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
import java.lang.reflect.Constructor;
import java.lang.reflect.Field;
import java.lang.reflect.Method;

/** Runs actual APK smali and MediaCodec in an offscreen EGL surface; does not apply a wallpaper. */
public class PlaybackSmoke {
    private static final String NS = "com.androradar.walls6.";
    private static Object player;
    private static long homeUs;
    private static long holdUs;

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
        // Poll the real GL texture without requiring the main Looper's callback delivery.
        call(player, "onFrameAvailable", new Class<?>[]{SurfaceTexture.class}, surface);
        invoke("update");
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
            while (!(boolean) call(stream, "isTargetReached", new Class<?>[0]) && System.nanoTime() < deadline) sample();
            check((boolean) call(stream, "isTargetReached", new Class<?>[0]), "Lock did not pause");
            long held = sample();
            check(held == holdUs, "Wrong lock hold: " + held + " expected " + holdUs);
            Thread.sleep(150);
            check(sample() == held, "Lock advanced into reveal");
            System.out.println("PASS exact lock hold: PTS " + held);

            invoke("playToHome");
            check(waitHome() >= homeUs, "Held lock did not enter home");
            sleepPlayer();
            invoke("playToLock");
            Thread.sleep(150);
            sample();
            invoke("playToHome");
            long early = waitHome();
            check(early <= homeUs + 100000, "Interrupted intro did not seek to home: " + early);
            System.out.println("PASS unlock during intro: first visible PTS " + early);

            // Recreated GL resources must resume home without initial rewind/preroll.
            call(shader, "clean", new Class<?>[0]);
            call(shader, "init", new Class<?>[]{quadClass}, quad);
            call(player, "init", new Class<?>[]{int.class}, texture());
            call(player, "bind", new Class<?>[]{float[].class}, matrix);
            check((boolean) field(shader, "mUseBackup"), "Recreated unready texture was exposed");
            check((int) field(shader, "mBackupTextureHandle") >= 0, "Recreated home fallback was not loaded");
            check(waitHome() >= homeUs, "GL recreation played intro");
            System.out.println("PASS surface recreation retains home");
            sleepPlayer();
            invoke("reset");
            System.out.println("ALL PLAYBACK CHECKS PASSED");
            System.exit(0);
        } catch (Throwable error) {
            error.printStackTrace();
            System.exit(1);
        }
    }
}
