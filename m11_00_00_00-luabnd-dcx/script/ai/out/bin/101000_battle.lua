RegisterTableGoal(GOAL_Ochimusha_katate_101000_Battle, "Ochimusha_katate_101000_Battle")
REGISTER_GOAL_NO_SUB_GOAL(GOAL_Ochimusha_katate_101000_Battle, true)

Goal.Initialize = function (f1_arg0, f1_arg1, f1_arg2, f1_arg3)
    
end

Goal.Activate = function (f2_arg0, f2_arg1, f2_arg2)
    Init_Pseudo_Global(f2_arg1, f2_arg2)
    f2_arg1:SetStringIndexedNumber("Dist_Step_Small", 2)
    f2_arg1:SetStringIndexedNumber("Dist_Step_Large", 4)
    f2_arg1:SetStringIndexedNumber("KengekiID", 0)
    f2_arg1:SetStringIndexedNumber("KaihukuSp", 30)
    if f2_arg0.Kengeki_Activate(f2_arg0, f2_arg1, f2_arg2) then
        return
    end
    f2_arg1:SetStringIndexedNumber("targetWhich", TARGET_ENE_0)
    if f2_arg1:IsInsideTargetEx(TARGET_ENE_0, TARGET_SELF, AI_DIR_TYPE_F, 120, 9999) or f2_arg1:HasSpecialEffectId(TARGET_SELF, 220020) then
        f2_arg1:SetStringIndexedNumber("karaburiDist", 0)
    else
        f2_arg1:SetStringIndexedNumber("karaburiDist", 2)
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
    local f2_local9 = f2_arg1:GetSpRate(TARGET_SELF)
    local f2_local10 = f2_arg1:GetDist(TARGET_ENE_0)
    local f2_local11 = f2_arg1:GetRandam_Int(1, 100)
    local f2_local12 = f2_arg1:GetExcelParam(AI_EXCEL_THINK_PARAM_TYPE__thinkAttr_doAdmirer)
    local f2_local13 = f2_arg1:GetNpcThinkParamID()
    local f2_local14 = f2_arg1:GetEventRequest()
    f2_arg1:AddObserveSpecialEffectAttribute(TARGET_ENE_0, 109031)
    f2_arg1:AddObserveSpecialEffectAttribute(TARGET_SELF, 107900)
    f2_arg1:AddObserveSpecialEffectAttribute(TARGET_ENE_0, 109220)
    f2_arg1:AddObserveSpecialEffectAttribute(TARGET_ENE_0, 109221)
    Set_ConsecutiveGuardCount_Interrupt(f2_arg1)
    if f2_arg1:HasSpecialEffectId(TARGET_ENE_0, 3170200) then
        f2_local0[25] = 1000
        f2_local0[1] = 1
    elseif f2_arg1:HasSpecialEffectId(TARGET_ENE_0, 3101540) then
        f2_local0[27] = 100
    elseif Common_ActivateAct(f2_arg1, f2_arg2) then
    elseif f2_arg1:CheckDoesExistPath(TARGET_ENE_0, AI_DIR_TYPE_F, 0, 0) == false or f2_arg1:HasSpecialEffectId(TARGET_ENE_0, 109220) or f2_arg1:HasSpecialEffectId(TARGET_ENE_0, 109221) then
        f2_local0[7] = 100
        f2_local0[27] = 100
    elseif f2_arg1:HasSpecialEffectId(TARGET_SELF, 107900) and f2_arg1:GetNumber(12) == 1 then
        f2_arg1:SetNumber(12, 0)
        f2_local0[6] = 100
    elseif f2_local12 == 1 and f2_arg1:GetTeamOrder(ORDER_TYPE_Role) == ROLE_TYPE_Kankyaku then
        KankyakuAct(f2_arg1, f2_arg2)
    elseif f2_local12 == 1 and f2_arg1:GetTeamOrder(ORDER_TYPE_Role) == ROLE_TYPE_Torimaki then
        if TorimakiAct(f2_arg1, f2_arg2) then
            f2_local0[1] = 50
            f2_local0[2] = 50
            f2_local0[7] = 100
        end
    elseif f2_arg1:HasSpecialEffectId(TARGET_SELF, 310000) then
        f2_local0[23] = 100
    elseif f2_arg1:HasSpecialEffectId(TARGET_SELF, 310001) then
        f2_local0[1] = 10
    elseif f2_arg1:HasSpecialEffectId(TARGET_SELF, 310020) then
        if f2_local9 < 0.4 then
            f2_local0[12] = 100
            f2_local0[1] = 1
            f2_local0[3] = 1
            f2_local0[11] = 1
        else
            f2_local0[1] = 10
            f2_local0[3] = 10
            f2_local0[11] = 10
        end
    elseif f2_arg1:HasSpecialEffectId(TARGET_SELF, 310060) then
        f2_local0[1] = 10
        f2_local0[14] = 10
        f2_local0[15] = 10
        f2_local0[23] = 10
    elseif f2_arg1:HasSpecialEffectId(TARGET_SELF, 310090) then
        f2_local0[1] = 10
        f2_local0[3] = 10
        f2_local0[11] = 10
    elseif f2_local10 >= 7 then
        if f2_arg1:HasSpecialEffectId(TARGET_SELF, 200050) and f2_arg1:GetNumber(5) == 0 or f2_arg1:HasSpecialEffectId(TARGET_ENE_0, 100002) then
            f2_local0[8] = 100
            f2_local0[9] = 100
        elseif f2_arg1:HasSpecialEffectId(TARGET_ENE_0, 109031) then
            f2_local0[23] = 100
        elseif f2_arg1:IsTargetGuard(TARGET_ENE_0) then
            f2_local0[1] = 0
            f2_local0[2] = 0
            f2_local0[3] = 100
            f2_local0[4] = 0
            f2_local0[5] = 200
            f2_local0[6] = 0
            f2_local0[7] = 0
            f2_local0[11] = 0
        else
            f2_local0[1] = 0
            f2_local0[2] = 100
            f2_local0[3] = 200
            f2_local0[4] = 0
            f2_local0[5] = 0
            f2_local0[6] = 0
            f2_local0[7] = 0
            f2_local0[11] = 0
        end
    elseif f2_local10 >= 5 then
        if f2_arg1:HasSpecialEffectId(TARGET_ENE_0, 109031) then
            f2_local0[23] = 100
        elseif f2_arg1:IsTargetGuard(TARGET_ENE_0) then
            f2_local0[1] = 0
            f2_local0[2] = 200
            f2_local0[3] = 100
            f2_local0[4] = 0
            f2_local0[5] = 200
            f2_local0[6] = 0
            f2_local0[7] = 0
            f2_local0[11] = 0
        else
            f2_local0[1] = 100
            f2_local0[2] = 200
            f2_local0[3] = 100
            f2_local0[4] = 0
            f2_local0[5] = 0
            f2_local0[6] = 100
            f2_local0[7] = 0
            f2_local0[11] = 100
        end
    elseif f2_local10 >= 3 then
        if f2_arg1:HasSpecialEffectId(TARGET_ENE_0, 109031) then
            f2_local0[24] = 100
            f2_local0[25] = 100
        elseif f2_arg1:IsTargetGuard(TARGET_ENE_0) then
            f2_local0[1] = 100
            f2_local0[2] = 0
            f2_local0[3] = 0
            f2_local0[4] = 0
            f2_local0[5] = 300
            f2_local0[6] = 100
            f2_local0[7] = 0
            f2_local0[11] = 100
        else
            f2_local0[1] = 100
            f2_local0[2] = 0
            f2_local0[3] = 0
            f2_local0[4] = 0
            f2_local0[5] = 0
            f2_local0[6] = 100
            f2_local0[7] = 0
            f2_local0[11] = 100
        end
    elseif f2_local10 >= 1 then
        if f2_arg1:HasSpecialEffectId(TARGET_ENE_0, 109031) then
            f2_local0[24] = 100
            f2_local0[25] = 100
        elseif f2_arg1:IsTargetGuard(TARGET_ENE_0) then
            f2_local0[1] = 100
            f2_local0[2] = 0
            f2_local0[3] = 0
            f2_local0[4] = 0
            f2_local0[5] = 300
            f2_local0[6] = 100
            f2_local0[7] = 0
            f2_local0[11] = 100
            f2_local0[24] = 0
        else
            f2_local0[1] = 200
            f2_local0[2] = 0
            f2_local0[3] = 0
            f2_local0[4] = 0
            f2_local0[5] = 0
            f2_local0[6] = 200
            f2_local0[7] = 0
            f2_local0[11] = 200
            f2_local0[24] = 0
        end
    elseif f2_arg1:HasSpecialEffectId(TARGET_ENE_0, 109031) then
        f2_local0[24] = 100
        f2_local0[25] = 100
    elseif f2_arg1:IsTargetGuard(TARGET_ENE_0) then
        f2_local0[1] = 100
        f2_local0[2] = 0
        f2_local0[3] = 0
        f2_local0[4] = 0
        f2_local0[5] = 300
        f2_local0[6] = 100
        f2_local0[7] = 0
        f2_local0[11] = 100
        f2_local0[24] = 0
    else
        f2_local0[1] = 200
        f2_local0[2] = 0
        f2_local0[3] = 0
        f2_local0[4] = 0
        f2_local0[5] = 0
        f2_local0[6] = 200
        f2_local0[7] = 0
        f2_local0[11] = 200
        f2_local0[24] = 50
    end
    if f2_arg1:IsFinishTimer(0) == false then
        f2_local0[12] = 0
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
    f2_local0[1] = SetCoolTime(f2_arg1, f2_arg2, 3000, 5, f2_local0[1], 1)
    f2_local0[2] = SetCoolTime(f2_arg1, f2_arg2, 3002, 5, f2_local0[2], 1)
    f2_local0[3] = SetCoolTime(f2_arg1, f2_arg2, 3003, 5, f2_local0[3], 1)
    f2_local0[4] = SetCoolTime(f2_arg1, f2_arg2, 3004, 10, f2_local0[4], 1)
    f2_local0[5] = SetCoolTime(f2_arg1, f2_arg2, 3005, 10, f2_local0[5], 1)
    f2_local0[6] = SetCoolTime(f2_arg1, f2_arg2, 3008, 10, f2_local0[6], 1)
    f2_local0[7] = SetCoolTime(f2_arg1, f2_arg2, 3009, 5, f2_local0[7], 1)
    f2_local0[8] = SetCoolTime(f2_arg1, f2_arg2, 3010, 15, f2_local0[8], 1)
    f2_local0[9] = SetCoolTime(f2_arg1, f2_arg2, 3011, 15, f2_local0[9], 1)
    f2_local0[11] = SetCoolTime(f2_arg1, f2_arg2, 3012, 5, f2_local0[11], 1)
    f2_local0[14] = SetCoolTime(f2_arg1, f2_arg2, 3014, 5, f2_local0[14], 1)
    f2_local0[15] = SetCoolTime(f2_arg1, f2_arg2, 3015, 5, f2_local0[15], 1)
    f2_local0[24] = SetCoolTime(f2_arg1, f2_arg2, 5211, 5, f2_local0[24], 1)
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
    f2_local1[12] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act12)
    f2_local1[13] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act13)
    f2_local1[14] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act14)
    f2_local1[15] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act15)
    f2_local1[21] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act21)
    f2_local1[22] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act22)
    f2_local1[23] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act23)
    f2_local1[24] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act24)
    f2_local1[25] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act25)
    f2_local1[26] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act26)
    f2_local1[27] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act27)
    f2_local1[28] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act28)
    f2_local1[41] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act41)
    local f2_local15 = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.ActAfter_AdjustSpace)
    Common_Battle_Activate(f2_arg1, f2_arg2, f2_local0, f2_local1, f2_local15, f2_local2)
    
