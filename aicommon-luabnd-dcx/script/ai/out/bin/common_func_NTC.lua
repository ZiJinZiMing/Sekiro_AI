--[[******************************************************************************
    common_func_NTC.lua - Sekiro AI Common Functions (NTC System)

    模块名称: NTC通用AI函数库
    文件编码: Shift-JIS
    版本: 1.0

    模块概述:
    ========
    本模块是只狼AI系统的核心支撑模块，包含了NPC战斗AI的通用行为函数。
    NTC (Non-Target Combat) 系统负责处理敌人与玩家之间的战斗交互逻辑，
    包括弹反(Parry)、格挡、闪避、围攻等核心战斗机制。

    核心功能:
    ========
    1. 弹反系统 (Parry System)
       - Common_Parry() - 主弹反判定和执行
       - GetDist_Parry() - 武器距离检测
       - RankCheck_Parry() - 弹反等级判定

    2. 特效管理 (Special Effect Management)
       - GetKengekiSpecialEffect() - 检测剑戟特效
       - ReturnKengekiSpecialEffect() - 返回当前剑戟特效ID
       - Set_ConsecutiveGuardCount() - 连续格挡计数

    3. 战术移动 (Tactical Movement)
       - YousumiAct_TopGoal/SubGoal() - 几何战术定位系统
       - TorimakiAct() - 围攻移动行为
       - KankyakuAct() - 观战移动行为

    4. 空间检测 (Spatial Checks)
       - SpaceCheck_SidewayMove() - 侧向移动空间检测
       - GetDirection_Sideway() - 侧向方向判定
       - Check_ReachAttack() - 攻击可达性检测

    5. 激活行为 (Activation Behaviors)
       - Common_ActivateAct() - 通用激活响应
       - JuzuReaction() - 数珠反应处理
       - Check_KugutsuActState() - 傀儡状态检测

    6. 中断处理 (Interrupt Handlers)
       - Interupt_Use_Item() - 使用道具中断
       - Interupt_PC_Break() - 玩家破防中断

    与common_func.lua的关系:
    =======================
    - common_func.lua: 基础AI框架和通用工具函数
    - common_func_NTC.lua: 战斗特化的高级行为函数
    - 本模块依赖common_func.lua中的SpaceCheck等基础函数

    特效ID范围说明:
    ==============
    - 200200-200229: 剑戟系特效 (武器状态、强化类型)
    - 200300-200306: 防御系特效 (格挡、弹反状态)
    - 200400-200406: 招式系特效 (特殊攻击类型)
    - 221000-221002: 弹反等级标记 (Lv0/Lv1/Lv2)
    - 110xxx: 玩家状态特效 (武器类型、招式标识)

******************************************************************************]]

--[[******************************************************************************
    函数名: GetKengekiSpecialEffect
    功能: 检测剑戟(Kengeki)相关特效是否激活
    Function: Check if Kengeki (sword combat) special effect is active

    参数:
        f1_arg0 - AI实体对象
        f1_arg1 - 未使用
        f1_arg2 - 特效ID (200200-200229范围为剑戟特效)

    返回值:
        true  - 特效ID在剑戟特效列表中
        false - 特效ID不在剑戟特效列表中

    说明:
        检测特效ID是否为预定义的剑戟类特效。
        这些特效通常标识武器强化状态、战斗模式等。
******************************************************************************]]
function GetKengekiSpecialEffect(f1_arg0, f1_arg1, f1_arg2)
    if f1_arg2 == 200200 or f1_arg2 == 200201 or f1_arg2 == 200205 or f1_arg2 == 200206 or f1_arg2 == 200210 or f1_arg2 == 200211 or f1_arg2 == 200215 or f1_arg2 == 200216 or f1_arg2 == 200225 or f1_arg2 == 200226 or f1_arg2 == 200227 or f1_arg2 == 200228 or f1_arg2 == 200229 then
        return true
    end
    return false
    
end

--[[******************************************************************************
    函数名: ReturnKengekiSpecialEffect
    功能: 返回当前激活的剑戟特效ID
    Function: Return currently active Kengeki special effect ID

    参数:
        f2_arg0 - AI实体对象

    返回值:
        特效ID (200200-200406) - 当前激活的特效
        0 - 无剑戟特效激活

    说明:
        按优先级顺序检测并返回当前生效的剑戟特效ID。
        包含三个类别：200200系(基础)、200300系(防御)、200400系(攻击)。
******************************************************************************]]
function ReturnKengekiSpecialEffect(f2_arg0)
    if f2_arg0:HasSpecialEffectId(TARGET_SELF, 200200) then
        return 200200
    elseif f2_arg0:HasSpecialEffectId(TARGET_SELF, 200201) then
        return 200201
    elseif f2_arg0:HasSpecialEffectId(TARGET_SELF, 200205) then
        return 200205
    elseif f2_arg0:HasSpecialEffectId(TARGET_SELF, 200206) then
        return 200206
    elseif f2_arg0:HasSpecialEffectId(TARGET_SELF, 200210) then
        return 200210
    elseif f2_arg0:HasSpecialEffectId(TARGET_SELF, 200211) then
        return 200211
    elseif f2_arg0:HasSpecialEffectId(TARGET_SELF, 200215) then
        return 200215
    elseif f2_arg0:HasSpecialEffectId(TARGET_SELF, 200216) then
        return 200216
    elseif f2_arg0:HasSpecialEffectId(TARGET_SELF, 200225) then
        return 200225
    elseif f2_arg0:HasSpecialEffectId(TARGET_SELF, 200226) then
        return 200226
    elseif f2_arg0:HasSpecialEffectId(TARGET_SELF, 200227) then
        return 200227
    elseif f2_arg0:HasSpecialEffectId(TARGET_SELF, 200228) then
        return 200228
    elseif f2_arg0:HasSpecialEffectId(TARGET_SELF, 200229) then
        return 200229
    elseif f2_arg0:HasSpecialEffectId(TARGET_SELF, 200300) then
        return 200300
    elseif f2_arg0:HasSpecialEffectId(TARGET_SELF, 200301) then
        return 200301
    elseif f2_arg0:HasSpecialEffectId(TARGET_SELF, 200305) then
        return 200305
    elseif f2_arg0:HasSpecialEffectId(TARGET_SELF, 200306) then
        return 200306
    elseif f2_arg0:HasSpecialEffectId(TARGET_SELF, 200400) then
        return 200400
    elseif f2_arg0:HasSpecialEffectId(TARGET_SELF, 200401) then
        return 200401
    elseif f2_arg0:HasSpecialEffectId(TARGET_SELF, 200405) then
        return 200405
    elseif f2_arg0:HasSpecialEffectId(TARGET_SELF, 200406) then
        return 200406
    end
    return 0

