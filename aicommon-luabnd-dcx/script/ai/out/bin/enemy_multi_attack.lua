--[[============================================================================
    enemy_multi_attack.lua - 敌人多段攻击系统 (Enemy Multi-Attack System)

    版本信息 (Version Info): v1.0
    作者 (Author): FromSoftware AI Team / Enhanced by Claude Code
    最后修改 (Last Modified): 2025-10-21
    编码格式 (Encoding): Shift-JIS (required for Sekiro compatibility)

    ============================================================================
    模块概述 (Module Overview):
    ============================================================================
    这是Sekiro AI系统中的多段攻击系统模块。该模块提供了一个通用的多段攻击框架，
    能够管理多个连续攻击动作并根据概率决定是否连接后续攻击。它充当了高层攻击
    决策系统与底层HandyAttack连击执行系统之间的中间桥梁，负责组织和协调多个
    攻击阶段的执行流程。

    核心功能 (Core Functions):
    ├─ 多段攻击管理：组织并执行包含多个阶段的复杂攻击序列
    ├─ 概率控制：通过灵活的概率参数控制攻击链的形成与中断
    ├─ 连击触发：自动利用HandyAttack系统处理连击逻辑
    ├─ 执行流程控制：在Activate和Update中管理攻击生命周期
    └─ 与HandyAttack的集成：充分利用现有的连击和多段机制

    与其他攻击模块的关系 (Relationship with Other Attack Modules):
    ┌─ enemy_handy_attack.lua    - 便捷攻击系统（处理基础连击逻辑）
    ├─ enemy_keepdist.lua        - 距离保持系统（行走和躲避）
    ├─ combo_attack_tunable_spin.lua - 旋回连击（精确角度控制）
    └─ common_func.lua           - 通用函数（数学和工具函数）

    ============================================================================
    参数系统详解 (Parameter System Details):
    ============================================================================

    参数0 (Param0): 対象 (攻击目标)
    ────────────────────────────────────────────────────────────────────
    功能：指定多段攻击的目标对象
    数据类型：目标枚举 (Target Enum)
    常用值：
      - TARGET_ENE_0: 主要敌人（默认，通常是玩家）
      - TARGET_ENE_1: 次要敌人1
      - TARGET_ENE_2: 次要敌人2
    使用说明：
      - 在整个多段攻击过程中保持目标不变
      - 目标一经设定，该系列攻击都将针对此目标

    参数1 (Param1): コンボ確率 (连击概率)
    ────────────────────────────────────────────────────────────────────
    功能：控制多段攻击中连击成功的概率
    数据类型：浮点数 (Float)
    单位：百分比 (0.0 ~ 100.0)
    取值范围：0 ~ 100
    使用说明：
      - 决定了整个攻击链是否能继续连接
      - 此参数用于所有6段攻击的连击概率（均匀分布）
      - 概率高：易形成长连击链，给玩家压力大
      - 概率低：连击易中断，战斗节奏较为分散
    推荐配置：
      - 敏捷敌人：60-80% （快速且具有威胁）
      - 标准敌人：40-60% （平衡的连击威胁）
      - 笨拙敌人：20-40% （较容易防守）

    参数2~7 (Param2-Param7): 攻撃1~6 (6段攻击动画ID)
    ────────────────────────────────────────────────────────────────────
    功能：指定多段攻击序列中的每个攻击动画状态ID
    数据类型：整数 (Integer)
    取值范围：对应AIAttackParam.xml中定义的有效攻击ID
    使用说明：
      - 这些ID按顺序组成一个完整的攻击链
      - 如果某个位置的ID为0或无效，则该段及后续段不执行
      - 通常从敌人的AI配置中预先定义
      - 建议遵循递进式设计：前段蓄力少，后段蓄力多
    典型配置模式：
      - 连续快速型：ID1(快) → ID2(快) → ID3(快) → ...
      - 渐进加速型：ID1(快) → ID2(中) → ID3(慢) → ...
      - 蓄力型：ID1(快) → ID2(慢) → ID3(蓄力)

    ============================================================================
    工作流程 (Workflow):
    ============================================================================

    初始化阶段 (Initialization Phase):
    ────────────────────────────────────────────────────────────────────
    1. 敌人AI决定使用多段攻击行为
    2. 创建GOAL_EnemyMultiAttack并设置上述7个参数
    3. 调用Activate函数初始化攻击序列

    执行阶段 (Execution Phase):
    ────────────────────────────────────────────────────────────────────
    1. Activate函数提取所有参数
    2. 构建HandyAttack参数包：
       - 目标、第1个攻击ID、攻击2~6的ID
       - 将连击概率传递给前4个攻击位置（对应HandyAttack的概率参数）
    3. 调用AddSubGoal添加HandyAttack子目标
    4. HandyAttack接管并执行整个多段攻击流程

    监控阶段 (Monitoring Phase):
    ────────────────────────────────────────────────────────────────────
    1. Update函数每帧被调用
    2. 检查HandyAttack子目标的执行状态
    3. 当所有子目标完成时，返回Success
    4. 否则返回Continue维持执行状态

    ============================================================================
    参数传递机制详解 (Parameter Passing Mechanism):
    ============================================================================

    从MultiAttack到HandyAttack的参数映射：
    ────────────────────────────────────────────────────────────────────

    MultiAttack参数            →  HandyAttack参数位置        →  含义
    ─────────────────────────────────────────────────────────────────
    目标 (f1_local0)           →  参数1                     → 攻击目标
    0 (固定值)                 →  参数2                     → 链式触发标志（0=否）
    攻击1 (f1_local2)          →  参数3                     → 第1个攻击ID
    攻击2 (f1_local3)          →  参数4                     → 第2个攻击ID
    攻击3 (f1_local4)          →  参数5                     → 第3个攻击ID
    攻击4 (f1_local5)          →  参数6                     → 第4个攻击ID
    攻击5 (f1_local6)          →  参数7                     → 第5个攻击ID
    攻击6 (f1_local7)          →  参数8                     → 第6个攻击ID
    连击概率 (f1_local1)       →  参数9~13（概率1~5）      → 所有连击概率

    关键设计说明：
    - 参数2设为0表示禁用链式连击触发（由HandyAttack内部逻辑处理）
    - 连击概率均匀应用于所有5个概率参数（HandyAttack系统的设计）
    - 这种一一映射确保了参数的精确传递和预期行为

    ============================================================================
    使用场景示例 (Usage Scenarios):
    ============================================================================

    场景1：敌人标准连击攻击
    ────────────────────────────────────────────────────────────────────
    配置：
      - 目标：TARGET_ENE_0（玩家）
      - 连击概率：50（中等威胁）
      - 6个攻击ID：[3001, 3002, 3003, 3004, 0, 0]
    效果：
      - 敌人对玩家进行4段连击
      - 每段之间有50%概率继续连接
      - 给玩家适度的压力，并留有反击机会

    场景2：敌人高压力快速连击
    ────────────────────────────────────────────────────────────────────
    配置：
      - 目标：TARGET_ENE_0
      - 连击概率：75（高威胁）
      - 6个攻击ID：[3001, 3001, 3002, 3002, 3003, 3003]
    效果：
      - 连续多次相同或相似的快速攻击
      - 75%的连击概率使得长连击链可能性大
      - 形成对玩家的高压压制

    场景3：敌人多段蓄力攻击
    ────────────────────────────────────────────────────────────────────
    配置：
      - 目标：TARGET_ENE_0
      - 连击概率：30（低威胁）
      - 6个攻击ID：[3010, 3011, 3012, 0, 0, 0]
    效果：
      - 只有3段攻击，每段蓄力时间较长
      - 低连击概率给玩家更多反击时间
      - 适合体型较大、蓄力式的敌人

    ============================================================================
    技术特点和设计考虑 (Technical Features and Design Considerations):
    ============================================================================

    简洁的设计哲学 (Simplicity Philosophy):
    ────────────────────────────────────────────────────────────────────
    本模块采用"薄包装"设计：
    - Activate：仅提取参数并调用AddSubGoal
    - Update：仅检查子目标状态
    - 所有复杂逻辑均由HandyAttack处理

    优势：
    - 代码简洁，易于理解和维护
    - 避免逻辑重复，降低出错概率
    - 性能开销最小
    - 与HandyAttack的契合度高

    概率模型 (Probability Model):
    ────────────────────────────────────────────────────────────────────
    连击概率的应用方式：
    - MultiAttack设定一个全局概率值
    - HandyAttack接收此概率作为所有连击位置的概率
    - 结果：整个多段攻击链有相同的连接概率

    概率计算示例：
    - 设定概率 P = 60%
    - 期望连击数 = 第1段 + P×1 + P²×1 + ... ≈ 2.5段平均
    - 这为设计者提供了直观的威胁度量化

    执行状态管理 (Execution State Management):
    ────────────────────────────────────────────────────────────────────
    MultiAttack的状态转移：
    ┌─ Activate: 初始化 → 添加HandyAttack子目标 → 就绪
    │
    └─ Update循环:
       ├─ 子目标数 > 0: 返回Continue
       └─ 子目标数 <= 0: 返回Success → 行为完成

    ============================================================================
    与HandyAttack系统的深层关系 (Deep Relationship with HandyAttack System):
    ============================================================================

    HandyAttack的核心职责 (HandyAttack Core Responsibilities):
    ────────────────────────────────────────────────────────────────────
    1. 连击触发管理：
       - 监控每次攻击的命中情况
       - 根据概率决定是否触发下一个攻击
       - 处理连击失败时的特殊行为

    2. 攻击执行协调：
       - 等待前一个攻击完成
       - 启动下一个攻击阶段
       - 管理攻击之间的间隔时间

    3. 状态和参数维护：
       - 跟踪当前执行的攻击阶段
       - 维护链式连接的各类信息
       - 提供子目标完成信息

    MultiAttack的角色 (MultiAttack's Role):
    ────────────────────────────────────────────────────────────────────
    1. 高层决策：
       - 决定使用多段攻击而非单次攻击
       - 选择攻击动画和连击概率
       - 设定目标对象

    2. 参数组织：
       - 将高层战术参数转化为HandyAttack格式
       - 确保参数的正确映射和传递
       - 维持参数的一致性

    3. 生命周期管理：
       - Activate时创建HandyAttack
       - Update时监控执行进度
       - 在适当时刻返回成功或继续

    ============================================================================
    平衡性和性能考虑 (Balance and Performance Considerations):
    ============================================================================

    平衡设计 (Balance Design):
    ────────────────────────────────────────────────────────────────────
    - 参数2固定为0：确保不启用特殊链式模式，使用标准连击逻辑
    - 概率参数都相同：简化概率管理，便于玩家理解敌人威胁度
    - 最多6段攻击：防止攻击链过长导致玩家无法反击

    性能优化 (Performance Optimization):
    ────────────────────────────────────────────────────────────────────
    - 轻量级状态：MultiAttack本身不维护复杂状态
    - 委托执行：所有复杂计算由HandyAttack负责
    - 简洁的Update函数：只进行基本的子目标检查
    - 避免重复：不重新实现已有的HandyAttack逻辑

    ============================================================================
    扩展和修改指南 (Extension and Modification Guidelines):
    ============================================================================

    可能的改进方向 (Possible Improvements):
    ────────────────────────────────────────────────────────────────────
    1. 动态概率：
       - 根据玩家防守/血量调整概率
       - 实现自适应难度的多段攻击

    2. 分段概率：
       - 为不同攻击位置设置不同概率
       - 例如：前期易连（70%），后期难连（30%）

    3. 高级策略：
       - 根据环境改变攻击选择
       - 实现AI学习和适应机制

    ============================================================================
]]--

-- 注册多段攻击行为的调试参数 (Register debug parameters for multi-attack behavior)
RegisterTableGoal(GOAL_EnemyMultiAttack, "GOAL_EnemyMultiAttack")
-- 启用连击取消功能 (Enable combo attack cancellation)
ENABLE_COMBO_ATK_CANCEL(GOAL_EnemyMultiAttack)
-- 标记此目标无子目标要求 (Mark this goal as having no sub-goal requirement)
REGISTER_GOAL_NO_SUB_GOAL(GOAL_EnemyMultiAttack, true)
-- 注册攻击目标调试参数 (Register attack target debug parameter)
REGISTER_DBG_GOAL_PARAM(GOAL_EnemyMultiAttack, 0, "対象", 0)
-- 注册连击概率调试参数 (Register combo probability debug parameter)
REGISTER_DBG_GOAL_PARAM(GOAL_EnemyMultiAttack, 1, "コンボ確率", 0)
-- 注册第1个攻击ID调试参数 (Register 1st attack ID debug parameter)
REGISTER_DBG_GOAL_PARAM(GOAL_EnemyMultiAttack, 2, "攻撃1", 0)
-- 注册第2个攻击ID调试参数 (Register 2nd attack ID debug parameter)
REGISTER_DBG_GOAL_PARAM(GOAL_EnemyMultiAttack, 3, "攻撃2", 0)
-- 注册第3个攻击ID调试参数 (Register 3rd attack ID debug parameter)
REGISTER_DBG_GOAL_PARAM(GOAL_EnemyMultiAttack, 4, "攻撃3", 0)
-- 注册第4个攻击ID调试参数 (Register 4th attack ID debug parameter)
REGISTER_DBG_GOAL_PARAM(GOAL_EnemyMultiAttack, 5, "攻撃4", 0)
-- 注册第5个攻击ID调试参数 (Register 5th attack ID debug parameter)
REGISTER_DBG_GOAL_PARAM(GOAL_EnemyMultiAttack, 6, "攻撃5", 0)
-- 注册第6个攻击ID调试参数 (Register 6th attack ID debug parameter)
REGISTER_DBG_GOAL_PARAM(GOAL_EnemyMultiAttack, 7, "攻撃6", 0)

--[[============================================================================
    多段攻击激活函数 (Multi-Attack Activation Function)
    ============================================================================

    功能说明 (Function Description):
    ────────────────────────────────────────────────────────────────────
    这是多段攻击系统的核心入口函数，负责组织和启动一个完整的多段连击序列。
    它从目标对象中提取高层战术参数（目标、攻击序列、连击概率），然后
    构建适配HandyAttack系统的参数包，并通过AddSubGoal将整个多段攻击任务
    委托给HandyAttack执行。该函数是高层战术决策与低层具体执行之间的关键
    接口。

    参数说明 (Parameters):
    ────────────────────────────────────────────────────────────────────
    f1_arg0: AI角色对象 (AI character object)
             - 执行多段攻击的AI实体
             - 包含所有角色属性和状态信息

    f1_arg1: 目标对象/行为对象 (Goal object)
             - 当前GOAL_EnemyMultiAttack行为的实例
             - 通过GetParam方法获取配置参数
             - 通过AddSubGoal方法添加子目标
             - 通过GetLife方法获取行为生命周期

    返回值 (Return Value):
    ────────────────────────────────────────────────────────────────────
    无返回值 (No return value)
    - 通过AddSubGoal的副作用实现行为激活
    - 系统将自动调用后续的Update函数监控执行进度
]]--
Goal.Activate = function (f1_arg0, f1_arg1, f1_arg2)
    -- === 第一步：参数提取阶段 (Parameter Extraction Phase) ===
    -- 从行为参数中提取高层战术参数

    -- 提取攻击目标 (Extract attack target)
    -- 这是整个多段攻击序列共同针对的目标
    local f1_local0 = f1_arg2:GetParam(0)

    -- 提取连击概率 (Extract combo probability)
    -- 决定了整个多段攻击链的形成倾向
    -- 值范围：0~100，表示百分比
    local f1_local1 = f1_arg2:GetParam(1)

    -- === 第二步：攻击序列提取阶段 (Attack Sequence Extraction Phase) ===
    -- 依次提取6个攻击动画ID

    -- 提取第1个攻击ID (Extract 1st attack ID)
    local f1_local2 = f1_arg2:GetParam(2)

    -- 提取第2个攻击ID (Extract 2nd attack ID)
    local f1_local3 = f1_arg2:GetParam(3)

    -- 提取第3个攻击ID (Extract 3rd attack ID)
    local f1_local4 = f1_arg2:GetParam(4)

    -- 提取第4个攻击ID (Extract 4th attack ID)
    local f1_local5 = f1_arg2:GetParam(5)

    -- 提取第5个攻击ID (Extract 5th attack ID)
    local f1_local6 = f1_arg2:GetParam(6)

    -- 提取第6个攻击ID (Extract 6th attack ID)
    local f1_local7 = f1_arg2:GetParam(7)

    -- === 第三步：HandyAttack委托执行 (Delegate to HandyAttack Execution) ===
    -- 参数映射说明：
    -- f1_arg2:GetLife()       → 行为生命周期 (Behavior life cycle)
    -- f1_local0              → 目标对象 (Attack target)
    -- 0                      → 链式触发标志：0表示不启用特殊链式模式
    --                          (Chain trigger flag: 0 means no special chain mode)
    -- f1_local2~7            → 6个攻击ID按顺序传递 (6 attack IDs passed in order)
    -- f1_local1 (重复5次)    → 连击概率参数，对应HandyAttack的参数9-13
    --                          (Combo probability parameters, corresponding to HandyAttack parameters 9-13)

    -- 调用AddSubGoal添加HandyAttack子目标，执行多段攻击
    -- AddSubGoal(目标类型, 生命周期, 参数1, 参数2, 参数3, 参数4, 参数5, 参数6, 参数7, 参数8, 参数9, 参数10, 参数11, 参数12, 参数13)
    f1_arg2:AddSubGoal(GOAL_EnemyHandyAttack,
                       f1_arg2:GetLife(),        -- 行为生命周期 (Behavior life cycle)
                       f1_local0,                -- 目标 (Target)
                       0,                        -- 链式标志=0（禁用特殊链式） (Chain flag=0, disable special chain)
                       f1_local2,                -- 攻击1 (Attack 1)
                       f1_local3,                -- 攻击2 (Attack 2)
                       f1_local4,                -- 攻击3 (Attack 3)
                       f1_local5,                -- 攻击4 (Attack 4)
                       f1_local6,                -- 攻击5 (Attack 5)
                       f1_local7,                -- 攻击6 (Attack 6)
                       f1_local1,                -- 概率1 (Probability 1)
                       f1_local1,                -- 概率2 (Probability 2)
                       f1_local1,                -- 概率3 (Probability 3)
                       f1_local1,                -- 概率4 (Probability 4)
                       f1_local1)                -- 概率5 (Probability 5)
    -- ★ 关键设计点：所有概率值都相同 (f1_local1)
    --    这确保了整个多段攻击链具有统一的连击概率
    --    (All probability values are identical, ensuring uniform combo probability for the entire chain)

end

--[[============================================================================
    多段攻击状态更新函数 (Multi-Attack State Update Function)
    ============================================================================

    功能说明 (Function Description):
    ────────────────────────────────────────────────────────────────────
    这是多段攻击系统的执行监控函数，每帧被调用以监测HandyAttack子目标的
    执行进度。它维持一个简单的状态检查流程：只要HandyAttack子目标还在
    执行（GetSubGoalNum() > 0），就继续返回Continue；当所有子目标完成时
    （GetSubGoalNum() <= 0），返回Success表示多段攻击完成。

    参数说明 (Parameters):
    ────────────────────────────────────────────────────────────────────
    f2_arg0: AI角色对象 (AI character object)
             - 执行多段攻击的AI实体

    f2_arg1: 行为对象 (Goal object)
             - 当前GOAL_EnemyMultiAttack行为的实例
             - 通过GetSubGoalNum获取当前子目标数量

    f2_arg2: 额外参数 (Extra parameter)
             - 当前未使用 (Currently unused)

    返回值 (Return Value):
    ────────────────────────────────────────────────────────────────────
    GOAL_RESULT_Success: 多段攻击完成，返回成功
                        (Multi-attack completed, return success)
    GOAL_RESULT_Continue: 多段攻击还在进行中，继续监控
                         (Multi-attack still in progress, continue monitoring)
]]--
Goal.Update = function (f2_arg0, f2_arg1, f2_arg2)
    -- === 状态检查阶段 (State Check Phase) ===
    -- 检查HandyAttack子目标的执行状态

    -- 获取当前子目标的数量 (Get the number of current sub-goals)
    -- GetSubGoalNum() 返回当前激活的子目标数量
    -- 包括HandyAttack本身及其可能的子目标
    if f2_arg2:GetSubGoalNum() <= 0 then
        -- 子目标数 <= 0：所有子目标已完成
        -- (Sub-goal count <= 0: all sub-goals have completed)
        return GOAL_RESULT_Success
        -- 返回成功，表示多段攻击行为完成
        -- (Return success, indicating multi-attack behavior completion)
    end

    -- === 继续监控阶段 (Continue Monitoring Phase) ===
    -- 子目标数 > 0：HandyAttack还在执行
    -- (Sub-goal count > 0: HandyAttack is still executing)
    return GOAL_RESULT_Continue
    -- 返回继续，保持对HandyAttack的监控
    -- (Return continue, maintain monitoring of HandyAttack)

end


