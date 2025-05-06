RegisterTableGoal(GOAL_SamuraiTaisho_102020_Battle, "GOAL_SamuraiTaisho_102020_Battle")
REGISTER_GOAL_NO_UPDATE(GOAL_Template_XXXXYY_Battle, true)

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
    local f2_local5 = Check_ReachAttack(f2_arg1, 0)
    f2_arg1:AddObserveSpecialEffectAttribute(TARGET_SELF, 5025)
    f2_arg1:AddObserveSpecialEffectAttribute(TARGET_SELF, 5026)
    f2_arg1:AddObserveSpecialEffectAttribute(TARGET_SELF, 5027)
    f2_arg1:AddObserveSpecialEffectAttribute(TARGET_ENE_0, 109031)
    f2_arg1:AddObserveSpecialEffectAttribute(TARGET_ENE_0, 110125)
    Set_ConsecutiveGuardCount_Interrupt(f2_arg1)
    if f2_arg0.Kengeki_Activate(f2_arg0, f2_arg1, f2_arg2) then
        return
    end
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
            f2_local0[7] = 100
        elseif f2_local5 == REACH_ATTACK_TARGET_LOW_POSITION then
            f2_local0[1] = 100
            f2_local0[7] = 100
        else
            f2_local0[27] = 100
        end
    elseif f2_local4 == 1 and f2_arg1:GetTeamOrder(ORDER_TYPE_Role) == ROLE_TYPE_Kankyaku then
        KankyakuAct(f2_arg1, f2_arg2)
    elseif f2_local4 == 1 and f2_arg1:GetTeamOrder(ORDER_TYPE_Role) == ROLE_TYPE_Torimaki then
        TorimakiAct(f2_arg1, f2_arg2, -1, 0)
    elseif f2_arg1:HasSpecialEffectId(TARGET_ENE_0, COMMON_SP_EFFECT_PC_BREAK) then
        f2_local0[5] = 100
        f2_local0[9] = 100
    elseif f2_local3 >= 7 then
        f2_local0[1] = 10
        f2_local0[2] = 30
        f2_local0[4] = 20
        f2_local0[5] = 100
        f2_local0[6] = 60
        f2_local0[7] = 10
        f2_local0[8] = 40
        f2_local0[10] = 80
    elseif f2_local3 >= 5 then
        f2_local0[1] = 50
        f2_local0[2] = 30
        f2_local0[4] = 20
        f2_local0[6] = 100
        f2_local0[7] = 100
        f2_local0[8] = 100
        f2_local0[10] = 100
        f2_local0[23] = 100
    elseif f2_local3 > 3 then
        f2_local0[1] = 50
        f2_local0[2] = 30
        f2_local0[4] = 20
        f2_local0[6] = 100
        f2_local0[7] = 100
        f2_local0[8] = 10
        f2_local0[10] = 10
        f2_local0[11] = 100
        f2_local0[23] = 100
    else
        f2_local0[1] = 10
        f2_local0[2] = 10
        f2_local0[3] = 100
        f2_local0[4] = 10
        f2_local0[6] = 100
        f2_local0[7] = 100
        f2_local0[8] = 0
        f2_local0[11] = 100
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
    if f2_arg1:IsFinishTimer(0) == false then
        f2_local0[6] = 0
    end
    f2_local0[1] = SetCoolTime(f2_arg1, f2_arg2, 3000, 10, f2_local0[1], 1)
    f2_local0[2] = SetCoolTime(f2_arg1, f2_arg2, 3006, 10, f2_local0[2], 1)
    f2_local0[3] = SetCoolTime(f2_arg1, f2_arg2, 3011, 10, f2_local0[3], 1)
    f2_local0[4] = SetCoolTime(f2_arg1, f2_arg2, 3012, 10, f2_local0[4], 1)
    f2_local0[5] = SetCoolTime(f2_arg1, f2_arg2, 3005, 10, f2_local0[5], 1)
    f2_local0[6] = SetCoolTime(f2_arg1, f2_arg2, 3010, 10, f2_local0[6], 1)
    f2_local0[7] = SetCoolTime(f2_arg1, f2_arg2, 3003, 20, f2_local0[7], 1)
    f2_local0[8] = SetCoolTime(f2_arg1, f2_arg2, 3013, 20, f2_local0[8], 1)
    f2_local0[9] = SetCoolTime(f2_arg1, f2_arg2, 3016, 20, f2_local0[9], 1)
    f2_local0[10] = SetCoolTime(f2_arg1, f2_arg2, 3007, 10, f2_local0[10], 1)
    f2_local0[11] = SetCoolTime(f2_arg1, f2_arg2, 3008, 10, f2_local0[11], 1)
    f2_local0[11] = SetCoolTime(f2_arg1, f2_arg2, 3081, 10, f2_local0[11], 1)
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
    f2_local1[20] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act20)
    f2_local1[30] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act30)
    f2_local1[31] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act31)
    f2_local1[40] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act40)
    f2_local1[41] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act41)
    f2_local1[42] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act42)
    f2_local1[43] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act43)
    f2_local1[21] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act21)
    f2_local1[22] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act22)
    f2_local1[23] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act23)
    f2_local1[24] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act24)
    f2_local1[25] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act25)
    f2_local1[26] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act26)
    f2_local1[27] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act27)
    f2_local1[28] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act28)
    local f2_local6 = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.ActAfter_AdjustSpace)
    Common_Battle_Activate(f2_arg1, f2_arg2, f2_local0, f2_local1, f2_local6, f2_local2)
    
