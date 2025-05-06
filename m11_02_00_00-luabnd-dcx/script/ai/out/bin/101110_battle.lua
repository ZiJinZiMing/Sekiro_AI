RegisterTableGoal(GOAL_Tutorial_Ochimusha_hassou_101110_Battle, "GOAL_Tutorial_Ochimusha_hassou_101110_Battle")
REGISTER_GOAL_NO_UPDATE(GOAL_Tutorial_Ochimusha_hassou_101110_Battle, true)

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
    elseif f2_local5 == 10110603 and f2_arg1:GetNumber(0) == 0 then
        f2_local0[31] = 100
    elseif f2_local4 == 1 and f2_arg1:GetTeamOrder(ORDER_TYPE_Role) == ROLE_TYPE_Kankyaku then
        KankyakuAct(f2_arg1, f2_arg2)
    elseif f2_local4 == 1 and f2_arg1:GetTeamOrder(ORDER_TYPE_Role) == ROLE_TYPE_Torimaki then
        TorimakiAct(f2_arg1, f2_arg2, -1, 0)
    elseif f2_arg1:IsInsideTargetEx(TARGET_ENE_0, TARGET_SELF, AI_DIR_TYPE_B, 240, 4) then
        f2_local0[1] = 1
        f2_local0[30] = 100000
    elseif f2_local3 > 4 then
        f2_local0[1] = 30
        f2_local0[2] = 100
    else
        f2_local0[1] = 30
        f2_local0[23] = 10
        if f2_arg1:GetNumber(1) >= 1 then
            f2_local0[1] = 100
        end
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
    f2_local0[1] = SetCoolTime(f2_arg1, f2_arg2, 3000, 5, f2_local0[1], 1)
    f2_local0[2] = SetCoolTime(f2_arg1, f2_arg2, 3002, 5, f2_local0[2], 1)
    f2_local1[1] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act01)
    f2_local1[2] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act02)
    f2_local1[21] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act21)
    f2_local1[22] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act22)
    f2_local1[23] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act23)
    f2_local1[24] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act24)
    f2_local1[25] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act25)
    f2_local1[26] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act26)
    f2_local1[27] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act27)
    f2_local1[28] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act28)
    f2_local1[29] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act29)
    f2_local1[30] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act30)
    f2_local1[31] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act31)
    local f2_local6 = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.ActAfter_AdjustSpace)
    Common_Battle_Activate(f2_arg1, f2_arg2, f2_local0, f2_local1, f2_local6, f2_local2)
    
end

Goal.Act01 = function (f3_arg0, f3_arg1, f3_arg2)
    local f3_local0 = 3.5 - f3_arg0:GetMapHitRadius(TARGET_SELF)
    local f3_local1 = 3.5 - f3_arg0:GetMapHitRadius(TARGET_SELF) + 2
    local f3_local2 = 3.5 - f3_arg0:GetMapHitRadius(TARGET_SELF) + 2
    local f3_local3 = 100
    local f3_local4 = 0
    local f3_local5 = 1.5
    local f3_local6 = 3
    Approach_Act_Flex(f3_arg0, f3_arg1, f3_local0, f3_local1, f3_local2, f3_local3, f3_local4, f3_local5, f3_local6)
    local f3_local7 = 3 - f3_arg0:GetMapHitRadius(TARGET_SELF)
    local f3_local8 = 0
    local f3_local9 = 0
    f3_arg1:AddSubGoal(GOAL_COMMON_ComboAttackTunableSpin, 10, 3000, TARGET_ENE_0, f3_local7, f3_local8, f3_local9, 0, 0)
    f3_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3001, TARGET_ENE_0, 9999, 0, 0)
    f3_arg0:SetNumber(0, 1)
    f3_arg0:SetNumber(1, 0)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act02 = function (f4_arg0, f4_arg1, f4_arg2)
    local f4_local0 = 5.8 - f4_arg0:GetMapHitRadius(TARGET_SELF)
    local f4_local1 = 5.8 - f4_arg0:GetMapHitRadius(TARGET_SELF) + 2
    local f4_local2 = 5.8 - f4_arg0:GetMapHitRadius(TARGET_SELF) + 2
    local f4_local3 = 100
    local f4_local4 = 0
    local f4_local5 = 1.5
    local f4_local6 = 3
    Approach_Act_Flex(f4_arg0, f4_arg1, f4_local0, f4_local1, f4_local2, f4_local3, f4_local4, f4_local5, f4_local6)
    local f4_local7 = 3 - f4_arg0:GetMapHitRadius(TARGET_SELF)
    local f4_local8 = 0
    local f4_local9 = 0
    f4_arg1:AddSubGoal(GOAL_COMMON_ComboAttackTunableSpin, 10, 3002, TARGET_ENE_0, f4_local7, f4_local8, f4_local9, 0, 0)
    f4_arg0:SetNumber(1, 0)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act21 = function (f5_arg0, f5_arg1, f5_arg2)
    local f5_local0 = 3
    local f5_local1 = 45
    f5_arg1:AddSubGoal(GOAL_COMMON_Turn, f5_local0, TARGET_ENE_0, f5_local1, -1, GOAL_RESULT_Success, true)
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
    
