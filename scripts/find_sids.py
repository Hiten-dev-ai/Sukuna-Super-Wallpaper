import zipfile, struct

apk_path = r'C:\Users\hiten_9mpt\.gemini\antigravity\scratch\sukuna_theme\MIUIAod.apk'

with zipfile.ZipFile(apk_path, 'r') as z:
    dex = z.read('classes.dex')

# DEX Header parsing
magic = dex[:8]
string_ids_size, string_ids_off = struct.unpack('<II', dex[0x38:0x40])
type_ids_size, type_ids_off = struct.unpack('<II', dex[0x40:0x48])
proto_ids_size, proto_ids_off = struct.unpack('<II', dex[0x48:0x50])
field_ids_size, field_ids_off = struct.unpack('<II', dex[0x50:0x58])
method_ids_size, method_ids_off = struct.unpack('<II', dex[0x58:0x60])
class_defs_size, class_defs_off = struct.unpack('<II', dex[0x60:0x68])

print(f"Strings: {string_ids_size}, Classes: {class_defs_size}, Methods: {method_ids_size}")

def get_string(idx):
    if idx >= string_ids_size: return ""
    off = struct.unpack('<I', dex[string_ids_off + idx*4 : string_ids_off + idx*4 + 4])[0]
    # parse uleb128 length
    p = off
    l = 0
    shift = 0
    while True:
        b = dex[p]
        p += 1
        l |= (b & 0x7f) << shift
        if not (b & 0x80): break
        shift += 7
    return dex[p:p+l].decode('utf-8', errors='replace')

# Build map of interesting strings -> string_id
target_words = ['support_aod_fullscreen', 'aod_using_super_wallpaper', 'aod_show_style', 'aod_mode', 'doze_always_on', 'isSupportFullScreenAod', 'full_screen_aod_support']
target_sids = {}
for i in range(string_ids_size):
    s = get_string(i)
    if s in target_words:
        target_sids[s] = i
        print(f"String '{s}' -> ID {i}")

