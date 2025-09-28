# 只狼AI脚本GOAL类型使用情况详细分析报告

## 概述

通过对只狼AI脚本的全面扫描分析，发现了112种不同的GOAL_COMMON_类型，总使用次数达21,888次。GOAL系统是只狼AI行为的核心组件，控制着敌人的各种行为模式。

## 使用频率最高的GOAL类型（前20名）

### 1. GOAL_COMMON_ComboFinal (3,877次)
**功能**: 连击最终攻击
**作用**: 执行连击序列的最后一击攻击，通常是威力最大的终结技
**参数**:
- 参数0: EzStateID - 动画状态ID
- 参数1: 攻击对象 - 攻击目标
- 参数2: 成功距离 - 攻击成功判定距离
- 参数3: 上攻击角度 - 向上攻击角度
- 参数4: 下攻击角度 - 向下攻击角度

**主要用途**: Boss战和精英敌人的连击终结技

### 2. GOAL_COMMON_AttackTunableSpin (3,185次)
**功能**: 可调旋转攻击
**作用**: 执行可以调整旋转时间的攻击动作，攻击前会转身面向玩家
**参数**:
- 参数0: EzStateID - 动画状态ID
- 参数1: 攻击对象 - 攻击目标
- 参数2: 成功距离 - 攻击成功判定距离
- 参数3: 攻击前旋回时间 - 攻击前旋转时间
- 参数4: 正面判定角度 - 正面判定角度
- 参数5: 上攻击角度 - 向上攻击角度
- 参数6: 下攻击角度 - 向下攻击角度

**主要用途**: 各种敌人的基础攻击动作，可以追踪玩家

### 3. GOAL_COMMON_ComboRepeat (2,183次)
**功能**: 连击重复攻击
**作用**: 执行可重复的连击攻击动作，可以连接到其他连击动作
**参数**:
- 参数0: EzStateID - 动画状态ID
- 参数1: 攻击对象 - 攻击目标
- 参数2: 成功距离 - 攻击成功判定距离
- 参数3: 上攻击角度 - 向上攻击角度
- 参数4: 下攻击角度 - 向下攻击角度

**主要用途**: 连击系统的中间环节，可以循环执行

### 4. GOAL_COMMON_ComboAttackTunableSpin (2,068次)
**功能**: 连击可调旋转攻击
**作用**: 执行带有可调旋转的连击攻击，结合了连击和旋转特性
**参数**:
- 参数0-6: 同AttackTunableSpin

**主要用途**: 高级敌人的连击开始动作

### 5. GOAL_COMMON_SpinStep (1,901次)
**功能**: 旋转步法
**作用**: 执行旋转步法动作，用于闪避或重新定位
**参数**:
- 参数0: EzState番号 - 动画状态ID
- 参数1: 攻击对象 - 目标对象
- 参数2: 旋转方向 - 旋转方向类型
- 参数3: 距离 - 移动距离

**主要用途**: 敌人的闪避和重新定位动作

### 6. GOAL_COMMON_ApproachTarget (1,634次)
**功能**: 接近目标
**作用**: 向指定目标移动接近
**参数**:
- 参数0: 移动对象 - 移动目标
- 参数1: 到达判定距离 - 到达判定距离
- 参数2: 旋回对象 - 旋转朝向目标
- 参数3: 步行? - 是否步行
- 参数4: 防御EzState番号 - 防御状态ID

**主要用途**: 敌人主动接近玩家进行攻击

### 7. GOAL_COMMON_SidewayMove (1,515次)
**功能**: 侧向移动
**作用**: 向左或右侧向移动
**参数**:
- 参数0: 移动时间 - 移动时间
- 参数1: 目标 - 目标对象
- 参数2: 距离 - 移动距离
- 参数3: 角度 - 移动角度
- 参数4: 是否防御 - 移动时是否保持防御

**主要用途**: 敌人的侧向移动和围绕玩家游走

### 8. GOAL_COMMON_EndureAttack (1,412次)
**功能**: 忍受攻击/霸体攻击
**作用**: 执行忍受伤害的攻击动作，通常是霸体攻击
**参数**:
- 参数0: 攻击时间 - 攻击持续时间
- 参数1: EzStateID - 动画状态ID
- 参数2: 攻击对象 - 攻击目标
- 参数3: 成功距离 - 攻击成功距离

**主要用途**: Boss和强力敌人的不可打断攻击

### 9. GOAL_COMMON_Wait (970次)
**功能**: 等待
**作用**: AI等待指定时间或条件
**参数**:
- 参数0: 等待时间 - 等待时间长度
- 参数1: 目标 - 等待时朝向的目标
- 参数2: 动画ID - 等待时播放的动画

