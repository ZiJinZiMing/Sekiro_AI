RegisterTableGoal(GOAL_YashazaruKenzoku_ju_125010_Battle, "GOAL_YashazaruKenzoku_ju_125010_Battle")
REGISTER_GOAL_NO_UPDATE(GOAL_YashazaruKenzoku_ju_125010_Battle, true)

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
    f2_arg1:DeleteObserve(0)
    if f2_arg1:HasSpecialEffectId(TARGET_SELF, 200030) then
        f2_arg2:AddSubGoal(GOAL_YashazaruKenzoku_sude_125000_Battle, -1)
    else
        if f2_arg1:HasSpecialEffectId(TARGET_SELF, 200050) and f2_arg1:GetNumber(0) < 9 then
            local f2_local5 = 1702320 + f2_arg1:GetNumber(0)
            f2_arg1:SetEventMoveTarget(f2_local5)
            if f2_arg1:GetDist(POINT_EVENT) >= 0.2 then
                f2_local0[10] = 100
            else
                f2_local0[11] = 100
            end
        elseif Common_ActivateAct(f2_arg1, f2_arg2) then
        elseif f2_arg1:HasSpecialEffectId(TARGET_SELF, 5020) then
            f2_local0[5] = 1000
        elseif f2_arg1:CheckDoesExistPath(TARGET_ENE_0, AI_DIR_TYPE_F, 0, 0) == false then
            f2_local0[2] = 150
            f2_local0[3] = 100
            f2_local0[4] = 100
            f2_local0[5] = 100
            f2_local0[27] = 100
        elseif f2_local4 == 1 and f2_arg1:GetTeamOrder(ORDER_TYPE_Role) == ROLE_TYPE_Kankyaku then
            if KankyakuAct(f2_arg1, f2_arg2, -1, 50) then
                f2_local0[6] = 100
                f2_local0[22] = 200
                f2_local0[24] = 200
            end
        elseif f2_local4 == 1 and f2_arg1:GetTeamOrder(ORDER_TYPE_Role) == ROLE_TYPE_Torimaki then
            if TorimakiAct(f2_arg1, f2_arg2, -1, 70) then
                f2_local0[5] = 100
                f2_local0[6] = 200
                f2_local0[22] = 300
                f2_local0[24] = 100
            end
        elseif f2_arg1:IsInsideTarget(TARGET_ENE_0, AI_DIR_TYPE_B, 180) then
            f2_local0[21] = 100
            f2_local0[22] = 1
        elseif f2_local3 >= 12 then
            f2_local0[5] = 1000
        elseif f2_local3 > 7 then
            f2_local0[1] = 300
            f2_local0[22] = 300
            f2_local0[23] = 200
            f2_local0[24] = 200
        elseif f2_local3 > 3 then
            f2_local0[2] = 150
            f2_local0[3] = 100
            f2_local0[4] = 100
            f2_local0[8] = 100
            f2_local0[9] = 100
            f2_local0[22] = 200
            f2_local0[24] = 250
        else
            f2_local0[2] = 200
            f2_local0[9] = 300
            f2_local0[24] = 500
        end
        if SpaceCheck(f2_arg1, f2_arg2, 180, 6) == false then
            f2_local0[2] = 0
        end
        if SpaceCheck(f2_arg1, f2_arg2, -80, 6) == false then
            f2_local0[3] = 0
        end
        if SpaceCheck(f2_arg1, f2_arg2, 80, 6) == false then
            f2_local0[4] = 0
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
        f2_local0[1] = SetCoolTime(f2_arg1, f2_arg2, 3000, 5, f2_local0[1], 1)
        f2_local0[2] = SetCoolTime(f2_arg1, f2_arg2, 3002, 5, f2_local0[2], 1)
        f2_local0[3] = SetCoolTime(f2_arg1, f2_arg2, 3003, 5, f2_local0[3], 1)
        f2_local0[4] = SetCoolTime(f2_arg1, f2_arg2, 3004, 5, f2_local0[4], 1)
        f2_local0[5] = SetCoolTime(f2_arg1, f2_arg2, 3005, 8, f2_local0[5], 1)
        f2_local0[6] = SetCoolTime(f2_arg1, f2_arg2, 3006, 20, f2_local0[6], 1)
        f2_local0[7] = SetCoolTime(f2_arg1, f2_arg2, 3007, 15, f2_local0[7], 1)
        f2_local0[8] = SetCoolTime(f2_arg1, f2_arg2, 3010, 8, f2_local0[8], 1)
        f2_local0[9] = SetCoolTime(f2_arg1, f2_arg2, 3011, 8, f2_local0[9], 1)
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
    
