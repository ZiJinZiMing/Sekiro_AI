RegisterTableGoal(GOAL_Rival_710000_Battle, "GOAL_Rival_710000_Battle")
REGISTER_GOAL_NO_UPDATE(GOAL_Rival_710000_Battle, true)

--GOAL_COMMON_CommonAttack:[1]ezStateId,[2]target,[3]successDistance,[4]successAngle,[5]turnTime,[6]turnFaceAngle,[7]isComboEnabled,[8]isTurn,[9]isGuardBreakAttack,[10]isNonspinning,[11]angleUp,[12]angleDown,[13]isCancelAttack

REGISTER_DBG_GOAL_PARAM(GOAL_COMMON_CommonAttack, 0, "ezStateId", 0)
REGISTER_DBG_GOAL_PARAM(GOAL_COMMON_CommonAttack, 1, "target", 0)
REGISTER_DBG_GOAL_PARAM(GOAL_COMMON_CommonAttack, 2, "successDistance", 0)
REGISTER_DBG_GOAL_PARAM(GOAL_COMMON_CommonAttack, 3, "successAngle", 0)
REGISTER_DBG_GOAL_PARAM(GOAL_COMMON_CommonAttack, 4, "turnTime", 0)
REGISTER_DBG_GOAL_PARAM(GOAL_COMMON_CommonAttack, 5, "turnFaceAngle", 0)
REGISTER_DBG_GOAL_PARAM(GOAL_COMMON_CommonAttack, 6, "isComboEnabled", 0)
REGISTER_DBG_GOAL_PARAM(GOAL_COMMON_CommonAttack, 7, "isTurn", 0)
REGISTER_DBG_GOAL_PARAM(GOAL_COMMON_CommonAttack, 8, "isGuardBreakAttack", 0)
REGISTER_DBG_GOAL_PARAM(GOAL_COMMON_CommonAttack, 9, "isNonspinning", 0)
REGISTER_DBG_GOAL_PARAM(GOAL_COMMON_CommonAttack, 10, "angleUp", 0)
REGISTER_DBG_GOAL_PARAM(GOAL_COMMON_CommonAttack, 11, "angleDown", 0)
REGISTER_DBG_GOAL_PARAM(GOAL_COMMON_CommonAttack, 12, "isCancelAttack", 0)

------------------------------------------------------------------------------

--GOAL_COMMON_SidewayMove:moveTarget,isRight,stopAngle,isWalk,successOnEnd,guardStateId,guardEndType
REGISTER_DBG_GOAL_PARAM(GOAL_COMMON_SidewayMove, 0, "moveTarget", 0)
REGISTER_DBG_GOAL_PARAM(GOAL_COMMON_SidewayMove, 1, "isRight", 0)
REGISTER_DBG_GOAL_PARAM(GOAL_COMMON_SidewayMove, 2, "stopAngle", 0)
REGISTER_DBG_GOAL_PARAM(GOAL_COMMON_SidewayMove, 3, "isWalk", 0)
REGISTER_DBG_GOAL_PARAM(GOAL_COMMON_SidewayMove, 4, "successOnEnd", 0)
REGISTER_DBG_GOAL_PARAM(GOAL_COMMON_SidewayMove, 5, "guardStateId", 0)
REGISTER_DBG_GOAL_PARAM(GOAL_COMMON_SidewayMove, 6, "guardEndType", 0)




function log( message)

    local time = os.date("%H-%M-%S")

    if not logFile then
        logFile = io.open(string.format("D:\\Sekiro\\Log\\%s.log",time), "w")
    end

    logFile:write(string.format("[%s] [INFO] %s\n", time, message))
    logFile:flush()

end

Goal.Initialize = function (f1_arg0, f1_arg1, f1_arg2, f1_arg3)
    
end

--[[
================================================================================
Goal.Activate - 主激活函数（行为决策入口）
================================================================================
功能说明：
  当AI进入战斗状态时调用，根据距离、血量、架势值等条件，通过权重系统选择攻击行为。

参数说明：
  f2_arg0: Goal对象（包含各种Act行为函数）
  f2_arg1: AI控制器（提供各种AI查询和设置方法）
  f2_arg2: 目标管理器（用于子目标管理）

关键变量：
  f2_local0: 行为权重表（索引对应不同的Act函数）
  f2_local1: 行为函数注册表
  f2_local3: 与玩家的距离
  f2_local5: 自身血量百分比
  f2_local6: 自身架势值(Sp/Posture)
  f2_local7: 忍杀次数

监视的特效ID（自身）:
  5025-5031: 逻辑判定用通用效果6-12
  3710010: 宿敌_攻击未被防御判定（减少剑戟计数）
  3710020: 宿敌_被忍杀判定（剑戟计数归零）
  3710030: AI中断判定_累加弹反
  3710031: AI中断判定_被向右弹开_强_连接到直接攻击

监视的特效ID（玩家TARGET_ENE_0）:
  110010: 回生之术_假死效果（玩家装死）
  3710050: 宿敌_回旋踢命中
  110620: 居合架势专用对策命令（玩家进入居合架势）
================================================================================
--]]
Goal.Activate = function (f2_arg0, f2_arg1, f2_arg2)
    Init_Pseudo_Global(f2_arg1, f2_arg2)
    local f2_local0 = {}       -- 行为权重表
    local f2_local1 = {}       -- 行为函数表
    local f2_local2 = {}       -- 附加参数表
    Common_Clear_Param(f2_local0, f2_local1, f2_local2)
    local f2_local3 = f2_arg1:GetDist(TARGET_ENE_0)        -- 与玩家距离
    local f2_local4 = f2_arg1:GetExcelParam(AI_EXCEL_THINK_PARAM_TYPE__thinkAttr_doAdmirer)
    local f2_local5 = f2_arg1:GetHpRate(TARGET_SELF)       -- 自身血量百分比
    local f2_local6 = f2_arg1:GetSp(TARGET_SELF)           -- 自身架势值
    local f2_local7 = f2_arg1:GetNinsatsuNum()             -- 忍杀次数
    -- 监视自身特效：逻辑判定用通用效果
    f2_arg1:AddObserveSpecialEffectAttribute(TARGET_SELF, 5025)    -- 逻辑判定用通用效果6
    f2_arg1:AddObserveSpecialEffectAttribute(TARGET_SELF, 5026)    -- 逻辑判定用通用效果7
    f2_arg1:AddObserveSpecialEffectAttribute(TARGET_SELF, 5029)    -- 逻辑判定用通用效果10
    f2_arg1:AddObserveSpecialEffectAttribute(TARGET_SELF, 5030)    -- 逻辑判定用通用效果11
    f2_arg1:AddObserveSpecialEffectAttribute(TARGET_SELF, 5031)    -- 逻辑判定用通用效果12
    -- 监视自身特效：宿敌相关判定
    f2_arg1:AddObserveSpecialEffectAttribute(TARGET_SELF, 3710010) -- 宿敌_攻击未被防御判定
    f2_arg1:AddObserveSpecialEffectAttribute(TARGET_SELF, 3710020) -- 宿敌_被忍杀判定
    f2_arg1:AddObserveSpecialEffectAttribute(TARGET_SELF, 3710030) -- AI中断判定_累加弹反
    f2_arg1:AddObserveSpecialEffectAttribute(TARGET_SELF, 3710031) -- AI中断判定_被向右弹开
    -- 监视玩家特效
    f2_arg1:AddObserveSpecialEffectAttribute(TARGET_ENE_0, 110010) -- 回生之术_假死效果
    f2_arg1:AddObserveSpecialEffectAttribute(TARGET_ENE_0, 3710050)-- 宿敌_回旋踢命中
    f2_arg1:AddObserveSpecialEffectAttribute(TARGET_ENE_0, 110620) -- 居合架势专用对策命令
    Set_ConsecutiveGuardCount_Interrupt(f2_arg1)
    f2_arg1:DeleteObserve(0)
    if f2_arg0.Kengeki_Activate(f2_arg0, f2_arg1, f2_arg2) then
        return
    end
    if f2_arg1:HasSpecialEffectId(TARGET_ENE_0, 110060) or f2_arg1:HasSpecialEffectId(TARGET_ENE_0, 110010) then
        if f2_arg1:IsInsideTarget(TARGET_ENE_0, AI_DIR_TYPE_F, 90) then
            f2_local0[21] = 1
            f2_local0[28] = 100
        else
            f2_local0[21] = 100
        end
    elseif Common_ActivateAct(f2_arg1, f2_arg2, 0, 1) then
    elseif f2_arg1:GetNumber(7) == 0 and f2_arg1:HasSpecialEffectId(TARGET_SELF, 200050) then
        f2_local0[15] = 600
    elseif f2_arg1:HasSpecialEffectId(TARGET_ENE_0, 110030) then
        f2_local0[28] = 100
    elseif f2_arg1:IsInsideTarget(TARGET_ENE_0, AI_DIR_TYPE_B, 180) then
        f2_local0[21] = 100
        f2_local0[22] = 1
    elseif f2_arg1:HasSpecialEffectId(TARGET_ENE_0, 110060) or f2_arg1:HasSpecialEffectId(TARGET_ENE_0, 110010) then
        f2_local0[27] = 100
    elseif f2_local3 >= 7 then
        f2_local0[10] = 300
        f2_local0[15] = 600
    elseif f2_local3 >= 5 then
        f2_local0[10] = 300
        f2_local0[34] = 100
        f2_local0[23] = 100
        if f2_local6 <= 360 then
            f2_local0[9] = 300
        end
    elseif f2_local3 > 3 then
        f2_local0[1] = 5
        f2_local0[2] = 10
        f2_local0[6] = 30
        f2_local0[11] = 15
        f2_local0[23] = 15
        if f2_local6 <= 360 then
            f2_local0[9] = 300
        end
    else
        f2_local0[3] = 15
        f2_local0[11] = 15
        f2_local0[23] = 10
        f2_local0[31] = 30
        if f2_arg1:IsFinishTimer(7) == true then
            f2_local0[24] = 30
        end
    end
    if (f2_arg1:HasSpecialEffectId(TARGET_ENE_0, 109031) or f2_arg1:HasSpecialEffectId(TARGET_ENE_0, 110125)) and f2_local3 <= 5 then
        f2_local0[16] = 100
    end
    if f2_arg1:HasSpecialEffectId(TARGET_ENE_0, 109900) then
        f2_local0[1] = 5
        f2_local0[2] = 5
        f2_local0[3] = 5
        f2_local0[9] = 0
        f2_local0[11] = 5
        f2_local0[10] = 30
        f2_local0[15] = 0
        f2_local0[31] = 0
        f2_local0[48] = 30
    end
    if f2_arg1:GetNumber(2) == 1 then
        f2_local0[23] = 6000
        f2_arg1:SetNumber(2, 0)
    end
    if f2_arg1:IsFinishTimer(0) == false then
        f2_local0[3] = 0
        f2_local0[6] = 1
    end
    if f2_arg1:IsFinishTimer(1) == false then
        f2_local0[2] = 0
    end
    if f2_arg1:IsFinishTimer(3) == false then
        f2_local0[24] = 0
    end
    if f2_arg1:IsFinishTimer(6) == false then
        f2_local0[9] = 0
    end
    if f2_arg1:HasSpecialEffectId(TARGET_SELF, 200051) then
        f2_local0[15] = 0
        f2_local0[18] = 0
        f2_local0[19] = 0
        f2_local0[34] = 0
        f2_local0[48] = 0
    end
    if SpaceCheck(f2_arg1, f2_arg2, 45, 2) == false and SpaceCheck(f2_arg1, f2_arg2, -45, 2) == false then
        f2_local0[22] = 0
    end
    if SpaceCheck(f2_arg1, f2_arg2, 90, 1) == false and SpaceCheck(f2_arg1, f2_arg2, -90, 1) == false then
        f2_local0[23] = 0
    end
    if SpaceCheck(f2_arg1, f2_arg2, 180, 2) == false then
        f2_local0[24] = 0
    end
    if SpaceCheck(f2_arg1, f2_arg2, 180, 1) == false then
        f2_local0[25] = 0
    end
    if f2_arg1:HasSpecialEffectId(TARGET_ENE_0, 110621) then
        f2_local0[23] = 0
        f2_local0[24] = 0
        f2_local0[31] = 10
    end
    f2_local0[1] = SetCoolTime(f2_arg1, f2_arg2, 3000, 15, f2_local0[1], 1)
    f2_local0[2] = SetCoolTime(f2_arg1, f2_arg2, 3004, 15, f2_local0[2], 1)
    f2_local0[3] = SetCoolTime(f2_arg1, f2_arg2, 3005, 15, f2_local0[3], 1)
    f2_local0[4] = SetCoolTime(f2_arg1, f2_arg2, 3006, 15, f2_local0[4], 1)
    f2_local0[5] = SetCoolTime(f2_arg1, f2_arg2, 3007, 15, f2_local0[5], 1)
    f2_local0[6] = SetCoolTime(f2_arg1, f2_arg2, 3016, 15, f2_local0[6], 1)
    f2_local0[7] = SetCoolTime(f2_arg1, f2_arg2, 3020, 15, f2_local0[7], 1)
    f2_local0[8] = SetCoolTime(f2_arg1, f2_arg2, 3021, 15, f2_local0[8], 1)
    f2_local0[9] = SetCoolTime(f2_arg1, f2_arg2, 3092, 15, f2_local0[9], 1)
    f2_local0[10] = SetCoolTime(f2_arg1, f2_arg2, 3006, 15, f2_local0[10], 1)
    f2_local0[11] = SetCoolTime(f2_arg1, f2_arg2, 3037, 15, f2_local0[11], 1)
    f2_local0[13] = SetCoolTime(f2_arg1, f2_arg2, 3011, 15, f2_local0[13], 1)
    f2_local0[14] = SetCoolTime(f2_arg1, f2_arg2, 3014, 15, f2_local0[14], 1)
    f2_local0[15] = SetCoolTime(f2_arg1, f2_arg2, 3014, 15, f2_local0[15], 1)
    f2_local0[18] = SetCoolTime(f2_arg1, f2_arg2, 3040, 15, f2_local0[18], 1)
    f2_local0[30] = SetCoolTime(f2_arg1, f2_arg2, 3006, 15, f2_local0[30], 1)
    f2_local0[31] = SetCoolTime(f2_arg1, f2_arg2, 3045, 15, f2_local0[31], 1)
    f2_local0[32] = SetCoolTime(f2_arg1, f2_arg2, 3006, 15, f2_local0[32], 1)
    f2_local0[34] = SetCoolTime(f2_arg1, f2_arg2, 3007, 15, f2_local0[34], 1)
    f2_local0[38] = SetCoolTime(f2_arg1, f2_arg2, 3006, 15, f2_local0[38], 1)
    f2_local0[48] = SetCoolTime(f2_arg1, f2_arg2, 3013, 5, f2_local0[48], 1)
    f2_local1[1] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act01)
    f2_local1[2] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act02)
    f2_local1[3] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act03)
    f2_local1[5] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act05)
    f2_local1[6] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act06)
    f2_local1[7] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act07)
    f2_local1[8] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act08)
    f2_local1[9] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act09)
    f2_local1[10] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act10)
    f2_local1[11] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act11)
    f2_local1[15] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act15)
    f2_local1[16] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act16)
    f2_local1[18] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act18)
    f2_local1[19] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act19)
    f2_local1[20] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act20)
    f2_local1[21] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act21)
    f2_local1[22] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act22)
    f2_local1[23] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act23)
    f2_local1[24] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act24)
    f2_local1[25] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act25)
    f2_local1[26] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act26)
    f2_local1[27] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act27)
    f2_local1[28] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act28)
    f2_local1[30] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act30)
    f2_local1[31] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act31)
    f2_local1[34] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act34)
    f2_local1[40] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act40)
    f2_local1[41] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act41)
    f2_local1[42] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act42)
    f2_local1[45] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act45)
    f2_local1[46] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act46)
    f2_local1[47] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act47)
    f2_local1[48] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act48)
    local f2_local8 = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.ActAfter_AdjustSpace)
    Common_Battle_Activate(f2_arg1, f2_arg2, f2_local0, f2_local1, f2_local8, f2_local2)
    
