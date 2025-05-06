import os
import subprocess
import shutil
import sys
from pathlib import Path
import codecs


def clear_directory(directory):
    """ 清空指定的文件夹 """
    for filename in os.listdir(directory):
        file_path = os.path.join(directory, filename)
        try:
            if os.path.isfile(file_path) or os.path.islink(file_path):
                os.unlink(file_path)
            elif os.path.isdir(file_path):
                shutil.rmtree(file_path)
        except Exception as e:
            print(f"Failed to delete {file_path}. Reason: {e}")



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
        
        # 移除UTF-8 BOM标记（如果存在）
        if content.startswith('\ufeff'):
            content = content[1:]
            print(f"从文件 {file_path} 中移除了BOM标记")

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
        # 获取源目录的名称
        src_dir_name = os.path.basename(os.path.normpath(src_dir))
        
        # 创建输出目录（如果不存在）
        if not os.path.exists(dst_dir):
            os.makedirs(dst_dir)
        
        # 构建目标子目录路径
        target_subdir = os.path.join(dst_dir, src_dir_name)
        
        # 如果目标子目录已存在，先删除
        if os.path.exists(target_subdir):
            shutil.rmtree(target_subdir)
        
        # 复制整个目录到目标子目录
        shutil.copytree(src_dir, target_subdir)
        print(f"成功将 {src_dir} 复制到 {target_subdir}")
        return target_subdir
    except Exception as e:
        print(f"复制目录时出错: {str(e)}")
        return False


def process_directory(directory_path, target_encoding='shift_jis', file_extensions=None):
    """处理目录中的所有文件"""
    if file_extensions is None:
        file_extensions = ['.lua']
    
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

    # 示例名称数组
    #
    names = ["aicommon","m10_00_00_00", "m11_00_00_00", "m11_01_00_00", "m11_02_00_00", "m12_00_00_00", "m13_00_00_00", "m15_00_00_00", "m17_00_00_00", "m20_00_00_00", "m25_00_00_00", "m25_01_00_00"]  # 这里应替换为您的名称数组
    # names = ["m11_00_00_00"]  # 这里应替换为您的名称数组
    # names = ["m11_02_00_00"]  # 这里应替换为您的名称数组
    # names = ["m11_01_00_00"]  # 永真、弦一郎
    # names = ["m11_02_00_00"]  # 剑圣一心
    # names = ["m17_00_00_00"]  # 狮子猿
    current_directory = os.getcwd()
    Yabber_exe = "./Yabber/Yabber.exe"  # 替换为外部程序的路径
    # Yabber_exe = "D:/Game/Sekiro/WitchyBND-v2.6.2.1/WitchyBND.exe"  # 替换为外部程序的路径
    destination_directory = "D:/SteamLibrary/steamapps/common/Sekiro/mods/script"  # 替换为目标文件夹的路径

    # 清空目标文件夹
    clear_directory(destination_directory)

    for name in names:

        
        source_dir_path = os.path.join(current_directory, name + "-luabnd-dcx")


        source_directory = source_dir_path
        
        # 确定输出目录路径
        output_directory =os.path.join(current_directory, "output")
        
        # 复制源目录到输出目录，包括顶级目录
        print(f"正在复制源目录 {source_directory} 到输出目录 {output_directory}...")
        copied_dir = copy_directory(source_directory, output_directory)
        if not copied_dir:
            print("复制目录失败，程序退出")
            return 1
        
        target_encoding = 'shift_jis'

        print(f"\n开始处理输出目录: {copied_dir}")
        print(f"目标编码: {target_encoding}")
        
        success, failed, skipped = process_directory(copied_dir, target_encoding, ['.lua'])

        # 执行外部程序
        subprocess.run([Yabber_exe, copied_dir])

        # 生成的文件路径
        generated_file = os.path.join(output_directory, f"{name}.luabnd.dcx")

        # 检查文件是否存在并移动
        if os.path.exists(generated_file):
            shutil.move(generated_file, destination_directory)
            print(f"Moved '{generated_file}' to '{destination_directory}'")
        else:
            print(f"File '{generated_file}' not found after execution.")

    return 0


if __name__ == "__main__":
    sys.exit(main())
