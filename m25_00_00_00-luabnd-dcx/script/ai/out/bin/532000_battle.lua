RegisterTableGoal(GOAL_Okinaryuu_big_532000_Battle, "GOAL_Okinaryuu_big_532000_Battle")
REGISTER_GOAL_NO_UPDATE(GOAL_Okinaryuu_big_532000_Battle, true)

Goal.Initialize = function (f1_arg0, f1_arg1, f1_arg2, f1_arg3)
    
end

Goal.Activate = function (f2_arg0, f2_arg1, f2_arg2)
    Init_Pseudo_Global(f2_arg1, f2_arg2)
    local f2_local0 = {}
    local f2_local1 = {}
    local f2_local2 = {}
    Common_Clear_Param(f2_local0, f2_local1, f2_local2)
    local f2_local3 = f2_arg1:GetDist(TARGET_ENE_0)
    local f2_local4 = f2_arg1:GetDistYSigned(TARGET_ENE_0)
    local f2_local5 = f2_arg1:GetExcelParam(AI_EXCEL_THINK_PARAM_TYPE__thinkAttr_doAdmirer)
    local f2_local6 = f2_arg1:GetSpRate(TARGET_SELF)
    local f2_local7 = f2_arg1:GetEventRequest()
    if f2_arg1:IsEventFlag(19959972) == true then
        f2_local0[10] = 100
    elseif f2_arg1:IsEventFlag(19959970) == true then
        f2_local0[2] = 100
    elseif f2_arg1:HasSpecialEffectId(TARGET_ENE_0, 110060) then
        if f2_arg1:IsInsideTarget(TARGET_ENE_0, AI_DIR_TYPE_F, 90) then
            f2_local0[26] = 100
        else
            f2_local0[21] = 100
        end
    elseif f2_arg1:HasSpecialEffectId(TARGET_ENE_0, 110030) then
        f2_local0[23] = 100
        f2_local0[25] = 100
    elseif f2_local4 >= 3 then
        f2_local0[27] = 100
    elseif f2_arg1:IsInsideTarget(TARGET_ENE_0, AI_DIR_TYPE_B, 180) then
        f2_local0[21] = 100
        f2_local0[22] = 1
    elseif f2_local3 >= 5 then
        f2_local0[1] = 100
        f2_local0[5] = 100
        f2_local0[6] = 100
        f2_local0[7] = 100
        f2_local0[23] = 50
    elseif f2_local3 >= 3 then
        f2_local0[1] = 100
        f2_local0[3] = 100
        f2_local0[5] = 100
        f2_local0[6] = 100
        f2_local0[7] = 100
        f2_local0[25] = 50
    else
        f2_local0[1] = 100
        f2_local0[6] = 100
        f2_local0[25] = 100
    end
    f2_local0[1] = SetCoolTime(f2_arg1, f2_arg2, 3000, 10, f2_local0[1], 1)
    f2_local0[3] = SetCoolTime(f2_arg1, f2_arg2, 3002, 10, f2_local0[3], 1)
    f2_local0[4] = SetCoolTime(f2_arg1, f2_arg2, 3003, 25, f2_local0[4], 1)
    f2_local0[5] = SetCoolTime(f2_arg1, f2_arg2, 3004, 5, f2_local0[5], 1)
    f2_local0[6] = SetCoolTime(f2_arg1, f2_arg2, 3005, 4, f2_local0[6], 1)
    f2_local0[7] = SetCoolTime(f2_arg1, f2_arg2, 3007, 8, f2_local0[7], 1)
    f2_local1[1] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act01)
    f2_local1[2] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act02)
    f2_local1[3] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act03)
    f2_local1[4] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act04)
    f2_local1[5] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act05)
    f2_local1[6] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act06)
    f2_local1[7] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act07)
    f2_local1[10] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act10)
    f2_local1[20] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act20)
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
    local f3_local0 = 3 - f3_arg0:GetMapHitRadius(TARGET_SELF)
    local f3_local1 = 3 - f3_arg0:GetMapHitRadius(TARGET_SELF) + 0
    local f3_local2 = 3 - f3_arg0:GetMapHitRadius(TARGET_SELF) + 999
    local f3_local3 = 0
    local f3_local4 = 0
    local f3_local5 = 1.5
    local f3_local6 = 4
    Approach_Act_Flex(f3_arg0, f3_arg1, f3_local0, f3_local1, f3_local2, f3_local3, f3_local4, f3_local5, f3_local6)
    local f3_local7 = 0
    local f3_local8 = 0
    f3_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 10, 3000, TARGET_ENE_0, 9999, f3_local7, f3_local8, 0, 0)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act02 = function (f4_arg0, f4_arg1, f4_arg2)
    local f4_local0 = 0
    local f4_local1 = 0
    f4_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 10, 3001, TARGET_ENE_0, 9999, f4_local0, f4_local1, 0, 0)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act03 = function (f5_arg0, f5_arg1, f5_arg2)
    local f5_local0 = 5 - f5_arg0:GetMapHitRadius(TARGET_SELF)
    local f5_local1 = 5 - f5_arg0:GetMapHitRadius(TARGET_SELF) + 0
    local f5_local2 = 5 - f5_arg0:GetMapHitRadius(TARGET_SELF) + 999
    local f5_local3 = 0
    local f5_local4 = 0
    local f5_local5 = 1.5
    local f5_local6 = 4
    Approach_Act_Flex(f5_arg0, f5_arg1, f5_local0, f5_local1, f5_local2, f5_local3, f5_local4, f5_local5, f5_local6)
    local f5_local7 = 0
    local f5_local8 = 0
    f5_arg1:AddSubGoal(GOAL_COMMON_ComboAttackTunableSpin, 10, 3002, TARGET_ENE_0, 9999, f5_local7, f5_local8, 0, 0)
    f5_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3006, TARGET_ENE_0, 9999, 0)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act04 = function (f6_arg0, f6_arg1, f6_arg2)
    local f6_local0 = 0
    local f6_local1 = 0
    f6_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 10, 3003, TARGET_ENE_0, 9999, f6_local0, f6_local1, 0, 0)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act05 = function (f7_arg0, f7_arg1, f7_arg2)
    local f7_local0 = f7_arg0:GetRandam_Int(1, 100)
    local f7_local1 = 0
    local f7_local2 = 0
    f7_arg1:AddSubGoal(GOAL_COMMON_ComboAttackTunableSpin, 10, 3004, TARGET_ENE_0, 9999, f7_local1, f7_local2, 0, 0)
    if f7_local0 <= 50 then
        f7_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3008, TARGET_ENE_0, 9999, 0)
    end
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act06 = function (f8_arg0, f8_arg1, f8_arg2)
    local f8_local0 = 0
    local f8_local1 = 0
    f8_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 10, 3005, TARGET_ENE_0, 9999, f8_local0, f8_local1, 0, 0)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act07 = function (f9_arg0, f9_arg1, f9_arg2)
    local f9_local0 = 8 - f9_arg0:GetMapHitRadius(TARGET_SELF)
    local f9_local1 = 8 - f9_arg0:GetMapHitRadius(TARGET_SELF) + 0
    local f9_local2 = 8 - f9_arg0:GetMapHitRadius(TARGET_SELF) + 999
    local f9_local3 = 0
    local f9_local4 = 0
    local f9_local5 = 1.5
    local f9_local6 = 4
    Approach_Act_Flex(f9_arg0, f9_arg1, f9_local0, f9_local1, f9_local2, f9_local3, f9_local4, f9_local5, f9_local6)
    local f9_local7 = 0
    local f9_local8 = 0
    f9_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 10, 3007, TARGET_ENE_0, 9999, f9_local7, f9_local8, 0, 0)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act10 = function (f10_arg0, f10_arg1, f10_arg2)
    local f10_local0 = 0
    local f10_local1 = 180
    f10_arg1:AddSubGoal(GOAL_COMMON_ComboTunable_SuccessAngle180, 10, 3010, TARGET_ENE_0, 999, f10_local0, f10_local1, 0, 0)
    f10_arg1:AddSubGoal(GOAL_COMMON_ComboRepeat_SuccessAngle180, 10, 3011, TARGET_ENE_0, 999, 0, 0)
    f10_arg1:AddSubGoal(GOAL_COMMON_ComboRepeat_SuccessAngle180, 10, 3011, TARGET_ENE_0, 999, 0, 0)
    f10_arg1:AddSubGoal(GOAL_COMMON_ComboRepeat_SuccessAngle180, 10, 3011, TARGET_ENE_0, 999, 0, 0)
    f10_arg1:AddSubGoal(GOAL_COMMON_ComboRepeat_SuccessAngle180, 10, 3011, TARGET_ENE_0, 999, 0, 0)
    f10_arg1:AddSubGoal(GOAL_COMMON_ComboRepeat_SuccessAngle180, 10, 3011, TARGET_ENE_0, 999, 0, 0)
    f10_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3012, TARGET_ENE_0, 999, 0, 0)
    f10_arg0:SetNumber(0, 0)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act20 = function (f11_arg0, f11_arg1, f11_arg2)
    local f11_local0 = 7
    local f11_local1 = 10
    local f11_local2 = 15
    local f11_local3 = 0
    local f11_local4 = 0
    local f11_local5 = 1.5
    local f11_local6 = 2
    local f11_local7 = AI_DIR_TYPE_ToF
    f11_arg1:AddSubGoal(GOAL_COMMON_ApproachTarget, 10, TARGET_ENE_0, 6, TARGET_SELF, true, -1)
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

