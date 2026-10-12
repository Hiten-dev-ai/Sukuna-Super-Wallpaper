import struct
from find_sids import dex, target_sids, get_string, method_ids_off, proto_ids_off, type_ids_off

# Search for const-string (0x1a reg idx_lo idx_hi) or const-string/jumbo (0x1b reg idx_0 idx_1 idx_2 idx_3)
for name, sid in target_sids.items():
    print(f"\nSearching for usage of '{name}' (sid={sid}):")
    # pattern 1: 1a XX [sid & 0xff] [(sid >> 8) & 0xff]
    pattern1 = bytes([0x1a]) + bytes([sid & 0xff, (sid >> 8) & 0xff])
    # pattern 2: 1b XX [sid 4 bytes]
    pattern2 = bytes([0x1b]) + struct.pack('<I', sid)
    
    # search pattern1 (matching 2nd byte as wildcard)
    for pos in range(0, len(dex) - 4):
        if dex[pos] == 0x1a and dex[pos+2] == (sid & 0xff) and dex[pos+3] == ((sid >> 8) & 0xff):
            print(f"  Match const-string at offset 0x{pos:x} (reg {dex[pos+1]})")
        elif dex[pos] == 0x1b and dex[pos+2:pos+6] == struct.pack('<I', sid):
            print(f"  Match const-string/jumbo at offset 0x{pos:x} (reg {dex[pos+1]})")
