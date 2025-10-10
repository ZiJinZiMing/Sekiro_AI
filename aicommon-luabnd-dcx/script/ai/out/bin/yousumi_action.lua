--[[
    特殊动作AI系统 (Yousumi Special Action AI System)
    文件: yousumi_action.lua

    功能架构解析:
    ================================================================================
    这是只狼中复杂的特殊动作AI控制脚本，主要处理基于几何角度计算的
    智能定位和移动行为。"Yousumi"可能指特定的战术移动模式或特殊技能。

    核心机制:
    - 基于三角函数的几何距离计算
    - 多层空间检测与路径验证
    - 角度驱动的动态定位系统
    - 自适应的移动策略选择

    参数系统:
    - param0: 步行模式标志 (0=禁用步行, 1=允许步行)
    - param1: 最大角度 (度数，用于距离计算)
    - param2: 最小角度 (度数，用于距离计算)
    - param3: 姿势偏移 (特殊值9910有特殊含义)
    - param4: 后退移动目标寿命 (默认1秒)
    - param5: 横移目标寿命 (默认2.5秒)

    算法特点:
    - 使用正弦函数计算理想距离位置
    - 多重空间检查确保移动安全性
    - 智能的目标切换机制
    - 路径失败的自动处理

    技术实现:
    - 禁用子目标嵌套，简化执行流程
    - 复杂的条件分支处理各种移动场景
    - 集成路径检测和空间感知系统
    ================================================================================
--]]

RegisterTableGoal(GOAL_COMMON_YousumiAct, "YousumiAct")

-- 性能优化：禁用子目标嵌套，简化执行流程
REGISTER_GOAL_NO_SUB_GOAL(GOAL_COMMON_YousumiAct, true)

-- 调试参数定义：支持六种可配置参数
REGISTER_DBG_GOAL_PARAM(GOAL_COMMON_YousumiAct, 0, "歩くか", 0)           -- 步行模式控制
REGISTER_DBG_GOAL_PARAM(GOAL_COMMON_YousumiAct, 1, "最大角度", 0)         -- 最大计算角度
REGISTER_DBG_GOAL_PARAM(GOAL_COMMON_YousumiAct, 2, "最小角度", 0)         -- 最小计算角度
REGISTER_DBG_GOAL_PARAM(GOAL_COMMON_YousumiAct, 3, "姿勢オフセット", 0)   -- 姿势偏移参数
REGISTER_DBG_GOAL_PARAM(GOAL_COMMON_YousumiAct, 4, "後移動ゴールの寿命", 0) -- 后退移动寿命
REGISTER_DBG_GOAL_PARAM(GOAL_COMMON_YousumiAct, 5, "横移動ゴールの寿命", 0) -- 横移寿命

