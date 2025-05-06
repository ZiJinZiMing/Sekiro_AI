﻿RegisterTableGoal(GOAL_Okinaryuu_530000_Battle, "GOAL_Okinaryuu_530000_Battle")
REGISTER_GOAL_NO_UPDATE(GOAL_Okinaryuu_530000_Battle, true)

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
    local f2_local5 = f2_arg1:GetDist(TARGET_TEAM_LEADER)
    local f2_local6 = f2_arg1:GetDist(TARGET_EVENT)
    local f2_local7 = f2_arg1:GetRandam_Int(1, 100)
    local f2_local8 = f2_arg1:GetEventRequest()
    local f2_local9 = f2_arg1:IsEventFlag(12505901)
    local f2_local10 = f2_arg1:IsEventFlag(12505857)
    if f2_arg1:HasSpecialEffectId(TARGET_SELF, 200050) then
        local f2_local11 = f2_local9
    end
    local f2_local12 = f2_arg1:HasSpecialEffectId(TARGET_SELF, 3530030)
    f2_arg1:AddObserveSpecialEffectAttribute(TARGET_SELF, 5025)
    f2_arg1:AddObserveSpecialEffectAttribute(TARGET_SELF, 5026)
    f2_arg1:AddObserveSpecialEffectAttribute(TARGET_SELF, 5030)
    if f2_arg1:HasSpecialEffectId(TARGET_SELF, 200031) then
        f2_local0[31] = 100
    elseif not f2_arg1:HasSpecialEffectId(TARGET_SELF, 200031) then
        if f2_arg1:IsEventFlag(12505877) == true and f2_arg1:GetNumber(0) == 0 then
            f2_local0[6] = 100
        elseif f2_arg1:IsEventFlag(12505875) == true then
            f2_local0[5] = 100
        elseif f2_arg1:HasSpecialEffectId(TARGET_ENE_0, 110060) or f2_arg1:HasSpecialEffectId(TARGET_ENE_0, 110010) then
            f2_local0[28] = 100
        elseif Common_ActivateAct(f2_arg1, f2_arg2, 1) then
        else
            if f2_arg1:IsInsideTarget(TARGET_ENE_0, AI_DIR_TYPE_B, 180) then
                f2_local0[21] = 100
            elseif f2_local9 and f2_local5 <= 3 then
                f2_local0[32] = 100
            elseif f2_local3 >= 5 then
                f2_local0[3] = 0
                f2_local0[4] = 0
                f2_local0[5] = 0
                f2_local0[6] = 0
                f2_local0[7] = 10
                f2_local0[16] = 10
                f2_local0[28] = 50
            elseif f2_local3 > 3 then
                f2_local0[7] = 100
                f2_local0[28] = 100
            else
                f2_local0[2] = 100
                f2_local0[3] = 100
                f2_local0[4] = 100
                f2_local0[7] = 100
                f2_local0[28] = 100
            end
            if f2_local12 then
                f2_local0[25] = 0
                f2_local0[32] = 10
                f2_local0[7] = 0
                f2_local0[16] = 0
                if f2_local3 >= 12 and f2_arg1:CheckDoesExistPath(TARGET_ENE_0, AI_DIR_TYPE_F, 0, 0) == true then
                    f2_local0[12] = 800
                elseif f2_local4 == 1 and f2_arg1:GetTeamOrder(ORDER_TYPE_Role) == ROLE_TYPE_Kankyaku then
                    f2_local0[28] = 100
                elseif f2_local4 == 1 and f2_arg1:GetTeamOrder(ORDER_TYPE_Role) == ROLE_TYPE_Torimaki then
                    f2_local0[28] = 100
                else
                    f2_local0[13] = 100
                end
            end
            if f2_local9 then
                f2_local0[33] = f2_local0[32]
                f2_local0[32] = 0
                f2_local0[11] = 600
                f2_local0[12] = 0
            end
            if f2_arg1:IsEventFlag(19959973) == true then
                f2_local0[10] = 0
                f2_local0[12] = 0
                f2_local0[23] = 0
                f2_local0[25] = 0
                f2_local0[32] = 0
                f2_local0[11] = 800
            end
        end
        if SpaceCheck(f2_arg1, f2_arg2, 90, 1) == false and SpaceCheck(f2_arg1, f2_arg2, -90, 1) == false then
            f2_local0[23] = 0
        end
        if SpaceCheck(f2_arg1, f2_arg2, 180, 1) == false then
            f2_local0[25] = 0
        end
    end
    f2_local0[2] = SetCoolTime(f2_arg1, f2_arg2, 3005, 10, f2_local0[2], 1)
    f2_local0[3] = SetCoolTime(f2_arg1, f2_arg2, 3002, 10, f2_local0[3], 1)
    f2_local0[4] = SetCoolTime(f2_arg1, f2_arg2, 3003, 10, f2_local0[4], 1)
    f2_local0[7] = SetCoolTime(f2_arg1, f2_arg2, 3004, 15, f2_local0[7], 1)
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
    f2_local1[15] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act15)
    f2_local1[16] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act16)
    f2_local1[17] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act17)
    f2_local1[18] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act18)
    f2_local1[19] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act19)
    f2_local1[21] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act21)
    f2_local1[23] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act23)
    f2_local1[25] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act25)
    f2_local1[26] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act26)
    f2_local1[28] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act28)
    f2_local1[30] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act30)
    f2_local1[31] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act31)
    f2_local1[32] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act32)
    f2_local1[33] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act33)
    f2_local1[40] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act40)
    f2_local1[41] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act41)
    local f2_local13 = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.ActAfter_AdjustSpace)
    Common_Battle_Activate(f2_arg1, f2_arg2, f2_local0, f2_local1, f2_local13, f2_local2)
    
