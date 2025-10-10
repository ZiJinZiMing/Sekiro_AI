--[[
持续保持距离行为脚本
功能：AI持续与目标保持在指定距离范围内，动态调整位置并执行侧移
使用场景：远程攻击AI、需要保持战术距离的敌人、弓箭手等
战术意图：通过距离控制获得战术优势，避免被近战攻击同时保持攻击机会
系统特点：使用Table目标系统，支持复杂的行为组合和状态管理
--]]

-- 注册为表格目标，支持复杂的行为状态管理
RegisterTableGoal(GOAL_COMMON_ContinueKeepDist, "GOAL_COMMON_ContinueKeepDist")

-- 注册为允许子目标的类型，支持复杂的行为组合
REGISTER_GOAL_NO_SUB_GOAL(GOAL_COMMON_ContinueKeepDist, true)

-- 调试参数注册
REGISTER_DBG_GOAL_PARAM(GOAL_COMMON_ContinueKeepDist, 0, "ターゲット", 0)        -- 目标类型
REGISTER_DBG_GOAL_PARAM(GOAL_COMMON_ContinueKeepDist, 1, "最低距離", 1)        -- 最小距离（米）
REGISTER_DBG_GOAL_PARAM(GOAL_COMMON_ContinueKeepDist, 2, "最大距離", 2)        -- 最大距离（米）
REGISTER_DBG_GOAL_PARAM(GOAL_COMMON_ContinueKeepDist, 3, "強制走行距離", 3)    -- 强制移动距离
REGISTER_DBG_GOAL_PARAM(GOAL_COMMON_ContinueKeepDist, 4, "接近ガード確率", 4)  -- 接近时防御概率（%）
REGISTER_DBG_GOAL_PARAM(GOAL_COMMON_ContinueKeepDist, 5, "間合いガード確率", 5) -- 保持距离时防御概率（%）

--[[
持续保持距离激活函数
功能：初始化持续保持距离行为，开始第一次距离调整
逻辑：直接调用核心距离保持函数，开始行为循环
--]]
Goal.Activate = function (f1_arg0, f1_arg1, f1_arg2)
    -- 调用核心距离保持函数，开始持续保持距离行为
    f1_arg0.ContinueKeepDist(f1_arg0, f1_arg1, f1_arg2)

end

--[[
持续保持距离更新函数
功能：监控距离保持行为的执行状态，动态调整行为策略
返回值：
  GOAL_RESULT_Success - 目标死亡，任务完成
  GOAL_RESULT_Continue - 继续执行距离保持
逻辑流程：
  1. 检查目标生命状态
  2. 检查子目标执行情况
  3. 监控侧移行为是否需要重新调整距离
  4. 在合适时机重新启动距离保持逻辑
--]]
Goal.Update = function (f2_arg0, f2_arg1, f2_arg2)
    -- 获取距离控制参数
    local f2_local0 = f2_arg2:GetParam(1)  -- 最小距离
    local f2_local1 = f2_arg2:GetParam(2)  -- 最大距离
    local f2_local2 = f2_arg1:GetDist(Target)  -- 当前到目标的距离

    -- 检查目标生命状态：目标死亡则任务完成
    if f2_arg2:GetLife() <= 0 then
        return GOAL_RESULT_Success
    end

    -- 检查是否没有子目标在执行：无子目标时重新开始距离保持
    if f2_arg2:GetSubGoalNum() <= 0 then
        f2_arg0.ContinueKeepDist(f2_arg0, f2_arg1, f2_arg2)
        return GOAL_RESULT_Continue
    end

    -- 检查侧移行为状态：如果正在侧移且距离超出理想范围，重新调整
    -- 这确保AI在侧移过程中不会偏离理想的战术距离
    if f2_arg1:IsActiveGoal(GOAL_COMMON_SidewayMove) and (f2_local1 <= f2_local2 or f2_local0 <= f2_local2) then
        -- 清除当前子目标，重新开始距离保持
        f2_arg2:ClearSubGoal()
        f2_arg0.ContinueKeepDist(f2_arg0, f2_arg1, f2_arg2)
        return GOAL_RESULT_Continue
    end

    -- 继续执行当前的子目标
    return GOAL_RESULT_Continue

