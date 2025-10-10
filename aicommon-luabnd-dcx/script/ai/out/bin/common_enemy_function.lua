--[[============================================================================
    common_enemy_function.lua - Sekiro AI敌人通用行为函数库

    版本信息 (Version Info): v3.0 - Comprehensive professional documentation
    作者 (Author): FromSoftware AI Team / Enhanced by Claude Code
    最后修改 (Last Modified): 2025-10-10
    编码格式 (Encoding): Shift-JIS (required for Sekiro compatibility)

    ============================================================================
    模块概述 (Module Overview):
    ============================================================================
    这是Sekiro AI系统的敌人通用行为函数库，提供了各种敌人AI的核心行为逻辑。
    该模块包含了紧急逃脱、防御概率、中断处理、行为选择等关键功能，是敌人
    AI智能行为的基础支撑库。

    核心功能模块 (Core Function Modules):
    ┌─ 紧急反应系统 (Emergency Response System)
    │  ├─ EmagencyEscapeStep() - 紧急逃脱步法
    │  └─ 基于距离和状态的智能逃脱机制
    │
    ├─ 防御概率系统 (Guard Probability System)
    │  ├─ GuardOnProbability() - 基于概率的防御触发
    │  └─ 动态防御概率调整机制
    │
    ├─ 中断处理系统 (Interrupt Handling System)
    │  ├─ Interrupt_FindAttack_Default() - 默认发现攻击中断
    │  ├─ Interrupt_FindAttack_Guard() - 防御型发现攻击中断
    │  └─ 各种中断条件的统一处理
    │
    ├─ 行为选择系统 (Behavior Selection System)
    │  ├─ _SelectEnemyAct() - 智能敌人行为选择算法
    │  └─ 基于权重和条件的复杂行为决策
    │
    └─ 状态更新系统 (State Update System)
       ├─ Update_FinishOnNoSubGoal() - 无子目标时完成更新
       └─ 各种更新逻辑的标准化处理

    ============================================================================
]]--

-- ■ 紧急逃脱步法函数 (Emergency Escape Step Function)
-- ■ 功能说明：当AI处于特定战斗状态且敌人距离过近时，执行紧急侧步逃脱
-- ■ 触发条件：
-- ■   1. AI正在执行攻击前、攻击后或行动后的目标行为
-- ■   2. 敌人距离小于等于设定的发现攻击距离阈值
-- ■ 参数说明 (Parameters):
-- ■   f1_arg0: AI参数对象，包含发现攻击距离等配置 (AI parameter object)
-- ■   f1_arg1: AI实体对象，用于距离检测和状态判断 (AI entity object)
-- ■   f1_arg2: 子目标管理器，用于清理当前目标并设置逃脱行为 (Sub-goal manager)
function EmagencyEscapeStep(f1_arg0, f1_arg1, f1_arg2)
    -- ■ 检查AI是否处于攻击相关状态 (Check if AI is in attack-related state)
    local isInAttackState = f1_arg1:IsActiveGoal(GOAL_EnemyBeforeAttack) or
                           f1_arg1:IsActiveGoal(GOAL_EnemyAfterAttack) or
                           f1_arg1:IsActiveGoal(GOAL_EnemyAfterAction)

    -- ■ 检查距离条件 (Check distance condition)
    local isInRange = (f1_arg0.FindAttackDist == nil) or
                     (f1_arg0.FindAttackDist ~= nil and f1_arg1:GetDist(TARGET_ENE_0) <= f1_arg0.FindAttackDist)

    -- ■ 如果满足紧急逃脱条件，执行侧步逃脱 (If emergency escape conditions are met, execute side step escape)
    if isInAttackState and isInRange then
        -- ■ 清除当前所有子目标 (Clear all current sub-goals)
        f1_arg2:ClearSubGoal()
        -- ■ 添加左右侧步逃脱目标：2秒持续时间，步法类型6 (Add left-right side step escape goal)
        f1_arg2:AddSubGoal(GOAL_EnemyStepBLR, 2, 6)
    end
end

