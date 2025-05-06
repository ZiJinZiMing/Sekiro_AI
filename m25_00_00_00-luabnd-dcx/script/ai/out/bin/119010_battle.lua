RegisterTableGoal(GOAL_Taniteki_Sniper_119010_Battle, "GOAL_Taniteki_Sniper_119010_Battle")
REGISTER_GOAL_NO_UPDATE(GOAL_Taniteki_Sniper_119010_Battle, true)

Goal.Initialize = function (f1_arg0, f1_arg1, f1_arg2, f1_arg3)
    
end

Goal.Activate = function (f2_arg0, f2_arg1, f2_arg2)
    Init_Pseudo_Global(f2_arg1, f2_arg2)
    f2_arg1:SetStringIndexedNumber("Dist_Step_Small", 4)
    f2_arg1:SetStringIndexedNumber("Dist_Step_Large", 5)
    f2_arg1:SetStringIndexedNumber("KaihukuSp", 30)
    f2_arg1:DeleteObserve(0)
    f2_arg1:AddObserveSpecialEffectAttribute(TARGET_SELF, 5025)
    Set_ConsecutiveGuardCount_Interrupt(f2_arg1)
    local f2_local0 = {}
    local f2_local1 = {}
    local f2_local2 = {}
    Common_Clear_Param(f2_local0, f2_local1, f2_local2)
    local f2_local3 = f2_arg1:GetHpRate(TARGET_SELF)
    local f2_local4 = f2_arg1:GetSp(TARGET_SELF)
    local f2_local5 = f2_arg1:GetDist(TARGET_ENE_0)
    local f2_local6 = f2_arg1:GetExcelParam(AI_EXCEL_THINK_PARAM_TYPE__thinkAttr_doAdmirer)
    local f2_local7 = f2_arg1:GetEventRequest()
    local f2_local8 = 25 - f2_arg1:GetMapHitRadius(TARGET_SELF)
    local f2_local9 = 10 - f2_arg1:GetMapHitRadius(TARGET_SELF)
    local f2_local10 = 90
    local f2_local11 = f2_arg1:GetRandam_Int(5, 10)
    if f2_arg1:IsFinishTimer(1) == true then
        f2_arg1:SetNumber(6, 0)
    end
    if f2_arg0.Kengeki_Activate(f2_arg0, f2_arg1, f2_arg2) then
        return
    end
    if Common_ActivateAct(f2_arg1, f2_arg2) then
    elseif f2_local6 == 1 and f2_arg1:GetTeamOrder(ORDER_TYPE_Role) == ROLE_TYPE_Kankyaku then
        KankyakuAct(f2_arg1, f2_arg2)
    elseif f2_local6 == 1 and f2_arg1:GetTeamOrder(ORDER_TYPE_Role) == ROLE_TYPE_Torimaki then
        if TorimakiAct(f2_arg1, f2_arg2) then
            f2_local0[1] = 100
        end
    elseif f2_arg1:CheckDoesExistPath(TARGET_ENE_0, AI_DIR_TYPE_F, 0, 0) == false then
        f2_local0[27] = 1
        if f2_arg1:IsVisibleTarget(TARGET_ENE_0) then
            f2_local0[31] = 600000
        end
    elseif f2_arg1:IsInsideTarget(TARGET_ENE_0, AI_DIR_TYPE_B, 180) then
        f2_local0[21] = 100
    elseif f2_arg1:HasSpecialEffectId(TARGET_ENE_0, COMMON_SP_EFFECT_PC_BREAK) then
        if f2_local5 >= 5 then
            f2_local0[2] = 100
        else
            f2_local0[10] = 100
        end
    elseif f2_local5 >= 15 then
        f2_local0[1] = 150
        f2_local0[10] = 100
        f2_local0[23] = 50
    elseif f2_local5 >= 7 then
        f2_local0[1] = 200
        f2_local0[2] = 30
        f2_local0[10] = 130
        f2_local0[11] = 200
        f2_local0[23] = 100
    else
        f2_local0[1] = 0
        f2_local0[2] = 0
        f2_local0[10] = 130
        f2_local0[11] = 600
        f2_local0[12] = 130
        f2_local0[13] = 130
        f2_local0[24] = 10
    end
    if SpaceCheck(f2_arg1, f2_arg2, 90, 1) == false and SpaceCheck(f2_arg1, f2_arg2, -45, 1) == false then
        f2_local0[23] = 0
    end
    if SpaceCheck(f2_arg1, f2_arg2, 180, 5) == false then
        f2_local0[24] = 0
    end
    if SpaceCheck(f2_arg1, f2_arg2, 180, 1) == false then
        f2_local0[25] = 0
    end
    f2_local0[1] = SetCoolTime(f2_arg1, f2_arg2, 3000, 5, f2_local0[1], 1)
    f2_local0[5] = SetCoolTime(f2_arg1, f2_arg2, 3005, 3, f2_local0[5], 1)
    f2_local0[10] = SetCoolTime(f2_arg1, f2_arg2, 3010, 7, f2_local0[10], 1)
    f2_local0[11] = SetCoolTime(f2_arg1, f2_arg2, 3013, 35, f2_local0[11], 1)
    f2_local0[12] = SetCoolTime(f2_arg1, f2_arg2, 3015, 8, f2_local0[12], 1)
    f2_local0[13] = SetCoolTime(f2_arg1, f2_arg2, 3017, 10, f2_local0[13], 1)
    f2_local0[24] = SetCoolTime(f2_arg1, f2_arg2, 5211, 10, f2_local0[24], 1)
    f2_local0[24] = SetCoolTime(f2_arg1, f2_arg2, 5211, 10, f2_local0[24], 1)
    f2_local1[1] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act01)
    f2_local1[2] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act02)
    f2_local1[3] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act03)
    f2_local1[4] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act04)
    f2_local1[5] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act05)
    f2_local1[10] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act10)
    f2_local1[11] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act11)
    f2_local1[12] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act12)
    f2_local1[13] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act13)
    f2_local1[21] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act21)
    f2_local1[23] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act23)
    f2_local1[24] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act24)
    f2_local1[25] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act25)
    f2_local1[26] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act26)
    f2_local1[27] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act27)
    f2_local1[28] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act28)
    f2_local1[29] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act29)
    f2_local1[30] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act30)
    f2_local1[31] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act31)
    f2_local1[40] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act40)
    local f2_local12 = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.ActAfter_AdjustSpace)
    Common_Battle_Activate(f2_arg1, f2_arg2, f2_local0, f2_local1, f2_local12, f2_local2)
    