end

Goal.Act01 = function (f3_arg0, f3_arg1, f3_arg2)
    local f3_local0 = 3.6 - f3_arg0:GetMapHitRadius(TARGET_SELF)
    local f3_local1 = 3.6 - f3_arg0:GetMapHitRadius(TARGET_SELF) + 2
    local f3_local2 = 3.6 - f3_arg0:GetMapHitRadius(TARGET_SELF) + 3
    local f3_local3 = 100
    local f3_local4 = 0
    local f3_local5 = 2.5
    local f3_local6 = 3
    local f3_local7 = f3_arg0:GetRandam_Int(1, 100)
    Approach_Act_Flex(f3_arg0, f3_arg1, f3_local0, f3_local1, f3_local2, f3_local3, f3_local4, f3_local5, f3_local6)
    local f3_local8 = 3.5 - f3_arg0:GetMapHitRadius(TARGET_SELF)
    local f3_local9 = 3.4 - f3_arg0:GetMapHitRadius(TARGET_SELF)
    local f3_local10 = 3.4 - f3_arg0:GetMapHitRadius(TARGET_SELF)
    local f3_local11 = 0
    local f3_local12 = 0
    if f3_local7 <= 30 then
        f3_arg1:AddSubGoal(GOAL_COMMON_ComboAttackTunableSpin, 10, 3000, TARGET_ENE_0, f3_local8, f3_local11, f3_local12, 0, 0)
        f3_arg1:AddSubGoal(GOAL_COMMON_ComboRepeat, 10, 3001, TARGET_ENE_0, f3_local9, 0)
        f3_arg1:AddSubGoal(GOAL_COMMON_ComboRepeat, 10, 3002, TARGET_ENE_0, f3_local10, 0)
        f3_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3003, TARGET_ENE_0, 9999, 0, 0)
    else
        f3_arg1:AddSubGoal(GOAL_COMMON_ComboAttackTunableSpin, 10, 3000, TARGET_ENE_0, f3_local8, f3_local11, f3_local12, 0, 0)
        f3_arg1:AddSubGoal(GOAL_COMMON_ComboRepeat, 10, 3001, TARGET_ENE_0, 3.5, 0)
        f3_arg1:AddSubGoal(GOAL_COMMON_ComboRepeat, 10, 3010, TARGET_ENE_0, 5, 0)
        f3_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3025, TARGET_ENE_0, 9999, 0, 0)
    end

    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
end

