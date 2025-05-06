RegisterTableGoal(GOAL_SamuraiTaisho_102010_Battle, "GOAL_SamuraiTaisho_102010_Battle")
REGISTER_GOAL_NO_UPDATE(GOAL_SamuraiTaisho_102010_Battle, true)

Goal.Initialize = function (f1_arg0, f1_arg1, f1_arg2, f1_arg3)
    
end

Goal.Activate = function (f2_arg0, f2_arg1, f2_arg2)
    Init_Pseudo_Global(f2_arg1, f2_arg2)
    if f2_arg1:GetNumber(1) > 0 then
        f2_arg1:SetStringIndexedNumber("FirstAttackFlag", 1)
    end
    Set_ConsecutiveGuardCount_Interrupt(f2_arg1)
    if f2_arg0.Kengeki_Activate(f2_arg0, f2_arg1, f2_arg2) then
        return
    end
    local f2_local0 = {}
    local f2_local1 = {}
    local f2_local2 = {}
    Common_Clear_Param(f2_local0, f2_local1, f2_local2)
    local f2_local3 = f2_arg1:GetDist(TARGET_ENE_0)
    local f2_local4 = f2_arg1:GetExcelParam(AI_EXCEL_THINK_PARAM_TYPE__thinkAttr_doAdmirer)
    local f2_local5 = Check_ReachAttack(f2_arg1, 0)
    local f2_local6 = f2_arg1:GetNinsatsuNum()
    if Common_ActivateAct(f2_arg1, f2_arg2) then
    elseif f2_local5 ~= POSSIBLE_ATTACK then
        if f2_local4 == 1 and f2_arg1:GetTeamOrder(ORDER_TYPE_Role) == ROLE_TYPE_Kankyaku then
            f2_local0[27] = 100
        elseif f2_local4 == 1 and f2_arg1:GetTeamOrder(ORDER_TYPE_Role) == ROLE_TYPE_Torimaki then
            f2_local0[27] = 100
        elseif f2_local5 == UNREACH_ATTACK then
            f2_local0[27] = 100
        elseif f2_local5 == REACH_ATTACK_TARGET_HIGH_POSITION then
            f2_local0[1] = 100
            f2_local0[4] = 100
        elseif f2_local5 == REACH_ATTACK_TARGET_LOW_POSITION then
            f2_local0[1] = 100
        else
            f2_local0[27] = 100
        end
    elseif f2_local4 == 1 and f2_arg1:GetTeamOrder(ORDER_TYPE_Role) == ROLE_TYPE_Kankyaku then
        KankyakuAct(f2_arg1, f2_arg2)
    elseif f2_local4 == 1 and f2_arg1:GetTeamOrder(ORDER_TYPE_Role) == ROLE_TYPE_Torimaki then
        TorimakiAct(f2_arg1, f2_arg2, -1, 0)
    elseif f2_arg1:GetNumber(2) == 0 and f2_local6 == 2 then
        f2_local0[1] = 100
    elseif f2_arg1:GetNumber(3) == 0 and f2_local6 == 1 then
        f2_local0[1] = 100
    elseif f2_arg1:GetNumber(1) > 0 then
        f2_local0[23] = 100
        if f2_local3 <= 2 then
            f2_local0[24] = 200
            f2_local0[25] = 300
        end
        f2_local0[1] = 1
    elseif f2_local3 >= 7 then
        f2_local0[1] = 100
        f2_local0[2] = 200
        f2_local0[3] = 200
        f2_local0[4] = 0
    elseif f2_local3 >= 5 then
        f2_local0[1] = 100
        f2_local0[2] = 100
        f2_local0[3] = 100
        f2_local0[4] = 0
    elseif f2_local3 > 2 then
        f2_local0[1] = 100
        f2_local0[2] = 0
        f2_local0[3] = 100
        f2_local0[4] = 150
    else
        f2_local0[1] = 150
        f2_local0[2] = 0
        f2_local0[3] = 0
        f2_local0[4] = 150
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
    if f2_arg1:HasSpecialEffectId(TARGET_SELF, 200215) or f2_arg1:HasSpecialEffectId(TARGET_SELF, 200216) then
        f2_local0[23] = 0
        f2_local0[24] = 0
    end
    f2_local0[1] = SetCoolTime(f2_arg1, f2_arg2, 3000, 5, f2_local0[1], 1)
    f2_local0[2] = SetCoolTime(f2_arg1, f2_arg2, 3003, 8, f2_local0[2], 1)
    f2_local0[3] = SetCoolTime(f2_arg1, f2_arg2, 3006, 5, f2_local0[3], 1)
    f2_local0[4] = SetCoolTime(f2_arg1, f2_arg2, 3007, 8, f2_local0[4], 1)
    f2_local0[5] = SetCoolTime(f2_arg1, f2_arg2, 3008, 8, f2_local0[5], 1)
    f2_local0[24] = SetCoolTime(f2_arg1, f2_arg2, 5201, 6, f2_local0[24], 1)
    f2_local0[24] = SetCoolTime(f2_arg1, f2_arg2, 5211, 6, f2_local0[24], 1)
    f2_local1[1] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act01)
    f2_local1[2] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act02)
    f2_local1[3] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act03)
    f2_local1[4] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act04)
    f2_local1[21] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act21)
    f2_local1[23] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act23)
    f2_local1[24] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act24)
    f2_local1[25] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act25)
    f2_local1[26] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act26)
    f2_local1[27] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act27)
    f2_local1[28] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act28)
    local f2_local7 = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.ActAfter_AdjustSpace)
    Common_Battle_Activate(f2_arg1, f2_arg2, f2_local0, f2_local1, f2_local7, f2_local2)
    
