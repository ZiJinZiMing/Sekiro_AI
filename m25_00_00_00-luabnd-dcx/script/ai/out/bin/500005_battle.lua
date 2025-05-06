RegisterTableGoal(GOAL_HakaisouPhantom500005_Battle, "HakaisouPhantom500005_Battle")
REGISTER_GOAL_NO_SUB_GOAL(GOAL_HakaisouPhantom500005_Battle, true)

Goal.Initialize = function (f1_arg0, f1_arg1, f1_arg2, f1_arg3)
    
end

Goal.Activate = function (f2_arg0, f2_arg1, f2_arg2)
    Init_Pseudo_Global(f2_arg1, f2_arg2)
    f2_arg1:SetStringIndexedNumber("Dist_SideStep", 0)
    f2_arg1:SetStringIndexedNumber("Dist_BackStep", 0)
    local f2_local0 = {}
    local f2_local1 = {}
    local f2_local2 = {}
    Common_Clear_Param(f2_local0, f2_local1, f2_local2)
    local f2_local3 = f2_arg1:GetHpRate(TARGET_SELF)
    local f2_local4 = f2_arg1:GetSp(TARGET_SELF)
    local f2_local5 = f2_arg1:GetDist(TARGET_ENE_0)
    local f2_local6 = f2_arg1:GetRandam_Int(1, 100)
    local f2_local7 = f2_arg1:GetExcelParam(AI_EXCEL_THINK_PARAM_TYPE__thinkAttr_doAdmirer)
    local f2_local8 = f2_arg1:GetEventRequest()
    local f2_local9 = f2_arg1:GetEventRequest(1)
    f2_arg1:DeleteObserve(1)
    f2_arg1:SetNumber(11, 0)
    f2_arg1:AddObserveSpecialEffectAttribute(TARGET_SELF, 5026)
    f2_arg1:AddObserveSpecialEffectAttribute(TARGET_SELF, 5027)
    if f2_local9 == 0 then
        f2_local0[40] = 100
    elseif f2_local8 == 10 and (f2_arg1:IsInsideTargetRegion(TARGET_ENE_0, 9622850) == true or f2_arg1:IsInsideTargetRegion(TARGET_ENE_0, 2502853) == true or f2_arg1:IsInsideTargetRegion(TARGET_ENE_0, 2512853) == true) then
        f2_local0[10] = 10
        f2_local0[11] = 10
        f2_local0[12] = 10
        f2_local0[13] = 10
    elseif f2_local9 == 10 then
        f2_local0[1] = 0
        f2_local0[4] = 0
        f2_local0[5] = 0
        f2_local0[8] = 0
        f2_local0[9] = 100
    elseif f2_local9 == 20 then
        f2_local0[1] = 0
        f2_local0[2] = 0
        f2_local0[5] = 0
        f2_local0[8] = 100
        f2_local0[9] = 0
    elseif f2_local9 == 30 then
        f2_local0[1] = 0
        f2_local0[2] = 0
        f2_local0[3] = 0
        f2_local0[4] = 0
        f2_local0[5] = 100
    elseif f2_local9 == 40 then
        f2_local0[6] = 100
    elseif f2_local9 == 50 then
        f2_local0[7] = 100
    else
        f2_local0[2] = 100
    end
    f2_local1[1] = REGIST_FUNC(f2_arg1, f2_arg2, HakaisouPhantom500005_Act01)
    f2_local1[2] = REGIST_FUNC(f2_arg1, f2_arg2, HakaisouPhantom500005_Act02)
    f2_local1[3] = REGIST_FUNC(f2_arg1, f2_arg2, HakaisouPhantom500005_Act03)
    f2_local1[4] = REGIST_FUNC(f2_arg1, f2_arg2, HakaisouPhantom500005_Act04)
    f2_local1[5] = REGIST_FUNC(f2_arg1, f2_arg2, HakaisouPhantom500005_Act05)
    f2_local1[6] = REGIST_FUNC(f2_arg1, f2_arg2, HakaisouPhantom500005_Act06)
    f2_local1[7] = REGIST_FUNC(f2_arg1, f2_arg2, HakaisouPhantom500005_Act07)
    f2_local1[8] = REGIST_FUNC(f2_arg1, f2_arg2, HakaisouPhantom500005_Act08)
    f2_local1[9] = REGIST_FUNC(f2_arg1, f2_arg2, HakaisouPhantom500005_Act09)
    f2_local1[10] = REGIST_FUNC(f2_arg1, f2_arg2, HakaisouPhantom500005_Act10)
    f2_local1[11] = REGIST_FUNC(f2_arg1, f2_arg2, HakaisouPhantom500005_Act11)
    f2_local1[12] = REGIST_FUNC(f2_arg1, f2_arg2, HakaisouPhantom500005_Act12)
    f2_local1[13] = REGIST_FUNC(f2_arg1, f2_arg2, HakaisouPhantom500005_Act13)
    f2_local1[40] = REGIST_FUNC(f2_arg1, f2_arg2, HakaisouPhantom500005_Act40)
    local f2_local10 = REGIST_FUNC(f2_arg1, f2_arg2, HakaisouPhantom500005_ActAfter_AdjustSpace)
    Common_Battle_Activate(f2_arg1, f2_arg2, f2_local0, f2_local1, f2_local10, f2_local2)
    
