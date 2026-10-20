import os

base = r"D:\Projects\SukunaSuperWallpaper\miside_decompiled\smali\com\androradar\walls6"

# 1. Update VideoPlayer.smali (playToLock)
p_path = os.path.join(base, "VideoPlayer.smali")
with open(p_path, "r", encoding="utf-8") as f:
    c = f.read()

# Replace any previous value with 0x2dc6c0
for old in ["0x100590", "0x1b7740", "0x1e8480"]:
    if old in c:
        c = c.replace(old, "0x2dc6c0")
        print(f"Replaced {old} with 0x2dc6c0 in VideoPlayer.smali")

with open(p_path, "w", encoding="utf-8", newline="") as f:
    f.write(c)

# 2. Update VideoPlayer$VideoHandler.smali (resumeAdvance)
h_path = os.path.join(base, "VideoPlayer$VideoHandler.smali")
with open(h_path, "r", encoding="utf-8") as f:
    c = f.read()

for old in ["0x100590", "0x1b7740", "0x1e8480"]:
    if old in c:
        c = c.replace(old, "0x2dc6c0")
        print(f"Replaced {old} with 0x2dc6c0 in VideoPlayer$VideoHandler.smali")

with open(h_path, "w", encoding="utf-8", newline="") as f:
    f.write(c)

print("Sukuna smali updated to 3.0s (0x2dc6c0)!")
