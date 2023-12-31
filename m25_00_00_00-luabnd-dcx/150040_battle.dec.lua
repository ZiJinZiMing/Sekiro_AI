﻿RegisterTableGoal(GOAL_MurabitoZombie_takeyari_150040_Battle, "GOAL_MurabitoZombie_takeyari_150040_Battle")
REGISTER_GOAL_NO_UPDATE(GOAL_MurabitoZombie_takeyari_150040_Battle, true)

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
    f2_arg1:AddObserveSpecialEffectAttribute(TARGET_ENE_0, 106020)
    if Common_ActivateAct(f2_arg1, f2_arg2) then
    elseif f2_arg1:CheckDoesExistPath(TARGET_ENE_0, AI_DIR_TYPE_F, 0, 0) == false then
        f2_local0[27] = 100
    elseif f2_local4 == 1 and f2_arg1:GetTeamOrder(ORDER_TYPE_Role) == ROLE_TYPE_Kankyaku then
        if KankyakuAct(f2_arg1, f2_arg2, -1, 50) then
            f2_local0[5] = 100
            f2_local0[22] = 100
        end
    elseif f2_local4 == 1 and f2_arg1:GetTeamOrder(ORDER_TYPE_Role) == ROLE_TYPE_Torimaki then
        if TorimakiAct(f2_arg1, f2_arg2, -1, 50) then
            f2_local0[1] = 100
            f2_local0[2] = 50
            f2_local0[3] = 50
            f2_local0[5] = 200
            f2_local0[22] = 100
        end
    elseif f2_arg1:IsInsideTarget(TARGET_ENE_0, AI_DIR_TYPE_B, 180) then
        f2_local0[21] = 100
        f2_local0[22] = 1
    elseif f2_local3 >= 11 then
        f2_local0[1] = 200
        f2_local0[2] = 350
        f2_local0[3] = 350
    elseif f2_local3 >= 8 then
        f2_local0[1] = 400
        f2_local0[2] = 300
        f2_local0[3] = 300
    elseif f2_local3 > 5 then
        f2_local0[1] = 500
        f2_local0[2] = 250
        f2_local0[3] = 250
        f2_local0[10] = 0
    else
        f2_local0[1] = 400
        f2_local0[2] = 150
        f2_local0[3] = 150
        f2_local0[10] = 300
    end
    if SpaceCheck(f2_arg1, f2_arg2, 45, 2) == false and SpaceCheck(f2_arg1, f2_arg2, -45, 2) == false then
        f2_local0[22] = 0
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
    f2_local0[1] = SetCoolTime(f2_arg1, f2_arg2, 3010, 5, f2_local0[1], 1)
    f2_local0[2] = SetCoolTime(f2_arg1, f2_arg2, 3011, 5, f2_local0[2], 1)
    f2_local0[3] = SetCoolTime(f2_arg1, f2_arg2, 3012, 5, f2_local0[3], 1)
    f2_local0[10] = SetCoolTime(f2_arg1, f2_arg2, 3020, 5, f2_local0[10], 1)
    f2_local1[1] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act01)
    f2_local1[2] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act02)
    f2_local1[3] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act03)
    f2_local1[5] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act05)
    f2_local1[10] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act10)
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
    f2_local1[35] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act35)
    f2_local1[36] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act36)
    local f2_local5 = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.ActAfter_AdjustSpace)
    Common_Battle_Activate(f2_arg1, f2_arg2, f2_local0, f2_local1, f2_local5, f2_local2)
    
end