end

Goal.Act01 = function (f3_arg0, f3_arg1, f3_arg2)
    local f3_local0 = f3_arg0:GetDist(TARGET_ENE_0)
    local f3_local1 = 4 - f3_arg0:GetMapHitRadius(TARGET_SELF)
    local f3_local2 = 4 - f3_arg0:GetMapHitRadius(TARGET_SELF) + 0
    local f3_local3 = 4 - f3_arg0:GetMapHitRadius(TARGET_SELF) + 999
    local f3_local4 = 0
    local f3_local5 = 0
    local f3_local6 = 1.5
    local f3_local7 = 3
    local f3_local8 = f3_arg0:GetNinsatsuNum()
    if f3_arg0:GetStringIndexedNumber("FirstAttackFlag") == 0 then
        f3_local4 = 100
    end
    Approach_Act_Flex(f3_arg0, f3_arg1, f3_local1, f3_local2, f3_local3, f3_local4, f3_local5, f3_local6, f3_local7)
    local f3_local9 = 3000
    local f3_local10 = 3001
    local f3_local11 = 3002
    local f3_local12 = 3.5 - f3_arg0:GetMapHitRadius(TARGET_SELF)
    local f3_local13 = 5.8 - f3_arg0:GetMapHitRadius(TARGET_SELF)
    local f3_local14 = 0
    local f3_local15 = 0
    if f3_local8 == 2 then
        f3_arg1:AddSubGoal(GOAL_COMMON_ComboAttackTunableSpin, 10, f3_local9, TARGET_ENE_0, f3_local12, f3_local14, f3_local15, 0, 0):TimingSetNumber(1, f3_arg0:GetNumber(1) + 1, AI_TIMING_SET__ACTIVATE):TimingSetNumber(2, 1, AI_TIMING_SET__ACTIVATE)
    else
        f3_arg1:AddSubGoal(GOAL_COMMON_ComboAttackTunableSpin, 10, f3_local9, TARGET_ENE_0, f3_local12, f3_local14, f3_local15, 0, 0):TimingSetNumber(1, f3_arg0:GetNumber(1) + 1, AI_TIMING_SET__ACTIVATE):TimingSetNumber(3, 1, AI_TIMING_SET__ACTIVATE)
    end
    f3_arg1:AddSubGoal(GOAL_COMMON_ComboRepeat, 10, f3_local10, TARGET_ENE_0, f3_local13, 0):TimingSetNumber(1, f3_arg0:GetNumber(1) + 2, AI_TIMING_SET__ACTIVATE)
    f3_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, f3_local11, TARGET_ENE_0, 9999, 0, 0):TimingSetNumber(1, f3_arg0:GetNumber(1) + 3, AI_TIMING_SET__ACTIVATE)
    return 0
    
end

