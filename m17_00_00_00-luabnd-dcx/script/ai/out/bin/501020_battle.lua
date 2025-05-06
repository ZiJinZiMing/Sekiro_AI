RegisterTableGoal(GOAL_Orochi_hebidani_501020_Battle, "GOAL_Orochi_hebidani_501020_Battle")
REGISTER_GOAL_NO_UPDATE(GOAL_Orochi_hebidani_501020_Battle, true)

Goal.Initialize = function (f1_arg0, f1_arg1, f1_arg2, f1_arg3)
    
end

Goal.Activate = function (f2_arg0, f2_arg1, f2_arg2)
    f2_arg1:AddObserveRegion(0, TARGET_ENE_0, 1702616)
    f2_arg1:AddObserveRegion(1, TARGET_ENE_0, 1702618)
    f2_arg1:AddObserveRegion(2, TARGET_ENE_0, 1702619)
    f2_arg1:AddObserveRegion(3, TARGET_ENE_0, 1702601)
    f2_arg1:AddObserveRegion(4, TARGET_ENE_0, 1702605)
    f2_arg1:AddObserveRegion(5, TARGET_ENE_0, 1702608)
    f2_arg1:AddObserveRegion(6, TARGET_ENE_0, 1702603)
    f2_arg1:AddObserveRegion(7, TARGET_ENE_0, 1702500)
    f2_arg1:AddObserveRegion(8, TARGET_ENE_0, 1702501)
    if f2_arg1:IsInsideTargetRegion(TARGET_ENE_0, 1702500) then
        f2_arg1:SetNumber(4, 1)
    else
        f2_arg1:SetNumber(4, 0)
    end
    f2_arg1:AddObserveSpecialEffectAttribute(TARGET_SELF, 5025)
    f2_arg1:AddObserveSpecialEffectAttribute(TARGET_SELF, 5026)
    f2_arg1:AddObserveSpecialEffectAttribute(TARGET_SELF, 5027)
    f2_arg1:AddObserveSpecialEffectAttribute(TARGET_SELF, 5028)
    f2_arg1:AddObserveSpecialEffectAttribute(TARGET_SELF, 5029)
    f2_arg1:AddObserveSpecialEffectAttribute(TARGET_SELF, 5030)
    f2_arg1:AddObserveSpecialEffectAttribute(TARGET_SELF, 5031)
    f2_arg1:AddObserveSpecialEffectAttribute(TARGET_SELF, 5032)
    Init_Pseudo_Global(f2_arg1, f2_arg2)
    local f2_local0 = {}
    local f2_local1 = {}
    local f2_local2 = {}
    Common_Clear_Param(f2_local0, f2_local1, f2_local2)
    local f2_local3 = f2_arg1:GetDist(TARGET_ENE_0)
    local f2_local4 = f2_arg1:GetExcelParam(AI_EXCEL_THINK_PARAM_TYPE__thinkAttr_doAdmirer)
    if f2_arg1:HasSpecialEffectId(TARGET_SELF, 5023) then
        if f2_arg1:IsFinishTimer(1) == false then
            f2_local0[27] = 100
        elseif f2_arg1:IsInsideTargetRegion(TARGET_LOCALPLAYER, 1702605) or f2_arg1:HasSpecialEffectId(TARGET_SELF, 5034) then
            if f2_arg1:IsEventFlag(11700602) then
                f2_local0[15] = 100
            else
                f2_local0[27] = 100
            end
        else
            f2_local0[27] = 100
        end
    elseif f2_arg1:IsEventFlag(11700603) then
        f2_local0[27] = 100
    elseif f2_arg1:IsInsideTargetRegion(TARGET_LOCALPLAYER, 1702605) or f2_arg1:HasSpecialEffectId(TARGET_SELF, 5034) then
        if f2_arg1:IsEventFlag(11700602) then
            f2_local0[5] = 100
        else
            f2_local0[6] = 100
        end
    elseif (f2_arg1:HasSpecialEffectId(TARGET_SELF, 5038) or f2_arg1:HasSpecialEffectId(TARGET_SELF, 5037)) and f2_arg1:GetNumber(2) == 1 then
        f2_local0[7] = 100
    elseif f2_arg1:IsEventFlag(11700601) then
        f2_local0[6] = 100
    elseif f2_arg1:IsEventFlag(11700100) == false and f2_arg1:IsInsideTargetRegion(TARGET_LOCALPLAYER, 1702632) then
        f2_local0[4] = 100
    elseif f2_arg1:HasSpecialEffectId(TARGET_LOCALPLAYER, 110060) or f2_arg1:HasSpecialEffectId(TARGET_LOCALPLAYER, 110010) then
        f2_local0[26] = 100
    elseif f2_arg1:IsInsideTargetRegion(TARGET_LOCALPLAYER, 1702600) then
        if f2_arg1:IsInsideTargetRegion(TARGET_LOCALPLAYER, 1702602) then
            f2_local0[11] = 100
        else
            f2_local0[1] = 100
        end
    elseif f2_arg1:IsInsideTargetRegion(TARGET_LOCALPLAYER, 1702610) then
        if f2_arg1:IsInsideTargetRegion(TARGET_LOCALPLAYER, 1702618) then
            f2_local0[1] = 100
        elseif f2_arg1:IsInsideTargetRegion(TARGET_LOCALPLAYER, 1702619) then
            if f2_arg1:IsInsideTargetRegion(TARGET_LOCALPLAYER, 1702616) then
                f2_local0[3] = 100
            else
                f2_local0[2] = 100
            end
        else
            f2_local0[2] = 100
        end
    elseif f2_arg1:IsInsideTargetRegion(TARGET_LOCALPLAYER, 1702635) or f2_arg1:IsInsideTargetRegion(TARGET_LOCALPLAYER, 1702636) or f2_arg1:IsInsideTargetRegion(TARGET_LOCALPLAYER, 1702637) then
        f2_local0[8] = 100
    else
        f2_local0[26] = 100
    end
    f2_local1[1] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act01)
    f2_local1[2] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act02)
    f2_local1[3] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act03)
    f2_local1[4] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act04)
    f2_local1[5] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act05)
    f2_local1[6] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act06)
    f2_local1[7] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act07)
    f2_local1[8] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act08)
    f2_local1[15] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act15)
    f2_local1[11] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act11)
    f2_local1[26] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act26)
    f2_local1[27] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act27)
    local f2_local5 = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.ActAfter_AdjustSpace)
    Common_Battle_Activate(f2_arg1, f2_arg2, f2_local0, f2_local1, f2_local5, f2_local2)
    
