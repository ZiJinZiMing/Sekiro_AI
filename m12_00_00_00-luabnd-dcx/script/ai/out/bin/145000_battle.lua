RegisterTableGoal(GOAL_Yotakashu_Kinsetsu_145000_Battle, "GOAL_Yotakashu_Kinsetsu_145000_Battle")
REGISTER_GOAL_NO_UPDATE(GOAL_Yotakashu_Kinsetsu_145000_Battle, true)

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
    local f2_local5 = f2_arg1:GetHpRate(TARGET_SELF)
    local f2_local6 = f2_arg1:GetSp(TARGET_SELF)
    local f2_local7 = f2_arg1:GetEventRequest()
    local f2_local8 = f2_arg1:GetEventRequest(1)
    local f2_local9 = Check_ReachAttack(f2_arg1, 0)
    f2_arg1:AddObserveSpecialEffectAttribute(TARGET_SELF, 5030)
    f2_arg1:AddObserveSpecialEffectAttribute(TARGET_SELF, 5031)
    f2_arg1:AddObserveSpecialEffectAttribute(TARGET_SELF, 5032)
    f2_arg1:AddObserveSpecialEffectAttribute(TARGET_SELF, 5033)
    Set_ConsecutiveGuardCount_Interrupt(f2_arg1)
    f2_arg1:DeleteObserve(0)
    f2_arg1:SetStringIndexedNumber("noRun", false)
    if f2_arg1:IsInsideTargetRegion(TARGET_SELF, COMMON_REGION_FORCE_WALK_M11_1) then
        f2_arg1:SetStringIndexedNumber("noRun", true)
    end
    f2_arg1:AddObserveRegion(30, TARGET_SELF, COMMON_REGION_FORCE_WALK_M11_1)
    if f2_arg0.Kengeki_Activate(f2_arg0, f2_arg1, f2_arg2) then
        return
    end
    if (f2_arg1:GetNpcThinkParamID() == 14509008 or f2_arg1:GetNpcThinkParamID() == 14509009) and f2_arg1:GetNumber(2) == 0 then
        f2_local0[8] = 100
    elseif f2_local7 == 10 and not f2_arg1:HasSpecialEffectId(TARGET_SELF, 5020) then
        f2_local0[18] = 100
    elseif Common_ActivateAct(f2_arg1, f2_arg2) then
    elseif f2_local9 ~= POSSIBLE_ATTACK then
        if f2_local4 == 1 and f2_arg1:GetTeamOrder(ORDER_TYPE_Role) == ROLE_TYPE_Kankyaku then
            f2_local0[27] = 100
        elseif f2_local4 == 1 and f2_arg1:GetTeamOrder(ORDER_TYPE_Role) == ROLE_TYPE_Torimaki then
            f2_local0[27] = 100
        elseif f2_local9 == UNREACH_ATTACK then
            f2_local0[27] = 300
            f2_local0[19] = 500
        elseif f2_local9 == REACH_ATTACK_TARGET_HIGH_POSITION then
            f2_local0[27] = 300
            f2_local0[19] = 500
            f2_local0[14] = 500
        elseif f2_local9 == REACH_ATTACK_TARGET_LOW_POSITION then
            f2_local0[27] = 300
            f2_local0[19] = 500
            f2_local0[14] = 500
        else
            f2_local0[27] = 100
        end
    elseif f2_arg1:HasSpecialEffectId(TARGET_SELF, 200050) then
        f2_local0[30] = 100
    elseif f2_local4 == 1 and f2_arg1:GetTeamOrder(ORDER_TYPE_Role) == ROLE_TYPE_Kankyaku then
        KankyakuAct(f2_arg1, f2_arg2, 0, f2_arg1:GetStringIndexedNumber("noRun"))
    elseif f2_local4 == 1 and f2_arg1:GetTeamOrder(ORDER_TYPE_Role) == ROLE_TYPE_Torimaki then
        if TorimakiAct(f2_arg1, f2_arg2, 6, 0, f2_arg1:GetStringIndexedNumber("noRun")) then
            f2_local0[2] = 100
            f2_local0[5] = 100
        end
    else
        if f2_arg1:IsInsideTarget(TARGET_ENE_0, AI_DIR_TYPE_B, 180) then
            f2_local0[21] = 100
            f2_local0[22] = 1
        elseif not f2_arg1:HasSpecialEffectId(TARGET_SELF, 3145000) and f2_arg1:HasSpecialEffectId(TARGET_SELF, 5021) and f2_arg1:IsFinishTimer(1) == true then
            if f2_local3 >= 3 then
                f2_local0[7] = 1000
            else
                f2_local0[7] = 1
                f2_local0[24] = 1000
            end
        elseif f2_local3 >= 12 then
            f2_local0[1] = 0
            f2_local0[2] = 0
            f2_local0[4] = 0
            f2_local0[5] = 0
            f2_local0[8] = 100
            f2_local0[10] = 80
        elseif f2_local3 >= 7 then
            f2_local0[1] = 0
            f2_local0[2] = 50
            f2_local0[4] = 0
            f2_local0[5] = 50
            f2_local0[8] = 0
            f2_local0[10] = 100
        elseif f2_local3 >= 5 then
            f2_local0[1] = 0
            f2_local0[2] = 50
            f2_local0[4] = 0
            f2_local0[5] = 50
            f2_local0[8] = 0
            f2_local0[10] = 100
        elseif f2_local3 >= 3 then
            f2_local0[2] = 0
            f2_local0[4] = 50
            f2_local0[5] = 0
            f2_local0[24] = 50
        elseif f2_local3 >= 2 then
            f2_local0[2] = 0
            f2_local0[4] = 50
            f2_local0[5] = 0
            f2_local0[12] = 200
            f2_local0[24] = 100
        else
            f2_local0[2] = 0
            f2_local0[4] = 50
            f2_local0[5] = 0
            f2_local0[12] = 300
            f2_local0[24] = 100
        end
        if f2_arg1:HasSpecialEffectId(TARGET_SELF, 3145000) then
            f2_local0[7] = 1
        end
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
    f2_local0[1] = SetCoolTime(f2_arg1, f2_arg2, 3000, 5, f2_local0[1], 1)
    f2_local0[2] = SetCoolTime(f2_arg1, f2_arg2, 3002, 5, f2_local0[2], 1)
    f2_local0[3] = SetCoolTime(f2_arg1, f2_arg2, 3003, 5, f2_local0[3], 1)
    f2_local0[4] = SetCoolTime(f2_arg1, f2_arg2, 3004, 15, f2_local0[4], 1)
    f2_local0[5] = SetCoolTime(f2_arg1, f2_arg2, 3005, 5, f2_local0[5], 1)
    f2_local0[9] = SetCoolTime(f2_arg1, f2_arg2, 3017, 10, f2_local0[9], 1)
    f2_local0[10] = SetCoolTime(f2_arg1, f2_arg2, 3018, 10, f2_local0[10], 1)
    f2_local0[11] = SetCoolTime(f2_arg1, f2_arg2, 3009, 5, f2_local0[11], 1)
    f2_local0[12] = SetCoolTime(f2_arg1, f2_arg2, 3021, 5, f2_local0[12], 1)
    f2_local0[14] = SetCoolTime(f2_arg1, f2_arg2, 3025, 10, f2_local0[14], 1)
    f2_local0[16] = SetCoolTime(f2_arg1, f2_arg2, 3033, 10, f2_local0[16], 1)
    f2_local0[17] = SetCoolTime(f2_arg1, f2_arg2, 3032, 10, f2_local0[17], 1)
    f2_local0[19] = SetCoolTime(f2_arg1, f2_arg2, 3040, 5, f2_local0[19], 1)
    f2_local0[24] = SetCoolTime(f2_arg1, f2_arg2, 5211, 5, f2_local0[24], 1)
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
    f2_local1[13] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act13)
    f2_local1[14] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act14)
    f2_local1[15] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act15)
    f2_local1[16] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act16)
    f2_local1[17] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act17)
    f2_local1[18] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act18)
    f2_local1[19] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act19)
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
    f2_local1[40] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act40)
    f2_local1[41] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act41)
    f2_local1[42] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act42)
    f2_local1[43] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act43)
    f2_local1[44] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act44)
    local f2_local10 = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.ActAfter_AdjustSpace)
    Common_Battle_Activate(f2_arg1, f2_arg2, f2_local0, f2_local1, f2_local10, f2_local2)
    
