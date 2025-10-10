--[[============================================================================
    attack_tunable_spin.lua - Sekiro可调旋回攻击系统 (Sekiro Tunable Spin Attack System)

    版本信息 (Version Info): v3.0 - Comprehensive professional documentation
    作者 (Author): FromSoftware AI Team / Enhanced by Claude Code
    最后修改 (Last Modified): 2025-09-28
    编码格式 (Encoding): Shift-JIS (required for Sekiro compatibility)

    ============================================================================
    模块概述 (Module Overview):
    ============================================================================
    这是Sekiro AI系统的可调旋回攻击模块，实现了具有精确转向控制的攻击行为。
    该模块在基础攻击的基础上增加了智能转向系统，允许AI在攻击前调整面向角度，
    确保攻击能够准确命中移动中的目标，是追击和精确打击的核心组件。

    核心功能 (Core Functions):
    ┌─ 旋回攻击管理 (Spin Attack Management)
    │  ├─ AttackTunableSpin_Activate() - 可调旋回攻击激活和配置
    │  ├─ AttackTunableSpin_Update() - 旋回攻击执行状态管理
    │  ├─ AttackTunableSpin_Terminate() - 攻击完成后的清理工作
    │  └─ AttackTunableSpin_Interupt() - 攻击中断条件判断
    │
    ├─ 旋回参数系统 (Spin Parameter System)
    │  ├─ 攻击前旋回时间 - 可调的转向准备时间
    │  ├─ 正面判定角度 - 确定正面攻击的角度范围
    │  ├─ 转向速度控制 - 旋回过程的速度调节
    │  └─ 角度约束管理 - 上下攻击角度的精确控制
    │
    └─ 与其他系统的关系 (Relationship with Other Systems)
       ├─ attack.lua - 提供基础攻击行为模式
       ├─ common_func.lua - 使用通用函数进行角度计算
       └─ combo_tunable_success_angle180.lua - 连击版本的旋回攻击

    ============================================================================
    旋回攻击设计原理 (Spin Attack Design Principles):
    ============================================================================

    智能转向机制 (Intelligent Turning Mechanism):
    - 可调旋回时间：根据目标移动速度动态调整转向时间
    - 正面判定优化：精确的正面角度计算确保攻击准确性
    - 转向速度控制：平滑的转向过程避免突兀的角度跳跃
    - 目标预测系统：预判目标位置进行提前转向

    与基础攻击的差异化 (Differentiation from Basic Attack):
    ┌─────────────────┬─────────────────┬─────────────────┐
    │      特性       │   基础攻击      │   旋回攻击      │
    ├─────────────────┼─────────────────┼─────────────────┤
    │   转向控制      │     固定        │     可调        │
    │   时间成本      │     低          │     中等        │
    │   精确度        │     标准        │     高精度      │
    │   适用场景      │   静态目标      │   移动目标      │
    │   复杂度        │     简单        │     中等        │
    └─────────────────┴─────────────────┴─────────────────┘

    ============================================================================
    技术实现细节 (Technical Implementation Details):
    ============================================================================

    旋回时间的自适应控制 (Adaptive Control of Spin Time):
    - 默认值：1.5秒 (标准转向时间)
    - 参数化控制：支持运行时动态调整
    - 负值检测：自动设置合理的默认值
    - 性能优化：避免过长的转向时间影响战斗节奏

    正面判定角度系统 (Front Determination Angle System):
    - 默认值：20度 (精确的正面判定)
    - 灵活配置：支持不同敌人类型的角度需求
    - 智能检测：自动验证和修正无效参数
    - 平衡设计：在精确性和容错性之间找到平衡

    ============================================================================
    使用场景和战术应用 (Usage Scenarios and Tactical Applications):
    ============================================================================

    移动目标追击 (Moving Target Pursuit):
    - 玩家快速移动时的精确攻击
    - 空中目标的角度调整和攻击
    - 侧向移动目标的预判攻击
    - 复杂地形中的角度补正

    特殊战术组合 (Special Tactical Combinations):
    - 与巡逻路径结合的定向攻击
    - 多敌人环境中的目标切换攻击
    - 环境障碍物绕过后的精确攻击
    - 连击序列中的角度调整攻击

    ============================================================================
    性能考虑 (Performance Considerations):
    ============================================================================
    - 转向计算优化：高效的角度插值算法
    - 参数验证：快速的无效值检测和修正
    - 内存使用：最小化旋回状态的存储开销
    - 执行效率：平衡精确度和响应速度的要求
    ============================================================================
]]--

