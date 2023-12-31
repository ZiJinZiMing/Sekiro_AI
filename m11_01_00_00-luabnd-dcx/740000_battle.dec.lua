﻿RegisterTableGoal(GOAL_Iseinomusume_740000_Battle, "GOAL_Iseinomusume_740000_Battle")
REGISTER_GOAL_NO_UPDATE(GOAL_Iseinomusume_740000_Battle, true)

Goal.Initialize = function (f1_arg0, f1_arg1, f1_arg2, f1_arg3)
    
end

Goal.Activate = function (f2_arg0, f2_arg1, f2_arg2)
    Init_Pseudo_Global(f2_arg1, f2_arg2)
    f2_arg1:DeleteObserve(0)
    local f2_local0 = {}
    local f2_local1 = {}
    local f2_local2 = {}
    Common_Clear_Param(f2_local0, f2_local1, f2_local2)
    local f2_local3 = f2_arg1:GetDist(TARGET_ENE_0)
    local f2_local4 = f2_arg1:GetExcelParam(AI_EXCEL_THINK_PARAM_TYPE__thinkAttr_doAdmirer)
    local f2_local5 = 0
    if f2_arg1:HasSpecialEffectId(TARGET_ENE_0, 109031) == true or f2_arg1:HasSpecialEffectId(TARGET_ENE_0, 110125) == true then
        f2_local5 = 1
    else
        f2_local5 = 0
    end
    local f2_local6 = 0
    if f2_arg1:GetHpRate(TARGET_ENE_0) < 0.6 or f2_arg1:GetSpRate(TARGET_ENE_0) < 0.6 or f2_arg1:GetHpRate(TARGET_SELF) < 0.6 or f2_arg1:GetSpRate(TARGET_SELF) < 0.6 then
        f2_local6 = 1
    else
        f2_local6 = 0
    end
    f2_arg1:DeleteObserve(1)
    f2_arg1:AddObserveSpecialEffectAttribute(TARGET_ENE_0, 110111)
    f2_arg1:AddObserveSpecialEffectAttribute(TARGET_ENE_0, 109031)
    f2_arg1:AddObserveSpecialEffectAttribute(TARGET_ENE_0, 110125)
    f2_arg1:AddObserveSpecialEffectAttribute(TARGET_SELF, 5025)
    f2_arg1:AddObserveSpecialEffectAttribute(TARGET_SELF, 5027)
    f2_arg1:AddObserveSpecialEffectAttribute(TARGET_SELF, 5028)
    f2_arg1:AddObserveSpecialEffectAttribute(TARGET_SELF, 5029)
    f2_arg1:AddObserveSpecialEffectAttribute(TARGET_SELF, 3740000)
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
    elseif f2_arg1:CheckDoesExistPath(TARGET_ENE_0, AI_DIR_TYPE_F, 0, 0) == false then
        f2_local0[27] = 100
    elseif f2_arg1:IsInsideTarget(TARGET_ENE_0, AI_DIR_TYPE_B, 180) then
        f2_local0[21] = 100
    elseif f2_arg1:HasSpecialEffectId(TARGET_ENE_0, 110120) and f2_local3 <= 6 then
        f2_local0[7] = 1000
    elseif f2_local5 == 1 and f2_arg1:GetTimer(2) <= 0 then
        f2_arg1:SetTimer(2, 10)
        f2_local0[42] = 100
    elseif f2_local3 >= 7 then
        f2_local0[29] = 100
        if f2_local6 == 1 and f2_local3 < 10 then
            f2_local0[42] = 500
        end
    elseif f2_local3 >= 5 then
        f2_local0[8] = 100
        f2_local0[16] = 100
        if f2_local6 == 1 then
            f2_local0[42] = 150
        end
    elseif f2_local3 > 3 then
        f2_local0[1] = 200
        f2_local0[4] = 100
        f2_local0[8] = 0
        f2_local0[10] = 0
        f2_local0[15] = 0
        f2_local0[16] = 100
    elseif f2_local3 > 1 then
        f2_local0[1] = 150
        f2_local0[4] = 100
        f2_local0[10] = 100
        f2_local0[15] = 150
        f2_local0[16] = 100
    else
        f2_local0[1] = 150
        f2_local0[4] = 100
        f2_local0[10] = 100
        f2_local0[15] = 150
        f2_local0[16] = 100
    end
    if SpaceCheck(f2_arg1, f2_arg2, 45, 2) == false and SpaceCheck(f2_arg1, f2_arg2, -45, 2) == false then
        f2_local0[22] = 0
    end
    if SpaceCheck(f2_arg1, f2_arg2, 90, 1) == false and SpaceCheck(f2_arg1, f2_arg2, -90, 1) == false then
        f2_local0[23] = 0
    elseif f2_arg1:GetNumber(5) == 1 and f2_local3 > 3 then
        f2_local0[23] = 10000
    end
    if SpaceCheck(f2_arg1, f2_arg2, 180, 2) == false then
        f2_local0[24] = 0
    end
    if SpaceCheck(f2_arg1, f2_arg2, 180, 1) == false then
        f2_local0[25] = 0
    end
    f2_local0[1] = SetCoolTime(f2_arg1, f2_arg2, 3000, 15, f2_local0[1], 1)
    f2_local0[2] = SetCoolTime(f2_arg1, f2_arg2, 3003, 6, f2_local0[2], 1)
    f2_local0[3] = SetCoolTime(f2_arg1, f2_arg2, 3016, 7, f2_local0[3], 1)
    f2_local0[4] = SetCoolTime(f2_arg1, f2_arg2, 3006, 15, f2_local0[4], 1)
    f2_local0[5] = SetCoolTime(f2_arg1, f2_arg2, 3015, 7, f2_local0[5], 1)
    f2_local0[6] = SetCoolTime(f2_arg1, f2_arg2, 3015, 7, f2_local0[6], 1)
    f2_local0[8] = SetCoolTime(f2_arg1, f2_arg2, 3013, 30, f2_local0[8], 0)
    f2_local0[10] = SetCoolTime(f2_arg1, f2_arg2, 3005, 15, f2_local0[10], 1)
    f2_local0[11] = SetCoolTime(f2_arg1, f2_arg2, 3011, 10, f2_local0[11], 1)
    f2_local0[12] = SetCoolTime(f2_arg1, f2_arg2, 3010, 7, f2_local0[12], 1)
    f2_local0[13] = SetCoolTime(f2_arg1, f2_arg2, 3015, 7, f2_local0[13], 1)
    f2_local0[14] = SetCoolTime(f2_arg1, f2_arg2, 3012, 7, f2_local0[14], 1)
    f2_local0[15] = SetCoolTime(f2_arg1, f2_arg2, 3027, 5, f2_local0[15], 1)
    f2_local0[16] = SetCoolTime(f2_arg1, f2_arg2, 3027, 5, f2_local0[16], 1)
    f2_local0[17] = SetCoolTime(f2_arg1, f2_arg2, 3025, 5, f2_local0[17], 1)
    f2_local0[18] = SetCoolTime(f2_arg1, f2_arg2, 3000, 10, f2_local0[18], 1)
    f2_local0[19] = SetCoolTime(f2_arg1, f2_arg2, 3010, 10, f2_local0[19], 1)
    f2_local0[42] = SetCoolTime(f2_arg1, f2_arg2, 3004, 15, f2_local0[42], 1)
    f2_local0[42] = SetCoolTime(f2_arg1, f2_arg2, 3019, 15, f2_local0[42], 1)
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
    f2_local1[11] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act11)
    f2_local1[12] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act12)
    f2_local1[13] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act13)
    f2_local1[14] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act14)
    f2_local1[15] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act15)
    f2_local1[16] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act16)
    f2_local1[17] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act17)
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
    f2_local1[29] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act29)
    f2_local1[30] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act30)
    f2_local1[31] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act31)
    f2_local1[35] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act35)
    f2_local1[36] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act36)
    f2_local1[40] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act40)
    f2_local1[41] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act41)
    f2_local1[42] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act42)
    local f2_local7 = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.ActAfter_AdjustSpace)
    Common_Battle_Activate(f2_arg1, f2_arg2, f2_local0, f2_local1, f2_local7, f2_local2)
    
