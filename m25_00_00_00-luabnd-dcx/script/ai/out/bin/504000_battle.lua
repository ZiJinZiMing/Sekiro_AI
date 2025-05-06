RegisterTableGoal(GOAL_Waraningyou_504000_Battle, "GOAL_Waraningyou_504000_Battle")
REGISTER_GOAL_NO_SUB_GOAL(GOAL_Waraningyou_504000_Battle, true)

Goal.Initialize = function (f1_arg0, f1_arg1, f1_arg2, f1_arg3)
    
end

Goal.Activate = function (f2_arg0, f2_arg1, f2_arg2)
    Init_Pseudo_Global(f2_arg1, f2_arg2)
    local f2_local0 = {}
    local f2_local1 = {}
    local f2_local2 = {}
    Common_Clear_Param(f2_local0, f2_local1, f2_local2)
    f2_arg1:AddObserveChrDmySphere(0, TARGET_ENE_0, 20, 6)
    f2_arg1:AddObserveChrDmySphere(1, TARGET_ENE_0, 1, 10)
    f2_arg1:AddObserveChrDmySphere(2, TARGET_ENE_0, 10, 9)
    f2_arg1:AddObserveChrDmySphere(3, TARGET_ENE_0, 11, 9)
    f2_arg1:AddObserveChrDmySphere(4, TARGET_ENE_0, 2, 10)
    f2_arg1:AddObserveChrDmySphere(5, TARGET_ENE_0, 15, 9)
    f2_arg1:AddObserveChrDmySphere(6, TARGET_ENE_0, 16, 9)
    f2_arg1:AddObserveChrDmySphere(7, TARGET_ENE_0, 21, 10)
    f2_arg1:AddObserveSpecialEffectAttribute(TARGET_ENE_0, 3504005)
    f2_arg1:AddObserveSpecialEffectAttribute(TARGET_SELF, 3504007)
    f2_arg1:AddObserveSpecialEffectAttribute(TARGET_SELF, 3504008)
    local f2_local3 = f2_arg1:GetEventRequest()
    local f2_local4 = f2_arg1:GetHpRate(TARGET_SELF)
    local f2_local5 = f2_arg1:GetSp(TARGET_SELF)
    local f2_local6 = f2_arg1:GetDist(TARGET_ENE_0)
    local f2_local7 = f2_arg1:GetRandam_Int(1, 100)
    local f2_local8 = f2_arg1:GetExcelParam(AI_EXCEL_THINK_PARAM_TYPE__thinkAttr_doAdmirer)
    f2_arg1:AddObserveSpecialEffectAttribute(TARGET_SELF, 200200)
    if f2_arg1:HasSpecialEffectId(TARGET_SELF, 200030) or f2_arg1:HasSpecialEffectId(TARGET_SELF, 200031) then
        if f2_arg1:IsEventFlag(19625685) == true then
            f2_local0[7] = 100
        elseif f2_arg1:IsEventFlag(19625681) == true then
            if f2_arg1:HasSpecialEffectId(TARGET_SELF, 200030) then
                f2_local0[3] = 100
            else
                f2_local0[4] = 100
            end
        elseif f2_arg1:IsEventFlag(19625682) == true then
            if f2_arg1:HasSpecialEffectId(TARGET_SELF, 200030) then
                f2_local0[2] = 100
            else
                f2_local0[5] = 100
            end
        elseif f2_arg1:IsEventFlag(19625683) == true or f2_arg1:IsEventFlag(19625684) == true then
            if f2_arg1:HasSpecialEffectId(TARGET_SELF, 200030) then
                f2_local0[6] = 100
            else
                f2_local0[15] = 100
            end
        elseif f2_arg1:IsEventFlag(19625680) == true then
            f2_local0[1] = 100
        end
    elseif f2_arg1:HasSpecialEffectId(TARGET_SELF, 200032) then
        if f2_arg1:IsEventFlag(19625686) == true then
            f2_local0[9] = 100
        elseif not f2_arg1:IsEventFlag(19625685) == true then
            f2_local0[10] = 100
        else
            f2_local0[8] = 90
            f2_local0[20] = 10
        end
    elseif f2_arg1:HasSpecialEffectId(TARGET_SELF, 200033) then
        if f2_arg1:IsEventFlag(19625690) == true then
            f2_local0[16] = 100
        elseif f2_arg1:IsEventFlag(19625688) == true then
            f2_local0[21] = 100
        elseif f2_arg1:IsEventFlag(19625686) == true then
            f2_local0[11] = 100
        elseif f2_arg1:IsEventFlag(19625687) == true then
            f2_local0[12] = 100
        else
            f2_local0[13] = 100
        end
    elseif f2_arg1:HasSpecialEffectId(TARGET_SELF, 200034) then
        if f2_arg1:IsEventFlag(19625693) == true then
            f2_local0[14] = 100
        else
            f2_local0[20] = 100
        end
    end
    f2_local0[4] = SetCoolTime(f2_arg1, f2_arg2, 20005, 10, f2_local0[4], 1)
    f2_local0[7] = SetCoolTime(f2_arg1, f2_arg2, 20012, 10, f2_local0[7], 1)
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
    local f2_local9 = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.ActAfter_AdjustSpace)
    Common_Battle_Activate(f2_arg1, f2_arg2, f2_local0, f2_local1, f2_local9, f2_local2)
    