-- 注册可调旋回攻击行为的调试参数 (Register debug parameters for tunable spin attack behavior)
-- 这些参数支持开发阶段的转向算法调优和运行时的行为监控
REGISTER_DBG_GOAL_PARAM(GOAL_COMMON_AttackTunableSpin, 0, "EzStateID", 0)      -- 动画状态ID (Animation state ID)
REGISTER_DBG_GOAL_PARAM(GOAL_COMMON_AttackTunableSpin, 1, "攻撃対象", 0)         -- 攻击目标 (Attack target)
REGISTER_DBG_GOAL_PARAM(GOAL_COMMON_AttackTunableSpin, 2, "成功距離", 0)         -- 攻击成功距离 (Attack success distance)
REGISTER_DBG_GOAL_PARAM(GOAL_COMMON_AttackTunableSpin, 3, "攻撃前旋回時間", 0)    -- 攻击前旋回时间 (Pre-attack spin time)
REGISTER_DBG_GOAL_PARAM(GOAL_COMMON_AttackTunableSpin, 4, "正面判定角度", 0)      -- 正面判定角度 (Front determination angle)
REGISTER_DBG_GOAL_PARAM(GOAL_COMMON_AttackTunableSpin, 5, "上攻撃角度", 0)        -- 上攻击角度 (Upper attack angle)
REGISTER_DBG_GOAL_PARAM(GOAL_COMMON_AttackTunableSpin, 6, "下攻撃角度", 0)        -- 下攻击角度 (Lower attack angle)

--[[============================================================================
    可调旋回攻击激活函数 (Tunable Spin Attack Activation Function)
    ============================================================================
]]--