end

Goal.Act01 = function (f3_arg0, f3_arg1, f3_arg2)
    local f3_local0 = 3000
    local f3_local1 = 0
    local f3_local2 = 0
    f3_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 10, f3_local0, TARGET_ENE_0, 9999, f3_local1, f3_local2, 0, 0)

    f3_arg1:AddSubGoal(GOAL_COMMON_Wait, 5, TARGET_ENE_0 --[[TARGET_SELF]], 0, 0, 0)

    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act02 = function (f4_arg0, f4_arg1, f4_arg2)
    local f4_local0 = 3001
    local f4_local1 = 3005
    local f4_local2 = 3009
    local f4_local3 = 0
    local f4_local4 = 0
    local f4_local5 = f4_arg0:GetRandam_Int(1, 100)
    f4_arg1:AddSubGoal(GOAL_COMMON_ComboAttackTunableSpin, 10, f4_local0, TARGET_ENE_0, 9999, f4_local3, f4_local4, 0, 0)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act03 = function (f5_arg0, f5_arg1, f5_arg2)
    local f5_local0 = 3002
    local f5_local1 = 0
    local f5_local2 = 0
    f5_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 10, f5_local0, TARGET_ENE_0, 9999, f5_local1, f5_local2, 0, 0)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act04 = function (f6_arg0, f6_arg1, f6_arg2)
    local f6_local0 = 3003
    local f6_local1 = 0
    local f6_local2 = 0
    f6_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 10, f6_local0, TARGET_ENE_0, 9999, f6_local1, f6_local2, 0, 0)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act05 = function (f7_arg0, f7_arg1, f7_arg2)
    local f7_local0 = 3005
    local f7_local1 = 0
    local f7_local2 = 0
    local f7_local3 = f7_arg0:GetRandam_Int(1, 100)
    local f7_local4 = 3009
    f7_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 10, f7_local0, TARGET_ENE_0, 9999, f7_local1, f7_local2, 0, 0)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act10 = function (f8_arg0, f8_arg1, f8_arg2)
    local f8_local0 = f8_arg0:GetDist(TARGET_ENE_0)
    local f8_local1 = 4 - f8_arg0:GetMapHitRadius(TARGET_SELF)
    local f8_local2 = 4 - f8_arg0:GetMapHitRadius(TARGET_SELF) + 0
    local f8_local3 = 4 - f8_arg0:GetMapHitRadius(TARGET_SELF) + 2
    local f8_local4 = 100
    local f8_local5 = 0
    local f8_local6 = 1.5
    local f8_local7 = 3
    local f8_local8 = f8_arg0:GetDistYSigned(TARGET_ENE_0)
    if f8_local1 < f8_local0 then
        Approach_Act_Flex(f8_arg0, f8_arg1, f8_local1, f8_local2, f8_local3, f8_local4, f8_local5, f8_local6, f8_local7)
    end
    if f8_local8 >= 1.5 or f8_local8 <= -1.5 then
        f8_local1 = 0.3
    end
    local f8_local9 = 3010
    local f8_local10 = 3011
    local f8_local11 = 3012
    local f8_local12 = 3001
    local f8_local13 = 4 - f8_arg0:GetMapHitRadius(TARGET_SELF)
    local f8_local14 = 4.5 - f8_arg0:GetMapHitRadius(TARGET_SELF)
    local f8_local15 = 0
    local f8_local16 = 0
    local f8_local17 = f8_arg0:GetRandam_Int(1, 100)
    f8_arg0:SetNumber(1, f8_arg0:GetNumber(1) + 1)
    f8_arg1:AddSubGoal(GOAL_COMMON_ComboAttackTunableSpin, 10, f8_local9, TARGET_ENE_0, f8_local13, f8_local15, f8_local16, 0, 0)
    f8_arg1:AddSubGoal(GOAL_COMMON_ComboRepeat, 10, f8_local10, TARGET_ENE_0, f8_local14, 0)
    f8_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, f8_local11, TARGET_ENE_0, 9999, 0, 0)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act11 = function (f9_arg0, f9_arg1, f9_arg2)
    local f9_local0 = f9_arg0:GetDist(TARGET_ENE_0)
    local f9_local1 = 4.5 - f9_arg0:GetMapHitRadius(TARGET_SELF)
    local f9_local2 = 4.5 - f9_arg0:GetMapHitRadius(TARGET_SELF) + 0
    local f9_local3 = 4.5 - f9_arg0:GetMapHitRadius(TARGET_SELF) + 2
    local f9_local4 = 100
    local f9_local5 = 0
    local f9_local6 = 1.5
    local f9_local7 = 3
    local f9_local8 = f9_arg0:GetDistYSigned(TARGET_ENE_0)
    if f9_local1 < f9_local0 then
        Approach_Act_Flex(f9_arg0, f9_arg1, f9_local1, f9_local2, f9_local3, f9_local4, f9_local5, f9_local6, f9_local7)
    end
    if f9_local8 >= 1.5 or f9_local8 <= -1.5 then
        f9_local1 = 0.3
    end
    local f9_local9 = 3013
    local f9_local10 = 4.5 - f9_arg0:GetMapHitRadius(TARGET_SELF) + 1
    local f9_local11 = 0
    local f9_local12 = 0
    f9_arg0:SetNumber(1, f9_arg0:GetNumber(1) + 1)
    f9_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 10, f9_local9, TARGET_ENE_0, 9999, f9_local11, f9_local12, 0, 0)
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
    
