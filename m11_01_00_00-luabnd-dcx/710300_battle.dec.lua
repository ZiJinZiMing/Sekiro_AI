RegisterTableGoal(GOAL_Rival_710300_Battle, "GOAL_Rival_710300_Battle")
REGISTER_GOAL_NO_UPDATE(GOAL_Rival_710300_Battle, true)

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
    local f2_local5 = f2_arg1:GetHpRate(TARGET_SELF)
    local f2_local6 = f2_arg1:GetSp(TARGET_SELF)
    local f2_local7 = f2_arg1:GetNinsatsuNum()
    f2_arg1:AddObserveSpecialEffectAttribute(TARGET_SELF, 5025)
    f2_arg1:AddObserveSpecialEffectAttribute(TARGET_SELF, 5026)
    f2_arg1:AddObserveSpecialEffectAttribute(TARGET_SELF, 5029)
    f2_arg1:AddObserveSpecialEffectAttribute(TARGET_SELF, 5030)
    f2_arg1:AddObserveSpecialEffectAttribute(TARGET_SELF, 5031)
    f2_arg1:AddObserveSpecialEffectAttribute(TARGET_SELF, 3710010)
    f2_arg1:AddObserveSpecialEffectAttribute(TARGET_SELF, 3710020)
    f2_arg1:AddObserveSpecialEffectAttribute(TARGET_SELF, 3710030)
    f2_arg1:AddObserveSpecialEffectAttribute(TARGET_SELF, 3710031)
    f2_arg1:AddObserveSpecialEffectAttribute(TARGET_ENE_0, 110010)
    f2_arg1:AddObserveSpecialEffectAttribute(TARGET_ENE_0, 3710050)
    f2_arg1:AddObserveSpecialEffectAttribute(TARGET_ENE_0, 110620)
    Set_ConsecutiveGuardCount_Interrupt(f2_arg1)
    f2_arg1:DeleteObserve(0)
    if f2_arg0.Kengeki_Activate(f2_arg0, f2_arg1, f2_arg2) then
        return
    end
    if f2_arg1:HasSpecialEffectId(TARGET_ENE_0, 110060) or f2_arg1:HasSpecialEffectId(TARGET_ENE_0, 110010) then
        if f2_arg1:IsInsideTarget(TARGET_ENE_0, AI_DIR_TYPE_F, 90) then
            f2_local0[21] = 1
            f2_local0[28] = 100
        else
            f2_local0[21] = 100
        end
    elseif Common_ActivateAct(f2_arg1, f2_arg2, 0, 1) then
    elseif f2_arg1:GetNumber(7) == 0 and f2_arg1:HasSpecialEffectId(TARGET_SELF, 200050) then
        f2_local0[14] = 600
    elseif f2_local3 >= 7 and f2_arg1:GetNumber(7) == 1 and f2_arg1:GetNumber(10) == 0 then
        f2_local0[49] = 50
    elseif f2_arg1:HasSpecialEffectId(TARGET_ENE_0, 110030) then
        f2_local0[28] = 100
    elseif f2_arg1:IsInsideTarget(TARGET_ENE_0, AI_DIR_TYPE_B, 180) then
        f2_local0[21] = 100
        f2_local0[22] = 1
    elseif f2_arg1:HasSpecialEffectId(TARGET_ENE_0, 110060) or f2_arg1:HasSpecialEffectId(TARGET_ENE_0, 110010) then
        f2_local0[27] = 100
    elseif f2_local3 >= 7 then
        f2_local0[7] = 600
        f2_local0[10] = 300
        f2_local0[14] = 600
        f2_local0[15] = 600
        f2_local0[16] = 600
        if f2_arg1:GetNinsatsuNum() <= 1 then
            f2_local0[38] = 700
            f2_local0[39] = 700
        else
            f2_local0[35] = 200
        end
    elseif f2_local3 >= 5 then
        f2_local0[7] = 600
        f2_local0[8] = 100
        f2_local0[10] = 300
        f2_local0[14] = 600
        f2_local0[34] = 100
        f2_local0[23] = 100
        f2_local0[30] = 100
        if f2_arg1:GetNinsatsuNum() <= 1 then
            f2_local0[38] = 700
            f2_local0[39] = 700
        else
            f2_local0[35] = 200
        end
    elseif f2_local3 > 3 then
        f2_local0[1] = 5
        f2_local0[2] = 10
        f2_local0[6] = 30
        f2_local0[11] = 15
        f2_local0[14] = 600
        f2_local0[23] = 15
        f2_local0[30] = 50
        if f2_arg1:GetNumber(7) == 1 then
            f2_local0[49] = 50
        end
        if f2_arg1:GetNinsatsuNum() <= 1 then
            f2_local0[38] = 700
            f2_local0[39] = 700
        else
            f2_local0[35] = 200
        end
    else
        f2_local0[3] = 15
        f2_local0[11] = 15
        f2_local0[23] = 10
        f2_local0[30] = 50
        f2_local0[31] = 30
        if f2_arg1:GetNumber(7) == 1 then
            f2_local0[49] = 50
        end
        if f2_arg1:IsFinishTimer(7) == true then
            f2_local0[24] = 30
        end
    end
    if (f2_arg1:HasSpecialEffectId(TARGET_ENE_0, 109031) or f2_arg1:HasSpecialEffectId(TARGET_ENE_0, 110125)) and f2_local3 <= 5 then
        f2_local0[16] = 100
    end
    if f2_arg1:HasSpecialEffectId(TARGET_ENE_0, 109900) then
        f2_local0[1] = 5
        f2_local0[2] = 5
        f2_local0[3] = 5
        f2_local0[9] = 0
        f2_local0[11] = 5
        f2_local0[10] = 5
        f2_local0[14] = 0
        f2_local0[15] = 0
        f2_local0[35] = 0
        f2_local0[36] = 0
        f2_local0[48] = 30
    end
    if f2_arg1:GetNumber(2) == 1 then
        f2_local0[23] = 6000
        f2_arg1:SetNumber(2, 0)
    end
    if f2_arg1:IsFinishTimer(0) == false then
        f2_local0[3] = 0
        f2_local0[6] = 1
    end
    if f2_arg1:IsFinishTimer(1) == false then
        f2_local0[2] = 0
    end
    if f2_arg1:IsFinishTimer(3) == false then
        f2_local0[24] = 0
    end
    if f2_arg1:IsFinishTimer(6) == false then
        f2_local0[9] = 0
        f2_local0[35] = 0
        f2_local0[36] = 0
        if f2_arg1:GetNumber(9) == 1 then
            f2_local0[38] = 0
        end
    end
    if f2_arg1:HasSpecialEffectId(TARGET_SELF, 200051) then
        f2_local0[8] = 0
        f2_local0[15] = 0
        f2_local0[19] = 0
        f2_local0[34] = 0
        f2_local0[48] = 0
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
    if f2_arg1:HasSpecialEffectId(TARGET_ENE_0, 110621) then
        f2_local0[23] = 0
        f2_local0[24] = 0
        f2_local0[31] = 10
    end
    f2_local0[1] = SetCoolTime(f2_arg1, f2_arg2, 3000, 15, f2_local0[1], 1)
    f2_local0[2] = SetCoolTime(f2_arg1, f2_arg2, 3004, 15, f2_local0[2], 1)
    f2_local0[3] = SetCoolTime(f2_arg1, f2_arg2, 3005, 15, f2_local0[3], 1)
    f2_local0[5] = SetCoolTime(f2_arg1, f2_arg2, 3007, 15, f2_local0[5], 1)
    f2_local0[6] = SetCoolTime(f2_arg1, f2_arg2, 3016, 15, f2_local0[6], 1)
    f2_local0[7] = SetCoolTime(f2_arg1, f2_arg2, 3038, 15, f2_local0[7], 1)
    f2_local0[8] = SetCoolTime(f2_arg1, f2_arg2, 3038, 15, f2_local0[8], 1)
    f2_local0[9] = SetCoolTime(f2_arg1, f2_arg2, 3092, 15, f2_local0[9], 1)
    f2_local0[10] = SetCoolTime(f2_arg1, f2_arg2, 3006, 15, f2_local0[10], 1)
    f2_local0[11] = SetCoolTime(f2_arg1, f2_arg2, 3037, 15, f2_local0[11], 1)
    f2_local0[13] = SetCoolTime(f2_arg1, f2_arg2, 3031, 15, f2_local0[13], 1)
    f2_local0[14] = SetCoolTime(f2_arg1, f2_arg2, 3026, 15, f2_local0[14], 1)
    f2_local0[15] = SetCoolTime(f2_arg1, f2_arg2, 3014, 15, f2_local0[15], 1)
    f2_local0[17] = SetCoolTime(f2_arg1, f2_arg2, 3014, 15, f2_local0[17], 1)
    f2_local0[18] = SetCoolTime(f2_arg1, f2_arg2, 3014, 15, f2_local0[18], 1)
    f2_local0[30] = SetCoolTime(f2_arg1, f2_arg2, 3009, 15, f2_local0[30], 1)
    f2_local0[31] = SetCoolTime(f2_arg1, f2_arg2, 3045, 15, f2_local0[31], 1)
    f2_local0[32] = SetCoolTime(f2_arg1, f2_arg2, 3006, 15, f2_local0[32], 1)
    f2_local0[34] = SetCoolTime(f2_arg1, f2_arg2, 3007, 15, f2_local0[34], 1)
    f2_local0[48] = SetCoolTime(f2_arg1, f2_arg2, 3013, 5, f2_local0[48], 1)
    f2_local0[49] = SetCoolTime(f2_arg1, f2_arg2, 3018, 5, f2_local0[49], 1)
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
    f2_local1[34] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act34)
    f2_local1[35] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act35)
    f2_local1[37] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act37)
    f2_local1[38] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act38)
    f2_local1[39] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act39)
    f2_local1[40] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act40)
    f2_local1[41] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act41)
    f2_local1[42] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act42)
    f2_local1[45] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act45)
    f2_local1[46] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act46)
    f2_local1[47] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act47)
    f2_local1[48] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act48)
    f2_local1[49] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act49)
    local f2_local8 = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.ActAfter_AdjustSpace)
    Common_Battle_Activate(f2_arg1, f2_arg2, f2_local0, f2_local1, f2_local8, f2_local2)
    
end