Goal.Act01 = function (f3_arg0, f3_arg1, f3_arg2)
    local f3_local0 = 4.2 - f3_arg0:GetMapHitRadius(TARGET_SELF) + (f3_arg0:GetRandam_Float(0, 2.5) - 0.8)
    local f3_local1 = f3_local0
    local f3_local2 = f3_local0 + 8
    local f3_local3 = 0
    local f3_local4 = 0
    local f3_local5 = 1.5
    local f3_local6 = 2
    Approach_Act_Flex(f3_arg0, f3_arg1, f3_local0, f3_local1, f3_local2, f3_local3, f3_local4, f3_local5, f3_local6)
    local f3_local7 = 0
    local f3_local8 = 0
    f3_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 10, 3010, TARGET_ENE_0, 9999, f3_local7, f3_local8, 0, 0)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act02 = function (f4_arg0, f4_arg1, f4_arg2)
    local f4_local0 = 5.5 - f4_arg0:GetMapHitRadius(TARGET_SELF) + (f4_arg0:GetRandam_Float(0, 2.5) - 0.8)
    local f4_local1 = f4_local0
    local f4_local2 = f4_local0 + 9
    local f4_local3 = 0
    local f4_local4 = 0
    local f4_local5 = 1.5
    local f4_local6 = 2
    Approach_Act_Flex(f4_arg0, f4_arg1, f4_local0, f4_local1, f4_local2, f4_local3, f4_local4, f4_local5, f4_local6)
    local f4_local7 = 0
    local f4_local8 = 0
    f4_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 10, 3011, TARGET_ENE_0, 9999, f4_local7, f4_local8, 0, 0)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act03 = function (f5_arg0, f5_arg1, f5_arg2)
    local f5_local0 = 2.8 - f5_arg0:GetMapHitRadius(TARGET_SELF) + (f5_arg0:GetRandam_Float(0, 2.5) - 0.8)
    local f5_local1 = f5_local0
    local f5_local2 = f5_local0 + 9
    local f5_local3 = 0
    local f5_local4 = 0
    local f5_local5 = 1.5
    local f5_local6 = 2
    Approach_Act_Flex(f5_arg0, f5_arg1, f5_local0, f5_local1, f5_local2, f5_local3, f5_local4, f5_local5, f5_local6)
    local f5_local7 = 0
    local f5_local8 = 0
    f5_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 10, 3012, TARGET_ENE_0, 9999, f5_local7, f5_local8, 0, 0)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act05 = function (f6_arg0, f6_arg1, f6_arg2)
    local f6_local0 = 0
    local f6_local1 = 0
    f6_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 10, 3025, TARGET_ENE_0, 9999, f6_local0, f6_local1, 0, 0)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act10 = function (f7_arg0, f7_arg1, f7_arg2)
    local f7_local0 = 0
    local f7_local1 = 0
    f7_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 10, 3020, TARGET_ENE_0, 9999, f7_local0, f7_local1, 0, 0)
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
    local f9_local2 = f9_arg0:GetDist(TARGET_FRI_0)
    local f9_local3 = f9_arg0:GetRandam_Int(1, 100)
    if SpaceCheck(f9_arg0, f9_arg1, -45, 2) == true and SpaceCheck(f9_arg0, f9_arg1, 45, 2) == true and f9_local2 >= 2.5 then
        if f9_local3 <= 50 then
            f9_arg1:AddSubGoal(GOAL_COMMON_SpinStep, f9_local0, 5212, TARGET_ENE_0, f9_local1, AI_DIR_TYPE_L, 0)
        else
            f9_arg1:AddSubGoal(GOAL_COMMON_SpinStep, f9_local0, 5213, TARGET_ENE_0, f9_local1, AI_DIR_TYPE_R, 0)
        end
    elseif f9_arg0:IsInsideTarget(TARGET_FRI_0, AI_DIR_TYPE_R, 100) and SpaceCheck(f9_arg0, f9_arg1, -45, 2) == true and f9_local2 <= 2.5 then
        f9_arg1:AddSubGoal(GOAL_COMMON_SpinStep, f9_local0, 5212, TARGET_ENE_0, f9_local1, AI_DIR_TYPE_L, 0)
    elseif f9_arg0:IsInsideTarget(TARGET_FRI_0, AI_DIR_TYPE_L, 100) and SpaceCheck(f9_arg0, f9_arg1, 45, 2) == true and f9_local2 <= 2.5 then
        f9_arg1:AddSubGoal(GOAL_COMMON_SpinStep, f9_local0, 5213, TARGET_ENE_0, f9_local1, AI_DIR_TYPE_R, 0)
    elseif SpaceCheck(f9_arg0, f9_arg1, -45, 2) == true and SpaceCheck(f9_arg0, f9_arg1, 45, 2) == true then
        if f9_local3 <= 50 then
            f9_arg1:AddSubGoal(GOAL_COMMON_SpinStep, f9_local0, 5212, TARGET_ENE_0, f9_local1, AI_DIR_TYPE_L, 0)
        else
            f9_arg1:AddSubGoal(GOAL_COMMON_SpinStep, f9_local0, 5213, TARGET_ENE_0, f9_local1, AI_DIR_TYPE_R, 0)
        end
    elseif SpaceCheck(f9_arg0, f9_arg1, -45, 2) == true then
        f9_arg1:AddSubGoal(GOAL_COMMON_SpinStep, f9_local0, 5212, TARGET_ENE_0, f9_local1, AI_DIR_TYPE_L, 0)
    elseif SpaceCheck(f9_arg0, f9_arg1, 45, 2) == true then
        f9_arg1:AddSubGoal(GOAL_COMMON_SpinStep, f9_local0, 5213, TARGET_ENE_0, f9_local1, AI_DIR_TYPE_R, 0)
    else
    end
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
    
