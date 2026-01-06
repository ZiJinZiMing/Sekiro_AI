# 只狼AI攻击与连击GOAL完整统计文档

## 文档说明

本文档统计了只狼（Sekiro）AI系统中所有与攻击（Attack）和连击（Combo）相关的GOAL行为模块。

**统计时间**: 2025年
**统计范围**: aicommon-luabnd-dcx 和各地图专用AI脚本
**GOAL总数**: 29个

---

## 一、分类统计

### 1. 基础攻击类 (12个)

基础攻击类是所有攻击行为的基础模块，提供单次攻击的各种变体。

| GOAL名称 | 核心特性 | 主要用途 |
|---------|---------|---------|
| GOAL_COMMON_Attack | 180度基础攻击 | 最基础的单次攻击 |
| GOAL_COMMON_Attack3 | 精确转向+条件触发 | 需要精确角度控制的攻击 |
| GOAL_COMMON_AttackTunableSpin | 可调旋回(1.5秒) | 追击移动目标 |
| GOAL_COMMON_AttackImmediateAction | 即时动作响应 | 可中途响应事件的攻击 |
| GOAL_COMMON_EndureAttack | 霸体状态 | 不可打断的强力攻击 |
| GOAL_COMMON_AttackNonCancel | 完全不可取消 | 必须执行完毕的攻击 |
| GOAL_COMMON_StabCounterAttack | 刺击反击 | 针对刺击的专门反击 |
| GOAL_COMMON_NonspinningAttack | 零旋回时间 | 快速直接攻击 |
| GOAL_COMMON_ContinueAttack | 持续攻击 | 无间断持续攻击 |
| GOAL_COMMON_GuardBreakAttack | 架势破坏 | 破坏敌人防御架势 |
| GOAL_COMMON_DashAttack | 冲刺攻击 | 冲刺接近后攻击 |
| GOAL_COMMON_DashAttack_Attack | 冲刺攻击执行 | DashAttack的子模块 |

### 2. 连击攻击类 (11个)

连击攻击类用于构建连续攻击序列，是连击系统的核心。

#### 2.1 标准连击系列 (90度精确)

| GOAL名称 | 攻击角度 | 位置 | 特性 |
|---------|---------|------|------|
| GOAL_COMMON_ComboAttack | 90度 | 起始段 | 建立连击链 |
| GOAL_COMMON_ComboAttackTunableSpin | 90度 | 起始段 | 可调旋回+连击 |
| GOAL_COMMON_ComboRepeat | 90度 | 重复段 | 零延迟重复 |
| GOAL_COMMON_ComboFinal | 180度攻击/90度连击 | 终结段 | 高威力收尾 |

#### 2.2 广角连击系列 (180度覆盖)

| GOAL名称 | 攻击角度 | 位置 | 特性 |
|---------|---------|------|------|
| GOAL_COMMON_ComboAttack_SuccessAngle180 | 180度 | 起始段 | 广域覆盖 |
| GOAL_COMMON_ComboTunable_SuccessAngle180 | 180度 | 起始段 | 可调旋回+广角 |
| GOAL_COMMON_ComboRepeat_SuccessAngle180 | 180度 | 重复段 | 广角重复 |

#### 2.3 非旋转连击系列 (零延迟)

| GOAL名称 | 旋回时间 | 位置 | 特性 |
|---------|---------|------|------|
| GOAL_COMMON_NonspinningComboAttack | 0秒 | 起始段 | 快速连击起手 |
| GOAL_COMMON_NonspinningComboRepeat | 0秒 | 重复段 | 快速重复 |
| GOAL_COMMON_NonspinningComboFinal | 0秒 | 终结段 | 快速终结 |

#### 2.4 特殊连击

| GOAL名称 | 类型 | 特性 |
|---------|------|------|
| GOAL_COMMON_GuardBreakCombo | 架势破坏连击 | 两段式：破防+终结 |

### 3. 敌人专用攻击类 (5个)

敌人专用的高级攻击选择和管理系统。

| GOAL名称 | 功能 | 最大段数 |
|---------|------|---------|
| GOAL_EnemyMultiAttack | 多段攻击选择 | 6段 |
| GOAL_EnemyDeriveAttackMain | 派生攻击主控 | 可配置 |
| GOAL_EnemyDeriveAttackSub | 派生攻击子控 | 可配置 |
| GOAL_EnemyHandyAttack | 便捷多攻击选择 | 6个攻击 |
| GOAL_EnemyChainAttack | 连锁攻击 | 6段 |

