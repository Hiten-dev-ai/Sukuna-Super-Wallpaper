import zipfile, re

apk_path = r'C:\Users\hiten_9mpt\.gemini\antigravity\scratch\sukuna_theme\MIUIAod.apk'
with zipfile.ZipFile(apk_path, 'r') as z:
    for dex_name in ['classes.dex', 'classes2.dex']:
        data = z.read(dex_name)
        print(f"=== {dex_name} ({len(data)} bytes) ===")
        for word in [b'support_aod', b'aod_mode', b'always_on', b'doze', b'full_screen_aod', b'support_full_screen', b'aod_show_style', b'aod_using_super_wallpaper']:
            matches = [m.start() for m in re.finditer(word, data, re.IGNORECASE)]
            print(f'Keyword {word.decode()} matches: {len(matches)}')
            for m in matches[:3]:
                snippet = data[max(0, m-30):min(len(data), m+60)]
                printable = ''.join(chr(c) if 32 <= c <= 126 else ' ' for c in snippet)
                print('   Snippet:', printable.strip())
