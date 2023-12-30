RegisterTableGoal(GOAL_RedOgre_502000_Battle, "GOAL_RedOgre_502000_Battle")
REGISTER_GOAL_NO_SUB_GOAL(GOAL_RedOgre_502000_Battle, true)

Goal.Initialize = function (f1_arg0, f1_arg1, f1_arg2, f1_arg3)
    
end

Goal.Activate = function (f2_arg0, f2_arg1, f2_arg2)
    f2_arg1:SetNumber(5, 0)
    Init_Pseudo_Global(f2_arg1, f2_arg2)
    f2_arg1:SetStringIndexedNumber("Dist_Step_Small", 2)
    f2_arg1:SetStringIndexedNumber("Dist_Step_Large", 4)
    f2_arg1:SetStringIndexedNumber("KengekiID", 0)
    local f2_local0 = {}
    local f2_local1 = {}
    local f2_local2 = {}
    Common_Clear_Param(f2_local0, f2_local1, f2_local2)
    local f2_local3 = f2_arg1:GetHpRate(TARGET_SELF)
    local f2_local4 = f2_arg1:GetSp(TARGET_SELF)
    local f2_local5 = f2_arg1:GetDist(TARGET_ENE_0)
    local f2_local6 = f2_arg1:GetExcelParam(AI_EXCEL_THINK_PARAM_TYPE__thinkATTr_doAdmirer)
    local f2_local7 = Check_ReachAttack(f2_arg1, 0)
    local f2_local8 = f2_arg1:GetEventRequest()
    local f2_local9 = f2_arg1:GetNinsatsuNum()
    f2_arg1:SetNumber(5, 0)
    f2_arg1:AddObserveSpecialEffectAttribute(TARGET_SELF, 5025)
    f2_arg1:AddObserveSpecialEffectAttribute(TARGET_SELF, 5026)
    f2_arg1:AddObserveSpecialEffectAttribute(TARGET_SELF, 3502000)
    f2_arg1:AddObserveSpecialEffectAttribute(TARGET_ENE_0, 3502010)
    f2_arg1:AddObserveSpecialEffectAttribute(TARGET_SELF, 3502540)
    f2_arg1:AddObserveSpecialEffectAttribute(TARGET_ENE_0, 100401)
    if Common_ActivateAct(f2_arg1, f2_arg2, 1) then
    elseif f2_local7 ~= POSSIBLE_ATTACK then
        if f2_local7 == UNREACH_ATTACK then
            if f2_arg1:IsInsideTargetRegion(TARGET_SELF, 1102318) then
                f2_local0[45] = 100
                f2_local0[46] = 100
                f2_local0[47] = 200
            else
                f2_local0[27] = 100
            end
        elseif f2_local7 == REACH_ATTACK_TARGET_HIGH_POSITION then
            f2_local0[4] = 100
            f2_local0[7] = 100
        elseif f2_local7 == REACH_ATTACK_TARGET_LOW_POSITION then
            f2_local0[3] = 100
            f2_local0[11] = 100
        elseif f2_arg1:IsInsideTargetRegion(TARGET_SELF, 1102318) then
            f2_local0[45] = 100
            f2_local0[46] = 100
            f2_local0[47] = 200
        else
            f2_local0[27] = 100
        end
    elseif f2_arg1:GetNumber(0) == 1 and f2_arg1:HasSpecialEffectId(TARGET_SELF, 200030) then
        f2_local0[10] = 100
    elseif f2_local3 <= 0.7 and f2_arg1:HasSpecialEffectId(TARGET_SELF, 200030) then
        f2_local0[10] = 100
    elseif f2_arg1:HasSpecialEffectId(TARGET_SELF, 5270) and f2_arg1:HasSpecialEffectId(TARGET_SELF, 200030) then
        f2_local0[10] = 100
    elseif f2_arg1:HasSpecialEffectId(TARGET_SELF, 3502540) then
        f2_local0[25] = 10000
        f2_local0[27] = 100
    elseif f2_arg1:IsInsideTarget(TARGET_ENE_0, AI_DIR_TYPE_B, 180) then
        if f2_local5 > 7 then
            f2_local0[21] = 100
        elseif f2_local5 > 5 then
            f2_local0[21] = 100
        else
            f2_local0[21] = 100
        end
    elseif f2_arg1:GetNumber(1) == 0 and f2_arg1:HasSpecialEffectId(TARGET_SELF, 3502500) then
        f2_local0[20] = 100
    elseif f2_arg1:HasSpecialEffectId(TARGET_ENE_0, 3502540) and f2_local5 <= 7 then
        f2_local0[23] = 100
    elseif f2_arg1:HasSpecialEffectId(TARGET_SELF, 200031) and f2_arg1:HasSpecialEffectId(TARGET_SELF, 5020) and f2_arg1:GetNumber(2) == 0 then
        if f2_local5 >= 5 then
            f2_local0[1] = 1
            f2_local0[8] = 50000000
        else
            f2_local0[1] = 1
            f2_local0[9] = 50000000
        end
    elseif f2_arg1:HasSpecialEffectId(TARGET_ENE_0, COMMON_SP_EFFECT_PC_BREAK) then
        if f2_arg1:HasSpecialEffectId(TARGET_SELF, 200031) then
            if f2_local5 >= 7 then
                f2_local0[14] = 100
            else
                f2_local0[9] = 100
            end
        elseif f2_local5 >= 7 then
            f2_local0[5] = 200
        else
            f2_local0[3] = 100
        end
    elseif not f2_arg1:HasSpecialEffectId(TARGET_SELF, 200031) then
        if f2_local5 >= 7 then
            f2_local0[5] = 200
        else
            f2_local0[1] = 100
            f2_local0[2] = 100
            f2_local0[3] = 100
            f2_local0[4] = 100
        end
    elseif f2_local5 >= 8 then
        f2_local0[1] = 0
        f2_local0[2] = 0
        f2_local0[3] = 50
        f2_local0[4] = 0
        f2_local0[5] = 200
        f2_local0[6] = 0
        f2_local0[7] = 0
        f2_local0[8] = 100
        f2_local0[9] = 0
        f2_local0[13] = 0
        f2_local0[14] = 100
    elseif f2_local5 >= 7 then
        f2_local0[1] = 0
        f2_local0[3] = 100
        f2_local0[5] = 200
        f2_local0[6] = 0
        f2_local0[8] = 100
        f2_local0[14] = 100
    elseif f2_local5 >= 5 then
        f2_local0[1] = 30
        f2_local0[2] = 50
        f2_local0[3] = 100
        f2_local0[6] = 0
        f2_local0[7] = 0
        f2_local0[8] = 100
        f2_local0[9] = 0
        f2_local0[13] = 50
        f2_local0[14] = 0
    elseif f2_local5 > 3 then
        f2_local0[1] = 100
        f2_local0[2] = 100
        f2_local0[3] = 100
        f2_local0[4] = 100
        f2_local0[5] = 0
        f2_local0[6] = 0
        f2_local0[7] = 0
        f2_local0[8] = 0
        f2_local0[9] = 100
        f2_local0[13] = 100
        f2_local0[14] = 0
    elseif f2_local5 > 1 then
        f2_local0[1] = 100
        f2_local0[2] = 100
        f2_local0[4] = 100
        f2_local0[6] = 0
        f2_local0[7] = 100
        f2_local0[9] = 100
        f2_local0[11] = 100
        f2_local0[13] = 100
        f2_local0[14] = 0
    else
        f2_local0[6] = 200
        f2_local0[7] = 200
        f2_local0[9] = 50
        f2_local0[11] = 100
    end
    if f2_arg1:IsFinishTimer(0) == false then
        f2_local0[6] = 0
        f2_local0[8] = 0
        f2_local0[9] = 0
        f2_local0[13] = 0
        f2_local0[14] = 0
    end
    if f2_arg1:HasSpecialEffectId(TARGET_ENE_0, 3101520) then
        f2_local0[6] = 0
        f2_local0[8] = 0
        f2_local0[9] = 0
        f2_local0[13] = 0
        f2_local0[14] = 0
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
    f2_local0[1] = SetCoolTime(f2_arg1, f2_arg2, 3000, 10, f2_local0[1], 1)
    f2_local0[2] = SetCoolTime(f2_arg1, f2_arg2, 3001, 15, f2_local0[2], 1)
    f2_local0[3] = SetCoolTime(f2_arg1, f2_arg2, 3002, 8, f2_local0[3], 1)
    f2_local0[4] = SetCoolTime(f2_arg1, f2_arg2, 3003, 8, f2_local0[4], 1)
    f2_local0[5] = SetCoolTime(f2_arg1, f2_arg2, 3004, 8, f2_local0[5], 1)
    f2_local0[6] = SetCoolTime(f2_arg1, f2_arg2, 3005, 8, f2_local0[6], 1)
    f2_local0[7] = SetCoolTime(f2_arg1, f2_arg2, 3006, 8, f2_local0[7], 1)
    f2_local0[8] = SetCoolTime(f2_arg1, f2_arg2, 3007, 8, f2_local0[8], 1)
    f2_local0[9] = SetCoolTime(f2_arg1, f2_arg2, 3008, 8, f2_local0[9], 1)
    f2_local0[11] = SetCoolTime(f2_arg1, f2_arg2, 3011, 8, f2_local0[11], 1)
    f2_local0[13] = SetCoolTime(f2_arg1, f2_arg2, 3013, 8, f2_local0[13], 1)
    f2_local0[14] = SetCoolTime(f2_arg1, f2_arg2, 3014, 8, f2_local0[14], 1)
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
    f2_local1[13] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act13)
    f2_local1[14] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act14)
    f2_local1[20] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act20)
    f2_local1[21] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act21)
    f2_local1[23] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act23)
    f2_local1[25] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act25)
    f2_local1[26] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act26)
    f2_local1[27] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act27)
    f2_local1[28] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act28)
    f2_local1[30] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act30)
    f2_local1[31] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act31)
    f2_local1[41] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act41)
    f2_local1[45] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act45)
    f2_local1[46] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act46)
    f2_local1[47] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act47)
    local f2_local10 = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.ActAfter_AdjustSpace)
    Common_Battle_Activate(f2_arg1, f2_arg2, f2_local0, f2_local1, f2_local10, f2_local2)
    
