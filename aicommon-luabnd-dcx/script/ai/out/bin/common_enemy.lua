--[[============================================================================
    common_enemy.lua - Sekiro AI敌人通用行为模块 (Sekiro AI Common Enemy Behavior Module)

    版本信息 (Version Info): v3.0 - Comprehensive documentation upgrade
    作者 (Author): FromSoftware AI Team / Enhanced by Claude Code
    最后修改 (Last Modified): 2025-09-28
    编码格式 (Encoding): Shift-JIS (required for Sekiro compatibility)

    ============================================================================
    模块概述 (Module Overview):
    ============================================================================
    此模块定义了Sekiro AI系统中敌人的通用行为目标和行为模式。包含了攻击前准备、
    攻击后行为、步法移动、距离控制等核心战斗行为的实现。这些目标函数被各种
    敌人AI脚本广泛使用，构成了AI战斗行为的基础框架。

    核心功能模块 (Core Function Modules):
    ┌─ 攻击前行为 (Pre-Attack Behavior)
    │  ├─ GOAL_EnemyBeforeAttack - 攻击前的接近和准备行为
    │  └─ GOAL_EnemyApproachForAttack - 为攻击而接近目标
    │
    ├─ 攻击后行为 (Post-Attack Behavior)
    │  ├─ GOAL_EnemyAfterAttack - 攻击后的动态行为选择
    │  └─ GOAL_EnemyAfterAction - 基于参数的攻击后行为
    │
    ├─ 移动与步法 (Movement & Stepping)
    │  ├─ GOAL_EnemyStepRight/Left/Back/Front - 方向性步法
    │  ├─ GOAL_EnemyStepLR/BLR - 组合步法移动
    │  └─ GOAL_EnemyMoveToPoint - 目标点移动
    │
    └─ 灵活移动 (Flexible Movement)
       └─ GOAL_EnemyFlexisbleMove - 动态灵活移动系统

    ============================================================================
    战术行为ID映射 (Tactical Behavior ID Mapping):
    ============================================================================
    7000 = 防御待机 (Guard Stance) - 举盾防御状态
    7001 = 左右移动 (Lateral Movement) - 侧向移动避开攻击
    7002 = 后退移动 (Retreat Movement) - 拉开距离重新定位
    7003 = 横向步法 (Side Step) - 快速侧向闪避
    7004 = 后退步法 (Back Step) - 快速后撤闪避
    7006 = 距离维持 (Distance Maintenance) - 保持最佳战斗距离
    7007 = 前进移动 (Forward Movement) - 主动接近目标
    7008 = 前进步法 (Forward Step) - 快速前冲接近

    注意事项 (Important Notes):
    - 所有步法行为都会启动相应的冷却计时器
    - 行为选择基于距离、角度、概率等多个因素
    - 参数配置直接影响AI的战斗风格和难度
    ============================================================================
]]--

-- ===== 敌人攻击前行为目标 (Enemy Pre-Attack Behavior Goal) =====
-- 功能说明：控制敌人在发动攻击前的接近和准备行为
-- 这是攻击序列的第一阶段，负责将AI移动到合适的攻击位置
RegisterTableGoal(GOAL_EnemyBeforeAttack, "GOAL_EnemyBeforeAttack")
REGISTER_GOAL_NO_SUB_GOAL(GOAL_EnemyBeforeAttack, true)

-- 调试参数注册 (Debug Parameter Registration)
REGISTER_DBG_GOAL_PARAM(GOAL_EnemyBeforeAttack, 0, "目标对象 (Target)", 0)           -- 攻击目标
REGISTER_DBG_GOAL_PARAM(GOAL_EnemyBeforeAttack, 1, "转向目标 (Turn Target)", 0)      -- 面向目标
REGISTER_DBG_GOAL_PARAM(GOAL_EnemyBeforeAttack, 2, "基准攻击ID (Base Action ID)", 0) -- 基础攻击动作编号
REGISTER_DBG_GOAL_PARAM(GOAL_EnemyBeforeAttack, 3, "强制步行距离 (Force Walk Distance)", 0) -- 必须步行的距离
REGISTER_DBG_GOAL_PARAM(GOAL_EnemyBeforeAttack, 4, "强制跑步距离 (Force Run Distance)", 0)  -- 必须跑步的距离
REGISTER_DBG_GOAL_PARAM(GOAL_EnemyBeforeAttack, 5, "跑步概率 (Run Probability)", 0)       -- 选择跑步的概率
REGISTER_DBG_GOAL_PARAM(GOAL_EnemyBeforeAttack, 6, "防御概率 (Guard Probability)", 0)     -- 接近时防御的概率
REGISTER_DBG_GOAL_PARAM(GOAL_EnemyBeforeAttack, 7, "后步概率 (Back Step Probability)", 0) -- 后退步法的概率
REGISTER_DBG_GOAL_PARAM(GOAL_EnemyBeforeAttack, 8, "前步概率 (Front Step Probability)", 0) -- 前进步法的概率
REGISTER_DBG_GOAL_PARAM(GOAL_EnemyBeforeAttack, 9, "步法间隔 (Step Interval)", 0)         -- 步法动作的时间间隔
REGISTER_DBG_GOAL_PARAM(GOAL_EnemyBeforeAttack, 10, "后退权限 (Retreat Permission)", 0)    -- 是否允许后退行为

