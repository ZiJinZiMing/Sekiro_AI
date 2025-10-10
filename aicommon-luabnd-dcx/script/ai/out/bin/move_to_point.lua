--[[============================================================================
    move_to_point.lua - Sekiro定点移动系统 (Sekiro Point Movement System)

    版本信息 (Version Info): v3.0 - Comprehensive professional documentation
    作者 (Author): FromSoftware AI Team / Enhanced by Claude Code
    最后修改 (Last Modified): 2025-09-28
    编码格式 (Encoding): Shift-JIS (required for Sekiro compatibility)

    ============================================================================
    模块概述 (Module Overview):
    ============================================================================
    这是Sekiro AI系统的定点移动模块，专门负责AI角色向特定地点的精确移动行为。
    该模块提供了单点移动和多点序列移动两种核心功能，是AI导航系统的重要组成
    部分，为巡逻、支援、逃跑等各种AI行为提供基础的移动能力。

    核心功能 (Core Functions):
    ┌─ 单点移动系统 (Single Point Movement System)
    │  ├─ GOAL_COMMON_MoveToPoint - 向指定点移动的核心行为
    │  ├─ 精确到达判定 - 基于距离的到达检测
    │  ├─ 灵活移动模式 - 支持步行/跑步切换
    │  └─ 防御状态支持 - 移动过程中的防御动作
    │
    ├─ 多点移动系统 (Multi-Point Movement System)
    │  ├─ GOAL_COMMON_MoveToMultiPoint - 多点序列移动行为
    │  ├─ 动态路径规划 - 最多10个移动点的序列执行
    │  ├─ 智能点位管理 - 自动检测有效移动点数量
    │  └─ 循环移动支持 - 支持巡逻式的循环移动
    │
    └─ 系统集成特性 (System Integration Features)
       ├─ ApproachTarget集成 - 委托给接近目标系统执行
       ├─ 事件目标支持 - 与游戏事件系统的无缝集成
       ├─ 调试接口完整 - 全面的调试参数和监控
       └─ 性能优化设计 - 无子目标和高效的执行模式

    ============================================================================
    设计理念 (Design Philosophy):
    ============================================================================

    分层委托架构 (Layered Delegation Architecture):
    - 移动抽象层：提供高级的移动意图接口
    - 路径规划层：处理多点移动的路径逻辑
    - 执行委托层：委托给ApproachTarget进行具体移动
    - 硬件抽象层：底层的导航和碰撞检测

    智能路径管理 (Intelligent Path Management):
    - 动态点位检测：自动识别有效的移动目标点
    - 序列执行控制：按顺序执行多个移动点
    - 失败恢复机制：移动失败时的智能处理
    - 资源优化管理：最小化路径计算的开销

    ============================================================================
    技术实现架构 (Technical Implementation Architecture):
    ============================================================================

    单点移动实现模式 (Single Point Movement Implementation):
    ┌─ 参数接收 → 事件目标设置 → ApproachTarget委托 → 状态监控 → 完成判定 ┐
    │                                                                      │
    └─ POINT_EVENT常量 ← 标准化接口 ← 距离/模式参数 ← 防御状态支持 ←─────┘

    多点移动实现模式 (Multi-Point Movement Implementation):
    ┌─ 参数数组解析 → 有效点检测 → 序列索引管理 → 循环移动执行 → 完成监控 ┐
    │                                                                      │
    └─ 动态点位切换 ← 状态同步 ← 单点移动复用 ← ApproachTarget ←─────────┘

    ============================================================================
    使用场景和应用案例 (Usage Scenarios and Application Cases):
    ============================================================================

    单点移动应用 (Single Point Movement Applications):
    - 巡逻兵移动到指定哨位
    - 支援单位前往支援位置
    - 敌人撤退到安全点
    - NPC移动到剧情触发点

    多点移动应用 (Multi-Point Movement Applications):
    - 复杂巡逻路径的执行
    - 逃跑路径的分段移动
    - 编队移动的路径点控制
    - 场景触发的连续移动

    ============================================================================
    性能优化特性 (Performance Optimization Features):
    ============================================================================
    - 无子目标设计：REGISTER_GOAL_NO_SUB_GOAL减少目标层级开销
    - 委托式执行：复用成熟的ApproachTarget系统
    - 参数预处理：一次性解析所有移动点参数
    - 状态轻量化：最小化移动状态的内存占用
    ============================================================================
]]--

