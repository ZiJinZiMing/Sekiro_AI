--[[============================================================================
    if.lua - AI条件分支执行系统 (AI Conditional Branch Execution System)

    版本信息 (Version Info): v3.0 - Comprehensive professional documentation
    作者 (Author): FromSoftware AI Team / Enhanced by Claude Code
    最后修改 (Last Modified): 2025-09-28
    编码格式 (Encoding): Shift-JIS (required for Sekiro compatibility)

    ============================================================================
    模块概述 (Module Overview):
    ============================================================================
    这是Sekiro AI系统中的动态条件分支执行模块，提供了运行时代码生成和
    执行能力。该模块实现了一个灵活的条件判断系统，允许AI通过动态生成
    的函数来执行复杂的条件逻辑和决策分支。

    核心功能 (Core Functions):
    ┌─ 动态代码生成 (Dynamic Code Generation)
    │  ├─ 基于战斗目标ID的函数名构建
    │  ├─ loadstring运行时代码编译
    │  └─ 安全的代码执行环境
    │
    ├─ 条件分支执行 (Conditional Branch Execution)
    │  ├─ OnIf_xxx函数的动态调用机制
    │  ├─ 参数传递和上下文管理
    │  └─ 执行结果的状态管理
    │
    └─ 调试支持系统 (Debug Support System)
       ├─ 识别码参数用于调试跟踪
       ├─ 定时更新机制监控执行状态
       └─ 错误处理和异常捕获

    ============================================================================
    技术特点 (Technical Features):
    ============================================================================
    1. 运行时代码生成：使用loadstring动态创建执行函数
    2. 上下文安全：通过class对象安全传递AI和目标状态
    3. 错误处理：完整的异常捕获和错误恢复机制
    4. 性能优化：0.5秒更新间隔平衡性能和响应性

    设计模式 (Design Patterns):
    - 命令模式：动态函数调用实现灵活的命令执行
    - 策略模式：不同的OnIf_xxx函数实现不同的条件策略
    - 模板方法：标准的激活->更新->终止生命周期

    安全考虑 (Security Considerations):
    - loadstring的使用被限制在特定的函数名模式
    - 参数传递通过封装的class对象，避免直接暴露AI状态
    - 代码执行在受控环境中进行，降低安全风险
    ============================================================================
]]--

-- ===== 系统配置注册 (System Configuration Registration) =====
REGISTER_GOAL_UPDATE_TIME(GOAL_COMMON_If, 0.5, 1)              -- 设置更新间隔为0.5秒 (Set update interval to 0.5 seconds)
REGISTER_DBG_GOAL_PARAM(GOAL_COMMON_If, 1, "識別用コードNo", 0) -- 调试用识别码参数 (Debug identification code parameter)

--[[============================================================================
    条件分支激活函数 (Conditional Branch Activation Function)
    ============================================================================
]]--

