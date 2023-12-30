﻿RegisterTableGoal(GOAL_MurabitoZombie_kumade_genkaku_151010_Battle, "GOAL_MurabitoZombie_kumade_genkaku_151010_Battle")
REGISTER_GOAL_NO_UPDATE(GOAL_MurabitoZombie_kumade_genkaku_151010_Battle, true)

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
    local f2_local5 = f2_arg1:GetDistAtoB(TARGET_EVENT, POINT_EVENT)
    local f2_local6 = f2_arg1:GetEventRequest()
    f2_arg1:AddObserveSpecialEffectAttribute(TARGET_ENE_0, 110124)
    if f2_arg1:GetNumber(1) == 0 then
        if f2_arg1:HasSpecialEffectId(TARGET_SELF, 5020) then
            f2_local0[44] = 100
            f2_arg1:SetNumber(1, 44)
        else
            f2_local0[43] = 100
            f2_arg1:SetNumber(1, 43)
        end
    elseif f2_arg1:IsEventFlag(19952081) == true then
        if f2_local3 >= 8 then
            f2_local0[7] = 100
        elseif f2_local3 >= 5 then
            f2_local0[7] = 100
            f2_local0[23] = 100
        else
            f2_local0[6] = 100
            f2_local0[25] = 100
            f2_local0[27] = 100
        end
    elseif f2_arg1:IsEventFlag(19952082) == true then
        f2_local0[1] = 200
        f2_local0[2] = 200
    elseif f2_arg1:HasSpecialEffectId(TARGET_ENE_0, 110010) then
        KankyakuAct(f2_arg1, f2_arg2, 0)
    elseif Common_ActivateAct(f2_arg1, f2_arg2) then
    elseif f2_arg1:CheckDoesExistPath(TARGET_ENE_0, AI_DIR_TYPE_F, 0, 0) == false then
        f2_local0[27] = 100
    elseif f2_arg1:HasSpecialEffectId(TARGET_ENE_0, 110124) == true then
        f2_local0[35] = 1000
    elseif f2_local4 == 1 and f2_arg1:GetTeamOrder(ORDER_TYPE_Role) == ROLE_TYPE_Kankyaku then
        if f2_local3 >= 7 then
            f2_local0[2] = 100
            f2_local0[5] = 100
            f2_local0[22] = 300
            f2_local0[28] = 500
            f2_local0[29] = 0
        elseif f2_local3 >= 3 then
            f2_local0[2] = 200
            f2_local0[5] = 100
            f2_local0[22] = 200
            f2_local0[24] = 200
            f2_local0[28] = 200
            f2_local0[29] = 100
        else
            f2_local0[1] = 300
            f2_local0[22] = 100
            f2_local0[24] = 200
            f2_local0[28] = 200
            f2_local0[29] = 200
        end
    elseif f2_local4 == 1 and f2_arg1:GetTeamOrder(ORDER_TYPE_Role) == ROLE_TYPE_Torimaki then
        if f2_local3 >= 7 then
            f2_local0[2] = 300
            f2_local0[5] = 50
            f2_local0[22] = 300
            f2_local0[28] = 350
            f2_local0[29] = 0
        elseif f2_local3 >= 3 then
            f2_local0[2] = 300
            f2_local0[5] = 50
            f2_local0[22] = 100
            f2_local0[24] = 150
            f2_local0[28] = 200
            f2_local0[29] = 200
        else
            f2_local0[1] = 200
            f2_local0[22] = 100
            f2_local0[24] = 200
            f2_local0[28] = 200
            f2_local0[29] = 300
        end
    elseif f2_arg1:HasSpecialEffectId(TARGET_ENE_0, 110030) then
        f2_local0[28] = 100
    elseif f2_arg1:IsInsideTarget(TARGET_ENE_0, AI_DIR_TYPE_B, 180) then
        f2_local0[21] = 100
        f2_local0[22] = 1
    elseif f2_local3 >= 10 then
        f2_local0[1] = 300
        f2_local0[2] = 700
    elseif f2_local3 >= 5 then
        f2_local0[1] = 400
        f2_local0[2] = 600
    elseif f2_local3 > 3 then
        f2_local0[1] = 500
        f2_local0[2] = 400
        f2_local0[24] = 100
    else
        f2_local0[1] = 400
        f2_local0[2] = 350
        f2_local0[24] = 250
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
    f2_local0[1] = SetCoolTime(f2_arg1, f2_arg2, 3020, 5, f2_local0[1], 1)
    f2_local0[2] = SetCoolTime(f2_arg1, f2_arg2, 3021, 5, f2_local0[2], 1)
    f2_local0[5] = SetCoolTime(f2_arg1, f2_arg2, 3025, 10, f2_local0[5], 1)
    f2_local1[1] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act01)
    f2_local1[2] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act02)
    f2_local1[5] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act05)
    f2_local1[6] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act06)
    f2_local1[7] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act07)
    f2_local1[21] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act21)
    f2_local1[22] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act22)
    f2_local1[23] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act23)
    f2_local1[24] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act24)
    f2_local1[25] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act25)
    f2_local1[26] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act26)
    f2_local1[27] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act27)
    f2_local1[28] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act28)
    f2_local1[29] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act29)
    f2_local1[35] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act35)
    f2_local1[36] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act36)
    f2_local1[37] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act37)
    f2_local1[38] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act38)
    f2_local1[40] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act40)
    f2_local1[41] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act41)
    f2_local1[42] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act42)
    f2_local1[43] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act43)
    f2_local1[44] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act44)
    local f2_local7 = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.ActAfter_AdjustSpace)
    Common_Battle_Activate(f2_arg1, f2_arg2, f2_local0, f2_local1, f2_local7, f2_local2)
    