Goal.Act22 = function (f13_arg0, f13_arg1, f13_arg2)
    local f13_local0 = 3
    local f13_local1 = 0
    local f13_local2 = 5202
    if SpaceCheck(f13_arg0, f13_arg1, -45, 2) == true then
        if SpaceCheck(f13_arg0, f13_arg1, 45, 2) == true then
            if f13_arg0:IsInsideTarget(TARGET_ENE_0, AI_DIR_TYPE_R, 180) then
                f13_local2 = 5202
            else
                f13_local2 = 5203
            end
        else
            f13_local2 = 5202
        end
    elseif SpaceCheck(f13_arg0, f13_arg1, 45, 2) == true then
        f13_local2 = 5203
    else
    end
    f13_arg1:AddSubGoal(GOAL_COMMON_SpinStep, f13_local0, f13_local2, TARGET_ENE_0, f13_local1, AI_DIR_TYPE_R, 0)
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
    
end

Goal.Act23 = function (f14_arg0, f14_arg1, f14_arg2)
    local f14_local0 = f14_arg0:GetDist(TARGET_ENE_0)
    local f14_local1 = f14_arg0:GetRandam_Int(1, 100)
    local f14_local2 = -1
    local f14_local3 = 0
    if SpaceCheck(f14_arg0, f14_arg1, -90, 1) == true then
        if SpaceCheck(f14_arg0, f14_arg1, 90, 1) == true then
            if f14_arg0:IsInsideTargetEx(TARGET_ENE_0, TARGET_SELF, AI_DIR_TYPE_R, 180, 999) then
                f14_local3 = 1
            else
                f14_local3 = 0
            end
        else
            f14_local3 = 0
        end
    elseif SpaceCheck(f14_arg0, f14_arg1, 90, 1) == true then
        f14_local3 = 1
    else
    end
    local f14_local4 = 3
    local f14_local5 = f14_arg0:GetRandam_Int(30, 45)
    f14_arg0:SetNumber(10, f14_local3)
    f14_arg1:AddSubGoal(GOAL_COMMON_SidewayMove, f14_local4, TARGET_ENE_0, f14_local3, f14_local5, true, true, f14_local2)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act24 = function (f15_arg0, f15_arg1, f15_arg2)
    local f15_local0 = f15_arg0:GetDist(TARGET_ENE_0)
    local f15_local1 = 3
    local f15_local2 = 0
    local f15_local3 = 5201
    if SpaceCheck(f15_arg0, f15_arg1, 180, 2) ~= true or SpaceCheck(f15_arg0, f15_arg1, 180, 4) ~= true or f15_local0 > 4 then
    else
        f15_local3 = 5211
        if false then
        else
        end
    end
    f15_arg1:AddSubGoal(GOAL_COMMON_SpinStep, f15_local1, f15_local3, TARGET_ENE_0, f15_local2, AI_DIR_TYPE_B, 0)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act25 = function (f16_arg0, f16_arg1, f16_arg2)
    local f16_local0 = f16_arg0:GetRandam_Float(2, 4)
    local f16_local1 = f16_arg0:GetRandam_Float(5, 7)
    local f16_local2 = f16_arg0:GetDist(TARGET_ENE_0)
    local f16_local3 = -1
    f16_arg1:AddSubGoal(GOAL_COMMON_LeaveTarget, f16_local0, TARGET_ENE_0, f16_local1, TARGET_ENE_0, true, f16_local3)
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
    