end

Goal.Act01 = function (f3_arg0, f3_arg1, f3_arg2)
    local f3_local0 = 0
    local f3_local1 = 0
    local f3_local2 = f3_arg0:GetRandam_Int(1, 100)
    f3_arg0:AddObserveArea(0, TARGET_SELF, TARGET_ENE_0, AI_DIR_TYPE_F, 180, 2)
    if f3_local2 <= 60 then
        f3_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 10, 3000, TARGET_ENE_0, 9999, f3_local0, f3_local1, 0, 0)
    else
        f3_arg1:AddSubGoal(GOAL_COMMON_ComboAttackTunableSpin, 10, 3000, TARGET_ENE_0, 9999, f3_local0, f3_local1, 0, 0)
        f3_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3007, TARGET_ENE_0, 9999, 0, 0)
    end
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act02 = function (f4_arg0, f4_arg1, f4_arg2)
    local f4_local0 = 0
    local f4_local1 = 0
    local f4_local2 = f4_arg0:GetRandam_Int(1, 100)
    f4_arg0:AddObserveSpecialEffectAttribute(TARGET_SELF, 5025)
    f4_arg1:AddSubGoal(GOAL_COMMON_ComboAttackTunableSpin, 10, 3002, TARGET_ENE_0, 9999, f4_local0, f4_local1, 0, 0)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act03 = function (f5_arg0, f5_arg1, f5_arg2)
    local f5_local0 = 0
    local f5_local1 = 0
    local f5_local2 = f5_arg0:GetRandam_Int(1, 100)
    f5_arg0:AddObserveSpecialEffectAttribute(TARGET_SELF, 5025)
    f5_arg1:AddSubGoal(GOAL_COMMON_ComboAttackTunableSpin, 10, 3003, TARGET_ENE_0, 9999, f5_local0, f5_local1, 0, 0)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act04 = function (f6_arg0, f6_arg1, f6_arg2)
    local f6_local0 = 0
    local f6_local1 = 0
    local f6_local2 = f6_arg0:GetRandam_Int(1, 100)
    f6_arg0:AddObserveSpecialEffectAttribute(TARGET_SELF, 5025)
    f6_arg1:AddSubGoal(GOAL_COMMON_ComboAttackTunableSpin, 10, 3004, TARGET_ENE_0, 9999, f6_local0, f6_local1, 0, 0)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act05 = function (f7_arg0, f7_arg1, f7_arg2)
    local f7_local0 = 0
    local f7_local1 = 0
    f7_arg0:AddObserveArea(0, TARGET_SELF, TARGET_ENE_0, AI_DIR_TYPE_F, 180, 2)
    f7_arg1:AddSubGoal(GOAL_COMMON_ComboAttackTunableSpin, 10, 3005, TARGET_ENE_0, 9999, f7_local0, f7_local1, 0, 0)
    f7_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3007, TARGET_ENE_0, 9999, 0, 0)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act06 = function (f8_arg0, f8_arg1, f8_arg2)
    local f8_local0 = 0
    local f8_local1 = 0
    f8_arg0:AddObserveArea(0, TARGET_SELF, TARGET_ENE_0, AI_DIR_TYPE_F, 180, 2)
    f8_arg1:AddSubGoal(GOAL_COMMON_ComboAttackTunableSpin, 10, 3000, TARGET_ENE_0, 9999, f8_local0, f8_local1, 0, 0)
    f8_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3007, TARGET_ENE_0, 9999, 0, 0)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act07 = function (f9_arg0, f9_arg1, f9_arg2)
    local f9_local0 = 0
    local f9_local1 = 0
    f9_arg0:AddObserveArea(0, TARGET_SELF, TARGET_ENE_0, AI_DIR_TYPE_F, 180, 2)
    f9_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 10, 3007, TARGET_ENE_0, 9999, f9_local0, f9_local1, 0, 0)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act08 = function (f10_arg0, f10_arg1, f10_arg2)
    local f10_local0 = 5.9 - f10_arg0:GetMapHitRadius(TARGET_SELF)
    local f10_local1 = 5.9 - f10_arg0:GetMapHitRadius(TARGET_SELF) + 2
    local f10_local2 = 5.9 - f10_arg0:GetMapHitRadius(TARGET_SELF) + 2
    local f10_local3 = 100
    local f10_local4 = 0
    local f10_local5 = 1.5
    local f10_local6 = 3
    Approach_Act_Flex(f10_arg0, f10_arg1, f10_local0, f10_local1, f10_local2, f10_local3, f10_local4, f10_local5, f10_local6)
    local f10_local7 = 0
    local f10_local8 = 0
    local f10_local9 = f10_arg0:GetRandam_Int(1, 100)
    f10_arg1:AddSubGoal(GOAL_COMMON_ComboAttack_SuccessAngle180, 10, 3010, TARGET_ENE_0, 9999, 0, 0)
    f10_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3012, TARGET_ENE_0, 9999, 0, 0)
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
    
