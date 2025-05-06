RegisterTableGoal(GOAL_Yasyazaru510001_Battle, "GOAL_Yasyazaru510001_Battle")
REGISTER_GOAL_NO_UPDATE(GOAL_Yasyazaru510001_Battle, true)

Goal.Initialize = function (f1_arg0, f1_arg1, f1_arg2, f1_arg3)
    
end

Goal.Activate = function (f2_arg0, f2_arg1, f2_arg2)
    Init_Pseudo_Global(f2_arg1, f2_arg2)
    f2_arg1:SetStringIndexedNumber("Dist_SideStep", 0)
    f2_arg1:SetStringIndexedNumber("Dist_BackStep", 0)
    local f2_local0 = {}
    local f2_local1 = {}
    local f2_local2 = {}
    Common_Clear_Param(f2_local0, f2_local1, f2_local2)
    local f2_local3 = f2_arg1:GetHpRate(TARGET_SELF)
    local f2_local4 = f2_arg1:GetSpRate(TARGET_SELF)
    local f2_local5 = f2_arg1:GetDist(TARGET_ENE_0)
    local f2_local6 = f2_arg1:GetRandam_Int(1, 100)
    local f2_local7 = f2_arg1:GetExcelParam(AI_EXCEL_THINK_PARAM_TYPE__thinkAttr_doAdmirer)
    local f2_local8 = f2_arg1:GetEventRequest()
    local f2_local9 = f2_arg1:GetEventRequest(1)
    local f2_local10 = f2_arg1:GetDistY(TARGET_SELF)
    local f2_local11 = f2_arg1:GetDistY(TARGET_ENE_0)
    local f2_local12 = f2_arg1:HasSpecialEffectId(TARGET_SELF, 200050)
    local f2_local13 = f2_arg1:GetDist(TARGET_EVENT)
    f2_arg1:SetNumber(11, 0)
    f2_arg1:AddObserveSpecialEffectAttribute(TARGET_SELF, 5025)
    f2_arg1:AddObserveSpecialEffectAttribute(TARGET_SELF, 5026)
    f2_arg1:AddObserveSpecialEffectAttribute(TARGET_SELF, 5027)
    f2_arg1:AddObserveSpecialEffectAttribute(TARGET_EVENT, 5034)
    f2_arg1:AddObserveSpecialEffectAttribute(TARGET_SELF, 5039)
    f2_arg1:AddObserveSpecialEffectAttribute(TARGET_SELF, 3510020)
    f2_arg1:AddObserveSpecialEffectAttribute(TARGET_EVENT, 3510900)
    f2_arg1:AddObserveSpecialEffectAttribute(TARGET_EVENT, 3510901)
    f2_arg1:AddObserveSpecialEffectAttribute(TARGET_EVENT, 3510902)
    f2_arg1:AddObserveSpecialEffectAttribute(TARGET_EVENT, 3510903)
    f2_arg1:AddObserveSpecialEffectAttribute(TARGET_EVENT, 3510904)
    f2_arg1:AddObserveSpecialEffectAttribute(TARGET_EVENT, 3510905)
    f2_arg1:AddObserveSpecialEffectAttribute(TARGET_ENE_0, 110010)
    f2_arg1:AddObserveSpecialEffectAttribute(TARGET_ENE_0, 110030)
    f2_arg1:DeleteObserve(2)
    f2_arg1:DeleteObserve(3)
    if f2_arg0.Kengeki_Activate(f2_arg0, f2_arg1, f2_arg2) then
        return
    end
    if f2_local8 == 10 then
        f2_local0[20] = 100
    elseif f2_arg1:HasSpecialEffectId(TARGET_EVENT, 5033) then
        f2_local0[39] = 100
    elseif f2_arg1:HasSpecialEffectId(TARGET_ENE_0, 110060) or f2_arg1:HasSpecialEffectId(TARGET_ENE_0, 110010) then
        if f2_arg1:IsInsideTarget(TARGET_ENE_0, AI_DIR_TYPE_F, 90) then
            f2_local0[27] = 100
        else
            f2_local0[41] = 100
        end
    elseif Common_ActivateAct(f2_arg1, f2_arg2) then
    elseif f2_arg1:IsInsideTarget(TARGET_ENE_0, AI_DIR_TYPE_B, 90) then
        if f2_local5 >= 7 then
            f2_local0[42] = 100
        else
            f2_local0[42] = 100
        end
    elseif f2_arg1:GetNumber(7) == 1 then
        f2_local0[2] = 1000000
    elseif f2_local13 >= 10 then
        f2_local0[21] = 100
    elseif f2_local5 >= 3 then
        f2_local0[43] = 100
    else
        f2_local0[11] = 500
        f2_local0[44] = 100
    end
    f2_local0[1] = SetCoolTime(f2_arg1, f2_arg2, 3000, 15, f2_local0[1], 1)
    f2_local0[2] = SetCoolTime(f2_arg1, f2_arg2, 3003, 15, f2_local0[2], 1)
    f2_local0[3] = SetCoolTime(f2_arg1, f2_arg2, 3008, 15, f2_local0[3], 1)
    f2_local0[5] = SetCoolTime(f2_arg1, f2_arg2, 3009, 20, f2_local0[5], 1)
    f2_local0[6] = SetCoolTime(f2_arg1, f2_arg2, 3012, 5, f2_local0[6], 1)
    f2_local0[7] = SetCoolTime(f2_arg1, f2_arg2, 3020, 10, f2_local0[7], 1)
    f2_local0[9] = SetCoolTime(f2_arg1, f2_arg2, 3021, 10, f2_local0[9], 1)
    f2_local0[13] = SetCoolTime(f2_arg1, f2_arg2, 3015, 15, f2_local0[13], 1)
    f2_local0[14] = SetCoolTime(f2_arg1, f2_arg2, 3016, 10, f2_local0[14], 1)
    f2_local0[15] = SetCoolTime(f2_arg1, f2_arg2, 3028, 8, f2_local0[15], 1)
    f2_local0[18] = SetCoolTime(f2_arg1, f2_arg2, 3018, 5, f2_local0[18], 1)
    f2_local0[19] = SetCoolTime(f2_arg1, f2_arg2, 3029, 5, f2_local0[19], 1)
    f2_local0[29] = SetCoolTime(f2_arg1, f2_arg2, 3017, 15, f2_local0[29], 1)
    f2_local0[46] = SetCoolTime(f2_arg1, f2_arg2, 3005, 10, f2_local0[46], 1)
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
    f2_local1[27] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act27)
    f2_local1[29] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act29)
    f2_local1[30] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act30)
    f2_local1[31] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act31)
    f2_local1[32] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act32)
    f2_local1[33] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act33)
    f2_local1[34] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act34)
    f2_local1[35] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act35)
    f2_local1[36] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act36)
    f2_local1[37] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act37)
    f2_local1[38] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act38)
    f2_local1[39] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act39)
    f2_local1[40] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act40)
    f2_local1[41] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act41)
    f2_local1[42] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act42)
    f2_local1[43] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act43)
    f2_local1[44] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act44)
    f2_local1[45] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act45)
    f2_local1[46] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act46)
    f2_local1[47] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act47)
    f2_local1[48] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act48)
    local f2_local14 = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.ActAfter_AdjustSpace)
    Common_Battle_Activate(f2_arg1, f2_arg2, f2_local0, f2_local1, f2_local14, f2_local2)
    
end

Goal.Act01 = function (f3_arg0, f3_arg1, f3_arg2)
    local f3_local0 = f3_arg0:GetDist(TARGET_ENE_0)
    local f3_local1 = 9.6 - f3_arg0:GetMapHitRadius(TARGET_SELF)
    local f3_local2 = f3_arg0:GetRandam_Float(3, 9)
    local f3_local3 = false
    local f3_local4 = 5
    if f3_local1 < f3_local0 then
        f3_arg1:AddSubGoal(GOAL_COMMON_ApproachTarget, f3_local4, TARGET_ENE_0, f3_local1, TARGET_SELF, f3_local3, -1)
    end
    local f3_local5 = 3000
    local f3_local6 = 3001
    local f3_local7 = 3002
    local f3_local8 = 9.6 - f3_arg0:GetMapHitRadius(TARGET_SELF)
    local f3_local9 = 9.6 - f3_arg0:GetMapHitRadius(TARGET_SELF)
    local f3_local10 = 9.6 - f3_arg0:GetMapHitRadius(TARGET_SELF)
    local f3_local11 = 0
    local f3_local12 = 0
    local f3_local13 = f3_arg0:GetRandam_Int(1, 100)
    f3_arg1:AddSubGoal(GOAL_COMMON_ComboTunable_SuccessAngle180, 10, f3_local5, TARGET_ENE_0, 999, 0, 0, 0, 0)
    f3_arg1:AddSubGoal(GOAL_COMMON_ComboRepeat_SuccessAngle180, 10, f3_local6, TARGET_ENE_0, 999, 0, 0, 0, 0)
    f3_arg0:SetNumber(5, 1)
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
    
end

