RegisterTableGoal(GOAL_Hakaisou500000_Battle, "Hakaisou500000_Battle")
REGISTER_GOAL_NO_SUB_GOAL(GOAL_Hakaisou500000_Battle, true)

Goal.Initialize = function (f1_arg0, f1_arg1, f1_arg2, f1_arg3)
    
end

Goal.Activate = function (f2_arg0, f2_arg1, f2_arg2)
    Init_Pseudo_Global(f2_arg1, f2_arg2)
    f2_arg1:SetStringIndexedNumber("Dist_SideStep", 0)
    f2_arg1:SetStringIndexedNumber("Dist_BackStep", 0)
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
    local f2_local9 = f2_arg1:GetEventRequest(1)
    local f2_local10 = f2_arg1:GetEventRequest(2)
    local f2_local11 = f2_arg1:GetNinsatsuMaxNum()
    local f2_local12 = f2_arg1:GetNinsatsuNum()
    local f2_local13 = f2_arg1:GetNinsatsuMaxNum()
    local f2_local14 = f2_arg1:GetNinsatsuNum()
    local f2_local15 = false
    if f2_local14 < f2_local13 then
        f2_local15 = true
    end
    local f2_local16 = f2_arg1:HasSpecialEffectId(TARGET_SELF, 200031)
    f2_arg1:SetStringIndexedNumber("IsHU2", f2_arg1:HasSpecialEffectId(TARGET_SELF, 200031))
    local f2_local17 = f2_arg1:GetNumber(2)
    f2_arg1:DeleteObserve(1)
    f2_arg1:SetNumber(11, 0)
    f2_arg1:AddObserveSpecialEffectAttribute(TARGET_SELF, 5020)
    f2_arg1:AddObserveSpecialEffectAttribute(TARGET_SELF, 5021)
    f2_arg1:AddObserveSpecialEffectAttribute(TARGET_SELF, 5026)
    f2_arg1:AddObserveSpecialEffectAttribute(TARGET_SELF, 5027)
    f2_arg1:AddObserveSpecialEffectAttribute(TARGET_SELF, 5029)
    f2_arg1:AddObserveSpecialEffectAttribute(TARGET_SELF, 5035)
    f2_arg1:AddObserveSpecialEffectAttribute(TARGET_SELF, 5038)
    f2_arg1:AddObserveSpecialEffectAttribute(TARGET_ENE_0, 110010)
    f2_arg1:AddObserveSpecialEffectAttribute(TARGET_ENE_0, 110125)
    f2_arg1:AddObserveSpecialEffectAttribute(TARGET_SELF, 107900)
    f2_arg1:AddObserveSpecialEffectAttribute(TARGET_SELF, 3500051)
    Set_ConsecutiveGuardCount_Interrupt(f2_arg1)
    if f2_arg0.Kengeki_Activate(f2_arg0, f2_arg1, f2_arg2) then
        return
    end
    local f2_local18 = 0
    if f2_local16 then
        f2_local18 = 1
    end
    if f2_arg1:HasSpecialEffectId(TARGET_ENE_0, 110060) or f2_arg1:HasSpecialEffectId(TARGET_ENE_0, 110010) then
        f2_local0[39] = 100
    elseif Common_ActivateAct(f2_arg1, f2_arg2, f2_local18, 1) then
    elseif f2_local9 == 10 then
        f2_local0[25] = 100
    elseif f2_arg1:IsInsideTargetRegion(TARGET_ENE_0, 9622850) == true or f2_arg1:IsInsideTargetRegion(TARGET_ENE_0, 2502853) == true or f2_arg1:IsInsideTargetRegion(TARGET_ENE_0, 2502868) == true or f2_arg1:IsInsideTargetRegion(TARGET_ENE_0, 2512853) == true then
        if f2_arg1:IsInsideTargetRegion(TARGET_ENE_0, 2502868) then
            f2_local0[11] = 0
            f2_local0[17] = 100
            f2_local0[18] = 0
            f2_local0[19] = 100
            f2_local0[43] = 200
        elseif f2_local5 >= 5.8 then
            f2_local0[11] = 0
            f2_local0[17] = 0
            f2_local0[18] = 0
            f2_local0[19] = 300
            f2_local0[43] = 300
        else
            f2_local0[11] = 100
            f2_local0[17] = 300
            f2_local0[18] = 300
            f2_local0[19] = 0
            f2_local0[43] = 600
        end
        if f2_local16 then
            f2_local0[11] = 0
        end
    elseif f2_arg1:IsInsideTargetRegion(TARGET_ENE_0, 1502810) == true then
        if f2_local5 >= 6 then
            f2_local0[19] = 300
            f2_local0[43] = 300
        elseif f2_local5 >= 4 then
            f2_local0[17] = 300
            f2_local0[18] = 300
            f2_local0[43] = 600
        else
            f2_local0[11] = 300
            f2_local0[17] = 100
            f2_local0[43] = 400
        end
    elseif f2_arg1:IsInsideTargetRegion(TARGET_ENE_0, 9622851) == true or f2_arg1:IsInsideTargetRegion(TARGET_ENE_0, 2502854) == true or f2_arg1:IsInsideTargetRegion(TARGET_ENE_0, 2512854) == true then
        f2_local0[20] = 200
        f2_local0[3] = 100
        f2_local0[43] = 150
    elseif f2_arg1:IsFinishTimer(0) == true and f2_local15 and not f2_local16 then
        f2_local0[16] = 100
    elseif f2_arg1:IsFinishTimer(2) == true and f2_local14 == 1 then
        f2_local0[22] = 100
    else
        if f2_arg1:GetNumber(3) == 0 then
            f2_local0[27] = 100
        elseif f2_arg1:IsInsideTargetRegion(TARGET_ENE_0, 2502869) then
            f2_local0[17] = 300
            f2_local0[31] = 100
        elseif not f2_arg1:IsExistMeshOnLine(TARGET_ENE_0, AI_DIR_TYPE_ToB, f2_local5) and f2_arg1:CheckDoesExistPath(TARGET_ENE_0, AI_DIR_TYPE_F, 0, 0) == true then
            f2_local0[30] = 100
        elseif f2_arg1:HasSpecialEffectId(TARGET_ENE_0, COMMON_SP_EFFECT_PC_BREAK) then
            f2_local0[4] = 100
        elseif f2_local5 >= 10 then
            f2_local0[1] = 100
            f2_local0[2] = 200
            f2_local0[3] = 0
            f2_local0[4] = 0
            f2_local0[5] = 0
            f2_local0[6] = 0
            f2_local0[7] = 0
            f2_local0[8] = 0
            f2_local0[9] = 0
            f2_local0[10] = 0
            f2_local0[11] = 0
            f2_local0[12] = 0
            f2_local0[13] = 0
            f2_local0[14] = 200
            f2_local0[24] = 300
        elseif f2_local5 >= 7 then
            f2_local0[1] = 150
            f2_local0[2] = 0
            f2_local0[3] = 0
            f2_local0[4] = 0
            f2_local0[5] = 0
            f2_local0[6] = 0
            f2_local0[7] = 0
            f2_local0[8] = 100
            f2_local0[9] = 0
            f2_local0[10] = 0
            f2_local0[11] = 0
            f2_local0[12] = 0
            f2_local0[13] = 0
            f2_local0[14] = 300
            f2_local0[24] = 200
        elseif f2_local5 >= 5 then
            f2_local0[1] = 50
            f2_local0[2] = 0
            f2_local0[3] = 200
            f2_local0[4] = 200
            f2_local0[5] = 100
            f2_local0[6] = 0
            f2_local0[7] = 0
            f2_local0[8] = 100
            f2_local0[9] = 0
            f2_local0[10] = 0
            f2_local0[11] = 0
            f2_local0[12] = 0
            f2_local0[13] = 0
            f2_local0[14] = 0
        elseif f2_local5 > 3 then
            f2_local0[1] = 0
            f2_local0[2] = 0
            f2_local0[3] = 150
            f2_local0[4] = 150
            f2_local0[5] = 100
            f2_local0[6] = 0
            f2_local0[7] = 0
            f2_local0[8] = 0
            f2_local0[9] = 0
            f2_local0[10] = 0
            f2_local0[11] = 0
            f2_local0[12] = 0
            f2_local0[13] = 100
            f2_local0[14] = 0
            f2_local0[26] = 50
        elseif f2_local5 > 1 then
            f2_local0[1] = 0
            f2_local0[2] = 0
            f2_local0[3] = 100
            f2_local0[4] = 100
            f2_local0[5] = 150
            f2_local0[6] = 0
            f2_local0[7] = 0
            f2_local0[8] = 0
            f2_local0[9] = 0
            f2_local0[10] = 0
            f2_local0[11] = 0
            f2_local0[12] = 0
            f2_local0[13] = 100
            f2_local0[14] = 0
            f2_local0[21] = 50
            f2_local0[26] = 100
        else
            f2_local0[1] = 0
            f2_local0[2] = 0
            f2_local0[3] = 50
            f2_local0[4] = 50
            f2_local0[5] = 20
            f2_local0[6] = 150
            f2_local0[7] = 150
            f2_local0[8] = 0
            f2_local0[9] = 0
            f2_local0[10] = 0
            f2_local0[11] = 0
            f2_local0[12] = 0
            f2_local0[13] = 0
            f2_local0[14] = 0
            f2_local0[21] = 100
            f2_local0[26] = 100
        end
        if f2_arg1:IsTargetGuard(TARGET_ENE_0) then
            f2_local0[5] = f2_local0[5] * 10
        end
        if not f2_local16 then
            f2_local0[4] = 0
            f2_local0[24] = 0
            f2_local0[26] = 0
        end
        if f2_local16 then
            f2_local0[1] = 0
            f2_local0[5] = 0
            f2_local0[6] = 0
            f2_local0[7] = 0
            f2_local0[8] = 0
            f2_local0[10] = 0
            f2_local0[11] = 0
            f2_local0[12] = 0
            f2_local0[21] = 0
        end
        if not (f2_arg1:IsExistMeshOnLine(TARGET_SELF, AI_DIR_TYPE_L, 2) and f2_arg1:IsExistMeshOnLine(TARGET_SELF, AI_DIR_TYPE_R, 2)) and f2_local5 <= 5 and not f2_local16 then
            f2_local0[42] = 400
        end
        if f2_arg1:HasSpecialEffectId(TARGET_ENE_0, 109900) then
            f2_local0[1] = f2_local0[1] * 1.5
            f2_local0[3] = f2_local0[3] * 0.5
            f2_local0[5] = f2_local0[5] * 1.5
            f2_local0[24] = f2_local0[24] * 1.5
            f2_local0[43] = 150
        end
    end
    f2_local0[1] = SetCoolTime(f2_arg1, f2_arg2, 3000, 8, f2_local0[1], 1)
    f2_local0[2] = SetCoolTime(f2_arg1, f2_arg2, 3001, 8, f2_local0[2], 1)
    f2_local0[3] = SetCoolTime(f2_arg1, f2_arg2, 3003, 10, f2_local0[3], 1)
    f2_local0[4] = SetCoolTime(f2_arg1, f2_arg2, 3009, 8, f2_local0[4], 1)
    f2_local0[5] = SetCoolTime(f2_arg1, f2_arg2, 3010, 8, f2_local0[5], 1)
    f2_local0[6] = SetCoolTime(f2_arg1, f2_arg2, 3012, 8, f2_local0[6], 1)
    f2_local0[7] = SetCoolTime(f2_arg1, f2_arg2, 3013, 8, f2_local0[7], 1)
    f2_local0[8] = SetCoolTime(f2_arg1, f2_arg2, 3015, 8, f2_local0[8], 1)
    f2_local0[13] = SetCoolTime(f2_arg1, f2_arg2, 3022, 8, f2_local0[13], 1)
    f2_local0[14] = SetCoolTime(f2_arg1, f2_arg2, 3023, 8, f2_local0[14], 1)
    f2_local0[14] = SetCoolTime(f2_arg1, f2_arg2, 3038, 8, f2_local0[14], 1)
    f2_local0[24] = SetCoolTime(f2_arg1, f2_arg2, 3039, 8, f2_local0[24], 1)
    f2_local0[26] = SetCoolTime(f2_arg1, f2_arg2, 3040, 10, f2_local0[26], 1)
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
    f2_local1[16] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act16)
    f2_local1[17] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act17)
    f2_local1[18] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act18)
    f2_local1[19] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act19)
    f2_local1[20] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act20)
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
    f2_local1[39] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act39)
    f2_local1[40] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act40)
    f2_local1[41] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act41)
    f2_local1[42] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act42)
    f2_local1[43] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act43)
    f2_local1[44] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act44)
    f2_local1[45] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act45)
    f2_local1[46] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act46)
    f2_local1[47] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act47)
    f2_local1[48] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act48)
    f2_local1[49] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act49)
    local f2_local19 = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.ActAfter_AdjustSpace)
    Common_Battle_Activate(f2_arg1, f2_arg2, f2_local0, f2_local1, f2_local19, f2_local2)
    
