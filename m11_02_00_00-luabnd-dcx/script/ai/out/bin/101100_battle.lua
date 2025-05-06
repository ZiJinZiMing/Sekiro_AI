RegisterTableGoal(GOAL_Tutorial_Ochimusha_katate_101100_Battle, "GOAL_Tutorial_Ochimusha_katate_101100_Battle")
REGISTER_GOAL_NO_UPDATE(GOAL_Tutorial_Ochimusha_katate_101100_Battle, true)

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
    local f2_local5 = f2_arg1:GetNpcThinkParamID()
    Set_ConsecutiveGuardCount_Interrupt(f2_arg1)
    if f2_arg0.Kengeki_Activate(f2_arg0, f2_arg1, f2_arg2) then
        return
    end
    if Common_ActivateAct(f2_arg1, f2_arg2) then
    elseif f2_arg1:CheckDoesExistPath(TARGET_ENE_0, AI_DIR_TYPE_F, 0, 0) == false then
        f2_local0[27] = 100
    elseif f2_arg1:HasSpecialEffectId(TARGET_SELF, 5020) then
        if f2_arg1:GetNumber(0) == 0 then
            f2_local0[23] = 1000000000
            f2_local0[1] = 1
        else
            f2_local0[1] = 100
            f2_local0[23] = 10
        end
    elseif f2_arg1:HasSpecialEffectId(TARGET_SELF, 5021) then
        if f2_arg1:GetNumber(0) == 0 then
            f2_local0[32] = 100
        else
            f2_local0[1] = 100
            f2_local0[23] = 10
        end
    elseif f2_local4 == 1 and f2_arg1:GetTeamOrder(ORDER_TYPE_Role) == ROLE_TYPE_Kankyaku then
        KankyakuAct(f2_arg1, f2_arg2)
    elseif f2_local4 == 1 and f2_arg1:GetTeamOrder(ORDER_TYPE_Role) == ROLE_TYPE_Torimaki then
        TorimakiAct(f2_arg1, f2_arg2, -1, 0)
    elseif f2_arg1:IsInsideTarget(TARGET_ENE_0, AI_DIR_TYPE_B, 180) then
        f2_local0[21] = 10
    elseif f2_arg1:IsInsideTargetEx(TARGET_ENE_0, TARGET_SELF, AI_DIR_TYPE_B, 240, 7) then
        f2_local0[30] = 100000
        f2_local0[1] = 1
    elseif f2_local3 >= 7 then
        f2_local0[1] = 10
        f2_local0[2] = 10
    else
        f2_local0[1] = 100
        f2_local0[2] = 100
    end
    if SpaceCheck(f2_arg1, f2_arg2, 45, 2) == false and SpaceCheck(f2_arg1, f2_arg2, -45, 2) == false then
        f2_local0[22] = 0
    end
    if SpaceCheck(f2_arg1, f2_arg2, 90, 1) == false and SpaceCheck(f2_arg1, f2_arg2, -90, 1) == false then
        f2_local0[23] = 0
        f2_local0[30] = 0
    end
    if SpaceCheck(f2_arg1, f2_arg2, 180, 2) == false then
        f2_local0[24] = 0
    end
    if SpaceCheck(f2_arg1, f2_arg2, 180, 1) == false then
        f2_local0[25] = 0
    end
    f2_local0[1] = SetCoolTime(f2_arg1, f2_arg2, 3000, 8, f2_local0[1], 1)
    f2_local0[2] = SetCoolTime(f2_arg1, f2_arg2, 3012, 8, f2_local0[2], 1)
    f2_local0[3] = SetCoolTime(f2_arg1, f2_arg2, 3003, 8, f2_local0[3], 1)
    f2_local1[1] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act01)
    f2_local1[2] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act02)
    f2_local1[3] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act03)
    f2_local1[21] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act21)
    f2_local1[22] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act22)
    f2_local1[23] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act23)
    f2_local1[24] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act24)
    f2_local1[25] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act25)
    f2_local1[26] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act26)
    f2_local1[27] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act27)
    f2_local1[28] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act28)
    f2_local1[30] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act30)
    f2_local1[31] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act31)
    f2_local1[32] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act32)
    local f2_local6 = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.ActAfter_AdjustSpace)
    Common_Battle_Activate(f2_arg1, f2_arg2, f2_local0, f2_local1, f2_local6, f2_local2)
    
end

