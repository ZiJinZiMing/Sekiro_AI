RegisterTableGoal(GOAL_Yasyazaru510010_Battle, "GOAL_Yasyazaru510010_Battle")
REGISTER_GOAL_NO_SUB_GOAL(GOAL_Yasyazaru510010_Battle, true)

Goal.Initialize = function (f1_arg0, f1_arg1, f1_arg2, f1_arg3)
    f1_arg1:SetTimer(6, 50)
    
end

Goal.Activate = function (f2_arg0, f2_arg1, f2_arg2)
    Init_Pseudo_Global(f2_arg1, f2_arg2)
    if f2_arg0.Kengeki_Activate(f2_arg0, f2_arg1, f2_arg2) then
        return
    end
    local f2_local0 = {}
    local f2_local1 = {}
    local f2_local2 = {}
    Common_Clear_Param(f2_local0, f2_local1, f2_local2)
    local f2_local3 = f2_arg1:GetDist(TARGET_EVENT)
    local f2_local4 = f2_arg1:GetHpRate(TARGET_EVENT)
    local f2_local5 = f2_arg1:GetDist(TARGET_ENE_0)
    local f2_local6 = f2_arg1:GetExcelParam(AI_EXCEL_THINK_PARAM_TYPE__thinkAttr_doAdmirer)
    local f2_local7 = f2_arg1:GetEventRequest()
    local f2_local8 = f2_arg1:GetEventRequest(1)
    f2_arg1:AddObserveSpecialEffectAttribute(TARGET_SELF, 5028)
    f2_arg1:AddObserveSpecialEffectAttribute(TARGET_EVENT, 3510900)
    f2_arg1:AddObserveSpecialEffectAttribute(TARGET_EVENT, 3510901)
    f2_arg1:DeleteObserve(0)
    if f2_arg1:GetTimer(5) <= 0 and f2_arg1:GetNumber(1) == 1 then
        f2_arg1:SetNumber(1, 0)
    end
    if f2_arg1:GetNumber(1) == 1 and f2_local4 <= 0 then
        f2_arg1:SetNumber(1, 0)
    end
    if f2_local7 == 10 then
        f2_arg1:SetEventMoveTarget(1702871)
        if f2_arg1:IsInsideTarget(POINT_EVENT, AI_DIR_TYPE_B, 180) then
            f2_arg2:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 10, 3017, POINT_EVENT, 9999, 0, 0, 0, 0)
        end
        f2_arg2:AddSubGoal(GOAL_COMMON_ApproachTarget, 10, POINT_EVENT, 2, TARGET_SELF, false, -1)
    elseif f2_local7 == 11 then
        f2_arg2:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 10, 3018, TARGET_ENE_0, 9999, 0, 0, 0, 0)
        f2_arg2:AddSubGoal(GOAL_COMMON_Wait, 3, TARGET_SELF, 0, 0, 0)
    elseif f2_arg1:HasSpecialEffectId(TARGET_ENE_0, 110060) or f2_arg1:HasSpecialEffectId(TARGET_ENE_0, 110010) then
        if f2_arg1:IsInsideTarget(TARGET_ENE_0, AI_DIR_TYPE_F, 90) then
            f2_local0[27] = 100
        else
            f2_local0[21] = 100
        end
    elseif Common_ActivateAct(f2_arg1, f2_arg2, 1) then
    elseif f2_arg1:HasSpecialEffectId(TARGET_ENE_0, COMMON_SP_EFFECT_PC_BREAK) and f2_arg1:GetNumber(1) == 0 then
        if 20 - f2_arg1:GetMapHitRadius(TARGET_SELF) <= f2_local5 then
            f2_local0[9] = 100
        else
            f2_local0[4] = 100
        end
    elseif f2_arg1:GetNumber(1) == 1 or f2_arg1:HasSpecialEffectId(TARGET_ENE_0, 110030) then
        if f2_arg1:GetNumber(5) == 1 then
            f2_local0[23] = 1
            f2_local0[24] = 200
        elseif f2_local3 >= 10 then
            f2_local0[30] = 100000
        elseif f2_local5 >= 20 then
            f2_local0[4] = 0
            f2_local0[6] = 0
            f2_local0[8] = 0
            f2_local0[22] = 200
            f2_local0[23] = 400
        elseif f2_local5 >= 5 then
            f2_local0[6] = 0
            f2_local0[8] = 0
            f2_local0[22] = 200
            f2_local0[23] = 300
        elseif f2_local5 >= 3 then
            f2_local0[8] = 0
            f2_local0[22] = 200
            f2_local0[23] = 100
            f2_local0[24] = 500
        else
            f2_local0[4] = 0
            f2_local0[7] = 0
            f2_local0[22] = 50
            f2_local0[24] = 400
        end
    elseif f2_arg1:IsInsideTarget(TARGET_ENE_0, AI_DIR_TYPE_B, 90) then
        f2_local0[22] = 100
        if f2_local5 >= 10 then
            f2_local0[4] = 100
            f2_local0[21] = 50
        elseif f2_local5 >= 3 then
            f2_local0[4] = 100
            f2_local0[22] = 100
        else
            f2_local0[6] = 500
            f2_local0[22] = 100
            f2_local0[24] = 100
        end
    else
        if f2_local7 == 20 then
            f2_local0[12] = 500
        elseif f2_local5 >= 20 then
            f2_local0[1] = 0
            f2_local0[2] = 0
            f2_local0[3] = 0
            f2_local0[4] = 0
            f2_local0[5] = 50
            f2_local0[6] = 0
            f2_local0[7] = 60
            f2_local0[8] = 0
            f2_local0[9] = 0
            f2_local0[10] = 100
        elseif f2_local5 >= 10 then
            f2_local0[5] = 60
            f2_local0[6] = 0
            f2_local0[7] = 50
            f2_local0[8] = 0
            f2_local0[9] = 0
            f2_local0[10] = 120
            if f2_arg1:HasSpecialEffectId(TARGET_SELF, 5021) then
                f2_local0[4] = 0
                f2_local0[41] = 100
                f2_local0[9] = 0
                f2_local0[40] = 0
            end
        elseif f2_local5 >= 3 then
            f2_local0[1] = 100
            f2_local0[4] = 50
            f2_local0[5] = 100
            f2_local0[6] = 100
            f2_local0[7] = 100
            f2_local0[8] = 0
            f2_local0[9] = 50
            f2_local0[22] = 100
            f2_local0[24] = 100
            if f2_arg1:HasSpecialEffectId(TARGET_SELF, 5021) then
                f2_local0[4] = 0
                f2_local0[41] = 100
                f2_local0[9] = 0
                f2_local0[40] = 100
            end
        else
            f2_local0[1] = 0
            f2_local0[2] = 0
            f2_local0[3] = 0
            f2_local0[4] = 0
            f2_local0[5] = 0
            f2_local0[6] = 500
            f2_local0[7] = 0
            f2_local0[8] = 100
            f2_local0[9] = 100
            f2_local0[22] = 100
            f2_local0[24] = 100
        end
        if f2_arg1:HasSpecialEffectId(TARGET_ENE_0, 109031) or f2_arg1:HasSpecialEffectId(TARGET_ENE_0, 110125) then
            f2_local0[22] = 1
            f2_local0[24] = 1
        end
    end
    if f2_arg1:IsFinishTimer(0) == false then
        f2_local0[22] = 1
    end
    if f2_arg1:IsFinishTimer(1) == false and f2_arg1:GetNumber(1) == 0 then
        f2_local0[24] = 1
    end
    if f2_arg1:GetNumber(1) == 1 then
        f2_arg1:SetNumber(5, 0)
    end
    if SpaceCheck(f2_arg1, f2_arg2, 45, 2) == false and SpaceCheck(f2_arg1, f2_arg2, -45, 2) == false then
    end
    if SpaceCheck(f2_arg1, f2_arg2, 90, 1) == false and SpaceCheck(f2_arg1, f2_arg2, -90, 1) == false then
        f2_local0[23] = 0
    end
    if SpaceCheck(f2_arg1, f2_arg2, 180, 2) == false then
    end
    if SpaceCheck(f2_arg1, f2_arg2, 180, 1) == false then
    end
    f2_local0[1] = SetCoolTime(f2_arg1, f2_arg2, 3000, 8, f2_local0[1], 1)
    f2_local0[2] = SetCoolTime(f2_arg1, f2_arg2, 3003, 8, f2_local0[2], 1)
    f2_local0[3] = SetCoolTime(f2_arg1, f2_arg2, 3004, 8, f2_local0[3], 1)
    f2_local0[4] = SetCoolTime(f2_arg1, f2_arg2, 3005, 8, f2_local0[4], 1)
    f2_local0[5] = SetCoolTime(f2_arg1, f2_arg2, 3006, 8, f2_local0[5], 1)
    f2_local0[6] = SetCoolTime(f2_arg1, f2_arg2, 3007, 12, f2_local0[6], 0)
    f2_local0[6] = SetCoolTime(f2_arg1, f2_arg2, 3050, 12, f2_local0[6], 0)
    f2_local0[7] = SetCoolTime(f2_arg1, f2_arg2, 3009, 8, f2_local0[7], 1)
    f2_local0[8] = SetCoolTime(f2_arg1, f2_arg2, 3011, 8, f2_local0[8], 1)
    f2_local0[9] = SetCoolTime(f2_arg1, f2_arg2, 3015, 8, f2_local0[9], 1)
    f2_local0[9] = SetCoolTime(f2_arg1, f2_arg2, 3066, 8, f2_local0[9], 1)
    f2_local0[10] = SetCoolTime(f2_arg1, f2_arg2, 3012, 14, f2_local0[10], 1)
    f2_local0[40] = SetCoolTime(f2_arg1, f2_arg2, 3067, 8, f2_local0[40], 1)
    f2_local0[41] = SetCoolTime(f2_arg1, f2_arg2, 3067, 14, f2_local0[41], 1)
    f2_local0[41] = SetCoolTime(f2_arg1, f2_arg2, 3005, 14, f2_local0[41], 1)
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
    f2_local1[21] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act21)
    f2_local1[22] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act22)
    f2_local1[23] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act23)
    f2_local1[24] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act24)
    f2_local1[25] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act25)
    f2_local1[26] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act26)
    f2_local1[27] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act27)
    f2_local1[28] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act28)
    f2_local1[30] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act30)
    f2_local1[40] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act40)
    f2_local1[41] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act41)
    local f2_local9 = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.ActAfter_AdjustSpace)
    Common_Battle_Activate(f2_arg1, f2_arg2, f2_local0, f2_local1, f2_local9, f2_local2)
    