end

Goal.Act49 = function (f3_arg0, f3_arg1, f3_arg2)
    local f3_local0 = f3_arg0:GetDist(TARGET_ENE_0)
    local f3_local1 = 999
    local f3_local2 = false
    local f3_local3 = 3
    if f3_local1 < f3_local0 then
        f3_arg1:AddSubGoal(GOAL_COMMON_ApproachTarget, f3_local3, TARGET_ENE_0, f3_local1, TARGET_SELF, f3_local2, -1)
    end
    local f3_local4 = 3012
    local f3_local5 = 999
    local f3_local6 = 0
    local f3_local7 = 0
    f3_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 10, f3_local4, TARGET_ENE_0, f3_local5, f3_local6, f3_local7, 0, 0)
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
    
end

Goal.Act01 = function (f4_arg0, f4_arg1, f4_arg2)
    local f4_local0 = f4_arg0:GetDist(TARGET_ENE_0)
    local f4_local1 = 11.6 - f4_arg0:GetMapHitRadius(TARGET_SELF)
    local f4_local2 = false
    local f4_local3 = 1
    if f4_arg0:GetNumber(2) == 0 then
        f4_local2 = true
        f4_local3 = 5
    end
    if f4_local1 + 1 < f4_local0 then
        f4_local1 = f4_local1 + 1
    end
    if f4_local1 < f4_local0 then
        f4_arg1:AddSubGoal(GOAL_COMMON_ApproachTarget, f4_local3, TARGET_ENE_0, f4_local1, TARGET_SELF, f4_local2, -1)
    end
    local f4_local4 = 3000
    local f4_local5 = 11.6 - f4_arg0:GetMapHitRadius(TARGET_SELF)
    local f4_local6 = 0
    local f4_local7 = 0
    f4_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 10, f4_local4, TARGET_ENE_0, f4_local5, f4_local6, f4_local7, 0, 0)
    f4_arg0:SetNumber(2, 1)
    f4_arg0:SetNumber(5, 1)
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
    
end

Goal.Act02 = function (f5_arg0, f5_arg1, f5_arg2)
    local f5_local0 = f5_arg0:GetDist(TARGET_ENE_0)
    local f5_local1 = 17.9 - f5_arg0:GetMapHitRadius(TARGET_SELF)
    local f5_local2 = false
    local f5_local3 = 1
    if f5_arg0:GetNumber(2) == 0 then
        f5_local2 = true
        f5_local3 = 5
    end
    if f5_local1 + 1 < f5_local0 then
        f5_local1 = f5_local1 + 1
    end
    if f5_local1 < f5_local0 then
        f5_arg1:AddSubGoal(GOAL_COMMON_ApproachTarget, f5_local3, TARGET_ENE_0, f5_local1, TARGET_SELF, f5_local2, -1)
    end
    f5_arg0:AddObserveArea(1, TARGET_SELF, TARGET_ENE_0, AI_DIR_TYPE_F, 360, 5)
    local f5_local4 = 3001
    local f5_local5 = 3002
    local f5_local6 = 8 - f5_arg0:GetMapHitRadius(TARGET_SELF)
    local f5_local7 = 9999
    local f5_local8 = 0
    local f5_local9 = 0
    f5_arg1:AddSubGoal(GOAL_COMMON_ComboAttackTunableSpin, 10, f5_local4, TARGET_ENE_0, f5_local6, f5_local8, f5_local9, 0, 0)
    f5_arg0:SetNumber(2, 2)
    f5_arg0:SetNumber(5, 1)
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
    
end

Goal.Act03 = function (f6_arg0, f6_arg1, f6_arg2)
    local f6_local0 = f6_arg0:GetDist(TARGET_ENE_0)
    local f6_local1 = 5.6 - f6_arg0:GetMapHitRadius(TARGET_SELF) - 1
    local f6_local2 = false
    local f6_local3 = 3
    local f6_local4 = f6_arg0:GetEventRequest()
    local f6_local5 = f6_arg0:GetNinsatsuMaxNum()
    local f6_local6 = f6_arg0:GetNinsatsuNum()
    local f6_local7 = false
    if f6_local6 < f6_local5 then
        f6_local7 = true
    end
    local f6_local8 = f6_arg0:HasSpecialEffectId(TARGET_SELF, 200031)
    if f6_arg0:GetNumber(2) == 0 then
        f6_local2 = true
        f6_local3 = 5
    end
    local f6_local9 = 2
    local f6_local10 = f6_arg0:GetRandam_Int(1, 100)
    if f6_local1 + 1 < f6_local0 then
        f6_local1 = f6_local1 + 1
    end
    if f6_local1 < f6_local0 then
        f6_arg1:AddSubGoal(GOAL_COMMON_ApproachTarget, f6_local3, TARGET_ENE_0, f6_local1, TARGET_SELF, f6_local2, -1)
    end
    if f6_local8 then
        f6_local9 = f6_arg0:GetRandam_Int(3, 6)
    elseif f6_local7 then
        f6_local9 = f6_arg0:GetRandam_Int(1, 2)
    else
        f6_local9 = f6_arg0:GetRandam_Int(1, 2)
    end
    local f6_local11 = 3003
    local f6_local12 = 3004
    local f6_local13 = 3005
    local f6_local14 = 5.9 - f6_arg0:GetMapHitRadius(TARGET_SELF)
    local f6_local15 = 8.5 - f6_arg0:GetMapHitRadius(TARGET_SELF)
    local f6_local16 = 9999
    local f6_local17 = 0
    local f6_local18 = 0
    if f6_local9 == 1 then
        f6_local12 = 3004
        f6_local13 = 3006
        f6_local14 = 5.9 - f6_arg0:GetMapHitRadius(TARGET_SELF)
        f6_local15 = 7 - f6_arg0:GetMapHitRadius(TARGET_SELF)
    elseif f6_local9 == 2 then
        f6_local12 = 3004
        f6_local13 = 3005
        f6_local14 = 5.9 - f6_arg0:GetMapHitRadius(TARGET_SELF)
        f6_local15 = 8.5 - f6_arg0:GetMapHitRadius(TARGET_SELF)
    elseif f6_local9 == 3 then
        f6_local12 = 3007
        f6_local13 = 3008
        f6_local14 = 7.3 - f6_arg0:GetMapHitRadius(TARGET_SELF)
        f6_local15 = 6.2 - f6_arg0:GetMapHitRadius(TARGET_SELF)
    elseif f6_local9 == 4 then
        f6_local12 = 3004
        f6_local13 = 3040
        f6_local14 = 5.9 - f6_arg0:GetMapHitRadius(TARGET_SELF)
        f6_local15 = 8.5 - f6_arg0:GetMapHitRadius(TARGET_SELF)
    elseif f6_local9 == 5 then
        f6_local12 = 3007
        f6_local13 = 3040
        f6_local14 = 7.3 - f6_arg0:GetMapHitRadius(TARGET_SELF)
        f6_local15 = 6.2 - f6_arg0:GetMapHitRadius(TARGET_SELF)
    else
        f6_local12 = 3004
        f6_local13 = 3005
        f6_local14 = 5.9 - f6_arg0:GetMapHitRadius(TARGET_SELF)
        f6_local15 = 8.5 - f6_arg0:GetMapHitRadius(TARGET_SELF)
    end
    f6_arg1:AddSubGoal(GOAL_COMMON_ComboTunable_SuccessAngle180, 10, f6_local11, TARGET_ENE_0, 9999, f6_local17, f6_local18, 0, 0)
    f6_arg1:AddSubGoal(GOAL_COMMON_ComboRepeat_SuccessAngle180, 10, f6_local12, TARGET_ENE_0, 9999, 0, 0)
    f6_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, f6_local13, TARGET_ENE_0, 9999, 0, 0)
    f6_arg0:SetNumber(2, 3)
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
    
end

Goal.Act04 = function (f7_arg0, f7_arg1, f7_arg2)
    local f7_local0 = f7_arg0:GetDist(TARGET_ENE_0)
    local f7_local1 = 6 - f7_arg0:GetMapHitRadius(TARGET_SELF)
    local f7_local2 = false
    local f7_local3 = 3
    if f7_arg0:GetNumber(2) == 0 then
        f7_local2 = true
        f7_local3 = 5
    end
    if f7_local1 + 1 < f7_local0 then
        f7_local1 = f7_local1 + 1
    end
    if f7_local1 < f7_local0 then
        f7_arg1:AddSubGoal(GOAL_COMMON_ApproachTarget, f7_local3, TARGET_ENE_0, f7_local1, TARGET_SELF, f7_local2, -1)
    end
    local f7_local4 = 3009
    local f7_local5 = 6 - f7_arg0:GetMapHitRadius(TARGET_SELF)
    local f7_local6 = 0
    local f7_local7 = 0
    f7_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 10, f7_local4, TARGET_ENE_0, f7_local5, f7_local6, f7_local7, 0, 0)
    f7_arg0:SetNumber(2, 4)
    f7_arg0:SetNumber(5, 1)
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
    
end

Goal.Act05 = function (f8_arg0, f8_arg1, f8_arg2)
    local f8_local0 = f8_arg0:GetDist(TARGET_ENE_0)
    local f8_local1 = 7 - f8_arg0:GetMapHitRadius(TARGET_SELF)
    local f8_local2 = false
    local f8_local3 = 3
    if f8_arg0:GetNumber(2) == 0 then
        f8_local2 = true
        f8_local3 = 5
    end
    if f8_local1 + 1 < f8_local0 then
        f8_local1 = f8_local1 + 1
    end
    if f8_local1 < f8_local0 then
        f8_arg1:AddSubGoal(GOAL_COMMON_ApproachTarget, f8_local3, TARGET_ENE_0, f8_local1, TARGET_SELF, f8_local2, -1)
    end
    local f8_local4 = 3010
    local f8_local5 = 3011
    local f8_local6 = 9 - f8_arg0:GetMapHitRadius(TARGET_SELF)
    local f8_local7 = 9999
    local f8_local8 = 0
    local f8_local9 = 0
    f8_arg1:AddSubGoal(GOAL_COMMON_ComboTunable_SuccessAngle180, 10, f8_local4, TARGET_ENE_0, 9999, f8_local8, f8_local9, 0, 0)
    f8_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, f8_local5, TARGET_ENE_0, f8_local7, 0, 0)
    f8_arg0:SetNumber(2, 5)
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
    
