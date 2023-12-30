RegisterTableGoal(GOAL_YashazaruKenzoku_chigosaru_126000_Battle, "GOAL_YashazaruKenzoku_chigosaru_126000_Battle")
REGISTER_GOAL_NO_UPDATE(GOAL_YashazaruKenzoku_chigosaru_126000_Battle, true)

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
    local f2_local5 = f2_arg1:GetDist(TARGET_LOCALPLAYER)
    local f2_local6 = f2_arg1:GetEventRequest(0)
    local f2_local7 = f2_arg1:GetEventRequest(1)
    local f2_local8 = f2_arg1:GetEventRequest(2)
    local f2_local9 = f2_arg1:GetEventRequest(3)
    local f2_local10 = f2_arg1:GetRandam_Int(1, 100)
    local f2_local11 = f2_arg1:GetTeamRecordCount(COORDINATE_TYPE_Attack, TARGET_ENE_0, 20)
    local f2_local12 = f2_arg1:GetTeamRecordCount(COORDINATE_TYPE_AttackOrder, TARGET_ENE_0, 20)
    local f2_local13 = 5.5
    local f2_local14 = 90
    local f2_local15 = 15
    f2_arg1:AddObserveSpecialEffectAttribute(TARGET_SELF, 5026)
    f2_arg1:AddObserveSpecialEffectAttribute(TARGET_SELF, 200004)
    f2_arg1:AddObserveSpecialEffectAttribute(TARGET_SELF, 3126000)
    f2_arg1:AddObserveSpecialEffectAttribute(TARGET_ENE_0, 3126070)
    if f2_arg1:HasSpecialEffectId(TARGET_SELF, 200004) and f2_arg1:HasSpecialEffectId(TARGET_SELF, 5023) then
        if f2_arg1:HasSpecialEffectId(TARGET_ENE_0, 3126070) then
            f2_local0[26] = 100
        else
            f2_local0[16] = 100
        end
    elseif f2_local3 < 1 then
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
            if TorimakiAct(f2_arg1, f2_arg2, 0, 80) then
                f2_local0[7] = 100
                f2_local0[10] = 100
                f2_local0[11] = 100
                f2_local0[12] = 100
                f2_local0[13] = 100
                f2_local0[14] = 100
                f2_local0[15] = 100
            end
        elseif f2_arg1:HasSpecialEffectId(TARGET_ENE_0, 110030) then
            if TorimakiAct(f2_arg1, f2_arg2, 0, 80) then
                f2_local0[7] = 100
                f2_local0[10] = 100
                f2_local0[11] = 100
                f2_local0[12] = 100
                f2_local0[13] = 100
                f2_local0[14] = 100
                f2_local0[15] = 100
            end
        elseif f2_arg1:CheckDoesExistPath(TARGET_ENE_0, AI_DIR_TYPE_F, 0, 0) == false then
            f2_local0[7] = 100
            f2_local0[27] = 100
        elseif f2_local4 == 1 and f2_arg1:GetTeamOrder(ORDER_TYPE_Role) == ROLE_TYPE_Kankyaku then
            if KankyakuAct(f2_arg1, f2_arg2, -1, 70) then
                f2_local0[7] = 100
                f2_local0[10] = 100
                f2_local0[11] = 100
                f2_local0[12] = 100
                f2_local0[13] = 100
                f2_local0[14] = 100
                f2_local0[15] = 100
            end
        elseif f2_local4 == 1 and f2_arg1:GetTeamOrder(ORDER_TYPE_Role) == ROLE_TYPE_Torimaki then
            if TorimakiAct(f2_arg1, f2_arg2, -1, 70) then
                f2_local0[7] = 100
                f2_local0[10] = 100
                f2_local0[11] = 100
                f2_local0[12] = 100
                f2_local0[13] = 100
                f2_local0[14] = 100
                f2_local0[15] = 100
            end
        elseif f2_arg1:IsInsideTarget(TARGET_ENE_0, AI_DIR_TYPE_B, 180) then
            f2_local0[21] = 100
            f2_local0[22] = 1
        elseif f2_local3 >= 15 then
            f2_local0[26] = 100
        elseif f2_local3 >= 12 then
            f2_local0[7] = 100
            f2_local0[8] = 400
            f2_local0[10] = 100
            f2_local0[11] = 100
            f2_local0[12] = 100
            f2_local0[13] = 100
        elseif f2_local3 >= 7 then
            f2_local0[1] = 100
            f2_local0[2] = 200
            f2_local0[4] = 100
            f2_local0[5] = 100
            f2_local0[22] = 200
            f2_local0[23] = 300
        elseif f2_local3 > 5.5 then
            f2_local0[1] = 100
            f2_local0[2] = 200
            f2_local0[4] = 100
            f2_local0[5] = 100
            f2_local0[22] = 200
            f2_local0[23] = 100
            f2_local0[24] = 200
        else
            f2_local0[17] = 100
            f2_local0[22] = 10
            f2_local0[23] = 1
            f2_local0[24] = 1000
        end
    else
        f2_local0[17] = 100
    end
    if SpaceCheck(f2_arg1, f2_arg2, -60, 6.5) == false then
        f2_local0[4] = 0
        f2_local0[14] = 0
    end
    if SpaceCheck(f2_arg1, f2_arg2, -40, 5) == false and f2_local3 < 5 then
        f2_local0[4] = 0
        f2_local0[14] = 0
    end
    if SpaceCheck(f2_arg1, f2_arg2, 60, 6.5) == false then
        f2_local0[5] = 0
        f2_local0[15] = 0
    end
    if SpaceCheck(f2_arg1, f2_arg2, 40, 5) == false and f2_local3 < 5 then
        f2_local0[5] = 0
        f2_local0[15] = 0
    end
    if SpaceCheck(f2_arg1, f2_arg2, 45, 2.6) == false and SpaceCheck(f2_arg1, f2_arg2, -45, 2.6) == false then
        f2_local0[22] = 0
    end
    if SpaceCheck(f2_arg1, f2_arg2, 90, 1) == false and SpaceCheck(f2_arg1, f2_arg2, -45, 1) == false then
        f2_local0[23] = 0
    end
    if SpaceCheck(f2_arg1, f2_arg2, 180, 2.6) == false then
        f2_local0[24] = 0
    end
    if SpaceCheck(f2_arg1, f2_arg2, 180, 1) == false then
        f2_local0[25] = 0
    end
    f2_local0[1] = SetCoolTime(f2_arg1, f2_arg2, 3000, 7, f2_local0[1], 1)
    f2_local0[2] = SetCoolTime(f2_arg1, f2_arg2, 3003, 8, f2_local0[2], 1)
    f2_local0[3] = SetCoolTime(f2_arg1, f2_arg2, 3004, 7, f2_local0[3], 1)
    f2_local0[4] = SetCoolTime(f2_arg1, f2_arg2, 3001, 10, f2_local0[4], 1)
    f2_local0[5] = SetCoolTime(f2_arg1, f2_arg2, 3002, 10, f2_local0[5], 1)
    f2_local0[6] = SetCoolTime(f2_arg1, f2_arg2, 3020, 20, f2_local0[6], 1)
    f2_local0[7] = SetCoolTime(f2_arg1, f2_arg2, 3021, 20, f2_local0[7], 1)
    f2_local0[8] = SetCoolTime(f2_arg1, f2_arg2, 3022, 10, f2_local0[8], 1)
    f2_local0[10] = SetCoolTime(f2_arg1, f2_arg2, 3015, 5, f2_local0[10], 1)
    f2_local0[11] = SetCoolTime(f2_arg1, f2_arg2, 3016, 5, f2_local0[11], 1)
    f2_local0[12] = SetCoolTime(f2_arg1, f2_arg2, 3017, 5, f2_local0[12], 1)
    f2_local0[13] = SetCoolTime(f2_arg1, f2_arg2, 3018, 5, f2_local0[13], 1)
    f2_local0[14] = SetCoolTime(f2_arg1, f2_arg2, 3010, 5, f2_local0[14], 1)
    f2_local0[15] = SetCoolTime(f2_arg1, f2_arg2, 3011, 5, f2_local0[15], 1)
    f2_local1[1] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act01)
    f2_local1[2] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act02)
    f2_local1[3] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act03)
    f2_local1[4] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act04)
    f2_local1[5] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act05)
    f2_local1[6] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act06)
    f2_local1[7] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act07)
    f2_local1[8] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act08)
    f2_local1[10] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act10)
    f2_local1[11] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act11)
    f2_local1[12] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act12)
    f2_local1[13] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act13)
    f2_local1[14] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act14)
    f2_local1[15] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act15)
    f2_local1[16] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act16)
    f2_local1[17] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act17)
    f2_local1[21] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act21)
    f2_local1[22] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act22)
    f2_local1[23] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act23)
    f2_local1[24] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act24)
    f2_local1[25] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act25)
    f2_local1[26] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act26)
    f2_local1[27] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act27)
    f2_local1[28] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act28)
    local f2_local16 = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.ActAfter_AdjustSpace)
    Common_Battle_Activate(f2_arg1, f2_arg2, f2_local0, f2_local1, f2_local16, f2_local2)
    
end

Goal.Act01 = function (f3_arg0, f3_arg1, f3_arg2)
    local f3_local0 = 4.6 - f3_arg0:GetMapHitRadius(TARGET_SELF)
    local f3_local1 = 4.6 - f3_arg0:GetMapHitRadius(TARGET_SELF) + 2
    local f3_local2 = 4.6 - f3_arg0:GetMapHitRadius(TARGET_SELF) + 2
    local f3_local3 = 100
    local f3_local4 = 0
    local f3_local5 = 1.5
    local f3_local6 = 3
    Approach_Act_Flex(f3_arg0, f3_arg1, f3_local0, f3_local1, f3_local2, f3_local3, f3_local4, f3_local5, f3_local6)
    local f3_local7 = 0
    local f3_local8 = 0
    f3_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 10, 3000, TARGET_ENE_0, 9999, f3_local7, f3_local8, 0, 0)
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
    
end

Goal.Act02 = function (f4_arg0, f4_arg1, f4_arg2)
    local f4_local0 = 7.5 - f4_arg0:GetMapHitRadius(TARGET_SELF)
    local f4_local1 = 7.5 - f4_arg0:GetMapHitRadius(TARGET_SELF) + 2
    local f4_local2 = 7.5 - f4_arg0:GetMapHitRadius(TARGET_SELF) + 2
    local f4_local3 = 100
    local f4_local4 = 0
    local f4_local5 = 1.5
    local f4_local6 = 3
    Approach_Act_Flex(f4_arg0, f4_arg1, f4_local0, f4_local1, f4_local2, f4_local3, f4_local4, f4_local5, f4_local6)
    local f4_local7 = 0
    local f4_local8 = 0
    f4_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 10, 3003, TARGET_ENE_0, 9999, f4_local7, f4_local8, 0, 0)
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
    
end

