RegisterTableGoal(GOAL_Yotakashu_Shuriken_145010_Battle, "GOAL_Yotakashu_Shuriken_145010_Battle")
REGISTER_GOAL_NO_UPDATE(GOAL_Yotakashu_Shuriken_145010_Battle, true)

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
    local f2_local5 = f2_arg1:GetEventRequest()
    local f2_local6 = f2_arg1:GetEventRequest(1)
    local f2_local7 = f2_arg1:GetNumber(0)
    if f2_arg1:GetNumber(4) >= f2_arg1:GetRandam_Int(5, 7) then
        f2_arg1:SetNumber(4, 0)
        f2_arg1:SetTimer(5, f2_arg1:GetRandam_Int(3, 8))
    end
    f2_arg1:AddObserveSpecialEffectAttribute(TARGET_SELF, 5025)
    f2_arg1:AddObserveSpecialEffectAttribute(TARGET_SELF, 5026)
    Set_ConsecutiveGuardCount_Interrupt(f2_arg1)
    f2_arg1:AddObserveSpecialEffectAttribute(TARGET_SELF, 5027)
    f2_arg1:DeleteObserve(0)
    f2_arg1:SetStringIndexedNumber("noRun", false)
    if f2_arg1:IsInsideTargetRegion(TARGET_SELF, COMMON_REGION_FORCE_WALK_M11_1) then
        f2_arg1:SetStringIndexedNumber("noRun", true)
    end
    f2_arg1:AddObserveRegion(30, TARGET_SELF, COMMON_REGION_FORCE_WALK_M11_1)
    if f2_arg0.Kengeki_Activate(f2_arg0, f2_arg1, f2_arg2) then
        return
    end
    if f2_arg1:HasSpecialEffectId(TARGET_SELF, 3145010) then
        f2_arg1:AddObserveRegion(1, TARGET_ENE_0, 1112260)
        f2_arg1:AddObserveRegion(2, TARGET_ENE_0, 1112261)
        f2_local0[26] = 100
    elseif f2_local5 == 10 and not f2_arg1:HasSpecialEffectId(TARGET_SELF, 5020) then
        f2_local0[10] = 100
    elseif Common_ActivateAct(f2_arg1, f2_arg2) then
    elseif f2_arg1:HasSpecialEffectId(TARGET_ENE_0, 109220) then
        f2_local0[27] = 100
        local f2_local8 = f2_arg1:GetDistYSigned(TARGET_ENE_0)
        if f2_local8 <= 0 and f2_arg1:HasSpecialEffectId(TARGET_ENE_0, 109220) then
            f2_local0[1] = 100
        elseif f2_local8 > 0 and f2_local8 < 10.5 and f2_arg1:HasSpecialEffectId(TARGET_ENE_0, 109220) then
            f2_local0[1] = 100
        end
    elseif f2_local4 == 1 and f2_arg1:GetTeamOrder(ORDER_TYPE_Role) == ROLE_TYPE_Kankyaku then
        if KankyakuAct(f2_arg1, f2_arg2, 20, 50, f2_arg1:GetStringIndexedNumber("noRun")) then
            f2_local0[1] = 100
            f2_local0[2] = 100
        end
    elseif f2_local4 == 1 and f2_arg1:GetTeamOrder(ORDER_TYPE_Role) == ROLE_TYPE_Torimaki then
        if TorimakiAct(f2_arg1, f2_arg2, 9.5, 70) then
            f2_local0[1] = 100
            f2_local0[2] = 100
        end
    elseif f2_arg1:IsInsideTarget(TARGET_ENE_0, AI_DIR_TYPE_B, 180) then
        f2_local0[21] = 100
        f2_local0[22] = 1
    elseif f2_arg1:IsFinishTimer(5) == false and f2_local3 >= 10 then
        f2_local0[27] = 100
    elseif f2_local3 >= 15 then
        f2_local0[1] = 500
        f2_local0[2] = 100
        f2_local0[3] = 0
        f2_local0[4] = 0
        f2_local0[5] = 0
        f2_local0[6] = 100
        f2_local0[8] = 50
    elseif f2_local3 >= 10 then
        f2_local0[1] = 500
        f2_local0[2] = 200
        f2_local0[3] = 200
        f2_local0[4] = 0
        f2_local0[5] = 0
        f2_local0[6] = 50
        f2_local0[7] = 100
        f2_local0[8] = 50
    elseif f2_local3 >= 5 then
        f2_local0[1] = 0
        f2_local0[2] = 0
        f2_local0[3] = 200
        f2_local0[4] = 0
        f2_local0[5] = 0
        f2_local0[6] = 0
        f2_local0[7] = 50
        f2_local0[8] = 50
        f2_local0[24] = 100
    elseif f2_local3 >= 3 then
        f2_local0[1] = 0
        f2_local0[2] = 0
        f2_local0[3] = 200
        f2_local0[4] = 50
        f2_local0[5] = 50
        f2_local0[6] = 0
        f2_local0[7] = 50
        f2_local0[8] = 0
        f2_local0[24] = 100
    else
        f2_local0[1] = 0
        f2_local0[2] = 0
        f2_local0[3] = 200
        f2_local0[4] = 100
        f2_local0[5] = 100
        f2_local0[6] = 0
        f2_local0[7] = 50
        f2_local0[8] = 0
        f2_local0[24] = 100
    end
    if f2_local3 <= 7 then
        f2_arg1:SetNumber(2, f2_arg1:GetNumber(2) + 1)
    else
        f2_arg1:SetNumber(2, 0)
    end
    if f2_arg1:GetNumber(2) <= 3 or f2_arg1:HasSpecialEffectId(TARGET_SELF, 200050) then
        f2_local0[3] = 0
        f2_local0[24] = 0
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
    if f2_local7 == 4 and f2_local0[4] > 0 then
        f2_local0[4] = 1
    end
    if f2_local7 == 5 and f2_local0[5] > 0 then
        f2_local0[5] = 1
    end
    if f2_local7 == 6 and f2_local0[6] > 0 then
        f2_local0[6] = 1
    end
    if f2_local7 == 8 and f2_local0[8] > 0 then
        f2_local0[8] = 1
    end
    if f2_local7 == 22 and f2_local0[22] > 0 then
        f2_local0[22] = 1
    end
    if f2_local7 == 24 and f2_local0[24] > 0 then
        f2_local0[24] = 1
    end
    f2_local0[1] = SetCoolTime(f2_arg1, f2_arg2, 3000, 15, f2_local0[1], 1)
    f2_local0[2] = SetCoolTime(f2_arg1, f2_arg2, 3003, 15, f2_local0[2], 1)
    f2_local0[3] = SetCoolTime(f2_arg1, f2_arg2, 3004, 10, f2_local0[3], 1)
    f2_local0[7] = SetCoolTime(f2_arg1, f2_arg2, 3010, 10, f2_local0[7], 1)
    f2_local0[9] = SetCoolTime(f2_arg1, f2_arg2, 3015, 15, f2_local0[9], 1)
    f2_local0[24] = SetCoolTime(f2_arg1, f2_arg2, 5211, 15, f2_local0[24], 1)
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
    f2_local1[30] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act30)
    f2_local1[21] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act21)
    f2_local1[22] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act22)
    f2_local1[23] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act23)
    f2_local1[24] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act24)
    f2_local1[25] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act25)
    f2_local1[26] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act26)
    f2_local1[27] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act27)
    f2_local1[28] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act28)
    local f2_local8 = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.ActAfter_AdjustSpace)
    Common_Battle_Activate(f2_arg1, f2_arg2, f2_local0, f2_local1, f2_local8, f2_local2)
    