end

Goal.Act09 = function (f11_arg0, f11_arg1, f11_arg2)
    local f11_local0 = 4.6 - f11_arg0:GetMapHitRadius(TARGET_SELF)
    local f11_local1 = 4.6 - f11_arg0:GetMapHitRadius(TARGET_SELF) + 2
    local f11_local2 = 4.6 - f11_arg0:GetMapHitRadius(TARGET_SELF) + 2
    local f11_local3 = 100
    local f11_local4 = 0
    local f11_local5 = 1.5
    local f11_local6 = 3
    Approach_Act_Flex(f11_arg0, f11_arg1, f11_local0, f11_local1, f11_local2, f11_local3, f11_local4, f11_local5, f11_local6)
    local f11_local7 = 0
    local f11_local8 = 0
    local f11_local9 = f11_arg0:GetRandam_Int(1, 100)
    if f11_local9 <= 1 then
        f11_arg1:AddSubGoal(GOAL_COMMON_ComboAttackTunableSpin, 10, 3011, TARGET_ENE_0, 9999, f11_local7, f11_local8, 0, 0)
        f11_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3012, TARGET_ENE_0, 9999, 0, 0)
    else
        f11_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 10, 3011, TARGET_ENE_0, 9999, f11_local7, f11_local8, 0, 0)
    end
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
    
end

Goal.Act10 = function (f12_arg0, f12_arg1, f12_arg2)
    local f12_local0 = f12_arg0:GetDist(TARGET_ENE_0)
    local f12_local1 = 0
    local f12_local2 = 0
    local f12_local3 = 1702320 + f12_arg0:GetNumber(0)
    f12_arg0:SetEventMoveTarget(f12_local3)
    f12_arg1:AddSubGoal(GOAL_COMMON_ApproachTarget, 10, POINT_EVENT, 0.2, TARGET_SELF, false, -1):TimingSetNumber(0, f12_arg0:GetNumber(0) + 1, AI_TIMING_SET__UPDATE_SUCCESS)
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
    
end

Goal.Act11 = function (f13_arg0, f13_arg1, f13_arg2)
    local f13_local0 = f13_arg0:GetDist(TARGET_ENE_0)
    local f13_local1 = 0
    local f13_local2 = 0
    local f13_local3 = 1702320 + f13_arg0:GetNumber(0)
    f13_arg0:SetEventMoveTarget(f13_local3)
    f13_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 10, 3005, TARGET_ENE_0, 9999, f13_local1, f13_local2, 0, 0):TimingSetNumber(0, f13_arg0:GetNumber(0) + 1, AI_TIMING_SET__UPDATE_SUCCESS)
    f13_arg1:AddSubGoal(GOAL_COMMON_ApproachTarget, 10, POINT_EVENT, 0.2, TARGET_SELF, false, -1)
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
    
end