Goal.Act03 = function (f5_arg0, f5_arg1, f5_arg2)
    local f5_local0 = 3.2 - f5_arg0:GetMapHitRadius(TARGET_SELF)
    local f5_local1 = 3.2 - f5_arg0:GetMapHitRadius(TARGET_SELF) + 2
    local f5_local2 = 3.2 - f5_arg0:GetMapHitRadius(TARGET_SELF) + 2
    local f5_local3 = 100
    local f5_local4 = 0
    local f5_local5 = 1.5
    local f5_local6 = 3
    Approach_Act_Flex(f5_arg0, f5_arg1, f5_local0, f5_local1, f5_local2, f5_local3, f5_local4, f5_local5, f5_local6)
    local f5_local7 = 2.4 - f5_arg0:GetMapHitRadius(TARGET_SELF) + 1
    local f5_local8 = 0
    local f5_local9 = 0
    local f5_local10 = f5_arg0:GetRandam_Int(1, 100)
    if f5_local10 <= 60 then
        f5_arg1:AddSubGoal(GOAL_COMMON_ComboAttackTunableSpin, 10, 3004, TARGET_ENE_0, f5_local7, f5_local8, f5_local9, 0, 0)
        f5_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3007, TARGET_ENE_0, 9999, 0, 0)
    else
        f5_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 10, 3004, TARGET_ENE_0, 9999, f5_local8, f5_local9, 0, 0)
    end
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
    
end

Goal.Act04 = function (f6_arg0, f6_arg1, f6_arg2)
    local f6_local0 = 6.6 - f6_arg0:GetMapHitRadius(TARGET_SELF)
    local f6_local1 = 6.6 - f6_arg0:GetMapHitRadius(TARGET_SELF) + 2
    local f6_local2 = 6.6 - f6_arg0:GetMapHitRadius(TARGET_SELF) + 2
    local f6_local3 = 100
    local f6_local4 = 0
    local f6_local5 = 1.5
    local f6_local6 = 3
    Approach_Act_Flex(f6_arg0, f6_arg1, f6_local0, f6_local1, f6_local2, f6_local3, f6_local4, f6_local5, f6_local6)
    local f6_local7 = 6.6 - f6_arg0:GetMapHitRadius(TARGET_SELF)
    local f6_local8 = 0
    local f6_local9 = 180
    local f6_local10 = f6_arg0:GetRandam_Int(1, 100)
    if SpaceCheck(f6_arg0, f6_arg1, -60, 9) == true and f6_local10 <= 40 then
        f6_arg1:AddSubGoal(GOAL_COMMON_ComboAttackTunableSpin, 10, 3005, TARGET_ENE_0, 9999, f6_local8, f6_local9, 0, 0)
        f6_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3010, TARGET_ENE_0, 9999, 0, 0)
    else
        f6_arg1:AddSubGoal(GOAL_COMMON_ComboAttackTunableSpin, 10, 3005, TARGET_ENE_0, 9999, f6_local8, f6_local9, 0, 0)
        f6_arg1:AddSubGoal(GOAL_COMMON_ComboRepeat, 10, 3010, TARGET_ENE_0, 9999, 0)
        f6_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3001, TARGET_ENE_0, 9999, 0, 0)
    end
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
    
end

Goal.Act05 = function (f7_arg0, f7_arg1, f7_arg2)
    local f7_local0 = 6.6 - f7_arg0:GetMapHitRadius(TARGET_SELF)
    local f7_local1 = 6.6 - f7_arg0:GetMapHitRadius(TARGET_SELF) + 2
    local f7_local2 = 6.6 - f7_arg0:GetMapHitRadius(TARGET_SELF) + 2
    local f7_local3 = 100
    local f7_local4 = 0
    local f7_local5 = 1.5
    local f7_local6 = 3
    Approach_Act_Flex(f7_arg0, f7_arg1, f7_local0, f7_local1, f7_local2, f7_local3, f7_local4, f7_local5, f7_local6)
    local f7_local7 = 6.6 - f7_arg0:GetMapHitRadius(TARGET_SELF)
    local f7_local8 = 0
    local f7_local9 = 180
    local f7_local10 = f7_arg0:GetRandam_Int(1, 100)
    if SpaceCheck(f7_arg0, f7_arg1, 60, 9) == true and f7_local10 <= 40 then
        f7_arg1:AddSubGoal(GOAL_COMMON_ComboAttackTunableSpin, 10, 3006, TARGET_ENE_0, 9999, f7_local8, f7_local9, 0, 0)
        f7_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3011, TARGET_ENE_0, 9999, 0, 0)
    else
        f7_arg1:AddSubGoal(GOAL_COMMON_ComboAttackTunableSpin, 10, 3006, TARGET_ENE_0, 9999, f7_local8, f7_local9, 0, 0)
        f7_arg1:AddSubGoal(GOAL_COMMON_ComboRepeat, 10, 3011, TARGET_ENE_0, 9999, 0)
        f7_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3002, TARGET_ENE_0, 9999, 0, 0)
    end
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
    
end

Goal.Act06 = function (f8_arg0, f8_arg1, f8_arg2)
    local f8_local0 = 0
    local f8_local1 = 0
    f8_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 10, 3020, TARGET_ENE_0, 9999, f8_local0, f8_local1, 0, 0)
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
    
end

Goal.Act07 = function (f9_arg0, f9_arg1, f9_arg2)
    local f9_local0 = 8 - f9_arg0:GetMapHitRadius(TARGET_SELF)
    local f9_local1 = 8 - f9_arg0:GetMapHitRadius(TARGET_SELF) + 2
    local f9_local2 = 8 - f9_arg0:GetMapHitRadius(TARGET_SELF) + 2
    local f9_local3 = 100
    local f9_local4 = 0
    local f9_local5 = 1.5
    local f9_local6 = 3
    Approach_Act_Flex(f9_arg0, f9_arg1, f9_local0, f9_local1, f9_local2, f9_local3, f9_local4, f9_local5, f9_local6)
    local f9_local7 = 0
    local f9_local8 = 0
    f9_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 10, 3021, TARGET_ENE_0, 9999, f9_local7, f9_local8, 0, 0)
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
    
end

Goal.Act08 = function (f10_arg0, f10_arg1, f10_arg2)
    local f10_local0 = 12.5 - f10_arg0:GetMapHitRadius(TARGET_SELF)
    local f10_local1 = 12.5 - f10_arg0:GetMapHitRadius(TARGET_SELF) + 2
    local f10_local2 = 12.5 - f10_arg0:GetMapHitRadius(TARGET_SELF) + 2
    local f10_local3 = 100
    local f10_local4 = 0
    local f10_local5 = 1.5
    local f10_local6 = 3
    Approach_Act_Flex(f10_arg0, f10_arg1, f10_local0, f10_local1, f10_local2, f10_local3, f10_local4, f10_local5, f10_local6)
    local f10_local7 = 4.6 - f10_arg0:GetMapHitRadius(TARGET_SELF)
    local f10_local8 = 0
    local f10_local9 = 180
    local f10_local10 = f10_arg0:GetRandam_Int(1, 100)
    f10_arg1:AddSubGoal(GOAL_COMMON_ComboAttackTunableSpin, 10, 5210, TARGET_ENE_0, f10_local7, f10_local8, f10_local9, 0, 0)
    f10_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3000, TARGET_ENE_0, 9999, 0, 0)
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
    
end

Goal.Act10 = function (f11_arg0, f11_arg1, f11_arg2)
    local f11_local0 = 0
    local f11_local1 = 0
    f11_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 10, 3015, TARGET_ENE_0, 9999, f11_local0, f11_local1, 0, 0)
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
    
end

Goal.Act11 = function (f12_arg0, f12_arg1, f12_arg2)
    local f12_local0 = 0
    local f12_local1 = 0
    if SpaceCheck(f12_arg0, f12_arg1, 180, 1.7) == true then
        f12_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 10, 3016, TARGET_ENE_0, 9999, f12_local0, f12_local1, 0, 0)
    else
        f12_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 10, 3015, TARGET_ENE_0, 9999, f12_local0, f12_local1, 0, 0)
    end
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
    
end

Goal.Act12 = function (f13_arg0, f13_arg1, f13_arg2)
    local f13_local0 = 0
    local f13_local1 = 0
    if SpaceCheck(f13_arg0, f13_arg1, -90, 1.7) == true then
        f13_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 10, 3017, TARGET_ENE_0, 9999, f13_local0, f13_local1, 0, 0)
    else
        f13_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 10, 3015, TARGET_ENE_0, 9999, f13_local0, f13_local1, 0, 0)
    end
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
    
end

Goal.Act13 = function (f14_arg0, f14_arg1, f14_arg2)
    local f14_local0 = 0
    local f14_local1 = 0
    if SpaceCheck(f14_arg0, f14_arg1, 90, 1.7) == true then
        f14_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 10, 3018, TARGET_ENE_0, 9999, f14_local0, f14_local1, 0, 0)
    else
        f14_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 10, 3015, TARGET_ENE_0, 9999, f14_local0, f14_local1, 0, 0)
    end
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
    
end

Goal.Act14 = function (f15_arg0, f15_arg1, f15_arg2)
    local f15_local0 = 0
    local f15_local1 = 180
    local f15_local2 = f15_arg0:GetRandam_Int(1, 100)
    if SpaceCheck(f15_arg0, f15_arg1, -70, 12.5) == true and f15_local2 <= 70 then
        f15_arg1:AddSubGoal(GOAL_COMMON_ComboAttackTunableSpin, 10, 3005, TARGET_ENE_0, 9999, f15_local0, f15_local1, 0, 0)
        f15_arg1:AddSubGoal(GOAL_COMMON_ComboRepeat, 10, 3010, TARGET_ENE_0, 9999, 0)
        f15_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3010, TARGET_ENE_0, 9999, 0, 0)
    else
        f15_arg1:AddSubGoal(GOAL_COMMON_ComboAttackTunableSpin, 10, 3005, TARGET_ENE_0, 9999, f15_local0, f15_local1, 0, 0)
        f15_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3010, TARGET_ENE_0, 9999, 0, 0)
    end
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
    
end

Goal.Act15 = function (f16_arg0, f16_arg1, f16_arg2)
    local f16_local0 = 0
    local f16_local1 = 180
    local f16_local2 = f16_arg0:GetRandam_Int(1, 100)
    if SpaceCheck(f16_arg0, f16_arg1, 70, 12.5) == true and f16_local2 <= 70 then
        f16_arg1:AddSubGoal(GOAL_COMMON_ComboAttackTunableSpin, 10, 3006, TARGET_ENE_0, 9999, f16_local0, f16_local1, 0, 0)
        f16_arg1:AddSubGoal(GOAL_COMMON_ComboRepeat, 10, 3011, TARGET_ENE_0, 9999, 0)
        f16_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3011, TARGET_ENE_0, 9999, 0, 0)
    else
        f16_arg1:AddSubGoal(GOAL_COMMON_ComboAttackTunableSpin, 10, 3006, TARGET_ENE_0, 9999, f16_local0, f16_local1, 0, 0)
        f16_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3011, TARGET_ENE_0, 9999, 0, 0)
    end
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
    
end

