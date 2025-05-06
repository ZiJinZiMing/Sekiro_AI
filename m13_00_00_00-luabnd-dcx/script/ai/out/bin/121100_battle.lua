RegisterTableGoal(GOAL_Korogi_121100_Battle, "GOAL_Korogi_121100_Battle")
REGISTER_GOAL_NO_UPDATE(GOAL_Korogi_121100_Battle, true)

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
    local f2_local5 = f2_arg1:GetNpcThinkParamID()
    local f2_local6 = f2_arg1:GetDistYSigned(TARGET_ENE_0)
    local f2_local7 = f2_arg1:GetEventRequest()
    local f2_local8 = f2_arg1:GetHpRate(TARGET_TEAM_LEADER)
    local f2_local9 = f2_arg1:GetDist(TARGET_TEAM_LEADER)
    f2_arg1:DeleteObserve(0)
    if f2_arg1:HasSpecialEffectId(TARGET_ENE_0, 110060) then
        if f2_arg1:IsInsideTarget(TARGET_ENE_0, AI_DIR_TYPE_F, 90) then
            f2_local0[20] = 100
        else
            f2_local0[21] = 100
        end
    elseif f2_arg1:HasSpecialEffectId(TARGET_ENE_0, 110015) then
        if f2_arg1:IsInsideTarget(TARGET_ENE_0, AI_DIR_TYPE_F, 90) then
            f2_local0[20] = 100
        else
            f2_local0[21] = 100
        end
    elseif f2_arg1:CheckDoesExistPath(TARGET_ENE_0, AI_DIR_TYPE_F, 0, 0) == false then
        f2_local0[2] = 100
    elseif f2_local4 == 1 and f2_arg1:GetTeamOrder(ORDER_TYPE_Role) == ROLE_TYPE_Kankyaku then
        f2_local0[2] = 200
    elseif f2_local4 == 1 and f2_arg1:GetTeamOrder(ORDER_TYPE_Role) == ROLE_TYPE_Torimaki then
        f2_local0[2] = 200
    elseif f2_arg1:IsInsideTarget(TARGET_ENE_0, AI_DIR_TYPE_B, 180) then
        if not f2_arg1:HasSpecialEffectId(TARGET_ENE_0, 3121100) or f2_arg1:HasSpecialEffectId(TARGET_SELF, 3121101) then
            f2_local0[20] = 100
            f2_local0[2] = 30
            f2_local0[31] = 40
        elseif f2_local3 > 7 then
            f2_local0[21] = 100
        elseif f2_local3 > 5 then
            f2_local0[21] = 100
        else
            f2_local0[21] = 100
        end
    elseif f2_arg1:HasSpecialEffectId(TARGET_ENE_0, 3121100) or f2_arg1:HasSpecialEffectId(TARGET_SELF, 3121101) then
        if f2_local3 > 7 then
            f2_local0[30] = 10
        elseif f2_local3 > 5 then
            f2_local0[30] = 10
        elseif f2_local3 > 3 then
            f2_local0[1] = 70
            f2_local0[2] = 30
            f2_local0[3] = 30
            f2_local0[30] = 10
        elseif f2_local3 > 1.3 then
            f2_local0[1] = 70
            f2_local0[2] = 30
            f2_local0[30] = 10
        else
            f2_local0[2] = 30
            f2_local0[30] = 30
        end
    elseif f2_local3 > 3 then
        f2_local0[2] = 30
        f2_local0[31] = 40
        f2_local0[20] = 20
    else
        f2_local0[2] = 10
        f2_local0[31] = 40
    end
    f2_local1[1] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act01)
    f2_local1[2] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act02)
    f2_local1[3] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act03)
    f2_local1[20] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act20)
    f2_local1[21] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act21)
    f2_local1[27] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act27)
    f2_local1[28] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act28)
    f2_local1[30] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act30)
    f2_local1[31] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act31)
    local f2_local10 = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.ActAfter_AdjustSpace)
    Common_Battle_Activate(f2_arg1, f2_arg2, f2_local0, f2_local1, f2_local10, f2_local2)
    
end

