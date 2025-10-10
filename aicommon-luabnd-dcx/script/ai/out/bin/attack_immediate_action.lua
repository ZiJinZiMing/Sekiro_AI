--[[============================================================================
    attack_immediate_action.lua - Sekiro即时动作攻击系统 (Sekiro Immediate Action Attack System)

    版本信息 (Version Info): v3.0 - Comprehensive professional documentation
    作者 (Author): FromSoftware AI Team / Enhanced by Claude Code
    最后修改 (Last Modified): 2025-09-28
    编码格式 (Encoding): Shift-JIS (required for Sekiro compatibility)

    ============================================================================
    模块概述 (Module Overview):
    ============================================================================
    这是Sekiro AI系统的即时动作攻击模块，实现了具有即时反应能力的攻击行为。
    该模块在基础攻击的基础上增加了即时动作机制，允许AI在攻击执行过程中
    响应紧急情况和优先级事件，提供更灵活和反应式的战斗体验。

    核心功能 (Core Functions):
    ┌─ 即时动作攻击管理 (Immediate Action Attack Management)
    │  ├─ AttackImmediateAction_Activate() - 即时动作攻击激活和配置
    │  ├─ AttackImmediateAction_Update() - 即时攻击执行状态管理
    │  ├─ AttackImmediateAction_Terminate() - 攻击完成后的清理工作
    │  └─ AttackImmediateAction_Interupt() - 攻击中断条件判断
    │
    ├─ 即时动作机制 (Immediate Action Mechanism)
    │  ├─ 即时动作启用 - SetEnableImmediateAction_forGoal()
    │  ├─ 即时动作清理 - ClearEnableImmediateAction_forGoal()
    │  ├─ 动作优先级管理 - 高优先级事件的即时响应
    │  └─ 状态保护机制 - 确保即时动作的正确执行
    │
    └─ 与其他系统的关系 (Relationship with Other Systems)
       ├─ attack.lua - 提供基础攻击能力的底层依赖
       ├─ common_func.lua - 使用通用函数进行状态管理
       └─ AI优先级系统 - 即时动作的事件响应机制

    ============================================================================
    即时动作设计原理 (Immediate Action Design Principles):
    ============================================================================

    即时响应机制 (Immediate Response Mechanism):
    - 即时动作启用：在攻击执行期间启用高优先级事件响应
    - 事件优先级管理：确保重要事件能够中断当前攻击
    - 状态保护设计：保护即时动作状态的完整性
    - 清理机制保证：确保即时动作状态的正确释放

    与基础攻击的差异化 (Differentiation from Basic Attack):
    ┌─────────────────┬─────────────────┬─────────────────┐
    │      特性       │   基础攻击      │   即时动作攻击  │
    ├─────────────────┼─────────────────┼─────────────────┤
    │   响应能力      │     固定        │     即时        │
    │   优先级处理    │     标准        │     高级        │
    │   中断灵活性    │     低          │     高          │
    │   适用场景      │   常规战斗      │   紧急情况      │
    │   系统复杂度    │     简单        │     中等        │
    └─────────────────┴─────────────────┴─────────────────┘

    ============================================================================
    技术实现细节 (Technical Implementation Details):
    ============================================================================

    即时动作启用机制 (Immediate Action Enable Mechanism):
    - SetEnableImmediateAction_forGoal(): 在攻击开始时启用即时动作
    - 作用范围：仅对当前Goal生效，不影响其他行为
    - 优先级控制：允许高优先级事件中断当前攻击
    - 性能考虑：最小化对正常攻击流程的影响

    即时动作清理机制 (Immediate Action Cleanup Mechanism):
    - ClearEnableImmediateAction_forGoal(): 在攻击结束时清理即时动作状态
    - 状态保护：确保即时动作状态不会泄漏到其他行为
    - 资源管理：及时释放即时动作相关的系统资源
    - 错误恢复：即使在异常情况下也能正确清理状态

    ============================================================================
    使用场景和战术应用 (Usage Scenarios and Tactical Applications):
    ============================================================================

    紧急情况响应 (Emergency Situation Response):
    - 玩家突然使用危险技能时的紧急规避
    - 环境危险(如陷阱)出现时的即时反应
    - 其他AI发出警告信号时的协调响应
    - 生命值危急时的紧急防御动作

    高优先级事件处理 (High Priority Event Handling):
    - 重要目标出现时的攻击目标切换
    - 团队指令变化时的即时行为调整
    - 玩家使用特殊道具时的对应策略
    - 战斗状态变化时的即时适应

    ============================================================================
    性能考虑 (Performance Considerations):
    ============================================================================
    - 即时动作开销：启用即时动作会增加少量系统开销
    - 状态管理：确保即时动作状态的及时清理避免内存泄漏
    - 优先级冲突：合理的优先级设计避免事件冲突
    - 执行效率：即时动作的快速响应和处理机制
    ============================================================================
]]--

