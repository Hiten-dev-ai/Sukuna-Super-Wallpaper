import struct
from find_sids import dex, field_ids_off, get_string, method_ids_off
from find_methods import get_type_name, get_method_name
from disasm_utils import dump_method_bytes

# Utils.<clinit> code_off was 0x3d334c
dump_method_bytes("Lcom/miui/aod/Utils;-><clinit>", 0x3d334c)
