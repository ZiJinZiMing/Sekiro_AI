RegisterTableGoal(GOAL_Nishikigoi_505000_Battle, "GOAL_Nishikigoi_505000_Battle")
REGISTER_GOAL_NO_UPDATE(GOAL_Nishikigoi_505000_Battle, true)

Goal.Initialize = function (f1_arg0, f1_arg1, f1_arg2, f1_arg3)
    
end

Goal.Activate = function (f2_arg0, f2_arg1, f2_arg2)
    Init_Pseudo_Global(f2_arg1, f2_arg2)
    f2_arg1:SetStringIndexedNumber("Dist_Step_Small", 2)
    f2_arg1:SetStringIndexedNumber("Dist_Step_Large", 4)
    f2_arg1:SetStringIndexedNumber("KengekiID", 0)
    f2_arg1:SetStringIndexedNumber("EndPoint", 2502802)
    f2_arg1:SetStringIndexedNumber("Area_First", 2502803)
    f2_arg1:SetStringIndexedNumber("Area_Last", 2502804)
    f2_arg1:SetStringIndexedNumber("Area_BattleStart", 2502807)
    f2_arg1:SetStringIndexedNumber("Point_Standard_Front", 2502805)
    f2_arg1:SetStringIndexedNumber("Point_Standard_Back", 2502806)
    if f2_arg1:GetNpcThinkParamID() == 50509000 or f2_arg1:GetNpcThinkParamID() == 50509090 then
        f2_arg1:SetStringIndexedNumber("EndPoint", 9992802)
        f2_arg1:SetStringIndexedNumber("Area_First", 9992803)
        f2_arg1:SetStringIndexedNumber("Area_Last", 9992804)
        f2_arg1:SetStringIndexedNumber("Area_BattleStart", 9992807)
        f2_arg1:SetStringIndexedNumber("Point_Standard_Front", 9992805)
        f2_arg1:SetStringIndexedNumber("Point_Standard_Back", 9992806)
    end
    local f2_local0 = {}
    local f2_local1 = {}
    local f2_local2 = {}
    Common_Clear_Param(f2_local0, f2_local1, f2_local2)
    local f2_local3 = f2_arg1:GetHpRate(TARGET_SELF)
    local f2_local4 = f2_arg1:GetSp(TARGET_SELF)
    local f2_local5 = f2_arg1:GetDist(TARGET_ENE_0)
    local f2_local6 = f2_arg1:GetDistY(TARGET_ENE_0)
    local f2_local7 = f2_arg1:GetDistYSigned(TARGET_ENE_0)
    local f2_local8 = f2_arg1:GetExcelParam(AI_EXCEL_THINK_PARAM_TYPE__thinkAttr_doAdmirer)
    local f2_local9 = f2_arg1:GetEventRequest()
    f2_arg1:SetEventMoveTarget(f2_arg1:GetStringIndexedNumber("EndPoint"))
    local f2_local10 = f2_arg1:GetDistAtoB(TARGET_SELF, POINT_EVENT)
    local f2_local11 = f2_arg1:GetDistAtoB(TARGET_ENE_0, POINT_EVENT)
    f2_arg1:SetStringIndexedNumber("pointDist", f2_local10)
    f2_arg1:SetStringIndexedNumber("targetToPointDist", f2_local11)
    f2_arg1:AddObserveSpecialEffectAttribute(TARGET_SELF, 5025)
    f2_arg1:AddObserveSpecialEffectAttribute(TARGET_SELF, 5026)
    f2_arg1:AddObserveSpecialEffectAttribute(TARGET_SELF, 5027)
    f2_arg1:AddObserveSpecialEffectAttribute(TARGET_SELF, 5028)
    f2_arg1:AddObserveSpecialEffectAttribute(TARGET_SELF, 3505010)
    f2_arg1:AddObserveRegion(0, TARGET_ENE_0, 2502819)
    f2_arg1:AddObserveRegion(1, TARGET_ENE_0, 2502370)
    if f2_arg1:HasSpecialEffectId(TARGET_ENE_0, 110060) then
        if f2_arg1:IsInsideTarget(TARGET_ENE_0, AI_DIR_TYPE_F, 90) then
            f2_local0[26] = 100
        else
            f2_local0[21] = 100
        end
    elseif f2_arg1:IsInsideTarget(TARGET_ENE_0, AI_DIR_TYPE_B, 180) then
        if f2_local5 >= 40 then
            f2_local0[6] = 0
            f2_local0[7] = 0
            f2_local0[8] = 0
            f2_local0[21] = 200
        elseif f2_local5 >= 20 then
            f2_local0[6] = 0
            f2_local0[7] = 0
            f2_local0[8] = 20
            f2_local0[21] = 100
        else
            if f2_arg1:IsInsideTarget(TARGET_ENE_0, AI_DIR_TYPE_R, 180) then
                f2_local0[6] = 100
            else
                f2_local0[7] = 100
            end
            f2_local0[8] = 100
            f2_local0[10] = 100
        end
    elseif f2_local5 >= 80 then
        f2_local0[1] = 100
    elseif f2_local5 >= 50 then
        f2_local0[1] = 800
        f2_local0[5] = 0
        f2_local0[6] = 0
        f2_local0[7] = 0
        f2_local0[8] = 0
    elseif f2_local5 >= 35 then
        f2_local0[1] = 100
        f2_local0[5] = 0
        f2_local0[6] = 0
        f2_local0[7] = 0
        f2_local0[8] = 0
    elseif f2_local5 >= 20 then
        f2_local0[1] = 100
        f2_local0[6] = 0
        f2_local0[7] = 0
        f2_local0[8] = 0
    else
        f2_local0[1] = 30
        f2_local0[2] = 0
        f2_local0[6] = 0
        f2_local0[7] = 0
        f2_local0[8] = 100
        f2_local0[11] = 0
        f2_local0[12] = 0
    end
    if f2_arg1:IsInsideTarget(TARGET_ENE_0, AI_DIR_TYPE_R, 180) then
        f2_local0[3] = 0
        f2_local0[11] = 0
    else
        f2_local0[4] = 0
        f2_local0[12] = 0
    end
    f2_local0[2] = 0
    if f2_local6 >= 20 then
        f2_local0[5] = 0
    end
    if f2_local11 <= f2_local10 + 10 or f2_arg1:IsInsideTargetRegion(TARGET_SELF, f2_arg1:GetStringIndexedNumber("Area_First")) == true or f2_local10 >= 30 then
        f2_local0[8] = 0
    end
    if f2_local11 + 40 <= f2_local10 then
        f2_local0[1] = f2_local0[1] * 10
    end
    f2_local0[1] = SetCoolTime(f2_arg1, f2_arg2, 3000, 8, f2_local0[1], 1)
    f2_local0[2] = SetCoolTime(f2_arg1, f2_arg2, 3001, 15, f2_local0[2], 1)
    f2_local0[3] = SetCoolTime(f2_arg1, f2_arg2, 3002, 10, f2_local0[3], 1)
    f2_local0[4] = SetCoolTime(f2_arg1, f2_arg2, 3003, 10, f2_local0[4], 1)
    f2_local0[5] = SetCoolTime(f2_arg1, f2_arg2, 3004, 15, f2_local0[5], 1)
    f2_local0[8] = SetCoolTime(f2_arg1, f2_arg2, 3007, 30, f2_local0[8], 1)
    f2_local0[10] = SetCoolTime(f2_arg1, f2_arg2, 3009, 10, f2_local0[10], 1)
    f2_local0[11] = SetCoolTime(f2_arg1, f2_arg2, 3012, 10, f2_local0[11], 1)
    f2_local0[12] = SetCoolTime(f2_arg1, f2_arg2, 3013, 10, f2_local0[12], 1)
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
    f2_local1[12] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act12)
    f2_local1[13] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act13)
    f2_local1[21] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act21)
    f2_local1[22] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act22)
    f2_local1[23] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act23)
    f2_local1[24] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act24)
    f2_local1[25] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act25)
    f2_local1[26] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act26)
    f2_local1[27] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act27)
    f2_local1[28] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act28)
    f2_local1[31] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act31)
    local f2_local12 = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.ActAfter_AdjustSpace)
    Common_Battle_Activate(f2_arg1, f2_arg2, f2_local0, f2_local1, f2_local12, f2_local2)
    