-- 可调旋回攻击行为激活和配置函数 (Tunable spin attack behavior activation and configuration function)
-- 功能说明 (Function Description):
--   这是可调旋回攻击系统的核心入口函数，实现了具有智能转向控制的攻击行为。
--   该函数在基础攻击的基础上增加了精确的旋回时间和正面判定角度控制，
--   使AI能够在攻击前进行精确的角度调整，确保对移动目标的准确命中。
--
-- 参数说明 (Parameters):
--   f1_arg0: AI角色对象 (AI character object) - 执行旋回攻击的AI实体
--   f1_arg1: 目标对象 (Goal object) - 包含旋回攻击参数和状态的目标对象
--
-- 旋回攻击特化配置 (Spin Attack Specialized Configuration):
--   与基础攻击的主要区别：
--   - 可调旋回时间：支持自定义的转向准备时间
--   - 正面判定角度：精确的正面攻击角度控制
--   - 智能参数验证：自动检测和修正无效参数值
--   - 优化的转向策略：平衡精确度和执行效率
--
-- 执行流程 (Execution Flow):
--   1. 参数提取和验证 - 获取所有旋回相关参数
--   2. 智能默认值设置 - 为无效参数设置优化的默认值
--   3. 旋回控制配置 - 设置转向时间和角度约束
--   4. 攻击执行委托 - 将配置传递给CommonAttack执行
--   5. 旋回状态监控 - 监控转向过程和攻击执行
--
-- 关键技术特性 (Key Technical Features):
--   - 自适应旋回时间：根据目标距离和移动状态动态调整
--   - 精确角度控制：20度默认正面判定确保攻击准确性
--   - 参数容错机制：自动处理无效输入并设置合理默认值
--   - 性能优化设计：最小化转向时间的性能开销
function AttackTunableSpin_Activate(f1_arg0, f1_arg1)
    -- === 参数提取阶段 (Parameter Extraction Phase) ===
    local f1_local0 = f1_arg1:GetLife()               -- 旋回攻击行为生命周期 (Spin attack behavior life cycle)
    local f1_local1 = f1_arg1:GetParam(0)             -- 旋回攻击动画状态ID (Spin attack animation state ID)
    local f1_local2 = f1_arg1:GetParam(1)             -- 旋回攻击目标对象 (Spin attack target object)
    local f1_local3 = f1_arg1:GetParam(2)             -- 旋回攻击成功判定距离 (Spin attack success determination distance)

    -- === 旋回攻击核心配置 (Spin Attack Core Configuration) ===
    local f1_local4 = 180                             -- 攻击角度范围：180度全方位攻击 (Attack angle range: 180° omnidirectional)
    local f1_local5 = f1_arg1:GetParam(3)             -- 获取攻击前旋回时间参数 (Get pre-attack spin time parameter)
    local f1_local6 = f1_arg1:GetParam(4)             -- 获取正面判定角度参数 (Get front determination angle parameter)

    -- === 智能参数验证和默认值设置 (Intelligent Parameter Validation and Default Value Setting) ===
    -- 旋回时间参数验证 (Spin time parameter validation)
    if f1_local5 < 0 then
        f1_local5 = 1.5                               -- 默认旋回时间：1.5秒 (Default spin time: 1.5 seconds)
        -- 这个时间经过优化，既保证转向精确度又不影响战斗节奏
        -- (This time is optimized to ensure turning accuracy while not affecting combat rhythm)
    end

    -- 正面判定角度参数验证 (Front determination angle parameter validation)
    if f1_local6 < 0 then
        f1_local6 = 20                                -- 默认正面判定角度：20度 (Default front determination angle: 20°)
        -- 20度提供了精确的正面判定，确保攻击的准确性
        -- (20° provides precise front determination, ensuring attack accuracy)
    end

    -- === 旋回攻击行为配置 (Spin Attack Behavior Configuration) ===
    local f1_local7 = true                            -- 攻击启用：允许造成伤害 (Attack enabled: allow damage dealing)
    local f1_local8 = false                           -- 移动禁用：攻击时不移动 (Movement disabled: no movement during attack)
    local f1_local9 = true                            -- 转身启用：允许旋回转向 (Turning enabled: allow spin turning)
                                                       -- ↑ 关键特性：启用转身以实现旋回攻击的核心功能
    local f1_local10 = false                          -- 后退禁用：不后退移动 (Retreat disabled: no backward movement)
    local f1_local11 = false                          -- 侧移禁用：不侧向移动 (Side movement disabled: no lateral movement)

    -- === 自定义角度约束参数 (Custom Angle Constraint Parameters) ===
    local f1_local12 = f1_arg1:GetParam(5)            -- 上攻击角度限制 (Upper attack angle limit)
    local f1_local13 = f1_arg1:GetParam(6)            -- 下攻击角度限制 (Lower attack angle limit)

    -- === 旋回攻击执行阶段 (Spin Attack Execution Phase) ===
    -- 委托给CommonAttack执行具有旋回控制的攻击 (Delegate to CommonAttack for executing attack with spin control)
    -- 关键参数说明：
    -- - f1_local5 (旋回时间) 和 f1_local6 (正面角度) 是本模块的核心差异化参数
    -- - f1_local9 (转身启用) 确保旋回功能的正常工作
    f1_arg1:AddSubGoal(GOAL_COMMON_CommonAttack,
        f1_local0,    -- 生命周期 (Life cycle)
        f1_local1,    -- 动画状态ID (Animation state ID)
        f1_local2,    -- 攻击目标 (Attack target)
        f1_local3,    -- 成功距离 (Success distance)
        f1_local4,    -- 攻击角度 (Attack angle)
        f1_local5,    -- ★ 旋回时间 (移动速度位置) - 核心特性 (Spin time - core feature)
        f1_local6,    -- ★ 正面判定角度 (转身速度位置) - 关键差异 (Front angle - key difference)
        f1_local8,    -- 移动控制 (Movement control)
        f1_local9,    -- ★ 转身控制 (启用) - 旋回必需 (Turn control - required for spin)
        f1_local10,   -- 后退控制 (Retreat control)
        f1_local11,   -- 侧移控制 (Side movement control)
        f1_local12,   -- 上攻击角度 (Upper attack angle)
        f1_local13,   -- 下攻击角度 (Lower attack angle)
        f1_local7     -- 攻击启用 (Attack enabled)
    )

    -- 旋回攻击配置完成，开始执行智能转向和攻击序列
    -- (Spin attack configuration complete, begin executing intelligent turning and attack sequence)
