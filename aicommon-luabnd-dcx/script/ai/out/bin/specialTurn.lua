﻿REGISTER_DBG_GOAL_PARAM(GOAL_COMMON_SpecialTurn, 0, "EzState番号", 0)
REGISTER_DBG_GOAL_PARAM(GOAL_COMMON_SpecialTurn, 1, "攻撃対象【Type】", 0)
REGISTER_DBG_GOAL_PARAM(GOAL_COMMON_SpecialTurn, 2, "旋回角度", 0)
REGISTER_GOAL_UPDATE_TIME(GOAL_COMMON_SpecialTurn, 0, 0)
REGISTER_GOAL_NO_INTERUPT(GOAL_COMMON_SpecialTurn, true)

function SpecialTurn_Activate(f1_arg0, f1_arg1)
    local f1_local0 = f1_arg1:GetParam(0)
    local f1_local1 = f1_arg1:GetParam(1)
    local f1_local2 = f1_arg1:GetParam(2)
    if f1_arg0:IsLookToTarget(f1_local1, f1_local2) then
        f1_arg1:SetNumber(0, 1)
    else
        f1_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, f1_arg1:GetLife(), f1_local0, f1_local1, DIST_None, 0, -1)
    end
    
end

function SpecialTurn_Update(f2_arg0, f2_arg1)
    if f2_arg1:GetNumber(0) == 1 then
        return GOAL_RESULT_Success
    end
    return GOAL_RESULT_Continue
    
end

function SpecialTurn_Terminate(f3_arg0, f3_arg1)
    
end

function SpecialTurn_Interupt(f4_arg0, f4_arg1)
    return false
    
end