end

Goal.Act01 = function (f3_arg0, f3_arg1, f3_arg2)
    local f3_local0 = 3 - f3_arg0:GetMapHitRadius(TARGET_SELF)
    local f3_local1 = 5
    local f3_local2 = 5
    local f3_local3 = 0
    local f3_local4 = 0
    local f3_local5 = 1.5
    local f3_local6 = 3
    Approach_Act_Flex(f3_arg0, f3_arg1, f3_local0, f3_local1, f3_local2, f3_local3, f3_local4, f3_local5, f3_local6)
    local f3_local7 = 10
    local f3_local8 = 10
    local f3_local9 = 0
    local f3_local10 = 0
    f3_arg1:AddSubGoal(GOAL_COMMON_ComboAttackTunableSpin, 10, 3000, TARGET_ENE_0, f3_local7, f3_local9, f3_local10, 0, 0)
    f3_arg1:AddSubGoal(GOAL_COMMON_ComboRepeat, 10, 3001, TARGET_ENE_0, f3_local8, 0)
    f3_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3002, TARGET_ENE_0, 9999, 0, 0)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act02 = function (f4_arg0, f4_arg1, f4_arg2)
    local f4_local0 = 2 - f4_arg0:GetMapHitRadius(TARGET_SELF)
    local f4_local1 = 5
    local f4_local2 = 5
    local f4_local3 = 0
    local f4_local4 = 0
    local f4_local5 = 1.5
    local f4_local6 = 3
    Approach_Act_Flex(f4_arg0, f4_arg1, f4_local0, f4_local1, f4_local2, f4_local3, f4_local4, f4_local5, f4_local6)
    local f4_local7 = 0
    local f4_local8 = 0
    local f4_local9 = f4_arg0:GetDist(TARGET_ENE_0)
    local f4_local10 = f4_arg0:GetRandam_Int(1, 100)
    f4_arg1:AddSubGoal(GOAL_COMMON_ComboAttackTunableSpin, 10, 3003, TARGET_ENE_0, 999, f4_local7, f4_local8, 0, 0)
    if f4_local10 > 50 then
        f4_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3005, TARGET_ENE_0, 999, 0, 0)
    else
        f4_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3006, TARGET_ENE_0, 999, 0, 0)
    end
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act03 = function (f5_arg0, f5_arg1, f5_arg2)
    local f5_local0 = 3
    local f5_local1 = 5
    local f5_local2 = 5
    local f5_local3 = 0
    local f5_local4 = 0
    local f5_local5 = 1.5
    local f5_local6 = 3
    Approach_Act_Flex(f5_arg0, f5_arg1, f5_local0, f5_local1, f5_local2, f5_local3, f5_local4, f5_local5, f5_local6)
    local f5_local7 = 0
    local f5_local8 = 0
    local f5_local9 = f5_arg0:GetRandam_Int(1, 100)
    f5_arg1:AddSubGoal(GOAL_COMMON_ComboAttackTunableSpin, 10, 3016, TARGET_ENE_0, 7, f5_local7, f5_local8, 0, 0)
    f5_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 5, 3004, TARGET_ENE_0, 9999, 0, 0)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act04 = function (f6_arg0, f6_arg1, f6_arg2)
    local f6_local0 = 2
    local f6_local1 = 5
    local f6_local2 = 5
    local f6_local3 = 0
    local f6_local4 = 0
    local f6_local5 = 1.5
    local f6_local6 = 3
    Approach_Act_Flex(f6_arg0, f6_arg1, f6_local0, f6_local1, f6_local2, f6_local3, f6_local4, f6_local5, f6_local6)
    local f6_local7 = 0
    local f6_local8 = 0
    local f6_local9 = f6_arg0:GetRandam_Int(1, 100)
    f6_arg1:AddSubGoal(GOAL_COMMON_ComboAttackTunableSpin, 10, 3016, TARGET_ENE_0, 5, f6_local7, f6_local8, 0, 0)
    f6_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3006, TARGET_ENE_0, 9999, 0, 0)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act05 = function (f7_arg0, f7_arg1, f7_arg2)
    local f7_local0 = 3
    local f7_local1 = 5
    local f7_local2 = 5
    local f7_local3 = 0
    local f7_local4 = 0
    local f7_local5 = 1.5
    local f7_local6 = 3
    Approach_Act_Flex(f7_arg0, f7_arg1, f7_local0, f7_local1, f7_local2, f7_local3, f7_local4, f7_local5, f7_local6)
    local f7_local7 = 0
    local f7_local8 = 0
    local f7_local9 = f7_arg0:GetRandam_Int(1, 100)
    f7_arg1:AddSubGoal(GOAL_COMMON_ComboAttackTunableSpin, 10, 3015, TARGET_ENE_0, 5, f7_local7, f7_local8, 0, 0)
    f7_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3016, TARGET_ENE_0, 10, 0, 0)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act06 = function (f8_arg0, f8_arg1, f8_arg2)
    local f8_local0 = 3
    local f8_local1 = 5
    local f8_local2 = 5
    local f8_local3 = 0
    local f8_local4 = 0
    local f8_local5 = 1.5
    local f8_local6 = 3
    Approach_Act_Flex(f8_arg0, f8_arg1, f8_local0, f8_local1, f8_local2, f8_local3, f8_local4, f8_local5, f8_local6)
    local f8_local7 = 0
    local f8_local8 = 0
    local f8_local9 = f8_arg0:GetRandam_Int(1, 100)
    f8_arg1:AddSubGoal(GOAL_COMMON_ComboAttackTunableSpin, 10, 3015, TARGET_ENE_0, 5, f8_local7, f8_local8, 0, 0)
    f8_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3017, TARGET_ENE_0, 9999, 0, 0)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act07 = function (f9_arg0, f9_arg1, f9_arg2)
    f9_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 10, 3008, TARGET_ENE_0, 7, 0, 0, 0, 0)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act08 = function (f10_arg0, f10_arg1, f10_arg2)
    local f10_local0 = 6
    local f10_local1 = 6
    local f10_local2 = 6
    local f10_local3 = 0
    local f10_local4 = 0
    local f10_local5 = 1.5
    local f10_local6 = 3
    Approach_Act_Flex(f10_arg0, f10_arg1, f10_local0, f10_local1, f10_local2, f10_local3, f10_local4, f10_local5, f10_local6)
    f10_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 10, 3013, TARGET_ENE_0, 7, 0, 0, 0, 0)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act09 = function (f11_arg0, f11_arg1, f11_arg2)
    local f11_local0 = 3
    local f11_local1 = 5
    local f11_local2 = 5
    local f11_local3 = 0
    local f11_local4 = 0
    local f11_local5 = 1.5
    local f11_local6 = 3
    Approach_Act_Flex(f11_arg0, f11_arg1, f11_local0, f11_local1, f11_local2, f11_local3, f11_local4, f11_local5, f11_local6)
    f11_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 10, 3010, TARGET_ENE_0, 7, 0, 0, 0, 0)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act10 = function (f12_arg0, f12_arg1, f12_arg2)
    f12_arg1:AddSubGoal(GOAL_COMMON_ComboAttackTunableSpin, 10, 3011, TARGET_ENE_0, 10, 0, 0, 0, 0)
    f12_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3005, TARGET_ENE_0, 10, 0, 0)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act11 = function (f13_arg0, f13_arg1, f13_arg2)
    f13_arg1:AddSubGoal(GOAL_COMMON_ComboAttackTunableSpin, 10, 3011, TARGET_ENE_0, 10, 0, 0, 0, 0)
    f13_arg1:AddSubGoal(GOAL_COMMON_ComboRepeat, 10, 3010, TARGET_ENE_0, 999, 0)
    f13_arg1:AddSubGoal(GOAL_COMMON_ComboRepeat, 10, 3023, TARGET_ENE_0, 999, 0)
    f13_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 5, 3004, TARGET_ENE_0, 10, 0, 0)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act12 = function (f14_arg0, f14_arg1, f14_arg2)
    f14_arg1:AddSubGoal(GOAL_COMMON_ComboAttackTunableSpin, 10, 3010, TARGET_ENE_0, 5, 0, 0, 0, 0)
    f14_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3005, TARGET_ENE_0, 10, 0, 0)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act13 = function (f15_arg0, f15_arg1, f15_arg2)
    f15_arg1:AddSubGoal(GOAL_COMMON_ComboAttackTunableSpin, 10, 3010, TARGET_ENE_0, 10, 0, 0, 0, 0)
    f15_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3011, TARGET_ENE_0, 10, 0, 0)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act14 = function (f16_arg0, f16_arg1, f16_arg2)
    local f16_local0 = 0
    local f16_local1 = 0
    local f16_local2 = f16_arg0:GetRandam_Int(1, 100)
    f16_arg1:AddSubGoal(GOAL_COMMON_ComboAttackTunableSpin, 10, 3012, TARGET_ENE_0, 10, 0, 0, 0, 0)
    f16_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3005, TARGET_ENE_0, 10, 0, 0)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act15 = function (f17_arg0, f17_arg1, f17_arg2)
    f17_arg1:AddSubGoal(GOAL_COMMON_ComboAttackTunableSpin, 10, 5201, TARGET_ENE_0, 999, 0, 0, 0, 0)
    f17_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 1, 3027, TARGET_ENE_0, 9999, 0, 0)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act16 = function (f18_arg0, f18_arg1, f18_arg2)
    local f18_local0 = 6
    local f18_local1 = 6
    local f18_local2 = 6
    local f18_local3 = 0
    local f18_local4 = 0
    local f18_local5 = 1.5
    local f18_local6 = 3
    Approach_Act_Flex(f18_arg0, f18_arg1, f18_local0, f18_local1, f18_local2, f18_local3, f18_local4, f18_local5, f18_local6)
    f18_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 3, 3027, TARGET_ENE_0, 7, 0, 0, 0, 0)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act17 = function (f19_arg0, f19_arg1, f19_arg2)
    f19_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 10, 5202, TARGET_ENE_0, 7, 0, 0, 0, 0)
    f19_arg1:AddSubGoal(GOAL_COMMON_ComboRepeat, 10, 3025, TARGET_ENE_0, 999, 0)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act18 = function (f20_arg0, f20_arg1, f20_arg2)
    f20_arg1:AddSubGoal(GOAL_COMMON_ComboAttackTunableSpin, 10, 3000, TARGET_ENE_0, 10, 0, 0, 0, 0)
    f20_arg1:AddSubGoal(GOAL_COMMON_ComboRepeat, 10, 3003, TARGET_ENE_0, 999, 0)
    f20_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 5, 3004, TARGET_ENE_0, 10, 0, 0)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act19 = function (f21_arg0, f21_arg1, f21_arg2)
    f21_arg1:AddSubGoal(GOAL_COMMON_ComboAttackTunableSpin, 10, 3010, TARGET_ENE_0, 10, 0, 0, 0, 0)
    f21_arg1:AddSubGoal(GOAL_COMMON_ComboRepeat, 10, 5201, TARGET_ENE_0, 999, 0)
    f21_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3024, TARGET_ENE_0, 10, 0, 0)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act20 = function (f22_arg0, f22_arg1, f22_arg2)
    f22_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 10, 3002, TARGET_ENE_0, 7, 0, 0, 0, 0)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act21 = function (f23_arg0, f23_arg1, f23_arg2)
    local f23_local0 = 3
    local f23_local1 = 45
    f23_arg1:AddSubGoal(GOAL_COMMON_Turn, f23_local0, TARGET_ENE_0, f23_local1, -1, GOAL_RESULT_Success, true)
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
    