Goal.Act01 = function (f3_arg0, f3_arg1, f3_arg2)
    local f3_local0 = 2.5 - f3_arg0:GetMapHitRadius(TARGET_SELF)
    local f3_local1 = 2.5 - f3_arg0:GetMapHitRadius(TARGET_SELF) + 2
    local f3_local2 = 2.5 - f3_arg0:GetMapHitRadius(TARGET_SELF) + 2
    local f3_local3 = 100
    local f3_local4 = 0
    local f3_local5 = 3
    local f3_local6 = 5
    Approach_Act_Flex(f3_arg0, f3_arg1, f3_local0, f3_local1, f3_local2, f3_local3, f3_local4, f3_local5, f3_local6)
    local f3_local7 = 3 - f3_arg0:GetMapHitRadius(TARGET_SELF)
    local f3_local8 = 0
    local f3_local9 = 0
    f3_arg1:AddSubGoal(GOAL_COMMON_ComboAttackTunableSpin, 10, 3000, TARGET_ENE_0, f3_local7, f3_local8, f3_local9, 0, 0)
    f3_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3001, TARGET_ENE_0, 9999, 0, 0)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act02 = function (f4_arg0, f4_arg1, f4_arg2)
    local f4_local0 = 3 - f4_arg0:GetMapHitRadius(TARGET_SELF)
    local f4_local1 = 3 - f4_arg0:GetMapHitRadius(TARGET_SELF) + 2
    local f4_local2 = 3 - f4_arg0:GetMapHitRadius(TARGET_SELF) + 2
    local f4_local3 = 100
    local f4_local4 = 0
    local f4_local5 = 1.5
    local f4_local6 = 3
    Approach_Act_Flex(f4_arg0, f4_arg1, f4_local0, f4_local1, f4_local2, f4_local3, f4_local4, f4_local5, f4_local6)
    local f4_local7 = 0
    local f4_local8 = 0
    f4_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 10, 3012, TARGET_ENE_0, 9999, f4_local7, f4_local8, 0, 0)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act03 = function (f5_arg0, f5_arg1, f5_arg2)
    local f5_local0 = 6.1 - f5_arg0:GetMapHitRadius(TARGET_SELF)
    local f5_local1 = 6.1 - f5_arg0:GetMapHitRadius(TARGET_SELF) + 2
    local f5_local2 = 6.1 - f5_arg0:GetMapHitRadius(TARGET_SELF) + 2
    local f5_local3 = 100
    local f5_local4 = 0
    local f5_local5 = 1.5
    local f5_local6 = 3
    Approach_Act_Flex(f5_arg0, f5_arg1, f5_local0, f5_local1, f5_local2, f5_local3, f5_local4, f5_local5, f5_local6)
    local f5_local7 = 0
    local f5_local8 = 0
    f5_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 10, 3003, TARGET_ENE_0, 9999, f5_local7, f5_local8, 0, 0)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act31 = function (f6_arg0, f6_arg1, f6_arg2)
    local f6_local0 = f6_arg0:GetDist(TARGET_ENE_0)
    local f6_local1 = 5
    local f6_local2 = 4
    local f6_local3 = 180
    local f6_local4 = 0
    if SpaceCheck(f6_arg0, f6_arg1, -90, 1) == true then
        if SpaceCheck(f6_arg0, f6_arg1, 90, 1) == true then
            if f6_arg0:IsInsideTargetEx(TARGET_ENE_0, TARGET_SELF, AI_DIR_TYPE_R, 180, 999) then
                f6_local4 = 1
            else
                f6_local4 = 0
            end
        else
            f6_local4 = 0
        end
    elseif SpaceCheck(f6_arg0, f6_arg1, 90, 1) == true then
        f6_local4 = 1
    else
    end
    f6_arg1:AddSubGoal(GOAL_COMMON_ApproachTarget, f6_local1, TARGET_ENE_0, 3, TARGET_SELF, false, -1)
    f6_arg1:AddSubGoal(GOAL_COMMON_SidewayMove, f6_local2, TARGET_ENE_0, f6_local4, f6_local3, true, false, 9910)
    f6_arg0:SetNumber(0, 1)
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
    
end

