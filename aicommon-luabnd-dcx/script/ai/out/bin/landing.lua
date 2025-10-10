--[[
起飞/升空AI脚本 - GOAL_COMMON_LiftOff
用途：控制AI的起飞和升空行为，与着陆相对应
适用场景：飞行敌人的起飞、跳跃攻击、空中机动等
特点：不可中断，确保起飞过程的完整性

系统说明：
- LiftOff：起飞/升空主控制
- Landing：着陆主控制
- Landing_Move：着陆前的移动调整
- Landing_Landing：实际着陆动作执行
--]]
REGISTER_GOAL_NO_INTERUPT(GOAL_COMMON_LiftOff, true)

--[[
起飞激活函数
功能：初始化起飞行为，开始执行起飞动作
参数：f1_arg0 - AI实体对象, f1_arg1 - 目标参数对象
说明：9520是起飞动作的状态ID，无需指定目标
--]]
function LiftOff_Activate(f1_arg0, f1_arg1)
    -- 添加起飞攻击动作子目标
    -- 参数：持续时间10秒，动作ID 9520，无目标，无距离限制
    f1_arg1:AddSubGoal(GOAL_COMMON_Attack, 10, 9520, TARGET_NONE, DIST_None)

end

--[[
起飞更新函数
功能：每帧检查起飞状态，监控高度并判断起飞是否成功
逻辑：当高度达到目标且不在地面时，起飞成功
--]]
function LiftOff_Update(f2_arg0, f2_arg1)
    -- 设置目标高度（5米）
    local f2_local0 = 5

    -- 获取与敌人的垂直距离
    local f2_local1 = f2_arg0:GetDistY(TARGET_ENE_0)

    -- 检查上一个子目标的结果
    local f2_local2 = f2_arg1:GetLastSubGoalResult()

    -- 如果上一个动作完成且（在地面或高度不足），继续起飞
    if (f2_local2 == GOAL_RESULT_Success or f2_local2 == GOAL_RESULT_Failed) and (f2_arg0:IsLanding() or f2_local1 < f2_local0) then
        -- 重新执行起飞动作，直到达到目标高度
        f2_arg1:AddSubGoal(GOAL_COMMON_Attack, 10, 9520, TARGET_NONE, DIST_None)
    end

    -- 检查是否在地面
    local f2_local3 = f2_arg0:IsLanding()

    -- 如果不在地面且高度达到或超过目标，起飞成功
    if not f2_local3 and f2_local0 <= f2_local1 then
        return GOAL_RESULT_Success
    end

    -- 继续起飞过程
    return GOAL_RESULT_Continue

end

--[[
起飞终止函数
功能：起飞结束时的清理工作
说明：起飞结束后通常不需要特殊处理，AI会自动转入空中状态
--]]
function LiftOff_Terminate(f3_arg0, f3_arg1)
    -- 起飞结束时无需特殊处理
    -- AI将自动转入空中状态或其他相应行为

end

--[[
起飞中断检查函数
功能：检查是否允许中断当前的起飞过程
返回：false - 不允许中断
说明：起飞过程不应被中断，以确保动作的完整性和真实性
--]]
function LiftOff_Interupt(f4_arg0, f4_arg1)
    -- 起飞过程不允许被中断
    -- 确保起飞动作的完整性和连续性
    return false

end

--[[
着陆主控制AI脚本 - GOAL_COMMON_Landing
用途：统一管理着陆过程，包括着陆前的移动和实际着陆动作
特点：不需要更新检查，不可中断，由子目标完成具体执行
系统设置：禁用更新和中断，保证着陆过程的稳定性
--]]
REGISTER_GOAL_NO_UPDATE(GOAL_COMMON_Landing, true)
REGISTER_GOAL_NO_INTERUPT(GOAL_COMMON_Landing, true)

