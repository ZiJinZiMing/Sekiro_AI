# Sekiro AI 通用行为模块与组织规则文档

## 概述

本文档详细描述了Sekiro AI系统中的通用行为模块和组织规则。这些模块采用参数化设计，通过传入不同参数实现行为定制，支持完整的生命周期管理和嵌套子目标系统。

## 通用行为模块表格

| 类别 | 功能名称 | 所在文件 | 功能描述 | 解释说明 |
|------|----------|----------|----------|----------|
| **核心组织规则** | `Common_Clear_Param()` | `common_battle_func.lua` | 清理行为参数数组 | 初始化50个行为参数槽位，清空权重和子目标配置 |
| | `Common_Battle_Activate()` | `common_battle_func.lua` | 战斗行为激活器 | 核心调度器，根据权重表选择执行对应的Act01-Act50函数 |
| | `Common_ActivateAct()` | `common_func_NTC.lua` | 通用行为激活器 | 处理特殊效果和状态检查，决定是否激活特定行为 |
| **状态查询** | `_COMMON_GetEzStateAnimId()` | `common_func.lua` | 获取动画状态ID | 批量获取30个动画状态ID，用于动画切换判断 |
| | `_COMMON_GetMinDist()/GetMaxDist()` | `common_func.lua` | 获取攻击距离范围 | 获取各个攻击动作的最小/最大有效距离 |
| | `_COMMON_GetAtkDistType()` | `common_func.lua` | 获取攻击距离类型 | 将数值转换为距离类型：近距离/中距离/远距离/超出范围 |
| **基础攻击** | `GOAL_COMMON_Attack` | `attack.lua` | 基本攻击行为 | 执行单次攻击，包含攻击角度和成功距离判定 |
| | `GOAL_COMMON_AttackTunableSpin` | `attack_tunable_spin.lua` | 可调节旋转攻击 | 带有旋转参数的攻击，可调节旋转角度和速度 |
| | `GOAL_COMMON_AttackEndure` | `attack_endure.lua` | 耐久攻击 | 承受伤害状态下的强制攻击行为 |
| **连击系统** | `GOAL_COMMON_ComboAttack` | `combo_attack.lua` | 连击攻击起始 | 连击序列的第一段，设定连击成功角度 |
| | `GOAL_COMMON_ComboRepeat` | `combo_repeat.lua` | 连击重复段 | 连击序列的中间段，可重复执行 |
| | `GOAL_COMMON_ComboFinal` | `combo_final.lua` | 连击终结段 | 连击序列的最后一段，通常威力更大 |
| | `GOAL_COMMON_ComboAttackTunableSpin` | `combo_attack_tunable_spin.lua` | 旋转连击攻击 | 带旋转效果的连击起始段 |
| **移动行为** | `GOAL_COMMON_ApproachTarget` | `approach_target.lua` | 接近目标 | 向指定目标移动，包含距离判定和移动方式 |
| | `GOAL_COMMON_ApproachSettingDirection` | `approach_setting_direction.lua` | 定向接近 | 从特定方向接近目标，用于战术定位 |
| | `GOAL_COMMON_SidewayMove` | `flexible_sideway.lua` | 侧向移动 | 左右横向移动，保持与目标距离 |
| | `GOAL_COMMON_Turn` | `turn.lua` | 转向行为 | 朝向指定目标或角度转身 |
| | `GOAL_COMMON_Step` | `step.lua` | 步伐调整 | 小幅度位置调整，用于精确定位 |
| **防御反应** | `Common_Parry()` | `common_func_NTC.lua` | 招架系统 | 处理招架时机和反击逻辑 |
| | `GOAL_COMMON_EndureAttack` | - | 承受攻击 | 在无法闪避时承受攻击的行为 |
| **团队协作** | 呼叫援助系统 | `team_call_help.lua` | 呼叫队友 | 向周围队友发送援助请求 |
| | 响应援助系统 | `team_reply_help.lua` | 响应援助 | 接收并响应队友的援助请求 |
| **状态控制** | `GOAL_COMMON_Wait` | `wait_with_anime.lua` | 等待行为 | 带动画的等待状态，可设定等待时间 |
| | 傀儡行为 | `kugutsu_act.lua` | 傀儡状态 | 被傀儡术控制时的特殊行为逻辑 |
| | 梯子动作 | `ladder_act.lua` | 梯子交互 | 攀爬梯子的专用行为模块 |

## 架构特点

### 1. 参数化设计
- 所有行为模块通过参数传递进行定制
- 支持动态调整攻击距离、角度、速度等属性
- 统一的参数获取接口：`GetParam(index)`

### 2. 生命周期管理
每个行为模块都包含完整的生命周期函数：
- `Activate()` - 行为激活时调用
- `Update()` - 每帧更新时调用
- `Terminate()` - 行为结束时调用
- `Interrupt()` - 行为被中断时调用

### 3. 嵌套子目标系统
- 通过 `AddSubGoal()` 支持行为的层次化组合
- 允许复杂行为由多个简单行为组成
- 支持条件分支和序列执行

### 4. 权重驱动选择
- `Common_Battle_Activate()` 根据权重表选择行为
- 支持动态权重调整，实现智能行为切换
- 最多支持50个并发行为槽位

## 使用示例

### 基本攻击示例
```lua
-- 在角色专有AI脚本中调用通用攻击
f1_arg1:AddSubGoal(GOAL_COMMON_Attack, 10, 3000, TARGET_ENE_0, 3.5, 0, 0)
-- 参数说明：生命周期=10, 攻击ID=3000, 目标=敌人0, 成功距离=3.5
```

### 连击序列示例
```lua
-- 连击攻击序列
f1_arg1:AddSubGoal(GOAL_COMMON_ComboAttackTunableSpin, 10, 3000, TARGET_ENE_0, 3.5, 0, 0, 0, 0)
f1_arg1:AddSubGoal(GOAL_COMMON_ComboRepeat, 10, 3001, TARGET_ENE_0, 3.4, 0)
f1_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3002, TARGET_ENE_0, 9999, 0, 0)
```

### 接近目标示例
```lua
-- 接近目标后执行攻击
Approach_Act_Flex(f1_arg0, f1_arg1, 3.0, 4.0, 5.0, 100, 0, 2.5, 3)
-- 参数说明：最小距离=3.0, 中等距离=4.0, 最大距离=5.0, 权重=100
```

## 已添加注释的文件

以下核心文件已添加详细的中英文注释：
1. `common_battle_func.lua` - 核心战斗行为组织器
2. `attack.lua` - 基础攻击行为
3. `approach_target.lua` - 接近目标行为
4. `combo_attack.lua` - 连击攻击行为

## 文件位置

所有通用行为模块位于：
```
D:\Sekiro\Sekiro_AI\aicommon-luabnd-dcx\script\ai\out\bin\
```

角色专有AI脚本位于各地图目录：
```
D:\Sekiro\Sekiro_AI\m##_##_##_##-luabnd-dcx\script\ai\out\bin\
```

---

*文档创建时间：2025-09-26*
*项目：Sekiro AI Modding*