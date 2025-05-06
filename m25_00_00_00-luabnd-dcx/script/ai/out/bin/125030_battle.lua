RegisterTableGoal(GOAL_YashazaruKenzoku_nitou_125030_Battle, "GOAL_YashazaruKenzoku_nitou_125030_Battle")
REGISTER_GOAL_NO_UPDATE(GOAL_YashazaruKenzoku_nitou_125030_Battle, true)

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
    local f2_local6 = Check_ReachAttack(f2_arg1, 0)
    local f2_local7 = f2_arg1:GetSpRate(TARGET_SELF)
    f2_arg1:SetNumber(0, 0)
    f2_arg1:AddObserveSpecialEffectAttribute(TARGET_SELF, 5025)
    Set_ConsecutiveGuardCount_Interrupt(f2_arg1)
    f2_arg1:DeleteObserve(1)
    if f2_arg0.Kengeki_Activate(f2_arg0, f2_arg1, f2_arg2) then
        return
    end
    if Common_ActivateAct(f2_arg1, f2_arg2, 0, 1) then
    elseif f2_local6 ~= POSSIBLE_ATTACK then
        if f2_local5 == 1 and f2_arg1:GetTeamOrder(ORDER_TYPE_Role) == ROLE_TYPE_Kankyaku then
            f2_local0[27] = 100
        elseif f2_local5 == 1 and f2_arg1:GetTeamOrder(ORDER_TYPE_Role) == ROLE_TYPE_Torimaki then
            f2_local0[27] = 100
        elseif f2_local6 == UNREACH_ATTACK then
            f2_local0[27] = 100
        elseif f2_local6 == REACH_ATTACK_TARGET_HIGH_POSITION then
            f2_local0[1] = 100
            f2_local0[2] = 100
        elseif f2_local6 == REACH_ATTACK_TARGET_LOW_POSITION then
            f2_local0[1] = 100
            f2_local0[2] = 100
        else
            f2_local0[27] = 100
        end
    elseif f2_local5 == 1 and f2_arg1:GetTeamOrder(ORDER_TYPE_Role) == ROLE_TYPE_Kankyaku then
        KankyakuAct(f2_arg1, f2_arg2)
    elseif f2_local5 == 1 and f2_arg1:GetTeamOrder(ORDER_TYPE_Role) == ROLE_TYPE_Torimaki then
        TorimakiAct(f2_arg1, f2_arg2, -1, 0)
    elseif f2_arg1:IsInsideTarget(TARGET_ENE_0, AI_DIR_TYPE_B, 180) then
        f2_local0[21] = 100
        f2_local0[22] = 1
    else
        if f2_local3 >= 7 then
            f2_local0[1] = 200
            f2_local0[2] = 200
            f2_local0[4] = 300
            f2_local0[23] = 200
        elseif f2_local3 > 4.2 then
            f2_local0[1] = 150
            f2_local0[2] = 150
            f2_local0[3] = 150
            if f2_local3 < 6 then
                f2_local0[4] = 100
            end
            f2_local0[22] = 100
            f2_local0[23] = 250
        else
            f2_local0[1] = 150
            f2_local0[2] = 100
            f2_local0[3] = 350
            f2_local0[22] = 100
            f2_local0[24] = 500
        end
        if f2_local7 < 0.5 then
            f2_local0[1] = f2_local0[1] * 0.5
            f2_local0[2] = f2_local0[2] * 0.5
            f2_local0[4] = f2_local0[4] * 0.5
            f2_local0[22] = f2_local0[22] * 0.3
            f2_local0[23] = f2_local0[23] * 4
            f2_local0[24] = f2_local0[24] * 3
        end
        if f2_arg1:HasSpecialEffectId(TARGET_ENE_0, COMMON_SP_EFFECT_PC_BREAK) then
            f2_local0[2] = 0
            f2_local0[22] = 0
            f2_local0[23] = 0
            f2_local0[24] = 0
        end
    end
    if f2_local4 >= 0.7 and f2_local3 > 1.5 and f2_local3 < 4 then
        f2_local0[8] = 200
    end
    if SpaceCheck(f2_arg1, f2_arg2, 45, 3.1) == false and SpaceCheck(f2_arg1, f2_arg2, -45, 3.1) == false then
        f2_local0[22] = 0
    end
    if SpaceCheck(f2_arg1, f2_arg2, 90, 1) == false and SpaceCheck(f2_arg1, f2_arg2, -90, 1) == false then
        f2_local0[23] = 0
    end
    f2_local0[19] = 0
    if SpaceCheck(f2_arg1, f2_arg2, 180, 3.1) == false then
        f2_local0[24] = 0
    end
    if SpaceCheck(f2_arg1, f2_arg2, 180, 3) == false then
        f2_local0[3] = 0
    end
    if SpaceCheck(f2_arg1, f2_arg2, 180, 2.5) == false then
        f2_local0[2] = 0
    end
    if SpaceCheck(f2_arg1, f2_arg2, 180, 1) == false then
        f2_local0[25] = 0
    end
    if f2_arg1:GetAttackPassedTime(5201) <= 1 then
        if SpaceCheck(f2_arg1, f2_arg2, 90, 3.1) == false and SpaceCheck(f2_arg1, f2_arg2, -90, 3.1) == false then
            f2_local0[22] = 0
        end
        f2_local0[22] = 600
    end
    f2_local0[1] = SetCoolTime(f2_arg1, f2_arg2, 3000, 5, f2_local0[1], 1)
    f2_local0[2] = SetCoolTime(f2_arg1, f2_arg2, 3003, 15, f2_local0[2], 1)
    f2_local0[3] = SetCoolTime(f2_arg1, f2_arg2, 3005, 10, f2_local0[3], 1)
    f2_local0[4] = SetCoolTime(f2_arg1, f2_arg2, 3006, 8, f2_local0[4], 1)
    f2_local0[8] = SetCoolTime(f2_arg1, f2_arg2, 3200, 5, f2_local0[8], 1)
    f2_local0[24] = SetCoolTime(f2_arg1, f2_arg2, 5201, 10, f2_local0[24], 1)
    f2_local1[1] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act01)
    f2_local1[2] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act02)
    f2_local1[3] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act03)
    f2_local1[4] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act04)
    f2_local1[5] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act05)
    f2_local1[6] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act06)
    f2_local1[7] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act07)
    f2_local1[8] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act08)
    f2_local1[19] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act19)
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
    local f3_local0 = 4 - f3_arg0:GetMapHitRadius(TARGET_SELF)
    local f3_local1 = 4 - f3_arg0:GetMapHitRadius(TARGET_SELF) + 2
    local f3_local2 = 4 - f3_arg0:GetMapHitRadius(TARGET_SELF) + 2
    local f3_local3 = 100
    local f3_local4 = 0
    local f3_local5 = 1.5
    local f3_local6 = 3
    Approach_Act_Flex(f3_arg0, f3_arg1, f3_local0, f3_local1, f3_local2, f3_local3, f3_local4, f3_local5, f3_local6)
    local f3_local7 = 3.5 - f3_arg0:GetMapHitRadius(TARGET_SELF)
    local f3_local8 = 5 - f3_arg0:GetMapHitRadius(TARGET_SELF)
    local f3_local9 = 0
    local f3_local10 = 0
    local f3_local11 = f3_arg0:GetRandam_Int(1, 100)
    local f3_local12 = 5.5
    f3_arg0:AddObserveArea(1, TARGET_SELF, TARGET_ENE_0, AI_DIR_TYPE_F, 90, f3_local12)
    if f3_local11 <= 50 then
        f3_arg1:AddSubGoal(GOAL_COMMON_ComboAttackTunableSpin, 10, 3000, TARGET_ENE_0, 9999, f3_local9, f3_local10, 0, 0)
    else
        f3_arg1:AddSubGoal(GOAL_COMMON_ComboAttackTunableSpin, 10, 3000, TARGET_ENE_0, 9999, f3_local9, f3_local10, 0, 0)
    end
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act02 = function (f4_arg0, f4_arg1, f4_arg2)
    local f4_local0 = 4.6 - f4_arg0:GetMapHitRadius(TARGET_SELF)
    local f4_local1 = 4.6 - f4_arg0:GetMapHitRadius(TARGET_SELF) + 2
    local f4_local2 = 4.6 - f4_arg0:GetMapHitRadius(TARGET_SELF) + 2
    local f4_local3 = 100
    local f4_local4 = 0
    local f4_local5 = 1.5
    local f4_local6 = 3
    Approach_Act_Flex(f4_arg0, f4_arg1, f4_local0, f4_local1, f4_local2, f4_local3, f4_local4, f4_local5, f4_local6)
    local f4_local7 = 0
    local f4_local8 = 0
    f4_arg1:AddSubGoal(GOAL_COMMON_ComboAttackTunableSpin, 10, 3003, TARGET_ENE_0, 9999, f4_local7, f4_local8, 0, 0)
    f4_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3004, TARGET_ENE_0, 9999, 0, 0)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act03 = function (f5_arg0, f5_arg1, f5_arg2)
    local f5_local0 = 3.6 - f5_arg0:GetMapHitRadius(TARGET_SELF)
    local f5_local1 = 3.6 - f5_arg0:GetMapHitRadius(TARGET_SELF) + 2
    local f5_local2 = 3.6 - f5_arg0:GetMapHitRadius(TARGET_SELF) + 2
    local f5_local3 = 100
    local f5_local4 = 0
    local f5_local5 = 1.5
    local f5_local6 = 3
    Approach_Act_Flex(f5_arg0, f5_arg1, f5_local0, f5_local1, f5_local2, f5_local3, f5_local4, f5_local5, f5_local6)
    local f5_local7 = 0
    local f5_local8 = 0
    f5_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 10, 3005, TARGET_ENE_0, 9999, f5_local7, f5_local8, 0, 0)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act04 = function (f6_arg0, f6_arg1, f6_arg2)
    local f6_local0 = 5.8 - f6_arg0:GetMapHitRadius(TARGET_SELF)
    local f6_local1 = 5.8 - f6_arg0:GetMapHitRadius(TARGET_SELF) + 2
    local f6_local2 = 5.8 - f6_arg0:GetMapHitRadius(TARGET_SELF) + 2
    local f6_local3 = 100
    local f6_local4 = 0
    local f6_local5 = 1.5
    local f6_local6 = 3
    Approach_Act_Flex(f6_arg0, f6_arg1, f6_local0, f6_local1, f6_local2, f6_local3, f6_local4, f6_local5, f6_local6)
    local f6_local7 = 0
    local f6_local8 = 0
    local f6_local9 = f6_arg0:GetRandam_Int(1, 100)
    if f6_local9 <= 50 then
        f6_arg1:AddSubGoal(GOAL_COMMON_ComboAttackTunableSpin, 10, 3006, TARGET_ENE_0, 5, f6_local7, f6_local8, 0, 0)
        f6_arg1:AddSubGoal(GOAL_COMMON_ComboRepeat, 10, 3007, TARGET_ENE_0, 9999, f6_local7, f6_local8, 0, 0)
        f6_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3001, TARGET_ENE_0, 9999, 0, 0)
    else
        f6_arg1:AddSubGoal(GOAL_COMMON_ComboAttackTunableSpin, 10, 3006, TARGET_ENE_0, 5, f6_local7, f6_local8, 0, 0)
        f6_arg1:AddSubGoal(GOAL_COMMON_ComboRepeat, 10, 3007, TARGET_ENE_0, 9999, f6_local7, f6_local8, 0, 0)
        f6_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3002, TARGET_ENE_0, 9999, 0, 0)
    end
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act05 = function (f7_arg0, f7_arg1, f7_arg2)
    local f7_local0 = 3.9 - f7_arg0:GetMapHitRadius(TARGET_SELF)
    local f7_local1 = 3.9 - f7_arg0:GetMapHitRadius(TARGET_SELF) + 2
    local f7_local2 = 3.9 - f7_arg0:GetMapHitRadius(TARGET_SELF) + 2
    local f7_local3 = 100
    local f7_local4 = 0
    local f7_local5 = 1.5
    local f7_local6 = 3
    Approach_Act_Flex(f7_arg0, f7_arg1, f7_local0, f7_local1, f7_local2, f7_local3, f7_local4, f7_local5, f7_local6)
    local f7_local7 = 0
    local f7_local8 = 0
    f7_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 10, 3070, TARGET_ENE_0, 9999, f7_local7, f7_local8, 0, 0)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act06 = function (f8_arg0, f8_arg1, f8_arg2)
    local f8_local0 = 4.9 - f8_arg0:GetMapHitRadius(TARGET_SELF)
    local f8_local1 = 4.9 - f8_arg0:GetMapHitRadius(TARGET_SELF) + 2
    local f8_local2 = 4.9 - f8_arg0:GetMapHitRadius(TARGET_SELF) + 2
    local f8_local3 = 100
    local f8_local4 = 0
    local f8_local5 = 1.5
    local f8_local6 = 3
    Approach_Act_Flex(f8_arg0, f8_arg1, f8_local0, f8_local1, f8_local2, f8_local3, f8_local4, f8_local5, f8_local6)
    local f8_local7 = 0
    local f8_local8 = 0
    f8_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 10, 3071, TARGET_ENE_0, 9999, f8_local7, f8_local8, 0, 0)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act07 = function (f9_arg0, f9_arg1, f9_arg2)
    local f9_local0 = 4.4 - f9_arg0:GetMapHitRadius(TARGET_SELF)
    local f9_local1 = 4.4 - f9_arg0:GetMapHitRadius(TARGET_SELF) + 2
    local f9_local2 = 4.4 - f9_arg0:GetMapHitRadius(TARGET_SELF) + 2
    local f9_local3 = 100
    local f9_local4 = 0
    local f9_local5 = 1.5
    local f9_local6 = 3
    Approach_Act_Flex(f9_arg0, f9_arg1, f9_local0, f9_local1, f9_local2, f9_local3, f9_local4, f9_local5, f9_local6)
    local f9_local7 = 0
    local f9_local8 = 0
    f9_arg1:AddSubGoal(GOAL_COMMON_ComboAttackTunableSpin, 10, 3072, TARGET_ENE_0, 9999, f9_local7, f9_local8, 0, 0)
    f9_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3073, TARGET_ENE_0, 9999, 0, 0)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act08 = function (f10_arg0, f10_arg1, f10_arg2)
    local f10_local0 = 4.4 - f10_arg0:GetMapHitRadius(TARGET_SELF)
    local f10_local1 = 4.4 - f10_arg0:GetMapHitRadius(TARGET_SELF) + 2
    local f10_local2 = 4.4 - f10_arg0:GetMapHitRadius(TARGET_SELF) + 2
    local f10_local3 = 100
    local f10_local4 = 0
    local f10_local5 = 1.5
    local f10_local6 = 3
    local f10_local7 = 3200
    Approach_Act_Flex(f10_arg0, f10_arg1, 20, f10_local1, f10_local2, f10_local3, f10_local4, f10_local5, f10_local6)
    local f10_local8 = 0
    local f10_local9 = 0
    f10_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 10, f10_local7, TARGET_ENE_0, 9999, f10_local8, f10_local9, 0, 0)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act19 = function (f11_arg0, f11_arg1, f11_arg2)
    local f11_local0 = 3
    local f11_local1 = 0
    local f11_local2 = 5200
    f11_arg1:AddSubGoal(GOAL_COMMON_SpinStep, f11_local0, f11_local2, TARGET_ENE_0, f11_local1, AI_DIR_TYPE_B, 0)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act21 = function (f12_arg0, f12_arg1, f12_arg2)
    local f12_local0 = 3
    local f12_local1 = 45
    if f12_arg0:IsTargetGuard(TARGET_SELF) then
        f12_arg1:AddSubGoal(GOAL_COMMON_Turn, f12_local0, TARGET_ENE_0, f12_local1, 9910, GOAL_RESULT_Success, true)
    else
        f12_arg1:AddSubGoal(GOAL_COMMON_Turn, f12_local0, TARGET_ENE_0, f12_local1, -1, GOAL_RESULT_Success, true)
    end
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
    