-- 攻击前行为目标激活函数 (Pre-Attack Behavior Goal Activation Function)
-- 功能说明：设置敌人在攻击前的接近行为，确保AI移动到最佳攻击位置
Goal.Activate = function (f1_arg0, f1_arg1, f1_arg2)
    -- 获取所有行为参数 (Get all behavior parameters)
    local f1_local0 = f1_arg2:GetParam(0)   -- 攻击目标 (Attack target)
    local f1_local1 = f1_arg2:GetParam(1)   -- 转向目标 (Turn target)
    local f1_local2 = f1_arg2:GetParam(2)   -- 基准攻击ID (Base attack ID)
    local f1_local3 = f1_arg2:GetParam(3)   -- 强制步行距离 (Force walk distance)
    local f1_local4 = f1_arg2:GetParam(4)   -- 强制跑步距离 (Force run distance)
    local f1_local5 = f1_arg2:GetParam(5)   -- 跑步概率 (Run probability)
    local f1_local6 = f1_arg2:GetParam(6)   -- 防御概率 (Guard probability)
    local f1_local7 = f1_arg2:GetParam(7)   -- 后退步法概率 (Back step probability)
    local f1_local8 = f1_arg2:GetParam(8)   -- 前进步法概率 (Front step probability)
    local f1_local9 = f1_arg2:GetParam(9)   -- 步法间隔时间 (Step interval time)

    -- 处理后退权限参数 (Process retreat permission parameter)
    local f1_local10
    if f1_arg2:GetParam(10) == true then
        f1_local10 = 1                       -- 允许后退 (Allow retreat)
    else
        f1_local10 = 0                       -- 禁止后退 (Prohibit retreat)
    end

    -- 设置AI朝向自身方向，准备接近目标 (Set AI to face self direction, prepare to approach target)
    f1_arg1:TurnTo(TARGET_SELF)

    -- 从攻击参数中获取到达距离范围 (Get arrival distance range from attack parameters)
    local f1_local11 = f1_arg1:GetAIAttackParam(f1_local2, AI_ATTACK_PARAM_TYPE__MIN_ARRIVE_DISTANCE) -- 最小到达距离
    local f1_local12 = f1_arg1:GetAIAttackParam(f1_local2, AI_ATTACK_PARAM_TYPE__MAX_ARRIVE_DISTANCE) -- 最大到达距离

    -- 添加灵活接近子目标，执行实际的接近行为 (Add flexible approach sub-goal, execute actual approach behavior)
    f1_arg2:AddSubGoal(GOAL_EnemyFlexibleApproach, f1_arg2:GetLife(), f1_local0, f1_local1, f1_local11, f1_local12, f1_local3, f1_local4, f1_local5, f1_local6, f1_local7, f1_local8, f1_local9, f1_local10)

end

-- 攻击前行为目标更新函数 (Pre-Attack Behavior Goal Update Function)
-- 功能说明：检查子目标执行状态，判断接近行为是否完成
Goal.Update = function (f2_arg0, f2_arg1, f2_arg2)
    -- 如果没有子目标在执行，说明接近行为已完成 (If no sub-goals executing, approach behavior is complete)
    if f2_arg2:GetSubGoalNum() <= 0 then
        return GOAL_RESULT_Success           -- 返回成功状态 (Return success state)
    end
    return GOAL_RESULT_Continue              -- 继续执行当前目标 (Continue executing current goal)

end

-- ===== 敌人攻击后行为目标 (Enemy Post-Attack Behavior Goal) =====
-- 功能说明：控制敌人在攻击完成后的动态行为选择
-- 这是攻击序列的第二阶段，负责根据战场情况选择最合适的后续行为
RegisterTableGoal(GOAL_EnemyAfterAttack, "GOAL_EnemyAfterAttack")
REGISTER_GOAL_NO_SUB_GOAL(GOAL_EnemyAfterAttack, true)

-- 调试参数注册 (Debug Parameter Registration)
REGISTER_DBG_GOAL_PARAM(GOAL_EnemyAfterAttack, 0, "目标对象 (Target)", 0)               -- 攻击目标
REGISTER_DBG_GOAL_PARAM(GOAL_EnemyAfterAttack, 1, "转向目标 (Turn Target)", 0)          -- 面向目标
REGISTER_DBG_GOAL_PARAM(GOAL_EnemyAfterAttack, 2, "跑步概率 (Run Probability)", 0)      -- 选择跑步移动的概率
REGISTER_DBG_GOAL_PARAM(GOAL_EnemyAfterAttack, 3, "防御概率 (Guard Probability)", 0)    -- 选择防御姿态的概率
REGISTER_DBG_GOAL_PARAM(GOAL_EnemyAfterAttack, 4, "安全距离 (Safety Distance)", 0)      -- 维持的安全作战距离
REGISTER_DBG_GOAL_PARAM(GOAL_EnemyAfterAttack, 5, "回避距离 (Evasion Distance)", 0)     -- 回避行为的目标距离
REGISTER_DBG_GOAL_PARAM(GOAL_EnemyAfterAttack, 6, "回避概率 (Evasion Probability)", 0)  -- 选择回避行为的概率
REGISTER_DBG_GOAL_PARAM(GOAL_EnemyAfterAttack, 7, "回避间隔 (Evasion Interval)", 0)     -- 回避行为的时间间隔

