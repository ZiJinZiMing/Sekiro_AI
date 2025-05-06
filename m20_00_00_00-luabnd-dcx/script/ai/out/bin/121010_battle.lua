RegisterTableGoal(GOAL_Sokushinbutsu_poltergeist_121010_Battle, "GOAL_Sokushinbutsu_poltergeist_121010_Battle")
REGISTER_GOAL_NO_UPDATE(GOAL_Sokushinbutsu_poltergeist_121010_Battle, true)

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
    local f2_local5 = f2_arg1:GetEventRequest()
    local f2_local6 = f2_arg1:GetEventRequest(1)
    f2_arg1:AddObserveRegion(0, TARGET_ENE_0, 2002600)
    if f2_arg1:IsInsideTargetRegion(TARGET_ENE_0, 2002600) then
        f2_local0[1] = 100
    else
        f2_local0[26] = 100
    end
    f2_local0[1] = SetCoolTime(f2_arg1, f2_arg2, 3020, 8, f2_local0[1], 1)
    f2_local1[1] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act01)
    f2_local1[26] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act26)
    local f2_local7 = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.ActAfter_AdjustSpace)
    Common_Battle_Activate(f2_arg1, f2_arg2, f2_local0, f2_local1, f2_local7, f2_local2)
    
end

Goal.Act01 = function (f3_arg0, f3_arg1, f3_arg2)
    local f3_local0 = 9999 - f3_arg0:GetMapHitRadius(TARGET_SELF)
    local f3_local1 = 9999 - f3_arg0:GetMapHitRadius(TARGET_SELF) + 0
    local f3_local2 = 9999 - f3_arg0:GetMapHitRadius(TARGET_SELF) + 2
    local f3_local3 = 100
    local f3_local4 = 0
    local f3_local5 = 1.5
    local f3_local6 = 3
    local f3_local7 = 3020
    local f3_local8 = 0
    local f3_local9 = 360
    f3_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 10, f3_local7, TARGET_ENE_0, 9999, f3_local8, f3_local9, 0, 0)
    f3_arg1:AddSubGoal(GOAL_COMMON_Wait, 2, TARGET_SELF, 0, 0, 0)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act26 = function (f4_arg0, f4_arg1, f4_arg2)
    f4_arg1:AddSubGoal(GOAL_COMMON_Wait, 3, TARGET_SELF, 0, 0, 0)
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
    
end

Goal.Interrupt = function (f5_arg0, f5_arg1, f5_arg2)
    if f5_arg1:IsInterupt(INTERUPT_Inside_ObserveArea) and f5_arg1:IsInsideObserve(0) then
        f5_arg1:Replanning()
        return true
    end
    return false
    
end

Goal.ActAfter_AdjustSpace = function (f6_arg0, f6_arg1, f6_arg2)
    
end

Goal.Update = function (f7_arg0, f7_arg1, f7_arg2)
    return Update_Default_NoSubGoal(f7_arg0, f7_arg1, f7_arg2)
    
end

Goal.Terminate = function (f8_arg0, f8_arg1, f8_arg2)
    
end


