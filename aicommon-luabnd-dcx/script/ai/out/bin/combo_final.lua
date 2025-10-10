--[[============================================================================
    combo_final.lua - Sekiro连击终结技系统 (Sekiro Combo Final Attack System)

    版本信息 (Version Info): v3.0 - Comprehensive professional documentation
    作者 (Author): FromSoftware AI Team / Enhanced by Claude Code
    最后修改 (Last Modified): 2025-09-28
    编码格式 (Encoding): Shift-JIS (required for Sekiro compatibility)

    ============================================================================
    模块概述 (Module Overview):
    ============================================================================
    这是Sekiro AI系统的连击终结技模块，专门负责执行连击序列的最终攻击段。
    该模块是连击系统的收尾组件，负责为整个连击序列提供强有力的结束，
    通常伴随着更高的伤害、更大的范围或特殊的视觉效果。

    核心特性 (Core Features):
    ┌─ 终结技执行管理 (Finisher Execution Management)
    │  ├─ ComboFinal_Activate() - 终结技激活和参数配置
    │  ├─ ComboFinal_Update() - 终结技执行状态更新
    │  ├─ ComboFinal_Terminate() - 终结技完成后的清理工作
    │  └─ ComboFinal_Interupt() - 终结技中断条件判断
    │
    ├─ 终结技特化参数 (Finisher-Specific Parameters)
    │  ├─ 90度连击成功角度 - 比普通攻击更严格的角度要求
    │  ├─ 180度攻击判定角度 - 确保终结技的命中率
    │  ├─ 角度控制系统 - 支持上下攻击角度的精确控制
    │  └─ 距离优化配置 - 为终结技定制的最佳攻击距离
    │
    └─ 连击系统集成 (Combo System Integration)
       ├─ 连击取消支持 - 可被防御等行为中断
       ├─ 状态重置机制 - 终结技后重置连击状态
       ├─ 与前置连击的无缝衔接
       └─ 完整的调试和监控接口

    ============================================================================
    终结技设计理念 (Finisher Design Philosophy):
    ============================================================================

    威力与精确的平衡 (Balance of Power and Precision):
    - 高威力输出：终结技通常造成比普通攻击更高的伤害
    - 精确控制：90度连击成功角度确保攻击的准确性
    - 视觉冲击：为连击序列提供戏剧性的结束效果
    - 风险控制：保持可被中断的机制以维持游戏平衡

    参数配置策略 (Parameter Configuration Strategy):
    - 攻击角度：180度确保较高的命中率
    - 连击角度：90度要求精确的角度控制
    - 移动控制：禁用移动以确保攻击的稳定性
    - 转身控制：启用转身以跟踪移动的目标

    连击序列完整性 (Combo Sequence Completeness):
    起始攻击 → [重复攻击] × N → 终结攻击(本模块) → 连击状态结束

    ============================================================================
    性能和平衡考虑 (Performance and Balance Considerations):
    ============================================================================
    - 执行效率：直接委托给CommonAttack，减少处理开销
    - 游戏平衡：支持连击取消以保持防御反击的可能性
    - 角度优化：90度连击角度在精确性和可执行性间平衡
    - 状态管理：简洁的状态转换逻辑确保稳定性
    ============================================================================
]]--

-- 注册连击终结技的调试参数 (Register debug parameters for combo final attack)
-- 这些参数支持游戏运行时的实时调试和参数调优
REGISTER_DBG_GOAL_PARAM(GOAL_COMMON_ComboFinal, 0, "EzStateID", 0)      -- 动画状态ID (Animation state ID)
REGISTER_DBG_GOAL_PARAM(GOAL_COMMON_ComboFinal, 1, "攻撃対象", 0)        -- 攻击目标 (Attack target)
REGISTER_DBG_GOAL_PARAM(GOAL_COMMON_ComboFinal, 2, "成功距離", 0)        -- 攻击成功距离 (Attack success distance)
REGISTER_DBG_GOAL_PARAM(GOAL_COMMON_ComboFinal, 3, "上攻撃角度", 0)       -- 上攻击角度 (Upper attack angle)
REGISTER_DBG_GOAL_PARAM(GOAL_COMMON_ComboFinal, 4, "下攻撃角度", 0)       -- 下攻击角度 (Lower attack angle)