end

Goal.Act01 = function (f3_arg0, f3_arg1, f3_arg2)
    if f3_arg0:HasSpecialEffectId(TARGET_SELF, 5035) then
        f3_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 20, 20010, TARGET_ENE_0, 999, 0, 0, 0, 0)
    elseif f3_arg0:HasSpecialEffectId(TARGET_SELF, 5036) then
        f3_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 20, 20010, TARGET_ENE_0, 999, 0, 0, 0, 0)
    elseif f3_arg0:HasSpecialEffectId(TARGET_SELF, 5038) then
        f3_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 20, 20021, TARGET_ENE_0, 999, 0, 0, 0, 0)
    elseif f3_arg0:HasSpecialEffectId(TARGET_SELF, 5039) then
        if f3_arg0:IsInsideTargetRegion(TARGET_ENE_0, 1702615) then
            f3_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 20, 20007, TARGET_ENE_0, 999, 0, 0, 0, 0)
        else
            f3_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 20, 20004, TARGET_ENE_0, 999, 0, 0, 0, 0)
        end
    elseif f3_arg0:HasSpecialEffectId(TARGET_SELF, 5037) then
        f3_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 20, 20011, TARGET_ENE_0, 999, 0, 0, 0, 0)
    else
        f3_arg1:AddSubGoal(GOAL_COMMON_Wait, 10, TARGET_SELF, 0, 0, 0)
    end
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
    
end