end

Goal.Act12 = function (f10_arg0, f10_arg1, f10_arg2)
    local f10_local0 = f10_arg0:GetDist(TARGET_ENE_0)
    local f10_local1 = 4.5 - f10_arg0:GetMapHitRadius(TARGET_SELF)
    local f10_local2 = 4.5 - f10_arg0:GetMapHitRadius(TARGET_SELF) + 0
    local f10_local3 = 4.5 - f10_arg0:GetMapHitRadius(TARGET_SELF) + 2
    local f10_local4 = 100
    local f10_local5 = 0
    local f10_local6 = 1.5
    local f10_local7 = 3
    local f10_local8 = f10_arg0:GetDistYSigned(TARGET_ENE_0)
    if f10_local1 < f10_local0 then
        Approach_Act_Flex(f10_arg0, f10_arg1, f10_local1, f10_local2, f10_local3, f10_local4, f10_local5, f10_local6, f10_local7)
    end
    if f10_local8 >= 1.5 or f10_local8 <= -1.5 then
        f10_local1 = 0.3
    end
    local f10_local9 = 3015
    local f10_local10 = 3016
    local f10_local11 = 4.5 - f10_arg0:GetMapHitRadius(TARGET_SELF) + 1
    local f10_local12 = 0
    local f10_local13 = 0
    local f10_local14 = f10_arg0:GetRandam_Int(1, 100)
    local f10_local15 = 3009
    f10_arg0:SetNumber(1, f10_arg0:GetNumber(1) + 1)
    f10_arg1:AddSubGoal(GOAL_COMMON_ComboAttackTunableSpin, 10, f10_local9, TARGET_ENE_0, f10_local11, f10_local12, f10_local13, 0, 0)
    f10_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, f10_local10, TARGET_ENE_0, 9999, 0, 0)
    if f10_local14 <= 30 and SpaceCheck(f10_arg0, f10_arg1, 180, 4) == true then
        f10_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, f10_local15, TARGET_ENE_0, 9999, 0, 0)
    end
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
    
end

Goal.Act13 = function (f11_arg0, f11_arg1, f11_arg2)
    local f11_local0 = f11_arg0:GetDist(TARGET_ENE_0)
    local f11_local1 = 4.5 - f11_arg0:GetMapHitRadius(TARGET_SELF)
    local f11_local2 = 4.5 - f11_arg0:GetMapHitRadius(TARGET_SELF) + 0
    local f11_local3 = 4.5 - f11_arg0:GetMapHitRadius(TARGET_SELF) + 2
    local f11_local4 = 100
    local f11_local5 = 0
    local f11_local6 = 1.5
    local f11_local7 = 3
    local f11_local8 = f11_arg0:GetDistYSigned(TARGET_ENE_0)
    if f11_local1 < f11_local0 then
        Approach_Act_Flex(f11_arg0, f11_arg1, f11_local1, f11_local2, f11_local3, f11_local4, f11_local5, f11_local6, f11_local7)
    end
    if f11_local8 >= 1.5 or f11_local8 <= -1.5 then
        f11_local1 = 0.3
    end
    local f11_local9 = 3017
    local f11_local10 = 3018
    local f11_local11 = 3019
    local f11_local12 = 4.5 - f11_arg0:GetMapHitRadius(TARGET_SELF)
    local f11_local13 = 4.5 - f11_arg0:GetMapHitRadius(TARGET_SELF)
    local f11_local14 = 0
    local f11_local15 = 0
    local f11_local16 = f11_arg0:GetRandam_Int(1, 100)
    local f11_local17 = 3009
    f11_arg0:SetNumber(1, f11_arg0:GetNumber(1) + 1)
    f11_arg1:AddSubGoal(GOAL_COMMON_ComboAttackTunableSpin, 10, f11_local9, TARGET_ENE_0, f11_local12, f11_local14, f11_local15, 0, 0)
    f11_arg1:AddSubGoal(GOAL_COMMON_ComboRepeat, 10, f11_local10, TARGET_ENE_0, f11_local13, 0)
    f11_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, f11_local11, TARGET_ENE_0, 9999, 0, 0)
    if f11_local16 <= 30 and SpaceCheck(f11_arg0, f11_arg1, 180, 4) == true then
        f11_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, f11_local17, TARGET_ENE_0, 9999, 0, 0)
    end
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
    
end

Goal.Act21 = function (f12_arg0, f12_arg1, f12_arg2)
    local f12_local0 = 3
    local f12_local1 = 45
    f12_arg1:AddSubGoal(GOAL_COMMON_Turn, f12_local0, TARGET_ENE_0, f12_local1, -1, GOAL_RESULT_Success, true)
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
    
end