end

Goal.Act01 = function (f3_arg0, f3_arg1, f3_arg2)
    local f3_local0 = 9.8 - f3_arg0:GetMapHitRadius(TARGET_SELF)
    local f3_local1 = 9.8 - f3_arg0:GetMapHitRadius(TARGET_SELF) + 2
    local f3_local2 = 9.8 - f3_arg0:GetMapHitRadius(TARGET_SELF) + 2
    local f3_local3 = 100
    local f3_local4 = 0
    local f3_local5 = 1.5
    local f3_local6 = 3
    Approach_Act_Flex(f3_arg0, f3_arg1, f3_local0, f3_local1, f3_local2, f3_local3, f3_local4, f3_local5, f3_local6)
    local f3_local7 = 5 - f3_arg0:GetMapHitRadius(TARGET_SELF)
    local f3_local8 = 4 - f3_arg0:GetMapHitRadius(TARGET_SELF)
    local f3_local9 = 0
    local f3_local10 = 0
    local f3_local11 = f3_arg0:GetRandam_Int(1, 100)
    if f3_local11 <= 40 then
        f3_arg1:AddSubGoal(GOAL_COMMON_ComboAttackTunableSpin, 10, 3000, TARGET_ENE_0, f3_local7, f3_local9, f3_local10, 0, 0)
        f3_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3001, TARGET_ENE_0, 9999, 0, 0)
    else
        f3_arg1:AddSubGoal(GOAL_COMMON_ComboAttackTunableSpin, 10, 3000, TARGET_ENE_0, f3_local8, f3_local9, f3_local10, 0, 0)
        f3_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3002, TARGET_ENE_0, 9999, 0, 0)
    end
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act02 = function (f4_arg0, f4_arg1, f4_arg2)
    local f4_local0 = 10.4 - f4_arg0:GetMapHitRadius(TARGET_SELF)
    local f4_local1 = 10.4 - f4_arg0:GetMapHitRadius(TARGET_SELF) + 2
    local f4_local2 = 10.4 - f4_arg0:GetMapHitRadius(TARGET_SELF) + 2
    local f4_local3 = 100
    local f4_local4 = 0
    local f4_local5 = 1.5
    local f4_local6 = 3
    Approach_Act_Flex(f4_arg0, f4_arg1, f4_local0, f4_local1, f4_local2, f4_local3, f4_local4, f4_local5, f4_local6)
    local f4_local7 = 0
    local f4_local8 = 0
    f4_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 10, 3003, TARGET_ENE_0, 9999, f4_local7, f4_local8, 0, 0)
    f4_arg0:SetNumber(0, 0)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act03 = function (f5_arg0, f5_arg1, f5_arg2)
    local f5_local0 = 13.6 - f5_arg0:GetMapHitRadius(TARGET_SELF)
    local f5_local1 = 13.6 - f5_arg0:GetMapHitRadius(TARGET_SELF) + 2
    local f5_local2 = 13.6 - f5_arg0:GetMapHitRadius(TARGET_SELF) + 2
    local f5_local3 = 100
    local f5_local4 = 0
    local f5_local5 = 1.5
    local f5_local6 = 3
    Approach_Act_Flex(f5_arg0, f5_arg1, f5_local0, f5_local1, f5_local2, f5_local3, f5_local4, f5_local5, f5_local6)
    local f5_local7 = 0
    local f5_local8 = 0
    f5_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 10, 3004, TARGET_ENE_0, 9999, f5_local7, f5_local8, 0, 0)
    f5_arg0:SetNumber(0, 0)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act04 = function (f6_arg0, f6_arg1, f6_arg2)
    local f6_local0 = 12 - f6_arg0:GetMapHitRadius(TARGET_SELF)
    local f6_local1 = 12 - f6_arg0:GetMapHitRadius(TARGET_SELF) + 2
    local f6_local2 = 12 - f6_arg0:GetMapHitRadius(TARGET_SELF) + 2
    local f6_local3 = 100
    local f6_local4 = 0
    local f6_local5 = 1.5
    local f6_local6 = 3
    local f6_local7 = f6_arg0:GetEventRequest(1)
    if f6_local7 == 10 then
        f6_local2 = 9999
        f6_local3 = 0
    end
    Approach_Act_Flex(f6_arg0, f6_arg1, f6_local0, f6_local1, f6_local2, f6_local3, f6_local4, f6_local5, f6_local6)
    local f6_local8 = 0
    local f6_local9 = 0
    f6_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 10, 3005, TARGET_ENE_0, 9999, f6_local8, f6_local9, 0, 0)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act05 = function (f7_arg0, f7_arg1, f7_arg2)
    local f7_local0 = 8 - f7_arg0:GetMapHitRadius(TARGET_SELF)
    local f7_local1 = 8 - f7_arg0:GetMapHitRadius(TARGET_SELF) + 2
    local f7_local2 = 8 - f7_arg0:GetMapHitRadius(TARGET_SELF) + 2
    local f7_local3 = 100
    local f7_local4 = 0
    local f7_local5 = 1.5
    local f7_local6 = 3
    Approach_Act_Flex(f7_arg0, f7_arg1, f7_local0, f7_local1, f7_local2, f7_local3, f7_local4, f7_local5, f7_local6)
    local f7_local7 = 0
    local f7_local8 = 0
    f7_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 10, 3006, TARGET_ENE_0, 9999, f7_local7, f7_local8, 0, 0)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act06 = function (f8_arg0, f8_arg1, f8_arg2)
    local f8_local0 = 10.1 - f8_arg0:GetMapHitRadius(TARGET_SELF)
    local f8_local1 = 10.1 - f8_arg0:GetMapHitRadius(TARGET_SELF) + 2
    local f8_local2 = 10.1 - f8_arg0:GetMapHitRadius(TARGET_SELF) + 2
    local f8_local3 = 100
    local f8_local4 = 0
    local f8_local5 = 1.5
    local f8_local6 = 3
    local f8_local7 = 0
    local f8_local8 = 0
    f8_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 20, 3007, TARGET_ENE_0, 9999, f8_local7, f8_local8, 0, 0)
    f8_arg0:SetTimer(6, 50)
    f8_arg0:SetNumber(5, 1)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act07 = function (f9_arg0, f9_arg1, f9_arg2)
    local f9_local0 = 8.6 - f9_arg0:GetMapHitRadius(TARGET_SELF)
    local f9_local1 = 8.6 - f9_arg0:GetMapHitRadius(TARGET_SELF) + 2
    local f9_local2 = 8.6 - f9_arg0:GetMapHitRadius(TARGET_SELF) + 2
    local f9_local3 = 100
    local f9_local4 = 0
    local f9_local5 = 1.5
    local f9_local6 = 3
    local f9_local7 = f9_arg0:GetEventRequest(1)
    if f9_local7 == 10 then
        f9_local2 = 9999
        f9_local3 = 0
    end
    Approach_Act_Flex(f9_arg0, f9_arg1, f9_local0, f9_local1, f9_local2, f9_local3, f9_local4, f9_local5, f9_local6)
    local f9_local8 = 0
    local f9_local9 = 0
    f9_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 10, 3009, TARGET_ENE_0, 9999, f9_local8, f9_local9, 0, 0)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act08 = function (f10_arg0, f10_arg1, f10_arg2)
    local f10_local0 = 3.2 - f10_arg0:GetMapHitRadius(TARGET_SELF)
    local f10_local1 = 3.2 - f10_arg0:GetMapHitRadius(TARGET_SELF) + 2
    local f10_local2 = 3.2 - f10_arg0:GetMapHitRadius(TARGET_SELF) + 2
    local f10_local3 = 100
    local f10_local4 = 0
    local f10_local5 = 1.5
    local f10_local6 = 3
    local f10_local7 = 0
    local f10_local8 = 0
    f10_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 10, 3011, TARGET_ENE_0, 9999, f10_local7, f10_local8, 0, 0)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act09 = function (f11_arg0, f11_arg1, f11_arg2)
    local f11_local0 = 7.2 - f11_arg0:GetMapHitRadius(TARGET_SELF)
    local f11_local1 = 7.2 - f11_arg0:GetMapHitRadius(TARGET_SELF) + 2
    local f11_local2 = 7.2 - f11_arg0:GetMapHitRadius(TARGET_SELF) + 2
    local f11_local3 = 100
    local f11_local4 = 0
    local f11_local5 = 1.5
    local f11_local6 = 3
    Approach_Act_Flex(f11_arg0, f11_arg1, f11_local0, f11_local1, f11_local2, f11_local3, f11_local4, f11_local5, f11_local6)
    local f11_local7 = 0
    local f11_local8 = 0
    f11_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 10, 3015, TARGET_ENE_0, 9999, f11_local7, f11_local8, 0, 0)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act10 = function (f12_arg0, f12_arg1, f12_arg2)
    local f12_local0 = 20 - f12_arg0:GetMapHitRadius(TARGET_SELF)
    local f12_local1 = 20 - f12_arg0:GetMapHitRadius(TARGET_SELF) + 2
    local f12_local2 = 20 - f12_arg0:GetMapHitRadius(TARGET_SELF) + 2
    local f12_local3 = 100
    local f12_local4 = 0
    local f12_local5 = 1.5
    local f12_local6 = 3
    Approach_Act_Flex(f12_arg0, f12_arg1, f12_local0, f12_local1, f12_local2, f12_local3, f12_local4, f12_local5, f12_local6)
    local f12_local7 = 0
    local f12_local8 = 0
    f12_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 10, 3012, TARGET_ENE_0, 9999, f12_local7, f12_local8, 0, 0)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act11 = function (f13_arg0, f13_arg1, f13_arg2)
    local f13_local0 = 20 - f13_arg0:GetMapHitRadius(TARGET_SELF)
    local f13_local1 = 20 - f13_arg0:GetMapHitRadius(TARGET_SELF) + 2
    local f13_local2 = 20 - f13_arg0:GetMapHitRadius(TARGET_SELF) + 2
    local f13_local3 = 100
    local f13_local4 = 0
    local f13_local5 = 1.5
    local f13_local6 = 3
    Approach_Act_Flex(f13_arg0, f13_arg1, f13_local0, f13_local1, f13_local2, f13_local3, f13_local4, f13_local5, f13_local6)
    local f13_local7 = 0
    local f13_local8 = 0
    f13_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 10, 3013, TARGET_ENE_0, 9999, f13_local7, f13_local8, 0, 0)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act12 = function (f14_arg0, f14_arg1, f14_arg2)
    local f14_local0 = 10.1 - f14_arg0:GetMapHitRadius(TARGET_SELF)
    local f14_local1 = 10.1 - f14_arg0:GetMapHitRadius(TARGET_SELF) + 2
    local f14_local2 = 10.1 - f14_arg0:GetMapHitRadius(TARGET_SELF) + 2
    local f14_local3 = 100
    local f14_local4 = 0
    local f14_local5 = 1.5
    local f14_local6 = 3
    local f14_local7 = 3
    local f14_local8 = 0
    local f14_local9 = 0
    f14_arg0:SetEventMoveTarget(1702821)
    f14_arg1:AddSubGoal(GOAL_COMMON_ApproachTarget, f14_local7, POINT_EVENT, 1, TARGET_SELF, false, -1)
    f14_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 20, 3007, TARGET_ENE_0, 9999, f14_local8, f14_local9, 0, 0)
    f14_arg0:SetTimer(6, 50)
    f14_arg0:SetNumber(5, 1)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act30 = function (f15_arg0, f15_arg1, f15_arg2)
    local f15_local0 = 3
    local f15_local1 = 8
    f15_arg1:AddSubGoal(GOAL_COMMON_ApproachTarget, f15_local0, TARGET_EVENT, f15_local1, TARGET_SELF, false, -1)
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
    
