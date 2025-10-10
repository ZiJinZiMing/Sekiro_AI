--[[
持续攻击AI脚本 - GOAL_COMMON_EndureAttack
用途：执行不可中断的持续攻击，在攻击过程中保持韧性
特点：攻击期间启用霸体状态，不会被敌人攻击打断

调试参数说明：
参数0: EzStateID - 攻击动作的状态ID
参数1: 攻击对象 - 目标敌人的索引或类型
参数2: 成功距离 - 攻击判定的有效距离
参数3: 攻击前旋回时间 - 攻击前的转身调整时间
参数4: 正面判定角度 - 判定为正面攻击的角度范围
参数5: 上攻击角度 - 向上攻击的角度限制
参数6: 下攻击角度 - 向下攻击的角度限制
--]]
REGISTER_DBG_GOAL_PARAM(GOAL_COMMON_EndureAttack, 0, "EzStateID", 0)
REGISTER_DBG_GOAL_PARAM(GOAL_COMMON_EndureAttack, 1, "攻撃対象", 0)
REGISTER_DBG_GOAL_PARAM(GOAL_COMMON_EndureAttack, 2, "成功距離", 0)
REGISTER_DBG_GOAL_PARAM(GOAL_COMMON_EndureAttack, 3, "攻撃前旋回時間", 0)
REGISTER_DBG_GOAL_PARAM(GOAL_COMMON_EndureAttack, 4, "正面判定角度", 0)
REGISTER_DBG_GOAL_PARAM(GOAL_COMMON_EndureAttack, 5, "上攻撃角度", 0)
REGISTER_DBG_GOAL_PARAM(GOAL_COMMON_EndureAttack, 6, "下攻撃角度", 0)

--[[
持续攻击激活函数
功能：初始化持续攻击行为，设置攻击参数并启用霸体状态
参数：f1_arg0 - AI实体对象, f1_arg1 - 目标参数对象
特点：攻击期间不会被中断，保证攻击的连续性和威胁性
--]]
function EndureAttack_Activate(f1_arg0, f1_arg1)
    -- 获取目标的生命值，用于持续时间计算
    local f1_local0 = f1_arg1:GetLife()

    -- 获取攻击相关参数
    local f1_local1 = f1_arg1:GetParam(0)  -- 攻击动作ID
    local f1_local2 = f1_arg1:GetParam(1)  -- 攻击目标
    local f1_local3 = f1_arg1:GetParam(2)  -- 成功距离

    -- 设置旋转角度限制为180度（半圆范围）
    local f1_local4 = 180

    -- 获取时间和角度参数
    local f1_local5 = f1_arg1:GetParam(3)  -- 攻击前旋回时间
    local f1_local6 = f1_arg1:GetParam(4)  -- 正面判定角度

    -- 设置默认值（如果参数无效）
    if f1_local5 < 0 then
        f1_local5 = 1.5  -- 默认旋回时间1.5秒
    end
    if f1_local6 < 0 then
        f1_local6 = 20   -- 默认正面角度20度
    end

    -- 设置攻击行为标志
    local f1_local7 = true   -- 启用持续攻击标志
    local f1_local8 = false  -- 禁用某些中断条件
    local f1_local9 = true   -- 启用攻击追踪
    local f1_local10 = false -- 禁用其他行为
    local f1_local11 = false -- 禁用额外检查

    -- 获取垂直攻击角度参数
    local f1_local12 = f1_arg1:GetParam(5)  -- 上攻击角度
    local f1_local13 = f1_arg1:GetParam(6)  -- 下攻击角度

    -- 添加通用攻击子目标，传递所有配置参数
    f1_arg1:AddSubGoal(GOAL_COMMON_CommonAttack, f1_local0, f1_local1, f1_local2, f1_local3, f1_local4, f1_local5, f1_local6, f1_local8, f1_local9, f1_local10, f1_local11, f1_local12, f1_local13, f1_local7)

    -- 启用霸体状态，防止攻击被中断
    -- 这是持续攻击的关键特性，确保攻击动作的完整执行
    f1_arg0:SetEnableEndureCancel_forGoal()

end

--[[
持续攻击更新函数
功能：每帧更新持续攻击状态
返回：GOAL_RESULT_Continue - 持续执行攻击
说明：持续攻击通常不需要复杂的状态判断，直接继续执行
--]]
function EndureAttack_Update(f2_arg0, f2_arg1)
    -- 返回继续执行状态，保持攻击的持续性
    -- 霸体状态下的攻击不会被轻易中断
    return GOAL_RESULT_Continue

end

--[[
持续攻击终止函数
功能：攻击结束时清理霸体状态和相关标志
参数：f3_arg0 - AI实体对象, f3_arg1 - 目标参数对象
重要性：必须正确清理状态，避免影响后续AI行为
--]]
function EndureAttack_Terminate(f3_arg0, f3_arg1)
    -- 清除霸体状态，恢复正常的可中断状态
    -- 这确保AI在攻击结束后能够正常响应外部事件
    f3_arg0:ClearEnableEndureCancel_forGoal()

end

-- 注册持续攻击为不可中断目标
-- 这是系统级设置，确保该类型攻击的优先级和连续性
REGISTER_GOAL_NO_INTERUPT(GOAL_COMMON_EndureAttack, true)

--[[
持续攻击中断检查函数
功能：检查是否允许中断当前的持续攻击
返回：false - 不允许中断
说明：持续攻击的核心特性就是不可中断，因此总是返回false
应用场景：当外部事件尝试打断攻击时，此函数会阻止中断
--]]
function EndureAttack_Interupt(f4_arg0, f4_arg1)
    -- 持续攻击不允许被中断，这是其核心特征
    -- 无论外部条件如何变化，都要完成当前攻击动作
    return false

end


