RegisterTableGoal(GOAL_KaitenSoujutusi_106000_Battle, "GOAL_KaitenSoujutusi_106000_Battle")
REGISTER_GOAL_NO_UPDATE(GOAL_KaitenSoujutusi_106000_Battle, true)

Goal.Initialize = function (f1_arg0, f1_arg1, f1_arg2, f1_arg3)
    
end

Goal.Activate = function (f2_arg0, f2_arg1, f2_arg2)
    Init_Pseudo_Global(f2_arg1, f2_arg2)
    f2_arg1:AddObserveSpecialEffectAttribute(TARGET_SELF, 5025)
    f2_arg1:AddObserveRegion(1, TARGET_SELF, 2002651)
    Set_ConsecutiveGuardCount_Interrupt(f2_arg1)
    if f2_arg0.Kengeki_Activate(f2_arg0, f2_arg1, f2_arg2) then
        return
    end
    local f2_local0 = {}
    local f2_local1 = {}
    local f2_local2 = {}
    Common_Clear_Param(f2_local0, f2_local1, f2_local2)
    local f2_local3 = f2_arg1:GetDist(TARGET_ENE_0)
    local f2_local4 = f2_arg1:GetDistY(TARGET_ENE_0)
    local f2_local5 = f2_arg1:GetExcelParam(AI_EXCEL_THINK_PARAM_TYPE__thinkAttr_doAdmirer)
    local f2_local6 = Check_ReachAttack(f2_arg1, 0)
    if Common_ActivateAct(f2_arg1, f2_arg2) then
    elseif f2_local6 ~= POSSIBLE_ATTACK then
        if f2_local5 == 1 and f2_arg1:GetTeamOrder(ORDER_TYPE_Role) == ROLE_TYPE_Kankyaku then
            f2_local0[27] = 100
        elseif f2_local5 == 1 and f2_arg1:GetTeamOrder(ORDER_TYPE_Role) == ROLE_TYPE_Torimaki then
            f2_local0[27] = 100
        elseif f2_local6 == UNREACH_ATTACK then
            f2_local0[14] = 1000
            f2_local0[27] = 100
        elseif f2_local6 == REACH_ATTACK_TARGET_HIGH_POSITION then
            f2_local0[1] = 100
            f2_local0[10] = 100
            f2_local0[27] = 100
        elseif f2_local6 == REACH_ATTACK_TARGET_LOW_POSITION then
            f2_local0[1] = 150
            f2_local0[14] = 100
            f2_local0[27] = 100
        else
            f2_local0[27] = 100
        end
    elseif f2_local5 == 1 and f2_arg1:GetTeamOrder(ORDER_TYPE_Role) == ROLE_TYPE_Kankyaku then
        if KankyakuAct(f2_arg1, f2_arg2, -1, 20) then
            f2_local0[9] = 100
            f2_local0[14] = 1
            f2_local0[22] = 100
        end
    elseif f2_local5 == 1 and f2_arg1:GetTeamOrder(ORDER_TYPE_Role) == ROLE_TYPE_Torimaki then
        if TorimakiAct(f2_arg1, f2_arg2) then
            f2_local0[9] = 100
            f2_local0[14] = 500
            f2_local0[22] = 100
        end
    elseif f2_arg1:IsInsideTarget(TARGET_ENE_0, AI_DIR_TYPE_B, 180) then
        if f2_local3 > 7 then
            f2_local0[21] = 50
            f2_local0[22] = 50
        elseif f2_local3 > 5 then
            f2_local0[21] = 50
            f2_local0[22] = 50
        else
            f2_local0[21] = 50
            f2_local0[22] = 50
        end
    elseif f2_local4 > 1.8 or f2_local4 < -1.8 then
        f2_local0[1] = 200
        f2_local0[10] = 100
        f2_local0[11] = 100
    elseif f2_arg1:HasSpecialEffectId(TARGET_ENE_0, COMMON_SP_EFFECT_PC_BREAK) then
        if f2_local3 >= 7 then
            f2_local0[2] = 100
            f2_local0[4] = 1000
        else
            f2_local0[10] = 100
        end
    elseif f2_local3 >= 12 then
        f2_local0[1] = 0
        f2_local0[2] = 250
        f2_local0[3] = 250
        f2_local0[4] = 200
        f2_local0[5] = 100
        f2_local0[6] = 100
        f2_local0[9] = 1800
        f2_local0[10] = 0
        f2_local0[11] = 0
    elseif f2_local3 > 7 then
        f2_local0[1] = 0
        f2_local0[2] = 250
        f2_local0[3] = 250
        f2_local0[4] = 200
        f2_local0[5] = 100
        f2_local0[6] = 100
        f2_local0[7] = 0
        f2_local0[9] = 1100
        f2_local0[10] = 0
        f2_local0[11] = 0
    elseif f2_local3 > 5 then
        f2_local0[1] = 0
        f2_local0[4] = 200
        f2_local0[7] = 200
        f2_local0[8] = 100
        f2_local0[10] = 0
        f2_local0[11] = 0
        f2_local0[22] = 1
        f2_local0[24] = 100
    else
        f2_local0[1] = 200
        f2_local0[7] = 200
        f2_local0[8] = 100
        f2_local0[10] = 100
        f2_local0[11] = 200
        f2_local0[22] = 1
        f2_local0[24] = 100
    end
    if f2_arg1:IsFinishTimer(1) == false then
        f2_local0[9] = 1
        f2_local0[23] = 1
    end
    if f2_arg1:GetStringIndexedNumber("FirstCheck") == 0 then
        f2_local0[9] = 0
    end
    f2_arg1:SetStringIndexedNumber("FirstCheck", 1)
    if f2_arg1:GetSpRate(TARGET_SELF) > 0.75 and f2_arg1:GetHpRate(TARGET_SELF) > 0.75 or f2_arg1:IsInsideTargetRegion(TARGET_SELF, 2002651) then
        f2_local0[4] = 0
    end
    if SpaceCheck(f2_arg1, f2_arg2, 45, 3) == false and SpaceCheck(f2_arg1, f2_arg2, -45, 3) == false then
        f2_local0[22] = 0
    end
    if SpaceCheck(f2_arg1, f2_arg2, 90, 1) == false and SpaceCheck(f2_arg1, f2_arg2, -45, 1) == false then
        f2_local0[23] = 0
    end
    if SpaceCheck(f2_arg1, f2_arg2, 180, 3) == false then
        f2_local0[14] = f2_local0[7]
        f2_local0[24] = 0
    end
    if SpaceCheck(f2_arg1, f2_arg2, 0, 7) == false then
        f2_local0[8] = 0
    end
    f2_local0[1] = SetCoolTime(f2_arg1, f2_arg2, 3000, 8, f2_local0[1], 1)
    f2_local0[2] = SetCoolTime(f2_arg1, f2_arg2, 3003, 5, f2_local0[2], 1)
    f2_local0[3] = SetCoolTime(f2_arg1, f2_arg2, 3004, 5, f2_local0[3], 1)
    f2_local0[4] = SetCoolTime(f2_arg1, f2_arg2, 3005, 5, f2_local0[4], 1)
    f2_local0[5] = SetCoolTime(f2_arg1, f2_arg2, 3006, 5, f2_local0[5], 1)
    f2_local0[6] = SetCoolTime(f2_arg1, f2_arg2, 3007, 5, f2_local0[6], 1)
    f2_local0[7] = SetCoolTime(f2_arg1, f2_arg2, 3008, 5, f2_local0[7], 1)
    f2_local0[8] = SetCoolTime(f2_arg1, f2_arg2, 3009, 5, f2_local0[8], 1)
    f2_local0[9] = SetCoolTime(f2_arg1, f2_arg2, 3010, 5, f2_local0[9], 1)
    f2_local0[9] = SetCoolTime(f2_arg1, f2_arg2, 3011, 5, f2_local0[9], 1)
    f2_local0[10] = SetCoolTime(f2_arg1, f2_arg2, 3012, 5, f2_local0[10], 1)
    f2_local0[11] = SetCoolTime(f2_arg1, f2_arg2, 3013, 5, f2_local0[11], 1)
    f2_local0[12] = SetCoolTime(f2_arg1, f2_arg2, 3014, 10, f2_local0[12], 1)
    f2_local0[14] = SetCoolTime(f2_arg1, f2_arg2, 3018, 8, f2_local0[14], 1)
    f2_local0[22] = SetCoolTime(f2_arg1, f2_arg2, 5202, 5, f2_local0[22], 1)
    f2_local0[22] = SetCoolTime(f2_arg1, f2_arg2, 5203, 5, f2_local0[22], 1)
    f2_local0[24] = SetCoolTime(f2_arg1, f2_arg2, 5211, 5, f2_local0[22], 1)
    f2_local1[1] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act01)
    f2_local1[2] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act02)
    f2_local1[3] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act03)
    f2_local1[4] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act04)
    f2_local1[5] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act05)
    f2_local1[6] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act06)
    f2_local1[7] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act07)
    f2_local1[8] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act08)
    f2_local1[9] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act09)
    f2_local1[10] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act10)
    f2_local1[11] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act11)
    f2_local1[12] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act12)
    f2_local1[14] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act14)
    f2_local1[21] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act21)
    f2_local1[22] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act22)
    f2_local1[23] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act23)
    f2_local1[24] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act24)
    f2_local1[25] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act25)
    f2_local1[26] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act26)
    f2_local1[27] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act27)
    f2_local1[28] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act28)
    f2_local1[41] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act41)
    f2_local1[42] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act42)
    f2_local1[43] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act43)
    local f2_local7 = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.ActAfter_AdjustSpace)
    Common_Battle_Activate(f2_arg1, f2_arg2, f2_local0, f2_local1, f2_local7, f2_local2)
    
