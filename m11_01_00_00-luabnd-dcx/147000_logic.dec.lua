﻿RegisterTableLogic(147000)

Logic.Main = function (f1_arg0, f1_arg1)
    if COMMON_HiPrioritySetup(f1_arg1) then
        return true
    end
    local f1_local0 = f1_arg1:GetEventRequest()
    if f1_arg1:HasSpecialEffectId(TARGET_SELF, 3147100) then
        f1_arg1:AddTopGoal(GOAL_COMMON_AttackTunableSpin, 3, 3200, TARGET_SELF, 9999, 0, 0, 0, 0)
        return true
    end
    if f1_local0 == 10 then
        f1_arg1:AddTopGoal(GOAL_COMMON_AttackTunableSpin, 10, 3220, TARGET_ENE_0, 9999, 0, 0, 0, 0)
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
    return false
    
end

Logic.KugutsuAct = function (f3_arg0, f3_arg1)
    if f3_arg0:IsBattleState() == false and f3_arg0:IsFindState() == false then
        f3_arg0:AddTopGoal(GOAL_KugutsuAct_20000_Battle, -1)
        return true
    end
    return false
    
end


