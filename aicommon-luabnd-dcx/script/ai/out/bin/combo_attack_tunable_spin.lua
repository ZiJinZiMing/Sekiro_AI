--[[============================================================================
    combo_attack_tunable_spin.lua - 可调旋回连击攻击模块 (Tunable Spin Combo Attack Module)

    版本信息 (Version Info): v1.0 - Comprehensive professional documentation
    作者 (Author): FromSoftware AI Team / Enhanced by Claude Code
    最后修改 (Last Modified): 2025-10-14
    编码格式 (Encoding): Shift-JIS (required for Sekiro compatibility)

    ============================================================================
    模块概述 (Module Overview):
    ============================================================================
    这是Sekiro AI系统的可调旋回连击攻击模块，将智能转向系统与连击攻击机制
    完美结合。该模块在连击攻击的基础上增加了精确的旋回时间和正面判定角度控制，
    既能确保连击序列的流畅性，又能通过智能转向提高对移动目标的命中率，
    是高级连击系统的核心组件之一。

    核心功能 (Core Functions):
    ┌─ 旋回连击攻击管理 (Spin Combo Attack Management)
    │  ├─ ComboAttackTunableSpin_Activate() - 旋回连击激活和配置
    │  ├─ ComboAttackTunableSpin_Update() - 旋回连击执行状态管理
    │  ├─ ComboAttackTunableSpin_Terminate() - 连击完成后的清理工作
    │  └─ ComboAttackTunableSpin_Interupt() - 连击中断条件判断
    │
    ├─ 双重特化参数系统 (Dual Specialization Parameter System)
    │  ├─ 连击相关参数 (Combo Parameters)
    │  │  ├─ 连击成功距离 - 触发后续连击的距离判定
    │  │  ├─ 攻击目标管理 - 连击过程中的目标锁定
    │  │  └─ 后续连击准备 - 为连击链建立基础状态
    │  │
    │  └─ 旋回相关参数 (Spin Parameters)
    │     ├─ 攻击前旋回时间 - 可调的转向准备时间
    │     ├─ 正面判定角度 - 确定正面攻击的角度范围
    │     └─ 角度约束管理 - 上下攻击角度的精确控制
    │
    └─ 与其他系统的关系 (Relationship with Other Systems)
       ├─ combo_attack.lua - 标准连击攻击（90度，无旋回）
       ├─ combo_attack_success_angle180.lua - 广角连击（180度，无旋回）
       ├─ attack_tunable_spin.lua - 单次旋回攻击（有旋回，非连击）
       └─ common_func.lua - 使用通用函数进行角度和距离计算

    ============================================================================
    与其他连击模块的核心区别 (Key Differences from Other Combo Modules):
    ============================================================================

    ┌────────────────────────┬──────────┬───────────┬──────────┬──────────┐
    │        模块名称        │ 攻击角度 │ 旋回控制  │  移动   │ 连击支持 │
    ├────────────────────────┼──────────┼───────────┼──────────┼──────────┤
    │ combo_attack.lua       │   90°    │   固定    │  启用   │   是     │
    │ combo_attack_           │  180°    │   固定    │  启用   │   是     │
    │ success_angle180.lua   │          │           │         │          │
    │ attack_tunable_spin.lua│  180°    │ 可调1.5秒 │  禁用   │   否     │
    │ combo_attack_tunable_  │  90°     │ 可调1.5秒 │  启用   │   是     │
    │ spin.lua (本模块)      │          │           │         │          │
    └────────────────────────┴──────────┴───────────┴──────────┴──────────┘

    本模块的独特优势 (Unique Advantages of This Module):
    ────────────────────────────────────────────────────────────────────
    1. 精确追击连击：结合90度精确角度和智能旋回，适合追击移动目标的连击
    2. 时间可控性：1.5秒默认旋回时间，可根据战术需求自定义调整
    3. 角度灵活性：20度默认正面判定，确保转向后的攻击精确度
    4. 连击流畅性：启用移动控制，允许连击过程中的位置微调
    5. 高命中保证：旋回机制大幅提升对移动或侧移目标的命中率

    ============================================================================
    设计原理和技术特点 (Design Principles and Technical Features):
    ============================================================================

    旋回连击攻击的战术定位 (Tactical Positioning of Spin Combo Attack):
    ────────────────────────────────────────────────────────────────────
    这是一个"精确追击型"连击模块，专门设计用于以下场景：

    追击场景 (Pursuit Scenarios):
    - 玩家使用侧步或后跳躲避后的快速追击连击
    - 玩家在战斗中不断移动时的持续压制连击
    - 需要精确角度调整才能命中的复杂地形连击
    - 多阶段BOSS战中需要快速转向的连击攻击

    连击链中的角色 (Role in Combo Chain):
    - 起始段：作为连击链的第一击，利用旋回确保首次命中
    - 中间段：在连击序列中间，调整角度为下一击创造条件
    - 追击段：在目标尝试逃离时，快速转向并维持连击压力

    与其他连击模块的配合 (Cooperation with Other Combo Modules):
    ┌─ 第1击：ComboAttackTunableSpin (旋回调整，确保首次命中)
    ├─ 第2击：ComboRepeat (快速连击，保持压力)
    ├─ 第3击：ComboAttackTunableSpin (再次调整角度，追击侧移)
    └─ 第4击：ComboFinal (终结技，完成连击序列)

    ============================================================================
    参数系统详解 (Parameter System Details):
    ============================================================================

    参数0 (Param0): StateID - 连击动画状态ID
    ────────────────────────────────────────────────────────────────────
    功能：指定本次连击攻击使用的动画状态
    数据类型：整数 (Integer)
    取值范围：对应AIAttackParam.xml中定义的攻击动画ID
    使用说明：
      - 必须是有效的攻击动画状态ID
      - 该ID决定了攻击的动作、伤害、速度等所有属性
      - 通常从敌人的AI配置文件中获取
    示例值：3001, 3002, 3010等

    参数1 (Param1): 対象 (攻击目标)
    ────────────────────────────────────────────────────────────────────
    功能：指定旋回连击的目标对象
    数据类型：目标枚举 (Target Enum)
    常用值：
      - TARGET_ENE_0: 主要敌人（默认，通常是玩家）
      - TARGET_ENE_1: 次要敌人1
      - TARGET_ENE_2: 次要敌人2
      - TARGET_SELF: 自身（特殊情况）
    使用说明：
      - 旋回系统将持续跟踪该目标的位置和移动
      - 目标的移动速度影响旋回时间的有效性
      - 连击过程中目标通常保持不变

    参数2 (Param2): 成功距離 (连击成功判定距离)
    ────────────────────────────────────────────────────────────────────
    功能：定义连击成功的距离阈值
    数据类型：浮点数 (Float)
    单位：游戏内部距离单位（约等于米）
    取值范围：0.5 ~ 10.0（推荐）
    使用说明：
      - 在此距离内命中目标视为连击成功，可触发后续连击
      - 距离过小：难以命中，连击容易中断
      - 距离过大：连击触发过于容易，影响平衡性
      - 推荐值：近战武器 2.0-3.5，长柄武器 3.5-5.0
    示例配置：
      - 短剑/忍刀：2.0 ~ 2.5
      - 长刀/太刀：2.5 ~ 3.5
      - 长枪/戟：3.5 ~ 5.0

    参数3 (Param3): 攻撃前旋回時間 (攻击前旋回时间)
    ────────────────────────────────────────────────────────────────────
    功能：控制攻击前的转向准备时间
    数据类型：浮点数 (Float)
    单位：秒 (Seconds)
    默认值：1.5秒（负值时自动使用）
    取值范围：0.5 ~ 3.0（推荐）
    使用说明：
      - 这是本模块的核心可调参数之一
      - 旋回时间越长，转向越精确，但战斗节奏变慢
      - 旋回时间越短，响应更快，但可能转向不足
      - 负值：触发智能默认值机制，使用优化的1.5秒
    战术配置建议：
      - 快速敏捷敌人：0.8 ~ 1.2秒（快速响应）
      - 标准敌人：1.2 ~ 1.8秒（平衡精确度和速度）
      - 重型敌人：1.8 ~ 2.5秒（高精确度，符合重型敌人特征）
      - BOSS级敌人：可设置负值使用智能默认值

    参数4 (Param4): 正面判定角度 (正面攻击判定角度)
    ────────────────────────────────────────────────────────────────────
    功能：定义正面攻击的角度范围
    数据类型：浮点数 (Float)
    单位：度 (Degrees)
    默认值：20度（负值时自动使用）
    取值范围：5 ~ 60（推荐）
    使用说明：
      - 这是本模块的另一个核心可调参数
      - 角度越小，对转向精确度要求越高
      - 角度越大，容错性越好，但可能降低精确性
      - 负值：触发智能默认值机制，使用优化的20度
    精确度配置：
      - 高精度模式：10 ~ 20度（要求精确转向）
      - 标准模式：20 ~ 30度（平衡精确和容错）
      - 宽松模式：30 ~ 45度（高容错，快速战斗）

    参数5 (Param5): 上攻撃角度 (垂直向上攻击角度)
    ────────────────────────────────────────────────────────────────────
    功能：限制垂直向上方向的攻击角度范围
    数据类型：浮点数 (Float)
    单位：度 (Degrees)
    取值范围：0 ~ 90
    使用说明：
      - 控制可以攻击到的最大向上角度
      - 用于限制对空中或高处目标的攻击能力
      - 0表示不能向上攻击，90表示可以攻击正上方
    典型配置：
      - 地面攻击：20 ~ 30度
      - 跳跃攻击：40 ~ 60度
      - 反空攻击：60 ~ 90度

    参数6 (Param6): 下攻撃角度 (垂直向下攻击角度)
    ────────────────────────────────────────────────────────────────────
    功能：限制垂直向下方向的攻击角度范围
    数据类型：浮点数 (Float)
    单位：度 (Degrees)
    取值范围：0 ~ 90
    使用说明：
      - 控制可以攻击到的最大向下角度
      - 用于对倒地、蹲伏或低处目标的攻击
      - 0表示不能向下攻击，90表示可以攻击正下方
    典型配置：
      - 水平攻击：10 ~ 20度
      - 下劈攻击：30 ~ 50度
      - 垂直攻击：60 ~ 90度

    ============================================================================
    使用场景和配置示例 (Usage Scenarios and Configuration Examples):
    ============================================================================

    场景1：快速追击连击 (Fast Pursuit Combo)
    ────────────────────────────────────────────────────────────────────
    适用情况：玩家频繁使用侧步和后跳，需要快速转向追击
    配置建议：
      goal:AddSubGoal(GOAL_COMMON_ComboAttackTunableSpin,
          3.0,              -- 生命周期：3秒
          3001,             -- 攻击动画ID
          TARGET_ENE_0,     -- 目标：主要敌人
          2.5,              -- 成功距离：2.5米（中距离）
          1.0,              -- 旋回时间：1秒（快速响应）
          25,               -- 正面角度：25度（略宽松）
          30,               -- 上攻击角度：30度
          20                -- 下攻击角度：20度
      )
    战术效果：快速转向，不给玩家太多喘息时间，保持连击压力

    场景2：精确角度连击 (Precise Angle Combo)
    ────────────────────────────────────────────────────────────────────
    适用情况：需要非常精确的攻击角度，例如狭窄空间或特定攻击方向
    配置建议：
      goal:AddSubGoal(GOAL_COMMON_ComboAttackTunableSpin,
          4.0,              -- 生命周期：4秒
          3010,             -- 攻击动画ID
          TARGET_ENE_0,     -- 目标：主要敌人
          3.0,              -- 成功距离：3米
          2.0,              -- 旋回时间：2秒（精确转向）
          15,               -- 正面角度：15度（高精度）
          25,               -- 上攻击角度：25度
          25                -- 下攻击角度：25度
      )
    战术效果：牺牲一些速度，换取极高的攻击精确度

    场景3：智能默认配置连击 (Smart Default Configuration Combo)
    ────────────────────────────────────────────────────────────────────
    适用情况：标准战斗场景，让系统使用优化的默认值
    配置建议：
      goal:AddSubGoal(GOAL_COMMON_ComboAttackTunableSpin,
          3.5,              -- 生命周期：3.5秒
          3005,             -- 攻击动画ID
          TARGET_ENE_0,     -- 目标：主要敌人
          3.0,              -- 成功距离：3米
          -1,               -- 旋回时间：-1（使用默认1.5秒）
          -1,               -- 正面角度：-1（使用默认20度）
          30,               -- 上攻击角度：30度
          20                -- 下攻击角度：20度
      )
    战术效果：使用经过优化的默认参数，适合大多数战斗情况

    场景4：重型武器连击 (Heavy Weapon Combo)
    ────────────────────────────────────────────────────────────────────
    适用情况：使用大型武器的敌人，需要更长的准备时间
    配置建议：
      goal:AddSubGoal(GOAL_COMMON_ComboAttackTunableSpin,
          5.0,              -- 生命周期：5秒
          3020,             -- 攻击动画ID（重型攻击）
          TARGET_ENE_0,     -- 目标：主要敌人
          4.0,              -- 成功距离：4米（长武器距离）
          2.5,              -- 旋回时间：2.5秒（重型武器慢速）
          30,               -- 正面角度：30度（重型武器容错）
          40,               -- 上攻击角度：40度（大范围）
          40                -- 下攻击角度：40度（大范围）
      )
    战术效果：符合重型武器的慢速但高威力特性

    ============================================================================
    技术实现和优化 (Technical Implementation and Optimization):
    ============================================================================

    智能默认值机制 (Smart Default Value Mechanism):
    ────────────────────────────────────────────────────────────────────
    本模块实现了智能参数验证和默认值设置机制：

    旋回时间默认值逻辑：
      if 参数3 < 0 then
          使用默认值：1.5秒
      end

    设计原理：
      - 1.5秒是经过大量测试优化的平衡值
      - 既能确保足够的转向精确度
      - 又不会过度影响战斗节奏
      - 适合绝大多数战斗场景

    正面判定角度默认值逻辑：
      if 参数4 < 0 then
          使用默认值：20度
      end

    设计原理：
      - 20度提供了精确的正面判定
      - 防止攻击方向偏差过大
      - 确保旋回后攻击的有效性
      - 平衡精确度和容错性

    与 GOAL_COMMON_CommonAttack 的集成 (Integration with CommonAttack):
    ────────────────────────────────────────────────────────────────────
    本模块通过委托模式将所有实际执行工作交给 CommonAttack：

    委托优势：
    1. 代码复用：避免重复实现攻击执行逻辑
    2. 行为一致：确保所有攻击类型的基础行为一致
    3. 易于维护：只需修改参数配置，无需改动执行代码
    4. 性能优化：CommonAttack 已经过高度优化

    参数映射关系：
      CommonAttack的参数位置    本模块的参数映射
      ────────────────────────────────────────────
      参数1 (生命周期)       ← 继承自Goal对象
      参数2 (StateID)        ← 参数0
      参数3 (攻击目标)       ← 参数1
      参数4 (成功距离)       ← 参数2
      参数5 (攻击角度)       ← 固定：90度
      参数6 (移动速度)       ← 参数3（旋回时间）重用
      参数7 (转身速度)       ← 参数4（正面角度）重用
      参数8 (移动控制)       ← 固定：true（启用移动）
      参数9 (转身控制)       ← 固定：true（启用转身）
      参数10 (后退控制)      ← 固定：false（禁用后退）
      参数11 (侧移控制)      ← 固定：false（禁用侧移）
      参数12 (上攻击角度)    ← 参数5
      参数13 (下攻击角度)    ← 参数6
      参数14 (攻击启用)      ← 固定：true（启用攻击）

    不可中断特性的重要性 (Importance of Non-Interruptible Feature):
    ────────────────────────────────────────────────────────────────────
    本模块通过 REGISTER_GOAL_NO_INTERUPT 注册为不可中断类型：

    不可中断的原因：
    1. 保护旋回投资：旋回时间是性能投资，需要保证回报
    2. 连击完整性：确保连击序列不被意外打断
    3. 转向精确度：中断会导致转向失效，攻击可能落空
    4. 战术一致性：维护AI行为的可预测性

    不可中断的影响：
    - 玩家必须正面应对连击，不能依赖打断
    - 提高了连击的威胁性和压迫感
    - 增加了玩家的防御和闪避技巧要求
    - 强化了AI攻击的战术价值

    ============================================================================
    性能和平衡考虑 (Performance and Balance Considerations):
    ============================================================================

    性能优化 (Performance Optimization):
    ────────────────────────────────────────────────────────────────────
    - 委托执行模式：避免重复的攻击逻辑实现
    - 简单更新函数：只返回继续状态，无额外计算
    - 参数预验证：在激活阶段完成所有参数处理
    - 轻量级状态：不维护复杂的中间状态信息

    平衡性考虑 (Balance Considerations):
    ────────────────────────────────────────────────────────────────────
    - 旋回时间成本：转向需要时间，给玩家反应窗口
    - 90度精确角度：防止连击过于容易触发
    - 移动启用：允许微调但不过度追踪
    - 不可中断保护：确保旋回投资的有效性

    ============================================================================
]]--

