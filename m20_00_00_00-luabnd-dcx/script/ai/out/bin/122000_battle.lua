RegisterTableGoal(GOAL_Terakisozako_kobushi_122000_Battle, "GOAL_Terakisozako_kobushi_122000_Battle")
REGISTER_GOAL_NO_UPDATE(GOAL_Terakisozako_kobushi_122000_Battle_Battle, true)

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
    local f2_local9 = f2_arg1:GetNpcThinkParamID()
    local f2_local10 = f2_arg1:GetDistYSigned(TARGET_ENE_0)
    f2_arg1:AddObserveSpecialEffectAttribute(TARGET_SELF, 5025)
    f2_arg1:AddObserveSpecialEffectAttribute(TARGET_SELF, 5026)
    f2_arg1:AddObserveSpecialEffectAttribute(TARGET_SELF, 3122000)
    f2_arg1:AddObserveSpecialEffectAttribute(TARGET_ENE_0, 3122010)
    f2_arg1:AddObserveSpecialEffectAttribute(TARGET_SELF, 3122020)
    f2_arg1:AddObserveSpecialEffectAttribute(TARGET_ENE_0, 3122030)
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
            if f2_arg1:HasSpecialEffectId(TARGET_SELF, 3122200) then
                f2_local0[41] = 100
                f2_local0[23] = 100
                f2_local0[26] = 10
            else
                f2_local0[3] = 100
                f2_local0[27] = 50
            end
        elseif f2_local7 == REACH_ATTACK_TARGET_HIGH_POSITION then
            if f2_arg1:HasSpecialEffectId(TARGET_SELF, 3122200) then
                f2_local0[1] = 20
                f2_local0[41] = 100
            else
                f2_local0[1] = 100
                f2_local0[7] = 200
                f2_local0[27] = 100
            end
        elseif f2_local7 == REACH_ATTACK_TARGET_LOW_POSITION then
            if f2_arg1:HasSpecialEffectId(TARGET_SELF, 3122200) then
                f2_local0[1] = 20
                f2_local0[41] = 100
            else
                f2_local0[1] = 100
                f2_local0[27] = 100
            end
        else
            f2_local0[27] = 100
        end
    elseif f2_local6 == 1 and f2_arg1:GetTeamOrder(ORDER_TYPE_Role) == ROLE_TYPE_Kankyaku then
        if f2_arg1:HasSpecialEffectId(TARGET_SELF, 3122200) then
            f2_local0[41] = 1000
            f2_local0[23] = 100
            f2_local0[26] = 10
        else
            KankyakuAct(f2_arg1, f2_arg2)
        end
    elseif f2_local6 == 1 and f2_arg1:GetTeamOrder(ORDER_TYPE_Role) == ROLE_TYPE_Torimaki then
        if f2_arg1:HasSpecialEffectId(TARGET_SELF, 3122200) then
            f2_local0[41] = 1000
            f2_local0[23] = 100
            f2_local0[26] = 10
        elseif f2_local5 > 5 then
            f2_local0[7] = 10
            f2_local0[28] = 100
            f2_local0[45] = 10
        else
            f2_local0[2] = 10
            f2_local0[45] = 10
            f2_local0[28] = 100
        end
    elseif f2_arg1:IsInsideTarget(TARGET_ENE_0, AI_DIR_TYPE_B, 90) then
        f2_local0[21] = 100
    elseif f2_arg1:HasSpecialEffectId(TARGET_SELF, 3122200) then
        if f2_local5 > 3 then
            f2_local0[41] = 1000
            f2_local0[23] = 100
            f2_local0[26] = 10
        else
            f2_local0[23] = 50
            f2_local0[24] = 100
            f2_local0[25] = 100
            f2_local0[1] = 1
        end
    elseif f2_arg1:GetNumber(1) == 1 then
        f2_local0[10] = 1
        f2_local0[23] = 100
    elseif f2_local5 >= 5 then
        f2_local0[1] = 0
        f2_local0[2] = 0
        f2_local0[4] = 100
        f2_local0[6] = 200
        f2_local0[7] = 100
        f2_local0[23] = 0
        f2_local0[10] = 200
    elseif f2_local5 >= 3 then
        f2_local0[1] = 100
        f2_local0[2] = 100
        f2_local0[4] = 200
        f2_local0[6] = 0
        f2_local0[7] = 200
        f2_local0[10] = 0
    else
        f2_local0[1] = 100
        f2_local0[2] = 100
        f2_local0[4] = 0
        f2_local0[6] = 0
        f2_local0[7] = 0
        f2_local0[24] = 0
    end
    if f2_arg1:GetNumber(2) >= 3 then
        f2_local0[24] = f2_local0[24] + 1000
    elseif f2_arg1:GetNumber(2) >= 2 then
        f2_local0[24] = f2_local0[24] + 100
    end
    if f2_arg1:HasSpecialEffectId(TARGET_SELF, 3122040) then
        f2_local0[45] = 0
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
    if f2_arg1:HasSpecialEffectId(TARGET_SELF, 3122200) and f2_local5 >= 50 then
        f2_local0[41] = 0
    end
    f2_local0[1] = SetCoolTime(f2_arg1, f2_arg2, 3005, 8, f2_local0[1], 1)
    f2_local0[2] = SetCoolTime(f2_arg1, f2_arg2, 3001, 8, f2_local0[2], 1)
    f2_local0[3] = SetCoolTime(f2_arg1, f2_arg2, 3002, 4, f2_local0[3], 1)
    f2_local0[4] = SetCoolTime(f2_arg1, f2_arg2, 3008, 8, f2_local0[4], 1)
    f2_local0[6] = SetCoolTime(f2_arg1, f2_arg2, 3011, 8, f2_local0[6], 1)
    f2_local0[7] = SetCoolTime(f2_arg1, f2_arg2, 3013, 8, f2_local0[7], 1)
    f2_local0[10] = SetCoolTime(f2_arg1, f2_arg2, 3010, 8, f2_local0[10], 1)
    f2_local0[41] = SetCoolTime(f2_arg1, f2_arg2, 3035, 3, f2_local0[41], 1)
    f2_local1[1] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act01)
    f2_local1[2] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act02)
    f2_local1[3] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act03)
    f2_local1[4] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act04)
    f2_local1[5] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act05)
    f2_local1[6] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act06)
    f2_local1[7] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act07)
    f2_local1[10] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act10)
    f2_local1[15] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act15)
    f2_local1[30] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act30)
    f2_local1[31] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act31)
    f2_local1[32] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act32)
    f2_local1[35] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act35)
    f2_local1[40] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act40)
    f2_local1[41] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act41)
    f2_local1[45] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act45)
    f2_local1[21] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act21)
    f2_local1[23] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act23)
    f2_local1[24] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act24)
    f2_local1[25] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act25)
    f2_local1[26] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act26)
    f2_local1[27] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act27)
    f2_local1[28] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act28)
    local f2_local11 = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.ActAfter_AdjustSpace)
    Common_Battle_Activate(f2_arg1, f2_arg2, f2_local0, f2_local1, f2_local11, f2_local2)
    
