﻿RegisterTableGoal(GOAL_EnemyKeepDist, "GOAL_EnemyKeepDist")
REGISTER_GOAL_NO_SUB_GOAL(GOAL_EnemyKeepDist, true)
REGISTER_DBG_GOAL_PARAM(GOAL_EnemyKeepDist, 0, "対象", 0)
REGISTER_DBG_GOAL_PARAM(GOAL_EnemyKeepDist, 1, "旋回対象", 1)
REGISTER_DBG_GOAL_PARAM(GOAL_EnemyKeepDist, 2, "強制歩行距離", 2)
REGISTER_DBG_GOAL_PARAM(GOAL_EnemyKeepDist, 3, "強制走行距離", 3)
REGISTER_DBG_GOAL_PARAM(GOAL_EnemyKeepDist, 4, "走行率", 4)
REGISTER_DBG_GOAL_PARAM(GOAL_EnemyKeepDist, 5, "防御率", 5)
REGISTER_DBG_GOAL_PARAM(GOAL_EnemyKeepDist, 6, "後方ステップ確率", 6)
REGISTER_DBG_GOAL_PARAM(GOAL_EnemyKeepDist, 7, "前方ステップ確率", 7)
REGISTER_DBG_GOAL_PARAM(GOAL_EnemyKeepDist, 8, "ステップ実行確認間隔", 8)
REGISTER_DBG_GOAL_PARAM(GOAL_EnemyKeepDist, 9, "緊急回避距離", 8)
REGISTER_DBG_GOAL_PARAM(GOAL_EnemyKeepDist, 10, "緊急回避確率", 8)
REGISTER_DBG_GOAL_PARAM(GOAL_EnemyKeepDist, 11, "緊急回避確認間隔", 8)

Goal.Activate = function (f1_arg0, f1_arg1, f1_arg2)
    if not f1_arg1:IsAIAttackParam(7006) then
        return
    end
    local f1_local0 = f1_arg2:GetParam(0)
    local f1_local1 = f1_arg2:GetParam(1)
    local f1_local2 = f1_arg2:GetParam(2)
    local f1_local3 = f1_arg2:GetParam(3)
    local f1_local4 = f1_arg2:GetParam(4)
    local f1_local5 = f1_arg2:GetParam(5)
    local f1_local6 = f1_arg2:GetParam(6)
    local f1_local7 = f1_arg2:GetParam(7)
    local f1_local8 = f1_arg2:GetParam(8)
    local f1_local9 = f1_arg1:GetAIAttackParam(7006, AI_ATTACK_PARAM_TYPE__MIN_ARRIVE_DISTANCE)
    local f1_local10 = f1_arg1:GetAIAttackParam(7006, AI_ATTACK_PARAM_TYPE__MAX_ARRIVE_DISTANCE)
    if f1_local9 < 0 then
        f1_local9 = 0
    end
    local f1_local11 = f1_arg1:GetDist(f1_local0)
    if f1_arg1:GetRandam_Float(0, 100) < f1_local5 then
        f1_arg2:SetNumber(1, 9910)
    else
        f1_arg2:SetNumber(1, -1)
    end
    f1_arg1:StartIdTimerSpecifyTime(GOAL_EnemyKeepDist, f1_arg1:GetRandam_Float(0, 5 / 2))
    if f1_local11 < f1_local9 or f1_local10 < f1_local11 then
        f1_arg2:AddSubGoal(GOAL_EnemyFlexibleApproach, f1_arg2:GetLife(), f1_local0, f1_local1, (f1_local9 + f1_local10) / 2, (f1_local9 + f1_local10) / 2, f1_local2, f1_local3, f1_local4, GuradRate, f1_local6, f1_local7, f1_local8, 1)
    end
    f1_arg2:AddSubGoal(GOAL_COMMON_FlexibleSideWayMove, f1_arg2:GetLife(), f1_arg1:GetRandam_Float(1, 100), f1_arg1:GetRandam_Float(1, 100), f1_local1, 3, 90, f1_local5, f1_local9, f1_local10):SetFailedEndOption(AI_GOAL_FAILED_END_OPT__PARENT_NEXT_SUB_GOAL)
    
end