end

Goal.Act40 = function (f16_arg0, f16_arg1, f16_arg2)
    local f16_local0 = 7.2 - f16_arg0:GetMapHitRadius(TARGET_SELF)
    local f16_local1 = 7.2 - f16_arg0:GetMapHitRadius(TARGET_SELF) + 2
    local f16_local2 = 7.2 - f16_arg0:GetMapHitRadius(TARGET_SELF) + 2
    local f16_local3 = 100
    local f16_local4 = 0
    local f16_local5 = 1.5
    local f16_local6 = 3
    Approach_Act_Flex(f16_arg0, f16_arg1, f16_local0, f16_local1, f16_local2, f16_local3, f16_local4, f16_local5, f16_local6)
    local f16_local7 = 0
    local f16_local8 = 0
    f16_arg1:AddSubGoal(GOAL_COMMON_ComboAttackTunableSpin, 10, 3015, TARGET_ENE_0, 9999, f16_local7, f16_local8, 0, 0)
    f16_arg1:AddSubGoal(GOAL_COMMON_ComboRepeat, 10, 3016, TARGET_ENE_0, 9999, f16_local7, f16_local8, 0, 0)
    f16_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3067, TARGET_ENE_0, 9999, 0, 0)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act41 = function (f17_arg0, f17_arg1, f17_arg2)
    local f17_local0 = 7.2 - f17_arg0:GetMapHitRadius(TARGET_SELF)
    local f17_local1 = 7.2 - f17_arg0:GetMapHitRadius(TARGET_SELF) + 2
    local f17_local2 = 7.2 - f17_arg0:GetMapHitRadius(TARGET_SELF) + 2
    local f17_local3 = 100
    local f17_local4 = 0
    local f17_local5 = 1.5
    local f17_local6 = 3
    Approach_Act_Flex(f17_arg0, f17_arg1, f17_local0, f17_local1, f17_local2, f17_local3, f17_local4, f17_local5, f17_local6)
    local f17_local7 = 0
    local f17_local8 = 0
    f17_arg1:AddSubGoal(GOAL_COMMON_ComboAttackTunableSpin, 10, 3005, TARGET_ENE_0, 9999, f17_local7, f17_local8, 0, 0)
    f17_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3067, TARGET_ENE_0, 9999, 0, 0)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act21 = function (f18_arg0, f18_arg1, f18_arg2)
    local f18_local0 = 3
    local f18_local1 = 45
    f18_arg1:AddSubGoal(GOAL_COMMON_Turn, f18_local0, TARGET_ENE_0, f18_local1, -1, GOAL_RESULT_Success, true)
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
    
