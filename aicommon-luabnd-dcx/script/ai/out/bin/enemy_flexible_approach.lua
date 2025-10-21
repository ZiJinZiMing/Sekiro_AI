-- =======================================================================================
-- 敌人灵活接近行为目标 (Enemy Flexible Approach Goal)
-- =======================================================================================
-- 功能说明：
--   这个AI目标负责控制敌人如何灵活地接近或远离目标。
--   支持多种移动策略：步行、跑步、前步、后步、防御移动等。
--   通过概率和距离判断来决定具体的移动行为，使AI表现更加多样化和智能化。
-- =======================================================================================

RegisterTableGoal(GOAL_EnemyFlexibleApproach, "GOAL_EnemyFlexibleApproach")
REGISTER_GOAL_NO_SUB_GOAL(GOAL_EnemyFlexibleApproach, true)

-- 参数说明（对应REGISTER_DBG_GOAL_PARAM的索引）：
REGISTER_DBG_GOAL_PARAM(GOAL_EnemyFlexibleApproach, 0, "対象", 0)              -- 参数0: 目标对象（通常是玩家）
REGISTER_DBG_GOAL_PARAM(GOAL_EnemyFlexibleApproach, 1, "旋回対象", 0)         -- 参数1: 旋回目标（面向的对象）
REGISTER_DBG_GOAL_PARAM(GOAL_EnemyFlexibleApproach, 2, "到達最小距離", 0)     -- 参数2: 到达最小距离（小于此距离则后退）
REGISTER_DBG_GOAL_PARAM(GOAL_EnemyFlexibleApproach, 3, "到達最大距離", 0)     -- 参数3: 到达最大距离（大于此距离则接近）
REGISTER_DBG_GOAL_PARAM(GOAL_EnemyFlexibleApproach, 4, "強制歩行距離", 0)     -- 参数4: 强制步行距离（在此距离内强制步行）
REGISTER_DBG_GOAL_PARAM(GOAL_EnemyFlexibleApproach, 5, "強制走行距離", 0)     -- 参数5: 强制奔跑距离（在此距离外强制奔跑）
REGISTER_DBG_GOAL_PARAM(GOAL_EnemyFlexibleApproach, 6, "走行確率", 0)         -- 参数6: 奔跑概率（0-100）
REGISTER_DBG_GOAL_PARAM(GOAL_EnemyFlexibleApproach, 7, "防御確率", 0)         -- 参数7: 防御概率（移动时保持防御姿态的概率，0-100）
REGISTER_DBG_GOAL_PARAM(GOAL_EnemyFlexibleApproach, 8, "後ステップ確率", 0)   -- 参数8: 后步概率（0-100）
REGISTER_DBG_GOAL_PARAM(GOAL_EnemyFlexibleApproach, 9, "前ステップ確率", 0)   -- 参数9: 前步概率（0-100）
REGISTER_DBG_GOAL_PARAM(GOAL_EnemyFlexibleApproach, 10, "ステップ間隔", 0)    -- 参数10: 步法间隔时间（秒）
REGISTER_DBG_GOAL_PARAM(GOAL_EnemyFlexibleApproach, 11, "後退可狽ｩ", 0)       -- 参数11: 后退可能性（0=禁用后退，1=允许后退）

