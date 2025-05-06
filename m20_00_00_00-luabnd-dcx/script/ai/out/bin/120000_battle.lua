RegisterTableGoal(GOAL_Sokushinbutsu_120000_Battle, "GOAL_Sokushinbutsu_120000_Battle")
REGISTER_GOAL_NO_UPDATE(GOAL_Sokushinbutsu_120000_Battle, true)

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
    local f2_local5 = f2_arg1:GetEventRequest()
    local f2_local6 = f2_arg1:GetDist_Point(POINT_INITIAL)
    f2_arg1:DeleteObserve(0)
    f2_arg1:DeleteObserveSpecialEffectAttribute(TARGET_SELF, 5026)
    f2_arg1:DeleteObserveSpecialEffectAttribute(TARGET_SELF, 5027)
    f2_arg1:AddObserveSpecialEffectAttribute(TARGET_SELF, 5025)
    f2_arg1:AddObserveSpecialEffectAttribute(TARGET_ENE_0, 109031)
    f2_arg1:AddObserveSpecialEffectAttribute(TARGET_ENE_0, 110125)
    f2_arg1:SetNumber(0, 0)
    if Common_ActivateAct(f2_arg1, f2_arg2, 0) then
    elseif f2_arg1:CheckDoesExistPath(TARGET_ENE_0, AI_DIR_TYPE_F, 0, 0) == false then
        f2_local0[26] = 100
    elseif f2_local4 == 1 and f2_arg1:GetTeamOrder(ORDER_TYPE_Role) == ROLE_TYPE_Kankyaku then
        f2_local0[26] = 100
    elseif f2_local4 == 1 and f2_arg1:GetTeamOrder(ORDER_TYPE_Role) == ROLE_TYPE_Torimaki then
        f2_local0[26] = 100
    elseif f2_arg1:IsInsideTarget(TARGET_ENE_0, AI_DIR_TYPE_B, 240) then
        if f2_local3 > 7 then
            f2_local0[21] = 100
        elseif f2_local3 > 5 then
            f2_local0[21] = 100
        else
            f2_local0[21] = 100
        end
    else
        f2_arg1:SetEventMoveTarget(2002660)
        if f2_local6 > 3.8 and f2_arg1:IsInsideTargetEx(TARGET_SELF, POINT_EVENT, AI_DIR_TYPE_B, 100, 10) then
            f2_local0[25] = 100
        elseif f2_local3 > 50 then
            f2_local0[25] = 100
        elseif f2_local3 > 5 then
            f2_local0[21] = 100
            f2_local0[26] = 100
        elseif f2_local3 >= 3 then
            f2_local0[1] = 100
            f2_local0[3] = 100
            f2_local0[13] = 80
        elseif f2_local3 >= 2 then
            f2_local0[1] = 50
            f2_local0[2] = 100
            f2_local0[3] = 80
            f2_local0[13] = 80
        else
            f2_local0[3] = 50
            f2_local0[7] = 80
        end
    end
    f2_local0[1] = SetCoolTime(f2_arg1, f2_arg2, 3000, 10, f2_local0[1], 1)
    f2_local0[2] = SetCoolTime(f2_arg1, f2_arg2, 3001, 8, f2_local0[2], 1)
    f2_local0[3] = SetCoolTime(f2_arg1, f2_arg2, 3002, 3, f2_local0[3], 1)
    f2_local0[4] = SetCoolTime(f2_arg1, f2_arg2, 3011, 8, f2_local0[4], 1)
    f2_local0[5] = SetCoolTime(f2_arg1, f2_arg2, 3012, 8, f2_local0[5], 1)
    f2_local0[7] = SetCoolTime(f2_arg1, f2_arg2, 3010, 8, f2_local0[7], 1)
    f2_local0[7] = SetCoolTime(f2_arg1, f2_arg2, 3014, 4, f2_local0[7], 1)
    f2_local0[13] = SetCoolTime(f2_arg1, f2_arg2, 3013, 8, f2_local0[13], 1)
    f2_local1[1] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act01)
    f2_local1[2] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act02)
    f2_local1[3] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act03)
    f2_local1[4] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act04)
    f2_local1[5] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act05)
    f2_local1[7] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act07)
    f2_local1[11] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act11)
    f2_local1[12] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act12)
    f2_local1[13] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act13)
    f2_local1[21] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act21)
    f2_local1[25] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act25)
    f2_local1[26] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act26)
    f2_local1[27] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act27)
    f2_local1[28] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act28)
    local f2_local7 = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.ActAfter_AdjustSpace)
    Common_Battle_Activate(f2_arg1, f2_arg2, f2_local0, f2_local1, f2_local7, f2_local2)
    
end

