RegisterTableGoal(GOAL_Kibamusya508000_Battle, "GOAL_Kibamusya508000_Battle")
REGISTER_GOAL_NO_UPDATE(GOAL_Kibamusya508000_Battle, true)

Goal.Initialize = function (f1_arg0, f1_arg1, f1_arg2, f1_arg3)
    
end

Goal.Activate = function (f2_arg0, f2_arg1, f2_arg2)
    Init_Pseudo_Global(f2_arg1, f2_arg2)
    local f2_local0 = {}
    local f2_local1 = {}
    local f2_local2 = {}
    Common_Clear_Param(f2_local0, f2_local1, f2_local2)
    local f2_local3 = f2_arg1:GetHpRate(TARGET_SELF)
    local f2_local4 = f2_arg1:GetSp(TARGET_SELF)
    local f2_local5 = f2_arg1:GetDist(TARGET_ENE_0)
    local f2_local6 = f2_arg1:GetExcelParam(AI_EXCEL_THINK_PARAM_TYPE__thinkAttr_doAdmirer)
    local f2_local7 = f2_arg1:GetEventRequest()
    local f2_local8 = true
    local f2_local9 = f2_arg1:GetNinsatsuNum()
    f2_arg1:AddObserveSpecialEffectAttribute(TARGET_SELF, 5026)
    f2_arg1:AddObserveSpecialEffectAttribute(TARGET_SELF, 5027)
    f2_arg1:AddObserveSpecialEffectAttribute(TARGET_SELF, 5028)
    f2_arg1:AddObserveSpecialEffectAttribute(TARGET_SELF, 5029)
    f2_arg1:AddObserveSpecialEffectAttribute(TARGET_SELF, 5030)
    f2_arg1:AddObserveSpecialEffectAttribute(TARGET_SELF, 5031)
    f2_arg1:AddObserveSpecialEffectAttribute(TARGET_SELF, 5032)
    f2_arg1:AddObserveSpecialEffectAttribute(TARGET_SELF, 5033)
    f2_arg1:AddObserveSpecialEffectAttribute(TARGET_SELF, 5034)
    f2_arg1:AddObserveSpecialEffectAttribute(TARGET_SELF, 3508050)
    f2_arg1:AddObserveSpecialEffectAttribute(TARGET_SELF, 3508080)
    f2_arg1:AddObserveSpecialEffectAttribute(TARGET_ENE_0, 3508510)
    f2_arg1:AddObserveSpecialEffectAttribute(TARGET_SELF, 105100)
    f2_arg1:AddObserveSpecialEffectAttribute(TARGET_ENE_0, 100401)
    f2_arg1:AddObserveSpecialEffectAttribute(TARGET_ENE_0, 3508040)
    f2_arg1:DeleteObserveSpecialEffectAttribute(TARGET_SELF, 3508520)
    f2_arg1:DeleteObserve(0)
    f2_arg1:DeleteObserve(1)
    f2_arg1:DeleteObserve(2)
    f2_arg1:DeleteObserve(4)
    f2_arg1:SetNumber(8, 0)
    if f2_arg0.Kengeki_Activate(f2_arg0, f2_arg1, f2_arg2) then
        return
    end
    if f2_arg1:HasSpecialEffectId(TARGET_SELF, 3508000) then
        f2_local8 = true
    else
        f2_local8 = false
    end
    if f2_arg1:IsFinishTimer(2) == true then
        f2_arg1:SetNumber(2, 0)
    end
    if f2_local7 == 1 and f2_arg1:GetNumber(7) ~= 2 then
        f2_local0[34] = 100
    elseif f2_arg1:HasSpecialEffectId(TARGET_SELF, 3508530) and f2_local5 >= 4 then
        f2_local0[22] = 100
    elseif f2_arg1:HasSpecialEffectId(TARGET_ENE_0, 110060) or f2_arg1:HasSpecialEffectId(TARGET_ENE_0, 110010) then
        if f2_arg1:HasSpecialEffectId(TARGET_SELF, 3508000) then
            f2_local0[32] = 100
        else
            f2_local0[28] = 100
        end
    elseif f2_arg1:HasSpecialEffectId(TARGET_ENE_0, 110015) then
        f2_local0[30] = 100
    elseif f2_arg1:HasSpecialEffectId(TARGET_SELF, 3508090) then
        f2_local0[30] = 100
        f2_local0[33] = 100
    elseif f2_local8 == true then
        if f2_arg1:IsFinishTimer(8) == true then
            if f2_local5 <= 10 then
                f2_local0[30] = 40
            else
                f2_local0[31] = 60
            end
        end
        f2_local0[12] = 60
        f2_local0[25] = 0
        f2_local0[3] = 60
        if f2_local9 <= 1 then
            f2_local0[25] = 120
        end
    elseif f2_arg1:IsInsideTarget(TARGET_ENE_0, AI_DIR_TYPE_R, 90) or f2_arg1:IsInsideTarget(TARGET_ENE_0, AI_DIR_TYPE_F, 90) then
        if f2_local5 >= 10 then
            f2_local0[3] = 5
        elseif f2_local5 >= 7 then
            f2_local0[30] = 1
            f2_local0[33] = 5
            f2_local0[10] = 50
            f2_local0[11] = 50
            f2_local0[42] = 50
            if f2_local5 <= 9 then
                f2_local0[9] = 50
            end
        elseif f2_local5 >= 4 then
            f2_local0[9] = 50
            f2_local0[30] = 1
            f2_local0[33] = 5
            f2_local0[10] = 50
            f2_local0[11] = 50
            f2_local0[42] = 50
        else
            f2_local0[1] = 50
            f2_local0[2] = 100
            f2_local0[35] = 50
            f2_local0[37] = 150
            f2_local0[42] = 50
            if f2_local5 <= 2 and f2_local9 <= 1 then
                f2_local0[46] = 120
            end
            if f2_arg1:IsInsideTarget(TARGET_ENE_0, AI_DIR_TYPE_R, 90) then
                f2_local0[13] = 50
            end
        end
    elseif f2_arg1:IsInsideTarget(TARGET_ENE_0, AI_DIR_TYPE_L, 90) then
        if f2_local5 >= 3 then
            f2_local0[30] = 50
            f2_local0[33] = 20
        else
            f2_local0[4] = 100
        end
    elseif f2_arg1:IsInsideTarget(TARGET_ENE_0, AI_DIR_TYPE_B, 90) then
        if f2_local5 >= 5 then
            f2_local0[30] = 50
            f2_local0[33] = 20
        elseif f2_arg1:IsInsideTarget(TARGET_ENE_0, AI_DIR_TYPE_R, 180) then
            f2_local0[8] = 100
            f2_local0[13] = 100
            f2_local0[16] = 100
        else
            f2_local0[4] = 100
            f2_local0[8] = 100
        end
    else
        f2_local0[33] = 20
    end
    if f2_arg1:IsFinishTimer(10) == false then
        f2_local0[25] = 0
    end
    if f2_arg1:IsFinishTimer(3) == false or f2_local5 >= 2 then
        f2_local0[36] = 0
    end
    if f2_local5 <= 1.2 then
        f2_local0[42] = 0
    end
    f2_arg1:SetStringIndexedNumber(" targetDist ", f2_local5)
    f2_arg1:SetStringIndexedNumber(" targetAngle ", f2_arg1:GetToTargetAngle(TARGET_ENE_0))
    f2_arg1:SetStringIndexedNumber(" running ", f2_local8)
    local f2_local10 = f2_arg1:GetRandam_Int(8, 20)
    f2_local0[1] = SetCoolTime(f2_arg1, f2_arg2, 3000, 5, f2_local0[1], 1)
    f2_local0[2] = SetCoolTime(f2_arg1, f2_arg2, 3070, 5, f2_local0[2], 1)
    f2_local0[3] = SetCoolTime(f2_arg1, f2_arg2, 3024, 5, f2_local0[3], 1)
    f2_local0[8] = SetCoolTime(f2_arg1, f2_arg2, 3007, 10, f2_local0[8], 1)
    f2_local0[9] = SetCoolTime(f2_arg1, f2_arg2, 3008, 5, f2_local0[9], 1)
    f2_local0[10] = SetCoolTime(f2_arg1, f2_arg2, 3009, 60, f2_local0[10], 1)
    f2_local0[11] = SetCoolTime(f2_arg1, f2_arg2, 3010, 60, f2_local0[11], 1)
    f2_local0[12] = SetCoolTime(f2_arg1, f2_arg2, 3011, 20, f2_local0[12], 1)
    f2_local0[13] = SetCoolTime(f2_arg1, f2_arg2, 3089, 20, f2_local0[13], 1)
    f2_local0[14] = SetCoolTime(f2_arg1, f2_arg2, 3015, 20, f2_local0[14], 1)
    f2_local0[16] = SetCoolTime(f2_arg1, f2_arg2, 3023, 5, f2_local0[16], 1)
    f2_local0[18] = SetCoolTime(f2_arg1, f2_arg2, 3025, 5, f2_local0[18], 1)
    f2_local0[19] = SetCoolTime(f2_arg1, f2_arg2, 3026, 3, f2_local0[19], 1)
    f2_local0[25] = SetCoolTime(f2_arg1, f2_arg2, 5010, 45, f2_local0[25], 1)
    f2_local0[30] = SetCoolTime(f2_arg1, f2_arg2, 5010, 5, f2_local0[30], 1)
    f2_local0[31] = SetCoolTime(f2_arg1, f2_arg2, 3032, 15, f2_local0[31], 1)
    f2_local0[31] = SetCoolTime(f2_arg1, f2_arg2, 3033, 15, f2_local0[31], 1)
    f2_local0[35] = SetCoolTime(f2_arg1, f2_arg2, 3029, 8, f2_local0[35], 1)
    f2_local0[36] = SetCoolTime(f2_arg1, f2_arg2, 3064, 20, f2_local0[36], 1)
    f2_local0[37] = SetCoolTime(f2_arg1, f2_arg2, 3084, f2_local10, f2_local0[37], 1)
    f2_local0[42] = SetCoolTime(f2_arg1, f2_arg2, 3039, 5, f2_local0[42], 1)
    f2_local0[45] = SetCoolTime(f2_arg1, f2_arg2, 3096, 8, f2_local0[45], 1)
    f2_local0[45] = SetCoolTime(f2_arg1, f2_arg2, 3096, 8, f2_local0[45], 1)
    f2_local0[46] = SetCoolTime(f2_arg1, f2_arg2, 3045, 45, f2_local0[46], 1)
    f2_local1[1] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act01)
    f2_local1[2] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act02)
    f2_local1[3] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act03)
    f2_local1[4] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act04)
    f2_local1[5] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act05)
    f2_local1[6] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act06)
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
    f2_local1[49] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act49)
    local f2_local11 = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.ActAfter_AdjustSpace)
    Common_Battle_Activate(f2_arg1, f2_arg2, f2_local0, f2_local1, f2_local11, f2_local2)
    
end

