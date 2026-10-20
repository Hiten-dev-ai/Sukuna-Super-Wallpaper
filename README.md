# ⛩️ Sukuna Super Wallpaper (HyperOS / MIUI & Android)

[![Platform](https://img.shields.io/badge/Platform-Android%20%7C%20Xiaomi%20HyperOS%20%7C%20MIUI-orange.svg)](https://android.com)
[![Engine](https://img.shields.io/badge/Engine-OpenGL%20ES%202.0%20LiveWallpaper-red.svg)]()
[![Resolution](https://img.shields.io/badge/Resolution-1220x2712%2024fps-blue.svg)]()
[![License](https://img.shields.io/badge/License-MIT%20%2F%20Non--Commercial-green.svg)]()

A high-performance **Ryomen Sukuna Domain Expansion ("Malevolent Shrine" / 伏魔御厨子)** Super Wallpaper for Android devices, natively optimized for **Xiaomi HyperOS** and **MIUI**.

Lockscreen plays the opening segment and holds at **2.250000s**. Unlock jumps directly to the home segment at **2.291667s**, including direct AOD unlock and unlock during the intro.

---

## 🌟 Features

- **Reveal boundary**: Lock holds on source frame 54 (2.250s), with the hand sign complete and face still dark. Home starts on frame 55 (2.291667s), just as the red reveal begins.
- **Separate lock and home segments**: Frame zero is used only for lock startup. Screen-off does not decode a frame-zero preroll; a matching `home.jpg` covers the home seek until a home frame is available.
- **Native HyperOS / MIUI Intent Hooks**: Registered with `miui.service.wallpaper.SuperWallpaperService` and `is_super_wallpaper=true` for seamless integration into Xiaomi's wallpaper pipeline.
- **Companion Always-On Display (AOD)**: Includes matching MTZ theme packages (`sukuna_aod.mtz`) for Xiaomi AOD engines.
- **Universal Android Compatibility**: Also works on Samsung One UI, Google Pixel, OnePlus OxygenOS, and stock Android via the Google Wallpapers app.

---

## 📁 Repository Structure

```
SukunaSuperWallpaper/
├── prebuilt/
│   ├── SukunaSuperWallpaper.apk   # Ready-to-install signed APK (14.34 MB)
│   ├── sukuna_aod.mtz             # Custom Xiaomi AOD theme package
│   └── sukuna_aod_store.mtz       # Store-compatible Xiaomi AOD package
├── miside_decompiled/             # Full Apktool source tree
│   ├── AndroidManifest.xml        # Package definitions, permissions & SuperWallpaperService
│   ├── assets/
│   │   ├── backup.jpg             # Lock startup fallback image
│   │   ├── sukuna_aod.png         # AOD texture reference
│   │   └── unlocked.mp4           # 1220x2712 native 24fps supplied animation
│   ├── res/                       # App icons, strings & wallpaper metadata
│   └── smali/                     # Modified OpenGL ES wallpaper engine & shader logic
├── aod_theme/                     # AOD theme source files and MTZ descriptors
│   ├── sukuna_aod_build/          # Source folder for AOD manifest & preview
│   └── sukuna_mtz_build/          # Package layout for Theme Manager
├── assets/                        # Raw source artwork, frames and test videos
│   ├── sukuna_aod_1220x2712.png   # Full-resolution AOD graphic
│   ├── sukuna_frame0.jpg          # Standby reference frame
│   └── mahoraga_frames/           # Frame sequence
├── scripts/                       # HyperOS & MIUI reverse-engineering / analysis scripts
├── build.ps1                      # One-click PowerShell build & sign script
├── build.bat                      # One-click Batch build script
├── .gitignore
└── README.md
```

---

## 🚀 Quick Install

### 1. Install Live Wallpaper APK
Download `SukunaSuperWallpaper.apk` from the `prebuilt/` folder or install via ADB:
```bash
adb install -r prebuilt/SukunaSuperWallpaper.apk
```

### 2. Apply the Wallpaper
- **Xiaomi HyperOS / MIUI**:
  1. Open **Settings** > **Wallpaper** > **Super Wallpaper** (or Live Wallpapers).
  2. Select **Sukuna Super Wallpaper** (`com.androradar.walls6`).
  3. Apply to **Both Lock Screen and Home Screen**.
- **Other Android Devices**:
  1. Install [Google Wallpapers](https://play.google.com/store/apps/details?id=com.google.android.apps.wallpaper) from the Play Store.
  2. Open Wallpapers > **Live Wallpapers** > Select **Sukuna Super Wallpaper** > Apply.

### 3. (Optional) Apply Companion AOD
1. Copy `prebuilt/sukuna_aod.mtz` to your device storage (`/sdcard/Download/` or `/sdcard/MIUI/theme/`).
2. Open **Xiaomi Theme Manager** > Profile > Themes > **Import** > select `sukuna_aod.mtz`.
3. Apply Always-On Display.

---

## 🛠️ Building from Source

### Prerequisites
- **Java JDK 17+** (JDK 21 or 25 recommended)
- **Apktool** (v2.10.0+)
- **uber-apk-signer** (or Android SDK `apksigner` / `zipalign`)

### One-Click Build
Run the provided PowerShell build script:
```powershell
.\build.ps1
```
Or on Windows CMD:
```cmd
build.bat
```

The script will automatically compile `miside_decompiled/` with Apktool, zipalign the package, and sign it with a debug keystore to `prebuilt/SukunaSuperWallpaper.apk`.

---

## 🧠 Technical Architecture & HyperOS Deep Dive

### Unlock Transition Pipeline
1. **Screen Off / Standby**: Cancel pending playback and retain the requested standby mode without decoding frame zero.
2. **Screen Wake / Lockscreen**: Play the opening segment and pause exactly at 2.250s while the hand sign is complete and the face remains dark.
3. **Screen Unlock**: Seek directly to the home IDR at 2.291667s, even when unlock interrupts the opening segment. Duplicate wake/unlock events do not rewind playback.
4. **Homescreen Rest**: Finish the animation and hold the final frame. GL surface recreation retains the selected segment.

### HyperOS In-Call UI Behavior Note
In Xiaomi HyperOS, the dialer application (`com.android.incallui` / `XiaomiInCallUI`) queries `MiuiWallpaperManagerService` for a static preview bitmap when rendering the call background. When any live/super wallpaper is applied across both home and lock screens, HyperOS clears the static lockscreen wallpaper cache (`Lock wallpaper state: null`). Because live wallpaper engines do not provide a static surface to external applications, `XiaomiInCallUI` falls back to the system ROM's default gradient (stock pink/blue HyperOS theme). This is an operating system limitation that affects all official Xiaomi Super Wallpapers (Earth, Mars, Snow Mountain) as well.

---

## 📜 Disclaimer

This project is a fan-made, non-commercial customization for Android.
- *Jujutsu Kaisen* and Ryomen Sukuna are trademarks and copyright of Gege Akutami / Shueisha / MAPPA.
- Base engine derived from open Android live wallpaper research.


## Playback fix and verification (v1.1.0)

See [playback behavior, exact frames and checks](docs/PLAYBACK.md), the [boundary image](docs/transition-boundary.jpg), and [project navigation map](docs/PROJECT_MAP.md).

`media-timing.json` records the reviewed source clip/hash, lock hold and first home frame. `scripts/prepare_media.py <source.mp4>` rebuilds media with a home IDR and matching fallback image. Historical anchor patchers are not part of the build and can overwrite these fixes if replayed.
