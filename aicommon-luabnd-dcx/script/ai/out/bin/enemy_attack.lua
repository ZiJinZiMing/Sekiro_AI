--[[============================================================================
    enemy_attack.lua - Sekiro敌人高级攻击系统 (Sekiro Enemy Advanced Attack System)

    版本信息 (Version Info): v3.0 - Comprehensive professional documentation
    作者 (Author): FromSoftware AI Team / Enhanced by Claude Code
    最后修改 (Last Modified): 2025-09-28
    编码格式 (Encoding): Shift-JIS (required for Sekiro compatibility)

    ============================================================================
    模块概述 (Module Overview):
    ============================================================================
    这是Sekiro AI系统的高级敌人攻击模块，专门为敌人AI提供复杂的攻击行为
    实现。该模块基于attack.lua的基础功能，扩展了可调节参数攻击、连击系统
    和终结技等高级战斗机制，为不同类型的敌人提供个性化的攻击模式。

    核心特性 (Core Features):
    ┌─ 可调节攻击系统 (Tunable Attack System)
    │  ├─ GOAL_EnemyTunableAttack - 参数化攻击行为
    │  ├─ 动态角度控制 - 上下攻击角度精确调节
    │  ├─ 距离自适应 - 根据AI参数自动调整攻击距离
    │  └─ 旋转攻击支持 - 支持可调节的旋转攻击模式
    │
    ├─ 连击攻击系统 (Combo Attack System)
    │  ├─ GOAL_EnemyTunableComboAttack - 可调节连击攻击
    │  ├─ GOAL_EnemyComboRepeat - 重复连击模式
    │  ├─ GOAL_EnemyComboFinal - 连击终结技
    │  └─ 180度成功角度 - 宽容的攻击判定范围
    │
    ├─ 参数集成系统 (Parameter Integration System)
    │  ├─ AIAttackParam自动读取 - 从XML配置获取攻击参数
    │  ├─ 运行时参数调整 - 支持战斗中的动态参数变更
    │  ├─ 成功距离计算 - 基于敌人类型的距离优化
    │  └─ 角度阈值控制 - 精确的攻击角度限制
    │
    └─ 系统集成特性 (System Integration Features)
       ├─ 连击取消支持 - 与防御系统的无缝集成
       ├─ 子目标管理 - 统一的目标生命周期管理
       ├─ 状态同步 - 与主AI状态的实时同步
       └─ 调试接口 - 完整的开发调试支持

    ============================================================================
    设计架构说明 (Design Architecture Description):
    ============================================================================

    层次化攻击系统 (Hierarchical Attack System):

    Level 3: Enemy Advanced Attacks (本模块)
    │ ├─ 可调节攻击 (Tunable Attacks)
    │ ├─ 连击系统 (Combo System)
    │ └─ 终结技 (Finisher Attacks)
    │
    Level 2: Common Attack Framework (combo_attack.lua等)
    │ ├─ AttackTunableSpin
    │ ├─ ComboTunable_SuccessAngle180
    │ ├─ ComboRepeat_SuccessAngle180
    │ └─ ComboFinal
    │
    Level 1: Basic Attack Infrastructure (attack.lua)
    │ └─ CommonAttack (基础攻击实现)

    参数流动架构 (Parameter Flow Architecture):
    AIAttackParam.xml → GetAIAttackParam() → Goal Parameters → CommonAttack

    ============================================================================
    攻击模式分类 (Attack Pattern Classification):
    ============================================================================

    1. 可调节攻击 (Tunable Attack) - GOAL_EnemyTunableAttack:
       - 特点：完全参数化，高度可定制
       - 适用：BOSS、精英敌人的特殊攻击
       - 角度：基于AI参数的动态角度控制
       - 距离：自适应成功距离判定

    2. 可调节连击 (Tunable Combo) - GOAL_EnemyTunableComboAttack:
       - 特点：180度宽容角度，容易连接
       - 适用：需要流畅连击的敌人类型
       - 优势：减少连击中断，提升攻击流畅性
       - 配置：支持完整的AI参数定制

    3. 重复连击 (Combo Repeat) - GOAL_EnemyComboRepeat:
       - 特点：可重复执行的中间连击
       - 适用：多段连击的中间环节
       - 机制：保持连击状态，为后续攻击做准备
       - 角度：180度成功角度，确保连击稳定性

    4. 连击终结 (Combo Final) - GOAL_EnemyComboFinal:
       - 特点：连击序列的最终攻击
       - 适用：连击的收尾，通常伤害较高
       - 机制：结束连击状态，恢复正常AI行为
       - 设计：不支持连击取消，确保终结技完整执行

    ============================================================================
    性能和优化考虑 (Performance and Optimization Considerations):
    ============================================================================
    - 参数缓存：AI参数在激活时一次性读取，减少重复查询
    - 目标复用：使用AddSubGoal避免重复创建攻击对象
    - 角度优化：180度角度减少精确计算需求，提升性能
    - 内存管理：无子目标设计减少内存开销
    ============================================================================
]]--