Goal.Act01 = function (f3_arg0, f3_arg1, f3_arg2)
    local f3_local0 = 3.5 - f3_arg0:GetMapHitRadius(TARGET_SELF)
    local f3_local1 = 3.5 - f3_arg0:GetMapHitRadius(TARGET_SELF) + 99
    local f3_local2 = 3.5 - f3_arg0:GetMapHitRadius(TARGET_SELF) + 100
    local f3_local3 = 100
    local f3_local4 = 0
    local f3_local5 = 1.5
    local f3_local6 = 3
    if f3_arg0:IsInsideTarget(TARGET_ENE_0, AI_DIR_TYPE_L, 180) or f3_arg0:IsInsideTarget(TARGET_ENE_0, AI_DIR_TYPE_B, 60) then
        f3_arg1:AddSubGoal(GOAL_COMMON_ApproachSettingDirection, 0.1, TARGET_ENE_0, 0, TARGET_SELF, false, -1, AI_DIR_TYPE_ToL, 3)
    end
    local f3_local7 = 3
    local f3_local8 = 45
    local f3_local9 = 3000
    local f3_local10 = 0
    local f3_local11 = 0
    f3_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 10, f3_local9, TARGET_ENE_0, 9999, f3_local10, f3_local11, 0, 0)
    f3_arg0:SetNumber(5, 1)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act02 = function (f4_arg0, f4_arg1, f4_arg2)
    local f4_local0 = 3070
    local f4_local1 = 0
    local f4_local2 = 0
    f4_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 10, f4_local0, TARGET_ENE_0, 9999, f4_local1, f4_local2, 0, 0)
    f4_arg0:SetNumber(5, 2)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

--Approach
Goal.Act03 = function (f5_arg0, f5_arg1, f5_arg2)
    local f5_local0 = 8 - f5_arg0:GetMapHitRadius(TARGET_SELF)
    local f5_local1 = 8 - f5_arg0:GetMapHitRadius(TARGET_SELF) + 0
    local f5_local2 = 8 - f5_arg0:GetMapHitRadius(TARGET_SELF) + 2
    local f5_local3 = 100
    local f5_local4 = 0
    local f5_local5 = 1.5
    local f5_local6 = 3
    Approach_Act_Flex(f5_arg0, f5_arg1, f5_local0, f5_local1, f5_local2, f5_local3, f5_local4, f5_local5, f5_local6)
    local f5_local7 = 3038
    local f5_local8 = 0
    local f5_local9 = 0
    f5_arg1:AddSubGoal(GOAL_COMMON_ComboTunable_SuccessAngle180, 10, 3024, TARGET_ENE_0, 3.5, f5_local8, f5_local9, 0, 0)
    f5_arg1:AddSubGoal(GOAL_COMMON_ComboRepeat_SuccessAngle180, 10, 3082, TARGET_ENE_0, 3, 0, 0)
    f5_arg1:AddSubGoal(GOAL_COMMON_ComboRepeat_SuccessAngle180, 10, 3083, TARGET_ENE_0, 5, 0, 0)
    f5_arg1:AddSubGoal(GOAL_COMMON_ComboRepeat_SuccessAngle180, 10, 3084, TARGET_ENE_0, 9999, 0, 0)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act04 = function (f6_arg0, f6_arg1, f6_arg2)
    local f6_local0 = 5.9 - f6_arg0:GetMapHitRadius(TARGET_SELF)
    local f6_local1 = 5.9 - f6_arg0:GetMapHitRadius(TARGET_SELF) + 0
    local f6_local2 = 5.9 - f6_arg0:GetMapHitRadius(TARGET_SELF) + 2
    local f6_local3 = 100
    local f6_local4 = 0
    local f6_local5 = 1.5
    local f6_local6 = 3
    local f6_local7 = 3003
    local f6_local8 = 0
    local f6_local9 = 0
    f6_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 10, f6_local7, TARGET_ENE_0, 9999, f6_local8, f6_local9, 0, 0)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act05 = function (f7_arg0, f7_arg1, f7_arg2)
    local f7_local0 = 4.6 - f7_arg0:GetMapHitRadius(TARGET_SELF)
    local f7_local1 = 4.6 - f7_arg0:GetMapHitRadius(TARGET_SELF) + 0
    local f7_local2 = 4.6 - f7_arg0:GetMapHitRadius(TARGET_SELF) + 2
    local f7_local3 = 100
    local f7_local4 = 0
    local f7_local5 = 1.5
    local f7_local6 = 3
    local f7_local7 = 3004
    local f7_local8 = 0
    local f7_local9 = 0
    f7_arg1:AddSubGoal(GOAL_COMMON_ComboTunable_SuccessAngle180, 10, 3004, TARGET_ENE_0, 9999, f7_local8, f7_local9, 0, 0)
    f7_arg1:AddSubGoal(GOAL_COMMON_ApproachSettingDirection, 0.5, TARGET_SELF, 2, TARGET_SELF, false, -1, AI_DIR_TYPE_F, f7_arg0:GetRandam_Float(8, 10)):TimingSetNumber(0, 1, AI_TIMING_SET__UPDATE_SUCCESS)
    f7_arg0:SetNumber(5, 5)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act06 = function (f8_arg0, f8_arg1, f8_arg2)
    local f8_local0 = f8_arg0:GetDist(TARGET_ENE_0)
    local f8_local1 = 14 - f8_arg0:GetMapHitRadius(TARGET_SELF)
    local f8_local2 = 14 - f8_arg0:GetMapHitRadius(TARGET_SELF) + 0
    local f8_local3 = 14 - f8_arg0:GetMapHitRadius(TARGET_SELF) + 2
    local f8_local4 = 100
    local f8_local5 = 0
    local f8_local6 = 1.5
    local f8_local7 = 3
    if not f8_arg0:HasSpecialEffectId(TARGET_SELF, 3508000) then
        f8_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 10, 3030, TARGET_ENE_0, 9999, 0, 0, 0, 0)
    end
    if f8_local0 >= 12 and f8_arg0:IsInsideTarget(TARGET_ENE_0, AI_DIR_TYPE_B, 90) then
        if f8_arg0:IsInsideTarget(TARGET_ENE_0, AI_DIR_TYPE_R, 90) then
            f8_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 10, 3032, TARGET_ENE_0, 9999, 0, 0, 0, 0)
        else
            f8_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 10, 3033, TARGET_ENE_0, 9999, 0, 0, 0, 0)
        end
    end
    f8_arg1:AddSubGoal(GOAL_COMMON_ApproachSettingDirection, 1, TARGET_ENE_0, 2, TARGET_ENE_0, false, -1, AI_DIR_TYPE_ToL, 3)
    local f8_local8 = 3005
    local f8_local9 = 0
    local f8_local10 = 0
    f8_arg0:AddObserveArea(0, TARGET_SELF, TARGET_ENE_0, AI_DIR_TYPE_F, 90, 16)
    f8_arg0:SetNumber(5, 6)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act07 = function (f9_arg0, f9_arg1, f9_arg2)
    local f9_local0 = 4.5 - f9_arg0:GetMapHitRadius(TARGET_SELF)
    local f9_local1 = 4.5 - f9_arg0:GetMapHitRadius(TARGET_SELF) + 0
    local f9_local2 = 4.5 - f9_arg0:GetMapHitRadius(TARGET_SELF) + 2
    local f9_local3 = 100
    local f9_local4 = 0
    local f9_local5 = 1.5
    local f9_local6 = 3
    local f9_local7 = 3006
    local f9_local8 = 0
    local f9_local9 = 0
    f9_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 10, f9_local7, TARGET_ENE_0, 9999, f9_local8, f9_local9, 0, 0)
    f9_arg0:SetNumber(5, 7)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act08 = function (f10_arg0, f10_arg1, f10_arg2)
    local f10_local0 = 4.5 - f10_arg0:GetMapHitRadius(TARGET_SELF)
    local f10_local1 = 4.5 - f10_arg0:GetMapHitRadius(TARGET_SELF) + 0
    local f10_local2 = 4.5 - f10_arg0:GetMapHitRadius(TARGET_SELF) + 2
    local f10_local3 = 100
    local f10_local4 = 0
    local f10_local5 = 1.5
    local f10_local6 = 3
    local f10_local7 = 3007
    local f10_local8 = 0
    local f10_local9 = 0
    f10_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 10, f10_local7, TARGET_ENE_0, 9999, f10_local8, f10_local9, 0, 0)
    f10_arg0:SetNumber(5, 8)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act09 = function (f11_arg0, f11_arg1, f11_arg2)
    local f11_local0 = 3008
    local f11_local1 = 0
    local f11_local2 = 0
    f11_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 10, f11_local0, TARGET_ENE_0, 9999, f11_local1, f11_local2, 0, 0)
    f11_arg0:SetNumber(5, 9)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act10 = function (f12_arg0, f12_arg1, f12_arg2)
    local f12_local0 = 50 - f12_arg0:GetMapHitRadius(TARGET_SELF)
    local f12_local1 = 50 - f12_arg0:GetMapHitRadius(TARGET_SELF) + 0
    local f12_local2 = 50 - f12_arg0:GetMapHitRadius(TARGET_SELF) + 2
    local f12_local3 = 100
    local f12_local4 = 0
    local f12_local5 = 1.5
    local f12_local6 = 3
    if f12_arg0:HasSpecialEffectId(TARGET_SELF, 3508000) then
        f12_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 10, 3031, TARGET_ENE_0, 9999, 0, 0, 0, 0)
    end
    local f12_local7 = 3009
    local f12_local8 = 0
    local f12_local9 = 0
    f12_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 10, f12_local7, TARGET_ENE_0, 9999, f12_local8, f12_local9, 0, 0)
    f12_arg0:SetNumber(5, 10)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act11 = function (f13_arg0, f13_arg1, f13_arg2)
    local f13_local0 = 4.5 - f13_arg0:GetMapHitRadius(TARGET_SELF)
    local f13_local1 = 4.5 - f13_arg0:GetMapHitRadius(TARGET_SELF) + 0
    local f13_local2 = 4.5 - f13_arg0:GetMapHitRadius(TARGET_SELF) + 2
    local f13_local3 = 100
    local f13_local4 = 0
    local f13_local5 = 1.5
    local f13_local6 = 3
    if f13_arg0:HasSpecialEffectId(TARGET_SELF, 3508000) then
        f13_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 10, 3031, TARGET_ENE_0, 9999, 0, 0, 0, 0)
    end
    local f13_local7 = 3010
    local f13_local8 = 0
    local f13_local9 = 0
    f13_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 10, f13_local7, TARGET_ENE_0, 9999, f13_local8, f13_local9, 0, 0)
    f13_arg0:SetNumber(5, 11)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act12 = function (f14_arg0, f14_arg1, f14_arg2)
    local f14_local0 = f14_arg0:GetDist(TARGET_ENE_0)
    local f14_local1 = f14_local0 - 2
    local f14_local2 = 4.5 - f14_arg0:GetMapHitRadius(TARGET_SELF) + 0
    local f14_local3 = 4.5 - f14_arg0:GetMapHitRadius(TARGET_SELF) + 2
    local f14_local4 = 100
    local f14_local5 = 0
    local f14_local6 = 1.5
    local f14_local7 = 3
    if not f14_arg0:HasSpecialEffectId(TARGET_SELF, 3508000) then
        f14_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 10, 3030, TARGET_ENE_0, 9999, 0, 0, 0, 0)
    end
    if f14_local0 >= 12 and f14_arg0:IsInsideTarget(TARGET_ENE_0, AI_DIR_TYPE_B, 120) then
        if f14_arg0:IsInsideTarget(TARGET_ENE_0, AI_DIR_TYPE_R, 90) then
            f14_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 10, 3032, TARGET_ENE_0, 9999, 0, 0, 0, 0)
        else
            f14_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 10, 3033, TARGET_ENE_0, 9999, 0, 0, 0, 0)
        end
    end
    local f14_local8 = 3011
    local f14_local9 = 0
    local f14_local10 = 0
    f14_arg1:AddSubGoal(GOAL_COMMON_ComboTunable_SuccessAngle180, 10, 3011, TARGET_ENE_0, 9999, f14_local9, f14_local10, 0, 0)
    f14_arg1:AddSubGoal(GOAL_COMMON_ComboRepeat_SuccessAngle180, 10, 3012, TARGET_ENE_0, 9999, 0, 0)
    f14_arg1:AddSubGoal(GOAL_COMMON_ComboRepeat_SuccessAngle180, 10, 3013, TARGET_ENE_0, 9999, 0, 0)
    f14_arg0:SetNumber(5, 12)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act13 = function (f15_arg0, f15_arg1, f15_arg2)
    f15_arg1:AddSubGoal(GOAL_COMMON_ComboRepeat_SuccessAngle180, 10, 3089, TARGET_ENE_0, 3, 0, 0, 0, 0)
    