end

Goal.Act01 = function (f3_arg0, f3_arg1, f3_arg2)
    local f3_local0 = f3_arg0:GetDist(TARGET_ENE_0)
    local f3_local1 = 3.8 - f3_arg0:GetMapHitRadius(TARGET_SELF)
    local f3_local2 = 3.8 - f3_arg0:GetMapHitRadius(TARGET_SELF) + 0
    local f3_local3 = 3.8 - f3_arg0:GetMapHitRadius(TARGET_SELF) + 2
    local f3_local4 = 100
    local f3_local5 = 0
    local f3_local6 = 1.5
    local f3_local7 = 3
    local f3_local8 = f3_arg0:GetRandam_Int(1, 100)
    local f3_local9 = 0
    if f3_local1 <= f3_local0 then
        Approach_Act_Flex(f3_arg0, f3_arg1, f3_local1, f3_local2, f3_local3, f3_local4, f3_local5, f3_local6, f3_local7)
    end
    local f3_local10 = 3005
    local f3_local11 = 3006
    local f3_local12 = 3007
    local f3_local13 = 3010
    local f3_local14 = 2.5 - f3_arg0:GetMapHitRadius(TARGET_SELF)
    local f3_local15 = 1.7 - f3_arg0:GetMapHitRadius(TARGET_SELF)
    local f3_local16 = 1.5 - f3_arg0:GetMapHitRadius(TARGET_SELF)
    local f3_local17 = 0
    f3_arg1:AddSubGoal(GOAL_COMMON_ComboAttackTunableSpin, 10, f3_local10, TARGET_ENE_0, f3_local14, f3_local9, f3_local17, 0, 0)
    f3_arg1:AddSubGoal(GOAL_COMMON_ComboRepeat, 10, f3_local11, TARGET_ENE_0, f3_local15, 0)
    f3_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, f3_local12, TARGET_ENE_0, 9999, 0, 0)
    f3_arg0:SetNumber(2, f3_arg0:GetNumber(2) + 1)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act02 = function (f4_arg0, f4_arg1, f4_arg2)
    local f4_local0 = f4_arg0:GetDist(TARGET_ENE_0)
    local f4_local1 = 4.4 - f4_arg0:GetMapHitRadius(TARGET_SELF)
    local f4_local2 = 4.4 - f4_arg0:GetMapHitRadius(TARGET_SELF) + 0
    local f4_local3 = 4.4 - f4_arg0:GetMapHitRadius(TARGET_SELF) + 2
    local f4_local4 = 100
    local f4_local5 = 0
    local f4_local6 = 1.5
    local f4_local7 = 3
    local f4_local8 = 0
    if f4_local1 <= f4_local0 then
        Approach_Act_Flex(f4_arg0, f4_arg1, f4_local1, f4_local2, f4_local3, f4_local4, f4_local5, f4_local6, f4_local7)
    end
    local f4_local9 = 3001
    local f4_local10 = 0
    f4_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 10, f4_local9, TARGET_ENE_0, 9999, f4_local8, f4_local10, 0, 0)
    f4_arg0:SetNumber(2, f4_arg0:GetNumber(2) + 1)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act03 = function (f5_arg0, f5_arg1, f5_arg2)
    local f5_local0 = 15 - f5_arg0:GetMapHitRadius(TARGET_SELF)
    local f5_local1 = 15 - f5_arg0:GetMapHitRadius(TARGET_SELF) + 0
    local f5_local2 = 15 - f5_arg0:GetMapHitRadius(TARGET_SELF) + 2
    local f5_local3 = 100
    local f5_local4 = 0
    local f5_local5 = 1.5
    local f5_local6 = 3
    Approach_Act_Flex(f5_arg0, f5_arg1, f5_local0, f5_local1, f5_local2, f5_local3, f5_local4, f5_local5, f5_local6)
    local f5_local7 = 3002
    local f5_local8 = 0
    local f5_local9 = 0
    f5_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 10, f5_local7, TARGET_ENE_0, 9999, f5_local8, f5_local9, 0, 0)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act04 = function (f6_arg0, f6_arg1, f6_arg2)
    local f6_local0 = f6_arg0:GetDist(TARGET_ENE_0)
    local f6_local1 = 4.6 - f6_arg0:GetMapHitRadius(TARGET_SELF)
    local f6_local2 = 4.6 - f6_arg0:GetMapHitRadius(TARGET_SELF) + 0
    local f6_local3 = 4.6 - f6_arg0:GetMapHitRadius(TARGET_SELF) + 2
    local f6_local4 = 100
    local f6_local5 = 0
    local f6_local6 = 1.5
    local f6_local7 = 3
    local f6_local8 = f6_arg0:GetRandam_Int(1, 100)
    Approach_Act_Flex(f6_arg0, f6_arg1, f6_local1, f6_local2, f6_local3, f6_local4, f6_local5, f6_local6, f6_local7)
    local f6_local9 = 3008
    local f6_local10 = 3009
    local f6_local11 = 2.2 - f6_arg0:GetMapHitRadius(TARGET_SELF)
    local f6_local12 = 0
    local f6_local13 = 0
    f6_arg1:AddSubGoal(GOAL_COMMON_ComboAttackTunableSpin, 10, f6_local9, TARGET_ENE_0, f6_local11, f6_local12, f6_local13, 0, 0)
    f6_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, f6_local10, TARGET_ENE_0, 9999, 0, 0)
    f6_arg0:SetNumber(0, 1)
    f6_arg0:SetNumber(2, f6_arg0:GetNumber(2) + 1)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act06 = function (f7_arg0, f7_arg1, f7_arg2)
    local f7_local0 = f7_arg0:GetDist(TARGET_ENE_0)
    local f7_local1 = 4.6 - f7_arg0:GetMapHitRadius(TARGET_SELF)
    local f7_local2 = 4.6 - f7_arg0:GetMapHitRadius(TARGET_SELF) + 0
    local f7_local3 = 4.6 - f7_arg0:GetMapHitRadius(TARGET_SELF) + 2
    local f7_local4 = 100
    local f7_local5 = 0
    local f7_local6 = 1.5
    local f7_local7 = 3
    local f7_local8 = f7_arg0:GetRandam_Int(1, 100)
    Approach_Act_Flex(f7_arg0, f7_arg1, f7_local1, f7_local2, f7_local3, f7_local4, f7_local5, f7_local6, f7_local7)
    local f7_local9 = 3011
    local f7_local10 = 0
    local f7_local11 = 0
    f7_arg1:AddSubGoal(GOAL_COMMON_ComboAttackTunableSpin, 10, f7_local9, TARGET_ENE_0, DistToAtt1, f7_local10, f7_local11, 0, 0)
    f7_arg0:SetNumber(2, f7_arg0:GetNumber(2) + 1)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act07 = function (f8_arg0, f8_arg1, f8_arg2)
    local f8_local0 = 5.2 - f8_arg0:GetMapHitRadius(TARGET_SELF)
    local f8_local1 = 5.2 - f8_arg0:GetMapHitRadius(TARGET_SELF) + 0
    local f8_local2 = 5.2 - f8_arg0:GetMapHitRadius(TARGET_SELF) + 2
    local f8_local3 = 100
    local f8_local4 = 0
    local f8_local5 = 1.5
    local f8_local6 = 3
    Approach_Act_Flex(f8_arg0, f8_arg1, f8_local0, f8_local1, f8_local2, f8_local3, f8_local4, f8_local5, f8_local6)
    local f8_local7 = 3013
    local f8_local8 = 0
    local f8_local9 = 0
    f8_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 10, f8_local7, TARGET_ENE_0, 9999, f8_local8, f8_local9, 0, 0)
    f8_arg0:SetNumber(2, f8_arg0:GetNumber(2) + 1)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act10 = function (f9_arg0, f9_arg1, f9_arg2)
    local f9_local0 = 3014
    local f9_local1 = 0
    local f9_local2 = 0
    f9_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 10, f9_local0, TARGET_ENE_0, 9999, f9_local1, f9_local2, 0, 0)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act15 = function (f10_arg0, f10_arg1, f10_arg2)
    local f10_local0 = f10_arg0:GetDist(TARGET_ENE_0)
    local f10_local1 = 3.8 - f10_arg0:GetMapHitRadius(TARGET_SELF)
    local f10_local2 = 3.8 - f10_arg0:GetMapHitRadius(TARGET_SELF) + 2
    local f10_local3 = 3.8 - f10_arg0:GetMapHitRadius(TARGET_SELF) + 2
    local f10_local4 = 100
    local f10_local5 = 0
    local f10_local6 = 1.5
    local f10_local7 = 3
    local f10_local8 = f10_arg0:GetRandam_Int(1, 100)
    local f10_local9 = 0
    Approach_Act_Flex(f10_arg0, f10_arg1, f10_local1 + 5, f10_local2, f10_local3, f10_local4, f10_local5, f10_local6, f10_local7)
    f10_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 10, 3020, TARGET_ENE_0, 9999, f10_local9, FrontAngle, 0, 0)
    local f10_local10 = 3005
    local f10_local11 = 3006
    local f10_local12 = 3007
    local f10_local13 = 2.5 - f10_arg0:GetMapHitRadius(TARGET_SELF)
    local f10_local14 = 1.7 - f10_arg0:GetMapHitRadius(TARGET_SELF)
    local f10_local15 = 1.5 - f10_arg0:GetMapHitRadius(TARGET_SELF)
    local f10_local16 = 0
    if f10_local8 <= 50 then
        f10_arg1:AddSubGoal(GOAL_COMMON_ComboAttackTunableSpin, 10, f10_local10, TARGET_ENE_0, f10_local13, f10_local9, f10_local16, 0, 0)
        f10_arg1:AddSubGoal(GOAL_COMMON_ComboRepeat, 10, f10_local11, TARGET_ENE_0, f10_local14, 0)
        f10_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, f10_local12, TARGET_ENE_0, 9999, 0, 0)
    else
        f10_arg1:AddSubGoal(GOAL_COMMON_ComboAttackTunableSpin, 10, 3001, TARGET_ENE_0, f10_local13, f10_local9, f10_local16, 0, 0)
    end
    f10_arg0:SetNumber(0, 1)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act21 = function (f11_arg0, f11_arg1, f11_arg2)
    local f11_local0 = 3
    local f11_local1 = 45
    f11_arg1:AddSubGoal(GOAL_COMMON_Turn, f11_local0, TARGET_ENE_0, f11_local1, -1, GOAL_RESULT_Success, true)
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
    
