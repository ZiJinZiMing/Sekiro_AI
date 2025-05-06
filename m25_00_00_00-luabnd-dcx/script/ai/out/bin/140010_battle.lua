RegisterTableGoal(GOAL_Kenkaku_seigan_140010_Battle, "GOAL_Kenkaku_seigan_140010_Battle")
REGISTER_GOAL_NO_UPDATE(GOAL_Kenkaku_seigan_140010_Battle, true)

Goal.Initialize = function (f1_arg0, f1_arg1, f1_arg2, f1_arg3)
    
end

Goal.Activate = function (f2_arg0, f2_arg1, f2_arg2)
    Init_Pseudo_Global(f2_arg1, f2_arg2)
    f2_arg1:DeleteObserve(0)
    local f2_local0 = {}
    local f2_local1 = {}
    local f2_local2 = {}
    Common_Clear_Param(f2_local0, f2_local1, f2_local2)
    local f2_local3 = f2_arg1:GetDist(TARGET_ENE_0)
    local f2_local4 = f2_arg1:GetExcelParam(AI_EXCEL_THINK_PARAM_TYPE__thinkAttr_doAdmirer)
    local f2_local5 = nil
    if f2_arg1:IsInsideTargetRegion(TARGET_SELF, 1112430) then
        f2_local5 = Check_ReachAttack(f2_arg1, 4.5)
    else
        f2_local5 = Check_ReachAttack(f2_arg1, 0)
    end
    local f2_local6 = f2_arg1:GetSp(TARGET_SELF)
    local f2_local7 = f2_arg1:GetSpRate(TARGET_SELF)
    local f2_local8 = f2_arg1:GetSpRate(TARGET_ENE_0)
    local f2_local9 = 0
    local f2_local10 = f2_arg1:GetEventRequest()
    local f2_local11 = 0
    f2_arg1:AddObserveSpecialEffectAttribute(TARGET_ENE_0, 109031)
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
            if f2_arg1:IsVisibleCurrTarget() then
                f2_local0[1] = 100
                f2_local0[8] = 100
            else
                f2_local0[27] = 100
            end
        elseif f2_local5 == REACH_ATTACK_TARGET_LOW_POSITION then
            if f2_arg1:IsVisibleCurrTarget() then
                f2_local0[1] = 100
                f2_local0[3] = 100
                f2_local0[8] = 100
            else
                f2_local0[27] = 100
            end
        else
            f2_local0[27] = 100
        end
    elseif f2_local4 == 1 and f2_arg1:GetTeamOrder(ORDER_TYPE_Role) == ROLE_TYPE_Kankyaku then
        KankyakuAct(f2_arg1, f2_arg2)
    elseif f2_local4 == 1 and f2_arg1:GetTeamOrder(ORDER_TYPE_Role) == ROLE_TYPE_Torimaki then
        if TorimakiAct(f2_arg1, f2_arg2) then
            f2_local0[1] = 100
            f2_local0[3] = 100
        end
    elseif f2_arg1:IsInsideTarget(TARGET_ENE_0, AI_DIR_TYPE_B, 180) then
        f2_local0[21] = 100
    else
        f2_local9 = 1
        if f2_local3 >= 8 then
            f2_local0[29] = 100
        elseif f2_local3 >= 5 then
            if f2_arg1:IsInsideTarget(TARGET_ENE_0, AI_DIR_TYPE_F, 120) then
                f2_local0[4] = 30
            end
            f2_local0[19] = 30
            f2_local0[23] = 15
            f2_local0[26] = 10
        elseif f2_local3 > 3 then
            f2_local0[19] = 30
            f2_local0[18] = 10
            f2_local0[23] = 20
            if 0 == 0 then
                f2_local0[23] = 5
                f2_local0[6] = 40
            end
            f2_local0[24] = 10
            f2_local0[25] = 10
            f2_local0[26] = 10
            if f2_arg1:GetHpRate(TARGET_SELF) > 0.4 and f2_arg1:GetSpRate(TARGET_SELF) < 0.4 then
                f2_local0[23] = 70
                f2_local0[24] = 20
                f2_local0[25] = 20
                f2_local0[19] = 5
                f2_local0[18] = 10
            end
        elseif f2_local3 > 2 then
            f2_local0[1] = 100
            f2_local0[2] = 0
            f2_local0[3] = 100
            f2_local0[4] = 100
            if 0 == 0 then
                f2_local0[23] = 5
                f2_local0[6] = 100
            end
            f2_local0[7] = 50
            f2_local0[8] = 50
            f2_local0[23] = 40
            f2_local0[24] = 15
        else
            f2_local0[2] = 40
            f2_local0[5] = 55
            f2_local0[7] = 50
            f2_local0[23] = 1
            f2_local0[24] = 100
            f2_local0[20] = 1
            if 0 == 0 then
                f2_local0[24] = 20
                f2_local0[5] = 70
            end
        end
    end
    f2_local0[3] = 0
    f2_local0[20] = 0
    if f2_arg1:HasSpecialEffectId(TARGET_SELF, 200030) and f2_local3 <= 1 then
        f2_local0[5] = 50
        f2_local0[9] = 50
    else
        f2_local0[5] = 0
    end
    if f2_local7 > 0.3 and f2_local8 < f2_local7 then
        f2_local0[24] = f2_local0[24] * 0.1
        f2_local0[25] = 0
    end
    if f2_local7 < 0.6 then
        f2_local0[6] = 0
    end
    local f2_local12 = 0
    if f2_local9 == 1 then
        if f2_arg1:GetNumber(1) == 1 and f2_arg1:HasSpecialEffectId(TARGET_ENE_0, 100358) then
            f2_local12 = 1
        elseif f2_arg1:GetNumber(1) == 2 and f2_arg1:HasSpecialEffectId(TARGET_ENE_0, 100360) then
            f2_local12 = 1
        elseif f2_arg1:GetNumber(1) == 3 and f2_arg1:HasSpecialEffectId(TARGET_ENE_0, 100361) then
            f2_local12 = 1
        elseif f2_arg1:GetNumber(1) == 4 and f2_arg1:HasSpecialEffectId(TARGET_ENE_0, 100356) then
            f2_local12 = 1
        elseif f2_arg1:GetNumber(1) == 5 and f2_arg1:HasSpecialEffectId(TARGET_ENE_0, 100357) then
            f2_local12 = 1
        end
    end
    if f2_arg1:HasSpecialEffectId(TARGET_SELF, 5035) and f2_local12 == 1 and f2_local3 <= 3 then
        f2_local0[1] = 0
        f2_local0[2] = 0
        f2_local0[3] = 0
        f2_local0[4] = 0
        f2_local0[5] = 0
        f2_local0[6] = 0
        f2_local0[7] = 0
        f2_local0[8] = 0
        f2_local0[9] = 0
        f2_local0[18] = 0
        f2_local0[19] = 0
        f2_local0[23] = 0
        f2_local0[24] = 0
        f2_local0[20] = 100
    end
    f2_local0[3] = 0
    if SpaceCheck(f2_arg1, f2_arg2, 0, 1) == false then
        f2_local0[19] = 0
    end
    if SpaceCheck(f2_arg1, f2_arg2, 90, 1.5) == false and SpaceCheck(f2_arg1, f2_arg2, -90, 1.5) == false then
        f2_local0[23] = 0
    end
    if SpaceCheck(f2_arg1, f2_arg2, 180, 2) == false then
        f2_local0[24] = 0
        f2_local0[5] = 0
        f2_local11 = 1
    end
    if SpaceCheck(f2_arg1, f2_arg2, 180, 1) == false then
        f2_local0[25] = 0
    end
    if f2_arg1:GetNumber(2) > 2 then
        f2_arg1:SetNumber(2, 0)
        f2_local0[19] = 0
    end
    if f2_arg1:IsInsideTargetRegion(TARGET_SELF, 1112250) or f2_arg1:IsInsideTargetRegion(TARGET_ENE_0, 1112250) then
        f2_local0[4] = 0
    end
    f2_local0[1] = SetCoolTime(f2_arg1, f2_arg2, 3011, 10, f2_local0[1], 1)
    f2_local0[2] = SetCoolTime(f2_arg1, f2_arg2, 3015, 4, f2_local0[2], 1)
    f2_local0[3] = SetCoolTime(f2_arg1, f2_arg2, 3001, 8, f2_local0[3], 1)
    f2_local0[3] = SetCoolTime(f2_arg1, f2_arg2, 3003, 8, f2_local0[3], 1)
    f2_local0[4] = SetCoolTime(f2_arg1, f2_arg2, 3005, 8, f2_local0[4], 1)
    f2_local0[4] = SetCoolTime(f2_arg1, f2_arg2, 3006, 8, f2_local0[4], 1)
    f2_local0[4] = SetCoolTime(f2_arg1, f2_arg2, 3073, 8, f2_local0[4], 1)
    f2_local0[5] = SetCoolTime(f2_arg1, f2_arg2, 3009, 8, f2_local0[5], 1)
    f2_local0[6] = SetCoolTime(f2_arg1, f2_arg2, 3000, 8, f2_local0[6], 1)
    f2_local0[6] = SetCoolTime(f2_arg1, f2_arg2, 3004, 8, f2_local0[6], 1)
    f2_local0[7] = SetCoolTime(f2_arg1, f2_arg2, 3002, 4, f2_local0[7], 1)
    f2_local0[8] = SetCoolTime(f2_arg1, f2_arg2, 3011, 2, f2_local0[8], 1)
    f2_local0[9] = SetCoolTime(f2_arg1, f2_arg2, 3006, 6, f2_local0[9], 1)
    f2_local0[10] = SetCoolTime(f2_arg1, f2_arg2, 3040, 20, f2_local0[10], 1)
    f2_local0[24] = SetCoolTime(f2_arg1, f2_arg2, 5201, 1, f2_local0[24], 1)
    f2_local0[24] = SetCoolTime(f2_arg1, f2_arg2, 5211, 1, f2_local0[24], 1)
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
    f2_local1[15] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act15)
    f2_local1[16] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act16)
    f2_local1[17] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act17)
    f2_local1[18] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act18)
    f2_local1[19] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act19)
    f2_local1[20] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act20)
    f2_local1[21] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act21)
    f2_local1[23] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act23)
    f2_local1[24] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act24)
    f2_local1[25] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act25)
    f2_local1[26] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act26)
    f2_local1[27] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act27)
    f2_local1[28] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act28)
    f2_local1[29] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act29)
    f2_local1[30] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act30)
    local f2_local13 = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.ActAfter_AdjustSpace)
    Common_Battle_Activate(f2_arg1, f2_arg2, f2_local0, f2_local1, f2_local13, f2_local2)
    
