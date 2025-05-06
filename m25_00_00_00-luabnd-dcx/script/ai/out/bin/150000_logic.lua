RegisterTableLogic(150000)

Logic.Main = function (f1_arg0, f1_arg1)
    if f1_arg1:HasSpecialEffectId(TARGET_SELF, 3150100) then
        if f1_arg1:IsFindState() or f1_arg1:IsBattleState() then
            _COMMON_SetBattleGoal(f1_arg1)
            f1_arg1:SetStringIndexedNumber("findFlag", 1)
            return true
        else
            goal:AddTopGoal(GOAL_COMMON_ComboAttackTunableSpin, 0.5, 20010, TARGET_ENE_0, 9999, 0, 0, 0, 0)
            return true
        end
    else
        if COMMON_HiPrioritySetup(f1_arg1) then
            return true
        end
        if f1_arg1:HasSpecialEffectId(TARGET_SELF, 220020) then
            if f1_arg0.KugutsuAct(f1_arg1, goal) then
                return true
            end
        elseif f1_arg1:IsFinishTimer(AI_TIMER_TEKIMAWASHI_REACTION) == false then
            JuzuReaction(f1_arg1, goal, 0, 20105)
            return true
        end
        COMMON_EzSetup(f1_arg1)
    end
    
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


