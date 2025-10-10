--[[
路径失败时接近目标系统
功能：在导航路径失败情况下的智能接近机制
用途：用于处理复杂地形或障碍物导致的路径规划失败问题
特点：定时检查路径可用性，并在路径恢复时自动结束
应用场景：地形复杂、动态障碍物、多层结构等环境
--]]

--[[
路径失败时接近目标激活函数
功能：初始化路径失败处理机制并启动接近行为
参数：
  f1_arg0 - AI实体对象
  f1_arg1 - 目标参数对象，包含路径检查和接近配置
返回：无
逻辑流程：
  1. 设置路径检查定时器（参数0）
  2. 获取接近目标的相关参数（参数1-5）
  3. 启动通用接近目标子目标，尝试继续接近
特点：在路径不可用情况下仍然尝试接近，并定时检查路径恢复
--]]
function ApproachOnFailedPath_Activate(f1_arg0, f1_arg1)
    -- 获取路径检查间隔时间（参数0）
    local f1_local0 = f1_arg1:GetParam(0)
    -- 设置定时器，用于定期检查路径是否恢复
    f1_arg1:SetTimer(0, f1_local0)

    -- 获取接近目标的相关参数
    local f1_local1 = f1_arg1:GetParam(1)  -- 接近目标类型
    local f1_local2 = f1_arg1:GetParam(2)  -- 接近距离
    local f1_local3 = f1_arg1:GetParam(3)  -- 接近参数3
    local f1_local4 = f1_arg1:GetParam(4)  -- 接近参数4
    local f1_local5 = f1_arg1:GetParam(5)  -- 接近参数5

    -- 添加通用接近目标子目标，即使路径失败也要尝试接近
    -- 使用-1作为生命周期，表示持续尝试
    f1_arg1:AddSubGoal(GOAL_COMMON_ApproachTarget, -1, f1_local1, f1_local2, f1_local3, f1_local4, f1_local5)

end

--[[
路径失败时接近目标更新函数
功能：每帧监控路径状态和接近进度，管理路径恢复检查
参数：
  f2_arg0 - AI实体对象
  f2_arg1 - 目标参数对象
返回：
  GOAL_RESULT_Success - 当路径恢复可用时
  GOAL_RESULT_Continue - 需要继续处理时
逻辑流程：
  1. 检查路径检查定时器是否超时
  2. 如果超时，检查到目标的路径是否已恢复
  3. 路径恢复则返回Success，否则重置定时器
  4. 管理接近子目标，必要时重新添加
--]]
function ApproachOnFailedPath_Update(f2_arg0, f2_arg1)
    local f2_local0 = GOAL_RESULT_Continue

    -- 检查路径检查定时器是否超时
    if true == f2_arg1:IsFinishTimer(0) then
        -- 检查到敌人0的路径是否存在
        -- 参数：目标敌人0，左侧方向，0.5米距离，0角度偏移
        local f2_local1 = f2_arg0:CheckDoesExistPath(TARGET_ENE_0, AI_DIR_TYPE_L, 0.5, 0)
        if true == f2_local1 then
            -- 路径已恢复，返回成功结束该目标
            f2_local0 = GOAL_RESULT_Success
        else
            -- 路径仍然不可用，重置检查定时器
            local f2_local2 = f2_arg1:GetParam(0)
            f2_arg1:SetTimer(0, f2_local2)
        end
    end

    -- 检查接近子目标是否存在，如果不存在则重新添加
    if f2_arg1:GetSubGoalNum() <= 0 then
        -- 重新获取接近参数
        local f2_local1 = f2_arg1:GetParam(1)  -- 接近目标类型
        local f2_local2 = f2_arg1:GetParam(2)  -- 接近距离
        local f2_local3 = f2_arg1:GetParam(3)  -- 接近参数3
        local f2_local4 = f2_arg1:GetParam(4)  -- 接近参数4
        local f2_local5 = f2_arg1:GetParam(5)  -- 接近参数5

        -- 重新添加接近子目标，继续尝试接近
        f2_arg1:AddSubGoal(GOAL_COMMON_ApproachTarget, -1, f2_local1, f2_local2, f2_local3, f2_local4, f2_local5)
    end

    return f2_local0

end

--[[
路径失败时接近目标终止函数
功能：在接近行为结束时执行清理工作
参数：
  f3_arg0 - AI实体对象
  f3_arg1 - 目标参数对象
返回：无
逻辑：当前实现为空，定时器会自动清理
--]]
function ApproachOnFailedPath_Terminate(f3_arg0, f3_arg1)

end

--[[
路径失败时接近目标中断处理函数
功能：检查是否允许特定中断事件打断当前接近行为
参数：
  f4_arg0 - AI实体对象
  f4_arg1 - 目标参数对象
返回：
  true - 允许中断，当移动结束于路径失败时
  false - 不允许其他中断
逻辑：
  只允许INTERUPT_MovedEnd_OnFailedPath中断，这是在路径失败后移动结束的特定事件
  其他中断事件都不允许，保持路径失败处理的连续性
重要性：确保在复杂环境中的导航问题得到适当处理
--]]
function ApproachOnFailedPath_Interupt(f4_arg0, f4_arg1)
    -- 检查是否有“移动结束于路径失败”中断
    if f4_arg0:IsInterupt(INTERUPT_MovedEnd_OnFailedPath) then
        return true  -- 允许这种特定中断
    end
    -- 其他情况不允许中断
    return false

end


