import zipfile, re

apk_path = r'C:\Users\hiten_9mpt\.gemini\antigravity\scratch\sukuna_theme\MIUIAod.apk'
with zipfile.ZipFile(apk_path, 'r') as z:
    data = z.read('classes.dex')
    
    # Search for all occurrences of SettingsHolder or Settings keys registered in SettingsHolder
    idx = data.find(b'Lcom/miui/aod/doze/SettingsHolder;')
    print(f"SettingsHolder found at: {idx}")
    
    # Find all strings that look like setting keys (alphanumeric with underscores) near SettingsHolder or across dex
    # In SettingsHolder, observers are registered for ContentResolver
    matches = re.findall(rb'content://settings/[a-zA-Z0-9_/]+', data)
    print("Settings URIs:", set(m.decode() for m in matches))

    # Let's search for "aod_" keys used in Settings.Secure / System
    aod_keys = set(re.findall(rb'\b(?:aod|doze)_[a-zA-Z0-9_]+\b', data))
    print("\nAll aod_/doze_ keys found in classes.dex:")
    for k in sorted(k.decode() for k in aod_keys):
        print("  ", k)
