RegisterTableGoal(GOAL_NanbanArmor_113000_Battle, "GOAL_NanbanArmor_113000_Battle")
REGISTER_GOAL_NO_UPDATE(GOAL_NanbanArmor_113000_Battle, true)

Goal.Initialize = function (f1_arg0, f1_arg1, f1_arg2, f1_arg3)
    
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
    local f2_local3 = f2_arg1:GetHpRate(TARGET_SELF)
    local f2_local4 = f2_arg1:GetSp(TARGET_SELF)
    local f2_local5 = f2_arg1:GetDist(TARGET_ENE_0)
    local f2_local6 = f2_arg1:GetRandam_Int(1, 100)
    local f2_local7 = f2_arg1:GetExcelParam(AI_EXCEL_THINK_PARAM_TYPE__thinkAttr_doAdmirer)
    local f2_local8 = f2_arg1:GetEventRequest()
    f2_arg1:AddObserveSpecialEffectAttribute(TARGET_SELF, 5025)
    f2_arg1:AddObserveSpecialEffectAttribute(TARGET_SELF, 5026)
    f2_arg1:AddObserveSpecialEffectAttribute(TARGET_SELF, 5027)
    f2_arg1:AddObserveSpecialEffectAttribute(TARGET_SELF, 5030)
    f2_arg1:AddObserveSpecialEffectAttribute(TARGET_SELF, 5031)
    f2_arg1:AddObserveSpecialEffectAttribute(TARGET_SELF, 5032)
    f2_arg1:AddObserveSpecialEffectAttribute(TARGET_SELF, 5033)
    f2_arg1:AddObserveSpecialEffectAttribute(TARGET_ENE_0, 3113000)
    f2_arg1:AddObserveSpecialEffectAttribute(TARGET_SELF, 3113020)
    f2_arg1:DeleteObserve(1)
    if Common_ActivateAct(f2_arg1, f2_arg2, 1) then
    elseif f2_arg1:CheckDoesExistPath(TARGET_ENE_0, AI_DIR_TYPE_F, 0, 0) == false then
        f2_local0[27] = 100
    elseif f2_arg1:GetNumber(0) >= 4 then
        f2_local0[7] = 100
    elseif not f2_arg1:IsExistMeshOnLine(TARGET_ENE_0, AI_DIR_TYPE_ToB, f2_local5) and f2_arg1:CheckDoesExistPath(TARGET_ENE_0, AI_DIR_TYPE_F, 0, 0) == true then
        f2_local0[40] = 100
    elseif f2_arg1:IsInsideTarget(TARGET_ENE_0, AI_DIR_TYPE_B, 180) then
        if f2_local5 > 7 then
            f2_local0[21] = 100
        elseif f2_local5 > 5 then
            f2_local0[21] = 100
        else
            f2_local0[21] = 100
        end
    elseif not f2_arg1:IsExistMeshOnLine(TARGET_ENE_0, AI_DIR_TYPE_ToB, f2_local5) and f2_arg1:CheckDoesExistPath(TARGET_ENE_0, AI_DIR_TYPE_F, 0, 0) == true then
        f2_local0[40] = 100
    elseif f2_arg1:HasSpecialEffectId(TARGET_ENE_0, COMMON_SP_EFFECT_PC_BREAK) then
        f2_local0[3] = 100
    elseif f2_local5 >= 11 then
        f2_local0[1] = 0
        f2_local0[2] = 0
        f2_local0[3] = 100
        f2_local0[4] = 0
        f2_local0[5] = 100
        f2_local0[6] = 0
    elseif f2_local5 >= 9 then
        f2_local0[1] = 0
        f2_local0[2] = 0
        f2_local0[3] = 100
        f2_local0[4] = 0
        f2_local0[5] = 200
        f2_local0[6] = 0
    elseif f2_local5 > 7 then
        f2_local0[1] = 100
        f2_local0[2] = 100
        f2_local0[3] = 100
        f2_local0[4] = 0
        f2_local0[5] = 0
        f2_local0[6] = 0
    elseif f2_local5 > 5 then
        f2_local0[1] = 100
        f2_local0[2] = 100
        f2_local0[3] = 100
        f2_local0[4] = 0
        f2_local0[5] = 100
    elseif f2_local5 > 3 then
        f2_local0[1] = 100
        f2_local0[2] = 100
        f2_local0[3] = 0
        f2_local0[4] = 100
        f2_local0[6] = 100
    else
        f2_local0[1] = 50
        f2_local0[2] = 50
        f2_local0[3] = 0
        f2_local0[4] = 100
        f2_local0[5] = 0
        f2_local0[6] = 200
    end
    if f2_arg1:IsFinishTimer(0) == false then
        f2_local0[6] = 0
    end
    if SpaceCheck(f2_arg1, f2_arg2, 45, f2_arg1:GetStringIndexedNumber("Dist_Step_Small")) == false and SpaceCheck(f2_arg1, f2_arg2, -45, f2_arg1:GetStringIndexedNumber("Dist_Step_Small")) == false then
        f2_local0[22] = 0
    end
    if SpaceCheck(f2_arg1, f2_arg2, 90, 1) == false and SpaceCheck(f2_arg1, f2_arg2, -90, 1) == false then
        f2_local0[23] = 0
    end
    if SpaceCheck(f2_arg1, f2_arg2, 180, f2_arg1:GetStringIndexedNumber("Dist_Step_Small")) == false then
        f2_local0[24] = 0
    end
    if SpaceCheck(f2_arg1, f2_arg2, 180, 1) == false then
        f2_local0[25] = 0
    end
    f2_local0[1] = SetCoolTime(f2_arg1, f2_arg2, 3000, 20, f2_local0[1], 1)
    f2_local0[2] = SetCoolTime(f2_arg1, f2_arg2, 3004, 20, f2_local0[2], 1)
    f2_local0[3] = SetCoolTime(f2_arg1, f2_arg2, 3007, 20, f2_local0[3], 1)
    f2_local0[4] = SetCoolTime(f2_arg1, f2_arg2, 3008, 20, f2_local0[4], 1)
    f2_local0[5] = SetCoolTime(f2_arg1, f2_arg2, 3009, 20, f2_local0[5], 1)
    f2_local0[6] = SetCoolTime(f2_arg1, f2_arg2, 3011, 20, f2_local0[6], 1)
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
    f2_local1[21] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act21)
    f2_local1[23] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act23)
    f2_local1[26] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act26)
    f2_local1[27] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act27)
    f2_local1[30] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act30)
    f2_local1[40] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act40)
    local f2_local9 = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.ActAfter_AdjustSpace)
    Common_Battle_Activate(f2_arg1, f2_arg2, f2_local0, f2_local1, f2_local9, f2_local2)
    