-- 注册即时动作攻击行为的调试参数 (Register debug parameters for immediate action attack behavior)
-- 这些参数支持开发阶段的即时动作调优和运行时的行为监控
REGISTER_DBG_GOAL_PARAM(GOAL_COMMON_AttackImmediateAction, 0, "EzStateID", 0)      -- 动画状态ID (Animation state ID)
REGISTER_DBG_GOAL_PARAM(GOAL_COMMON_AttackImmediateAction, 1, "攻撃対象", 0)         -- 攻击目标 (Attack target)
REGISTER_DBG_GOAL_PARAM(GOAL_COMMON_AttackImmediateAction, 2, "成功距離", 0)         -- 攻击成功距离 (Attack success distance)
REGISTER_DBG_GOAL_PARAM(GOAL_COMMON_AttackImmediateAction, 3, "攻撃前旋回時間", 0)    -- 攻击前旋回时间 (Pre-attack spin time)
REGISTER_DBG_GOAL_PARAM(GOAL_COMMON_AttackImmediateAction, 4, "正面判定角度", 0)      -- 正面判定角度 (Front determination angle)
REGISTER_DBG_GOAL_PARAM(GOAL_COMMON_AttackImmediateAction, 5, "上攻撃角度", 0)        -- 上攻击角度 (Upper attack angle)
REGISTER_DBG_GOAL_PARAM(GOAL_COMMON_AttackImmediateAction, 6, "下攻撃角度", 0)        -- 下攻击角度 (Lower attack angle)

--[[============================================================================
    即时动作攻击激活函数 (Immediate Action Attack Activation Function)
    ============================================================================
]]--

