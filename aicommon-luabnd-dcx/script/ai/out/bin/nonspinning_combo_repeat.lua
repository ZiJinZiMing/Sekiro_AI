--[[
非旋转连击重复攻击系统
功能：实现可重复执行的非旋转连击攻击，作为连击序列的中间环节
用途：用于连击组合中的可重复攻击阶段，可以多次循环执行
特点：组合了非旋转、连击和重复性，允许灵活的连击控制
与终结攻击的区别：启用连击取消机制，可以随时停止或转入下一阶段
与普通连击的区别：专门设计为可重复环节，适用于持续攻击模式
--]]

-- 参数0：EzState动画状态编号，指定重复攻击的动画
REGISTER_DBG_GOAL_PARAM(GOAL_COMMON_NonspinningComboRepeat, 0, "EzState番号", 0)
-- 参数1：攻击目标类型，决定重复攻击的目标选择策略
REGISTER_DBG_GOAL_PARAM(GOAL_COMMON_NonspinningComboRepeat, 1, "攻撃対象【Type】", 0)
-- 参数2：成功距离类型，重复攻击的有效距离范围
REGISTER_DBG_GOAL_PARAM(GOAL_COMMON_NonspinningComboRepeat, 2, "成功距離【Type】", 0)
-- 参数3：上攻击角度，重复攻击向上攻击的仰角限制
REGISTER_DBG_GOAL_PARAM(GOAL_COMMON_NonspinningComboRepeat, 3, "上攻撃角度", 0)
-- 参数4：下攻击角度，重复攻击向下攻击的俯角限制
REGISTER_DBG_GOAL_PARAM(GOAL_COMMON_NonspinningComboRepeat, 4, "下攻撃角度", 0)

-- 启用连击攻击取消机制，允许该目标在连击序列中灵活停止或跳转
ENABLE_COMBO_ATK_CANCEL(GOAL_COMMON_NonspinningComboRepeat)

--[[
非旋转连击重复攻击激活函数
功能：初始化并启动非旋转连击重复攻击行为
参数：
  f1_arg0 - AI实体对象
  f1_arg1 - 目标参数对象，包含重复攻击配置信息
返回：无
逻辑流程：
  1. 获取重复攻击的基础参数
  2. 设置非旋转特性：旋转时间=0，判定角度=180度
  3. 启用连击取消机制，允许灵活控制重复次数
  4. 启动通用攻击子目标，执行可重复的连击攻击
特点：作为连击中间环节，可以根据战术需要多次执行
--]]
function NonspinningComboRepeat_Activate(f1_arg0, f1_arg1)
    -- 获取重复攻击生命周期时间
    local f1_local0 = f1_arg1:GetLife()
    -- 获取重复攻击动画状态ID
    local f1_local1 = f1_arg1:GetParam(0)
    -- 获取重复攻击目标类型
    local f1_local2 = f1_arg1:GetParam(1)
    -- 获取重复攻击成功判定距离
    local f1_local3 = f1_arg1:GetParam(2)

    -- 非旋转重复攻击的特定参数设置
    local f1_local4 = 180   -- 攻击角度范围（180度，半圆范围）
    local f1_local5 = 0     -- 攻击前旋转时间（0秒，即时执行）
    local f1_local6 = 180   -- 正面判定角度（180度，全方位）

    -- 配置非旋转重复攻击行为标志
    local f1_local7 = true   -- 启用攻击
    local f1_local8 = true   -- 启用连击取消机制（重复攻击特性）
    local f1_local9 = true   -- 启用目标跟踪
    local f1_local10 = false -- 禁用复杂检查（保持重复性能）
    local f1_local11 = true  -- 启用重复模式

    -- 获取上下攻击角度限制
    local f1_local12 = f1_arg1:GetParam(3)  -- 上攻击角度
    local f1_local13 = f1_arg1:GetParam(4)  -- 下攻击角度

    -- 启动通用攻击子目标，执行非旋转重复攻击
    -- 注意：连击取消机制被启用，允许灵活控制重复次数和时机
    f1_arg1:AddSubGoal(GOAL_COMMON_CommonAttack, f1_local0, f1_local1, f1_local2, f1_local3, f1_local4, f1_local5, f1_local6, f1_local8, f1_local9, f1_local10, f1_local11, f1_local12, f1_local13, f1_local7)

end

--[[
非旋转连击重复攻击更新函数
功能：在重复攻击执行期间监控和维持攻击状态
参数：
  f2_arg0 - AI实体对象
  f2_arg1 - 目标参数对象
返回：GOAL_RESULT_Continue - 指示目标应继续执行
逻辑：重复攻击需要持续监控状态，决定是否重复或结束
--]]
function NonspinningComboRepeat_Update(f2_arg0, f2_arg1)
    return GOAL_RESULT_Continue

end

--[[
非旋转连击重复攻击终止函数
功能：在重复攻击结束时执行清理工作
参数：
  f3_arg0 - AI实体对象
  f3_arg1 - 目标参数对象
返回：无
逻辑：清理重复状态，为连击序列的下一阶段做准备
灵活性：重复攻击可以根据需要停止或转入其他连击环节
--]]
function NonspinningComboRepeat_Terminate(f3_arg0, f3_arg1)

end

-- 注册该目标为不可中断类型，但允许通过连击取消机制灵活控制
REGISTER_GOAL_NO_INTERUPT(GOAL_COMMON_NonspinningComboRepeat, true)

--[[
非旋转连击重复攻击中断处理函数
功能：决定是否允许其他目标中断当前重复攻击
参数：
  f4_arg0 - AI实体对象
  f4_arg1 - 目标参数对象
返回：false - 不允许外部中断，保持重复阶段的稳定性
逻辑：虽然可以通过内部取消机制停止，但不允许外部事件打断
灵活性：重复攻击的结束时机由AI策略决定，不是外部事件
--]]
function NonspinningComboRepeat_Interupt(f4_arg0, f4_arg1)
    return false

end