end

--[[******************************************************************************
    函数名: Check_KugutsuActState
    功能: 检测AI是否处于傀儡(Kugutsu)行动状态
    Function: Check if AI is in Puppet (Kugutsu) action state

    参数:
        f3_arg0 - AI实体对象

    返回值:
        true  - 处于傀儡状态且未被发现
        false - 不满足傀儡行动条件

    说明:
        傀儡状态(220020特效)下，AI处于待命状态。
        只有在未被发现(IsFindState)且非战斗状态时返回true。
******************************************************************************]]
function Check_KugutsuActState(f3_arg0)
    local f3_local0 = false
    if f3_arg0:HasSpecialEffectId(TARGET_SELF, 220020) and f3_arg0:IsFindState() == false and f3_arg0:IsBattleState() == false then
        f3_local0 = true
    end
    return f3_local0

end

--[[******************************************************************************
    函数名: YousumiAct_TopGoal
    功能: 几何战术定位系统 - 基于角度计算最佳攻击位置
    Function: Geometric tactical positioning - calculate optimal attack position

    参数:
        f4_arg0 - AI实体对象
        f4_arg1 - Goal对象
        f4_arg2 - 是否允许跑步接近 (false=快速接近)
        f4_arg3 - 最小仰角(度) - 用于计算高位距离阈值
        f4_arg4 - 最大仰角(度) - 用于计算低位距离阈值

    返回值:
        true  - 已达到理想位置，可以开始攻击
        false - 正在调整位置中

    核心算法:
        利用三角函数计算不同高度差时的最佳距离：
        - f4_local4 = DistY / sin(最小角) -> 目标太高时的最小接近距离
        - f4_local5 = DistY / sin(最大角) -> 目标太低时的最大接近距离

    说明:
        这是一个复杂的3D空间定位函数，用于处理高低差战斗。
        通过角度和距离的几何关系，自动调整AI位置以获得最佳攻击角度。
        常用于需要精确定位的远程或跳跃攻击前置。
******************************************************************************]]
function YousumiAct_TopGoal(f4_arg0, f4_arg1, f4_arg2, f4_arg3, f4_arg4)
    local f4_local0 = f4_arg0:GetDist(TARGET_ENE_0)
    local f4_local1 = f4_arg0:GetDistYSigned(TARGET_ENE_0)
    local f4_local2 = 1
    local f4_local3 = 30  -- 最大允许距离
    local f4_local4 = f4_local1 / math.sin(math.rad(f4_arg3))  -- 高位时的最小距离
    local f4_local5 = f4_local1 / math.sin(math.rad(f4_arg4))  -- 低位时的最大距离
    local f4_local6 = f4_arg0:GetRandam_Int(0, 1)
    local f4_local7 = true
    f4_arg0:SetNumber(10, f4_local6)
    local f4_local8 = TARGET_ENE_0
    if f4_arg0:GetCurrTargetType() == AI_TARGET_TYPE__MEMORY_ENEMY then
        f4_local8 = TARGET_SELF
    end
    if f4_arg0:GetStringIndexedNumber("Reach_EndOnFailedPath") == 1 then
        f4_arg0:SetStringIndexedNumber("Reach_EndOnFailedPath", 0)
        return true
    elseif f4_local0 <= f4_local2 then
        if SpaceCheck(f4_arg0, f4_arg1, 180, 1) == true then
            f4_arg0:AddTopGoal(GOAL_COMMON_LeaveTarget, 10, TARGET_ENE_0, f4_local2, f4_local8, true, -1)
            f4_local7 = false
        end
    elseif f4_local3 <= f4_local0 then
        f4_arg0:AddTopGoal(GOAL_COMMON_ApproachTarget, 1.5, TARGET_ENE_0, f4_local3 - 0.5, TARGET_SELF, false, -1)
        f4_local7 = false
    elseif f4_local1 > 0 then
        if f4_local4 <= f4_local2 then
            f4_local4 = f4_local2
        end
        if f4_local3 <= f4_local5 then
            f4_local5 = f4_local3
        end
        if f4_local5 <= f4_local0 then
            if f4_local0 - f4_local5 >= 5 and f4_arg2 == false then
                f4_arg0:AddTopGoal(GOAL_COMMON_ApproachTarget, 1.5, TARGET_ENE_0, f4_local5, TARGET_SELF, false, -1)
                f4_local7 = false
            else
                f4_arg0:AddTopGoal(GOAL_COMMON_ApproachTarget, 3, TARGET_ENE_0, f4_local5, TARGET_SELF, true, -1)
                f4_local7 = false
            end
        elseif f4_local0 <= f4_local4 then
            if f4_arg0:IsInsideTarget(TARGET_ENE_0, AI_DIR_TYPE_F, 180) then
                if SpaceCheck(f4_arg0, f4_arg1, 180, 0.5) == true then
                    f4_arg0:AddTopGoal(GOAL_COMMON_LeaveTarget, 10, TARGET_ENE_0, f4_local4, f4_local8, true, -1)
                    f4_local7 = false
                end
            elseif SpaceCheck(f4_arg0, f4_arg1, 0, 0.5) == true then
                f4_arg0:AddTopGoal(GOAL_COMMON_LeaveTarget, 10, TARGET_ENE_0, f4_local4, f4_local8, true, -1)
                f4_local7 = false
            else
                f4_arg0:AddTopGoal(GOAL_COMMON_Turn, 3, TARGET_ENE_0, 0, 0, 0, 0)
            end
        elseif f4_arg0:IsInsideTarget(TARGET_ENE_0, AI_DIR_TYPE_B, 180) then
            f4_arg0:AddTopGoal(GOAL_COMMON_Turn, 3, TARGET_ENE_0, 0, 0, 0, 0)
        end
    else
        local f4_local9 = TARGET_ENE_0
        if f4_arg0:CheckDoesExistPathWithSetPoint(TARGET_ENE_0, AI_DIR_TYPE_F, 0, 0) == false then
            f4_local9 = POINT_UnreachTerminate
        end
        if SpaceCheck(f4_arg0, f4_arg1, 0, 4) == true and f4_arg2 == false then
            f4_arg0:AddTopGoal(GOAL_COMMON_ApproachTarget, 1.5, f4_local9, 0.5, TARGET_SELF, false, -1)
            f4_local7 = false
        elseif SpaceCheck(f4_arg0, f4_arg1, 0, 3) == true then
            f4_arg0:AddTopGoal(GOAL_COMMON_ApproachTarget, 3, f4_local9, 0.5, TARGET_SELF, true, -1)
            f4_local7 = false
        elseif SpaceCheck(f4_arg0, f4_arg1, 0, 0.5) == false then
            f4_arg0:AddTopGoal(GOAL_COMMON_LeaveTarget, 2, f4_local9, 50, f4_local8, true, -1)
            f4_arg0:AddTopGoal(GOAL_COMMON_Turn, 3, TARGET_ENE_0, 0, 0, 0, 0)
            f4_local7 = false
        end
    end
    return f4_local7

