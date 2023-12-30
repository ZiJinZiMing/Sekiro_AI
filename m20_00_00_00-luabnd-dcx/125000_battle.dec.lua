﻿RegisterTableGoal(GOAL_YashazaruKenzoku_sude_125000_Battle, "GOAL_YashazaruKenzoku_sude_125000_Battle")
REGISTER_GOAL_NO_UPDATE(GOAL_YashazaruKenzoku_sude_125000_Battle, true)

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
    local f2_local5 = Check_ReachAttack(f2_arg1, 0)
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
    elseif f2_local5 ~= POSSIBLE_ATTACK then
        if f2_local4 == 1 and f2_arg1:GetTeamOrder(ORDER_TYPE_Role) == ROLE_TYPE_Kankyaku then
            f2_local0[27] = 100
        elseif f2_local4 == 1 and f2_arg1:GetTeamOrder(ORDER_TYPE_Role) == ROLE_TYPE_Torimaki then
            f2_local0[27] = 100
        elseif f2_local5 == UNREACH_ATTACK then
            f2_local0[6] = 100
            f2_local0[7] = 100
            f2_local0[27] = 100
        elseif f2_local5 == REACH_ATTACK_TARGET_HIGH_POSITION then
            f2_local0[1] = 100
            f2_local0[3] = 100
            f2_local0[27] = 100
        elseif f2_local5 == REACH_ATTACK_TARGET_LOW_POSITION then
            f2_local0[1] = 100
            f2_local0[3] = 100
            f2_local0[27] = 100
        else
            f2_local0[27] = 100
        end
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
        if TorimakiAct(f2_arg1, f2_arg2, -1, 80) then
            f2_local0[6] = 100
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
    elseif f2_local3 >= 12 then
        f2_local0[6] = 100
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
    elseif f2_local3 > 4 then
        f2_local0[1] = 100
        f2_local0[2] = 200
        f2_local0[4] = 100
        f2_local0[5] = 100
        f2_local0[6] = 80
        f2_local0[22] = 200
        f2_local0[23] = 100
        f2_local0[24] = 200
    else
        f2_local0[1] = 200
        f2_local0[3] = 200
        f2_local0[4] = 100
        f2_local0[5] = 100
        f2_local0[24] = 400
    end
    if f2_arg1:HasSpecialEffectId(TARGET_SELF, 200050) then
        f2_local0[6] = 0
    elseif f2_arg1:HasSpecialEffectId(TARGET_SELF, 3125041) then
        if f2_arg1:HasSpecialEffectId(TARGET_SELF, 4000) then
            f2_local0[1] = f2_local0[1] * 0.2
            f2_local0[2] = f2_local0[2] * 0.2
            f2_local0[3] = f2_local0[3] * 0.2
            f2_local0[6] = f2_local0[6] * 5
        else
            f2_local0[6] = 0
        end
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
    if SpaceCheck(f2_arg1, f2_arg2, 90, 1) == false and SpaceCheck(f2_arg1, f2_arg2, -90, 1) == false then
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
    f2_local0[6] = SetCoolTime(f2_arg1, f2_arg2, 3020, 8, f2_local0[6], 1)
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
    f2_local1[21] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act21)
    f2_local1[22] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act22)
    f2_local1[23] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act23)
    f2_local1[24] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act24)
    f2_local1[25] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act25)
    f2_local1[26] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act26)
    f2_local1[27] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act27)
    f2_local1[28] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act28)
    local f2_local6 = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.ActAfter_AdjustSpace)
    Common_Battle_Activate(f2_arg1, f2_arg2, f2_local0, f2_local1, f2_local6, f2_local2)
    
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

Goal.Act21 = function (f17_arg0, f17_arg1, f17_arg2)
    local f17_local0 = 3
    local f17_local1 = 45
    f17_arg1:AddSubGoal(GOAL_COMMON_Turn, f17_local0, TARGET_ENE_0, f17_local1, -1, GOAL_RESULT_Success, true)
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
    
end

