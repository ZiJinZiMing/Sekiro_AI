RegisterTableGoal(GOAL_MurabitoZombie_sude_150000_Battle, "GOAL_MurabitoZombie_sude_150000_Battle")
REGISTER_GOAL_NO_UPDATE(GOAL_MurabitoZombie_sude_150000_Battle, true)

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
    f2_arg1:AddObserveSpecialEffectAttribute(TARGET_ENE_0, 106020)
    if f2_arg1:HasSpecialEffectId(TARGET_SELF, 3150100) then
        if f2_arg1:HasSpecialEffectId(TARGET_ENE_0, 108030) or f2_arg1:HasSpecialEffectId(TARGET_ENE_0, 110030) or f2_arg1:HasSpecialEffectId(TARGET_ENE_0, 110060) or f2_arg1:HasSpecialEffectId(TARGET_ENE_0, 110010) or f2_arg1:HasSpecialEffectId(TARGET_ENE_0, 110032) then
            f2_local0[17] = 100
        elseif f2_arg1:HasSpecialEffectId(TARGET_SELF, 5030) then
            f2_local0[15] = 100
        else
            f2_local0[16] = 100
        end
    elseif Common_ActivateAct(f2_arg1, f2_arg2) then
    elseif f2_arg1:CheckDoesExistPath(TARGET_ENE_0, AI_DIR_TYPE_F, 0, 0) == false then
        if f2_arg1:HasSpecialEffectId(TARGET_SELF, 3150014) then
            f2_local0[6] = 100
        else
            f2_local0[4] = 100
            f2_local0[27] = 100
        end
    elseif f2_arg1:HasSpecialEffectId(TARGET_SELF, 3150014) then
        if f2_local4 == 1 and f2_arg1:GetTeamOrder(ORDER_TYPE_Role) == ROLE_TYPE_Kankyaku then
            if f2_local3 >= 10 then
                f2_local0[6] = 100
            elseif f2_local3 >= 6 then
                f2_local0[6] = 100
            elseif f2_local3 > 2 then
                f2_local0[6] = 100
            else
                f2_local0[1] = 100
            end
        elseif f2_local4 == 1 and f2_arg1:GetTeamOrder(ORDER_TYPE_Role) == ROLE_TYPE_Torimaki then
            if f2_local3 >= 10 then
                f2_local0[6] = 100
            elseif f2_local3 >= 6 then
                f2_local0[6] = 100
            elseif f2_local3 > 2 then
                f2_local0[6] = 100
            else
                f2_local0[1] = 100
            end
        elseif f2_arg1:IsInsideTarget(TARGET_ENE_0, AI_DIR_TYPE_B, 180) then
            f2_local0[21] = 100
            f2_local0[22] = 1
        elseif f2_local3 >= 10 then
            f2_local0[6] = 100
        elseif f2_local3 >= 6 then
            f2_local0[6] = 100
        elseif f2_local3 > 2 then
            f2_local0[6] = 100
        else
            f2_local0[1] = 100
            f2_local0[3] = 200
            f2_local0[6] = 100
        end
    elseif f2_arg1:HasSpecialEffectId(TARGET_SELF, 3150015) then
        if f2_arg1:IsInsideTarget(TARGET_ENE_0, AI_DIR_TYPE_B, 180) then
            f2_local0[21] = 100
        elseif f2_local3 >= 7 then
            f2_local0[40] = 100
        else
            f2_local0[6] = 100
            f2_local0[28] = 100
        end
    elseif f2_arg1:HasSpecialEffectId(TARGET_SELF, 3150011) then
        if f2_arg1:HasSpecialEffectId(TARGET_SELF, 3150060) then
            if f2_local4 == 1 and f2_arg1:GetTeamOrder(ORDER_TYPE_Role) == ROLE_TYPE_Kankyaku then
                if f2_local3 >= 10 then
                    f2_local0[11] = 100
                elseif f2_local3 >= 6 then
                    f2_local0[11] = 100
                elseif f2_local3 > 2 then
                    f2_local0[11] = 100
                else
                    f2_local0[1] = 100
                end
            elseif f2_local4 == 1 and f2_arg1:GetTeamOrder(ORDER_TYPE_Role) == ROLE_TYPE_Torimaki then
                if f2_local3 >= 10 then
                    f2_local0[11] = 100
                elseif f2_local3 >= 6 then
                    f2_local0[11] = 100
                elseif f2_local3 > 2 then
                    f2_local0[11] = 100
                else
                    f2_local0[1] = 100
                end
            elseif f2_arg1:IsInsideTarget(TARGET_ENE_0, AI_DIR_TYPE_B, 180) then
                f2_local0[21] = 100
                f2_local0[22] = 1
            elseif f2_local3 >= 10 then
                f2_local0[11] = 100
            elseif f2_local3 >= 6 then
                f2_local0[11] = 100
            elseif f2_local3 > 2 then
                f2_local0[11] = 100
            else
                f2_local0[1] = 100
            end
        elseif f2_local4 == 1 and f2_arg1:GetTeamOrder(ORDER_TYPE_Role) == ROLE_TYPE_Kankyaku then
            if f2_local3 >= 10 then
                f2_local0[2] = 100
            elseif f2_local3 >= 6 then
                f2_local0[2] = 100
            elseif f2_local3 > 2 then
                f2_local0[2] = 100
            else
                f2_local0[2] = 100
            end
        elseif f2_local4 == 1 and f2_arg1:GetTeamOrder(ORDER_TYPE_Role) == ROLE_TYPE_Torimaki then
            if f2_local3 >= 10 then
                f2_local0[2] = 100
            elseif f2_local3 >= 6 then
                f2_local0[2] = 100
            elseif f2_local3 > 2 then
                f2_local0[2] = 100
            else
                f2_local0[1] = 150
                f2_local0[2] = 100
            end
        elseif f2_arg1:IsInsideTarget(TARGET_ENE_0, AI_DIR_TYPE_B, 180) then
            f2_local0[21] = 100
            f2_local0[22] = 1
        elseif f2_local3 >= 10 then
            f2_local0[2] = 100
        elseif f2_local3 >= 5 then
            f2_local0[2] = 100
        elseif f2_local3 > 2 then
            f2_local0[2] = 100
        else
            f2_local0[1] = 100
            f2_local0[2] = 100
        end
    elseif f2_arg1:HasSpecialEffectId(TARGET_SELF, 3150060) then
        if f2_local4 == 1 and f2_arg1:GetTeamOrder(ORDER_TYPE_Role) == ROLE_TYPE_Kankyaku then
            if KankyakuAct(f2_arg1, f2_arg2, -1, 50) then
                f2_local0[5] = 100
                f2_local0[22] = 100
            end
        elseif f2_local4 == 1 and f2_arg1:GetTeamOrder(ORDER_TYPE_Role) == ROLE_TYPE_Torimaki then
            if TorimakiAct(f2_arg1, f2_arg2) then
                f2_local0[5] = 100
                f2_local0[10] = 50
                f2_local0[11] = 100
                f2_local0[12] = 50
                f2_local0[22] = 50
            end
        elseif f2_arg1:IsInsideTarget(TARGET_ENE_0, AI_DIR_TYPE_B, 180) then
            f2_local0[21] = 100
            f2_local0[22] = 1
        elseif f2_local3 >= 10 then
            f2_local0[10] = 0
            f2_local0[11] = 700
            f2_local0[12] = 200
        elseif f2_local3 >= 5 then
            f2_local0[10] = 100
            f2_local0[11] = 500
            f2_local0[12] = 300
        elseif f2_local3 > 3 then
            f2_local0[10] = 700
            f2_local0[11] = 0
            f2_local0[12] = 300
        else
            f2_local0[3] = 200
            f2_local0[10] = 600
            f2_local0[11] = 0
            f2_local0[24] = 200
        end
    elseif f2_local4 == 1 and f2_arg1:GetTeamOrder(ORDER_TYPE_Role) == ROLE_TYPE_Kankyaku then
        if KankyakuAct(f2_arg1, f2_arg2, -1, 50) then
            f2_local0[2] = 200
            f2_local0[5] = 100
            f2_local0[22] = 100
        end
    elseif f2_local4 == 1 and f2_arg1:GetTeamOrder(ORDER_TYPE_Role) == ROLE_TYPE_Torimaki then
        if TorimakiAct(f2_arg1, f2_arg2, -1, 50) then
            f2_local0[1] = 50
            f2_local0[2] = 300
            f2_local0[3] = 50
            f2_local0[5] = 200
            f2_local0[22] = 50
        end
    elseif f2_arg1:IsInsideTarget(TARGET_ENE_0, AI_DIR_TYPE_B, 180) then
        f2_local0[21] = 100
        f2_local0[22] = 1
    elseif f2_local3 >= 10 then
        f2_local0[1] = 100
        f2_local0[2] = 700
        f2_local0[3] = 200
    elseif f2_local3 >= 5 then
        f2_local0[1] = 100
        f2_local0[2] = 600
        f2_local0[3] = 300
    elseif f2_local3 > 3 then
        f2_local0[1] = 300
        f2_local0[2] = 300
        f2_local0[3] = 200
        f2_local0[24] = 200
    else
        f2_local0[1] = 500
        f2_local0[2] = 100
        f2_local0[3] = 200
        f2_local0[24] = 200
    end
    if f2_arg1:IsInsideTargetRegion(TARGET_ENE_0, 1502295) and not f2_arg1:IsInsideTargetRegion(TARGET_SELF, 1502295) then
        f2_local0[36] = 300
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
    f2_local0[1] = SetCoolTime(f2_arg1, f2_arg2, 3000, 5, f2_local0[1], 1)
    f2_local0[3] = SetCoolTime(f2_arg1, f2_arg2, 3002, 12, f2_local0[3], 1)
    f2_local0[10] = SetCoolTime(f2_arg1, f2_arg2, 3010, 5, f2_local0[10], 1)
    f2_local0[36] = SetCoolTime(f2_arg1, f2_arg2, 20000, 10, f2_local0[36], 0)
    f2_local1[1] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act01)
    f2_local1[2] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act02)
    f2_local1[3] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act03)
    f2_local1[4] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act04)
    f2_local1[5] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act05)
    f2_local1[6] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act06)
    f2_local1[10] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act10)
    f2_local1[11] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act11)
    f2_local1[12] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act12)
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
    f2_local1[30] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act30)
    f2_local1[35] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act35)
    f2_local1[36] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act36)
    f2_local1[40] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act40)
    local f2_local5 = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.ActAfter_AdjustSpace)
    Common_Battle_Activate(f2_arg1, f2_arg2, f2_local0, f2_local1, f2_local5, f2_local2)
    
