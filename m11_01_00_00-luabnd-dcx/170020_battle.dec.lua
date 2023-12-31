﻿RegisterTableGoal(GOAL_Tokugawazamurai_kaenhoushaki_170020_Battle, "GOAL_Tokugawazamurai_kaenhoushaki_170020_Battle")
REGISTER_GOAL_NO_UPDATE(GOAL_Tokugawazamurai_kaenhoushaki_170020_Battle, true)

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
    f2_arg1:AddObserveSpecialEffectAttribute(TARGET_SELF, 5027)
    f2_arg1:AddObserveSpecialEffectAttribute(TARGET_SELF, 5028)
    Set_ConsecutiveGuardCount_Interrupt(f2_arg1)
    if f2_arg0.Kengeki_Activate(f2_arg0, f2_arg1, f2_arg2) then
        return
    end
    if f2_arg1:HasSpecialEffectId(TARGET_ENE_0, 110060) then
        if f2_arg1:IsInsideTarget(TARGET_ENE_0, AI_DIR_TYPE_F, 90) then
            f2_local0[26] = 100
        else
            f2_local0[21] = 100
        end
    elseif f2_arg1:HasSpecialEffectId(TARGET_ENE_0, 110015) then
        f2_local0[24] = 10000
        f2_local0[23] = 100
        f2_local0[26] = 1
    elseif f2_arg1:HasSpecialEffectId(TARGET_ENE_0, COMMON_SP_EFFECT_PC_REVIVAL_AFTER_1) or f2_arg1:HasSpecialEffectId(TARGET_ENE_0, COMMON_SP_EFFECT_PC_REVIVAL_AFTER_2) then
        TorimakiAct(f2_arg1, f2_arg2, 0, 0)
    elseif f2_arg1:HasSpecialEffectId(TARGET_ENE_0, 110030) then
        if f2_arg1:HasSpecialEffectId(TARGET_SELF, 5031) then
            f2_local0[1] = 100
        else
            TorimakiAct(f2_arg1, f2_arg2, 0, 0)
        end
    elseif f2_arg1:HasSpecialEffectId(TARGET_SELF, 3170200) then
        f2_local0[3] = 100
    elseif f2_arg1:CheckDoesExistPath(TARGET_ENE_0, AI_DIR_TYPE_F, 0, 0) == false then
        if f2_arg1:IsVisibleTarget(TARGET_ENE_0) and f2_local3 <= 8 then
            if f2_arg1:HasSpecialEffectId(TARGET_SELF, 5031) then
                f2_local0[1] = 100
            else
                f2_local0[2] = 100
            end
        elseif f2_arg1:HasSpecialEffectId(TARGET_SELF, 5031) then
            f2_local0[1] = 100
        else
            f2_local0[27] = 100
        end
    elseif f2_local4 == 1 and f2_arg1:GetTeamOrder(ORDER_TYPE_Role) == ROLE_TYPE_Kankyaku then
        if f2_arg1:HasSpecialEffectId(TARGET_SELF, 5031) then
            f2_local0[1] = 100
        else
            KankyakuAct(f2_arg1, f2_arg2)
        end
    elseif f2_local4 == 1 and f2_arg1:GetTeamOrder(ORDER_TYPE_Role) == ROLE_TYPE_Torimaki then
        if f2_arg1:HasSpecialEffectId(TARGET_SELF, 5031) then
            f2_local0[1] = 100
        else
            TorimakiAct(f2_arg1, f2_arg2, -1, 0)
        end
    elseif f2_arg1:IsInsideTarget(TARGET_ENE_0, AI_DIR_TYPE_B, 180) then
        if f2_arg1:HasSpecialEffectId(TARGET_SELF, 5031) then
            f2_local0[1] = 100
        else
            f2_local0[21] = 100
        end
    elseif f2_arg1:HasSpecialEffectId(TARGET_SELF, 5031) == false then
        if f2_local3 >= 12 then
            f2_local0[28] = 100
        elseif f2_local3 >= 6 then
            f2_local0[2] = 100
        elseif f2_local3 >= 2 then
            f2_local0[2] = 100
        elseif f2_arg1:GetNumber(4) == 1 then
            f2_local0[10] = 100
            f2_local0[25] = 50
        elseif f2_arg1:GetNumber(4) == 0 then
            f2_local0[11] = 100
            f2_local0[25] = 50
        end
    elseif f2_local3 >= 12 then
        if f2_arg1:HasSpecialEffectId(TARGET_SELF, 5031) then
            f2_local0[1] = 100
        else
            f2_local0[28] = 100
        end
    elseif f2_local3 >= 6 then
        f2_local0[1] = 100
    elseif f2_local3 >= 2 then
        f2_local0[1] = 100
    elseif f2_arg1:HasSpecialEffectId(TARGET_SELF, 5031) then
        f2_local0[1] = 100
    elseif f2_arg1:GetNumber(4) == 1 then
        f2_local0[10] = 100
        f2_local0[25] = 50
    elseif f2_arg1:GetNumber(4) == 0 then
        f2_local0[11] = 100
        f2_local0[25] = 50
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
    f2_local1[1] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act01)
    f2_local1[2] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act02)
    f2_local1[3] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act03)
    f2_local1[10] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act10)
    f2_local1[11] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act11)
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
    f2_local1[32] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act32)
    local f2_local5 = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.ActAfter_AdjustSpace)
    Common_Battle_Activate(f2_arg1, f2_arg2, f2_local0, f2_local1, f2_local5, f2_local2)
    
