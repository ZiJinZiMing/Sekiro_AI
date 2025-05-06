﻿RegisterTableGoal(GOAL_Genpeimusya_naginata_131010_Battle, "GOAL_Genpeimusya_naginata_131010_Battle")
REGISTER_GOAL_NO_UPDATE(GOAL_Genpeimusya_naginata_131010_Battle, true)

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
    local f2_local6 = f2_arg1:GetSpRate(TARGET_SELF)
    local f2_local7 = Check_ReachAttack(f2_arg1, 0)
    f2_arg1:AddObserveSpecialEffectAttribute(TARGET_SELF, 5025)
    Set_ConsecutiveGuardCount_Interrupt(f2_arg1)
    f2_arg1:DeleteObserve(0)
    f2_arg1:DeleteObserve(1)
    if f2_arg0.Kengeki_Activate(f2_arg0, f2_arg1, f2_arg2) then
        return
    end
    if Common_ActivateAct(f2_arg1, f2_arg2, 1) then
    elseif f2_local7 ~= POSSIBLE_ATTACK then
        if f2_local4 == 1 and f2_arg1:GetTeamOrder(ORDER_TYPE_Role) == ROLE_TYPE_Kankyaku then
            f2_local0[27] = 100
        elseif f2_local4 == 1 and f2_arg1:GetTeamOrder(ORDER_TYPE_Role) == ROLE_TYPE_Torimaki then
            f2_local0[27] = 100
        elseif f2_local7 == UNREACH_ATTACK then
            f2_local0[27] = 100
        elseif f2_local7 == REACH_ATTACK_TARGET_HIGH_POSITION then
            f2_local0[2] = 100
            f2_local0[27] = 100
        elseif f2_local7 == REACH_ATTACK_TARGET_LOW_POSITION then
            f2_local0[1] = 100
            f2_local0[2] = 100
            f2_local0[27] = 100
        else
            f2_local0[27] = 100
        end
    elseif not f2_arg1:IsExistMeshOnLine(TARGET_ENE_0, AI_DIR_TYPE_ToB, f2_local3) and f2_local3 >= 3 then
        f2_local0[29] = 100
    elseif f2_local4 == 1 and f2_arg1:GetTeamOrder(ORDER_TYPE_Role) == ROLE_TYPE_Kankyaku then
        if f2_arg1:HasSpecialEffectId(TARGET_SELF, 200051) then
            if KankyakuAct(f2_arg1, f2_arg2, -1, 70) then
                f2_local0[15] = 300
                f2_local0[17] = 200
            end
        else
            KankyakuAct(f2_arg1, f2_arg2)
        end
    elseif f2_local4 == 1 and f2_arg1:GetTeamOrder(ORDER_TYPE_Role) == ROLE_TYPE_Torimaki then
        if f2_arg1:HasSpecialEffectId(TARGET_SELF, 200051) then
            if TorimakiAct(f2_arg1, f2_arg2, -1, 70) then
                f2_local0[15] = 300
                f2_local0[17] = 200
            end
        elseif TorimakiAct(f2_arg1, f2_arg2) then
            f2_local0[7] = 100
        end
    elseif f2_arg1:IsInsideTarget(TARGET_ENE_0, AI_DIR_TYPE_B, 180) then
        f2_local0[21] = 100
    elseif f2_arg1:HasSpecialEffectId(TARGET_ENE_0, COMMON_SP_EFFECT_PC_BREAK) then
        f2_local0[6] = 100
    elseif f2_arg1:IsInsideTargetEx(TARGET_ENE_0, TARGET_SELF, AI_DIR_TYPE_F, 120, 9999) then
        if f2_local3 >= 9 then
            f2_local0[29] = 100
        elseif f2_local3 >= 7 then
            f2_local0[23] = 100
            if f2_arg1:HasSpecialEffectId(TARGET_SELF, 200051) then
                f2_local0[15] = 200
                f2_local0[17] = 200
            end
        elseif f2_local3 >= 5 then
            f2_local0[23] = 300
            if f2_arg1:HasSpecialEffectId(TARGET_SELF, 200051) then
                f2_local0[15] = 200
                f2_local0[16] = 200
            end
        elseif f2_local3 > 4 then
            f2_local0[3] = 100
            f2_local0[6] = 100
            f2_local0[23] = 100
            if f2_arg1:HasSpecialEffectId(TARGET_SELF, 200051) then
                f2_local0[15] = 150
                f2_local0[16] = 150
            end
        elseif f2_local3 > 3 then
            f2_local0[1] = 100
            f2_local0[2] = 100
            f2_local0[3] = 100
            f2_local0[6] = 100
            f2_local0[23] = 50
            if f2_arg1:GetNumber(1) >= 2 then
                f2_local0[9] = 500
            end
            if f2_arg1:HasSpecialEffectId(TARGET_SELF, 200051) then
                f2_local0[15] = 300
                f2_local0[16] = 300
            end
        else
            f2_local0[1] = 100
            f2_local0[2] = 100
            f2_local0[3] = 100
            f2_local0[6] = 100
            if f2_arg1:GetNumber(1) >= 2 then
                f2_local0[5] = 100
                f2_local0[9] = 100
            end
            if f2_arg1:HasSpecialEffectId(TARGET_SELF, 200051) then
                f2_local0[15] = 300
                f2_local0[16] = 300
            end
        end
    elseif f2_local3 > 9 then
        f2_local0[29] = 100
    elseif f2_local3 > 7 then
        f2_local0[4] = 100
        f2_local0[29] = 100
        if f2_arg1:HasSpecialEffectId(TARGET_SELF, 200051) then
            f2_local0[15] = 100
            f2_local0[17] = 100
        end
    elseif f2_local3 >= 5 then
        f2_local0[4] = 100
        f2_local0[23] = 100
        if f2_arg1:HasSpecialEffectId(TARGET_SELF, 200051) then
            f2_local0[15] = 100
            f2_local0[16] = 150
            f2_local0[17] = 100
        end
    else
        f2_local0[1] = 100
        f2_local0[2] = 100
        f2_local0[3] = 100
        f2_local0[6] = 100
        if f2_arg1:HasSpecialEffectId(TARGET_SELF, 200051) then
            f2_local0[16] = 400
        end
    end
    if f2_arg1:HasSpecialEffectId(TARGET_SELF, 200051) then
        f2_local0[3] = 0
        f2_local0[4] = 0
    end
    if SpaceCheck(f2_arg1, f2_arg2, 45, 2) == false and SpaceCheck(f2_arg1, f2_arg2, -45, 2) == false then
        f2_local0[9] = 0
        f2_local0[22] = 0
    end
    if SpaceCheck(f2_arg1, f2_arg2, 90, 1) == false and SpaceCheck(f2_arg1, f2_arg2, -90, 1) == false then
        f2_local0[23] = 1
    end
    if SpaceCheck(f2_arg1, f2_arg2, 180, 2) == false then
        f2_local0[9] = 0
        f2_local0[24] = 0
    end
    if SpaceCheck(f2_arg1, f2_arg2, 180, 1) == false then
        f2_local0[25] = 0
    end
    f2_local0[1] = SetCoolTime(f2_arg1, f2_arg2, 3000, 15, f2_local0[1], 1)
    f2_local0[2] = SetCoolTime(f2_arg1, f2_arg2, 3009, 15, f2_local0[2], 1)
    f2_local0[3] = SetCoolTime(f2_arg1, f2_arg2, 3002, 15, f2_local0[3], 1)
    f2_local0[4] = SetCoolTime(f2_arg1, f2_arg2, 3003, 15, f2_local0[4], 1)
    f2_local0[5] = SetCoolTime(f2_arg1, f2_arg2, 3006, 15, f2_local0[5], 1)
    f2_local0[6] = SetCoolTime(f2_arg1, f2_arg2, 3010, 20, f2_local0[6], 1)
    f2_local0[6] = SetCoolTime(f2_arg1, f2_arg2, 3020, 20, f2_local0[6], 1)
    f2_local0[9] = SetCoolTime(f2_arg1, f2_arg2, 3045, 20, f2_local0[6], 1)
    f2_local0[15] = SetCoolTime(f2_arg1, f2_arg2, 3005, 20, f2_local0[15], 1)
    f2_local0[16] = SetCoolTime(f2_arg1, f2_arg2, 3008, 20, f2_local0[16], 1)
    f2_local0[17] = SetCoolTime(f2_arg1, f2_arg2, 3004, 20, f2_local0[17], 1)
    f2_local1[1] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act01)
    f2_local1[2] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act02)
    f2_local1[3] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act03)
    f2_local1[4] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act04)
    f2_local1[5] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act05)
    f2_local1[6] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act06)
    f2_local1[7] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act07)
    f2_local1[9] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act09)
    f2_local1[10] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act10)
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
    f2_local1[29] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act29)
    local f2_local8 = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.ActAfter_AdjustSpace)
    Common_Battle_Activate(f2_arg1, f2_arg2, f2_local0, f2_local1, f2_local8, f2_local2)
    