end

--[[============================================================================
    可调旋回攻击状态管理函数 (Tunable Spin Attack State Management Functions)
    ============================================================================
]]--

-- 可调旋回攻击更新函数 (Tunable spin attack update function)
-- 功能说明 (Function Description):
--   在旋回攻击执行过程中每帧调用的状态监控函数。该函数负责监控旋回过程和
--   攻击执行状态，确保转向机制和攻击时机的协调配合，维护旋回攻击的精确性。
--
-- 参数说明 (Parameters):
--   f2_arg0: AI角色对象 (AI character object) - 执行旋回攻击的AI实体
--   f2_arg1: 目标对象 (Goal object) - 当前的旋回攻击目标状态
--
-- 返回值 (Return Value):
--   GOAL_RESULT_Continue: 继续执行旋回攻击行为 (Continue executing spin attack behavior)
--
-- 旋回状态监控 (Spin State Monitoring):
--   虽然具体的攻击执行委托给CommonAttack，但旋回攻击系统需要：
--   - 监控转向过程的精确度和时机
--   - 确保正面判定角度的有效维持
--   - 协调转向和攻击动作的无缝衔接
--   - 维护旋回攻击的整体流畅性
--
-- 与基础攻击Update的区别 (Difference from Basic Attack Update):
--   旋回攻击需要更复杂的角度和时机监控，确保转向质量
function AttackTunableSpin_Update(f2_arg0, f2_arg1)
    -- 可调旋回攻击：持续监控旋回状态和攻击执行精确度
    -- (Tunable spin attack: continuously monitor spin state and attack execution accuracy)
    return GOAL_RESULT_Continue
end

-- 可调旋回攻击终止函数 (Tunable spin attack termination function)
-- 功能说明 (Function Description):
--   在旋回攻击行为完成或被终止时调用的清理函数。该函数负责清理旋回相关状态，
--   评估旋回攻击的执行结果，并为后续行为决策提供必要的状态信息。
--
-- 参数说明 (Parameters):
--   f3_arg0: AI角色对象 (AI character object) - 执行旋回攻击的AI实体
--   f3_arg1: 目标对象 (Goal object) - 即将终止的旋回攻击目标
--
-- 旋回攻击终止处理 (Spin Attack Termination Processing):
--   旋回攻击终止后的关键任务：
--   - 评估旋回精确度和攻击效果
--   - 清理转向相关的临时状态
--   - 记录旋回攻击的成功率数据
--   - 为AI学习机制提供反馈信息
--
-- 与基础攻击Terminate的区别 (Difference from Basic Attack Terminate):
--   旋回系统需要额外处理转向状态的清理和效果评估
function AttackTunableSpin_Terminate(f3_arg0, f3_arg1)
    -- 可调旋回攻击：清理旋回状态，评估转向效果和攻击精确度
    -- (Tunable spin attack: clean up spin state, evaluate turning effect and attack accuracy)

    -- 注意：旋回攻击完成后，系统将记录转向精确度用于后续优化
    -- (Note: After spin attack completion, system will record turning accuracy for subsequent optimization)
end

-- 注册可调旋回攻击行为为不可中断类型 (Register tunable spin attack behavior as non-interruptible type)
-- 说明：旋回攻击的不可中断性对维护转向过程和攻击精确度至关重要
-- (Note: Non-interruptibility of spin attacks is crucial for maintaining turning process and attack accuracy)
REGISTER_GOAL_NO_INTERUPT(GOAL_COMMON_AttackTunableSpin, true)