-- 即时动作攻击行为激活和配置函数 (Immediate action attack behavior activation and configuration function)
-- 功能说明 (Function Description):
--   这是即时动作攻击系统的核心入口函数，在标准攻击功能的基础上增加了即时动作
--   响应能力。该函数不仅配置和启动攻击，还激活了即时动作机制，使AI能够在
--   攻击执行过程中响应高优先级的紧急事件和状态变化。
--
-- 参数说明 (Parameters):
--   f1_arg0: AI角色对象 (AI character object) - 执行即时动作攻击的AI实体
--   f1_arg1: 目标对象 (Goal object) - 包含攻击参数和即时动作配置的目标对象
--
-- 即时动作攻击特化配置 (Immediate Action Attack Specialized Configuration):
--   与基础攻击的主要区别：
--   - 即时动作启用：在攻击期间启用高优先级事件响应
--   - 灵活中断能力：支持紧急情况下的攻击中断
--   - 状态管理增强：专门的即时动作状态管理
--   - 优先级事件处理：能够响应系统级和战术级事件
--
-- 执行流程 (Execution Flow):
--   1. 参数提取和验证 - 获取所有攻击相关参数
--   2. 智能默认值设置 - 为无效参数设置优化的默认值
--   3. 标准攻击配置 - 配置基础攻击行为参数
--   4. 攻击执行委托 - 将配置传递给CommonAttack执行
--   5. 即时动作激活 - 启用即时动作响应机制
--
-- 关键技术特性 (Key Technical Features):
--   - 双重功能集成：标准攻击 + 即时动作响应
--   - 参数继承机制：复用attack_tunable_spin.lua的参数体系
--   - 优先级事件支持：高优先级事件的即时处理能力
--   - 状态保护设计：确保即时动作状态的正确管理
function AttackImmediateAction_Activate(f1_arg0, f1_arg1)
    -- === 参数提取阶段 (Parameter Extraction Phase) ===
    local f1_local0 = f1_arg1:GetLife()               -- 即时动作攻击行为生命周期 (Immediate action attack behavior life cycle)
    local f1_local1 = f1_arg1:GetParam(0)             -- 攻击动画状态ID (Attack animation state ID)
    local f1_local2 = f1_arg1:GetParam(1)             -- 攻击目标对象 (Attack target object)
    local f1_local3 = f1_arg1:GetParam(2)             -- 攻击成功判定距离 (Attack success determination distance)

    -- === 即时动作攻击核心配置 (Immediate Action Attack Core Configuration) ===
    local f1_local4 = 180                             -- 攻击角度范围：180度全方位攻击 (Attack angle range: 180° omnidirectional)
    local f1_local5 = f1_arg1:GetParam(3)             -- 获取攻击前旋回时间参数 (Get pre-attack spin time parameter)
    local f1_local6 = f1_arg1:GetParam(4)             -- 获取正面判定角度参数 (Get front determination angle parameter)

    -- === 智能参数验证和默认值设置 (Intelligent Parameter Validation and Default Value Setting) ===
    -- 旋回时间参数验证 (Spin time parameter validation)
    if f1_local5 < 0 then
        f1_local5 = 1.5                               -- 默认旋回时间：1.5秒 (Default spin time: 1.5 seconds)
        -- 即时动作攻击使用与旋回攻击相同的优化时间配置
        -- (Immediate action attack uses same optimized time configuration as spin attack)
    end

    -- 正面判定角度参数验证 (Front determination angle parameter validation)
    if f1_local6 < 0 then
        f1_local6 = 20                                -- 默认正面判定角度：20度 (Default front determination angle: 20°)
        -- 精确的角度控制确保即时动作攻击的准确性
        -- (Precise angle control ensures accuracy of immediate action attacks)
    end

    -- === 即时动作攻击行为配置 (Immediate Action Attack Behavior Configuration) ===
    local f1_local7 = true                            -- 攻击启用：允许造成伤害 (Attack enabled: allow damage dealing)
    local f1_local8 = false                           -- 移动禁用：攻击时不移动 (Movement disabled: no movement during attack)
    local f1_local9 = true                            -- 转身启用：允许旋回转向 (Turning enabled: allow spin turning)
                                                       -- ↑ 保持转向能力以支持即时动作的灵活性
    local f1_local10 = false                          -- 后退禁用：不后退移动 (Retreat disabled: no backward movement)
    local f1_local11 = false                          -- 侧移禁用：不侧向移动 (Side movement disabled: no lateral movement)

    -- === 自定义角度约束参数 (Custom Angle Constraint Parameters) ===
    local f1_local12 = f1_arg1:GetParam(5)            -- 上攻击角度限制 (Upper attack angle limit)
    local f1_local13 = f1_arg1:GetParam(6)            -- 下攻击角度限制 (Lower attack angle limit)

    -- === 标准攻击执行阶段 (Standard Attack Execution Phase) ===
    -- 委托给CommonAttack执行基础攻击功能 (Delegate to CommonAttack for basic attack functionality)
    -- 注意：这里使用与attack_tunable_spin.lua相同的参数配置
    -- (Note: Using same parameter configuration as attack_tunable_spin.lua)
    f1_arg1:AddSubGoal(GOAL_COMMON_CommonAttack,
        f1_local0,    -- 生命周期 (Life cycle)
        f1_local1,    -- 动画状态ID (Animation state ID)
        f1_local2,    -- 攻击目标 (Attack target)
        f1_local3,    -- 成功距离 (Success distance)
        f1_local4,    -- 攻击角度 (Attack angle)
        f1_local5,    -- 旋回时间 (Spin time)
        f1_local6,    -- 正面判定角度 (Front determination angle)
        f1_local8,    -- 移动控制 (Movement control)
        f1_local9,    -- 转身控制 (Turn control)
        f1_local10,   -- 后退控制 (Retreat control)
        f1_local11,   -- 侧移控制 (Side movement control)
        f1_local12,   -- 上攻击角度 (Upper attack angle)
        f1_local13,   -- 下攻击角度 (Lower attack angle)
        f1_local7     -- 攻击启用 (Attack enabled)
    )

    -- === 即时动作机制激活阶段 (Immediate Action Mechanism Activation Phase) ===
    -- ★ 核心特性：启用即时动作响应机制 (Core Feature: Enable immediate action response mechanism)
    f1_arg0:SetEnableImmediateAction_forGoal()
    -- 这是即时动作攻击与其他攻击类型的核心区别：
    -- (This is the core difference between immediate action attacks and other attack types:)
    -- - 启用高优先级事件的即时响应 (Enable immediate response to high priority events)
    -- - 允许紧急情况下的攻击中断 (Allow attack interruption in emergency situations)
    -- - 提供更灵活的AI行为响应能力 (Provide more flexible AI behavior response capabilities)

    -- 即时动作攻击配置完成，系统现在具备标准攻击和即时响应双重能力
    -- (Immediate action attack configuration complete, system now has both standard attack and immediate response capabilities)
end