Goal.Act02 = function (f4_arg0, f4_arg1, f4_arg2)
    local f4_local0 = f4_arg0:GetDist(TARGET_ENE_0)
    local f4_local1 = 5 - f4_arg0:GetMapHitRadius(TARGET_SELF)
    local f4_local2 = 5 - f4_arg0:GetMapHitRadius(TARGET_SELF) + 0
    local f4_local3 = 5 - f4_arg0:GetMapHitRadius(TARGET_SELF) + 999
    local f4_local4 = 0
    local f4_local5 = 0
    local f4_local6 = 1.5
    local f4_local7 = 3
    if f4_arg0:GetStringIndexedNumber("FirstAttackFlag") == 0 then
        f4_local4 = 100
    end
    Approach_Act_Flex(f4_arg0, f4_arg1, f4_local1, f4_local2, f4_local3, f4_local4, f4_local5, f4_local6, f4_local7)
    local f4_local8 = 3003
    local f4_local9 = 0
    local f4_local10 = 0
    f4_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 10, f4_local8, TARGET_ENE_0, 9999, f4_local9, f4_local10, 0, 0):TimingSetNumber(1, f4_arg0:GetNumber(1) + 3, AI_TIMING_SET__ACTIVATE)
    return 0
    
end

Goal.Act03 = function (f5_arg0, f5_arg1, f5_arg2)
    local f5_local0 = f5_arg0:GetDist(TARGET_ENE_0)
    local f5_local1 = 5.6 - f5_arg0:GetMapHitRadius(TARGET_SELF)
    local f5_local2 = 5.6 - f5_arg0:GetMapHitRadius(TARGET_SELF) + 0
    local f5_local3 = 5.6 - f5_arg0:GetMapHitRadius(TARGET_SELF) + 999
    local f5_local4 = 0
    local f5_local5 = 0
    local f5_local6 = 1.5
    local f5_local7 = 3
    if f5_arg0:GetStringIndexedNumber("FirstAttackFlag") == 0 then
        f5_local4 = 100
    end
    Approach_Act_Flex(f5_arg0, f5_arg1, f5_local1, f5_local2, f5_local3, f5_local4, f5_local5, f5_local6, f5_local7)
    local f5_local8 = 3006
    local f5_local9 = 0
    local f5_local10 = 0
    f5_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 10, f5_local8, TARGET_ENE_0, 9999, f5_local9, f5_local10, 0, 0):TimingSetNumber(1, f5_arg0:GetNumber(1) + 3, AI_TIMING_SET__ACTIVATE)
    
end

Goal.Act04 = function (f6_arg0, f6_arg1, f6_arg2)
    local f6_local0 = f6_arg0:GetDist(TARGET_ENE_0)
    local f6_local1 = 4 - f6_arg0:GetMapHitRadius(TARGET_SELF)
    local f6_local2 = 4 - f6_arg0:GetMapHitRadius(TARGET_SELF) + 0
    local f6_local3 = 4 - f6_arg0:GetMapHitRadius(TARGET_SELF) + 999
    local f6_local4 = 0
    local f6_local5 = 0
    local f6_local6 = 1.5
    local f6_local7 = 3
    if f6_arg0:GetStringIndexedNumber("FirstAttackFlag") == 0 then
        f6_local4 = 100
    end
    Approach_Act_Flex(f6_arg0, f6_arg1, f6_local1, f6_local2, f6_local3, f6_local4, f6_local5, f6_local6, f6_local7)
    local f6_local8 = 3007
    local f6_local9 = 0
    local f6_local10 = 0
    f6_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 10, f6_local8, TARGET_ENE_0, 9999, f6_local9, f6_local10, 0, 0):TimingSetNumber(1, f6_arg0:GetNumber(1) + 2, AI_TIMING_SET__ACTIVATE)
    return 0
    
end

