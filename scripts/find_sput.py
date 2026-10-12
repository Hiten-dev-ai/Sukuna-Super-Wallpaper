import struct
from dump_utils import class_defs_size, class_defs_off, dex, field_ids_off, get_string, method_ids_off
from find_methods import get_type_name, get_method_name, read_uleb128

target_field = None
for i in range(field_ids_size if 'field_ids_size' in globals() else 30000):
    try:
        c_idx, t_idx, n_idx = struct.unpack('<HHI', dex[field_ids_off + i*8 : field_ids_off + i*8 + 8])
        cname = get_type_name(c_idx)
        fname = get_string(n_idx)
        if cname == 'Lcom/miui/aod/Utils;' and fname == 'sMiuiOptimizationDisabled':
            target_field = i
            print(f"Found field {fname} with id {i}")
            break
    except:
        pass

if target_field is not None:
    # search sput (0x68, 0x69, etc) with target_field
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
                if op in [0x67, 0x68, 0x69, 0x6a, 0x6b]:
                    fid = struct.unpack('<H', insns[pc+2:pc+4])[0]
                    if fid == target_field:
                        caller_name = get_method_name(mid)
                        print(f"Writer: {caller_name} writes to sMiuiOptimizationDisabled (op 0x{op:x} at pc {pc})")
