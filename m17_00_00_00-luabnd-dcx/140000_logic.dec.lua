﻿RegisterTableLogic(140000)

Logic.Main = function (f1_arg0, f1_arg1)
    if COMMON_HiPrioritySetup(f1_arg1) then
        return true
    end
    if f1_arg1:GetStringIndexedNumber("firstSpRead") == 0 then
        f1_arg1:SetStringIndexedNumber("maxSp", f1_arg1:GetSp(TARGET_SELF))
        f1_arg1:SetStringIndexedNumber("firstSpRead", 1)
    end
    if f1_arg1:GetStringIndexedNumber("firstHpRead") == 0 then
        f1_arg1:SetStringIndexedNumber("maxHp", f1_arg1:GetHpRate(TARGET_SELF))
        f1_arg1:SetStringIndexedNumber("firstHpRead", 1)
    end
    if f1_arg1:HasSpecialEffectId(TARGET_SELF, 220020) then
        if f1_arg0.KugutsuAct(f1_arg1, goal) then
            return true
        end
    elseif f1_arg1:IsFinishTimer(AI_TIMER_TEKIMAWASHI_REACTION) == false then
        local f1_local0 = f1_arg1:GetExcelParam(AI_EXCEL_THINK_PARAM_TYPE__battleGoalID)
        if f1_local0 == GOAL_Kenkaku_weak_140000_Battle then
            JuzuReaction(f1_arg1, goal, 0, 20105)
        else
            JuzuReaction(f1_arg1, goal, 1, 20105)
        end
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


