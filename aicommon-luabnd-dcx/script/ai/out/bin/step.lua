-- ■ 步进攻击系统 - AI进阶攻击行为模块
-- 描述：处理AI的步进式攻击动作，支持连击和时机控制
-- 功能：管理攻击请求、状态检查和攻击完成判定
-- 用途：用于实现需要精确时机的攻击模式

REGISTER_DBG_GOAL_PARAM(GOAL_COMMON_Step, 0, "EzState番号", 0)  -- 注册调试参数：EzState编号
REGISTER_GOAL_UPDATE_TIME(GOAL_COMMON_Step, 0, 0)              -- 注册目标更新时间

-- ■ 步进攻击激活函数
-- 描述：初始化步进攻击行为，设置攻击请求
-- 参数：f1_arg0 - AI实体对象, f1_arg1 - 目标参数对象
-- 功能：从参数中获取EzState编号并设置攻击请求
function Step_Activate(f1_arg0, f1_arg1)
    local f1_local0 = f1_arg1:GetParam(0)  -- 获取EzState编号参数
    f1_arg0:SetAttackRequest(f1_local0)    -- 向AI发送攻击请求

end

-- ■ 步进攻击更新函数
-- 描述：每帧更新步进攻击状态，管理攻击执行过程
-- 参数：f2_arg0 - AI实体对象, f2_arg1 - 目标参数对象
-- 返回：GOAL_RESULT_Success - 攻击完成, GOAL_RESULT_Continue - 继续执行
function Step_Update(f2_arg0, f2_arg1)
    local f2_local0 = f2_arg1:GetParam(0)  -- 获取EzState编号
    local f2_local1 = false                -- 攻击完成标志

    -- ■ 攻击完成条件检查
    if f2_arg0:IsEnableComboAttack() == true then  -- 连击可用状态
        f2_local1 = true  -- 标记为完成
    end
    if f2_arg0:IsFinishAttack() == true then       -- 攻击动作结束
        f2_local1 = true  -- 标记为完成
    end

    -- 如果攻击完成条件满足，返回成功
    if f2_local1 == true then
        return GOAL_RESULT_Success
    end

    -- ■ 攻击请求维护
    -- 如果攻击尚未开始，重新发送攻击请求
    if f2_arg0:IsStartAttack() == false then
        f2_arg0:SetAttackRequest(f2_local0)  -- 重新设置攻击请求
    end

    return GOAL_RESULT_Continue  -- 继续执行攻击

end

-- ■ 步进攻击终止函数
-- 描述：步进攻击结束时的清理函数
-- 功能：执行必要的状态重置和资源清理
function Step_Terminate(f3_arg0, f3_arg1)

end

REGISTER_GOAL_NO_INTERUPT(GOAL_COMMON_Step, true)  -- 注册为不可中断目标

-- ■ 步进攻击中断处理函数
-- 描述：处理步进攻击过程中的中断事件
-- 返回：false - 不处理任何中断（因为设置为不可中断）
function Step_Interupt(f4_arg0, f4_arg1)
    return false  -- 步进攻击不接受中断

end