end

function HakaisouPhantom500005_Act01(f3_arg0, f3_arg1, f3_arg2)
    local f3_local0 = f3_arg0:GetDist(TARGET_ENE_0)
    local f3_local1 = 17.9 - f3_arg0:GetMapHitRadius(TARGET_SELF) - 1
    local f3_local2 = false
    local f3_local3 = 1
    if f3_local1 < f3_local0 then
        f3_arg1:AddSubGoal(GOAL_COMMON_ApproachTarget, f3_local3, TARGET_ENE_0, f3_local1, TARGET_SELF, f3_local2, -1)
    end
    local f3_local4 = 3001
    local f3_local5 = 17.9 - f3_arg0:GetMapHitRadius(TARGET_SELF)
    local f3_local6 = 0
    local f3_local7 = 0
    f3_arg0:AddObserveArea(1, TARGET_SELF, TARGET_ENE_0, AI_DIR_TYPE_F, 360, 5)
    f3_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 10, f3_local4, TARGET_ENE_0, f3_local5, f3_local6, f3_local7, 0, 0)
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
    
end

function HakaisouPhantom500005_Act02(f4_arg0, f4_arg1, f4_arg2)
    local f4_local0 = f4_arg0:GetDist(TARGET_ENE_0)
    local f4_local1 = 5.6 - f4_arg0:GetMapHitRadius(TARGET_SELF) - 1
    local f4_local2 = false
    local f4_local3 = 1
    if f4_local1 < f4_local0 then
        f4_arg1:AddSubGoal(GOAL_COMMON_ApproachTarget, f4_local3, TARGET_ENE_0, f4_local1, TARGET_SELF, f4_local2, -1)
    end
    local f4_local4 = 3003
    local f4_local5 = 5.6 - f4_arg0:GetMapHitRadius(TARGET_SELF)
    local f4_local6 = 0
    local f4_local7 = 0
    f4_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 10, f4_local4, TARGET_ENE_0, f4_local5, f4_local6, f4_local7, 0, 0)
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
    
end

function HakaisouPhantom500005_Act03(f5_arg0, f5_arg1, f5_arg2)
    local f5_local0 = f5_arg0:GetDist(TARGET_ENE_0)
    local f5_local1 = 3.5 - f5_arg0:GetMapHitRadius(TARGET_SELF) - 1
    local f5_local2 = false
    local f5_local3 = 1
    if f5_local1 < f5_local0 then
        f5_arg1:AddSubGoal(GOAL_COMMON_ApproachTarget, f5_local3, TARGET_ENE_0, f5_local1, TARGET_SELF, f5_local2, -1)
    end
    local f5_local4 = 3013
    local f5_local5 = 3.5 - f5_arg0:GetMapHitRadius(TARGET_SELF)
    local f5_local6 = 0
    local f5_local7 = 0
    f5_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 10, f5_local4, TARGET_ENE_0, f5_local5, f5_local6, f5_local7, 0, 0)
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
    
end

function HakaisouPhantom500005_Act04(f6_arg0, f6_arg1, f6_arg2)
    local f6_local0 = f6_arg0:GetDist(TARGET_ENE_0)
    local f6_local1 = 4 - f6_arg0:GetMapHitRadius(TARGET_SELF) - 1
    local f6_local2 = false
    local f6_local3 = 1
    if f6_local1 < f6_local0 then
        f6_arg1:AddSubGoal(GOAL_COMMON_ApproachTarget, f6_local3, TARGET_ENE_0, f6_local1, TARGET_SELF, f6_local2, -1)
    end
    local f6_local4 = 3022
    local f6_local5 = 4 - f6_arg0:GetMapHitRadius(TARGET_SELF)
    local f6_local6 = 0
    local f6_local7 = 0
    f6_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 10, f6_local4, TARGET_ENE_0, f6_local5, f6_local6, f6_local7, 0, 0)
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
    
end