end

Goal.Act01 = function (f3_arg0, f3_arg1, f3_arg2)
    local f3_local0 = f3_arg0:GetDist(TARGET_ENE_0)
    local f3_local1 = 25 - f3_arg0:GetMapHitRadius(TARGET_SELF)
    local f3_local2 = 25 - f3_arg0:GetMapHitRadius(TARGET_SELF) + 2
    local f3_local3 = 25 - f3_arg0:GetMapHitRadius(TARGET_SELF) + 2
    local f3_local4 = 100
    local f3_local5 = 0
    local f3_local6 = 1.5
    local f3_local7 = 3
    local f3_local8 = 3000
    local f3_local9 = 25 - f3_arg0:GetMapHitRadius(TARGET_SELF)
    local f3_local10 = 25 - f3_arg0:GetMapHitRadius(TARGET_SELF)
    local f3_local11 = 0
    local f3_local12 = 0
    if f3_local0 <= 15 then
        f3_local8 = 3030
    end
    f3_arg1:AddSubGoal(GOAL_COMMON_ComboAttackTunableSpin, 10, f3_local8, TARGET_ENE_0, f3_local9, f3_local11, f3_local12, 0, 0):TimingSetNumber(4, f3_arg0:GetNumber(4) + 2, AI_TIMING_SET__ACTIVATE)
    f3_arg0:SetNumber(1, 0)
    f3_arg0:AddObserveArea(0, TARGET_SELF, TARGET_ENE_0, AI_DIR_TYPE_F, 360, 7)
    f3_arg0:SetNumber(0, 1)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act02 = function (f4_arg0, f4_arg1, f4_arg2)
    local f4_local0 = f4_arg0:GetDist(TARGET_ENE_0)
    local f4_local1 = 25 - f4_arg0:GetMapHitRadius(TARGET_SELF)
    local f4_local2 = 25 - f4_arg0:GetMapHitRadius(TARGET_SELF) + 2
    local f4_local3 = 25 - f4_arg0:GetMapHitRadius(TARGET_SELF) + 2
    local f4_local4 = 100
    local f4_local5 = 0
    local f4_local6 = 1.5
    local f4_local7 = 3
    local f4_local8 = 3003
    local f4_local9 = 0
    local f4_local10 = 0
    if f4_local0 <= 15 then
        f4_local8 = 3033
    end
    f4_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 10, f4_local8, TARGET_ENE_0, 9999, f4_local9, f4_local10, 0, 0):TimingSetNumber(4, f4_arg0:GetNumber(4) + 2, AI_TIMING_SET__ACTIVATE)
    f4_arg0:SetNumber(0, 2)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act03 = function (f5_arg0, f5_arg1, f5_arg2)
    local f5_local0 = 0
    local f5_local1 = 0
    f5_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 10, 3004, TARGET_ENE_0, 9999, f5_local0, f5_local1, 0, 0):TimingSetNumber(4, f5_arg0:GetNumber(4) + 2, AI_TIMING_SET__ACTIVATE)
    f5_arg0:SetNumber(0, 3)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act04 = function (f6_arg0, f6_arg1, f6_arg2)
    local f6_local0 = 2.5 - f6_arg0:GetMapHitRadius(TARGET_SELF)
    local f6_local1 = 2.5 - f6_arg0:GetMapHitRadius(TARGET_SELF) + 2
    local f6_local2 = 2.5 - f6_arg0:GetMapHitRadius(TARGET_SELF) + 2
    local f6_local3 = 100
    local f6_local4 = 0
    local f6_local5 = 1.5
    local f6_local6 = 3
    local f6_local7 = f6_arg0:GetRandam_Int(1, 100)
    local f6_local8 = f6_arg0:GetRandam_Int(1, 100)
    Approach_Act_Flex(f6_arg0, f6_arg1, f6_local0, f6_local1, f6_local2, f6_local3, f6_local4, f6_local5, f6_local6)
    local f6_local9 = 3005
    local f6_local10 = 0
    local f6_local11 = 0
    if f6_local7 <= 50 then
        f6_local9 = 3006
    end
    if f6_local8 <= 50 then
        f6_local9 = f6_local9 + 2
    end
    f6_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 10, f6_local9, TARGET_ENE_0, 9999, f6_local10, f6_local11, 0, 0)
    f6_arg0:SetNumber(0, 4)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act05 = function (f7_arg0, f7_arg1, f7_arg2)
    local f7_local0 = 3.5 - f7_arg0:GetMapHitRadius(TARGET_SELF)
    local f7_local1 = 3.5 - f7_arg0:GetMapHitRadius(TARGET_SELF) + 0
    local f7_local2 = 3.5 - f7_arg0:GetMapHitRadius(TARGET_SELF) + 0
    local f7_local3 = 100
    local f7_local4 = 0
    local f7_local5 = 1.5
    local f7_local6 = 3
    Approach_Act_Flex(f7_arg0, f7_arg1, f7_local0, f7_local1, f7_local2, f7_local3, f7_local4, f7_local5, f7_local6)
    local f7_local7 = 0
    local f7_local8 = 0
    f7_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 10, 3009, TARGET_ENE_0, 9999, f7_local7, f7_local8, 0, 0)
    f7_arg0:SetNumber(0, 5)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act06 = function (f8_arg0, f8_arg1, f8_arg2)
    local f8_local0 = f8_arg0:GetDist(TARGET_ENE_0)
    local f8_local1 = 3010
    local f8_local2 = 0
    local f8_local3 = 0
    if f8_local0 <= 15 then
        f8_local1 = 3034
    end
    f8_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 10, f8_local1, TARGET_ENE_0, 9999, f8_local2, f8_local3, 0, 0):TimingSetNumber(4, f8_arg0:GetNumber(4) + 2, AI_TIMING_SET__ACTIVATE)
    f8_arg0:SetNumber(1, 0)
    f8_arg0:AddObserveArea(0, TARGET_SELF, TARGET_ENE_0, AI_DIR_TYPE_F, 360, 7)
    f8_arg0:SetNumber(0, 6)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act07 = function (f9_arg0, f9_arg1, f9_arg2)
    local f9_local0 = 15 - f9_arg0:GetMapHitRadius(TARGET_SELF)
    local f9_local1 = 15 - f9_arg0:GetMapHitRadius(TARGET_SELF) + 2
    local f9_local2 = 15 - f9_arg0:GetMapHitRadius(TARGET_SELF) + 2
    local f9_local3 = 100
    local f9_local4 = 0
    local f9_local5 = 1.5
    local f9_local6 = 3
    local f9_local7 = f9_arg0:GetRandam_Int(1, 100)
    local f9_local8 = 3012
    local f9_local9 = 0
    local f9_local10 = 0
    if f9_local7 <= 50 then
        f9_local0 = 15 - f9_arg0:GetMapHitRadius(TARGET_SELF)
        f9_local1 = 15 - f9_arg0:GetMapHitRadius(TARGET_SELF) + 2
        f9_local2 = 15 - f9_arg0:GetMapHitRadius(TARGET_SELF) + 2
        f9_local8 = 3013
    end
    f9_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 10, f9_local8, TARGET_ENE_0, 9999, f9_local9, f9_local10, 0, 0)
    f9_arg0:SetNumber(0, 7)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act08 = function (f10_arg0, f10_arg1, f10_arg2)
    local f10_local0 = f10_arg0:GetRandam_Int(1, 100)
    local f10_local1 = 0
    local f10_local2 = 0
    f10_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 10, 3014, TARGET_ENE_0, 9999, f10_local1, f10_local2, 0, 0):TimingSetNumber(4, f10_arg0:GetNumber(4) + 1, AI_TIMING_SET__ACTIVATE)
    if f10_local0 <= 30 then
        f10_arg0:AddObserveSpecialEffectAttribute(TARGET_SELF, 5027)
    end
    f10_arg0:SetNumber(0, 8)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act09 = function (f11_arg0, f11_arg1, f11_arg2)
    local f11_local0 = 10 - f11_arg0:GetMapHitRadius(TARGET_SELF)
    local f11_local1 = 10 - f11_arg0:GetMapHitRadius(TARGET_SELF) + 0
    local f11_local2 = 10 - f11_arg0:GetMapHitRadius(TARGET_SELF) + 0
    local f11_local3 = 100
    local f11_local4 = 0
    local f11_local5 = 1.5
    local f11_local6 = 3
    Approach_Act_Flex(f11_arg0, f11_arg1, f11_local0, f11_local1, f11_local2, f11_local3, f11_local4, f11_local5, f11_local6)
    local f11_local7 = 0
    local f11_local8 = 0
    f11_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 10, 3015, TARGET_ENE_0, 9999, f11_local7, f11_local8, 0, 0)
    f11_arg0:SetNumber(0, 5)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act10 = function (f12_arg0, f12_arg1, f12_arg2)
    local f12_local0 = 0
    local f12_local1 = 0
    f12_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 10, 20002, TARGET_ENE_0, 9999, f12_local0, f12_local1, 0, 0)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act30 = function (f13_arg0, f13_arg1, f13_arg2)
    local f13_local0 = 0
    local f13_local1 = 0
    f13_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 10, 3020, TARGET_ENE_0, 9999, f13_local0, f13_local1, 0, 0)
    f13_arg0:SetNumber(0, 30)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act31 = function (f14_arg0, f14_arg1, f14_arg2)
    local f14_local0 = 0
    local f14_local1 = 0
    local f14_local2 = 20000
    f14_arg1:AddSubGoal(GOAL_COMMON_AttackImmediateAction, 10, f14_local2, TARGET_ENE_0, 9999, f14_local0, f14_local1, 0, 0)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act21 = function (f15_arg0, f15_arg1, f15_arg2)
    local f15_local0 = 3
    local f15_local1 = 45
    f15_arg1:AddSubGoal(GOAL_COMMON_Turn, f15_local0, TARGET_ENE_0, f15_local1, -1, GOAL_RESULT_Success, true)
    f15_arg0:SetNumber(0, 21)
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
    