Goal.Act02 = function (f4_arg0, f4_arg1, f4_arg2)
    if f4_arg0:HasSpecialEffectId(TARGET_SELF, 5035) then
        f4_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 20, 20010, TARGET_ENE_0, 999, 0, 0, 0, 0)
    elseif f4_arg0:HasSpecialEffectId(TARGET_SELF, 5036) then
        f4_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 20, 20010, TARGET_ENE_0, 999, 0, 0, 0, 0)
    elseif f4_arg0:HasSpecialEffectId(TARGET_SELF, 5037) then
        f4_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 20, 20020, TARGET_ENE_0, 999, 0, 0, 0, 0)
    elseif f4_arg0:HasSpecialEffectId(TARGET_SELF, 5039) then
        f4_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 20, 20009, TARGET_ENE_0, 999, 0, 0, 0, 0)
    else
        f4_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 20, 20021, TARGET_ENE_0, 999, 0, 0, 0, 0)
    end
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
    
end

Goal.Act03 = function (f5_arg0, f5_arg1, f5_arg2)
    if f5_arg0:HasSpecialEffectId(TARGET_SELF, 5035) then
        f5_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 20, 20010, TARGET_ENE_0, 999, 0, 0, 0, 0)
    elseif f5_arg0:HasSpecialEffectId(TARGET_SELF, 5036) then
        f5_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 20, 20010, TARGET_ENE_0, 999, 0, 0, 0, 0)
    elseif f5_arg0:HasSpecialEffectId(TARGET_SELF, 5037) then
        f5_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 20, 20020, TARGET_ENE_0, 999, 0, 0, 0, 0)
    elseif f5_arg0:HasSpecialEffectId(TARGET_SELF, 5039) then
        f5_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 20, 20009, TARGET_ENE_0, 999, 0, 0, 0, 0)
    else
        f5_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 20, 20021, TARGET_ENE_0, 999, 0, 0, 0, 0)
    end
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
    
end

Goal.Act04 = function (f6_arg0, f6_arg1, f6_arg2)
    f6_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 20, 20000, TARGET_ENE_0, 999, 0, 0, 0, 0)
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
    
end

Goal.Act05 = function (f7_arg0, f7_arg1, f7_arg2)
    f7_arg1:AddSubGoal(GOAL_COMMON_Wait, 10, TARGET_SELF, 0, 0, 0)
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
    
end

Goal.Act15 = function (f8_arg0, f8_arg1, f8_arg2)
    f8_arg1:AddSubGoal(GOAL_COMMON_Wait, 10, TARGET_SELF, 0, 0, 0)
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
    
end

Goal.Act06 = function (f9_arg0, f9_arg1, f9_arg2)
    f9_arg1:AddSubGoal(GOAL_COMMON_Wait, 10, TARGET_SELF, 0, 0, 0)
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
    
end

Goal.Act07 = function (f10_arg0, f10_arg1, f10_arg2)
    if f10_arg0:HasSpecialEffectId(TARGET_SELF, 5037) then
        f10_arg1:AddSubGoal(GOAL_COMMON_EndureAttack, 20, 20014, TARGET_ENE_0, 9999, 0)
        f10_arg1:AddSubGoal(GOAL_COMMON_EndureAttack, 20, 20030, TARGET_ENE_0, 9999, 0)
    else
        f10_arg1:AddSubGoal(GOAL_COMMON_EndureAttack, 20, 20030, TARGET_ENE_0, 9999, 0)
    end
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
    
end

