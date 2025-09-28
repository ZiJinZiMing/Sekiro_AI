--[[============================================================================
    enemy_common_SubGoal.lua - 敌人通用子目标系统 (Enemy Common Sub-Goal System)

    版本信息 (Version Info): v3.0 - Comprehensive professional documentation
    作者 (Author): FromSoftware AI Team / Enhanced by Claude Code
    最后修改 (Last Modified): 2025-09-28
    编码格式 (Encoding): Shift-JIS (required for Sekiro compatibility)

    ============================================================================
    模块概述 (Module Overview):
    ============================================================================
    这是Sekiro AI系统中敌人通用子目标行为的核心模块，提供了可复用的
    战斗行为组件，包括攻击、接近、后退、侧移等基础战术动作。该模块
    采用模块化设计，为不同类型的敌人提供标准化的行为实现。

    核心功能模块 (Core Function Modules):
    ┌─ 攻击行为系统 (Attack Behavior System)
    │  ├─ EnemyCommonSubGoal_Attack - 多段攻击组合执行
    │  ├─ 动画偏移计算 - 支持特殊效果下的动画变化
    │  └─ 概率驱动的攻击序列选择
    │
    ├─ 移动行为系统 (Movement Behavior System)
    │  ├─ EnemyCommonSubGoal_ApproachAct - 智能接近行为
    │  ├─ EnemyCommonSubGoal_ApproachAct_For_Beast - 野兽专用接近
    │  ├─ EnemyCommonSubGoal_LeaveTarget - 战术后退行为
    │  └─ EnemyCommonSubGoal_SideWalk - 侧向移动包抄
    │
    ├─ 战术决策系统 (Tactical Decision System)
    │  ├─ 基于距离的行为选择算法
    │  ├─ 团队协调的侧移控制
    │  └─ 概率权重的随机行为选择
    │
    └─ 状态管理系统 (State Management System)
       ├─ 攻击后行为处理 (EnemyCommonSubGoal_AfterAttack)
       ├─ 特殊效果监测和响应
       └─ 动画ID的动态偏移计算

    ============================================================================
    设计特点 (Design Features):
    ============================================================================
    1. 模块化架构：每个子目标都是独立的可复用组件
    2. 参数驱动：通过参数系统灵活配置行为细节
    3. 概率控制：使用权重和概率实现自然的行为变化
    4. 团队协调：支持多AI单位的协同行为
    5. 特殊效果支持：动态响应游戏状态变化

    性能优化 (Performance Optimization):
    - 使用本地缓存减少重复计算
    - 概率计算优化避免复杂的分支逻辑
    - 团队记录系统减少冲突检测开销
    ============================================================================
]]--

-- ===== 全局配置数组 (Global Configuration Arrays) =====
local f0_local0 = {4, 5, 15}      -- 近距离行为权重表 (Close range behavior weight table)
local f0_local1 = {10, 4, 15}     -- 远距离行为权重表 (Far range behavior weight table)
local f0_local2 = {}              -- 临时数据缓存 (Temporary data cache)
local f0_local3 = -1              -- 未使用的标识符 (Unused identifier)
local f0_local4 = 0               -- 动画偏移值缓存 (Animation offset value cache)

--[[============================================================================
    通用列表索引选择函数 (Universal List Index Selection Function)
    ============================================================================
]]--

