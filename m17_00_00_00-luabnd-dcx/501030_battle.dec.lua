RegisterTableGoal(GOAL_Orochi_nest_501030_Battle, "GOAL_Orochi_nest_501030_Battle")
REGISTER_GOAL_NO_UPDATE(GOAL_Orochi_nest_501030_Battle, true)

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
    f2_arg1:AddObserveRegion(0, TARGET_LOCALPLAYER, 1702621)
    f2_arg1:AddObserveRegion(1, TARGET_LOCALPLAYER, 1702626)
    f2_arg1:AddObserveRegion(2, TARGET_LOCALPLAYER, 1702627)
    f2_arg1:AddObserveSpecialEffectAttribute(TARGET_SELF, 5025)
    f2_arg1:AddObserveSpecialEffectAttribute(TARGET_SELF, 5022)
    f2_arg1:AddObserveSpecialEffectAttribute(TARGET_ENE_0, 109031)
    if f2_arg1:HasSpecialEffectId(TARGET_ENE_0, 110060) or f2_arg1:HasSpecialEffectId(TARGET_ENE_0, 110010) then
        if f2_arg1:HasSpecialEffectId(TARGET_SELF, 5036) and f2_arg1:IsInsideTargetRegion(TARGET_ENE_0, 1702626) then
            f2_local0[12] = 100
        else
            f2_local0[26] = 100
        end
    elseif f2_arg1:HasSpecialEffectId(TARGET_SELF, 5021) then
        if f2_arg1:HasSpecialEffectId(TARGET_SELF, 5037) then
            f2_local0[26] = 100
        elseif f2_arg1:HasSpecialEffectId(TARGET_SELF, 5023) and f2_arg1:HasSpecialEffectId(TARGET_SELF, 5036) == false then
            f2_local0[13] = 100
        elseif f2_arg1:HasSpecialEffectId(TARGET_SELF, 5038) then
            f2_local0[26] = 100
        elseif f2_arg1:HasSpecialEffectId(TARGET_SELF, 5022) then
            f2_local0[11] = 100
        elseif f2_arg1:HasSpecialEffectId(TARGET_SELF, 5036) then
            if f2_arg1:IsInsideTargetRegion(TARGET_ENE_0, 1702627) then
                f2_local0[14] = 100
            elseif f2_arg1:IsInsideTargetRegion(TARGET_ENE_0, 1702626) and f2_arg1:IsEventFlag(11700621) == false then
                f2_local0[12] = 100
            else
                f2_local0[26] = 100
            end
        elseif f2_arg1:IsInsideTargetRegion(TARGET_ENE_0, 1702621) then
            f2_local0[10] = 100
        else
            f2_local0[26] = 100
        end
    else
        f2_local0[26] = 100
    end
    f2_local1[1] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act01)
    f2_local1[10] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act10)
    f2_local1[11] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act11)
    f2_local1[12] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act12)
    f2_local1[13] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act13)
    f2_local1[14] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act14)
    f2_local1[26] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act26)
    local f2_local5 = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.ActAfter_AdjustSpace)
    Common_Battle_Activate(f2_arg1, f2_arg2, f2_local0, f2_local1, f2_local5, f2_local2)
    
end

Goal.Act10 = function (f3_arg0, f3_arg1, f3_arg2)
    if f3_arg0:IsInsideTargetRegion(TARGET_ENE_0, 1702625) then
        f3_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 1, 20012, TARGET_ENE_0, 9999, 0, 0, 0, 0)
    else
        f3_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 10, 20011, TARGET_ENE_0, 9999, 0, 0, 0, 0)
    end
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
    
end

Goal.Act11 = function (f4_arg0, f4_arg1, f4_arg2)
    f4_arg1:AddSubGoal(GOAL_COMMON_EndureAttack, 10, 20016, TARGET_ENE_0, 9999, 0)
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
    
end

Goal.Act12 = function (f5_arg0, f5_arg1, f5_arg2)
    if f5_arg0:HasSpecialEffectId(TARGET_SELF, 5038) then
        f5_arg1:AddSubGoal(GOAL_COMMON_EndureAttack, 1, 20020, TARGET_ENE_0, 999, 0)
    else
        f5_arg1:AddSubGoal(GOAL_COMMON_EndureAttack, 1, 20022, TARGET_ENE_0, 999, 0)
    end
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
    
end

Goal.Act13 = function (f6_arg0, f6_arg1, f6_arg2)
    f6_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 10, 20018, TARGET_ENE_0, 9999, 0, 0, 0, 0)
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
    
end

Goal.Act14 = function (f7_arg0, f7_arg1, f7_arg2)
    f7_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 10, 20023, TARGET_ENE_0, 9999, 0, 0, 0, 0)
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
    
end

