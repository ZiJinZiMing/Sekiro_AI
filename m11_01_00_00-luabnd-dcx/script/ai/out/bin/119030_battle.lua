RegisterTableGoal(GOAL_Taniteki_Canon_119030_Battle, "GOAL_Taniteki_Canon_119030_Battle")
REGISTER_GOAL_NO_UPDATE(GOAL_Taniteki_Canon_119030_Battle, true)

Goal.Initialize = function (f1_arg0, f1_arg1, f1_arg2, f1_arg3)
    
end

Goal.Activate = function (f2_arg0, f2_arg1, f2_arg2)
    Init_Pseudo_Global(f2_arg1, f2_arg2)
    f2_arg1:DeleteObserve(0)
    f2_arg1:AddObserveSpecialEffectAttribute(TARGET_SELF, 5025)
    Set_ConsecutiveGuardCount_Interrupt(f2_arg1)
    local f2_local0 = {}
    local f2_local1 = {}
    local f2_local2 = {}
    Common_Clear_Param(f2_local0, f2_local1, f2_local2)
    local f2_local3 = f2_arg1:GetHpRate(TARGET_SELF)
    local f2_local4 = f2_arg1:GetSp(TARGET_SELF)
    local f2_local5 = f2_arg1:GetExcelParam(AI_EXCEL_THINK_PARAM_TYPE__thinkAttr_doAdmirer)
    local f2_local6 = f2_arg1:GetDist(TARGET_ENE_0)
    local f2_local7 = f2_arg1:GetEventRequest()
    if f2_arg0.Kengeki_Activate(f2_arg0, f2_arg1, f2_arg2) then
        return
    end
    local f2_local8 = 0
    if f2_local6 >= 30 then
        f2_local8 = 2
    end
    if Common_ActivateAct(f2_arg1, f2_arg2, f2_local8) then
    elseif f2_local5 == 1 and f2_arg1:GetTeamOrder(ORDER_TYPE_Role) == ROLE_TYPE_Kankyaku then
        if f2_local6 >= 10 then
            f2_local0[1] = 20
            f2_local0[26] = 100
        elseif f2_local6 >= 5 then
            f2_local0[4] = 20
            f2_local0[26] = 100
        else
            KankyakuAct(f2_arg1, f2_arg2, 0, 0)
        end
    elseif f2_local5 == 1 and f2_arg1:GetTeamOrder(ORDER_TYPE_Role) == ROLE_TYPE_Torimaki then
        if f2_local6 >= 10 then
            f2_local0[1] = 20
            f2_local0[26] = 100
        elseif f2_local6 >= 5 then
            f2_local0[4] = 20
            f2_local0[26] = 100
        else
            TorimakiAct(f2_arg1, f2_arg2, 0, 0)
        end
    elseif f2_arg1:IsInsideTarget(TARGET_ENE_0, AI_DIR_TYPE_B, 180) then
        f2_local0[26] = 100
        f2_local0[21] = 100
    elseif f2_local6 > 10 then
        f2_local0[1] = 100
        f2_local0[9] = 1
    elseif f2_local6 > 5 then
        f2_local0[4] = 100
        f2_local0[9] = 1
    else
        f2_local0[4] = 10
        f2_local0[10] = 25
        f2_local0[11] = 25
        f2_local0[23] = 10
        f2_local0[25] = 20
    end
    if f2_arg1:GetDistY(TARGET_ENE_0) >= 1 then
        f2_local0[10] = 0
        f2_local0[11] = 0
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
    f2_local0[4] = SetCoolTime(f2_arg1, f2_arg2, 3001, 5, f2_local0[4], 1)
    f2_local0[4] = SetCoolTime(f2_arg1, f2_arg2, 3006, 5, f2_local0[4], 1)
    f2_local0[10] = SetCoolTime(f2_arg1, f2_arg2, 3010, 4, f2_local0[10], 1)
    f2_local0[11] = SetCoolTime(f2_arg1, f2_arg2, 3011, 8, f2_local0[11], 1)
    f2_local0[24] = SetCoolTime(f2_arg1, f2_arg2, 5201, 10, f2_local0[24], 1)
    f2_local1[1] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act01)
    f2_local1[2] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act02)
    f2_local1[3] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act03)
    f2_local1[4] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act04)
    f2_local1[9] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act09)
    f2_local1[10] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act10)
    f2_local1[11] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act11)
    f2_local1[21] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act21)
    f2_local1[23] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act23)
    f2_local1[24] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act24)
    f2_local1[25] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act25)
    f2_local1[26] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act26)
    f2_local1[27] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act27)
    f2_local1[28] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act28)
    f2_local1[30] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act30)
    local f2_local9 = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.ActAfter_AdjustSpace)
    Common_Battle_Activate(f2_arg1, f2_arg2, f2_local0, f2_local1, f2_local9, f2_local2)
    
