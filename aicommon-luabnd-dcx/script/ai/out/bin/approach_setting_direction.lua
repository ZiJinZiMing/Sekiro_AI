-- ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■
-- ■ 模块名称: ApproachSettingDirection (指定方向接近目标)
-- ■ 功能描述: 控制AI角色向指定方向移动并接近目标的行为逻辑
-- ■ 主要特性:
-- ■   1. 支持自定义移动方向和距离
-- ■   2. 可配置到达判定距离
-- ■   3. 支持步行或跑步移动模式
-- ■   4. 可设置防御状态和旋回目标
-- ■   5. 灵活的生命周期和成功判定机制
-- ■ 应用场景: 敌人需要向特定方向移动接近玩家或其他目标时使用
-- ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■

-- ■ 参数定义：调试用参数注册，保留原有日文注释便于开发调试
REGISTER_DBG_GOAL_PARAM(GOAL_COMMON_ApproachSettingDirection, 0, "移動対象", 0)        -- 移动目标 (TARGET_*)
REGISTER_DBG_GOAL_PARAM(GOAL_COMMON_ApproachSettingDirection, 1, "到達判定距離", 0)     -- 到达判定距离 (米)
REGISTER_DBG_GOAL_PARAM(GOAL_COMMON_ApproachSettingDirection, 2, "旋回対象", 0)        -- 旋回目标 (TARGET_*)
REGISTER_DBG_GOAL_PARAM(GOAL_COMMON_ApproachSettingDirection, 3, "歩く?", 0)          -- 是否步行 (0:跑步, 1:步行)
REGISTER_DBG_GOAL_PARAM(GOAL_COMMON_ApproachSettingDirection, 4, "ガードEzState番号", 0) -- 防御EzState编号
REGISTER_DBG_GOAL_PARAM(GOAL_COMMON_ApproachSettingDirection, 5, "移動方向", 0)        -- 移动方向 (角度值)
REGISTER_DBG_GOAL_PARAM(GOAL_COMMON_ApproachSettingDirection, 6, "指定方向への距離", 0)   -- 向指定方向的距离 (米)
REGISTER_DBG_GOAL_PARAM(GOAL_COMMON_ApproachSettingDirection, 7, "寿命終了時、成功扱いにするか", 0) -- 生命周期结束时是否视为成功

-- ■ 目标设置：设置为不可中断且不允许子目标
REGISTER_GOAL_NO_INTERUPT(GOAL_COMMON_ApproachSettingDirection, true)   -- 标记为不可中断目标
REGISTER_GOAL_NO_SUB_GOAL(GOAL_COMMON_ApproachSettingDirection, true)   -- 标记为不允许子目标

-- ■ 函数名称: ApproachSettingDirection_Activate
-- ■ 功能描述: 指定方向接近目标的激活函数，负责初始化移动行为
-- ■ 参数说明:
-- ■   f1_arg0: AI角色实体对象
-- ■   f1_arg1: 目标参数对象，包含所有配置参数
-- ■ 执行逻辑:
-- ■   1. 获取所有移动相关参数
-- ■   2. 添加MoveToSomewhere子目标来执行实际的移动行为
-- ■   3. 配置移动的方向、距离、速度等属性
function ApproachSettingDirection_Activate(f1_arg0, f1_arg1)
    local f1_local0 = f1_arg1:GetLife()        -- 获取目标生命周期
    local f1_local1 = f1_arg1:GetParam(0)      -- 移动目标 (TARGET_*)
    local f1_local2 = f1_arg1:GetParam(1)      -- 到达判定距离
    local f1_local3 = f1_arg1:GetParam(2)      -- 旋回目标 (朝向目标)
    local f1_local4 = f1_arg1:GetParam(3)      -- 是否步行 (移动速度控制)
    local f1_local5 = f1_arg1:GetParam(4)      -- 防御EzState编号
    local f1_local6 = f1_arg1:GetParam(5)      -- 移动方向 (角度)
    local f1_local7 = f1_arg1:GetParam(6)      -- 向指定方向的距离

    -- ■ 添加移动到某处的子目标，使用所有配置参数
    -- ■ 参数顺序: 生命周期(-1表示无限), 目标, 方向, 距离, 旋回目标, 步行标志, 移动距离, 未知参数, false, 防御状态, 继续结果, false
    f1_arg1:AddSubGoal(GOAL_COMMON_MoveToSomewhere, -1, f1_local1, f1_local6, f1_local2, f1_local3, f1_local4, f1_local7, 0, false, f1_local5, GOAL_RESULT_Continue, false)

end

-- ■ 函数名称: ApproachSettingDirection_Update
-- ■ 功能描述: 指定方向接近目标的更新函数，负责监控移动状态并返回执行结果
-- ■ 参数说明:
-- ■   f2_arg0: AI角色实体对象
-- ■   f2_arg1: 目标参数对象
-- ■   f2_arg2: 更新参数对象
-- ■ 返回值: GOAL_RESULT_Success/Failed/Continue (目标执行结果)
-- ■ 执行逻辑:
-- ■   1. 检查子目标是否完成 (无子目标时表示移动完成)
-- ■   2. 检查生命周期是否结束
-- ■   3. 根据"生命周期结束时成功标志"决定返回成功或失败
function ApproachSettingDirection_Update(f2_arg0, f2_arg1, f2_arg2)
    local f2_local0 = f2_arg1:GetParam(7)      -- 生命周期结束时是否视为成功的标志

    -- ■ 检查是否还有子目标在执行 (子目标数量为0表示移动已完成)
    if f2_arg1:GetSubGoalNum() <= 0 then
        return GOAL_RESULT_Success              -- 移动完成，返回成功
    end

    -- ■ 检查生命周期是否已结束
    if f2_arg1:GetLife() <= 0 then
        if f2_local0 == nil then
            return GOAL_RESULT_Failed           -- 生命周期结束且未设置成功标志，返回失败
        else
            return GOAL_RESULT_Success          -- 生命周期结束但设置了成功标志，返回成功
        end
    end

    return GOAL_RESULT_Continue                 -- 继续执行移动

end

-- ■ 函数名称: ApproachSettingDirection_Terminate
-- ■ 功能描述: 指定方向接近目标的终止函数，负责清理资源和状态
-- ■ 参数说明:
-- ■   f3_arg0: AI角色实体对象
-- ■   f3_arg1: 目标参数对象
-- ■ 执行逻辑: 当前为空实现，无需特殊的清理操作
function ApproachSettingDirection_Terminate(f3_arg0, f3_arg1)
    -- ■ 当前无需特殊的终止处理，MoveToSomewhere子目标会自动清理
end

-- ■ 函数名称: ApproachSettingDirection_Interupt
-- ■ 功能描述: 指定方向接近目标的中断处理函数，决定是否允许被其他目标中断
-- ■ 参数说明:
-- ■   f4_arg0: AI角色实体对象
-- ■   f4_arg1: 目标参数对象
-- ■ 返回值: false (不允许中断)
-- ■ 设计理念: 由于此目标被标记为REGISTER_GOAL_NO_INTERUPT，因此不允许被中断
function ApproachSettingDirection_Interupt(f4_arg0, f4_arg1)
    return false                                -- 始终返回false，不允许中断此目标

end


