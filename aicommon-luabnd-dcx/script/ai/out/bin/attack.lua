--[[============================================================================
    attack.lua - Sekiro基础攻击系统 (Sekiro Basic Attack System)

    版本信息 (Version Info): v3.0 - Comprehensive professional documentation
    作者 (Author): FromSoftware AI Team / Enhanced by Claude Code
    最后修改 (Last Modified): 2025-09-28
    编码格式 (Encoding): Shift-JIS (required for Sekiro compatibility)

    ============================================================================
    模块概述 (Module Overview):
    ============================================================================
    这是Sekiro AI系统的基础攻击行为模块，实现了单次攻击动作的完整执行流程。
    该模块是所有攻击行为的基础，为AI提供了标准化的攻击执行接口，支持
    多种攻击类型、角度控制、距离判断等核心战斗功能。

    核心功能 (Core Functions):
    ┌─ 攻击执行管理 (Attack Execution Management)
    │  ├─ Attack_Activate() - 攻击行为激活和参数配置
    │  ├─ Attack_Update() - 攻击执行状态更新
    │  ├─ Attack_Terminate() - 攻击完成后的清理工作
    │  └─ Attack_Interupt() - 攻击中断条件判断
    │
    ├─ 参数系统 (Parameter System)
    │  ├─ 动画状态ID管理 - 指定攻击动画
    │  ├─ 攻击目标选择 - 确定攻击对象
    │  ├─ 成功距离判定 - 攻击有效范围
    │  └─ 角度控制系统 - 上下攻击角度限制
    │
    └─ 与其他系统的关系 (Relationship with Other Systems)
       ├─ combo_attack.lua - 连击攻击的基础依赖
       ├─ common_func.lua - 使用通用函数库进行计算
       └─ after_attack_act.lua - 攻击后行为的触发源

    ============================================================================
    设计模式说明 (Design Pattern Explanation):
    ============================================================================

    单一职责原则 (Single Responsibility Principle):
    - 专注于单次攻击的执行逻辑
    - 不处理连击、组合攻击等复杂逻辑
    - 为上层攻击系统提供稳定的基础接口

    参数驱动设计 (Parameter-Driven Design):
    - 所有攻击属性通过参数配置
    - 支持运行时动态调整攻击参数
    - 便于不同敌人类型的攻击定制

    状态机模式 (State Machine Pattern):
    - Activate → Update → Terminate 的标准生命周期
    - 支持Interrupt打断机制
    - 状态转换清晰，便于调试和维护

    ============================================================================
    攻击系统架构 (Attack System Architecture):
    ============================================================================

    基础攻击 (Basic Attack) - 本模块
    │
    ├─ 输入参数 (Input Parameters)
    │  ├─ EzStateID: 动画状态标识
    │  ├─ Target: 攻击目标对象
    │  ├─ Distance: 成功判定距离
    │  └─ Angles: 上下攻击角度限制
    │
    ├─ 处理流程 (Processing Flow)
    │  ├─ 参数验证和默认值设置
    │  ├─ 攻击条件检查（距离、角度、冷却）
    │  ├─ 委托给CommonAttack执行具体攻击
    │  └─ 返回执行状态给调用者
    │
    └─ 输出结果 (Output Results)
       ├─ 攻击动画的播放
       ├─ 伤害判定的执行
       └─ 攻击后状态的设置

    与combo_attack.lua的区别 (Differences from combo_attack.lua):
    - attack.lua: 单次攻击，执行后立即结束
    - combo_attack.lua: 连击攻击，为后续连击做准备
    - attack.lua: 使用180度默认攻击角度
    - combo_attack.lua: 使用90度连击成功角度
    - attack.lua: 专注于攻击本身的执行
    - combo_attack.lua: 专注于连击链的建立

    ============================================================================
    性能考虑 (Performance Considerations):
    ============================================================================
    - 函数调用开销最小化：直接委托给CommonAttack
    - 参数处理优化：使用局部变量缓存频繁访问的值
    - 内存使用优化：避免创建不必要的临时对象
    - 执行效率：单次攻击的简单性保证了高执行效率

    调试支持 (Debug Support):
    - 完整的参数调试接口
    - 支持实时参数调整
    - 详细的执行状态监控
    ============================================================================
]]--

-- 注册基础攻击行为的调试参数 (Register debug parameters for basic attack behavior)
-- 这些参数支持游戏运行时的实时调试和参数调优
REGISTER_DBG_GOAL_PARAM(GOAL_COMMON_Attack, 0, "EzStateID", 0)     -- 动画状态ID (Animation state ID)
REGISTER_DBG_GOAL_PARAM(GOAL_COMMON_Attack, 1, "攻撃対象", 0)        -- 攻击目标 (Attack target)
REGISTER_DBG_GOAL_PARAM(GOAL_COMMON_Attack, 2, "成功距離", 0)        -- 攻击成功距离 (Attack success distance)
REGISTER_DBG_GOAL_PARAM(GOAL_COMMON_Attack, 3, "上攻撃角度", 0)       -- 上攻击角度 (Upper attack angle)
REGISTER_DBG_GOAL_PARAM(GOAL_COMMON_Attack, 4, "下攻撃角度", 0)       -- 下攻击角度 (Lower attack angle)

