-- ========================================
-- AI逻辑控制脚本 710000 (AI Logic Control Script 710000)
-- ========================================
-- 功能说明 (Functionality Description):
-- 1. 主逻辑控制: 管理AI的基础行为状态和特效监听
-- 2. 中断处理: 响应特定特效触发的中断事件
-- 3. 状态管理: 处理战斗、警戒、平静等不同AI状态
-- 4. 目标跟踪: 管理敌人目标的生死状态标记
-- ========================================

RegisterTableLogic(710000)  -- 注册AI逻辑表ID 710000 (Register AI logic table ID 710000)

-- ==========================================
-- 主逻辑函数 (Main Logic Function)
-- ==========================================
-- 参数说明 (Parameters):
-- f1_arg0: AI实体对象 (AI entity object)
-- f1_arg1: AI逻辑管理器 (AI logic manager)
-- 功能: 管理AI的主要行为逻辑和状态转换
Logic.Main = function (f1_arg0, f1_arg1)
    -- ========== 特效监听设置 (Special Effect Observation Setup) ==========
    f1_arg1:AddObserveSpecialEffectAttribute(TARGET_SELF, 220010)   -- 监听自身特效220010 (Observe self special effect 220010)
    f1_arg1:AddObserveSpecialEffectAttribute(TARGET_SELF, 107710)   -- 监听自身特效107710 (Observe self special effect 107710)
    f1_arg1:AddObserveSpecialEffectAttribute(TARGET_ENE_0, 110060)  -- 监听敌人死亡特效110060 (Observe enemy death effect 110060)
    f1_arg1:AddObserveSpecialEffectAttribute(TARGET_ENE_0, 110015)  -- 监听敌人复活特效110015 (Observe enemy revival effect 110015)

    -- 获取目标的最后HP值 (Get target's last HP value)
    local f1_local0 = f1_arg1:GetHpLastTarget()

    -- ========== 高优先级BOSS设置检查 (High Priority Boss Setup Check) ==========
    if COMMON_HiPrioritySetup(f1_arg1, COMMON_FLAG_BOSS) then
        return true  -- 如果高优先级设置成功，直接返回 (Return immediately if high priority setup succeeds)
    end

    -- ========== AI状态判断和处理 (AI State Detection and Processing) ==========
    if f1_arg1:IsFindState() or f1_arg1:IsBattleState() then
        -- 发现敌人或战斗状态 (Enemy found or battle state)
        if f1_arg1:HasSpecialEffectId(TARGET_SELF, 200004) then
            -- 拥有特效200004时的处理（空实现） (Processing when having special effect 200004 - empty implementation)
        elseif f1_arg1:HasSpecialEffectId(TARGET_SELF, 200002) and false then
            -- 拥有特效200002时的处理（条件永远为false，不会执行） (Processing when having special effect 200002 - condition always false)
        end
    elseif f1_arg1:IsCautionState() then
        -- 警戒状态 (Caution state)
        if f1_arg1:HasSpecialEffectId(TARGET_SELF, 200004) then
            -- 拥有特效200004时的处理（空实现） (Processing when having special effect 200004 - empty implementation)
        elseif f1_arg1:HasSpecialEffectId(TARGET_SELF, 200002) and false then
            -- 拥有特效200002时的处理（条件永远为false，不会执行） (Processing when having special effect 200002 - condition always false)
        end
    else
        -- 平静状态 (Peaceful state)
        if f1_arg1:HasSpecialEffectId(TARGET_SELF, 200004) then
            -- 拥有特效200004时的处理（空实现） (Processing when having special effect 200004 - empty implementation)
        elseif f1_arg1:HasSpecialEffectId(TARGET_SELF, 200002) then
            -- 拥有特效200002时的处理（空实现） (Processing when having special effect 200002 - empty implementation)
        else
            -- 默认情况（空实现） (Default case - empty implementation)
        end
        -- 重置目标死亡标记为0 (Reset target death flag to 0)
        f1_arg1:SetStringIndexedNumber("TargetDeadFlag", 0)
    end

    -- ========== 通用BOSS设置 (Common Boss Setup) ==========
    COMMON_EzSetup(f1_arg1, COMMON_FLAG_BOSS)  -- 执行通用的简易BOSS设置 (Execute common easy boss setup)

end

-- ==========================================
-- 中断处理函数 (Interrupt Handler Function)
-- ==========================================
-- 参数说明 (Parameters):
-- f2_arg0: AI实体对象 (AI entity object)
-- f2_arg1: AI逻辑管理器 (AI logic manager)
-- f2_arg2: 目标管理器 (Target manager)
-- 功能: 处理特效激活引起的中断事件，响应特定游戏状态变化
Logic.Interrupt = function (f2_arg0, f2_arg1, f2_arg2)
    -- 获取当前激活的特效中断类型 (Get current activated special effect interrupt type)
    local f2_local0 = f2_arg1:GetSpecialEffectActivateInterruptType(0)

    -- ========== 特效激活中断处理 (Special Effect Activation Interrupt Processing) ==========
    if f2_arg1:IsInterupt(INTERUPT_ActivateSpecialEffect) then
        if f2_local0 == 220010 then
            -- 特效220010激活：清除敌人目标 (Special effect 220010 activated: Clear enemy target)
            f2_arg1:ClearEnemyTarget()
            return true  -- 中断处理成功 (Interrupt handled successfully)

        elseif f2_local0 == 107710 then
            -- 特效107710激活：重新规划AI行为 (Special effect 107710 activated: Replanning AI behavior)
            f2_arg1:Replanning()
            return true  -- 中断处理成功 (Interrupt handled successfully)

        elseif f2_arg1:GetSpecialEffectActivateInterruptType(0) == 110060 then
            -- 特效110060激活：敌人死亡处理 (Special effect 110060 activated: Enemy death processing)
            f2_arg1:SetStringIndexedNumber("targetDeadFlag", 1)  -- 设置目标死亡标记为1 (Set target death flag to 1)
            f2_arg2:ClearSubGoal()  -- 清除所有子目标 (Clear all sub-goals)
            -- 添加接近目标的行为，最大距离9999 (Add approach target behavior with max distance 9999)
            f2_arg2:AddSubGoal(GOAL_COMMON_ApproachTarget, 1, TARGET_ENE_0, 9999, TARGET_SELF, true, -1)
            return true  -- 中断处理成功 (Interrupt handled successfully)

        elseif f2_arg1:GetSpecialEffectActivateInterruptType(0) == 110015 then
            -- 特效110015激活：敌人复活处理 (Special effect 110015 activated: Enemy revival processing)
            f2_arg1:SetStringIndexedNumber("TargetDeadFlag", 0)  -- 重置目标死亡标记为0 (Reset target death flag to 0)
            f2_arg2:ClearSubGoal()  -- 清除所有子目标 (Clear all sub-goals)
            -- 添加等待行为 (Add wait behavior)
            f2_arg2:AddSubGoal(GOAL_COMMON_Wait, 0, TARGET_ENE_0, 0, 0, 0)
            return true  -- 中断处理成功 (Interrupt handled successfully)
        end
    end

    return false  -- 没有匹配的中断处理，返回false (No matching interrupt handler, return false)

end


