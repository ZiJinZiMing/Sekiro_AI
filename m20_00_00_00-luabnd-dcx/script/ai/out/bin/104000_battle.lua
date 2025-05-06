RegisterTableGoal(GOAL_Mukade_large_104000_Battle, "GOAL_Mukade_large_104000_Battle")
REGISTER_GOAL_NO_UPDATE(GOAL_Mukade_large_104000_Battle, true)

Goal.Initialize = function (f1_arg0, f1_arg1, f1_arg2, f1_arg3)
    
end

Goal.Activate = function (f2_arg0, f2_arg1, f2_arg2)
    Init_Pseudo_Global(f2_arg1, f2_arg2)
    f2_arg1:SetStringIndexedNumber("Dist_Step_Small", 2)
    f2_arg1:SetStringIndexedNumber("Dist_Step_Large", 4)
    kengekiId = 0
    Set_ConsecutiveGuardCount_Interrupt(f2_arg1)
    if f2_arg0.Kengeki_Activate(f2_arg0, f2_arg1, f2_arg2) then
        return
    end
    local f2_local0 = {}
    local f2_local1 = {}
    local f2_local2 = {}
    Common_Clear_Param(f2_local0, f2_local1, f2_local2)
    local f2_local3 = f2_arg1:GetHpRate(TARGET_SELF)
    local f2_local4 = f2_arg1:GetSp(TARGET_SELF)
    local f2_local5 = f2_arg1:GetDist(TARGET_ENE_0)
    local f2_local6 = f2_arg1:GetExcelParam(AI_EXCEL_THINK_PARAM_TYPE__thinkAttr_doAdmirer)
    local f2_local7 = Check_ReachAttack(f2_arg1, 0)
    local f2_local8 = f2_arg1:GetEventRequest()
    local f2_local9 = f2_arg1:GetNinsatsuNum()
    f2_arg1:AddObserveSpecialEffectAttribute(TARGET_ENE_0, 90)
    if Common_ActivateAct(f2_arg1, f2_arg2) then
    elseif f2_arg1:IsInsideTargetRegion(TARGET_ENE_0, 2002223) then
        if f2_local5 >= 5 then
            f2_local0[27] = 20
            f2_local0[45] = 100
            f2_local0[46] = 100
        else
            f2_local0[24] = 20
            f2_local0[25] = 20
            f2_local0[27] = 20
            f2_local0[45] = 20
        end
    elseif f2_local7 ~= POSSIBLE_ATTACK then
        if f2_local6 == 1 and f2_arg1:GetTeamOrder(ORDER_TYPE_Role) == ROLE_TYPE_Kankyaku then
            f2_local0[27] = 100
        elseif f2_local6 == 1 and f2_arg1:GetTeamOrder(ORDER_TYPE_Role) == ROLE_TYPE_Torimaki then
            f2_local0[27] = 100
        elseif f2_local7 == UNREACH_ATTACK then
            f2_local0[27] = 20
            f2_local0[45] = 100
            f2_local0[46] = 100
        elseif f2_local7 == REACH_ATTACK_TARGET_HIGH_POSITION then
            f2_local0[11] = 50
            f2_local0[23] = 50
            if f2_local9 <= 1 then
                f2_local0[8] = 80
            end
        elseif f2_local7 == REACH_ATTACK_TARGET_LOW_POSITION then
            f2_local0[11] = 50
            f2_local0[23] = 50
            if f2_local9 <= 1 then
                f2_local0[8] = 80
            end
        else
            f2_local0[27] = 100
        end
    elseif f2_local6 == 1 and f2_arg1:GetTeamOrder(ORDER_TYPE_Role) == ROLE_TYPE_Kankyaku then
        KankyakuAct(f2_arg1, f2_arg2)
    elseif f2_local6 == 1 and f2_arg1:GetTeamOrder(ORDER_TYPE_Role) == ROLE_TYPE_Torimaki then
        TorimakiAct(f2_arg1, f2_arg2, -1, 0)
    elseif f2_arg1:IsInsideTarget(TARGET_ENE_0, AI_DIR_TYPE_B, 180) then
        if f2_local5 > 4 then
            f2_local0[21] = 50
            f2_local0[22] = 50
        else
            f2_local0[21] = 50
            f2_local0[22] = 100
        end
    elseif f2_local5 >= 10 then
        f2_local0[11] = 50
        f2_local0[23] = 50
        if f2_local9 <= 1 then
            f2_local0[8] = 80
        end
    else
        f2_local0[11] = 50
        f2_local0[23] = 50
        if f2_local9 <= 1 then
            f2_local0[8] = 80
        end
    end
    if SpaceCheck(f2_arg1, f2_arg2, 45, f2_arg1:GetStringIndexedNumber("Dist_Step_Small")) == false and SpaceCheck(f2_arg1, f2_arg2, -45, f2_arg1:GetStringIndexedNumber("Dist_Step_Small")) == false then
        f2_local0[22] = 0
    end
    if SpaceCheck(f2_arg1, f2_arg2, 90, 1) == false and SpaceCheck(f2_arg1, f2_arg2, -90, 1) == false then
        f2_local0[23] = 0
    end
    if SpaceCheck(f2_arg1, f2_arg2, 180, f2_arg1:GetStringIndexedNumber("Dist_Step_Small")) == false then
        f2_local0[24] = 0
    end
    if SpaceCheck(f2_arg1, f2_arg2, 180, 1) == false then
        f2_local0[25] = 0
    end
    if f2_arg1:IsFinishTimer(0) == false then
        f2_local0[23] = 0
    end
    f2_local0[8] = SetCoolTime(f2_arg1, f2_arg2, 3024, 6, f2_local0[8], 1)
    f2_local0[11] = SetCoolTime(f2_arg1, f2_arg2, 3030, 6, f2_local0[11], 1)
    f2_local1[8] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act08)
    f2_local1[9] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act09)
    f2_local1[10] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act10)
    f2_local1[11] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act11)
    f2_local1[21] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act21)
    f2_local1[22] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act22)
    f2_local1[23] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act23)
    f2_local1[24] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act24)
    f2_local1[25] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act25)
    f2_local1[26] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act26)
    f2_local1[27] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act27)
    f2_local1[28] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act28)
    f2_local1[30] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act30)
    f2_local1[41] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act41)
    f2_local1[45] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act45)
    f2_local1[46] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act46)
    local f2_local10 = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.ActAfter_AdjustSpace)
    Common_Battle_Activate(f2_arg1, f2_arg2, f2_local0, f2_local1, f2_local10, f2_local2)
    