Goal.Act02 = function (f4_arg0, f4_arg1, f4_arg2)
    local f4_local0 = f4_arg0:GetDist(TARGET_ENE_0)
    local f4_local1 = 12.4 - f4_arg0:GetMapHitRadius(TARGET_SELF)
    local f4_local2 = false
    local f4_local3 = 10
    if f4_local1 < f4_local0 then
        f4_arg1:AddSubGoal(GOAL_COMMON_ApproachTarget, f4_local3, TARGET_ENE_0, f4_local1, TARGET_SELF, f4_local2, -1)
    else
    end
    local f4_local4 = 3009
    local f4_local5 = 3004
    local f4_local6 = 3023
    local f4_local7 = 12.4 - f4_arg0:GetMapHitRadius(TARGET_SELF)
    local f4_local8 = 0.1 - f4_arg0:GetMapHitRadius(TARGET_SELF)
    local f4_local9 = 0
    local f4_local10 = 0
    local f4_local11 = f4_arg0:GetRandam_Int(1, 100)
    f4_arg1:AddSubGoal(GOAL_COMMON_ComboAttackTunableSpin, 4, f4_local4, TARGET_ENE_0, 999, f4_local9, f4_local10, 0, 0)
    f4_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, f4_local6, TARGET_ENE_0, 999, f4_local9, f4_local10, 0, 0)
    f4_arg0:SetNumber(7, 0)
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
    
end

Goal.Act03 = function (f5_arg0, f5_arg1, f5_arg2)
    local f5_local0 = f5_arg0:GetDist(TARGET_ENE_0)
    local f5_local1 = 26.8 - f5_arg0:GetMapHitRadius(TARGET_SELF)
    local f5_local2 = false
    local f5_local3 = 10
    if f5_local1 < f5_local0 then
        f5_arg1:AddSubGoal(GOAL_COMMON_ApproachTarget, f5_local3, TARGET_ENE_0, f5_local1, TARGET_SELF, f5_local2, -1)
    elseif f5_local1 - 8 < f5_local0 then
        f5_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 4, 3023, TARGET_ENE_0, SuccessDist1, TurnTime, FrontAngle, 0, 0)
    elseif f5_local1 - 24 < f5_local0 then
        f5_arg1:AddSubGoal(GOAL_COMMON_SpinStep, StepLife, 5211, TARGET_ENE_0, TurnTime, AI_DIR_TYPE_F, CourseLong)
    else
        f5_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 4, 3023, TARGET_ENE_0, SuccessDist1, TurnTime, FrontAngle, 0, 0)
        return false
    end
    local f5_local4 = 3008
    local f5_local5 = 26.8 - f5_arg0:GetMapHitRadius(TARGET_SELF)
    local f5_local6 = 0
    local f5_local7 = 120
    if f5_arg0:IsExistMeshOnLine(TARGET_SELF, AI_DIR_TYPE_F, 15) then
        f5_arg1:AddSubGoal(GOAL_COMMON_ComboTunable_SuccessAngle180, 15, f5_local4, TARGET_ENE_0, 9999, f5_local6, f5_local7, 0, 0)
    else
        return false
    end
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
    
end

Goal.Act04 = function (f6_arg0, f6_arg1, f6_arg2)
    local f6_local0 = f6_arg0:GetDist(TARGET_ENE_0)
    local f6_local1 = 9.2 - f6_arg0:GetMapHitRadius(TARGET_SELF)
    local f6_local2 = 3013
    local f6_local3 = 9.2 - f6_arg0:GetMapHitRadius(TARGET_SELF)
    local f6_local4 = 0
    local f6_local5 = 0
    f6_arg1:AddSubGoal(GOAL_COMMON_ComboTunable_SuccessAngle180, 10, f6_local2, TARGET_ENE_0, 9999, f6_local4, f6_local5, 0, 0):TimingSetNumber(AI_NUMBER_SEARCH_ENEMY_ACTION, 1, AI_TIMING_SET__ACTIVATE)
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
    
end

Goal.Act05 = function (f7_arg0, f7_arg1, f7_arg2)
    local f7_local0 = f7_arg0:GetDist(TARGET_ENE_0)
    local f7_local1 = 12.4 - f7_arg0:GetMapHitRadius(TARGET_SELF) + 2
    local f7_local2 = false
    local f7_local3 = 1
    local f7_local4 = f7_arg0:GetRandam_Int(1, 100)
    if f7_local1 < f7_local0 then
        f7_arg1:AddSubGoal(GOAL_COMMON_ApproachTarget, f7_local3, TARGET_ENE_0, f7_local1, TARGET_SELF, f7_local2, -1)
    else
    end
    local f7_local5 = 3009
    local f7_local6 = 12.4 - f7_arg0:GetMapHitRadius(TARGET_SELF)
    local f7_local7 = 0
    local f7_local8 = 0
    f7_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 10, f7_local5, TARGET_ENE_0, 9999, f7_local7, f7_local8, 0, 0)
    if f7_arg0:IsExistMeshOnLine(TARGET_SELf, AI_DIR_TYPE_B, 20) then
        if f7_local4 > 50 then
            f7_arg1:AddSubGoal(GOAL_COMMON_SpinStep, 10, 5211, TARGET_ENE_0, f7_local7, AI_DIR_TYPE_F, CourseLong)
        else
            f7_arg1:AddSubGoal(GOAL_COMMON_ComboTunable_SuccessAngle180, 10, 3023, TARGET_ENE_0, 999, 0, 0, 0, 0)
        end
    else
        f7_arg1:AddSubGoal(GOAL_COMMON_ComboTunable_SuccessAngle180, 10, 3023, TARGET_ENE_0, 999, 0, 0, 0, 0)
    end
    local f7_local9 = f7_arg0:GetRandam_Float(3.5, 3.5)
    local f7_local10 = f7_arg0:GetRandam_Int(30, 45)
    local f7_local11 = f7_arg0:GetSpRate(TARGET_SELF)
    if f7_local11 >= 0.5 then
        if InsideRange(f7_arg0, f7_arg1, 90, 180, -9999, 9999) then
            f7_arg1:AddSubGoal(GOAL_COMMON_SidewayMove, f7_local9, TARGET_ENE_0, 0, f7_local10, true, true, -1)
        elseif InsideRange(f7_arg0, f7_arg1, -90, 180, -9999, 9999) then
            f7_arg1:AddSubGoal(GOAL_COMMON_SidewayMove, f7_local9, TARGET_ENE_0, 1, f7_local10, true, true, -1)
        end
    end
    f7_arg0:SetNumber(5, 1)
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
    
end

Goal.Act06 = function (f8_arg0, f8_arg1, f8_arg2)
    local f8_local0 = 3012
    local f8_local1 = 0.1 - f8_arg0:GetMapHitRadius(TARGET_SELF)
    local f8_local2 = 0
    local f8_local3 = 0
    f8_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 10, f8_local0, TARGET_ENE_0, f8_local1, f8_local2, f8_local3, 0, 0)
    f8_arg0:SetTimer(2, 8)
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
    
end

Goal.Act07 = function (f9_arg0, f9_arg1, f9_arg2)
    local f9_local0 = f9_arg0:GetDist(TARGET_ENE_0)
    local f9_local1 = 12 - f9_arg0:GetMapHitRadius(TARGET_SELF)
    local f9_local2 = false
    local f9_local3 = f9_arg0:GetRandam_Int(1, 100)
    if f9_local1 + 1 < f9_local0 then
        f9_local1 = f9_local1 + 2.6
    end
    if f9_local1 < f9_local0 then
        f9_arg1:AddSubGoal(GOAL_COMMON_ApproachTarget, 10, TARGET_ENE_0, f9_local1, TARGET_SELF, f9_local2, -1)
    end
    local f9_local4 = 3019
    local f9_local5 = 3020
    local f9_local6 = 0
    local f9_local7 = 0
    if f9_local3 > 10 then
        f9_arg1:AddSubGoal(GOAL_COMMON_ComboAttackTunableSpin, 10, f9_local4, TARGET_ENE_0, f9_local1, f9_local6, f9_local7, 0, 0)
        f9_arg1:AddSubGoal(GOAL_COMMON_ComboRepeat, 10, f9_local5, TARGET_ENE_0, f9_local1, f9_local6, f9_local7, 0, 0)
    else
        f9_arg1:AddSubGoal(GOAL_COMMON_ComboAttackTunableSpin, 10, 3019, TARGET_ENE_0, f9_local1, f9_local6, f9_local7, 0, 0)
    end
    f9_arg0:SetNumber(5, 1)
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
    
end

Goal.Act08 = function (f10_arg0, f10_arg1, f10_arg2)
    local f10_local0 = f10_arg0:GetRandam_Float(3, 4)
    local f10_local1 = f10_arg0:GetRandam_Int(30, 45)
    local f10_local2 = f10_arg0:GetRandam_Int(1, 100)
    local f10_local3 = f10_arg0:GetDist(TARGET_ENE_0)
    local f10_local4 = false
    local f10_local5 = 12 - f10_arg0:GetMapHitRadius(TARGET_SELF) + 5
    local f10_local6 = 3019
    local f10_local7 = 3020
    local f10_local8 = 0
    local f10_local9 = 0
    if f10_local5 < f10_local3 then
        f10_arg1:AddSubGoal(GOAL_COMMON_ApproachTarget, f10_local0, TARGET_ENE_0, f10_local5, TARGET_SELF, f10_local4, -1)
    end
    f10_arg1:AddSubGoal(GOAL_COMMON_ComboTunable_SuccessAngle180, 10, 3022, TARGET_ENE_0, 999, 0, 0, 0, 0)
    if f10_local2 > 10 then
        f10_arg1:AddSubGoal(GOAL_COMMON_ComboAttackTunableSpin, 10, f10_local6, TARGET_ENE_0, f10_local5, f10_local8, f10_local9, 0, 0)
        f10_arg1:AddSubGoal(GOAL_COMMON_ComboRepeat, 10, f10_local7, TARGET_ENE_0, f10_local5, f10_local8, f10_local9, 0, 0)
    else
        f10_arg1:AddSubGoal(GOAL_COMMON_ComboAttackTunableSpin, 10, 3019, TARGET_ENE_0, f10_local5, f10_local8, f10_local9, 0, 0)
    end
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
    
