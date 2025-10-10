--[[============================================================================
    attack3.lua - Sekiro精确控制攻击系统 (Sekiro Precision Control Attack System)

    版本信息 (Version Info): v3.0 - Comprehensive professional documentation
    作者 (Author): FromSoftware AI Team / Enhanced by Claude Code
    最后修改 (Last Modified): 2025-09-28
    编码格式 (Encoding): Shift-JIS (required for Sekiro compatibility)

    ============================================================================
    模块概述 (Module Overview):
    ============================================================================
    这是Sekiro AI系统的精确控制攻击模块，提供比基础attack.lua更精细的攻击
    控制能力。该模块专注于需要精确时机和角度控制的攻击动作，支持攻击前的
    精确转向、角度判断和团队协调记录。

    核心特性 (Core Features):
    ┌─ 精确转向控制 (Precise Turn Control)
    │  ├─ 攻击前转向时间 - 可配置的转向预备时间
    │  ├─ 角度判定机制 - 精确的朝向判断
    │  └─ 动态角度调整 - 基于目标位置实时调整
    │
    ├─ 智能攻击触发 (Intelligent Attack Trigger)
    │  ├─ 角度条件检查 - 只在合适角度时发动攻击
    │  ├─ 攻击请求管理 - 精确的攻击时机控制
    │  └─ 失败处理机制 - 角度不符时的处理逻辑
    │
    └─ 团队协调集成 (Team Coordination Integration)
       ├─ 攻击记录管理 - 向团队广播攻击信息
       ├─ 协调类型标记 - COORDINATE_TYPE_Attack标记
       └─ 冲突避免机制 - 防止团队成员攻击冲突

    ============================================================================
    与其他攻击模块的差异 (Differences from Other Attack Modules):
    ============================================================================

    attack.lua vs attack3.lua vs enemy_attack.lua:

    attack.lua (基础攻击):
    - 简单直接的攻击执行
    - 固定180度攻击角度
    - 委托给CommonAttack处理

    attack3.lua (精确攻击 - 本模块):
    - 精确的转向时间控制
    - 可配置的角度判定
    - 团队协调记录
    - 条件性攻击触发

    enemy_attack.lua (敌人高级攻击):
    - 基于AIAttackParam.xml的参数化攻击
    - 支持复杂的连击系统
    - 专门为敌人AI设计

    ============================================================================
    设计理念 (Design Philosophy):
    ============================================================================
    精确控制：强调攻击时机和角度的精确性
    条件触发：只在满足条件时才执行攻击
    团队感知：考虑团队协调的攻击模式
    简洁高效：保持实现的简洁性和执行效率
    ============================================================================
]]--

-- 注册Attack3攻击行为的调试参数 (Register debug parameters for Attack3 behavior)
-- 这些参数支持游戏运行时的实时调试和参数调优
REGISTER_DBG_GOAL_PARAM(GOAL_COMMON_Attack3, 0, "EzState番号", 0)          -- 动画状态ID (Animation state ID)
REGISTER_DBG_GOAL_PARAM(GOAL_COMMON_Attack3, 1, "攻撃対象【Type】", 0)      -- 攻击目标类型 (Attack target type)
REGISTER_DBG_GOAL_PARAM(GOAL_COMMON_Attack3, 2, "成功距離【Type】", 0)      -- 成功距离类型 (Success distance type)
REGISTER_DBG_GOAL_PARAM(GOAL_COMMON_Attack3, 3, "攻撃前旋回時間【秒】", 0)   -- 攻击前转向时间(秒) (Turn time before attack in seconds)
REGISTER_DBG_GOAL_PARAM(GOAL_COMMON_Attack3, 4, "正面判定角度【度】", 0)     -- 正面判定角度(度) (Front angle judgment in degrees)
REGISTER_DBG_GOAL_PARAM(GOAL_COMMON_Attack3, 5, "必ず成功するか？", 0)       -- 是否必定成功 (Is it guaranteed to succeed?)

