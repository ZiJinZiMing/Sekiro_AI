--[[============================================================================
    flexible_sideway.lua - 灵活侧向移动系统 (Flexible Sideway Movement System)

    功能概述 (Overview):
    - 实现AI的智能侧向移动行为，根据环境和优先级自动选择左右移动方向
    - 支持基于优先级的方向选择算法
    - 具备障碍物检测和路径安全性检查
    - 可配置的防御动作集成
    - 距离限制和安全距离管理

    核心特性 (Core Features):
    - 优先级方向选择：根据左右优先度智能选择移动方向
    - 双层安全检测：检查地面和障碍物是否可通过
    - 动态距离管理：支持最小和最大距离限制
    - 防御状态支持：移动过程中可以触发防御动作
    - 智能容错机制：第一轮检测失败时放宽条件重试

    技术要点 (Technical Points):
    - 使用优先级排序算法确定移动方向顺序
    - 结合IsExistMeshOnLine和IsExistChrOnLineSpecifyAngle进行路径检测
    - 支持步行模式和防御状态的灵活配置
    - 基于GOAL_COMMON_SidewayMove子目标执行实际移动

    应用场景 (Use Cases):
    - 战斗中的侧向闪避和机动
    - 保持与敌人的安全距离同时侧向移动
    - 需要根据环境自动选择移动方向的AI行为
    - 复杂地形中的智能导航
============================================================================]]

-- 注册灵活侧向移动目标行为
RegisterTableGoal(GOAL_COMMON_FlexibleSideWayMove, "FlexibleSideWayMove")

-- 设置为无子目标类型，直接使用SidewayMove作为执行器
REGISTER_GOAL_NO_SUB_GOAL(GOAL_COMMON_FlexibleSideWayMove, true)

-- 注册调试参数，保留原有日文注释便于开发调试
REGISTER_DBG_GOAL_PARAM(GOAL_COMMON_FlexibleSideWayMove, 0, "左優先度", 0)      -- 左侧移动优先度 (Left movement priority)
REGISTER_DBG_GOAL_PARAM(GOAL_COMMON_FlexibleSideWayMove, 1, "右優先度", 1)      -- 右侧移动优先度 (Right movement priority)
REGISTER_DBG_GOAL_PARAM(GOAL_COMMON_FlexibleSideWayMove, 2, "旋回対象", 0)      -- 旋回目标 (Turn target)
REGISTER_DBG_GOAL_PARAM(GOAL_COMMON_FlexibleSideWayMove, 3, "安全距離", 0)      -- 安全移动距离 (Safe movement distance)
REGISTER_DBG_GOAL_PARAM(GOAL_COMMON_FlexibleSideWayMove, 4, "旋回角度", 0)      -- 旋回角度限制 (Turn angle limit)
REGISTER_DBG_GOAL_PARAM(GOAL_COMMON_FlexibleSideWayMove, 5, "防御確率", 0)      -- 防御触发概率 (Guard trigger probability)
REGISTER_DBG_GOAL_PARAM(GOAL_COMMON_FlexibleSideWayMove, 6, "最低距離", 0)      -- 最小距离限制 (Minimum distance limit)
REGISTER_DBG_GOAL_PARAM(GOAL_COMMON_FlexibleSideWayMove, 7, "最大距離", 0)      -- 最大距离限制 (Maximum distance limit)