end

Goal.Act22 = function (f16_arg0, f16_arg1, f16_arg2)
    local f16_local0 = 3
    local f16_local1 = 0
    local f16_local2 = 5202
    if SpaceCheck(f16_arg0, f16_arg1, -45, 2) == true then
        if SpaceCheck(f16_arg0, f16_arg1, 45, 2) == true then
            if f16_arg0:IsInsideTarget(TARGET_ENE_0, AI_DIR_TYPE_R, 180) then
                f16_local2 = 5202
            else
                f16_local2 = 5203
            end
        else
            f16_local2 = 5202
        end
    elseif SpaceCheck(f16_arg0, f16_arg1, 45, 2) == true then
        f16_local2 = 5203
    else
    end
    f16_arg1:AddSubGoal(GOAL_COMMON_SpinStep, f16_local0, f16_local2, TARGET_ENE_0, f16_local1, AI_DIR_TYPE_R, 0)
    f16_arg0:SetNumber(0, 22)
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
    
end

Goal.Act23 = function (f17_arg0, f17_arg1, f17_arg2)
    local f17_local0 = f17_arg0:GetDist(TARGET_ENE_0)
    local f17_local1 = 0
    if SpaceCheck(f17_arg0, f17_arg1, -90, 1) == true then
        if SpaceCheck(f17_arg0, f17_arg1, 90, 1) == true then
            if f17_arg0:IsInsideTargetEx(TARGET_ENE_0, TARGET_SELF, AI_DIR_TYPE_R, 180, 999) then
                f17_local1 = 1
            else
                f17_local1 = 0
            end
        else
            f17_local1 = 0
        end
    elseif SpaceCheck(f17_arg0, f17_arg1, 90, 1) == true then
        f17_local1 = 1
    else
    end
    local f17_local2 = f17_arg0:GetRandam_Float(1, 1.5)
    local f17_local3 = f17_arg0:GetRandam_Int(30, 45)
    f17_arg1:AddSubGoal(GOAL_COMMON_SidewayMove, f17_local2, TARGET_ENE_0, f17_local1, f17_local3, true, true, -1)
    f17_arg0:SetNumber(0, 23)
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
    