end

Goal.Act08 = function (f3_arg0, f3_arg1, f3_arg2)
    local f3_local0 = f3_arg0:GetDist(TARGET_ENE_0)
    local f3_local1 = 4.8 - f3_arg0:GetMapHitRadius(TARGET_SELF)
    local f3_local2 = 4.8 - f3_arg0:GetMapHitRadius(TARGET_SELF) + 0
    local f3_local3 = 4.8 - f3_arg0:GetMapHitRadius(TARGET_SELF) + 2
    local f3_local4 = 100
    local f3_local5 = 0
    local f3_local6 = 1.5
    local f3_local7 = 3
    Approach_Act_Flex(f3_arg0, f3_arg1, f3_local1, f3_local2, f3_local3, f3_local4, f3_local5, f3_local6, f3_local7)
    local f3_local8 = 3024
    local f3_local9 = 3029
    local f3_local10 = 3027
    local f3_local11 = 4.8 - f3_arg0:GetMapHitRadius(TARGET_SELF)
    local f3_local12 = 4.8 - f3_arg0:GetMapHitRadius(TARGET_SELF)
    local f3_local13 = 5 - f3_arg0:GetMapHitRadius(TARGET_SELF)
    local f3_local14 = 0
    local f3_local15 = 0
    local f3_local16 = f3_arg0:GetRandam_Int(1, 100)
    f3_arg1:AddSubGoal(GOAL_COMMON_ComboAttackTunableSpin, 10, f3_local8, TARGET_ENE_0, 9999, f3_local14, f3_local15, 0, 0)
    f3_arg1:AddSubGoal(GOAL_COMMON_ComboRepeat, 10, f3_local9, TARGET_ENE_0, 9999, 0, 0)
    f3_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, f3_local10, TARGET_ENE_0, 9999, 0, 0)
    local f3_local17 = f3_arg0:GetRandam_Float(1.5, 2)
    local f3_local18 = f3_arg0:GetRandam_Int(60, 75)
    local f3_local19 = 5
    if SpaceCheck(f3_arg0, f3_arg1, 180, 1) == true then
        f3_arg1:AddSubGoal(GOAL_COMMON_LeaveTarget, f3_local17, TARGET_ENE_0, f3_local19, TARGET_ENE_0, true, -1)
    elseif SpaceCheck(f3_arg0, f3_arg1, 90, 1) == true and SpaceCheck(f3_arg0, f3_arg1, -90, 1) == true then
        if f3_local16 <= 50 then
            f3_arg1:AddSubGoal(GOAL_COMMON_SidewayMove, f3_local17, TARGET_ENE_0, 1, f3_local18, true, true, -1)
        else
            f3_arg1:AddSubGoal(GOAL_COMMON_SidewayMove, f3_local17, TARGET_ENE_0, 0, f3_local18, true, true, -1)
        end
    elseif SpaceCheck(f3_arg0, f3_arg1, 90, 1) == true and SpaceCheck(f3_arg0, f3_arg1, -90, 1) == false then
        f3_arg1:AddSubGoal(GOAL_COMMON_SidewayMove, f3_local17, TARGET_ENE_0, 1, f3_local18, true, true, -1)
    else
        f3_arg1:AddSubGoal(GOAL_COMMON_SidewayMove, f3_local17, TARGET_ENE_0, 0, f3_local18, true, true, -1)
    end
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act09 = function (f4_arg0, f4_arg1, f4_arg2)
    local f4_local0 = f4_arg0:GetDist(TARGET_ENE_0)
    local f4_local1 = 10.9 - f4_arg0:GetMapHitRadius(TARGET_SELF)
    local f4_local2 = 10.9 - f4_arg0:GetMapHitRadius(TARGET_SELF) + 0
    local f4_local3 = 10.9 - f4_arg0:GetMapHitRadius(TARGET_SELF) + 2
    local f4_local4 = 100
    local f4_local5 = 0
    local f4_local6 = 1.5
    local f4_local7 = 3
    Approach_Act_Flex(f4_arg0, f4_arg1, f4_local1, f4_local2, f4_local3, f4_local4, f4_local5, f4_local6, f4_local7)
    local f4_local8 = 3025
    local f4_local9 = 5 - f4_arg0:GetMapHitRadius(TARGET_SELF)
    local f4_local10 = 0
    local f4_local11 = 0
    local f4_local12 = f4_arg0:GetRandam_Int(1, 100)
    f4_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 10, f4_local8, TARGET_ENE_0, f4_local9, f4_local10, f4_local11, 0, 0)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act10 = function (f5_arg0, f5_arg1, f5_arg2)
    local f5_local0 = 3018
    local f5_local1 = 5 - f5_arg0:GetMapHitRadius(TARGET_SELF)
    local f5_local2 = 0
    local f5_local3 = 0
    local f5_local4 = f5_arg0:GetRandam_Int(1, 100)
    f5_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 10, f5_local0, TARGET_ENE_0, f5_local1, f5_local2, f5_local3, 0, 0)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act11 = function (f6_arg0, f6_arg1, f6_arg2)
    local f6_local0 = f6_arg0:GetDist(TARGET_ENE_0)
    local f6_local1 = 4.8 - f6_arg0:GetMapHitRadius(TARGET_SELF)
    local f6_local2 = 4.8 - f6_arg0:GetMapHitRadius(TARGET_SELF) + 0
    local f6_local3 = 4.8 - f6_arg0:GetMapHitRadius(TARGET_SELF) + 2
    local f6_local4 = 100
    local f6_local5 = 0
    local f6_local6 = 1.5
    local f6_local7 = 3
    Approach_Act_Flex(f6_arg0, f6_arg1, f6_local1, f6_local2, f6_local3, f6_local4, f6_local5, f6_local6, f6_local7)
    local f6_local8 = 3030
    local f6_local9 = 3026
    local f6_local10 = 3027
    local f6_local11 = 4.8 - f6_arg0:GetMapHitRadius(TARGET_SELF)
    local f6_local12 = 4.8 - f6_arg0:GetMapHitRadius(TARGET_SELF)
    local f6_local13 = 5 - f6_arg0:GetMapHitRadius(TARGET_SELF)
    local f6_local14 = 0
    local f6_local15 = 0
    local f6_local16 = f6_arg0:GetRandam_Int(1, 100)
    f6_arg1:AddSubGoal(GOAL_COMMON_ComboAttackTunableSpin, 10, f6_local8, TARGET_ENE_0, 9999, f6_local14, f6_local15, 0, 0)
    f6_arg1:AddSubGoal(GOAL_COMMON_ComboRepeat, 10, f6_local9, TARGET_ENE_0, 9999, 0, 0)
    f6_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, f6_local10, TARGET_ENE_0, 9999, 0, 0)
    