end

Goal.Act01 = function (f3_arg0, f3_arg1, f3_arg2)
    local f3_local0 = 4.6 - f3_arg0:GetMapHitRadius(TARGET_SELF)
    local f3_local1 = 4.6 - f3_arg0:GetMapHitRadius(TARGET_SELF) + 99
    local f3_local2 = 4.6 - f3_arg0:GetMapHitRadius(TARGET_SELF) + 100
    local f3_local3 = 0
    local f3_local4 = 0
    local f3_local5 = 1.5
    local f3_local6 = 3
    Approach_Act_Flex(f3_arg0, f3_arg1, f3_local0, f3_local1, f3_local2, f3_local3, f3_local4, f3_local5, f3_local6)
    local f3_local7 = 0
    local f3_local8 = 0
    f3_arg1:AddSubGoal(GOAL_COMMON_ComboAttackTunableSpin, 10, 3000, TARGET_ENE_0, 9999, f3_local7, f3_local8, 0, 0):TimingSetNumber(1, f3_arg0:GetNumber(1) + 2, AI_TIMING_SET__ACTIVATE)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act02 = function (f4_arg0, f4_arg1, f4_arg2)
    local f4_local0 = 3.5 - f4_arg0:GetMapHitRadius(TARGET_SELF)
    local f4_local1 = 3.5 - f4_arg0:GetMapHitRadius(TARGET_SELF) + 99
    local f4_local2 = 3.5 - f4_arg0:GetMapHitRadius(TARGET_SELF) + 100
    local f4_local3 = 0
    local f4_local4 = 0
    local f4_local5 = 1.5
    local f4_local6 = 3
    Approach_Act_Flex(f4_arg0, f4_arg1, f4_local0, f4_local1, f4_local2, f4_local3, f4_local4, f4_local5, f4_local6)
    local f4_local7 = 0
    local f4_local8 = 0
    f4_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 10, 3009, TARGET_ENE_0, 9999, f4_local7, f4_local8, 0, 0):TimingSetNumber(1, f4_arg0:GetNumber(1) + 2, AI_TIMING_SET__ACTIVATE)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act03 = function (f5_arg0, f5_arg1, f5_arg2)
    local f5_local0 = 4.7 - f5_arg0:GetMapHitRadius(TARGET_SELF)
    local f5_local1 = 4.7 - f5_arg0:GetMapHitRadius(TARGET_SELF) + 99
    local f5_local2 = 4.7 - f5_arg0:GetMapHitRadius(TARGET_SELF) + 100
    local f5_local3 = 0
    local f5_local4 = 0
    local f5_local5 = 1.5
    local f5_local6 = 3
    Approach_Act_Flex(f5_arg0, f5_arg1, f5_local0, f5_local1, f5_local2, f5_local3, f5_local4, f5_local5, f5_local6)
    local f5_local7 = 0
    local f5_local8 = 0
    f5_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 10, 3002, TARGET_ENE_0, 9999, f5_local7, f5_local8, 0, 0):TimingSetNumber(1, f5_arg0:GetNumber(1) + 2, AI_TIMING_SET__ACTIVATE)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act04 = function (f6_arg0, f6_arg1, f6_arg2)
    local f6_local0 = 12 - f6_arg0:GetMapHitRadius(TARGET_SELF)
    local f6_local1 = 12 - f6_arg0:GetMapHitRadius(TARGET_SELF) + 99
    local f6_local2 = 12 - f6_arg0:GetMapHitRadius(TARGET_SELF) + 100
    local f6_local3 = 0
    local f6_local4 = 0
    local f6_local5 = 3
    local f6_local6 = 3
    Approach_Act_Flex(f6_arg0, f6_arg1, f6_local0, f6_local1, f6_local2, f6_local3, f6_local4, f6_local5, f6_local6)
    local f6_local7 = 0
    local f6_local8 = 0
    f6_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 10, 3003, TARGET_ENE_0, 9999, f6_local7, f6_local8, 0, 0):TimingSetNumber(1, f6_arg0:GetNumber(1) + 2, AI_TIMING_SET__ACTIVATE)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act05 = function (f7_arg0, f7_arg1, f7_arg2)
    local f7_local0 = 2.5 - f7_arg0:GetMapHitRadius(TARGET_SELF)
    local f7_local1 = 2.5 - f7_arg0:GetMapHitRadius(TARGET_SELF) + 99
    local f7_local2 = 2.5 - f7_arg0:GetMapHitRadius(TARGET_SELF) + 100
    local f7_local3 = 0
    local f7_local4 = 0
    local f7_local5 = 1.5
    local f7_local6 = 3
    local f7_local7 = 0
    local f7_local8 = 0
    f7_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 10, 3006, TARGET_ENE_0, 9999, f7_local7, f7_local8, 0, 0)
    f7_arg0:SetNumber(1, 0)
    f7_arg0:SetNumber(0, 1)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act06 = function (f8_arg0, f8_arg1, f8_arg2)
    if f8_arg0:GetDist(TARGET_ENE_0) <= 4 then
        f8_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 10, 3020, TARGET_ENE_0, 9999, 0, 0, 0, 0)
        GetWellSpace_Odds = 100
        return GetWellSpace_Odds
    else
        local f8_local0 = 10 - f8_arg0:GetMapHitRadius(TARGET_SELF)
        local f8_local1 = 10 - f8_arg0:GetMapHitRadius(TARGET_SELF) + 99
        local f8_local2 = 10 - f8_arg0:GetMapHitRadius(TARGET_SELF) + 100
        local f8_local3 = 0
        local f8_local4 = 0
        local f8_local5 = 1.5
        local f8_local6 = 3
        Approach_Act_Flex(f8_arg0, f8_arg1, f8_local0, f8_local1, f8_local2, f8_local3, f8_local4, f8_local5, f8_local6)
        local f8_local7 = 0
        local f8_local8 = 0
        f8_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 10, 3010, TARGET_ENE_0, 9999, f8_local7, f8_local8, 0, 0):TimingSetNumber(1, f8_arg0:GetNumber(1) + 2, AI_TIMING_SET__ACTIVATE)
        GetWellSpace_Odds = 100
        return GetWellSpace_Odds
    end
    
