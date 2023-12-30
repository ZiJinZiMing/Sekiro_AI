﻿RegisterTableGoal(GOAL_MurabitoZombie_syujin_150060_Battle, "GOAL_MurabitoZombie_syujin_150060_Battle")
REGISTER_GOAL_NO_UPDATE(GOAL_MurabitoZombie_syujin_150060_Battle, true)

Goal.Initialize = function (f1_arg0, f1_arg1, f1_arg2, f1_arg3)
    
end

Goal.Activate = function (f2_arg0, f2_arg1, f2_arg2)
    f2_arg1:DeleteObserve(0)
    Init_Pseudo_Global(f2_arg1, f2_arg2)
    local f2_local0 = {}
    local f2_local1 = {}
    local f2_local2 = {}
    Common_Clear_Param(f2_local0, f2_local1, f2_local2)
    local f2_local3 = f2_arg1:GetDist(TARGET_ENE_0)
    local f2_local4 = f2_arg1:GetExcelParam(AI_EXCEL_THINK_PARAM_TYPE__thinkAttr_doAdmirer)
    f2_arg1:AddObserveSpecialEffectAttribute(TARGET_SELF, 5025)
    f2_arg1:AddObserveSpecialEffectAttribute(TARGET_SELF, 5026)
    f2_arg1:AddObserveSpecialEffectAttribute(TARGET_SELF, 3150111)
    if Common_ActivateAct(f2_arg1, f2_arg2) then
    elseif f2_arg1:CheckDoesExistPath(TARGET_ENE_0, AI_DIR_TYPE_F, 0, 0) == false then
        f2_local0[27] = 100
    elseif f2_local4 == 1 and f2_arg1:GetTeamOrder(ORDER_TYPE_Role) == ROLE_TYPE_Kankyaku then
        KankyakuAct(f2_arg1, f2_arg2)
    elseif f2_local4 == 1 and f2_arg1:GetTeamOrder(ORDER_TYPE_Role) == ROLE_TYPE_Torimaki then
        TorimakiAct(f2_arg1, f2_arg2, -1, 0)
    elseif not f2_arg1:IsExistMeshOnLine(TARGET_ENE_0, AI_DIR_TYPE_ToB, f2_local3) and f2_arg1:CheckDoesExistPath(TARGET_ENE_0, AI_DIR_TYPE_F, 0, 0) == true then
        f2_local0[40] = 300
    elseif f2_arg1:IsInsideTarget(TARGET_ENE_0, AI_DIR_TYPE_B, 150) then
        f2_local0[21] = 100
    else
        f2_local0[4] = 300
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
    f2_local0[1] = SetCoolTime(f2_arg1, f2_arg2, 3005, 5, f2_local0[1], 1)
    f2_local0[2] = SetCoolTime(f2_arg1, f2_arg2, 3006, 15, f2_local0[2], 1)
    f2_local0[3] = SetCoolTime(f2_arg1, f2_arg2, 3007, 8, f2_local0[3], 1)
    f2_local0[4] = SetCoolTime(f2_arg1, f2_arg2, 3011, 8, f2_local0[4], 1)
    f2_local1[1] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act01)
    f2_local1[2] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act02)
    f2_local1[3] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act03)
    f2_local1[4] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act04)
    f2_local1[40] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act40)
    f2_local1[21] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act21)
    f2_local1[22] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act22)
    f2_local1[23] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act23)
    f2_local1[24] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act24)
    f2_local1[25] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act25)
    f2_local1[26] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act26)
    f2_local1[27] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act27)
    f2_local1[28] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act28)
    local f2_local5 = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.ActAfter_AdjustSpace)
    Common_Battle_Activate(f2_arg1, f2_arg2, f2_local0, f2_local1, f2_local5, f2_local2)
    
end