end

Goal.Act09 = function (f11_arg0, f11_arg1, f11_arg2)
    local f11_local0 = f11_arg0:GetDist(TARGET_ENE_0)
    local f11_local1 = 7.6 - f11_arg0:GetMapHitRadius(TARGET_SELF)
    local f11_local2 = f11_arg0:GetRandam_Float(0, 3)
    local f11_local3 = false
    local f11_local4 = 3
    if f11_local1 < f11_local0 then
        f11_arg1:AddSubGoal(GOAL_COMMON_ApproachTarget, f11_local4, TARGET_ENE_0, f11_local1, TARGET_SELF, f11_local3, -1)
    end
    local f11_local5 = 3021
    local f11_local6 = 7.6 - f11_arg0:GetMapHitRadius(TARGET_SELF)
    local f11_local7 = 0
    local f11_local8 = 0
    if f11_arg0:IsExistMeshOnLine(TARGET_SELF, AI_DIR_TYPE_F, 20) then
        f11_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 10, f11_local5, TARGET_ENE_0, f11_local6, f11_local7, f11_local8, 0, 0)
        f11_arg0:SetNumber(5, 1)
    else
        return false
    end
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
    
end

Goal.Act10 = function (f12_arg0, f12_arg1, f12_arg2)
    local f12_local0 = f12_arg0:GetDist(TARGET_ENE_0)
    local f12_local1 = 9.6 - f12_arg0:GetMapHitRadius(TARGET_SELF) + (22.6 - f12_arg0:GetMapHitRadius(TARGET_SELF)) + 3
    local f12_local2 = false
    local f12_local3 = 5
    local f12_local4 = 3
    local f12_local5 = 45
    if f12_local1 < f12_local0 then
        f12_arg1:AddSubGoal(GOAL_COMMON_ApproachTarget, f12_local3, TARGET_ENE_0, f12_local1, TARGET_SELF, f12_local2, -1)
    end
    local f12_local6 = 3026
    local f12_local7 = 3000
    local f12_local8 = 3001
    local f12_local9 = 3002
    local f12_local10 = 9.6 - f12_arg0:GetMapHitRadius(TARGET_SELF) + (22.6 - f12_arg0:GetMapHitRadius(TARGET_SELF)) + 1.5
    local f12_local11 = 9.6 - f12_arg0:GetMapHitRadius(TARGET_SELF)
    local f12_local12 = 9.6 - f12_arg0:GetMapHitRadius(TARGET_SELF)
    local f12_local13 = 9.6 - f12_arg0:GetMapHitRadius(TARGET_SELF)
    local f12_local14 = 0
    local f12_local15 = 0
    local f12_local16 = f12_arg0:GetRandam_Int(1, 100)
    if f12_local16 > 50 then
        f12_arg1:AddSubGoal(GOAL_COMMON_ComboAttackTunableSpin, 10, f12_local6, TARGET_ENE_0, f12_local10, f12_local14, f12_local15, 0, 0)
        f12_arg1:AddSubGoal(GOAL_COMMON_ComboRepeat, 10, f12_local7, TARGET_ENE_0, f12_local11, f12_local14, f12_local15, 0, 0)
        f12_arg1:AddSubGoal(GOAL_COMMON_ComboRepeat, 10, f12_local8, TARGET_ENE_0, f12_local12, f12_local14, f12_local15, 0, 0)
        f12_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, f12_local9, TARGET_ENE_0, f12_local13, f12_local14, f12_local15, 0, 0)
    elseif f12_local16 > 20 then
        f12_arg1:AddSubGoal(GOAL_COMMON_ComboAttackTunableSpin, 10, f12_local6, TARGET_ENE_0, f12_local10, f12_local14, f12_local15, 0, 0)
        f12_arg1:AddSubGoal(GOAL_COMMON_ComboRepeat, 10, f12_local7, TARGET_ENE_0, f12_local11, f12_local14, f12_local15, 0, 0)
        f12_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, f12_local8, TARGET_ENE_0, f12_local12, f12_local14, f12_local15, 0, 0)
    elseif f12_local16 > 20 then
        f12_arg0:AddObserveArea(3, TARGET_SELF, TARGET_ENE_0, AI_DIR_TYPE_B, 120, 7)
        f12_arg1:AddSubGoal(GOAL_COMMON_ComboTunable_SuccessAngle180, 10, f12_local6, TARGET_ENE_0, 9999, f12_local14, f12_local15, 0, 0)
        f12_arg1:AddSubGoal(GOAL_COMMON_ComboTunable_SuccessAngle180, 10, f12_local7, TARGET_ENE_0, 9999, f12_local14, f12_local15, 0, 0)
    else
        f12_arg1:AddSubGoal(GOAL_COMMON_ComboAttackTunableSpin, 10, f12_local6, TARGET_ENE_0, f12_local10, f12_local14, f12_local15, 0, 0)
    end
    f12_arg0:SetNumber(5, 1)
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
    
end

Goal.Act11 = function (f13_arg0, f13_arg1, f13_arg2)
    local f13_local0 = f13_arg0:GetDist(TARGET_ENE_0)
    local f13_local1 = 12.4 - f13_arg0:GetMapHitRadius(TARGET_SELF) + (22.6 - f13_arg0:GetMapHitRadius(TARGET_SELF)) - 1
    local f13_local2 = false
    local f13_local3 = 5
    local f13_local4 = 3
    local f13_local5 = 45
    if f13_local1 < f13_local0 then
        f13_arg1:AddSubGoal(GOAL_COMMON_ApproachTarget, f13_local3, TARGET_ENE_0, f13_local1, TARGET_SELF, f13_local2, -1)
    end
    local f13_local6 = 3026
    local f13_local7 = 3009
    local f13_local8 = 12.4 - f13_arg0:GetMapHitRadius(TARGET_SELF) + (22.6 - f13_arg0:GetMapHitRadius(TARGET_SELF))
    local f13_local9 = 12.4 - f13_arg0:GetMapHitRadius(TARGET_SELF)
    local f13_local10 = 0
    local f13_local11 = 0
    local f13_local12 = f13_arg0:GetRandam_Int(1, 100)
    f13_arg1:AddSubGoal(GOAL_COMMON_ComboRepeat, 10, f13_local7, TARGET_ENE_0, f13_local9, 0)
    f13_arg0:SetNumber(5, 1)
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
    
end

Goal.Act12 = function (f14_arg0, f14_arg1, f14_arg2)
    local f14_local0 = f14_arg0:GetDist(TARGET_ENE_0)
    local f14_local1 = 3014
    local f14_local2 = 0.1 - f14_arg0:GetMapHitRadius(TARGET_SELF)
    local f14_local3 = 0
    local f14_local4 = 0
    f14_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 10, f14_local1, TARGET_ENE_0, f14_local2, f14_local3, f14_local4, 0, 0)
    f14_arg0:SetNumber(5, 1)
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
    
end

Goal.Act13 = function (f15_arg0, f15_arg1, f15_arg2)
    local f15_local0 = f15_arg0:GetDist(TARGET_ENE_0)
    local f15_local1 = 9.6 - f15_arg0:GetMapHitRadius(TARGET_SELF)
    local f15_local2 = f15_arg0:GetRandam_Float(3, 9)
    local f15_local3 = false
    local f15_local4 = 5
    local f15_local5 = 3000
    local f15_local6 = 3015
    local f15_local7 = 3026
    local f15_local8 = 9.6 - f15_arg0:GetMapHitRadius(TARGET_SELF)
    local f15_local9 = 0.1 - f15_arg0:GetMapHitRadius(TARGET_SELF)
    local f15_local10 = 0
    local f15_local11 = 0
    f15_arg0:AddObserveArea(3, TARGET_SELF, TARGET_ENE_0, AI_DIR_TYPE_B, 120, 8)
    f15_arg1:AddSubGoal(GOAL_COMMON_ComboTunable_SuccessAngle180, 10, f15_local5, TARGET_ENE_0, 9999, f15_local10, f15_local11, 0, 0)
    f15_arg0:SetNumber(5, 1)
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
    
end

Goal.Act14 = function (f16_arg0, f16_arg1, f16_arg2)
    local f16_local0 = f16_arg0:GetDist(TARGET_ENE_0)
    local f16_local1 = 9.2 - f16_arg0:GetMapHitRadius(TARGET_SELF)
    local f16_local2 = 3013
    local f16_local3 = 9.2 - f16_arg0:GetMapHitRadius(TARGET_SELF)
    local f16_local4 = 0
    local f16_local5 = 0
    local f16_local6 = f16_arg0:GetDist(TARGET_ENE_0)
    local f16_local7 = 9.6 - f16_arg0:GetMapHitRadius(TARGET_SELF)
    local f16_local8 = f16_arg0:GetRandam_Float(3, 9)
    local f16_local9 = false
    local f16_local10 = 5
    if f16_local7 < f16_local6 then
        f16_arg1:AddSubGoal(GOAL_COMMON_ApproachTarget, f16_local10, TARGET_ENE_0, f16_local7, TARGET_SELF, f16_local9, -1)
    end
    f16_arg1:AddSubGoal(GOAL_COMMON_ComboTunable_SuccessAngle180, 10, 3016, TARGET_ENE_0, 9999, f16_local4, f16_local5, 0, 0)
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
    