end

Goal.Act01 = function (f3_arg0, f3_arg1, f3_arg2)
    local f3_local0 = 20028
    local f3_local1 = ATT_SUCCESSDIST
    local f3_local2 = 0
    local f3_local3 = 0
    local f3_local4 = f3_arg0:GetRandam_Int(1, 100)
    f3_arg1:AddSubGoal(GOAL_COMMON_ComboTunable_SuccessAngle180, 30, f3_local0, TARGET_ENE_0, 999, 0, 0, 0, 0)
    f3_arg1:AddSubGoal(GOAL_COMMON_Wait, 5, TARGET_NONE, 0, 0, 0)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act02 = function (f4_arg0, f4_arg1, f4_arg2)
    local f4_local0 = 20024
    local f4_local1 = ATT_SUCCESSDIST
    local f4_local2 = 0
    local f4_local3 = 0
    local f4_local4 = f4_arg0:GetRandam_Int(1, 100)
    f4_arg1:AddSubGoal(GOAL_COMMON_ComboTunable_SuccessAngle180, 30, f4_local0, TARGET_ENE_0, 999, 0, 0, 0, 0)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act03 = function (f5_arg0, f5_arg1, f5_arg2)
    local f5_local0 = 20025
    local f5_local1 = ATT_SUCCESSDIST
    local f5_local2 = 0
    local f5_local3 = 0
    local f5_local4 = f5_arg0:GetRandam_Int(1, 100)
    f5_arg1:AddSubGoal(GOAL_COMMON_ComboTunable_SuccessAngle180, 30, f5_local0, TARGET_ENE_0, 999, 0, 0, 0, 0)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act04 = function (f6_arg0, f6_arg1, f6_arg2)
    local f6_local0 = 20026
    local f6_local1 = ATT_SUCCESSDIST
    local f6_local2 = 0
    local f6_local3 = 0
    local f6_local4 = f6_arg0:GetRandam_Int(1, 100)
    f6_arg1:AddSubGoal(GOAL_COMMON_ComboTunable_SuccessAngle180, 30, f6_local0, TARGET_ENE_0, 999, 0, 0, 0, 0)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act05 = function (f7_arg0, f7_arg1, f7_arg2)
    local f7_local0 = 20027
    local f7_local1 = ATT_SUCCESSDIST
    local f7_local2 = 0
    local f7_local3 = 0
    local f7_local4 = f7_arg0:GetRandam_Int(1, 100)
    f7_arg1:AddSubGoal(GOAL_COMMON_ComboTunable_SuccessAngle180, 30, f7_local0, TARGET_ENE_0, 999, 0, 0, 0, 0)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act06 = function (f8_arg0, f8_arg1, f8_arg2)
    local f8_local0 = 20017
    local f8_local1 = ATT_SUCCESSDIST
    local f8_local2 = 0
    local f8_local3 = 0
    local f8_local4 = f8_arg0:GetRandam_Int(1, 100)
    f8_arg1:AddSubGoal(GOAL_COMMON_ComboTunable_SuccessAngle180, 30, f8_local0, TARGET_ENE_0, 999, 0, 0, 0, 0)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act07 = function (f9_arg0, f9_arg1, f9_arg2)
    f9_arg1:AddSubGoal(GOAL_COMMON_Wait, 3, TARGET_NONE, 0, 0, 0)
    f9_arg1:AddSubGoal(GOAL_COMMON_ComboTunable_SuccessAngle180, 30, 20003, TARGET_ENE_0, 999, 0, 0, 0, 0)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act08 = function (f10_arg0, f10_arg1, f10_arg2)
    f10_arg1:AddSubGoal(GOAL_COMMON_ComboTunable_SuccessAngle180, 30, 20005, TARGET_ENE_0, 999, 0, 0, 0, 0)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act09 = function (f11_arg0, f11_arg1, f11_arg2)
    f11_arg1:AddSubGoal(GOAL_COMMON_ComboTunable_SuccessAngle180, 30, 20007, TARGET_ENE_0, 999, 0, 0, 0, 0)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act10 = function (f12_arg0, f12_arg1, f12_arg2)
    f12_arg1:AddSubGoal(GOAL_COMMON_ComboTunable_SuccessAngle180, 30, 20004, TARGET_ENE_0, 999, 0, 0, 0, 0)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act11 = function (f13_arg0, f13_arg1, f13_arg2)
    local f13_local0 = 20010
    local f13_local1 = 20024
    local f13_local2 = 999
    local f13_local3 = 0
    local f13_local4 = 0
    local f13_local5 = f13_arg0:GetRandam_Int(1, 100)
    f13_arg1:AddSubGoal(GOAL_COMMON_ComboTunable_SuccessAngle180, 20, f13_local0, TARGET_ENE_0, f13_local2, f13_local3, f13_local4, 0, 0)
    f13_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 20, f13_local1, TARGET_ENE_0, 9999, 0, 0)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act12 = function (f14_arg0, f14_arg1, f14_arg2)
    f14_arg1:AddSubGoal(GOAL_COMMON_ComboTunable_SuccessAngle180, 30, 20011, TARGET_ENE_0, 999, 0, 0, 0, 0)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act13 = function (f15_arg0, f15_arg1, f15_arg2)
    f15_arg1:AddSubGoal(GOAL_COMMON_ComboTunable_SuccessAngle180, 30, 20019, TARGET_ENE_0, 999, 0, 0, 0, 0)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act14 = function (f16_arg0, f16_arg1, f16_arg2)
    f16_arg1:AddSubGoal(GOAL_COMMON_ComboTunable_SuccessAngle180, 30, 20022, TARGET_ENE_0, 999, 0, 0, 0, 0)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act15 = function (f17_arg0, f17_arg1, f17_arg2)
    f17_arg1:AddSubGoal(GOAL_COMMON_ComboTunable_SuccessAngle180, 30, 20018, TARGET_ENE_0, 999, 0, 0, 0, 0)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act16 = function (f18_arg0, f18_arg1, f18_arg2)
    f18_arg1:AddSubGoal(GOAL_COMMON_ComboTunable_SuccessAngle180, 30, 20020, TARGET_ENE_0, 999, 0, 0, 0, 0)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act17 = function (f19_arg0, f19_arg1, f19_arg2)
    f19_arg0:SetNumber(4, 1)
    f19_arg1:AddSubGoal(GOAL_COMMON_ComboTunable_SuccessAngle180, 30, 20023, TARGET_ENE_0, 999, 0, 0, 0, 0)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act18 = function (f20_arg0, f20_arg1, f20_arg2)
    f20_arg1:AddSubGoal(GOAL_COMMON_ComboTunable_SuccessAngle180, 30, 20008, TARGET_ENE_0, 999, 0, 0, 0, 0)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act19 = function (f21_arg0, f21_arg1, f21_arg2)
    f21_arg1:AddSubGoal(GOAL_COMMON_ComboTunable_SuccessAngle180, 30, 20029, TARGET_ENE_0, 999, 0, 0, 0, 0)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act20 = function (f22_arg0, f22_arg1, f22_arg2)
    f22_arg0:SetNumber(3, 0)
    f22_arg1:AddSubGoal(GOAL_COMMON_Wait, 3, TARGET_NONE, 0, 0, 0)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act21 = function (f23_arg0, f23_arg1, f23_arg2)
    f23_arg1:AddSubGoal(GOAL_COMMON_ComboTunable_SuccessAngle180, 30, 20030, TARGET_ENE_0, 999, 0, 0, 0, 0)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.ActAfter_AdjustSpace = function (f24_arg0, f24_arg1, f24_arg2)
    