end

Goal.Act26 = function (f17_arg0, f17_arg1, f17_arg2)
    f17_arg1:AddSubGoal(GOAL_COMMON_Wait, 0.5, TARGET_SELF, 0, 0, 0)
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
    
end

Goal.Act27 = function (f18_arg0, f18_arg1, f18_arg2)
    local f18_local0 = f18_arg0:GetDist(TARGET_ENE_0)
    local f18_local1 = f18_arg0:GetDistYSigned(TARGET_ENE_0)
    local f18_local2 = f18_local1 / math.tan(math.deg(30))
    local f18_local3 = f18_arg0:GetRandam_Int(0, 1)
    if f18_local1 >= 3 then
        if f18_local2 + 1 <= f18_local0 then
            f18_arg1:AddSubGoal(GOAL_COMMON_ApproachTarget, 3, TARGET_ENE_0, f18_local2, TARGET_SELF, true, -1)
        elseif f18_local0 <= f18_local2 - 1 then
            f18_arg1:AddSubGoal(GOAL_COMMON_LeaveTarget, 3, TARGET_ENE_0, f18_local2, TARGET_ENE_0, true, -1)
        else
            f18_arg1:AddSubGoal(GOAL_COMMON_SidewayMove, 3, TARGET_ENE_0, f18_local3, f18_arg0:GetRandam_Int(30, 45), true, true, -1)
            f18_arg0:SetNumber(10, f18_local3)
        end
    elseif SpaceCheck(f18_arg0, f18_arg1, 0, 4) == true then
        f18_arg1:AddSubGoal(GOAL_COMMON_ApproachTarget, 0.1, TARGET_ENE_0, 0, TARGET_SELF, false, -1)
    elseif SpaceCheck(f18_arg0, f18_arg1, 0, 3) == true then
        f18_arg1:AddSubGoal(GOAL_COMMON_ApproachTarget, 0.5, TARGET_ENE_0, 0, TARGET_SELF, true, -1)
    elseif SpaceCheck(f18_arg0, f18_arg1, 0, 1) == false then
        f18_arg1:AddSubGoal(GOAL_COMMON_LeaveTarget, 0.5, TARGET_ENE_0, 999, TARGET_ENE_0, true, -1)
    else
        f18_arg1:AddSubGoal(GOAL_COMMON_SidewayMove, 3, TARGET_ENE_0, f18_local3, f18_arg0:GetRandam_Int(30, 45), true, true, -1)
        f18_arg0:SetNumber(10, f18_local3)
    end
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
    