end

Goal.Act24 = function (f18_arg0, f18_arg1, f18_arg2)
    local f18_local0 = f18_arg0:GetDist(TARGET_ENE_0)
    local f18_local1 = 3
    local f18_local2 = 0
    local f18_local3 = 5211
    if SpaceCheck(f18_arg0, f18_arg1, 180, 2) ~= true or SpaceCheck(f18_arg0, f18_arg1, 180, 4) ~= true or f18_local0 > 4 then
    else
        f18_local3 = 5211
        if false then
        else
        end
    end
    f18_arg1:AddSubGoal(GOAL_COMMON_SpinStep, f18_local1, f18_local3, TARGET_ENE_0, f18_local2, AI_DIR_TYPE_B, 0)
    f18_arg0:SetNumber(0, 24)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act25 = function (f19_arg0, f19_arg1, f19_arg2)
    local f19_local0 = f19_arg0:GetRandam_Float(2, 4)
    local f19_local1 = f19_arg0:GetRandam_Float(1, 3)
    local f19_local2 = f19_arg0:GetDist(TARGET_ENE_0)
    local f19_local3 = -1
    f19_arg1:AddSubGoal(GOAL_COMMON_LeaveTarget, f19_local0, TARGET_ENE_0, f19_local1, TARGET_ENE_0, true, f19_local3)
    f19_arg0:SetNumber(0, 25)
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
    
