﻿RegisterTableGoal(GOAL_Yatou_katanaTaimatsu_155020_Battle, "GOAL_Yatou_katanaTaimatsu_155020_Battle")
REGISTER_GOAL_NO_UPDATE(GOAL_Yatou_katanaTaimatsu_155020_Battle, true)

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
    Set_ConsecutiveGuardCount_Interrupt(f2_arg1)
    f2_arg1:DeleteObserve(0)
    if f2_arg0.Kengeki_Activate(f2_arg0, f2_arg1, f2_arg2) then
        return
    end
    if Common_ActivateAct(f2_arg1, f2_arg2) then
    elseif f2_arg1:CheckDoesExistPath(TARGET_ENE_0, AI_DIR_TYPE_F, 0, 0) == false then
        f2_local0[27] = 100
    elseif f2_local4 == 1 and f2_arg1:GetTeamOrder(ORDER_TYPE_Role) == ROLE_TYPE_Kankyaku then
        KankyakuAct(f2_arg1, f2_arg2)
    elseif f2_local4 == 1 and f2_arg1:GetTeamOrder(ORDER_TYPE_Role) == ROLE_TYPE_Torimaki then
        if TorimakiAct(f2_arg1, f2_arg2) then
            f2_local0[7] = 200
            f2_local0[15] = 100
        end
    elseif f2_arg1:HasSpecialEffectId(TARGET_SELF, 3155550) then
        f2_local0[28] = 200
    elseif f2_arg1:IsInsideTarget(TARGET_ENE_0, AI_DIR_TYPE_B, 180) then
        f2_local0[21] = 100
        f2_local0[22] = 1
    elseif f2_arg1:GetNumber(0) == 0 and f2_arg1:HasSpecialEffectId(TARGET_SELF, 5020) == false then
        f2_local0[4] = 100
    elseif f2_local3 >= 7 then
        f2_local0[1] = 0
        f2_local0[2] = 0
        f2_local0[5] = 0
        f2_local0[6] = 100
        f2_local0[7] = 200
        f2_local0[15] = 200
    elseif f2_local3 >= 5 then
        f2_local0[1] = 0
        f2_local0[2] = 0
        f2_local0[5] = 50
        f2_local0[6] = 0
        f2_local0[7] = 50
        f2_local0[15] = 100
    elseif f2_local3 > 3 then
        f2_local0[1] = 100
        f2_local0[2] = 100
        f2_local0[5] = 50
        f2_local0[6] = 50
    elseif f2_local3 > 1 then
        f2_local0[1] = 100
        f2_local0[2] = 100
        f2_local0[3] = 100
        f2_local0[5] = 50
        f2_local0[6] = 50
    else
        f2_local0[3] = 100
    end
    if SpaceCheck(f2_arg1, f2_arg2, 45, 2) == false and SpaceCheck(f2_arg1, f2_arg2, -45, 2) == false then
        f2_local0[22] = 0
    end
    if SpaceCheck(f2_arg1, f2_arg2, 90, 1) == false and SpaceCheck(f2_arg1, f2_arg2, -90, 1) == false then
        f2_local0[23] = 0
    end
    if SpaceCheck(f2_arg1, f2_arg2, 180, 4) == false then
        f2_local0[24] = 0
    end
    if SpaceCheck(f2_arg1, f2_arg2, 180, 1) == false then
        f2_local0[25] = 0
    end
    if f2_arg1:IsFinishTimer(0) == false then
        f2_local0[15] = 0
    end
    f2_local0[1] = SetCoolTime(f2_arg1, f2_arg2, 3000, 5, f2_local0[1], 1)
    f2_local0[2] = SetCoolTime(f2_arg1, f2_arg2, 3002, 5, f2_local0[2], 1)
    f2_local0[3] = SetCoolTime(f2_arg1, f2_arg2, 3003, 5, f2_local0[3], 1)
    f2_local0[4] = SetCoolTime(f2_arg1, f2_arg2, 3004, 15, f2_local0[4], 1)
    f2_local0[5] = SetCoolTime(f2_arg1, f2_arg2, 3008, 20, f2_local0[5], 1)
    f2_local0[6] = SetCoolTime(f2_arg1, f2_arg2, 3011, 20, f2_local0[6], 1)
    f2_local0[7] = SetCoolTime(f2_arg1, f2_arg2, 3012, 20, f2_local0[7], 1)
    f2_local0[15] = SetCoolTime(f2_arg1, f2_arg2, 3007, 15, f2_local0[15], 1)
    f2_local0[24] = SetCoolTime(f2_arg1, f2_arg2, 5211, 10, f2_local0[24], 1)
    f2_local1[1] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act01)
    f2_local1[2] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act02)
    f2_local1[3] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act03)
    f2_local1[4] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act04)
    f2_local1[5] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act05)
    f2_local1[6] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act06)
    f2_local1[7] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act07)
    f2_local1[15] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act15)
    f2_local1[21] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act21)
    f2_local1[22] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act22)
    f2_local1[23] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act23)
    f2_local1[24] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act24)
    f2_local1[25] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act25)
    f2_local1[26] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act26)
    f2_local1[27] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act27)
    f2_local1[28] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act28)
    f2_local1[29] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act29)
    f2_local1[40] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act40)
    f2_local1[41] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act41)
    local f2_local5 = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.ActAfter_AdjustSpace)
    Common_Battle_Activate(f2_arg1, f2_arg2, f2_local0, f2_local1, f2_local5, f2_local2)
    