end

Goal.Act21 = function (f7_arg0, f7_arg1, f7_arg2)
    local f7_local0 = 3
    local f7_local1 = 45
    f7_arg1:AddSubGoal(GOAL_COMMON_Turn, f7_local0, TARGET_ENE_0, f7_local1, -1, GOAL_RESULT_Success, true)
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
    
end

Goal.Act22 = function (f8_arg0, f8_arg1, f8_arg2)
    local f8_local0 = 3
    local f8_local1 = 0
    local f8_local2 = 3
    if InsideRange(f8_arg0, f8_arg1, 90, 180, -9999, 9999) then
        f8_arg1:AddSubGoal(GOAL_COMMON_SpinStep, f8_local0, 5202, TARGET_ENE_0, f8_local1, AI_DIR_TYPE_L, f8_local2)
    elseif InsideRange(f8_arg0, f8_arg1, -90, 180, -9999, 9999) then
        f8_arg1:AddSubGoal(GOAL_COMMON_SpinStep, f8_local0, 5203, TARGET_ENE_0, f8_local1, AI_DIR_TYPE_R, f8_local2)
    end
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
    
end

Goal.Act23 = function (f9_arg0, f9_arg1, f9_arg2)
    local f9_local0 = f9_arg0:GetDist(TARGET_ENE_0)
    local f9_local1 = f9_arg0:GetSp(TARGET_SELF)
    local f9_local2 = 20
    local f9_local3 = f9_arg0:GetRandam_Int(1, 100)
    local f9_local4 = -1
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
    f9_arg0:SetNumber(NUMBER_SIDEWAY_DIRECTION, f9_local5)
    f9_arg1:AddSubGoal(GOAL_COMMON_SidewayMove, f9_local6, TARGET_ENE_0, f9_local5, f9_local7, true, true, f9_local4)
    f9_arg0:SetTimer(0, 20)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act24 = function (f10_arg0, f10_arg1, f10_arg2)
    local f10_local0 = 3
    local f10_local1 = 0
    local f10_local2 = 3
    f10_arg1:AddSubGoal(GOAL_COMMON_SpinStep, f10_local0, 5201, TARGET_ENE_0, f10_local1, AI_DIR_TYPE_B, f10_local2)
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
    
