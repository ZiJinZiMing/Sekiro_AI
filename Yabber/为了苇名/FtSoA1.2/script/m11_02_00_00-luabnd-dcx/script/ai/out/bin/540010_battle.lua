RegisterTableGoal(GOAL_Kensei_540010_Battle, "GOAL_Kensei_540010_Battle")
REGISTER_GOAL_NO_UPDATE(GOAL_Kensei_540010_Battle, true)
Goal.Initialize = function (arg0, arg1, arg2, arg3)
    
end

Goal.Activate = function (arg0, arg1, arg2)
    Init_Pseudo_Global(arg1, arg2)
    local f2_local0 = {}
    local f2_local1 = {}
    local f2_local2 = {}
    Common_Clear_Param(f2_local0, f2_local1, f2_local2)
    local f2_local3 = arg1:GetDist(TARGET_ENE_0)
    local f2_local4 = arg1:GetExcelParam(AI_EXCEL_THINK_PARAM_TYPE__thinkAttr_doAdmirer)
    local f2_local5 = arg1:GetHpRate(TARGET_SELF)
    local f2_local6 = arg1:GetNinsatsuNum()
    local f2_local7 = arg1:GetSpRate(TARGET_SELF)
    arg1:AddObserveSpecialEffectAttribute(TARGET_SELF, 3540060)
    arg1:AddObserveSpecialEffectAttribute(TARGET_ENE_0, 3540081)
    arg1:AddObserveSpecialEffectAttribute(TARGET_SELF, 5025)
    arg1:AddObserveSpecialEffectAttribute(TARGET_ENE_0, 5026)
    arg1:AddObserveSpecialEffectAttribute(TARGET_SELF, 5027)
    arg1:AddObserveSpecialEffectAttribute(TARGET_SELF, 5028)
    arg1:AddObserveSpecialEffectAttribute(TARGET_SELF, 5029)
    arg1:AddObserveSpecialEffectAttribute(TARGET_SELF, 5030)
    arg1:AddObserveSpecialEffectAttribute(TARGET_SELF, 5031)
    arg1:AddObserveSpecialEffectAttribute(TARGET_SELF, 5032)
    arg1:AddObserveSpecialEffectAttribute(TARGET_SELF, 5033)
    arg1:AddObserveSpecialEffectAttribute(TARGET_SELF, 5034)
    arg1:AddObserveSpecialEffectAttribute(TARGET_SELF, 3540073)
    arg1:AddObserveSpecialEffectAttribute(TARGET_SELF, 3540074)
    arg1:AddObserveSpecialEffectAttribute(TARGET_SELF, 3540075)
    arg1:AddObserveSpecialEffectAttribute(TARGET_SELF, 3540076)
    arg1:AddObserveSpecialEffectAttribute(TARGET_SELF, 3540077)
    arg1:AddObserveSpecialEffectAttribute(TARGET_SELF, 3540078)
    arg1:AddObserveSpecialEffectAttribute(TARGET_SELF, 3540082)
    arg1:AddObserveSpecialEffectAttribute(TARGET_SELF, 3540083)
    arg1:AddObserveSpecialEffectAttribute(TARGET_SELF, 3540085)
    arg1:AddObserveSpecialEffectAttribute(TARGET_SELF, 3540086)
    arg1:AddObserveSpecialEffectAttribute(TARGET_SELF, 3540087)
    arg1:AddObserveSpecialEffectAttribute(TARGET_SELF, 3540088)
    arg1:AddObserveSpecialEffectAttribute(TARGET_SELF, 3540089)
    arg1:AddObserveSpecialEffectAttribute(TARGET_SELF, 3540102)
    arg1:AddObserveSpecialEffectAttribute(TARGET_SELF, 3540103)
    arg1:AddObserveSpecialEffectAttribute(TARGET_SELF, 3540099)
    arg1:AddObserveSpecialEffectAttribute(TARGET_SELF, 3540101)
    arg1:AddObserveSpecialEffectAttribute(TARGET_SELF, 3540104)
    arg1:AddObserveSpecialEffectAttribute(TARGET_ENE_0, 109031)
    arg1:AddObserveSpecialEffectAttribute(TARGET_ENE_0, 110031)
    if arg1:GetNumber(6) == 0 and arg1:GetTimer(11) > 0 then
        arg1:SetNumber(6, 1)
    end
    if arg0:Kengeki_Activate(arg1, arg2) then
        return 
    end
    if not not arg1:HasSpecialEffectId(TARGET_ENE_0, 110060) or arg1:HasSpecialEffectId(TARGET_ENE_0, 110010) then
        if arg1:IsInsideTarget(TARGET_ENE_0, AI_DIR_TYPE_F, 90) then
            f2_local0[21] = 1
            f2_local0[28] = 100
        else
            f2_local0[21] = 100
        end
    elseif arg1:HasSpecialEffectId(TARGET_ENE_0, 110031) then
        f2_local0[9] = 999
    elseif arg1:HasSpecialEffectId(TARGET_ENE_0, 109031) then
        if f2_local3 >= 10 then
            f2_local0[3] = 100
        elseif f2_local3 >= 6 then
            f2_local0[6] = 100
            f2_local0[9] = 100
        else
            f2_local0[9] = 100
        end
    elseif arg1:IsInsideTarget(TARGET_ENE_0, AI_DIR_TYPE_B, 180) then
        f2_local0[21] = 100
        f2_local0[22] = 100
    elseif f2_local3 >= 10 then
        f2_local0[3] = 200
        if arg1:HasSpecialEffectId(TARGET_SELF, 3540099) == false then
            f2_local0[45] = 500
        end
        if arg1:IsFinishTimer(7) == true then
            f2_local0[17] = 100
        end
    elseif f2_local3 >= 7 then
        f2_local0[3] = 200
        f2_local0[12] = 100
        if arg1:HasSpecialEffectId(TARGET_SELF, 3540099) == false then
            f2_local0[45] = 500
        end
        if arg1:IsFinishTimer(7) == true then
            f2_local0[17] = 100
        end
    elseif f2_local3 >= 5 then
        f2_local0[2] = 25
        f2_local0[8] = 25
        if arg1:HasSpecialEffectId(TARGET_SELF, 3540099) == false then
            f2_local0[45] = 500
        end
    elseif f2_local3 > 3 then
        f2_local0[2] = 25
        f2_local0[8] = 30
        f2_local0[1] = 10
        if arg1:HasSpecialEffectId(TARGET_SELF, 3540099) == false then
            f2_local0[45] = 500
        end
    elseif f2_local3 > 1 then
        f2_local0[1] = 10
        f2_local0[8] = 25
    else
        f2_local0[1] = 10
    end
    if arg1:GetNumber(4) == 1 then
        f2_local0[23] = 10000
    end
    if arg1:GetNumber(5) == 1 then
        arg1:SetNumber(5, 0)
    end
    if SpaceCheck(arg1, arg2, 45, 2) == false and SpaceCheck(arg1, arg2, -45, 2) == false then
        f2_local0[22] = 0
    end
    if SpaceCheck(arg1, arg2, 90, 1) == false and SpaceCheck(arg1, arg2, -90, 1) == false then
        f2_local0[23] = 0
    end
    if SpaceCheck(arg1, arg2, 180, 2) == false then
        f2_local0[24] = 0
    end
    if SpaceCheck(arg1, arg2, 180, 1) == false then
        f2_local0[25] = 0
    end
    f2_local0[1] = SetCoolTime(arg1, arg2, 3000, 20, f2_local0[1], 1)
    f2_local0[2] = SetCoolTime(arg1, arg2, 3004, 20, f2_local0[2], 1)
    f2_local0[3] = SetCoolTime(arg1, arg2, 3004, 20, f2_local0[3], 1)
    f2_local0[4] = SetCoolTime(arg1, arg2, 3007, 20, f2_local0[4], 1)
    f2_local0[5] = SetCoolTime(arg1, arg2, 3010, 20, f2_local0[5], 1)
    f2_local0[6] = SetCoolTime(arg1, arg2, 3009, 20, f2_local0[6], 1)
    f2_local0[6] = SetCoolTime(arg1, arg2, 3056, 20, f2_local0[6], 1)
    f2_local0[7] = SetCoolTime(arg1, arg2, 3011, 20, f2_local0[7], 1)
    f2_local0[8] = SetCoolTime(arg1, arg2, 3020, 30, f2_local0[8], 1)
    f2_local0[9] = SetCoolTime(arg1, arg2, 3012, 20, f2_local0[9], 1)
    f2_local0[10] = SetCoolTime(arg1, arg2, 3013, 20, f2_local0[10], 1)
    f2_local0[11] = SetCoolTime(arg1, arg2, 3015, 20, f2_local0[11], 1)
    f2_local0[12] = SetCoolTime(arg1, arg2, 3024, 20, f2_local0[12], 1)
    f2_local0[13] = SetCoolTime(arg1, arg2, 3022, 20, f2_local0[13], 1)
    f2_local0[13] = SetCoolTime(arg1, arg2, 3055, 20, f2_local0[13], 1)
    f2_local0[14] = SetCoolTime(arg1, arg2, 3022, 20, f2_local0[14], 1)
    f2_local0[16] = SetCoolTime(arg1, arg2, 3000, 20, f2_local0[16], 1)
    f2_local0[40] = SetCoolTime(arg1, arg2, 3004, 20, f2_local0[40], 1)
    f2_local0[41] = SetCoolTime(arg1, arg2, 3013, 20, f2_local0[41], 1)
    f2_local0[42] = SetCoolTime(arg1, arg2, 3032, 20, f2_local0[42], 1)
    f2_local0[43] = SetCoolTime(arg1, arg2, 3030, 20, f2_local0[43], 1)
    f2_local0[44] = SetCoolTime(arg1, arg2, 3010, 20, f2_local0[44], 1)
    f2_local0[45] = SetCoolTime(arg1, arg2, 3090, 30, f2_local0[45], 0)
    f2_local1[1] = REGIST_FUNC(arg1, arg2, arg0.Act01)
    f2_local1[2] = REGIST_FUNC(arg1, arg2, arg0.Act02)
    f2_local1[3] = REGIST_FUNC(arg1, arg2, arg0.Act03)
    f2_local1[4] = REGIST_FUNC(arg1, arg2, arg0.Act04)
    f2_local1[5] = REGIST_FUNC(arg1, arg2, arg0.Act05)
    f2_local1[6] = REGIST_FUNC(arg1, arg2, arg0.Act06)
    f2_local1[7] = REGIST_FUNC(arg1, arg2, arg0.Act07)
    f2_local1[8] = REGIST_FUNC(arg1, arg2, arg0.Act08)
    f2_local1[9] = REGIST_FUNC(arg1, arg2, arg0.Act09)
    f2_local1[10] = REGIST_FUNC(arg1, arg2, arg0.Act10)
    f2_local1[11] = REGIST_FUNC(arg1, arg2, arg0.Act11)
    f2_local1[12] = REGIST_FUNC(arg1, arg2, arg0.Act12)
    f2_local1[13] = REGIST_FUNC(arg1, arg2, arg0.Act13)
    f2_local1[14] = REGIST_FUNC(arg1, arg2, arg0.Act14)
    f2_local1[15] = REGIST_FUNC(arg1, arg2, arg0.Act15)
    f2_local1[16] = REGIST_FUNC(arg1, arg2, arg0.Act16)
    f2_local1[17] = REGIST_FUNC(arg1, arg2, arg0.Act17)
    f2_local1[21] = REGIST_FUNC(arg1, arg2, arg0.Act21)
    f2_local1[22] = REGIST_FUNC(arg1, arg2, arg0.Act22)
    f2_local1[23] = REGIST_FUNC(arg1, arg2, arg0.Act23)
    f2_local1[24] = REGIST_FUNC(arg1, arg2, arg0.Act24)
    f2_local1[25] = REGIST_FUNC(arg1, arg2, arg0.Act25)
    f2_local1[26] = REGIST_FUNC(arg1, arg2, arg0.Act26)
    f2_local1[27] = REGIST_FUNC(arg1, arg2, arg0.Act27)
    f2_local1[28] = REGIST_FUNC(arg1, arg2, arg0.Act28)
    f2_local1[29] = REGIST_FUNC(arg1, arg2, arg0.Act29)
    f2_local1[30] = REGIST_FUNC(arg1, arg2, arg0.Act30)
    f2_local1[31] = REGIST_FUNC(arg1, arg2, arg0.Act31)
    f2_local1[32] = REGIST_FUNC(arg1, arg2, arg0.Act32)
    f2_local1[33] = REGIST_FUNC(arg1, arg2, arg0.Act33)
    f2_local1[34] = REGIST_FUNC(arg1, arg2, arg0.Act34)
    f2_local1[35] = REGIST_FUNC(arg1, arg2, arg0.Act35)
    f2_local1[36] = REGIST_FUNC(arg1, arg2, arg0.Act36)
    f2_local1[37] = REGIST_FUNC(arg1, arg2, arg0.Act37)
    f2_local1[39] = REGIST_FUNC(arg1, arg2, arg0.Act39)
    f2_local1[40] = REGIST_FUNC(arg1, arg2, arg0.Act40)
    f2_local1[41] = REGIST_FUNC(arg1, arg2, arg0.Act41)
    f2_local1[42] = REGIST_FUNC(arg1, arg2, arg0.Act42)
    f2_local1[43] = REGIST_FUNC(arg1, arg2, arg0.Act43)
    f2_local1[44] = REGIST_FUNC(arg1, arg2, arg0.Act44)
    f2_local1[45] = REGIST_FUNC(arg1, arg2, arg0.Act45)
    local f2_local8 = REGIST_FUNC(arg1, arg2, arg0.ActAfter_AdjustSpace)
    Common_Battle_Activate(arg1, arg2, f2_local0, f2_local1, f2_local8, f2_local2)
    