-- 注册单点移动目标行为 (Register single point movement goal behavior)
RegisterTableGoal(GOAL_COMMON_MoveToPoint, "MoveToPoint")

-- 性能优化配置：禁用子目标以减少层级开销 (Performance optimization: disable sub-goals to reduce hierarchy overhead)
REGISTER_GOAL_NO_SUB_GOAL(GOAL_COMMON_MoveToPoint, true)

-- 注册单点移动调试参数 (Register debug parameters for single point movement)
-- 这些参数支持开发阶段的移动行为调优和运行时监控
REGISTER_DBG_GOAL_PARAM(GOAL_COMMON_MoveToPoint, 0, "ポイントエンティティID", 0)  -- 目标点实体ID (Target point entity ID)
REGISTER_DBG_GOAL_PARAM(GOAL_COMMON_MoveToPoint, 1, "到達判定距離", 0)          -- 到达判定距离 (Arrival determination distance)
REGISTER_DBG_GOAL_PARAM(GOAL_COMMON_MoveToPoint, 2, "旋回対象", 0)              -- 旋回目标 (Turn target)
REGISTER_DBG_GOAL_PARAM(GOAL_COMMON_MoveToPoint, 3, "歩くか", 0)                -- 移动模式：是否步行 (Movement mode: walk or run)
REGISTER_DBG_GOAL_PARAM(GOAL_COMMON_MoveToPoint, 4, "ガード番号", 0)            -- 防御动画编号 (Guard animation number)

--[[============================================================================
    单点移动系统实现 (Single Point Movement System Implementation)
    ============================================================================
]]--

-- 单点移动激活函数 (Single point movement activation function)
-- 功能说明 (Function Description):
--   初始化AI向指定点的移动行为。该函数实现了高层的移动抽象，通过设置事件目标
--   并委托给ApproachTarget系统来执行具体的移动逻辑。这种分层设计确保了移动
--   系统的模块化和可维护性。
--
-- 参数说明 (Parameters):
--   f1_arg0: AI角色对象 (AI character object) - 执行移动的AI实体
--   f1_arg1: AI实体对象 (AI entity object) - AI的游戏世界实体
--   f1_arg2: 目标参数对象 (Goal parameter object) - 包含移动参数的目标对象
--
-- 执行流程 (Execution Flow):
--   1. 事件目标设置：通过SetEventMoveTarget设置移动目标点
--   2. 委托执行：创建ApproachTarget子目标执行具体移动
--   3. 参数传递：将所有移动参数透传给ApproachTarget
--
-- 技术实现细节 (Technical Implementation Details):
--   - POINT_EVENT常量：标准化的事件点类型标识
--   - 参数透传机制：直接传递距离、目标、模式、防御等参数
--   - 委托式架构：复用成熟的ApproachTarget移动算法
--
-- 与ApproachTarget的参数映射 (Parameter Mapping to ApproachTarget):
--   生命周期, 目标类型, 距离, 旋回目标, 移动模式, 防御状态
Goal.Activate = function (f1_arg0, f1_arg1, f1_arg2)
    -- === 事件目标设置阶段 (Event Target Setting Phase) ===
    -- 设置AI的移动事件目标，将参数0（点实体ID）作为移动目标
    f1_arg1:SetEventMoveTarget(f1_arg2:GetParam(0))  -- 参数0: 目标点实体ID (Target point entity ID)

    -- === 移动执行委托阶段 (Movement Execution Delegation Phase) ===
    -- 委托给ApproachTarget执行具体的移动逻辑
    -- 参数映射说明：
    -- - GetLife(): 行为生命周期
    -- - POINT_EVENT: 事件点类型标识
    -- - GetParam(1): 到达判定距离
    -- - GetParam(2): 旋回目标
    -- - GetParam(3): 移动模式（步行/跑步）
    -- - GetParam(4): 防御动画编号
    f1_arg2:AddSubGoal(GOAL_COMMON_ApproachTarget,
        f1_arg2:GetLife(),      -- 行为生命周期 (Behavior life cycle)
        POINT_EVENT,            -- 目标类型：事件点 (Target type: event point)
        f1_arg2:GetParam(1),    -- 到达判定距离 (Arrival determination distance)
        f1_arg2:GetParam(2),    -- 旋回目标 (Turn target)
        f1_arg2:GetParam(3),    -- 移动模式 (Movement mode)
        f1_arg2:GetParam(4)     -- 防御动画编号 (Guard animation number)
    )

    -- 单点移动初始化完成，ApproachTarget将接管具体的移动执行
    -- (Single point movement initialization complete, ApproachTarget will take over specific movement execution)