end

Goal.Act22 = function (f6_arg0, f6_arg1, f6_arg2)
    local f6_local0 = 3
    local f6_local1 = 0
    local f6_local2 = 5202
    if SpaceCheck(f6_arg0, f6_arg1, -45, 2) == true then
        if SpaceCheck(f6_arg0, f6_arg1, 45, 2) == true then
            if f6_arg0:IsInsideTarget(TARGET_ENE_0, AI_DIR_TYPE_R, 180) then
                f6_local2 = 5202
            else
                f6_local2 = 5203
            end
        else
            f6_local2 = 5202
        end
    elseif SpaceCheck(f6_arg0, f6_arg1, 45, 2) == true then
        f6_local2 = 5203
    else
    end
    f6_arg1:AddSubGoal(GOAL_COMMON_SpinStep, f6_local0, f6_local2, TARGET_ENE_0, f6_local1, AI_DIR_TYPE_R, 0)
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
    
end

Goal.Act23 = function (f7_arg0, f7_arg1, f7_arg2)
    local f7_local0 = f7_arg0:GetDist(TARGET_ENE_0)
    local f7_local1 = f7_arg0:GetSp(TARGET_SELF)
    local f7_local2 = 20
    local f7_local3 = f7_arg0:GetRandam_Int(1, 100)
    local f7_local4 = -1
    if f7_local2 <= f7_local1 and f7_local3 <= 50 then
        f7_local4 = 9910
    end
    local f7_local5 = 0
    if SpaceCheck(f7_arg0, f7_arg1, -90, 1) == true then
        if SpaceCheck(f7_arg0, f7_arg1, 90, 1) == true then
            if f7_arg0:IsInsideTargetEx(TARGET_ENE_0, TARGET_SELF, AI_DIR_TYPE_R, 180, 999) then
                f7_local5 = 1
            else
                f7_local5 = 0
            end
        else
            f7_local5 = 0
        end
    elseif SpaceCheck(f7_arg0, f7_arg1, 90, 1) == true then
        f7_local5 = 1
    else
    end
    local f7_local6 = 3
    local f7_local7 = f7_arg0:GetRandam_Int(30, 45)
    f7_arg0:SetNumber(10, f7_local5)
    f7_arg0:SetNumber(1, f7_arg0:GetNumber(1) + 1)
    f7_arg1:AddSubGoal(GOAL_COMMON_SidewayMove, f7_local6, TARGET_ENE_0, f7_local5, f7_local7, true, true, -1)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act24 = function (f8_arg0, f8_arg1, f8_arg2)
    local f8_local0 = f8_arg0:GetDist(TARGET_ENE_0)
    local f8_local1 = 3
    local f8_local2 = 0
    local f8_local3 = 5201
    if SpaceCheck(f8_arg0, f8_arg1, 180, 2) ~= true or SpaceCheck(f8_arg0, f8_arg1, 180, 4) ~= true or f8_local0 > 4 then
    else
        f8_local3 = 5211
        if false then
        else
        end
    end
    f8_arg1:AddSubGoal(GOAL_COMMON_SpinStep, f8_local1, f8_local3, TARGET_ENE_0, f8_local2, AI_DIR_TYPE_B, 0)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act25 = function (f9_arg0, f9_arg1, f9_arg2)
    local f9_local0 = f9_arg0:GetRandam_Float(2, 4)
    local f9_local1 = f9_arg0:GetRandam_Float(5, 7)
    local f9_local2 = f9_arg0:GetDist(TARGET_ENE_0)
    local f9_local3 = -1
    f9_arg1:AddSubGoal(GOAL_COMMON_LeaveTarget, f9_local0, TARGET_ENE_0, f9_local1, TARGET_ENE_0, true, f9_local3)
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
    
end

Goal.Act26 = function (f10_arg0, f10_arg1, f10_arg2)
    f10_arg1:AddSubGoal(GOAL_COMMON_Wait, 0.5, TARGET_SELF, 0, 0, 0)
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
    
end