end

Goal.Act07 = function (f9_arg0, f9_arg1, f9_arg2)
    local f9_local0 = 0
    local f9_local1 = 0
    f9_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 10, 3011, TARGET_ENE_0, 9999, f9_local0, f9_local1, 0, 0)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act09 = function (f10_arg0, f10_arg1, f10_arg2)
    local f10_local0 = f10_arg0:GetDist(TARGET_ENE_0)
    local f10_local1 = 0
    local f10_local2 = 0
    local f10_local3 = f10_arg0:GetRandam_Int(1, 100)
    if f10_local3 <= 50 then
        f10_arg1:AddSubGoal(GOAL_COMMON_ComboAttackTunableSpin, 10, 3044, TARGET_ENE_0, 9999, f10_local1, f10_local2, 0, 0)
        f10_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3045, TARGET_ENE_0, 9999, f10_local1, f10_local2, 0, 0)
    else
        f10_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 10, 3045, TARGET_ENE_0, 9999, f10_local1, f10_local2, 0, 0)
    end
    f10_arg0:SetNumber(1, 0)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act10 = function (f11_arg0, f11_arg1, f11_arg2)
    local f11_local0 = f11_arg0:GetDist(TARGET_ENE_0)
    local f11_local1 = 0
    local f11_local2 = 0
    local f11_local3 = f11_arg0:GetRandam_Int(1, 100)
    if f11_local0 >= 7 then
        f11_arg1:AddSubGoal(GOAL_COMMON_ComboAttackTunableSpin, 10, 3042, TARGET_ENE_0, 9999, f11_local1, f11_local2, 0, 0)
        f11_arg1:AddSubGoal(GOAL_COMMON_ComboRepeat, 10, 3040, TARGET_ENE_0, 9999, 0, 0)
        f11_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3009, TARGET_ENE_0, 9999, 0, 0)
    else
        f11_arg1:AddSubGoal(GOAL_COMMON_ComboAttackTunableSpin, 10, 3009, TARGET_ENE_0, 9999, f11_local1, f11_local2, 0, 0)
        f11_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3044, TARGET_ENE_0, 9999, 0, 0)
    end
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act15 = function (f12_arg0, f12_arg1, f12_arg2)
    local f12_local0 = 8 - f12_arg0:GetMapHitRadius(TARGET_SELF)
    local f12_local1 = 8 - f12_arg0:GetMapHitRadius(TARGET_SELF) + 99
    local f12_local2 = 8 - f12_arg0:GetMapHitRadius(TARGET_SELF) + 100
    local f12_local3 = 0
    local f12_local4 = 0
    local f12_local5 = 1.5
    local f12_local6 = 3
    Approach_Act_Flex(f12_arg0, f12_arg1, f12_local0, f12_local1, f12_local2, f12_local3, f12_local4, f12_local5, f12_local6)
    local f12_local7 = 0
    local f12_local8 = 0
    f12_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 10, 3005, TARGET_ENE_0, 9999, f12_local7, f12_local8, 0, 0)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act16 = function (f13_arg0, f13_arg1, f13_arg2)
    local f13_local0 = 6.2 - f13_arg0:GetMapHitRadius(TARGET_SELF)
    local f13_local1 = 6.2 - f13_arg0:GetMapHitRadius(TARGET_SELF) + 99
    local f13_local2 = 6.2 - f13_arg0:GetMapHitRadius(TARGET_SELF) + 100
    local f13_local3 = 0
    local f13_local4 = 0
    local f13_local5 = 1.5
    local f13_local6 = 3
    Approach_Act_Flex(f13_arg0, f13_arg1, f13_local0, f13_local1, f13_local2, f13_local3, f13_local4, f13_local5, f13_local6)
    local f13_local7 = 0
    local f13_local8 = 0
    f13_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 10, 3008, TARGET_ENE_0, 9999, f13_local7, f13_local8, 0, 0)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act17 = function (f14_arg0, f14_arg1, f14_arg2)
    local f14_local0 = 18 - f14_arg0:GetMapHitRadius(TARGET_SELF)
    local f14_local1 = 18 - f14_arg0:GetMapHitRadius(TARGET_SELF) + 99
    local f14_local2 = 18 - f14_arg0:GetMapHitRadius(TARGET_SELF) + 100
    local f14_local3 = 0
    local f14_local4 = 0
    local f14_local5 = 1.5
    local f14_local6 = 3
    Approach_Act_Flex(f14_arg0, f14_arg1, f14_local0, f14_local1, f14_local2, f14_local3, f14_local4, f14_local5, f14_local6)
    local f14_local7 = 0
    local f14_local8 = 0
    f14_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 10, 3004, TARGET_ENE_0, 9999, f14_local7, f14_local8, 0, 0)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act21 = function (f15_arg0, f15_arg1, f15_arg2)
    local f15_local0 = 3
    local f15_local1 = 45
    f15_arg1:AddSubGoal(GOAL_COMMON_Turn, f15_local0, TARGET_ENE_0, f15_local1, -1, GOAL_RESULT_Success, true)
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
    