end

Goal.Act22 = function (f24_arg0, f24_arg1, f24_arg2)
    local f24_local0 = 3
    local f24_local1 = 0
    local f24_local2 = 5202
    if SpaceCheck(f24_arg0, f24_arg1, -45, 2) == true then
        if SpaceCheck(f24_arg0, f24_arg1, 45, 2) == true then
            if f24_arg0:IsInsideTarget(TARGET_ENE_0, AI_DIR_TYPE_R, 180) then
                f24_local2 = 5202
            else
                f24_local2 = 5203
            end
        else
            f24_local2 = 5202
        end
    elseif SpaceCheck(f24_arg0, f24_arg1, 45, 2) == true then
        f24_local2 = 5203
    else
    end
    f24_arg1:AddSubGoal(GOAL_COMMON_SpinStep, f24_local0, f24_local2, TARGET_ENE_0, f24_local1, AI_DIR_TYPE_R, 0)
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
    
end

Goal.Act23 = function (f25_arg0, f25_arg1, f25_arg2)
    f25_arg0:SetNumber(5, 0)
    local f25_local0 = f25_arg0:GetDist(TARGET_ENE_0)
    local f25_local1 = f25_arg0:GetRandam_Int(1, 100)
    local f25_local2 = -1
    local f25_local3 = 0
    if SpaceCheck(f25_arg0, f25_arg1, -90, 1) == true then
        if SpaceCheck(f25_arg0, f25_arg1, 90, 1) == true then
            if f25_arg0:IsInsideTargetEx(TARGET_ENE_0, TARGET_SELF, AI_DIR_TYPE_R, 180, 999) then
                f25_local3 = 1
            else
                f25_local3 = 0
            end
        else
            f25_local3 = 0
        end
    elseif SpaceCheck(f25_arg0, f25_arg1, 90, 1) == true then
        f25_local3 = 1
    else
    end
    local f25_local4 = 4
    local f25_local5 = f25_arg0:GetRandam_Int(90, 120)
    f25_arg0:SetNumber(10, f25_local3)
    f25_arg1:AddSubGoal(GOAL_COMMON_SidewayMove, f25_local4, TARGET_ENE_0, f25_local3, f25_local5, true, true, f25_local2)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act24 = function (f26_arg0, f26_arg1, f26_arg2)
    local f26_local0 = f26_arg0:GetDist(TARGET_ENE_0)
    local f26_local1 = 3
    local f26_local2 = 0
    local f26_local3 = 5201
    if SpaceCheck(f26_arg0, f26_arg1, 180, 2) ~= true or SpaceCheck(f26_arg0, f26_arg1, 180, 4) ~= true or f26_local0 > 4 then
    else
        f26_local3 = 5211
        if false then
        else
        end
    end
    f26_arg1:AddSubGoal(GOAL_COMMON_SpinStep, f26_local1, f26_local3, TARGET_ENE_0, f26_local2, AI_DIR_TYPE_B, 0)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act25 = function (f27_arg0, f27_arg1, f27_arg2)
    local f27_local0 = f27_arg0:GetRandam_Float(2, 4)
    local f27_local1 = f27_arg0:GetRandam_Float(5, 7)
    local f27_local2 = f27_arg0:GetDist(TARGET_ENE_0)
    local f27_local3 = -1
    f27_arg1:AddSubGoal(GOAL_COMMON_LeaveTarget, f27_local0, TARGET_ENE_0, f27_local1, TARGET_ENE_0, true, f27_local3)
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
    
