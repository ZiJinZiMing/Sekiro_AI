﻿RegisterTableGoal(GOAL_COMMON_GuardBreakCombo, "GuardBreakCombo")
REGISTER_GOAL_NO_SUB_GOAL(GOAL_COMMON_GuardBreakCombo, true)
REGISTER_DBG_GOAL_PARAM(GOAL_COMMON_GuardBreakCombo, 0, "１段目の攻撃番号", 0)
REGISTER_DBG_GOAL_PARAM(GOAL_COMMON_GuardBreakCombo, 1, "２段目の攻撃番号", 0)
REGISTER_DBG_GOAL_PARAM(GOAL_COMMON_GuardBreakCombo, 2, "攻撃対象", 0)
REGISTER_DBG_GOAL_PARAM(GOAL_COMMON_GuardBreakCombo, 3, "成功距離（２段目に適応される）", 0)
REGISTER_DBG_GOAL_PARAM(GOAL_COMMON_GuardBreakCombo, 4, "攻撃前旋回時間", 0)
REGISTER_DBG_GOAL_PARAM(GOAL_COMMON_GuardBreakCombo, 5, "正面判定角度", 0)

Goal.Activate = function (f1_arg0, f1_arg1, f1_arg2)
    local f1_local0 = f1_arg2:GetParam(0)
    local f1_local1 = f1_arg2:GetParam(1)
    local f1_local2 = f1_arg2:GetParam(2)
    local f1_local3 = 10
    local f1_local4 = f1_arg2:GetParam(3)
    local f1_local5 = f1_arg2:GetParam(4)
    local f1_local6 = f1_arg2:GetParam(5)
    f1_arg2:AddSubGoal(GOAL_COMMON_GuardBreakTunable, 10, f1_local0, f1_local2, f1_local3, f1_local5, f1_local6, 0, 0)
    f1_arg2:AddSubGoal(GOAL_COMMON_ComboFinal, 10, f1_local1, f1_local2, f1_local4, 0)
    
end

Goal.Update = function (f2_arg0, f2_arg1, f2_arg2)
    return Update_Default_NoSubGoal(f2_arg0, f2_arg1, f2_arg2)
    
end