end

Goal.Act01 = function (f3_arg0, f3_arg1, f3_arg2)
    local f3_local0 = 3.1 - f3_arg0:GetMapHitRadius(TARGET_SELF)
    local f3_local1 = 3.1 - f3_arg0:GetMapHitRadius(TARGET_SELF) + 2
    local f3_local2 = 3.1 - f3_arg0:GetMapHitRadius(TARGET_SELF) + 2
    local f3_local3 = 100
    local f3_local4 = 0
    local f3_local5 = 1.5
    local f3_local6 = 3
    Approach_Act_Flex(f3_arg0, f3_arg1, f3_local0, f3_local1, f3_local2, f3_local3, f3_local4, f3_local5, f3_local6)
    local f3_local7 = 3 - f3_arg0:GetMapHitRadius(TARGET_SELF)
    local f3_local8 = 3.1 - f3_arg0:GetMapHitRadius(TARGET_SELF)
    local f3_local9 = 0
    local f3_local10 = 0
    f3_arg1:AddSubGoal(GOAL_COMMON_ComboAttackTunableSpin, 10, 3000, TARGET_ENE_0, f3_local7, f3_local9, f3_local10, 0, 0)
    f3_arg1:AddSubGoal(GOAL_COMMON_ComboRepeat, 10, 3001, TARGET_ENE_0, f3_local8, 0)
    f3_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3005, TARGET_ENE_0, 9999, 0, 0)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act02 = function (f4_arg0, f4_arg1, f4_arg2)
    local f4_local0 = 2.8 - f4_arg0:GetMapHitRadius(TARGET_SELF)
    local f4_local1 = 2.8 - f4_arg0:GetMapHitRadius(TARGET_SELF) + 2
    local f4_local2 = 2.8 - f4_arg0:GetMapHitRadius(TARGET_SELF) + 2
    local f4_local3 = 100
    local f4_local4 = 0
    local f4_local5 = 1.5
    local f4_local6 = 3
    Approach_Act_Flex(f4_arg0, f4_arg1, f4_local0, f4_local1, f4_local2, f4_local3, f4_local4, f4_local5, f4_local6)
    local f4_local7 = 0
    local f4_local8 = 0
    f4_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 10, 3002, TARGET_ENE_0, 9999, f4_local7, f4_local8, 0, 0)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act03 = function (f5_arg0, f5_arg1, f5_arg2)
    local f5_local0 = 0
    local f5_local1 = 0
    f5_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 10, 3003, TARGET_ENE_0, 9999, f5_local0, f5_local1, 0, 0)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act04 = function (f6_arg0, f6_arg1, f6_arg2)
    local f6_local0 = 0
    local f6_local1 = 0
    local f6_local2 = 90
    local f6_local3 = 1.5 - f6_arg0:GetMapHitRadius(TARGET_SELF)
    f6_arg0:AddObserveArea(0, TARGET_SELF, TARGET_ENE_0, AI_DIR_TYPE_F, f6_local2, f6_local3)
    f6_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 10, 3004, TARGET_ENE_0, 9999, f6_local0, f6_local1, 0, 0)
    f6_arg0:SetNumber(0, 1)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act05 = function (f7_arg0, f7_arg1, f7_arg2)
    local f7_local0 = 3.3 - f7_arg0:GetMapHitRadius(TARGET_SELF)
    local f7_local1 = 3.3 - f7_arg0:GetMapHitRadius(TARGET_SELF) + 2
    local f7_local2 = 3.3 - f7_arg0:GetMapHitRadius(TARGET_SELF) + 2
    local f7_local3 = 100
    local f7_local4 = 0
    local f7_local5 = 1.5
    local f7_local6 = 3
    Approach_Act_Flex(f7_arg0, f7_arg1, f7_local0, f7_local1, f7_local2, f7_local3, f7_local4, f7_local5, f7_local6)
    local f7_local7 = 3 - f7_arg0:GetMapHitRadius(TARGET_SELF)
    local f7_local8 = 3.2 - f7_arg0:GetMapHitRadius(TARGET_SELF)
    local f7_local9 = 0
    local f7_local10 = 0
    f7_arg1:AddSubGoal(GOAL_COMMON_ComboAttackTunableSpin, 10, 3008, TARGET_ENE_0, f7_local7, f7_local9, f7_local10, 0, 0)
    f7_arg1:AddSubGoal(GOAL_COMMON_ComboRepeat, 10, 3009, TARGET_ENE_0, f7_local8, 0)
    f7_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3010, TARGET_ENE_0, 9999, 0, 0)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act06 = function (f8_arg0, f8_arg1, f8_arg2)
    local f8_local0 = 5 - f8_arg0:GetMapHitRadius(TARGET_SELF)
    local f8_local1 = 5 - f8_arg0:GetMapHitRadius(TARGET_SELF) + 0
    local f8_local2 = 5 - f8_arg0:GetMapHitRadius(TARGET_SELF) + 100
    local f8_local3 = 100
    local f8_local4 = 0
    local f8_local5 = 1.5
    local f8_local6 = 3
    Approach_Act_Flex(f8_arg0, f8_arg1, f8_local0, f8_local1, f8_local2, f8_local3, f8_local4, f8_local5, f8_local6)
    local f8_local7 = 0
    local f8_local8 = 0
    f8_arg1:AddSubGoal(GOAL_COMMON_ComboAttackTunableSpin, 10, 3011, TARGET_ENE_0, 9999, f8_local7, f8_local8, 0, 0)
    f8_arg1:AddSubGoal(GOAL_COMMON_ComboRepeat, 10, 3002, TARGET_ENE_0, 999, 0)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act07 = function (f9_arg0, f9_arg1, f9_arg2)
    local f9_local0 = 7.5 - f9_arg0:GetMapHitRadius(TARGET_SELF)
    local f9_local1 = 7.5 - f9_arg0:GetMapHitRadius(TARGET_SELF) + 0
    local f9_local2 = 7.5 - f9_arg0:GetMapHitRadius(TARGET_SELF) + 100
    local f9_local3 = 100
    local f9_local4 = 0
    local f9_local5 = 1.5
    local f9_local6 = 3
    Approach_Act_Flex(f9_arg0, f9_arg1, f9_local0, f9_local1, f9_local2, f9_local3, f9_local4, f9_local5, f9_local6)
    local f9_local7 = 0
    local f9_local8 = 0
    f9_arg1:AddSubGoal(GOAL_COMMON_ComboAttackTunableSpin, 10, 3012, TARGET_ENE_0, 9999, f9_local7, f9_local8, 0, 0)
    f9_arg1:AddSubGoal(GOAL_COMMON_ComboRepeat, 10, 3003, TARGET_ENE_0, 999, 0)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act40 = function (f10_arg0, f10_arg1, f10_arg2)
    local f10_local0 = 7.5 - f10_arg0:GetMapHitRadius(TARGET_SELF)
    local f10_local1 = 7.5 - f10_arg0:GetMapHitRadius(TARGET_SELF) + 0
    local f10_local2 = 7.5 - f10_arg0:GetMapHitRadius(TARGET_SELF) + 100
    local f10_local3 = 100
    local f10_local4 = 0
    local f10_local5 = 1.5
    local f10_local6 = 3
    Approach_Act_Flex(f10_arg0, f10_arg1, f10_local0, f10_local1, f10_local2, f10_local3, f10_local4, f10_local5, f10_local6)
    local f10_local7 = 0
    local f10_local8 = 0
    local f10_local9 = 3.1 - f10_arg0:GetMapHitRadius(TARGET_SELF)
    local f10_local10 = 1.5 - f10_arg0:GetMapHitRadius(TARGET_SELF)
    f10_arg1:AddSubGoal(GOAL_COMMON_ComboAttackTunableSpin, 10, 3012, TARGET_ENE_0, f10_local9, f10_local7, f10_local8, 0, 0)
    f10_arg1:AddSubGoal(GOAL_COMMON_ComboRepeat, 10, 3000, TARGET_ENE_0, f10_local10, 0)
    f10_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3003, TARGET_ENE_0, 9999, 0, 0)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act41 = function (f11_arg0, f11_arg1, f11_arg2)
    local f11_local0 = 3.5
    local f11_local1 = f11_arg0:GetRandam_Int(30, 45)
    local f11_local2 = 3
    local f11_local3 = 0
    local f11_local4 = 5201
    if SpaceCheck(f11_arg0, f11_arg1, 180, 4) == true then
        f11_arg1:AddSubGoal(GOAL_COMMON_SpinStep, f11_local2, f11_local4, TARGET_ENE_0, f11_local3, AI_DIR_TYPE_B, 0)
    end
    local f11_local5 = 0
    if SpaceCheck(f11_arg0, f11_arg1, -90, 1) == true then
        if SpaceCheck(f11_arg0, f11_arg1, 90, 1) == true then
            if f11_arg0:IsInsideTarget(TARGET_ENE_0, AI_DIR_TYPE_R, 180) then
                f11_local5 = 0
            else
                f11_local5 = 1
            end
        else
            f11_local5 = 0
        end
    elseif SpaceCheck(f11_arg0, f11_arg1, 90, 1) == true then
        f11_local5 = 1
    else
    end
    f11_arg1:AddSubGoal(GOAL_COMMON_SidewayMove, f11_local0, TARGET_ENE_0, f11_local5, f11_local1, true, true, -1)
    return GETWELLSPACE_ODDS
    