Goal.Act01 = function (f3_arg0, f3_arg1, f3_arg2)
    local f3_local0 = 3.6 - f3_arg0:GetMapHitRadius(TARGET_SELF)
    local f3_local1 = 3.6 - f3_arg0:GetMapHitRadius(TARGET_SELF) + 2
    local f3_local2 = 3.6 - f3_arg0:GetMapHitRadius(TARGET_SELF) + 3
    local f3_local3 = 100
    local f3_local4 = 0
    local f3_local5 = 2.5
    local f3_local6 = 3
    local f3_local7 = f3_arg0:GetRandam_Int(1, 100)
    Approach_Act_Flex(f3_arg0, f3_arg1, f3_local0, f3_local1, f3_local2, f3_local3, f3_local4, f3_local5, f3_local6)
    local f3_local8 = 3.5 - f3_arg0:GetMapHitRadius(TARGET_SELF)
    local f3_local9 = 3.4 - f3_arg0:GetMapHitRadius(TARGET_SELF)
    local f3_local10 = 3.4 - f3_arg0:GetMapHitRadius(TARGET_SELF)
    local f3_local11 = 0
    local f3_local12 = 0
    if f3_local7 <= 30 then
        f3_arg1:AddSubGoal(GOAL_COMMON_ComboAttackTunableSpin, 10, 3000, TARGET_ENE_0, f3_local8, f3_local11, f3_local12, 0, 0)
        f3_arg1:AddSubGoal(GOAL_COMMON_ComboRepeat, 10, 3001, TARGET_ENE_0, f3_local9, 0)
        f3_arg1:AddSubGoal(GOAL_COMMON_ComboRepeat, 10, 3002, TARGET_ENE_0, f3_local10, 0)
        f3_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3003, TARGET_ENE_0, 9999, 0, 0)
    else
        f3_arg1:AddSubGoal(GOAL_COMMON_ComboAttackTunableSpin, 10, 3000, TARGET_ENE_0, f3_local8, f3_local11, f3_local12, 0, 0)
        f3_arg1:AddSubGoal(GOAL_COMMON_ComboRepeat, 10, 3001, TARGET_ENE_0, 3.5, 0)
        f3_arg1:AddSubGoal(GOAL_COMMON_ComboRepeat, 10, 3010, TARGET_ENE_0, 5, 0)
        f3_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3025, TARGET_ENE_0, 9999, 0, 0)
    end
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act02 = function (f4_arg0, f4_arg1, f4_arg2)
    local f4_local0 = 3.2 - f4_arg0:GetMapHitRadius(TARGET_SELF)
    local f4_local1 = 3.2 - f4_arg0:GetMapHitRadius(TARGET_SELF) + 2
    local f4_local2 = 3.2 - f4_arg0:GetMapHitRadius(TARGET_SELF) + 3
    local f4_local3 = 100
    local f4_local4 = 0
    local f4_local5 = 2.5
    local f4_local6 = 3
    Approach_Act_Flex(f4_arg0, f4_arg1, f4_local0, f4_local1, f4_local2, f4_local3, f4_local4, f4_local5, f4_local6)
    local f4_local7 = 0
    local f4_local8 = 0
    f4_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 10, 3004, TARGET_ENE_0, 9999, f4_local7, f4_local8, 0, 0)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act03 = function (f5_arg0, f5_arg1, f5_arg2)
    local f5_local0 = 2.2 - f5_arg0:GetMapHitRadius(TARGET_SELF)
    local f5_local1 = 2.2 - f5_arg0:GetMapHitRadius(TARGET_SELF) + 0.3
    local f5_local2 = 2.2 - f5_arg0:GetMapHitRadius(TARGET_SELF) + 2
    local f5_local3 = 0
    local f5_local4 = 0
    local f5_local5 = 1.5
    local f5_local6 = 3
    Approach_Act_Flex(f5_arg0, f5_arg1, f5_local0, f5_local1, f5_local2, f5_local3, f5_local4, f5_local5, f5_local6)
    local f5_local7 = 0
    local f5_local8 = 0
    local f5_local9 = 180
    local f5_local10 = 3
    f5_arg0:AddObserveArea(0, TARGET_SELF, TARGET_ENE_0, AI_DIR_TYPE_B, f5_local9, f5_local10)
    f5_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 10, 3005, TARGET_ENE_0, 9999, f5_local7, f5_local8, 0, 0)
    f5_arg0:SetTimer(0, 7)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act04 = function (f6_arg0, f6_arg1, f6_arg2)
    f6_arg1:AddSubGoal(GOAL_COMMON_ComboAttackTunableSpin, 10, 3009, TARGET_ENE_0, 9999, 0, 0)
    f6_arg1:AddSubGoal(GOAL_COMMON_ComboRepeat, 10, 3011, TARGET_ENE_0, 9999, 0, 0)
    f6_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3007, TARGET_ENE_0, 9999, 0, 0)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act05 = function (f7_arg0, f7_arg1, f7_arg2)
    local f7_local0 = 5.9 - f7_arg0:GetMapHitRadius(TARGET_SELF)
    local f7_local1 = 5.9 - f7_arg0:GetMapHitRadius(TARGET_SELF)
    local f7_local2 = 5.9 - f7_arg0:GetMapHitRadius(TARGET_SELF)
    local f7_local3 = 100
    local f7_local4 = 0
    local f7_local5 = 2.5
    local f7_local6 = 3
    Approach_Act_Flex(f7_arg0, f7_arg1, f7_local0, f7_local1, f7_local2, f7_local3, f7_local4, f7_local5, f7_local6)
    local f7_local7 = 0
    local f7_local8 = 0
    f7_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 10, 3007, TARGET_ENE_0, 9999, f7_local7, f7_local8, 0, 0)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act06 = function (f8_arg0, f8_arg1, f8_arg2)
    local f8_local0 = 5.2 - f8_arg0:GetMapHitRadius(TARGET_SELF)
    local f8_local1 = 5.2 - f8_arg0:GetMapHitRadius(TARGET_SELF) + 2
    local f8_local2 = 5.2 - f8_arg0:GetMapHitRadius(TARGET_SELF) + 3
    local f8_local3 = 100
    local f8_local4 = 0
    local f8_local5 = 1.5
    local f8_local6 = 3
    Approach_Act_Flex(f8_arg0, f8_arg1, f8_local0, f8_local1, f8_local2, f8_local3, f8_local4, f8_local5, f8_local6)
    local f8_local7 = 0
    local f8_local8 = 0
    f8_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 10, 3016, TARGET_ENE_0, 9999, f8_local7, f8_local8, 0, 0)
    f8_arg0:SetTimer(0, 5)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act07 = function (f9_arg0, f9_arg1, f9_arg2)
    local f9_local0 = 8.9 - f9_arg0:GetMapHitRadius(TARGET_SELF)
    local f9_local1 = 8.9 - f9_arg0:GetMapHitRadius(TARGET_SELF) - 2
    local f9_local2 = 8.9 - f9_arg0:GetMapHitRadius(TARGET_SELF)
    local f9_local3 = 100
    local f9_local4 = 0
    local f9_local5 = 1.5
    local f9_local6 = 3
    Approach_Act_Flex(f9_arg0, f9_arg1, f9_local0, f9_local1, f9_local2, f9_local3, f9_local4, f9_local5, f9_local6)
    local f9_local7 = 0
    local f9_local8 = 0
    local f9_local9 = 7 - f9_arg0:GetMapHitRadius(TARGET_SELF)
    f9_arg1:AddSubGoal(GOAL_COMMON_ComboAttackTunableSpin, 10, 3014, TARGET_ENE_0, f9_local9, f9_local7, f9_local8, 0, 0)
    f9_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3038, TARGET_ENE_0, 999, 0)
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
    local f10_local9 = 999 - f10_arg0:GetMapHitRadius(TARGET_SELF)
    f10_arg1:AddSubGoal(GOAL_COMMON_ComboAttackTunableSpin, 10, 3007, TARGET_ENE_0, f10_local9, f10_local7, f10_local8, 0, 0)
    f10_arg1:AddSubGoal(GOAL_COMMON_ComboRepeat, 10, 3011, TARGET_ENE_0, 9999, 0, 0)
    f10_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3038, TARGET_ENE_0, 999, 0)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act09 = function (f11_arg0, f11_arg1, f11_arg2)
    local f11_local0 = 4.5 - f11_arg0:GetMapHitRadius(TARGET_SELF)
    local f11_local1 = 4.5 - f11_arg0:GetMapHitRadius(TARGET_SELF)
    local f11_local2 = 4.5 - f11_arg0:GetMapHitRadius(TARGET_SELF)
    local f11_local3 = 100
    local f11_local4 = 0
    local f11_local5 = 1.5
    local f11_local6 = 3
    Approach_Act_Flex(f11_arg0, f11_arg1, f11_local0, f11_local1, f11_local2, f11_local3, f11_local4, f11_local5, f11_local6)
    local f11_local7 = 0
    local f11_local8 = 0
    f11_arg1:AddSubGoal(GOAL_COMMON_ComboAttackTunableSpin, 10, 3040, TARGET_ENE_0, 4, f11_local7, f11_local8, 0, 0)
    f11_arg1:AddSubGoal(GOAL_COMMON_ComboRepeat, 10, 3041, TARGET_ENE_0, 3.5, 0)
    f11_arg0:SetTimer(6, 30)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act10 = function (f12_arg0, f12_arg1, f12_arg2)
    local f12_local0 = 4.8 - f12_arg0:GetMapHitRadius(TARGET_SELF)
    local f12_local1 = 4.8 - f12_arg0:GetMapHitRadius(TARGET_SELF)
    local f12_local2 = 4.8 - f12_arg0:GetMapHitRadius(TARGET_SELF)
    local f12_local3 = 100
    local f12_local4 = 0
    local f12_local5 = 10
    local f12_local6 = 10
    Approach_Act_Flex(f12_arg0, f12_arg1, f12_local0, f12_local1, f12_local2, f12_local3, f12_local4, f12_local5, f12_local6)
    local f12_local7 = 0
    local f12_local8 = 0
    f12_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 10, 3006, TARGET_ENE_0, 9999, f12_local7, f12_local8, 0, 0)
    f12_arg0:SetTimer(3, 10)
    GetWellSpace_Odds = 100
    
end

Goal.Act11 = function (f13_arg0, f13_arg1, f13_arg2)
    local f13_local0 = 3.2 - f13_arg0:GetMapHitRadius(TARGET_SELF)
    local f13_local1 = 3.2 - f13_arg0:GetMapHitRadius(TARGET_SELF) + 2
    local f13_local2 = 3.2 - f13_arg0:GetMapHitRadius(TARGET_SELF) + 3
    local f13_local3 = 100
    local f13_local4 = 0
    local f13_local5 = 3
    local f13_local6 = 3
    Approach_Act_Flex(f13_arg0, f13_arg1, f13_local0, f13_local1, f13_local2, f13_local3, f13_local4, f13_local5, f13_local6)
    f13_arg1:AddSubGoal(GOAL_COMMON_ComboAttackTunableSpin, 10, 3037, TARGET_ENE_0, 6, 0)
    f13_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3020, TARGET_ENE_0, 9999, 0, 0)
    
end