--[[
着陆激活函数
功能：初始化着陆过程，设置目标并选择适当的着陆策略
参数：f5_arg0 - AI实体对象, f5_arg1 - 目标参数对象
逻辑：根据当前位置选择先移动还是直接着陆
--]]
function Landing_Activate(f5_arg0, f5_arg1)
    -- 获取着陆目标点
    local f5_local0 = f5_arg1:GetParam(0)

    -- 设置AI的固定移动目标为着陆点
    f5_arg0:SetAIFixedMoveTarget(f5_local0, TARGET_SELF, 0)

    -- 获取着陆前的移动距离参数
    local f5_local1 = f5_arg1:GetParam(1)

    -- 首先添加着陆移动子目标，调整位置
    f5_arg1:AddSubGoal(GOAL_COMMON_Landing_Move, 10, f5_local1)

    -- 根据与敌人的高度关系决定下一步动作
    if f5_arg0:GetDistYSigned(TARGET_ENE_0) > 0 then
        -- 如果高于敌人，需要先接近固定位置
        f5_arg1:AddSubGoal(GOAL_COMMON_ApproachTarget, 10, POINT_AI_FIXED_POS, 0.1, TARGET_SELF, false, -1)
    else
        -- 如果已经在适当高度，直接执行着陆动作
        f5_arg1:AddSubGoal(GOAL_COMMON_Landing_Landing, 10)
    end

end

--[[
着陆更新函数
功能：维持着陆过程的执行，由子目标完成具体操作
说明：着陆主控制不需要复杂更新，只需保持继续状态
--]]
function Landing_Update(f6_arg0, f6_arg1)
    -- 保持继续执行，由子目标处理具体的着陆逻辑
    return GOAL_RESULT_Continue

end

--[[
着陆终止函数
功能：着陆过程结束时的清理工作
说明：着陆结束后通常不需要特殊处理，AI会自动恢复正常状态
--]]
function Landing_Terminate(f7_arg0, f7_arg1)
    -- 着陆结束时无需特殊清理
    -- AI会自动转入地面行动模式

end

--[[
着陆中断检查函数
功能：检查是否允许中断当前的着陆过程
返回：false - 不允许中断
说明：着陆过程不应被中断，以确保安全着陆
--]]
function Landing_Interupt(f8_arg0, f8_arg1)
    -- 着陆过程不允许被中断
    -- 确保着陆的安全性和连续性
    return false

end

--[[
着陆移动AI脚本 - GOAL_COMMON_Landing_Move
用途：在实际着陆前调整位置，移动到最佳着陆点
更新频率：0.5秒间隔，适中的检查频率
特点：不可中断，确保移动过程的完整性
--]]
REGISTER_GOAL_UPDATE_TIME(GOAL_COMMON_Landing_Move, 0.5, 0.5)
REGISTER_GOAL_NO_INTERUPT(GOAL_COMMON_Landing_Move, true)

--[[
着陆移动激活函数
功能：开始向着陆点移动，调整位置以便着陆
参数：f9_arg0 - AI实体对象, f9_arg1 - 目标参数对象
策略：使用通用接近目标的方式移动到指定位置
--]]
function Landing_Move_Activate(f9_arg0, f9_arg1)
    -- 获取移动距离参数（精度要求）
    local f9_local0 = f9_arg1:GetParam(0)

    -- 添加接近目标子目标，移动到固定位置
    -- 参数：持续时间10秒，目标为固定位置，精度要求，目标自身，不使用路线
    f9_arg1:AddSubGoal(GOAL_COMMON_ApproachTarget, 10, POINT_AI_FIXED_POS, f9_local0, TARGET_SELF, false, -1)

end

--[[
着陆移动更新函数
功能：检查移动进度和着陆状态，判断是否需要继续移动
成功条件：距离目标少于1米
失败条件：移动过程中意外着陆
--]]
function Landing_Move_Update(f10_arg0, f10_arg1)
    -- 计算与目标位置的水平距离（忽略Y轴高度）
    local f10_local0 = f10_arg0:GetDistXZ(POINT_AI_FIXED_POS)

    -- 如果已经足够接近目标位置，移动成功
    if f10_local0 < 1 then
        return GOAL_RESULT_Success
    end

    -- 如果在移动过程中意外着陆，返回失败
    -- 这可能表示需要重新评估着陆策略
    if f10_arg0:IsLanding() then
        return GOAL_RESULT_Failed
    end

    -- 继续移动过程
    return GOAL_RESULT_Continue

end

--[[
着陆移动终止函数
功能：移动阶段结束时的清理工作
说明：移动结束后通常直接转入着陆阶段，无需特殊处理
--]]
function Landing_Move_Terminate(f11_arg0, f11_arg1)
    -- 移动阶段结束时无需特殊清理
    -- 将自动转入下一个着陆阶段

