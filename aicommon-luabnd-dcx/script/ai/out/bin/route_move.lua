--[[============================================================================
    route_move.lua - AI路径巡回移动系统 (AI Route Patrol Movement System)

    功能概述 (Overview):
    - 实现AI沿预定路径进行巡回移动的行为系统
    - 支持基于路径实体的自动导航
    - 提供灵活的巡回模式配置（从起点开始或最近点开始）
    - 可控制是否在路径终点结束巡回
    - 集成平滑移动算法确保自然流畅的移动效果

    核心特性 (Core Features):
    - 路径实体绑定：通过实体ID关联预定义的巡回路径
    - 智能起点选择：可选择从路径起点或最近点开始
    - 终点控制：支持到达终点后结束或循环巡回
    - 连续移动：使用双目标缓冲确保移动连续性
    - 平滑导航：使用MoveToSomewhereSmooth实现流畅过渡

    技术要点 (Technical Points):
    - 使用POINT_MOVE_POINT作为路径点类型
    - 支持可配置的到达判定距离
    - 可选步行或跑步移动模式
    - 集成路径结束检测机制
    - 不可中断设计确保巡回的完整性

    应用场景 (Use Cases):
    - 守卫的固定巡逻路线
    - NPC的日常移动路径
    - 敌人的预定巡回区域
    - 场景中的动态角色路径
============================================================================]]

-- 设置为无子目标类型，直接管理移动行为
REGISTER_GOAL_NO_SUB_GOAL(GOAL_COMMON_RouteMove, true)

-- 注册调试参数，保留原有日文注释便于开发调试
REGISTER_DBG_GOAL_PARAM(GOAL_COMMON_RouteMove, 0, "ルートのエンティティID", 0)            -- 路径实体ID (Route entity ID)
REGISTER_DBG_GOAL_PARAM(GOAL_COMMON_RouteMove, 1, "開始点から巡回を始めるか？", 0)           -- 是否从起点开始巡回 (Start patrol from beginning?)
REGISTER_DBG_GOAL_PARAM(GOAL_COMMON_RouteMove, 2, "終端で巡回を終了するか？", 0)            -- 是否在终点结束巡回 (End patrol at terminus?)
REGISTER_DBG_GOAL_PARAM(GOAL_COMMON_RouteMove, 3, "到達判定距離", 0)                      -- 到达判定距离 (Arrival determination distance)
REGISTER_DBG_GOAL_PARAM(GOAL_COMMON_RouteMove, 4, "歩くか？", 0)                          -- 是否步行 (Walk or run?)
REGISTER_DBG_GOAL_PARAM(GOAL_COMMON_RouteMove, 5, "検索範囲", 0)                          -- 搜索范围 (Search range)

-- 设置为不可中断目标，确保巡回路径的完整执行
REGISTER_GOAL_NO_INTERUPT(GOAL_COMMON_RouteMove, true)

--[[============================================================================
    路径巡回移动激活函数 (Route Movement Activation Function)

    功能说明 (Function Description):
    - 初始化路径巡回移动系统
    - 设置路径信息和起始点
    - 创建初始移动子目标确保连续移动

    参数映射 (Parameter Mapping):
    - f1_arg0: AI实体对象 (AI entity object)
    - f1_arg1: 目标参数对象 (Goal parameter object)

    执行流程 (Execution Flow):
    1. 获取所有路径相关参数
    2. 通过实体ID绑定路径信息
    3. 根据起点模式设置当前移动点索引
    4. 添加两个移动子目标实现缓冲机制

    技术细节 (Technical Details):
    - SetRouteInfoByEntityId: 绑定路径实体
    - CalcNearMovePointOnRoute: 计算最近路径点
    - 双目标缓冲: 确保移动的连续性
    - 使用MoveToSomewhereSmooth: 平滑移动算法
============================================================================]]
function RouteMove_Activate(f1_arg0, f1_arg1)
    -- === 参数获取阶段 (Parameter Acquisition Phase) ===
    local f1_local0 = f1_arg1:GetLife()         -- 目标生命周期 (Goal lifecycle)
    local f1_local1 = f1_arg1:GetParam(0)       -- 路径实体ID (Route entity ID)
    local f1_local2 = f1_arg1:GetParam(1)       -- 从起点开始标志 (Start from beginning flag)
    local f1_local3 = f1_arg1:GetParam(3)       -- 到达判定距离 (Arrival determination distance)
    local f1_local4 = f1_arg1:GetParam(4)       -- 步行模式标志 (Walk mode flag)
    local f1_local5 = f1_arg1:GetParam(5)       -- 路径点搜索范围 (Path point search range)

    -- === 路径信息设置阶段 (Path Information Setup Phase) ===
    -- 通过实体ID设置AI的路径信息
    f1_arg0:SetRouteInfoByEntityId(f1_local1)

    -- === 起始点确定阶段 (Starting Point Determination Phase) ===
    if f1_local2 <= 0 then
        -- 不从起点开始，计算最近的路径移动点
        -- CalcNearMovePointOnRoute: 计算从自身位置出发，在搜索范围内最近的路径点
        local f1_local6 = f1_arg0:CalcNearMovePointOnRoute(TARGET_SELF, AI_DIR_TYPE_CENTER, 0, f1_local5)
        -- 设置当前移动点索引为计算出的最近点
        f1_arg0:SetCurrentMovePointIndex(f1_local6)
    end
    -- 如果f1_local2 > 0，则从路径起点开始（默认行为）

    -- === 移动子目标创建阶段 (Movement Sub-Goal Creation Phase) ===
    -- 添加第一个平滑移动子目标
    -- 参数：生命周期, 目标点类型, 移动方向, 到达距离, 朝向目标, 步行模式
    f1_arg1:AddSubGoal(GOAL_COMMON_MoveToSomewhereSmooth, f1_local0, POINT_MOVE_POINT, AI_DIR_TYPE_CENTER, f1_local3, TARGET_SELF, f1_local4)

    -- 添加第二个平滑移动子目标（缓冲机制）
    -- 双目标缓冲确保当第一个目标完成时，已有下一个目标在队列中
    -- 这避免了移动中断，实现连续流畅的路径巡回
    f1_arg1:AddSubGoal(GOAL_COMMON_MoveToSomewhereSmooth, f1_local0, POINT_MOVE_POINT, AI_DIR_TYPE_CENTER, f1_local3, TARGET_SELF, f1_local4)