end

Goal.Act01 = function (f3_arg0, f3_arg1, f3_arg2)
    local f3_local0 = 4 - f3_arg0:GetMapHitRadius(TARGET_SELF) - 1.5
    local f3_local1 = 4 - f3_arg0:GetMapHitRadius(TARGET_SELF)
    local f3_local2 = 4 - f3_arg0:GetMapHitRadius(TARGET_SELF)
    local f3_local3 = 100
    local f3_local4 = 0
    local f3_local5 = 3
    local f3_local6 = 3
    if f3_arg0:IsExistMeshOnLine(TARGET_ENE_0, AI_DIR_TYPE_ToF, 8) == false then
        f3_arg1:AddSubGoal(GOAL_COMMON_ApproachTarget, 10, TARGET_ENE_0, 1, TARGET_SELF, false, -1)
    else
        Approach_Act_Flex(f3_arg0, f3_arg1, f3_local0, f3_local1, f3_local2, f3_local3, f3_local4, f3_local5, f3_local6)
    end
    local f3_local7 = 3000
    local f3_local8 = 3015
    local f3_local9 = 4 - f3_arg0:GetMapHitRadius(TARGET_SELF)
    local f3_local10 = 0
    local f3_local11 = 0
    local f3_local12 = f3_arg0:GetRandam_Int(1, 100)
    if f3_arg0:HasSpecialEffectId(TARGET_SELF, 200031) then
        if f3_local12 <= 50 then
            f3_arg1:AddSubGoal(GOAL_COMMON_ComboAttackTunableSpin, 10, f3_local7, TARGET_ENE_0, 9999, f3_local10, f3_local11, 0, 0)
            f3_arg1:AddSubGoal(GOAL_COMMON_ComboRepeat, 10, f3_local8, TARGET_ENE_0, 9999, 0, 0)
        else
            f3_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 4, f3_local7, TARGET_ENE_0, 9999, f3_local10, f3_local11, 0, 0)
        end
    else
        f3_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 4, f3_local7, TARGET_ENE_0, 9999, f3_local10, f3_local11, 0, 0)
    end
    