end

Goal.Act28 = function (f19_arg0, f19_arg1, f19_arg2)
    local f19_local0 = f19_arg0:GetDist(TARGET_ENE_0)
    local f19_local1 = 1.5
    local f19_local2 = 1.5
    local f19_local3 = 1.5
    local f19_local4 = f19_arg0:GetRandam_Int(30, 45)
    local f19_local5 = -1
    local f19_local6 = f19_arg0:GetRandam_Int(0, 1)
    if f19_local0 <= 5 then
        f19_arg1:AddSubGoal(GOAL_COMMON_LeaveTarget, f19_local3, TARGET_ENE_0, 6, true, f19_local5)
    elseif f19_local0 <= 10 then
        f19_arg1:AddSubGoal(GOAL_COMMON_ApproachTarget, f19_local2, TARGET_ENE_0, 5, TARGET_SELF, true, -1)
    else
        f19_arg1:AddSubGoal(GOAL_COMMON_ApproachTarget, f19_local2, TARGET_ENE_0, 10, TARGET_SELF, true, -1)
    end
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
    
end

Goal.Interrupt = function (f20_arg0, f20_arg1, f20_arg2)
    local f20_local0 = f20_arg1:GetSpecialEffectActivateInterruptType(0)
    if f20_arg1:IsLadderAct(TARGET_SELF) then
        return false
    end
    if not f20_arg1:HasSpecialEffectId(TARGET_SELF, 200004) then
        return false
    end
    if f20_arg1:IsInterupt(INTERUPT_ParryTiming) then
        return f20_arg0.Parry(f20_arg1, f20_arg2)
    end
    if f20_arg1:IsInterupt(INTERUPT_Damaged) then
        return f20_arg0.Damaged(f20_arg1, f20_arg2)
    end
    return false
    