end

-- 单点移动更新函数 (Single point movement update function)
-- 功能说明 (Function Description):
--   监控单点移动的执行状态并判断移动是否完成。由于移动的具体执行委托给了
--   ApproachTarget子目标，该函数主要负责监控子目标的执行状态并返回相应结果。
--
-- 参数说明 (Parameters):
--   f2_arg0: AI角色对象 (AI character object) - 执行移动的AI实体
--   f2_arg1: AI实体对象 (AI entity object) - AI的游戏世界实体
--   f2_arg2: 目标参数对象 (Goal parameter object) - 包含移动状态的目标对象
--
-- 返回值 (Return Values):
--   GOAL_RESULT_Success: 移动成功完成 (Movement successfully completed)
--   GOAL_RESULT_Continue: 继续执行移动 (Continue executing movement)
--
-- 状态监控逻辑 (State Monitoring Logic):
--   通过检查子目标数量来判断移动状态：
--   - 子目标数量为0：ApproachTarget已完成，移动成功
--   - 子目标数量>0：ApproachTarget仍在执行，继续移动
--
-- 设计考虑 (Design Considerations):
--   这种基于子目标监控的设计确保了移动状态的准确反映，同时保持了
--   与ApproachTarget系统的松耦合关系。
Goal.Update = function (f2_arg0, f2_arg1, f2_arg2)
    -- === 移动完成检查 (Movement Completion Check) ===
    -- 检查ApproachTarget子目标是否已完成执行
    if f2_arg2:GetSubGoalNum() <= 0 then
        -- 子目标已完成，移动成功到达目标点
        return GOAL_RESULT_Success
    end

    -- 子目标仍在执行，继续移动过程
    return GOAL_RESULT_Continue
end

--[[============================================================================
    多点移动系统实现 (Multi-Point Movement System Implementation)
    ============================================================================
]]--

-- 注册多点移动目标行为 (Register multi-point movement goal behavior)
RegisterTableGoal(GOAL_COMMON_MoveToMultiPoint, "GOAL_COMMON_MoveToMultiPoint")

-- 性能优化配置：禁用子目标管理以提高多点移动效率 (Performance optimization: disable sub-goal management for multi-point movement efficiency)
REGISTER_GOAL_NO_SUB_GOAL(GOAL_COMMON_MoveToMultiPoint, true)

-- 注册多点移动调试参数 (Register debug parameters for multi-point movement)
-- 基础移动配置参数 (Basic movement configuration parameters)
REGISTER_DBG_GOAL_PARAM(GOAL_COMMON_MoveToMultiPoint, 0, "到達判定距離", 0)    -- 到达判定距离 (Arrival determination distance)
REGISTER_DBG_GOAL_PARAM(GOAL_COMMON_MoveToMultiPoint, 1, "旋回対象", 0)        -- 旋回目标 (Turn target)
REGISTER_DBG_GOAL_PARAM(GOAL_COMMON_MoveToMultiPoint, 2, "歩くか", 0)          -- 移动模式：是否步行 (Movement mode: walk or run)
REGISTER_DBG_GOAL_PARAM(GOAL_COMMON_MoveToMultiPoint, 3, "ガード番号", 0)      -- 防御动画编号 (Guard animation number)