end

Goal.Act01 = function (f3_arg0, f3_arg1, f3_arg2)
    local f3_local0 = 15 - f3_arg0:GetMapHitRadius(TARGET_SELF)
    local f3_local1 = 15 - f3_arg0:GetMapHitRadius(TARGET_SELF) + 2
    local f3_local2 = 15 - f3_arg0:GetMapHitRadius(TARGET_SELF) + 2
    local f3_local3 = 100
    local f3_local4 = 0
    local f3_local5 = 1.5
    local f3_local6 = 3
    local f3_local7 = 90
    local f3_local8 = 5
    local f3_local9 = f3_arg0:GetDist(TARGET_ENE_0)
    local f3_local10 = f3_arg0:GetRandam_Int(1, 100)
    local f3_local11 = 3003
    local f3_local12 = ATT3025_DIST_MAX
    local f3_local13 = ATT3025_DIST_MAX
    local f3_local14 = 0
    local f3_local15 = 0
    if f3_arg0:IsFinishTimer(0) then
        f3_local11 = 3001
    elseif f3_local9 >= 7 then
        f3_local11 = 3005
    elseif f3_local9 >= 5 then
        if SpaceCheck(f3_arg0, f3_arg1, -90, 1) == true then
            if SpaceCheck(f3_arg0, f3_arg1, 90, 1) == true then
                if f3_arg0:IsInsideTargetEx(TARGET_ENE_0, TARGET_SELF, AI_DIR_TYPE_R, 180, 999) then
                    f3_local11 = 3008
                else
                    f3_local11 = 3007
                end
            else
                f3_local11 = 3007
            end
        elseif SpaceCheck(f3_arg0, f3_arg1, 90, 1) == true then
            f3_local11 = 3008
        end
    elseif SpaceCheck(f3_arg0, f3_arg1, 180, 4) == true then
        f3_local11 = 3006
    elseif SpaceCheck(f3_arg0, f3_arg1, -90, 1) == true then
        if SpaceCheck(f3_arg0, f3_arg1, 90, 1) == true then
            if f3_arg0:IsInsideTargetEx(TARGET_ENE_0, TARGET_SELF, AI_DIR_TYPE_R, 180, 999) then
                f3_local11 = 3008
            else
                f3_local11 = 3007
            end
        else
            f3_local11 = 3007
        end
    elseif SpaceCheck(f3_arg0, f3_arg1, 90, 1) == true then
        f3_local11 = 3008
    else
        f3_local11 = 3005
    end
    f3_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 10, f3_local11, TARGET_ENE_0, 9999, f3_local14, f3_local15, 0, 0)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act02 = function (f4_arg0, f4_arg1, f4_arg2)
    local f4_local0 = 12 - f4_arg0:GetMapHitRadius(TARGET_SELF)
    local f4_local1 = 12 - f4_arg0:GetMapHitRadius(TARGET_SELF) + 200
    local f4_local2 = 12 - f4_arg0:GetMapHitRadius(TARGET_SELF) + 200
    local f4_local3 = 100
    local f4_local4 = 0
    local f4_local5 = 1.5
    local f4_local6 = 3
    Approach_Act_Flex(f4_arg0, f4_arg1, f4_local0, f4_local1, f4_local2, f4_local3, f4_local4, f4_local5, f4_local6)
    local f4_local7 = 0
    local f4_local8 = 0
    f4_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 10, 3000, TARGET_ENE_0, 9999, f4_local7, f4_local8, 0, 0):TimingSetTimer(0, 15, AI_TIMING_SET__ACTIVATE)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act03 = function (f5_arg0, f5_arg1, f5_arg2)
    local f5_local0 = 30 - f5_arg0:GetMapHitRadius(TARGET_SELF)
    local f5_local1 = 30 - f5_arg0:GetMapHitRadius(TARGET_SELF) + 200
    local f5_local2 = 30 - f5_arg0:GetMapHitRadius(TARGET_SELF) + 200
    local f5_local3 = 100
    local f5_local4 = 0
    local f5_local5 = 1.5
    local f5_local6 = 3
    Approach_Act_Flex(f5_arg0, f5_arg1, f5_local0, f5_local1, f5_local2, f5_local3, f5_local4, f5_local5, f5_local6)
    local f5_local7 = 0
    local f5_local8 = 0
    f5_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 10, 3005, TARGET_ENE_0, 9999, f5_local7, f5_local8, 0, 0):TimingSetTimer(0, 15, AI_TIMING_SET__ACTIVATE)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act10 = function (f6_arg0, f6_arg1, f6_arg2)
    local f6_local0 = 2.5 - f6_arg0:GetMapHitRadius(TARGET_SELF)
    local f6_local1 = 2.5 - f6_arg0:GetMapHitRadius(TARGET_SELF) + 2
    local f6_local2 = 2.5 - f6_arg0:GetMapHitRadius(TARGET_SELF) + 2
    local f6_local3 = 100
    local f6_local4 = 0
    local f6_local5 = 1.5
    local f6_local6 = 3
    Approach_Act_Flex(f6_arg0, f6_arg1, f6_local0, f6_local1, f6_local2, f6_local3, f6_local4, f6_local5, f6_local6)
    local f6_local7 = 0
    local f6_local8 = 0
    f6_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 10, 3016, TARGET_ENE_0, 9999, f6_local7, f6_local8, 0, 0):TimingSetNumber(4, 0, AI_TIMING_SET__ACTIVATE)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act11 = function (f7_arg0, f7_arg1, f7_arg2)
    local f7_local0 = 2.5 - f7_arg0:GetMapHitRadius(TARGET_SELF)
    local f7_local1 = 2.5 - f7_arg0:GetMapHitRadius(TARGET_SELF) + 2
    local f7_local2 = 2.5 - f7_arg0:GetMapHitRadius(TARGET_SELF) + 2
    local f7_local3 = 100
    local f7_local4 = 0
    local f7_local5 = 1.5
    local f7_local6 = 3
    Approach_Act_Flex(f7_arg0, f7_arg1, f7_local0, f7_local1, f7_local2, f7_local3, f7_local4, f7_local5, f7_local6)
    local f7_local7 = 0
    local f7_local8 = 0
    f7_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 10, 3015, TARGET_ENE_0, 9999, f7_local7, f7_local8, 0, 0):TimingSetNumber(4, 1, AI_TIMING_SET__ACTIVATE)
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
    local f9_local2 = 5202
    if SpaceCheck(f9_arg0, f9_arg1, -45, 2) == true then
        if SpaceCheck(f9_arg0, f9_arg1, 45, 2) == true then
            if f9_arg0:IsInsideTarget(TARGET_ENE_0, AI_DIR_TYPE_R, 180) then
                f9_local2 = 5202
            else
                f9_local2 = 5203
            end
        else
            f9_local2 = 5202
        end
    elseif SpaceCheck(f9_arg0, f9_arg1, 45, 2) == true then
        f9_local2 = 5203
    else
    end
    f9_arg1:AddSubGoal(GOAL_COMMON_SpinStep, f9_local0, f9_local2, TARGET_ENE_0, f9_local1, AI_DIR_TYPE_R, 0)
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
    