Goal.Act01 = function (f3_arg0, f3_arg1, f3_arg2)
    local f3_local0 = 3 - f3_arg0:GetMapHitRadius(TARGET_SELF)
    local f3_local1 = 3 - f3_arg0:GetMapHitRadius(TARGET_SELF) + 99
    local f3_local2 = 3 - f3_arg0:GetMapHitRadius(TARGET_SELF) + 100
    local f3_local3 = 100
    local f3_local4 = 0
    local f3_local5 = 3
    local f3_local6 = 3
    Approach_Act_Flex(f3_arg0, f3_arg1, f3_local0, f3_local1, f3_local2, f3_local3, f3_local4, f3_local5, f3_local6)
    local f3_local7 = ATT3001_DIST_MAX
    local f3_local8 = ATT3002_DIST_MAX
    local f3_local9 = 0
    local f3_local10 = 0
    f3_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 10, 3005, TARGET_ENE_0, 9999, f3_local9, f3_local10, 0, 0)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act02 = function (f4_arg0, f4_arg1, f4_arg2)
    local f4_local0 = 2.5 - f4_arg0:GetMapHitRadius(TARGET_SELF)
    local f4_local1 = 2.5 - f4_arg0:GetMapHitRadius(TARGET_SELF) + 99
    local f4_local2 = 2.5 - f4_arg0:GetMapHitRadius(TARGET_SELF) + 100
    local f4_local3 = 100
    local f4_local4 = 0
    local f4_local5 = 3
    local f4_local6 = 3
    Approach_Act_Flex(f4_arg0, f4_arg1, f4_local0, f4_local1, f4_local2, f4_local3, f4_local4, f4_local5, f4_local6)
    local f4_local7 = 0
    local f4_local8 = 0
    f4_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 10, 3006, TARGET_ENE_0, 9999, f4_local7, f4_local8, 0, 0)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act04 = function (f5_arg0, f5_arg1, f5_arg2)
    local f5_local0 = 5.5 - f5_arg0:GetMapHitRadius(TARGET_SELF)
    local f5_local1 = 5.5 - f5_arg0:GetMapHitRadius(TARGET_SELF) + 99
    local f5_local2 = 5.5 - f5_arg0:GetMapHitRadius(TARGET_SELF) + 100
    local f5_local3 = 0
    local f5_local4 = 0
    local f5_local5 = 3
    local f5_local6 = 3
    if SpaceCheck(f5_arg0, f5_arg1, 0, 5.5 - f5_arg0:GetMapHitRadius(TARGET_SELF)) == false then
        f5_local0 = 1
    end
    Approach_Act_Flex(f5_arg0, f5_arg1, f5_local0, f5_local1, f5_local2, f5_local3, f5_local4, f5_local5, f5_local6)
    local f5_local7 = 0
    local f5_local8 = 0
    f5_arg1:AddSubGoal(GOAL_COMMON_ComboTunable_SuccessAngle180, 15, 3011, TARGET_ENE_0, 8888, 0, 0, 0, 0)
    f5_arg1:AddSubGoal(GOAL_COMMON_ComboRepeat_SuccessAngle180, 10, 3012, TARGET_ENE_0, 8888, 0, 0)
    f5_arg1:AddSubGoal(GOAL_COMMON_ComboRepeat_SuccessAngle180, 10, 3012, TARGET_ENE_0, 8888, 0, 0)
    f5_arg1:AddSubGoal(GOAL_COMMON_ComboRepeat_SuccessAngle180, 10, 3012, TARGET_ENE_0, 8888, 0, 0)
    f5_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3013, TARGET_ENE_0, 9999, 0, 0)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act40 = function (f6_arg0, f6_arg1, f6_arg2)
    local f6_local0 = 1
    local f6_local1 = 5.5 - f6_arg0:GetMapHitRadius(TARGET_SELF) + 99
    local f6_local2 = 5.5 - f6_arg0:GetMapHitRadius(TARGET_SELF) + 100
    local f6_local3 = 0
    local f6_local4 = 0
    local f6_local5 = 3
    local f6_local6 = 3
    Approach_Act_Flex(f6_arg0, f6_arg1, f6_local0, f6_local1, f6_local2, f6_local3, f6_local4, f6_local5, f6_local6)
    local f6_local7 = 0
    local f6_local8 = 0
    f6_arg1:AddSubGoal(GOAL_COMMON_ComboTunable_SuccessAngle180, 15, 3011, TARGET_ENE_0, 8888, 0, 0, 0, 0)
    f6_arg1:AddSubGoal(GOAL_COMMON_ComboRepeat_SuccessAngle180, 10, 3012, TARGET_ENE_0, 8888, 0, 0)
    f6_arg1:AddSubGoal(GOAL_COMMON_ComboRepeat_SuccessAngle180, 10, 3012, TARGET_ENE_0, 8888, 0, 0)
    f6_arg1:AddSubGoal(GOAL_COMMON_ComboRepeat_SuccessAngle180, 10, 3012, TARGET_ENE_0, 8888, 0, 0)
    f6_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3013, TARGET_ENE_0, 9999, 0, 0)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act21 = function (f7_arg0, f7_arg1, f7_arg2)
    local f7_local0 = 3
    local f7_local1 = 45
    f7_arg1:AddSubGoal(GOAL_COMMON_Turn, f7_local0, TARGET_ENE_0, f7_local1, -1, GOAL_RESULT_Success, true)
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
    
