# ⛩️ Sukuna Super Wallpaper (HyperOS / MIUI & Android)

[![Platform](https://img.shields.io/badge/Platform-Android%20%7C%20Xiaomi%20HyperOS%20%7C%20MIUI-orange.svg)](https://android.com)
[![Engine](https://img.shields.io/badge/Engine-OpenGL%20ES%202.0%20LiveWallpaper-red.svg)]()
[![Resolution](https://img.shields.io/badge/Resolution-1220x2712%2060fps-blue.svg)]()
[![License](https://img.shields.io/badge/License-MIT%20%2F%20Non--Commercial-green.svg)]()

A high-performance **Ryomen Sukuna Domain Expansion ("Malevolent Shrine" / 伏魔御厨子)** Super Wallpaper for Android devices, natively optimized for **Xiaomi HyperOS** and **MIUI**.

Features an AMOLED pure-black standby frame on lockscreen standby, transitioning seamlessly into an unwatermarked, high-bitrate 1220×2712 60 FPS Domain Expansion animation the moment the device is unlocked.

---

## 🌟 Features

- **Domain Expansion: Malevolent Shrine**: High-fidelity cinematic animation cut from Jujutsu Kaisen Season 1 Episode 4, remastered to 1220×2712 vertical AMOLED format with no watermarks.
- **AMOLED Frame 0 Standby**: Lockscreen keyguard renders a static pure-black Frame 0 (`backup.jpg`) during standby to eliminate battery drain and prevent keyguard desync.
- **Native HyperOS / MIUI Intent Hooks**: Registered with `miui.service.wallpaper.SuperWallpaperService` and `is_super_wallpaper=true` for seamless integration into Xiaomi's wallpaper pipeline.
- **Companion Always-On Display (AOD)**: Includes matching MTZ theme packages (`sukuna_aod.mtz`) for Xiaomi AOD engines.
- **Universal Android Compatibility**: Also works on Samsung One UI, Google Pixel, OnePlus OxygenOS, and stock Android via the Google Wallpapers app.

---

## 📁 Repository Structure

```
SukunaSuperWallpaper/
├── prebuilt/
│   ├── SukunaSuperWallpaper.apk   # Ready-to-install signed APK (10.09 MB)
│   ├── sukuna_aod.mtz             # Custom Xiaomi AOD theme package
│   └── sukuna_aod_store.mtz       # Store-compatible Xiaomi AOD package
├── miside_decompiled/             # Full Apktool source tree
│   ├── AndroidManifest.xml        # Package definitions, permissions & SuperWallpaperService
│   ├── assets/
│   │   ├── backup.jpg             # Frame 0 AMOLED standby image
│   │   ├── sukuna_aod.png         # AOD texture reference
│   │   └── unlocked.mp4           # 1220x2712 60fps Domain Expansion video
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
1. **Screen Off / Standby**: The engine pauses video playback and binds `backup.jpg` (Frame 0) to the OpenGL ES 2.0 surface.
2. **Screen Wake / Lockscreen**: Frame 0 remains displayed without decoding video frames, minimizing power consumption on AMOLED displays.
3. **Screen Unlock**: The `onVisibilityChanged` / `onCommand` triggers surface unlock, and `unlocked.mp4` begins playback at 60 FPS, animating Sukuna forming the Enmaten hand seal and manifesting Malevolent Shrine.
4. **Homescreen Loop / Rest**: The animation concludes on the grand view of Malevolent Shrine surrounded by cursed skulls and water ripples.

### HyperOS In-Call UI Behavior Note
In Xiaomi HyperOS, the dialer application (`com.android.incallui` / `XiaomiInCallUI`) queries `MiuiWallpaperManagerService` for a static preview bitmap when rendering the call background. When any live/super wallpaper is applied across both home and lock screens, HyperOS clears the static lockscreen wallpaper cache (`Lock wallpaper state: null`). Because live wallpaper engines do not provide a static surface to external applications, `XiaomiInCallUI` falls back to the system ROM's default gradient (stock pink/blue HyperOS theme). This is an operating system limitation that affects all official Xiaomi Super Wallpapers (Earth, Mars, Snow Mountain) as well.

---

## 📜 Disclaimer

This project is a fan-made, non-commercial customization for Android.
- *Jujutsu Kaisen* and Ryomen Sukuna are trademarks and copyright of Gege Akutami / Shueisha / MAPPA.
- Base engine derived from open Android live wallpaper research.