end

Goal.Act01 = function (f3_arg0, f3_arg1, f3_arg2)
    local f3_local0 = 5.6 - f3_arg0:GetMapHitRadius(TARGET_SELF)
    local f3_local1 = 5.6 - f3_arg0:GetMapHitRadius(TARGET_SELF) + 2
    local f3_local2 = 5.6 - f3_arg0:GetMapHitRadius(TARGET_SELF) + 2
    local f3_local3 = 100
    local f3_local4 = 0
    local f3_local5 = 1.5
    local f3_local6 = 3
    Approach_Act_Flex(f3_arg0, f3_arg1, f3_local0, f3_local1, f3_local2, f3_local3, f3_local4, f3_local5, f3_local6)
    local f3_local7 = 3000
    local f3_local8 = 3001
    local f3_local9 = 3002
    local f3_local10 = 3003
    local f3_local11 = 6.7 - f3_arg0:GetMapHitRadius(TARGET_SELF)
    local f3_local12 = 7.5 - f3_arg0:GetMapHitRadius(TARGET_SELF)
    local f3_local13 = 6.5 - f3_arg0:GetMapHitRadius(TARGET_SELF)
    local f3_local14 = 0
    local f3_local15 = 0
    local f3_local16 = f3_arg0:GetRandam_Int(1, 100)
    if f3_local16 <= 50 then
        f3_arg1:AddSubGoal(GOAL_COMMON_ComboAttackTunableSpin, 10, f3_local7, TARGET_ENE_0, 9999, f3_local14, f3_local15, 0, 0)
        f3_arg1:AddSubGoal(GOAL_COMMON_ComboRepeat, 10, f3_local8, TARGET_ENE_0, 9999, 0, 0)
        f3_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, f3_local9, TARGET_ENE_0, 9999, 0, 0)
    else
        f3_arg1:AddSubGoal(GOAL_COMMON_ComboAttackTunableSpin, 10, f3_local7, TARGET_ENE_0, 9999, f3_local14, f3_local15, 0, 0)
        f3_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, f3_local10, TARGET_ENE_0, 9999, 0, 0)
    end
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act02 = function (f4_arg0, f4_arg1, f4_arg2)
    local f4_local0 = 6.2 - f4_arg0:GetMapHitRadius(TARGET_SELF)
    local f4_local1 = 6.2 - f4_arg0:GetMapHitRadius(TARGET_SELF) + 0
    local f4_local2 = 6.2 - f4_arg0:GetMapHitRadius(TARGET_SELF) + 2
    local f4_local3 = 100
    local f4_local4 = 0
    local f4_local5 = 1.5
    local f4_local6 = 3
    Approach_Act_Flex(f4_arg0, f4_arg1, f4_local0, f4_local1, f4_local2, f4_local3, f4_local4, f4_local5, f4_local6)
    local f4_local7 = 3004
    local f4_local8 = 3005
    local f4_local9 = 3003
    local f4_local10 = 5.85 - f4_arg0:GetMapHitRadius(TARGET_SELF)
    local f4_local11 = 6.4 - f4_arg0:GetMapHitRadius(TARGET_SELF)
    local f4_local12 = 0
    local f4_local13 = 0
    f4_arg1:AddSubGoal(GOAL_COMMON_ComboAttackTunableSpin, 10, f4_local7, TARGET_ENE_0, 9999, f4_local12, f4_local13, 0, 0)
    f4_arg1:AddSubGoal(GOAL_COMMON_ComboRepeat, 10, f4_local8, TARGET_ENE_0, 9999, 0, 0)
    f4_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, f4_local9, TARGET_ENE_0, 9999, 0, 0)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act03 = function (f5_arg0, f5_arg1, f5_arg2)
    local f5_local0 = 7.6 - f5_arg0:GetMapHitRadius(TARGET_SELF)
    local f5_local1 = 7.6 - f5_arg0:GetMapHitRadius(TARGET_SELF) + 0
    local f5_local2 = 7.6 - f5_arg0:GetMapHitRadius(TARGET_SELF) + 2
    local f5_local3 = 100
    local f5_local4 = 0
    local f5_local5 = 1.5
    local f5_local6 = 3
    Approach_Act_Flex(f5_arg0, f5_arg1, f5_local0, f5_local1, f5_local2, f5_local3, f5_local4, f5_local5, f5_local6)
    local f5_local7 = 3007
    f5_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 10, f5_local7, TARGET_ENE_0, 9999, TurnTime, FrontAngle, 0, 0)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act04 = function (f6_arg0, f6_arg1, f6_arg2)
    local f6_local0 = 4.7 - f6_arg0:GetMapHitRadius(TARGET_SELF)
    local f6_local1 = 4.7 - f6_arg0:GetMapHitRadius(TARGET_SELF) + 0
    local f6_local2 = 4.7 - f6_arg0:GetMapHitRadius(TARGET_SELF) + 2
    local f6_local3 = 100
    local f6_local4 = 0
    local f6_local5 = 1.5
    local f6_local6 = 3
    local f6_local7 = 3008
    f6_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 10, f6_local7, TARGET_ENE_0, 9999, TurnTime, FrontAngle, 0, 0)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act05 = function (f7_arg0, f7_arg1, f7_arg2)
    local f7_local0 = 14.8 - f7_arg0:GetMapHitRadius(TARGET_SELF)
    local f7_local1 = 14.8 - f7_arg0:GetMapHitRadius(TARGET_SELF) + 2
    local f7_local2 = 14.8 - f7_arg0:GetMapHitRadius(TARGET_SELF) + 2
    local f7_local3 = 100
    local f7_local4 = 0
    local f7_local5 = 1.5
    local f7_local6 = 3
    Approach_Act_Flex(f7_arg0, f7_arg1, f7_local0, f7_local1, f7_local2, f7_local3, f7_local4, f7_local5, f7_local6)
    f7_arg0:AddObserveArea(1, TARGET_SELF, TARGET_ENE_0, AI_DIR_TYPE_F, 360, 7)
    local f7_local7 = 3009
    local f7_local8 = 3010
    local f7_local9 = 4.8 - f7_arg0:GetMapHitRadius(TARGET_SELF)
    local f7_local10 = 0
    local f7_local11 = 0
    local f7_local12 = f7_arg0:GetRandam_Int(1, 100)
    f7_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 10, f7_local7, TARGET_ENE_0, 9999, f7_local10, f7_local11, 0, 0)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act06 = function (f8_arg0, f8_arg1, f8_arg2)
    local f8_local0 = 3011
    f8_arg1:AddSubGoal(GOAL_COMMON_ComboAttackTunableSpin, 10, 3011, TARGET_ENE_0, 9999, 0, 0, 0, 0)
    f8_arg1:AddSubGoal(GOAL_COMMON_ComboRepeat, 10, 3013, TARGET_ENE_0, 9999, 0, 0)
    f8_arg0:SetTimer(0, 5)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act07 = function (f9_arg0, f9_arg1, f9_arg2)
    f9_arg1:AddSubGoal(GOAL_COMMON_ComboAttackTunableSpin, 10, 3094, TARGET_ENE_0, 9999, TurnTime, FrontAngle, 0, 0)
    f9_arg0:SetNumber(0, 0)
    f9_arg0:SetNumber(1, 1)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act08 = function (f10_arg0, f10_arg1, f10_arg2)
    f10_arg1:AddSubGoal(GOAL_COMMON_ComboAttackTunableSpin, 10, 3092, TARGET_ENE_0, 9999, TurnTime, FrontAngle, 0, 0)
    f10_arg1:AddSubGoal(GOAL_COMMON_ComboRepeat, 10, 3095, TARGET_ENE_0, 9999, TurnTime, FrontAngle, 0, 0)
    f10_arg0:SetNumber(1, 0)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act09 = function (f11_arg0, f11_arg1, f11_arg2)
    f11_arg1:AddSubGoal(GOAL_COMMON_ComboAttackTunableSpin, 10, 3093, TARGET_ENE_0, 9999, TurnTime, FrontAngle, 0, 0)
    f11_arg0:SetNumber(1, 0)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act10 = function (f12_arg0, f12_arg1, f12_arg2)
    local f12_local0 = 3091
    f12_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 10, f12_local0, TARGET_ENE_0, 9999, TurnTime, FrontAngle, 0, 0)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act30 = function (f13_arg0, f13_arg1, f13_arg2)
    local f13_local0 = 3092
    f13_arg1:AddSubGoal(GOAL_COMMON_ComboRepeat, 10, 3011, TARGET_ENE_0, 9999, 0, 0)
    f13_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3013, TARGET_ENE_0, 9999, 0, 0)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act40 = function (f14_arg0, f14_arg1, f14_arg2)
    local f14_local0 = f14_arg0:GetDist(TARGET_ENE_0)
    local f14_local1 = 1
    local f14_local2 = false
    local f14_local3 = 0.1
    local f14_local4 = f14_arg0:GetEventRequest()
    local f14_local5 = f14_arg0:GetNinsatsuMaxNum()
    local f14_local6 = f14_arg0:GetNinsatsuNum()
    local f14_local7 = f14_arg0:GetRandam_Int(1, 100)
    f14_arg1:AddSubGoal(GOAL_COMMON_ApproachTarget, f14_local3, TARGET_ENE_0, f14_local1, TARGET_SELF, f14_local2, -1)
    if f14_local7 <= 25 then
        f14_arg1:AddSubGoal(GOAL_COMMON_ComboAttackTunableSpin, 10, 3000, TARGET_ENE_0, 9999, TurnTime, FrontAngle, 0, 0)
        f14_arg1:AddSubGoal(GOAL_COMMON_ComboRepeat, 10, 3001, TARGET_ENE_0, 9999, 0, 0)
        f14_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3002, TARGET_ENE_0, 9999, 0, 0)
    elseif f14_local7 <= 50 then
        f14_arg1:AddSubGoal(GOAL_COMMON_ComboAttackTunableSpin, 10, 3000, TARGET_ENE_0, 9999, TurnTime, FrontAngle, 0, 0)
        f14_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3003, TARGET_ENE_0, 9999, 0, 0)
    elseif f14_local7 <= 75 then
        f14_arg1:AddSubGoal(GOAL_COMMON_ComboAttackTunableSpin, 10, 3004, TARGET_ENE_0, 9999, TurnTime, FrontAngle, 0, 0)
        f14_arg1:AddSubGoal(GOAL_COMMON_ComboRepeat, 10, 3005, TARGET_ENE_0, 9999, 0, 0)
        f14_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3003, TARGET_ENE_0, 9999, 0, 0)
    else
        f14_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 10, 3007, TARGET_ENE_0, 9999, TurnTime, FrontAngle, 0, 0)
    end
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act20 = function (f15_arg0, f15_arg1, f15_arg2)
    local f15_local0 = 6.2 - f15_arg0:GetMapHitRadius(TARGET_SELF)
    local f15_local1 = 6.2 - f15_arg0:GetMapHitRadius(TARGET_SELF) + 0
    local f15_local2 = 6.2 - f15_arg0:GetMapHitRadius(TARGET_SELF) + 2
    local f15_local3 = 100
    local f15_local4 = 0
    local f15_local5 = 1.5
    local f15_local6 = 3
    Approach_Act_Flex(f15_arg0, f15_arg1, f15_local0, f15_local1, f15_local2, f15_local3, f15_local4, f15_local5, f15_local6)
    f15_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 10, 3003, TARGET_ENE_0, 9999, TurnTime, FrontAngle, 0, 0)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act21 = function (f16_arg0, f16_arg1, f16_arg2)
    local f16_local0 = 3
    local f16_local1 = 45
    f16_arg1:AddSubGoal(GOAL_COMMON_Turn, f16_local0, TARGET_ENE_0, f16_local1, -1, GOAL_RESULT_Success, true)
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
            if f17_arg0:IsInsideTarget(TARGET_ENE_0, AI_DIR_TYPE_R, 180) then
                f17_local5 = 0
            else
                f17_local5 = 1
            end
        else
            f17_local5 = 0
        end
    elseif SpaceCheck(f17_arg0, f17_arg1, 90, 1) == true then
        f17_local5 = 1
    else
        GetWellSpace_Odds = 100
        return GetWellSpace_Odds
    end
    local f17_local6 = 2.5
    local f17_local7 = f17_arg0:GetRandam_Int(30, 45)
    f17_arg1:AddSubGoal(GOAL_COMMON_SidewayMove, f17_local6, TARGET_ENE_0, f17_local5, f17_local7, true, true, f17_local4):TimingSetTimer(2, 4, UPDATE_SUCCESS)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act26 = function (f18_arg0, f18_arg1, f18_arg2)
    f18_arg1:AddSubGoal(GOAL_COMMON_Wait, 0.5, TARGET_SELF, 0, 0, 0)
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
    
