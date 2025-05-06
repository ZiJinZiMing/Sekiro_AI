RegisterTableGoal(GOAL_Okinaryuu_Dummy_530010_Battle, "GOAL_Okinaryuu_Dummy_530010_Battle")
REGISTER_GOAL_NO_UPDATE(GOAL_Okinaryuu_Dummy_530010_Battle, true)

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
    local f2_local5 = f2_arg1:GetDist(TARGET_EVENT)
    local f2_local6 = f2_arg1:GetEventRequest()
    local f2_local7 = f2_arg1:IsEventFlag(12505855)
    if f2_local7 then
        if f2_local5 >= 15 then
            f2_local0[1] = 100
            f2_local0[2] = 0
            f2_local0[3] = 50
        elseif f2_local5 >= 3 then
            f2_local0[1] = 50
            f2_local0[2] = 50
            f2_local0[3] = 50
        else
            f2_local0[1] = 0
            f2_local0[2] = 100
        end
    else
        f2_local0[1] = 100
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
    f2_local1[1] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act01)
    f2_local1[2] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act02)
    f2_local1[3] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act03)
    f2_local1[21] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act21)
    f2_local1[22] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act22)
    f2_local1[23] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act23)
    f2_local1[24] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act24)
    f2_local1[25] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act25)
    f2_local1[26] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act26)
    f2_local1[27] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act27)
    f2_local1[28] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act28)
    local f2_local8 = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.ActAfter_AdjustSpace)
    Common_Battle_Activate(f2_arg1, f2_arg2, f2_local0, f2_local1, f2_local8, f2_local2)
    
end

Goal.Act01 = function (f3_arg0, f3_arg1, f3_arg2)
    local f3_local0 = 7
    local f3_local1 = 10
    local f3_local2 = 15
    local f3_local3 = 0
    local f3_local4 = 0
    local f3_local5 = f3_arg0:GetDist(TARGET_ENE_0)
    local f3_local6 = f3_arg0:GetRandam_Float(0.5, 3)
    local f3_local7 = f3_arg0:GetRandam_Float(2, 3)
    if f3_local5 >= 10 then
        f3_arg1:AddSubGoal(GOAL_COMMON_ApproachTarget, f3_local6, TARGET_ENE_0, 1, TARGET_SELF, true, -1)
    elseif f3_local5 >= 5 then
        f3_arg1:AddSubGoal(GOAL_COMMON_SidewayMove, f3_local6, TARGET_ENE_0, f3_arg0:GetRandam_Int(0, 1), 45, true, true, -1)
    else
        f3_arg1:AddSubGoal(GOAL_COMMON_LeaveTarget, f3_local6, TARGET_ENE_0, 10, TARGET_ENE_0, true, -1)
    end
    f3_arg1:AddSubGoal(GOAL_COMMON_Wait, f3_local7, TARGET_SELF, 0, 0, 0)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act02 = function (f4_arg0, f4_arg1, f4_arg2)
    local f4_local0 = 7
    local f4_local1 = 10
    local f4_local2 = 15
    local f4_local3 = 0
    local f4_local4 = 0
    local f4_local5 = f4_arg0:GetRandam_Float(2, 3)
    local f4_local6 = f4_arg0:GetDist(TARGET_ENE_0)
    local f4_local7 = f4_arg0:GetRandam_Float(0.5, 3)
    local f4_local8 = f4_arg0:GetDist(TARGET_EVENT)
    local f4_local9 = f4_arg0:GetDistAtoB(TARGET_EVENT, TARGET_ENE_0)
    if f4_arg0:IsInsideTargetEx(TARGET_SELF, TARGET_EVENT, AI_DIR_TYPE_R, 180, 999) then
        f4_arg1:AddSubGoal(GOAL_COMMON_SidewayMove, f4_local5, TARGET_ENE_0, 0, 45, true, true, -1)
    else
        f4_arg1:AddSubGoal(GOAL_COMMON_SidewayMove, f4_local5, TARGET_ENE_0, 1, 45, true, true, -1)
    end
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act03 = function (f5_arg0, f5_arg1, f5_arg2)
    local f5_local0 = 7
    local f5_local1 = 10
    local f5_local2 = 15
    local f5_local3 = 0
    local f5_local4 = 0
    local f5_local5 = f5_arg0:GetRandam_Float(2, 3)
    local f5_local6 = f5_arg0:GetDist(TARGET_ENE_0)
    local f5_local7 = f5_arg0:GetRandam_Float(0.5, 3)
    local f5_local8 = f5_arg0:GetDist(TARGET_EVENT)
    local f5_local9 = f5_arg0:GetDistAtoB(TARGET_EVENT, TARGET_ENE_0)
    if f5_arg0:IsInsideTargetEx(TARGET_SELF, TARGET_EVENT, AI_DIR_TYPE_R, 180, 999) then
        f5_arg1:AddSubGoal(GOAL_COMMON_SidewayMove, f5_local5, TARGET_EVENT, 0, 45, true, true, -1)
    else
        f5_arg1:AddSubGoal(GOAL_COMMON_SidewayMove, f5_local5, TARGET_EVENT, 1, 45, true, true, -1)
    end
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act21 = function (f6_arg0, f6_arg1, f6_arg2)
    local f6_local0 = 3
    local f6_local1 = 45
    f6_arg1:AddSubGoal(GOAL_COMMON_Turn, f6_local0, TARGET_ENE_0, f6_local1, -1, GOAL_RESULT_Success, true)
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
    
