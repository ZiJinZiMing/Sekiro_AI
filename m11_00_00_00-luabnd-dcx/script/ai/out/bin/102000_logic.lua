RegisterTableLogic(102000)

Logic.Main = function (f1_arg0, f1_arg1)
    f1_arg1:AddObserveRegion(30, TARGET_SELF, COMMON_REGION_FORCE_WALK_M11_0)
    if COMMON_HiPrioritySetup(f1_arg1) then
        return true
    end
    if f1_arg1:HasSpecialEffectId(TARGET_SELF, 220020) then
        if f1_arg0.KugutsuAct(f1_arg1, goal) then
            return true
        end
    elseif f1_arg1:IsFinishTimer(AI_TIMER_TEKIMAWASHI_REACTION) == false then
        JuzuReaction(f1_arg1, goal, 1, 20105)
        return true
    end
    if f1_arg1:GetStringIndexedNumber("firstSpRead") == 0 then
        f1_arg1:SetStringIndexedNumber("maxSp", f1_arg1:GetSp(TARGET_SELF))
        f1_arg1:SetStringIndexedNumber("firstSpRead", 1)
    end
    local f1_local0 = f1_arg1:GetRandam_Int(1, 100)
    local f1_local1 = f1_arg1:GetHpLastTarget()
    local f1_local2 = f1_arg1:GetEventRequest()
    if f1_local2 == 10 then
        if not f1_arg1:HasSpecialEffectId(TARGET_SELF, 200004) then
            f1_arg1:AddTopGoal(GOAL_COMMON_AttackTunableSpin, 1, 1040, TARGET_ENE_0, 9999, 0, 0, 0, 0)
        end
        f1_arg1:SetEventMoveTarget(9622492)
        f1_arg1:AddTopGoal(GOAL_COMMON_ApproachTarget, 0.5, POINT_EVENT, 0, TARGET_SELF, true, -1)
        f1_arg1:SetStringIndexedNumber("findFlag", 1)
    else
        COMMON_EzSetup(f1_arg1)
    end
    
end

Logic.Interrupt = function (f2_arg0, f2_arg1, f2_arg2)
    local f2_local0 = f2_arg1:GetSpecialEffectActivateInterruptType(0)
    if f2_arg1:IsInterupt(INTERUPT_EventRequest) then
        local f2_local1 = f2_arg1:GetEventRequest()
        if f2_local1 == 10 then
            f2_arg1:Replanning()
        end
    end
    return false
    
end

Logic.KugutsuAct = function (f3_arg0, f3_arg1)
    if f3_arg0:IsBattleState() == false and f3_arg0:IsFindState() == false then
        f3_arg0:AddTopGoal(GOAL_KugutsuAct_20000_Battle, -1)
        return true
    end
    return false
    
end