end

Goal.Act01 = function (f3_arg0, f3_arg1, f3_arg2)
    local f3_local0 = 3.2 - f3_arg0:GetMapHitRadius(TARGET_SELF) + (f3_arg0:GetRandam_Float(0, 2.5) - 0.8)
    local f3_local1 = f3_local0 - 1
    local f3_local2 = f3_local0 + 1
    local f3_local3 = 100
    local f3_local4 = 0
    local f3_local5 = 1.5
    local f3_local6 = 2
    Approach_Act_Flex(f3_arg0, f3_arg1, f3_local0, f3_local1, f3_local2, f3_local3, f3_local4, f3_local5, f3_local6)
    local f3_local7 = 0
    local f3_local8 = 0
    f3_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 10, 3000, TARGET_ENE_0, 9999, f3_local7, f3_local8, 0, 0)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act02 = function (f4_arg0, f4_arg1, f4_arg2)
    local f4_local0 = 0
    local f4_local1 = 0
    f4_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 10, 3001, TARGET_ENE_0, 9999, f4_local0, f4_local1, 0, 0)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act03 = function (f5_arg0, f5_arg1, f5_arg2)
    local f5_local0 = 6 - f5_arg0:GetMapHitRadius(TARGET_SELF) + (f5_arg0:GetRandam_Float(0, 2.5) - 0.8)
    local f5_local1 = f5_local0
    local f5_local2 = f5_local0 + 15
    local f5_local3 = 0
    local f5_local4 = 0
    local f5_local5 = 1.5
    local f5_local6 = 2
    Approach_Act_Flex(f5_arg0, f5_arg1, f5_local0, f5_local1, f5_local2, f5_local3, f5_local4, f5_local5, f5_local6)
    local f5_local7 = 0
    local f5_local8 = 0
    f5_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 10, 3002, TARGET_ENE_0, 9999, f5_local7, f5_local8, 0, 0)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act04 = function (f6_arg0, f6_arg1, f6_arg2)
    local f6_local0 = 0
    local f6_local1 = 0
    f6_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 10, 3003, TARGET_ENE_0, 9999, f6_local0, f6_local1, 0, 0)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act05 = function (f7_arg0, f7_arg1, f7_arg2)
    local f7_local0 = 0
    local f7_local1 = 0
    f7_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 10, 3025, TARGET_ENE_0, 9999, f7_local0, f7_local1, 0, 0)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act06 = function (f8_arg0, f8_arg1, f8_arg2)
    local f8_local0 = 0
    local f8_local1 = 0
    f8_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 10, 3004, TARGET_ENE_0, 9999, f8_local0, f8_local1, 0, 0)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act10 = function (f9_arg0, f9_arg1, f9_arg2)
    local f9_local0 = 2.5 - f9_arg0:GetMapHitRadius(TARGET_SELF) + (f9_arg0:GetRandam_Float(0, 2.5) - 0.8)
    local f9_local1 = f9_local0
    local f9_local2 = f9_local0 + 1
    local f9_local3 = 100
    local f9_local4 = 0
    local f9_local5 = 1.5
    local f9_local6 = 2
    Approach_Act_Flex(f9_arg0, f9_arg1, f9_local0, f9_local1, f9_local2, f9_local3, f9_local4, f9_local5, f9_local6)
    local f9_local7 = 2.2 - f9_arg0:GetMapHitRadius(TARGET_SELF) + 0.5
    local f9_local8 = 0
    local f9_local9 = 0
    local f9_local10 = f9_arg0:GetRandam_Int(1, 100)
    f9_arg1:AddSubGoal(GOAL_COMMON_ComboAttackTunableSpin, 10, 3010, TARGET_ENE_0, f9_local7, f9_local8, f9_local9, 0, 0)
    f9_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3011, TARGET_ENE_0, 9999, 0, 0)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act11 = function (f10_arg0, f10_arg1, f10_arg2)
    local f10_local0 = 12 - f10_arg0:GetMapHitRadius(TARGET_SELF) + (f10_arg0:GetRandam_Float(0, 2.5) - 0.8)
    local f10_local1 = f10_local0
    local f10_local2 = f10_local0 + 1
    local f10_local3 = 100
    local f10_local4 = 0
    local f10_local5 = 1.5
    local f10_local6 = 2
    if not f10_arg0:HasSpecialEffectId(TARGET_SELF, 3150011) then
        Approach_Act_Flex(f10_arg0, f10_arg1, f10_local0, f10_local1, f10_local2, f10_local3, f10_local4, f10_local5, f10_local6)
    end
    local f10_local7 = 0
    local f10_local8 = 0
    f10_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 10, 3012, TARGET_ENE_0, 9999, f10_local7, f10_local8, 0, 0)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act12 = function (f11_arg0, f11_arg1, f11_arg2)
    local f11_local0 = 6.1 - f11_arg0:GetMapHitRadius(TARGET_SELF) + (f11_arg0:GetRandam_Float(0, 2.5) - 0.8)
    local f11_local1 = f11_local0
    local f11_local2 = f11_local0 + 1
    local f11_local3 = 100
    local f11_local4 = 0
    local f11_local5 = 1.5
    local f11_local6 = 2
    Approach_Act_Flex(f11_arg0, f11_arg1, f11_local0, f11_local1, f11_local2, f11_local3, f11_local4, f11_local5, f11_local6)
    local f11_local7 = 0
    local f11_local8 = 0
    local f11_local9 = f11_arg0:GetRandam_Int(1, 100)
    f11_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 10, 3013, TARGET_ENE_0, DistToAtt1, f11_local7, f11_local8, 0, 0)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act15 = function (f12_arg0, f12_arg1, f12_arg2)
    local f12_local0 = 0
    local f12_local1 = 0
    f12_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 10, 3015, TARGET_ENE_0, 9999, f12_local0, f12_local1, 0, 0)
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
    