end

Goal.Act23 = function (f16_arg0, f16_arg1, f16_arg2)
    local f16_local0 = f16_arg0:GetDist(TARGET_ENE_0)
    local f16_local1 = f16_arg0:GetSp(TARGET_SELF)
    local f16_local2 = 20
    local f16_local3 = f16_arg0:GetRandam_Int(1, 100)
    local f16_local4 = -1
    local f16_local5 = 0
    if SpaceCheck(f16_arg0, f16_arg1, -90, 1) == true then
        if SpaceCheck(f16_arg0, f16_arg1, 90, 1) == true then
            if f16_arg0:IsInsideTargetEx(TARGET_ENE_0, TARGET_SELF, AI_DIR_TYPE_R, 180, 999) then
                f16_local5 = 1
            else
                f16_local5 = 0
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
    if f16_local0 >= 7 then
        f16_local6 = 1
    elseif f16_local0 >= 3 then
        f16_local6 = 1
    else
        f16_local6 = 1
    end
    local f16_local8 = 90
    local f16_local9 = 4 - f16_arg0:GetMapHitRadius(TARGET_SELF) + 1
    f16_arg0:AddObserveArea(1, TARGET_SELF, TARGET_ENE_0, AI_DIR_TYPE_F, f16_local8, f16_local9)
    f16_arg1:AddSubGoal(GOAL_COMMON_SidewayMove, f16_local6, TARGET_ENE_0, f16_local5, f16_local7, true, true, f16_local4)
    f16_arg0:SetNumber(0, 0)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act25 = function (f17_arg0, f17_arg1, f17_arg2)
    local f17_local0 = f17_arg0:GetRandam_Float(2, 4)
    local f17_local1 = f17_arg0:GetRandam_Float(5, 7)
    local f17_local2 = f17_arg0:GetDist(TARGET_ENE_0)
    local f17_local3 = -1
    f17_arg1:AddSubGoal(GOAL_COMMON_LeaveTarget, f17_local0, TARGET_ENE_0, f17_local1, TARGET_ENE_0, true, f17_local3)
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
        f19_arg1:AddSubGoal(GOAL_COMMON_Wait, 0.5, TARGET_SELF, 0, 0, 0)
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
    local f21_local1 = f21_arg0:GetDist(TARGET_ENE_0)
    if not f21_arg0:IsExistMeshOnLine(TARGET_ENE_0, AI_DIR_TYPE_ToB, f21_local1) then
        f21_arg1:AddSubGoal(GOAL_COMMON_ApproachTarget, f21_local0, TARGET_ENE_0, 3, TARGET_SELF, false, -1)
    else
        f21_arg1:AddSubGoal(GOAL_COMMON_ApproachTarget, f21_local0, TARGET_ENE_0, 7, TARGET_SELF, false, -1)
    end
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
    
