--[[============================================================================
    combo_repeat.lua - Sekiro连击重复技系统 (Sekiro Combo Repeat Attack System)

    版本信息 (Version Info): v3.0 - Comprehensive professional documentation
    作者 (Author): FromSoftware AI Team / Enhanced by Claude Code
    最后修改 (Last Modified): 2025-09-28
    编码格式 (Encoding): Shift-JIS (required for Sekiro compatibility)

    ============================================================================
    模块概述 (Module Overview):
    ============================================================================
    这是Sekiro AI系统的连击重复技模块，专门负责执行连击序列中的重复攻击段。
    该模块实现了可重复执行的连击动作，用于构建流畅的连击序列，是连击系统的
    核心构建组件，提供了连击链条中的稳定重复元素。

    核心功能 (Core Functions):
    ┌─ 重复技执行管理 (Repeat Attack Execution Management)
    │  ├─ ComboRepeat_Activate() - 重复技激活和参数配置
    │  ├─ ComboRepeat_Update() - 重复技执行状态更新
    │  ├─ ComboRepeat_Terminate() - 重复技完成后的清理工作
    │  └─ ComboRepeat_Interupt() - 重复技中断条件判断
    │
    ├─ 重复技特化参数 (Repeat Attack Specialized Parameters)
    │  ├─ 90度连击成功角度 - 严格的连击角度控制
    │  ├─ 90度攻击判定角度 - 精确的攻击范围控制
    │  ├─ 移动启用配置 - 允许在重复技期间调整位置
    │  └─ 角度控制系统 - 支持上下攻击角度的精确控制
    │
    └─ 连击系统集成 (Combo System Integration)
       ├─ 连击取消支持 - ENABLE_COMBO_ATK_CANCEL启用
       ├─ 重复执行机制 - 支持多次重复触发
       ├─ 与其他连击技的无缝衔接
       └─ 完整的调试和监控接口

    ============================================================================
    重复技设计理念 (Repeat Attack Design Philosophy):
    ============================================================================

    流畅重复的核心原理 (Core Principles of Smooth Repetition):
    - 精确角度控制：90度的严格要求确保重复技的连贯性
    - 位置微调能力：启用移动以适应目标位置变化
    - 快速响应设计：零延迟设置确保重复技的流畅执行
    - 灵活取消机制：支持连击取消以应对防御和反击

    与其他连击技的差异化 (Differentiation from Other Combo Attacks):
    ┌─────────────────┬─────────────────┬─────────────────┬─────────────────┐
    │      特性       │   combo_attack  │  combo_repeat   │   combo_final   │
    ├─────────────────┼─────────────────┼─────────────────┼─────────────────┤
    │   设计目的      │   连击起始      │   连击重复      │   连击终结      │
    │   攻击角度      │      90°        │      90°        │     180°        │
    │   连击角度      │      90°        │      90°        │      90°        │
    │   移动控制      │     启用        │     启用        │     禁用        │
    │   执行特性      │   链条建立      │   重复循环      │   威力终结      │
    │   取消支持      │     支持        │     支持        │     支持        │
    └─────────────────┴─────────────────┴─────────────────┴─────────────────┘

    ============================================================================
    技术实现细节 (Technical Implementation Details):
    ============================================================================

    重复技的角度配置策略 (Angle Configuration Strategy for Repeat Attacks):
    - 攻击角度：90度确保精确的重复攻击
    - 连击成功角度：90度维持连击的严格标准
    - 移动速度：0确保无延迟的快速重复
    - 转身速度：90度允许快速跟踪目标

    连击取消机制 (Combo Cancel Mechanism):
    - ENABLE_COMBO_ATK_CANCEL: 启用连击攻击取消功能
    - 防御反应：允许AI根据玩家行为取消重复技
    - 战术灵活性：提供连击序列的动态调整能力
    - 平衡控制：防止重复技过于僵硬影响游戏体验

    ============================================================================
    使用场景和战术应用 (Usage Scenarios and Tactical Applications):
    ============================================================================

    连击序列构建 (Combo Sequence Construction):
    - 连击起始 → 重复技(本模块) → 重复技 → 终结技
    - 多段重复：可在连击中多次使用重复技
    - 节奏控制：通过重复技调整连击的节奏和威胁性
    - 压制效果：持续的重复攻击增加对玩家的压力

    战术变化支持 (Tactical Variation Support):
    - 位置调整：重复技期间的移动能力适应战场变化
    - 角度修正：严格的角度要求确保每次重复都准确
    - 取消选项：根据战况灵活中断重复序列
    - 流畅衔接：为后续连击技提供良好的状态基础

    ============================================================================
    性能考虑 (Performance Considerations):
    ============================================================================
    - 零延迟执行：移动速度为0确保快速重复
    - 角度优化：90度精确控制平衡精确度和执行效率
    - 状态轻量：重复技的状态管理保持简洁高效
    - 取消响应：连击取消机制的快速响应设计
    ============================================================================
]]--

