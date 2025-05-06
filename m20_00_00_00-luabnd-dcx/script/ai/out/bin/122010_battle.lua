RegisterTableGoal(GOAL_Terakisozako_bojutsu_122010_Battle, "GOAL_Terakisozako_bojutsu_122010_Battle")
REGISTER_GOAL_NO_UPDATE(GOAL_Terakisozako_bojutsu_122010_Battle, true)

Goal.Initialize = function (f1_arg0, f1_arg1, f1_arg2, f1_arg3)
    
end

Goal.Activate = function (f2_arg0, f2_arg1, f2_arg2)
    Init_Pseudo_Global(f2_arg1, f2_arg2)
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
    local f2_local9 = f2_arg1:GetRandam_Int(4, 6)
    f2_arg1:DeleteObserve(0)
    f2_arg1:AddObserveSpecialEffectAttribute(TARGET_ENE_0, 109970)
    f2_arg1:AddObserveSpecialEffectAttribute(TARGET_SELF, 3122100)
    f2_arg1:AddObserveSpecialEffectAttribute(TARGET_ENE_0, 3122101)
    Set_ConsecutiveGuardCount_Interrupt(f2_arg1)
    if f2_arg0.Kengeki_Activate(f2_arg0, f2_arg1, f2_arg2) then
        return
    end
    if Common_ActivateAct(f2_arg1, f2_arg2) then
    elseif f2_arg1:GetNumber(7) == 0 and f2_arg1:HasSpecialEffectId(TARGET_SELF, 5020) then
        f2_local0[45] = 10
    elseif f2_local7 ~= POSSIBLE_ATTACK then
        if f2_local6 == 1 and f2_arg1:GetTeamOrder(ORDER_TYPE_Role) == ROLE_TYPE_Kankyaku then
            f2_local0[27] = 100
        elseif f2_local6 == 1 and f2_arg1:GetTeamOrder(ORDER_TYPE_Role) == ROLE_TYPE_Torimaki then
            f2_local0[27] = 100
        elseif f2_local7 == UNREACH_ATTACK then
            f2_local0[27] = 100
        elseif f2_local7 == REACH_ATTACK_TARGET_HIGH_POSITION then
            f2_local0[1] = 100
            f2_local0[7] = 100
            f2_local0[27] = 100
        elseif f2_local7 == REACH_ATTACK_TARGET_LOW_POSITION then
            f2_local0[1] = 100
            f2_local0[7] = 100
            f2_local0[27] = 100
        else
            f2_local0[27] = 100
        end
    elseif f2_local6 == 1 and f2_arg1:GetTeamOrder(ORDER_TYPE_Role) == ROLE_TYPE_Kankyaku then
        KankyakuAct(f2_arg1, f2_arg2)
    elseif f2_local6 == 1 and f2_arg1:GetTeamOrder(ORDER_TYPE_Role) == ROLE_TYPE_Torimaki then
        f2_local0[28] = 100
        f2_local0[45] = 10
    elseif f2_arg1:IsInsideTarget(TARGET_ENE_0, AI_DIR_TYPE_B, 90) then
        f2_local0[21] = 100
    else
        if f2_arg1:GetNumber(0) >= 20 then
            f2_arg1:SetTimer(2, f2_local9)
            f2_arg1:SetNumber(0, 0)
        end
        if f2_arg1:IsFinishTimer(2) == true then
            if f2_local5 >= 8 then
                if f2_arg1:IsFinishTimer(0) == true then
                    f2_local0[1] = 100
                    f2_local0[2] = 0
                    f2_local0[4] = 500
                    f2_local0[5] = 0
                    f2_local0[6] = 300
                    f2_local0[7] = 300
                    f2_local0[23] = 100
                    f2_local0[24] = 0
                    f2_local0[28] = 50
                    if f2_arg1:GetNumber(0) >= 12 then
                        f2_local0[7] = 600
                    end
                else
                    f2_local0[23] = 100
                end
            elseif f2_local5 >= 5 then
                if f2_arg1:IsFinishTimer(0) == true then
                    f2_local0[1] = 100
                    f2_local0[2] = 0
                    f2_local0[4] = 400
                    f2_local0[5] = 0
                    f2_local0[6] = 200
                    f2_local0[7] = 100
                    f2_local0[23] = 100
                    f2_local0[24] = 0
                    f2_local0[28] = 50
                    if f2_arg1:GetNumber(0) >= 12 then
                        f2_local0[7] = 500
                    end
                else
                    f2_local0[23] = 100
                end
            elseif f2_local5 > 3 then
                f2_local0[1] = 200
                f2_local0[2] = 100
                f2_local0[5] = 0
                f2_local0[23] = 0
                f2_local0[24] = 0
            elseif f2_local5 > 1.5 then
                f2_local0[1] = 100
                f2_local0[2] = 100
                f2_local0[4] = 0
                f2_local0[5] = 100
                f2_local0[23] = 0
                f2_local0[24] = 10
            else
                f2_local0[1] = 0
                f2_local0[2] = 100
                f2_local0[3] = 0
                f2_local0[4] = 0
                f2_local0[5] = 100
                f2_local0[23] = 0
                f2_local0[24] = 30
            end
        elseif f2_local5 >= 7 then
            f2_local0[23] = 100
            if f2_arg1:IsFinishTimer(0) == true then
                f2_local0[28] = 100
            end
        elseif f2_local5 >= 5 then
            f2_local0[23] = 100
            if f2_arg1:IsFinishTimer(0) == true then
                f2_local0[28] = 100
            end
        elseif f2_local5 > 3 then
            f2_local0[23] = 100
            f2_local0[24] = 10
            f2_local0[25] = 100
        elseif f2_local5 > 2 then
            f2_local0[2] = 100
            f2_local0[5] = 0
            f2_local0[23] = 50
            f2_local0[24] = 50
            f2_local0[25] = 100
        else
            f2_local0[2] = 100
            f2_local0[5] = 100
            f2_local0[23] = 0
            f2_local0[24] = 100
            f2_local0[25] = 100
        end
    end
    if 2.8 - f2_arg1:GetMapHitRadius(TARGET_SELF) < f2_local5 then
        f2_local0[2] = 0
    end
    if 2.4 - f2_arg1:GetMapHitRadius(TARGET_SELF) < f2_local5 then
        f2_local0[5] = 0
    end
    if f2_local5 < 5.5 then
        f2_local0[7] = 0
    end
    if f2_arg1:IsFinishTimer(0) == false or f2_arg1:IsFinishTimer(3) == false then
        f2_local0[24] = 0
    end
    if f2_arg1:IsFinishTimer(1) == false then
        f2_local0[23] = 1
    end
    if f2_arg1:HasSpecialEffectId(TARGET_SELF, 3122050) then
        f2_local0[45] = 0
    end
    if SpaceCheck(f2_arg1, f2_arg2, 90, 1) == false and SpaceCheck(f2_arg1, f2_arg2, -45, 1) == false then
        f2_local0[23] = 0
    end
    if SpaceCheck(f2_arg1, f2_arg2, 180, 2) == false then
        f2_local0[24] = 0
    end
    if SpaceCheck(f2_arg1, f2_arg2, 180, 1) == false then
        f2_local0[25] = 0
    end
    f2_local0[1] = SetCoolTime(f2_arg1, f2_arg2, 3006, 15, f2_local0[1], 1)
    f2_local0[2] = SetCoolTime(f2_arg1, f2_arg2, 3001, 8, f2_local0[2], 1)
    f2_local0[3] = SetCoolTime(f2_arg1, f2_arg2, 3003, 8, f2_local0[3], 1)
    f2_local0[4] = SetCoolTime(f2_arg1, f2_arg2, 3004, 8, f2_local0[4], 1)
    f2_local0[5] = SetCoolTime(f2_arg1, f2_arg2, 3005, 8, f2_local0[5], 1)
    f2_local0[6] = SetCoolTime(f2_arg1, f2_arg2, 3010, 8, f2_local0[6], 1)
    f2_local0[7] = SetCoolTime(f2_arg1, f2_arg2, 3008, 8, f2_local0[7], 1)
    f2_local0[24] = SetCoolTime(f2_arg1, f2_arg2, 5201, 15, f2_local0[24], 1)
    f2_local0[24] = SetCoolTime(f2_arg1, f2_arg2, 5211, 15, f2_local0[24], 1)
    f2_local1[1] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act01)
    f2_local1[2] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act02)
    f2_local1[3] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act03)
    f2_local1[4] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act04)
    f2_local1[5] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act05)
    f2_local1[6] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act06)
    f2_local1[7] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act07)
    f2_local1[8] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act08)
    f2_local1[21] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act21)
    f2_local1[22] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act22)
    f2_local1[23] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act23)
    f2_local1[24] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act24)
    f2_local1[25] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act25)
    f2_local1[26] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act26)
    f2_local1[27] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act27)
    f2_local1[28] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act28)
    f2_local1[45] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act45)
    local f2_local10 = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.ActAfter_AdjustSpace)
    Common_Battle_Activate(f2_arg1, f2_arg2, f2_local0, f2_local1, f2_local10, f2_local2)
    