end

Goal.Act01 = function (arg0, arg1, arg2)
    local f3_local0 = 4.5 - arg0:GetMapHitRadius(TARGET_SELF)
    local f3_local1 = 4.5 - arg0:GetMapHitRadius(TARGET_SELF)
    local f3_local2 = 4.5 - arg0:GetMapHitRadius(TARGET_SELF)
    local f3_local3 = 100
    local f3_local4 = 0
    local f3_local5 = 1.5
    local f3_local6 = 3
    Approach_Act_Flex(arg0, arg1, f3_local0, f3_local1, f3_local2, f3_local3, f3_local4, f3_local5, f3_local6)
    arg1:AddSubGoal(GOAL_COMMON_ComboAttackTunableSpin, 10, 3000, TARGET_ENE_0, 4, 0)
    arg1:AddSubGoal(GOAL_COMMON_ComboRepeat, 10, 3001, TARGET_ENE_0, 6, 0)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act02 = function (arg0, arg1, arg2)
    local f4_local0 = 5 - arg0:GetMapHitRadius(TARGET_SELF)
    local f4_local1 = 5 - arg0:GetMapHitRadius(TARGET_SELF)
    local f4_local2 = 5 - arg0:GetMapHitRadius(TARGET_SELF)
    local f4_local3 = 100
    local f4_local4 = 0
    local f4_local5 = 1.5
    local f4_local6 = 3
    Approach_Act_Flex(arg0, arg1, f4_local0, f4_local1, f4_local2, f4_local3, f4_local4, f4_local5, f4_local6)
    arg1:AddSubGoal(GOAL_COMMON_ComboAttackTunableSpin, 10, 3004, TARGET_ENE_0, 6, 0)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act03 = function (arg0, arg1, arg2)
    local f5_local0 = 13 - arg0:GetMapHitRadius(TARGET_SELF)
    local f5_local1 = 13 - arg0:GetMapHitRadius(TARGET_SELF) + 2
    local f5_local2 = 13 - arg0:GetMapHitRadius(TARGET_SELF) + 2
    local f5_local3 = 100
    local f5_local4 = 0
    local f5_local5 = 1.5
    local f5_local6 = 3
    Approach_Act_Flex(arg0, arg1, f5_local0, f5_local1, f5_local2, f5_local3, f5_local4, f5_local5, f5_local6)
    arg1:AddSubGoal(GOAL_COMMON_ComboAttackTunableSpin, 10, 3007, TARGET_ENE_0, 6, 0)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act04 = function (arg0, arg1, arg2)
    local f6_local0 = 13 - arg0:GetMapHitRadius(TARGET_SELF)
    local f6_local1 = 13 - arg0:GetMapHitRadius(TARGET_SELF)
    local f6_local2 = 13 - arg0:GetMapHitRadius(TARGET_SELF)
    local f6_local3 = 100
    local f6_local4 = 0
    local f6_local5 = 1.5
    local f6_local6 = 3
    local f6_local7 = arg0:GetDist(TARGET_ENE_0)
    local f6_local8 = arg0:GetHpRate(TARGET_SELF)
    Approach_Act_Flex(arg0, arg1, f6_local0, f6_local1, f6_local2, f6_local3, f6_local4, f6_local5, f6_local6)
    local f6_local9 = 0
    local f6_local10 = 0
    if f6_local7 <= 10 then
        arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 10, 3007, TARGET_ENE_0, 9999, f6_local9, f6_local10, 0, 0)
    else
        arg1:AddSubGoal(GOAL_COMMON_ComboAttackTunableSpin, 10, 3007, TARGET_ENE_0, 9999, f6_local9, f6_local10, 0, 0)
        arg1:AddSubGoal(GOAL_COMMON_ComboRepeat, 10, 3018, TARGET_ENE_0, 9999, 0, 0)
        arg1:AddSubGoal(GOAL_COMMON_ComboRepeat, 10, 3007, TARGET_ENE_0, 9999, 0, 0)
    end
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act05 = function (arg0, arg1, arg2)
    local f7_local0 = 5 - arg0:GetMapHitRadius(TARGET_SELF)
    local f7_local1 = 5 - arg0:GetMapHitRadius(TARGET_SELF)
    local f7_local2 = 5 - arg0:GetMapHitRadius(TARGET_SELF)
    local f7_local3 = 100
    local f7_local4 = 0
    local f7_local5 = 1.5
    local f7_local6 = 3
    Approach_Act_Flex(arg0, arg1, f7_local0, f7_local1, f7_local2, f7_local3, f7_local4, f7_local5, f7_local6)
    local f7_local7 = 0
    local f7_local8 = 0
    arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 10, 3011, TARGET_ENE_0, 9999, f7_local7, f7_local8, 0, 0)
    arg0:SetNumber(5, 1)
    arg0:SetTimer(1, 30)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act06 = function (arg0, arg1, arg2)
    local f8_local0 = 7.5 - arg0:GetMapHitRadius(TARGET_SELF)
    local f8_local1 = 7.5 - arg0:GetMapHitRadius(TARGET_SELF)
    local f8_local2 = 7.5 - arg0:GetMapHitRadius(TARGET_SELF)
    local f8_local3 = 100
    local f8_local4 = 0
    local f8_local5 = 1.5
    local f8_local6 = 3
    Approach_Act_Flex(arg0, arg1, f8_local0, f8_local1, f8_local2, f8_local3, f8_local4, f8_local5, f8_local6)
    arg1:AddSubGoal(GOAL_COMMON_ComboAttackTunableSpin, 10, 3009, TARGET_ENE_0, 6, 0)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act07 = function (arg0, arg1, arg2)
    local f9_local0 = 4.5 - arg0:GetMapHitRadius(TARGET_SELF)
    local f9_local1 = 4.5 - arg0:GetMapHitRadius(TARGET_SELF)
    local f9_local2 = 4.5 - arg0:GetMapHitRadius(TARGET_SELF)
    local f9_local3 = 100
    local f9_local4 = 0
    local f9_local5 = 1.5
    local f9_local6 = 3
    Approach_Act_Flex(arg0, arg1, f9_local0, f9_local1, f9_local2, f9_local3, f9_local4, f9_local5, f9_local6)
    local f9_local7 = 0
    local f9_local8 = 0
    arg1:AddSubGoal(GOAL_COMMON_ComboAttackTunableSpin, 10, 3010, TARGET_ENE_0, 7, f9_local7, f9_local8, 0, 0)
    arg1:AddSubGoal(GOAL_COMMON_ComboRepeat, 10, 3003, TARGET_ENE_0, 6, 0)
    arg1:AddSubGoal(GOAL_COMMON_ComboRepeat, 10, 3021, TARGET_ENE_0, 9999, 0)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act08 = function (arg0, arg1, arg2)
    local f10_local0 = 4.3 - arg0:GetMapHitRadius(TARGET_SELF)
    local f10_local1 = 4.3 - arg0:GetMapHitRadius(TARGET_SELF)
    local f10_local2 = 4.3 - arg0:GetMapHitRadius(TARGET_SELF)
    local f10_local3 = 100
    local f10_local4 = 0
    local f10_local5 = 3
    local f10_local6 = 3
    Approach_Act_Flex(arg0, arg1, f10_local0, f10_local1, f10_local2, f10_local3, f10_local4, f10_local5, f10_local6)
    if arg0:HasSpecialEffectId(TARGET_SELF, 3540082) then
        arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 10, 3020, TARGET_ENE_0, 5, 0)
    elseif arg0:HasSpecialEffectId(TARGET_SELF, 3540083) then
        arg1:AddSubGoal(GOAL_COMMON_ComboAttackTunableSpin, 10, 3020, TARGET_ENE_0, 5, 0)
        arg1:AddSubGoal(GOAL_COMMON_ComboRepeat, 10, 3024, TARGET_ENE_0, 5, 0, 0)
    end
    arg0:SetNumber(4, 1)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act09 = function (arg0, arg1, arg2)
    local f11_local0 = 5 - arg0:GetMapHitRadius(TARGET_SELF)
    local f11_local1 = 5 - arg0:GetMapHitRadius(TARGET_SELF)
    local f11_local2 = 5 - arg0:GetMapHitRadius(TARGET_SELF)
    local f11_local3 = 100
    local f11_local4 = 0
    local f11_local5 = 1.5
    local f11_local6 = 3
    Approach_Act_Flex(arg0, arg1, f11_local0, f11_local1, f11_local2, f11_local3, f11_local4, f11_local5, f11_local6)
    local f11_local7 = 0
    local f11_local8 = 0
    arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 10, 3012, TARGET_ENE_0, 9999, f11_local7, f11_local8, 0, 0)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act10 = function (arg0, arg1, arg2)
    local f12_local0 = 2.5 - arg0:GetMapHitRadius(TARGET_SELF)
    local f12_local1 = 2.5 - arg0:GetMapHitRadius(TARGET_SELF)
    local f12_local2 = 2.5 - arg0:GetMapHitRadius(TARGET_SELF)
    local f12_local3 = 100
    local f12_local4 = 0
    local f12_local5 = 1.5
    local f12_local6 = 3
    Approach_Act_Flex(arg0, arg1, f12_local0, f12_local1, f12_local2, f12_local3, f12_local4, f12_local5, f12_local6)
    arg1:AddSubGoal(GOAL_COMMON_ComboAttackTunableSpin, 10, 3009, TARGET_ENE_0, 6, 0)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act11 = function (arg0, arg1, arg2)
    local f13_local0 = 5.9 - arg0:GetMapHitRadius(TARGET_SELF)
    local f13_local1 = 5.9 - arg0:GetMapHitRadius(TARGET_SELF)
    local f13_local2 = 5.9 - arg0:GetMapHitRadius(TARGET_SELF)
    local f13_local3 = 100
    local f13_local4 = 0
    local f13_local5 = 1.5
    local f13_local6 = 3
    local f13_local7 = arg0:GetRandam_Int(1, 100)
    Approach_Act_Flex(arg0, arg1, f13_local0, f13_local1, f13_local2, f13_local3, f13_local4, f13_local5, f13_local6)
    local f13_local8 = 0
    local f13_local9 = 0
    arg1:AddSubGoal(GOAL_COMMON_ComboAttackTunableSpin, 10, 3025, TARGET_ENE_0, 7, f13_local8, f13_local9, 0, 0)
    arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3026, TARGET_ENE_0, 9999, 0, 0)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act12 = function (arg0, arg1, arg2)
    local f14_local0 = 7.5 - arg0:GetMapHitRadius(TARGET_SELF)
    local f14_local1 = 7.5 - arg0:GetMapHitRadius(TARGET_SELF)
    local f14_local2 = 7.5 - arg0:GetMapHitRadius(TARGET_SELF)
    local f14_local3 = 100
    local f14_local4 = 0
    local f14_local5 = 1.5
    local f14_local6 = 3
    local f14_local7 = arg0:GetRandam_Int(1, 100)
    Approach_Act_Flex(arg0, arg1, f14_local0, f14_local1, f14_local2, f14_local3, f14_local4, f14_local5, f14_local6)
    local f14_local8 = 0
    local f14_local9 = 0
    arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 10, 3024, TARGET_ENE_0, 9999, f14_local8, f14_local9, 0, 0)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act13 = function (arg0, arg1, arg2)
    local f15_local0 = arg0:GetRandam_Int(1, 100)
    local f15_local1 = arg0:GetRandam_Int(1, 100)
    local f15_local2 = 0
    local f15_local3 = 0
    local f15_local4 = arg0:GetHpRate(TARGET_SELF)
    if arg0:IsFinishTimer(7) == true then
        if f15_local0 <= 80 then
            if arg0:GetNinsatsuNum() >= 2 or arg0:GetTimer(11) > 0 then
                arg1:AddSubGoal(GOAL_COMMON_ComboAttackTunableSpin, 10, 3022, TARGET_ENE_0, 9999, f15_local2, f15_local3, 0, 0)
            else
                local f15_local5 = arg1:AddSubGoal(GOAL_COMMON_ComboAttackTunableSpin, 10, 3055, TARGET_ENE_0, 9999, f15_local2, f15_local3, 0, 0)
                f15_local5:TimingSetTimer(11, 8, AI_TIMING_SET__ACTIVATE)
            end
            local f15_local5 = arg1:AddSubGoal(GOAL_COMMON_ComboRepeat, 10, 3018, TARGET_ENE_0, 10.5 - arg0:GetMapHitRadius(TARGET_SELF) + 2, f15_local2, f15_local3, 0, 0)
            f15_local5:TimingSetTimer(7, 20, AI_TIMING_SET__ACTIVATE)
            arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3016, TARGET_ENE_0, 9999, f15_local2, f15_local3, 0, 0)
        else
            if arg0:GetNinsatsuNum() >= 2 or arg0:GetTimer(11) > 0 then
                arg1:AddSubGoal(GOAL_COMMON_ComboAttackTunableSpin, 10, 3022, TARGET_ENE_0, 9999, f15_local2, f15_local3, 0, 0)
            else
                local f15_local5 = arg1:AddSubGoal(GOAL_COMMON_ComboAttackTunableSpin, 10, 3055, TARGET_ENE_0, 9999, f15_local2, f15_local3, 0, 0)
                f15_local5:TimingSetTimer(11, 8, AI_TIMING_SET__ACTIVATE)
            end
            local f15_local5 = arg1:AddSubGoal(GOAL_COMMON_ComboRepeat, 10, 3018, TARGET_ENE_0, 10.5 - arg0:GetMapHitRadius(TARGET_SELF) + 2, f15_local2, f15_local3, 0, 0)
            f15_local5:TimingSetTimer(7, 20, AI_TIMING_SET__ACTIVATE)
            arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3014, TARGET_ENE_0, 9999, f15_local2, f15_local3, 0, 0)
        end
    else
        if arg0:GetNinsatsuNum() >= 2 or arg0:GetTimer(11) > 0 then
            arg1:AddSubGoal(GOAL_COMMON_ComboAttackTunableSpin, 10, 3022, TARGET_ENE_0, 9999, f15_local2, f15_local3, 0, 0)
        else
            local f15_local5 = arg1:AddSubGoal(GOAL_COMMON_ComboAttackTunableSpin, 10, 3055, TARGET_ENE_0, 9999, f15_local2, f15_local3, 0, 0)
            f15_local5:TimingSetTimer(11, 8, AI_TIMING_SET__ACTIVATE)
        end
        if f15_local1 <= 50 then
            arg0:SetNumber(4, 1)
        end
    end
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act14 = function (arg0, arg1, arg2)
    local f16_local0 = 0
    local f16_local1 = 0
    arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 10, 3008, TARGET_ENE_0, 9999, f16_local0, f16_local1, 0, 0)
    arg0:SetNumber(0, 0)
    arg0:SetTimer(6, 60)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act15 = function (arg0, arg1, arg2)
    local f17_local0 = 10.5 - arg0:GetMapHitRadius(TARGET_SELF)
    local f17_local1 = 10.5 - arg0:GetMapHitRadius(TARGET_SELF)
    local f17_local2 = 10.5 - arg0:GetMapHitRadius(TARGET_SELF)
    local f17_local3 = 100
    local f17_local4 = 0
    local f17_local5 = 1.5
    local f17_local6 = 3
    Approach_Act_Flex(arg0, arg1, f17_local0, f17_local1, f17_local2, f17_local3, f17_local4, f17_local5, f17_local6)
    local f17_local7 = 0
    local f17_local8 = 0
    arg1:AddSubGoal(GOAL_COMMON_ComboAttackTunableSpin, 10, 3016, TARGET_ENE_0, 9999, f17_local7, f17_local8, 0, 0)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act16 = function (arg0, arg1, arg2)
    local f18_local0 = 5 - arg0:GetMapHitRadius(TARGET_SELF)
    local f18_local1 = 5 - arg0:GetMapHitRadius(TARGET_SELF)
    local f18_local2 = 5 - arg0:GetMapHitRadius(TARGET_SELF)
    local f18_local3 = 100
    local f18_local4 = 0
    local f18_local5 = 1.5
    local f18_local6 = 3
    Approach_Act_Flex(arg0, arg1, f18_local0, f18_local1, f18_local2, f18_local3, f18_local4, f18_local5, f18_local6)
    local f18_local7 = 0
    local f18_local8 = 0
    arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 10, 3012, TARGET_ENE_0, 9999, 0)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act17 = function (arg0, arg1, arg2)
    local f19_local0 = 13.5 - arg0:GetMapHitRadius(TARGET_SELF)
    local f19_local1 = 13.5 - arg0:GetMapHitRadius(TARGET_SELF)
    local f19_local2 = 13.5 - arg0:GetMapHitRadius(TARGET_SELF)
    local f19_local3 = 100
    local f19_local4 = 0
    local f19_local5 = 1.5
    local f19_local6 = 3
    Approach_Act_Flex(arg0, arg1, f19_local0, f19_local1, f19_local2, f19_local3, f19_local4, f19_local5, f19_local6)
    local f19_local7 = 0
    local f19_local8 = 0
    local f19_local9 = arg1:AddSubGoal(GOAL_COMMON_ComboAttackTunableSpin, 10, 3025, TARGET_ENE_0, 9999, f19_local7, f19_local8, 0, 0)
    f19_local9:TimingSetTimer(7, 20, AI_TIMING_SET__ACTIVATE)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act21 = function (arg0, arg1, arg2)
    local f20_local0 = 3
    local f20_local1 = 45
    arg1:AddSubGoal(GOAL_COMMON_Turn, f20_local0, TARGET_ENE_0, f20_local1, -1, GOAL_RESULT_Success, true)
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
    
