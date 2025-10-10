--[[
目标清除行为脚本
功能：清除AI记忆中的特定类型目标信息
使用场景：当AI需要忘记某个目标或重置注意力时使用
战术意图：允许AI放弃当前目标，转向其他行为或目标
系统集成：与AI的目标跟踪和记忆系统配合工作
--]]

-- 注册调试参数：清除目标类型（クリア対象ターゲット = Clear Target Type）
REGISTER_DBG_GOAL_PARAM(GOAL_COMMON_ClearTarget, 0, "クリア対象ターゲット", 0)

-- 注册目标更新时间：立即执行，无持续更新
REGISTER_GOAL_UPDATE_TIME(GOAL_COMMON_ClearTarget, 0, 0)

-- 注册为不可中断目标，确保清除操作的完整性
REGISTER_GOAL_NO_INTERUPT(GOAL_COMMON_ClearTarget, true)

--[[
目标清除行为激活函数
功能：根据指定的目标类型清除对应的目标信息
参数：f1_arg1:GetParam(0) 指定要清除的目标类型
目标类型：
- NORMAL_ENEMY：普通敌人目标
- SOUND：声音目标
- MEMORY_ENEMY：记忆中的敌人位置
- INDICATION_POS：指示位置目标
- CORPSE_POS：尸体位置目标
--]]
function ClearTarget_Activate(f1_arg0, f1_arg1)
    -- 获取要清除的目标类型参数
    local f1_local0 = f1_arg1:GetParam(0)

    -- 根据目标类型执行相应的清除操作
    if f1_local0 == AI_TARGET_TYPE__NORMAL_ENEMY then
        -- 清除当前追踪的敌人目标
        -- 使AI失去对当前敌人的锁定，可转向其他目标或行为
        f1_arg0:ClearEnemyTarget()

    elseif f1_local0 == AI_TARGET_TYPE__SOUND then
        -- 清除声音目标
        -- 使AI忘记之前听到的声音源位置，停止调查声音
        f1_arg0:ClearSoundTarget()

    elseif f1_local0 == AI_TARGET_TYPE__MEMORY_ENEMY then
        -- 清除记忆中的敌人最后位置
        -- 使AI忘记敌人消失前的最后已知位置，停止搜索
        f1_arg0:ClearLastMemoryTargetPos()

    elseif f1_local0 == AI_TARGET_TYPE__INDICATION_POS then
        -- 清除指示位置目标
        -- 使AI忘记被指示要前往的特定位置
        f1_arg0:ClearIndicationPosTarget()

    elseif f1_local0 == AI_TARGET_TYPE__CORPSE_POS then
        -- 清除尸体位置目标
        -- 使AI忘记发现的尸体位置，停止相关的调查行为
        f1_arg0:ClearCorpsePosTarget()
    end

    -- 添加短暂的等待子目标，确保清除操作完全生效
    -- 0.1秒的等待时间足以让AI系统处理目标清除
    f1_arg1:AddSubGoal(GOAL_COMMON_Wait, 0.1, TARGET_SELF, 0, 0, 0)

end

--[[
目标清除行为更新函数
功能：立即完成目标清除操作
返回值：Success表示清除操作已完成
实现：由于清除操作是瞬时的，无需持续更新，直接返回成功
设计理念：目标清除应该是原子操作，一次性完成
--]]
function ClearTarget_Update(f2_arg0, f2_arg1, f2_arg2)
    -- 直接返回成功，因为清除操作在Activate阶段已完成
    -- 无需持续监控或等待，清除是瞬时生效的
    return GOAL_RESULT_Success

end

--[[
目标清除行为终止函数
功能：清理目标清除行为的相关状态
实现：当前为空实现，因为清除操作无需额外清理
说明：目标清除是无状态操作，终止时无需特殊处理
--]]
function ClearTarget_Terminate(f3_arg0, f3_arg1)
    -- 空实现：目标清除操作无需特殊的终止处理
    -- 清除操作已在Activate阶段完成，无残留状态需要清理

end

--[[
目标清除行为中断检查函数
功能：检查是否允许中断目标清除操作
返回值：false表示不允许中断，确保清除操作的原子性
设计理念：目标清除是关键操作，不应被中断以避免AI状态不一致
系统稳定性：防止部分清除导致的AI行为异常
--]]
function ClearTarget_Interupt(f4_arg0, f4_arg1)
    -- 始终返回false，不允许中断目标清除过程
    -- 确保清除操作的完整性和AI系统状态的一致性
    return false

end