end

Goal.Interrupt = function (f22_arg0, f22_arg1, f22_arg2)
    local f22_local0 = f22_arg1:GetSpecialEffectActivateInterruptType(0)
    local f22_local1 = f22_arg1:GetRandam_Int(1, 100)
    local f22_local2 = f22_arg1:GetRandam_Int(1, 100)
    local f22_local3 = 90
    local f22_local4 = 3.1 - f22_arg1:GetMapHitRadius(TARGET_SELF)
    if f22_arg1:IsLadderAct(TARGET_SELF) then
        return false
    end
    if not f22_arg1:HasSpecialEffectId(TARGET_SELF, 200004) then
        return false
    end
    if f22_arg1:IsInterupt(INTERUPT_ParryTiming) then
        return Common_Parry(f22_arg1, f22_arg2, 50, 0, -1)
    end
    if Interupt_PC_Break(f22_arg1) then
        f22_arg1:Replanning()
        return true
    end
    if f22_arg1:IsInterupt(INTERUPT_Damaged) then
        return f22_arg0.Damaged(f22_arg1, f22_arg2)
    end
    if f22_arg1:IsInterupt(INTERUPT_ActivateSpecialEffect) then
    end
    if f22_arg1:IsInterupt(INTERUPT_Inside_ObserveArea) and f22_arg1:IsInsideObserve(1) then
        if f22_arg1:GetNumber(2) >= 2 then
            f22_arg1:SetNumber(2, 0)
            f22_arg1:Replanning()
        elseif f22_local1 <= 33 then
            f22_arg2:ClearSubGoal()
            f22_arg2:AddSubGoal(GOAL_COMMON_ComboRepeat, 5, 3009, TARGET_ENE_0, 9999, 0, 0)
            f22_arg1:SetNumber(2, f22_arg1:GetNumber(2) + 1)
        else
            f22_arg2:ClearSubGoal()
            f22_arg2:AddSubGoal(GOAL_COMMON_ComboRepeat, 3, 3011, TARGET_ENE_0, 9999, 0, 0)
            f22_arg1:SetNumber(2, f22_arg1:GetNumber(2) + 1)
        end
        f22_arg1:DeleteObserve(1)
        return true
    end
    if f22_arg1:IsInterupt(INTERUPT_ShootImpact) and f22_arg0.ShootReaction(f22_arg1, f22_arg2) then
        return true
    end
    return false
    
