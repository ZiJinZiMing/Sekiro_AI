RegisterTableGoal(GOAL_Kensei_540010_Battle, "GOAL_Kensei_540010_Battle")
REGISTER_GOAL_NO_UPDATE(GOAL_Kensei_540010_Battle, true)

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
    local f2_local5 = f2_arg1:GetHpRate(TARGET_SELF)
    local f2_local6 = 0
    local f2_local7 = 0
    f2_arg1:AddObserveSpecialEffectAttribute(TARGET_SELF, 3540060)
    f2_arg1:AddObserveSpecialEffectAttribute(TARGET_ENE_0, 3540081)
    f2_arg1:AddObserveSpecialEffectAttribute(TARGET_SELF, 5025)
    f2_arg1:AddObserveSpecialEffectAttribute(TARGET_ENE_0, 5026)
    f2_arg1:AddObserveSpecialEffectAttribute(TARGET_SELF, 5027)
    f2_arg1:AddObserveSpecialEffectAttribute(TARGET_SELF, 5028)
    f2_arg1:AddObserveSpecialEffectAttribute(TARGET_SELF, 5029)
    f2_arg1:AddObserveSpecialEffectAttribute(TARGET_SELF, 5030)
    f2_arg1:AddObserveSpecialEffectAttribute(TARGET_SELF, 5031)
    f2_arg1:AddObserveSpecialEffectAttribute(TARGET_SELF, 5032)
    f2_arg1:AddObserveSpecialEffectAttribute(TARGET_SELF, 5033)
    f2_arg1:AddObserveSpecialEffectAttribute(TARGET_SELF, 5034)
    f2_arg1:AddObserveSpecialEffectAttribute(TARGET_ENE_0, 109031)
    if f2_arg1:GetNumber(6) == 0 and f2_arg1:GetTimer(11) > 0 then
        f2_arg1:SetNumber(6, 1)
    end
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
    elseif f2_arg1:HasSpecialEffectId(TARGET_ENE_0, 109031) then
        if f2_local3 >= 10 then
            f2_local0[4] = 100
        elseif f2_local3 >= 6 then
            f2_local0[6] = 100
            f2_local0[9] = 100
        else
            f2_local0[9] = 100
        end
    elseif f2_arg1:IsInsideTarget(TARGET_ENE_0, AI_DIR_TYPE_B, 180) then
        f2_local0[21] = 100
        f2_local0[22] = 100
    elseif f2_arg1:GetNumber(6) == 0 and f2_arg1:GetNinsatsuNum() <= 1 then
        if f2_local3 >= 5 then
            f2_local0[6] = 1000000000
        else
            f2_local0[13] = 1000000000
        end
    elseif f2_local3 >= 10 then
        f2_local0[4] = 200
        f2_local0[17] = 100
    elseif f2_local3 >= 7 then
        f2_local0[2] = 10
        f2_local0[4] = 200
        f2_local0[12] = 100
    elseif f2_local3 >= 5 then
        f2_local0[2] = 10
        f2_local0[5] = 0
        f2_local0[6] = 20
        f2_local0[10] = 10
        f2_local0[40] = 15
        f2_local0[8] = 25
    elseif f2_local3 > 3 then
        f2_local0[2] = 10
        f2_local0[5] = 0
        f2_local0[8] = 25
        f2_local0[10] = 10
        f2_local0[16] = 50
        if f2_local3 < 4.5 - f2_arg1:GetMapHitRadius(TARGET_SELF) then
            f2_local0[1] = 10
        end
    elseif f2_local3 > 1 then
        f2_local0[1] = 10
        f2_local0[5] = 0
        f2_local0[8] = 25
        f2_local0[10] = 10
        f2_local0[13] = 10
        f2_local0[16] = 10
    else
        f2_local0[1] = 10
        f2_local0[10] = 10
        f2_local0[13] = 10
    end
    if f2_arg1:IsFinishTimer(7) == false then
        f2_local0[17] = 0
    end
    if f2_arg1:IsFinishTimer(5) == false then
        f2_local0[10] = 0
    end
    if f2_arg1:GetNumber(0) == 1 and f2_arg1:IsFinishTimer(6) == true then
        f2_local0[14] = 100
    end
    if f2_arg1:IsFinishTimer(6) == true then
        f2_local0[14] = 0
        f2_local0[40] = 0
    end
    if f2_arg1:GetNumber(5) == 1 and f2_local3 > 5 and f2_arg1:IsInsideTarget(TARGET_ENE_0, AI_DIR_TYPE_F, 140) then
        if f2_arg1:GetNinsatsuNum() >= 2 then
            f2_arg1:SetNumber(5, 0)
        else
            f2_local0[45] = 100000
        end
    elseif f2_arg1:GetNumber(4) == 1 then
        f2_local0[23] = 100000
    end
    if f2_arg1:GetNumber(5) == 1 then
        f2_arg1:SetNumber(5, 0)
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
    f2_local0[1] = SetCoolTime(f2_arg1, f2_arg2, 3000, 20, f2_local0[1], 1)
    f2_local0[2] = SetCoolTime(f2_arg1, f2_arg2, 3004, 20, f2_local0[2], 1)
    f2_local0[3] = SetCoolTime(f2_arg1, f2_arg2, 3004, 20, f2_local0[3], 1)
    f2_local0[4] = SetCoolTime(f2_arg1, f2_arg2, 3007, 20, f2_local0[4], 1)
    f2_local0[5] = SetCoolTime(f2_arg1, f2_arg2, 3010, 20, f2_local0[5], 1)
    f2_local0[6] = SetCoolTime(f2_arg1, f2_arg2, 3009, 20, f2_local0[6], 1)
    f2_local0[6] = SetCoolTime(f2_arg1, f2_arg2, 3056, 20, f2_local0[6], 1)
    f2_local0[7] = SetCoolTime(f2_arg1, f2_arg2, 3011, 20, f2_local0[7], 1)
    f2_local0[8] = SetCoolTime(f2_arg1, f2_arg2, 3020, 30, f2_local0[8], 1)
    f2_local0[9] = SetCoolTime(f2_arg1, f2_arg2, 3012, 20, f2_local0[9], 1)
    f2_local0[10] = SetCoolTime(f2_arg1, f2_arg2, 3013, 20, f2_local0[10], 1)
    f2_local0[11] = SetCoolTime(f2_arg1, f2_arg2, 3015, 20, f2_local0[11], 1)
    f2_local0[12] = SetCoolTime(f2_arg1, f2_arg2, 3024, 20, f2_local0[12], 1)
    f2_local0[13] = SetCoolTime(f2_arg1, f2_arg2, 3022, 20, f2_local0[13], 1)
    f2_local0[13] = SetCoolTime(f2_arg1, f2_arg2, 3055, 20, f2_local0[13], 1)
    f2_local0[14] = SetCoolTime(f2_arg1, f2_arg2, 3022, 20, f2_local0[14], 1)
    f2_local0[16] = SetCoolTime(f2_arg1, f2_arg2, 3000, 20, f2_local0[16], 1)
    f2_local0[40] = SetCoolTime(f2_arg1, f2_arg2, 3004, 20, f2_local0[40], 1)
    f2_local0[41] = SetCoolTime(f2_arg1, f2_arg2, 3013, 20, f2_local0[41], 1)
    f2_local0[42] = SetCoolTime(f2_arg1, f2_arg2, 3032, 20, f2_local0[42], 1)
    f2_local0[43] = SetCoolTime(f2_arg1, f2_arg2, 3030, 20, f2_local0[43], 1)
    f2_local0[44] = SetCoolTime(f2_arg1, f2_arg2, 3010, 20, f2_local0[44], 1)
    f2_local0[45] = SetCoolTime(f2_arg1, f2_arg2, 3090, 30, f2_local0[45], 0)
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
    f2_local1[32] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act32)
    f2_local1[33] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act33)
    f2_local1[34] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act34)
    f2_local1[35] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act35)
    f2_local1[36] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act36)
    f2_local1[37] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act37)
    f2_local1[39] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act39)
    f2_local1[40] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act40)
    f2_local1[41] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act41)
    f2_local1[42] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act42)
    f2_local1[43] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act43)
    f2_local1[44] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act44)
    f2_local1[45] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act45)
    local f2_local8 = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.ActAfter_AdjustSpace)
    Common_Battle_Activate(f2_arg1, f2_arg2, f2_local0, f2_local1, f2_local8, f2_local2)
    
end