end

Goal.Act01 = function (f3_arg0, f3_arg1, f3_arg2)
    local f3_local0 = 0
    local f3_local1 = 0
    f3_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 10, 3000, TARGET_ENE_0, 9999, f3_local0, f3_local1, 0, 0)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act02 = function (f4_arg0, f4_arg1, f4_arg2)
    local f4_local0 = 2 - f4_arg0:GetMapHitRadius(TARGET_SELF)
    local f4_local1 = 2 - f4_arg0:GetMapHitRadius(TARGET_SELF) + 0
    local f4_local2 = 2 - f4_arg0:GetMapHitRadius(TARGET_SELF) + 999
    local f4_local3 = 100
    local f4_local4 = 0
    local f4_local5 = 1
    local f4_local6 = 4
    Approach_Act_Flex(f4_arg0, f4_arg1, f4_local0, f4_local1, f4_local2, f4_local3, f4_local4, f4_local5, f4_local6)
    local f4_local7 = 0
    local f4_local8 = 0
    f4_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 10, 3005, TARGET_ENE_0, 9999, f4_local7, f4_local8, 0, 0)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act03 = function (f5_arg0, f5_arg1, f5_arg2)
    local f5_local0 = 2 - f5_arg0:GetMapHitRadius(TARGET_SELF)
    local f5_local1 = 2 - f5_arg0:GetMapHitRadius(TARGET_SELF) + 0
    local f5_local2 = 2 - f5_arg0:GetMapHitRadius(TARGET_SELF) + 999
    local f5_local3 = 100
    local f5_local4 = 0
    local f5_local5 = 1
    local f5_local6 = 4
    Approach_Act_Flex(f5_arg0, f5_arg1, f5_local0, f5_local1, f5_local2, f5_local3, f5_local4, f5_local5, f5_local6)
    local f5_local7 = 0
    local f5_local8 = 0
    f5_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 10, 3002, TARGET_ENE_0, 9999, f5_local7, f5_local8, 0, 0)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act04 = function (f6_arg0, f6_arg1, f6_arg2)
    local f6_local0 = 2 - f6_arg0:GetMapHitRadius(TARGET_SELF)
    local f6_local1 = 2 - f6_arg0:GetMapHitRadius(TARGET_SELF) + 0
    local f6_local2 = 2 - f6_arg0:GetMapHitRadius(TARGET_SELF) + 999
    local f6_local3 = 100
    local f6_local4 = 0
    local f6_local5 = 1
    local f6_local6 = 4
    Approach_Act_Flex(f6_arg0, f6_arg1, f6_local0, f6_local1, f6_local2, f6_local3, f6_local4, f6_local5, f6_local6)
    local f6_local7 = 0
    local f6_local8 = 0
    f6_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 10, 3003, TARGET_ENE_0, 9999, f6_local7, f6_local8, 0, 0)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act05 = function (f7_arg0, f7_arg1, f7_arg2)
    local f7_local0 = 0
    local f7_local1 = 180
    if not f7_arg0:HasSpecialEffectId(TARGET_SELF, 3530000) then
        f7_arg1:AddSubGoal(GOAL_COMMON_ComboAttackTunableSpin, 10, 3015, TARGET_ENE_0, 9999, f7_local0, f7_local1, 0, 0)
    else
        f7_arg1:AddSubGoal(GOAL_COMMON_ComboRepeat, 10, 3016, TARGET_ENE_0, 9999, 0)
    end
    f7_arg0:SetNumber(0, 0)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act06 = function (f8_arg0, f8_arg1, f8_arg2)
    local f8_local0 = 0
    local f8_local1 = 180
    local f8_local2 = f8_arg0:GetRandam_Int(1, 2)
    if f8_local2 == 1 then
        f8_arg1:AddSubGoal(GOAL_COMMON_ComboAttackTunableSpin, 10, 3017, TARGET_ENE_0, 9999, f8_local0, f8_local1, 0, 0)
    else
        f8_arg1:AddSubGoal(GOAL_COMMON_ComboAttackTunableSpin, 10, 3018, TARGET_ENE_0, 9999, f8_local0, f8_local1, 0, 0)
    end
    f8_arg0:SetNumber(0, 1)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act07 = function (f9_arg0, f9_arg1, f9_arg2)
    local f9_local0 = 0
    local f9_local1 = 0
    f9_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 10, 3004, TARGET_ENE_0, 9999, f9_local0, f9_local1, 0, 0)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act08 = function (f10_arg0, f10_arg1, f10_arg2)
    local f10_local0 = 0
    local f10_local1 = 0
    f10_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 10, 3021, TARGET_ENE_0, 9999, f10_local0, f10_local1, 0, 0)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act09 = function (f11_arg0, f11_arg1, f11_arg2)
    local f11_local0 = 0
    local f11_local1 = 0
    f11_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 10, 3022, TARGET_ENE_0, 9999, f11_local0, f11_local1, 0, 0)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act10 = function (f12_arg0, f12_arg1, f12_arg2)
    local f12_local0 = 7
    local f12_local1 = 10
    local f12_local2 = 15
    local f12_local3 = 0
    local f12_local4 = 0
    local f12_local5 = 1.5
    local f12_local6 = 2
    local f12_local7 = AI_DIR_TYPE_ToF
    if f12_arg0:IsInsideTargetEx(TARGET_FRI_0, TARGET_SELF, AI_DIR_TYPE_R, 180, 999) then
        f12_local7 = AI_DIR_TYPE_ToR
    else
        f12_local7 = AI_DIR_TYPE_ToL
    end
    f12_arg1:AddSubGoal(GOAL_COMMON_ApproachSettingDirection, 2, TARGET_ENE_0, 2, TARGET_ENE_0, false, -1, f12_local7, f12_arg0:GetRandam_Float(5, 8))
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act11 = function (f13_arg0, f13_arg1, f13_arg2)
    local f13_local0 = 4
    local f13_local1 = 10
    local f13_local2 = 15
    local f13_local3 = 0
    local f13_local4 = 0
    local f13_local5 = 1.5
    local f13_local6 = 2
    local f13_local7 = f13_arg0:GetDist(TARGET_ENE_0)
    local f13_local8 = f13_arg0:GetDist(TARGET_TEAM_LEADER)
    local f13_local9 = f13_arg0:GetDistAtoB(TARGET_TEAM_LEADER, TARGET_ENE_0)
    local f13_local10 = f13_arg0:IsEventFlag(12505901)
    f13_arg0:SetStringIndexedNumber(" targetDist ", f13_local7)
    f13_arg0:SetStringIndexedNumber(" leaderDist ", f13_local8)
    f13_arg0:SetStringIndexedNumber(" bossToTargetDist ", f13_local9)
    local f13_local11 = AI_DIR_TYPE_ToF
    if f13_local0 <= f13_local8 then
        f13_arg1:AddSubGoal(GOAL_COMMON_ApproachTarget, 2, TARGET_TEAM_LEADER, f13_local0, TARGET_ENE_0, true, -1)
    elseif f13_arg0:IsInsideTargetEx(TARGET_SELF, TARGET_TEAM_LEADER, AI_DIR_TYPE_R, 180, 999) then
        f13_arg1:AddSubGoal(GOAL_COMMON_SidewayMove, 1, TARGET_ENE_0, 1, 45, true, true, -1)
    else
        f13_arg1:AddSubGoal(GOAL_COMMON_SidewayMove, 1, TARGET_ENE_0, 0, 45, true, true, -1)
    end
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act12 = function (f14_arg0, f14_arg1, f14_arg2)
    local f14_local0 = 0
    local f14_local1 = 0
    local f14_local2 = f14_arg0:IsEventFlag(12505901)
    local f14_local3 = f14_arg0:IsEventFlag(12505857)
    if f14_local2 and not f14_local3 then
        f14_arg0:SetEventMoveTarget(2502908)
        f14_arg1:AddSubGoal(GOAL_COMMON_Turn, 5, POINT_EVENT, f14_local1, -1, GOAL_RESULT_Success, true)
    end
    f14_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 1, 20000, TARGET_ENE_0, 9999, f14_local0, f14_local1, 0, 0)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act13 = function (f15_arg0, f15_arg1, f15_arg2)
    local f15_local0 = 9 - f15_arg0:GetMapHitRadius(TARGET_SELF)
    local f15_local1 = 9 - f15_arg0:GetMapHitRadius(TARGET_SELF) + 0
    local f15_local2 = 9 - f15_arg0:GetMapHitRadius(TARGET_SELF) + 999
    local f15_local3 = 100
    local f15_local4 = 0
    local f15_local5 = 1
    local f15_local6 = 4
    Approach_Act_Flex(f15_arg0, f15_arg1, f15_local0, f15_local1, f15_local2, f15_local3, f15_local4, f15_local5, f15_local6)
    local f15_local7 = 0
    local f15_local8 = 0
    f15_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 10, 3008, TARGET_ENE_0, 9999, f15_local7, f15_local8, 0, 0)
    f15_arg1:AddSubGoal(GOAL_COMMON_SidewayMove, 3, TARGET_ENE_0, 0, 45, true, true, -1)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act15 = function (f16_arg0, f16_arg1, f16_arg2)
    local f16_local0 = 0
    local f16_local1 = 0
    f16_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 10, 3020, TARGET_ENE_0, 9999, f16_local0, f16_local1, 0, 0)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act16 = function (f17_arg0, f17_arg1, f17_arg2)
    local f17_local0 = 0
    local f17_local1 = 0
    local f17_local2 = f17_arg0:GetRandam_Int(1, 2)
    if f17_local2 == 1 then
        f17_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 10, 3021, TARGET_ENE_0, 9999, f17_local0, f17_local1, 0, 0)
    else
        f17_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 10, 3022, TARGET_ENE_0, 9999, f17_local0, f17_local1, 0, 0)
    end
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act17 = function (f18_arg0, f18_arg1, f18_arg2)
    local f18_local0 = f18_arg0:GetRandam_Float(0, 0.8)
    f18_arg1:AddSubGoal(GOAL_COMMON_Wait, f18_local0, TARGET_SELF, 0, 0, 0)
    local f18_local1 = 0
    local f18_local2 = 0
    f18_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 10, 3006, TARGET_ENE_0, 9999, f18_local1, f18_local2, 0, 0)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act18 = function (f19_arg0, f19_arg1, f19_arg2)
    local f19_local0 = 0.5
    local f19_local1 = 10
    local f19_local2 = 15
    local f19_local3 = 0
    local f19_local4 = 0
    local f19_local5 = 1.5
    local f19_local6 = 2
    local f19_local7 = f19_arg0:GetDist(TARGET_TEAM_FORMATION)
    local f19_local8 = f19_arg0:GetDist(TARGET_TEAM_LEADER)
    local f19_local9 = f19_arg0:GetDistAtoB(TARGET_TEAM_LEADER, TARGET_ENE_0)
    f19_arg0:SetStringIndexedNumber(" targetDist ", f19_local7)
    f19_arg0:SetStringIndexedNumber(" leaderDist ", f19_local8)
    f19_arg0:SetStringIndexedNumber(" bossToTargetDist ", f19_local9)
    if f19_local7 <= f19_local0 then
        if f19_arg0:IsInsideTargetEx(TARGET_SELF, TARGET_TEAM_LEADER, AI_DIR_TYPE_R, 180, 999) then
            f19_arg1:AddSubGoal(GOAL_COMMON_SidewayMove, 1, TARGET_ENE_0, 1, 45, true, true, -1)
        else
            f19_arg1:AddSubGoal(GOAL_COMMON_SidewayMove, 1, TARGET_ENE_0, 0, 45, true, true, -1)
        end
    else
        f19_arg1:AddSubGoal(GOAL_COMMON_ApproachTarget, 2, TARGET_TEAM_FORMATION, f19_local0, TARGET_ENE_0, true, -1)
    end
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act19 = function (f20_arg0, f20_arg1, f20_arg2)
    local f20_local0 = 0.5
    local f20_local1 = 10
    local f20_local2 = 15
    local f20_local3 = 0
    local f20_local4 = 0
    local f20_local5 = 1.5
    local f20_local6 = 2
    local f20_local7 = 0
    local f20_local8 = f20_arg0:HasSpecialEffectId(TARGET_FRI_0, 3530030)
    local f20_local9 = f20_arg0:GetDist(TARGET_TEAM_FORMATION)
    local f20_local10 = f20_arg0:GetDist(TARGET_TEAM_LEADER)
    local f20_local11 = f20_arg0:GetDistAtoB(TARGET_TEAM_LEADER, TARGET_ENE_0)
    f20_arg0:SetStringIndexedNumber(" targetDist ", f20_local9)
    f20_arg0:SetStringIndexedNumber(" leaderDist ", f20_local10)
    f20_arg0:SetStringIndexedNumber(" bossToTargetDist ", f20_local11)
    if f20_arg0:IsInsideTargetEx(TARGET_SELF, TARGET_FRI_0, AI_DIR_TYPE_R, 180, 999) then
        f20_local7 = 1
    else
        f20_local7 = 0
    end
    if f20_local8 or f20_arg0:HasSpecialEffectId(TARGET_FRI_0, 200031) then
        if f20_local7 == 0 then
            f20_local7 = 1
        else
            f20_local7 = 0
        end
    end
    f20_arg1:AddSubGoal(GOAL_COMMON_SidewayMove, 1, TARGET_ENE_0, f20_local7, 45, true, true, -1)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act21 = function (f21_arg0, f21_arg1, f21_arg2)
    local f21_local0 = 3
    local f21_local1 = 45
    f21_arg1:AddSubGoal(GOAL_COMMON_Turn, f21_local0, TARGET_ENE_0, f21_local1, -1, GOAL_RESULT_Success, true)
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
    