Goal.Act05 = function (f7_arg0, f7_arg1, f7_arg2)
    local f7_local0 = f7_arg0:GetDist(TARGET_ENE_0)
    local f7_local1 = 2.5 - f7_arg0:GetMapHitRadius(TARGET_SELF)
    local f7_local2 = 2.5 - f7_arg0:GetMapHitRadius(TARGET_SELF) + 0
    local f7_local3 = 2.5 - f7_arg0:GetMapHitRadius(TARGET_SELF) + 999
    local f7_local4 = 0
    local f7_local5 = 0
    local f7_local6 = 1.5
    local f7_local7 = 3
    if f7_arg0:GetStringIndexedNumber("FirstAttackFlag") == 0 then
        f7_local4 = 100
    end
    Approach_Act_Flex(f7_arg0, f7_arg1, f7_local1, f7_local2, f7_local3, f7_local4, f7_local5, f7_local6, f7_local7)
    local f7_local8 = 3008
    local f7_local9 = 3009
    local f7_local10 = 3067
    local f7_local11 = 3.8 - f7_arg0:GetMapHitRadius(TARGET_SELF)
    local f7_local12 = 0
    local f7_local13 = 0
    local f7_local14 = f7_arg0:GetRandam_Int(1, 100)
    f7_arg1:AddSubGoal(GOAL_COMMON_ComboAttackTunableSpin, 10, f7_local8, TARGET_ENE_0, f7_local11, f7_local12, f7_local13, 0, 0):TimingSetNumber(1, f7_arg0:GetNumber(1) + 1, AI_TIMING_SET__ACTIVATE)
    if f7_local14 <= 40 then
        f7_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, f7_local10, TARGET_ENE_0, 9999, 0, 0):TimingSetNumber(1, f7_arg0:GetNumber(1) + 2, AI_TIMING_SET__ACTIVATE)
    else
        f7_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, f7_local9, TARGET_ENE_0, 9999, 0, 0):TimingSetNumber(1, f7_arg0:GetNumber(1) + 2, AI_TIMING_SET__ACTIVATE)
    end
    return 0
    
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
    local f9_local1 = f9_arg0:GetNinsatsuNum()
    local f9_local2 = f9_arg0:GetSpRate(TARGET_SELF)
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
    local f9_local6 = f9_arg0:GetRandam_Int(30, 45)
    if f9_local1 <= 1 and f9_local3 <= 50 then
        f9_local4 = 9910
    end
    f9_arg0:SetNumber(10, f9_local5)
    f9_arg1:AddSubGoal(GOAL_COMMON_SidewayMove, 3, TARGET_ENE_0, f9_local5, f9_local6, true, true, f9_local4):TimingSetNumber(1, 0, AI_TIMING_SET__ACTIVATE)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act24 = function (f10_arg0, f10_arg1, f10_arg2)
    local f10_local0 = f10_arg0:GetDist(TARGET_ENE_0)
    local f10_local1 = 3
    local f10_local2 = 0
    local f10_local3 = 5201
    local f10_local4 = f10_arg0:GetNinsatsuNum()
    local f10_local5 = f10_arg0:GetSp(TARGET_SELF)
    local f10_local6 = -1
    local f10_local7 = f10_arg0:GetRandam_Int(1, 100)
    if SpaceCheck(f10_arg0, f10_arg1, 180, 2) ~= true or SpaceCheck(f10_arg0, f10_arg1, 180, 4) ~= true or f10_local0 > 4 then
    else
        f10_local3 = 5211
        if false then
        else
        end
    end
    f10_arg1:AddSubGoal(GOAL_COMMON_SpinStep, f10_local1, f10_local3, TARGET_ENE_0, f10_local2, AI_DIR_TYPE_B, 0):TimingSetTimer(1, 6, AI_TIMING_SET__ACTIVATE)
    local f10_local8 = 0
    if SpaceCheck(f10_arg0, f10_arg1, -90, 1) == true then
        if SpaceCheck(f10_arg0, f10_arg1, 90, 1) == true then
            if f10_arg0:IsInsideTargetEx(TARGET_ENE_0, TARGET_SELF, AI_DIR_TYPE_R, 180, 999) then
                f10_local8 = 1
            else
                f10_local8 = 0
            end
        else
            f10_local8 = 0
        end
    elseif SpaceCheck(f10_arg0, f10_arg1, 90, 1) == true then
        f10_local8 = 1
    else
    end
    local f10_local9 = f10_arg0:GetRandam_Int(30, 45)
    f10_arg0:SetNumber(10, f10_local8)
    if f10_local4 <= 1 then
        f10_local6 = 9910
    end
    f10_arg1:AddSubGoal(GOAL_COMMON_SidewayMove, 3, TARGET_ENE_0, f10_local8, f10_local9, true, true, f10_local6):TimingSetNumber(1, 0, AI_TIMING_SET__ACTIVATE)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act25 = function (f11_arg0, f11_arg1, f11_arg2)
    local f11_local0 = f11_arg0:GetRandam_Float(2, 4)
    local f11_local1 = f11_arg0:GetRandam_Float(5, 7)
    local f11_local2 = f11_arg0:GetDist(TARGET_ENE_0)
    local f11_local3 = f11_arg0:GetNinsatsuNum()
    local f11_local4 = f11_arg0:GetRandam_Int(1, 100)
    local f11_local5 = -1
    if f11_local3 <= 1 and f11_local4 <= 50 then
        f11_local5 = 9910
    end
    f11_arg1:AddSubGoal(GOAL_COMMON_LeaveTarget, f11_local0, TARGET_ENE_0, f11_local1, TARGET_ENE_0, true, f11_local5):TimingSetNumber(1, 0, AI_TIMING_SET__ACTIVATE)
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
    