Goal.Act32 = function (f7_arg0, f7_arg1, f7_arg2)
    local f7_local0 = 6.1 - f7_arg0:GetMapHitRadius(TARGET_SELF)
    local f7_local1 = 6.1 - f7_arg0:GetMapHitRadius(TARGET_SELF)
    local f7_local2 = 6.1 - f7_arg0:GetMapHitRadius(TARGET_SELF)
    local f7_local3 = 100
    local f7_local4 = 0
    local f7_local5 = 1.5
    local f7_local6 = 3
    Approach_Act_Flex(f7_arg0, f7_arg1, f7_local0, f7_local1, f7_local2, f7_local3, f7_local4, f7_local5, f7_local6)
    local f7_local7 = 0
    local f7_local8 = 0
    local f7_local9 = 0
    if SpaceCheck(f7_arg0, f7_arg1, -90, 1) == true then
        if SpaceCheck(f7_arg0, f7_arg1, 90, 1) == true then
            if f7_arg0:IsInsideTargetEx(TARGET_ENE_0, TARGET_SELF, AI_DIR_TYPE_R, 180, 999) then
                f7_local9 = 1
            else
                f7_local9 = 0
            end
        else
            f7_local9 = 0
        end
    elseif SpaceCheck(f7_arg0, f7_arg1, 90, 1) == true then
        f7_local9 = 1
    else
        f7_local9 = 1
    end
    f7_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 10, 3003, TARGET_ENE_0, 9999, f7_local7, f7_local8, 0, 0):TimingSetNumber(0, 1, AI_TIMING_SET__ACTIVATE)
    f7_arg1:AddSubGoal(GOAL_COMMON_SidewayMove, 5, TARGET_ENE_0, f7_local9, 180, true, false, 9910)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act21 = function (f8_arg0, f8_arg1, f8_arg2)
    local f8_local0 = 3
    local f8_local1 = 45
    f8_arg1:AddSubGoal(GOAL_COMMON_Turn, f8_local0, TARGET_ENE_0, f8_local1, -1, GOAL_RESULT_Success, true)
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
    
end

Goal.Act22 = function (f9_arg0, f9_arg1, f9_arg2)
    local f9_local0 = 3
    local f9_local1 = 0
    local f9_local2 = 5202
    if SpaceCheck(f9_arg0, f9_arg1, -45, 2) == true then
        if SpaceCheck(f9_arg0, f9_arg1, 45, 2) == true then
            if f9_arg0:IsInsideTarget(TARGET_ENE_0, AI_DIR_TYPE_R, 180) then
                f9_local2 = 5202
            else
                f9_local2 = 5203
            end
        else
            f9_local2 = 5202
        end
    elseif SpaceCheck(f9_arg0, f9_arg1, 45, 2) == true then
        f9_local2 = 5203
    else
    end
    f9_arg1:AddSubGoal(GOAL_COMMON_SpinStep, f9_local0, f9_local2, TARGET_ENE_0, f9_local1, AI_DIR_TYPE_R, 0)
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
    
end

Goal.Act23 = function (f10_arg0, f10_arg1, f10_arg2)
    local f10_local0 = f10_arg0:GetDist(TARGET_ENE_0)
    local f10_local1 = f10_arg0:GetSp(TARGET_SELF)
    local f10_local2 = 20
    local f10_local3 = f10_arg0:GetRandam_Int(1, 100)
    local f10_local4 = 9910
    local f10_local5 = 0
    if SpaceCheck(f10_arg0, f10_arg1, -90, 1) == true then
        if SpaceCheck(f10_arg0, f10_arg1, 90, 1) == true then
            if f10_arg0:IsInsideTargetEx(TARGET_ENE_0, TARGET_SELF, AI_DIR_TYPE_R, 180, 999) then
                f10_local5 = 1
            else
                f10_local5 = 0
            end
        else
            f10_local5 = 0
        end
    elseif SpaceCheck(f10_arg0, f10_arg1, 90, 1) == true then
        f10_local5 = 1
    else
    end
    local f10_local6 = 3
    local f10_local7 = f10_arg0:GetRandam_Int(30, 45)
    f10_arg0:SetNumber(10, f10_local5)
    f10_arg1:AddSubGoal(GOAL_COMMON_SidewayMove, f10_local6, TARGET_ENE_0, f10_local5, f10_local7, true, true, f10_local4):TimingSetNumber(0, 1, AI_TIMING_SET__ACTIVATE)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act24 = function (f11_arg0, f11_arg1, f11_arg2)
    local f11_local0 = f11_arg0:GetDist(TARGET_ENE_0)
    local f11_local1 = 3
    local f11_local2 = 0
    local f11_local3 = 5201
    if SpaceCheck(f11_arg0, f11_arg1, 180, 2) ~= true or SpaceCheck(f11_arg0, f11_arg1, 180, 4) ~= true or f11_local0 > 4 then
    else
        f11_local3 = 5211
        if false then
        else
        end
    end
    f11_arg1:AddSubGoal(GOAL_COMMON_SpinStep, f11_local1, f11_local3, TARGET_ENE_0, f11_local2, AI_DIR_TYPE_B, 0)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act25 = function (f12_arg0, f12_arg1, f12_arg2)
    local f12_local0 = f12_arg0:GetRandam_Float(2, 4)
    local f12_local1 = f12_arg0:GetRandam_Float(5, 7)
    local f12_local2 = f12_arg0:GetDist(TARGET_ENE_0)
    local f12_local3 = -1
    f12_arg1:AddSubGoal(GOAL_COMMON_LeaveTarget, f12_local0, TARGET_ENE_0, f12_local1, TARGET_ENE_0, true, f12_local3)
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
    