end

Goal.Act23 = function (f22_arg0, f22_arg1, f22_arg2)
    local f22_local0 = f22_arg0:GetDist(TARGET_ENE_0)
    local f22_local1 = f22_arg0:GetRandam_Int(1, 100)
    local f22_local2 = -1
    local f22_local3 = 0
    if SpaceCheck(f22_arg0, f22_arg1, -90, 1) == true then
        if SpaceCheck(f22_arg0, f22_arg1, 90, 1) == true then
            if f22_arg0:IsInsideTargetEx(TARGET_ENE_0, TARGET_SELF, AI_DIR_TYPE_R, 180, 999) then
                f22_local3 = 1
            else
                f22_local3 = 0
            end
        else
            f22_local3 = 0
        end
    elseif SpaceCheck(f22_arg0, f22_arg1, 90, 1) == true then
        f22_local3 = 1
    else
    end
    local f22_local4 = 3
    local f22_local5 = f22_arg0:GetRandam_Int(30, 45)
    f22_arg0:SetNumber(10, f22_local3)
    f22_arg1:AddSubGoal(GOAL_COMMON_SidewayMove, f22_local4, TARGET_ENE_0, f22_local3, f22_local5, true, true, f22_local2)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act25 = function (f23_arg0, f23_arg1, f23_arg2)
    local f23_local0 = f23_arg0:GetRandam_Float(2, 4)
    local f23_local1 = f23_arg0:GetRandam_Float(5, 7)
    local f23_local2 = f23_arg0:GetDist(TARGET_ENE_0)
    local f23_local3 = -1
    f23_arg1:AddSubGoal(GOAL_COMMON_LeaveTarget, f23_local0, TARGET_ENE_0, f23_local1, TARGET_ENE_0, true, f23_local3)
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
    
