<#
.SYNOPSIS
    Build and sign Sukuna Super Wallpaper APK.
.DESCRIPTION
    Uses apktool to recompile miside_decompiled and uber-apk-signer (or apksigner) to zipalign and sign the APK.
#>

param(
    [string]$SourceDir = "$PSScriptRoot\miside_decompiled",
    [string]$OutputDir = "$PSScriptRoot\prebuilt",
    [string]$ApktoolJar = "$env:USERPROFILE\apktool.jar",
    [string]$SignerJar = "$env:USERPROFILE\uber-apk-signer.jar"
)

$ErrorActionPreference = "Stop"

Write-Host "==================================================" -ForegroundColor Cyan
Write-Host "   Sukuna Super Wallpaper - Build & Sign System   " -ForegroundColor Cyan
Write-Host "==================================================" -ForegroundColor Cyan

if (-not (Test-Path $SourceDir)) {
    Write-Error "Source directory not found: $SourceDir"
}

if (-not (Test-Path $OutputDir)) {
    New-Item -ItemType Directory -Path $OutputDir -Force | Out-Null
}

$UnsignedApk = "$OutputDir\SukunaSuperWallpaper_unsigned.apk"
$FinalApk = "$OutputDir\SukunaSuperWallpaper.apk"

# Step 1: Recompile with apktool
Write-Host "`n[1/3] Building APK with apktool..." -ForegroundColor Yellow
if (Get-Command apktool -ErrorAction SilentlyContinue) {
    apktool b "$SourceDir" -o "$UnsignedApk"
} elseif (Test-Path $ApktoolJar) {
    java -jar "$ApktoolJar" b "$SourceDir" -o "$UnsignedApk"
} else {
    Write-Error "apktool not found! Place apktool.jar in $env:USERPROFILE or add apktool to PATH."
}

if (-not (Test-Path $UnsignedApk)) {
    Write-Error "APK compilation failed. $UnsignedApk was not generated."
}

# Step 2: Zipalign & Sign
Write-Host "`n[2/3] Aligning and signing APK..." -ForegroundColor Yellow
if (Test-Path $SignerJar) {
    java -jar "$SignerJar" --apks "$UnsignedApk" --allowResign -o "$OutputDir"
    $SignedPattern = "$OutputDir\SukunaSuperWallpaper_unsigned-aligned-debugSigned.apk"
    if (Test-Path $SignedPattern) {
        Move-Item -Path $SignedPattern -Destination $FinalApk -Force
    }
} elseif (Get-Command apksigner -ErrorAction SilentlyContinue) {
    Write-Host "Using system apksigner/zipalign..." -ForegroundColor Yellow
    zipalign -p -f 4 "$UnsignedApk" "$FinalApk"
    apksigner sign --ks "$env:USERPROFILE\.android\debug.keystore" --ks-pass pass:android "$FinalApk"
} else {
    Write-Warning "No signer jar found at $SignerJar. Unsigned APK available at: $UnsignedApk"
    exit 0
}

# Step 3: Cleanup temporary unsigned files
if (Test-Path "$UnsignedApk") {
    Remove-Item -Path "$UnsignedApk" -Force
}
if (Test-Path "$FinalApk.idsig") {
    Remove-Item -Path "$FinalApk.idsig" -Force
}

Write-Host "`n[3/3] Build complete!" -ForegroundColor Green
Write-Host "Output: $FinalApk" -ForegroundColor Green
Write-Host "Size:   $([math]::Round((Get-Item $FinalApk).Length / 1MB, 2)) MB" -ForegroundColor Green