Goal.Act21 = function (f14_arg0, f14_arg1, f14_arg2)
    local f14_local0 = 3
    local f14_local1 = 45
    f14_arg1:AddSubGoal(GOAL_COMMON_Turn, f14_local0, TARGET_ENE_0, f14_local1, -1, GOAL_RESULT_Success, true)
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
    
end

Goal.Act22 = function (f15_arg0, f15_arg1, f15_arg2)
    local f15_local0 = 3
    local f15_local1 = 0
    local f15_local2 = f15_arg0:GetRandam_Int(1, 100)
    if SpaceCheck(f15_arg0, f15_arg1, -45, 2) == true then
        if SpaceCheck(f15_arg0, f15_arg1, 45, 2) == true then
            if f15_arg0:IsInsideTarget(TARGET_ENE_0, AI_DIR_TYPE_R, 180) then
                if SpaceCheck(f15_arg0, f15_arg1, -60, 4) == true and f15_local2 <= 60 then
                    f15_arg1:AddSubGoal(GOAL_COMMON_SpinStep, f15_local0, 5212, TARGET_ENE_0, f15_local1, AI_DIR_TYPE_L, 0)
                else
                    f15_arg1:AddSubGoal(GOAL_COMMON_SpinStep, f15_local0, 5202, TARGET_ENE_0, f15_local1, AI_DIR_TYPE_L, 0)
                end
            elseif SpaceCheck(f15_arg0, f15_arg1, 60, 4) == true and f15_local2 <= 60 then
                f15_arg1:AddSubGoal(GOAL_COMMON_SpinStep, f15_local0, 5213, TARGET_ENE_0, f15_local1, AI_DIR_TYPE_L, 0)
            else
                f15_arg1:AddSubGoal(GOAL_COMMON_SpinStep, f15_local0, 5203, TARGET_ENE_0, f15_local1, AI_DIR_TYPE_L, 0)
            end
        elseif SpaceCheck(f15_arg0, f15_arg1, -60, 4) == true and f15_local2 <= 60 then
            f15_arg1:AddSubGoal(GOAL_COMMON_SpinStep, f15_local0, 5212, TARGET_ENE_0, f15_local1, AI_DIR_TYPE_L, 0)
        else
            f15_arg1:AddSubGoal(GOAL_COMMON_SpinStep, f15_local0, 5202, TARGET_ENE_0, f15_local1, AI_DIR_TYPE_L, 0)
        end
    elseif SpaceCheck(f15_arg0, f15_arg1, 45, 2) == true then
        f15_arg1:AddSubGoal(GOAL_COMMON_SpinStep, f15_local0, 5203, TARGET_ENE_0, f15_local1, AI_DIR_TYPE_R, 0)
    else
        f15_arg1:AddSubGoal(GOAL_COMMON_SpinStep, f15_local0, 5203, TARGET_ENE_0, f15_local1, AI_DIR_TYPE_R, 0)
    end
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
    
end

Goal.Act23 = function (f16_arg0, f16_arg1, f16_arg2)
    local f16_local0 = f16_arg0:GetDist(TARGET_ENE_0)
    local f16_local1 = f16_arg0:GetSp(TARGET_SELF)
    local f16_local2 = 20
    local f16_local3 = f16_arg0:GetRandam_Int(1, 100)
    local f16_local4 = -1
    if f16_local2 <= f16_local1 and f16_local3 <= 50 then
        f16_local4 = -1
    end
    local f16_local5 = 0
    if SpaceCheck(f16_arg0, f16_arg1, -90, 1) == true then
        if SpaceCheck(f16_arg0, f16_arg1, 90, 1) == true then
            if f16_arg0:IsInsideTarget(TARGET_ENE_0, AI_DIR_TYPE_R, 180) then
                f16_local5 = 0
            else
                f16_local5 = 1
            end
        else
            f16_local5 = 0
        end
    elseif SpaceCheck(f16_arg0, f16_arg1, 90, 1) == true then
        f16_local5 = 1
    else
    end
    local f16_local6 = 3
    local f16_local7 = f16_arg0:GetRandam_Int(30, 45)
    f16_arg0:SetNumber(10, f16_local5)
    f16_arg1:AddSubGoal(GOAL_COMMON_SidewayMove, f16_local6, TARGET_ENE_0, f16_local5, f16_local7, true, true, f16_local4):TimingSetTimer(2, 4, UPDATE_SUCCESS)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act24 = function (f17_arg0, f17_arg1, f17_arg2)
    local f17_local0 = f17_arg0:GetDist(TARGET_ENE_0)
    local f17_local1 = 3
    local f17_local2 = 0
    local f17_local3 = 5201
    local f17_local4 = f17_arg0:GetRandam_Int(1, 100)
    if SpaceCheck(f17_arg0, f17_arg1, 180, 2) == true and SpaceCheck(f17_arg0, f17_arg1, 180, 4) == true and f17_local0 < 4 and f17_local4 < 60 then
        f17_local3 = 5211
        if false and false then
        else
        end
    end
    f17_arg1:AddSubGoal(GOAL_COMMON_SpinStep, f17_local1, f17_local3, TARGET_ENE_0, f17_local2, AI_DIR_TYPE_B, 0)
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
    