Goal.Act12 = function (f14_arg0, f14_arg1, f14_arg2)
    local f14_local0 = 0
    local f14_local1 = 0
    local f14_local2 = 999 - f14_arg0:GetMapHitRadius(TARGET_SELF)
    local f14_local3 = f14_arg0:GetDist(TARGET_ENE_0)
    f14_arg1:AddSubGoal(GOAL_COMMON_ComboAttackTunableSpin, 10, 3034, TARGET_ENE_0, f14_local2, f14_local0, f14_local1, 0, 0)
    f14_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3036, TARGET_ENE_0, 999, 0)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act13 = function (f15_arg0, f15_arg1, f15_arg2)
    f15_arg1:AddSubGoal(GOAL_COMMON_ComboAttackTunableSpin, 10, 3031, TARGET_ENE_0, 9999, TurnTime, FrontAngle, 0, 0)
    f15_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3018, TARGET_ENE_0, DistToAtt1, TurnTime, FrontAngle, 0, 0)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act14 = function (f16_arg0, f16_arg1, f16_arg2)
    local f16_local0 = 5.5 - f16_arg0:GetMapHitRadius(TARGET_SELF)
    local f16_local1 = 5.5 - f16_arg0:GetMapHitRadius(TARGET_SELF)
    local f16_local2 = 5.5 - f16_arg0:GetMapHitRadius(TARGET_SELF)
    local f16_local3 = 100
    local f16_local4 = 0
    local f16_local5 = 1.5
    local f16_local6 = 3
    local f16_local7 = f16_arg0:GetRandam_Int(1, 100)
    Approach_Act_Flex(f16_arg0, f16_arg1, f16_local0, f16_local1, f16_local2, f16_local3, f16_local4, f16_local5, f16_local6)
    local f16_local8 = 0
    local f16_local9 = 0
    local f16_local10 = 5.5 - f16_arg0:GetMapHitRadius(TARGET_SELF)
    f16_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 10, 3026, TARGET_ENE_0, 9999, f16_local8, f16_local9, 0, 0):TimingSetNumber(9, 1, AI_TIMING_SET__ACTIVATE)
    f16_arg0:SetNumber(7, 1)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act15 = function (f17_arg0, f17_arg1, f17_arg2)
    local f17_local0 = 8.9 - f17_arg0:GetMapHitRadius(TARGET_SELF)
    local f17_local1 = 8.9 - f17_arg0:GetMapHitRadius(TARGET_SELF) - 2
    local f17_local2 = 8.9 - f17_arg0:GetMapHitRadius(TARGET_SELF)
    local f17_local3 = 100
    local f17_local4 = 0
    local f17_local5 = 1.5
    local f17_local6 = 3
    Approach_Act_Flex(f17_arg0, f17_arg1, f17_local0, f17_local1, f17_local2, f17_local3, f17_local4, f17_local5, f17_local6)
    local f17_local7 = 0
    local f17_local8 = 0
    local f17_local9 = 7 - f17_arg0:GetMapHitRadius(TARGET_SELF)
    f17_arg1:AddSubGoal(GOAL_COMMON_ComboAttackTunableSpin, 10, 3014, TARGET_ENE_0, f17_local9, f17_local7, f17_local8, 0, 0)
    f17_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3015, TARGET_ENE_0, 9999, 0, 0)
    f17_arg0:SetNumber(7, 1)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act16 = function (f18_arg0, f18_arg1, f18_arg2)
    local f18_local0 = 2.5 - f18_arg0:GetMapHitRadius(TARGET_SELF)
    local f18_local1 = 2.5 - f18_arg0:GetMapHitRadius(TARGET_SELF)
    local f18_local2 = 2.5 - f18_arg0:GetMapHitRadius(TARGET_SELF)
    local f18_local3 = 100
    local f18_local4 = 0
    local f18_local5 = 1.5
    local f18_local6 = 3
    local f18_local7 = f18_arg0:GetRandam_Int(1, 100)
    Approach_Act_Flex(f18_arg0, f18_arg1, f18_local0, f18_local1, f18_local2, f18_local3, f18_local4, f18_local5, f18_local6)
    local f18_local8 = 0
    local f18_local9 = 0
    local f18_local10 = 7 - f18_arg0:GetMapHitRadius(TARGET_SELF)
    f18_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 10, 3022, TARGET_ENE_0, 9999, f18_local8, f18_local9, 0, 0)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act17 = function (f19_arg0, f19_arg1, f19_arg2)
    local f19_local0 = 8.9 - f19_arg0:GetMapHitRadius(TARGET_SELF)
    local f19_local1 = 8.9 - f19_arg0:GetMapHitRadius(TARGET_SELF) - 2
    local f19_local2 = 8.9 - f19_arg0:GetMapHitRadius(TARGET_SELF)
    local f19_local3 = 100
    local f19_local4 = 0
    local f19_local5 = 1.5
    local f19_local6 = 3
    Approach_Act_Flex(f19_arg0, f19_arg1, f19_local0, f19_local1, f19_local2, f19_local3, f19_local4, f19_local5, f19_local6)
    local f19_local7 = 0
    local f19_local8 = 0
    local f19_local9 = 7 - f19_arg0:GetMapHitRadius(TARGET_SELF)
    f19_arg1:AddSubGoal(GOAL_COMMON_ComboAttackTunableSpin, 10, 3014, TARGET_ENE_0, f19_local9, f19_local7, f19_local8, 0, 0)
    f19_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3018, TARGET_ENE_0, 9999, 0, 0)
    f19_arg0:SetNumber(7, 1)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act18 = function (f20_arg0, f20_arg1, f20_arg2)
    local f20_local0 = 8.9 - f20_arg0:GetMapHitRadius(TARGET_SELF)
    local f20_local1 = 8.9 - f20_arg0:GetMapHitRadius(TARGET_SELF) - 2
    local f20_local2 = 8.9 - f20_arg0:GetMapHitRadius(TARGET_SELF)
    local f20_local3 = 100
    local f20_local4 = 0
    local f20_local5 = 1.5
    local f20_local6 = 3
    Approach_Act_Flex(f20_arg0, f20_arg1, f20_local0, f20_local1, f20_local2, f20_local3, f20_local4, f20_local5, f20_local6)
    local f20_local7 = 0
    local f20_local8 = 0
    local f20_local9 = 7 - f20_arg0:GetMapHitRadius(TARGET_SELF)
    f20_arg1:AddSubGoal(GOAL_COMMON_ComboAttackTunableSpin, 10, 3014, TARGET_ENE_0, f20_local9, f20_local7, f20_local8, 0, 0)
    f20_arg1:AddSubGoal(GOAL_COMMON_ComboRepeat, 10, 3018, TARGET_ENE_0, 9999, 0, 0)
    f20_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3006, TARGET_ENE_0, 9999, 0, 0)
    f20_arg0:SetNumber(7, 1)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act20 = function (f21_arg0, f21_arg1, f21_arg2)
    local f21_local0 = 3.2 - f21_arg0:GetMapHitRadius(TARGET_SELF)
    local f21_local1 = 3.2 - f21_arg0:GetMapHitRadius(TARGET_SELF) + 1
    local f21_local2 = 3.2 - f21_arg0:GetMapHitRadius(TARGET_SELF) + 2
    local f21_local3 = 100
    local f21_local4 = 0
    local f21_local5 = 2.5
    local f21_local6 = 3
    Approach_Act_Flex(f21_arg0, f21_arg1, f21_local0, f21_local1, f21_local2, f21_local3, f21_local4, f21_local5, f21_local6)
    local f21_local7 = 0
    local f21_local8 = 0
    f21_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 10, 3062, TARGET_ENE_0, 9999, f21_local7, f21_local8, 0, 0)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act21 = function (f22_arg0, f22_arg1, f22_arg2)
    local f22_local0 = 3
    local f22_local1 = 45
    f22_arg1:AddSubGoal(GOAL_COMMON_Turn, f22_local0, TARGET_ENE_0, f22_local1, -1, GOAL_RESULT_Success, true)
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
    
end

Goal.Act22 = function (f23_arg0, f23_arg1, f23_arg2)
    local f23_local0 = 3
    local f23_local1 = 0
    if SpaceCheck(f23_arg0, f23_arg1, -45, 2) == true then
        if SpaceCheck(f23_arg0, f23_arg1, 45, 2) == true then
            if f23_arg0:IsInsideTarget(TARGET_ENE_0, AI_DIR_TYPE_R, 180) then
                f23_arg1:AddSubGoal(GOAL_COMMON_SpinStep, f23_local0, 5202, TARGET_ENE_0, f23_local1, AI_DIR_TYPE_L, 0)
            else
                f23_arg1:AddSubGoal(GOAL_COMMON_SpinStep, f23_local0, 5203, TARGET_ENE_0, f23_local1, AI_DIR_TYPE_R, 0)
            end
        else
            f23_arg1:AddSubGoal(GOAL_COMMON_SpinStep, f23_local0, 5202, TARGET_ENE_0, f23_local1, AI_DIR_TYPE_L, 0)
        end
    elseif SpaceCheck(f23_arg0, f23_arg1, 45, 2) == true then
        f23_arg1:AddSubGoal(GOAL_COMMON_SpinStep, f23_local0, 5203, TARGET_ENE_0, f23_local1, AI_DIR_TYPE_R, 0)
    else
    end
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
    
end

Goal.Act23 = function (f24_arg0, f24_arg1, f24_arg2)
    local f24_local0 = f24_arg0:GetDist(TARGET_ENE_0)
    local f24_local1 = f24_arg0:GetSp(TARGET_SELF)
    local f24_local2 = 20
    local f24_local3 = f24_arg0:GetRandam_Int(1, 100)
    local f24_local4 = -1
    local f24_local5 = 0
    if SpaceCheck(f24_arg0, f24_arg1, -90, 1) == true then
        if SpaceCheck(f24_arg0, f24_arg1, 90, 1) == true then
            if f24_arg0:IsInsideTargetEx(TARGET_ENE_0, TARGET_SELF, AI_DIR_TYPE_R, 180, 5) then
                f24_local5 = 1
            else
                f24_local5 = 0
            end
        else
            f24_local5 = 0
        end
    elseif SpaceCheck(f24_arg0, f24_arg1, 90, 1) == true then
        f24_local5 = 1
    else
    end
    local f24_local6 = f24_arg0:GetRandam_Int(1.5, 3)
    local f24_local7 = f24_arg0:GetRandam_Int(30, 45)
    f24_arg0:SetNumber(10, f24_local5)
    f24_arg1:AddSubGoal(GOAL_COMMON_SidewayMove, f24_local6, TARGET_ENE_0, f24_local5, f24_local7, true, true, f24_local4)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act24 = function (f25_arg0, f25_arg1, f25_arg2)
    local f25_local0 = f25_arg0:GetDist(TARGET_ENE_0)
    local f25_local1 = 3
    local f25_local2 = 0
    local f25_local3 = 5201
    local f25_local4 = f25_arg0:GetSpRate(TARGET_SELF)
    if SpaceCheck(f25_arg0, f25_arg1, 180, 2) ~= true or SpaceCheck(f25_arg0, f25_arg1, 180, 4) ~= true or f25_local0 > 4 then
    else
        f25_local3 = 5201
        if false then
        else
        end
    end
    f25_arg0:SetNumber(2, 1)
    f25_arg1:AddSubGoal(GOAL_COMMON_SpinStep, f25_local1, f25_local3, TARGET_ENE_0, f25_local2, AI_DIR_TYPE_B, 0):TimingSetTimer(3, 30, AI_TIMING_SET__UPDATE_SUCCESS)
    if f25_local4 <= 0.7 and f25_arg0:HasSpecialEffectId(TARGET_SELF, 200050) then
        f25_arg1:AddSubGoal(GOAL_COMMON_ComboRepeat, 10, 3044, TARGET_ENE_0, DistToAtt1, f25_local2, FrontAngle, 0, 0)
    end
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act25 = function (f26_arg0, f26_arg1, f26_arg2)
    local f26_local0 = f26_arg0:GetRandam_Float(2, 4)
    local f26_local1 = f26_arg0:GetRandam_Float(1, 3)
    local f26_local2 = f26_arg0:GetDist(TARGET_ENE_0)
    local f26_local3 = -1
    if SpaceCheck(f26_arg0, f26_arg1, 180, 1) == true then
        f26_arg1:AddSubGoal(GOAL_COMMON_LeaveTarget, f26_local0, TARGET_ENE_0, f26_local1, TARGET_ENE_0, true, f26_local3)
    else
    end
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
    
end

Goal.Act26 = function (f27_arg0, f27_arg1, f27_arg2)
    f27_arg1:AddSubGoal(GOAL_COMMON_Wait, 0.5, TARGET_SELF, 0, 0, 0)
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
    
end

Goal.Act27 = function (f28_arg0, f28_arg1, f28_arg2)
    local f28_local0 = f28_arg0:GetDist(TARGET_ENE_0)
    local f28_local1 = f28_arg0:GetRandam_Int(1, 100)
    local f28_local2 = 8
    local f28_local3 = 5
    local f28_local4 = f28_arg0:GetRandam_Float(2, 4)
    local f28_local5 = f28_arg0:GetRandam_Int(30, 45)
    if f28_local0 >= 8 then
        f28_arg1:AddSubGoal(GOAL_COMMON_ApproachTarget, f28_local4, TARGET_ENE_0, f28_local2, TARGET_ENE_0, true, -1)
    elseif f28_local0 <= 5 then
        f28_arg1:AddSubGoal(GOAL_COMMON_LeaveTarget, f28_local4, TARGET_ENE_0, f28_local3, TARGET_ENE_0, true, -1)
    end
    f28_arg1:AddSubGoal(GOAL_COMMON_SidewayMove, f28_local4, TARGET_ENE_0, f28_arg0:GetRandam_Int(0, 1), f28_local5, true, true, -1)
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
    
end

Goal.Act28 = function (f29_arg0, f29_arg1, f29_arg2)
    local f29_local0 = f29_arg0:GetDist(TARGET_ENE_0)
    local f29_local1 = 1.5
    local f29_local2 = 1.5
    local f29_local3 = f29_arg0:GetRandam_Int(30, 45)
    local f29_local4 = -1
    local f29_local5 = f29_arg0:GetRandam_Int(0, 1)
    if f29_local0 <= 3 then
        f29_arg1:AddSubGoal(GOAL_COMMON_SidewayMove, f29_local1, TARGET_ENE_0, f29_local5, f29_local3, true, true, f29_local4)
    elseif f29_local0 <= 8 then
        f29_arg1:AddSubGoal(GOAL_COMMON_ApproachTarget, f29_local2, TARGET_ENE_0, 3, TARGET_SELF, true, -1)
    else
        f29_arg1:AddSubGoal(GOAL_COMMON_ApproachTarget, f29_local2, TARGET_ENE_0, 8, TARGET_SELF, false, -1)
    end
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
    