Goal.Act16 = function (f17_arg0, f17_arg1, f17_arg2)
    local f17_local0 = f17_arg0:GetDist(TARGET_ENE_0)
    if f17_arg0:CheckDoesExistPath(TARGET_LOCALPLAYER, AI_DIR_TYPE_F, 0, 0) == true then
        if f17_local0 <= 10 then
            f17_arg1:AddSubGoal(GOAL_COMMON_Wait, 1, TARGET_SELF, 0, 0, 0)
        elseif doNotRun == 1 then
            f17_arg1:AddSubGoal(GOAL_COMMON_ApproachTarget, 10.5, TARGET_LOCALPLAYER, 10, TARGET_SELF, true, -1)
        else
            f17_arg1:AddSubGoal(GOAL_COMMON_ApproachTarget, 10.5, TARGET_LOCALPLAYER, 10, TARGET_SELF, false, -1)
        end
    elseif f17_arg0:IsInsideTarget(TARGET_LOCALPLAYER, AI_DIR_TYPE_F, 90) then
        f17_arg1:AddSubGoal(GOAL_COMMON_Wait, 1, TARGET_SELF, 0, 0, 0)
    else
        f17_arg1:AddSubGoal(GOAL_COMMON_Turn, 1, TARGET_LOCALPLAYER, 0, 0, 0)
    end
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
    
end