end

Goal.Act01 = function (f3_arg0, f3_arg1, f3_arg2)
    local f3_local0 = 4.8 - f3_arg0:GetMapHitRadius(TARGET_SELF)
    local f3_local1 = 4.8 - f3_arg0:GetMapHitRadius(TARGET_SELF) + 2
    local f3_local2 = 4.8 - f3_arg0:GetMapHitRadius(TARGET_SELF) + 2
    local f3_local3 = 100
    local f3_local4 = 0
    local f3_local5 = 1.5
    local f3_local6 = 3
    Approach_Act_Flex(f3_arg0, f3_arg1, f3_local0, f3_local1, f3_local2, f3_local3, f3_local4, f3_local5, f3_local6)
    local f3_local7 = 4 - f3_arg0:GetMapHitRadius(TARGET_SELF)
    local f3_local8 = 4.6 - f3_arg0:GetMapHitRadius(TARGET_SELF)
    local f3_local9 = 0
    local f3_local10 = 0
    local f3_local11 = f3_arg0:GetRandam_Int(1, 100)
    f3_arg1:AddSubGoal(GOAL_COMMON_ComboAttackTunableSpin, 10, 3015, TARGET_ENE_0, f3_local7, f3_local9, f3_local10, 0, 0)
    f3_arg1:AddSubGoal(GOAL_COMMON_ComboRepeat, 10, 3001, TARGET_ENE_0, 9999, 0)
    f3_arg1:AddSubGoal(GOAL_COMMON_ComboRepeat, 10, 3002, TARGET_ENE_0, 9999, 0)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act02 = function (f4_arg0, f4_arg1, f4_arg2)
    local f4_local0 = 5.4 - f4_arg0:GetMapHitRadius(TARGET_SELF)
    local f4_local1 = 5.4 - f4_arg0:GetMapHitRadius(TARGET_SELF) + 2
    local f4_local2 = 5.4 - f4_arg0:GetMapHitRadius(TARGET_SELF) + 2
    local f4_local3 = 100
    local f4_local4 = 0
    local f4_local5 = 1.5
    local f4_local6 = 3
    Approach_Act_Flex(f4_arg0, f4_arg1, f4_local0, f4_local1, f4_local2, f4_local3, f4_local4, f4_local5, f4_local6)
    local f4_local7 = 0
    local f4_local8 = 0
    f4_arg1:AddSubGoal(GOAL_COMMON_ComboAttackTunableSpin, 10, 3006, TARGET_ENE_0, 9999, f4_local7, f4_local8, 0, 0)
    f4_arg1:AddSubGoal(GOAL_COMMON_ComboRepeat, 10, 3066, TARGET_ENE_0, 9999, 0)
    f4_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3017, TARGET_ENE_0, 9999, 0, 0)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act03 = function (f5_arg0, f5_arg1, f5_arg2)
    local f5_local0 = 3.3 - f5_arg0:GetMapHitRadius(TARGET_SELF)
    local f5_local1 = 3.3 - f5_arg0:GetMapHitRadius(TARGET_SELF) + 2
    local f5_local2 = 3.3 - f5_arg0:GetMapHitRadius(TARGET_SELF) + 2
    local f5_local3 = 100
    local f5_local4 = 0
    local f5_local5 = 1.5
    local f5_local6 = 3
    Approach_Act_Flex(f5_arg0, f5_arg1, f5_local0, f5_local1, f5_local2, f5_local3, f5_local4, f5_local5, f5_local6)
    local f5_local7 = 10 - f5_arg0:GetMapHitRadius(TARGET_SELF)
    local f5_local8 = 5.4 - f5_arg0:GetMapHitRadius(TARGET_SELF)
    local f5_local9 = 0
    local f5_local10 = 0
    local f5_local11 = f5_arg0:GetRandam_Int(1, 100)
    f5_arg1:AddSubGoal(GOAL_COMMON_ComboAttackTunableSpin, 10, 3011, TARGET_ENE_0, f5_local8, f5_local9, f5_local10, 0, 0)
    f5_arg1:AddSubGoal(GOAL_COMMON_ComboRepeat, 10, 3000, TARGET_ENE_0, 9999, 0, 0)
    f5_arg1:AddSubGoal(GOAL_COMMON_ComboRepeat, 10, 3001, TARGET_ENE_0, 9999, 0, 0)
    f5_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3002, TARGET_ENE_0, 9999, 0, 0)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act04 = function (f6_arg0, f6_arg1, f6_arg2)
    local f6_local0 = 6 - f6_arg0:GetMapHitRadius(TARGET_SELF)
    local f6_local1 = 6 - f6_arg0:GetMapHitRadius(TARGET_SELF) + 2
    local f6_local2 = 6 - f6_arg0:GetMapHitRadius(TARGET_SELF) + 2
    local f6_local3 = 100
    local f6_local4 = 0
    local f6_local5 = 1.5
    local f6_local6 = 3
    Approach_Act_Flex(f6_arg0, f6_arg1, f6_local0, f6_local1, f6_local2, f6_local3, f6_local4, f6_local5, f6_local6)
    local f6_local7 = 0
    local f6_local8 = 0
    f6_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 10, 3012, TARGET_ENE_0, 9999, f6_local7, f6_local8, 0, 0)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act05 = function (f7_arg0, f7_arg1, f7_arg2)
    local f7_local0 = 10 - f7_arg0:GetMapHitRadius(TARGET_SELF)
    local f7_local1 = 10 - f7_arg0:GetMapHitRadius(TARGET_SELF) + 2
    local f7_local2 = 10 - f7_arg0:GetMapHitRadius(TARGET_SELF) + 2
    local f7_local3 = 100
    local f7_local4 = 0
    local f7_local5 = 1.5
    local f7_local6 = 3
    Approach_Act_Flex(f7_arg0, f7_arg1, f7_local0, f7_local1, f7_local2, f7_local3, f7_local4, f7_local5, f7_local6)
    local f7_local7 = 0
    local f7_local8 = 0
    f7_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 10, 3005, TARGET_ENE_0, 9999, f7_local7, f7_local8, 0, 0)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act06 = function (f8_arg0, f8_arg1, f8_arg2)
    local f8_local0 = 6 - f8_arg0:GetMapHitRadius(TARGET_SELF)
    local f8_local1 = 6 - f8_arg0:GetMapHitRadius(TARGET_SELF) + 2
    local f8_local2 = 6 - f8_arg0:GetMapHitRadius(TARGET_SELF) + 2
    local f8_local3 = 100
    local f8_local4 = 0
    local f8_local5 = 1.5
    local f8_local6 = 3
    Approach_Act_Flex(f8_arg0, f8_arg1, f8_local0, f8_local1, f8_local2, f8_local3, f8_local4, f8_local5, f8_local6)
    local f8_local7 = 0
    local f8_local8 = 0
    f8_arg1:AddSubGoal(GOAL_COMMON_ComboAttackTunableSpin, 10, 3010, TARGET_ENE_0, 9999, f8_local7, f8_local8, 0, 0)
    f8_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3017, TARGET_ENE_0, 9999, 0, 0)
    f8_arg0:SetTimer(0, 12)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act07 = function (f9_arg0, f9_arg1, f9_arg2)
    local f9_local0 = 4.6 - f9_arg0:GetMapHitRadius(TARGET_SELF)
    local f9_local1 = 4.6 - f9_arg0:GetMapHitRadius(TARGET_SELF) + 2
    local f9_local2 = 4.6 - f9_arg0:GetMapHitRadius(TARGET_SELF) + 2
    local f9_local3 = 100
    local f9_local4 = 0
    local f9_local5 = 1.5
    local f9_local6 = 3
    Approach_Act_Flex(f9_arg0, f9_arg1, f9_local0, f9_local1, f9_local2, f9_local3, f9_local4, f9_local5, f9_local6)
    local f9_local7 = 4.6 - f9_arg0:GetMapHitRadius(TARGET_SELF)
    local f9_local8 = 0
    local f9_local9 = 0
    local f9_local10 = f9_arg0:GetRandam_Int(1, 100)
    f9_arg1:AddSubGoal(GOAL_COMMON_ComboAttackTunableSpin, 10, 3003, TARGET_ENE_0, f9_local7, f9_local8, f9_local9, 0, 0)
    f9_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3004, TARGET_ENE_0, 9999, 0, 0)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act08 = function (f10_arg0, f10_arg1, f10_arg2)
    local f10_local0 = 0
    local f10_local1 = 0
    f10_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 10, 3013, TARGET_ENE_0, 9999, f10_local0, f10_local1, 0, 0)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act09 = function (f11_arg0, f11_arg1, f11_arg2)
    local f11_local0 = 0
    local f11_local1 = 0
    local f11_local2 = 9 - f11_arg0:GetMapHitRadius(TARGET_SELF)
    local f11_local3 = 9 - f11_arg0:GetMapHitRadius(TARGET_SELF) + 2
    local f11_local4 = 9 - f11_arg0:GetMapHitRadius(TARGET_SELF) + 2
    local f11_local5 = 100
    local f11_local6 = 0
    local f11_local7 = 1.5
    local f11_local8 = 3
    Approach_Act_Flex(f11_arg0, f11_arg1, f11_local2, f11_local3, f11_local4, f11_local5, f11_local6, f11_local7, f11_local8)
    local f11_local9 = 4.6 - f11_arg0:GetMapHitRadius(TARGET_SELF)
    local f11_local10 = 0
    local f11_local11 = 0
    local f11_local12 = f11_arg0:GetRandam_Int(1, 100)
    f11_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 10, 3016, TARGET_ENE_0, 9999, f11_local10, f11_local11, 0, 0)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act10 = function (f12_arg0, f12_arg1, f12_arg2)
    local f12_local0 = 7 - f12_arg0:GetMapHitRadius(TARGET_SELF)
    local f12_local1 = 7 - f12_arg0:GetMapHitRadius(TARGET_SELF) + 2
    local f12_local2 = 7 - f12_arg0:GetMapHitRadius(TARGET_SELF) + 2
    local f12_local3 = 100
    local f12_local4 = 0
    local f12_local5 = 1.5
    local f12_local6 = 3
    Approach_Act_Flex(f12_arg0, f12_arg1, f12_local0, f12_local1, f12_local2, f12_local3, f12_local4, f12_local5, f12_local6)
    local f12_local7 = 0
    local f12_local8 = 0
    f12_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 10, 3007, TARGET_ENE_0, 9999, f12_local7, f12_local8, 0, 0)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act20 = function (f13_arg0, f13_arg1, f13_arg2)
    local f13_local0 = 4.8 - f13_arg0:GetMapHitRadius(TARGET_SELF)
    local f13_local1 = 4.8 - f13_arg0:GetMapHitRadius(TARGET_SELF) + 2
    local f13_local2 = 4.8 - f13_arg0:GetMapHitRadius(TARGET_SELF) + 2
    local f13_local3 = 100
    local f13_local4 = 0
    local f13_local5 = 1.5
    local f13_local6 = 3
    Approach_Act_Flex(f13_arg0, f13_arg1, f13_local0, f13_local1, f13_local2, f13_local3, f13_local4, f13_local5, f13_local6)
    local f13_local7 = 4 - f13_arg0:GetMapHitRadius(TARGET_SELF)
    local f13_local8 = 4.6 - f13_arg0:GetMapHitRadius(TARGET_SELF)
    local f13_local9 = 0
    local f13_local10 = 0
    local f13_local11 = f13_arg0:GetRandam_Int(1, 100)
    f13_arg1:AddSubGoal(GOAL_COMMON_ComboAttackTunableSpin, 10, 3090, TARGET_ENE_0, f13_local7, f13_local9, f13_local10, 0, 0)
    f13_arg1:AddSubGoal(GOAL_COMMON_ComboRepeat, 10, 3091, TARGET_ENE_0, 9999, 0)
    f13_arg1:AddSubGoal(GOAL_COMMON_ComboRepeat, 10, 3092, TARGET_ENE_0, 9999, 0)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act11 = function (f14_arg0, f14_arg1, f14_arg2)
    local f14_local0 = 0
    local f14_local1 = 0
    f14_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 10, 3008, TARGET_ENE_0, 9999, f14_local0, f14_local1, 0, 0)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act21 = function (f15_arg0, f15_arg1, f15_arg2)
    local f15_local0 = 3
    local f15_local1 = 45
    f15_arg1:AddSubGoal(GOAL_COMMON_Turn, f15_local0, TARGET_ENE_0, f15_local1, -1, GOAL_RESULT_Success, true)
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
    
