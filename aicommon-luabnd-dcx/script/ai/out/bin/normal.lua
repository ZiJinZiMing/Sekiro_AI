-- ■ 标准AI行为模式激活函数
-- 描述：定义AI在正常状态下的基础行为逻辑，根据距离和随机值决定攻击或移动
-- 参数：f1_arg0 - AI实体对象, f1_arg1 - 目标对象
-- 功能：实现基于距离的分层决策系统，包含攻击和移动的平衡策略
function Normal_Activate(f1_arg0, f1_arg1)
    local f1_local0 = f1_arg0:GetDist(TARGET_ENE_0)    -- 获取与目标敌人的距离
    local f1_local1 = f1_arg0:GetRandam_Int(1, 100)    -- 生成第一个随机数(1-100)，用于行为选择
    local f1_local2 = f1_arg0:GetRandam_Int(1, 100)    -- 生成第二个随机数(1-100)，用于后续移动决策

    -- ■ 距离阈值定义
    local f1_local3 = 2     -- 极近距离阈值
    local f1_local4 = 4     -- 近距离阈值
    local f1_local5 = 0     -- 保留参数

    -- ■ 攻击ID定义
    local f1_local6 = 3000  -- 极近距离攻击ID
    local f1_local7 = 3000  -- 近距离攻击ID
    local f1_local8 = 3000  -- 中距离攻击ID

    -- ■ 移动距离参数
    local f1_local9 = 3     -- 极近距离后退距离
    local f1_local10 = 1    -- 近距离后退距离
    local f1_local11 = 3    -- 中距离移动距离

    -- ■ 行为概率阈值
    local f1_local12 = 20   -- 极近距离移动概率阈值
    local f1_local13 = 30   -- 近距离移动概率阈值
    local f1_local14 = 40   -- 中距离移动概率阈值

    -- ■ 攻击后移动距离
    local f1_local15 = 1.5  -- 极近距离攻击后移动距离
    local f1_local16 = 3.5  -- 近距离攻击后移动距离
    local f1_local17 = 5.5  -- 中距离攻击后移动距离

    -- ■ 攻击后移动概率
    local f1_local18 = 40   -- 极近距离攻击后移动概率
    local f1_local19 = 30   -- 近距离攻击后移动概率
    local f1_local20 = 20   -- 中距离攻击后移动概率

    -- ■ 远距离行为参数
    local f1_local21 = 6    -- 战斗距离上限
    local f1_local22 = 0    -- 远距离移动类型
    local f1_local23 = 9    -- 远距离阈值
    local f1_local24 = 7    -- 远距离接近模式
    local f1_local25 = 3    -- 标准接近距离
    -- ■ 主要决策逻辑：基于距离的分层行为选择
    if f1_local0 <= f1_local21 then    -- 在战斗距离范围内(≤6)
        if f1_local0 < f1_local3 then    -- 极近距离(<2)：优先后退，偶尔攻击
            if f1_local1 <= f1_local12 then    -- 20%概率后退保持距离
                f1_arg1:AddSubGoal(GOAL_COMMON_MoveToSomewhere, 5, TARGET_ENE_0, AI_DIR_TYPE_CENTER, f1_local9, TARGET_ENE_0, true)
            else    -- 80%概率执行近身攻击
                f1_arg1:AddSubGoal(GOAL_COMMON_Attack, 10, f1_local6, TARGET_ENE_0, DIST_Near, 0)
                if f1_local2 <= f1_local18 then    -- 40%概率攻击后后退
                    f1_arg1:AddSubGoal(GOAL_COMMON_MoveToSomewhere, 5, TARGET_ENE_0, AI_DIR_TYPE_CENTER, f1_local15, TARGET_ENE_0, true)
                end
            end
        elseif f1_local0 < f1_local4 then    -- 近距离(2-4)：攻击与后退的平衡
            if f1_local1 <= f1_local13 then    -- 30%概率后退
                f1_arg1:AddSubGoal(GOAL_COMMON_MoveToSomewhere, 5, TARGET_ENE_0, AI_DIR_TYPE_CENTER, f1_local10, TARGET_ENE_0, true)
            else    -- 70%概率攻击
                f1_arg1:AddSubGoal(GOAL_COMMON_Attack, 10, f1_local7, TARGET_ENE_0, DIST_Near, 0)
                if f1_local2 <= f1_local19 then    -- 30%概率攻击后移动
                    f1_arg1:AddSubGoal(GOAL_COMMON_MoveToSomewhere, 5, TARGET_ENE_0, AI_DIR_TYPE_CENTER, f1_local16, TARGET_ENE_0, true)
                end
            end
        elseif f1_local1 <= f1_local14 then    -- 中距离(4-6)：40%概率移动调整位置
            f1_arg1:AddSubGoal(GOAL_COMMON_MoveToSomewhere, 5, TARGET_ENE_0, AI_DIR_TYPE_CENTER, f1_local11, TARGET_ENE_0, true)
        else    -- 60%概率主动攻击
            f1_arg1:AddSubGoal(GOAL_COMMON_Attack, 10, f1_local8, TARGET_ENE_0, DIST_Near, 0)
            if f1_local2 <= f1_local20 then    -- 20%概率攻击后移动
                f1_arg1:AddSubGoal(GOAL_COMMON_MoveToSomewhere, 5, TARGET_ENE_0, AI_DIR_TYPE_CENTER, f1_local17, TARGET_ENE_0, true)
            end
        end
    elseif f1_local0 <= f1_local23 then    -- 远距离(6-9)：主动接近
        f1_arg1:AddSubGoal(GOAL_COMMON_MoveToSomewhere, 10, TARGET_ENE_0, AI_DIR_TYPE_CENTER, f1_local25, TARGET_ENE_0, true)
    else    -- 超远距离(>9)：两阶段接近策略
        -- 第一阶段：快速接近到中等距离
        f1_arg1:AddSubGoal(GOAL_COMMON_MoveToSomewhere, 10, TARGET_ENE_0, AI_DIR_TYPE_CENTER, f1_local24, TARGET_ENE_0, false)
        -- 第二阶段：谨慎接近到战斗距离
        f1_arg1:AddSubGoal(GOAL_COMMON_MoveToSomewhere, 10, TARGET_ENE_0, AI_DIR_TYPE_CENTER, f1_local25, TARGET_ENE_0, true)
    end
    