end

Goal.Act15 = function (f17_arg0, f17_arg1, f17_arg2)
    local f17_local0 = f17_arg0:GetDist(TARGET_ENE_0)
    local f17_local1 = 20 - f17_arg0:GetMapHitRadius(TARGET_SELF) + 12
    local f17_local2 = false
    local f17_local3 = 5
    if f17_local1 < f17_local0 then
        f17_arg1:AddSubGoal(GOAL_COMMON_ApproachTarget, f17_local3, TARGET_ENE_0, f17_local1, TARGET_SELF, f17_local2, -1)
    elseif f17_local0 <= 10 then
        local f17_local4 = 3
        local f17_local5 = 0
        local f17_local6 = 3
        f17_arg1:AddSubGoal(GOAL_COMMON_SpinStep, f17_local4, 5211, TARGET_ENE_0, f17_local5, AI_DIR_TYPE_B, f17_local6)
    end
    local f17_local4 = 3
    local f17_local5 = 45
    local f17_local6 = 3028
    local f17_local7 = 20 - f17_arg0:GetMapHitRadius(TARGET_SELF)
    local f17_local8 = 0
    local f17_local9 = 0
    f17_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 10, f17_local6, TARGET_ENE_0, f17_local7, f17_local8, f17_local9, 0, 0)
    f17_arg0:SetNumber(5, 1)
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
    
end

Goal.Act16 = function (f18_arg0, f18_arg1, f18_arg2)
    local f18_local0 = f18_arg0:GetDist(TARGET_ENE_0)
    local f18_local1 = 10
    local f18_local2 = 9920
    f18_arg1:AddSubGoal(GOAL_COMMON_Guard, f18_local1, f18_local2, TARGET_ENE_0, false, 0)
    f18_arg0:SetNumber(5, 1)
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
    
end

Goal.Act17 = function (f19_arg0, f19_arg1, f19_arg2)
    f19_arg1:AddSubGoal(GOAL_COMMON_ComboAttackTunableSpin, 10, 3026, TARGET_ENE_0, 999, 0, 0, 0, 0)
    f19_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3027, TARGET_ENE_0, 999, 0, 0, 0, 0)
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
    
end

Goal.Act18 = function (f20_arg0, f20_arg1, f20_arg2)
    local f20_local0 = 0
    local f20_local1 = 0
    f20_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 10, 3018, TARGET_ENE_0, 999, f20_local0, f20_local1, 0, 0)
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
    
end

Goal.Act19 = function (f21_arg0, f21_arg1, f21_arg2)
    local f21_local0 = 0
    local f21_local1 = 0
    f21_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 10, 3029, TARGET_ENE_0, 999, f21_local0, f21_local1, 0, 0)
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
    
end

Goal.Act20 = function (f22_arg0, f22_arg1, f22_arg2)
    local f22_local0 = 0
    local f22_local1 = 0
    f22_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 10, 20025, TARGET_EVENT, 999, f22_local0, f22_local1, 0, 0)
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
    
end

Goal.Act21 = function (f23_arg0, f23_arg1, f23_arg2)
    local f23_local0 = 3
    local f23_local1 = 8
    f23_arg1:AddSubGoal(GOAL_COMMON_ApproachTarget, f23_local0, TARGET_EVENT, f23_local1, TARGET_SELF, false, -1)
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
    
end

Goal.Act27 = function (f24_arg0, f24_arg1, f24_arg2)
    local f24_local0 = f24_arg0:GetDist(TARGET_ENE_0)
    local f24_local1 = f24_arg0:GetRandam_Int(1, 100)
    local f24_local2 = 15
    local f24_local3 = 10
    local f24_local4 = f24_arg0:GetRandam_Float(2, 4)
    local f24_local5 = f24_arg0:GetRandam_Int(30, 45)
    local f24_local6 = f24_arg0:GetRandam_Float(3, 5)
    local f24_local7 = 3
    local f24_local8 = 0
    local f24_local9 = 3
    if f24_local2 <= f24_local0 then
        f24_arg1:AddSubGoal(GOAL_COMMON_ApproachTarget, f24_local4, TARGET_ENE_0, f24_local2, TARGET_ENE_0, true, -1)
    elseif f24_local0 <= f24_local3 then
        f24_arg1:AddSubGoal(GOAL_COMMON_SpinStep, f24_local7, 5201, TARGET_ENE_0, f24_local8, AI_DIR_TYPE_B, f24_local9)
    end
    f24_arg1:AddSubGoal(GOAL_COMMON_SidewayMove, f24_local4, TARGET_ENE_0, f24_arg0:GetRandam_Int(0, 1), f24_local5, true, true, -1)
    if f24_local1 <= 60 then
    end
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
    
end

Goal.Act29 = function (f25_arg0, f25_arg1, f25_arg2)
    local f25_local0 = f25_arg0:GetDist(TARGET_ENE_0)
    local f25_local1 = f25_arg0:GetRandam_Int(1, 100)
    local f25_local2 = 0
    local f25_local3 = 0
    local f25_local4 = 10
    local f25_local5 = 3026
    local f25_local6 = 9.6 - f25_arg0:GetMapHitRadius(TARGET_SELF)
    f25_arg1:ClearSubGoal()
    if f25_arg0:IsExistMeshOnLine(TARGET_ENE_0, AI_DIR_TYPE_B, 15) then
        f25_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 10, 3017, TARGET_ENE_0, 999, f25_local2, f25_local3, 0, 0)
        f25_arg1:AddSubGoal(GOAL_COMMON_LeaveTarget, 10, TARGET_ENE_0, f25_local0 + 20, TARGET_SELF, false, -1)
    end
    f25_arg0:SetTimer(0, 60)
    f25_arg0:SetTimer(1, 25)
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
    
end

Goal.Act30 = function (f26_arg0, f26_arg1, f26_arg2)
    local f26_local0 = f26_arg0:GetDist(TARGET_ENE_0)
    local f26_local1 = f26_arg0:GetRandam_Int(1, 100)
    local f26_local2 = 0
    local f26_local3 = 0
    local f26_local4 = 10
    local f26_local5 = 3026
    local f26_local6 = 9.6 - f26_arg0:GetMapHitRadius(TARGET_SELF)
    f26_arg1:ClearSubGoal()
    if f26_arg0:IsExistMeshOnLine(TARGET_ENE_0, AI_DIR_TYPE_B, 15) then
        f26_arg1:AddSubGoal(GOAL_COMMON_LeaveTarget, 8, TARGET_ENE_0, f26_local0 + 15, TARGET_SELF, false, -1)
    end
    f26_arg0:SetTimer(0, 60)
    f26_arg0:SetTimer(1, 25)
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
    
end

Goal.Act31 = function (f27_arg0, f27_arg1, f27_arg2)
    local f27_local0 = f27_arg0:GetDist(TARGET_ENE_0)
    local f27_local1 = f27_arg0:GetRandam_Int(1, 100)
    local f27_local2 = 0.1
    local f27_local3 = 0
    local f27_local4 = f27_arg0:GetRandam_Int(30, 45)
    local f27_local5 = f27_arg0:GetRandam_Float(6, 12)
    local f27_local6 = f27_arg0:GetRandam_Float(28, 30)
    local f27_local7 = f27_arg0:GetRandam_Float(10, 15)
    if f27_arg0:IsExistMeshOnLine(TARGET_ENE_0, AI_DIR_TYPE_F, 32) then
        f27_arg1:AddSubGoal(GOAL_COMMON_SpinStep, f27_local2, 5211, TARGET_ENE_0, f27_local3, AI_DIR_TYPE_F, f27_local6)
    elseif f27_arg0:IsExistMeshOnLine(TARGET_ENE_0, AI_DIR_TYPE_F, 20) then
        f27_arg1:AddSubGoal(GOAL_COMMON_ComboAttack, 10, 3023, TARGET_ENE_0, f27_local5, f27_local3, 0, 0, 0)
        f27_arg1:AddSubGoal(GOAL_COMMON_ComboRepeat, 10, 3023, TARGET_ENE_0, f27_local5, f27_local3, 0, 0, 0)
    elseif f27_arg0:IsExistMeshOnLine(TARGET_ENE_0, AI_DIR_TYPE_F, 10) then
        f27_arg1:AddSubGoal(GOAL_COMMON_ComboAttackTunableSpin, 10, 3023, TARGET_ENE_0, f27_local5, f27_local3, 0, 0, 0)
    elseif f27_arg0:IsExistMeshOnLine(TARGET_ENE_0, AI_DIR_TYPE_F, 5) then
        return false
    else
        return false
    end
    f27_arg0:SetTimer(0, 60)
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
    
end

