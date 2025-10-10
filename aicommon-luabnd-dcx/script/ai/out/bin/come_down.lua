--[[
下降行为系统
功能：实现AI从高处下降到目标高度的智能控制
用途：用于高空单位的下降攻击、垂直移动、高度调整等场景
特点：使用特殊攻击ID 9510来控制下降动作，并实时监控高度变化
应用场景：空中敌人下降攻击、高台跳跃、垂直追击等
--]]

-- 设置目标更新频率：最小0.5秒，最大0.5秒（即固定0.5秒更新一次）
REGISTER_GOAL_UPDATE_TIME(GOAL_COMMON_ComeDown, 0.5, 0.5)
-- 注册为不可中断目标，确保下降过程的安全性和连续性
REGISTER_GOAL_NO_INTERUPT(GOAL_COMMON_ComeDown, true)

--[[
下降行为激活函数
功能：初始化并启动下降行为
参数：
  f1_arg0 - AI实体对象
  f1_arg1 - 目标参数对象，包含下降配置信息
返回：无
逻辑流程：
  使用特殊攻击ID 9510来执行下降动作，该ID对应特定的下降动画
  目标设为TARGET_NONE（无目标），距离设为DIST_None（无距离限制）
特点：下降是自主动作，不需要特定目标，只需要触发下降动画
--]]
function ComeDown_Activate(f1_arg0, f1_arg1)
    -- 添加通用攻击子目标，使用特殊攻击ID 9510来执行下降动作
    -- 参数：生命周期，攻击ID 9510（下降动作），无目标，无距离限制
    f1_arg1:AddSubGoal(GOAL_COMMON_Attack, f1_arg1:GetLife(), 9510, TARGET_NONE, DIST_None)

end

--[[
下降行为更新函数
功能：每帧监控下降状态和高度变化，管理下降过程
参数：
  f2_arg0 - AI实体对象
  f2_arg1 - 目标参数对象
返回：
  GOAL_RESULT_Failed - 当AI已经着陆时（不需要下降）
  GOAL_RESULT_Success - 当達到目标高度时
  GOAL_RESULT_Continue - 需要继续下降时
逻辑流程：
  1. 初始化状态标志（设置数值0为0）
  2. 检查AI是否已经着陆，如果是则返回Failed
  3. 检查下降子目标的执行结果，必要时重新添加
  4. 检查当前高度差，达到目标高度则返回Success
--]]
function ComeDown_Update(f2_arg0, f2_arg1)
    -- 初始化状态标志，设置数值0为0（表示正在下降）
    f2_arg0:SetNumber(0, 0)

    -- 获取目标高度差参数（参数0）
    local f2_local0 = f2_arg1:GetParam(0)

    -- 检查AI是否已经着陆，如果已经在地面上则不需要下降
    if f2_arg0:IsLanding() then
        return GOAL_RESULT_Failed
    end

    -- 检查最后一个子目标（下降攻击）的执行结果
    local f2_local1 = f2_arg1:GetLastSubGoalResult()
    if f2_local1 == GOAL_RESULT_Success or f2_local1 == GOAL_RESULT_Failed then
        -- 如果下降攻击完成，检查是否需要继续下降
        local f2_local2 = f2_arg0:GetDistY(TARGET_ENE_0)  -- 获取与敌人的Y轴距离差
        if f2_local2 < f2_local0 then
            -- 如果还没有达到目标高度，继续添加下降攻击
            f2_arg1:AddSubGoal(GOAL_COMMON_Attack, f2_arg1:GetLife(), 9510, TARGET_NONE, DIST_None)
        end
    end

    -- 再次检查当前高度差，决定是否完成下降
    local f2_local2 = f2_arg0:GetDistY(TARGET_ENE_0)
    if f2_local2 <= f2_local0 then
        -- 达到目标高度，设置成功标志并返回Success
        f2_arg0:SetNumber(0, 1)  -- 设置数值0为1（表示下降完成）
        return GOAL_RESULT_Success
    end

    -- 继续下降过程
    return GOAL_RESULT_Continue

end

--[[
下降行为终止函数
功能：在下降行为结束时执行清理工作
参数：
  f3_arg0 - AI实体对象
  f3_arg1 - 目标参数对象
返回：无
逻辑：当前实现为空，状态标志会自动清理
--]]
function ComeDown_Terminate(f3_arg0, f3_arg1)

end

--[[
下降行为中断处理函数
功能：决定是否允许其他目标中断当前下降行为
参数：
  f4_arg0 - AI实体对象
  f4_arg1 - 目标参数对象
返回：false - 不允许中断，确保下降过程的安全性
逻辑：下降过程不能被中断，以防止AI在空中出现异常状态
重要性：保证高空移动的安全性，防止意外情况导致的问题
--]]
function ComeDown_Interupt(f4_arg0, f4_arg1)
    return false

end


