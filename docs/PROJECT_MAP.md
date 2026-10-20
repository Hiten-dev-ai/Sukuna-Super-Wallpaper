# Sukuna Super Wallpaper project map

Checkout: `fix/aod-unlock-timing` (based on `origin/main`); source, media, tests and docs changed together.

Android live wallpaper maintained as an Apktool/smali project. Project root is the repository root. Read [README](../README.md), then this map before edits. No on-disk AGENTS.md was found; session instructions apply.

## Coverage

2026-10-21 baseline: all tracked paths enumerated in [inventory](project-map/inventory.md). Playback, wake/unlock dispatch, GL texture fallback, manifest and build scripts inspected. Companion AOD activity entry points inspected; historical patch scripts, base GL helpers and theme internals are not fully audited. This is a partial implementation review with complete file inventory. Vendor annotations and generated resource bindings are classified separately. No nested source project was found.

## Behavior lookup

All runtime paths below are relative to `miside_decompiled/smali/com/androradar/walls6/`.

| Behavior | Owner and searchable symbol | Caller / consumer | Verification |
| --- | --- | --- | --- |
| AOD / lock wake | `LiveWallpaperService$WallpaperEngine.smali`: `handleScreenOn`, `syncLockedState`, `mPendingUnlock` | DeviceLockedReceiver broadcasts, AodActivity.dismissToLockscreen, visibility callback | Keyguard / physical device |
| Direct unlock to home | Engine `handleUnlocked` then `WallpaperRenderer.onUnlocked` | USER_PRESENT / pending visible unlock; `VideoPlayer.restartHome` resumes or restarts | Playback regression and physical biometric unlock |
| Lock cutoff and home start | `VideoPlayer.restartHome`, VideoHandler message 7 continuation, `VideoStream.smali` | Renderer screen events; MediaExtractor / MediaCodec | Media PTS/keyframes, build and decoder smoke |
| Video / fallback rendering | `VideoPlayer.update`, `bind`; `VideoShader.smali` | Renderer.onDrawFrame, SurfaceTexture frame callback | GL timestamp/fallback smoke |
| Surface recreation | `WallpaperRenderer.setupResources`, `releasePlayer`; engine `onSurfaceDestroyed` retains preserved-context state | GLSurfaceView lifecycle | Recreate while locked / unlocked |
| Standalone AOD | `AodActivity.smali` and nested listeners/view | Manifest activity / notification listener | Manual on-device AOD |
| APK packaging | [build.ps1](../build.ps1), [apktool.yml](../miside_decompiled/apktool.yml) | build.bat; Apktool and uber-apk-signer | Rebuild and verify APK signature |

## Runtime flow and contracts

Manifest service registration creates `LiveWallpaperService` and its `WallpaperEngine`. The engine creates `WallpaperRenderer`, keyguard/power services, and registers SCREEN_ON, SCREEN_OFF and USER_PRESENT. The renderer owns one VideoPlayer, shader and quad. VideoPlayer owns a SurfaceTexture and VideoHandler; VideoStream owns the extractor/codec. Playback must serialize codec access on VideoHandlerThread. Lock playback ends before the reveal; home continues a displayed lock clip; direct AOD unlock starts the full clip. Explicit unlock differs from an idempotent visibility refresh. Screen-off must not expose a decoded frame-zero preroll on the next unlock. Window surface destruction preserves the player when EGL is reused; final engine teardown releases the decoder.

Packaged media lives in `miside_decompiled/assets/`; `unlocked.mp4` is the runtime animation, `backup.jpg` is the lock startup fallback, `home.jpg` covers the direct home seek, and `sukuna_aod.png` is companion artwork. Picker images live in `res/drawable-xxhdpi-v4/`. Shaders are `res/raw/video_vs.glsl` and `video_fs.glsl`. Manifest package and smali class namespace differ for Gojo intentionally. No server, database or network playback service is configured.

## Maintenance and checks

Run `.\build.ps1` at repository root with Java, `%USERPROFILE%\apktool.jar` and `%USERPROFILE%\uber-apk-signer.jar`. Output: `prebuilt/SukunaSuperWallpaper.apk`. Build uses debug signing; compare the certificate before installing over an existing package. `scripts/` contains historical one-shot patchers and device reverse-engineering tools, not build inputs. Do not replay old anchor patchers over current runtime fixes.

Playback checks now live in `scripts/verify_media.py` and `scripts/test_playback.ps1` / `PlaybackSmoke.java`; [PLAYBACK.md](PLAYBACK.md) records exact frames, mode/message contracts and test evidence. `media-timing.json` and `scripts/prepare_media.py` own reviewed clip provenance and media rebuilds. Version 1.1.3 / 2098184 is declared in apktool.yml. Apktool assembly proves smali syntax/package structure; decoder smoke and physical AOD/fingerprint checks are separate. Install, wallpaper selection and publishing are separate actions.

## Affected-area review

2026-10-21: updated wake/visibility reconciliation, pending unlock, continuation versus restart, GL surface ownership, worker callback teardown, exact media timing and real-frame-callback regressions. The earlier preserved-context failure was reproduced before fixing it. Builds, media checks, repeated phone decoder cycles and installed hashes passed. See PLAYBACK.md for physical-review limits and current timing. Historical helpers/theme internals retain the coverage limits above.