end

Goal.Act25 = function (f18_arg0, f18_arg1, f18_arg2)
    local f18_local0 = f18_arg0:GetRandam_Float(2, 4)
    local f18_local1 = f18_arg0:GetRandam_Float(1, 3)
    local f18_local2 = f18_arg0:GetDist(TARGET_ENE_0)
    local f18_local3 = -1
    f18_arg1:AddSubGoal(GOAL_COMMON_LeaveTarget, f18_local0, TARGET_ENE_0, f18_local1, TARGET_ENE_0, true, f18_local3)
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
    
end

Goal.Act26 = function (f19_arg0, f19_arg1, f19_arg2)
    f19_arg1:AddSubGoal(GOAL_COMMON_Wait, 0.5, TARGET_SELF, 0, 0, 0)
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
    
end

Goal.Act27 = function (f20_arg0, f20_arg1, f20_arg2)
    local f20_local0 = f20_arg0:GetRandam_Int(1, 100)
    if YousumiAct_SubGoal(f20_arg0, f20_arg1, true, 60, 30) == false then
        GetWellSpace_Odds = 0
        return GetWellSpace_Odds
    end
    local f20_local1 = 0
    local f20_local2 = SpaceCheck_SidewayMove(f20_arg0, f20_arg1, 1)
    if f20_local2 == 0 then
        f20_local1 = 0
    elseif f20_local2 == 1 then
        f20_local1 = 1
    elseif f20_local2 == 2 then
        if f20_local0 <= 50 then
            f20_local1 = 0
        else
            f20_local1 = 1
        end
    else
        f20_arg1:AddSubGoal(GOAL_COMMON_Wait, 0.5, TARGET_SELF, 0, 0, 0)
        GetWellSpace_Odds = 0
        return GetWellSpace_Odds
    end
    f20_arg0:SetNumber(10, f20_local1)
    f20_arg1:AddSubGoal(GOAL_COMMON_SidewayMove, 3, TARGET_ENE_0, f20_local1, f20_arg0:GetRandam_Int(30, 45), true, true, -1)
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
    
end

Goal.Act28 = function (f21_arg0, f21_arg1, f21_arg2)
    local f21_local0 = f21_arg0:GetDist(TARGET_ENE_0)
    local f21_local1 = 1.5
    local f21_local2 = 1.5
    local f21_local3 = f21_arg0:GetRandam_Int(30, 45)
    local f21_local4 = -1
    local f21_local5 = f21_arg0:GetRandam_Int(0, 1)
    if f21_local0 <= 15 then
        f21_arg1:AddSubGoal(GOAL_COMMON_SidewayMove, f21_local1, TARGET_ENE_0, f21_local5, f21_local3, true, true, f21_local4)
    else
        f21_arg1:AddSubGoal(GOAL_COMMON_ApproachTarget, f21_local2, TARGET_ENE_0, 10, TARGET_SELF, true, -1)
    end
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
    
end

