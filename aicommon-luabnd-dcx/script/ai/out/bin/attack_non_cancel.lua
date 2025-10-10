--[[
不可取消攻击AI脚本 - GOAL_COMMON_AttackNonCancel
用途：执行完全不可取消的攻击，一旦开始必须完整执行
特点：比持续攻击更严格，无法被任何方式中断或取消
应用：关键攻击动作、必杀技、重要战术动作等

与EndureAttack的区别：
- EndureAttack：具有霸体，可抵抗打击但仍可能被特殊情况中断
- AttackNonCancel：完全不可取消，任何情况下都要执行完毕

调试参数说明：
参数0: EzStateID - 攻击动作的状态ID
参数1: 攻击对象 - 目标敌人的索引或类型
参数2: 成功距离 - 攻击判定的有效距离
参数3: 攻击前旋回时间 - 攻击前的转身调整时间
参数4: 正面判定角度 - 判定为正面攻击的角度范围
参数5: 上攻击角度 - 向上攻击的角度限制
参数6: 下攻击角度 - 向下攻击的角度限制
--]]
REGISTER_DBG_GOAL_PARAM(GOAL_COMMON_AttackNonCancel, 0, "EzStateID", 0)
REGISTER_DBG_GOAL_PARAM(GOAL_COMMON_AttackNonCancel, 1, "攻撃対象", 0)
REGISTER_DBG_GOAL_PARAM(GOAL_COMMON_AttackNonCancel, 2, "成功距離", 0)
REGISTER_DBG_GOAL_PARAM(GOAL_COMMON_AttackNonCancel, 3, "攻撃前旋回時間", 0)
REGISTER_DBG_GOAL_PARAM(GOAL_COMMON_AttackNonCancel, 4, "正面判定角度", 0)
REGISTER_DBG_GOAL_PARAM(GOAL_COMMON_AttackNonCancel, 5, "上攻撃角度", 0)
REGISTER_DBG_GOAL_PARAM(GOAL_COMMON_AttackNonCancel, 6, "下攻撃角度", 0)

--[[
不可取消攻击激活函数
功能：初始化完全不可取消的攻击行为
参数：f1_arg0 - AI实体对象, f1_arg1 - 目标参数对象
特点：所有标志都设为false，确保攻击过程中不会有任何中断或取消机制
--]]
function AttackNonCancel_Activate(f1_arg0, f1_arg1)
    -- 获取目标的生命值，用于持续时间计算
    local f1_local0 = f1_arg1:GetLife()

    -- 获取攻击相关参数
    local f1_local1 = f1_arg1:GetParam(0)  -- 攻击动作ID
    local f1_local2 = f1_arg1:GetParam(1)  -- 攻击目标
    local f1_local3 = f1_arg1:GetParam(2)  -- 成功距离

    -- 设置旋转角度限制为180度（半圆范围）
    local f1_local4 = 180

    -- 获取时间和角度参数
    local f1_local5 = f1_arg1:GetParam(3)  -- 攻击前旋回时间
    local f1_local6 = f1_arg1:GetParam(4)  -- 正面判定角度

    -- 设置默认值（如果参数无效）
    if f1_local5 < 0 then
        f1_local5 = 1.5  -- 默认旋回时间1.5秒
    end
    if f1_local6 < 0 then
        f1_local6 = 20   -- 默认正面角度20度
    end

    -- 所有控制标志都设为false，确保完全不可取消
    local f1_local7 = false   -- 禁用灵活取消
    local f1_local8 = false   -- 禁用条件取消
    local f1_local9 = false   -- 禁用追踪取消
    local f1_local10 = false  -- 禁用其他取消条件

    -- 获取垂直攻击角度参数
    local f1_local11 = f1_arg1:GetParam(5)  -- 上攻击角度
    local f1_local12 = f1_arg1:GetParam(6)  -- 下攻击角度

    -- 禁用所有可能的取消机制
    local f1_local13 = false  -- 总取消标志也设为false

    -- 添加通用攻击子目标，所有取消相关参数都是false
    -- 这确保攻击一旦开始就必须完整执行到结束
    f1_arg1:AddSubGoal(GOAL_COMMON_CommonAttack, f1_local0, f1_local1, f1_local2, f1_local3, f1_local4, f1_local5, f1_local6, f1_local7, f1_local8, f1_local9, f1_local10, f1_local11, f1_local12, f1_local13)

    -- 注意：此函数不调用SetEnableEndureCancel，因为这是完全不可取消的攻击
    -- 它比EndureAttack更严格，不依赖霸体机制而是从逻辑上完全禁止取消

end

--[[
不可取消攻击更新函数
功能：每帧更新攻击状态，保持攻击的持续执行
返回：GOAL_RESULT_Continue - 无条件继续执行
说明：不可取消攻击不需要任何状态检查，直接持续执行到完成
--]]
function AttackNonCancel_Update(f2_arg0, f2_arg1)
    -- 无条件返回继续执行状态
    -- 不可取消攻击的核心就是无论发生什么都要继续
    return GOAL_RESULT_Continue

end

--[[
不可取消攻击终止函数
功能：攻击自然结束时的清理工作
参数：f3_arg0 - AI实体对象, f3_arg1 - 目标参数对象
说明：由于攻击不可取消，这里只在攻击完全结束时才会被调用
--]]
function AttackNonCancel_Terminate(f3_arg0, f3_arg1)
    -- 不可取消攻击结束时通常不需要特殊清理
    -- 因为攻击过程中没有设置任何特殊状态标志
    -- 所有状态都会在攻击动作完成后自然恢复

end

-- 注册不可取消攻击为不可中断目标
-- 这是系统级的保护，确保该攻击类型的绝对优先级
REGISTER_GOAL_NO_INTERUPT(GOAL_COMMON_AttackNonCancel, true)

--[[
不可取消攻击中断检查函数
功能：检查是否允许中断当前的攻击
返回：false - 绝对不允许中断
说明：这是不可取消攻击的核心保证，任何情况下都返回false
应用：当任何外部事件尝试中断攻击时，此函数会阻止中断
重要性：确保关键攻击动作的完整性，维护战斗逻辑的一致性
--]]
function AttackNonCancel_Interupt(f4_arg0, f4_arg1)
    -- 不可取消攻击在任何情况下都不允许被中断
    -- 这是比EndureAttack更严格的保证
    -- 无论是受到攻击、状态异常、AI切换等都不会中断
    return false

end


