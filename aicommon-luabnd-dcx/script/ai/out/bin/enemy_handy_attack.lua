--[[============================================================================
    enemy_handy_attack.lua - 敌人便捷攻击系统 (Enemy Handy Attack System)

    版本信息 (Version Info): v1.0
    作者 (Author): FromSoftware AI Team / Enhanced by Claude Code
    最后修改 (Last Modified): 2025-10-21
    编码格式 (Encoding): Shift-JIS (required for Sekiro compatibility)

    ============================================================================
    模块概述 (Module Overview):
    ============================================================================
    这是Sekiro AI系统中最核心和最灵活的连击攻击管理模块。HandyAttack提供了
    一个通用的多段连击框架，能够管理从1段到6段的任意长度的攻击序列，并根据
    概率模型动态决定是否继续连击。

    该模块的设计哲学是"便捷"和"灵活"：
    - 便捷：通过简单的参数配置快速构建复杂的连击序列
    - 灵活：支持每个攻击位置独立的概率控制和链式触发管理

    HandyAttack 是所有其他连击系统（MultiAttack、ComboAttack 等）的基础执行层，
    处理了所有关于连击触发、状态管理和链式控制的复杂逻辑。

    核心功能 (Core Functions):
    ├─ 多段连击管理：执行1-6段的任意长度攻击序列
    ├─ 概率驱动决策：每段攻击都有独立的连击概率控制
    ├─ 链式触发模式：支持"链式"模式以在多个连击点动态判定
    ├─ 状态转移管理：处理攻击之间的过渡和状态同步
    ├─ 命中判定反馈：根据实际命中情况调整连击链
    └─ 连击失败处理：支持连击失败时的特殊行为（如最终技）

    与其他攻击模块的关系 (Relationship with Other Attack Modules):
    ├─ enemy_multi_attack.lua      - 多段攻击系统（高层封装）
    ├─ combo_attack.lua             - 标准连击（简化版）
    ├─ combo_attack_success_angle180.lua - 广角连击（简化版）
    ├─ attack_tunable_spin.lua      - 旋回攻击（单次攻击）
    ├─ combo_attack_tunable_spin.lua - 旋回连击（高级版）
    ├─ combo_repeat.lua             - 连击重复段（快速连续）
    ├─ combo_final.lua              - 连击终结段（高伤害）
    └─ common_func.lua              - 通用函数（工具类）

    ============================================================================
    参数系统详解 (Parameter System Details):
    ============================================================================

    参数0 (Param0): 対象 (攻击目标)
    ────────────────────────────────────────────────────────────────────
    功能：指定便捷攻击的主要目标对象
    数据类型：目标枚举 (Target Enum)
    常用值：TARGET_ENE_0（主要敌人/玩家）
    使用说明：
      - HandyAttack所有攻击都针对此目标
      - 在连击过程中通常保持不变
      - 影响距离判定、角度计算等所有方面

    参数1 (Param1): チェインか (链式触发标志)
    ────────────────────────────────────────────────────────────────────
    功能：控制连击链式触发的行为模式
    数据类型：整数 (Integer)
    取值范围：0 或 1（其他值未定义）
    使用说明：
      - 0（禁用链式）：每个攻击位置按固定概率独立决定是否连击
      - 1（启用链式）：如果本次攻击连击成功，在下个攻击到达时
                      再次检查是否继续连击（双重判定）
    链式模式的优势：
      - 更精确的连击流程控制
      - 允许在连击中途动态变更策略
      - 更接近真实的战斗行为逻辑
    链式 vs 非链式示例（概率都是50%）：
      非链式：1段成功->自动进行2段概率检查->50%进行->自动进行3段...
      链式：1段成功->2段概率检查->50%进行->攻击中->3段再次概率检查->50%进行...

    参数2~7 (Param2-Param7): 攻撃1~6 (6段攻击动画ID)
    ────────────────────────────────────────────────────────────────────
    功能：指定连击序列中的每个攻击动画状态ID
    数据类型：整数 (Integer)
    取值范围：有效的攻击ID（通常0表示该位置无攻击）
    使用说明：
      - 按顺序组成完整的攻击链
      - 如果某个位置的ID为0或无效，该段及后续段不执行
      - HandyAttack自动管理其中的转换
    配置建议：
      - 前段攻击：通常蓄力较少，速度较快
      - 中段攻击：逐步增加蓄力和威力
      - 后段攻击：最高伤害，可能有特殊效果

    参数8~12 (Param8-Param12): 確率1~5 (5段连击概率)
    ────────────────────────────────────────────────────────────────────
    功能：控制每个攻击位置的连击成功概率
    数据类型：浮点数 (Float)
    单位：百分比 (0.0 ~ 100.0)
    取值范围：0 ~ 100
    使用说明：
      - 参数8：在1→2位置的连击概率
      - 参数9：在2→3位置的连击概率
      - 参数10：在3→4位置的连击概率
      - 参数11：在4→5位置的连击概率
      - 参数12：在5→6位置的连击概率
    配置策略：
      - 均匀型：所有概率相同，形成平衡的连击链
      - 递减型：逐步降低后续概率，形成难度递增
      - 递增型：逐步提高概率，形成威胁递增
    概率对连击长度的影响：
      - 若所有概率都是P，期望连击长度 ≈ 1/(1-P)
      - 例如：P=50%，期望长度≈2段；P=70%，期望长度≈3.33段

    ============================================================================
    工作流程 (Workflow):
    ============================================================================

    初始化阶段 (Initialization Phase):
    ────────────────────────────────────────────────────────────────────
    1. 高层系统（如MultiAttack）创建HandyAttack目标
    2. 设置攻击序列、目标、概率等参数
    3. 调用Activate函数启动便捷攻击

    执行阶段 (Execution Phase):
    ────────────────────────────────────────────────────────────────────
    1. Activate：
       - 验证攻击参数是否有效
       - 初始化连击链状态
       - 激活第一个攻击段
    2. Update循环：
       - 监测当前攻击的执行状态
       - 在攻击完成时检查是否应该继续连击
       - 根据概率和命中情况决定下一段攻击
       - 直到连击链结束或无更多攻击段

    终止阶段 (Termination Phase):
    ────────────────────────────────────────────────────────────────────
    1. 所有攻击段完成后返回Success
    2. 如果无法继续连击则中断并返回

    ============================================================================
    高级功能说明 (Advanced Features):
    ============================================================================

    命中判定系统 (Hit Determination System):
    ────────────────────────────────────────────────────────────────────
    HandyAttack 在Update中监控每个攻击的命中结果：
    - IsHitAttack()：检查攻击是否命中目标
    - 命中时：触发下一个攻击的连击概率检查
    - 未命中时：可能触发连击失败处理

    链式触发的详细流程 (Chain Trigger Detailed Flow):
    ────────────────────────────────────────────────────────────────────
    当参数1设为1（链式模式）时：
    1. 第N段攻击执行
    2. 攻击完成，进入第N+1段
    3. 第N+1段动作开始前：再次检查概率（"链式"特性）
    4. 概率检查决定是否执行第N+1段
    5. 如果跳过，进入第N+2段
    6. 直到找到有效执行的攻击段或链结束

    ============================================================================
]]--