Goal.Act26 = function (f8_arg0, f8_arg1, f8_arg2)
    if f8_arg0:HasSpecialEffectId(TARGET_SELF, 5020) then
        f8_arg1:AddSubGoal(GOAL_COMMON_WaitWithAnime, 10, 20001, TARGET_NONE)
    elseif f8_arg0:HasSpecialEffectId(TARGET_SELF, 5036) then
        f8_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 20, 20012, TARGET_ENE_0, 999, 0, 0, 0, 0)
    elseif f8_arg0:HasSpecialEffectId(TARGET_SELF, 5038) then
        f8_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 20, 20017, TARGET_ENE_0, 999, 0, 0, 0, 0)
    elseif f8_arg0:HasSpecialEffectId(TARGET_SELF, 5037) then
        f8_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 20, 20014, TARGET_ENE_0, 999, 0, 0, 0, 0)
    else
        f8_arg1:AddSubGoal(GOAL_COMMON_Wait, 10, TARGET_SELF, 0, 0, 0)
    end
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
    
end

Goal.Interrupt = function (f9_arg0, f9_arg1, f9_arg2)
    local f9_local0 = f9_arg1:GetSpecialEffectActivateInterruptType(0)
    if f9_arg1:IsLadderAct(TARGET_SELF) then
        return false
    end
    if f9_arg1:IsInterupt(INTERUPT_Damaged) then
        return f9_arg0.Damaged(f9_arg1, f9_arg2)
    end
    if f9_arg1:GetSpecialEffectActivateInterruptType(0) == 109031 then
        f9_arg1:Replanning()
        return true
    end
    if f9_arg1:HasSpecialEffectId(TARGET_ENE_0, 110010) then
        return false
    end
    if f9_arg1:IsInterupt(INTERUPT_Inside_ObserveArea) and f9_arg1:HasSpecialEffectId(TARGET_SELF, 5021) then
        if f9_arg1:IsInsideObserve(1) then
            if f9_arg1:IsEventFlag(11700621) == false then
                if f9_arg1:HasSpecialEffectId(TARGET_SELF, 5038) then
                    f9_arg2:ClearSubGoal()
                    f9_arg2:AddSubGoal(GOAL_COMMON_EndureAttack, 1, 20020, TARGET_ENE_0, 999, 0)
                    return true
                elseif f9_arg1:HasSpecialEffectId(TARGET_SELF, 5036) then
                    f9_arg2:ClearSubGoal()
                    f9_arg2:AddSubGoal(GOAL_COMMON_EndureAttack, 1, 20022, TARGET_ENE_0, 999, 0)
                    return true
                end
            end
        elseif f9_arg1:IsInsideObserve(2) then
            if not f9_arg1:HasSpecialEffectId(TARGET_SELF, 5038) then
                f9_arg2:ClearSubGoal()
                f9_arg2:AddSubGoal(GOAL_COMMON_EndureAttack, 1, 20023, TARGET_ENE_0, 999, 0)
                return true
            end
        elseif f9_arg1:IsInsideObserve(0) then
            f9_arg1:Replanning()
            return true
        end
    end
    if f9_arg1:IsInterupt(INTERUPT_ActivateSpecialEffect) then
        if f9_local0 == 5025 and f9_arg1:IsInsideTargetRegion(TARGET_LOCALPLAYER, 1702622) and f9_arg1:HasSpecialEffectId(TARGET_SELF, 5021) then
            f9_arg2:ClearSubGoal()
            f9_arg2:AddSubGoal(GOAL_COMMON_EndureAttack, 1, 20015, TARGET_ENE_0, 999, 0)
            return true
        elseif f9_local0 == 5022 then
            f9_arg2:ClearSubGoal()
            f9_arg2:AddSubGoal(GOAL_COMMON_EndureAttack, 1, 20016, TARGET_ENE_0, 999, 0)
            return true
        end
    end
    return false
    
end

Goal.Damaged = function (f10_arg0, f10_arg1, f10_arg2)
    if f10_arg0:HasSpecialEffectId(TARGET_SELF, 5020) then
        f10_arg1:ClearSubGoal()
        f10_arg1:AddSubGoal(GOAL_COMMON_EndureAttack, 0.1, 20005, TARGET_ENE_0, 9999, 0, 0, 0, 0)
        return true
    elseif f10_arg0:HasSpecialEffectId(TARGET_SELF, 5021) and f10_arg0:HasSpecialEffectId(TARGET_SELF, 5037) then
        f10_arg1:ClearSubGoal()
        f10_arg1:AddSubGoal(GOAL_COMMON_EndureAttack, 0.1, 20019, TARGET_ENE_0, 9999, 0, 0, 0, 0)
        return true
    end
    return false
    
end

Goal.ActAfter_AdjustSpace = function (f11_arg0, f11_arg1, f11_arg2)
    
end

Goal.Update = function (f12_arg0, f12_arg1, f12_arg2)
    return Update_Default_NoSubGoal(f12_arg0, f12_arg1, f12_arg2)
    
end

Goal.Terminate = function (f13_arg0, f13_arg1, f13_arg2)
    
end