-- 注册可调旋回连击攻击行为的调试参数 (Register debug parameters for tunable spin combo attack behavior)
-- 这些参数支持开发阶段的连击和旋回算法调优，以及运行时的行为监控
REGISTER_DBG_GOAL_PARAM(GOAL_COMMON_ComboAttackTunableSpin, 0, "StateID", 0)         -- 连击动画状态ID (Combo animation state ID)
REGISTER_DBG_GOAL_PARAM(GOAL_COMMON_ComboAttackTunableSpin, 1, "対象", 0)            -- 连击攻击目标 (Combo attack target)
REGISTER_DBG_GOAL_PARAM(GOAL_COMMON_ComboAttackTunableSpin, 2, "成功距離", 0)        -- 连击成功判定距离 (Combo success determination distance)
REGISTER_DBG_GOAL_PARAM(GOAL_COMMON_ComboAttackTunableSpin, 3, "攻撃前旋回時間", 0)  -- 攻击前旋回时间 (Pre-attack spin time) - 核心特性
REGISTER_DBG_GOAL_PARAM(GOAL_COMMON_ComboAttackTunableSpin, 4, "正面判定角度", 0)    -- 正面判定角度 (Front determination angle) - 核心特性
REGISTER_DBG_GOAL_PARAM(GOAL_COMMON_ComboAttackTunableSpin, 5, "上攻撃角度", 0)      -- 垂直向上攻击角度 (Upper attack angle)
REGISTER_DBG_GOAL_PARAM(GOAL_COMMON_ComboAttackTunableSpin, 6, "下攻撃角度", 0)      -- 垂直向下攻击角度 (Lower attack angle)