Goal.Act01 = function (f3_arg0, f3_arg1, f3_arg2)
    local f3_local0 = 4.5 - f3_arg0:GetMapHitRadius(TARGET_SELF)
    local f3_local1 = 4.5 - f3_arg0:GetMapHitRadius(TARGET_SELF)
    local f3_local2 = 4.5 - f3_arg0:GetMapHitRadius(TARGET_SELF)
    local f3_local3 = 100
    local f3_local4 = 0
    local f3_local5 = 1.5
    local f3_local6 = 3
    local f3_local7 = f3_arg0:GetRandam_Int(1, 100)
    local f3_local8 = 3.5 - f3_arg0:GetMapHitRadius(TARGET_SELF)
    local f3_local9 = 3.6 - f3_arg0:GetMapHitRadius(TARGET_SELF)
    local f3_local10 = 5.9 - f3_arg0:GetMapHitRadius(TARGET_SELF)
    local f3_local11 = 0
    local f3_local12 = 0
    if f3_local7 <= 35 then
        f3_arg1:AddSubGoal(GOAL_COMMON_ComboAttackTunableSpin, 10, 3000, TARGET_ENE_0, f3_local8, f3_local11, f3_local12, 0, 0)
        f3_arg1:AddSubGoal(GOAL_COMMON_ComboRepeat, 10, 3001, TARGET_ENE_0, f3_local9, 0, 0)
        f3_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3002, TARGET_ENE_0, 9999, 0, 0)
    else
        f3_arg1:AddSubGoal(GOAL_COMMON_ComboAttackTunableSpin, 10, 3000, TARGET_ENE_0, f3_local8, f3_local11, f3_local12, 0, 0)
        f3_arg1:AddSubGoal(GOAL_COMMON_ComboRepeat, 10, 3001, TARGET_ENE_0, f3_local10, 0, 0)
        f3_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3003, TARGET_ENE_0, 9999, 0, 0)
    end

    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act02 = function (f4_arg0, f4_arg1, f4_arg2)
    local f4_local0 = 8 - f4_arg0:GetMapHitRadius(TARGET_SELF)
    local f4_local1 = 8 - f4_arg0:GetMapHitRadius(TARGET_SELF)
    local f4_local2 = 8 - f4_arg0:GetMapHitRadius(TARGET_SELF)
    local f4_local3 = 100
    local f4_local4 = 0
    local f4_local5 = 1.5
    local f4_local6 = 3
    local f4_local7 = f4_arg0:GetRandam_Int(1, 100)
    Approach_Act_Flex(f4_arg0, f4_arg1, f4_local0, f4_local1, f4_local2, f4_local3, f4_local4, f4_local5, f4_local6)
    local f4_local8 = 8 - f4_arg0:GetMapHitRadius(TARGET_SELF)
    local f4_local9 = 0
    local f4_local10 = 0
    f4_arg1:AddSubGoal(GOAL_COMMON_ComboAttackTunableSpin, 10, 3004, TARGET_ENE_0, f4_local8, f4_local9, f4_local10, 0, 0)
    if f4_local7 <= 50 then
        f4_arg1:AddSubGoal(GOAL_COMMON_ComboRepeat, 10, 3005, TARGET_ENE_0, 9999, 0, 0)
    else
        f4_arg1:AddSubGoal(GOAL_COMMON_ComboRepeat, 10, 3026, TARGET_ENE_0, 9999, 0, 0)
    end
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act03 = function (f5_arg0, f5_arg1, f5_arg2)
    local f5_local0 = 8 - f5_arg0:GetMapHitRadius(TARGET_SELF)
    local f5_local1 = 8 - f5_arg0:GetMapHitRadius(TARGET_SELF) + 2
    local f5_local2 = 8 - f5_arg0:GetMapHitRadius(TARGET_SELF) + 2
    local f5_local3 = 100
    local f5_local4 = 0
    local f5_local5 = 1.5
    local f5_local6 = 3
    Approach_Act_Flex(f5_arg0, f5_arg1, f5_local0, f5_local1, f5_local2, f5_local3, f5_local4, f5_local5, f5_local6)
    local f5_local7 = 8 - f5_arg0:GetMapHitRadius(TARGET_SELF)
    local f5_local8 = 4.5 - f5_arg0:GetMapHitRadius(TARGET_SELF)
    local f5_local9 = 0
    local f5_local10 = 0
    local f5_local11 = f5_arg0:GetRandam_Int(1, 100)
    f5_arg1:AddSubGoal(GOAL_COMMON_ComboAttackTunableSpin, 10, 3004, TARGET_ENE_0, f5_local8, f5_local9, f5_local10, 0, 0)
    f5_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3006, TARGET_ENE_0, 9999, 0, 0)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act04 = function (f6_arg0, f6_arg1, f6_arg2)
    local f6_local0 = 13 - f6_arg0:GetMapHitRadius(TARGET_SELF)
    local f6_local1 = 13 - f6_arg0:GetMapHitRadius(TARGET_SELF)
    local f6_local2 = 13 - f6_arg0:GetMapHitRadius(TARGET_SELF)
    local f6_local3 = 100
    local f6_local4 = 0
    local f6_local5 = 1.5
    local f6_local6 = 3
    local f6_local7 = f6_arg0:GetDist(TARGET_ENE_0)
    local f6_local8 = f6_arg0:GetHpRate(TARGET_SELF)
    Approach_Act_Flex(f6_arg0, f6_arg1, f6_local0, f6_local1, f6_local2, f6_local3, f6_local4, f6_local5, f6_local6)
    local f6_local9 = 0
    local f6_local10 = 0
    if f6_local7 <= 10 then
        f6_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 10, 3007, TARGET_ENE_0, 9999, f6_local9, f6_local10, 0, 0)
    else
        f6_arg1:AddSubGoal(GOAL_COMMON_ComboAttackTunableSpin, 10, 3007, TARGET_ENE_0, 9999, f6_local9, f6_local10, 0, 0)
        f6_arg1:AddSubGoal(GOAL_COMMON_ComboRepeat, 10, 3018, TARGET_ENE_0, 9999, 0, 0)
        f6_arg1:AddSubGoal(GOAL_COMMON_ComboRepeat, 10, 3007, TARGET_ENE_0, 9999, 0, 0)
    end
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act05 = function (f7_arg0, f7_arg1, f7_arg2)
    local f7_local0 = 5 - f7_arg0:GetMapHitRadius(TARGET_SELF)
    local f7_local1 = 5 - f7_arg0:GetMapHitRadius(TARGET_SELF)
    local f7_local2 = 5 - f7_arg0:GetMapHitRadius(TARGET_SELF)
    local f7_local3 = 100
    local f7_local4 = 0
    local f7_local5 = 1.5
    local f7_local6 = 3
    Approach_Act_Flex(f7_arg0, f7_arg1, f7_local0, f7_local1, f7_local2, f7_local3, f7_local4, f7_local5, f7_local6)
    local f7_local7 = 0
    local f7_local8 = 0
    f7_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 10, 3011, TARGET_ENE_0, 9999, f7_local7, f7_local8, 0, 0)
    f7_arg0:SetNumber(5, 1)
    f7_arg0:SetTimer(1, 30)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act06 = function (f8_arg0, f8_arg1, f8_arg2)
    local f8_local0 = 7.5 - f8_arg0:GetMapHitRadius(TARGET_SELF)
    local f8_local1 = 7.5 - f8_arg0:GetMapHitRadius(TARGET_SELF)
    local f8_local2 = 7.5 - f8_arg0:GetMapHitRadius(TARGET_SELF)
    local f8_local3 = 100
    local f8_local4 = 0
    local f8_local5 = 1.5
    local f8_local6 = 3
    local f8_local7 = f8_arg0:GetRandam_Int(1, 100)
    Approach_Act_Flex(f8_arg0, f8_arg1, f8_local0, f8_local1, f8_local2, f8_local3, f8_local4, f8_local5, f8_local6)
    local f8_local8 = 0
    local f8_local9 = 0
    if f8_local7 <= 70 then
        if f8_arg0:GetNinsatsuNum() >= 2 or f8_arg0:GetTimer(11) > 0 then
            f8_arg1:AddSubGoal(GOAL_COMMON_ComboAttackTunableSpin, 10, 3009, TARGET_ENE_0, 7, f8_local8, f8_local9, 0, 0)
        else
            f8_arg1:AddSubGoal(GOAL_COMMON_ComboAttackTunableSpin, 10, 3056, TARGET_ENE_0, 7, f8_local8, f8_local9, 0, 0):TimingSetTimer(11, 8, AI_TIMING_SET__ACTIVATE)
        end
        f8_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3026, TARGET_ENE_0, 9999, 0, 0)
    else
        if f8_arg0:GetNinsatsuNum() >= 2 or f8_arg0:GetTimer(11) > 0 then
            f8_arg1:AddSubGoal(GOAL_COMMON_ComboAttackTunableSpin, 10, 3009, TARGET_ENE_0, 7, f8_local8, f8_local9, 0, 0)
        else
            f8_arg1:AddSubGoal(GOAL_COMMON_ComboAttackTunableSpin, 10, 3056, TARGET_ENE_0, 7, f8_local8, f8_local9, 0, 0):TimingSetTimer(11, 8, AI_TIMING_SET__ACTIVATE)
        end
        f8_arg0:SetNumber(5, 1)
    end
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act07 = function (f9_arg0, f9_arg1, f9_arg2)
    local f9_local0 = 4.5 - f9_arg0:GetMapHitRadius(TARGET_SELF)
    local f9_local1 = 4.5 - f9_arg0:GetMapHitRadius(TARGET_SELF)
    local f9_local2 = 4.5 - f9_arg0:GetMapHitRadius(TARGET_SELF)
    local f9_local3 = 100
    local f9_local4 = 0
    local f9_local5 = 1.5
    local f9_local6 = 3
    Approach_Act_Flex(f9_arg0, f9_arg1, f9_local0, f9_local1, f9_local2, f9_local3, f9_local4, f9_local5, f9_local6)
    local f9_local7 = 0
    local f9_local8 = 0
    f9_arg1:AddSubGoal(GOAL_COMMON_ComboAttackTunableSpin, 10, 3010, TARGET_ENE_0, 7, f9_local7, f9_local8, 0, 0)
    f9_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3003, TARGET_ENE_0, 9999, 0, 0)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act08 = function (f10_arg0, f10_arg1, f10_arg2)
    local f10_local0 = 4.3 - f10_arg0:GetMapHitRadius(TARGET_SELF)
    local f10_local1 = 4.3 - f10_arg0:GetMapHitRadius(TARGET_SELF)
    local f10_local2 = 4.3 - f10_arg0:GetMapHitRadius(TARGET_SELF)
    local f10_local3 = 100
    local f10_local4 = 0
    local f10_local5 = 3
    local f10_local6 = 3
    local f10_local7 = f10_arg0:GetDist(TARGET_ENE_0)
    Approach_Act_Flex(f10_arg0, f10_arg1, f10_local0, f10_local1, f10_local2, f10_local3, f10_local4, f10_local5, f10_local6)
    local f10_local8 = 3.5 - f10_arg0:GetMapHitRadius(TARGET_SELF)
    local f10_local9 = 0
    local f10_local10 = 0
    local f10_local11 = f10_arg0:GetRandam_Int(1, 100)
    if f10_local11 <= 50 then
        f10_arg1:AddSubGoal(GOAL_COMMON_ComboAttackTunableSpin, 10, 3020, TARGET_ENE_0, 9999, f10_local9, f10_local10, 0, 0)
        f10_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3021, TARGET_ENE_0, 9999, 0, 0)
    else
        f10_arg1:AddSubGoal(GOAL_COMMON_ComboAttackTunableSpin, 10, 3020, TARGET_ENE_0, 9999, f10_local9, f10_local10, 0, 0)
        f10_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3032, TARGET_ENE_0, 9999, 0, 0)
        f10_arg0:SetNumber(5, 1)
    end
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act09 = function (f11_arg0, f11_arg1, f11_arg2)
    local f11_local0 = 5 - f11_arg0:GetMapHitRadius(TARGET_SELF)
    local f11_local1 = 5 - f11_arg0:GetMapHitRadius(TARGET_SELF)
    local f11_local2 = 5 - f11_arg0:GetMapHitRadius(TARGET_SELF)
    local f11_local3 = 100
    local f11_local4 = 0
    local f11_local5 = 1.5
    local f11_local6 = 3
    Approach_Act_Flex(f11_arg0, f11_arg1, f11_local0, f11_local1, f11_local2, f11_local3, f11_local4, f11_local5, f11_local6)
    local f11_local7 = 0
    local f11_local8 = 0
    f11_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 10, 3012, TARGET_ENE_0, 9999, f11_local7, f11_local8, 0, 0)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act10 = function (f12_arg0, f12_arg1, f12_arg2)
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
    f12_arg0:DeleteObserveSpecialEffectAttribute(TARGET_SELF, 5027)
    f12_arg1:AddSubGoal(GOAL_COMMON_ComboAttackTunableSpin, 10, 3013, TARGET_ENE_0, 9999, f12_local8, f12_local9, 0, 0)
    if f12_local7 >= 35 then
        f12_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3009, TARGET_ENE_0, 9999, 0, 0)
    else
        f12_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3021, TARGET_ENE_0, 9999, 0, 0)
    end
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act11 = function (f13_arg0, f13_arg1, f13_arg2)
    local f13_local0 = 5.9 - f13_arg0:GetMapHitRadius(TARGET_SELF)
    local f13_local1 = 5.9 - f13_arg0:GetMapHitRadius(TARGET_SELF)
    local f13_local2 = 5.9 - f13_arg0:GetMapHitRadius(TARGET_SELF)
    local f13_local3 = 100
    local f13_local4 = 0
    local f13_local5 = 1.5
    local f13_local6 = 3
    local f13_local7 = f13_arg0:GetRandam_Int(1, 100)
    Approach_Act_Flex(f13_arg0, f13_arg1, f13_local0, f13_local1, f13_local2, f13_local3, f13_local4, f13_local5, f13_local6)
    local f13_local8 = 0
    local f13_local9 = 0
    f13_arg1:AddSubGoal(GOAL_COMMON_ComboAttackTunableSpin, 10, 3025, TARGET_ENE_0, 7, f13_local8, f13_local9, 0, 0)
    f13_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3026, TARGET_ENE_0, 9999, 0, 0)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act12 = function (f14_arg0, f14_arg1, f14_arg2)
    local f14_local0 = 7.5 - f14_arg0:GetMapHitRadius(TARGET_SELF)
    local f14_local1 = 7.5 - f14_arg0:GetMapHitRadius(TARGET_SELF)
    local f14_local2 = 7.5 - f14_arg0:GetMapHitRadius(TARGET_SELF)
    local f14_local3 = 100
    local f14_local4 = 0
    local f14_local5 = 1.5
    local f14_local6 = 3
    local f14_local7 = f14_arg0:GetRandam_Int(1, 100)
    Approach_Act_Flex(f14_arg0, f14_arg1, f14_local0 + 3, f14_local1, f14_local2, f14_local3, f14_local4, f14_local5, f14_local6)
    local f14_local8 = 0
    local f14_local9 = 0
    if f14_local7 <= 0 then
        f14_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 10, 3024, TARGET_ENE_0, 9999, f14_local8, f14_local9, 0, 0)
    else
        --f14_arg1:AddSubGoal(GOAL_COMMON_ComboAttackTunableSpin, 10, 3024, TARGET_ENE_0, 10.5 - f14_arg0:GetMapHitRadius(TARGET_SELF), f14_local8, f14_local9, 0, 0)
        f14_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3016, TARGET_ENE_0, DistToAtt2, f14_local8, f14_local9, 0, 0)
    end
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act13 = function (f15_arg0, f15_arg1, f15_arg2)
    local f15_local0 = f15_arg0:GetRandam_Int(1, 100)
    local f15_local1 = f15_arg0:GetRandam_Int(1, 100)
    local f15_local2 = 0
    local f15_local3 = 0
    local f15_local4 = f15_arg0:GetHpRate(TARGET_SELF)
    if f15_arg0:IsFinishTimer(7) == true then
        if f15_local0 <= 80 then
            if f15_arg0:GetNinsatsuNum() >= 2 or f15_arg0:GetTimer(11) > 0 then
                f15_arg1:AddSubGoal(GOAL_COMMON_ComboAttackTunableSpin, 10, 3022, TARGET_ENE_0, 9999, f15_local2, f15_local3, 0, 0)
            else
                f15_arg1:AddSubGoal(GOAL_COMMON_ComboAttackTunableSpin, 10, 3055, TARGET_ENE_0, 9999, f15_local2, f15_local3, 0, 0):TimingSetTimer(11, 8, AI_TIMING_SET__ACTIVATE)
            end
            f15_arg1:AddSubGoal(GOAL_COMMON_ComboRepeat, 10, 3018, TARGET_ENE_0, 10.5 - f15_arg0:GetMapHitRadius(TARGET_SELF) + 2, f15_local2, f15_local3, 0, 0):TimingSetTimer(7, 20, AI_TIMING_SET__ACTIVATE)
            f15_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3016, TARGET_ENE_0, 9999, f15_local2, f15_local3, 0, 0)
        else
            if f15_arg0:GetNinsatsuNum() >= 2 or f15_arg0:GetTimer(11) > 0 then
                f15_arg1:AddSubGoal(GOAL_COMMON_ComboAttackTunableSpin, 10, 3022, TARGET_ENE_0, 9999, f15_local2, f15_local3, 0, 0)
            else
                f15_arg1:AddSubGoal(GOAL_COMMON_ComboAttackTunableSpin, 10, 3055, TARGET_ENE_0, 9999, f15_local2, f15_local3, 0, 0):TimingSetTimer(11, 8, AI_TIMING_SET__ACTIVATE)
            end
            f15_arg1:AddSubGoal(GOAL_COMMON_ComboRepeat, 10, 3018, TARGET_ENE_0, 10.5 - f15_arg0:GetMapHitRadius(TARGET_SELF) + 2, f15_local2, f15_local3, 0, 0):TimingSetTimer(7, 20, AI_TIMING_SET__ACTIVATE)
            f15_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3014, TARGET_ENE_0, 9999, f15_local2, f15_local3, 0, 0)
        end
    else
        if f15_arg0:GetNinsatsuNum() >= 2 or f15_arg0:GetTimer(11) > 0 then
            f15_arg1:AddSubGoal(GOAL_COMMON_ComboAttackTunableSpin, 10, 3022, TARGET_ENE_0, 9999, f15_local2, f15_local3, 0, 0)
        else
            f15_arg1:AddSubGoal(GOAL_COMMON_ComboAttackTunableSpin, 10, 3055, TARGET_ENE_0, 9999, f15_local2, f15_local3, 0, 0):TimingSetTimer(11, 8, AI_TIMING_SET__ACTIVATE)
        end
        if f15_local1 <= 50 then
            f15_arg0:SetNumber(4, 1)
        end
    end
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act14 = function (f16_arg0, f16_arg1, f16_arg2)
    local f16_local0 = 0
    local f16_local1 = 0
    f16_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 10, 3008, TARGET_ENE_0, 9999, f16_local0, f16_local1, 0, 0)
    f16_arg0:SetNumber(0, 0)
    f16_arg0:SetTimer(6, 60)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act15 = function (f17_arg0, f17_arg1, f17_arg2)
    local f17_local0 = 10.5 - f17_arg0:GetMapHitRadius(TARGET_SELF)
    local f17_local1 = 10.5 - f17_arg0:GetMapHitRadius(TARGET_SELF)
    local f17_local2 = 10.5 - f17_arg0:GetMapHitRadius(TARGET_SELF)
    local f17_local3 = 100
    local f17_local4 = 0
    local f17_local5 = 1.5
    local f17_local6 = 3
    Approach_Act_Flex(f17_arg0, f17_arg1, f17_local0, f17_local1, f17_local2, f17_local3, f17_local4, f17_local5, f17_local6)
    local f17_local7 = 0
    local f17_local8 = 0
    f17_arg1:AddSubGoal(GOAL_COMMON_ComboAttackTunableSpin, 10, 3016, TARGET_ENE_0, 9999, f17_local7, f17_local8, 0, 0)
    f17_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3015, TARGET_ENE_0, 9999, 0, 0)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act16 = function (f18_arg0, f18_arg1, f18_arg2)
    local f18_local0 = 4.5 - f18_arg0:GetMapHitRadius(TARGET_SELF)
    local f18_local1 = 4.5 - f18_arg0:GetMapHitRadius(TARGET_SELF)
    local f18_local2 = 4.5 - f18_arg0:GetMapHitRadius(TARGET_SELF)
    local f18_local3 = 100
    local f18_local4 = 0
    local f18_local5 = 1.5
    local f18_local6 = 3
    Approach_Act_Flex(f18_arg0, f18_arg1, f18_local0, f18_local1, f18_local2, f18_local3, f18_local4, f18_local5, f18_local6)
    local f18_local7 = 0
    local f18_local8 = 0
    f18_arg1:AddSubGoal(GOAL_COMMON_ComboAttackTunableSpin, 10, 3000, TARGET_ENE_0, 9999, f18_local7, f18_local8, 0, 0)
    f18_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3027, TARGET_ENE_0, 9999, 0, 0)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act17 = function (f19_arg0, f19_arg1, f19_arg2)
    local f19_local0 = 13.5 - f19_arg0:GetMapHitRadius(TARGET_SELF)
    local f19_local1 = 13.5 - f19_arg0:GetMapHitRadius(TARGET_SELF)
    local f19_local2 = 13.5 - f19_arg0:GetMapHitRadius(TARGET_SELF)
    local f19_local3 = 100
    local f19_local4 = 0
    local f19_local5 = 1.5
    local f19_local6 = 3
    Approach_Act_Flex(f19_arg0, f19_arg1, f19_local0, f19_local1, f19_local2, f19_local3, f19_local4, f19_local5, f19_local6)
    local f19_local7 = 0
    local f19_local8 = 0
    f19_arg1:AddSubGoal(GOAL_COMMON_ComboAttackTunableSpin, 10, 3023, TARGET_ENE_0, 9999, f19_local7, f19_local8, 0, 0):TimingSetTimer(7, 20, AI_TIMING_SET__ACTIVATE)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act21 = function (f20_arg0, f20_arg1, f20_arg2)
    local f20_local0 = 3
    local f20_local1 = 45
    f20_arg1:AddSubGoal(GOAL_COMMON_Turn, f20_local0, TARGET_ENE_0, f20_local1, -1, GOAL_RESULT_Success, true)
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
    