end

Goal.Act22 = function (f16_arg0, f16_arg1, f16_arg2)
    local f16_local0 = 3
    local f16_local1 = 0
    local f16_local2 = 5202
    if SpaceCheck(f16_arg0, f16_arg1, -45, 2) == true then
        if SpaceCheck(f16_arg0, f16_arg1, 45, 2) == true then
            if f16_arg0:IsInsideTarget(TARGET_ENE_0, AI_DIR_TYPE_R, 180) then
                f16_local2 = 5202
            else
                f16_local2 = 5203
            end
        else
            f16_local2 = 5202
        end
    elseif SpaceCheck(f16_arg0, f16_arg1, 45, 2) == true then
        f16_local2 = 5203
    else
    end
    f16_arg1:AddSubGoal(GOAL_COMMON_SpinStep, f16_local0, f16_local2, TARGET_ENE_0, f16_local1, AI_DIR_TYPE_R, 0)
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
    
end

Goal.Act23 = function (f17_arg0, f17_arg1, f17_arg2)
    local f17_local0 = f17_arg0:GetDist(TARGET_ENE_0)
    local f17_local1 = f17_arg0:GetSp(TARGET_SELF)
    local f17_local2 = 20
    local f17_local3 = f17_arg0:GetRandam_Int(1, 100)
    local f17_local4 = -1
    local f17_local5 = 0
    if SpaceCheck(f17_arg0, f17_arg1, -90, 1) == true then
        if SpaceCheck(f17_arg0, f17_arg1, 90, 1) == true then
            if f17_arg0:IsInsideTargetEx(TARGET_ENE_0, TARGET_SELF, AI_DIR_TYPE_R, 180, 999) then
                f17_local5 = 1
            else
                f17_local5 = 0
            end
        else
            f17_local5 = 0
        end
    elseif SpaceCheck(f17_arg0, f17_arg1, 90, 1) == true then
        f17_local5 = 1
    else
    end
    local f17_local6 = 3
    local f17_local7 = f17_arg0:GetRandam_Int(30, 45)
    f17_arg0:SetNumber(10, f17_local5)
    f17_arg1:AddSubGoal(GOAL_COMMON_SidewayMove, f17_local6, TARGET_ENE_0, f17_local5, f17_local7, true, true, f17_local4)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act24 = function (f18_arg0, f18_arg1, f18_arg2)
    local f18_local0 = f18_arg0:GetDist(TARGET_ENE_0)
    local f18_local1 = 3
    local f18_local2 = 0
    local f18_local3 = 5201
    if SpaceCheck(f18_arg0, f18_arg1, 180, 2) ~= true or SpaceCheck(f18_arg0, f18_arg1, 180, 4) ~= true or f18_local0 > 4 then
    else
        f18_local3 = 5211
        if false then
        else
        end
    end
    f18_arg1:AddSubGoal(GOAL_COMMON_SpinStep, f18_local1, f18_local3, TARGET_ENE_0, f18_local2, AI_DIR_TYPE_B, 0)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act25 = function (f19_arg0, f19_arg1, f19_arg2)
    local f19_local0 = f19_arg0:GetRandam_Float(2, 4)
    local f19_local1 = f19_arg0:GetRandam_Float(5, 7)
    local f19_local2 = f19_arg0:GetDist(TARGET_ENE_0)
    local f19_local3 = -1
    f19_arg1:AddSubGoal(GOAL_COMMON_LeaveTarget, f19_local0, TARGET_ENE_0, f19_local1, TARGET_ENE_0, true, f19_local3)
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
    