end

Goal.Damaged = function (f23_arg0, f23_arg1, f23_arg2)
    local f23_local0 = f23_arg0:GetRandam_Int(1, 100)
    local f23_local1 = f23_arg0:GetDist(TARGET_ENE_0)
    if f23_local1 <= 4 - f23_arg0:GetMapHitRadius(TARGET_SELF) + 0.5 and f23_local0 <= 50 and SpaceCheck(f23_arg0, f23_arg1, 180, 2) then
        f23_arg1:ClearSubGoal()
        f23_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 4, 3045, TARGET_ENE_0, 9999, 0, 0, 0, 0)
        return true
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
    else
        if f25_local0 == 200228 then
            if f25_local4 >= 3 then
                f25_local1[10] = 100
            elseif f25_local4 <= 0.2 then
                f25_local1[10] = 100
            else
                f25_local1[10] = 100
            end
        elseif f25_local0 == 200200 then
            if f25_local4 >= 3 then
                f25_local1[50] = 100
            elseif f25_local4 <= 0.2 then
                f25_local1[50] = 100
            elseif f25_arg1:GetNumber(1) >= 4 then
                f25_local1[6] = 100
                f25_local1[7] = 100
            else
                f25_local1[2] = 100
                f25_local1[9] = 100
            end
        elseif f25_local0 == 200201 then
            if f25_local4 >= 3 then
                f25_local1[50] = 100
            elseif f25_local4 <= 0.2 then
                f25_local1[50] = 100
            elseif f25_arg1:GetNumber(1) >= 4 then
                f25_local1[6] = 100
                f25_local1[7] = 100
                f25_local1[50] = 100
            else
                f25_local1[4] = 100
                f25_local1[9] = 100
                f25_local1[50] = 100
            end
        elseif f25_local0 == 200215 or f25_local0 == 200216 then
            if f25_local4 >= 3 then
                f25_local1[50] = 100
            elseif f25_local4 <= 0.2 then
                if f25_arg1:GetNumber(1) >= 4 then
                    f25_local1[6] = 100
                    f25_local1[7] = 50
                    f25_local1[12] = 100
                else
                    f25_local1[1] = 100
                    f25_local1[2] = 100
                    f25_local1[9] = 100
                end
            elseif f25_arg1:GetNumber(1) >= 4 then
                f25_local1[6] = 100
                f25_local1[7] = 50
                f25_local1[12] = 100
            else
                f25_local1[3] = 100
                f25_local1[4] = 100
                f25_local1[9] = 100
            end
        elseif f25_local0 == 200210 or f25_local0 == 200211 then
            if f25_local4 >= 3 then
                f25_local1[50] = 100
            else
                f25_local1[11] = 100
                f25_local1[12] = 150
            end
        else
            f25_local1[50] = 100
        end
        f25_local1[6] = 0
        f25_local1[9] = 0
    end
    f25_local2[1] = REGIST_FUNC(f25_arg1, f25_arg2, f25_arg0.Kengeki01)
    f25_local2[2] = REGIST_FUNC(f25_arg1, f25_arg2, f25_arg0.Kengeki02)
    f25_local2[3] = REGIST_FUNC(f25_arg1, f25_arg2, f25_arg0.Kengeki03)
    f25_local2[4] = REGIST_FUNC(f25_arg1, f25_arg2, f25_arg0.Kengeki04)
    f25_local2[5] = REGIST_FUNC(f25_arg1, f25_arg2, f25_arg0.Kengeki05)
    f25_local2[6] = REGIST_FUNC(f25_arg1, f25_arg2, f25_arg0.Kengeki06)
    f25_local2[7] = REGIST_FUNC(f25_arg1, f25_arg2, f25_arg0.Kengeki07)
    f25_local2[8] = REGIST_FUNC(f25_arg1, f25_arg2, f25_arg0.Kengeki08)
    f25_local2[9] = REGIST_FUNC(f25_arg1, f25_arg2, f25_arg0.Kengeki09)
    f25_local2[10] = REGIST_FUNC(f25_arg1, f25_arg2, f25_arg0.Kengeki10)
    f25_local2[11] = REGIST_FUNC(f25_arg1, f25_arg2, f25_arg0.Kengeki11)
    f25_local2[12] = REGIST_FUNC(f25_arg1, f25_arg2, f25_arg0.Kengeki12)
    f25_local2[50] = REGIST_FUNC(f25_arg1, f25_arg2, f25_arg0.NoAction)
    local f25_local6 = REGIST_FUNC(f25_arg1, f25_arg2, f25_arg0.ActAfter_AdjustSpace)
    return Common_Kengeki_Activate(f25_arg1, f25_arg2, f25_local1, f25_local2, f25_local6, f25_local3)
    