end

Goal.Act22 = function (f21_arg0, f21_arg1, f21_arg2)
    local f21_local0 = 3
    local f21_local1 = 0
    local f21_local2 = 5202
    if SpaceCheck(f21_arg0, f21_arg1, -45, 2) == true then
        if SpaceCheck(f21_arg0, f21_arg1, 45, 2) == true then
            if f21_arg0:IsInsideTarget(TARGET_ENE_0, AI_DIR_TYPE_R, 180) then
                f21_local2 = 5202
            else
                f21_local2 = 5203
            end
        else
            f21_local2 = 5202
        end
    elseif SpaceCheck(f21_arg0, f21_arg1, 45, 2) == true then
        f21_local2 = 5203
    else
    end
    f21_arg1:AddSubGoal(GOAL_COMMON_SpinStep, f21_local0, f21_local2, TARGET_ENE_0, f21_local1, AI_DIR_TYPE_R, 0)
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
    
end

Goal.Act23 = function (f22_arg0, f22_arg1, f22_arg2)
    local f22_local0 = f22_arg0:GetDist(TARGET_ENE_0)
    local f22_local1 = f22_arg0:GetSpRate(TARGET_SELF)
    local f22_local2 = 20
    local f22_local3 = f22_arg0:GetRandam_Int(1, 100)
    local f22_local4 = -1
    local f22_local5 = 0
    if SpaceCheck(f22_arg0, f22_arg1, -90, 1) == true then
        if SpaceCheck(f22_arg0, f22_arg1, 90, 1) == true then
            if f22_arg0:IsInsideTargetEx(TARGET_ENE_0, TARGET_SELF, AI_DIR_TYPE_R, 180, 999) then
                f22_local5 = 1
            else
                f22_local5 = 0
            end
        else
            f22_local5 = 0
        end
    elseif SpaceCheck(f22_arg0, f22_arg1, 90, 1) == true then
        f22_local5 = 1
    else
    end
    local f22_local6 = 3
    local f22_local7 = f22_arg0:GetRandam_Int(30, 45)
    f22_arg0:SetNumber(10, f22_local5)
    f22_arg1:AddSubGoal(GOAL_COMMON_SidewayMove, f22_local6, TARGET_ENE_0, f22_local5, f22_local7, true, true, f22_local4):TimingSetNumber(4, 0, AI_TIMING_SET__ACTIVATE)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act24 = function (f23_arg0, f23_arg1, f23_arg2)
    local f23_local0 = f23_arg0:GetDist(TARGET_ENE_0)
    local f23_local1 = 3
    local f23_local2 = 0
    local f23_local3 = 5201
    if SpaceCheck(f23_arg0, f23_arg1, 180, 2) ~= true or SpaceCheck(f23_arg0, f23_arg1, 180, 4) ~= true or f23_local0 > 4 then
    else
        f23_local3 = 5201
        if false then
        else
        end
    end
    f23_arg1:AddSubGoal(GOAL_COMMON_SpinStep, f23_local1, f23_local3, TARGET_ENE_0, f23_local2, AI_DIR_TYPE_B, 0)
    f23_arg0:SetNumber(5, 1)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act25 = function (f24_arg0, f24_arg1, f24_arg2)
    local f24_local0 = f24_arg0:GetRandam_Float(2, 4)
    local f24_local1 = f24_arg0:GetRandam_Float(5, 7)
    local f24_local2 = f24_arg0:GetDist(TARGET_ENE_0)
    local f24_local3 = -1
    f24_arg1:AddSubGoal(GOAL_COMMON_LeaveTarget, f24_local0, TARGET_ENE_0, f24_local1, TARGET_ENE_0, true, f24_local3)
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
    