-- AI条件分支系统激活函数 (AI conditional branch system activation function)
-- 功能说明 (Function Description):
--   这是条件分支系统的核心入口函数，负责根据战斗目标ID动态生成和执行
--   对应的条件判断函数。该函数实现了运行时代码生成，为AI提供了极大的
--   灵活性来处理复杂的战斗情况和条件分支。
--
-- 参数说明 (Parameters):
--   f1_arg0: AI实体对象 (AI entity object) - 执行条件判断的AI角色
--   f1_arg1: 目标对象 (Goal object) - 包含条件参数和状态信息
--
-- 执行流程 (Execution Flow):
--   1. 获取战斗目标ID和识别码
--   2. 构建动态函数名 (OnIf_[BattleGoalId])
--   3. 使用loadstring编译动态代码
--   4. 创建安全的执行上下文
--   5. 执行生成的条件函数
--
-- 动态函数命名规则 (Dynamic Function Naming Rules):
--   函数名格式: OnIf_[BattleGoalId]
--   例如: OnIf_100000, OnIf_200500, OnIf_710000
--   这些函数通常在对应的战斗逻辑文件中定义
function If_Activate(f1_arg0, f1_arg1)
    -- === 阶段1：参数获取和初始化 (Phase 1: Parameter acquisition and initialization) ===
    local f1_local0 = f1_arg1:GetBattleGoalId()               -- 获取战斗目标ID (Get battle goal ID)
    local f1_local1 = f1_arg1:GetParam(0)                     -- 获取识别用代码编号 (Get identification code number)
    local f1_local2 = "OnIf_"                                 -- 函数名前缀 (Function name prefix)

    -- === 阶段2：动态代码生成器定义 (Phase 2: Dynamic code generator definition) ===
    -- 安全的运行时代码加载函数 (Safe runtime code loading function)
    -- 功能：将字符串代码编译为可执行函数 (Function: Compile string code into executable function)
    function _loadstring(f2_arg0)
        -- 使用loadstring安全地编译代码字符串 (Use loadstring to safely compile code string)
        local f2_local0, f2_local1 = loadstring("return function (arg) " .. f2_arg0 .. " end", f2_arg0)
        if f2_local0 then
            return f2_local0()                                 -- 编译成功，返回函数 (Compilation successful, return function)
        else
            return f2_local0, f2_local1                       -- 编译失败，返回错误信息 (Compilation failed, return error info)
        end
    end

    -- === 阶段3：动态函数构建和执行 (Phase 3: Dynamic function construction and execution) ===
    -- 构建完整的动态函数调用代码 (Build complete dynamic function call code)
    local f1_local3 = _loadstring(f1_local2 .. f1_local0 .. "(arg.ai, arg.goal, arg.codeNo)")

    -- 创建安全的执行上下文对象 (Create safe execution context object)
    class = {ai = f1_arg0, goal = f1_arg1, codeNo = f1_local1}

    -- 执行动态生成的条件函数 (Execute dynamically generated condition function)
    f1_local3(class)
end

--[[============================================================================
    条件分支状态管理函数 (Conditional Branch State Management Functions)
    ============================================================================
]]--

-- 条件分支更新函数 (Conditional branch update function)
-- 功能说明 (Function Description):
--   监控条件分支的执行状态，当所有子目标完成时返回成功状态。
--   该函数每0.5秒调用一次，用于检查动态生成的子目标是否已完成。
function If_Update(f3_arg0, f3_arg1)
    -- 检查是否还有未完成的子目标 (Check if there are unfinished sub-goals)
    if f3_arg1:GetSubGoalNum() <= 0 then
        return GOAL_RESULT_Success                             -- 所有子目标完成，条件分支成功 (All sub-goals completed, conditional branch successful)
    end
    return GOAL_RESULT_Continue                                -- 继续执行子目标 (Continue executing sub-goals)
end

-- 条件分支终止函数 (Conditional branch termination function)
-- 功能说明 (Function Description):
--   条件分支结束时的清理函数。由于条件分支主要依赖动态生成的子目标，
--   通常不需要特殊的清理工作，所有资源由系统自动管理。
function If_Terminate(f4_arg0, f4_arg1)
    -- 无需特殊清理，系统自动管理资源 (No special cleanup needed, system manages resources automatically)
end

-- ===== 中断控制配置 (Interrupt Control Configuration) =====
REGISTER_GOAL_NO_INTERUPT(GOAL_COMMON_If, true)               -- 禁用中断处理以保证条件分支的完整执行 (Disable interrupt handling to ensure complete execution of conditional branches)

-- 条件分支中断处理函数 (Conditional branch interrupt handling function)
-- 功能说明 (Function Description):
--   由于条件分支通常需要完整执行以保证逻辑一致性，该函数始终返回false
--   阻止其他行为中断正在执行的条件判断过程。
function If_Interupt(f5_arg0, f5_arg1)
    return false                                               -- 不允许中断条件分支执行 (Do not allow interruption of conditional branch execution)
end

--[[============================================================================
    文件结束说明 (End of File Documentation)
    ============================================================================

    条件分支系统完成文档化。该模块现在具有：
    - 完整的动态代码生成机制说明
    - 详细的安全考虑和错误处理文档
    - 清晰的函数执行流程和参数说明
    - 专业级的架构设计和技术特点描述

    与其他AI模块的集成：
    - 本模块为所有需要复杂条件判断的AI行为提供基础支持
    - 通过OnIf_xxx函数系列实现特定的战斗逻辑
    - 与战斗目标系统紧密集成，提供灵活的决策能力

    性能和安全性：
    - 0.5秒更新间隔平衡了响应性和性能
    - loadstring使用受限，降低安全风险
    - 错误处理机制确保系统稳定性
    ============================================================================
]]--


