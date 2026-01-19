import csv

csv_path = r"D:\BaiduSyncdisk\MyObsidian\游戏设计\只狼\角色AI\弦一郎ATKParam分析\AtkParam_c7100_弦一郎.csv"

with open(csv_path, 'r', encoding='gbk') as f:
    reader = csv.DictReader(f)

    print('攻击ID          | guardAtkRate | guardBreakRate | 攻击名称')
    print('-' * 100)

    count = 0
    for row in reader:
        if count < 30:
            atk_id = row['ID']
            atk_rate = row['guardAtkRate']
            break_rate = row['guardBreakRate']
            name = row['Name'][:50]
            print(f"{atk_id:15} | {atk_rate:12} | {break_rate:14} | {name}")
            count += 1
        else:
            break

    # 统计数据
    f.seek(0)
    reader = csv.DictReader(f)

    rate_values = []
    break_values = []

    for row in reader:
        try:
            rate_values.append(int(row['guardAtkRate']))
            break_values.append(int(row['guardBreakRate']))
        except:
            pass

    print('\n' + '=' * 100)
    print('统计分析:')
    print(f'guardAtkRate  - 最小值: {min(rate_values)}, 最大值: {max(rate_values)}, 平均值: {sum(rate_values)/len(rate_values):.2f}')
    print(f'guardBreakRate - 最小值: {min(break_values)}, 最大值: {max(break_values)}, 平均值: {sum(break_values)/len(break_values):.2f}')