end

Goal.Act26 = function (f28_arg0, f28_arg1, f28_arg2)
    f28_arg1:AddSubGoal(GOAL_COMMON_Wait, 0.5, TARGET_SELF, 0, 0, 0)
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
    
end

Goal.Act27 = function (f29_arg0, f29_arg1, f29_arg2)
    local f29_local0 = f29_arg0:GetDist(TARGET_ENE_0)
    local f29_local1 = f29_arg0:GetDistYSigned(TARGET_ENE_0)
    local f29_local2 = f29_local1 / math.tan(math.deg(30))
    local f29_local3 = f29_arg0:GetRandam_Int(0, 1)
    if f29_local1 >= 3 then
        if f29_local2 + 1 <= f29_local0 then
            if SpaceCheck(f29_arg0, f29_arg1, 0, 4) == true then
                f29_arg1:AddSubGoal(GOAL_COMMON_ApproachTarget, 0.1, TARGET_ENE_0, f29_local2, TARGET_SELF, false, -1)
            elseif SpaceCheck(f29_arg0, f29_arg1, 0, 3) == true then
                f29_arg1:AddSubGoal(GOAL_COMMON_ApproachTarget, 0.5, TARGET_ENE_0, f29_local2, TARGET_SELF, true, -1)
            end
        elseif f29_local0 <= f29_local2 - 1 then
            f29_arg1:AddSubGoal(GOAL_COMMON_LeaveTarget, 10, TARGET_ENE_0, f29_local2, TARGET_ENE_0, true, -1)
        else
            f29_arg1:AddSubGoal(GOAL_COMMON_SidewayMove, 3, TARGET_ENE_0, f29_local3, f29_arg0:GetRandam_Int(30, 45), true, true, -1)
            f29_arg0:SetNumber(10, f29_local3)
        end
    elseif SpaceCheck(f29_arg0, f29_arg1, 0, 4) == true then
        f29_arg1:AddSubGoal(GOAL_COMMON_ApproachTarget, 0.1, TARGET_ENE_0, 0, TARGET_SELF, false, -1)
    elseif SpaceCheck(f29_arg0, f29_arg1, 0, 3) == true then
        f29_arg1:AddSubGoal(GOAL_COMMON_ApproachTarget, 0.5, TARGET_ENE_0, 0, TARGET_SELF, true, -1)
    elseif SpaceCheck(f29_arg0, f29_arg1, 0, 1) == false then
        f29_arg1:AddSubGoal(GOAL_COMMON_LeaveTarget, 0.5, TARGET_ENE_0, 999, TARGET_ENE_0, true, -1)
    else
        f29_arg1:AddSubGoal(GOAL_COMMON_SidewayMove, 3, TARGET_ENE_0, f29_local3, f29_arg0:GetRandam_Int(30, 45), true, true, -1)
        f29_arg0:SetNumber(10, f29_local3)
    end
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
    
end

Goal.Act28 = function (f30_arg0, f30_arg1, f30_arg2)
    local f30_local0 = f30_arg0:GetDist(TARGET_ENE_0)
    local f30_local1 = 1.5
    local f30_local2 = 1.5
    local f30_local3 = f30_arg0:GetRandam_Int(30, 45)
    local f30_local4 = -1
    local f30_local5 = f30_arg0:GetRandam_Int(0, 1)
    if f30_local0 <= 3 then
        f30_arg1:AddSubGoal(GOAL_COMMON_SidewayMove, f30_local1, TARGET_ENE_0, f30_local5, f30_local3, true, true, f30_local4)
    elseif f30_local0 <= 8 then
        f30_arg1:AddSubGoal(GOAL_COMMON_ApproachTarget, f30_local2, TARGET_ENE_0, 3, TARGET_SELF, true, -1)
    else
        f30_arg1:AddSubGoal(GOAL_COMMON_ApproachTarget, f30_local2, TARGET_ENE_0, 8, TARGET_SELF, true, -1)
    end
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
    
end

Goal.Act29 = function (f31_arg0, f31_arg1, f31_arg2)
    local f31_local0 = 2
    f31_arg1:AddSubGoal(GOAL_COMMON_ApproachTarget, f31_local0, TARGET_ENE_0, 3.9, TARGET_SELF, false, -1)
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
    
end

Goal.Act30 = function (f32_arg0, f32_arg1, f32_arg2)
    local f32_local0 = f32_arg0:GetDist(TARGET_ENE_0)
    local f32_local1 = f32_arg0:GetRandam_Int(1, 100)
    local f32_local2 = 9910
    local f32_local3 = 0
    if SpaceCheck(f32_arg0, f32_arg1, -90, 1) == true then
        if SpaceCheck(f32_arg0, f32_arg1, 90, 1) == true then
            if f32_arg0:IsInsideTargetEx(TARGET_ENE_0, TARGET_SELF, AI_DIR_TYPE_R, 180, 999) then
                f32_local3 = 1
            else
                f32_local3 = 0
            end
        else
            f32_local3 = 0
        end
    elseif SpaceCheck(f32_arg0, f32_arg1, 90, 1) == true then
        f32_local3 = 1
    else
    end
    local f32_local4 = 3
    local f32_local5 = f32_arg0:GetRandam_Int(30, 45)
    f32_arg0:SetNumber(10, f32_local3)
    f32_arg1:AddSubGoal(GOAL_COMMON_SidewayMove, f32_local4, TARGET_ENE_0, f32_local3, f32_local5, true, true, f32_local2)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act31 = function (f33_arg0, f33_arg1, f33_arg2)
    local f33_local0 = 3.5
    local f33_local1 = f33_arg0:GetRandam_Int(30, 45)
    local f33_local2 = f33_arg0:GetDist(TARGET_ENE_0)
    local f33_local3 = 0
    if SpaceCheck(f33_arg0, f33_arg1, -90, 1) == true then
        if SpaceCheck(f33_arg0, f33_arg1, 90, 1) == true then
            if f33_arg0:IsInsideTarget(TARGET_ENE_0, AI_DIR_TYPE_R, 180) then
                f33_local3 = 0
            else
                f33_local3 = 1
            end
        else
            f33_local3 = 0
        end
    elseif SpaceCheck(f33_arg0, f33_arg1, 90, 1) == true then
        f33_local3 = 1
    else
    end
    if f33_local2 <= 2 then
        f33_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 10, 5201, TARGET_ENE_0, 9999, 0, 0, 0, 0)
    end
    f33_arg1:AddSubGoal(GOAL_COMMON_SidewayMove, f33_local0, TARGET_ENE_0, f33_local3, f33_local1, true, true, -1)
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
    
end