end

Goal.Act01 = function (f3_arg0, f3_arg1, f3_arg2)
    local f3_local0 = 3.8 - f3_arg0:GetMapHitRadius(TARGET_SELF)
    local f3_local1 = 3.8 - f3_arg0:GetMapHitRadius(TARGET_SELF)
    local f3_local2 = 3.8 - f3_arg0:GetMapHitRadius(TARGET_SELF)
    local f3_local3 = 0
    local f3_local4 = 0
    local f3_local5 = 3
    local f3_local6 = 3
    Approach_Act_Flex(f3_arg0, f3_arg1, f3_local0, f3_local1, f3_local2, f3_local3, f3_local4, f3_local5, f3_local6)
    local f3_local7 = 3006
    local f3_local8 = 3007
    local f3_local9 = 3.7 - f3_arg0:GetMapHitRadius(TARGET_SELF)
    local f3_local10 = 0
    local f3_local11 = 0
    f3_arg1:AddSubGoal(GOAL_COMMON_ComboAttackTunableSpin, 10, f3_local7, TARGET_ENE_0, f3_local9, f3_local10, f3_local11, 0, 0):TimingSetNumber(0, f3_arg0:GetNumber(0) + 3, AI_TIMING_SET__ACTIVATE)
    f3_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, f3_local8, TARGET_ENE_0, 9999, 0):TimingSetNumber(0, f3_arg0:GetNumber(0) + 5, AI_TIMING_SET__ACTIVATE)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act02 = function (f4_arg0, f4_arg1, f4_arg2)
    local f4_local0 = 2.8 - f4_arg0:GetMapHitRadius(TARGET_SELF)
    local f4_local1 = 6 - f4_arg0:GetMapHitRadius(TARGET_SELF)
    local f4_local2 = 2.8 - f4_arg0:GetMapHitRadius(TARGET_SELF)
    local f4_local3 = 100
    local f4_local4 = 0
    local f4_local5 = 1.5
    local f4_local6 = 3
    local f4_local7 = f4_arg0:GetRandam_Int(1, 100)
    local f4_local8 = 3001
    local f4_local9 = 3002
    local f4_local10 = 5.9 - f4_arg0:GetMapHitRadius(TARGET_SELF)
    local f4_local11 = 0
    local f4_local12 = 0
    f4_arg1:AddSubGoal(GOAL_COMMON_ComboAttackTunableSpin, 10, f4_local8, TARGET_ENE_0, f4_local10, f4_local11, f4_local12, 0, 0):TimingSetNumber(0, f4_arg0:GetNumber(0) + 2, AI_TIMING_SET__ACTIVATE)
    if f4_local7 >= 20 then
        f4_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, f4_local9, TARGET_ENE_0, 9999, 0, 0):TimingSetNumber(0, f4_arg0:GetNumber(0) + 5, AI_TIMING_SET__ACTIVATE)
    end
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act03 = function (f5_arg0, f5_arg1, f5_arg2)
    local f5_local0 = ATT3003_DIST_MAX
    local f5_local1 = ATT3003_DIST_MAX
    local f5_local2 = ATT3003_DIST_MAX
    local f5_local3 = 60
    local f5_local4 = 0
    local f5_local5 = 1.5
    local f5_local6 = 3
    Approach_Act_Flex(f5_arg0, f5_arg1, f5_local0, f5_local1, f5_local2, f5_local3, f5_local4, f5_local5, f5_local6)
    local f5_local7 = 3003
    local f5_local8 = 0
    local f5_local9 = 0
    f5_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 10, f5_local7, TARGET_ENE_0, 9999, f5_local8, f5_local9, 0, 0):TimingSetNumber(0, f5_arg0:GetNumber(0) + 5, AI_TIMING_SET__ACTIVATE)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act04 = function (f6_arg0, f6_arg1, f6_arg2)
    local f6_local0 = 5.9 - f6_arg0:GetMapHitRadius(TARGET_SELF)
    local f6_local1 = 5.9 - f6_arg0:GetMapHitRadius(TARGET_SELF)
    local f6_local2 = 5.9 - f6_arg0:GetMapHitRadius(TARGET_SELF)
    local f6_local3 = 40
    local f6_local4 = 0
    local f6_local5 = 1.5
    local f6_local6 = 3
    Approach_Act_Flex(f6_arg0, f6_arg1, f6_local0, f6_local1, f6_local2, f6_local3, f6_local4, f6_local5, f6_local6)
    local f6_local7 = 3004
    local f6_local8 = 0
    local f6_local9 = 0
    f6_arg1:AddSubGoal(GOAL_COMMON_ComboAttackTunableSpin, 10, f6_local7, TARGET_ENE_0, 9999, f6_local8, f6_local9, 0, 0):TimingSetNumber(0, f6_arg0:GetNumber(0) + 8, AI_TIMING_SET__ACTIVATE)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act05 = function (f7_arg0, f7_arg1, f7_arg2)
    local f7_local0 = 2.4 - f7_arg0:GetMapHitRadius(TARGET_SELF)
    local f7_local1 = 2.4 - f7_arg0:GetMapHitRadius(TARGET_SELF)
    local f7_local2 = 2.4 - f7_arg0:GetMapHitRadius(TARGET_SELF)
    local f7_local3 = 100
    local f7_local4 = 0
    local f7_local5 = 1.5
    local f7_local6 = 3
    local f7_local7 = f7_arg0:GetRandam_Int(1, 100)
    local f7_local8 = 3005
    local f7_local9 = 3009
    local f7_local10 = 9.5 - f7_arg0:GetMapHitRadius(TARGET_SELF)
    local f7_local11 = 0
    local f7_local12 = 0
    f7_arg1:AddSubGoal(GOAL_COMMON_ComboAttackTunableSpin, 10, f7_local8, TARGET_ENE_0, f7_local10, f7_local11, f7_local12, 0, 0):TimingSetTimer(0, 3, AI_TIMING_SET__ACTIVATE):TimingSetNumber(0, f7_arg0:GetNumber(0) + 2, AI_TIMING_SET__ACTIVATE)
    if f7_local7 >= 70 then
        f7_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, f7_local9, TARGET_ENE_0, 9999, 0, 0):TimingSetNumber(0, f7_arg0:GetNumber(0) + 5, AI_TIMING_SET__ACTIVATE)
    end
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act06 = function (f8_arg0, f8_arg1, f8_arg2)
    local f8_local0 = 6 - f8_arg0:GetMapHitRadius(TARGET_SELF)
    local f8_local1 = 6 - f8_arg0:GetMapHitRadius(TARGET_SELF)
    local f8_local2 = 6 - f8_arg0:GetMapHitRadius(TARGET_SELF)
    local f8_local3 = 100
    local f8_local4 = 0
    local f8_local5 = 1.5
    local f8_local6 = 3
    Approach_Act_Flex(f8_arg0, f8_arg1, f8_local0, f8_local1, f8_local2, f8_local3, f8_local4, f8_local5, f8_local6)
    local f8_local7 = 3010
    local f8_local8 = 0
    local f8_local9 = 0
    f8_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 10, f8_local7, TARGET_ENE_0, 9999, f8_local8, f8_local9, 0, 0):TimingSetNumber(0, f8_arg0:GetNumber(0) + 5, AI_TIMING_SET__ACTIVATE)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act07 = function (f9_arg0, f9_arg1, f9_arg2)
    local f9_local0 = 9.5 - f9_arg0:GetMapHitRadius(TARGET_SELF)
    local f9_local1 = 9.5 - f9_arg0:GetMapHitRadius(TARGET_SELF)
    local f9_local2 = 9.5 - f9_arg0:GetMapHitRadius(TARGET_SELF)
    local f9_local3 = 100
    local f9_local4 = 0
    local f9_local5 = 1.5
    local f9_local6 = 3
    Approach_Act_Flex(f9_arg0, f9_arg1, f9_local0, f9_local1, f9_local2, f9_local3, f9_local4, f9_local5, f9_local6)
    local f9_local7 = 3008
    local f9_local8 = 0
    local f9_local9 = 0
    f9_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 10, f9_local7, TARGET_ENE_0, 9999, f9_local8, f9_local9, 0, 0):TimingSetNumber(0, f9_arg0:GetNumber(0) + 6, AI_TIMING_SET__ACTIVATE)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act08 = function (f10_arg0, f10_arg1, f10_arg2)
    local f10_local0 = 2.8 - f10_arg0:GetMapHitRadius(TARGET_SELF)
    local f10_local1 = 2.8 - f10_arg0:GetMapHitRadius(TARGET_SELF)
    local f10_local2 = 2.8 - f10_arg0:GetMapHitRadius(TARGET_SELF)
    local f10_local3 = 100
    local f10_local4 = 0
    local f10_local5 = 1.5
    local f10_local6 = 3
    local f10_local7 = f10_arg0:GetRandam_Int(1, 100)
    Approach_Act_Flex(f10_arg0, f10_arg1, f10_local0, f10_local1, f10_local2, f10_local3, f10_local4, f10_local5, f10_local6)
    local f10_local8 = 3001
    local f10_local9 = 3002
    local f10_local10 = 5.9 - f10_arg0:GetMapHitRadius(TARGET_SELF)
    local f10_local11 = 0
    local f10_local12 = 0
    f10_arg1:AddSubGoal(GOAL_COMMON_ComboAttackTunableSpin, 10, f10_local8, TARGET_ENE_0, f10_local10, f10_local11, f10_local12, 0, 0):TimingSetNumber(0, f10_arg0:GetNumber(0) + 2, AI_TIMING_SET__ACTIVATE)
    f10_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, f10_local9, TARGET_ENE_0, 9999, 0, 0):TimingSetNumber(0, f10_arg0:GetNumber(0) + 5, AI_TIMING_SET__ACTIVATE)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act21 = function (f11_arg0, f11_arg1, f11_arg2)
    local f11_local0 = 3
    local f11_local1 = 45
    if f11_arg0:IsTargetGuard(TARGET_SELF) then
        f11_arg1:AddSubGoal(GOAL_COMMON_Turn, f11_local0, TARGET_ENE_0, f11_local1, 9910, GOAL_RESULT_Success, true)
    else
        f11_arg1:AddSubGoal(GOAL_COMMON_Turn, f11_local0, TARGET_ENE_0, f11_local1, -1, GOAL_RESULT_Success, true)
    end
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
    
