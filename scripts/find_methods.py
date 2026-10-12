import struct
from find_sids import dex, class_defs_size, class_defs_off, type_ids_off, get_string

def get_type_name(type_idx):
    descriptor_idx = struct.unpack('<I', dex[type_ids_off + type_idx*4 : type_ids_off + type_idx*4 + 4])[0]
    return get_string(descriptor_idx)

# Search class_defs
target_offsets = [0x3d1670, 0x3d22cc, 0x3d29ec, 0x3d337e, 0x3d5524, 0x40f006, 0x74eb61]

print("Checking classes containing those offsets:")
for i in range(class_defs_size):
    entry = class_defs_off + i * 32
    class_idx, access_flags, superclass_idx, interfaces_off, source_file_idx, annotations_off, class_data_off, static_values_off = struct.unpack('<IIIIIIII', dex[entry:entry+32])
    if class_data_off == 0: continue
    
    # Check if any target offset is roughly near this class or let's find class_data
    # In class_data, code_off gives the method code items!
    # Let's inspect class name if class_data_off is near
    pass

# Better: Let's read code_item offsets and see which method contains 0x3d22cc
# Each code_item starts with: registers_size (u2), ins_size (u2), outs_size (u2), tries_size (u2), debug_info_off (u4), insns_size (u4), insns (u2 * insns_size)
print("Scanning code items...")
# Parse all class_data
from find_sids import method_ids_off

def get_method_name(mid):
    class_idx, proto_idx, name_idx = struct.unpack('<HHI', dex[method_ids_off + mid*8 : method_ids_off + mid*8 + 8])
    cname = get_type_name(class_idx)
    mname = get_string(name_idx)
    return f"{cname}->{mname}"

def read_uleb128(p):
    val = 0
    shift = 0
    while True:
        b = dex[p]
        p += 1
        val |= (b & 0x7f) << shift
        if not (b & 0x80): break
        shift += 7
    return val, p

# Find which method contains 0x3d22cc, 0x3d5524, 0x3d1bd4, 0x3d337e
found = {}
for i in range(class_defs_size):
    entry = class_defs_off + i * 32
    class_idx, _, _, _, _, _, class_data_off, _ = struct.unpack('<IIIIIIII', dex[entry:entry+32])
    if class_data_off == 0: continue
    
    p = class_data_off
    static_fields_size, p = read_uleb128(p)
    instance_fields_size, p = read_uleb128(p)
    direct_methods_size, p = read_uleb128(p)
    virtual_methods_size, p = read_uleb128(p)
    
    for _ in range(static_fields_size + instance_fields_size):
        _, p = read_uleb128(p)
        _, p = read_uleb128(p)
        
    method_id = 0
    for _ in range(direct_methods_size + virtual_methods_size):
        method_idx_diff, p = read_uleb128(p)
        method_id += method_idx_diff
        access_flags, p = read_uleb128(p)
        code_off, p = read_uleb128(p)
        if code_off != 0:
            insns_size = struct.unpack('<I', dex[code_off + 12 : code_off + 16])[0]
            insns_start = code_off + 16
            insns_end = insns_start + insns_size * 2
            for target in target_offsets:
                if insns_start <= target < insns_end:
                    cname = get_type_name(class_idx)
                    mname = get_method_name(method_id)
                    print(f"Target 0x{target:x} is inside {mname} (insns: 0x{insns_start:x} - 0x{insns_end:x})")

