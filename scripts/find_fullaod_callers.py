import struct
from find_sids import dex, method_ids_off, get_string, class_defs_size, class_defs_off
from find_methods import get_method_name, read_uleb128

# Search for calls to isFullAodSupport
target_method = "Lcom/miui/aod/Utils;->isFullAodSupport"
target_mid = None
for i in range(59952):
    m = get_method_name(i)
    if m.startswith(target_method):
        target_mid = i
        print(f"Target {m} -> mid {i}")
        break

if target_mid is not None:
    for i in range(class_defs_size):
        entry = class_defs_off + i * 32
        class_idx, _, _, _, _, _, class_data_off, _ = struct.unpack('<IIIIIIII', dex[entry:entry+32])
        if class_data_off == 0: continue
        p = class_data_off
        sf, p = read_uleb128(p); inf, p = read_uleb128(p); dm, p = read_uleb128(p); vm, p = read_uleb128(p)
        for _ in range(sf + inf): _, p = read_uleb128(p); _, p = read_uleb128(p)
        mid = 0
        for _ in range(dm + vm):
            m_diff, p = read_uleb128(p); mid += m_diff; flags, p = read_uleb128(p); code_off, p = read_uleb128(p)
            if code_off == 0: continue
            insns_size = struct.unpack('<I', dex[code_off+12:code_off+16])[0]
            insns = dex[code_off+16 : code_off+16 + insns_size*2]
            for pc in range(0, len(insns)-4, 2):
                op = insns[pc]
                if op in [0x6e, 0x71, 0x74, 0x77]:
                    called_mid = struct.unpack('<H', insns[pc+2:pc+4])[0]
                    if called_mid == target_mid:
                        caller_name = get_method_name(mid)
                        print(f"Caller of isFullAodSupport: {caller_name}")