end

Goal.Act25 = function (f11_arg0, f11_arg1, f11_arg2)
    local f11_local0 = f11_arg0:GetRandam_Float(3, 5)
    local f11_local1 = 5
    f11_arg1:AddSubGoal(GOAL_COMMON_LeaveTarget, f11_local0, TARGET_ENE_0, f11_local1, TARGET_ENE_0, true, -1)
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
    
end

Goal.Act26 = function (f12_arg0, f12_arg1, f12_arg2)
    f12_arg1:AddSubGoal(GOAL_COMMON_Wait, 0.5, TARGET_ENE_0, 0, 0, 0)
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
    
end

Goal.Act27 = function (f13_arg0, f13_arg1, f13_arg2)
    local f13_local0 = f13_arg0:GetRandam_Int(1, 100)
    if YousumiAct_SubGoal(f13_arg0, f13_arg1, true, 60, 30) == false then
        GetWellSpace_Odds = 0
        return GetWellSpace_Odds
    end
    local f13_local1 = 0
    local f13_local2 = SpaceCheck_SidewayMove(f13_arg0, f13_arg1, 1)
    if f13_local2 == 0 then
        f13_local1 = 0
    elseif f13_local2 == 1 then
        f13_local1 = 1
    elseif f13_local2 == 2 then
        if f13_local0 <= 50 then
            f13_local1 = 0
        else
            f13_local1 = 1
        end
    else
        f13_arg1:AddSubGoal(GOAL_COMMON_Wait, 1, TARGET_SELF, 0, 0, 0)
        GetWellSpace_Odds = 0
        return GetWellSpace_Odds
    end
    f13_arg0:SetNumber(10, f13_local1)
    f13_arg1:AddSubGoal(GOAL_COMMON_SidewayMove, 3, TARGET_ENE_0, f13_local1, f13_arg0:GetRandam_Int(30, 45), true, true, -1)
    return GET_WELL_SPACE_ODDS
    