Goal.Act23 = function (f13_arg0, f13_arg1, f13_arg2)
    local f13_local0 = f13_arg0:GetDist(TARGET_ENE_0)
    local f13_local1 = f13_arg0:GetSp(TARGET_SELF)
    local f13_local2 = 20
    local f13_local3 = f13_arg0:GetRandam_Int(1, 100)
    local f13_local4 = -1
    local f13_local5 = 0
    if SpaceCheck(f13_arg0, f13_arg1, -90, 1) == true then
        if SpaceCheck(f13_arg0, f13_arg1, 90, 1) == true then
            if f13_arg0:IsInsideTargetEx(TARGET_ENE_0, TARGET_SELF, AI_DIR_TYPE_R, 180, 999) then
                f13_local5 = 1
            else
                f13_local5 = 0
            end
        else
            f13_local5 = 0
        end
    elseif SpaceCheck(f13_arg0, f13_arg1, 90, 1) == true then
        f13_local5 = 1
    else
    end
    local f13_local6 = 3
    local f13_local7 = f13_arg0:GetRandam_Int(30, 45)
    f13_arg0:SetNumber(NUMBER_SIDEWAY_DIRECTION, f13_local5)
    f13_arg1:AddSubGoal(GOAL_COMMON_SidewayMove, f13_local6, TARGET_ENE_0, f13_local5, f13_local7, true, true, f13_local4):TmiingSetTimer(2, 4, UPDATE_SUCCESS)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act24 = function (f14_arg0, f14_arg1, f14_arg2)
    local f14_local0 = f14_arg0:GetDist(TARGET_ENE_0)
    local f14_local1 = 3
    local f14_local2 = 0
    local f14_local3 = 5211
    if SpaceCheck(f14_arg0, f14_arg1, 180, 2) ~= true or SpaceCheck(f14_arg0, f14_arg1, 180, 4) ~= true or f14_local0 > 4 then
    else
        f14_local3 = 5211
        if false then
        else
        end
    end
    f14_arg1:AddSubGoal(GOAL_COMMON_SpinStep, f14_local1, f14_local3, TARGET_ENE_0, f14_local2, AI_DIR_TYPE_B, 0)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act25 = function (f15_arg0, f15_arg1, f15_arg2)
    local f15_local0 = f15_arg0:GetRandam_Float(1.5, 4)
    local f15_local1 = f15_arg0:GetRandam_Float(3, 4)
    local f15_local2 = f15_arg0:GetDist(TARGET_ENE_0)
    local f15_local3 = -1
    if SpaceCheck(f15_arg0, f15_arg1, 180, 1) == true then
        f15_arg1:AddSubGoal(GOAL_COMMON_LeaveTarget, f15_local0, TARGET_ENE_0, f15_local1, TARGET_ENE_0, true, f15_local3)
    else
        GetWellSpace_Odds = 100
        return GetWellSpace_Odds
    end
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
    
end

Goal.Act26 = function (f16_arg0, f16_arg1, f16_arg2)
    f16_arg1:AddSubGoal(GOAL_COMMON_Wait, 0.5, TARGET_SELF, 0, 0, 0)
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
    
end

Goal.Act27 = function (f17_arg0, f17_arg1, f17_arg2)
    local f17_local0 = f17_arg0:GetRandam_Int(1, 100)
    if YousumiAct_SubGoal(f17_arg0, f17_arg1, true, 60, 30) == false then
        GetWellSpace_Odds = 0
        return GetWellSpace_Odds
    end
    local f17_local1 = 0
    local f17_local2 = SpaceCheck_SidewayMove(f17_arg0, f17_arg1, 1)
    if f17_local2 == 0 then
        f17_local1 = 0
    elseif f17_local2 == 1 then
        f17_local1 = 1
    elseif f17_local2 == 2 then
        if f17_local0 <= 50 then
            f17_local1 = 0
        else
            f17_local1 = 1
        end
    else
        f17_arg1:AddSubGoal(GOAL_COMMON_Wait, 0.5, TARGET_SELF, 0, 0, 0)
        GetWellSpace_Odds = 0
        return GetWellSpace_Odds
    end
    f17_arg0:SetNumber(10, f17_local1)
    f17_arg1:AddSubGoal(GOAL_COMMON_SidewayMove, 3, TARGET_ENE_0, f17_local1, f17_arg0:GetRandam_Int(30, 45), true, true, -1)
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
    
end

Goal.Act28 = function (f18_arg0, f18_arg1, f18_arg2)
    local f18_local0 = f18_arg0:GetDist(TARGET_ENE_0)
    local f18_local1 = 1.5
    local f18_local2 = 1.5
    local f18_local3 = f18_arg0:GetRandam_Int(30, 45)
    local f18_local4 = -1
    local f18_local5 = f18_arg0:GetRandam_Int(0, 1)
    if f18_local0 <= 3 then
        f18_arg1:AddSubGoal(GOAL_COMMON_SidewayMove, f18_local1, TARGET_ENE_0, f18_local5, f18_local3, true, true, f18_local4)
    elseif f18_local0 <= 8 then
        f18_arg1:AddSubGoal(GOAL_COMMON_ApproachTarget, f18_local2, TARGET_ENE_0, 3, TARGET_SELF, true, -1)
    else
        f18_arg1:AddSubGoal(GOAL_COMMON_ApproachTarget, f18_local2, TARGET_ENE_0, 8, TARGET_SELF, false, -1)
    end
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
    
end