Goal.Act02 = function (f4_arg0, f4_arg1, f4_arg2)
    local f4_local0 = 3.2 - f4_arg0:GetMapHitRadius(TARGET_SELF)
    local f4_local1 = 3.2 - f4_arg0:GetMapHitRadius(TARGET_SELF) + 2
    local f4_local2 = 3.2 - f4_arg0:GetMapHitRadius(TARGET_SELF) + 3
    local f4_local3 = 100
    local f4_local4 = 0
    local f4_local5 = 2.5
    local f4_local6 = 3
    Approach_Act_Flex(f4_arg0, f4_arg1, f4_local0, f4_local1, f4_local2, f4_local3, f4_local4, f4_local5, f4_local6)
    local f4_local7 = 0
    local f4_local8 = 0
    f4_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 10, 3004, TARGET_ENE_0, 9999, f4_local7, f4_local8, 0, 0)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act03 = function (f5_arg0, f5_arg1, f5_arg2)
    local f5_local0 = 2.2 - f5_arg0:GetMapHitRadius(TARGET_SELF)
    local f5_local1 = 2.2 - f5_arg0:GetMapHitRadius(TARGET_SELF) + 0.3
    local f5_local2 = 2.2 - f5_arg0:GetMapHitRadius(TARGET_SELF) + 2
    local f5_local3 = 0
    local f5_local4 = 0
    local f5_local5 = 1.5
    local f5_local6 = 3
    Approach_Act_Flex(f5_arg0, f5_arg1, f5_local0, f5_local1, f5_local2, f5_local3, f5_local4, f5_local5, f5_local6)
    local f5_local7 = 0
    local f5_local8 = 0
    local f5_local9 = 180
    local f5_local10 = 3
    f5_arg0:AddObserveArea(0, TARGET_SELF, TARGET_ENE_0, AI_DIR_TYPE_B, f5_local9, f5_local10)
    f5_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 10, 3005, TARGET_ENE_0, 9999, f5_local7, f5_local8, 0, 0)
    f5_arg0:SetTimer(0, 7)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act05 = function (f6_arg0, f6_arg1, f6_arg2)
    local f6_local0 = 5.9 - f6_arg0:GetMapHitRadius(TARGET_SELF)
    local f6_local1 = 5.9 - f6_arg0:GetMapHitRadius(TARGET_SELF)
    local f6_local2 = 5.9 - f6_arg0:GetMapHitRadius(TARGET_SELF)
    local f6_local3 = 100
    local f6_local4 = 0
    local f6_local5 = 2.5
    local f6_local6 = 3
    Approach_Act_Flex(f6_arg0, f6_arg1, f6_local0, f6_local1, f6_local2, f6_local3, f6_local4, f6_local5, f6_local6)
    local f6_local7 = 0
    local f6_local8 = 0
    f6_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 10, 3007, TARGET_ENE_0, 9999, f6_local7, f6_local8, 0, 0)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act06 = function (f7_arg0, f7_arg1, f7_arg2)
    local f7_local0 = 5.2 - f7_arg0:GetMapHitRadius(TARGET_SELF)
    local f7_local1 = 5.2 - f7_arg0:GetMapHitRadius(TARGET_SELF) + 2
    local f7_local2 = 5.2 - f7_arg0:GetMapHitRadius(TARGET_SELF) + 3
    local f7_local3 = 100
    local f7_local4 = 0
    local f7_local5 = 1.5
    local f7_local6 = 3
    Approach_Act_Flex(f7_arg0, f7_arg1, f7_local0, f7_local1, f7_local2, f7_local3, f7_local4, f7_local5, f7_local6)
    local f7_local7 = 0
    local f7_local8 = 0
    f7_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 10, 3016, TARGET_ENE_0, 9999, f7_local7, f7_local8, 0, 0)
    f7_arg0:SetTimer(0, 5)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act09 = function (f8_arg0, f8_arg1, f8_arg2)
    local f8_local0 = 4.5 - f8_arg0:GetMapHitRadius(TARGET_SELF)
    local f8_local1 = 4.5 - f8_arg0:GetMapHitRadius(TARGET_SELF)
    local f8_local2 = 4.5 - f8_arg0:GetMapHitRadius(TARGET_SELF)
    local f8_local3 = 100
    local f8_local4 = 0
    local f8_local5 = 1.5
    local f8_local6 = 3
    Approach_Act_Flex(f8_arg0, f8_arg1, f8_local0, f8_local1, f8_local2, f8_local3, f8_local4, f8_local5, f8_local6)
    local f8_local7 = 0
    local f8_local8 = 0
    f8_arg1:AddSubGoal(GOAL_COMMON_ComboAttackTunableSpin, 10, 3040, TARGET_ENE_0, 4, f8_local7, f8_local8, 0, 0)
    f8_arg1:AddSubGoal(GOAL_COMMON_ComboRepeat, 10, 3041, TARGET_ENE_0, 3.5, 0)
    f8_arg0:SetTimer(6, 30)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act10 = function (f9_arg0, f9_arg1, f9_arg2)
    local f9_local0 = 4.8 - f9_arg0:GetMapHitRadius(TARGET_SELF)
    local f9_local1 = 4.8 - f9_arg0:GetMapHitRadius(TARGET_SELF)
    local f9_local2 = 4.8 - f9_arg0:GetMapHitRadius(TARGET_SELF)
    local f9_local3 = 100
    local f9_local4 = 0
    local f9_local5 = 10
    local f9_local6 = 10
    Approach_Act_Flex(f9_arg0, f9_arg1, f9_local0, f9_local1, f9_local2, f9_local3, f9_local4, f9_local5, f9_local6)
    local f9_local7 = 0
    local f9_local8 = 0
    f9_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 10, 3006, TARGET_ENE_0, 9999, f9_local7, f9_local8, 0, 0)
    f9_arg0:SetTimer(3, 10)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act11 = function (f10_arg0, f10_arg1, f10_arg2)
    local f10_local0 = 3.2 - f10_arg0:GetMapHitRadius(TARGET_SELF)
    local f10_local1 = 3.2 - f10_arg0:GetMapHitRadius(TARGET_SELF) + 2
    local f10_local2 = 3.2 - f10_arg0:GetMapHitRadius(TARGET_SELF) + 3
    local f10_local3 = 100
    local f10_local4 = 0
    local f10_local5 = 3
    local f10_local6 = 3
    Approach_Act_Flex(f10_arg0, f10_arg1, f10_local0, f10_local1, f10_local2, f10_local3, f10_local4, f10_local5, f10_local6)
    f10_arg1:AddSubGoal(GOAL_COMMON_ComboAttackTunableSpin, 10, 3037, TARGET_ENE_0, 6, 0)
    f10_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3020, TARGET_ENE_0, 9999, 0, 0)
    
end

Goal.Act15 = function (f11_arg0, f11_arg1, f11_arg2)
    local f11_local0 = 8.9 - f11_arg0:GetMapHitRadius(TARGET_SELF)
    local f11_local1 = 8.9 - f11_arg0:GetMapHitRadius(TARGET_SELF) - 2
    local f11_local2 = 8.9 - f11_arg0:GetMapHitRadius(TARGET_SELF)
    local f11_local3 = 100
    local f11_local4 = 0
    local f11_local5 = 1.5
    local f11_local6 = 3
    Approach_Act_Flex(f11_arg0, f11_arg1, f11_local0, f11_local1, f11_local2, f11_local3, f11_local4, f11_local5, f11_local6)
    local f11_local7 = 0
    local f11_local8 = 0
    local f11_local9 = 7 - f11_arg0:GetMapHitRadius(TARGET_SELF)
    f11_arg1:AddSubGoal(GOAL_COMMON_ComboAttackTunableSpin, 10, 3014, TARGET_ENE_0, f11_local9, f11_local7, f11_local8, 0, 0)
    f11_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3015, TARGET_ENE_0, 9999, 0, 0)
    f11_arg0:SetNumber(7, 1)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act16 = function (f12_arg0, f12_arg1, f12_arg2)
    local f12_local0 = 2.5 - f12_arg0:GetMapHitRadius(TARGET_SELF)
    local f12_local1 = 2.5 - f12_arg0:GetMapHitRadius(TARGET_SELF)
    local f12_local2 = 2.5 - f12_arg0:GetMapHitRadius(TARGET_SELF)
    local f12_local3 = 100
    local f12_local4 = 0
    local f12_local5 = 1.5
    local f12_local6 = 3
    local f12_local7 = f12_arg0:GetRandam_Int(1, 100)
    Approach_Act_Flex(f12_arg0, f12_arg1, f12_local0, f12_local1, f12_local2, f12_local3, f12_local4, f12_local5, f12_local6)
    local f12_local8 = 0
    local f12_local9 = 0
    local f12_local10 = 7 - f12_arg0:GetMapHitRadius(TARGET_SELF)
    f12_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 10, 3022, TARGET_ENE_0, 9999, f12_local8, f12_local9, 0, 0)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act20 = function (f13_arg0, f13_arg1, f13_arg2)
    local f13_local0 = 3.2 - f13_arg0:GetMapHitRadius(TARGET_SELF)
    local f13_local1 = 3.2 - f13_arg0:GetMapHitRadius(TARGET_SELF) + 1
    local f13_local2 = 3.2 - f13_arg0:GetMapHitRadius(TARGET_SELF) + 2
    local f13_local3 = 100
    local f13_local4 = 0
    local f13_local5 = 2.5
    local f13_local6 = 3
    Approach_Act_Flex(f13_arg0, f13_arg1, f13_local0, f13_local1, f13_local2, f13_local3, f13_local4, f13_local5, f13_local6)
    local f13_local7 = 0
    local f13_local8 = 0
    f13_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 10, 3062, TARGET_ENE_0, 9999, f13_local7, f13_local8, 0, 0)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act21 = function (f14_arg0, f14_arg1, f14_arg2)
    local f14_local0 = 3
    local f14_local1 = 45
    f14_arg1:AddSubGoal(GOAL_COMMON_Turn, f14_local0, TARGET_ENE_0, f14_local1, -1, GOAL_RESULT_Success, true)
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
    
end

Goal.Act22 = function (f15_arg0, f15_arg1, f15_arg2)
    local f15_local0 = 3
    local f15_local1 = 0
    if SpaceCheck(f15_arg0, f15_arg1, -45, 2) == true then
        if SpaceCheck(f15_arg0, f15_arg1, 45, 2) == true then
            if f15_arg0:IsInsideTarget(TARGET_ENE_0, AI_DIR_TYPE_R, 180) then
                f15_arg1:AddSubGoal(GOAL_COMMON_SpinStep, f15_local0, 5202, TARGET_ENE_0, f15_local1, AI_DIR_TYPE_L, 0)
            else
                f15_arg1:AddSubGoal(GOAL_COMMON_SpinStep, f15_local0, 5203, TARGET_ENE_0, f15_local1, AI_DIR_TYPE_R, 0)
            end
        else
            f15_arg1:AddSubGoal(GOAL_COMMON_SpinStep, f15_local0, 5202, TARGET_ENE_0, f15_local1, AI_DIR_TYPE_L, 0)
        end
    elseif SpaceCheck(f15_arg0, f15_arg1, 45, 2) == true then
        f15_arg1:AddSubGoal(GOAL_COMMON_SpinStep, f15_local0, 5203, TARGET_ENE_0, f15_local1, AI_DIR_TYPE_R, 0)
    else
    end
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
    
end

Goal.Act23 = function (f16_arg0, f16_arg1, f16_arg2)
    local f16_local0 = f16_arg0:GetDist(TARGET_ENE_0)
    local f16_local1 = f16_arg0:GetSp(TARGET_SELF)
    local f16_local2 = 20
    local f16_local3 = f16_arg0:GetRandam_Int(1, 100)
    local f16_local4 = -1
    local f16_local5 = 0
    if SpaceCheck(f16_arg0, f16_arg1, -90, 1) == true then
        if SpaceCheck(f16_arg0, f16_arg1, 90, 1) == true then
            if f16_arg0:IsInsideTargetEx(TARGET_ENE_0, TARGET_SELF, AI_DIR_TYPE_R, 180, 5) then
                f16_local5 = 1
            else
                f16_local5 = 0
            end
        else
            f16_local5 = 0
        end
    elseif SpaceCheck(f16_arg0, f16_arg1, 90, 1) == true then
        f16_local5 = 1
    else
    end
    local f16_local6 = f16_arg0:GetRandam_Int(1.5, 3)
    local f16_local7 = f16_arg0:GetRandam_Int(30, 45)
    f16_arg0:SetNumber(10, f16_local5)
    f16_arg1:AddSubGoal(GOAL_COMMON_SidewayMove, f16_local6, TARGET_ENE_0, f16_local5, f16_local7, true, true, f16_local4)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act24 = function (f17_arg0, f17_arg1, f17_arg2)
    local f17_local0 = f17_arg0:GetDist(TARGET_ENE_0)
    local f17_local1 = 3
    local f17_local2 = 0
    local f17_local3 = 5201
    local f17_local4 = f17_arg0:GetSpRate(TARGET_SELF)
    if SpaceCheck(f17_arg0, f17_arg1, 180, 2) ~= true or SpaceCheck(f17_arg0, f17_arg1, 180, 4) ~= true or f17_local0 > 4 then
    else
        f17_local3 = 5201
        if false then
        else
        end
    end
    f17_arg0:SetNumber(2, 1)
    f17_arg1:AddSubGoal(GOAL_COMMON_SpinStep, f17_local1, f17_local3, TARGET_ENE_0, f17_local2, AI_DIR_TYPE_B, 0):TimingSetTimer(3, 30, AI_TIMING_SET__UPDATE_SUCCESS)
    if f17_local4 <= 0.7 and f17_arg0:HasSpecialEffectId(TARGET_SELF, 200050) then
        f17_arg1:AddSubGoal(GOAL_COMMON_ComboRepeat, 10, 3044, TARGET_ENE_0, DistToAtt1, f17_local2, FrontAngle, 0, 0)
    end
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act25 = function (f18_arg0, f18_arg1, f18_arg2)
    local f18_local0 = f18_arg0:GetRandam_Float(2, 4)
    local f18_local1 = f18_arg0:GetRandam_Float(1, 3)
    local f18_local2 = f18_arg0:GetDist(TARGET_ENE_0)
    local f18_local3 = -1
    if SpaceCheck(f18_arg0, f18_arg1, 180, 1) == true then
        f18_arg1:AddSubGoal(GOAL_COMMON_LeaveTarget, f18_local0, TARGET_ENE_0, f18_local1, TARGET_ENE_0, true, f18_local3)
    else
    end
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
    
