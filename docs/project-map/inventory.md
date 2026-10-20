# File inventory

Enumerated tracked files on 2026-10-21. Runtime playback implementations inspected; legacy scripts and companion theme internals remain partially inspected. Binary internals are covered only by media/build checks.

| Path | Owning area | Role / consumer |
| --- | --- | --- |
| `.gitignore` | Build | Build/cache exclusion rules |
| `README.md` | Documentation | User setup and build overview |
| `aod_theme/liquid_26.mrm` | AOD theme | Companion Xiaomi AOD theme input, manifest or package |
| `aod_theme/project_x.mrm` | AOD theme | Companion Xiaomi AOD theme input, manifest or package |
| `aod_theme/sukuna_aod.mrm` | AOD theme | Companion Xiaomi AOD theme input, manifest or package |
| `aod_theme/sukuna_aod_build/aod_description.xml` | AOD theme | Companion Xiaomi AOD theme input, manifest or package |
| `aod_theme/sukuna_aod_build/content/manifest.xml` | AOD theme | Companion Xiaomi AOD theme input, manifest or package |
| `aod_theme/sukuna_aod_build/content/sukuna_aod.png` | AOD theme | Companion Xiaomi AOD theme input, manifest or package |
| `aod_theme/sukuna_aod_build/maml_thumb.png` | AOD theme | Companion Xiaomi AOD theme input, manifest or package |
| `aod_theme/sukuna_mtz_build/aod` | AOD theme | Companion Xiaomi AOD theme input, manifest or package |
| `aod_theme/sukuna_mtz_build/description.xml` | AOD theme | Companion Xiaomi AOD theme input, manifest or package |
| `aod_theme/sukuna_mtz_build/preview/preview_aod_0.png` | AOD theme | Companion Xiaomi AOD theme input, manifest or package |
| `aod_theme/sukuna_mtz_build/preview/preview_aod_small_0.png` | AOD theme | Companion Xiaomi AOD theme input, manifest or package |
| `aod_theme/updated_theme_meta.json` | AOD theme | Companion Xiaomi AOD theme input, manifest or package |
| `assets/project_x_wallpaper.jpg` | Media reference | Historical source/reference artwork or video, outside packaged APK assets |
| `assets/sukuna_aod_1220x2712.png` | Media reference | Historical source/reference artwork or video, outside packaged APK assets |
| `assets/sukuna_aod_exact.png` | Media reference | Historical source/reference artwork or video, outside packaged APK assets |
| `assets/sukuna_frame0.jpg` | Media reference | Historical source/reference artwork or video, outside packaged APK assets |
| `assets/test_sukuna.mp4` | Media reference | Historical source/reference artwork or video, outside packaged APK assets |
| `assets/test_transition.mp4` | Media reference | Historical source/reference artwork or video, outside packaged APK assets |
| `build.bat` | Build | Windows build.ps1 launcher |
| `build.ps1` | Build | Apktool assembly and debug signing entry point |
| `miside_decompiled/AndroidManifest.xml` | Android configuration | Package, wallpaper/AOD components and Android permissions |
| `miside_decompiled/apktool.yml` | Build configuration | APK SDK/version values, framework and uncompressed mp4 assets |
| `miside_decompiled/assets/backup.jpg` | Media | Initial static fallback loaded by VideoShader |
| `miside_decompiled/assets/sukuna_aod.png` | AOD | AOD artwork consumed by AodActivity$AodView |
| `miside_decompiled/assets/unlocked.mp4` | Media | Packaged animation opened by WallpaperRenderer / VideoStream |
| `miside_decompiled/res/drawable-xxhdpi-v4/banner.jpg` | Android resources | Shader, resource identifiers, wallpaper metadata or picker artwork |
| `miside_decompiled/res/drawable-xxhdpi-v4/icon.png` | Android resources | Shader, resource identifiers, wallpaper metadata or picker artwork |
| `miside_decompiled/res/drawable-xxhdpi-v4/preview.jpg` | Android resources | Shader, resource identifiers, wallpaper metadata or picker artwork |
| `miside_decompiled/res/raw/video_fs.glsl` | Android resources | Shader, resource identifiers, wallpaper metadata or picker artwork |
| `miside_decompiled/res/raw/video_vs.glsl` | Android resources | Shader, resource identifiers, wallpaper metadata or picker artwork |
| `miside_decompiled/res/values/public.xml` | Android resources | Shader, resource identifiers, wallpaper metadata or picker artwork |
| `miside_decompiled/res/values/strings.xml` | Android resources | Shader, resource identifiers, wallpaper metadata or picker artwork |
| `miside_decompiled/res/xml/skin_info.xml` | Android resources | Shader, resource identifiers, wallpaper metadata or picker artwork |
| `miside_decompiled/res/xml/wallpaper.xml` | Android resources | Shader, resource identifiers, wallpaper metadata or picker artwork |
| `miside_decompiled/smali/com/androradar/walls6/AodActivity$1.smali` | Runtime playback / AOD | AOD ten-second timer Runnable |
| `miside_decompiled/smali/com/androradar/walls6/AodActivity$2.smali` | Runtime playback / AOD | AOD single/double tap GestureDetector listener |
| `miside_decompiled/smali/com/androradar/walls6/AodActivity$3.smali` | Runtime playback / AOD | AOD touch listener |
| `miside_decompiled/smali/com/androradar/walls6/AodActivity$AodView.smali` | Runtime playback / AOD | AOD clock and character drawing |
| `miside_decompiled/smali/com/androradar/walls6/AodActivity.smali` | Runtime playback / AOD | Standalone AOD activity, input, timer and dismissToLockscreen bridge |
| `miside_decompiled/smali/com/androradar/walls6/AodNotificationListener.smali` | Runtime playback / AOD | Android notification listener for AOD badges |
| `miside_decompiled/smali/com/androradar/walls6/IndexedQuad.smali` | Runtime playback / AOD | Fullscreen indexed GL quad geometry |
| `miside_decompiled/smali/com/androradar/walls6/LiveWallpaperService$1.smali` | Runtime playback / AOD | Nested type consumed by LiveWallpaperService |
| `miside_decompiled/smali/com/androradar/walls6/LiveWallpaperService$WallpaperEngine$DeviceLockedReceiver.smali` | Runtime playback / AOD | Broadcast receiver dispatch into engine wake and unlock methods |
| `miside_decompiled/smali/com/androradar/walls6/LiveWallpaperService$WallpaperEngine$WallpaperGLSurfaceView.smali` | Runtime playback / AOD | Wallpaper SurfaceHolder bridge and GL lifecycle |
| `miside_decompiled/smali/com/androradar/walls6/LiveWallpaperService$WallpaperEngine.smali` | Runtime playback / AOD | Keyguard, SCREEN_ON, SCREEN_OFF, USER_PRESENT and visibility dispatch |
| `miside_decompiled/smali/com/androradar/walls6/LiveWallpaperService.smali` | Runtime playback / AOD | Android WallpaperService registration and active engine reference |
| `miside_decompiled/smali/com/androradar/walls6/Renderable.smali` | Runtime playback / AOD | Shared render/bind contract for quad and shader |
| `miside_decompiled/smali/com/androradar/walls6/Shader$ShaderCompilationException.smali` | Runtime playback / AOD | Shader compile error type |
| `miside_decompiled/smali/com/androradar/walls6/Shader.smali` | Runtime playback / AOD | GL shader program compilation and binding |
| `miside_decompiled/smali/com/androradar/walls6/Utils$BitmapNotLoadedException.smali` | Runtime playback / AOD | Nested type consumed by Utils |
| `miside_decompiled/smali/com/androradar/walls6/Utils$InvalidHandleException.smali` | Runtime playback / AOD | Nested type consumed by Utils |
| `miside_decompiled/smali/com/androradar/walls6/Utils.smali` | Runtime playback / AOD | GL handles, shader text and bitmap asset loading |
| `miside_decompiled/smali/com/androradar/walls6/VideoPlayer$StreamCondition.smali` | Runtime playback / AOD | Nested type consumed by VideoPlayer |
| `miside_decompiled/smali/com/androradar/walls6/VideoPlayer$StreamState.smali` | Runtime playback / AOD | Nested type consumed by VideoPlayer |
| `miside_decompiled/smali/com/androradar/walls6/VideoPlayer$VideoHandler.smali` | Runtime playback / AOD | HandlerThread playback messages and segment scheduling |
| `miside_decompiled/smali/com/androradar/walls6/VideoPlayer.smali` | Runtime playback / AOD | Requested lock/home mode, GL SurfaceTexture and playback lifecycle |
| `miside_decompiled/smali/com/androradar/walls6/VideoShader.smali` | Runtime playback / AOD | External video texture and static fallback texture selection |
| `miside_decompiled/smali/com/androradar/walls6/VideoStream$IncorrectFileTypeException.smali` | Runtime playback / AOD | Nested type consumed by VideoStream |
| `miside_decompiled/smali/com/androradar/walls6/VideoStream$OnStreamResourcesLostListener.smali` | Runtime playback / AOD | Nested type consumed by VideoStream |
| `miside_decompiled/smali/com/androradar/walls6/VideoStream$VideoNotInitializedException.smali` | Runtime playback / AOD | Nested type consumed by VideoStream |
| `miside_decompiled/smali/com/androradar/walls6/VideoStream.smali` | Runtime playback / AOD | MediaExtractor/MediaCodec input, output, seeking, timing and lock hold |
| `miside_decompiled/smali/com/androradar/walls6/WallpaperRenderer.smali` | Runtime playback / AOD | GL setup, aspect rendering and onScreenOn/onUnlocked/onScreenOff player calls |
| `prebuilt/SukunaSuperWallpaper.apk` | Build outputs | Distributable signed APK or companion AOD theme |
| `prebuilt/sukuna_aod.mtz` | Build outputs | Distributable signed APK or companion AOD theme |
| `prebuilt/sukuna_aod_store.mtz` | Build outputs | Distributable signed APK or companion AOD theme |
| `scripts/WallpaperReceiver.java` | Maintenance scripts | Legacy one-shot patch or device analysis; not invoked by build.ps1. Inspect before running. |
| `scripts/apply_lock_fix.py` | Maintenance scripts | Legacy one-shot patch or device analysis; not invoked by build.ps1. Inspect before running. |
| `scripts/caller_opt.py` | Maintenance scripts | Legacy one-shot patch or device analysis; not invoked by build.ps1. Inspect before running. |
| `scripts/disasm_aodsettings.py` | Maintenance scripts | Legacy one-shot patch or device analysis; not invoked by build.ps1. Inspect before running. |
| `scripts/disasm_showstyle.py` | Maintenance scripts | Legacy one-shot patch or device analysis; not invoked by build.ps1. Inspect before running. |
| `scripts/disasm_utils.py` | Maintenance scripts | Legacy one-shot patch or device analysis; not invoked by build.ps1. Inspect before running. |
| `scripts/dump_clinit.py` | Maintenance scripts | Legacy one-shot patch or device analysis; not invoked by build.ps1. Inspect before running. |
| `scripts/dump_utils.py` | Maintenance scripts | Legacy one-shot patch or device analysis; not invoked by build.ps1. Inspect before running. |
| `scripts/enable_fs_aod.py` | Maintenance scripts | Legacy one-shot patch or device analysis; not invoked by build.ps1. Inspect before running. |
| `scripts/find_callers.py` | Maintenance scripts | Legacy one-shot patch or device analysis; not invoked by build.ps1. Inspect before running. |
| `scripts/find_fullaod_callers.py` | Maintenance scripts | Legacy one-shot patch or device analysis; not invoked by build.ps1. Inspect before running. |
| `scripts/find_methods.py` | Maintenance scripts | Legacy one-shot patch or device analysis; not invoked by build.ps1. Inspect before running. |
| `scripts/find_refs.py` | Maintenance scripts | Legacy one-shot patch or device analysis; not invoked by build.ps1. Inspect before running. |
| `scripts/find_sids.py` | Maintenance scripts | Legacy one-shot patch or device analysis; not invoked by build.ps1. Inspect before running. |
| `scripts/find_sput.py` | Maintenance scripts | Legacy one-shot patch or device analysis; not invoked by build.ps1. Inspect before running. |
| `scripts/inspect_aod.py` | Maintenance scripts | Legacy one-shot patch or device analysis; not invoked by build.ps1. Inspect before running. |
| `scripts/inspect_aod_strings.py` | Maintenance scripts | Legacy one-shot patch or device analysis; not invoked by build.ps1. Inspect before running. |
| `scripts/inspect_settings_keys.py` | Maintenance scripts | Legacy one-shot patch or device analysis; not invoked by build.ps1. Inspect before running. |
| `scripts/patch_direct_unlock.py` | Maintenance scripts | Legacy one-shot patch or device analysis; not invoked by build.ps1. Inspect before running. |
| `scripts/patch_smooth_transition.py` | Maintenance scripts | Legacy one-shot patch or device analysis; not invoked by build.ps1. Inspect before running. |
| `scripts/patch_videostream.py` | Maintenance scripts | Legacy one-shot patch or device analysis; not invoked by build.ps1. Inspect before running. |
| `scripts/set_aod_settings.py` | Maintenance scripts | Legacy one-shot patch or device analysis; not invoked by build.ps1. Inspect before running. |
| `scripts/trace_settings.py` | Maintenance scripts | Legacy one-shot patch or device analysis; not invoked by build.ps1. Inspect before running. |
| `scripts/update_anchor_105.py` | Maintenance scripts | Legacy one-shot patch or device analysis; not invoked by build.ps1. Inspect before running. |
| `scripts/update_anchor_300.py` | Maintenance scripts | Legacy one-shot patch or device analysis; not invoked by build.ps1. Inspect before running. |

