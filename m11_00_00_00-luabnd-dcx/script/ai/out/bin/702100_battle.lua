RegisterTableGoal(GOAL_Kibutu_702100_Battle, "GOAL_Kibutu_702100_Battle")
REGISTER_GOAL_NO_UPDATE(GOAL_Kibutu_702100_Battle, true)

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
    f2_arg1:AddObserveSpecialEffectAttribute(TARGET_SELF, 5028)
    f2_arg1:AddObserveSpecialEffectAttribute(TARGET_SELF, 5030)
    f2_arg1:AddObserveSpecialEffectAttribute(TARGET_SELF, 3702111)
    f2_arg1:AddObserveSpecialEffectAttribute(TARGET_SELF, 3702112)
    f2_arg1:AddObserveSpecialEffectAttribute(TARGET_SELF, 3702113)
    f2_arg1:AddObserveSpecialEffectAttribute(TARGET_SELF, 3702114)
    f2_arg1:AddObserveSpecialEffectAttribute(TARGET_SELF, 3702115)
    f2_arg1:AddObserveSpecialEffectAttribute(TARGET_SELF, 3702116)
    f2_arg1:AddObserveSpecialEffectAttribute(TARGET_SELF, 3702117)
    f2_arg1:AddObserveSpecialEffectAttribute(TARGET_SELF, 3702118)
    f2_arg1:AddObserveSpecialEffectAttribute(TARGET_SELF, 3702119)
    f2_arg1:AddObserveSpecialEffectAttribute(TARGET_SELF, 3702120)
    if f2_arg1:HasSpecialEffectId(TARGET_SELF, 5028) then
        f2_local0[26] = 100
    else
        f2_local0[26] = 100
    end
    f2_local1[1] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act01)
    f2_local1[2] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act02)
    f2_local1[3] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act03)
    f2_local1[4] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act04)
    f2_local1[5] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act05)
    f2_local1[21] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act21)
    f2_local1[23] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act23)
    f2_local1[25] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act25)
    f2_local1[26] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act26)
    local f2_local5 = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.ActAfter_AdjustSpace)
    Common_Battle_Activate(f2_arg1, f2_arg2, f2_local0, f2_local1, f2_local5, f2_local2)
    
end

Goal.Act01 = function (f3_arg0, f3_arg1, f3_arg2)
    f3_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 10, 20010, TARGET_ENE_0, 9999, 0, 0, 0, 0)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act02 = function (f4_arg0, f4_arg1, f4_arg2)
    local f4_local0 = 5
    local f4_local1 = 5 + 1000
    local f4_local2 = 5 + 0
    local f4_local3 = 0
    local f4_local4 = 0
    local f4_local5 = 1.5
    local f4_local6 = 3
    if f4_arg0:HasSpecialEffectId(TARGET_SELF, 3702111) then
        f4_arg1:AddSubGoal(GOAL_COMMON_ApproachTarget, 0.5, TARGET_ENE_0, 0, TARGET_SELF, true, -1)
    else
        f4_arg1:AddSubGoal(GOAL_COMMON_Wait, 0.5, TARGET_SELF, 0, 0, 0)
    end
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act03 = function (f5_arg0, f5_arg1, f5_arg2)
    f5_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 10, 20010, TARGET_ENE_0, 9999, 0, 0, 0, 0)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act04 = function (f6_arg0, f6_arg1, f6_arg2)
    f6_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 10, 3003, TARGET_ENE_0, 9999, 0, 0, 0, 0)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act05 = function (f7_arg0, f7_arg1, f7_arg2)
    f7_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 10, 3003, TARGET_ENE_0, 9999, 0, 0, 0, 0)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act21 = function (f8_arg0, f8_arg1, f8_arg2)
    local f8_local0 = 3
    local f8_local1 = 45
    f8_arg1:AddSubGoal(GOAL_COMMON_Turn, f8_local0, TARGET_ENE_0, f8_local1, -1, GOAL_RESULT_Success, true)
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
    
end

Goal.Act23 = function (f9_arg0, f9_arg1, f9_arg2)
    local f9_local0 = f9_arg0:GetDist(TARGET_ENE_0)
    local f9_local1 = f9_arg0:GetSp(TARGET_SELF)
    local f9_local2 = 20
    local f9_local3 = f9_arg0:GetRandam_Int(1, 100)
    local f9_local4 = -1
    if f9_local2 <= f9_local1 and f9_local3 <= 50 then
        f9_local4 = 9910
    end
    local f9_local5 = 0
    if SpaceCheck(f9_arg0, f9_arg1, -90, 1) == true then
        if SpaceCheck(f9_arg0, f9_arg1, 90, 1) == true then
            if f9_arg0:IsInsideTargetEx(TARGET_ENE_0, TARGET_SELF, AI_DIR_TYPE_R, 180, 999) then
                f9_local5 = 1
            else
                f9_local5 = 0
            end
        else
            f9_local5 = 0
        end
    elseif SpaceCheck(f9_arg0, f9_arg1, 90, 1) == true then
        f9_local5 = 1
    else
    end
    local f9_local6 = 3
    local f9_local7 = f9_arg0:GetRandam_Int(30, 45)
    f9_arg0:SetNumber(10, f9_local5)
    f9_arg1:AddSubGoal(GOAL_COMMON_SidewayMove, f9_local6, TARGET_ENE_0, f9_local5, f9_local7, true, true, f9_local4)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act25 = function (f10_arg0, f10_arg1, f10_arg2)
    local f10_local0 = f10_arg0:GetRandam_Float(2, 4)
    local f10_local1 = f10_arg0:GetRandam_Float(5, 7)
    local f10_local2 = f10_arg0:GetDist(TARGET_ENE_0)
    local f10_local3 = -1
    f10_arg1:AddSubGoal(GOAL_COMMON_LeaveTarget, f10_local0, TARGET_ENE_0, f10_local1, TARGET_ENE_0, true, f10_local3)
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
    
end

Goal.Act26 = function (f11_arg0, f11_arg1, f11_arg2)
    f11_arg1:AddSubGoal(GOAL_COMMON_Wait, 0.5, TARGET_SELF, 0, 0, 0)
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
    
end

Goal.Interrupt = function (f12_arg0, f12_arg1, f12_arg2)
    local f12_local0 = f12_arg1:GetSpecialEffectActivateInterruptType(0)
    if f12_arg1:IsLadderAct(TARGET_SELF) then
        return false
    end
    if f12_arg1:IsInterupt(INTERUPT_Damaged) then
        return f12_arg0.Damaged(f12_arg1, f12_arg2)
    end
    if f12_arg1:IsInterupt(INTERUPT_ActivateSpecialEffect) and f12_local0 == 5030 then
        f12_arg2:ClearSubGoal()
        f12_arg2:AddSubGoal(GOAL_COMMON_EndureAttack, 0.5, 20010, TARGET_ENE_0, 9999, 0)
        return true
    end
    return false
    
end

Goal.Damaged = function (f13_arg0, f13_arg1, f13_arg2)
    local f13_local0 = 3
    return false
    
end

Goal.NoAction = function (f14_arg0, f14_arg1, f14_arg2)
    f14_arg0:Replanning()
    
end

Goal.ActAfter_AdjustSpace = function (f15_arg0, f15_arg1, f15_arg2)
    
end

Goal.Update = function (f16_arg0, f16_arg1, f16_arg2)
    return Update_Default_NoSubGoal(f16_arg0, f16_arg1, f16_arg2)
    
end

Goal.Terminate = function (f17_arg0, f17_arg1, f17_arg2)
    
end