Goal.Act17 = function (f18_arg0, f18_arg1, f18_arg2)
    local f18_local0 = 0
    local f18_local1 = 180
    local f18_local2 = f18_arg0:GetRandam_Int(1, 100)
    local f18_local3 = 9902839
    if f18_arg0:IsInsideTargetRegion(TARGET_SELF, 9902820) then
        if f18_arg0:IsInsideTargetRegion(TARGET_ENE_0, 9902812) then
            f18_local3 = 9902839
        elseif f18_arg0:IsInsideTargetRegion(TARGET_ENE_0, 9902822) then
            f18_local3 = 9902819
        elseif f18_arg0:IsInsideTargetRegion(TARGET_ENE_0, 9902821) then
            f18_local3 = 9902819
        elseif f18_arg0:IsInsideTargetRegion(TARGET_ENE_0, 9902820) then
            f18_local3 = 9902819
        else
            f18_local3 = 9902829
        end
    elseif f18_arg0:IsInsideTargetRegion(TARGET_SELF, 9902830) then
        if f18_arg0:IsInsideTargetRegion(TARGET_ENE_0, 9902822) then
            f18_local3 = 9902849
        elseif f18_arg0:IsInsideTargetRegion(TARGET_ENE_0, 9902832) then
            f18_local3 = 9902829
        elseif f18_arg0:IsInsideTargetRegion(TARGET_ENE_0, 9902831) then
            f18_local3 = 9902829
        elseif f18_arg0:IsInsideTargetRegion(TARGET_ENE_0, 9902830) then
            f18_local3 = 9902829
        else
            f18_local3 = 9902839
        end
    elseif f18_arg0:IsInsideTargetRegion(TARGET_SELF, 9902800) then
        if f18_arg0:IsInsideTargetRegion(TARGET_ENE_0, 9902802) then
            f18_local3 = 9902818
        elseif f18_arg0:IsInsideTargetRegion(TARGET_ENE_0, 9902801) then
            f18_local3 = 9902819
        elseif f18_arg0:IsInsideTargetRegion(TARGET_ENE_0, 9902800) then
            f18_local3 = 9902819
        else
            f18_local3 = 9902809
        end
    elseif f18_arg0:IsInsideTargetRegion(TARGET_SELF, 9902810) then
        if f18_arg0:IsInsideTargetRegion(TARGET_ENE_0, 9902802) then
            f18_local3 = 9902849
        elseif f18_arg0:IsInsideTargetRegion(TARGET_ENE_0, 9902812) then
            if f18_arg0:HasSpecialEffectId(TARGET_SELF, 5021) then
                f18_local3 = 9902849
            else
                f18_local3 = 9902869
            end
        elseif f18_arg0:IsInsideTargetRegion(TARGET_ENE_0, 9902816) then
            f18_local3 = 9902452
        elseif f18_arg0:IsInsideTargetRegion(TARGET_ENE_0, 9902812) then
            if f18_arg0:HasSpecialEffectId(TARGET_SELF, 5021) then
                f18_local3 = 9902849
            else
                f18_local3 = 9902869
            end
        elseif f18_arg0:IsInsideTargetRegion(TARGET_ENE_0, 9902813) then
            if f18_arg0:HasSpecialEffectId(TARGET_SELF, 5021) then
                f18_local3 = 9902869
            else
                f18_local3 = 9902809
            end
        elseif f18_arg0:IsInsideTargetRegion(TARGET_ENE_0, 9902814) then
            f18_local3 = 9902849
        else
            f18_local3 = 9902819
        end
    elseif f18_arg0:IsInsideTargetRegion(TARGET_SELF, 9902840) then
        if f18_arg0:IsInsideTargetRegion(TARGET_ENE_0, 9902832) then
            if f18_arg0:HasSpecialEffectId(TARGET_SELF, 5021) then
                f18_local3 = 9902819
            else
                f18_local3 = 9902869
            end
        elseif f18_arg0:IsInsideTargetRegion(TARGET_ENE_0, 9902813) then
            if f18_arg0:HasSpecialEffectId(TARGET_SELF, 5021) then
                f18_local3 = 9902869
            else
                f18_local3 = 9902859
            end
        elseif f18_arg0:IsInsideTargetRegion(TARGET_ENE_0, 9902842) then
            f18_local3 = 9902819
        elseif f18_arg0:IsInsideTargetRegion(TARGET_ENE_0, 9902843) or f18_arg0:IsInsideTargetRegion(TARGET_ENE_0, 9902840) then
            if f18_arg0:HasSpecialEffectId(TARGET_SELF, 5020) then
                f18_local3 = 9902859
            else
                f18_local3 = 9902839
            end
        else
            f18_local3 = 9902849
        end
    elseif f18_arg0:IsInsideTargetRegion(TARGET_SELF, 9902850) then
        if f18_arg0:IsInsideTargetRegion(TARGET_ENE_0, 9902842) then
            f18_local3 = 9902848
        elseif f18_arg0:IsInsideTargetRegion(TARGET_ENE_0, 9902850) or f18_arg0:IsInsideTargetRegion(TARGET_ENE_0, 9902851) then
            f18_local3 = 9902849
        else
            f18_local3 = 9902859
        end
    elseif f18_arg0:IsInsideTargetRegion(TARGET_SELF, 9902860) then
        if f18_arg0:IsInsideTargetRegion(TARGET_ENE_0, 9902862) then
            f18_local3 = 9902849
        elseif f18_arg0:IsInsideTargetRegion(TARGET_ENE_0, 9902863) then
            f18_local3 = 9902819
        else
            f18_local3 = 9902869
        end
    elseif f18_arg0:IsInsideTargetRegion(TARGET_SELF, 9902450) then
        if f18_arg0:IsInsideTargetRegion(TARGET_ENE_0, 9902816) then
            if f18_arg0:HasSpecialEffectId(TARGET_SELF, 5021) then
                f18_local3 = 9902828
            elseif f18_arg0:HasSpecialEffectId(TARGET_SELF, 5022) then
                f18_local3 = 9902828
            else
                f18_local3 = 9902838
            end
        else
            f18_local3 = 9902451
        end
    elseif f18_arg0:IsInsideTargetRegion(TARGET_SELF, 9902822) then
        if f18_arg0:IsInsideTargetRegion(TARGET_ENE_0, 9902822) or f18_arg0:IsInsideTargetRegion(TARGET_ENE_0, 9902820) then
            f18_local3 = 9902839
        else
            f18_local3 = 9902829
        end
    elseif f18_arg0:IsInsideTargetRegion(TARGET_SELF, 9902832) then
        if f18_arg0:IsInsideTargetRegion(TARGET_ENE_0, 9902840) or f18_arg0:IsInsideTargetRegion(TARGET_ENE_0, 9902832) then
            f18_local3 = 9902839
        else
            f18_local3 = 9902849
        end
    elseif f18_arg0:IsInsideTargetRegion(TARGET_SELF, 9902821) then
        if f18_arg0:IsInsideTargetRegion(TARGET_ENE_0, 9902825) then
            f18_local3 = 9902818
        elseif f18_arg0:IsInsideTargetRegion(TARGET_ENE_0, 9902815) then
            f18_local3 = 9902838
        elseif f18_arg0:IsInsideTargetRegion(TARGET_ENE_0, 9902821) then
            f18_local3 = 9902818
        else
            f18_local3 = 9902454
        end
    elseif f18_arg0:IsInsideTargetRegion(TARGET_SELF, 9902831) then
        if f18_arg0:IsInsideTargetRegion(TARGET_ENE_0, 9902825) then
            f18_local3 = 9902848
        elseif f18_arg0:IsInsideTargetRegion(TARGET_ENE_0, 9902835) then
            f18_local3 = 9902828
        elseif f18_arg0:IsInsideTargetRegion(TARGET_ENE_0, 9902831) then
            f18_local3 = 9902848
        else
            f18_local3 = 9902838
        end
    elseif f18_arg0:IsInsideTargetRegion(TARGET_SELF, 9902801) then
        if f18_arg0:IsInsideTargetRegion(TARGET_ENE_0, 9902800) then
            f18_local3 = 9902818
        else
            f18_local3 = 9902809
        end
    elseif f18_arg0:IsInsideTargetRegion(TARGET_SELF, 9902811) then
        if f18_arg0:IsInsideTargetRegion(TARGET_ENE_0, 9902815) then
            if f18_arg0:HasSpecialEffectId(TARGET_SELF, 5022) then
                f18_local3 = 9902868
            else
                f18_local3 = 9902868
            end
        elseif f18_arg0:IsInsideTargetRegion(TARGET_ENE_0, 9902805) then
            f18_local3 = 9902848
        elseif f18_arg0:IsInsideTargetRegion(TARGET_ENE_0, 9902816) then
            if f18_arg0:HasSpecialEffectId(TARGET_SELF, 5022) then
                f18_local3 = 9902828
            else
                f18_local3 = 9902809
            end
        elseif f18_arg0:IsInsideTargetRegion(TARGET_ENE_0, 9902817) then
            f18_local3 = 9902828
        else
            f18_local3 = 9902818
        end
    elseif f18_arg0:IsInsideTargetRegion(TARGET_SELF, 9902841) then
        if f18_arg0:IsInsideTargetRegion(TARGET_ENE_0, 9902835) then
            if f18_arg0:HasSpecialEffectId(TARGET_SELF, 5022) then
                f18_local3 = 9902818
            else
                f18_local3 = 9902859
            end
        elseif f18_arg0:IsInsideTargetRegion(TARGET_ENE_0, 9902816) then
            if f18_arg0:HasSpecialEffectId(TARGET_SELF, 5022) then
                f18_local3 = 9902868
            else
                f18_local3 = 9902859
            end
        elseif f18_arg0:IsInsideTargetRegion(TARGET_ENE_0, 9902845) then
            f18_local3 = 9902818
        elseif f18_arg0:IsInsideTargetRegion(TARGET_ENE_0, 9902846) then
            f18_local3 = 9902838
        else
            f18_local3 = 9902848
        end
    elseif f18_arg0:IsInsideTargetRegion(TARGET_SELF, 9902851) then
        if f18_arg0:IsInsideTargetRegion(TARGET_ENE_0, 9902841) or f18_arg0:IsInsideTargetRegion(TARGET_ENE_0, 9902845) then
            f18_local3 = 9902849
        else
            f18_local3 = 9902848
        end
    elseif f18_arg0:IsInsideTargetRegion(TARGET_SELF, 9902861) then
        if f18_arg0:IsInsideTargetRegion(TARGET_ENE_0, 9902817) then
            f18_local3 = 9902848
        elseif f18_arg0:IsInsideTargetRegion(TARGET_ENE_0, 9902846) then
            f18_local3 = 9902818
        elseif f18_arg0:IsInsideTargetRegion(TARGET_ENE_0, 9902884) then
            f18_local3 = 9902848
        elseif f18_arg0:IsInsideTargetRegion(TARGET_ENE_0, 9902885) then
            f18_local3 = 9902818
        else
            f18_local3 = 9902868
        end
    elseif f18_arg0:IsInsideTargetRegion(TARGET_SELF, 9902825) then
        if f18_arg0:IsInsideTargetRegion(TARGET_ENE_0, 9902821) or f18_arg0:IsInsideTargetRegion(TARGET_ENE_0, 9902815) then
            f18_local3 = 9902838
        else
            f18_local3 = 9902828
        end
    elseif f18_arg0:IsInsideTargetRegion(TARGET_SELF, 9902815) then
        if f18_arg0:IsInsideTargetRegion(TARGET_ENE_0, 9902821) or f18_arg0:IsInsideTargetRegion(TARGET_ENE_0, 9902825) then
            f18_local3 = 9902818
        else
            f18_local3 = 9902828
        end
    elseif f18_arg0:IsInsideTargetRegion(TARGET_SELF, 9902835) then
        if f18_arg0:IsInsideTargetRegion(TARGET_ENE_0, 9902831) or f18_arg0:IsInsideTargetRegion(TARGET_ENE_0, 9902825) then
            f18_local3 = 9902849
        else
            f18_local3 = 9902831
        end
    elseif f18_arg0:IsInsideTargetRegion(TARGET_SELF, 9902816) then
        if f18_arg0:IsInsideTargetRegion(TARGET_ENE_0, 9902811) or f18_arg0:IsInsideTargetRegion(TARGET_ENE_0, 9902815) then
            f18_local3 = 9902848
        elseif f18_arg0:IsInsideTargetRegion(TARGET_ENE_0, 9902841) or f18_arg0:IsInsideTargetRegion(TARGET_ENE_0, 9902835) then
            f18_local3 = 9902818
        else
            f18_local3 = 9902453
        end
    elseif f18_arg0:IsInsideTargetRegion(TARGET_SELF, 9902450) then
        if f18_arg0:IsInsideTargetRegion(TARGET_ENE_0, 9902450) then
            f18_local3 = 9902451
        else
            f18_local3 = 9902452
        end
    elseif f18_arg0:IsInsideTargetRegion(TARGET_SELF, 9902453) then
        if f18_arg0:IsInsideTargetRegion(TARGET_ENE_0, 9902453) then
            f18_local3 = 9902451
        else
            f18_local3 = 9902451
        end
    elseif f18_arg0:IsInsideTargetRegion(TARGET_SELF, 9902814) then
        if f18_arg0:IsInsideTargetRegion(TARGET_ENE_0, 9902810) or f18_arg0:IsInsideTargetRegion(TARGET_ENE_0, 9902812) then
            f18_local3 = 9902869
        else
            f18_local3 = 9902819
        end
    elseif f18_arg0:IsInsideTargetRegion(TARGET_SELF, 9902843) then
        if f18_arg0:IsInsideTargetRegion(TARGET_ENE_0, R_23) or f18_arg0:IsInsideTargetRegion(TARGET_ENE_0, 9902832) then
            f18_local3 = 9902869
        else
            f18_local3 = 9902849
        end
    elseif f18_arg0:IsInsideTargetRegion(TARGET_SELF, 9902881) then
        if f18_arg0:IsInsideTargetRegion(TARGET_ENE_0, 9902880) or f18_arg0:IsInsideTargetRegion(TARGET_ENE_0, 9902860) then
            f18_local3 = 9902849
        else
            f18_local3 = 9902869
        end
    elseif f18_arg0:IsInsideTargetRegion(TARGET_SELF, 9902880) then
        if f18_arg0:IsInsideTargetRegion(TARGET_ENE_0, 9902860) or f18_arg0:IsInsideTargetRegion(TARGET_ENE_0, 9902883) then
            f18_local3 = 9902819
        else
            f18_local3 = 9902869
        end
    elseif f18_arg0:IsInsideTargetRegion(TARGET_SELF, 2002822) and f18_arg0:IsInsideTargetRegion(TARGET_SELF, 2002830) then
        if f18_arg0:IsInsideTargetRegion(TARGET_ENE_0, c11_22) then
            if f18_arg0:HasSpecialEffectId(TARGET_SELF, 5020) then
                f18_local3 = 2002838
            elseif f18_arg0:HasSpecialEffectId(TARGET_SELF, 5021) then
                f18_local3 = 2002838
            else
                f18_local3 = 2002838
            end
        else
            f18_local3 = 2002838
        end
    elseif f18_arg0:IsInsideTargetRegion(TARGET_SELF, 2002821) then
        if f18_arg0:IsInsideTargetRegion(TARGET_ENE_0, 2002821) then
            if f18_arg0:HasSpecialEffectId(TARGET_SELF, 5020) then
                f18_local3 = 2002859
            elseif f18_arg0:HasSpecialEffectId(TARGET_SELF, 5021) then
                f18_local3 = 2002898
            else
                f18_local3 = 2002898
            end
        elseif f18_arg0:IsInsideTargetRegion(TARGET_ENE_0, 2002825) then
            if f18_arg0:HasSpecialEffectId(TARGET_SELF, 5020) then
                f18_local3 = 2002859
            elseif f18_arg0:HasSpecialEffectId(TARGET_SELF, 5021) then
                f18_local3 = 2002859
            else
                f18_local3 = 2002859
            end
        elseif f18_arg0:IsInsideTargetRegion(TARGET_ENE_0, 2002826) then
            if f18_arg0:HasSpecialEffectId(TARGET_SELF, 5020) then
                f18_local3 = 2002898
            elseif f18_arg0:HasSpecialEffectId(TARGET_SELF, 5021) then
                f18_local3 = 2002898
            else
                f18_local3 = 2002898
            end
        else
            f18_local3 = 2002829
        end
    elseif f18_arg0:IsInsideTargetRegion(TARGET_SELF, 2002831) then
        if f18_arg0:IsInsideTargetRegion(TARGET_ENE_0, 2002830) or f18_arg0:IsInsideTargetRegion(TARGET_ENE_0, 2002831) then
            if f18_arg0:HasSpecialEffectId(TARGET_SELF, 5020) then
                f18_local3 = 2002898
            elseif f18_arg0:HasSpecialEffectId(TARGET_SELF, 5021) then
                f18_local3 = 2002898
            else
                f18_local3 = 2002898
            end
        elseif f18_arg0:IsInsideTargetRegion(TARGET_ENE_0, 2002825) then
            if f18_arg0:HasSpecialEffectId(TARGET_SELF, 5020) then
                f18_local3 = 2002869
            elseif f18_arg0:HasSpecialEffectId(TARGET_SELF, 5021) then
                f18_local3 = 2002869
            else
                f18_local3 = 2002869
            end
        elseif f18_arg0:IsInsideTargetRegion(TARGET_ENE_0, 2002835) then
            if f18_arg0:HasSpecialEffectId(TARGET_SELF, 5020) then
                f18_local3 = 2002829
            elseif f18_arg0:HasSpecialEffectId(TARGET_SELF, 5021) then
                f18_local3 = 2002898
            else
                f18_local3 = 2002829
            end
        elseif f18_arg0:IsInsideTargetRegion(TARGET_ENE_0, 2002826) then
            if f18_arg0:HasSpecialEffectId(TARGET_SELF, 5020) then
                f18_local3 = 2002898
            elseif f18_arg0:HasSpecialEffectId(TARGET_SELF, 5021) then
                f18_local3 = 2002898
            else
                f18_local3 = 2002898
            end
        else
            f18_local3 = 2002839
        end
    elseif f18_arg0:IsInsideTargetRegion(TARGET_SELF, 2002563) then
        if f18_arg0:IsInsideTargetRegion(TARGET_ENE_0, 2002840) then
            if f18_arg0:HasSpecialEffectId(TARGET_SELF, 5020) then
                f18_local3 = 2002849
            elseif f18_arg0:HasSpecialEffectId(TARGET_SELF, 5021) then
                f18_local3 = 2002849
            else
                f18_local3 = 2002849
            end
        else
            f18_local3 = 2002848
        end
    elseif f18_arg0:IsInsideTargetRegion(TARGET_SELF, 2002851) then
        if f18_arg0:IsInsideTargetRegion(TARGET_ENE_0, 2002826) then
            if f18_arg0:HasSpecialEffectId(TARGET_SELF, 5020) then
                f18_local3 = 2002580
            elseif f18_arg0:HasSpecialEffectId(TARGET_SELF, 5021) then
                f18_local3 = 2002580
            else
                f18_local3 = 2002583
            end
        elseif f18_arg0:IsInsideTargetRegion(TARGET_ENE_0, 2002841) then
            if f18_arg0:HasSpecialEffectId(TARGET_SELF, 5020) then
                f18_local3 = 2002869
            elseif f18_arg0:HasSpecialEffectId(TARGET_SELF, 5021) then
                f18_local3 = 2002869
            else
                f18_local3 = 2002583
            end
        elseif f18_arg0:IsInsideTargetRegion(TARGET_ENE_0, 2002851) then
            if f18_arg0:HasSpecialEffectId(TARGET_SELF, 5020) then
                f18_local3 = 2002869
            elseif f18_arg0:HasSpecialEffectId(TARGET_SELF, 5021) then
                f18_local3 = 2002869
            else
                f18_local3 = 2002583
            end
        elseif f18_arg0:IsInsideTargetRegion(TARGET_ENE_0, 2002855) then
            if f18_arg0:HasSpecialEffectId(TARGET_SELF, 5020) then
                f18_local3 = 2002898
            elseif f18_arg0:HasSpecialEffectId(TARGET_SELF, 5021) then
                f18_local3 = 2002898
            else
                f18_local3 = 2002583
            end
        elseif f18_arg0:IsInsideTargetRegion(TARGET_ENE_0, 2002853) or f18_arg0:IsInsideTargetRegion(TARGET_ENE_0, 2002856) then
            if f18_arg0:HasSpecialEffectId(TARGET_SELF, 5020) then
                f18_local3 = 2002869
            elseif f18_arg0:HasSpecialEffectId(TARGET_SELF, 5021) then
                f18_local3 = 2002898
            else
                f18_local3 = 2002827
            end
        else
            f18_local3 = 2002859
        end
    elseif f18_arg0:IsInsideTargetRegion(TARGET_SELF, 2002856) then
        if f18_arg0:IsInsideTargetRegion(TARGET_ENE_0, 2002851) or f18_arg0:IsInsideTargetRegion(TARGET_SELF, 2002855) then
            if f18_arg0:HasSpecialEffectId(TARGET_SELF, 5020) then
                f18_local3 = 2002889
            elseif f18_arg0:HasSpecialEffectId(TARGET_SELF, 5021) then
                f18_local3 = 2002889
            else
                f18_local3 = 2002889
            end
        elseif f18_arg0:IsInsideTargetRegion(TARGET_ENE_0, 2002881) then
            if f18_arg0:HasSpecialEffectId(TARGET_SELF, 5020) then
                f18_local3 = 2002859
            elseif f18_arg0:HasSpecialEffectId(TARGET_SELF, 5021) then
                f18_local3 = 2002859
            else
                f18_local3 = 2002859
            end
        else
            f18_local3 = 2002859
        end
    elseif f18_arg0:IsInsideTargetRegion(TARGET_SELF, 2002866) then
        if f18_arg0:IsInsideTargetRegion(TARGET_ENE_0, 2002881) or f18_arg0:IsInsideTargetRegion(TARGET_ENE_0, 2002856) or f18_arg0:IsInsideTargetRegion(TARGET_ENE_0, 2002866) then
            if f18_arg0:HasSpecialEffectId(TARGET_SELF, 5020) then
                f18_local3 = 2002869
            elseif f18_arg0:HasSpecialEffectId(TARGET_SELF, 5021) then
                f18_local3 = 2002869
            else
                f18_local3 = 2002869
            end
        else
            f18_local3 = 2002889
        end
    elseif f18_arg0:IsInsideTargetRegion(TARGET_SELF, 2002861) then
        if f18_arg0:IsInsideTargetRegion(TARGET_ENE_0, 2002835) then
            if f18_arg0:HasSpecialEffectId(TARGET_SELF, 5020) then
                f18_local3 = 2002565
            elseif f18_arg0:HasSpecialEffectId(TARGET_SELF, 5021) then
                f18_local3 = 2002565
            else
                f18_local3 = 2002582
            end
        elseif f18_arg0:IsInsideTargetRegion(TARGET_ENE_0, 2002855) then
            if f18_arg0:HasSpecialEffectId(TARGET_SELF, 5020) then
                f18_local3 = 2002581
            elseif f18_arg0:HasSpecialEffectId(TARGET_SELF, 5021) then
                f18_local3 = 2002898
            else
                f18_local3 = 2002582
            end
        elseif f18_arg0:IsInsideTargetRegion(TARGET_ENE_0, 2002861) then
            if f18_arg0:HasSpecialEffectId(TARGET_SELF, 5020) then
                f18_local3 = 2002581
            elseif f18_arg0:HasSpecialEffectId(TARGET_SELF, 5021) then
                f18_local3 = 2002898
            else
                f18_local3 = 2002582
            end
        elseif f18_arg0:IsInsideTargetRegion(TARGET_ENE_0, 2002871) then
            if f18_arg0:HasSpecialEffectId(TARGET_SELF, 5020) then
                f18_local3 = 2002859
            elseif f18_arg0:HasSpecialEffectId(TARGET_SELF, 5021) then
                f18_local3 = 2002888
            else
                f18_local3 = 2002898
            end
        elseif f18_arg0:IsInsideTargetRegion(TARGET_ENE_0, 2002863) or f18_arg0:IsInsideTargetRegion(TARGET_ENE_0, 2002866) then
            if f18_arg0:HasSpecialEffectId(TARGET_SELF, 5020) then
                f18_local3 = 2002581
            elseif f18_arg0:HasSpecialEffectId(TARGET_SELF, 5021) then
                f18_local3 = 2002859
            else
                f18_local3 = 2002898
            end
        else
            f18_local3 = 2002869
        end
    elseif f18_arg0:IsInsideTargetRegion(TARGET_SELF, 2002564) then
        if f18_arg0:IsInsideTargetRegion(TARGET_ENE_0, 2002870) or f18_arg0:IsInsideTargetRegion(TARGET_ENE_0, 2002862) or f18_arg0:IsInsideTargetRegion(TARGET_ENE_0, 2002570) then
            if f18_arg0:HasSpecialEffectId(TARGET_SELF, 5020) then
                f18_local3 = 2002879
            elseif f18_arg0:HasSpecialEffectId(TARGET_SELF, 5021) then
                f18_local3 = 2002879
            else
                f18_local3 = 2002879
            end
        else
            f18_local3 = 2002878
        end
    elseif f18_arg0:IsInsideTargetRegion(TARGET_SELF, 2002581) then
        if f18_arg0:IsInsideTargetRegion(TARGET_ENE_0, 2002870) or f18_arg0:IsInsideTargetRegion(TARGET_ENE_0, 2002862) or f18_arg0:IsInsideTargetRegion(TARGET_ENE_0, 2002570) then
            if f18_arg0:HasSpecialEffectId(TARGET_SELF, 5020) then
                f18_local3 = 2002879
            elseif f18_arg0:HasSpecialEffectId(TARGET_SELF, 5021) then
                f18_local3 = 2002879
            else
                f18_local3 = 2002879
            end
        else
            f18_local3 = 2002564
        end
    elseif f18_arg0:IsInsideTargetRegion(TARGET_SELF, 2002871) then
        if f18_arg0:IsInsideTargetRegion(TARGET_ENE_0, 2002861) then
            if f18_arg0:HasSpecialEffectId(TARGET_SELF, 5020) then
                f18_local3 = 2002878
            elseif f18_arg0:HasSpecialEffectId(TARGET_SELF, 5021) then
                f18_local3 = 2002878
            else
                f18_local3 = 2002878
            end
        elseif f18_arg0:IsInsideTargetRegion(TARGET_ENE_0, 2002570) then
            if f18_arg0:HasSpecialEffectId(TARGET_SELF, 5020) then
                f18_local3 = 2002898
            elseif f18_arg0:HasSpecialEffectId(TARGET_SELF, 5021) then
                f18_local3 = 2002839
            else
                f18_local3 = 2002839
            end
        elseif f18_arg0:IsInsideTargetRegion(TARGET_ENE_0, 2002871) then
            if f18_arg0:HasSpecialEffectId(TARGET_SELF, 5020) then
                f18_local3 = 2002898
            elseif f18_arg0:HasSpecialEffectId(TARGET_SELF, 5021) then
                f18_local3 = 2002839
            else
                f18_local3 = 2002839
            end
        else
            f18_local3 = 2002879
        end
    elseif f18_arg0:IsInsideTargetRegion(TARGET_SELF, 2002881) then
        if f18_arg0:IsInsideTargetRegion(TARGET_ENE_0, 2002881) and f18_arg0:IsInsideTargetRegion(TARGET_ENE_0, 2002896) then
            if f18_arg0:HasSpecialEffectId(TARGET_SELF, 5020) then
                f18_local3 = 2002869
            elseif f18_arg0:HasSpecialEffectId(TARGET_SELF, 5021) then
                f18_local3 = 2002869
            else
                f18_local3 = 2002869
            end
        elseif f18_arg0:IsInsideTargetRegion(TARGET_ENE_0, 2002881) and f18_arg0:IsInsideTargetRegion(TARGET_ENE_0, 2002897) then
            if f18_arg0:HasSpecialEffectId(TARGET_SELF, 5020) then
                f18_local3 = 2002859
            elseif f18_arg0:HasSpecialEffectId(TARGET_SELF, 5021) then
                f18_local3 = 2002859
            else
                f18_local3 = 2002859
            end
        else
            f18_local3 = 2002889
        end
    elseif f18_arg0:IsInsideTargetRegion(TARGET_SELF, 2002553) then
        if f18_arg0:IsInsideTargetRegion(TARGET_ENE_0, 2002553) then
            if f18_arg0:HasSpecialEffectId(TARGET_SELF, 5020) then
                f18_local3 = 2002828
            elseif f18_arg0:HasSpecialEffectId(TARGET_SELF, 5021) then
                f18_local3 = 2002555
            else
                f18_local3 = 2002828
            end
        elseif f18_arg0:IsInsideTargetRegion(TARGET_ENE_0, 2002554) and f18_arg0:IsInsideTargetRegion(TARGET_ENE_0, 2002893) then
            if f18_arg0:HasSpecialEffectId(TARGET_SELF, 5020) then
                f18_local3 = 2002828
            elseif f18_arg0:HasSpecialEffectId(TARGET_SELF, 5021) then
                f18_local3 = 2002556
            else
                f18_local3 = 2002828
            end
        elseif f18_arg0:IsInsideTargetRegion(TARGET_ENE_0, 2002554) and f18_arg0:IsInsideTargetRegion(TARGET_ENE_0, 2002894) then
            if f18_arg0:HasSpecialEffectId(TARGET_SELF, 5020) then
                f18_local3 = 2002828
            elseif f18_arg0:HasSpecialEffectId(TARGET_SELF, 5021) then
                f18_local3 = 2002555
            else
                f18_local3 = 2002828
            end
        else
            f18_local3 = 2002813
        end
    elseif f18_arg0:IsInsideTargetRegion(TARGET_SELF, 2002825) then
        if f18_arg0:IsInsideTargetRegion(TARGET_ENE_0, 2002825) then
            if f18_arg0:HasSpecialEffectId(TARGET_SELF, 5020) then
                f18_local3 = 2002829
            elseif f18_arg0:HasSpecialEffectId(TARGET_SELF, 5021) then
                f18_local3 = 2002898
            else
                f18_local3 = 2002200
            end
        elseif f18_arg0:IsInsideTargetRegion(TARGET_ENE_0, 2002566) then
            if f18_arg0:HasSpecialEffectId(TARGET_SELF, 5020) then
                f18_local3 = 2002200
            elseif f18_arg0:HasSpecialEffectId(TARGET_SELF, 5021) then
                f18_local3 = 2002200
            else
                f18_local3 = 2002200
            end
        elseif f18_arg0:IsInsideTargetRegion(TARGET_ENE_0, 2002821) then
            if f18_arg0:HasSpecialEffectId(TARGET_SELF, 5020) then
                f18_local3 = 2002898
            elseif f18_arg0:HasSpecialEffectId(TARGET_SELF, 5021) then
                f18_local3 = 2002898
            else
                f18_local3 = 2002898
            end
        elseif f18_arg0:IsInsideTargetRegion(TARGET_ENE_0, 2002831) then
            if f18_arg0:HasSpecialEffectId(TARGET_SELF, 5020) then
                f18_local3 = 2002859
            elseif f18_arg0:HasSpecialEffectId(TARGET_SELF, 5021) then
                f18_local3 = 2002859
            else
                f18_local3 = 2002859
            end
        elseif f18_arg0:IsInsideTargetRegion(TARGET_ENE_0, 2002568) then
            if f18_arg0:HasSpecialEffectId(TARGET_SELF, 5020) then
                f18_local3 = 2002898
            elseif f18_arg0:HasSpecialEffectId(TARGET_SELF, 5021) then
                f18_local3 = 2002898
            else
                f18_local3 = 2002898
            end
        else
            f18_local3 = 2002827
        end
    elseif f18_arg0:IsInsideTargetRegion(TARGET_SELF, 2002855) then
        if f18_arg0:IsInsideTargetRegion(TARGET_ENE_0, 2002550) then
            if f18_arg0:HasSpecialEffectId(TARGET_SELF, 5020) then
                f18_local3 = 2002889
            elseif f18_arg0:HasSpecialEffectId(TARGET_SELF, 5021) then
                f18_local3 = 2002813
            else
                f18_local3 = 2002889
            end
        elseif f18_arg0:IsInsideTargetRegion(TARGET_ENE_0, 2002855) and f18_arg0:IsInsideTargetRegion(TARGET_ENE_0, 2002893) then
            if f18_arg0:HasSpecialEffectId(TARGET_SELF, 5020) then
                f18_local3 = 2002869
            elseif f18_arg0:HasSpecialEffectId(TARGET_SELF, 5021) then
                f18_local3 = 2002813
            else
                f18_local3 = 2002889
            end
        elseif f18_arg0:IsInsideTargetRegion(TARGET_ENE_0, 2002855) and f18_arg0:IsInsideTargetRegion(TARGET_ENE_0, 2002894) then
            if f18_arg0:HasSpecialEffectId(TARGET_SELF, 5020) then
                f18_local3 = 2002859
            elseif f18_arg0:HasSpecialEffectId(TARGET_SELF, 5021) then
                f18_local3 = 2002813
            else
                f18_local3 = 2002889
            end
        elseif f18_arg0:IsInsideTargetRegion(TARGET_ENE_0, 2002851) then
            if f18_arg0:HasSpecialEffectId(TARGET_SELF, 5020) then
                f18_local3 = 2002869
            elseif f18_arg0:HasSpecialEffectId(TARGET_SELF, 5021) then
                f18_local3 = 2002813
            else
                f18_local3 = 2002889
            end
        elseif f18_arg0:IsInsideTargetRegion(TARGET_ENE_0, 2002861) then
            if f18_arg0:HasSpecialEffectId(TARGET_SELF, 5020) then
                f18_local3 = 2002859
            elseif f18_arg0:HasSpecialEffectId(TARGET_SELF, 5021) then
                f18_local3 = 2002813
            else
                f18_local3 = 2002889
            end
        else
            f18_local3 = 2002857
        end
    elseif f18_arg0:IsInsideTargetRegion(TARGET_SELF, 2002822) then
        if f18_arg0:IsInsideTargetRegion(TARGET_ENE_0, 2002820) then
            if f18_arg0:HasSpecialEffectId(TARGET_SELF, 5020) then
                f18_local3 = 2002829
            elseif f18_arg0:HasSpecialEffectId(TARGET_SELF, 5021) then
                f18_local3 = 2002838
            else
                f18_local3 = 2002829
            end
        elseif f18_arg0:IsInsideTargetRegion(TARGET_ENE_0, 2002822) or f18_arg0:IsInsideTargetRegion(TARGET_ENE_0, 2002566) then
            if f18_arg0:HasSpecialEffectId(TARGET_SELF, 5020) then
                f18_local3 = 2002838
            elseif f18_arg0:HasSpecialEffectId(TARGET_SELF, 5021) then
                f18_local3 = 2002898
            else
                f18_local3 = 2002838
            end
        else
            f18_local3 = 2002824
        end
    elseif f18_arg0:IsInsideTargetRegion(TARGET_SELF, 2002830) then
        if f18_arg0:IsInsideTargetRegion(TARGET_ENE_0, 2002830) then
            if f18_arg0:HasSpecialEffectId(TARGET_SELF, 5020) then
                f18_local3 = 2002829
            elseif f18_arg0:HasSpecialEffectId(TARGET_SELF, 5021) then
                f18_local3 = 2002839
            else
                f18_local3 = 2002829
            end
        else
            f18_local3 = 2002838
        end
    elseif f18_arg0:IsInsideTargetRegion(TARGET_SELF, 2002853) then
        if f18_arg0:IsInsideTargetRegion(TARGET_ENE_0, 2002560) then
            if f18_arg0:HasSpecialEffectId(TARGET_SELF, 5020) then
                f18_local3 = 2002859
            elseif f18_arg0:HasSpecialEffectId(TARGET_SELF, 5021) then
                f18_local3 = 2002859
            else
                f18_local3 = 2002859
            end
        else
            f18_local3 = 2002888
        end
    elseif f18_arg0:IsInsideTargetRegion(TARGET_SELF, 2002860) then
        if f18_arg0:IsInsideTargetRegion(TARGET_ENE_0, 2002832) then
            if f18_arg0:HasSpecialEffectId(TARGET_SELF, 5020) then
                f18_local3 = 2002888
            elseif f18_arg0:HasSpecialEffectId(TARGET_SELF, 5021) then
                f18_local3 = 2002888
            else
                f18_local3 = 2002888
            end
        elseif f18_arg0:IsInsideTargetRegion(TARGET_ENE_0, 2002852) then
            if f18_arg0:HasSpecialEffectId(TARGET_SELF, 5020) then
                f18_local3 = 2002878
            elseif f18_arg0:HasSpecialEffectId(TARGET_SELF, 5021) then
                f18_local3 = 2002878
            else
                f18_local3 = 2002878
            end
        elseif f18_arg0:IsInsideTargetRegion(TARGET_ENE_0, 2002870) or f18_arg0:IsInsideTargetRegion(TARGET_ENE_0, 2002862) then
            if f18_arg0:HasSpecialEffectId(TARGET_SELF, 5020) then
                f18_local3 = 2002898
            elseif f18_arg0:HasSpecialEffectId(TARGET_SELF, 5021) then
                f18_local3 = 2002898
            else
                f18_local3 = 2002898
            end
        elseif f18_arg0:IsInsideTargetRegion(TARGET_ENE_0, 2002863) then
            if f18_arg0:HasSpecialEffectId(TARGET_SELF, 5020) then
                f18_local3 = 2002839
            elseif f18_arg0:HasSpecialEffectId(TARGET_SELF, 5021) then
                f18_local3 = 2002839
            else
                f18_local3 = 2002839
            end
        elseif f18_arg0:IsInsideTargetRegion(TARGET_ENE_0, 2002860) then
            if f18_arg0:HasSpecialEffectId(TARGET_SELF, 5020) then
                f18_local3 = 2002898
            elseif f18_arg0:HasSpecialEffectId(TARGET_SELF, 5021) then
                f18_local3 = 2002898
            else
                f18_local3 = 2002898
            end
        else
            f18_local3 = 2002868
        end
    elseif f18_arg0:IsInsideTargetRegion(TARGET_SELF, 2002863) then
        if f18_arg0:IsInsideTargetRegion(TARGET_ENE_0, 2002560) then
            if f18_arg0:HasSpecialEffectId(TARGET_SELF, 5020) then
                f18_local3 = 2002869
            elseif f18_arg0:HasSpecialEffectId(TARGET_SELF, 5021) then
                f18_local3 = 2002869
            else
                f18_local3 = 2002869
            end
        else
            f18_local3 = 2002888
        end
    elseif f18_arg0:IsInsideTargetRegion(TARGET_SELF, 2002870) then
        if f18_arg0:IsInsideTargetRegion(TARGET_ENE_0, 2002862) then
            if f18_arg0:HasSpecialEffectId(TARGET_SELF, 5020) then
                f18_local3 = 2002879
            elseif f18_arg0:HasSpecialEffectId(TARGET_SELF, 5021) then
                f18_local3 = 2002879
            else
                f18_local3 = 2002879
            end
        elseif f18_arg0:IsInsideTargetRegion(TARGET_ENE_0, 2002870) or f18_arg0:IsInsideTargetRegion(TARGET_ENE_0, 2002570) then
            if f18_arg0:HasSpecialEffectId(TARGET_SELF, 5020) then
                f18_local3 = 2002569
            elseif f18_arg0:HasSpecialEffectId(TARGET_SELF, 5021) then
                f18_local3 = 2002569
            else
                f18_local3 = 2002569
            end
        else
            f18_local3 = 2002878
        end
    elseif f18_arg0:IsInsideTargetRegion(TARGET_SELF, 2002558) then
        if f18_arg0:IsInsideTargetRegion(TARGET_ENE_0, 2002880) then
            if f18_arg0:HasSpecialEffectId(TARGET_SELF, 5020) then
                f18_local3 = 2002859
            elseif f18_arg0:HasSpecialEffectId(TARGET_SELF, 5021) then
                f18_local3 = 2002859
            else
                f18_local3 = 2002859
            end
        else
            f18_local3 = 2002888
        end
    elseif f18_arg0:IsInsideTargetRegion(TARGET_SELF, 2002559) then
        if f18_arg0:IsInsideTargetRegion(TARGET_ENE_0, 2002880) then
            if f18_arg0:HasSpecialEffectId(TARGET_SELF, 5020) then
                f18_local3 = 2002869
            elseif f18_arg0:HasSpecialEffectId(TARGET_SELF, 5021) then
                f18_local3 = 2002869
            else
                f18_local3 = 2002869
            end
        else
            f18_local3 = 2002888
        end
    elseif f18_arg0:IsInsideTargetRegion(TARGET_SELF, 2002880) then
        if f18_arg0:IsInsideTargetRegion(TARGET_ENE_0, 2002561) then
            if f18_arg0:HasSpecialEffectId(TARGET_SELF, 5020) then
                f18_local3 = 2002565
            elseif f18_arg0:HasSpecialEffectId(TARGET_SELF, 5021) then
                f18_local3 = 2002565
            else
                f18_local3 = 2002565
            end
        elseif f18_arg0:IsInsideTargetRegion(TARGET_ENE_0, 2002562) then
            if f18_arg0:HasSpecialEffectId(TARGET_SELF, 5020) then
                f18_local3 = 2002580
            elseif f18_arg0:HasSpecialEffectId(TARGET_SELF, 5021) then
                f18_local3 = 2002580
            else
                f18_local3 = 2002580
            end
        else
            f18_local3 = 2002888
        end
    elseif f18_arg0:IsInsideTargetRegion(TARGET_SELF, 2002551) then
        if f18_arg0:IsInsideTargetRegion(TARGET_ENE_0, 2002816) then
            if f18_arg0:HasSpecialEffectId(TARGET_SELF, 5020) then
                f18_local3 = 2002857
            elseif f18_arg0:HasSpecialEffectId(TARGET_SELF, 5021) then
                f18_local3 = 2002857
            else
                f18_local3 = 2002869
            end
        elseif f18_arg0:IsInsideTargetRegion(TARGET_ENE_0, 2002815) then
            if f18_arg0:HasSpecialEffectId(TARGET_SELF, 5020) then
                f18_local3 = 2002857
            elseif f18_arg0:HasSpecialEffectId(TARGET_SELF, 5021) then
                f18_local3 = 2002857
            else
                f18_local3 = 2002827
            end
        elseif f18_arg0:IsInsideTargetRegion(TARGET_ENE_0, 2002817) then
            if f18_arg0:HasSpecialEffectId(TARGET_SELF, 5020) then
                f18_local3 = 2002869
            elseif f18_arg0:HasSpecialEffectId(TARGET_SELF, 5021) then
                f18_local3 = 2002824
            else
                f18_local3 = 2002827
            end
        elseif f18_arg0:IsInsideTargetRegion(TARGET_ENE_0, 2002814) then
            if f18_arg0:HasSpecialEffectId(TARGET_SELF, 5020) then
                f18_local3 = 2002869
            elseif f18_arg0:HasSpecialEffectId(TARGET_SELF, 5021) then
                f18_local3 = 2002857
            else
                f18_local3 = 2002869
            end
        elseif f18_arg0:IsInsideTargetRegion(TARGET_ENE_0, 2002551) or f18_arg0:IsInsideTargetRegion(TARGET_ENE_0, 2002552) then
            if f18_arg0:HasSpecialEffectId(TARGET_SELF, 5020) then
                f18_local3 = 2002857
            elseif f18_arg0:HasSpecialEffectId(TARGET_SELF, 5021) then
                f18_local3 = 2002857
            else
                f18_local3 = 2002827
            end
        elseif f18_arg0:IsInsideTargetRegion(TARGET_ENE_0, 2002831) then
            if f18_arg0:HasSpecialEffectId(TARGET_SELF, 5020) then
                f18_local3 = 2002857
            elseif f18_arg0:HasSpecialEffectId(TARGET_SELF, 5021) then
                f18_local3 = 2002857
            else
                f18_local3 = 2002869
            end
        else
            f18_local3 = 2002898
        end
    elseif f18_arg0:IsInsideTargetRegion(TARGET_SELF, 2002552) then
        if f18_arg0:IsInsideTargetRegion(TARGET_ENE_0, 2002816) then
            if f18_arg0:HasSpecialEffectId(TARGET_SELF, 5020) then
                f18_local3 = 2002859
            elseif f18_arg0:HasSpecialEffectId(TARGET_SELF, 5021) then
                f18_local3 = 2002857
            else
                f18_local3 = 2002869
            end
        elseif f18_arg0:IsInsideTargetRegion(TARGET_ENE_0, 2002815) then
            if f18_arg0:HasSpecialEffectId(TARGET_SELF, 5020) then
                f18_local3 = 2002829
            elseif f18_arg0:HasSpecialEffectId(TARGET_SELF, 5021) then
                f18_local3 = 2002857
            else
                f18_local3 = 2002827
            end
        elseif f18_arg0:IsInsideTargetRegion(TARGET_ENE_0, 2002817) then
            if f18_arg0:HasSpecialEffectId(TARGET_SELF, 5020) then
                f18_local3 = 2002829
            elseif f18_arg0:HasSpecialEffectId(TARGET_SELF, 5021) then
                f18_local3 = 2002824
            else
                f18_local3 = 2002827
            end
        elseif f18_arg0:IsInsideTargetRegion(TARGET_ENE_0, 2002814) then
            if f18_arg0:HasSpecialEffectId(TARGET_SELF, 5020) then
                f18_local3 = 2002869
            elseif f18_arg0:HasSpecialEffectId(TARGET_SELF, 5021) then
                f18_local3 = 2002857
            else
                f18_local3 = 2002869
            end
        elseif f18_arg0:IsInsideTargetRegion(TARGET_ENE_0, 2002551) or f18_arg0:IsInsideTargetRegion(TARGET_ENE_0, 2002552) then
            if f18_arg0:HasSpecialEffectId(TARGET_SELF, 5020) then
                f18_local3 = 2002869
            elseif f18_arg0:HasSpecialEffectId(TARGET_SELF, 5021) then
                f18_local3 = 2002857
            else
                f18_local3 = 2002869
            end
        else
            f18_local3 = 2002898
        end
    elseif f18_arg0:IsInsideTargetRegion(TARGET_SELF, 2002835) then
        if f18_arg0:IsInsideTargetRegion(TARGET_ENE_0, 2002835) then
            if f18_arg0:HasSpecialEffectId(TARGET_SELF, 5020) then
                f18_local3 = 2002898
            elseif f18_arg0:HasSpecialEffectId(TARGET_SELF, 5021) then
                f18_local3 = 2002898
            else
                f18_local3 = 2002898
            end
        elseif f18_arg0:IsInsideTargetRegion(TARGET_ENE_0, 2002831) then
            if f18_arg0:HasSpecialEffectId(TARGET_SELF, 5020) then
                f18_local3 = 2002869
            elseif f18_arg0:HasSpecialEffectId(TARGET_SELF, 5021) then
                f18_local3 = 2002869
            else
                f18_local3 = 2002869
            end
        elseif f18_arg0:IsInsideTargetRegion(TARGET_ENE_0, 2002861) then
            if f18_arg0:HasSpecialEffectId(TARGET_SELF, 5020) then
                f18_local3 = 2002898
            elseif f18_arg0:HasSpecialEffectId(TARGET_SELF, 5021) then
                f18_local3 = 2002839
            else
                f18_local3 = 2002839
            end
        else
            f18_local3 = 2002869
        end
    elseif f18_arg0:IsInsideTargetRegion(TARGET_SELF, 2002826) then
        if f18_arg0:IsInsideTargetRegion(TARGET_ENE_0, 2002826) then
            if f18_arg0:HasSpecialEffectId(TARGET_SELF, 5020) then
                f18_local3 = 2002859
            elseif f18_arg0:HasSpecialEffectId(TARGET_SELF, 5021) then
                f18_local3 = 2002898
            else
                f18_local3 = 2002200
            end
        elseif f18_arg0:IsInsideTargetRegion(TARGET_ENE_0, 2002821) then
            if f18_arg0:HasSpecialEffectId(TARGET_SELF, 5020) then
                f18_local3 = 2002859
            elseif f18_arg0:HasSpecialEffectId(TARGET_SELF, 5021) then
                f18_local3 = 2002898
            else
                f18_local3 = 2002898
            end
        elseif f18_arg0:IsInsideTargetRegion(TARGET_ENE_0, 2002851) then
            if f18_arg0:HasSpecialEffectId(TARGET_SELF, 5020) then
                f18_local3 = 2002898
            elseif f18_arg0:HasSpecialEffectId(TARGET_SELF, 5021) then
                f18_local3 = 2002898
            else
                f18_local3 = 2002898
            end
        elseif f18_arg0:IsInsideTargetRegion(TARGET_ENE_0, 2002568) then
            if f18_arg0:HasSpecialEffectId(TARGET_SELF, 5020) then
                f18_local3 = 2002898
            elseif f18_arg0:HasSpecialEffectId(TARGET_SELF, 5021) then
                f18_local3 = 2002898
            else
                f18_local3 = 2002898
            end
        else
            f18_local3 = 2002859
        end
    elseif f18_arg0:IsInsideTargetRegion(TARGET_SELF, 2002568) then
        if f18_arg0:IsInsideTargetRegion(TARGET_ENE_0, 2002567) then
            if f18_arg0:HasSpecialEffectId(TARGET_SELF, 5020) then
                f18_local3 = 2002898
            elseif f18_arg0:HasSpecialEffectId(TARGET_SELF, 5021) then
                f18_local3 = 2002898
            else
                f18_local3 = 2002898
            end
        else
            f18_local3 = 2002200
        end
    elseif f18_arg0:IsInsideTargetRegion(TARGET_SELF, 2002567) then
        if f18_arg0:IsInsideTargetRegion(TARGET_ENE_0, 2002567) and f18_arg0:IsInsideTargetRegion(TARGET_ENE_0, 2002890) then
            if f18_arg0:HasSpecialEffectId(TARGET_SELF, 5020) then
                f18_local3 = 2002839
            elseif f18_arg0:HasSpecialEffectId(TARGET_SELF, 5021) then
                f18_local3 = 2002839
            else
                f18_local3 = 2002839
            end
        elseif f18_arg0:IsInsideTargetRegion(TARGET_ENE_0, 2002567) and f18_arg0:IsInsideTargetRegion(TARGET_ENE_0, 2002891) then
            if f18_arg0:HasSpecialEffectId(TARGET_SELF, 5020) then
                f18_local3 = 2002829
            elseif f18_arg0:HasSpecialEffectId(TARGET_SELF, 5021) then
                f18_local3 = 2002829
            else
                f18_local3 = 2002829
            end
        else
            f18_local3 = 2002200
        end
    else
        f18_local3 = 2002898
    end
    f18_arg0:SetEventMoveTarget(f18_local3)
    local f18_local4 = f18_arg0:GetDist(POINT_EVENT)
    if f18_local4 > 0.7 then
        f18_arg0:SetTimer(0, 7)
        f18_arg1:AddSubGoal(GOAL_COMMON_ApproachTarget, 10, POINT_EVENT, 1.2, TARGET_SELF, false, -1)
        f18_arg0:SetStringIndexedNumber("timerRestart", 1)
    elseif f18_arg0:IsInsideTarget(TARGET_ENE_0, AI_DIR_TYPE_F, 60) then
        f18_arg1:AddSubGoal(GOAL_COMMON_Wait, 0.3, TARGET_ENE_0, 0, 0, 0)
        local f18_local5 = 0
        if f18_arg0:IsVisibleTarget(TARGET_ENE_0) then
            f18_arg0:SetStringIndexedNumber("timerRestart", 1)
            f18_local5 = 1
        elseif f18_arg0:GetStringIndexedNumber("timerRestart") == 1 then
            f18_arg0:SetTimer(0, 7)
            f18_arg0:SetStringIndexedNumber("timerRestart", 0)
        elseif f18_arg0:IsFinishTimer(0) and f18_local5 == 0 then
            f18_arg0:ClearEnemyTarget()
            f18_arg0:ClearSoundTarget()
            f18_arg0:Replanning()
        end
    else
        f18_arg1:AddSubGoal(GOAL_COMMON_Turn, 0.3, TARGET_ENE_0, 0, 0, 0)
    end
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
    