end

Goal.Act26 = function (f25_arg0, f25_arg1, f25_arg2)
    f25_arg1:AddSubGoal(GOAL_COMMON_Wait, 0.5, TARGET_SELF, 0, 0, 0)
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
    
end

Goal.Act27 = function (f26_arg0, f26_arg1, f26_arg2)
    local f26_local0 = f26_arg0:GetDist(TARGET_ENE_0)
    local f26_local1 = f26_arg0:GetRandam_Int(1, 100)
    local f26_local2 = 8
    local f26_local3 = 5
    local f26_local4 = f26_arg0:GetRandam_Float(2, 4)
    local f26_local5 = f26_arg0:GetRandam_Int(30, 45)
    if f26_local0 >= 8 then
        f26_arg1:AddSubGoal(GOAL_COMMON_ApproachTarget, f26_local4, TARGET_ENE_0, f26_local2, TARGET_ENE_0, true, -1)
    elseif f26_local0 <= 5 then
        f26_arg1:AddSubGoal(GOAL_COMMON_LeaveTarget, f26_local4, TARGET_ENE_0, f26_local3, TARGET_ENE_0, true, -1)
    end
    f26_arg1:AddSubGoal(GOAL_COMMON_SidewayMove, f26_local4, TARGET_ENE_0, f26_arg0:GetRandam_Int(0, 1), f26_local5, true, true, -1)
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
    
end

Goal.Act28 = function (f27_arg0, f27_arg1, f27_arg2)
    local f27_local0 = f27_arg0:GetDist(TARGET_ENE_0)
    local f27_local1 = 1.5
    local f27_local2 = 1.5
    local f27_local3 = f27_arg0:GetRandam_Int(30, 45)
    local f27_local4 = -1
    local f27_local5 = f27_arg0:GetRandam_Int(0, 1)
    if f27_local0 <= 3 then
        f27_arg1:AddSubGoal(GOAL_COMMON_SidewayMove, f27_local1, TARGET_ENE_0, f27_local5, f27_local3, true, true, f27_local4)
    elseif f27_local0 <= 8 then
        f27_arg1:AddSubGoal(GOAL_COMMON_ApproachTarget, f27_local2, TARGET_ENE_0, 3, TARGET_SELF, true, -1)
    else
        f27_arg1:AddSubGoal(GOAL_COMMON_ApproachTarget, f27_local2, TARGET_ENE_0, 8, TARGET_SELF, false, -1)
    end
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
    
end

