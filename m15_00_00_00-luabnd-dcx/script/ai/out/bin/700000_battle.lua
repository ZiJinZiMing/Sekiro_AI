﻿RegisterTableGoal(GOAL_OnnaSousha_700000_Battle, "OnnaSousha_700000_Battle")
REGISTER_GOAL_NO_SUB_GOAL(GOAL_OnnaSousha_700000_Battle, true)

Goal.Initialize = function (f1_arg0, f1_arg1, f1_arg2, f1_arg3)
    
end

Goal.Activate = function (f2_arg0, f2_arg1, f2_arg2)
    Init_Pseudo_Global(f2_arg1, f2_arg2)
    local f2_local0 = {}
    local f2_local1 = {}
    local f2_local2 = {}
    Common_Clear_Param(f2_local0, f2_local1, f2_local2)
    local f2_local3 = f2_arg1:GetDist(TARGET_ENE_0)
    local f2_local4 = f2_arg1:GetExcelParam(AI_EXCEL_THINK_PARAM_TYPE__thinkAttr_doAdmirer)
    local f2_local5 = f2_arg1:GetNpcThinkParamID()
    local f2_local6 = Check_ReachAttack(f2_arg1, 0)
    local f2_local7 = f2_arg1:GetDistYSigned(TARGET_ENE_0)
    local f2_local8 = f2_arg1:GetEventRequest()
    f2_arg1:SetNumber(4, f2_local7)
    f2_arg1:AddObserveSpecialEffectAttribute(TARGET_SELF, 5025)
    f2_arg1:AddObserveSpecialEffectAttribute(TARGET_SELF, 5026)
    Set_ConsecutiveGuardCount_Interrupt(f2_arg1)
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
    elseif f2_local6 ~= POSSIBLE_ATTACK then
        if f2_local4 == 1 and f2_arg1:GetTeamOrder(ORDER_TYPE_Role) == ROLE_TYPE_Kankyaku then
            f2_local0[27] = 100
        elseif f2_local4 == 1 and f2_arg1:GetTeamOrder(ORDER_TYPE_Role) == ROLE_TYPE_Torimaki then
            f2_local0[27] = 100
        elseif f2_local6 == UNREACH_ATTACK then
            f2_local0[27] = 100
        elseif f2_local6 == REACH_ATTACK_TARGET_HIGH_POSITION then
            f2_local0[1] = 150
            f2_local0[27] = 100
        elseif f2_local6 == REACH_ATTACK_TARGET_LOW_POSITION then
            f2_local0[1] = 150
            f2_local0[27] = 100
        else
            f2_local0[27] = 100
        end
    elseif f2_local4 == 1 and f2_arg1:GetTeamOrder(ORDER_TYPE_Role) == ROLE_TYPE_Kankyaku then
        f2_local0[28] = 100
    elseif f2_local4 == 1 and f2_arg1:GetTeamOrder(ORDER_TYPE_Role) == ROLE_TYPE_Torimaki then
        f2_local0[28] = 100
    elseif f2_local7 > 1.8 or f2_local7 < -1.8 then
        if f2_local3 <= 5 then
            f2_local0[24] = 100
            if f2_local7 < -1.8 then
                f2_local0[29] = 500
            end
        else
            f2_local0[1] = 100
        end
    elseif f2_arg1:IsInsideTarget(TARGET_ENE_0, AI_DIR_TYPE_B, 180) then
        if f2_local3 >= 16 then
            f2_local0[21] = 100
        elseif f2_local3 > 7 then
            f2_local0[21] = 100
        elseif f2_local3 > 5 then
            f2_local0[21] = 100
        else
            f2_local0[21] = 1
            f2_local0[9] = 100
        end
    elseif f2_local3 >= 12 then
        f2_local0[2] = 200
        f2_local0[24] = 10
    elseif f2_local3 >= 7 then
        f2_local0[1] = 0
        f2_local0[2] = 200
        f2_local0[3] = 0
        f2_local0[4] = 0
        f2_local0[7] = 0
        f2_local0[8] = 0
        f2_local0[9] = 0
        f2_local0[24] = 10
    elseif f2_local3 >= 5 then
        f2_local0[1] = 200
        f2_local0[3] = 0
        f2_local0[4] = 200
        f2_local0[7] = 100
        f2_local0[9] = 0
    elseif f2_local7 > 1.2 or f2_local7 < -1.2 then
        f2_local0[24] = 10
        if f2_local7 < -1.2 then
            f2_local0[29] = 100
        end
    elseif f2_local3 > 3 then
        f2_local0[1] = 100
        f2_local0[3] = 0
        f2_local0[4] = 100
        f2_local0[7] = 0
        f2_local0[9] = 100
        f2_local0[10] = 100
    else
        f2_local0[1] = 150
        f2_local0[3] = 0
        f2_local0[4] = 100
        f2_local0[7] = 0
        f2_local0[9] = 150
        f2_local0[10] = 100
    end
    if SpaceCheck(f2_arg1, f2_arg2, 45, 5) == false and SpaceCheck(f2_arg1, f2_arg2, -45, 5) == false then
        f2_local0[9] = 0
    end
    if SpaceCheck(f2_arg1, f2_arg2, 90, 1) == false and SpaceCheck(f2_arg1, f2_arg2, -45, 1) == false then
        f2_local0[23] = 0
    end
    if SpaceCheck(f2_arg1, f2_arg2, 180, 5) == false then
    end
    if SpaceCheck(f2_arg1, f2_arg2, 0, 5) == false then
        f2_local0[2] = 0
    end
    if SpaceCheck(f2_arg1, f2_arg2, 180, 1) == false then
        f2_local0[25] = 0
    end
    if f2_arg1:IsFinishTimer(0) == false then
        f2_local0[9] = 0
    end
    f2_local0[1] = SetCoolTime(f2_arg1, f2_arg2, 3000, 6, f2_local0[1], 1)
    f2_local0[3] = SetCoolTime(f2_arg1, f2_arg2, 3011, 6, f2_local0[3], 1)
    f2_local0[4] = SetCoolTime(f2_arg1, f2_arg2, 3003, 6, f2_local0[4], 1)
    f2_local0[5] = SetCoolTime(f2_arg1, f2_arg2, 3006, 6, f2_local0[5], 1)
    f2_local0[6] = SetCoolTime(f2_arg1, f2_arg2, 3007, 10, f2_local0[6], 1)
    f2_local0[7] = SetCoolTime(f2_arg1, f2_arg2, 3009, 5, f2_local0[7], 1)
    f2_local0[8] = SetCoolTime(f2_arg1, f2_arg2, 3015, 6, f2_local0[8], 1)
    f2_local0[8] = SetCoolTime(f2_arg1, f2_arg2, 3016, 6, f2_local0[8], 1)
    f2_local0[9] = SetCoolTime(f2_arg1, f2_arg2, 3017, 10, f2_local0[9], 1)
    f2_local0[10] = SetCoolTime(f2_arg1, f2_arg2, 3009, 6, f2_local0[10], 1)
    f2_local1[1] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act01)
    f2_local1[2] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act02)
    f2_local1[3] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act03)
    f2_local1[4] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act04)
    f2_local1[5] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act05)
    f2_local1[6] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act06)
    f2_local1[7] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act07)
    f2_local1[8] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act08)
    f2_local1[9] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act09)
    f2_local1[10] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act10)
    f2_local1[21] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act21)
    f2_local1[22] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act22)
    f2_local1[23] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act23)
    f2_local1[24] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act24)
    f2_local1[25] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act25)
    f2_local1[26] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act26)
    f2_local1[27] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act27)
    f2_local1[28] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act28)
    f2_local1[29] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act29)
    f2_local1[30] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act30)
    f2_local1[31] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act31)
    f2_local1[40] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act40)
    f2_local1[41] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act41)
    f2_local1[42] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act42)
    f2_local1[43] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act43)
    f2_local1[44] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act44)
    f2_local1[45] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act45)
    local f2_local9 = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.ActAfter_AdjustSpace)
    Common_Battle_Activate(f2_arg1, f2_arg2, f2_local0, f2_local1, f2_local9, f2_local2)
    