end

Goal.Act30 = function (f30_arg0, f30_arg1, f30_arg2)
    f30_arg1:AddSubGoal(GOAL_COMMON_ComboAttackTunableSpin, 10, 3009, TARGET_ENE_0, 9999, TurnTime, FrontAngle, 0, 0)
    f30_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3038, TARGET_ENE_0, 999, 0)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act31 = function (f31_arg0, f31_arg1, f31_arg2)
    local f31_local0 = 3.6 - f31_arg0:GetMapHitRadius(TARGET_SELF)
    local f31_local1 = 3.6 - f31_arg0:GetMapHitRadius(TARGET_SELF) + 2
    local f31_local2 = 3.6 - f31_arg0:GetMapHitRadius(TARGET_SELF) + 2
    local f31_local3 = 100
    local f31_local4 = 0
    local f31_local5 = 1.5
    local f31_local6 = 3
    Approach_Act_Flex(f31_arg0, f31_arg1, f31_local0, f31_local1, f31_local2, f31_local3, f31_local4, f31_local5, f31_local6)
    local f31_local7 = 0
    local f31_local8 = 0
    local f31_local9 = 999 - f31_arg0:GetMapHitRadius(TARGET_SELF)
    f31_arg1:AddSubGoal(GOAL_COMMON_ComboAttackTunableSpin, 10, 3003, TARGET_ENE_0, f31_local9, f31_local7, f31_local8, 0, 0)
    f31_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3045, TARGET_ENE_0, 9999, 0, 0)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act34 = function (f32_arg0, f32_arg1, f32_arg2)
    local f32_local0 = 5.9 - f32_arg0:GetMapHitRadius(TARGET_SELF)
    local f32_local1 = 5.9 - f32_arg0:GetMapHitRadius(TARGET_SELF) + 2
    local f32_local2 = 5.9 - f32_arg0:GetMapHitRadius(TARGET_SELF) + 2
    local f32_local3 = 100
    local f32_local4 = 0
    local f32_local5 = 1.5
    local f32_local6 = 3
    Approach_Act_Flex(f32_arg0, f32_arg1, f32_local0, f32_local1, f32_local2, f32_local3, f32_local4, f32_local5, f32_local6)
    local f32_local7 = 0
    local f32_local8 = 0
    local f32_local9 = 999 - f32_arg0:GetMapHitRadius(TARGET_SELF)
    f32_arg1:AddSubGoal(GOAL_COMMON_ComboAttackTunableSpin, 10, 3007, TARGET_ENE_0, f32_local9, f32_local7, f32_local8, 0, 0)
    f32_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3011, TARGET_ENE_0, 9999, 0, 0)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act35 = function (f33_arg0, f33_arg1, f33_arg2)
    local f33_local0 = 0
    local f33_local1 = 0
    f33_arg1:AddSubGoal(GOAL_COMMON_ComboAttackTunableSpin, 10, 3040, TARGET_ENE_0, 9, f33_local0, f33_local1, 0, 0)
    local f33_local2 = f33_arg0:GetRandam_Int(1, 100)
    f33_arg1:AddSubGoal(GOAL_COMMON_ComboRepeat, 10, 3041, TARGET_ENE_0, 3.5, 0)
    f33_arg0:SetTimer(6, 30)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act36 = function (f34_arg0, f34_arg1, f34_arg2)
    local f34_local0 = 4.5 - f34_arg0:GetMapHitRadius(TARGET_SELF)
    local f34_local1 = 4.5 - f34_arg0:GetMapHitRadius(TARGET_SELF)
    local f34_local2 = 4.5 - f34_arg0:GetMapHitRadius(TARGET_SELF)
    local f34_local3 = 100
    local f34_local4 = 0
    local f34_local5 = 1.5
    local f34_local6 = 3
    Approach_Act_Flex(f34_arg0, f34_arg1, f34_local0, f34_local1, f34_local2, f34_local3, f34_local4, f34_local5, f34_local6)
    local f34_local7 = 0
    local f34_local8 = 0
    f34_arg1:AddSubGoal(GOAL_COMMON_ComboAttackTunableSpin, 10, 3040, TARGET_ENE_0, 4, f34_local7, f34_local8, 0, 0)
    f34_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3049, TARGET_ENE_0, 3.5, 0)
    f34_arg0:SetTimer(6, 30)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act37 = function (f35_arg0, f35_arg1, f35_arg2)
    local f35_local0 = 4.8 - f35_arg0:GetMapHitRadius(TARGET_SELF)
    local f35_local1 = 4.8 - f35_arg0:GetMapHitRadius(TARGET_SELF)
    local f35_local2 = 4.8 - f35_arg0:GetMapHitRadius(TARGET_SELF)
    local f35_local3 = 100
    local f35_local4 = 0
    local f35_local5 = 10
    local f35_local6 = 10
    Approach_Act_Flex(f35_arg0, f35_arg1, f35_local0, f35_local1, f35_local2, f35_local3, f35_local4, f35_local5, f35_local6)
    local f35_local7 = 3
    local f35_local8 = 360
    f35_arg1:AddSubGoal(GOAL_COMMON_ComboAttackTunableSpin, 10, 3006, TARGET_ENE_0, 9999, 0, 0, 0, 0)
    f35_arg1:AddSubGoal(GOAL_COMMON_ComboRepeat, 10, 3045, TARGET_ENE_0, 9999, 360, 360, 360, 360)
    f35_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3010, TARGET_ENE_0, 9999, 360, 360, 360, 360)
    f35_arg0:SetTimer(3, 10)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act38 = function (f36_arg0, f36_arg1, f36_arg2)
    local f36_local0 = 4.5 - f36_arg0:GetMapHitRadius(TARGET_SELF)
    local f36_local1 = 4.5 - f36_arg0:GetMapHitRadius(TARGET_SELF)
    local f36_local2 = 4.5 - f36_arg0:GetMapHitRadius(TARGET_SELF)
    local f36_local3 = 100
    local f36_local4 = 0
    local f36_local5 = 1.5
    local f36_local6 = 3
    Approach_Act_Flex(f36_arg0, f36_arg1, f36_local0, f36_local1, f36_local2, f36_local3, f36_local4, f36_local5, f36_local6)
    local f36_local7 = 0
    local f36_local8 = 0
    f36_arg1:AddSubGoal(GOAL_COMMON_ComboAttackTunableSpin, 10, 3040, TARGET_ENE_0, 999, f36_local7, f36_local8, 0, 0)
    local f36_local9 = f36_arg0:GetRandam_Int(1, 100)
    if f36_local9 <= 30 then
        f36_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3048, TARGET_ENE_0, 9999, 0):TimingSetNumber(9, 1, AI_TIMING_SET__ACTIVATE)
    else
        f36_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3026, TARGET_ENE_0, 999, 0):TimingSetNumber(9, 1, AI_TIMING_SET__ACTIVATE)
    end
    f36_arg0:SetTimer(6, 30)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act39 = function (f37_arg0, f37_arg1, f37_arg2)
    local f37_local0 = 0
    local f37_local1 = 0
    f37_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 10, 3006, TARGET_ENE_0, 9999, f37_local0, f37_local1, 0, 0)
    local f37_local2 = f37_arg0:GetDist(TARGET_ENE_0)
    if f37_local2 <= 4 then
        f37_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3048, TARGET_ENE_0, 9999, 0):TimingSetNumber(9, 1, AI_TIMING_SET__ACTIVATE)
    else
        f37_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3026, TARGET_ENE_0, 999, 0):TimingSetNumber(9, 1, AI_TIMING_SET__ACTIVATE)
    end
    GetWellSpace_Odds = 100
    return GetWellSpace_Oddsr
    
end

Goal.Act40 = function (f38_arg0, f38_arg1, f38_arg2)
    local f38_local0 = 0
    local f38_local1 = 0
    f38_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 10, 3026, TARGET_ENE_0, 999, 0):TimingSetNumber(9, 1, AI_TIMING_SET__ACTIVATE)
    GetWellSpace_Odds = 100
    return GetWellSpace_Oddsr
    
end

Goal.Act48 = function (f39_arg0, f39_arg1, f39_arg2)
    local f39_local0 = 8.9 - f39_arg0:GetMapHitRadius(TARGET_SELF)
    local f39_local1 = 8.9 - f39_arg0:GetMapHitRadius(TARGET_SELF) - 2
    local f39_local2 = 8.9 - f39_arg0:GetMapHitRadius(TARGET_SELF)
    local f39_local3 = 100
    local f39_local4 = 0
    local f39_local5 = 1.5
    local f39_local6 = 3
    Approach_Act_Flex(f39_arg0, f39_arg1, f39_local0, f39_local1, f39_local2, f39_local3, f39_local4, f39_local5, f39_local6)
    local f39_local7 = 0
    local f39_local8 = 0
    local f39_local9 = 7 - f39_arg0:GetMapHitRadius(TARGET_SELF)
    f39_arg1:AddSubGoal(GOAL_COMMON_ComboAttackTunableSpin, 10, 3013, TARGET_ENE_0, f39_local9, f39_local7, f39_local8, 0, 0)
    f39_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3015, TARGET_ENE_0, 9999, 0, 0)
    f39_arg0:SetNumber(7, 1)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act49 = function (f40_arg0, f40_arg1, f40_arg2)
    local f40_local0 = 0
    local f40_local1 = 0
    local f40_local2 = 999 - f40_arg0:GetMapHitRadius(TARGET_SELF)
    local f40_local3 = 7 - f40_arg0:GetMapHitRadius(TARGET_SELF)
    f40_arg1:AddSubGoal(GOAL_COMMON_ComboAttackTunableSpin, 10, 3018, TARGET_ENE_0, f40_local2, f40_local0, f40_local1, 0, 0)
    f40_arg1:AddSubGoal(GOAL_COMMON_ComboRepeat, 10, 3038, TARGET_ENE_0, 9999, 0, 0)
    f40_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3026, TARGET_ENE_0, 999, 0):TimingSetNumber(10, 1, AI_TIMING_SET__ACTIVATE)
    f40_arg0:SetNumber(6, 1)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Interrupt = function (f41_arg0, f41_arg1, f41_arg2)
    local f41_local0 = f41_arg1:GetSpecialEffectActivateInterruptType(0)
    local f41_local1 = f41_arg1:GetSpecialEffectInactivateInterruptType(0)
    local f41_local2 = f41_arg1:GetDist(TARGET_ENE_0)
    local f41_local3 = f41_arg1:GetRandam_Int(1, 100)
    local f41_local4 = f41_arg1:GetNinsatsuNum()
    if f41_arg1:IsLadderAct(TARGET_SELF) then
        return false
    end
    if not f41_arg1:HasSpecialEffectId(TARGET_SELF, 200004) then
        return false
    end
    if f41_arg1:IsInterupt(INTERUPT_ParryTiming) then
        return f41_arg0.Parry(f41_arg1, f41_arg2, 100, 0)
    end
    if f41_arg1:IsInterupt(INTERUPT_ShootImpact) and f41_arg0.ShootReaction(f41_arg1, f41_arg2) then
        return true
    end
    if f41_arg1:IsInterupt(INTERUPT_ActivateSpecialEffect) then
        if f41_local0 == 3710020 then
            f41_arg1:SetNumber(0, 0)
            return true
        elseif f41_local0 == 3710030 and f41_arg1:HasSpecialEffectId(TARGET_SELF, 3710032) then
            f41_arg2:ClearSubGoal()
            f41_arg2:AddSubGoal(GOAL_COMMON_EndureAttack, 5, 3092, TARGET_ENE_0, 9999, 0)
            f41_arg1:SetTimer(6, 50)
            return true
        elseif f41_local0 == 5029 then
            return f41_arg0.Damaged(f41_arg1, f41_arg2)
        elseif f41_local0 == 5031 then
            if f41_local2 >= 4.5 then
                f41_arg2:ClearSubGoal()
                f41_arg2:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3049, TARGET_ENE_0, 9999, 0)
            end
        elseif f41_local0 == 5358 then
            if f41_local2 >= 4.5 then
                f41_arg2:ClearSubGoal()
                f41_arg2:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3049, TARGET_ENE_0, 9999, 0)
            end
        elseif f41_local0 == 3710050 then
            if f41_arg1:HasSpecialEffectId(TARGET_ENE_0, 105025) or f41_arg1:HasSpecialEffectId(TARGET_ENE_0, 100320) then
                f41_arg2:ClearSubGoal()
                f41_arg2:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3026, TARGET_ENE_0, 999, 0)
            elseif f41_local3 <= 50 and f41_arg1:HasSpecialEffectId(TARGET_SELF, 200050) then
                f41_arg2:ClearSubGoal()
                f41_arg2:AddSubGoal(GOAL_COMMON_ComboRepeat, 5, 3023, TARGET_ENE_0, 9999, 0)
            else
                f41_arg2:ClearSubGoal()
                f41_arg2:AddSubGoal(GOAL_COMMON_SidewayMove, 4, TARGET_ENE_0, f41_arg1:GetRandam_Int(0, 1), f41_arg1:GetRandam_Int(30, 45), true, true, -1)
            end
        elseif f41_local0 == 110620 then
            f41_arg1:Replanning()
            return true
        end
    end
    if not Interupt_Use_Item(f41_arg1, 8, 5) or f41_arg1:HasSpecialEffectId(TARGET_SELF, 200051) and f41_local4 >= 2 then
    else
        f41_arg2:ClearSubGoal()
        f41_arg2:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 1, 3023, TARGET_ENE_0, 9999, 0, 0, 0, 0)
        return true
    end
    return false
    