## Classified families

| Membership | Classification | Purpose |
| --- | --- | --- |
| `miside_decompiled/smali/android/support/annotation/*.smali` | Vendored annotations | Android support types; unmodified |
| `miside_decompiled/smali/com/androradar/walls6/R*.smali`, `BuildConfig.smali` | Generated resource/build bindings | Consumed by Android runtime classes |
| `miside_decompiled/build/**`, `build/**`, `__pycache__/**` | Ignored generated output | Apktool/Python output; no first-party source found |
| `miside_decompiled/original/**` | Original APK metadata/signatures | Apktool reference input |
| `assets/mahoraga_frames/frame_001.jpg` through `frame_040.jpg` | 40 historical binary frames | Reference assets outside APK |
| `tools/android.jar`, `tools/r8.jar` | Ignored external dependencies | Android compile stubs and D8/R8 tool |

Map files: `docs/PROJECT_MAP.md` is the navigation entry; `docs/project-map/inventory.md` is this inventory.

## Added playback-maintenance files

| Path | Owning area | Role / consumer |
| --- | --- | --- |
| `media-timing.json` | Media contract | Reviewed source filename/hash, source frames and runtime PTS |
| `scripts/prepare_media.py` | Media build | Rebuilds video, home keyframe, fallback images and picker images |
| `scripts/verify_media.py` | Media regression | Verifies stream metadata, frame PTS, runtime constants and APK media bytes |
| `scripts/PlaybackSmoke.java` | Runtime regression | Exercises actual packaged smali and MediaCodec in offscreen EGL |
| `scripts/test_playback.ps1` | Runtime regression | Compiles/runs smoke harness via adb and cleans task-owned files |
| `miside_decompiled/assets/home.jpg` | Rendering | Home-start fallback loaded by VideoShader.useHomeBackup |
| `docs/PLAYBACK.md` | Documentation | Frame/mode/message contracts, checks and evidence limits |
| `docs/transition-boundary.jpg` | Documentation asset | Exact last-lock and first-home frames for user review |