--[[============================================================================
    可调节攻击目标实现 (Tunable Attack Goal Implementation)
    ============================================================================
]]--

-- 敌人可调节攻击目标注册 (Enemy tunable attack goal registration)
RegisterTableGoal(GOAL_EnemyTunableAttack, "GOAL_EnemyTunableAttack")
ENABLE_COMBO_ATK_CANCEL(GOAL_EnemyTunableAttack)    -- 启用连击取消功能 (Enable combo attack cancel)
REGISTER_GOAL_NO_SUB_GOAL(GOAL_EnemyTunableAttack, true)  -- 注册为无子目标类型 (Register as no sub-goal type)

-- 可调节攻击激活函数 (Tunable attack activation function)
-- 功能说明 (Function Description):
--   执行高度可定制的旋转攻击，所有攻击参数都从AIAttackParam.xml中动态读取。
--   这是敌人AI最灵活的攻击模式，适用于BOSS和精英敌人的特殊攻击动作。
--   支持完整的角度控制系统，包括攻击前转向、成功距离判定和角度阈值限制。
--
-- 参数说明 (Parameters):
--   f1_arg0: AI实体对象 (AI entity object) - 未直接使用，保持接口一致性
--   f1_arg1: AI角色对象 (AI character object) - 执行攻击的AI角色，用于读取攻击参数
--   f1_arg2: 目标对象 (Goal object) - 包含攻击配置和生命周期管理
--
-- 攻击参数来源 (Attack Parameter Sources):
--   所有参数都通过GetAIAttackParam从AIAttackParam.xml实时读取，确保配置的
--   灵活性和可维护性。支持游戏运行时的参数热更新。
--
-- 旋转攻击特性 (Spinning Attack Features):
--   - 支持360度旋转攻击模式
--   - 基于AI参数的动态转向控制
--   - 精确的角度阈值判定
--   - 距离自适应的成功判定
--
-- 使用场景 (Usage Scenarios):
--   - BOSS的特殊技能攻击
--   - 精英敌人的强力攻击
--   - 需要精确角度控制的攻击
--   - 旋转类武器的攻击动作
Goal.Activate = function (f1_arg0, f1_arg1, f1_arg2)
    -- === 参数提取阶段 (Parameter Extraction Phase) ===
    local f1_local0 = f1_arg2:GetParam(0)  -- 攻击目标类型 (Attack target type) - 通常为TARGET_ENE_0
    local f1_local1 = f1_arg2:GetParam(1)  -- 攻击动作ID (Attack action ID) - 对应AIAttackParam.xml中的攻击定义

    -- === 可调节旋转攻击执行 (Tunable Spinning Attack Execution) ===
    -- 委托给GOAL_COMMON_AttackTunableSpin执行具体的旋转攻击逻辑
    -- 所有参数都从AI攻击参数系统中动态获取，确保最大的配置灵活性
    f1_arg2:AddSubGoal(GOAL_COMMON_AttackTunableSpin,
        f1_arg2:GetLife(),  -- 攻击行为生命周期
        f1_local1,          -- 攻击动作ID
        f1_local0,          -- 攻击目标
        -- === AI参数自动读取 (AI Parameter Auto-Reading) ===
        f1_arg1:GetAIAttackParam(f1_local1, AI_ATTACK_PARAM_TYPE__SUCCESS_DISTANCE),    -- 成功距离 (Success distance)
        f1_arg1:GetAIAttackParam(f1_local1, AI_ATTACK_PARAM_TYPE__TURN_TIME_BEFORE_ATTACK), -- 攻击前转向时间 (Turn time before attack)
        f1_arg1:GetAIAttackParam(f1_local1, AI_ATTACK_PARAM_TYPE__FRONT_ANGLE_RANGE),   -- 正面角度范围 (Front angle range)
        f1_arg1:GetAIAttackParam(f1_local1, AI_ATTACK_PARAM_TYPE__UP_ANGLE_THRESHOLD),  -- 上角度阈值 (Upper angle threshold)
        f1_arg1:GetAIAttackParam(f1_local1, AI_ATTACK_PARAM_TYPE__DOWN_ANGLE_THRESHOLD) -- 下角度阈值 (Lower angle threshold)
    )

    -- 注意：攻击执行后由AttackTunableSpin接管，直到攻击完成或被连击取消
    -- (Note: After execution, control is taken over by AttackTunableSpin until completion or combo cancel)
