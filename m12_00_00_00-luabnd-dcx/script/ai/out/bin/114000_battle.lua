RegisterTableGoal(GOAL_Dobeihei_114000_Battle, "GOAL_Dobeihei_114000_Battle")
REGISTER_GOAL_NO_UPDATE(GOAL_Dobeihei_114000_Battle, true)

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
    local f2_local7 = f2_arg1:GetEventRequest()
    f2_arg1:AddObserveArea(0, TARGET_SELF, TARGET_ENE_0, AI_DIR_TYPE_F, 180, 3.1)
    Set_ConsecutiveGuardCount_Interrupt(f2_arg1)
    if f2_arg1:HasSpecialEffectId(TARGET_ENE_0, 110060) then
        f2_local0[26] = 100
    elseif f2_arg1:HasSpecialEffectId(TARGET_SELF, 3114000) then
        f2_local0[26] = 100
    elseif f2_arg1:HasSpecialEffectId(TARGET_SELF, 220900) == false and f2_arg1:IsInsideTargetRegion(TARGET_ENE_0, 1702430) == false and f2_arg1:HasSpecialEffectId(TARGET_SELF, 3114020) then
        f2_local0[26] = 100
    elseif (f2_arg1:GetNumber(1) == 1 or f2_arg1:HasSpecialEffectId(TARGET_SELF, 200211) or f2_arg1:HasSpecialEffectId(TARGET_SELF, 200210)) and f2_arg1:IsFinishTimer(1) then
        if f2_arg1:HasSpecialEffectId(TARGET_SELF, 200004) then
            f2_local0[3] = 100
        else
            f2_local0[26] = 100
        end
    elseif f2_local3 > 4.1 then
        if f2_arg1:HasSpecialEffectId(TARGET_SELF, 200004) then
            f2_local0[3] = 100
        else
            f2_local0[26] = 100
        end
    elseif f2_local3 > 3.1 then
        if f2_arg1:HasSpecialEffectId(TARGET_SELF, 200004) then
            if f2_arg1:IsFinishTimer(0) then
                f2_local0[3] = 100
            else
                f2_local0[26] = 100
            end
        else
            f2_local0[26] = 100
        end
    elseif f2_arg1:HasSpecialEffectId(TARGET_ENE_0, 110030) then
        f2_local0[26] = 100
    elseif f2_arg1:IsInsideTarget(TARGET_ENE_0, AI_DIR_TYPE_B, 180) then
        if f2_arg1:HasSpecialEffectId(TARGET_SELF, 200004) then
            f2_local0[3] = 100
            f2_local0[7] = 500
        else
            f2_local0[1] = 100
            f2_local0[26] = 100
        end
    elseif f2_arg1:IsInsideTarget(TARGET_ENE_0, AI_DIR_TYPE_F, 140) then
        if f2_arg1:HasSpecialEffectId(TARGET_SELF, 200004) then
            if f2_local3 <= 1.4 - f2_arg1:GetMapHitRadius(TARGET_SELF) then
                if f2_arg1:HasSpecialEffectId(TARGET_ENE_0, 109012) then
                    f2_local0[11] = 800
                else
                    f2_local0[5] = 800
                    f2_local0[11] = 500
                end
            end
            f2_local0[4] = 100
            f2_local0[9] = 100
            f2_local0[10] = 100
            f2_local0[41] = 400
            f2_local0[42] = 200
        else
            f2_local0[1] = 10000
            f2_local0[26] = 1
        end
    elseif f2_arg1:HasSpecialEffectId(TARGET_SELF, 200004) then
        f2_local0[6] = 100
        f2_local0[7] = 100
    else
        f2_local0[1] = 10000
        f2_local0[26] = 1
    end
    if f2_arg1:HasSpecialEffectId(TARGET_SELF, 200004) == false and f2_arg1:HasSpecialEffectId(TARGET_SELF, 5020) then
        if f2_arg1:IsInsideTargetRegion(TARGET_ENE_0, 9902020) and not f2_arg1:HasSpecialEffectId(TARGET_SELF, 3114000) then
            f2_local0[1] = 100
            f2_local0[26] = 0
        else
            f2_local0[1] = 0
            f2_local0[26] = 100
        end
    elseif f2_arg1:HasSpecialEffectId(TARGET_SELF, 200004) == false and f2_arg1:HasSpecialEffectId(TARGET_SELF, 5021) then
        if f2_arg1:IsInsideTargetRegion(TARGET_ENE_0, 9902030) or f2_arg1:IsInsideTargetRegion(TARGET_ENE_0, 9902031) and f2_arg1:HasSpecialEffectId(TARGET_ENE_0, 109016) then
            f2_local0[1] = 100
            f2_local0[26] = 0
        else
            f2_local0[1] = 0
            f2_local0[26] = 100
        end
    end
    if 2.2 - f2_arg1:GetMapHitRadius(TARGET_SELF) < f2_local3 then
        f2_local0[5] = 0
    end
    if SpaceCheck(f2_arg1, f2_arg2, 45, 2) == false and SpaceCheck(f2_arg1, f2_arg2, -45, 2) == false then
        f2_local0[22] = 0
    end
    if SpaceCheck(f2_arg1, f2_arg2, 90, 1) == false and SpaceCheck(f2_arg1, f2_arg2, -45, 1) == false then
        f2_local0[23] = 0
    end
    if SpaceCheck(f2_arg1, f2_arg2, 180, 2) == false then
        f2_local0[24] = 0
    end
    if SpaceCheck(f2_arg1, f2_arg2, 180, 1) == false then
        f2_local0[25] = 0
    end
    f2_local0[1] = SetCoolTime(f2_arg1, f2_arg2, 3000, 4, f2_local0[1], 1)
    f2_local0[1] = SetCoolTime(f2_arg1, f2_arg2, 3001, 4, f2_local0[1], 1)
    f2_local0[1] = SetCoolTime(f2_arg1, f2_arg2, 4100, 8, f2_local0[1], 1)
    f2_local0[1] = SetCoolTime(f2_arg1, f2_arg2, 4110, 8, f2_local0[1], 1)
    f2_local0[3] = SetCoolTime(f2_arg1, f2_arg2, 3009, 8, f2_local0[3], 1)
    f2_local0[4] = SetCoolTime(f2_arg1, f2_arg2, 3005, 3, f2_local0[4], 1)
    f2_local0[5] = SetCoolTime(f2_arg1, f2_arg2, 3006, 3, f2_local0[5], 1)
    f2_local0[6] = SetCoolTime(f2_arg1, f2_arg2, 3007, 6, f2_local0[6], 1)
    f2_local0[6] = SetCoolTime(f2_arg1, f2_arg2, 3008, 6, f2_local0[6], 1)
    f2_local0[7] = SetCoolTime(f2_arg1, f2_arg2, 3010, 8, f2_local0[7], 1)
    f2_local0[7] = SetCoolTime(f2_arg1, f2_arg2, 3011, 8, f2_local0[7], 1)
    f2_local0[8] = SetCoolTime(f2_arg1, f2_arg2, 3014, 4, f2_local0[8], 1)
    f2_local0[9] = SetCoolTime(f2_arg1, f2_arg2, 3015, 10, f2_local0[9], 1)
    f2_local0[10] = SetCoolTime(f2_arg1, f2_arg2, 3016, 10, f2_local0[10], 1)
    f2_local0[11] = SetCoolTime(f2_arg1, f2_arg2, 3015, 5, f2_local0[11], 1)
    f2_local0[41] = SetCoolTime(f2_arg1, f2_arg2, 3003, 4, f2_local0[41], 1)
    f2_local0[42] = SetCoolTime(f2_arg1, f2_arg2, 3004, 10, f2_local0[42], 1)
    f2_local1[1] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act01)
    f2_local1[2] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act02)
    f2_local1[3] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act03)
    f2_local1[4] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act04)
    f2_local1[5] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act05)
    f2_local1[6] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act06)
    f2_local1[7] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act07)
    f2_local1[9] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act09)
    f2_local1[10] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act10)
    f2_local1[11] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act11)
    f2_local1[26] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act26)
    f2_local1[41] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act41)
    f2_local1[42] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act42)
    local f2_local8 = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.ActAfter_AdjustSpace)
    Common_Battle_Activate(f2_arg1, f2_arg2, f2_local0, f2_local1, f2_local8, f2_local2)
    
