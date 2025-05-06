﻿RegisterTableGoal(GOAL_EnemyDeriveAttack, "GOAL_EnemyDeriveAttack")
ENABLE_COMBO_ATK_CANCEL(GOAL_EnemyDeriveAttack)
REGISTER_GOAL_NO_SUB_GOAL(GOAL_EnemyDeriveAttack, true)
Goal.Update = Update_FinishOnNoSubGoal

Goal.Activate = function (f1_arg0, f1_arg1, f1_arg2)
    local f1_local0 = f1_arg2:GetParam(4)
    for f1_local1 = 0, 15, 1 do
        f1_arg1:SetStringIndexedArray("DeriveAttackMemory", f1_local1, 9999999)
    end
    f1_arg2:AddSubGoal(GOAL_EnemyDeriveAttackMain, f1_arg2:GetLife(), f1_arg2:GetParam(0), f1_arg2:GetParam(1), f1_arg2:GetParam(2), f1_arg2:GetParam(3), 1, f1_local0)
    

end

RegisterTableGoal(GOAL_EnemyDeriveAttackMain, "GOAL_EnemyDeriveAttackMain")
ENABLE_COMBO_ATK_CANCEL(GOAL_EnemyDeriveAttackMain)
REGISTER_GOAL_NO_SUB_GOAL(GOAL_EnemyDeriveAttackMain, true)
REGISTER_DBG_GOAL_PARAM(GOAL_EnemyDeriveAttackMain, 0, "対象", 0)
REGISTER_DBG_GOAL_PARAM(GOAL_EnemyDeriveAttackMain, 1, "攻撃", 0)
REGISTER_DBG_GOAL_PARAM(GOAL_EnemyDeriveAttackMain, 2, "派生確率", 0)
REGISTER_DBG_GOAL_PARAM(GOAL_EnemyDeriveAttackMain, 3, "最大段数", 0)
REGISTER_DBG_GOAL_PARAM(GOAL_EnemyDeriveAttackMain, 4, "現在段数", 0)
REGISTER_DBG_GOAL_PARAM(GOAL_EnemyDeriveAttackMain, 5, "同じ攻撃を出さないか", 0)

Goal.Activate = function (f2_arg0, f2_arg1, f2_arg2)
    local f2_local0 = f2_arg2:GetParam(0)
    local f2_local1 = f2_arg2:GetParam(1)
    local f2_local2 = f2_arg2:GetParam(2)
    local f2_local3 = f2_arg2:GetParam(3)
    local f2_local4 = f2_arg2:GetParam(4)
    if f2_local3 <= 0 or f2_local4 > 16 then
        return
    end
    local f2_local5 = f2_arg2:GetParam(5)
    if f2_local5 == false then
        f2_arg1:SetStringIndexedArray("DeriveAttackMemory", 0 + f2_local4 - 1, f2_local1)
    end
    local f2_local6 = f2_arg1:GetDist(f2_local0)
    if f2_local1 <= 0 then
        return
    end
    if f2_local6 < f2_arg1:GetAIAttackParam(f2_local1, AI_ATTACK_PARAM_TYPE__MIN_OPTIMAL_DISTANCE) or f2_arg1:GetAIAttackParam(f2_local1, AI_ATTACK_PARAM_TYPE__MAX_OPTIMAL_DISTANCE) < f2_local6 then
        return
    end
    local f2_local7 = 0
    f2_arg2:SetNumber(2, 0)
    if f2_arg1:GetRandam_Float(0, 100) < f2_local2 then
        f2_local7 = 1
        f2_arg2:SetNumber(2, 1)
    end
    if f2_local1 == 7008 then
        f2_arg2:AddSubGoal(GOAL_EnemyStepFront, f2_arg2:GetLife(), f2_local0, 6.5)
    elseif f2_arg1:GetAIAttackParam(f2_local1, AI_ATTACK_PARAM_TYPE__IS_FIRST_ATTACK) == 1 then
        if f2_local7 == 1 then
            f2_arg2:AddSubGoal(GOAL_EnemyTunableComboAttack, f2_arg2:GetLife(), f2_local0, f2_local1)
        else
            f2_arg2:AddSubGoal(GOAL_EnemyTunableAttack, f2_arg2:GetLife(), f2_local0, f2_local1)
        end
    elseif f2_local7 == 1 then
        f2_arg2:AddSubGoal(GOAL_EnemyComboRepeat, f2_arg2:GetLife(), f2_local0, f2_local1)
    else
        f2_arg2:AddSubGoal(GOAL_EnemyComboFinal, f2_arg2:GetLife(), f2_local0, f2_local1)
    end
    f2_arg2:SetNumber(0, 0)
    