end

Goal.Parry = function (f21_arg0, f21_arg1, f21_arg2)
    local f21_local0 = f21_arg0:GetHpRate(TARGET_SELF)
    local f21_local1 = f21_arg0:GetDist(TARGET_ENE_0)
    local f21_local2 = f21_arg0:GetSp(TARGET_SELF)
    local f21_local3 = f21_arg0:GetRandam_Int(1, 100)
    local f21_local4 = 0
    if not f21_arg0:IsInsideTarget(TARGET_ENE_0, AI_DIR_TYPE_F, 90) or not f21_arg0:IsInsideTargetEx(TARGET_ENE_0, TARGET_SELF, AI_DIR_TYPE_F, 90, 3) or f21_arg0:HasSpecialEffectId(TARGET_ENE_0, 109012) then
    elseif f21_arg0:IsTargetGuard(TARGET_SELF) then
        if f21_arg0:HasSpecialEffectId(TARGET_ENE_0, 109970) then
        else
            f21_arg1:ClearSubGoal()
            f21_arg1:AddSubGoal(GOAL_COMMON_EndureAttack, 0.1, 3100, TARGET_ENE_0, 9999, 0)
            return true
        end
    elseif f21_arg0:HasSpecialEffectId(TARGET_ENE_0, 109970) then
        f21_arg1:ClearSubGoal()
        f21_arg1:AddSubGoal(GOAL_COMMON_EndureAttack, 0.1, 3101, TARGET_ENE_0, 9999, 0)
        return true
    else
        f21_arg1:ClearSubGoal()
        f21_arg1:AddSubGoal(GOAL_COMMON_EndureAttack, 0.1, 3100, TARGET_ENE_0, 9999, 0)
        return true
    end
    return false
    
end

Goal.Damaged = function (f22_arg0, f22_arg1, f22_arg2)
    local f22_local0 = 3
    if SpaceCheck(f22_arg0, f22_arg1, 180, 2) == false then
        f22_arg1:ClearSubGoal()
        f22_arg1:AddSubGoal(GOAL_COMMON_SpinStep, f22_local0, 5201, TARGET_ENE_0, 0, AI_DIR_TYPE_B, 0)
        return true
    end
    return false
    
end

Goal.ActAfter_AdjustSpace = function (f23_arg0, f23_arg1, f23_arg2)
    
end

Goal.Update = function (f24_arg0, f24_arg1, f24_arg2)
    return Update_Default_NoSubGoal(f24_arg0, f24_arg1, f24_arg2)
    
end

Goal.Terminate = function (f25_arg0, f25_arg1, f25_arg2)
    
end


