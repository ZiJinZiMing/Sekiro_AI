--[[
非旋转连击终结攻击系统
功能：实现连击序列的终结攻击，通常是威力最大的最后一击
用途：作为连击组合的最终攻击，通常具有特殊效果和更高伤害
特点：终结性攻击，不需要旋转，但禁用连击取消机制
与连击攻击的区别：连击取消被禁用，确保终结攻击的完整执行
重要性：启用了ENABLE_COMBO_ATK_CANCEL，允许作为连击序列的终结
--]]

-- 参数0：EzState动画状态编号，指定终结攻击的动画
REGISTER_DBG_GOAL_PARAM(GOAL_COMMON_NonspinningComboFinal, 0, "EzState番号", 0)
-- 参数1：攻击目标类型，决定终结攻击的目标选择策略
REGISTER_DBG_GOAL_PARAM(GOAL_COMMON_NonspinningComboFinal, 1, "攻撃対象【Type】", 0)
-- 参数2：成功距离类型，终结攻击的有效距离范围
REGISTER_DBG_GOAL_PARAM(GOAL_COMMON_NonspinningComboFinal, 2, "成功距離【Type】", 0)
-- 参数3：上攻击角度，终结攻击向上攻击的仰角限制
REGISTER_DBG_GOAL_PARAM(GOAL_COMMON_NonspinningComboFinal, 3, "上攻撃角度", 0)
-- 参数4：下攻击角度，终结攻击向下攻击的俯角限制
REGISTER_DBG_GOAL_PARAM(GOAL_COMMON_NonspinningComboFinal, 4, "下攻撃角度", 0)

-- 启用连击攻击取消机制，允许该目标作为连击终结点
ENABLE_COMBO_ATK_CANCEL(GOAL_COMMON_NonspinningComboFinal)

--[[
非旋转连击终结攻击激活函数
功能：初始化并启动非旋转连击终结攻击行为
参数：
  f1_arg0 - AI实体对象
  f1_arg1 - 目标参数对象，包含终结攻击配置信息
返回：无
逻辑流程：
  1. 获取终结攻击的基础参数
  2. 设置非旋转特性：旋转时间=0，判定角度=180度
  3. 禁用连击取消机制，确保终结攻击的完整执行
  4. 启动通用攻击子目标，执行威力最大的终结攻击
特点：作为连击序列的高潮，必须完整执行以发挥最大威力
--]]
function NonspinningComboFinal_Activate(f1_arg0, f1_arg1)
    -- 获取终结攻击生命周期时间
    local f1_local0 = f1_arg1:GetLife()
    -- 获取终结攻击动画状态ID
    local f1_local1 = f1_arg1:GetParam(0)
    -- 获取终结攻击目标类型
    local f1_local2 = f1_arg1:GetParam(1)
    -- 获取终结攻击成功判定距离
    local f1_local3 = f1_arg1:GetParam(2)

    -- 非旋转终结攻击的特定参数设置
    local f1_local4 = 180   -- 攻击角度范围（180度，半圆范围）
    local f1_local5 = 0     -- 攻击前旋转时间（0秒，即时执行）
    local f1_local6 = 180   -- 正面判定角度（180度，全方位）

    -- 配置非旋转终结攻击行为标志
    local f1_local7 = true   -- 启用攻击
    local f1_local8 = false  -- 禁用连击取消机制（终结攻击特性）
    local f1_local9 = true   -- 启用目标跟踪
    local f1_local10 = false -- 禁用复杂检查（保持终结攻击的简洁性）
    local f1_local11 = true  -- 启用终结模式

    -- 获取上下攻击角度限制
    local f1_local12 = f1_arg1:GetParam(3)  -- 上攻击角度
    local f1_local13 = f1_arg1:GetParam(4)  -- 下攻击角度

    -- 启动通用攻击子目标，执行非旋转终结攻击
    -- 注意：连击取消被禁用，确保终结攻击必须完整执行
    f1_arg1:AddSubGoal(GOAL_COMMON_CommonAttack, f1_local0, f1_local1, f1_local2, f1_local3, f1_local4, f1_local5, f1_local6, f1_local8, f1_local9, f1_local10, f1_local11, f1_local12, f1_local13, f1_local7)

end

--[[
非旋转连击终结攻击更新函数
功能：在终结攻击执行期间监控和维持攻击状态
参数：
  f2_arg0 - AI实体对象
  f2_arg1 - 目标参数对象
返回：GOAL_RESULT_Continue - 指示目标应继续执行
逻辑：终结攻击必须完整执行，不允许中途停止
--]]
function NonspinningComboFinal_Update(f2_arg0, f2_arg1)
    return GOAL_RESULT_Continue

end

--[[
非旋转连击终结攻击终止函数
功能：在终结攻击完成时执行清理工作
参数：
  f3_arg0 - AI实体对象
  f3_arg1 - 目标参数对象
返回：无
逻辑：清理连击终结状态，为AI返回常规状态做准备
重要性：终结攻击的结束意味着整个连击序列的完成
--]]
function NonspinningComboFinal_Terminate(f3_arg0, f3_arg1)

end

-- 注册该目标为不可中断类型，确保终结攻击的绝对优先级
REGISTER_GOAL_NO_INTERUPT(GOAL_COMMON_NonspinningComboFinal, true)

--[[
非旋转连击终结攻击中断处理函数
功能：决定是否允许其他目标中断当前终结攻击
参数：
  f4_arg0 - AI实体对象
  f4_arg1 - 目标参数对象
返回：false - 绝对不允许中断，保证终结攻击的完整性
逻辑：终结攻击是连击序列的高潮，不能被任何外部事件打断
重要性：确保连击组合的策略意图得到完整体现
--]]
function NonspinningComboFinal_Interupt(f4_arg0, f4_arg1)
    return false

end