end

Goal.Act26 = function (f19_arg0, f19_arg1, f19_arg2)
    f19_arg1:AddSubGoal(GOAL_COMMON_Wait, 0.5, TARGET_SELF, 0, 0, 0)
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
    
end

Goal.Act27 = function (f20_arg0, f20_arg1, f20_arg2)
    local f20_local0 = f20_arg0:GetDist(TARGET_ENE_0)
    local f20_local1 = f20_arg0:GetRandam_Int(1, 100)
    local f20_local2 = 8
    local f20_local3 = 5
    local f20_local4 = f20_arg0:GetRandam_Float(2, 4)
    local f20_local5 = f20_arg0:GetRandam_Int(30, 45)
    if f20_local0 >= 8 then
        f20_arg1:AddSubGoal(GOAL_COMMON_ApproachTarget, f20_local4, TARGET_ENE_0, f20_local2, TARGET_ENE_0, true, -1)
    elseif f20_local0 <= 5 then
        f20_arg1:AddSubGoal(GOAL_COMMON_LeaveTarget, f20_local4, TARGET_ENE_0, f20_local3, TARGET_ENE_0, true, -1)
    end
    f20_arg1:AddSubGoal(GOAL_COMMON_SidewayMove, f20_local4, TARGET_ENE_0, f20_arg0:GetRandam_Int(0, 1), f20_local5, true, true, -1)
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
    
end

Goal.Act28 = function (f21_arg0, f21_arg1, f21_arg2)
    local f21_local0 = f21_arg0:GetDist(TARGET_ENE_0)
    local f21_local1 = 1.5
    local f21_local2 = 1.5
    local f21_local3 = f21_arg0:GetRandam_Int(30, 45)
    local f21_local4 = -1
    local f21_local5 = f21_arg0:GetRandam_Int(0, 1)
    if f21_local0 <= 3 then
        f21_arg1:AddSubGoal(GOAL_COMMON_SidewayMove, f21_local1, TARGET_ENE_0, f21_local5, f21_local3, true, true, f21_local4)
    elseif f21_local0 <= 8 then
        f21_arg1:AddSubGoal(GOAL_COMMON_ApproachTarget, f21_local2, TARGET_ENE_0, 3, TARGET_SELF, true, -1)
    else
        f21_arg1:AddSubGoal(GOAL_COMMON_ApproachTarget, f21_local2, TARGET_ENE_0, 8, TARGET_SELF, false, -1)
    end
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
    
end

Goal.Act30 = function (f22_arg0, f22_arg1, f22_arg2)
    f22_arg1:AddSubGoal(GOAL_COMMON_ComboAttackTunableSpin, 99999, 3009, TARGET_ENE_0, 9999, TurnTime, FrontAngle, 0, 0)
    f22_arg1:AddSubGoal(GOAL_COMMON_ComboRepeat, 99999, 3044, TARGET_ENE_0, DistToAtt1, TurnTime, FrontAngle, 0, 0)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act31 = function (f23_arg0, f23_arg1, f23_arg2)
    local f23_local0 = 3.6 - f23_arg0:GetMapHitRadius(TARGET_SELF)
    local f23_local1 = 3.6 - f23_arg0:GetMapHitRadius(TARGET_SELF) + 2
    local f23_local2 = 3.6 - f23_arg0:GetMapHitRadius(TARGET_SELF) + 2
    local f23_local3 = 100
    local f23_local4 = 0
    local f23_local5 = 1.5
    local f23_local6 = 3
    Approach_Act_Flex(f23_arg0, f23_arg1, f23_local0, f23_local1, f23_local2, f23_local3, f23_local4, f23_local5, f23_local6)
    local f23_local7 = 0
    local f23_local8 = 0
    local f23_local9 = 999 - f23_arg0:GetMapHitRadius(TARGET_SELF)
    f23_arg1:AddSubGoal(GOAL_COMMON_ComboAttackTunableSpin, 10, 3003, TARGET_ENE_0, f23_local9, f23_local7, f23_local8, 0, 0)
    f23_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3045, TARGET_ENE_0, 9999, 0, 0)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act34 = function (f24_arg0, f24_arg1, f24_arg2)
    local f24_local0 = 5.9 - f24_arg0:GetMapHitRadius(TARGET_SELF)
    local f24_local1 = 5.9 - f24_arg0:GetMapHitRadius(TARGET_SELF) + 2
    local f24_local2 = 5.9 - f24_arg0:GetMapHitRadius(TARGET_SELF) + 2
    local f24_local3 = 100
    local f24_local4 = 0
    local f24_local5 = 1.5
    local f24_local6 = 3
    Approach_Act_Flex(f24_arg0, f24_arg1, f24_local0, f24_local1, f24_local2, f24_local3, f24_local4, f24_local5, f24_local6)
    local f24_local7 = 0
    local f24_local8 = 0
    local f24_local9 = 999 - f24_arg0:GetMapHitRadius(TARGET_SELF)
    f24_arg1:AddSubGoal(GOAL_COMMON_ComboAttackTunableSpin, 10, 3007, TARGET_ENE_0, f24_local9, f24_local7, f24_local8, 0, 0)
    f24_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3011, TARGET_ENE_0, 9999, 0, 0)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act48 = function (f25_arg0, f25_arg1, f25_arg2)
    local f25_local0 = 8.9 - f25_arg0:GetMapHitRadius(TARGET_SELF)
    local f25_local1 = 8.9 - f25_arg0:GetMapHitRadius(TARGET_SELF) - 2
    local f25_local2 = 8.9 - f25_arg0:GetMapHitRadius(TARGET_SELF)
    local f25_local3 = 100
    local f25_local4 = 0
    local f25_local5 = 1.5
    local f25_local6 = 3
    Approach_Act_Flex(f25_arg0, f25_arg1, f25_local0, f25_local1, f25_local2, f25_local3, f25_local4, f25_local5, f25_local6)
    local f25_local7 = 0
    local f25_local8 = 0
    local f25_local9 = 7 - f25_arg0:GetMapHitRadius(TARGET_SELF)
    f25_arg1:AddSubGoal(GOAL_COMMON_ComboAttackTunableSpin, 10, 3013, TARGET_ENE_0, f25_local9, f25_local7, f25_local8, 0, 0)
    f25_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3015, TARGET_ENE_0, 9999, 0, 0)
    f25_arg0:SetNumber(7, 1)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

--[[
================================================================================
Goal.Interrupt - 中断处理函数
================================================================================
功能说明：
  处理各种中断事件，包括弹反时机、射击反应、特效激活等。
  当满足特定条件时，会打断当前行为并执行对应的响应动作。

参数说明：
  f26_arg0: Goal对象
  f26_arg1: AI控制器
  f26_arg2: 目标管理器

关键变量：
  f26_local0: 激活的特效中断类型ID
  f26_local1: 失活的特效中断类型ID
  f26_local2: 与玩家距离
  f26_local3: 随机数(1-100)
  f26_local4: 忍杀次数

处理的中断类型：
  INTERUPT_ParryTiming: 弹反时机中断 -> 调用Parry函数
  INTERUPT_ShootImpact: 射击命中中断 -> 调用ShootReaction
  INTERUPT_ActivateSpecialEffect: 特效激活中断

特效ID响应逻辑：
  3710020: 被忍杀判定 -> 重置剑戟计数
  3710030+3710032: 累加弹反+被向左弹开 -> 执行反击(GOAL_COMMON_EndureAttack)
  5029: 逻辑判定通用效果10 -> 调用Damaged受伤响应
  5031: 逻辑判定通用效果12 -> 第一次忍杀且距离>=4.1时追击
  3710050: 回旋踢命中 -> 50%概率反击或侧移
  110620: 玩家进入居合架势 -> 重新规划行为
================================================================================
--]]
Goal.Interrupt = function (f26_arg0, f26_arg1, f26_arg2)
    local f26_local0 = f26_arg1:GetSpecialEffectActivateInterruptType(0)  -- 激活的特效ID
    local f26_local1 = f26_arg1:GetSpecialEffectInactivateInterruptType(0) -- 失活的特效ID
    local f26_local2 = f26_arg1:GetDist(TARGET_ENE_0)   -- 与玩家距离
    local f26_local3 = f26_arg1:GetRandam_Int(1, 100)   -- 随机数
    local f26_local4 = f26_arg1:GetNinsatsuNum()        -- 忍杀次数

    -- 在梯子上时不处理中断
    if f26_arg1:IsLadderAct(TARGET_SELF) then
        return false
    end
    -- 必须处于战斗状态(200004: AI状态_发现/战斗)才处理中断
    if not f26_arg1:HasSpecialEffectId(TARGET_SELF, 200004) then
        return false
    end
    -- 弹反时机中断：调用Parry函数处理
    if f26_arg1:IsInterupt(INTERUPT_ParryTiming) then
        return f26_arg0.Parry(f26_arg1, f26_arg2, 100, 0)
    end
    -- 射击命中中断：调用射击反应
    if f26_arg1:IsInterupt(INTERUPT_ShootImpact) and f26_arg0.ShootReaction(f26_arg1, f26_arg2) then
        return true
    end
    -- 特效激活中断处理
    if f26_arg1:IsInterupt(INTERUPT_ActivateSpecialEffect) then
        if f26_local0 == 3710020 then
            -- 3710020: 被忍杀判定 -> 剑戟计数归零
            f26_arg1:SetNumber(0, 0)
            return true
        elseif f26_local0 == 3710030 and f26_arg1:HasSpecialEffectId(TARGET_SELF, 3710032) then
            -- 3710030: 累加弹反 + 3710032: 被向左弹开_强 -> 发动反击
            f26_arg2:ClearSubGoal()
            f26_arg2:AddSubGoal(GOAL_COMMON_EndureAttack, 5, 3092, TARGET_ENE_0, 9999, 0)
            f26_arg1:SetTimer(6, 50)
            return true
        elseif f26_local0 == 5029 then
            -- 5029: 逻辑判定通用效果10 -> 触发受伤响应
            return f26_arg0.Damaged(f26_arg1, f26_arg2)
        elseif f26_local0 == 5031 then
            -- 5031: 逻辑判定通用效果12 -> 第一次忍杀且远距离时追击
            if f26_local4 <= 1 and f26_local2 >= 4.1 then
                f26_arg2:ClearSubGoal()
                f26_arg2:AddSubGoal(GOAL_COMMON_ComboRepeat, 5, 3017, TARGET_ENE_0, 9999, 0)
            end
        elseif f26_local0 == 3710050 then
            -- 3710050: 回旋踢命中 -> 根据概率选择反击或侧移
            if f26_local3 <= 50 and f26_arg1:HasSpecialEffectId(TARGET_SELF, 200050) then
                -- 200050: 行为模式变化0，50%概率反击
                f26_arg2:ClearSubGoal()
                f26_arg2:AddSubGoal(GOAL_COMMON_ComboRepeat, 5, 3023, TARGET_ENE_0, 9999, 0)
            else
                -- 否则侧向移动躲避
                f26_arg2:ClearSubGoal()
                f26_arg2:AddSubGoal(GOAL_COMMON_SidewayMove, 4, TARGET_ENE_0, f26_arg1:GetRandam_Int(0, 1), f26_arg1:GetRandam_Int(30, 45), true, true, -1)
            end
        elseif f26_local0 == 110620 then
            -- 110620: 玩家进入居合架势 -> 重新规划行为应对
            f26_arg1:Replanning()
            return true
        end
    end
    -- 使用道具中断判定（200051: 行为模式变化1时且忍杀>=2次时不使用）
    if not Interupt_Use_Item(f26_arg1, 8, 5) or f26_arg1:HasSpecialEffectId(TARGET_SELF, 200051) and f26_local4 >= 2 then
    else
        f26_arg2:ClearSubGoal()
        f26_arg2:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 1, 3023, TARGET_ENE_0, 9999, 0, 0, 0, 0)
        return true
    end
    return false