end

Goal.Act22 = function (f7_arg0, f7_arg1, f7_arg2)
    local f7_local0 = 3
    local f7_local1 = 0
    local f7_local2 = 5202
    if SpaceCheck(f7_arg0, f7_arg1, -45, 2) == true then
        if SpaceCheck(f7_arg0, f7_arg1, 45, 2) == true then
            if f7_arg0:IsInsideTarget(TARGET_ENE_0, AI_DIR_TYPE_R, 180) then
                f7_local2 = 5202
            else
                f7_local2 = 5203
            end
        else
            f7_local2 = 5202
        end
    elseif SpaceCheck(f7_arg0, f7_arg1, 45, 2) == true then
        f7_local2 = 5203
    else
    end
    f7_arg1:AddSubGoal(GOAL_COMMON_SpinStep, f7_local0, f7_local2, TARGET_ENE_0, f7_local1, AI_DIR_TYPE_R, 0)
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
    
end

Goal.Act23 = function (f8_arg0, f8_arg1, f8_arg2)
    local f8_local0 = f8_arg0:GetDist(TARGET_ENE_0)
    local f8_local1 = f8_arg0:GetRandam_Int(1, 100)
    local f8_local2 = -1
    local f8_local3 = 0
    if SpaceCheck(f8_arg0, f8_arg1, -90, 1) == true then
        if SpaceCheck(f8_arg0, f8_arg1, 90, 1) == true then
            if f8_arg0:IsInsideTargetEx(TARGET_ENE_0, TARGET_SELF, AI_DIR_TYPE_R, 180, 999) then
                f8_local3 = 1
            else
                f8_local3 = 0
            end
        else
            f8_local3 = 0
        end
    elseif SpaceCheck(f8_arg0, f8_arg1, 90, 1) == true then
        f8_local3 = 1
    else
    end
    local f8_local4 = 3
    local f8_local5 = f8_arg0:GetRandam_Int(30, 45)
    f8_arg0:SetNumber(10, f8_local3)
    f8_arg1:AddSubGoal(GOAL_COMMON_SidewayMove, f8_local4, TARGET_ENE_0, f8_local3, f8_local5, true, true, f8_local2)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act24 = function (f9_arg0, f9_arg1, f9_arg2)
    local f9_local0 = f9_arg0:GetDist(TARGET_ENE_0)
    local f9_local1 = 3
    local f9_local2 = 0
    local f9_local3 = 5201
    if SpaceCheck(f9_arg0, f9_arg1, 180, 2) ~= true or SpaceCheck(f9_arg0, f9_arg1, 180, 4) ~= true or f9_local0 > 4 then
    else
        f9_local3 = 5211
        if false then
        else
        end
    end
    f9_arg1:AddSubGoal(GOAL_COMMON_SpinStep, f9_local1, f9_local3, TARGET_ENE_0, f9_local2, AI_DIR_TYPE_B, 0)
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

Goal.Act27 = function (f12_arg0, f12_arg1, f12_arg2)
    local f12_local0 = f12_arg0:GetDist(TARGET_ENE_0)
    local f12_local1 = f12_arg0:GetDistYSigned(TARGET_ENE_0)
    local f12_local2 = f12_local1 / math.tan(math.deg(30))
    local f12_local3 = f12_arg0:GetRandam_Int(0, 1)
    if f12_local1 >= 3 then
        if f12_local2 + 1 <= f12_local0 then
            if SpaceCheck(f12_arg0, f12_arg1, 0, 4) == true then
                f12_arg1:AddSubGoal(GOAL_COMMON_ApproachTarget, 0.1, TARGET_ENE_0, f12_local2, TARGET_SELF, false, -1)
            elseif SpaceCheck(f12_arg0, f12_arg1, 0, 3) == true then
                f12_arg1:AddSubGoal(GOAL_COMMON_ApproachTarget, 0.5, TARGET_ENE_0, f12_local2, TARGET_SELF, true, -1)
            end
        elseif f12_local0 <= f12_local2 - 1 then
            f12_arg1:AddSubGoal(GOAL_COMMON_LeaveTarget, 10, TARGET_ENE_0, f12_local2, TARGET_ENE_0, true, -1)
        else
            f12_arg1:AddSubGoal(GOAL_COMMON_SidewayMove, 3, TARGET_ENE_0, f12_local3, f12_arg0:GetRandam_Int(30, 45), true, true, -1)
            f12_arg0:SetNumber(10, f12_local3)
        end
    elseif SpaceCheck(f12_arg0, f12_arg1, 0, 4) == true then
        f12_arg1:AddSubGoal(GOAL_COMMON_ApproachTarget, 0.1, TARGET_ENE_0, 0, TARGET_SELF, false, -1)
    elseif SpaceCheck(f12_arg0, f12_arg1, 0, 3) == true then
        f12_arg1:AddSubGoal(GOAL_COMMON_ApproachTarget, 0.5, TARGET_ENE_0, 0, TARGET_SELF, true, -1)
    elseif SpaceCheck(f12_arg0, f12_arg1, 0, 1) == false then
        f12_arg1:AddSubGoal(GOAL_COMMON_LeaveTarget, 0.5, TARGET_ENE_0, 999, TARGET_ENE_0, true, -1)
    else
        f12_arg1:AddSubGoal(GOAL_COMMON_SidewayMove, 3, TARGET_ENE_0, f12_local3, f12_arg0:GetRandam_Int(30, 45), true, true, -1)
        f12_arg0:SetNumber(10, f12_local3)
    end
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
    