end

Goal.Act06 = function (f9_arg0, f9_arg1, f9_arg2)
    local f9_local0 = f9_arg0:GetDist(TARGET_ENE_0)
    local f9_local1 = 2.5 - f9_arg0:GetMapHitRadius(TARGET_SELF)
    local f9_local2 = false
    local f9_local3 = 3
    if f9_arg0:GetNumber(2) == 0 then
        f9_local2 = true
        f9_local3 = 5
    end
    if f9_local1 + 1 < f9_local0 then
        f9_local1 = f9_local1 + 1
    end
    if f9_local1 < f9_local0 then
        f9_arg1:AddSubGoal(GOAL_COMMON_ApproachTarget, f9_local3, TARGET_ENE_0, f9_local1, TARGET_SELF, f9_local2, -1)
    end
    local f9_local4 = 3012
    local f9_local5 = 2.5 - f9_arg0:GetMapHitRadius(TARGET_SELF)
    local f9_local6 = 0
    local f9_local7 = 0
    f9_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 10, f9_local4, TARGET_ENE_0, f9_local5, f9_local6, f9_local7, 0, 0)
    f9_arg0:SetNumber(2, 6)
    f9_arg0:SetNumber(5, 1)
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
    
end

Goal.Act07 = function (f10_arg0, f10_arg1, f10_arg2)
    local f10_local0 = f10_arg0:GetDist(TARGET_ENE_0)
    local f10_local1 = 3.5 - f10_arg0:GetMapHitRadius(TARGET_SELF)
    local f10_local2 = false
    local f10_local3 = 3
    if f10_arg0:GetNumber(2) == 0 then
        f10_local2 = true
        f10_local3 = 5
    end
    if f10_local1 + 1 < f10_local0 then
        f10_local1 = f10_local1 + 1
    end
    if f10_local1 < f10_local0 then
        f10_arg1:AddSubGoal(GOAL_COMMON_ApproachTarget, f10_local3, TARGET_ENE_0, f10_local1, TARGET_SELF, f10_local2, -1)
    end
    local f10_local4 = 3013
    local f10_local5 = 3014
    local f10_local6 = 5.9 - f10_arg0:GetMapHitRadius(TARGET_SELF)
    local f10_local7 = 9999
    local f10_local8 = 0
    local f10_local9 = 0
    f10_arg1:AddSubGoal(GOAL_COMMON_ComboTunable_SuccessAngle180, 10, f10_local4, TARGET_ENE_0, 9999, f10_local8, f10_local9, 0, 0)
    f10_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, f10_local5, TARGET_ENE_0, f10_local7, 0, 0)
    f10_arg0:SetNumber(2, 7)
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
    
end

Goal.Act08 = function (f11_arg0, f11_arg1, f11_arg2)
    local f11_local0 = f11_arg0:GetDist(TARGET_ENE_0)
    local f11_local1 = 5.9 - f11_arg0:GetMapHitRadius(TARGET_SELF)
    local f11_local2 = false
    local f11_local3 = 3
    if f11_arg0:GetNumber(2) == 0 then
        f11_local2 = true
        f11_local3 = 5
    end
    if f11_local1 + 1 < f11_local0 then
        f11_local1 = f11_local1 + 1
    end
    if f11_local1 < f11_local0 then
        f11_arg1:AddSubGoal(GOAL_COMMON_ApproachTarget, f11_local3, TARGET_ENE_0, f11_local1, TARGET_SELF, f11_local2, -1)
    end
    local f11_local4 = 3015
    local f11_local5 = 5.9 - f11_arg0:GetMapHitRadius(TARGET_SELF)
    local f11_local6 = 0
    local f11_local7 = 0
    f11_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 10, f11_local4, TARGET_ENE_0, f11_local5, f11_local6, f11_local7, 0, 0)
    f11_arg0:SetNumber(2, 8)
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
    
end

Goal.Act09 = function (f12_arg0, f12_arg1, f12_arg2)
    local f12_local0 = f12_arg0:GetDist(TARGET_ENE_0)
    local f12_local1 = 5.3 - f12_arg0:GetMapHitRadius(TARGET_SELF)
    local f12_local2 = false
    local f12_local3 = 3
    if f12_arg0:GetNumber(2) == 0 then
        f12_local2 = true
        f12_local3 = 5
    end
    if f12_local1 < f12_local0 then
        f12_arg1:AddSubGoal(GOAL_COMMON_ApproachTarget, f12_local3, TARGET_ENE_0, f12_local1, TARGET_SELF, f12_local2, -1)
    end
    local f12_local4 = 3016
    local f12_local5 = 5.3 - f12_arg0:GetMapHitRadius(TARGET_SELF)
    local f12_local6 = 0
    local f12_local7 = 0
    f12_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 10, f12_local4, TARGET_ENE_0, f12_local5, f12_local6, f12_local7, 0, 0)
    f12_arg0:SetNumber(2, 9)
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
    
end

Goal.Act10 = function (f13_arg0, f13_arg1, f13_arg2)
    local f13_local0 = f13_arg0:GetDist(TARGET_ENE_0)
    local f13_local1 = 4.4 - f13_arg0:GetMapHitRadius(TARGET_SELF)
    local f13_local2 = false
    local f13_local3 = 3
    if f13_arg0:GetNumber(2) == 0 then
        f13_local2 = true
        f13_local3 = 5
    end
    if f13_local1 + 1 < f13_local0 then
        f13_local1 = f13_local1 + 1
    end
    if f13_local1 < f13_local0 then
        f13_arg1:AddSubGoal(GOAL_COMMON_ApproachTarget, f13_local3, TARGET_ENE_0, f13_local1, TARGET_SELF, f13_local2, -1)
    end
    local f13_local4 = 3017
    local f13_local5 = 999
    local f13_local6 = 0
    local f13_local7 = 0
    f13_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 10, f13_local4, TARGET_ENE_0, f13_local5, f13_local6, f13_local7, 0, 0)
    f13_arg0:SetNumber(2, 10)
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
    
end

Goal.Act11 = function (f14_arg0, f14_arg1, f14_arg2)
    local f14_local0 = f14_arg0:GetDist(TARGET_ENE_0)
    local f14_local1 = 6.5 - f14_arg0:GetMapHitRadius(TARGET_SELF)
    local f14_local2 = false
    local f14_local3 = 3
    if f14_arg0:GetNumber(2) == 0 then
        f14_local2 = true
        f14_local3 = 5
    end
    if f14_local1 < f14_local0 then
        f14_arg1:AddSubGoal(GOAL_COMMON_ApproachTarget, f14_local3, TARGET_ENE_0, f14_local1, TARGET_SELF, f14_local2, -1)
    end
    local f14_local4 = 3018
    local f14_local5 = 999
    local f14_local6 = 0
    local f14_local7 = 0
    f14_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 10, f14_local4, TARGET_ENE_0, f14_local5, f14_local6, f14_local7, 0, 0)
    f14_arg0:SetNumber(2, 11)
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
    
end

Goal.Act12 = function (f15_arg0, f15_arg1, f15_arg2)
    local f15_local0 = f15_arg0:GetDist(TARGET_ENE_0)
    local f15_local1 = 5.8 - f15_arg0:GetMapHitRadius(TARGET_SELF)
    local f15_local2 = false
    local f15_local3 = 3
    if f15_arg0:GetNumber(2) == 0 then
        f15_local2 = true
        f15_local3 = 5
    end
    if f15_local1 < f15_local0 then
        f15_arg1:AddSubGoal(GOAL_COMMON_ApproachTarget, f15_local3, TARGET_ENE_0, f15_local1, TARGET_SELF, f15_local2, -1)
    end
    local f15_local4 = 3019
    local f15_local5 = 3020
    local f15_local6 = 5.8 - f15_arg0:GetMapHitRadius(TARGET_SELF)
    local f15_local7 = 9999
    local f15_local8 = 0
    local f15_local9 = 0
    f15_arg1:AddSubGoal(GOAL_COMMON_ComboAttackTunableSpin, 10, f15_local4, TARGET_ENE_0, f15_local6, f15_local8, f15_local9, 0, 0)
    f15_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, f15_local5, TARGET_ENE_0, f15_local7, 0, 0)
    f15_arg0:SetNumber(2, 12)
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
    
end

Goal.Act13 = function (f16_arg0, f16_arg1, f16_arg2)
    local f16_local0 = f16_arg0:GetDist(TARGET_ENE_0)
    local f16_local1 = 4 - f16_arg0:GetMapHitRadius(TARGET_SELF)
    local f16_local2 = false
    local f16_local3 = 3
    if f16_arg0:GetNumber(2) == 0 then
        f16_local2 = true
        f16_local3 = 5
    end
    if f16_local1 + 1 < f16_local0 then
        f16_local1 = f16_local1 + 1
    end
    if f16_local1 < f16_local0 then
        f16_arg1:AddSubGoal(GOAL_COMMON_ApproachTarget, f16_local3, TARGET_ENE_0, f16_local1, TARGET_SELF, f16_local2, -1)
    end
    local f16_local4 = 3022
    local f16_local5 = 9999
    local f16_local6 = 0
    local f16_local7 = 0
    f16_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 10, f16_local4, TARGET_ENE_0, f16_local5, f16_local6, f16_local7, 0, 0)
    f16_arg0:SetNumber(2, 13)
    f16_arg0:SetNumber(5, 1)
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
    
end

Goal.Act14 = function (f17_arg0, f17_arg1, f17_arg2)
    local f17_local0 = f17_arg0:GetDist(TARGET_ENE_0)
    local f17_local1 = 11 - f17_arg0:GetMapHitRadius(TARGET_SELF)
    local f17_local2 = false
    local f17_local3 = 1
    local f17_local4 = f17_arg0:GetEventRequest()
    local f17_local5 = f17_arg0:GetNinsatsuMaxNum()
    local f17_local6 = f17_arg0:GetNinsatsuNum()
    local f17_local7 = false
    if f17_local6 < f17_local5 then
        f17_local7 = true
    end
    local f17_local8 = f17_arg0:HasSpecialEffectId(TARGET_SELF, 200031)
    if f17_arg0:GetNumber(2) == 0 then
        f17_local2 = true
        f17_local3 = 5
    end
    if f17_local1 + 1 < f17_local0 then
        f17_local1 = f17_local1 + 1
    end
    if f17_local1 < f17_local0 then
        f17_arg1:AddSubGoal(GOAL_COMMON_ApproachTarget, f17_local3, TARGET_ENE_0, f17_local1, TARGET_SELF, f17_local2, -1)
    end
    local f17_local9 = 3023
    local f17_local10 = 9999
    local f17_local11 = 0
    local f17_local12 = 0
    if f17_local8 then
        f17_local9 = 3038
    end
    f17_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 10, f17_local9, TARGET_ENE_0, f17_local10, f17_local11, f17_local12, 0, 0)
    f17_arg0:SetNumber(2, 14)
    f17_arg0:SetNumber(5, 1)
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
    
end