Goal.Act01 = function (f3_arg0, f3_arg1, f3_arg2)
    local f3_local0 = f3_arg0:GetDist(TARGET_ENE_0)
    local f3_local1 = 4 - f3_arg0:GetMapHitRadius(TARGET_SELF)
    local f3_local2 = 4 - f3_arg0:GetMapHitRadius(TARGET_SELF) + 0
    local f3_local3 = 4 - f3_arg0:GetMapHitRadius(TARGET_SELF) + 999
    local f3_local4 = 0
    local f3_local5 = 0
    local f3_local6 = 1.5
    local f3_local7 = 3
    local f3_local8 = f3_arg0:GetRandam_Int(1, 100)
    local f3_local9 = f3_arg0:GetRandam_Float(0.1, 0.8)
    local f3_local10 = f3_arg0:GetRandam_Float(1, 3)
    if f3_local1 < f3_local0 then
        if f3_local8 <= 33 then
            f3_arg1:AddSubGoal(GOAL_COMMON_ApproachSettingDirection, f3_local9, TARGET_ENE_0, 3, TARGET_SELF, false, -1, AI_DIR_TYPE_ToL, f3_local10)
        elseif f3_local8 <= 66 then
            f3_arg1:AddSubGoal(GOAL_COMMON_ApproachSettingDirection, f3_local9, TARGET_ENE_0, 3, TARGET_SELF, false, -1, AI_DIR_TYPE_ToR, f3_local10)
        else
            Approach_Act_Flex(f3_arg0, f3_arg1, f3_local1, f3_local2, f3_local3, f3_local4, f3_local5, f3_local6, f3_local7)
        end
    end
    local f3_local11 = 3001
    local f3_local12 = 0
    local f3_local13 = 0
    f3_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 10, f3_local11, TARGET_ENE_0, 9999, f3_local12, f3_local13, 0, 0)
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
    
end

Goal.Act02 = function (f4_arg0, f4_arg1, f4_arg2)
    local f4_local0 = 3010
    local f4_local1 = f4_arg0:GetRandam_Float(0, 0.2)
    local f4_local2 = 0
    if not f4_arg0:HasSpecialEffectId(TARGET_ENE_0, 3121100) or f4_arg0:HasSpecialEffectId(TARGET_SELF, 3121101) then
        f4_local1 = 0
    end
    f4_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 10, f4_local0, TARGET_ENE_0, 9999, f4_local1, f4_local2, 0, 0)
    f4_arg0:AddObserveArea(0, TARGET_SELF, TARGET_ENE_0, AI_DIR_TYPE_F, 30, 4)
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
    
end

Goal.Act03 = function (f5_arg0, f5_arg1, f5_arg2)
    local f5_local0 = f5_arg0:GetDist(TARGET_ENE_0)
    local f5_local1 = 4 - f5_arg0:GetMapHitRadius(TARGET_SELF)
    local f5_local2 = 4 - f5_arg0:GetMapHitRadius(TARGET_SELF) + 0
    local f5_local3 = 4 - f5_arg0:GetMapHitRadius(TARGET_SELF) + 2
    local f5_local4 = 100
    local f5_local5 = 0
    local f5_local6 = 1.5
    local f5_local7 = 3
    if f5_local1 < f5_local0 then
        Approach_Act_Flex(f5_arg0, f5_arg1, f5_local1, f5_local2, f5_local3, f5_local4, f5_local5, f5_local6, f5_local7)
    end
    local f5_local8 = 3001
    local f5_local9 = 0
    local f5_local10 = 0
    f5_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 10, f5_local8, TARGET_ENE_0, 9999, f5_local9, f5_local10, 0, 0)
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
    
end

Goal.Act20 = function (f6_arg0, f6_arg1, f6_arg2)
    local f6_local0 = f6_arg0:GetRandam_Float(0.5, 1.5)
    if not f6_arg0:HasSpecialEffectId(TARGET_ENE_0, 3121100) or f6_arg0:HasSpecialEffectId(TARGET_SELF, 3121101) then
        f6_arg1:AddSubGoal(GOAL_COMMON_Wait, f6_local0, TARGET_SELF, 0, 0, 0)
    else
        f6_arg1:AddSubGoal(GOAL_COMMON_Wait, f6_local0, TARGET_ENE_0, 0, 0, 0)
    end
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
    
end

Goal.Act21 = function (f7_arg0, f7_arg1, f7_arg2)
    f7_arg1:AddSubGoal(GOAL_COMMON_Turn, 3, TARGET_ENE_0, f7_arg0:GetRandam_Int(15, 30))
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
    
end

Goal.Act27 = function (f8_arg0, f8_arg1, f8_arg2)
    f8_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 10, 3010, TARGET_ENE_0, 9999, TurnTime, FrontAngle, 0, 0)
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
    
end

Goal.Act28 = function (f9_arg0, f9_arg1, f9_arg2)
    f9_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 10, 3010, TARGET_ENE_0, 9999, TurnTime, FrontAngle, 0, 0)
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
    
end