end

Goal.Act23 = function (f10_arg0, f10_arg1, f10_arg2)
    local f10_local0 = f10_arg0:GetDist(TARGET_ENE_0)
    local f10_local1 = f10_arg0:GetSp(TARGET_SELF)
    local f10_local2 = 20
    local f10_local3 = f10_arg0:GetRandam_Int(1, 100)
    local f10_local4 = -1
    local f10_local5 = 0
    if SpaceCheck(f10_arg0, f10_arg1, -90, 1) == true then
        if SpaceCheck(f10_arg0, f10_arg1, 90, 1) == true then
            if f10_arg0:IsInsideTargetEx(TARGET_ENE_0, TARGET_SELF, AI_DIR_TYPE_R, 180, 999) then
                f10_local5 = 1
            else
                f10_local5 = 0
            end
        else
            f10_local5 = 0
        end
    elseif SpaceCheck(f10_arg0, f10_arg1, 90, 1) == true then
        f10_local5 = 1
    else
    end
    local f10_local6 = 3
    local f10_local7 = f10_arg0:GetRandam_Int(30, 45)
    f10_arg0:SetNumber(10, f10_local5)
    f10_arg1:AddSubGoal(GOAL_COMMON_SidewayMove, f10_local6, TARGET_ENE_0, f10_local5, f10_local7, true, true, f10_local4)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act24 = function (f11_arg0, f11_arg1, f11_arg2)
    local f11_local0 = f11_arg0:GetDist(TARGET_ENE_0)
    local f11_local1 = 3
    local f11_local2 = 0
    local f11_local3 = 5201
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
    local f12_local1 = f12_arg0:GetRandam_Float(5, 7)
    local f12_local2 = f12_arg0:GetDist(TARGET_ENE_0)
    local f12_local3 = -1
    local f12_local4 = 90
    local f12_local5 = 2
    f12_arg1:AddSubGoal(GOAL_COMMON_LeaveTarget, f12_local0, TARGET_ENE_0, f12_local1, TARGET_ENE_0, true, f12_local3)
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
    