end

Goal.Act23 = function (f10_arg0, f10_arg1, f10_arg2)
    local f10_local0 = f10_arg0:GetDist(TARGET_ENE_0)
    local f10_local1 = f10_arg0:GetDist(TARGET_FRI_0)
    local f10_local2 = f10_arg0:GetSp(TARGET_SELF)
    local f10_local3 = 20
    local f10_local4 = f10_arg0:GetRandam_Int(1, 100)
    local f10_local5 = -1
    local f10_local6 = f10_arg0:GetRandam_Int(0, 1)
    if f10_arg0:IsInsideTarget(TARGET_FRI_0, AI_DIR_TYPE_R, 100) and SpaceCheck(f10_arg0, f10_arg1, -90, 1) == true and f10_local1 <= 2.5 then
        f10_local6 = 0
    elseif f10_arg0:IsInsideTarget(TARGET_FRI_0, AI_DIR_TYPE_L, 100) and SpaceCheck(f10_arg0, f10_arg1, 90, 1) == true and f10_local1 <= 2.5 then
        f10_local6 = 1
    end
    local f10_local7 = 3
    local f10_local8 = f10_arg0:GetRandam_Int(30, 45)
    f10_arg0:SetNumber(10, f10_local6)
    f10_arg1:AddSubGoal(GOAL_COMMON_SidewayMove, f10_local7, TARGET_ENE_0, f10_local6, f10_local8, true, true, f10_local5):TimingSetTimer(2, 4, UPDATE_SUCCESS)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act24 = function (f11_arg0, f11_arg1, f11_arg2)
    local f11_local0 = f11_arg0:GetDist(TARGET_ENE_0)
    local f11_local1 = 3
    local f11_local2 = 0
    local f11_local3 = 5211
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
    local f12_local1 = f12_arg0:GetRandam_Float(1, 3)
    local f12_local2 = f12_arg0:GetDist(TARGET_ENE_0)
    local f12_local3 = -1
    if SpaceCheck(f12_arg0, f12_arg1, 180, 1) == true then
        f12_arg1:AddSubGoal(GOAL_COMMON_LeaveTarget, f12_local0, TARGET_ENE_0, f12_local1, TARGET_ENE_0, true, f12_local3)
    else
    end
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
    
end

Goal.Act26 = function (f13_arg0, f13_arg1, f13_arg2)
    f13_arg1:AddSubGoal(GOAL_COMMON_Wait, 0.5, TARGET_SELF, 0, 0, 0)
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
    
end