end

Goal.Act16 = function (f13_arg0, f13_arg1, f13_arg2)
    local f13_local0 = -1
    local f13_local1 = 0
    local f13_local2 = 0
    local f13_local3 = f13_arg0:GetDist(TARGET_ENE_0)
    local f13_local4 = 0.2
    if f13_local4 <= f13_local3 then
        f13_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 2, 20011, TARGET_ENE_0, 9999, f13_local1, f13_local2, 0, 0)
    else
        f13_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 2, 20010, TARGET_ENE_0, 9999, f13_local1, f13_local2, 0, 0)
    end
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act17 = function (f14_arg0, f14_arg1, f14_arg2)
    local f14_local0 = 0
    local f14_local1 = 0
    f14_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 10, 20010, TARGET_ENE_0, 9999, f14_local0, f14_local1, 0, 0)
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
    
end

Goal.Act21 = function (f15_arg0, f15_arg1, f15_arg2)
    local f15_local0 = 3
    local f15_local1 = 45
    f15_arg1:AddSubGoal(GOAL_COMMON_Turn, f15_local0, TARGET_ENE_0, f15_local1, -1, GOAL_RESULT_Success, true)
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
    
end

Goal.Act22 = function (f16_arg0, f16_arg1, f16_arg2)
    local f16_local0 = 3
    local f16_local1 = 0
    local f16_local2 = f16_arg0:GetDist(TARGET_FRI_0)
    local f16_local3 = f16_arg0:GetRandam_Int(1, 100)
    if SpaceCheck(f16_arg0, f16_arg1, -45, 2) == true and SpaceCheck(f16_arg0, f16_arg1, 45, 2) == true and f16_local2 >= 2.5 then
        if f16_local3 <= 50 then
            f16_arg1:AddSubGoal(GOAL_COMMON_SpinStep, f16_local0, 5212, TARGET_ENE_0, f16_local1, AI_DIR_TYPE_L, 0)
        else
            f16_arg1:AddSubGoal(GOAL_COMMON_SpinStep, f16_local0, 5213, TARGET_ENE_0, f16_local1, AI_DIR_TYPE_R, 0)
        end
    elseif f16_arg0:IsInsideTarget(TARGET_FRI_0, AI_DIR_TYPE_R, 100) and SpaceCheck(f16_arg0, f16_arg1, -45, 2) == true and f16_local2 <= 2.5 then
        f16_arg1:AddSubGoal(GOAL_COMMON_SpinStep, f16_local0, 5212, TARGET_ENE_0, f16_local1, AI_DIR_TYPE_L, 0)
    elseif f16_arg0:IsInsideTarget(TARGET_FRI_0, AI_DIR_TYPE_L, 100) and SpaceCheck(f16_arg0, f16_arg1, 45, 2) == true and f16_local2 <= 2.5 then
        f16_arg1:AddSubGoal(GOAL_COMMON_SpinStep, f16_local0, 5213, TARGET_ENE_0, f16_local1, AI_DIR_TYPE_R, 0)
    elseif SpaceCheck(f16_arg0, f16_arg1, -45, 2) == true and SpaceCheck(f16_arg0, f16_arg1, 45, 2) == true then
        if f16_local3 <= 50 then
            f16_arg1:AddSubGoal(GOAL_COMMON_SpinStep, f16_local0, 5212, TARGET_ENE_0, f16_local1, AI_DIR_TYPE_L, 0)
        else
            f16_arg1:AddSubGoal(GOAL_COMMON_SpinStep, f16_local0, 5213, TARGET_ENE_0, f16_local1, AI_DIR_TYPE_R, 0)
        end
    elseif SpaceCheck(f16_arg0, f16_arg1, -45, 2) == true then
        f16_arg1:AddSubGoal(GOAL_COMMON_SpinStep, f16_local0, 5212, TARGET_ENE_0, f16_local1, AI_DIR_TYPE_L, 0)
    elseif SpaceCheck(f16_arg0, f16_arg1, 45, 2) == true then
        f16_arg1:AddSubGoal(GOAL_COMMON_SpinStep, f16_local0, 5213, TARGET_ENE_0, f16_local1, AI_DIR_TYPE_R, 0)
    else
    end
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
    