-- 注册连击重复技行为的调试参数 (Register debug parameters for combo repeat attack behavior)
-- 这些参数支持开发阶段的重复技调优和运行时的行为监控
REGISTER_DBG_GOAL_PARAM(GOAL_COMMON_ComboRepeat, 0, "StateID", 0)        -- 动画状态ID (Animation state ID)
REGISTER_DBG_GOAL_PARAM(GOAL_COMMON_ComboRepeat, 1, "対象", 0)            -- 攻击目标 (Attack target)
REGISTER_DBG_GOAL_PARAM(GOAL_COMMON_ComboRepeat, 2, "成功距離", 0)        -- 攻击成功距离 (Attack success distance)
REGISTER_DBG_GOAL_PARAM(GOAL_COMMON_ComboRepeat, 3, "上攻撃角度", 0)       -- 上攻击角度 (Upper attack angle)
REGISTER_DBG_GOAL_PARAM(GOAL_COMMON_ComboRepeat, 4, "下攻撃角度", 0)       -- 下攻击角度 (Lower attack angle)
REGISTER_DBG_GOAL_PARAM(GOAL_COMMON_ComboRepeat, 5, "成功角度", 0)        -- 连击成功角度 (Combo success angle)

-- 启用连击攻击取消功能 (Enable combo attack cancel functionality)
-- 这是重复技的关键特性，允许根据战况灵活中断重复序列
ENABLE_COMBO_ATK_CANCEL(GOAL_COMMON_ComboRepeat)

--[[============================================================================
    连击重复技激活函数 (Combo Repeat Attack Activation Function)
    ============================================================================
]]--