end

Goal.Act22 = function (arg0, arg1, arg2)
    local f21_local0 = 3
    local f21_local1 = 0
    local f21_local2 = 5202
    if SpaceCheck(arg0, arg1, -45, 2) == true then
        if SpaceCheck(arg0, arg1, 45, 2) == true then
            if arg0:IsInsideTarget(TARGET_ENE_0, AI_DIR_TYPE_R, 180) then
                f21_local2 = 5202
            else
                f21_local2 = 5203
            end
        else
            f21_local2 = 5202
        end
    elseif SpaceCheck(arg0, arg1, 45, 2) == true then
        f21_local2 = 5203
    else

    end
    arg1:AddSubGoal(GOAL_COMMON_SpinStep, f21_local0, f21_local2, TARGET_ENE_0, f21_local1, AI_DIR_TYPE_R, 0)
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
    
end

Goal.Act23 = function (arg0, arg1, arg2)
    local f22_local0 = arg0:GetDist(TARGET_ENE_0)
    local f22_local1 = arg0:GetSpRate(TARGET_SELF)
    local f22_local2 = 20
    local f22_local3 = arg0:GetRandam_Int(1, 100)
    local f22_local4 = -1
    local f22_local5 = 0
    if SpaceCheck(arg0, arg1, -90, 1) == true then
        if SpaceCheck(arg0, arg1, 90, 1) == true then
            if arg0:IsInsideTargetEx(TARGET_ENE_0, TARGET_SELF, AI_DIR_TYPE_R, 180, 999) then
                f22_local5 = 1
            else
                f22_local5 = 0
            end
        else
            f22_local5 = 0
        end
    elseif SpaceCheck(arg0, arg1, 90, 1) == true then
        f22_local5 = 1
    else

    end
    local f22_local6 = 3
    local f22_local7 = arg0:GetRandam_Int(30, 45)
    arg0:SetNumber(10, f22_local5)
    local f22_local8 = arg1:AddSubGoal(GOAL_COMMON_SidewayMove, f22_local6, TARGET_ENE_0, f22_local5, f22_local7, true, true, f22_local4)
    f22_local8:TimingSetNumber(4, 0, AI_TIMING_SET__ACTIVATE)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act24 = function (arg0, arg1, arg2)
    local f23_local0 = arg0:GetDist(TARGET_ENE_0)
    local f23_local1 = 3
    local f23_local2 = 0
    local f23_local3 = 5201
    if SpaceCheck(arg0, arg1, 180, 2) == true and SpaceCheck(arg0, arg1, 180, 4) == true then
        if f23_local0 > 4 then

        else
            f23_local3 = 5201
        end
    end
    arg1:AddSubGoal(GOAL_COMMON_SpinStep, f23_local1, f23_local3, TARGET_ENE_0, f23_local2, AI_DIR_TYPE_B, 0)
    arg0:SetNumber(5, 1)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act25 = function (arg0, arg1, arg2)
    local f24_local0 = arg0:GetRandam_Float(2, 4)
    local f24_local1 = arg0:GetRandam_Float(5, 7)
    local f24_local2 = arg0:GetDist(TARGET_ENE_0)
    local f24_local3 = -1
    arg1:AddSubGoal(GOAL_COMMON_LeaveTarget, f24_local0, TARGET_ENE_0, f24_local1, TARGET_ENE_0, true, f24_local3)
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
    