-- 基于权重的随机列表索引选择算法 (Weight-based random list index selection algorithm)
-- 功能说明 (Function Description):
--   这是一个通用的概率选择算法，根据提供的权重数组随机选择一个索引。
--   该函数实现了标准的轮盘赌选择算法，确保每个选项被选择的概率与其权重成正比。
--
-- 参数说明 (Parameters):
--   f1_arg0: AI实体对象 (AI entity object) - 提供随机数生成服务
--   f1_arg1: 权重数组 (Weight array) - 包含各选项权重值的数组
--
-- 返回值 (Return Value):
--   选中的数组索引 (Selected array index) - 返回1-based索引，失败时返回-1
--
-- 算法流程 (Algorithm Flow):
--   1. 计算所有权重的总和
--   2. 生成0到总和之间的随机数
--   3. 累积遍历数组，找到随机数对应的区间
--   4. 返回对应区间的索引
--
-- 使用示例 (Usage Example):
--   local weights = {10, 30, 60}  -- 权重：10%, 30%, 60%
--   local selected = Select_ListIndex_For_EnemyCommonSubGoal(ai, weights)
--   -- selected 有10%机会为1, 30%机会为2, 60%机会为3
function Select_ListIndex_For_EnemyCommonSubGoal(f1_arg0, f1_arg1)
    -- === 阶段1：计算权重总和 (Phase 1: Calculate total weight) ===
    local f1_local0 = 0                                    -- 权重总和累积器 (Weight sum accumulator)
    for f1_local1 = 1, table.getn(f1_arg1), 1 do
        f1_local0 = f1_local0 + f1_arg1[f1_local1]        -- 累加所有权重值 (Accumulate all weight values)
    end

    -- === 阶段2：生成随机选择点 (Phase 2: Generate random selection point) ===
    local f1_local1 = f1_arg0:GetRandam_Int(0, f1_local0) -- 在[0, 总权重)范围内生成随机数 (Generate random number in [0, total_weight))

    -- === 阶段3：查找对应的权重区间 (Phase 3: Find corresponding weight interval) ===
    local f1_local2 = 0                                    -- 累积权重计数器 (Cumulative weight counter)
    for f1_local3 = 1, table.getn(f1_arg1), 1 do
        f1_local2 = f1_arg1[f1_local3] + f1_local2        -- 累加到当前项 (Accumulate to current item)
        -- 检查随机数是否落在当前权重区间内且权重大于0 (Check if random number falls in current weight interval and weight > 0)
        if f1_local1 < f1_local2 and 0 < f1_arg1[f1_local3] then
            return f1_local3                               -- 返回选中的索引 (Return selected index)
        end
    end
    return -1                                              -- 所有权重为0或出错时返回-1 (Return -1 when all weights are 0 or error occurs)
end

--[[============================================================================
    动画偏移计算函数 (Animation Offset Calculation Function)
    ============================================================================
]]--

-- 敌人通用子目标动画偏移获取函数 (Enemy common sub-goal animation offset acquisition function)
-- 功能说明 (Function Description):
--   根据AI角色身上的特殊效果状态，动态计算动画ID的偏移量。这个系统允许
--   相同的基础动画ID在不同状态下触发不同的变种动画，实现丰富的视觉效果。
--
-- 参数说明 (Parameters):
--   f2_arg0: AI实体对象 (AI entity object) - 需要检查特殊效果的AI角色
--   f2_arg1: 基础动画ID (Base animation ID) - 原始的动画标识符
--
-- 返回值 (Return Value):
--   调整后的动画ID (Adjusted animation ID) - 应用偏移后的最终动画ID
--
-- 特殊效果偏移映射 (Special Effect Offset Mapping):
--   效果5404: -1000000偏移 - 通常用于强化状态的动画变种
--   效果5405: -2000000偏移 - 通常用于虚弱状态的动画变种
--   效果5406: -3000000偏移 - 通常用于特殊能力状态的动画变种
--   效果5407: -4000000偏移 - 通常用于boss阶段变化的动画变种
--   无效果:   0偏移        - 使用原始动画ID
--
-- 设计理念 (Design Philosophy):
--   这种偏移系统允许动画师为相同的攻击动作创建多个视觉变种，而AI逻辑
--   保持不变，大大提高了动画资源的利用效率和游戏的视觉丰富度。
--
-- 使用示例 (Usage Example):
--   local baseAnimId = 3001                    -- 基础攻击动画
--   local finalAnimId = Get_AnimOffset_For_EnemyCommonSubGoal(ai, baseAnimId)
--   -- 如果AI有特殊效果5404，则finalAnimId = 2001 (3001-1000000)
function Get_AnimOffset_For_EnemyCommonSubGoal(f2_arg0, f2_arg1)
    -- 输入验证：无效动画ID直接返回 (Input validation: return invalid animation ID directly)
    if f2_arg1 == -1 then
        return -1
    end

    -- === 特殊效果检测和偏移计算 (Special Effect Detection and Offset Calculation) ===

    -- 检测强化状态效果 (Detect enhancement state effect)
    if f2_arg0:HasSpecialEffectId(TARGET_SELF, 5404) then
        f2_arg1 = f2_arg1 - 1000000               -- 应用强化状态动画偏移 (Apply enhancement state animation offset)
        f0_local4 = 1000000                       -- 缓存偏移值供后续使用 (Cache offset value for later use)

    -- 检测虚弱状态效果 (Detect weakened state effect)
    elseif f2_arg0:HasSpecialEffectId(TARGET_SELF, 5405) then
        f2_arg1 = f2_arg1 - 2000000               -- 应用虚弱状态动画偏移 (Apply weakened state animation offset)
        f0_local4 = 2000000                       -- 缓存偏移值 (Cache offset value)

    -- 检测特殊能力状态效果 (Detect special ability state effect)
    elseif f2_arg0:HasSpecialEffectId(TARGET_SELF, 5406) then
        f2_arg1 = f2_arg1 - 3000000               -- 应用特殊能力动画偏移 (Apply special ability animation offset)
        f0_local4 = 3000000                       -- 缓存偏移值 (Cache offset value)

    -- 检测boss阶段变化效果 (Detect boss phase change effect)
    elseif f2_arg0:HasSpecialEffectId(TARGET_SELF, 5407) then
        f2_arg1 = f2_arg1 - 4000000               -- 应用boss阶段动画偏移 (Apply boss phase animation offset)
        f0_local4 = 4000000                       -- 缓存偏移值 (Cache offset value)

    -- 无特殊效果：使用原始动画ID (No special effect: use original animation ID)
    else
        f0_local4 = 0                             -- 无偏移 (No offset)
    end

    return f2_arg1                                -- 返回计算后的动画ID (Return calculated animation ID)
