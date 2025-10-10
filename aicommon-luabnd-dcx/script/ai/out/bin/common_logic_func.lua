--[[============================================================================
    common_logic_func.lua - Sekiro AI逻辑控制通用函数库

    版本信息 (Version Info): v3.0 - Comprehensive documentation upgrade
    作者 (Author): FromSoftware AI Team / Enhanced by Claude Code
    最后修改 (Last Modified): 2025-09-28
    编码格式 (Encoding): Shift-JIS (required for Sekiro compatibility)

    ============================================================================
    模块概述 (Module Overview):
    ============================================================================
    这是Sekiro AI系统的逻辑控制核心函数库，负责管理AI的状态转换、行为决策、
    目标识别、战斗逻辑等关键功能。该模块是AI大脑的核心组件，处理复杂的
    游戏逻辑和AI智能行为。

    核心功能模块 (Core Function Modules):
    ┌─ 高优先级设置系统 (High Priority Setup System)
    │  ├─ COMMON_HiPrioritySetup() - 特效监控和敌人状态检测
    │  └─ 关键游戏事件的实时监控和响应
    │
    ├─ AI状态控制系统 (AI State Control System)
    │  ├─ _COMMON_SetBattleActLogic() - 战斗逻辑设置
    │  ├─ _COMMON_AddBattleGoal() - 战斗目标添加
    │  └─ _COMMON_AddNonBattleGoal() - 非战斗目标添加
    │
    ├─ 状态转换管理 (State Transition Management)
    │  ├─ _COMMON_AddStateTransitionGoal() - 状态转换目标
    │  ├─ _COMMON_AddCautionAndFindGoal() - 警戒和搜索目标
    │  └─ 复杂的AI状态机控制
    │
    └─ 中断处理系统 (Interrupt Handling System)
       ├─ COMMON_Interrupt() - 通用中断处理
       └─ 路径失败和异常情况处理

    ============================================================================
]]--

-- AI高优先级设置和监控函数 (AI high priority setup and monitoring function)
-- 功能说明 (Function Description):
--   这是AI系统的核心初始化函数，负责设置重要的游戏状态监控和特效观察。
--   该函数会监控玩家的关键状态变化（如死亡、复活、隐身等）以及AI自身的状态，
--   确保AI能够及时响应关键游戏事件。
--
-- 参数说明 (Parameters):
--   f1_arg0: AI实体对象 (AI entity object) - 执行设置的AI角色
--   f1_arg1: AI标志参数 (AI flag parameter) - 用于特殊AI类型的标识
--
-- 返回值 (Return Value):
--   true:  AI需要进入特殊状态处理，暂停正常行为
--   false: AI可以继续正常的行为处理流程
--
-- 监控的特效类型 (Monitored Special Effect Types):
--   玩家相关 (Player-related):
--   - COMMON_SP_EFFECT_PC_DEAD: 玩家死亡状态
--   - COMMON_SP_EFFECT_PC_RETURN: 玩家回归状态
--   - COMMON_SP_EFFECT_PC_NINSATSU: 玩家忍杀状态
--   - COMMON_SP_EFFECT_PC_REVIVAL_AFTER_2/3: 玩家复活状态
--   - COMMON_SP_EFFECT_HIDE_IN_BLOOD: 血遁隐身状态
--   - COMMON_SP_EFFECT_PC_BREAK: 玩家架势破坏状态
--
--   AI自身相关 (AI Self-related):
--   - COMMON_SP_EFFECT_ENEMY_TURN: AI转身状态
--   - COMMON_SP_EFFECT_QUICK_TURN_TO_PC: 快速转向玩家
--   - COMMON_SP_EFFECT_BLOOD_SMOKE: 血雾效果
--   - COMMON_SP_EFFECT_CONFUSE: 混乱状态
--   - COMMON_SP_EFFECT_CONFUSE_GHOST: 幽灵混乱状态
function COMMON_HiPrioritySetup(f1_arg0, f1_arg1)
    -- ========== 玩家状态监控设置 (Player Status Monitoring Setup) ==========

    f1_arg0:AddObserveSpecialEffectAttribute(TARGET_ENE_0, COMMON_SP_EFFECT_PC_DEAD)           -- 监控玩家死亡状态
    f1_arg0:AddObserveSpecialEffectAttribute(TARGET_ENE_0, COMMON_SP_EFFECT_PC_RETURN)         -- 监控玩家回归状态
    f1_arg0:AddObserveSpecialEffectAttribute(TARGET_ENE_0, COMMON_SP_EFFECT_PC_NINSATSU)       -- 监控玩家忍杀状态
    f1_arg0:AddObserveSpecialEffectAttribute(TARGET_ENE_0, COMMON_SP_EFFECT_PC_REVIVAL_AFTER_2) -- 监控玩家2次复活后状态
    f1_arg0:AddObserveSpecialEffectAttribute(TARGET_ENE_0, COMMON_SP_EFFECT_PC_REVIVAL_AFTER_3) -- 监控玩家3次复活后状态
    f1_arg0:AddObserveSpecialEffectAttribute(TARGET_ENE_0, COMMON_SP_EFFECT_HIDE_IN_BLOOD)     -- 监控血遁隐身状态
    f1_arg0:AddObserveSpecialEffectAttribute(TARGET_ENE_0, COMMON_SP_EFFECT_PC_BREAK)          -- 监控玩家架势破坏状态

    -- ========== AI自身状态监控设置 (AI Self Status Monitoring Setup) ==========

    f1_arg0:AddObserveSpecialEffectAttribute(TARGET_SELF, COMMON_SP_EFFECT_ENEMY_TURN)         -- 监控AI转身状态
    f1_arg0:AddObserveSpecialEffectAttribute(TARGET_SELF, COMMON_SP_EFFECT_QUICK_TURN_TO_PC)   -- 监控快速转向玩家状态
    f1_arg0:AddObserveSpecialEffectAttribute(TARGET_SELF, COMMON_SP_EFFECT_BLOOD_SMOKE)        -- 监控血雾效果状态
    f1_arg0:AddObserveSpecialEffectAttribute(TARGET_SELF, COMMON_SP_EFFECT_CONFUSE)            -- 监控混乱状态
    f1_arg0:AddObserveSpecialEffectAttribute(TARGET_SELF, COMMON_SP_EFFECT_CONFUSE_GHOST)      -- 监控幽灵混乱状态
    -- ========== 观察槽清理和事件检查 (Observation Slot Cleanup and Event Check) ==========

    f1_arg0:DeleteObserve(COMMON_OBSERVE_SLOT_BATTLE_STEALTH)  -- 删除战斗潜行观察槽，重置潜行监控
    local f1_local0 = f1_arg0:GetEventRequest(2)               -- 获取事件请求2（距离相关事件）
    -- ========== 特殊状态检查和处理 (Special Status Check and Handling) ==========

    -- 检查玩家是否具有特殊保护状态或AI自身的特殊状态 (Check player special protection or AI special status)
    if not f1_arg0:HasSpecialEffectId(TARGET_ENE_0, 110010) or f1_arg0:HasSpecialEffectId(TARGET_SELF, 205090) or f1_arg0:HasSpecialEffectId(TARGET_SELF, 205091) then
        -- 正常情况，继续执行后续检查 (Normal situation, continue with subsequent checks)
    else
        -- 特殊情况：玩家处于保护状态，AI必须停止所有攻击性行为 (Special case: player protected, AI must stop all aggressive actions)
        f1_arg0:ClearEnemyTarget()            -- 清除敌人目标 (Clear enemy target)
        f1_arg0:ClearSoundTarget()            -- 清除声音目标 (Clear sound target)
        f1_arg0:ClearIndicationPosTarget()    -- 清除指示位置目标 (Clear indication position target)
        f1_arg0:ClearLastMemoryTargetPos()    -- 清除最后记忆目标位置 (Clear last memory target position)
        f1_arg0:AddTopGoal(GOAL_COMMON_Wait, 0.1, TARGET_SELF, 0, 0, 0)  -- 进入短暂等待状态 (Enter brief waiting state)
        return true                           -- 返回true，停止当前帧的进一步处理 (Return true, stop further processing this frame)
    end
    if f1_arg0:HasSpecialEffectId(TARGET_SELF, COMMON_SP_EFFECT_SMOKE_SCREEN) and f1_arg0:HasSpecialEffectId(TARGET_ENE_0, COMMON_SP_EFFECT_HIDE_IN_BUSH) and f1_arg0:IsVisibleCurrTarget() == false then
        if f1_arg0:HasSpecialEffectId(TARGET_SELF, COMMON_SP_EFFECT_ZAKO_REACTION) or f1_arg0:HasSpecialEffectId(TARGET_SELF, COMMON_SP_EFFECT_ZAKO_NOREACTION) then
            f1_arg0:ClearEnemyTarget()
            f1_arg0:ClearSoundTarget()
            f1_arg0:ClearIndicationPosTarget()
            f1_arg0:AddTopGoal(GOAL_COMMON_Wait, 0.1, TARGET_SELF, 0, 0, 0)
            return true
        elseif f1_arg0:HasSpecialEffectId(TARGET_SELF, COMMON_SP_EFFECT_CHUBOSS_REACTION) or f1_arg0:HasSpecialEffectId(TARGET_SELF, COMMON_SP_EFFECT_CHUBOSS_NOREACTION) then
            if f1_arg0:GetRandam_Int(1, 100) <= 50 then
                pcSearchAnim = 400600
            else
                pcSearchAnim = 400610
            end
            f1_arg0:AddTopGoal(GOAL_COMMON_WaitWithAnime, 30, pcSearchAnim, TARGET_SELF)
            f1_arg0:AddTopGoal(GOAL_COMMON_AttackTunableSpin, 10, 401040, TARGET_ENE_0, 9999, 0, 0, 0, 0)
            f1_arg0:AddObserveChrDmyArea(COMMON_OBSERVE_SLOT_BATTLE_STEALTH, TARGET_ENE_0, 7, 90, 120, 30, 4)
            return true
        end
    end
    if f1_local0 + 10 <= f1_arg0:GetDist(TARGET_ENE_0) and f1_local0 >= 0 and f1_arg0:GetCurrTargetType() ~= AI_TARGET_TYPE__NONE and f1_arg0:GetTopNormalEnemyForgettingTime() >= 5 then
        f1_arg0:ClearEnemyTarget()
        f1_arg0:ClearSoundTarget()
        f1_arg0:ClearIndicationPosTarget()
        f1_arg0:ClearLastMemoryTargetPos()
        f1_arg0:AddTopGoal(GOAL_COMMON_Wait, 0.1, TARGET_SELF, 0, 0, 0)
        return true
    end
    if not f1_arg0:IsCautionState() then
        f1_arg0:SetNumber(AI_NUMBER_LATEST_SOUND_ID, 0)
    end
    return false
    