Goal.Act27 = function (f11_arg0, f11_arg1, f11_arg2)
    local f11_local0 = f11_arg0:GetRandam_Int(1, 100)
    if YousumiAct_SubGoal(f11_arg0, f11_arg1, true, 60, 30) == false then
        GetWellSpace_Odds = 0
        return GetWellSpace_Odds
    end
    local f11_local1 = 0
    local f11_local2 = SpaceCheck_SidewayMove(f11_arg0, f11_arg1, 1)
    if f11_local2 == 0 then
        f11_local1 = 0
    elseif f11_local2 == 1 then
        f11_local1 = 1
    elseif f11_local2 == 2 then
        if f11_local0 <= 50 then
            f11_local1 = 0
        else
            f11_local1 = 1
        end
    else
        f11_arg1:AddSubGoal(GOAL_COMMON_Wait, 1, TARGET_SELF, 0, 0, 0)
        GetWellSpace_Odds = 0
        return GetWellSpace_Odds
    end
    f11_arg0:SetNumber(10, f11_local1)
    f11_arg1:AddSubGoal(GOAL_COMMON_SidewayMove, 3, TARGET_ENE_0, f11_local1, f11_arg0:GetRandam_Int(30, 45), true, true, -1)
    f11_arg0:SetNumber(NUMBER_SLOT_FIGHT_COUNT, 0)
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
    
end

Goal.Act28 = function (f12_arg0, f12_arg1, f12_arg2)
    local f12_local0 = f12_arg0:GetDist(TARGET_ENE_0)
    local f12_local1 = 1.5
    local f12_local2 = 1.5
    local f12_local3 = f12_arg0:GetRandam_Int(30, 45)
    local f12_local4 = -1
    local f12_local5 = f12_arg0:GetRandam_Int(0, 1)
    if f12_local0 <= 5 then
        if f12_arg0:IsInsideTargetEx(TARGET_FRI_0, TARGET_SELF, AI_DIR_TYPE_R, 180, 999) then
            f12_arg1:AddSubGoal(GOAL_COMMON_SidewayMove, f12_local1, TARGET_ENE_0, 1, f12_local3, true, true, f12_local4)
        else
            f12_arg1:AddSubGoal(GOAL_COMMON_SidewayMove, f12_local1, TARGET_ENE_0, 0, f12_local3, true, true, f12_local4)
        end
    elseif f12_local0 <= 8 then
        f12_arg1:AddSubGoal(GOAL_COMMON_ApproachTarget, f12_local2, TARGET_ENE_0, 3, TARGET_SELF, true, -1)
    else
        f12_arg1:AddSubGoal(GOAL_COMMON_ApproachTarget, f12_local2, TARGET_ENE_0, 8, TARGET_SELF, false, -1)
    end
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
    
end

Goal.Act29 = function (f13_arg0, f13_arg1, f13_arg2)
    local f13_local0 = 3
    f13_arg1:AddSubGoal(GOAL_COMMON_ApproachTarget, f13_local0, TARGET_ENE_0, 3.9, TARGET_SELF, false, -1)
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
    
end

Goal.Act30 = function (f14_arg0, f14_arg1, f14_arg2)
    local f14_local0 = f14_arg0:GetDist(TARGET_ENE_0)
    local f14_local1 = f14_arg0:GetSp(TARGET_SELF)
    local f14_local2 = 20
    local f14_local3 = f14_arg0:GetRandam_Int(1, 100)
    local f14_local4 = -1
    if f14_local2 <= f14_local1 and f14_local3 <= 50 then
        f14_local4 = 9910
    end
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
    f14_arg1:AddSubGoal(GOAL_COMMON_SidewayMove, f14_local6, TARGET_ENE_0, f14_local5, f14_local7, true, false, -1)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act31 = function (f15_arg0, f15_arg1, f15_arg2)
    local f15_local0 = 7
    f15_arg1:AddSubGoal(GOAL_COMMON_ApproachTarget, f15_local0, TARGET_ENE_0, 3.9, TARGET_SELF, true, -1)
    f15_arg0:SetNumber(0, 1)
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
    
end

Goal.Interrupt = function (f16_arg0, f16_arg1, f16_arg2)
    local f16_local0 = f16_arg1:GetSpecialEffectActivateInterruptType(0)
    if f16_arg1:IsLadderAct(TARGET_SELF) then
        return false
    end
    if not f16_arg1:HasSpecialEffectId(TARGET_SELF, 200004) then
        return false
    end
    if f16_arg1:IsInterupt(INTERUPT_ParryTiming) then
        return Common_Parry(f16_arg1, f16_arg2, 100, 0, 0, 3102)
    end
    if f16_arg1:IsInterupt(INTERUPT_Damaged) then
        return f16_arg0.Damaged(f16_arg1, f16_arg2)
    end
    if f16_arg1:IsInterupt(INTERUPT_ShootImpact) and f16_arg0.ShootReaction(f16_arg1, f16_arg2) then
        return true
    end
    return false
    
end