end

Goal.Act23 = function (f17_arg0, f17_arg1, f17_arg2)
    local f17_local0 = f17_arg0:GetDist(TARGET_ENE_0)
    local f17_local1 = f17_arg0:GetDist(TARGET_FRI_0)
    local f17_local2 = f17_arg0:GetSp(TARGET_SELF)
    local f17_local3 = 20
    local f17_local4 = f17_arg0:GetRandam_Int(1, 100)
    local f17_local5 = -1
    local f17_local6 = f17_arg0:GetRandam_Int(0, 1)
    if f17_arg0:IsInsideTarget(TARGET_FRI_0, AI_DIR_TYPE_R, 100) and SpaceCheck(f17_arg0, f17_arg1, -90, 1) == true and f17_local1 <= 2.5 then
        f17_local6 = 0
    elseif f17_arg0:IsInsideTarget(TARGET_FRI_0, AI_DIR_TYPE_L, 100) and SpaceCheck(f17_arg0, f17_arg1, 90, 1) == true and f17_local1 <= 2.5 then
        f17_local6 = 1
    end
    local f17_local7 = 3
    local f17_local8 = f17_arg0:GetRandam_Int(30, 45)
    f17_arg0:SetNumber(10, f17_local6)
    f17_arg1:AddSubGoal(GOAL_COMMON_SidewayMove, f17_local7, TARGET_ENE_0, f17_local6, f17_local8, true, true, f17_local5):TimingSetTimer(2, 4, UPDATE_SUCCESS)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act24 = function (f18_arg0, f18_arg1, f18_arg2)
    local f18_local0 = f18_arg0:GetDist(TARGET_ENE_0)
    local f18_local1 = 3
    local f18_local2 = 0
    local f18_local3 = 5211
    if SpaceCheck(f18_arg0, f18_arg1, 180, 2) ~= true or SpaceCheck(f18_arg0, f18_arg1, 180, 4) ~= true or f18_local0 > 4 then
    else
        f18_local3 = 5211
        if false then
        else
        end
    end
    f18_arg1:AddSubGoal(GOAL_COMMON_SpinStep, f18_local1, f18_local3, TARGET_ENE_0, f18_local2, AI_DIR_TYPE_B, 0)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act25 = function (f19_arg0, f19_arg1, f19_arg2)
    local f19_local0 = f19_arg0:GetRandam_Float(2, 4)
    local f19_local1 = f19_arg0:GetRandam_Float(1, 3)
    local f19_local2 = f19_arg0:GetDist(TARGET_ENE_0)
    local f19_local3 = -1
    if SpaceCheck(f19_arg0, f19_arg1, 180, 1) == true then
        f19_arg1:AddSubGoal(GOAL_COMMON_LeaveTarget, f19_local0, TARGET_ENE_0, f19_local1, TARGET_ENE_0, true, f19_local3)
    else
    end
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
    