end

Goal.Act21 = function (f19_arg0, f19_arg1, f19_arg2)
    local f19_local0 = 3
    local f19_local1 = 45
    f19_arg1:AddSubGoal(GOAL_COMMON_Turn, f19_local0, TARGET_ENE_0, f19_local1, -1, GOAL_RESULT_Success, true)
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
    
end

Goal.Act22 = function (f20_arg0, f20_arg1, f20_arg2)
    local f20_local0 = 3
    local f20_local1 = 0
    local f20_local2 = f20_arg0:GetRandam_Int(1, 100)
    if SpaceCheck(f20_arg0, f20_arg1, -45, 2.6) == true then
        if SpaceCheck(f20_arg0, f20_arg1, 45, 2.6) == true then
            if f20_arg0:IsInsideTarget(TARGET_ENE_0, AI_DIR_TYPE_R, 180) then
                if SpaceCheck(f20_arg0, f20_arg1, -60, 5) == true and f20_local2 <= 60 then
                    f20_arg1:AddSubGoal(GOAL_COMMON_SpinStep, f20_local0, 5212, TARGET_ENE_0, f20_local1, AI_DIR_TYPE_L, 0)
                else
                    f20_arg1:AddSubGoal(GOAL_COMMON_SpinStep, f20_local0, 5202, TARGET_ENE_0, f20_local1, AI_DIR_TYPE_L, 0)
                end
            elseif SpaceCheck(f20_arg0, f20_arg1, 60, 5) == true and f20_local2 <= 60 then
                f20_arg1:AddSubGoal(GOAL_COMMON_SpinStep, f20_local0, 5213, TARGET_ENE_0, f20_local1, AI_DIR_TYPE_L, 0)
            else
                f20_arg1:AddSubGoal(GOAL_COMMON_SpinStep, f20_local0, 5203, TARGET_ENE_0, f20_local1, AI_DIR_TYPE_L, 0)
            end
        elseif SpaceCheck(f20_arg0, f20_arg1, -60, 5) == true and f20_local2 <= 60 then
            f20_arg1:AddSubGoal(GOAL_COMMON_SpinStep, f20_local0, 5212, TARGET_ENE_0, f20_local1, AI_DIR_TYPE_L, 0)
        else
            f20_arg1:AddSubGoal(GOAL_COMMON_SpinStep, f20_local0, 5202, TARGET_ENE_0, f20_local1, AI_DIR_TYPE_L, 0)
        end
    elseif SpaceCheck(f20_arg0, f20_arg1, 45, 2.6) == true then
        f20_arg1:AddSubGoal(GOAL_COMMON_SpinStep, f20_local0, 5203, TARGET_ENE_0, f20_local1, AI_DIR_TYPE_R, 0)
    else
    end
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
    