Goal.Act40 = function (f34_arg0, f34_arg1, f34_arg2)
    local f34_local0 = 7
    local f34_local1 = 5
    local f34_local2 = 5
    local f34_local3 = 0
    local f34_local4 = 0
    local f34_local5 = 1.5
    local f34_local6 = 3
    Approach_Act_Flex(f34_arg0, f34_arg1, f34_local0, f34_local1, f34_local2, f34_local3, f34_local4, f34_local5, f34_local6)
    local f34_local7 = 10
    local f34_local8 = 10
    local f34_local9 = 0
    local f34_local10 = 0
    f34_arg1:AddSubGoal(GOAL_COMMON_ComboAttackTunableSpin, 10, 5202, TARGET_ENE_0, f34_local7, f34_local9, f34_local10, 0, 0)
    f34_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3027, TARGET_ENE_0, 9999, 0, 0)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act41 = function (f35_arg0, f35_arg1, f35_arg2)
    local f35_local0 = 7
    local f35_local1 = 5
    local f35_local2 = 5
    local f35_local3 = 0
    local f35_local4 = 0
    local f35_local5 = 1.5
    local f35_local6 = 3
    Approach_Act_Flex(f35_arg0, f35_arg1, f35_local0, f35_local1, f35_local2, f35_local3, f35_local4, f35_local5, f35_local6)
    local f35_local7 = 10
    local f35_local8 = 10
    local f35_local9 = 0
    local f35_local10 = 0
    f35_arg1:AddSubGoal(GOAL_COMMON_ComboAttackTunableSpin, 10, 5203, TARGET_ENE_0, f35_local7, f35_local9, f35_local10, 0, 0)
    f35_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3027, TARGET_ENE_0, 9999, 0, 0)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act42 = function (f36_arg0, f36_arg1, f36_arg2)
    f36_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 5, 3004, TARGET_ENE_0, 7, 0, 0, 0, 0)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Interrupt = function (f37_arg0, f37_arg1, f37_arg2)
    local f37_local0 = f37_arg1:GetSpecialEffectActivateInterruptType(0)
    local f37_local1 = f37_arg1:GetDist(TARGET_ENE_0)
    if f37_arg1:IsLadderAct(TARGET_SELF) then
        return false
    end
    if not f37_arg1:HasSpecialEffectId(TARGET_SELF, 200004) then
        return false
    end
    if f37_arg1:IsInterupt(INTERUPT_ActivateSpecialEffect) and f37_local0 == 5028 then
        f37_arg2:ClearSubGoal()
        f37_arg2:AddSubGoal(GOAL_COMMON_ComboFinal, 5, 3026, TARGET_ENE_0, 999, 0, 0, 0, 0)
        return true
    end
    if f37_arg1:IsInterupt(INTERUPT_ParryTiming) then
        return f37_arg0.Parry(f37_arg1, f37_arg2, 50, 0)
    end
    if f37_arg1:IsInterupt(INTERUPT_ShootImpact) then
        return f37_arg0.ShootReaction(f37_arg1, f37_arg2)
    end
    if f37_arg1:IsInterupt(INTERUPT_Damaged) then
        return f37_arg0.Damaged(f37_arg1, f37_arg2)
    end
    if Interupt_PC_Break(f37_arg1) then
        f37_arg1:Replanning()
        return true
    end
    if Interupt_Use_Item(f37_arg1, 4, 10) and f37_arg1:IsInsideTarget(TARGET_ENE_0, AI_DIR_TYPE_F, 180) then
        if f37_local1 < 8 then
            f37_arg2:ClearSubGoal()
            f37_arg2:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 1, 3027, TARGET_ENE_0, 9999, 0)
            return true
        elseif f37_local1 < 11 then
            f37_arg2:ClearSubGoal()
            f37_arg2:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 1, 3013, TARGET_ENE_0, 9999, 0)
            return true
        else
            f37_arg1:Replanning()
            return true
        end
    end
    if f37_arg1:IsInterupt(INTERUPT_ActivateSpecialEffect) then
        if f37_local0 == 5029 then
            if f37_local1 < 6.5 then
                f37_arg1:AddObserveArea(1, TARGET_SELF, TARGET_ENE_0, AI_DIR_TYPE_F, 360, 7)
                return true
            else
                f37_arg2:ClearSubGoal()
                f37_arg2:AddSubGoal(GOAL_COMMON_EndureAttack, 5, 3018, TARGET_ENE_0, 9999, 0)
                f37_arg2:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 5, 3019, TARGET_ENE_0, 7, 0, 0, 0, 0)
                return true
            end
        end
        if f37_local0 == 5025 then
            f37_arg2:ClearSubGoal()
            f37_arg2:AddSubGoal(GOAL_COMMON_ComboFinal, 5, 3020, TARGET_ENE_0, 9999, 0, 0)
            return true
        elseif f37_local0 == 5027 then
            f37_arg2:ClearSubGoal()
            f37_arg2:AddSubGoal(GOAL_COMMON_ComboFinal, 2, 3010, TARGET_ENE_0, 999, 0, 0, 0, 0)
            return true
        elseif f37_local0 == 110111 then
            f37_arg1:AddObserveArea(0, TARGET_SELF, TARGET_ENE_0, AI_DIR_TYPE_F, 120, 4)
            return true
        elseif f37_local0 == 109031 or f37_local0 == 110125 then
            f37_arg2:ClearSubGoal()
            f37_arg1:Replanning()
            return true
        end
    end
    if f37_arg1:IsInterupt(INTERUPT_Outside_ObserveArea) then
        if f37_arg1:HasSpecialEffectId(TARGET_SELF, 5029) then
            f37_arg1:DeleteObserve(1)
            f37_arg2:ClearSubGoal()
            f37_arg2:AddSubGoal(GOAL_COMMON_EndureAttack, 5, 3018, TARGET_ENE_0, 9999, 0)
            f37_arg2:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 5, 3019, TARGET_ENE_0, 7, 0, 0, 0, 0)
            return true
        else
            f37_arg1:DeleteObserve(1)
            return false
        end
    end
    if f37_arg1:IsInterupt(INTERUPT_Inside_ObserveArea) and f37_arg1:IsInsideObserve(0) then
        f37_arg1:DeleteObserve(0)
        f37_arg2:ClearSubGoal()
        f37_arg2:AddSubGoal(GOAL_COMMON_EndureAttack, 1, 3008, TARGET_ENE_0, 9999, 0)
        return true
    end
    return false
    
end