end

--[[******************************************************************************
    函数名: YousumiAct_SubGoal
    功能: 添加几何定位子目标
    Function: Add geometric positioning sub-goal

    参数:
        f5_arg0 - AI实体对象
        f5_arg1 - Goal对象
        f5_arg2-f5_arg5 - 传递给GOAL_COMMON_YousumiAct的参数

    返回值: true (始终成功)

    说明:
        与YousumiAct_TopGoal配合使用，用于子目标层级的定位。
******************************************************************************]]
function YousumiAct_SubGoal(f5_arg0, f5_arg1, f5_arg2, f5_arg3, f5_arg4, f5_arg5)
    f5_arg1:AddSubGoal(GOAL_COMMON_YousumiAct, 10, f5_arg2, f5_arg3, f5_arg4, f5_arg5)
    return true
    
end

--[[******************************************************************************
    函数名: TorimakiAct
    功能: 围攻移动行为 (Torimaki = Encirclement)
    Function: Encirclement movement behavior

    参数:
        f6_arg0 - AI实体对象
        f6_arg1 - Goal对象
        f6_arg2 - 理想距离 (默认6米)
        f6_arg3 - 停止概率 (0-100, 默认10%)
        f6_arg4 - 是否允许远距离跑步接近 (默认false)

    返回值:
        true  - 执行了停止等待
        false - 执行了移动调整

    说明:
        多敌人围攻时的核心移动逻辑。
        维持理想距离的同时，通过侧向移动和前后调整，形成包围态势。
        当距离理想且随机值满足时，有概率停止移动进行观察。
******************************************************************************]]
function TorimakiAct(f6_arg0, f6_arg1, f6_arg2, f6_arg3, f6_arg4)
    local f6_local0 = f6_arg0:GetDist(TARGET_ENE_0)
    local f6_local1 = f6_arg0:GetRandam_Float(1, 2)
    local f6_local2 = 1.5
    local f6_local3 = f6_arg0:GetRandam_Int(30, 45)
    local f6_local4 = -1
    local f6_local5 = 0
    local f6_local6 = f6_arg0:GetRandam_Int(1, 100)
    local f6_local7 = true
    local f6_local8 = f6_arg0:GetRandam_Float(-1, 1)
    if f6_arg2 == nil or f6_arg2 == -1 then
        f6_arg2 = 6
    end
    if f6_arg3 == nil or f6_arg3 == -1 then
        f6_arg3 = 10
    end
    if f6_arg4 == nil then
        f6_arg4 = false
    end
    if f6_arg2 ~= 0 and f6_local0 <= f6_arg2 - 2 then
        f6_arg1:AddSubGoal(GOAL_COMMON_LeaveTarget, f6_local2, TARGET_ENE_0, f6_arg2, TARGET_ENE_0, true, f6_local4)
    elseif f6_arg2 ~= 0 and f6_arg2 + 2 <= f6_local0 then
        if not f6_arg4 and f6_arg2 + 3 <= f6_local0 then
            f6_local7 = false
        end
        f6_arg1:AddSubGoal(GOAL_COMMON_ApproachTarget, f6_local2, TARGET_ENE_0, f6_arg2 + f6_local8, TARGET_SELF, f6_local7, -1)
    elseif f6_arg3 ~= nil and f6_local6 <= f6_arg3 then
        return true
    elseif SpaceCheck(f6_arg0, f6_arg1, 90, 1) == true or SpaceCheck(f6_arg0, f6_arg1, -90, 1) == true then
        f6_local5 = GetDirection_Sideway(f6_arg0)
        f6_arg1:AddSubGoal(GOAL_COMMON_SidewayMove, f6_local1, TARGET_ENE_0, f6_local5, f6_local3, true, true, f6_local4)
    elseif SpaceCheck(f6_arg0, f6_arg1, 180, 1) == true then
        f6_arg1:AddSubGoal(GOAL_COMMON_LeaveTarget, f6_local2, TARGET_ENE_0, 999, TARGET_ENE_0, true, f6_local4)
    else
        f6_arg1:AddSubGoal(GOAL_COMMON_Wait, 0.5, TARGET_SELF, 0, 0, 0)
    end
    return false

end

--[[******************************************************************************
    函数名: KankyakuAct
    功能: 观战移动行为 (Kankyaku = Spectator)
    Function: Spectator movement behavior

    参数:
        f7_arg0 - AI实体对象
        f7_arg1 - Goal对象
        f7_arg2 - 理想距离 (默认10米)
        f7_arg3 - 停止概率 (默认0%)
        f7_arg4 - 是否允许跑步接近

    返回值:
        同TorimakiAct

    说明:
        观战状态的移动行为，实际调用TorimakiAct。
        与TorimakiAct的区别在于默认距离更远(10米)，更适合待机AI。
******************************************************************************]]
function KankyakuAct(f7_arg0, f7_arg1, f7_arg2, f7_arg3, f7_arg4)
    if f7_arg2 == nil or f7_arg2 == -1 then
        f7_arg2 = 10
    end
    if f7_arg3 == nil or f7_arg3 == -1 then
        f7_arg3 = 0
    end
    return TorimakiAct(f7_arg0, f7_arg1, f7_arg2, f7_arg3, f7_arg4)

