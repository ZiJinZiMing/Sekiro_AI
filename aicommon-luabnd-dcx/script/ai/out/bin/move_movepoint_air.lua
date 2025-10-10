--[[
空中移动到移动点AI脚本 - GOAL_COMMON_MoveToMovePointAir
用途：控制AI在空中状态下移动到指定的移动点
适用场景：飞行敌人、空中单位、垂直移动等特殊移动需求
特点：支持三维空间中的精确定位移动

参数说明：
参数0: 目标移动点ID或坐标X
参数1: 移动方式或速度参数
参数2: 移动距离或坐标Y
参数3: 高度参数或坐标Z
参数4: 其他移动配置参数

应用场景：
- 飞行敌人的路径移动
- 垂直攀爬或下降
- 空中巡逻路线
- 三维空间中的精确定位
--]]
function MoveToMovePointAir_Activate(f1_arg0, f1_arg1)
    -- 获取移动相关参数
    local f1_local0 = f1_arg1:GetParam(0)  -- 目标移动点ID或X坐标
    local f1_local1 = f1_arg1:GetParam(1)  -- 移动方式参数（未使用）
    local f1_local2 = f1_arg1:GetParam(2)  -- 移动距离或Y坐标
    local f1_local3 = f1_arg1:GetParam(3)  -- 高度参数或Z坐标（未使用）
    local f1_local4 = f1_arg1:GetParam(4)  -- 其他配置参数（未使用）

    -- 设置AI的固定移动目标
    -- 参数：目标ID/坐标, 距离/Y坐标, Z轴高度(0表示使用默认高度)
    -- 这个函数专门用于空中移动，可以处理三维空间的移动
    f1_arg0:SetAIFixedMoveTarget(f1_local0, f1_local2, 0)

end

--[[
空中移动更新函数
功能：每帧更新移动状态，维持移动行为
返回：GOAL_RESULT_Continue - 持续执行移动
说明：空中移动通常需要持续的控制和调整，直到到达目标点
--]]
function MoveToMovePointAir_Update(f2_arg0, f2_arg1)
    -- 返回继续执行状态，保持移动的持续性
    -- 空中移动需要持续的路径调整和状态监控
    return GOAL_RESULT_Continue

end

--[[
空中移动终止函数
功能：移动结束时的清理工作
参数：f3_arg0 - AI实体对象, f3_arg1 - 目标参数对象
说明：空中移动结束时通常不需要特殊清理，AI会自动恢复正常状态
--]]
function MoveToMovePointAir_Terminate(f3_arg0, f3_arg1)
    -- 空中移动结束时无需特殊清理
    -- 移动目标会自动清除，AI恢复正常行为状态

end

-- 注册空中移动为不可中断目标
-- 确保移动过程的连续性，避免在空中被意外中断导致异常
REGISTER_GOAL_NO_INTERUPT(GOAL_COMMON_MoveToMovePointAir, true)

--[[
空中移动中断检查函数
功能：检查是否允许中断当前的空中移动
返回：false - 不允许中断
说明：空中移动不应被中断，以确保移动的安全性和连续性
重要性：防止AI在空中移动过程中被意外中断，导致位置异常或卡顿
--]]
function MoveToMovePointAir_Interupt(f4_arg0, f4_arg1)
    -- 空中移动不允许被中断
    -- 这确保AI能够安全地完成空中移动，避免在移动过程中出现异常状态
    return false

end