end

Goal.Act02 = function (f4_arg0, f4_arg1, f4_arg2)
    local f4_local0 = 4 - f4_arg0:GetMapHitRadius(TARGET_SELF) - 1
    local f4_local1 = 4 - f4_arg0:GetMapHitRadius(TARGET_SELF)
    local f4_local2 = 4 - f4_arg0:GetMapHitRadius(TARGET_SELF)
    local f4_local3 = 100
    local f4_local4 = 0
    local f4_local5 = 3
    local f4_local6 = 3
    if f4_arg0:IsExistMeshOnLine(TARGET_ENE_0, AI_DIR_TYPE_ToF, 8) == false then
        f4_arg1:AddSubGoal(GOAL_COMMON_ApproachTarget, 10, TARGET_ENE_0, 1, TARGET_SELF, false, -1)
    else
        Approach_Act_Flex(f4_arg0, f4_arg1, f4_local0, f4_local1, f4_local2, f4_local3, f4_local4, f4_local5, f4_local6)
    end
    local f4_local7 = 3001
    local f4_local8 = 0
    local f4_local9 = 0
    f4_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 4, f4_local7, TARGET_ENE_0, 9999, f4_local8, f4_local9, 0, 0)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act03 = function (f5_arg0, f5_arg1, f5_arg2)
    local f5_local0 = 3.8 - f5_arg0:GetMapHitRadius(TARGET_SELF) - 0.5
    local f5_local1 = 3.8 - f5_arg0:GetMapHitRadius(TARGET_SELF)
    local f5_local2 = 3.8 - f5_arg0:GetMapHitRadius(TARGET_SELF)
    local f5_local3 = 100
    local f5_local4 = 0
    local f5_local5 = 3
    local f5_local6 = 3
    if f5_arg0:IsExistMeshOnLine(TARGET_ENE_0, AI_DIR_TYPE_ToF, 8) == false then
        f5_arg1:AddSubGoal(GOAL_COMMON_ApproachTarget, 10, TARGET_ENE_0, 1, TARGET_SELF, false, -1)
    else
        Approach_Act_Flex(f5_arg0, f5_arg1, f5_local0, f5_local1, f5_local2, f5_local3, f5_local4, f5_local5, f5_local6)
    end
    local f5_local7 = 3002
    local f5_local8 = 0
    local f5_local9 = 0
    f5_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 4, f5_local7, TARGET_ENE_0, 9999, f5_local8, f5_local9, 0, 0)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act04 = function (f6_arg0, f6_arg1, f6_arg2)
    local f6_local0 = 5.9 - f6_arg0:GetMapHitRadius(TARGET_SELF) - 1.5
    local f6_local1 = 5.9 - f6_arg0:GetMapHitRadius(TARGET_SELF)
    local f6_local2 = 5.9 - f6_arg0:GetMapHitRadius(TARGET_SELF)
    local f6_local3 = 100
    local f6_local4 = 0
    local f6_local5 = 3
    local f6_local6 = 3
    if f6_arg0:IsExistMeshOnLine(TARGET_ENE_0, AI_DIR_TYPE_ToF, 8) == false then
        f6_arg1:AddSubGoal(GOAL_COMMON_ApproachTarget, 10, TARGET_ENE_0, 1, TARGET_SELF, false, -1)
    else
        Approach_Act_Flex(f6_arg0, f6_arg1, f6_local0, f6_local1, f6_local2, f6_local3, f6_local4, f6_local5, f6_local6)
    end
    local f6_local7 = 3003
    local f6_local8 = 0
    local f6_local9 = 0
    f6_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 5, f6_local7, TARGET_ENE_0, 9999, f6_local8, f6_local9, 0, 0)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act05 = function (f7_arg0, f7_arg1, f7_arg2)
    local f7_local0 = 9.6 - f7_arg0:GetMapHitRadius(TARGET_SELF)
    local f7_local1 = 9.6 - f7_arg0:GetMapHitRadius(TARGET_SELF)
    local f7_local2 = 9.6 - f7_arg0:GetMapHitRadius(TARGET_SELF)
    local f7_local3 = 100
    local f7_local4 = 0
    local f7_local5 = 3
    local f7_local6 = 3
    if f7_arg0:IsExistMeshOnLine(TARGET_ENE_0, AI_DIR_TYPE_ToF, 8) == false then
        f7_arg1:AddSubGoal(GOAL_COMMON_ApproachTarget, 10, TARGET_ENE_0, 1, TARGET_SELF, false, -1)
    else
        Approach_Act_Flex(f7_arg0, f7_arg1, f7_local0, f7_local1, f7_local2, f7_local3, f7_local4, f7_local5, f7_local6)
    end
    local f7_local7 = 3004
    local f7_local8 = 0
    local f7_local9 = 0
    f7_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 5, f7_local7, TARGET_ENE_0, 9999, f7_local8, f7_local9, 0, 0)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act06 = function (f8_arg0, f8_arg1, f8_arg2)
    local f8_local0 = 3005
    local f8_local1 = 0
    local f8_local2 = 0
    f8_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 10, f8_local0, TARGET_ENE_0, 9999, f8_local1, f8_local2, 0, 0)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act07 = function (f9_arg0, f9_arg1, f9_arg2)
    local f9_local0 = 2 - f9_arg0:GetMapHitRadius(TARGET_SELF) - 0.5
    local f9_local1 = 2 - f9_arg0:GetMapHitRadius(TARGET_SELF)
    local f9_local2 = 2 - f9_arg0:GetMapHitRadius(TARGET_SELF)
    local f9_local3 = 100
    local f9_local4 = 0
    local f9_local5 = 3
    local f9_local6 = 3
    if f9_arg0:IsExistMeshOnLine(TARGET_ENE_0, AI_DIR_TYPE_ToF, 3) == false then
        f9_arg1:AddSubGoal(GOAL_COMMON_ApproachTarget, 10, TARGET_ENE_0, 1, TARGET_SELF, false, -1)
    else
        Approach_Act_Flex(f9_arg0, f9_arg1, f9_local0, f9_local1, f9_local2, f9_local3, f9_local4, f9_local5, f9_local6)
    end
    local f9_local7 = 3006
    local f9_local8 = 0
    local f9_local9 = 0
    f9_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 10, f9_local7, TARGET_ENE_0, 9999, f9_local8, f9_local9, 0, 0)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act08 = function (f10_arg0, f10_arg1, f10_arg2)
    local f10_local0 = 8.5 - f10_arg0:GetMapHitRadius(TARGET_SELF)
    local f10_local1 = 8.5 - f10_arg0:GetMapHitRadius(TARGET_SELF)
    local f10_local2 = 8.5 - f10_arg0:GetMapHitRadius(TARGET_SELF)
    local f10_local3 = 100
    local f10_local4 = 0
    local f10_local5 = 3
    local f10_local6 = 3
    Approach_Act_Flex(f10_arg0, f10_arg1, f10_local0, f10_local1, f10_local2, f10_local3, f10_local4, f10_local5, f10_local6)
    local f10_local7 = 3007
    local f10_local8 = 0
    local f10_local9 = 0
    f10_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 10, f10_local7, TARGET_ENE_0, 9999, f10_local8, f10_local9, 0, 0):TimingSetNumber(2, 1, AI_TIMING_SET__ACTIVATE)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act09 = function (f11_arg0, f11_arg1, f11_arg2)
    local f11_local0 = 5.4 - f11_arg0:GetMapHitRadius(TARGET_SELF)
    local f11_local1 = 5.4 - f11_arg0:GetMapHitRadius(TARGET_SELF)
    local f11_local2 = 5.4 - f11_arg0:GetMapHitRadius(TARGET_SELF)
    local f11_local3 = 100
    local f11_local4 = 0
    local f11_local5 = 3
    local f11_local6 = 3
    if f11_arg0:IsExistMeshOnLine(TARGET_ENE_0, AI_DIR_TYPE_ToF, 8) == false then
        f11_arg1:AddSubGoal(GOAL_COMMON_ApproachTarget, 10, TARGET_ENE_0, 1, TARGET_SELF, false, -1)
    else
        Approach_Act_Flex(f11_arg0, f11_arg1, f11_local0, f11_local1, f11_local2, f11_local3, f11_local4, f11_local5, f11_local6)
    end
    local f11_local7 = 3008
    local f11_local8 = 0
    local f11_local9 = 0
    f11_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 10, f11_local7, TARGET_ENE_0, 9999, f11_local8, f11_local9, 0, 0):TimingSetNumber(2, 1, AI_TIMING_SET__ACTIVATE)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act10 = function (f12_arg0, f12_arg1, f12_arg2)
    local f12_local0 = 3010
    local f12_local1 = 0
    local f12_local2 = 0
    f12_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 10, f12_local0, TARGET_ENE_0, 9999, f12_local1, f12_local2, 0, 0)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act11 = function (f13_arg0, f13_arg1, f13_arg2)
    local f13_local0 = 4.2 - f13_arg0:GetMapHitRadius(TARGET_SELF)
    local f13_local1 = 4.2 - f13_arg0:GetMapHitRadius(TARGET_SELF)
    local f13_local2 = 4.2 - f13_arg0:GetMapHitRadius(TARGET_SELF)
    local f13_local3 = 100
    local f13_local4 = 0
    local f13_local5 = 3
    local f13_local6 = 3
    if f13_arg0:IsExistMeshOnLine(TARGET_ENE_0, AI_DIR_TYPE_ToF, 8) == false then
        f13_arg1:AddSubGoal(GOAL_COMMON_ApproachTarget, 10, TARGET_ENE_0, 1, TARGET_SELF, false, -1)
    else
        Approach_Act_Flex(f13_arg0, f13_arg1, f13_local0, f13_local1, f13_local2, f13_local3, f13_local4, f13_local5, f13_local6)
    end
    local f13_local7 = 3011
    local f13_local8 = 0
    local f13_local9 = 0
    f13_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 10, f13_local7, TARGET_ENE_0, 9999, f13_local8, f13_local9, 0, 0)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act13 = function (f14_arg0, f14_arg1, f14_arg2)
    local f14_local0 = 5.4 - f14_arg0:GetMapHitRadius(TARGET_SELF) - 1
    local f14_local1 = 5.4 - f14_arg0:GetMapHitRadius(TARGET_SELF)
    local f14_local2 = 5.4 - f14_arg0:GetMapHitRadius(TARGET_SELF)
    local f14_local3 = 100
    local f14_local4 = 0
    local f14_local5 = 3
    local f14_local6 = 3
    if f14_arg0:IsExistMeshOnLine(TARGET_ENE_0, AI_DIR_TYPE_ToF, 8) == false then
        f14_arg1:AddSubGoal(GOAL_COMMON_ApproachTarget, 10, TARGET_ENE_0, 1, TARGET_SELF, false, -1)
    else
        Approach_Act_Flex(f14_arg0, f14_arg1, f14_local0, f14_local1, f14_local2, f14_local3, f14_local4, f14_local5, f14_local6)
    end
    local f14_local7 = 3013
    local f14_local8 = 0
    local f14_local9 = 0
    f14_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 10, f14_local7, TARGET_ENE_0, 9999, f14_local8, f14_local9, 0, 0)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act14 = function (f15_arg0, f15_arg1, f15_arg2)
    local f15_local0 = 9.4 - f15_arg0:GetMapHitRadius(TARGET_SELF)
    local f15_local1 = 9.4 - f15_arg0:GetMapHitRadius(TARGET_SELF)
    local f15_local2 = 9.4 - f15_arg0:GetMapHitRadius(TARGET_SELF)
    local f15_local3 = 100
    local f15_local4 = 0
    local f15_local5 = 3
    local f15_local6 = 3
    Approach_Act_Flex(f15_arg0, f15_arg1, f15_local0, f15_local1, f15_local2, f15_local3, f15_local4, f15_local5, f15_local6)
    local f15_local7 = 3014
    local f15_local8 = 0
    local f15_local9 = 0
    f15_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 10, f15_local7, TARGET_ENE_0, 9999, f15_local8, f15_local9, 0, 0)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act20 = function (f16_arg0, f16_arg1, f16_arg2)
    local f16_local0 = 1040
    local f16_local1 = 0
    local f16_local2 = 0
    f16_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 10, f16_local0, TARGET_ENE_0, 9999, f16_local1, f16_local2, 0, 0):TimingSetNumber(1, 1, AI_TIMING_SET__UPDATE_SUCCESS)
    f16_arg0:SetTimer(0, 30)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act30 = function (f17_arg0, f17_arg1, f17_arg2)
    local f17_local0 = 5.4 - f17_arg0:GetMapHitRadius(TARGET_SELF)
    local f17_local1 = 5.4 - f17_arg0:GetMapHitRadius(TARGET_SELF) + 0
    local f17_local2 = 5.4 - f17_arg0:GetMapHitRadius(TARGET_SELF) + 2
    local f17_local3 = 100
    local f17_local4 = 0
    local f17_local5 = 3
    local f17_local6 = 3
    Approach_Act_Flex(f17_arg0, f17_arg1, f17_local0, f17_local1, f17_local2, f17_local3, f17_local4, f17_local5, f17_local6)
    local f17_local7 = 3008
    local f17_local8 = 0
    local f17_local9 = 0
    f17_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 10, f17_local7, TARGET_ENE_0, 9999, f17_local8, f17_local9, 0, 0)
    f17_arg0:SetNumber(5, 1)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act31 = function (f18_arg0, f18_arg1, f18_arg2)
    local f18_local0 = 5.4 - f18_arg0:GetMapHitRadius(TARGET_SELF)
    local f18_local1 = 5.4 - f18_arg0:GetMapHitRadius(TARGET_SELF) + 0
    local f18_local2 = 5.4 - f18_arg0:GetMapHitRadius(TARGET_SELF) + 2
    local f18_local3 = 100
    local f18_local4 = 0
    local f18_local5 = 1.5
    local f18_local6 = 3
    Approach_Act_Flex(f18_arg0, f18_arg1, f18_local0, f18_local1, f18_local2, f18_local3, f18_local4, f18_local5, f18_local6)
    local f18_local7 = 3013
    local f18_local8 = 0
    local f18_local9 = 0
    f18_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 10, f18_local7, TARGET_ENE_0, 9999, f18_local8, f18_local9, 0, 0)
    f18_arg0:SetNumber(5, 1)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act21 = function (f19_arg0, f19_arg1, f19_arg2)
    local f19_local0 = 3
    local f19_local1 = 45
    f19_arg1:AddSubGoal(GOAL_COMMON_Turn, f19_local0, TARGET_ENE_0, f19_local1, -1, GOAL_RESULT_Success, true)
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
    