end

Goal.Act01 = function (f3_arg0, f3_arg1, f3_arg2)
    local f3_local0 = f3_arg0:GetDistYSigned(TARGET_ENE_0)
    local f3_local1 = 3000
    local f3_local2 = 3007
    local f3_local3 = 0
    local f3_local4 = 0
    f3_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 10, 3000, TARGET_ENE_0, 9999, f3_local3, f3_local4, 0, 0)
    f3_arg1:AddSubGoal(GOAL_COMMON_Wait, 1, TARGET_SELF, 0, 0, 0)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act02 = function (f4_arg0, f4_arg1, f4_arg2)
    local f4_local0 = f4_arg0:GetDistYSigned(TARGET_ENE_0)
    local f4_local1 = 3004
    local f4_local2 = 3008
    local f4_local3 = 0
    local f4_local4 = 0
    if f4_local0 <= -2 then
        f4_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 10, 3008, TARGET_ENE_0, 9999, f4_local3, f4_local4, 0, 0)
        f4_arg1:AddSubGoal(GOAL_COMMON_Wait, 1.5, TARGET_SELF, 0, 0, 0)
    else
        f4_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 10, 3004, TARGET_ENE_0, 9999, f4_local3, f4_local4, 0, 0)
        f4_arg1:AddSubGoal(GOAL_COMMON_Wait, 2, TARGET_SELF, 0, 0, 0)
    end
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act03 = function (f5_arg0, f5_arg1, f5_arg2)
    local f5_local0 = f5_arg0:GetDistYSigned(TARGET_ENE_0)
    local f5_local1 = 0
    local f5_local2 = 0
    if f5_local0 <= -2 then
        f5_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 10, 3009, TARGET_ENE_0, 9999, f5_local1, f5_local2, 0, 0)
        f5_arg1:AddSubGoal(GOAL_COMMON_Wait, 1.5, TARGET_SELF, 0, 0, 0)
    else
        f5_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 10, 3005, TARGET_ENE_0, 9999, f5_local1, f5_local2, 0, 0)
        f5_arg1:AddSubGoal(GOAL_COMMON_Wait, 2, TARGET_SELF, 0, 0, 0)
    end
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act04 = function (f6_arg0, f6_arg1, f6_arg2)
    local f6_local0 = f6_arg0:GetDist(TARGET_ENE_0)
    local f6_local1 = 0
    local f6_local2 = 0
    f6_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 10, 3001, TARGET_ENE_0, 9999, f6_local1, f6_local2, 0, 0)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act09 = function (f7_arg0, f7_arg1, f7_arg2)
    local f7_local0 = 3003
    local f7_local1 = 0
    local f7_local2 = 0
    f7_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 10, f7_local0, TARGET_ENE_0, 9999, f7_local1, f7_local2, 0, 0)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act10 = function (f8_arg0, f8_arg1, f8_arg2)
    local f8_local0 = f8_arg0:GetDist(TARGET_ENE_0)
    local f8_local1 = 3 - f8_arg0:GetMapHitRadius(TARGET_SELF)
    local f8_local2 = 3 - f8_arg0:GetMapHitRadius(TARGET_SELF) + 0
    local f8_local3 = 3 - f8_arg0:GetMapHitRadius(TARGET_SELF) + 5
    local f8_local4 = 100
    local f8_local5 = 0
    local f8_local6 = 1.5
    local f8_local7 = 3
    if f8_local1 < f8_local0 then
        Approach_Act_Flex(f8_arg0, f8_arg1, f8_local1, f8_local2, f8_local3, f8_local4, f8_local5, f8_local6, f8_local7)
    end
    local f8_local8 = 3010
    local f8_local9 = 0
    local f8_local10 = 0
    f8_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 10, f8_local8, TARGET_ENE_0, 9999, f8_local9, f8_local10, 0, 0)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act11 = function (f9_arg0, f9_arg1, f9_arg2)
    local f9_local0 = f9_arg0:GetDist(TARGET_ENE_0)
    local f9_local1 = 3 - f9_arg0:GetMapHitRadius(TARGET_SELF)
    local f9_local2 = 3 - f9_arg0:GetMapHitRadius(TARGET_SELF) + 0
    local f9_local3 = 3 - f9_arg0:GetMapHitRadius(TARGET_SELF) + 5
    local f9_local4 = 100
    local f9_local5 = 0
    local f9_local6 = 1.5
    local f9_local7 = 3
    local f9_local8 = f9_arg0:GetRandam_Int(1, 100)
    if f9_local1 < f9_local0 then
        Approach_Act_Flex(f9_arg0, f9_arg1, f9_local1, f9_local2, f9_local3, f9_local4, f9_local5, f9_local6, f9_local7)
    end
    local f9_local9 = 3011
    local f9_local10 = 3013
    local f9_local11 = 0
    local f9_local12 = 0
    f9_arg1:AddSubGoal(GOAL_COMMON_ComboAttackTunableSpin, 10, f9_local9, TARGET_ENE_0, 9999, f9_local11, f9_local12, 0, 0)
    f9_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, f9_local10, TARGET_ENE_0, 9999, 0, 0)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act21 = function (f10_arg0, f10_arg1, f10_arg2)
    local f10_local0 = 3
    local f10_local1 = 45
    f10_arg1:AddSubGoal(GOAL_COMMON_Turn, f10_local0, TARGET_ENE_0, f10_local1, -1, GOAL_RESULT_Success, true)
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
    