end

--[[******************************************************************************
    函数名: Common_ActivateAct
    功能: 通用激活响应行为 - 对玩家特定动作的反应
    Function: Common activation response - react to specific player actions

    参数:
        f8_arg0 - AI实体对象
        f8_arg1 - Goal对象
        f8_arg2 - 步法类型 (0=允许小步, 1=允许所有步法, 2=仅大步)
        f8_arg3 - 攻击规避类型 (0=优先后撤, 1=仅后撤, 2=仅侧移)

    返回值:
        true  - 执行了响应行为
        false - 未检测到需要响应的条件

    检测的玩家状态:
        - 110060: 玩家僵直/硬直状态
        - 110015: 玩家攻击预兆 (可进行见切/垫步)
        - REVIVAL_AFTER: 玩家复活无敌时间
        - 110030: 玩家处于特定招式中

    说明:
        这是AI对玩家动作做出战术响应的核心函数。
        根据玩家状态选择最优应对：等待、后撤、侧移或转身。
******************************************************************************]]
function Common_ActivateAct(f8_arg0, f8_arg1, f8_arg2, f8_arg3)
    local f8_local0 = f8_arg0:GetDist(TARGET_ENE_0)
    local f8_local1 = f8_arg0:GetRandam_Float(1, 2)
    local f8_local2 = f8_arg0:GetRandam_Int(30, 45)
    local f8_local3 = -1
    local f8_local4 = 0
    if f8_arg2 == nil then
        f8_arg2 = 0
    end
    if f8_arg3 == nil then
        f8_arg3 = 0
    end
    -- 玩家僵直状态：转身或等待
    if f8_arg0:HasSpecialEffectId(TARGET_ENE_0, 110060) then
        if f8_arg0:IsInsideTarget(TARGET_ENE_0, AI_DIR_TYPE_F, 90) then
            f8_arg1:AddSubGoal(GOAL_COMMON_Wait, 0.5, TARGET_SELF, 0, 0, 0)
        else
            f8_arg1:AddSubGoal(GOAL_COMMON_Turn, 3, TARGET_ENE_0, 45, -1, GOAL_RESULT_Success, true)
        end
    -- 玩家攻击预兆：执行垫步规避 (5201=小步后撤, 5211=大步后撤)
    elseif f8_arg0:HasSpecialEffectId(TARGET_ENE_0, 110015) and f8_arg0:GetStringIndexedNumber("Steped") ~= 1 then
        if f8_arg2 == 0 and SpaceCheck(f8_arg0, f8_arg1, 180, f8_arg0:GetStringIndexedNumber("Dist_Step_Small")) == true then
            if (f8_arg3 == 0 or f8_arg3 == 2) and SpaceCheck(f8_arg0, f8_arg1, 180, f8_arg0:GetStringIndexedNumber("Dist_Step_Large")) == true then
                if f8_arg3 == 0 and f8_local0 > 4 or f8_arg3 == 1 then
                    f8_arg1:AddSubGoal(GOAL_COMMON_SpinStep, 3, 5201, TARGET_ENE_0, 0, AI_DIR_TYPE_B, 0)  -- 小步后撤
                else
                    f8_arg1:AddSubGoal(GOAL_COMMON_SpinStep, 3, 5211, TARGET_ENE_0, 0, AI_DIR_TYPE_B, 0)  -- 大步后撤
                end
            else
                f8_arg1:AddSubGoal(GOAL_COMMON_SpinStep, 3, 5201, TARGET_ENE_0, 0, AI_DIR_TYPE_B, 0)
            end
            f8_arg0:SetStringIndexedNumber("Steped", 1)  -- 标记已垫步，避免连续垫步
        elseif f8_arg2 <= 1 and (SpaceCheck(f8_arg0, f8_arg1, 90, 1) == true or SpaceCheck(f8_arg0, f8_arg1, -90, 1) == true) then
            f8_local4 = GetDirection_Sideway(f8_arg0)
            f8_arg1:AddSubGoal(GOAL_COMMON_SidewayMove, f8_local1, TARGET_ENE_0, f8_local4, f8_local2, true, true, f8_local3)
        else
            f8_arg1:AddSubGoal(GOAL_COMMON_Wait, 0.5, TARGET_SELF, 0, 0, 0)
        end
    elseif f8_arg2 <= 1 and (f8_arg0:HasSpecialEffectId(TARGET_ENE_0, COMMON_SP_EFFECT_PC_REVIVAL_AFTER_1) or f8_arg0:HasSpecialEffectId(TARGET_ENE_0, COMMON_SP_EFFECT_PC_REVIVAL_AFTER_2)) then
        KankyakuAct(f8_arg0, f8_arg1, 0)
    elseif f8_arg2 <= 1 and f8_arg0:HasSpecialEffectId(TARGET_ENE_0, 110030) then
        KankyakuAct(f8_arg0, f8_arg1, 0)
    else
        f8_arg0:SetStringIndexedNumber("Steped", 0)
        return false
    end
    return true

end

--[[******************************************************************************
    函数名: GetDirection_Sideway
    功能: 判定最佳侧向移动方向
    Function: Determine best sideway movement direction

    参数:
        f9_arg0 - AI实体对象

    返回值:
        0 - 向左侧移动
        1 - 向右侧移动

    说明:
        优先选择玩家背对的方向移动。如果只有一侧有空间则选择该侧。
******************************************************************************]]
function GetDirection_Sideway(f9_arg0)
    if SpaceCheck(f9_arg0, goal, -90, 1) == true then
        if SpaceCheck(f9_arg0, goal, 90, 1) == true then
            if f9_arg0:IsInsideTarget(TARGET_ENE_0, AI_DIR_TYPE_R, 180) then
                return 1
            else
                return 0
            end
        else
            return 0
        end
    elseif SpaceCheck(f9_arg0, goal, 90, 1) == true then
        return 1
    else
        return 0
    end
    
end