-- 攻击后行为目标激活函数 (Post-Attack Behavior Goal Activation Function)
-- 功能说明：基于AI参数系统动态选择攻击后的最佳行为
Goal.Activate = function (f3_arg0, f3_arg1, f3_arg2)
    -- 获取基础参数 (Get basic parameters)
    local f3_local0 = f3_arg2:GetParam(0)   -- 攻击目标 (Attack target)
    local f3_local1 = f3_arg2:GetParam(1)   -- 转向目标 (Turn target)
    local f3_local2 = f3_arg1:GetDist(f3_local0) -- 当前与目标的距离 (Current distance to target)
    local f3_local3 = f3_arg2:GetParam(2)   -- 跑步概率 (Run probability)
    local f3_local4 = f3_arg2:GetParam(3)   -- 防御概率 (Guard probability)
    local f3_local5 = 1                     -- 移动类型：1=走路, 0=跑步 (Movement type: 1=walk, 0=run)
    local f3_local6 = -1                    -- 防御ID初始值 (Guard ID initial value)
    local f3_local7 = f3_arg2:GetParam(4)   -- 安全距离 (Safety distance)
    local f3_local8 = f3_arg2:GetParam(5)   -- 回避距离 (Evasion distance)
    local f3_local9 = f3_arg2:GetParam(6)   -- 回避概率 (Evasion probability)
    local f3_local10 = f3_arg2:GetParam(7)  -- 回避间隔 (Evasion interval)
    local f3_local11 = 0                    -- 行为权重总和 (Total behavior weight)
    local f3_local12 = {}                   -- 行为权重数组 (Behavior weight array)
    if f3_arg1:GetRandam_Float(0, 100) < f3_local3 then
        f3_local5 = 0
    end
    if f3_arg1:GetRandam_Float(0, 100) < f3_local4 then
        f3_local6 = 9910
    end
    for f3_local13 = 7000, 7008, 1 do
        f3_local12[f3_local13] = 0
        if f3_arg1:IsAIAttackParam(f3_local13) then
            if f3_arg1:GetAIAttackParam(f3_local13, AI_ATTACK_PARAM_TYPE__INTERVAL_EXEC) <= f3_arg1:GetIdTimer(f3_local13 + 7100000) or f3_arg1:GetNumber(60) == 1 then
                if f3_arg1:GetAIAttackParam(f3_local13, AI_ATTACK_PARAM_TYPE__DOES_SELECT_ON_OUT_RANGE) == 1 and f3_arg1:GetAIAttackParam(f3_local13, AI_ATTACK_PARAM_TYPE__DOES_SELECT_ON_INNER_RANGE) == 1 or f3_arg1:GetAIAttackParam(f3_local13, AI_ATTACK_PARAM_TYPE__MIN_OPTIMAL_DISTANCE) <= f3_local2 and f3_local2 <= f3_arg1:GetAIAttackParam(f3_local13, AI_ATTACK_PARAM_TYPE__MAX_OPTIMAL_DISTANCE) then
                    if f3_arg1:IsOptimalAttackRangeH(f3_local0, f3_local13) then
                        local f3_local16 = f3_arg1:GetIdTimer(f3_local13 + 7100000) - f3_arg1:GetAIAttackParam(f3_local13, AI_ATTACK_PARAM_TYPE__INTERVAL_EXEC)
                        if f3_local16 < 0 then
                            f3_local16 = 1
                        end
                        print("【After Action】" .. "選択確率[" .. f3_local13 .. "]　" .. f3_arg1:GetAIAttackParam(f3_local13, AI_ATTACK_PARAM_TYPE__SELECTION_TENDENCY) .. "　　" .. f3_arg1:GetAIAttackParam(f3_local13, AI_ATTACK_PARAM_TYPE__MAX_OPTIMAL_DISTANCE))
                        f3_local12[f3_local13] = f3_local16 * f3_arg1:GetAIAttackParam(f3_local13, AI_ATTACK_PARAM_TYPE__SELECTION_TENDENCY) * GetAttackRateByDist(f3_arg0, f3_arg1, f3_arg2, f3_local13, GetDistPos(f3_arg0, f3_arg1, f3_arg2, f3_local2))
                    else
                        print("【After Action】" .. "角度外[" .. f3_local13 .. "]")
                    end
                else
                    print("【After Action】" .. "範囲外[" .. f3_local13 .. "]")
                end
            else
                print("【After Action】" .. "時間外[" .. f3_local13 .. "]")
            end
        end
        f3_local11 = f3_local11 + f3_local12[f3_local13]
    end
    if f3_local11 <= 0 then
        print("【After Action】" .. "できることなし")
        return
    end
    local f3_local13 = f3_arg1:GetRandam_Float(0.001, f3_local11)
    local f3_local14 = 9999999
    local f3_local15 = 0
    for f3_local16 = 7000, 7008, 1 do
        f3_local15 = f3_local15 + f3_local12[f3_local16]
        if f3_local13 <= f3_local15 then
            f3_local14 = f3_local16
            f3_arg2:SetNumber(0, f3_local16)
            f3_arg1:StartIdTimer(f3_local16 + 7100000)
            break
        end
    end
    if f3_local14 == 7000 then
        print("【After Action】" .. "ガード待機")
        f3_arg2:AddSubGoal(GOAL_COMMON_Guard, f3_arg2:GetLife(), 9910, f3_local0, true, 0)
    elseif f3_local14 == 7001 then
        print("【After Action】" .. "左右移動")
        f3_arg2:AddSubGoal(GOAL_COMMON_FlexibleSideWayMove, f3_arg2:GetLife(), f3_arg1:GetRandam_Float(1, 100), f3_arg1:GetRandam_Float(1, 100), f3_local0, f3_local7, f3_arg1:GetRandam_Float(45, 240), f3_local4, f3_arg1:GetAIAttackParam(7001, AI_ATTACK_PARAM_TYPE__MIN_OPTIMAL_DISTANCE), f3_arg1:GetAIAttackParam(7001, AI_ATTACK_PARAM_TYPE__MAX_OPTIMAL_DISTANCE))
    elseif f3_local14 == 7002 then
        print("【After Action】" .. "後退")
        f3_arg2:AddSubGoal(GOAL_COMMON_LeaveTarget, f3_arg2:GetLife(), f3_local0, f3_arg1:GetAIAttackParam(7002, AI_ATTACK_PARAM_TYPE__MAX_OPTIMAL_DISTANCE), f3_local0, f3_local5, GuardID, 1, true):SetFailedEndOption(AI_GOAL_FAILED_END_OPT__PARENT_NEXT_SUB_GOAL)
    elseif f3_local14 == 7003 then
        print("【After Action】" .. "横ステップ")
        f3_arg2:AddSubGoal(GOAL_EnemyStepLR, f3_arg2:GetLife(), f3_local0, f3_local7)
    elseif f3_local14 == 7004 then
        print("【After Action】" .. "後ステップ")
        f3_arg2:AddSubGoal(GOAL_EnemyStepBack, f3_arg2:GetLife(), f3_local0, f3_local7)
    elseif f3_local14 == 7006 then
        print("【After Action】" .. "距離維持")
        f3_arg2:AddSubGoal(GOAL_EnemyKeepDist, f3_arg2:GetLife(), f3_local0, f3_local1, f3_arg1:GetAIAttackParam(7006, AI_ATTACK_PARAM_TYPE__MIN_OPTIMAL_DISTANCE), f3_arg1:GetAIAttackParam(7006, AI_ATTACK_PARAM_TYPE__MAX_OPTIMAL_DISTANCE), f3_local3, f3_local4, f3_local9, 0, f3_local8, f3_local9, f3_local10, f3_local7):SetFailedEndOption(AI_GOAL_FAILED_END_OPT__PARENT_NEXT_SUB_GOAL)
    elseif f3_local14 == 7007 then
        print("【After Action】" .. "前方移動")
        local f3_local16 = f3_arg1:GetAIAttackParam(7007, AI_ATTACK_PARAM_TYPE__MIN_ARRIVE_DISTANCE)
        if f3_local16 < 0 then
            f3_local16 = 0
        end
        local f3_local17 = (f3_local16 + f3_arg1:GetAIAttackParam(7007, AI_ATTACK_PARAM_TYPE__MAX_ARRIVE_DISTANCE)) / 2
        if f3_local17 < 0 then
            f3_local17 = 0
        end
        f3_arg2:AddSubGoal(GOAL_EnemyFlexibleApproach, f3_arg2:GetLife(), f3_local0, f3_local1, f3_local17, f3_local17, 0, 999, f3_local3, f3_local4, 0, 0, 0, 0)
    elseif f3_local14 == 7008 then
        print("【After Action】" .. "前方ステップ")
        f3_arg2:AddSubGoal(GOAL_EnemyStepFront, f3_arg2:GetLife(), f3_local0, f3_local7)
    else
        print("【After Action】" .. "何もしない")
        f3_arg2:AddSubGoal(GOAL_COMMON_Turn, f3_arg2:GetLife(), f3_local0, 45, 0, 0)
    end
    