end

Goal.Act01 = function (f3_arg0, f3_arg1, f3_arg2)
    local f3_local0 = 3000
    local f3_local1 = 3001
    local f3_local2 = 3012
    local f3_local3 = 3013
    local f3_local4 = 0
    local f3_local5 = 0
    local f3_local6 = f3_arg0:GetRandam_Int(1, 100)
    if f3_arg0:IsInsideTarget(TARGET_ENE_0, AI_DIR_TYPE_L, 40) then
        f3_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 10, f3_local2, TARGET_ENE_0, 9999, f3_local4, f3_local5, 0, 0)
    elseif f3_arg0:IsInsideTarget(TARGET_ENE_0, AI_DIR_TYPE_R, 40) then
        f3_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 10, f3_local3, TARGET_ENE_0, 9999, f3_local4, f3_local5, 0, 0)
    elseif f3_local6 <= 50 then
        f3_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 10, f3_local0, TARGET_ENE_0, 9999, f3_local4, f3_local5, 0, 0)
    else
        f3_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 10, f3_local1, TARGET_ENE_0, 9999, f3_local4, f3_local5, 0, 0)
    end
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act02 = function (f4_arg0, f4_arg1, f4_arg2)
    local f4_local0 = 3002
    local f4_local1 = 3003
    local f4_local2 = 3004
    local f4_local3 = 3.2 - f4_arg0:GetMapHitRadius(TARGET_SELF)
    local f4_local4 = 0
    local f4_local5 = 0
    local f4_local6 = f4_arg0:GetRandam_Int(1, 100)
    f4_arg1:AddSubGoal(GOAL_COMMON_ComboAttackTunableSpin, 10, f4_local0, TARGET_ENE_0, f4_local3, f4_local4, f4_local5, 0, 0)
    if f4_local6 <= 60 then
        f4_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, f4_local1, TARGET_ENE_0, 9999, 0, 0)
    else
        f4_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, f4_local2, TARGET_ENE_0, 9999, 0, 0)
    end
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act03 = function (f5_arg0, f5_arg1, f5_arg2)
    local f5_local0 = 3009
    local f5_local1 = 0
    local f5_local2 = 0
    local f5_local3 = f5_arg0:GetRandam_Int(1, 100)
    f5_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 10, f5_local0, TARGET_ENE_0, 9999, f5_local1, f5_local2, 0, 0):TimingSetTimer(1, 10, AI_TIMING_SET__ACTIVATE):TimingSetNumber(1, 0, AI_TIMING_SET__ACTIVATE)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act04 = function (f6_arg0, f6_arg1, f6_arg2)
    local f6_local0 = 3005
    local f6_local1 = 0
    local f6_local2 = 0
    local f6_local3 = f6_arg0:GetRandam_Int(1, 100)
    f6_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 10, f6_local0, TARGET_ENE_0, 9999, f6_local1, f6_local2, 0, 0)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act05 = function (f7_arg0, f7_arg1, f7_arg2)
    local f7_local0 = 3006
    local f7_local1 = 0
    local f7_local2 = 0
    local f7_local3 = f7_arg0:GetRandam_Int(1, 100)
    f7_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 10, f7_local0, TARGET_ENE_0, 9999, f7_local1, f7_local2, 0, 0)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act06 = function (f8_arg0, f8_arg1, f8_arg2)
    local f8_local0 = 3007
    local f8_local1 = 3008
    local f8_local2 = 0
    local f8_local3 = 0
    local f8_local4 = f8_arg0:GetRandam_Int(1, 100)
    if f8_arg0:IsInsideTarget(TARGET_ENE_0, AI_DIR_TYPE_L, 180) then
        f8_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 10, f8_local0, TARGET_ENE_0, 9999, f8_local2, f8_local3, 0, 0)
    else
        f8_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 10, f8_local1, TARGET_ENE_0, 9999, f8_local2, f8_local3, 0, 0)
    end
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act07 = function (f9_arg0, f9_arg1, f9_arg2)
    local f9_local0 = 3010
    local f9_local1 = 3011
    local f9_local2 = 0
    local f9_local3 = 0
    local f9_local4 = f9_arg0:GetRandam_Int(1, 100)
    if f9_arg0:IsInsideTarget(TARGET_ENE_0, AI_DIR_TYPE_R, 180) then
        f9_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 10, f9_local0, TARGET_ENE_0, 9999, f9_local2, f9_local3, 0, 0)
    else
        f9_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 10, f9_local1, TARGET_ENE_0, 9999, f9_local2, f9_local3, 0, 0)
    end
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act08 = function (f10_arg0, f10_arg1, f10_arg2)
    local f10_local0 = 3014
    local f10_local1 = 0
    local f10_local2 = 0
    local f10_local3 = f10_arg0:GetRandam_Int(1, 100)
    f10_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 10, f10_local0, TARGET_ENE_0, 9999, f10_local1, f10_local2, 0, 0)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act09 = function (f11_arg0, f11_arg1, f11_arg2)
    local f11_local0 = 3015
    local f11_local1 = 0
    local f11_local2 = 0
    local f11_local3 = f11_arg0:GetRandam_Int(1, 100)
    f11_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 10, f11_local0, TARGET_ENE_0, 9999, f11_local1, f11_local2, 0, 0)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act10 = function (f12_arg0, f12_arg1, f12_arg2)
    local f12_local0 = 3015
    local f12_local1 = 3016
    local f12_local2 = 3.5 - f12_arg0:GetMapHitRadius(TARGET_SELF)
    local f12_local3 = 0
    local f12_local4 = 0
    f12_arg1:AddSubGoal(GOAL_COMMON_ComboAttackTunableSpin, 10, f12_local0, TARGET_ENE_0, f12_local2, f12_local3, f12_local4, 0, 0)
    f12_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, f12_local1, TARGET_ENE_0, 9999, 0, 0)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act11 = function (f13_arg0, f13_arg1, f13_arg2)
    local f13_local0 = 3017
    local f13_local1 = 0
    local f13_local2 = 0
    local f13_local3 = f13_arg0:GetRandam_Int(1, 100)
    f13_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 10, f13_local0, TARGET_ENE_0, 9999, f13_local1, f13_local2, 0, 0)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act26 = function (f14_arg0, f14_arg1, f14_arg2)
    local f14_local0 = f14_arg0:GetRandam_Float(0.5, 1)
    f14_arg1:AddSubGoal(GOAL_COMMON_Wait, f14_local0, TARGET_SELF, 0, 0, 0)
    f14_arg0:SetNumber(1, 0)
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
    
