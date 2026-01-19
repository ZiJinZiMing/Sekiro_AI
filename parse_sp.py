
import csv

def parse_sp_effect(csv_path, target_id):
    with open(csv_path, 'r', encoding='utf-8', errors='ignore') as f:
        lines = f.readlines()

    header = []
    target_row = []

    for line in lines:
        parts = line.strip().split(',')
        if not header and "ID" in parts[0]:
            header = parts
        if parts[0] == target_id:
            target_row = parts
            break
    
    if not header or not target_row:
        print("Header or Target Row not found")
        return

    print(f"Attributes for {target_id}:")
    for i, (key, value) in enumerate(zip(header, target_row)):
        if value and value not in ['0', '-1', '0.0', '', ' ']:
             # Filter out common defaults if possible, but showing all non-zero is safer
             # Actually -1 is common default for IDs. 0 is common for rates.
             # Let's just print everything that looks "set".
             # For floats, 1.0 might be default for rates.
             
             # Heuristic: Print everything not 0, -1, empty. 
             # Also print 1 if it's likely a boolean flag (but we don't know types for sure).
             print(f"{i}: {key} = {value}")

parse_sp_effect(r"d:\Sekiro\Sekiro_AI\param\param\SpEffectParam.csv", "200220")
