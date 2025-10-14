--[[============================================================================
    specialTurn.lua - 特殊转身攻击模块 (Special Turn Attack Module)

    版本信息 (Version Info): v1.0 - Initial documentation
    作者 (Author): FromSoftware AI Team / Enhanced by Claude Code
    最后修改 (Last Modified): 2025-10-13
    编码格式 (Encoding): Shift-JIS (required for Sekiro compatibility)

    ============================================================================
    模块概述 (Module Overview):
    ============================================================================
    这是一个特殊转身攻击模块，用于处理AI在攻击前的智能转向行为。该模块会先
    检查AI是否已经面向目标，如果已经面向目标则跳过转身动作，否则执行带有
    转身动画的攻击。这种设计避免了不必要的转身动画，提升战斗流畅度。

    核心功能 (Core Functions):
    - 智能转身判断 (Intelligent turn determination)
    - 条件性攻击执行 (Conditional attack execution)
    - 角度检测与优化 (Angle detection and optimization)

    使用场景 (Usage Scenarios):
    - 需要面向目标才能发动的定向攻击 (Directional attacks requiring target facing)
    - 减少不必要的转身动画卡顿 (Reduce unnecessary turn animation stuttering)
    - 提升AI攻击的自然度和流畅性 (Improve AI attack naturalness and fluidity)
    - 配合特殊技能的准备动作 (Preparation actions for special skills)

    与普通攻击的区别 (Difference from Normal Attacks):
    - 普通攻击：直接执行，可能包含自动转向
    - 特殊转身：先判断角度，仅在需要时转身
    - 优化：避免角度已对准时仍执行转身动画

    ============================================================================
]]--

-- 注册调试参数：EzState编号 (Register debug parameter: EzState number)
REGISTER_DBG_GOAL_PARAM(GOAL_COMMON_SpecialTurn, 0, "EzState番号", 0)  -- 攻击动画状态ID (Attack animation state ID)

-- 注册调试参数：攻击目标类型 (Register debug parameter: attack target type)
REGISTER_DBG_GOAL_PARAM(GOAL_COMMON_SpecialTurn, 1, "攻撃対象【Type】", 0)  -- 攻击目标对象 (Attack target object)

-- 注册调试参数：旋回角度 (Register debug parameter: turn angle)
REGISTER_DBG_GOAL_PARAM(GOAL_COMMON_SpecialTurn, 2, "旋回角度", 0)  -- 判断是否面向目标的角度范围 (Angle range for target facing determination)

-- 注册目标更新时间：立即更新 (Register goal update time: immediate update)
REGISTER_GOAL_UPDATE_TIME(GOAL_COMMON_SpecialTurn, 0, 0)

-- 注册目标为不可中断类型 (Register goal as non-interruptible)
REGISTER_GOAL_NO_INTERUPT(GOAL_COMMON_SpecialTurn, true)

--[[============================================================================
    特殊转身攻击激活函数 (Special Turn Attack Activation Function)
    ============================================================================
]]--