end

Goal.Act01 = function (f3_arg0, f3_arg1, f3_arg2)
    local f3_local0 = 4.6 - f3_arg0:GetMapHitRadius(TARGET_SELF)
    local f3_local1 = 4.6 - f3_arg0:GetMapHitRadius(TARGET_SELF) + 0
    local f3_local2 = 4.6 - f3_arg0:GetMapHitRadius(TARGET_SELF) + 2
    local f3_local3 = 100
    local f3_local4 = 0
    local f3_local5 = 3
    local f3_local6 = 6
    Approach_Act_Flex(f3_arg0, f3_arg1, f3_local0, f3_local1, f3_local2, f3_local3, f3_local4, f3_local5, f3_local6)
    local f3_local7 = 0
    local f3_local8 = 0
    local f3_local9 = f3_arg0:GetRandam_Int(1, 100)
    if f3_local9 <= 60 then
        f3_arg1:AddSubGoal(GOAL_COMMON_ComboAttackTunableSpin, 10, 3000, TARGET_ENE_0, 4.8 - f3_arg0:GetMapHitRadius(TARGET_SELF), f3_local7, f3_local8, 0, 0)
        f3_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3001, TARGET_ENE_0, 9999, 0, 0)
    else
        f3_arg1:AddSubGoal(GOAL_COMMON_ComboAttackTunableSpin, 10, 3000, TARGET_ENE_0, 6.8 - f3_arg0:GetMapHitRadius(TARGET_SELF), f3_local7, f3_local8, 0, 0)
        f3_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3015, TARGET_ENE_0, 9999, 0, 0)
    end
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act02 = function (f4_arg0, f4_arg1, f4_arg2)
    local f4_local0 = 8.6 - f4_arg0:GetMapHitRadius(TARGET_SELF)
    local f4_local1 = 8.6 - f4_arg0:GetMapHitRadius(TARGET_SELF) + 0
    local f4_local2 = 8.6 - f4_arg0:GetMapHitRadius(TARGET_SELF) + 2
    local f4_local3 = 100
    local f4_local4 = 0
    local f4_local5 = 3
    local f4_local6 = 6
    Approach_Act_Flex(f4_arg0, f4_arg1, f4_local0, f4_local1, f4_local2, f4_local3, f4_local4, f4_local5, f4_local6, 1)
    local f4_local7 = 0
    local f4_local8 = 0
    f4_arg1:AddSubGoal(GOAL_COMMON_ComboAttackTunableSpin, 10, 3003, TARGET_ENE_0, 999, f4_local7, f4_local8, 0, 0)
    f4_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3004, TARGET_ENE_0, 9999, 0, 0)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act03 = function (f5_arg0, f5_arg1, f5_arg2)
    f5_arg1:ClearSubGoal()
    local f5_local0 = 7.9 - f5_arg0:GetMapHitRadius(TARGET_SELF)
    local f5_local1 = 7.9 - f5_arg0:GetMapHitRadius(TARGET_SELF) + 0
    local f5_local2 = 7.9 - f5_arg0:GetMapHitRadius(TARGET_SELF) + 2
    local f5_local3 = 100
    local f5_local4 = 0
    local f5_local5 = 3
    local f5_local6 = 6
    Approach_Act_Flex(f5_arg0, f5_arg1, f5_local0, f5_local1, f5_local2, f5_local3, f5_local4, f5_local5, f5_local6)
    local f5_local7 = 0
    local f5_local8 = 0
    f5_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 10, 3004, TARGET_ENE_0, 9999, f5_local7, f5_local8, 0, 0)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act04 = function (f6_arg0, f6_arg1, f6_arg2)
    local f6_local0 = 11.8 - f6_arg0:GetMapHitRadius(TARGET_SELF)
    local f6_local1 = 11.8 - f6_arg0:GetMapHitRadius(TARGET_SELF) + 0
    local f6_local2 = 11.8 - f6_arg0:GetMapHitRadius(TARGET_SELF) + 2
    local f6_local3 = 100
    local f6_local4 = 0
    local f6_local5 = 3
    local f6_local6 = 6
    Approach_Act_Flex(f6_arg0, f6_arg1, f6_local0, f6_local1, f6_local2, f6_local3, f6_local4, f6_local5, f6_local6)
    local f6_local7 = 3005
    local f6_local8 = 0
    local f6_local9 = 0
    f6_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 10, f6_local7, TARGET_ENE_0, 9999, f6_local8, f6_local9, 0, 0)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act05 = function (f7_arg0, f7_arg1, f7_arg2)
    local f7_local0 = 14 - f7_arg0:GetMapHitRadius(TARGET_SELF)
    local f7_local1 = 14 - f7_arg0:GetMapHitRadius(TARGET_SELF) + 0
    local f7_local2 = 14 - f7_arg0:GetMapHitRadius(TARGET_SELF) + 2
    local f7_local3 = 100
    local f7_local4 = 0
    local f7_local5 = 3
    local f7_local6 = 6
    Approach_Act_Flex(f7_arg0, f7_arg1, f7_local0, f7_local1, f7_local2, f7_local3, f7_local4, f7_local5, f7_local6)
    local f7_local7 = 3006
    local f7_local8 = 0
    local f7_local9 = 0
    f7_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 10, f7_local7, TARGET_ENE_0, 9999, f7_local8, f7_local9, 0, 0)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act06 = function (f8_arg0, f8_arg1, f8_arg2)
    local f8_local0 = 14 - f8_arg0:GetMapHitRadius(TARGET_SELF)
    local f8_local1 = 14 - f8_arg0:GetMapHitRadius(TARGET_SELF) + 0
    local f8_local2 = 14 - f8_arg0:GetMapHitRadius(TARGET_SELF) + 2
    local f8_local3 = 100
    local f8_local4 = 0
    local f8_local5 = 3
    local f8_local6 = 6
    Approach_Act_Flex(f8_arg0, f8_arg1, f8_local0, f8_local1, f8_local2, f8_local3, f8_local4, f8_local5, f8_local6)
    local f8_local7 = 3007
    local f8_local8 = 0
    local f8_local9 = 0
    f8_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 10, f8_local7, TARGET_ENE_0, 9999, f8_local8, f8_local9, 0, 0)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act07 = function (f9_arg0, f9_arg1, f9_arg2)
    local f9_local0 = 3008
    local f9_local1 = 0
    local f9_local2 = 0
    if f9_arg0:GetSpRate(TARGET_SELF) > 0.75 and f9_arg0:GetHpRate(TARGET_SELF) > 0.75 or f9_arg0:IsInsideTargetRegion(TARGET_SELF, 2002651) then
        f9_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 10, f9_local0, TARGET_ENE_0, 9999, f9_local1, f9_local2, 0, 0)
    else
        f9_arg1:AddSubGoal(GOAL_COMMON_ComboAttackTunableSpin, 10, f9_local0, TARGET_ENE_0, 999, f9_local1, f9_local2, 0, 0)
        f9_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3005, TARGET_ENE_0, 9999, 0, 0)
    end
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act08 = function (f10_arg0, f10_arg1, f10_arg2)
    local f10_local0 = 4.7 - f10_arg0:GetMapHitRadius(TARGET_SELF)
    local f10_local1 = 4.7 - f10_arg0:GetMapHitRadius(TARGET_SELF) + 0
    local f10_local2 = 4.7 - f10_arg0:GetMapHitRadius(TARGET_SELF) + 2
    local f10_local3 = 100
    local f10_local4 = 0
    local f10_local5 = 3
    local f10_local6 = 6
    Approach_Act_Flex(f10_arg0, f10_arg1, f10_local0, f10_local1, f10_local2, f10_local3, f10_local4, f10_local5, f10_local6)
    local f10_local7 = 0
    local f10_local8 = 0
    f10_arg1:AddSubGoal(GOAL_COMMON_ComboAttackTunableSpin, 10, 3009, TARGET_ENE_0, 9.5 - f10_arg0:GetMapHitRadius(TARGET_SELF), f10_local7, f10_local8, 0, 0)
    f10_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3016, TARGET_ENE_0, 9999, 0, 0)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act09 = function (f11_arg0, f11_arg1, f11_arg2)
    local f11_local0 = 3010
    local f11_local1 = 3011
    local f11_local2 = 0
    local f11_local3 = 0
    local f11_local4 = f11_arg0:GetRandam_Int(1, 100)
    local f11_local5 = f11_arg0:GetRandam_Float(0.5, 1.5)
    local f11_local6 = f11_arg0:GetRandam_Float(0.5, 1.5)
    local f11_local7 = f11_arg0:GetRandam_Int(30, 45)
    if f11_local4 <= 50 then
        f11_arg1:AddSubGoal(GOAL_COMMON_SidewayMove, f11_local5, TARGET_ENE_0, 0, f11_local7, true, true, -1):TimingSetTimer(1, 6, UPDATE_SUCCESS)
        f11_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 10, f11_local0, TARGET_ENE_0, 9999, f11_local2, f11_local3, 0, 0)
    else
        f11_arg1:AddSubGoal(GOAL_COMMON_SidewayMove, f11_local5, TARGET_ENE_0, 1, f11_local7, true, true, -1):TimingSetTimer(1, 6, UPDATE_SUCCESS)
        f11_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 10, f11_local1, TARGET_ENE_0, 9999, f11_local2, f11_local3, 0, 0)
    end
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act10 = function (f12_arg0, f12_arg1, f12_arg2)
    local f12_local0 = 5.6 - f12_arg0:GetMapHitRadius(TARGET_SELF)
    local f12_local1 = 5.6 - f12_arg0:GetMapHitRadius(TARGET_SELF) + 0
    local f12_local2 = 5.6 - f12_arg0:GetMapHitRadius(TARGET_SELF) + 2
    local f12_local3 = 100
    local f12_local4 = 0
    local f12_local5 = 3
    local f12_local6 = 6
    Approach_Act_Flex(f12_arg0, f12_arg1, f12_local0, f12_local1, f12_local2, f12_local3, f12_local4, f12_local5, f12_local6)
    local f12_local7 = 3012
    local f12_local8 = 0
    local f12_local9 = 0
    f12_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 10, f12_local7, TARGET_ENE_0, 9999, f12_local8, f12_local9, 0, 0)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act11 = function (f13_arg0, f13_arg1, f13_arg2)
    local f13_local0 = 3.3 - f13_arg0:GetMapHitRadius(TARGET_SELF) - 0.5
    local f13_local1 = 3.3 - f13_arg0:GetMapHitRadius(TARGET_SELF) + 0
    local f13_local2 = 3.3 - f13_arg0:GetMapHitRadius(TARGET_SELF) + 2
    local f13_local3 = 100
    local f13_local4 = 0
    local f13_local5 = 3
    local f13_local6 = 6
    Approach_Act_Flex(f13_arg0, f13_arg1, f13_local0, f13_local1, f13_local2, f13_local3, f13_local4, f13_local5, f13_local6)
    local f13_local7 = 0
    local f13_local8 = 0
    f13_arg1:AddSubGoal(GOAL_COMMON_ComboAttackTunableSpin, 10, 3013, TARGET_ENE_0, 4.2 - f13_arg0:GetMapHitRadius(TARGET_SELF), f13_local7, f13_local8, 0, 0)
    f13_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3017, TARGET_ENE_0, 9999, 0, 0)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act12 = function (f14_arg0, f14_arg1, f14_arg2)
    local f14_local0 = 4.3 - f14_arg0:GetMapHitRadius(TARGET_SELF)
    local f14_local1 = 4.3 - f14_arg0:GetMapHitRadius(TARGET_SELF) + 0
    local f14_local2 = 4.3 - f14_arg0:GetMapHitRadius(TARGET_SELF) + 2
    local f14_local3 = 100
    local f14_local4 = 0
    local f14_local5 = 3
    local f14_local6 = 6
    Approach_Act_Flex(f14_arg0, f14_arg1, f14_local0, f14_local1, f14_local2, f14_local3, f14_local4, f14_local5, f14_local6)
    local f14_local7 = 3014
    local f14_local8 = 0
    local f14_local9 = 0
    f14_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 10, f14_local7, TARGET_ENE_0, 9999, f14_local8, f14_local9, 0, 0)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act13 = function (f15_arg0, f15_arg1, f15_arg2)
    local f15_local0 = 4.6 - f15_arg0:GetMapHitRadius(TARGET_SELF)
    local f15_local1 = 4.6 - f15_arg0:GetMapHitRadius(TARGET_SELF) + 0
    local f15_local2 = 4.6 - f15_arg0:GetMapHitRadius(TARGET_SELF) + 2
    local f15_local3 = 100
    local f15_local4 = 0
    local f15_local5 = 3
    local f15_local6 = 6
    Approach_Act_Flex(f15_arg0, f15_arg1, f15_local0, f15_local1, f15_local2, f15_local3, f15_local4, f15_local5, f15_local6)
    local f15_local7 = 3000
    local f15_local8 = 3014
    local f15_local9 = 0
    local f15_local10 = 0
    f15_arg1:AddSubGoal(GOAL_COMMON_ComboAttackTunableSpin, 10, f15_local7, TARGET_ENE_0, 4.3 - f15_arg0:GetMapHitRadius(TARGET_SELF), f15_local9, f15_local10, 0, 0)
    f15_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, f15_local8, TARGET_ENE_0, 9999, 0, 0)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act14 = function (f16_arg0, f16_arg1, f16_arg2)
    local f16_local0 = 3018
    local f16_local1 = 0
    local f16_local2 = 0
    f16_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 10, f16_local0, TARGET_ENE_0, 9999, f16_local1, f16_local2, 0, 0)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act21 = function (f17_arg0, f17_arg1, f17_arg2)
    local f17_local0 = 3
    local f17_local1 = 45
    f17_arg1:AddSubGoal(GOAL_COMMON_Turn, f17_local0, TARGET_ENE_0, f17_local1, -1, GOAL_RESULT_Success, true)
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
    