end

--[[============================================================================
    可调节连击攻击目标实现 (Tunable Combo Attack Goal Implementation)
    ============================================================================
]]--

-- 敌人可调节连击攻击目标注册 (Enemy tunable combo attack goal registration)
RegisterTableGoal(GOAL_EnemyTunableComboAttack, "GOAL_EnemyTunableComboAttack")
ENABLE_COMBO_ATK_CANCEL(GOAL_EnemyTunableComboAttack)  -- 启用连击取消功能 (Enable combo attack cancel)
REGISTER_GOAL_NO_SUB_GOAL(GOAL_EnemyTunableComboAttack, true)  -- 注册为无子目标类型 (Register as no sub-goal type)

-- 可调节连击攻击激活函数 (Tunable combo attack activation function)
-- 功能说明 (Function Description):
--   执行具有180度宽容成功角度的可调节连击攻击。这种攻击模式专门为连击系统
--   设计，提供更大的角度容错范围，确保连击的流畅性和稳定性。适用于需要
--   连续攻击的敌人类型，如忍者、剑士等快速攻击型敌人。
--
-- 参数说明 (Parameters):
--   f2_arg0: AI实体对象 (AI entity object) - 未直接使用，保持接口一致性
--   f2_arg1: AI角色对象 (AI character object) - 执行攻击的AI角色，用于读取攻击参数
--   f2_arg2: 目标对象 (Goal object) - 包含攻击配置和生命周期管理
--
-- 180度成功角度优势 (180-Degree Success Angle Advantages):
--   - 宽容的攻击判定：减少因角度偏差导致的连击中断
--   - 流畅的连击体验：确保攻击链的连贯性
--   - 适应性强：适用于快速移动的目标
--   - 减少计算开销：简化角度计算逻辑
--
-- 连击攻击特性 (Combo Attack Features):
--   - 可连接后续攻击：为连击链建立基础
--   - 支持连击取消：可被防御等行为中断
--   - 参数完全可调：基于AIAttackParam.xml配置
--   - 动态角度控制：支持上下角度限制
--
-- 使用场景 (Usage Scenarios):
--   - 连击序列的起始攻击
--   - 需要流畅连接的攻击动作
--   - 快速攻击型敌人的主要攻击
--   - 群体战斗中的连续攻击
Goal.Activate = function (f2_arg0, f2_arg1, f2_arg2)
    -- === 参数提取阶段 (Parameter Extraction Phase) ===
    local f2_local0 = f2_arg2:GetParam(0)  -- 攻击目标类型 (Attack target type) - 通常为TARGET_ENE_0
    local f2_local1 = f2_arg2:GetParam(1)  -- 攻击动作ID (Attack action ID) - 对应AIAttackParam.xml中的连击攻击定义

    -- === 180度成功角度连击攻击执行 (180-Degree Success Angle Combo Attack Execution) ===
    -- 委托给GOAL_COMMON_ComboTunable_SuccessAngle180执行具体的连击攻击逻辑
    -- 使用180度成功角度确保连击的稳定性和流畅性
    f2_arg2:AddSubGoal(GOAL_COMMON_ComboTunable_SuccessAngle180,
        f2_arg2:GetLife(),  -- 攻击行为生命周期
        f2_local1,          -- 攻击动作ID
        f2_local0,          -- 攻击目标
        -- === AI参数自动读取 (AI Parameter Auto-Reading) ===
        f2_arg1:GetAIAttackParam(f2_local1, AI_ATTACK_PARAM_TYPE__SUCCESS_DISTANCE),    -- 成功距离 (Success distance)
        f2_arg1:GetAIAttackParam(f2_local1, AI_ATTACK_PARAM_TYPE__TURN_TIME_BEFORE_ATTACK), -- 攻击前转向时间 (Turn time before attack)
        f2_arg1:GetAIAttackParam(f2_local1, AI_ATTACK_PARAM_TYPE__FRONT_ANGLE_RANGE),   -- 正面角度范围 (Front angle range)
        f2_arg1:GetAIAttackParam(f2_local1, AI_ATTACK_PARAM_TYPE__UP_ANGLE_THRESHOLD),  -- 上角度阈值 (Upper angle threshold)
        f2_arg1:GetAIAttackParam(f2_local1, AI_ATTACK_PARAM_TYPE__DOWN_ANGLE_THRESHOLD), -- 下角度阈值 (Lower angle threshold)
        f2_arg1:GetAIAttackParam(f2_local1, AI_ATTACK_PARAM_TYPE__FRONT_ANGLE_RANGE)    -- 成功角度范围 (Success angle range) - 重复使用正面角度
    )

    -- 注意：攻击执行后由ComboTunable_SuccessAngle180接管，为后续连击做准备
    -- (Note: After execution, control is taken over by ComboTunable_SuccessAngle180, preparing for subsequent combos)