end

Goal.Act22 = function (f13_arg0, f13_arg1, f13_arg2)
    local f13_local0 = 3
    local f13_local1 = 0
    if SpaceCheck(f13_arg0, f13_arg1, -45, 3.1) == true then
        if SpaceCheck(f13_arg0, f13_arg1, 45, 3.1) == true then
            if f13_arg0:IsInsideTarget(TARGET_ENE_0, AI_DIR_TYPE_R, 180) then
                f13_arg1:AddSubGoal(GOAL_COMMON_SpinStep, f13_local0, 5202, TARGET_ENE_0, f13_local1, AI_DIR_TYPE_L, 0)
            else
                f13_arg1:AddSubGoal(GOAL_COMMON_SpinStep, f13_local0, 5203, TARGET_ENE_0, f13_local1, AI_DIR_TYPE_R, 0)
            end
        else
            f13_arg1:AddSubGoal(GOAL_COMMON_SpinStep, f13_local0, 5202, TARGET_ENE_0, f13_local1, AI_DIR_TYPE_L, 0)
        end
    elseif SpaceCheck(f13_arg0, f13_arg1, 45, 3.1) == true then
        f13_arg1:AddSubGoal(GOAL_COMMON_SpinStep, f13_local0, 5203, TARGET_ENE_0, f13_local1, AI_DIR_TYPE_R, 0)
    else
        f13_arg1:AddSubGoal(GOAL_COMMON_SpinStep, f13_local0, 5203, TARGET_ENE_0, f13_local1, AI_DIR_TYPE_R, 0)
    end
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
    