end

Goal.Act22 = function (f8_arg0, f8_arg1, f8_arg2)
    local f8_local0 = 3
    local f8_local1 = 0
    local f8_local2 = 5202
    if SpaceCheck(f8_arg0, f8_arg1, -45, 2) == true then
        if SpaceCheck(f8_arg0, f8_arg1, 45, 2) == true then
            if f8_arg0:IsInsideTarget(TARGET_ENE_0, AI_DIR_TYPE_R, 180) then
                f8_local2 = 5202
            else
                f8_local2 = 5203
            end
        else
            f8_local2 = 5202
        end
    elseif SpaceCheck(f8_arg0, f8_arg1, 45, 2) == true then
        f8_local2 = 5203
    else
    end
    f8_arg1:AddSubGoal(GOAL_COMMON_SpinStep, f8_local0, f8_local2, TARGET_ENE_0, f8_local1, AI_DIR_TYPE_R, 0)
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
    
end

Goal.Act23 = function (f9_arg0, f9_arg1, f9_arg2)
    local f9_local0 = f9_arg0:GetDist(TARGET_ENE_0)
    local f9_local1 = f9_arg0:GetSp(TARGET_SELF)
    local f9_local2 = 20
    local f9_local3 = f9_arg0:GetRandam_Int(1, 100)
    local f9_local4 = -1
    if f9_local2 <= f9_local1 and f9_local3 <= 50 then
        f9_local4 = 9910
    end
    local f9_local5 = 0
    if SpaceCheck(f9_arg0, f9_arg1, -90, 1) == true then
        if SpaceCheck(f9_arg0, f9_arg1, 90, 1) == true then
            if f9_arg0:IsInsideTargetEx(TARGET_ENE_0, TARGET_SELF, AI_DIR_TYPE_R, 180, 999) then
                f9_local5 = 1
            else
                f9_local5 = 0
            end
        else
            f9_local5 = 0
        end
    elseif SpaceCheck(f9_arg0, f9_arg1, 90, 1) == true then
        f9_local5 = 1
    else
    end
    local f9_local6 = 3
    local f9_local7 = f9_arg0:GetRandam_Int(30, 45)
    f9_arg0:SetNumber(10, f9_local5)
    f9_arg1:AddSubGoal(GOAL_COMMON_SidewayMove, f9_local6, TARGET_ENE_0, f9_local5, f9_local7, true, true, f9_local4)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act24 = function (f10_arg0, f10_arg1, f10_arg2)
    local f10_local0 = f10_arg0:GetDist(TARGET_ENE_0)
    local f10_local1 = 3
    local f10_local2 = 0
    local f10_local3 = 5201
    if SpaceCheck(f10_arg0, f10_arg1, 180, 2) ~= true or SpaceCheck(f10_arg0, f10_arg1, 180, 4) ~= true or f10_local0 > 4 then
    else
        f10_local3 = 5211
        if false then
        else
        end
    end
    f10_arg1:AddSubGoal(GOAL_COMMON_SpinStep, f10_local1, f10_local3, TARGET_ENE_0, f10_local2, AI_DIR_TYPE_B, 0)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act25 = function (f11_arg0, f11_arg1, f11_arg2)
    local f11_local0 = f11_arg0:GetRandam_Float(2, 4)
    local f11_local1 = f11_arg0:GetRandam_Float(5, 7)
    local f11_local2 = f11_arg0:GetDist(TARGET_ENE_0)
    local f11_local3 = -1
    f11_arg1:AddSubGoal(GOAL_COMMON_LeaveTarget, f11_local0, TARGET_ENE_0, f11_local1, TARGET_ENE_0, true, f11_local3)
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
    
end

Goal.Act26 = function (f12_arg0, f12_arg1, f12_arg2)
    f12_arg1:AddSubGoal(GOAL_COMMON_Wait, 0.5, TARGET_SELF, 0, 0, 0)
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
    
end