end

Goal.Act26 = function (f13_arg0, f13_arg1, f13_arg2)
    f13_arg1:AddSubGoal(GOAL_COMMON_Wait, 0.5, TARGET_SELF, 0, 0, 0)
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
    
end

Goal.Act27 = function (f14_arg0, f14_arg1, f14_arg2)
    local f14_local0 = f14_arg0:GetRandam_Int(1, 100)
    if YousumiAct_SubGoal(f14_arg0, f14_arg1, true, 60, 30) == false then
        GetWellSpace_Odds = 0
        return GetWellSpace_Odds
    end
    local f14_local1 = 0
    local f14_local2 = SpaceCheck_SidewayMove(f14_arg0, f14_arg1, 1)
    if f14_local2 == 0 then
        f14_local1 = 0
    elseif f14_local2 == 1 then
        f14_local1 = 1
    elseif f14_local2 == 2 then
        if f14_local0 <= 50 then
            f14_local1 = 0
        else
            f14_local1 = 1
        end
    else
        f14_arg1:AddSubGoal(GOAL_COMMON_Wait, 1, TARGET_SELF, 0, 0, 0)
        GetWellSpace_Odds = 0
        return GetWellSpace_Odds
    end
    f14_arg0:SetNumber(10, f14_local1)
    f14_arg1:AddSubGoal(GOAL_COMMON_SidewayMove, 3, TARGET_ENE_0, f14_local1, f14_arg0:GetRandam_Int(30, 45), true, true, -1)
    f14_arg0:SetNumber(NUMBER_SLOT_FIGHT_COUNT, 0)
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
    
end

Goal.Act28 = function (f15_arg0, f15_arg1, f15_arg2)
    local f15_local0 = f15_arg0:GetDist(TARGET_ENE_0)
    local f15_local1 = 1.5
    local f15_local2 = 1.5
    local f15_local3 = f15_arg0:GetRandam_Int(30, 45)
    local f15_local4 = -1
    local f15_local5 = f15_arg0:GetRandam_Int(0, 1)
    if f15_local0 <= 5 then
        if f15_arg0:IsInsideTargetEx(TARGET_FRI_0, TARGET_SELF, AI_DIR_TYPE_R, 180, 999) then
            f15_arg1:AddSubGoal(GOAL_COMMON_SidewayMove, f15_local1, TARGET_ENE_0, 1, f15_local3, true, true, f15_local4)
        else
            f15_arg1:AddSubGoal(GOAL_COMMON_SidewayMove, f15_local1, TARGET_ENE_0, 0, f15_local3, true, true, f15_local4)
        end
    elseif f15_local0 <= 8 then
        f15_arg1:AddSubGoal(GOAL_COMMON_ApproachTarget, f15_local2, TARGET_ENE_0, 3, TARGET_SELF, true, -1)
    else
        f15_arg1:AddSubGoal(GOAL_COMMON_ApproachTarget, f15_local2, TARGET_ENE_0, 8, TARGET_SELF, false, -1)
    end
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
    
end