end

Goal.Act23 = function (f21_arg0, f21_arg1, f21_arg2)
    local f21_local0 = f21_arg0:GetDist(TARGET_ENE_0)
    local f21_local1 = f21_arg0:GetSp(TARGET_SELF)
    local f21_local2 = 20
    local f21_local3 = f21_arg0:GetRandam_Int(1, 100)
    local f21_local4 = -1
    local f21_local5 = 0
    if SpaceCheck(f21_arg0, f21_arg1, -90, 1) == true then
        if SpaceCheck(f21_arg0, f21_arg1, 90, 1) == true then
            if f21_arg0:IsInsideTarget(TARGET_ENE_0, AI_DIR_TYPE_R, 180) then
                f21_local5 = 0
            else
                f21_local5 = 1
            end
        else
            f21_local5 = 0
        end
    elseif SpaceCheck(f21_arg0, f21_arg1, 90, 1) == true then
        f21_local5 = 1
    else
    end
    local f21_local6 = 3
    local f21_local7 = f21_arg0:GetRandam_Int(30, 45)
    f21_arg0:SetNumber(10, f21_local5)
    f21_arg1:AddSubGoal(GOAL_COMMON_SidewayMove, f21_local6, TARGET_ENE_0, f21_local5, f21_local7, true, true, f21_local4):TimingSetTimer(2, 4, UPDATE_SUCCESS)
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
    
