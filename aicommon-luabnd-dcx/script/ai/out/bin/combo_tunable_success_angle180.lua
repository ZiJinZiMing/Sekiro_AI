--[[============================================================================
    combo_tunable_success_angle180.lua - Sekiro可调180度连击攻击系统
    (Tunable 180-Degree Combo Attack System)

    版本信息 (Version Info): v3.0 - Professional documentation
    作者 (Author): FromSoftware AI Team / Enhanced by Claude Code
    编码格式 (Encoding): Shift-JIS (required for Sekiro compatibility)

    ============================================================================
    模块概述 (Module Overview):
    ============================================================================
    这是Sekiro AI系统的可调180度连击攻击模块,结合了可调旋转攻击(attack_tunable_spin)
    和180度宽角度攻击的优势。该模块提供可自定义的旋转时间和角度参数,同时使用
    180度的攻击范围,适用于需要灵活配置且覆盖范围广的连击起始段。

    核心特性 (Core Features):
    ┌─ 可调旋转 + 180度宽角度 (Tunable Spin + 180° Wide Angle)
    │  ├─ 攻击角度: 180度 - 提供宽广的攻击覆盖
    │  ├─ 旋转时间: 可自定义(默认1.5秒) - 灵活的转向控制
    │  ├─ 正面角度: 可自定义(默认20度) - 精确的方向判定
    │  └─ 移动启用: true - 支持位置调整
    │
    ├─ 与其他连击攻击的差异化 (Differentiation from Other Combo Attacks)
    │  ┌────────────────────┬────────────────┬─────────────────┬──────────────────┐
    │  │      特性          │ combo_attack   │ combo_tunable   │ combo_tunable180 │
    │  ├────────────────────┼────────────────┼─────────────────┼──────────────────┤
    │  │    攻击角度        │      90°       │       90°       │       180°       │
    │  │  旋转时间配置      │     固定       │      可调       │       可调       │
    │  │  正面角度配置      │     固定       │      可调       │       可调       │
    │  │    覆盖范围        │     标准       │      标准       │       大         │
    │  │    灵活性          │     低         │      高         │       高         │
    │  └────────────────────┴────────────────┴─────────────────┴──────────────────┘
    │
    └─ 战术应用场景 (Tactical Application Scenarios)
       ├─ 移动目标追击: 可调旋转 + 180度覆盖 = 高追击成功率
       ├─ 群战起手: 180度范围覆盖多个目标
       ├─ 适应性战术: 通过参数调整适应不同战况
       └─ 容错连击: 宽角度降低连击失败风险

    ============================================================================
    参数配置策略 (Parameter Configuration Strategy):
    ============================================================================

    智能默认值设定 (Intelligent Default Values):
    - 旋转时间: 1.5秒 - 平衡转向精度和执行速度
    - 正面角度: 20度 - 精确的方向判断
    - 参数验证: 负值自动使用默认值

    可调性优势 (Adjustability Advantages):
    - 根据敌人移动速度调整旋转时间
    - 根据攻击特性调整正面判定角度
    - 运行时参数化配置提高适应性

    ============================================================================
]]--

-- 注册可调180度连击攻击行为的调试参数
-- (Register debug parameters for tunable 180° combo attack behavior)
REGISTER_DBG_GOAL_PARAM(GOAL_COMMON_ComboTunable_SuccessAngle180, 0, "EzStateID", 0)           -- 动画状态ID
REGISTER_DBG_GOAL_PARAM(GOAL_COMMON_ComboTunable_SuccessAngle180, 1, "攻撃対象", 0)             -- 攻击目标
REGISTER_DBG_GOAL_PARAM(GOAL_COMMON_ComboTunable_SuccessAngle180, 2, "成功距離", 0)             -- 成功距离
REGISTER_DBG_GOAL_PARAM(GOAL_COMMON_ComboTunable_SuccessAngle180, 3, "攻撃前旋回時間【秒】", 0)  -- 攻击前旋转时间(秒)
REGISTER_DBG_GOAL_PARAM(GOAL_COMMON_ComboTunable_SuccessAngle180, 4, "正面判定角度【度】", 0)    -- 正面判定角度(度)
REGISTER_DBG_GOAL_PARAM(GOAL_COMMON_ComboTunable_SuccessAngle180, 5, "上攻撃角度", 0)           -- 上攻击角度
REGISTER_DBG_GOAL_PARAM(GOAL_COMMON_ComboTunable_SuccessAngle180, 6, "下攻撃角度", 0)           -- 下攻击角度