Goal.Act30 = function (f16_arg0, f16_arg1, f16_arg2)
    local f16_local0 = f16_arg0:GetDist(TARGET_ENE_0)
    local f16_local1 = f16_arg0:GetSp(TARGET_SELF)
    local f16_local2 = 20
    local f16_local3 = f16_arg0:GetRandam_Int(1, 100)
    local f16_local4 = 9910
    local f16_local5 = 0
    if SpaceCheck(f16_arg0, f16_arg1, -90, 1) == true then
        if SpaceCheck(f16_arg0, f16_arg1, 90, 1) == true then
            if f16_arg0:IsInsideTargetEx(TARGET_ENE_0, TARGET_SELF, AI_DIR_TYPE_R, 180, 999) then
                f16_local5 = 1
            else
                f16_local5 = 0
            end
        else
            f16_local5 = 0
        end
    elseif SpaceCheck(f16_arg0, f16_arg1, 90, 1) == true then
        f16_local5 = 1
    else
    end
    local f16_local6 = 3
    local f16_local7 = f16_arg0:GetRandam_Int(30, 45)
    f16_arg1:AddSubGoal(GOAL_COMMON_SidewayMove, f16_local6, TARGET_ENE_0, f16_local5, f16_local7, true, false, -1)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Interrupt = function (f17_arg0, f17_arg1, f17_arg2)
    local f17_local0 = f17_arg1:GetSpecialEffectActivateInterruptType(0)
    if f17_arg1:IsLadderAct(TARGET_SELF) then
        return false
    end
    if not f17_arg1:HasSpecialEffectId(TARGET_SELF, 200004) then
        return false
    end
    if f17_arg1:IsInterupt(INTERUPT_ParryTiming) then
        return Common_Parry(f17_arg1, f17_arg2, 0, 25, 0, 3102)
    end
    if f17_arg1:IsInterupt(INTERUPT_Damaged) then
        return f17_arg0.Damaged(f17_arg1, f17_arg2)
    end
    if f17_arg1:IsInterupt(INTERUPT_ShootImpact) and f17_arg0.ShootReaction(f17_arg1, f17_arg2) then
        return true
    end
    return false
    
end

Goal.Damaged = function (f18_arg0, f18_arg1, f18_arg2)
    local f18_local0 = 3
    if SpaceCheck(f18_arg0, f18_arg1, 180, 2) then
        f18_arg1:ClearSubGoal()
        f18_arg1:AddSubGoal(GOAL_COMMON_SpinStep, f18_local0, 5201, TARGET_ENE_0, 0, AI_DIR_TYPE_B, 0)
        return true
    end
    return false
    
end

Goal.ShootReaction = function (f19_arg0, f19_arg1)
    f19_arg1:ClearSubGoal()
    f19_arg1:AddSubGoal(GOAL_COMMON_EndureAttack, 0.3, 3100, TARGET_ENE_0, 9999, 0)
    return true
    
end

