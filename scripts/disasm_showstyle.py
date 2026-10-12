from disasm_utils import dump_method_bytes, get_method_name, read_uleb128
from dump_utils import class_defs_size, class_defs_off, dex, struct, get_type_name

methods_to_dump = ['getDefaultShowStyle', 'verifyShowStyle', 'isMiuiOptimizationDisabled', 'setMiuiOptimizationDisabled', 'resolveShowStyle']

for i in range(class_defs_size):
    entry = class_defs_off + i * 32
    class_idx, _, _, _, _, _, class_data_off, _ = struct.unpack('<IIIIIIII', dex[entry:entry+32])
    cname = get_type_name(class_idx)
    if cname == 'Lcom/miui/aod/Utils;':
        p = class_data_off
        static_fields_size, p = read_uleb128(p)
        instance_fields_size, p = read_uleb128(p)
        direct_methods_size, p = read_uleb128(p)
        virtual_methods_size, p = read_uleb128(p)
        for _ in range(static_fields_size + instance_fields_size):
            _, p = read_uleb128(p); _, p = read_uleb128(p)
        method_id = 0
        for _ in range(direct_methods_size + virtual_methods_size):
            method_idx_diff, p = read_uleb128(p)
            method_id += method_idx_diff
            access_flags, p = read_uleb128(p)
            code_off, p = read_uleb128(p)
            mname = get_method_name(method_id)
            base_mname = mname.split('->')[-1]
            if base_mname in methods_to_dump:
                dump_method_bytes(mname, code_off)