end

Goal.Act23 = function (f11_arg0, f11_arg1, f11_arg2)
    local f11_local0 = f11_arg0:GetDist(TARGET_ENE_0)
    local f11_local1 = f11_arg0:GetSp(TARGET_SELF)
    local f11_local2 = 20
    local f11_local3 = f11_arg0:GetRandam_Int(1, 100)
    local f11_local4 = -1
    local f11_local5 = 0
    if SpaceCheck(f11_arg0, f11_arg1, -90, 1) == true then
        if SpaceCheck(f11_arg0, f11_arg1, 90, 1) == true then
            if f11_arg0:IsInsideTargetEx(TARGET_ENE_0, TARGET_SELF, AI_DIR_TYPE_R, 180, 999) then
                f11_local5 = 1
            else
                f11_local5 = 0
            end
        else
            f11_local5 = 0
        end
    elseif SpaceCheck(f11_arg0, f11_arg1, 90, 1) == true then
        f11_local5 = 1
    else
    end
    local f11_local6 = 3
    local f11_local7 = f11_arg0:GetRandam_Int(30, 45)
    f11_arg0:SetNumber(NUMBER_SIDEWAY_DIRECTION, f11_local5)
    f11_arg1:AddSubGoal(GOAL_COMMON_SidewayMove, f11_local6, TARGET_ENE_0, f11_local5, f11_local7, true, true, f11_local4):TmiingSetTimer(2, 4, UPDATE_SUCCESS)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act24 = function (f12_arg0, f12_arg1, f12_arg2)
    local f12_local0 = f12_arg0:GetDist(TARGET_ENE_0)
    local f12_local1 = 3
    local f12_local2 = 0
    local f12_local3 = 5201
    if SpaceCheck(f12_arg0, f12_arg1, 180, 2) == true then
        if SpaceCheck(f12_arg0, f12_arg1, 180, 4) ~= true or f12_local0 > 4 then
        else
            f12_local3 = 5201
            if false then
            end
        end
    else
        GetWellSpace_Odds = 100
        return GetWellSpace_Odds
    end
    f12_arg1:AddSubGoal(GOAL_COMMON_SpinStep, f12_local1, f12_local3, TARGET_ENE_0, f12_local2, AI_DIR_TYPE_B, 0)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act25 = function (f13_arg0, f13_arg1, f13_arg2)
    local f13_local0 = f13_arg0:GetRandam_Float(1, 4)
    local f13_local1 = f13_arg0:GetRandam_Float(1, 3)
    local f13_local2 = f13_arg0:GetDist(TARGET_ENE_0)
    local f13_local3 = -1
    if SpaceCheck(f13_arg0, f13_arg1, 180, 1) == true then
        f13_arg1:AddSubGoal(GOAL_COMMON_LeaveTarget, f13_local0, TARGET_ENE_0, f13_local1, TARGET_ENE_0, true, f13_local3)
    else
        GetWellSpace_Odds = 100
        return GetWellSpace_Odds
    end
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
    
end

