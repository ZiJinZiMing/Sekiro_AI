RegisterTableLogic(136000)

Logic.Main = function (f1_arg0, f1_arg1)
    if COMMON_HiPrioritySetup(f1_arg1) then
        return true
    end
    if f1_arg1:HasSpecialEffectId(TARGET_SELF, 220020) then
        if f1_arg1:HasSpecialEffectId(TARGET_SELF, 3136200) then
            f1_arg1:SetEventMoveTarget(2002241)
            if f1_arg1:GetDist(POINT_EVENT) >= 1 then
                f1_arg1:AddTopGoal(GOAL_COMMON_ApproachTarget, 10, POINT_EVENT, 1, TARGET_SELF, false, -1)
            else
                f1_arg1:AddTopGoal(GOAL_COMMON_Turn, 0.5, POINT_EVENT, 0, 0, 0)
                f1_arg1:AddTopGoal(GOAL_COMMON_Wait, 3, TARGET_SELF, 0, 0, 0)
            end
        elseif f1_arg0.KugutsuAct(f1_arg1, goal) then
            return true
        end
    elseif f1_arg1:IsFinishTimer(AI_TIMER_TEKIMAWASHI_REACTION) == false then
        JuzuReaction(f1_arg1, goal, 0, 20100)
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