end

Goal.Act23 = function (f12_arg0, f12_arg1, f12_arg2)
    local f12_local0 = f12_arg0:GetDist(TARGET_ENE_0)
    local f12_local1 = f12_arg0:GetSp(TARGET_SELF)
    local f12_local2 = 20
    local f12_local3 = f12_arg0:GetRandam_Int(1, 100)
    local f12_local4 = -1
    if f12_local2 <= f12_local1 and f12_local3 <= 75 then
        f12_local4 = 9910
    end
    if SpaceCheck(f12_arg0, f12_arg1, -90, 1) == true then
        if SpaceCheck(f12_arg0, f12_arg1, 90, 1) == true then
            if f12_arg0:IsInsideTarget(TARGET_ENE_0, AI_DIR_TYPE_R, 180, 999) then
                direction = 1
            else
                direction = 0
            end
        else
            direction = 0
        end
    elseif SpaceCheck(f12_arg0, f12_arg1, 90, 1) == true then
        direction = 1
    else
        GetWellSpace_Odds = 100
        return GetWellSpace_Odds
    end
    local f12_local5 = nil
    local f12_local6 = f12_arg0:GetRandam_Int(30, 45)
    local f12_local7 = 90
    local f12_local8 = 3.5
    f12_arg0:AddObserveArea(0, TARGET_SELF, TARGET_ENE_0, AI_DIR_TYPE_F, f12_local7, f12_local8)
    f12_arg0:AddObserveArea(1, TARGET_SELF, TARGET_ENE_0, AI_DIR_TYPE_F, f12_local7, 11)
    if f12_local0 <= 5 then
        f12_local5 = f12_arg0:GetRandam_Float(1, 2)
    elseif f12_local0 <= 8 then
        f12_local5 = f12_arg0:GetRandam_Float(2, 3)
    else
        f12_local5 = f12_arg0:GetRandam_Float(3, 4)
    end
    f12_arg1:AddSubGoal(GOAL_COMMON_SidewayMove, f12_local5, TARGET_ENE_0, direction, f12_local6, true, true, f12_local4):TimingSetTimer(3, 3, AITIMING_SET__UPDATE_SUCCESS)
    f12_arg0:SetTimer(1, 4)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act24 = function (f13_arg0, f13_arg1, f13_arg2)
    local f13_local0 = f13_arg0:GetDist(TARGET_ENE_0)
    local f13_local1 = 3
    local f13_local2 = 0
    local f13_local3 = 5201
    if SpaceCheck(f13_arg0, f13_arg1, 180, 2) == true then
        if SpaceCheck(f13_arg0, f13_arg1, 180, 4) == true then
            if f13_local0 > 4 then
                f13_local3 = 5201
            else
                f13_local3 = 5211
            end
        else
            f13_local3 = 5201
        end
    else
        GetWellSpace_Odds = 100
        return GetWellSpace_Odds
    end
    f13_arg1:AddSubGoal(GOAL_COMMON_SpinStep, f13_local1, f13_local3, TARGET_ENE_0, f13_local2, AI_DIR_TYPE_B, 0):TimingSetTimer(0, 2, UPDATE_SUCCESS)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act25 = function (f14_arg0, f14_arg1, f14_arg2)
    local f14_local0 = f14_arg0:GetRandam_Float(2, 4)
    local f14_local1 = f14_arg0:GetRandam_Float(3, 5)
    local f14_local2 = f14_arg0:GetDist(TARGET_ENE_0)
    local f14_local3 = f14_arg0:GetSp(TARGET_SELF)
    local f14_local4 = 20
    local f14_local5 = f14_arg0:GetRandam_Int(1, 100)
    local f14_local6 = -1
    local f14_local7 = 90
    local f14_local8 = 2.4 - f14_arg0:GetMapHitRadius(TARGET_SELF)
    f14_arg0:AddObserveArea(0, TARGET_SELF, TARGET_ENE_0, AI_DIR_TYPE_F, f14_local7, f14_local8)
    f14_arg0:AddObserveArea(1, TARGET_SELF, TARGET_ENE_0, AI_DIR_TYPE_F, f14_local7, 11)
    if f14_local4 <= f14_local3 and f14_local5 <= 90 then
        Guard = 9910
    end
    if SpaceCheck(f14_arg0, f14_arg1, 180, 1) == true then
        f14_arg1:AddSubGoal(GOAL_COMMON_LeaveTarget, f14_local0, TARGET_ENE_0, f14_local1, TARGET_ENE_0, true, f14_local6)
    else
        GetWellSpace_Odds = 100
        return GetWellSpace_Odds
    end
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
    