end

-- ■ 标准AI行为更新函数
-- 描述：每帧调用的更新函数，维持AI行为的持续性
-- 返回：GOAL_RESULT_Continue - 指示目标继续执行
function Normal_Update(f2_arg0, f2_arg1)
    return GOAL_RESULT_Continue

end

-- ■ 标准AI行为终止函数
-- 描述：当AI行为结束时调用的清理函数
-- 功能：执行必要的资源清理和状态重置
function Normal_Terminate(f3_arg0, f3_arg1)

end

-- ■ 标准AI行为中断处理函数
-- 描述：处理战斗过程中的各种中断事件，实现反应性行为
-- 参数：f4_arg0 - AI实体对象, f4_arg1 - 目标对象
-- 返回：true - 中断被处理, false - 无中断处理
function Normal_Interupt(f4_arg0, f4_arg1)
    local f4_local0 = f4_arg0:GetDist(TARGET_ENE_0)    -- 获取与目标的距离
    local f4_local1 = f4_arg0:GetRandam_Int(1, 100)    -- 第一个随机数
    local f4_local2 = f4_arg0:GetRandam_Int(1, 100)    -- 第二个随机数

    -- ■ 中断响应参数定义
    -- 发现攻击时的防御响应参数
    local f4_local3 = 3     -- 防御响应距离阈值
    local f4_local4 = 50    -- 防御响应概率阈值
    local f4_local5 = 9910  -- 防御EzState ID

    -- 攻击落空时的反击参数
    local f4_local6 = 3     -- 反击距离阈值
    local f4_local7 = 50    -- 反击概率阈值
    local f4_local8 = 3300  -- 反击攻击ID

    -- 防御破绽时的攻击参数
    local f4_local9 = 3     -- 破绽攻击距离阈值
    local f4_local10 = 75   -- 破绽攻击概率阈值
    local f4_local11 = 3300 -- 破绽攻击ID

    -- 防御结束时的追击参数
    local f4_local12 = 3    -- 追击距离阈值
    local f4_local13 = 40   -- 追击概率阈值
    local f4_local14 = 3000 -- 追击攻击ID
    -- ■ 中断事件处理逻辑

    -- 1. 发现敌人攻击时的防御响应
    if f4_arg0:IsInterupt(INTERUPT_FindAttack) and f4_local0 <= f4_local3 and f4_local1 <= f4_local4 then
        f4_arg1:ClearSubGoal()    -- 清除当前目标
        f4_arg1:AddSubGoal(GOAL_COMMON_Guard, 5, f4_local5, TARGET_ENE_0, 0, 0)    -- 启动防御行为
        return true    -- 中断处理成功
    end

    -- 2. 敌人攻击落空时的反击机会
    if f4_arg0:IsInterupt(INTERUPT_MissSwing) and f4_local0 < f4_local6 and f4_local1 <= f4_local7 then
        f4_arg1:ClearSubGoal()    -- 清除当前目标
        f4_arg1:AddSubGoal(GOAL_COMMON_Attack, 5, f4_local8, TARGET_ENE_0, DIST_Near, 0)    -- 执行反击
        return true    -- 中断处理成功
    end

    -- 3. 敌人防御被破坏时的追击
    if f4_arg0:IsInterupt(INTERUPT_GuardBreak) and f4_local0 < f4_local9 and f4_local1 <= f4_local10 then
        f4_arg1:ClearSubGoal()    -- 清除当前目标
        f4_arg1:AddSubGoal(GOAL_COMMON_Attack, 5, f4_local11, TARGET_ENE_0, DIST_Near, 0)    -- 执行破绽攻击
        return true    -- 中断处理成功
    end

    -- 4. 敌人防御结束时的攻击机会
    if f4_arg0:IsInterupt(INTERUPT_GuardFinish) and f4_local0 < f4_local12 and f4_local1 <= f4_local13 then
        f4_arg1:ClearSubGoal()    -- 清除当前目标
        f4_arg1:AddSubGoal(GOAL_COMMON_Attack, 5, f4_local14, TARGET_ENE_0, DIST_Near, 0)    -- 执行追击
        return true    -- 中断处理成功
    end

    return false    -- 无中断事件需要处理
    
end


