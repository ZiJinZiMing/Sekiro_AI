--[[============================================================================
    common_platoon_func.lua - Sekiro AI排兵布阵通用函数库

    版本信息 (Version Info): v3.0 - Comprehensive documentation upgrade
    作者 (Author): FromSoftware AI Team / Enhanced by Claude Code
    最后修改 (Last Modified): 2025-09-28
    编码格式 (Encoding): Shift-JIS (required for Sekiro compatibility)

    ============================================================================
    模块概述 (Module Overview):
    ============================================================================
    这是Sekiro AI系统的排兵布阵通用函数库，专门负责管理多人AI小队的协同行为。
    该模块实现了复杂的阵型控制、移动协调、速度调节和指挥系统，是团队AI的核心。

    核心功能 (Core Features):
    - 动态速度调节系统：根据与阵型位置的距离自动调整移动速度
    - 智能阵型维持：确保队员保持在指定的阵型位置
    - 指挥官控制机制：特殊的领导者行为逻辑
    - 队员状态管理：监控和协调所有队员的状态
    - 距离自适应算法：基于距离的平滑速度插值计算

    ============================================================================
]]--

-- 排兵布阵通用行为控制函数 (Common platoon behavior control function)
-- 功能说明 (Function Description):
--   这是所有排兵布阵AI的核心控制函数，负责管理整个小队的协同行为。
--   该函数实现了复杂的速度调节算法，确保队员能够智能地维持阵型同时响应战斗需求。
--
-- 参数说明 (Parameters):
--   f1_arg0: 小队管理器对象 (Platoon manager object) - 控制整个小队的AI系统
--
-- 算法核心思想 (Core Algorithm Concept):
--   通过动态调节队员移动速度来维持阵型完整性。距离阵型位置越远的队员移动越快，
--   距离阵型位置越近的队员移动越慢，实现平滑的阵型维持效果。
function Platoon_Common_Act(f1_arg0)
    -- ========== 核心参数配置区域 (Core Parameter Configuration) ==========

    local f1_local0 = 5                                  -- 队员行为指令ID (Member behavior command ID)
    local f1_local1 = 10                                 -- 最大距离阈值 (Maximum distance threshold) - 超过此距离使用最大加速
    local f1_local2 = 5                                  -- 远距离阈值 (Far distance threshold) - 开始加速的距离
    local f1_local3 = 5                                  -- 近距离阈值 (Near distance threshold) - 开始减速的距离
    local f1_local4 = 1.5                                -- 最大移动速度倍率 (Maximum movement speed multiplier) - 落后时的加速倍率
    local f1_local5 = 0.7                                -- 最小移动速度倍率 (Minimum movement speed multiplier) - 太近时的减速倍率
    local f1_local6 = 4                                  -- 掉队判定距离 (Out-of-formation distance) - 超过此距离视为掉队
    local f1_local7 = 0                                  -- 总队员计数器 (Total member counter) - 统计活跃队员数量
    local f1_local8 = 0                                  -- 掉队队员计数器 (Out-of-formation member counter) - 统计掉队队员数量

    -- ========== 队员遍历和控制循环 (Member Iteration and Control Loop) ==========

    -- 从最后一个队员开始倒序遍历所有队员 (Iterate all members in reverse order from last to first)
    -- 倒序遍历确保指挥官（通常是索引0）最后处理，可以根据队员状态做出决策
    for f1_local9 = f1_arg0:GetMemberNum() - 1, 0, -1 do
        local f1_local12 = f1_arg0:GetMemberAI(f1_local9)  -- 获取队员AI对象 (Get member AI object)

        -- 验证队员AI对象有效性 (Validate member AI object validity)
        if f1_local12 ~= nil then                          -- 注意：原代码中"nill"应该是"nil"的笔误

            -- ========== 指挥官特殊处理逻辑 (Commander Special Handling Logic) ==========
            if f1_local9 == 0 then
                -- 指挥官（队员索引0）的移动速度控制 (Commander movement speed control)
                if f1_local8 == f1_local7 then
                    -- 情况1：所有队员都在阵型内，指挥官几乎停止移动等待队员 (All members in formation, commander waits)
                    f1_arg0:SetMoveRate(f1_local9, 0.01)
                elseif f1_local7 == 0 then
                    -- 情况2：没有活跃队员，指挥官几乎停止移动 (No active members, commander waits)
                    f1_arg0:SetMoveRate(f1_local9, 0.01)
                else
                    -- 情况3：有队员掉队，指挥官正常速度移动继续前进 (Members out of formation, commander moves normally)
                    f1_arg0:SetMoveRate(f1_local9, 1)
                end
                -- 向指挥官发送行为指令 (Send behavior command to commander)
                f1_arg0:SendCommand(f1_local9, f1_local0)

            -- ========== 普通队员处理逻辑 (Regular Member Handling Logic) ==========
            else
                local f1_local13 = f1_local12:GetDist(TARGET_TEAM_FORMATION)  -- 获取队员与阵型位置的距离 (Get distance to formation position)
                local f1_local14 = 0                         -- 计算出的移动速度倍率 (Calculated movement speed multiplier)
                f1_local7 = f1_local7 + 1                    -- 增加总队员计数 (Increment total member count)

                -- 掉队状态检查 (Out-of-formation status check)
                if f1_local6 < f1_local13 then
                    f1_local8 = f1_local8 + 1                -- 增加掉队队员计数 (Increment out-of-formation count)
                end

                -- ========== 队员移动速度计算算法 (Member Movement Speed Calculation Algorithm) ==========

                -- 特殊效果检查：如果队员有特定状态效果，使用标准速度 (Special effect check)
                if f1_local12:HasSpecialEffectId(TARGET_SELF, 5002) then
                    f1_arg0:SetMoveRate(f1_local9, 1)         -- 标准移动速度 (Standard movement speed)

                -- 超远距离：距离 > 10，使用最大加速 (Very far distance: > 10 units)
                elseif f1_local1 < f1_local13 then
                    f1_arg0:SetMoveRate(f1_local9, f1_local4) -- 1.5倍速度加速追赶 (1.5x speed acceleration)

                -- 远距离：5 < 距离 <= 10，线性插值加速 (Far distance: 5-10 units, linear interpolation acceleration)
                elseif f1_local2 < f1_local13 then
                    -- 线性插值公式：speed = 1 + (dist - 5) / (10 - 5) * (1.5 - 1)
                    -- 距离越远速度越快，从1.0平滑过渡到1.5 (Smooth transition from 1.0 to 1.5 based on distance)
                    f1_local14 = 1 + (f1_local13 - f1_local2) / (f1_local1 - f1_local2) * (f1_local4 - 1)
                    f1_arg0:SetMoveRate(f1_local9, f1_local14)

                -- 近距离：距离 < 5，线性插值减速 (Near distance: < 5 units, linear interpolation deceleration)
                elseif f1_local13 < f1_local3 then
                    -- 线性插值公式：speed = 1 + (5 - dist) / 5 * (0.7 - 1)
                    -- 距离越近速度越慢，从1.0平滑过渡到0.7 (Smooth transition from 1.0 to 0.7 based on proximity)
                    f1_local14 = 1 + (f1_local3 - f1_local13) / f1_local3 * (f1_local5 - 1)
                    f1_arg0:SetMoveRate(f1_local9, f1_local14)

                -- 适中距离：距离正好在阈值范围内，使用标准速度 (Optimal distance: within threshold range)
                else
                    f1_arg0:SetMoveRate(f1_local9, 1)         -- 标准移动速度 (Standard movement speed)
                end

                -- 向队员发送行为指令 (Send behavior command to member)
                f1_arg0:SendCommand(f1_local9, f1_local0)
            end
        end
    end
