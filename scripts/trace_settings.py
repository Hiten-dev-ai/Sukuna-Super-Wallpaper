import zipfile, re

apk_path = r'C:\Users\hiten_9mpt\.gemini\antigravity\scratch\sukuna_theme\MIUIAod.apk'
with zipfile.ZipFile(apk_path, 'r') as z:
    data = z.read('classes.dex')
    
    # Search for methods in SettingsHolder
    # Let's search for "aod_show_mode" or "aod_show_style" or "doze_always_on"
    for target in [b'aod_show_mode', b'aod_show_style', b'aod_always_style', b'aod_using_super_wallpaper', b'support_aod_fullscreen']:
        print(f"\n=== Searching for {target.decode()} ===")
        pos = 0
        while True:
            idx = data.find(target, pos)
            if idx == -1:
                break
            snippet = data[max(0, idx-100):min(len(data), idx+150)]
            # print printable string
            printable = ''.join(chr(c) if 32 <= c <= 126 else '.' for c in snippet)
            print(f"Offset {idx}: {printable}\n")
            pos = idx + len(target)
            if pos > idx + 500: break
