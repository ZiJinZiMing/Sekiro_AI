RegisterTableLogic(LOGIC_ID_Orochi_Dummy_501001)

Logic.Main = function (f1_arg0, f1_arg1)
    f1_arg1:AddObserveRegion(0, TARGET_LOCALPLAYER, 1702623)
    f1_arg1:AddObserveRegion(1, TARGET_LOCALPLAYER, 1702626)
    if f1_arg1:IsInsideTargetRegion(TARGET_LOCALPLAYER, 1702623) then
        f1_arg1:ClearEnemyTarget()
    elseif f1_arg1:GetNumber(1) == 1 and f1_arg1:IsInsideTargetRegion(TARGET_LOCALPLAYER, 1702626) then
        f1_arg1:ClearEnemyTarget()
        f1_arg1:ClearSoundTarget()
        f1_arg1:ClearIndicationPosTarget()
        f1_arg1:ClearLastMemoryTargetPos()
    end
    f1_arg1:AddTopGoal(GOAL_COMMON_Wait, 5, TARGET_NONE, 0, 0, 0)
    
end

Logic.Interrupt = function (f2_arg0, f2_arg1, f2_arg2)
    if f2_arg1:IsInterupt(INTERUPT_Inside_ObserveArea) then
        if f2_arg1:IsInsideObserve(0) then
            f2_arg1:ClearEnemyTarget()
            return true
        elseif f2_arg1:IsInsideObserve(1) then
            f2_arg1:ClearEnemyTarget()
            f2_arg1:ClearSoundTarget()
            f2_arg1:ClearIndicationPosTarget()
            f2_arg1:ClearLastMemoryTargetPos()
            f2_arg1:SetNumber(1, 1)
            return true
        end
    end
    return false
    
end


