RegisterTableLogic(122000)

Logic.Main = function (f1_arg0, f1_arg1)
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
    elseif f1_arg1:HasSpecialEffectId(TARGET_SELF, 3122510) and (f1_arg1:IsFindState() == true or f1_arg1:IsBattleState() == true) and f1_arg1:GetNumber(9) == 0 then
        f1_arg1:AddTopGoal(GOAL_COMMON_AttackTunableSpin, 10, 200, TARGET_ENE_0, 9999, 0, 0, 0, 0):TimingSetNumber(9, 1, AI_TIMING_SET__ACTIVATE)
        return true
    end
    COMMON_EzSetup(f1_arg1)
    
end

Logic.Interrupt = function (f2_arg0, f2_arg1, f2_arg2)
    local f2_local0 = f2_arg1:GetSpecialEffectActivateInterruptType(0)
    local f2_local1 = f2_arg1:GetRandam_Int(1, 100)
    if f2_arg1:IsInterupt(INTERUPT_ParryTiming) and f2_arg1:HasSpecialEffectId(TARGET_SELF, 3122110) then
        if f2_arg1:IsInsideTarget(TARGET_ENE_0, AI_DIR_TYPE_F, 90) then
            if f2_arg1:HasSpecialEffectId(TARGET_ENE_0, 109012) then
                if f2_arg1:IsInsideTargetEx(TARGET_ENE_0, TARGET_SELF, AI_DIR_TYPE_F, 90, PC_ATTACK_DIST_CROUCH) then
                    f2_arg2:ClearSubGoal()
                    f2_arg2:AddTopGoal(GOAL_COMMON_EndureAttack, 0.1, 3101, TARGET_ENE_0, 9999, 0)
                    return true
                end
            elseif f2_arg1:HasSpecialEffectId(TARGET_ENE_0, 109970) then
                if f2_arg1:IsInsideTargetEx(TARGET_ENE_0, TARGET_SELF, AI_DIR_TYPE_F, 90, PC_ATTACK_DIST_THRUST) then
                    if f2_arg1:IsTargetGuard(TARGET_SELF) then
                        return false
                    else
                        f2_arg2:ClearSubGoal()
                        f2_arg1:AddTopGoal(GOAL_COMMON_EndureAttack, 0.1, 3100, TARGET_ENE_0, 9999, 0)
                        return true
                    end
                end
            elseif f2_arg1:IsInsideTargetEx(TARGET_ENE_0, TARGET_SELF, AI_DIR_TYPE_F, 90, PC_ATTACK_DIST_STAND) then
                if f2_local1 <= Get_ConsecutiveGuardCount(f2_arg1) * 50 then
                    f2_arg2:ClearSubGoal()
                    f2_arg1:AddTopGoal(GOAL_COMMON_EndureAttack, 0.1, 3101, TARGET_ENE_0, 9999, 0)
                    return true
                else
                    f2_arg2:ClearSubGoal()
                    f2_arg1:AddTopGoal(GOAL_COMMON_EndureAttack, 0.1, 3100, TARGET_ENE_0, 9999, 0)
                    return true
                end
            elseif f2_arg1:IsInsideTargetEx(TARGET_ENE_0, TARGET_SELF, AI_DIR_TYPE_F, 90, 5) then
            end
        end
        return false
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