end

Goal.Act41 = function (f15_arg0, f15_arg1, f15_arg2)
    local f15_local0 = 3002
    local f15_local1 = 3003
    local f15_local2 = 3.2 - f15_arg0:GetMapHitRadius(TARGET_SELF)
    local f15_local3 = 0
    local f15_local4 = 0
    local f15_local5 = f15_arg0:GetRandam_Int(1, 100)
    f15_arg1:AddSubGoal(GOAL_COMMON_ComboAttackTunableSpin, 10, f15_local0, TARGET_ENE_0, f15_local2, f15_local3, f15_local4, 0, 0)
    f15_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, f15_local1, TARGET_ENE_0, 9999, 0, 0)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act42 = function (f16_arg0, f16_arg1, f16_arg2)
    local f16_local0 = 3002
    local f16_local1 = 3004
    local f16_local2 = 3.5 - f16_arg0:GetMapHitRadius(TARGET_SELF)
    local f16_local3 = 0
    local f16_local4 = 0
    local f16_local5 = f16_arg0:GetRandam_Int(1, 100)
    f16_arg1:AddSubGoal(GOAL_COMMON_ComboAttackTunableSpin, 10, f16_local0, TARGET_ENE_0, f16_local2, f16_local3, f16_local4, 0, 0)
    f16_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, f16_local1, TARGET_ENE_0, 9999, 0, 0)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Interrupt = function (f17_arg0, f17_arg1, f17_arg2)
    local f17_local0 = f17_arg1:GetDist(TARGET_ENE_0)
    local f17_local1 = f17_arg1:GetSpecialEffectActivateInterruptType(0)
    if f17_arg1:IsLadderAct(TARGET_SELF) then
        return false
    end
    if not f17_arg1:HasSpecialEffectId(TARGET_SELF, 200004) then
        return false
    end
    if f17_arg1:IsInterupt(INTERUPT_ParryTiming) then
        return Common_Parry(f17_arg1, f17_arg2, 40, 0, -1)
    end
    if f17_arg1:IsInterupt(INTERUPT_Damaged) then
        return f17_arg0.Damaged(f17_arg1, f17_arg2)
    end
    if f17_arg1:IsInterupt(INTERUPT_ShootImpact) and f17_arg0.ShootReaction(f17_arg1, f17_arg2) then
        return true
    end
    if f17_arg1:IsInterupt(INTERUPT_ActivateSpecialEffect) then
    end
    if f17_arg1:IsInterupt(INTERUPT_Outside_ObserveArea) then
        f17_arg1:SetTimer(0, f17_arg1:GetRandam_Float(1, 2))
        return false
    end
    return false
    
end

Goal.Damaged = function (f18_arg0, f18_arg1, f18_arg2)
    f18_arg0:SetNumber(1, 1)
    return false
    
end

Goal.ShootReaction = function (f19_arg0, f19_arg1)
    f19_arg1:ClearSubGoal()
    f19_arg1:AddSubGoal(GOAL_COMMON_EndureAttack, 0.1, 3100, TARGET_ENE_0, 9999, 0)
    return true
    
end

Goal.ActAfter_AdjustSpace = function (f20_arg0, f20_arg1, f20_arg2)
    
end

Goal.Update = function (f21_arg0, f21_arg1, f21_arg2)
    return Update_Default_NoSubGoal(f21_arg0, f21_arg1, f21_arg2)
    
end

Goal.Terminate = function (f22_arg0, f22_arg1, f22_arg2)
    
end


