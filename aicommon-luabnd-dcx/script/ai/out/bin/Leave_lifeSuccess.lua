--[[
生命成功撤离目标系统
功能：实现在目标生命周期内持续撤离目标的AI行为
用途：用于需要持续逃离或保持距离直到目标死亡或任务完成的场景
特点：目标生命结束时返回Success，适用于防御和逃脱类任务
与普通撤离的区别：目标死亡时视为成功而非失败，适用于防御战术
注意：使用Table Goal模式，支持更灵活的目标管理
--]]

-- 注册为Table Goal类型，支持更灵活的目标管理机制
RegisterTableGoal(GOAL_COMMON_LeaveTarget_LifeSuccess, "LeaveTargetLifeSuccess")
-- 注册该目标为无子目标类型，直接使用内部撤离机制
REGISTER_GOAL_NO_SUB_GOAL(GOAL_COMMON_LeaveTarget_LifeSuccess, true)

--[[
生命成功撤离目标激活函数
功能：初始化并启动生命成功撤离行为
参数：
  f1_arg0 - 未使用（Table Goal特性）
  f1_arg1 - AI实体对象
  f1_arg2 - 目标参数对象，包含撤离配置信息
返回：无
逻辑流程：
  1. 获取目标生命周期作为撤离持续时间
  2. 获取传入的所有撤离参数（参数0-6）
  3. 启动通用撤离目标子目标，执行实际撤离操作
特点：使用目标自己的生命周期，保证撤离持续到目标生命结束
--]]
Goal.Activate = function (f1_arg0, f1_arg1, f1_arg2)
    -- 启动通用撤离目标子目标
    -- 使用目标自己的生命周期作为撤离持续时间
    -- 传递所有原始参数（参数0-6）给通用撤离目标系统
    f1_arg2:AddSubGoal(GOAL_COMMON_LeaveTarget, f1_arg2:GetLife(), f1_arg2:GetParam(0), f1_arg2:GetParam(1), f1_arg2:GetParam(2), f1_arg2:GetParam(3), f1_arg2:GetParam(4), f1_arg2:GetParam(5), f1_arg2:GetParam(6))

end

--[[
生命成功撤离目标更新函数
功能：每帧检查撤离状态和目标生命状态
参数：
  f2_arg0 - 未使用（Table Goal特性）
  f2_arg1 - AI实体对象
  f2_arg2 - 目标参数对象
返回：
  GOAL_RESULT_Success - 当子目标完成或目标生命结束时
  GOAL_RESULT_Continue - 需要继续撤离时
逻辑：
  1. 检查子目标数量，为0时表示撤离完成
  2. 检查目标生命周期，结束时视为成功
  3. 其他情况继续执行撤离
特点：目标死亡时返回Success而非Failed，适用于防御战术
与Approach的区别：撤离远离目标而非接近目标
--]]
Goal.Update = function (f2_arg0, f2_arg1, f2_arg2)
    -- 检查子目标数量，为0表示撤离目标子目标已完成
    if f2_arg2:GetSubGoalNum() <= 0 then
        return GOAL_RESULT_Success
    end

    -- 检查目标生命周期，如果结束则视为成功
    -- 这是生命成功撤离的核心特性：目标死亡=任务成功
    if f2_arg2:GetLife() <= 0 then
        return GOAL_RESULT_Success
    end

    -- 其他情况继续执行撤离行为
    return GOAL_RESULT_Continue

end