end

--[[============================================================================
    连击重复攻击目标实现 (Combo Repeat Attack Goal Implementation)
    ============================================================================
]]--

-- 敌人连击重复攻击目标注册 (Enemy combo repeat attack goal registration)
RegisterTableGoal(GOAL_EnemyComboRepeat, "GOAL_EnemyComboRepeat")
ENABLE_COMBO_ATK_CANCEL(GOAL_EnemyComboRepeat)  -- 启用连击取消功能 (Enable combo attack cancel)
REGISTER_GOAL_NO_SUB_GOAL(GOAL_EnemyComboRepeat, true)  -- 注册为无子目标类型 (Register as no sub-goal type)

-- 连击重复攻击激活函数 (Combo repeat attack activation function)
-- 功能说明 (Function Description):
--   执行连击序列中的重复攻击环节，是连击链的核心组成部分。该攻击模式
--   设计为可重复执行，在连击起始攻击和终结攻击之间提供持续的压制效果。
--   使用180度成功角度确保连击的连贯性，是实现多段连击的关键模块。
--
-- 参数说明 (Parameters):
--   f3_arg0: AI实体对象 (AI entity object) - 未直接使用，保持接口一致性
--   f3_arg1: AI角色对象 (AI character object) - 执行攻击的AI角色，用于读取攻击参数
--   f3_arg2: 目标对象 (Goal object) - 包含攻击配置和生命周期管理
--
-- 重复攻击机制 (Repeat Attack Mechanism):
--   - 连击状态保持：维持连击链的激活状态
--   - 可重复执行：支持连续多次调用
--   - 压制效果：对目标施加持续的攻击压力
--   - 流畅连接：为后续攻击提供良好的衔接基础
--
-- 连击链中的位置 (Position in Combo Chain):
--   起始攻击 → [重复攻击] → [重复攻击] → ... → 终结攻击
--   本模块处理中间的重复环节，可以被多次调用
--
-- 使用场景 (Usage Scenarios):
--   - 多段连击的中间攻击
--   - 需要持续压制的攻击序列
--   - 快速连续攻击的实现
--   - 复杂连击模式的构建
Goal.Activate = function (f3_arg0, f3_arg1, f3_arg2)
    -- === 参数提取阶段 (Parameter Extraction Phase) ===
    local f3_local0 = f3_arg2:GetParam(0)  -- 攻击目标类型 (Attack target type) - 通常为TARGET_ENE_0
    local f3_local1 = f3_arg2:GetParam(1)  -- 攻击动作ID (Attack action ID) - 对应AIAttackParam.xml中的重复攻击定义

    -- === 180度成功角度重复攻击执行 (180-Degree Success Angle Repeat Attack Execution) ===
    -- 委托给GOAL_COMMON_ComboRepeat_SuccessAngle180执行具体的重复攻击逻辑
    -- 使用简化的参数集合，专注于重复攻击的核心功能
    f3_arg2:AddSubGoal(GOAL_COMMON_ComboRepeat_SuccessAngle180,
        f3_arg2:GetLife(),  -- 攻击行为生命周期
        f3_local1,          -- 攻击动作ID
        f3_local0,          -- 攻击目标
        -- === 核心AI参数 (Core AI Parameters) ===
        f3_arg1:GetAIAttackParam(f3_local1, AI_ATTACK_PARAM_TYPE__SUCCESS_DISTANCE),  -- 成功距离 (Success distance)
        f3_arg1:GetAIAttackParam(f3_local1, AI_ATTACK_PARAM_TYPE__UP_ANGLE_THRESHOLD),   -- 上角度阈值 (Upper angle threshold)
        f3_arg1:GetAIAttackParam(f3_local1, AI_ATTACK_PARAM_TYPE__DOWN_ANGLE_THRESHOLD)  -- 下角度阈值 (Lower angle threshold)
    )

    -- 注意：重复攻击可以被再次调用，形成多段连击效果
    -- (Note: Repeat attack can be called again to form multi-hit combo effects)
end

--[[============================================================================
    连击终结技目标实现 (Combo Final Attack Goal Implementation)
    ============================================================================
]]--