end

Goal.Act23 = function (f20_arg0, f20_arg1, f20_arg2)
    local f20_local0 = f20_arg0:GetDist(TARGET_ENE_0)
    local f20_local1 = f20_arg0:GetSp(TARGET_SELF)
    local f20_local2 = 20
    local f20_local3 = f20_arg0:GetRandam_Int(1, 100)
    local f20_local4 = -1
    local f20_local5 = 0
    if SpaceCheck(f20_arg0, f20_arg1, -90, 1) == true then
        if SpaceCheck(f20_arg0, f20_arg1, 90, 1) == true then
            if f20_arg0:IsInsideTarget(TARGET_ENE_0, AI_DIR_TYPE_R, 180) then
                f20_local5 = 0
            else
                f20_local5 = 1
            end
        else
            f20_local5 = 0
        end
    elseif SpaceCheck(f20_arg0, f20_arg1, 90, 1) == true then
        f20_local5 = 1
    else
    end
    local f20_local6 = 3
    local f20_local7 = f20_arg0:GetRandam_Int(30, 45)
    f20_arg0:SetNumber(10, f20_local5)
    f20_arg1:AddSubGoal(GOAL_COMMON_SidewayMove, f20_local6, TARGET_ENE_0, f20_local5, f20_local7, true, true, f20_local4)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act25 = function (f21_arg0, f21_arg1, f21_arg2)
    local f21_local0 = f21_arg0:GetRandam_Float(2, 4)
    local f21_local1 = 4
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
    if YousumiAct_SubGoal(f23_arg0, f23_arg1, true, 50, 30) == false then
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
        f23_arg1:AddSubGoal(GOAL_COMMON_Wait, 1, TARGET_SELF, 0, 0, 0)
        GetWellSpace_Odds = 0
        return GetWellSpace_Odds
    end
    f23_arg0:SetNumber(10, f23_local1)
    f23_arg1:AddSubGoal(GOAL_COMMON_SidewayMove, 3, TARGET_ENE_0, f23_local1, f23_arg0:GetRandam_Int(30, 45), true, true, -1)
    f23_arg0:SetNumber(NUMBER_SLOT_FIGHT_COUNT, 0)
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
    if f24_local0 <= 5 then
        f24_arg1:AddSubGoal(GOAL_COMMON_SidewayMove, f24_local1, TARGET_ENE_0, f24_local5, f24_local3, true, true, f24_local4)
    else
        f24_arg1:AddSubGoal(GOAL_COMMON_ApproachTarget, f24_local2, TARGET_ENE_0, 3, TARGET_SELF, true, -1)
    end
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
    
