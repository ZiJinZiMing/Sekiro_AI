﻿RegisterTableGoal(GOAL_Innsmouth_130000_Battle, "GOAL_Innsmouth_130000_Battle")
REGISTER_GOAL_NO_UPDATE(GOAL_Innsmouth_130000_Battle, true)

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
    local f2_local7 = f2_arg1:GetEventRequest()
    f2_arg1:DeleteObserve(0)
    f2_arg1:DeleteObserve(1)
    f2_arg1:DeleteObserve(3)
    f2_arg1:AddObserveSpecialEffectAttribute(TARGET_SELF, 3130000)
    f2_arg1:AddObserveSpecialEffectAttribute(TARGET_ENE_0, 9620)
    if f2_arg1:HasSpecialEffectId(TARGET_SELF, 5026) then
        f2_local0[5] = 100
    elseif f2_arg1:HasSpecialEffectId(TARGET_SELF, 220020) then
        f2_local0[2] = 10000
    elseif Common_ActivateAct(f2_arg1, f2_arg2, 1) then
    elseif f2_arg1:IsInsideTarget(TARGET_ENE_0, AI_DIR_TYPE_B, 180) then
        f2_local0[21] = 100
    elseif f2_arg1:HasSpecialEffectId(TARGET_SELF, 5020) then
        if not f2_arg1:IsVisibleTarget(TARGET_ENE_0) then
            if f2_arg1:HasSpecialEffectId(TARGET_SELF, 3130000) then
                if f2_arg1:CheckDoesExistPath(TARGET_ENE_0, AI_DIR_TYPE_F, 0, 0) == false then
                    f2_local0[27] = 100
                elseif 3 - f2_arg1:GetMapHitRadius(TARGET_SELF) <= f2_local5 then
                    f2_local0[10] = 100
                    f2_local0[28] = 1
                else
                    f2_local0[11] = 100
                    f2_local0[28] = 1
                end
            elseif f2_arg1:HasSpecialEffectId(TARGET_ENE_0, 9620) then
                f2_local0[27] = 100
            elseif f2_local5 >= 4 then
                f2_local0[29] = 100
            else
                f2_local0[26] = 100
            end
        elseif f2_arg1:HasSpecialEffectId(TARGET_SELF, 3130000) then
            if f2_arg1:CheckDoesExistPath(TARGET_ENE_0, AI_DIR_TYPE_F, 0, 0) == false then
                f2_local0[27] = 100
            elseif 3 - f2_arg1:GetMapHitRadius(TARGET_SELF) <= f2_local5 then
                f2_local0[10] = 100
                f2_local0[28] = 1
            else
                f2_local0[11] = 100
                f2_local0[28] = 1
            end
        elseif f2_arg1:HasSpecialEffectId(TARGET_ENE_0, 9620) then
            if f2_local5 >= 1 then
                f2_local0[3] = 100
            else
                f2_local0[2] = 500
                f2_local0[3] = 100
            end
        elseif f2_local5 >= 1 then
            f2_local0[1] = 100
        else
            f2_local0[1] = 100
            f2_local0[2] = 10000
        end
    elseif f2_arg1:HasSpecialEffectId(TARGET_SELF, 5021) then
        if f2_local6 == 1 and f2_arg1:GetTeamOrder(ORDER_TYPE_Role) == ROLE_TYPE_Kankyaku then
            KankyakuAct(f2_arg1, f2_arg2)
        elseif f2_local6 == 1 and f2_arg1:GetTeamOrder(ORDER_TYPE_Role) == ROLE_TYPE_Torimaki then
            TorimakiAct(f2_arg1, f2_arg2, -1, 0)
        elseif f2_arg1:CheckDoesExistPath(TARGET_ENE_0, AI_DIR_TYPE_F, 0, 0) == false then
            f2_local0[27] = 100
        elseif f2_local5 >= 10 then
            f2_local0[5] = 100
            f2_local0[27] = 100
        elseif f2_local5 >= 6 then
            f2_local0[5] = 200
            f2_local0[4] = 200
            f2_local0[27] = 100
        else
            f2_local0[2] = 100
            f2_local0[4] = 200
        end
    else
        f2_local0[26] = 100
    end
    if SpaceCheck(f2_arg1, f2_arg2, 90, 1) == false and SpaceCheck(f2_arg1, f2_arg2, -45, 1) == false then
        f2_local0[23] = 0
    end
    if SpaceCheck(f2_arg1, f2_arg2, 180, 1) == false then
        f2_local0[25] = 0
    end
    f2_local0[2] = SetCoolTime(f2_arg1, f2_arg2, 3004, 15, f2_local0[2], 1)
    f2_local0[4] = SetCoolTime(f2_arg1, f2_arg2, 3009, 8, f2_local0[4], 1)
    f2_local0[10] = SetCoolTime(f2_arg1, f2_arg2, 3005, 10, f2_local0[10], 0)
    f2_local0[10] = SetCoolTime(f2_arg1, f2_arg2, 3006, 10, f2_local0[10], 0)
    f2_local0[11] = SetCoolTime(f2_arg1, f2_arg2, 3005, 10, f2_local0[11], 0)
    f2_local0[11] = SetCoolTime(f2_arg1, f2_arg2, 3006, 10, f2_local0[11], 0)
    f2_local1[1] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act01)
    f2_local1[2] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act02)
    f2_local1[3] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act03)
    f2_local1[4] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act04)
    f2_local1[5] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act05)
    f2_local1[10] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act10)
    f2_local1[11] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act11)
    f2_local1[21] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act21)
    f2_local1[26] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act26)
    f2_local1[27] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act27)
    f2_local1[28] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act28)
    f2_local1[29] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act29)
    local f2_local8 = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.ActAfter_AdjustSpace)
    Common_Battle_Activate(f2_arg1, f2_arg2, f2_local0, f2_local1, f2_local8, f2_local2)
    
