--[[
标准架势破坏攻击系统
功能：实现固定参数的架势破坏攻击AI行为
用途：用于标准化的架势破坏技能，使用预设的攻击时机和角度参数
特点：相比可调节版本更简单直接，适用于大多数常规架势破坏场景
区别：与GuardBreakTunable相比，使用固定的旋转时间和角度判定
--]]

-- 参数0：EzState动画状态ID，指定要执行的架势破坏攻击动画
REGISTER_DBG_GOAL_PARAM(GOAL_COMMON_GuardBreakAttack, 0, "EzStateID", 0)
-- 参数1：攻击目标类型，决定攻击的目标选择策略
REGISTER_DBG_GOAL_PARAM(GOAL_COMMON_GuardBreakAttack, 1, "攻撃対象", 0)
-- 参数2：成功距离，攻击生效的最大有效距离
REGISTER_DBG_GOAL_PARAM(GOAL_COMMON_GuardBreakAttack, 2, "成功距離", 0)
-- 参数3：上攻击角度，向上攻击的仰角限制
REGISTER_DBG_GOAL_PARAM(GOAL_COMMON_GuardBreakAttack, 3, "上攻撃角度", 0)
-- 参数4：下攻击角度，向下攻击的俯角限制
REGISTER_DBG_GOAL_PARAM(GOAL_COMMON_GuardBreakAttack, 4, "下攻撃角度", 0)

--[[
标准架势破坏攻击激活函数
功能：初始化并启动标准化的架势破坏攻击行为
参数：
  f1_arg0 - AI实体对象
  f1_arg1 - 目标参数对象，包含攻击配置信息
返回：无
逻辑流程：
  1. 获取攻击基础参数（时间、动画、目标、距离）
  2. 使用预设的标准化参数（90度角度范围、1.5秒旋转、20度判定）
  3. 配置标准攻击行为标志
  4. 启动通用攻击子目标，执行架势破坏
特点：使用固定参数，确保一致的攻击表现
--]]
function GuardBreakAttack_Activate(f1_arg0, f1_arg1)
    -- 获取攻击生命周期时间
    local f1_local0 = f1_arg1:GetLife()
    -- 获取攻击动画状态ID
    local f1_local1 = f1_arg1:GetParam(0)
    -- 获取攻击目标类型
    local f1_local2 = f1_arg1:GetParam(1)
    -- 获取攻击成功判定距离
    local f1_local3 = f1_arg1:GetParam(2)

    -- 使用标准化的固定参数
    local f1_local4 = 90    -- 标准攻击角度范围（90度）
    local f1_local5 = 1.5   -- 标准攻击前旋转时间（1.5秒）
    local f1_local6 = 20    -- 标准正面判定角度（20度）

    -- 配置标准攻击行为标志
    local f1_local7 = true   -- 启用攻击
    local f1_local8 = true   -- 启用目标跟踪
    local f1_local9 = true   -- 启用距离检查
    local f1_local10 = true  -- 启用角度检查
    local f1_local11 = false -- 禁用连击模式（架势破坏为单次攻击）

    -- 获取上下攻击角度限制
    local f1_local12 = f1_arg1:GetParam(3)  -- 上攻击角度
    local f1_local13 = f1_arg1:GetParam(4)  -- 下攻击角度

    -- 启动通用攻击子目标，执行标准化架势破坏攻击
    f1_arg1:AddSubGoal(GOAL_COMMON_CommonAttack, f1_local0, f1_local1, f1_local2, f1_local3, f1_local4, f1_local5, f1_local6, f1_local8, f1_local9, f1_local10, f1_local11, f1_local12, f1_local13, f1_local7)

end

--[[
标准架势破坏攻击更新函数
功能：在攻击执行期间维持攻击状态
参数：
  f2_arg0 - AI实体对象
  f2_arg1 - 目标参数对象
返回：GOAL_RESULT_Continue - 指示目标应继续执行
逻辑：标准架势破坏攻击使用固定流程，一旦启动就持续到完成
--]]
function GuardBreakAttack_Update(f2_arg0, f2_arg1)
    return GOAL_RESULT_Continue

end

--[[
标准架势破坏攻击终止函数
功能：在攻击目标结束时执行清理工作
参数：
  f3_arg0 - AI实体对象
  f3_arg1 - 目标参数对象
返回：无
逻辑：当前实现为空，主要清理工作由CommonAttack子目标处理
--]]
function GuardBreakAttack_Terminate(f3_arg0, f3_arg1)

end

-- 注册该目标为不可中断类型，确保架势破坏攻击的完整执行
REGISTER_GOAL_NO_INTERUPT(GOAL_COMMON_GuardBreakAttack, true)

--[[
标准架势破坏攻击中断处理函数
功能：决定是否允许其他目标中断当前攻击
参数：
  f4_arg0 - AI实体对象
  f4_arg1 - 目标参数对象
返回：false - 不允许中断，确保架势破坏攻击完整执行
逻辑：架势破坏攻击是关键战术动作，必须完整执行以确保游戏平衡
--]]
function GuardBreakAttack_Interupt(f4_arg0, f4_arg1)
    return false

end


