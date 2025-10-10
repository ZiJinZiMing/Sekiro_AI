--[[
刺击反击攻击AI脚本 - GOAL_COMMON_StabCounterAttack
用途：执行针对刺击攻击的反击，特别适用于对抗玩家的刺击动作
特点：可以反击刺击并具有特殊的取消机制

应用场景：
- 当敌人执行刺击攻击时的反击
- 破解玩家刺击战术的专门攻击
- 具有特殊时机的反击动作

与其他攻击类型的区别：
- 普通攻击：常规的攻击行为
- 持续攻击：具有霸体的不可中断攻击
- 刺击反击：专门针对刺击的反击，有特殊的取消条件

调试参数说明：
参数0: EzStateID - 反击动作的状态ID
参数1: 攻击对象 - 目标敌人的索引或类型
参数2: 成功距离 - 反击判定的有效距离
参数3: 攻击前旋回时间 - 反击前的转身调整时间
参数4: 正面判定角度 - 判定为正面反击的角度范围
参数5: 上攻击角度 - 向上反击的角度限制
参数6: 下攻击角度 - 向下反击的角度限制
--]]
REGISTER_DBG_GOAL_PARAM(GOAL_COMMON_StabCounterAttack, 0, "EzStateID", 0)
REGISTER_DBG_GOAL_PARAM(GOAL_COMMON_StabCounterAttack, 1, "攻撃対象", 0)
REGISTER_DBG_GOAL_PARAM(GOAL_COMMON_StabCounterAttack, 2, "成功距離", 0)
REGISTER_DBG_GOAL_PARAM(GOAL_COMMON_StabCounterAttack, 3, "攻撃前旋回時間", 0)
REGISTER_DBG_GOAL_PARAM(GOAL_COMMON_StabCounterAttack, 4, "正面判定角度", 0)
REGISTER_DBG_GOAL_PARAM(GOAL_COMMON_StabCounterAttack, 5, "上攻撃角度", 0)
REGISTER_DBG_GOAL_PARAM(GOAL_COMMON_StabCounterAttack, 6, "下攻撃角度", 0)

--[[
刺击反击攻击激活函数
功能：初始化刺击反击攻击行为，设置特殊的反击参数
参数：f1_arg0 - AI实体对象, f1_arg1 - 目标参数对象
特点：启用刺击反击取消机制，允许在特定条件下取消反击
--]]
function StabCounterAttack_Activate(f1_arg0, f1_arg1)
    -- 获取目标的生命值，用于持续时间计算
    local f1_local0 = f1_arg1:GetLife()

    -- 获取反击相关参数
    local f1_local1 = f1_arg1:GetParam(0)  -- 反击动作ID
    local f1_local2 = f1_arg1:GetParam(1)  -- 攻击目标
    local f1_local3 = f1_arg1:GetParam(2)  -- 成功距离

    -- 设置旋转角度限制为180度（半圆范围）
    local f1_local4 = 180

    -- 获取时间和角度参数
    local f1_local5 = f1_arg1:GetParam(3)  -- 反击前旋回时间
    local f1_local6 = f1_arg1:GetParam(4)  -- 正面判定角度

    -- 设置默认值（如果参数无效）
    if f1_local5 < 0 then
        f1_local5 = 1.5  -- 默认旋回时间1.5秒
    end
    if f1_local6 < 0 then
        f1_local6 = 20   -- 默认正面角度20度
    end

    -- 设置反击行为标志
    local f1_local7 = true   -- 启用刺击反击标志
    local f1_local8 = false  -- 禁用某些中断条件
    local f1_local9 = true   -- 启用反击追踪
    local f1_local10 = false -- 禁用其他行为
    local f1_local11 = false -- 禁用额外检查

    -- 获取垂直攻击角度参数
    local f1_local12 = f1_arg1:GetParam(5)  -- 上攻击角度
    local f1_local13 = f1_arg1:GetParam(6)  -- 下攻击角度

    -- 添加通用攻击子目标，配置为反击模式
    f1_arg1:AddSubGoal(GOAL_COMMON_CommonAttack, f1_local0, f1_local1, f1_local2, f1_local3, f1_local4, f1_local5, f1_local6, f1_local8, f1_local9, f1_local10, f1_local11, f1_local12, f1_local13, f1_local7)

    -- 启用刺击反击取消机制
    -- 这是刺击反击攻击的特殊功能，允许在特定条件下取消反击
    -- 例如：当检测到敌人没有执行刺击时可以取消反击
    f1_arg0:SetEnableStabCounterCancel_forGoal()

end

--[[
刺击反击攻击更新函数
功能：每帧更新反击状态
返回：GOAL_RESULT_Continue - 持续执行反击
说明：刺击反击通常需要持续到完成，但可能被特殊取消机制中断
--]]
function StabCounterAttack_Update(f2_arg0, f2_arg1)
    -- 返回继续执行状态
    -- 刺击反击攻击会持续执行，直到完成或被特殊机制取消
    return GOAL_RESULT_Continue

end

--[[
刺击反击攻击终止函数
功能：反击结束时清理刺击反击取消状态
参数：f3_arg0 - AI实体对象, f3_arg1 - 目标参数对象
重要性：必须清理特殊状态，避免影响后续AI行为
--]]
function StabCounterAttack_Terminate(f3_arg0, f3_arg1)
    -- 清除刺击反击取消机制
    -- 这确保AI在反击结束后恢复正常状态
    f3_arg0:ClearEnableStabCounterCancel_forGoal()

end

-- 注册刺击反击攻击为不可中断目标
-- 虽然有特殊的取消机制，但仍然保护其不被普通中断打断
REGISTER_GOAL_NO_INTERUPT(GOAL_COMMON_StabCounterAttack, true)

--[[
刺击反击攻击中断检查函数
功能：检查是否允许中断当前的反击
返回：false - 不允许普通中断
说明：刺击反击有自己的特殊取消机制，不允许普通中断
特殊性：虽然有取消机制，但该机制是通过特殊系统实现的，不是普通中断
--]]
function StabCounterAttack_Interupt(f4_arg0, f4_arg1)
    -- 刺击反击攻击不允许被普通方式中断
    -- 只能通过特殊的刺击反击取消机制来中断
    -- 这保证了反击的完整性和专门性
    return false

end