end

RegisterTableGoal(GOAL_EnemyCommonSubGoal_Attack, "EnemyCommonSubGoal_Attack")
REGISTER_GOAL_NO_SUB_GOAL(GOAL_EnemyCommonSubGoal_Attack, true)
REGISTER_DBG_GOAL_PARAM(GOAL_EnemyMultiAttack, 0, "攻撃1", 0)
REGISTER_DBG_GOAL_PARAM(GOAL_EnemyMultiAttack, 1, "攻撃2", 1)
REGISTER_DBG_GOAL_PARAM(GOAL_EnemyMultiAttack, 2, "攻撃3", 2)

Goal.Activate = function (f3_arg0, f3_arg1, f3_arg2)
    local f3_local0 = Get_AnimOffset_For_EnemyCommonSubGoal(f3_arg1, f3_arg2:GetParam(0))
    local f3_local1 = Get_AnimOffset_For_EnemyCommonSubGoal(f3_arg1, f3_arg2:GetParam(1))
    local f3_local2 = Get_AnimOffset_For_EnemyCommonSubGoal(f3_arg1, f3_arg2:GetParam(2))
    local f3_local3 = f3_arg2:GetParam(3)
    local f3_local4 = f3_arg2:GetParam(4)
    local f3_local5 = f3_arg2:GetParam(5)
    if f3_local3 == -1 then
        f3_local3 = TARGET_ENE_0
    end
    if f3_local4 == -1 then
        f3_local4 = 50
    end
    if f3_local5 == -1 then
        f3_local5 = 50
    end
    if attackIndex1 == -1 then
        print("※※※ 攻撃IDが入力されてません ※※※")
    elseif f3_local4 < f3_arg1:GetRandam_Int(1, 100) or f3_local1 == -1 then
        f3_arg2:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 10, f3_local0, f3_local3, f3_arg1:GetAIAttackParam(f3_local0, AI_ATTACK_PARAM_TYPE__SUCCESS_DISTANCE), f3_arg1:GetAIAttackParam(f3_local0, AI_ATTACK_PARAM_TYPE__TURN_TIME_BEFORE_ATTACK), f3_arg1:GetAIAttackParam(f3_local0, AI_ATTACK_PARAM_TYPE__FRONT_ANGLE_RANGE))
    elseif f3_local5 < f3_arg1:GetRandam_Int(1, 100) or f3_local2 == -1 then
        f3_arg2:AddSubGoal(GOAL_COMMON_ComboAttackTunableSpin, 10, f3_local0, f3_local3, f3_arg1:GetAIAttackParam(f3_local0, AI_ATTACK_PARAM_TYPE__SUCCESS_DISTANCE), f3_arg1:GetAIAttackParam(f3_local0, AI_ATTACK_PARAM_TYPE__TURN_TIME_BEFORE_ATTACK), f3_arg1:GetAIAttackParam(f3_local0, AI_ATTACK_PARAM_TYPE__FRONT_ANGLE_RANGE))
        f3_arg2:AddSubGoal(GOAL_COMMON_ComboFinal, 10, f3_local1, f3_local3, f3_arg1:GetAIAttackParam(f3_local1, AI_ATTACK_PARAM_TYPE__SUCCESS_DISTANCE), f3_arg1:GetAIAttackParam(f3_local1, AI_ATTACK_PARAM_TYPE__TURN_TIME_BEFORE_ATTACK), f3_arg1:GetAIAttackParam(f3_local1, AI_ATTACK_PARAM_TYPE__FRONT_ANGLE_RANGE))
    else
        f3_arg2:AddSubGoal(GOAL_COMMON_ComboAttackTunableSpin, 10, f3_local0, f3_local3, f3_arg1:GetAIAttackParam(f3_local0, AI_ATTACK_PARAM_TYPE__SUCCESS_DISTANCE), f3_arg1:GetAIAttackParam(f3_local0, AI_ATTACK_PARAM_TYPE__TURN_TIME_BEFORE_ATTACK), f3_arg1:GetAIAttackParam(f3_local0, AI_ATTACK_PARAM_TYPE__FRONT_ANGLE_RANGE))
        f3_arg2:AddSubGoal(GOAL_COMMON_ComboRepeat, 10, f3_local1, f3_local3, f3_arg1:GetAIAttackParam(f3_local2, AI_ATTACK_PARAM_TYPE__SUCCESS_DISTANCE), f3_arg1:GetAIAttackParam(f3_local1, AI_ATTACK_PARAM_TYPE__TURN_TIME_BEFORE_ATTACK), f3_arg1:GetAIAttackParam(f3_local1, AI_ATTACK_PARAM_TYPE__FRONT_ANGLE_RANGE))
        f3_arg2:AddSubGoal(GOAL_COMMON_ComboFinal, 10, f3_local2, f3_local3, f3_arg1:GetAIAttackParam(f3_local2, AI_ATTACK_PARAM_TYPE__SUCCESS_DISTANCE), f3_arg1:GetAIAttackParam(f3_local2, AI_ATTACK_PARAM_TYPE__TURN_TIME_BEFORE_ATTACK), f3_arg1:GetAIAttackParam(f3_local2, AI_ATTACK_PARAM_TYPE__FRONT_ANGLE_RANGE))
    end
    