end

Goal.Act26 = function (f15_arg0, f15_arg1, f15_arg2)
    f15_arg1:AddSubGoal(GOAL_COMMON_Wait, 0.5, TARGET_SELF, 0, 0, 0)
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
    
end

Goal.Act27 = function (f16_arg0, f16_arg1, f16_arg2)
    local f16_local0 = f16_arg0:GetRandam_Int(1, 100)
    if YousumiAct_SubGoal(f16_arg0, f16_arg1, true, 60, 30) == false then
        GetWellSpace_Odds = 0
        return GetWellSpace_Odds
    end
    local f16_local1 = 0
    local f16_local2 = SpaceCheck_SidewayMove(f16_arg0, f16_arg1, 1)
    if f16_local2 == 0 then
        f16_local1 = 0
    elseif f16_local2 == 1 then
        f16_local1 = 1
    elseif f16_local2 == 2 then
        if f16_local0 <= 50 then
            f16_local1 = 0
        else
            f16_local1 = 1
        end
    else
        f16_arg1:AddSubGoal(GOAL_COMMON_Wait, 0.5, TARGET_SELF, 0, 0, 0)
        GetWellSpace_Odds = 0
        return GetWellSpace_Odds
    end
    f16_arg0:SetNumber(10, f16_local1)
    f16_arg1:AddSubGoal(GOAL_COMMON_SidewayMove, 3, TARGET_ENE_0, f16_local1, f16_arg0:GetRandam_Int(30, 45), true, true, -1)
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
    