end

Goal.Act24 = function (f22_arg0, f22_arg1, f22_arg2)
    local f22_local0 = f22_arg0:GetDist(TARGET_ENE_0)
    local f22_local1 = 3
    local f22_local2 = 0
    local f22_local3 = 5201
    local f22_local4 = f22_arg0:GetRandam_Int(1, 100)
    if SpaceCheck(f22_arg0, f22_arg1, 180, 2.6) == true and SpaceCheck(f22_arg0, f22_arg1, 180, 5) == true and f22_local0 < 4 and f22_local4 < 60 then
        f22_local3 = 5211
        if false and false then
        else
        end
    end
    f22_arg1:AddSubGoal(GOAL_COMMON_SpinStep, f22_local1, f22_local3, TARGET_ENE_0, f22_local2, AI_DIR_TYPE_B, 0)
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
    
end

Goal.Act25 = function (f23_arg0, f23_arg1, f23_arg2)
    local f23_local0 = f23_arg0:GetRandam_Float(2, 4)
    local f23_local1 = f23_arg0:GetRandam_Float(1, 3)
    local f23_local2 = f23_arg0:GetDist(TARGET_ENE_0)
    local f23_local3 = -1
    if SpaceCheck(f23_arg0, f23_arg1, 180, 1) == true then
        f23_arg1:AddSubGoal(GOAL_COMMON_LeaveTarget, f23_local0, TARGET_ENE_0, f23_local1, TARGET_ENE_0, true, f23_local3)
    else
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
    local f25_local0 = f25_arg0:GetDist(TARGET_ENE_0)
    local f25_local1 = f25_arg0:GetDistYSigned(TARGET_ENE_0)
    local f25_local2 = f25_local1 / math.tan(math.deg(30))
    local f25_local3 = f25_arg0:GetRandam_Int(0, 1)
    if f25_local1 >= 3 then
        if f25_local2 + 1 <= f25_local0 then
            if SpaceCheck(f25_arg0, f25_arg1, 0, 4) == true then
                f25_arg1:AddSubGoal(GOAL_COMMON_ApproachTarget, 0.1, TARGET_ENE_0, f25_local2, TARGET_SELF, false, -1)
            elseif SpaceCheck(f25_arg0, f25_arg1, 0, 3) == true then
                f25_arg1:AddSubGoal(GOAL_COMMON_ApproachTarget, 0.5, TARGET_ENE_0, f25_local2, TARGET_SELF, true, -1)
            end
        elseif f25_local0 <= f25_local2 - 1 then
            f25_arg1:AddSubGoal(GOAL_COMMON_LeaveTarget, 10, TARGET_ENE_0, f25_local2, TARGET_ENE_0, true, -1)
        end
    elseif SpaceCheck(f25_arg0, f25_arg1, 0, 4) == true then
        f25_arg1:AddSubGoal(GOAL_COMMON_ApproachTarget, 0.1, TARGET_ENE_0, 0, TARGET_SELF, false, -1)
    elseif SpaceCheck(f25_arg0, f25_arg1, 0, 3) == true then
        f25_arg1:AddSubGoal(GOAL_COMMON_ApproachTarget, 0.5, TARGET_ENE_0, 0, TARGET_SELF, true, -1)
    elseif SpaceCheck(f25_arg0, f25_arg1, 0, 1) == false then
        f25_arg1:AddSubGoal(GOAL_COMMON_LeaveTarget, 0.5, TARGET_ENE_0, 999, TARGET_ENE_0, true, -1)
    end
    f25_arg0:SetNumber(10, f25_local3)
    f25_arg1:AddSubGoal(GOAL_COMMON_SidewayMove, 3, TARGET_ENE_0, f25_local3, f25_arg0:GetRandam_Int(30, 45), true, true, -1)
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
    