end

Goal.Update = function (f4_arg0, f4_arg1, f4_arg2)
    if f4_arg2:GetSubGoalNum() <= 0 then
        return GOAL_RESULT_Success
    end
    return GOAL_RESULT_Continue
    
end

RegisterTableGoal(GOAL_EnemyCommonSubGoal_AfterAttack, "EnemyCommonSubGoal_AfterAttack")
REGISTER_GOAL_NO_SUB_GOAL(GOAL_EnemyCommonSubGoal_AfterAttack, true)

Goal.Activate = function (f5_arg0, f5_arg1, f5_arg2)
    local f5_local0 = {}
    local f5_local1 = f5_arg1:GetDist(TARGET_ENE_0)
    if f5_local1 < 2.5 then
        f5_local0 = f0_local0
    else
        f5_local0 = f0_local1
    end
    local f5_local2 = 9910
    local f5_local3 = Select_ListIndex_For_PriestSoldier_115000(f5_arg1, f5_local0)
    if f5_local3 == 1 then
        f5_arg2:AddSubGoal(GOAL_COMMON_LeaveTarget, 5, TARGET_ENE_0, distLeave, TARGET_ENE_0, true, f5_local2)
    elseif f5_local3 == 2 then
        f5_arg2:AddSubGoal(GOAL_EnemyCommonSubGoal_SideWalk, 10, f5_arg1:GetRandam_Int(2, 3), f5_local2)
    end
    
end

Goal.Update = function (f6_arg0, f6_arg1, f6_arg2)
    if f6_arg2:GetSubGoalNum() <= 0 then
        return GOAL_RESULT_Success
    end
    return GOAL_RESULT_Continue
    
end

RegisterTableGoal(GOAL_EnemyCommonSubGoal_ApproachAct, "EnemyCommonSubGoal_ApproachAct")
REGISTER_DBG_GOAL_PARAM(GOAL_EnemyMultiAttack, 5, "ガード確率", 5)