Goal.Kengeki_Activate = function (f20_arg0, f20_arg1, f20_arg2, f20_arg3)
    local f20_local0 = ReturnKengekiSpecialEffect(f20_arg1)
    if f20_local0 == 0 then
        return false
    end
    local f20_local1 = {}
    local f20_local2 = {}
    local f20_local3 = {}
    Common_Clear_Param(f20_local1, f20_local2, f20_local3)
    local f20_local4 = f20_arg1:GetDist(TARGET_ENE_0)
    local f20_local5 = f20_arg1:GetSp(TARGET_SELF)
    local f20_local6 = f20_arg1:GetNpcThinkParamID()
    if f20_local5 <= 0 then
        f20_local1[50] = 100
    elseif f20_local0 == 200200 or f20_local0 == 200205 then
        if f20_local6 == 10110002 then
            f20_local1[23] = 100
        elseif f20_local4 >= 2 then
            f20_local1[50] = 100
        elseif f20_local4 <= 0.2 then
            f20_local1[50] = 100
        else
            f20_local1[50] = 100
        end
    elseif f20_local0 == 200201 or f20_local0 == 200206 then
        if f20_local6 == 10110002 then
            f20_local1[23] = 100
        elseif f20_local4 >= 2 then
            f20_local1[50] = 100
        elseif f20_local4 <= 0.2 then
            f20_local1[50] = 100
        else
            f20_local1[50] = 100
        end
    elseif f20_local0 == 200210 or f20_local0 == 200215 then
        if f20_local6 == 10110001 then
            f20_local1[23] = 100
        elseif f20_local4 >= 2 then
            f20_local1[50] = 100
        elseif f20_local4 <= 0.2 then
            f20_local1[50] = 100
        else
            f20_local1[50] = 100
        end
    elseif f20_local0 == 200211 or f20_local0 == 200216 then
        if f20_local6 == 10110001 then
            f20_local1[23] = 100
        elseif f20_local4 >= 2 then
            f20_local1[50] = 100
        elseif f20_local4 <= 0.2 then
            f20_local1[50] = 100
        else
            f20_local1[50] = 100
        end
    else
        f20_local1[50] = 100
    end
    f20_local2[1] = REGIST_FUNC(f20_arg1, f20_arg2, f20_arg0.Kengeki01)
    f20_local2[2] = REGIST_FUNC(f20_arg1, f20_arg2, f20_arg0.Kengeki02)
    f20_local2[3] = REGIST_FUNC(f20_arg1, f20_arg2, f20_arg0.Kengeki03)
    f20_local2[4] = REGIST_FUNC(f20_arg1, f20_arg2, f20_arg0.Kengeki04)
    f20_local2[5] = REGIST_FUNC(f20_arg1, f20_arg2, f20_arg0.Kengeki05)
    f20_local2[6] = REGIST_FUNC(f20_arg1, f20_arg2, f20_arg0.Kengeki06)
    f20_local2[7] = REGIST_FUNC(f20_arg1, f20_arg2, f20_arg0.Kengeki07)
    f20_local2[8] = REGIST_FUNC(f20_arg1, f20_arg2, f20_arg0.Kengeki08)
    f20_local2[23] = REGIST_FUNC(f20_arg1, f20_arg2, f20_arg0.Kengeki23)
    f20_local2[50] = REGIST_FUNC(f20_arg1, f20_arg2, f20_arg0.NoAction)
    local f20_local7 = REGIST_FUNC(f20_arg1, f20_arg2, f20_arg0.ActAfter_AdjustSpace)
    Common_Kengeki_Activate(f20_arg1, f20_arg2, f20_local1, f20_local2, f20_local7, f20_local3)
    
end

Goal.Kengeki01 = function (f21_arg0, f21_arg1, f21_arg2)
    f21_arg1:ClearSubGoal()
    f21_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 1, 3050, TARGET_ENE_0, 9999, 0, 0)
    
end

Goal.Kengeki02 = function (f22_arg0, f22_arg1, f22_arg2)
    f22_arg1:ClearSubGoal()
    f22_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 1, 3051, TARGET_ENE_0, 9999, 0, 0)
    
end

Goal.Kengeki07 = function (f23_arg0, f23_arg1, f23_arg2)
    f23_arg1:ClearSubGoal()
    f23_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 1, 3075, TARGET_ENE_0, 9999, 0, 0)
    
end

Goal.Kengeki23 = function (f24_arg0, f24_arg1, f24_arg2)
    local f24_local0 = f24_arg0:GetDist(TARGET_ENE_0)
    local f24_local1 = f24_arg0:GetSp(TARGET_SELF)
    local f24_local2 = 20
    local f24_local3 = f24_arg0:GetRandam_Int(1, 100)
    local f24_local4 = -1
    if f24_local2 <= f24_local1 and f24_local3 <= 50 then
        f24_local4 = 9910
    end
    local f24_local5 = 0
    if SpaceCheck(f24_arg0, f24_arg1, -90, 1) == true then
        if SpaceCheck(f24_arg0, f24_arg1, 90, 1) == true then
            if f24_arg0:IsInsideTargetEx(TARGET_ENE_0, TARGET_SELF, AI_DIR_TYPE_R, 180, 999) then
                f24_local5 = 1
            else
                f24_local5 = 0
            end
        else
            f24_local5 = 0
        end
    elseif SpaceCheck(f24_arg0, f24_arg1, 90, 1) == true then
        f24_local5 = 1
    else
    end
    local f24_local6 = 4
    local f24_local7 = 180
    f24_arg1:AddSubGoal(GOAL_COMMON_SidewayMove, f24_local6, TARGET_ENE_0, f24_local5, f24_local7, true, true, -1)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.NoAction = function (f25_arg0, f25_arg1, f25_arg2)
    return -1
    
end

Goal.ActAfter_AdjustSpace = function (f26_arg0, f26_arg1, f26_arg2)
    
end

Goal.Update = function (f27_arg0, f27_arg1, f27_arg2)
    return Update_Default_NoSubGoal(f27_arg0, f27_arg1, f27_arg2)
    
end

Goal.Terminate = function (f28_arg0, f28_arg1, f28_arg2)
    
end