--[[
    特殊动作激活函数 - 复杂几何计算与决策中心
    ============================================================================
    这是系统中最复杂的AI决策函数之一，整合了几何学、空间感知、
    路径规划等多个子系统来实现智能的战术移动。

    算法核心：基于三角函数的动态定位系统
    通过目标的Y轴高度差和角度参数，计算出理想的接近距离，
    实现类似"包抄"、"迂回"等高级战术动作。

    执行阶段：
    1. 参数初始化与默认值设定
    2. 几何距离计算 (基于正弦定理)
    3. 空间检测与路径验证
    4. 移动策略选择与执行
    ============================================================================
--]]
Goal.Activate = function (f1_arg0, f1_arg1, f1_arg2)
    -- ===== 第一阶段：参数获取与初始化 =====
    local f1_local0 = f1_arg2:GetParam(0)  -- 步行模式标志
    local f1_local1 = f1_arg2:GetParam(1)  -- 最大角度 (度数)
    local f1_local2 = f1_arg2:GetParam(2)  -- 最小角度 (度数)
    local f1_local3 = f1_arg2:GetParam(3)  -- 姿势偏移参数
    local f1_local4 = f1_arg2:GetParam(4)  -- 后退移动寿命
    local f1_local5 = f1_arg2:GetParam(5)  -- 横移寿命

    -- 默认值设定：确保关键参数的有效性
    if f1_local4 == 0 then
        f1_local4 = 1      -- 后退移动默认1秒寿命
    end
    if f1_local5 == 0 then
        f1_local5 = 2.5    -- 横移默认2.5秒寿命
    end

    -- ===== 第二阶段：空间信息采集 =====
    local f1_local6 = f1_arg2:GetLife()                    -- AI实体生命周期
    local f1_local7 = f1_arg1:GetDist(TARGET_ENE_0)        -- 与敌人的水平距离
    local f1_local8 = f1_arg1:GetDistYSigned(TARGET_ENE_0)  -- 与敌人的Y轴高度差(带符号)

    -- ===== 第三阶段：算法常量与变量定义 =====
    local f1_local9 = 1           -- 基础缩放系数
    local f1_local10 = 30         -- 最大接近距离阈值

    -- ===== 核心几何计算：基于三角函数的距离算法 =====
    -- 使用正弦定理计算理想接近距离
    -- 公式：距离 = 高度差 / sin(角度)
    local f1_local11 = f1_local8 / math.sin(math.rad(f1_local1))  -- 基于最大角度的距离
    local f1_local12 = f1_local8 / math.sin(math.rad(f1_local2))  -- 基于最小角度的距离

    -- ===== 第四阶段：随机化与配置设定 =====
    local f1_local13 = f1_arg1:GetRandam_Int(0, 1)  -- 随机方向选择 (0或1)
    local f1_local14 = true        -- 布尔标志位
    local f1_local15 = 2.5         -- 目标接近距离
    local f1_local16 = -1          -- 默认动作偏移

    -- 特殊姿势处理：9910可能是特定的战术模式标识
    if f1_local3 == 9910 then
        f1_local16 = 9910   -- 启用特殊姿势偏移
    end
    -- ===== 第五阶段：空间检测与方向决策 =====
    -- 侧向移动空间检查：确定可用的移动方向
    local f1_local17 = SpaceCheck_SidewayMove(f1_arg1, f1_arg2, 1)
    if f1_local17 == 0 then
        -- 只有左侧可移动
        f1_local13 = 0
    elseif f1_local17 == 1 then
        -- 只有右侧可移动
        f1_local13 = 1
    elseif f1_local17 == 2 then
        -- 两侧都可移动，保持随机选择
        -- f1_local13 保持之前的随机值
    else
        -- 其他情况：无可用空间或错误状态
        -- 保持默认行为
    end

    -- ===== 第六阶段：目标切换与路径验证 =====
    local f1_local18 = TARGET_ENE_0  -- 默认目标：敌人0

    -- 关键路径检测：验证到达敌人的路径是否可行
    if f1_arg1:CheckDoesExistPathWithSetPoint(TARGET_ENE_0, AI_DIR_TYPE_F, 0, 0) == false then
        -- 路径不可达时的应急处理
        f1_local18 = POINT_UnreachTerminate  -- 切换到终点标记
        f1_local7 = f1_arg1:GetDist_Point(POINT_UnreachTerminate)  -- 重新计算距离
        f1_local15 = 0.5  -- 降低接近距离要求
    end
    -- ===== 第七阶段：主要决策分支系统 =====

    -- 路径失败状态重置
    if f1_arg1:GetStringIndexedNumber("Reach_EndOnFailedPath") == 1 then
        -- 重置路径失败标记，准备新的尝试
        f1_arg1:SetStringIndexedNumber("Reach_EndOnFailedPath", 0)

    -- 决策分支1：距离过远时的接近行为
    elseif f1_local10 <= f1_local7 then
        -- 距离超过30米时，执行简单接近
        f1_arg2:AddSubGoal(GOAL_COMMON_ApproachTarget, 1.5, f1_local18, f1_local10 - 0.5, TARGET_SELF, false, f1_local16)
    -- 决策分支2：目标在上方时的复杂处理 (高度差 > 0)
    elseif f1_local8 > 0 then

        -- 子分支2.1：在最小角度计算范围内
        if f1_local12 <= f1_local7 then
            if f1_local7 <= f1_local15 then
                -- 已经在理想距离范围内，无需移动
                -- 空处理，保持当前位置
            elseif f1_local7 - f1_local12 >= 5 and f1_local0 == false then
                -- 距离差异较大且禁用步行时，快速接近
                f1_arg2:AddSubGoal(GOAL_COMMON_ApproachTarget, 1.5, f1_local18, f1_local15, TARGET_SELF, false, f1_local16)
            else
                -- 常规接近，允许后退调整
                f1_arg2:AddSubGoal(GOAL_COMMON_ApproachTarget, 3, f1_local18, f1_local15, TARGET_SELF, true, f1_local16)
            end

        -- 子分支2.2：在最大角度计算范围内 (需要后退)
        elseif f1_local7 <= f1_local11 then
            if f1_arg1:IsInsideTarget(TARGET_ENE_0, AI_DIR_TYPE_F, 180) then
                -- 敌人在前方180度范围内
                if SpaceCheck(f1_arg1, f1_arg2, 180, 1.5) == true then
                    -- 后方有足够空间，执行后退
                    f1_arg2:AddSubGoal(GOAL_COMMON_LeaveTarget, f1_local4, TARGET_ENE_0, 50, TARGET_ENE_0, true, f1_local16)
                end
            elseif SpaceCheck(f1_arg1, f1_arg2, 0, 0.5) == true then
                -- 前方有空间，直接后退
                f1_arg2:AddSubGoal(GOAL_COMMON_LeaveTarget, f1_local4, TARGET_ENE_0, 50, TARGET_ENE_0, true, f1_local16)
            else
                -- 空间不足，转向敌人
                f1_arg2:AddSubGoal(GOAL_COMMON_Turn, 3, TARGET_ENE_0, 0, 0, 0, 0)
                -- 注：原代码中的 if false 可能是调试代码残留
            end
        end
    -- 决策分支3：目标在下方或同水平时的处理 (高度差 <= 0)
    elseif SpaceCheck(f1_arg1, f1_arg2, 0, 0.5) == false then
        -- 前方空间不足，强制后退
        f1_arg2:AddSubGoal(GOAL_COMMON_LeaveTarget, f1_local4, TARGET_ENE_0, 50, TARGET_ENE_0, true, f1_local16)

    elseif f1_local7 <= f1_local15 then
        -- 已经在理想距离范围内，无需移动
        -- 空处理，保持当前位置

    elseif SpaceCheck(f1_arg1, f1_arg2, 0, 4) == true and f1_local0 == false then
        -- 前方有4米空间且禁用步行模式时，快速接近
        f1_arg2:AddSubGoal(GOAL_COMMON_ApproachTarget, 1.5, f1_local18, f1_local15, TARGET_SELF, false, f1_local16)

    elseif SpaceCheck(f1_arg1, f1_arg2, 0, 3) == true then
        -- 前方有3米空间时，谨慎接近 (允许后退调整)
        f1_arg2:AddSubGoal(GOAL_COMMON_ApproachTarget, 3, f1_local18, f1_local15, TARGET_SELF, true, f1_local16)
    else
        -- 默认情况：空间不足或其他条件不满足
        -- 保持当前状态，等待下一次决策
    end