end

Goal.Act01 = function (f3_arg0, f3_arg1, f3_arg2)
    local f3_local0 = f3_arg0:GetDist(TARGET_ENE_0)
    local f3_local1 = 2.5 - f3_arg0:GetMapHitRadius(TARGET_SELF) + f3_arg0:GetStringIndexedNumber("karaburiDist")
    local f3_local2 = 2.5 - f3_arg0:GetMapHitRadius(TARGET_SELF) + 0
    local f3_local3 = 2.5 - f3_arg0:GetMapHitRadius(TARGET_SELF) + 2
    local f3_local4 = 100
    local f3_local5 = 0
    local f3_local6 = 1.5
    local f3_local7 = 3
    if f3_local1 < f3_local0 then --距，Approach靠近
        Approach_Act_Flex(f3_arg0, f3_arg1, f3_local1, f3_local2, f3_local3, f3_local4, f3_local5, f3_local6, f3_local7)
    elseif f3_arg0:GetStringIndexedNumber("targetWhich") == TARGET_SELF then -- ？？？
        f3_arg1:AddSubGoal(GOAL_COMMON_Turn, 2, TARGET_ENE_0, 20, -1, GOAL_RESULT_Success, true)
    end
    local f3_local8 = 3000
    local f3_local9 = 3001
    local f3_local10 = 3 - f3_arg0:GetMapHitRadius(TARGET_SELF) + 1
    local f3_local11 = 0.5
    local f3_local12 = 90
    f3_arg1:AddSubGoal(GOAL_COMMON_ComboAttackTunableSpin, 10, f3_local8, f3_arg0:GetStringIndexedNumber("targetWhich"), f3_local10, f3_local11, f3_local12, 0, 0)
    f3_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, f3_local9, f3_arg0:GetStringIndexedNumber("targetWhich"), 9999, 0, 0)
    if f3_arg0:HasSpecialEffectId(TARGET_SELF, 310060) then
        f3_arg0:SetNumber(1, 1)
    end
    
