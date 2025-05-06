RegisterTableLogic(702000)

Logic.Main = function (f1_arg0, f1_arg1)
    f1_arg1:AddObserveSpecialEffectAttribute(TARGET_SELF, 220010)
    f1_arg1:AddObserveSpecialEffectAttribute(TARGET_SELF, 107710)
    f1_arg1:AddObserveSpecialEffectAttribute(TARGET_ENE_0, 110060)
    f1_arg1:AddObserveSpecialEffectAttribute(TARGET_ENE_0, 110015)
    f1_arg1:AddObserveSpecialEffectAttribute(TARGET_SELF, 107900)
    f1_arg1:AddObserveSpecialEffectAttribute(TARGET_SELF, 230541)
    if COMMON_HiPrioritySetup(f1_arg1) then
        return true
    end
    if f1_arg1:GetStringIndexedNumber("firstSpRead") == 0 then
        f1_arg1:SetStringIndexedNumber("maxSp", f1_arg1:GetSp(TARGET_SELF))
        f1_arg1:SetStringIndexedNumber("firstSpRead", 1)
    end
    COMMON_EzSetup(f1_arg1, COMMON_FLAG_BOSS)
    
end

Logic.Interrupt = function (f2_arg0, f2_arg1, f2_arg2)
    local f2_local0 = f2_arg1:GetSpecialEffectActivateInterruptType(0)
    if f2_arg1:IsInterupt(INTERUPT_ActivateSpecialEffect) then
        if f2_local0 == 220010 then
            f2_arg1:ClearEnemyTarget()
            return true
        elseif f2_local0 == 107710 then
            f2_arg1:Replanning()
            return true
        elseif f2_local0 == 230541 then
            return f2_arg0.YubibueInterruptTiming(f2_arg1, f2_arg2)
        elseif f2_arg1:GetSpecialEffectActivateInterruptType(0) == 110060 then
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

Logic.YubibueInterruptTiming = function (f3_arg0, f3_arg1, f3_arg2)
    if f3_arg0:GetNumber(9) >= 3 - 1 then
        f3_arg1:ClearSubGoal()
        f3_arg0:AddTopGoal(GOAL_COMMON_EndureAttack, 0.1, 20003, TARGET_ENE_0, 9999, 0)
        return true
    end
    f3_arg0:SetNumber(9, f3_arg0:GetNumber(9) + 1)
    
end