end

Goal.Act01 = function (f3_arg0, f3_arg1, f3_arg2)
    local f3_local0 = f3_arg0:GetDist(TARGET_ENE_0)
    local f3_local1 = 4.8 - f3_arg0:GetMapHitRadius(TARGET_SELF)
    local f3_local2 = 999
    local f3_local3 = 999
    local f3_local4 = 0
    local f3_local5 = 0
    local f3_local6 = 1.5
    local f3_local7 = 3
    Approach_Act_Flex(f3_arg0, f3_arg1, f3_local1, f3_local2, f3_local3, f3_local4, f3_local5, f3_local6, f3_local7)
    local f3_local8 = 3000
    local f3_local9 = 3001
    local f3_local10 = 3002
    local f3_local11 = 3008
    local f3_local12 = 3005
    local f3_local13 = 4.1 - f3_arg0:GetMapHitRadius(TARGET_SELF)
    local f3_local14 = 4.5 - f3_arg0:GetMapHitRadius(TARGET_SELF)
    local f3_local15 = 4.5 - f3_arg0:GetMapHitRadius(TARGET_SELF)
    local f3_local16 = f3_arg0:GetRandam_Int(1, 100)
    f3_arg1:AddSubGoal(GOAL_COMMON_ComboAttackTunableSpin, 10, f3_local8, TARGET_ENE_0, f3_local13, 0, 0, 0, 0)
    f3_arg1:AddSubGoal(GOAL_COMMON_ComboRepeat, 10, f3_local9, TARGET_ENE_0, f3_local14, 0)
    f3_arg1:AddSubGoal(GOAL_COMMON_ComboRepeat, 10, f3_local10, TARGET_ENE_0, 999, 0)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act02 = function (f4_arg0, f4_arg1, f4_arg2)
    local f4_local0 = f4_arg0:GetDist(TARGET_ENE_0)
    local f4_local1 = 4.8 - f4_arg0:GetMapHitRadius(TARGET_SELF)
    local f4_local2 = 999
    local f4_local3 = 999
    local f4_local4 = 0
    local f4_local5 = 0
    local f4_local6 = 1.5
    local f4_local7 = 3
    local f4_local8 = 3000
    local f4_local9 = 3001
    local f4_local10 = 3002
    local f4_local11 = 3008
    local f4_local12 = 3005
    local f4_local13 = 4.1 - f4_arg0:GetMapHitRadius(TARGET_SELF)
    local f4_local14 = 4.5 - f4_arg0:GetMapHitRadius(TARGET_SELF)
    local f4_local15 = 4.5 - f4_arg0:GetMapHitRadius(TARGET_SELF)
    local f4_local16 = f4_arg0:GetRandam_Int(1, 100)
    f4_arg1:AddSubGoal(GOAL_COMMON_ComboRepeat, 10, 3034, TARGET_ENE_0, 9999, 0)
    f4_arg0:SetTimer(0, 8)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act03 = function (f5_arg0, f5_arg1, f5_arg2)
    local f5_local0 = f5_arg0:GetDist(TARGET_ENE_0)
    local f5_local1 = 2.6 - f5_arg0:GetMapHitRadius(TARGET_SELF)
    local f5_local2 = 999
    local f5_local3 = 999
    local f5_local4 = 0
    local f5_local5 = 0
    local f5_local6 = 1.5
    local f5_local7 = 3
    local f5_local8 = f5_arg0:GetRandam_Int(1, 100)
    Approach_Act_Flex(f5_arg0, f5_arg1, f5_local1, f5_local2, f5_local3, f5_local4, f5_local5, f5_local6, f5_local7)
    if f5_local8 <= 50 then
        f5_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3012, TARGET_ENE_0, 9999, 0, 0)
    else
        f5_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3014, TARGET_ENE_0, 9999, 0, 0)
    end
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act04 = function (f6_arg0, f6_arg1, f6_arg2)
    local f6_local0 = 3.6 - f6_arg0:GetMapHitRadius(TARGET_SELF)
    local f6_local1 = 999
    local f6_local2 = 999
    local f6_local3 = 0
    local f6_local4 = 0
    local f6_local5 = 1.5
    local f6_local6 = 3
    local f6_local7 = f6_arg0:GetRandam_Int(1, 100)
    Approach_Act_Flex(f6_arg0, f6_arg1, f6_local0, f6_local1, f6_local2, f6_local3, f6_local4, f6_local5, f6_local6)
    local f6_local8 = 4.7 - f6_arg0:GetMapHitRadius(TARGET_SELF)
    f6_arg1:AddSubGoal(GOAL_COMMON_ComboAttackTunableSpin, 10, 3003, TARGET_ENE_0, f6_local8, 0, 0, 0, 0)
    f6_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3004, TARGET_ENE_0, 9999, 0, 0)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act07 = function (f7_arg0, f7_arg1, f7_arg2)
    local f7_local0 = f7_arg0:GetDist(TARGET_ENE_0)
    local f7_local1 = 5 - f7_arg0:GetMapHitRadius(TARGET_SELF)
    local f7_local2 = 99
    local f7_local3 = 99
    local f7_local4 = 0
    local f7_local5 = 0
    local f7_local6 = 1.5
    local f7_local7 = 3
    f7_arg0:AddObserveSpecialEffectAttribute(TARGET_SELF, 5025)
    if f7_local0 <= f7_local1 + 4 then
        Approach_Act_Flex(f7_arg0, f7_arg1, f7_local1, f7_local2, f7_local3, f7_local4, f7_local5, f7_local6, f7_local7)
    else
        Approach_Act_Flex(f7_arg0, f7_arg1, f7_local1 + 4, f7_local2, f7_local3, f7_local4, f7_local5, f7_local6, f7_local7)
        f7_arg1:AddSubGoal(GOAL_COMMON_SpinStep, 3, 5200, TARGET_ENE_0, 0, AI_DIR_TYPE_F, 3)
    end
    f7_arg1:AddSubGoal(GOAL_COMMON_ComboAttackTunableSpin, 10, 3009, TARGET_ENE_0, DistToAtt1, 0, 0, 0, 0)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act08 = function (f8_arg0, f8_arg1, f8_arg2)
    local f8_local0 = f8_arg0:GetDist(TARGET_ENE_0)
    local f8_local1 = 3.2 - f8_arg0:GetMapHitRadius(TARGET_SELF)
    local f8_local2 = 999
    local f8_local3 = 999
    local f8_local4 = 0
    local f8_local5 = 0
    local f8_local6 = 1.5
    local f8_local7 = 3
    Approach_Act_Flex(f8_arg0, f8_arg1, f8_local1, f8_local2, f8_local3, f8_local4, f8_local5, f8_local6, f8_local7)
    local f8_local8 = 3015
    local f8_local9 = 3016
    local f8_local10 = 2.6 - f8_arg0:GetMapHitRadius(TARGET_SELF)
    local f8_local11 = f8_arg0:GetRandam_Int(1, 100)
    if f8_local0 >= 2.6 then
        f8_arg1:AddSubGoal(GOAL_COMMON_ComboAttackTunableSpin, 10, f8_local8, TARGET_ENE_0, f8_local10, 0, 0, 0, 0)
    else
        f8_arg1:AddSubGoal(GOAL_COMMON_ComboAttackTunableSpin, 10, f8_local9, TARGET_ENE_0, f8_local10, 0, 0, 0, 0)
    end
    if f8_local11 <= 50 then
        f8_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3011, TARGET_ENE_0, 2.6 - f8_arg0:GetMapHitRadius(TARGET_SELF), 0)
    else
        f8_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3013, TARGET_ENE_0, 2.6 - f8_arg0:GetMapHitRadius(TARGET_SELF), 0)
    end
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act09 = function (f9_arg0, f9_arg1, f9_arg2)
    local f9_local0 = f9_arg0:GetRandam_Int(1, 100)
    local f9_local1 = f9_arg0:GetRandam_Int(1, 100)
    if SpaceCheck(f9_arg0, f9_arg1, 135, 5) then
        if f9_local0 <= 50 then
            f9_arg1:AddSubGoal(GOAL_COMMON_ComboAttackTunableSpin, 10, 5213, TARGET_ENE_0, 7.2 - f9_arg0:GetMapHitRadius(TARGET_SELF), 0, 0, 0, 0)
            f9_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3017, TARGET_ENE_0, 9999, 0, 0)
        else
            f9_arg1:AddSubGoal(GOAL_COMMON_ComboAttackTunableSpin, 10, 5212, TARGET_ENE_0, 7.2 - f9_arg0:GetMapHitRadius(TARGET_SELF), 0, 0, 0, 0)
            f9_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3017, TARGET_ENE_0, 9999, 0, 0)
        end
    elseif SpaceCheck(f9_arg0, f9_arg1, -135, 5) then
        if f9_local1 <= 50 then
            f9_arg1:AddSubGoal(GOAL_COMMON_ComboAttackTunableSpin, 10, 5212, TARGET_ENE_0, 7.2 - f9_arg0:GetMapHitRadius(TARGET_SELF), 0, 0, 0, 0)
            f9_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3017, TARGET_ENE_0, 9999, 0, 0)
        else
            f9_arg1:AddSubGoal(GOAL_COMMON_ComboAttackTunableSpin, 10, 5212, TARGET_ENE_0, 7.2 - f9_arg0:GetMapHitRadius(TARGET_SELF), 0, 0, 0, 0)
            f9_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3009, TARGET_ENE_0, 9999, 0, 0)
        end
    else
        f9_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3017, TARGET_ENE_0, 9999, 0, 0)
    end
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
    
