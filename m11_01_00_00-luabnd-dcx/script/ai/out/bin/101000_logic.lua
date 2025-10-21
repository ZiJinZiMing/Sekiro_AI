-- ====================================================================================================
-- 101000_logic.lua
-- AI逻辑ID：101000
-- 地图区域：m11_01_00_00（苇名城）
-- 功能说明：处理特定敌人/NPC的AI行为逻辑，包括事件响应、傀儡控制和数珠反应
-- ====================================================================================================

RegisterTableLogic(101000)

-- ====================================================================================================
-- 主逻辑函数
-- 参数：
--   f1_arg0: AI对象自身引用
--   f1_arg1: Goal对象，用于控制AI行为
-- 返回值：
--   布尔值，表示是否完成本次逻辑处理
-- ====================================================================================================
Logic.Main = function (f1_arg0, f1_arg1)
    -- 添加观察器：监视自身的特效属性200299（可能用于状态切换）
    f1_arg1:AddObserveSpecialEffectAttribute(TARGET_SELF, 200299)

    -- 添加区域观察器：观察区域30，用于强制步行区域检测
    f1_arg1:AddObserveRegion(30, TARGET_SELF, COMMON_REGION_FORCE_WALK_M11_0)

    -- 锁定触发检测：玩家锁定自身且拥有特效3101110时，设置事件标志11125650
    if f1_arg1:IsLockOnTarget(TARGET_LOCALPLAYER, TARGET_SELF) and f1_arg1:HasSpecialEffectId(TARGET_SELF, 3101110) then
        f1_arg1:SetEventFlag(11125650, true)
    end

    -- 高优先级设置检查：实验模式标志处理
    if COMMON_HiPrioritySetup(f1_arg1, COMMON_FLAG_EXPERIMENT) then
        return true
    end

    -- 傀儡状态处理：检测到傀儡特效（220020）时，执行傀儡行为
    if f1_arg1:HasSpecialEffectId(TARGET_SELF, 220020) then
        if f1_arg0.KugutsuAct(f1_arg1, goal) then
            return true
        end
    -- 数珠反应处理：定时器未完成时触发数珠反应
    elseif f1_arg1:IsFinishTimer(AI_TIMER_TEKIMAWASHI_REACTION) == false then
        -- 触发数珠反应，参数：0（反应类型）、20105和20107（技能ID）
        JuzuReaction(f1_arg1, goal, 0, 20105, 20107)
        return true
    end
    -- ====================================================================================================
    -- 事件请求系统：根据事件ID执行不同的行为逻辑
    -- ====================================================================================================
    local f1_local0 = f1_arg1:GetEventRequest()

    -- 事件10：移动到目标点9622490
    if f1_local0 == 10 then
        f1_arg1:SetEventMoveTarget(9622490)
        local f1_local1 = f1_arg1:GetDist_Point(POINT_EVENT)
        -- 如果距离超过3米，添加接近目标的目标行为（步行模式）
        if f1_local1 > 3 then
            f1_arg1:AddTopGoal(GOAL_COMMON_ApproachTarget, 3, POINT_EVENT, 0, TARGET_SELF, false, -1)
            if false then
            end
        end

    -- 事件11：移动到目标点9622118（奔跑模式）
    elseif f1_local0 == 11 then
        f1_arg1:SetEventMoveTarget(9622118)
        f1_arg1:AddTopGoal(GOAL_COMMON_ApproachTarget, 3, POINT_EVENT, 0, TARGET_SELF, true, -1)

    -- 事件12：执行攻击动作并移动到目标点9622492
    elseif f1_local0 == 12 then
        -- 检查是否没有特效200004，如果没有则执行攻击
        if not f1_arg1:HasSpecialEffectId(TARGET_SELF, 200004) then
            -- 添加可调旋转攻击目标，使用攻击ID 1040，攻击范围9999
            f1_arg1:AddTopGoal(GOAL_COMMON_AttackTunableSpin, 1, 1040, TARGET_ENE_0, 9999, 0, 0, 0, 0)
        end
        f1_arg1:SetEventMoveTarget(9622492)
        local f1_local1 = f1_arg1:GetDist_Point(POINT_EVENT)
        -- 如果距离超过3米，接近目标点
        if f1_local1 > 3 then
            f1_arg1:AddTopGoal(GOAL_COMMON_ApproachTarget, 3, POINT_EVENT, 0, TARGET_SELF, false, -1)
            if false then
            end
        end

    -- 事件13：移动到目标点1112390
    elseif f1_local0 == 13 then
        f1_arg1:SetEventMoveTarget(1112390)
        f1_arg1:AddTopGoal(GOAL_COMMON_ApproachTarget, 3, POINT_EVENT, 0, TARGET_SELF, false, -1)

    -- 事件20：转向玩家
    elseif f1_local0 == 20 then
        -- 转向本地玩家，角度容差45度，等待成功结果
        f1_arg1:AddTopGoal(GOAL_COMMON_Turn, 3, TARGET_LOCALPLAYER, 45, -1, GOAL_RESULT_Success, true)

    -- 事件21：移动到目标点1122522
    elseif f1_local0 == 21 then
        f1_arg1:SetEventMoveTarget(1122522)
        local f1_local1 = f1_arg1:GetDist_Point(POINT_EVENT)
        if f1_local1 > 3 then
            f1_arg1:AddTopGoal(GOAL_COMMON_ApproachTarget, 3, POINT_EVENT, 0, TARGET_SELF, false, -1)
            if false then
            end
        end

    -- 事件22：移动到目标点1122523
    elseif f1_local0 == 22 then
        f1_arg1:SetEventMoveTarget(1122523)
        local f1_local1 = f1_arg1:GetDist_Point(POINT_EVENT)
        if f1_local1 > 3 then
            f1_arg1:AddTopGoal(GOAL_COMMON_ApproachTarget, 3, POINT_EVENT, 0, TARGET_SELF, false, -1)
            if false then
            end
        end

    -- 事件30：执行承受攻击动作（攻击ID 20002）
    elseif f1_local0 == 30 then
        if f1_arg1:GetNumber(30) == 0 then
            -- 添加承受攻击目标，使用动画20002，攻击范围9999
            f1_arg1:AddTopGoal(GOAL_COMMON_EndureAttack, 1, 20002, TARGET_ENE_0, 9999, 0)
            f1_arg1:SetNumber(30, 1)  -- 标记已执行
        end

    -- 事件31：执行承受攻击动作（攻击ID 20003）
    elseif f1_local0 == 31 then
        if f1_arg1:GetNumber(30) == 0 then
            -- 添加承受攻击目标，使用动画20003，攻击范围9999
            f1_arg1:AddTopGoal(GOAL_COMMON_EndureAttack, 1, 20003, TARGET_ENE_0, 9999, 0)
            f1_arg1:SetNumber(30, 1)  -- 标记已执行
        end

    -- 特效组合检测：特定状态的复合条件判断
    elseif f1_arg1:HasSpecialEffectId(TARGET_SELF, 200030) and not f1_arg1:HasSpecialEffectId(TARGET_SELF, 200050) and f1_arg1:HasSpecialEffectId(TARGET_SELF, 200051) then
        -- 空处理块：满足条件时不执行任何操作
    end

    -- 通用AI设置：使用实验模式标志进行标准AI初始化
    COMMON_EzSetup(f1_arg1, COMMON_FLAG_EXPERIMENT)
    