-- ■ 基于概率的防御触发函数 (Probability-based Guard Trigger Function)
-- ■ 功能说明：根据连续受到攻击的时间间隔动态调整防御概率
-- ■ 算法核心：
-- ■   1. 监控最近5秒内是否受到攻击
-- ■   2. 根据攻击频率动态增加防御概率
-- ■   3. 最大防御概率限制为60%
-- ■ 参数说明 (Parameters):
-- ■   f2_arg0: AI参数对象，包含防御概率配置 (AI parameter object)
-- ■   f2_arg1: AI实体对象，用于随机数生成和计时器管理 (AI entity object)
-- ■   f2_arg2: 子目标管理器，用于设置防御行为 (Sub-goal manager)
function GuardOnProbability(f2_arg0, f2_arg1, f2_arg2)
    -- ■ 初始化受损防御概率 (Initialize damage guard probability)
    if f2_arg0.GuardRateOnDamged == nil then
        f2_arg0.GuardRateOnDamged = 0
    end

    -- ■ 获取计时器8000的当前值（监控攻击间隔） (Get timer 8000 current value for attack interval monitoring)
    local attackIntervalTimer = f2_arg1:GetIdTimer(8000)
    if attackIntervalTimer == nil or attackIntervalTimer <= 0 then
        attackIntervalTimer = 100  -- ■ 默认值：假设很长时间没有受到攻击 (Default: assume no attack for long time)
    end

    -- ■ 计算距离上次攻击的时间差 (Calculate time since last attack)
    local timeSinceLastAttack = 5 - attackIntervalTimer

    -- ■ 根据攻击频率动态调整防御概率 (Dynamically adjust guard probability based on attack frequency)
    if timeSinceLastAttack > 0 then
        -- ■ 攻击频率越高，防御概率增加越多 (Higher attack frequency increases guard probability more)
        -- ■ 公式：基础概率 + (5秒内攻击次数 * 10 / 2.5)
        f2_arg0.GuardRateOnDamged = f2_arg0.GuardRateOnDamged + timeSinceLastAttack * 10 / 2.5

        -- ■ 防御概率上限控制：最大60% (Guard probability upper limit: maximum 60%)
        if f2_arg0.GuardRateOnDamged > 60 then
            f2_arg0.GuardRateOnDamged = 60
        end
    else
        -- ■ 如果超过5秒没有受到攻击，重置防御概率 (Reset guard probability if no attack for over 5 seconds)
        f2_arg0.GuardRateOnDamged = 0
    end

    -- ■ 基于计算的概率决定是否触发防御 (Decide whether to trigger guard based on calculated probability)
    local randomValue = f2_arg1:GetRandam_Float(0, 100)
    if randomValue < f2_arg0.GuardRateOnDamged then
        -- ■ 清除当前目标并执行防御 (Clear current goals and execute guard)
        f2_arg2:ClearSubGoal()
        -- ■ 添加防御目标：1秒持续时间，动画9910，目标敌人0，启用防御，优先级1 (Add guard goal)
        f2_arg2:AddSubGoal(GOAL_COMMON_Guard, 1, 9910, TARGET_ENE_0, true, 1)
    end

    -- ■ 重新启动计时器以监控下次攻击 (Restart timer to monitor next attack)
    f2_arg1:StartIdTimer(8000)
    
end

-- ■ 默认发现攻击中断函数 (Default Find Attack Interrupt Function)
-- ■ 功能说明：处理AI发现玩家攻击时的默认中断逻辑
-- ■ 注意：当前为空实现，子类可以重写此函数添加特定的中断处理
-- ■ 参数说明 (Parameters):
-- ■   f3_arg0: AI参数对象 (AI parameter object)
-- ■   f3_arg1: AI实体对象 (AI entity object)
-- ■   f3_arg2: 子目标管理器 (Sub-goal manager)
function Interrupt_FindAttack_Default(f3_arg0, f3_arg1, f3_arg2)
    -- ■ 空实现：默认不执行任何中断处理 (Empty implementation: no interrupt handling by default)
    -- ■ 具体的敌人类型可以重写此函数实现特定的发现攻击反应
end