end

Goal.Act22 = function (f18_arg0, f18_arg1, f18_arg2)
    local f18_local0 = 3
    local f18_local1 = 0
    local f18_local2 = f18_arg0:GetRandam_Int(1, 100)
    local f18_local3 = f18_arg0:GetRandam_Int(0, 1)
    if SpaceCheck(f18_arg0, f18_arg1, -45, 3) == true then
        if SpaceCheck(f18_arg0, f18_arg1, 45, 3) == true then
            if f18_local2 <= 50 then
                f18_arg1:AddSubGoal(GOAL_COMMON_SpinStep, f18_local0, 5202, TARGET_ENE_0, f18_local1, AI_DIR_TYPE_L, 0)
                if f18_local2 <= 25 then
                    f18_arg1:AddSubGoal(GOAL_COMMON_SpinStep, f18_local0, 5212, TARGET_ENE_0, f18_local1, AI_DIR_TYPE_L, 0)
                end
            else
                f18_arg1:AddSubGoal(GOAL_COMMON_SpinStep, f18_local0, 5203, TARGET_ENE_0, f18_local1, AI_DIR_TYPE_R, 0)
                if f18_local2 <= 25 then
                    f18_arg1:AddSubGoal(GOAL_COMMON_SpinStep, f18_local0, 5213, TARGET_ENE_0, f18_local1, AI_DIR_TYPE_L, 0)
                end
            end
        else
            f18_arg1:AddSubGoal(GOAL_COMMON_SpinStep, f18_local0, 5202, TARGET_ENE_0, f18_local1, AI_DIR_TYPE_L, 0)
            if f18_local2 <= 25 then
                f18_arg1:AddSubGoal(GOAL_COMMON_SpinStep, f18_local0, 5212, TARGET_ENE_0, f18_local1, AI_DIR_TYPE_L, 0)
            end
        end
    elseif SpaceCheck(f18_arg0, f18_arg1, 45, 3) == true then
        f18_arg1:AddSubGoal(GOAL_COMMON_SpinStep, f18_local0, 5203, TARGET_ENE_0, f18_local1, AI_DIR_TYPE_R, 0)
        if f18_local2 <= 25 then
            f18_arg1:AddSubGoal(GOAL_COMMON_SpinStep, f18_local0, 5213, TARGET_ENE_0, f18_local1, AI_DIR_TYPE_L, 0)
        end
    else
        f18_arg1:AddSubGoal(GOAL_COMMON_SpinStep, f18_local0, 5202, TARGET_ENE_0, f18_local1, AI_DIR_TYPE_L, 0)
    end
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
    