end

-- ====================================================================================================
-- 中断处理函数
-- 参数：
--   f2_arg0: AI对象自身引用
--   f2_arg1: Goal对象
--   f2_arg2: 中断参数
-- 返回值：
--   布尔值，表示是否处理了中断
-- 功能说明：监听并处理AI行为的中断事件
-- ====================================================================================================
Logic.Interrupt = function (f2_arg0, f2_arg1, f2_arg2)
    -- 获取特效激活的中断类型（参数0）
    local f2_local0 = f2_arg1:GetSpecialEffectActivateInterruptType(0)

    -- 检测是否有事件请求中断
    if f2_arg1:IsInterupt(INTERUPT_EventRequest) then
        local f2_local1 = f2_arg1:GetEventRequest()
        -- 如果是事件12，触发重新规划
        if f2_local1 == 12 then
            f2_arg1:Replanning()  -- 重新规划AI行为目标
        end
    end

    -- 返回false表示没有处理中断，继续执行其他逻辑
    return false

end

-- ====================================================================================================
-- 傀儡行为函数
-- 参数：
--   f3_arg0: Goal对象
--   f3_arg1: 未使用参数
-- 返回值：
--   布尔值，true表示成功激活傀儡行为，false表示不满足激活条件
-- 功能说明：当AI处于傀儡状态时，控制其战斗行为
-- ====================================================================================================
Logic.KugutsuAct = function (f3_arg0, f3_arg1)
    -- 检查AI是否处于非战斗状态且非发现状态
    if f3_arg0:IsBattleState() == false and f3_arg0:IsFindState() == false then
        -- 添加傀儡战斗目标（优先级-1表示最高优先级）
        f3_arg0:AddTopGoal(GOAL_KugutsuAct_20000_Battle, -1)
        return true  -- 成功激活傀儡行为
    end

    -- 不满足条件，不激活傀儡行为
    return false

end