Goal.Act01 = function (f3_arg0, f3_arg1, f3_arg2)
    local f3_local0 = 8 - f3_arg0:GetMapHitRadius(TARGET_SELF)
    local f3_local1 = f3_arg0:GetRandam_Int(1, 100)
    local f3_local2 = 0
    local f3_local3 = 0
    local f3_local4 = 90
    local f3_local5 = 2
    f3_arg1:AddSubGoal(GOAL_COMMON_ComboAttackTunableSpin, 10, 3000, TARGET_ENE_0, f3_local0, f3_local2, f3_local3, 0, 0)
    if f3_local1 <= 50 then
        f3_arg1:AddSubGoal(GOAL_COMMON_ComboRepeat, 10, 3008, TARGET_ENE_0, f3_local0, 0)
    else
        f3_arg1:AddSubGoal(GOAL_COMMON_ComboRepeat, 10, 3009, TARGET_ENE_0, f3_local0, 0)
    end
    local f3_local6 = f3_arg0:GetRandam_Int(1, 100)
    if f3_local6 <= 50 then
        f3_arg1:AddSubGoal(GOAL_COMMON_ComboRepeat, 10, 3006, TARGET_ENE_0, f3_local0, 0)
    else
        f3_arg1:AddSubGoal(GOAL_COMMON_ComboRepeat, 10, 3007, TARGET_ENE_0, f3_local0, 0)
    end
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act02 = function (f4_arg0, f4_arg1, f4_arg2)
    local f4_local0 = 8 - f4_arg0:GetMapHitRadius(TARGET_SELF)
    local f4_local1 = f4_arg0:GetRandam_Int(1, 100)
    local f4_local2 = f4_arg0:GetRandam_Int(1, 100)
    local f4_local3 = 0
    local f4_local4 = 0
    local f4_local5 = 90
    local f4_local6 = 2
    f4_arg1:AddSubGoal(GOAL_COMMON_ComboAttackTunableSpin, 10, 3001, TARGET_ENE_0, f4_local0, f4_local3, f4_local4, 0, 0)
    if f4_local1 <= 50 then
        f4_arg1:AddSubGoal(GOAL_COMMON_ComboRepeat, 10, 3006, TARGET_ENE_0, f4_local0, 0)
    else
        f4_arg1:AddSubGoal(GOAL_COMMON_ComboRepeat, 10, 3007, TARGET_ENE_0, f4_local0, 0)
    end
    if f4_local2 <= 50 then
        f4_arg1:AddSubGoal(GOAL_COMMON_ComboRepeat, 10, 3008, TARGET_ENE_0, f4_local0, 0)
    else
        f4_arg1:AddSubGoal(GOAL_COMMON_ComboRepeat, 10, 3009, TARGET_ENE_0, f4_local0, 0)
    end
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act03 = function (f5_arg0, f5_arg1, f5_arg2)
    local f5_local0 = 3
    local f5_local1 = 3002
    local f5_local2 = 0
    local f5_local3 = 0
    local f5_local4 = f5_arg0:GetRandam_Int(1, 100)
    f5_arg1:AddSubGoal(GOAL_COMMON_ComboAttackTunableSpin, 10, f5_local1, TARGET_ENE_0, f5_local0, f5_local2, f5_local3, 0, 0)
    if f5_local4 <= 50 then
        f5_arg1:AddSubGoal(GOAL_COMMON_ComboRepeat, 10, 3006, TARGET_ENE_0, f5_local0, 0)
    else
        f5_arg1:AddSubGoal(GOAL_COMMON_ComboRepeat, 10, 3007, TARGET_ENE_0, f5_local0, 0)
    end
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act04 = function (f6_arg0, f6_arg1, f6_arg2)
    local f6_local0 = 3011
    local f6_local1 = 0
    local f6_local2 = 0
    local f6_local3 = f6_arg0:GetRandam_Int(1, 100)
    f6_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 10, f6_local0, TARGET_ENE_0, 9999, f6_local1, f6_local2, 0, 0)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act05 = function (f7_arg0, f7_arg1, f7_arg2)
    local f7_local0 = 3012
    local f7_local1 = 0
    local f7_local2 = 0
    local f7_local3 = f7_arg0:GetRandam_Int(1, 100)
    f7_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 10, f7_local0, TARGET_ENE_0, 9999, f7_local1, f7_local2, 0, 0)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act07 = function (f8_arg0, f8_arg1, f8_arg2)
    local f8_local0 = 3010
    local f8_local1 = 0
    local f8_local2 = 0
    local f8_local3 = f8_arg0:GetRandam_Int(1, 100)
    f8_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 10, f8_local0, TARGET_ENE_0, 9999, f8_local1, f8_local2, 0, 0)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act11 = function (f9_arg0, f9_arg1, f9_arg2)
    local f9_local0 = 3007
    local f9_local1 = 0
    local f9_local2 = 0
    local f9_local3 = f9_arg0:GetRandam_Int(1, 100)
    f9_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 10, f9_local0, TARGET_ENE_0, 9999, f9_local1, f9_local2, 0, 0)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act12 = function (f10_arg0, f10_arg1, f10_arg2)
    local f10_local0 = 3009
    local f10_local1 = 0
    local f10_local2 = 0
    local f10_local3 = f10_arg0:GetRandam_Int(1, 100)
    f10_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 10, f10_local0, TARGET_ENE_0, 9999, f10_local1, f10_local2, 0, 0)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act13 = function (f11_arg0, f11_arg1, f11_arg2)
    local f11_local0 = 3 - f11_arg0:GetMapHitRadius(TARGET_SELF)
    local f11_local1 = 0
    local f11_local2 = 0
    f11_arg1:AddSubGoal(GOAL_COMMON_ComboAttackTunableSpin, 10, 3013, TARGET_ENE_0, f11_local0, f11_local1, f11_local2, 0, 0)
    f11_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3014, TARGET_ENE_0, 9999, 0, 0)
    f11_arg0:AddObserveSpecialEffectAttribute(TARGET_SELF, 5027)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act21 = function (f12_arg0, f12_arg1, f12_arg2)
    local f12_local0 = 3
    local f12_local1 = 45
    f12_arg1:AddSubGoal(GOAL_COMMON_Turn, f12_local0, TARGET_ENE_0, f12_local1, -1, GOAL_RESULT_Success, true)
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
    