end

Goal.Act28 = function (f13_arg0, f13_arg1, f13_arg2)
    local f13_local0 = f13_arg0:GetDist(TARGET_ENE_0)
    local f13_local1 = 1.5
    local f13_local2 = 1.5
    local f13_local3 = 1.5
    local f13_local4 = f13_arg0:GetRandam_Int(30, 45)
    local f13_local5 = -1
    local f13_local6 = f13_arg0:GetRandam_Int(0, 1)
    if f13_local0 <= 5 then
        f13_arg1:AddSubGoal(GOAL_COMMON_LeaveTarget, f13_local3, TARGET_ENE_0, 6, true, f13_local5)
    elseif f13_local0 <= 10 then
        f13_arg1:AddSubGoal(GOAL_COMMON_ApproachTarget, f13_local2, TARGET_ENE_0, 5, TARGET_SELF, true, -1)
    else
        f13_arg1:AddSubGoal(GOAL_COMMON_ApproachTarget, f13_local2, TARGET_ENE_0, 10, TARGET_SELF, true, -1)
    end
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
    
end

Goal.Interrupt = function (f14_arg0, f14_arg1, f14_arg2)
    local f14_local0 = f14_arg1:GetSpecialEffectActivateInterruptType(0)
    if f14_arg1:IsLadderAct(TARGET_SELF) then
        return false
    end
    if not f14_arg1:HasSpecialEffectId(TARGET_SELF, 200004) then
        return false
    end
    if f14_arg1:IsInterupt(INTERUPT_ParryTiming) then
        return f14_arg0.Parry(f14_arg1, f14_arg2)
    end
    if f14_arg1:IsInterupt(INTERUPT_Damaged) then
        return f14_arg0.Damaged(f14_arg1, f14_arg2)
    end
    return false
    
end

Goal.Parry = function (f15_arg0, f15_arg1, f15_arg2)
    local f15_local0 = f15_arg0:GetHpRate(TARGET_SELF)
    local f15_local1 = f15_arg0:GetDist(TARGET_ENE_0)
    local f15_local2 = f15_arg0:GetSp(TARGET_SELF)
    local f15_local3 = f15_arg0:GetRandam_Int(1, 100)
    local f15_local4 = 0
    if not f15_arg0:IsInsideTarget(TARGET_ENE_0, AI_DIR_TYPE_F, 90) or not f15_arg0:IsInsideTargetEx(TARGET_ENE_0, TARGET_SELF, AI_DIR_TYPE_F, 90, 3) or f15_arg0:HasSpecialEffectId(TARGET_ENE_0, 109012) then
    elseif f15_arg0:IsTargetGuard(TARGET_SELF) then
        if f15_arg0:HasSpecialEffectId(TARGET_ENE_0, 109970) then
        else
            f15_arg1:ClearSubGoal()
            f15_arg1:AddSubGoal(GOAL_COMMON_EndureAttack, 0.1, 3100, TARGET_ENE_0, 9999, 0)
            return true
        end
    elseif f15_arg0:HasSpecialEffectId(TARGET_ENE_0, 109970) then
        f15_arg1:ClearSubGoal()
        f15_arg1:AddSubGoal(GOAL_COMMON_EndureAttack, 0.1, 3101, TARGET_ENE_0, 9999, 0)
        return true
    else
        f15_arg1:ClearSubGoal()
        f15_arg1:AddSubGoal(GOAL_COMMON_EndureAttack, 0.1, 3100, TARGET_ENE_0, 9999, 0)
        return true
    end
    return false
    
end

Goal.Damaged = function (f16_arg0, f16_arg1, f16_arg2)
    local f16_local0 = 3
    if SpaceCheck(f16_arg0, f16_arg1, 180, 2) == false then
        f16_arg1:ClearSubGoal()
        f16_arg1:AddSubGoal(GOAL_COMMON_SpinStep, f16_local0, 5201, TARGET_ENE_0, 0, AI_DIR_TYPE_B, 0)
        return true
    end
    return false
    
end

Goal.ActAfter_AdjustSpace = function (f17_arg0, f17_arg1, f17_arg2)
    
end

Goal.Update = function (f18_arg0, f18_arg1, f18_arg2)
    return Update_Default_NoSubGoal(f18_arg0, f18_arg1, f18_arg2)
    
end

Goal.Terminate = function (f19_arg0, f19_arg1, f19_arg2)
    
end