end

--[[
================================================================================
Goal.Parry - 弹反/格挡响应函数
================================================================================
功能说明：
  当检测到玩家攻击时，决定AI是否执行弹反或其他防御行为。
  根据弹反等级、玩家攻击类型、距离等条件选择不同的响应。

参数说明：
  f27_arg0: AI控制器
  f27_arg1: 目标管理器
  f27_arg2: 弹反概率基数（默认50）
  f27_arg3: 后撤概率（默认0）

关键变量：
  f27_local0: 与玩家距离
  f27_local1: 弹反有效距离
  f27_local5: 玩家是否在使用突刺攻击(109970: 敌人AI参照_突刺)
  f27_local6: 玩家是否在连续攻击(COMMON_SP_EFFECT_PC_ATTACK_RUSH)
  f27_local7: 弹反中断等级 (0=A级, 1=B级, 2=无等级)

弹反等级判定：
  221000: 弹反中断等级A（最强，100%弹反反击）
  221001: 弹反中断等级B（50%概率后撤）

不弹反的情况（玩家特效）：
  110450: 隐形居合连击1
  110501: 忍刺
  110500: 蓄力忍刺

响应类型：
  3710040: 宿敌破绽 -> 抓破绽反击(3102)
  玩家连续攻击 -> 反击(3103)
  玩家突刺(109970) -> 根据等级决定是否反击
  玩家不可格挡攻击(109980) -> 后撤闪避(5201)
  普通攻击 -> 根据连续格挡次数概率弹反(3101)或格挡(3100)
================================================================================
--]]
Goal.Parry = function (f27_arg0, f27_arg1, f27_arg2, f27_arg3)
    local f27_local0 = f27_arg0:GetDist(TARGET_ENE_0)       -- 与玩家距离
    local f27_local1 = GetDist_Parry(f27_arg0)              -- 弹反有效距离
    local f27_local2 = f27_arg0:GetRandam_Int(1, 100)       -- 随机数1
    local f27_local3 = f27_arg0:GetRandam_Int(1, 100)       -- 随机数2
    local f27_local4 = f27_arg0:GetRandam_Int(1, 100)       -- 随机数3
    local f27_local5 = f27_arg0:HasSpecialEffectId(TARGET_ENE_0, 109970)  -- 109970: 玩家突刺攻击
    local f27_local6 = f27_arg0:HasSpecialEffectId(TARGET_ENE_0, COMMON_SP_EFFECT_PC_ATTACK_RUSH) -- 玩家连续攻击

    -- 弹反中断等级判定（2=无等级, 1=B级, 0=A级）
    local f27_local7 = 2
    if f27_arg0:HasSpecialEffectId(TARGET_SELF, 221000) then
        f27_local7 = 0  -- 221000: 弹反中断等级A（最强）
    elseif f27_arg0:HasSpecialEffectId(TARGET_SELF, 221001) then
        f27_local7 = 1  -- 221001: 弹反中断等级B
    end

    -- 弹反间隔计时器未完成则不弹反
    if f27_arg0:IsFinishTimer(AI_TIMER_PARRY_INTERVAL) == false then
        return false
    end
    -- 玩家使用居合连击/忍刺/蓄力忍刺时不弹反
    if f27_arg0:HasSpecialEffectId(TARGET_ENE_0, 110450) or   -- 110450: 隐形居合连击1
       f27_arg0:HasSpecialEffectId(TARGET_ENE_0, 110501) or   -- 110501: 忍刺
       f27_arg0:HasSpecialEffectId(TARGET_ENE_0, 110500) then -- 110500: 蓄力忍刺
        return false
    end
    f27_arg0:SetTimer(AI_TIMER_PARRY_INTERVAL, 0.1)  -- 设置弹反间隔

    -- 参数默认值
    if f27_arg2 == nil then
        f27_arg2 = 50
    end
    if f27_arg3 == nil then
        f27_arg3 = 0
    end

    -- 玩家在正面90度且在弹反距离内
    if f27_arg0:IsInsideTarget(TARGET_ENE_0, AI_DIR_TYPE_F, 90) and f27_arg0:IsInsideTargetEx(TARGET_ENE_0, TARGET_SELF, AI_DIR_TYPE_F, 180, f27_local1) then
        if f27_arg0:HasSpecialEffectId(TARGET_SELF, 3710040) then
            -- 3710040: 宿敌破绽 -> 抓住破绽发动反击
            f27_arg1:ClearSubGoal()
            f27_arg1:AddSubGoal(GOAL_COMMON_EndureAttack, 0.3, 3102, TARGET_ENE_0, 9999, 0)
            f27_arg0:SetTimer(5, 60)
            return true
        elseif f27_local6 then
            -- 玩家连续攻击中 -> 发动反击
            f27_arg1:ClearSubGoal()
            f27_arg1:AddSubGoal(GOAL_COMMON_EndureAttack, 0.3, 3103, TARGET_ENE_0, 9999, 0)
            return true
        elseif f27_local5 then
            -- 109970: 玩家突刺攻击 -> 根据弹反等级处理
            if f27_arg0:IsTargetGuard(TARGET_SELF) and ReturnKengekiSpecialEffect(f27_arg0) == false then
                return false
            elseif f27_local7 == 2 then
                return false  -- 无等级：不处理
            elseif f27_local7 == 1 then
                -- B级：50%概率后撤
                if f27_local2 <= 50 then
                    f27_arg1:ClearSubGoal()
                    f27_arg1:AddSubGoal(GOAL_COMMON_SpinStep, 1, 5211, TARGET_ENE_0, 0, AI_DIR_TYPE_B, 0)
                    return true
                end
            elseif f27_local7 == 0 and f27_local2 <= 100 then
                -- A级：100%弹反反击
                f27_arg1:ClearSubGoal()
                f27_arg1:AddSubGoal(GOAL_COMMON_EndureAttack, 0.3, 3101, TARGET_ENE_0, 9999, 0)
                return true
            end
        elseif f27_arg0:HasSpecialEffectId(TARGET_ENE_0, 109980) then
            -- 109980: 玩家不可格挡攻击 -> 后撤闪避
            f27_arg1:ClearSubGoal()
            f27_arg1:AddSubGoal(GOAL_COMMON_SpinStep, 1, 5201, TARGET_ENE_0, 0, AI_DIR_TYPE_B, 0)
            return true
        elseif f27_local3 <= Get_ConsecutiveGuardCount(f27_arg0) * f27_arg2 then
            -- 根据连续格挡次数，概率触发弹反反击
            f27_arg1:ClearSubGoal()
            f27_arg1:AddSubGoal(GOAL_COMMON_EndureAttack, 0.3, 3101, TARGET_ENE_0, 9999, 0)
            return true
        else
            -- 默认：普通格挡
            f27_arg1:ClearSubGoal()
            f27_arg1:AddSubGoal(GOAL_COMMON_EndureAttack, 0.3, 3100, TARGET_ENE_0, 9999, 0)
            return true
        end
    elseif f27_arg0:IsInsideTargetEx(TARGET_ENE_0, TARGET_SELF, AI_DIR_TYPE_F, 90, f27_local1 + 1) then
        -- 玩家在稍远距离 -> 根据概率后撤
        if f27_local4 <= f27_arg3 then
            f27_arg1:ClearSubGoal()
            f27_arg1:AddSubGoal(GOAL_COMMON_SpinStep, 1, 5211, TARGET_ENE_0, 0, AI_DIR_TYPE_B, 0)
            return true
        else
            return false
        end
    else
        return false
    end

end