end

Goal.Act15 = function (f3_arg0, f3_arg1, f3_arg2)
    local f3_local0 = 5.8 - f3_arg0:GetMapHitRadius(TARGET_SELF)
    local f3_local1 = 5.8 - f3_arg0:GetMapHitRadius(TARGET_SELF) + 0
    local f3_local2 = 5.8 - f3_arg0:GetMapHitRadius(TARGET_SELF) + 2
    local f3_local3 = 100
    local f3_local4 = 0
    local f3_local5 = 1.5
    local f3_local6 = 3
    Approach_Act_Flex(f3_arg0, f3_arg1, f3_local0, f3_local1, f3_local2, f3_local3, f3_local4, f3_local5, f3_local6)
    f3_arg1:AddSubGoal(GOAL_COMMON_ComboTunable_SuccessAngle180, 10, 3032, TARGET_ENE_0, 9999, TurnTime, FrontAngle, 0, 0)
    f3_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3031, TARGET_ENE_0, 9999, 0, 0)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act01 = function (f4_arg0, f4_arg1, f4_arg2)
    local f4_local0 = 4 - f4_arg0:GetMapHitRadius(TARGET_SELF)
    local f4_local1 = 4 - f4_arg0:GetMapHitRadius(TARGET_SELF) + 0
    local f4_local2 = 4 - f4_arg0:GetMapHitRadius(TARGET_SELF) + 2
    local f4_local3 = 100
    local f4_local4 = 0
    local f4_local5 = 1.5
    local f4_local6 = 3
    Approach_Act_Flex(f4_arg0, f4_arg1, f4_local0, f4_local1, f4_local2, f4_local3, f4_local4, f4_local5, f4_local6)
    local f4_local7 = 3.5 - f4_arg0:GetMapHitRadius(TARGET_SELF)
    local f4_local8 = 5.8 - f4_arg0:GetMapHitRadius(TARGET_SELF)
    local f4_local9 = 0
    local f4_local10 = 0
    f4_arg1:AddSubGoal(GOAL_COMMON_ComboAttackTunableSpin, 10, 3000, TARGET_ENE_0, f4_local7, f4_local9, f4_local10, 0, 0)
    f4_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3001, TARGET_ENE_0, 9999, 0, 0)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act02 = function (f5_arg0, f5_arg1, f5_arg2)
    local f5_local0 = 5.8 - f5_arg0:GetMapHitRadius(TARGET_SELF)
    local f5_local1 = 5.8 - f5_arg0:GetMapHitRadius(TARGET_SELF) + 0
    local f5_local2 = 5.8 - f5_arg0:GetMapHitRadius(TARGET_SELF) + 2
    local f5_local3 = 100
    local f5_local4 = 0
    local f5_local5 = 1.5
    local f5_local6 = 3
    local f5_local7 = f5_arg0:GetRandam_Int(1, 100)
    Approach_Act_Flex(f5_arg0, f5_arg1, f5_local0, f5_local1, f5_local2, f5_local3, f5_local4, f5_local5, f5_local6)
    local f5_local8 = 0
    local f5_local9 = 0
    if f5_local7 <= 30 then
        f5_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 10, 3002, TARGET_ENE_0, 9999, f5_local8, f5_local9, 0, 0)
    else
        f5_arg1:AddSubGoal(GOAL_COMMON_ComboAttackTunableSpin, 10, 3002, TARGET_ENE_0, 9999, 0, 0, 0, 0)
        f5_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3071, TARGET_ENE_0, 9999, 0, 0)
    end
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act03 = function (f6_arg0, f6_arg1, f6_arg2)
    local f6_local0 = 5.9 - f6_arg0:GetMapHitRadius(TARGET_SELF)
    local f6_local1 = 5.9 - f6_arg0:GetMapHitRadius(TARGET_SELF) + 0
    local f6_local2 = 5.9 - f6_arg0:GetMapHitRadius(TARGET_SELF) + 2
    local f6_local3 = 100
    local f6_local4 = 0
    local f6_local5 = 1.5
    local f6_local6 = 3
    Approach_Act_Flex(f6_arg0, f6_arg1, f6_local0, f6_local1, f6_local2, f6_local3, f6_local4, f6_local5, f6_local6)
    local f6_local7 = 0
    local f6_local8 = 0
    f6_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 10, 3003, TARGET_ENE_0, 9999, f6_local7, f6_local8, 0, 0)
    f6_arg1:AddSubGoal(GOAL_COMMON_ComboRepeat, 10, 3009, TARGET_ENE_0, 9999, 0, 0)
    f6_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3021, TARGET_ENE_0, 9999, 0, 0)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act04 = function (f7_arg0, f7_arg1, f7_arg2)
    local f7_local0 = 4.6 - f7_arg0:GetMapHitRadius(TARGET_SELF)
    local f7_local1 = 4.6 - f7_arg0:GetMapHitRadius(TARGET_SELF) + 0
    local f7_local2 = 4.6 - f7_arg0:GetMapHitRadius(TARGET_SELF) + 2
    local f7_local3 = 100
    local f7_local4 = 0
    local f7_local5 = 1.5
    local f7_local6 = 3
    Approach_Act_Flex(f7_arg0, f7_arg1, f7_local0, f7_local1, f7_local2, f7_local3, f7_local4, f7_local5, f7_local6)
    local f7_local7 = 0
    local f7_local8 = 0
    f7_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 10, 3004, TARGET_ENE_0, 9999, f7_local7, f7_local8, 0, 0)
    f7_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3020, TARGET_ENE_0, 9999, 0, 0)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act05 = function (f8_arg0, f8_arg1, f8_arg2)
    local f8_local0 = 5.8 - f8_arg0:GetMapHitRadius(TARGET_SELF)
    local f8_local1 = 5.8 - f8_arg0:GetMapHitRadius(TARGET_SELF) + 0
    local f8_local2 = 5.8 - f8_arg0:GetMapHitRadius(TARGET_SELF) + 2
    local f8_local3 = 100
    local f8_local4 = 0
    local f8_local5 = 1.5
    local f8_local6 = 3
    Approach_Act_Flex(f8_arg0, f8_arg1, f8_local0, f8_local1, f8_local2, f8_local3, f8_local4, f8_local5, f8_local6)
    local f8_local7 = 0
    local f8_local8 = 0
    f8_arg1:AddSubGoal(GOAL_COMMON_ComboAttackTunableSpin, 10, 3005, TARGET_ENE_0, 9999, f8_local7, f8_local8, 0, 0)
    f8_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3026, TARGET_ENE_0, 9999, 0, 0)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act06 = function (f9_arg0, f9_arg1, f9_arg2)
    local f9_local0 = 5.8 - f9_arg0:GetMapHitRadius(TARGET_SELF)
    local f9_local1 = 5.8 - f9_arg0:GetMapHitRadius(TARGET_SELF) + 0
    local f9_local2 = 5.8 - f9_arg0:GetMapHitRadius(TARGET_SELF) + 2
    local f9_local3 = 100
    local f9_local4 = 0
    local f9_local5 = 1.5
    local f9_local6 = 3
    Approach_Act_Flex(f9_arg0, f9_arg1, 20, f9_local1, f9_local2, f9_local3, f9_local4, f9_local5, f9_local6)
    local f9_local7 = 0
    local f9_local8 = 0
    f9_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 10, 3210, TARGET_ENE_0, 9999, f9_local7, f9_local8, 0, 0)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act07 = function (f10_arg0, f10_arg1, f10_arg2)
    local f10_local0 = 0
    local f10_local1 = 0
    f10_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 10, 3015, TARGET_ENE_0, 9999, f10_local0, f10_local1, 0, 0):TimingSetTimer(1, 15, AI_TIMING_SET__UPDATE_ACTIVATE)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act08 = function (f11_arg0, f11_arg1, f11_arg2)
    local f11_local0 = 14 - f11_arg0:GetMapHitRadius(TARGET_SELF)
    local f11_local1 = 14 - f11_arg0:GetMapHitRadius(TARGET_SELF) + 0
    local f11_local2 = 14 - f11_arg0:GetMapHitRadius(TARGET_SELF) + 2
    local f11_local3 = 100
    local f11_local4 = 0
    local f11_local5 = 1.5
    local f11_local6 = 3
    if f11_arg0:GetNpcThinkParamID() == 14509008 or f11_arg0:GetNpcThinkParamID() == 14509009 then
        if f11_arg0:GetNumber(2) == 1 then
            Approach_Act_Flex(f11_arg0, f11_arg1, f11_local0, f11_local1, f11_local2, f11_local3, f11_local4, f11_local5, f11_local6)
        end
    else
        Approach_Act_Flex(f11_arg0, f11_arg1, f11_local0, f11_local1, f11_local2, f11_local3, f11_local4, f11_local5, f11_local6)
    end
    local f11_local7 = 3.5 - f11_arg0:GetMapHitRadius(TARGET_SELF)
    local f11_local8 = 5.8 - f11_arg0:GetMapHitRadius(TARGET_SELF)
    local f11_local9 = 0
    local f11_local10 = 0
    if (f11_arg0:GetNpcThinkParamID() == 14509008 or f11_arg0:GetNpcThinkParamID() == 14509009) and f11_arg0:GetNumber(2) == 0 then
        f11_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 10, 3016, TARGET_SELF, 9999, 0, 0, 0, 0)
        f11_arg0:SetNumber(2, 1)
    else
        f11_arg1:AddSubGoal(GOAL_COMMON_ComboTunable_SuccessAngle180, 10, 3016, TARGET_ENE_0, 9999, f11_local9, f11_local10, 0, 0)
        f11_arg1:AddSubGoal(GOAL_COMMON_ComboRepeat, 10, 3006, TARGET_ENE_0, 9999, 0, 0)
        f11_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3020, TARGET_ENE_0, 9999, 0, 0)
    end
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act09 = function (f12_arg0, f12_arg1, f12_arg2)
    local f12_local0 = f12_arg0:GetDist(TARGET_ENE_0)
    local f12_local1 = 8 - f12_arg0:GetMapHitRadius(TARGET_SELF)
    local f12_local2 = 8 - f12_arg0:GetMapHitRadius(TARGET_SELF) + 0
    local f12_local3 = 8 - f12_arg0:GetMapHitRadius(TARGET_SELF) + 2
    local f12_local4 = 100
    local f12_local5 = 0
    local f12_local6 = 1.5
    local f12_local7 = 3
    local f12_local8 = f12_arg0:GetRandam_Int(1, 100)
    local f12_local9 = f12_arg0:GetRandam_Int(1, 100)
    Approach_Act_Flex(f12_arg0, f12_arg1, f12_local1, f12_local2, f12_local3, f12_local4, f12_local5, f12_local6, f12_local7)
    local f12_local10 = 3.5 - f12_arg0:GetMapHitRadius(TARGET_SELF)
    local f12_local11 = 5.8 - f12_arg0:GetMapHitRadius(TARGET_SELF)
    local f12_local12 = 0
    local f12_local13 = 0
    if f12_local0 <= 3 then
        f12_arg1:AddSubGoal(GOAL_COMMON_ComboTunable_SuccessAngle180, 10, 3033, TARGET_ENE_0, 9999, f12_local12, f12_local13, 0, 0)
    else
        f12_arg1:AddSubGoal(GOAL_COMMON_ComboTunable_SuccessAngle180, 10, 3017, TARGET_ENE_0, 9999, f12_local12, f12_local13, 0, 0)
    end
    f12_arg1:AddSubGoal(GOAL_COMMON_ComboRepeat, 10, 3030, TARGET_ENE_0, 3.5 - f12_arg0:GetMapHitRadius(TARGET_SELF), 0, 0)
    if f12_local8 <= 100 then
        f12_arg1:AddSubGoal(GOAL_COMMON_ComboRepeat, 10, 3033, TARGET_ENE_0, 9999, 0, 0)
        f12_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3031, TARGET_ENE_0, 9999, 0, 0)
    else
        f12_arg1:AddSubGoal(GOAL_COMMON_ComboRepeat, 10, 3001, TARGET_ENE_0, 9999, 0, 0)
        f12_arg1:AddSubGoal(GOAL_COMMON_ComboRepeat, 10, 3003, TARGET_ENE_0, 9999, 0, 0)
        f12_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3023, TARGET_ENE_0, 9999, 0, 0)
        f12_arg0:AddObserveArea(0, TARGET_SELF, TARGET_ENE_0, AI_DIR_TYPE_F, 180, 4)
    end
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act10 = function (f13_arg0, f13_arg1, f13_arg2)
    local f13_local0 = f13_arg0:GetDist(TARGET_ENE_0)
    local f13_local1 = 8 - f13_arg0:GetMapHitRadius(TARGET_SELF)
    local f13_local2 = 8 - f13_arg0:GetMapHitRadius(TARGET_SELF) + 0
    local f13_local3 = 8 - f13_arg0:GetMapHitRadius(TARGET_SELF) + 2
    local f13_local4 = 100
    local f13_local5 = 0
    local f13_local6 = 1.5
    local f13_local7 = 3
    local f13_local8 = f13_arg0:GetRandam_Int(1, 100)
    Approach_Act_Flex(f13_arg0, f13_arg1, f13_local1, f13_local2, f13_local3, f13_local4, f13_local5, f13_local6, f13_local7)
    local f13_local9 = 3.5 - f13_arg0:GetMapHitRadius(TARGET_SELF)
    local f13_local10 = 5.8 - f13_arg0:GetMapHitRadius(TARGET_SELF)
    local f13_local11 = 0
    local f13_local12 = 0
    if f13_local0 <= 3 then
        f13_arg1:AddSubGoal(GOAL_COMMON_ComboTunable_SuccessAngle180, 10, 3032, TARGET_ENE_0, 9999, f13_local11, f13_local12, 0, 0)
    else
        f13_arg1:AddSubGoal(GOAL_COMMON_ComboTunable_SuccessAngle180, 10, 3018, TARGET_ENE_0, 9999, f13_local11, f13_local12, 0, 0)
    end
    f13_arg1:AddSubGoal(GOAL_COMMON_ComboRepeat, 10, 3031, TARGET_ENE_0, 4 - f13_arg0:GetMapHitRadius(TARGET_SELF), 0, 0)
    if f13_local8 <= 100 then
        f13_arg1:AddSubGoal(GOAL_COMMON_ComboRepeat, 10, 3034, TARGET_ENE_0, 9999, 0, 0)
        f13_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3005, TARGET_ENE_0, 9999, 0, 0)
    else
        f13_arg1:AddSubGoal(GOAL_COMMON_ComboRepeat, 10, 3000, TARGET_ENE_0, 4 - f13_arg0:GetMapHitRadius(TARGET_SELF), 0, 0)
        f13_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3021, TARGET_ENE_0, 9999, 0, 0)
    end
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act11 = function (f14_arg0, f14_arg1, f14_arg2)
    local f14_local0 = 4.8 - f14_arg0:GetMapHitRadius(TARGET_SELF)
    local f14_local1 = 4.8 - f14_arg0:GetMapHitRadius(TARGET_SELF) + 0
    local f14_local2 = 4.8 - f14_arg0:GetMapHitRadius(TARGET_SELF) + 2
    local f14_local3 = 100
    local f14_local4 = 0
    local f14_local5 = 1.5
    local f14_local6 = 3
    Approach_Act_Flex(f14_arg0, f14_arg1, f14_local0, f14_local1, f14_local2, f14_local3, f14_local4, f14_local5, f14_local6)
    local f14_local7 = 0
    local f14_local8 = 0
    f14_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 10, 3009, TARGET_ENE_0, 9999, f14_local7, f14_local8, 0, 0)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act12 = function (f15_arg0, f15_arg1, f15_arg2)
    local f15_local0 = f15_arg0:GetRandam_Int(1, 100)
    local f15_local1 = 0
    local f15_local2 = 0
    if f15_local0 <= 50 then
        f15_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 10, 3021, TARGET_ENE_0, 9999, f15_local1, f15_local2, 0, 0)
    else
        f15_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 10, 3023, TARGET_ENE_0, 9999, f15_local1, f15_local2, 0, 0)
    end
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act13 = function (f16_arg0, f16_arg1, f16_arg2)
    local f16_local0 = 14 - f16_arg0:GetMapHitRadius(TARGET_SELF)
    local f16_local1 = 14 - f16_arg0:GetMapHitRadius(TARGET_SELF) + 2
    local f16_local2 = 14 - f16_arg0:GetMapHitRadius(TARGET_SELF) + 2
    local f16_local3 = 100
    local f16_local4 = 0
    local f16_local5 = 1.5
    local f16_local6 = 3
    Approach_Act_Flex(f16_arg0, f16_arg1, f16_local0, f16_local1, f16_local2, f16_local3, f16_local4, f16_local5, f16_local6)
    local f16_local7 = 3.5 - f16_arg0:GetMapHitRadius(TARGET_SELF)
    local f16_local8 = 5.8 - f16_arg0:GetMapHitRadius(TARGET_SELF)
    local f16_local9 = 0
    local f16_local10 = 0
    f16_arg1:AddSubGoal(GOAL_COMMON_ComboTunable_SuccessAngle180, 10, 3016, TARGET_ENE_0, 9999, f16_local9, f16_local10, 0, 0)
    f16_arg1:AddSubGoal(GOAL_COMMON_ComboRepeat, 10, 3006, TARGET_ENE_0, 9999, f16_local9, f16_local10, 0, 0)
    f16_arg1:AddSubGoal(GOAL_COMMON_ComboRepeat, 10, 3001, TARGET_ENE_0, 9999, 0, 0)
    f16_arg1:AddSubGoal(GOAL_COMMON_ComboRepeat, 10, 3003, TARGET_ENE_0, 9999, 0, 0)
    f16_arg1:AddSubGoal(GOAL_COMMON_ComboRepeat, 10, 3009, TARGET_ENE_0, 9999, 0, 0)
    f16_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3022, TARGET_ENE_0, 9999, 0, 0)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act14 = function (f17_arg0, f17_arg1, f17_arg2)
    local f17_local0 = 8 - f17_arg0:GetMapHitRadius(TARGET_SELF)
    local f17_local1 = 8 - f17_arg0:GetMapHitRadius(TARGET_SELF) + 0
    local f17_local2 = 8 - f17_arg0:GetMapHitRadius(TARGET_SELF) + 2
    local f17_local3 = 100
    local f17_local4 = 0
    local f17_local5 = 1.5
    local f17_local6 = 3
    Approach_Act_Flex(f17_arg0, f17_arg1, f17_local0, f17_local1, f17_local2, f17_local3, f17_local4, f17_local5, f17_local6)
    local f17_local7 = 0
    local f17_local8 = 0
    f17_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 10, 3025, TARGET_ENE_0, 9999, f17_local7, f17_local8, 0, 0)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act16 = function (f18_arg0, f18_arg1, f18_arg2)
    local f18_local0 = f18_arg0:GetDist(TARGET_ENE_0)
    local f18_local1 = 8 - f18_arg0:GetMapHitRadius(TARGET_SELF)
    local f18_local2 = 8 - f18_arg0:GetMapHitRadius(TARGET_SELF) + 0
    local f18_local3 = 8 - f18_arg0:GetMapHitRadius(TARGET_SELF) + 2
    local f18_local4 = 100
    local f18_local5 = 0
    local f18_local6 = 1.5
    local f18_local7 = 3
    local f18_local8 = f18_arg0:GetRandam_Int(1, 100)
    local f18_local9 = f18_arg0:GetRandam_Int(1, 100)
    Approach_Act_Flex(f18_arg0, f18_arg1, f18_local1, f18_local2, f18_local3, f18_local4, f18_local5, f18_local6, f18_local7)
    local f18_local10 = 3.5 - f18_arg0:GetMapHitRadius(TARGET_SELF)
    local f18_local11 = 5.8 - f18_arg0:GetMapHitRadius(TARGET_SELF)
    local f18_local12 = 0
    local f18_local13 = 0
    f18_arg1:AddSubGoal(GOAL_COMMON_ComboTunable_SuccessAngle180, 10, 3033, TARGET_ENE_0, 9999, f18_local12, f18_local13, 0, 0)
    f18_arg1:AddSubGoal(GOAL_COMMON_ComboRepeat, 10, 3030, TARGET_ENE_0, 3.5 - f18_arg0:GetMapHitRadius(TARGET_SELF), 0, 0)
    f18_arg1:AddSubGoal(GOAL_COMMON_ComboRepeat, 10, 3001, TARGET_ENE_0, 9999, 0, 0)
    f18_arg1:AddSubGoal(GOAL_COMMON_ComboRepeat, 10, 3003, TARGET_ENE_0, 9999, 0, 0)
    f18_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3023, TARGET_ENE_0, 9999, 0, 0)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act17 = function (f19_arg0, f19_arg1, f19_arg2)
    local f19_local0 = f19_arg0:GetDist(TARGET_ENE_0)
    local f19_local1 = 8 - f19_arg0:GetMapHitRadius(TARGET_SELF)
    local f19_local2 = 8 - f19_arg0:GetMapHitRadius(TARGET_SELF) + 0
    local f19_local3 = 8 - f19_arg0:GetMapHitRadius(TARGET_SELF) + 2
    local f19_local4 = 100
    local f19_local5 = 0
    local f19_local6 = 1.5
    local f19_local7 = 3
    local f19_local8 = f19_arg0:GetRandam_Int(1, 100)
    Approach_Act_Flex(f19_arg0, f19_arg1, f19_local1, f19_local2, f19_local3, f19_local4, f19_local5, f19_local6, f19_local7)
    local f19_local9 = 3.5 - f19_arg0:GetMapHitRadius(TARGET_SELF)
    local f19_local10 = 5.8 - f19_arg0:GetMapHitRadius(TARGET_SELF)
    local f19_local11 = 0
    local f19_local12 = 0
    f19_arg1:AddSubGoal(GOAL_COMMON_ComboTunable_SuccessAngle180, 10, 3032, TARGET_ENE_0, 9999, f19_local11, f19_local12, 0, 0)
    f19_arg1:AddSubGoal(GOAL_COMMON_ComboRepeat, 10, 3031, TARGET_ENE_0, 4 - f19_arg0:GetMapHitRadius(TARGET_SELF), 0, 0)
    f19_arg1:AddSubGoal(GOAL_COMMON_ComboRepeat, 10, 3000, TARGET_ENE_0, 4 - f19_arg0:GetMapHitRadius(TARGET_SELF), 0, 0)
    f19_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3021, TARGET_ENE_0, 9999, 0, 0)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act18 = function (f20_arg0, f20_arg1, f20_arg2)
    local f20_local0 = 0
    local f20_local1 = 0
    f20_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 10, 20002, TARGET_ENE_0, 9999, f20_local0, f20_local1, 0, 0)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act19 = function (f21_arg0, f21_arg1, f21_arg2)
    local f21_local0 = 0
    local f21_local1 = 0
    f21_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 10, 3040, TARGET_ENE_0, 9999, f21_local0, f21_local1, 0, 0)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act30 = function (f22_arg0, f22_arg1, f22_arg2)
    local f22_local0 = f22_arg0:GetDist(TARGET_ENE_0)
    local f22_local1 = 8 - f22_arg0:GetMapHitRadius(TARGET_SELF)
    local f22_local2 = 8 - f22_arg0:GetMapHitRadius(TARGET_SELF) + 0
    local f22_local3 = 8 - f22_arg0:GetMapHitRadius(TARGET_SELF) + 2
    local f22_local4 = 100
    local f22_local5 = 0
    local f22_local6 = 1.5
    local f22_local7 = 3
    Approach_Act_Flex(f22_arg0, f22_arg1, f22_local1, f22_local2, f22_local3, f22_local4, f22_local5, f22_local6, f22_local7)
    local f22_local8 = 0
    local f22_local9 = 0
    f22_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 10, 3010, TARGET_ENE_0, 9999, f22_local8, f22_local9, 0, 0)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act31 = function (f23_arg0, f23_arg1, f23_arg2)
    local f23_local0 = 0
    local f23_local1 = 0
    local f23_local2 = 3220
    if f23_arg0:IsEventFlag(0) == true then
        f23_local2 = 3200
    end
    f23_arg1:AddSubGoal(GOAL_COMMON_AttackImmediateAction, 10, f23_local2, TARGET_ENE_0, 9999, f23_local0, f23_local1, 0, 0)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act40 = function (f24_arg0, f24_arg1, f24_arg2)
    local f24_local0 = 5.9 - f24_arg0:GetMapHitRadius(TARGET_SELF)
    local f24_local1 = 5.9 - f24_arg0:GetMapHitRadius(TARGET_SELF) + 0
    local f24_local2 = 5.9 - f24_arg0:GetMapHitRadius(TARGET_SELF) + 2
    local f24_local3 = 100
    local f24_local4 = 0
    local f24_local5 = 1.5
    local f24_local6 = 3
    local f24_local7 = f24_arg0:GetRandam_Int(1, 100)
    Approach_Act_Flex(f24_arg0, f24_arg1, f24_local0, f24_local1, f24_local2, f24_local3, f24_local4, f24_local5, f24_local6)
    local f24_local8 = 3.5 - f24_arg0:GetMapHitRadius(TARGET_SELF)
    local f24_local9 = 5.8 - f24_arg0:GetMapHitRadius(TARGET_SELF)
    f24_arg1:AddSubGoal(GOAL_COMMON_ComboAttackTunableSpin, 10, 3003, TARGET_ENE_0, f24_local8, 0, 0, 0, 0)
    f24_arg1:AddSubGoal(GOAL_COMMON_ComboRepeat, 10, 3009, TARGET_ENE_0, f24_local9, 0, 0)
    f24_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3021, TARGET_ENE_0, 9999, 0, 0)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act41 = function (f25_arg0, f25_arg1, f25_arg2)
    local f25_local0 = 4.6 - f25_arg0:GetMapHitRadius(TARGET_SELF)
    local f25_local1 = 4.6 - f25_arg0:GetMapHitRadius(TARGET_SELF) + 0
    local f25_local2 = 4.6 - f25_arg0:GetMapHitRadius(TARGET_SELF) + 2
    local f25_local3 = 100
    local f25_local4 = 0
    local f25_local5 = 1.5
    local f25_local6 = 3
    local f25_local7 = f25_arg0:GetRandam_Int(1, 100)
    Approach_Act_Flex(f25_arg0, f25_arg1, f25_local0, f25_local1, f25_local2, f25_local3, f25_local4, f25_local5, f25_local6)
    local f25_local8 = 3.5 - f25_arg0:GetMapHitRadius(TARGET_SELF)
    local f25_local9 = 5.8 - f25_arg0:GetMapHitRadius(TARGET_SELF)
    f25_arg1:AddSubGoal(GOAL_COMMON_ComboAttackTunableSpin, 10, 3004, TARGET_ENE_0, f25_local8, 0, 0, 0, 0)
    f25_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3020, TARGET_ENE_0, 9999, 0, 0)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act42 = function (f26_arg0, f26_arg1, f26_arg2)
    local f26_local0 = 14 - f26_arg0:GetMapHitRadius(TARGET_SELF)
    local f26_local1 = 14 - f26_arg0:GetMapHitRadius(TARGET_SELF) + 0
    local f26_local2 = 14 - f26_arg0:GetMapHitRadius(TARGET_SELF) + 2
    local f26_local3 = 100
    local f26_local4 = 0
    local f26_local5 = 1.5
    local f26_local6 = 3
    local f26_local7 = f26_arg0:GetRandam_Int(1, 100)
    Approach_Act_Flex(f26_arg0, f26_arg1, f26_local0, f26_local1, f26_local2, f26_local3, f26_local4, f26_local5, f26_local6)
    local f26_local8 = 3.5 - f26_arg0:GetMapHitRadius(TARGET_SELF)
    local f26_local9 = 5.8 - f26_arg0:GetMapHitRadius(TARGET_SELF)
    f26_arg1:AddSubGoal(GOAL_COMMON_ComboAttackTunableSpin, 10, 3016, TARGET_ENE_0, f26_local8, 0, 0, 0, 0)
    f26_arg1:AddSubGoal(GOAL_COMMON_ComboRepeat, 10, 3006, TARGET_ENE_0, f26_local9, 0, 0)
    f26_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3020, TARGET_ENE_0, 9999, 0, 0)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act43 = function (f27_arg0, f27_arg1, f27_arg2)
    local f27_local0 = 8 - f27_arg0:GetMapHitRadius(TARGET_SELF)
    local f27_local1 = 8 - f27_arg0:GetMapHitRadius(TARGET_SELF) + 0
    local f27_local2 = 8 - f27_arg0:GetMapHitRadius(TARGET_SELF) + 2
    local f27_local3 = 100
    local f27_local4 = 0
    local f27_local5 = 1.5
    local f27_local6 = 3
    local f27_local7 = f27_arg0:GetRandam_Int(1, 100)
    Approach_Act_Flex(f27_arg0, f27_arg1, f27_local0, f27_local1, f27_local2, f27_local3, f27_local4, f27_local5, f27_local6)
    local f27_local8 = 3.5 - f27_arg0:GetMapHitRadius(TARGET_SELF)
    local f27_local9 = 5.8 - f27_arg0:GetMapHitRadius(TARGET_SELF)
    f27_arg1:AddSubGoal(GOAL_COMMON_ComboTunable_SuccessAngle180, 10, 3017, TARGET_ENE_0, f27_local8, 0, 0, 0, 0)
    f27_arg1:AddSubGoal(GOAL_COMMON_ComboRepeat, 10, 3007, TARGET_ENE_0, f27_local9, 0, 0)
    f27_arg1:AddSubGoal(GOAL_COMMON_ComboRepeat, 10, 3001, TARGET_ENE_0, f27_local9, 0, 0)
    f27_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3003, TARGET_ENE_0, 9999, 0, 0)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act44 = function (f28_arg0, f28_arg1, f28_arg2)
    local f28_local0 = 8 - f28_arg0:GetMapHitRadius(TARGET_SELF)
    local f28_local1 = 8 - f28_arg0:GetMapHitRadius(TARGET_SELF) + 0
    local f28_local2 = 8 - f28_arg0:GetMapHitRadius(TARGET_SELF) + 2
    local f28_local3 = 100
    local f28_local4 = 0
    local f28_local5 = 1.5
    local f28_local6 = 3
    local f28_local7 = f28_arg0:GetRandam_Int(1, 100)
    Approach_Act_Flex(f28_arg0, f28_arg1, f28_local0, f28_local1, f28_local2, f28_local3, f28_local4, f28_local5, f28_local6)
    local f28_local8 = 3.5 - f28_arg0:GetMapHitRadius(TARGET_SELF)
    local f28_local9 = 5.8 - f28_arg0:GetMapHitRadius(TARGET_SELF)
    f28_arg1:AddSubGoal(GOAL_COMMON_ComboTunable_SuccessAngle180, 10, 3018, TARGET_ENE_0, f28_local8, 0, 0, 0, 0)
    f28_arg1:AddSubGoal(GOAL_COMMON_ComboRepeat, 10, 3008, TARGET_ENE_0, f28_local9, 0, 0)
    f28_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3021, TARGET_ENE_0, 9999, 0, 0)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act21 = function (f29_arg0, f29_arg1, f29_arg2)
    local f29_local0 = 3
    local f29_local1 = 45
    f29_arg1:AddSubGoal(GOAL_COMMON_Turn, f29_local0, TARGET_ENE_0, f29_local1, -1, GOAL_RESULT_Success, true)
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
    