end

Goal.Act26 = function (f13_arg0, f13_arg1, f13_arg2)
    f13_arg1:AddSubGoal(GOAL_COMMON_Wait, 0.5, TARGET_SELF, 0, 0, 0)
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
    
end

Goal.Act27 = function (f14_arg0, f14_arg1, f14_arg2)
    local f14_local0 = f14_arg0:GetRandam_Int(1, 100)
    if YousumiAct_SubGoal(f14_arg0, f14_arg1, false, 60, 30) == false then
        GetWellSpace_Odds = 0
        return GetWellSpace_Odds
    end
    local f14_local1 = 0
    local f14_local2 = SpaceCheck_SidewayMove(f14_arg0, f14_arg1, 1)
    if f14_local2 == 0 then
        f14_local1 = 0
    elseif f14_local2 == 1 then
        f14_local1 = 1
    elseif f14_local2 == 2 then
        if f14_local0 <= 50 then
            f14_local1 = 0
        else
            f14_local1 = 1
        end
    else
        f14_arg1:AddSubGoal(GOAL_COMMON_Wait, 0.5, TARGET_SELF, 0, 0, 0)
        GetWellSpace_Odds = 0
        return GetWellSpace_Odds
    end
    f14_arg0:SetNumber(10, f14_local1)
    f14_arg1:AddSubGoal(GOAL_COMMON_SidewayMove, 3, TARGET_ENE_0, f14_local1, f14_arg0:GetRandam_Int(30, 45), true, true, -1)
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
    