--[[
================================================================================
Goal.Damaged - 受伤响应函数
================================================================================
功能说明：
  当AI受到伤害时的响应逻辑。根据随机概率决定是后撤闪避还是反击。

参数说明：
  f28_arg0: AI控制器
  f28_arg1: 目标管理器
  f28_arg2: 未使用

关键变量：
  f28_local0: 自身血量百分比
  f28_local1: 与玩家距离
  f28_local2: 自身架势值
  f28_local3: 随机数(1-100)
  Number[0]: 剑戟计数（累计弹反次数）
  Number[2]: 反击标记（设为1表示下次优先反击）

响应逻辑：
  15%概率: 后撤闪避(5201) + 设置反击标记 + 减少剑戟计数3
  15%概率(需200050): 发动反击(3009) + 设置反击标记 + 减少剑戟计数3
  70%概率: 不做特殊响应

特效说明：
  200050: 行为模式变化0（进入特定战斗阶段后才会反击）
================================================================================
--]]
Goal.Damaged = function (f28_arg0, f28_arg1, f28_arg2)
    local f28_local0 = f28_arg0:GetHpRate(TARGET_SELF)    -- 自身血量百分比
    local f28_local1 = f28_arg0:GetDist(TARGET_ENE_0)     -- 与玩家距离
    local f28_local2 = f28_arg0:GetSp(TARGET_SELF)        -- 自身架势值
    local f28_local3 = f28_arg0:GetRandam_Int(1, 100)     -- 随机数
    local f28_local4 = 0
    local f28_local5 = 3  -- 后撤动作持续时间

    if f28_local3 <= 15 then
        -- 15%概率：后撤闪避
        f28_arg1:ClearSubGoal()
        f28_arg1:AddSubGoal(GOAL_COMMON_SpinStep, f28_local5, 5201, TARGET_ENE_0, TurnTime, AI_DIR_TYPE_B, 0):TimingSetTimer(3, 6, UPDATE_SUCCESS)
        f28_arg0:SetNumber(2, 1)  -- 设置反击标记，下次Activate优先反击
        -- 减少剑戟计数
        if f28_arg0:GetNumber(0) <= 3 then
            f28_arg0:SetNumber(0, 0)
        else
            f28_arg0:SetNumber(0, f28_arg0:GetNumber(0) - 3)
        end
        return true
    elseif f28_local3 <= 30 and f28_arg0:HasSpecialEffectId(TARGET_SELF, 200050) then
        -- 15%概率(且处于行为模式0)：发动反击
        -- 200050: 行为模式变化0
        f28_arg1:ClearSubGoal()
        f28_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3009, TARGET_ENE_0, 9999, 0)
        f28_arg0:SetNumber(2, 1)  -- 设置反击标记
        -- 减少剑戟计数
        if f28_arg0:GetNumber(0) <= 3 then
            f28_arg0:SetNumber(0, 0)
        else
            f28_arg0:SetNumber(0, f28_arg0:GetNumber(0) - 3)
        end
        return true
    else
        -- 70%概率：不做特殊响应
    end
    return false

end

Goal.ShootReaction = function (f29_arg0, f29_arg1)
    f29_arg1:ClearSubGoal()
    f29_arg1:AddSubGoal(GOAL_COMMON_EndureAttack, 0.1, 3100, TARGET_ENE_0, 9999, 0)
    return true
    
end

--[[
================================================================================
Goal.Kengeki_Activate - 剑戟（弹刀）反击激活函数
================================================================================
功能说明：
  当AI成功弹开玩家攻击或被玩家弹开时触发。根据弹刀类型和累计次数，
  通过权重系统选择对应的剑戟反击行为（Kengeki系列函数）。

参数说明：
  f30_arg0: Goal对象（包含Kengeki系列函数）
  f30_arg1: AI控制器
  f30_arg2: 目标管理器
  f30_arg3: 未使用

关键变量：
  f30_local0: 当前剑戟特效类型（由ReturnKengekiSpecialEffect返回）
  f30_local1: 剑戟行为权重表
  f30_local4: 与玩家距离
  f30_local5: 自身血量百分比
  f30_local6: 自身架势值百分比
  Number[0]: 剑戟计数（累计弹刀次数）
  Number[3]: 攻击模式标记
  Number[6]: 左右方向标记

剑戟特效类型（AI被弹开/弹开玩家时触发）：
  200200: 被向右弹开_强 -> 累加计数，根据次数选择反击
  200201: 被向左弹开_强 -> 累加计数，根据次数选择反击
  200210: 向右弹开玩家_强 -> 后撤+多种反击选择
  200211: 向左弹开玩家_强 -> 后撤+多种反击选择
  200215: 向右弹开玩家_弱 -> 累加计数，根据次数选择反击
  200216: 向左弹开玩家_弱 -> 累加计数，根据次数选择反击

行为模式限制：
  200051: 行为模式变化1 -> 禁用多种剑戟反击
  200050: 行为模式变化0 -> 禁用侧移(Kengeki20)

血量相关：
  血量<=75%时，Timer6完成后开启Kengeki40(权重50)
================================================================================
--]]
Goal.Kengeki_Activate = function (f30_arg0, f30_arg1, f30_arg2, f30_arg3)
    local f30_local0 = ReturnKengekiSpecialEffect(f30_arg1)  -- 获取当前剑戟特效类型
    if f30_local0 == 0 then
        return false  -- 无剑戟特效，不处理
    end
    local f30_local1 = {}       -- 剑戟行为权重表
    local f30_local2 = {}       -- 剑戟函数表
    local f30_local3 = {}       -- 附加参数表
    Common_Clear_Param(f30_local1, f30_local2, f30_local3)
    local f30_local4 = f30_arg1:GetDist(TARGET_ENE_0)       -- 与玩家距离
    local f30_local5 = f30_arg1:GetHpRate(TARGET_SELF)      -- 自身血量百分比
    local f30_local6 = f30_arg1:GetSpRate(TARGET_SELF)      -- 自身架势百分比

    -- 200200: 被向右弹开_强
    if f30_local0 == 200200 then
        f30_arg1:SetNumber(0, f30_arg1:GetNumber(0) + 1)  -- 累加剑戟计数
        if f30_local4 >= 2.5 then
            f30_local1[50] = 100  -- 距离远则不行动
        elseif f30_arg1:GetNumber(0) >= 2 then
            -- 累计弹刀>=2次：多种反击选择
            f30_local1[3] = 60    -- Kengeki03
            f30_local1[20] = 60   -- Kengeki20 侧移
            f30_local1[30] = 5    -- Kengeki30
            f30_local1[38] = 50   -- Kengeki38
            f30_local1[15] = 30   -- Kengeki15
            f30_local1[43] = 50   -- Kengeki43
            f30_local1[39] = 30   -- Kengeki39
            if f30_arg1:GetNumber(6) == 0 then
                f30_local1[32] = 20
            else
                f30_local1[33] = 20
            end
        elseif f30_arg1:GetNumber(3) == 0 then
            f30_local1[1] = 50    -- Kengeki01
        else
            f30_local1[4] = 100   -- Kengeki04
        end
    -- 200201: 被向左弹开_强
    elseif f30_local0 == 200201 then
        if f30_local4 >= 2.5 then
            f30_local1[50] = 100
        elseif f30_arg1:GetNumber(0) >= 2 then
            f30_local1[3] = 60
            f30_local1[20] = 60
            f30_local1[38] = 50
            f30_local1[15] = 30
            f30_local1[43] = 50
            f30_local1[39] = 30
            if f30_arg1:GetNumber(6) == 0 then
                f30_local1[32] = 50
            else
                f30_local1[33] = 50
            end
        elseif f30_arg1:GetNumber(3) == 0 then
            f30_local1[1] = 50
        else
            f30_local1[4] = 100
        end
    -- 200210: 向右弹开玩家_强（弹开敌人）
    elseif f30_local0 == 200210 then
        f30_local1[2] = 100   -- Kengeki02 后撤
        f30_local1[17] = 100  -- Kengeki17
        f30_local1[38] = 50   -- Kengeki38
        f30_local1[31] = 50   -- Kengeki31
    -- 200211: 向左弹开玩家_强
    elseif f30_local0 == 200211 then
        f30_local1[2] = 100   -- Kengeki02 后撤
        f30_local1[10] = 50   -- Kengeki10
        f30_local1[31] = 50   -- Kengeki31
        f30_local1[38] = 50   -- Kengeki38
    -- 200216: 向左弹开玩家_弱
    elseif f30_local0 == 200216 then
        if f30_local4 >= 2 then
            f30_local1[50] = 10
        else
            f30_arg1:SetNumber(0, f30_arg1:GetNumber(0) + 1)
            if f30_arg1:GetNumber(0) >= 3 then
                f30_local1[3] = 60
                f30_local1[20] = 20
                f30_local1[38] = 100
                f30_local1[43] = 50
                if f30_arg1:GetNumber(6) == 0 then
                    f30_local1[32] = 50
                else
                    f30_local1[33] = 50
                end
            else
                f30_local1[20] = 50
                if f30_arg1:GetNumber(3) == 0 then
                    f30_local1[1] = 50
                else
                    f30_local1[14] = 50
                end
            end
        end
    -- 200215: 向右弹开玩家_弱
    elseif f30_local0 == 200215 then
        if f30_local4 >= 2 then
            f30_local1[50] = 10
        else
            f30_arg1:SetNumber(0, f30_arg1:GetNumber(0) + 1)
            if f30_arg1:GetNumber(0) >= 3 then
                f30_local1[20] = 20
                f30_local1[38] = 30
                f30_local1[31] = 15
                f30_local1[43] = 10
                f30_local1[39] = 10
                if f30_arg1:GetNumber(6) == 0 then
                    f30_local1[32] = 50
                else
                    f30_local1[33] = 50
                end
            else
                f30_local1[20] = 50
                if f30_arg1:GetNumber(3) == 0 then
                    f30_local1[1] = 50
                else
                    f30_local1[14] = 50
                end
            end
        end
    end

    -- 行为模式限制
    if f30_arg1:HasSpecialEffectId(TARGET_SELF, 200051) then
        -- 200051: 行为模式变化1 -> 禁用多种反击
        f30_local1[3] = 0
        f30_local1[9] = 0
        f30_local1[15] = 0
        f30_local1[32] = 0
        f30_local1[33] = 0
        f30_local1[39] = 0
        f30_local1[46] = 0
    elseif f30_arg1:HasSpecialEffectId(TARGET_SELF, 200050) then
        -- 200050: 行为模式变化0 -> 禁用侧移
        f30_local1[20] = 0
    end
    -- 空间检测：无法侧移则禁用
    if SpaceCheck(f30_arg1, f30_arg2, 45, 2) == false and SpaceCheck(f30_arg1, f30_arg2, -45, 2) == false then
        f30_local1[20] = 0
    end
    -- Timer6控制：血量<=75%时开启Kengeki40
    if f30_arg1:IsFinishTimer(6) == false then
        f30_local1[40] = 0
    elseif f30_arg1:IsFinishTimer(6) == true and f30_local5 <= 0.75 then
        f30_local1[40] = 50
    end
    f30_local1[1] = SetCoolTime(f30_arg1, f30_arg2, 3050, 8, f30_local1[1], 1)
    f30_local1[2] = SetCoolTime(f30_arg1, f30_arg2, 5201, 10, f30_local1[2], 1)
    f30_local1[3] = SetCoolTime(f30_arg1, f30_arg2, 3009, 10, f30_local1[3], 1)
    f30_local1[4] = SetCoolTime(f30_arg1, f30_arg2, 3055, 8, f30_local1[4], 1)
    f30_local1[7] = SetCoolTime(f30_arg1, f30_arg2, 3060, 8, f30_local1[7], 1)
    f30_local1[9] = SetCoolTime(f30_arg1, f30_arg2, 3018, 8, f30_local1[9], 1)
    f30_local1[10] = SetCoolTime(f30_arg1, f30_arg2, 3065, 8, f30_local1[10], 1)
    f30_local1[13] = SetCoolTime(f30_arg1, f30_arg2, 3075, 8, f30_local1[13], 1)
    f30_local1[14] = SetCoolTime(f30_arg1, f30_arg2, 3076, 8, f30_local1[14], 1)
    f30_local1[15] = SetCoolTime(f30_arg1, f30_arg2, 3031, 15, f30_local1[15], 1)
    f30_local1[17] = SetCoolTime(f30_arg1, f30_arg2, 3071, 8, f30_local1[17], 1)
    f30_local1[18] = SetCoolTime(f30_arg1, f30_arg2, 3004, 8, f30_local1[18], 1)
    f30_local1[20] = SetCoolTime(f30_arg1, f30_arg2, 5202, 15, f30_local1[20], 1)
    f30_local1[30] = SetCoolTime(f30_arg1, f30_arg2, 3063, 15, f30_local1[30], 1)
    f30_local1[31] = SetCoolTime(f30_arg1, f30_arg2, 3068, 15, f30_local1[31], 1)
    f30_local1[32] = SetCoolTime(f30_arg1, f30_arg2, 3018, 15, f30_local1[32], 1)
    f30_local1[33] = SetCoolTime(f30_arg1, f30_arg2, 3007, 15, f30_local1[33], 1)
    f30_local1[34] = SetCoolTime(f30_arg1, f30_arg2, 3037, 15, f30_local1[34], 1)
    f30_local1[35] = SetCoolTime(f30_arg1, f30_arg2, 3016, 8, f30_local1[35], 1)
    f30_local1[38] = SetCoolTime(f30_arg1, f30_arg2, 3030, 8, f30_local1[38], 1)
    f30_local1[39] = SetCoolTime(f30_arg1, f30_arg2, 3034, 15, f30_local1[39], 1)
    f30_local1[40] = SetCoolTime(f30_arg1, f30_arg2, 3028, 15, f30_local1[40], 1)
    f30_local1[41] = SetCoolTime(f30_arg1, f30_arg2, 3020, 15, f30_local1[41], 1)
    f30_local1[43] = SetCoolTime(f30_arg1, f30_arg2, 3062, 15, f30_local1[43], 1)
    f30_local1[44] = SetCoolTime(f30_arg1, f30_arg2, 3067, 15, f30_local1[44], 1)
    f30_local1[45] = SetCoolTime(f30_arg1, f30_arg2, 3032, 15, f30_local1[45], 1)
    f30_local2[1] = REGIST_FUNC(f30_arg1, f30_arg2, f30_arg0.Kengeki01)
    f30_local2[2] = REGIST_FUNC(f30_arg1, f30_arg2, f30_arg0.Kengeki02)
    f30_local2[3] = REGIST_FUNC(f30_arg1, f30_arg2, f30_arg0.Kengeki03)
    f30_local2[4] = REGIST_FUNC(f30_arg1, f30_arg2, f30_arg0.Kengeki04)
    f30_local2[5] = REGIST_FUNC(f30_arg1, f30_arg2, f30_arg0.Kengeki05)
    f30_local2[6] = REGIST_FUNC(f30_arg1, f30_arg2, f30_arg0.Kengeki06)
    f30_local2[7] = REGIST_FUNC(f30_arg1, f30_arg2, f30_arg0.Kengeki07)
    f30_local2[9] = REGIST_FUNC(f30_arg1, f30_arg2, f30_arg0.Kengeki09)
    f30_local2[10] = REGIST_FUNC(f30_arg1, f30_arg2, f30_arg0.Kengeki10)
    f30_local2[13] = REGIST_FUNC(f30_arg1, f30_arg2, f30_arg0.Kengeki13)
    f30_local2[14] = REGIST_FUNC(f30_arg1, f30_arg2, f30_arg0.Kengeki14)
    f30_local2[15] = REGIST_FUNC(f30_arg1, f30_arg2, f30_arg0.Kengeki15)
    f30_local2[17] = REGIST_FUNC(f30_arg1, f30_arg2, f30_arg0.Kengeki17)
    f30_local2[18] = REGIST_FUNC(f30_arg1, f30_arg2, f30_arg0.Kengeki18)
    f30_local2[19] = REGIST_FUNC(f30_arg1, f30_arg2, f30_arg0.Kengeki19)
    f30_local2[20] = REGIST_FUNC(f30_arg1, f30_arg2, f30_arg0.Kengeki20)
    f30_local2[21] = REGIST_FUNC(f30_arg1, f30_arg2, f30_arg0.Kengeki21)
    f30_local2[30] = REGIST_FUNC(f30_arg1, f30_arg2, f30_arg0.Kengeki30)
    f30_local2[31] = REGIST_FUNC(f30_arg1, f30_arg2, f30_arg0.Kengeki31)
    f30_local2[32] = REGIST_FUNC(f30_arg1, f30_arg2, f30_arg0.Kengeki32)
    f30_local2[33] = REGIST_FUNC(f30_arg1, f30_arg2, f30_arg0.Kengeki33)
    f30_local2[34] = REGIST_FUNC(f30_arg1, f30_arg2, f30_arg0.Kengeki34)
    f30_local2[35] = REGIST_FUNC(f30_arg1, f30_arg2, f30_arg0.Kengeki35)
    f30_local2[36] = REGIST_FUNC(f30_arg1, f30_arg2, f30_arg0.Kengeki36)
    f30_local2[37] = REGIST_FUNC(f30_arg1, f30_arg2, f30_arg0.Kengeki37)
    f30_local2[38] = REGIST_FUNC(f30_arg1, f30_arg2, f30_arg0.Kengeki38)
    f30_local2[39] = REGIST_FUNC(f30_arg1, f30_arg2, f30_arg0.Kengeki39)
    f30_local2[40] = REGIST_FUNC(f30_arg1, f30_arg2, f30_arg0.Kengeki40)
    f30_local2[41] = REGIST_FUNC(f30_arg1, f30_arg2, f30_arg0.Kengeki41)
    f30_local2[43] = REGIST_FUNC(f30_arg1, f30_arg2, f30_arg0.Kengeki43)
    f30_local2[44] = REGIST_FUNC(f30_arg1, f30_arg2, f30_arg0.Kengeki44)
    f30_local2[45] = REGIST_FUNC(f30_arg1, f30_arg2, f30_arg0.Kengeki45)
    f30_local2[46] = REGIST_FUNC(f30_arg1, f30_arg2, f30_arg0.Kengeki46)
    f30_local2[50] = REGIST_FUNC(f30_arg1, f30_arg2, f30_arg0.NoAction)
    local f30_local7 = REGIST_FUNC(f30_arg1, f30_arg2, f30_arg0.ActAfter_AdjustSpace)
    return Common_Kengeki_Activate(f30_arg1, f30_arg2, f30_local1, f30_local2, f30_local7, f30_local3)
    