**主要用途**: 攻击间隙的等待和观察

### 10. GOAL_COMMON_LeaveTarget (796次)
**功能**: 远离目标
**作用**: 从目标处后退或远离
**参数**:
- 参数0: 移动时间 - 移动时间
- 参数1: 目标 - 远离的目标
- 参数2: 距离 - 远离距离
- 参数3: 方向目标 - 朝向目标
- 参数4: 是否防御 - 移动时是否防御

**主要用途**: 敌人的后退和拉开距离

### 11-20. 其他高频GOAL
- GOAL_COMMON_Turn (553次) - 转向
- GOAL_COMMON_ApproachSettingDirection (433次) - 设定方向接近
- GOAL_COMMON_ComboTunable_SuccessAngle180 (243次) - 180度成功角度连击
- GOAL_COMMON_ComboRepeat_SuccessAngle180 (237次) - 180度成功角度重复连击
- GOAL_COMMON_AttackImmediateAction (123次) - 即时攻击动作
- GOAL_COMMON_WaitWithAnime (59次) - 带动画等待
- GOAL_COMMON_Attack (51次) - 基础攻击
- GOAL_COMMON_Guard (48次) - 防御
- GOAL_COMMON_ToTargetWarp (33次) - 传送到目标
- GOAL_COMMON_MoveToSomewhere (31次) - 移动到某处

## 按功能分类统计

### 攻击类GOAL (30种，13,601次使用)
这是最重要的GOAL类别，包含所有与攻击相关的行为：
- 基础攻击: Attack, AttackTunableSpin
- 连击攻击: ComboAttack, ComboRepeat, ComboFinal
- 特殊攻击: EndureAttack, StabCounterAttack, GuardBreakAttack
- 防御相关: Guard, Parry, GuardBreakCombo

**关键特点**: 攻击类GOAL占总使用量的62%，是AI行为的核心

### 移动类GOAL (38种，6,997次使用)
控制敌人的各种移动行为：
- 接近移动: ApproachTarget, ApproachSettingDirection
- 回避移动: LeaveTarget, SidewayMove, SpinStep
- 转向: Turn, TurnAround, SpecialTurn
- 特殊移动: Fall, Landing, LadderAct

**关键特点**: 移动类GOAL占总使用量的32%，确保敌人能够灵活定位

### 等待类GOAL (8种，1,069次使用)
用于控制AI的等待和观察行为：
- Wait, WaitWithAnime, Stay, KeepDist

**关键特点**: 提供攻击间隙和行为节奏控制

### 状态管理类GOAL (7种，41次使用)
管理AI的内部状态：
- ClearTarget, SetTimerRealtime, SetNumberRealtime

### 其他类别
- 特殊动作类: 如LadderAct, UseItem, DoorAct
- 团队协作类: TeamCallHelp, TeamReplyHelp
- 各种辅助功能

## 重要发现和分析

### 1. 连击系统的核心地位
连击相关的GOAL（ComboFinal, ComboRepeat, ComboAttackTunableSpin）总计使用8,128次，占总数的37%，说明只狼的AI系统高度依赖连击机制。

### 2. 可调旋转攻击的普遍性
AttackTunableSpin和ComboAttackTunableSpin合计使用5,253次，说明只狼AI具有强大的玩家追踪能力。

### 3. 移动和定位的重要性
各种移动相关的GOAL使用频率很高，体现了只狼战斗中位置和距离控制的重要性。

### 4. 霸体攻击的广泛应用
EndureAttack使用1,412次，说明只狼中存在大量不可打断的强力攻击。

## 技术实现特点

### 参数化设计
每个GOAL都采用参数化设计，可以通过调整参数来改变行为：
- EzStateID控制动画
- 距离参数控制作用范围
- 角度参数控制方向判定
- 时间参数控制持续时间

### 层次化结构
GOAL系统采用层次化结构：
- Top层GOAL控制整体行为模式
- Sub层GOAL执行具体动作
- 可以动态添加和移除SubGoal

### 状态管理
通过GOAL_RESULT返回值管理状态：
- Success: 成功完成
- Continue: 继续执行
- Failed: 执行失败

## 结论

只狼的AI系统通过112种精细化的GOAL类型实现了复杂而流畅的敌人行为。攻击类GOAL占主导地位，移动类GOAL提供灵活性，等待类GOAL控制节奏。这种设计使得只狼的敌人AI表现出高度的智能性和战斗挑战性。

连击系统、可调旋转攻击和霸体攻击是只狼AI的三大核心特色，这些机制共同构成了只狼独特的战斗体验。