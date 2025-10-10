--[[
非旋转攻击系统
功能：实现无旋转动作的攻击AI行为
用途：用于不需要旋转调整的直接攻击，适用于快速响应和即时攻击
特点：旋转时间为0，判定角度为180度，可以对全方位目标进行攻击
与普通攻击的区别：省略旋转时间，更加直接和快速
--]]

-- 参数0：EzState动画状态编号，指定要执行的非旋转攻击动画
REGISTER_DBG_GOAL_PARAM(GOAL_COMMON_NonspinningAttack, 0, "EzState番号", 0)
-- 参数1：攻击目标类型，决定攻击的目标选择策略
REGISTER_DBG_GOAL_PARAM(GOAL_COMMON_NonspinningAttack, 1, "攻撃対象【Type】", 0)
-- 参数2：成功距离类型，攻击生效的有效距离范围
REGISTER_DBG_GOAL_PARAM(GOAL_COMMON_NonspinningAttack, 2, "成功距離【Type】", 0)
-- 参数3：上攻击角度，向上攻击的仰角限制
REGISTER_DBG_GOAL_PARAM(GOAL_COMMON_NonspinningAttack, 3, "上攻撃角度", 0)
-- 参数4：下攻击角度，向下攻击的俯角限制
REGISTER_DBG_GOAL_PARAM(GOAL_COMMON_NonspinningAttack, 4, "下攻撃角度", 0)

--[[
非旋转攻击激活函数
功能：初始化并启动非旋转攻击行为
参数：
  f1_arg0 - AI实体对象
  f1_arg1 - 目标参数对象，包含攻击配置信息
返回：无
逻辑流程：
  1. 获取攻击基础参数（时间、动画、目标、距离）
  2. 设置非旋转特性：旋转时间=0，判定角度=180度
  3. 配置攻击行为标志，启用快速响应模式
  4. 启动通用攻击子目标，执行即时攻击
特点：无需等待旋转，直接攻击，适用于快速反击和连续攻击
--]]
function NonspinningAttack_Activate(f1_arg0, f1_arg1)
    -- 获取攻击生命周期时间
    local f1_local0 = f1_arg1:GetLife()
    -- 获取攻击动画状态ID
    local f1_local1 = f1_arg1:GetParam(0)
    -- 获取攻击目标类型
    local f1_local2 = f1_arg1:GetParam(1)
    -- 获取攻击成功判定距离
    local f1_local3 = f1_arg1:GetParam(2)

    -- 非旋转攻击的特定参数设置
    local f1_local4 = 180   -- 攻击角度范围（180度，半圆范围）
    local f1_local5 = 0     -- 攻击前旋转时间（0秒，无旋转）
    local f1_local6 = 180   -- 正面判定角度（180度，全方位）

    -- 配置非旋转攻击行为标志
    local f1_local7 = true   -- 启用攻击
    local f1_local8 = false  -- 禁用高级取消机制（保持即时性）
    local f1_local9 = true   -- 启用目标跟踪
    local f1_local10 = false -- 禁用复杂检查（简化逐）
    local f1_local11 = true  -- 启用快速执行模式

    -- 获取上下攻击角度限制
    local f1_local12 = f1_arg1:GetParam(3)  -- 上攻击角度
    local f1_local13 = f1_arg1:GetParam(4)  -- 下攻击角度

    -- 启动通用攻击子目标，执行非旋转攻击
    -- 注意：旋转时间为0，使攻击可以立即执行
    f1_arg1:AddSubGoal(GOAL_COMMON_CommonAttack, f1_local0, f1_local1, f1_local2, f1_local3, f1_local4, f1_local5, f1_local6, f1_local8, f1_local9, f1_local10, f1_local11, f1_local12, f1_local13, f1_local7)

end

--[[
非旋转攻击更新函数
功能：在攻击执行期间维持攻击状态
参数：
  f2_arg0 - AI实体对象
  f2_arg1 - 目标参数对象
返回：GOAL_RESULT_Continue - 指示目标应继续执行
逻辑：非旋转攻击由于省略了旋转时间，通常执行更快
--]]
function NonspinningAttack_Update(f2_arg0, f2_arg1)
    return GOAL_RESULT_Continue

end

--[[
非旋转攻击终止函数
功能：在攻击目标结束时执行清理工作
参数：
  f3_arg0 - AI实体对象
  f3_arg1 - 目标参数对象
返回：无
逻辑：当前实现为空，主要清理工作由CommonAttack子目标处理
--]]
function NonspinningAttack_Terminate(f3_arg0, f3_arg1)

end

-- 注册该目标为不可中断类型，确保非旋转攻击的完整性
REGISTER_GOAL_NO_INTERUPT(GOAL_COMMON_NonspinningAttack, true)

--[[
非旋转攻击中断处理函数
功能：决定是否允许其他目标中断当前攻击
参数：
  f4_arg0 - AI实体对象
  f4_arg1 - 目标参数对象
返回：false - 不允许中断，确保非旋转攻击完整执行
逻辑：非旋转攻击需要完整执行以确保即时攻击的效果
--]]
function NonspinningAttack_Interupt(f4_arg0, f4_arg1)
    return false

end