Goal.Act30 = function (f28_arg0, f28_arg1, f28_arg2)
    local f28_local0 = 4.5 - f28_arg0:GetMapHitRadius(TARGET_SELF)
    local f28_local1 = 4.5 - f28_arg0:GetMapHitRadius(TARGET_SELF)
    local f28_local2 = 4.5 - f28_arg0:GetMapHitRadius(TARGET_SELF)
    local f28_local3 = 100
    local f28_local4 = 0
    local f28_local5 = 1.5
    local f28_local6 = 3
    Approach_Act_Flex(f28_arg0, f28_arg1, f28_local0 + 1, f28_local1, f28_local2, f28_local3, f28_local4, f28_local5, f28_local6)
    local f28_local7 = 0
    local f28_local8 = 0
    f28_arg1:AddSubGoal(GOAL_COMMON_ComboAttackTunableSpin, 10, 3003, TARGET_ENE_0, 9999, f28_local7, f28_local8, 0, 0)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act31 = function (f29_arg0, f29_arg1, f29_arg2)
    local f29_local0 = 4.5 - f29_arg0:GetMapHitRadius(TARGET_SELF)
    local f29_local1 = 4.5 - f29_arg0:GetMapHitRadius(TARGET_SELF)
    local f29_local2 = 4.5 - f29_arg0:GetMapHitRadius(TARGET_SELF)
    local f29_local3 = 100
    local f29_local4 = 0
    local f29_local5 = 1.5
    local f29_local6 = 3
    Approach_Act_Flex(f29_arg0, f29_arg1, f29_local0 + 1, f29_local1, f29_local2, f29_local3, f29_local4, f29_local5, f29_local6)
    local f29_local7 = 0
    local f29_local8 = 0
    f29_arg1:AddSubGoal(GOAL_COMMON_ComboAttackTunableSpin, 10, 3004, TARGET_ENE_0, 9999, f29_local7, f29_local8, 0, 0)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act32 = function (f30_arg0, f30_arg1, f30_arg2)
    local f30_local0 = 4.5 - f30_arg0:GetMapHitRadius(TARGET_SELF)
    local f30_local1 = 4.5 - f30_arg0:GetMapHitRadius(TARGET_SELF)
    local f30_local2 = 4.5 - f30_arg0:GetMapHitRadius(TARGET_SELF)
    local f30_local3 = 100
    local f30_local4 = 0
    local f30_local5 = 1.5
    local f30_local6 = 3
    Approach_Act_Flex(f30_arg0, f30_arg1, f30_local0 + 1, f30_local1, f30_local2, f30_local3, f30_local4, f30_local5, f30_local6)
    local f30_local7 = 0
    local f30_local8 = 0
    f30_arg1:AddSubGoal(GOAL_COMMON_ComboAttackTunableSpin, 10, 3004, TARGET_ENE_0, 9999, f30_local7, f30_local8, 0, 0)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act33 = function (f31_arg0, f31_arg1, f31_arg2)
    local f31_local0 = 4.5 - f31_arg0:GetMapHitRadius(TARGET_SELF)
    local f31_local1 = 4.5 - f31_arg0:GetMapHitRadius(TARGET_SELF)
    local f31_local2 = 4.5 - f31_arg0:GetMapHitRadius(TARGET_SELF)
    local f31_local3 = 100
    local f31_local4 = 0
    local f31_local5 = 1.5
    local f31_local6 = 3
    Approach_Act_Flex(f31_arg0, f31_arg1, f31_local0 + 1, f31_local1, f31_local2, f31_local3, f31_local4, f31_local5, f31_local6)
    local f31_local7 = 0
    local f31_local8 = 0
    f31_arg1:AddSubGoal(GOAL_COMMON_ComboAttackTunableSpin, 10, 3029, TARGET_ENE_0, 9999, f31_local7, f31_local8, 0, 0)
    f31_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3005, TARGET_ENE_0, DistToAtt2, f31_local7, f31_local8, 0, 0)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act34 = function (f32_arg0, f32_arg1, f32_arg2)
    local f32_local0 = 4.3 - f32_arg0:GetMapHitRadius(TARGET_SELF)
    local f32_local1 = 4.3 - f32_arg0:GetMapHitRadius(TARGET_SELF)
    local f32_local2 = 4.3 - f32_arg0:GetMapHitRadius(TARGET_SELF)
    local f32_local3 = 100
    local f32_local4 = 0
    local f32_local5 = 1.5
    local f32_local6 = 3
    Approach_Act_Flex(f32_arg0, f32_arg1, f32_local0 + 1, f32_local1, f32_local2, f32_local3, f32_local4, f32_local5, f32_local6)
    local f32_local7 = 0
    local f32_local8 = 0
    f32_arg1:AddSubGoal(GOAL_COMMON_ComboAttackTunableSpin, 10, 3027, TARGET_ENE_0, 9999, f32_local7, f32_local8, 0, 0)
    f32_arg1:AddSubGoal(GOAL_COMMON_ComboRepeat, 10, 3030, TARGET_ENE_0, 9999, f32_local7, f32_local8, 0, 0)
    f32_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3029, TARGET_ENE_0, DistToAtt2, f32_local7, f32_local8, 0, 0)
    f32_arg0:SetNumber(5, 1)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act36 = function (f33_arg0, f33_arg1, f33_arg2)
    f33_arg0:DeleteObserveSpecialEffectAttribute(TARGET_SELF, 5026)
    local f33_local0 = 4.5 - f33_arg0:GetMapHitRadius(TARGET_SELF)
    local f33_local1 = 4.5 - f33_arg0:GetMapHitRadius(TARGET_SELF)
    local f33_local2 = 4.5 - f33_arg0:GetMapHitRadius(TARGET_SELF)
    local f33_local3 = 100
    local f33_local4 = 0
    local f33_local5 = 1.5
    local f33_local6 = 3
    Approach_Act_Flex(f33_arg0, f33_arg1, f33_local0, f33_local1, f33_local2, f33_local3, f33_local4, f33_local5, f33_local6)
    local f33_local7 = 0
    local f33_local8 = 0
    f33_arg1:AddSubGoal(GOAL_COMMON_ComboAttackTunableSpin, 10, 3010, TARGET_ENE_0, 9999, f33_local7, f33_local8, 0, 0)
    f33_arg1:AddSubGoal(GOAL_COMMON_ComboRepeat, 10, 3029, TARGET_ENE_0, 9999, 0, 0)
    f33_arg0:SetNumber(5, 1)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act39 = function (f34_arg0, f34_arg1, f34_arg2)
    local f34_local0 = 3
    local f34_local1 = 0
    local f34_local2 = 4.5
    local f34_local3 = f34_arg0:GetRandam_Int(30, 45)
    if SpaceCheck(f34_arg0, f34_arg1, 180, 5) then
        f34_arg1:AddSubGoal(GOAL_COMMON_SpinStep, f34_local0, 5201, TARGET_ENE_0, f34_local1, AI_DIR_TYPE_B, 0)
        f34_local2 = 3.5
    end
    local f34_local4 = 0
    if SpaceCheck(f34_arg0, f34_arg1, -90, 1) == true then
        if SpaceCheck(f34_arg0, f34_arg1, 90, 1) == true then
            if f34_arg0:IsInsideTarget(TARGET_ENE_0, AI_DIR_TYPE_R, 180) then
                f34_local4 = 0
            else
                f34_local4 = 1
            end
        else
            f34_local4 = 0
        end
    elseif SpaceCheck(f34_arg0, f34_arg1, 90, 1) == true then
        f34_local4 = 1
    else
    end
    f34_arg1:AddSubGoal(GOAL_COMMON_SidewayMove, f34_local2, TARGET_ENE_0, f34_local4, f34_local3, true, true, -1)
    return GETWELLSPACE_ODDS
    
end