end

Goal.Act23 = function (f14_arg0, f14_arg1, f14_arg2)
    local f14_local0 = f14_arg0:GetDist(TARGET_ENE_0)
    local f14_local1 = 0.8
    local f14_local2 = f14_arg0:GetSpRate(TARGET_SELF)
    local f14_local3 = f14_arg0:GetRandam_Int(1, 100)
    local f14_local4 = f14_arg0:GetRandam_Int(1, 100)
    local f14_local5 = -1
    local f14_local6 = 0
    if SpaceCheck(f14_arg0, f14_arg1, -90, 1) == true then
        if SpaceCheck(f14_arg0, f14_arg1, 90, 1) == true then
            if f14_arg0:IsInsideTarget(TARGET_ENE_0, AI_DIR_TYPE_R, 180) then
                f14_local6 = 0
            else
                f14_local6 = 1
            end
        else
            f14_local6 = 0
        end
    elseif SpaceCheck(f14_arg0, f14_arg1, 90, 1) == true then
        f14_local6 = 1
    else
    end
    local f14_local7 = f14_arg0:GetRandam_Float(1, 2)
    local f14_local8 = f14_arg0:GetRandam_Int(30, 45)
    local f14_local9 = f14_arg0:GetRandam_Float(3.8, 4.1)
    f14_arg0:SetNumber(10, f14_local6)
    if f14_local2 < f14_local1 then
        f14_local7 = f14_arg0:GetRandam_Float(1, 2)
        f14_local5 = 9910
    end
    f14_arg1:AddSubGoal(GOAL_COMMON_SidewayMove, f14_local7, TARGET_ENE_0, f14_local6, f14_local8, true, true, f14_local5):TimingSetTimer(2, 4, UPDATE_SUCCESS):SetTargetRange(0, f14_local9, 999)
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
    