end

Goal.Act28 = function (f15_arg0, f15_arg1, f15_arg2)
    local f15_local0 = f15_arg0:GetDist(TARGET_ENE_0)
    local f15_local1 = 1.5
    local f15_local2 = 1.5
    local f15_local3 = f15_arg0:GetRandam_Int(30, 45)
    local f15_local4 = -1
    local f15_local5 = f15_arg0:GetRandam_Int(0, 1)
    if f15_local0 <= 3 then
        f15_arg1:AddSubGoal(GOAL_COMMON_SidewayMove, f15_local1, TARGET_ENE_0, f15_local5, f15_local3, true, true, f15_local4)
    elseif f15_local0 <= 8 then
        f15_arg1:AddSubGoal(GOAL_COMMON_ApproachTarget, f15_local2, TARGET_ENE_0, 3, TARGET_SELF, true, f15_local4)
    else
        f15_arg1:AddSubGoal(GOAL_COMMON_ApproachTarget, f15_local2, TARGET_ENE_0, 8, TARGET_SELF, true, f15_local4)
    end
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
    
end

Goal.Interrupt = function (f16_arg0, f16_arg1, f16_arg2)
    local f16_local0 = f16_arg1:GetSpecialEffectActivateInterruptType(0)
    local f16_local1 = f16_arg1:GetRandam_Float(2, 4)
    local f16_local2 = f16_arg1:GetRandam_Float(5, 7)
    local f16_local3 = f16_arg1:GetDist(TARGET_ENE_0)
    local f16_local4 = 9910
    local f16_local5 = 270
    local f16_local6 = 6
    local f16_local7 = f16_arg1:GetRandam_Int(1, 100)
    if f16_arg1:IsLadderAct(TARGET_SELF) then
        return false
    end
    if not f16_arg1:HasSpecialEffectId(TARGET_SELF, 200004) then
        return false
    end
    if f16_arg1:IsInterupt(INTERUPT_ActivateSpecialEffect) then
        if f16_local0 == 5025 then
            if f16_local3 <= 3 then
                f16_arg2:ClearSubGoal()
                f16_arg2:AddSubGoal(GOAL_COMMON_EndureAttack, 5, 3017, TARGET_ENE_0, 9999, 0)
                return true
            end
        elseif f16_local0 == 5027 then
            f16_arg1:AddObserveArea(0, TARGET_SELF, TARGET_ENE_0, AI_DIR_TYPE_B, f16_local5, f16_local6)
            return true
        end
    end
    if f16_arg1:IsInterupt(INTERUPT_Inside_ObserveArea) and f16_arg1:IsInsideObserve(0) then
        if f16_arg1:IsFinishTimer(1) == false then
            f16_arg1:DeleteObserve(0)
            return true
        elseif f16_arg1:IsInsideTarget(TARGET_ENE_0, AI_DIR_TYPE_R, 180) then
            f16_arg2:ClearSubGoal()
            f16_arg2:AddSubGoal(GOAL_COMMON_EndureAttack, 0.1, 3036, TARGET_ENE_0, 9999, 0):TimingSetTimer(1, 7, AI_TIMING_SET__ACTIVATE)
            f16_arg1:DeleteObserve(0)
            return true
        else
            f16_arg2:ClearSubGoal()
            f16_arg2:AddSubGoal(GOAL_COMMON_EndureAttack, 0.1, 3035, TARGET_ENE_0, 9999, 0):TimingSetTimer(1, 7, AI_TIMING_SET__ACTIVATE)
            f16_arg1:DeleteObserve(0)
            return true
        end
    end
    if f16_arg1:IsInterupt(INTERUPT_ParryTiming) then
        return f16_arg0.Parry(f16_arg1, f16_arg2)
    end
    if f16_arg1:IsInterupt(INTERUPT_Damaged) then
        return f16_arg0.Damaged(f16_arg1, f16_arg2)
    end
    return false
    