end

Goal.Update = function (f4_arg0, f4_arg1, f4_arg2)
    if f4_arg2:GetSubGoalNum() <= 0 then
        f4_arg1:TurnTo(TARGET_SELF)
        return GOAL_RESULT_Success
    end
    local f4_local0 = f4_arg2:GetParam(0)
    local f4_local1 = f4_arg2:GetParam(1)
    local f4_local2 = f4_arg1:GetDist(f4_local0)
    local f4_local3 = f4_arg2:GetNumber(0)
    if f4_local3 == 7000 then
        if (f4_arg1:GetAIAttackParam(f4_local3, AI_ATTACK_PARAM_TYPE__DOES_SELECT_ON_OUT_RANGE) == 1 and f4_arg1:GetAIAttackParam(f4_local3, AI_ATTACK_PARAM_TYPE__DOES_SELECT_ON_INNER_RANGE) == 1) == 0 and (f4_local2 < f4_arg1:GetAIAttackParam(f4_local3, AI_ATTACK_PARAM_TYPE__MIN_OPTIMAL_DISTANCE) or f4_arg1:GetAIAttackParam(f4_local3, AI_ATTACK_PARAM_TYPE__MAX_OPTIMAL_DISTANCE) < f4_local2) then
            return GOAL_RESULT_Success
        end
    elseif f4_local3 == 7002 then
    elseif f4_local3 == 7003 then
    elseif f4_local3 == 7004 then
    elseif f4_local3 == 7001 then
    elseif f4_local3 == 7006 then
    elseif f4_local3 == 7007 then
    elseif f4_local3 == 7008 then
    else
    end
    return GOAL_RESULT_Continue
    