end

Goal.Act01 = function (f3_arg0, f3_arg1, f3_arg2)
    local f3_local0 = 2.2 - f3_arg0:GetMapHitRadius(TARGET_SELF) + (f3_arg0:GetRandam_Float(0, 2.5) - 0.8)
    local f3_local1 = f3_local0
    local f3_local2 = f3_local0 + 0.5
    local f3_local3 = 100
    local f3_local4 = 0
    local f3_local5 = 1.5
    local f3_local6 = 3
    Approach_Act_Flex(f3_arg0, f3_arg1, f3_local0, f3_local1, f3_local2, f3_local3, f3_local4, f3_local5, f3_local6)
    local f3_local7 = 0
    local f3_local8 = 0
    f3_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 10, 3020, TARGET_ENE_0, 9999, f3_local7, f3_local8, 0, 0)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act02 = function (f4_arg0, f4_arg1, f4_arg2)
    local f4_local0 = 2.6 - f4_arg0:GetMapHitRadius(TARGET_SELF) + (f4_arg0:GetRandam_Float(0, 2.5) - 0.8)
    local f4_local1 = f4_local0
    local f4_local2 = f4_local0 + 1
    local f4_local3 = 100
    local f4_local4 = 0
    local f4_local5 = 1.5
    local f4_local6 = 3
    Approach_Act_Flex(f4_arg0, f4_arg1, f4_local0, f4_local1, f4_local2, f4_local3, f4_local4, f4_local5, f4_local6)
    local f4_local7 = 0
    local f4_local8 = 0
    f4_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 10, 3021, TARGET_ENE_0, 9999, f4_local7, f4_local8, 0, 0)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act05 = function (f5_arg0, f5_arg1, f5_arg2)
    local f5_local0 = 0
    local f5_local1 = 0
    f5_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 10, 3025, TARGET_ENE_0, 9999, f5_local0, f5_local1, 0, 0)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act06 = function (f6_arg0, f6_arg1, f6_arg2)
    local f6_local0 = -1
    local f6_local1 = f6_arg0:GetRandam_Int(0, 100)
    local f6_local2 = f6_arg0:GetRandam_Int(0, 1)
    local f6_local3 = 3
    local f6_local4 = f6_arg0:GetRandam_Int(30, 45)
    if SpaceCheck(f6_arg0, f6_arg1, -90, 1) == true then
        f6_local2 = 0
    elseif SpaceCheck(f6_arg0, f6_arg1, 90, 1) == true then
        f6_local2 = 1
    end
    if SpaceCheck(f6_arg0, f6_arg1, 180, 1) == true then
        f6_arg1:AddSubGoal(GOAL_COMMON_LeaveTarget, 10, TARGET_ENE_0, 8, TARGET_ENE_0, true, f6_local0)
    else
        f6_arg1:AddSubGoal(GOAL_COMMON_SidewayMove, f6_local3, TARGET_ENE_0, f6_local2, f6_local4, true, true, f6_local0)
    end
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act07 = function (f7_arg0, f7_arg1, f7_arg2)
    local f7_local0 = 5
    local f7_local1 = 10
    local f7_local2 = 15
    local f7_local3 = 0
    local f7_local4 = 0
    local f7_local5 = 1.5
    local f7_local6 = 2
    Approach_Act_Flex(f7_arg0, f7_arg1, f7_local0, f7_local1, f7_local2, f7_local3, f7_local4, f7_local5, f7_local6)
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
        f9_arg1:AddSubGoal(GOAL_COMMON_Wait, 0.5, TARGET_SELF, 0, 0, 0)
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
            if SpaceCheck(f14_arg0, f14_arg1, 0, 5) == true then
                f14_arg1:AddSubGoal(GOAL_COMMON_ApproachTarget, 0.1, TARGET_ENE_0, f14_local2, TARGET_SELF, false, -1)
            elseif SpaceCheck(f14_arg0, f14_arg1, 0, 3) == true then
                f14_arg1:AddSubGoal(GOAL_COMMON_ApproachTarget, 0.5, TARGET_ENE_0, f14_local2, TARGET_SELF, true, -1)
            end
        elseif f14_local0 <= f14_local2 - 1 then
            f14_arg1:AddSubGoal(GOAL_COMMON_LeaveTarget, 10, TARGET_ENE_0, f14_local2, TARGET_ENE_0, true, -1)
        end
    elseif SpaceCheck(f14_arg0, f14_arg1, 0, 5) == true then
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
    local f15_local1 = f15_arg0:GetRandam_Float(2, 3.5)
    local f15_local2 = 1.5
    local f15_local3 = f15_arg0:GetRandam_Int(30, 45)
    local f15_local4 = -1
    local f15_local5 = f15_arg0:GetRandam_Int(0, 1)
    if f15_local0 <= 8 then
        f15_arg1:AddSubGoal(GOAL_COMMON_SidewayMove, f15_local1, TARGET_ENE_0, f15_local5, f15_local3, true, true, f15_local4)
    elseif f15_local0 <= 10 then
        f15_arg1:AddSubGoal(GOAL_COMMON_ApproachTarget, f15_local2, TARGET_ENE_0, 7.9, TARGET_SELF, true, -1)
    else
        f15_arg1:AddSubGoal(GOAL_COMMON_ApproachTarget, f15_local2, TARGET_ENE_0, 9.9, TARGET_SELF, false, -1)
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

