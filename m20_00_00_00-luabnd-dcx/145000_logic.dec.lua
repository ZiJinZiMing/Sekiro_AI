﻿RegisterTableLogic(145000)

Logic.Main = function (f1_arg0, f1_arg1)
    local f1_local0 = f1_arg1:GetEventRequest()
    local f1_local1 = f1_arg1:GetEventRequest(1)
    if f1_arg1:HasSpecialEffectId(TARGET_SELF, 3145010) then
        if f1_arg1:GetNpcThinkParamID() == 14500010 then
            f1_arg1:AddObserveRegion(1, TARGET_ENE_0, 1112266)
        elseif f1_arg1:GetNpcThinkParamID() == 14500011 then
            f1_arg1:AddObserveRegion(1, TARGET_ENE_0, 1112549)
        end
        f1_arg1:AddTopGoal(GOAL_COMMON_Wait, 10, TARGET_SELF, 0, 0, 0)
    end
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
    COMMON_EzSetup(f1_arg1)
    
end

Logic.Interrupt = function (f2_arg0, f2_arg1, f2_arg2)
    if f2_arg1:IsInterupt(INTERUPT_Inside_ObserveArea) and f2_arg1:IsInsideObserve(1) then
        f2_arg2:ClearSubGoal()
        f2_arg1:AddTopGoal(GOAL_COMMON_AttackImmediateAction, 1, 3220, TARGET_ENE_0, 9999, 0)
        f2_arg1:DeleteObserve(1)
        return true
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