end

--[[
持续保持距离核心函数
功能：根据当前距离状况执行相应的调整行为
参数：
  f3_arg0 - Goal对象
  f3_arg1 - AI实体对象
  f3_arg2 - 目标参数对象
逻辑流程：
  1. 获取所有距离和防御参数
  2. 判断当前距离状态（太远/太近/合适）
  3. 执行相应的接近/撤离行为
  4. 添加随机侧移增加战术机动性
战术要点：
  - 距离过远时接近，带可选防御
  - 距离过近时撤离，带可选防御
  - 始终保持侧移，增加闪避能力
--]]
Goal.ContinueKeepDist = function (f3_arg0, f3_arg1, f3_arg2)
    -- 获取距离保持参数
    local f3_local0 = f3_arg2:GetParam(0)  -- 目标类型
    local f3_local1 = f3_arg2:GetParam(1)  -- 最小距离
    local f3_local2 = f3_arg2:GetParam(2)  -- 最大距离
    local f3_local3 = f3_arg2:GetParam(3)  -- 强制移动距离
    local f3_local4 = f3_arg2:GetParam(4)  -- 接近时防御概率
    local f3_local5 = f3_arg2:GetParam(5)  -- 保持距离时防御概率

    -- 获取当前到目标的距离
    local f3_local6 = f3_arg1:GetDist(f3_local0)

    -- 距离判断和行为决策
    if f3_local2 <= f3_local6 then
        -- 距离过远：需要接近目标
        local f3_local7 = -1  -- 防御动作ID初始化

        -- 根据接近防御概率决定是否使用防御姿态
        if f3_arg1:GetRandam_Int(1, 100) <= f3_local4 then
            f3_local7 = 9910  -- 设置防御动作ID
        end

        -- 检查强制移动距离设置，决定接近方式
        if f3_local2 <= f3_local0 then
            -- 不使用可达性检查的接近（可能穿越障碍）
            f3_arg2:AddSubGoal(GOAL_COMMON_ApproachTarget, f3_arg2:GetLife(), TARGET_ENE_0, (f3_local2 + f3_local1) / 2, TARGET_SELF, false, f3_local7):SetFailedEndOption(AI_GOAL_FAILED_END_OPT__PARENT_NEXT_SUB_GOAL)
        else
            -- 使用可达性检查的接近（寻找路径）
            f3_arg2:AddSubGoal(GOAL_COMMON_ApproachTarget, f3_arg2:GetLife(), TARGET_ENE_0, (f3_local2 + f3_local1) / 2, TARGET_SELF, true, f3_local7):SetFailedEndOption(AI_GOAL_FAILED_END_OPT__PARENT_NEXT_SUB_GOAL)
        end

    elseif f3_local6 <= f3_local1 then
        -- 距离过近：需要撤离目标
        local f3_local7 = -1  -- 防御动作ID初始化

        -- 根据保持距离防御概率决定是否使用防御姿态
        if f3_arg1:GetRandam_Int(1, 100) <= f3_local5 then
            f3_local7 = 9910  -- 设置防御动作ID
        end

        -- 执行撤离行为，移动到理想距离范围的中点
        f3_arg2:AddSubGoal(GOAL_COMMON_LeaveTarget, f3_arg2:GetLife(), TARGET_ENE_0, (f3_local2 + f3_local1) / 2, TARGET_ENE_0, true, f3_local7):SetFailedEndOption(AI_GOAL_FAILED_END_OPT__PARENT_NEXT_SUB_GOAL)
    end

    -- 距离合适或调整完成后，执行侧移行为
    -- 侧移增加战术机动性，避免成为静止目标
    -- 参数：持续时间3-5秒、目标敌人、随机方向、随机角度30-45度、多项移动选项、防御姿态
    f3_arg2:AddSubGoal(GOAL_COMMON_SidewayMove, f3_arg1:GetRandam_Float(3, 5), TARGET_ENE_0, f3_arg1:GetRandam_Int(0, 1), f3_arg1:GetRandam_Int(30, 45), true, true, Guard)

end