Goal.Update = function (f2_arg0, f2_arg1, f2_arg2)
    if f2_arg2:GetSubGoalNum() <= 0 then
        return GOAL_RESULT_Success
    end
    local f2_local0 = f2_arg2:GetParam(0)
    local f2_local1 = f2_arg2:GetParam(1)
    local f2_local2 = f2_arg2:GetParam(2)
    local f2_local3 = f2_arg2:GetParam(3)
    local f2_local4 = f2_arg2:GetParam(4)
    local f2_local5 = f2_arg2:GetParam(5)
    local f2_local6 = f2_arg2:GetParam(6)
    local f2_local7 = f2_arg2:GetParam(7)
    local f2_local8 = f2_arg2:GetParam(8)
    local f2_local9 = f2_arg1:GetAIAttackParam(7006, AI_ATTACK_PARAM_TYPE__MIN_ARRIVE_DISTANCE)
    local f2_local10 = f2_arg1:GetAIAttackParam(7006, AI_ATTACK_PARAM_TYPE__MAX_ARRIVE_DISTANCE)
    if f2_local9 < 0 then
        f2_local9 = 0
    end
    local f2_local11 = f2_arg2:GetParam(9)
    local f2_local12 = f2_arg2:GetParam(10)
    local f2_local13 = f2_arg2:GetParam(11)
    local f2_local14 = f2_arg1:GetDist(f2_local0)
    if f2_local11 ~= nil and f2_local14 <= f2_local11 then
        PassTime = f2_arg1:GetIdTimer(1 + 1)
        if 0 >= PassTime then
            PassTime = f2_local13
        end
        if f2_local13 ~= nil and f2_local13 <= PassTime then
            f2_arg1:StartIdTimer(1 + 1)
            if f2_local12 ~= nil and f2_arg1:GetRandam_Float(0, 100) < f2_local12 then
                f2_arg2:ClearSubGoal()
                f2_arg1:TurnTo(TRAGET_SELF)
                f2_arg2:AddSubGoal(GOAL_EnemyStepBLR, f2_arg2:GetLife(), f2_local0, 5)
                f2_arg2:AddSubGoal(GOAL_EnemyFlexibleApproach, f2_arg2:GetLife(), f2_local0, f2_local1, (f2_local9 + f2_local10) / 2, (f2_local9 + f2_local10) / 2, f2_local2, f2_local3, f2_local4, GuradRate, f2_local6, f2_local7, f2_local8, 1)
                f2_arg2:AddSubGoal(GOAL_COMMON_FlexibleSideWayMove, f2_arg2:GetLife(), f2_arg1:GetRandam_Float(1, 100), f2_arg1:GetRandam_Float(1, 100), TARGET_ENE_0, 3, f2_arg1:GetRandam_Float(30, 70), f2_arg2:GetParam(5), f2_local9, f2_local10):SetFailedEndOption(AI_GOAL_FAILED_END_OPT__PARENT_NEXT_SUB_GOAL)
                return GOAL_RESULT_Continue
            end
        end
    end
    if not (not (f2_local14 < f2_local9) or f2_arg1:HasGoal(GOAL_COMMON_LeaveTarget)) or f2_local10 < f2_local14 and not f2_arg1:HasGoal(GOAL_COMMON_ApproachTarget) then
        f2_arg2:ClearSubGoal()
        f2_arg1:TurnTo(TRAGET_SELF)
        f2_arg2:AddSubGoal(GOAL_EnemyFlexibleApproach, f2_arg2:GetLife(), f2_local0, f2_local1, (f2_local9 + f2_local10) / 2, (f2_local9 + f2_local10) / 2, f2_local2, f2_local3, f2_local4, GuradRate, f2_local6, f2_local7, f2_local8, 1)
        f2_arg2:AddSubGoal(GOAL_COMMON_FlexibleSideWayMove, f2_arg2:GetLife(), f2_arg1:GetRandam_Float(1, 100), f2_arg1:GetRandam_Float(1, 100), TARGET_ENE_0, 3, f2_arg1:GetRandam_Float(30, 70), f2_arg2:GetParam(5), f2_local9, f2_local10):SetFailedEndOption(AI_GOAL_FAILED_END_OPT__PARENT_NEXT_SUB_GOAL)
    end
    return GOAL_RESULT_Continue
    
end