end

Goal.Act23 = function (f12_arg0, f12_arg1, f12_arg2)
    local f12_local0 = f12_arg0:GetDist(TARGET_ENE_0)
    local f12_local1 = f12_arg0:GetSp(TARGET_SELF)
    local f12_local2 = f12_arg0:GetRandam_Int(1, 100)
    local f12_local3 = -1
    local f12_local4 = 0
    if SpaceCheck(f12_arg0, f12_arg1, -90, 1) == true then
        if SpaceCheck(f12_arg0, f12_arg1, 90, 1) == true then
            if f12_arg0:IsInsideTarget(TARGET_ENE_0, AI_DIR_TYPE_R, 180) then
                f12_local4 = 0
            else
                f12_local4 = 1
            end
        else
            f12_local4 = 0
        end
    elseif SpaceCheck(f12_arg0, f12_arg1, 90, 1) == true then
        f12_local4 = 1
    else
    end
    local f12_local5 = 3
    local f12_local6 = f12_arg0:GetRandam_Int(30, 45)
    f12_arg0:SetNumber(10, f12_local4)
    f12_arg1:AddSubGoal(GOAL_COMMON_SidewayMove, f12_local5, TARGET_ENE_0, f12_local4, f12_local6, true, true, f12_local3):TimingSetTimer(2, 4, UPDATE_SUCCESS)
    f12_arg0:SetNumber(1, 0)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act24 = function (f13_arg0, f13_arg1, f13_arg2)
    local f13_local0 = f13_arg0:GetDist(TARGET_ENE_0)
    local f13_local1 = 3
    local f13_local2 = 0
    local f13_local3 = 5201
    if SpaceCheck(f13_arg0, f13_arg1, 180, 2) == true then
        if SpaceCheck(f13_arg0, f13_arg1, 180, 4) ~= true or f13_local0 > 4 then
        else
            f13_local3 = 5211
            if false then
            end
        end
    else
        GetWellSpace_Odds = 100
        return GetWellSpace_Odds
    end
    f13_arg1:AddSubGoal(GOAL_COMMON_SpinStep, f13_local1, f13_local3, TARGET_ENE_0, f13_local2, AI_DIR_TYPE_B, 0)
    f13_arg0:SetNumber(1, 1)
    f13_arg0:SetNumber(2, 0)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act25 = function (f14_arg0, f14_arg1, f14_arg2)
    local f14_local0 = f14_arg0:GetRandam_Float(2, 4)
    local f14_local1 = f14_arg0:GetRandam_Float(1, 3)
    local f14_local2 = f14_arg0:GetDist(TARGET_ENE_0)
    local f14_local3 = -1
    if SpaceCheck(f14_arg0, f14_arg1, 180, 1) == true then
        f14_arg1:AddSubGoal(GOAL_COMMON_LeaveTarget, f14_local0, TARGET_ENE_0, f14_local1, TARGET_ENE_0, true, f14_local3)
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
    if f17_local0 <= 3 then
        f17_arg1:AddSubGoal(GOAL_COMMON_SidewayMove, f17_local1, TARGET_ENE_0, f17_local5, f17_local3, true, true, f17_local4)
    elseif f17_local0 <= 8 then
        f17_arg1:AddSubGoal(GOAL_COMMON_ApproachTarget, f17_local2, TARGET_ENE_0, 3, TARGET_SELF, true, -1)
    else
        f17_arg1:AddSubGoal(GOAL_COMMON_ApproachTarget, f17_local2, TARGET_ENE_0, 8, TARGET_SELF, true, -1)
    end
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
    
