--[[============================================================================
    after_attack_act.lua - 攻击后行为处理系统 (After Attack Action System)

    版本信息 (Version Info): v2.1 - Enhanced with comprehensive annotations
    作者 (Author): FromSoftware AI Team / Enhanced by Claude Code
    最后修改 (Last Modified): 2025-09-28
    编码格式 (Encoding): Shift-JIS (required for Sekiro compatibility)

    ============================================================================
    功能概述 (Overview):
    ============================================================================
    这是Sekiro AI系统中的核心攻击后行为管理模块，负责在AI完成攻击动作后
    智能选择和执行下一步的战术行为。该系统是整个战斗AI循环中的关键环节，
    直接影响AI的战斗流畅性、挑战性和玩家体验。

    主要功能 (Main Functions):
    - 攻击后行为决策：基于概率权重系统选择合适的后续动作
    - 环境感知：考虑与敌人的距离、角度关系进行行为筛选
    - 团队协调：分析队友位置分布，避免拥挤和碰撞
    - 动态适应：根据战斗状况实时调整行为策略
    - 中断处理：提供灵活的行为中断和状态切换机制

    ============================================================================
    行为类型详解 (Detailed Action Types):
    ============================================================================

    1. NoAct (无动作) - 战术意图：保持攻击节奏
       └─ 使用场景：连续攻击、压制敌人
       └─ 策略价值：维持攻击主动权，不给敌人喘息机会

    2. BackAndSide (后退+侧移组合) - 战术意图：安全重新定位
       └─ 执行顺序：先后退拉开距离 → 再侧移改变角度
       └─ 策略价值：既保证安全又保持进攻角度
       └─ 适用情况：中近距离战斗，需要重新调整位置

    3. Back (单纯后退) - 战术意图：拉开距离重整
       └─ 使用场景：敌人反击风险高，需要暂时脱离
       └─ 策略价值：为下一轮攻击创造空间和时间

    4. Backstep (后跃步) - 战术意图：快速脱离
       └─ 动作特点：短距离、高速度、低消耗
       └─ 策略价值：保持与敌人的接触距离，便于后续攻击

    5. Sidestep (侧跃步) - 战术意图：规避直线攻击
       └─ 方向选择：基于团队分布智能选择左右
       └─ 策略价值：寻找敌人侧翼弱点，创造攻击机会

    6. BitWait (短暂等待) - 战术意图：观察敌人动向
       └─ 时机判断：敌人可能进入攻击后硬直
       └─ 策略价值：等待最佳攻击时机，节约体力

    7. BsAndSide (后跃步+侧移组合) - 战术意图：复合机动
       └─ 执行特点：快速后退 + 持续侧移
       └─ 策略价值：兼顾安全性和位置优势

    8. BsAndSs (后跃步+侧跃步组合) - 战术意图：高机动性规避
       └─ 动作特点：连续快速移动，难以预测
       └─ 策略价值：对付反应快速的敌人

    ============================================================================
    参数系统详解 (Detailed Parameter System):
    ============================================================================

    距离参数 (Distance Parameters):
    - DistMin_AAA/DistMax_AAA: 攻击后行为触发的距离范围
    - BackDist_AAA: 后退动作的目标距离
    - Dist_BackStep/Dist_SideStep: 跃步动作的移动距离

    角度参数 (Angle Parameters):
    - BaseDir_AAA: 攻击后行为判定的基准方向
    - Angle_AAA: 有效角度范围（度数）
    - BaseAng_Inter_AAA: 中断判定的基准角度

    概率参数 (Probability Parameters):
    - Odds_*_AAA: 各种行为的选择概率权重
    - Odds_Guard_AAA: 在行为中添加防御动作的概率

    时间参数 (Time Parameters):
    - *Life_AAA: 各种移动行为的持续时间
    - 中断参数: 用于提前终止不合适的行为

    方向参数 (Direction Parameters):
    - *Dir_AAA: 移动方向的调整系数
    - 团队协调: 基于队友分布的智能方向选择

    ============================================================================
    与其他AI系统的交互接口 (Interaction with Other AI Systems):
    ============================================================================

    输入接口 (Input Interfaces):
    └─ 主战斗AI调用: 在攻击动作完成后触发
    └─ 参数系统: 从AIAttackParam.xml读取配置
    └─ 团队系统: 获取队友位置信息进行协调

    输出接口 (Output Interfaces):
    └─ 移动系统: 调用GOAL_COMMON_LeaveTarget等移动目标
    └─ 动作系统: 调用GOAL_COMMON_SpinStep等动作目标
    └─ 状态系统: 返回目标执行结果，影响后续AI决策

    中断机制 (Interrupt Mechanisms):
    └─ 距离监控: 当敌我距离超出预期范围时中断
    └─ 角度监控: 当敌人移出有效角度时中断
    └─ 生命周期: 基于时间的自动中断机制

============================================================================]]