end

Goal.Act02 = function (f4_arg0, f4_arg1, f4_arg2)
    local f4_local0 = f4_arg0:GetDist(TARGET_ENE_0)
    local f4_local1 = 7 - f4_arg0:GetMapHitRadius(TARGET_SELF) + f4_arg0:GetStringIndexedNumber("karaburiDist")
    local f4_local2 = 7 - f4_arg0:GetMapHitRadius(TARGET_SELF) + 0
    local f4_local3 = 7 - f4_arg0:GetMapHitRadius(TARGET_SELF) + 2
    local f4_local4 = 100
    local f4_local5 = 0
    local f4_local6 = 1.5
    local f4_local7 = 3
    if f4_local1 < f4_local0 then
        Approach_Act_Flex(f4_arg0, f4_arg1, f4_local1, f4_local2, f4_local3, f4_local4, f4_local5, f4_local6, f4_local7)
    elseif f4_arg0:GetStringIndexedNumber("targetWhich") == TARGET_SELF then
        f4_arg1:AddSubGoal(GOAL_COMMON_Turn, 2, TARGET_ENE_0, 20, -1, GOAL_RESULT_Success, true)
    end
    local f4_local8 = 3002
    local f4_local9 = 0.5
    local f4_local10 = 90
    f4_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 10, f4_local8, f4_arg0:GetStringIndexedNumber("targetWhich"), DistToAtt1, f4_local9, f4_local10, 0, 0)
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
    
end

Goal.Act03 = function (f5_arg0, f5_arg1, f5_arg2)
    local f5_local0 = f5_arg0:GetDist(TARGET_ENE_0)
    local f5_local1 = 7.1 - f5_arg0:GetMapHitRadius(TARGET_SELF) + f5_arg0:GetStringIndexedNumber("karaburiDist")
    local f5_local2 = 7.1 - f5_arg0:GetMapHitRadius(TARGET_SELF) + 0
    local f5_local3 = 7.1 - f5_arg0:GetMapHitRadius(TARGET_SELF) + 2
    local f5_local4 = 100
    local f5_local5 = 0
    local f5_local6 = 1.5
    local f5_local7 = 3
    if f5_local1 < f5_local0 then
        Approach_Act_Flex(f5_arg0, f5_arg1, f5_local1, f5_local2, f5_local3, f5_local4, f5_local5, f5_local6, f5_local7)
    elseif f5_arg0:GetStringIndexedNumber("targetWhich") == TARGET_SELF then
        f5_arg1:AddSubGoal(GOAL_COMMON_Turn, 2, TARGET_ENE_0, 20, -1, GOAL_RESULT_Success, true)
    end
    local f5_local8 = 3003
    local f5_local9 = 0.5
    local f5_local10 = 90
    f5_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 10, f5_local8, f5_arg0:GetStringIndexedNumber("targetWhich"), 9999, f5_local9, f5_local10, 0, 0)
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
    
end

Goal.Act04 = function (f6_arg0, f6_arg1, f6_arg2)
    local f6_local0 = f6_arg0:GetDist(TARGET_ENE_0)
    local f6_local1 = 3.1 - f6_arg0:GetMapHitRadius(TARGET_SELF) + f6_arg0:GetStringIndexedNumber("karaburiDist")
    local f6_local2 = 3.1 - f6_arg0:GetMapHitRadius(TARGET_SELF) + 0
    local f6_local3 = 3.1 - f6_arg0:GetMapHitRadius(TARGET_SELF) + 2
    local f6_local4 = 100
    local f6_local5 = 0
    local f6_local6 = 1.5
    local f6_local7 = 3
    if f6_local1 < f6_local0 then
        Approach_Act_Flex(f6_arg0, f6_arg1, f6_local1, f6_local2, f6_local3, f6_local4, f6_local5, f6_local6, f6_local7)
    elseif f6_arg0:GetStringIndexedNumber("targetWhich") == TARGET_SELF then
        f6_arg1:AddSubGoal(GOAL_COMMON_Turn, 2, TARGET_ENE_0, 20, -1, GOAL_RESULT_Success, true)
    end
    local f6_local8 = 3004
    local f6_local9 = 3006
    local f6_local10 = 3.7 - f6_arg0:GetMapHitRadius(TARGET_SELF) + 1
    local f6_local11 = 0.5
    local f6_local12 = 90
    f6_arg1:AddSubGoal(GOAL_COMMON_ComboAttackTunableSpin, 10, f6_local8, f6_arg0:GetStringIndexedNumber("targetWhich"), f6_local10, f6_local11, f6_local12, 0, 0)
    f6_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, f6_local9, f6_arg0:GetStringIndexedNumber("targetWhich"), 9999, 0, 0)
    
end