end

Goal.Act01 = function (f3_arg0, f3_arg1, f3_arg2)
    local f3_local0 = 0
    local f3_local1 = 90
    local f3_local2 = f3_arg0:GetDist(TARGET_ENE_0)
    local f3_local3 = 3001
    if 0 == 1 then
        f3_local3 = 3011
    end
    if f3_arg0:IsInsideTargetRegion(TARGET_SELF, 1112250) or f3_arg0:IsInsideTargetRegion(TARGET_ENE_0, 1112250) then
        f3_arg1:AddSubGoal(GOAL_COMMON_ComboAttackTunableSpin, 10, f3_local3, TARGET_ENE_0, 4, f3_local0, f3_local1, 0, 0)
        f3_arg1:AddSubGoal(GOAL_COMMON_ComboRepeat, 10, 3012, TARGET_ENE_0, 3, 0)
    else
        f3_arg1:AddSubGoal(GOAL_COMMON_ComboAttackTunableSpin, 10, f3_local3, TARGET_ENE_0, 4, f3_local0, f3_local1, 0, 0)
        f3_arg1:AddSubGoal(GOAL_COMMON_ComboRepeat, 10, 3012, TARGET_ENE_0, 3, 0)
        f3_arg1:AddSubGoal(GOAL_COMMON_ComboRepeat, 10, 3013, TARGET_ENE_0, 9999, 0)
        f3_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3014, TARGET_ENE_0, 9999, 0, 0)
    end
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act02 = function (f4_arg0, f4_arg1, f4_arg2)
    local f4_local0 = 0
    local f4_local1 = 90
    local f4_local2 = f4_arg0:GetRandam_Int(1, 100)
    f4_arg1:AddSubGoal(GOAL_COMMON_ComboAttackTunableSpin, 10, 3015, TARGET_ENE_0, 3 - f4_arg0:GetMapHitRadius(TARGET_SELF), f4_local0, f4_local1, 0, 0)
    if f4_local2 <= 80 then
        f4_arg1:AddSubGoal(GOAL_COMMON_ComboRepeat, 10, 3016, TARGET_ENE_0, 2 - f4_arg0:GetMapHitRadius(TARGET_SELF), 0, 0, f4_local1)
        f4_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3017, TARGET_ENE_0, 9999, 0, 0)
    end
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act03 = function (f5_arg0, f5_arg1, f5_arg2)
    local f5_local0 = 0
    local f5_local1 = 0
    local f5_local2 = f5_arg0:GetRandam_Int(1, 100)
    local f5_local3 = 3001
    local f5_local4 = f5_arg0:GetSpRate(TARGET_SELF)
    if f5_arg0:IsInsideTargetRegion(TARGET_SELF, 1112250) or f5_arg0:IsInsideTargetRegion(TARGET_ENE_0, 1112250) then
        f5_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 10, f5_local3, TARGET_ENE_0, 6, f5_local0, f5_local1, 0, 0)
    else
        f5_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 10, f5_local3, TARGET_ENE_0, 6, f5_local0, f5_local1, 0, 0)
        if f5_local4 > 0.7 then
            f5_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3005, TARGET_ENE_0, 9999, 0.2, 0)
        end
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
    f7_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 10, 3009, TARGET_ENE_0, 9999, f7_local0, f7_local1, 0, 0)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act06 = function (f8_arg0, f8_arg1, f8_arg2)
    local f8_local0 = 5 - f8_arg0:GetMapHitRadius(TARGET_SELF)
    local f8_local1 = 5 - f8_arg0:GetMapHitRadius(TARGET_SELF) + 2
    local f8_local2 = 5 - f8_arg0:GetMapHitRadius(TARGET_SELF) + 3
    local f8_local3 = 100
    local f8_local4 = 0
    local f8_local5 = 2
    local f8_local6 = 2.5
    Approach_Act_Flex(f8_arg0, f8_arg1, f8_local0, f8_local1, f8_local2, f8_local3, f8_local4, f8_local5, f8_local6)
    local f8_local7 = 0
    local f8_local8 = 0
    f8_arg1:AddSubGoal(GOAL_COMMON_ComboAttackTunableSpin, 10, 3000, TARGET_ENE_0, 5 - f8_arg0:GetMapHitRadius(TARGET_SELF), f8_local7, f8_local8, 0, 0)
    f8_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3004, TARGET_ENE_0, 9999, 0, 0)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act07 = function (f9_arg0, f9_arg1, f9_arg2)
    local f9_local0 = 0
    local f9_local1 = 0
    f9_arg1:AddSubGoal(GOAL_COMMON_ComboAttackTunableSpin, 10, 3002, TARGET_ENE_0, 5, f9_local0, f9_local1, 0, 0)
    f9_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3017, TARGET_ENE_0, 3, 0, 0)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act08 = function (f10_arg0, f10_arg1, f10_arg2)
    local f10_local0 = 0
    local f10_local1 = 90
    f10_arg1:AddSubGoal(GOAL_COMMON_ComboAttackTunableSpin, 10, 3011, TARGET_ENE_0, 4, f10_local0, f10_local1, 0, 0)
    f10_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3012, TARGET_ENE_0, 9999, 0, 0)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act09 = function (f11_arg0, f11_arg1, f11_arg2)
    local f11_local0 = 0
    local f11_local1 = 120
    local f11_local2 = f11_arg0:GetRandam_Int(1, 100)
    if f11_arg0:IsInsideTargetRegion(TARGET_SELF, 1112250) or f11_arg0:IsInsideTargetRegion(TARGET_ENE_0, 1112250) then
        f11_arg1:AddSubGoal(GOAL_COMMON_ComboAttackTunableSpin, 10, 3009, TARGET_ENE_0, 6, f11_local0, f11_local1, 0, 0)
    else
        f11_arg1:AddSubGoal(GOAL_COMMON_ComboAttackTunableSpin, 10, 3009, TARGET_ENE_0, 6, f11_local0, f11_local1, 0, 0)
        if f11_local2 <= 50 then
            f11_arg1:AddSubGoal(GOAL_COMMON_ComboRepeat, 10, 3006, TARGET_ENE_0, 6, 0)
            f11_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 5211, TARGET_ENE_0, 9999, 0, 0)
        end
    end
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act10 = function (f12_arg0, f12_arg1, f12_arg2)
    local f12_local0 = 0
    local f12_local1 = 3040
    local f12_local2 = 0
    f12_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 10, f12_local1, TARGET_ENE_0, 9999, f12_local0, f12_local2, 0, 0)
    GetWellSpace_Odds = 100
    return GET_WELL_SPACE_ODDS
    
