--[[============================================================================
    approach_target.lua - AI目标接近系统 (AI Target Approach System)

    功能概述 (Overview):
    - 实现AI角色向指定目标的智能移动行为
    - 支持多种移动模式：步行、跑步、带防御移动
    - 提供精确的距离控制和方向管理
    - 为其他AI行为提供基础移动支持

    参数说明 (Parameter Description):
    - Param0: 移动目标ID (Movement target ID)
    - Param1: 到达判定距离 (Arrival detection distance)
    - Param2: 旋回目标ID (Turn target ID)
    - Param3: 移动模式 (Movement mode: 0=跑, 1=步行)
    - Param4: 防御动画状态ID (Guard animation state ID)
    - Param5-7: 扩展参数 (Extended parameters)

    使用场景 (Use Cases):
    - 敌人接近玩家进行攻击
    - 巡逻兵移动到指定地点
    - 支援单位前往支援目标
    - NPC跟随玩家行为
============================================================================]]

-- ===== 调试参数注册 (Debug Parameter Registration) =====
-- 为开发者提供实时调试和参数监控功能
REGISTER_DBG_GOAL_PARAM(GOAL_COMMON_ApproachTarget, 0, "移動対象", 0)          -- 移动目标 (Movement target)
REGISTER_DBG_GOAL_PARAM(GOAL_COMMON_ApproachTarget, 1, "到達判定距離", 0)      -- 到达判定距离 (Arrival detection distance)
REGISTER_DBG_GOAL_PARAM(GOAL_COMMON_ApproachTarget, 2, "旋回対象", 0)          -- 旋回目标 (Turn target)
REGISTER_DBG_GOAL_PARAM(GOAL_COMMON_ApproachTarget, 3, "歩く?", 0)             -- 是否步行 (Walk or run)
REGISTER_DBG_GOAL_PARAM(GOAL_COMMON_ApproachTarget, 4, "ガードEzState番号", 0) -- 防守动画状态ID (Guard animation state ID)

-- ===== 目标行为配置 (Goal Behavior Configuration) =====
-- 禁用Update函数，使用一次性激活模式 (Disable update function, use one-time activation mode)
REGISTER_GOAL_NO_UPDATE(GOAL_COMMON_ApproachTarget, true)
-- 禁用中断处理，减少不必要的开销 (Disable interrupt handling to reduce overhead)
REGISTER_GOAL_NO_INTERUPT(GOAL_COMMON_ApproachTarget, true)

-- ===== 接近目标行为激活函数 (Approach Target Behavior Activation Function) =====
--[[
    功能说明 (Function Description):
    - 初始化AI接近目标的行为参数
    - 设置移动方式、目标距离和附加动作
    - 委托给GOAL_COMMON_MoveToSomewhere执行具体移动

    性能优化 (Performance Optimization):
    - 参数一次性解析，避免重复计算
    - 直接调用底层移动系统，减少层级开销
]]
function ApproachTarget_Activate(f1_arg0, f1_arg1)
    -- ===== 参数解析和初始化 (Parameter Parsing and Initialization) =====
    local f1_local0 = f1_arg1:GetLife()        -- 目标生命周期 (Goal lifecycle)
    local f1_local1 = f1_arg1:GetParam(0)      -- 移动目标ID (Movement target ID)
    local f1_local2 = f1_arg1:GetParam(1)      -- 到达判定距离 (Arrival detection distance)
    local f1_local3 = f1_arg1:GetParam(2)      -- 旋回目标ID (Turn target ID) - 移动时的朝向目标
    local f1_local4 = f1_arg1:GetParam(3)      -- 移动模式 (Movement mode) - 0:跑步 1:步行
    local f1_local5 = f1_arg1:GetParam(4)      -- 防御动画状态ID (Guard animation state ID)

    -- ===== 移动方向参数设置 (Movement Direction Parameter Setup) =====
    local f1_local6 = AI_DIR_TYPE_CENTER       -- 移动方向类型：中心方向 (Movement direction type: center)
    local f1_local7 = 0                        -- 方向偏移量 (Direction offset)

    -- ===== 扩展参数获取 (Extended Parameters Retrieval) =====
    local f1_local8 = f1_arg1:GetParam(5)      -- 扩展参数5 (Extended parameter 5) - 用于特殊移动模式
    local f1_local9 = f1_arg1:GetParam(6)      -- 扩展参数6 (Extended parameter 6) - 用于移动速度调整
    local f1_local10 = f1_arg1:GetParam(7)     -- 扩展参数7 (Extended parameter 7) - 用于路径选择

    -- ===== 移动子目标创建 (Movement Sub-Goal Creation) =====
    --[[
        GOAL_COMMON_MoveToSomewhere参数说明 (Parameter Description):
        1. f1_local0  - 生命周期 (Lifecycle)
        2. f1_local1  - 目标ID (Target ID)
        3. f1_local6  - 移动方向类型 (Movement direction type)
        4. f1_local2  - 到达距离 (Arrival distance)
        5. f1_local3  - 旋回目标 (Turn target)
        6. f1_local4  - 移动模式 (Movement mode)
        7. f1_local6  - 方向参数 (Direction parameter)
        8. f1_local7  - 方向偏移 (Direction offset)
        9. f1_local10 - 路径选择 (Path selection)
        10. f1_local5 - 防御动作 (Guard action)
        11. f1_local8 - 移动模式扩展 (Movement mode extension)
        12. f1_local9 - 速度调整 (Speed adjustment)
    ]]
    f1_arg1:AddSubGoal(GOAL_COMMON_MoveToSomewhere,
        f1_local0,   -- 生命周期
        f1_local1,   -- 目标ID
        f1_local6,   -- 移动方向类型
        f1_local2,   -- 到达距离
        f1_local3,   -- 旋回目标
        f1_local4,   -- 移动模式
        f1_local6,   -- 方向参数
        f1_local7,   -- 方向偏移
        f1_local10,  -- 路径选择
        f1_local5,   -- 防御动作
        f1_local8,   -- 移动模式扩展
        f1_local9    -- 速度调整
    )