end

Goal.Act26 = function (f20_arg0, f20_arg1, f20_arg2)
    f20_arg1:AddSubGoal(GOAL_COMMON_Wait, 0.5, TARGET_SELF, 0, 0, 0)
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
    
end

Goal.Act27 = function (f21_arg0, f21_arg1, f21_arg2)
    local f21_local0 = f21_arg0:GetDist(TARGET_ENE_0)
    local f21_local1 = f21_arg0:GetDistYSigned(TARGET_ENE_0)
    local f21_local2 = f21_local1 / math.tan(math.deg(30))
    local f21_local3 = f21_arg0:GetRandam_Int(0, 1)
    if f21_local1 >= 3 then
        if f21_local2 + 1 <= f21_local0 then
            if SpaceCheck(f21_arg0, f21_arg1, 0, 4) == true then
                f21_arg1:AddSubGoal(GOAL_COMMON_ApproachTarget, 0.1, TARGET_ENE_0, f21_local2, TARGET_SELF, false, -1)
            elseif SpaceCheck(f21_arg0, f21_arg1, 0, 3) == true then
                f21_arg1:AddSubGoal(GOAL_COMMON_ApproachTarget, 0.5, TARGET_ENE_0, f21_local2, TARGET_SELF, true, -1)
            end
        elseif f21_local0 <= f21_local2 - 1 then
            f21_arg1:AddSubGoal(GOAL_COMMON_LeaveTarget, 10, TARGET_ENE_0, f21_local2, TARGET_ENE_0, true, -1)
        end
    elseif SpaceCheck(f21_arg0, f21_arg1, 0, 4) == true then
        f21_arg1:AddSubGoal(GOAL_COMMON_ApproachTarget, 0.1, TARGET_ENE_0, 0, TARGET_SELF, false, -1)
    elseif SpaceCheck(f21_arg0, f21_arg1, 0, 3) == true then
        f21_arg1:AddSubGoal(GOAL_COMMON_ApproachTarget, 0.5, TARGET_ENE_0, 0, TARGET_SELF, true, -1)
    elseif SpaceCheck(f21_arg0, f21_arg1, 0, 1) == false then
        f21_arg1:AddSubGoal(GOAL_COMMON_LeaveTarget, 0.5, TARGET_ENE_0, 999, TARGET_ENE_0, true, -1)
    end
    f21_arg0:SetNumber(10, f21_local3)
    f21_arg1:AddSubGoal(GOAL_COMMON_SidewayMove, 3, TARGET_ENE_0, f21_local3, f21_arg0:GetRandam_Int(30, 45), true, true, -1)
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
    