end

Goal.Act23 = function (f19_arg0, f19_arg1, f19_arg2)
    local f19_local0 = f19_arg0:GetDist(TARGET_ENE_0)
    local f19_local1 = -1
    local f19_local2 = 0
    if SpaceCheck(f19_arg0, f19_arg1, -90, 1) == true then
        if SpaceCheck(f19_arg0, f19_arg1, 90, 1) == true then
            if f19_arg0:IsInsideTarget(TARGET_ENE_0, AI_DIR_TYPE_R, 180) then
                f19_local2 = 0
            else
                f19_local2 = 1
            end
        else
            f19_local2 = 0
        end
    elseif SpaceCheck(f19_arg0, f19_arg1, 90, 1) == true then
        f19_local2 = 1
    else
    end
    f19_arg0:SetNumber(10, f19_local2)
    local f19_local3 = 180
    local f19_local4 = 7
    f19_arg0:AddObserveArea(0, TARGET_SELF, TARGET_ENE_0, AI_DIR_TYPE_F, f19_local3, f19_local4)
    local f19_local5 = f19_arg0:GetRandam_Float(1, 2)
    local f19_local6 = f19_arg0:GetRandam_Int(30, 45)
    f19_arg1:AddSubGoal(GOAL_COMMON_SidewayMove, f19_local5, TARGET_ENE_0, f19_local2, f19_local6, true, true, f19_local1):TimingSetTimer(1, 6, UPDATE_SUCCESS)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act24 = function (f20_arg0, f20_arg1, f20_arg2)
    local f20_local0 = 3
    local f20_local1 = 0
    f20_arg1:AddSubGoal(GOAL_COMMON_SpinStep, f20_local0, 5211, TARGET_ENE_0, f20_local1, AI_DIR_TYPE_B, 0)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act25 = function (f21_arg0, f21_arg1, f21_arg2)
    local f21_local0 = f21_arg0:GetRandam_Float(2, 4)
    local f21_local1 = f21_arg0:GetRandam_Float(1, 3)
    local f21_local2 = -1
    f21_arg1:AddSubGoal(GOAL_COMMON_LeaveTarget, f21_local0, TARGET_ENE_0, f21_local1, TARGET_ENE_0, true, f21_local2)
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
    
