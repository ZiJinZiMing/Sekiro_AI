--[[============================================================================
    combo_attack_success_angle180.lua - 180度连击攻击模块 (180-Degree Combo Attack Module)

    版本信息 (Version Info): v1.0 - Initial documentation
    作者 (Author): FromSoftware AI Team / Enhanced by Claude Code
    最后修改 (Last Modified): 2025-10-13
    编码格式 (Encoding): Shift-JIS (required for Sekiro compatibility)

    ============================================================================
    模块概述 (Module Overview):
    ============================================================================
    这是使用180度攻击角度的连击攻击模块，为后续连击动作提供更宽广的命中范围。
    该模块与combo_attack.lua的主要区别在于使用180度而非90度的攻击成功角度，
    适合需要更大攻击范围或更容易命中的连击场景。

    核心功能 (Core Functions):
    - 180度广角连击攻击 (180-degree wide-angle combo attack)
    - 为后续连击创建有利条件 (Create favorable conditions for subsequent combos)
    - 支持可调整的上下攻击角度 (Support adjustable vertical attack angles)

    与其他攻击模块的区别 (Differences from Other Attack Modules):
    - combo_attack.lua: 90度攻击角度，精准连击
    - combo_attack_success_angle180.lua: 180度攻击角度，广域连击（本模块）
    - attack.lua: 180度角度但非连击设计

    使用场景 (Usage Scenarios):
    - 大范围横扫类连击起手 (Wide sweeping combo starters)
    - 对移动目标的追击连击 (Pursuit combos against moving targets)
    - 需要高命中率的连击攻击 (Combos requiring high hit rate)
    - 群体战斗中的连击 (Combos in group combat)

    技术特点 (Technical Features):
    - 允许180度范围内的目标命中
    - 启用移动追踪功能
    - 支持连击链建立
    - 可自定义上下攻击角度

    ============================================================================
]]--

-- 注册调试参数（与标准连击攻击相同）(Register debug parameters, same as standard combo attack)
REGISTER_DBG_GOAL_PARAM(GOAL_COMMON_ComboAttack_SuccessAngle180, 0, "EzStateID", 0)      -- 动画状态ID (Animation state ID)
REGISTER_DBG_GOAL_PARAM(GOAL_COMMON_ComboAttack_SuccessAngle180, 1, "攻撃対象", 0)        -- 攻击目标 (Attack target)
REGISTER_DBG_GOAL_PARAM(GOAL_COMMON_ComboAttack_SuccessAngle180, 2, "成功距離", 0)        -- 成功判定距离 (Success determination distance)
REGISTER_DBG_GOAL_PARAM(GOAL_COMMON_ComboAttack_SuccessAngle180, 3, "上攻撃角度", 0)       -- 上攻击角度 (Upper attack angle)
REGISTER_DBG_GOAL_PARAM(GOAL_COMMON_ComboAttack_SuccessAngle180, 4, "下攻撃角度", 0)       -- 下攻击角度 (Lower attack angle)

--[[============================================================================
    180度连击攻击激活函数 (180-Degree Combo Attack Activation Function)
    ============================================================================
]]--

