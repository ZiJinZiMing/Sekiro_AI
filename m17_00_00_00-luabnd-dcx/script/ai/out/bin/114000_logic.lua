RegisterTableLogic(114000)

Logic.Main = function (f1_arg0, f1_arg1)
    if COMMON_HiPrioritySetup(f1_arg1) then
        return true
    end
    local f1_local0 = f1_arg1:GetEventRequest()
    local f1_local1 = f1_arg1:GetDist(TARGET_ENE_0)
    if f1_arg1:HasSpecialEffectId(TARGET_SELF, 3114010) then
        if f1_arg1:HasSpecialEffectId(TARGET_SELF, 3114002) then
            f1_arg1:AddTopGoal(GOAL_COMMON_Wait, 10, TARGET_SELF, 0, 0, 0)
        else
            f1_arg1:AddTopGoal(GOAL_COMMON_AttackTunableSpin, 10, 20000, TARGET_ENE_0, 9999, 0, 0, 0, 0)
        end
    elseif f1_arg1:IsBattleState() and not f1_arg1:HasSpecialEffectId(TARGET_SELF, 3114010) then
        _COMMON_SetBattleGoal(f1_arg1)
    elseif f1_arg1:HasSpecialEffectId(TARGET_SELF, 200004) then
        f1_arg1:AddTopGoal(GOAL_COMMON_AttackTunableSpin, 10, 3009, TARGET_ENE_0, 9999, 0, 0, 0, 0)
    else
        f1_arg1:AddTopGoal(GOAL_COMMON_Wait, 0.1, TARGET_SELF, 0, 0, 0)
    end
    
end

Logic.Interrupt = function (f2_arg0, f2_arg1, f2_arg2)
    return false
    
end


