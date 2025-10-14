--[[============================================================================
    guard_break_combo.lua - Sekiro架势破坏连击系统
    (Guard Break Combo System)

    版本信息 (Version Info): v3.0 - Professional documentation
    作者 (Author): FromSoftware AI Team / Enhanced by Claude Code
    编码格式 (Encoding): Shift-JIS (required for Sekiro compatibility)

    ============================================================================
    模块概述 (Module Overview):
    ============================================================================
    这是Sekiro AI系统的架势破坏连击模块,实现了两段式架势破坏攻击组合。
    该模块将架势破坏攻击和终结技结合,形成完整的破防连击序列,专门用于
    突破玩家防御并造成大量架势伤害。

    核心功能 (Core Functions):
    ┌─ 两段式架势破坏连击 (Two-Stage Guard Break Combo)
    │  ├─ 第一段: 架势破坏攻击 (GuardBreakTunable)
    │  │  └─ 目的: 破坏敌人防御姿态
    │  ├─ 第二段: 连击终结技 (ComboFinal)
    │  │  └─ 目的: 趁架势破坏之机造成高伤害
    │  └─ 连击流畅性: 使用子目标链确保无缝衔接
    │
    ├─ 战术意义 (Tactical Significance)
    │  ├─ 破防组合: 专门针对防御型玩家
    │  ├─ 架势压制: 快速积累玩家架势伤害
    │  ├─ 威胁升级: 比单一攻击更具压迫感
    │  └─ 节奏控制: 通过连击控制战斗节奏
    │
    └─ 参数配置特点 (Parameter Configuration Features)
       ├─ 第一段参数: 旋转时间、角度判定
       ├─ 第二段参数: 成功距离专门配置
       ├─ 固定生命周期: 两段均为10秒
       └─ 角度约束: 支持自定义上下攻击角度

    ============================================================================
    连击设计原理 (Combo Design Principles):
    ============================================================================

    两段式架势破坏流程 (Two-Stage Guard Break Flow):
    1. GuardBreakTunable执行
       - 破坏敌人的防御架势
       - 强制敌人进入硬直状态
       - 为第二段攻击创造机会

    2. ComboFinal执行
       - 利用架势破坏后的硬直
       - 造成高伤害终结攻击
       - 完成整个破防组合

    参数分配策略 (Parameter Distribution Strategy):
    - 第一段使用旋转和角度参数 → 确保破防命中
    - 第二段使用成功距离参数 → 控制终结技射程
    - 统一目标参数 → 保证攻击连贯性

    ============================================================================
]]--

-- 注册架势破坏连击行为的Goal系统
-- (Register guard break combo behavior in Goal system)
RegisterTableGoal(GOAL_COMMON_GuardBreakCombo, "GuardBreakCombo")
REGISTER_GOAL_NO_SUB_GOAL(GOAL_COMMON_GuardBreakCombo, true)

-- 调试参数注册 (Debug parameter registration)
-- 这些参数支持开发阶段的连击调优和运行时的行为监控
REGISTER_DBG_GOAL_PARAM(GOAL_COMMON_GuardBreakCombo, 0, "１段目の攻撃番号", 0)      -- 第一段攻击编号
REGISTER_DBG_GOAL_PARAM(GOAL_COMMON_GuardBreakCombo, 1, "２段目の攻撃番号", 0)      -- 第二段攻击编号
REGISTER_DBG_GOAL_PARAM(GOAL_COMMON_GuardBreakCombo, 2, "攻撃対象", 0)               -- 攻击目标
REGISTER_DBG_GOAL_PARAM(GOAL_COMMON_GuardBreakCombo, 3, "成功距離（２段目に適応される）", 0)  -- 成功距离(应用于第二段)
REGISTER_DBG_GOAL_PARAM(GOAL_COMMON_GuardBreakCombo, 4, "攻撃前旋回時間", 0)         -- 攻击前旋转时间
REGISTER_DBG_GOAL_PARAM(GOAL_COMMON_GuardBreakCombo, 5, "正面判定角度", 0)           -- 正面判定角度