end

Goal.Act10 = function (f10_arg0, f10_arg1, f10_arg2)
    local f10_local0 = f10_arg0:GetRandam_Int(1, 100)
    local f10_local1 = f10_arg0:GetRandam_Int(1, 100)
    f10_arg1:AddSubGoal(GOAL_COMMON_ComboAttackTunableSpin, 10, 5212, TARGET_ENE_0, 7.2 - f10_arg0:GetMapHitRadius(TARGET_SELF), 0, 0, 0, 0)
    f10_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3009, TARGET_ENE_0, 9999, 0, 0)
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
    
end

Goal.Act21 = function (f11_arg0, f11_arg1, f11_arg2)
    f11_arg1:AddSubGoal(GOAL_COMMON_Turn, 3, TARGET_ENE_0, f11_arg0:GetRandam_Int(15, 30))
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
    
end

Goal.Act23 = function (f12_arg0, f12_arg1, f12_arg2)
    local f12_local0 = 0
    local f12_local1 = -1
    local f12_local2 = 0
    if SpaceCheck(f12_arg0, f12_arg1, -90, 1) == true then
        if SpaceCheck(f12_arg0, f12_arg1, 90, 1) == true then
            if f12_arg0:IsInsideTarget(TARGET_ENE_0, AI_DIR_TYPE_R, 180) then
                f12_local2 = 0
            else
                f12_local2 = 1
            end
        else
            f12_local2 = 0
        end
    elseif SpaceCheck(f12_arg0, f12_arg1, 90, 1) == true then
        f12_local2 = 1
    else
    end
    local f12_local3 = 1.8
    local f12_local4 = f12_arg0:GetRandam_Int(30, 45)
    f12_arg1:AddSubGoal(GOAL_COMMON_SidewayMove, f12_local3, TARGET_ENE_0, f12_local2, f12_local4, true, true, f12_local1)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act24 = function (f13_arg0, f13_arg1, f13_arg2)
    local f13_local0 = f13_arg0:GetDist(TARGET_ENE_0)
    local f13_local1 = f13_arg0:GetDistY(TARGET_ENE_0)
    local f13_local2 = 999
    local f13_local3 = 999
    local f13_local4 = 0
    local f13_local5 = 0
    local f13_local6 = 20
    local f13_local7 = 0
    local f13_local8 = f13_arg0:GetRandam_Int(1, 100)
    if f13_local0 >= 12 then
        f13_arg1:AddSubGoal(GOAL_COMMON_ApproachTarget, f13_local6, TARGET_ENE_0, 11.8, TARGET_SELF, true, -1)
    elseif f13_local0 <= 5 and f13_local1 > 1.2 then
        f13_arg1:AddSubGoal(GOAL_COMMON_ApproachTarget, 10, TARGET_ENE_0, 0.5, TARGET_SELF, true, -1)
    elseif f13_local0 <= 5 and f13_local1 < -1.2 then
        f13_arg1:AddSubGoal(GOAL_COMMON_ApproachTarget, 10, TARGET_ENE_0, 0.5, TARGET_SELF, true, -1)
    else
        f13_arg1:AddSubGoal(GOAL_COMMON_ApproachTarget, f13_local6, TARGET_ENE_0, 6.8, TARGET_SELF, true, -1)
    end
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
    