--[[
可调180度连击攻击激活函数 (Tunable 180° combo attack activation function)
功能：启动具有可调旋转和180度攻击范围的连击攻击
参数：
  f1_arg0 - AI角色对象 (AI character object)
  f1_arg1 - 目标对象 (Goal object)
逻辑流程：
  1. 提取所有攻击参数(动画ID、目标、距离等)
  2. 获取可调参数(旋转时间、正面角度)
  3. 参数验证并应用智能默认值
  4. 配置180度宽角度攻击
  5. 委托CommonAttack执行可调连击
核心特性：
  - 180度攻击角度 + 可调旋转参数 = 最大灵活性和覆盖范围
  - 智能参数验证确保始终有合理的配置
  - 移动启用支持追击和位置调整
]]--
function ComboTunableSuccessAngle180_Activate(f1_arg0, f1_arg1)
    -- === 参数提取阶段 (Parameter Extraction Phase) ===
    local f1_local0 = f1_arg1:GetLife()      -- 连击攻击生命周期 (Combo attack life cycle)
    local f1_local1 = f1_arg1:GetParam(0)    -- 攻击动画状态ID (Attack animation state ID)
    local f1_local2 = f1_arg1:GetParam(1)    -- 攻击目标对象 (Attack target object)
    local f1_local3 = f1_arg1:GetParam(2)    -- 成功判定距离 (Success determination distance)

    -- === 可调180度连击配置 (Tunable 180° Combo Configuration) ===
    local f1_local4 = 180                    -- ★ 攻击角度: 180度宽角度覆盖
                                             -- (Attack angle: 180° wide angle coverage)
                                             -- 比标准连击(90度)提供更大的攻击范围

    local f1_local5 = f1_arg1:GetParam(3)    -- 获取可调旋转时间参数
                                             -- (Get tunable spin time parameter)
    local f1_local6 = f1_arg1:GetParam(4)    -- 获取可调正面角度参数
                                             -- (Get tunable front angle parameter)

    -- === 智能参数验证和默认值设置 (Intelligent Parameter Validation and Default Values) ===
    if f1_local5 < 0 then
        f1_local5 = 1.5  -- 默认旋转时间: 1.5秒 - 优化的转向时间
                         -- (Default spin time: 1.5s - optimized turn time)
    end
    if f1_local6 < 0 then
        f1_local6 = 20   -- 默认正面角度: 20度 - 精确的方向判定
                         -- (Default front angle: 20° - precise direction determination)
    end

    -- === 连击攻击行为控制配置 (Combo Attack Behavior Control Configuration) ===
    local f1_local7 = true   -- 攻击启用 (Attack enabled)
    local f1_local8 = true   -- ★ 移动启用 - 支持位置调整和追击
                             -- (Movement enabled - support position adjustment and pursuit)
    local f1_local9 = true   -- 转身启用 - 支持旋转转向
                             -- (Turning enabled - support spin turning)
    local f1_local10 = false -- 后退禁用 (Retreat disabled)
    local f1_local11 = false -- 侧移禁用 (Side movement disabled)

    -- === 自定义角度约束参数 (Custom Angle Constraint Parameters) ===
    local f1_local12 = f1_arg1:GetParam(5)   -- 上攻击角度限制 (Upper attack angle limit)
    local f1_local13 = f1_arg1:GetParam(6)   -- 下攻击角度限制 (Lower attack angle limit)

    -- === 可调180度连击执行阶段 (Tunable 180° Combo Execution Phase) ===
    -- 委托给CommonAttack执行具有可调旋转和180度范围的连击攻击
    -- (Delegate to CommonAttack for executing combo attack with tunable spin and 180° range)
    -- 核心组合: 180度攻击角度 + 可调旋转时间 + 可调正面角度 + 移动启用
    -- (Core combination: 180° attack angle + tunable spin time + tunable front angle + movement enabled)
    f1_arg1:AddSubGoal(GOAL_COMMON_CommonAttack,
        f1_local0,    -- 生命周期
        f1_local1,    -- 动画状态ID
        f1_local2,    -- 攻击目标
        f1_local3,    -- 成功距离
        f1_local4,    -- ★ 攻击角度(180度) - 宽角度覆盖
        f1_local5,    -- ★ 旋转时间(可调) - 灵活转向控制
        f1_local6,    -- ★ 正面角度(可调) - 精确方向判定
        f1_local8,    -- ★ 移动控制(启用) - 位置调整能力
        f1_local9,    -- 转身控制
        f1_local10,   -- 后退控制
        f1_local11,   -- 侧移控制
        f1_local12,   -- 上攻击角度
        f1_local13,   -- 下攻击角度
        f1_local7     -- 攻击启用
    )