end

Goal.Act30 = function (f18_arg0, f18_arg1, f18_arg2)
    local f18_local0 = 3030
    local f18_local1 = 0
    local f18_local2 = 0
    f18_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 10, f18_local0, TARGET_ENE_0, 9999, f18_local1, f18_local2, 0, 0)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act31 = function (f19_arg0, f19_arg1, f19_arg2)
    local f19_local0 = 3031
    local f19_local1 = 0
    local f19_local2 = 0
    f19_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 10, f19_local0, TARGET_ENE_0, 9999, f19_local1, f19_local2, 0, 0)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act32 = function (f20_arg0, f20_arg1, f20_arg2)
    local f20_local0 = 3033
    local f20_local1 = 0
    local f20_local2 = 0
    f20_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 10, f20_local0, TARGET_ENE_0, 9999, f20_local1, f20_local2, 0, 0)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act35 = function (f21_arg0, f21_arg1, f21_arg2)
    local f21_local0 = 3032
    local f21_local1 = 0
    local f21_local2 = 0
    f21_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 10, f21_local0, TARGET_ENE_0, 9999, f21_local1, f21_local2, 0, 0)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act40 = function (f22_arg0, f22_arg1, f22_arg2)
    local f22_local0 = 3034
    local f22_local1 = 0
    local f22_local2 = 0
    f22_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 10, f22_local0, TARGET_ENE_0, 9999, f22_local1, f22_local2, 0, 0)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act41 = function (f23_arg0, f23_arg1, f23_arg2)
    local f23_local0 = 3035
    local f23_local1 = 0
    local f23_local2 = 0
    f23_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 10, f23_local0, TARGET_ENE_0, 9999, f23_local1, f23_local2, 0, 0)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act45 = function (f24_arg0, f24_arg1, f24_arg2)
    local f24_local0 = 3035
    local f24_local1 = 0
    local f24_local2 = 0
    local f24_local3 = f24_arg0:GetDist(TARGET_ENE_0)
    if f24_local3 <= 3 then
        f24_arg1:AddSubGoal(GOAL_COMMON_ComboRepeat, 10, 5211, TARGET_ENE_0, 9999, 0)
    end
    f24_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3045, TARGET_ENE_0, 9999, f24_local1, f24_local2, 0, 0):TimingSetNumber(7, 1, AI_TIMING_SET__ACTIVATE)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Interrupt = function (f25_arg0, f25_arg1, f25_arg2)
    local f25_local0 = f25_arg1:GetHpRate(TARGET_SELF)
    local f25_local1 = f25_arg1:GetDist(TARGET_ENE_0)
    local f25_local2 = f25_arg1:GetSp(TARGET_SELF)
    local f25_local3 = f25_arg1:GetSpecialEffectActivateInterruptType(0)
    local f25_local4 = f25_arg1:GetHp(TARGET_ENE_0)
    local f25_local5 = f25_arg1:GetSp(TARGET_ENE_0)
    if f25_arg1:IsLadderAct(TARGET_SELF) then
        return false
    end
    if not f25_arg1:HasSpecialEffectId(TARGET_SELF, 200004) then
        return false
    end
    if f25_arg1:IsInterupt(INTERUPT_ParryTiming) then
        if f25_arg1:HasSpecialEffectId(TARGET_SELF, 297490) then
            return Common_Parry(f25_arg1, f25_arg2, 100, 0)
        else
            return Common_Parry(f25_arg1, f25_arg2, 50, 0)
        end
    end
    if f25_arg1:IsInterupt(INTERUPT_Damaged) then
        return f25_arg0.Damaged(f25_arg1, f25_arg2)
    end
    if f25_arg1:IsInterupt(INTERUPT_GuardBreak) then
        f25_arg2:ClearSubGoal()
        f25_arg2:AddSubGoal(GOAL_COMMON_ComboAttackTunableSpin, 3, 3020, TARGET_ENE_0, 9999, 0, 0)
        f25_arg2:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3010, TARGET_ENE_0, 9999, 0, 0)
        return true
    end
    if f25_arg1:IsInterupt(INTERUPT_ActivateSpecialEffect) then
        if f25_arg1:GetSpecialEffectActivateInterruptType(0) == 3122010 and f25_arg1:HasSpecialEffectId(TARGET_SELF, 3122000) then
            if f25_local5 <= 0 or f25_local4 <= 0 then
            else
                f25_arg2:ClearSubGoal()
                f25_arg2:AddSubGoal(GOAL_COMMON_ComboFinal, 3, 3012, TARGET_ENE_0, 9999, 0, 0)
            end
        elseif f25_arg1:GetSpecialEffectActivateInterruptType(0) == 5026 and f25_local1 <= 4.6 then
            f25_arg2:ClearSubGoal()
            f25_arg2:AddSubGoal(GOAL_COMMON_ComboFinal, 3, 3010, TARGET_ENE_0, 9999, 0, 0)
            return true
        end
    end
    if f25_arg1:IsInterupt(INTERUPT_Inside_ObserveArea) then
    end
    if f25_arg1:IsInterupt(INTERUPT_ShootImpact) and f25_arg0.ShootReaction(f25_arg1, f25_arg2) then
        return true
    end
    return false
    