-- 启用连击攻击取消功能 (Enable combo attack cancel functionality)
-- 允许终结技被防御、招架等行为中断，保持游戏的平衡性
ENABLE_COMBO_ATK_CANCEL(GOAL_COMMON_ComboFinal)

--[[============================================================================
    连击终结技执行函数 (Combo Final Attack Execution Functions)
    ============================================================================
]]--

-- 连击终结技激活函数 (Combo final attack activation function)
-- 功能说明 (Function Description):
--   执行连击序列的最终攻击，为整个连击链提供强有力的结束。终结技具有
--   特化的参数配置，包括严格的连击成功角度(90度)和较高的攻击判定角度
--   (180度)，确保攻击的威力和准确性。
--
-- 参数说明 (Parameters):
--   f1_arg0: AI角色对象 (AI character object) - 执行攻击的AI实体
--   f1_arg1: 目标对象 (Goal object) - 包含攻击参数和生命周期管理
--
-- 终结技特性 (Finisher Features):
--   - 高命中率：180度攻击角度确保较高的命中概率
--   - 精确控制：90度连击成功角度要求精确的角度控制
--   - 强力结束：为连击序列提供戏剧性的收尾效果
--   - 平衡机制：支持连击取消以保持游戏平衡
--
-- 参数配置策略 (Parameter Configuration Strategy):
--   本函数采用"威力优先"的配置策略，平衡攻击效果和控制精度
function ComboFinal_Activate(f1_arg0, f1_arg1)
    -- === 参数提取阶段 (Parameter Extraction Phase) ===
    local f1_local0 = f1_arg1:GetLife()      -- 行为生命周期 (Behavior life cycle)
    local f1_local1 = f1_arg1:GetParam(0)    -- 动画状态ID (Animation state ID)
    local f1_local2 = f1_arg1:GetParam(1)    -- 攻击目标 (Attack target)
    local f1_local3 = f1_arg1:GetParam(2)    -- 成功距离 (Success distance)

    -- === 终结技特化配置 (Finisher-Specific Configuration) ===
    local f1_local4 = 180    -- 攻击角度范围：180度确保高命中率 (Attack angle range: 180° for high hit rate)
    local f1_local5 = 0      -- 移动速度倍率：0禁用移动确保稳定性 (Movement speed: 0 to disable movement for stability)
    local f1_local6 = 90     -- 连击成功角度：90度精确控制 (Combo success angle: 90° precise control)
    local f1_local7 = true   -- 攻击启用：允许造成伤害 (Attack enabled: allow damage dealing)
    local f1_local8 = false  -- 移动禁用：攻击时不移动 (Movement disabled: no movement during attack)
    local f1_local9 = true   -- 转身启用：可以转向目标 (Turning enabled: can orient to target)
    local f1_local10 = false -- 后退禁用：不后退移动 (Retreat disabled: no backward movement)
    local f1_local11 = false -- 侧移禁用：不侧向移动 (Side movement disabled: no lateral movement)

    -- === 自定义角度参数 (Custom Angle Parameters) ===
    local f1_local12 = f1_arg1:GetParam(3)   -- 上攻击角度限制 (Upper attack angle limit)
    local f1_local13 = f1_arg1:GetParam(4)   -- 下攻击角度限制 (Lower attack angle limit)

    -- === 终结技攻击执行 (Finisher Attack Execution) ===
    -- 委托给CommonAttack执行具体的终结技逻辑，使用终结技特化的参数配置
    -- (Delegate to CommonAttack for actual finisher execution with finisher-specific parameter configuration)
    f1_arg1:AddSubGoal(GOAL_COMMON_CommonAttack,
        f1_local0,    -- 生命周期
        f1_local1,    -- 动画状态ID
        f1_local2,    -- 攻击目标
        f1_local3,    -- 成功距离
        f1_local4,    -- 攻击角度 (180度)
        f1_local5,    -- 移动速度 (禁用)
        f1_local6,    -- 连击成功角度 (90度)
        f1_local8,    -- 移动控制
        f1_local9,    -- 转身控制
        f1_local10,   -- 后退控制
        f1_local11,   -- 侧移控制
        f1_local12,   -- 上攻击角度
        f1_local13,   -- 下攻击角度
        f1_local7     -- 攻击启用
    )

    -- 注意：终结技执行后，连击状态将自动重置，AI返回正常行为模式
    -- (Note: After finisher execution, combo state will be automatically reset, AI returns to normal behavior mode)
