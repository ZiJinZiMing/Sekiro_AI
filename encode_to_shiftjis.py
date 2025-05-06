#!/usr/bin/env python
# -*- coding: utf-8 -*-

import os
import sys
import codecs
import argparse
import shutil
from pathlib import Path

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

def convert_file(file_path, target_encoding='shift_jis'):
    """将文件从UTF-8转换为目标编码"""
    # 检测当前编码
    current_encoding = detect_encoding(file_path)
    
    if current_encoding is None:
        print(f"无法检测文件编码: {file_path}")
        return False
    
    if current_encoding == target_encoding:
        print(f"文件已经是{target_encoding}编码: {file_path}")
        return True
    
    try:
        # 读取文件内容
        with codecs.open(file_path, 'r', encoding=current_encoding) as f:
            content = f.read()
        
        # 写入新编码
        with codecs.open(file_path, 'w', encoding=target_encoding) as f:
            f.write(content)
        
        print(f"成功将 {file_path} 从 {current_encoding} 转换为 {target_encoding}")
        return True
    except Exception as e:
        print(f"转换 {file_path} 时出错: {str(e)}")
        return False

def copy_directory(src_dir, dst_dir):
    """将源目录复制到目标目录"""
    try:
        # 如果目标目录已存在，先删除
        if os.path.exists(dst_dir):
            shutil.rmtree(dst_dir)
        
        # 复制整个目录
        shutil.copytree(src_dir, dst_dir)
        print(f"成功将 {src_dir} 复制到 {dst_dir}")
        return True
    except Exception as e:
        print(f"复制目录时出错: {str(e)}")
        return False

def process_directory(directory_path, target_encoding='shift_jis', file_extensions=None):
    """处理目录中的所有文件"""
    if file_extensions is None:
        file_extensions = ['.txt','.lua', '.csv', '.html', '.xml', '.json', '.js', '.css', '.py']
    
    count_success = 0
    count_failed = 0
    count_skipped = 0
    
    for root, _, files in os.walk(directory_path):
        for file in files:
            file_path = os.path.join(root, file)
            file_ext = os.path.splitext(file)[1].lower()
            
            # 只处理指定扩展名的文件
            if file_extensions and file_ext not in file_extensions:
                count_skipped += 1
                continue
            
            if convert_file(file_path, target_encoding):
                count_success += 1
            else:
                count_failed += 1
    
    return count_success, count_failed, count_skipped

def main():
    parser = argparse.ArgumentParser(description='将文件从UTF-8转换为Shift-JIS编码')
    parser.add_argument('directory', help='要处理的目录路径')
    parser.add_argument('--output', default='output', help='输出目录路径（默认为当前目录下的output文件夹）')
    parser.add_argument('--extensions', help='要处理的文件扩展名（逗号分隔，例如.txt,.html）')
    parser.add_argument('--encoding', default='shift_jis', help='目标编码（默认为shift_jis）')
    
    args = parser.parse_args()
    
    source_directory = args.directory
    if not os.path.isdir(source_directory):
        print(f"错误: {source_directory} 不是有效的目录")
        return 1
    
    # 确定输出目录路径
    output_directory = args.output
    if not os.path.isabs(output_directory):
        # 如果output_directory不是绝对路径，则将其视为相对于当前工作目录的路径
        output_directory = os.path.join(os.getcwd(), output_directory)
    
    # 复制源目录到输出目录
    print(f"正在复制源目录 {source_directory} 到输出目录 {output_directory}...")
    if not copy_directory(source_directory, output_directory):
        print("复制目录失败，程序退出")
        return 1
    
    target_encoding = args.encoding
    
    file_extensions = None
    if args.extensions:
        file_extensions = args.extensions.split(',')
    
    print(f"\n开始处理输出目录: {output_directory}")
    print(f"目标编码: {target_encoding}")
    if file_extensions:
        print(f"处理文件类型: {', '.join(file_extensions)}")
    
    success, failed, skipped = process_directory(output_directory, target_encoding, file_extensions)
    
    print("\n转换完成:")
    print(f"- 成功: {success} 个文件")
    print(f"- 失败: {failed} 个文件")
    print(f"- 跳过: {skipped} 个文件")
    
    return 0

if __name__ == "__main__":
    sys.exit(ma