end

Goal.Act22 = function (f30_arg0, f30_arg1, f30_arg2)
    local f30_local0 = 3
    local f30_local1 = 0
    local f30_local2 = 5202
    if SpaceCheck(f30_arg0, f30_arg1, -45, 2) == true then
        if SpaceCheck(f30_arg0, f30_arg1, 45, 2) == true then
            if f30_arg0:IsInsideTarget(TARGET_ENE_0, AI_DIR_TYPE_R, 180) then
                f30_local2 = 5202
            else
                f30_local2 = 5203
            end
        else
            f30_local2 = 5202
        end
    elseif SpaceCheck(f30_arg0, f30_arg1, 45, 2) == true then
        f30_local2 = 5203
    else
    end
    f30_arg1:AddSubGoal(GOAL_COMMON_SpinStep, f30_local0, f30_local2, TARGET_ENE_0, f30_local1, AI_DIR_TYPE_R, 0)
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
    
end

Goal.Act23 = function (f31_arg0, f31_arg1, f31_arg2)
    local f31_local0 = f31_arg0:GetDist(TARGET_ENE_0)
    local f31_local1 = f31_arg0:GetSp(TARGET_SELF)
    local f31_local2 = 20
    local f31_local3 = f31_arg0:GetRandam_Int(1, 100)
    local f31_local4 = -1
    local f31_local5 = 0
    if SpaceCheck(f31_arg0, f31_arg1, -90, 1) == true then
        if SpaceCheck(f31_arg0, f31_arg1, 90, 1) == true then
            if f31_arg0:IsInsideTargetEx(TARGET_ENE_0, TARGET_SELF, AI_DIR_TYPE_R, 180) then
                f31_local5 = 1
            else
                f31_local5 = 0
            end
        else
            f31_local5 = 0
        end
    elseif SpaceCheck(f31_arg0, f31_arg1, 90, 1) == true then
        f31_local5 = 1
    else
    end
    local f31_local6 = 3
    local f31_local7 = f31_arg0:GetRandam_Int(30, 45)
    f31_arg0:SetNumber(10, f31_local5)
    f31_arg1:AddSubGoal(GOAL_COMMON_SidewayMove, f31_local6, TARGET_ENE_0, f31_local5, f31_local7, true, true, f31_local4):TimingSetTimer(2, 4, UPDATE_SUCCESS)
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
    
