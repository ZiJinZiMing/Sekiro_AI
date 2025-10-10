--[[
非旋转连击攻击系统
功能：实现无旋转调整的连续攻击组合
用途：用于需要多次连续攻击但不需要旋转调整的战术动作
特点：组合了非旋转攻击的即时性和连击的持续性
与单次非旋转攻击的区别：启用了连击相关的取消机制
与普通连击的区别：省略旋转时间，攻击间隔更短，频率更高
--]]

-- 参数0：EzState动画状态编号，指定连击攻击的初始动画
REGISTER_DBG_GOAL_PARAM(GOAL_COMMON_NonspinningComboAttack, 0, "EzState番号", 0)
-- 参数1：攻击目标类型，决定连击攻击的目标选择策略
REGISTER_DBG_GOAL_PARAM(GOAL_COMMON_NonspinningComboAttack, 1, "攻撃対象【Type】", 0)
-- 参数2：成功距离类型，连击攻击的有效距离范围
REGISTER_DBG_GOAL_PARAM(GOAL_COMMON_NonspinningComboAttack, 2, "成功距離【Type】", 0)
-- 参数3：上攻击角度，连击中向上攻击的仰角限制
REGISTER_DBG_GOAL_PARAM(GOAL_COMMON_NonspinningComboAttack, 3, "上攻撃角度", 0)
-- 参数4：下攻击角度，连击中向下攻击的俯角限制
REGISTER_DBG_GOAL_PARAM(GOAL_COMMON_NonspinningComboAttack, 4, "下攻撃角度", 0)

--[[
非旋转连击攻击激活函数
功能：初始化并启动非旋转连击攻击行为
参数：
  f1_arg0 - AI实体对象
  f1_arg1 - 目标参数对象，包含连击攻击配置信息
返回：无
逻辑流程：
  1. 获取连击攻击的基础参数
  2. 设置非旋转特性：旋转时间=0，判定角度=180度
  3. 启用连击相关取消机制，允许在特定条件下中断连击
  4. 启动通用攻击子目标，执行快速连击
特点：结合了即时性和连续性，适用于快速的持续攻击
--]]
function NonspinningComboAttack_Activate(f1_arg0, f1_arg1)
    -- 获取连击攻击生命周期时间
    local f1_local0 = f1_arg1:GetLife()
    -- 获取连击初始动画状态ID
    local f1_local1 = f1_arg1:GetParam(0)
    -- 获取连击攻击目标类型
    local f1_local2 = f1_arg1:GetParam(1)
    -- 获取连击攻击成功判定距离
    local f1_local3 = f1_arg1:GetParam(2)

    -- 非旋转连击攻击的特定参数设置
    local f1_local4 = 180   -- 攻击角度范围（180度，半圆范围）
    local f1_local5 = 0     -- 攻击前旋转时间（0秒，即时反应）
    local f1_local6 = 180   -- 正面判定角度（180度，全方位）

    -- 配置非旋转连击攻击行为标志
    local f1_local7 = true   -- 启用攻击
    local f1_local8 = true   -- 启用连击取消机制（连击特性）
    local f1_local9 = true   -- 启用目标跟踪
    local f1_local10 = false -- 禁用复杂检查（保持连击流畅性）
    local f1_local11 = true  -- 启用连击模式

    -- 获取上下攻击角度限制
    local f1_local12 = f1_arg1:GetParam(3)  -- 上攻击角度
    local f1_local13 = f1_arg1:GetParam(4)  -- 下攻击角度

    -- 启动通用攻击子目标，执行非旋转连击攻击
    -- 注意：连击取消机制被启用，允许在特定条件下停止连击
    f1_arg1:AddSubGoal(GOAL_COMMON_CommonAttack, f1_local0, f1_local1, f1_local2, f1_local3, f1_local4, f1_local5, f1_local6, f1_local8, f1_local9, f1_local10, f1_local11, f1_local12, f1_local13, f1_local7)

end

--[[
非旋转连击攻击更新函数
功能：在连击执行期间监控和维持攻击状态
参数：
  f2_arg0 - AI实体对象
  f2_arg1 - 目标参数对象
返回：GOAL_RESULT_Continue - 指示目标应继续执行
逻辑：非旋转连击需要持续监控连击状态，并在适当时机结束
--]]
function NonspinningComboAttack_Update(f2_arg0, f2_arg1)
    return GOAL_RESULT_Continue

end

--[[
非旋转连击攻击终止函数
功能：在连击攻击结束时执行清理工作
参数：
  f3_arg0 - AI实体对象
  f3_arg1 - 目标参数对象
返回：无
逻辑：清理连击状态，确保后续攻击不受影响
--]]
function NonspinningComboAttack_Terminate(f3_arg0, f3_arg1)

end

-- 注册该目标为不可中断类型，确保非旋转连击攻击的连续性
REGISTER_GOAL_NO_INTERUPT(GOAL_COMMON_NonspinningComboAttack, true)

--[[
非旋转连击攻击中断处理函数
功能：决定是否允许其他目标中断当前连击攻击
参数：
  f4_arg0 - AI实体对象
  f4_arg1 - 目标参数对象
返回：false - 不允许中断，保持连击的连续性
逻辑：连击攻击需要完整执行以发挥最大威力，但可以通过内部取消机制停止
--]]
function NonspinningComboAttack_Interupt(f4_arg0, f4_arg1)
    return false

end