end

Goal.Act15 = function (f13_arg0, f13_arg1, f13_arg2)
    if f13_arg0:HasSpecialEffectId(TARGET_SELF, 5020) then
        f13_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 10, 20000, TARGET_LOCALPLAYER, 9999, 0, 0, 0, 0)
    else
        f13_arg0:SetEventMoveTarget(TARGET_EVENT)
        f13_arg1:AddSubGoal(GOAL_COMMON_ApproachTarget, 10, TARGET_EVENT, 3, TARGET_SELF, false, -1)
    end
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act16 = function (f14_arg0, f14_arg1, f14_arg2)
    f14_arg1:AddSubGoal(GOAL_COMMON_ApproachTarget, 10, TARGET_EVENT, 2, TARGET_EVENT, false, -1)
    f14_arg1:AddSubGoal(GOAL_COMMON_ComboAttackTunableSpin, 10, 3001, TARGET_EVENT, 9999, 0, 0, 0, 0)
    f14_arg1:AddSubGoal(GOAL_COMMON_ComboRepeat, 10, 3012, TARGET_EVENT, 9999, 0)
    f14_arg1:AddSubGoal(GOAL_COMMON_ComboRepeat, 10, 3013, TARGET_EVENT, 9999, 0)
    f14_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3014, TARGET_EVENT, 9999, 0, 0)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act17 = function (f15_arg0, f15_arg1, f15_arg2)
    f15_arg1:AddSubGoal(GOAL_COMMON_ApproachTarget, 10, TARGET_EVENT, 2, TARGET_EVENT, false, -1)
    f15_arg1:AddSubGoal(GOAL_COMMON_ComboAttackTunableSpin, 10, 3015, TARGET_EVENT, 9999, 0, 0, 0, 0)
    f15_arg1:AddSubGoal(GOAL_COMMON_ComboRepeat, 10, 3016, TARGET_EVENT, 9999, 0)
    f15_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3017, TARGET_EVENT, 9999, 0, 0)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act18 = function (f16_arg0, f16_arg1, f16_arg2)
    local f16_local0 = f16_arg0:GetDist(TARGET_ENE_0)
    local f16_local1 = 3
    local f16_local2 = 4.5
    local f16_local3 = -1
    if 0 == 1 then
        f16_local3 = 9910
    end
    f16_arg1:AddSubGoal(GOAL_COMMON_ApproachTarget, f16_local2, TARGET_ENE_0, f16_local1, TARGET_SELF, true, f16_local3)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act19 = function (f17_arg0, f17_arg1, f17_arg2)
    local f17_local0 = 3
    local f17_local1 = 0
    local f17_local2 = 5200
    f17_arg0:SetNumber(2, f17_arg0:GetNumber(2) + 1)
    f17_arg1:AddSubGoal(GOAL_COMMON_SpinStep, f17_local0, f17_local2, TARGET_ENE_0, f17_local1, AI_DIR_TYPE_B, 0)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act20 = function (f18_arg0, f18_arg1, f18_arg2)
    local f18_local0 = f18_arg0:GetRandam_Float(0.3, 1.2)
    f18_arg1:AddSubGoal(GOAL_COMMON_Guard, f18_local0, 9910, TARGET_ENE_0, false, 0)
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
    