end

Goal.Act25 = function (f14_arg0, f14_arg1, f14_arg2)
    local f14_local0 = 0
    local f14_local1 = -1
    local f14_local2 = f14_arg0:GetRandam_Float(3, 5)
    local f14_local3 = 5
    if SpaceCheck(f14_arg0, f14_arg1, 180, 1) == true then
        f14_arg1:AddSubGoal(GOAL_COMMON_LeaveTarget, f14_local2, TARGET_ENE_0, f14_local3, TARGET_ENE_0, true, f14_local1)
    else
        f14_arg0:Replannning()
    end
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
    
end

Goal.Act26 = function (f15_arg0, f15_arg1, f15_arg2)
    f15_arg1:AddSubGoal(GOAL_COMMON_Wait, 0.5, TARGET_ENE_0, 0, 0, 0)
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
    
end

Goal.Act27 = function (f16_arg0, f16_arg1, f16_arg2)
    local f16_local0 = f16_arg0:GetRandam_Int(1, 100)
    if YousumiAct_SubGoal(f16_arg0, f16_arg1, true, 60, 30) == false then
        GetWellSpace_Odds = 0
        return GetWellSpace_Odds
    end
    local f16_local1 = 0
    local f16_local2 = SpaceCheck_SidewayMove(f16_arg0, f16_arg1, 1)
    if f16_local2 == 0 then
        f16_local1 = 0
    elseif f16_local2 == 1 then
        f16_local1 = 1
    elseif f16_local2 == 2 then
        if f16_local0 <= 50 then
            f16_local1 = 0
        else
            f16_local1 = 1
        end
    else
        f16_arg1:AddSubGoal(GOAL_COMMON_Wait, 1, TARGET_SELF, 0, 0, 0)
        GetWellSpace_Odds = 0
        return GetWellSpace_Odds
    end
    f16_arg0:SetNumber(10, f16_local1)
    f16_arg1:AddSubGoal(GOAL_COMMON_SidewayMove, 3, TARGET_ENE_0, f16_local1, f16_arg0:GetRandam_Int(30, 45), true, true, -1):SetTargetRange(0, -99, 12)
    f16_arg0:SetNumber(NUMBER_SLOT_FIGHT_COUNT, 0)
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
    
end

Goal.Act28 = function (f17_arg0, f17_arg1, f17_arg2)
    local f17_local0 = f17_arg0:GetDist(TARGET_ENE_0)
    local f17_local1 = f17_arg0:GetRandam_Float(3, 3.5)
    local f17_local2 = f17_arg0:GetRandam_Int(30, 45)
    local f17_local3 = -1
    local f17_local4 = f17_arg0:GetRandam_Int(0, 1)
    if f17_local0 <= 5 then
        if SpaceCheck(f17_arg0, f17_arg1, 180, 1) == true then
            f17_arg1:AddSubGoal(GOAL_COMMON_LeaveTarget, 3, TARGET_ENE_0, 6, TARGET_ENE_0, true, f17_local3)
        else
            f17_arg1:AddSubGoal(GOAL_COMMON_SidewayMove, f17_local1, TARGET_ENE_0, f17_local4, f17_local2, true, true, f17_local3)
        end
    elseif f17_local0 <= 7 then
        f17_arg1:AddSubGoal(GOAL_COMMON_SidewayMove, f17_local1, TARGET_ENE_0, f17_local4, f17_local2, true, true, f17_local3)
    else
        f17_arg1:AddSubGoal(GOAL_COMMON_ApproachTarget, 3, TARGET_ENE_0, 3, TARGET_SELF, true, -1)
    end
    return GETWELLSPACE_ODDS
    
end

Goal.Act29 = function (f18_arg0, f18_arg1, f18_arg2)
    f18_arg1:AddSubGoal(GOAL_COMMON_ComboRepeat, 10, 3042, TARGET_ENE_0, 9999, 0)
    f18_arg0:SetTimer(0, 8)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act30 = function (f19_arg0, f19_arg1, f19_arg2)
    local f19_local0 = 3030
    local f19_local1 = 3031
    local f19_local2 = 3032
    local f19_local3 = 3033
    local f19_local4 = 3034
    local f19_local5 = ATT_SUCCESSDIST
    f19_arg1:AddSubGoal(GOAL_COMMON_ComboAttack_SuccessAngle180, 20, f19_local2, TARGET_ENE_0, 9999, 0)
    f19_arg1:AddSubGoal(GOAL_COMMON_ComboRepeat_SuccessAngle180, 20, f19_local0, TARGET_ENE_0, 9999, 0)
    f19_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 20, 3021, TARGET_ENE_0, 9999, 0, 0)
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
    