Goal.Act32 = function (f28_arg0, f28_arg1, f28_arg2)
    local f28_local0 = f28_arg0:GetRandam_Float(3, 4)
    local f28_local1 = f28_arg0:GetRandam_Int(30, 45)
    local f28_local2 = 0
    local f28_local3 = 0
    local f28_local4 = f28_arg0:GetRandam_Int(1, 100)
    local f28_local5 = f28_arg0:GetRandam_Int(1, 100)
    local f28_local6 = f28_arg0:GetRandam_Int(1, 100)
    if f28_local4 > 40 then
        f28_arg1:AddSubGoal(GOAL_COMMON_ComboTunable_SuccessAngle180, 10, 3022, TARGET_ENE_0, 999, 0)
    elseif fata1 > 20 then
        f28_arg1:AddSubGoal(GOAL_COMMON_ComboTunable_SuccessAngle180, 10, 3024, TARGET_ENE_0, 999, 0)
    else
        f28_arg1:AddSubGoal(GOAL_COMMON_ComboTunable_SuccessAngle180, 10, 3025, TARGET_ENE_0, 999, 0)
    end
    if f28_local5 > 80 then
        f28_arg1:AddSubGoal(GOAL_COMMON_ComboRepeat, 10, 3022, TARGET_ENE_0, 999, 0)
    elseif f28_local5 > 50 then
        f28_arg1:AddSubGoal(GOAL_COMMON_ComboRepeat, 10, 3024, TARGET_ENE_0, 999, 0)
    elseif f28_local5 > 20 then
        f28_arg1:AddSubGoal(GOAL_COMMON_ComboRepeat, 10, 3025, TARGET_ENE_0, 999, 0)
    else
    end
    if f28_local6 > 80 then
        f28_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3022, TARGET_ENE_0, 999, 0)
    elseif f28_local6 > 50 then
        f28_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3024, TARGET_ENE_0, 999, 0)
    elseif f28_local6 > 20 then
        f28_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3025, TARGET_ENE_0, 999, 0)
    else
        f28_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3023, TARGET_ENE_0, 999, 0)
    end
    f28_arg0:SetTimer(3, 5)
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
    
end

Goal.Act33 = function (f29_arg0, f29_arg1, f29_arg2)
    local f29_local0 = f29_arg0:GetRandam_Float(3, 4)
    local f29_local1 = f29_arg0:GetRandam_Int(30, 45)
    local f29_local2 = 0
    local f29_local3 = 0
    local f29_local4 = f29_arg0:GetRandam_Int(1, 100)
    local f29_local5 = 3
    local f29_local6 = 0
    local f29_local7 = 3
    if f29_arg0:IsExistMeshOnLine(TARGET_SELF, AI_DIR_TYPE_R, 15) and f29_arg0:IsExistMeshOnLine(TARGET_SELF, AI_DIR_TYPE_L, 15) then
        f29_arg1:AddSubGoal(GOAL_COMMON_ComboTunable_SuccessAngle180, 10, 3024, TARGET_ENE_0, 999, 0)
    elseif not f29_arg0:IsExistMeshOnLine(TARGET_SELF, AI_DIR_TYPE_R, 15) then
        f29_arg1:AddSubGoal(GOAL_COMMON_ComboTunable_SuccessAngle180, 10, 3024, TARGET_ENE_0, 999, 0)
    elseif not f29_arg0:IsExistMeshOnLine(TARGET_SELF, AI_DIR_TYPE_L, 15) then
        f29_arg1:AddSubGoal(GOAL_COMMON_ComboTunable_SuccessAngle180, 10, 3025, TARGET_ENE_0, 999, 0)
    else
        return false
    end
    f29_arg0:SetTimer(3, 5)
    f29_arg0:SetTimer(1, 25)
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
    
end

Goal.Act34 = function (f30_arg0, f30_arg1, f30_arg2)
    local f30_local0 = f30_arg0:GetRandam_Float(3, 4)
    local f30_local1 = f30_arg0:GetRandam_Int(30, 45)
    local f30_local2 = 0
    local f30_local3 = 0
    local f30_local4 = f30_arg0:GetRandam_Int(1, 100)
    local f30_local5 = 3
    local f30_local6 = 0
    local f30_local7 = 3
    if f30_arg0:IsExistMeshOnLine(TARGET_SELF, AI_DIR_TYPE_R, 15) and f30_arg0:IsExistMeshOnLine(TARGET_SELF, AI_DIR_TYPE_L, 15) then
        f30_arg1:AddSubGoal(GOAL_COMMON_ComboTunable_SuccessAngle180, 10, 3025, TARGET_ENE_0, 999, 0)
    elseif not f30_arg0:IsExistMeshOnLine(TARGET_SELF, AI_DIR_TYPE_R, 15) then
        f30_arg1:AddSubGoal(GOAL_COMMON_ComboTunable_SuccessAngle180, 10, 3024, TARGET_ENE_0, 999, 0)
    elseif not f30_arg0:IsExistMeshOnLine(TARGET_SELF, AI_DIR_TYPE_L, 15) then
        f30_arg1:AddSubGoal(GOAL_COMMON_ComboTunable_SuccessAngle180, 10, 3025, TARGET_ENE_0, 999, 0)
    else
        return false
    end
    f30_arg0:SetTimer(3, 5)
    f30_arg0:SetTimer(1, 25)
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
    
end

Goal.Act35 = function (f31_arg0, f31_arg1, f31_arg2)
    local f31_local0 = 3
    local f31_local1 = f31_arg0:GetRandam_Float(1.5, 2.5)
    local f31_local2 = f31_arg0:GetRandam_Int(30, 45)
    local f31_local3 = f31_arg0:GetRandam_Float(9, 13)
    local f31_local4 = f31_arg0:GetRandam_Float(6, 10)
    local f31_local5 = f31_arg0:GetDist(TARGET_ENE_0)
    if InsideRange(f31_arg0, f31_arg1, 135, 90, -9999, 9999) then
        f31_arg1:AddSubGoal(GOAL_COMMON_SidewayMove, f31_local0, TARGET_ENE_0, 0, f31_local2, true, true, -1)
    elseif InsideRange(f31_arg0, f31_arg1, -135, 90, -9999, 9999) then
        f31_arg1:AddSubGoal(GOAL_COMMON_SidewayMove, f31_local0, TARGET_ENE_0, 1, f31_local2, true, true, -1)
    elseif f31_local5 > 15 then
        f31_arg1:AddSubGoal(GOAL_COMMON_ApproachTarget, f31_local1, TARGET_ENE_0, f31_local3, TARGET_SELF, true, 9910)
    else
        f31_arg1:AddSubGoal(GOAL_COMMON_ApproachTarget, f31_local1, TARGET_ENE_0, f31_local4, TARGET_SELF, true, 9910)
    end
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
    
end

Goal.Act36 = function (f32_arg0, f32_arg1, f32_arg2)
    local f32_local0 = 3
    local f32_local1 = 0
    local f32_local2 = 3
    local f32_local3 = f32_arg0:GetRandam_Int(1, 100)
    local f32_local4 = f32_arg0:GetDist(TARGET_ENE_0)
    f32_arg0:SetTimer(1, 25)
    if InsideRange(f32_arg0, f32_arg1, 90, 180, -9999, 9999) and f32_arg0:IsExistMeshOnLine(TARGET_SELF, AI_DIR_TYPE_L, 2) or InsideRange(f32_arg0, f32_arg1, -90, 180, -9999, 9999) and not f32_arg0:IsExistMeshOnLine(TARGET_SELF, AI_DIR_TYPE_R, 2) then
        f32_arg1:AddSubGoal(GOAL_COMMON_SpinStep, f32_local0, 5202, TARGET_ENE_0, f32_local1, AI_DIR_TYPE_L, f32_local2)
        if f32_local3 > 50 and f32_local4 > 10 then
            f32_arg1:AddSubGoal(GOAL_COMMON_Attack, f32_local0, 3022, TARGET_ENE_0, 0)
        else
            f32_arg1:AddSubGoal(GOAL_COMMON_Attack, f32_local0, 3023, TARGET_ENE_0, 0)
        end
    elseif InsideRange(f32_arg0, f32_arg1, -90, 180, -9999, 9999) and f32_arg0:IsExistMeshOnLine(TARGET_SELF, AI_DIR_TYPE_R, 2) or InsideRange(f32_arg0, f32_arg1, 90, 180, -9999, 9999) and not f32_arg0:IsExistMeshOnLine(TARGET_SELF, AI_DIR_TYPE_L, 2) then
        f32_arg1:AddSubGoal(GOAL_COMMON_SpinStep, f32_local0, 5203, TARGET_ENE_0, f32_local1, AI_DIR_TYPE_R, f32_local2)
        if f32_local3 > 50 and f32_local4 > 10 then
            f32_arg1:AddSubGoal(GOAL_COMMON_Attack, f32_local0, 3022, TARGET_ENE_0, 0)
        else
            f32_arg1:AddSubGoal(GOAL_COMMON_Attack, f32_local0, 3023, TARGET_ENE_0, 0)
        end
    end
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
    
end