--[[******************************************************************************
    函数名: Get_ConsecutiveGuardCount
    功能: 获取连续格挡次数
    Function: Get consecutive guard count

    参数:
        f10_arg0 - AI实体对象

    返回值:
        连续格挡次数 (0-N)

    说明:
        读取Timer13，如果超时则重置计数为0。
        用于弹反概率计算：格挡次数越多，下次执行弹反的概率越高。
******************************************************************************]]
function Get_ConsecutiveGuardCount(f10_arg0)
    local f10_local0 = 0
    if f10_arg0:IsFinishTimer(13) then
        f10_local0 = 0
    else
        f10_local0 = f10_arg0:GetStringIndexedNumber("ConsecutiveGuardCount")
    end
    return f10_local0
    
end

--[[******************************************************************************
    函数名: Set_ConsecutiveGuardCount
    功能: 设置连续格挡次数
    Function: Set consecutive guard count

    参数:
        f11_arg0 - AI实体对象
        f11_arg1 - 特效ID (200215/200216=格挡成功, 200210/200211=被破防)

    说明:
        - 格挡成功(200215/216)：计数+1，刷新Timer13
        - 被破防(200210/211)：计数归零
******************************************************************************]]
function Set_ConsecutiveGuardCount(f11_arg0, f11_arg1)
    if f11_arg1 == 200215 or f11_arg1 == 200216 then
        if f11_arg0:IsFinishTimer(13) then
            f11_arg0:SetStringIndexedNumber("ConsecutiveGuardCount", 1)
        else
            f11_arg0:SetStringIndexedNumber("ConsecutiveGuardCount", f11_arg0:GetStringIndexedNumber("ConsecutiveGuardCount") + 1)
        end
        f11_arg0:SetTimer(13, 1)
    elseif f11_arg1 == 200210 or f11_arg1 == 200211 then
        f11_arg0:SetStringIndexedNumber("ConsecutiveGuardCount", 0)
        f11_arg0:SetTimer(13, 0)
    end
    
end

--[[******************************************************************************
    函数名: Set_ConsecutiveGuardCount_Interrupt
    功能: 注册连续格挡计数的中断监听
    Function: Register interrupt observers for guard counting

    参数:
        f12_arg0 - AI实体对象

    说明:
        注册特效监听，当特效激活时自动触发Set_ConsecutiveGuardCount更新。
******************************************************************************]]
function Set_ConsecutiveGuardCount_Interrupt(f12_arg0)
    f12_arg0:AddObserveSpecialEffectAttribute(TARGET_SELF, 200250)
    f12_arg0:AddObserveSpecialEffectAttribute(TARGET_SELF, 200210)
    f12_arg0:AddObserveSpecialEffectAttribute(TARGET_SELF, 200211)
    
end

--[[******************************************************************************
    函数名: JuzuReaction
    功能: 数珠(Juzu)反应攻击 - Boss战数珠破坏时的反应
    Function: Prayer Bead reaction attack - Boss response when bead destroyed

    参数:
        f13_arg0 - AI实体对象
        f13_arg1 - 未使用
        f13_arg2 - 未使用
        f13_arg3 - 主要攻击ID
        f13_arg4 - 替代攻击ID (50%概率)

    说明:
        当玩家破坏数珠时，Boss执行的特殊反击动作。
        重置AI_TIMER_TEKIMAWASHI_REACTION计时器。
******************************************************************************]]
function JuzuReaction(f13_arg0, f13_arg1, f13_arg2, f13_arg3, f13_arg4)
    local f13_local0 = f13_arg3
    local f13_local1 = 400600
    local f13_local2 = f13_arg0:GetRandam_Int(1, 100)
    local f13_local3 = f13_arg0:GetRandam_Int(1, 100)
    if f13_arg4 ~= nil and f13_local2 <= 50 then
        f13_local0 = f13_arg4
    end
    if f13_arg2 == 0 then
        f13_arg0:AddTopGoal(GOAL_COMMON_AttackTunableSpin, 10, f13_local0, TARGET_NONE, 9999, 0, 0, 0, 0):TimingSetTimer(AI_TIMER_TEKIMAWASHI_REACTION, 0, AI_TIMING_SET__ACTIVATE)
    else
        f13_arg0:AddTopGoal(GOAL_COMMON_AttackTunableSpin, 10, f13_local0, TARGET_NONE, 9999, 0, 0, 0, 0):TimingSetTimer(AI_TIMER_TEKIMAWASHI_REACTION, 0, AI_TIMING_SET__ACTIVATE)
    end
    return true

end

--[[******************************************************************************
    函数名: SpaceCheck_SidewayMove
    功能: 侧向移动空间检测
    Function: Check available space for sideway movement

    参数:
        f14_arg0 - AI实体对象
        f14_arg1 - Goal对象
        f14_arg2 - 检测距离(米)

    返回值:
        0 - 仅左侧有空间
        1 - 仅右侧有空间
        2 - 左右两侧都有空间
        3 - 左右两侧都无空间

    说明:
        检测AI左右两侧的可移动空间，用于选择侧移方向。
******************************************************************************]]
function SpaceCheck_SidewayMove(f14_arg0, f14_arg1, f14_arg2)
    local f14_local0 = nil
    if SpaceCheck(f14_arg0, f14_arg1, -90, f14_arg2) == true then
        if SpaceCheck(f14_arg0, f14_arg1, 90, f14_arg2) == true then
            f14_local0 = 2
        else
            f14_local0 = 0
        end
    elseif SpaceCheck(f14_arg0, f14_arg1, 90, f14_arg2) == true then
        f14_local0 = 1
    else
        f14_local0 = 3
    end
    return f14_local0
    
end