end

Goal.Act14 = function (f16_arg0, f16_arg1, f16_arg2)
    local f16_local0 = f16_arg0:GetDist(TARGET_ENE_0)
    local f16_local1 = 4.5 - f16_arg0:GetMapHitRadius(TARGET_SELF)
    local f16_local2 = 4.5 - f16_arg0:GetMapHitRadius(TARGET_SELF) + 0
    local f16_local3 = 4.5 - f16_arg0:GetMapHitRadius(TARGET_SELF) + 2
    local f16_local4 = 100
    local f16_local5 = 0
    local f16_local6 = 1.5
    local f16_local7 = 3
    if not f16_arg0:HasSpecialEffectId(TARGET_SELF, 3508000) then
        f16_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 10, 3030, TARGET_ENE_0, 9999, 0, 0, 0, 0)
    end
    if f16_local0 >= 12 and f16_arg0:IsInsideTarget(TARGET_ENE_0, AI_DIR_TYPE_B, 120) then
        if f16_arg0:IsInsideTarget(TARGET_ENE_0, AI_DIR_TYPE_R, 90) then
            f16_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 10, 3032, TARGET_ENE_0, 9999, 0, 0, 0, 0)
        else
            f16_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 10, 3033, TARGET_ENE_0, 9999, 0, 0, 0, 0)
        end
    end
    local f16_local8 = 3015
    local f16_local9 = 0
    local f16_local10 = 0
    f16_arg1:AddSubGoal(GOAL_COMMON_ComboTunable_SuccessAngle180, 10, 3015, TARGET_ENE_0, 9999, f16_local9, f16_local10, 0, 0)
    f16_arg1:AddSubGoal(GOAL_COMMON_ComboRepeat_SuccessAngle180, 10, 3016, TARGET_ENE_0, 9999, 0, 0)
    f16_arg1:AddSubGoal(GOAL_COMMON_ComboRepeat_SuccessAngle180, 10, 3016, TARGET_ENE_0, 9999, 0, 0)
    f16_arg1:AddSubGoal(GOAL_COMMON_ComboRepeat_SuccessAngle180, 10, 3016, TARGET_ENE_0, 9999, 0, 0)
    f16_arg1:AddSubGoal(GOAL_COMMON_ComboRepeat_SuccessAngle180, 10, 3016, TARGET_ENE_0, 9999, 0, 0)
    f16_arg0:AddObserveArea(2, TARGET_SELF, TARGET_ENE_0, AI_DIR_TYPE_F, 360, 3)
    f16_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3017, TARGET_ENE_0, 9999, 0, 0)
    f16_arg0:SetNumber(5, 14)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act15 = function (f17_arg0, f17_arg1, f17_arg2)
    local f17_local0 = 30 - f17_arg0:GetMapHitRadius(TARGET_SELF)
    local f17_local1 = 30 - f17_arg0:GetMapHitRadius(TARGET_SELF) + 0
    local f17_local2 = 30 - f17_arg0:GetMapHitRadius(TARGET_SELF) + 2
    local f17_local3 = 100
    local f17_local4 = 0
    local f17_local5 = 1.5
    local f17_local6 = 3
    Approach_Act_Flex(f17_arg0, f17_arg1, f17_local0, f17_local1, f17_local2, f17_local3, f17_local4, f17_local5, f17_local6)
    local f17_local7 = 3016
    local f17_local8 = 0
    local f17_local9 = 0
    f17_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 10, 3018, TARGET_ENE_0, 9999, f17_local8, f17_local9, 0, 0)
    f17_arg0:SetNumber(5, 15)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act16 = function (f18_arg0, f18_arg1, f18_arg2)
    f18_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 10, 3001, TARGET_ENE_0, 9999, TurnTime, FrontAngle, 0, 0)
    f18_arg0:SetNumber(5, 16)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act17 = function (f19_arg0, f19_arg1, f19_arg2)
    local f19_local0 = f19_arg0:GetDist(TARGET_ENE_0)
    local f19_local1 = 14 - f19_arg0:GetMapHitRadius(TARGET_SELF)
    local f19_local2 = 14 - f19_arg0:GetMapHitRadius(TARGET_SELF) + 0
    local f19_local3 = 14 - f19_arg0:GetMapHitRadius(TARGET_SELF) + 2
    local f19_local4 = 100
    local f19_local5 = 0
    local f19_local6 = 1.5
    local f19_local7 = 3
    if not f19_arg0:HasSpecialEffectId(TARGET_SELF, 3508000) then
        f19_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 10, 3030, TARGET_ENE_0, 9999, 0, 0, 0, 0)
    end
    f19_arg1:AddSubGoal(GOAL_COMMON_ApproachTarget, 10, TARGET_ENE_0, 16, TARGET_SELF, false, -1)
    local f19_local8 = 3005
    local f19_local9 = 0
    local f19_local10 = 0
    f19_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 10, f19_local8, TARGET_ENE_0, 9999, f19_local9, f19_local10, 0, 0)
    f19_arg0:SetNumber(5, 17)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act18 = function (f20_arg0, f20_arg1, f20_arg2)
    local f20_local0 = 0
    local f20_local1 = 0
    f20_arg1:AddSubGoal(GOAL_COMMON_ApproachTarget, 10, TARGET_ENE_0, 9, TARGET_SELF, false, -1)
    f20_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 10, 3024, TARGET_ENE_0, 9999, f20_local0, f20_local1, 0, 0)
    f20_arg0:SetNumber(5, 18)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act19 = function (f21_arg0, f21_arg1, f21_arg2)
    local f21_local0 = 0
    local f21_local1 = 0
    f21_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 10, 3026, TARGET_ENE_0, 9999, f21_local0, f21_local1, 0, 0)
    f21_arg0:SetNumber(5, 19)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act20 = function (f22_arg0, f22_arg1, f22_arg2)
    local f22_local0 = 4.5 - f22_arg0:GetMapHitRadius(TARGET_SELF)
    local f22_local1 = 4.5 - f22_arg0:GetMapHitRadius(TARGET_SELF) + 0
    local f22_local2 = 4.5 - f22_arg0:GetMapHitRadius(TARGET_SELF) + 2
    local f22_local3 = 100
    local f22_local4 = 0
    local f22_local5 = 1.5
    local f22_local6 = 3
    Approach_Act_Flex(f22_arg0, f22_arg1, f22_local0, f22_local1, f22_local2, f22_local3, f22_local4, f22_local5, f22_local6)
    local f22_local7 = 3027
    local f22_local8 = 0
    local f22_local9 = 0
    f22_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 10, 3027, TARGET_ENE_0, 9999, f22_local8, f22_local9, 0, 0)
    f22_arg0:SetNumber(5, 20)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act22 = function (f23_arg0, f23_arg1, f23_arg2)
    if not f23_arg0:HasSpecialEffectId(TARGET_SELF, 3508000) then
        f23_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 10, 3030, TARGET_ENE_0, 9999, 0, 0, 0, 0)
    end
    f23_arg0:SetEventMoveTarget(1102847)
    f23_arg1:AddSubGoal(GOAL_COMMON_ApproachTarget, 5, POINT_EVENT, 2, TARGET_SELF, false, -1)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act30 = function (f24_arg0, f24_arg1, f24_arg2)
    local f24_local0 = f24_arg0:GetDist(TARGET_ENE_0)
    local f24_local1 = 4.6 - f24_arg0:GetMapHitRadius(TARGET_SELF)
    local f24_local2 = 4.6 - f24_arg0:GetMapHitRadius(TARGET_SELF) + 0
    local f24_local3 = 4.6 - f24_arg0:GetMapHitRadius(TARGET_SELF) + 2
    local f24_local4 = 100
    local f24_local5 = 0
    local f24_local6 = 1.5
    local f24_local7 = 3
    local f24_local8 = f24_arg0:GetRandam_Int(1, 100)
    if f24_local0 <= 10 and f24_arg0:IsInsideTarget(TARGET_ENE_0, AI_DIR_TYPE_B, 90) and f24_local8 <= 0 then
        if f24_arg0:IsInsideTarget(TARGET_ENE_0, AI_DIR_TYPE_R, 90) then
            f24_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 10, 3032, TARGET_ENE_0, 9999, 0, 0, 0, 0)
        else
            f24_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 10, 3033, TARGET_ENE_0, 9999, 0, 0, 0, 0)
        end
        f24_arg1:AddSubGoal(GOAL_COMMON_EndureAttack, 10, 3014, TARGET_ENE_0, 9999, 0)
    else
        if not f24_arg0:HasSpecialEffectId(TARGET_SELF, 3508000) then
            f24_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 10, 3030, TARGET_ENE_0, 9999, 0, 0, 0, 0)
        end
        if f24_local8 <= 50 then
            f24_arg1:AddSubGoal(GOAL_COMMON_ApproachSettingDirection, f24_arg0:GetRandam_Float(1, 1.5), TARGET_ENE_0, 20000000, TARGET_ENE_0, false, -1, AI_DIR_TYPE_ToR, f24_arg0:GetRandam_Float(20000, 20000))
        else
            f24_arg1:AddSubGoal(GOAL_COMMON_ApproachSettingDirection, f24_arg0:GetRandam_Float(1, 1.5), TARGET_ENE_0, 20000000, TARGET_ENE_0, false, -1, AI_DIR_TYPE_ToL, f24_arg0:GetRandam_Float(2000, 2000))
        end
        f24_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 10, 3033, TARGET_ENE_0, 9999, 0, 0, 0, 0)
    end
    f24_arg0:SetNumber(5, 30)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act31 = function (f25_arg0, f25_arg1, f25_arg2)
    if not f25_arg0:HasSpecialEffectId(TARGET_SELF, 3508000) then
        f25_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 10, 3030, TARGET_ENE_0, 9999, 0, 0, 0, 0)
    end
    local f25_local0 = f25_arg0:GetRandam_Int(1, 100)
    if f25_arg0:IsInsideTarget(TARGET_ENE_0, AI_DIR_TYPE_R, 90) then
        f25_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 10, 3032, TARGET_ENE_0, 9999, 0, 0, 0, 0)
    else
        f25_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 10, 3033, TARGET_ENE_0, 9999, 0, 0, 0, 0)
    end
    f25_arg0:SetNumber(5, 31)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act32 = function (f26_arg0, f26_arg1, f26_arg2)
    f26_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 10, 3031, TARGET_ENE_0, 9999, 0, 0, 0, 0):TimingSetTimer(3, 25, UPDATE_SUCCESS)
    f26_arg0:SetNumber(5, 32)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act33 = function (f27_arg0, f27_arg1, f27_arg2)
    if not f27_arg0:HasSpecialEffectId(TARGET_SELF, 3508000) then
        f27_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 10, 3030, TARGET_ENE_0, 9999, 0, 0, 0, 0)
    end
    f27_arg1:AddSubGoal(GOAL_COMMON_ApproachSettingDirection, 10, TARGET_SELF, 2, TARGET_SELF, true, 9910, AI_DIR_TYPE_ToR, 5)
    if f27_arg0:IsInsideTarget(TARGET_ENE_0, AI_DIR_TYPE_R, 90) then
        f27_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 10, 3032, TARGET_ENE_0, 9999, 0, 0, 0, 0)
    else
        f27_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 10, 3033, TARGET_ENE_0, 9999, 0, 0, 0, 0)
    end
    f27_arg0:SetNumber(5, 33)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act34 = function (f28_arg0, f28_arg1, f28_arg2)
    local f28_local0 = f28_arg0:GetDist(TARGET_ENE_0)
    local f28_local1 = 4.6 - f28_arg0:GetMapHitRadius(TARGET_SELF)
    local f28_local2 = 4.6 - f28_arg0:GetMapHitRadius(TARGET_SELF) + 0
    local f28_local3 = 4.6 - f28_arg0:GetMapHitRadius(TARGET_SELF) + 2
    local f28_local4 = 100
    local f28_local5 = 0
    local f28_local6 = 1.5
    local f28_local7 = 3
    local f28_local8 = f28_arg0:GetRandam_Int(1, 100)
    if not f28_arg0:HasSpecialEffectId(TARGET_SELF, 3508000) then
        f28_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 10, 3030, TARGET_ENE_0, 9999, 0, 0, 0, 0)
    end
    if f28_arg0:GetNumber(7) == 0 then
        f28_arg0:SetEventMoveTarget(1102840)
        f28_arg1:AddSubGoal(GOAL_COMMON_ApproachTarget, 5, POINT_EVENT, 2, TARGET_SELF, false, -1):TimingSetNumber(7, 1, UPDATE_SUCCESS):TimingSetTimer(7, 4, UPDATE_SUCCESS)
    elseif f28_arg0:GetNumber(7) == 1 then
        if f28_arg0:IsFinishTimer(7) == false then
            f28_arg1:AddSubGoal(GOAL_COMMON_ApproachTarget, 2, TARGET_ENE_0, 15, TARGET_SELF, false, -1)
            f28_arg1:AddSubGoal(GOAL_COMMON_ApproachSettingDirection, 0.5, TARGET_ENE_0, 2, TARGET_ENE_0, false, -1, AI_DIR_TYPE_ToL, 4)
        else
            f28_arg1:AddSubGoal(GOAL_COMMON_ApproachSettingDirection, 0.5, TARGET_ENE_0, 2, TARGET_ENE_0, false, -1, AI_DIR_TYPE_ToL, 4)
        end
        f28_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 10, 3040, TARGET_ENE_0, 9999, 0, 0, 0, 0):TimingSetNumber(7, 2, UPDATE_SUCCESS):TimingSetTimer(8, 15, AI_TIMING_SET__ACTIVATE)
    elseif f28_arg0:GetNumber(7) == 2 then
        f28_arg1:AddSubGoal(GOAL_COMMON_ApproachSettingDirection, 0.5, TARGET_ENE_0, 2, TARGET_ENE_0, false, -1, AI_DIR_TYPE_ToL, 10)
    end
    f28_arg0:SetNumber(5, 34)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act35 = function (f29_arg0, f29_arg1, f29_arg2)
    local f29_local0 = 0
    local f29_local1 = 0
    f29_arg1:AddSubGoal(GOAL_COMMON_ComboTunable_SuccessAngle180, 10, 3029, TARGET_ENE_0, 9999, 0, 0)
    f29_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3066, TARGET_ENE_0, 9999, 0, 0)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act36 = function (f30_arg0, f30_arg1, f30_arg2)
    local f30_local0 = 0
    local f30_local1 = 0
    local f30_local2 = f30_arg0:GetRandam_Int(1, 100)
    f30_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 10, 3064, TARGET_ENE_0, 9999, f30_local0, f30_local1, 0, 0)
    f30_arg1:AddSubGoal(GOAL_COMMON_ApproachSettingDirection, f30_arg0:GetRandam_Float(1, 1.5), TARGET_ENE_0, 2, TARGET_ENE_0, false, -1, f30_arg0:GetRandam_Int(AI_DIR_TYPE_ToL, AI_DIR_TYPE_ToR), f30_arg0:GetRandam_Float(8, 10))
    if f30_local2 <= 50 then
        f30_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 10, 3032, TARGET_ENE_0, 9999, 0, 0, 0, 0)
    else
        f30_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 10, 3033, TARGET_ENE_0, 9999, 0, 0, 0, 0)
    end
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act37 = function (f31_arg0, f31_arg1, f31_arg2)
    local f31_local0 = 0
    local f31_local1 = 0
    f31_arg1:AddSubGoal(GOAL_COMMON_ComboTunable_SuccessAngle180, 10, 3082, TARGET_ENE_0, 9999, 0, 0)
    f31_arg1:AddSubGoal(GOAL_COMMON_ComboRepeat_SuccessAngle180, 10, 3083, TARGET_ENE_0, 9999, 0, 0)
    f31_arg1:AddSubGoal(GOAL_COMMON_ComboRepeat_SuccessAngle180, 10, 3084, TARGET_ENE_0, 9999, 0, 0)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act38 = function (f32_arg0, f32_arg1, f32_arg2)
    local f32_local0 = 0
    local f32_local1 = 0
    f32_arg1:AddSubGoal(GOAL_COMMON_ComboTunable_SuccessAngle180, 10, 3085, TARGET_ENE_0, 9999, 0, 0)
    f32_arg1:AddSubGoal(GOAL_COMMON_ComboRepeat_SuccessAngle180, 10, 3045, TARGET_ENE_0, 9999, 0, 0)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act39 = function (f33_arg0, f33_arg1, f33_arg2)
    local f33_local0 = 0
    local f33_local1 = 0
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act40 = function (f34_arg0, f34_arg1, f34_arg2)
    if not f34_arg0:HasSpecialEffectId(TARGET_SELF, 3508000) then
        f34_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 10, 3030, TARGET_ENE_0, 9999, 0, 0, 0, 0)
    end
    f34_arg1:AddSubGoal(GOAL_COMMON_ApproachSettingDirection, f34_arg0:GetRandam_Float(0.3, 0.7), TARGET_SELF, 2, TARGET_SELF, false, -1, AI_DIR_TYPE_F, 20)
    f34_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 10, 3032, TARGET_ENE_0, 9999, 0, 0, 0, 0)
    f34_arg0:SetNumber(5, 33)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act41 = function (f35_arg0, f35_arg1, f35_arg2)
    if not f35_arg0:HasSpecialEffectId(TARGET_SELF, 3508000) then
        f35_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 10, 3030, TARGET_ENE_0, 9999, 0, 0, 0, 0)
    end
    f35_arg1:AddSubGoal(GOAL_COMMON_ApproachSettingDirection, f35_arg0:GetRandam_Float(0.3, 0.7), TARGET_SELF, 2, TARGET_SELF, false, -1, AI_DIR_TYPE_F, 20)
    f35_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 10, 3033, TARGET_ENE_0, 9999, 0, 0, 0, 0)
    f35_arg0:SetNumber(5, 33)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act42 = function (f36_arg0, f36_arg1, f36_arg2)
    local f36_local0 = 3.5 - f36_arg0:GetMapHitRadius(TARGET_SELF)
    local f36_local1 = 3.5 - f36_arg0:GetMapHitRadius(TARGET_SELF) + 2
    local f36_local2 = 3.5 - f36_arg0:GetMapHitRadius(TARGET_SELF) + 2
    local f36_local3 = 100
    local f36_local4 = 0
    local f36_local5 = 1.5
    local f36_local6 = 3
    if f36_arg0:HasSpecialEffectId(TARGET_SELF, 3508000) then
        f36_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 10, 3031, TARGET_ENE_0, 9999, 0, 0, 0, 0)
    end
    local f36_local7 = 3
    local f36_local8 = 45
    local f36_local9 = 0
    local f36_local10 = 0
    f36_arg1:AddSubGoal(GOAL_COMMON_ComboTunable_SuccessAngle180, 10, 3039, TARGET_ENE_0, 9999, 0)
    f36_arg1:AddSubGoal(GOAL_COMMON_ComboRepeat_SuccessAngle180, 10, 3043, TARGET_ENE_0, 9999, 0)
    f36_arg0:SetNumber(5, 1)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act43 = function (f37_arg0, f37_arg1, f37_arg2)
    local f37_local0 = 17
    local f37_local1 = 17
    local f37_local2 = 17
    local f37_local3 = 100
    local f37_local4 = 0
    local f37_local5 = 1.5
    local f37_local6 = 3
    f37_arg1:AddSubGoal(GOAL_COMMON_ApproachTarget, 3, TARGET_ENE_0, 5, TARGET_SELF, false, -1)
    local f37_local7 = 3
    local f37_local8 = 45
    local f37_local9 = 0
    local f37_local10 = 0
    f37_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 10, 3097, TARGET_ENE_0, 9999, f37_local9, f37_local10, 0, 0)
    f37_arg0:SetNumber(5, 1)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act44 = function (f38_arg0, f38_arg1, f38_arg2)
    if not f38_arg0:HasSpecialEffectId(TARGET_SELF, 3508000) then
        f38_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 10, 3030, TARGET_ENE_0, 9999, 0, 0, 0, 0)
    end
    local f38_local0 = f38_arg0:GetRandam_Int(1, 100)
    if f38_arg0:IsInsideTarget(TARGET_ENE_0, AI_DIR_TYPE_R, 90) then
        f38_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 10, 3041, TARGET_ENE_0, 9999, 0, 0, 0, 0)
    else
        f38_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 10, 3042, TARGET_ENE_0, 9999, 0, 0, 0, 0)
    end
    f38_arg1:AddSubGoal(GOAL_COMMON_ApproachTarget, 3, TARGET_ENE_0, 10, TARGET_SELF, false, -1)
    f38_arg1:AddSubGoal(GOAL_COMMON_ComboTunable_SuccessAngle180, 10, 3095, TARGET_ENE_0, 9999, 0)
    f38_arg1:AddSubGoal(GOAL_COMMON_ApproachSettingDirection, f38_arg0:GetRandam_Float(2, 2.5), TARGET_ENE_0, 15, TARGET_ENE_0, false, -1, f38_arg0:GetRandam_Int(AI_DIR_TYPE_ToL, AI_DIR_TYPE_ToR), f38_arg0:GetRandam_Float(14, 20))
    if f38_arg0:IsInsideTarget(TARGET_ENE_0, AI_DIR_TYPE_R, 90) then
        f38_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 10, 3041, TARGET_ENE_0, 9999, 0, 0, 0, 0)
    else
        f38_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 10, 3042, TARGET_ENE_0, 9999, 0, 0, 0, 0)
    end
    f38_arg1:AddSubGoal(GOAL_COMMON_ApproachTarget, 3, TARGET_ENE_0, 10, TARGET_SELF, false, -1)
    f38_arg1:AddSubGoal(GOAL_COMMON_ComboTunable_SuccessAngle180, 10, 3024, TARGET_ENE_0, 9999, TurnTime, FrontAngle, 0, 0)
    f38_arg1:AddSubGoal(GOAL_COMMON_ComboRepeat_SuccessAngle180, 10, 3018, TARGET_ENE_0, 9999, 0, 0)
    f38_arg0:SetNumber(5, 31)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act45 = function (f39_arg0, f39_arg1, f39_arg2)
    local f39_local0 = 3.5 - f39_arg0:GetMapHitRadius(TARGET_SELF)
    local f39_local1 = 3.5 - f39_arg0:GetMapHitRadius(TARGET_SELF) + 99
    local f39_local2 = 3.5 - f39_arg0:GetMapHitRadius(TARGET_SELF) + 100
    local f39_local3 = 100
    local f39_local4 = 0
    local f39_local5 = 1.5
    local f39_local6 = 3
    if f39_arg0:IsInsideTarget(TARGET_ENE_0, AI_DIR_TYPE_L, 180) or f39_arg0:IsInsideTarget(TARGET_ENE_0, AI_DIR_TYPE_B, 60) then
        f39_arg1:AddSubGoal(GOAL_COMMON_ApproachSettingDirection, 0.1, TARGET_ENE_0, 0, TARGET_SELF, false, -1, AI_DIR_TYPE_ToL, 3)
    end
    local f39_local7 = 3
    local f39_local8 = 45
    local f39_local9 = 3096
    local f39_local10 = 0
    local f39_local11 = 0
    f39_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 10, f39_local9, TARGET_ENE_0, 9999, f39_local10, f39_local11, 0, 0)
    f39_arg0:SetNumber(5, 1)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act46 = function (f40_arg0, f40_arg1, f40_arg2)
    local f40_local0 = 3045
    local f40_local1 = 0
    local f40_local2 = 0
    f40_arg1:AddSubGoal(GOAL_COMMON_ComboTunable_SuccessAngle180, 10, 3085, TARGET_ENE_0, 9999, 0, 0)
    f40_arg1:AddSubGoal(GOAL_COMMON_ComboRepeat_SuccessAngle180, 10, 3045, TARGET_ENE_0, 9999, 0, 0)
    f40_arg0:SetNumber(5, 2)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act47 = function (f41_arg0, f41_arg1, f41_arg2)
    local f41_local0 = 3038
    local f41_local1 = 0
    local f41_local2 = 0
    f41_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 10, f41_local0, TARGET_ENE_0, 9999, f41_local1, f41_local2, 0, 0)
    f41_arg0:SetNumber(5, 2)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act48 = function (f42_arg0, f42_arg1, f42_arg2)
    local f42_local0 = 3044
    local f42_local1 = 0
    local f42_local2 = 0
    f42_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 10, f42_local0, TARGET_ENE_0, 9999, f42_local1, f42_local2, 0, 0)
    f42_arg1:AddSubGoal(GOAL_COMMON_ComboAttackTunableSpin, 10, 3082, TARGET_ENE_0, 9999, 0, 0)
    f42_arg1:AddSubGoal(GOAL_COMMON_ComboRepeat_SuccessAngle180, 10, 3083, TARGET_ENE_0, 9999, 0, 0)
    f42_arg1:AddSubGoal(GOAL_COMMON_ComboRepeat_SuccessAngle180, 10, 3084, TARGET_ENE_0, 9999, 0, 0)
    f42_arg0:SetNumber(5, 2)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act21 = function (f43_arg0, f43_arg1, f43_arg2)
    local f43_local0 = 3
    local f43_local1 = 45
    f43_arg1:AddSubGoal(GOAL_COMMON_Turn, f43_local0, TARGET_ENE_0, f43_local1, -1, GOAL_RESULT_Success, true)
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
    
