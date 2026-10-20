import android.content.Context;
import android.content.ContextWrapper;
import android.content.res.AssetManager;
import android.content.res.Resources;
import android.graphics.SurfaceTexture;
import android.opengl.EGL14;
import android.opengl.EGLConfig;
import android.opengl.EGLContext;
import android.opengl.EGLDisplay;
import android.opengl.EGLSurface;
import android.opengl.GLES30;
import android.opengl.GLSurfaceView;
import android.os.Looper;
import android.os.Handler;
import android.os.HandlerThread;
import java.lang.reflect.Constructor;
import java.lang.reflect.Field;
import java.lang.reflect.Method;

/** Runs actual APK smali and MediaCodec in an offscreen EGL surface; does not apply a wallpaper. */
public class PlaybackSmoke {
    private static final String NS = "com.androradar.walls6.";
    private static Object player;
    private static long homeUs;
    private static long holdUs;
    private static HandlerThread frameCallbacks;
    private static SurfaceTexture observedSurface;

    private static Object call(Object object, String name, Class<?>[] types, Object... args) throws Exception {
        Method method = object.getClass().getDeclaredMethod(name, types);
        method.setAccessible(true);
        return method.invoke(object, args);
    }

    private static Object field(Object object, String name) throws Exception {
        Field field = object.getClass().getDeclaredField(name);
        field.setAccessible(true);
        return field.get(object);
    }

    private static void setField(Object object, String name, Object value) throws Exception {
        Field field = object.getClass().getDeclaredField(name);
        field.setAccessible(true);
        field.set(object, value);
    }

    private static void invoke(String name) throws Exception {
        call(player, name, new Class<?>[0]);
    }

    private static void check(boolean ok, String message) {
        if (!ok) throw new AssertionError(message);
    }

    private static int texture() {
        int[] handles = new int[1];
        GLES30.glGenTextures(1, handles, 0);
        return handles[0];
    }

    private static long sample() throws Exception {
        SurfaceTexture surface = (SurfaceTexture) field(player, "mSurfaceTexture");
        if (surface != observedSurface) {
            surface.setOnFrameAvailableListener((SurfaceTexture.OnFrameAvailableListener) player,
                    new Handler(frameCallbacks.getLooper()));
            observedSurface = surface;
        }
        // Real SurfaceTexture callbacks mark new frames; polling only consumes them on the GL thread.
        invoke("update");
        surface = (SurfaceTexture) field(player, "mSurfaceTexture");
        long pts = surface.getTimestamp() / 1000;
        if ((int) field(player, "mPlaybackMode") == 2 && (boolean) field(player, "mFrameReady")) {
            check(pts >= homeUs, "Home exposed intro frame at " + pts);
        }
        if ((int) field(player, "mPlaybackMode") == 1 && (boolean) field(player, "mFrameReady")) {
            check(pts <= holdUs, "Lock exposed a retained home frame at " + pts);
        }
        Thread.sleep(10);
        return pts;
    }

    private static long waitHome() throws Exception {
        long deadline = System.nanoTime() + 4_000_000_000L;
        while (System.nanoTime() < deadline) {
            long pts = sample();
            if ((boolean) field(player, "mFrameReady")) return pts;
        }
        throw new AssertionError("Home decoder did not produce a frame");
    }

    private static void sleepPlayer() throws Exception {
        invoke("stop");
        invoke("prepare");
        Thread.sleep(100);
        check((int) field(player, "mPlaybackMode") == 0, "Screen-off did not reset mode");
    }