end

--[[
着陆移动中断检查函数
功能：检查是否允许中断当前的移动过程
返回：false - 不允许中断
说明：着陆前的位置调整不应被中断，以确保着陆的准确性
--]]
function Landing_Move_Interupt(f12_arg0, f12_arg1)
    -- 着陆移动过程不允许被中断
    -- 确保位置调整的准确性和完整性
    return false

end

--[[
着陆动作AI脚本 - GOAL_COMMON_Landing_Landing
用途：执行实际的着陆动作，处理着陆时的物理效果
更新频率：0.5秒间隔，频繁检查着陆状态
特点：不可中断，确保着陆动作的完整性
动作说明：9510是着陆冲击效果的动作状态ID
--]]
REGISTER_GOAL_UPDATE_TIME(GOAL_COMMON_Landing_Landing, 0.5, 0.5)
REGISTER_GOAL_NO_INTERUPT(GOAL_COMMON_Landing_Landing, true)

--[[
着陆动作激活函数
功能：初始化实际的着陆动作，开始执行着陆冲击效果
参数：f13_arg0 - AI实体对象, f13_arg1 - 目标参数对象
效果：可能包括着陆尘土、声音、捅损等物理效果
--]]
function Landing_Landing_Activate(f13_arg0, f13_arg1)
    -- 添加着陆冲击效果攻击动作
    -- 参数：持续时间为生命周期，动作ID 9510，无目标，无距离限制
    f13_arg1:AddSubGoal(GOAL_COMMON_Attack, f13_arg1:GetLife(), 9510, TARGET_NONE, DIST_None)

end

--[[
着陆动作更新函数
功能：监控着陆过程，检查着陆状态并处理各种情况
逻辑：通过计数器检查着陆时间，处理着陆失败情况
安全检查：确保不会超过目标位置太多
--]]
function Landing_Landing_Update(f14_arg0, f14_arg1)
    -- 检查是否已经着陆
    if f14_arg0:IsLanding() then
        -- 获取着陆计数器
        local f14_local0 = f14_arg1:GetNumber(0)

        -- 如果着陆时间超过10帧，认为着陆成功
        if f14_local0 > 10 then
            return GOAL_RESULT_Success
        else
            -- 增加着陆计数器
            f14_local0 = f14_local0 + 1
            f14_arg1:SetNumber(0, f14_local0)
        end
    end

    -- 检查上一个子目标的结果
    local f14_local0 = f14_arg1:GetLastSubGoalResult()

    -- 如果动作完成但还未着陆，继续执行着陆动作
    if (f14_local0 == GOAL_RESULT_Success or f14_local0 == GOAL_RESULT_Failed) and not f14_arg0:IsLanding() then
        f14_arg1:AddSubGoal(GOAL_COMMON_Attack, f14_arg1:GetLife(), 9510, TARGET_NONE, DIST_None)
    end

    -- 安全检查：如果超过目标位置1米以上，认为着陆失败
    if f14_arg0:GetDistYSigned(POINT_AI_FIXED_POS) > 1 then
        -- 输出调试信息
        f14_arg0:PrintText("[Landing_Landing_Update]目标位置高度异常，着陆失败")
        return GOAL_RESULT_Failed
    end

    -- 继续着陆过程
    return GOAL_RESULT_Continue

end

--[[
着陆动作终止函数
功能：着陆动作完成时的清理工作
说明：着陆完成后通常不需要特殊处理，AI会自动转入正常状态
--]]
function Landing_Landing_Terminate(f15_arg0, f15_arg1)
    -- 着陆动作结束时无需特殊清理
    -- AI将自动恢复到正常的地面行动模式

end

--[[
着陆动作中断检查函数
功能：检查是否允许中断当前的着陆动作
返回：false - 不允许中断
说明：着陆动作不应被中断，以确保着陆效果的完整性
重要性：防止着陆动作被中断导致效果不完整或状态异常
--]]
function Landing_Landing_Interupt(f16_arg0, f16_arg1)
    -- 着陆动作不允许被中断
    -- 确保着陆冲击效果和相关物理效果的完整执行
    return false

end