end

Goal.Act01 = function (f3_arg0, f3_arg1, f3_arg2)
    local f3_local0 = f3_arg0:GetDist(TARGET_ENE_0)
    local f3_local1 = 120 - f3_arg0:GetMapHitRadius(TARGET_SELF)
    local f3_local2 = false
    local f3_local3 = 3
    f3_arg1:AddSubGoal(GOAL_COMMON_Turn, 5, TARGET_ENE_0, 90, -1, GOAL_RESULT_Success, true)
    local f3_local4 = 3000
    local f3_local5 = 3010
    local f3_local6 = 0
    local f3_local7 = 0
    f3_arg1:AddSubGoal(GOAL_COMMON_ComboTunable_SuccessAngle180, 10, f3_local4, TARGET_ENE_0, 9999, f3_local6, f3_local7, 0, 0)
    f3_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, f3_local5, TARGET_ENE_0, 9999, 0, 0)
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
    
end

Goal.Act02 = function (f4_arg0, f4_arg1, f4_arg2)
    local f4_local0 = f4_arg0:GetDist(TARGET_ENE_0)
    local f4_local1 = 60 - f4_arg0:GetMapHitRadius(TARGET_SELF)
    local f4_local2 = false
    local f4_local3 = 3
    if f4_local1 < f4_local0 then
        f4_arg1:AddSubGoal(GOAL_COMMON_ApproachTarget, f4_local3, TARGET_ENE_0, f4_local1, TARGET_SELF, f4_local2, -1)
    end
    local f4_local4 = 3001
    local f4_local5 = 0
    local f4_local6 = 0
    f4_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 10, f4_local4, TARGET_ENE_0, 9999, f4_local5, f4_local6, 0, 0)
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
    