end

Goal.Act31 = function (f20_arg0, f20_arg1, f20_arg2)
    local f20_local0 = 3039
    local f20_local1 = 3040
    local f20_local2 = 3041
    local f20_local3 = 3042
    local f20_local4 = 3043
    local f20_local5 = 3044
    local f20_local6 = 3045
    local f20_local7 = ATT_SUCCESSDIST
    local f20_local8 = f20_arg0:GetRandam_Int(1, 100)
    f20_arg1:AddSubGoal(GOAL_COMMON_ComboAttackTunableSpin, 10, f20_local0, TARGET_ENE_0, 9999, 0, 0, 0, 0)
    f20_arg1:AddSubGoal(GOAL_COMMON_ComboRepeat, 10, f20_local1, TARGET_ENE_0, 9999, 0, 0, 0, 0)
    f20_arg1:AddSubGoal(GOAL_COMMON_ComboRepeat, 10, f20_local2, TARGET_ENE_0, 9999, 0, 0, 0, 0)
    f20_arg1:AddSubGoal(GOAL_COMMON_ComboRepeat, 10, f20_local3, TARGET_ENE_0, 9999, 0, 0, 0, 0)
    f20_arg1:AddSubGoal(GOAL_COMMON_ComboRepeat, 10, f20_local4, TARGET_ENE_0, 9999, 0, 0, 0, 0)
    f20_arg1:AddSubGoal(GOAL_COMMON_ComboRepeat, 10, f20_local5, TARGET_ENE_0, 9999, 0, 0, 0, 0)
    f20_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, f20_local6, TARGET_ENE_0, 9999, 0, 0, 0, 0)
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
    
end

Goal.Act40 = function (f21_arg0, f21_arg1, f21_arg2)
    local f21_local0 = 3
    local f21_local1 = 0
    local f21_local2 = 4.5
    local f21_local3 = f21_arg0:GetRandam_Int(30, 45)
    if SpaceCheck(f21_arg0, f21_arg1, 180, 5) then
        f21_arg1:AddSubGoal(GOAL_COMMON_SpinStep, f21_local0, 5201, TARGET_ENE_0, f21_local1, AI_DIR_TYPE_B, 0)
        f21_local2 = 0.1
    end
    local f21_local4 = 0
    if SpaceCheck(f21_arg0, f21_arg1, -90, 1) == true then
        if SpaceCheck(f21_arg0, f21_arg1, 90, 1) == true then
            if f21_arg0:IsInsideTarget(TARGET_ENE_0, AI_DIR_TYPE_R, 180) then
                f21_local4 = 0
            else
                f21_local4 = 1
            end
        else
            f21_local4 = 0
        end
    elseif SpaceCheck(f21_arg0, f21_arg1, 90, 1) == true then
        f21_local4 = 1
    else
    end
    f21_arg1:AddSubGoal(GOAL_COMMON_SidewayMove, f21_local2, TARGET_ENE_0, f21_local4, f21_local3, true, true, -1)
    return GETWELLSPACE_ODDS
    
end

Goal.Act41 = function (f22_arg0, f22_arg1, f22_arg2)
    local f22_local0 = 4.8 - f22_arg0:GetMapHitRadius(TARGET_SELF)
    local f22_local1 = 99
    local f22_local2 = 99
    local f22_local3 = 0
    local f22_local4 = 0
    local f22_local5 = 1.5
    local f22_local6 = 3
    Approach_Act_Flex(f22_arg0, f22_arg1, f22_local0, f22_local1, f22_local2, f22_local3, f22_local4, f22_local5, f22_local6)
    local f22_local7 = 3000
    local f22_local8 = 3001
    local f22_local9 = 3002
    local f22_local10 = 3008
    local f22_local11 = 4.1 - f22_arg0:GetMapHitRadius(TARGET_SELF)
    local f22_local12 = 4.5 - f22_arg0:GetMapHitRadius(TARGET_SELF)
    local f22_local13 = 4.5 - f22_arg0:GetMapHitRadius(TARGET_SELF)
    f22_arg1:AddSubGoal(GOAL_COMMON_ComboAttackTunableSpin, 10, 3000, TARGET_ENE_0, 9999, 0, 0, 0, 0)
    f22_arg1:AddSubGoal(GOAL_COMMON_ComboRepeat, 10, 3066, TARGET_ENE_0, f22_local12, 0)
    f22_arg1:AddSubGoal(GOAL_COMMON_ComboRepeat, 10, 3011, TARGET_ENE_0, 9999, 0)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act42 = function (f23_arg0, f23_arg1, f23_arg2)
    local f23_local0 = 7.2 - f23_arg0:GetMapHitRadius(TARGET_SELF)
    local f23_local1 = 99
    local f23_local2 = 99
    local f23_local3 = 0
    local f23_local4 = 0
    local f23_local5 = 1.5
    local f23_local6 = 3
    Approach_Act_Flex(f23_arg0, f23_arg1, f23_local0, f23_local1, f23_local2, f23_local3, f23_local4, f23_local5, f23_local6)
    f23_arg1:AddSubGoal(GOAL_COMMON_ComboAttackTunableSpin, 10, 3079, TARGET_ENE_0, 9999, 0, 0, 0, 0)
    f23_arg1:AddSubGoal(GOAL_COMMON_ComboRepeat, 10, 3017, TARGET_ENE_0, 9999, 0, 0, 0, 0)
    f23_arg1:AddSubGoal(GOAL_COMMON_ComboRepeat, 10, 3019, TARGET_ENE_0, DistToAtt4, 0)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act43 = function (f24_arg0, f24_arg1, f24_arg2)
    local f24_local0 = 4.8 - f24_arg0:GetMapHitRadius(TARGET_SELF)
    local f24_local1 = 99
    local f24_local2 = 99
    local f24_local3 = 0
    local f24_local4 = 0
    local f24_local5 = 1.5
    local f24_local6 = 3
    Approach_Act_Flex(f24_arg0, f24_arg1, f24_local0, f24_local1, f24_local2, f24_local3, f24_local4, f24_local5, f24_local6)
    f24_arg1:AddSubGoal(GOAL_COMMON_ComboAttackTunableSpin, 10, 5212, TARGET_ENE_0, 9999, 0, 0, 0, 0)
    f24_arg1:AddSubGoal(GOAL_COMMON_ComboRepeat_SuccessAngle180, 10, 3009, TARGET_ENE_0, 9999, 0, 0, 0, 0)
    f24_arg1:AddSubGoal(GOAL_COMMON_ComboRepeat, 10, 3019, TARGET_ENE_0, DistToAtt4, 0)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act44 = function (f25_arg0, f25_arg1, f25_arg2)
    local f25_local0 = 4.8 - f25_arg0:GetMapHitRadius(TARGET_SELF)
    local f25_local1 = 99
    local f25_local2 = 99
    local f25_local3 = 0
    local f25_local4 = 0
    local f25_local5 = 1.5
    local f25_local6 = 3
    Approach_Act_Flex(f25_arg0, f25_arg1, f25_local0, f25_local1, f25_local2, f25_local3, f25_local4, f25_local5, f25_local6)
    local f25_local7 = 3021
    f25_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 10, f25_local7, TARGET_ENE_0, 9999, 0, 0, 0, 0)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act45 = function (f26_arg0, f26_arg1, f26_arg2)
    local f26_local0 = 3
    if SpaceCheck(f26_arg0, f26_arg1, 180, 5) == true then
        f26_arg1:AddSubGoal(GOAL_COMMON_SpinStep, f26_local0, 5201, TARGET_ENE_0, 0, AI_DIR_TYPE_B, 0)
    end
    f26_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3007, TARGET_ENE_0, 999, 0, 0)
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
    
