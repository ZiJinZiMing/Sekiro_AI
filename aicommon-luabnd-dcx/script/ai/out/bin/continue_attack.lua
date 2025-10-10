--[[
持续攻击系统
功能：实现持续无间断攻击直到满足停止条件的AI行为
用途：用于需要持续输出攻击的情况，如连续攻击、压制攻击等
特点：直接使用攻击请求而非子目标，更加直接和高效
与普通攻击的区别：不使用子目标，直接控制攻击状态，反应更快
--]]

-- 参数0：EzState动画状态编号，指定要持续执行的攻击动画
REGISTER_DBG_GOAL_PARAM(GOAL_COMMON_ContinueAttack, 0, "EzState番号", 0)
-- 参数1：攻击目标类型，决定持续攻击的目标选择
REGISTER_DBG_GOAL_PARAM(GOAL_COMMON_ContinueAttack, 1, "攻撃対象【Type】", 0)
-- 参数2：成功距离（米），超过此距离则攻击失败
REGISTER_DBG_GOAL_PARAM(GOAL_COMMON_ContinueAttack, 2, "成功距離【ｍ】", 0)
-- 参数3：命中后是否成功，决定命中目标后是否停止攻击
REGISTER_DBG_GOAL_PARAM(GOAL_COMMON_ContinueAttack, 3, "命中したら成功？", 0)

--[[
持续攻击激活函数
功能：初始化并启动持续攻击行为
参数：
  f1_arg0 - AI实体对象
  f1_arg1 - 目标参数对象，包含持续攻击配置信息
返回：无
逻辑流程：
  1. 获取攻击动画和目标参数
  2. 转向目标并设置攻击请求
  3. 记录進队伍攻击协调信息
特点：直接发送攻击请求，不通过子目标，提高执行效率
--]]
function ContinueAttack_Activate(f1_arg0, f1_arg1)
    -- 获取攻击动画状态ID
    local f1_local0 = f1_arg1:GetParam(0)
    -- 获取攻击目标类型
    local f1_local1 = f1_arg1:GetParam(1)

    -- 转向目标，确保攻击方向正确
    f1_arg0:TurnTo(f1_local1)
    -- 直接设置攻击请求，开始持续攻击
    f1_arg0:SetAttackRequest(f1_local0)
    -- 添加目标范围内的队伍记录，用于攻击协调
    f1_arg1:AddGoalScopedTeamRecord(COORDINATE_TYPE_Attack, f1_local1, 0)

end

--[[
持续攻击更新函数
功能：每帧检查持续攻击的停止条件和状态
参数：
  f2_arg0 - AI实体对象
  f2_arg1 - 目标参数对象
返回：
  GOAL_RESULT_Failed - 距离过远攻击失败时
  GOAL_RESULT_Success - 目标死亡或攻击命中时
  GOAL_RESULT_Continue - 需要继续攻击时
逻辑流程：
  1. 检查攻击距离，超出范围则失败
  2. 检查目标生命状态，死亡则成功
  3. 检查攻击命中状态（如果启用），命中则成功
  4. 继续转向目标并发送攻击请求
--]]
function ContinueAttack_Update(f2_arg0, f2_arg1)
    -- 获取攻击参数
    local f2_local0 = f2_arg1:GetParam(0)  -- 攻击动画状态ID
    local f2_local1 = f2_arg1:GetParam(1)  -- 攻击目标类型
    local f2_local2 = f2_arg1:GetParam(2)  -- 成功距离
    local f2_local3 = f2_arg1:GetParam(3)  -- 命中成功标志

    -- 获取当前到目标的距离
    local f2_local4 = f2_arg0:GetDist(f2_local1)

    -- 检查距离条件：如果距离过远则攻击失败
    if f2_local2 <= f2_local4 then
        return GOAL_RESULT_Failed
    -- 检查目标生命状态：目标死亡则攻击成功
    elseif f2_arg1:GetLife() <= 0 then
        return GOAL_RESULT_Success
    -- 检查攻击命中条件：如果启用了命中成功模式且攻击命中
    elseif f2_local3 == true and f2_arg0:IsHitAttack() == true then
        return GOAL_RESULT_Success
    end

    -- 继续持续攻击：转向目标并发送攻击请求
    f2_arg0:TurnTo(f2_local1)
    f2_arg0:SetAttackRequest(f2_local0)
    return GOAL_RESULT_Continue

end

--[[
持续攻击终止函数
功能：在持续攻击结束时执行清理工作
参数：
  f3_arg0 - AI实体对象
  f3_arg1 - 目标参数对象
返回：无
逻辑：攻击请求会自动清理，无需额外操作
--]]
function ContinueAttack_Terminate(f3_arg0, f3_arg1)

end

-- 注册该目标为不可中断类型，确保持续攻击的连续性
REGISTER_GOAL_NO_INTERUPT(GOAL_COMMON_ContinueAttack, true)

--[[
持续攻击中断处理函数
功能：决定是否允许其他目标中断当前持续攻击
参数：
  f4_arg0 - AI实体对象
  f4_arg1 - 目标参数对象
返回：false - 不允许中断，保持持续攻击的连续性
逻辑：持续攻击的核心就是不被中断，直到满足停止条件
重要性：确保攻击的持续压制效果，不被其他事件打断
--]]
function ContinueAttack_Interupt(f4_arg0, f4_arg1)
    return false

end