end

Goal.Act24 = function (f15_arg0, f15_arg1, f15_arg2)
    local f15_local0 = f15_arg0:GetDist(TARGET_ENE_0)
    local f15_local1 = 3
    local f15_local2 = 0
    local f15_local3 = 5201
    f15_arg1:ClearSubGoal()
    f15_arg1:AddSubGoal(GOAL_COMMON_SpinStep, f15_local1, f15_local3, TARGET_ENE_0, f15_local2, AI_DIR_TYPE_B, 0)
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
    
end

Goal.Act25 = function (f16_arg0, f16_arg1, f16_arg2)
    local f16_local0 = f16_arg0:GetRandam_Float(2, 4)
    local f16_local1 = f16_arg0:GetRandam_Float(1, 3)
    local f16_local2 = f16_arg0:GetDist(TARGET_ENE_0)
    local f16_local3 = -1
    local f16_local4 = f16_arg0:GetSpRate(TARGET_SELF)
    if f16_local4 < 0.5 then
        f16_local3 = 9910
    end
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

Goal.Interrupt = function (f20_arg0, f20_arg1, f20_arg2)
    local f20_local0 = f20_arg1:GetSpecialEffectActivateInterruptType(0)
    local f20_local1 = f20_arg1:GetRandam_Int(1, 100)
    local f20_local2 = 3000
    if f20_arg1:IsLadderAct(TARGET_SELF) then
        return false
    end
    if not f20_arg1:HasSpecialEffectId(TARGET_SELF, 200004) then
        return false
    end
    if f20_arg1:IsInterupt(INTERUPT_ParryTiming) then
        return Common_Parry(f20_arg1, f20_arg2, 50, 0, 1)
    end
    if f20_arg1:IsInterupt(INTERUPT_TargetOutOfRange) and f20_arg1:IsTargetOutOfRangeInterruptSlot(0) then
        f20_arg1:Replanning()
        return true
    end
    if f20_arg1:IsInterupt(INTERUPT_ShootImpact) and f20_arg0.ShootReaction(f20_arg1, f20_arg2) then
        return true
    end
    if f20_arg1:IsInterupt(INTERUPT_Damaged) then
        return f20_arg0.Damaged(f20_arg1, f20_arg2)
    end
    local f20_local3 = 3000
    if f20_arg1:IsInterupt(INTERUPT_ActivateSpecialEffect) and f20_local0 == 5025 and f20_arg1:IsInsideTarget(TARGET_ENE_0, AI_DIR_TYPE_F, 120) then
        if f20_local1 < 90 and f20_arg1:GetDist(TARGET_ENE_0) <= 2.8 then
            f20_local3 = 3001
        elseif f20_local1 < 90 then
            f20_local3 = 3002
        else
            f20_arg2:ClearSubGoal()
            f20_arg1:Replanning()
            return true
        end
        f20_arg2:ClearSubGoal()
        f20_arg2:AddSubGoal(GOAL_COMMON_EndureAttack, 5, f20_local3, TARGET_ENE_0, 9999, 0, 0, 0, 0)
        return true
    end
    if Interupt_PC_Break(f20_arg1) then
        f20_arg1:Replanning()
        return true
    end
    return false
    