end

Goal.Act41 = function (f25_arg0, f25_arg1, f25_arg2)
    local f25_local0 = f25_arg0:GetDist(TARGET_ENE_0)
    local f25_local1 = 1.5
    local f25_local2 = 1.5
    local f25_local3 = f25_arg0:GetRandam_Int(30, 45)
    local f25_local4 = -1
    local f25_local5 = f25_arg0:GetRandam_Int(0, 1)
    if f25_local0 <= 3 then
        f25_arg1:AddSubGoal(GOAL_COMMON_LeaveTarget, WalkLife, TARGET_ENE_0, 4, TARGET_ENE_0, true, guard)
    else
        f25_arg1:AddSubGoal(GOAL_COMMON_SidewayMove, f25_local1, TARGET_ENE_0, f25_local5, f25_local3, true, true, f25_local4)
    end
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
    
end

Goal.Act45 = function (f26_arg0, f26_arg1, f26_arg2)
    local f26_local0 = 2 - f26_arg0:GetMapHitRadius(TARGET_SELF) - 0.5
    local f26_local1 = 2 - f26_arg0:GetMapHitRadius(TARGET_SELF)
    local f26_local2 = 2 - f26_arg0:GetMapHitRadius(TARGET_SELF)
    local f26_local3 = 100
    local f26_local4 = 0
    local f26_local5 = 3
    local f26_local6 = 3
    local f26_local7 = 3006
    local f26_local8 = 0
    local f26_local9 = 0
    f26_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 10, f26_local7, TARGET_ENE_0, 9999, f26_local8, f26_local9, 0, 0)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act46 = function (f27_arg0, f27_arg1, f27_arg2)
    local f27_local0 = 3.8 - f27_arg0:GetMapHitRadius(TARGET_SELF) - 0.5
    local f27_local1 = 3.8 - f27_arg0:GetMapHitRadius(TARGET_SELF)
    local f27_local2 = 3.8 - f27_arg0:GetMapHitRadius(TARGET_SELF)
    local f27_local3 = 100
    local f27_local4 = 0
    local f27_local5 = 3
    local f27_local6 = 3
    local f27_local7 = 3002
    local f27_local8 = 0
    local f27_local9 = 0
    f27_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 4, f27_local7, TARGET_ENE_0, 9999, f27_local8, f27_local9, 0, 0)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act47 = function (f28_arg0, f28_arg1, f28_arg2)
    local f28_local0 = 0
    local f28_local1 = 180
    local f28_local2 = f28_arg0:GetRandam_Int(1, 100)
    f28_arg0:SetEventMoveTarget(1102319)
    f28_arg1:AddSubGoal(GOAL_COMMON_ApproachTarget, 5, POINT_EVENT, 0.2, TARGET_SELF, false, -1)
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
    