end

Goal.Kengeki01 = function (f26_arg0, f26_arg1, f26_arg2)
    f26_arg1:ClearSubGoal()
    f26_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3062, TARGET_ENE_0, 9999, 0, 0)
    f26_arg0:SetNumber(1, f26_arg0:GetNumber(1) + 2)
    
end

Goal.Kengeki02 = function (f27_arg0, f27_arg1, f27_arg2)
    f27_arg1:ClearSubGoal()
    f27_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3063, TARGET_ENE_0, 9999, TurnTime, FrontAngle, 0, 0)
    f27_arg0:SetNumber(1, f27_arg0:GetNumber(1) + 2)
    
end

Goal.Kengeki03 = function (f28_arg0, f28_arg1, f28_arg2)
    f28_arg1:ClearSubGoal()
    f28_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3000, TARGET_ENE_0, 9999, 0, 0)
    f28_arg0:SetNumber(1, f28_arg0:GetNumber(1) + 2)
    
end

Goal.Kengeki04 = function (f29_arg0, f29_arg1, f29_arg2)
    f29_arg1:ClearSubGoal()
    f29_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3065, TARGET_ENE_0, 9999, 0, 0)
    f29_arg0:SetNumber(1, f29_arg0:GetNumber(1) + 2)
    
end

Goal.Kengeki05 = function (f30_arg0, f30_arg1, f30_arg2)
    f30_arg1:ClearSubGoal()
    f30_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3000, TARGET_ENE_0, 9999, 0, 0)
    