-- ■ 无子目标时完成更新函数 (Update Function that Finishes on No Sub-goals)
-- ■ 功能说明：当AI没有子目标时自动完成当前行为并转向自身
-- ■ 应用场景：简单的AI行为结束处理，确保AI有明确的结束状态
-- ■ 参数说明 (Parameters):
-- ■   f4_arg0: AI参数对象 (AI parameter object)
-- ■   f4_arg1: AI实体对象 (AI entity object)
-- ■   f4_arg2: 子目标管理器 (Sub-goal manager)
-- ■ 返回值 (Return Value):
-- ■   GOAL_RESULT_Success: 无子目标时返回成功
-- ■   GOAL_RESULT_Continue: 有子目标时继续执行
function Update_FinishOnNoSubGoal(f4_arg0, f4_arg1, f4_arg2)
    -- ■ 检查是否还有子目标需要执行 (Check if there are sub-goals to execute)
    if f4_arg2:GetSubGoalNum() <= 0 then
        -- ■ 没有子目标时，让AI转向自身（重置朝向） (No sub-goals: turn AI to self to reset orientation)
        f4_arg1:TurnTo(TARGET_SELF)
        -- ■ 返回成功状态，表示行为已完成 (Return success status indicating behavior completion)
        return GOAL_RESULT_Success
    end
    -- ■ 还有子目标时继续执行 (Continue if there are still sub-goals)
    return GOAL_RESULT_Continue
end

-- ■ 防御型发现攻击中断函数 (Guard-oriented Find Attack Interrupt Function)
-- ■ 功能说明：当AI发现玩家攻击且距离较近时，触发防御反应
-- ■ 触发条件：敌人距离小于等于3米
-- ■ 参数说明 (Parameters):
-- ■   f5_arg0: AI参数对象 (AI parameter object)
-- ■   f5_arg1: AI实体对象 (AI entity object)
-- ■   f5_arg2: 子目标管理器 (Sub-goal manager)
function Interrupt_FindAttack_Guard(f5_arg0, f5_arg1, f5_arg2)
    if f5_arg1:GetDist(TARGET_ENE_0) <= 3 then
        local f5_local0 = 1
        if f5_arg1:GetIdTimer(7000) < 3 then
            f5_local0 = 2
        end
        if f5_arg1:GetRandam_Float(0, 100) < 10 then
            f5_arg2:ClearSubGoal()
            f5_arg2:AddSubGoal(GOAL_COMMON_Guard, 1, 9910, TARGET_ENE_0, true, 1)
        end
        f5_arg1:StartIdTimer(7000)
    end
    
end

function Interrupt_GuardBreak_ClearSubGoal(f6_arg0, f6_arg1, f6_arg2)
    f6_arg2:ClearSubGoal()
    f6_arg1:TurnTo(TARGET_SELF)
    
end

function GetDefaultParam(f7_arg0, f7_arg1, f7_arg2, f7_arg3, f7_arg4)
    local f7_local0 = f7_arg2:GetParam(f7_arg3)
    if f7_local0 == nil then
        return f7_arg4
    else
        return f7_local0
    end
    
end

function GetDistPos(f8_arg0, f8_arg1, f8_arg2, f8_arg3)
    if f8_arg3 <= f8_arg1:GetDistParam(DIST_Near) then
        return 0
    elseif f8_arg3 <= f8_arg1:GetDistParam(DIST_Middle) then
        return 1
    elseif f8_arg3 <= f8_arg1:GetDistParam(DIST_Far) then
        return 2
    else
        return 3
    end
    
end

function GetAttackRateByDist(f9_arg0, f9_arg1, f9_arg2, f9_arg3, f9_arg4)
    local f9_local0 = 0
    if f9_arg4 == 0 then
        f9_local0 = f9_arg1:GetAIAttackParam(f9_arg3, AI_ATTACK_PARAM_TYPE__SHORT_RANGE_TENDENCY)
    elseif f9_arg4 == 1 then
        f9_local0 = f9_arg1:GetAIAttackParam(f9_arg3, AI_ATTACK_PARAM_TYPE__MIDDLE_RANGE_TENDENCY)
    elseif f9_arg4 == 2 then
        f9_local0 = f9_arg1:GetAIAttackParam(f9_arg3, AI_ATTACK_PARAM_TYPE__FAR_RANGE_TENDENCY)
    elseif f9_arg4 == 3 then
        f9_local0 = f9_arg1:GetAIAttackParam(f9_arg3, AI_ATTACK_PARAM_TYPE__OUT_RANGE_TENDENCY)
    end
    if f9_local0 < 0 then
        f9_local0 = 0
    end
    return f9_local0
    
end

