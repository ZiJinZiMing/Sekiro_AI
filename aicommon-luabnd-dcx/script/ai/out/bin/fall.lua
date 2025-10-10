--[[
坠落AI脚本 - GOAL_COMMON_Fall
用途：控制AI的坠落行为，包括坠落开始、过程和结束的处理
适用场景：高处跌落、被击落、主动跳跃等垂直移动情况
特点：实时监控高度变化，自动触发相应的动作状态

更新频率设置：0.1-0.2秒间隔，频繁检查高度变化
不可中断：确保坠落过程的完整性，避免状态异常

调试参数说明：
参数0: 目标类型 - 坠落目标点或参考对象
参数1: 坠落开始EzState编号 - 坠落过程中执行的动作状态
参数2: 坠落停止EzState编号 - 坠落结束时执行的着陆动作
参数3: 坠落停止边界值[米] - 距离地面多远时停止坠落检查
--]]
REGISTER_GOAL_UPDATE_TIME(GOAL_COMMON_Fall, 0.1, 0.2)
REGISTER_GOAL_NO_INTERUPT(GOAL_COMMON_Fall, true)
REGISTER_DBG_GOAL_PARAM(GOAL_COMMON_Fall, 0, "ターゲット【Type】", 0)
REGISTER_DBG_GOAL_PARAM(GOAL_COMMON_Fall, 1, "落下開始EzState番号", 0)
REGISTER_DBG_GOAL_PARAM(GOAL_COMMON_Fall, 2, "落下停止EzState番号", 0)
REGISTER_DBG_GOAL_PARAM(GOAL_COMMON_Fall, 3, "落下停止マージン[m]", 0)

--[[
坠落激活函数
功能：初始化坠落行为，检查初始高度并启动相应动作
参数：f1_arg0 - AI实体对象, f1_arg1 - 目标参数对象
逻辑：如果AI已经在目标位置下方，立即开始坠落动作
--]]
function Fall_Activate(f1_arg0, f1_arg1)
    -- 获取目标参考点（通常是地面或着陆点）
    local f1_local0 = f1_arg1:GetParam(0)

    -- 获取坠落过程中的动作状态ID
    local f1_local1 = f1_arg1:GetParam(1)

    -- 计算与目标的垂直距离（带符号，负值表示在目标下方）
    local f1_local2 = f1_arg0:GetDistYSigned(f1_local0)

    -- 如果已经在目标位置或下方，立即开始坠落动作
    if f1_local2 <= 0 then
        -- 设置坠落动作请求，触发坠落动画
        f1_arg0:SetAttackRequest(f1_local1)
    end

end

--[[
坠落更新函数
功能：每帧检查坠落状态，监控高度变化并判断是否着陆
返回：GOAL_RESULT_Success(着陆成功) 或 GOAL_RESULT_Continue(继续坠落)
检查频率：0.1-0.2秒间隔，确保实时监控
--]]
function Fall_Update(f2_arg0, f2_arg1)
    -- 获取目标参考点
    local f2_local0 = f2_arg1:GetParam(0)

    -- 获取坠落过程动作状态
    local f2_local1 = f2_arg1:GetParam(1)

    -- 获取停止坠落的边界距离（距离地面多远时认为已着陆）
    local f2_local2 = f2_arg1:GetParam(3)

    -- 实时计算与目标的垂直距离
    local f2_local3 = f2_arg0:GetDistYSigned(f2_local0)

    -- 判断是否已经接近地面（在边界距离内）
    if f2_local2 < f2_local3 then
        -- 已经接近地面，坠落结束，即将触发着陆动作
        return GOAL_RESULT_Success
    else
        -- 仍在坠落过程中，继续执行坠落动作
        f2_arg0:SetAttackRequest(f2_local1)
    end

    -- 继续坠落过程
    return GOAL_RESULT_Continue

end

--[[
坠落终止函数
功能：坠落结束时触发着陆动作，处理着陆后的状态转换
参数：f3_arg0 - AI实体对象, f3_arg1 - 目标参数对象
重要性：确保着陆动作的正确执行，完成坠落到着陆的过渡
--]]
function Fall_Terminate(f3_arg0, f3_arg1)
    -- 获取着陆动作状态ID
    local f3_local0 = f3_arg1:GetParam(2)

    -- 触发着陆动作，完成从坠落到着陆的过渡
    -- 这可能包括着陆的冲击效果、声音、尘土等
    f3_arg0:SetAttackRequest(f3_local0)

end

--[[
坠落中断检查函数
功能：检查是否允许中断当前的坠落过程
返回：false - 不允许中断
说明：坠落是物理过程，不应被人为中断，以避免不合理的悬浮状态
重要性：保证坠落物理效果的真实性和连续性
--]]
function Fall_Interupt(f4_arg0, f4_arg1)
    -- 坠落过程不允许被中断
    -- 这保证了物理过程的真实性和连续性
    -- 避免出现AI在空中突然停止或改变状态的不合理情况
    return false

end


