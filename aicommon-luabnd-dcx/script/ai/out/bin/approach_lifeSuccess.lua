--[[
生命成功接近目标系统
功能：实现在目标生命周期内持续接近目标的AI行为
用途：用于需要持续跟踪和接近目标直到目标死亡或任务完成的场景
特点：目标生命结束时返回Success，而不是Failed，适用于追击类任务
与普通接近的区别：目标死亡时视为成功而非失败
--]]

-- 注册该目标为无子目标类型，直接使用内部接近机制
REGISTER_GOAL_NO_SUB_GOAL(GOAL_COMMON_ApproachTarget_LifeSuccess, true)

--[[
生命成功接近目标激活函数
功能：初始化并启动生命成功接近行为
参数：
  f1_arg0 - AI实体对象
  f1_arg1 - 目标参数对象，包含接近配置信息
返回：无
逻辑流程：
  1. 获取传入的所有接近参数（参数0-6）
  2. 使用-1作为生命周期，表示无限持续
  3. 启动通用接近目标子目标，执行实际接近操作
特点：传递所有原始参数，保持接近行为的完整性
--]]
function ApproachTargetLifeSuccess_Activate(f1_arg0, f1_arg1)
    -- 启动通用接近目标子目标
    -- 使用-1作为生命周期，表示无限持续直到目标死亡或任务完成
    -- 传递所有原始参数（参数0-6）给通用接近目标系统
    f1_arg1:AddSubGoal(GOAL_COMMON_ApproachTarget, -1, f1_arg1:GetParam(0), f1_arg1:GetParam(1), f1_arg1:GetParam(2), f1_arg1:GetParam(3), f1_arg1:GetParam(4), f1_arg1:GetParam(5), f1_arg1:GetParam(6))

end

--[[
生命成功接近目标更新函数
功能：每帧检查接近状态和目标生命状态
参数：
  f2_arg0 - AI实体对象
  f2_arg1 - 目标参数对象
返回：
  GOAL_RESULT_Success - 当子目标完成或目标生命结束时
  GOAL_RESULT_Continue - 需要继续接近时
逻辑：
  1. 检查子目标数量，为0时表示接近完成
  2. 检查目标生命周期，结束时视为成功
  3. 其他情况继续执行接近
特点：目标死亡时返回Success而非Failed，适用于追击任务
--]]
function ApproachTargetLifeSuccess_Update(f2_arg0, f2_arg1)
    -- 检查子目标数量，为0表示接近目标子目标已完成
    if f2_arg1:GetSubGoalNum() <= 0 then
        return GOAL_RESULT_Success
    end

    -- 检查目标生命周期，如果结束则视为成功
    -- 这是生命成功接近的核心特性：目标死亡=任务成功
    if f2_arg1:GetLife() <= 0 then
        return GOAL_RESULT_Success
    end

    -- 其他情况继续执行接近行为
    return GOAL_RESULT_Continue

end

--[[
生命成功接近目标终止函数
功能：在接近目标结束时执行清理工作
参数：
  f3_arg0 - AI实体对象
  f3_arg1 - 目标参数对象
返回：无
逻辑：当前实现为空，因为主要清理工作由子目标处理
--]]
function ApproachTargetLifeSuccess_Terminate(f3_arg0, f3_arg1)

end

--[[
生命成功接近目标中断处理函数
功能：决定是否允许其他目标中断当前接近行为
参数：
  f4_arg0 - AI实体对象
  f4_arg1 - 目标参数对象
返回：false - 不允许中断，保持接近行为的连续性
逻辑：生命成功接近需要保持持续性，直到目标生命结束
重要性：确保追击任务的完整性，不会被其他事件打断
--]]
function ApproachTargetLifeSuccess_Interupt(f4_arg0, f4_arg1)
    return false

end