end

Goal.Act23 = function (f44_arg0, f44_arg1, f44_arg2)
    local f44_local0 = f44_arg0:GetDist(TARGET_ENE_0)
    local f44_local1 = f44_arg0:GetSp(TARGET_SELF)
    local f44_local2 = 20
    local f44_local3 = f44_arg0:GetRandam_Int(1, 100)
    local f44_local4 = -1
    if f44_local2 <= f44_local1 and f44_local3 <= 50 then
        f44_local4 = 9910
    end
    local f44_local5 = 0
    if SpaceCheck(f44_arg0, f44_arg1, -90, 1) == true then
        if SpaceCheck(f44_arg0, f44_arg1, 90, 1) == true then
            if f44_arg0:IsInsideTarget(TARGET_ENE_0, AI_DIR_TYPE_R, 180) then
                f44_local5 = 0
            else
                f44_local5 = 1
            end
        else
            f44_local5 = 0
        end
    elseif SpaceCheck(f44_arg0, f44_arg1, 90, 1) == true then
        f44_local5 = 1
    else
        GetWellSpace_Odds = 100
        return GetWellSpace_Odds
    end
    local f44_local6 = 3
    local f44_local7 = f44_arg0:GetRandam_Int(30, 45)
    f44_arg0:SetNumber(10, f44_local5)
    f44_arg1:AddSubGoal(GOAL_COMMON_SidewayMove, f44_local6, TARGET_ENE_0, f44_local5, f44_local7, true, true, f44_local4)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act24 = function (f45_arg0, f45_arg1, f45_arg2)
    local f45_local0 = f45_arg0:GetDist(TARGET_ENE_0)
    local f45_local1 = 3
    local f45_local2 = 0
    local f45_local3 = 5201
    if SpaceCheck(f45_arg0, f45_arg1, 180, 2) == true then
        if SpaceCheck(f45_arg0, f45_arg1, 180, 4) ~= true or f45_local0 > 4 then
        else
            f45_local3 = 5211
            if false then
            end
        end
    else
        GetWellSpace_Odds = 100
        return GetWellSpace_Odds
    end
    f45_arg1:AddSubGoal(GOAL_COMMON_SpinStep, f45_local1, f45_local3, TARGET_ENE_0, f45_local2, AI_DIR_TYPE_B, 0)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act25 = function (f46_arg0, f46_arg1, f46_arg2)
    local f46_local0 = f46_arg0:GetRandam_Float(2, 4)
    local f46_local1 = f46_arg0:GetRandam_Float(1, 3)
    local f46_local2 = f46_arg0:GetDist(TARGET_ENE_0)
    local f46_local3 = -1
    f46_arg0:AddObserveSpecialEffectAttribute(TARGET_SELF, 3508520)
    f46_arg1:AddSubGoal(GOAL_COMMON_LeaveTarget, 10, TARGET_ENE_0, 15, TARGET_SELF, false, -1)
    if f46_arg0:IsInsideTarget(TARGET_ENE_0, AI_DIR_TYPE_R, 90) then
        f46_arg1:AddSubGoal(GOAL_COMMON_ComboTunable_SuccessAngle180, 10, 3041, TARGET_ENE_0, 9999, 0, 0)
    else
        f46_arg1:AddSubGoal(GOAL_COMMON_ComboTunable_SuccessAngle180, 10, 3042, TARGET_ENE_0, 9999, 0, 0)
    end
    f46_arg1:AddSubGoal(GOAL_COMMON_ComboRepeat_SuccessAngle180, 10, 3015, TARGET_ENE_0, 9999, TurnTime, FrontAngle, 0, 0)
    f46_arg1:AddSubGoal(GOAL_COMMON_ComboRepeat_SuccessAngle180, 10, 3016, TARGET_ENE_0, 9999, 0, 0)
    f46_arg1:AddSubGoal(GOAL_COMMON_ComboRepeat_SuccessAngle180, 10, 3021, TARGET_ENE_0, 9999, 0, 0)
    f46_arg1:AddSubGoal(GOAL_COMMON_ComboRepeat_SuccessAngle180, 10, 3016, TARGET_ENE_0, 9999, 0, 0)
    f46_arg1:AddSubGoal(GOAL_COMMON_ComboRepeat_SuccessAngle180, 10, 3021, TARGET_ENE_0, 9999, 0, 0)
    f46_arg1:AddSubGoal(GOAL_COMMON_ComboRepeat_SuccessAngle180, 10, 3016, TARGET_ENE_0, 9999, 0, 0)
    f46_arg1:AddSubGoal(GOAL_COMMON_ComboRepeat_SuccessAngle180, 10, 3021, TARGET_ENE_0, 9999, 0, 0)
    f46_arg1:AddSubGoal(GOAL_COMMON_ComboRepeat_SuccessAngle180, 10, 3016, TARGET_ENE_0, 9999, 0, 0)
    f46_arg1:AddSubGoal(GOAL_COMMON_ComboRepeat_SuccessAngle180, 10, 3021, TARGET_ENE_0, 9999, 0, 0)
    f46_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3017, TARGET_ENE_0, 9999, 0, 0)
    