--[[******************************************************************************
    函数名: Common_Parry
    功能: 弹反系统核心函数 - AI对玩家攻击的弹反判定与执行
    Function: Core Parry System - AI deflection against player attacks

    参数:
        f15_arg0 - AI实体对象
        f15_arg1 - Goal对象
        f15_arg2 - 弹反概率加成(%) - 每次连续格挡增加的弹反概率
        f15_arg3 - 超距垫步概率(%) - 距离稍远时执行垫步的概率
        f15_arg4 - 垫步类型 (0=小步, 1=大步, -1=禁用)
        f15_arg5 - 弹反动作ID (默认3100=普通弹反, 3101=进攻性弹反)

    返回值:
        true  - 执行了弹反或垫步
        false - 未满足弹反条件

    弹反等级系统 (通过特效221000-221002标识):
        Level 0 (221000) - 新手AI：100%执行弹反，对突刺有特殊处理
        Level 1 (221001) - 进阶AI：50%执行弹反，对突刺有特殊处理
        Level 2 (221002) - 困难AI：不执行弹反，仅格挡

    核心逻辑:
        1. 检测弹反前置条件（距离、角度、冷却时间）
        2. 识别玩家攻击类型（普通/突刺/连击/攻势）
        3. 根据AI等级和攻击类型选择响应方式：
           - 普通弹反(3100) - 消耗玩家架势但不反击
           - 进攻性弹反(3101) - 消耗玩家架势并有反击机会
           - 后撤垫步(5201/5211) - 规避攻击
        4. 连续格挡次数越多，弹反概率越高

    特殊攻击检测:
        - 109970: 玩家突刺攻击 (可被见切)
        - 109980: 可垫步规避的攻击
        - 110450/110501: 特殊攻击 (不可弹反)
        - ATTACK_RUSH: 玩家连击状态 (强制使用3100承受)

    距离判定:
        使用GetDist_Parry()获取不同武器类型的有效距离。
        距离稍远时可选择执行垫步代替弹反。
******************************************************************************]]
function Common_Parry(f15_arg0, f15_arg1, f15_arg2, f15_arg3, f15_arg4, f15_arg5)
    local f15_local0 = f15_arg0:GetDist(TARGET_ENE_0)
    local f15_local1 = GetDist_Parry(f15_arg0)
    local f15_local2 = f15_arg0:GetRandam_Int(1, 100)
    local f15_local3 = f15_arg0:GetRandam_Int(1, 100)
    local f15_local4 = f15_arg0:GetRandam_Int(1, 100)
    local f15_local5 = f15_arg0:HasSpecialEffectId(TARGET_ENE_0, 109970)  -- 玩家突刺攻击
    local f15_local6 = f15_arg0:HasSpecialEffectId(TARGET_ENE_0, COMMON_SP_EFFECT_PC_ATTACK_RUSH)  -- 玩家连击状态
    local f15_local7 = -1  -- 弹反等级
    if f15_arg0:HasSpecialEffectId(TARGET_SELF, 221000) then
        f15_local7 = 0  -- Lv0: 始终弹反
    elseif f15_arg0:HasSpecialEffectId(TARGET_SELF, 221001) then
        f15_local7 = 1  -- Lv1: 50%弹反
    elseif f15_arg0:HasSpecialEffectId(TARGET_SELF, 221002) then
        f15_local7 = 2  -- Lv2: 不弹反
    end
    if f15_arg0:IsFinishTimer(AI_TIMER_PARRY_INTERVAL) == false then
        return false
    end
    if f15_local7 == -1 then
        return false
    end
    if f15_arg0:HasSpecialEffectId(TARGET_SELF, 220062) then
        return false
    end
    if f15_arg0:HasSpecialEffectId(TARGET_ENE_0, 110450) or f15_arg0:HasSpecialEffectId(TARGET_ENE_0, 110501) or f15_arg0:HasSpecialEffectId(TARGET_ENE_0, 110500) then
        return false
    end
    f15_arg0:SetTimer(AI_TIMER_PARRY_INTERVAL, 0.1)
    if f15_arg2 == nil then
        f15_arg2 = 50
    end
    if f15_arg3 == nil then
        f15_arg3 = 0
    end
    if f15_arg4 == nil then
        f15_arg4 = 0
    end
    if f15_arg5 == nil then
        f15_arg5 = 3100
    end
    -- 在有效距离和角度内
    if f15_arg0:IsInsideTarget(TARGET_ENE_0, AI_DIR_TYPE_F, 90) and f15_arg0:IsInsideTargetEx(TARGET_ENE_0, TARGET_SELF, AI_DIR_TYPE_F, 90, f15_local1) then
        -- 玩家连击状态：必定弹反(3100承受连打)
        if f15_local6 then
            f15_arg1:ClearSubGoal()
            f15_arg1:AddSubGoal(GOAL_COMMON_EndureAttack, 0.3, f15_arg5, TARGET_ENE_0, 9999, 0)
            return true
        -- 玩家突刺攻击：根据等级决定是否弹反(3101进攻性弹反)
        elseif f15_local5 then
            if f15_arg0:IsTargetGuard(TARGET_SELF) and ReturnKengekiSpecialEffect(f15_arg0) == false then
                return false  -- 正在格挡且无特效时不处理
            else
                if f15_local7 == 2 then
                    return false  -- Lv2不弹反
                elseif f15_local7 == 1 then
                    if f15_local2 <= 50 then  -- Lv1: 50%概率
                        f15_arg1:ClearSubGoal()
                        f15_arg1:AddSubGoal(GOAL_COMMON_EndureAttack, 0.3, 3101, TARGET_ENE_0, 9999, 0)
                        return true
                    end
                elseif f15_local7 == 0 and f15_local2 <= 100 then  -- Lv0: 100%概率
                    f15_arg1:ClearSubGoal()
                    f15_arg1:AddSubGoal(GOAL_COMMON_EndureAttack, 0.3, 3101, TARGET_ENE_0, 9999, 0)
                    return true
                end
                return false
            end
        -- 可垫步规避的攻击 (仅Lv0 AI使用)
        elseif f15_arg0:HasSpecialEffectId(TARGET_ENE_0, 109980) and f15_arg4 ~= -1 and f15_local7 == 0 then
            if f15_arg4 == 1 then
                f15_arg1:ClearSubGoal()
                f15_arg1:AddSubGoal(GOAL_COMMON_SpinStep, 1, 5201, TARGET_ENE_0, 0, AI_DIR_TYPE_B, 0)  -- 小步后撤
                return true
            else
                f15_arg1:ClearSubGoal()
                f15_arg1:AddSubGoal(GOAL_COMMON_SpinStep, 1, 5211, TARGET_ENE_0, 0, AI_DIR_TYPE_B, 0)  -- 大步后撤
                return true
            end
        -- 普通攻击：根据连续格挡次数决定弹反类型
        elseif f15_local3 <= Get_ConsecutiveGuardCount(f15_arg0) * f15_arg2 then
            -- 格挡次数越多，越倾向于进攻性弹反(3101)
            f15_arg1:ClearSubGoal()
            f15_arg1:AddSubGoal(GOAL_COMMON_EndureAttack, 0.3, 3101, TARGET_ENE_0, 9999, 0)
            return true
        else
            -- 默认使用普通弹反(3100)
            f15_arg1:ClearSubGoal()
            f15_arg1:AddSubGoal(GOAL_COMMON_EndureAttack, 0.3, 3100, TARGET_ENE_0, 9999, 0)
            return true
        end
    -- 距离稍远(在有效距离+1米内)：可选择垫步规避
    elseif f15_arg0:IsInsideTargetEx(TARGET_ENE_0, TARGET_SELF, AI_DIR_TYPE_F, 90, f15_local1 + 1) then
        if f15_arg4 ~= -1 and f15_local4 <= f15_arg3 then
            if f15_arg4 == 1 then
                f15_arg1:ClearSubGoal()
                f15_arg1:AddSubGoal(GOAL_COMMON_SpinStep, 1, 5201, TARGET_ENE_0, 0, AI_DIR_TYPE_B, 0)
                return true
            else
                f15_arg1:ClearSubGoal()
                f15_arg1:AddSubGoal(GOAL_COMMON_SpinStep, 1, 5211, TARGET_ENE_0, 0, AI_DIR_TYPE_B, 0)
                return true
            end
        else
            return false
        end
    else
        return false  -- 超出弹反距离
    end
    