    public static void main(String[] args) {
        try {
            homeUs = Long.parseLong(args[1]);
            holdUs = Long.parseLong(args[2]);
            if (Looper.myLooper() == null) Looper.prepareMainLooper();
            frameCallbacks = new HandlerThread("PlaybackSmokeFrames");
            frameCallbacks.start();
            Class<?> threadClass = Class.forName("android.app.ActivityThread");
            Object thread = threadClass.getMethod("systemMain").invoke(null);
            Context system = (Context) threadClass.getMethod("getSystemContext").invoke(thread);
            Constructor<AssetManager> assetConstructor = AssetManager.class.getDeclaredConstructor();
            assetConstructor.setAccessible(true);
            AssetManager assets = assetConstructor.newInstance();
            Method add = AssetManager.class.getDeclaredMethod("addAssetPath", String.class);
            check((int) add.invoke(assets, args[0]) != 0, "Cannot open APK assets");
            Resources resources = new Resources(assets, system.getResources().getDisplayMetrics(), system.getResources().getConfiguration());
            Context context = new ContextWrapper(system) {
                @Override public AssetManager getAssets() { return assets; }
                @Override public Resources getResources() { return resources; }
            };
            EGLDisplay display = EGL14.eglGetDisplay(EGL14.EGL_DEFAULT_DISPLAY);
            int[] version = new int[2];
            check(EGL14.eglInitialize(display, version, 0, version, 1), "EGL init");
            EGLConfig[] configs = new EGLConfig[1];
            int[] count = new int[1];
            EGL14.eglChooseConfig(display, new int[]{EGL14.EGL_RENDERABLE_TYPE, 0x40, EGL14.EGL_SURFACE_TYPE, EGL14.EGL_PBUFFER_BIT, EGL14.EGL_NONE}, 0, configs, 0, 1, count, 0);
            check(count[0] > 0, "No ES3 pbuffer config");
            EGLContext eglContext = EGL14.eglCreateContext(display, configs[0], EGL14.EGL_NO_CONTEXT, new int[]{EGL14.EGL_CONTEXT_CLIENT_VERSION, 3, EGL14.EGL_NONE}, 0);
            EGLSurface eglSurface = EGL14.eglCreatePbufferSurface(display, configs[0], new int[]{EGL14.EGL_WIDTH, 16, EGL14.EGL_HEIGHT, 16, EGL14.EGL_NONE}, 0);
            check(EGL14.eglMakeCurrent(display, eglSurface, eglSurface, eglContext), "EGL current");
            GLSurfaceView view = new GLSurfaceView(context);
            view.setRenderer(new GLSurfaceView.Renderer() {
                public void onSurfaceCreated(javax.microedition.khronos.opengles.GL10 gl, javax.microedition.khronos.egl.EGLConfig config) {}
                public void onSurfaceChanged(javax.microedition.khronos.opengles.GL10 gl, int w, int h) {}
                public void onDrawFrame(javax.microedition.khronos.opengles.GL10 gl) {}
            });
            Class<?> shaderClass = Class.forName(NS + "VideoShader");
            Class<?> quadClass = Class.forName(NS + "IndexedQuad");
            Object shader = shaderClass.getConstructor(Context.class).newInstance(context);
            Object quad = quadClass.getConstructor().newInstance();
            Class<?> playerClass = Class.forName(NS + "VideoPlayer");
            Constructor<?> constructor = playerClass.getDeclaredConstructor(AssetManager.class, String.class, GLSurfaceView.class, shaderClass, quadClass);
            constructor.setAccessible(true);
            player = constructor.newInstance(assets, "unlocked.mp4", view, shader, quad);

            // Actual GL fallback must be the home asset while an earlier texture is gated.
            call(quad, "init", new Class<?>[0]);
            call(shader, "init", new Class<?>[]{quadClass}, quad);
            float[] matrix = new float[16];
            android.opengl.Matrix.setIdentityM(matrix, 0);
            invoke("playToHome");
            call(player, "bind", new Class<?>[]{float[].class}, matrix);
            check((boolean) field(shader, "mUseHomeBackup"), "Home cover was not selected");
            check((boolean) field(shader, "mUseBackup"), "Unready texture was exposed before home decode");
            System.out.println("PASS home fallback asset selection");

            // Cold unlocked creation must retain the requested home segment until init.
            call(player, "init", new Class<?>[]{int.class}, texture());
            long first = waitHome();
            check(first <= homeUs + 100000, "Cold home seek skipped boundary: " + first);
            System.out.println("PASS cold direct unlock: first visible PTS " + first);

            // A duplicate or late wake must not restart home or downgrade it to the intro.
            long until = System.nanoTime() + 400_000_000L;
            long before = first;
            while (System.nanoTime() < until) before = sample();
            invoke("playToHome");
            invoke("playToLock");
            check((int) field(player, "mPlaybackMode") == 2, "Late wake overrode unlock");
            long after = sample();
            check(after >= before, "Duplicate wake/unlock rewound home");
            System.out.println("PASS duplicate unlock and late wake");

            // Off/standby must not render frame zero. Normal wake plays only the lock range.
            sleepPlayer();
            long retained = sample();
            check(retained >= homeUs, "Screen-off preroll replaced home with frame zero");
            invoke("playToLock");
            long deadline = System.nanoTime() + 6_000_000_000L;
            Object stream = field(player, "mVideoStream");
            while (System.nanoTime() < deadline) {
                sample();
                stream = field(player, "mVideoStream");
                if ((boolean) call(stream, "isTargetReached", new Class<?>[0])) break;
            }
            check((boolean) call(stream, "isTargetReached", new Class<?>[0]), "Lock did not pause");
            long held = sample();
            check(held == holdUs, "Wrong lock hold: " + held + " expected " + holdUs);
            Thread.sleep(150);
            check(sample() == held, "Lock advanced into reveal");
            System.out.println("PASS exact lock hold: PTS " + held);

            SurfaceTexture lockedTexture = (SurfaceTexture) field(player, "mSurfaceTexture");
            invoke("restartHome");
            check(field(player, "mSurfaceTexture") == lockedTexture, "Lock-to-home replaced the texture instead of continuing");
            long continueDeadline = System.nanoTime() + 2_000_000_000L;
            long continuedFrame = 0;
            while (continuedFrame <= holdUs && System.nanoTime() < continueDeadline) continuedFrame = sample();
            check(continuedFrame > holdUs, "Held lock did not continue into home");
            System.out.println("PASS held lock continues into home without seek or replay");
            sleepPlayer();
            invoke("playToLock");
            Thread.sleep(150);
            sample();
            invoke("playToHome");
            long early = waitHome();
            check(early <= homeUs + 100000, "Interrupted intro did not seek to home: " + early);
            System.out.println("PASS unlock during intro: first visible PTS " + early);

            // Recreated GL resources must resume home at its displayed position.
            until = System.nanoTime() + 400_000_000L;
            while (System.nanoTime() < until) sample();
            long beforeRecreate = (long) field(player, "mResumePositionUs");
            call(shader, "clean", new Class<?>[0]);
            call(shader, "init", new Class<?>[]{quadClass}, quad);
            call(player, "init", new Class<?>[]{int.class}, texture());
            call(player, "bind", new Class<?>[]{float[].class}, matrix);
            check((boolean) field(shader, "mUseBackup"), "Recreated unready texture was exposed");
            check((int) field(shader, "mBackupTextureHandle") >= 0, "Recreated home fallback was not loaded");
            check(waitHome() >= beforeRecreate, "GL recreation rewound home");
            System.out.println("PASS surface recreation retains home");

            // Android may replace only the window surface while preserving the EGL context.
            Class<?> serviceClass = Class.forName(NS + "LiveWallpaperService");
            Object service = serviceClass.getConstructor().newInstance();
            Class<?> engineClass = Class.forName(NS + "LiveWallpaperService$WallpaperEngine");
            Constructor<?> engineConstructor = engineClass.getDeclaredConstructor(serviceClass);
            engineConstructor.setAccessible(true);
            Object engine = engineConstructor.newInstance(service);
            Class<?> rendererClass = Class.forName(NS + "WallpaperRenderer");
            Object renderer = rendererClass.getConstructor(Context.class, GLSurfaceView.class).newInstance(context, view);
            setField(renderer, "mUnlockVideo", player);
            setField(engine, "mRenderer", renderer);
            setField(engine, "mPowerManager", system.getSystemService(Context.POWER_SERVICE));
            setField(engine, "mKeyGuardManager", system.getSystemService(Context.KEYGUARD_SERVICE));
            sleepPlayer();
            call(engine, "handleScreenOn", new Class<?>[0]);
            call(engine, "handleUnlocked", new Class<?>[0]);
            check((int) field(player, "mPlaybackMode") == 0, "Invisible engine consumed wake/unlock animation");
            System.out.println("PASS invisible wake/unlock waits for visibility");
            invoke("playToHome");
            waitHome();
            call(engine, "onSurfaceDestroyed", new Class<?>[]{android.view.SurfaceHolder.class}, new Object[]{null});
            check(field(player, "mSurfaceTexture") != null, "Window surface destruction cleared preserved-context player");
            check(field(player, "mHandler") != null, "Window surface destruction disposed preserved-context decoder");
            sleepPlayer();
            invoke("playToHome");
            check(waitHome() >= homeUs, "Window surface return failed to resume home");
            System.out.println("PASS window surface replacement with preserved EGL context");

            // Opening an app is a visibility pause, not a new screen-off/unlock session.
            Class<?> wallpaperViewClass = Class.forName(NS + "LiveWallpaperService$WallpaperEngine$WallpaperGLSurfaceView");
            Constructor<?> wallpaperViewConstructor = wallpaperViewClass.getDeclaredConstructor(engineClass, Context.class);
            wallpaperViewConstructor.setAccessible(true);
            GLSurfaceView wallpaperView = (GLSurfaceView) wallpaperViewConstructor.newInstance(engine, context);
            wallpaperView.setRenderer(new GLSurfaceView.Renderer() {
                public void onSurfaceCreated(javax.microedition.khronos.opengles.GL10 gl, javax.microedition.khronos.egl.EGLConfig config) {}
                public void onSurfaceChanged(javax.microedition.khronos.opengles.GL10 gl, int w, int h) {}
                public void onDrawFrame(javax.microedition.khronos.opengles.GL10 gl) {}
            });
            setField(engine, "mGlView", wallpaperView);
            setField(engine, "mKeyGuardManager", null); // Fixture represents an unlocked app return.
            setField(engine, "mLocked", false);
            setField(engine, "mPendingUnlock", false);
            until = System.nanoTime() + 400_000_000L;
            while (System.nanoTime() < until) sample();
            long beforeApp = sample();
            call(engine, "onVisibilityChanged", new Class<?>[]{boolean.class}, false);
            check((int) field(player, "mPlaybackMode") == 2, "Opening an app cleared the home session");
            Thread.sleep(150);
            long paused = sample();
            Thread.sleep(150);
            check(sample() == paused, "Hidden wallpaper kept decoding");
            call(engine, "onVisibilityChanged", new Class<?>[]{boolean.class}, true);
            check(sample() >= beforeApp, "Closing an app replayed the home opening");
            until = System.nanoTime() + 500_000_000L;
            long resumed = paused;
            while (System.nanoTime() < until) resumed = sample();
            check(resumed > paused, "Closing an app did not resume paused playback");
            System.out.println("PASS app return preserves the current home session");

            // Use the last three frames to reach genuine decoder completion quickly.
            setField(player, "mResumePositionUs", 9_875_000L);
            call(player, "init", new Class<?>[]{int.class}, texture());
            check(waitHome() >= 9_875_000L, "Restored home ignored saved position");
            until = System.nanoTime() + 2_000_000_000L;
            while ((boolean) field(player, "mIsPlaying") && System.nanoTime() < until) sample();
            check(!(boolean) field(player, "mIsPlaying"), "Home did not complete");
            Thread.sleep(100);
            long completed = sample();
            check(completed == 9_958_333L, "Completion did not hold the final video frame: " + completed);
            for (int appReturn = 0; appReturn < 3; appReturn++) {
                call(engine, "onVisibilityChanged", new Class<?>[]{boolean.class}, false);
                Thread.sleep(100);
                call(engine, "onVisibilityChanged", new Class<?>[]{boolean.class}, true);
                Thread.sleep(100);
                check(sample() == completed, "Completed home replayed on app return");
                check(!(boolean) field(player, "mIsPlaying"), "App return restarted completed playback");
            }
            System.out.println("PASS three app returns retain the completed final frame");

            call(shader, "clean", new Class<?>[0]);
            call(shader, "init", new Class<?>[]{quadClass}, quad);
            call(player, "init", new Class<?>[]{int.class}, texture());
            call(player, "bind", new Class<?>[]{float[].class}, matrix);
            check((boolean) field(shader, "mUseRestBackup"), "Completed context recreation did not select the final-frame asset");
            check((boolean) field(shader, "mUseBackup"), "Completed context recreation exposed an empty texture");
            Thread.sleep(150);
            sample();
            check(!(boolean) field(player, "mIsPlaying"), "Context recreation restarted completed home");
            check(!(boolean) field(player, "mFrameReady"), "Completed context recreation started decoding again");
            System.out.println("PASS completed context recreation keeps final-frame fallback without replay");

            for (int cycle = 0; cycle < 4; cycle++) {
                sleepPlayer();
                invoke("playToLock");
                long cycleDeadline = System.nanoTime() + 2_000_000_000L;
                long lockFrame = Long.MAX_VALUE;
                while (System.nanoTime() < cycleDeadline) {
                    lockFrame = sample();
                    if ((boolean) field(player, "mFrameReady") && lockFrame <= 250000) break;
                }
                check(lockFrame <= 250000, "Repeated wake did not start lock video");
                call(renderer, "onUnlocked", new Class<?>[0]);
                check(waitHome() >= lockFrame, "Lock-to-home replayed an earlier frame");
                long homeFrame = 0;
                cycleDeadline = System.nanoTime() + 2_000_000_000L;
                while (homeFrame < lockFrame + 125000 && System.nanoTime() < cycleDeadline) homeFrame = sample();
                check(homeFrame >= lockFrame + 125000, "Repeated unlock video did not advance");
            }
            System.out.println("PASS four repeated wake/unlock cycles using real frame callbacks");

            // USER_PRESENT must restart even when the previous off/hide event was missed.
            call(renderer, "onUnlocked", new Class<?>[0]);
            check(!(boolean) field(player, "mFrameReady"), "Unlock was ignored because home mode was already latched");
            invoke("onPlayingComplete"); // A prior decoder can finish while a fresh unlock is pending.
            check(waitHome() <= 100000, "New unlock did not restart the full video");
            check((boolean) field(player, "mIsPlaying"), "Prior decoder completion cancelled a fresh unlock");
            System.out.println("PASS explicit unlock restarts full video without a preceding screen-off event");

            // Completion cannot wait on the monitor that reset holds while joining its worker.
            synchronized (player) {
                Thread callback = new Thread(() -> {
                    try { invoke("onPlayingComplete"); }
                    catch (Exception error) { throw new RuntimeException(error); }
                });
                callback.start();
                callback.join(500);
                check(!callback.isAlive(), "Decoder completion blocks teardown's player monitor");
            }
            System.out.println("PASS decoder completion does not deadlock teardown");
            sleepPlayer();
            invoke("reset");
            frameCallbacks.quitSafely();
            System.out.println("ALL PLAYBACK CHECKS PASSED");
            System.exit(0);
        } catch (Throwable error) {
            error.printStackTrace();
            System.exit(1);
        }
    }
}