Goal.Damaged = function (f17_arg0, f17_arg1, f17_arg2)
    local f17_local0 = 3
    if SpaceCheck(f17_arg0, f17_arg1, 180, 2) then
        f17_arg1:ClearSubGoal()
        f17_arg1:AddSubGoal(GOAL_COMMON_SpinStep, f17_local0, 5211, TARGET_ENE_0, 0, AI_DIR_TYPE_B, 0)
        return true
    end
    return false
    
end

Goal.ShootReaction = function (f18_arg0, f18_arg1)
    f18_arg1:ClearSubGoal()
    f18_arg1:AddSubGoal(GOAL_COMMON_EndureAttack, 0.3, 3100, TARGET_ENE_0, 9999, 0)
    return true
    
end

Goal.Kengeki_Activate = function (f19_arg0, f19_arg1, f19_arg2, f19_arg3)
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
    if f19_local5 <= 0 then
        f19_local1[50] = 100
    elseif f19_local0 == 200205 then
        if f19_local4 >= 2 then
            f19_local1[50] = 100
        elseif f19_local4 <= 0.2 then
            f19_local1[50] = 100
        else
            f19_local1[5] = 100
        end
    elseif f19_local0 == 200206 then
        if f19_local4 >= 2 then
            f19_local1[50] = 100
        elseif f19_local4 <= 0.2 then
            f19_local1[50] = 100
        else
            f19_local1[5] = 100
        end
    elseif f19_local0 == 200210 then
        if f19_local4 >= 2 then
            f19_local1[50] = 100
        elseif f19_local4 <= 0.2 then
            f19_local1[50] = 100
        else
            f19_local1[1] = 100
        end
    elseif f19_local0 == 200211 then
        if f19_local4 >= 2 then
            f19_local1[50] = 100
        elseif f19_local4 <= 0.2 then
            f19_local1[50] = 100
        else
            f19_local1[1] = 100
        end
    elseif f19_local0 == 200215 then
        if f19_local4 >= 2 then
            f19_local1[50] = 100
        elseif f19_local4 <= 0.2 then
            f19_local1[50] = 100
        else
            f19_local1[5] = 100
        end
    elseif f19_local0 == 200216 then
        if f19_local4 >= 2 then
            f19_local1[50] = 100
        elseif f19_local4 <= 0.2 then
            f19_local1[50] = 100
        else
            f19_local1[5] = 100
        end
    else
        f19_local1[50] = 100
    end
    f19_local2[1] = REGIST_FUNC(f19_arg1, f19_arg2, f19_arg0.Kengeki01)
    f19_local2[2] = REGIST_FUNC(f19_arg1, f19_arg2, f19_arg0.Kengeki02)
    f19_local2[3] = REGIST_FUNC(f19_arg1, f19_arg2, f19_arg0.Kengeki03)
    f19_local2[4] = REGIST_FUNC(f19_arg1, f19_arg2, f19_arg0.Kengeki04)
    f19_local2[5] = REGIST_FUNC(f19_arg1, f19_arg2, f19_arg0.Kengeki05)
    f19_local2[6] = REGIST_FUNC(f19_arg1, f19_arg2, f19_arg0.Kengeki06)
    f19_local2[7] = REGIST_FUNC(f19_arg1, f19_arg2, f19_arg0.Kengeki07)
    f19_local2[8] = REGIST_FUNC(f19_arg1, f19_arg2, f19_arg0.Kengeki08)
    f19_local2[50] = REGIST_FUNC(f19_arg1, f19_arg2, f19_arg0.NoAction)
    local f19_local6 = REGIST_FUNC(f19_arg1, f19_arg2, f19_arg0.ActAfter_AdjustSpace)
    return Common_Kengeki_Activate(f19_arg1, f19_arg2, f19_local1, f19_local2, f19_local6, f19_local3)
    
end

Goal.Kengeki01 = function (f20_arg0, f20_arg1, f20_arg2)
    f20_arg1:ClearSubGoal()
    f20_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 1, 3076, TARGET_ENE_0, 9999, 0, 0)
    
end

Goal.Kengeki05 = function (f21_arg0, f21_arg1, f21_arg2)
    f21_arg1:ClearSubGoal()
    f21_arg1:AddSubGoal(GOAL_COMMON_ComboRepeat, 10, 3000, TARGET_ENE_0, 9999, 0, 0)
    f21_arg1:AddSubGoal(GOAL_COMMON_ComboRepeat, 10, 3001, TARGET_ENE_0, 9999, 0, 0)
    
end

Goal.NoAction = function (f22_arg0, f22_arg1, f22_arg2)
    return -1
    
end

Goal.ActAfter_AdjustSpace = function (f23_arg0, f23_arg1, f23_arg2)
    
end

Goal.Update = function (f24_arg0, f24_arg1, f24_arg2)
    return Update_Default_NoSubGoal(f24_arg0, f24_arg1, f24_arg2)
    
end

Goal.Terminate = function (f25_arg0, f25_arg1, f25_arg2)
    
end