Goal.Parry = function (f38_arg0, f38_arg1, f38_arg2, f38_arg3)
    local f38_local0 = f38_arg0:GetDist(TARGET_ENE_0)
    local f38_local1 = GetDist_Parry(f38_arg0)
    local f38_local2 = f38_arg0:GetRandam_Int(1, 100)
    local f38_local3 = f38_arg0:GetRandam_Int(1, 100)
    local f38_local4 = f38_arg0:GetRandam_Int(1, 100)
    local f38_local5 = f38_arg0:HasSpecialEffectId(TARGET_ENE_0, 109970)
    local f38_local6 = f38_arg0:HasSpecialEffectId(TARGET_ENE_0, COMMON_SP_EFFECT_PC_ATTACK_RUSH)
    local f38_local7 = 2
    if f38_arg0:HasSpecialEffectId(TARGET_SELF, 221000) then
        f38_local7 = 0
    elseif f38_arg0:HasSpecialEffectId(TARGET_SELF, 221001) then
        f38_local7 = 1
    end
    if f38_arg0:IsFinishTimer(AI_TIMER_PARRY_INTERVAL) == false then
        return false
    end
    if f38_arg0:HasSpecialEffectId(TARGET_ENE_0, 110450) or f38_arg0:HasSpecialEffectId(TARGET_ENE_0, 110501) or f38_arg0:HasSpecialEffectId(TARGET_ENE_0, 110500) then
        return false
    end
    f38_arg0:SetTimer(AI_TIMER_PARRY_INTERVAL, 0.1)
    if f38_arg2 == nil then
        f38_arg2 = 50
    end
    if f38_arg3 == nil then
        f38_arg3 = 0
    end
    if f38_arg0:IsInsideTarget(TARGET_ENE_0, AI_DIR_TYPE_F, 90) and f38_arg0:IsInsideTargetEx(TARGET_ENE_0, TARGET_SELF, AI_DIR_TYPE_F, 180, f38_local1) then
        if f38_local6 then
            f38_arg1:ClearSubGoal()
            f38_arg1:AddSubGoal(GOAL_COMMON_EndureAttack, 0.3, 3100, TARGET_ENE_0, 9999, 0)
            return true
        elseif f38_local5 then
            if f38_arg0:IsTargetGuard(TARGET_SELF) and ReturnKengekiSpecialEffect(f38_arg0) == false then
                return false
            elseif f38_arg0:HasSpecialEffectId(TARGET_SELF, 5026) then
                f38_arg1:ClearSubGoal()
                f38_arg1:AddSubGoal(GOAL_COMMON_EndureAttack, 0.3, 3101, TARGET_ENE_0, 9999, 0)
                return true
            elseif f38_local7 == 2 then
                return false
            elseif f38_local7 == 1 then
                if f38_local2 <= 50 then
                    f38_arg1:ClearSubGoal()
                    f38_arg1:AddSubGoal(GOAL_COMMON_SpinStep, 1, 5211, TARGET_ENE_0, 0, AI_DIR_TYPE_B, 0)
                    return true
                end
            elseif f38_local7 == 0 and f38_local2 <= 100 then
                f38_arg1:ClearSubGoal()
                f38_arg1:AddSubGoal(GOAL_COMMON_EndureAttack, 0.3, 3102, TARGET_ENE_0, 9999, 0)
                return true
            end
        elseif f38_arg0:HasSpecialEffectId(TARGET_SELF, 5026) then
            f38_arg1:ClearSubGoal()
            f38_arg1:AddSubGoal(GOAL_COMMON_EndureAttack, 0.3, 3101, TARGET_ENE_0, 9999, 0)
            return true
        elseif f38_arg0:HasSpecialEffectId(TARGET_ENE_0, 109980) then
            f38_arg1:ClearSubGoal()
            f38_arg1:AddSubGoal(GOAL_COMMON_SpinStep, 1, 5201, TARGET_ENE_0, 0, AI_DIR_TYPE_B, 0)
            return true
        elseif f38_local3 <= Get_ConsecutiveGuardCount(f38_arg0) * f38_arg2 then
            f38_arg1:ClearSubGoal()
            f38_arg1:AddSubGoal(GOAL_COMMON_EndureAttack, 0.3, 3102, TARGET_ENE_0, 9999, 0)
            return true
        else
            f38_arg1:ClearSubGoal()
            f38_arg1:AddSubGoal(GOAL_COMMON_EndureAttack, 0.3, 3100, TARGET_ENE_0, 9999, 0)
            return true
        end
    elseif f38_arg0:IsInsideTargetEx(TARGET_ENE_0, TARGET_SELF, AI_DIR_TYPE_F, 90, f38_local1 + 1) then
        if f38_local4 <= f38_arg3 then
            f38_arg1:ClearSubGoal()
            f38_arg1:AddSubGoal(GOAL_COMMON_SpinStep, 1, 5201, TARGET_ENE_0, 0, AI_DIR_TYPE_B, 0)
            return true
        else
            return false
        end
    else
        return false
    end
    
end

Goal.Damaged = function (f39_arg0, f39_arg1, f39_arg2)
    local f39_local0 = f39_arg0:GetRandam_Int(1, 100)
    local f39_local1 = 3
    if f39_local0 <= 70 then
        if SpaceCheck(f39_arg0, f39_arg1, 90, 2) then
            f39_arg1:ClearSubGoal()
            f39_arg1:AddSubGoal(GOAL_COMMON_SpinStep, f39_local1, 5203, TARGET_ENE_0, 0, AI_DIR_TYPE_R, 0)
            return true
        elseif SpaceCheck(f39_arg0, f39_arg1, -90, 2) then
            f39_arg1:ClearSubGoal()
            f39_arg1:AddSubGoal(GOAL_COMMON_SpinStep, f39_local1, 5202, TARGET_ENE_0, 0, AI_DIR_TYPE_L, 0)
            return true
        end
    else
        return false
    end
    return false
    
end

Goal.ShootReaction = function (f40_arg0, f40_arg1)
    local f40_local0 = f40_arg0:GetDist(TARGET_ENE_0)
    if f40_arg0:IsInsideTargetEx(TARGET_ENE_0, TARGET_SELF, AI_DIR_TYPE_F, 20, 999) then
        if f40_local0 <= 30 then
            f40_arg1:ClearSubGoal()
            f40_arg1:AddSubGoal(GOAL_COMMON_EndureAttack, 0.1, 3100, TARGET_ENE_0, 9999, 0)
            return true
        else
            f40_arg1:ClearSubGoal()
            f40_arg1:AddSubGoal(GOAL_COMMON_Wait, 0.3, TARGET_SELF, 0, 0, 0)
            f40_arg1:AddSubGoal(GOAL_COMMON_EndureAttack, 0.1, 3100, TARGET_ENE_0, 9999, 0)
            return true
        end
    end
    return false
    
end

