RegisterTableGoal(GOAL_Taniteki_Normal_119000_Battle, "GOAL_Taniteki_Normal_119000_Battle")
REGISTER_GOAL_NO_UPDATE(GOAL_Taniteki_Normal_119000_Battle, true)

Goal.Initialize = function (f1_arg0, f1_arg1, f1_arg2, f1_arg3)
    
end

Goal.Activate = function (f2_arg0, f2_arg1, f2_arg2)
    Init_Pseudo_Global(f2_arg1, f2_arg2)
    f2_arg1:SetStringIndexedNumber("Dist_Step_Small", 4)
    f2_arg1:SetStringIndexedNumber("Dist_Step_Large", 5)
    f2_arg1:AddObserveSpecialEffectAttribute(TARGET_SELF, 5026)
    local f2_local0 = {}
    local f2_local1 = {}
    local f2_local2 = {}
    Common_Clear_Param(f2_local0, f2_local1, f2_local2)
    local f2_local3 = f2_arg1:GetHpRate(TARGET_SELF)
    local f2_local4 = f2_arg1:GetSp(TARGET_SELF)
    local f2_local5 = f2_arg1:GetDist(TARGET_ENE_0)
    local f2_local6 = f2_arg1:GetExcelParam(AI_EXCEL_THINK_PARAM_TYPE__thinkAttr_doAdmirer)
    local f2_local7 = f2_arg1:GetEventRequest()
    local f2_local8 = f2_arg1:GetDistYSigned(TARGET_ENE_0)
    Set_ConsecutiveGuardCount_Interrupt(f2_arg1)
    local f2_local9 = 25 - f2_arg1:GetMapHitRadius(TARGET_SELF)
    local f2_local10 = 10 - f2_arg1:GetMapHitRadius(TARGET_SELF)
    local f2_local11 = 90
    if f2_arg0.Kengeki_Activate(f2_arg0, f2_arg1, f2_arg2) then
        return
    end
    local f2_local12 = 0
    if f2_local5 >= 30 then
        f2_local12 = 2
    end
    if Common_ActivateAct(f2_arg1, f2_arg2, f2_local12) then
    elseif f2_local6 == 1 and f2_arg1:GetTeamOrder(ORDER_TYPE_Role) == ROLE_TYPE_Kankyaku then
        if f2_local5 >= 10 then
            f2_local0[26] = 100
        else
            KankyakuAct(f2_arg1, f2_arg2, 0, 0)
        end
    elseif f2_local6 == 1 and f2_arg1:GetTeamOrder(ORDER_TYPE_Role) == ROLE_TYPE_Torimaki then
        if f2_local5 >= 10 then
            f2_local0[26] = 100
        else
            TorimakiAct(f2_arg1, f2_arg2, 0, 0)
        end
    elseif f2_arg1:CheckDoesExistPath(TARGET_ENE_0, AI_DIR_TYPE_F, 0, 0) == false then
        f2_local0[1] = 100
    elseif f2_arg1:IsInsideTarget(TARGET_ENE_0, AI_DIR_TYPE_B, 180) then
        f2_local0[21] = 100
    elseif f2_local5 >= 10 then
        f2_local0[1] = 100
        f2_local0[27] = 0
    elseif f2_local5 >= 5 then
        if f2_arg1:HasSpecialEffectId(TARGET_SELF, 5025) then
            f2_local0[10] = 100
        end
        f2_local0[5] = 100
        f2_local0[6] = 100
        f2_local0[23] = 10
        f2_local0[27] = 10
    elseif f2_local5 >= 3 then
        f2_local0[5] = 100
        f2_local0[6] = 200
        f2_local0[12] = 20
        f2_local0[23] = 50
        f2_local0[24] = 20
    elseif f2_local5 >= 1 then
        f2_local0[5] = 100
        f2_local0[6] = 200
        f2_local0[11] = 30
        f2_local0[12] = 20
        f2_local0[23] = 50
        f2_local0[24] = 100
    else
        f2_local0[11] = 100
        f2_local0[24] = 50
    end
    if f2_arg1:GetNumber(0) >= 3 and f2_arg1:GetNumber(1) >= 3 then
        f2_local0[15] = 1000
    end
    if SpaceCheck(f2_arg1, f2_arg2, 90, 1) == false and SpaceCheck(f2_arg1, f2_arg2, -45, 1) == false then
        f2_local0[23] = 0
    end
    if SpaceCheck(f2_arg1, f2_arg2, 180, 2) == false then
        f2_local0[24] = 0
    end
    if SpaceCheck(f2_arg1, f2_arg2, 180, 1) == false then
        f2_local0[25] = 0
    end
    if f2_local8 > 2 or f2_local8 < -2 then
        f2_local0[6] = 0
    end
    f2_local0[4] = SetCoolTime(f2_arg1, f2_arg2, 3005, 3, f2_local0[4], 1)
    f2_local0[5] = SetCoolTime(f2_arg1, f2_arg2, 3000, 10, f2_local0[5], 1)
    f2_local0[6] = SetCoolTime(f2_arg1, f2_arg2, 3005, 10, f2_local0[6], 1)
    f2_local0[10] = SetCoolTime(f2_arg1, f2_arg2, 3010, 2, f2_local0[10], 1)
    f2_local0[10] = SetCoolTime(f2_arg1, f2_arg2, 601041, 2, f2_local0[10], 1)
    f2_local0[11] = SetCoolTime(f2_arg1, f2_arg2, 3012, 8, f2_local0[11], 1)
    f2_local0[12] = SetCoolTime(f2_arg1, f2_arg2, 3014, 10, f2_local0[12], 1)
    f2_local0[24] = SetCoolTime(f2_arg1, f2_arg2, 5201, 3, f2_local0[24], 1)
    f2_local0[24] = SetCoolTime(f2_arg1, f2_arg2, 5211, 3, f2_local0[24], 1)
    f2_local1[1] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act01)
    f2_local1[2] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act02)
    f2_local1[3] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act03)
    f2_local1[4] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act04)
    f2_local1[5] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act05)
    f2_local1[6] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act06)
    f2_local1[10] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act10)
    f2_local1[11] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act11)
    f2_local1[12] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act12)
    f2_local1[15] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act15)
    f2_local1[21] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act21)
    f2_local1[23] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act23)
    f2_local1[24] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act24)
    f2_local1[25] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act25)
    f2_local1[26] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act26)
    f2_local1[27] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act27)
    f2_local1[28] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act28)
    f2_local1[30] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act30)
    local f2_local13 = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.ActAfter_AdjustSpace)
    Common_Battle_Activate(f2_arg1, f2_arg2, f2_local0, f2_local1, f2_local13, f2_local2)
    