Goal.Act27 = function (f14_arg0, f14_arg1, f14_arg2)
    local f14_local0 = f14_arg0:GetDist(TARGET_ENE_0)
    local f14_local1 = f14_arg0:GetDistYSigned(TARGET_ENE_0)
    local f14_local2 = f14_local1 / math.tan(math.deg(30))
    local f14_local3 = f14_arg0:GetRandam_Int(0, 1)
    if f14_local1 >= 3 then
        if f14_local2 + 1 <= f14_local0 then
            if SpaceCheck(f14_arg0, f14_arg1, 0, 4) == true then
                f14_arg1:AddSubGoal(GOAL_COMMON_ApproachTarget, 0.1, TARGET_ENE_0, f14_local2, TARGET_SELF, false, -1)
            elseif SpaceCheck(f14_arg0, f14_arg1, 0, 3) == true then
                f14_arg1:AddSubGoal(GOAL_COMMON_ApproachTarget, 0.5, TARGET_ENE_0, f14_local2, TARGET_SELF, true, -1)
            end
        elseif f14_local0 <= f14_local2 - 1 then
            f14_arg1:AddSubGoal(GOAL_COMMON_LeaveTarget, 10, TARGET_ENE_0, f14_local2, TARGET_ENE_0, true, -1)
        end
    elseif SpaceCheck(f14_arg0, f14_arg1, 0, 4) == true then
        f14_arg1:AddSubGoal(GOAL_COMMON_ApproachTarget, 0.1, TARGET_ENE_0, 0, TARGET_SELF, false, -1)
    elseif SpaceCheck(f14_arg0, f14_arg1, 0, 3) == true then
        f14_arg1:AddSubGoal(GOAL_COMMON_ApproachTarget, 0.5, TARGET_ENE_0, 0, TARGET_SELF, true, -1)
    elseif SpaceCheck(f14_arg0, f14_arg1, 0, 1) == false then
        f14_arg1:AddSubGoal(GOAL_COMMON_LeaveTarget, 0.5, TARGET_ENE_0, 999, TARGET_ENE_0, true, -1)
    end
    f14_arg0:SetNumber(10, f14_local3)
    f14_arg1:AddSubGoal(GOAL_COMMON_SidewayMove, 3, TARGET_ENE_0, f14_local3, f14_arg0:GetRandam_Int(30, 45), true, true, -1)
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
    
end

Goal.Act28 = function (f15_arg0, f15_arg1, f15_arg2)
    local f15_local0 = f15_arg0:GetDist(TARGET_ENE_0)
    local f15_local1 = f15_arg0:GetRandam_Float(1, 3.5)
    local f15_local2 = 1.5
    local f15_local3 = f15_arg0:GetRandam_Int(30, 45)
    local f15_local4 = -1
    local f15_local5 = f15_arg0:GetRandam_Int(0, 1)
    if f15_local0 <= 9 then
        f15_arg1:AddSubGoal(GOAL_COMMON_SidewayMove, f15_local1, TARGET_ENE_0, f15_local5, f15_local3, true, true, f15_local4)
    elseif f15_local0 <= 13 then
        f15_arg1:AddSubGoal(GOAL_COMMON_ApproachTarget, f15_local2, TARGET_ENE_0, 7.9, TARGET_SELF, true, -1)
    else
        f15_arg1:AddSubGoal(GOAL_COMMON_ApproachTarget, f15_local2, TARGET_ENE_0, 14.9, TARGET_SELF, false, -1)
    end
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
    
end

Goal.Act29 = function (f16_arg0, f16_arg1, f16_arg2)
    local f16_local0 = f16_arg0:GetDist(TARGET_ENE_0)
    local f16_local1 = 7
    local f16_local2 = 0
    local f16_local3 = f16_arg0:GetRandam_Float(1, 3.5)
    f16_arg1:AddSubGoal(GOAL_COMMON_LeaveTarget, f16_local3, TARGET_ENE_0, f16_local1, TARGET_ENE_0, true, -1)
    
end

Goal.Act30 = function (f17_arg0, f17_arg1, f17_arg2)
    local f17_local0 = 3.5
    local f17_local1 = f17_arg0:GetRandam_Int(30, 45)
    local f17_local2 = 0
    if SpaceCheck(f17_arg0, f17_arg1, -90, 1) == true then
        if SpaceCheck(f17_arg0, f17_arg1, 90, 1) == true then
            if f17_arg0:IsInsideTarget(TARGET_ENE_0, AI_DIR_TYPE_R, 180) then
                f17_local2 = 0
            else
                f17_local2 = 1
            end
        else
            f17_local2 = 0
        end
    elseif SpaceCheck(f17_arg0, f17_arg1, 90, 1) == true then
        f17_local2 = 1
    else
    end
    f17_arg1:AddSubGoal(GOAL_COMMON_SidewayMove, f17_local0, TARGET_ENE_0, f17_local2, f17_local1, true, true, -1)
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
    