end

-- ===== 敌人攻击后动作目标 (Enemy After Action Goal) =====
-- 功能说明：基于预设参数权重进行攻击后行为选择，提供更精确的行为控制
RegisterTableGoal(GOAL_EnemyAfterAction, "GOAL_EnemyAfterAction")
REGISTER_GOAL_NO_SUB_GOAL(GOAL_EnemyAfterAction, true)

-- 调试参数注册 (Debug Parameter Registration)
REGISTER_DBG_GOAL_PARAM(GOAL_EnemyAfterAction, 0, "目标对象 (Target)", 0)               -- 攻击目标
REGISTER_DBG_GOAL_PARAM(GOAL_EnemyAfterAction, 1, "转向目标 (Turn Target)", 1)          -- 面向目标
REGISTER_DBG_GOAL_PARAM(GOAL_EnemyAfterAction, 2, "防御移动概率 (Guard Move Prob)", 2)  -- 防御状态下移动概率
REGISTER_DBG_GOAL_PARAM(GOAL_EnemyAfterAction, 3, "待机权重 (Wait Weight)", 3)          -- 原地待机的权重
REGISTER_DBG_GOAL_PARAM(GOAL_EnemyAfterAction, 4, "防御待机权重 (Guard Wait Weight)", 4) -- 防御待机的权重
REGISTER_DBG_GOAL_PARAM(GOAL_EnemyAfterAction, 5, "横向移动权重 (Side Move Weight)", 5) -- 横向移动的权重
REGISTER_DBG_GOAL_PARAM(GOAL_EnemyAfterAction, 6, "后退权重 (Retreat Weight)", 6)      -- 后退移动的权重
REGISTER_DBG_GOAL_PARAM(GOAL_EnemyAfterAction, 7, "横向步法权重 (Side Step Weight)", 7) -- 横向步法的权重
REGISTER_DBG_GOAL_PARAM(GOAL_EnemyAfterAction, 8, "后退步法权重 (Back Step Weight)", 8) -- 后退步法的权重
REGISTER_DBG_GOAL_PARAM(GOAL_EnemyAfterAction, 9, "距离维持权重 (Distance Keep Weight)", 9) -- 距离维持的权重
REGISTER_DBG_GOAL_PARAM(GOAL_EnemyAfterAction, 10, "无动作权重 (No Action Weight)", 10) -- 不执行动作的权重