end

--[[******************************************************************************
    函数名: GetDist_Parry
    功能: 获取弹反有效距离 - 根据玩家武器/招式类型返回对应距离
    Function: Get parry effective distance based on player weapon/skill type

    参数:
        f16_arg0 - AI实体对象

    返回值:
        弹反有效距离(米) - 对应玩家当前武器/招式的攻击距离

    武器类型映射 (通过特效ID识别):
        110271 - 铁扇 (TESSEN)
        110231 - 斧 (AXE)
        110250 - 小太刀 (KODACHI)
        110291/110292 - 长枪1/2 (LANCE)
        110290/110293 - 长枪蓄力1/2 (LANCE_CHARGE)
        110400 - 旋转攻击 (SPIN)
        110410/110411 - 跳跃攻击前/后 (JUMP)
        110420/110421 - 面攻击1/2 (MEN)
        110430 - 剑圣居合 (KENSEI_IAI)
        110440 - 居合斩 (IAI)
        110450/110451 - 隐形居合1/2 (INVISIBLE_IAI)
        110460 - 八相 (HASSOU)
        110470 - 浮舟斩Lv1 (HUSHIGIRI)
        110480 - 连踢 (KICK_RUSH)
        110490 - 拳击 (PUNCHI)
        110501 - 牙突 (GATOTSU)
        109970 - 普通突刺 (THRUST)
        default - 普通站立攻击 (STAND)

    说明:
        每种武器和招式都有独特的攻击距离。
        AI通过识别玩家特效来动态调整弹反判定距离。
        这是弹反系统精确性的关键：距离判定必须匹配武器类型。
******************************************************************************]]
function GetDist_Parry(f16_arg0)
    local f16_local0 = PC_ATTACK_DIST_STAND  -- 默认：普通站立攻击距离
    if f16_arg0:HasSpecialEffectId(TARGET_ENE_0, 110271) then
        f16_local0 = PC_ATTACK_DIST_TESSEN
    elseif f16_arg0:HasSpecialEffectId(TARGET_ENE_0, 110231) then
        f16_local0 = PC_ATTACK_DIST_AXE
    elseif f16_arg0:HasSpecialEffectId(TARGET_ENE_0, 110250) then
        f16_local0 = PC_ATTACK_DIST_KODACHI
    elseif f16_arg0:HasSpecialEffectId(TARGET_ENE_0, 110291) then
        f16_local0 = PC_ATTACK_DIST_LANCE_1
    elseif f16_arg0:HasSpecialEffectId(TARGET_ENE_0, 110292) then
        f16_local0 = PC_ATTACK_DIST_LANCE_2
    elseif f16_arg0:HasSpecialEffectId(TARGET_ENE_0, 110290) then
        f16_local0 = PC_ATTACK_DIST_LANCE_TYPE1_CHARGE
    elseif f16_arg0:HasSpecialEffectId(TARGET_ENE_0, 110293) then
        f16_local0 = PC_ATTACK_DIST_LANCE_TYPE2_CHARGE
    elseif f16_arg0:HasSpecialEffectId(TARGET_ENE_0, 110400) then
        f16_local0 = PC_ATTACK_DIST_SPIN
    elseif f16_arg0:HasSpecialEffectId(TARGET_ENE_0, 110410) then
        f16_local0 = PC_ATTACK_DIST_JUMP_FRONT
    elseif f16_arg0:HasSpecialEffectId(TARGET_ENE_0, 110411) then
        f16_local0 = PC_ATTACK_DIST_JUMP_BACK
    elseif f16_arg0:HasSpecialEffectId(TARGET_ENE_0, 110420) then
        f16_local0 = PC_ATTACK_DIST_MEN_1
    elseif f16_arg0:HasSpecialEffectId(TARGET_ENE_0, 110421) then
        f16_local0 = PC_ATTACK_DIST_MEN_2
    elseif f16_arg0:HasSpecialEffectId(TARGET_ENE_0, 110430) then
        f16_local0 = PC_ATTACK_DIST_KENSEI_IAI
    elseif f16_arg0:HasSpecialEffectId(TARGET_ENE_0, 110440) then
        f16_local0 = PC_ATTACK_DIST_IAI
    elseif f16_arg0:HasSpecialEffectId(TARGET_ENE_0, 110450) then
        f16_local0 = PC_ATTACK_DIST_INVISIBLE_IAI_1
    elseif f16_arg0:HasSpecialEffectId(TARGET_ENE_0, 110451) then
        f16_local0 = PC_ATTACK_DIST_INVISIBLE_IAI_2
    elseif f16_arg0:HasSpecialEffectId(TARGET_ENE_0, 110460) then
        f16_local0 = PC_ATTACK_DIST_HASSOU
    elseif f16_arg0:HasSpecialEffectId(TARGET_ENE_0, 110470) then
        f16_local0 = PC_ATTACK_DIST_HUSHIGIRI_LV1
    elseif f16_arg0:HasSpecialEffectId(TARGET_ENE_0, 110480) then
        f16_local0 = PC_ATTACK_DIST_KICK_RUSH
    elseif f16_arg0:HasSpecialEffectId(TARGET_ENE_0, 110490) then
        f16_local0 = PC_ATTACK_DIST_PUNCHI
    elseif f16_arg0:HasSpecialEffectId(TARGET_ENE_0, 110501) then
        f16_local0 = PC_ATTACK_DIST_GATOTSU
    elseif f16_arg0:HasSpecialEffectId(TARGET_ENE_0, 109970) then
        f16_local0 = PC_ATTACK_DIST_THRUST
    end
    return f16_local0

