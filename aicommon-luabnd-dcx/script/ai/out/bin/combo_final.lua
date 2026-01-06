REGISTER_DBG_GOAL_PARAM(GOAL_COMMON_ComboFinal, 0, "EzStateID", 0)
REGISTER_DBG_GOAL_PARAM(GOAL_COMMON_ComboFinal, 1, "攻撃対象", 0)
REGISTER_DBG_GOAL_PARAM(GOAL_COMMON_ComboFinal, 2, "成功距離", 0)
REGISTER_DBG_GOAL_PARAM(GOAL_COMMON_ComboFinal, 3, "上攻撃角度", 0)
REGISTER_DBG_GOAL_PARAM(GOAL_COMMON_ComboFinal, 4, "下攻撃角度", 0)
ENABLE_COMBO_ATK_CANCEL(GOAL_COMMON_ComboFinal)

function ComboFinal_Activate(f1_arg0, f1_arg1)
    local f1_local0 = f1_arg1:GetLife()
    local f1_local1 = f1_arg1:GetParam(0)
    local f1_local2 = f1_arg1:GetParam(1)
    local f1_local3 = f1_arg1:GetParam(2)
    local f1_local4 = 180
    local f1_local5 = 0
    local f1_local6 = 90
    local f1_local7 = true
    local f1_local8 = false
    local f1_local9 = true
    local f1_local10 = false
    local f1_local11 = false
    local f1_local12 = f1_arg1:GetParam(3)
    local f1_local13 = f1_arg1:GetParam(4)

    -- GOAL_COMMON_CommonAttack 参数说明 (基于GOAL_COMMON_CommonAttack整参数验证报告):
    --   [1] ezStateId          - 动画状态ID
    --   [2] target             - 攻击目标
    --   [3] successDistance    - 成功判定距离（决定后续连击触发）
    --   [4] successAngle       - 成功判定角度（90度或180度）
    --   [5] turnTime           - 攻击前旋转时间（>0时有Turn动画）
    --   [6] turnFaceAngle      - 正面判定角度（Turn时角度差小于此值切换到攻击）
    --   [7] isComboEnabled     - 是否启用连击（true=可触发后续连击，false=终结）
    --   [8] isTurn             - 是否允许转向（false仅NonCancel使用）
    --   [9] isGuardBreakAttack - 是否架势破坏攻击（GuardBreak专用）
    --   [10] isNonspinning     - 是否禁用旋转（Nonspinning系列为true）
    --   [11] angleUp           - 上攻击角度限制（0-90度）
    --   [12] angleDown         - 下攻击角度限制（0-90度）
    --   [13] isCancelAttack    - 是否允许取消攻击（false仅NonCancel使用）
    --
    -- 本模块配置: [4]=180°高命中率, [7]=false连击终结, [10]=false启用旋转
    f1_arg1:AddSubGoal(GOAL_COMMON_CommonAttack, f1_local0, f1_local1, f1_local2, f1_local3, f1_local4, f1_local5, f1_local6, f1_local8, f1_local9, f1_local10, f1_local11, f1_local12, f1_local13, f1_local7)

end

function ComboFinal_Update(f2_arg0, f2_arg1)
    return GOAL_RESULT_Continue
    
end

function ComboFinal_Terminate(f3_arg0, f3_arg1)
    
end

REGISTER_GOAL_NO_INTERUPT(GOAL_COMMON_ComboFinal, true)

function ComboFinal_Interupt(f4_arg0, f4_arg1)
    return false
    
end