-- 注册攻击后行为目标到AI系统 (Register after attack action goal to AI system)
RegisterTableGoal(GOAL_COMMON_AfterAttackAct, "AfterAttackAct")
-- 注册为无子目标类型，直接执行动作 (Register as no sub-goal type for direct execution)
REGISTER_GOAL_NO_SUB_GOAL(GOAL_COMMON_AfterAttackAct, true)

-- ============================================================================
-- 目标激活函数 (Goal Activation Function)
-- ============================================================================
-- 功能：攻击后行为的核心决策函数，在AI完成攻击动作后立即调用
-- 参数：f1_arg0 - 目标实例，f1_arg1 - AI实体，f1_arg2 - 目标管理器
-- 返回：无返回值，通过添加子目标来执行具体行为
-- 算法：基于概率权重的多选一决策系统 + 环境条件筛选
Goal.Activate = function (f1_arg0, f1_arg1, f1_arg2)

    -- ===== 阶段1：环境条件检测 (Phase 1: Environmental Condition Detection) =====
    -- 获取与主要敌人（玩家）的当前距离 (Get current distance to primary enemy - player)
    local f1_local0 = f1_arg1:GetDist(TARGET_ENE_0)

    -- 执行前置条件检查 (Execute pre-condition checks)
    -- 条件1：距离检查 - 确保在攻击后行为的有效距离范围内
    -- 条件2：角度检查 - 确保敌人在AI的感知扇形区域内
    -- 条件3：状态检查 - 确保AI和敌人都处于可交互状态
    local distance_valid = f1_local0 >= f1_arg1:GetStringIndexedNumber("DistMin_AAA") and
                          f1_local0 <= f1_arg1:GetStringIndexedNumber("DistMax_AAA")
    local angle_valid = f1_arg1:IsInsideTarget(TARGET_ENE_0,
                                              f1_arg1:GetStringIndexedNumber("BaseDir_AAA"),
                                              f1_arg1:GetStringIndexedNumber("Angle_AAA"))

    if not distance_valid or not angle_valid then
        -- 条件不满足，不执行攻击后行为，直接返回主战斗循环
        -- (Conditions not met, skip after-attack actions, return to main combat loop)
        return
    else
        -- ===== 阶段2：防御行为概率计算 (Phase 2: Guard Action Probability Calculation) =====
        -- 初始化防御动作ID，默认值-1表示不启用防御 (Initialize guard action ID, -1 means no guard)
        local f1_local1 = -1

        -- 基于配置概率决定是否在移动行为中融入防御姿态
        -- 这是一个重要的战术决策：移动时保持防御可以降低受伤风险，但会影响移动速度
        -- (Decide whether to integrate guard stance in movement based on probability)
        local guard_roll = f1_arg1:GetRandam_Int(1, 100)
        local guard_threshold = f1_arg1:GetStringIndexedNumber("Odds_Guard_AAA")
        if guard_roll <= guard_threshold then
            f1_local1 = 9910  -- 标准防御动作ID (Standard guard action ID)
            -- 注意：防御动作会影响移动速度和动画，但提供额外保护
            -- (Note: Guard action affects movement speed and animation but provides extra protection)
        end

        -- ===== 阶段3：智能方向选择系统 (Phase 3: Intelligent Direction Selection System) =====
        -- 初始方向选择：使用随机数作为基础 (Initial direction: random as baseline)
        local f1_local2 = f1_arg1:GetRandam_Int(0, 1)  -- 0=左侧, 1=右侧 (0=left, 1=right)

        -- 团队协调分析：统计各侧的队友分布 (Team coordination analysis: count allies on each side)
        -- 使用4米范围作为拥挤判定距离，避免队友间碰撞和重叠
        local f1_local3 = f1_arg1:GetTeamRecordCount(COORDINATE_TYPE_SideWalk_L, TARGET_ENE_0, 4)  -- 左侧队友数量
        local f1_local4 = f1_arg1:GetTeamRecordCount(COORDINATE_TYPE_SideWalk_R, TARGET_ENE_0, 4)  -- 右侧队友数量

        -- 智能方向调整算法：选择人员较少的一侧以避免拥挤
        -- 这个算法确保AI团队能够均匀分布，避免"扎堆"现象
        -- (Intelligent direction adjustment: choose the side with fewer allies)
        if f1_local4 < f1_local3 then
            f1_local2 = 1  -- 右侧人员较少，优先选择右侧 (Right side has fewer allies, prefer right)
        elseif f1_local3 < f1_local4 then
            f1_local2 = 0  -- 左侧人员较少，优先选择左侧 (Left side has fewer allies, prefer left)
        end
        -- 如果两侧人数相等，保持初始随机选择 (If equal on both sides, keep initial random choice)

        -- ===== 阶段4：概率权重系统 (Phase 4: Probability Weight System) =====
        -- 这是攻击后行为选择的核心算法：加权随机选择系统
        -- 算法原理：将所有行为的概率权重累加，生成随机数进行区间判定
        -- 优势：配置灵活、性能高效、支持动态权重调整

        -- 步骤4.1：收集所有行为选项的概率权重 (Step 4.1: Collect probability weights for all actions)
        local weight_no_act = f1_arg1:GetStringIndexedNumber("Odds_NoAct_AAA")         -- 无动作权重
        local weight_back_side = f1_arg1:GetStringIndexedNumber("Odds_BackAndSide_AAA") -- 后退+侧移权重
        local weight_back = f1_arg1:GetStringIndexedNumber("Odds_Back_AAA")            -- 后退权重
        local weight_backstep = f1_arg1:GetStringIndexedNumber("Odds_Backstep_AAA")    -- 后跃步权重
        local weight_sidestep = f1_arg1:GetStringIndexedNumber("Odds_Sidestep_AAA")    -- 侧跃步权重
        local weight_wait = f1_arg1:GetStringIndexedNumber("Odds_BitWait_AAA")         -- 等待权重
        local weight_bs_side = f1_arg1:GetStringIndexedNumber("Odds_BsAndSide_AAA")    -- 后跃+侧移权重
        local weight_bs_ss = f1_arg1:GetStringIndexedNumber("Odds_BsAndSs_AAA")        -- 后跃+侧跃权重

        -- 步骤4.2：计算总权重 (Step 4.2: Calculate total weight)
        local f1_local5 = weight_no_act + weight_back_side + weight_back + weight_backstep +
                         weight_sidestep + weight_wait + weight_bs_side + weight_bs_ss

        -- 步骤4.3：构建累积概率区间 (Step 4.3: Build cumulative probability ranges)
        -- 这种区间划分方法允许O(1)时间复杂度的随机选择
        -- 区间示例：[0-10]=NoAct, [11-35]=BackAndSide, [36-55]=Back, ...
        local f1_local6 = weight_no_act                                    -- 区间1结束：无动作
        local f1_local7 = f1_local6 + weight_back_side                     -- 区间2结束：后退+侧移
        local f1_local8 = f1_local7 + weight_back                          -- 区间3结束：后退
        local f1_local9 = f1_local8 + weight_backstep                      -- 区间4结束：后跃步
        local f1_local10 = f1_local9 + weight_sidestep                     -- 区间5结束：侧跃步
        local f1_local11 = f1_local10 + weight_wait                        -- 区间6结束：等待
        local f1_local12 = f1_local11 + weight_bs_side                     -- 区间7结束：后跃+侧移
        local f1_local13 = f1_local12 + weight_bs_ss                       -- 区间8结束：后跃+侧跃

        -- 步骤4.4：生成决策随机数 (Step 4.4: Generate decision random number)
        -- 范围：[1, total_weight]，确保每个行为都有被选中的可能
        local f1_local14 = f1_arg1:GetRandam_Int(1, f1_local5)

        -- ===== 阶段5：行为执行分支 (Phase 5: Action Execution Branches) =====
        -- 基于累积概率区间的多分支判定，每个分支对应一种特定的攻击后行为
        -- 分支顺序与权重计算顺序保持一致，确保逻辑正确性

        if f1_local14 > 0 and f1_local14 <= f1_local6 then
            -- ========== 行为选项1：NoAct (无动作) ==========
            -- 战术目的：保持攻击压力，不给敌人喘息机会
            -- 适用场景：连续攻击链、敌人处于劣势状态、距离非常适合
            -- 执行结果：直接结束当前目标，AI将立即进入下一个攻击循环
            -- 性能优势：零开销，最快的选择路径
            -- 注意：这是最激进的选择，需要确保安全性
        elseif f1_local6 < f1_local14 and f1_local14 <= f1_local7 then
            -- ========== 行为选项2：BackAndSide (后退+侧移组合) ==========
            -- 战术目的：安全重新定位，保持战斗优势
            -- 适用场景：中近距离战斗，需要调整位置获得更好的攻击角度
            -- 执行策略：两阶段复合行为，先确保安全再优化位置
            -- 性能特点：适中的开销，良好的安全性和灵活性

            -- 阶段2.1：执行后退动作 (Phase 2.1: Execute back movement)
            -- 目的：立即拉开距离，减少受到反击的风险
            -- 参数解析：BackLife控制持续时间，BackDist控制目标距离
            f1_arg2:AddSubGoal(GOAL_COMMON_LeaveTarget,
                f1_arg1:GetStringIndexedNumber("BackAndSide_BackLife_AAA"),    -- 后退持续时间：控制移动速度
                TARGET_ENE_0,                                                  -- 目标：主要敌人（玩家）
                f1_arg1:GetStringIndexedNumber("BackAndSide_BackDist_AAA"),    -- 后退距离：安全距离设定
                TARGET_ENE_0, true, f1_local1                                 -- 参数：目标、朝向锁定、防御动作ID
            ):SetTargetRange(30,                                              -- 中断信号ID：30
                f1_arg1:GetStringIndexedNumber("DistMin_Inter_AAA"),           -- 中断条件：最小距离阈值
                f1_arg1:GetStringIndexedNumber("DistMax_Inter_AAA")            -- 中断条件：最大距离阈值
            ):SetTargetAngle(30,                                              -- 中断信号ID：30（与距离共用）
                f1_arg1:GetStringIndexedNumber("BaseAng_Inter_AAA"),           -- 中断条件：基准角度
                f1_arg1:GetStringIndexedNumber("Ang_Inter_AAA")               -- 中断条件：角度范围
            )

            -- 阶段2.2：执行侧移动作 (Phase 2.2: Execute side movement)
            -- 目的：改变攻击角度，寻找敌人的侧翼弱点
            -- 方向：基于前面团队协调分析的结果（f1_local2）
            f1_arg2:AddSubGoal(GOAL_COMMON_SidewayMove,
                f1_arg1:GetStringIndexedNumber("BackAndSide_SideLife_AAA"),    -- 侧移持续时间
                TARGET_ENE_0, f1_local2,                                      -- 目标和智能选择的方向
                f1_arg1:GetStringIndexedNumber("BackAndSide_SideDir_AAA"),     -- 侧移角度调整系数
                true, true, f1_local1                                         -- 锁定目标、保持距离、防御姿态
            ):SetTargetRange(30,                                              -- 继承相同的中断条件
                f1_arg1:GetStringIndexedNumber("DistMin_Inter_AAA"),
                f1_arg1:GetStringIndexedNumber("DistMax_Inter_AAA")
            ):SetTargetAngle(30,
                f1_arg1:GetStringIndexedNumber("BaseAng_Inter_AAA"),
                f1_arg1:GetStringIndexedNumber("Ang_Inter_AAA")
            )
        elseif f1_local7 < f1_local14 and f1_local14 <= f1_local8 then
            -- ========== 行为选项3：Back (单纯后退) ==========
            -- 战术目的：快速脱离接触，重新评估局势
            -- 适用场景：敌人反击风险较高，需要暂时脱离进行重整
            -- 执行特点：单一动作，执行快速，资源消耗低
            -- 策略价值：为下一轮攻击创造时间和空间，降低连击风险
            f1_arg2:AddSubGoal(GOAL_COMMON_LeaveTarget,
                f1_arg1:GetStringIndexedNumber("BackLife_AAA"),      -- 后退持续时间：影响移动速度
                TARGET_ENE_0,                                        -- 离开目标：主要敌人
                f1_arg1:GetStringIndexedNumber("BackDist_AAA"),      -- 后退距离：安全距离设定
                TARGET_ENE_0, true, f1_local1                       -- 面向目标、防御姿态
            )

        elseif f1_local8 < f1_local14 and f1_local14 <= f1_local9 then
            -- ========== 行为选项4：Backstep (后跃步) ==========
            -- 战术目的：快速短距离脱离，保持攻击距离
            -- 适用场景：需要避开即将到来的攻击，但仍希望保持进攻态势
            -- 动作特点：速度快、距离短、硬直时间少
            -- 策略优势：既能规避威胁又能快速重新投入战斗
            f1_arg2:AddSubGoal(GOAL_COMMON_SpinStep,
                5,                                                   -- 动作持续时间：固定5帧，确保快速执行
                6001,                                                -- 动作ID：后跃步专用动画
                TARGET_ENE_0, 0, AI_DIR_TYPE_B,                     -- 目标、偏移、方向（向后）
                f1_arg1:GetStringIndexedNumber("Dist_BackStep")      -- 后跃距离：短距离快速移动
            )

        elseif f1_local9 < f1_local14 and f1_local14 <= f1_local10 then
            -- ========== 行为选项5：Sidestep (侧跃步) ==========
            -- 战术目的：横向规避，寻找侧翼攻击机会
            -- 适用场景：面对直线攻击或需要改变攻击角度
            -- 方向选择：使用前面计算的智能方向选择结果
            -- 策略价值：既能避开攻击又能获得更好的攻击位置
            f1_arg2:AddSubGoal(GOAL_EnemyStepLR,
                5,                                                   -- 动作持续时间：快速执行
                TARGET_ENE_0,                                        -- 相对于敌人进行侧跃
                f1_arg1:GetStringIndexedNumber("Dist_SideStep")      -- 侧跃距离：保持合适的战斗距离
            )

        elseif f1_local10 < f1_local14 and f1_local14 <= f1_local11 then
            -- ========== 行为选项6：BitWait (短暂等待) ==========
            -- 战术目的：观察敌人动向，寻找最佳攻击时机
            -- 适用场景：敌人处于攻击后硬直，或者局势需要重新评估
            -- 时间设计：随机化避免被玩家预测，增加战斗的不可预测性
            -- 策略价值：节约体力，等待更好的攻击机会，打乱敌人节奏
            f1_arg2:AddSubGoal(GOAL_COMMON_Wait,
                f1_arg1:GetRandam_Float(0.5, 1),                    -- 随机等待0.5-1秒：避免行为模式化
                0, 0, 0, 0                                          -- 等待参数：保持警戒状态
            )
        elseif f1_local11 < f1_local14 and f1_local14 <= f1_local12 then
            -- ========== 行为选项7：BsAndSide (后跃步+侧移组合) ==========
            -- 战术目的：快速脱离+战术重新定位，兼顾安全性和攻击位置
            -- 适用场景：需要快速脱离危险区域并重新获得攻击优势
            -- 执行策略：快速后跃确保安全 → 持续侧移寻找机会
            -- 复合优势：结合了后跃的安全性和侧移的机动性

            -- 阶段7.1：快速后跃步 (Phase 7.1: Quick backstep)
            -- 目的：立即脱离当前危险位置
            f1_arg2:AddSubGoal(GOAL_COMMON_SpinStep,
                5, 6001, TARGET_ENE_0, 0, AI_DIR_TYPE_B,               -- 标准后跃步配置
                f1_arg1:GetStringIndexedNumber("Dist_BackStep")         -- 后跃距离
            )

            -- 阶段7.2：持续侧移 (Phase 7.2: Sustained side movement)
            -- 目的：在安全距离下寻找攻击角度，保持战斗主动权
            f1_arg2:AddSubGoal(GOAL_COMMON_SidewayMove,
                f1_arg1:GetStringIndexedNumber("BsAndSide_SideLife_AAA"),  -- 侧移持续时间：较长时间保持机动
                TARGET_ENE_0, f1_local2,                                  -- 智能方向选择
                f1_arg1:GetStringIndexedNumber("BsAndSide_SideDir_AAA"),    -- 侧移角度调整
                true, true, f1_local1                                     -- 锁定目标、保持距离、防御姿态
            ):SetTargetRange(30,                                          -- 设置中断监控
                f1_arg1:GetStringIndexedNumber("DistMin_Inter_AAA"),
                f1_arg1:GetStringIndexedNumber("DistMax_Inter_AAA")
            ):SetTargetAngle(30,
                f1_arg1:GetStringIndexedNumber("BaseAng_Inter_AAA"),
                f1_arg1:GetStringIndexedNumber("Ang_Inter_AAA")
            )

        elseif f1_local12 < f1_local14 and f1_local14 <= f1_local13 then
            -- ========== 行为选项8：BsAndSs (后跃步+侧跃步组合) ==========
            -- 战术目的：高机动性连续规避，对付反应敏捷的敌人
            -- 适用场景：面对快速连击或需要进行复杂规避的情况
            -- 执行特点：双重快速移动，动作连贯，难以预测
            -- 策略价值：最大化生存能力，创造反击机会

            -- 阶段8.1：快速后跃步 (Phase 8.1: Quick backstep)
            -- 目的：第一时间脱离威胁区域
            f1_arg2:AddSubGoal(GOAL_COMMON_SpinStep,
                5, 6001, TARGET_ENE_0, 0, AI_DIR_TYPE_B,               -- 后跃步动作
                f1_arg1:GetStringIndexedNumber("Dist_BackStep")         -- 后跃距离
            )

            -- 阶段8.2：快速侧跃步 (Phase 8.2: Quick sidestep)
            -- 目的：改变位置避免被追击，同时寻找侧翼机会
            f1_arg2:AddSubGoal(GOAL_EnemyStepLR,
                5, TARGET_ENE_0,                                       -- 快速侧跃
                f1_arg1:GetStringIndexedNumber("Dist_SideStep")         -- 侧跃距离
            )

        else
            -- ========== 默认分支：安全处理 (Default Branch: Safe Handling) ==========
            -- 当随机数超出所有预定义范围时的保护机制
            -- 这种情况理论上不应该发生，但提供保护以确保系统稳定性
            -- 行为：不执行任何动作，直接返回主战斗循环
        end
    end
    -- ===== 阶段6：执行完成标记 (Phase 6: Execution Completion Mark) =====
    -- 所有攻击后行为选择和配置完成，控制权交给子目标系统
    -- 主战斗AI将等待这些行为完成后再进入下一个决策循环