end

Goal.Act01 = function (f3_arg0, f3_arg1, f3_arg2)
    local f3_local0 = f3_arg0:GetRandam_Int(1, 100)
    local f3_local1 = f3_arg0:GetDistY(TARGET_ENE_0)
    f3_arg1:AddSubGoal(GOAL_COMMON_Wait, 1, TARGET_SELF, 0, 0, 0)
    f3_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 10, 3000, TARGET_ENE_0, 9999, 0, 0, 0, 0)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act02 = function (f4_arg0, f4_arg1, f4_arg2)
    f4_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 10, 603000, TARGET_ENE_0, 9999, 0, 0, 0, 0)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act03 = function (f5_arg0, f5_arg1, f5_arg2)
    if f5_arg0:HasSpecialEffectId(TARGET_SELF, 5025) then
        f5_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 10, 603002, TARGET_ENE_0, 9999, 0, 0, 0, 0)
    else
        f5_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 10, 401062, TARGET_ENE_0, 9999, 0, 0, 0, 0)
    end
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act04 = function (f6_arg0, f6_arg1, f6_arg2)
    local f6_local0 = 0
    local f6_local1 = 0
    f6_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 10, 3005, TARGET_ENE_0, 9999, f6_local0, f6_local1, 0, 0)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act05 = function (f7_arg0, f7_arg1, f7_arg2)
    local f7_local0 = 0
    local f7_local1 = 0
    f7_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 10, 3000, TARGET_ENE_0, 9999, f7_local0, f7_local1, 0, 0)
    f7_arg0:SetNumber(0, f7_arg0:GetNumber(0) + 1)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act06 = function (f8_arg0, f8_arg1, f8_arg2)
    local f8_local0 = 0
    local f8_local1 = 0
    f8_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 10, 3005, TARGET_ENE_0, 9999, f8_local0, f8_local1, 0, 0)
    f8_arg0:SetNumber(0, f8_arg0:GetNumber(0) + 1)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act10 = function (f9_arg0, f9_arg1, f9_arg2)
    local f9_local0 = f9_arg0:GetDist(TARGET_ENE_0)
    local f9_local1 = 4 - f9_arg0:GetMapHitRadius(TARGET_SELF)
    local f9_local2 = 4 - f9_arg0:GetMapHitRadius(TARGET_SELF) + 2
    local f9_local3 = 4 - f9_arg0:GetMapHitRadius(TARGET_SELF) + 4
    local f9_local4 = 2 - f9_arg0:GetMapHitRadius(TARGET_SELF)
    local f9_local5 = 100
    local f9_local6 = 0
    local f9_local7 = 1.5
    local f9_local8 = 3
    local f9_local9 = f9_arg0:GetRandam_Int(1, 100)
    f9_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3015, TARGET_ENE_0, 9999, 0, 0):TimingSetNumber(0, f9_arg0:GetNumber(0) + 1, AI_TIMING_SET__ACTIVATE)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act11 = function (f10_arg0, f10_arg1, f10_arg2)
    local f10_local0 = f10_arg0:GetDist(TARGET_ENE_0)
    local f10_local1 = 2 - f10_arg0:GetMapHitRadius(TARGET_SELF)
    local f10_local2 = 2 - f10_arg0:GetMapHitRadius(TARGET_SELF) + 2
    local f10_local3 = 2 - f10_arg0:GetMapHitRadius(TARGET_SELF) + 2
    local f10_local4 = 100
    local f10_local5 = 0
    local f10_local6 = 1.5
    local f10_local7 = 3
    if f10_local1 < f10_local0 then
        Approach_Act_Flex(f10_arg0, f10_arg1, f10_local1, f10_local2, f10_local3, f10_local4, f10_local5, f10_local6, f10_local7)
    end
    local f10_local8 = 3012
    local f10_local9 = 0
    local f10_local10 = 0
    f10_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 10, f10_local8, TARGET_ENE_0, 9999, f10_local9, f10_local10, 0, 0)
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
    