end

Goal.Damaged = function (f26_arg0, f26_arg1, f26_arg2)
    local f26_local0 = f26_arg0:GetRandam_Int(1, 100)
    local f26_local1 = -1
    local f26_local2 = 3
    if f26_local0 <= 25 then
        if SpaceCheck(f26_arg0, f26_arg1, 180, 1) == true then
            f26_arg1:ClearSubGoal()
            f26_arg1:AddSubGoal(GOAL_COMMON_LeaveTarget, f26_local2, TARGET_ENE_0, 9999, TARGET_ENE_0, true, f26_local1)
            return true
        else
            f26_arg1:ClearSubGoal()
            f26_arg1:AddSubGoal(GOAL_COMMON_SidewayMove, f26_local2, TARGET_ENE_0, direction, SuccessAngle, true, true, f26_local1)
            f26_arg0:SetTimer(2, 4)
            return true
        end
    elseif f26_local0 <= 40 then
        if SpaceCheck(f26_arg0, f26_arg1, 180, 2) == true then
            f26_arg1:ClearSubGoal()
            f26_arg1:AddSubGoal(GOAL_COMMON_SpinStep, 1, 5211, TARGET_ENE_0, TurnTime, AI_DIR_TYPE_B, 0):TimingSetTimer(3, 6, UPDATE_SUCCESS)
            return true
        else
            return false
        end
    else
        return false
    end
    return false
    