end

Goal.Act27 = function (f19_arg0, f19_arg1, f19_arg2)
    local f19_local0 = f19_arg0:GetDist(TARGET_ENE_0)
    local f19_local1 = f19_arg0:GetDistYSigned(TARGET_ENE_0)
    local f19_local2 = f19_local1 / math.tan(math.deg(30))
    local f19_local3 = f19_arg0:GetRandam_Int(0, 1)
    f19_arg0:SetNumber(10, f19_local3)
    if f19_local1 >= 3 then
        if f19_local2 + 1 <= f19_local0 then
            if SpaceCheck(f19_arg0, f19_arg1, 0, 4) == true then
                f19_arg1:AddSubGoal(GOAL_COMMON_ApproachTarget, 0.1, TARGET_ENE_0, f19_local2, TARGET_SELF, false, -1)
            elseif SpaceCheck(f19_arg0, f19_arg1, 0, 3) == true then
                f19_arg1:AddSubGoal(GOAL_COMMON_ApproachTarget, 0.5, TARGET_ENE_0, f19_local2, TARGET_SELF, true, -1)
            else
                f19_arg1:AddSubGoal(GOAL_COMMON_SidewayMove, 3, TARGET_ENE_0, f19_local3, f19_arg0:GetRandam_Int(30, 45), true, true, -1)
            end
        elseif f19_local0 <= f19_local2 - 1 then
            f19_arg1:AddSubGoal(GOAL_COMMON_LeaveTarget, 10, TARGET_ENE_0, f19_local2, TARGET_ENE_0, true, -1):SetTargetRange(0, -99, 12)
        end
    elseif SpaceCheck(f19_arg0, f19_arg1, 0, 4) == true then
        f19_arg1:AddSubGoal(GOAL_COMMON_ApproachTarget, 0.1, TARGET_ENE_0, 0, TARGET_SELF, false, -1)
    elseif SpaceCheck(f19_arg0, f19_arg1, 0, 3) == true then
        f19_arg1:AddSubGoal(GOAL_COMMON_ApproachTarget, 0.5, TARGET_ENE_0, 0, TARGET_SELF, true, -1)
    elseif SpaceCheck(f19_arg0, f19_arg1, 0, 1) == false then
        f19_arg1:AddSubGoal(GOAL_COMMON_LeaveTarget, 0.5, TARGET_ENE_0, 999, TARGET_ENE_0, true, -1):SetTargetRange(0, -99, 12)
    end
    f19_arg1:AddSubGoal(GOAL_COMMON_SidewayMove, 3, TARGET_ENE_0, f19_local3, f19_arg0:GetRandam_Int(30, 45), true, true, -1):SetTargetRange(0, -99, 12)
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
    