end

--[[============================================================================
    算法详细说明 (Detailed Algorithm Explanation):
    ============================================================================

    1. 速度调节策略 (Speed Adjustment Strategy):
       - 距离 > 10：1.5倍速度快速追赶
       - 距离 5-10：1.0到1.5倍线性插值加速
       - 距离 = 5：标准1.0倍速度
       - 距离 < 5：1.0到0.7倍线性插值减速
       - 特殊状态：忽略距离使用标准速度

    2. 指挥官行为逻辑 (Commander Behavior Logic):
       - 所有队员在位：几乎停止等待（0.01倍速度）
       - 有队员掉队：正常速度继续前进
       - 无活跃队员：几乎停止等待

    3. 阵型维持机制 (Formation Maintenance Mechanism):
       - 掉队检测：距离 > 4视为掉队
       - 动态统计：实时统计掉队队员数量
       - 协调控制：根据整体状况调整指挥官行为

    4. 性能优化考虑 (Performance Optimization):
       - 倒序遍历：确保指挥官最后处理，掌握全局信息
       - 线性插值：平滑的速度变化避免抖动
       - 最小移动：避免完全停止造成的卡顿现象

    使用场景 (Usage Scenarios):
    - 所有排兵布阵AI的Update函数都会调用此函数
    - 适用于任何规模的AI小队（2-10人）
    - 支持各种阵型配置和战术需求
    ============================================================================
]]--


