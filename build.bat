@echo off
setlocal
echo ==================================================
echo    Sukuna Super Wallpaper - Build ^& Sign System   
echo ==================================================

powershell -NoProfile -ExecutionPolicy Bypass -File "%~dp0build.ps1"
if %ERRORLEVEL% neq 0 (
    echo [ERROR] Build failed with exit code %ERRORLEVEL%
    exit /b %ERRORLEVEL%
)
echo [SUCCESS] Build completed successfully.
pause