end

Goal.Act01 = function (f3_arg0, f3_arg1, f3_arg2)
    local f3_local0 = 45 - f3_arg0:GetMapHitRadius(TARGET_SELF)
    local f3_local1 = 45 - f3_arg0:GetMapHitRadius(TARGET_SELF) + 2
    local f3_local2 = 999
    local f3_local3 = 0
    local f3_local4 = 0
    local f3_local5 = 1.5
    local f3_local6 = 3
    Approach_Act_Flex(f3_arg0, f3_arg1, f3_local0, f3_local1, f3_local2, f3_local3, f3_local4, f3_local5, f3_local6)
    local f3_local7 = 0
    local f3_local8 = 0
    local f3_local9 = 90
    local f3_local10 = 45 - f3_arg0:GetMapHitRadius(TARGET_SELF)
    f3_arg0:AddObserveArea(0, TARGET_SELF, TARGET_ENE_0, AI_DIR_TYPE_F, f3_local9, f3_local10)
    f3_arg1:AddSubGoal(GOAL_COMMON_ComboAttackTunableSpin, 10, 3000, TARGET_ENE_0, 45 - f3_arg0:GetMapHitRadius(TARGET_SELF), f3_local7, f3_local8, 0, 0)
    f3_arg1:AddSubGoal(GOAL_COMMON_ComboRepeat, 10, 3001, TARGET_ENE_0, 45 - f3_arg0:GetMapHitRadius(TARGET_SELF), 0)
    f3_arg1:AddSubGoal(GOAL_COMMON_ComboRepeat, 10, 3001, TARGET_ENE_0, 45 - f3_arg0:GetMapHitRadius(TARGET_SELF), 0)
    f3_arg1:AddSubGoal(GOAL_COMMON_ComboRepeat, 10, 3001, TARGET_ENE_0, 45 - f3_arg0:GetMapHitRadius(TARGET_SELF), 0)
    f3_arg1:AddSubGoal(GOAL_COMMON_ComboRepeat, 10, 3001, TARGET_ENE_0, 45 - f3_arg0:GetMapHitRadius(TARGET_SELF), 0)
    f3_arg1:AddSubGoal(GOAL_COMMON_ComboRepeat, 10, 3001, TARGET_ENE_0, 45 - f3_arg0:GetMapHitRadius(TARGET_SELF), 0)
    f3_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3003, TARGET_ENE_0, 9999, 0, 0)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act02 = function (f4_arg0, f4_arg1, f4_arg2)
    local f4_local0 = 1.7 - f4_arg0:GetMapHitRadius(TARGET_SELF)
    local f4_local1 = 1.7 - f4_arg0:GetMapHitRadius(TARGET_SELF) + 2
    local f4_local2 = 999
    local f4_local3 = 0
    local f4_local4 = 0
    local f4_local5 = 1.5
    local f4_local6 = 0
    Approach_Act_Flex(f4_arg0, f4_arg1, f4_local0, f4_local1, f4_local2, f4_local3, f4_local4, f4_local5, f4_local6)
    local f4_local7 = 0
    local f4_local8 = 0
    f4_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 10, 3004, TARGET_ENE_0, 9999, f4_local7, f4_local8, 0, 0)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act03 = function (f5_arg0, f5_arg1, f5_arg2)
    local f5_local0 = 10
    local f5_local1 = 10
    local f5_local2 = 999
    local f5_local3 = 0
    local f5_local4 = 0
    local f5_local5 = 1.5
    local f5_local6 = 3
    Approach_Act_Flex(f5_arg0, f5_arg1, f5_local0, f5_local1, f5_local2, f5_local3, f5_local4, f5_local5, f5_local6)
    local f5_local7 = 0
    local f5_local8 = 0
    f5_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 10, 3007, TARGET_ENE_0, 9999, f5_local7, f5_local8, 0, 0)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act04 = function (f6_arg0, f6_arg1, f6_arg2)
    local f6_local0 = 4.1 - f6_arg0:GetMapHitRadius(TARGET_SELF)
    local f6_local1 = 4.1 - f6_arg0:GetMapHitRadius(TARGET_SELF)
    local f6_local2 = 4.1 - f6_arg0:GetMapHitRadius(TARGET_SELF) + 999
    local f6_local3 = 0
    local f6_local4 = 0
    local f6_local5 = 4.5
    local f6_local6 = 3
    Approach_Act_Flex(f6_arg0, f6_arg1, f6_local0, f6_local1, f6_local2, f6_local3, f6_local4, f6_local5, f6_local6)
    local f6_local7 = 0
    local f6_local8 = 0
    f6_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 10, 3009, TARGET_ENE_0, 9999, f6_local7, f6_local8, 0, 0)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act05 = function (f7_arg0, f7_arg1, f7_arg2)
    local f7_local0 = 3.2 - f7_arg0:GetMapHitRadius(TARGET_SELF)
    local f7_local1 = 3.2 - f7_arg0:GetMapHitRadius(TARGET_SELF)
    local f7_local2 = 3.2 - f7_arg0:GetMapHitRadius(TARGET_SELF) + 999
    local f7_local3 = 0
    local f7_local4 = 0
    local f7_local5 = 1.5
    local f7_local6 = 3
    Approach_Act_Flex(f7_arg0, f7_arg1, f7_local0 + 5, f7_local1, f7_local2, f7_local3, f7_local4, f7_local5, f7_local6)
    local f7_local7 = f7_arg0:GetRandam_Float(1, 2.5)
    local f7_local8 = 90
    local f7_local9 = 3.2 - f7_arg0:GetMapHitRadius(TARGET_SELF) + f7_local7
    f7_arg0:AddObserveArea(3, TARGET_SELF, TARGET_ENE_0, AI_DIR_TYPE_F, f7_local8, f7_local9)
    local f7_local10 = 0
    local f7_local11 = 0
    f7_arg1:AddSubGoal(GOAL_COMMON_ComboAttackTunableSpin, 10, 3014, TARGET_ENE_0, 999, f7_local10, f7_local11, 0, 0)
    f7_arg1:AddSubGoal(GOAL_COMMON_ComboRepeat, 10, 3015, TARGET_ENE_0, 999, 0)
    f7_arg1:AddSubGoal(GOAL_COMMON_ComboRepeat, 10, 3015, TARGET_ENE_0, 999, 0)
    f7_arg1:AddSubGoal(GOAL_COMMON_ComboRepeat, 10, 3015, TARGET_ENE_0, 999, 0)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act10 = function (f8_arg0, f8_arg1, f8_arg2)
    local f8_local0 = 7.5 - f8_arg0:GetMapHitRadius(TARGET_SELF)
    local f8_local1 = 7.5 - f8_arg0:GetMapHitRadius(TARGET_SELF)
    local f8_local2 = 7.5 - f8_arg0:GetMapHitRadius(TARGET_SELF)
    local f8_local3 = 100
    local f8_local4 = 0
    local f8_local5 = 1.5
    local f8_local6 = 3
    Approach_Act_Flex(f8_arg0, f8_arg1, f8_local0, f8_local1, f8_local2, f8_local3, f8_local4, f8_local5, f8_local6)
    local f8_local7 = 90
    local f8_local8 = 1.5 - f8_arg0:GetMapHitRadius(TARGET_SELF)
    f8_arg0:AddObserveArea(1, TARGET_SELF, TARGET_ENE_0, AI_DIR_TYPE_F, f8_local7, f8_local8)
    local f8_local9 = 0
    local f8_local10 = 0
    local f8_local11 = f8_arg0:GetRandam_Int(1, 100)
    f8_arg1:AddSubGoal(GOAL_COMMON_ComboAttackTunableSpin, 10, 3005, TARGET_ENE_0, 9999, f8_local9, f8_local10, 0, 0)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act11 = function (f9_arg0, f9_arg1, f9_arg2)
    local f9_local0 = 3 - f9_arg0:GetMapHitRadius(TARGET_SELF)
    local f9_local1 = 3 - f9_arg0:GetMapHitRadius(TARGET_SELF)
    local f9_local2 = 3 - f9_arg0:GetMapHitRadius(TARGET_SELF)
    local f9_local3 = 100
    local f9_local4 = 0
    local f9_local5 = 1.5
    local f9_local6 = 3
    Approach_Act_Flex(f9_arg0, f9_arg1, f9_local0, f9_local1, f9_local2, f9_local3, f9_local4, f9_local5, f9_local6)
    local f9_local7 = 3 - f9_arg0:GetMapHitRadius(TARGET_SELF)
    local f9_local8 = 0
    local f9_local9 = 0
    local f9_local10 = f9_arg0:GetRandam_Int(1, 100)
    f9_arg1:AddSubGoal(GOAL_COMMON_ComboAttackTunableSpin, 10, 3006, TARGET_ENE_0, 9999, f9_local8, f9_local9, 0, 0)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act21 = function (f10_arg0, f10_arg1, f10_arg2)
    local f10_local0 = 3
    local f10_local1 = 45
    f10_arg1:AddSubGoal(GOAL_COMMON_Turn, f10_local0, TARGET_ENE_0, f10_local1, -1, GOAL_RESULT_Success, true)
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
    
