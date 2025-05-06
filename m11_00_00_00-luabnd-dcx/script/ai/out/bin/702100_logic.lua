RegisterTableLogic(702100)

Logic.Main = function (f1_arg0, f1_arg1)
    f1_arg1:AddObserveSpecialEffectAttribute(TARGET_ENE_0, 110060)
    f1_arg1:AddObserveSpecialEffectAttribute(TARGET_ENE_0, 110015)
    _COMMON_SetBattleGoal(f1_arg1)
    
end

Logic.Interrupt = function (f2_arg0, f2_arg1, f2_arg2)
    local f2_local0 = f2_arg1:GetSpecialEffectActivateInterruptType(0)
    if f2_arg1:IsInterupt(INTERUPT_ActivateSpecialEffect) then
        if f2_arg1:GetSpecialEffectActivateInterruptType(0) == 110060 then
            f2_arg1:SetStringIndexedNumber("targetDeadFlag", 1)
            f2_arg2:ClearSubGoal()
            f2_arg2:AddSubGoal(GOAL_COMMON_ApproachTarget, 1, TARGET_ENE_0, 9999, TARGET_SELF, true, -1)
            return true
        elseif f2_arg1:GetSpecialEffectActivateInterruptType(0) == 110015 then
            f2_arg1:SetStringIndexedNumber("TargetDeadFlag", 0)
            f2_arg2:ClearSubGoal()
            f2_arg2:AddSubGoal(GOAL_COMMON_Wait, 0, TARGET_ENE_0, 0, 0, 0)
            return true
        end
    end
    return false
    
end


