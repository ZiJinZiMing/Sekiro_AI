﻿RegisterTableGoal(GOAL_COMMON_SetNumberRealtime, "SetTimerRealtime")
REGISTER_GOAL_NO_SUB_GOAL(GOAL_COMMON_SetNumberRealtime, true)
REGISTER_DBG_GOAL_PARAM(GOAL_COMMON_SetNumberRealtime, 0, "ナンバーインデックス", 0)
REGISTER_DBG_GOAL_PARAM(GOAL_COMMON_SetNumberRealtime, 1, "番号", 0)

Goal.Activate = function (f1_arg0, f1_arg1, f1_arg2)
    local f1_local0 = f1_arg2:GetParam(0)
    local f1_local1 = f1_arg2:GetParam(1)
    f1_arg1:SetNumber(f1_local0, f1_local1)
    
end

Goal.Update = function (f2_arg0, f2_arg1, f2_arg2)
    return Update_Default_NoSubGoal(f2_arg0, f2_arg1, f2_arg2)
    
end