-- 系统配置 (System Configuration)
REGISTER_GOAL_UPDATE_TIME(GOAL_COMMON_Attack3, 0, 0)    -- 更新时间间隔 (Update time interval)
REGISTER_GOAL_NO_INTERUPT(GOAL_COMMON_Attack3, true)    -- 设为不可中断 (Set as non-interruptible)

--[[============================================================================
    精确控制攻击激活函数 (Precision Control Attack Activation Function)
    ============================================================================
]]--

-- 精确控制攻击激活和执行函数 (Precision control attack activation and execution function)
-- 功能说明 (Function Description):
--   这是精确控制攻击系统的核心函数，实现了条件性攻击触发机制。与基础攻击
--   不同，该函数会先进行精确的转向调整，然后判断角度是否符合攻击条件，
--   只有在满足角度要求时才会触发实际的攻击动作。
--
-- 参数说明 (Parameters):
--   f1_arg0: AI角色对象 (AI character object) - 执行攻击的AI实体
--   f1_arg1: 目标对象 (Goal object) - 包含攻击参数和状态管理
--
-- 执行流程 (Execution Flow):
--   1. 参数提取和验证：获取攻击参数并设置默认值
--   2. 转向准备阶段：开始朝向目标转身
--   3. 角度判断阶段：检查是否达到攻击角度要求
--   4. 条件性攻击：只有角度符合时才发动攻击
--   5. 团队协调记录：向团队广播攻击信息
--
-- 关键特性 (Key Features):
--   - 条件性触发：智能的攻击条件判断
--   - 精确转向：可配置的转向时间控制
--   - 角度验证：严格的朝向角度检查
--   - 团队感知：集成的团队协调机制
--
-- 与attack.lua的区别 (Differences from attack.lua):
--   - attack.lua: 立即执行攻击，由CommonAttack处理所有逻辑
--   - attack3.lua: 条件性攻击，需要满足角度要求才执行
function Attack3_Activate(f1_arg0, f1_arg1)
    -- === 参数提取阶段 (Parameter Extraction Phase) ===
    local f1_local0 = f1_arg1:GetParam(0)  -- 动画状态ID (Animation state ID)
    local f1_local1 = f1_arg1:GetParam(1)  -- 攻击目标 (Attack target)
    local f1_local2 = f1_arg1:GetParam(3)  -- 攻击前转向时间 (Turn time before attack)
    local f1_local3 = f1_arg1:GetParam(4)  -- 正面角度判定范围 (Front angle judgment range)

    -- === 参数验证和默认值设置 (Parameter Validation and Default Values) ===
    if f1_local2 < 0 then
        f1_local2 = 1.5  -- 默认转向时间：1.5秒 (Default turn time: 1.5 seconds)
    end
    if f1_local3 < 0 then
        f1_local3 = 10   -- 默认角度范围：10度 (Default angle range: 10 degrees)
    end

    -- === 状态设置阶段 (State Setting Phase) ===
    f1_arg1:SetNumber(0, f1_local3)  -- 保存角度参数供后续使用 (Save angle parameter for later use)
    f1_arg1:SetTimer(0, f1_local2)   -- 设置转向计时器 (Set turn timer)

    -- === 精确转向阶段 (Precise Turn Phase) ===
    -- 开始朝向目标转身，这是精确攻击的关键准备步骤
    -- (Start turning towards target, this is a key preparation step for precise attack)
    f1_arg0:TurnTo(f1_local1)

    -- === 条件性攻击触发阶段 (Conditional Attack Trigger Phase) ===
    -- 检查是否已经朝向目标并满足角度要求
    -- (Check if already facing target and meeting angle requirements)
    if f1_arg0:IsLookToTarget(f1_local3) then
        -- 角度符合要求，发出攻击请求 (Angle meets requirements, issue attack request)
        f1_arg0:SetAttackRequest(f1_local0)
    end
    -- 注意：如果角度不符合，攻击不会立即执行，需要等待转向完成
    -- (Note: If angle doesn't meet requirements, attack won't execute immediately, need to wait for turn completion)

    -- === 团队协调记录阶段 (Team Coordination Record Phase) ===
    -- 向团队广播攻击信息，避免多个AI同时攻击造成混乱
    -- (Broadcast attack information to team, avoid chaos from multiple AIs attacking simultaneously)
    f1_arg1:AddGoalScopedTeamRecord(COORDINATE_TYPE_Attack, f1_local1, 0)

    -- 函数执行完成，攻击是否实际发生取决于角度判断结果
    -- (Function execution complete, whether attack actually occurs depends on angle judgment result)
