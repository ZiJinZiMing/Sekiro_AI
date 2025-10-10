--[[
敌人连锁攻击系统
功能：实现敌人的连续攻击链，支持多段攻击组合
使用场景：强敌的连击技能、BOSS战中的复杂攻击模式
战术意图：通过连续攻击增加伤害输出，形成攻击压制
系统特点：使用Table目标系统，支持灵活的连击取消和控制
--]]

-- 注册为表格目标，支持复杂的连击状态管理
RegisterTableGoal(GOAL_EnemyChainAttack, "GOAL_EnemyChainAttack")

-- 启用连击攻击取消机制，允许在特定条件下中断连击
ENABLE_COMBO_ATK_CANCEL(GOAL_EnemyChainAttack)

-- 注册为允许子目标的类型，支持复杂的攻击行为组合
REGISTER_GOAL_NO_SUB_GOAL(GOAL_EnemyChainAttack, true)

-- 调试参数注册
REGISTER_DBG_GOAL_PARAM(GOAL_EnemyChainAttack, 0, "対象", 0)        -- 攻击目标类型
REGISTER_DBG_GOAL_PARAM(GOAL_EnemyChainAttack, 1, "コンボ確率", 0)  -- 连击概率（%）
REGISTER_DBG_GOAL_PARAM(GOAL_EnemyChainAttack, 2, "攻撃1", 0)      -- 第1段攻击动作ID
REGISTER_DBG_GOAL_PARAM(GOAL_EnemyChainAttack, 3, "攻撃2", 0)      -- 第2段攻击动作ID
REGISTER_DBG_GOAL_PARAM(GOAL_EnemyChainAttack, 4, "攻撃3", 0)      -- 第3段攻击动作ID
REGISTER_DBG_GOAL_PARAM(GOAL_EnemyChainAttack, 5, "攻撃4", 0)      -- 第4段攻击动作ID
REGISTER_DBG_GOAL_PARAM(GOAL_EnemyChainAttack, 6, "攻撃5", 0)      -- 第5段攻击动作ID
REGISTER_DBG_GOAL_PARAM(GOAL_EnemyChainAttack, 7, "攻撃6", 0)      -- 第6段攻击动作ID

--[[
敌人连锁攻击激活函数
功能：初始化连锁攻击序列，设置所有攻击段和连击概率
参数获取：
- f1_local0: 攻击目标类型
- f1_local1: 连击概率，控制每一段攻击的执行概率
- f1_local2-7: 6个攻击动作ID，组成完整的连锁攻击序列
实现机制：
- 使用GOAL_EnemyHandyAttack作为子目标来执行连击
- 所有连击段都使用相同的概率值，确保一致性
--]]
Goal.Activate = function (f1_arg0, f1_arg1, f1_arg2)
    -- 获取攻击目标类型
    local f1_local0 = f1_arg2:GetParam(0)

    -- 获取连击概率，用于控制每段攻击的执行概率
    local f1_local1 = f1_arg2:GetParam(1)

    -- 获取6段攻击动作ID，构成完整的连锁攻击序列
    local f1_local2 = f1_arg2:GetParam(2)  -- 第1段攻击
    local f1_local3 = f1_arg2:GetParam(3)  -- 第2段攻击
    local f1_local4 = f1_arg2:GetParam(4)  -- 第3段攻击
    local f1_local5 = f1_arg2:GetParam(5)  -- 第4段攻击
    local f1_local6 = f1_arg2:GetParam(6)  -- 第5段攻击
    local f1_local7 = f1_arg2:GetParam(7)  -- 第6段攻击

    -- 启动敌人便利攻击子目标，执行连锁攻击序列
    -- 参数说明：生命周期、目标、攻击类型(1)、6段攻击ID、所有段都使用相同连击概率
    f1_arg2:AddSubGoal(GOAL_EnemyHandyAttack, f1_arg2:GetLife(), f1_local0, 1, f1_local2, f1_local3, f1_local4, f1_local5, f1_local6, f1_local7, f1_local1, f1_local1, f1_local1, f1_local1, f1_local1)

end

--[[
敌人连锁攻击更新函数
功能：监控连锁攻击的执行状态，判断攻击序列是否完成
返回值：
- GOAL_RESULT_Success: 当所有子目标完成，连锁攻击结束
- GOAL_RESULT_Continue: 连锁攻击仍在进行中
逻辑：
- 检查子目标数量来判断连击是否完成
- 连击过程完全由GOAL_EnemyHandyAttack子目标管理
--]]
Goal.Update = function (f2_arg0, f2_arg1, f2_arg2)
    -- 检查是否还有子目标在执行
    if f2_arg2:GetSubGoalNum() <= 0 then
        -- 所有攻击段都已完成，连锁攻击成功结束
        return GOAL_RESULT_Success
    end

    -- 连锁攻击仍在进行中，继续执行
    return GOAL_RESULT_Continue

end