end

Goal.Act24 = function (f32_arg0, f32_arg1, f32_arg2)
    local f32_local0 = f32_arg0:GetDist(TARGET_ENE_0)
    local f32_local1 = 3
    local f32_local2 = 0
    local f32_local3 = 5201
    local f32_local4 = f32_arg0:GetRandam_Int(1, 100)
    if SpaceCheck(f32_arg0, f32_arg1, 180, 2) ~= true or SpaceCheck(f32_arg0, f32_arg1, 180, 4) ~= true or f32_local0 > 4 then
    else
        f32_local3 = 5211
        if false then
        else
        end
    end
    if f32_local4 <= 50 then
        f32_local3 = 5211
    else
        f32_local3 = 5201
    end
    f32_arg1:AddSubGoal(GOAL_COMMON_SpinStep, f32_local1, f32_local3, TARGET_ENE_0, f32_local2, AI_DIR_TYPE_B, 0)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act25 = function (f33_arg0, f33_arg1, f33_arg2)
    local f33_local0 = f33_arg0:GetRandam_Float(2, 4)
    local f33_local1 = f33_arg0:GetRandam_Float(1, 3)
    local f33_local2 = f33_arg0:GetDist(TARGET_ENE_0)
    local f33_local3 = -1
    f33_arg1:AddSubGoal(GOAL_COMMON_LeaveTarget, f33_local0, TARGET_ENE_0, f33_local1, TARGET_ENE_0, true, f33_local3)
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
    
