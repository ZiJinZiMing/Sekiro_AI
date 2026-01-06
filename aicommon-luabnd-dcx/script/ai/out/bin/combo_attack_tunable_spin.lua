REGISTER_DBG_GOAL_PARAM(GOAL_COMMON_ComboAttackTunableSpin, 0, "StateID", 0)
REGISTER_DBG_GOAL_PARAM(GOAL_COMMON_ComboAttackTunableSpin, 1, "対象", 0)
REGISTER_DBG_GOAL_PARAM(GOAL_COMMON_ComboAttackTunableSpin, 2, "成功距離", 0)
REGISTER_DBG_GOAL_PARAM(GOAL_COMMON_ComboAttackTunableSpin, 3, "攻撃前旋回時間", 0)
REGISTER_DBG_GOAL_PARAM(GOAL_COMMON_ComboAttackTunableSpin, 4, "正面判定角度", 0)
REGISTER_DBG_GOAL_PARAM(GOAL_COMMON_ComboAttackTunableSpin, 5, "上攻撃角度", 0)
REGISTER_DBG_GOAL_PARAM(GOAL_COMMON_ComboAttackTunableSpin, 6, "下攻撃角度", 0)

function ComboAttackTunableSpin_Activate(f1_arg0, f1_arg1)
    local f1_local0 = f1_arg1:GetLife()
    local f1_local1 = f1_arg1:GetParam(0) --ezStateId
    local f1_local2 = f1_arg1:GetParam(1) --target
    local f1_local3 = f1_arg1:GetParam(2) --successDistance
    local f1_local4 = f1_arg1:GetParam(3) --turnTime,默认为1.5
    local f1_local5 = f1_arg1:GetParam(4) --turnFaceAngle,默认为20
    if f1_local4 < 0 then
        f1_local4 = 1.5
    end
    if f1_local5 < 0 then
        f1_local5 = 20
    end
    local f1_local6 = 90 --successAngle
    local f1_local7 = true
    local f1_local8 = true
    local f1_local9 = true
    local f1_local10 = false
    local f1_local11 = false
    local f1_local12 = f1_arg1:GetParam(5)
    local f1_local13 = f1_arg1:GetParam(6)

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
    -- 本模块配置: [4]=90°精确角度, [5]=可调旋回时间(默认1.5秒), [6]=可调正面角度(默认20°), [7]=true启用连击
    f1_arg1:AddSubGoal(GOAL_COMMON_CommonAttack, f1_local0,
            f1_local1, --ezStateId
            f1_local2, --target
            f1_local3, --successDistance
            f1_local6, --successAngle
            f1_local4, --turnTime
            f1_local5, --turnFaceAngle
            f1_local8, --isComboEnabled
            f1_local9, --isTurn
            f1_local10, --isGuardBreakAttack
            f1_local11, --isNonspinning
            f1_local12, --angleUp
            f1_local13, --angleDown
            f1_local7   --isCancelAttack
    )

end

function ComboAttackTunableSpin_Update(f2_arg0, f2_arg1)
    return GOAL_RESULT_Continue
    
end

function ComboAttackTunableSpin_Terminate(f3_arg0, f3_arg1)
    
end

REGISTER_GOAL_NO_INTERUPT(GOAL_COMMON_ComboAttackTunableSpin, true)

function ComboAttackTunableSpin_Interupt(f4_arg0, f4_arg1)
    return false
    
end


