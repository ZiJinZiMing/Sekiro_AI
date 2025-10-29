#!/usr/bin/env python3
"""
Sekiro AI Battle Script Analysis Tool
Analyzes all battle scripts to find which character uses the most common AI functions
"""

import os
import re
import glob
from collections import defaultdict, Counter

def find_battle_scripts(base_dir):
    """Find all battle script files"""
    pattern = os.path.join(base_dir, "*-luabnd-dcx", "script", "ai", "out", "bin", "*_battle.lua")
    return glob.glob(pattern)

def analyze_file(filepath):
    """Analyze a single battle script file for common AI functions"""
    try:
        with open(filepath, 'r', encoding='utf-8', errors='ignore') as f:
            content = f.read()
    except:
        try:
            # Try with different encoding
            with open(filepath, 'r', encoding='shift_jis', errors='ignore') as f:
                content = f.read()
        except:
            return {}, {}

    # Extract character ID from filename
    filename = os.path.basename(filepath)
    char_id = filename.replace('_battle.lua', '')

    # Count GOAL_COMMON_* functions
    goal_common_pattern = r'GOAL_COMMON_\w+'
    goal_common_matches = re.findall(goal_common_pattern, content)
    goal_common_counts = Counter(goal_common_matches)

    # Count Common_* functions
    common_pattern = r'Common_\w+'
    common_matches = re.findall(common_pattern, content)
    common_counts = Counter(common_matches)

    return {
        'char_id': char_id,
        'filepath': filepath,
        'goal_common_total': sum(goal_common_counts.values()),
        'common_total': sum(common_counts.values()),
        'goal_common_functions': goal_common_counts,
        'common_functions': common_counts,
        'total_common_usage': sum(goal_common_counts.values()) + sum(common_counts.values())
    }

def main():
    base_dir = r"D:\Sekiro\Sekiro_AI"
    battle_scripts = find_battle_scripts(base_dir)

    print(f"Found {len(battle_scripts)} battle scripts")
    print("="*60)

    results = []
    all_goal_common_funcs = Counter()
    all_common_funcs = Counter()

    for script_path in battle_scripts:
        analysis = analyze_file(script_path)
        if analysis and analysis['total_common_usage'] > 0:
            results.append(analysis)
            all_goal_common_funcs.update(analysis['goal_common_functions'])
            all_common_funcs.update(analysis['common_functions'])

    # Sort by total usage
    results.sort(key=lambda x: x['total_common_usage'], reverse=True)

    print("TOP 20 CHARACTERS BY COMMON AI FUNCTION USAGE:")
    print("="*60)
    print(f"{'Character ID':<12} {'GOAL_COMMON':<12} {'Common_*':<12} {'Total':<8} {'File Location'}")
    print("-"*80)

    for i, result in enumerate(results[:20]):
        char_id = result['char_id']
        goal_total = result['goal_common_total']
        common_total = result['common_total']
        total = result['total_common_usage']
        filepath = result['filepath'].replace(base_dir, "").replace("\\", "/")
        print(f"{char_id:<12} {goal_total:<12} {common_total:<12} {total:<8} {filepath}")

    print("\n" + "="*60)
    print("WINNER:")
    top_result = results[0]
    print(f"Character {top_result['char_id']} uses {top_result['total_common_usage']} common AI functions total")
    print(f"  - GOAL_COMMON_* functions: {top_result['goal_common_total']}")
    print(f"  - Common_* functions: {top_result['common_total']}")
    print(f"  - Located in: {top_result['filepath']}")

    print("\n" + "="*60)
    print("BREAKDOWN OF TOP CHARACTER'S FUNCTION USAGE:")
    print("\nGOAL_COMMON_* Functions:")
    for func, count in top_result['goal_common_functions'].most_common(10):
        print(f"  {func}: {count}")

    print("\nCommon_* Functions:")
    for func, count in top_result['common_functions'].most_common(10):
        print(f"  {func}: {count}")

    print("\n" + "="*60)
    print("MOST POPULAR GOAL_COMMON_* FUNCTIONS ACROSS ALL CHARACTERS:")
    for func, count in all_goal_common_funcs.most_common(15):
        print(f"  {func}: {count}")

    print("\nMOST POPULAR Common_* FUNCTIONS ACROSS ALL CHARACTERS:")
    for func, count in all_common_funcs.most_common(15):
        print(f"  {func}: {count}")

if __name__ == "__main__":
    main()