end

Goal.Act26 = function (f24_arg0, f24_arg1, f24_arg2)
    f24_arg1:AddSubGoal(GOAL_COMMON_Wait, 5, TARGET_SELF, 0, 0, 0)
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
    
end

Goal.Act28 = function (f25_arg0, f25_arg1, f25_arg2)
    local f25_local0 = f25_arg0:GetDist(TARGET_ENE_0)
    local f25_local1 = f25_arg0:GetRandam_Int(2, 4)
    local f25_local2 = f25_arg0:GetRandam_Int(2, 4)
    local f25_local3 = f25_arg0:GetRandam_Int(1, 3)
    local f25_local4 = f25_arg0:GetRandam_Int(30, 45)
    local f25_local5 = -1
    local f25_local6 = f25_arg0:GetRandam_Int(0, 1)
    if f25_local0 <= 3 then
        f25_arg1:AddSubGoal(GOAL_COMMON_SidewayMove, f25_local1, TARGET_ENE_0, f25_local6, f25_local4, true, true, f25_local5)
    else
        f25_arg1:AddSubGoal(GOAL_COMMON_ApproachTarget, f25_local2, TARGET_ENE_0, 3, TARGET_SELF, true, -1)
    end
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
    
end

Goal.Act30 = function (f26_arg0, f26_arg1, f26_arg2)
    local f26_local0 = 0
    local f26_local1 = 0
    f26_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 10, 20000, TARGET_ENE_0, 9999, f26_local0, f26_local1, 0, 0)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act31 = function (f27_arg0, f27_arg1, f27_arg2)
    local f27_local0 = -1
    local f27_local1 = 0
    local f27_local2 = 0
    local f27_local3 = f27_arg0:GetDist(TARGET_ENE_0)
    local f27_local4 = f27_arg0:GetRandam_Int(6, 7)
    local f27_local5 = TARGET_ENE_0
    local f27_local6 = f27_arg0:IsEventFlag(12505901)
    local f27_local7 = f27_arg0:IsEventFlag(12505857)
    if f27_arg0:HasSpecialEffectId(TARGET_SELF, 200050) then
        local f27_local8 = f27_local6
    end
    local f27_local9 = f27_arg0:HasSpecialEffectId(TARGET_SELF, 3530030)
    local f27_local10 = AI_DIR_TYPE_ToF
    local f27_local11 = f27_arg0:GetRandam_Float(0, 2)
    local f27_local12 = f27_arg0:GetEventRequest()
    if f27_local12 == 30 then
        f27_local4 = f27_arg0:GetRandam_Int(10, 15)
    end
    f27_arg1:AddSubGoal(GOAL_COMMON_ApproachTarget, 10, f27_local5, f27_local4, TARGET_SELF, true, -1)
    if f27_local12 == 30 then
        f27_arg1:AddSubGoal(GOAL_COMMON_Wait, f27_local11, TARGET_SELF, 0, 0, 0)
        f27_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 3, 20001, TARGET_ENE_0, 9999, f27_local1, f27_local2, 0, 0)
    else
        f27_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 3, 20001, TARGET_ENE_0, 9999, f27_local1, f27_local2, 0, 0)
    end
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act32 = function (f28_arg0, f28_arg1, f28_arg2)
    local f28_local0 = f28_arg0:GetDist(TARGET_FRI_0)
    local f28_local1 = f28_arg0:GetSp(TARGET_SELF)
    local f28_local2 = 20
    local f28_local3 = f28_arg0:GetRandam_Int(1, 100)
    local f28_local4 = -1
    local f28_local5 = 0
    if SpaceCheck(f28_arg0, f28_arg1, -90, 1) == true then
        if SpaceCheck(f28_arg0, f28_arg1, 90, 1) == true then
            if f28_arg0:IsInsideTargetEx(TARGET_SELF, TARGET_FRI_0, AI_DIR_TYPE_R, 180, 999) then
                f28_local5 = 0
            else
                f28_local5 = 1
            end
        else
            f28_local5 = 0
        end
    elseif SpaceCheck(f28_arg0, f28_arg1, 90, 1) == true then
        f28_local5 = 1
    else
    end
    local f28_local6 = 2
    local f28_local7 = f28_arg0:GetRandam_Int(30, 45)
    f28_arg0:SetNumber(10, f28_local5)
    f28_arg1:AddSubGoal(GOAL_COMMON_SidewayMove, f28_local6, TARGET_ENE_0, f28_local5, f28_local7, true, true, f28_local4)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act33 = function (f29_arg0, f29_arg1, f29_arg2)
    local f29_local0 = 7
    local f29_local1 = 10
    local f29_local2 = 15
    local f29_local3 = 0
    local f29_local4 = 0
    local f29_local5 = 1.5
    local f29_local6 = 2
    local f29_local7 = f29_arg0:GetDist(TARGET_ENE_0)
    local f29_local8 = f29_arg0:GetDist(TARGET_TEAM_LEADER)
    local f29_local9 = f29_arg0:GetDistAtoB(TARGET_TEAM_LEADER, TARGET_ENE_0)
    f29_arg0:SetStringIndexedNumber(" targetDist ", f29_local7)
    f29_arg0:SetStringIndexedNumber(" leaderDist ", f29_local8)
    f29_arg0:SetStringIndexedNumber(" bossToTargetDist ", f29_local9)
    local f29_local10 = AI_DIR_TYPE_ToF
    if f29_arg0:IsInsideTargetEx(TARGET_SELF, TARGET_TEAM_LEADER, AI_DIR_TYPE_R, 180, 999) then
        f29_arg1:AddSubGoal(GOAL_COMMON_SidewayMove, 3, TARGET_ENE_0, 0, 45, true, true, -1)
    else
        f29_arg1:AddSubGoal(GOAL_COMMON_SidewayMove, 3, TARGET_ENE_0, 1, 45, true, true, -1)
    end
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act40 = function (f30_arg0, f30_arg1, f30_arg2)
    local f30_local0 = f30_arg0:GetDist(TARGET_ENE_0)
    local f30_local1 = 0
    local f30_local2 = 180
    local f30_local3 = f30_arg0:GetRandam_Int(1, 2)
    local f30_local4 = f30_arg0:GetRandam_Int(0, 1)
    if f30_arg0:HasSpecialEffectId(TARGET_SELF, 200030) then
        f30_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 10, 20000, TARGET_ENE_0, 9999, f30_local1, f30_local2, 0, 0)
    end
    if f30_local0 >= 3 then
        f30_arg1:AddSubGoal(GOAL_COMMON_ApproachTarget, 3, TARGET_ENE_0, 2.9, TARGET_SELF, true, -1)
    else
        f30_arg1:AddSubGoal(GOAL_COMMON_Wait, 0.5, TARGET_SELF, 0, 0, 0)
    end
    f30_arg0:SetNumber(0, 1)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act41 = function (f31_arg0, f31_arg1, f31_arg2)
    local f31_local0 = 0
    local f31_local1 = 180
    local f31_local2 = f31_arg0:GetRandam_Int(1, 2)
    f31_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 10, 20000, TARGET_ENE_0, 9999, f31_local0, f31_local1, 0, 0)
    f31_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 10, 3018, TARGET_ENE_0, 9999, f31_local0, f31_local1, 0, 0)
    f31_arg0:SetNumber(0, 1)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Interrupt = function (f32_arg0, f32_arg1, f32_arg2)
    local f32_local0 = f32_arg1:GetSpecialEffectActivateInterruptType(0)
    if f32_arg1:IsLadderAct(TARGET_SELF) then
        return false
    end
    if not f32_arg1:HasSpecialEffectId(TARGET_SELF, 200004) then
        return false
    end
    if f32_arg1:IsInterupt(INTERUPT_ActivateSpecialEffect) then
    end
    return false
    
end

Goal.ActAfter_AdjustSpace = function (f33_arg0, f33_arg1, f33_arg2)
    
end

Goal.Update = function (f34_arg0, f34_arg1, f34_arg2)
    return Update_Default_NoSubGoal(f34_arg0, f34_arg1, f34_arg2)
    
end

Goal.Terminate = function (f35_arg0, f35_arg1, f35_arg2)
    
end