end

Goal.Act26 = function (f20_arg0, f20_arg1, f20_arg2)
    f20_arg1:AddSubGoal(GOAL_COMMON_Wait, 0.5, TARGET_SELF, 0, 0, 0)
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
    
end

Goal.Act27 = function (f21_arg0, f21_arg1, f21_arg2)
    local f21_local0 = f21_arg0:GetDist(TARGET_ENE_0)
    local f21_local1 = f21_arg0:GetDistYSigned(TARGET_ENE_0)
    local f21_local2 = f21_local1 / math.tan(math.deg(30))
    local f21_local3 = f21_arg0:GetRandam_Int(0, 1)
    if f21_local1 >= 3 then
        if f21_local2 + 1 <= f21_local0 then
            if SpaceCheck(f21_arg0, f21_arg1, 0, 4) == true then
                f21_arg1:AddSubGoal(GOAL_COMMON_ApproachTarget, 0.1, TARGET_ENE_0, f21_local2, TARGET_SELF, false, -1)
            elseif SpaceCheck(f21_arg0, f21_arg1, 0, 3) == true then
                f21_arg1:AddSubGoal(GOAL_COMMON_ApproachTarget, 0.5, TARGET_ENE_0, f21_local2, TARGET_SELF, true, -1)
            else
                f21_arg1:AddSubGoal(GOAL_COMMON_SidewayMove, 3, TARGET_ENE_0, f21_local3, f21_arg0:GetRandam_Int(30, 45), true, true, -1)
            end
        elseif f21_local0 <= f21_local2 - 1 then
            f21_arg1:AddSubGoal(GOAL_COMMON_LeaveTarget, 10, TARGET_ENE_0, f21_local2, TARGET_ENE_0, true, -1)
        else
            f21_arg1:AddSubGoal(GOAL_COMMON_SidewayMove, 3, TARGET_ENE_0, f21_local3, f21_arg0:GetRandam_Int(30, 45), true, true, -1)
            f21_arg0:SetNumber(10, f21_local3)
        end
    elseif SpaceCheck(f21_arg0, f21_arg1, 0, 4) == true then
        f21_arg1:AddSubGoal(GOAL_COMMON_ApproachTarget, 0.1, TARGET_ENE_0, 0, TARGET_SELF, false, -1)
    elseif SpaceCheck(f21_arg0, f21_arg1, 0, 3) == true then
        f21_arg1:AddSubGoal(GOAL_COMMON_ApproachTarget, 0.5, TARGET_ENE_0, 0, TARGET_SELF, true, -1)
    elseif SpaceCheck(f21_arg0, f21_arg1, 0, 1) == false then
        f21_arg1:AddSubGoal(GOAL_COMMON_LeaveTarget, 0.5, TARGET_ENE_0, 999, TARGET_ENE_0, true, -1)
    else
        f21_arg1:AddSubGoal(GOAL_COMMON_SidewayMove, 3, TARGET_ENE_0, f21_local3, f21_arg0:GetRandam_Int(30, 45), true, true, -1)
        f21_arg0:SetNumber(10, f21_local3)
    end
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
    