end

Goal.Interrupt = function (f20_arg0, f20_arg1, f20_arg2)
    local f20_local0 = f20_arg1:GetHpRate(TARGET_SELF)
    local f20_local1 = f20_arg1:GetDist(TARGET_ENE_0)
    local f20_local2 = f20_arg1:GetSp(TARGET_SELF)
    local f20_local3 = f20_arg1:GetRandam_Int(1, 100)
    local f20_local4 = f20_arg1:GetSpecialEffectActivateInterruptType(0)
    if f20_arg1:IsLadderAct(TARGET_SELF) then
        return false
    end
    if not f20_arg1:HasSpecialEffectId(TARGET_SELF, 200004) then
        return false
    end
    if f20_arg1:IsInterupt(INTERUPT_ParryTiming) then
        return f20_arg0.Parry(f20_arg1, f20_arg2)
    end
    if f20_arg1:IsInterupt(INTERUPT_Damaged) then
        return f20_arg0.Damaged(f20_arg1, f20_arg2)
    end
    if Interupt_PC_Break(f20_arg1) then
        f20_arg1:Replanning()
        return true
    end
    if f20_arg1:IsInterupt(INTERUPT_ActivateSpecialEffect) then
        if f20_arg1:GetSpecialEffectActivateInterruptType(0) == 3113000 then
            f20_arg2:ClearSubGoal()
            f20_arg2:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3030, TARGET_ENE_0, 9999, 0, 0)
            return true
        elseif f20_arg1:GetSpecialEffectActivateInterruptType(0) == 3113020 then
            f20_arg2:ClearSubGoal()
            f20_arg2:AddSubGoal(GOAL_COMMON_EndureAttack, 3, 20000, TARGET_ENE_0, 9999, 0)
            return true
        elseif f20_arg1:GetSpecialEffectActivateInterruptType(0) == 5026 then
            f20_arg1:SetNumber(0, 0)
        elseif f20_arg1:GetSpecialEffectActivateInterruptType(0) == 5027 then
            f20_arg1:SetNumber(0, 2)
        elseif f20_arg1:GetSpecialEffectActivateInterruptType(0) == 5030 then
            f20_arg1:SetNumber(0, f20_arg1:GetNumber(0) + 3)
        elseif f20_arg1:GetSpecialEffectActivateInterruptType(0) == 5031 then
            f20_arg1:SetNumber(0, f20_arg1:GetNumber(0) + 3)
        elseif f20_arg1:GetSpecialEffectActivateInterruptType(0) == 5032 then
            if f20_local1 <= 5 then
                f20_arg2:ClearSubGoal()
                f20_arg2:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3092, TARGET_ENE_0, 9999, 0, 0)
                f20_arg1:SetNumber(1, 0)
            else
                f20_arg2:ClearSubGoal()
                f20_arg2:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3093, TARGET_ENE_0, 9999, 0, 0)
                f20_arg1:SetNumber(1, 0)
            end
        elseif f20_arg1:GetSpecialEffectActivateInterruptType(0) == 5033 and f20_local1 >= 4.5 then
            f20_arg2:ClearSubGoal()
            f20_arg2:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3095, TARGET_ENE_0, 9999, 0, 0)
        end
    end
    if f20_arg1:IsInterupt(INTERUPT_Inside_ObserveArea) then
        f20_arg2:ClearSubGoal()
        f20_arg2:AddSubGoal(GOAL_COMMON_ComboRepeat, 1, 3010, TARGET_ENE_0, 7.5 - f20_arg1:GetMapHitRadius(TARGET_SELF), 0, 0)
        f20_arg1:DeleteObserve(1)
        return true
    end
    return false
    
