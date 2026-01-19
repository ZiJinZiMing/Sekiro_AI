import csv

csv_path = r"D:\BaiduSyncdisk\MyObsidian\游戏设计\只狼\角色AI\弦一郎ATKParam分析\AtkParam_c7100_弦一郎.csv"

with open(csv_path, 'r', encoding='gbk') as f:
    reader = csv.DictReader(f)

    print('=' * 120)
    print('弦一郎 guardAtkRate = 100 的攻击')
    print('=' * 120)
    print(f"{'攻击ID':<15} | {'guardAtkRate':<12} | {'guardBreakRate':<14} | {'攻击名称':<60}")
    print('-' * 120)

    count = 0
    for row in reader:
        if row['guardAtkRate'] == '100':
            atk_id = row['ID']
            atk_rate = row['guardAtkRate']
            break_rate = row['guardBreakRate']
            name = row['Name']
            print(f"{atk_id:<15} | {atk_rate:<12} | {break_rate:<14} | {name:<60}")
            count += 1

    print('-' * 120)
    print(f'共找到 {count} 个 guardAtkRate=100 的攻击')