end

Goal.Act22 = function (f19_arg0, f19_arg1, f19_arg2)
    local f19_local0 = 3
    local f19_local1 = 0
    local f19_local2 = 5202
    if SpaceCheck(f19_arg0, f19_arg1, -45, 2) == true then
        if SpaceCheck(f19_arg0, f19_arg1, 45, 2) == true then
            if f19_arg0:IsInsideTarget(TARGET_ENE_0, AI_DIR_TYPE_R, 180) then
                f19_local2 = 5202
            else
                f19_local2 = 5203
            end
        else
            f19_local2 = 5202
        end
    elseif SpaceCheck(f19_arg0, f19_arg1, 45, 2) == true then
        f19_local2 = 5203
    else
    end
    f19_arg0:SetTimer(0, 8)
    f19_arg1:AddSubGoal(GOAL_COMMON_SpinStep, f19_local0, f19_local2, TARGET_ENE_0, f19_local1, AI_DIR_TYPE_R, 0)
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
    
end

Goal.Act23 = function (f20_arg0, f20_arg1, f20_arg2)
    local f20_local0 = f20_arg0:GetDist(TARGET_ENE_0)
    local f20_local1 = f20_arg0:GetSp(TARGET_SELF)
    local f20_local2 = 20
    local f20_local3 = f20_arg0:GetRandam_Int(1, 100)
    local f20_local4 = -1
    local f20_local5 = 0
    if SpaceCheck(f20_arg0, f20_arg1, -90, 1) == true then
        if SpaceCheck(f20_arg0, f20_arg1, 90, 1) == true then
            if f20_arg0:IsInsideTargetEx(TARGET_ENE_0, TARGET_SELF, AI_DIR_TYPE_R, 180, 999) then
                f20_local5 = 1
            else
                f20_local5 = 0
            end
        else
            f20_local5 = 0
        end
    elseif SpaceCheck(f20_arg0, f20_arg1, 90, 1) == true then
        f20_local5 = 1
    else
    end
    local f20_local6 = 3
    local f20_local7 = f20_arg0:GetRandam_Int(30, 45)
    f20_arg0:SetNumber(10, f20_local5)
    f20_arg1:AddSubGoal(GOAL_COMMON_SidewayMove, f20_local6, TARGET_ENE_0, f20_local5, f20_local7, true, true, f20_local4)
    if f20_arg0:GetNumber(1) == 1 then
        f20_arg0:AddObserveArea(0, TARGET_SELF, TARGET_ENE_0, AI_DIR_TYPE_F, 180, 5)
    end
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act24 = function (f21_arg0, f21_arg1, f21_arg2)
    local f21_local0 = f21_arg0:GetDist(TARGET_ENE_0)
    local f21_local1 = 10
    local f21_local2 = 0
    local f21_local3 = 5211
    f21_arg1:AddSubGoal(GOAL_COMMON_SpinStep, f21_local1, f21_local3, TARGET_ENE_0, f21_local2, AI_DIR_TYPE_B, 0)
    f21_arg0:SetTimer(1, 8)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act25 = function (f22_arg0, f22_arg1, f22_arg2)
    local f22_local0 = f22_arg0:GetRandam_Float(2, 4)
    local f22_local1 = f22_arg0:GetRandam_Float(5, 7)
    local f22_local2 = f22_arg0:GetDist(TARGET_ENE_0)
    local f22_local3 = -1
    f22_arg1:AddSubGoal(GOAL_COMMON_LeaveTarget, f22_local0, TARGET_ENE_0, f22_local1, TARGET_ENE_0, true, f22_local3)
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
    