Goal.Act05 = function (f7_arg0, f7_arg1, f7_arg2)
    local f7_local0 = f7_arg0:GetDist(TARGET_ENE_0)
    local f7_local1 = 3.7 - f7_arg0:GetMapHitRadius(TARGET_SELF) + f7_arg0:GetStringIndexedNumber("karaburiDist")
    local f7_local2 = 3.7 - f7_arg0:GetMapHitRadius(TARGET_SELF) + 0
    local f7_local3 = 3.7 - f7_arg0:GetMapHitRadius(TARGET_SELF) + 2
    local f7_local4 = 100
    local f7_local5 = 0
    local f7_local6 = 1.5
    local f7_local7 = 3
    if f7_local1 < f7_local0 then
        Approach_Act_Flex(f7_arg0, f7_arg1, f7_local1, f7_local2, f7_local3, f7_local4, f7_local5, f7_local6, f7_local7)
    elseif f7_arg0:GetStringIndexedNumber("targetWhich") == TARGET_SELF then
        f7_arg1:AddSubGoal(GOAL_COMMON_Turn, 2, TARGET_ENE_0, 20, -1, GOAL_RESULT_Success, true)
    end
    local f7_local8 = 3005
    local f7_local9 = 3007
    local f7_local10 = 3.4 - f7_arg0:GetMapHitRadius(TARGET_SELF) + 1
    local f7_local11 = 0.5
    local f7_local12 = 90
    f7_arg1:AddSubGoal(GOAL_COMMON_ComboAttackTunableSpin, 10, f7_local8, f7_arg0:GetStringIndexedNumber("targetWhich"), f7_local10, f7_local11, f7_local12, 0, 0)
    f7_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, f7_local9, f7_arg0:GetStringIndexedNumber("targetWhich"), 9999, 0, 0)
    
end

Goal.Act06 = function (f8_arg0, f8_arg1, f8_arg2)
    local f8_local0 = f8_arg0:GetDist(TARGET_ENE_0)
    local f8_local1 = 4.7 - f8_arg0:GetMapHitRadius(TARGET_SELF) + f8_arg0:GetStringIndexedNumber("karaburiDist")
    local f8_local2 = 4.7 - f8_arg0:GetMapHitRadius(TARGET_SELF) + 0
    local f8_local3 = 4.7 - f8_arg0:GetMapHitRadius(TARGET_SELF) + 2
    local f8_local4 = 100
    local f8_local5 = 0
    local f8_local6 = 1.5
    local f8_local7 = 3
    if f8_local1 < f8_local0 then
        Approach_Act_Flex(f8_arg0, f8_arg1, f8_local1, f8_local2, f8_local3, f8_local4, f8_local5, f8_local6, f8_local7)
    elseif f8_arg0:GetStringIndexedNumber("targetWhich") == TARGET_SELF then
        f8_arg1:AddSubGoal(GOAL_COMMON_Turn, 2, TARGET_ENE_0, 20, -1, GOAL_RESULT_Success, true)
    end
    local f8_local8 = 3008
    local f8_local9 = 0.5
    local f8_local10 = 90
    f8_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 10, f8_local8, f8_arg0:GetStringIndexedNumber("targetWhich"), 9999, f8_local9, f8_local10, 0, 0)
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
    
end

Goal.Act07 = function (f9_arg0, f9_arg1, f9_arg2)
    local f9_local0 = f9_arg0:GetDist(TARGET_ENE_0)
    local f9_local1 = 12 - f9_arg0:GetMapHitRadius(TARGET_SELF) + f9_arg0:GetStringIndexedNumber("karaburiDist")
    local f9_local2 = 12 - f9_arg0:GetMapHitRadius(TARGET_SELF) + 0
    local f9_local3 = 12 - f9_arg0:GetMapHitRadius(TARGET_SELF) + 2
    local f9_local4 = 100
    local f9_local5 = 0
    local f9_local6 = 1.5
    local f9_local7 = 3
    if f9_local1 < f9_local0 then
    elseif f9_arg0:GetStringIndexedNumber("targetWhich") == TARGET_SELF then
    end
    local f9_local8 = 3009
    local f9_local9 = 0.5
    local f9_local10 = 90
    f9_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 10, f9_local8, f9_arg0:GetStringIndexedNumber("targetWhich"), 9999, f9_local9, f9_local10, 0, 0)
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
    
end

Goal.Act08 = function (f10_arg0, f10_arg1, f10_arg2)
    f10_arg0:SetNumber(5, 1)
    local f10_local0 = f10_arg0:GetDist(TARGET_ENE_0)
    local f10_local1 = 5 - f10_arg0:GetMapHitRadius(TARGET_SELF)
    if f10_arg0:HasSpecialEffectId(TARGET_ENE_0, 109900) then
        f10_local1 = f10_local1 + 4
    end
    local f10_local2 = f10_local1 + 0
    local f10_local3 = f10_local1 + 2
    local f10_local4 = 100
    local f10_local5 = 0
    local f10_local6 = 1.5
    local f10_local7 = 3
    if f10_local1 < f10_local0 then
        Approach_Act_Flex(f10_arg0, f10_arg1, f10_local1, f10_local2, f10_local3, f10_local4, f10_local5, f10_local6, f10_local7)
    end
    local f10_local8 = 3010
    local f10_local9 = 0.5
    local f10_local10 = 90
    f10_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 10, f10_local8, f10_arg0:GetStringIndexedNumber("targetWhich"), 9999, f10_local9, f10_local10, 0, 0)
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
    
end

Goal.Act09 = function (f11_arg0, f11_arg1, f11_arg2)
    f11_arg0:SetNumber(5, 1)
    local f11_local0 = f11_arg0:GetDist(TARGET_ENE_0)
    local f11_local1 = 7.6 - f11_arg0:GetMapHitRadius(TARGET_SELF)
    if f11_arg0:HasSpecialEffectId(TARGET_ENE_0, 109900) then
        f11_local1 = f11_local1 + 4
    end
    local f11_local2 = f11_local1 + 0
    local f11_local3 = f11_local1 + 2
    local f11_local4 = 100
    local f11_local5 = 0
    local f11_local6 = 1.5
    local f11_local7 = 3
    if f11_local1 < f11_local0 then
        Approach_Act_Flex(f11_arg0, f11_arg1, f11_local1, f11_local2, f11_local3, f11_local4, f11_local5, f11_local6, f11_local7)
    end
    local f11_local8 = 3011
    local f11_local9 = 0.5
    local f11_local10 = 90
    f11_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 10, f11_local8, f11_arg0:GetStringIndexedNumber("targetWhich"), 9999, f11_local9, f11_local10, 0, 0)
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
    
end

Goal.Act10 = function (f12_arg0, f12_arg1, f12_arg2)
    f12_arg0:SetEventMoveTarget(9622518)
    f12_arg1:AddSubGoal(GOAL_COMMON_ApproachTarget, 10, POINT_EVENT, 2, TARGET_SELF, false, -1)
    local f12_local0 = 3013
    local f12_local1 = 0.5
    local f12_local2 = 90
    f12_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 10, f12_local0, POINT_EVENT, 9999, f12_local1, f12_local2, 0, 0)
    