Goal.Act40 = function (f35_arg0, f35_arg1, f35_arg2)
    local f35_local0 = 8 - f35_arg0:GetMapHitRadius(TARGET_SELF)
    local f35_local1 = 8 - f35_arg0:GetMapHitRadius(TARGET_SELF)
    local f35_local2 = 8 - f35_arg0:GetMapHitRadius(TARGET_SELF)
    local f35_local3 = 100
    local f35_local4 = 0
    local f35_local5 = 1.5
    local f35_local6 = 3
    Approach_Act_Flex(f35_arg0, f35_arg1, f35_local0, f35_local1, f35_local2, f35_local3, f35_local4, f35_local5, f35_local6)
    local f35_local7 = 0
    local f35_local8 = 0
    f35_arg1:AddSubGoal(GOAL_COMMON_ComboAttackTunableSpin, 10, 3016, TARGET_ENE_0, DistToAtt1, f35_local7, f35_local8, 0, 0)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act41 = function (f36_arg0, f36_arg1, f36_arg2)
    local f36_local0 = 7.5 - f36_arg0:GetMapHitRadius(TARGET_SELF)
    local f36_local1 = 7.5 - f36_arg0:GetMapHitRadius(TARGET_SELF)
    local f36_local2 = 7.5 - f36_arg0:GetMapHitRadius(TARGET_SELF)
    local f36_local3 = 100
    local f36_local4 = 0
    local f36_local5 = 1.5
    local f36_local6 = 3
    Approach_Act_Flex(f36_arg0, f36_arg1, f36_local0, f36_local1, f36_local2, f36_local3, f36_local4, f36_local5, f36_local6)
    local f36_local7 = 0
    local f36_local8 = 0
    f36_arg1:AddSubGoal(GOAL_COMMON_ComboAttackTunableSpin, 10, 3024, TARGET_ENE_0, 9999, f36_local7, f36_local8, 0, 0)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act42 = function (f37_arg0, f37_arg1, f37_arg2)
    local f37_local0 = 7.5 - f37_arg0:GetMapHitRadius(TARGET_SELF)
    local f37_local1 = 7.5 - f37_arg0:GetMapHitRadius(TARGET_SELF)
    local f37_local2 = 7.5 - f37_arg0:GetMapHitRadius(TARGET_SELF)
    local f37_local3 = 100
    local f37_local4 = 0
    local f37_local5 = 1.5
    local f37_local6 = 3
    Approach_Act_Flex(f37_arg0, f37_arg1, f37_local0, f37_local1, f37_local2, f37_local3, f37_local4, f37_local5, f37_local6)
    local f37_local7 = 0
    local f37_local8 = 0
    if f37_arg0:GetNinsatsuNum() >= 2 or f37_arg0:GetTimer(11) > 0 then
        f37_arg1:AddSubGoal(GOAL_COMMON_ComboAttackTunableSpin, 10, 3009, TARGET_ENE_0, 7, f37_local7, f37_local8, 0, 0)
    else
        f37_arg1:AddSubGoal(GOAL_COMMON_ComboAttackTunableSpin, 10, 3056, TARGET_ENE_0, 7, f37_local7, f37_local8, 0, 0):TimingSetTimer(11, 8, AI_TIMING_SET__ACTIVATE)
    end
    f37_arg0:SetNumber(5, 1)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act43 = function (f38_arg0, f38_arg1, f38_arg2)
    local f38_local0 = 0
    local f38_local1 = 0
    f38_arg1:AddSubGoal(GOAL_COMMON_ComboAttackTunableSpin, 10, 3003, TARGET_ENE_0, 9999, f38_local0, f38_local1, 0, 0)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act44 = function (f39_arg0, f39_arg1, f39_arg2)
    f39_arg0:DeleteObserveSpecialEffectAttribute(TARGET_SELF, 5026)
    local f39_local0 = 4.5 - f39_arg0:GetMapHitRadius(TARGET_SELF)
    local f39_local1 = 4.5 - f39_arg0:GetMapHitRadius(TARGET_SELF)
    local f39_local2 = 4.5 - f39_arg0:GetMapHitRadius(TARGET_SELF)
    local f39_local3 = 100
    local f39_local4 = 0
    local f39_local5 = 1.5
    local f39_local6 = 3
    Approach_Act_Flex(f39_arg0, f39_arg1, f39_local0, f39_local1, f39_local2, f39_local3, f39_local4, f39_local5, f39_local6)
    local f39_local7 = 0
    local f39_local8 = 0
    f39_arg1:AddSubGoal(GOAL_COMMON_ComboAttackTunableSpin, 10, 3010, TARGET_ENE_0, 9999, f39_local7, f39_local8, 0, 0)
    f39_arg1:AddSubGoal(GOAL_COMMON_ComboRepeat, 10, 3031, TARGET_ENE_0, 9999, 0, 0)
    f39_arg0:SetNumber(5, 1)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act45 = function (f40_arg0, f40_arg1, f40_arg2)
    local f40_local0 = 0
    local f40_local1 = 0
    f40_arg1:AddSubGoal(GOAL_COMMON_ComboRepeat, 10, 3090, TARGET_ENE_0, 9999, f40_local0, f40_local1, 0, 0)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Interrupt = function (f41_arg0, f41_arg1, f41_arg2)
    local f41_local0 = f41_arg1:GetSpecialEffectActivateInterruptType(0)
    local f41_local1 = f41_arg1:GetDist(TARGET_ENE_0)
    local f41_local2 = f41_arg1:GetRandam_Int(1, 100)
    local f41_local3 = f41_arg1:GetHpRate(TARGET_SELF)
    if f41_arg1:IsLadderAct(TARGET_SELF) then
        return false
    end
    if not f41_arg1:HasSpecialEffectId(TARGET_SELF, 200004) then
        return false
    end
    if f41_arg1:IsInterupt(INTERUPT_ParryTiming) then
        return Common_Parry(f41_arg1, f41_arg2, 100, 0, 1, 3102)
    end
    if f41_arg1:IsInterupt(INTERUPT_Damaged) then
        return f41_arg0.Damaged(f41_arg1, f41_arg2)
    end
    if Interupt_PC_Break(f41_arg1) then
        f41_arg1:Replanning()
        return true
    end
    if Interupt_Use_Item(f41_arg1, 10, 10) and f41_arg1:IsInsideTarget(TARGET_ENE_0, AI_DIR_TYPE_F, 180) then
        if f41_local1 < 5.5 then
            f41_arg2:ClearSubGoal()
            f41_arg2:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 1, 3012, TARGET_ENE_0, 9999, 0)
            return true
        elseif f41_local1 < 13 then
            f41_arg2:ClearSubGoal()
            f41_arg2:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 1, 3007, TARGET_ENE_0, 9999, 0)
            return true
        else
            f41_arg1:Replanning()
            return true
        end
    end
    if f41_arg1:IsInterupt(INTERUPT_ActivateSpecialEffect) then
        if f41_local0 == 109031 and f41_arg1:HasSpecialEffectId(TARGET_SELF, 3540050) then
            f41_arg2:ClearSubGoal()
            f41_arg2:AddSubGoal(GOAL_COMMON_ComboRepeat, 4, 3012, TARGET_ENE_0, 9999, 0)
            return true
        elseif f41_local0 == 3540081 and f41_arg1:HasSpecialEffectId(TARGET_SELF, 3540080) then
            f41_arg2:ClearSubGoal()
            f41_arg2:AddSubGoal(GOAL_COMMON_ComboFinal, 5, 3013, TARGET_ENE_0, 9999, 0, 0)
            f41_arg1:SetTimer(5, 7)
            return true
        elseif f41_local0 == 5027 and f41_local2 <= 100 then
            if f41_local1 <= 5 then
                f41_arg2:ClearSubGoal()
                f41_arg2:AddSubGoal(GOAL_COMMON_ComboFinal, 3, 3015, TARGET_ENE_0, 9999, 0, 0)
                return true
            end
        elseif f41_local0 == 5028 then
            f41_arg1:SetNumber(0, 1)
            return true
        elseif f41_local0 == 5031 then
            if f41_local2 <= 100 and f41_arg1:IsInsideTargetEx(TARGET_SELF, TARGET_ENE_0, AI_DIR_TYPE_F, 45, 5) then
                f41_arg2:ClearSubGoal()
                f41_arg2:AddSubGoal(GOAL_COMMON_ComboRepeat, 2, 3028, TARGET_ENE_0, 9999, 0, 0)
                return true
            end
        elseif f41_local0 == 5034 and f41_local1 >= 4 then
            f41_arg2:ClearSubGoal()
            if f41_local2 > 40 then
                f41_arg2:AddSubGoal(GOAL_COMMON_ComboRepeat, 10, 3026, TARGET_ENE_0, 9999, 0, 0)
            else
                f41_arg2:AddSubGoal(GOAL_COMMON_ComboRepeat, 10, 3005, TARGET_ENE_0, 9999, 0, 0)
            end
        end
    end
    if f41_arg1:IsInterupt(INTERUPT_ShootImpact) then
        f41_arg2:ClearSubGoal()
        f41_arg2:AddSubGoal(GOAL_COMMON_EndureAttack, 0.1, 3100, TARGET_ENE_0, 9999, 0)
        return true
    end
    return false
    
end