end

Goal.Act26 = function (f34_arg0, f34_arg1, f34_arg2)
    f34_arg1:AddSubGoal(GOAL_COMMON_Wait, 0.5, TARGET_SELF, 0, 0, 0)
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
    
end

Goal.Act27 = function (f35_arg0, f35_arg1, f35_arg2)
    local f35_local0 = f35_arg0:GetRandam_Int(1, 100)
    if YousumiAct_SubGoal(f35_arg0, f35_arg1, true, 60, 30) == false then
        GetWellSpace_Odds = 0
        return GetWellSpace_Odds
    end
    local f35_local1 = 0
    local f35_local2 = SpaceCheck_SidewayMove(f35_arg0, f35_arg1, 1)
    if f35_local2 == 0 then
        f35_local1 = 0
    elseif f35_local2 == 1 then
        f35_local1 = 1
    elseif f35_local2 == 2 then
        if f35_local0 <= 50 then
            f35_local1 = 0
        else
            f35_local1 = 1
        end
    else
        f35_arg1:AddSubGoal(GOAL_COMMON_Wait, 0.5, TARGET_SELF, 0, 0, 0)
        GetWellSpace_Odds = 0
        return GetWellSpace_Odds
    end
    f35_arg0:SetNumber(10, f35_local1)
    f35_arg1:AddSubGoal(GOAL_COMMON_SidewayMove, 3, TARGET_ENE_0, f35_local1, f35_arg0:GetRandam_Int(30, 45), true, true, -1)
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
    