Goal.Act22 = function (f18_arg0, f18_arg1, f18_arg2)
    local f18_local0 = 3
    local f18_local1 = 0
    local f18_local2 = f18_arg0:GetRandam_Int(1, 100)
    if SpaceCheck(f18_arg0, f18_arg1, -45, 2.6) == true then
        if SpaceCheck(f18_arg0, f18_arg1, 45, 2.6) == true then
            if f18_arg0:IsInsideTarget(TARGET_ENE_0, AI_DIR_TYPE_R, 180) then
                if SpaceCheck(f18_arg0, f18_arg1, -60, 5) == true and f18_local2 <= 60 then
                    f18_arg1:AddSubGoal(GOAL_COMMON_SpinStep, f18_local0, 5212, TARGET_ENE_0, f18_local1, AI_DIR_TYPE_L, 0)
                else
                    f18_arg1:AddSubGoal(GOAL_COMMON_SpinStep, f18_local0, 5202, TARGET_ENE_0, f18_local1, AI_DIR_TYPE_L, 0)
                end
            elseif SpaceCheck(f18_arg0, f18_arg1, 60, 5) == true and f18_local2 <= 60 then
                f18_arg1:AddSubGoal(GOAL_COMMON_SpinStep, f18_local0, 5213, TARGET_ENE_0, f18_local1, AI_DIR_TYPE_L, 0)
            else
                f18_arg1:AddSubGoal(GOAL_COMMON_SpinStep, f18_local0, 5203, TARGET_ENE_0, f18_local1, AI_DIR_TYPE_L, 0)
            end
        elseif SpaceCheck(f18_arg0, f18_arg1, -60, 5) == true and f18_local2 <= 60 then
            f18_arg1:AddSubGoal(GOAL_COMMON_SpinStep, f18_local0, 5212, TARGET_ENE_0, f18_local1, AI_DIR_TYPE_L, 0)
        else
            f18_arg1:AddSubGoal(GOAL_COMMON_SpinStep, f18_local0, 5202, TARGET_ENE_0, f18_local1, AI_DIR_TYPE_L, 0)
        end
    elseif SpaceCheck(f18_arg0, f18_arg1, 45, 2.6) == true then
        f18_arg1:AddSubGoal(GOAL_COMMON_SpinStep, f18_local0, 5203, TARGET_ENE_0, f18_local1, AI_DIR_TYPE_R, 0)
    else
        f18_arg1:AddSubGoal(GOAL_COMMON_SpinStep, f18_local0, 5203, TARGET_ENE_0, f18_local1, AI_DIR_TYPE_R, 0)
    end
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
    
end

Goal.Act23 = function (f19_arg0, f19_arg1, f19_arg2)
    local f19_local0 = f19_arg0:GetDist(TARGET_ENE_0)
    local f19_local1 = f19_arg0:GetSp(TARGET_SELF)
    local f19_local2 = 20
    local f19_local3 = f19_arg0:GetRandam_Int(1, 100)
    local f19_local4 = -1
    local f19_local5 = 0
    if SpaceCheck(f19_arg0, f19_arg1, -90, 1) == true then
        if SpaceCheck(f19_arg0, f19_arg1, 90, 1) == true then
            if f19_arg0:IsInsideTarget(TARGET_ENE_0, AI_DIR_TYPE_R, 180) then
                f19_local5 = 0
            else
                f19_local5 = 1
            end
        else
            f19_local5 = 0
        end
    elseif SpaceCheck(f19_arg0, f19_arg1, 90, 1) == true then
        f19_local5 = 1
    else
    end
    local f19_local6 = 3
    local f19_local7 = f19_arg0:GetRandam_Int(30, 45)
    f19_arg0:SetNumber(10, f19_local5)
    f19_arg1:AddSubGoal(GOAL_COMMON_SidewayMove, f19_local6, TARGET_ENE_0, f19_local5, f19_local7, true, true, f19_local4):TimingSetTimer(2, 4, UPDATE_SUCCESS)
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
    
end