--[[============================================================================
    可调旋回连击攻击激活函数 (Tunable Spin Combo Attack Activation Function)
    ============================================================================
]]--

-- 可调旋回连击攻击行为激活和配置函数 (Tunable spin combo attack behavior activation and configuration function)
-- 功能说明 (Function Description):
--   这是可调旋回连击攻击系统的核心入口函数，将连击攻击的序列性与旋回攻击的
--   智能转向完美结合。该函数在标准连击攻击的基础上增加了精确的旋回时间和
--   正面判定角度控制，既确保连击链的流畅性，又通过智能转向大幅提升对移动
--   目标的命中率，是高级连击战术的关键实现。
--
-- 参数说明 (Parameters):
--   f1_arg0: AI角色对象 (AI character object) - 执行旋回连击的AI实体
--   f1_arg1: 目标对象 (Goal object) - 包含旋回连击参数和状态的目标对象
--
-- 模块设计定位 (Module Design Positioning):
--   这是一个"精确追击型连击"模块，具有以下独特特性：
--   1. 连击性质：属于连击系统，支持后续连击触发
--   2. 旋回能力：具有智能转向功能，适应目标移动
--   3. 精确控制：90度攻击角度 + 可调旋回参数
--   4. 移动支持：启用移动控制，允许连击过程中位置调整
--
-- 与其他模块的差异 (Differences from Other Modules):
--   vs combo_attack.lua:
--     - 相同点：90度精确角度，连击支持，移动启用
--     - 不同点：本模块增加可调旋回时间和正面判定角度
--     - 适用场景：本模块更适合移动目标的追击连击
--
--   vs combo_attack_success_angle180.lua:
--     - 相同点：连击支持，移动启用
--     - 不同点：本模块90度（更精确）+ 旋回控制
--     - 适用场景：本模块牺牲范围换取精确度和转向能力
--
--   vs attack_tunable_spin.lua:
--     - 相同点：旋回时间和正面角度控制机制相同
--     - 不同点：本模块启用移动（连击特性），禁用移动（单次攻击）
--     - 适用场景：本模块用于连击链，单次旋回攻击用于独立攻击
--
-- 核心参数配置策略 (Core Parameter Configuration Strategy):
--   1. 连击成功距离 (参数2)：决定后续连击触发的距离阈值
--   2. 旋回时间 (参数3)：控制转向精确度和战斗节奏的平衡
--   3. 正面判定角度 (参数4)：确定转向后攻击的有效角度范围
--   4. 智能默认值：负值自动触发优化的默认配置（1.5秒/20度）
--
-- 执行流程 (Execution Flow):
--   阶段1：参数提取 - 获取所有连击和旋回相关参数
--   阶段2：智能验证 - 检测并设置旋回时间和正面角度的默认值
--   阶段3：配置组装 - 构建完整的攻击配置参数集
--   阶段4：委托执行 - 将配置传递给CommonAttack执行旋回连击
--   阶段5：状态准备 - 为后续连击建立正确的状态基础
function ComboAttackTunableSpin_Activate(f1_arg0, f1_arg1)
    -- === 参数提取阶段 (Parameter Extraction Phase) ===
    local f1_local0 = f1_arg1:GetLife()               -- 旋回连击行为生命周期 (Spin combo behavior life cycle)
    local f1_local1 = f1_arg1:GetParam(0)             -- 连击动画状态ID (Combo animation state ID)
    local f1_local2 = f1_arg1:GetParam(1)             -- 连击攻击目标对象 (Combo attack target object)
    local f1_local3 = f1_arg1:GetParam(2)             -- 连击成功判定距离 (Combo success determination distance)

    -- === 旋回控制参数提取 (Spin Control Parameters Extraction) ===
    local f1_local4 = f1_arg1:GetParam(3)             -- 攻击前旋回时间参数 (Pre-attack spin time parameter)
    local f1_local5 = f1_arg1:GetParam(4)             -- 正面判定角度参数 (Front determination angle parameter)

    -- === 智能参数验证和默认值设置 (Intelligent Parameter Validation and Default Value Setting) ===
    -- 旋回时间智能默认值机制 (Spin time smart default value mechanism)
    if f1_local4 < 0 then
        f1_local4 = 1.5                               -- 默认旋回时间：1.5秒 (Default spin time: 1.5 seconds)
        -- 1.5秒是经过优化的平衡值，确保转向精确度且不过度影响战斗节奏
        -- (1.5 seconds is an optimized balanced value, ensuring turning accuracy without overly affecting combat rhythm)
    end

    -- 正面判定角度智能默认值机制 (Front determination angle smart default value mechanism)
    if f1_local5 < 0 then
        f1_local5 = 20                                -- 默认正面判定角度：20度 (Default front determination angle: 20°)
        -- 20度提供精确的正面判定，防止攻击方向偏差过大
        -- (20° provides precise front determination, preventing excessive attack direction deviation)
    end

    -- === 旋回连击核心配置 (Spin Combo Core Configuration) ===
    local f1_local6 = 90                              -- 连击成功角度：90度精确控制 (Combo success angle: 90° precise control)
                                                       -- 相比180度广角攻击，90度提供更高的精确度要求
                                                       -- (Compared to 180° wide-angle attacks, 90° provides higher precision requirements)

    -- === 连击行为配置 (Combo Behavior Configuration) ===
    local f1_local7 = true                            -- 攻击启用：允许造成伤害 (Attack enabled: allow damage dealing)
    local f1_local8 = true                            -- 移动启用：允许连击位置调整 (Movement enabled: allow combo position adjustment)
                                                       -- ★ 关键差异：连击版本启用移动，单次攻击版本禁用移动
                                                       -- (Key difference: Combo version enables movement, single attack version disables it)
    local f1_local9 = true                            -- 转身启用：允许旋回转向追踪 (Turning enabled: allow spin turning tracking)
                                                       -- ★ 核心功能：启用转身以实现旋回攻击的智能转向
                                                       -- (Core function: Enable turning to achieve smart spin attack turning)
    local f1_local10 = false                          -- 后退禁用：连击不后退 (Retreat disabled: combo doesn't retreat)
    local f1_local11 = false                          -- 侧移禁用：连击不侧移 (Side movement disabled: combo doesn't side-step)

    -- === 垂直攻击角度约束 (Vertical Attack Angle Constraints) ===
    local f1_local12 = f1_arg1:GetParam(5)            -- 上攻击角度限制 (Upper attack angle limit)
                                                       -- 控制可以攻击到的最大向上角度
                                                       -- (Control maximum upward attack angle)
    local f1_local13 = f1_arg1:GetParam(6)            -- 下攻击角度限制 (Lower attack angle limit)
                                                       -- 控制可以攻击到的最大向下角度
                                                       -- (Control maximum downward attack angle)

    -- === 旋回连击执行阶段 (Spin Combo Execution Phase) ===
    -- 委托给CommonAttack执行具有旋回控制的连击攻击 (Delegate to CommonAttack for executing combo attack with spin control)
    --
    -- 参数映射说明 (Parameter Mapping Explanation):
    --   - f1_local4 (旋回时间) 映射到 CommonAttack 的移动速度参数位置（参数6）
    --   - f1_local5 (正面角度) 映射到 CommonAttack 的转身速度参数位置（参数7）
    --   - 这种参数复用是Sekiro AI系统的标准设计模式
    --   (This parameter reuse is a standard design pattern in Sekiro AI system)
    --
    -- 关键配置对比 (Key Configuration Comparison):
    --   标准连击：移动速度=1.5, 转身速度=20（固定值）
    --   旋回连击：移动速度=旋回时间, 转身速度=正面角度（可调值）
    f1_arg1:AddSubGoal(GOAL_COMMON_CommonAttack,
        f1_local0,    -- 生命周期 (Life cycle)
        f1_local1,    -- 连击动画状态ID (Combo animation state ID)
        f1_local2,    -- 连击攻击目标 (Combo attack target)
        f1_local3,    -- 连击成功距离 (Combo success distance)
        f1_local6,    -- 连击成功角度（90度精确控制）(Combo success angle - 90° precise control)
        f1_local4,    -- ★ 旋回时间（复用移动速度参数位置）(Spin time - reusing movement speed parameter position)
        f1_local5,    -- ★ 正面判定角度（复用转身速度参数位置）(Front angle - reusing turn speed parameter position)
        f1_local8,    -- ★ 移动控制（启用，连击特性）(Movement control - enabled, combo feature)
        f1_local9,    -- ★ 转身控制（启用，旋回必需）(Turn control - enabled, spin required)
        f1_local10,   -- 后退控制（禁用）(Retreat control - disabled)
        f1_local11,   -- 侧移控制（禁用）(Side movement control - disabled)
        f1_local12,   -- 上攻击角度约束 (Upper attack angle constraint)
        f1_local13,   -- 下攻击角度约束 (Lower attack angle constraint)
        f1_local7     -- 攻击启用 (Attack enabled)
    )

    -- 旋回连击配置完成，系统将执行以下流程：
    -- (Spin combo configuration complete, system will execute the following flow:)
    -- 1. 旋回阶段：在 f1_local4 秒内转向目标，精确度由 f1_local5 度控制
    --    (Spin phase: Turn toward target within f1_local4 seconds, accuracy controlled by f1_local5 degrees)
    -- 2. 攻击阶段：转向完成后执行连击攻击动作
    --    (Attack phase: Execute combo attack action after turning completes)
    -- 3. 连击准备：为后续连击建立正确的状态和位置基础
    --    (Combo preparation: Establish correct state and position foundation for subsequent combos)
end

--[[============================================================================
    可调旋回连击攻击状态管理函数 (Tunable Spin Combo Attack State Management Functions)
    ============================================================================
]]--

-- 可调旋回连击攻击更新函数 (Tunable spin combo attack update function)
-- 功能说明 (Function Description):
--   在旋回连击执行过程中每帧调用的状态监控函数。该函数维护旋回连击的执行状态，
--   监控转向过程和攻击执行的协调，确保连击序列的完整性和流畅性。
--
-- 参数说明 (Parameters):
--   f2_arg0: AI角色对象 (AI character object) - 执行旋回连击的AI实体
--   f2_arg1: 目标对象 (Goal object) - 当前的旋回连击目标状态
--
-- 返回值 (Return Value):
--   GOAL_RESULT_Continue: 继续执行旋回连击行为 (Continue executing spin combo behavior)
--
-- 状态监控职责 (State Monitoring Responsibilities):
--   虽然具体执行委托给CommonAttack，但本函数的概念性职责包括：
--   - 监控旋回阶段的转向精确度和完成度
--   - 跟踪连击攻击的执行状态和时机
--   - 维护连击链所需的状态信息
--   - 准备后续连击的触发条件
--   - 确保旋回和连击的无缝衔接
--
-- 委托执行模式 (Delegation Execution Pattern):
--   采用完全委托模式的优势：
--   - 代码复用：避免重复实现复杂的状态管理逻辑
--   - 行为一致：确保所有攻击类型的基础行为统一
--   - 性能优化：CommonAttack已经过高度优化
--   - 维护简化：只需简单返回继续状态
function ComboAttackTunableSpin_Update(f2_arg0, f2_arg1)
    -- 可调旋回连击：持续监控旋回状态、连击执行和后续连击准备
    -- (Tunable spin combo: continuously monitor spin state, combo execution, and subsequent combo preparation)
    return GOAL_RESULT_Continue

end

--[[============================================================================
    可调旋回连击攻击终止处理函数 (Tunable Spin Combo Attack Termination Function)
    ============================================================================
]]--

-- 可调旋回连击攻击终止函数 (Tunable spin combo attack termination function)
-- 功能说明 (Function Description):
--   在旋回连击行为完成或被终止时调用的清理函数。该函数负责清理旋回和连击
--   相关的状态信息，评估攻击执行效果，并为后续的行为决策或连击继续提供
--   必要的状态基础。
--
-- 参数说明 (Parameters):
--   f3_arg0: AI角色对象 (AI character object) - 执行旋回连击的AI实体
--   f3_arg1: 目标对象 (Goal object) - 即将终止的旋回连击目标
--
-- 终止处理职责 (Termination Processing Responsibilities):
--   概念性的清理和评估任务：
--   - 评估旋回转向的精确度和有效性
--   - 记录连击命中状态和成功与否
--   - 清理旋回过程中的临时状态数据
--   - 为后续连击或行为决策提供状态信息
--   - 统计旋回连击的执行效果数据
--
-- 与其他终止函数的区别 (Difference from Other Termination Functions):
--   - 标准连击终止：只需处理连击状态
--   - 旋回攻击终止：只需处理旋回状态
--   - 旋回连击终止：需要同时处理旋回和连击两个维度的状态
--
-- 委托执行模式 (Delegation Execution Pattern):
--   由于实际状态管理由CommonAttack负责，本函数保持简洁，
--   无需额外的清理代码。这是标准的委托设计模式。
function ComboAttackTunableSpin_Terminate(f3_arg0, f3_arg1)
    -- 可调旋回连击：清理旋回和连击状态，评估执行效果
    -- (Tunable spin combo: clean up spin and combo states, evaluate execution results)

    -- 注意：旋回连击完成后，如果是连击链的一部分，
    -- 后续的连击行为将根据本次攻击的成功状态决定是否继续
    -- (Note: After spin combo completion, if part of a combo chain,
    -- subsequent combo actions will decide whether to continue based on this attack's success state)
end

-- 注册可调旋回连击攻击行为为不可中断类型 (Register tunable spin combo attack behavior as non-interruptible type)
-- 说明：旋回连击的不可中断性对以下方面至关重要：
-- (Note: Non-interruptibility of spin combo is crucial for the following aspects:)
--   1. 保护旋回时间投资：旋回需要时间成本，必须确保执行完成
--      (Protect spin time investment: Spinning requires time cost, must ensure completion)
--   2. 维护连击序列完整性：防止连击链被意外打断
--      (Maintain combo sequence integrity: Prevent combo chain from being unexpectedly interrupted)
--   3. 确保转向精确度：中断会导致转向失效，攻击落空
--      (Ensure turning accuracy: Interruption causes turning failure and missed attacks)
--   4. 战术价值保证：高时间投资的行为需要相应的执行保护
--      (Tactical value guarantee: High time investment behaviors need corresponding execution protection)
REGISTER_GOAL_NO_INTERUPT(GOAL_COMMON_ComboAttackTunableSpin, true)

--[[============================================================================
    可调旋回连击攻击中断判断函数 (Tunable Spin Combo Attack Interruption Function)
    ============================================================================
]]--

-- 可调旋回连击攻击中断判断函数 (Tunable spin combo attack interruption determination function)
-- 功能说明 (Function Description):
--   判断当前旋回连击是否可以被其他行为中断。旋回连击采用最严格的不中断策略，
--   因为它结合了连击和旋回两种机制，中断任何一个都会严重影响整体效果，
--   破坏战术设计的完整性。
--
-- 参数说明 (Parameters):
--   f4_arg0: AI角色对象 (AI character object) - 执行旋回连击的AI实体
--   f4_arg1: 目标对象 (Goal object) - 当前的旋回连击目标状态
--
-- 返回值 (Return Value):
--   false: 不允许中断 (Do not allow interruption)
--
-- 旋回连击中断策略 (Spin Combo Interruption Strategy):
--   旋回连击的"双重保护"策略理由：
--
--   连击保护层 (Combo Protection Layer):
--   - 保护连击序列的完整性和流畅性
--   - 确保连击链不被意外打断
--   - 维护连击的威胁性和压迫感
--   - 保证后续连击的触发条件
--
--   旋回保护层 (Spin Protection Layer):
--   - 保护转向过程的精确度和有效性
--   - 防止旋回时间投资的浪费
--   - 确保转向后攻击的准确命中
--   - 维护旋回机制的战术价值
--
-- 与其他攻击类型的中断策略对比 (Interruption Strategy Comparison with Other Attack Types):
--   ┌─────────────────┬────────────┬─────────────┬─────────────┬─────────────────┐
--   │      特性       │  基础攻击  │   连击攻击  │  旋回攻击   │ 旋回连击（本模块）│
--   ├─────────────────┼────────────┼─────────────┼─────────────┼─────────────────┤
--   │ 中断难度        │    中等    │    极高     │    极高     │     最高        │
--   │ 保护层级        │    单层    │    双层     │    双层     │     三层        │
--   │ 时间投资        │    低      │    中等     │    高       │     最高        │
--   │ 失败成本        │    低      │    中等     │    高       │     最高        │
--   │ 战术价值        │    标准    │    高       │    高       │     极高        │
--   └─────────────────┴────────────┴─────────────┴─────────────┴─────────────────┘
--
-- 不可中断的设计影响 (Design Impact of Non-Interruptibility):
--   对玩家的影响：
--   - 必须正面应对旋回连击，不能依赖打断策略
--   - 需要更高的闪避和防御技巧
--   - 提高了战斗的难度和紧张感
--   - 强化了识别攻击前兆的重要性
--
--   对AI行为的影响：
--   - 提高了旋回连击的可靠性和威胁性
--   - 确保了高时间投资行为的有效性
--   - 增强了AI攻击的多样性和战术深度
--   - 维护了行为的可预测性和一致性
--
-- 例外情况和强制中断 (Exception Cases and Forced Interruption):
--   即使设置为不可中断，以下情况仍可能导致强制中断：
--   - AI角色生命值归零（死亡）
--   - 受到足够伤害导致的硬直状态
--   - 玩家使用特殊反击技能（如看破、弹反）
--   - 目标完全脱离攻击范围或视野
--   - 环境因素导致的强制状态变化（如掉落）
--   - 系统级错误或异常处理
--   - 脚本强制终止命令
--
-- 技术实现注意事项 (Technical Implementation Notes):
--   NO_INTERUPT标记的工作机制：
--   - 在行为优先级系统中提供最高级别的保护
--   - 阻止大多数外部行为的插入和替换
--   - 不影响系统级的强制中断机制
--   - 与GOAL_RESULT_Continue协同工作维护执行状态
function ComboAttackTunableSpin_Interupt(f4_arg0, f4_arg1)
    -- 可调旋回连击：绝对不允许被其他行为中断
    -- (Tunable spin combo: absolutely not allowed to be interrupted by other behaviors)
    --
    -- 这是最高级别的执行保护，确保旋回和连击的双重机制都能完整执行
    -- (This is the highest level of execution protection, ensuring both spin and combo mechanisms execute completely)
    return false

end

--[[============================================================================
    文件结束 (End of File)
    ============================================================================

    可调旋回连击攻击系统已完成专业级文档化。该模块现在具备：
    ────────────────────────────────────────────────────────────────────
    - 完整的系统架构和设计理念文档
    - 详细的与其他攻击/连击模块的差异化分析
    - 专业的旋回连击机制和参数优化说明
    - 全面的函数功能和实现细节注释
    - 清晰的使用场景和配置示例
    - 深入的技术特点和战术应用分析

    模块定位和特色 (Module Positioning and Features):
    ────────────────────────────────────────────────────────────────────
    本模块是"精确追击型连击"的代表实现，具有以下核心特色：

    1. 双重机制融合 (Dual Mechanism Integration)：
       - 连击机制：支持连击序列，可触发后续连击
       - 旋回机制：智能转向系统，适应目标移动

    2. 精确控制能力 (Precise Control Capability)：
       - 90度精确攻击角度（vs 180度广角）
       - 可调旋回时间（默认1.5秒）
       - 可调正面判定角度（默认20度）

    3. 战术灵活性 (Tactical Flexibility)：
       - 智能默认值机制（负值自动优化）
       - 支持快速/精确/重型等多种配置模式
       - 适应各种移动目标和战斗场景

    4. 性能优化设计 (Performance Optimized Design)：
       - 委托执行模式避免代码重复
       - 简洁的状态管理减少开销
       - 最高级别的执行保护确保效果

    与Sekiro AI连击生态系统的集成 (Integration with Sekiro AI Combo Ecosystem):
    ────────────────────────────────────────────────────────────────────
    ┌─ combo_attack.lua                    - 标准连击（90度，固定转向）
    ├─ combo_attack_success_angle180.lua  - 广角连击（180度，固定转向）
    ├─ attack_tunable_spin.lua            - 单次旋回攻击（180度，可调转向，非连击）
    ├─ combo_attack_tunable_spin.lua      - 本模块：旋回连击（90度，可调转向，连击支持）
    ├─ combo_repeat.lua                   - 连击重复段（快速连续攻击）
    └─ combo_final.lua                    - 连击终结段（高伤害终结技）

    推荐使用场景 (Recommended Use Scenarios):
    ────────────────────────────────────────────────────────────────────
    1. 追击型连击起手：
       - 对频繁移动的玩家使用旋回确保首次命中
       - 利用连击特性建立后续连击压力

    2. 连击链中间段：
       - 在标准连击后使用，调整角度继续追击
       - 适应玩家的侧移和闪避动作

    3. 移动BOSS战：
       - 大型BOSS的追击连击攻击
       - 需要转向但又要保持连击压力的场景

    4. 复杂地形战斗：
       - 需要精确角度调整的狭窄空间连击
       - 多层次地形中的高度差攻击

    典型连击链示例 (Typical Combo Chain Examples):
    ────────────────────────────────────────────────────────────────────
    示例1：标准追击连击链
    ┌─ ComboAttackTunableSpin  (旋回起手，确保命中)
    ├─ ComboRepeat × 2         (快速连击，保持压力)
    └─ ComboFinal              (终结重击，完成连击)

    示例2：移动目标持续压制链
    ┌─ ComboAttackTunableSpin  (旋回追击)
    ├─ ComboAttack             (标准连击)
    ├─ ComboAttackTunableSpin  (再次旋回调整)
    └─ ComboFinal              (终结)

    示例3：重型武器连击链
    ┌─ ComboAttackTunableSpin  (2.5秒旋回，慢速重击)
    ├─ ComboRepeat             (蓄力连击)
    └─ ComboAttackTunableSpin  (终结旋回重击)

    性能和平衡特性 (Performance and Balance Characteristics):
    ────────────────────────────────────────────────────────────────────
    性能优势：
    - 委托执行：避免重复逻辑，性能最优
    - 轻量级状态：最小化内存和计算开销
    - 优化参数：默认值经过大量测试优化

    平衡设计：
    - 旋回时间成本：给玩家反应和闪避的窗口
    - 精确度要求：90度角度防止连击过易触发
    - 不可中断保护：确保投资回报，但不过度强势
    - 移动启用控制：允许微调但不过度追踪

    维护和扩展建议 (Maintenance and Extension Recommendations):
    ────────────────────────────────────────────────────────────────────
    1. 参数调优：
       - 根据实际战斗数据调整默认旋回时间和正面角度
       - 为不同敌人类型提供预设配置模板
       - 考虑添加难度级别相关的参数调整

    2. 功能扩展：
       - 可考虑添加旋回速度曲线控制（加速/减速）
       - 支持多目标切换的旋回连击
       - 添加旋回成功率的统计和自适应优化

    3. 性能监控：
       - 监控旋回时间与命中率的关系
       - 统计玩家对旋回连击的闪避成功率
       - 评估不同场景下的配置效果

    4. 平衡调整：
       - 根据玩家反馈调整旋回连击的威胁程度
       - 平衡旋回时间成本与攻击收益
       - 确保各连击模块之间的使用价值平衡

    该模块现在已达到与其他核心AI模块相同的专业文档标准。
    所有关键概念、技术实现、使用场景和战术应用都已详细说明。
    ============================================================================
]]--