-- =======================================================================================
-- 目标激活函数 (Activate Function)
-- =======================================================================================
-- 功能说明：
--   当AI目标被激活时执行，根据当前与目标的距离和各种参数来决定初始行为。
--
-- 参数说明：
--   f1_arg0: AI对象
--   f1_arg1: AI实体（敌人自身）
--   f1_arg2: 目标对象（包含所有参数）
-- =======================================================================================
Goal.Activate = function (f1_arg0, f1_arg1, f1_arg2)
    -- ==================================================================================
    -- 第一部分：参数获取与初始化
    -- ==================================================================================

    -- 获取所有输入参数
    local f1_local0 = f1_arg2:GetParam(0)   -- 目标对象
    local f1_local1 = f1_arg2:GetParam(1)   -- 旋回目标（未使用，预留参数）
    local f1_local2 = f1_arg2:GetParam(2)   -- 到达最小距离
    local f1_local3 = f1_arg2:GetParam(3)   -- 到达最大距离
    local f1_local4 = f1_arg2:GetParam(4)   -- 强制步行距离
    local f1_local5 = f1_arg2:GetParam(5)   -- 强制奔跑距离
    local f1_local6 = f1_arg2:GetParam(6)   -- 奔跑概率（0-100）
    local f1_local7 = f1_arg2:GetParam(7)   -- 防御概率（0-100）
    local f1_local8 = f1_arg2:GetParam(8)   -- 后步概率（0-100）
    local f1_local9 = f1_arg2:GetParam(9)   -- 前步概率（0-100）
    local f1_local10 = f1_arg2:GetParam(10) -- 步法间隔时间（秒）
    local f1_local11 = f1_arg2:GetParam(11) -- 后退可能性标志

    -- 参数默认值处理：如果未指定后退可能性，则默认为0（禁用后退）
    if f1_local11 == nil then
        f1_local11 = 0
    end

    -- 参数合法性校验：确保最小距离不为负数
    if f1_local2 < 0 then
        f1_local2 = 0
    end

    -- 获取当前与目标的实际距离
    local f1_local12 = f1_arg1:GetDist(f1_local0)

    -- 初始化局部变量
    local f1_local13 = -1   -- 防御动画ID（-1表示不使用防御）
    local f1_local14 = true -- 是否步行标志（true=步行，false=奔跑）

    -- ==================================================================================
    -- 第二部分：步法间隔计时器管理
    -- ==================================================================================

    -- 计时器ID 7110005用于控制步法行为（前步/后步）的执行间隔
    -- 如果计时器已过期（<=0），则重新启动并设置为指定的步法间隔时间
    if f1_arg1:GetIdTimer(7110005) <= 0 then
        f1_arg1:StartIdTimerSpecifyTime(7110005, f1_local10)
    end

    -- ==================================================================================
    -- 第三部分：防御行为概率判定
    -- ==================================================================================

    -- 根据防御概率决定是否在移动时保持防御姿态
    -- 如果随机数小于防御概率，则设置防御动画ID为9910（防御移动）
    if f1_arg1:GetRandam_Float(0.1, 100) < f1_local7 then
        f1_local13 = 9910  -- 9910是防御移动的动画ID
    end

    -- 计算中间距离（用于未来可能的扩展，当前代码中未直接使用）
    local f1_local15 = (f1_local3 + f1_local2) / 2 + 1

    -- ==================================================================================
    -- 第四部分：距离过近时的后退逻辑
    -- ==================================================================================

    -- 情况1：当前距离小于最小距离（距离过近）
    if f1_local12 < f1_local2 then
        -- 如果后退功能被禁用（f1_local11 == 0），则直接结束目标
        if f1_local11 == 0 then
            return
        else
            -- 后退功能已启用，尝试执行后退步法

            -- 检查是否满足后步条件（所有条件必须同时满足）：
            -- 1. AI攻击参数7004（后步）存在
            -- 2. 后步动作对当前目标有效
            -- 3. 后步的执行间隔时间已过
            -- 4. 步法间隔计时器（7110005）已过
            -- 5. 当前距离加上最大距离小于8（避免后退过远）
            if f1_arg1:IsAIAttackParam(7004) and IsValidEnemySelect(f1_arg0, f1_arg1, f1_arg2, 7004, f1_local0) and f1_arg1:GetAIAttackParam(7004, AI_ATTACK_PARAM_TYPE__INTERVAL_EXEC) < f1_arg1:GetIdTimer(7100000 + 7004) and f1_local10 < f1_arg1:GetIdTimer(7110005) and f1_local12 + f1_local3 < 8 then
                -- 重置步法间隔计时器
                f1_arg1:StartIdTimer(7110005)

                -- 根据后步概率决定是否执行后步动作
                if f1_arg1:GetRandam_Float(0.1, 100) < f1_local8 then
                    -- 重置后步专用计时器（7100000 + 7004）
                    f1_arg1:StartIdTimer(7100000 + 7004)
                    -- 添加敌人后步目标，后退距离为8
                    f1_arg2:AddSubGoal(GOAL_EnemyStepBack, f1_arg2:GetLife(), f1_local0, 8)
                end
            end

            -- 无论是否执行后步，都添加离开目标的子目标（后退到最小距离）
            -- SetFailedEndOption：如果失败则继续执行父目标的下一个子目标
            f1_arg2:AddSubGoal(GOAL_COMMON_LeaveTarget, f1_arg2:GetLife(), f1_local0, f1_local2, TARGET_ENE_0, f1_local14, f1_local13):SetFailedEndOption(AI_GOAL_FAILED_END_OPT__PARENT_NEXT_SUB_GOAL)
            return
        end
    end
    -- ==================================================================================
    -- 第五部分：距离过远时的接近逻辑
    -- ==================================================================================

    -- 情况2：当前距离大于最大距离（距离过远）
    if f1_local3 < f1_local12 then
        -- ----------------------------
        -- 步行/奔跑决策
        -- ----------------------------

        -- 决定是否使用奔跑接近目标
        -- 条件1：距离超过强制奔跑距离（f1_local5），则必定奔跑
        -- 条件2：距离超过强制步行距离（f1_local4）且概率判定通过，则奔跑
        if f1_local5 < f1_local12 or f1_local4 < f1_local12 and f1_arg1:GetRandam_Float(0.1, 100) < f1_local6 then
            f1_local14 = false  -- false表示奔跑
        end

        -- ----------------------------
        -- 前步动作判定
        -- ----------------------------

        -- 根据前步概率判定是否执行前步动作，并且AI攻击参数7008（前步）必须存在
        if f1_arg1:GetRandam_Float(0.1, 100) < f1_local9 and f1_arg1:IsAIAttackParam(7008) then
            -- 获取前步的最小最佳距离（前步能够缩短的距离）
            local f1_local16 = f1_arg1:GetAIAttackParam(7008, AI_ATTACK_PARAM_TYPE__MIN_OPTIMAL_DISTANCE)

            -- 检查是否满足前步执行条件（所有条件必须同时满足）：
            -- 1. 执行前步后仍能保持在最小距离之外（f1_local2 < f1_local12 - f1_local16）
            -- 2. 前步的执行间隔时间已过
            -- 3. 步法间隔计时器已过
            if f1_local2 < f1_local12 - f1_local16 and f1_arg1:GetAIAttackParam(7008, AI_ATTACK_PARAM_TYPE__INTERVAL_EXEC) < f1_arg1:GetIdTimer(7100000 + 7008) and f1_local10 < f1_arg1:GetIdTimer(7110005) then
                -- 重置步法间隔计时器
                f1_arg1:StartIdTimer(7110005)
                -- 重置前步专用计时器（7100000 + 7008）
                f1_arg1:StartIdTimer(7100000 + 7008)
                -- 添加敌人前步目标，前进距离为f1_local16
                f1_arg2:AddSubGoal(GOAL_EnemyStepFront, f1_arg2:GetLife(), f1_local0, f1_local16)
            end
        end

        -- ----------------------------
        -- 接近目标
        -- ----------------------------

        -- 添加接近目标的子目标，移动到最大距离（f1_local3）之内
        -- 参数说明：
        --   - f1_local3: 目标距离（最大距离）
        --   - TARGET_SELF: 以自身为基准
        --   - f1_local14: 是否步行（true=步行，false=奔跑）
        --   - f1_local13: 防御动画ID（-1或9910）
        f1_arg2:AddSubGoal(GOAL_COMMON_ApproachTarget, f1_arg2:GetLife(), f1_local0, f1_local3, TARGET_SELF, f1_local14, f1_local13)

        -- 如果使用步行接近，设置数字标志4为1（可能用于其他AI逻辑的状态判断）
        if f1_local14 then
            f1_arg2:SetNumber(4, 1)
        end
    end