end

Goal.Act26 = function (f23_arg0, f23_arg1, f23_arg2)
    f23_arg1:AddSubGoal(GOAL_COMMON_Wait, 0.5, TARGET_SELF, 0, 0, 0)
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
    
end

Goal.Act27 = function (f24_arg0, f24_arg1, f24_arg2)
    local f24_local0 = f24_arg0:GetDist(TARGET_ENE_0)
    local f24_local1 = f24_arg0:GetRandam_Int(1, 100)
    local f24_local2 = 15
    local f24_local3 = 10
    local f24_local4 = f24_arg0:GetRandam_Float(2, 4)
    local f24_local5 = f24_arg0:GetRandam_Int(30, 45)
    local f24_local6 = f24_arg0:GetRandam_Float(3, 5)
    local f24_local7 = 3
    local f24_local8 = 0
    local f24_local9 = 3
    if f24_local2 <= f24_local0 then
        f24_arg1:AddSubGoal(GOAL_COMMON_ApproachTarget, f24_local4, TARGET_ENE_0, f24_local2, TARGET_ENE_0, true, -1)
    elseif f24_local0 <= f24_local3 then
        f24_arg1:AddSubGoal(GOAL_COMMON_SpinStep, f24_local7, 5211, TARGET_ENE_0, f24_local8, AI_DIR_TYPE_B, f24_local9)
    end
    f24_arg1:AddSubGoal(GOAL_COMMON_SidewayMove, f24_local4, TARGET_ENE_0, f24_arg0:GetRandam_Int(0, 1), f24_local5, true, true, -1)
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
    