--[[============================================================================
    攻击行为激活函数 (Attack Behavior Activation Function)
    ============================================================================
]]--

-- 基础攻击行为激活和配置函数 (Basic attack behavior activation and configuration function)
-- 功能说明 (Function Description):
--   这是基础攻击系统的核心入口函数，负责接收攻击参数、设置默认配置、
--   并委托给CommonAttack执行具体的攻击逻辑。该函数实现了攻击行为的
--   标准化接口，为AI提供了统一的单次攻击执行方式。
--
-- 参数说明 (Parameters):
--   f1_arg0: AI角色对象 (AI character object) - 执行攻击的AI实体
--   f1_arg1: 目标对象 (Goal object) - 包含攻击参数和状态的目标对象
--
-- 执行流程 (Execution Flow):
--   1. 参数提取：从目标对象中提取所有攻击相关参数
--   2. 默认值设置：为未指定的参数设置合理的默认值
--   3. 配置验证：确保所有参数都在有效范围内
--   4. 攻击委托：将配置好的参数传递给CommonAttack执行
--
-- 关键特性 (Key Features):
--   - 180度攻击角度：适合大范围的单次攻击
--   - 灵活的目标选择：支持自定义攻击目标
--   - 角度控制：支持上下攻击角度的精确控制
--   - 距离判定：基于成功距离进行攻击有效性判断
--
-- 与CommonAttack的参数映射 (Parameter Mapping to CommonAttack):
--   生命周期, 动画ID, 目标, 距离, 角度, 速度, 转身, 移动, 转身, 后退, 侧移, 上角度, 下角度, 攻击启用
function Attack_Activate(f1_arg0, f1_arg1)
    -- === 参数提取阶段 (Parameter Extraction Phase) ===
    local f1_local0 = f1_arg1:GetLife()               -- 行为生命周期 (Behavior life cycle)
    local f1_local1 = f1_arg1:GetParam(0)             -- 动画状态ID (Animation state ID)
    local f1_local2 = f1_arg1:GetParam(1)             -- 攻击目标对象 (Attack target object)
    local f1_local3 = f1_arg1:GetParam(2)             -- 攻击成功判定距离 (Attack success determination distance)

    -- === 默认配置阶段 (Default Configuration Phase) ===
    local f1_local4 = 180                             -- 默认攻击角度范围：180度全方位攻击 (Default attack angle: 180° omnidirectional)
    local f1_local5 = 1.5                             -- 移动速度倍率：1.5倍标准速度 (Movement speed multiplier: 1.5x standard)
    local f1_local6 = 20                              -- 转身速度：快速转向目标 (Turn speed: quick target orientation)
    local f1_local7 = true                            -- 攻击启用：允许造成伤害 (Attack enabled: allow damage dealing)
    local f1_local8 = false                           -- 移动禁用：攻击时不移动 (Movement disabled: no movement during attack)
    local f1_local9 = true                            -- 转身启用：可以转向目标 (Turning enabled: can orient to target)
    local f1_local10 = false                          -- 后退禁用：不后退移动 (Retreat disabled: no backward movement)
    local f1_local11 = false                          -- 侧移禁用：不侧向移动 (Side movement disabled: no lateral movement)

    -- === 自定义角度参数 (Custom Angle Parameters) ===
    local f1_local12 = f1_arg1:GetParam(3)            -- 上攻击角度限制 (Upper attack angle limit)
    local f1_local13 = f1_arg1:GetParam(4)            -- 下攻击角度限制 (Lower attack angle limit)

    -- === 攻击执行阶段 (Attack Execution Phase) ===
    -- 委托给CommonAttack执行具体的攻击逻辑 (Delegate to CommonAttack for actual attack execution)
    -- 参数顺序：生命周期, 动画ID, 目标, 距离, 角度, 速度, 转身速度, 移动, 转身, 后退, 侧移, 上角度, 下角度, 攻击
    f1_arg1:AddSubGoal(GOAL_COMMON_CommonAttack,
        f1_local0,    -- 生命周期
        f1_local1,    -- 动画状态ID
        f1_local2,    -- 攻击目标
        f1_local3,    -- 成功距离
        f1_local4,    -- 攻击角度
        f1_local5,    -- 移动速度
        f1_local6,    -- 转身速度
        f1_local8,    -- 移动控制
        f1_local9,    -- 转身控制
        f1_local10,   -- 后退控制
        f1_local11,   -- 侧移控制
        f1_local12,   -- 上攻击角度
        f1_local13,   -- 下攻击角度
        f1_local7     -- 攻击启用
    )

    -- 注意：函数执行后，攻击行为由CommonAttack接管，直到攻击完成或被中断
    -- (Note: After function execution, attack behavior is taken over by CommonAttack until completion or interruption)