end

Goal.Act26 = function (f47_arg0, f47_arg1, f47_arg2)
    f47_arg1:AddSubGoal(GOAL_COMMON_Wait, 0.5, TARGET_SELF, 0, 0, 0)
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
    
end

Goal.Act27 = function (f48_arg0, f48_arg1, f48_arg2)
    local f48_local0 = f48_arg0:GetDist(TARGET_ENE_0)
    local f48_local1 = f48_arg0:GetDistYSigned(TARGET_ENE_0)
    local f48_local2 = f48_local1 / math.tan(math.deg(30))
    local f48_local3 = f48_arg0:GetRandam_Int(0, 1)
    if f48_local1 >= 3 then
        if f48_local2 + 1 <= f48_local0 then
            if SpaceCheck(f48_arg0, f48_arg1, 0, 4) == true then
                f48_arg1:AddSubGoal(GOAL_COMMON_ApproachTarget, 0.1, TARGET_ENE_0, f48_local2, TARGET_SELF, false, -1)
            elseif SpaceCheck(f48_arg0, f48_arg1, 0, 3) == true then
                f48_arg1:AddSubGoal(GOAL_COMMON_ApproachTarget, 0.5, TARGET_ENE_0, f48_local2, TARGET_SELF, true, -1)
            end
        elseif f48_local0 <= f48_local2 - 1 then
            f48_arg1:AddSubGoal(GOAL_COMMON_LeaveTarget, 10, TARGET_ENE_0, f48_local2, TARGET_ENE_0, true, -1)
        end
    elseif SpaceCheck(f48_arg0, f48_arg1, 0, 4) == true then
        f48_arg1:AddSubGoal(GOAL_COMMON_ApproachTarget, 0.1, TARGET_ENE_0, 0, TARGET_SELF, false, -1)
    elseif SpaceCheck(f48_arg0, f48_arg1, 0, 3) == true then
        f48_arg1:AddSubGoal(GOAL_COMMON_ApproachTarget, 0.5, TARGET_ENE_0, 0, TARGET_SELF, true, -1)
    elseif SpaceCheck(f48_arg0, f48_arg1, 0, 1) == false then
        f48_arg1:AddSubGoal(GOAL_COMMON_LeaveTarget, 0.5, TARGET_ENE_0, 999, TARGET_ENE_0, true, -1)
    end
    f48_arg0:SetNumber(10, f48_local3)
    f48_arg1:AddSubGoal(GOAL_COMMON_SidewayMove, 3, TARGET_ENE_0, f48_local3, f48_arg0:GetRandam_Int(30, 45), true, true, -1)
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
    