--[[
架势破坏连击激活函数 (Guard break combo activation function)
功能：启动两段式架势破坏连击攻击序列
参数：
  f1_arg0 - AI角色对象 (AI character object)
  f1_arg1 - AI实体对象 (AI entity object)
  f1_arg2 - 目标对象 (Goal object)
逻辑流程：
  1. 提取所有连击参数(攻击编号、目标、距离、角度等)
  2. 添加第一段子目标: 架势破坏攻击(GuardBreakTunable)
     - 使用旋转时间和角度参数确保破防命中
     - 固定第一段的成功距离为10
  3. 添加第二段子目标: 连击终结技(ComboFinal)
     - 使用专门的成功距离参数
     - 利用第一段造成的硬直机会
  4. 子目标按顺序自动执行,形成完整连击
特点：
  - 双重子目标链: 架势破坏 → 终结攻击
  - 参数分离: 不同段使用不同的距离和角度配置
  - 自动衔接: Goal系统自动处理两段之间的过渡
]]--
Goal.Activate = function (f1_arg0, f1_arg1, f1_arg2)
    -- === 参数提取阶段 (Parameter Extraction Phase) ===
    local f1_local0 = f1_arg2:GetParam(0)  -- 第一段攻击动画编号 (First stage attack animation number)
    local f1_local1 = f1_arg2:GetParam(1)  -- 第二段攻击动画编号 (Second stage attack animation number)
    local f1_local2 = f1_arg2:GetParam(2)  -- 攻击目标对象 (Attack target object)
    local f1_local3 = 10                   -- 第一段固定成功距离 (First stage fixed success distance)
    local f1_local4 = f1_arg2:GetParam(3)  -- 第二段成功距离参数 (Second stage success distance parameter)
    local f1_local5 = f1_arg2:GetParam(4)  -- 攻击前旋转时间 (Pre-attack spin time)
    local f1_local6 = f1_arg2:GetParam(5)  -- 正面判定角度 (Front determination angle)

    -- === 第一段: 架势破坏攻击 (First Stage: Guard Break Attack) ===
    -- 添加可调节架势破坏子目标,执行第一段破防攻击
    -- (Add tunable guard break sub-goal for first stage defense-breaking attack)
    -- 参数说明 (Parameter explanation):
    --   生命周期10秒, 第一段攻击ID, 目标, 成功距离10, 旋转时间, 角度判定, 无上下角度限制
    f1_arg2:AddSubGoal(GOAL_COMMON_GuardBreakTunable, 10, f1_local0, f1_local2, f1_local3, f1_local5, f1_local6, 0, 0)

    -- === 第二段: 连击终结技 (Second Stage: Combo Finisher) ===
    -- 添加连击终结子目标,执行第二段终结攻击
    -- (Add combo finisher sub-goal for second stage finishing attack)
    -- 参数说明 (Parameter explanation):
    --   生命周期10秒, 第二段攻击ID, 目标, 第二段专用成功距离, 无上下角度限制
    f1_arg2:AddSubGoal(GOAL_COMMON_ComboFinal, 10, f1_local1, f1_local2, f1_local4, 0)

    -- 注意: Goal系统会自动按顺序执行这两个子目标
    -- 第一段完成后自动开始第二段,无需手动控制
    -- (Note: Goal system automatically executes these two sub-goals in sequence
    -- Second stage starts automatically after first stage completes, no manual control needed)
end

--[[
架势破坏连击更新函数 (Guard break combo update function)
功能：每帧更新连击执行状态
参数：
  f2_arg0 - AI角色对象 (AI character object)
  f2_arg1 - AI实体对象 (AI entity object)
  f2_arg2 - 目标对象 (Goal object)
返回：更新结果状态
说明：使用默认的无子目标更新逻辑,子目标的状态管理由Goal系统自动处理
设计理念：
  - 委托式管理: 连击状态由子目标自行管理
  - 简洁高效: 不需要在Update中进行复杂的状态判断
  - 系统集成: 充分利用Goal系统的自动化功能
]]--
Goal.Update = function (f2_arg0, f2_arg1, f2_arg2)
    -- 使用默认更新逻辑,连击的两段攻击由子目标自动管理
    -- (Use default update logic, two stages of combo automatically managed by sub-goals)
    --
    -- 执行过程 (Execution process):
    -- 1. 第一段(GuardBreakTunable)执行中 → 返回Continue
    -- 2. 第一段完成 → 自动切换到第二段(ComboFinal)
    -- 3. 第二段执行中 → 返回Continue
    -- 4. 第二段完成 → 整个连击结束,返回Success
    return Update_Default_NoSubGoal(f2_arg0, f2_arg1, f2_arg2)
end

--[[============================================================================
    文件结束 (End of File)
    ============================================================================

    架势破坏连击系统已完成专业文档化。该模块现在具备：
    - 完整的两段式连击机制说明
    - 详细的架势破坏战术逻辑
    - 清晰的参数分配策略文档
    - 专业的子目标链执行流程

    关键特性总结：
    - 两段式组合：架势破坏 + 连击终结
    - 破防专精：专门针对防御型玩家
    - 自动衔接：Goal系统自动处理段间过渡
    - 参数优化：不同段使用不同的距离和角度配置

    连击序列：
    GuardBreakTunable(破防) → ComboFinal(终结) → 连击完成

    应用场景：
    - BOSS战中的破防组合攻击
    - 对防御型玩家的专门战术
    - 架势压制流的核心技能
    ============================================================================
]]--