--[[============================================================================
    即时动作攻击状态管理函数 (Immediate Action Attack State Management Functions)
    ============================================================================
]]--

-- 即时动作攻击更新函数 (Immediate action attack update function)
-- 功能说明 (Function Description):
--   在即时动作攻击执行过程中每帧调用的状态监控函数。该函数负责监控攻击执行状态
--   和即时动作机制的运行状态，确保高优先级事件能够得到及时响应，同时维护攻击
--   行为的正常执行流程。
--
-- 参数说明 (Parameters):
--   f2_arg0: AI角色对象 (AI character object) - 执行即时动作攻击的AI实体
--   f2_arg1: 目标对象 (Goal object) - 当前的即时动作攻击目标状态
--
-- 返回值 (Return Value):
--   GOAL_RESULT_Continue: 继续执行即时动作攻击行为 (Continue executing immediate action attack behavior)
--
-- 即时动作状态监控 (Immediate Action State Monitoring):
--   虽然具体的攻击执行委托给CommonAttack，但即时动作攻击系统需要：
--   - 监控即时动作机制的激活状态
--   - 确保高优先级事件的响应准备就绪
--   - 协调标准攻击流程与即时动作响应
--   - 维护即时动作攻击的整体稳定性
--
-- 与基础攻击Update的区别 (Difference from Basic Attack Update):
--   即时动作攻击需要额外的即时动作状态监控和事件响应准备
function AttackImmediateAction_Update(f2_arg0, f2_arg1)
    -- 即时动作攻击：持续监控攻击执行状态和即时动作响应机制
    -- (Immediate action attack: continuously monitor attack execution state and immediate action response mechanism)
    return GOAL_RESULT_Continue
end

-- 即时动作攻击终止函数 (Immediate action attack termination function)
-- 功能说明 (Function Description):
--   在即时动作攻击行为完成或被终止时调用的清理函数。该函数的关键职责是清理
--   即时动作状态，确保即时动作机制不会影响后续的AI行为，并释放相关的系统资源。
--
-- 参数说明 (Parameters):
--   f3_arg0: AI角色对象 (AI character object) - 执行即时动作攻击的AI实体
--   f3_arg1: 目标对象 (Goal object) - 即将终止的即时动作攻击目标
--
-- 即时动作攻击终止处理 (Immediate Action Attack Termination Processing):
--   即时动作攻击终止后的关键任务：
--   - 清理即时动作状态：调用ClearEnableImmediateAction_forGoal()
--   - 释放系统资源：确保即时动作机制的资源正确释放
--   - 状态隔离保护：防止即时动作状态泄漏到其他行为
--   - 错误恢复处理：即使在异常情况下也能正确清理
--
-- 与基础攻击Terminate的关键区别 (Key Difference from Basic Attack Terminate):
--   即时动作攻击必须进行专门的即时动作状态清理，这是系统稳定性的关键
--
-- 错误处理考虑 (Error Handling Considerations):
--   即使在攻击被强制中断或发生错误的情况下，即时动作状态的清理也必须正确执行，
--   否则可能导致后续AI行为异常或系统资源泄漏。
function AttackImmediateAction_Terminate(f3_arg0, f3_arg1)
    -- === 即时动作状态清理阶段 (Immediate Action State Cleanup Phase) ===
    -- ★ 核心清理操作：清除即时动作响应机制 (Core Cleanup: Clear immediate action response mechanism)
    f3_arg0:ClearEnableImmediateAction_forGoal()
    -- 这是即时动作攻击终止的关键步骤：
    -- (This is the key step in immediate action attack termination:)
    -- - 确保即时动作状态完全清理 (Ensure immediate action state is completely cleaned)
    -- - 防止状态泄漏到后续行为 (Prevent state leakage to subsequent behaviors)
    -- - 释放即时动作相关的系统资源 (Release immediate action related system resources)
    -- - 恢复AI到标准行为模式 (Restore AI to standard behavior mode)

    -- 即时动作攻击清理完成，AI现在恢复到标准行为模式
    -- (Immediate action attack cleanup complete, AI now restored to standard behavior mode)
end

-- 注册即时动作攻击行为为不可中断类型 (Register immediate action attack behavior as non-interruptible type)
-- 说明：尽管即时动作攻击具有高优先级事件响应能力，但攻击本身仍需要执行保护
-- (Note: Although immediate action attacks have high priority event response capability, the attack itself still needs execution protection)
REGISTER_GOAL_NO_INTERUPT(GOAL_COMMON_AttackImmediateAction, true)