end

Goal.Act26 = function (f20_arg0, f20_arg1, f20_arg2)
    f20_arg1:AddSubGoal(GOAL_COMMON_Wait, 0.5, TARGET_SELF, 0, 0, 0)
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
    
end

Goal.Act27 = function (f21_arg0, f21_arg1, f21_arg2)
    local f21_local0 = f21_arg0:GetRandam_Int(1, 100)
    if YousumiAct_SubGoal(f21_arg0, f21_arg1, true, 60, 30) == false then
        GetWellSpace_Odds = 0
        return GetWellSpace_Odds
    end
    local f21_local1 = 0
    local f21_local2 = SpaceCheck_SidewayMove(f21_arg0, f21_arg1, 1)
    if f21_local2 == 0 then
        f21_local1 = 0
    elseif f21_local2 == 1 then
        f21_local1 = 1
    elseif f21_local2 == 2 then
        if f21_local0 <= 50 then
            f21_local1 = 0
        else
            f21_local1 = 1
        end
    else
        f21_arg1:AddSubGoal(GOAL_COMMON_Wait, 0.5, TARGET_SELF, 0, 0, 0)
        GetWellSpace_Odds = 0
        return GetWellSpace_Odds
    end
    f21_arg0:SetNumber(10, f21_local1)
    f21_arg1:AddSubGoal(GOAL_COMMON_SidewayMove, 3, TARGET_ENE_0, f21_local1, f21_arg0:GetRandam_Int(30, 45), true, true, -1)
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
    
