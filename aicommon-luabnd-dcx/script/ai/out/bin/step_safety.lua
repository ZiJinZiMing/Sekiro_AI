--[[============================================================================
    step_safety.lua - AI安全闪避步法系统 (AI Safety Step System)

    功能概述 (Overview):
    - 实现基于环境安全性检测的智能闪避步法选择系统
    - 根据优先级和环境条件自动选择最佳闪避方向
    - 支持前后左右四个方向的闪避动作
    - 集成地面检测和障碍物检测的双重安全机制

    核心特性 (Core Features):
    - 优先级方向选择：根据四个方向的优先度智能排序
    - 安全性验证：地面存在性检测 + 障碍物检测
    - 灵活的失败处理：可配置无可执行闪避时的结果
    - SpinStep集成：使用旋转步法实现流畅闪避

    技术要点 (Technical Points):
    - 使用优先级排序算法确定尝试顺序
    - GetExistMeshOnLineDistEx进行精确地面检测
    - IsExistChrOnLineSpecifyAngle检测角色障碍物
    - 支持闪避前的预旋回时间配置

    应用场景 (Use Cases):
    - 战斗中的智能闪避决策
    - 复杂地形中的安全移动
    - 悬崖边缘的防坠落机制
    - 多敌人场景中的空间管理

    参数配置说明 (Parameter Configuration):
    - 参数0-3: 前后左右四个方向的优先度（数值越大优先级越高）
    - 参数4: 旋回目标（闪避时保持朝向的目标）
    - 参数5: 安全检查距离（地面和障碍物的检测距离）
    - 参数6: 闪避前旋回时间（预备动作时长）
    - 参数7: 无可执行闪避时是否视为成功
============================================================================]]

-- 注册为Table Goal类型，使用Goal.Activate等方法
RegisterTableGoal(GOAL_COMMON_StepSafety, "StepSafety")

-- 设置为无子目标类型，直接使用SpinStep作为执行器
REGISTER_GOAL_NO_SUB_GOAL(GOAL_COMMON_StepSafety, true)

-- 注册调试参数，保留原有日文注释便于开发调试
REGISTER_DBG_GOAL_PARAM(GOAL_COMMON_StepSafety, 0, "前ステップ優先度", 0)        -- 前方闪避优先度 (Forward step priority)
REGISTER_DBG_GOAL_PARAM(GOAL_COMMON_StepSafety, 1, "後ステップ優先度", 0)        -- 后方闪避优先度 (Backward step priority)
REGISTER_DBG_GOAL_PARAM(GOAL_COMMON_StepSafety, 2, "左ステップ優先度", 0)        -- 左侧闪避优先度 (Left step priority)
REGISTER_DBG_GOAL_PARAM(GOAL_COMMON_StepSafety, 3, "右ステップ優先度", 0)        -- 右侧闪避优先度 (Right step priority)
REGISTER_DBG_GOAL_PARAM(GOAL_COMMON_StepSafety, 4, "旋回対象", 0)                -- 旋回目标 (Turn target)
REGISTER_DBG_GOAL_PARAM(GOAL_COMMON_StepSafety, 5, "安全チェック距離", 0)        -- 安全检查距离 (Safety check distance)
REGISTER_DBG_GOAL_PARAM(GOAL_COMMON_StepSafety, 6, "ステップ前旋回時間", 0)      -- 闪避前旋回时间 (Pre-step turn time)
REGISTER_DBG_GOAL_PARAM(GOAL_COMMON_StepSafety, 7, "実行不可の時成功とみなすか", 0) -- 无法执行时是否视为成功 (Treat as success when not executable)