end

Goal.Act03 = function (f5_arg0, f5_arg1, f5_arg2)
    local f5_local0 = f5_arg0:GetDist(TARGET_ENE_0)
    local f5_local1 = 60 - f5_arg0:GetMapHitRadius(TARGET_SELF) + 10
    local f5_local2 = false
    local f5_local3 = 1
    if f5_arg0:IsInsideTarget(TARGET_ENE_0, AI_DIR_TYPE_B, 270) and f5_arg0:IsInsideTarget(TARGET_ENE_0, AI_DIR_TYPE_R, 180) then
    else
    end
    f5_arg1:AddSubGoal(GOAL_COMMON_Turn, 3, TARGET_ENE_0, 45, -1, GOAL_RESULT_Success, true)
    if f5_local1 < f5_local0 then
        f5_arg1:AddSubGoal(GOAL_COMMON_ApproachTarget, f5_local3, TARGET_ENE_0, f5_local1, TARGET_SELF, f5_local2, -1)
    end
    local f5_local4 = 3002
    local f5_local5 = 0
    local f5_local6 = 0
    f5_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 10, f5_local4, TARGET_ENE_0, 9999, f5_local5, f5_local6, 0, 0)
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
    
end

Goal.Act04 = function (f6_arg0, f6_arg1, f6_arg2)
    local f6_local0 = f6_arg0:GetDist(TARGET_ENE_0)
    local f6_local1 = 60 - f6_arg0:GetMapHitRadius(TARGET_SELF) + 10
    local f6_local2 = false
    local f6_local3 = 1
    if f6_arg0:IsInsideTarget(TARGET_ENE_0, AI_DIR_TYPE_B, 270) and f6_arg0:IsInsideTarget(TARGET_ENE_0, AI_DIR_TYPE_R, 180) then
    else
    end
    f6_arg1:AddSubGoal(GOAL_COMMON_Turn, 3, TARGET_ENE_0, 45, -1, GOAL_RESULT_Success, true)
    if f6_local1 < f6_local0 then
        f6_arg1:AddSubGoal(GOAL_COMMON_ApproachTarget, f6_local3, TARGET_ENE_0, f6_local1, TARGET_SELF, f6_local2, -1)
    end
    local f6_local4 = 3003
    local f6_local5 = 0
    local f6_local6 = 0
    f6_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 10, f6_local4, TARGET_ENE_0, 9999, f6_local5, f6_local6, 0, 0)
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
    
