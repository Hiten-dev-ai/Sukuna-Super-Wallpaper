import os

handler_path = r"D:\Projects\SukunaSuperWallpaper\miside_decompiled\smali\com\androradar\walls6\VideoPlayer$VideoHandler.smali"
with open(handler_path, "r", encoding="utf-8") as f:
    content = f.read()

print("Original content contains 0x1b7740?", "0x1b7740" in content)
if "0x1b7740" in content:
    content = content.replace("0x1b7740", "0x100590")
    with open(handler_path, "w", encoding="utf-8", newline="") as f:
        f.write(content)
    print("SUCCESS: Updated VideoPlayer$VideoHandler.smali to 0x100590")
else:
    print("WARNING: 0x1b7740 not in VideoPlayer$VideoHandler.smali")