end

Goal.ActAfter_AdjustSpace = function (f27_arg0, f27_arg1, f27_arg2)
    
end

Goal.Update = function (f28_arg0, f28_arg1, f28_arg2)
    return Update_Default_NoSubGoal(f28_arg0, f28_arg1, f28_arg2)
    
end

Goal.Terminate = function (f29_arg0, f29_arg1, f29_arg2)
    
end

Goal.Interrupt = function (f30_arg0, f30_arg1, f30_arg2)
    local f30_local0 = 1
    local f30_local1 = f30_arg1:GetSpecialEffectActivateInterruptType(0)
    local f30_local2 = f30_arg1:GetRandam_Int(1, 100)
    local f30_local3 = f30_arg1:GetDist(TARGET_ENE_0)
    if f30_arg1:IsLadderAct(TARGET_SELF) then
        return false
    end
    if not f30_arg1:HasSpecialEffectId(TARGET_SELF, 200004) then
        return false
    end
    if f30_arg1:IsInterupt(INTERUPT_ParryTiming) then
        return Common_Parry(f30_arg1, f30_arg2, 100, 0, 1, 3103)
    end
    if f30_arg1:IsInterupt(INTERUPT_ShootImpact) and f30_arg0.ShootReaction(f30_arg1, f30_arg2) then
        return true
    end
    if f30_arg1:IsInterupt(INTERUPT_GuardBreak) and f30_local2 <= 60 then
        f30_arg2:ClearSubGoal()
        f30_arg2:AddSubGoal(GOAL_COMMON_EndureAttack, 3, 3021, TARGET_ENE_0, 9999, 0)
        f30_arg1:SetTimer(5, 0.1)
        return true
    end
    if Interupt_PC_Break(f30_arg1) and f30_arg1:GetTimer(5) <= 0 then
        f30_arg1:Replanning()
        return true
    end
    if Interupt_Use_Item(f30_arg1, 4, 10) and f30_arg1:IsInsideTarget(TARGET_ENE_0, AI_DIR_TYPE_F, 180) then
        if f30_local3 < 5 then
            f30_arg2:ClearSubGoal()
            f30_arg2:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 1, 3017, TARGET_ENE_0, 9999, 0)
            return true
        elseif f30_local3 < 7 then
            f30_arg2:ClearSubGoal()
            f30_arg2:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 1, 3009, TARGET_ENE_0, 9999, 0)
            return true
        else
            f30_arg1:Replanning()
            return true
        end
    end
    if f30_arg1:IsInterupt(INTERUPT_ActivateSpecialEffect) then
        if f30_local1 == 5025 then
            if f30_arg1:HasSpecialEffectId(TARGET_ENE_0, 110060) == false or f30_arg1:HasSpecialEffectId(TARGET_ENE_0, 110010) == false or f30_arg1:HasSpecialEffectId(TARGET_ENE_0, 110015) == false then
                if f30_local3 <= 3.34 - f30_arg1:GetMapHitRadius(TARGET_SELF) then
                    f30_arg2:ClearSubGoal()
                    f30_arg2:AddSubGoal(GOAL_COMMON_EndureAttack, 3, 3023, TARGET_ENE_0, 9999, 0)
                    return true
                elseif f30_local3 <= 15 - f30_arg1:GetMapHitRadius(TARGET_SELF) then
                    f30_arg2:ClearSubGoal()
                    f30_arg2:AddSubGoal(GOAL_COMMON_EndureAttack, 3, 3017, TARGET_ENE_0, 9999, 0)
                    return true
                end
            end
        elseif f30_local1 == 5026 then
            if f30_local3 <= 4.1 - f30_arg1:GetMapHitRadius(TARGET_SELF) then
                f30_arg2:ClearSubGoal()
                f30_arg2:AddSubGoal(GOAL_COMMON_EndureAttack, 3, 3006, TARGET_ENE_0, 9999, 0)
                return true
            elseif f30_local3 <= 7.2 - f30_arg1:GetMapHitRadius(TARGET_SELF) then
                f30_arg2:ClearSubGoal()
                f30_arg2:AddSubGoal(GOAL_COMMON_EndureAttack, 3, 3006, TARGET_ENE_0, 9999, 0)
                return true
            else
            end
        end
    end
    return false
    
end

Goal.ShootReaction = function (f31_arg0, f31_arg1)
    f31_arg1:ClearSubGoal()
    f31_arg1:AddSubGoal(GOAL_COMMON_EndureAttack, 0.1, 3100, TARGET_ENE_0, 9999, 0)
    return true
    