end

Goal.Act26 = function (f12_arg0, f12_arg1, f12_arg2)
    f12_arg1:AddSubGoal(GOAL_COMMON_Wait, 0.5, TARGET_SELF, 0, 0, 0):TimingSetNumber(1, 0, AI_TIMING_SET__ACTIVATE)
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
    f13_arg0:SetNumber(1, 0)
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
    
end

Goal.Act28 = function (f14_arg0, f14_arg1, f14_arg2)
    local f14_local0 = f14_arg0:GetDist(TARGET_ENE_0)
    local f14_local1 = 1.5
    local f14_local2 = 1.5
    local f14_local3 = f14_arg0:GetRandam_Int(30, 45)
    local f14_local4 = -1
    local f14_local5 = f14_arg0:GetRandam_Int(0, 1)
    if f14_local0 <= 3 then
        f14_arg1:AddSubGoal(GOAL_COMMON_SidewayMove, f14_local1, TARGET_ENE_0, f14_local5, f14_local3, true, true, f14_local4)
    elseif f14_local0 <= 8 then
        f14_arg1:AddSubGoal(GOAL_COMMON_ApproachTarget, f14_local2, TARGET_ENE_0, 3, TARGET_SELF, true, -1)
    else
        f14_arg1:AddSubGoal(GOAL_COMMON_ApproachTarget, f14_local2, TARGET_ENE_0, 8, TARGET_SELF, true, -1)
    end
    f14_arg0:SetNumber(1, 0)
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
    
end

Goal.Interrupt = function (f15_arg0, f15_arg1, f15_arg2)
    local f15_local0 = f15_arg1:GetSpecialEffectActivateInterruptType(0)
    if f15_arg1:IsLadderAct(TARGET_SELF) then
        return false
    end
    if not f15_arg1:HasSpecialEffectId(TARGET_SELF, 200004) then
        return false
    end
    if f15_arg1:IsInterupt(INTERUPT_ParryTiming) then
        return f15_arg0.Parry(f15_arg1, f15_arg2, 50, 0)
    end
    if f15_arg1:IsInterupt(INTERUPT_Shoot) then
        return f15_arg0.ShootReaction(f15_arg1, f15_arg2)
    end
    if f15_arg1:IsInterupt(INTERUPT_Damaged) then
        return f15_arg0.Damaged(f15_arg1, f15_arg2)
    end
    return false
    
end

