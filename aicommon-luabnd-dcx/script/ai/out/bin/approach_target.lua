-- 注册接近目标行为的调试参数 (Register debug parameters for approach target behavior)
REGISTER_DBG_GOAL_PARAM(GOAL_COMMON_ApproachTarget, 0, "移動対象", 0)          -- 移动目标 (Movement target)
REGISTER_DBG_GOAL_PARAM(GOAL_COMMON_ApproachTarget, 1, "到達判定距離", 0)      -- 到达判定距离 (Arrival detection distance)
REGISTER_DBG_GOAL_PARAM(GOAL_COMMON_ApproachTarget, 2, "旋回対象", 0)          -- 旋回目标 (Turn target)
REGISTER_DBG_GOAL_PARAM(GOAL_COMMON_ApproachTarget, 3, "歩く?", 0)             -- 是否步行 (Walk or run)
REGISTER_DBG_GOAL_PARAM(GOAL_COMMON_ApproachTarget, 4, "ガードEzState番号", 0) -- 防守动画状态ID (Guard animation state ID)
REGISTER_GOAL_NO_UPDATE(GOAL_COMMON_ApproachTarget, true)      -- 禁用Update函数 (Disable update function)
REGISTER_GOAL_NO_INTERUPT(GOAL_COMMON_ApproachTarget, true)    -- 禁用中断 (Disable interrupt)

-- 接近目标行为激活函数 (Approach target behavior activation function)
-- 让AI角色向指定目标移动，直到达到设定距离 (Make AI character move towards target until reaching set distance)
function ApproachTarget_Activate(f1_arg0, f1_arg1)
    local f1_local0 = f1_arg1:GetLife()        -- 获取生命周期 (Get life cycle)
    local f1_local1 = f1_arg1:GetParam(0)      -- 移动目标 (Movement target)
    local f1_local2 = f1_arg1:GetParam(1)      -- 到达判定距离 (Arrival detection distance)
    local f1_local3 = f1_arg1:GetParam(2)      -- 旋回目标 (Turn target)
    local f1_local4 = f1_arg1:GetParam(3)      -- 是否步行 (Walk mode)
    local f1_local5 = f1_arg1:GetParam(4)      -- 防守动画状态ID (Guard animation state ID)
    local f1_local6 = AI_DIR_TYPE_CENTER       -- 移动方向类型：中心方向 (Movement direction type: center)
    local f1_local7 = 0                        -- 方向偏移 (Direction offset)
    local f1_local8 = f1_arg1:GetParam(5)      -- 扩展参数5 (Extended parameter 5)
    local f1_local9 = f1_arg1:GetParam(6)      -- 扩展参数6 (Extended parameter 6)
    local f1_local10 = f1_arg1:GetParam(7)     -- 扩展参数7 (Extended parameter 7)

    -- 添加移动到某处的子目标 (Add move to somewhere sub-goal)
    f1_arg1:AddSubGoal(GOAL_COMMON_MoveToSomewhere, f1_local0, f1_local1, f1_local6, f1_local2, f1_local3, f1_local4, f1_local6, f1_local7, f1_local10, f1_local5, f1_local8, f1_local9)

end

function ApproachTarget_Update(f2_arg0, f2_arg1, f2_arg2)
    
end

function ApproachTarget_Terminate(f3_arg0, f3_arg1)
    
end

function ApproachTarget_Interupt(f4_arg0, f4_arg1)
    return false
    
end