end

Goal.Kengeki_Activate = function (f32_arg0, f32_arg1, f32_arg2, f32_arg3)
    local f32_local0 = ReturnKengekiSpecialEffect(f32_arg1)
    if f32_local0 == 0 then
        return false
    end
    local f32_local1 = {}
    local f32_local2 = {}
    local f32_local3 = {}
    Common_Clear_Param(f32_local1, f32_local2, f32_local3)
    local f32_local4 = f32_arg1:GetDist(TARGET_ENE_0)
    f32_arg1:SetNumber(5, f32_arg1:GetNumber(5) + 1)
    if f32_local0 == 200200 then
        if f32_local4 >= 3 then
            f32_local1[31] = 100
        else
            f32_local1[31] = 100
        end
    elseif f32_local0 == 200201 then
        if f32_local4 >= 3 then
            f32_local1[31] = 100
        else
            f32_local1[31] = 100
        end
    elseif f32_local0 == 200210 then
        if f32_local4 >= 3 then
            f32_local1[31] = 100
        else
            f32_local1[7] = 100
        end
    elseif f32_local0 == 200211 then
        if f32_local4 >= 3 then
            f32_local1[31] = 100
        else
            f32_local1[6] = 100
        end
    end
    if f32_arg1:GetNumber(5) >= 3 then
        if f32_arg1:GetNinsatsuNum() <= 1 then
            f32_local1[44] = 300
        else
            f32_local1[45] = 300
        end
    end
    if SpaceCheck(f32_arg1, f32_arg2, 180, 5) == false then
    end
    f32_local1[6] = SetCoolTime(f32_arg1, f32_arg2, 3066, 3, f32_local1[6], 1)
    f32_local1[7] = SetCoolTime(f32_arg1, f32_arg2, 3063, 3, f32_local1[7], 1)
    f32_local2[1] = REGIST_FUNC(f32_arg1, f32_arg2, f32_arg0.Kengeki01)
    f32_local2[2] = REGIST_FUNC(f32_arg1, f32_arg2, f32_arg0.Kengeki02)
    f32_local2[3] = REGIST_FUNC(f32_arg1, f32_arg2, f32_arg0.Kengeki03)
    f32_local2[4] = REGIST_FUNC(f32_arg1, f32_arg2, f32_arg0.Kengeki04)
    f32_local2[5] = REGIST_FUNC(f32_arg1, f32_arg2, f32_arg0.Kengeki05)
    f32_local2[6] = REGIST_FUNC(f32_arg1, f32_arg2, f32_arg0.Kengeki06)
    f32_local2[7] = REGIST_FUNC(f32_arg1, f32_arg2, f32_arg0.Kengeki07)
    f32_local2[8] = REGIST_FUNC(f32_arg1, f32_arg2, f32_arg0.Kengeki08)
    f32_local2[15] = REGIST_FUNC(f32_arg1, f32_arg2, f32_arg0.Kengeki15)
    f32_local2[16] = REGIST_FUNC(f32_arg1, f32_arg2, f32_arg0.Kengeki16)
    f32_local2[21] = REGIST_FUNC(f32_arg1, f32_arg2, f32_arg0.Act21)
    f32_local2[22] = REGIST_FUNC(f32_arg1, f32_arg2, f32_arg0.Act22)
    f32_local2[23] = REGIST_FUNC(f32_arg1, f32_arg2, f32_arg0.Act23)
    f32_local2[24] = REGIST_FUNC(f32_arg1, f32_arg2, f32_arg0.Act24)
    f32_local2[25] = REGIST_FUNC(f32_arg1, f32_arg2, f32_arg0.Act25)
    f32_local2[31] = REGIST_FUNC(f32_arg1, f32_arg2, f32_arg0.Replanning)
    f32_local2[40] = REGIST_FUNC(f32_arg1, f32_arg2, f32_arg0.Kengeki40)
    f32_local2[41] = REGIST_FUNC(f32_arg1, f32_arg2, f32_arg0.Kengeki41)
    f32_local2[42] = REGIST_FUNC(f32_arg1, f32_arg2, f32_arg0.Kengeki42)
    f32_local2[43] = REGIST_FUNC(f32_arg1, f32_arg2, f32_arg0.Kengeki43)
    f32_local2[44] = REGIST_FUNC(f32_arg1, f32_arg2, f32_arg0.Kengeki44)
    f32_local2[45] = REGIST_FUNC(f32_arg1, f32_arg2, f32_arg0.Kengeki45)
    local f32_local5 = REGIST_FUNC(f32_arg1, f32_arg2, f32_arg0.ActAfter_AdjustSpace)
    return Common_Kengeki_Activate(f32_arg1, f32_arg2, f32_local1, f32_local2, f32_local5, f32_local3)
    
end

Goal.Kengeki01 = function (f33_arg0, f33_arg1, f33_arg2)
    local f33_local0 = f33_arg0:GetRandam_Int(1, 100)
    local f33_local1 = f33_arg0:GetRandam_Int(1, 100)
    f33_arg1:ClearSubGoal()
    if f33_local0 <= 50 then
        f33_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3011, TARGET_ENE_0, 9999, 0, 0)
        f33_arg0:SetNumber(1, 0)
    else
        f33_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3013, TARGET_ENE_0, 9999, 0, 0)
        f33_arg0:SetNumber(1, 1)
    end
    
end

Goal.Kengeki02 = function (f34_arg0, f34_arg1, f34_arg2)
    f34_arg1:ClearSubGoal()
    f34_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3061, TARGET_ENE_0, 9999, 0, 0)
    
end

Goal.Kengeki03 = function (f35_arg0, f35_arg1, f35_arg2)
    f35_arg1:ClearSubGoal()
    f35_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3082, TARGET_ENE_0, 9999, 0, 0)
    
end

Goal.Kengeki04 = function (f36_arg0, f36_arg1, f36_arg2)
    f36_arg1:ClearSubGoal()
    f36_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3083, TARGET_ENE_0, 9999, 0, 0)
    
end

Goal.Kengeki05 = function (f37_arg0, f37_arg1, f37_arg2)
    f37_arg1:ClearSubGoal()
    f37_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3087, TARGET_ENE_0, 9999, 0, 0)
    