end

Goal.ShootReaction = function (f27_arg0, f27_arg1)
    f27_arg1:ClearSubGoal()
    f27_arg1:AddSubGoal(GOAL_COMMON_EndureAttack, 0.1, 3100, TARGET_ENE_0, 9999, 0)
    return true
    
end

Goal.Kengeki_Activate = function (f28_arg0, f28_arg1, f28_arg2)
    local f28_local0 = ReturnKengekiSpecialEffect(f28_arg1)
    if f28_local0 == 0 then
        return false
    end
    local f28_local1 = {}
    local f28_local2 = {}
    local f28_local3 = {}
    Common_Clear_Param(f28_local1, f28_local2, f28_local3)
    local f28_local4 = f28_arg1:GetDist(TARGET_ENE_0)
    local f28_local5 = f28_arg1:GetSp(TARGET_SELF)
    if f28_local0 == 200200 then
        f28_local1[26] = 100
        f28_local1[9] = 20
    elseif f28_local0 == 200201 then
        f28_local1[26] = 100
        f28_local1[9] = 20
    elseif f28_local0 == 200210 then
        if f28_local4 >= 2 then
            f28_local1[10] = 50
        elseif f28_local4 <= 0.2 then
            f28_local1[10] = 50
        else
            f28_local1[10] = 50
        end
    elseif f28_local0 == 200211 then
        if f28_arg1:HasSpecialEffectId(TARGET_SELF, 297490) then
            f28_local1[5] = 200
            f28_local1[9] = 50
            f28_local1[26] = 20
        end
    elseif f28_local0 == 200215 then
        if f28_arg1:HasSpecialEffectId(TARGET_SELF, 297490) then
            f28_local1[26] = 100
        else
            f28_local1[9] = 20
            f28_local1[26] = 100
        end
    elseif f28_local0 == 200216 then
        if f28_arg1:HasSpecialEffectId(TARGET_SELF, 297490) then
            f28_local1[26] = 100
        else
            f28_local1[9] = 20
            f28_local1[26] = 100
        end
    end
    if SpaceCheck(f28_arg1, f28_arg2, 180, 2) == false then
        f28_local1[9] = 0
        f28_local1[26] = 100
    end
    if SpaceCheck(f28_arg1, f28_arg2, 90, 1) == false and SpaceCheck(f28_arg1, f28_arg2, -90, 1) == false then
        f28_local1[10] = 0
        f28_local1[26] = 100
    end
    f28_local2[5] = REGIST_FUNC(f28_arg1, f28_arg2, f28_arg0.Kengeki05)
    f28_local2[9] = REGIST_FUNC(f28_arg1, f28_arg2, f28_arg0.Kengeki09)
    f28_local2[10] = REGIST_FUNC(f28_arg1, f28_arg2, f28_arg0.Kengeki10)
    f28_local2[26] = REGIST_FUNC(f28_arg1, f28_arg2, f28_arg0.NoAction)
    local f28_local6 = REGIST_FUNC(f28_arg1, f28_arg2, f28_arg0.ActAfter_AdjustSpace)
    return Common_Kengeki_Activate(f28_arg1, f28_arg2, f28_local1, f28_local2, f28_local6, f28_local3)
    
