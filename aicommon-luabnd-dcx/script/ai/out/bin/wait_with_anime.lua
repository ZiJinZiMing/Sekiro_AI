--[[
wait_with_anime.lua - 动画等待行为模块
=====================================

【功能描述】
提供带有特定动画播放的等待行为。AI在执行等待期间会播放指定的动画，
并可选择性地面向特定目标，常用于展示特殊姿态或执行仪式性动作。

【核心机制】
- 动画播放：执行指定ID的动画序列
- 目标朝向：可配置面向特定目标或保持当前朝向
- 持续执行：等待行为会持续到目标生命周期结束
- 中断保护：默认不允许中断，确保动画完整播放

【应用场景】
- Boss战前的威吓动作
- 守卫的巡逻站岗姿态
- 仪式性或展示性动作
- 特殊状态下的等待行为

【参数配置】
- 参数0：动画ID，指定要播放的动画
- 参数1：旋回目标，控制朝向行为
--]]

-- 调试参数注册：动画ID参数
REGISTER_DBG_GOAL_PARAM(GOAL_COMMON_WaitWithAnime, 0, "アニメID", 0)
-- 调试参数注册：旋回目标参数
REGISTER_DBG_GOAL_PARAM(GOAL_COMMON_WaitWithAnime, 1, "旋回対象", 1)

function WaitWithAnime_Activate(f1_arg0, f1_arg1)
    --[[
    【激活函数】- 初始化动画等待行为

    参数：
    - f1_arg0: AI实体对象
    - f1_arg1: 目标控制器

    功能：
    - 获取动画ID和朝向目标参数
    - 启动不可取消的攻击动作来播放动画
    - 设置持续时间为目标生命周期

    技术细节：
    - 使用GOAL_COMMON_AttackNonCancel确保动画不被打断
    - 距离参数设为9999，表示不考虑距离限制
    - 方向参数设为-1，表示使用默认朝向逻辑
    --]]
    -- 获取动画ID参数
    local f1_local0 = f1_arg1:GetParam(0)
    -- 获取旋回目标参数
    local f1_local1 = f1_arg1:GetParam(1)

    -- 添加不可取消的攻击子目标来播放动画
    -- 参数说明：生命周期, 动画ID, 目标, 距离(9999=无限制), 0, 方向(-1=默认)
    f1_arg1:AddSubGoal(GOAL_COMMON_AttackNonCancel, f1_arg1:GetLife(), f1_local0, f1_local1, 9999, 0, -1)

end

function WaitWithAnime_Update(f2_arg0, f2_arg1)
    --[[
    【更新函数】- 维持等待状态

    返回值：
    - GOAL_RESULT_Continue: 持续等待状态

    设计思路：
    - 简单返回Continue状态，让子目标处理实际逻辑
    - 等待行为由添加的AttackNonCancel子目标管理
    - 确保动画播放的连续性和稳定性

    性能考虑：
    - 极简实现，无额外计算开销
    - 状态管理委托给子目标系统
    --]]
    return GOAL_RESULT_Continue

end

function WaitWithAnime_Terminate(f3_arg0, f3_arg1)
    --[[
    【终止函数】- 清理和重置

    功能：
    - 当前实现为空，子目标会自动清理
    - 预留扩展空间用于特殊清理逻辑

    扩展建议：
    - 记录动画播放统计信息
    - 重置特殊状态标志
    - 触发动画结束事件通知
    --]]

end

function WaitWithAnime_Interupt(f4_arg0, f4_arg1)
    --[[
    【中断处理函数】- 控制中断行为

    返回值：
    - false: 不允许中断

    设计理念：
    - 保护动画的完整性，不允许外部中断
    - 确保重要动作（如Boss威吓）能够完整展示
    - 维持视觉效果的连贯性

    使用场景：
    - 重要的剧情动画不应被打断
    - 仪式性动作需要完整执行
    - 特殊状态指示动画的保护

    注意事项：
    - 谨慎使用，可能导致AI响应性降低
    - 考虑添加紧急情况的例外处理
    - 平衡动画完整性与游戏流畅性
    --]]
    return false

end