end

Goal.Kengeki01 = function (f31_arg0, f31_arg1, f31_arg2)
    f31_arg0:SetNumber(3, 1)
    f31_arg1:ClearSubGoal()
    f31_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3050, TARGET_ENE_0, 9999, 0, 0)
    
end

Goal.Kengeki02 = function (f32_arg0, f32_arg1, f32_arg2)
    local f32_local0 = f32_arg0:GetSpRate(TARGET_SELF)
    f32_arg1:ClearSubGoal()
    f32_arg1:AddSubGoal(GOAL_COMMON_ComboRepeat, 10, 5201, TARGET_ENE_0, 9999, 0, 0):TimingSetTimer(3, 30, AI_TIMING_SET__UPDATE_SUCCESS)
    f32_arg0:SetNumber(2, 1)
    if f32_local0 <= 0.7 and f32_arg0:HasSpecialEffectId(TARGET_SELF, 200050) then
        f32_arg1:AddSubGoal(GOAL_COMMON_ComboRepeat, 10, 3044, TARGET_ENE_0, DistToAtt1, TurnTime, FrontAngle, 0, 0)
    end
    
end

Goal.Kengeki03 = function (f33_arg0, f33_arg1, f33_arg2)
    f33_arg1:ClearSubGoal()
    f33_arg1:AddSubGoal(GOAL_COMMON_ComboAttackTunableSpin, 10, 3009, TARGET_ENE_0, 999, 0, 0, 0, 0)
    local f33_local0 = 0
    if SpaceCheck(f33_arg0, f33_arg1, -90, 1) == true then
        if SpaceCheck(f33_arg0, f33_arg1, 90, 1) == true then
            if f33_arg0:IsInsideTargetEx(TARGET_ENE_0, TARGET_SELF, AI_DIR_TYPE_R, 180, 5) then
                f33_local0 = 1
            else
                f33_local0 = 0
            end
        else
            f33_local0 = 0
        end
    elseif SpaceCheck(f33_arg0, f33_arg1, 90, 1) == true then
        f33_local0 = 1
    else
        f33_local0 = 1
    end
    local f33_local1 = 4
    local f33_local2 = f33_arg0:GetRandam_Int(30, 45)
    f33_arg1:AddSubGoal(GOAL_COMMON_SidewayMove, f33_local1, TARGET_ENE_0, f33_local0, f33_local2, true, true, -1)
    
end

Goal.Kengeki04 = function (f34_arg0, f34_arg1, f34_arg2)
    f34_arg0:SetNumber(3, 0)
    f34_arg1:ClearSubGoal()
    f34_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3055, TARGET_ENE_0, 9999, 0, 0)
    
end

Goal.Kengeki07 = function (f35_arg0, f35_arg1, f35_arg2)
    f35_arg1:ClearSubGoal()
    f35_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3060, TARGET_ENE_0, 9999, 0, 0)
    
end

Goal.Kengeki09 = function (f36_arg0, f36_arg1, f36_arg2)
    f36_arg1:ClearSubGoal()
    f36_arg1:AddSubGoal(GOAL_COMMON_ComboAttackTunableSpin, 10, 3018, TARGET_ENE_0, 999, 0, 0, 0, 0)
    f36_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3015, TARGET_ENE_0, 9999, 0, 0)
    
end

Goal.Kengeki10 = function (f37_arg0, f37_arg1, f37_arg2)
    f37_arg1:ClearSubGoal()
    f37_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3065, TARGET_ENE_0, 9999, 0, 0)
    
end

Goal.Kengeki13 = function (f38_arg0, f38_arg1, f38_arg2)
    f38_arg1:ClearSubGoal()
    f38_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3075, TARGET_ENE_0, 9999, 0, 0)
    
end

Goal.Kengeki14 = function (f39_arg0, f39_arg1, f39_arg2)
    f39_arg1:ClearSubGoal()
    f39_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3076, TARGET_ENE_0, 9999, 0, 0)
    
end