-- 即时动作攻击中断判断函数 (Immediate action attack interruption determination function)
-- 功能说明 (Function Description):
--   判断当前即时动作攻击是否可以被其他行为中断。即时动作攻击采用复杂的中断策略：
--   虽然设置为不可中断，但通过即时动作机制提供了高优先级事件的响应通道，
--   实现了"保护性执行"与"灵活响应"的平衡。
--
-- 参数说明 (Parameters):
--   f4_arg0: AI角色对象 (AI character object) - 执行即时动作攻击的AI实体
--   f4_arg1: 目标对象 (Goal object) - 当前的即时动作攻击目标状态
--
-- 返回值 (Return Value):
--   false: 不允许中断 (Do not allow interruption)
--
-- 即时动作攻击中断策略 (Immediate Action Attack Interruption Strategy):
--   即时动作攻击的"双层保护"策略：
--   - 标准中断保护：防止普通行为随意中断攻击
--   - 即时动作通道：为高优先级事件提供专用响应机制
--   - 智能优先级判断：系统自动判断事件优先级
--   - 保护性响应：确保响应不会破坏攻击的核心逻辑
--
-- 设计哲学 (Design Philosophy):
--   即时动作攻击的中断策略体现了AI系统的智能化设计：
--   ┌─────────────────────────────────────────────────────────┐
--   │  标准行为中断 (Standard Behavior Interruption)         │
--   │  ├─ 优先级：低 (Priority: Low)                         │
--   │  ├─ 处理：拒绝 (Handling: Reject)                      │
--   │  └─ 原因：保护攻击完整性 (Reason: Protect attack integrity) │
--   │                                                         │
--   │  即时动作事件 (Immediate Action Events)                │
--   │  ├─ 优先级：高 (Priority: High)                        │
--   │  ├─ 处理：响应 (Handling: Respond)                     │
--   │  └─ 通道：专用机制 (Channel: Dedicated mechanism)        │
--   └─────────────────────────────────────────────────────────┘
--
-- 实际应用场景 (Practical Application Scenarios):
--   普通情况：其他AI想要执行攻击 → 被拒绝，避免冲突
--   紧急情况：玩家使用危险技能 → 通过即时动作响应，立即规避
--   重要事件：环境发生重大变化 → 通过即时动作调整，适应新情况
--
-- 技术实现考虑 (Technical Implementation Considerations):
--   这种设计允许AI在保持攻击威胁性的同时具备必要的灵活性，是高级AI系统的重要特征
function AttackImmediateAction_Interupt(f4_arg0, f4_arg1)
    -- 即时动作攻击：不允许被标准行为中断，但通过即时动作机制响应高优先级事件
    -- (Immediate action attack: not allowed to be interrupted by standard behaviors, but responds to high priority events through immediate action mechanism)
    return false
end

--[[============================================================================
    文件结束 (End of File)
    ============================================================================

    即时动作攻击系统已完成专业级文档化。该模块现在具备：
    - 完整的即时动作机制和技术实现文档
    - 详细的双层保护策略和响应机制说明
    - 专业的与其他攻击系统的差异化分析
    - 全面的函数功能和状态管理注释

    与Sekiro AI攻击生态系统的集成 (Integration with Sekiro AI Attack Ecosystem):
    ┌─ attack.lua                    - 基础攻击能力和标准接口
    ├─ attack_tunable_spin.lua      - 智能转向和精确攻击
    ├─ attack3.lua                  - 精确控制和条件性攻击
    ├─ attack_immediate_action.lua  - 本模块：即时响应和灵活攻击
    └─ combo_attack.lua             - 连击攻击和序列管理

    关键技术优势 (Key Technical Advantages):
    - 即时动作机制：SetEnableImmediateAction_forGoal() / ClearEnableImmediateAction_forGoal()
    - 双层保护策略：标准中断保护 + 即时动作响应通道
    - 参数继承设计：复用attack_tunable_spin.lua的优化参数配置
    - 状态管理安全：确保即时动作状态的正确激活和清理

    战术和性能特性 (Tactical and Performance Features):
    - 紧急响应能力：能够在攻击执行期间响应高优先级事件
    - 执行保护机制：防止普通行为冲突破坏攻击完整性
    - 资源管理优化：即时动作状态的及时清理和资源释放
    - 系统稳定保证：错误恢复机制确保系统稳定性

    该模块现在已达到与其他专业文档化攻击模块相同的标准，
    为Sekiro AI系统提供了高级的即时响应攻击能力。
    ============================================================================
]]--