end

Goal.Act35 = function (f18_arg0, f18_arg1, f18_arg2)
    local f18_local0 = f18_arg0:GetDist(TARGET_ENE_0)
    local f18_local1 = f18_arg0:GetRandam_Int(1, 100)
    local f18_local2 = f18_arg0:GetRandam_Int(0, 1)
    local f18_local3 = f18_arg0:GetRandam_Float(2, 3.5)
    local f18_local4 = 3
    local f18_local5 = 0
    local f18_local6 = f18_arg0:GetDist(TARGET_FRI_0)
    local f18_local7 = f18_arg0:GetRandam_Int(1, 100)
    local f18_local8 = f18_arg0:GetRandam_Float(6.5, 7.5)
    local f18_local9 = f18_arg0:GetRandam_Float(5.5, 6.5)
    local f18_local10 = 999
    local f18_local11 = 100
    if f18_local0 >= 10 then
        Approach_Act(f18_arg0, f18_arg1, f18_local8, f18_local10, 0, 3)
    elseif f18_local0 >= 5 then
    elseif f18_local0 >= 3.5 then
        f18_arg1:AddSubGoal(GOAL_COMMON_LeaveTarget, 3, TARGET_ENE_0, f18_local8, TARGET_ENE_0, false, 9910)
    else
        f18_arg1:AddSubGoal(GOAL_COMMON_SpinStep, 5, 5201, TARGET_ENE_0, 0, AI_DIR_TYPE_B, 2)
    end
    f18_arg1:AddSubGoal(GOAL_COMMON_SidewayMove, f18_local3, TARGET_ENE_0, f18_local2, f18_arg0:GetRandam_Int(30, 45), true, true, 9910):TimingSetTimer(2, 4, UPDATE_SUCCESS)
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
    
end

Goal.Act36 = function (f19_arg0, f19_arg1, f19_arg2)
    local f19_local0 = -0.5
    f19_arg0:SetEventMoveTarget(1502251)
    f19_arg1:AddSubGoal(GOAL_COMMON_ApproachTarget, 3, POINT_EVENT, f19_local0, POINT_EVENT, false, -1)
    
end

Goal.Interrupt = function (f20_arg0, f20_arg1, f20_arg2)
    local f20_local0 = f20_arg1:GetSpecialEffectActivateInterruptType(0)
    if f20_arg1:IsLadderAct(TARGET_SELF) then
        return false
    end
    if not f20_arg1:HasSpecialEffectId(TARGET_SELF, 200004) then
        return false
    end
    if f20_arg1:IsInterupt(INTERUPT_Damaged) then
        return f20_arg0.Damaged(f20_arg1, f20_arg2)
    end
    return false
    
end

Goal.Parry = function (f21_arg0, f21_arg1, f21_arg2)
    local f21_local0 = f21_arg0:GetHpRate(TARGET_SELF)
    local f21_local1 = f21_arg0:GetDist(TARGET_ENE_0)
    local f21_local2 = f21_arg0:GetSp(TARGET_SELF)
    local f21_local3 = f21_arg0:GetRandam_Int(1, 100)
    local f21_local4 = 0
    if not f21_arg0:IsInsideTarget(TARGET_ENE_0, AI_DIR_TYPE_F, 90) or not f21_arg0:IsInsideTargetEx(TARGET_ENE_0, TARGET_SELF, AI_DIR_TYPE_F, 90, 3) or f21_arg0:HasSpecialEffectId(TARGET_ENE_0, 109012) then
    elseif f21_arg0:IsTargetGuard(TARGET_SELF) then
        if f21_arg0:HasSpecialEffectId(TARGET_ENE_0, 109970) then
        else
            f21_arg1:ClearSubGoal()
            f21_arg1:AddSubGoal(GOAL_COMMON_EndureAttack, 0.1, 3100, TARGET_ENE_0, 9999, 0)
            return true
        end
    elseif f21_arg0:HasSpecialEffectId(TARGET_ENE_0, 109970) then
        f21_arg1:ClearSubGoal()
        f21_arg1:AddSubGoal(GOAL_COMMON_EndureAttack, 0.1, 3101, TARGET_ENE_0, 9999, 0)
        return true
    else
        f21_arg1:ClearSubGoal()
        f21_arg1:AddSubGoal(GOAL_COMMON_EndureAttack, 0.1, 3100, TARGET_ENE_0, 9999, 0)
        return true
    end
    return false
    