end

Goal.Damaged = function (f21_arg0, f21_arg1, f21_arg2)
    local f21_local0 = f21_arg0:GetHpRate(TARGET_SELF)
    local f21_local1 = f21_arg0:GetDist(TARGET_ENE_0)
    local f21_local2 = f21_arg0:GetSp(TARGET_SELF)
    local f21_local3 = f21_arg0:GetRandam_Int(1, 100)
    local f21_local4 = 0
    if f21_local3 <= 90 and SpaceCheck(f21_arg0, f21_arg1, 180, 3.1) == true then
        f21_arg1:ClearSubGoal()
        f21_arg1:AddSubGoal(GOAL_COMMON_SpinStep, 3, 5201, TARGET_ENE_0, TurnTime, AI_DIR_TYPE_B, 0):TimingSetTimer(3, 6, UPDATE_SUCCESS)
        return true
    else
    end
    return false
    
end

Goal.ShootReaction = function (f22_arg0, f22_arg1)
    f22_arg1:ClearSubGoal()
    f22_arg1:AddSubGoal(GOAL_COMMON_EndureAttack, 0.1, 3100, TARGET_ENE_0, 9999, 0)
    return true
    
end

Goal.Kengeki_Activate = function (f23_arg0, f23_arg1, f23_arg2, f23_arg3)
    local f23_local0 = ReturnKengekiSpecialEffect(f23_arg1)
    if f23_local0 == 0 then
        return false
    end
    local f23_local1 = {}
    local f23_local2 = {}
    local f23_local3 = {}
    Common_Clear_Param(f23_local1, f23_local2, f23_local3)
    local f23_local4 = f23_arg1:GetDist(TARGET_ENE_0)
    local f23_local5 = f23_arg1:GetSp(TARGET_SELF)
    local f23_local6 = f23_arg1:GetSpRate(TARGET_SELF)
    local f23_local7 = f23_arg1:GetHpRate(TARGET_SELF)
    local f23_local8 = f23_arg1:GetNinsatsuNum()
    if f23_local5 <= 0 then
        f23_local1[50] = 100
    elseif f23_local0 == 200200 or f23_local0 == 200205 then
        if f23_local4 >= 3.5 then
            f23_local1[50] = 100
        elseif f23_local6 <= 0.7 and f23_arg1:IsFinishTimer(0) then
            f23_local1[11] = 500
            f23_local1[24] = 80
        else
            f23_local1[1] = 200
            f23_local1[2] = 150
            f23_local1[3] = 50
        end
    elseif f23_local0 == 200201 or f23_local0 == 200206 then
        if f23_local4 >= 3.5 then
            f23_local1[50] = 100
        elseif f23_local6 <= 0.7 and f23_arg1:IsFinishTimer(0) then
            f23_local1[11] = 500
            f23_local1[24] = 80
        else
            f23_local1[5] = 50
            f23_local1[7] = 200
            f23_local1[9] = 100
        end
    elseif f23_local0 == 200210 then
        if f23_local4 >= 3.5 then
            f23_local1[50] = 100
        elseif f23_local6 <= 0.7 and f23_arg1:IsFinishTimer(0) then
            f23_local1[10] = 500
            f23_local1[24] = 80
        else
            f23_local1[1] = 100
            f23_local1[3] = 50
            f23_local1[4] = 100
            f23_local1[12] = 200
        end
    elseif f23_local0 == 200211 then
        if f23_local4 >= 3.5 then
            f23_local1[50] = 100
        elseif f23_local6 <= 0.7 and f23_arg1:IsFinishTimer(0) then
            f23_local1[11] = 500
            f23_local1[24] = 80
        else
            f23_local1[8] = 100
            f23_local1[9] = 100
            f23_local1[12] = 200
        end
    elseif f23_local0 == 200215 then
        if f23_local4 >= 3.5 then
            f23_local1[50] = 100
        else
            f23_local1[1] = 100
            f23_local1[3] = 50
            if f23_local6 <= 0.5 then
                f23_local1[24] = 100
            end
        end
    elseif f23_local0 == 200216 then
        if f23_local4 >= 3.5 then
            f23_local1[50] = 100
        else
            f23_local1[5] = 100
            f23_local1[7] = 200
            if f23_local6 <= 0.5 then
                f23_local1[24] = 100
            end
        end
    end
    if SpaceCheck(f23_arg1, f23_arg2, 45, 3.1) == false and SpaceCheck(f23_arg1, f23_arg2, -45, 3.1) == false then
        f23_local1[22] = 0
    end
    if SpaceCheck(f23_arg1, f23_arg2, 180, 3.1) == false and f23_local1[24] + f23_local1[4] + f23_local1[9] > 0 then
        f23_local1[24] = 0
        f23_local1[4] = 0
        f23_local1[9] = 0
        f23_local1[50] = 1
    else
        f23_local1[22] = f23_local1[22] * 0.2
    end
    f23_local1[2] = SetCoolTime(f23_arg1, f23_arg2, 3051, 5, f23_local1[2], 1)
    f23_local1[3] = SetCoolTime(f23_arg1, f23_arg2, 3052, 5, f23_local1[3], 1)
    f23_local1[4] = SetCoolTime(f23_arg1, f23_arg2, 3053, 5, f23_local1[4], 1)
    f23_local1[5] = SetCoolTime(f23_arg1, f23_arg2, 3055, 5, f23_local1[5], 1)
    f23_local1[6] = SetCoolTime(f23_arg1, f23_arg2, 3056, 5, f23_local1[6], 1)
    f23_local1[7] = SetCoolTime(f23_arg1, f23_arg2, 3057, 5, f23_local1[7], 1)
    f23_local1[8] = SetCoolTime(f23_arg1, f23_arg2, 3058, 5, f23_local1[8], 1)
    f23_local1[9] = SetCoolTime(f23_arg1, f23_arg2, 3059, 10, f23_local1[9], 1)
    f23_local1[10] = SetCoolTime(f23_arg1, f23_arg2, 3060, 10, f23_local1[10], 1)
    f23_local1[11] = SetCoolTime(f23_arg1, f23_arg2, 3065, 10, f23_local1[11], 1)
    f23_local1[12] = SetCoolTime(f23_arg1, f23_arg2, 3070, 5, f23_local1[12], 1)
    f23_local2[1] = REGIST_FUNC(f23_arg1, f23_arg2, f23_arg0.Kengeki01)
    f23_local2[2] = REGIST_FUNC(f23_arg1, f23_arg2, f23_arg0.Kengeki02)
    f23_local2[3] = REGIST_FUNC(f23_arg1, f23_arg2, f23_arg0.Kengeki03)
    f23_local2[4] = REGIST_FUNC(f23_arg1, f23_arg2, f23_arg0.Kengeki04)
    f23_local2[5] = REGIST_FUNC(f23_arg1, f23_arg2, f23_arg0.Kengeki05)
    f23_local2[6] = REGIST_FUNC(f23_arg1, f23_arg2, f23_arg0.Kengeki06)
    f23_local2[7] = REGIST_FUNC(f23_arg1, f23_arg2, f23_arg0.Kengeki07)
    f23_local2[8] = REGIST_FUNC(f23_arg1, f23_arg2, f23_arg0.Kengeki08)
    f23_local2[9] = REGIST_FUNC(f23_arg1, f23_arg2, f23_arg0.Kengeki09)
    f23_local2[10] = REGIST_FUNC(f23_arg1, f23_arg2, f23_arg0.Kengeki10)
    f23_local2[11] = REGIST_FUNC(f23_arg1, f23_arg2, f23_arg0.Kengeki11)
    f23_local2[12] = REGIST_FUNC(f23_arg1, f23_arg2, f23_arg0.Kengeki12)
    f23_local2[13] = REGIST_FUNC(f23_arg1, f23_arg2, f23_arg0.Kengeki13)
    f23_local2[14] = REGIST_FUNC(f23_arg1, f23_arg2, f23_arg0.Kengeki14)
    f23_local2[22] = REGIST_FUNC(f23_arg1, f23_arg2, f23_arg0.Act22)
    f23_local2[24] = REGIST_FUNC(f23_arg1, f23_arg2, f23_arg0.Act24)
    f23_local2[50] = REGIST_FUNC(f23_arg1, f23_arg2, f23_arg0.NoAction)
    local f23_local9 = REGIST_FUNC(f23_arg1, f23_arg2, f23_arg0.ActAfter_AdjustSpace)
    return Common_Kengeki_Activate(f23_arg1, f23_arg2, f23_local1, f23_local2, f23_local9, f23_local3)
    