end

Goal.Kengeki06 = function (f31_arg0, f31_arg1, f31_arg2)
    f31_arg1:ClearSubGoal()
    f31_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3006, TARGET_ENE_0, 9999, 0, 0)
    f31_arg0:SetNumber(1, 0)
    
end

Goal.Kengeki07 = function (f32_arg0, f32_arg1, f32_arg2)
    f32_arg1:ClearSubGoal()
    f32_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3045, TARGET_ENE_0, 9999, 0, 0)
    f32_arg0:SetNumber(1, 0)
    
end

Goal.Kengeki08 = function (f33_arg0, f33_arg1, f33_arg2)
    f33_arg1:ClearSubGoal()
    f33_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 1, 3006, TARGET_ENE_0, 9999, 0, 0)
    f33_arg0:SetNumber(1, 0)
    
end

Goal.Kengeki09 = function (f34_arg0, f34_arg1, f34_arg2)
    f34_arg1:ClearSubGoal()
    f34_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 1, 3011, TARGET_ENE_0, 9999, 0, 0)
    f34_arg0:SetNumber(1, f34_arg0:GetNumber(1) + 4)
    
end

Goal.Kengeki10 = function (f35_arg0, f35_arg1, f35_arg2)
    f35_arg1:ClearSubGoal()
    f35_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3061, TARGET_ENE_0, 9999, 0, 0)
    f35_arg0:SetNumber(2, 0)
    f35_arg0:SetNumber(1, 0)
    
end

Goal.Kengeki11 = function (f36_arg0, f36_arg1, f36_arg2)
    f36_arg1:ClearSubGoal()
    f36_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3002, TARGET_ENE_0, 9999, 0, 0)
    f36_arg0:SetNumber(1, f36_arg0:GetNumber(1) + 4)
    
end

Goal.Kengeki12 = function (f37_arg0, f37_arg1, f37_arg2)
    f37_arg1:ClearSubGoal()
    f37_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3020, TARGET_ENE_0, 9999, 0, 0)
    f37_arg0:SetNumber(1, f37_arg0:GetNumber(1) + 4)
    
end

Goal.NoAction = function (f38_arg0, f38_arg1, f38_arg2)
    return -1
    
end

Goal.ActAfter_AdjustSpace = function (f39_arg0, f39_arg1, f39_arg2)
    
end

Goal.Update = function (f40_arg0, f40_arg1, f40_arg2)
    return Update_Default_NoSubGoal(f40_arg0, f40_arg1, f40_arg2)
    
end

Goal.Terminate = function (f41_arg0, f41_arg1, f41_arg2)
    
end


