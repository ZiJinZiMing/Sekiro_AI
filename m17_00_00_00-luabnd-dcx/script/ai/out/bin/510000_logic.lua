RegisterTableLogic(510000)

Logic.Main = function (f1_arg0, f1_arg1)
    f1_arg1:AddObserveSpecialEffectAttribute(TARGET_SELF, 220010)
    f1_arg1:AddObserveSpecialEffectAttribute(TARGET_SELF, 107710)
    f1_arg1:AddObserveSpecialEffectAttribute(TARGET_ENE_0, 110060)
    f1_arg1:AddObserveSpecialEffectAttribute(TARGET_ENE_0, 110015)
    f1_arg1:DeleteObserve(COMMON_OBSERVE_SLOT_BATTLE_STEALTH)
    local f1_local0 = f1_arg1:GetDist(TARGET_ENE_0)
    if COMMON_HiPrioritySetup(f1_arg1, COMMON_FLAG_BOSS) then
        return true
    end
    if f1_arg1:HasSpecialEffectId(TARGET_SELF, 200031) == false and f1_arg1:HasSpecialEffectId(TARGET_SELF, COMMON_SP_EFFECT_SMOKE_SCREEN) and f1_arg1:HasSpecialEffectId(TARGET_ENE_0, COMMON_SP_EFFECT_HIDE_IN_BUSH) and f1_arg1:IsVisibleCurrTarget() == false then
        f1_arg1:AddTopGoal(GOAL_COMMON_WaitWithAnime, 30, 20030, TARGET_SELF)
        f1_arg1:AddTopGoal(GOAL_COMMON_AttackTunableSpin, 10, 20031, TARGET_ENE_0, 9999, 0, 0, 0, 0)
        f1_arg1:AddObserveChrDmyArea(COMMON_OBSERVE_SLOT_BATTLE_STEALTH, TARGET_ENE_0, 7, 90, 120, 30, 4)
        return true
    end
    local f1_local1 = f1_arg1:GetHpLastTarget()
    if f1_arg1:IsFindState() or f1_arg1:IsBattleState() then
        _COMMON_SetBattleGoal(f1_arg1)
        if f1_arg1:HasSpecialEffectId(TARGET_SELF, 200004) then
        elseif f1_arg1:HasSpecialEffectId(TARGET_SELF, 200002) and false then
        end
    elseif f1_arg1:IsCautionState() then
        if f1_arg1:HasSpecialEffectId(TARGET_SELF, 200004) then
        elseif f1_arg1:HasSpecialEffectId(TARGET_SELF, 200002) and false then
        end
    elseif f1_arg1:HasSpecialEffectId(TARGET_SELF, 200004) then
    elseif f1_arg1:HasSpecialEffectId(TARGET_SELF, 200002) then
    else
    end
    
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
        elseif f2_local0 == 110060 then
            f2_arg1:SetStringIndexedNumber("TargetDeadFlag", 1)
            f2_arg2:ClearSubGoal()
            f2_arg2:AddSubGoal(GOAL_COMMON_Wait, 0, TARGET_ENE_0, 0, 0, 0)
            return true
        elseif f2_local0 == 110015 then
            f2_arg1:SetStringIndexedNumber("TargetDeadFlag", 0)
            f2_arg2:ClearSubGoal()
            f2_arg2:AddSubGoal(GOAL_COMMON_Wait, 0, TARGET_ENE_0, 0, 0, 0)
            return true
        elseif f2_local0 == 110060 then
            f2_arg1:SetStringIndexedNumber("targetDeadFlag", 1)
            f2_arg1:Replanning()
            retval = false
        elseif f2_local0 == 110015 then
            f2_arg1:SetStringIndexedNumber("targetDeadFlag", 0)
            f2_arg1:Replanning()
            retval = false
        end
    end
    if f2_arg1:IsInterupt(INTERUPT_Damaged) and f2_arg1:HasSpecialEffectId(TARGET_SELF, 3510060) and f2_arg1:HasSpecialEffectId(TARGET_SELF, 200031) == false then
        f2_arg1:DeleteObserve(COMMON_OBSERVE_SLOT_BATTLE_STEALTH)
        f2_arg2:ClearSubGoal()
        f2_arg1:AddTopGoal(GOAL_COMMON_AttackTunableSpin, 1, 20031, TARGET_ENE_0, 9999, 0, 0, 0, 0)
        return true
    end
    if f2_arg1:IsInterupt(INTERUPT_Inside_ObserveArea) then
        if f2_arg1:IsVisibleCurrTarget() then
            if f2_arg1:HasSpecialEffectId(TARGET_SELF, 3510060) and f2_arg1:HasSpecialEffectId(TARGET_SELF, 200031) == false then
                f2_arg1:DeleteObserve(COMMON_OBSERVE_SLOT_BATTLE_STEALTH)
                f2_arg2:ClearSubGoal()
                f2_arg1:AddTopGoal(GOAL_COMMON_AttackTunableSpin, 1, 20031, TARGET_ENE_0, 9999, 0, 0, 0, 0)
                return true
            end
        else
            f2_arg1:DeleteObserve(COMMON_OBSERVE_SLOT_BATTLE_STEALTH)
            f2_arg1:AddObserveChrDmyArea(COMMON_OBSERVE_SLOT_BATTLE_STEALTH, TARGET_ENE_0, 7, 90, 120, 30, 4)
            return false
        end
    end
    return false
    
end