end

Goal.Kengeki01 = function (f24_arg0, f24_arg1, f24_arg2)
    f24_arg1:ClearSubGoal()
    local f24_local0 = 0
    local f24_local1 = 0
    local f24_local2 = f24_arg0:GetRandam_Int(1, 100)
    if f24_local2 <= 50 then
        f24_arg1:AddSubGoal(GOAL_COMMON_ComboRepeat, 10, 3050, TARGET_ENE_0, 9999, f24_local0, f24_local1, 0, 0)
        f24_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3001, TARGET_ENE_0, 9999, 0, 0)
    else
        f24_arg1:AddSubGoal(GOAL_COMMON_ComboRepeat, 10, 3050, TARGET_ENE_0, 9999, f24_local0, f24_local1, 0, 0)
        f24_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3002, TARGET_ENE_0, 9999, 0, 0)
    end
    
end

Goal.Kengeki02 = function (f25_arg0, f25_arg1, f25_arg2)
    f25_arg1:ClearSubGoal()
    f25_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 1, 3051, TARGET_ENE_0, 9999, 0, 0)
    
end

Goal.Kengeki03 = function (f26_arg0, f26_arg1, f26_arg2)
    f26_arg1:ClearSubGoal()
    f26_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 1, 3052, TARGET_ENE_0, 9999, 0, 0)
    