end

Goal.Act28 = function (f17_arg0, f17_arg1, f17_arg2)
    local f17_local0 = f17_arg0:GetDist(TARGET_ENE_0)
    local f17_local1 = 1.5
    local f17_local2 = 1.5
    local f17_local3 = f17_arg0:GetRandam_Int(30, 45)
    local f17_local4 = -1
    local f17_local5 = f17_arg0:GetRandam_Int(0, 1)
    local f17_local6 = f17_arg0:GetSp(TARGET_SELF)
    local f17_local7 = 20
    local f17_local8 = f17_arg0:GetRandam_Int(1, 100)
    local f17_local9 = 90
    local f17_local10 = 3.5
    f17_arg0:AddObserveArea(0, TARGET_SELF, TARGET_ENE_0, AI_DIR_TYPE_F, f17_local9, f17_local10)
    f17_arg0:AddObserveArea(1, TARGET_SELF, TARGET_ENE_0, AI_DIR_TYPE_F, f17_local9, 11)
    if f17_local7 <= f17_local6 and f17_local8 <= 90 then
        f17_local4 = 9910
    end
    if f17_local0 <= 6 then
        f17_arg1:AddSubGoal(GOAL_COMMON_SidewayMove, f17_local1, TARGET_ENE_0, f17_local5, f17_local3, true, true, f17_local4)
    elseif f17_local0 <= 8 then
        f17_arg1:AddSubGoal(GOAL_COMMON_ApproachTarget, f17_local2, TARGET_ENE_0, 6, TARGET_SELF, true, -1)
    else
        f17_arg1:AddSubGoal(GOAL_COMMON_ApproachTarget, f17_local2, TARGET_ENE_0, 8, TARGET_SELF, true, -1)
    end
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
    