Goal.Act27 = function (f13_arg0, f13_arg1, f13_arg2)
    local f13_local0 = f13_arg0:GetDist(TARGET_ENE_0)
    local f13_local1 = f13_arg0:GetDistYSigned(TARGET_ENE_0)
    local f13_local2 = f13_local1 / math.tan(math.deg(30))
    local f13_local3 = f13_arg0:GetRandam_Int(0, 1)
    if f13_local1 >= 3 then
        if f13_local2 + 1 <= f13_local0 then
            if SpaceCheck(f13_arg0, f13_arg1, 0, 4) == true then
                f13_arg1:AddSubGoal(GOAL_COMMON_ApproachTarget, 0.1, TARGET_ENE_0, f13_local2, TARGET_SELF, true, -1)
            elseif SpaceCheck(f13_arg0, f13_arg1, 0, 3) == true then
                f13_arg1:AddSubGoal(GOAL_COMMON_ApproachTarget, 0.5, TARGET_ENE_0, f13_local2, TARGET_SELF, true, -1)
            else
                f13_arg1:AddSubGoal(GOAL_COMMON_SidewayMove, 3, TARGET_ENE_0, f13_local3, f13_arg0:GetRandam_Int(30, 45), true, true, -1)
            end
        elseif f13_local0 <= f13_local2 - 1 then
            f13_arg1:AddSubGoal(GOAL_COMMON_LeaveTarget, 10, TARGET_ENE_0, f13_local2, TARGET_ENE_0, true, -1)
        else
            f13_arg1:AddSubGoal(GOAL_COMMON_SidewayMove, 3, TARGET_ENE_0, f13_local3, f13_arg0:GetRandam_Int(30, 45), true, true, -1)
            f13_arg0:SetNumber(10, f13_local3)
        end
    elseif SpaceCheck(f13_arg0, f13_arg1, 0, 4) == true then
        f13_arg1:AddSubGoal(GOAL_COMMON_ApproachTarget, 0.1, TARGET_ENE_0, 0, TARGET_SELF, true, -1)
    elseif SpaceCheck(f13_arg0, f13_arg1, 0, 3) == true then
        f13_arg1:AddSubGoal(GOAL_COMMON_ApproachTarget, 0.5, TARGET_ENE_0, 0, TARGET_SELF, true, -1)
    elseif SpaceCheck(f13_arg0, f13_arg1, 0, 1) == false then
        f13_arg1:AddSubGoal(GOAL_COMMON_LeaveTarget, 0.5, TARGET_ENE_0, 999, TARGET_ENE_0, true, -1)
    else
        f13_arg1:AddSubGoal(GOAL_COMMON_SidewayMove, 3, TARGET_ENE_0, f13_local3, f13_arg0:GetRandam_Int(30, 45), true, true, -1)
        f13_arg0:SetNumber(10, f13_local3)
    end
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
    
end

Goal.Act28 = function (f14_arg0, f14_arg1, f14_arg2)
    local f14_local0 = f14_arg0:GetDist(TARGET_ENE_0)
    local f14_local1 = 1.5
    local f14_local2 = 1.5
    local f14_local3 = f14_arg0:GetRandam_Int(30, 45)
    local f14_local4 = -1
    local f14_local5 = f14_arg0:GetRandam_Int(0, 1)
    if f14_local0 <= 3 then
        f14_arg1:AddSubGoal(GOAL_COMMON_SidewayMove, f14_local1, TARGET_ENE_0, f14_local5, f14_local3, true, true, f14_local4)
    elseif f14_local0 <= 8 then
        f14_arg1:AddSubGoal(GOAL_COMMON_ApproachTarget, f14_local2, TARGET_ENE_0, 3, TARGET_SELF, true, -1)
    else
        f14_arg1:AddSubGoal(GOAL_COMMON_ApproachTarget, f14_local2, TARGET_ENE_0, 8, TARGET_SELF, true, -1)
    end
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
    
end

Goal.Interrupt = function (f15_arg0, f15_arg1, f15_arg2)
    local f15_local0 = f15_arg1:GetSpecialEffectActivateInterruptType(0)
    if f15_arg1:IsLadderAct(TARGET_SELF) then
        return false
    end
    if not f15_arg1:HasSpecialEffectId(TARGET_SELF, 200004) then
        return false
    end
    if f15_local0 == 3150111 and f15_arg1:HasSpecialEffectId(TARGET_SELF, 3150110) then
        f15_arg2:ClearSubGoal()
        f15_arg2:AddSubGoal(GOAL_COMMON_EndureAttack, 5, 3013, TARGET_ENE_0, 9999, 0)
        return true
    end
    return false
    
end

Goal.NoAction = function (f16_arg0, f16_arg1, f16_arg2)
    return -1
    
end

Goal.ActAfter_AdjustSpace = function (f17_arg0, f17_arg1, f17_arg2)
    
end

Goal.Update = function (f18_arg0, f18_arg1, f18_arg2)
    return Update_Default_NoSubGoal(f18_arg0, f18_arg1, f18_arg2)
    
end

Goal.Terminate = function (f19_arg0, f19_arg1, f19_arg2)
    
end

