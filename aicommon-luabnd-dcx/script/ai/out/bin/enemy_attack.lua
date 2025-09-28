-- ■ 敌人攻击系统 - AI高级攻击行为模块
-- 描述：定义敌人AI的各种攻击模式，包括可调节攻击、连击攻击和终结技
-- 功能：提供灵活的攻击参数配置和角度控制机制
-- 用途：用于实现复杂的战斗攻击模式和连击系统

-- ==================== 敌人可调节攻击目标 ====================
RegisterTableGoal(GOAL_EnemyTunableAttack, "GOAL_EnemyTunableAttack")
ENABLE_COMBO_ATK_CANCEL(GOAL_EnemyTunableAttack)    -- 启用连击取消功能
REGISTER_GOAL_NO_SUB_GOAL(GOAL_EnemyTunableAttack, true)  -- 注册为无子目标类型

-- ■ 可调节攻击激活函数
-- 描述：执行具有可调节参数的攻击，支持角度和距离精确控制
-- 参数：f1_arg0 - AI实体, f1_arg1 - AI对象, f1_arg2 - 目标参数
-- 功能：根据AI攻击参数执行旋转攻击，具有完整的角度控制
Goal.Activate = function (f1_arg0, f1_arg1, f1_arg2)
    local f1_local0 = f1_arg2:GetParam(0)  -- 获取目标类型参数
    local f1_local1 = f1_arg2:GetParam(1)  -- 获取攻击ID参数
    -- 添加可调节旋转攻击子目标，包含完整的AI攻击参数配置
    f1_arg2:AddSubGoal(GOAL_COMMON_AttackTunableSpin, f1_arg2:GetLife(), f1_local1, f1_local0,
        f1_arg1:GetAIAttackParam(f1_local1, AI_ATTACK_PARAM_TYPE__SUCCESS_DISTANCE),    -- 成功距离
        f1_arg1:GetAIAttackParam(f1_local1, AI_ATTACK_PARAM_TYPE__TURN_TIME_BEFORE_ATTACK), -- 攻击前转向时间
        f1_arg1:GetAIAttackParam(f1_local1, AI_ATTACK_PARAM_TYPE__FRONT_ANGLE_RANGE),   -- 正面角度范围
        f1_arg1:GetAIAttackParam(f1_local1, AI_ATTACK_PARAM_TYPE__UP_ANGLE_THRESHOLD),  -- 上角度阈值
        f1_arg1:GetAIAttackParam(f1_local1, AI_ATTACK_PARAM_TYPE__DOWN_ANGLE_THRESHOLD)) -- 下角度阈值

end

-- ==================== 敌人可调节连击攻击目标 ====================
RegisterTableGoal(GOAL_EnemyTunableComboAttack, "GOAL_EnemyTunableComboAttack")
ENABLE_COMBO_ATK_CANCEL(GOAL_EnemyTunableComboAttack)  -- 启用连击取消功能
REGISTER_GOAL_NO_SUB_GOAL(GOAL_EnemyTunableComboAttack, true)  -- 注册为无子目标类型

-- ■ 可调节连击攻击激活函数
-- 描述：执行具有180度成功角度的可调节连击攻击
-- 参数：f2_arg0 - AI实体, f2_arg1 - AI对象, f2_arg2 - 目标参数
-- 功能：实现具有宽角度容错的连击攻击模式
Goal.Activate = function (f2_arg0, f2_arg1, f2_arg2)
    local f2_local0 = f2_arg2:GetParam(0)  -- 获取目标类型参数
    local f2_local1 = f2_arg2:GetParam(1)  -- 获取攻击ID参数
    -- 添加180度成功角度的可调节连击攻击子目标
    f2_arg2:AddSubGoal(GOAL_COMMON_ComboTunable_SuccessAngle180, f2_arg2:GetLife(), f2_local1, f2_local0,
        f2_arg1:GetAIAttackParam(f2_local1, AI_ATTACK_PARAM_TYPE__SUCCESS_DISTANCE),    -- 成功距离
        f2_arg1:GetAIAttackParam(f2_local1, AI_ATTACK_PARAM_TYPE__TURN_TIME_BEFORE_ATTACK), -- 攻击前转向时间
        f2_arg1:GetAIAttackParam(f2_local1, AI_ATTACK_PARAM_TYPE__FRONT_ANGLE_RANGE),   -- 正面角度范围
        f2_arg1:GetAIAttackParam(f2_local1, AI_ATTACK_PARAM_TYPE__UP_ANGLE_THRESHOLD),  -- 上角度阈值
        f2_arg1:GetAIAttackParam(f2_local1, AI_ATTACK_PARAM_TYPE__DOWN_ANGLE_THRESHOLD), -- 下角度阈值
        f2_arg1:GetAIAttackParam(f2_local1, AI_ATTACK_PARAM_TYPE__FRONT_ANGLE_RANGE))   -- 重复正面角度范围