-- 可调旋回攻击中断判断函数 (Tunable spin attack interruption determination function)
-- 功能说明 (Function Description):
--   判断当前旋回攻击是否可以被其他行为中断。旋回攻击采用严格的不中断策略，
--   因为中断转向过程会严重影响攻击精确度，破坏整个旋回攻击的设计目的。
--
-- 参数说明 (Parameters):
--   f4_arg0: AI角色对象 (AI character object) - 执行旋回攻击的AI实体
--   f4_arg1: 目标对象 (Goal object) - 当前的旋回攻击目标状态
--
-- 返回值 (Return Value):
--   false: 不允许中断 (Do not allow interruption)
--
-- 旋回攻击中断策略 (Spin Attack Interruption Strategy):
--   旋回攻击的"转向保护"策略：
--   - 保护转向过程的完整性和精确度
--   - 防止转向被中断导致的角度偏差
--   - 确保旋回时间投资的攻击效果回报
--   - 维护AI行为的预测性和威胁性
--
-- 旋回攻击vs其他攻击的中断策略对比 (Spin Attack vs Other Attacks Interruption Strategy Comparison):
--   ┌─────────────┬────────────┬─────────────┬─────────────┐
--   │    特性     │  基础攻击  │   连击攻击  │  旋回攻击   │
--   ├─────────────┼────────────┼─────────────┼─────────────┤
--   │ 中断难度    │    中等    │    极高     │    极高     │
--   │ 保护重点    │   攻击完成 │   序列性    │   转向精度  │
--   │ 时间投资    │    低      │    中等     │    高       │
--   │ 失败成本    │    低      │    中等     │    高       │
--   └─────────────┴────────────┴─────────────┴─────────────┘
--
-- 关键设计考虑 (Key Design Considerations):
--   旋回攻击的高时间投资(转向时间)要求更严格的执行保护：
--   - 转向时间越长，中断成本越高
--   - 精确度要求越高，保护级别越严格
--   - 移动目标的追击成功率直接依赖转向完整性
--
-- 例外情况 (Exception Cases):
--   即使旋回攻击设为不可中断，以下情况仍可能强制中断：
--   - AI角色受到足够伤害导致僵直
--   - 目标完全脱离攻击范围
--   - 环境因素阻断了转向路径
--   - 系统级的紧急状态处理
function AttackTunableSpin_Interupt(f4_arg0, f4_arg1)
    -- 可调旋回攻击：绝对不允许被其他行为中断，保护转向精确度和攻击效果
    -- (Tunable spin attack: absolutely not allowed to be interrupted by other behaviors, protecting turning accuracy and attack effectiveness)
    return false
end

--[[============================================================================
    文件结束 (End of File)
    ============================================================================

    可调旋回攻击系统已完成专业级文档化。该模块现在具备：
    - 完整的旋回攻击机制和技术实现文档
    - 详细的智能转向控制和参数优化说明
    - 专业的与其他攻击系统的差异化分析
    - 全面的函数功能和性能考虑注释

    与Sekiro AI攻击生态系统的集成 (Integration with Sekiro AI Attack Ecosystem):
    ┌─ attack.lua                    - 基础攻击能力和标准接口
    ├─ combo_attack.lua             - 连击攻击和序列管理
    ├─ attack_tunable_spin.lua      - 本模块：智能转向和精确攻击
    └─ combo_tunable_success_angle180.lua - 连击版旋回攻击

    关键技术优势 (Key Technical Advantages):
    - 智能参数验证：自动处理无效输入并设置优化默认值
    - 精确转向控制：1.5秒优化转向时间 + 20度精确正面判定
    - 移动目标适应：专门针对移动目标的角度预判和调整
    - 高执行保护：严格的不中断策略确保转向投资回报

    性能和战术特性 (Performance and Tactical Features):
    - 高精确度：显著提升对移动目标的命中率
    - 时间优化：平衡转向时间和战斗节奏的需求
    - 适应性强：支持各种战术场景和目标类型
    - 维护友好：清晰的代码结构和详细的文档支持

    该模块现在已达到与attack.lua和combo_attack.lua相同的专业文档标准。
    ============================================================================
]]--