end

Goal.Act26 = function (f11_arg0, f11_arg1, f11_arg2)
    f11_arg1:AddSubGoal(GOAL_COMMON_Wait, 3, TARGET_SELF, 0, 0, 0)
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
    
end

Goal.Act27 = function (f12_arg0, f12_arg1, f12_arg2)
    local f12_local0 = f12_arg0:GetDist(TARGET_ENE_0)
    local f12_local1 = f12_arg0:GetDistYSigned(TARGET_ENE_0)
    local f12_local2 = f12_local1 / math.tan(math.deg(30))
    local f12_local3 = f12_arg0:GetRandam_Int(0, 1)
    local f12_local4 = f12_arg0:GetRandam_Int(1, 100)
    local f12_local5 = f12_arg0:GetRandam_Float(3, 5)
    f12_arg0:SetNumber(10, f12_local3)
    if f12_local1 >= 3 then
        if f12_local2 + 1 <= f12_local0 then
            if SpaceCheck(f12_arg0, f12_arg1, 0, 3) == true then
                f12_arg1:AddSubGoal(GOAL_COMMON_ApproachTarget, 0.5, TARGET_ENE_0, f12_local2, TARGET_SELF, true, -1)
            end
        elseif f12_local0 <= f12_local2 - 1 then
            f12_arg1:AddSubGoal(GOAL_COMMON_LeaveTarget, 10, TARGET_ENE_0, f12_local2, TARGET_ENE_0, true, -1)
        end
    elseif SpaceCheck(f12_arg0, f12_arg1, 0, 3) == true then
        f12_arg1:AddSubGoal(GOAL_COMMON_ApproachTarget, 0.5, TARGET_ENE_0, 0, TARGET_SELF, true, -1)
    elseif SpaceCheck(f12_arg0, f12_arg1, 0, 1) == false then
        f12_arg1:AddSubGoal(GOAL_COMMON_LeaveTarget, 0.5, TARGET_ENE_0, 999, TARGET_ENE_0, true, -1)
    end
    f12_arg1:AddSubGoal(GOAL_COMMON_SidewayMove, 3, TARGET_ENE_0, f12_local3, f12_arg0:GetRandam_Int(30, 45), true, true, -1)
    if f12_local4 <= 60 then
        f12_arg1:AddSubGoal(GOAL_COMMON_Wait, f12_local5, TARGET_ENE_0, 0, 0, 0)
    end
    if f12_arg0:HasSpecialEffectId(TARGET_SELF, 5021) then
        f12_arg0:AddObserveArea(2, TARGET_SELF, TARGET_ENE_0, AI_DIR_TYPE_F, 180, 1.7 - f12_arg0:GetMapHitRadius(TARGET_SELF))
    end
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
    