Goal.Act26 = function (f14_arg0, f14_arg1, f14_arg2)
    f14_arg1:AddSubGoal(GOAL_COMMON_Wait, 0.5, TARGET_SELF, 0, 0, 0)
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
    
end

Goal.Act27 = function (f15_arg0, f15_arg1, f15_arg2)
    local f15_local0 = f15_arg0:GetRandam_Int(1, 100)
    if YousumiAct_SubGoal(f15_arg0, f15_arg1, true, 60, 30) == false then
        GetWellSpace_Odds = 0
        return GetWellSpace_Odds
    end
    local f15_local1 = 0
    local f15_local2 = SpaceCheck_SidewayMove(f15_arg0, f15_arg1, 1)
    if f15_local2 == 0 then
        f15_local1 = 0
    elseif f15_local2 == 1 then
        f15_local1 = 1
    elseif f15_local2 == 2 then
        if f15_local0 <= 50 then
            f15_local1 = 0
        else
            f15_local1 = 1
        end
    else
        f15_arg1:AddSubGoal(GOAL_COMMON_Wait, 0.5, TARGET_SELF, 0, 0, 0)
        GetWellSpace_Odds = 0
        return GetWellSpace_Odds
    end
    f15_arg0:SetNumber(10, f15_local1)
    f15_arg1:AddSubGoal(GOAL_COMMON_SidewayMove, 3, TARGET_ENE_0, f15_local1, f15_arg0:GetRandam_Int(30, 45), true, true, -1)
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
    
end

Goal.Act28 = function (f16_arg0, f16_arg1, f16_arg2)
    local f16_local0 = f16_arg0:GetDist(TARGET_ENE_0)
    local f16_local1 = 1.5
    local f16_local2 = 1.5
    local f16_local3 = f16_arg0:GetRandam_Int(30, 45)
    local f16_local4 = -1
    local f16_local5 = f16_arg0:GetRandam_Int(0, 1)
    if f16_local0 <= 3 then
        f16_arg1:AddSubGoal(GOAL_COMMON_SidewayMove, f16_local1, TARGET_ENE_0, f16_local5, f16_local3, true, true, f16_local4)
    elseif f16_local0 <= 8 then
        f16_arg1:AddSubGoal(GOAL_COMMON_ApproachTarget, f16_local2, TARGET_ENE_0, 3, TARGET_SELF, true, -1)
    else
        f16_arg1:AddSubGoal(GOAL_COMMON_ApproachTarget, f16_local2, TARGET_ENE_0, 8, TARGET_SELF, false, -1)
    end
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
    
end

Goal.Act30 = function (f17_arg0, f17_arg1, f17_arg2)
    local f17_local0 = 3.5
    local f17_local1 = f17_arg0:GetRandam_Int(30, 45)
    local f17_local2 = 0
    if SpaceCheck(f17_arg0, f17_arg1, -90, 1) == true then
        if SpaceCheck(f17_arg0, f17_arg1, 90, 1) == true then
            if f17_arg0:IsInsideTarget(TARGET_ENE_0, AI_DIR_TYPE_R, 180) then
                f17_local2 = 0
            else
                f17_local2 = 1
            end
        else
            f17_local2 = 0
        end
    elseif SpaceCheck(f17_arg0, f17_arg1, 90, 1) == true then
        f17_local2 = 1
    else
    end
    f17_arg1:AddSubGoal(GOAL_COMMON_SidewayMove, f17_local0, TARGET_ENE_0, f17_local2, f17_local1, true, true, -1)
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
    
end

Goal.Interrupt = function (f18_arg0, f18_arg1, f18_arg2)
    local f18_local0 = f18_arg1:GetHpRate(TARGET_SELF)
    local f18_local1 = f18_arg1:GetDist(TARGET_ENE_0)
    local f18_local2 = f18_arg1:GetSp(TARGET_SELF)
    local f18_local3 = f18_arg1:GetSpecialEffectActivateInterruptType(0)
    if f18_arg1:IsLadderAct(TARGET_SELF) then
        return false
    end
    if not f18_arg1:HasSpecialEffectId(TARGET_SELF, 200004) then
        return false
    end
    if f18_arg1:IsInterupt(INTERUPT_ParryTiming) then
        return Common_Parry(f18_arg1, f18_arg2, 50, 0)
    end
    if f18_arg1:IsInterupt(INTERUPT_ShootImpact) then
        return f18_arg0.ShootReaction(f18_arg1, f18_arg2)
    end
    if f18_arg1:IsInterupt(INTERUPT_Damaged) then
        return f18_arg0.Damaged(f18_arg1, f18_arg2)
    end
    if f18_arg1:IsInterupt(INTERUPT_ActivateSpecialEffect) and f18_arg1:GetSpecialEffectActivateInterruptType(0) == 5025 then
        f18_arg1:AddObserveArea(0, TARGET_SELF, TARGET_ENE_0, AI_DIR_TYPE_F, 90, 4)
        return true
    end
    if f18_arg1:IsInterupt(INTERUPT_Inside_ObserveArea) and f18_arg1:IsInsideObserve(0) then
        f18_arg2:ClearSubGoal()
        f18_arg2:AddSubGoal(GOAL_COMMON_EndureAttack, 1, 3010, TARGET_ENE_0, 9999, 0)
        f18_arg1:DeleteObserve(0)
        return true
    end
    return false
    