Goal.Act29 = function (f19_arg0, f19_arg1, f19_arg2)
    local f19_local0 = f19_arg0:GetDist(TARGET_ENE_0)
    local f19_local1 = 3
    local f19_local2 = 0
    local f19_local3 = 5211
    if SpaceCheck(f19_arg0, f19_arg1, 180, 2) == true and SpaceCheck(f19_arg0, f19_arg1, 180, 4) == true then
        f19_local3 = 5211
        if false then
        else
        end
    end
    f19_arg1:AddSubGoal(GOAL_COMMON_SpinStep, f19_local1, f19_local3, TARGET_ENE_0, f19_local2, AI_DIR_TYPE_B, 0)
    local f19_local4 = f19_arg0:GetDist(TARGET_ENE_0)
    local f19_local5 = f19_arg0:GetSp(TARGET_SELF)
    local f19_local6 = 20
    local f19_local7 = f19_arg0:GetRandam_Int(1, 100)
    local f19_local8 = -1
    if f19_local6 <= f19_local5 and f19_local7 <= 0 then
        f19_local8 = 9910
    end
    local f19_local9 = 0
    if SpaceCheck(f19_arg0, f19_arg1, -90, 1) == true then
        if SpaceCheck(f19_arg0, f19_arg1, 90, 1) == true then
            if f19_arg0:IsInsideTarget(TARGET_ENE_0, AI_DIR_TYPE_R, 180) then
                f19_local9 = 0
            else
                f19_local9 = 1
            end
        else
            f19_local9 = 0
        end
    elseif SpaceCheck(f19_arg0, f19_arg1, 90, 1) == true then
        f19_local9 = 1
    else
        GetWellSpace_Odds = 100
        return GetWellSpace_Odds
    end
    local f19_local10 = f19_arg0:GetRandam_Float(2, 4)
    local f19_local11 = f19_arg0:GetRandam_Int(30, 45)
    f19_arg0:SetNumber(10, f19_local9)
    f19_arg1:AddSubGoal(GOAL_COMMON_SidewayMove, f19_local10, TARGET_ENE_0, f19_local9, f19_local11, true, true, f19_local8):TimingSetTimer(2, 4, UPDATE_SUCCESS)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act30 = function (f20_arg0, f20_arg1, f20_arg2)
    local f20_local0 = 3
    local f20_local1 = 0
    local f20_local2 = 3.5
    local f20_local3 = f20_arg0:GetRandam_Int(30, 45)
    local f20_local4 = f20_arg0:GetRandam_Int(1, 100)
    if SpaceCheck(f20_arg0, f20_arg1, 180, 5) then
        f20_arg1:AddSubGoal(GOAL_COMMON_SpinStep, f20_local0, 5211, TARGET_ENE_0, f20_local1, AI_DIR_TYPE_B, 0)
        f20_local2 = 3.5
    elseif SpaceCheck(f20_arg0, f20_arg1, 90, 2) and SpaceCheck(f20_arg0, f20_arg1, -90, 2) then
        if f20_local4 <= 50 then
            f20_arg1:AddSubGoal(GOAL_COMMON_SpinStep, f20_local0, 5202, TARGET_ENE_0, f20_local1, AI_DIR_TYPE_B, 0)
        else
            f20_arg1:AddSubGoal(GOAL_COMMON_SpinStep, f20_local0, 5203, TARGET_ENE_0, f20_local1, AI_DIR_TYPE_B, 0)
        end
        f20_local2 = 3.5
    elseif SpaceCheck(f20_arg0, f20_arg1, 90, 2) then
        f20_arg1:AddSubGoal(GOAL_COMMON_SpinStep, f20_local0, 5203, TARGET_ENE_0, f20_local1, AI_DIR_TYPE_B, 0)
        f20_local2 = 3.5
    elseif SpaceCheck(f20_arg0, f20_arg1, -90, 2) then
        f20_arg1:AddSubGoal(GOAL_COMMON_SpinStep, f20_local0, 5202, TARGET_ENE_0, f20_local1, AI_DIR_TYPE_B, 0)
        f20_local2 = 3.5
    end
    local f20_local5 = 0
    if SpaceCheck(f20_arg0, f20_arg1, -90, 1) == true then
        if SpaceCheck(f20_arg0, f20_arg1, 90, 1) == true then
            if f20_arg0:IsInsideTarget(TARGET_ENE_0, AI_DIR_TYPE_R, 180) then
                f20_local5 = 0
            else
                f20_local5 = 1
            end
        else
            f20_local5 = 0
        end
    elseif SpaceCheck(f20_arg0, f20_arg1, 90, 1) == true then
        f20_local5 = 1
    else
    end
    f20_arg1:AddSubGoal(GOAL_COMMON_SidewayMove, f20_local2, TARGET_ENE_0, f20_local5, f20_local3, true, true, -1)
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
    
end

Goal.Act31 = function (f21_arg0, f21_arg1, f21_arg2)
    local f21_local0 = 3000
    local f21_local1 = 0
    local f21_local2 = 0
    f21_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 10, f21_local0, TARGET_ENE_0, 9999, f21_local1, f21_local2, 0, 0)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act40 = function (f22_arg0, f22_arg1, f22_arg2)
    local f22_local0 = f22_arg0:GetDist(TARGET_ENE_0)
    local f22_local1 = 0.3
    local f22_local2 = false
    local f22_local3 = 3
    local f22_local4 = f22_arg0:GetEventRequest()
    f22_arg1:AddSubGoal(GOAL_COMMON_ApproachTarget, f22_local3, TARGET_ENE_0, f22_local1, TARGET_SELF, f22_local2, -1)
    local f22_local5 = 0
    local f22_local6 = 0
    f22_arg0:SetNumber(1, f22_arg0:GetNumber(1) + 1)
    local f22_local7 = 3015
    local f22_local8 = 3016
    local f22_local9 = 4.5 - f22_arg0:GetMapHitRadius(TARGET_SELF) + 1
    local f22_local10 = 0
    local f22_local11 = 0
    local f22_local12 = f22_arg0:GetRandam_Int(1, 100)
    local f22_local13 = 3009
    if f22_local12 <= 50 then
        f22_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 10, 3013, TARGET_ENE_0, 9999, f22_local10, f22_local11, 0, 0)
    else
        f22_arg1:AddSubGoal(GOAL_COMMON_ComboAttackTunableSpin, 10, f22_local7, TARGET_ENE_0, f22_local9, f22_local10, f22_local11, 0, 0)
        f22_arg1:AddSubGoal(GOAL_COMMON_ComboRepeat, 10, f22_local8, TARGET_ENE_0, DistToAtt2, 0)
    end
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
    