end

Goal.Act26 = function (f22_arg0, f22_arg1, f22_arg2)
    f22_arg1:AddSubGoal(GOAL_COMMON_Wait, 0.5, TARGET_SELF, 0, 0, 0)
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
    
end

Goal.Act27 = function (f23_arg0, f23_arg1, f23_arg2)
    local f23_local0 = f23_arg0:GetRandam_Int(1, 100)
    if YousumiAct_SubGoal(f23_arg0, f23_arg1, true, 60, 30) == false then
        GetWellSpace_Odds = 0
        return GetWellSpace_Odds
    end
    local f23_local1 = 0
    local f23_local2 = SpaceCheck_SidewayMove(f23_arg0, f23_arg1, 1)
    if f23_local2 == 0 then
        f23_local1 = 0
    elseif f23_local2 == 1 then
        f23_local1 = 1
    elseif f23_local2 == 2 then
        if f23_local0 <= 50 then
            f23_local1 = 0
        else
            f23_local1 = 1
        end
    else
        f23_arg1:AddSubGoal(GOAL_COMMON_Wait, 0.5, TARGET_SELF, 0, 0, 0)
        GetWellSpace_Odds = 0
        return GetWellSpace_Odds
    end
    f23_arg0:SetNumber(10, f23_local1)
    f23_arg1:AddSubGoal(GOAL_COMMON_SidewayMove, 3, TARGET_ENE_0, f23_local1, f23_arg0:GetRandam_Int(30, 45), true, true, -1)
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
    