Goal.Act37 = function (f33_arg0, f33_arg1, f33_arg2)
    local f33_local0 = f33_arg0:GetDist(TARGET_ENE_0)
    local f33_local1 = f33_arg0:GetRandam_Int(1, 100)
    local f33_local2 = 0.1
    local f33_local3 = 0
    local f33_local4 = 3
    local f33_local5 = f33_arg0:GetRandam_Float(1, 3)
    local f33_local6 = f33_arg0:GetRandam_Int(30, 45)
    local f33_local7 = f33_arg0:GetRandam_Float(3, 5)
    local f33_local8 = f33_arg0:GetRandam_Float(1, 1.5)
    local f33_local9 = f33_arg0:GetRandam_Float(6, 10)
    if f33_local1 > 60 then
        f33_arg1:AddSubGoal(GOAL_COMMON_ApproachSettingDirection, f33_local8, TARGET_ENE_0, f33_local9, TARGET_SELF, false, -1, AI_DIR_TYPE_ToR, f33_local9)
    elseif f33_local1 > 20 then
        f33_arg1:AddSubGoal(GOAL_COMMON_ApproachSettingDirection, f33_local8, TARGET_ENE_0, f33_local9, TARGET_SELF, false, -1, AI_DIR_TYPE_ToL, f33_local9)
    elseif InsideRange(f33_arg0, f33_arg1, 90, 180, -9999, 9999) and f33_arg0:IsExistMeshOnLine(TARGET_SELF, AI_DIR_TYPE_L, 5) or InsideRange(f33_arg0, f33_arg1, -90, 180, -9999, 9999) and not f33_arg0:IsExistMeshOnLine(TARGET_SELF, AI_DIR_TYPE_R, 2) then
        f33_arg1:AddSubGoal(GOAL_COMMON_SpinStep, f33_local2, 5202, TARGET_ENE_0, f33_local3, AI_DIR_TYPE_L, f33_local4)
    elseif InsideRange(f33_arg0, f33_arg1, -90, 180, -9999, 9999) and f33_arg0:IsExistMeshOnLine(TARGET_SELF, AI_DIR_TYPE_R, 5) or InsideRange(f33_arg0, f33_arg1, 90, 180, -9999, 9999) and not f33_arg0:IsExistMeshOnLine(TARGET_SELF, AI_DIR_TYPE_L, 2) then
        f33_arg1:AddSubGoal(GOAL_COMMON_SpinStep, f33_local2, 5203, TARGET_ENE_0, f33_local3, AI_DIR_TYPE_R, f33_local4)
    end
    f33_arg0:SetTimer(0, 60)
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
    
end

Goal.Act38 = function (f34_arg0, f34_arg1, f34_arg2)
    local f34_local0 = f34_arg0:GetDist(TARGET_ENE_0)
    local f34_local1 = f34_arg0:GetRandam_Int(1, 100)
    local f34_local2 = 0
    local f34_local3 = 3
    local f34_local4 = f34_arg0:GetRandam_Float(1, 2.5)
    local f34_local5 = f34_arg0:GetRandam_Int(30, 45)
    local f34_local6 = f34_arg0:GetRandam_Float(3, 5)
    local f34_local7 = f34_arg0:GetRandam_Float(2, 2.5)
    local f34_local8 = f34_arg0:GetRandam_Float(17, 20)
    if f34_local1 > 60 then
        f34_arg1:AddSubGoal(GOAL_COMMON_ApproachSettingDirection, f34_local7, TARGET_ENE_0, f34_local4, TARGET_SELF, false, -1, AI_DIR_TYPE_ToR, f34_local8)
        f34_arg1:AddSubGoal(GOAL_COMMON_ComboTunable_SuccessAngle180, 10, 3025, TARGET_ENE_0, 999, 0)
    elseif f34_local1 > 20 then
        f34_arg1:AddSubGoal(GOAL_COMMON_ApproachSettingDirection, f34_local7, TARGET_ENE_0, f34_local4, TARGET_SELF, false, -1, AI_DIR_TYPE_ToL, f34_local8)
        f34_arg1:AddSubGoal(GOAL_COMMON_ComboTunable_SuccessAngle180, 10, 3024, TARGET_ENE_0, 999, 0)
    elseif InsideRange(f34_arg0, f34_arg1, 90, 180, -9999, 9999) and f34_arg0:IsExistMeshOnLine(TARGET_SELF, AI_DIR_TYPE_L, 5) or InsideRange(f34_arg0, f34_arg1, -90, 180, -9999, 9999) and not f34_arg0:IsExistMeshOnLine(TARGET_SELF, AI_DIR_TYPE_R, 2) then
        f34_arg1:AddSubGoal(GOAL_COMMON_ComboTunable_SuccessAngle180, 10, 3024, TARGET_ENE_0, 999, 0)
    elseif InsideRange(f34_arg0, f34_arg1, -90, 180, -9999, 9999) and f34_arg0:IsExistMeshOnLine(TARGET_SELF, AI_DIR_TYPE_R, 5) or InsideRange(f34_arg0, f34_arg1, 90, 180, -9999, 9999) and not f34_arg0:IsExistMeshOnLine(TARGET_SELF, AI_DIR_TYPE_L, 2) then
        f34_arg1:AddSubGoal(GOAL_COMMON_ComboTunable_SuccessAngle180, 10, 3025, TARGET_ENE_0, 999, 0)
    end
    f34_arg0:SetTimer(0, 60)
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
    
end

Goal.Act39 = function (f35_arg0, f35_arg1, f35_arg2)
    local f35_local0 = f35_arg0:GetDist(TARGET_ENE_0)
    local f35_local1 = f35_arg0:GetRandam_Int(1, 100)
    local f35_local2 = 15
    local f35_local3 = 10
    local f35_local4 = f35_arg0:GetRandam_Float(2, 4)
    local f35_local5 = f35_arg0:GetRandam_Int(30, 45)
    local f35_local6 = f35_arg0:GetRandam_Float(3, 5)
    local f35_local7 = 3
    local f35_local8 = 0
    local f35_local9 = 3
    if f35_local2 <= f35_local0 then
        f35_arg1:AddSubGoal(GOAL_COMMON_ApproachTarget, f35_local4, TARGET_ENE_0, f35_local2, TARGET_ENE_0, true, -1)
    elseif f35_local0 <= f35_local3 then
        f35_arg1:AddSubGoal(GOAL_COMMON_SpinStep, f35_local7, 5201, TARGET_ENE_0, f35_local8, AI_DIR_TYPE_B, f35_local9)
    end
    f35_arg1:AddSubGoal(GOAL_COMMON_SidewayMove, f35_local4, TARGET_ENE_0, f35_arg0:GetRandam_Int(0, 1), f35_local5, true, true, -1)
    if f35_local1 <= 60 then
    end
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
    
end

Goal.Act40 = function (f36_arg0, f36_arg1, f36_arg2)
    local f36_local0 = f36_arg0:GetDist(TARGET_ENE_0)
    local f36_local1 = ATT3031_DIST_MAX
    local f36_local2 = false
    local f36_local3 = 3
    local f36_local4 = f36_arg0:GetRandam_Int(1, 100)
    if f36_local0 < 2 and f36_arg0:IsExistMeshOnLine(TARGET_SELF, AI_DIR_TYPE_B, 2) then
        f36_arg1:AddSubGoal(GOAL_COMMON_SpinStep, 3, 5210, TARGET_ENE_0, 0, AI_DIR_TYPE_B, 0)
    elseif f36_local0 < 5 and f36_arg0:IsExistMeshOnLine(TARGET_SELF, AI_DIR_TYPE_B, 2) then
        f36_arg1:AddSubGoal(GOAL_COMMON_SpinStep, 3, 5201, TARGET_ENE_0, 0, AI_DIR_TYPE_B, 0)
    end
    local f36_local5 = 3030
    local f36_local6 = 999
    local f36_local7 = 0
    local f36_local8 = 0
    f36_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 10, f36_local5, TARGET_ENE_0, f36_local6, f36_local7, f36_local8, 0, 0)
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
    
end

Goal.Act41 = function (f37_arg0, f37_arg1, f37_arg2)
    local f37_local0 = 3
    local f37_local1 = 45
    f37_arg1:AddSubGoal(GOAL_COMMON_Turn, f37_local0, TARGET_ENE_0, f37_local1, -1, GOAL_RESULT_Success, true)
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
    
end

Goal.Act42 = function (f38_arg0, f38_arg1, f38_arg2)
    local f38_local0 = 3
    local f38_local1 = 0
    local f38_local2 = 3
    if InsideRange(f38_arg0, f38_arg1, 90, 180, -9999, 9999) and f38_arg0:IsExistMeshOnLine(TARGET_SELF, AI_DIR_TYPE_L, 2) or InsideRange(f38_arg0, f38_arg1, -90, 180, -9999, 9999) and not f38_arg0:IsExistMeshOnLine(TARGET_SELF, AI_DIR_TYPE_R, 2) then
        f38_arg1:AddSubGoal(GOAL_COMMON_SpinStep, f38_local0, 5202, TARGET_ENE_0, f38_local1, AI_DIR_TYPE_L, f38_local2):TimingSetNumber(AI_NUMBER_SEARCH_ENEMY_ACTION, 1, AI_TIMING_SET__ACTIVATE)
    elseif InsideRange(f38_arg0, f38_arg1, -90, 180, -9999, 9999) and f38_arg0:IsExistMeshOnLine(TARGET_SELF, AI_DIR_TYPE_R, 2) or InsideRange(f38_arg0, f38_arg1, 90, 180, -9999, 9999) and not f38_arg0:IsExistMeshOnLine(TARGET_SELF, AI_DIR_TYPE_L, 2) then
        f38_arg1:AddSubGoal(GOAL_COMMON_SpinStep, f38_local0, 5203, TARGET_ENE_0, f38_local1, AI_DIR_TYPE_R, f38_local2):TimingSetNumber(AI_NUMBER_SEARCH_ENEMY_ACTION, 1, AI_TIMING_SET__ACTIVATE)
    end
    f38_arg0:SetTimer(1, 3)
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
    
end