end

Goal.Interrupt = function (f23_arg0, f23_arg1, f23_arg2)
    local f23_local0 = f23_arg1:GetHpRate(TARGET_SELF)
    local f23_local1 = f23_arg1:GetDist(TARGET_ENE_0)
    local f23_local2 = f23_arg1:GetSp(TARGET_SELF)
    local f23_local3 = f23_arg1:GetSpecialEffectActivateInterruptType(0)
    if f23_arg1:IsLadderAct(TARGET_SELF) then
        return false
    end
    if not f23_arg1:HasSpecialEffectId(TARGET_SELF, 200004) then
        return false
    end
    if f23_arg1:IsInterupt(INTERUPT_ParryTiming) then
        return Common_Parry(f23_arg1, f23_arg2, 50, 0)
    end
    if f23_arg1:IsInterupt(INTERUPT_ShootImpact) then
        return f23_arg0.ShootReaction(f23_arg1, f23_arg2)
    end
    if f23_arg1:IsInterupt(INTERUPT_Damaged) then
        return f23_arg0.Damaged(f23_arg1, f23_arg2)
    end
    if Interupt_PC_Break(f23_arg1) then
        f23_arg1:Replanning()
        return true
    end
    if f23_arg1:IsInterupt(INTERUPT_ActivateSpecialEffect) and f23_arg1:GetSpecialEffectActivateInterruptType(0) == 5025 then
        f23_arg1:AddObserveArea(0, TARGET_SELF, TARGET_ENE_0, AI_DIR_TYPE_F, 90, 4)
        return true
    end
    if Interupt_Use_Item(f23_arg1, 4, 10) then
        if f23_local1 <= 3 then
            f23_arg2:ClearSubGoal()
            f23_arg2:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 1, 3013, TARGET_ENE_0, 9999, 0, 0, 0, 0)
            return true
        elseif f23_local1 <= 6 then
            f23_arg2:ClearSubGoal()
            f23_arg2:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 1, 3017, TARGET_ENE_0, 9999, 0, 0, 0, 0)
            return true
        else
            f23_arg1:Replanning()
            return true
        end
    end
    if f23_arg1:IsInterupt(INTERUPT_Inside_ObserveArea) and f23_arg1:IsInsideObserve(0) then
        if SpaceCheck(f23_arg1, f23_arg2, 180, 4) == true then
            f23_arg2:ClearSubGoal()
            f23_arg2:AddSubGoal(GOAL_COMMON_EndureAttack, 1, 3081, TARGET_ENE_0, 9999, 0)
            f23_arg1:DeleteObserve(0)
            return true
        else
            f23_arg2:ClearSubGoal()
            f23_arg2:AddSubGoal(GOAL_COMMON_EndureAttack, 1, 3070, TARGET_ENE_0, 9999, 0)
            f23_arg1:DeleteObserve(0)
            return true
        end
    end
    return false
    
end

Goal.Damaged = function (f24_arg0, f24_arg1, f24_arg2)
    local f24_local0 = f24_arg0:GetHpRate(TARGET_SELF)
    local f24_local1 = f24_arg0:GetDist(TARGET_ENE_0)
    local f24_local2 = f24_arg0:GetSp(TARGET_SELF)
    local f24_local3 = f24_arg0:GetRandam_Int(1, 100)
    local f24_local4 = 0
    
end

Goal.ShootReaction = function (f25_arg0, f25_arg1)
    local f25_local0 = f25_arg0:GetDist(TARGET_ENE_0)
    if f25_arg0:IsInsideTargetEx(TARGET_ENE_0, TARGET_SELF, AI_DIR_TYPE_F, 20, 999) then
        if f25_local0 <= 30 then
            f25_arg1:ClearSubGoal()
            f25_arg1:AddSubGoal(GOAL_COMMON_EndureAttack, 0.1, 3100, TARGET_ENE_0, 9999, 0)
            return true
        else
            f25_arg1:ClearSubGoal()
            f25_arg1:AddSubGoal(GOAL_COMMON_Wait, 0.3, TARGET_SELF, 0, 0, 0)
            f25_arg1:AddSubGoal(GOAL_COMMON_EndureAttack, 0.1, 3100, TARGET_ENE_0, 9999, 0)
            return true
        end
    end
    return false
    
end