end

Goal.Kengeki04 = function (f27_arg0, f27_arg1, f27_arg2)
    f27_arg1:ClearSubGoal()
    f27_arg1:AddSubGoal(GOAL_COMMON_ComboRepeat, 3, 3053, TARGET_ENE_0, 9999, TurnTime, FrontAngle, 0, 0)
    f27_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3004, TARGET_ENE_0, 9999, 0, 0)
    
end

Goal.Kengeki05 = function (f28_arg0, f28_arg1, f28_arg2)
    f28_arg1:ClearSubGoal()
    local f28_local0 = 0
    local f28_local1 = 0
    local f28_local2 = f28_arg0:GetRandam_Int(1, 100)
    if f28_local2 <= 50 then
        f28_arg1:AddSubGoal(GOAL_COMMON_ComboRepeat, 3, 3055, TARGET_ENE_0, 9999, f28_local0, f28_local1, 0, 0)
        f28_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 1, 3001, TARGET_ENE_0, 9999, 0, 0)
    else
        f28_arg1:AddSubGoal(GOAL_COMMON_ComboRepeat, 3, 3055, TARGET_ENE_0, 9999, f28_local0, f28_local1, 0, 0)
        f28_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 1, 3002, TARGET_ENE_0, 9999, 0, 0)
    end
    