end

Goal.Act28 = function (f49_arg0, f49_arg1, f49_arg2)
    local f49_local0 = f49_arg0:GetDist(TARGET_ENE_0)
    local f49_local1 = 3
    local f49_local2 = f49_arg0:GetRandam_Int(30, 45)
    local f49_local3 = -1
    local f49_local4 = f49_arg0:GetRandam_Int(0, 1)
    local f49_local5 = f49_arg0:GetRandam_Int(1, 100)
    if f49_local5 <= 50 then
        f49_arg1:AddSubGoal(GOAL_COMMON_ApproachSettingDirection, f49_arg0:GetRandam_Float(1, 1.5), TARGET_ENE_0, 2, TARGET_ENE_0, true, -1, AI_DIR_TYPE_ToR, f49_arg0:GetRandam_Float(8, 10))
    else
        f49_arg1:AddSubGoal(GOAL_COMMON_ApproachSettingDirection, f49_arg0:GetRandam_Float(1, 1.5), TARGET_ENE_0, 2, TARGET_ENE_0, true, -1, AI_DIR_TYPE_ToL, f49_arg0:GetRandam_Float(8, 10))
    end
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
    
end

Goal.Interrupt = function (f50_arg0, f50_arg1, f50_arg2)
    local f50_local0 = f50_arg1:GetHpRate(TARGET_SELF)
    local f50_local1 = f50_arg1:GetDist(TARGET_ENE_0)
    local f50_local2 = f50_arg1:GetSp(TARGET_SELF)
    local f50_local3 = f50_arg1:GetSpecialEffectActivateInterruptType(0)
    local f50_local4 = f50_arg1:GetRandam_Int(1, 100)
    local f50_local5 = f50_arg1:GetRandam_Int(1, 100)
    local f50_local6 = f50_arg1:GetRandam_Int(1, 100)
    local f50_local7 = f50_arg1:GetNinsatsuNum()
    if f50_arg1:IsInterupt(INTERUPT_ActivateSpecialEffect) then
        if f50_arg1:GetSpecialEffectActivateInterruptType(0) == 5026 and f50_arg1:GetNumber(8) == 0 then
            if f50_arg1:IsInsideTarget(TARGET_ENE_0, AI_DIR_TYPE_R, 135) or f50_arg1:IsInsideTarget(TARGET_ENE_0, AI_DIR_TYPE_F, 60) then
                if f50_local1 >= 12 then
                    if not f50_arg1:HasSpecialEffectId(TARGET_SELF, 3508100) then
                        f50_arg2:ClearSubGoal()
                        f50_arg0.Act17(f50_arg1, f50_arg2, paramTbl)
                        f50_arg1:DeleteObserve(0)
                        f50_arg1:DeleteObserve(1)
                        f50_arg1:DeleteObserve(2)
                        f50_arg1:DeleteObserve(3)
                        return true
                    else
                        f50_arg2:ClearSubGoal()
                        f50_arg0.Act18(f50_arg1, f50_arg2, paramTbl)
                        f50_arg1:DeleteObserve(0)
                        f50_arg1:DeleteObserve(1)
                        f50_arg1:DeleteObserve(2)
                        f50_arg1:DeleteObserve(3)
                        return true
                    end
                elseif f50_arg1:IsFinishTimer(4) == true then
                    f50_arg2:ClearSubGoal()
                    f50_arg2:AddSubGoal(GOAL_COMMON_ApproachTarget, 10, TARGET_ENE_0, 8, TARGET_SELF, false, -1)
                    f50_arg2:AddSubGoal(GOAL_COMMON_ComboRepeat_SuccessAngle180, 10, 3097, TARGET_ENE_0, 9999, 0)
                    f50_arg1:SetTimer(4, 10)
                    do
                        return true
                    end
                    if false then
                    end
                end
            end
        elseif f50_arg1:GetSpecialEffectActivateInterruptType(0) == 5029 then
            f50_arg1:AddObserveArea(4, TARGET_SELF, TARGET_ENE_0, AI_DIR_TYPE_F, 360, 5)
        elseif f50_arg1:GetSpecialEffectActivateInterruptType(0) == 5031 and f50_local7 <= 1 then
            f50_arg2:ClearSubGoal()
            f50_arg2:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3090, TARGET_ENE_0, 9999, 0, 0)
            return true
        elseif f50_arg1:GetSpecialEffectActivateInterruptType(0) == 5032 then
            if f50_local1 >= 6 and f50_local1 <= 13 and f50_arg1:IsFinishTimer(8) == true then
                f50_arg2:ClearSubGoal()
                f50_arg2:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3046, TARGET_ENE_0, 9999, 0, 0)
                return true
            end
        elseif f50_arg1:GetSpecialEffectActivateInterruptType(0) == 5034 then
            if f50_local1 >= 6 then
                f50_arg2:ClearSubGoal()
                f50_arg2:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3018, TARGET_ENE_0, 9999, 0, 0)
                return true
            end
        elseif f50_arg1:GetSpecialEffectActivateInterruptType(0) == 105100 then
            if f50_arg1:HasSpecialEffectId(TARGET_SELF, 5039) then
                f50_arg2:ClearSubGoal()
                f50_arg2:AddSubGoal(GOAL_COMMON_EndureAttack, 1, 20000, TARGET_ENE_0, 9999, 0)
                return true
            end
        elseif f50_arg1:GetSpecialEffectActivateInterruptType(0) == 100401 then
            if f50_arg1:HasSpecialEffectId(TARGET_SELF, 3508070) then
                f50_arg2:ClearSubGoal()
                f50_arg2:AddSubGoal(GOAL_COMMON_EndureAttack, 1, 20001, TARGET_ENE_0, 9999, 0):TimingSetTimer(3, 25, UPDATE_SUCCESS)
                return true
            elseif f50_arg1:HasSpecialEffectId(TARGET_SELF, 3508071) then
                f50_arg2:ClearSubGoal()
                f50_arg2:AddSubGoal(GOAL_COMMON_EndureAttack, 1, 20002, TARGET_ENE_0, 9999, 0):TimingSetTimer(3, 25, UPDATE_SUCCESS)
                return true
            end
        elseif f50_arg1:GetSpecialEffectActivateInterruptType(0) == 3508080 then
            f50_arg1:SetTimer(3, 25)
        elseif f50_arg1:GetSpecialEffectActivateInterruptType(0) == 3508510 then
            f50_arg2:ClearSubGoal()
            f50_arg2:AddSubGoal(GOAL_COMMON_EndureAttack, 10, 3018, TARGET_ENE_0, 9999, 0)
            f50_arg1:SetTimer(10, 75)
            f50_arg1:DeleteObserve(3)
            return true
        elseif f50_arg1:GetSpecialEffectActivateInterruptType(0) == 3508520 then
            f50_arg1:DeleteObserveSpecialEffectAttribute(TARGET_SELF, 3508520)
            f50_arg2:ClearSubGoal()
            if f50_arg1:IsInsideTarget(TARGET_ENE_0, AI_DIR_TYPE_R, 90) then
                f50_arg2:AddSubGoal(GOAL_COMMON_ComboTunable_SuccessAngle180, 10, 3041, TARGET_ENE_0, 9999, 0, 0)
            else
                f50_arg2:AddSubGoal(GOAL_COMMON_ComboTunable_SuccessAngle180, 10, 3042, TARGET_ENE_0, 9999, 0, 0)
            end
            f50_arg2:AddSubGoal(GOAL_COMMON_ComboRepeat_SuccessAngle180, 10, 3015, TARGET_ENE_0, 9999, TurnTime, FrontAngle, 0, 0)
            f50_arg2:AddSubGoal(GOAL_COMMON_ComboRepeat_SuccessAngle180, 10, 3016, TARGET_ENE_0, 9999, 0, 0)
            f50_arg2:AddSubGoal(GOAL_COMMON_ComboRepeat_SuccessAngle180, 10, 3021, TARGET_ENE_0, 9999, 0, 0)
            f50_arg2:AddSubGoal(GOAL_COMMON_ComboRepeat_SuccessAngle180, 10, 3016, TARGET_ENE_0, 9999, 0, 0)
            f50_arg2:AddSubGoal(GOAL_COMMON_ComboRepeat_SuccessAngle180, 10, 3021, TARGET_ENE_0, 9999, 0, 0)
            f50_arg2:AddSubGoal(GOAL_COMMON_ComboRepeat_SuccessAngle180, 10, 3016, TARGET_ENE_0, 9999, 0, 0)
            f50_arg2:AddSubGoal(GOAL_COMMON_ComboRepeat_SuccessAngle180, 10, 3021, TARGET_ENE_0, 9999, 0, 0)
            f50_arg2:AddSubGoal(GOAL_COMMON_ComboRepeat_SuccessAngle180, 10, 3016, TARGET_ENE_0, 9999, 0, 0)
            f50_arg2:AddSubGoal(GOAL_COMMON_ComboRepeat_SuccessAngle180, 10, 3021, TARGET_ENE_0, 9999, 0, 0)
            return true
        end
    end
    if f50_arg1:IsInterupt(INTERUPT_Inside_ObserveArea) then
        if f50_arg1:IsInsideObserve(0) then
            f50_arg2:ClearSubGoal()
            f50_arg2:AddSubGoal(GOAL_COMMON_ComboTunable_SuccessAngle180, 10, 3005, TARGET_ENE_0, 5, 0, 0, 0, 0)
            f50_arg1:DeleteObserve(0)
            return true
        elseif f50_arg1:IsInsideObserve(1) then
            f50_arg2:ClearSubGoal()
            f50_arg2:AddSubGoal(GOAL_COMMON_ComboTunable_SuccessAngle180, 10, 3024, TARGET_ENE_0, 9999, 0, 0, 0, 0)
            f50_arg1:DeleteObserve(1)
            return true
        elseif f50_arg1:IsInsideObserve(4) then
            f50_arg2:ClearSubGoal()
            f50_arg2:AddSubGoal(GOAL_COMMON_EndureAttack, 5, 3019, TARGET_ENE_0, 9999, 0)
            f50_arg2:AddSubGoal(GOAL_COMMON_ComboFinal, 5, 3042, TARGET_ENE_0, 9999, 0)
            f50_arg1:DeleteObserve(4)
            return true
        end
    end
    if f50_arg1:IsInterupt(INTERUPT_Outside_ObserveArea) then
    end
    return false
    