end

Goal.Parry = function (f42_arg0, f42_arg1, f42_arg2, f42_arg3)
    local f42_local0 = f42_arg0:GetDist(TARGET_ENE_0)
    local f42_local1 = GetDist_Parry(f42_arg0)
    local f42_local2 = f42_arg0:GetRandam_Int(1, 100)
    local f42_local3 = f42_arg0:GetRandam_Int(1, 100)
    local f42_local4 = f42_arg0:GetRandam_Int(1, 100)
    local f42_local5 = f42_arg0:HasSpecialEffectId(TARGET_ENE_0, 109970)
    local f42_local6 = f42_arg0:HasSpecialEffectId(TARGET_ENE_0, COMMON_SP_EFFECT_PC_ATTACK_RUSH)
    local f42_local7 = 2
    if f42_arg0:HasSpecialEffectId(TARGET_SELF, 221000) then
        f42_local7 = 0
    elseif f42_arg0:HasSpecialEffectId(TARGET_SELF, 221001) then
        f42_local7 = 1
    end
    if f42_arg0:IsFinishTimer(AI_TIMER_PARRY_INTERVAL) == false then
        return false
    end
    if f42_arg0:HasSpecialEffectId(TARGET_ENE_0, 110450) or f42_arg0:HasSpecialEffectId(TARGET_ENE_0, 110501) or f42_arg0:HasSpecialEffectId(TARGET_ENE_0, 110500) then
        return false
    end
    f42_arg0:SetTimer(AI_TIMER_PARRY_INTERVAL, 0.1)
    if f42_arg2 == nil then
        f42_arg2 = 50
    end
    if f42_arg3 == nil then
        f42_arg3 = 0
    end
    if f42_arg0:IsInsideTarget(TARGET_ENE_0, AI_DIR_TYPE_F, 90) and f42_arg0:IsInsideTargetEx(TARGET_ENE_0, TARGET_SELF, AI_DIR_TYPE_F, 180, f42_local1) then
        if f42_arg0:HasSpecialEffectId(TARGET_SELF, 3710040) then
            f42_arg1:ClearSubGoal()
            f42_arg1:AddSubGoal(GOAL_COMMON_EndureAttack, 0.3, 3102, TARGET_ENE_0, 9999, 0)
            f42_arg0:SetTimer(5, 60)
            return true
        elseif f42_local6 then
            f42_arg1:ClearSubGoal()
            f42_arg1:AddSubGoal(GOAL_COMMON_EndureAttack, 0.3, 3103, TARGET_ENE_0, 9999, 0)
            return true
        elseif f42_local5 then
            if f42_arg0:IsTargetGuard(TARGET_SELF) and ReturnKengekiSpecialEffect(f42_arg0) == false then
                return false
            elseif f42_local7 == 2 then
                return false
            elseif f42_local7 == 1 then
                if f42_local2 <= 50 then
                    f42_arg1:ClearSubGoal()
                    f42_arg1:AddSubGoal(GOAL_COMMON_SpinStep, 1, 5211, TARGET_ENE_0, 0, AI_DIR_TYPE_B, 0)
                    return true
                end
            elseif f42_local7 == 0 and f42_local2 <= 100 then
                f42_arg1:ClearSubGoal()
                f42_arg1:AddSubGoal(GOAL_COMMON_EndureAttack, 0.3, 3101, TARGET_ENE_0, 9999, 0)
                return true
            end
        elseif f42_arg0:HasSpecialEffectId(TARGET_ENE_0, 109980) then
            f42_arg1:ClearSubGoal()
            f42_arg1:AddSubGoal(GOAL_COMMON_SpinStep, 1, 5201, TARGET_ENE_0, 0, AI_DIR_TYPE_B, 0)
            return true
        elseif f42_local3 <= Get_ConsecutiveGuardCount(f42_arg0) * f42_arg2 then
            f42_arg1:ClearSubGoal()
            f42_arg1:AddSubGoal(GOAL_COMMON_EndureAttack, 0.3, 3101, TARGET_ENE_0, 9999, 0)
            return true
        else
            f42_arg1:ClearSubGoal()
            f42_arg1:AddSubGoal(GOAL_COMMON_EndureAttack, 0.3, 3100, TARGET_ENE_0, 9999, 0)
            return true
        end
    elseif f42_arg0:IsInsideTargetEx(TARGET_ENE_0, TARGET_SELF, AI_DIR_TYPE_F, 90, f42_local1 + 1) then
        if f42_local4 <= f42_arg3 then
            f42_arg1:ClearSubGoal()
            f42_arg1:AddSubGoal(GOAL_COMMON_SpinStep, 1, 5211, TARGET_ENE_0, 0, AI_DIR_TYPE_B, 0)
            return true
        else
            return false
        end
    else
        return false
    end
    
end

Goal.Damaged = function (f43_arg0, f43_arg1, f43_arg2)
    local f43_local0 = f43_arg0:GetHpRate(TARGET_SELF)
    local f43_local1 = f43_arg0:GetDist(TARGET_ENE_0)
    local f43_local2 = f43_arg0:GetSp(TARGET_SELF)
    local f43_local3 = f43_arg0:GetRandam_Int(1, 100)
    local f43_local4 = 0
    local f43_local5 = 3
    if f43_local3 <= 15 then
        f43_arg1:ClearSubGoal()
        f43_arg1:AddSubGoal(GOAL_COMMON_SpinStep, f43_local5, 5201, TARGET_ENE_0, TurnTime, AI_DIR_TYPE_B, 0):TimingSetTimer(3, 6, UPDATE_SUCCESS)
        f43_arg0:SetNumber(2, 1)
        if f43_arg0:GetNumber(0) <= 3 then
            f43_arg0:SetNumber(0, 0)
        else
            f43_arg0:SetNumber(0, f43_arg0:GetNumber(0) - 3)
        end
        return true
    elseif f43_local3 <= 30 and f43_arg0:HasSpecialEffectId(TARGET_SELF, 200050) then
        f43_arg1:ClearSubGoal()
        f43_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3009, TARGET_ENE_0, 9999, 0)
        f43_arg0:SetNumber(2, 1)
        if f43_arg0:GetNumber(0) <= 3 then
            f43_arg0:SetNumber(0, 0)
        else
            f43_arg0:SetNumber(0, f43_arg0:GetNumber(0) - 3)
        end
        return true
    else
    end
    return false
    
end

Goal.ShootReaction = function (f44_arg0, f44_arg1)
    f44_arg1:ClearSubGoal()
    f44_arg1:AddSubGoal(GOAL_COMMON_EndureAttack, 0.1, 3100, TARGET_ENE_0, 9999, 0)
    return true
    
end