Goal.Parry = function (f16_arg0, f16_arg1, f16_arg2, f16_arg3)
    local f16_local0 = f16_arg0:GetDist(TARGET_ENE_0)
    local f16_local1 = GetDist_Parry(f16_arg0)
    local f16_local2 = f16_arg0:GetRandam_Int(1, 100)
    local f16_local3 = f16_arg0:GetRandam_Int(1, 100)
    local f16_local4 = f16_arg0:GetRandam_Int(1, 100)
    local f16_local5 = f16_arg0:HasSpecialEffectId(TARGET_ENE_0, 109970)
    local f16_local6 = f16_arg0:HasSpecialEffectId(TARGET_ENE_0, COMMON_SP_EFFECT_PC_ATTACK_RUSH)
    local f16_local7 = -1
    if f16_arg0:HasSpecialEffectId(TARGET_SELF, 221000) then
        f16_local7 = 0
    elseif f16_arg0:HasSpecialEffectId(TARGET_SELF, 221001) then
        f16_local7 = 1
    elseif f16_arg0:HasSpecialEffectId(TARGET_SELF, 221002) then
        f16_local7 = 2
    end
    if f16_arg0:IsFinishTimer(AI_TIMER_PARRY_INTERVAL) == false then
        return false
    end
    if f16_local7 == -1 then
        return false
    end
    if f16_arg0:HasSpecialEffectId(TARGET_SELF, 220062) then
        return false
    end
    if f16_arg0:HasSpecialEffectId(TARGET_ENE_0, 110450) or f16_arg0:HasSpecialEffectId(TARGET_ENE_0, 110501) or f16_arg0:HasSpecialEffectId(TARGET_ENE_0, 110500) then
        return false
    end
    f16_arg0:SetTimer(AI_TIMER_PARRY_INTERVAL, 0.1)
    if f16_arg0:IsInsideTarget(TARGET_ENE_0, AI_DIR_TYPE_F, 90) and f16_arg0:IsInsideTargetEx(TARGET_ENE_0, TARGET_SELF, AI_DIR_TYPE_F, 90, f16_local1) then
        if f16_local6 then
            f16_arg1:ClearSubGoal()
            f16_arg1:AddSubGoal(GOAL_COMMON_EndureAttack, 0.3, 3102, TARGET_ENE_0, 9999, 0)
            return true
        elseif f16_local5 then
            if f16_arg0:IsTargetGuard(TARGET_SELF) and ReturnKengekiSpecialEffect(f16_arg0) == false then
                return false
            elseif f16_local7 == 2 then
                return false
            elseif f16_local7 == 1 then
                if f16_local2 <= 50 then
                    f16_arg1:ClearSubGoal()
                    f16_arg1:AddSubGoal(GOAL_COMMON_EndureAttack, 0.3, 3101, TARGET_ENE_0, 9999, 0)
                    return true
                end
            elseif f16_local7 == 0 and f16_local2 <= 100 then
                f16_arg1:ClearSubGoal()
                f16_arg1:AddSubGoal(GOAL_COMMON_EndureAttack, 0.3, 3101, TARGET_ENE_0, 9999, 0)
                return true
            end
        elseif f16_arg0:HasSpecialEffectId(TARGET_ENE_0, 109980) then
            f16_arg1:ClearSubGoal()
            f16_arg1:AddSubGoal(GOAL_COMMON_SpinStep, 1, 5211, TARGET_ENE_0, 0, AI_DIR_TYPE_B, 0)
            return true
        elseif f16_local3 <= Get_ConsecutiveGuardCount(f16_arg0) * f16_arg2 then
            f16_arg1:ClearSubGoal()
            f16_arg1:AddSubGoal(GOAL_COMMON_EndureAttack, 0.3, 3101, TARGET_ENE_0, 9999, 0)
            return true
        else
            f16_arg1:ClearSubGoal()
            f16_arg1:AddSubGoal(GOAL_COMMON_EndureAttack, 0.3, 3100, TARGET_ENE_0, 9999, 0)
            return true
        end
    elseif f16_local1 <= 4 and f16_arg0:IsInsideTargetEx(TARGET_ENE_0, TARGET_SELF, AI_DIR_TYPE_F, 90, 5) then
        if f16_local4 <= 67 and f16_arg0:GetNinsatsuNum() <= 1 then
            f16_arg1:ClearSubGoal()
            f16_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 1, 3007, TARGET_ENE_0, 9999, 0, 0, 0, 0)
            return true
        else
            return false
        end
    end
    return false
    
end

Goal.Damaged = function (f17_arg0, f17_arg1, f17_arg2)
    local f17_local0 = 3
    if SpaceCheck(f17_arg0, f17_arg1, 180, 2) and f17_arg0:IsFinishTimer(1) then
        f17_arg1:ClearSubGoal()
        f17_arg1:AddSubGoal(GOAL_COMMON_SpinStep, f17_local0, 5201, TARGET_ENE_0, 0, AI_DIR_TYPE_B, 0):TimingSetTimer(1, 6, AI_TIMING_SET__ACTIVATE)
        return true
    end
    return false
    
end

Goal.ShootReaction = function (f18_arg0, f18_arg1)
    local f18_local0 = f18_arg0:GetDist(TARGET_ENE_0)
    if f18_arg0:IsInsideTargetEx(TARGET_ENE_0, TARGET_SELF, AI_DIR_TYPE_F, 20, 999) then
        if f18_local0 <= 30 then
            f18_arg1:ClearSubGoal()
            f18_arg1:AddSubGoal(GOAL_COMMON_EndureAttack, 0.1, 3100, TARGET_ENE_0, 9999, 0)
            return true
        else
            f18_arg1:ClearSubGoal()
            f18_arg1:AddSubGoal(GOAL_COMMON_Wait, 0.3, TARGET_SELF, 0, 0, 0)
            f18_arg1:AddSubGoal(GOAL_COMMON_EndureAttack, 0.1, 3100, TARGET_ENE_0, 9999, 0)
            return true
        end
    end
    return false
    
