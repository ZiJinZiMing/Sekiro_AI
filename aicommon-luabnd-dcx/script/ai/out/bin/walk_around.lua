--[[
walk_around.lua - 区域巡游行为模块
==================================

【功能描述】
实现AI在指定区域内的智能巡游行为。AI会在家园位置和自由位置之间选择目标点，
进行自然的巡逻移动，并在发现敌人时及时响应，适用于哨兵、守卫等角色的日常行为。

【核心机制】
- 双模式巡游：支持固定家园位置和自由移动位置
- 智能路径选择：根据当前距离动态选择移动策略
- 敌人感知：实时监测敌人距离，触发战斗响应
- 随机等待：增加行为的自然性和不可预测性

【应用场景】
- 守卫的日常巡逻路线
- 哨兵的区域监控行为
- NPC的自然生活模式
- 和平状态下的漫游活动

【参数配置】
- 参数0：移动圆形半径，控制移动范围
- 参数1：是否步行，影响移动速度
- 参数2：敌人反应距离，控制战斗触发范围
- 参数3：自由移动模式开关
--]]

-- 调试参数注册：移动圆形半径
REGISTER_DBG_GOAL_PARAM(GOAL_COMMON_WalkAround, 0, "移動する円の半径", 0)
-- 调试参数注册：步行模式开关
REGISTER_DBG_GOAL_PARAM(GOAL_COMMON_WalkAround, 1, "歩くか", 0)
-- 调试参数注册：敌人反应距离
REGISTER_DBG_GOAL_PARAM(GOAL_COMMON_WalkAround, 2, "敵に反応する距離", 0)

function WalkAround_Activate(f1_arg0, f1_arg1)
    --[[
    【激活函数】- 初始化巡游行为

    参数：
    - f1_arg0: AI实体对象
    - f1_arg1: 目标控制器

    功能：
    - 解析移动参数和模式设置
    - 选择合适的巡游目标点
    - 根据距离制定移动策略

    算法流程：
    1. 获取移动半径、步行模式、反应距离等参数
    2. 根据自由移动标志选择目标点类型
    3. 计算到目标点的距离
    4. 距离>=2米：执行移动+随机等待
    5. 距离<2米：短暂等待后重新规划

    技术细节：
    - 使用30秒作为最大移动时间限制
    - 随机等待3-6秒增加行为自然性
    - 支持固定家园和自由移动两种模式
    --]]
    -- 获取移动圆形半径参数
    local f1_local0 = f1_arg1:GetParam(0)
    -- 获取步行模式参数
    local f1_local1 = f1_arg1:GetParam(1)
    -- 获取敌人反应距离参数
    local f1_local2 = f1_arg1:GetParam(2)
    -- 解析自由移动模式标志（参数3不为0即为自由模式）
    local f1_local3 = not (f1_arg1:GetParam(3) == 0)
    -- 设置移动超时时间（30秒）
    local f1_local4 = 30
    -- 默认使用家园位置作为目标点
    local f1_local5 = POINT_WalkAroundPosition_Home

    -- 根据自由移动模式选择目标点类型
    if f1_local3 then
        f1_local5 = POINT_WalkAroundPosition_Free
    end

    -- 根据移动模式更新巡游位置
    if f1_local3 then
        -- 自由模式：改变自由巡游点
        f1_arg0:ChangeWalkAroundFreePoint()
    else
        -- 固定模式：决定固定巡游位置
        f1_arg0:DecideWalkAroundPos()
    end

    -- 计算到目标巡游点的距离
    local f1_local6 = f1_arg0:GetDist(f1_local5)

    -- 根据距离制定移动策略
    if f1_local6 >= 2 then
        -- 距离较远：执行正常移动
        -- 参数：超时时间, 目标点, 朝向类型, 半径, 目标类型, 步行模式
        f1_arg1:AddSubGoal(GOAL_COMMON_MoveToSomewhere, f1_local4, f1_local5, AI_DIR_TYPE_CENTER, f1_local0, TARGET_SELF, f1_local1)
        -- 到达后随机等待3-6秒，增加行为自然性
        f1_arg1:AddSubGoal(GOAL_COMMON_Wait, f1_arg0:GetRandam_Int(3, 6), TARGET_NONE, 0, 0, 0)
    else
        -- 距离很近：短暂等待后重新规划
        f1_arg1:AddSubGoal(GOAL_COMMON_Wait, 0.1, TARGET_NONE, 0, 0, 0)
    end

end

function WalkAround_Update(f2_arg0, f2_arg1)
    --[[
    【更新函数】- 监控巡游状态和敌人感知

    参数：
    - f2_arg0: AI实体对象
    - f2_arg1: 目标控制器

    返回值：
    - GOAL_RESULT_Failed: 发现敌人，巡游失败转入战斗
    - GOAL_RESULT_Continue: 继续巡游状态

    功能：
    - 实时监测敌人位置和距离
    - 根据反应距离判断是否进入战斗状态
    - 提供从和平巡游到战斗状态的无缝转换

    算法逻辑：
    1. 获取敌人反应距离参数
    2. 检查是否发现敌人目标
    3. 计算与敌人的距离
    4. 距离小于反应距离：返回失败，触发战斗
    5. 其他情况：继续巡游

    性能优化：
    - 只在发现敌人时才进行距离计算
    - 使用高效的目标搜索和距离检测
    --]]
    -- 获取敌人反应距离参数
    local f2_local0 = f2_arg1:GetParam(2)

    -- 检查是否发现敌人且距离过近
    if f2_arg0:IsSearchTarget(TARGET_ENE_0) == true and f2_arg0:GetDist(TARGET_ENE_0) < f2_local0 then
        -- 敌人进入反应范围，巡游失败，准备进入战斗状态
        return GOAL_RESULT_Failed
    end

    -- 继续巡游状态
    return GOAL_RESULT_Continue

end

function WalkAround_Terminate(f3_arg0, f3_arg1)
    --[[
    【终止函数】- 清理巡游行为

    功能：
    - 当前实现为空，依赖子目标自动清理
    - 预留扩展接口

    扩展建议：
    - 记录巡游统计数据（巡游时间、路径长度）
    - 重置巡游相关的内部状态
    - 清理临时路径点标记
    - 触发巡游结束事件通知
    --]]

end

function WalkAround_Interupt(f4_arg0, f4_arg1)
    --[[
    【中断处理函数】- 控制巡游中断行为

    返回值：
    - false: 不允许中断

    设计理念：
    - 保护巡游行为的连续性和完整性
    - 避免频繁中断导致的移动混乱
    - 确保AI行为的稳定性和可预测性

    适用场景：
    - 守卫巡逻需要按既定路线完成
    - 避免因小幅干扰打断正常巡游
    - 维持NPC行为的自然流畅性

    注意事项：
    - 可能影响对紧急情况的快速响应
    - Update函数中的敌人检测提供了主要的状态切换机制
    - 考虑为高优先级事件添加例外处理
    --]]
    return false

end