end

Goal.Act45 = function (f18_arg0, f18_arg1, f18_arg2)
    local f18_local0 = 3035
    local f18_local1 = 0
    local f18_local2 = 0
    local f18_local3 = f18_arg0:GetDist(TARGET_ENE_0)
    if f18_local3 <= 3 then
        f18_arg1:AddSubGoal(GOAL_COMMON_ComboRepeat, 10, 5211, TARGET_ENE_0, 9999, 0)
    end
    f18_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3045, TARGET_ENE_0, 9999, f18_local1, f18_local2, 0, 0):TimingSetNumber(7, 1, AI_TIMING_SET__ACTIVATE)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Interrupt = function (f19_arg0, f19_arg1, f19_arg2)
    local f19_local0 = f19_arg1:GetHpRate(TARGET_SELF)
    local f19_local1 = f19_arg1:GetDist(TARGET_ENE_0)
    local f19_local2 = f19_arg1:GetSp(TARGET_SELF)
    local f19_local3 = f19_arg1:GetSpecialEffectActivateInterruptType(0)
    local f19_local4 = f19_arg1:GetRandam_Int(1, 100)
    if f19_arg1:IsLadderAct(TARGET_SELF) then
        return false
    end
    if not f19_arg1:HasSpecialEffectId(TARGET_SELF, 200004) then
        return false
    end
    if f19_arg1:IsInterupt(INTERUPT_ParryTiming) then
        return Common_Parry(f19_arg1, f19_arg2, 50, 25)
    end
    if f19_arg1:IsInterupt(INTERUPT_Damaged) then
        return f19_arg0.Damaged(f19_arg1, f19_arg2)
    end
    if f19_arg1:IsInterupt(INTERUPT_Shoot) then
        return f19_arg0.ShootReaction(f19_arg1, f19_arg2)
    end
    if f19_arg1:IsInterupt(INTERUPT_ActivateSpecialEffect) then
    end
    if f19_arg1:IsInterupt(INTERUPT_Inside_ObserveArea) and f19_arg1:IsInsideObserve(0) then
        f19_arg1:SetTimer(2, 0)
        f19_arg1:DeleteObserve(0)
        f19_arg1:Replanning()
        return true
    end
    if f19_arg1:IsInterupt(INTERUPT_Outside_ObserveArea) and f19_arg1:GetAreaObserveSlot(AI_AREAOBSERVE_INTERRUPT__OUTSIDE, 1) then
        f19_arg1:SetTimer(2, 0)
        f19_arg1:DeleteObserve(1)
        f19_arg1:Replanning()
        return true
    end
    if f19_arg1:IsInterupt(INTERUPT_ShootImpact) and f19_arg0.ShootReaction(f19_arg1, f19_arg2) then
        return true
    end
    return false
    
