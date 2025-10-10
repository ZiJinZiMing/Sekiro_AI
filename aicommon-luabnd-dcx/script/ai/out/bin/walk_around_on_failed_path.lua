--[[
walk_around_on_failed_path.lua - 路径失败时的巡游行为模块
====================================================

【功能描述】
当AI的正常寻路失败时，切换到自由巡游模式的智能行为系统。该模块结合了定时器机制
和路径检测，在保持AI活跃的同时等待路径条件改善，避免AI因路径问题而完全停滞。

【核心机制】
- 定时路径检测：周期性检查到目标的路径可用性
- 自由巡游模式：在路径不可用期间启用自由移动
- 动态目标生成：自动变更巡游目标点保持移动活跃性
- 智能等待策略：根据距离调整移动和等待行为

【应用场景】
- 复杂地形中的AI导航恢复
- 动态环境变化后的路径适应
- 多AI场景中的路径冲突处理
- 破坏性环境中的导航备选方案

【技术特点】
- 定时器驱动的状态检查机制
- 自由移动点的动态生成
- 面向敌人的巡游行为
- 距离敏感的行为切换
--]]

function WalkAroundOnFailedPath_Activate(f1_arg0, f1_arg1)
    --[[
    【激活函数】- 初始化路径失败巡游模式

    参数：
    - f1_arg0: AI实体对象
    - f1_arg1: 目标控制器

    功能：
    - 设置路径检查定时器
    - 启动初始等待期
    - 激活自由巡游模式

    执行流程：
    1. 获取检查间隔参数并设置定时器
    2. 添加1秒初始等待，避免立即执行
    3. 启动自由巡游模式标志

    技术细节：
    - 使用定时器0作为路径检查周期控制
    - 初始1秒等待为路径状态稳定预留时间
    - BeginWalkAroundFree()激活自由移动点生成
    --]]
    -- 获取路径检查间隔参数
    local f1_local0 = f1_arg1:GetParam(0)
    -- 设置定时器0，用于控制路径检查周期
    f1_arg1:SetTimer(0, f1_local0)
    -- 添加初始等待期，让系统状态稳定
    f1_arg1:AddSubGoal(GOAL_COMMON_Wait, 1, 0, 0, 0, 0)
    -- 启动自由巡游模式
    f1_arg0:BeginWalkAroundFree()

end

function WalkAroundOnFailedPath_Update(f2_arg0, f2_arg1)
    --[[
    【更新函数】- 核心路径检测和巡游控制逻辑

    参数：
    - f2_arg0: AI实体对象
    - f2_arg1: 目标控制器

    返回值：
    - GOAL_RESULT_Success: 路径已恢复，可以退出巡游模式
    - GOAL_RESULT_Continue: 路径仍不可用，继续巡游

    算法流程：
    1. 检查定时器是否到期
    2. 到期时检测路径可用性
    3. 路径可用：返回成功
    4. 路径不可用：重置定时器继续等待
    5. 没有子目标时：添加新的巡游目标

    核心机制：
    - 定时器驱动的路径状态轮询
    - 路径恢复的自动检测
    - 持续的巡游行为维持
    --]]
    local f2_local0 = GOAL_RESULT_Continue

    -- 检查路径检测定时器是否到期
    if true == f2_arg1:IsFinishTimer(0) then
        -- 检查到敌人目标的路径是否已恢复
        -- 参数：目标, 方向类型, 容差距离, 附加参数
        local f2_local1 = f2_arg0:CheckDoesExistPath(TARGET_ENE_0, AI_DIR_TYPE_L, 0.5, 0)

        if true == f2_local1 then
            -- 路径已恢复，可以返回正常行为
            f2_local0 = GOAL_RESULT_Success
        else
            -- 路径仍不可用，重置定时器继续等待
            local f2_local2 = f2_arg1:GetParam(0)
            f2_arg1:SetTimer(0, f2_local2)
        end
    end

    -- 检查是否需要添加新的巡游目标
    if f2_arg1:GetSubGoalNum() <= 0 then
        -- 没有活跃子目标，添加新的巡游行为
        WalkAroundFailedPath_AddInnerGoal(f2_arg0, f2_arg1)
    end

    return f2_local0

end

function WalkAroundOnFailedPath_Terminate(f3_arg0, f3_arg1)
    --[[
    【终止函数】- 清理自由巡游模式

    参数：
    - f3_arg0: AI实体对象
    - f3_arg1: 目标控制器

    功能：
    - 结束自由巡游模式
    - 清理相关状态标志

    重要性：
    - 确保AI状态的正确切换
    - 避免自由巡游模式影响后续行为
    - 释放相关系统资源
    --]]
    -- 结束自由巡游模式，恢复正常导航
    f3_arg0:EndWalkAroundFree()

end

function WalkAroundOnFailedPath_Interupt(f4_arg0, f4_arg1)
    --[[
    【中断处理函数】- 响应路径相关事件

    参数：
    - f4_arg0: AI实体对象
    - f4_arg1: 目标控制器

    返回值：
    - true: 检测到移动结束事件，允许中断
    - false: 其他情况不允许中断

    中断条件：
    - INTERUPT_MovedEnd_OnFailedPath: 失败路径上的移动结束事件

    设计思路：
    - 专门响应路径相关的移动事件
    - 保护非关键时期的巡游连续性
    - 提供及时的状态切换机制
    --]]
    if f4_arg0:IsInterupt(INTERUPT_MovedEnd_OnFailedPath) then
        -- 检测到失败路径上的移动结束，允许中断进行状态评估
        return true
    end
    -- 其他情况保护巡游行为不被中断
    return false

end

function WalkAroundFailedPath_AddInnerGoal(f5_arg0, f5_arg1)
    --[[
    【内部目标添加函数】- 生成新的巡游子目标

    参数：
    - f5_arg0: AI实体对象
    - f5_arg1: 目标控制器

    功能：
    - 生成新的自由巡游目标点
    - 根据距离选择合适的行为策略
    - 添加面向敌人的等待行为

    算法逻辑：
    1. 获取自由巡游位置点
    2. 变更巡游点位置（动态性）
    3. 计算到目标点的距离
    4. 距离>=2米：移动+等待
    5. 距离<2米：短暂等待

    技术特点：
    - 使用TARGET_ENE_0作为朝向目标
    - 30秒移动超时限制
    - 3-6秒随机等待增加自然性
    - 步行模式(true)保持隐蔽性
    --]]
    -- 获取自由巡游位置点常量
    local f5_local0 = POINT_WalkAroundPosition_Free
    -- 变更自由巡游点，增加移动的随机性
    f5_arg0:ChangeWalkAroundFreePoint()
    -- 计算到新巡游点的距离
    local f5_local1 = f5_arg0:GetDist(f5_local0)

    if f5_local1 >= 2 then
        -- 距离较远，执行移动到新位置
        -- 参数：超时时间(30s), 目标点, 朝向类型, 半径(1), 朝向目标, 步行模式
        f5_arg1:AddSubGoal(GOAL_COMMON_MoveToSomewhere, 30, f5_local0, AI_DIR_TYPE_CENTER, 1, TARGET_ENE_0, true)
        -- 到达后面向敌人等待3-6秒
        f5_arg1:AddSubGoal(GOAL_COMMON_Wait, f5_arg0:GetRandam_Int(3, 6), TARGET_ENE_0, 0, 0, 0)
    else
        -- 距离很近，直接等待
        f5_arg1:AddSubGoal(GOAL_COMMON_Wait, 0.1, TARGET_ENE_0, 0, 0, 0)
    end

end