end

Goal.Act11 = function (f13_arg0, f13_arg1, f13_arg2)
    local f13_local0 = f13_arg0:GetDist(TARGET_ENE_0)
    local f13_local1 = 3.5 - f13_arg0:GetMapHitRadius(TARGET_SELF) + f13_arg0:GetStringIndexedNumber("karaburiDist")
    local f13_local2 = 3.5 - f13_arg0:GetMapHitRadius(TARGET_SELF) + 0
    local f13_local3 = 3.5 - f13_arg0:GetMapHitRadius(TARGET_SELF) + 2
    local f13_local4 = 100
    local f13_local5 = 0
    local f13_local6 = 1.5
    local f13_local7 = 3
    if f13_local1 < f13_local0 then
        Approach_Act_Flex(f13_arg0, f13_arg1, f13_local1, f13_local2, f13_local3, f13_local4, f13_local5, f13_local6, f13_local7)
    elseif f13_arg0:GetStringIndexedNumber("targetWhich") == TARGET_SELF then
        f13_arg1:AddSubGoal(GOAL_COMMON_Turn, 2, TARGET_ENE_0, 20, -1, GOAL_RESULT_Success, true)
    end
    local f13_local8 = 3012
    local f13_local9 = 0.5
    local f13_local10 = 90
    f13_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 10, f13_local8, f13_arg0:GetStringIndexedNumber("targetWhich"), 9999, f13_local9, f13_local10, 0, 0)
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
    
end

Goal.Act12 = function (f14_arg0, f14_arg1, f14_arg2)
    local f14_local0 = f14_arg0:GetDist(TARGET_ENE_0)
    local f14_local1 = 0.5
    local f14_local2 = 90
    if f14_local0 <= 5 and SpaceCheck(f14_arg0, f14_arg1, 180, 4) == true then
        f14_arg1:AddSubGoal(GOAL_COMMON_ComboAttackTunableSpin, 10, 5211, f14_arg0:GetStringIndexedNumber("targetWhich"), 9999, 0, 0)
        f14_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3030, TARGET_SELF, 9999, f14_local1, f14_local2, 0, 0)
    else
        f14_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 10, 3030, TARGET_SELF, 9999, f14_local1, f14_local2, 0, 0)
    end
    f14_arg0:SetTimer(0, 10)
    
end

Goal.Act13 = function (f15_arg0, f15_arg1, f15_arg2)
    f15_arg0:SetNumber(5, 1)
    local f15_local0 = 3011
    local f15_local1 = 0.5
    local f15_local2 = 90
    f15_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 10, f15_local0, TARGET_EVENT, 9999, f15_local1, f15_local2, 0, 0)
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
    
end

Goal.Act14 = function (f16_arg0, f16_arg1, f16_arg2)
    local f16_local0 = f16_arg0:GetDist(TARGET_ENE_0)
    local f16_local1 = 5 - f16_arg0:GetMapHitRadius(TARGET_SELF)
    local f16_local2 = 5 - f16_arg0:GetMapHitRadius(TARGET_SELF) + 0
    local f16_local3 = 5 - f16_arg0:GetMapHitRadius(TARGET_SELF) + 2
    local f16_local4 = 100
    local f16_local5 = 0
    local f16_local6 = 1.5
    local f16_local7 = 3
    if f16_local1 < f16_local0 then
        Approach_Act_Flex(f16_arg0, f16_arg1, f16_local1, f16_local2, f16_local3, f16_local4, f16_local5, f16_local6, f16_local7)
    end
    local f16_local8 = 3013
    local f16_local9 = 0.5
    local f16_local10 = 90
    f16_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 10, f16_local8, TARGET_ENE_0, 9999, f16_local9, f16_local10, 0, 0)
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
    
end

Goal.Act15 = function (f17_arg0, f17_arg1, f17_arg2)
    local f17_local0 = f17_arg0:GetDist(TARGET_ENE_0)
    local f17_local1 = 3.5 - f17_arg0:GetMapHitRadius(TARGET_SELF)
    local f17_local2 = 3.5 - f17_arg0:GetMapHitRadius(TARGET_SELF) + 0
    local f17_local3 = 3.5 - f17_arg0:GetMapHitRadius(TARGET_SELF) + 2
    local f17_local4 = 100
    local f17_local5 = 0
    local f17_local6 = 1.5
    local f17_local7 = 3
    if f17_local1 < f17_local0 then
        Approach_Act_Flex(f17_arg0, f17_arg1, f17_local1, f17_local2, f17_local3, f17_local4, f17_local5, f17_local6, f17_local7)
    end
    local f17_local8 = 3014
    local f17_local9 = 0.5
    local f17_local10 = 90
    f17_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 10, f17_local8, TARGET_ENE_0, 9999, f17_local9, f17_local10, 0, 0)
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
    
end

Goal.Act41 = function (f18_arg0, f18_arg1, f18_arg2)
    local f18_local0 = 3.5
    local f18_local1 = f18_arg0:GetRandam_Int(30, 45)
    local f18_local2 = 0
    if SpaceCheck(f18_arg0, f18_arg1, -90, 1) == true then
        if SpaceCheck(f18_arg0, f18_arg1, 90, 1) == true then
            if f18_arg0:IsInsideTarget(TARGET_ENE_0, AI_DIR_TYPE_R, 180) then
                f18_local2 = 0
            else
                f18_local2 = 1
            end
        else
            f18_local2 = 0
        end
    elseif SpaceCheck(f18_arg0, f18_arg1, 90, 1) == true then
        f18_local2 = 1
    else
    end
    f18_arg1:AddSubGoal(GOAL_COMMON_SidewayMove, f18_local0, TARGET_ENE_0, f18_local2, f18_local1, true, true, -1)
    return GETWELLSPACE_ODDS
    
end

Goal.Act21 = function (f19_arg0, f19_arg1, f19_arg2)
    local f19_local0 = 3
    local f19_local1 = 45
    if f19_arg0:IsTargetGuard(TARGET_SELF) then
        f19_arg1:AddSubGoal(GOAL_COMMON_Turn, f19_local0, TARGET_ENE_0, f19_local1, 9910, GOAL_RESULT_Success, true)
    else
        f19_arg1:AddSubGoal(GOAL_COMMON_Turn, f19_local0, TARGET_ENE_0, f19_local1, -1, GOAL_RESULT_Success, true)
    end
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
    