end

Goal.Act28 = function (f22_arg0, f22_arg1, f22_arg2)
    local f22_local0 = f22_arg0:GetDist(TARGET_ENE_0)
    local f22_local1 = 1.5
    local f22_local2 = 1.5
    local f22_local3 = f22_arg0:GetRandam_Int(30, 45)
    local f22_local4 = -1
    local f22_local5 = f22_arg0:GetRandam_Int(0, 1)
    if f22_local0 <= 3 then
        f22_arg1:AddSubGoal(GOAL_COMMON_SidewayMove, f22_local1, TARGET_ENE_0, f22_local5, f22_local3, true, true, f22_local4)
    elseif f22_local0 <= 8 then
        f22_arg1:AddSubGoal(GOAL_COMMON_ApproachTarget, f22_local2, TARGET_ENE_0, 3, TARGET_SELF, true, -1)
    else
        f22_arg1:AddSubGoal(GOAL_COMMON_ApproachTarget, f22_local2, TARGET_ENE_0, 8, TARGET_SELF, false, -1)
    end
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
    
end

Goal.Act31 = function (f23_arg0, f23_arg1, f23_arg2)
    local f23_local0 = 4.8 - f23_arg0:GetMapHitRadius(TARGET_SELF)
    local f23_local1 = 4.8 - f23_arg0:GetMapHitRadius(TARGET_SELF)
    local f23_local2 = 4.8 - f23_arg0:GetMapHitRadius(TARGET_SELF)
    local f23_local3 = 100
    local f23_local4 = 0
    local f23_local5 = 1.5
    local f23_local6 = 3
    Approach_Act_Flex(f23_arg0, f23_arg1, f23_local0, f23_local1, f23_local2, f23_local3, f23_local4, f23_local5, f23_local6)
    local f23_local7 = 4 - f23_arg0:GetMapHitRadius(TARGET_SELF)
    local f23_local8 = 4.6 - f23_arg0:GetMapHitRadius(TARGET_SELF)
    local f23_local9 = 0
    local f23_local10 = 0
    local f23_local11 = f23_arg0:GetRandam_Int(1, 100)
    f23_arg1:AddSubGoal(GOAL_COMMON_ComboAttackTunableSpin, 10, 3000, TARGET_ENE_0, 9999, f23_local9, f23_local10, 0, 0)
    f23_arg1:AddSubGoal(GOAL_COMMON_ComboRepeat, 10, 3001, TARGET_ENE_0, 9999, 0)
    f23_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3002, TARGET_ENE_0, 9999, 0, 0)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act40 = function (f24_arg0, f24_arg1, f24_arg2)
    local f24_local0 = 0
    local f24_local1 = 0
    f24_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 10, 3050, TARGET_ENE_0, 9999, f24_local0, f24_local1, 0, 0)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act41 = function (f25_arg0, f25_arg1, f25_arg2)
    local f25_local0 = 0
    local f25_local1 = 0
    f25_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 10, 3055, TARGET_ENE_0, 9999, f25_local0, f25_local1, 0, 0)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act42 = function (f26_arg0, f26_arg1, f26_arg2)
    local f26_local0 = 0
    local f26_local1 = 0
    f26_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 10, 3001, TARGET_ENE_0, 9999, f26_local0, f26_local1, 0, 0)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act43 = function (f27_arg0, f27_arg1, f27_arg2)
    local f27_local0 = 0
    local f27_local1 = 0
    f27_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 10, 3000, TARGET_ENE_0, 9999, f27_local0, f27_local1, 0, 0)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Interrupt = function (f28_arg0, f28_arg1, f28_arg2)
    local f28_local0 = f28_arg1:GetSpecialEffectActivateInterruptType(0)
    local f28_local1 = f28_arg1:GetSpecialEffectInactivateInterruptType(0)
    local f28_local2 = f28_arg1:GetDist(TARGET_ENE_0)
    local f28_local3 = f28_arg1:GetRandam_Int(1, 100)
    if f28_arg1:IsLadderAct(TARGET_SELF) then
        return false
    end
    if not f28_arg1:HasSpecialEffectId(TARGET_SELF, 200004) then
        return false
    end
    if f28_arg1:IsInterupt(INTERUPT_ParryTiming) then
        return Common_Parry(f28_arg1, f28_arg2, 50, 0, 2, 3102)
    end
    if f28_arg1:IsInterupt(INTERUPT_Damaged) and f28_arg0.Damaged(f28_arg1, f28_arg2) then
        return true
    end
    if Interupt_PC_Break(f28_arg1) then
        f28_arg1:Replanning()
        return true
    end
    if f28_arg1:IsInterupt(INTERUPT_ActivateSpecialEffect) then
        if f28_local0 == 5025 and f28_local2 <= 7 then
            f28_arg2:ClearSubGoal()
            f28_arg2:AddSubGoal(GOAL_COMMON_ComboFinal, 7, 3014, TARGET_ENE_0, 9999, 0, 0)
        end
        if f28_local0 == 5026 and f28_local2 >= 6 and f28_local2 <= 8 then
            f28_arg2:ClearSubGoal()
            f28_arg2:AddSubGoal(GOAL_COMMON_ComboFinal, 7, 3017, TARGET_ENE_0, 9999, 0, 0)
        end
        if f28_local0 == 5027 then
            if f28_local3 <= 25 then
                f28_arg2:ClearSubGoal()
                f28_arg2:AddSubGoal(GOAL_COMMON_ComboFinal, 7, 3080, TARGET_ENE_0, 9999, 0, 0)
            elseif f28_local3 <= 50 then
                f28_arg2:ClearSubGoal()
                f28_arg2:AddSubGoal(GOAL_COMMON_ComboFinal, 7, 3083, TARGET_ENE_0, 9999, 0, 0)
            else
                f28_arg2:ClearSubGoal()
                f28_arg2:AddSubGoal(GOAL_COMMON_ComboFinal, 7, 3082, TARGET_ENE_0, 9999, 0, 0)
            end
        end
    end
    if Interupt_Use_Item(f28_arg1, 2, 5) then
        if f28_local2 <= 9 - f28_arg1:GetMapHitRadius(TARGET_SELF) then
            f28_arg2:ClearSubGoal()
            f28_arg2:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 1, 3016, TARGET_ENE_0, 9999, 0, 0, 0, 0)
            return true
        else
            f28_arg1:Replanning()
            return true
        end
    end
    if f28_arg1:IsInterupt(INTERUPT_ShootImpact) and f28_arg0.ShootReaction(f28_arg1, f28_arg2) then
        return true
    end
    return false
    