Goal.Act35 = function (f17_arg0, f17_arg1, f17_arg2)
    local f17_local0 = f17_arg0:GetDist(TARGET_ENE_0)
    local f17_local1 = f17_arg0:GetRandam_Int(1, 100)
    local f17_local2 = f17_arg0:GetRandam_Int(0, 1)
    local f17_local3 = f17_arg0:GetRandam_Float(2, 3.5)
    local f17_local4 = 3
    local f17_local5 = 0
    local f17_local6 = f17_arg0:GetDist(TARGET_FRI_0)
    local f17_local7 = f17_arg0:GetRandam_Int(1, 100)
    local f17_local8 = f17_arg0:GetRandam_Float(6.5, 7.5)
    local f17_local9 = f17_arg0:GetRandam_Float(5.5, 6.5)
    local f17_local10 = 999
    local f17_local11 = 100
    if f17_local0 >= 10 then
        Approach_Act(f17_arg0, f17_arg1, f17_local8, f17_local10, 0, 3)
    elseif f17_local0 >= 5 then
    elseif f17_local0 >= 3.5 then
        f17_arg1:AddSubGoal(GOAL_COMMON_LeaveTarget, 3, TARGET_ENE_0, f17_local8, TARGET_ENE_0, false, 9910)
    else
        f17_arg1:AddSubGoal(GOAL_COMMON_SpinStep, 5, 5201, TARGET_ENE_0, 0, AI_DIR_TYPE_B, 2)
    end
    f17_arg1:AddSubGoal(GOAL_COMMON_SidewayMove, f17_local3, TARGET_ENE_0, f17_local2, f17_arg0:GetRandam_Int(30, 45), true, true, 9910):TimingSetTimer(2, 4, UPDATE_SUCCESS)
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
    