end

Goal.Act28 = function (f24_arg0, f24_arg1, f24_arg2)
    local f24_local0 = f24_arg0:GetDist(TARGET_ENE_0)
    local f24_local1 = 1.5
    local f24_local2 = 1.5
    local f24_local3 = f24_arg0:GetRandam_Int(30, 45)
    local f24_local4 = -1
    local f24_local5 = f24_arg0:GetRandam_Int(0, 1)
    if f24_local0 <= 3 then
        f24_arg1:AddSubGoal(GOAL_COMMON_SidewayMove, f24_local1, TARGET_ENE_0, f24_local5, f24_local3, true, true, f24_local4)
    elseif f24_local0 <= 10 then
        f24_arg1:AddSubGoal(GOAL_COMMON_ApproachTarget, f24_local2, TARGET_ENE_0, 3, TARGET_SELF, true, -1)
    else
        f24_arg1:AddSubGoal(GOAL_COMMON_ApproachTarget, f24_local2, TARGET_ENE_0, 8, TARGET_SELF, false, -1)
    end
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
    
end

Goal.Act41 = function (f25_arg0, f25_arg1, f25_arg2)
    local f25_local0 = 3
    local f25_local1 = 0
    local f25_local2 = 4.5
    local f25_local3 = f25_arg0:GetRandam_Int(30, 45)
    local f25_local4 = f25_arg0:GetRandam_Int(1, 100)
    if SpaceCheck(f25_arg0, f25_arg1, 180, 5) then
        f25_arg1:AddSubGoal(GOAL_COMMON_SpinStep, f25_local0, 5211, TARGET_ENE_0, f25_local1, AI_DIR_TYPE_B, 0)
        f25_local2 = 3.5
    elseif SpaceCheck(f25_arg0, f25_arg1, 90, 2) and SpaceCheck(f25_arg0, f25_arg1, -90, 2) then
        if f25_local4 <= 50 then
            f25_arg1:AddSubGoal(GOAL_COMMON_SpinStep, f25_local0, 5202, TARGET_ENE_0, f25_local1, AI_DIR_TYPE_B, 0)
        else
            f25_arg1:AddSubGoal(GOAL_COMMON_SpinStep, f25_local0, 5203, TARGET_ENE_0, f25_local1, AI_DIR_TYPE_B, 0)
        end
        f25_local2 = 3.5
    elseif SpaceCheck(f25_arg0, f25_arg1, 90, 2) then
        f25_arg1:AddSubGoal(GOAL_COMMON_SpinStep, f25_local0, 5203, TARGET_ENE_0, f25_local1, AI_DIR_TYPE_B, 0)
        f25_local2 = 3.5
    elseif SpaceCheck(f25_arg0, f25_arg1, -90, 2) then
        f25_arg1:AddSubGoal(GOAL_COMMON_SpinStep, f25_local0, 5202, TARGET_ENE_0, f25_local1, AI_DIR_TYPE_B, 0)
        f25_local2 = 3.5
    end
    local f25_local5 = 0
    if SpaceCheck(f25_arg0, f25_arg1, -90, 1) == true then
        if SpaceCheck(f25_arg0, f25_arg1, 90, 1) == true then
            if f25_arg0:IsInsideTarget(TARGET_ENE_0, AI_DIR_TYPE_R, 180) then
                f25_local5 = 0
            else
                f25_local5 = 1
            end
        else
            f25_local5 = 0
        end
    elseif SpaceCheck(f25_arg0, f25_arg1, 90, 1) == true then
        f25_local5 = 1
    else
    end
    f25_arg1:AddSubGoal(GOAL_COMMON_SidewayMove, f25_local2, TARGET_ENE_0, f25_local5, f25_local3, true, true, -1)
    return GETWELLSPACE_ODDS
    