end

Goal.Act26 = function (arg0, arg1, arg2)
    arg1:AddSubGoal(GOAL_COMMON_Wait, 0.5, TARGET_SELF, 0, 0, 0)
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
    
end

Goal.Act27 = function (arg0, arg1, arg2)
    local f26_local0 = arg0:GetDist(TARGET_ENE_0)
    local f26_local1 = arg0:GetRandam_Int(1, 100)
    local f26_local2 = 8
    local f26_local3 = 5
    local f26_local4 = arg0:GetRandam_Float(2, 4)
    local f26_local5 = arg0:GetRandam_Int(30, 45)
    if f26_local0 >= 8 then
        arg1:AddSubGoal(GOAL_COMMON_ApproachTarget, f26_local4, TARGET_ENE_0, f26_local2, TARGET_ENE_0, true, -1)
    elseif f26_local0 <= 5 then
        arg1:AddSubGoal(GOAL_COMMON_LeaveTarget, f26_local4, TARGET_ENE_0, f26_local3, TARGET_ENE_0, true, -1)
    end
    arg1:AddSubGoal(GOAL_COMMON_SidewayMove, f26_local4, TARGET_ENE_0, arg0:GetRandam_Int(0, 1), f26_local5, true, true, -1)
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
    
end

Goal.Act28 = function (arg0, arg1, arg2)
    local f27_local0 = arg0:GetDist(TARGET_ENE_0)
    local f27_local1 = 1.5
    local f27_local2 = 1.5
    local f27_local3 = arg0:GetRandam_Int(30, 45)
    local f27_local4 = -1
    local f27_local5 = arg0:GetRandam_Int(0, 1)
    if f27_local0 <= 3 then
        arg1:AddSubGoal(GOAL_COMMON_SidewayMove, f27_local1, TARGET_ENE_0, f27_local5, f27_local3, true, true, f27_local4)
    elseif f27_local0 <= 8 then
        arg1:AddSubGoal(GOAL_COMMON_ApproachTarget, f27_local2, TARGET_ENE_0, 3, TARGET_SELF, true, -1)
    else
        arg1:AddSubGoal(GOAL_COMMON_ApproachTarget, f27_local2, TARGET_ENE_0, 8, TARGET_SELF, false, -1)
    end
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
    
end

Goal.Act30 = function (arg0, arg1, arg2)
    local f28_local0 = 4.5 - arg0:GetMapHitRadius(TARGET_SELF)
    local f28_local1 = 4.5 - arg0:GetMapHitRadius(TARGET_SELF)
    local f28_local2 = 4.5 - arg0:GetMapHitRadius(TARGET_SELF)
    local f28_local3 = 100
    local f28_local4 = 0
    local f28_local5 = 1.5
    local f28_local6 = 3
    Approach_Act_Flex(arg0, arg1, f28_local0 + 1, f28_local1, f28_local2, f28_local3, f28_local4, f28_local5, f28_local6)
    local f28_local7 = 0
    local f28_local8 = 0
    arg1:AddSubGoal(GOAL_COMMON_ComboAttackTunableSpin, 10, 3003, TARGET_ENE_0, 6, 0)
    arg1:AddSubGoal(GOAL_COMMON_ComboRepeat, 10, 3021, TARGET_ENE_0, 9999, 0)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act31 = function (arg0, arg1, arg2)
    local f29_local0 = 4.5 - arg0:GetMapHitRadius(TARGET_SELF)
    local f29_local1 = 4.5 - arg0:GetMapHitRadius(TARGET_SELF)
    local f29_local2 = 4.5 - arg0:GetMapHitRadius(TARGET_SELF)
    local f29_local3 = 100
    local f29_local4 = 0
    local f29_local5 = 1.5
    local f29_local6 = 3
    Approach_Act_Flex(arg0, arg1, f29_local0 + 1, f29_local1, f29_local2, f29_local3, f29_local4, f29_local5, f29_local6)
    arg1:AddSubGoal(GOAL_COMMON_ComboAttackTunableSpin, 10, 3004, TARGET_ENE_0, 6, 0)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act32 = function (arg0, arg1, arg2)
    local f30_local0 = 4.5 - arg0:GetMapHitRadius(TARGET_SELF)
    local f30_local1 = 4.5 - arg0:GetMapHitRadius(TARGET_SELF)
    local f30_local2 = 4.5 - arg0:GetMapHitRadius(TARGET_SELF)
    local f30_local3 = 100
    local f30_local4 = 0
    local f30_local5 = 1.5
    local f30_local6 = 3
    Approach_Act_Flex(arg0, arg1, f30_local0 + 1, f30_local1, f30_local2, f30_local3, f30_local4, f30_local5, f30_local6)
    arg1:AddSubGoal(GOAL_COMMON_ComboAttackTunableSpin, 10, 3004, TARGET_ENE_0, 6, 0)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act33 = function (arg0, arg1, arg2)
    local f31_local0 = 4.5 - arg0:GetMapHitRadius(TARGET_SELF)
    local f31_local1 = 4.5 - arg0:GetMapHitRadius(TARGET_SELF)
    local f31_local2 = 4.5 - arg0:GetMapHitRadius(TARGET_SELF)
    local f31_local3 = 100
    local f31_local4 = 0
    local f31_local5 = 1.5
    local f31_local6 = 3
    Approach_Act_Flex(arg0, arg1, f31_local0 + 1, f31_local1, f31_local2, f31_local3, f31_local4, f31_local5, f31_local6)
    local f31_local7 = 0
    local f31_local8 = 0
    arg1:AddSubGoal(GOAL_COMMON_ComboAttackTunableSpin, 10, 3029, TARGET_ENE_0, 9999, f31_local7, f31_local8, 0, 0)
    arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3005, TARGET_ENE_0, DistToAtt2, f31_local7, f31_local8, 0, 0)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act34 = function (arg0, arg1, arg2)
    local f32_local0 = 4.3 - arg0:GetMapHitRadius(TARGET_SELF)
    local f32_local1 = 4.3 - arg0:GetMapHitRadius(TARGET_SELF)
    local f32_local2 = 4.3 - arg0:GetMapHitRadius(TARGET_SELF)
    local f32_local3 = 100
    local f32_local4 = 0
    local f32_local5 = 1.5
    local f32_local6 = 3
    Approach_Act_Flex(arg0, arg1, f32_local0 + 1, f32_local1, f32_local2, f32_local3, f32_local4, f32_local5, f32_local6)
    local f32_local7 = 0
    local f32_local8 = 0
    arg1:AddSubGoal(GOAL_COMMON_ComboAttackTunableSpin, 10, 3027, TARGET_ENE_0, 9999, f32_local7, f32_local8, 0, 0)
    arg1:AddSubGoal(GOAL_COMMON_ComboRepeat, 10, 3030, TARGET_ENE_0, 9999, f32_local7, f32_local8, 0, 0)
    arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3029, TARGET_ENE_0, DistToAtt2, f32_local7, f32_local8, 0, 0)
    arg0:SetNumber(5, 1)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act36 = function (arg0, arg1, arg2)
    arg0:DeleteObserveSpecialEffectAttribute(TARGET_SELF, 5026)
    local f33_local0 = 4.5 - arg0:GetMapHitRadius(TARGET_SELF)
    local f33_local1 = 4.5 - arg0:GetMapHitRadius(TARGET_SELF)
    local f33_local2 = 4.5 - arg0:GetMapHitRadius(TARGET_SELF)
    local f33_local3 = 100
    local f33_local4 = 0
    local f33_local5 = 1.5
    local f33_local6 = 3
    Approach_Act_Flex(arg0, arg1, f33_local0, f33_local1, f33_local2, f33_local3, f33_local4, f33_local5, f33_local6)
    local f33_local7 = 0
    local f33_local8 = 0
    arg1:AddSubGoal(GOAL_COMMON_ComboAttackTunableSpin, 10, 3010, TARGET_ENE_0, 9999, f33_local7, f33_local8, 0, 0)
    arg1:AddSubGoal(GOAL_COMMON_ComboRepeat, 10, 3029, TARGET_ENE_0, 9999, 0, 0)
    arg0:SetNumber(5, 1)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act39 = function (arg0, arg1, arg2)
    local f34_local0 = 3
    local f34_local1 = 0
    local f34_local2 = 4.5
    local f34_local3 = arg0:GetRandam_Int(30, 45)
    if SpaceCheck(arg0, arg1, 180, 5) then
        arg1:AddSubGoal(GOAL_COMMON_SpinStep, f34_local0, 5201, TARGET_ENE_0, f34_local1, AI_DIR_TYPE_B, 0)
        f34_local2 = 3.5
    end
    local f34_local4 = 0
    if SpaceCheck(arg0, arg1, -90, 1) == true then
        if SpaceCheck(arg0, arg1, 90, 1) == true then
            if arg0:IsInsideTarget(TARGET_ENE_0, AI_DIR_TYPE_R, 180) then
                f34_local4 = 0
            else
                f34_local4 = 1
            end
        else
            f34_local4 = 0
        end
    elseif SpaceCheck(arg0, arg1, 90, 1) == true then
        f34_local4 = 1
    else

    end
    arg1:AddSubGoal(GOAL_COMMON_SidewayMove, f34_local2, TARGET_ENE_0, f34_local4, f34_local3, true, true, -1)
    return GETWELLSPACE_ODDS
    