end

Goal.Act28 = function (f36_arg0, f36_arg1, f36_arg2)
    local f36_local0 = f36_arg0:GetDist(TARGET_ENE_0)
    local f36_local1 = 1.5
    local f36_local2 = 1.5
    local f36_local3 = f36_arg0:GetRandam_Int(30, 45)
    local f36_local4 = -1
    local f36_local5 = f36_arg0:GetRandam_Int(0, 1)
    if f36_local0 <= 3 then
        f36_arg1:AddSubGoal(GOAL_COMMON_SidewayMove, f36_local1, TARGET_ENE_0, f36_local5, f36_local3, true, true, f36_local4)
    elseif f36_local0 <= 8 then
        f36_arg1:AddSubGoal(GOAL_COMMON_ApproachTarget, f36_local2, TARGET_ENE_0, 3, TARGET_SELF, true, -1)
    else
        f36_arg1:AddSubGoal(GOAL_COMMON_ApproachTarget, f36_local2, TARGET_ENE_0, 8, TARGET_SELF, false, -1)
    end
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
    
end

Goal.Interrupt = function (f37_arg0, f37_arg1, f37_arg2)
    local f37_local0 = f37_arg1:GetSpecialEffectActivateInterruptType(0)
    local f37_local1 = f37_arg1:GetDist(TARGET_ENE_0)
    local f37_local2 = f37_arg1:GetRandam_Int(1, 100)
    if f37_arg1:IsLadderAct(TARGET_SELF) then
        return false
    end
    if not f37_arg1:HasSpecialEffectId(TARGET_SELF, 200004) then
        return false
    end
    if f37_arg1:IsInterupt(INTERUPT_ParryTiming) then
        return Common_Parry(f37_arg1, f37_arg2, 50, 0)
    end
    if f37_arg1:IsInterupt(INTERUPT_Damaged) then
        return f37_arg0.Damaged(f37_arg1, f37_arg2)
    end
    if f37_arg1:IsInterupt(INTERUPT_ShootImpact) and f37_arg0.ShootReaction(f37_arg1, f37_arg2) then
        return true
    end
    if f37_arg1:IsInterupt(INTERUPT_ActivateSpecialEffect) then
    end
    if f37_arg1:IsInterupt(INTERUPT_Outside_ObserveArea) and f37_arg1:GetAreaObserveSlot(AI_AREAOBSERVE_INTERRUPT__OUTSIDE, 0) then
        f37_arg2:ClearSubGoal()
        f37_arg2:AddSubGoal(GOAL_COMMON_EndureAttack, 1, 3025, TARGET_ENE_0, 9999, 0)
        f37_arg1:DeleteObserve(0)
        return true
    end
    return false
    
