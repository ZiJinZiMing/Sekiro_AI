import os
import subprocess

# 替换为你的.exe文件的路径
exe_path = 'D:/Game/Sekiro/DSLuaDecompiler/DSLuaDecompiler/bin/Release/net7.0/DSLuaDecompiler.exe'


current_directory = os.getcwd()

# 从完整路径中提取目录名
directory_name = os.path.basename(current_directory)

# 替换为你要搜索的目录
search_directory = '../../' + directory_name

# 遍历目录
for root, dirs, files in os.walk(search_directory):
    for file in files:
        if file.endswith('.lua'):
            # 构建完整的文件路径
            full_path = os.path.join(root, file)
            
            # 使用这个路径作为参数运行.exe文件
            subprocess.run([exe_path, full_path])



# exe_path = 'DSLuaDecompiler.exe'
# search_directory = 'aicommon-luabnd-dcx'