Goal.Kengeki_Activate = function (f42_arg0, f42_arg1, f42_arg2, f42_arg3)
    local f42_local0 = ReturnKengekiSpecialEffect(f42_arg1)
    if f42_local0 == 0 then
        return false
    end
    local f42_local1 = {}
    local f42_local2 = {}
    local f42_local3 = {}
    Common_Clear_Param(f42_local1, f42_local2, f42_local3)
    local f42_local4 = f42_arg1:GetDist(TARGET_ENE_0)
    local f42_local5 = f42_arg1:GetSp(TARGET_SELF)
    local f42_local6 = f42_arg1:GetHpRate(TARGET_SELF)
    if f42_local5 <= 0 then
        f42_local1[50] = 100
    elseif f42_local0 == 200205 or f42_local0 == 200200 then
        if f42_local4 >= 5 then
            f42_local1[9] = 100
            f42_local1[11] = 50
        else
            f42_local1[4] = 20
            f42_local1[5] = 30
            f42_local1[20] = 20
        end
    elseif f42_local0 == 200206 or f42_local0 == 200201 then
        if f42_local4 >= 5 then
            f42_local1[9] = 100
            f42_local1[8] = 50
        else
            f42_local1[1] = 40
            f42_local1[4] = 20
            f42_local1[20] = 20
        end
    elseif f42_local0 == 200229 then
        if f42_local4 >= 5 then
            f42_local1[50] = 100
        else
            f42_local1[3] = 40
        end
    elseif f42_local0 == 200215 then
        if f42_local4 >= 5 then
            f42_local1[50] = 100
        else
            f42_local1[3] = 40
            f42_local1[4] = 20
            f42_local1[5] = 30
            f42_local1[20] = 20
            if f42_local4 <= 2 - f42_arg1:GetMapHitRadius(TARGET_SELF) - 0.5 then
                f42_local1[4] = 100
                f42_local1[20] = 35
            end
        end
    elseif f42_local0 == 200216 then
        if f42_local4 >= 5 then
            f42_local1[50] = 100
        else
            f42_local1[1] = 40
            f42_local1[2] = 40
            f42_local1[4] = 20
            f42_local1[20] = 35
        end
    elseif f42_local0 == 200210 then
        if f42_local4 >= 5 then
            f42_local1[50] = 100
            f42_local1[11] = 50
        else
            f42_local1[3] = 40
            f42_local1[4] = 20
            f42_local1[5] = 30
            f42_local1[20] = 35
            f42_local1[11] = 100
            if f42_local4 <= 2 - f42_arg1:GetMapHitRadius(TARGET_SELF) - 0.5 then
                f42_local1[4] = 100
                f42_local1[20] = 30
            end
        end
    elseif f42_local0 == 200211 then
        if f42_local4 >= 5 then
            f42_local1[50] = 100
            f42_local1[8] = 50
        else
            f42_local1[1] = 40
            f42_local1[2] = 40
            f42_local1[4] = 20
            f42_local1[20] = 35
            f42_local1[8] = 100
        end
    elseif f42_local0 == 200225 then
        f42_arg1:SetNumber(3, f42_arg1:GetNumber(3) + 1)
        if f42_local4 <= 2.5 - f42_arg1:GetMapHitRadius(TARGET_SELF) then
            f42_local1[6] = 100
            f42_local1[20] = 100
        else
            f42_local1[36] = 100
            f42_local1[38] = 100
            if f42_arg1:GetNumber(3) >= 2 then
                f42_local1[31] = 100
            end
        end
    elseif f42_local0 == 200226 then
        f42_arg1:SetNumber(3, f42_arg1:GetNumber(3) + 1)
        if f42_local4 <= 2.5 - f42_arg1:GetMapHitRadius(TARGET_SELF) then
            f42_local1[1] = 100
            f42_local1[2] = 100
            f42_local1[20] = 100
        else
            f42_local1[35] = 100
            if f42_arg1:GetNumber(3) >= 2 then
                f42_local1[31] = 100
                f42_local1[32] = 100
            end
        end
    else
        f42_local1[4] = 100
    end
    if f42_arg1:IsFinishTimer(6) == false then
        f42_local1[8] = 0
        f42_local1[11] = 0
    end
    if f42_arg1:IsFinishTimer(7) == false then
        f42_local1[17] = 0
    end
    if f42_arg1:GetNumber(6) == 0 and f42_arg1:GetNinsatsuNum() <= 1 then
        f42_local1[4] = 100
    end
    Set_ConsecutiveGuardCount(f42_arg1, f42_local0)
    f42_local1[1] = SetCoolTime(f42_arg1, f42_arg2, 3013, 8, f42_local1[1], 1)
    f42_local1[2] = SetCoolTime(f42_arg1, f42_arg2, 3000, 15, f42_local1[2], 1)
    f42_local1[3] = SetCoolTime(f42_arg1, f42_arg2, 3012, 15, f42_local1[3], 1)
    f42_local1[4] = SetCoolTime(f42_arg1, f42_arg2, 3022, 15, f42_local1[4], 1)
    f42_local1[4] = SetCoolTime(f42_arg1, f42_arg2, 3055, 15, f42_local1[4], 1)
    f42_local1[5] = SetCoolTime(f42_arg1, f42_arg2, 3011, 15, f42_local1[5], 1)
    f42_local1[6] = SetCoolTime(f42_arg1, f42_arg2, 3019, 15, f42_local1[6], 1)
    f42_local1[7] = SetCoolTime(f42_arg1, f42_arg2, 3011, 15, f42_local1[7], 1)
    f42_local1[8] = SetCoolTime(f42_arg1, f42_arg2, 3031, 30, f42_local1[8], 1)
    f42_local1[8] = SetCoolTime(f42_arg1, f42_arg2, 3032, 30, f42_local1[8], 1)
    f42_local1[11] = SetCoolTime(f42_arg1, f42_arg2, 3031, 30, f42_local1[11], 1)
    f42_local1[11] = SetCoolTime(f42_arg1, f42_arg2, 3032, 30, f42_local1[11], 1)
    f42_local1[20] = SetCoolTime(f42_arg1, f42_arg2, 5201, 15, f42_local1[20], 1)
    f42_local1[30] = SetCoolTime(f42_arg1, f42_arg2, 3006, 15, f42_local1[30], 1)
    f42_local1[30] = SetCoolTime(f42_arg1, f42_arg2, 3014, 15, f42_local1[30], 1)
    f42_local1[31] = SetCoolTime(f42_arg1, f42_arg2, 3017, 15, f42_local1[31], 1)
    f42_local1[32] = SetCoolTime(f42_arg1, f42_arg2, 3018, 15, f42_local1[32], 1)
    f42_local1[33] = SetCoolTime(f42_arg1, f42_arg2, 3031, 15, f42_local1[33], 1)
    f42_local1[34] = SetCoolTime(f42_arg1, f42_arg2, 3032, 15, f42_local1[34], 1)
    f42_local1[35] = SetCoolTime(f42_arg1, f42_arg2, 3060, 15, f42_local1[35], 1)
    f42_local1[36] = SetCoolTime(f42_arg1, f42_arg2, 3065, 15, f42_local1[36], 1)
    f42_local1[37] = SetCoolTime(f42_arg1, f42_arg2, 3026, 15, f42_local1[37], 1)
    f42_local1[38] = SetCoolTime(f42_arg1, f42_arg2, 3066, 10, f42_local1[38], 1)
    f42_local2[1] = REGIST_FUNC(f42_arg1, f42_arg2, f42_arg0.Kengeki01)
    f42_local2[2] = REGIST_FUNC(f42_arg1, f42_arg2, f42_arg0.Kengeki02)
    f42_local2[3] = REGIST_FUNC(f42_arg1, f42_arg2, f42_arg0.Kengeki03)
    f42_local2[4] = REGIST_FUNC(f42_arg1, f42_arg2, f42_arg0.Kengeki04)
    f42_local2[5] = REGIST_FUNC(f42_arg1, f42_arg2, f42_arg0.Kengeki05)
    f42_local2[6] = REGIST_FUNC(f42_arg1, f42_arg2, f42_arg0.Kengeki06)
    f42_local2[7] = REGIST_FUNC(f42_arg1, f42_arg2, f42_arg0.Kengeki07)
    f42_local2[8] = REGIST_FUNC(f42_arg1, f42_arg2, f42_arg0.Kengeki08)
    f42_local2[9] = REGIST_FUNC(f42_arg1, f42_arg2, f42_arg0.Kengeki09)
    f42_local2[10] = REGIST_FUNC(f42_arg1, f42_arg2, f42_arg0.Kengeki10)
    f42_local2[11] = REGIST_FUNC(f42_arg1, f42_arg2, f42_arg0.Kengeki11)
    f42_local2[20] = REGIST_FUNC(f42_arg1, f42_arg2, f42_arg0.Kengeki20)
    f42_local2[30] = REGIST_FUNC(f42_arg1, f42_arg2, f42_arg0.Kengeki30)
    f42_local2[31] = REGIST_FUNC(f42_arg1, f42_arg2, f42_arg0.Kengeki31)
    f42_local2[32] = REGIST_FUNC(f42_arg1, f42_arg2, f42_arg0.Kengeki32)
    f42_local2[33] = REGIST_FUNC(f42_arg1, f42_arg2, f42_arg0.Kengeki33)
    f42_local2[34] = REGIST_FUNC(f42_arg1, f42_arg2, f42_arg0.Kengeki34)
    f42_local2[35] = REGIST_FUNC(f42_arg1, f42_arg2, f42_arg0.Kengeki35)
    f42_local2[36] = REGIST_FUNC(f42_arg1, f42_arg2, f42_arg0.Kengeki36)
    f42_local2[37] = REGIST_FUNC(f42_arg1, f42_arg2, f42_arg0.Kengeki37)
    f42_local2[38] = REGIST_FUNC(f42_arg1, f42_arg2, f42_arg0.Kengeki38)
    f42_local2[50] = REGIST_FUNC(f42_arg1, f42_arg2, f42_arg0.NoAction)
    local f42_local7 = REGIST_FUNC(f42_arg1, f42_arg2, f42_arg0.ActAfter_AdjustSpace)
    return Common_Kengeki_Activate(f42_arg1, f42_arg2, f42_local1, f42_local2, f42_local7, f42_local3)
    
end

Goal.Kengeki01 = function (f43_arg0, f43_arg1, f43_arg2)
    local f43_local0 = f43_arg0:GetRandam_Int(1, 100)
    f43_arg1:ClearSubGoal()
    f43_arg1:AddSubGoal(GOAL_COMMON_ComboRepeat, 10, 3013, TARGET_ENE_0, 9999, 0, 0)
    if f43_local0 < 30 then
        f43_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3021, TARGET_ENE_0, 9999, 0, 0)
    end
    
end

Goal.Kengeki02 = function (f44_arg0, f44_arg1, f44_arg2)
    f44_arg1:ClearSubGoal()
    f44_arg1:AddSubGoal(GOAL_COMMON_ComboRepeat, 10, 3002, TARGET_ENE_0, 4.5 - f44_arg0:GetMapHitRadius(TARGET_SELF), 0, 0)
    f44_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3010, TARGET_ENE_0, 9999, 0, 0)
    
end

Goal.Kengeki03 = function (f45_arg0, f45_arg1, f45_arg2)
    f45_arg1:ClearSubGoal()
    f45_arg1:AddSubGoal(GOAL_COMMON_ComboRepeat, 10, 3001, TARGET_ENE_0, 5.9 - f45_arg0:GetMapHitRadius(TARGET_SELF), 0, 0)
    f45_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3003, TARGET_ENE_0, 9999, 0, 0)
    
end

