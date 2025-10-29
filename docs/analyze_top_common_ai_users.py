#!/usr/bin/env python3
"""
Analysis of top characters that heavily use common AI logic patterns
Generates detailed CSV reports for characters with high common AI usage
"""

import os
import re
import glob
import csv
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
            with open(filepath, 'r', encoding='shift_jis', errors='ignore') as f:
                content = f.read()
        except:
            return None

    # Extract character ID and map info
    filename = os.path.basename(filepath)
    char_id = filename.replace('_battle.lua', '')
    map_info = os.path.dirname(filepath).split(os.sep)[-5] if len(os.path.dirname(filepath).split(os.sep)) > 4 else "unknown"

    # Count GOAL_COMMON_* functions
    goal_common_pattern = r'GOAL_COMMON_\w+'
    goal_common_matches = re.findall(goal_common_pattern, content)
    goal_common_counts = Counter(goal_common_matches)

    # Count Common_* functions
    common_pattern = r'Common_\w+'
    common_matches = re.findall(common_pattern, content)
    common_counts = Counter(common_matches)

    # Count total lines and functions
    total_lines = len(content.splitlines())

    # Find function definitions
    func_pattern = r'function\s+\w+'
    func_matches = re.findall(func_pattern, content)

    # Analyze attack patterns
    attack_pattern = r'local\s+(\w*[Aa]ct\w*)\s*='
    attack_matches = re.findall(attack_pattern, content)

    return {
        'char_id': char_id,
        'map_area': map_info,
        'filepath': filepath,
        'goal_common_total': sum(goal_common_counts.values()),
        'common_total': sum(common_counts.values()),
        'goal_common_functions': goal_common_counts,
        'common_functions': common_counts,
        'total_common_usage': sum(goal_common_counts.values()) + sum(common_counts.values()),
        'total_lines': total_lines,
        'total_functions': len(func_matches),
        'attack_functions': len(attack_matches),
        'top_goal_functions': goal_common_counts.most_common(3),
        'usage_density': (sum(goal_common_counts.values()) + sum(common_counts.values())) / total_lines * 100 if total_lines > 0 else 0
    }

def generate_detailed_csv():
    """Generate detailed CSV analysis of top common AI users"""
    base_dir = r"D:\Sekiro\Sekiro_AI"
    battle_scripts = find_battle_scripts(base_dir)

    results = []
    char_usage = defaultdict(list)  # Track multiple instances of same character

    for script_path in battle_scripts:
        analysis = analyze_file(script_path)
        if analysis and analysis['total_common_usage'] > 0:
            results.append(analysis)
            char_usage[analysis['char_id']].append(analysis)

    # Sort by total usage and get top characters
    results.sort(key=lambda x: x['total_common_usage'], reverse=True)

    # Create CSV for top 15 characters (excluding duplicates)
    seen_chars = set()
    top_unique_chars = []

    for result in results:
        if result['char_id'] not in seen_chars and len(top_unique_chars) < 15:
            seen_chars.add(result['char_id'])
            top_unique_chars.append(result)

    # Write detailed CSV
    output_file = os.path.join(base_dir, "顶级通用AI使用者详细分析.csv")
    with open(output_file, 'w', newline='', encoding='utf-8-sig') as csvfile:
        writer = csv.writer(csvfile)

        # Header
        writer.writerow([
            '排名', '角色ID', '地图区域', 'GOAL_COMMON使用', 'Common_*使用', '总使用次数',
            '脚本总行数', '函数总数', '攻击函数数', '使用密度%', '主要GOAL函数1', '使用次数1',
            '主要GOAL函数2', '使用次数2', '主要GOAL函数3', '使用次数3', '角色类型推测', '特征描述'
        ])

        # Data rows
        for i, result in enumerate(top_unique_chars, 1):
            char_id = result['char_id']

            # Determine character type based on ID patterns and usage
            char_type = "未知类型"
            char_desc = ""

            if char_id == "508000":
                char_type = "Boss角色"
                char_desc = "鬼庭昌雪，剑技Boss，通用AI使用最多"
            elif char_id.startswith("71"):
                char_type = "精英敌人"
                char_desc = "高级武士类敌人"
            elif char_id.startswith("50"):
                char_type = "标准敌人"
                char_desc = "基础敌人模板"
            elif char_id.startswith("54"):
                char_type = "特殊敌人"
                char_desc = "特殊机制敌人"
            elif char_id.startswith("147"):
                char_type = "通用模板"
                char_desc = "多地图复用的通用敌人"
            elif char_id.startswith("51"):
                char_type = "区域敌人"
                char_desc = "特定区域的敌人类型"

            # Get top 3 functions
            top_funcs = result['top_goal_functions'] + [('', 0)] * 3

            writer.writerow([
                i, char_id, result['map_area'],
                result['goal_common_total'], result['common_total'], result['total_common_usage'],
                result['total_lines'], result['total_functions'], result['attack_functions'],
                f"{result['usage_density']:.2f}",
                top_funcs[0][0] if len(top_funcs) > 0 else '', top_funcs[0][1] if len(top_funcs) > 0 else '',
                top_funcs[1][0] if len(top_funcs) > 1 else '', top_funcs[1][1] if len(top_funcs) > 1 else '',
                top_funcs[2][0] if len(top_funcs) > 2 else '', top_funcs[2][1] if len(top_funcs) > 2 else '',
                char_type, char_desc
            ])

        # Add summary statistics
        writer.writerow([])
        writer.writerow(['统计摘要'])
        writer.writerow(['总分析角色数', len(top_unique_chars)])
        writer.writerow(['平均GOAL_COMMON使用', f"{sum(r['goal_common_total'] for r in top_unique_chars) / len(top_unique_chars):.1f}"])
        writer.writerow(['平均Common_*使用', f"{sum(r['common_total'] for r in top_unique_chars) / len(top_unique_chars):.1f}"])
        writer.writerow(['平均总使用次数', f"{sum(r['total_common_usage'] for r in top_unique_chars) / len(top_unique_chars):.1f}"])

        # Function usage patterns
        all_goal_functions = Counter()
        for result in top_unique_chars:
            all_goal_functions.update(result['goal_common_functions'])

        writer.writerow([])
        writer.writerow(['最常用GOAL_COMMON函数排名'])
        writer.writerow(['函数名', '使用次数', '使用该函数的角色数'])

        for func, total_count in all_goal_functions.most_common(10):
            char_count = sum(1 for r in top_unique_chars if func in r['goal_common_functions'])
            writer.writerow([func, total_count, char_count])

    print(f"Detailed analysis saved to: {output_file}")
    return output_file

if __name__ == "__main__":
    generate_detailed_csv()