end

Goal.Act36 = function (f18_arg0, f18_arg1, f18_arg2)
    local f18_local0 = f18_arg0:GetRandam_Int(9992930, 9992937)
    f18_arg0:SetNumber(2, f18_local0)
    f18_arg0:SetEventMoveTarget(f18_local0)
    f18_arg1:AddSubGoal(GOAL_COMMON_ToTargetWarp, 10, POINT_EVENT, AI_DIR_TYPE_F, 0, TARGET_ENE_0)
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
    
end

Goal.Act37 = function (f19_arg0, f19_arg1, f19_arg2)
    local f19_local0 = f19_arg0:GetRandam_Int(9992934, 9992941)
    f19_arg0:SetNumber(2, f19_local0)
    f19_arg0:SetEventMoveTarget(f19_local0)
    f19_arg1:AddSubGoal(GOAL_COMMON_ToTargetWarp, 10, POINT_EVENT, AI_DIR_TYPE_F, 0, TARGET_ENE_0)
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
    
end

Goal.Act38 = function (f20_arg0, f20_arg1, f20_arg2)
    local f20_local0 = f20_arg0:GetRandam_Int(9992938, 9992945)
    f20_arg0:SetNumber(2, f20_local0)
    f20_arg0:SetEventMoveTarget(f20_local0)
    f20_arg1:AddSubGoal(GOAL_COMMON_ToTargetWarp, 10, POINT_EVENT, AI_DIR_TYPE_F, 0, TARGET_ENE_0)
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
    
end

Goal.Act40 = function (f21_arg0, f21_arg1, f21_arg2)
    local f21_local0 = f21_arg0:GetRandam_Int(9992960, 9992967)
    f21_arg0:SetNumber(2, f21_local0)
    f21_arg0:SetEventMoveTarget(f21_local0)
    f21_arg1:AddSubGoal(GOAL_COMMON_ToTargetWarp, 10, POINT_EVENT, AI_DIR_TYPE_F, 0, TARGET_ENE_0)
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
    
end

Goal.Act41 = function (f22_arg0, f22_arg1, f22_arg2)
    local f22_local0 = f22_arg0:GetRandam_Int(9992964, 9992971)
    f22_arg0:SetNumber(2, f22_local0)
    f22_arg0:SetEventMoveTarget(f22_local0)
    f22_arg1:AddSubGoal(GOAL_COMMON_ToTargetWarp, 10, POINT_EVENT, AI_DIR_TYPE_F, 0, TARGET_ENE_0)
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
    
end

Goal.Act42 = function (f23_arg0, f23_arg1, f23_arg2)
    local f23_local0 = f23_arg0:GetRandam_Int(9992968, 9992975)
    f23_arg0:SetNumber(2, f23_local0)
    f23_arg0:SetEventMoveTarget(f23_local0)
    f23_arg1:AddSubGoal(GOAL_COMMON_ToTargetWarp, 10, POINT_EVENT, AI_DIR_TYPE_F, 0, TARGET_ENE_0)
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
    
end

Goal.Act43 = function (f24_arg0, f24_arg1, f24_arg2)
    local f24_local0 = f24_arg0:GetRandam_Float(0, 1)
    local f24_local1 = f24_arg0:GetRandam_Int(9992810, 9992817)
    f24_arg0:SetNumber(2, f24_local1)
    f24_arg0:SetEventMoveTarget(f24_local1)
    f24_arg1:AddSubGoal(GOAL_COMMON_ToTargetWarp, 10, POINT_EVENT, AI_DIR_TYPE_F, f24_local0, TARGET_ENE_0)
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
    
end

Goal.Act44 = function (f25_arg0, f25_arg1, f25_arg2)
    local f25_local0 = f25_arg0:GetRandam_Int(0, 1)
    local f25_local1 = f25_arg0:GetRandam_Int(9992800, 9992807)
    f25_arg0:SetNumber(2, f25_local1)
    f25_arg0:SetEventMoveTarget(f25_local1)
    f25_arg1:AddSubGoal(GOAL_COMMON_ToTargetWarp, 10, POINT_EVENT, AI_DIR_TYPE_F, f25_local0, TARGET_ENE_0)
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
    
end

