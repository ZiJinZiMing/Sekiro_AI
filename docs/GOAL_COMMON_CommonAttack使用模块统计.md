# GOAL_COMMON_CommonAttack 使用模块统计报告

**生成日期**: 2026-01-04
**基础文档**: GOAL_COMMON_CommonAttack整参数验证报告.md
**统计范围**: aicommon-luabnd-dcx/script/ai/out/bin/

---

## 参数列表总览

根据参数验证报告，GOAL_COMMON_CommonAttack 的完整参数列表如下：

```lua
GOAL_COMMON_CommonAttack(
    lifetime,              -- [排除] 所有GOAL的第一参数
    ezStateId,             -- [1] ✅ 动画状态ID
    target,                -- [2] ✅ 攻击目标
    successDistance,       -- [3] ✅ 成功距离
    successAngle,          -- [4] ✅ 成功角度
    turnTime,              -- [5] ✅ 旋转时间
    turnFaceAngle,         -- [6] ✅ 正面判定角度
    isComboEnabled,        -- [7] ✅ 是否启用连击链接
    isTurn,                -- [8] ✅ 是否允许转向
    isGuardBreakAttack,    -- [9] ✅ 是否为架势破坏攻击
    isNonspinning,         -- [10] ✅ 是否禁用旋转
    angleUp,               -- [11] ✅ 上攻击角度
    angleDown,             -- [12] ✅ 下攻击角度
    isCancelAttack         -- [13] ✅ 是否允许取消攻击
)
```

---

## 所有使用 GOAL_COMMON_CommonAttack 的模块

### 一、连击系列 (Combo Series)

#### 1. 标准连击系列

| 序号 | 文件名 | GOAL名称 | 参数7<br>isComboEnabled | 更新状态 | 备注 |
|------|--------|----------|------------------------|----------|------|
| 1 | combo_attack.lua | GOAL_COMMON_ComboAttack | true | ⏳待更新 | 标准连击起始 |
| 2 | combo_repeat.lua | GOAL_COMMON_ComboRepeat | true | ✅已更新 | 连击重复段 |
| 3 | combo_final.lua | GOAL_COMMON_ComboFinal | **false** | ✅已更新 | 连击终结段 |

#### 2. 180度广角连击系列

| 序号 | 文件名 | GOAL名称 | 参数7<br>isComboEnabled | 更新状态 | 备注 |
|------|--------|----------|------------------------|----------|------|
| 4 | combo_attack_success_angle180.lua | GOAL_COMMON_ComboAttack180 | true | ⏳待更新 | 广角连击起始 |
| 5 | combo_repeat_success_angle180.lua | GOAL_COMMON_ComboRepeat_SuccessAngle180 | true | ⏳待更新 | 广角连击重复 |
| 6 | combo_tunable_success_angle180.lua | GOAL_COMMON_ComboTunableSuccessAngle180 | true | ⏳待更新 | 广角可调连击 |

#### 3. 旋回连击系列 (Tunable Spin Combo)

| 序号 | 文件名 | GOAL名称 | 参数7<br>isComboEnabled | 更新状态 | 备注 |
|------|--------|----------|------------------------|----------|------|
| 7 | combo_attack_tunable_spin.lua | GOAL_COMMON_ComboAttackTunableSpin | true | ✅已更新 | 可调旋回连击 |

#### 4. 禁旋转连击系列 (Nonspinning Combo)

| 序号 | 文件名 | GOAL名称 | 参数10<br>isNonspinning | 参数7<br>isComboEnabled | 更新状态 | 备注 |
|------|--------|----------|------------------------|------------------------|----------|------|
| 8 | nonspinning_combo_attack.lua | GOAL_COMMON_NonspinningComboAttack | **true** | true | ⏳待更新 | 禁旋转连击起始 |
| 9 | nonspinning_combo_repeat.lua | GOAL_COMMON_NonspinningComboRepeat | **true** | true | ⏳待更新 | 禁旋转连击重复 |
| 10 | nonspinning_combo_final.lua | GOAL_COMMON_NonspinningComboFinal | **true** | **false** | ⏳待更新 | 禁旋转连击终结 |