end

Goal.Damaged = function (f22_arg0, f22_arg1, f22_arg2)
    local f22_local0 = f22_arg0:GetHpRate(TARGET_SELF)
    local f22_local1 = f22_arg0:GetDist(TARGET_ENE_0)
    local f22_local2 = f22_arg0:GetSp(TARGET_SELF)
    local f22_local3 = f22_arg0:GetRandam_Int(1, 100)
    local f22_local4 = 0
    if f22_local3 <= 33 then
        f22_arg1:ClearSubGoal()
        f22_arg1:AddSubGoal(GOAL_COMMON_SpinStep, StepLife, 5211, TARGET_ENE_0, TurnTime, AI_DIR_TYPE_B, 0):TimingSetTimer(3, 6, UPDATE_SUCCESS)
        return true
    elseif f22_local3 <= 67 then
    end
    return false
    
end

Goal.ActAfter_AdjustSpace = function (f23_arg0, f23_arg1, f23_arg2)
    f23_arg1:AddSubGoal(GOAL_MurabitoZombie_takeyari_150040_AfterAttackAct, 10)
    
end

Goal.Update = function (f24_arg0, f24_arg1, f24_arg2)
    return Update_Default_NoSubGoal(f24_arg0, f24_arg1, f24_arg2)
    
end

Goal.Terminate = function (f25_arg0, f25_arg1, f25_arg2)
    
end

RegisterTableGoal(GOAL_MurabitoZombie_takeyari_150040_AfterAttackAct, "GOAL_MurabitoZombie_takeyari_150040_AfterAttackAct")
REGISTER_GOAL_NO_SUB_GOAL(GOAL_MurabitoZombie_takeyari_150040_AfterAttackAct, true)

Goal.Activate = function (f26_arg0, f26_arg1, f26_arg2)
    local f26_local0 = f26_arg1:GetDist(TARGET_ENE_0)
    local f26_local1 = f26_arg1:GetToTargetAngle(TARGET_ENE_0)
    local f26_local2 = f26_arg1:GetHpRate(TARGET_SELF)
    local f26_local3 = {}
    if f26_arg1:IsInsideTarget(TARGET_ENE_0, AI_DIR_TYPE_B, 160) then
        f26_local3[1] = 100
        f26_local3[2] = 0
        f26_local3[3] = 0
    elseif f26_local0 >= 7 then
        f26_local3[1] = 100
        f26_local3[2] = 0
        f26_local3[3] = 0
    elseif f26_local0 >= 3 then
        f26_local3[1] = 30
        f26_local3[2] = 45
        f26_local3[3] = 25
    else
        f26_local3[1] = 30
        f26_local3[2] = 20
        f26_local3[3] = 50
    end
    local f26_local4 = SelectOddsIndex(f26_arg1, f26_local3)
    if f26_local4 == 1 then
    elseif f26_local4 == 2 then
        f26_arg2:AddSubGoal(GOAL_COMMON_SidewayMove, f26_arg1:GetRandam_Float(0, 1), TARGET_ENE_0, f26_arg1:GetRandam_Int(1.5, 3), f26_arg1:GetRandam_Int(30, 45), true, true, -1)
    elseif f26_local4 == 3 then
        f26_arg2:AddSubGoal(GOAL_COMMON_LeaveTarget, f26_arg1:GetRandam_Int(1.5, 3), TARGET_ENE_0, 7, TARGET_ENE_0, true, -1)
    end
    
end

Goal.Update = function (f27_arg0, f27_arg1, f27_arg2)
    return Update_Default_NoSubGoal(f27_arg0, f27_arg1, f27_arg2)
    
end