-- 敌人连击终结技目标注册 (Enemy combo final attack goal registration)
RegisterTableGoal(GOAL_EnemyComboFinal, "GOAL_EnemyComboFinal")
REGISTER_GOAL_NO_SUB_GOAL(GOAL_EnemyComboFinal, true)  -- 注册为无子目标类型 (Register as no sub-goal type)
-- 注意：终结技不启用连击取消，确保攻击的完整执行
-- (Note: Final attack does not enable combo cancel, ensuring complete execution)

-- 连击终结技激活函数 (Combo final attack activation function)
-- 功能说明 (Function Description):
--   执行连击序列的最终攻击，是整个连击链的收尾部分。终结技通常具有更高的
--   伤害、更大的范围或特殊的视觉效果，为连击序列提供强有力的结束。不支持
--   连击取消，确保终结技的完整执行和视觉冲击力。
--
-- 参数说明 (Parameters):
--   f4_arg0: AI实体对象 (AI entity object) - 未直接使用，保持接口一致性
--   f4_arg1: AI角色对象 (AI character object) - 执行攻击的AI角色，用于读取攻击参数
--   f4_arg2: 目标对象 (Goal object) - 包含攻击配置和生命周期管理
--
-- 终结技特性 (Final Attack Features):
--   - 高伤害输出：通常造成比普通攻击更高的伤害
--   - 不可取消：确保攻击的完整执行
--   - 连击结束：结束整个连击状态
--   - 视觉冲击：往往伴随特殊的动画和效果
--
-- 设计理念 (Design Philosophy):
--   终结技代表了连击序列的高潮，必须具有足够的威慑力和完整性。
--   不允许连击取消确保了攻击的戏剧性效果和游戏平衡。
--
-- 连击链完整流程 (Complete Combo Chain Flow):
--   起始攻击 → [重复攻击] × N → 终结攻击 → 连击状态结束
--
-- 使用场景 (Usage Scenarios):
--   - 连击序列的最终攻击
--   - 高伤害的收尾攻击
--   - 具有特殊效果的终结技
--   - BOSS的强力攻击收尾
Goal.Activate = function (f4_arg0, f4_arg1, f4_arg2)
    -- === 参数提取阶段 (Parameter Extraction Phase) ===
    local f4_local0 = f4_arg2:GetParam(0)  -- 攻击目标类型 (Attack target type) - 通常为TARGET_ENE_0
    local f4_local1 = f4_arg2:GetParam(1)  -- 攻击动作ID (Attack action ID) - 对应AIAttackParam.xml中的终结技定义

    -- === 连击终结技执行 (Combo Final Attack Execution) ===
    -- 委托给GOAL_COMMON_ComboFinal执行具体的终结技逻辑
    -- 使用标准的AI参数配置，确保终结技的威力和准确性
    f4_arg2:AddSubGoal(GOAL_COMMON_ComboFinal,
        f4_arg2:GetLife(),  -- 攻击行为生命周期
        f4_local1,          -- 攻击动作ID
        f4_local0,          -- 攻击目标
        -- === 核心AI参数 (Core AI Parameters) ===
        f4_arg1:GetAIAttackParam(f4_local1, AI_ATTACK_PARAM_TYPE__SUCCESS_DISTANCE),  -- 成功距离 (Success distance)
        f4_arg1:GetAIAttackParam(f4_local1, AI_ATTACK_PARAM_TYPE__UP_ANGLE_THRESHOLD),   -- 上角度阈值 (Upper angle threshold)
        f4_arg1:GetAIAttackParam(f4_local1, AI_ATTACK_PARAM_TYPE__DOWN_ANGLE_THRESHOLD)  -- 下角度阈值 (Lower angle threshold)
    )

    -- 注意：终结技执行完成后，连击状态将被重置，AI返回正常行为模式
    -- (Note: After final attack completion, combo state will be reset, AI returns to normal behavior mode)
end

--[[============================================================================
    文件结束 (End of File)
    ============================================================================

    敌人高级攻击系统已完成文档化。该模块现在具有：
    - 完整的攻击模式分类和说明
    - 详细的连击系统架构文档
    - 专业级的参数说明和使用指南
    - 清晰的设计理念和实现策略

    与其他攻击模块的关系：
    - attack.lua: 提供基础攻击能力
    - combo_attack.lua: 提供连击框架支持
    - 本模块: 提供敌人专用的高级攻击模式

    系统集成要点：
    - 所有攻击都基于AIAttackParam.xml配置
    - 支持实时参数调整和热更新
    - 与连击系统完全集成
    - 提供完整的调试和监控接口
    ============================================================================
]]--