end

Goal.Act40 = function (arg0, arg1, arg2)
    local f35_local0 = 8 - arg0:GetMapHitRadius(TARGET_SELF)
    local f35_local1 = 8 - arg0:GetMapHitRadius(TARGET_SELF)
    local f35_local2 = 8 - arg0:GetMapHitRadius(TARGET_SELF)
    local f35_local3 = 100
    local f35_local4 = 0
    local f35_local5 = 1.5
    local f35_local6 = 3
    Approach_Act_Flex(arg0, arg1, f35_local0, f35_local1, f35_local2, f35_local3, f35_local4, f35_local5, f35_local6)
    local f35_local7 = 0
    local f35_local8 = 0
    arg1:AddSubGoal(GOAL_COMMON_ComboAttackTunableSpin, 10, 3016, TARGET_ENE_0, DistToAtt1, f35_local7, f35_local8, 0, 0)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act41 = function (arg0, arg1, arg2)
    local f36_local0 = 7.5 - arg0:GetMapHitRadius(TARGET_SELF)
    local f36_local1 = 7.5 - arg0:GetMapHitRadius(TARGET_SELF)
    local f36_local2 = 7.5 - arg0:GetMapHitRadius(TARGET_SELF)
    local f36_local3 = 100
    local f36_local4 = 0
    local f36_local5 = 1.5
    local f36_local6 = 3
    Approach_Act_Flex(arg0, arg1, f36_local0, f36_local1, f36_local2, f36_local3, f36_local4, f36_local5, f36_local6)
    local f36_local7 = 0
    local f36_local8 = 0
    arg1:AddSubGoal(GOAL_COMMON_ComboAttackTunableSpin, 10, 3024, TARGET_ENE_0, 9999, f36_local7, f36_local8, 0, 0)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act42 = function (arg0, arg1, arg2)
    local f37_local0 = 7.5 - arg0:GetMapHitRadius(TARGET_SELF)
    local f37_local1 = 7.5 - arg0:GetMapHitRadius(TARGET_SELF)
    local f37_local2 = 7.5 - arg0:GetMapHitRadius(TARGET_SELF)
    local f37_local3 = 100
    local f37_local4 = 0
    local f37_local5 = 1.5
    local f37_local6 = 3
    Approach_Act_Flex(arg0, arg1, f37_local0, f37_local1, f37_local2, f37_local3, f37_local4, f37_local5, f37_local6)
    arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3031, TARGET_ENE_0, 9999, 0)
    arg0:SetNumber(4, 1)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act43 = function (arg0, arg1, arg2)
    local f38_local0 = 0
    local f38_local1 = 0
    arg1:AddSubGoal(GOAL_COMMON_ComboAttackTunableSpin, 10, 3003, TARGET_ENE_0, 6, 0)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act44 = function (arg0, arg1, arg2)
    arg0:DeleteObserveSpecialEffectAttribute(TARGET_SELF, 5026)
    local f39_local0 = 4.5 - arg0:GetMapHitRadius(TARGET_SELF)
    local f39_local1 = 4.5 - arg0:GetMapHitRadius(TARGET_SELF)
    local f39_local2 = 4.5 - arg0:GetMapHitRadius(TARGET_SELF)
    local f39_local3 = 100
    local f39_local4 = 0
    local f39_local5 = 1.5
    local f39_local6 = 3
    Approach_Act_Flex(arg0, arg1, f39_local0, f39_local1, f39_local2, f39_local3, f39_local4, f39_local5, f39_local6)
    local f39_local7 = 0
    local f39_local8 = 0
    arg1:AddSubGoal(GOAL_COMMON_ComboAttackTunableSpin, 10, 3010, TARGET_ENE_0, 9999, f39_local7, f39_local8, 0, 0)
    arg1:AddSubGoal(GOAL_COMMON_ComboRepeat, 10, 3032, TARGET_ENE_0, 9999, 0, 0)
    arg0:SetNumber(5, 1)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act45 = function (arg0, arg1, arg2)
    local f40_local0 = 25 - arg0:GetMapHitRadius(TARGET_SELF)
    local f40_local1 = 25 - arg0:GetMapHitRadius(TARGET_SELF)
    local f40_local2 = 25 - arg0:GetMapHitRadius(TARGET_SELF)
    local f40_local3 = 100
    local f40_local4 = 0
    local f40_local5 = 1.5
    local f40_local6 = 3
    Approach_Act_Flex(arg0, arg1, f40_local0, f40_local1, f40_local2, f40_local3, f40_local4, f40_local5, f40_local6)
    local f40_local7 = arg0:GetNinsatsuNum()
    local f40_local8 = 0
    local f40_local9 = arg0:GetNumber(31)
    if f40_local7 <= 1 then
        arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 10, 3090, TARGET_ENE_0, 9999, 0)
    elseif f40_local9 == 0 then
        arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 10, 3040, TARGET_ENE_0, 9999, 0)
    else
        arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 10, 3039, TARGET_ENE_0, 9999, 0)
    end
    arg0:SetNumber(4, 1)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Interrupt = function (arg0, arg1, arg2)
    local f41_local0 = arg1:GetSpecialEffectActivateInterruptType(0)
    local f41_local1 = arg1:GetDist(TARGET_ENE_0)
    local f41_local2 = arg1:GetRandam_Int(1, 100)
    local f41_local3 = arg1:GetHpRate(TARGET_SELF)
    local f41_local4 = arg1:GetHpRate(TARGET_ENE_0)
    local f41_local5 = arg1:GetNinsatsuNum()
    if arg1:IsLadderAct(TARGET_SELF) then
        return false
    end
    if not arg1:HasSpecialEffectId(TARGET_SELF, 200004) then
        return false
    end
    if arg1:IsInterupt(INTERUPT_ParryTiming) then
        return Common_Parry(arg1, arg2, 100, 0, 1, 3102)
    end
    if arg1:IsInterupt(INTERUPT_Damaged) then
        return arg0.Damaged(arg1, arg2)
    end
    if Interupt_Use_Item(arg1, 10, 10) and arg1:HasSpecialEffectId(TARGET_SELF, 3540101) == false and arg1:IsInsideTarget(TARGET_ENE_0, AI_DIR_TYPE_F, 180) then
        if f41_local1 < 5.5 then
            arg2:ClearSubGoal()
            arg2:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 1, 3012, TARGET_ENE_0, 9999, 0)
            return true
        elseif f41_local1 < 13 then
            arg2:ClearSubGoal()
            arg2:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 1, 3007, TARGET_ENE_0, 9999, 0)
            return true
        else
            arg1:Replanning()
            return true
        end
    end
    if arg1:IsInterupt(INTERUPT_ActivateSpecialEffect) then
        if f41_local0 == 109031 and arg1:HasSpecialEffectId(TARGET_SELF, 3540050) then
            arg2:ClearSubGoal()
            arg2:AddSubGoal(GOAL_COMMON_ComboRepeat, 4, 3012, TARGET_ENE_0, 9999, 0)
            return true
        elseif f41_local0 == 3540081 and arg1:HasSpecialEffectId(TARGET_SELF, 3540080) then
            arg2:ClearSubGoal()
            arg2:AddSubGoal(GOAL_COMMON_ComboRepeat, 5, 3013, TARGET_ENE_0, 6, 0, 0)
            arg1:AddSubGoal(GOAL_COMMON_ComboRepeat, 10, 3021, TARGET_ENE_0, 9999, 0, 0)
            arg1:SetTimer(5, 7)
            return true
        elseif arg1:HasSpecialEffectId(TARGET_SELF, 3540073) and f41_local1 <= 6 and f41_local4 > 0 then
            arg2:ClearSubGoal()
            arg1:SetNumber(4, 1)
            arg2:AddSubGoal(GOAL_COMMON_AttackImmediateAction, 5, 3015, TARGET_ENE_0, 4, 0, 0)
        elseif arg1:HasSpecialEffectId(TARGET_SELF, 3540073) and f41_local1 > 6 and f41_local4 > 0 then
            arg2:ClearSubGoal()
            arg2:AddSubGoal(GOAL_COMMON_AttackImmediateAction, 5, 3005, TARGET_ENE_0, 9999, 0, 0)
            arg2:AddSubGoal(GOAL_COMMON_ComboRepeat, 5, 3002, TARGET_ENE_0, 4, 0, 0)
            arg2:AddSubGoal(GOAL_COMMON_ComboRepeat, 5, 3010, TARGET_ENE_0, 4, 0, 0)
        elseif arg1:HasSpecialEffectId(TARGET_SELF, 3540074) and f41_local1 <= 6 and f41_local4 > 0 then
            if arg1:GetNumber(21) == 0 then
                arg2:ClearSubGoal()
                arg1:SetNumber(21, 1)
                arg2:AddSubGoal(GOAL_COMMON_ComboRepeat, 5, 3013, TARGET_ENE_0, 6, 0, 0)
                arg2:AddSubGoal(GOAL_COMMON_ComboRepeat, 5, 3021, TARGET_ENE_0, 9999, 0)
            elseif arg1:GetNumber(21) == 1 then
                arg2:ClearSubGoal()
                arg1:SetNumber(21, 2)
                arg2:AddSubGoal(GOAL_COMMON_ComboFinal, 5, 3014, TARGET_ENE_0, 6, 0, 0)
            elseif arg1:GetNumber(21) == 2 then
                arg2:ClearSubGoal()
                arg1:SetNumber(21, 0)
                arg2:AddSubGoal(GOAL_COMMON_AttackImmediateAction, 5, 3091, TARGET_ENE_0, 9999, 0)
                arg2:AddSubGoal(GOAL_COMMON_ComboRepeat, 5, 3026, TARGET_ENE_0, 4, 0)
                arg2:AddSubGoal(GOAL_COMMON_ComboRepeat, 5, 3010, TARGET_ENE_0, 4, 0)
            end
        elseif arg1:HasSpecialEffectId(TARGET_SELF, 3540075) and f41_local1 <= 6 and f41_local4 > 0 then
            arg2:ClearSubGoal()
            arg2:AddSubGoal(GOAL_COMMON_AttackImmediateAction, 5, 3060, TARGET_ENE_0, 6, 0, 0)
        elseif arg1:HasSpecialEffectId(TARGET_SELF, 3540075) and f41_local1 > 6 and f41_local4 > 0 then
            arg2:ClearSubGoal()
            arg2:AddSubGoal(GOAL_COMMON_ComboRepeat, 5, 3019, TARGET_ENE_0, 6, 0, 0)
        elseif arg1:HasSpecialEffectId(TARGET_SELF, 3540076) then
            if arg1:GetNumber(30) == 0 then
                arg2:ClearSubGoal()
                arg1:SetNumber(30, 1)
                arg2:AddSubGoal(GOAL_COMMON_AttackImmediateAction, 5, 3060, TARGET_ENE_0, 8, 0, 0)
            elseif arg1:GetNumber(30) == 1 then
                arg2:ClearSubGoal()
                arg1:SetNumber(30, 2)
                arg2:AddSubGoal(GOAL_COMMON_AttackImmediateAction, 5, 3014, TARGET_ENE_0, 8, 0, 0)
            elseif arg1:GetNumber(30) == 2 then
                arg2:ClearSubGoal()
                arg1:SetNumber(30, 0)
            end
        elseif arg1:HasSpecialEffectId(TARGET_SELF, 3540078) and f41_local4 > 0 then
            if f41_local5 <= 1 then 
                arg2:ClearSubGoal()
                arg1:SetNumber(4, 1)
                arg2:AddSubGoal(GOAL_COMMON_ComboFinal, 5, 3032, TARGET_ENE_0, 8, 0, 0)
            elseif arg1:GetNumber(23) == 0 then
                arg2:ClearSubGoal()
                arg1:SetNumber(23, 1)
                arg2:AddSubGoal(GOAL_COMMON_AttackImmediateAction, 5, 3016, TARGET_ENE_0, 8, 0, 0)
            elseif arg1:GetNumber(23) == 1 then
                arg2:ClearSubGoal()
                arg1:SetNumber(23, 2)
                arg1:SetNumber(4, 1)
                arg2:AddSubGoal(GOAL_COMMON_ComboFinal, 5, 3032, TARGET_ENE_0, 8, 0, 0)
            elseif arg1:GetNumber(23) == 2 then
                arg2:ClearSubGoal()
                arg1:SetNumber(23, 0)
                arg2:AddSubGoal(GOAL_COMMON_ComboRepeat, 5, 3019, TARGET_ENE_0, 9999, 0, 0)
                arg2:AddSubGoal(GOAL_COMMON_ComboRepeat, 5, 3025, TARGET_ENE_0, 9999, 0, 0)
            end
        elseif arg1:HasSpecialEffectId(TARGET_SELF, 3540085) and f41_local1 <= 4 and f41_local4 > 0 then
            if arg1:GetNumber(24) == 0 then
                arg2:ClearSubGoal()
                arg1:SetNumber(24, 1)
                arg2:AddSubGoal(GOAL_COMMON_AttackImmediateAction, 5, 3003, TARGET_ENE_0, 8, 0, 0)
            elseif arg1:GetNumber(24) == 1 then
                arg2:ClearSubGoal()
                arg1:SetNumber(24, 0)
                arg2:AddSubGoal(GOAL_COMMON_AttackImmediateAction, 5, 3004, TARGET_ENE_0, 8, 0, 0)
            end
        elseif arg1:HasSpecialEffectId(TARGET_SELF, 3540086) and f41_local1 <= 6 and f41_local4 > 0 then
            arg2:ClearSubGoal()
            arg2:AddSubGoal(GOAL_COMMON_AttackImmediateAction, 5, 3021, TARGET_ENE_0, 8, 0, 0)
        elseif arg1:HasSpecialEffectId(TARGET_SELF, 3540086) and f41_local1 > 6 and f41_local4 > 0 then
            arg2:ClearSubGoal()
            arg2:AddSubGoal(GOAL_COMMON_AttackImmediateAction, 5, 3019, TARGET_ENE_0, 8, 0, 0)
        elseif arg1:HasSpecialEffectId(TARGET_SELF, 3540087) and f41_local1 <= 5 and f41_local4 > 0 then
            if arg1:GetNumber(27) == 0 and arg1:HasSpecialEffectId(3540082) then
                arg2:ClearSubGoal()
                arg1:SetNumber(27, 1)
                arg1:SetNumber(4, 1)
                arg2:AddSubGoal(GOAL_COMMON_ComboFinal, 5, 3020, TARGET_ENE_0, 8, 0, 0)
            elseif arg1:GetNumber(27) == 0 and arg1:HasSpecialEffectId(3540083) then
                arg2:ClearSubGoal()
                arg1:SetNumber(27, 1)
                arg2:AddSubGoal(GOAL_COMMON_ComboRepeat, 5, 3020, TARGET_ENE_0, 5, 0, 0)
                arg2:AddSubGoal(GOAL_COMMON_ComboRepeat, 5, 3024, TARGET_ENE_0, 5, 0, 0)
            elseif arg1:GetNumber(27) == 1 then
                arg2:ClearSubGoal()
                arg1:SetNumber(27, 0)
                arg1:SetNumber(4, 0)
                arg2:AddSubGoal(GOAL_COMMON_ComboRepeat, 5, 3022, TARGET_ENE_0, 8, 0, 0)
            end
        elseif arg1:HasSpecialEffectId(TARGET_SELF, 3540088) and f41_local1 <= 4 and f41_local4 > 0 then
            if arg1:GetNumber(29) == 0 then
                arg2:ClearSubGoal()
                arg1:SetNumber(29, 1)
                arg2:AddSubGoal(GOAL_COMMON_AttackImmediateAction, 5, 3011, TARGET_ENE_0, 12, 0, 0)
            elseif arg1:GetNumber(29) == 1 and arg1:HasSpecialEffectId(TARGET_SELF, 3540082) then
                arg2:ClearSubGoal()
                arg1:SetNumber(29, 0)
                arg1:SetNumber(4, 1)
                arg2:AddSubGoal(GOAL_COMMON_ComboFinal, 5, 3020, TARGET_ENE_0, 5, 0, 0)
            elseif arg1:GetNumber(29) == 1 and arg1:HasSpecialEffectId(TARGET_SELF, 3540083) then
                arg2:ClearSubGoal()
                arg1:SetNumber(29, 0)
                arg2:AddSubGoal(GOAL_COMMON_ComboRepeat, 5, 3020, TARGET_ENE_0, 5, 0, 0)
                arg2:AddSubGoal(GOAL_COMMON_ComboRepeat, 5, 3024, TARGET_ENE_0, 5, 0, 0)
            end
        elseif arg1:HasSpecialEffectId(TARGET_SELF, 3540089) then
            arg2:ClearSubGoal()
            arg2:AddSubGoal(GOAL_COMMON_AttackImmediateAction, 5, 3031, TARGET_ENE_0, 12, 0, 0)
        elseif arg1:HasSpecialEffectId(TARGET_SELF, 3540102) and f41_local4 > 0 then
            arg2:ClearSubGoal()
            arg2:AddSubGoal(GOAL_COMMON_AttackImmediateAction, 5, 3039, TARGET_ENE_0, 12, 0, 0)
        elseif arg1:HasSpecialEffectId(TARGET_SELF, 3540103) then
            arg2:ClearSubGoal()
            arg2:AddSubGoal(GOAL_COMMON_AttackImmediateAction, 5, 3004, TARGET_ENE_0, 12, 0, 0)
        elseif arg1:HasSpecialEffectId(TARGET_SELF, 3540104) then
            if arg1:GetNumber(31) == 0 then
                arg1:SetNumber(31, 1)
            else
                arg1:SetNumber(31, 0)
            end
        elseif f41_local0 == 5028 then
            arg1:SetNumber(0, 1)
            return true
        elseif f41_local0 == 5031 then
            if f41_local2 <= 100 and arg1:IsInsideTargetEx(TARGET_SELF, TARGET_ENE_0, AI_DIR_TYPE_F, 45, 5) then
                arg2:ClearSubGoal()
                arg2:AddSubGoal(GOAL_COMMON_ComboRepeat, 2, 3028, TARGET_ENE_0, 9999, 0, 0)
                return true
            end
        elseif f41_local0 == 5034 and f41_local1 >= 4 then
            arg2:ClearSubGoal()
            if f41_local2 > 40 then
                arg2:AddSubGoal(GOAL_COMMON_ComboRepeat, 10, 3026, TARGET_ENE_0, 9999, 0, 0)
            else
                arg2:AddSubGoal(GOAL_COMMON_ComboRepeat, 10, 3005, TARGET_ENE_0, 9999, 0, 0)
            end
        end
    end
    if arg1:IsInterupt(INTERUPT_ShootImpact) then
        arg2:ClearSubGoal()
        arg2:AddSubGoal(GOAL_COMMON_EndureAttack, 0.1, 3100, TARGET_ENE_0, 9999, 0)
        return true
    end
    return false
    