Goal.Act15 = function (f18_arg0, f18_arg1, f18_arg2)
    local f18_local0 = f18_arg0:GetDist(TARGET_ENE_0)
    local f18_local1 = 999 - f18_arg0:GetMapHitRadius(TARGET_SELF)
    local f18_local2 = false
    local f18_local3 = 3
    if f18_local1 < f18_local0 then
        f18_arg1:AddSubGoal(GOAL_COMMON_ApproachTarget, f18_local3, TARGET_ENE_0, f18_local1, TARGET_SELF, f18_local2, -1)
    end
    local f18_local4 = 3030
    local f18_local5 = 999
    local f18_local6 = 0
    local f18_local7 = 0
    f18_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 10, f18_local4, TARGET_ENE_0, f18_local5, f18_local6, f18_local7, 0, 0)
    f18_arg0:SetNumber(2, 15)
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
    
end

Goal.Act16 = function (f19_arg0, f19_arg1, f19_arg2)
    local f19_local0 = f19_arg0:GetDist(TARGET_ENE_0)
    local f19_local1 = 999 - f19_arg0:GetMapHitRadius(TARGET_SELF)
    local f19_local2 = false
    local f19_local3 = 3
    local f19_local4 = f19_arg0:GetRandam_Int(1, 100)
    local f19_local5 = f19_arg0:GetEventRequest()
    local f19_local6 = f19_arg0:GetNinsatsuMaxNum()
    local f19_local7 = f19_arg0:GetNinsatsuNum()
    local f19_local8 = false
    if f19_local7 < f19_local6 then
        f19_local8 = true
    end
    local f19_local9 = f19_arg0:HasSpecialEffectId(TARGET_SELF, 200031)
    f19_arg0:AddObserveSpecialEffectAttribute(TARGET_SELF, 5028)
    if f19_local0 < 2 and f19_arg0:IsExistMeshOnLine(TARGET_SELF, AI_DIR_TYPE_B, 2) and not f19_local9 then
        f19_arg1:AddSubGoal(GOAL_COMMON_SpinStep, 3, 5210, TARGET_ENE_0, 0, AI_DIR_TYPE_B, 0)
    elseif f19_local0 < 5 and f19_arg0:IsExistMeshOnLine(TARGET_SELF, AI_DIR_TYPE_B, 2) and not f19_local9 then
        f19_arg1:AddSubGoal(GOAL_COMMON_SpinStep, 3, 5201, TARGET_ENE_0, 0, AI_DIR_TYPE_B, 0)
    end
    local f19_local10 = 3031
    local f19_local11 = 999
    local f19_local12 = 0
    local f19_local13 = 0
    f19_arg1:AddSubGoal(GOAL_COMMON_ComboTunable_SuccessAngle180, 10, 3032, TARGET_ENE_0, 999, f19_local12, f19_local13, 0, 0):TimingSetTimer(0, 70, AI_TIMING_SET__UPDATE_SUCCESS)
    f19_arg1:AddSubGoal(GOAL_COMMON_ComboRepeat_SuccessAngle180, 10, 3033, TARGET_ENE_0, 999, 0, 0)
    f19_arg1:AddSubGoal(GOAL_COMMON_ComboRepeat_SuccessAngle180, 10, 3033, TARGET_ENE_0, 999, 0, 0)
    f19_arg1:AddSubGoal(GOAL_COMMON_ComboRepeat_SuccessAngle180, 10, 3033, TARGET_ENE_0, 999, 0, 0)
    f19_arg1:AddSubGoal(GOAL_COMMON_ComboRepeat_SuccessAngle180, 10, 3033, TARGET_ENE_0, 999, 0, 0)
    f19_arg1:AddSubGoal(GOAL_COMMON_ComboRepeat_SuccessAngle180, 10, 3033, TARGET_ENE_0, 999, 0, 0)
    f19_arg1:AddSubGoal(GOAL_COMMON_ComboRepeat_SuccessAngle180, 10, 3033, TARGET_ENE_0, 999, 0, 0)
    f19_arg1:AddSubGoal(GOAL_COMMON_ComboRepeat_SuccessAngle180, 10, 3033, TARGET_ENE_0, 999, 0, 0)
    f19_arg1:AddSubGoal(GOAL_COMMON_ComboRepeat_SuccessAngle180, 10, 3033, TARGET_ENE_0, 999, 0, 0)
    f19_arg1:AddSubGoal(GOAL_COMMON_ComboRepeat_SuccessAngle180, 10, 3033, TARGET_ENE_0, 999, 0, 0)
    f19_arg1:AddSubGoal(GOAL_COMMON_ComboRepeat_SuccessAngle180, 10, 3033, TARGET_ENE_0, 999, 0, 0)
    f19_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3034, TARGET_ENE_0, 999, 0, 0)
    f19_arg0:SetNumber(2, 16)
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
    
end

Goal.Act17 = function (f20_arg0, f20_arg1, f20_arg2)
    local f20_local0 = f20_arg0:GetDist(TARGET_ENE_0)
    local f20_local1 = 6 - f20_arg0:GetMapHitRadius(TARGET_SELF)
    local f20_local2 = false
    local f20_local3 = 2.5
    if f20_arg0:GetNumber(2) == 0 then
        f20_local2 = true
        f20_local3 = 5
    end
    if f20_local1 < f20_local0 then
        f20_arg1:AddSubGoal(GOAL_COMMON_ApproachTarget, f20_local3, TARGET_ENE_0, f20_local1, TARGET_SELF, f20_local2, -1)
    end
    local f20_local4 = 3024
    local f20_local5 = 999
    local f20_local6 = 0
    local f20_local7 = 0
    f20_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 10, f20_local4, TARGET_ENE_0, f20_local5, f20_local6, f20_local7, 0, 0)
    f20_arg0:SetNumber(2, 17)
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
    
end

Goal.Act18 = function (f21_arg0, f21_arg1, f21_arg2)
    local f21_local0 = f21_arg0:GetDist(TARGET_ENE_0)
    local f21_local1 = 6 - f21_arg0:GetMapHitRadius(TARGET_SELF)
    local f21_local2 = false
    local f21_local3 = 1
    if f21_arg0:GetNumber(2) == 0 then
        f21_local2 = true
        f21_local3 = 5
    end
    if f21_local1 < f21_local0 then
        f21_arg1:AddSubGoal(GOAL_COMMON_ApproachTarget, f21_local3, TARGET_ENE_0, f21_local1, TARGET_SELF, f21_local2, -1)
    end
    local f21_local4 = 3025
    local f21_local5 = 999
    local f21_local6 = 0
    local f21_local7 = 0
    f21_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 10, f21_local4, TARGET_ENE_0, f21_local5, f21_local6, f21_local7, 0, 0)
    f21_arg0:SetNumber(2, 18)
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
    
end

Goal.Act19 = function (f22_arg0, f22_arg1, f22_arg2)
    local f22_local0 = f22_arg0:GetDist(TARGET_ENE_0)
    local f22_local1 = 12 - f22_arg0:GetMapHitRadius(TARGET_SELF)
    local f22_local2 = false
    local f22_local3 = 1
    if f22_arg0:GetNumber(2) == 0 then
        f22_local2 = true
        f22_local3 = 5
    end
    if f22_local1 < f22_local0 then
        f22_arg1:AddSubGoal(GOAL_COMMON_ApproachTarget, f22_local3, TARGET_ENE_0, f22_local1, TARGET_SELF, f22_local2, -1)
    end
    local f22_local4 = 3026
    local f22_local5 = 999
    local f22_local6 = 0
    local f22_local7 = 0
    f22_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 10, f22_local4, TARGET_ENE_0, f22_local5, f22_local6, f22_local7, 0, 0)
    f22_arg0:SetNumber(2, 19)
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
    
end

Goal.Act20 = function (f23_arg0, f23_arg1, f23_arg2)
    local f23_local0 = f23_arg0:GetDist(TARGET_ENE_0)
    local f23_local1 = 8 - f23_arg0:GetMapHitRadius(TARGET_SELF) + 2.5
    local f23_local2 = false
    local f23_local3 = 1
    if f23_local1 < f23_local0 then
        f23_arg1:AddSubGoal(GOAL_COMMON_ApproachTarget, f23_local3, TARGET_ENE_0, f23_local1, TARGET_SELF, f23_local2, -1)
    end
    local f23_local4 = 3027
    local f23_local5 = 999
    local f23_local6 = 0
    local f23_local7 = 0
    f23_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 10, f23_local4, TARGET_ENE_0, f23_local5, f23_local6, f23_local7, 0, 0)
    f23_arg0:SetNumber(2, 20)
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
    
end

Goal.Act21 = function (f24_arg0, f24_arg1, f24_arg2)
    local f24_local0 = f24_arg0:GetDist(TARGET_ENE_0)
    local f24_local1 = 1 - f24_arg0:GetMapHitRadius(TARGET_SELF)
    local f24_local2 = false
    local f24_local3 = 1
    if f24_local1 < f24_local0 then
    end
    local f24_local4 = 3028
    local f24_local5 = 3029
    local f24_local6 = 0 - f24_arg0:GetMapHitRadius(TARGET_SELF)
    local f24_local7 = 9999
    local f24_local8 = 0
    local f24_local9 = 0
    f24_arg1:AddSubGoal(GOAL_COMMON_ComboAttackTunableSpin, 10, f24_local4, TARGET_ENE_0, f24_local6, f24_local8, f24_local9, 0, 0)
    f24_arg0:SetNumber(2, 21)
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
    
end

Goal.Act22 = function (f25_arg0, f25_arg1, f25_arg2)
    local f25_local0 = f25_arg0:GetDist(TARGET_ENE_0)
    local f25_local1 = 5.6 - f25_arg0:GetMapHitRadius(TARGET_SELF)
    local f25_local2 = false
    local f25_local3 = 3
    if f25_arg0:GetNumber(2) == 0 then
        f25_local2 = true
        f25_local3 = 5
    end
    local f25_local4 = f25_arg0:GetRandam_Int(1, 100)
    local f25_local5 = f25_arg0:GetRandam_Int(1, 100)
    if f25_local1 < f25_local0 then
        f25_arg1:AddSubGoal(GOAL_COMMON_ApproachTarget, f25_local3, TARGET_ENE_0, f25_local1, TARGET_SELF, f25_local2, -1)
    end
    local f25_local6 = 3035
    local f25_local7 = 3036
    local f25_local8 = 3037
    local f25_local9 = 9999
    local f25_local10 = 9999
    local f25_local11 = 9999
    local f25_local12 = 0
    local f25_local13 = 0
    f25_arg1:AddSubGoal(GOAL_COMMON_ComboTunable_SuccessAngle180, 15, f25_local6, TARGET_ENE_0, f25_local9, f25_local12, f25_local13, 0, 0):TimingSetTimer(2, 50, AI_TIMING_SET__UPDATE_SUCCESS)
    f25_arg1:AddSubGoal(GOAL_COMMON_ComboRepeat_SuccessAngle180, 10, f25_local7, TARGET_ENE_0, f25_local10, 0, 0)
    f25_arg1:AddSubGoal(GOAL_COMMON_ComboRepeat_SuccessAngle180, 10, f25_local7, TARGET_ENE_0, f25_local10, 0, 0)
    f25_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, f25_local8, TARGET_ENE_0, f25_local11, 0, 0)
    f25_arg0:SetNumber(2, 22)
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
    
end