Goal.Kengeki_Activate = function (f26_arg0, f26_arg1, f26_arg2, f26_arg3)
    local f26_local0 = ReturnKengekiSpecialEffect(f26_arg1)
    if f26_local0 == 0 then
        return false
    end
    local f26_local1 = {}
    local f26_local2 = {}
    local f26_local3 = {}
    Common_Clear_Param(f26_local1, f26_local2, f26_local3)
    local f26_local4 = f26_arg1:GetDist(TARGET_ENE_0)
    local f26_local5 = f26_arg1:GetSp(TARGET_SELF)
    local f26_local6 = f26_arg1:GetRandam_Int(1, 100)
    if f26_local0 == 200200 then
        if f26_local4 >= 3 then
            f26_local1[50] = 100
        else
            f26_local1[1] = 10
            f26_local1[3] = 100
            f26_local1[5] = 100
            f26_local1[24] = 10
        end
    elseif f26_local0 == 200201 then
        if f26_local4 >= 3 then
            f26_local1[50] = 100
        else
            f26_local1[2] = 100
            f26_local1[4] = 100
            f26_local1[24] = 10
        end
    elseif f26_local0 == 200205 then
        if f26_local4 >= 3 then
            f26_local1[50] = 100
        else
            f26_local1[1] = 10
            f26_local1[3] = 100
            f26_local1[5] = 100
            f26_local1[9] = 30
            f26_local1[24] = 10
        end
    elseif f26_local0 == 200206 then
        if f26_local4 >= 3 then
            f26_local1[50] = 100
        else
            f26_local1[2] = 100
            f26_local1[4] = 100
            f26_local1[9] = 30
            f26_local1[24] = 10
        end
    elseif f26_local0 == 200210 then
        if f26_local4 >= 3 then
            f26_local1[50] = 100
        else
            f26_local1[1] = 200
            f26_local1[5] = 700
            f26_local1[9] = 100
        end
    elseif f26_local0 == 200211 then
        if f26_local4 >= 3 then
            f26_local1[50] = 100
        else
            f26_local1[1] = 200
            f26_local1[5] = 700
            f26_local1[9] = 100
        end
    elseif f26_local0 == 200215 then
        if f26_local4 >= 3 then
            f26_local1[50] = 100
        else
            f26_local1[50] = 100
        end
    elseif f26_local0 == 200216 then
        if f26_local4 >= 3 then
            f26_local1[50] = 100
        else
            f26_local1[50] = 100
        end
    end
    if SpaceCheck(f26_arg1, f26_arg2, 90, 1) == false and SpaceCheck(f26_arg1, f26_arg2, -45, 1) == false then
        f26_local1[23] = 0
    end
    if SpaceCheck(f26_arg1, f26_arg2, 180, 4) == false then
        f26_local1[24] = 0
        f26_local1[10] = 0
    end
    if SpaceCheck(f26_arg1, f26_arg2, 180, 1) == false then
        f26_local1[25] = 0
    end
    f26_local1[1] = SetCoolTime(f26_arg1, f26_arg2, 3050, 30, f26_local1[1], 1)
    f26_local1[2] = SetCoolTime(f26_arg1, f26_arg2, 3055, 10, f26_local1[2], 1)
    f26_local1[3] = SetCoolTime(f26_arg1, f26_arg2, 3060, 10, f26_local1[3], 1)
    f26_local1[4] = SetCoolTime(f26_arg1, f26_arg2, 3067, 10, f26_local1[4], 1)
    f26_local1[5] = SetCoolTime(f26_arg1, f26_arg2, 3070, 10, f26_local1[5], 1)
    f26_local1[7] = SetCoolTime(f26_arg1, f26_arg2, 3019, 10, f26_local1[7], 1)
    f26_local1[8] = SetCoolTime(f26_arg1, f26_arg2, 3016, 10, f26_local1[8], 1)
    f26_local1[9] = SetCoolTime(f26_arg1, f26_arg2, 3080, 5, f26_local1[9], 1)
    f26_local1[24] = SetCoolTime(f26_arg1, f26_arg2, 5211, 10, f26_local1[24], 1)
    f26_local1[24] = SetCoolTime(f26_arg1, f26_arg2, 5211, 10, f26_local1[24], 1)
    f26_local2[1] = REGIST_FUNC(f26_arg1, f26_arg2, f26_arg0.Kengeki01)
    f26_local2[2] = REGIST_FUNC(f26_arg1, f26_arg2, f26_arg0.Kengeki02)
    f26_local2[3] = REGIST_FUNC(f26_arg1, f26_arg2, f26_arg0.Kengeki03)
    f26_local2[4] = REGIST_FUNC(f26_arg1, f26_arg2, f26_arg0.Kengeki04)
    f26_local2[5] = REGIST_FUNC(f26_arg1, f26_arg2, f26_arg0.Kengeki05)
    f26_local2[6] = REGIST_FUNC(f26_arg1, f26_arg2, f26_arg0.Kengeki06)
    f26_local2[7] = REGIST_FUNC(f26_arg1, f26_arg2, f26_arg0.Kengeki07)
    f26_local2[8] = REGIST_FUNC(f26_arg1, f26_arg2, f26_arg0.Kengeki08)
    f26_local2[9] = REGIST_FUNC(f26_arg1, f26_arg2, f26_arg0.Kengeki09)
    f26_local2[21] = REGIST_FUNC(f26_arg1, f26_arg2, f26_arg0.Act21)
    f26_local2[23] = REGIST_FUNC(f26_arg1, f26_arg2, f26_arg0.Act23)
    f26_local2[24] = REGIST_FUNC(f26_arg1, f26_arg2, f26_arg0.Act24)
    f26_local2[25] = REGIST_FUNC(f26_arg1, f26_arg2, f26_arg0.Act25)
    f26_local2[50] = REGIST_FUNC(f26_arg1, f26_arg2, f26_arg0.NoAction)
    local f26_local7 = REGIST_FUNC(f26_arg1, f26_arg2, f26_arg0.ActAfter_AdjustSpace)
    return Common_Kengeki_Activate(f26_arg1, f26_arg2, f26_local1, f26_local2, f26_local7, f26_local3)
    
end

Goal.Kengeki01 = function (f27_arg0, f27_arg1, f27_arg2)
    f27_arg1:ClearSubGoal()
    f27_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 1, 3050, TARGET_ENE_0, 9999, 0, 0)
    
