RegisterTableGoal(GOAL_Orochi_jouka_501010_Battle, "GOAL_Orochi_jouka_501010_Battle")

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
    f2_arg1:SetStringIndexedNumber("Orochi_SightDist", 5)
    f2_arg1:SetStringIndexedNumber("Orochi_SightPos", 15)
    f2_arg1:SetEventFlag(19625480, false)
    f2_arg1:SetEventFlag(19625481, false)
    f2_arg1:SetEventFlag(19625482, false)
    f2_arg1:SetEventFlag(19625483, false)
    f2_arg1:SetEventFlag(19625484, false)
    f2_arg1:SetEventFlag(19625485, false)
    f2_arg1:AddObserveRegion(4, TARGET_ENE_0, 1102861)
    f2_arg1:AddObserveRegion(5, TARGET_ENE_0, 1102862)
    if f2_arg1:HasSpecialEffectId(TARGET_SELF, 3501010) then
        f2_arg1:AddObserveSpecialEffectAttribute(TARGET_SELF, 5025)
        f2_arg1:AddObserveSpecialEffectAttribute(TARGET_SELF, 5026)
        f2_arg1:AddObserveSpecialEffectAttribute(TARGET_SELF, 5027)
        f2_arg1:AddObserveSpecialEffectAttribute(TARGET_SELF, 5028)
        f2_arg1:AddObserveSpecialEffectAttribute(TARGET_SELF, 5029)
        f2_arg1:AddObserveRegion(1, TARGET_ENE_0, 1102865)
    end
    if f2_arg1:HasSpecialEffectId(TARGET_SELF, 3501011) then
        f2_arg1:AddObserveSpecialEffectAttribute(TARGET_SELF, 5030)
        f2_arg1:AddObserveSpecialEffectAttribute(TARGET_SELF, 5031)
        f2_arg1:AddObserveSpecialEffectAttribute(TARGET_SELF, 5032)
        f2_arg1:AddObserveSpecialEffectAttribute(TARGET_SELF, 5033)
        f2_arg1:AddObserveSpecialEffectAttribute(TARGET_SELF, 5034)
        f2_arg1:AddObserveSpecialEffectAttribute(TARGET_SELF, 5035)
        f2_arg1:AddObserveSpecialEffectAttribute(TARGET_SELF, 5037)
        f2_arg1:AddObserveSpecialEffectAttribute(TARGET_SELF, 5038)
        f2_arg1:AddObserveSpecialEffectAttribute(TARGET_ENE_0, 3501021)
        f2_arg1:AddObserveRegion(2, TARGET_ENE_0, 1102895)
        f2_arg1:AddObserveRegion(3, TARGET_ENE_0, 1102897)
        f2_arg1:AddObserveRegion(6, TARGET_ENE_0, 1102879)
    end
    f2_arg1:DeleteObserve(0)
    local f2_local3 = f2_arg1:GetHpRate(TARGET_SELF)
    local f2_local4 = f2_arg1:GetSp(TARGET_SELF)
    local f2_local5 = f2_arg1:GetDist(TARGET_ENE_0)
    local f2_local6 = f2_arg1:GetRandam_Int(1, 100)
    local f2_local7 = f2_arg1:GetExcelParam(AI_EXCEL_THINK_PARAM_TYPE__thinkAttr_doAdmirer)
    local f2_local8 = f2_arg1:GetEventRequest()
    if f2_arg1:IsEventFlag(11100850) or f2_arg1:GetNumber(3) == 1 then
        f2_local0[30] = 100
    elseif f2_arg1:IsInsideTargetRegion(TARGET_ENE_0, 1102865) and f2_arg1:GetNumber(0) == 0 then
        f2_local0[8] = 100
    elseif (f2_arg1:IsInsideTargetRegion(TARGET_ENE_0, 1102861) or f2_arg1:IsInsideTargetRegion(TARGET_ENE_0, 1102862)) and f2_arg1:HasSpecialEffectId(TARGET_SELF, 3501033) == false and f2_arg1:GetNumber(0) == 0 then
        if f2_arg1:HasSpecialEffectId(TARGET_SELF, 3501010) == false then
            f2_local0[1] = 100
        elseif f2_arg1:GetNumber(1) == 0 then
            f2_local0[2] = 100
        elseif f2_arg1:GetNumber(1) == 1 then
            f2_local0[4] = 100
        elseif f2_arg1:GetNumber(1) == 2 then
            f2_local0[7] = 100
        else
            f2_local0[5] = 100
        end
    elseif f2_arg1:IsInsideTargetRegion(TARGET_ENE_0, 1102865) then
        f2_local0[30] = 100
    elseif f2_arg1:IsInsideTargetRegion(TARGET_ENE_0, 1102881) and f2_arg1:HasSpecialEffectId(TARGET_SELF, 3501013) == false and f2_arg1:HasSpecialEffectId(TARGET_SELF, 3501010) == false then
        if f2_arg1:HasSpecialEffectId(TARGET_SELF, 3501011) == false then
            f2_local0[11] = 100
        elseif not f2_arg1:HasSpecialEffectId(TARGET_SELF, 3501013) and f2_arg1:IsInsideTargetRegion(TARGET_ENE_0, 1102897) then
            f2_local0[25] = 100
        elseif not f2_arg1:HasSpecialEffectId(TARGET_SELF, 3501013) and f2_arg1:IsInsideTargetRegion(TARGET_ENE_0, 1102879) then
            f2_local0[26] = 100
        elseif f2_arg1:HasSpecialEffectId(TARGET_ENE_0, 109940) and not f2_arg1:HasSpecialEffectId(TARGET_SELF, 3501030) then
            if f2_arg1:HasSpecialEffectId(TARGET_ENE_0, 110010) then
                f2_local0[18] = 100
            elseif f2_arg1:HasSpecialEffectId(TARGET_SELF, 3501012) == false then
                f2_local0[21] = 100
            else
                f2_local0[22] = 100
            end
        elseif f2_arg1:IsInsideTargetRegion(TARGET_ENE_0, 1102886) or f2_arg1:IsInsideTargetRegion(TARGET_ENE_0, 1102889) then
            f2_local0[18] = 50
        elseif f2_arg1:IsInsideTargetRegion(TARGET_ENE_0, 1102882) then
            f2_local0[14] = 50
            f2_local0[15] = 30
        elseif f2_arg1:IsInsideTargetRegion(TARGET_ENE_0, 1102883) then
            f2_local0[13] = 70
            f2_local0[16] = 30
        elseif f2_arg1:IsInsideTargetRegion(TARGET_ENE_0, 1102885) then
            f2_local0[18] = 50
        elseif f2_arg1:IsInsideTargetRegion(TARGET_ENE_0, 1102884) then
            if f2_arg1:HasSpecialEffectId(TARGET_ENE_0, 110010) then
                f2_local0[13] = 10
            else
                f2_local0[12] = 20
                f2_local0[16] = 60
            end
        else
            f2_local0[12] = 100
            f2_local0[13] = 100
        end
    elseif f2_arg1:IsInsideTargetRegion(TARGET_ENE_0, 1102895) and f2_arg1:HasSpecialEffectId(TARGET_SELF, 3501013) == false then
        f2_local0[24] = 100
    elseif f2_arg1:HasSpecialEffectId(TARGET_SELF, 3501013) then
        if f2_arg1:IsInsideTargetRegion(TARGET_ENE_0, 1102895) == false then
            f2_local0[23] = 100
        else
            f2_local0[24] = 100
        end
    elseif f2_arg1:HasSpecialEffectId(TARGET_SELF, 3501010) then
        f2_local0[10] = 100
    elseif f2_arg1:HasSpecialEffectId(TARGET_SELF, 3501011) then
        f2_local0[20] = 100
    else
        f2_local0[30] = 100
    end
    if f2_arg1:IsFinishTimer(0) == false then
        f2_local0[7] = f2_local0[7] * 3
    end
    if f2_arg1:IsFinishTimer(1) == false then
    end
    if f2_arg1:IsFinishTimer(2) == false then
        f2_local0[6] = f2_local0[6] * 2
    end
    f2_local0[2] = SetCoolTime(f2_arg1, f2_arg2, 20011, 30, f2_local0[2], 1)
    f2_local0[3] = SetCoolTime(f2_arg1, f2_arg2, 20012, 45, f2_local0[3], 1)
    f2_local0[4] = SetCoolTime(f2_arg1, f2_arg2, 20013, 20, f2_local0[4], 1)
    f2_local0[5] = SetCoolTime(f2_arg1, f2_arg2, 20014, 10, f2_local0[5], 1)
    f2_local0[6] = SetCoolTime(f2_arg1, f2_arg2, 20015, 20, f2_local0[6], 1)
    f2_local0[7] = SetCoolTime(f2_arg1, f2_arg2, 20016, 20, f2_local0[7], 1)
    f2_local0[12] = SetCoolTime(f2_arg1, f2_arg2, 20021, 10, f2_local0[12], 1)
    f2_local0[13] = SetCoolTime(f2_arg1, f2_arg2, 20022, 30, f2_local0[13], 1)
    f2_local0[14] = SetCoolTime(f2_arg1, f2_arg2, 20023, 20, f2_local0[14], 1)
    f2_local0[15] = SetCoolTime(f2_arg1, f2_arg2, 20024, 20, f2_local0[15], 1)
    f2_local0[16] = SetCoolTime(f2_arg1, f2_arg2, 20025, 20, f2_local0[16], 1)
    f2_local0[17] = SetCoolTime(f2_arg1, f2_arg2, 20026, 20, f2_local0[17], 1)
    f2_local0[18] = SetCoolTime(f2_arg1, f2_arg2, 20027, 30, f2_local0[18], 1)
    f2_local0[19] = SetCoolTime(f2_arg1, f2_arg2, 20028, 25, f2_local0[19], 1)
    f2_local1[1] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act01)
    f2_local1[2] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act02)
    f2_local1[3] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act03)
    f2_local1[4] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act04)
    f2_local1[5] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act05)
    f2_local1[6] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act06)
    f2_local1[7] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act07)
    f2_local1[8] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act08)
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
    f2_local1[30] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act30)
    local f2_local9 = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.ActAfter_AdjustSpace)
    Common_Battle_Activate(f2_arg1, f2_arg2, f2_local0, f2_local1, f2_local9, f2_local2)
    