Goal.Act30 = function (f10_arg0, f10_arg1, f10_arg2)
    local f10_local0 = f10_arg0:GetDist(TARGET_ENE_0)
    local f10_local1 = 9999
    local f10_local2 = f10_arg0:GetRandam_Float(0, 1)
    local f10_local3 = 0
    local f10_local4 = f10_arg0:GetRandam_Int(2, 5)
    local f10_local5 = f10_arg0:GetRandam_Int(1, 100)
    local f10_local6 = f10_arg0:GetRandam_Int(1, 100)
    local f10_local7 = f10_arg0:GetRandam_Float(0.5, 2)
    local f10_local8 = f10_arg0:GetRandam_Float(1.5, 3)
    local f10_local9 = f10_arg0:GetRandam_Float(4, 10)
    local f10_local10 = 3
    local f10_local11 = 3031
    local f10_local12 = 3032
    if f10_local5 <= 50 then
        f10_arg1:AddSubGoal(GOAL_COMMON_ApproachSettingDirection, f10_local7, TARGET_ENE_0, 3, TARGET_SELF, false, -1, AI_DIR_TYPE_ToL, f10_local9)
    else
        f10_arg1:AddSubGoal(GOAL_COMMON_ApproachSettingDirection, f10_local7, TARGET_ENE_0, 3, TARGET_SELF, false, -1, AI_DIR_TYPE_ToR, f10_local9)
    end
    if f10_local6 <= 30 then
        f10_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 10, 3010, TARGET_ENE_0, 9999, 0, f10_local3, 0, 0)
        f10_arg0:AddObserveArea(0, TARGET_SELF, TARGET_ENE_0, AI_DIR_TYPE_F, 30, 4)
    else
        f10_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 10, 3000, TARGET_ENE_0, 9999, f10_local2, f10_local3, 0, 0)
    end
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
    
end

Goal.Act31 = function (f11_arg0, f11_arg1, f11_arg2)
    local f11_local0 = f11_arg0:GetDist(TARGET_ENE_0)
    local f11_local1 = 9999
    local f11_local2 = 0
    local f11_local3 = 0
    local f11_local4 = f11_arg0:GetRandam_Int(2, 5)
    local f11_local5 = f11_arg0:GetRandam_Int(1, 100)
    local f11_local6 = f11_arg0:GetRandam_Int(1, 100)
    local f11_local7 = f11_arg0:GetRandam_Float(1.5, 3)
    local f11_local8 = f11_arg0:GetRandam_Float(1.5, 3)
    local f11_local9 = f11_arg0:GetRandam_Float(4, 10)
    local f11_local10 = f11_arg0:GetRandam_Int(1, 3)
    if f11_local5 <= 50 then
        f11_arg1:AddSubGoal(GOAL_COMMON_ApproachSettingDirection, f11_local7, TARGET_ENE_0, 3, TARGET_SELF, true, -1, AI_DIR_TYPE_ToL, f11_local9)
    else
        f11_arg1:AddSubGoal(GOAL_COMMON_ApproachSettingDirection, f11_local7, TARGET_ENE_0, 3, TARGET_SELF, true, -1, AI_DIR_TYPE_ToR, f11_local9)
    end
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
    
end

Goal.Interrupt = function (f12_arg0, f12_arg1, f12_arg2)
    local f12_local0 = f12_arg1:GetSpecialEffectActivateInterruptType(0)
    local f12_local1 = f12_arg1:GetDist(TARGET_ENE_0)
    local f12_local2 = f12_arg1:GetRandam_Int(1, 100)
    local f12_local3 = f12_arg1:GetRandam_Float(1, 6)
    if f12_arg1:IsLadderAct(TARGET_SELF) then
        return false
    end
    if not f12_arg1:HasSpecialEffectId(TARGET_SELF, 200004) then
        return false
    end
    if not f12_arg1:HasSpecialEffectId(TARGET_ENE_0, 3121100) or f12_arg1:HasSpecialEffectId(TARGET_SELF, 3121101) then
        return false
    end
    if f12_arg1:IsInterupt(INTERUPT_Inside_ObserveArea) and f12_arg1:IsInsideObserve(0) then
        if f12_local2 <= 35 then
            f12_arg1:DeleteObserve(0)
            return false
        elseif f12_local1 < 1 then
            f12_arg1:DeleteObserve(0)
            f12_arg2:ClearSubGoal()
            f12_arg2:AddSubGoal(GOAL_COMMON_LeaveTarget, 10, TARGET_ENE_0, f12_local3, TARGET_SELF, false, -1)
            if f12_local2 <= 50 or f12_local3 < 1.5 then
                f12_arg2:AddSubGoal(GOAL_COMMON_EndureAttack, 10, 3000, TARGET_ENE_0, 9999, 0)
            end
            return true
        else
            f12_arg2:ClearSubGoal()
            f12_arg2:AddSubGoal(GOAL_COMMON_EndureAttack, 10, 3000, TARGET_ENE_0, 9999, 0)
            return true
        end
    end
    return false
    
end

Goal.ActAfter_AdjustSpace = function (f13_arg0, f13_arg1, f13_arg2)
    
end

Goal.Update = function (f14_arg0, f14_arg1, f14_arg2)
    return Update_Default_NoSubGoal(f14_arg0, f14_arg1, f14_arg2)
    
end

Goal.Terminate = function (f15_arg0, f15_arg1, f15_arg2)
    
end