end

Goal.Kengeki02 = function (f28_arg0, f28_arg1, f28_arg2)
    local f28_local0 = 4.5 - f28_arg0:GetMapHitRadius(TARGET_SELF)
    local f28_local1 = 4.5 - f28_arg0:GetMapHitRadius(TARGET_SELF)
    local f28_local2 = 4.5 - f28_arg0:GetMapHitRadius(TARGET_SELF) + 999
    local f28_local3 = 0
    local f28_local4 = 0
    local f28_local5 = f28_arg0:GetRandam_Int(1, 100)
    f28_arg1:ClearSubGoal()
    f28_arg1:AddSubGoal(GOAL_COMMON_ComboRepeat, 10, 3055, TARGET_ENE_0, f28_local0, 0, 0)
    if f28_local5 <= 40 then
        f28_arg1:AddSubGoal(GOAL_COMMON_ComboRepeat, 10, 3018, TARGET_ENE_0, f28_local1, 0)
        f28_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3019, TARGET_ENE_0, f28_local2, 0, 0)
    end
    
end

Goal.Kengeki03 = function (f29_arg0, f29_arg1, f29_arg2)
    local f29_local0 = 4 - f29_arg0:GetMapHitRadius(TARGET_SELF)
    local f29_local1 = 4 - f29_arg0:GetMapHitRadius(TARGET_SELF)
    local f29_local2 = 180 - f29_arg0:GetMapHitRadius(TARGET_SELF)
    local f29_local3 = 0
    local f29_local4 = 0
    local f29_local5 = f29_arg0:GetRandam_Int(1, 100)
    f29_arg1:ClearSubGoal()
    f29_arg1:AddSubGoal(GOAL_COMMON_ComboRepeat, 10, 3060, TARGET_ENE_0, f29_local0, 0, 0)
    if f29_local5 <= 40 then
        f29_arg1:AddSubGoal(GOAL_COMMON_ComboRepeat, 10, 3011, TARGET_ENE_0, f29_local1, 0)
        f29_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3012, TARGET_ENE_0, f29_local2, 0, 0)
    end
    
end

Goal.Kengeki04 = function (f30_arg0, f30_arg1, f30_arg2)
    local f30_local0 = 4.5 - f30_arg0:GetMapHitRadius(TARGET_SELF)
    local f30_local1 = 4.5 - f30_arg0:GetMapHitRadius(TARGET_SELF)
    local f30_local2 = 4.5 - f30_arg0:GetMapHitRadius(TARGET_SELF) + 999
    local f30_local3 = 0
    local f30_local4 = 0
    local f30_local5 = f30_arg0:GetRandam_Int(1, 100)
    f30_arg1:ClearSubGoal()
    f30_arg1:AddSubGoal(GOAL_COMMON_ComboRepeat, 10, 3067, TARGET_ENE_0, f30_local0, 0, 0)
    if f30_local5 <= 40 then
        f30_arg1:AddSubGoal(GOAL_COMMON_ComboRepeat, 10, 3018, TARGET_ENE_0, f30_local1, 0)
        f30_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3019, TARGET_ENE_0, f30_local2, 0, 0)
    end
    
end

Goal.Kengeki05 = function (f31_arg0, f31_arg1, f31_arg2)
    local f31_local0 = 0
    local f31_local1 = 0
    local f31_local2 = f31_arg0:GetRandam_Int(1, 100)
    f31_arg1:ClearSubGoal()
    f31_arg1:AddSubGoal(GOAL_COMMON_ComboRepeat, 10, 3070, TARGET_ENE_0, 9999, 0, 0)
    f31_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3019, TARGET_ENE_0, 9999, 0, 0)
    
end

Goal.Kengeki06 = function (f32_arg0, f32_arg1, f32_arg2)
    local f32_local0 = 0
    local f32_local1 = 0
    local f32_local2 = f32_arg0:GetRandam_Int(1, 100)
    f32_arg1:ClearSubGoal()
    f32_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3075, TARGET_ENE_0, 9999, 0, 0)
    if f32_local2 <= 40 then
        f32_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3019, TARGET_ENE_0, 9999, 0, 0)
    end
    
end

Goal.Kengeki07 = function (f33_arg0, f33_arg1, f33_arg2)
    local f33_local0 = 0
    local f33_local1 = 0
    local f33_local2 = f33_arg0:GetRandam_Int(1, 100)
    f33_arg1:ClearSubGoal()
    f33_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3019, TARGET_ENE_0, 9999, 0, 0)
    
end

Goal.Kengeki08 = function (f34_arg0, f34_arg1, f34_arg2)
    local f34_local0 = 0
    local f34_local1 = 0
    local f34_local2 = f34_arg0:GetRandam_Int(1, 100)
    f34_arg1:ClearSubGoal()
    f34_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3016, TARGET_ENE_0, 9999, 0, 0)
    
end

Goal.Kengeki09 = function (f35_arg0, f35_arg1, f35_arg2)
    local f35_local0 = 0
    local f35_local1 = 0
    f35_arg1:ClearSubGoal()
    f35_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3081, TARGET_ENE_0, 9999, 0, 0)
    
end

Goal.NoAction = function (f36_arg0, f36_arg1, f36_arg2)
    return -1
    
end

Goal.ActAfter_AdjustSpace = function (f37_arg0, f37_arg1, f37_arg2)
    
end

Goal.Update = function (f38_arg0, f38_arg1, f38_arg2)
    return Update_Default_NoSubGoal(f38_arg0, f38_arg1, f38_arg2)
    
end

Goal.Terminate = function (f39_arg0, f39_arg1, f39_arg2)
    
end