Goal.Act43 = function (f39_arg0, f39_arg1, f39_arg2)
    if f39_arg0:GetTimer(5) <= 0 then
        f39_arg0:SetNumber(5, 0)
        f39_arg0:SetTimer(5, 8)
    else
        f39_arg0:SetNumber(5, f39_arg0:GetNumber(5) + 1)
    end
    if f39_arg0:GetNumber(5) <= 1 or f39_arg0:HasSpecialEffectId(TARGET_EVENT, 3510900) then
        local f39_local0 = f39_arg0:GetRandam_Float(2.5, 3.5)
        local f39_local1 = f39_arg0:GetRandam_Int(30, 45)
        if InsideRange(f39_arg0, f39_arg1, 90, 180, -9999, 9999) then
            f39_arg1:AddSubGoal(GOAL_COMMON_SidewayMove, f39_local0, TARGET_ENE_0, 0, f39_local1, true, true, -1)
        elseif InsideRange(f39_arg0, f39_arg1, -90, 180, -9999, 9999) then
            f39_arg1:AddSubGoal(GOAL_COMMON_SidewayMove, f39_local0, TARGET_ENE_0, 1, f39_local1, true, true, -1)
        end
    else
        local f39_local0 = 0
        local f39_local1 = 0
        local f39_local2 = f39_arg0:GetRandam_Int(1, 100)
        if f39_local2 < 70 then
            f39_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 10, 3012, TARGET_ENE_0, 999, f39_local0, f39_local1, 0, 0)
        else
            f39_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 10, 3018, TARGET_ENE_0, 999, f39_local0, f39_local1, 0, 0)
        end
        f39_arg0:SetTimer(5, 0)
    end
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
    
end

Goal.Act44 = function (f40_arg0, f40_arg1, f40_arg2)
    local f40_local0 = 3
    local f40_local1 = 0
    local f40_local2 = 3
    f40_arg1:AddSubGoal(GOAL_COMMON_SpinStep, f40_local0, 5211, TARGET_ENE_0, f40_local1, AI_DIR_TYPE_B, f40_local2)
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
    
end

Goal.Act45 = function (f41_arg0, f41_arg1, f41_arg2)
    local f41_local0 = f41_arg0:GetRandam_Float(3, 5)
    local f41_local1 = 5
    f41_arg1:AddSubGoal(GOAL_COMMON_LeaveTarget, f41_local0, TARGET_ENE_0, f41_local1, TARGET_ENE_0, true, -1)
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
    
end

Goal.Act46 = function (f42_arg0, f42_arg1, f42_arg2)
    local f42_local0 = f42_arg0:GetDist(TARGET_ENE_0)
    local f42_local1 = 9.6 - f42_arg0:GetMapHitRadius(TARGET_SELF)
    local f42_local2 = f42_arg0:GetRandam_Float(3, 9)
    local f42_local3 = false
    local f42_local4 = 5
    if f42_local1 < f42_local0 then
        f42_arg1:AddSubGoal(GOAL_COMMON_ApproachTarget, f42_local4, TARGET_ENE_0, f42_local1, TARGET_SELF, f42_local3, -1)
    end
    local f42_local5 = 9.6 - f42_arg0:GetMapHitRadius(TARGET_SELF)
    local f42_local6 = 9.6 - f42_arg0:GetMapHitRadius(TARGET_SELF)
    local f42_local7 = 9.6 - f42_arg0:GetMapHitRadius(TARGET_SELF)
    local f42_local8 = 0
    local f42_local9 = 0
    local f42_local10 = f42_arg0:GetRandam_Int(1, 100)
    f42_arg1:AddSubGoal(GOAL_COMMON_ComboRepeat_SuccessAngle180, 10, 3000, TARGET_ENE_0, 9999, f42_local8, f42_local9, 0, 0)
    f42_arg1:AddSubGoal(GOAL_COMMON_ComboRepeat_SuccessAngle180, 10, 3005, TARGET_ENE_0, 9999, f42_local8, f42_local9, 0, 0)
    f42_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3006, TARGET_ENE_0, 9999, f42_local8, f42_local9, 0, 0)
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
    
end

Goal.Act47 = function (f43_arg0, f43_arg1, f43_arg2)
    local f43_local0 = f43_arg0:GetDist(TARGET_ENE_0)
    local f43_local1 = 9.6 - f43_arg0:GetMapHitRadius(TARGET_SELF)
    local f43_local2 = f43_arg0:GetRandam_Float(3, 9)
    local f43_local3 = false
    local f43_local4 = 5
    if f43_local1 < f43_local0 then
        f43_arg1:AddSubGoal(GOAL_COMMON_ApproachTarget, f43_local4, TARGET_ENE_0, f43_local1, TARGET_SELF, f43_local3, -1)
    end
    local f43_local5 = 9.6 - f43_arg0:GetMapHitRadius(TARGET_SELF)
    local f43_local6 = 9.6 - f43_arg0:GetMapHitRadius(TARGET_SELF)
    local f43_local7 = 9.6 - f43_arg0:GetMapHitRadius(TARGET_SELF)
    local f43_local8 = 0
    local f43_local9 = 0
    local f43_local10 = f43_arg0:GetRandam_Int(1, 100)
    f43_arg1:AddSubGoal(GOAL_COMMON_ComboRepeat_SuccessAngle180, 10, 3002, TARGET_ENE_0, 9999, f43_local8, f43_local9, 0, 0)
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
    
end

Goal.Act48 = function (f44_arg0, f44_arg1, f44_arg2)
    local f44_local0 = f44_arg0:GetRandam_Float(4.5, 5.5)
    local f44_local1 = f44_arg0:GetRandam_Int(30, 45)
    local f44_local2 = 3
    local f44_local3 = 0
    local f44_local4 = 3
    if InsideRange(f44_arg0, f44_arg1, 90, 180, -9999, 9999) then
        f44_arg1:AddSubGoal(GOAL_COMMON_ComboAttackTunableSpin, 10, 3026, TARGET_ENE_0, 9999, f44_local3, FrontAngle, 0, 0)
        f44_arg1:AddSubGoal(GOAL_COMMON_SidewayMove, f44_local0, TARGET_ENE_0, 0, f44_local1, true, true, -1)
    elseif InsideRange(f44_arg0, f44_arg1, -90, 180, -9999, 9999) then
        f44_arg1:AddSubGoal(GOAL_COMMON_ComboAttackTunableSpin, 10, 3026, TARGET_ENE_0, 9999, f44_local3, FrontAngle, 0, 0)
        f44_arg1:AddSubGoal(GOAL_COMMON_SidewayMove, f44_local0, TARGET_ENE_0, 1, f44_local1, true, true, -1)
    end
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
    
end

Goal.Interrupt = function (f45_arg0, f45_arg1, f45_arg2)
    local f45_local0 = f45_arg1:GetSpecialEffectActivateInterruptType(0)
    local f45_local1 = f45_arg1:GetDist(TARGET_ENE_0)
    local f45_local2 = f45_arg1:GetToTargetAngle(TARGET_ENE_0)
    local f45_local3 = f45_arg1:GetSp(TARGET_SELF)
    local f45_local4 = f45_arg1:GetRandam_Int(1, 100)
    if f45_arg1:IsLadderAct(TARGET_SELF) then
        return false
    end
    if f45_arg1:IsInterupt(INTERUPT_Inside_ObserveArea) and f45_arg1:IsInsideObserve(3) then
        f45_arg2:ClearSubGoal()
        f45_arg2:AddSubGoal(GOAL_COMMON_ComboTunable_SuccessAngle180, 10, 3015, TARGET_ENE_0, 9999, TurnTime, FrontAngle, 0, 0)
        f45_arg1:DeleteObserve(3)
        f45_arg2:AddSubGoal(GOAL_COMMON_ComboTunable_SuccessAngle180, 10, 3014, TARGET_ENE_0, 9999, TurnTime, FrontAngle, 0, 0)
        f45_arg1:DeleteObserve(3)
    end
    if f45_arg1:IsInterupt(INTERUPT_ActivateSpecialEffect) then
        if f45_arg1:GetSpecialEffectActivateInterruptType(0) == 3510020 then
            f45_arg1:AddObserveArea(1, TARGET_SELF, TARGET_ENE_0, AI_DIR_TYPE_F, 360, 15)
        elseif f45_arg1:GetSpecialEffectActivateInterruptType(0) == 5034 then
            f45_arg2:ClearSubGoal()
            f45_arg2:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 5201, TARGET_ENE_0, 999, 0, 0)
            return true
        elseif f45_arg1:GetSpecialEffectActivateInterruptType(0) == 5039 then
            f45_arg2:ClearSubGoal()
            f45_arg2:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3031, TARGET_ENE_0, 999, 0, 0)
            return true
        elseif f45_arg1:GetSpecialEffectActivateInterruptType(0) == 3510901 then
            if f45_local1 >= 35 and f45_local1 <= 40 then
                f45_arg2:ClearSubGoal()
                f45_arg2:AddSubGoal(GOAL_COMMON_ComboFinal, 1, 3028, TARGET_ENE_0, 999, 0, 0)
                return true
            end
        elseif f45_arg1:GetSpecialEffectActivateInterruptType(0) == 3510902 then
            if f45_arg1:GetTimer(4) <= 0 then
                f45_arg1:SetTimer(4, 8)
                f45_arg2:ClearSubGoal()
                f45_arg2:AddSubGoal(GOAL_COMMON_ComboFinal, 1, 3029, TARGET_ENE_0, 999, 0, 0)
                return true
            end
        elseif f45_arg1:GetSpecialEffectActivateInterruptType(0) == 3510903 then
            f45_arg2:ClearSubGoal()
            f45_arg2:AddSubGoal(GOAL_COMMON_ApproachTarget, 10, TARGET_ENE_0, 25, TARGET_SELF, false, -1)
            f45_arg2:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3007, TARGET_ENE_0, 999, 0, 0)
            return true
        elseif f45_arg1:GetSpecialEffectActivateInterruptType(0) == 3510904 then
            f45_arg2:ClearSubGoal()
            f45_arg1:SetNumber(7, 1)
            f45_arg2:AddSubGoal(GOAL_COMMON_ApproachTarget, 10, TARGET_ENE_0, 5, TARGET_SELF, false, -1)
            f45_arg2:AddSubGoal(GOAL_COMMON_ComboRepeat, 10, 3019, TARGET_ENE_0, 9999, 0)
            f45_arg2:AddSubGoal(GOAL_COMMON_ComboRepeat, 10, 3020, TARGET_ENE_0, 9999, 0)
            return true
        elseif f45_arg1:GetSpecialEffectActivateInterruptType(0) == 3510905 then
            f45_arg2:ClearSubGoal()
            if f45_local4 > 20 then
                f45_arg2:AddSubGoal(GOAL_COMMON_ApproachTarget, 5, TARGET_ENE_0, 5, TARGET_SELF, false, -1)
                f45_arg2:AddSubGoal(GOAL_COMMON_ComboRepeat, 10, 3006, TARGET_ENE_0, 9999, 0)
            else
                f45_arg2:AddSubGoal(GOAL_COMMON_ApproachTarget, 10, TARGET_ENE_0, 25, TARGET_SELF, false, -1)
                f45_arg2:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3007, TARGET_ENE_0, 999, 0, 0)
            end
            return true
        end
    end
    if f45_arg1:IsInterupt(INTERUPT_InactivateSpecialEffect) and f45_arg1:GetSpecialEffectInactivateInterruptType(0) == 3510020 then
        f45_arg1:DeleteObserve(1)
    end
    if f45_arg1:IsInterupt(INTERUPT_Inside_ObserveArea) and f45_arg1:IsInsideObserve(1) and f45_arg1:HasSpecialEffectId(TARGET_SELF, 3510020) then
        f45_arg2:ClearSubGoal()
        f45_arg1:AddTopGoal(GOAL_COMMON_AttackImmediateAction, 2, 20006, TARGET_SELF, 9999, 0, 0, 0, 0)
        f45_arg1:DeleteObserve(1)
        return true
    end
    if f45_arg1:IsInterupt(INTERUPT_Damaged) then
        return f45_arg0.Damaged(f45_arg1, f45_arg2)
    end
    return false
    