-- 特殊转身攻击激活函数 (Special turn attack activation function)
-- 功能说明 (Function Description):
--   执行智能转身攻击逻辑。首先检查AI是否已经面向目标（在指定角度范围内），
--   如果已经面向目标，则设置标志位直接跳过转身；如果未面向目标，则添加
--   带有转身能力的可调整攻击子目标。
--
-- 参数说明 (Parameters):
--   f1_arg0: AI实体对象 (AI entity object) - 执行转身攻击的AI实体
--   f1_arg1: 目标对象 (Goal object) - 包含攻击参数的目标对象
--
-- 参数详解 (Parameter Details):
--   参数0 (f1_local0): EzState编号 (EzState number)
--     - 攻击动画的状态ID
--     - 用于指定要执行的攻击动作
--     - 通常对应AIAttackParam.xml中的攻击ID
--
--   参数1 (f1_local1): 攻击目标 (Attack target)
--     - 目标对象类型（如TARGET_ENE_0）
--     - 用于确定AI应该面向和攻击的目标
--
--   参数2 (f1_local2): 旋回角度 (Turn angle)
--     - 判断是否面向目标的角度阈值
--     - 单位：度（degrees）
--     - 如果AI与目标的夹角小于此值，视为已面向
--     - 常用值：30-90度
--
-- 执行流程 (Execution Flow):
--   1. 从目标对象中提取攻击参数
--   2. 调用IsLookToTarget检查是否在指定角度内面向目标
--   3. 如果已面向：设置Number(0)=1，标记为完成
--   4. 如果未面向：添加GOAL_COMMON_AttackTunableSpin子目标执行转身攻击
--
-- 角度判断逻辑 (Angle Determination Logic):
--   - IsLookToTarget(target, angle) 返回true：AI朝向在目标方向±angle/2范围内
--   - 返回false：AI需要转身才能攻击目标
--
-- 使用示例 (Usage Example):
--   goal:AddSubGoal(GOAL_COMMON_SpecialTurn, 2.0, 3005, TARGET_ENE_0, 45)
--   -- 如果AI与目标夹角>45度，执行3005号转身攻击；否则跳过
--
-- 设计优势 (Design Advantages):
--   - 避免不必要的转身动画，提升流畅度
--   - 减少AI看起来"抽搐"的情况
--   - 在已对准目标时更快速地执行攻击
--   - 为不同攻击类型提供灵活的转身控制
function SpecialTurn_Activate(f1_arg0, f1_arg1)
    local f1_local0 = f1_arg1:GetParam(0)       -- 获取攻击动画状态ID (Get attack animation state ID)
    local f1_local1 = f1_arg1:GetParam(1)       -- 获取攻击目标对象 (Get attack target object)
    local f1_local2 = f1_arg1:GetParam(2)       -- 获取转身角度阈值 (Get turn angle threshold)

    -- 检查是否已经面向目标 (Check if already looking at target)
    if f1_arg0:IsLookToTarget(f1_local1, f1_local2) then
        -- 已经面向目标，无需转身，设置完成标志 (Already facing target, no turn needed, set completion flag)
        f1_arg1:SetNumber(0, 1)
    else
        -- 未面向目标，执行带转身的攻击 (Not facing target, execute attack with turn)
        -- 参数：目标类型, 生命周期, 动画ID, 目标, 距离类型(DIST_None表示不检查距离), 转身时间, 旋回角度
        f1_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, f1_arg1:GetLife(), f1_local0, f1_local1, DIST_None, 0, -1)
        -- DIST_None: 不进行距离判定，专注于转身攻击
        -- 转身时间0: 使用默认转身时间
        -- 旋回角度-1: 使用默认旋回角度设置
    end

end

--[[============================================================================
    特殊转身攻击更新函数 (Special Turn Attack Update Function)
    ============================================================================
]]--

-- 特殊转身攻击更新函数 (Special turn attack update function)
-- 功能说明 (Function Description):
--   每帧检查转身攻击的执行状态。如果在激活阶段设置了完成标志（Number(0)==1），
--   则立即返回成功；否则继续执行转身攻击子目标。
--
-- 参数说明 (Parameters):
--   f2_arg0: AI实体对象 (AI entity object) - 执行更新的AI实体
--   f2_arg1: 目标对象 (Goal object) - 当前目标对象
--
-- 返回值 (Return Value):
--   GOAL_RESULT_Success: 已面向目标或转身攻击完成 (Already facing target or turn attack completed)
--   GOAL_RESULT_Continue: 转身攻击仍在执行中 (Turn attack still executing)
--
-- 执行逻辑 (Execution Logic):
--   - Number(0)==1: 在激活时就已经面向目标，立即成功
--   - Number(0)!=1: 正在执行转身攻击子目标，继续等待完成
--
-- 性能考虑 (Performance Considerations):
--   - 简单的标志位检查，性能开销极小
--   - 避免不必要的子目标创建和执行
function SpecialTurn_Update(f2_arg0, f2_arg1)
    -- 检查是否在激活阶段就已经面向目标 (Check if already facing target from activation phase)
    if f2_arg1:GetNumber(0) == 1 then
        -- 已面向目标，立即返回成功 (Already facing target, return success immediately)
        return GOAL_RESULT_Success
    end
    -- 转身攻击仍在执行，继续 (Turn attack still executing, continue)
    return GOAL_RESULT_Continue

end