Goal.Activate = function (f5_arg0, f5_arg1, f5_arg2)
    local f5_local0 = f5_arg2:GetParam(0)
    local f5_local1 = f5_arg2:GetParam(1)
    local f5_local2 = f5_arg1:GetDist(f5_local0)
    local f5_local3 = f5_arg2:GetParam(2)
    local f5_local4 = f5_arg2:GetParam(3)
    local f5_local5 = f5_arg2:GetParam(4)
    local f5_local6 = f5_arg2:GetParam(5)
    local f5_local7 = f5_arg2:GetParam(6)
    local f5_local8 = f5_arg2:GetParam(7)
    local f5_local9 = f5_arg2:GetParam(8)
    local f5_local10 = f5_arg2:GetParam(9)
    local f5_local11 = f5_arg2:GetParam(10)
    local f5_local12 = f5_arg2:GetParam(11)
    local f5_local13 = f5_arg2:GetParam(12)
    local f5_local14 = 0
    local f5_local15 = {f5_local5, f5_local6, f5_local7, f5_local8, f5_local9, f5_local11, f5_local10}
    for f5_local16 = 7000, 7006, 1 do
        if f5_arg1:GetAIAttackParam(f5_local16, AI_ATTACK_PARAM_TYPE__MIN_OPTIMAL_DISTANCE) <= f5_local2 and f5_local2 <= f5_arg1:GetAIAttackParam(f5_local16, AI_ATTACK_PARAM_TYPE__MAX_OPTIMAL_DISTANCE) then
        else
            f5_local15[f5_local16 - 7000 + 1] = 0
        end
        f5_local14 = f5_local14 + f5_local15[f5_local16 - 7000 + 1]
    end
    local f5_local16 = f5_arg1:GetRandam_Float(0, f5_local14)
    local f5_local17 = 9999999
    local f5_local18 = 0
    for f5_local19 = 7000, 7006, 1 do
        f5_local18 = f5_local18 + f5_local15[f5_local19 - 7000 + 1]
        if f5_local16 <= f5_local18 then
            f5_local17 = f5_local19
            break
        end
    end
    if f5_local14 == 0 then
    elseif f5_local17 == 7002 then
        f5_arg2:AddSubGoal(GOAL_COMMON_LeaveTarget, f5_arg2:GetLife(), f5_local0, f5_arg1:GetAIAttackParam(7002, AI_ATTACK_PARAM_TYPE__MAX_OPTIMAL_DISTANCE), f5_local1, IsWalk, GuardID, 1, true):SetFailedEndOption(AI_GOAL_FAILED_END_OPT__PARENT_NEXT_SUB_GOAL)
        return
    elseif f5_local17 == 7003 then
        f5_arg2:AddSubGoal(GOAL_EnemyStepLR, f5_arg2:GetLife(), f5_local0, 5)
        return
    elseif f5_local17 == 7004 then
        print("後ステップ")
        f5_arg2:AddSubGoal(GOAL_EnemyStepBack, f5_arg2:GetLife(), f5_local0, 5)
        return
    elseif f5_local17 == 7001 then
        f5_arg2:SetNumber(1, 2)
        f5_arg2:AddSubGoal(GOAL_COMMON_SidewayMove, f5_arg2:GetLife(), f5_local0, f5_arg1:GetRandam_Int(0, 1), f5_arg1:GetRandam_Float(30, 60), true, true, GuardID, 1)
        return
    elseif f5_local17 == 7000 then
        f5_arg2:SetNumber(1, 1)
        f5_arg2:AddSubGoal(GOAL_COMMON_Guard, f5_arg2:GetLife(), 9910, f5_local0, true, 1)
    elseif f5_local17 == 7006 then
        f5_arg2:AddSubGoal(GOAL_EnemyKeepDist, f5_arg2:GetLife(), f5_local0, f5_local1, f5_local12, f5_local13, 50, f5_local3, 30, 0, f5_arg0.EmergencyDist, f5_arg0.EmergencyEscapeRate, f5_arg0.EmergencyEscapeInterval, f5_arg0.EmergencyCheckDist):SetFailedEndOption(AI_GOAL_FAILED_END_OPT__PARENT_NEXT_SUB_GOAL)
    else
        f5_arg2:AddSubGoal(GOAL_COMMON_Turn, f5_arg2:GetLife(), f5_local0, 90, 0, 0)
        return
    end
    


end

Goal.Update = function (f6_arg0, f6_arg1, f6_arg2)
    local f6_local0 = f6_arg2:GetParam(0)
    local f6_local1 = f6_arg1:GetDist(f6_local0)
    if f6_arg2:GetNumber(1) ~= 0 then
        local f6_local2 = -1
        if f6_arg2:GetNumber(1) == 1 then
            f6_local2 = 7000
        elseif f6_arg2:GetNumber(1) == 2 then
            f6_local2 = 7001
        end
        if f6_local1 < f6_arg1:GetAIAttackParam(f6_local2, AI_ATTACK_PARAM_TYPE__MIN_OPTIMAL_DISTANCE) or f6_arg1:GetAIAttackParam(f6_local2, AI_ATTACK_PARAM_TYPE__MAX_OPTIMAL_DISTANCE) < f6_local1 then
            f6_arg1:TurnTo(TARGET_SELF)
            return GOAL_RESULT_Success
        end
    end
    if f6_arg2:GetSubGoalNum() <= 0 then
        f6_arg1:TurnTo(TARGET_SELF)
        return GOAL_RESULT_Success
    end
    return GOAL_RESULT_Continue
    
end

RegisterTableGoal(GOAL_EnemyApproachForAttack, "GOAL_EnemyApproachForAttack")
REGISTER_GOAL_NO_SUB_GOAL(GOAL_EnemyApproachForAttack, true)
Goal.Update = Update_FinishOnNoSubGoal

