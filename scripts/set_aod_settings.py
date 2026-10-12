import subprocess, json

adb = r"C:\Users\hiten_9mpt\AppData\Local\Microsoft\WinGet\Packages\Google.PlatformTools_Microsoft.Winget.Source_8wekyb3d8bbwe\platform-tools\adb.exe"

data = {
    "is_invert": False,
    "show_style": 0,
    "pic_uri": "/sdcard/DCIM/Camera/.aod_cache/sukuna_aod.png",
    "attribute_flag": 3,
    "bg_cluster": [-1],
    "mForAodNotification": False,
    "is_change_color_alongtime": False,
    "name": "image_bg_selector",
    "set_window_size": {"x": 1220, "y": 2712},
    "content_container_location": [0, 0, 1220, 2712],
    "change_matrix": [1.0, 0.0, 0.0, 0.0, 1.0, 0.0, 0.0, 0.0, 1.0]
}

json_str = json.dumps(data)

cmd_str = f"settings put secure image_bg_selector '{json_str}'"
res = subprocess.run([adb, "shell", cmd_str], capture_output=True, text=True)
print("put secure:", res.returncode, res.stdout, res.stderr)

res2 = subprocess.run([adb, "shell", "settings", "get", "secure", "image_bg_selector"], capture_output=True, text=True)
print("get secure:", res2.stdout.strip())