end

Goal.Act15 = function (f12_arg0, f12_arg1, f12_arg2)
    local f12_local0 = 0
    local f12_local1 = 0
    local f12_local2 = f12_arg0:GetRandam_Int(1, 100)
    if f12_local2 < 50 then
        f12_arg1:AddSubGoal(GOAL_COMMON_ComboAttackTunableSpin, 10, 3007, TARGET_ENE_0, 5, f12_local0, f12_local1, 0, 0)
    else
        f12_arg1:AddSubGoal(GOAL_COMMON_ComboAttackTunableSpin, 10, 3014, TARGET_ENE_0, 5, f12_local0, f12_local1, 0, 0)
    end
    f12_arg0:SetTimer(0, 20)
    local f12_local3 = 180
    local f12_local4 = 5
    f12_arg0:AddObserveArea(0, TARGET_SELF, TARGET_ENE_0, AI_DIR_TYPE_F, f12_local3, f12_local4)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act21 = function (f13_arg0, f13_arg1, f13_arg2)
    local f13_local0 = 3
    local f13_local1 = 45
    f13_arg1:AddSubGoal(GOAL_COMMON_Turn, f13_local0, TARGET_ENE_0, f13_local1, -1, GOAL_RESULT_Success, true)
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
    
end

Goal.Act22 = function (f14_arg0, f14_arg1, f14_arg2)
    local f14_local0 = 3
    local f14_local1 = 0
    if SpaceCheck(f14_arg0, f14_arg1, -45, 2) == true then
        if SpaceCheck(f14_arg0, f14_arg1, 45, 2) == true then
            if f14_arg0:IsInsideTarget(TARGET_ENE_0, AI_DIR_TYPE_R, 180) then
                f14_arg1:AddSubGoal(GOAL_COMMON_SpinStep, f14_local0, 5202, TARGET_ENE_0, f14_local1, AI_DIR_TYPE_L, 0)
            else
                f14_arg1:AddSubGoal(GOAL_COMMON_SpinStep, f14_local0, 5203, TARGET_ENE_0, f14_local1, AI_DIR_TYPE_R, 0)
            end
        else
            f14_arg1:AddSubGoal(GOAL_COMMON_SpinStep, f14_local0, 5202, TARGET_ENE_0, f14_local1, AI_DIR_TYPE_L, 0)
        end
    elseif SpaceCheck(f14_arg0, f14_arg1, 45, 2) == true then
        f14_arg1:AddSubGoal(GOAL_COMMON_SpinStep, f14_local0, 5203, TARGET_ENE_0, f14_local1, AI_DIR_TYPE_R, 0)
    else
    end
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
    
