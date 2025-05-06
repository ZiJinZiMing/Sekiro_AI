RegisterTableLogic(121100)

Logic.Main = function (f1_arg0, f1_arg1)
    local f1_local0 = f1_arg1:GetDist(TARGET_ENE_0)
    if f1_arg1:IsBattleState() or f1_arg1:IsFindState() then
        _COMMON_SetBattleGoal(f1_arg1)
    elseif f1_arg1:IsCautionState() then
        if f1_local0 <= 1 then
            f1_arg1:AddTopGoal(GOAL_COMMON_Wait, 5, TARGET_SELF, 0, 0, 0)
        else
            f1_arg1:AddTopGoal(GOAL_COMMON_ApproachTarget, 10, TARGET_ENE_0, 1, TARGET_SELF, false, -1)
        end
    else
        _COMMON_AddNonBattleGoal(f1_arg1, -1, -1, true)
    end
    
end

Logic.Interrupt = function (f2_arg0, f2_arg1, f2_arg2)
    return false
    
end