end

Goal.Act28 = function (f13_arg0, f13_arg1, f13_arg2)
    local f13_local0 = f13_arg0:GetDist(TARGET_ENE_0)
    local f13_local1 = 1.5
    local f13_local2 = 1.5
    local f13_local3 = f13_arg0:GetRandam_Int(30, 45)
    local f13_local4 = -1
    local f13_local5 = 0
    local f13_local6 = f13_arg0:GetRandam_Int(1, 100)
    local f13_local7 = 4
    if f13_local0 <= 2 then
        f13_arg1:AddSubGoal(GOAL_COMMON_LeaveTarget, f13_local2, TARGET_ENE_0, 6, TARGET_ENE_0, true, f13_local4)
    elseif f13_local0 <= f13_local7 then
        if f13_local6 <= 30 then
            if SpaceCheck(f13_arg0, f13_arg1, -90, 1) == true then
                if SpaceCheck(f13_arg0, f13_arg1, 90, 1) == true then
                    if f13_arg0:IsInsideTarget(TARGET_ENE_0, AI_DIR_TYPE_R, 180) then
                        f13_local5 = 1
                    else
                        f13_local5 = 0
                    end
                else
                    f13_local5 = 0
                end
            elseif SpaceCheck(f13_arg0, f13_arg1, 90, 1) == true then
                f13_local5 = 1
            else
            end
            f13_arg1:AddSubGoal(GOAL_COMMON_SidewayMove, f13_local1, TARGET_ENE_0, f13_local5, f13_local3, true, true, -1)
        elseif f13_arg0:IsInsideTarget(TARGET_ENE_0, AI_DIR_TYPE_F, 90) then
            f13_arg1:AddSubGoal(GOAL_COMMON_Wait, f13_arg0:GetRandam_Float(0.5, 1), TARGET_SELF, 0, 0, 0)
        else
            f13_arg1:AddSubGoal(GOAL_COMMON_Turn, 3, TARGET_ENE_0, 45, -1, GOAL_RESULT_Success, true)
        end
    else
        f13_arg1:AddSubGoal(GOAL_COMMON_ApproachTarget, f13_local2, TARGET_ENE_0, f13_local7, TARGET_SELF, true, -1)
    end
    if f13_arg0:HasSpecialEffectId(TARGET_SELF, 5021) then
        f13_arg0:AddObserveArea(2, TARGET_SELF, TARGET_ENE_0, AI_DIR_TYPE_F, 180, 1.7 - f13_arg0:GetMapHitRadius(TARGET_SELF))
    end
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
    