end

Goal.Act23 = function (f15_arg0, f15_arg1, f15_arg2)
    local f15_local0 = f15_arg0:GetSp(TARGET_SELF)
    local f15_local1 = 0
    local f15_local2 = f15_arg0:GetRandam_Int(1, 100)
    local f15_local3 = -1
    local f15_local4 = 0
    if SpaceCheck(f15_arg0, f15_arg1, -90, 1) == true then
        if SpaceCheck(f15_arg0, f15_arg1, 90, 1) == true then
            if f15_arg0:IsInsideTarget(TARGET_ENE_0, AI_DIR_TYPE_R, 180) then
                f15_local4 = 1
            else
                f15_local4 = 0
            end
        else
            f15_local4 = 0
        end
    elseif SpaceCheck(f15_arg0, f15_arg1, 90, 1) == true then
        f15_local4 = 1
    else
        GetWellSpace_Odds = 100
        return GetWellSpace_Odds
    end
    local f15_local5 = 1.5
    local f15_local6 = f15_arg0:GetRandam_Int(30, 45)
    f15_arg1:AddSubGoal(GOAL_COMMON_SidewayMove, f15_local5, TARGET_ENE_0, f15_local4, f15_local6, true, true, f15_local3)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act24 = function (f16_arg0, f16_arg1, f16_arg2)
    local f16_local0 = f16_arg0:GetDist(TARGET_ENE_0)
    local f16_local1 = 3
    local f16_local2 = 0
    local f16_local3 = 5211
    if SpaceCheck(f16_arg0, f16_arg1, 180, 2) == true and SpaceCheck(f16_arg0, f16_arg1, 180, 4) == true then
        f16_local3 = 5211
        if false then
        else
        end
    end
    f16_arg1:AddSubGoal(GOAL_COMMON_SpinStep, f16_local1, f16_local3, TARGET_ENE_0, f16_local2, AI_DIR_TYPE_B, 0)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act25 = function (f17_arg0, f17_arg1, f17_arg2)
    local f17_local0 = f17_arg0:GetRandam_Float(2, 4)
    local f17_local1 = f17_arg0:GetRandam_Float(1, 3)
    local f17_local2 = f17_arg0:GetDist(TARGET_ENE_0)
    local f17_local3 = -1
    if SpaceCheck(f17_arg0, f17_arg1, 180, 1) == true then
        f17_arg1:AddSubGoal(GOAL_COMMON_LeaveTarget, f17_local0, TARGET_ENE_0, f17_local1, TARGET_ENE_0, true, f17_local3)
    else
    end
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
    