end

Goal.Act21 = function (f19_arg0, f19_arg1, f19_arg2)
    local f19_local0 = 3
    local f19_local1 = 45
    local f19_local2 = f19_arg0:GetSp(TARGET_SELF)
    local f19_local3 = 20
    local f19_local4 = -1
    if 0 == 1 then
        f19_local4 = 9910
    end
    f19_arg1:AddSubGoal(GOAL_COMMON_Turn, f19_local0, TARGET_ENE_0, f19_local1, f19_local4, GOAL_RESULT_Success, true)
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
    
end

Goal.Act23 = function (f20_arg0, f20_arg1, f20_arg2)
    local f20_local0 = f20_arg0:GetDist(TARGET_ENE_0)
    local f20_local1 = f20_arg0:GetSp(TARGET_SELF)
    local f20_local2 = 20
    local f20_local3 = f20_arg0:GetRandam_Int(1, 100)
    local f20_local4 = -1
    local f20_local5 = f20_arg0:GetRandam_Float(0.6, 2)
    local f20_local6 = f20_arg0:GetRandam_Int(30, 45)
    local f20_local7 = 0
    if SpaceCheck(f20_arg0, f20_arg1, -90, 1.5) == true then
        if SpaceCheck(f20_arg0, f20_arg1, 90, 1.5) == true then
            if f20_local3 <= 50 then
                if f20_arg0:IsInsideTargetEx(TARGET_ENE_0, TARGET_SELF, AI_DIR_TYPE_R, 180, 999) then
                    f20_local7 = 1
                else
                    f20_local7 = 0
                end
            elseif f20_arg0:IsInsideTargetEx(TARGET_ENE_0, TARGET_SELF, AI_DIR_TYPE_L, 180, 999) then
                f20_local7 = 0
            else
                f20_local7 = 1
            end
        else
            f20_local7 = 0
        end
    elseif SpaceCheck(f20_arg0, f20_arg1, 90, 1.5) == true then
        f20_local7 = 1
    else
    end
    f20_arg0:SetNumber(10, f20_local7)
    f20_arg1:AddSubGoal(GOAL_COMMON_SidewayMove, f20_local5, TARGET_ENE_0, f20_local7, f20_local6, true, true, f20_local4)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act24 = function (f21_arg0, f21_arg1, f21_arg2)
    local f21_local0 = f21_arg0:GetDist(TARGET_ENE_0)
    local f21_local1 = f21_arg0:GetRandam_Int(1, 3)
    local f21_local2 = 0
    local f21_local3 = 5201
    if SpaceCheck(f21_arg0, f21_arg1, 180, 2) ~= true or SpaceCheck(f21_arg0, f21_arg1, 180, 4.5) ~= true or f21_local0 > 2 then
    else
        f21_local3 = 5211
        if false then
        else
        end
    end
    f21_arg1:AddSubGoal(GOAL_COMMON_SpinStep, f21_local1, f21_local3, TARGET_ENE_0, f21_local2, AI_DIR_TYPE_B, 0)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act25 = function (f22_arg0, f22_arg1, f22_arg2)
    local f22_local0 = f22_arg0:GetRandam_Float(0.8, 3)
    local f22_local1 = f22_arg0:GetDist(TARGET_ENE_0)
    local f22_local2 = f22_arg0:GetSp(TARGET_SELF)
    local f22_local3 = 20
    local f22_local4 = -1
    if 0 == 1 then
        f22_local4 = 9910
    end
    f22_arg1:AddSubGoal(GOAL_COMMON_LeaveTarget, f22_local0, TARGET_ENE_0, 5, TARGET_ENE_0, true, f22_local4)
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
    