end

Goal.ShootReaction = function (f29_arg0, f29_arg1)
    f29_arg1:ClearSubGoal()
    f29_arg1:AddSubGoal(GOAL_COMMON_EndureAttack, 0.3, 3102, TARGET_ENE_0, 9999, 0)
    return true
    
end

Goal.Kengeki_Activate = function (f30_arg0, f30_arg1, f30_arg2, f30_arg3)
    local f30_local0 = ReturnKengekiSpecialEffect(f30_arg1)
    if f30_local0 == 0 then
        return false
    end
    local f30_local1 = {}
    local f30_local2 = {}
    local f30_local3 = {}
    Common_Clear_Param(f30_local1, f30_local2, f30_local3)
    local f30_local4 = f30_arg1:GetDist(TARGET_ENE_0)
    local f30_local5 = f30_arg1:GetSp(TARGET_SELF)
    if f30_local5 <= 0 then
        f30_local1[50] = 100
    elseif f30_local0 == 200200 then
        if f30_local4 >= 3.5 then
            f30_local1[3] = 100
            f30_local1[8] = 100
            f30_local1[50] = 100
        elseif f30_local4 <= 0.2 then
            f30_local1[1] = 100
            f30_local1[2] = 100
            f30_local1[3] = 100
            f30_local1[8] = 100
        else
            f30_local1[1] = 100
            f30_local1[2] = 100
            f30_local1[3] = 100
            f30_local1[8] = 100
            f30_local1[9] = 100
        end
    elseif f30_local0 == 200201 then
        if f30_local4 >= 3.5 then
            f30_local1[6] = 100
            f30_local1[8] = 100
            f30_local1[11] = 100
        elseif f30_local4 <= 0.2 then
            f30_local1[1] = 50
            f30_local1[2] = 50
            f30_local1[10] = 100
            f30_local1[11] = 100
        else
            f30_local1[1] = 50
            f30_local1[2] = 50
            f30_local1[10] = 300
            f30_local1[11] = 100
        end
    elseif f30_local0 == 200205 then
        f30_local1[1] = 100
        f30_local1[2] = 100
    elseif f30_local0 == 200206 then
        f30_local1[1] = 100
        f30_local1[2] = 100
    elseif f30_local0 == 200211 then
        f30_local1[1] = 100
        f30_local1[2] = 100
        f30_local1[5] = 100
        f30_local1[8] = 100
    elseif f30_local0 == 200216 then
        f30_local1[1] = 100
        f30_local1[2] = 100
        f30_local1[5] = 100
        f30_local1[8] = 100
    else
        f30_local1[50] = 100
    end
    if SpaceCheck(f30_arg1, f30_arg2, 180, 2) == true then
        f30_local1[24] = 0
    end
    f30_local1[1] = SetCoolTime(f30_arg1, f30_arg2, 3050, 10, f30_local1[1], 1)
    f30_local1[2] = SetCoolTime(f30_arg1, f30_arg2, 3055, 10, f30_local1[2], 1)
    f30_local1[3] = SetCoolTime(f30_arg1, f30_arg2, 3006, 10, f30_local1[3], 1)
    f30_local1[4] = SetCoolTime(f30_arg1, f30_arg2, 3005, 10, f30_local1[4], 1)
    f30_local1[5] = SetCoolTime(f30_arg1, f30_arg2, 3010, 10, f30_local1[5], 1)
    f30_local1[6] = SetCoolTime(f30_arg1, f30_arg2, 3007, 10, f30_local1[6], 1)
    f30_local1[7] = SetCoolTime(f30_arg1, f30_arg2, 3016, 20, f30_local1[7], 1)
    f30_local1[8] = SetCoolTime(f30_arg1, f30_arg2, 3008, 20, f30_local1[8], 1)
    f30_local1[9] = SetCoolTime(f30_arg1, f30_arg2, 3060, 20, f30_local1[9], 1)
    f30_local1[10] = SetCoolTime(f30_arg1, f30_arg2, 3065, 20, f30_local1[10], 1)
    f30_local1[11] = SetCoolTime(f30_arg1, f30_arg2, 3056, 10, f30_local1[11], 1)
    f30_local2[1] = REGIST_FUNC(f30_arg1, f30_arg2, f30_arg0.Kengeki01)
    f30_local2[2] = REGIST_FUNC(f30_arg1, f30_arg2, f30_arg0.Kengeki02)
    f30_local2[3] = REGIST_FUNC(f30_arg1, f30_arg2, f30_arg0.Kengeki03)
    f30_local2[4] = REGIST_FUNC(f30_arg1, f30_arg2, f30_arg0.Kengeki04)
    f30_local2[5] = REGIST_FUNC(f30_arg1, f30_arg2, f30_arg0.Kengeki05)
    f30_local2[6] = REGIST_FUNC(f30_arg1, f30_arg2, f30_arg0.Kengeki06)
    f30_local2[7] = REGIST_FUNC(f30_arg1, f30_arg2, f30_arg0.Kengeki07)
    f30_local2[8] = REGIST_FUNC(f30_arg1, f30_arg2, f30_arg0.Kengeki08)
    f30_local2[9] = REGIST_FUNC(f30_arg1, f30_arg2, f30_arg0.Kengeki09)
    f30_local2[10] = REGIST_FUNC(f30_arg1, f30_arg2, f30_arg0.Kengeki10)
    f30_local2[11] = REGIST_FUNC(f30_arg1, f30_arg2, f30_arg0.Kengeki11)
    f30_local2[24] = REGIST_FUNC(f30_arg1, f30_arg2, f30_arg0.Kengeki24)
    f30_local2[30] = REGIST_FUNC(f30_arg1, f30_arg2, f30_arg0.Kengeki30)
    f30_local2[50] = REGIST_FUNC(f30_arg1, f30_arg2, f30_arg0.NoAction)
    local f30_local6 = REGIST_FUNC(f30_arg1, f30_arg2, f30_arg0.ActAfter_AdjustSpace)
    return Common_Kengeki_Activate(f30_arg1, f30_arg2, f30_local1, f30_local2, f30_local6, f30_local3)
    