Goal.Kengeki04 = function (f46_arg0, f46_arg1, f46_arg2)
    local f46_local0 = f46_arg0:GetRandam_Int(1, 100)
    local f46_local1 = f46_arg0:GetRandam_Int(1, 100)
    local f46_local2 = f46_arg0:GetHpRate(TARGET_SELF)
    local f46_local3 = 0
    local f46_local4 = 0
    if f46_arg0:IsFinishTimer(7) == true then
        f46_arg1:ClearSubGoal()
        if f46_local0 <= 80 then
            if f46_arg0:GetNinsatsuNum() >= 2 then
                f46_arg1:AddSubGoal(GOAL_COMMON_ComboRepeat, 10, 3022, TARGET_ENE_0, 9999, f46_local3, f46_local4, 0, 0)
            else
                f46_arg1:AddSubGoal(GOAL_COMMON_ComboRepeat, 10, 3055, TARGET_ENE_0, 9999, f46_local3, f46_local4, 0, 0)
            end
            f46_arg1:AddSubGoal(GOAL_COMMON_ComboRepeat, 10, 3018, TARGET_ENE_0, 10.5 - f46_arg0:GetMapHitRadius(TARGET_SELF) + 2, f46_local3, f46_local4, 0, 0):TimingSetTimer(7, 20, AI_TIMING_SET__ACTIVATE)
            f46_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3016, TARGET_ENE_0, 9999, f46_local3, f46_local4, 0, 0)
        else
            if f46_arg0:GetNinsatsuNum() >= 2 then
                f46_arg1:AddSubGoal(GOAL_COMMON_ComboRepeat, 10, 3022, TARGET_ENE_0, 9999, f46_local3, f46_local4, 0, 0)
            else
                f46_arg1:AddSubGoal(GOAL_COMMON_ComboRepeat, 10, 3055, TARGET_ENE_0, 9999, f46_local3, f46_local4, 0, 0)
            end
            f46_arg1:AddSubGoal(GOAL_COMMON_ComboRepeat, 10, 3018, TARGET_ENE_0, 10.5 - f46_arg0:GetMapHitRadius(TARGET_SELF) + 2, f46_local3, f46_local4, 0, 0):TimingSetTimer(7, 20, AI_TIMING_SET__ACTIVATE)
            f46_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3014, TARGET_ENE_0, 9999, f46_local3, f46_local4, 0, 0)
        end
    else
        f46_arg1:ClearSubGoal()
        if f46_arg0:GetNinsatsuNum() >= 2 then
            f46_arg1:AddSubGoal(GOAL_COMMON_ComboRepeat, 10, 3022, TARGET_ENE_0, 9999, f46_local3, f46_local4, 0, 0)
        else
            f46_arg1:AddSubGoal(GOAL_COMMON_ComboRepeat, 10, 3055, TARGET_ENE_0, 9999, f46_local3, f46_local4, 0, 0)
        end
        if f46_local1 <= 50 then
            f46_arg0:SetNumber(4, 1)
        end
    end
    
end

Goal.Kengeki05 = function (f47_arg0, f47_arg1, f47_arg2)
    f47_arg1:ClearSubGoal()
    f47_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3011, TARGET_ENE_0, 9999, 0, 0)
    f47_arg0:SetNumber(5, 1)
    
end

Goal.Kengeki06 = function (f48_arg0, f48_arg1, f48_arg2)
    local f48_local0 = f48_arg0:GetRandam_Int(1, 100)
    f48_arg1:ClearSubGoal()
    f48_arg1:AddSubGoal(GOAL_COMMON_ComboRepeat, 10, 3019, TARGET_ENE_0, 9999, 0, 0)
    if f48_local0 <= 50 then
        f48_arg1:AddSubGoal(GOAL_COMMON_ComboRepeat, 10, 3006, TARGET_ENE_0, 9999, 0, 0)
    else
        f48_arg0:SetNumber(5, 1)
    end
    
end

Goal.Kengeki07 = function (f49_arg0, f49_arg1, f49_arg2)
    f49_arg1:ClearSubGoal()
    f49_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3027, TARGET_ENE_0, 9999, 0, 0)
    
end

Goal.Kengeki08 = function (f50_arg0, f50_arg1, f50_arg2)
    local f50_local0 = 0
    local f50_local1 = 0
    f50_arg1:ClearSubGoal()
    f50_arg1:AddSubGoal(GOAL_COMMON_EndureAttack, 10, 3031, TARGET_ENE_0, 9999, f50_local0, f50_local1, 0, 0)
    f50_arg0:SetTimer(6, 30)
    f50_arg0:SetNumber(5, 1)
    
end

Goal.Kengeki09 = function (f51_arg0, f51_arg1, f51_arg2)
    f51_arg1:ClearSubGoal()
    f51_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3003, TARGET_ENE_0, 9999, 0, 0)
    
end

Goal.Kengeki10 = function (f52_arg0, f52_arg1, f52_arg2)
    local f52_local0 = 0
    local f52_local1 = 0
    f52_arg1:ClearSubGoal()
    f52_arg1:AddSubGoal(GOAL_COMMON_ComboRepeat, 10, 3019, TARGET_ENE_0, 9999, 0, 0)
    if f52_arg0:GetNinsatsuNum() >= 2 or 0 < f52_arg0:GetTimer(11) then
        f52_arg1:AddSubGoal(GOAL_COMMON_ComboRepeat, 10, 3009, TARGET_ENE_0, 7, f52_local0, f52_local1, 0, 0)
    else
        f52_arg1:AddSubGoal(GOAL_COMMON_ComboRepeat, 10, 3056, TARGET_ENE_0, 7, f52_local0, f52_local1, 0, 0):TimingSetTimer(11, 8, AI_TIMING_SET__ACTIVATE)
    end
    
end

Goal.Kengeki11 = function (f53_arg0, f53_arg1, f53_arg2)
    local f53_local0 = 0
    local f53_local1 = 0
    f53_arg1:AddSubGoal(GOAL_COMMON_EndureAttack, 10, 3032, TARGET_ENE_0, 9999, f53_local0, f53_local1, 0, 0)
    f53_arg0:SetTimer(6, 30)
    f53_arg0:SetNumber(5, 1)
    
end

Goal.Kengeki20 = function (f54_arg0, f54_arg1, f54_arg2)
    f54_arg1:ClearSubGoal()
    f54_arg1:AddSubGoal(GOAL_COMMON_ComboRepeat, 10, 5201, TARGET_ENE_0, 9999, 0, 0, 0, 0)
    f54_arg0:SetNumber(4, 1)
    f54_arg0:SetNumber(5, 1)
    
end

Goal.Kengeki30 = function (f55_arg0, f55_arg1, f55_arg2)
    f55_arg1:ClearSubGoal()
    f55_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3006, TARGET_ENE_0, 9999, 0, 0)
    f55_arg0:SetNumber(3, 0)
    
end

Goal.Kengeki31 = function (f56_arg0, f56_arg1, f56_arg2)
    f56_arg1:ClearSubGoal()
    f56_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3017, TARGET_ENE_0, 9999, 0, 0)
    f56_arg0:SetNumber(3, 0)
    
end

Goal.Kengeki32 = function (f57_arg0, f57_arg1, f57_arg2)
    f57_arg1:ClearSubGoal()
    f57_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3018, TARGET_ENE_0, 9999, 0, 0):TimingSetTimer(7, 20, AI_TIMING_SET__ACTIVATE)
    f57_arg0:SetNumber(3, 0)
    
end

Goal.Kengeki33 = function (f58_arg0, f58_arg1, f58_arg2)
    f58_arg1:ClearSubGoal()
    f58_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3031, TARGET_ENE_0, 9999, 0, 0)
    f58_arg0:SetNumber(5, 1)
    
end

Goal.Kengeki34 = function (f59_arg0, f59_arg1, f59_arg2)
    f59_arg1:ClearSubGoal()
    f59_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3032, TARGET_ENE_0, 9999, 0, 0)
    f59_arg0:SetNumber(5, 1)
    
end

Goal.Kengeki35 = function (f60_arg0, f60_arg1, f60_arg2)
    f60_arg1:ClearSubGoal()
    f60_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3060, TARGET_ENE_0, 9999, 0, 0)
    
end

Goal.Kengeki36 = function (f61_arg0, f61_arg1, f61_arg2)
    f61_arg1:ClearSubGoal()
    f61_arg1:AddSubGoal(GOAL_COMMON_ComboRepeat, 10, 3065, TARGET_ENE_0, 9999, 0, 0, 0, 0)
    f61_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3060, TARGET_ENE_0, 9999, 0, 0)
    
end

Goal.Kengeki37 = function (f62_arg0, f62_arg1, f62_arg2)
    f62_arg1:ClearSubGoal()
    f62_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3026, TARGET_ENE_0, 9999, 0, 0)
    
end

Goal.Kengeki38 = function (f63_arg0, f63_arg1, f63_arg2)
    local f63_local0 = f63_arg0:GetHpRate(TARGET_SELF)
    f63_arg1:ClearSubGoal()
    f63_arg1:AddSubGoal(GOAL_COMMON_ComboRepeat, 10, 3066, TARGET_ENE_0, 9999, 0, 0, 0, 0)
    f63_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3019, TARGET_ENE_0, 9999, 0, 0)
    
end

Goal.NoAction = function (f64_arg0, f64_arg1, f64_arg2)
    return -1
    
end

Goal.ActAfter_AdjustSpace = function (f65_arg0, f65_arg1, f65_arg2)
    
end

Goal.Update = function (f66_arg0, f66_arg1, f66_arg2)
    return Update_Default_NoSubGoal(f66_arg0, f66_arg1, f66_arg2)
    
end

Goal.Terminate = function (f67_arg0, f67_arg1, f67_arg2)
    
end