end

Goal.Act28 = function (f22_arg0, f22_arg1, f22_arg2)
    local f22_local0 = f22_arg0:GetDist(TARGET_ENE_0)
    local f22_local1 = 1.5
    local f22_local2 = 1.5
    local f22_local3 = f22_arg0:GetRandam_Int(30, 45)
    local f22_local4 = -1
    local f22_local5 = f22_arg0:GetRandam_Int(0, 1)
    if f22_local0 <= 18 then
        f22_arg1:AddSubGoal(GOAL_COMMON_SidewayMove, f22_local1, TARGET_ENE_0, f22_local5, f22_local3, true, true, f22_local4)
    elseif f22_local0 <= 25 then
        f22_arg1:AddSubGoal(GOAL_COMMON_ApproachTarget, f22_local2, TARGET_ENE_0, 3, TARGET_SELF, true, -1)
    else
        f22_arg1:AddSubGoal(GOAL_COMMON_ApproachTarget, f22_local2, TARGET_ENE_0, 8, TARGET_SELF, false, -1)
    end
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
    
end

Goal.Interrupt = function (f23_arg0, f23_arg1, f23_arg2)
    local f23_local0 = f23_arg1:GetSpecialEffectActivateInterruptType(0)
    local f23_local1 = f23_arg1:GetDist(TARGET_ENE_0)
    local f23_local2 = f23_arg1:GetRandam_Int(1, 100)
    if f23_arg1:IsLadderAct(TARGET_SELF) then
        return false
    end
    if not f23_arg1:HasSpecialEffectId(TARGET_SELF, 200004) then
        return false
    end
    if f23_arg1:IsInterupt(INTERUPT_ParryTiming) then
        return Common_Parry(f23_arg1, f23_arg2, 0, 0)
    end
    if f23_arg1:IsInterupt(INTERUPT_Damaged) then
        return f23_arg0.Damaged(f23_arg1, f23_arg2)
    end
    if f23_arg1:IsInterupt(INTERUPT_ShootImpact) and f23_arg0.ShootReaction(f23_arg1, f23_arg2) then
        return true
    end
    if f23_arg1:IsInterupt(INTERUPT_ActivateSpecialEffect) then
        if f23_arg1:GetSpecialEffectActivateInterruptType(0) == 5025 and f23_arg1:GetNumber(1) == 0 then
            local f23_local3 = 3001
            if f23_local2 <= 70 then
                f23_local3 = 3001
                if f23_local1 <= 15 then
                    f23_local3 = 3031
                end
            else
                f23_local3 = 3011
                if f23_local1 <= 15 then
                    f23_local3 = 3035
                end
            end
            f23_arg2:ClearSubGoal()
            f23_arg2:AddSubGoal(GOAL_COMMON_ComboFinal, 5, f23_local3, TARGET_ENE_0, 9999, 0, 0):TimingSetNumber(4, f23_arg1:GetNumber(4) + 2, AI_TIMING_SET__ACTIVATE)
            return true
        elseif f23_arg1:GetSpecialEffectActivateInterruptType(0) == 5026 and f23_arg1:GetNumber(1) == 0 then
            local f23_local3 = 3002
            if f23_local1 <= 15 then
                f23_local3 = 3032
            end
            f23_arg2:ClearSubGoal()
            f23_arg2:AddSubGoal(GOAL_COMMON_ComboFinal, 5, f23_local3, TARGET_ENE_0, 9999, 0, 0):TimingSetNumber(4, f23_arg1:GetNumber(4) + 2, AI_TIMING_SET__ACTIVATE)
            return true
        elseif f23_arg1:GetSpecialEffectActivateInterruptType(0) == 5027 then
            if f23_local1 <= 10 then
                f23_arg2:ClearSubGoal()
                f23_arg2:AddSubGoal(GOAL_COMMON_ComboFinal, 5, 3015, TARGET_ENE_0, 9999, 0, 0):TimingSetNumber(4, f23_arg1:GetNumber(4) + 2, AI_TIMING_SET__ACTIVATE)
                return true
            else
                f23_arg1:SetTimer(3, 2)
                f23_arg1:Replanning()
            end
        end
    end
    if f23_arg1:IsInterupt(INTERUPT_Inside_ObserveArea) then
        if f23_arg1:IsInsideObserve(0) then
            f23_arg2:ClearSubGoal()
            f23_arg2:AddSubGoal(GOAL_COMMON_ComboFinal, 5, 3012, TARGET_ENE_0, 9999, 0):TimingSetNumber(4, f23_arg1:GetNumber(4) + 2, AI_TIMING_SET__ACTIVATE)
            f23_arg1:SetNumber(1, 1)
            f23_arg1:DeleteObserve(0)
            return true
        elseif f23_arg1:HasSpecialEffectId(TARGET_SELF, 3145010) and (f23_arg1:IsInsideObserve(1) or f23_arg1:IsInsideObserve(2)) then
            f23_arg2:ClearSubGoal()
            f23_arg2:AddSubGoal(GOAL_COMMON_AttackImmediateAction, 10, 20000, TARGET_ENE_0, 9999, 0)
            f23_arg1:DeleteObserve(1)
            f23_arg1:DeleteObserve(2)
            return true
        end
    end
    return false
    