end

Goal.Act26 = function (f18_arg0, f18_arg1, f18_arg2)
    f18_arg1:AddSubGoal(GOAL_COMMON_Wait, 0.5, TARGET_SELF, 0, 0, 0)
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
    
end

Goal.Act27 = function (f19_arg0, f19_arg1, f19_arg2)
    local f19_local0 = f19_arg0:GetRandam_Int(1, 100)
    if YousumiAct_SubGoal(f19_arg0, f19_arg1, true, 60, 30) == false then
        GetWellSpace_Odds = 0
        return GetWellSpace_Odds
    end
    local f19_local1 = 0
    local f19_local2 = SpaceCheck_SidewayMove(f19_arg0, f19_arg1, 1)
    if f19_local2 == 0 then
        f19_local1 = 0
    elseif f19_local2 == 1 then
        f19_local1 = 1
    elseif f19_local2 == 2 then
        if f19_local0 <= 50 then
            f19_local1 = 0
        else
            f19_local1 = 1
        end
    else
        f19_arg1:AddSubGoal(GOAL_COMMON_Wait, 1, TARGET_SELF, 0, 0, 0)
        GetWellSpace_Odds = 0
        return GetWellSpace_Odds
    end
    f19_arg0:SetNumber(10, f19_local1)
    f19_arg1:AddSubGoal(GOAL_COMMON_SidewayMove, 3, TARGET_ENE_0, f19_local1, f19_arg0:GetRandam_Int(30, 45), true, true, -1)
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
    
