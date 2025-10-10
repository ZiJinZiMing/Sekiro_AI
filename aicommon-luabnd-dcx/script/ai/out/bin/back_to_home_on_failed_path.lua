--[[
back_to_home_on_failed_path.lua - 路径失败时返回家园模块
================================================

【功能描述】
当AI无法到达敌人目标时，智能返回家园位置的行为系统。该模块结合了视野检测、
路径检测和定时机制，确保AI在战斗失败或无法接敌时能够安全返回起始位置。

【核心机制】
- 双重条件检测：结合视野范围和路径可用性判断
- 定时重试机制：周期性检查敌人路径恢复情况
- 返回家园行为：使用专门的BackToHome子目标
- 完成状态管理：智能判断何时结束返回行为

【应用场景】
- AI追击失败后的战术撤退
- 敌人脱离战斗范围时的复位行为
- 确保AI不会因追击而偏离防守区域
- 维持AI在指定区域内的战术态势

【技术特点】
- 40度视野角度的敌人检测
- 左侧路径检查的战术考虑
- 100秒超长返回时间限制
- 双参数配置的灵活性
--]]

function BackToHomeOnFailedPath_Activate(f1_arg0, f1_arg1)
    --[[
    【激活函数】- 初始化返回家园行为

    参数：
    - f1_arg0: AI实体对象
    - f1_arg1: 目标控制器

    功能：
    - 设置路径检查定时器
    - 启动返回家园子目标
    - 配置返回行为参数

    执行流程：
    1. 获取定时器间隔参数并设置定时器0
    2. 获取返回行为参数
    3. 添加BackToHome子目标，设置100秒超时

    技术细节：
    - 使用定时器0进行周期性路径检查
    - BackToHome子目标负责具体的返回导航
    - 100秒超时确保行为不会无限执行
    --]]
    -- 获取路径检查间隔参数
    local f1_local0 = f1_arg1:GetParam(0)
    -- 设置定时器0，控制路径检查周期
    f1_arg1:SetTimer(0, f1_local0)
    -- 获取返回家园行为参数
    local f1_local1 = f1_arg1:GetParam(1)
    -- 添加返回家园子目标，100秒超时
    f1_arg1:AddSubGoal(GOAL_COMMON_BackToHome, 100, f1_local1)

end

function BackToHomeOnFailedPath_Update(f2_arg0, f2_arg1)
    --[[
    【更新函数】- 智能路径检测和状态管理

    返回值：
    - GOAL_RESULT_Success: 路径已恢复或返回完成
    - GOAL_RESULT_Continue: 继续返回家园行为

    算法流程：
    1. 检查定时器是否到期
    2. 到期时进行双重条件检测：
       a. 检查是否在40度角内看到敌人
       b. 检查到敌人的左侧路径是否可用
    3. 双重条件满足：返回成功，可以重新接敌
    4. 条件不满足：重置定时器继续监控
    5. 无子目标时：返回完成状态

    核心设计：
    - 视野检测确保敌人在可观察范围内
    - 路径检测确保可以实际到达敌人
    - 双重验证避免误判和无效追击
    --]]
    local f2_local0 = GOAL_RESULT_Continue

    -- 检查路径检测定时器是否到期
    if true == f2_arg1:IsFinishTimer(0) then
        local f2_local1 = false

        -- 第一层检测：是否在40度角范围内看到敌人
        if true == f2_arg0:IsLookToTarget(TARGET_ENE_0, 40) then
            -- 第二层检测：检查到敌人左侧的路径是否可用
            f2_local1 = f2_arg0:CheckDoesExistPath(TARGET_ENE_0, AI_DIR_TYPE_L, 0.5, 0)
        end

        if true == f2_local1 then
            -- 双重条件满足：敌人可见且路径可达，可以重新开始追击
            f2_local0 = GOAL_RESULT_Success
        else
            -- 条件不满足，重置定时器继续监控
            local f2_local2 = f2_arg1:GetParam(0)
            f2_arg1:SetTimer(0, f2_local2)
        end
    end

    -- 检查返回家园行为是否完成
    if f2_arg1:GetSubGoalNum() <= 0 then
        -- 没有活跃子目标，返回家园行为已完成
        return GOAL_RESULT_Success
    end

    return f2_local0

end

function BackToHomeOnFailedPath_Terminate(f3_arg0, f3_arg1)
    --[[
    【终止函数】- 清理返回家园行为

    功能：
    - 当前实现为空，依赖子目标自动清理
    - 预留扩展接口

    扩展建议：
    - 记录返回家园的统计数据
    - 重置战斗相关的状态标志
    - 清理路径检测的临时数据
    - 触发返回完成事件通知
    --]]

end

function BackToHomeOnFailedPath_Interupt(f4_arg0, f4_arg1)
    --[[
    【中断处理函数】- 响应移动相关事件

    返回值：
    - true: 检测到失败路径移动结束事件
    - false: 其他情况不允许中断

    中断条件：
    - INTERUPT_MovedEnd_OnFailedPath: 失败路径上的移动结束

    设计理念：
    - 专门响应路径相关的移动事件
    - 在移动结束时允许重新评估状态
    - 保护返回行为的其他时期不被干扰

    应用价值：
    - 提供及时的状态切换机制
    - 避免AI卡在无效的移动状态
    - 确保路径问题能够得到及时处理
    --]]
    if f4_arg0:IsInterupt(INTERUPT_MovedEnd_OnFailedPath) then
        -- 失败路径上移动结束，允许中断进行状态重新评估
        return true
    end
    -- 其他情况保护返回家园行为不被中断
    return false

end