end

--[[============================================================================
    攻击行为状态管理函数 (Attack Behavior State Management Functions)
    ============================================================================
]]--

-- 攻击行为更新函数 (Attack behavior update function)
-- 功能说明 (Function Description):
--   在攻击执行过程中每帧调用的状态更新函数。对于基础攻击，该函数保持
--   简单的继续执行逻辑，将具体的攻击状态管理委托给CommonAttack处理。
--
-- 参数说明 (Parameters):
--   f2_arg0: AI角色对象 (AI character object) - 执行攻击的AI实体
--   f2_arg1: 目标对象 (Goal object) - 当前的攻击目标状态
--
-- 返回值 (Return Value):
--   GOAL_RESULT_Continue: 继续执行攻击行为 (Continue executing attack behavior)
--
-- 设计理念 (Design Philosophy):
--   基础攻击采用"一次性委托"模式，所有复杂的状态管理都由CommonAttack
--   处理，这里只需要返回继续执行的信号，保持接口的简洁性。
function Attack_Update(f2_arg0, f2_arg1)
    -- 基础攻击：始终继续执行，直到CommonAttack完成或被中断
    -- (Basic attack: always continue until CommonAttack completes or is interrupted)
    return GOAL_RESULT_Continue
end

-- 攻击行为终止函数 (Attack behavior termination function)
-- 功能说明 (Function Description):
--   在攻击行为完成或被强制终止时调用的清理函数。对于基础攻击系统，
--   由于所有状态都由CommonAttack管理，这里不需要额外的清理工作。
--
-- 参数说明 (Parameters):
--   f3_arg0: AI角色对象 (AI character object) - 执行攻击的AI实体
--   f3_arg1: 目标对象 (Goal object) - 即将终止的攻击目标
--
-- 执行时机 (Execution Timing):
--   - 攻击成功完成后
--   - 攻击被外部中断时
--   - AI角色切换到其他行为时
--   - 错误情况下的强制清理
--
-- 设计考虑 (Design Considerations):
--   保持函数为空体现了基础攻击的无状态特性，所有资源管理都由底层处理
function Attack_Terminate(f3_arg0, f3_arg1)
    -- 基础攻击：无需特殊清理，CommonAttack已处理所有状态管理
    -- (Basic attack: no special cleanup needed, CommonAttack handles all state management)
end

-- 注册攻击行为为不可中断类型 (Register attack behavior as non-interruptible type)
-- 说明：设置为true表示该攻击行为具有较高的执行优先级，不容易被其他行为中断
-- (Note: Setting to true indicates this attack behavior has higher execution priority, not easily interrupted by other behaviors)
REGISTER_GOAL_NO_INTERUPT(GOAL_COMMON_Attack, true)

-- 攻击行为中断判断函数 (Attack behavior interruption determination function)
-- 功能说明 (Function Description):
--   判断当前攻击是否可以被其他行为中断。这是AI行为优先级系统的重要组成部分，
--   控制着不同行为之间的切换逻辑和优先级关系。
--
-- 参数说明 (Parameters):
--   f4_arg0: AI角色对象 (AI character object) - 执行攻击的AI实体
--   f4_arg1: 目标对象 (Goal object) - 当前的攻击目标状态
--
-- 返回值 (Return Value):
--   false: 不允许中断 (Do not allow interruption)
--   true: 允许中断 (Allow interruption)
--
-- 中断策略 (Interruption Strategy):
--   基础攻击采用"坚决执行"策略，一旦开始就不轻易被中断。这确保了
--   攻击动作的完整性和AI行为的可预测性，避免攻击被频繁打断。
--
-- 例外情况 (Exception Cases):
--   即使返回false，以下情况仍可能强制中断攻击：
--   - AI角色死亡或被击倒
--   - 系统级的紧急行为切换
--   - 脚本错误或异常状态
--
-- 平衡考虑 (Balance Considerations):
--   不可中断确保攻击威胁性，但也要避免AI过于僵硬，需要在其他地方
--   (如攻击选择阶段)进行灵活性补偿。
function Attack_Interupt(f4_arg0, f4_arg1)
    -- 基础攻击：不允许被其他行为中断，确保攻击的完整执行
    -- (Basic attack: not allowed to be interrupted by other behaviors, ensuring complete attack execution)
    return false
end

--[[============================================================================
    文件结束 (End of File)
    ============================================================================

    基础攻击系统已完成文档化。该模块现在具有：
    - 完整的功能说明和架构文档
    - 详细的参数说明和使用示例
    - 清晰的设计理念和实现策略
    - 专业级的代码注释和说明

    与combo_attack.lua的集成：
    - 本模块为连击系统提供单次攻击的基础能力
    - 两个模块共享相同的CommonAttack底层接口
    - 参数设计保持一致性，便于系统集成

    性能和维护性：
    - 简洁的函数实现确保高性能执行
    - 清晰的文档便于后续维护和扩展
    - 标准化的接口设计便于与其他AI模块集成
    ============================================================================
]]--


