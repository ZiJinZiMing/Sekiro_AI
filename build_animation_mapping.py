#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
只狼动画映射分析工具
功能：从c9997.dec.lua中提取Fire事件和动画ID的映射关系
作者：Claude Code
版本：1.0.0
"""

import re
import json
from pathlib import Path
from collections import defaultdict

def parse_anime_id_constants(file_path):
    """解析ANIME_ID常量定义"""
    anime_ids = {}

    with open(file_path, 'r', encoding='utf-8', errors='ignore') as f:
        content = f.read()

    # 匹配模式：ANIME_ID_XXX = 数字
    pattern = r'ANIME_ID_(\w+)\s*=\s*(\d+)'
    matches = re.findall(pattern, content)

    for name, value in matches:
        anime_ids[f'ANIME_ID_{name}'] = int(value)

    return anime_ids

def find_fire_anime_mappings(file_path, anime_ids):
    """查找Fire事件和动画ID的映射关系"""
    mappings = []

    with open(file_path, 'r', encoding='utf-8', errors='ignore') as f:
        lines = f.readlines()

    # 查找Fire调用及其前面的IsExistAnime检查
    for i, line in enumerate(lines):
        # 查找Fire("W_XXX")调用
        fire_match = re.search(r'Fire\("(W_\w+)"\)', line)
        if fire_match:
            fire_event = fire_match.group(1)

            # 向前查找最近的IsExistAnime调用（最多往前看20行）
            anime_id_const = None
            anime_id_value = None
            context_start = max(0, i - 20)

            for j in range(i - 1, context_start, -1):
                # 查找IsExistAnime(ANIME_ID_XXX)
                anime_match = re.search(r'IsExistAnime\((ANIME_ID_\w+)\)', lines[j])
                if anime_match:
                    anime_id_const = anime_match.group(1)
                    anime_id_value = anime_ids.get(anime_id_const)
                    break

            # 记录映射
            mappings.append({
                'fire_event': fire_event,
                'anime_id_const': anime_id_const,
                'anime_id_value': anime_id_value,
                'line_number': i + 1,
                'code_context': line.strip()
            })

    return mappings

def categorize_mappings(mappings):
    """将映射按类别分组"""
    categories = defaultdict(list)

    for m in mappings:
        event_name = m['fire_event']

        # 根据事件名分类
        if 'JustGuard' in event_name:
            category = '弹反动画 (Just Guard)'
        elif 'GuardBreak' in event_name:
            category = '破防动画 (Guard Break)'
        elif 'GuardDamage' in event_name:
            category = '格挡动画 (Guard Damage)'
        elif 'Damage' in event_name:
            category = '受击动画 (Damage)'
        elif 'Death' in event_name:
            category = '死亡动画 (Death)'
        elif 'Trunk' in event_name:
            category = '体干动画 (Trunk Collapse)'
        elif 'Throw' in event_name:
            category = '投技动画 (Throw)'
        elif 'Attack' in event_name:
            category = '攻击动画 (Attack)'
        else:
            category = '其他动画 (Other)'

        categories[category].append(m)

    return categories

def generate_report(categories, output_file):
    """生成映射报告"""
    with open(output_file, 'w', encoding='utf-8') as f:
        f.write("# 只狼动画系统映射报告\n\n")
        f.write("本报告由 build_animation_mapping.py 自动生成\n\n")
        f.write("---\n\n")

        # 按类别输出
        for category, mappings in sorted(categories.items()):
            f.write(f"## {category}\n\n")
            f.write("| Fire事件名 | 动画ID常量 | 动画ID值 | 代码位置 |\n")
            f.write("|-----------|-----------|---------|----------|\n")

            for m in mappings:
                fire_event = m['fire_event']
                const = m['anime_id_const'] or 'N/A'
                value = m['anime_id_value'] or 'N/A'
                line = m['line_number']

                f.write(f"| `{fire_event}` | `{const}` | **{value}** | c9997.dec.lua:{line} |\n")

            f.write("\n")

        # 添加统计信息
        total = sum(len(m) for m in categories.values())
        f.write(f"---\n\n")
        f.write(f"**统计信息：**\n")
        f.write(f"- 总计找到 {total} 个映射关系\n")
        f.write(f"- 分为 {len(categories)} 个类别\n\n")

        # 添加使用说明
        f.write("## 如何使用这个映射表\n\n")
        f.write("1. **在AI脚本中查找Fire调用**\n")
        f.write("   - 例如：`Fire(\"W_JustGuardDamage_RighttoLeft\")`\n\n")
        f.write("2. **在此表中查找对应的动画ID**\n")
        f.write("   - 找到：动画ID 8400\n\n")
        f.write("3. **在chr文件中查找对应的动画文件**\n")
        f.write("   - 文件名：`a00_8400.hkx`\n\n")
        f.write("4. **使用DS Anim Studio打开查看**\n")
        f.write("   - 可以看到实际的动画表现\n\n")

def main():
    # 配置路径
    script_dir = Path(__file__).parent
    c9997_path = script_dir / 'action' / 'c9997.dec.lua'
    output_path = script_dir / 'docs' / '动画映射表.md'

    print("正在分析 c9997.dec.lua...")

    # 1. 解析动画ID常量
    print("  [1/4] 解析 ANIME_ID 常量定义...")
    anime_ids = parse_anime_id_constants(c9997_path)
    print(f"        找到 {len(anime_ids)} 个动画ID定义")

    # 2. 查找Fire映射
    print("  [2/4] 查找 Fire 事件和动画ID的映射...")
    mappings = find_fire_anime_mappings(c9997_path, anime_ids)
    print(f"        找到 {len(mappings)} 个映射关系")

    # 3. 分类
    print("  [3/4] 分类整理...")
    categories = categorize_mappings(mappings)
    print(f"        分为 {len(categories)} 个类别")

    # 4. 生成报告
    print("  [4/4] 生成报告...")
    output_path.parent.mkdir(exist_ok=True)
    generate_report(categories, output_path)
    print(f"        报告已生成：{output_path}")

    # 额外生成JSON格式
    json_path = script_dir / 'docs' / '动画映射表.json'
    with open(json_path, 'w', encoding='utf-8') as f:
        json.dump({
            'anime_ids': {k: v for k, v in anime_ids.items()},
            'categories': {k: v for k, v in categories.items()}
        }, f, ensure_ascii=False, indent=2)
    print(f"        JSON数据已生成：{json_path}")

    print("\n完成！")
    print(f"\n查看报告：{output_path}")

if __name__ == '__main__':
    main()