end

Goal.Act28 = function (f14_arg0, f14_arg1, f14_arg2)
    local f14_local0 = f14_arg0:GetDist(TARGET_ENE_0)
    local f14_local1 = 1.5
    local f14_local2 = 1.5
    local f14_local3 = f14_arg0:GetRandam_Int(30, 45)
    local f14_local4 = -1
    local f14_local5 = f14_arg0:GetRandam_Int(0, 1)
    if f14_local0 <= 20 then
        f14_arg1:AddSubGoal(GOAL_COMMON_SidewayMove, f14_local1, TARGET_ENE_0, f14_local5, f14_local3, true, true, f14_local4)
    else
        f14_arg1:AddSubGoal(GOAL_COMMON_ApproachTarget, f14_local2, TARGET_ENE_0, 7, TARGET_SELF, true, -1)
    end
    
end

Goal.Act30 = function (f15_arg0, f15_arg1, f15_arg2)
    local f15_local0 = 0.3
    f15_arg1:AddSubGoal(GOAL_COMMON_ApproachTarget, f15_local0, TARGET_ENE_0, 0.1, TARGET_SELF, false, -1)
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
    
end

Goal.Act41 = function (f16_arg0, f16_arg1, f16_arg2)
    local f16_local0 = 3.5
    local f16_local1 = f16_arg0:GetRandam_Int(30, 45)
    local f16_local2 = 0
    if SpaceCheck(f16_arg0, f16_arg1, -90, 1) == true then
        if SpaceCheck(f16_arg0, f16_arg1, 90, 1) == true then
            if f16_arg0:IsInsideTarget(TARGET_ENE_0, AI_DIR_TYPE_R, 180) then
                f16_local2 = 0
            else
                f16_local2 = 1
            end
        else
            f16_local2 = 0
        end
    elseif SpaceCheck(f16_arg0, f16_arg1, 90, 1) == true then
        f16_local2 = 1
    else
    end
    f16_arg1:AddSubGoal(GOAL_COMMON_SidewayMove, f16_local0, TARGET_ENE_0, f16_local2, f16_local1, true, true, -1)
    return GETWELLSPACE_ODDS
    
end

