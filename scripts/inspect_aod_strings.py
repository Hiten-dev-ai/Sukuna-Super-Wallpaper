import zipfile, re

apk_path = r'C:\Users\hiten_9mpt\.gemini\antigravity\scratch\sukuna_theme\MIUIAod.apk'
with zipfile.ZipFile(apk_path, 'r') as z:
    data = z.read('classes.dex')
    
    # Let's extract all strings in dex
    # DEX format string_ids: offset table
    # Simple regex to find ASCII strings between 3 and 60 chars
    strings = set()
    for s in re.findall(b'[\x20-\x7e]{4,60}', data):
        st = s.decode('latin1')
        if any(k in st.lower() for k in ['fullscreen', 'aod_', 'super_wallpaper', 'doze', 'timeout', '10s']):
            strings.add(st)
            
    print(f"Total matching strings: {len(strings)}")
    for s in sorted(list(strings))[:150]:
        print("  ", s)