--[[============================================================================
    安全闪避激活函数 (Safety Step Activation Function)

    功能说明 (Function Description):
    - 初始化安全闪避系统，根据环境和优先级选择最佳闪避方向
    - 实现基于优先级的方向选择算法
    - 执行双重安全性检测：地面检测 + 障碍物检测
    - 成功找到安全方向时执行SpinStep闪避

    参数映射 (Parameter Mapping):
    - f1_arg0: AI角色对象 (AI character object)
    - f1_arg1: AI实体对象 (AI entity object)
    - f1_arg2: 目标参数对象 (Goal parameter object)

    算法流程 (Algorithm Flow):
    1. 初始化方向映射表和常量
    2. 构建基于优先级的方向排序列表
    3. 按优先级顺序检测每个方向的安全性
    4. 找到安全方向时添加SpinStep子目标并返回
    5. 无安全方向时设置失败标志

    核心数据结构 (Core Data Structures):
    - f1_local0: 优先级数组（排序后）
    - f1_local1: 方向索引数组（与优先级对应）
    - f1_local2: 闪避动画ID数组 {6000前, 6001后, 6002左, 6003右}
    - f1_local3: 方向类型数组 {前, 后, 左, 右}
    - f1_local4: 角度数组 {0°, 180°, -90°, 90°}
============================================================================]]
Goal.Activate = function (f1_arg0, f1_arg1, f1_arg2)
    -- === 第一阶段：数据结构初始化 (Phase 1: Data Structure Initialization) ===
    local f1_local0 = {}  -- 优先级值数组 (Priority value array)
    local f1_local1 = {}  -- 方向索引数组 (Direction index array)

    -- 闪避动画ID映射表：前、后、左、右四个方向的闪避动作
    -- Step animation ID mapping: forward, backward, left, right step actions
    local f1_local2 = {6000, 6001, 6002, 6003}

    -- 方向类型映射表：用于地面检测
    -- Direction type mapping: for ground detection
    local f1_local3 = {AI_DIR_TYPE_F, AI_DIR_TYPE_B, AI_DIR_TYPE_L, AI_DIR_TYPE_R}

    -- 角度映射表：用于障碍物检测（前0°、后180°、左-90°、右90°）
    -- Angle mapping: for obstacle detection (front 0°, back 180°, left -90°, right 90°)
    local f1_local4 = {0, 180, -90, 90}

    -- === 第二阶段：参数解析 (Phase 2: Parameter Parsing) ===
    local f1_local5 = table.getn(f1_local2)         -- 方向数量 = 4
    local f1_local6 = f1_arg2:GetParam(f1_local5)   -- 参数4: 旋回目标
    local f1_local7 = f1_arg2:GetParam(f1_local5 + 1)  -- 参数5: 安全检查距离
    local f1_local8 = f1_arg2:GetParam(f1_local5 + 2)  -- 参数6: 闪避前旋回时间
    local f1_local9 = f1_arg2:GetParam(f1_local5 + 3)  -- 参数7: 无法执行时是否成功标志

    -- === 第三阶段：优先级排序 (Phase 3: Priority Sorting) ===
    -- 构建按优先级排序的方向列表（从高到低）
    -- Build direction list sorted by priority (high to low)
    for f1_local10 = 0, f1_local5 - 1, 1 do  -- 遍历四个方向的优先度参数
        if f1_arg2:GetParam(f1_local10) >= 0 then  -- 优先度 >= 0 表示该方向可用
            -- 使用插入排序算法维护优先级顺序
            local f1_local13 = table.getn(f1_local0) + 1  -- 默认插入到末尾
            for f1_local14 = 1, f1_local13 - 1, 1 do
                if f1_local0[f1_local14] < f1_arg2:GetParam(f1_local10) then
                    f1_local13 = f1_local14  -- 找到插入位置（保持降序）
                    break
                end
            end
            table.insert(f1_local0, f1_local13, f1_arg2:GetParam(f1_local10))  -- 插入优先级值
            table.insert(f1_local1, f1_local13, f1_local10 + 1)  -- 插入方向索引（1-4）

        end
    end

    -- === 第四阶段：安全性检测和闪避执行 (Phase 4: Safety Detection and Step Execution) ===
    -- 按优先级顺序检测每个方向的安全性
    for f1_local10 = 1, table.getn(f1_local0), 1 do
        local f1_local13 = f1_local3[f1_local1[f1_local10]]  -- 获取当前方向类型
        local f1_local14 = f1_arg1:GetMapHitRadius(TARGET_SELF)  -- 获取碰撞半径

        -- 双重安全性检测：
        -- 1. GetExistMeshOnLineDistEx: 检测方向上的地面距离
        --    参数：起点, 方向, 检测距离+3米缓冲, 起点半径, 终点半径
        --    返回值：到地面边缘的距离
        -- 2. IsExistChrOnLineSpecifyAngle: 检测是否有角色障碍物
        --    参数：起点, 角度, 检测距离, 检测角度类型
        --    返回值：是否存在障碍物
        if f1_local7 <= f1_arg1:GetExistMeshOnLineDistEx(TARGET_SELF, f1_local13, f1_local7 + 3, f1_local14, f1_local14) and
           not f1_arg1:IsExistChrOnLineSpecifyAngle(TARGET_SELF, f1_local4[f1_local1[f1_local10]], f1_local7, AI_SPA_DIR_TYPE_TargetF) then

            -- 找到安全方向！设置成功标志
            f1_arg2:SetNumber(0, 0)  -- 0表示成功找到安全方向

            -- 添加旋转闪避步法子目标
            -- 参数：生命周期, 闪避动画ID, 旋回目标, 闪避前旋回时间, 朝向类型, 未知参数
            f1_arg2:AddSubGoal(GOAL_COMMON_SpinStep, f1_arg2:GetLife(), f1_local2[f1_local1[f1_local10]], f1_local6, f1_local8, AI_DIR_TYPE_B, -1)
            return  -- 成功添加闪避目标，结束函数
        end
    end

    -- === 第五阶段：失败处理 (Phase 5: Failure Handling) ===
    -- 所有方向都不安全，根据配置设置失败标志
    if f1_local9 == false then
        f1_arg2:SetNumber(0, 1)  -- 1表示无可用方向，失败状态
    end
    -- 如果f1_local9 == true，不设置失败标志，Update函数会返回Success

end

--[[============================================================================
    安全闪避更新函数 (Safety Step Update Function)

    功能说明 (Function Description):
    - 监控闪避执行状态
    - 根据Activate函数设置的标志判断最终结果
    - 返回相应的执行状态

    返回值 (Return Values):
    - GOAL_RESULT_Failed: 无安全方向可闪避且配置为失败
    - GOAL_RESULT_Success: 闪避完成或配置为总是成功
    - GOAL_RESULT_Continue: 闪避子目标仍在执行

    状态标志说明 (Status Flag Description):
    - Number(0) == 0: 成功找到安全方向并添加了闪避子目标
    - Number(0) == 1: 无安全方向且配置为返回失败
    - Number(0) 未设置: 无安全方向但配置为返回成功

    设计理念 (Design Philosophy):
    - 灵活的失败处理策略
    - 基于标志的状态传递
    - 简洁的状态判断逻辑
============================================================================]]
Goal.Update = function (f2_arg0, f2_arg1, f2_arg2)
    -- 检查闪避子目标是否执行完成
    if f2_arg2:GetSubGoalNum() <= 0 then
        -- 子目标已完成或未添加，检查状态标志
        if f2_arg2:GetNumber(0) == 1 then
            -- 标志1：无安全方向且配置为失败
            return GOAL_RESULT_Failed
        end
        -- 标志0或未设置：闪避成功完成或配置为总是成功
        return GOAL_RESULT_Success
    end

    -- 闪避子目标仍在执行中
    return GOAL_RESULT_Continue

end