end

Goal.Update = function (f25_arg0, f25_arg1, f25_arg2)
    f25_arg1:SetEventFlag(19625680, false)
    f25_arg1:SetEventFlag(19625681, false)
    f25_arg1:SetEventFlag(19625682, false)
    f25_arg1:SetEventFlag(19625683, false)
    f25_arg1:SetEventFlag(19625684, false)
    f25_arg1:SetEventFlag(19625685, false)
    f25_arg1:SetEventFlag(19625686, false)
    f25_arg1:SetEventFlag(19625687, false)
    f25_arg1:SetEventFlag(19625688, false)
    f25_arg1:SetEventFlag(19625689, false)
    f25_arg1:SetEventFlag(19625693, false)
    if f25_arg1:HasSpecialEffectId(TARGET_ENE_0, 3504006) then
        f25_arg1:SetEventFlag(19625693, true)
    elseif f25_arg1:IsInsideObserve(7) then
        f25_arg1:SetEventFlag(19625688, true)
    elseif f25_arg1:IsInsideObserve(4) or f25_arg1:IsInsideObserve(5) or f25_arg1:IsInsideObserve(6) then
        f25_arg1:SetEventFlag(19625687, true)
    elseif f25_arg1:IsInsideObserve(1) or f25_arg1:IsInsideObserve(2) or f25_arg1:IsInsideObserve(3) then
        f25_arg1:SetEventFlag(19625686, true)
    elseif f25_arg1:IsInsideObserve(0) then
        f25_arg1:SetEventFlag(19625685, true)
    elseif f25_arg1:HasSpecialEffectId(TARGET_ENE_0, 3504004) then
        f25_arg1:SetEventFlag(19625684, true)
    elseif f25_arg1:HasSpecialEffectId(TARGET_ENE_0, 3504003) then
        f25_arg1:SetEventFlag(19625683, true)
    elseif f25_arg1:HasSpecialEffectId(TARGET_ENE_0, 3504002) then
        f25_arg1:SetEventFlag(19625682, true)
    elseif f25_arg1:HasSpecialEffectId(TARGET_ENE_0, 3504001) then
        f25_arg1:SetEventFlag(19625681, true)
    else
        f25_arg1:SetEventFlag(19625680, true)
    end
    return Update_Default_NoSubGoal(f25_arg0, f25_arg1, f25_arg2)
    
end

Goal.Terminate = function (f26_arg0, f26_arg1, f26_arg2)
    
end

Goal.Interrupt = function (f27_arg0, f27_arg1, f27_arg2)
    if f27_arg1:IsInterupt(INTERUPT_ActivateSpecialEffect) then
        if f27_arg1:HasSpecialEffectId(TARGET_ENE_0, 3504005) then
            f27_arg2:ClearSubGoal()
            f27_arg2:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 20029, TARGET_ENE_0, 9999, 0, 0)
            return true
        elseif f27_arg1:HasSpecialEffectId(TARGET_SELF, 3504007) then
            f27_arg2:ClearSubGoal()
            f27_arg2:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 20020, TARGET_ENE_0, 9999, 0, 0)
            return true
        elseif f27_arg1:HasSpecialEffectId(TARGET_SELF, 3504008) then
            f27_arg2:ClearSubGoal()
            f27_arg2:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 20023, TARGET_ENE_0, 9999, 0, 0)
            return true
        end
        return false
    end
    return false
    
end


