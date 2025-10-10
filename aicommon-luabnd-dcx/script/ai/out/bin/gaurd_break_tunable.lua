--[[
架势破坏可调节攻击系统
功能：实现可自定义参数的架势破坏攻击AI行为
用途：用于需要灵活配置攻击参数的架势破坏技能，允许在运行时调整攻击特性
特点：支持多角度攻击、可调旋转时间、自定义判定角度等高级功能
--]]

-- 参数0：EzState动画状态ID，指定要执行的攻击动画
REGISTER_DBG_GOAL_PARAM(GOAL_COMMON_GuardBreakTunable, 0, "EzStateID", 0)
-- 参数1：攻击目标类型，决定攻击的目标选择逻辑
REGISTER_DBG_GOAL_PARAM(GOAL_COMMON_GuardBreakTunable, 1, "攻撃対象", 0)
-- 参数2：成功距离，攻击被认为成功的最大距离
REGISTER_DBG_GOAL_PARAM(GOAL_COMMON_GuardBreakTunable, 2, "成功距離", 0)
-- 参数3：攻击前旋转时间（秒），执行攻击前的准备旋转持续时间
REGISTER_DBG_GOAL_PARAM(GOAL_COMMON_GuardBreakTunable, 3, "攻撃前旋回時間【秒】", 0)
-- 参数4：正面判定角度（度），判定目标是否在正面的角度范围
REGISTER_DBG_GOAL_PARAM(GOAL_COMMON_GuardBreakTunable, 4, "正面判定角度【度】", 0)
-- 参数5：上攻击角度，向上攻击的仰角限制
REGISTER_DBG_GOAL_PARAM(GOAL_COMMON_GuardBreakTunable, 5, "上攻撃角度", 0)
-- 参数6：下攻击角度，向下攻击的俯角限制
REGISTER_DBG_GOAL_PARAM(GOAL_COMMON_GuardBreakTunable, 6, "下攻撃角度", 0)

--[[
架势破坏可调节攻击激活函数
功能：初始化并启动可自定义的架势破坏攻击行为
参数：
  f1_arg0 - AI实体对象
  f1_arg1 - 目标参数对象，包含攻击配置信息
返回：无
逻辑流程：
  1. 获取攻击持续时间和基础攻击参数
  2. 应用参数验证和默认值设置
  3. 配置攻击行为标志和角度限制
  4. 启动通用攻击子目标，实现架势破坏效果
--]]
function GuardBreakTunable_Activate(f1_arg0, f1_arg1)
    -- 获取攻击生命周期时间
    local f1_local0 = f1_arg1:GetLife()
    -- 获取攻击动画状态ID
    local f1_local1 = f1_arg1:GetParam(0)
    -- 获取攻击目标类型
    local f1_local2 = f1_arg1:GetParam(1)
    -- 获取攻击成功判定距离
    local f1_local3 = f1_arg1:GetParam(2)
    -- 设置攻击角度范围，90度为默认值
    local f1_local4 = 90
    -- 获取攻击前旋转时间参数
    local f1_local5 = f1_arg1:GetParam(3)
    -- 获取正面判定角度参数
    local f1_local6 = f1_arg1:GetParam(4)

    -- 验证旋转时间参数，设置默认值为1.5秒
    if f1_local5 < 0 then
        f1_local5 = 1.5
    end
    -- 验证正面判定角度参数，设置默认值为20度
    if f1_local6 < 0 then
        f1_local6 = 20
    end

    -- 配置攻击行为标志
    local f1_local7 = true   -- 启用攻击
    local f1_local8 = true   -- 启用目标跟踪
    local f1_local9 = true   -- 启用距离检查
    local f1_local10 = true  -- 启用角度检查
    local f1_local11 = false -- 禁用连击模式

    -- 获取上下攻击角度限制
    local f1_local12 = f1_arg1:GetParam(5)  -- 上攻击角度
    local f1_local13 = f1_arg1:GetParam(6)  -- 下攻击角度

    -- 启动通用攻击子目标，传递所有配置参数
    -- 这将执行实际的架势破坏攻击行为
    f1_arg1:AddSubGoal(GOAL_COMMON_CommonAttack, f1_local0, f1_local1, f1_local2, f1_local3, f1_local4, f1_local5, f1_local6, f1_local8, f1_local9, f1_local10, f1_local11, f1_local12, f1_local13, f1_local7)

end

--[[
架势破坏可调节攻击更新函数
功能：在攻击执行期间持续监控和更新攻击状态
参数：
  f2_arg0 - AI实体对象
  f2_arg1 - 目标参数对象
返回：GOAL_RESULT_Continue - 指示目标应继续执行
逻辑：该攻击类型一旦启动就会持续进行，直到子目标完成
--]]
function GuardBreakTunable_Update(f2_arg0, f2_arg1)
    return GOAL_RESULT_Continue

end

--[[
架势破坏可调节攻击终止函数
功能：在攻击目标结束时执行清理工作
参数：
  f3_arg0 - AI实体对象
  f3_arg1 - 目标参数对象
返回：无
逻辑：当前实现为空，因为主要清理工作由子目标自动处理
--]]
function GuardBreakTunable_Terminate(f3_arg0, f3_arg1)

end

-- 注册该目标为不可中断类型，确保攻击的完整性
REGISTER_GOAL_NO_INTERUPT(GOAL_COMMON_GuardBreakTunable, true)

--[[
架势破坏可调节攻击中断处理函数
功能：决定是否允许其他目标中断当前攻击
参数：
  f4_arg0 - AI实体对象
  f4_arg1 - 目标参数对象
返回：false - 不允许中断，确保攻击完整执行
逻辑：架势破坏攻击是重要的战术动作，不应被轻易中断
--]]
function GuardBreakTunable_Interupt(f4_arg0, f4_arg1)
    return false

end