Goal.Kengeki_Activate = function (f41_arg0, f41_arg1, f41_arg2, f41_arg3)
    local f41_local0 = ReturnKengekiSpecialEffect(f41_arg1)
    if f41_local0 == 0 then
        return false
    end
    local f41_local1 = {}
    local f41_local2 = {}
    local f41_local3 = {}
    Common_Clear_Param(f41_local1, f41_local2, f41_local3)
    local f41_local4 = f41_arg1:GetDist(TARGET_ENE_0)
    local f41_local5 = f41_arg1:GetSp(TARGET_SELF)
    if f41_local0 == 200200 or f41_local0 == 200205 then
        f41_arg1:SetNumber(0, f41_arg1:GetNumber(0) + 1)
        if f41_arg1:GetNumber(0) >= 5 then
            f41_local1[3] = 100
            f41_arg1:SetNumber(0, 0)
        elseif f41_local4 >= 4 then
            f41_local1[50] = 100
        else
            f41_local1[12] = 200
            f41_local1[40] = 100
            f41_local1[9] = 100
            f41_local1[21] = 100
            f41_local1[42] = 200
        end
    elseif f41_local0 == 200201 or f41_local0 == 200206 then
        f41_arg1:SetNumber(0, f41_arg1:GetNumber(0) + 1)
        if f41_arg1:GetNumber(0) >= 5 then
            f41_local1[3] = 100
            f41_arg1:SetNumber(0, 0)
        elseif f41_local4 >= 4 then
            f41_local1[50] = 100
        else
            f41_local1[4] = 100
            f41_local1[12] = 200
            f41_local1[21] = 150
            f41_local1[41] = 100
            f41_local1[9] = 100
        end
    elseif f41_local0 == 200210 then
        f41_arg1:SetNumber(0, f41_arg1:GetNumber(0) + 1)
        if f41_arg1:GetNumber(0) >= 5 then
            f41_local1[3] = 100
            f41_arg1:SetNumber(0, 0)
        elseif f41_local4 >= 4 then
        else
            f41_arg1:SetNumber(0, f41_arg1:GetNumber(0) + 1)
            f41_local1[7] = 150
            f41_local1[12] = 200
            f41_local1[40] = 150
            f41_local1[9] = 150
            f41_local1[21] = 150
        end
    elseif f41_local0 == 200211 then
        f41_arg1:SetNumber(0, f41_arg1:GetNumber(0) + 1)
        if f41_arg1:GetNumber(0) >= 5 then
            f41_local1[3] = 100
            f41_arg1:SetNumber(0, 0)
        elseif f41_local4 >= 4 then
        else
            f41_arg1:SetNumber(0, f41_arg1:GetNumber(0) + 1)
            f41_local1[2] = 150
            f41_local1[4] = 100
            f41_local1[12] = 200
            f41_local1[42] = 200
            f41_local1[9] = 150
        end
    elseif f41_local0 == 200215 then
        if f41_local4 >= 4 then
            f41_local1[50] = 100
        else
            f41_local1[6] = 100
            f41_local1[12] = 100
            f41_local1[42] = 200
        end
    elseif f41_local0 == 200216 then
        if f41_local4 >= 4 then
            f41_local1[50] = 100
        else
            f41_local1[5] = 100
            f41_local1[7] = 100
        end
    end
    f41_local1[2] = SetCoolTime(f41_arg1, f41_arg2, 3067, 8, f41_local1[2], 1)
    f41_local1[4] = SetCoolTime(f41_arg1, f41_arg2, 3066, 15, f41_local1[4], 1)
    f41_local1[7] = SetCoolTime(f41_arg1, f41_arg2, 3070, 8, f41_local1[7], 1)
    f41_local1[9] = SetCoolTime(f41_arg1, f41_arg2, 5201, 15, f41_local1[9], 1)
    f41_local1[12] = SetCoolTime(f41_arg1, f41_arg2, 3027, 15, f41_local1[12], 1)
    f41_local1[21] = SetCoolTime(f41_arg1, f41_arg2, 3025, 20, f41_local1[21], 1)
    f41_local1[40] = SetCoolTime(f41_arg1, f41_arg2, 3005, 15, f41_local1[40], 1)
    f41_local1[41] = SetCoolTime(f41_arg1, f41_arg2, 3024, 15, f41_local1[41], 1)
    f41_local1[42] = SetCoolTime(f41_arg1, f41_arg2, 3003, 15, f41_local1[42], 1)
    f41_local2[1] = REGIST_FUNC(f41_arg1, f41_arg2, f41_arg0.Kengeki01)
    f41_local2[2] = REGIST_FUNC(f41_arg1, f41_arg2, f41_arg0.Kengeki02)
    f41_local2[3] = REGIST_FUNC(f41_arg1, f41_arg2, f41_arg0.Kengeki03)
    f41_local2[4] = REGIST_FUNC(f41_arg1, f41_arg2, f41_arg0.Kengeki04)
    f41_local2[5] = REGIST_FUNC(f41_arg1, f41_arg2, f41_arg0.Kengeki05)
    f41_local2[6] = REGIST_FUNC(f41_arg1, f41_arg2, f41_arg0.Kengeki06)
    f41_local2[7] = REGIST_FUNC(f41_arg1, f41_arg2, f41_arg0.Kengeki07)
    f41_local2[8] = REGIST_FUNC(f41_arg1, f41_arg2, f41_arg0.Kengeki08)
    f41_local2[9] = REGIST_FUNC(f41_arg1, f41_arg2, f41_arg0.Kengeki09)
    f41_local2[10] = REGIST_FUNC(f41_arg1, f41_arg2, f41_arg0.Kengeki10)
    f41_local2[11] = REGIST_FUNC(f41_arg1, f41_arg2, f41_arg0.Kengeki11)
    f41_local2[12] = REGIST_FUNC(f41_arg1, f41_arg2, f41_arg0.Kengeki12)
    f41_local2[13] = REGIST_FUNC(f41_arg1, f41_arg2, f41_arg0.Kengeki13)
    f41_local2[14] = REGIST_FUNC(f41_arg1, f41_arg2, f41_arg0.Kengeki14)
    f41_local2[20] = REGIST_FUNC(f41_arg1, f41_arg2, f41_arg0.Kengeki20)
    f41_local2[21] = REGIST_FUNC(f41_arg1, f41_arg2, f41_arg0.Kengeki21)
    f41_local2[22] = REGIST_FUNC(f41_arg1, f41_arg2, f41_arg0.Kengeki22)
    f41_local2[23] = REGIST_FUNC(f41_arg1, f41_arg2, f41_arg0.Kengeki23)
    f41_local2[30] = REGIST_FUNC(f41_arg1, f41_arg2, f41_arg0.Kengeki30)
    f41_local2[31] = REGIST_FUNC(f41_arg1, f41_arg2, f41_arg0.Kengeki31)
    f41_local2[32] = REGIST_FUNC(f41_arg1, f41_arg2, f41_arg0.Kengeki32)
    f41_local2[33] = REGIST_FUNC(f41_arg1, f41_arg2, f41_arg0.Kengeki33)
    f41_local2[40] = REGIST_FUNC(f41_arg1, f41_arg2, f41_arg0.Kengeki40)
    f41_local2[41] = REGIST_FUNC(f41_arg1, f41_arg2, f41_arg0.Kengeki41)
    f41_local2[42] = REGIST_FUNC(f41_arg1, f41_arg2, f41_arg0.Kengeki42)
    f41_local2[50] = REGIST_FUNC(f41_arg1, f41_arg2, f41_arg0.NoAction)
    local f41_local6 = REGIST_FUNC(f41_arg1, f41_arg2, f41_arg0.ActAfter_AdjustSpace)
    return Common_Kengeki_Activate(f41_arg1, f41_arg2, f41_local1, f41_local2, f41_local6, f41_local3)
    
end

Goal.Kengeki01 = function (f42_arg0, f42_arg1, f42_arg2)
    f42_arg1:ClearSubGoal()
    f42_arg1:AddSubGoal(GOAL_COMMON_ComboRepeat, 10, 3062, TARGET_ENE_0, 9999, 0)
    f42_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3002, TARGET_ENE_0, 9999, 0, 0)
    
end

Goal.Kengeki02 = function (f43_arg0, f43_arg1, f43_arg2)
    f43_arg1:ClearSubGoal()
    f43_arg1:AddSubGoal(GOAL_COMMON_ComboRepeat, 10, 3067, TARGET_ENE_0, 9999, 0)
    f43_arg1:AddSubGoal(GOAL_COMMON_ComboRepeat, 10, 3001, TARGET_ENE_0, 9999, 0)
    f43_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3002, TARGET_ENE_0, 9999, 0, 0)
    
end

Goal.Kengeki03 = function (f44_arg0, f44_arg1, f44_arg2)
    f44_arg1:ClearSubGoal()
    f44_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 1, 3061, TARGET_ENE_0, 9999, 0, 0)
    
end

Goal.Kengeki04 = function (f45_arg0, f45_arg1, f45_arg2)
    f45_arg1:ClearSubGoal()
    f45_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 1, 3066, TARGET_ENE_0, 9999, 0, 0)
    
end

Goal.Kengeki05 = function (f46_arg0, f46_arg1, f46_arg2)
    f46_arg1:ClearSubGoal()
    f46_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3001, TARGET_ENE_0, 9999, 0, 0)
    
end

Goal.Kengeki06 = function (f47_arg0, f47_arg1, f47_arg2)
    f47_arg1:ClearSubGoal()
    f47_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3002, TARGET_ENE_0, 9999, 0, 0)
    
end

