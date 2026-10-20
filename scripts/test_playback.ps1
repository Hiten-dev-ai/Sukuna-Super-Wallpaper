<# Runs the packaged player and hardware decoder without installing or selecting a wallpaper. #>
param(
    [Parameter(Mandatory = $true)][string]$AndroidJar,
    [Parameter(Mandatory = $true)][string]$D8Jar,
    [string]$Apk,
    [string]$Device
)
$ErrorActionPreference = 'Stop'
$ProjectRoot = Split-Path $PSScriptRoot -Parent
$Timing = Get-Content -LiteralPath "$ProjectRoot\media-timing.json" -Raw | ConvertFrom-Json
if (-not $Apk) {
    $ProjectName = Split-Path $ProjectRoot -Leaf
    $Apk = "$ProjectRoot\prebuilt\$ProjectName.apk"
}
$Apk = (Resolve-Path -LiteralPath $Apk).Path
$AndroidJar = (Resolve-Path -LiteralPath $AndroidJar).Path
$D8Jar = (Resolve-Path -LiteralPath $D8Jar).Path
$TaskId = [guid]::NewGuid().ToString('N')
$TempRoot = [IO.Path]::GetFullPath([IO.Path]::GetTempPath())
$TaskTemp = Join-Path $TempRoot "wallpaper-playback-$TaskId"
$RemoteTemp = "/data/local/tmp/wallpaper-playback-$TaskId"
$AdbArgs = @()
if ($Device) { $AdbArgs = @('-s', $Device) }
function Invoke-Checked([string]$Program, [string[]]$Arguments) {
    & $Program @Arguments
    if ($LASTEXITCODE -ne 0) { throw "$Program failed with exit code $LASTEXITCODE" }
}
try {
    New-Item -ItemType Directory -Path "$TaskTemp\classes" -Force | Out-Null
    Invoke-Checked 'javac' @('--release', '8', '-Xlint:-options', '-cp', $AndroidJar, '-d', "$TaskTemp\classes", "$PSScriptRoot\PlaybackSmoke.java")
    $Classes = @(Get-ChildItem -LiteralPath "$TaskTemp\classes" -Filter '*.class' | ForEach-Object FullName)
    Invoke-Checked 'java' (@('-cp', $D8Jar, 'com.android.tools.r8.D8', '--lib', $AndroidJar, '--output', $TaskTemp) + $Classes)
    Invoke-Checked 'adb' ($AdbArgs + @('shell', 'mkdir', $RemoteTemp))
    Invoke-Checked 'adb' ($AdbArgs + @('push', "$TaskTemp\classes.dex", "$RemoteTemp/classes.dex"))
    Invoke-Checked 'adb' ($AdbArgs + @('push', $Apk, "$RemoteTemp/app.apk"))
    $RemoteCommand = "CLASSPATH=$RemoteTemp/classes.dex`:$RemoteTemp/app.apk timeout 30 app_process /system/bin PlaybackSmoke $RemoteTemp/app.apk $($Timing.home_start_us) $($Timing.lock_hold_us)"
    Invoke-Checked 'adb' ($AdbArgs + @('shell', $RemoteCommand))
} finally {
    try {
        & adb @AdbArgs shell "if [ -d '$RemoteTemp' ]; then rm -f '$RemoteTemp/classes.dex' '$RemoteTemp/app.apk'; rmdir '$RemoteTemp'; fi" 2>$null
    } finally {
        $ResolvedTemp = [IO.Path]::GetFullPath($TaskTemp)
        if (-not $ResolvedTemp.StartsWith($TempRoot, [StringComparison]::OrdinalIgnoreCase)) { throw 'Temporary cleanup path escaped system temp directory' }
        if (Test-Path -LiteralPath $ResolvedTemp) { Remove-Item -LiteralPath $ResolvedTemp -Recurse -Force }
    }
}