Goal.Activate = function (f7_arg0, f7_arg1, f7_arg2)
    f7_arg2:AddSubGoal(GOAL_EnemyBeforeAttack, f7_arg2:GetLife(), f7_arg2:GetParam(0), f7_arg2:GetParam(1), f7_arg2:GetParam(2), f7_arg2:GetParam(3), f7_arg2:GetParam(4), f7_arg2:GetParam(5), nil, nil, nil)
    
end

-- ===== 敌人右步法目标 (Enemy Right Step Goal) =====
-- 功能说明：执行向右侧的快速步法移动，用于闪避攻击或调整位置
RegisterTableGoal(GOAL_EnemyStepRight, "GOAL_EnemyStepRight")
REGISTER_GOAL_NO_SUB_GOAL(GOAL_EnemyStepRight, true)
REGISTER_DBG_GOAL_PARAM(GOAL_EnemyStepRight, 0, "目标对象 (Target)", 0)              -- 步法面向的目标

Goal.Activate = function (f8_arg0, f8_arg1, f8_arg2)
    local f8_local0 = f8_arg2:GetParam(0)
    local f8_local1 = f8_arg2:GetParam(1)
    f8_arg1:StartIdTimer(7110004)
    f8_arg2:AddSubGoal(GOAL_COMMON_StepSafety, 5, -1, -1, -1, 1, f8_local0, f8_local1, 0, true)
    
end

-- ===== 敌人左步法目标 (Enemy Left Step Goal) =====
-- 功能说明：执行向左侧的快速步法移动，用于闪避攻击或调整位置
RegisterTableGoal(GOAL_EnemyStepLeft, "GOAL_EnemyStepLeft")
REGISTER_GOAL_NO_SUB_GOAL(GOAL_EnemyStepLeft, true)
REGISTER_DBG_GOAL_PARAM(GOAL_EnemyStepLeft, 0, "目标对象 (Target)", 0)               -- 步法面向的目标

Goal.Activate = function (f9_arg0, f9_arg1, f9_arg2)
    local f9_local0 = f9_arg2:GetParam(0)
    local f9_local1 = f9_arg2:GetParam(1)
    f9_arg2:AddSubGoal(GOAL_COMMON_StepSafety, f9_arg2:GetLife(), -1, -1, 1, -1, f9_local0, f9_local1, 0, true)
    
end

-- ===== 敌人后退步法目标 (Enemy Back Step Goal) =====
-- 功能说明：执行向后的快速步法移动，用于拉开距离或避开正面攻击
RegisterTableGoal(GOAL_EnemyStepBack, "GOAL_EnemyStepBack")
REGISTER_GOAL_NO_SUB_GOAL(GOAL_EnemyStepBack, true)
REGISTER_DBG_GOAL_PARAM(GOAL_EnemyStepBack, 0, "目标对象 (Target)", 0)               -- 步法面向的目标

Goal.Activate = function (f10_arg0, f10_arg1, f10_arg2)
    local f10_local0 = f10_arg2:GetParam(0)
    local f10_local1 = f10_arg2:GetParam(1)
    f10_arg1:StartIdTimer(7110004)
    f10_arg2:AddSubGoal(GOAL_COMMON_StepSafety, f10_arg2:GetLife(), -1, 1, -1, -1, f10_local0, f10_local1, 0, true)
    
end

Goal.Update = function (f11_arg0, f11_arg1, f11_arg2)
    if f11_arg2:GetSubGoalNum() <= 0 then
        f11_arg1:TurnTo(TARGET_SELF)
        return GOAL_RESULT_Success
    end
    return GOAL_RESULT_Continue
    
end

RegisterTableGoal(GOAL_EnemyStepLR, "GOAL_EnemyStepLR")
REGISTER_GOAL_NO_SUB_GOAL(GOAL_EnemyStepLR, true)
REGISTER_DBG_GOAL_PARAM(GOAL_EnemyStepLR, 0, "", 0)

Goal.Activate = function (f12_arg0, f12_arg1, f12_arg2)
    local f12_local0 = f12_arg2:GetParam(0)
    local f12_local1 = f12_arg2:GetParam(1)
    f12_arg1:StartIdTimer(7110004)
    f12_arg2:AddSubGoal(GOAL_COMMON_StepSafety, f12_arg2:GetLife(), -1, -1, f12_arg1:GetRandam_Float(1, 100), f12_arg1:GetRandam_Float(1, 100), f12_local0, f12_local1, 0, true)
    
end

RegisterTableGoal(GOAL_EnemyStepBLR, "GOAL_EnemyStepBLR")
REGISTER_GOAL_NO_SUB_GOAL(GOAL_EnemyStepBLR, true)
REGISTER_DBG_GOAL_PARAM(GOAL_EnemyStepBLR, 0, "", 0)

Goal.Activate = function (f13_arg0, f13_arg1, f13_arg2)
    local f13_local0 = f13_arg2:GetParam(0)
    local f13_local1 = f13_arg2:GetParam(1)
    f13_arg2:AddSubGoal(GOAL_COMMON_StepSafety, f13_arg2:GetLife(), -1, f13_arg1:GetRandam_Float(1, 100), f13_arg1:GetRandam_Float(1, 100), f13_arg1:GetRandam_Float(1, 100), f13_local0, f13_local1, 0, true)
    