end

Goal.Parry = function (f17_arg0, f17_arg1, f17_arg2)
    local f17_local0 = f17_arg0:GetHpRate(TARGET_SELF)
    local f17_local1 = f17_arg0:GetDist(TARGET_ENE_0)
    local f17_local2 = f17_arg0:GetSp(TARGET_SELF)
    local f17_local3 = f17_arg0:GetRandam_Int(1, 100)
    local f17_local4 = 0
    if not f17_arg0:IsInsideTarget(TARGET_ENE_0, AI_DIR_TYPE_F, 90) or not f17_arg0:IsInsideTargetEx(TARGET_ENE_0, TARGET_SELF, AI_DIR_TYPE_F, 90, 3) or f17_arg0:HasSpecialEffectId(TARGET_ENE_0, 109012) then
    elseif f17_arg0:IsTargetGuard(TARGET_SELF) then
        if f17_arg0:HasSpecialEffectId(TARGET_ENE_0, 109970) then
        else
            return true
        end
    elseif f17_arg0:HasSpecialEffectId(TARGET_ENE_0, 109970) then
        return true
    else
        return true
    end
    return false
    
end

Goal.Kengeki_Activate = function (f18_arg0, f18_arg1, f18_arg2, f18_arg3)
    local f18_local0 = ReturnKengekiSpecialEffect(f18_arg1)
    if f18_local0 == 0 then
        return false
    end
    local f18_local1 = {}
    local f18_local2 = {}
    local f18_local3 = {}
    Common_Clear_Param(f18_local1, f18_local2, f18_local3)
    local f18_local4 = f18_arg1:GetDist(TARGET_ENE_0)
    local f18_local5 = f18_arg1:GetSp(TARGET_SELF)
    if f18_local5 <= 0 then
        f18_local1[50] = 100
    elseif f18_local0 == 200200 then
        if f18_local4 >= 2 then
            f18_local1[50] = 100
        elseif f18_local4 <= 0.2 then
            f18_local1[50] = 100
        else
            f18_local1[3] = 100
        end
    elseif f18_local0 == 200201 then
        if f18_local4 >= 2 then
            f18_local1[50] = 100
        elseif f18_local4 <= 0.2 then
            f18_local1[50] = 100
        else
            f18_local1[4] = 100
        end
    elseif f18_local0 == 200205 then
        if f18_local4 >= 2 then
            f18_local1[50] = 100
        elseif f18_local4 <= 0.2 then
            f18_local1[50] = 100
        else
            f18_local1[1] = 100
        end
    elseif f18_local0 == 200206 then
        if f18_local4 >= 2 then
            f18_local1[50] = 100
        elseif f18_local4 <= 0.2 then
            f18_local1[50] = 100
        else
            f18_local1[2] = 100
        end
    elseif f18_local0 == 200210 then
        if f18_local4 >= 2 then
            f18_local1[50] = 100
        elseif f18_local4 <= 0.2 then
            f18_local1[50] = 100
        else
            f18_local1[7] = 100
        end
    elseif f18_local0 == 200211 then
        if f18_local4 >= 2 then
            f18_local1[50] = 100
        elseif f18_local4 <= 0.2 then
            f18_local1[50] = 100
        else
            f18_local1[8] = 100
        end
    elseif f18_local0 == 200215 then
        if f18_local4 >= 2 then
            f18_local1[50] = 100
        elseif f18_local4 <= 0.2 then
            f18_local1[50] = 100
        else
            f18_local1[5] = 100
        end
    elseif f18_local0 == 200216 then
        if f18_local4 >= 2 then
            f18_local1[50] = 100
        elseif f18_local4 <= 0.2 then
            f18_local1[50] = 100
        else
            f18_local1[6] = 100
        end
    else
        f18_local1[50] = 100
    end
    f18_local2[1] = REGIST_FUNC(f18_arg1, f18_arg2, f18_arg0.Kengeki01)
    f18_local2[2] = REGIST_FUNC(f18_arg1, f18_arg2, f18_arg0.Kengeki02)
    f18_local2[3] = REGIST_FUNC(f18_arg1, f18_arg2, f18_arg0.Kengeki03)
    f18_local2[4] = REGIST_FUNC(f18_arg1, f18_arg2, f18_arg0.Kengeki04)
    f18_local2[5] = REGIST_FUNC(f18_arg1, f18_arg2, f18_arg0.Kengeki05)
    f18_local2[6] = REGIST_FUNC(f18_arg1, f18_arg2, f18_arg0.Kengeki06)
    f18_local2[7] = REGIST_FUNC(f18_arg1, f18_arg2, f18_arg0.Kengeki07)
    f18_local2[8] = REGIST_FUNC(f18_arg1, f18_arg2, f18_arg0.Kengeki08)
    f18_local2[50] = REGIST_FUNC(f18_arg1, f18_arg2, f18_arg0.NoAction)
    local f18_local6 = REGIST_FUNC(f18_arg1, f18_arg2, f18_arg0.ActAfter_AdjustSpace)
    return Common_Kengeki_Activate(f18_arg1, f18_arg2, f18_local1, f18_local2, f18_local6, f18_local3)
    
