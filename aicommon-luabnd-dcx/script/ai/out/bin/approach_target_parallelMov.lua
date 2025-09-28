--[[============================================================================
    approach_target_parallelMov.lua - AI并行移动接近系统 (AI Parallel Movement Approach System)

    功能概述 (Overview):
    - 实现AI在执行其他动作的同时进行移动的功能
    - 支持并行移动模式，允许同时执行攻击和移动
    - 基于基础ApproachTarget系统，增加并行处理能力
    - 主要用于复杂的战斗机动和组合攻击

    技术特点 (Technical Features):
    - 并行执行：移动与其他行为同时进行
    - 实时更新：每帧调用RequestParallelMove()
    - 状态保持：持续监控移动进度直到完成
    - 防御集成：支持移动中的防御动作

    使用场景 (Use Cases):
    - 边攻击边移动的战斗风格
    - 复杂的闪避机动
    - 团队协调移动
    - 持续追击战术
============================================================================]]

-- ===== 调试参数注册 (Debug Parameter Registration) =====
REGISTER_DBG_GOAL_PARAM(GOAL_COMMON_ApproachTarget_ParallelMov, 0, "移動対象", 0)                      -- 移动目标 (Movement target)
REGISTER_DBG_GOAL_PARAM(GOAL_COMMON_ApproachTarget_ParallelMov, 1, "到達判定距離", 0)                -- 到达判定距离 (Arrival detection distance)
REGISTER_DBG_GOAL_PARAM(GOAL_COMMON_ApproachTarget_ParallelMov, 2, "旋回対象", 0)                      -- 旋回目标 (Turn target)
REGISTER_DBG_GOAL_PARAM(GOAL_COMMON_ApproachTarget_ParallelMov, 3, "歩く?", 0)                           -- 是否步行 (Walk or run)
REGISTER_DBG_GOAL_PARAM(GOAL_COMMON_ApproachTarget_ParallelMov, 4, "ガードEzState番号", 0)               -- 防守动画状态ID (Guard animation state ID)
REGISTER_DBG_GOAL_PARAM(GOAL_COMMON_ApproachTarget_ParallelMov, 5, "ガードゴール終了タイプ", 0)         -- 防守目标结束类型 (Guard goal end type)
REGISTER_DBG_GOAL_PARAM(GOAL_COMMON_ApproachTarget_ParallelMov, 6, "ガードゴール:寿命が尽きたら成功とするか", 0) -- 防守目标生命结束判定 (Guard goal life end determination)

-- ===== 目标行为配置 (Goal Behavior Configuration) =====
REGISTER_GOAL_UPDATE_TIME(GOAL_COMMON_ApproachTarget_ParallelMov, 0, 0)  -- 每帧更新 (Update every frame)
REGISTER_GOAL_NO_INTERUPT(GOAL_COMMON_ApproachTarget_ParallelMov, true)  -- 禁用中断处理 (Disable interrupt handling)

-- ===== 并行移动接近目标激活函数 (Parallel Movement Approach Target Activation Function) =====
--[[
    功能说明 (Function Description):
    - 初始化并行移动系统，设置移动参数
    - 创建基础的ApproachTarget子目标作为移动执行器
    - 与基础版本的区别在于Update函数中的并行处理

    设计理念 (Design Philosophy):
    - 封装复用：复用原有ApproachTarget逻辑
    - 功能扩展：在不修改原系统的情况下增加并行能力
    - 性能优化：避免重复计算，直接委托给成熟系统
]]
function ApproachTarget_ParallelMov_Activate(f1_arg0, f1_arg1)
    -- ===== 参数解析 (Parameter Parsing) =====
    local f1_local0 = f1_arg1:GetLife()         -- 目标生命周期 (Goal lifecycle)
    local f1_local1 = f1_arg1:GetParam(0)       -- 移动目标ID (Movement target ID)
    local f1_local2 = f1_arg1:GetParam(1)       -- 到达判定距离 (Arrival detection distance)
    local f1_local3 = f1_arg1:GetParam(2)       -- 旋回目标ID (Turn target ID)
    local f1_local4 = f1_arg1:GetParam(3)       -- 移动模式 (Movement mode)
    local f1_local5 = f1_arg1:GetParam(4)       -- 防守动画状态ID (Guard animation state ID)
    local f1_local6 = f1_arg1:GetParam(5)       -- 防守目标结束类型 (Guard goal end type)
    local f1_local7 = f1_arg1:GetParam(6)       -- 防守生命结束判定 (Guard life end determination)

    -- ===== 创建基础接近目标子目标 (Create Base Approach Target Sub-Goal) =====
    --[[
        复用GOAL_COMMON_ApproachTarget的所有功能，包括：
        - 路径规划和导航
        - 碰撞检测和避障
        - 距离判定和目标追踪
        - 防御动作集成

        Reuse all functionality of GOAL_COMMON_ApproachTarget, including:
        - Path planning and navigation
        - Collision detection and obstacle avoidance
        - Distance determination and target tracking
        - Guard action integration
    ]]
    f1_arg1:AddSubGoal(GOAL_COMMON_ApproachTarget,
        f1_local0,   -- 生命周期
        f1_local1,   -- 移动目标
        f1_local2,   -- 到达距离
        f1_local3,   -- 旋回目标
        f1_local4,   -- 移动模式
        f1_local5,   -- 防守动作
        f1_local6,   -- 结束类型
        f1_local7    -- 生命判定
    )