function HakaisouPhantom500005_Act05(f7_arg0, f7_arg1, f7_arg2)
    local f7_local0 = f7_arg0:GetDist(TARGET_ENE_0)
    local f7_local1 = 11 - f7_arg0:GetMapHitRadius(TARGET_SELF)
    local f7_local2 = false
    local f7_local3 = 1
    if f7_local1 < f7_local0 then
        f7_arg1:AddSubGoal(GOAL_COMMON_ApproachTarget, f7_local3, TARGET_ENE_0, f7_local1, TARGET_SELF, f7_local2, -1)
    end
    local f7_local4 = 3023
    local f7_local5 = 11 - f7_arg0:GetMapHitRadius(TARGET_SELF)
    local f7_local6 = 0
    local f7_local7 = 0
    f7_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 10, f7_local4, TARGET_ENE_0, f7_local5, f7_local6, f7_local7, 0, 0)
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
    
end

function HakaisouPhantom500005_Act06(f8_arg0, f8_arg1, f8_arg2)
    local f8_local0 = f8_arg0:GetDist(TARGET_ENE_0)
    local f8_local1 = 4 - f8_arg0:GetMapHitRadius(TARGET_SELF)
    local f8_local2 = false
    local f8_local3 = 3
    if f8_local1 < f8_local0 then
        f8_arg1:AddSubGoal(GOAL_COMMON_ApproachTarget, f8_local3, TARGET_ENE_0, f8_local1, TARGET_SELF, f8_local2, -1)
    end
    local f8_local4 = 3035
    local f8_local5 = 3036
    local f8_local6 = 3037
    local f8_local7 = 9999
    local f8_local8 = 9999
    local f8_local9 = 9999
    local f8_local10 = 0
    local f8_local11 = 0
    f8_arg1:AddSubGoal(GOAL_COMMON_ComboTunable_SuccessAngle180, 15, f8_local4, TARGET_ENE_0, f8_local7, f8_local10, f8_local11, 0, 0)
    f8_arg1:AddSubGoal(GOAL_COMMON_ComboRepeat_SuccessAngle180, 10, f8_local5, TARGET_ENE_0, f8_local8, 0, 0)
    f8_arg1:AddSubGoal(GOAL_COMMON_ComboRepeat_SuccessAngle180, 10, f8_local5, TARGET_ENE_0, f8_local8, 0, 0)
    f8_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, f8_local6, TARGET_ENE_0, f8_local9, 0, 0)
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
    
end

Goal.Act07 = function (f9_arg0, f9_arg1, f9_arg2)
    local f9_local0 = f9_arg0:GetDist(TARGET_ENE_0)
    local f9_local1 = 14.5 - f9_arg0:GetMapHitRadius(TARGET_SELF)
    local f9_local2 = false
    local f9_local3 = 3
    if f9_local1 < f9_local0 then
        f9_arg1:AddSubGoal(GOAL_COMMON_ApproachTarget, f9_local3, TARGET_ENE_0, f9_local1, TARGET_SELF, f9_local2, -1)
    end
    local f9_local4 = 3038
    local f9_local5 = 9999
    local f9_local6 = 0
    local f9_local7 = 0
    f9_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 10, f9_local4, TARGET_ENE_0, f9_local5, f9_local6, f9_local7, 0, 0)
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
    
end

function HakaisouPhantom500005_Act08(f10_arg0, f10_arg1, f10_arg2)
    local f10_local0 = f10_arg0:GetDist(TARGET_ENE_0)
    local f10_local1 = 7 - f10_arg0:GetMapHitRadius(TARGET_SELF) - 2.5
    local f10_local2 = false
    local f10_local3 = 1
    f10_arg1:AddSubGoal(GOAL_COMMON_ApproachTarget, f10_local3, TARGET_ENE_0, f10_local1, TARGET_SELF, f10_local2, -1)
    local f10_local4 = 3006
    local f10_local5 = 7 - f10_arg0:GetMapHitRadius(TARGET_SELF)
    local f10_local6 = 0
    local f10_local7 = 0
    f10_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 10, f10_local4, TARGET_ENE_0, f10_local5, f10_local6, f10_local7, 0, 0)
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
    
end

function HakaisouPhantom500005_Act09(f11_arg0, f11_arg1, f11_arg2)
    local f11_local0 = f11_arg0:GetDist(TARGET_ENE_0)
    local f11_local1 = 9 - f11_arg0:GetMapHitRadius(TARGET_SELF) - 2.5
    local f11_local2 = false
    local f11_local3 = 1
    f11_arg1:AddSubGoal(GOAL_COMMON_ApproachTarget, f11_local3, TARGET_ENE_0, f11_local1, TARGET_SELF, f11_local2, -1)
    local f11_local4 = 3011
    local f11_local5 = 9 - f11_arg0:GetMapHitRadius(TARGET_SELF)
    local f11_local6 = 0
    local f11_local7 = 0
    f11_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 10, f11_local4, TARGET_ENE_0, f11_local5, f11_local6, f11_local7, 0, 0)
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
    
end