end

Goal.Kengeki_Activate = function (arg0, arg1, arg2, arg3)
    local f42_local0 = ReturnKengekiSpecialEffect(arg1)
    if f42_local0 == 0 then
        return false
    end
    local f42_local1 = {}
    local f42_local2 = {}
    local f42_local3 = {}
    Common_Clear_Param(f42_local1, f42_local2, f42_local3)
    local f42_local4 = arg1:GetDist(TARGET_ENE_0)
    local f42_local5 = arg1:GetSp(TARGET_SELF)
    local f42_local6 = arg1:GetHpRate(TARGET_SELF)
    local f42_local7 = arg1:GetNinsatsuNum()
    if f42_local5 <= 0 then
        f42_local1[50] = 100
    elseif f42_local0 == 200205 or f42_local0 == 200200 then
        if f42_local4 >= 5 then
            f42_local1[9] = 100
        else
            f42_local1[2] = 40
            f42_local1[5] = 40
            if arg1:HasSpecialEffectId(TARGET_SELF, 3540099) == false then
                f42_local1[11] = 60
            end
        end
    elseif f42_local0 == 200206 or f42_local0 == 200201 then
        if f42_local4 >= 5 then
            f42_local1[9] = 100
            f42_local1[8] = 50
        else
            f42_local1[3] = 30
            f42_local1[30] = 30
            if arg1:HasSpecialEffectId(TARGET_SELF, 3540099) == false then
                f42_local1[11] = 50
            end
        end
    elseif f42_local0 == 200229 then
        if f42_local4 >= 5 then
            f42_local1[50] = 100
        else
            f42_local1[2] = 40
        end
    elseif f42_local0 == 200215 then
        if f42_local4 >= 5 then
            f42_local1[50] = 100
        else
            f42_local1[3] = 40
            f42_local1[30] = 40
        end
    elseif f42_local0 == 200216 then
        if f42_local4 >= 5 then
            f42_local1[50] = 100
        else
            f42_local1[2] = 40
        end
    elseif f42_local0 == 200210 then
        if f42_local4 >= 5 then
            f42_local1[50] = 100
        else
            f42_local1[3] = 50
            f42_local1[30] = 50
            if arg1:IsFinishTimer(3) == true then
                f42_local1[8] = 60
            end
            if arg1:HasSpecialEffectId(TARGET_SELF, 3540099) == false then
                f42_local1[11] = 120
            end
        end
    elseif f42_local0 == 200211 then
        if f42_local4 >= 5 then
            f42_local1[50] = 100
        else
            f42_local1[1] = 40
            f42_local1[2] = 40
            if arg1:IsFinishTimer(3) == true then
                f42_local1[8] = 40
            end
            if arg1:HasSpecialEffectId(TARGET_SELF, 3540099) == false then
                f42_local1[11] = 120
            end
        end
    elseif f42_local0 == 200225 then
        arg1:SetNumber(3, arg1:GetNumber(3) + 1)
        if arg1:GetNumber(7) == 0 then
            f42_local1[38] = 999
        else
            f42_local1[36] = 999
        end
    elseif f42_local0 == 200226 then
        arg1:SetNumber(3, arg1:GetNumber(3) + 1)
        arg1:SetNumber(32, arg1:GetNumber(32) + 1)
        if arg1:GetNumber(32) == 1 or arg1:GetNumber(32) == 3 then
            f42_local1[34] = 100
        end
        if arg1:HasSpecialEffectId(TARGET_SELF, 3540099) == false then
            f42_local1[11] = 80
        end
        f42_local1[37] = 1
    end
    if arg1:IsFinishTimer(7) == false then
        f42_local1[17] = 0
    end
    Set_ConsecutiveGuardCount(arg1, f42_local0)
    f42_local1[1] = SetCoolTime(arg1, arg2, 3013, 8, f42_local1[1], 1)
    f42_local1[2] = SetCoolTime(arg1, arg2, 3000, 15, f42_local1[2], 1)
    f42_local1[3] = SetCoolTime(arg1, arg2, 3012, 15, f42_local1[3], 1)
    f42_local1[4] = SetCoolTime(arg1, arg2, 3022, 15, f42_local1[4], 1)
    f42_local1[4] = SetCoolTime(arg1, arg2, 3055, 15, f42_local1[4], 1)
    f42_local1[5] = SetCoolTime(arg1, arg2, 3011, 15, f42_local1[5], 1)
    f42_local1[6] = SetCoolTime(arg1, arg2, 3019, 15, f42_local1[6], 1)
    f42_local1[7] = SetCoolTime(arg1, arg2, 3011, 15, f42_local1[7], 1)
    f42_local1[8] = SetCoolTime(arg1, arg2, 3031, 30, f42_local1[8], 1)
    f42_local1[8] = SetCoolTime(arg1, arg2, 3022, 30, f42_local1[8], 1)
    f42_local1[11] = SetCoolTime(arg1, arg2, 3031, 30, f42_local1[11], 1)
    f42_local1[11] = SetCoolTime(arg1, arg2, 3032, 30, f42_local1[11], 1)
    f42_local1[20] = SetCoolTime(arg1, arg2, 5201, 15, f42_local1[20], 1)
    f42_local1[30] = SetCoolTime(arg1, arg2, 3006, 15, f42_local1[30], 1)
    f42_local1[30] = SetCoolTime(arg1, arg2, 3014, 15, f42_local1[30], 1)
    f42_local1[31] = SetCoolTime(arg1, arg2, 3017, 15, f42_local1[31], 1)
    f42_local1[32] = SetCoolTime(arg1, arg2, 3018, 15, f42_local1[32], 1)
    f42_local1[33] = SetCoolTime(arg1, arg2, 3031, 15, f42_local1[33], 1)
    f42_local1[34] = SetCoolTime(arg1, arg2, 3032, 15, f42_local1[34], 1)
    f42_local1[35] = SetCoolTime(arg1, arg2, 3060, 15, f42_local1[35], 1)
    f42_local1[36] = SetCoolTime(arg1, arg2, 3065, 15, f42_local1[36], 1)
    f42_local1[37] = SetCoolTime(arg1, arg2, 3026, 15, f42_local1[37], 1)
    f42_local1[38] = SetCoolTime(arg1, arg2, 3066, 10, f42_local1[38], 1)
    f42_local2[1] = REGIST_FUNC(arg1, arg2, arg0.Kengeki01)
    f42_local2[2] = REGIST_FUNC(arg1, arg2, arg0.Kengeki02)
    f42_local2[3] = REGIST_FUNC(arg1, arg2, arg0.Kengeki03)
    f42_local2[4] = REGIST_FUNC(arg1, arg2, arg0.Kengeki04)
    f42_local2[5] = REGIST_FUNC(arg1, arg2, arg0.Kengeki05)
    f42_local2[6] = REGIST_FUNC(arg1, arg2, arg0.Kengeki06)
    f42_local2[7] = REGIST_FUNC(arg1, arg2, arg0.Kengeki07)
    f42_local2[8] = REGIST_FUNC(arg1, arg2, arg0.Kengeki08)
    f42_local2[9] = REGIST_FUNC(arg1, arg2, arg0.Kengeki09)
    f42_local2[10] = REGIST_FUNC(arg1, arg2, arg0.Kengeki10)
    f42_local2[11] = REGIST_FUNC(arg1, arg2, arg0.Kengeki11)
    f42_local2[20] = REGIST_FUNC(arg1, arg2, arg0.Kengeki20)
    f42_local2[30] = REGIST_FUNC(arg1, arg2, arg0.Kengeki30)
    f42_local2[31] = REGIST_FUNC(arg1, arg2, arg0.Kengeki31)
    f42_local2[32] = REGIST_FUNC(arg1, arg2, arg0.Kengeki32)
    f42_local2[33] = REGIST_FUNC(arg1, arg2, arg0.Kengeki33)
    f42_local2[34] = REGIST_FUNC(arg1, arg2, arg0.Kengeki34)
    f42_local2[35] = REGIST_FUNC(arg1, arg2, arg0.Kengeki35)
    f42_local2[36] = REGIST_FUNC(arg1, arg2, arg0.Kengeki36)
    f42_local2[37] = REGIST_FUNC(arg1, arg2, arg0.Kengeki37)
    f42_local2[38] = REGIST_FUNC(arg1, arg2, arg0.Kengeki38)
    f42_local2[50] = REGIST_FUNC(arg1, arg2, arg0.NoAction)
    local f42_local7 = REGIST_FUNC(arg1, arg2, arg0.ActAfter_AdjustSpace)
    return Common_Kengeki_Activate(arg1, arg2, f42_local1, f42_local2, f42_local7, f42_local3)
    