end

--[[
    特殊动作更新函数
    ===============================================
    使用默认的无子目标更新逻辑。

    设计说明:
    由于注册了NO_SUB_GOAL，系统禁用了子目标嵌套，
    所有行为都通过单一层级的子目标执行，简化了更新逻辑。

    返回值:
    使用默认更新函数处理标准的执行状态转换。
    ===============================================
--]]
Goal.Update = function (f2_arg0, f2_arg1, f2_arg2)
    -- 使用默认的无子目标更新逻辑
    return Update_Default_NoSubGoal(f2_arg0, f2_arg1, f2_arg2)
end

--[[
    特殊动作终止函数
    ===============================================
    AI行为结束时的清理工作。

    设计说明:
    特殊动作系统采用轻量级设计，无需特殊的清理操作。
    所有状态管理都由子目标系统自动处理。

    扩展建议:
    - 可以添加统计信息记录
    - 实现行为模式的学习机制
    - 记录成功的战术配置
    ===============================================
--]]
Goal.Terminate = function (f3_arg0, f3_arg1, f3_arg2)
    -- 特殊动作终止时无需额外清理操作
    -- 子目标系统会自动处理状态清理
end

--[[
    特殊动作中断处理函数
    ===============================================
    处理路径失败等特殊中断情况。

    中断类型处理:
    - INTERUPT_MovedEnd_OnFailedPath: 移动路径失败中断

    响应策略:
    1. 清除当前所有子目标
    2. 添加路径失败等待目标
    3. 返回true表示成功处理中断

    设计意图:
    确保在复杂地形中移动失败时能够优雅地恢复，
    避免AI陷入无限循环或卡顿状态。
    ===============================================
--]]
Goal.Interrupt = function (f4_arg0, f4_arg1, f4_arg2)
    -- 检查移动路径失败中断
    if f4_arg1:IsInterupt(INTERUPT_MovedEnd_OnFailedPath) then
        -- 路径失败处理流程:
        f4_arg2:ClearSubGoal()  -- 1. 清除当前所有子目标
        -- 2. 添加路径失败等待目标 (0.5秒超时, 0.1秒等待)
        f4_arg2:AddSubGoal(GOAL_COMMON_Wait_On_FailedPath, 0.5, 0.1)
        return true  -- 3. 返回true表示成功处理中断
    end

    -- 其他类型的中断不予处理
    return false
end

--[[
    =============================================================================
    脚本总结与扩展建议
    =============================================================================

    核心特点:
    - 基于三角函数的几何计算系统
    - 多层次的空间感知与路径验证
    - 复杂的条件分支决策树
    - 智能的路径失败恢复机制

    算法优势:
    - 数学模型驱动的精确定位
    - 自适应的移动策略选择
    - 健壮的错误处理机制
    - 高度可配置的参数系统

    技术实现亮点:
    - 正弦定理的实际应用
    - 多重空间检测的安全保障
    - 目标切换的智能机制
    - 路径失败的自动恢复

    调试建议:
    1. 验证角度参数的合理性 (避免sin(0)等异常)
    2. 监控几何距离计算的精度
    3. 检查空间检测函数的返回值
    4. 观察路径失败的触发频率

    扩展开发建议:
    1. 添加更多几何算法支持 (余弦定理、向量计算等)
    2. 实现动态角度调整机制
    3. 支持多目标的优先级管理
    4. 增加地形适应性学习
    5. 实现战术模式的动态切换

    使用场景:
    - 复杂地形中的精确定位
    - 高度差较大环境的移动
    - 需要几何计算的战术行为
    - 特殊技能或能力的执行

    数学模型解释:
    距离 = 高度差 / sin(角度)
    这个公式计算的是在给定角度下，达到特定高度差所需的斜距。
    通过最大和最小角度计算出理想的距离范围，实现精确的战术定位。

    参数配置最佳实践:
    - 最大角度 > 最小角度
    - 角度范围: 建议 15-75 度
    - 步行模式: 根据敌人类型调整
    - 移动寿命: 平衡响应性与稳定性
    - 姿势偏移: 特殊技能相关配置
    =============================================================================
--]]