end

Goal.Act05 = function (f7_arg0, f7_arg1, f7_arg2)
    local f7_local0 = f7_arg0:GetDist(TARGET_ENE_0)
    local f7_local1 = 50 - f7_arg0:GetMapHitRadius(TARGET_SELF)
    local f7_local2 = false
    local f7_local3 = 3
    if f7_local1 < f7_local0 then
        f7_arg1:AddSubGoal(GOAL_COMMON_ApproachTarget, f7_local3, TARGET_ENE_0, f7_local1, TARGET_SELF, f7_local2, -1)
    end
    local f7_local4 = 3004
    local f7_local5 = 0
    local f7_local6 = 0
    f7_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 10, f7_local4, TARGET_ENE_0, 9999, f7_local5, f7_local6, 0, 0)
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
    
end

Goal.Act06 = function (f8_arg0, f8_arg1, f8_arg2)
    local f8_local0 = f8_arg0:GetDist(TARGET_ENE_0)
    local f8_local1 = 999 - f8_arg0:GetMapHitRadius(TARGET_SELF)
    local f8_local2 = false
    local f8_local3 = 3
    if f8_local1 < f8_local0 then
        f8_arg1:AddSubGoal(GOAL_COMMON_ApproachTarget, f8_local3, TARGET_ENE_0, f8_local1, TARGET_SELF, f8_local2, -1)
    end
    local f8_local4 = 3005
    local f8_local5 = 0
    local f8_local6 = 0
    f8_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 10, f8_local4, TARGET_ENE_0, 9999, f8_local5, f8_local6, 0, 0)
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
    
end

Goal.Act07 = function (f9_arg0, f9_arg1, f9_arg2)
    local f9_local0 = f9_arg0:GetDist(TARGET_ENE_0)
    local f9_local1 = 999 - f9_arg0:GetMapHitRadius(TARGET_SELF)
    local f9_local2 = false
    local f9_local3 = 3
    if f9_local1 < f9_local0 then
        f9_arg1:AddSubGoal(GOAL_COMMON_ApproachTarget, f9_local3, TARGET_ENE_0, f9_local1, TARGET_SELF, f9_local2, -1)
    end
    local f9_local4 = 3006
    local f9_local5 = 0
    local f9_local6 = 0
    f9_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 10, f9_local4, TARGET_ENE_0, 9999, f9_local5, f9_local6, 0, 0)
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
    
end

Goal.Act08 = function (f10_arg0, f10_arg1, f10_arg2)
    local f10_local0 = f10_arg0:GetDist(TARGET_ENE_0)
    local f10_local1 = 999 - f10_arg0:GetMapHitRadius(TARGET_SELF)
    local f10_local2 = false
    local f10_local3 = 3
    if f10_local1 < f10_local0 then
        f10_arg1:AddSubGoal(GOAL_COMMON_ApproachTarget, f10_local3, TARGET_ENE_0, f10_local1, TARGET_SELF, f10_local2, -1)
    end
    local f10_local4 = 3007
    local f10_local5 = 0
    local f10_local6 = 0
    f10_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 10, f10_local4, TARGET_ENE_0, 9999, f10_local5, f10_local6, 0, 0)
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
    
end

Goal.Act09 = function (f11_arg0, f11_arg1, f11_arg2)
    local f11_local0 = 3
    local f11_local1 = 45
    if f11_arg0:IsInsideTarget(TARGET_ENE_0, AI_DIR_TYPE_R, 90) or f11_arg0:IsInsideTarget(TARGET_ENE_0, AI_DIR_TYPE_L, 90) then
        if f11_arg0:IsInsideTarget(TARGET_ENE_0, AI_DIR_TYPE_R, 180) then
            f11_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 10, 3021, TARGET_ENE_0, 9999, 0, 0, 0, 0)
        else
            f11_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 10, 3020, TARGET_ENE_0, 9999, 0, 0, 0, 0)
        end
    elseif f11_arg0:IsInsideTarget(TARGET_ENE_0, AI_DIR_TYPE_B, 90) then
        if f11_arg0:IsInsideTarget(TARGET_ENE_0, AI_DIR_TYPE_R, 180) then
            f11_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 10, 3023, TARGET_ENE_0, 9999, 0, 0, 0, 0)
        else
            f11_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 10, 3022, TARGET_ENE_0, 9999, 0, 0, 0, 0)
        end
    else
        f11_arg1:AddSubGoal(GOAL_COMMON_Wait, 0.5, TARGET_ENE_0, 0, 0, 0)
    end
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
    