Goal.Act45 = function (f17_arg0, f17_arg1, f17_arg2)
    f17_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 10, 3016, TARGET_ENE_0, SuccessDist, TurnTime, FrontAngle, 0, 0)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act46 = function (f18_arg0, f18_arg1, f18_arg2)
    f18_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 10, 3021, TARGET_ENE_0, SuccessDist, TurnTime, FrontAngle, 0, 0)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Interrupt = function (f19_arg0, f19_arg1, f19_arg2)
    local f19_local0 = f19_arg1:GetHpRate(TARGET_SELF)
    local f19_local1 = f19_arg1:GetDist(TARGET_ENE_0)
    local f19_local2 = f19_arg1:GetSp(TARGET_SELF)
    local f19_local3 = f19_arg1:GetSpecialEffectActivateInterruptType(0)
    if f19_arg1:IsLadderAct(TARGET_SELF) then
        return false
    end
    if not f19_arg1:HasSpecialEffectId(TARGET_SELF, 200004) then
        return false
    end
    if f19_arg1:IsInterupt(INTERUPT_ParryTiming) then
        return Common_Parry(f19_arg1, f19_arg2, 50, 0, 1)
    end
    if f19_arg1:IsInterupt(INTERUPT_Damaged) then
        return f19_arg0.Damaged(f19_arg1, f19_arg2)
    end
    if Interupt_PC_Break(f19_arg1) then
        f19_arg1:Replanning()
        return true
    end
    if f19_arg1:IsInterupt(INTERUPT_ActivateSpecialEffect) and f19_arg1:GetSpecialEffectActivateInterruptType(0) == 90 then
        f19_arg2:ClearSubGoal()
        f19_arg2:AddSubGoal(GOAL_COMMON_SidewayMove, 3, TARGET_ENE_0, f19_arg1:GetRandam_Int(0, 1), f19_arg1:GetRandam_Int(45, 60), true, true, -1)
        return true
    end
    if f19_arg1:IsInterupt(INTERUPT_Inside_ObserveArea) then
    end
    if f19_arg1:IsInterupt(INTERUPT_ShootImpact) and f19_arg0.ShootReaction(f19_arg1, f19_arg2) then
        return true
    end
    return false
    
end

Goal.ShootReaction = function (f20_arg0, f20_arg1)
    f20_arg1:ClearSubGoal()
    f20_arg1:AddSubGoal(GOAL_COMMON_EndureAttack, 0.1, 3100, TARGET_ENE_0, 9999, 0)
    return true
    
end

Goal.Kengeki_Activate = function (f21_arg0, f21_arg1, f21_arg2)
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
    if f21_local5 <= 0 then
    elseif f21_local0 == 200200 then
        f21_local1[3] = 100
    elseif f21_local0 == 200201 then
        f21_local1[3] = 100
    end
    f21_local2[3] = REGIST_FUNC(f21_arg1, f21_arg2, f21_arg0.Kengeki03)
    f21_local2[50] = REGIST_FUNC(f21_arg1, f21_arg2, f21_arg0.NoAction)
    local f21_local6 = REGIST_FUNC(f21_arg1, f21_arg2, f21_arg0.ActAfter_AdjustSpace)
    return Common_Kengeki_Activate(f21_arg1, f21_arg2, f21_local1, f21_local2, f21_local6, f21_local3)
    
end

Goal.Kengeki03 = function (f22_arg0, f22_arg1, f22_arg2)
    f22_arg1:ClearSubGoal()
    f22_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3055, TARGET_ENE_0, 9999, 0, 0)
    
end

Goal.NoAction = function (f23_arg0, f23_arg1, f23_arg2)
    return -1
    
end

Goal.ActAfter_AdjustSpace = function (f24_arg0, f24_arg1, f24_arg2)
    
end

Goal.Update = function (f25_arg0, f25_arg1, f25_arg2)
    return Update_Default_NoSubGoal(f25_arg0, f25_arg1, f25_arg2)
    
end

Goal.Terminate = function (f26_arg0, f26_arg1, f26_arg2)
    
end


