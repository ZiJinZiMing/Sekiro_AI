-- ■ 转向系统 - AI朝向控制模块
-- 描述：管理AI的转向行为，包含朝向目标和防御状态的整合
-- 功能：实现精确的转向控制，结合防御行为和角度判定
-- 用途：用于战斗中的朝向调整和防御姿态转换

REGISTER_GOAL_UPDATE_TIME(GOAL_COMMON_ApproachTarget, 0, 0)                     -- 注册接近目标更新时间
REGISTER_DBG_GOAL_PARAM(GOAL_COMMON_Turn, 0, "旋回ターゲット", 0)               -- 参数0：转向目标
REGISTER_DBG_GOAL_PARAM(GOAL_COMMON_Turn, 1, "正面判定角度", 0)                 -- 参数1：正面判定角度
REGISTER_DBG_GOAL_PARAM(GOAL_COMMON_Turn, 2, "ガードEzState番号", 0)           -- 参数2：防御EzState编号
REGISTER_DBG_GOAL_PARAM(GOAL_COMMON_Turn, 3, "ガードゴール終了タイプ", 0)       -- 参数3：防御目标结束类型
REGISTER_DBG_GOAL_PARAM(GOAL_COMMON_Turn, 4, "ガードゴール：寿命が尽きたら成功とするか", 0) -- 参数4：生命周期成功判定
REGISTER_GOAL_NO_SUB_GOAL(GOAL_COMMON_Turn, true)                              -- 注册为无子目标类型

-- ■ 转向行为激活函数
-- 描述：初始化转向行为，设置防御相关参数
-- 参数：f1_arg0 - AI实体对象, f1_arg1 - 目标参数对象
-- 功能：获取防御参数并激活防御子功能
function Turn_Activate(f1_arg0, f1_arg1)
    local f1_local0 = f1_arg1:GetParam(2)  -- 获取防御EzState编号
    local f1_local1 = f1_arg1:GetParam(3)  -- 获取防御目标结束类型
    local f1_local2 = f1_arg1:GetParam(4)  -- 获取生命周期成功判定标志
    GuardGoalSubFunc_Activate(f1_arg0, life_time, f1_local0)  -- 激活防御子功能

end

-- ■ 转向行为更新函数
-- 描述：每帧更新转向状态，处理转向和防御逻辑
-- 参数：f2_arg0 - AI实体对象, f2_arg1 - 目标参数对象
-- 返回：GOAL_RESULT_Success - 转向完成, 或防御子功能的返回值
function Turn_Update(f2_arg0, f2_arg1)
    local f2_local0 = f2_arg1:GetParam(0)  -- 获取转向目标

    -- ■ 执行转向操作
    f2_arg0:RequestEmergencyQuickTurn()     -- 请求紧急快速转向
    f2_arg0:TurnTo(f2_local0)               -- 执行转向到目标

    -- ■ 检查转向完成条件
    if Turn_IsLookToTarget(f2_arg0, f2_arg1) then
        return GOAL_RESULT_Success          -- 转向完成，返回成功
    end

    -- ■ 处理防御相关逻辑
    local f2_local1 = f2_arg1:GetParam(2)  -- 防御EzState编号
    local f2_local2 = f2_arg1:GetParam(3)  -- 防御目标结束类型
    local f2_local3 = f2_arg1:GetParam(4)  -- 生命周期成功判定标志
    return GuardGoalSubFunc_Update(f2_arg0, f2_arg1, f2_local1, f2_local2, f2_local3)  -- 更新防御子功能

end

-- ■ 转向行为终止函数
-- 描述：转向行为结束时的清理函数
-- 功能：执行必要的状态重置和资源清理
function Turn_Terminate(f3_arg0, f3_arg1)

end

-- ■ 转向行为中断处理函数
-- 描述：处理转向过程中的中断事件
-- 参数：f4_arg0 - AI实体对象, f4_arg1 - 目标参数对象
-- 返回：防御子功能的中断处理结果
function Turn_Interupt(f4_arg0, f4_arg1)
    local f4_local0 = f4_arg1:GetParam(2)  -- 获取防御EzState编号
    local f4_local1 = f4_arg1:GetParam(3)  -- 获取防御目标结束类型
    return GuardGoalSubFunc_Interrupt(f4_arg0, f4_arg1, f4_local0, f4_local1)  -- 处理防御中断

end

-- ■ 朝向目标检查函数
-- 描述：检查AI是否已经朝向目标
-- 参数：f5_arg0 - AI实体对象, f5_arg1 - 目标参数对象
-- 返回：true - 已朝向目标, false - 未朝向目标
function Turn_IsLookToTarget(f5_arg0, f5_arg1)
    local f5_local0 = f5_arg1:GetParam(1)  -- 获取正面判定角度
    if f5_local0 <= 0 then                 -- 如果角度参数无效
        f5_local0 = 15                     -- 设置默认角度为15度
    end
    return f5_arg0:IsLookToTarget(f5_local0)  -- 检查是否在指定角度内朝向目标

end