end

Goal.Act10 = function (f12_arg0, f12_arg1, f12_arg2)
    local f12_local0 = f12_arg0:GetRandam_Int(1, 100)
    local f12_local1 = 3009
    local f12_local2 = 3010
    local f12_local3 = 3000
    local f12_local4 = 0
    local f12_local5 = 0
    if f12_arg0:IsInsideTargetRegion(TARGET_SELF, f12_arg0:GetStringIndexedNumber("Area_Last")) == true then
        f12_arg0:SetEventMoveTarget(f12_arg0:GetStringIndexedNumber("Point_Standard_Front"))
    else
        f12_arg0:SetEventMoveTarget(f12_arg0:GetStringIndexedNumber("Point_Standard_Back"))
    end
    if f12_local0 <= 70 or f12_arg0:IsInsideTargetRegion(TARGET_SELF, f12_arg0:GetStringIndexedNumber("Area_Last")) == true then
        f12_arg1:AddSubGoal(GOAL_COMMON_ComboTunable_SuccessAngle180, 10, f12_local1, POINT_EVENT, 9999, f12_local4, f12_local5, 0, 0)
        f12_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, f12_local2, TARGET_ENE_0, 9999, 0, 0)
    else
        f12_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 10, f12_local1, POINT_EVENT, 9999, f12_local4, f12_local5, 0, 0)
    end
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
    
end

Goal.Act11 = function (f13_arg0, f13_arg1, f13_arg2)
    local f13_local0 = f13_arg0:GetDist(TARGET_ENE_0)
    local f13_local1 = 60 - f13_arg0:GetMapHitRadius(TARGET_SELF) + 10
    local f13_local2 = false
    local f13_local3 = 1
    if f13_arg0:IsInsideTarget(TARGET_ENE_0, AI_DIR_TYPE_B, 270) and f13_arg0:IsInsideTarget(TARGET_ENE_0, AI_DIR_TYPE_R, 180) then
    else
    end
    f13_arg1:AddSubGoal(GOAL_COMMON_Turn, 3, TARGET_ENE_0, 45, -1, GOAL_RESULT_Success, true)
    if f13_local1 < f13_local0 then
        f13_arg1:AddSubGoal(GOAL_COMMON_ApproachTarget, f13_local3, TARGET_ENE_0, f13_local1, TARGET_SELF, f13_local2, -1)
    end
    local f13_local4 = 3012
    local f13_local5 = 0
    local f13_local6 = 0
    f13_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 10, f13_local4, TARGET_ENE_0, 9999, f13_local5, f13_local6, 0, 0)
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
    
end

Goal.Act12 = function (f14_arg0, f14_arg1, f14_arg2)
    local f14_local0 = f14_arg0:GetDist(TARGET_ENE_0)
    local f14_local1 = 60 - f14_arg0:GetMapHitRadius(TARGET_SELF) + 10
    local f14_local2 = false
    local f14_local3 = 1
    if f14_arg0:IsInsideTarget(TARGET_ENE_0, AI_DIR_TYPE_B, 270) and f14_arg0:IsInsideTarget(TARGET_ENE_0, AI_DIR_TYPE_R, 180) then
    else
    end
    f14_arg1:AddSubGoal(GOAL_COMMON_Turn, 3, TARGET_ENE_0, 45, -1, GOAL_RESULT_Success, true)
    if f14_local1 < f14_local0 then
        f14_arg1:AddSubGoal(GOAL_COMMON_ApproachTarget, f14_local3, TARGET_ENE_0, f14_local1, TARGET_SELF, f14_local2, -1)
    end
    local f14_local4 = 3013
    local f14_local5 = 0
    local f14_local6 = 0
    f14_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 10, f14_local4, TARGET_ENE_0, 9999, f14_local5, f14_local6, 0, 0)
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
    
end