end

Goal.Kengeki01 = function (arg0, arg1, arg2)
    local f43_local0 = 0
    arg1:ClearSubGoal()
    arg1:AddSubGoal(GOAL_COMMON_ComboRepeat, 10, 3013, TARGET_ENE_0, 6, 0, 0)
    arg1:AddSubGoal(GOAL_COMMON_ComboRepeat, 10, 3021, TARGET_ENE_0, 9999, 0, 0)
    
end

Goal.Kengeki02 = function (arg0, arg1, arg2)
    arg1:ClearSubGoal()
    arg1:AddSubGoal(GOAL_COMMON_ComboRepeat, 10, 3002, TARGET_ENE_0, 4.5 - arg0:GetMapHitRadius(TARGET_SELF), 0, 0)
    arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3010, TARGET_ENE_0, 9999, 0, 0)
    
end

Goal.Kengeki03 = function (arg0, arg1, arg2)
    arg1:ClearSubGoal()
    arg1:AddSubGoal(GOAL_COMMON_ComboRepeat, 10, 3001, TARGET_ENE_0, 5.9 - arg0:GetMapHitRadius(TARGET_SELF), 0, 0)
    
end

Goal.Kengeki04 = function (arg0, arg1, arg2)
    local f46_local0 = arg0:GetRandam_Int(1, 100)
    local f46_local1 = arg0:GetRandam_Int(1, 100)
    local f46_local2 = arg0:GetHpRate(TARGET_SELF)
    local f46_local3 = 0
    local f46_local4 = 0
    if arg0:IsFinishTimer(7) == true then
        arg1:ClearSubGoal()
        if f46_local0 <= 80 then
            if arg0:GetNinsatsuNum() >= 2 then
                arg1:AddSubGoal(GOAL_COMMON_ComboRepeat, 10, 3022, TARGET_ENE_0, 9999, f46_local3, f46_local4, 0, 0)
            else
                arg1:AddSubGoal(GOAL_COMMON_ComboRepeat, 10, 3055, TARGET_ENE_0, 9999, f46_local3, f46_local4, 0, 0)
            end
            local f46_local5 = arg1:AddSubGoal(GOAL_COMMON_ComboRepeat, 10, 3018, TARGET_ENE_0, 10.5 - arg0:GetMapHitRadius(TARGET_SELF) + 2, f46_local3, f46_local4, 0, 0)
            f46_local5:TimingSetTimer(7, 20, AI_TIMING_SET__ACTIVATE)
            arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3016, TARGET_ENE_0, 9999, f46_local3, f46_local4, 0, 0)
        else
            if arg0:GetNinsatsuNum() >= 2 then
                arg1:AddSubGoal(GOAL_COMMON_ComboRepeat, 10, 3022, TARGET_ENE_0, 9999, f46_local3, f46_local4, 0, 0)
            else
                arg1:AddSubGoal(GOAL_COMMON_ComboRepeat, 10, 3055, TARGET_ENE_0, 9999, f46_local3, f46_local4, 0, 0)
            end
            local f46_local5 = arg1:AddSubGoal(GOAL_COMMON_ComboRepeat, 10, 3018, TARGET_ENE_0, 10.5 - arg0:GetMapHitRadius(TARGET_SELF) + 2, f46_local3, f46_local4, 0, 0)
            f46_local5:TimingSetTimer(7, 20, AI_TIMING_SET__ACTIVATE)
            arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3014, TARGET_ENE_0, 9999, f46_local3, f46_local4, 0, 0)
        end
    else
        arg1:ClearSubGoal()
        if arg0:GetNinsatsuNum() >= 2 then
            arg1:AddSubGoal(GOAL_COMMON_ComboRepeat, 10, 3022, TARGET_ENE_0, 9999, f46_local3, f46_local4, 0, 0)
        else
            arg1:AddSubGoal(GOAL_COMMON_ComboRepeat, 10, 3055, TARGET_ENE_0, 9999, f46_local3, f46_local4, 0, 0)
        end
        if f46_local1 <= 50 then
            arg0:SetNumber(4, 1)
        end
    end
    
