RegisterTableLogic(126000)

Logic.Main = function (f1_arg0, f1_arg1)
    f1_arg1:AddObserveSpecialEffectAttribute(TARGET_SELF, 5029)
    f1_arg1:AddObserveSpecialEffectAttribute(TARGET_SELF, 220010)
    f1_arg1:AddObserveSpecialEffectAttribute(TARGET_SELF, 107710)
    f1_arg1:AddObserveSpecialEffectAttribute(TARGET_ENE_0, 110060)
    f1_arg1:AddObserveSpecialEffectAttribute(TARGET_ENE_0, 110015)
    f1_arg1:AddObserveSpecialEffectAttribute(TARGET_ENE_0, 3126000)
    f1_arg1:DeleteObserve(0)
    local f1_local0 = 90
    local f1_local1 = 25
    local f1_local2 = 0
    local f1_local3 = 180
    local f1_local4 = f1_arg1:GetRandam_Int(1, 100)
    local f1_local5 = P_R12
    local f1_local6 = f1_arg1:GetDist(POINT_EVENT)
    if f1_arg1:HasSpecialEffectId(TARGET_SELF, 5022) and f1_arg1:HasSpecialEffectId(TARGET_SELF, 5025) then
        f1_arg1:AddTopGoal(GOAL_COMMON_AttackTunableSpin, 10, 20016, TARGET_ENE_0, 9999, 0, 0, 0, 0)
        return true
    end
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
    if _COMMON_AddStateTransitionGoal(f1_arg1) then
        return true
    end
    if f1_arg1:IsBattleState() == false and f1_arg1:IsCautionState() == false and f1_arg1:IsFindState() == false and f1_arg1:IsInsideTargetRegion(TARGET_SELF, 2002830) and f1_arg1:HasSpecialEffectId(TARGET_SELF, 5021) and f1_arg1:HasSpecialEffectId(TARGET_SELF, 5029) == false then
        f1_arg1:AddTopGoal(GOAL_COMMON_WaitWithAnime, 10, 20013, TARGET_SELF)
        return true
    elseif f1_arg1:IsBattleState() == false and f1_arg1:IsCautionState() == false and f1_arg1:IsFindState() == false and f1_arg1:IsInsideTargetRegion(TARGET_SELF, 2002870) and f1_arg1:IsEventFlag(62000705) and f1_arg1:HasSpecialEffectId(TARGET_SELF, 5020) and f1_arg1:HasSpecialEffectId(TARGET_SELF, 5029) == false then
        f1_arg1:AddTopGoal(GOAL_COMMON_WaitWithAnime, 21, 20006, TARGET_SELF)
        return true
    elseif f1_arg1:IsBattleState() == false and f1_arg1:IsCautionState() == false and f1_arg1:IsFindState() == false and f1_arg1:IsInsideTargetRegion(TARGET_SELF, 2002880) and f1_arg1:HasSpecialEffectId(TARGET_SELF, 5020) and f1_arg1:HasSpecialEffectId(TARGET_SELF, 5029) == false then
        f1_arg1:AddTopGoal(GOAL_COMMON_WaitWithAnime, 21, 20006, TARGET_SELF)
        return true
    end
    if f1_arg1:GetNumber(0) > 0 and f1_arg1:HasSpecialEffectId(TARGET_SELF, 5020) then
        if f1_arg1:GetNumber(0) == 1 then
            if f1_local6 > 1 then
                f1_local5 = 2002859
                f1_arg1:SetEventMoveTarget(f1_local5)
                f1_arg1:AddTopGoal(GOAL_COMMON_ApproachTarget, 10, POINT_EVENT, 1, TARGET_SELF, false, -1)
            else
                f1_arg1:SetNumber(0, 0)
                f1_arg1:AddTopGoal(GOAL_COMMON_Wait, 10, TARGET_SELF, 0, 0, 0)
                return true
            end
        elseif f1_arg1:GetNumber(0) == 2 then
            if f1_local6 > 1 then
                f1_local5 = 2002869
                f1_arg1:SetEventMoveTarget(f1_local5)
                f1_arg1:AddTopGoal(GOAL_COMMON_ApproachTarget, 10, POINT_EVENT, 1, TARGET_SELF, false, -1)
            else
                f1_arg1:SetNumber(0, 0)
                f1_arg1:AddTopGoal(GOAL_COMMON_Wait, 10, TARGET_SELF, 0, 0, 0)
                return true
            end
        end
    elseif f1_arg1:GetNumber(1) == 1 and f1_arg1:HasSpecialEffectId(TARGET_SELF, 5021) then
        if f1_local6 > 1 then
            f1_local5 = 2002898
            f1_arg1:SetEventMoveTarget(f1_local5)
            f1_arg1:AddTopGoal(GOAL_COMMON_ApproachTarget, 10, POINT_EVENT, 1, TARGET_SELF, false, -1)
        else
            f1_arg1:SetNumber(1, 0)
            f1_arg1:AddTopGoal(GOAL_COMMON_Wait, 10, TARGET_SELF, 0, 0, 0)
            return true
        end
    end
    if f1_arg1:HasSpecialEffectId(TARGET_SELF, 5020) or f1_arg1:HasSpecialEffectId(TARGET_SELF, 5021) then
        if f1_arg1:IsBattleState() or f1_arg1:IsFindState() then
            if f1_arg1:GetStringIndexedNumber("FirstSight") == 0 then
                f1_arg1:AddObserveArea(0, TARGET_SELF, TARGET_ENE_0, AI_DIR_TYPE_F, f1_local0, f1_local1)
                if f1_arg1:HasSpecialEffectId(TARGET_SELF, 5020) then
                    f1_arg1:SetTimer(0, 7)
                    f1_arg1:AddTopGoal(GOAL_COMMON_WaitWithAnime, 10, 20005, TARGET_ENE_0)
                elseif f1_arg1:HasSpecialEffectId(TARGET_SELF, 5021) then
                    f1_arg1:SetTimer(0, 7)
                    f1_arg1:AddTopGoal(GOAL_COMMON_WaitWithAnime, 10, 20010, TARGET_ENE_0)
                end
            else
                _COMMON_SetBattleGoal(f1_arg1)
            end
            f1_arg1:SetStringIndexedNumber("FirstSight", 1)
        elseif f1_arg1:IsCautionState() then
            f1_arg1:AddTopGoal(GOAL_COMMON_Turn, 5, TARGET_ENE_0, 0, 0, 0)
            f1_arg1:SetStringIndexedNumber("FirstSight", 0)
        else
            COMMON_EzSetup(f1_arg1)
            f1_arg1:SetStringIndexedNumber("FirstSight", 0)
        end
    elseif f1_arg1:HasSpecialEffectId(TARGET_SELF, 5022) then
        if f1_arg1:IsBattleState() or f1_arg1:IsFindState() then
            if f1_arg1:GetStringIndexedNumber("FirstSight") == 0 then
                f1_arg1:AddObserveArea(0, TARGET_SELF, TARGET_ENE_0, AI_DIR_TYPE_F, f1_local0, f1_local1)
                if f1_arg1:HasSpecialEffectId(TARGET_SELF, 5022) then
                    f1_arg1:SetTimer(0, 7)
                    f1_arg1:AddTopGoal(GOAL_COMMON_WaitWithAnime, 10, 20015, TARGET_ENE_0)
                end
            else
                COMMON_EzSetup(f1_arg1)
            end
            f1_arg1:SetStringIndexedNumber("FirstSight", 1)
        else
            COMMON_EzSetup(f1_arg1)
            f1_arg1:SetStringIndexedNumber("FirstSight", 0)
        end
    else
        COMMON_EzSetup(f1_arg1)
    end
    