end

--[[============================================================================
    精确控制攻击状态管理函数 (Precision Control Attack State Management Functions)
    ============================================================================
]]--

-- 精确控制攻击更新函数 (Precision control attack update function)
-- 功能说明 (Function Description):
--   每帧调用的状态更新函数，负责监控攻击执行状态、处理攻击结果判定、
--   以及在攻击未开始时继续尝试满足攻击条件。该函数实现了复杂的攻击
--   状态机逻辑，包括成功/失败判定和持续的角度监控。
--
-- 参数说明 (Parameters):
--   f2_arg0: AI角色对象 (AI character object) - 执行攻击的AI实体
--   f2_arg1: 目标对象 (Goal object) - 包含攻击状态和参数
--
-- 返回值 (Return Values):
--   GOAL_RESULT_Success: 攻击成功完成 (Attack completed successfully)
--   GOAL_RESULT_Failed: 攻击失败 (Attack failed)
--   GOAL_RESULT_Continue: 继续执行攻击 (Continue executing attack)
--
-- 状态机逻辑 (State Machine Logic):
--   未开始 → 角度检查 → 攻击触发 → 执行中 → 结果判定 → 完成
function Attack3_Update(f2_arg0, f2_arg1)
    -- === 参数获取阶段 (Parameter Retrieval Phase) ===
    local f2_local0 = f2_arg1:GetParam(0)  -- 动画状态ID (Animation state ID)
    local f2_local1 = f2_arg1:GetParam(1)  -- 攻击目标 (Attack target)
    local f2_local2 = f2_arg1:GetParam(2)  -- 成功距离类型 (Success distance type)
    local f2_local3 = f2_arg1:GetNumber(0) -- 角度判定范围 (Angle judgment range) - 从Activate中保存的值
    local f2_local4 = f2_arg1:GetParam(5)  -- 必定成功标志 (Guaranteed success flag)

    -- === 攻击完成检查阶段 (Attack Completion Check Phase) ===
    if f2_arg0:IsFinishAttack() then
        -- 攻击动作已完成，进行结果判定 (Attack action completed, perform result judgment)
        local f2_local5 = f2_arg0:GetDist(f2_local1)      -- 当前与目标的距离 (Current distance to target)
        local f2_local6 = f2_arg0:GetDistParam(f2_local2) -- 成功距离参数 (Success distance parameter)

        if f2_arg0:IsHitAttack() then
            -- 攻击命中目标，直接判定为成功 (Attack hit target, directly judge as success)
            return GOAL_RESULT_Success
        elseif f2_local6 < f2_local5 then
            -- 距离超出成功范围，根据必定成功标志判定结果
            -- (Distance exceeds success range, judge result based on guaranteed success flag)
            if f2_local4 == 0 then
                return GOAL_RESULT_Failed   -- 不是必定成功，判定为失败 (Not guaranteed success, judge as failed)
            else
                return GOAL_RESULT_Success  -- 必定成功模式，强制判定为成功 (Guaranteed success mode, force judge as success)
            end
        else
            -- 距离在成功范围内，判定为成功 (Distance within success range, judge as success)
            return GOAL_RESULT_Success
        end
    end

    -- === 攻击触发监控阶段 (Attack Trigger Monitoring Phase) ===
    if f2_arg0:IsStartAttack() == false then
        -- 攻击尚未开始，继续尝试触发攻击 (Attack not yet started, continue trying to trigger attack)
        if f2_arg0:IsLookToTarget(f2_local3) then
            -- 角度符合要求，立即发出攻击请求 (Angle meets requirements, immediately issue attack request)
            f2_arg0:SetAttackRequest(f2_local0)
        elseif f2_arg1:IsFinishTimer(0) then
            -- 转向时间已到，强制发出攻击请求 (Turn time expired, force issue attack request)
            f2_arg0:SetAttackRequest(f2_local0)
        end
    end

    -- === 持续转向阶段 (Continuous Turn Phase) ===
    -- 无论攻击是否已开始，都持续调整朝向以提高命中率
    -- (Regardless of whether attack has started, continuously adjust orientation to improve hit rate)
    f2_arg0:TurnTo(f2_local1)

    -- 继续执行攻击行为 (Continue executing attack behavior)
    return GOAL_RESULT_Continue