end

Goal.Damaged = function (f38_arg0, f38_arg1, f38_arg2)
    if SpaceCheck(f38_arg0, f38_arg1, 180, 2) == false then
        f38_arg1:ClearSubGoal()
        f38_arg1:AddSubGoal(GOAL_COMMON_SpinStep, StepLife, 5201, TARGET_ENE_0, 0, AI_DIR_TYPE_B, 0)
        return true
    end
    return false
    
end

Goal.ShootReaction = function (f39_arg0, f39_arg1)
    f39_arg1:ClearSubGoal()
    f39_arg1:AddSubGoal(GOAL_COMMON_EndureAttack, 0.1, 3100, TARGET_ENE_0, 9999, 0)
    return true
    
end

Goal.Kengeki_Activate = function (f40_arg0, f40_arg1, f40_arg2, f40_arg3)
    local f40_local0 = ReturnKengekiSpecialEffect(f40_arg1)
    if f40_local0 == 0 then
        return false
    end
    local f40_local1 = {}
    local f40_local2 = {}
    local f40_local3 = {}
    Common_Clear_Param(f40_local1, f40_local2, f40_local3)
    local f40_local4 = f40_arg1:GetDist(TARGET_ENE_0)
    local f40_local5 = f40_arg1:GetSp(TARGET_SELF)
    if f40_local5 <= 0 then
        f40_local1[50] = 100
    elseif f40_local0 == 200200 then
        if f40_local4 >= 2.5 then
            f40_local1[50] = 100
        elseif f40_local4 <= 0.2 then
            f40_local1[50] = 100
        else
            f40_local1[1] = 100
            f40_local1[2] = 100
            f40_local1[3] = 100
        end
    elseif f40_local0 == 200201 then
        if f40_local4 >= 2.5 then
            f40_local1[50] = 100
        elseif f40_local4 <= 0.2 then
            f40_local1[50] = 100
        else
            f40_local1[6] = 100
            f40_local1[7] = 100
            f40_local1[8] = 100
        end
    elseif f40_local0 == 200215 then
        if f40_local4 >= 2.5 then
            f40_local1[50] = 100
        elseif f40_local4 <= 0.2 then
            f40_local1[50] = 100
        elseif not f40_arg1:IsFinishTimer(0) then
            f40_local1[11] = 100
        else
            f40_local1[6] = 100
            f40_local1[7] = 100
            f40_local1[50] = 100
        end
        if f40_arg1:IsFinishTimer(0) then
            f40_arg1:SetTimer(0, 1)
        end
    elseif f40_local0 == 200216 then
        if f40_local4 >= 2.5 then
            f40_local1[50] = 100
        elseif f40_local4 <= 0.2 then
            f40_local1[50] = 100
        elseif not f40_arg1:IsFinishTimer(0) then
            f40_local1[11] = 100
        else
            f40_local1[1] = 100
            f40_local1[2] = 100
            f40_local1[12] = 100
            f40_local1[50] = 100
        end
        if f40_arg1:IsFinishTimer(0) then
            f40_arg1:SetTimer(0, 1)
        end
    elseif f40_local0 == 200210 then
        if f40_local4 >= 2.5 then
            f40_local1[50] = 100
        elseif f40_local4 <= 0.2 then
            f40_local1[50] = 100
        else
            f40_local1[11] = 100
        end
    elseif f40_local0 == 200211 then
        if f40_local4 >= 2.5 then
            f40_local1[50] = 100
        elseif f40_local4 <= 0.2 then
            f40_local1[50] = 100
        else
            f40_local1[12] = 100
        end
    end
    f40_local2[1] = REGIST_FUNC(f40_arg1, f40_arg2, f40_arg0.Kengeki01)
    f40_local2[2] = REGIST_FUNC(f40_arg1, f40_arg2, f40_arg0.Kengeki02)
    f40_local2[3] = REGIST_FUNC(f40_arg1, f40_arg2, f40_arg0.Kengeki03)
    f40_local2[6] = REGIST_FUNC(f40_arg1, f40_arg2, f40_arg0.Kengeki06)
    f40_local2[7] = REGIST_FUNC(f40_arg1, f40_arg2, f40_arg0.Kengeki07)
    f40_local2[8] = REGIST_FUNC(f40_arg1, f40_arg2, f40_arg0.Kengeki08)
    f40_local2[11] = REGIST_FUNC(f40_arg1, f40_arg2, f40_arg0.Kengeki11)
    f40_local2[12] = REGIST_FUNC(f40_arg1, f40_arg2, f40_arg0.Kengeki12)
    f40_local2[50] = REGIST_FUNC(f40_arg1, f40_arg2, f40_arg0.NoAction)
    local f40_local6 = REGIST_FUNC(f40_arg1, f40_arg2, f40_arg0.ActAfter_AdjustSpace)
    return Common_Kengeki_Activate(f40_arg1, f40_arg2, f40_local1, f40_local2, f40_local6, f40_local3)
    