Goal.Act13 = function (f15_arg0, f15_arg1, f15_arg2)
    local f15_local0 = f15_arg0:GetDist(TARGET_ENE_0)
    local f15_local1 = 3014
    local f15_local2 = 3018
    local f15_local3 = 0
    local f15_local4 = 0
    f15_arg0:SetEventMoveTarget(f15_arg0:GetStringIndexedNumber("Point_Standard_Front"))
    f15_arg1:AddSubGoal(GOAL_COMMON_ComboTunable_SuccessAngle180, 10, f15_local1, POINT_EVENT, 9999, f15_local3, f15_local4, 0, 0)
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
    
end

Goal.Act21 = function (f16_arg0, f16_arg1, f16_arg2)
    local f16_local0 = 5
    local f16_local1 = 90
    f16_arg1:AddSubGoal(GOAL_COMMON_Turn, f16_local0, TARGET_ENE_0, f16_local1, -1, GOAL_RESULT_Success, true)
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
    
end

Goal.Act22 = function (f17_arg0, f17_arg1, f17_arg2)
    local f17_local0 = 3
    local f17_local1 = 0
    if SpaceCheck(f17_arg0, f17_arg1, -45, f17_arg0:GetStringIndexedNumber("Dist_Step_Small")) == true then
        if SpaceCheck(f17_arg0, f17_arg1, 45, f17_arg0:GetStringIndexedNumber("Dist_Step_Small")) == true then
            if f17_arg0:IsInsideTarget(TARGET_ENE_0, AI_DIR_TYPE_R, 180) then
                f17_arg1:AddSubGoal(GOAL_COMMON_SpinStep, f17_local0, 5202, TARGET_ENE_0, f17_local1, AI_DIR_TYPE_L, 0)
            else
                f17_arg1:AddSubGoal(GOAL_COMMON_SpinStep, f17_local0, 5203, TARGET_ENE_0, f17_local1, AI_DIR_TYPE_R, 0)
            end
        else
            f17_arg1:AddSubGoal(GOAL_COMMON_SpinStep, f17_local0, 5202, TARGET_ENE_0, f17_local1, AI_DIR_TYPE_L, 0)
        end
    elseif SpaceCheck(f17_arg0, f17_arg1, 45, f17_arg0:GetStringIndexedNumber("Dist_Step_Small")) == true then
        f17_arg1:AddSubGoal(GOAL_COMMON_SpinStep, f17_local0, 5203, TARGET_ENE_0, f17_local1, AI_DIR_TYPE_R, 0)
    else
        GetWellSpace_Odds = 100
        return GetWellSpace_Odds
    end
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
    
end

Goal.Act23 = function (f18_arg0, f18_arg1, f18_arg2)
    local f18_local0 = f18_arg0:GetDist(TARGET_ENE_0)
    local f18_local1 = f18_arg0:GetSp(TARGET_SELF)
    local f18_local2 = 20
    local f18_local3 = f18_arg0:GetRandam_Int(1, 100)
    local f18_local4 = -1
    local f18_local5 = 0
    if SpaceCheck(f18_arg0, f18_arg1, -90, 1) == true then
        if SpaceCheck(f18_arg0, f18_arg1, 90, 1) == true then
            if f18_arg0:IsInsideTarget(TARGET_ENE_0, AI_DIR_TYPE_R, 180) then
                f18_local5 = 0
            else
                f18_local5 = 1
            end
        else
            f18_local5 = 0
        end
    elseif SpaceCheck(f18_arg0, f18_arg1, 90, 1) == true then
        f18_local5 = 1
    else
        GetWellSpace_Odds = 100
        return GetWellSpace_Odds
    end
    local f18_local6 = 3
    local f18_local7 = f18_arg0:GetRandam_Int(30, 45)
    f18_arg0:SetNumber(10, f18_local5)
    f18_arg1:AddSubGoal(GOAL_COMMON_SidewayMove, f18_local6, TARGET_ENE_0, f18_local5, f18_local7, true, true, f18_local4):TimingSetTimer(2, 4, UPDATE_SUCCESS)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act24 = function (f19_arg0, f19_arg1, f19_arg2)
    local f19_local0 = f19_arg0:GetDist(TARGET_ENE_0)
    local f19_local1 = 3
    local f19_local2 = 0
    local f19_local3 = 5201
    if SpaceCheck(f19_arg0, f19_arg1, 180, f19_arg0:GetStringIndexedNumber("Dist_Step_Small")) == true then
        if SpaceCheck(f19_arg0, f19_arg1, 180, f19_arg0:GetStringIndexedNumber("Dist_Step_Large")) ~= true or f19_local0 > 4 then
        else
            f19_local3 = 5211
            if false then
            end
        end
    else
        GetWellSpace_Odds = 100
        return GetWellSpace_Odds
    end
    f19_arg1:AddSubGoal(GOAL_COMMON_SpinStep, f19_local1, f19_local3, TARGET_ENE_0, f19_local2, AI_DIR_TYPE_B, 0)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act25 = function (f20_arg0, f20_arg1, f20_arg2)
    local f20_local0 = f20_arg0:GetRandam_Float(2, 4)
    local f20_local1 = f20_arg0:GetRandam_Float(1, 3)
    local f20_local2 = f20_arg0:GetDist(TARGET_ENE_0)
    local f20_local3 = -1
    if SpaceCheck(f20_arg0, f20_arg1, 180, 1) == true then
        f20_arg1:AddSubGoal(GOAL_COMMON_LeaveTarget, f20_local0, TARGET_ENE_0, f20_local1, TARGET_ENE_0, true, f20_local3)
    else
        GetWellSpace_Odds = 100
        return GetWellSpace_Odds
    end
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
    