end

Goal.Act22 = function (f20_arg0, f20_arg1, f20_arg2)
    local f20_local0 = 3
    local f20_local1 = 0
    if SpaceCheck(f20_arg0, f20_arg1, -45, f20_arg0:GetStringIndexedNumber("Dist_Step_Small")) == true then
        if SpaceCheck(f20_arg0, f20_arg1, 45, f20_arg0:GetStringIndexedNumber("Dist_Step_Small")) == true then
            if f20_arg0:IsInsideTarget(TARGET_ENE_0, AI_DIR_TYPE_R, 180) then
                f20_arg1:AddSubGoal(GOAL_COMMON_SpinStep, f20_local0, 5202, TARGET_ENE_0, f20_local1, AI_DIR_TYPE_L, 0)
            else
                f20_arg1:AddSubGoal(GOAL_COMMON_SpinStep, f20_local0, 5203, TARGET_ENE_0, f20_local1, AI_DIR_TYPE_R, 0)
            end
        else
            f20_arg1:AddSubGoal(GOAL_COMMON_SpinStep, f20_local0, 5202, TARGET_ENE_0, f20_local1, AI_DIR_TYPE_L, 0)
        end
    elseif SpaceCheck(f20_arg0, f20_arg1, 45, f20_arg0:GetStringIndexedNumber("Dist_Step_Small")) == true then
        f20_arg1:AddSubGoal(GOAL_COMMON_SpinStep, f20_local0, 5203, TARGET_ENE_0, f20_local1, AI_DIR_TYPE_R, 0)
    else
    end
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
    
end

Goal.Act23 = function (f21_arg0, f21_arg1, f21_arg2)
    local f21_local0 = f21_arg0:GetSp(TARGET_SELF)
    local f21_local1 = 0
    local f21_local2 = f21_arg0:GetRandam_Int(1, 100)
    local f21_local3 = -1
    local f21_local4 = 0
    if f21_local1 <= f21_local0 and f21_local2 <= 0 then
        f21_local3 = 9910
    end
    if SpaceCheck(f21_arg0, f21_arg1, -90, 1) == true then
        if SpaceCheck(f21_arg0, f21_arg1, 90, 1) == true then
            if f21_arg0:IsInsideTarget(TARGET_ENE_0, AI_DIR_TYPE_R, 180) then
                f21_local4 = 1
            else
                f21_local4 = 0
            end
        else
            f21_local4 = 0
        end
    elseif SpaceCheck(f21_arg0, f21_arg1, 90, 1) == true then
        f21_local4 = 1
    else
        GetWellSpace_Odds = 100
        return GetWellSpace_Odds
    end
    local f21_local5 = 1.8
    local f21_local6 = f21_arg0:GetRandam_Int(30, 45)
    f21_arg1:AddSubGoal(GOAL_COMMON_SidewayMove, f21_local5, TARGET_ENE_0, f21_local4, f21_local6, true, true, f21_local3)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act24 = function (f22_arg0, f22_arg1, f22_arg2)
    local f22_local0 = f22_arg0:GetDist(TARGET_ENE_0)
    local f22_local1 = 3
    local f22_local2 = 0
    if SpaceCheck(f22_arg0, f22_arg1, 180, f22_arg0:GetStringIndexedNumber("Dist_Step_Small")) == true then
        if SpaceCheck(f22_arg0, f22_arg1, 180, f22_arg0:GetStringIndexedNumber("Dist_Step_Large")) == true then
            if f22_local0 > 4 then
                f22_arg1:AddSubGoal(GOAL_COMMON_SpinStep, f22_local1, 5201, TARGET_ENE_0, f22_local2, AI_DIR_TYPE_B, 0)
            else
                f22_arg1:AddSubGoal(GOAL_COMMON_SpinStep, f22_local1, 5211, TARGET_ENE_0, f22_local2, AI_DIR_TYPE_B, 0)
            end
        else
            f22_arg1:AddSubGoal(GOAL_COMMON_SpinStep, f22_local1, 5201, TARGET_ENE_0, f22_local2, AI_DIR_TYPE_B, 0)
        end
    else
    end
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
    
end

Goal.Act25 = function (f23_arg0, f23_arg1, f23_arg2)
    local f23_local0 = f23_arg0:GetSp(TARGET_SELF)
    local f23_local1 = 0
    local f23_local2 = f23_arg0:GetRandam_Int(1, 100)
    local f23_local3 = -1
    if not (f23_local1 <= f23_local0 and f23_local2 <= 100) and f23_arg0:HasSpecialEffectId(TARGET_ENE_0, 3170200) then
    end
    local f23_local4 = f23_arg0:GetRandam_Float(3, 5)
    local f23_local5 = 5
    if f23_arg0:HasSpecialEffectId(TARGET_ENE_0, 3170200) then
        f23_local5 = 999
    end
    if SpaceCheck(f23_arg0, f23_arg1, 180, 1) == true then
        f23_arg1:AddSubGoal(GOAL_COMMON_LeaveTarget, f23_local4, TARGET_ENE_0, f23_local5, TARGET_ENE_0, true, f23_local3)
    elseif f23_local3 == 9910 then
        f23_arg1:AddSubGoal(GOAL_COMMON_Guard, f23_local4, 9910, TARGET_ENE_0, false, 0)
    else
        f23_arg1:AddSubGoal(GOAL_COMMON_Wait, 5, TARGET_SELF, 0, 0, 0)
    end
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
    
end

Goal.Act26 = function (f24_arg0, f24_arg1, f24_arg2)
    f24_arg1:AddSubGoal(GOAL_COMMON_Wait, 0.5, TARGET_SELF, 0, 0, 0)
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
    
end