Goal.Kengeki15 = function (f40_arg0, f40_arg1, f40_arg2)
    local f40_local0 = 0
    local f40_local1 = 0
    local f40_local2 = 7.8 - f40_arg0:GetMapHitRadius(TARGET_SELF) + 2
    local f40_local3 = 0
    local f40_local4 = f40_arg0
    f40_local3 = f40_arg0.GetMapHitRadius
    f40_local3 = f40_local3(f40_local4, TARGET_SELF)
    f40_local3 = 2.5 - f40_local3
    f40_local4 = f40_arg0:GetRandam_Int(1, 100)
    local f40_local5 = f40_arg0:GetRandam_Int(1, 100)
    local f40_local6 = f40_arg0:GetSp(TARGET_SELF)
    local f40_local7 = f40_arg0:GetRandam_Int(30, 45)
    f40_arg1:ClearSubGoal()
    f40_arg1:AddSubGoal(GOAL_COMMON_ComboAttackTunableSpin, 10, 3031, TARGET_ENE_0, f40_local2, f40_local0, f40_local1, 0, 0)
    if f40_local4 <= 50 then
        f40_arg1:AddSubGoal(GOAL_COMMON_ComboRepeat, 10, 3019, TARGET_ENE_0, f40_local3, 0)
        f40_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3029, TARGET_ENE_0, 9999, 0, 0)
    else
        f40_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3036, TARGET_ENE_0, 9999, 0, 0)
    end
    if f40_local5 <= 50 then
        f40_arg0:SetNumber(2, 1)
    end
    
end

Goal.Kengeki17 = function (f41_arg0, f41_arg1, f41_arg2)
    f41_arg1:ClearSubGoal()
    f41_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3071, TARGET_ENE_0, 9999, 0, 0)
    
end

Goal.Kengeki18 = function (f42_arg0, f42_arg1, f42_arg2)
    f42_arg1:ClearSubGoal()
    f42_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3004, TARGET_ENE_0, 9999, 0, 0)
    
end

Goal.Kengeki19 = function (f43_arg0, f43_arg1, f43_arg2)
    f43_arg1:ClearSubGoal()
    f43_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3044, TARGET_ENE_0, 9999, 0, 0)
    
end

Goal.Kengeki20 = function (f44_arg0, f44_arg1, f44_arg2)
    local f44_local0 = f44_arg0:GetDist(TARGET_ENE_0)
    local f44_local1 = 3
    local f44_local2 = 0
    if SpaceCheck(f44_arg0, f44_arg1, -135, 1) == true then
        if SpaceCheck(f44_arg0, f44_arg1, 135, 1) == true then
            if f44_arg0:IsInsideTarget(TARGET_ENE_0, AI_DIR_TYPE_R, 180) then
                f44_local2 = 1
            else
                f44_local2 = 0
            end
        else
            f44_local2 = 0
        end
    elseif SpaceCheck(f44_arg0, f44_arg1, 90, 1) == true then
        f44_local2 = 1
    else
    end
    f44_arg1:ClearSubGoal()
    f44_arg1:AddSubGoal(GOAL_COMMON_SpinStep, f44_local1, 5202, TARGET_ENE_0, 0, AI_DIR_TYPE_B, 0)
    f44_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3007, TARGET_ENE_0, 9999, 0, 0)
    return GETWELLSPACE_ODDS
    
end

Goal.Kengeki21 = function (f45_arg0, f45_arg1, f45_arg2)
    f45_arg1:ClearSubGoal()
    f45_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3010, TARGET_ENE_0, 9999, 0, 0)
    
end

Goal.Kengeki30 = function (f46_arg0, f46_arg1, f46_arg2)
    f46_arg1:ClearSubGoal()
    f46_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3063, TARGET_ENE_0, 9999, 0, 0):TimingSetTimer(1, 10, AI_TIMING_SET__UPDATE_SUCCESS)
    f46_arg0:SetNumber(5, 0)
    
end

Goal.Kengeki31 = function (f47_arg0, f47_arg1, f47_arg2)
    f47_arg1:ClearSubGoal()
    f47_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3068, TARGET_ENE_0, 9999, 0, 0):TimingSetTimer(1, 10, AI_TIMING_SET__UPDATE_SUCCESS)
    f47_arg0:SetNumber(5, 0)
    
end

Goal.Kengeki32 = function (f48_arg0, f48_arg1, f48_arg2)
    local f48_local0 = 0
    local f48_local1 = 0
    local f48_local2 = 999 - f48_arg0:GetMapHitRadius(TARGET_SELF)
    local f48_local3 = 7 - f48_arg0:GetMapHitRadius(TARGET_SELF)
    f48_arg1:ClearSubGoal()
    f48_arg1:AddSubGoal(GOAL_COMMON_ComboAttackTunableSpin, 10, 3018, TARGET_ENE_0, f48_local2, f48_local0, f48_local1, 0, 0)
    f48_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3015, TARGET_ENE_0, 9999, 0, 0)
    f48_arg0:SetNumber(6, 1)
    
end

Goal.Kengeki33 = function (f49_arg0, f49_arg1, f49_arg2)
    local f49_local0 = 0
    local f49_local1 = 0
    local f49_local2 = 999 - f49_arg0:GetMapHitRadius(TARGET_SELF)
    local f49_local3 = 7.8 - f49_arg0:GetMapHitRadius(TARGET_SELF)
    local f49_local4 = 2.5 - f49_arg0:GetMapHitRadius(TARGET_SELF)
    local f49_local5 = f49_arg0:GetRandam_Int(1, 100)
    f49_arg1:ClearSubGoal()
    f49_arg1:AddSubGoal(GOAL_COMMON_ComboAttackTunableSpin, 10, 3018, TARGET_ENE_0, f49_local2, f49_local0, f49_local1, 0, 0)
    if f49_local5 <= 50 then
        f49_arg1:AddSubGoal(GOAL_COMMON_ComboRepeat, 10, 3019, TARGET_ENE_0, f49_local3, 0)
        f49_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3029, TARGET_ENE_0, 9999, 0, 0)
    else
        f49_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3019, TARGET_ENE_0, 9999, 0, 0)
    end
    f49_arg0:SetNumber(6, 0)
    
end

Goal.Kengeki34 = function (f50_arg0, f50_arg1, f50_arg2)
    f50_arg1:ClearSubGoal()
    f50_arg1:AddSubGoal(GOAL_COMMON_ComboRepeat, 10, 3037, TARGET_ENE_0, 6, 0)
    f50_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3020, TARGET_ENE_0, 9999, 0, 0)
    
end

Goal.Kengeki35 = function (f51_arg0, f51_arg1, f51_arg2)
    f51_arg1:ClearSubGoal()
    f51_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3016, TARGET_ENE_0, 9999, 0, 0)
    f51_arg0:SetNumber(5, 0)
    
end

Goal.Kengeki38 = function (f52_arg0, f52_arg1, f52_arg2)
    local f52_local0 = 0
    local f52_local1 = 0
    local f52_local2 = f52_arg0:GetNinsatsuNum()
    local f52_local3 = f52_arg0:GetRandam_Int(1, 100)
    f52_arg1:ClearSubGoal()
    f52_arg1:AddSubGoal(GOAL_COMMON_ComboAttackTunableSpin, 10, 3030, TARGET_ENE_0, 999, f52_local0, f52_local1, 0, 0)
    if f52_local2 <= 1 then
        if f52_local3 <= 75 then
            f52_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3067, TARGET_ENE_0, 9999, 0, 0)
        else
            f52_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3025, TARGET_ENE_0, 9999, 0, 0)
        end
    else
        f52_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3025, TARGET_ENE_0, 9999, 0, 0)
    end
    
end

Goal.Kengeki39 = function (f53_arg0, f53_arg1, f53_arg2)
    local f53_local0 = 0
    local f53_local1 = 0
    local f53_local2 = 999 - f53_arg0:GetMapHitRadius(TARGET_SELF)
    local f53_local3 = f53_arg0:GetDist(TARGET_ENE_0)
    f53_arg1:ClearSubGoal()
    f53_arg1:AddSubGoal(GOAL_COMMON_ComboAttackTunableSpin, 10, 3034, TARGET_ENE_0, f53_local2, f53_local0, f53_local1, 0, 0)
    f53_arg1:AddSubGoal(GOAL_COMMON_ComboRepeat, 10, 3036, TARGET_ENE_0, 999, 0)
    f53_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3015, TARGET_ENE_0, 9999, 0, 0)
    
end

Goal.Kengeki40 = function (f54_arg0, f54_arg1, f54_arg2)
    f54_arg1:ClearSubGoal()
    f54_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3028, TARGET_ENE_0, 9999, 0, 0)
    f54_arg0:SetTimer(6, 50)
    
end

Goal.Kengeki43 = function (f55_arg0, f55_arg1, f55_arg2)
    f55_arg1:ClearSubGoal()
    f55_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3062, TARGET_ENE_0, 9999, 0, 0)
    f55_arg0:SetNumber(2, 1)
    
end

Goal.Kengeki44 = function (f56_arg0, f56_arg1, f56_arg2)
    f56_arg1:ClearSubGoal()
    f56_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3067, TARGET_ENE_0, 9999, 0, 0)
    f56_arg0:SetNumber(2, 1)
    
end

Goal.Kengeki45 = function (f57_arg0, f57_arg1, f57_arg2)
    f57_arg1:ClearSubGoal()
    f57_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3045, TARGET_ENE_0, 9999, 0, 0)
    f57_arg0:SetNumber(0, 0)
    
end

Goal.Kengeki46 = function (f58_arg0, f58_arg1, f58_arg2)
    local f58_local0 = 0
    local f58_local1 = 0
    local f58_local2 = 7.8 - f58_arg0:GetMapHitRadius(TARGET_SELF) + 2
    local f58_local3 = 0
    local f58_local4 = f58_arg0
    f58_local3 = f58_arg0.GetRandam_Int
    f58_local3 = f58_local3(f58_local4, 1, 100)
    f58_local4 = f58_arg0:GetSp(TARGET_SELF)
    local f58_local5 = f58_arg0:GetRandam_Int(30, 45)
    f58_arg1:ClearSubGoal()
    f58_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3039, TARGET_ENE_0, 9999, 0, 0):TimingSetTimer(4, 10, AI_TIMING_SET__UPDATE_SUCCESS)
    f58_arg1:AddSubGoal(GOAL_COMMON_SidewayMove, 2.5, TARGET_ENE_0, 0, f58_local5, true, true, -1)
    
end

Goal.Kengeki47 = function (f59_arg0, f59_arg1, f59_arg2)
    f59_arg1:ClearSubGoal()
    f59_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3038, TARGET_ENE_0, 9999, 0, 0):TimingSetTimer(4, 10, AI_TIMING_SET__UPDATE_SUCCESS)
    
end

Goal.NoAction = function (f60_arg0, f60_arg1, f60_arg2)
    return -1
    
end

Goal.ActAfter_AdjustSpace = function (f61_arg0, f61_arg1, f61_arg2)
    
end

Goal.Update = function (f62_arg0, f62_arg1, f62_arg2)
    return Update_Default_NoSubGoal(f62_arg0, f62_arg1, f62_arg2)
    
end

Goal.Terminate = function (f63_arg0, f63_arg1, f63_arg2)
    
end