end

Goal.Damaged = function (f46_arg0, f46_arg1, f46_arg2)
    local f46_local0 = f46_arg0:GetRandam_Int(1, 100)
    local f46_local1 = f46_arg0:GetDist(TARGET_ENE_0)
    local f46_local2 = 15
    local f46_local3 = 9920
    if f46_arg0:HasSpecialEffectId(TARGET_SELF, 3510020) then
        f46_arg1:ClearSubGoal()
        f46_arg0:AddTopGoal(GOAL_COMMON_AttackImmediateAction, 2, 20006, TARGET_SELF, 9999, 0, 0, 0, 0)
        return true
    end
    
end

Goal.Kengeki_Activate = function (f47_arg0, f47_arg1, f47_arg2, f47_arg3)
    local f47_local0 = ReturnKengekiSpecialEffect(f47_arg1)
    if f47_local0 == 0 then
        return false
    end
    local f47_local1 = {}
    local f47_local2 = {}
    local f47_local3 = {}
    Common_Clear_Param(f47_local1, f47_local2, f47_local3)
    local f47_local4 = f47_arg1:GetDist(TARGET_ENE_0)
    local f47_local5 = f47_arg1:GetSp(TARGET_SELF)
    if f47_local5 <= 0 then
        f47_local1[50] = 100
    elseif f47_local0 == 200200 then
        if f47_local4 >= 10 then
            f47_local1[50] = 100
        elseif f47_local4 <= 0.2 then
            f47_local1[50] = 100
        else
            f47_local1[3] = 100
        end
    elseif f47_local0 == 200201 then
        if f47_local4 >= 10 then
            f47_local1[50] = 100
        elseif f47_local4 <= 0.2 then
            f47_local1[50] = 100
        else
            f47_local1[4] = 100
        end
    elseif f47_local0 == 200205 then
        if f47_local4 >= 10 then
            f47_local1[50] = 100
        elseif f47_local4 <= 0.2 then
            f47_local1[50] = 100
        else
            f47_local1[1] = 100
        end
    elseif f47_local0 == 200206 then
        if f47_local4 >= 10 then
            f47_local1[50] = 100
        elseif f47_local4 <= 0.2 then
            f47_local1[50] = 100
        else
            f47_local1[2] = 100
        end
    elseif f47_local0 == 200210 then
        if f47_local4 >= 10 then
            f47_local1[50] = 100
        elseif f47_local4 <= 0.2 then
            f47_local1[50] = 100
        else
            f47_local1[7] = 100
        end
    elseif f47_local0 == 200211 then
        if f47_local4 >= 10 then
            f47_local1[50] = 100
        elseif f47_local4 <= 0.2 then
            f47_local1[50] = 100
        else
            f47_local1[8] = 100
        end
    elseif f47_local0 == 200215 then
        if f47_local4 >= 10 then
            f47_local1[50] = 100
        elseif f47_local4 <= 0.2 then
            f47_local1[50] = 100
        else
            f47_local1[5] = 100
        end
    elseif f47_local0 == 200216 then
        if f47_local4 >= 10 then
            f47_local1[50] = 100
        elseif f47_local4 <= 0.2 then
            f47_local1[50] = 100
        else
            f47_local1[6] = 100
        end
    else
        f47_local1[50] = 100
    end
    f47_local2[1] = REGIST_FUNC(f47_arg1, f47_arg2, f47_arg0.Kengeki01)
    f47_local2[2] = REGIST_FUNC(f47_arg1, f47_arg2, f47_arg0.Kengeki02)
    f47_local2[3] = REGIST_FUNC(f47_arg1, f47_arg2, f47_arg0.Kengeki03)
    f47_local2[4] = REGIST_FUNC(f47_arg1, f47_arg2, f47_arg0.Kengeki04)
    f47_local2[5] = REGIST_FUNC(f47_arg1, f47_arg2, f47_arg0.Kengeki05)
    f47_local2[6] = REGIST_FUNC(f47_arg1, f47_arg2, f47_arg0.Kengeki06)
    f47_local2[7] = REGIST_FUNC(f47_arg1, f47_arg2, f47_arg0.Kengeki07)
    f47_local2[8] = REGIST_FUNC(f47_arg1, f47_arg2, f47_arg0.Kengeki08)
    f47_local2[50] = REGIST_FUNC(f47_arg1, f47_arg2, f47_arg0.NoAction)
    local f47_local6 = REGIST_FUNC(f47_arg1, f47_arg2, f47_arg0.ActAfter_AdjustSpace)
    Common_Kengeki_Activate(f47_arg1, f47_arg2, f47_local1, f47_local2, f47_local6, f47_local3)
    
end

Goal.Kengeki01 = function (f48_arg0, f48_arg1, f48_arg2)
    f48_arg1:ClearSubGoal()
    f48_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 1, 3050, TARGET_ENE_0, 9999, 0, 0)
    
end

Goal.Kengeki02 = function (f49_arg0, f49_arg1, f49_arg2)
    f49_arg1:ClearSubGoal()
    f49_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 1, 3055, TARGET_ENE_0, 9999, 0, 0)
    
end

Goal.Kengeki03 = function (f50_arg0, f50_arg1, f50_arg2)
    f50_arg1:ClearSubGoal()
    f50_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 1, 3060, TARGET_ENE_0, 9999, 0, 0)
    
end

Goal.Kengeki04 = function (f51_arg0, f51_arg1, f51_arg2)
    f51_arg1:ClearSubGoal()
    f51_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 1, 3065, TARGET_ENE_0, 9999, 0, 0)
    
end

Goal.Kengeki05 = function (f52_arg0, f52_arg1, f52_arg2)
    f52_arg1:ClearSubGoal()
    f52_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 1, 3070, TARGET_ENE_0, 9999, 0, 0)
    
end

Goal.Kengeki06 = function (f53_arg0, f53_arg1, f53_arg2)
    f53_arg1:ClearSubGoal()
    f53_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 1, 3075, TARGET_ENE_0, 9999, 0, 0)
    
end

Goal.Kengeki07 = function (f54_arg0, f54_arg1, f54_arg2)
    f54_arg1:ClearSubGoal()
    f54_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 1, 3085, TARGET_ENE_0, 9999, 0, 0)
    
end

Goal.Kengeki08 = function (f55_arg0, f55_arg1, f55_arg2)
    f55_arg1:ClearSubGoal()
    f55_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 1, 3085, TARGET_ENE_0, 9999, 0, 0)
    
end

Goal.NoAction = function (f56_arg0, f56_arg1, f56_arg2)
    return -1
    
end

Goal.ActAfter_AdjustSpace = function (f57_arg0, f57_arg1, f57_arg2)
    
end

Goal.Update = function (f58_arg0, f58_arg1, f58_arg2)
    return Update_Default_NoSubGoal(f58_arg0, f58_arg1, f58_arg2)
    
end

Goal.Terminate = function (f59_arg0, f59_arg1, f59_arg2)
    
end