end

Goal.Kengeki_Activate = function (f21_arg0, f21_arg1, f21_arg2, f21_arg3)
    local f21_local0 = ReturnKengekiSpecialEffect(f21_arg1)
    if f21_local0 == 0 then
        return false
    end
    local f21_local1 = {}
    local f21_local2 = {}
    local f21_local3 = {}
    Common_Clear_Param(f21_local1, f21_local2, f21_local3)
    local f21_local4 = f21_arg1:GetDist(TARGET_ENE_0)
    local f21_local5 = f21_arg1:GetSp(TARGET_SELF)
    f21_arg1:SetNumber(0, f21_arg1:GetNumber(0) + 1)
    if f21_local0 == 200200 then
        if f21_arg1:GetNumber(0) >= 4 then
            f21_local1[50] = 100
        elseif f21_arg1:GetNumber(0) >= 2 then
            f21_local1[3] = 100
            f21_local1[5] = 100
        else
            f21_local1[3] = 100
        end
    elseif f21_local0 == 200201 then
        if f21_arg1:GetNumber(0) >= 4 then
            f21_local1[50] = 100
        elseif f21_arg1:GetNumber(0) >= 2 then
            f21_local1[4] = 100
            f21_local1[5] = 100
        else
            f21_local1[4] = 100
        end
    end
    if f21_arg1:IsFinishTimer(0) == false then
        f21_local1[5] = 0
    end
    f21_local1[3] = SetCoolTime(f21_arg1, f21_arg2, 3060, 15, f21_local1[3], 1)
    f21_local1[4] = SetCoolTime(f21_arg1, f21_arg2, 3065, 20, f21_local1[4], 1)
    f21_local1[5] = SetCoolTime(f21_arg1, f21_arg2, 3006, 8, f21_local1[5], 1)
    f21_local2[1] = REGIST_FUNC(f21_arg1, f21_arg2, f21_arg0.Kengeki01)
    f21_local2[2] = REGIST_FUNC(f21_arg1, f21_arg2, f21_arg0.Kengeki02)
    f21_local2[3] = REGIST_FUNC(f21_arg1, f21_arg2, f21_arg0.Kengeki03)
    f21_local2[4] = REGIST_FUNC(f21_arg1, f21_arg2, f21_arg0.Kengeki04)
    f21_local2[5] = REGIST_FUNC(f21_arg1, f21_arg2, f21_arg0.Kengeki05)
    f21_local2[6] = REGIST_FUNC(f21_arg1, f21_arg2, f21_arg0.Kengeki06)
    f21_local2[7] = REGIST_FUNC(f21_arg1, f21_arg2, f21_arg0.Kengeki07)
    f21_local2[8] = REGIST_FUNC(f21_arg1, f21_arg2, f21_arg0.Kengeki08)
    f21_local2[50] = REGIST_FUNC(f21_arg1, f21_arg2, f21_arg0.NoAction)
    local f21_local6 = REGIST_FUNC(f21_arg1, f21_arg2, f21_arg0.ActAfter_AdjustSpace)
    Common_Kengeki_Activate(f21_arg1, f21_arg2, f21_local1, f21_local2, f21_local6, f21_local3)
    