Goal.Act08 = function (f11_arg0, f11_arg1, f11_arg2)
    if f11_arg0:IsInsideTargetRegion(TARGET_LOCALPLAYER, 1702635) then
        if f11_arg0:HasSpecialEffectId(TARGET_SELF, 5035) then
            f11_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 20, 20001, TARGET_ENE_0, 999, 0, 0, 0, 0)
        elseif f11_arg0:HasSpecialEffectId(TARGET_SELF, 5036) then
            f11_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 20, 20010, TARGET_ENE_0, 999, 0, 0, 0, 0)
        elseif f11_arg0:HasSpecialEffectId(TARGET_SELF, 5037) then
            f11_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 20, 20011, TARGET_ENE_0, 999, 0, 0, 0, 0)
        elseif f11_arg0:HasSpecialEffectId(TARGET_SELF, 5039) then
            f11_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 20, 20004, TARGET_ENE_0, 999, 0, 0, 0, 0)
        else
            f11_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 20, 20021, TARGET_ENE_0, 999, 0, 0, 0, 0)
        end
    elseif f11_arg0:IsInsideTargetRegion(TARGET_LOCALPLAYER, 1702636) then
        if f11_arg0:HasSpecialEffectId(TARGET_SELF, 5035) then
            f11_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 20, 20001, TARGET_ENE_0, 999, 0, 0, 0, 0)
        elseif f11_arg0:HasSpecialEffectId(TARGET_SELF, 5036) then
            f11_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 20, 20010, TARGET_ENE_0, 999, 0, 0, 0, 0)
        elseif f11_arg0:HasSpecialEffectId(TARGET_SELF, 5037) then
            f11_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 20, 20011, TARGET_ENE_0, 999, 0, 0, 0, 0)
        elseif f11_arg0:HasSpecialEffectId(TARGET_SELF, 5039) then
            f11_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 20, 20009, TARGET_ENE_0, 999, 0, 0, 0, 0)
        else
            f11_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 20, 20021, TARGET_ENE_0, 999, 0, 0, 0, 0)
        end
    elseif f11_arg0:HasSpecialEffectId(TARGET_SELF, 5035) then
        f11_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 20, 20001, TARGET_ENE_0, 999, 0, 0, 0, 0)
    elseif f11_arg0:HasSpecialEffectId(TARGET_SELF, 5036) then
        f11_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 20, 20010, TARGET_ENE_0, 999, 0, 0, 0, 0)
    elseif f11_arg0:HasSpecialEffectId(TARGET_SELF, 5037) then
        f11_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 20, 20018, TARGET_ENE_0, 999, 0, 0, 0, 0)
    elseif f11_arg0:HasSpecialEffectId(TARGET_SELF, 5039) then
        f11_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 20, 20009, TARGET_ENE_0, 999, 0, 0, 0, 0)
    else
        f11_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 20, 20021, TARGET_ENE_0, 999, 0, 0, 0, 0)
    end
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
    
end

Goal.Act11 = function (f12_arg0, f12_arg1, f12_arg2)
    f12_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 20, 20006, TARGET_ENE_0, 999, 0, 0, 0, 0)
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
    
end

Goal.Act26 = function (f13_arg0, f13_arg1, f13_arg2)
    if f13_arg0:HasSpecialEffectId(TARGET_SELF, 5037) then
        f13_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 20, 20011, TARGET_ENE_0, 9999, 0, 0, 0, 0)
    elseif f13_arg0:HasSpecialEffectId(TARGET_SELF, 5038) then
        f13_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 20, 20021, TARGET_ENE_0, 9999, 0, 0, 0, 0)
    elseif f13_arg0:HasSpecialEffectId(TARGET_SELF, 5034) then
        f13_arg1:AddSubGoal(GOAL_COMMON_Wait, 10, TARGET_SELF, 0, 0, 0)
    elseif f13_arg0:IsInsideTargetRegion(TARGET_ENE_0, 1702605) then
        f13_arg1:AddSubGoal(GOAL_COMMON_Wait, 10, TARGET_SELF, 0, 0, 0)
    elseif f13_arg0:IsEventFlag(11700100) == false then
        f13_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 20, 20000, TARGET_ENE_0, 9999, 0, 0, 0, 0)
    else
        f13_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 20, 20004, TARGET_ENE_0, 9999, 0, 0, 0, 0)
    end
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
    
end

Goal.Act27 = function (f14_arg0, f14_arg1, f14_arg2)
    f14_arg1:AddSubGoal(GOAL_COMMON_Wait, 10, TARGET_SELF, 0, 0, 0)
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
    
end