end

-- ===== 并行移动接近目标更新函数 (Parallel Movement Approach Target Update Function) =====
--[[
    核心功能 (Core Functionality):
    - 每帧调用RequestParallelMove()启用并行移动模式
    - 允许AI在执行其他动作的同时进行移动
    - 持续监控移动状态直到子目标完成

    并行移动原理 (Parallel Movement Principle):
    - 正常情况下，AI只能执行一个动作（移动或攻击）
    - RequestParallelMove()破除这个限制，允许同时执行
    - 主要用于实现流畅的战斗机动和连续攻击

    性能考虑 (Performance Considerations):
    - 每帧调用，但RequestParallelMove()是轻量级操作
    - 不需要复杂的状态检查，系统自动处理
]]
function ApproachTarget_ParallelMov_Update(f2_arg0, f2_arg1, f2_arg2)
    -- ===== 启用并行移动模式 (Enable Parallel Movement Mode) =====
    --[[
        RequestParallelMove()功能说明：
        - 向AI系统请求并行移动模式
        - 允许当前帧同时执行移动和其他动作
        - 需要每帧调用以维持并行状态
        - 不调用时系统会自动回到串行模式

        RequestParallelMove() functionality:
        - Request parallel movement mode from AI system
        - Allow simultaneous execution of movement and other actions in current frame
        - Must be called every frame to maintain parallel state
        - System automatically returns to serial mode when not called
    ]]
    f2_arg0:RequestParallelMove()

    -- ===== 返回继续执行状态 (Return Continue Execution State) =====
    -- 保持目标活跃，直到子目标完成或生命周期结束
    return GOAL_RESULT_Continue
end

-- ===== 并行移动接近目标终止函数 (Parallel Movement Approach Target Termination Function) =====
--[[
    终止处理 (Termination Handling):
    - 当目标生命周期结束或子目标完成时被调用
    - 自动清理并行移动状态，无需手动处理
    - 系统会自动回到正常的串行执行模式

    资源清理 (Resource Cleanup):
    - 所有并行移动相关的资源由系统自动管理
    - 子目标的清理由父系统负责
    - 无需特殊的清理操作
]]
function ApproachTarget_ParallelMov_Terminate(f3_arg0, f3_arg1)
    -- 系统自动处理所有清理工作 (System automatically handles all cleanup work)
    -- 并行移动状态会自动被清除 (Parallel movement state will be automatically cleared)
end

-- ===== 并行移动接近目标中断处理函数 (Parallel Movement Approach Target Interrupt Handler Function) =====
--[[
    中断处理策略 (Interrupt Handling Strategy):
    - 由于REGISTER_GOAL_NO_INTERUPT被设置为true，此函数不会被调用
    - 这种设计避免了并行移动过程中的不必要中断
    - 所有中断处理由子目标GOAL_COMMON_ApproachTarget负责

    设计考虑 (Design Considerations):
    - 并行移动过程中的中断处理可能导致状态不一致
    - 通过禁用中断来保证移动行为的连续性
    - 提高性能和稳定性
]]
function ApproachTarget_ParallelMov_Interupt(f4_arg0, f4_arg1)
    return false  -- 不处理任何中断，由子目标系统处理 (Handle no interrupts, handled by sub-goal system)