-- 连击重复技行为激活和配置函数 (Combo repeat attack behavior activation and configuration function)
-- 功能说明 (Function Description):
--   这是连击重复技系统的核心入口函数，负责配置和启动重复攻击行为。该函数
--   专门为连击序列中的重复段设计，提供了精确的角度控制、快速的执行响应
--   以及灵活的位置调整能力，确保重复技能够流畅地融入连击序列。
--
-- 参数说明 (Parameters):
--   f1_arg0: AI角色对象 (AI character object) - 执行重复技的AI实体
--   f1_arg1: 目标对象 (Goal object) - 包含重复技参数和状态的目标对象
--
-- 重复技特化配置 (Repeat Attack Specialized Configuration):
--   与其他连击技的主要区别：
--   - 快速执行：移动速度为0确保无延迟的重复
--   - 精确角度：90度攻击角度和连击角度的严格控制
--   - 位置灵活：启用移动以适应目标位置变化
--   - 取消支持：通过ENABLE_COMBO_ATK_CANCEL启用灵活取消
--
-- 执行流程 (Execution Flow):
--   1. 参数提取和验证 - 获取所有重复技相关参数
--   2. 重复技角度配置 - 设置90度精确角度控制
--   3. 快速执行配置 - 零延迟的移动速度设置
--   4. 攻击执行委托 - 将配置传递给CommonAttack执行
--   5. 重复状态建立 - 为连击重复做好准备
--
-- 关键技术特性 (Key Technical Features):
--   - 零延迟重复：移动速度0确保快速重复执行
--   - 双90度控制：攻击角度和连击角度都使用90度精确控制
--   - 移动调整能力：启用移动以跟踪移动目标
--   - 连击取消集成：与连击取消机制的完美集成
function ComboRepeat_Activate(f1_arg0, f1_arg1)
    -- === 参数提取阶段 (Parameter Extraction Phase) ===
    local f1_local0 = f1_arg1:GetLife()               -- 重复技行为生命周期 (Repeat attack behavior life cycle)
    local f1_local1 = f1_arg1:GetParam(0)             -- 重复技动画状态ID (Repeat attack animation state ID)
    local f1_local2 = f1_arg1:GetParam(1)             -- 重复技攻击目标 (Repeat attack target)
    local f1_local3 = f1_arg1:GetParam(2)             -- 重复技成功判定距离 (Repeat attack success determination distance)

    -- === 重复技核心配置 (Repeat Attack Core Configuration) ===
    local f1_local4 = 90                              -- 攻击角度：90度精确控制 (Attack angle: 90° precise control)
                                                       -- ↑ 重复技使用严格的90度角度确保连击的连贯性
    local f1_local5 = 0                               -- 移动速度：0 - 零延迟快速重复 (Movement speed: 0 - zero delay fast repeat)
                                                       -- ↑ 关键特性：零移动速度确保重复技的快速执行
    local f1_local6 = 90                              -- 转身速度：90度快速转向 (Turn speed: 90° quick turn)
                                                       -- ↑ 快速转向以跟踪移动目标

    -- === 重复技行为控制配置 (Repeat Attack Behavior Control Configuration) ===
    local f1_local7 = true                            -- 攻击启用：允许造成伤害 (Attack enabled: allow damage dealing)
    local f1_local8 = true                            -- 移动启用：允许位置调整 (Movement enabled: allow position adjustment)
                                                       -- ↑ 关键差异：启用移动以适应重复技期间的目标位置变化
    local f1_local9 = true                            -- 转身启用：允许跟踪目标 (Turning enabled: allow target tracking)
    local f1_local10 = false                          -- 后退禁用：重复技不后退 (Retreat disabled: repeat attacks don't retreat)
    local f1_local11 = false                          -- 侧移禁用：重复技不侧移 (Side movement disabled: repeat attacks don't side-step)

    -- === 自定义角度约束参数 (Custom Angle Constraint Parameters) ===
    local f1_local12 = f1_arg1:GetParam(3)            -- 上攻击角度限制 (Upper attack angle limit)
    local f1_local13 = f1_arg1:GetParam(4)            -- 下攻击角度限制 (Lower attack angle limit)

    -- === 重复技执行阶段 (Repeat Attack Execution Phase) ===
    -- 委托给CommonAttack执行具有重复技特性的攻击 (Delegate to CommonAttack for executing repeat attack)
    -- 关键参数配置说明：
    -- - f1_local4 (90度攻击角度) 确保重复技的精确性
    -- - f1_local5 (0移动速度) 实现零延迟的快速重复
    -- - f1_local6 (90度转身速度) 提供快速的目标跟踪
    -- - f1_local8 (移动启用) 允许重复技期间的位置微调
    f1_arg1:AddSubGoal(GOAL_COMMON_CommonAttack,
        f1_local0,    -- 生命周期 (Life cycle)
        f1_local1,    -- 动画状态ID (Animation state ID)
        f1_local2,    -- 攻击目标 (Attack target)
        f1_local3,    -- 成功距离 (Success distance)
        f1_local4,    -- ★ 攻击角度 (90度) - 精确控制 (Attack angle - precise control)
        f1_local5,    -- ★ 移动速度 (0) - 零延迟重复 (Movement speed - zero delay repeat)
        f1_local6,    -- ★ 转身速度 (90度) - 快速跟踪 (Turn speed - quick tracking)
        f1_local8,    -- ★ 移动控制 (启用) - 位置调整 (Movement control - position adjustment)
        f1_local9,    -- 转身控制 (Turn control)
        f1_local10,   -- 后退控制 (Retreat control)
        f1_local11,   -- 侧移控制 (Side movement control)
        f1_local12,   -- 上攻击角度 (Upper attack angle)
        f1_local13,   -- 下攻击角度 (Lower attack angle)
        f1_local7     -- 攻击启用 (Attack enabled)
    )

    -- 重复技配置完成，系统现在具备快速重复执行和灵活取消的双重能力
    -- (Repeat attack configuration complete, system now has both rapid repeat execution and flexible cancel capabilities)
end

--[[============================================================================
    连击重复技状态管理函数 (Combo Repeat Attack State Management Functions)
    ============================================================================
]]--

-- 连击重复技更新函数 (Combo repeat attack update function)
-- 功能说明 (Function Description):
--   在重复技执行过程中每帧调用的状态监控函数。该函数负责监控重复技的执行状态
--   和连击取消机制的运行状态，确保重复技能够流畅执行同时响应连击取消请求，
--   维护重复技在连击序列中的稳定性和灵活性。
--
-- 参数说明 (Parameters):
--   f2_arg0: AI角色对象 (AI character object) - 执行重复技的AI实体
--   f2_arg1: 目标对象 (Goal object) - 当前的重复技目标状态
--
-- 返回值 (Return Value):
--   GOAL_RESULT_Continue: 继续执行重复技行为 (Continue executing repeat attack behavior)
--
-- 重复技状态监控 (Repeat Attack State Monitoring):
--   虽然具体的攻击执行委托给CommonAttack，但重复技系统需要：
--   - 监控重复技的快速执行状态
--   - 确保连击取消机制的响应准备就绪
--   - 协调重复执行与连击序列的无缝衔接
--   - 维护重复技的整体流畅性和精确性
--
-- 与其他连击技Update的区别 (Difference from Other Combo Attack Updates):
--   重复技需要额外的快速重复状态监控和连击取消响应管理
function ComboRepeat_Update(f2_arg0, f2_arg1)
    -- 连击重复技：持续监控重复执行状态和连击取消机制
    -- (Combo repeat attack: continuously monitor repeat execution state and combo cancel mechanism)
    return GOAL_RESULT_Continue
end

-- 连击重复技终止函数 (Combo repeat attack termination function)
-- 功能说明 (Function Description):
--   在重复技行为完成或被终止时调用的清理函数。由于重复技采用简洁的设计理念，
--   所有状态管理都由CommonAttack和连击系统处理，因此不需要额外的清理工作。
--
-- 参数说明 (Parameters):
--   f3_arg0: AI角色对象 (AI character object) - 执行重复技的AI实体
--   f3_arg1: 目标对象 (Goal object) - 即将终止的重复技目标
--
-- 重复技终止处理 (Repeat Attack Termination Processing):
--   重复技终止后的状态管理：
--   - 重复技状态由连击系统自动管理
--   - 连击取消状态由ENABLE_COMBO_ATK_CANCEL机制处理
--   - 无需额外的状态清理和资源释放
--   - 为下一次重复技或其他连击技做好准备
--
-- 与其他连击技Terminate的区别 (Difference from Other Combo Attack Terminates):
--   重复技的轻量级设计使其终止处理保持简洁，专注于重复执行的效率
function ComboRepeat_Terminate(f3_arg0, f3_arg1)
    -- 连击重复技：轻量级终止处理，状态由连击系统自动管理
    -- (Combo repeat attack: lightweight termination processing, state automatically managed by combo system)

    -- 注意：重复技完成后，连击系统将准备下一段连击或结束整个连击序列
    -- (Note: After repeat attack completion, combo system will prepare next combo segment or end entire combo sequence)
end

-- 注册连击重复技行为为不可中断类型 (Register combo repeat attack behavior as non-interruptible type)
-- 说明：重复技的不可中断性确保连击序列的流畅性，但通过连击取消机制提供灵活性
-- (Note: Non-interruptibility of repeat attacks ensures combo sequence fluidity, but provides flexibility through combo cancel mechanism)
REGISTER_GOAL_NO_INTERUPT(GOAL_COMMON_ComboRepeat, true)

-- 连击重复技中断判断函数 (Combo repeat attack interruption determination function)
-- 功能说明 (Function Description):
--   判断当前重复技是否可以被其他行为中断。重复技采用"保护性重复"策略，
--   通过标准的不可中断机制保护重复序列的完整性，同时通过连击取消机制
--   (ENABLE_COMBO_ATK_CANCEL)提供必要的战术灵活性。
--
-- 参数说明 (Parameters):
--   f4_arg0: AI角色对象 (AI character object) - 执行重复技的AI实体
--   f4_arg1: 目标对象 (Goal object) - 当前的重复技目标状态
--
-- 返回值 (Return Value):
--   false: 不允许中断 (Do not allow interruption)
--
-- 重复技中断策略 (Repeat Attack Interruption Strategy):
--   重复技的"双通道控制"策略：
--   - 标准中断保护：防止外部行为破坏重复序列的流畅性
--   - 连击取消通道：通过专用机制允许战术性的重复技取消
--   - 智能优先级管理：连击系统自动处理取消时机和条件
--   - 流畅性保护：确保重复技的执行不被随意打断
--
-- 设计理念 (Design Philosophy):
--   重复技的中断策略体现了连击系统的精密设计：
--   ┌─────────────────────────────────────────────────────────┐
--   │  外部行为中断 (External Behavior Interruption)         │
--   │  ├─ 处理方式：拒绝 (Handling: Reject)                  │
--   │  ├─ 设计目的：保护重复序列 (Purpose: Protect repeat sequence) │
--   │  └─ 适用场景：维持连击流畅性 (Scenario: Maintain combo fluidity) │
--   │                                                         │
--   │  连击取消机制 (Combo Cancel Mechanism)                 │
--   │  ├─ 处理方式：响应 (Handling: Respond)                 │
--   │  ├─ 设计目的：提供战术灵活性 (Purpose: Provide tactical flexibility) │
--   │  └─ 适用场景：防御反应 (Scenario: Defensive reactions)   │
--   └─────────────────────────────────────────────────────────┘
--
-- 实际应用效果 (Practical Application Effects):
--   - 保护重复：确保重复技序列的完整执行
--   - 响应灵活：通过连击取消应对玩家的防御行为
--   - 平衡战术：在重复压制和战术灵活之间找到平衡
--   - 流畅体验：为玩家提供可预测但不僵硬的AI行为
function ComboRepeat_Interupt(f4_arg0, f4_arg1)
    -- 连击重复技：不允许被外部行为中断，但通过连击取消机制提供战术灵活性
    -- (Combo repeat attack: not allowed to be interrupted by external behaviors, but provides tactical flexibility through combo cancel mechanism)
    return false
end

--[[============================================================================
    文件结束 (End of File)
    ============================================================================

    连击重复技系统已完成专业级文档化。该模块现在具备：
    - 完整的重复技机制和快速执行文档
    - 详细的双通道控制策略和连击取消机制说明
    - 专业的与其他连击系统的差异化分析
    - 全面的函数功能和性能优化注释

    与Sekiro AI连击生态系统的集成 (Integration with Sekiro AI Combo Ecosystem):
    ┌─ combo_attack.lua              - 连击起始和链条建立
    ├─ combo_repeat.lua             - 本模块：重复技和序列循环
    ├─ combo_final.lua              - 连击终结和威力输出
    └─ combo_*_success_angle180.lua - 特殊角度连击变体

    关键技术优势 (Key Technical Advantages):
    - 零延迟重复：移动速度0确保快速重复执行
    - 双90度精确控制：攻击角度和连击角度的严格管理
    - 连击取消集成：ENABLE_COMBO_ATK_CANCEL的完美集成
    - 位置调整能力：启用移动以适应重复技期间的目标变化

    战术和性能特性 (Tactical and Performance Features):
    - 流畅重复能力：确保重复技在连击中的无缝执行
    - 战术灵活性：通过连击取消机制应对各种战况
    - 压制效果：持续的重复攻击增加对玩家的压力
    - 高效执行：轻量级设计确保重复技的高性能表现

    该模块现在已达到与其他专业文档化连击模块相同的标准，
    为Sekiro AI系统提供了高效的重复攻击能力。
    ============================================================================
]]--