end

Goal.Act12 = function (f11_arg0, f11_arg1, f11_arg2)
    local f11_local0 = f11_arg0:GetDist(TARGET_ENE_0)
    local f11_local1 = 9.5 - f11_arg0:GetMapHitRadius(TARGET_SELF)
    local f11_local2 = 9.5 - f11_arg0:GetMapHitRadius(TARGET_SELF) + 0
    local f11_local3 = 9.5 - f11_arg0:GetMapHitRadius(TARGET_SELF) + 2
    local f11_local4 = 100
    local f11_local5 = 0
    local f11_local6 = 1.5
    local f11_local7 = 5
    if f11_local1 < f11_local0 then
        Approach_Act_Flex(f11_arg0, f11_arg1, f11_local1, f11_local2, f11_local3, f11_local4, f11_local5, f11_local6, f11_local7)
    end
    local f11_local8 = 3014
    local f11_local9 = 0
    local f11_local10 = 0
    f11_arg1:AddSubGoal(GOAL_COMMON_ComboAttackTunableSpin, 10, f11_local8, TARGET_ENE_0, 9999, f11_local9, f11_local10, 0, 0)
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
    
end

Goal.Act15 = function (f12_arg0, f12_arg1, f12_arg2)
    local f12_local0 = 0
    local f12_local1 = 0
    f12_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 10, 3009, TARGET_ENE_0, 9999, f12_local0, f12_local1, 0, 0)
    f12_arg0:SetNumber(0, 0)
    f12_arg0:SetNumber(1, 0)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act21 = function (f13_arg0, f13_arg1, f13_arg2)
    local f13_local0 = 3
    local f13_local1 = 45
    f13_arg1:AddSubGoal(GOAL_COMMON_Turn, f13_local0, TARGET_ENE_0, f13_local1, -1, GOAL_RESULT_Success, true)
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
    
end