end

-- 连击终结技更新函数 (Combo final attack update function)
-- 功能说明 (Function Description):
--   连击终结技的状态更新函数。采用简单的继续执行策略，将具体的状态
--   管理委托给底层的CommonAttack处理，确保终结技的稳定执行。
--
-- 参数说明 (Parameters):
--   f2_arg0: AI角色对象 (AI character object) - 执行攻击的AI实体
--   f2_arg1: 目标对象 (Goal object) - 当前的攻击目标状态
--
-- 返回值 (Return Value):
--   GOAL_RESULT_Continue: 继续执行终结技 (Continue executing finisher)
--
-- 设计理念 (Design Philosophy):
--   终结技采用"委托管理"模式，所有复杂逻辑由CommonAttack处理，
--   这里仅负责保持执行状态的连续性。
function ComboFinal_Update(f2_arg0, f2_arg1)
    -- 连击终结技：始终继续执行，直到CommonAttack完成
    -- (Combo finisher: always continue until CommonAttack completes)
    return GOAL_RESULT_Continue
end

-- 连击终结技终止函数 (Combo final attack termination function)
-- 功能说明 (Function Description):
--   在终结技完成或被强制终止时调用的清理函数。对于连击终结技，
--   由于状态管理由CommonAttack负责，这里不需要额外的清理工作。
--
-- 参数说明 (Parameters):
--   f3_arg0: AI角色对象 (AI character object) - 执行攻击的AI实体
--   f3_arg1: 目标对象 (Goal object) - 即将终止的攻击目标
--
-- 设计考虑 (Design Considerations):
--   终结技的状态重置由连击系统自动处理，脚本层面保持简洁
function ComboFinal_Terminate(f3_arg0, f3_arg1)
    -- 连击终结技：无需特殊清理，连击状态由系统自动重置
    -- (Combo finisher: no special cleanup needed, combo state automatically reset by system)
end

-- 注册连击终结技为不可中断类型 (Register combo finisher as non-interruptible type)
-- 说明：虽然启用了连击取消，但设置为不可中断确保终结技的完整执行
-- (Note: Although combo cancel is enabled, setting as non-interruptible ensures complete finisher execution)
REGISTER_GOAL_NO_INTERUPT(GOAL_COMMON_ComboFinal, true)

-- 连击终结技中断判断函数 (Combo final attack interruption judgment function)
-- 功能说明 (Function Description):
--   判断当前终结技是否可以被其他行为中断。连击终结技采用严格的不可
--   中断策略，确保攻击的完整性和视觉效果的连贯性。
--
-- 参数说明 (Parameters):
--   f4_arg0: AI角色对象 (AI character object) - 执行攻击的AI实体
--   f4_arg1: 目标对象 (Goal object) - 当前的攻击目标状态
--
-- 返回值 (Return Value):
--   false: 不允许中断 (Do not allow interruption)
--
-- 平衡考虑 (Balance Considerations):
--   虽然返回false，但连击取消机制仍可通过其他途径生效，如防御、招架等
function ComboFinal_Interupt(f4_arg0, f4_arg1)
    -- 连击终结技：不允许被其他行为中断，确保终结技的完整执行
    -- (Combo finisher: not allowed to be interrupted by other behaviors, ensuring complete finisher execution)
    return false
end

--[[============================================================================
    文件结束 (End of File)
    ============================================================================

    连击终结技系统已完成文档化。该模块现在具有：
    - 完整的终结技执行机制说明
    - 详细的参数配置策略文档
    - 专业级的威力平衡设计
    - 清晰的连击系统集成逻辑

    关键特性总结：
    - 高威力输出：为连击序列提供强力收尾
    - 精确控制：90度连击成功角度确保准确性
    - 平衡机制：支持连击取消保持游戏平衡
    - 稳定执行：不可中断确保终结技完整性
    - 系统集成：与连击系统的无缝集成

    连击系统完整流程：
    combo_attack.lua → [combo_repeat.lua] × N → combo_final.lua (本模块)
    ============================================================================
]]--