end

Goal.Kengeki05 = function (f29_arg0, f29_arg1, f29_arg2)
    f29_arg1:ClearSubGoal()
    f29_arg1:AddSubGoal(GOAL_COMMON_ComboRepeat, 10, 3070, TARGET_ENE_0, 9999, 0, 0)
    
end

Goal.Kengeki09 = function (f30_arg0, f30_arg1, f30_arg2)
    f30_arg1:ClearSubGoal()
    f30_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 3, 5211, TARGET_ENE_0, 0, AI_DIR_TYPE_B, 0)
    f30_arg0:SetNumber(1, 1)
    
end

Goal.Kengeki10 = function (f31_arg0, f31_arg1, f31_arg2)
    local f31_local0 = f31_arg0:GetDist(TARGET_ENE_0)
    local f31_local1 = f31_arg0:GetRandam_Int(1, 100)
    local f31_local2 = -1
    local f31_local3 = f31_arg0:GetRandam_Int(30, 45)
    local f31_local4 = f31_arg0:GetRandam_Int(0, 1)
    local f31_local5 = 3
    f31_arg1:ClearSubGoal()
    f31_arg1:AddSubGoal(GOAL_COMMON_SidewayMove, f31_local5, TARGET_ENE_0, f31_local4, f31_local3, true, true, -1)
    
end

Goal.NoAction = function (f32_arg0, f32_arg1, f32_arg2)
    return -1
    
end

Goal.ActAfter_AdjustSpace = function (f33_arg0, f33_arg1, f33_arg2)
    
end

Goal.Update = function (f34_arg0, f34_arg1, f34_arg2)
    return Update_Default_NoSubGoal(f34_arg0, f34_arg1, f34_arg2)
    
end

Goal.Terminate = function (f35_arg0, f35_arg1, f35_arg2)
    
end