Goal.Act23 = function (f14_arg0, f14_arg1, f14_arg2)
    local f14_local0 = f14_arg0:GetDist(TARGET_ENE_0)
    local f14_local1 = f14_arg0:GetSp(TARGET_SELF)
    local f14_local2 = 20
    local f14_local3 = f14_arg0:GetRandam_Int(1, 100)
    local f14_local4 = -1
    local f14_local5 = 0
    if SpaceCheck(f14_arg0, f14_arg1, -90, 1) == true then
        if SpaceCheck(f14_arg0, f14_arg1, 90, 1) == true then
            if f14_arg0:IsInsideTargetEx(TARGET_ENE_0, TARGET_SELF, AI_DIR_TYPE_R, 180, 999) then
                f14_local5 = 1
            else
                f14_local5 = 0
            end
        else
            f14_local5 = 0
        end
    elseif SpaceCheck(f14_arg0, f14_arg1, 90, 1) == true then
        f14_local5 = 1
    else
    end
    local f14_local6 = 3
    local f14_local7 = f14_arg0:GetRandam_Int(30, 45)
    f14_arg0:SetNumber(NUMBER_SIDEWAY_DIRECTION, f14_local5)
    f14_arg1:AddSubGoal(GOAL_COMMON_SidewayMove, f14_local6, TARGET_ENE_0, f14_local5, f14_local7, true, true, f14_local4):TmiingSetTimer(2, 4, UPDATE_SUCCESS)
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
    local f16_local0 = f16_arg0:GetRandam_Float(0.5, 1)
    local f16_local1 = f16_arg0:GetRandam_Float(0.1, 1)
    local f16_local2 = f16_arg0:GetDist(TARGET_ENE_0)
    local f16_local3 = -1
    if SpaceCheck(f16_arg0, f16_arg1, 180, 1) == true then
        f16_arg1:AddSubGoal(GOAL_COMMON_LeaveTarget, f16_local0, TARGET_ENE_0, f16_local1, TARGET_ENE_0, true, f16_local3)
    else
        GetWellSpace_Odds = 100
        return GetWellSpace_Odds
    end
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
    
end

Goal.Act26 = function (f17_arg0, f17_arg1, f17_arg2)
    f17_arg1:AddSubGoal(GOAL_COMMON_Wait, 0.5, TARGET_SELF, 0, 0, 0)
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
    
end

Goal.Act27 = function (f18_arg0, f18_arg1, f18_arg2)
    local f18_local0 = f18_arg0:GetRandam_Int(1, 100)
    if YousumiAct_SubGoal(f18_arg0, f18_arg1, true, 60, 30) == false then
        GetWellSpace_Odds = 0
        return GetWellSpace_Odds
    end
    local f18_local1 = 0
    local f18_local2 = SpaceCheck_SidewayMove(f18_arg0, f18_arg1, 1)
    if f18_local2 == 0 then
        f18_local1 = 0
    elseif f18_local2 == 1 then
        f18_local1 = 1
    elseif f18_local2 == 2 then
        if f18_local0 <= 50 then
            f18_local1 = 0
        else
            f18_local1 = 1
        end
    else
        f18_arg1:AddSubGoal(GOAL_COMMON_Wait, 0.5, TARGET_SELF, 0, 0, 0)
        GetWellSpace_Odds = 0
        return GetWellSpace_Odds
    end
    f18_arg0:SetNumber(10, f18_local1)
    f18_arg1:AddSubGoal(GOAL_COMMON_SidewayMove, 3, TARGET_ENE_0, f18_local1, f18_arg0:GetRandam_Int(30, 45), true, true, -1)
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
    
end

Goal.Act28 = function (f19_arg0, f19_arg1, f19_arg2)
    local f19_local0 = f19_arg0:GetDist(TARGET_ENE_0)
    local f19_local1 = 1.5
    local f19_local2 = 1.5
    local f19_local3 = f19_arg0:GetRandam_Int(30, 45)
    local f19_local4 = -1
    local f19_local5 = f19_arg0:GetRandam_Int(0, 1)
    if f19_local0 <= 3 then
        f19_arg1:AddSubGoal(GOAL_COMMON_SidewayMove, f19_local1, TARGET_ENE_0, f19_local5, f19_local3, true, true, f19_local4)
    elseif f19_local0 <= 8 then
        f19_arg1:AddSubGoal(GOAL_COMMON_ApproachTarget, f19_local2, TARGET_ENE_0, 3, TARGET_SELF, true, -1)
    else
        f19_arg1:AddSubGoal(GOAL_COMMON_ApproachTarget, f19_local2, TARGET_ENE_0, 8, TARGET_SELF, false, -1)
    end
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
    