end

Logic.Interrupt = function (f2_arg0, f2_arg1, f2_arg2)
    local f2_local0 = f2_arg1:GetSpecialEffectActivateInterruptType(0)
    if f2_arg1:IsInterupt(INTERUPT_Inside_ObserveArea) and f2_arg1:IsInsideObserve(0) then
        f2_arg1:Replanning()
        f2_arg1:DeleteObserve(0)
        return true
    end
    if f2_arg1:IsInterupt(INTERUPT_ActivateSpecialEffect) then
        if f2_local0 == 220010 then
            f2_arg1:ClearEnemyTarget()
            return true
        elseif f2_arg1:GetSpecialEffectActivateInterruptType(0) == 110060 then
            f2_arg1:SetStringIndexedNumber("targetDeadFlag", 1)
            f2_arg2:ClearSubGoal()
            f2_arg1:AddTopGoal(GOAL_COMMON_ApproachTarget, 1, TARGET_ENE_0, 9999, TARGET_SELF, true, -1)
            return true
        elseif f2_arg1:GetSpecialEffectActivateInterruptType(0) == 110015 then
            f2_arg1:SetStringIndexedNumber("TargetDeadFlag", 0)
            f2_arg2:ClearSubGoal()
            f2_arg1:AddTopGoal(GOAL_COMMON_Wait, 0, TARGET_ENE_0, 0, 0, 0)
            return true
        elseif f2_local0 == 3126000 then
            f2_arg1:SetNumber(0, 0)
            f2_arg1:SetNumber(1, 0)
            f2_arg2:ClearSubGoal()
            f2_arg1:ClearEnemyTarget()
            f2_arg1:ClearSoundTarget()
            f2_arg1:ClearIndicationPosTarget()
            f2_arg1:ClearLastMemoryTargetPos()
            f2_arg1:Replanning()
            return true
        end
    end
    return false
    
end