end

Goal.Act28 = function (f22_arg0, f22_arg1, f22_arg2)
    local f22_local0 = f22_arg0:GetDist(TARGET_ENE_0)
    local f22_local1 = f22_arg0:GetRandam_Float(1, 3.5)
    local f22_local2 = 1.5
    local f22_local3 = f22_arg0:GetRandam_Int(30, 45)
    local f22_local4 = -1
    local f22_local5 = f22_arg0:GetRandam_Int(0, 1)
    if f22_local0 <= 8 then
        f22_arg1:AddSubGoal(GOAL_COMMON_SidewayMove, f22_local1, TARGET_ENE_0, f22_local5, f22_local3, true, true, f22_local4)
    elseif f22_local0 <= 10 and not f22_arg0:HasSpecialEffectId(TARGET_SELF, 3150011) then
        f22_arg1:AddSubGoal(GOAL_COMMON_ApproachTarget, f22_local2, TARGET_ENE_0, 7.9, TARGET_SELF, true, -1)
    else
        f22_arg1:AddSubGoal(GOAL_COMMON_ApproachTarget, f22_local2, TARGET_ENE_0, 9.9, TARGET_SELF, false, -1)
    end
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
    
end

Goal.Act29 = function (f23_arg0, f23_arg1, f23_arg2)
    local f23_local0 = f23_arg0:GetDist(TARGET_ENE_0)
    local f23_local1 = 7
    local f23_local2 = 0
    local f23_local3 = f23_arg0:GetRandam_Float(1, 3.5)
    f23_arg1:AddSubGoal(GOAL_COMMON_LeaveTarget, f23_local3, TARGET_ENE_0, f23_local1, TARGET_ENE_0, true, -1)
    
end

