REGISTER_DBG_GOAL_PARAM(GOAL_COMMON_AttackImmediateAction, 0, "EzStateID", 0)
REGISTER_DBG_GOAL_PARAM(GOAL_COMMON_AttackImmediateAction, 1, "攻撃対象", 0)
REGISTER_DBG_GOAL_PARAM(GOAL_COMMON_AttackImmediateAction, 2, "成功距離", 0)
REGISTER_DBG_GOAL_PARAM(GOAL_COMMON_AttackImmediateAction, 3, "攻撃前旋回時間", 0)
REGISTER_DBG_GOAL_PARAM(GOAL_COMMON_AttackImmediateAction, 4, "正面判定角度", 0)
REGISTER_DBG_GOAL_PARAM(GOAL_COMMON_AttackImmediateAction, 5, "上攻撃角度", 0)
REGISTER_DBG_GOAL_PARAM(GOAL_COMMON_AttackImmediateAction, 6, "下攻撃角度", 0)

function AttackImmediateAction_Activate(f1_arg0, f1_arg1)
    local f1_local0 = f1_arg1:GetLife()
    local f1_local1 = f1_arg1:GetParam(0)
    local f1_local2 = f1_arg1:GetParam(1)
    local f1_local3 = f1_arg1:GetParam(2)
    local f1_local4 = 180
    local f1_local5 = f1_arg1:GetParam(3)
    local f1_local6 = f1_arg1:GetParam(4)
    if f1_local5 < 0 then
        f1_local5 = 1.5
    end
    if f1_local6 < 0 then
        f1_local6 = 20
    end
    local f1_local7 = true
    local f1_local8 = false
    local f1_local9 = true
    local f1_local10 = false
    local f1_local11 = false
    local f1_local12 = f1_arg1:GetParam(5)
    local f1_local13 = f1_arg1:GetParam(6)
    f1_arg1:AddSubGoal(GOAL_COMMON_CommonAttack, f1_local0, f1_local1, f1_local2, f1_local3, f1_local4, f1_local5, f1_local6, f1_local8, f1_local9, f1_local10, f1_local11, f1_local12, f1_local13, f1_local7)
    f1_arg0:SetEnableImmediateAction_forGoal()
    
end

function AttackImmediateAction_Update(f2_arg0, f2_arg1)
    return GOAL_RESULT_Continue
    
end

function AttackImmediateAction_Terminate(f3_arg0, f3_arg1)
    f3_arg0:ClearEnableImmediateAction_forGoal()
    
end

REGISTER_GOAL_NO_INTERUPT(GOAL_COMMON_AttackImmediateAction, true)

function AttackImmediateAction_Interupt(f4_arg0, f4_arg1)
    return false
    
end