end

Goal.Kengeki01 = function (f22_arg0, f22_arg1, f22_arg2)
    f22_arg1:ClearSubGoal()
    if f22_arg0:GetNumber(2) == 0 then
        f22_arg1:AddSubGoal(GOAL_COMMON_EndureAttack, 10, 3090, TARGET_ENE_0, 9999, TurnTime, FrontAngle, 0, 0)
        f22_arg0:SetNumber(2, 1)
    else
        f22_arg1:AddSubGoal(GOAL_COMMON_EndureAttack, 10, 3094, TARGET_ENE_0, 9999, TurnTime, FrontAngle, 0, 0)
    end
    f22_arg0:SetNumber(0, f22_arg0:GetNumber(0) - 5)
    f22_arg0:SetNumber(1, 1)
    
end

Goal.Kengeki02 = function (f23_arg0, f23_arg1, f23_arg2)
    f23_arg1:ClearSubGoal()
    f23_arg1:AddSubGoal(GOAL_COMMON_ComboRepeat, 10, 3006, TARGET_ENE_0, 9999, 0, 0)
    f23_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3013, TARGET_ENE_0, 9999, 0, 0)
    
end

Goal.Kengeki03 = function (f24_arg0, f24_arg1, f24_arg2)
    local f24_local0 = f24_arg0:GetRandam_Int(1, 100)
    f24_arg1:ClearSubGoal()
    f24_arg1:AddSubGoal(GOAL_COMMON_ComboRepeat, 10, 3060, TARGET_ENE_0, 9999, 0, 0)
    f24_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3003, TARGET_ENE_0, 9999, 0, 0)
    