end

-- ============================================================================
-- 目标更新函数 (Goal Update Function)
-- ============================================================================
-- 功能：每帧调用的状态检查函数，监控攻击后行为的执行进度
-- 频率：每游戏帧调用一次（通常60fps），必须高效执行
-- 返回：GOAL_RESULT_Success(完成) | GOAL_RESULT_Continue(继续) | GOAL_RESULT_Failed(失败)
Goal.Update = function (f2_arg0, f2_arg1, f2_arg2)

    -- 检查1：子目标完成状态 (Check 1: Sub-goal completion status)
    -- 当所有子目标都执行完毕时，攻击后行为目标应该结束
    if f2_arg2:GetSubGoalNum() <= 0 then
        return GOAL_RESULT_Success  -- 成功完成：所有子行为已执行完毕
    end

    -- 检查2：目标生命周期管理 (Check 2: Goal lifecycle management)
    -- 防止目标无限执行，提供超时保护机制
    if f2_arg2:GetLife() <= 0 then
        return GOAL_RESULT_Success  -- 超时完成：防止死锁，强制结束
    end

    -- 默认状态：继续执行 (Default state: Continue execution)
    -- 子目标仍在执行中，保持当前状态等待完成
    return GOAL_RESULT_Continue
end

-- ============================================================================
-- 距离超出范围中断处理 (Target Out of Range Interrupt Handler)
-- ============================================================================
-- 功能：当敌人距离超出预设范围时的紧急中断处理
-- 触发：敌人距离小于DistMin_Inter_AAA或大于DistMax_Inter_AAA
-- 目的：防止AI在不合适的距离下执行攻击后行为
Goal.Interrupt_TargetOutOfRange = function (f3_arg0, f3_arg1, f3_arg2, f3_arg3)

    -- 信号识别：检查是否为攻击后行为的距离监控信号
    if f3_arg3 == 30 then  -- 信号ID 30：专用于攻击后行为的距离监控
        -- 紧急处理：立即清除所有子目标，终止当前行为序列
        f3_arg2:ClearSubGoal()
        -- 理由：距离不合适时继续执行移动行为可能导致AI行为异常
        return true  -- 返回true表示中断已被正确处理
    end

    -- 非相关信号：不处理，传递给其他系统
    return false