end

Goal.Act01 = function (f3_arg0, f3_arg1, f3_arg2)
    f3_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 20, 20010, TARGET_ENE_0, 999, 0, 0, 0, 0)
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
    
end

Goal.Act02 = function (f4_arg0, f4_arg1, f4_arg2)
    f4_arg0:SetEventFlag(19625480, true)
    f4_arg0:SetEventFlag(19625481, true)
    f4_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 30, 20011, TARGET_ENE_0, 999, 0, 0, 0, 0):TimingSetNumber(1, 1, AI_TIMING_SET__ACTIVATE)
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
    
end

Goal.Act03 = function (f5_arg0, f5_arg1, f5_arg2)
    f5_arg0:SetEventFlag(19625480, true)
    f5_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 20, 20012, TARGET_ENE_0, 999, 0, 0, 0, 0)
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
    
end

Goal.Act04 = function (f6_arg0, f6_arg1, f6_arg2)
    f6_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 20, 20013, TARGET_ENE_0, 999, 0, 0, 0, 0):TimingSetNumber(1, 2, AI_TIMING_SET__ACTIVATE)
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
    
end

Goal.Act05 = function (f7_arg0, f7_arg1, f7_arg2)
    f7_arg0:SetEventFlag(19625480, true)
    f7_arg0:SetEventFlag(19625481, true)
    f7_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 20, 20014, TARGET_ENE_0, 999, 0, 0, 0, 0):TimingSetNumber(1, 0, AI_TIMING_SET__ACTIVATE)
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
    
