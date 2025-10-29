#!/usr/bin/env python3
# -*- coding: utf-8 -*-

import re
import os
from collections import defaultdict

def parse_goal_stats():
    """解析GOAL使用统计"""
    goal_stats = {}

    # 从统计文件读取数据
    with open("D:/Sekiro/Sekiro_AI/goal_final_stats.txt", "r", encoding="utf-8") as f:
        for line in f:
            line = line.strip()
            if line and "GOAL_COMMON_" in line:
                parts = line.split()
                if len(parts) >= 2:
                    count = int(parts[0])
                    goal_name = parts[-1].split(":")[-1] if ":" in parts[-1] else parts[-1]
                    goal_stats[goal_name] = count

    return goal_stats

def main():
    print("只狼AI脚本GOAL类型使用情况统计分析")
    print("=" * 80)

    goal_stats = parse_goal_stats()

    # GOAL功能描述和参数信息
    goal_descriptions = {
        "GOAL_COMMON_ComboFinal": {
            "desc": "连击最终攻击",
            "func": "执行连击序列的最后一击攻击",
            "params": [
                ("0", "EzStateID", "动画状态ID"),
                ("1", "攻撃対象", "攻击目标"),
                ("2", "成功距离", "攻击成功判定距离"),
                ("3", "上攻撃角度", "向上攻击角度"),
                ("4", "下攻撃角度", "向下攻击角度")
            ]
        },
        "GOAL_COMMON_AttackTunableSpin": {
            "desc": "可调旋转攻击",
            "func": "执行可以调整旋转时间的攻击动作",
            "params": [
                ("0", "EzStateID", "动画状态ID"),
                ("1", "攻撃対象", "攻击目标"),
                ("2", "成功距离", "攻击成功判定距离"),
                ("3", "攻撃前旋回時間", "攻击前旋转时间"),
                ("4", "正面判定角度", "正面判定角度"),
                ("5", "上攻撃角度", "向上攻击角度"),
                ("6", "下攻撃角度", "向下攻击角度")
            ]
        },
        "GOAL_COMMON_ComboRepeat": {
            "desc": "连击重复攻击",
            "func": "执行可重复的连击攻击动作",
            "params": [
                ("0", "EzStateID", "动画状态ID"),
                ("1", "攻撃対象", "攻击目标"),
                ("2", "成功距离", "攻击成功判定距离"),
                ("3", "上攻撃角度", "向上攻击角度"),
                ("4", "下攻撃角度", "向下攻击角度")
            ]
        },
        "GOAL_COMMON_ComboAttackTunableSpin": {
            "desc": "连击可调旋转攻击",
            "func": "执行带有可调旋转的连击攻击",
            "params": [
                ("0", "EzStateID", "动画状态ID"),
                ("1", "攻撃対象", "攻击目标"),
                ("2", "成功距离", "攻击成功判定距离"),
                ("3", "攻撃前旋回時間", "攻击前旋转时间"),
                ("4", "正面判定角度", "正面判定角度"),
                ("5", "上攻撃角度", "向上攻击角度"),
                ("6", "下攻撃角度", "向下攻击角度")
            ]
        },
        "GOAL_COMMON_SpinStep": {
            "desc": "旋转步法",
            "func": "执行旋转步法动作，用于闪避或重新定位",
            "params": [
                ("0", "EzState番号", "动画状态ID"),
                ("1", "攻撃対象", "目标对象"),
                ("2", "旋转方向", "旋转方向类型"),
                ("3", "距离", "移动距离")
            ]
        },
        "GOAL_COMMON_ApproachTarget": {
            "desc": "接近目标",
            "func": "向指定目标移动接近",
            "params": [
                ("0", "移動対象", "移动目标"),
                ("1", "到達判定距離", "到达判定距离"),
                ("2", "旋回対象", "旋转朝向目标"),
                ("3", "歩く?", "是否步行"),
                ("4", "ガードEzState番号", "防御状态ID")
            ]
        },
        "GOAL_COMMON_SidewayMove": {
            "desc": "侧向移动",
            "func": "向左或右侧向移动",
            "params": [
                ("0", "移動時間", "移动时间"),
                ("1", "目標", "目标对象"),
                ("2", "距離", "移动距离"),
                ("3", "角度", "移动角度"),
                ("4", "是否防御", "移动时是否保持防御")
            ]
        },
        "GOAL_COMMON_EndureAttack": {
            "desc": "忍受攻击",
            "func": "执行忍受伤害的攻击动作，通常是霸体攻击",
            "params": [
                ("0", "攻撃時間", "攻击持续时间"),
                ("1", "EzStateID", "动画状态ID"),
                ("2", "攻撃対象", "攻击目标"),
                ("3", "成功距離", "攻击成功距离")
            ]
        },
        "GOAL_COMMON_Wait": {
            "desc": "等待",
            "func": "AI等待指定时间或条件",
            "params": [
                ("0", "等待時間", "等待时间长度"),
                ("1", "目標", "等待时朝向的目标"),
                ("2", "動畫ID", "等待时播放的动画")
            ]
        },
        "GOAL_COMMON_LeaveTarget": {
            "desc": "远离目标",
            "func": "从目标处后退或远离",
            "params": [
                ("0", "移動時間", "移动时间"),
                ("1", "目標", "远离的目标"),
                ("2", "距離", "远离距离"),
                ("3", "方向目標", "朝向目标"),
                ("4", "是否防御", "移动时是否防御")
            ]
        },
        "GOAL_COMMON_Turn": {
            "desc": "转向",
            "func": "转向面对指定目标或方向",
            "params": [
                ("0", "轉向時間", "转向时间"),
                ("1", "目標", "转向目标"),
                ("2", "角度", "转向角度")
            ]
        },
        "GOAL_COMMON_ApproachSettingDirection": {
            "desc": "设定方向接近",
            "func": "按指定方向接近目标",
            "params": [
                ("0", "目標", "接近目标"),
                ("1", "距離", "接近距离"),
                ("2", "方向", "接近方向"),
                ("3", "時間", "接近时间")
            ]
        }
    }

    print(f"总共发现 {len(goal_stats)} 种不同的GOAL类型")
    print(f"总使用次数: {sum(goal_stats.values())}")
    print()

    print("使用频率最高的GOAL类型 (前20名):")
    print("-" * 80)

    sorted_goals = sorted(goal_stats.items(), key=lambda x: x[1], reverse=True)

    for i, (goal_name, count) in enumerate(sorted_goals[:20], 1):
        print(f"{i:2d}. {goal_name}")
        print(f"    使用次数: {count}")

        if goal_name in goal_descriptions:
            desc_info = goal_descriptions[goal_name]
            print(f"    功能描述: {desc_info['desc']}")
            print(f"    详细功能: {desc_info['func']}")
            print("    参数说明:")
            for param_idx, param_name, param_desc in desc_info['params']:
                print(f"      参数{param_idx}: {param_name} - {param_desc}")
        else:
            print("    功能描述: 待分析")

        print()

    # 按功能分类
    print("\n按功能分类的GOAL统计:")
    print("-" * 80)

    categories = {
        "攻击类": ["Attack", "Combo", "Strike", "Stab", "Guard", "Parry"],
        "移动类": ["Move", "Approach", "Leave", "Side", "Turn", "Step", "Spin"],
        "等待类": ["Wait", "Stay", "Keep"],
        "特殊动作类": ["Jump", "Fall", "Land", "Door", "Ladder", "Item"],
        "团队协作类": ["Team", "Call", "Help"],
        "状态管理类": ["State", "Activate", "Clear", "Set"]
    }

    category_stats = defaultdict(list)

    for goal_name, count in goal_stats.items():
        categorized = False
        for category, keywords in categories.items():
            if any(keyword.lower() in goal_name.lower() for keyword in keywords):
                category_stats[category].append((goal_name, count))
                categorized = True
                break

        if not categorized:
            category_stats["其他"].append((goal_name, count))

    for category, goals in category_stats.items():
        total_count = sum(count for _, count in goals)
        print(f"{category}: {len(goals)}种类型, 总使用{total_count}次")

        # 显示该类别中使用最多的3个
        top_goals = sorted(goals, key=lambda x: x[1], reverse=True)[:3]
        for goal_name, count in top_goals:
            print(f"  - {goal_name}: {count}次")
        print()

    print("分析完成！")

if __name__ == "__main__":
    main()