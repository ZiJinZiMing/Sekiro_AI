RegisterTableLogic(530010)

Logic.Main = function (f1_arg0, f1_arg1)
    if f1_arg1:IsBattleState() then
        _COMMON_SetBattleGoal(f1_arg1)
    else
        f1_arg1:AddTopGoal(GOAL_COMMON_Wait, 0.5, TARGET_SELF, 0, 0, 0)
    end
    
end

Logic.Interrupt = function (f2_arg0, f2_arg1, f2_arg2)
    return false
    
end