end

Goal.Damaged = function (f20_arg0, f20_arg1, f20_arg2)
    local f20_local0 = f20_arg0:GetHpRate(TARGET_SELF)
    local f20_local1 = f20_arg0:GetDist(TARGET_ENE_0)
    local f20_local2 = f20_arg0:GetSp(TARGET_SELF)
    local f20_local3 = f20_arg0:GetRandam_Int(1, 100)
    local f20_local4 = 0
    if f20_local3 <= 75 then
        guard = 9910
    end
    if f20_local3 <= 33 then
        if SpaceCheck(f20_arg0, f20_arg1, 180, 2) == true then
            f20_arg1:ClearSubGoal()
            f20_arg1:AddSubGoal(GOAL_COMMON_SpinStep, 3, 5201, TARGET_ENE_0, TurnTime, AI_DIR_TYPE_B, 0):TimingSetTimer(0, 2, UPDATE_SUCCESS)
            return true
        else
            return false
        end
    elseif f20_local3 <= 67 then
        if SpaceCheck(f20_arg0, f20_arg1, 180, 1) == true then
            f20_arg1:ClearSubGoal()
            f20_arg1:AddSubGoal(GOAL_COMMON_LeaveTarget, 3, TARGET_ENE_0, 9999, TARGET_ENE_0, true, guard)
            return true
        else
            f20_arg1:ClearSubGoal()
            f20_arg1:AddSubGoal(GOAL_COMMON_SidewayMove, walkLife, TARGET_ENE_0, direction, SuccessAngle, true, true, guard)
            return true
        end
    end
    return false
    
end

Goal.ShootReaction = function (f21_arg0, f21_arg1)
    f21_arg1:ClearSubGoal()
    f21_arg1:AddSubGoal(GOAL_COMMON_EndureAttack, 0.1, 3100, TARGET_ENE_0, 9999, 0)
    return true
    
end