Goal.Act23 = function (f26_arg0, f26_arg1, f26_arg2)
    local f26_local0 = f26_arg0:GetDist(TARGET_ENE_0)
    local f26_local1 = 14.5 - f26_arg0:GetMapHitRadius(TARGET_SELF)
    local f26_local2 = false
    local f26_local3 = 3
    if f26_arg0:GetNumber(2) == 0 then
        f26_local2 = true
        f26_local3 = 5
    end
    if f26_local1 + 1 < f26_local0 then
        f26_local1 = f26_local1 + 1
    end
    if f26_local1 < f26_local0 then
        f26_arg1:AddSubGoal(GOAL_COMMON_ApproachTarget, f26_local3, TARGET_ENE_0, f26_local1, TARGET_SELF, f26_local2, -1)
    end
    local f26_local4 = 3038
    local f26_local5 = 9999
    local f26_local6 = 0
    local f26_local7 = 0
    f26_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 10, f26_local4, TARGET_ENE_0, f26_local5, f26_local6, f26_local7, 0, 0)
    f26_arg0:SetNumber(2, 23)
    f26_arg0:SetNumber(5, 1)
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
    
end

Goal.Act24 = function (f27_arg0, f27_arg1, f27_arg2)
    local f27_local0 = f27_arg0:GetDist(TARGET_ENE_0)
    local f27_local1 = 15.7 - f27_arg0:GetMapHitRadius(TARGET_SELF)
    local f27_local2 = false
    local f27_local3 = 3
    if f27_local1 + 1 < f27_local0 then
        f27_local1 = f27_local1 + 1
    end
    if f27_local1 < f27_local0 then
        f27_arg1:AddSubGoal(GOAL_COMMON_ApproachTarget, f27_local3, TARGET_ENE_0, f27_local1, TARGET_SELF, f27_local2, -1)
    end
    local f27_local4 = 3039
    local f27_local5 = 9999
    local f27_local6 = 0
    local f27_local7 = 0
    f27_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 10, f27_local4, TARGET_ENE_0, f27_local5, f27_local6, f27_local7, 0, 0)
    f27_arg0:SetNumber(2, 24)
    f27_arg0:SetNumber(5, 1)
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
    
end

Goal.Act25 = function (f28_arg0, f28_arg1, f28_arg2)
    local f28_local0 = 3034
    local f28_local1 = 999
    local f28_local2 = 0
    local f28_local3 = 0
    f28_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, f28_local0, TARGET_ENE_0, f28_local1, 0, 0)
    f28_arg0:SetNumber(2, 25)
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
    
end

Goal.Act26 = function (f29_arg0, f29_arg1, f29_arg2)
    local f29_local0 = 3040
    local f29_local1 = 0
    local f29_local2 = 0
    f29_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, f29_local0, TARGET_ENE_0, 999, 0, 0)
    f29_arg0:SetNumber(2, 26)
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
    
end

Goal.Act27 = function (f30_arg0, f30_arg1, f30_arg2)
    local f30_local0 = f30_arg0:GetDist(TARGET_ENE_0)
    local f30_local1 = 17.9 - f30_arg0:GetMapHitRadius(TARGET_SELF)
    local f30_local2 = true
    local f30_local3 = 5
    local f30_local4 = 3001
    local f30_local5 = 3004
    local f30_local6 = 3006
    local f30_local7 = 0
    local f30_local8 = 0
    local f30_local9 = f30_arg0:HasSpecialEffectId(TARGET_SELF, 200031)
    if IsHU2 then
        f30_local6 = 3005
    end
    if f30_local0 >= 10 then
        f30_local1 = 17.9 - f30_arg0:GetMapHitRadius(TARGET_SELF)
        f30_local4 = 3001
        f30_arg0:AddObserveArea(1, TARGET_SELF, TARGET_ENE_0, AI_DIR_TYPE_F, 360, 5)
    elseif f30_local0 >= 5 then
        f30_local1 = 11 - f30_arg0:GetMapHitRadius(TARGET_SELF)
        f30_local4 = 3023
    else
        f30_local1 = 5.6 - f30_arg0:GetMapHitRadius(TARGET_SELF)
        f30_local4 = 3003
    end
    if f30_local1 + 1 < f30_local0 then
        f30_local1 = f30_local1 + 1
    end
    f30_arg1:AddSubGoal(GOAL_COMMON_ApproachTarget, f30_local3, TARGET_ENE_0, f30_local1, TARGET_SELF, f30_local2, -1):SetLifeEndSuccess(true):TimingSetNumber(3, 1, AI_TIMING_SET__UPDATE_SUCCESS)
    f30_arg1:AddSubGoal(GOAL_COMMON_ApproachTarget, 0.1, TARGET_ENE_0, f30_local1, TARGET_SELF, f30_local2, -1)
    f30_arg1:AddSubGoal(GOAL_COMMON_ComboAttackTunableSpin, 10, f30_local4, TARGET_ENE_0, 9999, f30_local7, f30_local8, 0, 0)
    if f30_local0 < 5 then
        f30_arg1:AddSubGoal(GOAL_COMMON_ComboRepeat_SuccessAngle180, 10, f30_local5, TARGET_ENE_0, 9999, 0, 0)
        f30_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, f30_local6, TARGET_ENE_0, 9999, 0, 0)
    end
    f30_arg0:SetNumber(2, 27)
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
    
end

Goal.Act28 = function (f31_arg0, f31_arg1, f31_arg2)
    local f31_local0 = f31_arg0:GetDist(TARGET_ENE_0)
    local f31_local1 = 1
    local f31_local2 = false
    local f31_local3 = 1
    if f31_arg0:GetNumber(2) == 0 then
        f31_local2 = true
        f31_local3 = 5
    end
    if f31_local1 < f31_local0 then
        f31_arg1:AddSubGoal(GOAL_COMMON_ApproachTarget, f31_local3, POINT_UnreachTerminate, f31_local1, TARGET_SELF, f31_local2, -1)
    end
    local f31_local4 = 3024
    local f31_local5 = 999
    local f31_local6 = 0
    local f31_local7 = 0
    f31_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 10, f31_local4, TARGET_ENE_0, f31_local5, f31_local6, f31_local7, 0, 0)
    f31_arg0:SetNumber(2, 17)
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
    
end

Goal.Act30 = function (f32_arg0, f32_arg1, f32_arg2)
    local f32_local0 = f32_arg0:GetDist(TARGET_ENE_0)
    local f32_local1 = 1.2
    local f32_local2 = false
    local f32_local3 = 1
    local f32_local4 = f32_arg0:GetEventRequest()
    local f32_local5 = f32_arg0:GetNinsatsuMaxNum()
    local f32_local6 = f32_arg0:GetNinsatsuNum()
    local f32_local7 = false
    if f32_local6 < f32_local5 then
        f32_local7 = true
    end
    local f32_local8 = f32_arg0:HasSpecialEffectId(TARGET_SELF, 200031)
    if f32_arg0:GetNumber(2) == 0 then
        f32_local2 = true
        f32_local3 = 5
    end
    local f32_local9 = 2
    local f32_local10 = f32_arg0:GetRandam_Int(1, 100)
    f32_arg1:AddSubGoal(GOAL_COMMON_ApproachTarget, f32_local3, TARGET_ENE_0, f32_local1, TARGET_SELF, f32_local2, -1)
    if f32_local8 then
        f32_local9 = f32_arg0:GetRandam_Int(3, 6)
    elseif f32_local7 then
        f32_local9 = f32_arg0:GetRandam_Int(1, 2)
    else
        f32_local9 = f32_arg0:GetRandam_Int(1, 2)
    end
    local f32_local11 = 3003
    local f32_local12 = 3004
    local f32_local13 = 3005
    local f32_local14 = 5.9 - f32_arg0:GetMapHitRadius(TARGET_SELF)
    local f32_local15 = 8.5 - f32_arg0:GetMapHitRadius(TARGET_SELF)
    local f32_local16 = 9999
    local f32_local17 = 0
    local f32_local18 = 0
    if f32_local9 == 1 then
        f32_local12 = 3004
        f32_local13 = 3006
        f32_local14 = 5.9 - f32_arg0:GetMapHitRadius(TARGET_SELF)
        f32_local15 = 7 - f32_arg0:GetMapHitRadius(TARGET_SELF)
    elseif f32_local9 == 2 then
        f32_local12 = 3004
        f32_local13 = 3005
        f32_local14 = 5.9 - f32_arg0:GetMapHitRadius(TARGET_SELF)
        f32_local15 = 8.5 - f32_arg0:GetMapHitRadius(TARGET_SELF)
    elseif f32_local9 == 3 then
        f32_local12 = 3007
        f32_local13 = 3008
        f32_local14 = 7.3 - f32_arg0:GetMapHitRadius(TARGET_SELF)
        f32_local15 = 6.2 - f32_arg0:GetMapHitRadius(TARGET_SELF)
    elseif f32_local9 == 4 then
        f32_local12 = 3004
        f32_local13 = 3040
        f32_local14 = 5.9 - f32_arg0:GetMapHitRadius(TARGET_SELF)
        f32_local15 = 8.5 - f32_arg0:GetMapHitRadius(TARGET_SELF)
    elseif f32_local9 == 5 then
        f32_local12 = 3007
        f32_local13 = 3040
        f32_local14 = 7.3 - f32_arg0:GetMapHitRadius(TARGET_SELF)
        f32_local15 = 6.2 - f32_arg0:GetMapHitRadius(TARGET_SELF)
    else
        f32_local12 = 3004
        f32_local13 = 3005
        f32_local14 = 5.9 - f32_arg0:GetMapHitRadius(TARGET_SELF)
        f32_local15 = 8.5 - f32_arg0:GetMapHitRadius(TARGET_SELF)
    end
    f32_arg1:AddSubGoal(GOAL_COMMON_ComboTunable_SuccessAngle180, 10, f32_local11, TARGET_ENE_0, 9999, f32_local17, f32_local18, 0, 0)
    f32_arg1:AddSubGoal(GOAL_COMMON_ComboRepeat_SuccessAngle180, 10, f32_local12, TARGET_ENE_0, 9999, 0, 0)
    f32_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, f32_local13, TARGET_ENE_0, 9999, 0, 0)
    f32_arg0:SetNumber(2, 3)
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
    
end

