import csv
from collections import Counter

csv_path = r"D:\BaiduSyncdisk\MyObsidian\游戏设计\只狼\角色AI\弦一郎ATKParam分析\AtkParam_c7100_弦一郎.csv"

with open(csv_path, 'r', encoding='gbk') as f:
    reader = csv.DictReader(f)

    # 统计guardAtkRate的分布
    guard_atk_distribution = Counter()
    attacks_by_rate = {}

    for row in reader:
        rate = int(row['guardAtkRate'])
        guard_atk_distribution[rate] += 1

        if rate not in attacks_by_rate:
            attacks_by_rate[rate] = []

        attacks_by_rate[rate].append({
            'id': row['ID'],
            'name': row['Name'],
            'guardBreakRate': row['guardBreakRate'],
            'atkPhys': row['atkPhys'],
            'dmgLevel': row['dmgLevel']
        })

    print('=' * 120)
    print('弦一郎 guardAtkRate 分布统计')
    print('=' * 120)
    print(f"{'guardAtkRate值':<15} | {'攻击数量':<10}")
    print('-' * 120)

    for rate in sorted(guard_atk_distribution.keys()):
        count = guard_atk_distribution[rate]
        print(f"{rate:<15} | {count:<10}")

    # 显示非30且非100的攻击
    print('\n' + '=' * 120)
    print('guardAtkRate 既不是30也不是100的攻击（特殊攻击）')
    print('=' * 120)

    for rate in sorted(attacks_by_rate.keys()):
        if rate != 30 and rate != 100:
            print(f"\nguardAtkRate = {rate} 的攻击:")
            print('-' * 120)
            for atk in attacks_by_rate[rate][:10]:  # 最多显示10个
                print(f"  {atk['id']:<15} | 物理伤害:{atk['atkPhys']:<4} | 伤害等级:{atk['dmgLevel']:<2} | {atk['name'][:60]}")