end

Goal.Act06 = function (f8_arg0, f8_arg1, f8_arg2)
    f8_arg0:SetEventFlag(19625481, true)
    f8_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 20, 20015, TARGET_ENE_0, 999, 0, 0, 0, 0)
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
    
end

Goal.Act07 = function (f9_arg0, f9_arg1, f9_arg2)
    f9_arg0:SetEventFlag(19625481, true)
    f9_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 20, 20016, TARGET_ENE_0, 999, 0, 0, 0, 0):TimingSetNumber(1, 3, AI_TIMING_SET__ACTIVATE)
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
    
end

Goal.Act08 = function (f10_arg0, f10_arg1, f10_arg2)
    f10_arg1:AddSubGoal(GOAL_COMMON_ComboTunable_SuccessAngle180, 20, 20031, TARGET_ENE_0, 999, 0, 0, 0, 0)
    f10_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 20, 20019, TARGET_ENE_0, 999, 0, 0, 0, 0)
    f10_arg0:SetNumber(0, 1)
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
    
end

Goal.Act10 = function (f11_arg0, f11_arg1, f11_arg2)
    f11_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 20, 20019, TARGET_ENE_0, 999, 0, 0, 0, 0)
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
    
end

Goal.Act11 = function (f12_arg0, f12_arg1, f12_arg2)
    f12_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 20, 20020, TARGET_ENE_0, 999, 0, 0, 0, 0)
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
    
end

Goal.Act12 = function (f13_arg0, f13_arg1, f13_arg2)
    f13_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 20, 20021, TARGET_ENE_0, 999, 0, 0, 0, 0)
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
    
end

Goal.Act13 = function (f14_arg0, f14_arg1, f14_arg2)
    f14_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 20, 20022, TARGET_ENE_0, 999, 0, 0, 0, 0)
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
    
end

Goal.Act14 = function (f15_arg0, f15_arg1, f15_arg2)
    f15_arg0:SetEventFlag(19625482, true)
    f15_arg0:SetEventFlag(19625483, true)
    f15_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 20, 20023, TARGET_ENE_0, 999, 0, 0, 0, 0)
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
    
end

Goal.Act15 = function (f16_arg0, f16_arg1, f16_arg2)
    f16_arg0:SetEventFlag(19625482, true)
    f16_arg0:SetEventFlag(19625483, true)
    f16_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 20, 20024, TARGET_ENE_0, 999, 0, 0, 0, 0)
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
    
end