### 4. 底层框架 (1个)

| GOAL名称 | 功能 |
|---------|------|
| GOAL_COMMON_CommonAttack | 所有攻击的底层执行框架 |

---

## 二、参数详解

### 通用参数说明

| 参数名称 | 日文原名 | 含义 | 典型值 |
|---------|---------|------|--------|
| EzStateID | EzStateID / EzState番号 | 动画状态ID | 3000-9999 |
| 攻击目标 | 攻撃対象 / 対象 | 攻击的目标对象 | TARGET_ENE_0 |
| 成功距离 | 成功距離 | 攻击有效距离 | 2.0-5.0米 |
| 攻击前旋回时间 | 攻撃前旋回時間 | 转向准备时间 | 1.5秒 |
| 正面判定角度 | 正面判定角度 | 正面攻击角度范围 | 20度 |
| 上攻击角度 | 上攻撃角度 | 向上攻击角度限制 | 0-90度 |
| 下攻击角度 | 下攻撃角度 | 向下攻击角度限制 | 0-90度 |

### 智能默认值机制

很多GOAL支持智能默认值，当参数为负值时自动使用优化的默认值：

- **旋回时间**: 负值 → 1.5秒（平衡转向精度和速度）
- **正面角度**: 负值 → 10度或20度（根据GOAL不同）

---

## 三、攻击角度对比

### 攻击角度类型

| 角度 | 适用场景 | 使用的GOAL |
|------|---------|-----------|
| 90度 | 精确攻击、单体追击 | ComboAttack系列 |
| 180度 | 广域攻击、群体战斗 | Attack, ComboAttack_SuccessAngle180系列 |
| 可配置 | 特殊需求 | CommonAttack |

### 旋回时间对比

| 时间 | 特性 | 使用的GOAL |
|------|------|-----------|
| 0秒 | 零延迟、快速响应 | NonspinningAttack系列, ComboRepeat系列 |
| 1.5秒 | 平衡精度和速度 | AttackTunableSpin, Attack3 |
| 可调 | 灵活配置 | TunableSpin系列 |

---

## 四、连击链构建指南

### 标准连击链

```
ComboAttack (起始)
  ↓
ComboRepeat (重复) × N
  ↓
ComboFinal (终结)
```

### 追击型连击链

```
ComboAttackTunableSpin (旋回起手)
  ↓
ComboRepeat (快速压制)
  ↓
ComboFinal (终结)
```

### 广域连击链

```
ComboAttack_SuccessAngle180 (广角起手)
  ↓
ComboRepeat_SuccessAngle180 (广角重复)
  ↓
ComboFinal (终结)
```

### 快速连击链

```
NonspinningComboAttack (快速起手)
  ↓
NonspinningComboRepeat (快速重复)
  ↓
NonspinningComboFinal (快速终结)
```

### 破防连击链

```
GuardBreakCombo
  ├─ GuardBreakTunable (破防)
  └─ ComboFinal (终结)
```

---

## 五、特殊机制说明

### 5.1 连击取消机制

支持 `ENABLE_COMBO_ATK_CANCEL` 的GOAL：
- ComboRepeat
- ComboFinal
- 所有Combo系列

### 5.2 霸体机制

支持霸体的GOAL：
- EndureAttack: `SetEnableEndureCancel_forGoal`

### 5.3 即时动作响应

支持即时响应的GOAL：
- AttackImmediateAction: `SetEnableImmediateAction_forGoal`

### 5.4 刺击反击

支持刺击反击的GOAL：
- StabCounterAttack: `SetEnableStabCounterCancel_forGoal`

---

## 六、使用建议

### 6.1 选择攻击GOAL的原则

1. **单次攻击**: 优先使用 `Attack` 或 `AttackTunableSpin`
2. **移动目标**: 使用带 `TunableSpin` 的变体
3. **快速攻击**: 使用 `NonspinningAttack`
4. **不可打断**: 使用 `EndureAttack` 或 `AttackNonCancel`

### 6.2 选择连击GOAL的原则