end

--[[============================================================================
    并行移动系统使用指南 (Parallel Movement System Usage Guide):

    一、基本使用场景 (Basic Usage Scenarios):

    1. 攻击中的移动调整 (Movement Adjustment During Attack):
    -- 在执行攻击的同时调整位置
    f26_arg2:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 5, 3000, TARGET_ENE_0, 999, 0, 0)
    f26_arg2:AddSubGoal(GOAL_COMMON_ApproachTarget_ParallelMov, 5, TARGET_ENE_0, 2, TARGET_ENE_0, 0, -1)

    2. 迟範围持续攻击 (Ranged Continuous Attack):
    -- 保持攻击距离的同时进行连续射击
    f26_arg2:AddSubGoal(GOAL_COMMON_ComboRepeat, 10, 3001, TARGET_ENE_0, 999, 0, 0)
    f26_arg2:AddSubGoal(GOAL_COMMON_ApproachTarget_ParallelMov, 10, TARGET_ENE_0, 6, TARGET_ENE_0, 1, 9910)

    3. 闪避后的快速接近 (Quick Approach After Dodge):
    -- 闪避动作的同时调整位置准备下一次攻击
    f26_arg2:AddSubGoal(GOAL_COMMON_SpinStep, 3, 6001, TARGET_ENE_0, 0, AI_DIR_TYPE_L, 2)
    f26_arg2:AddSubGoal(GOAL_COMMON_ApproachTarget_ParallelMov, 3, TARGET_ENE_0, 3, TARGET_ENE_0, 0, -1)

    二、高级使用技巧 (Advanced Usage Techniques):

    1. 动态距离管理 (Dynamic Distance Management):
    -- 根据敌人状态调整保持距离
    local distance = 3  -- 默认距离
    if f26_arg1:IsInsideTarget(TARGET_ENE_0, AI_DIR_TYPE_F, 180) then
        distance = 5  -- 敌人面对时增加距离
    end
    f26_arg2:AddSubGoal(GOAL_COMMON_ApproachTarget_ParallelMov, 8, TARGET_ENE_0, distance, TARGET_ENE_0, 1, 9910)

    2. 条件性并行移动 (Conditional Parallel Movement):
    -- 只在特定条件下启用并行移动
    if f26_arg1:GetDist(TARGET_ENE_0) > 5 then
        f26_arg2:AddSubGoal(GOAL_COMMON_ApproachTarget_ParallelMov, 6, TARGET_ENE_0, 3, TARGET_ENE_0, 0, -1)
    else
        f26_arg2:AddSubGoal(GOAL_COMMON_ApproachTarget, 6, TARGET_ENE_0, 3, TARGET_ENE_0, 0, -1)
    end

    三、性能优化建议 (Performance Optimization Recommendations):

    1. 限制并行移动的使用时间：
       - 短期使用（3-8秒）效果最佳
       - 避免长时间的并行移动以减少CPU开销

    2. 合理配置并行组合：
       - 移动+攻击：最常用的组合
       - 移动+防御：适合谨慎的敌人
       - 移动+观察：适合智能型敌人

    3. 避免过度使用：
       - 在一个战斗序列中不超过2-3个并行移动目标
       - 优先使用基本ApproachTarget，只在必要时使用并行版本

    四、常见问题及解决方案 (Common Issues and Solutions):

    1. 移动不流畅或断断续续：
       - 检查是否正确设置了REGISTER_GOAL_UPDATE_TIME
       - 确认Update函数中正确调用了RequestParallelMove()

    2. 并行移动与攻击冲突：
       - 调整攻击动作的优先级
       - 使用适当的移动模式（步行或跑步）

    3. AI卡在障碍物附近：
       - 检查导航网格的完整性
       - 调整到达判定距离以避免过于精确的定位

    4. 性能问题：
       - 减少同时活跃的并行移动目标数量
       - 优化移动路径，减少不必要的方向变更
============================================================================]]