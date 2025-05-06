RegisterTableGoal(GOAL_EnemyMultiAttack, "GOAL_EnemyMultiAttack")
ENABLE_COMBO_ATK_CANCEL(GOAL_EnemyMultiAttack)
REGISTER_GOAL_NO_SUB_GOAL(GOAL_EnemyMultiAttack, true)
REGISTER_DBG_GOAL_PARAM(GOAL_EnemyMultiAttack, 0, "対象", 0)
REGISTER_DBG_GOAL_PARAM(GOAL_EnemyMultiAttack, 1, "コンボ確率", 0)
REGISTER_DBG_GOAL_PARAM(GOAL_EnemyMultiAttack, 2, "攻撃1", 0)
REGISTER_DBG_GOAL_PARAM(GOAL_EnemyMultiAttack, 3, "攻撃2", 0)
REGISTER_DBG_GOAL_PARAM(GOAL_EnemyMultiAttack, 4, "攻撃3", 0)
REGISTER_DBG_GOAL_PARAM(GOAL_EnemyMultiAttack, 5, "攻撃4", 0)
REGISTER_DBG_GOAL_PARAM(GOAL_EnemyMultiAttack, 6, "攻撃5", 0)
REGISTER_DBG_GOAL_PARAM(GOAL_EnemyMultiAttack, 7, "攻撃6", 0)

Goal.Activate = function (f1_arg0, f1_arg1, f1_arg2)
    local f1_local0 = f1_arg2:GetParam(0)
    local f1_local1 = f1_arg2:GetParam(1)
    local f1_local2 = f1_arg2:GetParam(2)
    local f1_local3 = f1_arg2:GetParam(3)
    local f1_local4 = f1_arg2:GetParam(4)
    local f1_local5 = f1_arg2:GetParam(5)
    local f1_local6 = f1_arg2:GetParam(6)
    local f1_local7 = f1_arg2:GetParam(7)
    f1_arg2:AddSubGoal(GOAL_EnemyHandyAttack, f1_arg2:GetLife(), f1_local0, 0, f1_local2, f1_local3, f1_local4, f1_local5, f1_local6, f1_local7, f1_local1, f1_local1, f1_local1, f1_local1, f1_local1)
    
end

Goal.Update = function (f2_arg0, f2_arg1, f2_arg2)
    if f2_arg2:GetSubGoalNum() <= 0 then
        return GOAL_RESULT_Success
    end
    return GOAL_RESULT_Continue
    
end