end

Goal.Kengeki01 = function (f19_arg0, f19_arg1, f19_arg2)
    f19_arg1:ClearSubGoal()
    f19_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 1, 3050, TARGET_ENE_0, 9999, 0, 0)
    
end

Goal.Kengeki02 = function (f20_arg0, f20_arg1, f20_arg2)
    f20_arg1:ClearSubGoal()
    f20_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 1, 3055, TARGET_ENE_0, 9999, 0, 0)
    
end

Goal.Kengeki03 = function (f21_arg0, f21_arg1, f21_arg2)
    f21_arg1:ClearSubGoal()
    f21_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 1, 3060, TARGET_ENE_0, 9999, 0, 0)
    
end

Goal.Kengeki04 = function (f22_arg0, f22_arg1, f22_arg2)
    f22_arg1:ClearSubGoal()
    f22_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 1, 3065, TARGET_ENE_0, 9999, 0, 0)
    
end

Goal.Kengeki05 = function (f23_arg0, f23_arg1, f23_arg2)
    f23_arg1:ClearSubGoal()
    f23_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 1, 3070, TARGET_ENE_0, 9999, 0, 0)
    
end

Goal.Kengeki06 = function (f24_arg0, f24_arg1, f24_arg2)
    f24_arg1:ClearSubGoal()
    f24_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 1, 3075, TARGET_ENE_0, 9999, 0, 0)
    
end

Goal.Kengeki07 = function (f25_arg0, f25_arg1, f25_arg2)
    f25_arg1:ClearSubGoal()
    f25_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 1, 3085, TARGET_ENE_0, 9999, 0, 0)
    
end

Goal.Kengeki08 = function (f26_arg0, f26_arg1, f26_arg2)
    f26_arg1:ClearSubGoal()
    f26_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 1, 3085, TARGET_ENE_0, 9999, 0, 0)
    
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