Goal.Act31 = function (f33_arg0, f33_arg1, f33_arg2)
    local f33_local0 = f33_arg0:GetDist(TARGET_ENE_0)
    local f33_local1 = 5.6 - f33_arg0:GetMapHitRadius(TARGET_SELF)
    local f33_local2 = false
    local f33_local3 = 1
    local f33_local4 = f33_arg0:GetEventRequest()
    local f33_local5 = f33_arg0:GetNinsatsuMaxNum()
    local f33_local6 = f33_arg0:GetNinsatsuNum()
    local f33_local7 = false
    if f33_local6 < f33_local5 then
        f33_local7 = true
    end
    local f33_local8 = f33_arg0:HasSpecialEffectId(TARGET_SELF, 200031)
    if f33_arg0:GetNumber(2) == 0 then
        f33_local2 = true
        f33_local3 = 5
    end
    local f33_local9 = TARGET_ENE_0
    if f33_arg0:CheckDoesExistPathWithSetPoint(TARGET_ENE_0, AI_DIR_TYPE_F, 0, 0) == false then
        f33_local9 = POINT_UnreachTerminate
        f33_local1 = 0.3
    end
    local f33_local10 = 2
    local f33_local11 = f33_arg0:GetRandam_Int(1, 100)
    f33_arg1:AddSubGoal(GOAL_COMMON_ApproachTarget, f33_local3, f33_local9, f33_local1, TARGET_SELF, f33_local2, -1)
    if f33_local8 then
        f33_local10 = f33_arg0:GetRandam_Int(3, 6)
    elseif f33_local7 then
        f33_local10 = f33_arg0:GetRandam_Int(1, 2)
    else
        f33_local10 = f33_arg0:GetRandam_Int(1, 2)
    end
    local f33_local12 = 3003
    local f33_local13 = 3004
    local f33_local14 = 3005
    local f33_local15 = 5.9 - f33_arg0:GetMapHitRadius(TARGET_SELF)
    local f33_local16 = 8.5 - f33_arg0:GetMapHitRadius(TARGET_SELF)
    local f33_local17 = 9999
    local f33_local18 = 0
    local f33_local19 = 0
    if f33_local10 == 1 then
        f33_local13 = 3004
        f33_local14 = 3006
        f33_local15 = 5.9 - f33_arg0:GetMapHitRadius(TARGET_SELF)
        f33_local16 = 7 - f33_arg0:GetMapHitRadius(TARGET_SELF)
    elseif f33_local10 == 2 then
        f33_local13 = 3004
        f33_local14 = 3005
        f33_local15 = 5.9 - f33_arg0:GetMapHitRadius(TARGET_SELF)
        f33_local16 = 8.5 - f33_arg0:GetMapHitRadius(TARGET_SELF)
    elseif f33_local10 == 3 then
        f33_local13 = 3007
        f33_local14 = 3008
        f33_local15 = 7.3 - f33_arg0:GetMapHitRadius(TARGET_SELF)
        f33_local16 = 6.2 - f33_arg0:GetMapHitRadius(TARGET_SELF)
    elseif f33_local10 == 4 then
        f33_local13 = 3004
        f33_local14 = 3040
        f33_local15 = 5.9 - f33_arg0:GetMapHitRadius(TARGET_SELF)
        f33_local16 = 8.5 - f33_arg0:GetMapHitRadius(TARGET_SELF)
    elseif f33_local10 == 5 then
        f33_local13 = 3007
        f33_local14 = 3040
        f33_local15 = 7.3 - f33_arg0:GetMapHitRadius(TARGET_SELF)
        f33_local16 = 6.2 - f33_arg0:GetMapHitRadius(TARGET_SELF)
    else
        f33_local13 = 3004
        f33_local14 = 3005
        f33_local15 = 5.9 - f33_arg0:GetMapHitRadius(TARGET_SELF)
        f33_local16 = 8.5 - f33_arg0:GetMapHitRadius(TARGET_SELF)
    end
    f33_arg1:AddSubGoal(GOAL_COMMON_ComboTunable_SuccessAngle180, 10, f33_local12, TARGET_ENE_0, 9999, f33_local18, f33_local19, 0, 0)
    f33_arg1:AddSubGoal(GOAL_COMMON_ComboRepeat_SuccessAngle180, 10, f33_local13, TARGET_ENE_0, 9999, 0, 0)
    f33_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, f33_local14, TARGET_ENE_0, 9999, 0, 0)
    f33_arg0:SetNumber(2, 3)
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
    
end

Goal.Act39 = function (f34_arg0, f34_arg1, f34_arg2)
    local f34_local0 = f34_arg0:GetDist(TARGET_ENE_0)
    local f34_local1 = f34_arg0:GetRandam_Int(1, 100)
    local f34_local2 = 8
    local f34_local3 = 5
    local f34_local4 = f34_arg0:GetRandam_Float(2, 4)
    local f34_local5 = f34_arg0:GetRandam_Int(30, 45)
    local f34_local6 = f34_arg0:GetRandam_Float(3, 5)
    if f34_local0 >= 8 then
        f34_arg1:AddSubGoal(GOAL_COMMON_ApproachTarget, f34_local4, TARGET_ENE_0, f34_local2, TARGET_ENE_0, true, -1)
    elseif f34_local0 <= 5 then
        f34_arg1:AddSubGoal(GOAL_COMMON_LeaveTarget, f34_local4, TARGET_ENE_0, f34_local3, TARGET_ENE_0, true, -1)
    end
    f34_arg1:AddSubGoal(GOAL_COMMON_SidewayMove, f34_local4, TARGET_ENE_0, f34_arg0:GetRandam_Int(0, 1), f34_local5, true, true, -1)
    if f34_local1 <= 60 then
        f34_arg1:AddSubGoal(GOAL_COMMON_Wait, f34_local6, TARGET_ENE_0, 0, 0, 0)
    end
    f34_arg0:SetNumber(2, 39)
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
    
end

Goal.Act40 = function (f35_arg0, f35_arg1, f35_arg2)
    local f35_local0 = f35_arg0:GetDist(TARGET_ENE_0)
    local f35_local1 = 999 - f35_arg0:GetMapHitRadius(TARGET_SELF)
    local f35_local2 = false
    local f35_local3 = 3
    local f35_local4 = f35_arg0:GetRandam_Int(1, 100)
    if f35_local0 < 2 and f35_arg0:IsExistMeshOnLine(TARGET_SELF, AI_DIR_TYPE_B, 2) then
        f35_arg1:AddSubGoal(GOAL_COMMON_SpinStep, 3, 5210, TARGET_ENE_0, 0, AI_DIR_TYPE_B, 0)
    elseif f35_local0 < 5 and f35_arg0:IsExistMeshOnLine(TARGET_SELF, AI_DIR_TYPE_B, 2) then
        f35_arg1:AddSubGoal(GOAL_COMMON_SpinStep, 3, 5201, TARGET_ENE_0, 0, AI_DIR_TYPE_B, 0)
    end
    local f35_local5 = 3030
    local f35_local6 = 999
    local f35_local7 = 0
    local f35_local8 = 0
    f35_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 10, f35_local5, TARGET_ENE_0, f35_local6, f35_local7, f35_local8, 0, 0)
    f35_arg0:SetNumber(2, 40)
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
    
end

Goal.Act41 = function (f36_arg0, f36_arg1, f36_arg2)
    local f36_local0 = 3
    local f36_local1 = 45
    f36_arg1:AddSubGoal(GOAL_COMMON_Turn, f36_local0, TARGET_ENE_0, f36_local1, -1, GOAL_RESULT_Success, true)
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
    
end

Goal.Act42 = function (f37_arg0, f37_arg1, f37_arg2)
    local f37_local0 = 3
    local f37_local1 = 0
    local f37_local2 = 3
    if InsideRange(f37_arg0, f37_arg1, 90, 180, -9999, 9999) and f37_arg0:IsExistMeshOnLine(TARGET_SELF, AI_DIR_TYPE_L, 2) or InsideRange(f37_arg0, f37_arg1, -90, 180, -9999, 9999) and not f37_arg0:IsExistMeshOnLine(TARGET_SELF, AI_DIR_TYPE_R, 2) then
        f37_arg1:AddSubGoal(GOAL_COMMON_SpinStep, f37_local0, 5202, TARGET_ENE_0, f37_local1, AI_DIR_TYPE_L, f37_local2)
    elseif InsideRange(f37_arg0, f37_arg1, -90, 180, -9999, 9999) and f37_arg0:IsExistMeshOnLine(TARGET_SELF, AI_DIR_TYPE_R, 2) or InsideRange(f37_arg0, f37_arg1, 90, 180, -9999, 9999) and not f37_arg0:IsExistMeshOnLine(TARGET_SELF, AI_DIR_TYPE_L, 2) then
        f37_arg1:AddSubGoal(GOAL_COMMON_SpinStep, f37_local0, 5203, TARGET_ENE_0, f37_local1, AI_DIR_TYPE_R, f37_local2)
    end
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
    
end

Goal.Act43 = function (f38_arg0, f38_arg1, f38_arg2)
    local f38_local0 = f38_arg0:GetRandam_Float(2, 2.5)
    local f38_local1 = f38_arg0:GetRandam_Int(30, 45)
    if InsideRange(f38_arg0, f38_arg1, 90, 180, -9999, 9999) then
        f38_arg1:AddSubGoal(GOAL_COMMON_SidewayMove, f38_local0, TARGET_ENE_0, 0, f38_local1, true, true, -1)
    elseif InsideRange(f38_arg0, f38_arg1, -90, 180, -9999, 9999) then
        f38_arg1:AddSubGoal(GOAL_COMMON_SidewayMove, f38_local0, TARGET_ENE_0, 1, f38_local1, true, true, -1)
    end
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
    
end

Goal.Act44 = function (f39_arg0, f39_arg1, f39_arg2)
    local f39_local0 = 3
    local f39_local1 = 0
    local f39_local2 = 3
    f39_arg1:AddSubGoal(GOAL_COMMON_SpinStep, f39_local0, 5201, TARGET_ENE_0, f39_local1, AI_DIR_TYPE_B, f39_local2)
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
    
end

Goal.Act45 = function (f40_arg0, f40_arg1, f40_arg2)
    local f40_local0 = f40_arg0:GetRandam_Float(3, 5)
    local f40_local1 = 5
    f40_arg1:AddSubGoal(GOAL_COMMON_LeaveTarget, f40_local0, TARGET_ENE_0, f40_local1, TARGET_ENE_0, true, -1)
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
    
end

Goal.Act46 = function (f41_arg0, f41_arg1, f41_arg2)
    local f41_local0 = f41_arg0:GetDist(TARGET_ENE_0)
    local f41_local1 = 5.9 - f41_arg0:GetMapHitRadius(TARGET_SELF)
    if f41_local1 < f41_local0 then
        f41_arg1:AddSubGoal(GOAL_COMMON_ApproachTarget, 3, TARGET_ENE_0, f41_local1, TARGET_SELF, false, -1)
    end
    f41_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 10, 3003, TARGET_ENE_0, 999, 0, 0, 0, 0)
    f41_arg0:SetNumber(11, 1)
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
    
end

Goal.Act47 = function (f42_arg0, f42_arg1, f42_arg2)
    local f42_local0 = f42_arg0:GetDist(TARGET_ENE_0)
    local f42_local1 = 8.5 - f42_arg0:GetMapHitRadius(TARGET_SELF)
    if f42_local1 < f42_local0 then
        f42_arg1:AddSubGoal(GOAL_COMMON_ApproachTarget, 3, TARGET_ENE_0, f42_local1, TARGET_SELF, false, -1)
    end
    f42_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 10, 3004, TARGET_ENE_0, 999, 0, 0, 0, 0)
    f42_arg0:SetNumber(11, 1)
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
    
end

Goal.Act48 = function (f43_arg0, f43_arg1, f43_arg2)
    local f43_local0 = f43_arg0:GetDist(TARGET_ENE_0)
    local f43_local1 = 3
    if f43_local1 < f43_local0 then
        f43_arg1:AddSubGoal(GOAL_COMMON_ApproachTarget, 3, TARGET_ENE_0, f43_local1, TARGET_SELF, false, -1)
    end
    f43_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 10, 3069, TARGET_ENE_0, 999, 0, 0, 0, 0)
    f43_arg0:SetNumber(11, 1)
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
    
end