end

Goal.Act42 = function (f26_arg0, f26_arg1, f26_arg2)
    local f26_local0 = 4.6 - f26_arg0:GetMapHitRadius(TARGET_SELF)
    local f26_local1 = 4.6 - f26_arg0:GetMapHitRadius(TARGET_SELF) + 0
    local f26_local2 = 4.6 - f26_arg0:GetMapHitRadius(TARGET_SELF) + 2
    local f26_local3 = 100
    local f26_local4 = 0
    local f26_local5 = 1.5
    local f26_local6 = 3
    Approach_Act_Flex(f26_arg0, f26_arg1, f26_local0, f26_local1, f26_local2, f26_local3, f26_local4, f26_local5, f26_local6)
    local f26_local7 = 0
    local f26_local8 = 0
    local f26_local9 = f26_arg0:GetRandam_Int(1, 100)
    f26_arg1:AddSubGoal(GOAL_COMMON_ComboAttackTunableSpin, 10, 3000, TARGET_ENE_0, 4.8 - f26_arg0:GetMapHitRadius(TARGET_SELF), f26_local7, f26_local8, 0, 0)
    f26_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3001, TARGET_ENE_0, 9999, 0, 0)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act43 = function (f27_arg0, f27_arg1, f27_arg2)
    local f27_local0 = 4.6 - f27_arg0:GetMapHitRadius(TARGET_SELF)
    local f27_local1 = 4.6 - f27_arg0:GetMapHitRadius(TARGET_SELF) + 0
    local f27_local2 = 4.6 - f27_arg0:GetMapHitRadius(TARGET_SELF) + 2
    local f27_local3 = 100
    local f27_local4 = 0
    local f27_local5 = 1.5
    local f27_local6 = 3
    Approach_Act_Flex(f27_arg0, f27_arg1, f27_local0, f27_local1, f27_local2, f27_local3, f27_local4, f27_local5, f27_local6)
    local f27_local7 = 0
    local f27_local8 = 0
    local f27_local9 = f27_arg0:GetRandam_Int(1, 100)
    f27_arg1:AddSubGoal(GOAL_COMMON_ComboAttackTunableSpin, 10, 3000, TARGET_ENE_0, 6.8 - f27_arg0:GetMapHitRadius(TARGET_SELF), f27_local7, f27_local8, 0, 0)
    f27_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3015, TARGET_ENE_0, 9999, 0, 0)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Interrupt = function (f28_arg0, f28_arg1, f28_arg2)
    local f28_local0 = f28_arg1:GetDist(TARGET_ENE_0)
    local f28_local1 = f28_arg1:GetSpecialEffectActivateInterruptType(0)
    if f28_arg1:IsLadderAct(TARGET_SELF) then
        return false
    end
    if not f28_arg1:HasSpecialEffectId(TARGET_SELF, 200004) then
        return false
    end
    if f28_arg1:IsInterupt(INTERUPT_ParryTiming) then
        return Common_Parry(f28_arg1, f28_arg2, 100, 0, 2)
    end
    if f28_arg1:IsInterupt(INTERUPT_Damaged) and f28_arg0.Damaged(f28_arg1, f28_arg2) then
        return true
    end
    if f28_arg1:IsInterupt(INTERUPT_ShootImpact) and f28_arg0.ShootReaction(f28_arg1, f28_arg2) then
        return true
    end
    if f28_arg1:IsInterupt(INTERUPT_LoseSightTarget) and f28_arg1:IsActiveGoal(GOAL_COMMON_SidewayMove) then
        if f28_arg1:GetNumber(10) == 0 then
            f28_arg2:ClearSubGoal()
            f28_arg2:AddSubGoal(GOAL_COMMON_SidewayMove, 1, TARGET_ENE_0, 1, f28_arg1:GetRandam_Int(30, 45), true, true, -1):SetTargetRange(0, -99, 10)
        elseif f28_arg1:GetNumber(10) == 1 then
            f28_arg2:ClearSubGoal()
            f28_arg2:AddSubGoal(GOAL_COMMON_SidewayMove, 1, TARGET_ENE_0, 0, f28_arg1:GetRandam_Int(30, 45), true, true, -1):SetTargetRange(0, -99, 10)
        end
        return true
    end
    if Interupt_PC_Break(f28_arg1) then
        f28_arg1:Replanning()
        return true
    end
    if f28_arg1:IsInterupt(INTERUPT_ActivateSpecialEffect) then
    end
    if f28_arg1:IsInterupt(INTERUPT_Inside_ObserveArea) then
        if f28_arg1:IsInsideObserve(0) then
            f28_arg1:DeleteObserve(0)
            f28_arg1:Replanning()
            return true
        elseif f28_arg1:IsInsideObserve(1) then
            f28_arg1:Replanning()
            return true
        end
    end
    return false
    