function HakaisouPhantom500005_Act10(f12_arg0, f12_arg1, f12_arg2)
    local f12_local0 = f12_arg0:GetDist(TARGET_ENE_0)
    local f12_local1 = 11 - f12_arg0:GetMapHitRadius(TARGET_SELF)
    local f12_local2 = false
    local f12_local3 = 1
    if f12_local1 < f12_local0 then
        f12_arg1:AddSubGoal(GOAL_COMMON_ApproachTarget, f12_local3, TARGET_ENE_0, f12_local1, TARGET_SELF, f12_local2, -1)
    end
    local f12_local4 = 3023
    local f12_local5 = 11 - f12_arg0:GetMapHitRadius(TARGET_SELF)
    local f12_local6 = 0
    local f12_local7 = 0
    f12_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 10, f12_local4, TARGET_ENE_0, f12_local5, f12_local6, f12_local7, 0, 0)
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
    
end

function HakaisouPhantom500005_Act11(f13_arg0, f13_arg1, f13_arg2)
    local f13_local0 = f13_arg0:GetDist(TARGET_ENE_0)
    local f13_local1 = 6 - f13_arg0:GetMapHitRadius(TARGET_SELF)
    local f13_local2 = false
    local f13_local3 = 1
    if f13_local1 < f13_local0 then
        f13_arg1:AddSubGoal(GOAL_COMMON_ApproachTarget, f13_local3, TARGET_ENE_0, f13_local1, TARGET_SELF, f13_local2, -1)
    end
    local f13_local4 = 3024
    local f13_local5 = 6 - f13_arg0:GetMapHitRadius(TARGET_SELF)
    local f13_local6 = 0
    local f13_local7 = 0
    f13_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 10, f13_local4, TARGET_ENE_0, f13_local5, f13_local6, f13_local7, 0, 0)
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
    
end

function HakaisouPhantom500005_Act12(f14_arg0, f14_arg1, f14_arg2)
    local f14_local0 = f14_arg0:GetDist(TARGET_ENE_0)
    local f14_local1 = 6 - f14_arg0:GetMapHitRadius(TARGET_SELF)
    local f14_local2 = false
    local f14_local3 = 1
    if f14_local1 < f14_local0 then
        f14_arg1:AddSubGoal(GOAL_COMMON_ApproachTarget, f14_local3, TARGET_ENE_0, f14_local1, TARGET_SELF, f14_local2, -1)
    end
    local f14_local4 = 3025
    local f14_local5 = 6 - f14_arg0:GetMapHitRadius(TARGET_SELF)
    local f14_local6 = 0
    local f14_local7 = 0
    f14_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 10, f14_local4, TARGET_ENE_0, f14_local5, f14_local6, f14_local7, 0, 0)
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
    
end

function HakaisouPhantom500005_Act13(f15_arg0, f15_arg1, f15_arg2)
    local f15_local0 = f15_arg0:GetDist(TARGET_ENE_0)
    local f15_local1 = 12 - f15_arg0:GetMapHitRadius(TARGET_SELF)
    local f15_local2 = false
    local f15_local3 = 1
    if f15_local1 < f15_local0 then
        f15_arg1:AddSubGoal(GOAL_COMMON_ApproachTarget, f15_local3, TARGET_ENE_0, f15_local1, TARGET_SELF, f15_local2, -1)
    end
    local f15_local4 = 3026
    local f15_local5 = 12 - f15_arg0:GetMapHitRadius(TARGET_SELF)
    local f15_local6 = 0
    local f15_local7 = 0
    f15_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 10, f15_local4, TARGET_ENE_0, f15_local5, f15_local6, f15_local7, 0, 0)
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
    
end

function HakaisouPhantom500005_Act40(f16_arg0, f16_arg1, f16_arg2)
    f16_arg1:AddSubGoal(GOAL_COMMON_Wait, 1, TARGET_ENE_0, 0, 0, 0)
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
    
end

function HakaisouPhantom500005_ActAfter_AdjustSpace(f17_arg0, f17_arg1, f17_arg2)
    
end

Goal.Update = function (f18_arg0, f18_arg1, f18_arg2)
    return Update_Default_NoSubGoal(f18_arg0, f18_arg1, f18_arg2)
    
end

Goal.Terminate = function (f19_arg0, f19_arg1, f19_arg2)
    
end

Goal.Interrupt = function (f20_arg0, f20_arg1, f20_arg2)
    local f20_local0 = f20_arg1:GetSp(TARGET_SELF)
    local f20_local1 = f20_arg1:GetDist(TARGET_ENE_0)
    if f20_arg1:IsLadderAct(TARGET_SELF) then
        return false
    end
    if f20_arg1:IsInterupt(INTERUPT_Inside_ObserveArea) then
        f20_arg2:ClearSubGoal()
        f20_arg2:AddSubGoal(GOAL_COMMON_ComboRepeat, 10, 3021, TARGET_ENE_0, 999, 0, 0)
        f20_arg1:DeleteObserve(1)
        return true
    end
    return false
    
end