---

### 二、单次攻击系列 (Single Attack Series)

#### 1. 标准单次攻击

| 序号 | 文件名 | GOAL名称 | 参数7<br>isComboEnabled | 更新状态 | 备注 |
|------|--------|----------|------------------------|----------|------|
| 11 | attack.lua | GOAL_COMMON_Attack | false | ⏳待更新 | 基础攻击 |
| 12 | attack_endure.lua | GOAL_COMMON_EndureAttack | false | ⏳待更新 | 耐久攻击 |
| 13 | attack_immediate_action.lua | GOAL_COMMON_AttackImmediateAction | false | ⏳待更新 | 立即行动攻击 |

#### 2. 特殊控制攻击

| 序号 | 文件名 | GOAL名称 | 参数8<br>isTurn | 参数13<br>isCancelAttack | 更新状态 | 备注 |
|------|--------|----------|----------------|-------------------------|----------|------|
| 14 | attack_non_cancel.lua | GOAL_COMMON_AttackNonCancel | **false** | **false** | ⏳待更新 | 不可取消攻击 |

#### 3. 旋回攻击系列

| 序号 | 文件名 | GOAL名称 | 参数7<br>isComboEnabled | 更新状态 | 备注 |
|------|--------|----------|------------------------|----------|------|
| 15 | attack_tunable_spin.lua | GOAL_COMMON_AttackTunableSpin | false | ⏳待更新 | 可调旋回单次攻击 |

#### 4. 禁旋转攻击

| 序号 | 文件名 | GOAL名称 | 参数10<br>isNonspinning | 更新状态 | 备注 |
|------|--------|----------|------------------------|----------|------|
| 16 | nonspinning_attack.lua | GOAL_COMMON_NonspinningAttack | **true** | ⏳待更新 | 禁旋转单次攻击 |

---

### 三、特殊攻击系列 (Special Attack Series)

#### 1. 架势破坏攻击 (Guard Break)

| 序号 | 文件名 | GOAL名称 | 参数9<br>isGuardBreakAttack | 更新状态 | 备注 |
|------|--------|----------|---------------------------|----------|------|
| 17 | gaurd_break_attack.lua | GOAL_COMMON_GuardBreakAttack | **true** | ⏳待更新 | 架势破坏攻击 |
| 18 | gaurd_break_tunable.lua | GOAL_COMMON_GuardBreakTunable | **true** | ⏳待更新 | 可调架势破坏 |

#### 2. 其他特殊攻击

| 序号 | 文件名 | GOAL名称 | 更新状态 | 备注 |
|------|--------|----------|----------|------|
| 19 | attack_stab_counter.lua | GOAL_COMMON_StabCounterAttack | ⏳待更新 | 刺击反击攻击 |
| 20 | pursuit.lua | GOAL_COMMON_Pursuit | ⏳待更新 | 追击攻击 |

---

## 参数特征分类统计

### 按 isComboEnabled (参数7) 分类

| 类型 | 值 | 数量 | 模块 |
|------|-----|------|------|
| 连击启用 | true | 10 | combo_attack, combo_repeat, combo_attack_success_angle180, combo_repeat_success_angle180, combo_tunable_success_angle180, combo_attack_tunable_spin, nonspinning_combo_attack, nonspinning_combo_repeat |
| 连击终结/单次攻击 | false | 10 | combo_final, nonspinning_combo_final, attack, attack_endure, attack_immediate_action, attack_non_cancel, attack_tunable_spin, nonspinning_attack, gaurd_break_attack, gaurd_break_tunable, attack_stab_counter, pursuit |

### 按 isNonspinning (参数10) 分类

| 类型 | 值 | 数量 | 模块 |
|------|-----|------|------|
| 禁用旋转 | true | 4 | nonspinning_combo_attack, nonspinning_combo_repeat, nonspinning_combo_final, nonspinning_attack |
| 启用旋转 | false | 16 | 所有其他模块 |

### 按 isGuardBreakAttack (参数9) 分类