end

-- AI简化设置函数版本3 (AI Easy Setup Function Version 3)
-- 功能说明 (Function Description):
--   这是一个简化的AI设置包装函数，为大多数普通AI提供标准的初始化配置。
--   该函数使用默认参数调用COMMON_EzSetup，简化了AI的初始化过程。
--
-- 参数说明 (Parameters):
--   f2_arg0: AI实体对象 (AI entity object) - 需要设置的AI角色
--
-- 使用场景 (Usage Scenarios):
--   - 普通敌人的标准初始化
--   - 不需要特殊配置的AI角色
--   - 快速原型开发和测试
function COMMON_EasySetup3(f2_arg0)
    local f2_local0 = 0                                  -- 使用默认参数值0 (Use default parameter value 0)
    COMMON_EzSetup(f2_arg0, f2_local0)                   -- 调用核心设置函数 (Call core setup function)
end

-- AI核心简化设置函数 (AI Core Easy Setup Function)
-- 功能说明 (Function Description):
--   这是AI系统的核心设置函数，负责处理AI的基本状态转换、战斗逻辑和特殊情况。
--   该函数按优先级处理不同类型的AI行为，确保AI能够正确响应游戏情况。
--
-- 参数说明 (Parameters):
--   f3_arg0: AI实体对象 (AI entity object) - 执行设置的AI角色
--   f3_arg1: AI类型标志 (AI type flag) - 用于区分不同AI类型的标识
--
-- 处理优先级 (Processing Priority):
--   1. 状态转换检查（最高优先级）
--   2. 战斗行为逻辑设置
--   3. 特殊情况处理（如梯子互动）
function COMMON_EzSetup(f3_arg0, f3_arg1)
    -- ========== 优先级检查：状态转换处理 (Priority Check: State Transition Handling) ==========

    -- 检查AI是否需要特殊状态转换处理 (Check if AI needs special state transition handling)
    -- 特效205050/205051：特殊限制状态，跳过状态转换检查
    if not f3_arg0:HasSpecialEffectId(TARGET_SELF, 205050) and not f3_arg0:HasSpecialEffectId(TARGET_SELF, 205051) and _COMMON_AddStateTransitionGoal(f3_arg0, f3_arg1) then
        return true                                       -- 状态转换成功，结束当前帧处理 (State transition successful, end current frame processing)
    end

    -- ========== 正常流程：设置战斗行为逻辑 (Normal Flow: Set Battle Action Logic) ==========

    _COMMON_SetBattleActLogic(f3_arg0, f3_arg1)          -- 调用战斗行为逻辑设置函数 (Call battle action logic setup function)

    -- ========== 特殊情况处理：梯子互动 (Special Case Handling: Ladder Interaction) ==========

    -- 检查AI是否正在与梯子互动且尚未设置梯子目标 (Check if AI is interacting with ladder and hasn't set ladder goal yet)
    if f3_arg0:IsLadderAct(TARGET_SELF) and not f3_arg0:HasGoal(GOAL_COMMON_LadderAct) then
        local f3_local0 = f3_arg0:GetTopGoal()           -- 获取当前顶层目标 (Get current top goal)
        if f3_local0 ~= nil then
            -- 在现有目标前面插入梯子目标 (Insert ladder goal before existing goal)
            f3_local0:AddSubGoal_Front(GOAL_COMMON_LadderAct, -1, 3000, TARGET_SELF, f3_arg0:GetLadderDirMove(TARGET_SELF))
        else
            -- 直接添加梯子目标为顶层目标 (Directly add ladder goal as top goal)
            f3_arg0:AddTopGoal(GOAL_COMMON_LadderAct, -1, 3000, TARGET_SELF, f3_arg0:GetLadderDirMove(TARGET_SELF))
        end
    end
end

-- AI战斗行为逻辑设置函数 (AI Battle Action Logic Setup Function)
-- 功能说明 (Function Description):
--   这是AI系统的核心决策函数，负责根据当前情况决定AI应该执行什么类型的行为。
--   该函数综合考虑距离、目标状态、团队协作等因素，智能选择战斗模式或非战斗模式。
--
-- 参数说明 (Parameters):
--   f4_arg0: AI实体对象 (AI entity object) - 执行决策的AI角色
--   f4_arg1: AI类型标志 (AI type flag) - 用于特殊AI类型的标识
--
-- 决策逻辑流程 (Decision Logic Flow):
--   1. 团队协作优先：检查是否需要回应队友求助
--   2. 强制战斗检查：处理被强制进入战斗的情况
--   3. 目标搜索状态：根据是否发现目标选择行为模式
--   4. 距离评估决策：基于与目标的距离选择合适的行为
--
-- 返回值 (Return Value):
--   true:  成功设置了AI行为目标
--   false: 未能设置有效的行为目标（异常情况）
function _COMMON_SetBattleActLogic(f4_arg0, f4_arg1)
    -- ========== 参数获取和初始化 (Parameter Acquisition and Initialization) ==========

    local f4_local0 = f4_arg0:GetExcelParam(AI_EXCEL_THINK_PARAM_TYPE__maxBackhomeDist)        -- 最大返回距离阈值
    local f4_local1 = f4_arg0:GetExcelParam(AI_EXCEL_THINK_PARAM_TYPE__backhomeDist)           -- 标准返回距离阈值
    local f4_local2 = f4_arg0:GetExcelParam(AI_EXCEL_THINK_PARAM_TYPE__backhomeBattleDist)     -- 返回路径上的战斗距离阈值
    local f4_local3 = f4_arg0:GetExcelParam(AI_EXCEL_THINK_PARAM_TYPE__nonBattleActLife)       -- 非战斗行为持续时间
    local f4_local4 = f4_arg0:GetExcelParam(AI_EXCEL_THINK_PARAM_TYPE__callHelp_ForgetTimeByArrival)  -- 团队求助响应时间
    local f4_local5 = f4_arg0:IsSearchTarget(TARGET_ENE_0)                                     -- 是否正在搜索目标
    local f4_local6 = f4_arg0:GetMovePointEffectRange()                                        -- 移动点影响范围
    local f4_local7 = f4_arg0:GetDist(TARGET_ENE_0)                                            -- 与主要敌人的距离

    -- ========== 决策分支1：团队协作优先 (Decision Branch 1: Team Cooperation Priority) ==========

    if f4_arg0:TeamHelp_IsValidReply() then
        -- 有队友需要帮助，立即响应求助请求 (Teammate needs help, immediately respond to help request)
        f4_arg0:AddTopGoal(GOAL_COMMON_TeamReplyHelp, f4_local4)
        return true

    -- ========== 决策分支2：强制战斗模式 (Decision Branch 2: Forced Battle Mode) ==========

    elseif f4_arg0:IsForceBattleGoal() then
        -- AI被强制进入战斗状态（通常由脚本或特殊事件触发）
        f4_arg0:ClearForceBattleGoal()                    -- 清除强制战斗标志
        f4_arg0:ReqPlatoonState(PLATOON_STATE_Battle)     -- 请求小队进入战斗状态
        _COMMON_AddBattleGoal(f4_arg0, f4_arg1)           -- 添加战斗目标
        return true

    -- ========== 决策分支3：目标搜索状态分析 (Decision Branch 3: Target Search Status Analysis) ==========

    elseif f4_local5 == true then
        -- AI已经发现了目标，需要根据距离决定行为模式 (AI has found target, decide behavior based on distance)

        if f4_local0 < f4_local6 then
            -- 情况3.1：距离过远，超出最大追击范围 (Case 3.1: Too far, beyond maximum pursuit range)
            -- 执行非战斗行为，返回初始位置或巡逻 (Execute non-battle behavior, return to initial position or patrol)
            _COMMON_AddNonBattleGoal(f4_arg0, f4_local3, -1, false)
            return true

        elseif f4_local1 < f4_local6 then
            -- 情况3.2：距离适中，在追击范围内但需要进一步判断 (Case 3.2: Moderate distance, within pursuit range but needs further judgment)

            if f4_local7 < f4_local2 then
                -- 子情况3.2.1：敌人足够近，可以直接战斗 (Sub-case 3.2.1: Enemy close enough for direct combat)
                f4_arg0:ReqPlatoonState(PLATOON_STATE_Battle)     -- 请求小队进入战斗状态
                _COMMON_AddBattleGoal(f4_arg0, f4_arg1)           -- 添加战斗目标
                return true
            else
                -- 子情况3.2.2：敌人较远，执行受限的非战斗行为 (Sub-case 3.2.2: Enemy farther, execute limited non-battle behavior)
                _COMMON_AddNonBattleGoal(f4_arg0, f4_local3, f4_local2, false)
                return true
            end

        else
            -- 情况3.3：距离很近，立即进入战斗 (Case 3.3: Very close distance, immediately enter combat)
            _COMMON_AddBattleGoal(f4_arg0, f4_arg1)
            return true
        end

    -- ========== 决策分支4：未发现目标的默认行为 (Decision Branch 4: Default Behavior When No Target Found) ==========

    else
        -- AI未发现任何目标，执行默认的非战斗行为 (AI hasn't found any target, execute default non-battle behavior)
        -- 通常为巡逻、返回初始位置或待机 (Usually patrol, return to initial position, or standby)
        _COMMON_AddNonBattleGoal(f4_arg0, -1, -1, true)
        return true
    end

    -- ========== 异常情况 (Exception Case) ==========
    -- 正常情况下不应该执行到这里 (Should not reach here under normal circumstances)
    return false
end

function _COMMON_AddBattleGoal(f5_arg0, f5_arg1)
    local f5_local0 = f5_arg0:GetPrevTargetState()
    local f5_local1 = f5_arg0:GetCurrTargetType()
    local f5_local2 = 0
    if f5_arg0:IsFindState() or f5_arg0:IsBattleState() then
        if f5_arg0:GetNumber(AI_NUMBER_BLOOD_SMOKE_BLINDNESS) == 1 and f5_arg0:HasSpecialEffectId(TARGET_SELF, COMMON_SP_EFFECT_CHUBOSS_REACTION) then
            local f5_local3 = f5_arg0:GetRandam_Int(1, 100)
            if f5_local3 <= 50 then
                pcSearchAnim = 400600
            else
                pcSearchAnim = 400610
            end
            f5_arg0:AddTopGoal(GOAL_COMMON_WaitWithAnime, 30, pcSearchAnim, TARGET_SELF):TimingSetNumber(AI_NUMBER_BLOOD_SMOKE_BLINDNESS, 0, AI_TIMING_SET__ACTIVATE)
            f5_arg0:AddTopGoal(GOAL_COMMON_AttackTunableSpin, 10, 401040, TARGET_ENE_0, 9999, 0, 0, 0, 0)
            f5_arg0:AddObserveChrDmyArea(COMMON_OBSERVE_SLOT_BATTLE_STEALTH, TARGET_ENE_0, 7, 90, 120, 30, 4)
        elseif f5_arg0:IsBattleState() or f5_arg0:HasSpecialEffectId(TARGET_SELF, 220020) then
            f5_arg0:ReqPlatoonState(PLATOON_STATE_Battle)
            _COMMON_SetBattleGoal(f5_arg0)
        elseif f5_arg0:IsFindState() then
            f5_arg0:ReqPlatoonState(PLATOON_STATE_Find)
            f5_local2 = 2
            _COMMON_AddCautionAndFindGoal(f5_arg0, f5_local2, f5_arg1)
        end
    elseif f5_arg0:IsCautionState() then
        if f5_local1 == AI_TARGET_TYPE__MEMORY_ENEMY then
            f5_local2 = 0
            _COMMON_AddCautionAndFindGoal(f5_arg0, f5_local2, f5_arg1)
        elseif f5_local1 == AI_TARGET_TYPE__SOUND then
            f5_arg0:ReqPlatoonState(PLATOON_STATE_Caution)
            f5_local2 = 1
            _COMMON_AddCautionAndFindGoal(f5_arg0, f5_local2, f5_arg1)
        elseif f5_local1 == AI_TARGET_TYPE__CORPSE_POS then
            f5_arg0:ReqPlatoonState(PLATOON_STATE_Caution)
            f5_local2 = 4
            _COMMON_AddCautionAndFindGoal(f5_arg0, f5_local2, f5_arg1)
        else
            f5_arg0:ReqPlatoonState(PLATOON_STATE_Caution)
            f5_local2 = 3
            _COMMON_AddCautionAndFindGoal(f5_arg0, f5_local2, f5_arg1)
        end
    else
        _COMMON_AddNonBattleGoal(f5_arg0, 10, -1, true)
    end
    f5_arg0:SetNumber(AI_NUMBER_LATEST_ACTION, COMMON_LATEST_ACTION_BATTLEGOAL)
    
end

function _COMMON_AddChangeStateActionGoal(f6_arg0, f6_arg1)
    
end

function _COMMON_AddCautionAndFindGoal(f7_arg0, f7_arg1, f7_arg2)
    local f7_local0 = f7_arg0:GetExcelParam(AI_EXCEL_THINK_PARAM_TYPE__goalAction_ToCaution)
    local f7_local1 = f7_arg0:GetExcelParam(AI_EXCEL_THINK_PARAM_TYPE__goalAction_ToCautionImportant)
    local f7_local2 = f7_arg0:GetExcelParam(AI_EXCEL_THINK_PARAM_TYPE__goalAction_ToCautionCorpseTarget)
    local f7_local3 = f7_arg0:GetExcelParam(AI_EXCEL_THINK_PARAM_TYPE__goalAction_ToFind)
    local f7_local4 = f7_arg0:GetExcelParam(AI_EXCEL_THINK_PARAM_TYPE__goalAction_ToDisappear)
    local f7_local5 = f7_arg0:GetExcelParam(AI_EXCEL_THINK_PARAM_TYPE__goalAction_ToCautionIndicationTarget)
    local f7_local6 = f7_arg0:GetExcelParam(AI_EXCEL_THINK_PARAM_TYPE__maxBackhomeDist)
    local f7_local7 = f7_arg0:GetMovePointEffectRange()
    local f7_local8 = 0
    local f7_local9 = 1
    local f7_local10 = 2
    local f7_local11 = 3
    local f7_local12 = 4
    local f7_local13 = 5
    local f7_local14 = 0
    local f7_local15 = -1
    local f7_local16 = f7_arg0:GetDist(TARGET_ENE_0)
    local f7_local17 = 2.5
    local f7_local18 = f7_arg0:GetLatestSoundTargetRank()
    local f7_local19 = f7_arg0:GetRandam_Int(1, 100)
    if f7_arg1 == 0 then
        f7_local14 = f7_local4
    elseif f7_arg1 == 1 and f7_local18 == AI_SOUND_RANK__IMPORTANT then
        f7_local14 = f7_local1
    elseif f7_arg1 == 1 then
        f7_local14 = f7_local0
    elseif f7_arg1 == 2 then
        f7_local14 = f7_local3
    elseif f7_arg1 == 3 then
        f7_local14 = f7_local5
    elseif f7_arg1 == 4 then
        f7_local14 = f7_local2
    end
    if f7_arg0:HasSpecialEffectId(TARGET_SELF, 205050) or f7_arg0:HasSpecialEffectId(TARGET_SELF, 205051) then
        if f7_arg0:IsFindState() then
            _COMMON_SetBattleGoal(f7_arg0)
        else
            _COMMON_AddNonBattleGoal(f7_arg0, 3, -1, false)
        end
    end
    if f7_arg0:IsFindState() then
        if f7_local14 == f7_local9 then
            f7_arg0:AddTopGoal(GOAL_COMMON_Turn, 3, TARGET_ENE_0, 40, -1, GOAL_RESULT_Success, true)
            f7_arg0:AddTopGoal(GOAL_COMMON_Stay, 1, 0, TARGET_ENE_0)
        elseif f7_local14 == f7_local10 then
            if f7_arg0:CheckDoesExistPathWithSetPoint(TARGET_ENE_0, AI_DIR_TYPE_F, 0, 0) == false then
                if SpaceCheck(f7_arg0, goal, 0, 3) == true then
                    f7_arg0:AddTopGoal(GOAL_COMMON_ApproachTarget, 5, POINT_UnreachTerminate, f7_local17, TARGET_SELF, true, -1)
                elseif f7_arg0:IsInsideTarget(TARGET_ENE_0, AI_DIR_TYPE_F, 90) then
                    f7_arg0:AddTopGoal(GOAL_COMMON_Stay, 1, 0, TARGET_ENE_0)
                else
                    f7_arg0:AddTopGoal(GOAL_COMMON_Turn, 3, TARGET_ENE_0, 40, -1, GOAL_RESULT_Success, true)
                end
            elseif f7_local17 + 0.5 < f7_local16 then
                f7_arg0:AddTopGoal(GOAL_COMMON_Turn, 3, TARGET_ENE_0, 40, -1, GOAL_RESULT_Success, true)
                if not f7_arg0:HasSpecialEffectId(TARGET_SELF, 220010) and not f7_arg0:HasSpecialEffectId(TARGET_SELF, 220011) then
                    f7_arg0:AddTopGoal(GOAL_COMMON_MoveToSomewhere, f7_local15, TARGET_ENE_0, AI_DIR_TYPE_CENTER, f7_local17, TARGET_SELF, true)
                    if false then
                    end
                end
            end
        elseif f7_local14 == f7_local11 then
            if f7_arg0:CheckDoesExistPathWithSetPoint(TARGET_ENE_0, AI_DIR_TYPE_F, 0, 0) == false then
                if SpaceCheck(f7_arg0, goal, 0, 4) == true then
                    local f7_local20 = false
                    if f7_arg0:IsInsideTargetRegion(TARGET_SELF, COMMON_REGION_FORCE_WALK_M11_0) then
                        f7_local20 = true
                    end
                    f7_arg0:AddTopGoal(GOAL_COMMON_ApproachTarget, 5, POINT_UnreachTerminate, f7_local17, TARGET_SELF, f7_local20, -1)
                elseif SpaceCheck(f7_arg0, goal, 0, 3) == true then
                    f7_arg0:AddTopGoal(GOAL_COMMON_ApproachTarget, 5, POINT_UnreachTerminate, f7_local17, TARGET_SELF, true, -1)
                elseif f7_arg0:IsInsideTarget(TARGET_ENE_0, AI_DIR_TYPE_F, 90) then
                    f7_arg0:AddTopGoal(GOAL_COMMON_Stay, 1, 0, TARGET_ENE_0)
                else
                    f7_arg0:AddTopGoal(GOAL_COMMON_Turn, 3, TARGET_ENE_0, 40, -1, GOAL_RESULT_Success, true)
                end
            elseif f7_local17 + 0.5 < f7_local16 and not f7_arg0:HasSpecialEffectId(TARGET_SELF, 220010) and not f7_arg0:HasSpecialEffectId(TARGET_SELF, 220011) then
                local f7_local20 = false
                if f7_arg0:IsInsideTargetRegion(TARGET_SELF, COMMON_REGION_FORCE_WALK_M11_0) then
                    f7_local20 = true
                end
                f7_arg0:AddTopGoal(GOAL_COMMON_MoveToSomewhere, f7_local15, TARGET_ENE_0, AI_DIR_TYPE_CENTER, f7_local17, TARGET_SELF, f7_local20)
                if false then
                end
            end
        elseif f7_local14 == f7_local12 then
            f7_arg0:AddTopGoal(GOAL_COMMON_Stay, 1, 0, TARGET_ENE_0)
        elseif f7_local14 == f7_local13 then
            if f7_local17 <= f7_local16 then
                f7_arg0:AddTopGoal(GOAL_COMMON_Stay, 1, 0, TARGET_ENE_0)
            elseif f7_local17 / 2 <= f7_local16 then
                f7_arg0:AddTopGoal(GOAL_COMMON_LeaveTarget, f7_local15, TARGET_ENE_0, f7_local17, TARGET_ENE_0, true, -1)
            else
                f7_arg0:AddTopGoal(GOAL_COMMON_LeaveTarget, f7_local15, TARGET_ENE_0, f7_local17, TARGET_SELF, false, -1)
            end
        else
            _COMMON_AddNonBattleGoal(f7_arg0, 1, -1, false)
        end
    else
        if f7_arg1 == 1 then
            if f7_arg0:GetLatestSoundTargetID() == 7900 or f7_arg0:GetLatestSoundTargetID() == 7910 then
                f7_local17 = 0.4
            elseif f7_arg0:GetLatestSoundTargetID() == 3501 then
                f7_local17 = 0.2
            end
        end
        local f7_local20 = 600
        if f7_arg0:HasSpecialEffectId(TARGET_SELF, 200004) or f7_arg0:HasSpecialEffectId(TARGET_SELF, 200002) then
            if f7_local19 <= 50 then
                f7_local20 = 400600
            else
                f7_local20 = 400610
            end
        elseif f7_local19 <= 50 then
            f7_local20 = 610
        end
        f7_arg0:RegisterTriggerRegionObserver(1000)
        if f7_arg0:GetNumber(AI_NUMBER_LATEST_ACTION) == COMMON_LATEST_ACTION_NONBATTLEGOAL_BATTLE then
            f7_arg0:AddTopGoal(GOAL_COMMON_ConfirmCautionTarget, 30, f7_local20, TARGET_SELF, f7_arg0:GetRandam_Float(4, 6), TARGET_SELF)
        elseif f7_arg0:GetCurrTargetType() == AI_TARGET_TYPE__SOUND and f7_arg0:GetLatestSoundTargetID() == 7700 then
            f7_arg0:AddTopGoal(GOAL_COMMON_ConfirmCautionTarget, 30, f7_local20, TARGET_SELF, f7_arg0:GetRandam_Float(4, 6), TARGET_SELF)
        elseif f7_local14 == f7_local9 then
            f7_arg0:AddTopGoal(GOAL_COMMON_Turn, 3, TARGET_ENE_0, 40, -1, GOAL_RESULT_Success, true)
            f7_arg0:AddTopGoal(GOAL_COMMON_ConfirmCautionTarget, 30, f7_local20, TARGET_SELF, f7_arg0:GetRandam_Float(6, 7), TARGET_SELF)
        elseif f7_local14 == f7_local10 then
            if f7_arg0:CheckDoesExistPathWithSetPoint(TARGET_ENE_0, AI_DIR_TYPE_F, 0, 0) == false then
                if f7_arg1 == 0 then
                    local f7_local21 = f7_arg0:GetDist_Point(POINT_INITIAL)
                    if f7_local17 + 0.5 < f7_local21 then
                        f7_arg0:AddTopGoal(GOAL_COMMON_MoveToSomewhere, -1, POINT_INITIAL, AI_DIR_TYPE_CENTER, f7_local17, TARGET_ENE_0, false)
                    else
                        f7_arg0:AddTopGoal(GOAL_COMMON_ConfirmCautionTarget, 30, f7_local20, TARGET_SELF, f7_arg0:GetRandam_Float(3, 4), TARGET_SELF)
                    end
                else
                    f7_arg0:AddTopGoal(GOAL_COMMON_YousumiAct, 10, false, 60, 30, -1)
                    f7_arg0:AddTopGoal(GOAL_COMMON_Turn, 3, TARGET_ENE_0, 40, -1, GOAL_RESULT_Success, true)
                    f7_arg0:AddTopGoal(GOAL_COMMON_ConfirmCautionTarget, 30, f7_local20, TARGET_SELF, f7_arg0:GetRandam_Float(3, 4), TARGET_SELF)
                end
            elseif f7_local17 + 0.5 < f7_local16 then
                if not f7_arg0:HasSpecialEffectId(TARGET_SELF, 220010) and not f7_arg0:HasSpecialEffectId(TARGET_SELF, 220011) then
                    f7_arg0:AddTopGoal(GOAL_COMMON_MoveToSomewhere, f7_local15, TARGET_ENE_0, AI_DIR_TYPE_CENTER, f7_local17, TARGET_SELF, true)
                else
                    f7_arg0:AddTopGoal(GOAL_COMMON_ConfirmCautionTarget, 30, f7_local20, TARGET_SELF, f7_arg0:GetRandam_Float(7, 8), TARGET_SELF)
                end
            else
                f7_arg0:RegisterTriggerRegion(1000, f7_arg0:GetLatestSoundTargetInstanceID(), 5, 5, TARGET_SELF, AI_DIR_TYPE_F, 0)
                f7_arg0:AddTopGoal(GOAL_COMMON_Turn, 3, TARGET_ENE_0, 40, -1, GOAL_RESULT_Success, true)
                f7_arg0:AddTopGoal(GOAL_COMMON_ConfirmCautionTarget, 30, f7_local20, TARGET_SELF, f7_arg0:GetRandam_Float(3, 4), TARGET_SELF)
            end
        elseif f7_local14 == f7_local11 then
            if f7_arg0:CheckDoesExistPathWithSetPoint(TARGET_ENE_0, AI_DIR_TYPE_F, 0, 0) == false then
                if f7_arg1 == 0 then
                    local f7_local21 = f7_arg0:GetDist_Point(POINT_INITIAL)
                    if f7_local17 + 0.5 < f7_local21 then
                        f7_arg0:AddTopGoal(GOAL_COMMON_MoveToSomewhere, -1, POINT_INITIAL, AI_DIR_TYPE_CENTER, f7_local17, TARGET_ENE_0, false)
                    else
                        f7_arg0:AddTopGoal(GOAL_COMMON_ConfirmCautionTarget, 30, f7_local20, TARGET_SELF, f7_arg0:GetRandam_Float(3, 4), TARGET_SELF)
                    end
                else
                    f7_arg0:AddTopGoal(GOAL_COMMON_YousumiAct, 10, false, 60, 30, -1)
                    f7_arg0:AddTopGoal(GOAL_COMMON_Turn, 3, TARGET_ENE_0, 40, -1, GOAL_RESULT_Success, true)
                    f7_arg0:AddTopGoal(GOAL_COMMON_ConfirmCautionTarget, 30, f7_local20, TARGET_SELF, f7_arg0:GetRandam_Float(3, 4), TARGET_SELF)
                end
            elseif f7_local17 + 0.5 < f7_local16 then
                if not f7_arg0:HasSpecialEffectId(TARGET_SELF, 220010) and not f7_arg0:HasSpecialEffectId(TARGET_SELF, 220011) then
                    local f7_local21 = false
                    if f7_arg0:IsInsideTargetRegion(TARGET_SELF, COMMON_REGION_FORCE_WALK_M11_0) then
                        f7_local21 = true
                    end
                    f7_arg0:AddTopGoal(GOAL_COMMON_MoveToSomewhere, f7_local15, TARGET_ENE_0, AI_DIR_TYPE_CENTER, f7_local17, TARGET_SELF, f7_local21)
                else
                    f7_arg0:AddTopGoal(GOAL_COMMON_ConfirmCautionTarget, 30, f7_local20, TARGET_SELF, f7_arg0:GetRandam_Float(3, 4), TARGET_SELF)
                end
            else
                f7_arg0:RegisterTriggerRegion(1000, f7_arg0:GetLatestSoundTargetInstanceID(), 5, 5, TARGET_SELF, AI_DIR_TYPE_F, 0)
                f7_arg0:AddTopGoal(GOAL_COMMON_Turn, 3, TARGET_ENE_0, 40, -1, GOAL_RESULT_Success, true)
                f7_arg0:AddTopGoal(GOAL_COMMON_ConfirmCautionTarget, 30, f7_local20, TARGET_SELF, f7_arg0:GetRandam_Float(3, 4), TARGET_SELF)
            end
        elseif f7_local14 == f7_local12 then
            f7_arg0:AddTopGoal(GOAL_COMMON_Turn, 3, TARGET_ENE_0, 40, -1, GOAL_RESULT_Success, true)
            f7_arg0:AddTopGoal(GOAL_COMMON_ConfirmCautionTarget, 30, f7_local20, TARGET_SELF, f7_arg0:GetRandam_Float(6, 7), TARGET_SELF)
        elseif f7_local14 == f7_local13 then
            if f7_local17 <= f7_local16 then
                f7_arg0:AddTopGoal(GOAL_COMMON_ConfirmCautionTarget, 30, f7_local20, TARGET_SELF, f7_arg0:GetRandam_Float(3, 4), TARGET_SELF)
            elseif f7_local17 / 2 <= f7_local16 then
                f7_arg0:AddTopGoal(GOAL_COMMON_LeaveTarget, f7_local15, TARGET_ENE_0, f7_local17, TARGET_ENE_0, true, -1)
            else
                f7_arg0:AddTopGoal(GOAL_COMMON_LeaveTarget, f7_local15, TARGET_ENE_0, f7_local17, TARGET_SELF, false, -1)
            end
        else
            f7_arg0:AddTopGoal(GOAL_COMMON_Turn, 3, TARGET_ENE_0, 40, -1, GOAL_RESULT_Success, true)
            f7_arg0:AddTopGoal(GOAL_COMMON_ConfirmCautionTarget, 30, f7_local20, TARGET_SELF, f7_arg0:GetRandam_Float(6, 7), TARGET_SELF)
        end
    end
    
end

function _COMMON_AddNonBattleGoal(f8_arg0, f8_arg1, f8_arg2, f8_arg3)
    f8_arg0:TeamHelp_ValidateCall()
    f8_arg0:TeamHelp_ValidateReply()
    local f8_local0 = -1
    if f8_arg0:HasSpecialEffectId(TARGET_SELF, 205100) or f8_arg0:HasSpecialEffectId(TARGET_SELF, 205101) then
        f8_local0 = 9920
    end
    f8_arg0:AddTopGoal(GOAL_COMMON_NonBattleAct, f8_arg1, f8_arg2, f8_arg3, false, POINT_INIT_POSE, 0, 0, f8_local0)
    if f8_arg0:IsBattleState() or f8_arg0:IsFindState() or f8_arg0:IsCautionState() then
        f8_arg0:SetNumber(AI_NUMBER_LATEST_ACTION, COMMON_LATEST_ACTION_NONBATTLEGOAL_BATTLE)
    else
        f8_arg0:SetNumber(AI_NUMBER_LATEST_ACTION, COMMON_LATEST_ACTION_NONBATTLEGOAL_NON)
    end
    
end

function _COMMON_AddStateTransitionGoal(f9_arg0, f9_arg1)
    if f9_arg0:HasSpecialEffectId(TARGET_SELF, 205080) and f9_arg0:HasSpecialEffectId(TARGET_SELF, 205081) then
        return false
    end
    local f9_local0 = f9_arg0:IsSearchTarget(TARGET_ENE_0)
    local f9_local1 = f9_arg0:GetPrevTargetState()
    local f9_local2 = f9_arg0:GetCurrTargetType()
    if f9_arg1 == COMMON_FLAG_BOSS then
    elseif f9_arg0:IsFindState() or f9_arg0:IsBattleState() then
        f9_arg0:ClearSoundTarget()
        f9_arg0:ClearIndicationPosTarget()
        if f9_arg0:HasSpecialEffectId(TARGET_SELF, 200004) then
            if f9_arg0:IsChangeState() and f9_arg0:GetPrevTargetState() ~= AI_TARGET_STATE__FIND then
                f9_arg0:AddTopGoal(GOAL_COMMON_AttackTunableSpin, 10, 401040, TARGET_ENE_0, 9999, 0, 0, 0, 0)
                return true
            end
        elseif f9_arg0:HasSpecialEffectId(TARGET_SELF, 200002) then
            if f9_arg0:HasSpecialEffectId(TARGET_SELF, 220070) and f9_arg0:IsVisibleCurrTarget() == false then
                if not f9_arg0:IsInsideTarget(TARGET_ENE_0, AI_DIR_TYPE_F, 90) then
                    f9_arg0:AddTopGoal(GOAL_COMMON_Turn, 3, TARGET_ENE_0, 40, -1, GOAL_RESULT_Success, true)
                else
                    f9_arg0:AddTopGoal(GOAL_COMMON_ClearTarget, 3, AI_TARGET_TYPE__NORMAL_ENEMY)
                end
            else
                f9_arg0:AddTopGoal(GOAL_COMMON_AttackTunableSpin, 10, 201040, TARGET_ENE_0, 9999, 0, 0, 0, 0)
            end
            return true
        elseif f9_arg0:HasSpecialEffectId(TARGET_SELF, 200001) then
            if f9_arg0:HasSpecialEffectId(TARGET_SELF, 220070) and f9_arg0:IsVisibleCurrTarget() == false then
                if not f9_arg0:IsInsideTarget(TARGET_ENE_0, AI_DIR_TYPE_F, 90) then
                    f9_arg0:AddTopGoal(GOAL_COMMON_Turn, 3, TARGET_ENE_0, 40, -1, GOAL_RESULT_Success, true)
                else
                    f9_arg0:AddTopGoal(GOAL_COMMON_EndureAttack, 10, 101040, TARGET_ENE_0, 9999, 0, 0, 0, 0)
                    f9_arg0:AddTopGoal(GOAL_COMMON_ClearTarget, 3, AI_TARGET_TYPE__NORMAL_ENEMY)
                end
            else
                f9_arg0:AddTopGoal(GOAL_COMMON_EndureAttack, 10, 101040, TARGET_ENE_0, 9999, 0, 0, 0, 0)
            end
            return true
        else
            f9_arg0:AddTopGoal(GOAL_COMMON_EndureAttack, 10, 1040, TARGET_ENE_0, 9999, 0, 0, 0, 0)
            return true
        end
    elseif f9_arg0:IsCautionState() then
        if f9_local2 == AI_TARGET_TYPE__MEMORY_ENEMY then
            if f9_arg0:HasSpecialEffectId(TARGET_SELF, 200004) then
                f9_arg0:AddTopGoal(GOAL_COMMON_AttackTunableSpin, 10, 401020, TARGET_ENE_0, 9999, 0, 0, 0, 0)
                return true
            elseif f9_arg0:HasSpecialEffectId(TARGET_SELF, 200002) or f9_arg0:HasSpecialEffectId(TARGET_SELF, 200001) then
            else
                f9_arg0:AddTopGoal(GOAL_COMMON_EndureAttack, 10, 1010, TARGET_ENE_0, 9999, 0, 0, 0, 0)
                return true
            end
        elseif f9_local2 == AI_TARGET_TYPE__SOUND then
            if f9_arg0:HasSpecialEffectId(TARGET_SELF, 200004) then
                f9_arg0:AddTopGoal(GOAL_COMMON_AttackTunableSpin, 10, 401020, TARGET_ENE_0, 9999, 0, 0, 0, 0)
                return true
            elseif f9_arg0:HasSpecialEffectId(TARGET_SELF, 200002) or f9_arg0:HasSpecialEffectId(TARGET_SELF, 200001) then
            else
                f9_arg0:AddTopGoal(GOAL_COMMON_EndureAttack, 10, 1010, TARGET_ENE_0, 9999, 0, 0, 0, 0)
                return true
            end
        elseif f9_local2 == AI_TARGET_TYPE__INDICATION_POS then
            if f9_arg0:HasSpecialEffectId(TARGET_SELF, 200004) then
                f9_arg0:AddTopGoal(GOAL_COMMON_AttackTunableSpin, 10, 401020, TARGET_ENE_0, 9999, 0, 0, 0, 0)
                return true
            elseif f9_arg0:HasSpecialEffectId(TARGET_SELF, 200002) or f9_arg0:HasSpecialEffectId(TARGET_SELF, 200001) then
            else
                if f9_arg0:IsChangeState() then
                    f9_arg0:AddTopGoal(GOAL_COMMON_Wait, f9_arg0:GetRandam_Float(0, 0.3), TARGET_SELF, 0, 0, 0)
                    f9_arg0:AddTopGoal(GOAL_COMMON_EndureAttack, 10, 700, TARGET_ENE_0, 9999, 0)
                    return true
                end
                f9_arg0:AddTopGoal(GOAL_COMMON_EndureAttack, 10, 1010, TARGET_ENE_0, 9999, 0, 0, 0, 0)
                return true
            end
        elseif f9_local2 == AI_TARGET_TYPE__CORPSE_POS then
            if f9_arg0:HasSpecialEffectId(TARGET_SELF, 200004) then
                f9_arg0:AddTopGoal(GOAL_COMMON_AttackTunableSpin, 10, 401020, TARGET_ENE_0, 9999, 0, 0, 0, 0)
                return true
            elseif f9_arg0:HasSpecialEffectId(TARGET_SELF, 200002) or f9_arg0:HasSpecialEffectId(TARGET_SELF, 200001) then
            else
                if f9_arg0:IsChangeState() then
                    f9_arg0:AddTopGoal(GOAL_COMMON_Wait, f9_arg0:GetRandam_Float(0, 0.3), TARGET_SELF, 0, 0, 0)
                    f9_arg0:AddTopGoal(GOAL_COMMON_EndureAttack, 10, 710, TARGET_ENE_0, 9999, 0)
                    return true
                end
                f9_arg0:AddTopGoal(GOAL_COMMON_EndureAttack, 10, 1010, TARGET_ENE_0, 9999, 0, 0, 0, 0)
                return true
            end
        end
    elseif f9_arg0:HasSpecialEffectId(TARGET_SELF, 200004) then
        f9_arg0:AddTopGoal(GOAL_COMMON_AttackTunableSpin, 10, 401000, TARGET_ENE_0, 9999, 0, 0, 0, 0)
        return true
    elseif f9_arg0:HasSpecialEffectId(TARGET_SELF, 200002) then
        f9_arg0:AddTopGoal(GOAL_COMMON_AttackTunableSpin, 10, 201000, TARGET_ENE_0, 9999, 0, 0, 0, 0)
        return true
    elseif f9_arg0:HasSpecialEffectId(TARGET_SELF, 200001) then
        f9_arg0:AddTopGoal(GOAL_COMMON_AttackTunableSpin, 10, 101000, TARGET_SELF, 9999, 0, 0, 0, 0)
        return true
    else
    end
    return false
    
end

function _COMMON_SetBattleGoal(f10_arg0)
    local f10_local0 = f10_arg0:GetExcelParam(AI_EXCEL_THINK_PARAM_TYPE__battleGoalID)
    local f10_local1 = f10_arg0:AddTopGoal(f10_local0, -1)
    if f10_local1 then
        f10_local1:SetManagementGoal()
    end
    return true
    
end

function COMMON_Interrupt(f11_arg0, f11_arg1)
    local f11_local0 = false
    if f11_arg0:IsInterupt(INTERUPT_MovedEnd_OnFailedPath) then
        f11_arg0:DecideWalkAroundPos()
        local f11_local1 = f11_arg0:GetActTypeOnFailedPathEnd()
        if 0 == f11_local1 then
            f11_local0 = true
        elseif 1 == f11_local1 then
            f11_arg1:ClearSubGoal()
            f11_arg1:AddSubGoal(GOAL_COMMON_Wait_On_FailedPath, -1, 1)
            f11_local0 = true
        elseif 2 == f11_local1 then
            f11_arg1:ClearSubGoal()
            f11_arg1:AddSubGoal(GOAL_COMMON_Wait_On_FailedPath, 2, 1)
            f11_local0 = true
        elseif 3 == f11_local1 then
            f11_arg1:ClearSubGoal()
            f11_arg1:AddSubGoal(GOAL_COMMON_WalkAround_On_FailedPath, -1, 1)
            f11_local0 = true
        elseif 4 == f11_local1 then
            f11_arg1:ClearSubGoal()
            f11_arg1:AddSubGoal(GOAL_COMMON_BackToHome_On_FailedPath, 100, 1, 2)
            f11_local0 = true
        end
    end
    return f11_local0
    
end