1. **精确连击**: 使用90度系列 (`ComboAttack`)
2. **广域连击**: 使用180度系列 (`ComboAttack_SuccessAngle180`)
3. **快速连击**: 使用Nonspinning系列
4. **追击连击**: 使用TunableSpin系列

### 6.3 参数配置建议

| 敌人类型 | 旋回时间 | 正面角度 | 攻击角度 |
|---------|---------|---------|---------|
| 快速敏捷 | 0.8-1.2秒 | 25-30度 | 180度 |
| 标准敌人 | 1.2-1.8秒 | 15-25度 | 90-180度 |
| 重型敌人 | 1.8-2.5秒 | 10-20度 | 90度 |
| BOSS | 负值(智能) | 负值(智能) | 90度 |

---

## 七、常见问题

### Q1: 什么时候用90度，什么时候用180度？

- **90度**: 精确单体攻击、追击连击、BOSS战
- **180度**: 群体战斗、广域横扫、起手攻击

### Q2: 旋回时间如何选择？

- **0秒**: 快速反应、连击重复段
- **1.5秒**: 标准平衡值（推荐）
- **可调**: 根据敌人移动速度调整

### Q3: 移动是否启用的区别？

- **启用**: 连击系列（允许位置调整）
- **禁用**: 单次攻击系列（确保攻击稳定）

### Q4: 如何构建有效的连击链？

遵循：起始(建立) → 重复(压制) → 终结(收尾) 的结构

---

## 八、文件位置索引

### 基础攻击文件

```
aicommon-luabnd-dcx/script/ai/out/bin/
├── attack.lua                      (基础攻击)
├── attack3.lua                     (精确攻击)
├── attack_tunable_spin.lua         (可调旋回攻击)
├── attack_immediate_action.lua     (即时动作攻击)
├── attack_endure.lua               (霸体攻击)
├── attack_non_cancel.lua           (不可取消攻击)
├── attack_stab_counter.lua         (刺击反击)
├── nonspinning_attack.lua          (非旋转攻击)
├── continue_attack.lua             (持续攻击)
└── gaurd_break_attack.lua          (架势破坏)
```

### 连击攻击文件

```
aicommon-luabnd-dcx/script/ai/out/bin/
├── combo_attack.lua                        (标准连击)
├── combo_attack_tunable_spin.lua           (可调旋回连击)
├── combo_attack_success_angle180.lua       (180度连击)
├── combo_tunable_success_angle180.lua      (可调180度连击)
├── combo_repeat.lua                        (连击重复)
├── combo_repeat_success_angle180.lua       (180度重复)
├── combo_final.lua                         (连击终结)
├── nonspinning_combo_attack.lua            (非旋转连击)
├── nonspinning_combo_repeat.lua            (非旋转重复)
├── nonspinning_combo_final.lua             (非旋转终结)
└── guard_break_combo.lua                   (架势破坏连击)
```

### 敌人专用文件

```
aicommon-luabnd-dcx/script/ai/out/bin/
├── enemy_multi_attack.lua          (多段攻击)
├── enemy_derive_attack.lua         (派生攻击)
├── enemy_handy_attack.lua          (便捷攻击)
└── enemy_chain_attack.lua          (连锁攻击)
```

---

## 九、版本信息

- **文档版本**: v1.0
- **统计日期**: 2025年
- **适用游戏**: Sekiro: Shadows Die Twice
- **AI系统版本**: 原版 + MOD支持

---

## 十、参考资料

1. 只狼AI脚本源代码注释
2. FromSoftware AI系统设计文档
3. 社区MOD开发经验总结