end

Goal.Act28 = function (f20_arg0, f20_arg1, f20_arg2)
    local f20_local0 = f20_arg0:GetDist(TARGET_ENE_0)
    local f20_local1 = 1.5
    local f20_local2 = 1.5
    local f20_local3 = f20_arg0:GetRandam_Int(30, 45)
    local f20_local4 = -1
    local f20_local5 = f20_arg0:GetRandam_Int(0, 1)
    if f20_local0 <= 3 then
        f20_arg1:AddSubGoal(GOAL_COMMON_SidewayMove, f20_local1, TARGET_ENE_0, f20_local5, f20_local3, true, true, f20_local4)
    elseif f20_local0 <= 8 then
        f20_arg1:AddSubGoal(GOAL_COMMON_ApproachTarget, f20_local2, TARGET_ENE_0, 3, TARGET_SELF, true, -1)
    else
        f20_arg1:AddSubGoal(GOAL_COMMON_ApproachTarget, f20_local2, TARGET_ENE_0, 8, TARGET_SELF, false, -1)
    end
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
    
end

Goal.Act29 = function (f21_arg0, f21_arg1, f21_arg2)
    local f21_local0 = 3
    f21_arg1:AddSubGoal(GOAL_COMMON_ApproachTarget, f21_local0, TARGET_ENE_0, 4.9, TARGET_SELF, true, -1)
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
    
end