end

Goal.Act28 = function (f25_arg0, f25_arg1, f25_arg2)
    local f25_local0 = f25_arg0:GetDist(TARGET_ENE_0)
    local f25_local1 = 1.5
    local f25_local2 = 1.5
    local f25_local3 = f25_arg0:GetRandam_Int(30, 45)
    local f25_local4 = -1
    local f25_local5 = f25_arg0:GetRandam_Int(0, 1)
    if f25_local0 <= 3 then
        f25_arg1:AddSubGoal(GOAL_COMMON_SidewayMove, f25_local1, TARGET_ENE_0, f25_local5, f25_local3, true, true, f25_local4)
    elseif f25_local0 <= 8 then
        f25_arg1:AddSubGoal(GOAL_COMMON_ApproachTarget, f25_local2, TARGET_ENE_0, 3, TARGET_SELF, true, -1)
    else
        f25_arg1:AddSubGoal(GOAL_COMMON_ApproachTarget, f25_local2, TARGET_ENE_0, 8, TARGET_SELF, false, -1)
    end
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
    
end

Goal.Interrupt = function (f26_arg0, f26_arg1, f26_arg2)
    local f26_local0 = f26_arg1:GetSpecialEffectActivateInterruptType(0)
    local f26_local1 = f26_arg1:GetDist(TARGET_ENE_0)
    if f26_arg1:IsLadderAct(TARGET_SELF) then
        return false
    end
    if not f26_arg1:HasSpecialEffectId(TARGET_SELF, 200004) then
        return false
    end
    if Interupt_PC_Break(f26_arg1) then
        f26_arg1:Replanning()
        return true
    end
    if f26_arg1:IsInterupt(INTERUPT_ActivateSpecialEffect) then
        if f26_local0 == 5028 then
            if f26_local1 <= 3 then
                f26_arg2:ClearSubGoal()
                f26_arg2:AddSubGoal(GOAL_COMMON_EndureAttack, 3, 3016, TARGET_ENE_0, 9999, 0)
                return true
            end
        elseif f26_arg1:GetSpecialEffectActivateInterruptType(0) == 3510900 and f26_arg1:GetNumber(1) == 0 then
            f26_arg1:SetNumber(1, 1)
            f26_arg1:SetTimer(5, 14)
            return true
        elseif f26_arg1:GetSpecialEffectActivateInterruptType(0) == 3510901 and f26_arg1:GetNumber(1) == 1 then
            f26_arg1:SetNumber(1, 0)
            f26_arg2:ClearSubGoal()
            f26_arg1:Replanning()
            return true
        end
    end
    if f26_arg1:IsInterupt(INTERUPT_Inside_ObserveArea) and f26_arg1:IsInsideObserve(0) then
        f26_arg1:DeleteObserve(0)
        f26_arg2:ClearSubGoal()
        f26_arg1:Replanning()
        return true
    end
    if Interupt_Use_Item(f26_arg1, 2, 5) then
        if f26_local1 <= 20 - f26_arg1:GetMapHitRadius(TARGET_SELF) then
            f26_arg2:ClearSubGoal()
            f26_arg2:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 3, 3012, TARGET_ENE_0, 9999, 0, 0, 0, 0)
            return true
        else
            f26_arg1:Replanning()
            return true
        end
    end
    return false
    
