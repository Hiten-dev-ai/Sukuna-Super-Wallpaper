from dump_utils import class_defs_size, class_defs_off, dex, struct, get_type_name
from find_methods import get_method_name, read_uleb128
from disasm_utils import dump_method_bytes

for i in range(class_defs_size):
    entry = class_defs_off + i * 32
    class_idx, _, _, _, _, _, class_data_off, _ = struct.unpack('<IIIIIIII', dex[entry:entry+32])
    cname = get_type_name(class_idx)
    if 'AODSettings' in cname:
        p = class_data_off
        sf, p = read_uleb128(p); inf, p = read_uleb128(p); dm, p = read_uleb128(p); vm, p = read_uleb128(p)
        for _ in range(sf + inf): _, p = read_uleb128(p); _, p = read_uleb128(p)
        mid = 0
        for _ in range(dm + vm):
            m_diff, p = read_uleb128(p); mid += m_diff; flags, p = read_uleb128(p); code_off, p = read_uleb128(p)
            mname = get_method_name(mid)
            if 'onlySupportKeycodeGoto' in mname or 'isKeycodeGotoEnable' in mname:
                dump_method_bytes(mname, code_off)
