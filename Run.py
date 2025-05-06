import os

def convert_encoding(directory, source_encodings, target_encoding):
    for root, dirs, files in os.walk(directory):
        for file in files:
            if file.endswith('.lua'):
                file_path = os.path.join(root, file)

                content = None
                for encoding in source_encodings:
                    try:
                        # 尝试使用不同的编码格式读取文件
                        with open(file_path, 'r', encoding=encoding) as file:
                            content = file.read()
                        break
                    except UnicodeDecodeError:
                        pass
                
                if content is not None:
                    # 以新的编码格式保存文件
                    with open(file_path, 'w', encoding=target_encoding, errors='ignore') as file:
                        file.write(content)
                    print(f"Converted {file_path} to {target_encoding}")
                else:
                    print(f"Failed to read {file_path} with provided encodings.")

# 当前目录
current_directory = os.getcwd()

# 尝试的源编码格式
source_encodings = ['utf-8','shift_jis']

# 目标编码
target_encoding = 'utf-8'

# 转换编码
convert_encoding(current_directory, source_encodings, target_encoding)