end

Goal.Kengeki04 = function (f25_arg0, f25_arg1, f25_arg2)
    f25_arg1:ClearSubGoal()
    f25_arg1:AddSubGoal(GOAL_COMMON_ComboRepeat, 10, 3065, TARGET_ENE_0, 9999, 0, 0)
    f25_arg1:AddSubGoal(GOAL_COMMON_ComboRepeat, 10, 3005, TARGET_ENE_0, 9999, 0, 0)
    f25_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3003, TARGET_ENE_0, 9999, 0, 0)
    
end

Goal.Kengeki05 = function (f26_arg0, f26_arg1, f26_arg2)
    local f26_local0 = f26_arg0:GetRandam_Int(1, 100)
    f26_arg1:ClearSubGoal()
    f26_arg1:AddSubGoal(GOAL_COMMON_ComboRepeat, 10, 3006, TARGET_ENE_0, 9999, 0, 0)
    if f26_local0 <= 100 then
        f26_arg1:AddSubGoal(GOAL_COMMON_ComboRepeat, 10, 3013, TARGET_ENE_0, 9999, 0, 0)
    end
    f26_arg0:SetTimer(0, 5)
    
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

Goal.ActAfter_AdjustSpace = function (f31_arg0, f31_arg1, f31_arg2)
    
end

Goal.Update = function (f32_arg0, f32_arg1, f32_arg2)
    return Update_Default_NoSubGoal(f32_arg0, f32_arg1, f32_arg2)
    
end

Goal.Terminate = function (f33_arg0, f33_arg1, f33_arg2)
    
end