Goal.Act30 = function (f24_arg0, f24_arg1, f24_arg2)
    local f24_local0 = 3.5
    local f24_local1 = f24_arg0:GetRandam_Int(30, 45)
    local f24_local2 = 0
    if SpaceCheck(f24_arg0, f24_arg1, -90, 1) == true then
        if SpaceCheck(f24_arg0, f24_arg1, 90, 1) == true then
            if f24_arg0:IsInsideTarget(TARGET_ENE_0, AI_DIR_TYPE_R, 180) then
                f24_local2 = 0
            else
                f24_local2 = 1
            end
        else
            f24_local2 = 0
        end
    elseif SpaceCheck(f24_arg0, f24_arg1, 90, 1) == true then
        f24_local2 = 1
    else
    end
    f24_arg1:AddSubGoal(GOAL_COMMON_SidewayMove, f24_local0, TARGET_ENE_0, f24_local2, f24_local1, true, true, -1)
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
    
end

Goal.Act35 = function (f25_arg0, f25_arg1, f25_arg2)
    local f25_local0 = f25_arg0:GetDist(TARGET_ENE_0)
    local f25_local1 = f25_arg0:GetRandam_Int(1, 100)
    local f25_local2 = f25_arg0:GetRandam_Int(0, 1)
    local f25_local3 = f25_arg0:GetRandam_Float(2, 3.5)
    local f25_local4 = 3
    local f25_local5 = 0
    local f25_local6 = f25_arg0:GetDist(TARGET_FRI_0)
    local f25_local7 = f25_arg0:GetRandam_Int(1, 100)
    local f25_local8 = f25_arg0:GetRandam_Float(6.5, 7.5)
    local f25_local9 = f25_arg0:GetRandam_Float(5.5, 6.5)
    local f25_local10 = 999
    local f25_local11 = 100
    if f25_local0 >= 10 then
        Approach_Act(f25_arg0, f25_arg1, f25_local8, f25_local10, 0, 3)
    elseif f25_local0 >= 5 then
    elseif f25_local0 >= 3.5 then
        f25_arg1:AddSubGoal(GOAL_COMMON_LeaveTarget, 3, TARGET_ENE_0, f25_local8, TARGET_ENE_0, false, 9910)
    elseif f25_local7 <= 60 then
        f25_arg1:AddSubGoal(GOAL_COMMON_SpinStep, 5, 5201, TARGET_ENE_0, 0, AI_DIR_TYPE_B, 2)
    end
    f25_arg1:AddSubGoal(GOAL_COMMON_SidewayMove, f25_local3, TARGET_ENE_0, f25_local2, f25_arg0:GetRandam_Int(30, 45), true, true, 9910):TimingSetTimer(2, 4, UPDATE_SUCCESS)
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
    
end

Goal.Act36 = function (f26_arg0, f26_arg1, f26_arg2)
    local f26_local0 = -0.5
    local f26_local1 = f26_arg0:GetRandam_Int(1, 100)
    if f26_local1 <= 34 then
        f26_arg0:SetEventMoveTarget(1502296)
    elseif f26_local1 <= 67 then
        f26_arg0:SetEventMoveTarget(1502297)
    else
        f26_arg0:SetEventMoveTarget(1502298)
    end
    f26_arg1:AddSubGoal(GOAL_COMMON_ApproachTarget, 3, POINT_EVENT, f26_local0, POINT_EVENT, false, -1)
    
end

Goal.Act40 = function (f27_arg0, f27_arg1, f27_arg2)
    local f27_local0 = 3
    f27_arg1:AddSubGoal(GOAL_COMMON_ApproachTarget, f27_local0, TARGET_ENE_0, 6.9, TARGET_SELF, true, -1)
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
    
end

Goal.Interrupt = function (f28_arg0, f28_arg1, f28_arg2)
    local f28_local0 = f28_arg1:GetSpecialEffectActivateInterruptType(0)
    if f28_arg1:IsLadderAct(TARGET_SELF) then
        return false
    end
    if not f28_arg1:HasSpecialEffectId(TARGET_SELF, 200004) then
        return false
    end
    if f28_arg1:IsInterupt(INTERUPT_Damaged) then
        return f28_arg0.Damaged(f28_arg1, f28_arg2)
    end
    
end

