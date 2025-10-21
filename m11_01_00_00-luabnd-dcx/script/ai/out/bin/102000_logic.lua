-- ====================================================================================================
-- 102000_logic.lua - 武士大将 逻辑控制脚本
-- ====================================================================================================
-- 功能: 处理敌人的高级逻辑决策、事件处理和特殊状态管理
-- 主要内容:
--   - 主逻辑: 决策是否进入战斗或执行特殊事件
--   - 中断处理: 响应事件请求并重新规划
--   - 木偶操纵: 处理被控制状态下的特殊行为
-- ====================================================================================================

RegisterTableLogic(102000)

-- ====================================================================================================
-- 主逻辑函数
-- ====================================================================================================
-- 功能: 游戏主循环中的高级决策
-- 流程: 观察区域 -> 检查高优先级动作 -> 木偶状态检查 -> 定时器处理 -> 初始SP记录 -> 事件处理 -> 通用设置
-- ====================================================================================================
Logic.Main = function (f1_arg0, f1_arg1)
    -- 添加观察区域30：强制行走区域(m11_0地图)
    f1_arg1:AddObserveRegion(30, TARGET_SELF, COMMON_REGION_FORCE_WALK_M11_0)
    -- 检查高优先级设置(梯子/事件/特殊状态)
    if COMMON_HiPrioritySetup(f1_arg1) then
        return true
    end
    -- 检查木偶操纵状态(220020)
    if f1_arg1:HasSpecialEffectId(TARGET_SELF, 220020) then
        if f1_arg0.KugutsuAct(f1_arg1, goal) then
            return true
        end
    -- 检查转身反应定时器，若未完成则执行珠子反应
    elseif f1_arg1:IsFinishTimer(AI_TIMER_TEKIMAWASHI_REACTION) == false then
        JuzuReaction(f1_arg1, goal, 1, 20105)
        return true
    end
    -- 第一次读取最大SP值并设置标志
    if f1_arg1:GetStringIndexedNumber("firstSpRead") == 0 then
        f1_arg1:SetStringIndexedNumber("maxSp", f1_arg1:GetSp(TARGET_SELF))
        f1_arg1:SetStringIndexedNumber("firstSpRead", 1)
    end
    local f1_local0 = f1_arg1:GetRandam_Int(1, 100)
    local f1_local1 = f1_arg1:GetHpLastTarget()
    -- 获取事件请求ID
    local f1_local2 = f1_arg1:GetEventRequest()
    -- 事件处理：ID=10为特殊事件触发
    if f1_local2 == 10 then
        -- 检查是否已激活战斗特效(200004)
        if not f1_arg1:HasSpecialEffectId(TARGET_SELF, 200004) then
            -- 添加特殊攻击动作(1040)
            f1_arg1:AddTopGoal(GOAL_COMMON_AttackTunableSpin, 1, 1040, TARGET_ENE_0, 9999, 0, 0, 0, 0)
        end
        -- 设置事件移动目标点(9622492)
        f1_arg1:SetEventMoveTarget(9622492)
        -- 移动到事件点
        f1_arg1:AddTopGoal(GOAL_COMMON_ApproachTarget, 0.5, POINT_EVENT, 0, TARGET_SELF, true, -1)
        -- 标记已触发事件
        f1_arg1:SetStringIndexedNumber("findFlag", 1)
    else
        -- 标准战斗设置
        COMMON_EzSetup(f1_arg1)
    end

end

-- ====================================================================================================
-- 中断处理函数
-- ====================================================================================================
-- 功能: 处理逻辑层级的中断事件
-- 主要中断: 事件请求
-- ====================================================================================================
Logic.Interrupt = function (f2_arg0, f2_arg1, f2_arg2)
    local f2_local0 = f2_arg1:GetSpecialEffectActivateInterruptType(0)
    -- 检查事件请求中断
    if f2_arg1:IsInterupt(INTERUPT_EventRequest) then
        -- 获取事件请求ID
        local f2_local1 = f2_arg1:GetEventRequest()
        -- 若为ID=10则重新规划AI逻辑
        if f2_local1 == 10 then
            f2_arg1:Replanning()
        end
    end
    return false

end

-- ====================================================================================================
-- 木偶操纵动作函数
-- ====================================================================================================
-- 功能: 处理敌人被控制状态(220020)下的特殊动作
-- 用途: 当敌人被特定特效控制时使用的行为逻辑
-- ====================================================================================================
Logic.KugutsuAct = function (f3_arg0, f3_arg1)
    -- 检查是否不在战斗状态且不在发现状态
    if f3_arg0:IsBattleState() == false and f3_arg0:IsFindState() == false then
        -- 激活木偶操纵战斗AI(GOAL_KugutsuAct_20000_Battle)
        f3_arg0:AddTopGoal(GOAL_KugutsuAct_20000_Battle, -1)
        return true
    end
    return false

end


