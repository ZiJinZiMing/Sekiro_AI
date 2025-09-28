-- 注册连击攻击行为的调试参数 (Register debug parameters for combo attack behavior)
REGISTER_DBG_GOAL_PARAM(GOAL_COMMON_ComboAttack, 0, "EzStateID", 0)     -- 动画状态ID (Animation state ID)
REGISTER_DBG_GOAL_PARAM(GOAL_COMMON_ComboAttack, 1, "攻撃対象", 0)        -- 攻击目标 (Attack target)
REGISTER_DBG_GOAL_PARAM(GOAL_COMMON_ComboAttack, 2, "成功距離", 0)        -- 攻击成功距离 (Attack success distance)
REGISTER_DBG_GOAL_PARAM(GOAL_COMMON_ComboAttack, 3, "上攻撃角度", 0)       -- 上攻击角度 (Upper attack angle)
REGISTER_DBG_GOAL_PARAM(GOAL_COMMON_ComboAttack, 4, "下攻撃角度", 0)       -- 下攻击角度 (Lower attack angle)
REGISTER_DBG_GOAL_PARAM(GOAL_COMMON_ComboAttack, 5, "成功角度", 0)        -- 连击成功角度 (Combo success angle)

-- 连击攻击行为激活函数 (Combo attack behavior activation function)
-- 执行连击序列的起始段，为后续连击做准备 (Execute the initial segment of combo sequence, preparing for subsequent combo)
function ComboAttack_Activate(f1_arg0, f1_arg1)
    local f1_local0 = f1_arg1:GetLife()        -- 获取生命周期 (Get life cycle)
    local f1_local1 = f1_arg1:GetParam(0)      -- 动画状态ID (Animation state ID)
    local f1_local2 = f1_arg1:GetParam(1)      -- 攻击目标 (Attack target)
    local f1_local3 = f1_arg1:GetParam(2)      -- 成功距离 (Success distance)
    local f1_local4 = f1_arg1:GetParam(5)      -- 连击成功角度 (Combo success angle)
    if f1_local4 == nil then
        f1_local4 = 90                          -- 默认连击成功角度90度 (Default combo success angle 90 degrees)
    end
    local f1_local5 = 1.5
    local f1_local6 = 20
    local f1_local7 = true
    local f1_local8 = true
    local f1_local9 = true
    local f1_local10 = false
    local f1_local11 = false
    local f1_local12 = f1_arg1:GetParam(3)
    local f1_local13 = f1_arg1:GetParam(4)
    f1_arg1:AddSubGoal(GOAL_COMMON_CommonAttack, f1_local0, f1_local1, f1_local2, f1_local3, f1_local4, f1_local5, f1_local6, f1_local8, f1_local9, f1_local10, f1_local11, f1_local12, f1_local13, f1_local7)
    
end

function ComboAttack_Update(f2_arg0, f2_arg1)
    return GOAL_RESULT_Continue
    
end

function ComboAttack_Terminate(f3_arg0, f3_arg1)
    
end

REGISTER_GOAL_NO_INTERUPT(GOAL_COMMON_ComboAttack, true)

function ComboAttack_Interupt(f4_arg0, f4_arg1)
    return false
    
end