end

Goal.Interrupt = function (f29_arg0, f29_arg1, f29_arg2)
    local f29_local0 = f29_arg1:GetHpRate(TARGET_SELF)
    local f29_local1 = f29_arg1:GetDist(TARGET_ENE_0)
    local f29_local2 = f29_arg1:GetSp(TARGET_SELF)
    local f29_local3 = f29_arg1:GetSpecialEffectActivateInterruptType(0)
    local f29_local4 = f29_arg1:GetNinsatsuNum()
    local f29_local5 = f29_arg1:GetRandam_Int(1, 100)
    if f29_arg1:IsLadderAct(TARGET_SELF) then
        return false
    end
    if not f29_arg1:HasSpecialEffectId(TARGET_SELF, 200004) then
        return false
    end
    if Interupt_PC_Break(f29_arg1) then
        f29_arg1:Replanning()
        return true
    end
    if f29_arg1:IsInterupt(INTERUPT_ActivateSpecialEffect) then
        if f29_arg1:GetSpecialEffectActivateInterruptType(0) == 3502540 then
            f29_arg2:ClearSubGoal()
            f29_arg1:Replaning()
            return false
        end
        if f29_arg1:GetSpecialEffectActivateInterruptType(0) == 5025 and f29_arg1:HasSpecialEffectId(TARGET_SELF, 200030) then
            f29_arg1:SetNumber(0, 1)
            return true
        elseif f29_arg1:GetSpecialEffectActivateInterruptType(0) == 3502010 and f29_arg1:HasSpecialEffectId(TARGET_SELF, 3502000) then
            f29_arg2:ClearSubGoal()
            f29_arg2:AddSubGoal(GOAL_COMMON_ComboFinal, 3, 3016, TARGET_ENE_0, 9999, 0, 0)
            return true
        elseif f29_arg1:GetSpecialEffectActivateInterruptType(0) == 5026 and f29_arg1:IsFinishTimer(1) == true and f29_local4 <= 1 and f29_arg1:IsInsideTarget(TARGET_ENE_0, AI_DIR_TYPE_F, 150) then
            if f29_local1 <= 1.3 then
                if f29_local5 <= 33 then
                    f29_arg2:ClearSubGoal()
                    f29_arg2:AddSubGoal(GOAL_COMMON_ComboFinal, 3, 3006, TARGET_ENE_0, 9999, 0, 0):TimingSetTimer(1, 10, AI_TIMING_SET__ACTIVATE)
                elseif f29_local5 <= 66 then
                    f29_arg2:ClearSubGoal()
                    f29_arg2:AddSubGoal(GOAL_COMMON_ComboFinal, 3, 3011, TARGET_ENE_0, 9999, 0, 0):TimingSetTimer(1, 10, AI_TIMING_SET__ACTIVATE)
                else
                    f29_arg2:ClearSubGoal()
                    f29_arg2:AddSubGoal(GOAL_COMMON_ComboFinal, 3, 3013, TARGET_ENE_0, 9999, 0, 0):TimingSetTimer(1, 10, AI_TIMING_SET__ACTIVATE)
                end
            elseif f29_local1 <= 5.4 - f29_arg1:GetMapHitRadius(TARGET_SELF) then
                if f29_local5 <= 50 then
                    f29_arg2:ClearSubGoal()
                    f29_arg2:AddSubGoal(GOAL_COMMON_ComboFinal, 3, 3008, TARGET_ENE_0, 9999, 0, 0)
                else
                    f29_arg2:ClearSubGoal()
                    f29_arg2:AddSubGoal(GOAL_COMMON_ComboFinal, 3, 3013, TARGET_ENE_0, 9999, 0, 0)
                end
            elseif f29_local1 <= 9.4 - f29_arg1:GetMapHitRadius(TARGET_SELF) then
                if f29_local5 <= 50 then
                    f29_arg2:ClearSubGoal()
                    f29_arg2:AddSubGoal(GOAL_COMMON_ComboFinal, 3, 3004, TARGET_ENE_0, 9999, 0, 0)
                else
                    f29_arg2:ClearSubGoal()
                    f29_arg2:AddSubGoal(GOAL_COMMON_ComboFinal, 3, 3014, TARGET_ENE_0, 9999, 0, 0)
                end
            else
            end
        end
    end
    if f29_arg1:IsInterupt(INTERUPT_InactivateSpecialEffect) and f29_arg1:GetSpecialEffectInactivateInterruptType(0) == 3502540 then
        f29_arg2:ClearSubGoal()
        f29_arg1:Replaning()
        return false
    end
    return false
    
end

Goal.ActAfter_AdjustSpace = function (f30_arg0, f30_arg1, f30_arg2)
    
end

Goal.Update = function (f31_arg0, f31_arg1, f31_arg2)
    return Update_Default_NoSubGoal(f31_arg0, f31_arg1, f31_arg2)
    
end

Goal.Terminate = function (f32_arg0, f32_arg1, f32_arg2)
    
end


