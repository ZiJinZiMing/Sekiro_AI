--[[
顶级目标AI脚本 - TopGoal
用途：AI系统的顶级目标管理器，处理最高优先级的中断和全局行为
特点：负责处理各种紧急情况和系统级中断事件
重要性：确保AI在各种异常情况下都能做出正确反应

主要职责：
1. 处理无法移动时的破坏行为
2. 管理碰撞墙壁后的返回机制
3. 处理目标超出范围的重新规划
4. 管理路径偏离后的重新定位

中断优先级：
- INTERUPT_CANNOT_MOVE: 无法移动中断
- INTERUPT_HitEnemyWall: 碰撞敌人墙壁中断
- INTERUPT_TargetOutOfRange: 目标超出范围中断
- INTERUPT_WanderedOffPathRepath: 路径偏离重新定位中断
--]]

--[[
顶级目标激活函数
功能：初始化顶级目标，通常为空实现
说明：顶级目标主要通过中断机制工作，不需要复杂的初始化
--]]
function TopGoal_Activate(f1_arg0, f1_arg1)
    -- 顶级目标通常不需要特殊的激活逻辑
    -- 主要功能通过中断处理函数实现
end

--[[
顶级目标更新函数
功能：维持顶级目标的持续执行
返回：GOAL_RESULT_Continue - 持续运行
说明：顶级目标总是保持活跃状态，负责监控和处理各种中断
--]]
function TopGoal_Update(f2_arg0, f2_arg1)
    -- 顶级目标持续运行，通过中断机制处理各种情况
    return GOAL_RESULT_Continue
end

--[[
顶级目标终止函数
功能：顶级目标结束时的清理工作
说明：顶级目标通常不会被终止，此函数为空实现
--]]
function TopGoal_Terminate(f3_arg0, f3_arg1)
    -- 顶级目标通常不会被终止
    -- 如果被终止，也不需要特殊的清理工作
end

--[[
顶级目标中断处理函数 - AI系统的核心中断处理器
功能：处理各种系统级中断事件，确保AI在异常情况下的正确行为
返回：true表示处理了中断，false表示未处理
重要性：这是AI系统稳定性的关键保障

处理的中断类型：
1. 无法移动中断 - 当AI被阻挡时的破坏行为
2. 碰撞敌人墙壁中断 - 碰撞后的返回机制
3. 目标超出范围中断 - 目标丢失时的重新规划
4. 路径偏离中断 - 偏离路径时的重新定位
--]]
function TopGoal_Interupt(f4_arg0, f4_arg1)
    --[[
    中断处理1：无法移动时的破坏行为
    触发条件：AI无法正常移动（被障碍物阻挡）
    处理策略：如果接触可破坏物体且面向目标，执行破坏攻击
    --]]
    if f4_arg0:IsInterupt(INTERUPT_CANNOT_MOVE) then
        -- 获取无法移动时的动作参数
        local f4_local0 = f4_arg0:GetExcelParam(AI_EXCEL_THINK_PARAM_TYPE__CannotMoveAction)

        -- 检查条件：接触可破坏物体 + 有效动作参数 + 面向目标（90度范围内）
        if f4_arg0:IsTouchBreakableObject() and f4_local0 >= 0 and f4_arg0:IsLookToTarget(POINT_CurrRequestPosition, 90) then
            -- 清除当前所有子目标，执行破坏攻击
            f4_arg1:ClearSubGoal()
            f4_arg1:AddSubGoal(GOAL_COMMON_NonspinningAttack, -1, f4_local0, TARGET_NONE, DIST_None)
            return true
        end
    end

    --[[
    中断处理2：无法移动（禁用中断版本）
    与上述类似，但使用AddSubGoal_Front优先执行
    用于更紧急的破坏需求
    --]]
    if f4_arg0:IsInterupt(INTERUPT_CANNOT_MOVE_DisableInterupt) then
        local f4_local0 = f4_arg0:GetExcelParam(AI_EXCEL_THINK_PARAM_TYPE__CannotMoveAction)

        if f4_arg0:IsTouchBreakableObject() and f4_local0 >= 0 and f4_arg0:IsLookToTarget(POINT_CurrRequestPosition, 90) then
            -- 使用Front版本，优先级更高
            f4_arg1:AddSubGoal_Front(GOAL_COMMON_NonspinningAttack, -1, f4_local0, TARGET_NONE, DIST_None)
            return true
        end
    end

    --[[
    中断处理3：碰撞敌人墙壁后的返回机制
    触发条件：AI碰撞到敌人的墙壁或屏障
    处理策略：根据距离和位置决定离开目标或返回初始位置
    --]]
    if f4_arg0:IsInterupt(INTERUPT_HitEnemyWall) then
        -- 获取相关距离参数
        local f4_local0 = f4_arg0:GetExcelParam(AI_EXCEL_THINK_PARAM_TYPE__backhomeBattleDist)      -- 返回战斗距离
        local f4_local1 = f4_arg0:GetExcelParam(AI_EXCEL_THINK_PARAM_TYPE__maxBackhomeDist)        -- 最大返回距离
        local f4_local2 = f4_arg0:GetDist(TARGET_ENE_0)                                           -- 与敌人的距离
        local f4_local3 = f4_arg0:GetMovePointEffectRange()                                       -- 移动点影响范围
        local f4_local4 = f4_arg0:GetExcelParam(AI_EXCEL_THINK_PARAM_TYPE__BackHomeLife_OnHitEnemyWall) -- 返回生命时间

        if f4_local4 > 0 then
            local f4_local5 = f4_arg0:GetDist_Point(POINT_INITIAL)  -- 与初始位置的距离

            -- 判断是否需要返回：距离条件满足
            if f4_local1 <= f4_local3 or f4_local0 <= f4_local2 then
                if f4_local5 <= 1 then
                    -- 离初始位置很近，直接离开敌人
                    f4_arg1:ClearSubGoal()
                    f4_arg1:AddSubGoal(GOAL_COMMON_LeaveTarget, f4_local4, TARGET_ENE_0, 999, TARGET_ENE_0, true, -1)
                    return true
                else
                    -- 离初始位置较远，返回初始位置（带格挡）
                    f4_arg1:ClearSubGoal()
                    f4_arg1:AddSubGoal(GOAL_COMMON_BackToHome_With_Parry, f4_local4):SetTargetRange(COMMON_OBSERVE_SLOT_FINISH_BACKHOME, f4_local0, 999)
                    return true
                end
            end
        end
    end

    --[[
    中断处理4：目标超出范围时的重新规划
    触发条件：目标移动到AI的有效范围之外
    处理策略：触发AI重新规划路径和行为
    --]]
    if f4_arg0:IsInterupt(INTERUPT_TargetOutOfRange) and f4_arg0:IsTargetOutOfRangeInterruptSlot(COMMON_OBSERVE_SLOT_FINISH_BACKHOME) then
        -- 执行重新规划，重新评估当前情况和目标
        f4_arg0:Replanning()
        return true
    end

    --[[
    中断处理5：路径偏离后的重新定位
    触发条件：AI偏离了预定的移动路径
    处理策略：短暂等待后重新定位
    --]]
    if f4_arg0:IsInterupt(INTERUPT_WanderedOffPathRepath) then
        -- 清除当前目标，短暂等待重新定位
        f4_arg1:ClearSubGoal()
        f4_arg1:AddSubGoal(GOAL_COMMON_Wait, 0.1, TARGET_SELF, 0, 0, 0)
        return true
    end

    -- 没有处理任何中断
    return false
end

-- 注意：TopGoal_Update函数已在前面定义，此处为重复定义，已删除


