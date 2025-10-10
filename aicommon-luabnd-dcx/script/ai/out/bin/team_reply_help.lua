--[[
团队回应帮助行为激活函数
功能：响应队友的求助信号，执行支援行为
使用场景：收到team_call_help.lua发出的求助信号时触发
战术意图：通过团队协作形成战术支援，提高战斗效率
系统集成：与call_team.lua和team_call_help.lua形成完整的团队AI系统
--]]
function TeamReplyHelp_Activate(f1_arg0, f1_arg1)
    -- 获取响应帮助的最小和最大等待时间参数
    -- 用于控制AI响应求助的延迟，模拟真实的反应时间
    local f1_local0 = f1_arg0:GetExcelParam(AI_EXCEL_THINK_PARAM_TYPE__callHelp_MinWaitTime)
    local f1_local1 = f1_arg0:GetExcelParam(AI_EXCEL_THINK_PARAM_TYPE__callHelp_MaxWaitTime)

    -- 在最小和最大等待时间之间随机选择一个延迟时间
    -- 避免所有AI同时响应，创造更自然的团队行为
    local f1_local2 = f1_arg0:GetRandam_Float(f1_local0, f1_local1)

    -- 添加等待子目标，延迟响应以模拟真实的反应时间
    f1_arg1:AddSubGoal(GOAL_COMMON_Wait, f1_local2, TARGET_SELF)

    -- 向AI系统发送团队帮助回应信号
    -- 标记此AI已经响应了求助请求
    f1_arg0:TeamHelp_Reply()

    -- 获取回应动作ID（如点头、应答手势等）
    local f1_local3 = f1_arg0:GetExcelParam(AI_EXCEL_THINK_PARAM_TYPE__callHelp_ReplyActionId)

    -- 如果定义了回应动作，则执行该动作
    -- -1表示没有定义特定的回应动作
    if f1_local3 ~= -1 then
        -- 执行回应动作，向求助者表示收到信号
        f1_arg1:AddSubGoal(GOAL_COMMON_Attack, f1_arg1:GetLife(), f1_local3, TARGET_FRI_0, DIST_None)
    end
    -- 定义团队回应行为类型常量
    -- 这些常量控制AI如何响应队友的求助信号
    local f1_local4 = 0   -- 类型0：快速移动到求助者位置（可达时）
    local f1_local5 = 1   -- 类型1：正常移动到求助者位置（非可达）
    local f1_local6 = 2   -- 类型2：快速移动到求助者位置（可达时）
    local f1_local7 = 3   -- 类型3：正常移动到求助者位置（非可达）
    local f1_local8 = 4   -- 类型4：无特定行为
    local f1_local9 = 5   -- 类型5：无特定行为
    local f1_local10 = 6  -- 类型6：移动到固定位置点
    local f1_local11 = 7  -- 类型7：移动到固定位置点

    -- 获取当前AI的回应行为类型设置
    local f1_local12 = f1_arg0:GetExcelParam(AI_EXCEL_THINK_PARAM_TYPE__callHelp_ReplyBehaviorType)
    -- 根据回应行为类型执行相应的支援行为
    if f1_local12 == f1_local4 then
        -- 行为类型0：可达性快速支援
        -- 检查与求助队友的距离
        local f1_local13 = f1_arg0:GetDist(TARGET_FRI_0)
        if f1_local13 > 3 then
            -- 距离超过3米时，快速移动到队友位置（可达性移动）
            -- 参数：目标生命时间、目标队友、中心方向、2.5米范围、自身为基准、可达性移动
            f1_arg1:AddSubGoal(GOAL_COMMON_MoveToSomewhere, f1_arg1:GetLife(), TARGET_FRI_0, AI_DIR_TYPE_CENTER, 2.5, TARGET_SELF, true)
        else
            -- 距离较近时，保持当前位置并面向队友
            f1_arg1:AddSubGoal(GOAL_COMMON_Stay, f1_arg1:GetLife(), 0, TARGET_FRI_0)
        end

    elseif f1_local12 == f1_local5 then
        -- 行为类型1：正常速度支援
        -- 检查与求助队友的距离
        local f1_local13 = f1_arg0:GetDist(TARGET_FRI_0)
        if f1_local13 > 3 then
            -- 距离超过3米时，正常移动到队友位置（非可达性移动）
            -- false参数表示不使用可达性检查，可能穿越障碍
            f1_arg1:AddSubGoal(GOAL_COMMON_MoveToSomewhere, f1_arg1:GetLife(), TARGET_FRI_0, AI_DIR_TYPE_CENTER, 2.5, TARGET_SELF, false)
        else
            -- 距离较近时，保持当前位置并面向队友
            f1_arg1:AddSubGoal(GOAL_COMMON_Stay, f1_arg1:GetLife(), 0, TARGET_FRI_0)
        end

    elseif f1_local12 == f1_local6 then
        -- 行为类型2：可达性快速支援（重复类型0的行为）
        local f1_local13 = f1_arg0:GetDist(TARGET_FRI_0)
        if f1_local13 > 3 then
            f1_arg1:AddSubGoal(GOAL_COMMON_MoveToSomewhere, f1_arg1:GetLife(), TARGET_FRI_0, AI_DIR_TYPE_CENTER, 2.5, TARGET_SELF, true)
        else
            f1_arg1:AddSubGoal(GOAL_COMMON_Stay, f1_arg1:GetLife(), 0, TARGET_FRI_0)
        end

    elseif f1_local12 == f1_local7 then
        -- 行为类型3：正常速度支援（重复类型1的行为）
        local f1_local13 = f1_arg0:GetDist(TARGET_FRI_0)
        if f1_local13 > 3 then
            f1_arg1:AddSubGoal(GOAL_COMMON_MoveToSomewhere, f1_arg1:GetLife(), TARGET_FRI_0, AI_DIR_TYPE_CENTER, 2.5, TARGET_SELF, false)
        else
            f1_arg1:AddSubGoal(GOAL_COMMON_Stay, f1_arg1:GetLife(), 0, TARGET_FRI_0)
        end
    elseif f1_local12 == f1_local8 then
        -- 行为类型4：无特定支援行为
        -- AI收到求助信号但不执行移动，可能用于特殊角色或守卫型AI

    elseif f1_local12 == f1_local9 then
        -- 行为类型5：无特定支援行为
        -- 与类型4相同，为不同类型AI提供的预留行为类型

    elseif f1_local12 == f1_local10 then
        -- 行为类型6：移动到预设固定位置点
        -- 用于有特定站位要求的AI，如守卫巡逻点或战略位置
        local f1_local13 = f1_arg0:GetDist(POINT_AI_FIXED_POS)
        if f1_local13 > 2 then
            -- 距离固定点超过2米时，移动到该位置
            -- 使用较小的距离阈值，确保精确定位
            f1_arg1:AddSubGoal(GOAL_COMMON_MoveToSomewhere, f1_arg1:GetLife(), POINT_AI_FIXED_POS, AI_DIR_TYPE_CENTER, 2.5, TARGET_SELF, false)
        else
            -- 已在固定点附近，保持位置并面向固定点
            f1_arg1:AddSubGoal(GOAL_COMMON_Stay, f1_arg1:GetLife(), 0, POINT_AI_FIXED_POS)
        end

    elseif f1_local12 == f1_local11 then
        -- 行为类型7：移动到预设固定位置点（与类型6相同）
        -- 为不同AI类型提供的重复行为选项
        local f1_local13 = f1_arg0:GetDist(POINT_AI_FIXED_POS)
        if f1_local13 > 2 then
            f1_arg1:AddSubGoal(GOAL_COMMON_MoveToSomewhere, f1_arg1:GetLife(), POINT_AI_FIXED_POS, AI_DIR_TYPE_CENTER, 2.5, TARGET_SELF, false)
        else
            f1_arg1:AddSubGoal(GOAL_COMMON_Stay, f1_arg1:GetLife(), 0, POINT_AI_FIXED_POS)
        end
    end
    