Goal.Kengeki07 = function (f48_arg0, f48_arg1, f48_arg2)
    f48_arg1:ClearSubGoal()
    f48_arg1:AddSubGoal(GOAL_COMMON_ComboRepeat, 10, 3070, TARGET_ENE_0, 9999, 0, 0)
    f48_arg1:AddSubGoal(GOAL_COMMON_ComboRepeat, 10, 3023, TARGET_ENE_0, 9999, 0, 0)
    f48_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3020, TARGET_ENE_0, 9999, 0, 0)
    
end

Goal.Kengeki08 = function (f49_arg0, f49_arg1, f49_arg2)
    f49_arg1:ClearSubGoal()
    f49_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 1, 3075, TARGET_ENE_0, 9999, 0, 0)
    
end

Goal.Kengeki09 = function (f50_arg0, f50_arg1, f50_arg2)
    f50_arg1:ClearSubGoal()
    f50_arg1:AddSubGoal(GOAL_COMMON_ComboRepeat, 1, 5201, TARGET_ENE_0, 9999, 0, 0)
    if f50_arg0:GetSpRate(TARGET_SELF) < 0.5 and f50_arg0:GetDist(TARGET_ENE_0) > 4 and f50_arg0:GetTimer(1) <= 0 then
        f50_arg0:SetTimer(1, 30)
        f50_arg1:AddSubGoal(GOAL_COMMON_ComboRepeat, 1, 3040, TARGET_ENE_0, 9999, 0, 0)
    else
        f50_arg0:SetNumber(5, 1)
    end
    
end

Goal.Kengeki10 = function (f51_arg0, f51_arg1, f51_arg2)
    f51_arg1:ClearSubGoal()
    f51_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 1, 3068, TARGET_ENE_0, 9999, 0, 0)
    
end

Goal.Kengeki11 = function (f52_arg0, f52_arg1, f52_arg2)
    f52_arg1:ClearSubGoal()
    f52_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 1, 3060, TARGET_ENE_0, 9999, 0, 0)
    
end

Goal.Kengeki12 = function (f53_arg0, f53_arg1, f53_arg2)
    f53_arg1:ClearSubGoal()
    f53_arg1:AddSubGoal(GOAL_COMMON_ComboRepeat, 1, 5201, TARGET_ENE_0, 9999, 0)
    f53_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 1, 3027, TARGET_ENE_0, 9999, 0, 0)
    
end

Goal.Kengeki13 = function (f54_arg0, f54_arg1, f54_arg2)
    f54_arg1:ClearSubGoal()
    f54_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 1, 3013, TARGET_ENE_0, 9999, 0, 0)
    
end

Goal.Kengeki14 = function (f55_arg0, f55_arg1, f55_arg2)
    f55_arg1:ClearSubGoal()
    f55_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 1, 3080, TARGET_ENE_0, 9999, 0, 0)
    
end

Goal.Kengeki20 = function (f56_arg0, f56_arg1, f56_arg2)
    f56_arg1:ClearSubGoal()
    f56_arg1:AddSubGoal(GOAL_COMMON_ComboRepeat, 5, 5202, TARGET_ENE_0, 9999, 0)
    f56_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 5, 3010, TARGET_ENE_0, 9999, 0, 0)
    
end

Goal.Kengeki21 = function (f57_arg0, f57_arg1, f57_arg2)
    f57_arg1:ClearSubGoal()
    f57_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 5, 3025, TARGET_ENE_0, 9999, 0, 0)
    
end

Goal.Kengeki22 = function (f58_arg0, f58_arg1, f58_arg2)
    f58_arg1:ClearSubGoal()
    f58_arg1:AddSubGoal(GOAL_COMMON_ComboRepeat, 5, 5202, TARGET_ENE_0, 9999, 0)
    f58_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 5, 3012, TARGET_ENE_0, 9999, 0, 0)
    
end

Goal.Kengeki23 = function (f59_arg0, f59_arg1, f59_arg2)
    f59_arg1:ClearSubGoal()
    f59_arg1:AddSubGoal(GOAL_COMMON_ComboRepeat, 5, 5202, TARGET_ENE_0, 9999, 0)
    f59_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 5, 3027, TARGET_ENE_0, 9999, 0, 0)
    
end

Goal.Kengeki30 = function (f60_arg0, f60_arg1, f60_arg2)
    f60_arg1:ClearSubGoal()
    f60_arg1:AddSubGoal(GOAL_COMMON_ComboRepeat, 5, 5203, TARGET_ENE_0, 9999, 0)
    f60_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 5, 3010, TARGET_ENE_0, 9999, 0, 0)
    
end

Goal.Kengeki31 = function (f61_arg0, f61_arg1, f61_arg2)
    f61_arg1:ClearSubGoal()
    f61_arg1:AddSubGoal(GOAL_COMMON_ComboRepeat, 5, 5203, TARGET_ENE_0, 9999, 0)
    f61_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 5, 3011, TARGET_ENE_0, 9999, 0, 0)
    
end

Goal.Kengeki32 = function (f62_arg0, f62_arg1, f62_arg2)
    f62_arg1:ClearSubGoal()
    f62_arg1:AddSubGoal(GOAL_COMMON_ComboRepeat, 5, 5203, TARGET_ENE_0, 9999, 0)
    f62_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 5, 3012, TARGET_ENE_0, 9999, 0, 0)
    
end

Goal.Kengeki33 = function (f63_arg0, f63_arg1, f63_arg2)
    f63_arg0:DeleteObserveSpecialEffectAttribute(TARGET_SELF, 5027)
    f63_arg1:ClearSubGoal()
    f63_arg1:AddSubGoal(GOAL_COMMON_ComboRepeat, 5, 5203, TARGET_ENE_0, 9999, 0)
    f63_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 5, 3027, TARGET_ENE_0, 9999, 0, 0)
    
end

Goal.Kengeki40 = function (f64_arg0, f64_arg1, f64_arg2)
    f64_arg0:DeleteObserveSpecialEffectAttribute(TARGET_SELF, 5027)
    f64_arg1:ClearSubGoal()
    f64_arg1:AddSubGoal(GOAL_COMMON_ComboRepeat, 10, 3021, TARGET_ENE_0, 9999, 0)
    f64_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3005, TARGET_ENE_0, 9999, 0, 0)
    
end

Goal.Kengeki41 = function (f65_arg0, f65_arg1, f65_arg2)
    f65_arg1:ClearSubGoal()
    f65_arg1:AddSubGoal(GOAL_COMMON_ComboRepeat, 10, 3022, TARGET_ENE_0, 9999, 0)
    f65_arg1:AddSubGoal(GOAL_COMMON_ComboRepeat, 10, 3003, TARGET_ENE_0, 999, 0)
    f65_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3024, TARGET_ENE_0, 10, 0, 0)
    
end

Goal.Kengeki42 = function (f66_arg0, f66_arg1, f66_arg2)
    f66_arg1:ClearSubGoal()
    f66_arg1:AddSubGoal(GOAL_COMMON_ComboRepeat, 10, 3003, TARGET_ENE_0, 999, 0)
    f66_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3024, TARGET_ENE_0, 10, 0, 0)
    
end

Goal.NoAction = function (f67_arg0, f67_arg1, f67_arg2)
    return -1
    
end

Goal.ActAfter_AdjustSpace = function (f68_arg0, f68_arg1, f68_arg2)
    
end

Goal.Update = function (f69_arg0, f69_arg1, f69_arg2)
    return Update_Default_NoSubGoal(f69_arg0, f69_arg1, f69_arg2)
    
end

Goal.Terminate = function (f70_arg0, f70_arg1, f70_arg2)
    
end


