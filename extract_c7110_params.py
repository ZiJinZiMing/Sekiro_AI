#!/usr/bin/env python
# -*- coding: utf-8 -*-
"""
提取巴流弦一郎（c7110）的攻击属性和音效/特效参数
"""

import csv
import codecs

# 需要提取的列
columns_to_extract = [
    'ID', 'Name',
    # 十一、攻击属性
    'atkAttribute', 'spAttribute', 'staminaPhysicsAttribute', 'trackType',
    # 12.1 攻击音效/视效
    'atkType', 'atkMaterial_forSfx', 'atkMaterial_forSe', 'atkSize',
    'atkPow_forSfx', 'atkPow_forSe', 'atkDir_forSfx',
    # 12.2 防御音效/视效
    'defSeMaterial1', 'defSeMaterial2', 'defSfxMaterial1', 'defSfxMaterial2',
    # 12.3 剑闪特效（8组）
    'traceSfxId0', 'traceDmyIdHead0', 'traceDmyIdTail0',
    'traceSfxId1', 'traceDmyIdHead1', 'traceDmyIdTail1',
    'traceSfxId2', 'traceDmyIdHead2', 'traceDmyIdTail2',
    'traceSfxId3', 'traceDmyIdHead3', 'traceDmyIdTail3',
    'traceSfxId4', 'traceDmyIdHead4', 'traceDmyIdTail4',
    'traceSfxId5', 'traceDmyIdHead5', 'traceDmyIdTail5',
    'traceSfxId6', 'traceDmyIdHead6', 'traceDmyIdTail6',
    'traceSfxId7', 'traceDmyIdHead7', 'traceDmyIdTail7',
]

input_file = r'D:\Sekiro\Sekiro_AI\param\param\AtkParam_Npc.csv'
output_file = r'D:\Sekiro\Sekiro_AI\param\param\AtkParam_c7110_巴流弦一郎.csv'

def main():
    # 尝试不同的编码
    encodings = ['utf-8-sig', 'utf-8', 'gbk', 'shift-jis']

    data = None
    for encoding in encodings:
        try:
            with open(input_file, 'r', encoding=encoding) as f:
                reader = csv.DictReader(f)
                header = reader.fieldnames

                # 提取7110开头的行
                rows_7110 = []
                for row in reader:
                    if row['ID'].startswith('7110'):
                        rows_7110.append(row)

                data = (header, rows_7110)
                print(f"成功使用 {encoding} 编码读取文件")
                print(f"找到 {len(rows_7110)} 行巴流弦一郎（7110）的攻击参数")
                break
        except Exception as e:
            print(f"尝试 {encoding} 编码失败: {e}")
            continue

    if data is None:
        print("无法读取文件，所有编码尝试失败")
        return

    header, rows_7110 = data

    # 检查所有需要的列是否存在
    missing_cols = [col for col in columns_to_extract if col not in header]
    if missing_cols:
        print(f"警告：以下列在原文件中不存在: {missing_cols}")

    available_cols = [col for col in columns_to_extract if col in header]

    # 写入新的CSV文件
    with open(output_file, 'w', encoding='utf-8-sig', newline='') as f:
        writer = csv.DictWriter(f, fieldnames=available_cols)
        writer.writeheader()

        for row in rows_7110:
            filtered_row = {col: row.get(col, '') for col in available_cols}
            writer.writerow(filtered_row)

    print(f"\n数据已保存到: {output_file}")
    print(f"共提取 {len(available_cols)} 列，{len(rows_7110)} 行数据")

    # 显示前几行作为预览
    if rows_7110:
        print("\n=== 前5行数据预览 ===")
        for i, row in enumerate(rows_7110[:5], 1):
            print(f"\n第{i}行 - ID: {row['ID']}, Name: {row.get('Name', 'N/A')}")
            print(f"  攻击属性: atkAttribute={row.get('atkAttribute', 'N/A')}, spAttribute={row.get('spAttribute', 'N/A')}")
            print(f"  音效视效: atkType={row.get('atkType', 'N/A')}, atkMaterial_forSfx={row.get('atkMaterial_forSfx', 'N/A')}")
            print(f"  剑闪特效: traceSfxId0={row.get('traceSfxId0', 'N/A')}")

if __name__ == '__main__':
    main()