Goal.Interrupt = function (f26_arg0, f26_arg1, f26_arg2)
    local f26_local0 = f26_arg1:GetSpecialEffectActivateInterruptType(0)
    if f26_arg1:IsLadderAct(TARGET_SELF) then
        return false
    end
    if not f26_arg1:HasSpecialEffectId(TARGET_SELF, 200004) then
        return false
    end
    if f26_arg1:IsInterupt(INTERUPT_Damaged) then
        return f26_arg0.Damaged(f26_arg1, f26_arg2)
    end
    if f26_arg1:GetSpecialEffectActivateInterruptType(0) == 110124 then
        f26_arg2:ClearSubGoal()
        f26_arg1:Replaning()
        return false
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
    local f28_local0 = f28_arg0:GetHpRate(TARGET_SELF)
    local f28_local1 = f28_arg0:GetDist(TARGET_ENE_0)
    local f28_local2 = f28_arg0:GetSp(TARGET_SELF)
    local f28_local3 = f28_arg0:GetRandam_Int(1, 100)
    local f28_local4 = 0
    if f28_local3 <= 33 then
        f28_arg1:ClearSubGoal()
        f28_arg1:AddSubGoal(GOAL_COMMON_SpinStep, StepLife, 5211, TARGET_ENE_0, TurnTime, AI_DIR_TYPE_B, 0):TimingSetTimer(3, 6, UPDATE_SUCCESS)
        return true
    elseif f28_local3 <= 67 then
    end
    return false
    
end

Goal.ActAfter_AdjustSpace = function (f29_arg0, f29_arg1, f29_arg2)
    f29_arg1:AddSubGoal(GOAL_MurabitoZombie_kumade_genkaku_151010_AfterAttackAct, 10)
    
end

Goal.Update = function (f30_arg0, f30_arg1, f30_arg2)
    return Update_Default_NoSubGoal(f30_arg0, f30_arg1, f30_arg2)
    
end

Goal.Terminate = function (f31_arg0, f31_arg1, f31_arg2)
    
end

RegisterTableGoal(GOAL_MurabitoZombie_kumade_genkaku_151010_AfterAttackAct, "GOAL_MurabitoZombie_kumade_genkaku_151010_AfterAttackAct")
REGISTER_GOAL_NO_SUB_GOAL(GOAL_MurabitoZombie_kumade_genkaku_151010_AfterAttackAct, true)

Goal.Activate = function (f32_arg0, f32_arg1, f32_arg2)
    local f32_local0 = f32_arg1:GetDist(TARGET_ENE_0)
    local f32_local1 = f32_arg1:GetToTargetAngle(TARGET_ENE_0)
    local f32_local2 = f32_arg1:GetHpRate(TARGET_SELF)
    local f32_local3 = {}
    if f32_arg1:IsInsideTarget(TARGET_ENE_0, AI_DIR_TYPE_B, 160) then
        f32_local3[1] = 100
        f32_local3[2] = 0
        f32_local3[3] = 0
    elseif f32_local0 >= 7 then
        f32_local3[1] = 100
        f32_local3[2] = 0
        f32_local3[3] = 0
    elseif f32_local0 >= 3 then
        f32_local3[1] = 30
        f32_local3[2] = 45
        f32_local3[3] = 25
    else
        f32_local3[1] = 30
        f32_local3[2] = 20
        f32_local3[3] = 50
    end
    local f32_local4 = SelectOddsIndex(f32_arg1, f32_local3)
    if f32_local4 == 1 then
    elseif f32_local4 == 2 then
        f32_arg2:AddSubGoal(GOAL_COMMON_SidewayMove, f32_arg1:GetRandam_Float(0, 1), TARGET_ENE_0, f32_arg1:GetRandam_Int(1.5, 3), f32_arg1:GetRandam_Int(30, 45), true, true, -1)
    elseif f32_local4 == 3 then
        f32_arg2:AddSubGoal(GOAL_COMMON_LeaveTarget, f32_arg1:GetRandam_Int(1.5, 3), TARGET_ENE_0, 7, TARGET_ENE_0, true, -1)
    end
    
end

Goal.Update = function (f33_arg0, f33_arg1, f33_arg2)
    return Update_Default_NoSubGoal(f33_arg0, f33_arg1, f33_arg2)
    
end