end

Goal.Damaged = function (f24_arg0, f24_arg1, f24_arg2)
    if SpaceCheck(f24_arg0, f24_arg1, 180, 2) == false then
        f24_arg1:ClearSubGoal()
        f24_arg1:AddSubGoal(GOAL_COMMON_SpinStep, StepLife, 5201, TARGET_ENE_0, 0, AI_DIR_TYPE_B, 0)
        return true
    end
    return false
    
end

Goal.ShootReaction = function (f25_arg0, f25_arg1)
    f25_arg1:ClearSubGoal()
    f25_arg1:AddSubGoal(GOAL_COMMON_EndureAttack, 0.1, 3100, TARGET_ENE_0, 9999, 0)
    return true
    
end

Goal.Kengeki_Activate = function (f26_arg0, f26_arg1, f26_arg2, f26_arg3)
    local f26_local0 = ReturnKengekiSpecialEffect(f26_arg1)
    if f26_local0 == 0 then
        return false
    end
    local f26_local1 = {}
    local f26_local2 = {}
    local f26_local3 = {}
    Common_Clear_Param(f26_local1, f26_local2, f26_local3)
    local f26_local4 = f26_arg1:GetDist(TARGET_ENE_0)
    local f26_local5 = f26_arg1:GetSp(TARGET_SELF)
    if f26_local5 <= 0 then
        f26_local1[50] = 100
    elseif f26_local0 == 200216 then
        if f26_local4 >= 2 then
            f26_local1[50] = 100
        elseif f26_local4 <= 0.2 then
            f26_local1[50] = 100
        else
            f26_local1[6] = 100
        end
    end
    f26_local2[6] = REGIST_FUNC(f26_arg1, f26_arg2, f26_arg0.Kengeki06)
    f26_local2[50] = REGIST_FUNC(f26_arg1, f26_arg2, f26_arg0.NoAction)
    local f26_local6 = REGIST_FUNC(f26_arg1, f26_arg2, f26_arg0.ActAfter_AdjustSpace)
    return Common_Kengeki_Activate(f26_arg1, f26_arg2, f26_local1, f26_local2, f26_local6, f26_local3)
    
end

Goal.Kengeki06 = function (f27_arg0, f27_arg1, f27_arg2)
    local f27_local0 = f27_arg0:GetRandam_Int(1, 100)
    f27_arg1:ClearSubGoal()
    f27_arg1:AddSubGoal(GOAL_COMMON_ComboRepeat, 3, 3075, TARGET_ENE_0, 9999, 0, 0)
    if f27_local0 <= 100 then
        f27_arg1:AddSubGoal(GOAL_COMMON_ComboRepeat, 3, 3014, TARGET_ENE_0, 9999, 0, 0)
        if f27_local0 <= 100 then
            f27_arg0:AddObserveSpecialEffectAttribute(TARGET_SELF, 5027)
        end
    end
    
end

Goal.NoAction = function (f28_arg0, f28_arg1, f28_arg2)
    return -1
    
end

Goal.ActAfter_AdjustSpace = function (f29_arg0, f29_arg1, f29_arg2)
    
end

Goal.Update = function (f30_arg0, f30_arg1, f30_arg2)
    return Update_Default_NoSubGoal(f30_arg0, f30_arg1, f30_arg2)
    
end

Goal.Terminate = function (f31_arg0, f31_arg1, f31_arg2)
    
end