end

Goal.Kengeki05 = function (arg0, arg1, arg2)
    arg1:ClearSubGoal()
    arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3011, TARGET_ENE_0, 9999, 0, 0)
    arg0:SetNumber(5, 1)
    
end

Goal.Kengeki06 = function (arg0, arg1, arg2)
    local f48_local0 = 0
    arg1:ClearSubGoal()
    arg1:AddSubGoal(GOAL_COMMON_ComboRepeat, 10, 3019, TARGET_ENE_0, 9999, 0, 0)
    arg2:AddSubGoal(GOAL_COMMON_ComboRepeat, 5, 3025, TARGET_ENE_0, 9999, 0, 0)
    
end

Goal.Kengeki07 = function (arg0, arg1, arg2)
    arg1:ClearSubGoal()
    arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3027, TARGET_ENE_0, 9999, 0, 0)
    
end

Goal.Kengeki08 = function (arg0, arg1, arg2)
    local f50_local0 = 0
    local f50_local1 = 0
    arg1:ClearSubGoal()
    arg1:AddSubGoal(GOAL_COMMON_ComboRepeat, 10, 3022, TARGET_ENE_0, 9999, 0, 0)
    arg0:SetNumber(4, 0)
    arg0:SetTimer(3, 8)
    
end

Goal.Kengeki09 = function (arg0, arg1, arg2)
    arg1:ClearSubGoal()
    arg1:AddSubGoal(GOAL_COMMON_ComboRepeat, 10, 3003, TARGET_ENE_0, 6, 0)
    
end

Goal.Kengeki10 = function (arg0, arg1, arg2)
    local f52_local0 = 0
    local f52_local1 = 0
    arg1:ClearSubGoal()
    arg1:AddSubGoal(GOAL_COMMON_ComboRepeat, 10, 3019, TARGET_ENE_0, 9999, 0, 0)
    arg2:AddSubGoal(GOAL_COMMON_ComboRepeat, 5, 3025, TARGET_ENE_0, 9999, 0, 0)
    
end

Goal.Kengeki11 = function (arg0, arg1, arg2)
    local f53_local0 = arg0:GetNinsatsuNum()
    local f53_local1 = arg0:GetNumber(31)
    if f53_local0 <= 1 then
        arg1:AddSubGoal(GOAL_COMMON_ComboRepeat, 10, 5201, TARGET_ENE_0, 9999, 0, 0)
        arg1:AddSubGoal(GOAL_COMMON_ComboRepeat, 10, 3090, TARGET_ENE_0, 9999, 0, 0)
    elseif f53_local1 == 0 then
        arg1:AddSubGoal(GOAL_COMMON_ComboRepeat, 10, 5201, TARGET_ENE_0, 9999, 0, 0)
        arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3040, TARGET_ENE_0, 9999, 0, 0)
    else
        arg1:AddSubGoal(GOAL_COMMON_ComboRepeat, 10, 5201, TARGET_ENE_0, 9999, 0, 0)
        arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3039, TARGET_ENE_0, 9999, 0, 0)
    end
    
end

Goal.Kengeki20 = function (arg0, arg1, arg2)
    arg1:ClearSubGoal()
    arg1:AddSubGoal(GOAL_COMMON_ComboRepeat, 10, 5201, TARGET_ENE_0, 9999, 0, 0, 0, 0)
    arg0:SetNumber(4, 1)
    arg0:SetNumber(5, 1)
    
end

Goal.Kengeki30 = function (arg0, arg1, arg2)
    arg1:ClearSubGoal()
    if arg0:HasSpecialEffectId(TARGET_SELF, 3540082) then
        arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3020, TARGET_ENE_0, 5, 0)
    elseif arg0:HasSpecialEffectId(TARGET_SELF, 3540083) then
        arg1:AddSubGoal(GOAL_COMMON_ComboRepeat, 10, 3020, TARGET_ENE_0, 5, 0)
        arg1:AddSubGoal(GOAL_COMMON_ComboRepeat, 10, 3024, TARGET_ENE_0, 5, 0, 0)
    end
    arg0:SetNumber(4, 1)
    
end

Goal.Kengeki31 = function (arg0, arg1, arg2)
    arg1:ClearSubGoal()
    arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3017, TARGET_ENE_0, 9999, 0, 0)
    arg0:SetNumber(3, 0)
    
end

Goal.Kengeki32 = function (arg0, arg1, arg2)
    arg1:ClearSubGoal()
    local f57_local0 = arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3018, TARGET_ENE_0, 9999, 0, 0)
    f57_local0:TimingSetTimer(7, 20, AI_TIMING_SET__ACTIVATE)
    arg0:SetNumber(3, 0)
    
end

Goal.Kengeki33 = function (arg0, arg1, arg2)
    arg1:ClearSubGoal()
    arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3032, TARGET_ENE_0, 9999, 0, 0)
    arg0:SetNumber(5, 1)
    
end

Goal.Kengeki34 = function (arg0, arg1, arg2)
    arg1:ClearSubGoal()
    arg1:AddSubGoal(GOAL_COMMON_ComboRepeat, 10, 3060, TARGET_ENE_0, 9999, 0, 0)
    if arg0:GetNumber(32) >= 4 then
        arg0:SetNumber(32, 0)
    end
    
end

Goal.Kengeki35 = function (arg0, arg1, arg2)
    arg1:ClearSubGoal()
    arg1:AddSubGoal(GOAL_COMMON_ComboRepeat, 10, 5201, TARGET_ENE_0, 9999, 0, 0)
    arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3040, TARGET_ENE_0, 9999, 0, 0)
    
end

Goal.Kengeki36 = function (arg0, arg1, arg2)
    arg1:ClearSubGoal()
    arg0:SetNumber(7, 0)
    arg1:AddSubGoal(GOAL_COMMON_ComboRepeat, 10, 3065, TARGET_ENE_0, 6, 0, 0, 0, 0)
    arg1:AddSubGoal(GOAL_COMMON_ComboRepeat, 10, 3004, TARGET_ENE_0, 9999, 0, 0)
    
end

Goal.Kengeki37 = function (arg0, arg1, arg2)
    arg1:ClearSubGoal()
    arg1:AddSubGoal(GOAL_COMMON_ComboRepeat, 10, 3004, TARGET_ENE_0, 6, 0, 0, 0, 0)
    
end

Goal.Kengeki38 = function (arg0, arg1, arg2)
    local f63_local0 = arg0:GetHpRate(TARGET_SELF)
    arg1:ClearSubGoal()
    arg0:SetNumber(7, 1)
    arg1:AddSubGoal(GOAL_COMMON_ComboRepeat, 10, 3066, TARGET_ENE_0, 9999, 0, 0, 0, 0)
    
end

Goal.NoAction = function (arg0, arg1, arg2)
    return -1
    
end

Goal.ActAfter_AdjustSpace = function (arg0, arg1, arg2)
    
end

Goal.Update = function (arg0, arg1, arg2)
    return Update_Default_NoSubGoal(arg0, arg1, arg2)
    
end

Goal.Terminate = function (arg0, arg1, arg2)
    
end