end

Goal.Parry = function (f27_arg0, f27_arg1, f27_arg2)
    local f27_local0 = f27_arg0:GetHpRate(TARGET_SELF)
    local f27_local1 = f27_arg0:GetDist(TARGET_ENE_0)
    local f27_local2 = f27_arg0:GetSp(TARGET_SELF)
    local f27_local3 = f27_arg0:GetRandam_Int(1, 100)
    local f27_local4 = 0
    if not f27_arg0:IsInsideTarget(TARGET_ENE_0, AI_DIR_TYPE_F, 90) or not f27_arg0:IsInsideTargetEx(TARGET_ENE_0, TARGET_SELF, AI_DIR_TYPE_F, 90, 3) or f27_arg0:HasSpecialEffectId(TARGET_ENE_0, 109012) then
    elseif f27_arg0:IsTargetGuard(TARGET_SELF) then
        if f27_arg0:HasSpecialEffectId(TARGET_ENE_0, 109970) then
        else
            f27_arg1:ClearSubGoal()
            f27_arg1:AddSubGoal(GOAL_COMMON_EndureAttack, 0.1, 3100, TARGET_ENE_0, 9999, 0)
            return true
        end
    elseif f27_arg0:HasSpecialEffectId(TARGET_ENE_0, 109970) then
        f27_arg1:ClearSubGoal()
        f27_arg1:AddSubGoal(GOAL_COMMON_EndureAttack, 0.1, 3101, TARGET_ENE_0, 9999, 0)
        return true
    else
        f27_arg1:ClearSubGoal()
        f27_arg1:AddSubGoal(GOAL_COMMON_EndureAttack, 0.1, 3100, TARGET_ENE_0, 9999, 0)
        return true
    end
    return false
    
end

Goal.Damaged = function (f28_arg0, f28_arg1, f28_arg2)
    local f28_local0 = 3
    if SpaceCheck(f28_arg0, f28_arg1, 180, 2) then
        f28_arg1:ClearSubGoal()
        f28_arg1:AddSubGoal(GOAL_COMMON_SpinStep, f28_local0, 5201, TARGET_ENE_0, 0, AI_DIR_TYPE_B, 0)
        return true
    end
    return false
    
end

Goal.Kengeki_Activate = function (f29_arg0, f29_arg1, f29_arg2)
    local f29_local0 = ReturnKengekiSpecialEffect(f29_arg1)
    if f29_local0 == 0 then
        return false
    end
    local f29_local1 = {}
    local f29_local2 = {}
    local f29_local3 = {}
    Common_Clear_Param(f29_local1, f29_local2, f29_local3)
    local f29_local4 = f29_arg1:GetDist(TARGET_ENE_0)
    local f29_local5 = f29_arg1:GetSp(TARGET_SELF)
    local f29_local6 = f29_arg1:GetEventRequest(1)
    f29_arg1:SetNumber(0, f29_arg1:GetNumber(0) + 1)
    if f29_local0 == 200200 or f29_local0 == 200300 then
        if f29_local6 == 10 then
            f29_local1[10] = 100
        elseif f29_arg1:GetNumber(0) >= 2 then
            f29_local1[4] = 100
        elseif f29_local4 >= 3 then
            f29_local1[1] = 0
            f29_local1[2] = 100
            f29_local1[4] = 0
            f29_local1[11] = 50
        elseif f29_local4 >= 1 then
            f29_local1[1] = 100
            f29_local1[2] = 0
            f29_local1[4] = 0
            f29_local1[11] = 200
        else
            f29_local1[1] = 0
            f29_local1[2] = 0
            f29_local1[4] = 0
            f29_local1[3] = 100
            f29_local1[10] = 50
            f29_local1[11] = 200
        end
    elseif f29_local0 == 200201 or f29_local0 == 200301 then
        if f29_local6 == 10 then
            f29_local1[50] = 100
        elseif f29_arg1:GetNumber(0) >= 2 then
            f29_local1[7] = 100
        elseif f29_local4 >= 1 then
            f29_local1[5] = 100
            f29_local1[6] = 50
            f29_local1[7] = 0
            f29_local1[8] = 50
        else
            f29_local1[5] = 0
            f29_local1[6] = 50
            f29_local1[7] = 0
            f29_local1[8] = 0
            f29_local1[9] = 100
        end
    else
        f29_local1[50] = 100
    end
    f29_local1[1] = SetCoolTime(f29_arg1, f29_arg2, 3060, 8, f29_local1[1], 1)
    f29_local1[2] = SetCoolTime(f29_arg1, f29_arg2, 3061, 8, f29_local1[2], 1)
    f29_local1[3] = SetCoolTime(f29_arg1, f29_arg2, 3062, 8, f29_local1[3], 1)
    f29_local1[4] = SetCoolTime(f29_arg1, f29_arg2, 3063, 8, f29_local1[4], 1)
    f29_local1[5] = SetCoolTime(f29_arg1, f29_arg2, 3065, 8, f29_local1[5], 1)
    f29_local1[6] = SetCoolTime(f29_arg1, f29_arg2, 3066, 8, f29_local1[6], 1)
    f29_local1[6] = SetCoolTime(f29_arg1, f29_arg2, 3015, 8, f29_local1[6], 1)
    f29_local1[7] = SetCoolTime(f29_arg1, f29_arg2, 3067, 8, f29_local1[7], 1)
    f29_local1[8] = SetCoolTime(f29_arg1, f29_arg2, 3068, 8, f29_local1[8], 1)
    f29_local1[9] = SetCoolTime(f29_arg1, f29_arg2, 3069, 8, f29_local1[9], 1)
    f29_local1[11] = SetCoolTime(f29_arg1, f29_arg2, 3050, 25, f29_local1[11], 0)
    f29_local1[11] = SetCoolTime(f29_arg1, f29_arg2, 3007, 25, f29_local1[11], 0)
    f29_local2[1] = REGIST_FUNC(f29_arg1, f29_arg2, f29_arg0.Kengeki01)
    f29_local2[2] = REGIST_FUNC(f29_arg1, f29_arg2, f29_arg0.Kengeki02)
    f29_local2[3] = REGIST_FUNC(f29_arg1, f29_arg2, f29_arg0.Kengeki03)
    f29_local2[4] = REGIST_FUNC(f29_arg1, f29_arg2, f29_arg0.Kengeki04)
    f29_local2[5] = REGIST_FUNC(f29_arg1, f29_arg2, f29_arg0.Kengeki05)
    f29_local2[6] = REGIST_FUNC(f29_arg1, f29_arg2, f29_arg0.Kengeki06)
    f29_local2[7] = REGIST_FUNC(f29_arg1, f29_arg2, f29_arg0.Kengeki07)
    f29_local2[8] = REGIST_FUNC(f29_arg1, f29_arg2, f29_arg0.Kengeki08)
    f29_local2[9] = REGIST_FUNC(f29_arg1, f29_arg2, f29_arg0.Kengeki09)
    f29_local2[10] = REGIST_FUNC(f29_arg1, f29_arg2, f29_arg0.Kengeki10)
    f29_local2[11] = REGIST_FUNC(f29_arg1, f29_arg2, f29_arg0.Kengeki11)
    f29_local2[50] = REGIST_FUNC(f29_arg1, f29_arg2, f29_arg0.NoAction)
    local f29_local7 = REGIST_FUNC(f29_arg1, f29_arg2, f29_arg0.ActAfter_AdjustSpace)
    Common_Kengeki_Activate(f29_arg1, f29_arg2, f29_local1, f29_local2, f29_local7, f29_local3)
    