end

Goal.Damaged = function (f19_arg0, f19_arg1, f19_arg2)
    local f19_local0 = f19_arg0:GetHpRate(TARGET_SELF)
    local f19_local1 = f19_arg0:GetDist(TARGET_ENE_0)
    local f19_local2 = f19_arg0:GetSp(TARGET_SELF)
    local f19_local3 = f19_arg0:GetRandam_Int(1, 100)
    local f19_local4 = 0
    if f19_local3 <= 33 then
        f19_arg1:ClearSubGoal()
        f19_arg1:AddSubGoal(GOAL_COMMON_SpinStep, StepLife, 5201, TARGET_ENE_0, TurnTime, AI_DIR_TYPE_B, 0):TimingSetTimer(3, 6, UPDATE_SUCCESS)
        return true
    elseif f19_local3 <= 67 then
    end
    return false
    
end

Goal.ShootReaction = function (f20_arg0, f20_arg1)
    local f20_local0 = f20_arg0:GetDist(TARGET_ENE_0)
    if f20_arg0:IsInsideTargetEx(TARGET_ENE_0, TARGET_SELF, AI_DIR_TYPE_F, 20, 999) then
        if f20_local0 <= 30 then
            f20_arg1:ClearSubGoal()
            f20_arg1:AddSubGoal(GOAL_COMMON_EndureAttack, 0.1, 3100, TARGET_ENE_0, 9999, 0)
            return true
        else
            f20_arg1:ClearSubGoal()
            f20_arg1:AddSubGoal(GOAL_COMMON_Wait, 0.3, TARGET_SELF, 0, 0, 0)
            f20_arg1:AddSubGoal(GOAL_COMMON_EndureAttack, 0.1, 3100, TARGET_ENE_0, 9999, 0)
            return true
        end
    end
    return false
    
end