end

Goal.Damaged = function (f51_arg0, f51_arg1, f51_arg2)
    local f51_local0 = f51_arg0:GetHpRate(TARGET_SELF)
    local f51_local1 = f51_arg0:GetDist(TARGET_ENE_0)
    local f51_local2 = f51_arg0:GetSp(TARGET_SELF)
    local f51_local3 = f51_arg0:GetRandam_Int(1, 100)
    local f51_local4 = 0
    if f51_local1 <= 5 then
        f51_arg1:ClearSubGoal()
        f51_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 5, 3090, TARGET_ENE_0, 9999, 0, 0)
        return true
    end
    return false
    
end

Goal.Kengeki_Activate = function (f52_arg0, f52_arg1, f52_arg2, f52_arg3)
    local f52_local0 = ReturnKengekiSpecialEffect(f52_arg1)
    if f52_local0 == 0 then
        return false
    end
    local f52_local1 = {}
    local f52_local2 = {}
    local f52_local3 = {}
    Common_Clear_Param(f52_local1, f52_local2, f52_local3)
    local f52_local4 = f52_arg1:GetDist(TARGET_ENE_0)
    local f52_local5 = f52_arg1:GetSp(TARGET_SELF)
    local f52_local6 = f52_arg1:GetNumber(0)
    if f52_local5 <= 0 then
        f52_local1[26] = 100
    elseif f52_local0 == 200200 then
        if f52_local4 >= 3 then
            f52_local1[26] = 100
        else
            f52_local1[3] = 100
            f52_local1[35] = 30
            f52_local1[36] = 100
        end
    elseif f52_local0 == 200201 then
        if f52_local4 >= 3 then
            f52_local1[26] = 100
        else
            f52_local1[3] = 100
            f52_local1[35] = 30
            f52_local1[36] = 100
        end
    elseif f52_local0 == 200227 or f52_local0 == 200228 then
        if f52_local4 >= 3 then
            f52_local1[26] = 100
        elseif f52_local4 <= 1.5 and f52_arg1:IsInsideTarget(TARGET_ENE_0, AI_DIR_TYPE_R, 90) then
            f52_local1[10] = 200
        else
            f52_local1[30] = 50
        end
    end
    if f52_local4 <= 2 or not f52_arg1:IsInsideTarget(TARGET_ENE_0, AI_DIR_TYPE_F, 90) then
        f52_local1[35] = 0
    end
    if f52_local4 <= 1.2 then
        f52_local1[18] = 0
        f52_local1[35] = 0
    end
    f52_local1[1] = SetCoolTime(f52_arg1, f52_arg2, 3060, 10, f52_local1[1], 1)
    f52_local1[2] = SetCoolTime(f52_arg1, f52_arg2, 3061, 10, f52_local1[2], 1)
    f52_local1[3] = SetCoolTime(f52_arg1, f52_arg2, 3062, 30, f52_local1[3], 1)
    f52_local1[4] = SetCoolTime(f52_arg1, f52_arg2, 3063, 10, f52_local1[4], 1)
    f52_local1[5] = SetCoolTime(f52_arg1, f52_arg2, 3065, 10, f52_local1[5], 1)
    f52_local1[6] = SetCoolTime(f52_arg1, f52_arg2, 3066, 10, f52_local1[6], 1)
    f52_local1[7] = SetCoolTime(f52_arg1, f52_arg2, 3067, 10, f52_local1[7], 1)
    f52_local1[8] = SetCoolTime(f52_arg1, f52_arg2, 3068, 10, f52_local1[8], 1)
    f52_local1[9] = SetCoolTime(f52_arg1, f52_arg2, 3050, 40, f52_local1[9], 1)
    f52_local1[10] = SetCoolTime(f52_arg1, f52_arg2, 3006, 40, f52_local1[10], 1)
    f52_local1[11] = SetCoolTime(f52_arg1, f52_arg2, 3069, 10, f52_local1[11], 1)
    f52_local1[12] = SetCoolTime(f52_arg1, f52_arg2, 3025, 10, f52_local1[12], 1)
    f52_local1[13] = SetCoolTime(f52_arg1, f52_arg2, 3070, 30, f52_local1[13], 1)
    f52_local1[14] = SetCoolTime(f52_arg1, f52_arg2, 3071, 10, f52_local1[14], 1)
    f52_local1[15] = SetCoolTime(f52_arg1, f52_arg2, 3000, 10, f52_local1[15], 1)
    f52_local1[16] = SetCoolTime(f52_arg1, f52_arg2, 3080, 10, f52_local1[16], 1)
    f52_local1[17] = SetCoolTime(f52_arg1, f52_arg2, 3081, 10, f52_local1[17], 1)
    f52_local1[18] = SetCoolTime(f52_arg1, f52_arg2, 3002, 30, f52_local1[18], 1)
    f52_local1[19] = SetCoolTime(f52_arg1, f52_arg2, 3037, 10, f52_local1[19], 1)
    f52_local1[31] = SetCoolTime(f52_arg1, f52_arg2, 3026, 10, f52_local1[31], 1)
    f52_local1[32] = SetCoolTime(f52_arg1, f52_arg2, 3027, 10, f52_local1[32], 1)
    f52_local1[35] = SetCoolTime(f52_arg1, f52_arg2, 3039, 10, f52_local1[35], 1)
    f52_local1[36] = SetCoolTime(f52_arg1, f52_arg2, 3044, 10, f52_local1[36], 1)
    f52_local2[1] = REGIST_FUNC(f52_arg1, f52_arg2, f52_arg0.Kengeki01)
    f52_local2[2] = REGIST_FUNC(f52_arg1, f52_arg2, f52_arg0.Kengeki02)
    f52_local2[3] = REGIST_FUNC(f52_arg1, f52_arg2, f52_arg0.Kengeki03)
    f52_local2[4] = REGIST_FUNC(f52_arg1, f52_arg2, f52_arg0.Kengeki04)
    f52_local2[5] = REGIST_FUNC(f52_arg1, f52_arg2, f52_arg0.Kengeki05)
    f52_local2[6] = REGIST_FUNC(f52_arg1, f52_arg2, f52_arg0.Kengeki06)
    f52_local2[7] = REGIST_FUNC(f52_arg1, f52_arg2, f52_arg0.Kengeki07)
    f52_local2[8] = REGIST_FUNC(f52_arg1, f52_arg2, f52_arg0.Kengeki08)
    f52_local2[9] = REGIST_FUNC(f52_arg1, f52_arg2, f52_arg0.Kengeki09)
    f52_local2[10] = REGIST_FUNC(f52_arg1, f52_arg2, f52_arg0.Kengeki10)
    f52_local2[11] = REGIST_FUNC(f52_arg1, f52_arg2, f52_arg0.Kengeki11)
    f52_local2[12] = REGIST_FUNC(f52_arg1, f52_arg2, f52_arg0.Kengeki12)
    f52_local2[13] = REGIST_FUNC(f52_arg1, f52_arg2, f52_arg0.Kengeki13)
    f52_local2[14] = REGIST_FUNC(f52_arg1, f52_arg2, f52_arg0.Kengeki14)
    f52_local2[15] = REGIST_FUNC(f52_arg1, f52_arg2, f52_arg0.Kengeki15)
    f52_local2[16] = REGIST_FUNC(f52_arg1, f52_arg2, f52_arg0.Kengeki16)
    f52_local2[17] = REGIST_FUNC(f52_arg1, f52_arg2, f52_arg0.Kengeki17)
    f52_local2[18] = REGIST_FUNC(f52_arg1, f52_arg2, f52_arg0.Kengeki18)
    f52_local2[19] = REGIST_FUNC(f52_arg1, f52_arg2, f52_arg0.Kengeki19)
    f52_local2[20] = REGIST_FUNC(f52_arg1, f52_arg2, f52_arg0.Kengeki20)
    f52_local2[30] = REGIST_FUNC(f52_arg1, f52_arg2, f52_arg0.Kengeki30)
    f52_local2[31] = REGIST_FUNC(f52_arg1, f52_arg2, f52_arg0.Kengeki31)
    f52_local2[32] = REGIST_FUNC(f52_arg1, f52_arg2, f52_arg0.Kengeki32)
    f52_local2[33] = REGIST_FUNC(f52_arg1, f52_arg2, f52_arg0.Kengeki33)
    f52_local2[34] = REGIST_FUNC(f52_arg1, f52_arg2, f52_arg0.Kengeki34)
    f52_local2[35] = REGIST_FUNC(f52_arg1, f52_arg2, f52_arg0.Kengeki35)
    f52_local2[36] = REGIST_FUNC(f52_arg1, f52_arg2, f52_arg0.Kengeki36)
    f52_local2[37] = REGIST_FUNC(f52_arg1, f52_arg2, f52_arg0.Kengeki37)
    f52_local2[21] = REGIST_FUNC(f52_arg1, f52_arg2, f52_arg0.Act21)
    f52_local2[22] = REGIST_FUNC(f52_arg1, f52_arg2, f52_arg0.Act22)
    f52_local2[23] = REGIST_FUNC(f52_arg1, f52_arg2, f52_arg0.Act23)
    f52_local2[24] = REGIST_FUNC(f52_arg1, f52_arg2, f52_arg0.Act24)
    f52_local2[25] = REGIST_FUNC(f52_arg1, f52_arg2, f52_arg0.Act25)
    f52_local2[26] = REGIST_FUNC(f52_arg1, f52_arg2, f52_arg0.NoAction)
    local f52_local7 = REGIST_FUNC(f52_arg1, f52_arg2, f52_arg0.ActAfter_AdjustSpace)
    return Common_Kengeki_Activate(f52_arg1, f52_arg2, f52_local1, f52_local2, f52_local7, f52_local3)
    
end

Goal.Kengeki01 = function (f53_arg0, f53_arg1, f53_arg2)
    f53_arg1:ClearSubGoal()
    f53_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 3, 3060, TARGET_ENE_0, 9999, 0, 0)
    f53_arg0:SetNumber(6, 1)
    