--[[============================================================================
    灵活侧向移动激活函数 (Flexible Sideway Movement Activation Function)

    功能说明 (Function Description):
    - 初始化灵活侧向移动行为，根据环境和优先级智能选择左右移动方向
    - 实现了基于优先级的方向选择算法
    - 执行双层安全检测：地面存在性检测和障碍物检测
    - 支持防御动作的随机触发

    参数映射 (Parameter Mapping):
    - f1_arg0: AI角色对象 (AI character object)
    - f1_arg1: AI实体对象 (AI entity object)
    - f1_arg2: 目标参数对象 (Goal parameter object)

    执行流程 (Execution Flow):
    1. 距离验证：检查当前距离是否在允许范围内
    2. 优先级排序：根据左右优先度对移动方向进行排序
    3. 防御状态决策：根据概率决定是否启用防御状态
    4. 双轮路径检测：
       第一轮 - 严格检测：地面存在 + 无障碍物
       第二轮 - 宽松检测：仅地面存在
    5. 执行移动：根据选定方向创建侧向移动子目标

    算法特点 (Algorithm Features):
    - 优先级排序算法确保按重要性尝试移动方向
    - 容错机制保证在复杂环境中也能找到可行路径
    - 防御状态集成提供战斗中的安全性
============================================================================]]
Goal.Activate = function (f1_arg0, f1_arg1, f1_arg2)
    -- === 第一阶段：参数获取和距离验证 (Phase 1: Parameter Acquisition and Distance Validation) ===
    local f1_local0 = f1_arg2:GetParam(2)  -- 旋回目标 (Turn target)
    local f1_local1 = f1_arg1:GetDist(f1_local0)  -- 当前到目标的距离 (Current distance to target)
    local f1_local2 = f1_arg2:GetParam(6)  -- 最小距离限制 (Minimum distance limit)
    local f1_local3 = f1_arg2:GetParam(7)  -- 最大距离限制 (Maximum distance limit)
    local f1_local4 = f1_arg2:GetParam(5)  -- 防御触发概率 (Guard trigger probability)

    -- 距离范围检查：如果不在允许范围内则直接返回
    -- Distance range check: return directly if not within allowed range
    if f1_local1 < f1_local2 or f1_local3 < f1_local1 then
        return
    end

    -- === 第二阶段：优先级排序系统 (Phase 2: Priority Sorting System) ===
    local f1_local5 = {}  -- 优先级数组 (Priority array)
    local f1_local6 = {}  -- 方向索引数组 (Direction index array)
    local f1_local7 = {AI_DIR_TYPE_L, AI_DIR_TYPE_R}  -- 方向类型映射：左/右 (Direction type mapping: left/right)
    local f1_local8 = {-90, 90}  -- 角度映射：左-90度，右90度 (Angle mapping: left -90°, right 90°)
    local f1_local9 = f1_arg2:GetParam(3)  -- 安全移动距离 (Safe movement distance)
    local f1_local10 = f1_arg2:GetParam(4)  -- 旋回角度限制 (Turn angle limit)

    -- 优先级排序算法：构建按优先度排序的方向列表
    -- Priority sorting algorithm: build direction list sorted by priority
    for f1_local11 = 0, 1, 1 do
        if f1_arg2:GetParam(f1_local11) >= 0 then
            -- 使用插入排序算法维护优先级顺序（从高到低）
            -- Use insertion sort to maintain priority order (high to low)
            local f1_local14 = table.getn(f1_local5) + 1
            for f1_local15 = 1, f1_local14 - 1, 1 do
                if f1_local5[f1_local15] < f1_arg2:GetParam(f1_local11) then
                    f1_local14 = f1_local15
                    break
                end
            end
            table.insert(f1_local5, f1_local14, f1_arg2:GetParam(f1_local11))  -- 插入优先级值
            table.insert(f1_local6, f1_local14, f1_local11 + 1)  -- 插入方向索引

        end
    end

    -- === 第三阶段：防御状态决策 (Phase 3: Guard State Decision) ===
    local f1_local11 = -1  -- 防御EzState编号，默认为-1（无防御）
    if f1_arg1:GetRandam_Float(0, 100) < f1_local4 then
        f1_local11 = 9910  -- 启用防御状态 (Enable guard state)
    end

    -- === 第四阶段：双轮路径检测和移动执行 (Phase 4: Two-Round Path Detection and Movement Execution) ===
    -- f1_local12 = 1: 第一轮严格检测（地面 + 无障碍物）
    -- f1_local12 = 2: 第二轮宽松检测（仅地面）
    for f1_local12 = 1, 2, 1 do
        -- 按优先级顺序尝试每个移动方向
        for f1_local15 = 1, table.getn(f1_local5), 1 do
            local f1_local18 = f1_local7[f1_local6[f1_local15]]  -- 获取当前优先级对应的方向类型

            -- 路径安全性检测：
            -- IsExistMeshOnLine: 检查方向上是否有可行走的地面
            -- IsExistChrOnLineSpecifyAngle: 检查方向上是否有角色障碍物
            -- f1_local12 == 2: 第二轮时放宽障碍物检测条件
            if f1_arg1:IsExistMeshOnLine(TARGET_SELF, f1_local18, f1_local9) and
               (not f1_arg1:IsExistChrOnLineSpecifyAngle(TARGET_SELF, f1_local8[f1_local6[f1_local15]], f1_local9, AI_SPA_DIR_TYPE_TargetF) or f1_local12 == 2) then

                -- 根据选定的方向添加侧向移动子目标
                if f1_local18 == AI_DIR_TYPE_L then
                    -- 向左侧移动
                    -- 参数：生命周期, 旋回目标, 方向(0=左), 旋回角度, 步行?, 继续移动?, 防御状态, 未知
                    f1_arg2:AddSubGoal(GOAL_COMMON_SidewayMove, f1_arg2:GetLife(), f1_local0, 0, f1_local10, true, true, f1_local11, 1)
                elseif f1_local18 == AI_DIR_TYPE_R then
                    -- 向右侧移动
                    -- 参数：生命周期, 旋回目标, 方向(1=右), 旋回角度, 步行?, 继续移动?, 防御状态, 未知
                    f1_arg2:AddSubGoal(GOAL_COMMON_SidewayMove, f1_arg2:GetLife(), f1_local0, 1, f1_local10, true, true, f1_local11, 1)
                end
                return  -- 成功添加移动子目标，结束函数
            end
        end
    end

    -- 如果两轮检测都没有找到可行路径，则不执行任何移动
    -- If no viable path found in both rounds, do not execute any movement