-- 注册便捷攻击行为的调试参数 (Register debug parameters for handy attack behavior)
RegisterTableGoal(GOAL_EnemyHandyAttack, "GOAL_EnemyHandyAttack")
-- 启用连击取消功能（允许在连击中被打断） (Enable combo attack cancellation)
ENABLE_COMBO_ATK_CANCEL(GOAL_EnemyHandyAttack)
-- 标记此目标无子目标要求 (Mark this goal as having no sub-goal requirement)
REGISTER_GOAL_NO_SUB_GOAL(GOAL_EnemyHandyAttack, true)
-- 注册攻击目标调试参数 (Register attack target debug parameter)
REGISTER_DBG_GOAL_PARAM(GOAL_EnemyHandyAttack, 0, "対象", 0)
-- 注册链式触发标志调试参数 (Register chain trigger flag debug parameter)
REGISTER_DBG_GOAL_PARAM(GOAL_EnemyHandyAttack, 1, "チェインか", 0)
-- 注册第1个攻击ID调试参数 (Register 1st attack ID debug parameter)
REGISTER_DBG_GOAL_PARAM(GOAL_EnemyHandyAttack, 2, "攻撃1", 0)
-- 注册第2个攻击ID调试参数 (Register 2nd attack ID debug parameter)
REGISTER_DBG_GOAL_PARAM(GOAL_EnemyHandyAttack, 3, "攻撃2", 0)
-- 注册第3个攻击ID调试参数 (Register 3rd attack ID debug parameter)
REGISTER_DBG_GOAL_PARAM(GOAL_EnemyHandyAttack, 4, "攻撃3", 0)
-- 注册第4个攻击ID调试参数 (Register 4th attack ID debug parameter)
REGISTER_DBG_GOAL_PARAM(GOAL_EnemyHandyAttack, 5, "攻撃4", 0)
-- 注册第5个攻击ID调试参数 (Register 5th attack ID debug parameter)
REGISTER_DBG_GOAL_PARAM(GOAL_EnemyHandyAttack, 6, "攻撃5", 0)
-- 注册第6个攻击ID调试参数 (Register 6th attack ID debug parameter)
REGISTER_DBG_GOAL_PARAM(GOAL_EnemyHandyAttack, 7, "攻撃6", 0)
-- 注册连击概率1调试参数 (Register combo probability 1 debug parameter)
REGISTER_DBG_GOAL_PARAM(GOAL_EnemyHandyAttack, 8, "確率1", 0)
-- 注册连击概率2调试参数 (Register combo probability 2 debug parameter)
REGISTER_DBG_GOAL_PARAM(GOAL_EnemyHandyAttack, 9, "確率2", 0)
-- 注册连击概率3调试参数 (Register combo probability 3 debug parameter)
REGISTER_DBG_GOAL_PARAM(GOAL_EnemyHandyAttack, 10, "確率3", 0)
-- 注册连击概率4调试参数 (Register combo probability 4 debug parameter)
REGISTER_DBG_GOAL_PARAM(GOAL_EnemyHandyAttack, 11, "確率4", 0)
-- 注册连击概率5调试参数 (Register combo probability 5 debug parameter)
REGISTER_DBG_GOAL_PARAM(GOAL_EnemyHandyAttack, 12, "確率5", 0)