Goal.Act24 = function (f20_arg0, f20_arg1, f20_arg2)
    local f20_local0 = f20_arg0:GetDist(TARGET_ENE_0)
    local f20_local1 = 3
    local f20_local2 = 0
    local f20_local3 = 5201
    local f20_local4 = f20_arg0:GetRandam_Int(1, 100)
    if SpaceCheck(f20_arg0, f20_arg1, 180, 2.6) == true and SpaceCheck(f20_arg0, f20_arg1, 180, 5) == true and f20_local0 < 4 and f20_local4 < 60 then
        f20_local3 = 5211
        if false and false then
        else
        end
    end
    f20_arg1:AddSubGoal(GOAL_COMMON_SpinStep, f20_local1, f20_local3, TARGET_ENE_0, f20_local2, AI_DIR_TYPE_B, 0)
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
    
end

Goal.Act25 = function (f21_arg0, f21_arg1, f21_arg2)
    local f21_local0 = f21_arg0:GetRandam_Float(2, 4)
    local f21_local1 = f21_arg0:GetRandam_Float(1, 3)
    local f21_local2 = f21_arg0:GetDist(TARGET_ENE_0)
    local f21_local3 = -1
    if SpaceCheck(f21_arg0, f21_arg1, 180, 1) == true then
        f21_arg1:AddSubGoal(GOAL_COMMON_LeaveTarget, f21_local0, TARGET_ENE_0, f21_local1, TARGET_ENE_0, true, f21_local3)
    else
    end
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
    
end

Goal.Act26 = function (f22_arg0, f22_arg1, f22_arg2)
    f22_arg1:AddSubGoal(GOAL_COMMON_Wait, 0.5, TARGET_SELF, 0, 0, 0)
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
    
end

Goal.Act27 = function (f23_arg0, f23_arg1, f23_arg2)
    local f23_local0 = f23_arg0:GetRandam_Int(1, 100)
    if YousumiAct_SubGoal(f23_arg0, f23_arg1, true, 60, 30) == false then
        GetWellSpace_Odds = 0
        return GetWellSpace_Odds
    end
    local f23_local1 = 0
    local f23_local2 = SpaceCheck_SidewayMove(f23_arg0, f23_arg1, 1)
    if f23_local2 == 0 then
        f23_local1 = 0
    elseif f23_local2 == 1 then
        f23_local1 = 1
    elseif f23_local2 == 2 then
        if f23_local0 <= 50 then
            f23_local1 = 0
        else
            f23_local1 = 1
        end
    else
        f23_arg1:AddSubGoal(GOAL_COMMON_Wait, 0.5, TARGET_SELF, 0, 0, 0)
        GetWellSpace_Odds = 0
        return GetWellSpace_Odds
    end
    f23_arg0:SetNumber(10, f23_local1)
    f23_arg1:AddSubGoal(GOAL_COMMON_SidewayMove, 3, TARGET_ENE_0, f23_local1, f23_arg0:GetRandam_Int(30, 45), true, true, -1)
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
    
end

Goal.Act28 = function (f24_arg0, f24_arg1, f24_arg2)
    local f24_local0 = f24_arg0:GetDist(TARGET_ENE_0)
    local f24_local1 = 1.5
    local f24_local2 = 1.5
    local f24_local3 = f24_arg0:GetRandam_Int(30, 45)
    local f24_local4 = -1
    local f24_local5 = f24_arg0:GetRandam_Int(0, 1)
    if f24_local0 <= 3 then
        f24_arg1:AddSubGoal(GOAL_COMMON_SidewayMove, f24_local1, TARGET_ENE_0, f24_local5, f24_local3, true, true, f24_local4)
    elseif f24_local0 <= 8 then
        f24_arg1:AddSubGoal(GOAL_COMMON_ApproachTarget, f24_local2, TARGET_ENE_0, 3, TARGET_SELF, true, -1)
    else
        f24_arg1:AddSubGoal(GOAL_COMMON_ApproachTarget, f24_local2, TARGET_ENE_0, 8, TARGET_SELF, false, -1)
    end
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
    
end