end

Goal.Act26 = function (f23_arg0, f23_arg1, f23_arg2)
    f23_arg1:AddSubGoal(GOAL_COMMON_Wait, 0.5, TARGET_SELF, 0, 0, 0)
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
    
end

Goal.Act27 = function (f24_arg0, f24_arg1, f24_arg2)
    local f24_local0 = f24_arg0:GetRandam_Int(1, 100)
    if YousumiAct_SubGoal(f24_arg0, f24_arg1, true, 60, 30) == false then
        GetWellSpace_Odds = 0
        return GetWellSpace_Odds
    end
    local f24_local1 = 0
    local f24_local2 = SpaceCheck_SidewayMove(f24_arg0, f24_arg1, 1)
    if f24_local2 == 0 then
        f24_local1 = 0
    elseif f24_local2 == 1 then
        f24_local1 = 1
    elseif f24_local2 == 2 then
        if f24_local0 <= 50 then
            f24_local1 = 0
        else
            f24_local1 = 1
        end
    else
        f24_arg1:AddSubGoal(GOAL_COMMON_Wait, 0.5, TARGET_SELF, 0, 0, 0)
        GetWellSpace_Odds = 0
        return GetWellSpace_Odds
    end
    f24_arg0:SetNumber(10, f24_local1)
    f24_arg1:AddSubGoal(GOAL_COMMON_SidewayMove, 3, TARGET_ENE_0, f24_local1, f24_arg0:GetRandam_Int(30, 45), true, true, -1)
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
    
end

Goal.Act28 = function (f25_arg0, f25_arg1, f25_arg2)
    local f25_local0 = f25_arg0:GetDist(TARGET_ENE_0)
    local f25_local1 = 1.5
    local f25_local2 = 1.5
    local f25_local3 = f25_arg0:GetRandam_Int(30, 45)
    local f25_local4 = f25_arg0:GetRandam_Int(0, 1)
    local f25_local5 = f25_arg0:GetSp(TARGET_SELF)
    local f25_local6 = 20
    local f25_local7 = -1
    if 0 == 1 then
        f25_local7 = 9910
    end
    if f25_local0 <= 3 then
        f25_arg1:AddSubGoal(GOAL_COMMON_SidewayMove, f25_local1, TARGET_ENE_0, f25_local4, f25_local3, true, true, f25_local7)
    elseif f25_local0 <= 8 then
        f25_arg1:AddSubGoal(GOAL_COMMON_ApproachTarget, f25_local2, TARGET_ENE_0, 3, TARGET_SELF, true, f25_local7)
    else
        f25_arg1:AddSubGoal(GOAL_COMMON_ApproachTarget, f25_local2, TARGET_ENE_0, 8, TARGET_SELF, false, -1)
    end
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
    
end

Goal.Act29 = function (f26_arg0, f26_arg1, f26_arg2)
    local f26_local0 = 2
    local f26_local1 = -1
    if 0 == 1 then
        f26_local1 = 9910
    end
    f26_arg0:AddObserveArea(0, TARGET_SELF, TARGET_ENE_0, AI_DIR_TYPE_F, 360, 4.5)
    f26_arg1:AddSubGoal(GOAL_COMMON_ApproachTarget, f26_local0, TARGET_ENE_0, 1.9, TARGET_SELF, true, f26_local1)
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
    
end

Goal.Act30 = function (f27_arg0, f27_arg1, f27_arg2)
    local f27_local0 = 3.5
    local f27_local1 = f27_arg0:GetRandam_Int(30, 45)
    local f27_local2 = 0
    local f27_local3 = -1
    if 0 == 1 then
        f27_local3 = 9910
    end
    if SpaceCheck(f27_arg0, f27_arg1, -90, 1) == true then
        if SpaceCheck(f27_arg0, f27_arg1, 90, 1) == true then
            if f27_arg0:IsInsideTarget(TARGET_ENE_0, AI_DIR_TYPE_R, 180) then
                f27_local2 = 0
            else
                f27_local2 = 1
            end
        else
            f27_local2 = 0
        end
    elseif SpaceCheck(f27_arg0, f27_arg1, 90, 1) == true then
        f27_local2 = 1
    else
    end
    f27_arg1:AddSubGoal(GOAL_COMMON_SidewayMove, f27_local0, TARGET_ENE_0, f27_local2, f27_local1, true, true, f27_local3)
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
    
end

Goal.Interrupt = function (f28_arg0, f28_arg1, f28_arg2)
    local f28_local0 = f28_arg1:GetSpecialEffectActivateInterruptType(0)
    local f28_local1 = f28_arg1:GetSpRate(TARGET_SELF)
    local f28_local2 = f28_arg1:GetDist(TARGET_ENE_0)
    if f28_arg1:IsLadderAct(TARGET_SELF) then
        return false
    end
    if not f28_arg1:HasSpecialEffectId(TARGET_SELF, 200004) then
        return false
    end
    if f28_arg1:IsInterupt(INTERUPT_ParryTiming) then
        return Common_Parry(f28_arg1, f28_arg2, 100, 0, 0, 3103)
    end
    if f28_arg1:IsInterupt(INTERUPT_ShootImpact) then
        return f28_arg0.ShootReaction(f28_arg1, f28_arg2)
    end
    return false
    
end