Goal.Activate = function (f7_arg0, f7_arg1, f7_arg2)
    local f7_local0 = Get_AnimOffset_For_EnemyCommonSubGoal(f7_arg1, f7_arg2:GetParam(0))
    local f7_local1 = f7_arg2:GetParam(1)
    local f7_local2 = f7_arg2:GetParam(2)
    local f7_local3 = f7_arg2:GetParam(3)
    local f7_local4 = f7_arg2:GetParam(4)
    local f7_local5 = f7_arg2:GetParam(5)
    local f7_local6 = f7_arg2:GetParam(6)
    if f7_local1 == -1 then
        f7_local1 = TARGET_ENE_0
    end
    if turnTarget == -1 then
        turnTarget = TARGET_ENE_0
    end
    if f7_local2 == -1 then
        f7_local2 = f7_arg1:GetAIAttackParam(f7_local0, AI_ATTACK_PARAM_TYPE__MAX_OPTIMAL_DISTANCE)
    end
    if f7_local3 == -1 then
        f7_local3 = 4
    end
    if f7_local4 == -1 then
        f7_local4 = 20
    end
    if f7_local5 == -1 then
        f7_local5 = 80
    end
    if f7_local6 == -1 then
        f7_local6 = 0
    end
    local f7_local7 = f7_arg1:GetDist(TARGET_ENE_0)
    local f7_local8 = true
    if f7_local2 + f7_local3 < f7_local7 and f7_arg1:GetRandam_Int(1, 100) < f7_local5 then
        f7_local8 = false
    end
    local f7_local9 = -1
    if f7_local8 == true and f7_arg1:GetRandam_Int(1, 100) <= f7_local6 then
        f7_local9 = 9910
    end
    f7_arg2:AddSubGoal(GOAL_COMMON_ApproachTarget, 5, f7_local1, f7_local2, TARGET_SELF, f7_local8, f7_local9)
    
end

RegisterTableGoal(GOAL_EnemyCommonSubGoal_ApproachAct_For_Beast, "EnemyCommonSubGoal_ApproachAct_For_Beast")

Goal.Activate = function (f8_arg0, f8_arg1, f8_arg2)
    local f8_local0 = Get_AnimOffset_For_EnemyCommonSubGoal(f8_arg1, f8_arg2:GetParam(0))
    local f8_local1 = f8_arg2:GetParam(1)
    local f8_local2 = f8_arg2:GetParam(2)
    local f8_local3 = f8_arg2:GetParam(3)
    local f8_local4 = f8_arg2:GetParam(4)
    local f8_local5 = f8_arg2:GetParam(5)
    local f8_local6 = f8_arg2:GetParam(6)
    if f8_local1 == -1 then
        f8_local1 = TARGET_ENE_0
    end
    if f8_local2 == -1 then
        f8_local2 = f8_arg1:GetAIAttackParam(f8_local0, AI_ATTACK_PARAM_TYPE__MAX_OPTIMAL_DISTANCE)
    end
    if f8_local3 == -1 then
        f8_local3 = 4
    end
    if f8_local4 == -1 then
        f8_local4 = 20
    end
    if f8_local5 == -1 then
        f8_local5 = 80
    end
    if f8_local6 == -1 then
        f8_local6 = 0
    end
    local f8_local7 = f8_arg1:GetDist(TARGET_ENE_0)
    local f8_local8 = true
    if f8_local2 + f8_local3 < f8_local7 then
        if f8_arg1:GetRandam_Int(1, 100) <= f8_local5 then
            f8_local8 = false
        end
    elseif f8_arg1:GetRandam_Int(1, 100) <= f8_local4 then
        f8_local8 = false
    end
    local f8_local9 = -1
    if f8_local8 == true and f8_arg1:GetRandam_Int(1, 100) <= f8_local6 then
        f8_local9 = 9910
    end
    f8_arg2:AddSubGoal(GOAL_COMMON_ApproachTarget, 5, f8_local1, f8_local2, TARGET_SELF, f8_local8, f8_local9)
    
end

RegisterTableGoal(GOAL_EnemyCommonSubGoal_LeaveTarget, "EnemyCommonSubGoal_LeaveTarget")