end

Goal.Act26 = function (f21_arg0, f21_arg1, f21_arg2)
    f21_arg1:AddSubGoal(GOAL_COMMON_Wait, 0.5, TARGET_NONE, 0, 0, 0)
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
    
end

Goal.Act27 = function (f22_arg0, f22_arg1, f22_arg2)
    local f22_local0 = f22_arg0:GetDist(TARGET_ENE_0)
    local f22_local1 = f22_arg0:GetDistYSigned(TARGET_ENE_0)
    local f22_local2 = f22_local1 / math.tan(math.deg(30))
    local f22_local3 = f22_arg0:GetRandam_Int(0, 1)
    if f22_local1 >= 3 then
        if f22_local2 + 1 <= f22_local0 then
            if SpaceCheck(f22_arg0, f22_arg1, 0, 4) == true then
                f22_arg1:AddSubGoal(GOAL_COMMON_ApproachTarget, 0.1, TARGET_ENE_0, f22_local2, TARGET_SELF, false, -1)
            elseif SpaceCheck(f22_arg0, f22_arg1, 0, 3) == true then
                f22_arg1:AddSubGoal(GOAL_COMMON_ApproachTarget, 0.5, TARGET_ENE_0, f22_local2, TARGET_SELF, true, -1)
            end
        elseif f22_local0 <= f22_local2 - 1 then
            f22_arg1:AddSubGoal(GOAL_COMMON_LeaveTarget, 10, TARGET_ENE_0, f22_local2, TARGET_ENE_0, true, -1)
        end
    elseif SpaceCheck(f22_arg0, f22_arg1, 0, 4) == true then
        f22_arg1:AddSubGoal(GOAL_COMMON_ApproachTarget, 0.1, TARGET_ENE_0, 0, TARGET_SELF, false, -1)
    elseif SpaceCheck(f22_arg0, f22_arg1, 0, 3) == true then
        f22_arg1:AddSubGoal(GOAL_COMMON_ApproachTarget, 0.5, TARGET_ENE_0, 0, TARGET_SELF, true, -1)
    elseif SpaceCheck(f22_arg0, f22_arg1, 0, 1) == false then
        f22_arg1:AddSubGoal(GOAL_COMMON_LeaveTarget, 0.5, TARGET_ENE_0, 999, TARGET_ENE_0, true, -1)
    end
    f22_arg0:SetNumber(10, f22_local3)
    f22_arg1:AddSubGoal(GOAL_COMMON_SidewayMove, 3, TARGET_ENE_0, f22_local3, f22_arg0:GetRandam_Int(30, 45), true, true, -1)
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
    
end