Goal.Damaged = function (f29_arg0, f29_arg1, f29_arg2)
    local f29_local0 = f29_arg0:GetRandam_Int(1, 100)
    local f29_local1 = f29_arg0:GetRandam_Int(1, 100)
    local f29_local2 = -1
    local f29_local3 = 1
    local f29_local4 = 1
    local f29_local5 = 0
    local f29_local6 = 0
    local f29_local7 = 0
    if f29_arg0:HasSpecialEffectId(TARGET_ENE_0, 100356) then
        f29_arg0:SetNumber(1, 0)
    elseif f29_arg0:HasSpecialEffectId(TARGET_ENE_0, 100357) then
        f29_arg0:SetNumber(1, 1)
    elseif f29_arg0:HasSpecialEffectId(TARGET_ENE_0, 100358) then
        f29_arg0:SetNumber(1, 2)
    elseif f29_arg0:HasSpecialEffectId(TARGET_ENE_0, 100360) then
        f29_arg0:SetNumber(1, 3)
    elseif f29_arg0:HasSpecialEffectId(TARGET_ENE_0, 100361) then
        f29_arg0:SetNumber(1, 4)
    end
    f29_local2 = 9910
    if f29_local0 <= 70 then
        f29_arg1:ClearSubGoal()
        f29_arg1:AddSubGoal(GOAL_COMMON_SidewayMove, f29_local3, TARGET_ENE_0, f29_local5, f29_local6, true, true, f29_local2)
        return true
    end
    if f29_local1 <= 33 then
        if SpaceCheck(f29_arg0, f29_arg1, 180, 1) == true then
            f29_arg1:ClearSubGoal()
            f29_arg1:AddSubGoal(GOAL_COMMON_LeaveTarget, 1.5, TARGET_ENE_0, 9999, TARGET_ENE_0, true, f29_local2):SetTargetRange(0, -99, 10)
            return true
        else
            f29_arg1:ClearSubGoal()
            f29_arg1:AddSubGoal(GOAL_COMMON_SidewayMove, f29_local3, TARGET_ENE_0, f29_local5, f29_local6, true, true, f29_local2)
            return true
        end
    elseif SpaceCheck(f29_arg0, f29_arg1, 180, 2) == true then
        f29_arg1:ClearSubGoal()
        f29_arg1:AddSubGoal(GOAL_COMMON_SpinStep, f29_local4, 5201, TARGET_ENE_0, f29_local7, AI_DIR_TYPE_B, 0)
        return true
    else
        return false
    end
    return false
    
end

Goal.ShootReaction = function (f30_arg0, f30_arg1)
    local f30_local0 = f30_arg0:GetDist(TARGET_ENE_0)
    if f30_arg0:HasSpecialEffectId(TARGET_SELF, 5026) then
        f30_arg1:ClearSubGoal()
        f30_arg1:AddSubGoal(GOAL_COMMON_EndureAttack, 0.1, 3102, TARGET_ENE_0, 9999, 0)
        return true
    elseif f30_arg0:HasSpecialEffectId(TARGET_SELF, 200030) then
        if f30_arg0:IsInsideTargetEx(TARGET_ENE_0, TARGET_SELF, AI_DIR_TYPE_F, 20, 999) then
            if f30_local0 <= 30 then
                f30_arg1:ClearSubGoal()
                f30_arg1:AddSubGoal(GOAL_COMMON_EndureAttack, 0.1, 3100, TARGET_ENE_0, 9999, 0)
                return true
            else
                f30_arg1:ClearSubGoal()
                f30_arg1:AddSubGoal(GOAL_COMMON_Wait, 0.3, TARGET_SELF, 0, 0, 0)
                f30_arg1:AddSubGoal(GOAL_COMMON_EndureAttack, 0.1, 3100, TARGET_ENE_0, 9999, 0)
                return true
            end
        end
    elseif f30_arg0:HasSpecialEffectId(TARGET_SELF, 200031) and f30_arg0:IsInsideTargetEx(TARGET_ENE_0, TARGET_SELF, AI_DIR_TYPE_F, 90, 999) then
        if f30_local0 <= 30 then
            f30_arg1:ClearSubGoal()
            f30_arg1:AddSubGoal(GOAL_COMMON_EndureAttack, 0.1, 3011, TARGET_ENE_0, 9999, 0)
            return true
        else
            f30_arg1:ClearSubGoal()
            f30_arg1:AddSubGoal(GOAL_COMMON_Wait, 0.3, TARGET_SELF, 0, 0, 0)
            f30_arg1:AddSubGoal(GOAL_COMMON_EndureAttack, 0.1, 3011, TARGET_ENE_0, 9999, 0)
            return true
        end
    end
    return false
    
end

Goal.InObserveArea_Action = function (f31_arg0, f31_arg1)
    local f31_local0 = 0
    local f31_local1 = 0
    if f31_arg0:HasSpecialEffectId(TARGET_SELF, 200031) and f31_arg0:IsInsideObserve(0) then
        f31_arg1:ClearSubGoal()
        f31_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 5, 3010, TARGET_ENE_0, 9999, 0, 0)
        f31_arg0:DeleteObserve(0)
        return true
    end
    return false
    
end