end

-- =======================================================================================
-- 目标更新函数 (Update Function)
-- =======================================================================================
-- 功能说明：
--   在AI目标执行过程中每帧调用，根据当前状态动态调整行为。
--   主要负责在接近/后退过程中插入步法动作，使移动更加灵活和多变。
--
-- 参数说明：
--   f2_arg0: AI对象
--   f2_arg1: AI实体（敌人自身）
--   f2_arg2: 目标对象
--
-- 返回值：
--   GOAL_RESULT_Success - 目标成功完成
--   GOAL_RESULT_Continue - 目标继续执行
-- =======================================================================================
Goal.Update = function (f2_arg0, f2_arg1, f2_arg2)
    -- ==================================================================================
    -- 第一部分：目标完成检查
    -- ==================================================================================

    -- 如果没有子目标在执行，说明目标已完成
    if f2_arg2:GetSubGoalNum() <= 0 then
        return GOAL_RESULT_Success
    end

    -- ==================================================================================
    -- 第二部分：参数获取与初始化
    -- ==================================================================================

    -- 获取所有必要的参数
    local f2_local0 = f2_arg2:GetParam(0)   -- 目标对象
    local f2_local1 = f2_arg2:GetParam(1)   -- 旋回目标（未使用）
    local f2_local2 = f2_arg2:GetParam(2)   -- 到达最小距离
    local f2_local3 = f2_arg2:GetParam(3)   -- 到达最大距离
    local f2_local4 = f2_arg2:GetParam(5)   -- 强制奔跑距离（注意：跳过了参数4）
    local f2_local5 = f2_arg2:GetParam(7)   -- 防御概率
    local f2_local6 = f2_arg2:GetParam(8)   -- 后步概率
    local f2_local7 = f2_arg2:GetParam(9)   -- 前步概率
    local f2_local8 = f2_arg2:GetParam(10)  -- 步法间隔时间
    local f2_local9 = f2_arg1:GetDist(f2_local0)  -- 获取当前距离

    -- 初始化局部变量
    local f2_local10 = -1     -- 防御动画ID
    local f2_local11 = false  -- 是否步行标志（false=奔跑）

    -- ==================================================================================
    -- 第三部分：防御行为概率判定
    -- ==================================================================================

    -- 根据防御概率决定是否使用防御移动
    if f2_arg1:GetRandam_Float(0.1, 100) < f2_local5 then
        f2_local10 = 9910  -- 设置防御动画ID
    end

    -- ==================================================================================
    -- 第四部分：接近过程中的前步插入逻辑
    -- ==================================================================================

    -- 检查当前是否正在执行"接近目标"子目标
    -- 如果满足条件，在接近过程中插入前步动作，使移动更加灵活
    if f2_arg1:IsActiveGoal(GOAL_COMMON_ApproachTarget) and f2_arg1:IsAIAttackParam(7008) and f2_local8 < f2_arg1:GetIdTimer(7110005) then
        -- 重置步法间隔计时器
        f2_arg1:StartIdTimer(7110005)

        -- 检查是否满足前步插入条件（所有条件必须同时满足）：
        -- 1. 前步的执行间隔时间已过
        -- 2. 执行前步后仍能保持在最小距离之外
        -- 3. 前步概率判定通过
        if f2_arg1:GetAIAttackParam(7008, AI_ATTACK_PARAM_TYPE__INTERVAL_EXEC) < f2_arg1:GetIdTimer(7100000 + 7008) and f2_local2 < f2_local9 - f2_arg1:GetAIAttackParam(7008, AI_ATTACK_PARAM_TYPE__MIN_OPTIMAL_DISTANCE) and f2_arg1:GetRandam_Float(0.1, 100) < f2_local7 then
            -- 重置前步专用计时器
            f2_arg1:StartIdTimer(7100000 + 7008)

            -- 添加前步子目标，前进距离为5
            f2_arg2:AddSubGoal(GOAL_EnemyStepFront, f2_arg2:GetLife(), f2_local0, 5)

            -- 重新添加接近目标子目标，继续接近到最大距离
            f2_arg2:AddSubGoal(GOAL_COMMON_ApproachTarget, f2_arg2:GetLife(), f2_local0, f2_local3, TARGET_SELF, f2_local11, f2_local10)

            -- 返回继续执行状态
            return GOAL_RESULT_Continue
        end
    end
    -- ==================================================================================
    -- 第五部分：后退过程中的后步插入逻辑
    -- ==================================================================================

    -- 检查当前是否正在执行"离开目标"子目标
    -- 如果满足条件，在后退过程中插入后步动作，使后退更加灵活
    if f2_arg1:IsActiveGoal(GOAL_COMMON_LeaveTarget) and f2_arg1:IsAIAttackParam(7004) and f2_local8 < f2_arg1:GetIdTimer(7110005) then
        -- 重置步法间隔计时器
        f2_arg1:StartIdTimer(7110005)

        -- 检查是否满足后步插入条件（所有条件必须同时满足）：
        -- 1. 后步动作对当前目标有效
        -- 2. 后步的执行间隔时间已过
        -- 3. 后步概率判定通过
        if IsValidEnemySelect(f2_arg0, f2_arg1, f2_arg2, 7004, f2_local0) and f2_arg1:GetAIAttackParam(7004, AI_ATTACK_PARAM_TYPE__INTERVAL_EXEC) < f2_arg1:GetIdTimer(7100000 + 7004) and f2_arg1:GetRandam_Float(0, 100) < f2_local6 then
            -- 重置后步专用计时器
            f2_arg1:StartIdTimer(7100000 + 7004)

            -- 清除当前所有子目标
            f2_arg2:ClearSubGoal()

            -- 添加后步子目标，后退距离为5
            f2_arg2:AddSubGoal(GOAL_EnemyStepBack, f2_arg2:GetLife(), f2_local0, 5)

            -- 重新添加离开目标子目标，继续后退到最小距离
            -- SetFailedEndOption：如果失败则继续执行父目标的下一个子目标
            f2_arg2:AddSubGoal(GOAL_COMMON_LeaveTarget, f2_arg2:GetLife(), f2_local0, f2_local2, TARGET_ENE_0, f2_local11, f2_local10):SetFailedEndOption(AI_GOAL_FAILED_END_OPT__PARENT_NEXT_SUB_GOAL)
        end
    end

    -- 返回继续执行状态
    return GOAL_RESULT_Continue