end

Goal.Act25 = function (f13_arg0, f13_arg1, f13_arg2)
    local f13_local0 = 45
    local f13_local1 = f13_arg0:GetDist(TARGET_ENE_0)
    local f13_local2 = f13_arg0:GetRandam_Int(1, 3)
    local f13_local3 = 0
    local f13_local4 = 5201
    local f13_local5 = f13_arg0:GetNumber(0)
    if f13_local1 < 25 then
        if f13_arg0:HasSpecialEffectId(TARGET_SELF, 5026) then
            f13_arg0:AddObserveSpecialEffectAttribute(TARGET_SELF, 5026)
            f13_arg1:AddSubGoal(GOAL_COMMON_Wait, 0.5, TARGET_SELF, 0, 0, 0)
            f13_arg0:SetNumber(0, f13_local5 + 1)
        end
        f13_arg1:AddSubGoal(GOAL_COMMON_SpinStep, f13_local2, f13_local4, POINT_EVENT, f13_local3, AI_DIR_TYPE_F, 0)
    else
        f13_arg1:AddSubGoal(GOAL_COMMON_MoveToSomewhere, 20, POINT_INITIAL, AI_DIR_TYPE_CENTER, 0, TARGET_SELF, false)
    end
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
    
end

Goal.Act26 = function (f14_arg0, f14_arg1, f14_arg2)
    f14_arg1:AddSubGoal(GOAL_COMMON_Wait, 0.5, TARGET_SELF, 0, 0, 0)
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
    
end

Goal.Interrupt = function (f15_arg0, f15_arg1, f15_arg2)
    local f15_local0 = f15_arg1:GetDist(TARGET_ENE_0)
    local f15_local1 = f15_arg1:GetSpecialEffectActivateInterruptType(0)
    if f15_arg1:IsLadderAct(TARGET_SELF) then
        return false
    end
    if not f15_arg1:HasSpecialEffectId(TARGET_SELF, 200004) then
        return false
    end
    if f15_arg1:IsInterupt(INTERUPT_ActivateSpecialEffect) then
        if f15_arg1:GetSpecialEffectActivateInterruptType(0) == 5027 then
            f15_arg1:AddObserveArea(0, TARGET_SELF, TARGET_ENE_0, AI_DIR_TYPE_F, 150, 2)
            return true
        elseif f15_arg1:GetSpecialEffectActivateInterruptType(0) == 5025 or f15_arg1:HasSpecialEffectId(TARGET_ENE_0, 110125) then
            f15_arg1:Replanning()
            return true
        end
    end
    if f15_arg1:IsInterupt(INTERUPT_InactivateSpecialEffect) then
        if f15_arg1:GetSpecialEffectInactivateInterruptType(0) == 5027 then
            f15_arg1:DeleteObserve(0)
            return true
        elseif f15_arg1:GetSpecialEffectInactivateInterruptType(0) == 5026 and f15_arg1:GetNumber(0) >= 1 then
            f15_arg1:SetNumber(0, 0)
            f15_arg2:ClearSubGoal()
            f15_arg2:AddSubGoal(GOAL_COMMON_EndureAttack, 10, 5201, POINT_EVENT, 9999, 0)
            return true
        end
    end
    if f15_arg1:IsInterupt(INTERUPT_Inside_ObserveArea) and f15_arg1:IsInsideObserve(0) then
        f15_arg1:DeleteObserve(0)
        f15_arg2:ClearSubGoal()
        f15_arg2:AddSubGoal(GOAL_COMMON_EndureAttack, 10, 3014, TARGET_ENE_0, 9999, 0)
        return true
    end
    return false
    
end

Goal.ActAfter_AdjustSpace = function (f16_arg0, f16_arg1, f16_arg2)
    
end

Goal.Update = function (f17_arg0, f17_arg1, f17_arg2)
    return Update_Default_NoSubGoal(f17_arg0, f17_arg1, f17_arg2)
    
end

Goal.Terminate = function (f18_arg0, f18_arg1, f18_arg2)
    
end