Goal.Kengeki_Activate = function (f45_arg0, f45_arg1, f45_arg2, f45_arg3)
    local f45_local0 = ReturnKengekiSpecialEffect(f45_arg1)
    if f45_local0 == 0 then
        return false
    end
    local f45_local1 = {}
    local f45_local2 = {}
    local f45_local3 = {}
    Common_Clear_Param(f45_local1, f45_local2, f45_local3)
    local f45_local4 = f45_arg1:GetDist(TARGET_ENE_0)
    local f45_local5 = f45_arg1:GetHpRate(TARGET_SELF)
    local f45_local6 = f45_arg1:GetSpRate(TARGET_SELF)
    if f45_local0 == 200200 then
        f45_arg1:SetNumber(0, f45_arg1:GetNumber(0) + 1)
        if f45_local4 >= 2.5 then
            f45_local1[50] = 100
        elseif f45_arg1:GetNumber(0) >= 4 then
            f45_local1[3] = 60
            f45_local1[20] = 60
            f45_local1[30] = 5
            f45_local1[41] = 50
            f45_local1[15] = 30
            f45_local1[43] = 50
            f45_local1[39] = 30
            if f45_arg1:GetNinsatsuNum() <= 1 then
                f45_local1[12] = 100
            end
            if f45_arg1:GetNumber(6) == 0 then
                f45_local1[32] = 20
            else
                f45_local1[33] = 20
            end
        elseif f45_arg1:GetNumber(0) == 3 then
            f45_local1[3] = 60
            f45_local1[20] = 60
            f45_local1[30] = 5
            f45_local1[41] = 50
            f45_local1[15] = 30
            f45_local1[43] = 50
            f45_local1[39] = 30
            if f45_arg1:GetNinsatsuNum() <= 1 then
                f45_local1[12] = 100
            end
            if f45_arg1:GetNumber(3) == 0 then
                f45_local1[1] = 50
                f45_local1[7] = 50
            else
                f45_local1[4] = 100
            end
        elseif f45_arg1:GetNumber(0) == 2 then
            f45_local1[3] = 60
            f45_local1[20] = 60
            f45_local1[30] = 5
            f45_local1[15] = 30
            f45_local1[43] = 50
            f45_local1[39] = 30
            if f45_arg1:GetNumber(3) == 0 then
                f45_local1[1] = 50
                f45_local1[7] = 50
            else
                f45_local1[4] = 100
            end
        elseif f45_arg1:GetNumber(0) == 1 then
            f45_local1[3] = 60
            f45_local1[20] = 60
            f45_local1[30] = 5
            f45_local1[15] = 30
            f45_local1[43] = 50
            f45_local1[39] = 30
            if f45_arg1:GetNumber(3) == 0 then
                f45_local1[1] = 50
                f45_local1[7] = 50
            else
                f45_local1[4] = 100
                if false then
                end
            end
        end
    elseif f45_local0 == 200201 then
        if f45_local4 >= 2.5 then
            f45_local1[50] = 100
        elseif f45_arg1:GetNumber(0) >= 4 then
            f45_local1[3] = 60
            f45_local1[20] = 60
            f45_local1[41] = 50
            f45_local1[15] = 30
            f45_local1[43] = 50
            f45_local1[39] = 30
        elseif f45_arg1:GetNumber(0) == 3 then
            f45_local1[3] = 60
            f45_local1[20] = 60
            f45_local1[41] = 50
            f45_local1[15] = 30
            f45_local1[43] = 50
            f45_local1[39] = 30
            if f45_arg1:GetNumber(3) == 0 then
                f45_local1[1] = 50
                f45_local1[10] = 50
            else
                f45_local1[4] = 100
                f45_local1[22] = 50
            end
        elseif f45_arg1:GetNumber(0) == 2 then
            f45_local1[3] = 60
            f45_local1[20] = 60
            f45_local1[15] = 30
            f45_local1[43] = 50
            f45_local1[39] = 30
            if f45_arg1:GetNumber(3) == 0 then
                f45_local1[1] = 50
                f45_local1[10] = 50
            else
                f45_local1[4] = 100
                f45_local1[22] = 50
            end
        elseif f45_arg1:GetNumber(0) == 1 then
            f45_local1[3] = 60
            f45_local1[20] = 60
            f45_local1[15] = 30
            f45_local1[43] = 50
            f45_local1[39] = 30
            if f45_arg1:GetNumber(3) == 0 then
                f45_local1[1] = 50
                f45_local1[10] = 50
            else
                f45_local1[4] = 100
                f45_local1[22] = 50
                if false then
                end
            end
        end
    elseif f45_local0 == 200210 then
        f45_local1[2] = 100
        f45_local1[17] = 100
        f45_local1[41] = 50
        f45_local1[31] = 50
    elseif f45_local0 == 200211 then
        f45_local1[2] = 100
        f45_local1[10] = 50
        f45_local1[31] = 50
        f45_local1[41] = 50
    elseif f45_local0 == 200216 then
        if f45_local4 >= 2 then
            f45_local1[50] = 10
        else
            f45_arg1:SetNumber(0, f45_arg1:GetNumber(0) + 1)
            if f45_arg1:GetNumber(0) >= 4 then
                f45_local1[3] = 60
                f45_local1[20] = 20
                f45_local1[41] = 50
                f45_local1[43] = 50
                if f45_arg1:GetNinsatsuNum() <= 1 then
                    f45_local1[12] = 100
                end
                if f45_arg1:GetNumber(6) == 0 then
                    f45_local1[32] = 50
                else
                    f45_local1[33] = 50
                end
            elseif f45_arg1:GetNumber(0) == 3 then
                f45_local1[3] = 60
                f45_local1[20] = 20
                f45_local1[43] = 50
                if f45_arg1:GetNinsatsuNum() <= 1 then
                    f45_local1[12] = 100
                end
                if f45_arg1:GetNumber(3) == 0 then
                    f45_local1[1] = 50
                    f45_local1[30] = 50
                else
                    f45_local1[14] = 50
                    f45_local1[13] = 50
                end
            elseif f45_arg1:GetNumber(0) == 2 then
                f45_local1[3] = 60
                f45_local1[20] = 20
                f45_local1[43] = 50
                if f45_arg1:GetNumber(3) == 0 then
                    f45_local1[1] = 50
                    f45_local1[30] = 50
                else
                    f45_local1[14] = 50
                    f45_local1[13] = 50
                end
            elseif f45_arg1:GetNumber(0) == 1 then
                f45_local1[3] = 60
                f45_local1[20] = 20
                f45_local1[43] = 50
                f45_local1[20] = 50
                if f45_arg1:GetNumber(3) == 0 then
                    f45_local1[1] = 50
                    f45_local1[30] = 50
                else
                    f45_local1[14] = 50
                    f45_local1[13] = 50
                    if false then
                    end
                end
            end
        end
    elseif f45_local0 == 200215 then
        if f45_local4 >= 2 then
            f45_local1[50] = 10
        else
            f45_arg1:SetNumber(0, f45_arg1:GetNumber(0) + 1)
            if f45_arg1:GetNumber(0) >= 4 then
                f45_local1[20] = 20
                f45_local1[41] = 50
                f45_local1[31] = 15
                f45_local1[43] = 10
                f45_local1[39] = 10
                if f45_arg1:GetNinsatsuNum() <= 1 then
                    f45_local1[12] = 100
                end
                if f45_arg1:GetNumber(6) == 0 then
                    f45_local1[32] = 50
                else
                    f45_local1[33] = 50
                end
            elseif f45_arg1:GetNumber(0) == 3 then
                f45_local1[20] = 20
                f45_local1[41] = 50
                f45_local1[31] = 15
                f45_local1[43] = 10
                if f45_arg1:GetNinsatsuNum() <= 1 then
                    f45_local1[12] = 100
                end
                f45_local1[39] = 10
                if f45_arg1:GetNumber(3) == 0 then
                    f45_local1[1] = 50
                    f45_local1[17] = 50
                else
                    f45_local1[13] = 50
                    f45_local1[14] = 50
                end
            elseif f45_arg1:GetNumber(0) == 2 then
                f45_local1[20] = 20
                f45_local1[31] = 15
                f45_local1[43] = 10
                f45_local1[39] = 10
                if f45_arg1:GetNumber(3) == 0 then
                    f45_local1[1] = 50
                    f45_local1[17] = 50
                else
                    f45_local1[13] = 50
                    f45_local1[14] = 50
                end
            elseif f45_arg1:GetNumber(0) == 1 then
                f45_local1[20] = 20
                f45_local1[31] = 15
                f45_local1[43] = 10
                f45_local1[39] = 10
                if f45_arg1:GetNumber(3) == 0 then
                    f45_local1[1] = 50
                    f45_local1[17] = 50
                else
                    f45_local1[13] = 50
                    f45_local1[14] = 50
                end
            else
            end
        end
    end
    if f45_arg1:HasSpecialEffectId(TARGET_SELF, 200051) then
        f45_local1[3] = 0
        f45_local1[9] = 0
        f45_local1[12] = 0
        f45_local1[15] = 0
        f45_local1[32] = 0
        f45_local1[33] = 0
        f45_local1[39] = 0
        f45_local1[46] = 0
    elseif f45_arg1:HasSpecialEffectId(TARGET_SELF, 200050) then
        f45_local1[20] = 0
    end
    if SpaceCheck(f45_arg1, f45_arg2, 45, 2) == false and SpaceCheck(f45_arg1, f45_arg2, -45, 2) == false then
        f45_local1[20] = 0
    end
    if f45_arg1:IsFinishTimer(6) == false then
        f45_local1[40] = 0
        f45_local1[48] = 0
    elseif f45_arg1:IsFinishTimer(6) == true and f45_local5 <= 0.75 then
        f45_local1[40] = 50
        f45_local1[48] = 50
    end
    f45_local1[1] = SetCoolTime(f45_arg1, f45_arg2, 3050, 8, f45_local1[1], 1)
    f45_local1[2] = SetCoolTime(f45_arg1, f45_arg2, 5201, 10, f45_local1[2], 1)
    f45_local1[3] = SetCoolTime(f45_arg1, f45_arg2, 3009, 10, f45_local1[3], 1)
    f45_local1[4] = SetCoolTime(f45_arg1, f45_arg2, 3055, 8, f45_local1[4], 1)
    f45_local1[7] = SetCoolTime(f45_arg1, f45_arg2, 3060, 8, f45_local1[7], 1)
    f45_local1[9] = SetCoolTime(f45_arg1, f45_arg2, 3018, 8, f45_local1[9], 1)
    f45_local1[10] = SetCoolTime(f45_arg1, f45_arg2, 3065, 8, f45_local1[10], 1)
    f45_local1[11] = SetCoolTime(f45_arg1, f45_arg2, 3070, 8, f45_local1[11], 1)
    f45_local1[12] = SetCoolTime(f45_arg1, f45_arg2, 3018, 8, f45_local1[12], 1)
    f45_local1[13] = SetCoolTime(f45_arg1, f45_arg2, 3070, 8, f45_local1[13], 1)
    f45_local1[14] = SetCoolTime(f45_arg1, f45_arg2, 3076, 8, f45_local1[14], 1)
    f45_local1[15] = SetCoolTime(f45_arg1, f45_arg2, 3031, 15, f45_local1[15], 1)
    f45_local1[16] = SetCoolTime(f45_arg1, f45_arg2, 3070, 8, f45_local1[16], 1)
    f45_local1[17] = SetCoolTime(f45_arg1, f45_arg2, 3071, 8, f45_local1[17], 1)
    f45_local1[18] = SetCoolTime(f45_arg1, f45_arg2, 3004, 8, f45_local1[18], 1)
    f45_local1[20] = SetCoolTime(f45_arg1, f45_arg2, 5202, 15, f45_local1[20], 1)
    f45_local1[22] = SetCoolTime(f45_arg1, f45_arg2, 3070, 8, f45_local1[22], 1)
    f45_local1[30] = SetCoolTime(f45_arg1, f45_arg2, 3063, 15, f45_local1[30], 1)
    f45_local1[31] = SetCoolTime(f45_arg1, f45_arg2, 3068, 15, f45_local1[31], 1)
    f45_local1[32] = SetCoolTime(f45_arg1, f45_arg2, 3018, 15, f45_local1[32], 1)
    f45_local1[33] = SetCoolTime(f45_arg1, f45_arg2, 3007, 15, f45_local1[33], 1)
    f45_local1[34] = SetCoolTime(f45_arg1, f45_arg2, 3037, 15, f45_local1[34], 1)
    f45_local1[35] = SetCoolTime(f45_arg1, f45_arg2, 3016, 8, f45_local1[35], 1)
    f45_local1[37] = SetCoolTime(f45_arg1, f45_arg2, 3030, 8, f45_local1[37], 1)
    f45_local1[38] = SetCoolTime(f45_arg1, f45_arg2, 3030, 8, f45_local1[38], 1)
    f45_local1[39] = SetCoolTime(f45_arg1, f45_arg2, 3034, 15, f45_local1[39], 1)
    f45_local1[40] = SetCoolTime(f45_arg1, f45_arg2, 3040, 15, f45_local1[40], 1)
    f45_local1[41] = SetCoolTime(f45_arg1, f45_arg2, 3030, 15, f45_local1[41], 1)
    f45_local1[42] = SetCoolTime(f45_arg1, f45_arg2, 3030, 15, f45_local1[42], 1)
    f45_local1[43] = SetCoolTime(f45_arg1, f45_arg2, 3062, 15, f45_local1[43], 1)
    f45_local1[44] = SetCoolTime(f45_arg1, f45_arg2, 3067, 15, f45_local1[44], 1)
    f45_local1[45] = SetCoolTime(f45_arg1, f45_arg2, 3032, 15, f45_local1[45], 1)
    f45_local2[1] = REGIST_FUNC(f45_arg1, f45_arg2, f45_arg0.Kengeki01)
    f45_local2[2] = REGIST_FUNC(f45_arg1, f45_arg2, f45_arg0.Kengeki02)
    f45_local2[3] = REGIST_FUNC(f45_arg1, f45_arg2, f45_arg0.Kengeki03)
    f45_local2[4] = REGIST_FUNC(f45_arg1, f45_arg2, f45_arg0.Kengeki04)
    f45_local2[5] = REGIST_FUNC(f45_arg1, f45_arg2, f45_arg0.Kengeki05)
    f45_local2[6] = REGIST_FUNC(f45_arg1, f45_arg2, f45_arg0.Kengeki06)
    f45_local2[7] = REGIST_FUNC(f45_arg1, f45_arg2, f45_arg0.Kengeki07)
    f45_local2[9] = REGIST_FUNC(f45_arg1, f45_arg2, f45_arg0.Kengeki09)
    f45_local2[10] = REGIST_FUNC(f45_arg1, f45_arg2, f45_arg0.Kengeki10)
    f45_local2[11] = REGIST_FUNC(f45_arg1, f45_arg2, f45_arg0.Kengeki11)
    f45_local2[12] = REGIST_FUNC(f45_arg1, f45_arg2, f45_arg0.Kengeki12)
    f45_local2[13] = REGIST_FUNC(f45_arg1, f45_arg2, f45_arg0.Kengeki13)
    f45_local2[14] = REGIST_FUNC(f45_arg1, f45_arg2, f45_arg0.Kengeki14)
    f45_local2[15] = REGIST_FUNC(f45_arg1, f45_arg2, f45_arg0.Kengeki15)
    f45_local2[16] = REGIST_FUNC(f45_arg1, f45_arg2, f45_arg0.Kengeki16)
    f45_local2[17] = REGIST_FUNC(f45_arg1, f45_arg2, f45_arg0.Kengeki17)
    f45_local2[18] = REGIST_FUNC(f45_arg1, f45_arg2, f45_arg0.Kengeki18)
    f45_local2[19] = REGIST_FUNC(f45_arg1, f45_arg2, f45_arg0.Kengeki19)
    f45_local2[20] = REGIST_FUNC(f45_arg1, f45_arg2, f45_arg0.Kengeki20)
    f45_local2[21] = REGIST_FUNC(f45_arg1, f45_arg2, f45_arg0.Kengeki21)
    f45_local2[22] = REGIST_FUNC(f45_arg1, f45_arg2, f45_arg0.Kengeki22)
    f45_local2[30] = REGIST_FUNC(f45_arg1, f45_arg2, f45_arg0.Kengeki30)
    f45_local2[31] = REGIST_FUNC(f45_arg1, f45_arg2, f45_arg0.Kengeki31)
    f45_local2[32] = REGIST_FUNC(f45_arg1, f45_arg2, f45_arg0.Kengeki32)
    f45_local2[33] = REGIST_FUNC(f45_arg1, f45_arg2, f45_arg0.Kengeki33)
    f45_local2[34] = REGIST_FUNC(f45_arg1, f45_arg2, f45_arg0.Kengeki34)
    f45_local2[35] = REGIST_FUNC(f45_arg1, f45_arg2, f45_arg0.Kengeki35)
    f45_local2[36] = REGIST_FUNC(f45_arg1, f45_arg2, f45_arg0.Kengeki36)
    f45_local2[37] = REGIST_FUNC(f45_arg1, f45_arg2, f45_arg0.Kengeki37)
    f45_local2[38] = REGIST_FUNC(f45_arg1, f45_arg2, f45_arg0.Kengeki38)
    f45_local2[39] = REGIST_FUNC(f45_arg1, f45_arg2, f45_arg0.Kengeki39)
    f45_local2[40] = REGIST_FUNC(f45_arg1, f45_arg2, f45_arg0.Kengeki40)
    f45_local2[41] = REGIST_FUNC(f45_arg1, f45_arg2, f45_arg0.Kengeki41)
    f45_local2[42] = REGIST_FUNC(f45_arg1, f45_arg2, f45_arg0.Kengeki42)
    f45_local2[43] = REGIST_FUNC(f45_arg1, f45_arg2, f45_arg0.Kengeki43)
    f45_local2[44] = REGIST_FUNC(f45_arg1, f45_arg2, f45_arg0.Kengeki44)
    f45_local2[45] = REGIST_FUNC(f45_arg1, f45_arg2, f45_arg0.Kengeki45)
    f45_local2[46] = REGIST_FUNC(f45_arg1, f45_arg2, f45_arg0.Kengeki46)
    f45_local2[47] = REGIST_FUNC(f45_arg1, f45_arg2, f45_arg0.Kengeki47)
    f45_local2[48] = REGIST_FUNC(f45_arg1, f45_arg2, f45_arg0.Kengeki48)
    f45_local2[49] = REGIST_FUNC(f45_arg1, f45_arg2, f45_arg0.Kengeki49)
    f45_local2[50] = REGIST_FUNC(f45_arg1, f45_arg2, f45_arg0.NoAction)
    local f45_local7 = REGIST_FUNC(f45_arg1, f45_arg2, f45_arg0.ActAfter_AdjustSpace)
    return Common_Kengeki_Activate(f45_arg1, f45_arg2, f45_local1, f45_local2, f45_local7, f45_local3)
    