Goal.Interrupt = function (f15_arg0, f15_arg1, f15_arg2)
    local f15_local0 = 0
    if f15_arg1:HasSpecialEffectId(TARGET_SELF, 5022) then
        local f15_local1 = f15_arg1:GetSpecialEffectActivateInterruptType(0)
        if f15_arg1:IsInterupt(INTERUPT_ActivateSpecialEffect) and f15_arg1:HasSpecialEffectId(TARGET_LOCALPLAYER, 110060) == false and f15_arg1:HasSpecialEffectId(TARGET_LOCALPLAYER, 110010) == false then
            if f15_local1 == 5025 then
                if f15_arg1:IsInsideTargetRegion(TARGET_ENE_0, 1702611) then
                    f15_arg2:ClearSubGoal()
                    if f15_arg1:GetNumber(1) == 0 then
                        f15_arg2:AddSubGoal(GOAL_COMMON_EndureAttack, 0.1, 20016, TARGET_ENE_0, 9999, 0):TimingSetNumber(1, 1, AI_TIMING_SET__ACTIVATE)
                    else
                        f15_arg2:AddSubGoal(GOAL_COMMON_EndureAttack, 0.1, 20036, TARGET_ENE_0, 9999, 0):TimingSetNumber(1, 0, AI_TIMING_SET__ACTIVATE)
                    end
                    return true
                elseif f15_arg1:IsInsideTargetRegion(TARGET_ENE_0, 1702612) then
                    f15_arg2:ClearSubGoal()
                    if f15_arg1:GetNumber(1) == 0 then
                        f15_arg2:AddSubGoal(GOAL_COMMON_EndureAttack, 0.1, 20015, TARGET_ENE_0, 9999, 0):TimingSetNumber(1, 1, AI_TIMING_SET__ACTIVATE)
                    else
                        f15_arg2:AddSubGoal(GOAL_COMMON_EndureAttack, 0.1, 20035, TARGET_ENE_0, 9999, 0):TimingSetNumber(1, 0, AI_TIMING_SET__ACTIVATE)
                    end
                    return true
                elseif f15_arg1:IsInsideTargetRegion(TARGET_ENE_0, 1702609) or f15_arg1:IsInsideTargetRegion(TARGET_ENE_0, 1702613) or f15_arg1:IsInsideTargetRegion(TARGET_ENE_0, 1702614) then
                    f15_arg2:ClearSubGoal()
                    f15_arg2:AddSubGoal(GOAL_COMMON_EndureAttack, 0.1, 20018, TARGET_ENE_0, 9999, 0)
                    return true
                end
            elseif f15_local1 == 5026 then
                if f15_arg1:IsInsideTargetRegion(TARGET_ENE_0, 1702613) then
                    f15_arg2:ClearSubGoal()
                    f15_arg2:AddSubGoal(GOAL_COMMON_EndureAttack, 0.1, 20026, TARGET_ENE_0, 9999, 0)
                    return true
                elseif f15_arg1:IsInsideTargetRegion(TARGET_ENE_0, 1702608) then
                    f15_arg2:ClearSubGoal()
                    f15_arg2:AddSubGoal(GOAL_COMMON_EndureAttack, 0.1, 20030, TARGET_ENE_0, 9999, 0)
                    return true
                end
            elseif f15_local1 == 5027 then
            elseif f15_local1 == 5028 then
                if f15_arg1:IsInsideTargetRegion(TARGET_ENE_0, 1702617) then
                    f15_arg2:ClearSubGoal()
                    f15_arg2:AddSubGoal(GOAL_COMMON_EndureAttack, 0.1, 20007, TARGET_ENE_0, 9999, 0)
                    return true
                elseif f15_arg1:IsInsideTargetRegion(TARGET_ENE_0, 1702611) or f15_arg1:IsInsideTargetRegion(TARGET_ENE_0, 1702612) or f15_arg1:IsInsideTargetRegion(TARGET_ENE_0, 1702613) or f15_arg1:IsInsideTargetRegion(TARGET_ENE_0, 1702614) then
                    f15_arg2:ClearSubGoal()
                    f15_arg2:AddSubGoal(GOAL_COMMON_EndureAttack, 0.1, 20007, TARGET_ENE_0, 9999, 0)
                    return true
                end
            elseif f15_local1 == 5030 and (f15_arg1:IsInsideTargetRegion(TARGET_ENE_0, 1702611) or f15_arg1:IsInsideTargetRegion(TARGET_ENE_0, 1702612) or f15_arg1:IsInsideTargetRegion(TARGET_ENE_0, 1702613) or f15_arg1:IsInsideTargetRegion(TARGET_ENE_0, 1702614)) then
                f15_arg2:ClearSubGoal()
                f15_arg2:AddSubGoal(GOAL_COMMON_EndureAttack, 0.1, 20009, TARGET_ENE_0, 9999, 0)
                return true
            end
            if f15_local1 == 5029 then
                if f15_arg1:IsInsideTargetRegion(TARGET_ENE_0, 1702619) then
                    f15_arg2:ClearSubGoal()
                    f15_arg2:AddSubGoal(GOAL_COMMON_EndureAttack, 0.1, 20014, TARGET_ENE_0, 9999, 0)
                    return true
                end
            elseif f15_local1 == 5032 then
                if f15_arg1:IsInsideTargetRegion(TARGET_ENE_0, 1702619) then
                    f15_arg2:ClearSubGoal()
                    f15_arg2:AddSubGoal(GOAL_COMMON_EndureAttack, 0.1, 20013, TARGET_ENE_0, 9999, 0)
                    return true
                end
            elseif f15_local1 == 5031 and f15_arg1:IsInsideTargetRegion(TARGET_ENE_0, 1702610) then
                f15_arg2:ClearSubGoal()
                f15_arg2:AddSubGoal(GOAL_COMMON_EndureAttack, 0.1, 20008, TARGET_ENE_0, 9999, 0)
                return true
            end
        end
        if f15_arg1:IsInterupt(INTERUPT_Inside_ObserveArea) then
            if f15_arg1:IsInsideObserve(0) or f15_arg1:IsInsideObserve(1) or f15_arg1:IsInsideObserve(2) or f15_arg1:IsInsideObserve(4) or f15_arg1:IsInsideObserve(8) then
                f15_arg1:Replanning()
                return true
            elseif f15_arg1:IsInsideObserve(3) then
                if f15_arg1:IsEventFlag(11700603) == false then
                    f15_arg2:ClearSubGoal()
                    f15_arg2:AddSubGoal(GOAL_COMMON_EndureAttack, 0.1, 20005, TARGET_ENE_0, 9999, 0)
                    return true
                end
            elseif f15_arg1:IsInsideObserve(5) then
                f15_arg1:SetNumber(2, 1)
                f15_arg1:Replanning()
                return true
            elseif f15_arg1:IsInsideObserve(6) then
                if f15_arg1:HasSpecialEffectId(TARGET_SELF, 5035) and f15_arg1:IsEventFlag(11700602) == false then
                    f15_arg2:ClearSubGoal()
                    f15_arg2:AddSubGoal(GOAL_COMMON_EndureAttack, 0.1, 20001, TARGET_ENE_0, 9999, 0)
                    return true
                end
            elseif f15_arg1:IsInsideObserve(7) then
                f15_arg1:SetNumber(4, 1)
                return false
            end
        end
        if f15_arg1:IsInterupt(INTERUPT_Outside_ObserveArea) and f15_arg1:IsInsideObserve(7) == false and f15_arg1:GetNumber(4) == 1 then
            f15_arg1:SetTimer(1, 10)
            f15_arg1:SetNumber(4, 0)
            return false
        end
        if f15_arg1:IsInterupt(INTERUPT_Damaged) then
            return f15_arg0.Damaged(f15_arg1, f15_arg2)
        end
    elseif f15_arg1:IsInterupt(INTERUPT_Inside_ObserveArea) and f15_arg1:IsInsideObserve(4) then
        f15_arg1:Replanning()
        return true
    end
    return false
    
end

Goal.Damaged = function (f16_arg0, f16_arg1, f16_arg2)
    if f16_arg0:HasSpecialEffectId(TARGET_SELF, 205026) then
        f16_arg1:ClearSubGoal()
        f16_arg1:AddSubGoal(GOAL_COMMON_EndureAttack, 0.1, 20037, TARGET_ENE_0, 9999, 0)
        return true
    elseif f16_arg0:HasSpecialEffectId(TARGET_SELF, 205025) then
        f16_arg1:ClearSubGoal()
        f16_arg1:AddSubGoal(GOAL_COMMON_EndureAttack, 0.1, 20017, TARGET_ENE_0, 9999, 0)
        return true
    end
    return false
    
end

Goal.ActAfter_AdjustSpace = function (f17_arg0, f17_arg1, f17_arg2)
    
end

Goal.Update = function (f18_arg0, f18_arg1, f18_arg2)
    return Update_Default_NoSubGoal(f18_arg0, f18_arg1, f18_arg2)
    
end

Goal.Terminate = function (f19_arg0, f19_arg1, f19_arg2)
    
end