Goal.Kengeki_Activate = function (f32_arg0, f32_arg1, f32_arg2, f32_arg3)
    local f32_local0 = ReturnKengekiSpecialEffect(f32_arg1)
    if f32_local0 == 0 then
        return false
    end
    local f32_local1 = {}
    local f32_local2 = {}
    local f32_local3 = {}
    Common_Clear_Param(f32_local1, f32_local2, f32_local3)
    local f32_local4 = f32_arg1:GetDist(TARGET_ENE_0)
    local f32_local5 = f32_arg1:GetSp(TARGET_SELF)
    local f32_local6 = f32_arg1:GetSpRate(TARGET_SELF)
    if f32_local0 == 200200 then
        if f32_local4 >= 2.5 then
            f32_local1[50] = 100
        else
            f32_local1[3] = 100
            f32_local1[1] = 100
        end
    elseif f32_local0 == 200201 then
        if f32_local4 >= 2.5 then
            f32_local1[50] = 100
        else
            f32_local1[6] = 100
            f32_local1[4] = 100
        end
    elseif f32_local0 == 200205 then
        if f32_local4 >= 2.5 then
            f32_local1[50] = 100
        else
            f32_local1[3] = 100
            f32_local1[2] = 100
        end
    elseif f32_local0 == 200206 then
        if f32_local4 >= 2.5 then
            f32_local1[50] = 100
        else
            f32_local1[6] = 100
            f32_local1[4] = 100
        end
    elseif f32_local0 == 200210 then
        if f32_local4 >= 2.5 then
            f32_local1[50] = 100
        else
            f32_local1[4] = 10
            f32_local1[9] = 200
        end
    elseif f32_local0 == 200211 then
        if f32_local4 >= 2.5 then
            f32_local1[50] = 100
        else
            f32_local1[11] = 100
            f32_local1[12] = 200
        end
    elseif f32_local0 == 200215 then
        if f32_local4 >= 2 then
            f32_local1[50] = 100
        else
            f32_local1[7] = 100
            f32_local1[8] = 100
        end
    elseif f32_local0 == 200216 then
        if f32_local4 >= 2 then
            f32_local1[50] = 100
        else
            f32_local1[10] = 100
            f32_local1[13] = 100
        end
    else
        f32_local1[50] = 100
    end
    if f32_local6 < 50 then
        f32_local1[9] = f32_local1[9] * 2
        f32_local1[12] = f32_local1[12] * 2
        f32_local1[13] = f32_local1[13] * 2
    end
    if SpaceCheck(f32_arg1, f32_arg2, -180, 2) == false then
        f32_local1[13] = 0
    end
    if (f32_local0 == 200200 or f32_local0 == 200201 or f32_local0 == 200205 or f32_local0 == 200206) and f32_local6 <= 0.25 and SpaceCheck(f32_arg1, f32_arg2, -180, 2) == true then
        f32_local1[1] = 0
        f32_local1[2] = 0
        f32_local1[3] = 0
        f32_local1[4] = 0
        f32_local1[5] = 0
        f32_local1[6] = 0
        f32_local1[24] = 100
    end
    if f32_arg1:IsInsideTargetRegion(TARGET_SELF, 1112250) or f32_arg1:IsInsideTargetRegion(TARGET_ENE_0, 1112250) then
        f32_local1[9] = 0
        f32_local1[13] = 0
    end
    f32_local1[13] = SetCoolTime(f32_arg1, f32_arg2, 3006, 10, f32_local1[13], 1)
    f32_local2[1] = REGIST_FUNC(f32_arg1, f32_arg2, f32_arg0.Kengeki01)
    f32_local2[2] = REGIST_FUNC(f32_arg1, f32_arg2, f32_arg0.Kengeki02)
    f32_local2[3] = REGIST_FUNC(f32_arg1, f32_arg2, f32_arg0.Kengeki03)
    f32_local2[4] = REGIST_FUNC(f32_arg1, f32_arg2, f32_arg0.Kengeki04)
    f32_local2[5] = REGIST_FUNC(f32_arg1, f32_arg2, f32_arg0.Kengeki05)
    f32_local2[6] = REGIST_FUNC(f32_arg1, f32_arg2, f32_arg0.Kengeki06)
    f32_local2[7] = REGIST_FUNC(f32_arg1, f32_arg2, f32_arg0.Kengeki07)
    f32_local2[8] = REGIST_FUNC(f32_arg1, f32_arg2, f32_arg0.Kengeki08)
    f32_local2[9] = REGIST_FUNC(f32_arg1, f32_arg2, f32_arg0.Kengeki09)
    f32_local2[10] = REGIST_FUNC(f32_arg1, f32_arg2, f32_arg0.Kengeki10)
    f32_local2[11] = REGIST_FUNC(f32_arg1, f32_arg2, f32_arg0.Kengeki11)
    f32_local2[12] = REGIST_FUNC(f32_arg1, f32_arg2, f32_arg0.Kengeki12)
    f32_local2[13] = REGIST_FUNC(f32_arg1, f32_arg2, f32_arg0.Kengeki13)
    f32_local2[21] = REGIST_FUNC(f32_arg1, f32_arg2, f32_arg0.Act21)
    f32_local2[23] = REGIST_FUNC(f32_arg1, f32_arg2, f32_arg0.Act23)
    f32_local2[24] = REGIST_FUNC(f32_arg1, f32_arg2, f32_arg0.Act24)
    f32_local2[25] = REGIST_FUNC(f32_arg1, f32_arg2, f32_arg0.Act25)
    f32_local2[50] = REGIST_FUNC(f32_arg1, f32_arg2, f32_arg0.NoAction)
    local f32_local7 = REGIST_FUNC(f32_arg1, f32_arg2, f32_arg0.ActAfter_AdjustSpace)
    return Common_Kengeki_Activate(f32_arg1, f32_arg2, f32_local1, f32_local2, f32_local7, f32_local3)
    
end

Goal.Kengeki01 = function (f33_arg0, f33_arg1, f33_arg2)
    f33_arg1:ClearSubGoal()
    f33_arg1:AddSubGoal(GOAL_COMMON_ComboRepeat, 10, 3050, TARGET_ENE_0, 3.5 - f33_arg0:GetMapHitRadius(TARGET_SELF), 0)
    f33_arg1:AddSubGoal(GOAL_COMMON_ComboRepeat, 10, 3013, TARGET_ENE_0, 9999, 0)
    f33_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3014, TARGET_ENE_0, 9999, 0, 0):TimingSetNumber(0, f33_arg0:GetNumber(0) + 1, AI_TIMING_SET__ACTIVATE)
    
end

Goal.Kengeki02 = function (f34_arg0, f34_arg1, f34_arg2)
    f34_arg1:ClearSubGoal()
    f34_arg1:AddSubGoal(GOAL_COMMON_ComboRepeat, 10, 3051, TARGET_ENE_0, 3 - f34_arg0:GetMapHitRadius(TARGET_SELF), 0)
    f34_arg1:AddSubGoal(GOAL_COMMON_ComboRepeat, 10, 3016, TARGET_ENE_0, 2 - f34_arg0:GetMapHitRadius(TARGET_SELF), 0)
    f34_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3017, TARGET_ENE_0, 9999, 0, 0)
    f34_arg0:SetNumber(0, 0)
    
end

