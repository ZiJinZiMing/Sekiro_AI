import csv

csv_path = r"D:\BaiduSyncdisk\MyObsidian\游戏设计\只狼\角色AI\弦一郎ATKParam分析\AtkParam_c7100_弦一郎.csv"

with open(csv_path, 'r', encoding='gbk') as f:
    reader = csv.DictReader(f)

    print('=' * 140)
    print('弦一郎 guardAtkRate = 100 的攻击详细分析')
    print('=' * 140)

    for row in reader:
        if row['guardAtkRate'] == '100':
            print(f"\n攻击ID: {row['ID']}")
            print(f"名称: {row['Name']}")
            print(f"guardAtkRate: {row['guardAtkRate']} (弹击攻击力)")
            print(f"guardBreakRate: {row['guardBreakRate']} (弹击防御力)")
            print(f"atkPhys: {row['atkPhys']} (物理攻击力)")
            print(f"atkStam: {row['atkStam']} (体幹攻击力)")
            print(f"atkSuperArmor: {row['atkSuperArmor']} (SA攻击力)")
            print(f"dmgLevel: {row['dmgLevel']} (伤害等级)")
            print(f"throwFlag: {row['throwFlag']} (投技标志)")
            print('-' * 140)