Goal.Kengeki_Activate = function (f22_arg0, f22_arg1, f22_arg2)
    local f22_local0 = ReturnKengekiSpecialEffect(f22_arg1)
    if f22_local0 == 0 then
        return false
    end
    local f22_local1 = {}
    local f22_local2 = {}
    local f22_local3 = {}
    Common_Clear_Param(f22_local1, f22_local2, f22_local3)
    local f22_local4 = f22_arg1:GetDist(TARGET_ENE_0)
    local f22_local5 = f22_arg1:GetSp(TARGET_SELF)
    if f22_local5 <= 0 then
        f22_local1[26] = 100
    elseif f22_local0 == 200200 then
        if f22_local4 >= 2 then
            f22_local1[26] = 100
        elseif f22_local4 <= 0.2 then
            f22_local1[26] = 100
        else
            f22_local1[3] = 100
            f22_local1[24] = 10
            f22_local1[26] = 50
        end
    elseif f22_local0 == 200201 then
        if f22_local4 >= 2 then
            f22_local1[26] = 100
        elseif f22_local4 <= 0.2 then
            f22_local1[26] = 100
        else
            f22_local1[24] = 10
            f22_local1[26] = 100
        end
    elseif f22_local0 == 200205 then
        if f22_local4 >= 2 then
            f22_local1[26] = 100
        elseif f22_local4 <= 0.2 then
            f22_local1[26] = 100
        else
            f22_local1[26] = 100
        end
    elseif f22_local0 == 200206 then
        if f22_local4 >= 2 then
            f22_local1[26] = 100
        elseif f22_local4 <= 0.2 then
            f22_local1[26] = 100
        else
            f22_local1[26] = 100
        end
    elseif f22_local0 == 200215 or f22_local0 == 200210 then
        if f22_local4 >= 2 then
            f22_local1[26] = 100
        elseif f22_local4 <= 0.2 then
            f22_local1[26] = 100
        else
            f22_local1[5] = 100
            f22_local1[24] = 10
            f22_local1[26] = 100
        end
    elseif f22_local0 == 200216 then
        if f22_local4 >= 2 then
            f22_local1[26] = 100
        elseif f22_local4 <= 0.2 then
            f22_local1[26] = 100
        else
            f22_local1[6] = 100
            f22_local1[24] = 10
            f22_local1[26] = 100
        end
    elseif f22_local0 == 200211 then
        f22_local1[6] = 100
    end
    f22_local2[1] = REGIST_FUNC(f22_arg1, f22_arg2, f22_arg0.Kengeki01)
    f22_local2[2] = REGIST_FUNC(f22_arg1, f22_arg2, f22_arg0.Kengeki02)
    f22_local2[3] = REGIST_FUNC(f22_arg1, f22_arg2, f22_arg0.Kengeki03)
    f22_local2[4] = REGIST_FUNC(f22_arg1, f22_arg2, f22_arg0.Kengeki04)
    f22_local2[5] = REGIST_FUNC(f22_arg1, f22_arg2, f22_arg0.Kengeki05)
    f22_local2[6] = REGIST_FUNC(f22_arg1, f22_arg2, f22_arg0.Kengeki06)
    f22_local2[7] = REGIST_FUNC(f22_arg1, f22_arg2, f22_arg0.Kengeki07)
    f22_local2[8] = REGIST_FUNC(f22_arg1, f22_arg2, f22_arg0.Kengeki08)
    f22_local2[24] = REGIST_FUNC(f22_arg1, f22_arg2, f22_arg0.Kengeki24)
    f22_local2[26] = REGIST_FUNC(f22_arg1, f22_arg2, f22_arg0.NoAction)
    local f22_local6 = REGIST_FUNC(f22_arg1, f22_arg2, f22_arg0.ActAfter_AdjustSpace)
    return Common_Kengeki_Activate(f22_arg1, f22_arg2, f22_local1, f22_local2, f22_local6, f22_local3)
    
end

Goal.Kengeki03 = function (f23_arg0, f23_arg1, f23_arg2)
    f23_arg1:ClearSubGoal()
    local f23_local0 = 3061
    local f23_local1 = 0
    local f23_local2 = 0
    f23_arg1:AddSubGoal(GOAL_COMMON_ComboAttackTunableSpin, 10, f23_local0, TARGET_ENE_0, DistToAtt1, f23_local1, f23_local2, 0, 0):TimingSetNumber(0, f23_arg0:GetNumber(0) + 5, AI_TIMING_SET__ACTIVATE)
    
end

Goal.Kengeki05 = function (f24_arg0, f24_arg1, f24_arg2)
    f24_arg1:ClearSubGoal()
    f24_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3050, TARGET_ENE_0, 9999, 0, 0):TimingSetNumber(0, f24_arg0:GetNumber(0) + 5, AI_TIMING_SET__ACTIVATE)
    
end

Goal.Kengeki06 = function (f25_arg0, f25_arg1, f25_arg2)
    f25_arg1:ClearSubGoal()
    f25_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3050, TARGET_ENE_0, 9999, 0, 0):TimingSetNumber(0, f25_arg0:GetNumber(0) + 5, AI_TIMING_SET__ACTIVATE)
    
end

Goal.Kengeki24 = function (f26_arg0, f26_arg1, f26_arg2)
    f26_arg1:ClearSubGoal()
    f26_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 5211, TARGET_ENE_0, 0, AI_DIR_TYPE_B, 0)
    
end

Goal.NoAction = function (f27_arg0, f27_arg1, f27_arg2)
    return -1
    
end

Goal.ActAfter_AdjustSpace = function (f28_arg0, f28_arg1, f28_arg2)
    
end

Goal.Update = function (f29_arg0, f29_arg1, f29_arg2)
    return Update_Default_NoSubGoal(f29_arg0, f29_arg1, f29_arg2)
    
end

Goal.Terminate = function (f30_arg0, f30_arg1, f30_arg2)
    
end