Goal.Kengeki03 = function (f35_arg0, f35_arg1, f35_arg2)
    f35_arg1:ClearSubGoal()
    f35_arg1:AddSubGoal(GOAL_COMMON_ComboRepeat, 10, 3060, TARGET_ENE_0, 3.5 - f35_arg0:GetMapHitRadius(TARGET_SELF), 0)
    f35_arg1:AddSubGoal(GOAL_COMMON_ComboRepeat, 10, 3012, TARGET_ENE_0, 3.5 - f35_arg0:GetMapHitRadius(TARGET_SELF), 0)
    f35_arg1:AddSubGoal(GOAL_COMMON_ComboRepeat, 10, 3013, TARGET_ENE_0, 9999, 0)
    f35_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3014, TARGET_ENE_0, 9999, 0, 0)
    f35_arg0:SetNumber(0, 0)
    
end

Goal.Kengeki04 = function (f36_arg0, f36_arg1, f36_arg2)
    f36_arg1:ClearSubGoal()
    f36_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 1, 3056, TARGET_ENE_0, 9999, 0, 0)
    
end

Goal.Kengeki05 = function (f37_arg0, f37_arg1, f37_arg2)
    local f37_local0 = f37_arg0:GetRandam_Int(1, 100)
    f37_arg1:ClearSubGoal()
    f37_arg1:AddSubGoal(GOAL_COMMON_ComboRepeat, 1, 3057, TARGET_ENE_0, 3, 0, 0)
    f37_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3017, TARGET_ENE_0, 3, 0, 0)
    
end

Goal.Kengeki06 = function (f38_arg0, f38_arg1, f38_arg2)
    f38_arg1:ClearSubGoal()
    f38_arg1:AddSubGoal(GOAL_COMMON_ComboRepeat, 10, 3065, TARGET_ENE_0, 4, 0)
    f38_arg1:AddSubGoal(GOAL_COMMON_ComboRepeat, 10, 3012, TARGET_ENE_0, 3, 0)
    f38_arg1:AddSubGoal(GOAL_COMMON_ComboRepeat, 10, 3013, TARGET_ENE_0, 9999, 0)
    f38_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3014, TARGET_ENE_0, 9999, 0, 0)
    f38_arg0:SetNumber(0, 0)
    
end

Goal.Kengeki07 = function (f39_arg0, f39_arg1, f39_arg2)
    f39_arg1:ClearSubGoal()
    f39_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 1, 3071, TARGET_ENE_0, 9999, 0, 0):TimingSetNumber(0, f39_arg0:GetNumber(0) + 1, AI_TIMING_SET__ACTIVATE)
    
end

Goal.Kengeki08 = function (f40_arg0, f40_arg1, f40_arg2)
    f40_arg1:ClearSubGoal()
    f40_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 1, 3072, TARGET_ENE_0, 9999, 0, 0)
    
end

Goal.Kengeki09 = function (f41_arg0, f41_arg1, f41_arg2)
    f41_arg0:SetNumber(1, 0)
    f41_arg1:ClearSubGoal()
    f41_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 1, 3073, TARGET_ENE_0, 9999, 0, 0)
    
end

Goal.Kengeki10 = function (f42_arg0, f42_arg1, f42_arg2)
    f42_arg1:ClearSubGoal()
    f42_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 1, 3078, TARGET_ENE_0, 9999, 0, 0):TimingSetNumber(0, f42_arg0:GetNumber(0) + 1, AI_TIMING_SET__ACTIVATE)
    
end

Goal.Kengeki11 = function (f43_arg0, f43_arg1, f43_arg2)
    local f43_local0 = f43_arg0:GetRandam_Int(1, 100)
    f43_arg1:ClearSubGoal()
    if f43_arg0:IsInsideTargetRegion(TARGET_SELF, 1112250) or f43_arg0:IsInsideTargetRegion(TARGET_ENE_0, 1112250) then
        f43_arg1:AddSubGoal(GOAL_COMMON_ComboRepeat, 10, 3076, TARGET_ENE_0, 6, 0)
    else
        f43_arg1:AddSubGoal(GOAL_COMMON_ComboRepeat, 10, 3076, TARGET_ENE_0, 6, 0)
        if f43_local0 <= 80 then
            f43_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3079, TARGET_ENE_0, 9999, 0, 0)
        end
    end
    
end

Goal.Kengeki12 = function (f44_arg0, f44_arg1, f44_arg2)
    local f44_local0 = f44_arg0:GetRandam_Int(1, 100)
    local f44_local1 = f44_arg0:GetSpRate(TARGET_SELF)
    f44_arg1:ClearSubGoal()
    if f44_local0 <= 85 then
        f44_arg1:AddSubGoal(GOAL_COMMON_ComboRepeat, 10, 3077, TARGET_ENE_0, 9999, 0)
        f44_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3017, TARGET_ENE_0, 9999, 0, 0):TimingSetNumber(0, f44_arg0:GetNumber(0) + 1, AI_TIMING_SET__ACTIVATE)
    else
        f44_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 1, 3077, TARGET_ENE_0, 9999, 0, 0):TimingSetNumber(0, f44_arg0:GetNumber(0) + 1, AI_TIMING_SET__ACTIVATE)
    end
    
end

Goal.Kengeki13 = function (f45_arg0, f45_arg1, f45_arg2)
    local f45_local0 = f45_arg0:GetDist(TARGET_ENE_0)
    local f45_local1 = 3
    f45_arg1:ClearSubGoal()
    f45_arg1:AddSubGoal(GOAL_COMMON_ComboRepeat, 10, 3008, TARGET_ENE_0, 9999, 0)
    f45_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3006, TARGET_ENE_0, 9999, 0, 0)
    return GETWELLSPACE_ODDS
    
end

Goal.NoAction = function (f46_arg0, f46_arg1, f46_arg2)
    return -1
    
end

Goal.ActAfter_AdjustSpace = function (f47_arg0, f47_arg1, f47_arg2)
    
end

Goal.Update = function (f48_arg0, f48_arg1, f48_arg2)
    return Update_Default_NoSubGoal(f48_arg0, f48_arg1, f48_arg2)
    
end

Goal.Terminate = function (f49_arg0, f49_arg1, f49_arg2)
    
end