end

--[[============================================================================
    路径巡回移动更新函数 (Route Movement Update Function)

    功能说明 (Function Description):
    - 监控路径巡回的执行状态
    - 维护移动子目标队列的连续性
    - 检测路径终点并决定是否结束巡回

    返回值 (Return Values):
    - GOAL_RESULT_Success: 到达路径终点且设置为结束
    - GOAL_RESULT_Continue: 继续路径巡回

    核心机制 (Core Mechanism):
    - 单目标缓冲维护：当队列中只剩1个目标时补充新目标
    - 路径终点检测：根据配置决定是否在终点结束
    - 持续移动：不断添加新的路径点目标保持连续移动

    设计理念 (Design Philosophy):
    - 预先补充目标避免移动中断
    - 灵活的终点处理策略
    - 无缝循环或结束机制
============================================================================]]
function RouteMove_Update(f2_arg0, f2_arg1)
    -- === 目标队列维护检查 (Goal Queue Maintenance Check) ===
    -- 当子目标数量 <= 1 时，需要补充新的移动目标以保持连续性
    if f2_arg1:GetSubGoalNum() <= 1 then
        local f2_local0 = f2_arg1:GetLife()         -- 目标生命周期
        local f2_local1 = f2_arg1:GetParam(2)       -- 终点结束标志
        local f2_local2 = f2_arg1:GetParam(3)       -- 到达判定距离
        local f2_local3 = f2_arg1:GetParam(4)       -- 步行模式

        -- === 路径终点检测 (Path End Detection) ===
        -- 如果设置了在终点结束，并且当前已到达路径终点
        if f2_local1 > 0 and true == f2_arg0:IsRouteEnd() then
            return GOAL_RESULT_Success  -- 巡回完成，返回成功
        end

        -- === 补充移动目标 (Replenish Movement Goal) ===
        -- 添加新的移动点目标，系统会自动处理下一个路径点
        -- POINT_MOVE_POINT会自动指向路径上的下一个移动点
        f2_arg1:AddSubGoal(GOAL_COMMON_MoveToSomewhereSmooth, f2_local0, POINT_MOVE_POINT, AI_DIR_TYPE_CENTER, f2_local2, TARGET_SELF, f2_local3)
    end

    -- 继续执行路径巡回
    return GOAL_RESULT_Continue

end

--[[============================================================================
    路径巡回移动终止函数 (Route Movement Termination Function)

    功能说明 (Function Description):
    - 清理路径巡回相关资源
    - 重置路径状态

    当前实现 (Current Implementation):
    - 空实现，依赖系统自动清理
    - 路径信息会在目标结束时自动重置

    扩展建议 (Extension Suggestions):
    - 记录巡回统计数据（完成次数、总时长）
    - 清理路径点标记
    - 重置移动点索引
    - 触发巡回完成事件
============================================================================]]
function RouteMove_Terminate(f3_arg0, f3_arg1)
    -- 当前无需特殊终止处理
    -- 路径信息和移动状态会自动清理
end

--[[============================================================================
    路径巡回移动中断处理函数 (Route Movement Interrupt Handler Function)

    功能说明 (Function Description):
    - 控制路径巡回是否可被中断
    - 确保巡回路径的完整性

    返回值 (Return Value):
    - false: 不允许中断

    设计理念 (Design Philosophy):
    - 配合REGISTER_GOAL_NO_INTERUPT设置
    - 保护路径巡回的连续性
    - 避免中断导致的位置异常或路径状态混乱
    - 确保AI按预定路径完整执行

    重要性 (Importance):
    - 对于守卫、巡逻兵等角色，完整的巡回路径至关重要
    - 避免因临时事件打断而导致AI偏离岗位
    - 保持场景中AI行为的可预测性和稳定性
============================================================================]]
function RouteMove_Interupt(f4_arg0, f4_arg1)
    return false  -- 不允许中断路径巡回

end