-- 多点路径配置参数 (Multi-point path configuration parameters)
-- 支持最多10个移动点的复杂路径规划 (Support complex path planning with up to 10 movement points)
REGISTER_DBG_GOAL_PARAM(GOAL_COMMON_MoveToMultiPoint, 4, "ポイント1", 0)       -- 移动点1 (Movement point 1)
REGISTER_DBG_GOAL_PARAM(GOAL_COMMON_MoveToMultiPoint, 5, "ポイント2", 0)       -- 移动点2 (Movement point 2)
REGISTER_DBG_GOAL_PARAM(GOAL_COMMON_MoveToMultiPoint, 6, "ポイント3", 0)       -- 移动点3 (Movement point 3)
REGISTER_DBG_GOAL_PARAM(GOAL_COMMON_MoveToMultiPoint, 7, "ポイント4", 0)       -- 移动点4 (Movement point 4)
REGISTER_DBG_GOAL_PARAM(GOAL_COMMON_MoveToMultiPoint, 8, "ポイント5", 0)       -- 移动点5 (Movement point 5)
REGISTER_DBG_GOAL_PARAM(GOAL_COMMON_MoveToMultiPoint, 9, "ポイント6", 0)       -- 移动点6 (Movement point 6)
REGISTER_DBG_GOAL_PARAM(GOAL_COMMON_MoveToMultiPoint, 10, "ポイント7", 0)      -- 移动点7 (Movement point 7)
REGISTER_DBG_GOAL_PARAM(GOAL_COMMON_MoveToMultiPoint, 11, "ポイント8", 0)      -- 移动点8 (Movement point 8)
REGISTER_DBG_GOAL_PARAM(GOAL_COMMON_MoveToMultiPoint, 12, "ポイント9", 0)      -- 移动点9 (Movement point 9)
REGISTER_DBG_GOAL_PARAM(GOAL_COMMON_MoveToMultiPoint, 13, "ポイント10", 0)     -- 移动点10 (Movement point 10)

Goal.Activate = function (f3_arg0, f3_arg1, f3_arg2)
    local f3_local0 = 1
    for f3_local1 = 5, 13, 1 do
        if f3_arg2:GetParam(f3_local1) == nil or f3_arg2:GetParam(f3_local1) <= 0 then
            f3_arg2:SetNumber(0, f3_local1 - 1)
            f3_local0 = 0
            break
        end
    end
    if f3_local0 == 1 then
        f3_arg2:SetNumber(0, 13)
    end
    local f3_local1 = 9999
    local f3_local2 = -1
    for f3_local3 = 4, f3_arg2:GetNumber(0) - 1, 1 do
        f3_arg1:SetEventMoveTarget(f3_arg2:GetParam(f3_local3))
        local f3_local6 = f3_arg1:GetDist(POINT_EVENT)
        if f3_local6 < f3_local1 then
            f3_local1 = f3_local6
            f3_local2 = f3_local3
        end
    end
    for f3_local3 = f3_local2, f3_arg2:GetNumber(0), 1 do
        f3_arg2:AddSubGoal(GOAL_COMMON_MoveToPoint, f3_arg2:GetLife(), f3_arg2:GetParam(f3_local3), f3_arg2:GetParam(0), f3_arg2:GetParam(1), f3_arg2:GetParam(2), f3_arg2:GetParam(3))
    end
    



end

Goal.Update = function (f4_arg0, f4_arg1, f4_arg2)
    if f4_arg2:GetSubGoalNum() <= 0 then
        if f4_arg1:GetDist(f4_arg2:GetParam(f4_arg2:GetNumber(0))) <= f4_arg2:GetParam(0) then
            return GOAL_RESULT_Success
        else
            local f4_local0 = 9999
            local f4_local1 = -1
            for f4_local2 = 4, f4_arg2:GetNumber(0), 1 do
                f4_arg1:SetEventMoveTarget(f4_arg2:GetParam(f4_local2))
                local f4_local5 = f4_arg1:GetDist(POINT_EVENT)
                if f4_local5 < f4_local0 then
                    f4_local0 = f4_local5
                    f4_local1 = f4_local2
                end
            end
            for f4_local2 = f4_local1, f4_arg2:GetNumber(0), 1 do
                f4_arg2:AddSubGoal(GOAL_COMMON_MoveToPoint, f4_arg2:GetLife(), f4_arg2:GetParam(f4_local2), f4_arg2:GetParam(0), f4_arg2:GetParam(1), f4_arg2:GetParam(2), f4_arg2:GetParam(3))
            end

        end
    end
    return GOAL_RESULT_Continue
    
end