--[[============================================================================
    特殊转身攻击终止函数 (Special Turn Attack Termination Function)
    ============================================================================
]]--

-- 特殊转身攻击终止函数 (Special turn attack termination function)
-- 功能说明 (Function Description):
--   在转身攻击完成或被强制终止时调用的清理函数。由于该模块使用简单的
--   标志位和子目标系统，不需要额外的清理工作。
--
-- 参数说明 (Parameters):
--   f3_arg0: AI实体对象 (AI entity object) - 执行终止的AI实体
--   f3_arg1: 目标对象 (Goal object) - 即将终止的目标对象
--
-- 执行时机 (Execution Timing):
--   - 转身攻击成功完成后
--   - 行为被外部中断时
--   - AI切换到其他行为时
function SpecialTurn_Terminate(f3_arg0, f3_arg1)
    -- 无需特殊清理，子目标系统会自动处理资源释放
    -- (No special cleanup needed, sub-goal system handles resource release automatically)
end

--[[============================================================================
    特殊转身攻击中断判断函数 (Special Turn Attack Interruption Function)
    ============================================================================
]]--

-- 特殊转身攻击中断判断函数 (Special turn attack interruption function)
-- 功能说明 (Function Description):
--   判断当前转身攻击是否可以被其他行为中断。该模块被注册为不可中断类型，
--   确保转身攻击动作的完整性和流畅性。
--
-- 参数说明 (Parameters):
--   f4_arg0: AI实体对象 (AI entity object) - 执行判断的AI实体
--   f4_arg1: 目标对象 (Goal object) - 当前目标对象
--
-- 返回值 (Return Value):
--   false: 不允许中断 (Do not allow interruption)
--
-- 设计理念 (Design Philosophy):
--   转身攻击是原子性操作，应该完整执行以保证：
--   - AI攻击动画的连贯性
--   - 避免转身到一半被打断的不自然现象
--   - 确保转身攻击的威胁性和可预测性
--
-- 例外情况 (Exception Cases):
--   即使返回false，以下情况仍可能强制中断：
--   - AI角色死亡或被击倒
--   - 系统级的紧急行为切换
--   - 脚本错误或异常状态
function SpecialTurn_Interupt(f4_arg0, f4_arg1)
    -- 不允许中断，确保转身攻击的完整执行 (Do not allow interruption, ensure complete turn attack execution)
    return false

end

--[[============================================================================
    文件结束 (End of File)
    ============================================================================

    特殊转身攻击模块已完成文档化。该模块现在具有：
    - 完整的功能说明和设计理念
    - 详细的参数说明和角度判断逻辑
    - 清晰的执行流程和优化策略
    - 专业级的代码注释

    技术特点 (Technical Features):
    - 智能角度检测：避免不必要的转身动画
    - 性能优化：快速标志位检查
    - 流畅性提升：减少AI"抽搐"现象
    - 灵活配置：支持自定义角度阈值

    使用建议 (Usage Recommendations):
    - 对于需要精准朝向的攻击（如冲刺技、范围技），使用较小角度阈值（30-45度）
    - 对于容错性高的攻击（如横扫、旋转技），可使用较大角度阈值（60-90度）
    - 配合AttackTunableSpin使用，提供更细致的转身控制
    - 在BOSS战中使用，提升攻击预判的可读性

    与其他攻击模块的关系 (Relationship with Other Attack Modules):
    - GOAL_COMMON_Attack: 基础攻击，无特殊转身逻辑
    - GOAL_COMMON_AttackTunableSpin: 可调整转身攻击，本模块的底层依赖
    - GOAL_COMMON_SpecialTurn: 智能转身攻击，本模块

    常见应用场景 (Common Application Scenarios):
    1. 重型武器攻击：需要准确朝向才能发挥威力
    2. 远程攻击：需要面向目标才能命中
    3. 冲刺技能：需要精确的初始朝向
    4. BOSS特殊技能：提升技能的仪式感和可预测性

    调试技巧 (Debug Tips):
    - 观察Number(0)的值，判断是跳过还是执行了转身
    - 调整旋回角度参数，找到最佳的流畅度和准确度平衡
    - 使用调试参数实时修改角度阈值，测试不同值的效果
    ============================================================================
]]--