end

--[[
团队回应帮助行为更新函数
功能：监控回应帮助行为的执行状态
实现：由于回应行为主要在Activate中通过子目标完成，此函数为空实现
说明：所有的支援行为都通过子目标系统自动管理，无需额外更新逻辑
--]]
function TeamReplyHelp_Update(f2_arg0, f2_arg1)
    -- 空实现：回应帮助行为通过子目标系统自动执行
    -- 无需额外的更新逻辑，子目标会自动处理移动和停留行为

end

--[[
团队回应帮助行为终止函数
功能：清理回应帮助行为的相关状态
实现：当前为空实现，可能在未来版本中添加清理逻辑
说明：子目标系统会自动处理行为终止，无需手动清理
--]]
function TeamReplyHelp_Terminate(f3_arg0, f3_arg1)
    -- 空实现：子目标系统自动处理行为终止
    -- 可在此处添加特殊的清理逻辑，如状态重置或通知其他系统

end

-- 注册目标类型，指定此目标不可被中断
-- 确保团队回应过程的完整性，避免支援行为被意外打断
REGISTER_GOAL_NO_INTERUPT(GOAL_COMMON_TeamReplyHelp, true)

--[[
团队回应帮助行为中断检查函数
功能：检查是否允许中断当前的回应帮助行为
返回值：false表示不允许中断，确保支援流程的完整性
设计理念：团队协作行为应保持连续性，避免因其他事件中断支援
战术考虑：确保AI能够完成对队友的支援承诺，维持团队战术的有效性
--]]
function TeamReplyHelp_Interupt(f4_arg0, f4_arg1)
    -- 始终返回false，不允许中断回应帮助过程
    -- 这保证了团队AI系统的可靠性和战术执行的一致性
    return false

end