end

Goal.Kengeki01 = function (f31_arg0, f31_arg1, f31_arg2)
    f31_arg1:ClearSubGoal()
    f31_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3050, TARGET_ENE_0, 9999, 0, 0)
    
end

Goal.Kengeki02 = function (f32_arg0, f32_arg1, f32_arg2)
    f32_arg1:ClearSubGoal()
    f32_arg1:AddSubGoal(GOAL_COMMON_ComboRepeat, 10, 3055, TARGET_ENE_0, 9999, 0)
    f32_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3015, TARGET_ENE_0, 9999, 0, 0)
    
end

Goal.Kengeki03 = function (f33_arg0, f33_arg1, f33_arg2)
    f33_arg1:ClearSubGoal()
    f33_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3006, TARGET_ENE_0, 9999, 0, 0)
    
end

Goal.Kengeki04 = function (f34_arg0, f34_arg1, f34_arg2)
    f34_arg1:ClearSubGoal()
    f34_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3005, TARGET_ENE_0, 9999, 0, 0)
    
end

Goal.Kengeki05 = function (f35_arg0, f35_arg1, f35_arg2)
    f35_arg1:ClearSubGoal()
    f35_arg1:AddSubGoal(GOAL_COMMON_ComboRepeat, 10, 3010, TARGET_ENE_0, 9999, 0, 0, 0, 0)
    f35_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3017, TARGET_ENE_0, 9999, 0, 0)
    f35_arg0:SetTimer(0, 12)
    
