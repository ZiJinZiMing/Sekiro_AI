#!/usr/bin/env python
# -*- coding: utf-8 -*-

import os
import sys
import codecs
import argparse
from pathlib import Path

# 要处理的文件夹数组
FOLDERS = [
    "aicommon-luabnd-dcx",
    "m25_01_00_00-luabnd-dcx",
    "m25_00_00_00-luabnd-dcx",
    "m20_00_00_00-luabnd-dcx",
    "m17_00_00_00-luabnd-dcx",
    "m15_00_00_00-luabnd-dcx",
    "m13_00_00_00-luabnd-dcx",
    "m12_00_00_00-luabnd-dcx",
    "m11_02_00_00-luabnd-dcx",
    "m11_01_00_00-luabnd-dcx",
    "m11_00_00_00-luabnd-dcx",
    "m10_00_00_00-luabnd-dcx"
]

def detect_encoding(file_path):
    """尝试检测文件的编码"""
    encodings = ['utf-8', 'shift_jis', 'cp932']
    for encoding in encodings:
        try:
            with codecs.open(file_path, 'r', encoding=encoding) as f:
                f.read()
                return encoding
        except UnicodeDecodeError:
            continue
    return None

def remove_bom(file_path):
    """移除文件的BOM标记"""
    # 检测当前编码
    encoding = detect_encoding(file_path)
    
    if encoding is None:
        print(f"无法检测文件编码: {file_path}")
        return False
    
    try:
        # 读取文件内容
        with codecs.open(file_path, 'r', encoding=encoding) as f:
            content = f.read()
        
        # 检查是否有BOM标记
        if not content.startswith('\ufeff'):
            # 如果没有BOM标记，不需要修改
            return False
        
        # 移除BOM标记
        content = content[1:]
        
        # 以相同的编码写回文件
        with codecs.open(file_path, 'w', encoding=encoding) as f:
            f.write(content)
        
        print(f"成功从 {file_path} 移除BOM标记")
        return True
    except Exception as e:
        print(f"处理文件 {file_path} 时出错: {str(e)}")
        return False

def process_directory(directory_path, file_extensions=None):
    """处理目录中的所有文件"""
    if file_extensions is None:
        file_extensions = ['.lua']
    
    count_success = 0
    count_failed = 0
    count_skipped = 0
    count_no_bom = 0
    
    for root, _, files in os.walk(directory_path):
        for file in files:
            file_path = os.path.join(root, file)
            file_ext = os.path.splitext(file)[1].lower()
            
            # 只处理指定扩展名的文件
            if file_extensions and file_ext not in file_extensions:
                count_skipped += 1
                continue
            
            result = remove_bom(file_path)
            if result is True:
                count_success += 1
            elif result is False:
                count_no_bom += 1
            else:
                count_failed += 1
    
    return count_success, count_failed, count_skipped, count_no_bom

def main():
    parser = argparse.ArgumentParser(description='移除文件的BOM标记')
    parser.add_argument('--directories', nargs='*', help='要处理的目录路径（可选，如不指定则使用默认文件夹数组）')
    parser.add_argument('--extensions', help='要处理的文件扩展名（逗号分隔，例如.txt,.lua）')
    
    args = parser.parse_args()
    
    # 确定要处理的目录
    directories = args.directories if args.directories else FOLDERS
    
    # 确定要处理的文件类型
    file_extensions = None
    if args.extensions:
        file_extensions = args.extensions.split(',')
    
    total_success = 0
    total_failed = 0
    total_skipped = 0
    total_no_bom = 0
    
    for directory in directories:
        if not os.path.isdir(directory):
            print(f"错误: {directory} 不是有效的目录，跳过")
            continue
        
        print(f"\n开始处理目录: {directory}")
        success, failed, skipped, no_bom = process_directory(directory, file_extensions)
        
        print(f"目录 {directory} 处理结果:")
        print(f"- 成功移除BOM: {success} 个文件")
        print(f"- 无BOM标记: {no_bom} 个文件")
        print(f"- 处理失败: {failed} 个文件")
        print(f"- 跳过: {skipped} 个文件")
        
        total_success += success
        total_failed += failed
        total_skipped += skipped
        total_no_bom += no_bom
    
    print("\n总处理结果:")
    print(f"- 成功移除BOM: {total_success} 个文件")
    print(f"- 无BOM标记: {total_no_bom} 个文件")
    print(f"- 处理失败: {total_failed} 个文件")
    print(f"- 跳过: {total_skipped} 个文件")
    
    return 0

if __name__ == "__main__":
    sys.exit(main())



