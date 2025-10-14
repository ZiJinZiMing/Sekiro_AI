--[[============================================================================
    combo_repeat_success_angle180.lua - Sekiro 180度连击重复技系统
    (180-Degree Combo Repeat Attack System)

    版本信息 (Version Info): v3.0 - Professional documentation
    作者 (Author): FromSoftware AI Team / Enhanced by Claude Code
    编码格式 (Encoding): Shift-JIS (required for Sekiro compatibility)

    ============================================================================
    模块概述 (Module Overview):
    ============================================================================
    这是Sekiro AI系统的180度连击重复技模块,是combo_repeat.lua的扩展版本。
    该模块使用180度的攻击判定角度,相比标准重复技(90度)提供更宽的攻击范围,
    适用于需要更强容错性和覆盖面的连击重复段。

    核心特性 (Core Features):
    ┌─ 180度宽角度重复技 (180° Wide Angle Repeat Attack)
    │  ├─ 攻击角度: 180度 - 比标准重复技(90度)宽一倍
    │  ├─ 连击角度: 90度 - 保持精确的连击链接
    │  ├─ 执行速度: 0移动速度 - 零延迟重复
    │  └─ 转身速度: 90度 - 快速跟踪目标
    │
    ├─ 与标准重复技的区别 (Difference from Standard Repeat)
    │  ┌────────────────┬────────────────┬──────────────────────┐
    │  │    特性        │  combo_repeat  │ combo_repeat_SA180   │
    │  ├────────────────┼────────────────┼──────────────────────┤
    │  │  攻击角度      │      90°       │        180°          │
    │  │  命中容错性    │      标准      │        高            │
    │  │  适用场景      │   精确打击     │      大范围压制      │
    │  │  执行精度      │      高        │        中等          │
    │  └────────────────┴────────────────┴──────────────────────┘
    │
    └─ 战术应用场景 (Tactical Application Scenarios)
       ├─ 多目标环境: 180度覆盖多个敌人
       ├─ 快速移动目标: 更宽的角度提高命中率
       ├─ 群战压制: 连续重复技形成区域威胁
       └─ 容错性要求: 当精确度不是首要考虑时

    ============================================================================
]]--

-- 注册180度连击重复技行为的调试参数
-- (Register debug parameters for 180° combo repeat attack behavior)
REGISTER_DBG_GOAL_PARAM(GOAL_COMMON_ComboRepeat_SuccessAngle180, 0, "EzStateID", 0)    -- 动画状态ID
REGISTER_DBG_GOAL_PARAM(GOAL_COMMON_ComboRepeat_SuccessAngle180, 1, "攻撃対象", 0)      -- 攻击目标
REGISTER_DBG_GOAL_PARAM(GOAL_COMMON_ComboRepeat_SuccessAngle180, 2, "成功距離", 0)      -- 成功距离
REGISTER_DBG_GOAL_PARAM(GOAL_COMMON_ComboRepeat_SuccessAngle180, 3, "上攻撃角度", 0)    -- 上攻击角度
REGISTER_DBG_GOAL_PARAM(GOAL_COMMON_ComboRepeat_SuccessAngle180, 4, "下攻撃角度", 0)    -- 下攻击角度

-- 启用连击攻击取消功能
-- (Enable combo attack cancel functionality)
ENABLE_COMBO_ATK_CANCEL(GOAL_COMMON_ComboRepeat_SuccessAngle180)