Goal.Act28 = function (f23_arg0, f23_arg1, f23_arg2)
    local f23_local0 = f23_arg0:GetDist(TARGET_ENE_0)
    local f23_local1 = 3
    local f23_local2 = f23_arg0:GetRandam_Int(30, 45)
    local f23_local3 = -1
    local f23_local4 = f23_arg0:GetRandam_Int(0, 1)
    if f23_local0 <= 3 then
        f23_arg1:AddSubGoal(GOAL_COMMON_SidewayMove, f23_local1, TARGET_ENE_0, f23_local4, f23_local2, true, true, f23_local3)
    elseif f23_local0 <= 8 then
        f23_arg1:AddSubGoal(GOAL_COMMON_ApproachTarget, 10, TARGET_ENE_0, 3, TARGET_SELF, true, -1)
    else
        f23_arg1:AddSubGoal(GOAL_COMMON_ApproachTarget, 10, TARGET_ENE_0, 8, TARGET_SELF, false, -1)
    end
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
    
end

Goal.Act31 = function (f24_arg0, f24_arg1, f24_arg2)
    local f24_local0 = f24_arg0:GetDist(TARGET_ENE_0)
    local f24_local1 = 9999
    local f24_local2 = 0
    local f24_local3 = 0
    local f24_local4 = f24_arg0:GetRandam_Int(2, 5)
    local f24_local5 = f24_arg0:GetRandam_Int(1, 100)
    local f24_local6 = f24_arg0:GetRandam_Float(4, 6)
    local f24_local7 = 3
    if f24_local5 <= 50 then
        f24_arg1:AddSubGoal(GOAL_COMMON_ApproachSettingDirection, f24_local6, TARGET_ENE_0, 0, TARGET_SELF, false, -1, AI_DIR_TYPE_ToL, 120)
        f24_arg1:AddSubGoal(GOAL_COMMON_ApproachSettingDirection, f24_local6, TARGET_ENE_0, 0, TARGET_SELF, false, -1, AI_DIR_TYPE_ToL, 80)
    else
        f24_arg1:AddSubGoal(GOAL_COMMON_ApproachSettingDirection, f24_local6, TARGET_ENE_0, 0, TARGET_SELF, false, -1, AI_DIR_TYPE_ToR, 120)
        f24_arg1:AddSubGoal(GOAL_COMMON_ApproachSettingDirection, f24_local6, TARGET_ENE_0, 0, TARGET_SELF, false, -1, AI_DIR_TYPE_ToR, 80)
    end
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
    
end

Goal.Interrupt = function (f25_arg0, f25_arg1, f25_arg2)
    local f25_local0 = f25_arg1:GetHpRate(TARGET_SELF)
    local f25_local1 = f25_arg1:GetDist(TARGET_ENE_0)
    local f25_local2 = f25_arg1:GetSp(TARGET_SELF)
    local f25_local3 = f25_arg1:GetSpecialEffectActivateInterruptType(0)
    local f25_local4 = f25_arg1:GetRandam_Int(1, 100)
    local f25_local5 = f25_arg1:GetRandam_Int(1, 100)
    if f25_arg1:IsLadderAct(TARGET_SELF) then
        return false
    end
    if not f25_arg1:HasSpecialEffectId(TARGET_SELF, 200004) then
        return false
    end
    if f25_arg1:IsInterupt(INTERUPT_ActivateSpecialEffect) and f25_local3 == 3505010 then
        f25_arg2:ClearSubGoal()
        f25_arg2:AddSubGoal(GOAL_COMMON_EndureAttack, 100, 3008, TARGET_ENE_0, 9999, 0)
        return true
    end
    if f25_arg1:IsInterupt(INTERUPT_Inside_ObserveArea) then
    end
    if f25_arg1:IsInterupt(INTERUPT_Outside_ObserveArea) then
    end
    return false
    
end

Goal.ActAfter_AdjustSpace = function (f26_arg0, f26_arg1, f26_arg2)
    
end

Goal.Update = function (f27_arg0, f27_arg1, f27_arg2)
    return Update_Default_NoSubGoal(f27_arg0, f27_arg1, f27_arg2)
    
end

Goal.Terminate = function (f28_arg0, f28_arg1, f28_arg2)
    
end