end

Goal.Act28 = function (f26_arg0, f26_arg1, f26_arg2)
    local f26_local0 = f26_arg0:GetDist(TARGET_ENE_0)
    local f26_local1 = 1.5
    local f26_local2 = 1.5
    local f26_local3 = f26_arg0:GetRandam_Int(30, 45)
    local f26_local4 = -1
    local f26_local5 = f26_arg0:GetRandam_Int(0, 1)
    if f26_local0 <= 3 then
        f26_arg1:AddSubGoal(GOAL_COMMON_SidewayMove, f26_local1, TARGET_ENE_0, f26_local5, f26_local3, true, true, f26_local4)
    elseif f26_local0 <= 8 then
        f26_arg1:AddSubGoal(GOAL_COMMON_ApproachTarget, f26_local2, TARGET_ENE_0, 3, TARGET_SELF, true, -1)
    else
        f26_arg1:AddSubGoal(GOAL_COMMON_ApproachTarget, f26_local2, TARGET_ENE_0, 8, TARGET_SELF, false, -1)
    end
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
    
end

Goal.Interrupt = function (f27_arg0, f27_arg1, f27_arg2)
    local f27_local0 = f27_arg1:GetSpecialEffectActivateInterruptType(0)
    if f27_arg1:IsLadderAct(TARGET_SELF) then
        return false
    end
    if not f27_arg1:HasSpecialEffectId(TARGET_SELF, 200004) then
        return false
    end
    if f27_arg1:IsInterupt(INTERUPT_Damaged) then
        return f27_arg0.Damaged(f27_arg1, f27_arg2)
    end
    if f27_arg1:IsInterupt(INTERUPT_Inside_ObserveArea) and f27_arg1:IsInsideObserve(0) then
        f27_arg1:Replanning()
        f27_arg1:DeleteObserve(0)
        return true
    end
    if f27_arg1:IsInterupt(INTERUPT_ActivateSpecialEffect) then
        if f27_local0 == 5026 then
            f27_arg1:ClearEnemyTarget()
            f27_arg1:ClearSoundTarget()
            f27_arg1:Replanning()
            return true
        elseif f27_arg1:HasSpecialEffectId(TARGET_ENE_0, 3126070) and f27_arg1:HasSpecialEffectId(TARGET_SELF, 5023) then
            f27_arg2:ClearSubGoal()
            f27_arg1:Replanning()
            return true
        elseif f27_arg1:GetSpecialEffectActivateInterruptType(0) == 5025 and f27_arg1:HasSpecialEffectId(TARGET_ENE_0, 3125000) then
            f27_arg2:ClearSubGoal()
            f27_arg2:AddSubGoal(GOAL_COMMON_ComboFinal, 0.5, 3008, TARGET_ENE_0, 9999, 0, 0)
            return true
        elseif f27_local0 == 3126000 then
            f27_arg2:ClearSubGoal()
            f27_arg1:ClearEnemyTarget()
            f27_arg1:ClearSoundTarget()
            f27_arg1:ClearIndicationPosTarget()
            f27_arg1:ClearLastMemoryTargetPos()
            f27_arg1:Replanning()
            return true
        end
    end
    return false
    
end

Goal.Parry = function (f28_arg0, f28_arg1, f28_arg2)
    local f28_local0 = f28_arg0:GetHpRate(TARGET_SELF)
    local f28_local1 = f28_arg0:GetDist(TARGET_ENE_0)
    local f28_local2 = f28_arg0:GetSp(TARGET_SELF)
    local f28_local3 = f28_arg0:GetRandam_Int(1, 100)
    local f28_local4 = 0
    if not f28_arg0:IsInsideTarget(TARGET_ENE_0, AI_DIR_TYPE_F, 90) or not f28_arg0:IsInsideTargetEx(TARGET_ENE_0, TARGET_SELF, AI_DIR_TYPE_F, 90, 3) or f28_arg0:HasSpecialEffectId(TARGET_ENE_0, 109012) then
    elseif f28_arg0:IsTargetGuard(TARGET_SELF) then
        if f28_arg0:HasSpecialEffectId(TARGET_ENE_0, 109970) and false then
        end
    elseif f28_arg0:HasSpecialEffectId(TARGET_ENE_0, 109970) then
    else
    end
    return false
    
end

Goal.ActAfter_AdjustSpace = function (f29_arg0, f29_arg1, f29_arg2)
    
end

Goal.Update = function (f30_arg0, f30_arg1, f30_arg2)
    return Update_Default_NoSubGoal(f30_arg0, f30_arg1, f30_arg2)
    
end

Goal.Terminate = function (f31_arg0, f31_arg1, f31_arg2)
    
end