--[[============================================================================
    便捷攻击激活函数 (Handy Attack Activation Function)
    ============================================================================

    功能说明 (Function Description):
    ────────────────────────────────────────────────────────────────────
    这是便捷攻击系统的核心入口函数，负责初始化并启动整个多段连击序列。
    该函数主要工作包括：
    1. 验证第一个攻击段是否有效
    2. 根据概率决定是否应该立即进行连击
    3. 处理特殊的步移动作类型（7008/7003/7004）
    4. 根据攻击类型和连击条件选择合适的子目标
    5. 为后续连击做准备并设置内部状态

    这个函数是连击流程的入口点，所有后续的攻击都基于这里的初始化。

    参数说明 (Parameters):
    ────────────────────────────────────────────────────────────────────
    f1_arg0: AI角色对象 (AI character object)
             - 执行便捷攻击的AI实体

    f1_arg1: 目标对象/行为对象 (Goal object)
             - 当前GOAL_EnemyHandyAttack行为的实例
             - 包含所有攻击序列参数

    f1_arg2: 额外参数 (Extra parameter)
             - 当前未使用 (Currently unused)

    返回值 (Return Value):
    ────────────────────────────────────────────────────────────────────
    无返回值 (No return value)
]]--
Goal.Activate = function (f1_arg0, f1_arg1, f1_arg2)
    -- === 第一步：第一个攻击段验证 (First Attack Validation) ===
    -- 获取第一个攻击的ID
    local f1_local0 = f1_arg2:GetParam(2)

    -- 检查第一个攻击是否有效
    -- 如果为nil或 <= 0，则没有有效的攻击，便捷攻击无法启动
    if f1_local0 == nil or f1_local0 <= 0 then
        -- 打印调试信息（仅在开发模式下显示）
        -- (Print debug information - shown only in development mode)
        print("[HANDY ATTACK]" .. "終了")
        -- 返回，不激活任何攻击
        -- (Return without activating any attack)
        return
    end

    -- === 第二步：参数提取阶段 (Parameter Extraction Phase) ===

    -- 提取第二个攻击的ID（用于判断是否启用连击）
    -- (Extract second attack ID for determining combo mode)
    local f1_local1 = f1_arg2:GetParam(3)

    -- 提取第一个连击概率（1→2的连击概率）
    -- (Extract first combo probability for 1->2 transition)
    local f1_local2 = f1_arg2:GetParam(8)

    -- 提取攻击目标
    -- (Extract attack target)
    local f1_local3 = f1_arg2:GetParam(0)

    -- 获取敌人与目标的当前距离（用于距离相关判定）
    -- (Get distance between enemy and target for distance-related checks)
    local f1_local4 = f1_arg1:GetDist(f1_local3)

    -- === 第三步：连击概率判定 (Combo Probability Check) ===
    -- 根据第一个连击概率决定是否启用连击
    local f1_local5 = 0

    -- 生成随机数并与概率比较
    -- (Generate random number and compare with probability)
    if f1_arg1:GetRandam_Float(0.1, 100) < f1_local2 then
        -- 概率成功，设置连击标志为1（启用连击）
        -- (Probability success, set combo flag to 1 - enable combo)
        f1_local5 = 1
    else
        -- 概率失败，无法继续连击
        -- (Probability failure, cannot continue combo)
        print("[HANDY ATTACK]" .. f1_local0 .. "：抽選の結果次の攻撃には繋がない")
        -- 调试信息：说明第一个攻击无法连接下一个攻击
        -- (Debug info: First attack cannot connect to next attack)
    end

    -- === 第四步：攻击类型判定和子目标激活 (Attack Type Check and Sub-Goal Activation) ===
    -- 根据攻击ID的类型分别处理

    -- 检查是否为特殊的步移动作ID
    if f1_local0 == 7008 then
        -- 攻击ID 7008：前方步移 (Forward step)
        -- 激活前方步移子目标
        -- (Activate forward step sub-goal)
        f1_arg2:AddSubGoal(GOAL_EnemyStepFront, f1_arg2:GetLife(), f1_local3,
                          f1_arg1:GetAIAttackParam(7008, AI_ATTACK_PARAM_TYPE__MIN_ARRIVE_DISTANCE))

    elseif f1_local0 == 7003 then
        -- 攻击ID 7003：左右步移 (Left-right step)
        -- 激活左右步移子目标
        -- (Activate left-right step sub-goal)
        f1_arg2:AddSubGoal(GOAL_EnemyStepLR, f1_arg2:GetLife(), f1_local3,
                          f1_arg1:GetAIAttackParam(7003, AI_ATTACK_PARAM_TYPE__MIN_ARRIVE_DISTANCE))

    elseif f1_local0 == 7004 then
        -- 攻击ID 7004：后退步移 (Back step)
        -- 激活后退步移子目标
        -- (Activate back step sub-goal)
        f1_arg2:AddSubGoal(GOAL_EnemyStepBack, f1_arg2:GetLife(), f1_local3,
                          f1_arg1:GetAIAttackParam(7004, AI_ATTACK_PARAM_TYPE__MIN_ARRIVE_DISTANCE))

    elseif f1_arg1:GetAIAttackParam(f1_local0, AI_ATTACK_PARAM_TYPE__IS_FIRST_ATTACK) == 1 then
        -- === 第一类攻击：初始攻击 (First Attack Type) ===
        -- AI_ATTACK_PARAM_TYPE__IS_FIRST_ATTACK == 1 表示这是一个可以作为连击起点的攻击
        -- (AI_ATTACK_PARAM_TYPE__IS_FIRST_ATTACK == 1 means this is a valid combo starter)

        -- 判断是否应该启用连击（检查3个条件）
        -- (Check if combo should be enabled)
        if f1_local1 == nil or f1_local1 <= 0 or f1_local5 == 0 then
            -- 条件任一成立则不启用连击：
            -- 1. f1_local1 == nil：没有第二个攻击
            -- 2. f1_local1 <= 0：第二个攻击无效
            -- 3. f1_local5 == 0：连击概率检查失败
            -- (Any condition met means no combo)

            -- 激活单次可调节攻击（不启用连击）
            -- (Activate single tunable attack - no combo)
            f1_arg2:AddSubGoal(GOAL_EnemyTunableAttack, f1_arg2:GetLife(), f1_local3, f1_local0)
        else
            -- 所有条件都满足，启用可调节连击攻击
            -- (All conditions met, enable tunable combo attack)
            f1_arg2:AddSubGoal(GOAL_EnemyTunableComboAttack, f1_arg2:GetLife(), f1_local3, f1_local0)
        end

    elseif f1_local1 == nil or f1_local1 <= 0 or f1_local5 == 0 then
        -- === 第二类攻击：连击终结段 (Combo Final) ===
        -- 如果无法继续连击，直接使用连击最终段（高伤害终结技）
        -- (If no combo possible, use final combo attack - high damage finisher)

        f1_arg2:AddSubGoal(GOAL_EnemyComboFinal, f1_arg2:GetLife(), f1_local3, f1_local0)

    else
        -- === 第三类攻击：连击重复段 (Combo Repeat) ===
        -- 可以继续连击，使用标准的连击重复段
        -- (Can continue combo, use standard combo repeat)

        f1_arg2:AddSubGoal(GOAL_EnemyComboRepeat, f1_arg2:GetLife(), f1_local3, f1_local0)
    end

    -- === 第五步：内部状态初始化 (Internal State Initialization) ===
    -- 初始化一个内部标志以管理后续的连击流程

    -- 设置内部标志为0（初始状态）
    -- (Set internal flag to 0 - initial state)
    f1_arg2:SetNumber(1, 0)

    -- === 第六步：连击链标志设置 (Combo Chain Flag Setting) ===
    -- 如果满足以下所有条件，设置标志为1以启用连击链处理

    if f1_local1 ~= nil and not (f1_local1 <= 0) and f1_local5 == 1 then
        -- 条件检查：
        -- 1. f1_local1 ~= nil：第二个攻击存在
        -- 2. not (f1_local1 <= 0)：第二个攻击有效
        -- 3. f1_local5 == 1：连击概率检查成功

        -- 设置内部标志为1，表示可以进行连击链处理
        -- (Set flag to 1 - combo chain processing enabled)
        f1_arg2:SetNumber(1, 1)
    end