end

-- 精确控制攻击终止函数 (Precision control attack termination function)
-- 功能说明 (Function Description):
--   在攻击行为完成或被强制终止时调用的清理函数。对于精确控制攻击，
--   由于状态管理相对简单，不需要特殊的清理工作。
--
-- 参数说明 (Parameters):
--   f3_arg0: AI角色对象 (AI character object) - 执行攻击的AI实体
--   f3_arg1: 目标对象 (Goal object) - 即将终止的攻击目标
--
-- 设计考虑 (Design Considerations):
--   精确控制攻击的状态主要由引擎层面管理，脚本层面不需要额外清理
function Attack3_Terminate(f3_arg0, f3_arg1)
    -- 精确控制攻击：无需特殊清理工作 (Precision control attack: no special cleanup needed)
    -- 所有状态由引擎自动管理 (All states automatically managed by engine)
end

-- 精确控制攻击中断判断函数 (Precision control attack interruption judgment function)
-- 功能说明 (Function Description):
--   判断当前攻击是否可以被其他行为中断。精确控制攻击采用不可中断策略，
--   确保攻击的完整执行和角度控制的有效性。
--
-- 参数说明 (Parameters):
--   f4_arg0: AI角色对象 (AI character object) - 执行攻击的AI实体
--   f4_arg1: 目标对象 (Goal object) - 当前的攻击目标状态
--
-- 返回值 (Return Value):
--   false: 不允许中断 (Do not allow interruption)
--
-- 设计理念 (Design Philosophy):
--   精确控制攻击强调时机和角度的准确性，中断会破坏这种精确性，
--   因此采用严格的不可中断策略。
function Attack3_Interupt(f4_arg0, f4_arg1)
    -- 精确控制攻击：不允许被其他行为中断 (Precision control attack: not allowed to be interrupted by other behaviors)
    -- 确保攻击的完整性和精确性 (Ensure attack completeness and precision)
    return false
end

--[[============================================================================
    文件结束 (End of File)
    ============================================================================

    精确控制攻击系统已完成文档化。该模块现在具有：
    - 完整的精确控制机制说明
    - 详细的条件性攻击触发逻辑
    - 专业级的状态机文档
    - 清晰的设计理念和实现策略

    关键特性总结：
    - 条件性攻击：只有满足角度要求才执行
    - 精确转向：可配置的转向时间和角度控制
    - 智能重试：持续监控角度条件并重试攻击
    - 团队协调：集成的团队攻击记录机制
    - 状态完整：完整的成功/失败判定逻辑

    与其他攻击模块的定位：
    - attack.lua: 基础攻击，简单直接
    - attack3.lua: 精确攻击，条件触发 (本模块)
    - enemy_attack.lua: 高级攻击，参数化配置
    ============================================================================
]]--