end

Goal.Kengeki06 = function (f29_arg0, f29_arg1, f29_arg2)
    f29_arg1:ClearSubGoal()
    f29_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 1, 3056, TARGET_ENE_0, 9999, 0, 0)
    
end

Goal.Kengeki07 = function (f30_arg0, f30_arg1, f30_arg2)
    f30_arg1:ClearSubGoal()
    f30_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 1, 3057, TARGET_ENE_0, 9999, 0, 0)
    
end

Goal.Kengeki08 = function (f31_arg0, f31_arg1, f31_arg2)
    f31_arg1:ClearSubGoal()
    f31_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 1, 3058, TARGET_ENE_0, 9999, 0, 0)
    
end

Goal.Kengeki09 = function (f32_arg0, f32_arg1, f32_arg2)
    f32_arg1:ClearSubGoal()
    f32_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 1, 3059, TARGET_ENE_0, 9999, 0, 0)
    
end

Goal.Kengeki10 = function (f33_arg0, f33_arg1, f33_arg2)
    local f33_local0 = f33_arg0:GetHpRate(TARGET_SELF)
    f33_arg1:ClearSubGoal()
    if f33_local0 <= 0.5 then
        f33_arg1:AddSubGoal(GOAL_COMMON_ComboRepeat, 5, 3060, TARGET_ENE_0, 9999, 0, 0, 0, 0)
        f33_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 1, 3073, TARGET_ENE_0, 9999, 0, 0)
    else
        f33_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 1, 3060, TARGET_ENE_0, 9999, 0, 0)
    end
    f33_arg0:SetTimer(0, 15)
    
end

Goal.Kengeki11 = function (f34_arg0, f34_arg1, f34_arg2)
    local f34_local0 = f34_arg0:GetHpRate(TARGET_SELF)
    f34_arg1:ClearSubGoal()
    if f34_local0 <= 0.5 then
        f34_arg1:AddSubGoal(GOAL_COMMON_ComboRepeat, 5, 3065, TARGET_ENE_0, 9999, 0, 0, 0, 0)
        f34_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 1, 3073, TARGET_ENE_0, 9999, 0, 0)
    else
        f34_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 1, 3065, TARGET_ENE_0, 9999, 0, 0)
    end
    f34_arg0:SetTimer(0, 15)
    
end

Goal.Kengeki12 = function (f35_arg0, f35_arg1, f35_arg2)
    f35_arg1:ClearSubGoal()
    f35_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 1, 3070, TARGET_ENE_0, 9999, 0, 0)
    
end

Goal.Kengeki13 = function (f36_arg0, f36_arg1, f36_arg2)
    f36_arg1:ClearSubGoal()
    f36_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 1, 3071, TARGET_ENE_0, 9999, 0, 0)
    
end

Goal.Kengeki14 = function (f37_arg0, f37_arg1, f37_arg2)
    local f37_local0 = 0
    local f37_local1 = 0
    f37_arg1:ClearSubGoal()
    f37_arg1:AddSubGoal(GOAL_COMMON_ComboRepeat, 5, 3072, TARGET_ENE_0, 9999, f37_local0, f37_local1, 0, 0)
    f37_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 1, 3073, TARGET_ENE_0, 9999, 0, 0)
    
end

Goal.NoAction = function (f38_arg0, f38_arg1, f38_arg2)
    return -1
    
end

Goal.ActAfter_AdjustSpace = function (f39_arg0, f39_arg1, f39_arg2)
    
end

Goal.Update = function (f40_arg0, f40_arg1, f40_arg2)
    return Update_Default_NoSubGoal(f40_arg0, f40_arg1, f40_arg2)
    
end

Goal.Terminate = function (f41_arg0, f41_arg1, f41_arg2)
    
end

RegisterTableGoal(GOAL_YashazaruKenzoku_nitou_125030_AfterAttackAct, "GOAL_YashazaruKenzoku_nitou_125030_AfterAttackAct")
REGISTER_GOAL_NO_SUB_GOAL(GOAL_YashazaruKenzoku_nitou_125030_AfterAttackAct, true)

Goal.Activate = function (f42_arg0, f42_arg1, f42_arg2)
    
end

Goal.Update = function (f43_arg0, f43_arg1, f43_arg2)
    return Update_Default_NoSubGoal(f43_arg0, f43_arg1, f43_arg2)
    
end


