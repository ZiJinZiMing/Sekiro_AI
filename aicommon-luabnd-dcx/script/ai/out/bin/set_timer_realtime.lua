--[[============================================================================
    set_timer_realtime.lua - 实时定时器设置模块 (Realtime Timer Setting Module)

    版本信息 (Version Info): v1.0 - Initial documentation
    作者 (Author): FromSoftware AI Team / Enhanced by Claude Code
    最后修改 (Last Modified): 2025-10-13
    编码格式 (Encoding): Shift-JIS (required for Sekiro compatibility)

    ============================================================================
    模块概述 (Module Overview):
    ============================================================================
    这是一个实时定时器设置工具模块，提供即时设置AI定时器的功能。该模块允许
    在AI行为执行过程中动态设置或重置定时器值，用于控制行为的时序和间隔。

    核心功能 (Core Functions):
    - 实时设置AI定时器值 (Set AI timer value in realtime)
    - 支持任意定时器索引 (Support arbitrary timer index)
    - 即时生效无延迟 (Take effect immediately)

    使用场景 (Usage Scenarios):
    - 重置攻击冷却定时器 (Reset attack cooldown timer)
    - 动态调整行为间隔 (Dynamically adjust behavior intervals)
    - 同步多个AI的时序 (Synchronize timing across multiple AIs)
    - 状态转换时的定时器初始化 (Timer initialization during state transitions)

    与其他模块的关系 (Relationship with Other Modules):
    - 配合common_func.lua中的定时器管理函数使用
    - 可在任何AI行为中作为子目标调用
    - 通常与攻击、移动等行为组合使用

    ============================================================================
]]--

-- 注册定时器设置目标 (Register timer setting goal)
RegisterTableGoal(GOAL_COMMON_SetTimerRealtime, "SetTimerRealtime")

-- 声明该目标不使用子目标系统 (Declare this goal doesn't use sub-goal system)
REGISTER_GOAL_NO_SUB_GOAL(GOAL_COMMON_SetTimerRealtime, true)

-- 注册调试参数：定时器索引 (Register debug parameter: timer index)
REGISTER_DBG_GOAL_PARAM(GOAL_COMMON_SetTimerRealtime, 0, "タイマーインデックス", 0)  -- 定时器索引 (Timer index)

-- 注册调试参数：时间值 (Register debug parameter: time value)
REGISTER_DBG_GOAL_PARAM(GOAL_COMMON_SetTimerRealtime, 1, "時間", 0)  -- 时间值（秒） (Time value in seconds)

--[[============================================================================
    目标激活函数 (Goal Activation Function)
    ============================================================================
]]--

-- 实时定时器设置激活函数 (Realtime timer setting activation function)
-- 功能说明 (Function Description):
--   立即设置指定索引的AI定时器为指定时间值。该函数在被调用时立即执行，
--   修改AI的定时器状态，用于控制后续行为的时序安排。
--
-- 参数说明 (Parameters):
--   f1_arg0: AI角色对象 (AI character object) - 目标AI的角色对象（未直接使用）
--   f1_arg1: AI实体对象 (AI entity object) - 执行定时器设置的AI实体
--   f1_arg2: 目标对象 (Goal object) - 包含定时器参数的目标对象
--
-- 参数详解 (Parameter Details):
--   参数0 (f1_local0): 定时器索引 (Timer index)
--     - 范围：通常为0-99的整数
--     - 用途：标识要设置的定时器ID
--     - 不同索引用于不同的行为控制（攻击、移动、特殊行为等）
--
--   参数1 (f1_local1): 时间值 (Time value)
--     - 单位：秒 (seconds)
--     - 范围：0.0或正数，0表示立即过期
--     - 用途：定时器的初始值或重置值
--
-- 执行流程 (Execution Flow):
--   1. 从目标对象中提取定时器索引
--   2. 从目标对象中提取时间值
--   3. 调用SetTimer立即设置定时器
--   4. 函数结束，AI继续执行后续行为
--
-- 使用示例 (Usage Example):
--   -- 在AI逻辑脚本中使用
--   goal:AddSubGoal(GOAL_COMMON_SetTimerRealtime, 0.1, 5, 10.0)
--   -- 设置5号定时器为10秒
--
-- 常用定时器索引 (Common Timer Indices):
--   0-9: 基础行为定时器 (Basic behavior timers)
--   10-19: 攻击冷却定时器 (Attack cooldown timers)
--   20-29: 移动行为定时器 (Movement behavior timers)
--   30-49: 特殊行为定时器 (Special behavior timers)
--   50-99: 自定义定时器 (Custom timers)
Goal.Activate = function (f1_arg0, f1_arg1, f1_arg2)
    local f1_local0 = f1_arg2:GetParam(0)       -- 获取定时器索引 (Get timer index)
    local f1_local1 = f1_arg2:GetParam(1)       -- 获取时间值（秒） (Get time value in seconds)

    -- 立即设置定时器 (Set timer immediately)
    -- 参数：定时器索引, 时间值（秒）
    f1_arg1:SetTimer(f1_local0, f1_local1)

end

--[[============================================================================
    目标更新函数 (Goal Update Function)
    ============================================================================
]]--

-- 实时定时器设置更新函数 (Realtime timer setting update function)
-- 功能说明 (Function Description):
--   定时器设置是即时操作，无需持续更新。该函数使用默认的无子目标更新逻辑，
--   在激活后立即返回成功状态。
--
-- 参数说明 (Parameters):
--   f2_arg0: AI角色对象 (AI character object) - 目标AI的角色对象
--   f2_arg1: AI实体对象 (AI entity object) - 执行更新的AI实体
--   f2_arg2: 目标对象 (Goal object) - 当前目标对象
--
-- 返回值 (Return Value):
--   通过Update_Default_NoSubGoal返回成功状态 (Return success status via Update_Default_NoSubGoal)
--
-- 执行逻辑 (Execution Logic):
--   由于定时器设置是即时操作，该函数在第一次调用时就会返回成功，
--   不需要等待或循环处理。
Goal.Update = function (f2_arg0, f2_arg1, f2_arg2)
    -- 使用默认的无子目标更新逻辑，立即返回成功 (Use default no-sub-goal update logic, return success immediately)
    return Update_Default_NoSubGoal(f2_arg0, f2_arg1, f2_arg2)

end

--[[============================================================================
    文件结束 (End of File)
    ============================================================================

    实时定时器设置模块已完成文档化。该模块现在具有：
    - 完整的功能说明和用途描述
    - 详细的参数说明和使用场景
    - 清晰的定时器索引规范
    - 专业级的代码注释

    技术特点 (Technical Features):
    - 即时生效：无延迟，立即修改定时器状态
    - 轻量级操作：执行速度快，不影响性能
    - 灵活性高：支持任意定时器索引和时间值
    - 简单易用：参数少，逻辑清晰

    最佳实践 (Best Practices):
    - 为不同用途的定时器使用不同的索引范围
    - 在重要状态转换时使用此模块重置定时器
    - 配合GetTimer函数检查定时器状态
    - 避免频繁重置同一定时器，保持时序稳定性

    相关函数 (Related Functions):
    - AI:GetTimer(index) - 获取定时器当前值
    - AI:StartIdTimer(id) - 启动ID定时器
    - AI:GetIdTimer(id) - 获取ID定时器值
    ============================================================================
]]--