end

Goal.Kengeki06 = function (f38_arg0, f38_arg1, f38_arg2)
    f38_arg1:ClearSubGoal()
    f38_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3066, TARGET_ENE_0, 9999, 0, 0)
    
end

Goal.Kengeki07 = function (f39_arg0, f39_arg1, f39_arg2)
    f39_arg1:ClearSubGoal()
    f39_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3062, TARGET_ENE_0, 9999, 0, 0)
    
end

Goal.Kengeki15 = function (f40_arg0, f40_arg1, f40_arg2)
    f40_arg1:ClearSubGoal()
    f40_arg1:AddSubGoal(GOAL_COMMON_SpinStep, 5, 5201, TARGET_ENE_0, 0, AI_DIR_TYPE_B, 0)
    f40_arg1:AddSubGoal(GOAL_COMMON_ComboRepeat, 10, 3017, TARGET_ENE_0, 9999, 0, 0)
    f40_arg1:AddSubGoal(GOAL_COMMON_ComboRepeat, 10, 3014, TARGET_ENE_0, 2.6, 0)
    f40_arg1:AddSubGoal(GOAL_COMMON_ComboRepeat, 10, 3061, TARGET_ENE_0, 2.6, 0)
    f40_arg1:AddSubGoal(GOAL_COMMON_ComboRepeat, 10, 3067, TARGET_ENE_0, 2.6, 0)
    f40_arg1:AddSubGoal(GOAL_COMMON_ComboRepeat, 10, 3061, TARGET_ENE_0, 2.6, 0)
    f40_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3013, TARGET_ENE_0, 9999, 0, 0)
    
end

Goal.Kengeki16 = function (f41_arg0, f41_arg1, f41_arg2)
    f41_arg1:ClearSubGoal()
    f41_arg1:AddSubGoal(GOAL_COMMON_ComboRepeat, 10, 3061, TARGET_ENE_0, 2.6, 0)
    f41_arg1:AddSubGoal(GOAL_COMMON_ComboRepeat, 10, 3019, TARGET_ENE_0, 2.6, 0)
    f41_arg1:AddSubGoal(GOAL_COMMON_ComboRepeat, 10, 3012, TARGET_ENE_0, 2.6, 0)
    f41_arg1:AddSubGoal(GOAL_COMMON_ComboRepeat, 10, 3067, TARGET_ENE_0, 2.6, 0)
    f41_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 1, 3011, TARGET_ENE_0, 9999, 0, 0)
    
end

Goal.Kengeki43 = function (f42_arg0, f42_arg1, f42_arg2)
    f42_arg1:ClearSubGoal()
    f42_arg1:AddSubGoal(GOAL_COMMON_ComboRepeat_SuccessAngle180, 10, 3092, TARGET_ENE_0, 9999, 0, 0)
    f42_arg1:AddSubGoal(GOAL_COMMON_ComboRepeat_SuccessAngle180, 10, 3090, TARGET_ENE_0, 9999, 0)
    f42_arg1:AddSubGoal(GOAL_COMMON_ComboRepeat_SuccessAngle180, 10, 3093, TARGET_ENE_0, 9999, 0)
    f42_arg1:AddSubGoal(GOAL_COMMON_ComboRepeat_SuccessAngle180, 10, 3091, TARGET_ENE_0, 9999, 0)
    f42_arg1:AddSubGoal(GOAL_COMMON_ComboRepeat, 10, 3067, TARGET_ENE_0, 2.6, 0)
    f42_arg1:AddSubGoal(GOAL_COMMON_ComboRepeat, 10, 3061, TARGET_ENE_0, 2.6, 0)
    f42_arg1:AddSubGoal(GOAL_COMMON_ComboRepeat, 10, 3067, TARGET_ENE_0, 2.6, 0)
    f42_arg1:AddSubGoal(GOAL_COMMON_ComboRepeat, 10, 3061, TARGET_ENE_0, 2.6, 0)
    f42_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 1, 3005, TARGET_ENE_0, 9999, 0, 0)
    f42_arg0:SetNumber(5, 0)
    
end

Goal.Kengeki44 = function (f43_arg0, f43_arg1, f43_arg2)
    f43_arg1:ClearSubGoal()
    f43_arg1:AddSubGoal(GOAL_COMMON_ComboRepeat_SuccessAngle180, 10, 3093, TARGET_ENE_0, 9999, 0)
    f43_arg1:AddSubGoal(GOAL_COMMON_ComboRepeat_SuccessAngle180, 10, 3027, TARGET_ENE_0, 9999, 0)
    f43_arg1:AddSubGoal(GOAL_COMMON_ComboRepeat, 10, 3061, TARGET_ENE_0, 2.6, 0)
    f43_arg1:AddSubGoal(GOAL_COMMON_ComboRepeat, 10, 3067, TARGET_ENE_0, 2.6, 0)
    f43_arg1:AddSubGoal(GOAL_COMMON_ComboRepeat, 10, 3061, TARGET_ENE_0, 2.6, 0)
    f43_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3005, TARGET_ENE_0, 9999, 0, 0)
    f43_arg0:SetNumber(5, 0)
    
end

Goal.Kengeki45 = function (f44_arg0, f44_arg1, f44_arg2)
    f44_arg1:ClearSubGoal()
    f44_arg1:AddSubGoal(GOAL_COMMON_ComboRepeat_SuccessAngle180, 10, 3092, TARGET_ENE_0, 9999, 0)
    f44_arg1:AddSubGoal(GOAL_COMMON_ComboRepeat_SuccessAngle180, 10, 3088, TARGET_ENE_0, 9999, 0)
    f44_arg1:AddSubGoal(GOAL_COMMON_ComboRepeat_SuccessAngle180, 10, 3026, TARGET_ENE_0, 9999, 0)
    f44_arg1:AddSubGoal(GOAL_COMMON_ComboRepeat, 10, 3067, TARGET_ENE_0, 2.6, 0)
    f44_arg1:AddSubGoal(GOAL_COMMON_ComboRepeat, 10, 3061, TARGET_ENE_0, 2.6, 0)
    f44_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3005, TARGET_ENE_0, 9999, 0, 0)
    f44_arg0:SetNumber(5, 0)
    
end

Goal.Replanning = function (f45_arg0, f45_arg1, f45_arg2)
    return -1
    
end