Goal.Interrupt = function (f22_arg0, f22_arg1, f22_arg2)
    local f22_local0 = f22_arg1:GetSpecialEffectActivateInterruptType(0)
    local f22_local1 = f22_arg1:GetDist(TARGET_ENE_0)
    local f22_local2 = f22_arg1:GetRandam_Int(1, 100)
    if f22_arg1:IsLadderAct(TARGET_SELF) then
        return false
    end
    if not f22_arg1:HasSpecialEffectId(TARGET_SELF, 200004) then
        return false
    end
    if f22_arg1:IsInterupt(INTERUPT_Damaged) then
        return f22_arg0.Damaged(f22_arg1, f22_arg2)
    end
    if f22_arg1:IsInterupt(INTERUPT_ActivateSpecialEffect) then
        if f22_arg1:GetSpecialEffectActivateInterruptType(0) == 5025 and f22_local1 >= 9 and f22_local2 <= 40 then
            f22_arg2:ClearSubGoal()
            f22_arg2:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3007, TARGET_ENE_0, 9999, 0, 0)
            return true
        end
        return false
    end
    if f22_arg1:IsInterupt(INTERUPT_Inside_ObserveArea) and f22_arg1:IsInsideObserve(0) and f22_arg1:HasSpecialEffectId(TARGET_SELF, 5026) then
        f22_arg2:ClearSubGoal()
        f22_arg2:AddSubGoal(GOAL_COMMON_EndureAttack, 5, 3008, TARGET_ENE_0, 9999, 0, 0)
        f22_arg1:DeleteObserve(0)
        return true
    end
    return false
    
end

Goal.Parry = function (f23_arg0, f23_arg1, f23_arg2)
    local f23_local0 = f23_arg0:GetHpRate(TARGET_SELF)
    local f23_local1 = f23_arg0:GetDist(TARGET_ENE_0)
    local f23_local2 = f23_arg0:GetSp(TARGET_SELF)
    local f23_local3 = f23_arg0:GetRandam_Int(1, 100)
    local f23_local4 = 0
    if not f23_arg0:IsInsideTarget(TARGET_ENE_0, AI_DIR_TYPE_F, 90) or not f23_arg0:IsInsideTargetEx(TARGET_ENE_0, TARGET_SELF, AI_DIR_TYPE_F, 90, 3) or f23_arg0:HasSpecialEffectId(TARGET_ENE_0, 109012) then
    elseif f23_arg0:IsTargetGuard(TARGET_SELF) then
        if f23_arg0:HasSpecialEffectId(TARGET_ENE_0, 109970) and false then
        end
    elseif f23_arg0:HasSpecialEffectId(TARGET_ENE_0, 109970) then
    else
    end
    return false
    
end

Goal.Damaged = function (f24_arg0, f24_arg1, f24_arg2)
    local f24_local0 = f24_arg0:GetHpRate(TARGET_SELF)
    local f24_local1 = f24_arg0:GetDist(TARGET_ENE_0)
    local f24_local2 = f24_arg0:GetSp(TARGET_SELF)
    local f24_local3 = f24_arg0:GetRandam_Int(1, 100)
    local f24_local4 = 0
    if f24_local3 <= 33 then
        f24_arg1:ClearSubGoal()
        f24_arg1:AddSubGoal(GOAL_COMMON_SpinStep, 3, 5201, TARGET_ENE_0, TurnTime, AI_DIR_TYPE_B, 0):TimingSetTimer(3, 6, UPDATE_SUCCESS)
        return true
    elseif f24_local3 <= 67 then
    end
    return false
    
end

Goal.ActAfter_AdjustSpace = function (f25_arg0, f25_arg1, f25_arg2)
    
end

Goal.Update = function (f26_arg0, f26_arg1, f26_arg2)
    return Update_Default_NoSubGoal(f26_arg0, f26_arg1, f26_arg2)
    
end

Goal.Terminate = function (f27_arg0, f27_arg1, f27_arg2)
    
end

RegisterTableGoal(GOAL_YashazaruKenzoku_ju_125010_AfterAttackAct, "GOAL_YashazaruKenzoku_ju_125010_AfterAttackAct")
REGISTER_GOAL_NO_SUB_GOAL(GOAL_YashazaruKenzoku_ju_125010_AfterAttackAct, true)

Goal.Activate = function (f28_arg0, f28_arg1, f28_arg2)
    
end

Goal.Update = function (f29_arg0, f29_arg1, f29_arg2)
    return Update_Default_NoSubGoal(f29_arg0, f29_arg1, f29_arg2)
    
end