Goal.Interrupt = function (f44_arg0, f44_arg1, f44_arg2)
    local f44_local0 = f44_arg1:GetSp(TARGET_SELF)
    local f44_local1 = f44_arg1:GetDist(TARGET_ENE_0)
    local f44_local2 = f44_arg1:GetEventRequest()
    local f44_local3 = f44_arg1:GetSpecialEffectActivateInterruptType(0)
    local f44_local4 = f44_arg1:GetNinsatsuMaxNum()
    local f44_local5 = f44_arg1:GetNinsatsuNum()
    local f44_local6 = false
    if f44_local5 < f44_local4 then
        f44_local6 = true
    end
    local f44_local7 = f44_arg1:HasSpecialEffectId(TARGET_SELF, 200031)
    if f44_arg1:IsLadderAct(TARGET_SELF) then
        return false
    end
    if f44_arg1:IsInterupt(INTERUPT_Inside_ObserveArea) and f44_arg1:IsInsideObserve(1) then
        f44_arg2:ClearSubGoal()
        f44_arg2:AddSubGoal(GOAL_COMMON_ComboRepeat, 1, 3021, TARGET_ENE_0, 8 - f44_arg1:GetMapHitRadius(TARGET_SELF), 0, 0)
        f44_arg2:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3002, TARGET_ENE_0, 999, 0, 0)
        f44_arg1:DeleteObserve(1)
        return true
    end
    if f44_arg1:IsInterupt(INTERUPT_ParryTiming) and not f44_arg1:HasSpecialEffectId(TARGET_SELF, 200031) then
        return Common_Parry(f44_arg1, f44_arg2, 50, 0)
    end
    if f44_arg1:IsInterupt(INTERUPT_Damaged) then
    end
    local f44_local8 = f44_arg1:GetRandam_Int(1, 100)
    local f44_local9 = f44_arg1:GetRandam_Int(1, 100)
    local f44_local10 = f44_arg1:GetRandam_Int(1, 100)
    if Interupt_PC_Break(f44_arg1) then
        f44_arg1:Replanning()
        return true
    end
    if f44_arg1:IsInterupt(INTERUPT_ActivateSpecialEffect) then
        if f44_arg1:GetSpecialEffectActivateInterruptType(0) == 5035 then
            f44_arg1:Replanning()
            f44_arg1:DeleteObserve(1)
            return true
        end
        if f44_arg1:GetSpecialEffectActivateInterruptType(0) == 5020 then
            f44_arg2:ClearSubGoal()
            f44_arg2:AddSubGoal(GOAL_COMMON_EndureAttack, 10, 3034, TARGET_ENE_0, 9999, 0)
            return true
        elseif f44_arg1:GetSpecialEffectActivateInterruptType(0) == 5021 then
            f44_arg2:ClearSubGoal()
            f44_arg2:AddSubGoal(GOAL_COMMON_EndureAttack, 10, 3038, TARGET_ENE_0, 9999, 0)
            return true
        end
        if f44_arg1:GetSpecialEffectActivateInterruptType(0) == 5027 then
            f44_arg1:SetNumber(1, 0)
            f44_arg1:SetNumber(5, 0)
        end
        if f44_arg1:GetSpecialEffectActivateInterruptType(0) == 110125 then
        end
        if f44_local3 == 3500051 and f44_arg1:HasSpecialEffectId(TARGET_SELF, 6023) == false then
            f44_arg2:ClearSubGoal()
            f44_arg2:AddSubGoal(GOAL_COMMON_EndureAttack, 10, 3028, TARGET_ENE_0, 9999, 0)
            return true
        end
        if f44_local3 == 107900 then
            f44_arg1:SetNumber(12, 1)
            f44_arg2:ClearSubGoal()
            f44_arg1:Replanning()
            return true
        end
        return false
    end
    if Interupt_Use_Item(f44_arg1, 4, 10) then
        if f44_arg1:HasSpecialEffectId(TARGET_SELF, 200031) then
            if f44_local1 <= 6 - f44_arg1:GetMapHitRadius(TARGET_SELF) then
                f44_arg2:ClearSubGoal()
                f44_arg2:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 1, 3009, TARGET_ENE_0, 9999, 0, 0, 0, 0)
                return true
            elseif f44_local1 <= 14.5 - f44_arg1:GetMapHitRadius(TARGET_SELF) then
                f44_arg2:ClearSubGoal()
                f44_arg2:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 1, 3038, TARGET_ENE_0, 9999, 0, 0, 0, 0)
                return true
            else
                f44_arg1:Replanning()
                return true
            end
        elseif f44_local1 <= 4 - f44_arg1:GetMapHitRadius(TARGET_SELF) then
            f44_arg2:ClearSubGoal()
            f44_arg2:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 1, 3022, TARGET_ENE_0, 9999, 0, 0, 0, 0)
            return true
        elseif f44_local1 <= 11 - f44_arg1:GetMapHitRadius(TARGET_SELF) then
            f44_arg2:ClearSubGoal()
            f44_arg2:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 1, 3023, TARGET_ENE_0, 9999, 0, 0, 0, 0)
            return true
        else
            f44_arg1:Replanning()
            return true
        end
    end
    return false
    
end

Goal.Damaged = function (f45_arg0, f45_arg1, f45_arg2)
    local f45_local0 = f45_arg0:GetHpRate(TARGET_SELF)
    local f45_local1 = f45_arg0:GetDist(TARGET_ENE_0)
    local f45_local2 = f45_arg0:GetSp(TARGET_SELF)
    local f45_local3 = f45_arg0:GetRandam_Int(1, 100)
    local f45_local4 = 0
    if f45_local3 <= 33 then
        f45_arg1:ClearSubGoal()
        f45_arg1:AddSubGoal(GOAL_COMMON_SpinStep, StepLife, 5201, TARGET_ENE_0, TurnTime, AI_DIR_TYPE_B, 0):TimingSetTimer(3, 6, UPDATE_SUCCESS)
        return true
    elseif f45_local3 <= 67 then
    end
    return false
    
end

Goal.Kengeki_Activate = function (f46_arg0, f46_arg1, f46_arg2, f46_arg3)
    local f46_local0 = ReturnKengekiSpecialEffect(f46_arg1)
    if f46_local0 == 0 then
        return false
    end
    local f46_local1 = {}
    local f46_local2 = {}
    local f46_local3 = {}
    Common_Clear_Param(f46_local1, f46_local2, f46_local3)
    local f46_local4 = f46_arg1:GetDist(TARGET_ENE_0)
    local f46_local5 = f46_arg1:GetSp(TARGET_SELF)
    local f46_local6 = f46_arg1:GetRandam_Int(1, 100)
    local f46_local7 = f46_arg1:GetEventRequest()
    local f46_local8 = f46_arg1:GetEventRequest(2)
    local f46_local9 = f46_arg1:GetNinsatsuMaxNum()
    local f46_local10 = f46_arg1:GetNinsatsuNum()
    local f46_local11 = false
    if f46_local10 < f46_local9 then
        f46_local11 = true
    end
    local f46_local12 = f46_arg1:HasSpecialEffectId(TARGET_SELF, 200031)
    if f46_local5 <= 0 then
        f46_local1[46] = 100
    elseif f46_local0 == 200200 then
        if f46_local4 >= 10 then
            f46_local1[46] = 100
        elseif f46_local4 <= 0.2 then
            f46_local1[46] = 100
        elseif f46_arg1:GetNumber(1) < f46_arg1:GetRandam_Int(1, 3) then
            if f46_arg1:GetNumber(0) == 0 then
                f46_local1[14] = 100
                f46_arg1:SetNumber(0, 1)
            else
                f46_local1[15] = 100
                f46_arg1:SetNumber(0, 0)
            end
            f46_arg1:SetNumber(1, f46_arg1:GetNumber(1) + 1)
        else
            if f46_local6 <= 80 and f46_local12 then
                f46_local1[17] = 100
            elseif f46_local6 <= 60 and f46_arg1:IsExistMeshOnLine(TARGET_SELF, AI_DIR_TYPE_B, 6) == true then
                f46_local1[16] = 100
            else
                f46_local1[18] = 100
            end
            f46_arg1:SetNumber(1, 0)
        end
    elseif f46_local0 == 200201 then
        if f46_local4 >= 10 then
            f46_local1[46] = 100
        elseif f46_local4 <= 0.2 then
            f46_local1[46] = 100
        elseif f46_arg1:GetNumber(1) < f46_arg1:GetRandam_Int(1, 3) then
            if f46_arg1:GetNumber(0) == 0 then
                f46_local1[9] = 100
                f46_arg1:SetNumber(0, 1)
            else
                f46_local1[10] = 100
                f46_arg1:SetNumber(0, 0)
            end
            f46_arg1:SetNumber(1, f46_arg1:GetNumber(1) + 1)
        else
            if f46_local6 <= 20 and f46_arg1:IsExistMeshOnLine(TARGET_SELF, AI_DIR_TYPE_B, 6) == true and f46_local4 < 2.5 then
                f46_local1[12] = 100
            elseif f46_local6 <= 70 and f46_local12 then
                f46_local1[30] = 100
            else
                f46_local1[13] = 100
                f46_local1[11] = 100
            end
            f46_arg1:SetNumber(1, 0)
        end
    elseif f46_local0 == 200205 then
        if f46_local4 >= 10 then
            f46_local1[46] = 100
        elseif f46_local4 <= 0.2 then
            f46_local1[46] = 100
        else
            if f46_arg1:GetNumber(0) == 0 then
                f46_local1[1] = 100
                f46_arg1:SetNumber(0, 1)
            else
                f46_local1[2] = 100
                f46_arg1:SetNumber(0, 0)
            end
            if f46_local12 then
                f46_local1[30] = 100
            end
        end
    elseif f46_local0 == 200206 then
        if f46_local4 >= 10 then
            f46_local1[46] = 100
        elseif f46_local4 <= 0.2 then
            f46_local1[46] = 100
        else
            if f46_arg1:GetNumber(0) == 0 then
                f46_local1[5] = 100
                f46_arg1:SetNumber(0, 1)
            else
                f46_local1[6] = 100
                f46_arg1:SetNumber(0, 0)
            end
            if f46_local12 then
                f46_local1[30] = 100
            end
        end
    elseif f46_local0 == 200210 then
        if f46_local4 >= 10 then
            f46_local1[46] = 100
        else
            f46_local1[13] = 150
            f46_local1[21] = 100
            if f46_local12 then
                f46_local1[30] = 50
            end
        end
    elseif f46_local0 == 200211 then
        if f46_local4 >= 10 then
            f46_local1[46] = 100
        else
            f46_local1[25] = 100
            f46_local1[1] = 100
            if f46_local12 then
                f46_local1[30] = 50
            end
        end
    elseif f46_local0 == 200215 then
        if f46_arg1:IsFinishTimer(0) == true and f46_local11 and f46_local8 ~= 1 then
            f46_local1[46] = 100
        elseif f46_local4 >= 10 then
            f46_local1[46] = 100
        elseif f46_local4 <= 0.2 then
            f46_local1[46] = 100
        else
            f46_local1[46] = 100
            if f46_arg1:GetNumber(1) < f46_arg1:GetRandam_Int(2, 2) then
                f46_local1[20] = 200
                f46_arg1:SetNumber(0, 1)
                f46_arg1:SetNumber(1, f46_arg1:GetNumber(1) + 1)
            else
                f46_local1[21] = 200
                f46_arg1:SetNumber(0, 0)
                f46_arg1:SetNumber(1, 0)
            end
        end
    elseif f46_local0 == 200216 then
        if f46_arg1:IsFinishTimer(0) == true and f46_local11 and f46_local8 ~= 1 then
            f46_local1[46] = 100
        elseif f46_local4 >= 10 then
            f46_local1[46] = 100
        elseif f46_local4 <= 0.2 then
            f46_local1[46] = 100
        else
            f46_local1[46] = 100
            if f46_arg1:GetNumber(1) < f46_arg1:GetRandam_Int(2, 2) then
                f46_local1[24] = 200
                f46_arg1:SetNumber(0, 1)
                f46_arg1:SetNumber(1, f46_arg1:GetNumber(1) + 1)
            else
                f46_local1[25] = 200
                f46_arg1:SetNumber(0, 0)
                f46_arg1:SetNumber(1, 0)
            end
        end
    end
    f46_local1[13] = SetCoolTime(f46_arg1, f46_arg2, 3064, 12, f46_local1[13], 1)
    f46_local1[21] = SetCoolTime(f46_arg1, f46_arg2, 3072, 12, f46_local1[21], 1)
    f46_local1[1] = SetCoolTime(f46_arg1, f46_arg2, 3050, 12, f46_local1[1], 1)
    f46_local1[25] = SetCoolTime(f46_arg1, f46_arg2, 3077, 12, f46_local1[25], 1)
    f46_local2[1] = REGIST_FUNC(f46_arg1, f46_arg2, f46_arg0.Kengeki01)
    f46_local2[2] = REGIST_FUNC(f46_arg1, f46_arg2, f46_arg0.Kengeki02)
    f46_local2[3] = REGIST_FUNC(f46_arg1, f46_arg2, f46_arg0.Kengeki03)
    f46_local2[4] = REGIST_FUNC(f46_arg1, f46_arg2, f46_arg0.Kengeki04)
    f46_local2[5] = REGIST_FUNC(f46_arg1, f46_arg2, f46_arg0.Kengeki05)
    f46_local2[6] = REGIST_FUNC(f46_arg1, f46_arg2, f46_arg0.Kengeki06)
    f46_local2[7] = REGIST_FUNC(f46_arg1, f46_arg2, f46_arg0.Kengeki07)
    f46_local2[8] = REGIST_FUNC(f46_arg1, f46_arg2, f46_arg0.Kengeki08)
    f46_local2[9] = REGIST_FUNC(f46_arg1, f46_arg2, f46_arg0.Kengeki09)
    f46_local2[10] = REGIST_FUNC(f46_arg1, f46_arg2, f46_arg0.Kengeki10)
    f46_local2[11] = REGIST_FUNC(f46_arg1, f46_arg2, f46_arg0.Kengeki11)
    f46_local2[12] = REGIST_FUNC(f46_arg1, f46_arg2, f46_arg0.Kengeki12)
    f46_local2[13] = REGIST_FUNC(f46_arg1, f46_arg2, f46_arg0.Kengeki13)
    f46_local2[14] = REGIST_FUNC(f46_arg1, f46_arg2, f46_arg0.Kengeki14)
    f46_local2[15] = REGIST_FUNC(f46_arg1, f46_arg2, f46_arg0.Kengeki15)
    f46_local2[16] = REGIST_FUNC(f46_arg1, f46_arg2, f46_arg0.Kengeki16)
    f46_local2[17] = REGIST_FUNC(f46_arg1, f46_arg2, f46_arg0.Kengeki17)
    f46_local2[18] = REGIST_FUNC(f46_arg1, f46_arg2, f46_arg0.Kengeki18)
    f46_local2[19] = REGIST_FUNC(f46_arg1, f46_arg2, f46_arg0.Kengeki19)
    f46_local2[20] = REGIST_FUNC(f46_arg1, f46_arg2, f46_arg0.Kengeki20)
    f46_local2[21] = REGIST_FUNC(f46_arg1, f46_arg2, f46_arg0.Kengeki21)
    f46_local2[22] = REGIST_FUNC(f46_arg1, f46_arg2, f46_arg0.Kengeki22)
    f46_local2[23] = REGIST_FUNC(f46_arg1, f46_arg2, f46_arg0.Kengeki23)
    f46_local2[24] = REGIST_FUNC(f46_arg1, f46_arg2, f46_arg0.Kengeki24)
    f46_local2[25] = REGIST_FUNC(f46_arg1, f46_arg2, f46_arg0.Kengeki25)
    f46_local2[26] = REGIST_FUNC(f46_arg1, f46_arg2, f46_arg0.Kengeki26)
    f46_local2[30] = REGIST_FUNC(f46_arg1, f46_arg2, f46_arg0.Kengeki30)
    f46_local2[41] = REGIST_FUNC(f46_arg1, f46_arg2, f46_arg0.Act41)
    f46_local2[42] = REGIST_FUNC(f46_arg1, f46_arg2, f46_arg0.Act42)
    f46_local2[43] = REGIST_FUNC(f46_arg1, f46_arg2, f46_arg0.Act43)
    f46_local2[44] = REGIST_FUNC(f46_arg1, f46_arg2, f46_arg0.Act44)
    f46_local2[45] = REGIST_FUNC(f46_arg1, f46_arg2, f46_arg0.Act45)
    f46_local2[46] = REGIST_FUNC(f46_arg1, f46_arg2, f46_arg0.NoAction)
    local f46_local13 = REGIST_FUNC(f46_arg1, f46_arg2, f46_arg0.ActAfter_AdjustSpace)
    return Common_Kengeki_Activate(f46_arg1, f46_arg2, f46_local1, f46_local2, f46_local13, f46_local3)
    
