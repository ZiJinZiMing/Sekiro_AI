#!/usr/bin/env python
# -*- coding: utf-8 -*-
"""
对比分析 c7100（弦一郎） vs c7110（巴流弦一郎）的攻击参数差异
"""

import csv
from collections import Counter

def load_csv(file_path, prefix):
    """加载CSV文件并提取指定前缀的行"""
    encodings = ['gbk', 'utf-8-sig', 'utf-8', 'shift-jis']

    for encoding in encodings:
        try:
            with open(file_path, 'r', encoding=encoding) as f:
                reader = csv.DictReader(f)
                rows = [row for row in reader if row['ID'].startswith(prefix)]
                return rows
        except:
            continue
    return []

def analyze_attribute_distribution(rows, attr_name):
    """分析某个属性的分布"""
    values = [row.get(attr_name, '') for row in rows]
    return Counter(values)

def find_lightning_attacks(rows):
    """查找雷电攻击"""
    lightning = []
    for row in rows:
        sp_attr = row.get('spAttribute', '')
        if sp_attr in ['6', '10']:  # 雷电属性
            lightning.append({
                'ID': row['ID'],
                'Name': row['Name'],
                'spAttribute': sp_attr,
                'atkAttribute': row.get('atkAttribute', ''),
                'traceSfxId0': row.get('traceSfxId0', '')
            })
    return lightning

def compare_trace_sfx(rows):
    """分析剑闪特效使用情况"""
    trace_ids = {}
    for row in rows:
        for i in range(8):
            trace_key = f'traceSfxId{i}'
            trace_val = row.get(trace_key, '')
            if trace_val and trace_val != '-1':
                if trace_val not in trace_ids:
                    trace_ids[trace_val] = 0
                trace_ids[trace_val] += 1
    return trace_ids

def main():
    input_file = r'D:\Sekiro\Sekiro_AI\param\param\AtkParam_Npc.csv'

    print("=" * 60)
    print("弦一郎（c7100） vs 巴流弦一郎（c7110）攻击参数对比分析")
    print("=" * 60)

    # 加载数据
    c7100_rows = load_csv(input_file, '7100')
    c7110_rows = load_csv(input_file, '7110')

    print(f"\nc7100（第一阶段）攻击参数数量: {len(c7100_rows)}")
    print(f"c7110（第二阶段）攻击参数数量: {len(c7110_rows)}")
    print(f"新增攻击数量: {len(c7110_rows) - len(c7100_rows)}")

    # 物理属性分布
    print("\n" + "=" * 60)
    print("【一】物理属性分布 (atkAttribute)")
    print("=" * 60)

    c7100_atk_attr = analyze_attribute_distribution(c7100_rows, 'atkAttribute')
    c7110_atk_attr = analyze_attribute_distribution(c7110_rows, 'atkAttribute')

    print("\nc7100:")
    for val, count in sorted(c7100_atk_attr.items()):
        if val:
            print(f"  {val}: {count}次")

    print("\nc7110:")
    for val, count in sorted(c7110_atk_attr.items()):
        if val:
            print(f"  {val}: {count}次")

    # 特殊属性分布
    print("\n" + "=" * 60)
    print("【二】特殊属性分布 (spAttribute)")
    print("=" * 60)

    c7100_sp_attr = analyze_attribute_distribution(c7100_rows, 'spAttribute')
    c7110_sp_attr = analyze_attribute_distribution(c7110_rows, 'spAttribute')

    print("\nc7100:")
    for val, count in sorted(c7100_sp_attr.items()):
        if val:
            attr_name = "无" if val == '1' else f"特殊属性{val}"
            print(f"  {val} ({attr_name}): {count}次")

    print("\nc7110:")
    for val, count in sorted(c7110_sp_attr.items()):
        if val:
            if val == '1':
                attr_name = "无"
            elif val == '10':
                attr_name = "雷电 (有空中反转)"
            else:
                attr_name = f"特殊属性{val}"
            print(f"  {val} ({attr_name}): {count}次")

    # 雷电攻击详细分析
    print("\n" + "=" * 60)
    print("【三】雷电攻击详细列表 (spAttribute=10)")
    print("=" * 60)

    c7100_lightning = find_lightning_attacks(c7100_rows)
    c7110_lightning = find_lightning_attacks(c7110_rows)

    print(f"\nc7100 雷电攻击数量: {len(c7100_lightning)}")
    print(f"c7110 雷电攻击数量: {len(c7110_lightning)}")

    if c7110_lightning:
        print("\nc7110 雷电攻击清单:")
        for atk in c7110_lightning:
            name_parts = atk['Name'].split(' -- ')
            en_name = name_parts[0] if len(name_parts) > 0 else ''
            jp_name = name_parts[1] if len(name_parts) > 1 else ''
            print(f"  [{atk['ID']}] {jp_name}")
            print(f"    英文: {en_name}")
            print(f"    物理属性: {atk['atkAttribute']}, 剑闪: {atk['traceSfxId0']}")

    # 剑闪特效分析
    print("\n" + "=" * 60)
    print("【四】剑闪特效使用情况")
    print("=" * 60)

    c7100_trace = compare_trace_sfx(c7100_rows)
    c7110_trace = compare_trace_sfx(c7110_rows)

    print("\nc7100 剑闪特效:")
    for trace_id, count in sorted(c7100_trace.items()):
        print(f"  {trace_id}: {count}次")

    print("\nc7110 剑闪特效:")
    for trace_id, count in sorted(c7110_trace.items()):
        print(f"  {trace_id}: {count}次")

    # 攻击类型分布
    print("\n" + "=" * 60)
    print("【五】攻击类型分布 (atkType)")
    print("=" * 60)

    c7100_atk_type = analyze_attribute_distribution(c7100_rows, 'atkType')
    c7110_atk_type = analyze_attribute_distribution(c7110_rows, 'atkType')

    print("\nc7100:")
    for val, count in sorted(c7100_atk_type.items()):
        if val:
            type_name = {
                '0': '武器攻击',
                '1': '肉体/钝器',
                '2': '远程攻击'
            }.get(val, f'类型{val}')
            print(f"  {val} ({type_name}): {count}次")

    print("\nc7110:")
    for val, count in sorted(c7110_atk_type.items()):
        if val:
            type_name = {
                '0': '武器攻击',
                '1': '肉体/钝器',
                '2': '远程攻击'
            }.get(val, f'类型{val}')
            print(f"  {val} ({type_name}): {count}次")

    # 轨迹类型分布
    print("\n" + "=" * 60)
    print("【六】攻击轨迹类型 (trackType)")
    print("=" * 60)

    c7100_track = analyze_attribute_distribution(c7100_rows, 'trackType')
    c7110_track = analyze_attribute_distribution(c7110_rows, 'trackType')

    print("\nc7100:")
    for val, count in sorted(c7100_track.items()):
        if val:
            track_name = {
                '0': '无轨迹',
                '1': '直线',
                '2': '弧形/摆动',
                '6': '特殊',
                '7': '上挑'
            }.get(val, f'轨迹{val}')
            print(f"  {val} ({track_name}): {count}次")

    print("\nc7110:")
    for val, count in sorted(c7110_track.items()):
        if val:
            track_name = {
                '0': '无轨迹',
                '1': '直线',
                '2': '弧形/摆动',
                '6': '特殊',
                '7': '上挑'
            }.get(val, f'轨迹{val}')
            print(f"  {val} ({track_name}): {count}次")

    print("\n" + "=" * 60)
    print("分析完成！")
    print("=" * 60)

if __name__ == '__main__':
    main()