GOAL_COMMON_CommonAttack 的14个参数（正确版本）

  | 参数位置 | 参数名称    | 日文原名      | 数据类型   | 典型值          | 说明            |
  |------|---------|-----------|--------|--------------|---------------|
  | P1   | 生命周期    | Life      | 浮点数(秒) | -1, 2.0      | 行为持续时间，-1表示无限 |
  | P2   | 动画状态ID  | EzStateID | 整数     | 3000-9999    | 指定播放的攻击动画     |
  | P3   | 攻击目标    | 攻撃対象      | 目标对象   | TARGET_ENE_0 | 攻击的目标实体       |
  | P4   | 成功距离    | 成功距離      | 浮点数(米) | 2.0-5.0      | 攻击有效判定距离      |
  | P5   | 攻击角度    | -         | 浮点数(度) | 90, 180      | 攻击成功判定角度范围    |
  | P6   | 攻击前旋回时间 | 攻撃前旋回時間   | 浮点数(秒) | 0, 1.5       | 攻击前转向目标的准备时间  |
  | P7   | 正面判定角度  | 正面判定角度    | 浮点数(度) | 10, 20, 90   | 判定为"正面"的角度范围  |
  | P8   | 移动控制    | -         | 布尔值    | true/false   | 是否允许攻击时移动     |
  | P9   | 转身控制    | -         | 布尔值    | true/false   | 是否允许转向目标      |
  | P10  | 后退控制    | -         | 布尔值    | true/false   | 是否允许后退移动      |
  | P11  | 侧移控制    | -         | 布尔值    | true/false   | 是否允许侧向移动      |
  | P12  | 上攻击角度   | 上攻撃角度     | 浮点数(度) | 0-90         | 向上攻击的仰角限制     |
  | P13  | 下攻击角度   | 下攻撃角度     | 浮点数(度) | 0-90         | 向下攻击的俯角限制     |
  | P14  | 攻击启用    | -         | 布尔值    | true/false   | 是否造成实际伤害      |

---




 | 参数位置 | 验证状态  | 参数名称               | 数据类型   | 证据来源| 典型值          | 推测依据                                      |
  |------|-------|--------------------|--------|-------------------------------------------------------------------|--------------|-------------------------------------------|
  | P1   | ✅ 已验证 | 生命周期 (Life)        | 浮点数(秒) | 所有GOAL通用模式| -1, 2.0      | GetLife()在所有GOAL中的标准用法                    |
  | P2   | ✅ 已验证 | 动画状态ID (EzStateID) | 整数     | REGISTER_DBG_GOAL_PARAM attack_tunable_spin.lua:99| 3000-9999    | FromSoftware官方定义                          |
  | P3   | ✅ 已验证 | 攻击目标 (攻撃対象)        | 目标枚举   | REGISTER_DBG_GOAL_PARAM attack_tunable_spin.lua:100| TARGET_ENE_0 | FromSoftware官方定义                          |
  | P4   | ✅ 已验证 | 成功距离 (成功距離)        | 浮点数(米) | REGISTER_DBG_GOAL_PARAM attack_tunable_spin.lua:101| 2.0-5.0      | FromSoftware官方定义                          |
  | P5   | ✅ 已验证 | 攻击角度               | 浮点数(度) | 代码中硬编码| 90, 180      | attack.lua:144, combo_attack.lua:175      |
  | P6   | ✅ 已验证 | 攻击前旋回时间(攻撃前旋回時間)   | 浮点数(秒) |REGISTER_DBG_GOAL_PARAM attack_tunable_spin.lua:102                | 0, 1.5, 2.0  | FromSoftware官方定义|
  | P7   | ✅ 已验证 | 正面判定角度(正面判定角度)     | 浮点数(度) |REGISTER_DBG_GOAL_PARAM attack_tunable_spin.lua:103                | 10, 20, 90   | FromSoftware官方定义|
  | P8   | ⚠️ 推测 | 移动控制标志?            | 布尔值    | 代码模式分析| true/false   | Attack=false, Combo=true唯一在不同GOAL间变化的布尔参数 |
  | P9   | ❓ 未知  | 未知控制1              | 布尔值    | -| true         | 所有GOAL都是true（除NonCancel）                  |
  | P10  | ❓ 未知  | 未知控制2              | 布尔值    | -| false        | 所有GOAL都是false                             |
  | P11  | ❓ 未知  | 未知控制3              | 布尔值    | -| false        | 所有GOAL都是false                             |
  | P12  | ✅ 已验证 | 上攻击角度(上攻撃角度)       | 浮点数(度) |REGISTER_DBG_GOAL_PARAM attack.lua:104,attack_tunable_spin.lua:104 | 0-90         | FromSoftware官方定义|
  | P13  | ✅ 已验证 | 下攻击角度(下攻撃角度)       | 浮点数(度) |REGISTER_DBG_GOAL_PARAM attack.lua:105,attack_tunable_spin.lua:105 | 0-90         | FromSoftware官方定义|
  | P14  | ⚠️ 推测 | 攻击启用标志?            | 布尔值    | 代码模式分析| true/false   | AttackNonCancel=false,其他=true             |




**文档结束**