end

Goal.Kengeki01 = function (f47_arg0, f47_arg1, f47_arg2)
    f47_arg1:ClearSubGoal()
    f47_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 1, 3050, TARGET_ENE_0, 9999, 0, 0)
    
end

Goal.Kengeki02 = function (f48_arg0, f48_arg1, f48_arg2)
    f48_arg1:ClearSubGoal()
    f48_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 1, 3051, TARGET_ENE_0, 9999, 0, 0)
    
end

Goal.Kengeki03 = function (f49_arg0, f49_arg1, f49_arg2)
    f49_arg1:ClearSubGoal()
    f49_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 1, 3052, TARGET_ENE_0, 9999, 0, 0)
    
end

Goal.Kengeki04 = function (f50_arg0, f50_arg1, f50_arg2)
    f50_arg1:ClearSubGoal()
    f50_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 1, 3053, TARGET_ENE_0, 9999, 0, 0)
    
end

Goal.Kengeki05 = function (f51_arg0, f51_arg1, f51_arg2)
    f51_arg1:ClearSubGoal()
    f51_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 1, 3055, TARGET_ENE_0, 9999, 0, 0)
    
end

Goal.Kengeki06 = function (f52_arg0, f52_arg1, f52_arg2)
    f52_arg1:ClearSubGoal()
    f52_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 1, 3056, TARGET_ENE_0, 9999, 0, 0)
    
end

Goal.Kengeki07 = function (f53_arg0, f53_arg1, f53_arg2)
    f53_arg1:ClearSubGoal()
    f53_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 1, 3057, TARGET_ENE_0, 9999, 0, 0)
    
end

Goal.Kengeki08 = function (f54_arg0, f54_arg1, f54_arg2)
    f54_arg1:ClearSubGoal()
    f54_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 1, 3058, TARGET_ENE_0, 9999, 0, 0)
    
end

Goal.Kengeki09 = function (f55_arg0, f55_arg1, f55_arg2)
    f55_arg1:ClearSubGoal()
    f55_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 1, 3060, TARGET_ENE_0, 9999, 0, 0)
    
end

Goal.Kengeki10 = function (f56_arg0, f56_arg1, f56_arg2)
    f56_arg1:ClearSubGoal()
    f56_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 1, 3061, TARGET_ENE_0, 9999, 0, 0)
    
end

Goal.Kengeki11 = function (f57_arg0, f57_arg1, f57_arg2)
    f57_arg1:ClearSubGoal()
    f57_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 1, 3062, TARGET_ENE_0, 9999, 0, 0)
    
end

Goal.Kengeki12 = function (f58_arg0, f58_arg1, f58_arg2)
    f58_arg1:ClearSubGoal()
    f58_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 1, 3063, TARGET_ENE_0, 9999, 0, 0)
    
end

Goal.Kengeki13 = function (f59_arg0, f59_arg1, f59_arg2)
    f59_arg1:ClearSubGoal()
    f59_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 1, 3064, TARGET_ENE_0, 9999, 0, 0)
    
end

Goal.Kengeki14 = function (f60_arg0, f60_arg1, f60_arg2)
    f60_arg1:ClearSubGoal()
    f60_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 1, 3065, TARGET_ENE_0, 9999, 0, 0)
    
end

Goal.Kengeki15 = function (f61_arg0, f61_arg1, f61_arg2)
    f61_arg1:ClearSubGoal()
    f61_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 1, 3066, TARGET_ENE_0, 9999, 0, 0)
    
end

Goal.Kengeki16 = function (f62_arg0, f62_arg1, f62_arg2)
    f62_arg1:ClearSubGoal()
    f62_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 1, 3067, TARGET_ENE_0, 9999, 0, 0)
    
end

Goal.Kengeki17 = function (f63_arg0, f63_arg1, f63_arg2)
    f63_arg1:ClearSubGoal()
    f63_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 1, 3068, TARGET_ENE_0, 9999, 0, 0)
    
end

Goal.Kengeki18 = function (f64_arg0, f64_arg1, f64_arg2)
    f64_arg1:ClearSubGoal()
    f64_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 1, 3069, TARGET_ENE_0, 9999, 0, 0)
    
end

Goal.Kengeki19 = function (f65_arg0, f65_arg1, f65_arg2)
    f65_arg1:ClearSubGoal()
    f65_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 1, 3070, TARGET_ENE_0, 9999, 0, 0)
    
end

Goal.Kengeki20 = function (f66_arg0, f66_arg1, f66_arg2)
    f66_arg1:ClearSubGoal()
    f66_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 1, 3071, TARGET_ENE_0, 9999, 0, 0)
    
end

Goal.Kengeki21 = function (f67_arg0, f67_arg1, f67_arg2)
    f67_arg1:ClearSubGoal()
    f67_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 1, 3072, TARGET_ENE_0, 9999, 0, 0)
    
end

Goal.Kengeki22 = function (f68_arg0, f68_arg1, f68_arg2)
    f68_arg1:ClearSubGoal()
    f68_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 1, 3073, TARGET_ENE_0, 9999, 0, 0)
    
end

Goal.Kengeki23 = function (f69_arg0, f69_arg1, f69_arg2)
    f69_arg1:ClearSubGoal()
    f69_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 1, 3075, TARGET_ENE_0, 9999, 0, 0)
    
end

Goal.Kengeki24 = function (f70_arg0, f70_arg1, f70_arg2)
    f70_arg1:ClearSubGoal()
    f70_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 1, 3076, TARGET_ENE_0, 9999, 0, 0)
    
end

Goal.Kengeki25 = function (f71_arg0, f71_arg1, f71_arg2)
    f71_arg1:ClearSubGoal()
    f71_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 1, 3077, TARGET_ENE_0, 9999, 0, 0)
    
end

Goal.Kengeki26 = function (f72_arg0, f72_arg1, f72_arg2)
    f72_arg1:ClearSubGoal()
    f72_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 1, 3078, TARGET_ENE_0, 9999, 0, 0)
    
end

Goal.Kengeki30 = function (f73_arg0, f73_arg1, f73_arg2)
    f73_arg1:ClearSubGoal()
    f73_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 1, 3040, TARGET_ENE_0, 9999, 0, 0)
    
end

Goal.NoAction = function (f74_arg0, f74_arg1, f74_arg2)
    return -1
    
end

Goal.ActAfter_AdjustSpace = function (f75_arg0, f75_arg1, f75_arg2)
    
end

Goal.Update = function (f76_arg0, f76_arg1, f76_arg2)
    local f76_local0 = f76_arg1:GetSp(TARGET_SELF)
    if f76_local0 <= 0 then
        f76_arg1:SetEventFlag(19625862, true)
    else
        f76_arg1:SetEventFlag(19625862, false)
    end
    return Update_Default_NoSubGoal(f76_arg0, f76_arg1, f76_arg2)
    
end

Goal.Terminate = function (f77_arg0, f77_arg1, f77_arg2)
    
end