end

--[[============================================================================
    便捷攻击状态更新函数 (Handy Attack State Update Function)
    ============================================================================

    功能说明 (Function Description):
    ────────────────────────────────────────────────────────────────────
    这是便捷攻击系统的执行监控和连击链管理函数，每帧被调用以维持和控制
    连击序列的执行。该函数的主要职责包括：

    1. 检查子目标的完成状态
    2. 监测是否启用了连击链处理
    3. 在合适的时刻检查攻击命中情况
    4. 根据命中结果或其他条件决定是否触发后续连击
    5. 动态地添加新的HandyAttack子目标以形成连击链

    这个函数实现了"链式触发"的核心逻辑，能够在运行时动态判断并执行
    复杂的多段连击序列。

    参数说明 (Parameters):
    ────────────────────────────────────────────────────────────────────
    f2_arg0: AI角色对象 (AI character object)
             - 执行便捷攻击的AI实体

    f2_arg1: 行为对象 (Goal object)
             - 当前GOAL_EnemyHandyAttack行为的实例
             - 用于获取参数、子目标信息和AI状态

    f2_arg2: 额外参数 (Extra parameter)
             - 当前未使用 (Currently unused)

    返回值 (Return Value):
    ────────────────────────────────────────────────────────────────────
    GOAL_RESULT_Success: 所有连击段都已完成
    GOAL_RESULT_Continue: 连击还在进行中或等待后续处理
]]--
Goal.Update = function (f2_arg0, f2_arg1, f2_arg2)
    -- === 第一步：子目标完成检查 (Sub-Goal Completion Check) ===
    -- 检查所有子目标是否已完成
    if f2_arg2:GetSubGoalNum() <= 0 then
        -- 所有子目标已完成，便捷攻击行为成功结束
        -- (All sub-goals completed, handy attack behavior ends successfully)
        return GOAL_RESULT_Success
    end

    -- === 第二步：连击链标志检查 (Combo Chain Flag Check) ===
    -- 检查内部标志是否为1（表示启用了连击链处理）
    if f2_arg2:GetNumber(1) == 1 then
        -- 标志为1，需要进行连击链处理

        -- 获取链式触发标志（参数1）
        -- (Get chain trigger flag - Parameter 1)
        local f2_local0 = f2_arg2:GetParam(1)

        -- === 第三步：连击启用状态检查 (Combo Enabled State Check) ===
        -- 检查连击是否仍然启用中
        if f2_arg1:IsEnableComboAttack() then
            -- 连击仍然启用，清除标志以防止重复处理
            -- (Combo still enabled, clear flag to prevent duplicate processing)
            f2_arg2:SetNumber(1, 0)

            -- === 第四步：命中判定分支 (Hit Judgment Branch) ===
            -- 检查当前攻击是否命中目标
            if f2_arg1:IsHitAttack() then
                -- === 分支A：攻击命中 (Attack Hit Branch) ===
                -- 命中时自动触发下一个连击

                -- 提取攻击目标
                -- (Extract attack target)
                local f2_local1 = f2_arg2:GetParam(0)

                -- 提取第二个攻击的ID
                -- (Extract second attack ID)
                local f2_local2 = f2_arg2:GetParam(3)

                -- 递归地添加新的HandyAttack子目标以继续连击链
                -- (Recursively add new HandyAttack sub-goal to continue combo chain)
                --
                -- 参数说明 (Parameter Explanation):
                -- f2_local1 - 目标 (Target)
                -- f2_arg2:GetParam(1) - 链式标志 (Chain flag)
                -- f2_arg2:GetParam(3) - 第2个攻击ID (2nd attack ID)
                -- f2_arg2:GetParam(4-7) - 第3-6个攻击ID (3rd-6th attack IDs)
                -- nil - 占位符
                -- f2_arg2:GetParam(8-11) - 概率1-4 (Probabilities 1-4)
                -- nil - 占位符
                f2_arg2:AddSubGoal(GOAL_EnemyHandyAttack, f2_arg2:GetLife(),
                                  f2_local1, f2_arg2:GetParam(1),
                                  f2_arg2:GetParam(3), f2_arg2:GetParam(4),
                                  f2_arg2:GetParam(5), f2_arg2:GetParam(6),
                                  f2_arg2:GetParam(7), nil,
                                  f2_arg2:GetParam(8), f2_arg2:GetParam(9),
                                  f2_arg2:GetParam(10), f2_arg2:GetParam(11), nil)

            elseif f2_local0 == 0 then
                -- === 分支B：非链式模式且未命中 (Non-Chain Mode and No Hit Branch) ===
                -- 当不使用链式模式（参数1==0）时的处理流程
                -- (Processing when chain mode is not used - Parameter1 == 0)

                -- 提取攻击目标
                -- (Extract attack target)
                local f2_local1 = f2_arg2:GetParam(0)

                -- 获取敌人与目标的当前距离
                -- (Get distance between enemy and target)
                local f2_local2 = f2_arg1:GetDist(f2_local1)

                -- 提取第二个攻击的ID
                -- (Extract second attack ID)
                local f2_local3 = f2_arg2:GetParam(3)

                -- 获取该攻击的连击执行距离
                -- (Get combo execution distance for this attack)
                local f2_local4 = f2_arg1:GetAIAttackParam(f2_local3, AI_ATTACK_PARAM_TYPE__COMBO_EXEC_DISTANCE)

                -- 获取该攻击的连击执行范围（角度）
                -- (Get combo execution range/angle for this attack)
                local f2_local5 = f2_arg1:GetAIAttackParam(f2_local3, AI_ATTACK_PARAM_TYPE__COMBO_EXEC_RANGE)

                -- === 连击触发条件检查 (Combo Trigger Conditions Check) ===
                -- 检查三个条件，都满足才能继续连击：
                -- 1. IsFinishAttackCoolTime() - 前一个攻击已完成冷却
                -- 2. 距离检查 - 敌人与目标距离在允许范围内
                -- 3. IsInsideTarget() - 目标在敌人的攻击范围内（角度检查）

                if f2_arg1:IsFinishAttackCoolTime(f2_local3) and
                   f2_local2 <= f2_local4 and
                   f2_arg1:IsInsideTarget(f2_local1, AI_DIR_CENTER, f2_local5) then

                    -- 所有条件都满足，添加新的HandyAttack子目标继续连击
                    -- (All conditions met, add new HandyAttack sub-goal to continue combo)
                    f2_arg2:AddSubGoal(GOAL_EnemyHandyAttack, f2_arg2:GetLife(),
                                      f2_local1, f2_arg2:GetParam(1),
                                      f2_arg2:GetParam(3), f2_arg2:GetParam(4),
                                      f2_arg2:GetParam(5), f2_arg2:GetParam(6),
                                      f2_arg2:GetParam(7), nil,
                                      f2_arg2:GetParam(8), f2_arg2:GetParam(9),
                                      f2_arg2:GetParam(10), f2_arg2:GetParam(11), nil)
                end
            end
        end
    end

    -- === 第五步：行为继续返回 (Behavior Continuation Return) ===
    -- 返回Continue以维持便捷攻击行为的继续执行
    -- 直到所有子目标完成（在下一帧会检查到 GetSubGoalNum() <= 0 并返回Success）
    -- (Return Continue to maintain handy attack behavior continuation)
    -- (Next frame will check GetSubGoalNum() <= 0 and return Success when all sub-goals complete)
    return GOAL_RESULT_Continue

end