Goal.Act27 = function (f25_arg0, f25_arg1, f25_arg2)
    local f25_local0 = f25_arg0:GetRandam_Int(1, 100)
    if YousumiAct_SubGoal(f25_arg0, f25_arg1, true, 60, 30) == false then
        GetWellSpace_Odds = 0
        return GetWellSpace_Odds
    end
    local f25_local1 = 0
    local f25_local2 = SpaceCheck_SidewayMove(f25_arg0, f25_arg1, 1)
    if f25_local2 == 0 then
        f25_local1 = 0
    elseif f25_local2 == 1 then
        f25_local1 = 1
    elseif f25_local2 == 2 then
        if f25_local0 <= 50 then
            f25_local1 = 0
        else
            f25_local1 = 1
        end
    else
        f25_arg1:AddSubGoal(GOAL_COMMON_Wait, 1, TARGET_SELF, 0, 0, 0)
        GetWellSpace_Odds = 0
        return GetWellSpace_Odds
    end
    f25_arg0:SetNumber(10, f25_local1)
    f25_arg1:AddSubGoal(GOAL_COMMON_SidewayMove, 3, TARGET_ENE_0, f25_local1, f25_arg0:GetRandam_Int(30, 45), true, true, -1)
    return GET_WELL_SPACE_ODDS
    
end

Goal.Act28 = function (f26_arg0, f26_arg1, f26_arg2)
    local f26_local0 = f26_arg0:GetDist(TARGET_ENE_0)
    local f26_local1 = 1.5
    local f26_local2 = f26_arg0:GetRandam_Int(30, 45)
    local f26_local3 = -1
    local f26_local4 = 0
    if f26_local0 <= 3 then
        if SpaceCheck(f26_arg0, f26_arg1, -90, 1) == true then
            if SpaceCheck(f26_arg0, f26_arg1, 90, 1) == true then
                if f26_arg0:IsInsideTarget(TARGET_ENE_0, AI_DIR_TYPE_R, 180) then
                    f26_local4 = 1
                else
                    f26_local4 = 0
                end
            else
                f26_local4 = 0
            end
        elseif SpaceCheck(f26_arg0, f26_arg1, 90, 1) == true then
            f26_local4 = 1
        else
            GetWellSpace_Odds = 100
            return GetWellSpace_Odds
        end
        f26_arg1:AddSubGoal(GOAL_COMMON_SidewayMove, f26_local1, TARGET_ENE_0, f26_local4, f26_local2, true, true, f26_local3)
    elseif f26_local0 <= 8 then
        Approach_Act_Flex(f26_arg0, f26_arg1, 3, 3, 3, 100, 0, 1.5, 3)
    else
        Approach_Act_Flex(f26_arg0, f26_arg1, 8, 999, 999, 0, 0, 1.5, 3)
    end
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
    
end

Goal.Interrupt = function (f27_arg0, f27_arg1, f27_arg2)
    local f27_local0 = f27_arg1:GetHpRate(TARGET_SELF)
    local f27_local1 = f27_arg1:GetDist(TARGET_ENE_0)
    local f27_local2 = f27_arg1:GetSp(TARGET_SELF)
    local f27_local3 = f27_arg1:GetRandam_Int(1, 100)
    local f27_local4 = f27_arg1:GetSpecialEffectActivateInterruptType(0)
    if f27_arg1:IsLadderAct(TARGET_SELF) then
        return false
    end
    if not f27_arg1:HasSpecialEffectId(TARGET_SELF, 200004) then
        return false
    end
    if f27_arg1:GetSpecialEffectActivateInterruptType(0) == 109031 then
        f27_arg1:Replanning()
        return true
    end
    if f27_arg1:IsInterupt(INTERUPT_ActivateSpecialEffect) then
        if f27_local4 == 107900 then
            f27_arg1:SetNumber(12, 1)
            f27_arg2:ClearSubGoal()
            f27_arg1:Replanning()
            return true
        elseif f27_local4 == 109220 or f27_local4 == 109221 then
            f27_arg1:Replanning()
            return true
        end
    end
    if f27_arg1:IsInterupt(INTERUPT_ParryTiming) and not f27_arg1:HasSpecialEffectId(TARGET_ENE_0, 3502520) then
        return Common_Parry(f27_arg1, f27_arg2, 50, 25, 0, 3102)
    end
    if f27_arg1:IsInterupt(INTERUPT_LoseSightTarget) and f27_arg1:IsActiveGoal(GOAL_COMMON_SidewayMove) then
        if f27_arg1:GetNumber(10) == 0 then
            f27_arg2:ClearSubGoal()
            f27_arg2:AddSubGoal(GOAL_COMMON_SidewayMove, 1, TARGET_ENE_0, 1, f27_arg1:GetRandam_Int(30, 45), true, true, -1)
        elseif f27_arg1:GetNumber(10) == 1 then
            f27_arg2:ClearSubGoal()
            f27_arg2:AddSubGoal(GOAL_COMMON_SidewayMove, 1, TARGET_ENE_0, 0, f27_arg1:GetRandam_Int(30, 45), true, true, -1)
        end
        return true
    end
    if f27_arg1:IsInterupt(INTERUPT_ShootImpact) and f27_arg0.ShootReaction(f27_arg1, f27_arg2) then
        return true
    end
    return false
    
end

Goal.ShootReaction = function (f28_arg0, f28_arg1)
    f28_arg1:ClearSubGoal()
    f28_arg1:AddSubGoal(GOAL_COMMON_EndureAttack, 0.3, 3100, TARGET_ENE_0, 9999, 0)
    return true
    
end