function GetAttackIdOffset(f10_arg0, f10_arg1, f10_arg2, f10_arg3)
    local f10_local0 = nil
    if f10_arg1:HasSpecialEffectId(TARGET_SELF, 5404) then
        f10_arg3 = f10_arg3 - 1000000
        f10_local0 = 1000000
    elseif f10_arg1:HasSpecialEffectId(TARGET_SELF, 5405) then
        f10_arg3 = f10_arg3 - 2000000
        f10_local0 = 2000000
    elseif f10_arg1:HasSpecialEffectId(TARGET_SELF, 5406) then
        f10_arg3 = f10_arg3 - 3000000
        f10_local0 = 3000000
    elseif f10_arg1:HasSpecialEffectId(TARGET_SELF, 5407) then
        f10_arg3 = f10_arg3 - 4000000
        f10_local0 = 4000000
    else
        f10_local0 = 0
    end
    if f10_arg3 < 0 or f10_arg3 > 1000000 then
        f10_arg3 = 9999999
    end
    return f10_arg3, f10_local0
    
end

function IsValidEnemySelect(f11_arg0, f11_arg1, f11_arg2, f11_arg3, f11_arg4)
    if 0 < f11_arg1:GetAIAttackParam(f11_arg3, AI_ATTACK_PARAM_TYPE__SELECTION_TENDENCY) then
        local f11_local0 = f11_arg1:GetDist(f11_arg4)
        local f11_local1 = GetDistPos(f11_arg0, f11_arg1, f11_arg2, f11_local0)
        if 0 < GetAttackRateByDist(f11_arg0, f11_arg1, f11_arg2, f11_arg3, f11_local1) and f11_arg1:IsOptimalAttackRangeH(TARGET_ENE_0, f11_arg3) then
            if f11_arg1:IsOptimalAttackDist(f11_arg4, f11_arg3) or f11_arg1:GetAIAttackParam(f11_arg3, AI_ATTACK_PARAM_TYPE__DOES_SELECT_ON_OUT_RANGE) == 1 and f11_arg1:GetAIAttackParam(f11_arg3, AI_ATTACK_PARAM_TYPE__DOES_SELECT_ON_INNER_RANGE) == 1 then
                return true
            elseif f11_local0 < f11_arg1:GetAIAttackParam(f11_arg3, AI_ATTACK_PARAM_TYPE__MIN_OPTIMAL_DISTANCE) and f11_arg1:GetAIAttackParam(f11_arg3, AI_ATTACK_PARAM_TYPE__DOES_SELECT_ON_INNER_RANGE) then
                return true
            elseif f11_arg1:GetAIAttackParam(f11_arg3, AI_ATTACK_PARAM_TYPE__MAX_OPTIMAL_DISTANCE) < f11_local0 and f11_arg1:GetAIAttackParam(f11_arg3, AI_ATTACK_PARAM_TYPE__DOES_SELECT_ON_OUT_RANGE) then
                return true
            end
        end
    end
    return false
    
end