end

Goal.Kengeki_Activate = function (f19_arg0, f19_arg1, f19_arg2)
    local f19_local0 = ReturnKengekiSpecialEffect(f19_arg1)
    if f19_local0 == 0 then
        return false
    end
    local f19_local1 = {}
    local f19_local2 = {}
    local f19_local3 = {}
    Common_Clear_Param(f19_local1, f19_local2, f19_local3)
    local f19_local4 = f19_arg1:GetDist(TARGET_ENE_0)
    local f19_local5 = f19_arg1:GetSp(TARGET_SELF)
    if f19_local0 == 200200 then
    elseif f19_local0 == 200201 then
    elseif f19_local0 == 200205 then
    elseif f19_local0 == 200206 then
    elseif f19_local0 == 200210 then
        if f19_local4 >= 3 then
        else
            f19_local1[5] = 300
        end
    elseif f19_local0 == 200211 then
        if f19_local4 >= 3 then
        else
            f19_local1[9] = 300
        end
    elseif f19_local0 == 200215 then
        if f19_local4 >= 3 then
        else
            f19_local1[8] = 150
            f19_local1[17] = 100
        end
    elseif f19_local0 ~= 200216 or f19_local4 >= 3 then
    else
        f19_local1[16] = 150
        goto basicblock_27
    end
    f19_local1[2] = SetCoolTime(f19_arg1, f19_arg2, 3054, 10, f19_local1[2], 1)
    f19_local1[7] = SetCoolTime(f19_arg1, f19_arg2, 3062, 5, f19_local1[7], 1)
    f19_local1[8] = SetCoolTime(f19_arg1, f19_arg2, 3083, 5, f19_local1[8], 1)
    f19_local1[11] = SetCoolTime(f19_arg1, f19_arg2, 3076, 5, f19_local1[11], 1)
    f19_local1[16] = SetCoolTime(f19_arg1, f19_arg2, 3088, 5, f19_local1[16], 1)
    f19_local1[17] = SetCoolTime(f19_arg1, f19_arg2, 3063, 5, f19_local1[17], 1)
    f19_local2[1] = REGIST_FUNC(f19_arg1, f19_arg2, f19_arg0.Kengeki01)
    f19_local2[3] = REGIST_FUNC(f19_arg1, f19_arg2, f19_arg0.Kengeki03)
    f19_local2[5] = REGIST_FUNC(f19_arg1, f19_arg2, f19_arg0.Kengeki05)
    f19_local2[6] = REGIST_FUNC(f19_arg1, f19_arg2, f19_arg0.Kengeki06)
    f19_local2[7] = REGIST_FUNC(f19_arg1, f19_arg2, f19_arg0.Kengeki07)
    f19_local2[8] = REGIST_FUNC(f19_arg1, f19_arg2, f19_arg0.Kengeki08)
    f19_local2[9] = REGIST_FUNC(f19_arg1, f19_arg2, f19_arg0.Kengeki09)
    f19_local2[10] = REGIST_FUNC(f19_arg1, f19_arg2, f19_arg0.Kengeki10)
    f19_local2[11] = REGIST_FUNC(f19_arg1, f19_arg2, f19_arg0.Kengeki11)
    f19_local2[16] = REGIST_FUNC(f19_arg1, f19_arg2, f19_arg0.Kengeki16)
    f19_local2[17] = REGIST_FUNC(f19_arg1, f19_arg2, f19_arg0.Kengeki17)
    f19_local2[21] = REGIST_FUNC(f19_arg1, f19_arg2, f19_arg0.Act21)
    f19_local2[23] = REGIST_FUNC(f19_arg1, f19_arg2, f19_arg0.Act23)
    f19_local2[24] = REGIST_FUNC(f19_arg1, f19_arg2, f19_arg0.Act24)
    f19_local2[25] = REGIST_FUNC(f19_arg1, f19_arg2, f19_arg0.Act25)
    f19_local2[50] = REGIST_FUNC(f19_arg1, f19_arg2, f19_arg0.NoAction)
    local f19_local6 = REGIST_FUNC(f19_arg1, f19_arg2, f19_arg0.ActAfter_AdjustSpace)
    return Common_Kengeki_Activate(f19_arg1, f19_arg2, f19_local1, f19_local2, f19_local6, f19_local3)
    
end

