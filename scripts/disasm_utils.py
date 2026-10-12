import struct
from find_sids import dex, method_ids_off, string_ids_off, type_ids_off, field_ids_off, get_string
from find_methods import get_type_name, get_method_name, read_uleb128

methods_to_dump = [
    'isSupportFsAod', 'isFullAodSupport', 'isMiuiOptimizationDisabled',
    'getDisplayMode', 'setDisplayMode', 'getShowStyle', 'setShowStyle',
    'isUsingSuperWallpaperStyle', 'isWallPaperSuperWallpaper',
    'updateTouchModeForKeepScreenOnIfNeeded', '<clinit>'
]

def dump_method_bytes(mname, code_off):
    print(f"\n==================== {mname} (0x{code_off:x}) ====================")
    regs_size, ins_size, outs_size, tries_size, debug_off, insns_size = struct.unpack('<HHHHII', dex[code_off:code_off+16])
    print(f"regs={regs_size}, ins={ins_size}, outs={outs_size}, insns_size={insns_size}")
    insns_start = code_off + 16
    insns_data = dex[insns_start : insns_start + insns_size * 2]
    
    # Simple disassembly of common opcodes
    pc = 0
    while pc < len(insns_data):
        op = insns_data[pc]
        op_hex = f"{op:02x}"
        # const-string
        if op == 0x1a:
            reg = insns_data[pc+1]
            sid = struct.unpack('<H', insns_data[pc+2:pc+4])[0]
            print(f"  {pc:04x}: const-string v{reg}, \"{get_string(sid)}\"")
            pc += 4
        elif op == 0x1b:
            reg = insns_data[pc+1]
            sid = struct.unpack('<I', insns_data[pc+2:pc+6])[0]
            print(f"  {pc:04x}: const-string/jumbo v{reg}, \"{get_string(sid)}\"")
            pc += 6
        elif op == 0x12: # const/4
            vA = insns_data[pc+1] & 0x0f
            vB = (insns_data[pc+1] >> 4) & 0x0f
            print(f"  {pc:04x}: const/4 v{vA}, {vB}")
            pc += 2
        elif op == 0x13: # const/16
            reg = insns_data[pc+1]
            val = struct.unpack('<h', insns_data[pc+2:pc+4])[0]
            print(f"  {pc:04x}: const/16 v{reg}, {val}")
            pc += 4
        elif op in [0x6e, 0x74, 0x6f, 0x75]: # invoke-virtual/invoke-direct/etc
            reg_count = (insns_data[pc+1] >> 4) & 0x0f
            mid = struct.unpack('<H', insns_data[pc+2:pc+4])[0]
            print(f"  {pc:04x}: invoke {get_method_name(mid)} (mid={mid})")
            pc += 6
        elif op in [0x71, 0x77, 0x72, 0x78]: # invoke-xxx/range
            mid = struct.unpack('<H', insns_data[pc+2:pc+4])[0]
            print(f"  {pc:04x}: invoke-range {get_method_name(mid)} (mid={mid})")
            pc += 6
        elif op in [0x62, 0x63, 0x64, 0x65]: # sget
            reg = insns_data[pc+1]
            fid = struct.unpack('<H', insns_data[pc+2:pc+4])[0]
            # field name
            c_idx, t_idx, n_idx = struct.unpack('<HHI', dex[field_ids_off + fid*8 : field_ids_off + fid*8 + 8])
            print(f"  {pc:04x}: sget v{reg}, {get_type_name(c_idx)}->{get_string(n_idx)}")
            pc += 4
        elif op in [0x68, 0x69, 0x6a, 0x6b]: # sput
            reg = insns_data[pc+1]
            fid = struct.unpack('<H', insns_data[pc+2:pc+4])[0]
            c_idx, t_idx, n_idx = struct.unpack('<HHI', dex[field_ids_off + fid*8 : field_ids_off + fid*8 + 8])
            print(f"  {pc:04x}: sput v{reg}, {get_type_name(c_idx)}->{get_string(n_idx)}")
            pc += 4
        elif op in [0x54, 0x55, 0x56, 0x57]: # iget
            reg = insns_data[pc+1] & 0x0f
            fid = struct.unpack('<H', insns_data[pc+2:pc+4])[0]
            c_idx, t_idx, n_idx = struct.unpack('<HHI', dex[field_ids_off + fid*8 : field_ids_off + fid*8 + 8])
            print(f"  {pc:04x}: iget v{reg}, {get_type_name(c_idx)}->{get_string(n_idx)}")
            pc += 4
        elif op in [0x0e, 0x0f]: # return-void / return
            print(f"  {pc:04x}: return (op {op_hex})")
            pc += 2
        else:
            # print raw op
            # print(f"  {pc:04x}: op {op_hex}")
            pc += 2

from dump_utils import class_defs_size, class_defs_off, read_uleb128

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
