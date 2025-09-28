-- 注册通用攻击行为的调试参数 (Register debug parameters for common attack behavior)
REGISTER_DBG_GOAL_PARAM(GOAL_COMMON_Attack, 0, "EzStateID", 0)     -- 动画状态ID (Animation state ID)
REGISTER_DBG_GOAL_PARAM(GOAL_COMMON_Attack, 1, "攻撃対象", 0)        -- 攻击目标 (Attack target)
REGISTER_DBG_GOAL_PARAM(GOAL_COMMON_Attack, 2, "成功距離", 0)        -- 攻击成功距离 (Success distance)
REGISTER_DBG_GOAL_PARAM(GOAL_COMMON_Attack, 3, "上攻撃角度", 0)       -- 上攻击角度 (Upper attack angle)
REGISTER_DBG_GOAL_PARAM(GOAL_COMMON_Attack, 4, "下攻撃角度", 0)       -- 下攻击角度 (Lower attack angle)

-- 通用攻击行为激活函数 (Common attack behavior activation function)
-- 执行基本的单次攻击动作 (Execute basic single attack action)
function Attack_Activate(f1_arg0, f1_arg1)
    local f1_local0 = f1_arg1:GetLife()        -- 获取生命周期 (Get life cycle)
    local f1_local1 = f1_arg1:GetParam(0)      -- 动画状态ID (Animation state ID)
    local f1_local2 = f1_arg1:GetParam(1)      -- 攻击目标 (Attack target)
    local f1_local3 = f1_arg1:GetParam(2)      -- 成功距离 (Success distance)
    local f1_local4 = 180                      -- 默认攻击角度范围 (Default attack angle range)
    local f1_local5 = 1.5                      -- 移动速度倍率 (Movement speed multiplier)
    local f1_local6 = 20                       -- 转身速度 (Turn speed)
    local f1_local7 = true                     -- 启用攻击 (Enable attack)
    local f1_local8 = false                    -- 禁用移动 (Disable movement)
    local f1_local9 = true                     -- 启用转身 (Enable turning)
    local f1_local10 = false                   -- 禁用后退 (Disable retreat)
    local f1_local11 = false                   -- 禁用侧移 (Disable side movement)
    local f1_local12 = f1_arg1:GetParam(3)     -- 上攻击角度 (Upper attack angle)
    local f1_local13 = f1_arg1:GetParam(4)     -- 下攻击角度 (Lower attack angle)

    -- 添加通用攻击子目标 (Add common attack sub-goal)
    f1_arg1:AddSubGoal(GOAL_COMMON_CommonAttack, f1_local0, f1_local1, f1_local2, f1_local3, f1_local4, f1_local5, f1_local6, f1_local8, f1_local9, f1_local10, f1_local11, f1_local12, f1_local13, f1_local7)

end

function Attack_Update(f2_arg0, f2_arg1)
    return GOAL_RESULT_Continue
    
end

function Attack_Terminate(f3_arg0, f3_arg1)
    
end

REGISTER_GOAL_NO_INTERUPT(GOAL_COMMON_Attack, true)

function Attack_Interupt(f4_arg0, f4_arg1)
    return false
    
end


