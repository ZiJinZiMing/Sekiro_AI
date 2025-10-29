import os
import re

def check_function_body(file_path):
    """检查ActAfter_AdjustSpace函数体是否非空"""
    try:
        with open(file_path, 'r', encoding='utf-8') as f:
            content = f.read()
    except:
        try:
            with open(file_path, 'r', encoding='shift-jis') as f:
                content = f.read()
        except:
            return None

    # 查找ActAfter_AdjustSpace函数
    pattern = r'(function\s+\w*ActAfter_AdjustSpace\s*\([^)]*\)|Goal\.ActAfter_AdjustSpace\s*=\s*function\s*\([^)]*\))'
    matches = list(re.finditer(pattern, content))

    if not matches:
        return None

    non_empty_functions = []

    for match in matches:
        start_pos = match.end()
        # 找到对应的end
        lines = content[start_pos:].split('\n')
        func_body = []
        depth = 1

        for line in lines:
            stripped = line.strip()

            # 跳过空行和纯注释行
            if not stripped or stripped.startswith('--'):
                continue

            # 检查end
            if stripped == 'end' or stripped.startswith('end '):
                depth -= 1
                if depth == 0:
                    break

            # 检查嵌套function
            if 'function' in stripped:
                depth += 1

            # 有实际内容
            func_body.append(line)

        if func_body:
            non_empty_functions.append({
                'match': match.group(0),
                'body_lines': len(func_body),
                'body': '\n'.join(func_body[:5])  # 只显示前5行
            })

    return non_empty_functions if non_empty_functions else None

# 搜索所有battle.lua文件
base_dir = "D:/Sekiro/Sekiro_AI"
non_empty_files = []

for root, dirs, files in os.walk(base_dir):
    for file in files:
        if file.endswith('_battle.lua'):
            file_path = os.path.join(root, file)
            result = check_function_body(file_path)
            if result:
                non_empty_files.append((file_path, result))

# 输出结果
print(f"找到 {len(non_empty_files)} 个包含非空ActAfter_AdjustSpace的文件：\n")
for file_path, functions in non_empty_files:
    rel_path = os.path.relpath(file_path, base_dir)
    print(f"\n{'='*80}")
    print(f"文件: {rel_path}")
    print(f"{'='*80}")
    for idx, func in enumerate(functions, 1):
        print(f"\n函数 {idx}: {func['match']}")
        print(f"内容行数: {func['body_lines']}")
        print(f"前几行内容:\n{func['body']}")