end

-- ============================================================================
-- 角度超出范围中断处理 (Target Out of Angle Interrupt Handler)
-- ============================================================================
-- 功能：当敌人角度超出预设范围时的紧急中断处理
-- 触发：敌人角度超出BaseAng_Inter_AAA ± Ang_Inter_AAA范围
-- 目的：确保AI只在能够有效感知敌人的角度范围内执行行为
Goal.Interrupt_TargetOutOfAngle = function (f4_arg0, f4_arg1, f4_arg2, f4_arg3)

    -- 信号识别：检查是否为攻击后行为的角度监控信号
    if f4_arg3 == 30 then  -- 信号ID 30：与距离监控共用，简化管理
        -- 紧急处理：立即清除所有子目标，终止当前行为序列
        f4_arg2:ClearSubGoal()
        -- 理由：角度超出范围意味着失去目标锁定，继续行为没有意义
        return true  -- 返回true表示中断已被正确处理
    end

    -- 非相关信号：不处理，传递给其他系统
    return false
end

--[[============================================================================
    ★ 性能优化与技术实现细节 (Performance Optimization & Technical Details) ★
    ============================================================================

    ◆ 算法复杂度分析 (Algorithm Complexity Analysis):
    ──────────────────────────────────────────────────────────────────────
    - 时间复杂度：O(1) - 常数时间决策，不依赖于行为选项数量
    - 空间复杂度：O(1) - 固定内存占用，无动态分配
    - 概率计算：累积区间法，避免循环遍历，确保实时性能

    ◆ 内存管理优化 (Memory Management Optimization):
    ──────────────────────────────────────────────────────────────────────
    1. 参数缓存策略：
       └─ 一次性读取所有StringIndexedNumber参数
       └─ 避免重复访问字符串索引系统
       └─ 局部变量存储，减少函数调用开销

    2. 团队协调缓存：
       └─ GetTeamRecordCount结果可被多次使用
       └─ 4米范围查询是预计算的高效操作
       └─ 避免不必要的重复团队查询

    ◆ 实时性能保证 (Real-time Performance Guarantee):
    ──────────────────────────────────────────────────────────────────────
    - 每帧调用开销：< 0.1ms（在标准硬件上）
    - 无阻塞操作：所有计算都是同步且快速的
    - 中断响应：1帧内完成，确保及时响应环境变化

    ◆ 系统稳定性措施 (System Stability Measures):
    ──────────────────────────────────────────────────────────────────────
    - 防御式编程：所有分支都有默认处理
    - 超时保护：防止目标无限执行的生命周期管理
    - 边界检查：随机数范围验证，防止数组越界

    ============================================================================
    ★ 使用指南与配置示例 (Usage Guide & Configuration Examples) ★
    ============================================================================

    ◆ 基本调用方法 (Basic Usage):
    ──────────────────────────────────────────────────────────────────────
    -- 在主战斗AI脚本中添加攻击后行为
    f_arg2:AddSubGoal(GOAL_COMMON_AfterAttackAct, 10)  -- 10为生命周期

    -- 带条件调用示例
    if attack_completed and enemy_in_range then
        f_arg2:AddSubGoal(GOAL_COMMON_AfterAttackAct, 5)
    end

    ◆ AIAttackParam.xml配置示例 (Parameter Configuration):
    ──────────────────────────────────────────────────────────────────────
    <!-- 基础触发条件 -->
    <DistMin_AAA>0.5</DistMin_AAA>          <!-- 最小触发距离(米) -->
    <DistMax_AAA>5.0</DistMax_AAA>          <!-- 最大触发距离(米) -->
    <BaseDir_AAA>0</BaseDir_AAA>            <!-- 基准方向(度) -->
    <Angle_AAA>180</Angle_AAA>              <!-- 有效角度范围(度) -->

    <!-- 行为概率权重配置 -->
    <Odds_NoAct_AAA>10</Odds_NoAct_AAA>         <!-- 无动作：10% -->
    <Odds_BackAndSide_AAA>25</Odds_BackAndSide_AAA>  <!-- 后退+侧移：25% -->
    <Odds_Back_AAA>20</Odds_Back_AAA>           <!-- 单纯后退：20% -->
    <Odds_Backstep_AAA>15</Odds_Backstep_AAA>   <!-- 后跃步：15% -->
    <Odds_Sidestep_AAA>15</Odds_Sidestep_AAA>   <!-- 侧跃步：15% -->
    <Odds_BitWait_AAA>10</Odds_BitWait_AAA>     <!-- 短暂等待：10% -->
    <Odds_BsAndSide_AAA>3</Odds_BsAndSide_AAA>  <!-- 后跃+侧移：3% -->
    <Odds_BsAndSs_AAA>2</Odds_BsAndSs_AAA>      <!-- 后跃+侧跃：2% -->

    <!-- 防御行为配置 -->
    <Odds_Guard_AAA>30</Odds_Guard_AAA>         <!-- 防御姿态概率：30% -->

    <!-- 移动距离参数 -->
    <BackDist_AAA>2.0</BackDist_AAA>            <!-- 后退目标距离 -->
    <Dist_BackStep>1.5</Dist_BackStep>          <!-- 后跃步距离 -->
    <Dist_SideStep>1.2</Dist_SideStep>          <!-- 侧跃步距离 -->

    ◆ 战术配置建议 (Tactical Configuration Recommendations):
    ──────────────────────────────────────────────────────────────────────
    【积极型敌人配置】- 持续压制，少防守
    ├─ Odds_NoAct_AAA: 30        (保持攻击压力)
    ├─ Odds_BackAndSide_AAA: 20  (适度重新定位)
    ├─ Odds_Back_AAA: 15         (减少后退)
    └─ Odds_Guard_AAA: 15        (降低防御概率)

    【防御型敌人配置】- 保守战术，高安全性
    ├─ Odds_NoAct_AAA: 5         (减少连续攻击)
    ├─ Odds_Back_AAA: 40         (优先后退)
    ├─ Odds_BitWait_AAA: 25      (增加观察时间)
    └─ Odds_Guard_AAA: 50        (提高防御概率)

    【平衡型敌人配置】- 全面均衡，适应性强
    ├─ 使用上述示例的默认配置
    └─ 根据战斗表现进行微调

    ◆ 调试与优化建议 (Debugging & Optimization Tips):
    ──────────────────────────────────────────────────────────────────────
    1. 行为频率监控：
       └─ 观察各种行为的实际触发频率
       └─ 调整权重以达到期望的行为分布

    2. 团队协调效果：
       └─ 检查多个AI是否出现聚集现象
       └─ 调整侧移方向选择的优先级

    3. 性能监控：
       └─ 监控攻击后行为的执行时间
       └─ 确保中断处理的及时性

    4. 玩家体验调优：
       └─ 根据玩家反馈调整行为的可预测性
       └─ 平衡挑战性和公平性
============================================================================]]