end

-- =======================================================================================
-- AI行为逻辑总结
-- =======================================================================================
--
-- 这个脚本实现了一个灵活的敌人接近/后退AI系统，主要特点：
--
-- 1. 距离管理：
--    - 最小距离 < 当前距离 < 最大距离：保持当前状态
--    - 当前距离 < 最小距离：触发后退逻辑
--    - 当前距离 > 最大距离：触发接近逻辑
--
-- 2. 移动策略：
--    - 根据距离和概率决定步行或奔跑
--    - 支持防御移动（动画ID 9910）
--    - 通过步法（前步/后步）增加移动多样性
--
-- 3. 步法系统：
--    - 前步（AI参数7008）：用于快速缩短距离
--    - 后步（AI参数7004）：用于快速拉开距离
--    - 步法间隔计时器（7110005）：控制步法执行频率
--    - 独立计时器（7100000+攻击ID）：控制每种步法的冷却时间
--
-- 4. 动态调整：
--    - Activate函数：初始化行为目标
--    - Update函数：在执行过程中动态插入步法，使移动更加灵活和不可预测
--
-- 5. 关键计时器说明：
--    - 7110005：步法间隔总计时器
--    - 7100004 (7100000 + 7004)：后步专用冷却计时器
--    - 7100008 (7100000 + 7008)：前步专用冷却计时器
--
-- 6. 使用场景：
--    - 适用于需要保持特定距离范围的敌人
--    - 适用于需要灵活移动、防御移动的敌人
--    - 可以通过调整参数来创建不同风格的敌人行为（激进/保守/平衡）
--
-- =======================================================================================