Goal.Kengeki_Activate = function (f29_arg0, f29_arg1, f29_arg2)
    local f29_local0 = ReturnKengekiSpecialEffect(f29_arg1)
    if f29_local0 == 0 then
        return false
    end
    local f29_local1 = {}
    local f29_local2 = {}
    local f29_local3 = {}
    Common_Clear_Param(f29_local1, f29_local2, f29_local3)
    local f29_local4 = f29_arg1:GetDist(TARGET_ENE_0)
    local f29_local5 = f29_arg1:GetSp(TARGET_SELF)
    local f29_local6 = f29_arg1:GetRandam_Int(1, 100)
    local f29_local7 = f29_arg1:GetRandam_Int(1, 100)
    if f29_local0 == 200200 or f29_local0 == 200205 then
        if f29_local4 >= 2.7 then
        elseif f29_local4 <= 0.2 and SpaceCheck(f29_arg1, f29_arg2, 180, f29_arg1:GetStringIndexedNumber("Dist_Step_Large")) == true then
            f29_local1[30] = 50
            f29_local1[50] = 50
        else
            f29_local1[1] = 100
            f29_local1[2] = 100
            f29_local1[50] = 50
        end
    elseif f29_local0 == 200201 or f29_local0 == 200206 then
        if f29_local4 >= 2.7 then
        elseif f29_local4 <= 0.2 and SpaceCheck(f29_arg1, f29_arg2, 180, f29_arg1:GetStringIndexedNumber("Dist_Step_Large")) == true then
            f29_local1[30] = 50
            f29_local1[50] = 50
        else
            f29_local1[3] = 100
            f29_local1[4] = 100
            f29_local1[50] = 50
        end
    elseif f29_local0 == 200210 or f29_local0 == 200215 then
        if f29_local4 >= 2.7 then
        elseif f29_local4 <= 0.2 then
        elseif f29_local0 == 200210 and f29_arg1:HasSpecialEffectId(TARGET_SELF, 310080) then
            f29_local1[3] = 100
        elseif f29_local0 == 200215 and f29_arg1:HasSpecialEffectId(TARGET_SELF, 310080) then
            f29_local1[4] = 100
            f29_local1[7] = 100
        else
            f29_local1[5] = 0
            f29_local1[50] = 100
        end
    elseif f29_local0 ~= 200211 and f29_local0 ~= 200216 or f29_local4 >= 2.7 then
    elseif f29_local4 <= 0.2 then
    elseif f29_local0 == 200211 and f29_arg1:HasSpecialEffectId(TARGET_SELF, 310080) then
        f29_local1[3] = 100
    elseif f29_local0 == 200216 and f29_arg1:HasSpecialEffectId(TARGET_SELF, 310080) then
        f29_local1[4] = 100
        f29_local1[7] = 100
    else
        f29_local1[7] = 0
        f29_local1[50] = 100
    end
    f29_local2[1] = REGIST_FUNC(f29_arg1, f29_arg2, f29_arg0.Kengeki01)
    f29_local2[2] = REGIST_FUNC(f29_arg1, f29_arg2, f29_arg0.Kengeki02)
    f29_local2[3] = REGIST_FUNC(f29_arg1, f29_arg2, f29_arg0.Kengeki03)
    f29_local2[4] = REGIST_FUNC(f29_arg1, f29_arg2, f29_arg0.Kengeki04)
    f29_local2[5] = REGIST_FUNC(f29_arg1, f29_arg2, f29_arg0.Kengeki05)
    f29_local2[6] = REGIST_FUNC(f29_arg1, f29_arg2, f29_arg0.Kengeki06)
    f29_local2[7] = REGIST_FUNC(f29_arg1, f29_arg2, f29_arg0.Kengeki07)
    f29_local2[8] = REGIST_FUNC(f29_arg1, f29_arg2, f29_arg0.Kengeki08)
    f29_local2[21] = REGIST_FUNC(f29_arg1, f29_arg2, f29_arg0.Act21)
    f29_local2[22] = REGIST_FUNC(f29_arg1, f29_arg2, f29_arg0.Act22)
    f29_local2[23] = REGIST_FUNC(f29_arg1, f29_arg2, f29_arg0.Act23)
    f29_local2[24] = REGIST_FUNC(f29_arg1, f29_arg2, f29_arg0.Act24)
    f29_local2[25] = REGIST_FUNC(f29_arg1, f29_arg2, f29_arg0.Act25)
    f29_local2[30] = REGIST_FUNC(f29_arg1, f29_arg2, f29_arg0.Kengeki30)
    f29_local2[50] = REGIST_FUNC(f29_arg1, f29_arg2, f29_arg0.NoAction)
    local f29_local8 = REGIST_FUNC(f29_arg1, f29_arg2, f29_arg0.ActAfter_AdjustSpace)
    return Common_Kengeki_Activate(f29_arg1, f29_arg2, f29_local1, f29_local2, f29_local8, f29_local3)
    
end

Goal.Kengeki01 = function (f30_arg0, f30_arg1, f30_arg2)
    f30_arg1:ClearSubGoal()
    f30_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 1, 3050, TARGET_ENE_0, 9999, 0, 0)
    
end

Goal.Kengeki02 = function (f31_arg0, f31_arg1, f31_arg2)
    f31_arg1:ClearSubGoal()
    f31_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 1, 3051, TARGET_ENE_0, 9999, 0, 0)
    
end

Goal.Kengeki03 = function (f32_arg0, f32_arg1, f32_arg2)
    f32_arg1:ClearSubGoal()
    f32_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 1, 3055, TARGET_ENE_0, 9999, 0, 0)
    
end

Goal.Kengeki04 = function (f33_arg0, f33_arg1, f33_arg2)
    f33_arg1:ClearSubGoal()
    f33_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 1, 3056, TARGET_ENE_0, 9999, 0, 0)
    
end

Goal.Kengeki05 = function (f34_arg0, f34_arg1, f34_arg2)
    f34_arg0:SetNumber(0, 1)
    f34_arg1:ClearSubGoal()
    f34_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 1, 3070, TARGET_ENE_0, 9999, 0, 0)
    
end

Goal.Kengeki06 = function (f35_arg0, f35_arg1, f35_arg2)
    f35_arg0:SetNumber(0, 0)
    f35_arg1:ClearSubGoal()
    f35_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 1, 3071, TARGET_ENE_0, 9999, 0, 0)
    
end

Goal.Kengeki07 = function (f36_arg0, f36_arg1, f36_arg2)
    f36_arg1:ClearSubGoal()
    f36_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 1, 3075, TARGET_ENE_0, 9999, 0, 0)
    
end

Goal.Kengeki08 = function (f37_arg0, f37_arg1, f37_arg2)
    f37_arg1:ClearSubGoal()
    f37_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 1, 3076, TARGET_ENE_0, 9999, 0, 0)
    
end

Goal.Kengeki30 = function (f38_arg0, f38_arg1, f38_arg2)
    f38_arg1:ClearSubGoal()
    f38_arg1:AddSubGoal(GOAL_COMMON_ComboRepeat, 2, 5201, TARGET_ENE_0, TurnTime, AI_DIR_TYPE_B, 0)
    
end

Goal.NoAction = function (f39_arg0, f39_arg1, f39_arg2)
    return -1
    
end

Goal.ActAfter_AdjustSpace = function (f40_arg0, f40_arg1, f40_arg2)
    
end

Goal.Update = function (f41_arg0, f41_arg1, f41_arg2)
    return Update_Default_NoSubGoal(f41_arg0, f41_arg1, f41_arg2)
    
end

Goal.Terminate = function (f42_arg0, f42_arg1, f42_arg2)
    
end