Goal.Kengeki01 = function (f20_arg0, f20_arg1, f20_arg2)
    f20_arg1:ClearSubGoal()
    f20_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 1, 3051, TARGET_ENE_0, 9999, 0, 0):TimingSetNumber(1, f20_arg0:GetNumber(1) + 1, AI_TIMING_SET__ACTIVATE)
    return 0
    
end

Goal.Kengeki03 = function (f21_arg0, f21_arg1, f21_arg2)
    f21_arg1:ClearSubGoal()
    f21_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 1, 3056, TARGET_ENE_0, 9999, 0, 0):TimingSetNumber(1, f21_arg0:GetNumber(1) + 1, AI_TIMING_SET__ACTIVATE)
    return 0
    
end

Goal.Kengeki05 = function (f22_arg0, f22_arg1, f22_arg2)
    f22_arg1:ClearSubGoal()
    f22_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 1, 3060, TARGET_ENE_0, 9999, 0, 0):TimingSetNumber(1, f22_arg0:GetNumber(1) + 1, AI_TIMING_SET__ACTIVATE)
    return 0
    
end

Goal.Kengeki06 = function (f23_arg0, f23_arg1, f23_arg2)
    f23_arg1:ClearSubGoal()
    f23_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 1, 3061, TARGET_ENE_0, 9999, 0, 0):TimingSetNumber(1, f23_arg0:GetNumber(1) + 1, AI_TIMING_SET__ACTIVATE)
    return 0
    
end

Goal.Kengeki07 = function (f24_arg0, f24_arg1, f24_arg2)
    f24_arg1:ClearSubGoal()
    f24_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 1, 3071, TARGET_ENE_0, 9999, 0, 0):TimingSetNumber(1, f24_arg0:GetNumber(1) + 1, AI_TIMING_SET__ACTIVATE)
    return 0
    
end

Goal.Kengeki08 = function (f25_arg0, f25_arg1, f25_arg2)
    f25_arg1:ClearSubGoal()
    f25_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 1, 3083, TARGET_ENE_0, 9999, 0, 0):TimingSetNumber(1, f25_arg0:GetNumber(1) + 2, AI_TIMING_SET__ACTIVATE)
    return 0
    
end

Goal.Kengeki09 = function (f26_arg0, f26_arg1, f26_arg2)
    f26_arg1:ClearSubGoal()
    f26_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 1, 3065, TARGET_ENE_0, 9999, 0, 0):TimingSetNumber(1, f26_arg0:GetNumber(1) + 1, AI_TIMING_SET__ACTIVATE)
    return 0
    
end

Goal.Kengeki10 = function (f27_arg0, f27_arg1, f27_arg2)
    f27_arg1:ClearSubGoal()
    f27_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 1, 3066, TARGET_ENE_0, 9999, 0, 0):TimingSetNumber(1, f27_arg0:GetNumber(1) + 1, AI_TIMING_SET__ACTIVATE)
    return 0
    
end

Goal.Kengeki11 = function (f28_arg0, f28_arg1, f28_arg2)
    f28_arg1:ClearSubGoal()
    f28_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 1, 3076, TARGET_ENE_0, 9999, 0, 0):TimingSetNumber(1, f28_arg0:GetNumber(1) + 1, AI_TIMING_SET__ACTIVATE)
    return 0
    
end

Goal.Kengeki16 = function (f29_arg0, f29_arg1, f29_arg2)
    f29_arg1:ClearSubGoal()
    f29_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 1, 3088, TARGET_ENE_0, 9999, 0, 0):TimingSetNumber(1, f29_arg0:GetNumber(1) + 2, AI_TIMING_SET__ACTIVATE)
    return 0
    
end

Goal.Kengeki17 = function (f30_arg0, f30_arg1, f30_arg2)
    f30_arg1:ClearSubGoal()
    f30_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 1, 3063, TARGET_ENE_0, 9999, 0, 0):TimingSetNumber(1, f30_arg0:GetNumber(1) + 2, AI_TIMING_SET__ACTIVATE)
    return 0
    
end

Goal.NoAction = function (f31_arg0, f31_arg1, f31_arg2)
    return -1
    
end

Goal.ActAfter_AdjustSpace = function (f32_arg0, f32_arg1, f32_arg2)
    
end

Goal.Update = function (f33_arg0, f33_arg1, f33_arg2)
    return Update_Default_NoSubGoal(f33_arg0, f33_arg1, f33_arg2)
    
end

Goal.Terminate = function (f34_arg0, f34_arg1, f34_arg2)
    
end