end

Goal.Kengeki06 = function (f36_arg0, f36_arg1, f36_arg2)
    f36_arg1:ClearSubGoal()
    f36_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3007, TARGET_ENE_0, 9999, 0, 0)
    
end

Goal.Kengeki07 = function (f37_arg0, f37_arg1, f37_arg2)
    f37_arg1:ClearSubGoal()
    f37_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3016, TARGET_ENE_0, 9999, 0, 0)
    
end

Goal.Kengeki08 = function (f38_arg0, f38_arg1, f38_arg2)
    f38_arg1:ClearSubGoal()
    f38_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3008, TARGET_ENE_0, 9999, 0, 0)
    
end

Goal.Kengeki09 = function (f39_arg0, f39_arg1, f39_arg2)
    f39_arg1:ClearSubGoal()
    f39_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3060, TARGET_ENE_0, 9999, 0, 0)
    f39_arg0:SetTimer(0, 12)
    
end

Goal.Kengeki10 = function (f40_arg0, f40_arg1, f40_arg2)
    f40_arg1:ClearSubGoal()
    f40_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3065, TARGET_ENE_0, 9999, 0, 0)
    f40_arg0:SetTimer(0, 12)
    
end

Goal.Kengeki11 = function (f41_arg0, f41_arg1, f41_arg2)
    f41_arg1:ClearSubGoal()
    f41_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3057, TARGET_ENE_0, 9999, 0, 0)
    
end

Goal.Kengeki24 = function (f42_arg0, f42_arg1, f42_arg2)
    f42_arg1:ClearSubGoal()
    f42_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 5211, TARGET_ENE_0, 0, AI_DIR_TYPE_B, 0)
    
end

Goal.Kengeki30 = function (f43_arg0, f43_arg1, f43_arg2)
    local f43_local0 = f43_arg0:GetSp(TARGET_SELF)
    local f43_local1 = 0
    local f43_local2 = f43_arg0:GetRandam_Int(1, 100)
    local f43_local3 = 9910
    local f43_local4 = 0
    if SpaceCheck(f43_arg0, f43_arg1, -90, 1) == true then
        if SpaceCheck(f43_arg0, f43_arg1, 90, 1) == true then
            if f43_arg0:IsInsideTarget(TARGET_ENE_0, AI_DIR_TYPE_R, 180) then
                f43_local4 = 1
            else
                f43_local4 = 0
            end
        else
            f43_local4 = 0
        end
    elseif SpaceCheck(f43_arg0, f43_arg1, 90, 1) == true then
        f43_local4 = 1
    else
        GetWellSpace_Odds = 100
        return GetWellSpace_Odds
    end
    local f43_local5 = f43_arg0:GetRandam_Int(60, 90)
    f43_arg1:ClearSubGoal()
    f43_arg1:AddSubGoal(GOAL_COMMON_SidewayMove, 2, TARGET_ENE_0, f43_local4, f43_local5, true, true, -1)
    
end

Goal.NoAction = function (f44_arg0, f44_arg1, f44_arg2)
    return -1
    
end

Goal.ActAfter_AdjustSpace = function (f45_arg0, f45_arg1, f45_arg2)
    
end

Goal.Update = function (f46_arg0, f46_arg1, f46_arg2)
    return Update_Default_NoSubGoal(f46_arg0, f46_arg1, f46_arg2)
    
end

Goal.Terminate = function (f47_arg0, f47_arg1, f47_arg2)
    
end