Goal.Interrupt = function (f22_arg0, f22_arg1, f22_arg2)
    local f22_local0 = f22_arg1:GetSpecialEffectActivateInterruptType(0)
    if f22_arg1:IsLadderAct(TARGET_SELF) then
        return false
    end
    if not f22_arg1:HasSpecialEffectId(TARGET_SELF, 200004) then
        return false
    end
    if f22_arg1:IsInsideObserve(0) then
        f22_arg2:ClearSubGoal()
        f22_arg2:AddSubGoal(GOAL_COMMON_EndureAttack, 10, 3003, TARGET_ENE_0, 9999, 0)
        f22_arg1:DeleteObserve(0)
        return true
    end
    if f22_arg1:IsInterupt(INTERUPT_ParryTiming) then
        return Common_Parry(f22_arg1, f22_arg2, 0, 25, 0, 3102)
    end
    if f22_arg1:IsInterupt(INTERUPT_Damaged) then
        return f22_arg0.Damaged(f22_arg1, f22_arg2)
    end
    if f22_arg1:IsInterupt(INTERUPT_ShootImpact) and f22_arg0.ShootReaction(f22_arg1, f22_arg2) then
        return true
    end
    return false
    
end

Goal.Damaged = function (f23_arg0, f23_arg1, f23_arg2)
    local f23_local0 = f23_arg0:GetHpRate(TARGET_SELF)
    local f23_local1 = f23_arg0:GetDist(TARGET_ENE_0)
    local f23_local2 = f23_arg0:GetSp(TARGET_SELF)
    local f23_local3 = f23_arg0:GetRandam_Int(1, 100)
    local f23_local4 = 0
    if f23_local3 <= 33 then
        f23_arg1:ClearSubGoal()
        f23_arg1:AddSubGoal(GOAL_COMMON_SpinStep, StepLife, 5211, TARGET_ENE_0, TurnTime, AI_DIR_TYPE_B, 0):TimingSetTimer(3, 6, UPDATE_SUCCESS)
        return true
    elseif f23_local3 <= 67 then
    end
    return false
    
end

Goal.ShootReaction = function (f24_arg0, f24_arg1)
    f24_arg1:ClearSubGoal()
    f24_arg1:AddSubGoal(GOAL_COMMON_EndureAttack, 0.1, 3100, TARGET_ENE_0, 9999, 0)
    return true
    
end