end

-- ===== 接近目标更新函数 (Approach Target Update Function) =====
--[[
    由于REGISTER_GOAL_NO_UPDATE被设置为true，此函数不会被调用
    这种设计减少了不必要的性能开销，因为接近行为通常是一次性的
    所有逻辑都在Activate函数中处理，然后由MoveToSomewhere系统接管

    Since REGISTER_GOAL_NO_UPDATE is set to true, this function won't be called.
    This design reduces unnecessary performance overhead as approach behavior is usually one-time.
    All logic is handled in the Activate function, then taken over by the MoveToSomewhere system.
]]
function ApproachTarget_Update(f2_arg0, f2_arg1, f2_arg2)
    -- 空实现 - 不会被调用 (Empty implementation - won't be called)
end

-- ===== 接近目标终止函数 (Approach Target Termination Function) =====
--[[
    在目标行为结束时被调用，用于清理资源和状态
    由于接近行为相对简单，通常不需要特殊的清理工作
    所有资源管理由系统自动处理

    Called when the goal behavior ends, used for resource cleanup and state management.
    Since approach behavior is relatively simple, no special cleanup is usually needed.
    All resource management is automatically handled by the system.
]]
function ApproachTarget_Terminate(f3_arg0, f3_arg1)
    -- 清理工作由系统自动处理 (Cleanup work automatically handled by system)
end

-- ===== 接近目标中断处理函数 (Approach Target Interrupt Handler Function) =====
--[[
    由于REGISTER_GOAL_NO_INTERUPT被设置为true，此函数不会被调用
    这种设计减少了中断处理的性能开销
    接近行为通常不需要复杂的中断处理，由底层MoveToSomewhere系统处理

    Since REGISTER_GOAL_NO_INTERUPT is set to true, this function won't be called.
    This design reduces the performance overhead of interrupt handling.
    Approach behavior usually doesn't need complex interrupt handling, handled by underlying MoveToSomewhere system.
]]
function ApproachTarget_Interupt(f4_arg0, f4_arg1)
    return false  -- 始终返回false，表示不处理任何中断 (Always return false, indicating no interrupts are handled)
end

--[[============================================================================
    使用示例和最佳实践 (Usage Examples and Best Practices):

    1. 基本接近敌人 (Basic Enemy Approach):
    f26_arg2:AddSubGoal(GOAL_COMMON_ApproachTarget, 5, TARGET_ENE_0, 3, TARGET_ENE_0, 0, -1)
    -- 参数：生命5秒，接近敌人0，距离3米，朝向敌人，跑步模式，无防御

    2. 谨慎接近目标 (Cautious Target Approach):
    f26_arg2:AddSubGoal(GOAL_COMMON_ApproachTarget, 8, TARGET_ENE_0, 5, TARGET_ENE_0, 1, 9910)
    -- 参数：生命8秒，接近敌人0，距离5米，朝向敌人，步行模式，防御姿态

    3. 巡逻移动 (Patrol Movement):
    f26_arg2:AddSubGoal(GOAL_COMMON_ApproachTarget, 10, POINT_MOVE_POINT, 1, -1, 1, -1)
    -- 参数：生命10秒，移动到巡逻点，距离1米，无朝向，步行模式，无防御

    性能优化技巧 (Performance Optimization Tips):

    1. 合理设置生命周期：
       - 短距离接近：3-5秒
       - 中距离接近：5-8秒
       - 长距离接近：8-12秒

    2. 选择合适的移动模式：
       - 跑步(0)：快速接近，但可能过于直接
       - 步行(1)：更加谨慎，适合防御性接近

    3. 距离设置建议：
       - 近身攻击：1.5-3米
       - 中距攻击：3-5米
       - 远程攻击：5-8米

    常见问题及解决方案 (Common Issues and Solutions):

    1. AI卡在障碍物上：
       - 检查导航网格是否完整
       - 设置适当的路径选择参数

    2. AI接近速度过慢：
       - 检查移动模式设置
       - 调整速度参数(Param6)

    3. AI无法准确到达目标：
       - 检查到达距离设置是否合理
       - 确认目标位置是否可达
============================================================================]]