end

Goal.Kengeki01 = function (f46_arg0, f46_arg1, f46_arg2)
    f46_arg0:SetNumber(3, 1)
    f46_arg1:ClearSubGoal()
    f46_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3050, TARGET_ENE_0, 9999, 0, 0)
    
end

Goal.Kengeki02 = function (f47_arg0, f47_arg1, f47_arg2)
    local f47_local0 = f47_arg0:GetSpRate(TARGET_SELF)
    f47_arg1:ClearSubGoal()
    f47_arg1:AddSubGoal(GOAL_COMMON_ComboRepeat, 10, 5201, TARGET_ENE_0, 9999, 0, 0):TimingSetTimer(3, 30, AI_TIMING_SET__UPDATE_SUCCESS)
    f47_arg0:SetNumber(2, 1)
    if f47_local0 <= 0.7 and f47_arg0:HasSpecialEffectId(TARGET_SELF, 200050) then
        f47_arg1:AddSubGoal(GOAL_COMMON_ComboRepeat, 10, 3044, TARGET_ENE_0, DistToAtt1, TurnTime, FrontAngle, 0, 0)
    end
    
end

Goal.Kengeki03 = function (f48_arg0, f48_arg1, f48_arg2)
    f48_arg1:ClearSubGoal()
    f48_arg1:AddSubGoal(GOAL_COMMON_ComboAttackTunableSpin, 10, 3009, TARGET_ENE_0, 999, 0, 0, 0, 0)
    local f48_local0 = 0
    if SpaceCheck(f48_arg0, f48_arg1, -90, 1) == true then
        if SpaceCheck(f48_arg0, f48_arg1, 90, 1) == true then
            if f48_arg0:IsInsideTargetEx(TARGET_ENE_0, TARGET_SELF, AI_DIR_TYPE_R, 180, 5) then
                f48_local0 = 1
            else
                f48_local0 = 0
            end
        else
            f48_local0 = 0
        end
    elseif SpaceCheck(f48_arg0, f48_arg1, 90, 1) == true then
        f48_local0 = 1
    else
        f48_local0 = 1
    end
    local f48_local1 = 4
    local f48_local2 = f48_arg0:GetRandam_Int(30, 45)
    f48_arg1:AddSubGoal(GOAL_COMMON_SidewayMove, f48_local1, TARGET_ENE_0, f48_local0, f48_local2, true, true, -1)
    
end

Goal.Kengeki04 = function (f49_arg0, f49_arg1, f49_arg2)
    f49_arg0:SetNumber(3, 0)
    f49_arg1:ClearSubGoal()
    f49_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3055, TARGET_ENE_0, 9999, 0, 0)
    
end

Goal.Kengeki05 = function (f50_arg0, f50_arg1, f50_arg2)
    f50_arg1:ClearSubGoal()
    f50_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3061, TARGET_ENE_0, 9999, 0, 0)
    
end

Goal.Kengeki07 = function (f51_arg0, f51_arg1, f51_arg2)
    f51_arg1:ClearSubGoal()
    f51_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3060, TARGET_ENE_0, 9999, 0, 0)
    
end

Goal.Kengeki09 = function (f52_arg0, f52_arg1, f52_arg2)
    f52_arg1:ClearSubGoal()
    f52_arg1:AddSubGoal(GOAL_COMMON_ComboAttackTunableSpin, 10, 3018, TARGET_ENE_0, 999, 0, 0, 0, 0)
    f52_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3015, TARGET_ENE_0, 9999, 0, 0)
    
end

Goal.Kengeki10 = function (f53_arg0, f53_arg1, f53_arg2)
    f53_arg1:ClearSubGoal()
    f53_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3065, TARGET_ENE_0, 9999, 0, 0)
    
end

Goal.Kengeki11 = function (f54_arg0, f54_arg1, f54_arg2)
    f54_arg1:ClearSubGoal()
    f54_arg1:AddSubGoal(GOAL_COMMON_ComboAttackTunableSpin, 10, 3070, TARGET_ENE_0, 9999, 0, 0)
    f54_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3004, TARGET_ENE_0, 9999, 0, 0)
    
end

Goal.Kengeki12 = function (f55_arg0, f55_arg1, f55_arg2)
    local f55_local0 = 0
    local f55_local1 = 0
    local f55_local2 = 999 - f55_arg0:GetMapHitRadius(TARGET_SELF)
    local f55_local3 = 7 - f55_arg0:GetMapHitRadius(TARGET_SELF)
    f55_arg1:ClearSubGoal()
    f55_arg1:AddSubGoal(GOAL_COMMON_ComboAttackTunableSpin, 10, 3018, TARGET_ENE_0, f55_local2, f55_local0, f55_local1, 0, 0)
    f55_arg1:AddSubGoal(GOAL_COMMON_ComboRepeat, 10, 3038, TARGET_ENE_0, 9999, 0, 0)
    f55_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3026, TARGET_ENE_0, 999, 0)
    f55_arg0:SetNumber(6, 1)
    
end

Goal.Kengeki13 = function (f56_arg0, f56_arg1, f56_arg2)
    f56_arg1:ClearSubGoal()
    f56_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3075, TARGET_ENE_0, 9999, 0, 0)
    
end

Goal.Kengeki14 = function (f57_arg0, f57_arg1, f57_arg2)
    f57_arg1:ClearSubGoal()
    f57_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3076, TARGET_ENE_0, 9999, 0, 0)
    
end

Goal.Kengeki15 = function (f58_arg0, f58_arg1, f58_arg2)
    local f58_local0 = 0
    local f58_local1 = 0
    local f58_local2 = 7.8 - f58_arg0:GetMapHitRadius(TARGET_SELF) + 2
    local f58_local3 = 0
    local f58_local4 = f58_arg0
    f58_local3 = f58_arg0.GetMapHitRadius
    f58_local3 = f58_local3(f58_local4, TARGET_SELF)
    f58_local3 = 2.5 - f58_local3
    f58_local4 = f58_arg0:GetRandam_Int(1, 100)
    local f58_local5 = f58_arg0:GetRandam_Int(1, 100)
    local f58_local6 = f58_arg0:GetSp(TARGET_SELF)
    local f58_local7 = f58_arg0:GetRandam_Int(30, 45)
    f58_arg1:ClearSubGoal()
    f58_arg1:AddSubGoal(GOAL_COMMON_ComboAttackTunableSpin, 10, 3031, TARGET_ENE_0, f58_local2, f58_local0, f58_local1, 0, 0)
    if f58_local4 <= 50 then
        f58_arg1:AddSubGoal(GOAL_COMMON_ComboRepeat, 10, 3019, TARGET_ENE_0, f58_local3, 0)
        f58_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3029, TARGET_ENE_0, 9999, 0, 0)
    else
        f58_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3036, TARGET_ENE_0, 9999, 0, 0)
    end
    if f58_local5 <= 50 then
        f58_arg0:SetNumber(2, 1)
    end
    
end

Goal.Kengeki16 = function (f59_arg0, f59_arg1, f59_arg2)
    f59_arg1:ClearSubGoal()
    f59_arg1:AddSubGoal(GOAL_COMMON_ComboAttackTunableSpin, 10, 3070, TARGET_ENE_0, 9999, 0, 0)
    f59_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3044, TARGET_ENE_0, 9999, 0, 0)
    
end

Goal.Kengeki17 = function (f60_arg0, f60_arg1, f60_arg2)
    f60_arg1:ClearSubGoal()
    f60_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3071, TARGET_ENE_0, 9999, 0, 0)
    
end

Goal.Kengeki18 = function (f61_arg0, f61_arg1, f61_arg2)
    f61_arg1:ClearSubGoal()
    f61_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3004, TARGET_ENE_0, 9999, 0, 0)
    
end

Goal.Kengeki19 = function (f62_arg0, f62_arg1, f62_arg2)
    f62_arg1:ClearSubGoal()
    f62_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3044, TARGET_ENE_0, 9999, 0, 0)
    
end

Goal.Kengeki20 = function (f63_arg0, f63_arg1, f63_arg2)
    local f63_local0 = f63_arg0:GetDist(TARGET_ENE_0)
    local f63_local1 = 3
    local f63_local2 = 0
    if SpaceCheck(f63_arg0, f63_arg1, -135, 1) == true then
        if SpaceCheck(f63_arg0, f63_arg1, 135, 1) == true then
            if f63_arg0:IsInsideTarget(TARGET_ENE_0, AI_DIR_TYPE_R, 180) then
                f63_local2 = 1
            else
                f63_local2 = 0
            end
        else
            f63_local2 = 0
        end
    elseif SpaceCheck(f63_arg0, f63_arg1, 90, 1) == true then
        f63_local2 = 1
    else
    end
    f63_arg1:ClearSubGoal()
    f63_arg1:AddSubGoal(GOAL_COMMON_SpinStep, f63_local1, 5202, TARGET_ENE_0, 0, AI_DIR_TYPE_B, 0)
    f63_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3007, TARGET_ENE_0, 9999, 0, 0)
    return GETWELLSPACE_ODDS
    
end

Goal.Kengeki21 = function (f64_arg0, f64_arg1, f64_arg2)
    f64_arg1:ClearSubGoal()
    f64_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3010, TARGET_ENE_0, 9999, 0, 0)
    