end

Goal.Kengeki01 = function (f41_arg0, f41_arg1, f41_arg2)
    f41_arg1:ClearSubGoal()
    f41_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 1, 3060, TARGET_ENE_0, 9999, 0, 0)
    
end

Goal.Kengeki02 = function (f42_arg0, f42_arg1, f42_arg2)
    f42_arg1:ClearSubGoal()
    f42_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 3, 3061, TARGET_ENE_0, 9999, 0, 0)
    
end

Goal.Kengeki03 = function (f43_arg0, f43_arg1, f43_arg2)
    f43_arg1:ClearSubGoal()
    f43_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 3, 3062, TARGET_ENE_0, 9999, 0, 0)
    
end

Goal.Kengeki06 = function (f44_arg0, f44_arg1, f44_arg2)
    f44_arg1:ClearSubGoal()
    f44_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 1, 3065, TARGET_ENE_0, 9999, 0, 0)
    
end

Goal.Kengeki07 = function (f45_arg0, f45_arg1, f45_arg2)
    f45_arg1:ClearSubGoal()
    f45_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 3, 3066, TARGET_ENE_0, 9999, 0, 0)
    
end

Goal.Kengeki08 = function (f46_arg0, f46_arg1, f46_arg2)
    f46_arg1:ClearSubGoal()
    f46_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 3, 3067, TARGET_ENE_0, 9999, 0, 0)
    
end

Goal.Kengeki11 = function (f47_arg0, f47_arg1, f47_arg2)
    f47_arg1:ClearSubGoal()
    f47_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 3, 3070, TARGET_ENE_0, 9999, 0, 0)
    
end

Goal.Kengeki12 = function (f48_arg0, f48_arg1, f48_arg2)
    f48_arg1:ClearSubGoal()
    f48_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 3, 3071, TARGET_ENE_0, 9999, 0, 0)
    
end

Goal.NoAction = function (f49_arg0, f49_arg1, f49_arg2)
    return -1
    
end

Goal.ActAfter_AdjustSpace = function (f50_arg0, f50_arg1, f50_arg2)
    
end

Goal.Update = function (f51_arg0, f51_arg1, f51_arg2)
    return Update_Default_NoSubGoal(f51_arg0, f51_arg1, f51_arg2)
    
end

Goal.Terminate = function (f52_arg0, f52_arg1, f52_arg2)
    
end