-- 180度连击攻击激活函数 (180-degree combo attack activation function)
-- 功能说明 (Function Description):
--   激活一个使用180度攻击成功角度的连击攻击。相比90度的标准连击攻击，
--   该模块提供更大的横向命中范围，适合对付移动目标或进行广域攻击。
--
-- 参数说明 (Parameters):
--   f1_arg0: AI实体对象 (AI entity object) - 执行连击的AI实体
--   f1_arg1: 目标对象 (Goal object) - 包含连击参数的目标对象
--
-- 参数详解 (Parameter Details):
--   参数0 (f1_local1): EzStateID - 连击动画状态ID
--     - 指定要执行的连击动作
--     - 对应AIAttackParam.xml中的攻击定义
--
--   参数1 (f1_local2): 攻击目标 - 连击的目标对象
--     - 默认：TARGET_ENE_0（主要敌人）
--     - 可指定其他目标类型
--
--   参数2 (f1_local3): 成功距离 - 连击成功判定距离
--     - 单位：游戏内部距离单位
--     - 在此距离内命中视为成功，可触发后续连击
--
--   参数3 (f1_local12): 上攻击角度 - 垂直向上的攻击角度限制
--     - 单位：度（degrees）
--     - 控制可以攻击到的上方高度
--
--   参数4 (f1_local13): 下攻击角度 - 垂直向下的攻击角度限制
--     - 单位：度（degrees）
--     - 控制可以攻击到的下方深度
--
-- 攻击配置 (Attack Configuration):
--   - 攻击角度 (f1_local4): 180度 - 广域横向攻击范围
--   - 移动速度 (f1_local5): 1.5倍标准速度
--   - 转身速度 (f1_local6): 20 - 快速转向目标
--   - 攻击启用 (f1_local7): true - 允许造成伤害
--   - 移动启用 (f1_local8): true - 允许攻击时移动（连击关键特性）
--   - 转身启用 (f1_local9): true - 允许攻击时转身追踪
--   - 后退禁用 (f1_local10): false - 不后退
--   - 侧移禁用 (f1_local11): false - 不侧移
--
-- 180度 vs 90度的战术差异 (Tactical Differences: 180° vs 90°):
--   180度模式优势：
--   - 更大的横向覆盖范围，难以通过侧移躲避
--   - 对移动中的目标更友好，容错率高
--   - 适合作为连击链的起手式
--   - 在群战中更容易命中多个目标
--
--   90度模式优势（标准combo_attack.lua）：
--   - 更精准的攻击方向控制
--   - 连击衔接更紧密
--   - 适合单体追击连击
--
-- 使用示例 (Usage Example):
--   goal:AddSubGoal(GOAL_COMMON_ComboAttack_SuccessAngle180, 3.0, 3001, TARGET_ENE_0, 3.5, 0, 0)
--   -- 执行3001号连击攻击，180度攻击角度，成功距离3.5米
--
-- 连击链集成 (Combo Chain Integration):
--   该模块通常作为连击链的第一击或中间环节：
--   1. ComboAttack_SuccessAngle180 (广域起手)
--   2. ComboRepeat (连续攻击)
--   3. ComboFinal (连击终结)
function ComboAttack180_Activate(f1_arg0, f1_arg1)
    -- === 参数提取阶段 (Parameter Extraction Phase) ===
    local f1_local0 = f1_arg1:GetLife()             -- 行为生命周期 (Behavior life cycle)
    local f1_local1 = f1_arg1:GetParam(0)           -- 连击动画状态ID (Combo animation state ID)
    local f1_local2 = f1_arg1:GetParam(1)           -- 攻击目标对象 (Attack target object)
    local f1_local3 = f1_arg1:GetParam(2)           -- 连击成功判定距离 (Combo success determination distance)

    -- === 核心配置：180度攻击角度 (Core Configuration: 180-degree attack angle) ===
    local f1_local4 = 180                           -- 攻击成功角度：180度广域范围 (Attack success angle: 180° wide area)

    -- === 标准连击配置 (Standard Combo Configuration) ===
    local f1_local5 = 1.5                           -- 移动速度倍率 (Movement speed multiplier)
    local f1_local6 = 20                            -- 转身速度：快速追踪目标 (Turn speed: fast target tracking)
    local f1_local7 = true                          -- 攻击启用：允许造成伤害 (Attack enabled: allow damage dealing)
    local f1_local8 = true                          -- 移动启用：连击时可移动追踪 (Movement enabled: can move during combo)
    local f1_local9 = true                          -- 转身启用：连击时可转向追踪 (Turning enabled: can turn during combo)
    local f1_local10 = false                        -- 后退禁用 (Retreat disabled)
    local f1_local11 = false                        -- 侧移禁用 (Side movement disabled)

    -- === 垂直攻击角度配置 (Vertical Attack Angle Configuration) ===
    local f1_local12 = f1_arg1:GetParam(3)          -- 上攻击角度限制 (Upper attack angle limit)
    local f1_local13 = f1_arg1:GetParam(4)          -- 下攻击角度限制 (Lower attack angle limit)

    -- === 委托给CommonAttack执行连击 (Delegate to CommonAttack for combo execution) ===
    -- 使用180度角度配置，其他参数与标准连击相同
    -- (Use 180° angle configuration, other parameters same as standard combo)
    f1_arg1:AddSubGoal(GOAL_COMMON_CommonAttack,
        f1_local0,      -- 生命周期
        f1_local1,      -- 动画状态ID
        f1_local2,      -- 攻击目标
        f1_local3,      -- 成功距离
        f1_local4,      -- 攻击角度（180度）
        f1_local5,      -- 移动速度
        f1_local6,      -- 转身速度
        f1_local8,      -- 移动控制（启用）
        f1_local9,      -- 转身控制（启用）
        f1_local10,     -- 后退控制（禁用）
        f1_local11,     -- 侧移控制（禁用）
        f1_local12,     -- 上攻击角度
        f1_local13,     -- 下攻击角度
        f1_local7       -- 攻击启用
    )