end

Goal.Kengeki02 = function (f54_arg0, f54_arg1, f54_arg2)
    f54_arg1:ClearSubGoal()
    f54_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 3, 3061, TARGET_ENE_0, 9999, 0, 0)
    f54_arg0:SetNumber(4, 1)
    
end

Goal.Kengeki03 = function (f55_arg0, f55_arg1, f55_arg2)
    f55_arg1:ClearSubGoal()
    f55_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 3, 3070, TARGET_ENE_0, 9999, 0, 0)
    f55_arg0:SetNumber(2, 0)
    f55_arg0:SetNumber(6, 3)
    
end

Goal.Kengeki04 = function (f56_arg0, f56_arg1, f56_arg2)
    f56_arg1:ClearSubGoal()
    f56_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 3, 3063, TARGET_ENE_0, 9999, 0, 0)
    f56_arg0:SetNumber(6, 4)
    
end

Goal.Kengeki05 = function (f57_arg0, f57_arg1, f57_arg2)
    f57_arg1:ClearSubGoal()
    f57_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 3, 3004, TARGET_ENE_0, 9999, 0, 0)
    f57_arg0:SetNumber(6, 5)
    
end

Goal.Kengeki06 = function (f58_arg0, f58_arg1, f58_arg2)
    f58_arg1:ClearSubGoal()
    f58_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 3, 3066, TARGET_ENE_0, 9999, 0, 0)
    f58_arg0:SetNumber(6, 6)
    
end

Goal.Kengeki07 = function (f59_arg0, f59_arg1, f59_arg2)
    f59_arg1:ClearSubGoal()
    f59_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 3, 3067, TARGET_ENE_0, 9999, 0, 0)
    f59_arg0:SetNumber(6, 7)
    
end

Goal.Kengeki08 = function (f60_arg0, f60_arg1, f60_arg2)
    f60_arg1:ClearSubGoal()
    f60_arg1:AddSubGoal(GOAL_COMMON_ComboRepeat_SuccessAngle180, 10, 3068, TARGET_ENE_0, 9999, 0, 0)
    f60_arg1:AddSubGoal(GOAL_COMMON_LeaveTarget, 5, TARGET_ENE_0, 8, TARGET_SELF, false, -1)
    f60_arg1:AddSubGoal(GOAL_COMMON_ApproachSettingDirection, 3, TARGET_ENE_0, 2, TARGET_ENE_0, false, -1, AI_DIR_TYPE_ToL, f60_arg0:GetRandam_Float(8, 10))
    f60_arg1:AddSubGoal(GOAL_COMMON_ComboRepeat_SuccessAngle180, 10, 3046, TARGET_ENE_0, 9999, 0, 0)
    f60_arg0:SetNumber(6, 8)
    f60_arg0:SetTimer(2, 0)
    
end

Goal.Kengeki09 = function (f61_arg0, f61_arg1, f61_arg2)
    f61_arg1:ClearSubGoal()
    f61_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 3, 3050, TARGET_ENE_0, 9999, 0, 0)
    f61_arg0:SetNumber(2, 0)
    f61_arg0:SetNumber(6, 9)
    
end

Goal.Kengeki10 = function (f62_arg0, f62_arg1, f62_arg2)
    local f62_local0 = f62_arg0:GetRandam_Int(1, 100)
    f62_arg1:ClearSubGoal()
    f62_arg1:AddSubGoal(GOAL_COMMON_ComboRepeat_SuccessAngle180, 30, 3064, TARGET_ENE_0, 9999, 0, 0)
    f62_arg0:DeleteObserve(0)
    f62_arg0:DeleteObserve(1)
    f62_arg0:DeleteObserve(2)
    f62_arg0:DeleteObserve(4)
    f62_arg0:SetNumber(2, 0)
    f62_arg0:SetNumber(6, 10)
    
end

Goal.Kengeki11 = function (f63_arg0, f63_arg1, f63_arg2)
    f63_arg1:ClearSubGoal()
    f63_arg1:AddSubGoal(GOAL_COMMON_ComboRepeat_SuccessAngle180, 3, 3069, TARGET_ENE_0, 9999, 0, 0)
    f63_arg1:AddSubGoal(GOAL_COMMON_ComboRepeat_SuccessAngle180, 3, 3000, TARGET_ENE_0, 9999, 0, 0)
    f63_arg0:SetNumber(6, 11)
    
end

Goal.Kengeki12 = function (f64_arg0, f64_arg1, f64_arg2)
    f64_arg1:ClearSubGoal()
    f64_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 3, 3025, TARGET_ENE_0, 9999, 0, 0)
    f64_arg0:SetNumber(6, 12)
    
end

Goal.Kengeki13 = function (f65_arg0, f65_arg1, f65_arg2)
    f65_arg1:ClearSubGoal()
    f65_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 3, 3070, TARGET_ENE_0, 9999, 0, 0)
    f65_arg0:SetNumber(6, 12)
    
end

Goal.Kengeki14 = function (f66_arg0, f66_arg1, f66_arg2)
    f66_arg1:ClearSubGoal()
    f66_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 3, 3071, TARGET_ENE_0, 9999, 0, 0)
    f66_arg0:SetNumber(6, 12)
    
end

Goal.Kengeki15 = function (f67_arg0, f67_arg1, f67_arg2)
    f67_arg1:ClearSubGoal()
    f67_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 3, 3000, TARGET_ENE_0, 9999, 0, 0)
    f67_arg0:SetNumber(6, 12)
    
end

Goal.Kengeki16 = function (f68_arg0, f68_arg1, f68_arg2)
    f68_arg1:ClearSubGoal()
    f68_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 3, 3080, TARGET_ENE_0, 9999, 0, 0)
    f68_arg0:SetNumber(6, 12)
    
end

Goal.Kengeki17 = function (f69_arg0, f69_arg1, f69_arg2)
    f69_arg1:ClearSubGoal()
    f69_arg1:AddSubGoal(GOAL_COMMON_ComboRepeat_SuccessAngle180, 3, 3081, TARGET_ENE_0, 9999, 0, 0)
    f69_arg1:AddSubGoal(GOAL_COMMON_ComboRepeat_SuccessAngle180, 3, 3000, TARGET_ENE_0, 9999, 0, 0)
    f69_arg0:SetNumber(6, 12)
    
end

Goal.Kengeki18 = function (f70_arg0, f70_arg1, f70_arg2)
    f70_arg1:ClearSubGoal()
    f70_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 3, 3002, TARGET_ENE_0, 9999, 0, 0)
    f70_arg0:SetNumber(2, 0)
    f70_arg0:SetNumber(6, 12)
    
end

Goal.Kengeki19 = function (f71_arg0, f71_arg1, f71_arg2)
    f71_arg1:ClearSubGoal()
    f71_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 3, 3037, TARGET_ENE_0, 9999, 0, 0)
    f71_arg0:SetNumber(6, 1)
    
end

Goal.Kengeki20 = function (f72_arg0, f72_arg1, f72_arg2)
    f72_arg1:ClearSubGoal()
    f72_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 3, 3091, TARGET_ENE_0, 9999, 0, 0)
    f72_arg0:SetNumber(6, 1)
    
end

Goal.Kengeki30 = function (f73_arg0, f73_arg1, f73_arg2)
    f73_arg1:ClearSubGoal()
    f73_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 3, 3030, TARGET_ENE_0, 9999, 0, 0)
    f73_arg0:SetTimer(2, 0)
    f73_arg0:SetNumber(6, 31)
    
end

Goal.Kengeki31 = function (f74_arg0, f74_arg1, f74_arg2)
    f74_arg1:ClearSubGoal()
    f74_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 3, 3026, TARGET_ENE_0, 9999, 0, 0)
    f74_arg0:SetNumber(6, 31)
    
end

Goal.Kengeki32 = function (f75_arg0, f75_arg1, f75_arg2)
    f75_arg1:ClearSubGoal()
    f75_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 3, 3027, TARGET_ENE_0, 9999, 0, 0)
    f75_arg0:SetNumber(6, 32)
    
end

Goal.Kengeki33 = function (f76_arg0, f76_arg1, f76_arg2)
    f76_arg1:ClearSubGoal()
    f76_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 3, 3001, TARGET_ENE_0, 9999, 0, 0)
    f76_arg0:SetNumber(6, 32)
    
end

Goal.Kengeki34 = function (f77_arg0, f77_arg1, f77_arg2)
    f77_arg1:ClearSubGoal()
    f77_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3096, TARGET_ENE_0, 9999, 0, 0)
    f77_arg0:SetNumber(6, 32)
    
end

Goal.Kengeki35 = function (f78_arg0, f78_arg1, f78_arg2)
    f78_arg1:ClearSubGoal()
    f78_arg1:AddSubGoal(GOAL_COMMON_ComboRepeat_SuccessAngle180, 10, 3039, TARGET_ENE_0, 9999, 0)
    f78_arg1:AddSubGoal(GOAL_COMMON_ComboRepeat_SuccessAngle180, 10, 3043, TARGET_ENE_0, 9999, 0)
    f78_arg0:SetNumber(6, 32)
    
end

Goal.Kengeki36 = function (f79_arg0, f79_arg1, f79_arg2)
    local f79_local0 = f79_arg0:GetRandam_Int(1, 100)
    f79_arg1:ClearSubGoal()
    if f79_local0 <= 100 then
        f79_arg1:AddSubGoal(GOAL_COMMON_ComboRepeat_SuccessAngle180, 10, 3044, TARGET_ENE_0, 9999, 0)
        f79_arg1:AddSubGoal(GOAL_COMMON_ComboRepeat_SuccessAngle180, 10, 3039, TARGET_ENE_0, 9999, 0)
        f79_arg1:AddSubGoal(GOAL_COMMON_ComboRepeat_SuccessAngle180, 10, 3043, TARGET_ENE_0, 9999, 0)
    else
        f79_arg1:AddSubGoal(GOAL_COMMON_ComboRepeat_SuccessAngle180, 10, 3044, TARGET_ENE_0, 9999, 0)
    end
    f79_arg0:SetNumber(5, 2)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Kengeki37 = function (f80_arg0, f80_arg1, f80_arg2)
    local f80_local0 = f80_arg0:GetRandam_Int(1, 100)
    f80_arg1:ClearSubGoal()
    f80_arg1:AddSubGoal(GOAL_COMMON_ComboRepeat_SuccessAngle180, 10, 3044, TARGET_ENE_0, 9999, 0)
    f80_arg0:SetNumber(5, 2)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.NoAction = function (f81_arg0, f81_arg1, f81_arg2)
    return -1
    
end

Goal.ActAfter_AdjustSpace = function (f82_arg0, f82_arg1, f82_arg2)
    
end

Goal.Update = function (f83_arg0, f83_arg1, f83_arg2)
    return Update_Default_NoSubGoal(f83_arg0, f83_arg1, f83_arg2)
    
end

Goal.Terminate = function (f84_arg0, f84_arg1, f84_arg2)
    
end


