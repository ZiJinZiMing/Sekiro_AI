--[[
敌人派生攻击系统
功能：实现根据战斗情况动态派生出不同攻击的智能攻击系统
使用场景：高级BOSS或精英敌人的复杂攻击模式
战术意图：通过智能攻击选择提高战斗的不可预测性和挑战性
系统特点：
- 支持攻击记忆，避免重复相同攻击
- 动态派生攻击，根据当前情况选择最佳攻击
- 支持多层级的攻击组合和连续派生
--]]

-- 注册主派生攻击目标，作为整个派生攻击系统的入口
RegisterTableGoal(GOAL_EnemyDeriveAttack, "GOAL_EnemyDeriveAttack")

-- 启用连击攻击取消机制，允许在派生过程中灵活控制
ENABLE_COMBO_ATK_CANCEL(GOAL_EnemyDeriveAttack)

-- 允许子目标，支持复杂的派生攻击结构
REGISTER_GOAL_NO_SUB_GOAL(GOAL_EnemyDeriveAttack, true)

-- 使用标准的无子目标完成检查更新函数
Goal.Update = Update_FinishOnNoSubGoal

--[[
敌人派生攻击激活函数（入口）
功能：初始化派生攻击系统，清空攻击记忆并启动主派生攻击
逻辑：
1. 获取攻击记忆参数设置
2. 清空16个攻击记忆槽位（设为9999999表示未使用）
3. 启动主派生攻击目标，开始派生攻击序列
--]]
Goal.Activate = function (f1_arg0, f1_arg1, f1_arg2)
    -- 获取攻击记忆相关参数
    local f1_local0 = f1_arg2:GetParam(4)

    -- 初始化攻击记忆数组，清空所有16个记忆槽位
    -- 9999999表示该槽位为空，未记录任何攻击
    for f1_local1 = 0, 15, 1 do
        f1_arg1:SetStringIndexedArray("DeriveAttackMemory", f1_local1, 9999999)
    end

    -- 启动主派生攻击子目标，开始派生攻击流程
    -- 参数：生命周期、目标、攻击ID、派生概率、最大段数、当前段数1、记忆参数
    f1_arg2:AddSubGoal(GOAL_EnemyDeriveAttackMain, f1_arg2:GetLife(), f1_arg2:GetParam(0), f1_arg2:GetParam(1), f1_arg2:GetParam(2), f1_arg2:GetParam(3), 1, f1_local0)

end

--[[
敌人主派生攻击目标
功能：执行具体的派生攻击逻辑，管理攻击选择和连击控制
作用：作为派生攻击系统的核心执行单元
特点：支持距离检查、攻击记忆、动态派生选择
--]]

-- 注册主派生攻击目标
RegisterTableGoal(GOAL_EnemyDeriveAttackMain, "GOAL_EnemyDeriveAttackMain")

-- 启用连击攻击取消机制
ENABLE_COMBO_ATK_CANCEL(GOAL_EnemyDeriveAttackMain)

-- 允许子目标，支持复杂攻击行为
REGISTER_GOAL_NO_SUB_GOAL(GOAL_EnemyDeriveAttackMain, true)

-- 调试参数注册
REGISTER_DBG_GOAL_PARAM(GOAL_EnemyDeriveAttackMain, 0, "対象", 0)                    -- 攻击目标类型
REGISTER_DBG_GOAL_PARAM(GOAL_EnemyDeriveAttackMain, 1, "攻撃", 0)                    -- 当前攻击ID
REGISTER_DBG_GOAL_PARAM(GOAL_EnemyDeriveAttackMain, 2, "派生確率", 0)                -- 派生概率（%）
REGISTER_DBG_GOAL_PARAM(GOAL_EnemyDeriveAttackMain, 3, "最大段数", 0)                -- 最大派生段数
REGISTER_DBG_GOAL_PARAM(GOAL_EnemyDeriveAttackMain, 4, "現在段数", 0)                -- 当前执行段数
REGISTER_DBG_GOAL_PARAM(GOAL_EnemyDeriveAttackMain, 5, "同じ攻撃を出さないか", 0)      -- 是否避免重复攻击