Goal.Kengeki_Activate = function (f21_arg0, f21_arg1, f21_arg2, f21_arg3)
    local f21_local0 = ReturnKengekiSpecialEffect(f21_arg1)
    if f21_local0 == 0 then
        return false
    end
    local f21_local1 = {}
    local f21_local2 = {}
    local f21_local3 = {}
    Common_Clear_Param(f21_local1, f21_local2, f21_local3)
    local f21_local4 = f21_arg1:GetDist(TARGET_ENE_0)
    local f21_local5 = f21_arg1:GetSp(TARGET_SELF)
    local f21_local6 = f21_arg1:GetRandam_Int(1, 100)
    if f21_local5 <= 0 then
        f21_local1[50] = 100
    elseif f21_local0 == 200200 then
        if f21_local4 >= 2 then
            f21_local1[50] = 100
        elseif f21_local4 <= 0.2 then
            f21_local1[50] = 100
        else
            f21_local1[1] = 10
        end
    elseif f21_local0 == 200201 then
        if f21_local4 >= 2 then
            f21_local1[50] = 100
        elseif f21_local4 <= 0.2 then
            f21_local1[50] = 100
        else
            f21_local1[1] = 10
        end
    elseif f21_local0 == 200205 then
        if f21_local4 >= 2 then
            f21_local1[50] = 100
        elseif f21_local4 <= 0.2 then
            f21_local1[50] = 100
        else
            f21_local1[1] = 10
        end
    elseif f21_local0 == 200206 then
        if f21_local4 >= 2 then
            f21_local1[50] = 100
        elseif f21_local4 <= 0.2 then
            f21_local1[50] = 100
        else
            f21_local1[1] = 10
        end
    elseif f21_local0 == 200210 then
        if f21_local4 >= 2 then
            f21_local1[50] = 100
        elseif f21_local4 <= 0.2 then
            f21_local1[50] = 100
        else
            f21_local1[1] = 10
        end
    elseif f21_local0 == 200211 then
        if f21_local4 >= 2 then
            f21_local1[50] = 100
        elseif f21_local4 <= 0.2 then
            f21_local1[50] = 100
        else
            f21_local1[1] = 10
        end
    elseif f21_local0 == 200215 then
        if f21_local4 >= 2 then
            f21_local1[50] = 100
        elseif f21_local4 <= 0.2 then
            f21_local1[50] = 100
        else
            f21_local1[1] = 10
        end
    elseif f21_local0 == 200216 then
        if f21_local4 >= 2 then
            f21_local1[50] = 100
        elseif f21_local4 <= 0.2 then
            f21_local1[50] = 60
        else
            f21_local1[1] = 10
        end
    end
    f21_local1[24] = SetCoolTime(f21_arg1, f21_arg2, 5201, 10, f21_local1[24], 1)
    f21_local2[1] = REGIST_FUNC(f21_arg1, f21_arg2, f21_arg0.Kengeki01)
    f21_local2[21] = REGIST_FUNC(f21_arg1, f21_arg2, f21_arg0.Act21)
    f21_local2[22] = REGIST_FUNC(f21_arg1, f21_arg2, f21_arg0.Act22)
    f21_local2[23] = REGIST_FUNC(f21_arg1, f21_arg2, f21_arg0.Act23)
    f21_local2[24] = REGIST_FUNC(f21_arg1, f21_arg2, f21_arg0.Act24)
    f21_local2[25] = REGIST_FUNC(f21_arg1, f21_arg2, f21_arg0.Act25)
    f21_local2[50] = REGIST_FUNC(f21_arg1, f21_arg2, f21_arg0.NoAction)
    local f21_local7 = REGIST_FUNC(f21_arg1, f21_arg2, f21_arg0.ActAfter_AdjustSpace)
    return Common_Kengeki_Activate(f21_arg1, f21_arg2, f21_local1, f21_local2, f21_local7, f21_local3)
    
end

Goal.Kengeki01 = function (f22_arg0, f22_arg1, f22_arg2)
    f22_arg1:ClearSubGoal()
    f22_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 1, 3010, TARGET_ENE_0, 9999, 0, 0)
    
end

Goal.Kengeki02 = function (f23_arg0, f23_arg1, f23_arg2)
    f23_arg1:ClearSubGoal()
    f23_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 1, 3055, TARGET_ENE_0, 9999, 0, 0)
    
end

Goal.Kengeki03 = function (f24_arg0, f24_arg1, f24_arg2)
    f24_arg1:ClearSubGoal()
    f24_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 1, 3060, TARGET_ENE_0, 9999, 0, 0)
    
end

Goal.Kengeki04 = function (f25_arg0, f25_arg1, f25_arg2)
    f25_arg1:ClearSubGoal()
    f25_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 1, 3065, TARGET_ENE_0, 9999, 0, 0)
    
end

Goal.Kengeki05 = function (f26_arg0, f26_arg1, f26_arg2)
    f26_arg1:ClearSubGoal()
    f26_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 1, 3070, TARGET_ENE_0, 9999, 0, 0)
    
end

Goal.Kengeki06 = function (f27_arg0, f27_arg1, f27_arg2)
    f27_arg1:ClearSubGoal()
    f27_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 1, 3012, TARGET_ENE_0, 9999, 0, 0)
    
end

Goal.Kengeki07 = function (f28_arg0, f28_arg1, f28_arg2)
    f28_arg1:ClearSubGoal()
    f28_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 1, 3085, TARGET_ENE_0, 9999, 0, 0)
    
end

Goal.Kengeki08 = function (f29_arg0, f29_arg1, f29_arg2)
    f29_arg1:ClearSubGoal()
    f29_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 1, 3085, TARGET_ENE_0, 9999, 0, 0)
    
end

Goal.NoAction = function (f30_arg0, f30_arg1, f30_arg2)
    return -1
    
end

Goal.ActAfter_AdjustSpace = function (f31_arg0, f31_arg1, f31_arg2)
    
end

Goal.Update = function (f32_arg0, f32_arg1, f32_arg2)
    return Update_Default_NoSubGoal(f32_arg0, f32_arg1, f32_arg2)
    
end

Goal.Terminate = function (f33_arg0, f33_arg1, f33_arg2)
    
end