| 类型 | 值 | 数量 | 模块 |
|------|-----|------|------|
| 架势破坏 | true | 2 | gaurd_break_attack, gaurd_break_tunable |
| 普通攻击 | false | 18 | 所有其他模块 |

### 按 isTurn (参数8) 分类

| 类型 | 值 | 数量 | 模块 |
|------|-----|------|------|
| 允许转向 | true | 19 | 除 attack_non_cancel 外的所有模块 |
| 禁用转向 | false | 1 | attack_non_cancel |

### 按 isCancelAttack (参数13) 分类

| 类型 | 值 | 数量 | 模块 |
|------|-----|------|------|
| 允许取消 | true | 19 | 除 attack_non_cancel 外的所有模块 |
| 禁止取消 | false | 1 | attack_non_cancel |

---

## 更新进度统计

### 总体进度

| 状态 | 数量 | 百分比 | 模块 |
|------|------|--------|------|
| ✅ 已更新 | 3 | 15% | combo_attack_tunable_spin, combo_repeat, combo_final |
| ⏳ 待更新 | 17 | 85% | 其他所有模块 |
| **总计** | **20** | **100%** | - |

### 按系列分类进度

| 系列 | 总数 | 已更新 | 待更新 | 完成度 |
|------|------|--------|--------|--------|
| 连击系列 | 10 | 2 | 8 | 20% |
| 单次攻击系列 | 6 | 0 | 6 | 0% |
| 特殊攻击系列 | 4 | 0 | 4 | 0% |
| **总计** | **20** | **2** | **18** | **10%** |

---

## 后续更新计划

### 优先级1 - 核心连击系列（推荐优先更新）

1. combo_attack.lua - 标准连击起始，使用频率最高
2. combo_attack_success_angle180.lua - 广角连击起始
3. combo_repeat_success_angle180.lua - 广角连击重复

### 优先级2 - 基础攻击系列

4. attack.lua - 最基础的攻击模块
5. attack_endure.lua - 耐久攻击
6. attack_tunable_spin.lua - 可调旋回攻击

### 优先级3 - Nonspinning系列

7. nonspinning_combo_attack.lua
8. nonspinning_combo_repeat.lua
9. nonspinning_combo_final.lua
10. nonspinning_attack.lua

### 优先级4 - 特殊攻击系列

11. gaurd_break_attack.lua
12. gaurd_break_tunable.lua
13. attack_stab_counter.lua
14. attack_immediate_action.lua
15. attack_non_cancel.lua
16. pursuit.lua
17. combo_tunable_success_angle180.lua

---

## 重要发现

### 1. 命名规则与参数的完美对应

根据参数验证报告的发现，模块命名与参数配置存在严格的规律：

- **Combo** 命名 → isComboEnabled = true（除 Final 外）
- **Final** 命名 → isComboEnabled = false
- **Nonspinning** 命名 → isNonspinning = true
- **GuardBreak** 命名 → isGuardBreakAttack = true
- **NonCancel** 命名 → isTurn = false, isCancelAttack = false

### 2. 模块设计模式

所有模块都采用了委托模式（Delegation Pattern）：
- 激活函数负责参数配置
- 实际执行委托给 GOAL_COMMON_CommonAttack
- 简化了代码复用和维护

### 3. 参数可靠性

所有13个参数都已通过以下方式100%确认：
- 日文Debug参数名 (REGISTER_DBG_GOAL_PARAM)
- GOAL命名规则模式匹配
- 多文件交叉验证（8-10个文件）

---

## 技术说明

### 参数说明格式

每个模块更新时应包含以下信息：

1. **完整参数说明**：13个参数的详细说明
2. **参数映射关系**：本模块如何配置这13个参数
3. **本模块特性配置**：关键参数的特殊配置说明
4. **核心参数标记**：用 ★ 标记本模块的核心可调参数

### 参考模板

已更新的三个文件可作为参考模板：
- combo_attack_tunable_spin.lua - 旋回连击的完整注释
- combo_repeat.lua - 重复技的完整注释
- combo_final.lua - 终结技的完整注释

---

**报告生成者**: Claude Code
**最后更新**: 2026-01-04
**文档版本**: v1.0
