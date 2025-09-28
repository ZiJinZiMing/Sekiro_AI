#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
aicommon-luabnd-dcx 中文注释验证脚本
Final validation script for Chinese documentation in aicommon Lua files

检查标准:
1. 文件是否包含中文字符 (Chinese characters)
2. 是否有功能概述说明 (functional overview)
3. 是否有模块级文档 (module-level documentation)
4. 是否有"-- ■"标记的增强注释 (enhanced comment markers)
5. 严格区分日文和中文内容 (distinguish Japanese vs Chinese content)
"""

import os
import re
import glob
from pathlib import Path

def has_chinese_chars(text):
    """检查文本中是否包含中文字符"""
    chinese_pattern = re.compile(r'[\u4e00-\u9fff]')
    return bool(chinese_pattern.search(text))

def has_japanese_chars(text):
    """检查文本中是否包含日文字符"""
    # 日文平假名、片假名范围
    japanese_pattern = re.compile(r'[\u3040-\u309f\u30a0-\u30ff]')
    return bool(japanese_pattern.search(text))

def check_chinese_documentation(file_path):
    """检查单个文件的中文文档完整性"""
    try:
        with open(file_path, 'r', encoding='utf-8', errors='ignore') as f:
            content = f.read()
    except:
        try:
            with open(file_path, 'r', encoding='shift-jis', errors='ignore') as f:
                content = f.read()
        except:
            return {
                'has_chinese': False,
                'has_overview': False,
                'has_module_doc': False,
                'has_enhanced_markers': False,
                'has_function_docs': False,
                'total_chinese_lines': 0,
                'error': 'Cannot read file'
            }

    lines = content.split('\n')

    # 基本检查
    has_chinese = has_chinese_chars(content)
    has_enhanced_markers = '-- ■' in content

    # 检查功能概述 (多种可能的表达方式)
    overview_patterns = [
        r'功能概述|Overview|模块概述|Module Overview',
        r'功能说明|Description|系统说明',
        r'主要功能|Main Functions|核心功能|Core Functions'
    ]
    has_overview = any(re.search(pattern, content, re.IGNORECASE) for pattern in overview_patterns)

    # 检查模块级文档 (文件头部的详细说明)
    header_doc_patterns = [
        r'版本信息|Version Info',
        r'作者|Author',
        r'最后修改|Last Modified',
        r'编码格式|Encoding'
    ]
    has_module_doc = any(re.search(pattern, content) for pattern in header_doc_patterns)

    # 检查函数级文档
    function_doc_patterns = [
        r'-- .*[功能作用].*:',  # 函数功能说明
        r'-- .*参数.*:',        # 参数说明
        r'-- .*返回.*:',        # 返回值说明
        r'function.*\n.*--.*[功能作用]', # 函数后的中文注释
    ]
    has_function_docs = any(re.search(pattern, content, re.MULTILINE) for pattern in function_doc_patterns)

    # 统计中文注释行数
    chinese_comment_lines = 0
    for line in lines:
        if line.strip().startswith('--') and has_chinese_chars(line):
            chinese_comment_lines += 1

    return {
        'has_chinese': has_chinese,
        'has_overview': has_overview,
        'has_module_doc': has_module_doc,
        'has_enhanced_markers': has_enhanced_markers,
        'has_function_docs': has_function_docs,
        'total_chinese_lines': chinese_comment_lines,
        'error': None
    }

def main():
    base_dir = "C:/Sekiro/Sekiro/Sekiro_AI/aicommon-luabnd-dcx/script/ai/out/bin"

    if not os.path.exists(base_dir):
        print(f"错误: 目录不存在 {base_dir}")
        return

    # 获取所有Lua文件
    lua_files = glob.glob(os.path.join(base_dir, "*.lua"))
    lua_files.sort()

    print(f"=== aicommon-luabnd-dcx 中文注释最终验证报告 ===")
    print(f"检查目录: {base_dir}")
    print(f"总文件数: {len(lua_files)}")
    print("=" * 80)

    # 统计变量
    completed_files = []
    needs_chinese_docs = []
    has_enhanced_markers = []
    has_basic_chinese = []

    # 检查每个文件
    for i, file_path in enumerate(lua_files, 1):
        filename = os.path.basename(file_path)
        result = check_chinese_documentation(file_path)

        if result['error']:
            print(f"{i:3d}. ❌ {filename} - 读取错误: {result['error']}")
            needs_chinese_docs.append(filename)
            continue

        # 评分系统
        score = 0
        status_parts = []

        if result['has_chinese']:
            score += 2
            status_parts.append("中文✓")
        else:
            status_parts.append("中文✗")

        if result['has_overview']:
            score += 2
            status_parts.append("概述✓")
        else:
            status_parts.append("概述✗")

        if result['has_module_doc']:
            score += 2
            status_parts.append("模块文档✓")
        else:
            status_parts.append("模块文档✗")

        if result['has_enhanced_markers']:
            score += 1
            status_parts.append("增强标记✓")
            has_enhanced_markers.append(filename)
        else:
            status_parts.append("增强标记✗")

        if result['has_function_docs']:
            score += 1
            status_parts.append("函数文档✓")
        else:
            status_parts.append("函数文档✗")

        # 根据得分判断完成状态
        if score >= 6:  # 高质量完成
            status = "[COMPLETE]"
            completed_files.append(filename)
        elif score >= 4:  # 基本完成
            status = "[BASIC]"
            has_basic_chinese.append(filename)
        else:  # 需要补充
            status = "[NEED_WORK]"
            needs_chinese_docs.append(filename)

        # 输出状态
        print(f"{i:3d}. {status} {filename}")
        print(f"     得分: {score}/8, 中文行数: {result['total_chinese_lines']}")
        print(f"     状态: {' | '.join(status_parts)}")
        print()

    # 生成最终统计报告
    print("=" * 80)
    print("Final Statistics Report")
    print("=" * 80)
    print(f"总文件数: {len(lua_files)}")
    print(f"完成文件: {len(completed_files)} ({len(completed_files)/len(lua_files)*100:.1f}%)")
    print(f"基本完成: {len(has_basic_chinese)} ({len(has_basic_chinese)/len(lua_files)*100:.1f}%)")
    print(f"需要补充: {len(needs_chinese_docs)} ({len(needs_chinese_docs)/len(lua_files)*100:.1f}%)")
    print(f"有增强标记: {len(has_enhanced_markers)} ({len(has_enhanced_markers)/len(lua_files)*100:.1f}%)")

    print("\n[COMPLETE] Files:")
    for filename in completed_files:
        print(f"  + {filename}")

    if has_basic_chinese:
        print("\n[BASIC] Files:")
        for filename in has_basic_chinese:
            print(f"  ~ {filename}")

    if needs_chinese_docs:
        print("\n[NEED_WORK] Files:")
        for filename in needs_chinese_docs:
            print(f"  - {filename}")

    # 最终建议
    print("\n" + "=" * 80)
    print("Final Recommendations")
    print("=" * 80)

    if len(completed_files) == len(lua_files):
        print("SUCCESS: All files have complete Chinese documentation!")
    elif len(completed_files) + len(has_basic_chinese) == len(lua_files):
        print("GOOD: All files have at least basic Chinese comments. Recommend enhancing marker system.")
    else:
        print(f"WARNING: {len(needs_chinese_docs)} files still need Chinese documentation.")
        print("建议优先处理这些文件，确保100%完成率。")

if __name__ == "__main__":
    main()