Goal.Activate = function (f2_arg0, f2_arg1, f2_arg2)
    local f2_local0 = f2_arg2:GetParam(0)
    local f2_local1 = f2_arg2:GetParam(1)
    local f2_local2 = f2_arg2:GetParam(2)
    local f2_local3 = f2_arg2:GetParam(3)
    local f2_local4 = f2_arg2:GetParam(4)
    if f2_local3 <= 0 or f2_local4 > 16 then
        return
    end
    local f2_local5 = f2_arg2:GetParam(5)
    if f2_local5 == false then
        f2_arg1:SetStringIndexedArray("DeriveAttackMemory", 0 + f2_local4 - 1, f2_local1)
    end
    local f2_local6 = f2_arg1:GetDist(f2_local0)
    if f2_local1 <= 0 then
        return
    end
    if f2_local6 < f2_arg1:GetAIAttackParam(f2_local1, AI_ATTACK_PARAM_TYPE__MIN_OPTIMAL_DISTANCE) or f2_arg1:GetAIAttackParam(f2_local1, AI_ATTACK_PARAM_TYPE__MAX_OPTIMAL_DISTANCE) < f2_local6 then
        return
    end
    local f2_local7 = 0
    f2_arg2:SetNumber(2, 0)
    if f2_arg1:GetRandam_Float(0, 100) < f2_local2 then
        f2_local7 = 1
        f2_arg2:SetNumber(2, 1)
    end
    if f2_local1 == 7008 then
        f2_arg2:AddSubGoal(GOAL_EnemyStepFront, f2_arg2:GetLife(), f2_local0, 6.5)
    elseif f2_arg1:GetAIAttackParam(f2_local1, AI_ATTACK_PARAM_TYPE__IS_FIRST_ATTACK) == 1 then
        if f2_local7 == 1 then
            f2_arg2:AddSubGoal(GOAL_EnemyTunableComboAttack, f2_arg2:GetLife(), f2_local0, f2_local1)
        else
            f2_arg2:AddSubGoal(GOAL_EnemyTunableAttack, f2_arg2:GetLife(), f2_local0, f2_local1)
        end
    elseif f2_local7 == 1 then
        f2_arg2:AddSubGoal(GOAL_EnemyComboRepeat, f2_arg2:GetLife(), f2_local0, f2_local1)
    else
        f2_arg2:AddSubGoal(GOAL_EnemyComboFinal, f2_arg2:GetLife(), f2_local0, f2_local1)
    end
    f2_arg2:SetNumber(0, 0)
    
end

Goal.Update = function (f3_arg0, f3_arg1, f3_arg2)
    local f3_local0 = nil
    if f3_arg2:GetNumber(2) == 1 then
        if f3_arg2:GetNumber(0) == 0 and f3_arg1:IsEnableComboAttack() then
            f3_arg2:SetNumber(0, 1)
            f3_arg2:SetNumber(1, 1)
            f3_local0 = SelectDeriveAttack(f3_arg0, f3_arg1, f3_arg2, f3_arg2:GetParam(1), f3_arg2:GetParam(0), 0)
            if f3_local0 ~= 9999999 and f3_arg1:GetAIAttackParam(f3_local0, AI_ATTACK_PARAM_TYPE__IS_FIRST_ATTACK) == 0 then
                f3_arg2:AddSubGoal(GOAL_EnemyDeriveAttackMain, f3_arg2:GetLife(), f3_arg2:GetParam(0), f3_local0, f3_arg2:GetParam(2), f3_arg2:GetParam(3) - 1, f3_arg2:GetParam(4) + 1)
            else
                f3_arg2:AddSubGoal(GOAL_EnemyDeriveAttackSub, f3_arg2:GetLife(), f3_arg2:GetParam(0), f3_arg2:GetParam(1), f3_arg2:GetParam(2), f3_arg2:GetParam(3) - 1, f3_arg2:GetParam(4) + 1)
            end
        end
        if f3_arg2:GetNumber(1) == 0 and f3_arg1:IsEnableCancelAttack() then
            f3_arg2:SetNumber(1, 1)
            f3_arg2:SetNumber(0, 1)
            f3_arg2:AddSubGoal(GOAL_EnemyDeriveAttackSub, f3_arg2:GetLife(), f3_arg2:GetParam(0), f3_arg2:GetParam(1), f3_arg2:GetParam(2), f3_arg2:GetParam(3) - 1, f3_arg2:GetParam(4) + 1)
        end
    end
    if f3_arg2:GetSubGoalNum() <= 0 then
        return GOAL_RESULT_Success
    end
    return GOAL_RESULT_Continue
    
end

RegisterTableGoal(GOAL_EnemyDeriveAttackSub, "GOAL_EnemyDeriveAttackSub")
REGISTER_GOAL_NO_SUB_GOAL(GOAL_EnemyDeriveAttackSub, true)
REGISTER_DBG_GOAL_PARAM(GOAL_EnemyDeriveAttackSub, 0, "対象", 0)
REGISTER_DBG_GOAL_PARAM(GOAL_EnemyDeriveAttackSub, 1, "攻撃", 0)
REGISTER_DBG_GOAL_PARAM(GOAL_EnemyDeriveAttackSub, 2, "派生確率", 0)
REGISTER_DBG_GOAL_PARAM(GOAL_EnemyDeriveAttackSub, 3, "最大段数", 0)

Goal.Activate = function (f4_arg0, f4_arg1, f4_arg2)
    local f4_local0 = SelectDeriveAttack(f4_arg0, f4_arg1, f4_arg2, f4_arg2:GetParam(1), f4_arg2:GetParam(0), 1)
    if f4_local0 ~= 9999999 then
        f4_arg2:AddSubGoal(GOAL_EnemyDeriveAttackMain, f4_arg2:GetLife(), f4_arg2:GetParam(0), f4_local0, f4_arg2:GetParam(2), f4_arg2:GetParam(3), f4_arg2:GetParam(4))
    end
    
end

Goal.Update = function (f5_arg0, f5_arg1, f5_arg2)
    if f5_arg2:GetSubGoalNum() <= 0 then
        f5_arg1:TurnTo(TARGET_SELF)
        return GOAL_RESULT_Success
    end
    return GOAL_RESULT_Continue
    
end

RegisterTableGoal(GOAL_EnemyDeriveAttackDummy, "GOAL_EnemyDeriveAttackDummy")
Goal.Update = GOAL_EnemyDeriveAttackDummy

Goal.Activate = function (f6_arg0, f6_arg1, f6_arg2)
    
end