Goal.Parry = function (f29_arg0, f29_arg1, f29_arg2)
    local f29_local0 = f29_arg0:GetHpRate(TARGET_SELF)
    local f29_local1 = f29_arg0:GetDist(TARGET_ENE_0)
    local f29_local2 = f29_arg0:GetSp(TARGET_SELF)
    local f29_local3 = f29_arg0:GetRandam_Int(1, 100)
    local f29_local4 = 0
    if not f29_arg0:IsInsideTarget(TARGET_ENE_0, AI_DIR_TYPE_F, 90) or not f29_arg0:IsInsideTargetEx(TARGET_ENE_0, TARGET_SELF, AI_DIR_TYPE_F, 90, 3) or f29_arg0:HasSpecialEffectId(TARGET_ENE_0, 109012) then
    elseif f29_arg0:IsTargetGuard(TARGET_SELF) then
        if f29_arg0:HasSpecialEffectId(TARGET_ENE_0, 109970) then
        else
            f29_arg1:ClearSubGoal()
            f29_arg1:AddSubGoal(GOAL_COMMON_EndureAttack, 0.1, 3100, TARGET_ENE_0, 9999, 0)
            return true
        end
    elseif f29_arg0:HasSpecialEffectId(TARGET_ENE_0, 109970) then
        f29_arg1:ClearSubGoal()
        f29_arg1:AddSubGoal(GOAL_COMMON_EndureAttack, 0.1, 3101, TARGET_ENE_0, 9999, 0)
        return true
    else
        f29_arg1:ClearSubGoal()
        f29_arg1:AddSubGoal(GOAL_COMMON_EndureAttack, 0.1, 3100, TARGET_ENE_0, 9999, 0)
        return true
    end
    return false
    
end

Goal.Damaged = function (f30_arg0, f30_arg1, f30_arg2)
    local f30_local0 = f30_arg0:GetHpRate(TARGET_SELF)
    local f30_local1 = f30_arg0:GetDist(TARGET_ENE_0)
    local f30_local2 = f30_arg0:GetSp(TARGET_SELF)
    local f30_local3 = f30_arg0:GetRandam_Int(1, 100)
    local f30_local4 = 0
    if f30_local3 <= 33 then
        f30_arg1:ClearSubGoal()
        f30_arg1:AddSubGoal(GOAL_COMMON_SpinStep, StepLife, 5211, TARGET_ENE_0, TurnTime, AI_DIR_TYPE_B, 0):TimingSetTimer(3, 6, UPDATE_SUCCESS)
        return true
    elseif f30_local3 <= 67 then
    end
    return false
    
end

Goal.ActAfter_AdjustSpace = function (f31_arg0, f31_arg1, f31_arg2)
    if not f31_arg0:HasSpecialEffectId(TARGET_SELF, 3150100) then
        f31_arg1:AddSubGoal(GOAL_MurabitoZombie_sude_150000_AfterAttackAct, 10)
    end
    
end

Goal.Update = function (f32_arg0, f32_arg1, f32_arg2)
    return Update_Default_NoSubGoal(f32_arg0, f32_arg1, f32_arg2)
    
end

Goal.Terminate = function (f33_arg0, f33_arg1, f33_arg2)
    
end

RegisterTableGoal(GOAL_MurabitoZombie_sude_150000_AfterAttackAct, "GOAL_MurabitoZombie_sude_150000_AfterAttackAct")
REGISTER_GOAL_NO_SUB_GOAL(GOAL_MurabitoZombie_sude_150000_AfterAttackAct, true)

Goal.Activate = function (f34_arg0, f34_arg1, f34_arg2)
    local f34_local0 = f34_arg1:GetDist(TARGET_ENE_0)
    local f34_local1 = f34_arg1:GetToTargetAngle(TARGET_ENE_0)
    local f34_local2 = f34_arg1:GetHpRate(TARGET_SELF)
    local f34_local3 = {}
    if f34_arg1:IsInsideTarget(TARGET_ENE_0, AI_DIR_TYPE_B, 160) then
        f34_local3[1] = 100
        f34_local3[2] = 0
        f34_local3[3] = 0
    elseif f34_local0 >= 7 then
        f34_local3[1] = 100
        f34_local3[2] = 0
        f34_local3[3] = 0
    elseif f34_local0 >= 3 then
        f34_local3[1] = 30
        f34_local3[2] = 45
        f34_local3[3] = 25
    else
        f34_local3[1] = 30
        f34_local3[2] = 20
        f34_local3[3] = 50
    end
    local f34_local4 = SelectOddsIndex(f34_arg1, f34_local3)
    if f34_local4 == 1 then
    elseif f34_local4 == 2 then
        f34_arg2:AddSubGoal(GOAL_COMMON_SidewayMove, f34_arg1:GetRandam_Float(0, 1), TARGET_ENE_0, f34_arg1:GetRandam_Int(1.5, 3), f34_arg1:GetRandam_Int(30, 45), true, true, -1)
    elseif f34_local4 == 3 then
        f34_arg2:AddSubGoal(GOAL_COMMON_LeaveTarget, f34_arg1:GetRandam_Int(1.5, 3), TARGET_ENE_0, 7, TARGET_ENE_0, true, -1)
    end
    
end

Goal.Update = function (f35_arg0, f35_arg1, f35_arg2)
    return Update_Default_NoSubGoal(f35_arg0, f35_arg1, f35_arg2)
    
end