end

Goal.Act30 = function (f20_arg0, f20_arg1, f20_arg2)
    local f20_local0 = 3.5
    local f20_local1 = f20_arg0:GetRandam_Int(30, 45)
    local f20_local2 = 0
    if SpaceCheck(f20_arg0, f20_arg1, -90, 1) == true then
        if SpaceCheck(f20_arg0, f20_arg1, 90, 1) == true then
            if f20_arg0:IsInsideTarget(TARGET_ENE_0, AI_DIR_TYPE_R, 180) then
                f20_local2 = 0
            else
                f20_local2 = 1
            end
        else
            f20_local2 = 0
        end
    elseif SpaceCheck(f20_arg0, f20_arg1, 90, 1) == true then
        f20_local2 = 1
    else
    end
    f20_arg1:AddSubGoal(GOAL_COMMON_SidewayMove, f20_local0, TARGET_ENE_0, f20_local2, f20_local1, true, true, -1)
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
    
end

Goal.Interrupt = function (f21_arg0, f21_arg1, f21_arg2)
    local f21_local0 = f21_arg1:GetHpRate(TARGET_SELF)
    local f21_local1 = f21_arg1:GetDist(TARGET_ENE_0)
    local f21_local2 = f21_arg1:GetSp(TARGET_SELF)
    local f21_local3 = f21_arg1:GetSpecialEffectActivateInterruptType(0)
    if f21_arg1:IsLadderAct(TARGET_SELF) then
        return false
    end
    if not f21_arg1:HasSpecialEffectId(TARGET_SELF, 200004) then
        return false
    end
    if f21_arg1:IsInterupt(INTERUPT_ParryTiming) then
        return Common_Parry(f21_arg1, f21_arg2, 0, 0)
    end
    if f21_arg1:IsInterupt(INTERUPT_ShootImpact) then
        return f21_arg0.ShootReaction(f21_arg1, f21_arg2)
    end
    if f21_arg1:IsInterupt(INTERUPT_Damaged) then
        return f21_arg0.Damaged(f21_arg1, f21_arg2)
    end
    if f21_arg1:IsInterupt(INTERUPT_ActivateSpecialEffect) and f21_arg1:GetSpecialEffectActivateInterruptType(0) == 5026 then
        f21_arg1:SetNumber(1, f21_arg1:GetNumber(1) + 1)
    end
    if f21_arg1:IsInterupt(INTERUPT_Inside_ObserveArea) then
    end
    return false
    
end

Goal.Damaged = function (f22_arg0, f22_arg1, f22_arg2)
    local f22_local0 = f22_arg0:GetHpRate(TARGET_SELF)
    local f22_local1 = f22_arg0:GetDist(TARGET_ENE_0)
    local f22_local2 = f22_arg0:GetSp(TARGET_SELF)
    local f22_local3 = f22_arg0:GetRandam_Int(1, 100)
    local f22_local4 = 0
    if f22_local3 <= 33 then
        f22_arg1:ClearSubGoal()
        f22_arg1:AddSubGoal(GOAL_COMMON_SpinStep, StepLife, 5201, TARGET_ENE_0, TurnTime, AI_DIR_TYPE_B, 0):TimingSetTimer(3, 6, UPDATE_SUCCESS)
        return true
    elseif f22_local3 <= 67 then
    end
    return false
    
end

Goal.ShootReaction = function (f23_arg0, f23_arg1)
    local f23_local0 = f23_arg0:GetDist(TARGET_ENE_0)
    if f23_arg0:IsInsideTargetEx(TARGET_ENE_0, TARGET_SELF, AI_DIR_TYPE_F, 20, 999) then
        if f23_local0 <= 30 then
            f23_arg1:ClearSubGoal()
            f23_arg1:AddSubGoal(GOAL_COMMON_EndureAttack, 0.1, 3100, TARGET_ENE_0, 9999, 0)
            return true
        else
            f23_arg1:ClearSubGoal()
            f23_arg1:AddSubGoal(GOAL_COMMON_Wait, 0.3, TARGET_SELF, 0, 0, 0)
            f23_arg1:AddSubGoal(GOAL_COMMON_EndureAttack, 0.1, 3100, TARGET_ENE_0, 9999, 0)
            return true
        end
    end
    return false
    