Goal.Act16 = function (f17_arg0, f17_arg1, f17_arg2)
    f17_arg0:SetEventFlag(19625483, true)
    f17_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 20, 20025, TARGET_ENE_0, 999, 0, 0, 0, 0)
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
    
end

Goal.Act17 = function (f18_arg0, f18_arg1, f18_arg2)
    f18_arg0:SetEventFlag(19625484, true)
    f18_arg0:AddObserveChrDmySphere(0, TARGET_ENE_0, f18_arg0:GetStringIndexedNumber("Orochi_SightPos"), f18_arg0:GetStringIndexedNumber("Orochi_SightDist") + 3)
    f18_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 20, 20026, TARGET_ENE_0, 999, 0, 0, 0, 0)
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
    
end

Goal.Act18 = function (f19_arg0, f19_arg1, f19_arg2)
    f19_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 20, 20027, TARGET_ENE_0, 999, 0, 0, 0, 0)
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
    
end

Goal.Act19 = function (f20_arg0, f20_arg1, f20_arg2)
    f20_arg0:SetEventFlag(19625484, true)
    f20_arg0:AddObserveChrDmySphere(0, TARGET_ENE_0, f20_arg0:GetStringIndexedNumber("Orochi_SightPos"), f20_arg0:GetStringIndexedNumber("Orochi_SightDist"))
    f20_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 20, 20028, TARGET_ENE_0, 999, 0, 0, 0, 0)
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
    
end

Goal.Act20 = function (f21_arg0, f21_arg1, f21_arg2)
    f21_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 20, 20029, TARGET_ENE_0, 999, 0, 0, 0, 0)
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
    
end

Goal.Act21 = function (f22_arg0, f22_arg1, f22_arg2)
    f22_arg0:SetEventFlag(19625485, true)
    f22_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 20, 20002, TARGET_ENE_0, 999, 0, 0, 0, 0)
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
    
end

Goal.Act22 = function (f23_arg0, f23_arg1, f23_arg2)
    f23_arg0:SetEventFlag(19625485, true)
    f23_arg1:AddSubGoal(GOAL_COMMON_Wait, 10, TARGET_NONE, 0, 0, 0)
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
    
end

Goal.Act23 = function (f24_arg0, f24_arg1, f24_arg2)
    f24_arg1:AddSubGoal(GOAL_COMMON_Wait, 10, TARGET_NONE, 0, 0, 0)
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
    
end

Goal.Act24 = function (f25_arg0, f25_arg1, f25_arg2)
    f25_arg0:AddObserveSpecialEffectAttribute(TARGET_SELF, 5036)
    if f25_arg0:HasSpecialEffectId(TARGET_SELF, 3501013) then
        f25_arg1:AddSubGoal(GOAL_COMMON_Wait, 2.5, TARGET_NONE, 0, 0, 0)
    end
    f25_arg1:AddSubGoal(GOAL_COMMON_ComboTunable_SuccessAngle180, 20, 20004, TARGET_ENE_0, 999, 0, 0, 0, 0)
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
    
end

Goal.Act25 = function (f26_arg0, f26_arg1, f26_arg2)
    f26_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 20, 20037, TARGET_ENE_0, 999, 0, 0, 0, 0)
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
    
end

Goal.Act26 = function (f27_arg0, f27_arg1, f27_arg2)
    f27_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 20, 20026, TARGET_ENE_0, 999, 0, 0, 0, 0)
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
    
end

Goal.Act30 = function (f28_arg0, f28_arg1, f28_arg2)
    if f28_arg0:HasSpecialEffectId(TARGET_SELF, 3501013) then
        f28_arg1:AddSubGoal(GOAL_COMMON_Wait, 0.5, TARGET_NONE, 0, 0, 0)
    elseif f28_arg0:HasSpecialEffectId(TARGET_SELF, 3501010) then
        f28_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 20, 20019, TARGET_ENE_0, 999, 0, 0, 0, 0)
    elseif f28_arg0:HasSpecialEffectId(TARGET_SELF, 3501011) then
        f28_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 20, 20029, TARGET_ENE_0, 999, 0, 0, 0, 0)
    else
        f28_arg1:AddSubGoal(GOAL_COMMON_Wait, 0.5, TARGET_NONE, 0, 0, 0)
    end
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
    
end

Goal.ActAfter_AdjustSpace = function (f29_arg0, f29_arg1, f29_arg2)
    
end

Goal.Update = function (f30_arg0, f30_arg1, f30_arg2)
    return Update_Default_NoSubGoal(f30_arg0, f30_arg1, f30_arg2)
    
end

Goal.Terminate = function (f31_arg0, f31_arg1, f31_arg2)
    
end

Goal.Interrupt = function (f32_arg0, f32_arg1, f32_arg2)
    -- Warning: Function 32 using already code-generated block basicblock_129
end


