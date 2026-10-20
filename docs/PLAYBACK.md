# Playback behavior and verification

## Reviewed clip and boundary

The provided clip is identified by filename and SHA-256 in [`media-timing.json`](../media-timing.json). Frames are zero-based at the source's native 24 fps. The packaged video uses 1220x2712 height scaling and center crop, preserving aspect ratio. It contains no audio and no generated interpolation frames.

| State | Source frame | Packaged timestamp |
| --- | --- | --- |
| Last lock frame / hold | 54 | 2250000 us |
| First home frame / forced IDR | 55 | 2291667 us |

Lock stops after the hand sign, while the face is still dark; the red reveal remains in the home segment.

![Last lock frame beside first home frame](transition-boundary.jpg)

## Runtime owners and state

`LiveWallpaperService$WallpaperEngine` routes SCREEN_ON, USER_PRESENT and visibility using KeyguardManager. Non-interactive power state alone is not an indication that keyguard is locked. Visibility synchronizes before the GL surface resumes.

`VideoPlayer.mPlaybackMode` is 0 (standby), 1 (lock) or 2 (home). Segment requests are idempotent. A delayed lock/wake cannot downgrade mode 2 until screen-off resets the mode. The requested segment survives GL and codec resource recreation; initialization does not unconditionally rewind or decode frame zero.

`VideoPlayer$VideoHandler` messages 5 (home) and 6 (lock) serialize seek, pause-boundary configuration and playback on VideoHandlerThread. Home always seeks to its boundary, even when the lock intro is PLAYING. Segment requests and stop cancel stale queued advance/rewind messages.

`VideoStream.seekTo` flushes and selects the previous sync sample. `advance` discards decoded samples before `mRenderFromUs`, so seek preroll cannot reach SurfaceTexture. Rendered output carries its media timestamp in nanoseconds. Lock pauses when its exact hold timestamp is rendered.

`VideoPlayer.update` accepts a home texture only once its timestamp reaches the home boundary, and rejects retained home frames when switching back to lock. Callbacks from released SurfaceTextures are ignored. Until then, `VideoShader` uses `assets/home.jpg`, not the frame-zero `backup.jpg`. The fallback texture is reloaded after GL resource cleanup. See Android's [seek modes](https://developer.android.com/reference/android/media/MediaExtractor#seekTo(long,int)) and [surface timestamps](https://developer.android.com/reference/android/media/MediaCodec#releaseOutputBuffer(int,long)).

## Reproducible checks

From repository root:

```powershell
python scripts/prepare_media.py '<original supplied clip path>'
.\build.ps1
python scripts/verify_media.py
.\scripts\test_playback.ps1 -AndroidJar '<Android SDK android.jar>' -D8Jar '<r8.jar>' -Device '<adb serial>'
```

`prepare_media.py` rejects clips with a different SHA-256. `verify_media.py` checks native cadence, frame timestamps, home IDR, runtime constants, image dimensions and exact packaged media bytes. `test_playback.ps1` compiles `PlaybackSmoke.java`, executes the packaged smali with the phone's hardware decoder in an offscreen EGL surface, then removes its local/device test files. It does not install an app or select a wallpaper. Java, javac, adb and D8 are required.

## Verification record: 2026-10-21

- Apktool assembly and v1/v2/v3 signing/zip alignment passed.
- Media checks passed: 240 frames, 24 fps, exact hold timestamp and forced home keyframe; APK media bytes match source-tree assets.
- A shared-player regression on Gojo first reproduced a retained-home-frame leak into lock (PTS 3.875s); the lock timestamp gate fixed it.
- Offscreen hardware checks passed on the connected 2412DPC0AI: home fallback before decode, cold direct unlock, duplicate unlock, delayed wake, exact lock hold without advancing into the reveal, unlock during intro, and surface recreation in home mode.
- Both APKs were upgraded in place to 1.1.0 / versionCode 2098181. Installed SHA-256 values match the local signed APKs. Existing selected Gojo wallpaper was retained.
- Physical fingerprint timing and the complete AOD/keyguard/launcher composition remain for user review. Offscreen codec tests do not prove OEM compositor behavior.

The changes leave the standalone AOD activity and companion theme artwork unchanged.

Installed/prebuilt APK SHA-256: `52c003185ff222872dc6fe701f76c4edc11a7ad0d6c0ccc571b57d9547837a7a`.