end

Goal.Kengeki_Activate = function (f24_arg0, f24_arg1, f24_arg2, f24_arg3)
    local f24_local0 = ReturnKengekiSpecialEffect(f24_arg1)
    if f24_local0 == 0 then
        return false
    end
    local f24_local1 = {}
    local f24_local2 = {}
    local f24_local3 = {}
    Common_Clear_Param(f24_local1, f24_local2, f24_local3)
    local f24_local4 = f24_arg1:GetDist(TARGET_ENE_0)
    local f24_local5 = f24_arg1:GetSp(TARGET_SELF)
    if f24_local5 <= 0 then
        f24_local1[26] = 100
    elseif f24_local0 == 200215 then
        if f24_local4 >= 3.5 then
            f24_local1[26] = 100
        elseif f24_local4 <= 0.2 then
            f24_local1[26] = 100
        else
            f24_local1[5] = 100
            f24_local1[26] = 1
        end
    elseif f24_local0 == 200216 then
        if f24_local4 >= 3.5 then
            f24_local1[26] = 100
        elseif f24_local4 <= 0.2 then
            f24_local1[26] = 100
        else
            f24_local1[6] = 100
            f24_local1[26] = 1
        end
    end
    f24_local1[7] = SetCoolTime(f24_arg1, f24_arg2, 3080, 10, f24_local1[7], 1)
    f24_local1[8] = SetCoolTime(f24_arg1, f24_arg2, 3012, 10, f24_local1[7], 1)
    f24_local1[24] = SetCoolTime(f24_arg1, f24_arg2, 5201, 5, f24_local1[24], 1)
    f24_local1[24] = SetCoolTime(f24_arg1, f24_arg2, 5211, 5, f24_local1[24], 1)
    f24_local2[5] = REGIST_FUNC(f24_arg1, f24_arg2, f24_arg0.Kengeki05)
    f24_local2[6] = REGIST_FUNC(f24_arg1, f24_arg2, f24_arg0.Kengeki06)
    f24_local2[7] = REGIST_FUNC(f24_arg1, f24_arg2, f24_arg0.Kengeki07)
    f24_local2[21] = REGIST_FUNC(f24_arg1, f24_arg2, f24_arg0.Act21)
    f24_local2[22] = REGIST_FUNC(f24_arg1, f24_arg2, f24_arg0.Act22)
    f24_local2[23] = REGIST_FUNC(f24_arg1, f24_arg2, f24_arg0.Act23)
    f24_local2[24] = REGIST_FUNC(f24_arg1, f24_arg2, f24_arg0.Act24)
    f24_local2[25] = REGIST_FUNC(f24_arg1, f24_arg2, f24_arg0.Act25)
    f24_local2[26] = REGIST_FUNC(f24_arg1, f24_arg2, f24_arg0.NoAction)
    local f24_local6 = REGIST_FUNC(f24_arg1, f24_arg2, f24_arg0.ActAfter_AdjustSpace)
    return Common_Kengeki_Activate(f24_arg1, f24_arg2, f24_local1, f24_local2, f24_local6, f24_local3)
    
end

Goal.Kengeki05 = function (f25_arg0, f25_arg1, f25_arg2)
    f25_arg1:ClearSubGoal()
    f25_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 1, 3070, TARGET_ENE_0, 9999, 0, 0)
    
end

Goal.Kengeki06 = function (f26_arg0, f26_arg1, f26_arg2)
    f26_arg1:ClearSubGoal()
    f26_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 1, 3075, TARGET_ENE_0, 9999, 0, 0)
    
end

Goal.Kengeki07 = function (f27_arg0, f27_arg1, f27_arg2)
    f27_arg1:ClearSubGoal()
    f27_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 9999, 3080, TARGET_ENE_0, 9999, 0, 0)
    
end

Goal.NoAction = function (f28_arg0, f28_arg1, f28_arg2)
    return -1
    
end

Goal.ActAfter_AdjustSpace = function (f29_arg0, f29_arg1, f29_arg2)
    
end

Goal.Update = function (f30_arg0, f30_arg1, f30_arg2)
    return Update_Default_NoSubGoal(f30_arg0, f30_arg1, f30_arg2)
    
end

Goal.Terminate = function (f31_arg0, f31_arg1, f31_arg2)
    
end