end

Goal.Kengeki01 = function (f30_arg0, f30_arg1, f30_arg2)
    f30_arg1:ClearSubGoal()
    f30_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3060, TARGET_ENE_0, 9999, 0, 0)
    
end

Goal.Kengeki02 = function (f31_arg0, f31_arg1, f31_arg2)
    f31_arg1:ClearSubGoal()
    f31_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3061, TARGET_ENE_0, 9999, 0, 0)
    
end

Goal.Kengeki03 = function (f32_arg0, f32_arg1, f32_arg2)
    f32_arg1:ClearSubGoal()
    f32_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3062, TARGET_ENE_0, 9999, 0, 0)
    
end

Goal.Kengeki04 = function (f33_arg0, f33_arg1, f33_arg2)
    f33_arg1:ClearSubGoal()
    f33_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3063, TARGET_ENE_0, 9999, 0, 0)
    f33_arg0:SetNumber(0, 0)
    
end

Goal.Kengeki05 = function (f34_arg0, f34_arg1, f34_arg2)
    f34_arg1:ClearSubGoal()
    f34_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3065, TARGET_ENE_0, 9999, 0, 0)
    
end

Goal.Kengeki06 = function (f35_arg0, f35_arg1, f35_arg2)
    f35_arg1:ClearSubGoal()
    f35_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3066, TARGET_ENE_0, 9999, 0, 0)
    
end

Goal.Kengeki07 = function (f36_arg0, f36_arg1, f36_arg2)
    f36_arg1:ClearSubGoal()
    f36_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3067, TARGET_ENE_0, 9999, 0, 0)
    f36_arg0:SetNumber(0, 0)
    
end

Goal.Kengeki08 = function (f37_arg0, f37_arg1, f37_arg2)
    f37_arg1:ClearSubGoal()
    f37_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3068, TARGET_ENE_0, 9999, 0, 0)
    
end

Goal.Kengeki09 = function (f38_arg0, f38_arg1, f38_arg2)
    f38_arg1:ClearSubGoal()
    f38_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3069, TARGET_ENE_0, 9999, 0, 0)
    
end

Goal.Kengeki10 = function (f39_arg0, f39_arg1, f39_arg2)
    f39_arg1:ClearSubGoal()
    f39_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3064, TARGET_ENE_0, 9999, 0, 0)
    
end

Goal.Kengeki11 = function (f40_arg0, f40_arg1, f40_arg2)
    f40_arg1:ClearSubGoal()
    f40_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 20, 3050, TARGET_ENE_0, 9999, 0, 0)
    f40_arg0:SetTimer(6, 50)
    f40_arg0:SetNumber(5, 1)
    
end

Goal.NoAction = function (f41_arg0, f41_arg1, f41_arg2)
    return -1
    
end

Goal.ActAfter_AdjustSpace = function (f42_arg0, f42_arg1, f42_arg2)
    
end

Goal.Update = function (f43_arg0, f43_arg1, f43_arg2)
    return Update_Default_NoSubGoal(f43_arg0, f43_arg1, f43_arg2)
    
end

Goal.Terminate = function (f44_arg0, f44_arg1, f44_arg2)
    
end