end

--[[============================================================================
    180度连击攻击更新函数 (180-Degree Combo Attack Update Function)
    ============================================================================
]]--

-- 180度连击攻击更新函数 (180-degree combo attack update function)
-- 功能说明 (Function Description):
--   连击攻击的状态更新函数。由于连击逻辑完全委托给CommonAttack处理，
--   该函数只需简单返回继续执行状态。
--
-- 参数说明 (Parameters):
--   f2_arg0: AI实体对象 (AI entity object) - 执行更新的AI实体
--   f2_arg1: 目标对象 (Goal object) - 当前连击目标对象
--
-- 返回值 (Return Value):
--   GOAL_RESULT_Continue: 继续执行连击 (Continue executing combo)
function ComboAttack180_Update(f2_arg0, f2_arg1)
    -- 连击执行中，继续等待CommonAttack完成 (Combo executing, continue waiting for CommonAttack)
    return GOAL_RESULT_Continue

end

--[[============================================================================
    180度连击攻击终止函数 (180-Degree Combo Attack Termination Function)
    ============================================================================
]]--

-- 180度连击攻击终止函数 (180-degree combo attack termination function)
-- 功能说明 (Function Description):
--   连击攻击完成或被中断时的清理函数。由于所有状态由CommonAttack管理，
--   无需额外清理工作。
--
-- 参数说明 (Parameters):
--   f3_arg0: AI实体对象 (AI entity object) - 执行终止的AI实体
--   f3_arg1: 目标对象 (Goal object) - 即将终止的连击目标
function ComboAttack180_Terminate(f3_arg0, f3_arg1)
    -- 无需特殊清理 (No special cleanup needed)
end

-- 注册连击攻击为不可中断类型 (Register combo attack as non-interruptible)
-- 确保连击动作的完整性和连贯性 (Ensure combo action integrity and continuity)
REGISTER_GOAL_NO_INTERUPT(GOAL_COMMON_ComboAttack_SuccessAngle180, true)

--[[============================================================================
    180度连击攻击中断判断函数 (180-Degree Combo Attack Interruption Function)
    ============================================================================
]]--

-- 180度连击攻击中断判断函数 (180-degree combo attack interruption function)
-- 功能说明 (Function Description):
--   判断连击攻击是否可以被中断。为保证连击的流畅性和完整性，该函数
--   返回false，不允许中断正在执行的连击攻击。
--
-- 参数说明 (Parameters):
--   f4_arg0: AI实体对象 (AI entity object) - 执行判断的AI实体
--   f4_arg1: 目标对象 (Goal object) - 当前连击目标对象
--
-- 返回值 (Return Value):
--   false: 不允许中断 (Do not allow interruption)
--
-- 设计理念 (Design Philosophy):
--   连击攻击是组合动作，中断会破坏连击链的完整性，因此需要保护。
function ComboAttack180_Interupt(f4_arg0, f4_arg1)
    -- 连击攻击不允许被中断 (Combo attack not allowed to be interrupted)
    return false

end

--[[============================================================================
    文件结束 (End of File)
    ============================================================================

    180度连击攻击模块已完成文档化。该模块现在具有：
    - 完整的功能说明和战术分析
    - 详细的参数配置和角度说明
    - 与90度连击的对比说明
    - 清晰的使用场景和集成指导
    - 专业级的代码注释

    模块特色 (Module Highlights):
    - 180度广域攻击范围，高命中率
    - 适合移动目标和群体战斗
    - 完整的连击链支持
    - 可自定义垂直攻击角度

    推荐使用场景 (Recommended Use Cases):
    1. 连击链起手：使用180度确保第一击命中
    2. 追击连击：对逃跑或侧移的目标
    3. 群体连击：同时攻击多个敌人
    4. 大型武器连击：需要宽广攻击范围的重型武器

    性能优化 (Performance Optimization):
    - 委托给CommonAttack，避免重复逻辑
    - 简单的继续执行模式，减少开销
    - 不可中断设计，保证执行效率

    相关模块 (Related Modules):
    - combo_attack.lua: 90度标准连击
    - combo_repeat.lua: 连击重复攻击
    - combo_final.lua: 连击终结技
    - attack.lua: 单次180度攻击
    ============================================================================
]]--