Goal.Kengeki_Activate = function (f25_arg0, f25_arg1, f25_arg2, f25_arg3)
    local f25_local0 = ReturnKengekiSpecialEffect(f25_arg1)
    if f25_local0 == 0 then
        return false
    end
    local f25_local1 = {}
    local f25_local2 = {}
    local f25_local3 = {}
    Common_Clear_Param(f25_local1, f25_local2, f25_local3)
    local f25_local4 = f25_arg1:GetDist(TARGET_ENE_0)
    local f25_local5 = f25_arg1:GetSp(TARGET_SELF)
    if f25_local5 <= 0 then
        f25_local1[50] = 100
    elseif f25_local0 == 200200 then
        if f25_local4 >= 2 then
            f25_local1[50] = 100
        elseif f25_local4 <= 0.2 then
            f25_local1[50] = 100
        else
            f25_local1[50] = 100
        end
    elseif f25_local0 == 200201 then
        if f25_local4 >= 2 then
            f25_local1[50] = 100
        elseif f25_local4 <= 0.2 then
            f25_local1[50] = 100
        else
            f25_local1[50] = 100
        end
    elseif f25_local0 == 200205 then
        if f25_local4 >= 2 then
            f25_local1[50] = 100
        elseif f25_local4 <= 0.2 then
            f25_local1[50] = 100
        else
            f25_local1[50] = 100
        end
    elseif f25_local0 == 200206 then
        if f25_local4 >= 2 then
            f25_local1[50] = 100
        elseif f25_local4 <= 0.2 then
            f25_local1[50] = 100
        else
            f25_local1[2] = 100
        end
    elseif f25_local0 == 200210 then
        if f25_local4 >= 2 then
            f25_local1[50] = 100
        elseif f25_local4 <= 0.2 then
            f25_local1[50] = 100
        else
            f25_local1[50] = 100
        end
    elseif f25_local0 == 200211 then
        if f25_local4 >= 2 then
            f25_local1[50] = 100
        elseif f25_local4 <= 0.2 then
            f25_local1[50] = 100
        else
            f25_local1[50] = 100
        end
    elseif f25_local0 == 200215 then
        if f25_local4 >= 2 then
            f25_local1[50] = 100
        elseif f25_local4 <= 0.2 then
            f25_local1[50] = 100
        else
            f25_local1[5] = 100
        end
    elseif f25_local0 == 200216 then
        if f25_local4 >= 2 then
            f25_local1[50] = 100
        elseif f25_local4 <= 0.2 then
            f25_local1[50] = 100
        else
            f25_local1[6] = 100
        end
    end
    f25_local2[1] = REGIST_FUNC(f25_arg1, f25_arg2, f25_arg0.Kengeki01)
    f25_local2[2] = REGIST_FUNC(f25_arg1, f25_arg2, f25_arg0.Kengeki02)
    f25_local2[3] = REGIST_FUNC(f25_arg1, f25_arg2, f25_arg0.Kengeki03)
    f25_local2[4] = REGIST_FUNC(f25_arg1, f25_arg2, f25_arg0.Kengeki04)
    f25_local2[5] = REGIST_FUNC(f25_arg1, f25_arg2, f25_arg0.Kengeki05)
    f25_local2[6] = REGIST_FUNC(f25_arg1, f25_arg2, f25_arg0.Kengeki06)
    f25_local2[7] = REGIST_FUNC(f25_arg1, f25_arg2, f25_arg0.Kengeki07)
    f25_local2[8] = REGIST_FUNC(f25_arg1, f25_arg2, f25_arg0.Kengeki08)
    f25_local2[50] = REGIST_FUNC(f25_arg1, f25_arg2, f25_arg0.NoAction)
    local f25_local6 = REGIST_FUNC(f25_arg1, f25_arg2, f25_arg0.ActAfter_AdjustSpace)
    return Common_Kengeki_Activate(f25_arg1, f25_arg2, f25_local1, f25_local2, f25_local6, f25_local3)
    
end

Goal.Kengeki01 = function (f26_arg0, f26_arg1, f26_arg2)
    
end

Goal.Kengeki02 = function (f27_arg0, f27_arg1, f27_arg2)
    
end

Goal.Kengeki03 = function (f28_arg0, f28_arg1, f28_arg2)
    
end

Goal.Kengeki04 = function (f29_arg0, f29_arg1, f29_arg2)
    
end

Goal.Kengeki05 = function (f30_arg0, f30_arg1, f30_arg2)
    f30_arg1:ClearSubGoal()
    f30_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 1, 3072, TARGET_ENE_0, 9999, 0, 0)
    
end

Goal.Kengeki06 = function (f31_arg0, f31_arg1, f31_arg2)
    f31_arg1:ClearSubGoal()
    f31_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 1, 3072, TARGET_ENE_0, 9999, 0, 0)
    
end

Goal.Kengeki07 = function (f32_arg0, f32_arg1, f32_arg2)
    f32_arg1:ClearSubGoal()
    f32_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 1, 3072, TARGET_ENE_0, 9999, 0, 0)
    
end

Goal.Kengeki08 = function (f33_arg0, f33_arg1, f33_arg2)
    f33_arg1:ClearSubGoal()
    f33_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 1, 3072, TARGET_ENE_0, 9999, 0, 0)
    
end

Goal.NoAction = function (f34_arg0, f34_arg1, f34_arg2)
    return -1
    
end

Goal.ActAfter_AdjustSpace = function (f35_arg0, f35_arg1, f35_arg2)
    
end

Goal.Update = function (f36_arg0, f36_arg1, f36_arg2)
    return Update_Default_NoSubGoal(f36_arg0, f36_arg1, f36_arg2)
    
end

Goal.Terminate = function (f37_arg0, f37_arg1, f37_arg2)
    
end