end

-- ==================== 敌人连击重复攻击目标 ====================
RegisterTableGoal(GOAL_EnemyComboRepeat, "GOAL_EnemyComboRepeat")
ENABLE_COMBO_ATK_CANCEL(GOAL_EnemyComboRepeat)  -- 启用连击取消功能
REGISTER_GOAL_NO_SUB_GOAL(GOAL_EnemyComboRepeat, true)  -- 注册为无子目标类型

-- ■ 连击重复攻击激活函数
-- 描述：执行可重复的连击攻击模式，具有180度成功角度
-- 参数：f3_arg0 - AI实体, f3_arg1 - AI对象, f3_arg2 - 目标参数
-- 功能：实现连续重复的攻击序列，适用于持续压制
Goal.Activate = function (f3_arg0, f3_arg1, f3_arg2)
    local f3_local0 = f3_arg2:GetParam(0)  -- 获取目标类型参数
    local f3_local1 = f3_arg2:GetParam(1)  -- 获取攻击ID参数
    -- 添加180度成功角度的连击重复攻击子目标
    f3_arg2:AddSubGoal(GOAL_COMMON_ComboRepeat_SuccessAngle180, f3_arg2:GetLife(), f3_local1, f3_local0,
        f3_arg1:GetAIAttackParam(f3_local1, AI_ATTACK_PARAM_TYPE__SUCCESS_DISTANCE),  -- 成功距离
        f3_arg1:GetAIAttackParam(f3_local1, AI_ATTACK_PARAM_TYPE__UP_ANGLE_THRESHOLD),   -- 上角度阈值
        f3_arg1:GetAIAttackParam(f3_local1, AI_ATTACK_PARAM_TYPE__DOWN_ANGLE_THRESHOLD)) -- 下角度阈值

end

-- ==================== 敌人连击终结技目标 ====================
RegisterTableGoal(GOAL_EnemyComboFinal, "GOAL_EnemyComboFinal")
REGISTER_GOAL_NO_SUB_GOAL(GOAL_EnemyComboFinal, true)  -- 注册为无子目标类型

-- ■ 连击终结技激活函数
-- 描述：执行连击序列的终结攻击，通常具有更高伤害或特殊效果
-- 参数：f4_arg0 - AI实体, f4_arg1 - AI对象, f4_arg2 - 目标参数
-- 功能：完成连击序列，执行最终的强力攻击
Goal.Activate = function (f4_arg0, f4_arg1, f4_arg2)
    local f4_local0 = f4_arg2:GetParam(0)  -- 获取目标类型参数
    local f4_local1 = f4_arg2:GetParam(1)  -- 获取攻击ID参数
    -- 添加连击终结技子目标
    f4_arg2:AddSubGoal(GOAL_COMMON_ComboFinal, f4_arg2:GetLife(), f4_local1, f4_local0,
        f4_arg1:GetAIAttackParam(f4_local1, AI_ATTACK_PARAM_TYPE__SUCCESS_DISTANCE),  -- 成功距离
        f4_arg1:GetAIAttackParam(f4_local1, AI_ATTACK_PARAM_TYPE__UP_ANGLE_THRESHOLD),   -- 上角度阈值
        f4_arg1:GetAIAttackParam(f4_local1, AI_ATTACK_PARAM_TYPE__DOWN_ANGLE_THRESHOLD)) -- 下角度阈值

end


