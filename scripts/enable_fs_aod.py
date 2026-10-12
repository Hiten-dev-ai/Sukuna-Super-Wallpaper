import subprocess, json

adb = r"C:\Users\hiten_9mpt\AppData\Local\Microsoft\WinGet\Packages\Google.PlatformTools_Microsoft.Winget.Source_8wekyb3d8bbwe\platform-tools\adb.exe"

res = subprocess.run([adb, "shell", "settings", "get", "secure", "constant_template_editor_info"], capture_output=True, text=True)
raw = res.stdout.strip()

data = json.loads(raw)
data["lockscreenInfo"]["wallpaperInfo"]["isSupportFullScreenAod"] = True
if "homeInfo" in data and "wallpaperInfo" in data["homeInfo"]:
    data["homeInfo"]["wallpaperInfo"]["isSupportFullScreenAod"] = True

new_raw = json.dumps(data)

cmd_str = f"settings put secure constant_template_editor_info '{new_raw}'"
res2 = subprocess.run([adb, "shell", cmd_str], capture_output=True, text=True)
print("put result:", res2.returncode, res2.stdout, res2.stderr)