end

Goal.Update = function (f3_arg0, f3_arg1, f3_arg2)
    local f3_local0 = nil
    if f3_arg2:GetNumber(2) == 1 then
        if f3_arg2:GetNumber(0) == 0 and f3_arg1:IsEnableComboAttack() then
            f3_arg2:SetNumber(0, 1)
            f3_arg2:SetNumber(1, 1)
            f3_local0 = SelectDeriveAttack(f3_arg0, f3_arg1, f3_arg2, f3_arg2:GetParam(1), f3_arg2:GetParam(0), 0)
            if f3_local0 ~= 9999999 and f3_arg1:GetAIAttackParam(f3_local0, AI_ATTACK_PARAM_TYPE__IS_FIRST_ATTACK) == 0 then
                f3_arg2:AddSubGoal(GOAL_EnemyDeriveAttackMain, f3_arg2:GetLife(), f3_arg2:GetParam(0), f3_local0, f3_arg2:GetParam(2), f3_arg2:GetParam(3) - 1, f3_arg2:GetParam(4) + 1)
            else
                f3_arg2:AddSubGoal(GOAL_EnemyDeriveAttackSub, f3_arg2:GetLife(), f3_arg2:GetParam(0), f3_arg2:GetParam(1), f3_arg2:GetParam(2), f3_arg2:GetParam(3) - 1, f3_arg2:GetParam(4) + 1)
            end
        end
        if f3_arg2:GetNumber(1) == 0 and f3_arg1:IsEnableCancelAttack() then
            f3_arg2:SetNumber(1, 1)
            f3_arg2:SetNumber(0, 1)
            f3_arg2:AddSubGoal(GOAL_EnemyDeriveAttackSub, f3_arg2:GetLife(), f3_arg2:GetParam(0), f3_arg2:GetParam(1), f3_arg2:GetParam(2), f3_arg2:GetParam(3) - 1, f3_arg2:GetParam(4) + 1)
        end
    end
    if f3_arg2:GetSubGoalNum() <= 0 then
        return GOAL_RESULT_Success
    end
    return GOAL_RESULT_Continue
    
end

RegisterTableGoal(GOAL_EnemyDeriveAttackSub, "GOAL_EnemyDeriveAttackSub")
REGISTER_GOAL_NO_SUB_GOAL(GOAL_EnemyDeriveAttackSub, true)
REGISTER_DBG_GOAL_PARAM(GOAL_EnemyDeriveAttackSub, 0, "対象", 0)
REGISTER_DBG_GOAL_PARAM(GOAL_EnemyDeriveAttackSub, 1, "攻撃", 0)
REGISTER_DBG_GOAL_PARAM(GOAL_EnemyDeriveAttackSub, 2, "派生確率", 0)
REGISTER_DBG_GOAL_PARAM(GOAL_EnemyDeriveAttackSub, 3, "最大段数", 0)

Goal.Activate = function (f4_arg0, f4_arg1, f4_arg2)
    local f4_local0 = SelectDeriveAttack(f4_arg0, f4_arg1, f4_arg2, f4_arg2:GetParam(1), f4_arg2:GetParam(0), 1)
    if f4_local0 ~= 9999999 then
        f4_arg2:AddSubGoal(GOAL_EnemyDeriveAttackMain, f4_arg2:GetLife(), f4_arg2:GetParam(0), f4_local0, f4_arg2:GetParam(2), f4_arg2:GetParam(3), f4_arg2:GetParam(4))
    end
    
end

Goal.Update = function (f5_arg0, f5_arg1, f5_arg2)
    if f5_arg2:GetSubGoalNum() <= 0 then
        f5_arg1:TurnTo(TARGET_SELF)
        return GOAL_RESULT_Success
    end
    return GOAL_RESULT_Continue
    
end

RegisterTableGoal(GOAL_EnemyDeriveAttackDummy, "GOAL_EnemyDeriveAttackDummy")
Goal.Update = GOAL_EnemyDeriveAttackDummy

Goal.Activate = function (f6_arg0, f6_arg1, f6_arg2)
    
end