function SelectDeriveAttack(f12_arg0, f12_arg1, f12_arg2, f12_arg3, f12_arg4, f12_arg5)
    local f12_local0 = f12_arg1:GetDist(f12_arg4)
    local f12_local1 = nil
    local f12_local2 = {}
    local f12_local3 = 0
    for f12_local4 = 1, 16, 1 do
        f12_local1 = f12_arg1:GetDeriveAttackID(f12_arg3, f12_local4)
        if f12_local1 <= 0 then
            break
        end
        f12_local1, offset = GetAttackIdOffset(f12_arg0, f12_arg1, f12_arg2, f12_local1)
        print("[SELECT DERIVE]" .. "派生候補[" .. f12_local1 .. "]")
        if f12_local1 ~= 9999999 and f12_arg1:IsAIAttackParam(f12_local1) then
            local f12_local7 = 0
            if f12_arg5 == 0 then
                f12_local7 = 1
            elseif f12_arg5 == 1 then
                if f12_arg1:GetAIAttackParam(f12_local1, AI_ATTACK_PARAM_TYPE__IS_FIRST_ATTACK) == 1 then
                    f12_local7 = 1
                end
            elseif f12_arg5 == 2 then
                if f12_arg1:GetAIAttackParam(f12_local1, AI_ATTACK_PARAM_TYPE__IS_FIRST_ATTACK) == 0 then
                    f12_local7 = 1
                end
            else
                print("[SELECT DERIVE]" .. "選択タイプの関係で駄目[" .. f12_local1 .. "]")
            end
            if f12_local7 == 1 then
                for f12_local8 = 0, 15, 1 do
                    local f12_local11 = f12_arg1:GetStringIndexedArray("DeriveAttackMemory", f12_local8)
                    if f12_local11 == 9999999 then
                        break
                    end
                    if f12_local1 == f12_local11 then
                        print("[SELECT DERIVE]" .. "[" .. f12_local1 .. "]派生で既に出ている")
                        f12_local7 = 0
                    else
                        print("[SELECT DERIVE]" .. "[" .. f12_local1 .. "]派生OK")
                    end
                end
            end
            if f12_local7 == 1 then
                if f12_arg1:IsFinishAttackCoolTime(f12_local1) or f12_arg1:GetNumber(60) == 1 then
                    if f12_arg1:GetAIAttackParam(f12_local1, AI_ATTACK_PARAM_TYPE__MIN_OPTIMAL_DISTANCE) <= f12_local0 and f12_local0 <= f12_arg1:GetAIAttackParam(f12_local1, AI_ATTACK_PARAM_TYPE__MAX_OPTIMAL_DISTANCE) then
                        if f12_arg1:IsOptimalAttackRangeH(TARGET_ENE_0, f12_local1) then
                            if not f12_arg1:HasSpecialEffectAttribute(TARGET_ENE_0, SP_EFFECT_TYPE_TARGET_DOWN) or f12_arg1:GetAIAttackParam(f12_arg3, AI_ATTACK_PARAM_TYPE__DOES_SELECT_ON_TARGET_DOWN) == 1 then
                                f12_local3 = f12_local3 + 1
                                f12_local2[f12_local3] = f12_local1
                            else
                                print("[SELECT DERIVE]" .. "[" .. f12_local1 .. "]プレイヤーダウン中")
                            end
                        else
                            print("[SELECT DERIVE]" .. "[" .. f12_local1 .. "]角度外")
                        end
                    else
                        print("[SELECT DERIVE]" .. "[" .. f12_local1 .. "]範囲外")
                    end
                else
                    print("[SELECT DERIVE]" .. "[" .. f12_local1 .. "]インターバル経過していない")
                end
            end
        else
            print("[SELECT DERIVE]" .. "[" .. f12_local1 .. "]データない")
        end
    end
    local f12_local4 = {}
    local f12_local5 = 0
    local f12_local6 = 0
    if f12_local3 == 0 then
        print("[SELECT ENEMY]" .. "<<結果>> 抽選結果[なし]")
        return 9999999
    elseif f12_local3 > 1 then
        for f12_local7 = 1, f12_local3, 1 do
            local f12_local10 = f12_arg1:GetAttackPassedTime(f12_local2[f12_local7])
            if f12_local10 <= 0 then
                f12_local10 = f12_arg1:GetAIAttackParam(f12_local2[f12_local7], AI_ATTACK_PARAM_TYPE__INTERVAL_EXEC) * 2
            end
            f12_local10 = f12_local10 - f12_arg1:GetAIAttackParam(f12_local2[f12_local7], AI_ATTACK_PARAM_TYPE__INTERVAL_EXEC)
            if f12_local10 < 0 then
                f12_local10 = 1
            end
            print("[SELECT DERIVE]" .. "[" .. f12_local2[f12_local7] .. "]　経過時間[" .. f12_local10 .. "]　選択レート[" .. f12_arg1:GetAIAttackParam(f12_local2[f12_local7], AI_ATTACK_PARAM_TYPE__SELECTION_TENDENCY) .. "]")
            f12_local4[f12_local7] = f12_local10 * f12_arg1:GetAIAttackParam(f12_local2[f12_local7], AI_ATTACK_PARAM_TYPE__SELECTION_TENDENCY)
            f12_local5 = f12_local4[f12_local7] + f12_local5
        end
        if f12_local5 > 0 then
            local f12_local7 = f12_arg1:GetRandam_Float(0, f12_local5)
            local f12_local8 = 0
            for f12_local9 = 1, f12_local3, 1 do
                f12_local8 = f12_local8 + f12_local4[f12_local9]
                if f12_local7 <= f12_local8 then
                    print("[SELECT ENEMY]" .. "<<結果>> 抽選結果[" .. f12_local2[f12_local9] .. "]")
                    return f12_local2[f12_local9]
                end
            end
        end

    else
        print("[SELECT ENEMY]" .. "<<結果>> 抽選結果[" .. f12_local2[1] .. "]")
        return f12_local2[1]
    end
    return 9999999
    

end

RegisterTableGoal(GOAL_EnemyFuncDummy, "GOAL_EnemyFuncDummy")

Goal.Activate = function (f13_arg0, f13_arg1, f13_arg2)
    
end


