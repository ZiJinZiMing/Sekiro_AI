RegisterTableLogic(101000)

Logic.Main = function (f1_arg0, f1_arg1)
    f1_arg1:AddObserveSpecialEffectAttribute(TARGET_SELF, 200299)
    f1_arg1:AddObserveRegion(30, TARGET_SELF, COMMON_REGION_FORCE_WALK_M11_0)
    if f1_arg1:IsLockOnTarget(TARGET_LOCALPLAYER, TARGET_SELF) and f1_arg1:HasSpecialEffectId(TARGET_SELF, 3101110) then
        f1_arg1:SetEventFlag(11125650, true)
    end
    if COMMON_HiPrioritySetup(f1_arg1, COMMON_FLAG_EXPERIMENT) then
        return true
    end
    if f1_arg1:HasSpecialEffectId(TARGET_SELF, 220020) then
        if f1_arg0.KugutsuAct(f1_arg1, goal) then
            return true
        end
    elseif f1_arg1:IsFinishTimer(AI_TIMER_TEKIMAWASHI_REACTION) == false then
        JuzuReaction(f1_arg1, goal, 0, 20105, 20107)
        return true
    end
    local f1_local0 = f1_arg1:GetEventRequest()
    if f1_local0 == 10 then
        f1_arg1:SetEventMoveTarget(9622490)
        local f1_local1 = f1_arg1:GetDist_Point(POINT_EVENT)
        if f1_local1 > 3 then
            f1_arg1:AddTopGoal(GOAL_COMMON_ApproachTarget, 3, POINT_EVENT, 0, TARGET_SELF, false, -1)
            if false then
            end
        end
    elseif f1_local0 == 11 then
        f1_arg1:SetEventMoveTarget(9622118)
        f1_arg1:AddTopGoal(GOAL_COMMON_ApproachTarget, 3, POINT_EVENT, 0, TARGET_SELF, true, -1)
    elseif f1_local0 == 12 then
        if not f1_arg1:HasSpecialEffectId(TARGET_SELF, 200004) then
            f1_arg1:AddTopGoal(GOAL_COMMON_AttackTunableSpin, 1, 1040, TARGET_ENE_0, 9999, 0, 0, 0, 0)
        end
        f1_arg1:SetEventMoveTarget(9622492)
        local f1_local1 = f1_arg1:GetDist_Point(POINT_EVENT)
        if f1_local1 > 3 then
            f1_arg1:AddTopGoal(GOAL_COMMON_ApproachTarget, 3, POINT_EVENT, 0, TARGET_SELF, false, -1)
            if false then
            end
        end
    elseif f1_local0 == 13 then
        f1_arg1:SetEventMoveTarget(1112390)
        f1_arg1:AddTopGoal(GOAL_COMMON_ApproachTarget, 3, POINT_EVENT, 0, TARGET_SELF, false, -1)
    elseif f1_local0 == 20 then
        f1_arg1:AddTopGoal(GOAL_COMMON_Turn, 3, TARGET_LOCALPLAYER, 45, -1, GOAL_RESULT_Success, true)
    elseif f1_local0 == 21 then
        f1_arg1:SetEventMoveTarget(1122522)
        local f1_local1 = f1_arg1:GetDist_Point(POINT_EVENT)
        if f1_local1 > 3 then
            f1_arg1:AddTopGoal(GOAL_COMMON_ApproachTarget, 3, POINT_EVENT, 0, TARGET_SELF, false, -1)
            if false then
            end
        end
    elseif f1_local0 == 22 then
        f1_arg1:SetEventMoveTarget(1122523)
        local f1_local1 = f1_arg1:GetDist_Point(POINT_EVENT)
        if f1_local1 > 3 then
            f1_arg1:AddTopGoal(GOAL_COMMON_ApproachTarget, 3, POINT_EVENT, 0, TARGET_SELF, false, -1)
            if false then
            end
        end
    elseif f1_local0 == 30 then
        if f1_arg1:GetNumber(30) == 0 then
            f1_arg1:AddTopGoal(GOAL_COMMON_EndureAttack, 1, 20002, TARGET_ENE_0, 9999, 0)
            f1_arg1:SetNumber(30, 1)
        end
    elseif f1_local0 == 31 then
        if f1_arg1:GetNumber(30) == 0 then
            f1_arg1:AddTopGoal(GOAL_COMMON_EndureAttack, 1, 20003, TARGET_ENE_0, 9999, 0)
            f1_arg1:SetNumber(30, 1)
        end
    elseif f1_arg1:HasSpecialEffectId(TARGET_SELF, 200030) and not f1_arg1:HasSpecialEffectId(TARGET_SELF, 200050) and f1_arg1:HasSpecialEffectId(TARGET_SELF, 200051) then
    end
    COMMON_EzSetup(f1_arg1, COMMON_FLAG_EXPERIMENT)
    
end

Logic.Interrupt = function (f2_arg0, f2_arg1, f2_arg2)
    local f2_local0 = f2_arg1:GetSpecialEffectActivateInterruptType(0)
    if f2_arg1:IsInterupt(INTERUPT_EventRequest) then
        local f2_local1 = f2_arg1:GetEventRequest()
        if f2_local1 == 12 then
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