end

Goal.Kengeki22 = function (f65_arg0, f65_arg1, f65_arg2)
    f65_arg1:ClearSubGoal()
    f65_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3065, TARGET_ENE_0, 9999, 0, 0)
    
end

Goal.Kengeki30 = function (f66_arg0, f66_arg1, f66_arg2)
    f66_arg1:ClearSubGoal()
    f66_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3063, TARGET_ENE_0, 9999, 0, 0):TimingSetTimer(1, 10, AI_TIMING_SET__UPDATE_SUCCESS)
    f66_arg0:SetNumber(5, 0)
    
end

Goal.Kengeki31 = function (f67_arg0, f67_arg1, f67_arg2)
    f67_arg1:ClearSubGoal()
    f67_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3068, TARGET_ENE_0, 9999, 0, 0):TimingSetTimer(1, 10, AI_TIMING_SET__UPDATE_SUCCESS)
    f67_arg0:SetNumber(5, 0)
    
end

Goal.Kengeki32 = function (f68_arg0, f68_arg1, f68_arg2)
    local f68_local0 = 0
    local f68_local1 = 0
    local f68_local2 = 999 - f68_arg0:GetMapHitRadius(TARGET_SELF)
    local f68_local3 = 7 - f68_arg0:GetMapHitRadius(TARGET_SELF)
    f68_arg1:ClearSubGoal()
    f68_arg1:AddSubGoal(GOAL_COMMON_ComboAttackTunableSpin, 10, 3018, TARGET_ENE_0, f68_local2, f68_local0, f68_local1, 0, 0)
    f68_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3015, TARGET_ENE_0, 9999, 0, 0)
    f68_arg0:SetNumber(6, 1)
    
end

Goal.Kengeki33 = function (f69_arg0, f69_arg1, f69_arg2)
    local f69_local0 = 0
    local f69_local1 = 0
    local f69_local2 = 999 - f69_arg0:GetMapHitRadius(TARGET_SELF)
    local f69_local3 = 7.8 - f69_arg0:GetMapHitRadius(TARGET_SELF)
    local f69_local4 = 2.5 - f69_arg0:GetMapHitRadius(TARGET_SELF)
    local f69_local5 = f69_arg0:GetRandam_Int(1, 100)
    f69_arg1:ClearSubGoal()
    f69_arg1:AddSubGoal(GOAL_COMMON_ComboAttackTunableSpin, 10, 3018, TARGET_ENE_0, f69_local2, f69_local0, f69_local1, 0, 0)
    if f69_local5 <= 50 then
        f69_arg1:AddSubGoal(GOAL_COMMON_ComboRepeat, 10, 3019, TARGET_ENE_0, f69_local3, 0)
        f69_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3029, TARGET_ENE_0, 9999, 0, 0)
    else
        f69_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3019, TARGET_ENE_0, 9999, 0, 0)
    end
    f69_arg0:SetNumber(6, 0)
    
end

Goal.Kengeki34 = function (f70_arg0, f70_arg1, f70_arg2)
    f70_arg1:ClearSubGoal()
    f70_arg1:AddSubGoal(GOAL_COMMON_ComboRepeat, 10, 3037, TARGET_ENE_0, 6, 0)
    f70_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3020, TARGET_ENE_0, 9999, 0, 0)
    
end

Goal.Kengeki35 = function (f71_arg0, f71_arg1, f71_arg2)
    f71_arg1:ClearSubGoal()
    f71_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3016, TARGET_ENE_0, 9999, 0, 0)
    f71_arg0:SetNumber(5, 0)
    
end

Goal.Kengeki37 = function (f72_arg0, f72_arg1, f72_arg2)
    local f72_local0 = 0
    local f72_local1 = 0
    local f72_local2 = f72_arg0:GetNinsatsuNum()
    local f72_local3 = f72_arg0:GetRandam_Int(1, 100)
    f72_arg1:ClearSubGoal()
    f72_arg1:AddSubGoal(GOAL_COMMON_ComboAttackTunableSpin, 10, 3030, TARGET_ENE_0, 999, f72_local0, f72_local1, 0, 0)
    if f72_local2 <= 1 then
        if f72_local3 <= 75 then
            f72_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3031, TARGET_ENE_0, 9999, 0, 0)
        else
            f72_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3031, TARGET_ENE_0, 9999, 0, 0)
        end
    else
        f72_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3031, TARGET_ENE_0, 9999, 0, 0)
    end
    
end

Goal.Kengeki38 = function (f73_arg0, f73_arg1, f73_arg2)
    local f73_local0 = 0
    local f73_local1 = 0
    local f73_local2 = f73_arg0:GetNinsatsuNum()
    local f73_local3 = f73_arg0:GetRandam_Int(1, 100)
    f73_arg1:ClearSubGoal()
    f73_arg1:AddSubGoal(GOAL_COMMON_ComboAttackTunableSpin, 10, 3030, TARGET_ENE_0, 999, f73_local0, f73_local1, 0, 0)
    if f73_local2 <= 1 then
        if f73_local3 <= 75 then
            f73_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3020, TARGET_ENE_0, 9999, 0, 0)
        else
            f73_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3020, TARGET_ENE_0, 9999, 0, 0)
        end
    else
        f73_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3020, TARGET_ENE_0, 9999, 0, 0)
    end
    f73_arg0:SetNumber(4, 1)
    
end

Goal.Kengeki39 = function (f74_arg0, f74_arg1, f74_arg2)
    local f74_local0 = 0
    local f74_local1 = 0
    local f74_local2 = 999 - f74_arg0:GetMapHitRadius(TARGET_SELF)
    local f74_local3 = f74_arg0:GetDist(TARGET_ENE_0)
    f74_arg1:ClearSubGoal()
    f74_arg1:AddSubGoal(GOAL_COMMON_ComboAttackTunableSpin, 10, 3034, TARGET_ENE_0, f74_local2, f74_local0, f74_local1, 0, 0)
    f74_arg1:AddSubGoal(GOAL_COMMON_ComboRepeat, 10, 3036, TARGET_ENE_0, 999, 0)
    f74_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3015, TARGET_ENE_0, 9999, 0, 0)
    
end

Goal.Kengeki40 = function (f75_arg0, f75_arg1, f75_arg2)
    f75_arg1:ClearSubGoal()
    f75_arg1:AddSubGoal(GOAL_COMMON_ComboAttackTunableSpin, 10, 3040, TARGET_ENE_0, 9999, 0, 0)
    if targetDist <= 4.5 then
        f75_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3048, TARGET_ENE_0, 4.5, 0)
    else
        f75_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3049, TARGET_ENE_0, 999, 0)
    end
    f75_arg0:SetTimer(6, 50)
    
end

Goal.Kengeki41 = function (f76_arg0, f76_arg1, f76_arg2)
    local f76_local0 = 0
    local f76_local1 = 0
    local f76_local2 = f76_arg0:GetNinsatsuNum()
    local f76_local3 = f76_arg0:GetRandam_Int(1, 100)
    f76_arg1:ClearSubGoal()
    f76_arg1:AddSubGoal(GOAL_COMMON_ComboAttackTunableSpin, 10, 3030, TARGET_ENE_0, 999, f76_local0, f76_local1, 0, 0)
    if f76_local2 <= 1 then
        if f76_local3 <= 75 then
            f76_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3025, TARGET_ENE_0, 9999, 0, 0)
        else
            f76_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3025, TARGET_ENE_0, 9999, 0, 0)
        end
    else
        f76_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3025, TARGET_ENE_0, 9999, 0, 0)
    end
    
end

Goal.Kengeki42 = function (f77_arg0, f77_arg1, f77_arg2)
    local f77_local0 = 0
    local f77_local1 = 0
    local f77_local2 = f77_arg0:GetNinsatsuNum()
    local f77_local3 = f77_arg0:GetRandam_Int(1, 100)
    f77_arg1:ClearSubGoal()
    f77_arg1:AddSubGoal(GOAL_COMMON_ComboAttackTunableSpin, 10, 3030, TARGET_ENE_0, 999, f77_local0, f77_local1, 0, 0)
    if f77_local2 <= 1 then
        if f77_local3 <= 75 then
            f77_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3032, TARGET_ENE_0, 9999, 0, 0)
        else
            f77_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3032, TARGET_ENE_0, 9999, 0, 0)
        end
    else
        f77_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3032, TARGET_ENE_0, 9999, 0, 0)
    end
    
end

Goal.Kengeki43 = function (f78_arg0, f78_arg1, f78_arg2)
    f78_arg1:ClearSubGoal()
    f78_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3062, TARGET_ENE_0, 9999, 0, 0)
    f78_arg0:SetNumber(2, 1)
    
end

Goal.Kengeki44 = function (f79_arg0, f79_arg1, f79_arg2)
    f79_arg1:ClearSubGoal()
    f79_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3067, TARGET_ENE_0, 9999, 0, 0)
    f79_arg0:SetNumber(2, 1)
    
end

Goal.Kengeki45 = function (f80_arg0, f80_arg1, f80_arg2)
    f80_arg1:ClearSubGoal()
    f80_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3045, TARGET_ENE_0, 9999, 0, 0)
    f80_arg0:SetNumber(0, 0)
    
end

Goal.Kengeki46 = function (f81_arg0, f81_arg1, f81_arg2)
    local f81_local0 = 0
    local f81_local1 = 0
    local f81_local2 = 7.8 - f81_arg0:GetMapHitRadius(TARGET_SELF) + 2
    local f81_local3 = 0
    local f81_local4 = f81_arg0
    f81_local3 = f81_arg0.GetRandam_Int
    f81_local3 = f81_local3(f81_local4, 1, 100)
    f81_local4 = f81_arg0:GetSp(TARGET_SELF)
    local f81_local5 = f81_arg0:GetRandam_Int(30, 45)
    f81_arg1:ClearSubGoal()
    f81_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3039, TARGET_ENE_0, 9999, 0, 0):TimingSetTimer(4, 10, AI_TIMING_SET__UPDATE_SUCCESS)
    f81_arg1:AddSubGoal(GOAL_COMMON_SidewayMove, 2.5, TARGET_ENE_0, 0, f81_local5, true, true, -1)
    
end

Goal.Kengeki47 = function (f82_arg0, f82_arg1, f82_arg2)
    f82_arg1:ClearSubGoal()
    f82_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3038, TARGET_ENE_0, 9999, 0, 0):TimingSetTimer(4, 10, AI_TIMING_SET__UPDATE_SUCCESS)
    
end

Goal.Kengeki48 = function (f83_arg0, f83_arg1, f83_arg2)
    f83_arg1:ClearSubGoal()
    f83_arg1:AddSubGoal(GOAL_COMMON_ComboAttackTunableSpin, 10, 3040, TARGET_ENE_0, 999, TurnTime, FrontAngle, 0, 0)
    local f83_local0 = f83_arg0:GetDist(TARGET_ENE_0)
    if f83_local0 <= 4.5 then
        f83_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3048, TARGET_ENE_0, 4.5, 0)
    else
        f83_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3049, TARGET_ENE_0, 999, 0)
    end
    f83_arg0:SetTimer(6, 50)
    
end

Goal.Kengeki49 = function (f84_arg0, f84_arg1, f84_arg2)
    f84_arg1:ClearSubGoal()
    f84_arg1:AddSubGoal(GOAL_COMMON_ComboAttackTunableSpin, 10, 3040, TARGET_ENE_0, 4, TurnTime, FrontAngle, 0, 0)
    f84_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3049, TARGET_ENE_0, 3.5, 0)
    f84_arg0:SetTimer(6, 50)
    
end

Goal.NoAction = function (f85_arg0, f85_arg1, f85_arg2)
    return -1
    
end

Goal.ActAfter_AdjustSpace = function (f86_arg0, f86_arg1, f86_arg2)
    
end

Goal.Update = function (f87_arg0, f87_arg1, f87_arg2)
    return Update_Default_NoSubGoal(f87_arg0, f87_arg1, f87_arg2)
    
end

Goal.Terminate = function (f88_arg0, f88_arg1, f88_arg2)
    
end