end

Goal.Damaged = function (f29_arg0, f29_arg1, f29_arg2)
    local f29_local0 = f29_arg0:GetDist(TARGET_ENE_0)
    local f29_local1 = f29_arg0:GetRandam_Int(1, 100)
    local f29_local2 = 0
    f29_arg1:ClearSubGoal()
    if SpaceCheck(f29_arg0, f29_arg1, 0, 5) == true then
        if f29_local1 <= 50 then
            f29_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 1, 3008, TARGET_ENE_0, 9999, 0, 0)
        else
            f29_arg1:AddSubGoal(GOAL_COMMON_SpinStep, 1, 5211, TARGET_ENE_0, 0, AI_DIR_TYPE_B, 0)
        end
    else
        f29_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 1, 3009, TARGET_ENE_0, 9999, 0, 0)
    end
    
end

Goal.ShootReaction = function (f30_arg0, f30_arg1)
    f30_arg1:ClearSubGoal()
    f30_arg1:AddSubGoal(GOAL_COMMON_EndureAttack, 0.1, 3100, TARGET_ENE_0, 9999, 0)
    return true
    
end

Goal.Kengeki_Activate = function (f31_arg0, f31_arg1, f31_arg2)
    local f31_local0 = ReturnKengekiSpecialEffect(f31_arg1)
    if f31_local0 == 0 then
        return false
    end
    local f31_local1 = {}
    local f31_local2 = {}
    local f31_local3 = {}
    Common_Clear_Param(f31_local1, f31_local2, f31_local3)
    local f31_local4 = f31_arg1:GetDist(TARGET_ENE_0)
    if f31_local0 == 200211 then
        if f31_local4 >= 3 then
        else
            f31_local1[31] = 100
        end
    elseif f31_local0 == 200215 then
        if f31_local4 >= 3 then
        elseif f31_local4 <= 0.2 and false then
        end
    elseif f31_local0 ~= 200216 or f31_local4 >= 3 then
    elseif f31_local4 <= 0.2 then
    else
    end
    if SpaceCheck(f31_arg1, f31_arg2, 45, 3) == false and SpaceCheck(f31_arg1, f31_arg2, -45, 3) == false then
        f31_local1[22] = 0
    end
    if SpaceCheck(f31_arg1, f31_arg2, 180, 3) == false then
        f31_local1[24] = 0
    end
    f31_local1[32] = SetCoolTime(f31_arg1, f31_arg2, 3002, 5, f31_local1[32], 1)
    f31_local2[26] = REGIST_FUNC(f31_arg1, f31_arg2, f31_arg0.NoAction)
    f31_local2[31] = REGIST_FUNC(f31_arg1, f31_arg2, f31_arg0.Kengeki31)
    f31_local2[32] = REGIST_FUNC(f31_arg1, f31_arg2, f31_arg0.Kengeki32)
    f31_local2[33] = REGIST_FUNC(f31_arg1, f31_arg2, f31_arg0.Kengeki33)
    f31_local2[34] = REGIST_FUNC(f31_arg1, f31_arg2, f31_arg0.Kengeki34)
    f31_local2[35] = REGIST_FUNC(f31_arg1, f31_arg2, f31_arg0.Kengeki35)
    f31_local2[36] = REGIST_FUNC(f31_arg1, f31_arg2, f31_arg0.Kengeki36)
    local f31_local5 = REGIST_FUNC(f31_arg1, f31_arg2, f31_arg0.ActAfter_AdjustSpace)
    return Common_Kengeki_Activate(f31_arg1, f31_arg2, f31_local1, f31_local2, f31_local5, f31_local3)
    
end

Goal.Kengeki31 = function (f32_arg0, f32_arg1, f32_arg2)
    f32_arg1:ClearSubGoal()
    f32_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 1, 3009, TARGET_ENE_0, 9999, 0, 0)
    
end

Goal.Kengeki32 = function (f33_arg0, f33_arg1, f33_arg2)
    f33_arg1:ClearSubGoal()
    f33_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 1, 3003, TARGET_ENE_0, 9999, 0, 0)
    
end

Goal.Kengeki33 = function (f34_arg0, f34_arg1, f34_arg2)
    f34_arg1:ClearSubGoal()
    f34_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 1, 3008, TARGET_ENE_0, 9999, 0, 0)
    
end

Goal.Kengeki34 = function (f35_arg0, f35_arg1, f35_arg2)
    f35_arg1:ClearSubGoal()
    f35_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 1, 3005, TARGET_ENE_0, 9999, 0, 0)
    
end

Goal.Kengeki35 = function (f36_arg0, f36_arg1, f36_arg2)
    f36_arg1:ClearSubGoal()
    f36_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 1, 3013, TARGET_ENE_0, 9999, 0, 0)
    
end

Goal.Kengeki36 = function (f37_arg0, f37_arg1, f37_arg2)
    f37_arg1:ClearSubGoal()
    f37_arg1:AddSubGoal(GOAL_COMMON_ComboAttackTunableSpin, 10, 3000, TARGET_ENE_0, 5.2, 0, 0, 0, 0)
    f37_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3001, TARGET_ENE_0, 9999, 0, 0)
    
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