end

--[[
可调180度连击攻击更新函数 (Tunable 180° combo attack update function)
功能：每帧更新可调180度连击的执行状态
参数：
  f2_arg0 - AI角色对象
  f2_arg1 - 目标对象
返回：GOAL_RESULT_Continue - 继续执行连击
说明：状态管理由CommonAttack自动处理
]]--
function ComboTunableSuccessAngle180_Update(f2_arg0, f2_arg1)
    -- 可调180度连击持续执行,状态由CommonAttack自动管理
    -- (Tunable 180° combo continues, state automatically managed by CommonAttack)
    return GOAL_RESULT_Continue
end

--[[
可调180度连击攻击终止函数 (Tunable 180° combo attack termination function)
功能：连击结束时的清理
参数：
  f3_arg0 - AI角色对象
  f3_arg1 - 目标对象
说明：无需特殊清理,状态由CommonAttack自动管理
]]--
function ComboTunableSuccessAngle180_Terminate(f3_arg0, f3_arg1)
    -- 可调180度连击终止,无需特殊清理
    -- (Tunable 180° combo terminated, no special cleanup needed)
end

-- 注册为不可中断类型,确保连击的完整执行
-- (Register as non-interruptible type to ensure complete combo execution)
REGISTER_GOAL_NO_INTERUPT(GOAL_COMMON_ComboTunable_SuccessAngle180, true)

--[[
可调180度连击攻击中断判断函数 (Tunable 180° combo attack interruption determination function)
功能：判断是否允许中断当前可调180度连击
返回：false - 不允许中断
说明：
  - 连击完整性保护: 确保可调连击不被外部行为打断
  - 参数投资保护: 旋转时间的投入需要通过完整攻击回收
  - 宽角度优势: 180度范围降低了因角度问题需要中断的可能
]]--
function ComboTunableSuccessAngle180_Interupt(f4_arg0, f4_arg1)
    -- 可调180度连击不允许被其他行为中断,保护旋转时间投资和攻击完整性
    -- (Tunable 180° combo not allowed to be interrupted, protecting spin time investment and attack integrity)
    return false
end

--[[============================================================================
    文件结束 (End of File)
    ============================================================================

    可调180度连击攻击系统已完成专业文档化。该模块现在具备：
    - 完整的可调旋转 + 180度宽角度机制说明
    - 详细的与其他连击类型的对比分析
    - 清晰的智能默认值策略文档
    - 专业的战术应用场景说明

    关键特性总结：
    - 双重优势: 可调旋转 + 180度宽角度
    - 最大灵活性: 旋转时间和正面角度都可自定义
    - 智能容错: 参数验证和默认值确保稳定性
    - 广泛覆盖: 180度攻击范围提高命中率

    选择指南：
    - combo_attack: 标准连击,固定参数,90度
    - combo_tunable_SA180: 可调连击,自定义参数,180度 (本模块)
    - combo_repeat_SA180: 重复技,零延迟,180度

    应用场景：
    - 需要灵活配置的宽角度连击起手
    - 移动目标的追击连击
    - 群战环境的多目标连击
    - 需要高适应性的战术连击
    ============================================================================
]]--