Goal.Activate = function (f9_arg0, f9_arg1, f9_arg2)
    local f9_local0 = f9_arg2:GetParam(0)
    local f9_local1 = f9_arg2:GetParam(1)
    local f9_local2 = f9_arg1:GetDist(TARGET_ENE_0)
    local f9_local3 = -1
    if f9_arg1:GetRandam_Int(1, 100) < f9_arg2:GetParam(2) then
        f9_local3 = 9910
    end
    if f9_local0 == 0 then
        f9_arg2:AddSubGoal(GOAL_COMMON_LeaveTarget, 5, TARGET_ENE_0, f9_local1, TARGET_ENE_0, true, f9_local3):SetTargetRange(0, f9_local2 / 2, f9_local2 + 20)
    else
        f9_arg2:AddSubGoal(GOAL_COMMON_LeaveTarget, 5, TARGET_ENE_0, f9_local1, TARGET_SELF, false, -1)
    end
    
end

RegisterTableGoal(GOAL_EnemyCommonSubGoal_SideWalk, "EnemyCommonSubGoal_SideWalk")
REGISTER_GOAL_NO_SUB_GOAL(EnemyCommonSubGoal_SideWalk, true)

Goal.Activate = function (f10_arg0, f10_arg1, f10_arg2)
    local f10_local0 = f10_arg2:GetParam(0)
    local f10_local1 = f10_arg1:GetDist(TARGET_ENE_0)
    local f10_local2 = false
    local f10_local3 = f10_arg1:GetTeamRecordCount(COORDINATE_TYPE_SideWalk_L, TARGET_ENE_0, 5)
    local f10_local4 = f10_arg1:GetTeamRecordCount(COORDINATE_TYPE_SideWalk_R, TARGET_ENE_0, 5)
    local f10_local5 = -1
    if f10_arg1:GetRandam_Int(1, 100) < f10_arg2:GetParam(1) then
        f10_local5 = 9910
    end
    if f10_local0 == 2 then
        if f10_local3 < 1 or f10_local2 == true then
            f10_arg2:AddSubGoal(GOAL_COMMON_SidewayMove, f10_arg1:GetRandam_Float(2, 3), TARGET_ENE_0, SIDEWAY_MOVE_LEFT, f10_arg1:GetRandam_Int(30, 60), true, true, f10_local5)
            f10_arg2:GetLatestAddGoalFunc():AddGoalScopedTeamRecord(COORDINATE_TYPE_SideWalk_L, TARGET_ENE_0, 0)
        else
            f10_arg2:AddSubGoal(GOAL_COMMON_SidewayMove, f10_arg1:GetRandam_Float(2, 3), TARGET_ENE_0, SIDEWAY_MOVE_RIGHT, f10_arg1:GetRandam_Int(30, 60), true, true, f10_local5)
            f10_arg2:GetLatestAddGoalFunc():AddGoalScopedTeamRecord(COORDINATE_TYPE_SideWalk_R, TARGET_ENE_0, 0)
        end
    elseif f10_local0 == 3 then
        if f10_local4 < 1 or f10_local2 == true then
            f10_arg2:AddSubGoal(GOAL_COMMON_SidewayMove, f10_arg1:GetRandam_Float(2, 3), TARGET_ENE_0, SIDEAY_MOVE_RIGHT, f10_arg1:GetRandam_Int(30, 60), true, true, f10_local5)
            f10_arg2:GetLatestAddGoalFunc():AddGoalScopedTeamRecord(COORDINATE_TYPE_SideWalk_R, TARGET_ENE_0, 0)
        else
            f10_arg2:AddSubGoal(GOAL_COMMON_SidewayMove, f10_arg1:GetRandam_Float(2, 3), TARGET_ENE_0, SIDEWAY_MOVE_LEFT, f10_arg1:GetRandam_Int(30, 60), true, true, f10_local5)
            f10_arg2:GetLatestAddGoalFunc():AddGoalScopedTeamRecord(COORDINATE_TYPE_SideWalk_L, TARGET_ENE_0, 0)
        end
    end
    
end

Goal.Update = function (f11_arg0, f11_arg1, f11_arg2)
    if f11_arg2:GetSubGoalNum() <= 0 then
        return GOAL_RESULT_Success
    end
    return GOAL_RESULT_Continue
    
end


