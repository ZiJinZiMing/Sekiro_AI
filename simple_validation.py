#!/usr/bin/env python3
# -*- coding: utf-8 -*-

import os
import re
import glob

def has_chinese_chars(text):
    """检查文本中是否包含中文字符"""
    chinese_pattern = re.compile(r'[\u4e00-\u9fff]')
    return bool(chinese_pattern.search(text))

def check_file(file_path):
    """检查单个文件的中文文档状态"""
    try:
        with open(file_path, 'r', encoding='utf-8', errors='ignore') as f:
            content = f.read()
    except:
        try:
            with open(file_path, 'r', encoding='shift-jis', errors='ignore') as f:
                content = f.read()
        except:
            return {'status': 'ERROR', 'chinese_lines': 0, 'has_overview': False, 'has_module_doc': False}

    # 检查中文注释行数
    lines = content.split('\n')
    chinese_lines = 0
    for line in lines:
        if line.strip().startswith('--') and has_chinese_chars(line):
            chinese_lines += 1

    # 检查功能概述
    has_overview = bool(re.search(r'功能概述|Overview|模块概述|Module Overview|功能说明|Description|系统说明|主要功能|Main Functions|核心功能|Core Functions', content, re.IGNORECASE))

    # 检查模块级文档
    has_module_doc = bool(re.search(r'版本信息|Version Info|作者|Author|最后修改|Last Modified|编码格式|Encoding', content))

    # 检查增强标记
    has_enhanced = '-- ■' in content

    # 判断状态
    score = 0
    if has_chinese_chars(content):
        score += 2
    if has_overview:
        score += 2
    if has_module_doc:
        score += 2
    if has_enhanced:
        score += 1
    if chinese_lines >= 10:  # 至少10行中文注释
        score += 1

    if score >= 6:
        status = 'COMPLETE'
    elif score >= 4:
        status = 'BASIC'
    else:
        status = 'NEED_WORK'

    return {
        'status': status,
        'chinese_lines': chinese_lines,
        'has_overview': has_overview,
        'has_module_doc': has_module_doc,
        'has_enhanced': has_enhanced,
        'score': score
    }

def main():
    base_dir = "C:/Sekiro/Sekiro/Sekiro_AI/aicommon-luabnd-dcx/script/ai/out/bin"
    lua_files = glob.glob(os.path.join(base_dir, "*.lua"))
    lua_files.sort()

    print("=== aicommon-luabnd-dcx Chinese Documentation Final Validation ===")
    print(f"Directory: {base_dir}")
    print(f"Total files: {len(lua_files)}")
    print("=" * 70)

    complete_files = []
    basic_files = []
    need_work_files = []

    for i, file_path in enumerate(lua_files, 1):
        filename = os.path.basename(file_path)
        result = check_file(file_path)

        print(f"{i:3d}. [{result['status']:9s}] {filename}")
        print(f"     Score: {result['score']}/8, Chinese lines: {result['chinese_lines']}")

        if result['status'] == 'COMPLETE':
            complete_files.append(filename)
        elif result['status'] == 'BASIC':
            basic_files.append(filename)
        else:
            need_work_files.append(filename)

    print("\n" + "=" * 70)
    print("FINAL STATISTICS")
    print("=" * 70)
    print(f"Total files: {len(lua_files)}")
    print(f"Complete: {len(complete_files)} ({len(complete_files)/len(lua_files)*100:.1f}%)")
    print(f"Basic: {len(basic_files)} ({len(basic_files)/len(lua_files)*100:.1f}%)")
    print(f"Need work: {len(need_work_files)} ({len(need_work_files)/len(lua_files)*100:.1f}%)")

    if complete_files:
        print(f"\n[COMPLETE] Files ({len(complete_files)}):")
        for filename in complete_files:
            print(f"  + {filename}")

    if basic_files:
        print(f"\n[BASIC] Files ({len(basic_files)}):")
        for filename in basic_files:
            print(f"  ~ {filename}")

    if need_work_files:
        print(f"\n[NEED_WORK] Files ({len(need_work_files)}):")
        for filename in need_work_files:
            print(f"  - {filename}")

    print("\n" + "=" * 70)
    if len(complete_files) == len(lua_files):
        print("SUCCESS: All files have complete Chinese documentation!")
    elif len(complete_files) + len(basic_files) == len(lua_files):
        print("GOOD: All files have at least basic Chinese comments.")
    else:
        print(f"WARNING: {len(need_work_files)} files still need Chinese documentation.")

    return len(complete_files), len(basic_files), len(need_work_files)

if __name__ == "__main__":
    main()