end

Goal.Act29 = function (f14_arg0, f14_arg1, f14_arg2)
    local f14_local0 = f14_arg0:GetDist(TARGET_ENE_0)
    f14_arg1:AddSubGoal(GOAL_COMMON_ApproachTarget, 1, TARGET_ENE_0, 2, TARGET_SELF, true, -1)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Interrupt = function (f15_arg0, f15_arg1, f15_arg2)
    local f15_local0 = f15_arg1:GetHpRate(TARGET_SELF)
    local f15_local1 = f15_arg1:GetDist(TARGET_ENE_0)
    local f15_local2 = f15_arg1:GetSp(TARGET_SELF)
    local f15_local3 = f15_arg1:GetSpecialEffectActivateInterruptType(0)
    if f15_arg1:IsLadderAct(TARGET_SELF) then
        return false
    end
    if not f15_arg1:HasSpecialEffectId(TARGET_SELF, 200004) then
        return false
    end
    if f15_arg1:IsInterupt(INTERUPT_ActivateSpecialEffect) and f15_local3 == 9620 and f15_arg1:HasSpecialEffectId(TARGET_SELF, 5025) then
        f15_arg2:ClearSubGoal()
        f15_arg2:AddSubGoal(GOAL_COMMON_EndureAttack, 1, 3003, TARGET_ENE_0, 9999, 0)
        return true
    end
    if f15_arg1:IsInterupt(INTERUPT_Inside_ObserveArea) then
        if f15_arg1:IsInsideObserve(1) then
            f15_arg2:ClearSubGoal()
            f15_arg2:AddSubGoal(GOAL_COMMON_EndureAttack, 0.5, 3008, TARGET_ENE_0, 9999, 0)
            f15_arg1:DeleteObserve(1)
            return true
        elseif f15_arg1:IsInsideObserve(2) then
            f15_arg2:ClearSubGoal()
            f15_arg2:AddSubGoal(GOAL_COMMON_EndureAttack, 0.5, 3004, TARGET_ENE_0, 9999, 0)
            f15_arg1:DeleteObserve(2)
            return true
        elseif f15_arg1:IsInsideObserve(3) and f15_arg1:HasSpecialEffectId(TARGET_SELF, 5026) then
            f15_arg2:ClearSubGoal()
            f15_arg2:AddSubGoal(GOAL_COMMON_EndureAttack, 0.5, 3016, TARGET_ENE_0, 9999, 0)
            f15_arg1:DeleteObserve(3)
            return true
        end
    end
    if f15_arg1:IsInterupt(INTERUPT_TargetOutOfRange) and not f15_arg1:HasSpecialEffectId(TARGET_SELF, 3130000) and not f15_arg1:HasSpecialEffectId(TARGET_ENE_0, 9620) and f15_arg1:HasSpecialEffectId(TARGET_SELF, 3130030) and f15_arg1:IsTargetOutOfRangeInterruptSlot(0) then
        f15_arg2:ClearSubGoal()
        f15_arg2:AddSubGoal(GOAL_COMMON_EndureAttack, 1, 3002, TARGET_ENE_0, 9999, 0)
        f15_arg1:DeleteObserve(0)
        return true
    end
    if f15_arg1:IsInterupt(INTERUPT_LoseSightTarget) and not f15_arg1:HasSpecialEffectId(TARGET_SELF, 3130000) and not f15_arg1:HasSpecialEffectId(TARGET_ENE_0, 9620) and f15_arg1:HasSpecialEffectId(TARGET_SELF, 3130030) then
        f15_arg2:ClearSubGoal()
        f15_arg2:AddSubGoal(GOAL_COMMON_EndureAttack, 1, 3002, TARGET_ENE_0, 9999, 0)
        return true
    else
    end
    return false
    
end

Goal.NoAction = function (f16_arg0, f16_arg1, f16_arg2)
    f16_arg0:Replanning()
    
end

Goal.ActAfter_AdjustSpace = function (f17_arg0, f17_arg1, f17_arg2)
    
end

Goal.Update = function (f18_arg0, f18_arg1, f18_arg2)
    return Update_Default_NoSubGoal(f18_arg0, f18_arg1, f18_arg2)
    
end

Goal.Terminate = function (f19_arg0, f19_arg1, f19_arg2)
    
end