end

Goal.Update = function (f14_arg0, f14_arg1, f14_arg2)
    if f14_arg2:GetSubGoalNum() <= 0 then
        f14_arg1:TurnTo(TARGET_SELF)
        return GOAL_RESULT_Success
    end
    return GOAL_RESULT_Continue
    
end

RegisterTableGoal(GOAL_EnemyStepFront, "GOAL_EnemyStepFront")
REGISTER_GOAL_NO_SUB_GOAL(GOAL_EnemyStepFront, true)
REGISTER_DBG_GOAL_PARAM(GOAL_EnemyStepFront, 0, "", 0)

Goal.Activate = function (f15_arg0, f15_arg1, f15_arg2)
    local f15_local0 = f15_arg2:GetParam(0)
    local f15_local1 = f15_arg2:GetParam(1)
    f15_arg1:StartIdTimer(7110004)
    f15_arg2:AddSubGoal(GOAL_COMMON_StepSafety, f15_arg2:GetLife(), 1, -1, -1, -1, f15_local0, f15_local1, 0, true)
    
end

Goal.Update = function (f16_arg0, f16_arg1, f16_arg2)
    if f16_arg2:GetSubGoalNum() <= 0 then
        f16_arg1:TurnTo(TARGET_SELF)
        return GOAL_RESULT_Success
    end
    return GOAL_RESULT_Continue
    
end

-- ===== 敌人移动到指定点目标 (Enemy Move To Point Goal) =====
-- 功能说明：让AI移动到指定的世界坐标点，支持事件触发和脚本控制
RegisterTableGoal(GOAL_EnemyMoveToPoint, "GOAL_EnemyMoveToPoint")
ENABLE_COMBO_ATK_CANCEL(GOAL_EnemyMoveToPoint)  -- 允许连击攻击取消此目标
REGISTER_GOAL_NO_SUB_GOAL(GOAL_EnemyMoveToPoint, true)

-- 调试参数注册 (Debug Parameter Registration)
REGISTER_DBG_GOAL_PARAM(GOAL_EnemyMoveToPoint, 0, "目标点 (Target Point)", 0)         -- 移动的目标点坐标
REGISTER_DBG_GOAL_PARAM(GOAL_EnemyMoveToPoint, 1, "转向目标 (Turn Target)", 1)        -- 移动过程中面向的目标
REGISTER_DBG_GOAL_PARAM(GOAL_EnemyMoveToPoint, 2, "到达判定距离 (Arrival Distance)", 2) -- 判定到达的距离阈值
REGISTER_DBG_GOAL_PARAM(GOAL_EnemyMoveToPoint, 3, "是否步行 (Walk Mode)", 3)          -- true=步行, false=跑步
REGISTER_DBG_GOAL_PARAM(GOAL_EnemyMoveToPoint, 4, "防御ID (Guard ID)", 4)            -- 移动时使用的防御动作ID

Goal.Activate = function (f17_arg0, f17_arg1, f17_arg2)
    local f17_local0 = f17_arg2:GetParam(0)
    local f17_local1 = f17_arg2:GetParam(1)
    local f17_local2 = f17_arg2:GetParam(2)
    local f17_local3 = f17_arg2:GetParam(3)
    local f17_local4 = f17_arg2:GetParam(4)
    f17_arg1:SetEventMoveTarget(f17_local0)
    f17_arg2:AddSubGoal(GOAL_COMMON_ApproachTarget, f17_arg2:GetLife(), POINT_EVENT, f17_local2, f17_local1, f17_local3, f17_local4)
    
end

Goal.Update = function (f18_arg0, f18_arg1, f18_arg2)
    if f18_arg2:GetSubGoalNum() <= 0 then
        f18_arg1:TurnTo(TARGET_SELF)
        return GOAL_RESULT_Success
    end
    return GOAL_RESULT_Continue
    
end

RegisterTableGoal(GOAL_EnemyFlexisbleMove, "GOAL_EnemyFlexisbleMove")
REGISTER_GOAL_NO_SUB_GOAL(GOAL_EnemyFlexisbleMove, true)
REGISTER_DBG_GOAL_PARAM(GOAL_EnemyFlexisbleMove, 0, "", 0)

Goal.Activate = function (f19_arg0, f19_arg1, f19_arg2)
    local f19_local0 = f19_arg2:GetParam(0)
    local f19_local1 = f19_arg2:GetParam(1)
    local f19_local2 = f19_arg2:GetParam(2)
    local f19_local3 = f19_arg2:GetParam(3)
    
end

Goal.Update = function (f20_arg0, f20_arg1, f20_arg2)
    if f20_arg2:GetSubGoalNum() <= 0 then
        f20_arg1:TurnTo(TARGET_SELF)
        return GOAL_RESULT_Success
    end
    return GOAL_RESULT_Continue
    
end