end

--[[******************************************************************************
    函数名: RankCheck_Parry
    功能: 弹反等级检测 - 检查AI是否应该对特定攻击执行弹反
    Function: Parry rank check - check if AI should parry specific attacks

    参数:
        f17_arg0 - AI实体对象
        f17_arg1 - 未使用
        f17_arg2 - 弹反等级 (0=允许所有弹反, 其他=限制突刺弹反)

    返回值:
        true  - 允许执行弹反
        false - 不允许执行弹反

    说明:
        等级0的AI不应该弹反玩家的突刺攻击(109970)。
        这可能是游戏平衡设计，让低级AI更容易被见切。
******************************************************************************]]
function RankCheck_Parry(f17_arg0, f17_arg1, f17_arg2)
    local f17_local0 = f17_arg0:GetDist(TARGET_ENE_0)
    local f17_local1 = PC_ATTACK_DIST_STAND
    if f17_arg2 == 0 and f17_arg0:HasSpecialEffectId(TARGET_ENE_0, 109970) then
        return false
    else
        return true
    end
    
end

--[[******************************************************************************
    函数名: Interupt_Use_Item
    功能: 道具使用中断处理
    Function: Item usage interrupt handler

    参数:
        f18_arg0 - AI实体对象
        f18_arg1 - 冷却计时器ID (可选)
        f18_arg2 - 冷却时间(秒) (可选)

    返回值:
        true  - 检测到道具使用且满足条件
        false - 未检测到或冷却中

    说明:
        当玩家使用道具时触发。AI可以在此时机进行攻击等操作。
        支持可选的冷却时间限制，避免频繁触发。
******************************************************************************]]
function Interupt_Use_Item(f18_arg0, f18_arg1, f18_arg2)
    local f18_local0 = false
    if f18_arg0:IsInterupt(INTERUPT_UseItem) and f18_arg0:IsStartAttack() == false then
        if f18_arg1 ~= nil then
            if f18_arg0:IsFinishTimer(f18_arg1) then
                f18_local0 = true
                f18_arg0:SetTimer(f18_arg1, f18_arg2)
            end
        else
            f18_local0 = true
        end
    end
    return f18_local0

end

--[[******************************************************************************
    函数名: Interupt_PC_Break
    功能: 玩家破防中断处理
    Function: Player posture break interrupt handler

    参数:
        f19_arg0 - AI实体对象
        f19_arg1 - 冷却计时器ID (可选)
        f19_arg2 - 冷却时间(秒) (可选)

    返回值:
        true  - 检测到玩家破防且满足条件
        false - 未检测到或冷却中

    说明:
        当玩家架势条被打满(破防)时触发。
        这是AI执行处决或高伤害攻击的最佳时机。
******************************************************************************]]
function Interupt_PC_Break(f19_arg0, f19_arg1, f19_arg2)
    local f19_local0 = false
    if f19_arg0:IsInterupt(INTERUPT_ActivateSpecialEffect) and f19_arg0:GetSpecialEffectActivateInterruptType(0) == COMMON_SP_EFFECT_PC_BREAK and f19_arg0:IsStartAttack() == false then
        if f19_arg1 ~= nil then
            if f19_arg0:IsFinishTimer(f19_arg1) then
                f19_local0 = true
                f19_arg0:SetTimer(f19_arg1, f19_arg2)
            end
        else
            f19_local0 = true
        end
    end
    return f19_local0

end

--[[******************************************************************************
    函数名: Check_ReachAttack
    功能: 检测攻击可达性 - 判断目标是否可被攻击以及位置关系
    Function: Check attack reachability and target position relationship

    参数:
        f20_arg0 - AI实体对象
        f20_arg1 - 攻击有效距离(米)

    返回值:
        POSSIBLE_ATTACK (0) - 可以正常攻击
        UNREACH_ATTACK (1) - 目标不可达
        REACH_ATTACK_TARGET_HIGH_POSITION (2) - 目标在高位
        REACH_ATTACK_TARGET_LOW_POSITION (3) - 目标在低位

    检测条件:
        1. 路径检测：是否存在可达路径
        2. 距离检测：目标是否在攻击范围内
        3. 高度检测：目标相对高度 (DistYSigned)
        4. 特效检测：玩家是否处于特殊状态(109220/109221)

    说明:
        用于攻击前的可行性判断。
        如果目标过高或过低，AI可能需要选择特殊攻击或移动调整。
        特效109220/109221可能标识玩家在特殊地形(如钩绳、跳跃)。
******************************************************************************]]
function Check_ReachAttack(f20_arg0, f20_arg1)
    local f20_local0 = POSSIBLE_ATTACK
    local f20_local1 = f20_arg0:GetDist(TARGET_ENE_0)
    local f20_local2 = f20_arg0:GetDistYSigned(TARGET_ENE_0)
    if f20_arg0:CheckDoesExistPathWithSetPoint(TARGET_ENE_0, AI_DIR_TYPE_F, 0, 0) == false then
        if f20_arg1 < f20_local1 then
            f20_local0 = UNREACH_ATTACK
        elseif f20_local2 >= 0 then
            f20_local0 = REACH_ATTACK_TARGET_HIGH_POSITION
        else
            f20_local0 = REACH_ATTACK_TARGET_LOW_POSITION
        end
    elseif f20_arg0:HasSpecialEffectId(TARGET_ENE_0, 109220) or f20_arg0:HasSpecialEffectId(TARGET_ENE_0, 109221) then
        if f20_arg1 < f20_local1 then
            f20_local0 = UNREACH_ATTACK
        elseif f20_local2 >= 0 then
            f20_local0 = REACH_ATTACK_TARGET_HIGH_POSITION
        else
            f20_local0 = REACH_ATTACK_TARGET_LOW_POSITION
        end
    end
    return f20_local0
    
end