Goal.Interrupt = function (f25_arg0, f25_arg1, f25_arg2)
    local f25_local0 = f25_arg1:GetSpecialEffectActivateInterruptType(0)
    if f25_arg1:IsLadderAct(TARGET_SELF) then
        return false
    end
    if not f25_arg1:HasSpecialEffectId(TARGET_SELF, 200004) then
        return false
    end
    if f25_arg1:IsInterupt(INTERUPT_Damaged) then
        return f25_arg0.Damaged(f25_arg1, f25_arg2)
    end
    if f25_arg1:IsInterupt(INTERUPT_ActivateSpecialEffect) then
        if f25_arg1:GetSpecialEffectActivateInterruptType(0) == 5025 and f25_arg1:HasSpecialEffectId(TARGET_ENE_0, 3125000) then
            f25_arg2:ClearSubGoal()
            f25_arg2:AddSubGoal(GOAL_COMMON_ComboFinal, 0.5, 3008, TARGET_ENE_0, 9999, 0, 0)
            return true
        end
        return false
    end
    return false
    
end

Goal.Parry = function (f26_arg0, f26_arg1, f26_arg2)
    local f26_local0 = f26_arg0:GetHpRate(TARGET_SELF)
    local f26_local1 = f26_arg0:GetDist(TARGET_ENE_0)
    local f26_local2 = f26_arg0:GetSp(TARGET_SELF)
    local f26_local3 = f26_arg0:GetRandam_Int(1, 100)
    local f26_local4 = 0
    if not f26_arg0:IsInsideTarget(TARGET_ENE_0, AI_DIR_TYPE_F, 90) or not f26_arg0:IsInsideTargetEx(TARGET_ENE_0, TARGET_SELF, AI_DIR_TYPE_F, 90, 3) or f26_arg0:HasSpecialEffectId(TARGET_ENE_0, 109012) then
    elseif f26_arg0:IsTargetGuard(TARGET_SELF) then
        if f26_arg0:HasSpecialEffectId(TARGET_ENE_0, 109970) and false then
        end
    elseif f26_arg0:HasSpecialEffectId(TARGET_ENE_0, 109970) then
    else
    end
    return false
    
end

Goal.Damaged = function (f27_arg0, f27_arg1, f27_arg2)
    local f27_local0 = f27_arg0:GetHpRate(TARGET_SELF)
    local f27_local1 = f27_arg0:GetDist(TARGET_ENE_0)
    local f27_local2 = f27_arg0:GetSp(TARGET_SELF)
    local f27_local3 = f27_arg0:GetRandam_Int(1, 100)
    local f27_local4 = 0
    if f27_local3 <= 33 then
        f27_arg1:ClearSubGoal()
        f27_arg1:AddSubGoal(GOAL_COMMON_SpinStep, 3, 5201, TARGET_ENE_0, TurnTime, AI_DIR_TYPE_B, 0):TimingSetTimer(3, 6, UPDATE_SUCCESS)
        return true
    elseif f27_local3 <= 67 then
    end
    return false
    
end

Goal.ActAfter_AdjustSpace = function (f28_arg0, f28_arg1, f28_arg2)
    
end

Goal.Update = function (f29_arg0, f29_arg1, f29_arg2)
    return Update_Default_NoSubGoal(f29_arg0, f29_arg1, f29_arg2)
    
end

Goal.Terminate = function (f30_arg0, f30_arg1, f30_arg2)
    
end

RegisterTableGoal(GOAL_YashazaruKenzoku_sude_125000_AfterAttackAct, "GOAL_YashazaruKenzoku_sude_125000_AfterAttackAct")
REGISTER_GOAL_NO_SUB_GOAL(GOAL_YashazaruKenzoku_sude_125000_AfterAttackAct, true)

Goal.Activate = function (f31_arg0, f31_arg1, f31_arg2)
    
end

Goal.Update = function (f32_arg0, f32_arg1, f32_arg2)
    return Update_Default_NoSubGoal(f32_arg0, f32_arg1, f32_arg2)
    
end