--[[
180度连击重复技激活函数 (180° combo repeat attack activation function)
功能：启动具有180度攻击范围的连击重复技
参数：
  f1_arg0 - AI角色对象 (AI character object)
  f1_arg1 - 目标对象 (Goal object)
逻辑流程：
  1. 提取攻击参数(动画ID、目标、距离、角度等)
  2. 配置180度宽角度攻击判定
  3. 保持90度连击链接角度
  4. 零延迟执行确保快速重复
  5. 委托CommonAttack执行实际攻击
核心差异：
  - 攻击角度180度(f1_local4) vs 标准重复技90度
  - 提供更大的攻击覆盖范围和容错性
  - 适用于需要大范围压制的战术场景
]]--
function ComboRepeat_SuccessAngle180_Activate(f1_arg0, f1_arg1)
    -- === 参数提取阶段 (Parameter Extraction Phase) ===
    local f1_local0 = f1_arg1:GetLife()      -- 重复技生命周期 (Repeat attack life cycle)
    local f1_local1 = f1_arg1:GetParam(0)    -- 攻击动画状态ID (Attack animation state ID)
    local f1_local2 = f1_arg1:GetParam(1)    -- 攻击目标对象 (Attack target object)
    local f1_local3 = f1_arg1:GetParam(2)    -- 成功判定距离 (Success determination distance)

    -- === 180度宽角度重复技配置 (180° Wide Angle Repeat Attack Configuration) ===
    local f1_local4 = 180   -- ★ 关键差异: 攻击角度180度(标准重复技为90度)
                            -- (Key difference: 180° attack angle vs 90° in standard repeat)
                            -- 提供更大的攻击范围和命中容错性
                            -- (Provides larger attack coverage and hit tolerance)

    local f1_local5 = 0     -- 移动速度: 0 - 零延迟快速重复 (Movement speed: 0 - zero delay fast repeat)
    local f1_local6 = 90    -- 连击成功角度: 90度精确链接 (Combo success angle: 90° precise link)
                            -- 保持标准的连击链接精度
                            -- (Maintain standard combo link precision)

    -- === 重复技行为控制配置 (Repeat Attack Behavior Control Configuration) ===
    local f1_local7 = true   -- 攻击启用 (Attack enabled)
    local f1_local8 = true   -- 移动启用 (Movement enabled)
    local f1_local9 = true   -- 转身启用 (Turning enabled)
    local f1_local10 = false -- 后退禁用 (Retreat disabled)
    local f1_local11 = false -- 侧移禁用 (Side movement disabled)

    -- === 自定义角度约束参数 (Custom Angle Constraint Parameters) ===
    local f1_local12 = f1_arg1:GetParam(3)   -- 上攻击角度限制 (Upper attack angle limit)
    local f1_local13 = f1_arg1:GetParam(4)   -- 下攻击角度限制 (Lower attack angle limit)

    -- === 180度重复技执行阶段 (180° Repeat Attack Execution Phase) ===
    -- 委托给CommonAttack执行具有180度宽角度的重复技
    -- (Delegate to CommonAttack for executing repeat attack with 180° wide angle)
    -- 核心特性: 180度攻击角度 + 90度连击角度 + 零延迟执行
    -- (Core features: 180° attack angle + 90° combo angle + zero-delay execution)
    f1_arg1:AddSubGoal(GOAL_COMMON_CommonAttack,
        f1_local0,    -- 生命周期
        f1_local1,    -- 动画状态ID
        f1_local2,    -- 攻击目标
        f1_local3,    -- 成功距离
        f1_local4,    -- ★ 攻击角度(180度) - 本模块核心特性
        f1_local5,    -- 移动速度(0) - 快速重复
        f1_local6,    -- 连击角度(90度) - 精确链接
        f1_local8,    -- 移动控制
        f1_local9,    -- 转身控制
        f1_local10,   -- 后退控制
        f1_local11,   -- 侧移控制
        f1_local12,   -- 上攻击角度
        f1_local13,   -- 下攻击角度
        f1_local7     -- 攻击启用
    )
end

--[[
180度连击重复技更新函数 (180° combo repeat attack update function)
功能：每帧更新180度重复技的执行状态
参数：
  f2_arg0 - AI角色对象
  f2_arg1 - 目标对象
返回：GOAL_RESULT_Continue - 继续执行重复技
说明：状态管理由CommonAttack和连击取消机制自动处理
]]--
function ComboRepeat_SuccessAngle180_Update(f2_arg0, f2_arg1)
    -- 180度重复技持续执行,状态由连击系统自动管理
    -- (180° repeat attack continues, state automatically managed by combo system)
    return GOAL_RESULT_Continue
end

--[[
180度连击重复技终止函数 (180° combo repeat attack termination function)
功能：重复技结束时的清理
参数：
  f3_arg0 - AI角色对象
  f3_arg1 - 目标对象
说明：无需特殊清理,状态由连击系统自动管理
]]--
function ComboRepeat_SuccessAngle180_Terminate(f3_arg0, f3_arg1)
    -- 180度重复技终止,无需特殊清理
    -- (180° repeat attack terminated, no special cleanup needed)
end

-- 注册为不可中断类型,确保重复技的连贯性
-- (Register as non-interruptible type to ensure repeat attack continuity)
REGISTER_GOAL_NO_INTERUPT(GOAL_COMMON_ComboRepeat_SuccessAngle180, true)

--[[
180度连击重复技中断判断函数 (180° combo repeat attack interruption determination function)
功能：判断是否允许中断当前180度重复技
返回：false - 不允许中断
说明：
  - 标准中断保护: 防止外部行为破坏重复序列
  - 连击取消通道: 通过ENABLE_COMBO_ATK_CANCEL提供战术灵活性
  - 宽角度优势: 180度范围降低了因角度问题需要中断的可能性
]]--
function ComboRepeat_SuccessAngle180_Interupt(f4_arg0, f4_arg1)
    -- 180度重复技不允许被外部行为中断,但支持连击取消机制
    -- (180° repeat attack not allowed to be interrupted by external behaviors, but supports combo cancel mechanism)
    return false
end

--[[============================================================================
    文件结束 (End of File)
    ============================================================================

    180度连击重复技系统已完成专业文档化。该模块现在具备：
    - 完整的180度宽角度攻击机制说明
    - 详细的与标准重复技的对比分析
    - 清晰的战术应用场景文档
    - 专业的参数配置策略说明

    关键特性总结：
    - 宽角度覆盖：180度 vs 标准90度
    - 高容错性：适合快速移动目标和多目标环境
    - 快速执行：零延迟移动速度确保重复流畅
    - 精确链接：90度连击角度保持序列精度

    选择指南：
    - 使用 combo_repeat: 需要精确打击,单一目标
    - 使用 combo_repeat_SA180: 需要大范围覆盖,多目标压制

    应用场景：
    - 群战环境的连续重复攻击
    - 快速移动目标的追击重复技
    - 需要高容错性的连击序列
    ============================================================================
]]--


