﻿RegisterTableGoal(GOAL_COMMON_MoveToPoint, "MoveToPoint")
REGISTER_GOAL_NO_SUB_GOAL(GOAL_COMMON_MoveToPoint, true)
REGISTER_DBG_GOAL_PARAM(GOAL_COMMON_MoveToPoint, 0, "ポイントエンティティID", 0)
REGISTER_DBG_GOAL_PARAM(GOAL_COMMON_MoveToPoint, 1, "到達判定距離", 0)
REGISTER_DBG_GOAL_PARAM(GOAL_COMMON_MoveToPoint, 2, "旋回対象", 0)
REGISTER_DBG_GOAL_PARAM(GOAL_COMMON_MoveToPoint, 3, "歩くか", 0)
REGISTER_DBG_GOAL_PARAM(GOAL_COMMON_MoveToPoint, 4, "ガード番号", 0)

Goal.Activate = function (f1_arg0, f1_arg1, f1_arg2)
    f1_arg1:SetEventMoveTarget(f1_arg2:GetParam(0))
    f1_arg2:AddSubGoal(GOAL_COMMON_ApproachTarget, f1_arg2:GetLife(), POINT_EVENT, f1_arg2:GetParam(1), f1_arg2:GetParam(2), f1_arg2:GetParam(3), f1_arg2:GetParam(4))
    
end

Goal.Update = function (f2_arg0, f2_arg1, f2_arg2)
    if f2_arg2:GetSubGoalNum() <= 0 then
        return GOAL_RESULT_Success
    end
    return GOAL_RESULT_Continue
    
end

RegisterTableGoal(GOAL_COMMON_MoveToMultiPoint, "GOAL_COMMON_MoveToMultiPoint")
REGISTER_GOAL_NO_SUB_GOAL(GOAL_COMMON_MoveToMultiPoint, true)
REGISTER_DBG_GOAL_PARAM(GOAL_COMMON_MoveToMultiPoint, 0, "到達判定距離", 0)
REGISTER_DBG_GOAL_PARAM(GOAL_COMMON_MoveToMultiPoint, 1, "旋回対象", 0)
REGISTER_DBG_GOAL_PARAM(GOAL_COMMON_MoveToMultiPoint, 2, "歩くか", 0)
REGISTER_DBG_GOAL_PARAM(GOAL_COMMON_MoveToMultiPoint, 3, "ガード番号", 0)
REGISTER_DBG_GOAL_PARAM(GOAL_COMMON_MoveToMultiPoint, 4, "ポイント1", 0)
REGISTER_DBG_GOAL_PARAM(GOAL_COMMON_MoveToMultiPoint, 5, "ポイント2", 0)
REGISTER_DBG_GOAL_PARAM(GOAL_COMMON_MoveToMultiPoint, 6, "ポイント3", 0)
REGISTER_DBG_GOAL_PARAM(GOAL_COMMON_MoveToMultiPoint, 7, "ポイント4", 0)
REGISTER_DBG_GOAL_PARAM(GOAL_COMMON_MoveToMultiPoint, 8, "ポイント5", 0)
REGISTER_DBG_GOAL_PARAM(GOAL_COMMON_MoveToMultiPoint, 9, "ポイント6", 0)
REGISTER_DBG_GOAL_PARAM(GOAL_COMMON_MoveToMultiPoint, 10, "ポイント7", 0)
REGISTER_DBG_GOAL_PARAM(GOAL_COMMON_MoveToMultiPoint, 11, "ポイント8", 0)
REGISTER_DBG_GOAL_PARAM(GOAL_COMMON_MoveToMultiPoint, 12, "ポイント9", 0)
REGISTER_DBG_GOAL_PARAM(GOAL_COMMON_MoveToMultiPoint, 13, "ポイント10", 0)

Goal.Activate = function (f3_arg0, f3_arg1, f3_arg2)
    local f3_local0 = 1
    for f3_local1 = 5, 13, 1 do
        if f3_arg2:GetParam(f3_local1) == nil or f3_arg2:GetParam(f3_local1) <= 0 then
            f3_arg2:SetNumber(0, f3_local1 - 1)
            f3_local0 = 0
            break
        end
    end
    if f3_local0 == 1 then
        f3_arg2:SetNumber(0, 13)
    end
    local f3_local1 = 9999
    local f3_local2 = -1
    for f3_local3 = 4, f3_arg2:GetNumber(0) - 1, 1 do
        f3_arg1:SetEventMoveTarget(f3_arg2:GetParam(f3_local3))
        local f3_local6 = f3_arg1:GetDist(POINT_EVENT)
        if f3_local6 < f3_local1 then
            f3_local1 = f3_local6
            f3_local2 = f3_local3
        end
    end
    for f3_local3 = f3_local2, f3_arg2:GetNumber(0), 1 do
        f3_arg2:AddSubGoal(GOAL_COMMON_MoveToPoint, f3_arg2:GetLife(), f3_arg2:GetParam(f3_local3), f3_arg2:GetParam(0), f3_arg2:GetParam(1), f3_arg2:GetParam(2), f3_arg2:GetParam(3))
    end
    



end

Goal.Update = function (f4_arg0, f4_arg1, f4_arg2)
    if f4_arg2:GetSubGoalNum() <= 0 then
        if f4_arg1:GetDist(f4_arg2:GetParam(f4_arg2:GetNumber(0))) <= f4_arg2:GetParam(0) then
            return GOAL_RESULT_Success
        else
            local f4_local0 = 9999
            local f4_local1 = -1
            for f4_local2 = 4, f4_arg2:GetNumber(0), 1 do
                f4_arg1:SetEventMoveTarget(f4_arg2:GetParam(f4_local2))
                local f4_local5 = f4_arg1:GetDist(POINT_EVENT)
                if f4_local5 < f4_local0 then
                    f4_local0 = f4_local5
                    f4_local1 = f4_local2
                end
            end
            for f4_local2 = f4_local1, f4_arg2:GetNumber(0), 1 do
                f4_arg2:AddSubGoal(GOAL_COMMON_MoveToPoint, f4_arg2:GetLife(), f4_arg2:GetParam(f4_local2), f4_arg2:GetParam(0), f4_arg2:GetParam(1), f4_arg2:GetParam(2), f4_arg2:GetParam(3))
            end

        end
    end
    return GOAL_RESULT_Continue
    
end