end

--[[============================================================================
    灵活侧向移动更新函数 (Flexible Sideway Movement Update Function)

    功能说明 (Function Description):
    - 监控侧向移动的执行状态
    - 持续检查距离是否仍在有效范围内
    - 判断移动是否完成或需要提前终止

    返回值 (Return Values):
    - GOAL_RESULT_Success: 移动完成或距离超出范围
    - GOAL_RESULT_Continue: 继续执行移动

    设计理念 (Design Philosophy):
    - 双重完成条件：子目标完成或距离超出范围
    - 实时距离监控：确保移动的有效性
    - 自动终止机制：避免无效移动的持续执行
============================================================================]]
Goal.Update = function (f2_arg0, f2_arg1, f2_arg2)
    -- 检查侧向移动子目标是否已完成
    if f2_arg2:GetSubGoalNum() <= 0 then
        return GOAL_RESULT_Success  -- 移动子目标完成，返回成功
    end

    -- 获取当前距离状态和限制参数
    local f2_local0 = f2_arg2:GetParam(2)  -- 旋回目标
    local f2_local1 = f2_arg1:GetDist(f2_local0)  -- 当前到目标的距离
    local f2_local2 = f2_arg2:GetParam(6)  -- 最小距离限制
    local f2_local3 = f2_arg2:GetParam(7)  -- 最大距离限制

    -- 距离范围检查：如果超出允许范围则提前结束
    -- 这种设计确保AI不会在不合适的距离继续侧向移动
    if f2_local1 < f2_local2 or f2_local3 < f2_local1 then
        return GOAL_RESULT_Success  -- 距离超出范围，提前结束移动
    end

    -- 距离仍在有效范围内，继续执行侧向移动
    return GOAL_RESULT_Continue

end


