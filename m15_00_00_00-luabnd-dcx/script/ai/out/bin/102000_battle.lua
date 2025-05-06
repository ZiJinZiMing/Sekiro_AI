RegisterTableGoal(GOAL_SamuraiTaisho_102000_Battle, "GOAL_SamuraiTaisho_102000_Battle")
REGISTER_GOAL_NO_UPDATE(GOAL_SamuraiTaisho_102000_Battle, true)

Goal.Initialize = function (f1_arg0, f1_arg1, f1_arg2, f1_arg3)
    
end

Goal.Activate = function (f2_arg0, f2_arg1, f2_arg2)
    f2_arg1:DeleteObserve(0)
    f2_arg1:DeleteObserve(1)
    f2_arg1:DeleteObserve(2)
    f2_arg1:DeleteObserve(3)
    f2_arg1:AddObserveSpecialEffectAttribute(TARGET_ENE_0, 90)
    f2_arg1:AddObserveSpecialEffectAttribute(TARGET_ENE_0, 109220)
    f2_arg1:AddObserveSpecialEffectAttribute(TARGET_ENE_0, 109221)
    Set_ConsecutiveGuardCount_Interrupt(f2_arg1)
    if f2_arg0.Kengeki_Activate(f2_arg0, f2_arg1, f2_arg2) then
        return
    end
    local f2_local0 = {}
    local f2_local1 = {}
    local f2_local2 = {}
    Common_Clear_Param(f2_local0, f2_local1, f2_local2)
    local f2_local3 = f2_arg1:GetNinsatsuNum()
    local f2_local4 = f2_arg1:GetSp(TARGET_SELF)
    local f2_local5 = f2_arg1:GetSpRate(TARGET_SELF)
    local f2_local6 = f2_arg1:GetDist(TARGET_ENE_0)
    local f2_local7 = f2_arg1:GetRandam_Int(1, 100)
    local f2_local8 = f2_arg1:GetExcelParam(AI_EXCEL_THINK_PARAM_TYPE__thinkAttr_doAdmirer)
    local f2_local9 = Check_ReachAttack(f2_arg1, 4)
    local f2_local10 = f2_arg1:GetEventRequest()
    local f2_local11 = f2_arg1:GetNpcThinkParamID()
    local f2_local12 = 0
    local f2_local13 = 1
    local f2_local14 = 0
    if f2_arg1:IsTargetGuard(TARGET_ENE_0) then
        f2_local12 = 3
    end
    if f2_arg1:HasSpecialEffectId(TARGET_ENE_0, 109012) then
        f2_local13 = 0
    else
        f2_local13 = 1
    end
    local f2_local15 = 0
    if f2_arg1:HasSpecialEffectId(TARGET_SELF, 200051) then
        f2_local15 = 1
    end
    if f2_local3 <= 1 or f2_arg1:HasSpecialEffectId(TARGET_SELF, 200051) then
        f2_local14 = 1
    end
    if Common_ActivateAct(f2_arg1, f2_arg2) then
    elseif f2_local9 ~= POSSIBLE_ATTACK then
        if f2_local8 == 1 and f2_arg1:GetTeamOrder(ORDER_TYPE_Role) == ROLE_TYPE_Kankyaku then
            f2_local0[27] = 100
        elseif f2_local8 == 1 and f2_arg1:GetTeamOrder(ORDER_TYPE_Role) == ROLE_TYPE_Torimaki then
            f2_local0[27] = 100
        elseif f2_local9 == UNREACH_ATTACK then
            f2_local0[27] = 100
        elseif f2_local9 == REACH_ATTACK_TARGET_HIGH_POSITION then
            if f2_arg1:IsVisibleCurrTarget() then
                f2_local0[1] = 100
                f2_local0[4] = 100
                f2_local0[7] = 100
                f2_local0[27] = 100
            else
                f2_local0[27] = 100
            end
        elseif f2_local9 == REACH_ATTACK_TARGET_LOW_POSITION then
            if f2_arg1:IsVisibleCurrTarget() then
                f2_local0[1] = 100
                f2_local0[27] = 100
            else
                f2_local0[27] = 100
            end
        else
            f2_local0[27] = 100
        end
    elseif f2_local8 == 1 and f2_arg1:GetTeamOrder(ORDER_TYPE_Role) == ROLE_TYPE_Kankyaku then
        KankyakuAct(f2_arg1, f2_arg2)
    elseif f2_local8 == 1 and f2_arg1:GetTeamOrder(ORDER_TYPE_Role) == ROLE_TYPE_Torimaki then
        TorimakiAct(f2_arg1, f2_arg2, -1, 0)
    else
        if f2_arg1:IsInsideTarget(TARGET_ENE_0, AI_DIR_TYPE_B, 90) and f2_local6 < 3 then
            f2_local0[21] = 100
        elseif f2_arg1:GetNumber(3) == 0 and f2_local11 == 10200020 then
            f2_local0[3] = 100
        elseif not f2_arg1:IsExistMeshOnLine(TARGET_ENE_0, AI_DIR_TYPE_ToB, f2_local6) then
            f2_local0[1] = 100
            f2_local0[6] = 100
        elseif f2_arg1:HasSpecialEffectId(TARGET_ENE_0, COMMON_SP_EFFECT_PC_BREAK) then
            if f2_local6 >= 1 then
                f2_local0[8] = 100
            else
                f2_local0[5] = 100
            end
        elseif f2_arg1:GetNumber(10) == 0 then
            f2_local0[31] = 100
        elseif f2_local5 >= 0.5 then
            if f2_local6 >= 7 then
                f2_local0[1] = 0
                f2_local0[2] = 100
                f2_local0[3] = 100
                f2_local0[4] = 100
                f2_local0[5] = 0
                f2_local0[6] = 0
                f2_local0[7] = 200
                if f2_arg1:IsFinishTimer(0) == true then
                    f2_local0[9] = 800
                end
            elseif f2_local6 >= 5 then
                f2_local0[1] = 0
                f2_local0[2] = 100
                f2_local0[3] = 100
                f2_local0[4] = 100
                f2_local0[5] = 0
                f2_local0[6] = 0
                f2_local0[7] = 150
                if f2_arg1:IsFinishTimer(0) == true then
                    f2_local0[9] = 800
                end
            elseif f2_local6 > 3 then
                f2_local0[1] = 200
                f2_local0[2] = 50
                f2_local0[3] = 100
                f2_local0[4] = 200
                f2_local0[5] = 0
                f2_local0[6] = 100
                f2_local0[7] = 0
                if f2_arg1:IsFinishTimer(3) == true then
                    f2_local0[24] = 50
                end
            elseif f2_local6 > 0.8 then
                f2_local0[1] = 200
                f2_local0[2] = 50
                f2_local0[3] = 20
                f2_local0[4] = 0
                f2_local0[5] = 30
                f2_local0[6] = 20
                f2_local0[7] = 0
                if f2_arg1:IsFinishTimer(3) == true then
                    f2_local0[24] = 50
                end
            else
                f2_local0[1] = 0
                f2_local0[2] = 0
                f2_local0[3] = 0
                f2_local0[4] = 100
                f2_local0[5] = 100
                f2_local0[6] = 200
                f2_local0[7] = 0
                f2_local0[23] = 1
                if f2_arg1:IsFinishTimer(3) == true then
                    f2_local0[24] = 50
                end
                if f2_arg1:IsFinishTimer(1) == true then
                    f2_local0[25] = 100
                end
            end
        elseif f2_local6 >= 5 then
            f2_local0[2] = 100 * f2_local14
            f2_local0[7] = 100
            if f2_local15 == 0 then
                f2_local0[16] = 400
            else
                f2_local0[16] = 100
            end
        else
            f2_local0[1] = 100
            f2_local0[3] = 100
            f2_local0[6] = 100
            if f2_local15 == 0 then
                f2_local0[16] = 200
            else
                f2_local0[16] = 100
            end
        end
        if f2_local11 == 10200020 then
            f2_local0[7] = 0
            f2_local0[9] = 0
        end
        if f2_local14 == 0 then
            f2_local0[2] = 0
            f2_local0[9] = 0
        end
        if f2_local12 > 0 then
            f2_local0[2] = f2_local0[2] * f2_local12
            f2_local0[5] = f2_local0[5] * f2_local12
            f2_local0[6] = f2_local0[6] * f2_local12
        end
        if f2_local13 == 1 then
        else
            f2_local0[4] = 1
            f2_local0[6] = 1
        end
    end
    if f2_arg1:HasSpecialEffectId(TARGET_ENE_0, 109220) or f2_arg1:HasSpecialEffectId(TARGET_ENE_0, 109221) then
        f2_local0[6] = 0
    end
    if f2_arg1:IsFinishTimer(2) == false or f2_arg1:IsFinishTimer(3) == false then
        f2_local0[23] = 1
    end
    if f2_arg1:GetNumber(11) == 1 then
        f2_arg1:SetNumber(11, 0)
        if f2_local5 >= 0.5 then
            f2_local0[23] = 10000
        end
    end
    if SpaceCheck(f2_arg1, f2_arg2, 90, 1) == false and SpaceCheck(f2_arg1, f2_arg2, -90, 1) == false then
        f2_local0[23] = 0
    end
    if SpaceCheck(f2_arg1, f2_arg2, 180, 2) == false then
        f2_local0[24] = 0
    end
    if SpaceCheck(f2_arg1, f2_arg2, 180, 1) == false then
        f2_local0[25] = 0
    end
    f2_local0[1] = SetCoolTime(f2_arg1, f2_arg2, 3000, 5, f2_local0[1], 1)
    f2_local0[2] = SetCoolTime(f2_arg1, f2_arg2, 3003, 15, f2_local0[2], 1)
    f2_local0[3] = SetCoolTime(f2_arg1, f2_arg2, 3004, 5, f2_local0[3], 1)
    f2_local0[4] = SetCoolTime(f2_arg1, f2_arg2, 3006, 5, f2_local0[4], 1)
    f2_local0[5] = SetCoolTime(f2_arg1, f2_arg2, 3007, 5, f2_local0[5], 1)
    f2_local0[6] = SetCoolTime(f2_arg1, f2_arg2, 3008, 8, f2_local0[6], 1)
    f2_local0[7] = SetCoolTime(f2_arg1, f2_arg2, 3010, 5, f2_local0[7], 1)
    f2_local0[16] = SetCoolTime(f2_arg1, f2_arg2, 3020, 10, f2_local0[16], 1)
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
    f2_local1[16] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act16)
    f2_local1[21] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act21)
    f2_local1[22] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act22)
    f2_local1[23] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act23)
    f2_local1[24] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act24)
    f2_local1[25] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act25)
    f2_local1[26] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act26)
    f2_local1[27] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act27)
    f2_local1[28] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act28)
    f2_local1[31] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act31)
    local f2_local16 = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.ActAfter_AdjustSpace)
    Common_Battle_Activate(f2_arg1, f2_arg2, f2_local0, f2_local1, f2_local16, f2_local2)
    
end

Goal.Act01 = function (f3_arg0, f3_arg1, f3_arg2)
    local f3_local0 = f3_arg0:GetDist(TARGET_ENE_0)
    local f3_local1 = 4 - f3_arg0:GetMapHitRadius(TARGET_SELF)
    local f3_local2 = 4 - f3_arg0:GetMapHitRadius(TARGET_SELF) + 2
    local f3_local3 = 4 - f3_arg0:GetMapHitRadius(TARGET_SELF) + 2
    local f3_local4 = 100
    local f3_local5 = 0
    local f3_local6 = 2.5
    local f3_local7 = 5
    if f3_arg0:HasSpecialEffectId(TARGET_ENE_0, 3102000) or f3_local0 <= f3_local1 + 1 then
        Approach_Act_Flex(f3_arg0, f3_arg1, f3_local1, f3_local2, f3_local3, f3_local4, f3_local5, f3_local6, f3_local7)
    else
        Approach_Act_Flex(f3_arg0, f3_arg1, f3_local1 + 1, f3_local2, f3_local3, f3_local4, f3_local5, f3_local6, f3_local7)
        f3_arg1:AddSubGoal(GOAL_COMMON_SpinStep, 3, 5200, TARGET_ENE_0, 0, AI_DIR_TYPE_F, 3)
    end
    local f3_local8 = 3000
    local f3_local9 = 3001
    local f3_local10 = 3002
    local f3_local11 = 3.5 - f3_arg0:GetMapHitRadius(TARGET_SELF)
    local f3_local12 = 5.8 - f3_arg0:GetMapHitRadius(TARGET_SELF)
    local f3_local13 = 0.5
    local f3_local14 = 90
    f3_arg1:AddSubGoal(GOAL_COMMON_ComboAttackTunableSpin, 10, f3_local8, TARGET_ENE_0, f3_local11, f3_local13, f3_local14, 0, 0)
    f3_arg1:AddSubGoal(GOAL_COMMON_ComboRepeat, 10, f3_local9, TARGET_ENE_0, f3_local12, 0)
    f3_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, f3_local10, TARGET_ENE_0, 9999, 0, 0)
    return 0
    
end

Goal.Act02 = function (f4_arg0, f4_arg1, f4_arg2)
    local f4_local0 = f4_arg0:GetDist(TARGET_ENE_0)
    local f4_local1 = 5.9 - f4_arg0:GetMapHitRadius(TARGET_SELF)
    local f4_local2 = 5.9 - f4_arg0:GetMapHitRadius(TARGET_SELF) + 0
    local f4_local3 = 5.9 - f4_arg0:GetMapHitRadius(TARGET_SELF) + 2
    local f4_local4 = 100
    local f4_local5 = 0
    local f4_local6 = 2.5
    local f4_local7 = 10
    if f4_arg0:HasSpecialEffectId(TARGET_ENE_0, 3102000) or f4_local0 <= f4_local1 + 1 then
        Approach_Act_Flex(f4_arg0, f4_arg1, f4_local1, f4_local2, f4_local3, f4_local4, f4_local5, f4_local6, f4_local7)
    else
        Approach_Act_Flex(f4_arg0, f4_arg1, f4_local1 + 1, f4_local2, f4_local3, f4_local4, f4_local5, f4_local6, f4_local7)
        f4_arg1:AddSubGoal(GOAL_COMMON_SpinStep, 3, 5200, TARGET_ENE_0, 0, AI_DIR_TYPE_F, 3)
    end
    local f4_local8 = 3003
    local f4_local9 = 0.5
    local f4_local10 = 90
    f4_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 10, f4_local8, TARGET_ENE_0, 9999, f4_local9, f4_local10, 0, 0)
    return 0
    
end

Goal.Act03 = function (f5_arg0, f5_arg1, f5_arg2)
    local f5_local0 = f5_arg0:GetDist(TARGET_ENE_0)
    local f5_local1 = 4.6 - f5_arg0:GetMapHitRadius(TARGET_SELF)
    local f5_local2 = 4.6 - f5_arg0:GetMapHitRadius(TARGET_SELF) + 2
    local f5_local3 = 4.6 - f5_arg0:GetMapHitRadius(TARGET_SELF) + 2
    local f5_local4 = 100
    local f5_local5 = 0
    local f5_local6 = 2.5
    local f5_local7 = 10
    local f5_local8 = f5_arg0:GetNpcThinkParamID()
    if f5_arg0:HasSpecialEffectId(TARGET_ENE_0, 3102000) or f5_local0 <= f5_local1 + 1 then
        Approach_Act_Flex(f5_arg0, f5_arg1, f5_local1, f5_local2, f5_local3, f5_local4, f5_local5, f5_local6, f5_local7)
    else
        Approach_Act_Flex(f5_arg0, f5_arg1, f5_local1 + 1, f5_local2, f5_local3, f5_local4, f5_local5, f5_local6, f5_local7)
        f5_arg1:AddSubGoal(GOAL_COMMON_SpinStep, 3, 5200, TARGET_ENE_0, 0, AI_DIR_TYPE_F, 3)
    end
    local f5_local9 = 3004
    local f5_local10 = 3005
    local f5_local11 = 3.8 - f5_arg0:GetMapHitRadius(TARGET_SELF)
    local f5_local12 = 0.5
    local f5_local13 = 90
    if not f5_local8 == 10200020 then
        f5_arg1:AddSubGoal(GOAL_COMMON_ComboAttackTunableSpin, 10, f5_local9, TARGET_ENE_0, f5_local11, f5_local12, f5_local13, 0, 0)
        f5_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, f5_local10, TARGET_ENE_0, 9999, 0, 0)
    else
        f5_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 10, f5_local9, TARGET_ENE_0, 9999, f5_local12, f5_local13, 0, 0)
    end
    f5_arg0:SetNumber(3, 1)
    return 0
    
end

Goal.Act04 = function (f6_arg0, f6_arg1, f6_arg2)
    local f6_local0 = f6_arg0:GetDist(TARGET_ENE_0)
    local f6_local1 = 5.6 - f6_arg0:GetMapHitRadius(TARGET_SELF)
    local f6_local2 = 5.6 - f6_arg0:GetMapHitRadius(TARGET_SELF) + 2
    local f6_local3 = 5.6 - f6_arg0:GetMapHitRadius(TARGET_SELF) + 2
    local f6_local4 = 100
    local f6_local5 = 0
    local f6_local6 = 2.5
    local f6_local7 = 10
    if f6_arg0:HasSpecialEffectId(TARGET_ENE_0, 3102000) or f6_local0 <= f6_local1 + 1 then
        Approach_Act_Flex(f6_arg0, f6_arg1, f6_local1, f6_local2, f6_local3, f6_local4, f6_local5, f6_local6, f6_local7)
    else
        Approach_Act_Flex(f6_arg0, f6_arg1, f6_local1 + 1, f6_local2, f6_local3, f6_local4, f6_local5, f6_local6, f6_local7)
        f6_arg1:AddSubGoal(GOAL_COMMON_SpinStep, 3, 5200, TARGET_ENE_0, 0, AI_DIR_TYPE_F, 3)
    end
    local f6_local8 = 3006
    local f6_local9 = 0.5
    local f6_local10 = 90
    f6_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 10, f6_local8, TARGET_ENE_0, 9999, f6_local9, f6_local10, 0, 0)
    
end

Goal.Act05 = function (f7_arg0, f7_arg1, f7_arg2)
    local f7_local0 = f7_arg0:GetDist(TARGET_ENE_0)
    local f7_local1 = 4 - f7_arg0:GetMapHitRadius(TARGET_SELF)
    local f7_local2 = 4 - f7_arg0:GetMapHitRadius(TARGET_SELF) + 2
    local f7_local3 = 4 - f7_arg0:GetMapHitRadius(TARGET_SELF) + 2
    local f7_local4 = 100
    local f7_local5 = 0
    local f7_local6 = 2.5
    local f7_local7 = 5
    if f7_arg0:HasSpecialEffectId(TARGET_ENE_0, 3102000) or f7_local0 <= f7_local1 + 1 then
        Approach_Act_Flex(f7_arg0, f7_arg1, f7_local1, f7_local2, f7_local3, f7_local4, f7_local5, f7_local6, f7_local7)
    else
        Approach_Act_Flex(f7_arg0, f7_arg1, f7_local1 + 1, f7_local2, f7_local3, f7_local4, f7_local5, f7_local6, f7_local7)
        f7_arg1:AddSubGoal(GOAL_COMMON_SpinStep, 3, 5200, TARGET_ENE_0, 0, AI_DIR_TYPE_F, 3)
    end
    local f7_local8 = 3007
    local f7_local9 = 0.5
    local f7_local10 = 90
    f7_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 10, f7_local8, TARGET_ENE_0, 9999, f7_local9, f7_local10, 0, 0)
    return 0
    
end

Goal.Act06 = function (f8_arg0, f8_arg1, f8_arg2)
    local f8_local0 = f8_arg0:GetDist(TARGET_ENE_0)
    local f8_local1 = 2.5 - f8_arg0:GetMapHitRadius(TARGET_SELF)
    local f8_local2 = 2.5 - f8_arg0:GetMapHitRadius(TARGET_SELF) + 0
    local f8_local3 = 2.5 - f8_arg0:GetMapHitRadius(TARGET_SELF) + 2
    local f8_local4 = 100
    local f8_local5 = 0
    local f8_local6 = 1.5
    local f8_local7 = 2.5
    if f8_arg0:HasSpecialEffectId(TARGET_ENE_0, 3102000) or f8_local0 <= f8_local1 + 1 then
        Approach_Act_Flex(f8_arg0, f8_arg1, f8_local1, f8_local2, f8_local3, f8_local4, f8_local5, f8_local6, f8_local7)
    else
        Approach_Act_Flex(f8_arg0, f8_arg1, f8_local1 + 1, f8_local2, f8_local3, f8_local4, f8_local5, f8_local6, f8_local7)
        f8_arg1:AddSubGoal(GOAL_COMMON_SpinStep, 3, 5200, TARGET_ENE_0, 0, AI_DIR_TYPE_F, 3)
    end
    local f8_local8 = 3008
    local f8_local9 = 3009
    local f8_local10 = 3067
    local f8_local11 = 3.8 - f8_arg0:GetMapHitRadius(TARGET_SELF)
    local f8_local12 = 0.5
    local f8_local13 = 90
    local f8_local14 = f8_arg0:GetRandam_Int(1, 100)
    f8_arg1:AddSubGoal(GOAL_COMMON_ComboAttackTunableSpin, 10, f8_local8, TARGET_ENE_0, f8_local11, f8_local12, f8_local13, 0, 0)
    if f8_local14 <= 40 then
        f8_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, f8_local10, TARGET_ENE_0, 9999, 0, 0)
    else
        f8_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, f8_local9, TARGET_ENE_0, 9999, 0, 0)
    end
    return 0
    
end

Goal.Act07 = function (f9_arg0, f9_arg1, f9_arg2)
    local f9_local0 = f9_arg0:GetDist(TARGET_ENE_0)
    local f9_local1 = 6.5 - f9_arg0:GetMapHitRadius(TARGET_SELF)
    local f9_local2 = 6.5 - f9_arg0:GetMapHitRadius(TARGET_SELF) + 2
    local f9_local3 = 6.5 - f9_arg0:GetMapHitRadius(TARGET_SELF) + 2
    local f9_local4 = 100
    local f9_local5 = 0
    local f9_local6 = 2.5
    local f9_local7 = 10
    if f9_arg0:HasSpecialEffectId(TARGET_ENE_0, 3102000) or f9_local0 <= f9_local1 + 1 then
        Approach_Act_Flex(f9_arg0, f9_arg1, f9_local1, f9_local2, f9_local3, f9_local4, f9_local5, f9_local6, f9_local7)
    else
        Approach_Act_Flex(f9_arg0, f9_arg1, f9_local1 + 1, f9_local2, f9_local3, f9_local4, f9_local5, f9_local6, f9_local7)
        f9_arg1:AddSubGoal(GOAL_COMMON_SpinStep, 3, 5200, TARGET_ENE_0, 0, AI_DIR_TYPE_F, 3)
    end
    local f9_local8 = 3010
    local f9_local9 = 0.5
    local f9_local10 = 90
    f9_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 10, f9_local8, TARGET_ENE_0, 9999, f9_local9, f9_local10, 0, 0)
    return 0
    
end

Goal.Act08 = function (f10_arg0, f10_arg1, f10_arg2)
    local f10_local0 = f10_arg0:GetDist(TARGET_ENE_0)
    local f10_local1 = 5.6 - f10_arg0:GetMapHitRadius(TARGET_SELF)
    local f10_local2 = 5.6 - f10_arg0:GetMapHitRadius(TARGET_SELF) + 0
    local f10_local3 = 5.6 - f10_arg0:GetMapHitRadius(TARGET_SELF) + 2
    local f10_local4 = 100
    local f10_local5 = 0
    local f10_local6 = 2.5
    local f10_local7 = 5
    if f10_arg0:HasSpecialEffectId(TARGET_ENE_0, 3102000) or f10_local0 <= f10_local1 + 1 then
        Approach_Act_Flex(f10_arg0, f10_arg1, f10_local1, f10_local2, f10_local3, f10_local4, f10_local5, f10_local6, f10_local7)
    else
        Approach_Act_Flex(f10_arg0, f10_arg1, f10_local1 + 1, f10_local2, f10_local3, f10_local4, f10_local5, f10_local6, f10_local7)
        f10_arg1:AddSubGoal(GOAL_COMMON_SpinStep, 3, 5200, TARGET_ENE_0, 0, AI_DIR_TYPE_F, 3)
    end
    local f10_local8 = 3012
    local f10_local9 = 0.5
    local f10_local10 = 90
    f10_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 10, f10_local8, TARGET_ENE_0, 9999, f10_local9, f10_local10, 0, 0)
    return 0
    
end

Goal.Act09 = function (f11_arg0, f11_arg1, f11_arg2)
    local f11_local0 = f11_arg0:GetDist(TARGET_ENE_0)
    local f11_local1 = 10.4 - f11_arg0:GetMapHitRadius(TARGET_SELF)
    local f11_local2 = 10.4 - f11_arg0:GetMapHitRadius(TARGET_SELF) + 0
    local f11_local3 = 10.4 - f11_arg0:GetMapHitRadius(TARGET_SELF) + 2
    local f11_local4 = 100
    local f11_local5 = 0
    local f11_local6 = 2.5
    local f11_local7 = 10
    local f11_local8 = 3
    local f11_local9 = 0.5
    if f11_local1 + 1 < f11_local0 then
        Approach_Act_Flex(f11_arg0, f11_arg1, f11_local1 + 1, f11_local2, f11_local3, f11_local4, f11_local5, f11_local6, f11_local7)
        f11_arg1:AddSubGoal(GOAL_COMMON_SpinStep, 3, 5200, TARGET_ENE_0, 0, AI_DIR_TYPE_F, 3)
    elseif f11_local1 < f11_local0 then
        Approach_Act_Flex(f11_arg0, f11_arg1, f11_local1, f11_local2, f11_local3, f11_local4, f11_local5, f11_local6, f11_local7)
    elseif f11_local0 < 5 and SpaceCheck(f11_arg0, f11_arg1, 180, 4) == true then
        f11_arg1:AddSubGoal(GOAL_COMMON_SpinStep, f11_local8, 5211, TARGET_ENE_0, f11_local9, AI_DIR_TYPE_B, 0):TimingSetTimer(3, 6, UPDATE_SUCCESS)
    end
    local f11_local10 = 3014
    local f11_local11 = 5.2 - f11_arg0:GetMapHitRadius(TARGET_SELF)
    local f11_local12 = 0.5
    local f11_local13 = 90
    local f11_local14 = 90
    local f11_local15 = 5.2 - f11_arg0:GetMapHitRadius(TARGET_SELF) + f11_arg0:GetMapHitRadius(TARGET_SELF)
    f11_arg0:AddObserveArea(0, TARGET_SELF, TARGET_ENE_0, AI_DIR_TYPE_F, f11_local14, f11_local15)
    f11_arg1:AddSubGoal(GOAL_COMMON_ComboAttackTunableSpin, 10, f11_local10, TARGET_ENE_0, f11_local11, f11_local12, f11_local13, 0, 0):TimingSetTimer(0, 15, UPDATE_SUCCESS)
    return 0
    
end

Goal.Act10 = function (f12_arg0, f12_arg1, f12_arg2)
    local f12_local0 = f12_arg0:GetDist(TARGET_ENE_0)
    local f12_local1 = ATT3016_DIST_MAX
    local f12_local2 = ATT3016_DIST_MAX + 0
    local f12_local3 = ATT3016_DIST_MAX + 2
    local f12_local4 = 100
    local f12_local5 = 0
    local f12_local6 = 2.5
    local f12_local7 = 5
    if f12_arg0:HasSpecialEffectId(TARGET_ENE_0, 3102000) or f12_local0 <= f12_local1 + 1 then
        Approach_Act_Flex(f12_arg0, f12_arg1, f12_local1, f12_local2, f12_local3, f12_local4, f12_local5, f12_local6, f12_local7)
    else
        Approach_Act_Flex(f12_arg0, f12_arg1, f12_local1 + 1, f12_local2, f12_local3, f12_local4, f12_local5, f12_local6, f12_local7)
        f12_arg1:AddSubGoal(GOAL_COMMON_SpinStep, 3, 5200, TARGET_ENE_0, 0, AI_DIR_TYPE_F, 3)
    end
    local f12_local8 = 3016
    local f12_local9 = 0.5
    local f12_local10 = 90
    f12_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 10, f12_local8, TARGET_ENE_0, 9999, f12_local9, f12_local10, 0, 0)
    return 0
    
end

Goal.Act11 = function (f13_arg0, f13_arg1, f13_arg2)
    local f13_local0 = f13_arg0:GetDist(TARGET_ENE_0)
    local f13_local1 = ATT3017_DIST_MAX
    local f13_local2 = ATT3017_DIST_MAX + 0
    local f13_local3 = ATT3017_DIST_MAX + 2
    local f13_local4 = 100
    local f13_local5 = 0
    local f13_local6 = 2.5
    local f13_local7 = 5
    if f13_arg0:HasSpecialEffectId(TARGET_ENE_0, 3102000) or f13_local0 <= f13_local1 + 1 then
        Approach_Act_Flex(f13_arg0, f13_arg1, f13_local1, f13_local2, f13_local3, f13_local4, f13_local5, f13_local6, f13_local7)
    else
        Approach_Act_Flex(f13_arg0, f13_arg1, f13_local1 + 1, f13_local2, f13_local3, f13_local4, f13_local5, f13_local6, f13_local7)
        f13_arg1:AddSubGoal(GOAL_COMMON_SpinStep, 3, 5200, TARGET_ENE_0, 0, AI_DIR_TYPE_F, 3)
    end
    local f13_local8 = 3017
    local f13_local9 = 0.5
    local f13_local10 = 90
    f13_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 10, f13_local8, TARGET_ENE_0, 9999, f13_local9, f13_local10, 0, 0)
    return 0
    
end

Goal.Act16 = function (f14_arg0, f14_arg1, f14_arg2)
    local f14_local0 = f14_arg0:GetDist(TARGET_ENE_0)
    local f14_local1 = 3
    local f14_local2 = 0.5
    local f14_local3 = 3020
    local f14_local4 = 0.5
    local f14_local5 = 90
    if f14_local0 < 5 and f14_arg0:IsFinishTimer(3) == true then
        if SpaceCheck(f14_arg0, f14_arg1, 180, 4) == true then
            f14_arg1:AddSubGoal(GOAL_COMMON_SpinStep, f14_local1, 5211, TARGET_ENE_0, f14_local4, AI_DIR_TYPE_B, 0):TimingSetTimer(3, 6, UPDATE_SUCCESS)
        elseif SpaceCheck(f14_arg0, f14_arg1, 180, 4) == true then
            f14_arg1:AddSubGoal(GOAL_COMMON_SpinStep, f14_local1, 5201, TARGET_ENE_0, f14_local4, AI_DIR_TYPE_B, 0):TimingSetTimer(3, 6, UPDATE_SUCCESS)
        end
    end
    f14_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 10, f14_local3, TARGET_ENE_0, 9999, f14_local4, f14_local5, 0, 0)
    return 0
    
end

Goal.Act21 = function (f15_arg0, f15_arg1, f15_arg2)
    local f15_local0 = 3
    local f15_local1 = 45
    if f15_arg0:IsTargetGuard(TARGET_SELF) then
        f15_arg1:AddSubGoal(GOAL_COMMON_Turn, f15_local0, TARGET_ENE_0, f15_local1, 9910, GOAL_RESULT_Success, true)
    else
        f15_arg1:AddSubGoal(GOAL_COMMON_Turn, f15_local0, TARGET_ENE_0, f15_local1, -1, GOAL_RESULT_Success, true)
    end
    return 0
    
end

Goal.Act23 = function (f16_arg0, f16_arg1, f16_arg2)
    local f16_local0 = f16_arg0:GetDist(TARGET_ENE_0)
    local f16_local1 = f16_arg0:GetSp(TARGET_SELF)
    local f16_local2 = 20
    local f16_local3 = f16_arg0:GetRandam_Int(1, 100)
    local f16_local4 = -1
    if f16_local2 <= f16_local1 and f16_local3 <= 0 then
        f16_local4 = 9910
    end
    if SpaceCheck(f16_arg0, f16_arg1, -90, 1) == true then
        if SpaceCheck(f16_arg0, f16_arg1, 90, 1) == true then
            if f16_arg0:IsInsideTarget(TARGET_ENE_0, AI_DIR_TYPE_R, 180) then
                direction = 1
            else
                direction = 0
            end
        else
            direction = 0
        end
    elseif SpaceCheck(f16_arg0, f16_arg1, 90, 1) == true then
        direction = 1
    else
    end
    local f16_local5 = nil
    local f16_local6 = f16_arg0:GetRandam_Int(30, 45)
    local f16_local7 = 90
    local f16_local8 = 2.5 - f16_arg0:GetMapHitRadius(TARGET_SELF) + 1
    if f16_local0 <= 5 then
        f16_local5 = f16_arg0:GetRandam_Float(1, 2)
    elseif f16_local0 <= 8 then
        f16_local5 = f16_arg0:GetRandam_Float(2, 3)
    else
        f16_local5 = f16_arg0:GetRandam_Float(3, 4)
    end
    f16_arg1:AddSubGoal(GOAL_COMMON_SidewayMove, f16_local5, TARGET_ENE_0, direction, f16_local6, true, true, f16_local4)
    f16_arg0:AddObserveArea(1, TARGET_SELF, TARGET_ENE_0, AI_DIR_TYPE_F, f16_local7, f16_local8)
    f16_arg0:SetTimer(2, 4)
    return 0
    
end

Goal.Act24 = function (f17_arg0, f17_arg1, f17_arg2)
    local f17_local0 = f17_arg0:GetDist(TARGET_ENE_0)
    local f17_local1 = 3
    local f17_local2 = 0
    local f17_local3 = 5201
    if SpaceCheck(f17_arg0, f17_arg1, 180, 2) ~= true or SpaceCheck(f17_arg0, f17_arg1, 180, 4) ~= true or f17_local0 > 4 then
    else
        f17_local3 = 5211
        if false then
        else
        end
    end
    f17_arg1:AddSubGoal(GOAL_COMMON_SpinStep, f17_local1, f17_local3, TARGET_ENE_0, f17_local2, AI_DIR_TYPE_B, 0):TimingSetTimer(3, 6, AI_TIMING_SET__ACTIVATE):TimingSetNumber(11, 1, AI_TIMING_SET__ACTIVATE)
    return 0
    
end

Goal.Act25 = function (f18_arg0, f18_arg1, f18_arg2)
    local f18_local0 = f18_arg0:GetRandam_Float(2, 4)
    local f18_local1 = f18_arg0:GetRandam_Float(1, 3)
    local f18_local2 = f18_arg0:GetDist(TARGET_ENE_0)
    local f18_local3 = -1
    local f18_local4 = f18_arg0:GetRandam_Int(1, 100)
    f18_arg1:AddSubGoal(GOAL_COMMON_LeaveTarget, f18_local0, TARGET_ENE_0, f18_local1, TARGET_ENE_0, true, f18_local3)
    f18_arg0:SetTimer(1, 10)
    return 0
    
end

Goal.Act26 = function (f19_arg0, f19_arg1, f19_arg2)
    f19_arg1:AddSubGoal(GOAL_COMMON_Wait, 0.5, TARGET_SELF, 0, 0, 0)
    return 0
    
end

Goal.Act27 = function (f20_arg0, f20_arg1, f20_arg2)
    local f20_local0 = f20_arg0:GetRandam_Int(1, 100)
    if YousumiAct_SubGoal(f20_arg0, f20_arg1, true, 60, 30) == false then
        GetWellSpace_Odds = 0
        return GetWellSpace_Odds
    end
    local f20_local1 = 0
    local f20_local2 = SpaceCheck_SidewayMove(f20_arg0, f20_arg1, 1)
    if f20_local2 == 0 then
        f20_local1 = 0
    elseif f20_local2 == 1 then
        f20_local1 = 1
    elseif f20_local2 == 2 then
        if f20_local0 <= 50 then
            f20_local1 = 0
        else
            f20_local1 = 1
        end
    else
        f20_arg1:AddSubGoal(GOAL_COMMON_Wait, 1, TARGET_SELF, 0, 0, 0)
        GetWellSpace_Odds = 0
        return GetWellSpace_Odds
    end
    f20_arg0:SetNumber(10, f20_local1)
    f20_arg1:AddSubGoal(GOAL_COMMON_SidewayMove, 3, TARGET_ENE_0, f20_local1, f20_arg0:GetRandam_Int(30, 45), true, true, -1)
    return 0
    
end

Goal.Act28 = function (f21_arg0, f21_arg1, f21_arg2)
    local f21_local0 = f21_arg0:GetDist(TARGET_ENE_0)
    local f21_local1 = 1.5
    local f21_local2 = 1.5
    local f21_local3 = f21_arg0:GetRandam_Int(30, 45)
    local f21_local4 = -1
    local f21_local5 = 0
    local f21_local6 = f21_arg0:GetRandam_Int(1, 100)
    if f21_local0 <= 2 then
        f21_arg1:AddSubGoal(GOAL_COMMON_LeaveTarget, f21_local2, TARGET_ENE_0, 6, TARGET_ENE_0, true, f21_local4)
    elseif f21_local0 <= 6 then
        if SpaceCheck(f21_arg0, f21_arg1, -90, 1) == true then
            if SpaceCheck(f21_arg0, f21_arg1, 90, 1) == true then
                if f21_arg0:IsInsideTarget(TARGET_ENE_0, AI_DIR_TYPE_R, 180) then
                    f21_local5 = 1
                else
                    f21_local5 = 0
                end
            else
                f21_local5 = 0
            end
        elseif SpaceCheck(f21_arg0, f21_arg1, 90, 1) == true then
            f21_local5 = 1
        else
        end
        f21_arg1:AddSubGoal(GOAL_COMMON_SidewayMove, f21_local1, TARGET_ENE_0, f21_local5, f21_local3, true, true, f21_local4)
    elseif f21_local0 <= 8 then
        f21_arg1:AddSubGoal(GOAL_COMMON_ApproachTarget, f21_local2, TARGET_ENE_0, 6, TARGET_SELF, true, -1)
    else
        f21_arg1:AddSubGoal(GOAL_COMMON_ApproachTarget, f21_local2, TARGET_ENE_0, 8, TARGET_SELF, false, -1)
    end
    
end

Goal.Act31 = function (f22_arg0, f22_arg1, f22_arg2)
    local f22_local0 = f22_arg0:GetRandam_Float(3, 4)
    local f22_local1 = 8
    local f22_local2 = f22_arg0:GetDist(TARGET_ENE_0)
    local f22_local3 = -1
    local f22_local4 = 20
    local f22_local5 = f22_arg0:GetRandam_Int(1, 100)
    f22_arg0:SetNumber(10, 1)
    local f22_local6 = 0
    if SpaceCheck(f22_arg0, f22_arg1, -90, 1) == true then
        if SpaceCheck(f22_arg0, f22_arg1, 90, 1) == true then
            if f22_arg0:IsInsideTarget(TARGET_ENE_0, AI_DIR_TYPE_R, 180) then
                f22_local6 = 0
            else
                f22_local6 = 1
            end
        else
            f22_local6 = 0
        end
    elseif SpaceCheck(f22_arg0, f22_arg1, 90, 1) == true then
        f22_local6 = 1
    else
    end
    local f22_local7 = f22_arg0:GetRandam_Int(30, 45)
    if f22_local2 <= 14 then
        f22_arg1:AddSubGoal(GOAL_COMMON_ApproachTarget, 3, TARGET_ENE_0, f22_local1, TARGET_SELF, true, -1)
        f22_arg1:AddSubGoal(GOAL_COMMON_SidewayMove, f22_local0, TARGET_ENE_0, f22_local6, f22_local7, true, true, f22_local3)
    else
        f22_arg1:AddSubGoal(GOAL_COMMON_ApproachTarget, f22_local0, TARGET_ENE_0, f22_local1, TARGET_SELF, false, -1)
    end
    f22_arg0:SetTimer(2, 8)
    return 0
    
end

Goal.Kengeki_Activate = function (f23_arg0, f23_arg1, f23_arg2)
    local f23_local0 = ReturnKengekiSpecialEffect(f23_arg1)
    if f23_local0 == 0 then
        return false
    end
    local f23_local1 = {}
    local f23_local2 = {}
    local f23_local3 = {}
    Common_Clear_Param(f23_local1, f23_local2, f23_local3)
    local f23_local4 = f23_arg1:GetDist(TARGET_ENE_0)
    local f23_local5 = f23_arg1:GetNinsatsuNum()
    local f23_local6 = f23_arg1:GetSp(TARGET_SELF)
    local f23_local7 = f23_arg1:GetSpRate(TARGET_SELF)
    local f23_local8 = f23_arg1:GetNpcThinkParamID()
    local f23_local9 = 0
    if f23_arg1:HasSpecialEffectId(TARGET_SELF, 200051) then
        f23_local9 = 1
    end
    if f23_local9 == 0 and f23_local7 <= 0.5 and f23_arg1:GetAttackPassedTime(3020) >= 10 then
        f23_local1[50] = 1
    elseif f23_local0 == 200200 then
        if f23_local4 >= 3 then
        elseif f23_local4 <= 0.2 then
            if f23_arg1:GetNumber(0) == 0 then
                f23_local1[5] = 100
            else
                f23_local1[6] = 100
            end
        else
            if f23_arg1:GetNumber(0) == 0 then
                f23_local1[5] = 200
            else
                f23_local1[6] = 200
            end
            f23_local1[8] = 200
            if f23_local9 == 1 then
                f23_local1[7] = 500
            end
        end
    elseif f23_local0 == 200201 then
        if f23_local4 >= 3 then
        elseif f23_local4 <= 0.2 then
            if f23_arg1:GetNumber(1) == 0 then
                f23_local1[9] = 100
            else
                f23_local1[10] = 100
            end
            if f23_local9 == 1 then
                f23_local1[11] = 200
            end
        else
            if f23_arg1:GetNumber(1) == 0 then
                f23_local1[9] = 100
            elseif f23_arg1:GetNumber(1) == 1 then
                f23_local1[10] = 100
            end
            f23_local1[12] = 100
            if f23_local8 == 10200020 then
                f23_local1[12] = 500
            end
        end
    elseif f23_local0 == 200205 then
        if f23_local6 < 0 then
            f23_local1[24] = 100
        elseif f23_local4 >= 3 then
        elseif f23_local4 <= 0.2 then
            f23_local1[24] = 100
        else
            f23_local1[18] = 100
            if f23_local9 == 1 then
                f23_local1[1] = 100
                f23_local1[2] = 300
            else
                f23_local1[1] = 300
            end
        end
    elseif f23_local0 == 200206 then
        if f23_local6 < 0 then
            f23_local1[24] = 100
        elseif f23_local4 >= 3 then
        elseif f23_local4 <= 0.2 then
            f23_local1[4] = 200
            f23_local1[24] = 100
        else
            f23_local1[18] = 100
            f23_local1[3] = 300
        end
    elseif f23_local0 == 200210 then
        if f23_local4 >= 3 then
        else
            f23_local1[5] = 100
            f23_local1[16] = 200
        end
    elseif f23_local0 == 200211 then
        if f23_local4 >= 3 then
        else
            f23_local1[4] = 100
            f23_local1[16] = 200
        end
    elseif f23_local0 == 200215 then
        if f23_local4 >= 3 and false then
        end
    elseif f23_local0 == 200216 and f23_local4 >= 3 and false then
    else
    end
    f23_local1[2] = SetCoolTime(f23_arg1, f23_arg2, 3054, 10, f23_local1[2], 1)
    f23_local1[7] = SetCoolTime(f23_arg1, f23_arg2, 3062, 10, f23_local1[7], 1)
    f23_local2[1] = REGIST_FUNC(f23_arg1, f23_arg2, f23_arg0.Kengeki01)
    f23_local2[2] = REGIST_FUNC(f23_arg1, f23_arg2, f23_arg0.Kengeki02)
    f23_local2[3] = REGIST_FUNC(f23_arg1, f23_arg2, f23_arg0.Kengeki03)
    f23_local2[4] = REGIST_FUNC(f23_arg1, f23_arg2, f23_arg0.Kengeki04)
    f23_local2[5] = REGIST_FUNC(f23_arg1, f23_arg2, f23_arg0.Kengeki05)
    f23_local2[6] = REGIST_FUNC(f23_arg1, f23_arg2, f23_arg0.Kengeki06)
    f23_local2[7] = REGIST_FUNC(f23_arg1, f23_arg2, f23_arg0.Kengeki07)
    f23_local2[8] = REGIST_FUNC(f23_arg1, f23_arg2, f23_arg0.Kengeki08)
    f23_local2[9] = REGIST_FUNC(f23_arg1, f23_arg2, f23_arg0.Kengeki09)
    f23_local2[10] = REGIST_FUNC(f23_arg1, f23_arg2, f23_arg0.Kengeki10)
    f23_local2[11] = REGIST_FUNC(f23_arg1, f23_arg2, f23_arg0.Kengeki11)
    f23_local2[12] = REGIST_FUNC(f23_arg1, f23_arg2, f23_arg0.Kengeki12)
    f23_local2[13] = REGIST_FUNC(f23_arg1, f23_arg2, f23_arg0.Kengeki13)
    f23_local2[14] = REGIST_FUNC(f23_arg1, f23_arg2, f23_arg0.Kengeki14)
    f23_local2[15] = REGIST_FUNC(f23_arg1, f23_arg2, f23_arg0.Kengeki15)
    f23_local2[16] = REGIST_FUNC(f23_arg1, f23_arg2, f23_arg0.Kengeki16)
    f23_local2[18] = REGIST_FUNC(f23_arg1, f23_arg2, f23_arg0.Kengeki18)
    f23_local2[21] = REGIST_FUNC(f23_arg1, f23_arg2, f23_arg0.Act21)
    f23_local2[22] = REGIST_FUNC(f23_arg1, f23_arg2, f23_arg0.Act22)
    f23_local2[23] = REGIST_FUNC(f23_arg1, f23_arg2, f23_arg0.Act23)
    f23_local2[24] = REGIST_FUNC(f23_arg1, f23_arg2, f23_arg0.Act24)
    f23_local2[25] = REGIST_FUNC(f23_arg1, f23_arg2, f23_arg0.Act25)
    f23_local2[50] = REGIST_FUNC(f23_arg1, f23_arg2, f23_arg0.NoAction)
    local f23_local10 = REGIST_FUNC(f23_arg1, f23_arg2, f23_arg0.ActAfter_AdjustSpace)
    return Common_Kengeki_Activate(f23_arg1, f23_arg2, f23_local1, f23_local2, f23_local10, f23_local3)
    
end

Goal.Kengeki01 = function (f24_arg0, f24_arg1, f24_arg2)
    f24_arg1:ClearSubGoal()
    f24_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 1, 3051, TARGET_ENE_0, 9999, 0, 0)
    return 0
    
end

Goal.Kengeki02 = function (f25_arg0, f25_arg1, f25_arg2)
    f25_arg1:ClearSubGoal()
    f25_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 1, 3054, TARGET_ENE_0, 9999, 0, 0)
    return 0
    
end

Goal.Kengeki03 = function (f26_arg0, f26_arg1, f26_arg2)
    f26_arg1:ClearSubGoal()
    f26_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 1, 3056, TARGET_ENE_0, 9999, 0, 0)
    return 0
    
end

Goal.Kengeki04 = function (f27_arg0, f27_arg1, f27_arg2)
    f27_arg1:ClearSubGoal()
    f27_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 1, 3057, TARGET_ENE_0, 9999, 0, 0)
    return 0
    
end

Goal.Kengeki05 = function (f28_arg0, f28_arg1, f28_arg2)
    f28_arg0:SetNumber(0, 1)
    f28_arg1:ClearSubGoal()
    f28_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 1, 3060, TARGET_ENE_0, 9999, 0, 0)
    return 0
    
end

Goal.Kengeki06 = function (f29_arg0, f29_arg1, f29_arg2)
    f29_arg0:SetNumber(0, 0)
    f29_arg1:ClearSubGoal()
    f29_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 1, 3061, TARGET_ENE_0, 9999, 0, 0)
    return 0
    
end

Goal.Kengeki07 = function (f30_arg0, f30_arg1, f30_arg2)
    f30_arg1:ClearSubGoal()
    f30_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 1, 3062, TARGET_ENE_0, 9999, 0, 0)
    return 0
    
end

Goal.Kengeki08 = function (f31_arg0, f31_arg1, f31_arg2)
    f31_arg1:ClearSubGoal()
    f31_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 1, 3063, TARGET_ENE_0, 9999, 0, 0)
    return 0
    
end

Goal.Kengeki09 = function (f32_arg0, f32_arg1, f32_arg2)
    f32_arg0:SetNumber(1, 1)
    f32_arg1:ClearSubGoal()
    f32_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 1, 3065, TARGET_ENE_0, 9999, 0, 0)
    return 0
    
end

Goal.Kengeki10 = function (f33_arg0, f33_arg1, f33_arg2)
    f33_arg0:SetNumber(1, 0)
    f33_arg1:ClearSubGoal()
    f33_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 1, 3066, TARGET_ENE_0, 9999, 0, 0)
    return 0
    
end

Goal.Kengeki11 = function (f34_arg0, f34_arg1, f34_arg2)
    f34_arg1:ClearSubGoal()
    f34_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 1, 3067, TARGET_ENE_0, 9999, 0, 0)
    return 0
    
end

Goal.Kengeki12 = function (f35_arg0, f35_arg1, f35_arg2)
    f35_arg1:ClearSubGoal()
    f35_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 1, 3068, TARGET_ENE_0, 9999, 0, 0)
    return 0
    
end

Goal.Kengeki13 = function (f36_arg0, f36_arg1, f36_arg2)
    f36_arg0:SetNumber(3, 0)
    f36_arg1:ClearSubGoal()
    f36_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 1, 3071, TARGET_ENE_0, 9999, 0, 0)
    return 0
    
end

Goal.Kengeki14 = function (f37_arg0, f37_arg1, f37_arg2)
    f37_arg0:SetNumber(3, 0)
    f37_arg1:ClearSubGoal()
    f37_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 1, 3076, TARGET_ENE_0, 9999, 0, 0)
    return 0
    
end

Goal.Kengeki15 = function (f38_arg0, f38_arg1, f38_arg2)
    f38_arg1:ClearSubGoal()
    f38_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 1, 3083, TARGET_ENE_0, 9999, 0, 0)
    return 0
    
end

Goal.Kengeki16 = function (f39_arg0, f39_arg1, f39_arg2)
    f39_arg1:ClearSubGoal()
    f39_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 1, 3088, TARGET_ENE_0, 9999, 0, 0)
    return 0
    
end

Goal.Kengeki18 = function (f40_arg0, f40_arg1, f40_arg2)
    f40_arg1:ClearSubGoal()
    f40_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 1, 3003, TARGET_ENE_0, 9999, 0, 0)
    return 0
    
end

Goal.NoAction = function (f41_arg0, f41_arg1, f41_arg2)
    return -1
    
end

Goal.Interrupt = function (f42_arg0, f42_arg1, f42_arg2)
    local f42_local0 = f42_arg1:GetDist(TARGET_ENE_0)
    local f42_local1 = f42_arg1:GetRandam_Int(1, 100)
    local f42_local2 = f42_arg1:GetSpecialEffectActivateInterruptType(0)
    local f42_local3 = 90
    local f42_local4 = 4 - f42_arg1:GetMapHitRadius(TARGET_SELF)
    local f42_local5 = f42_arg1:GetNpcThinkParamID()
    if f42_arg1:IsLadderAct(TARGET_SELF) then
        return false
    end
    if not f42_arg1:HasSpecialEffectId(TARGET_SELF, 200004) then
        return false
    end
    if f42_arg1:IsInterupt(INTERUPT_ParryTiming) then
        return f42_arg0.Parry(f42_arg1, f42_arg2, 50, 0)
    end
    if f42_arg1:IsInterupt(INTERUPT_ShootImpact) and f42_arg0.ShootReaction(f42_arg1, f42_arg2) then
        return true
    end
    if Interupt_PC_Break(f42_arg1) and f42_local5 ~= 10200020 then
        f42_arg1:Replanning()
        return true
    end
    if f42_arg1:IsInterupt(INTERUPT_ActivateSpecialEffect) then
        if f42_arg1:GetSpecialEffectActivateInterruptType(0) == 90 then
            f42_arg2:ClearSubGoal()
            f42_arg2:AddSubGoal(GOAL_COMMON_SidewayMove, 2, TARGET_ENE_0, f42_arg1:GetRandam_Int(0, 1), f42_arg1:GetRandam_Int(30, 45), true, true, -1)
            f42_arg1:AddObserveArea(2, TARGET_SELF, TARGET_ENE_0, AI_DIR_TYPE_F, f42_local3, f42_local4)
            return true
        elseif f42_arg1:GetSpecialEffectActivateInterruptType(0) == 109220 or f42_arg1:GetSpecialEffectActivateInterruptType(0) == 109221 then
            f42_arg1:Replanning()
            return true
        end
        return false
    end
    if f42_arg1:HasSpecialEffectId(TARGET_SELF, 3102050) and Interupt_Use_Item(f42_arg1, 4, 10) then
        if f42_local0 <= 5.6 - f42_arg1:GetMapHitRadius(TARGET_SELF) then
            f42_arg2:ClearSubGoal()
            f42_arg2:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 1, 3012, TARGET_ENE_0, 9999, 0, 0, 0, 0)
            return true
        elseif f42_local0 <= 6.5 - f42_arg1:GetMapHitRadius(TARGET_SELF) then
            f42_arg2:ClearSubGoal()
            f42_arg2:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 1, 3010, TARGET_ENE_0, 9999, 0, 0, 0, 0)
            return true
        else
            f42_arg1:Replanning()
            return true
        end
    end
    if f42_arg1:IsInterupt(INTERUPT_Outside_ObserveArea) and f42_arg1:GetAreaObserveSlot(AI_AREAOBSERVE_INTERRUPT__OUTSIDE, 2) == false then
        f42_arg1:DeleteObserve(2)
        f42_arg2:ClearSubGoal()
        f42_arg2:AddSubGoal(GOAL_COMMON_ApproachTarget, 1, TARGET_ENE_0, 0, TARGET_SELF, true, -1)
        f42_arg1:AddObserveArea(3, TARGET_SELF, TARGET_ENE_0, AI_DIR_TYPE_F, f42_local3, f42_local4)
        return true
    end
    if f42_arg1:IsInterupt(INTERUPT_Inside_ObserveArea) then
        return f42_arg0.InObserveArea_Action(f42_arg1, f42_arg2)
    end
    if f42_arg1:IsInterupt(INTERUPT_LoseSightTarget) and f42_arg1:IsActiveGoal(GOAL_COMMON_SidewayMove) then
        if f42_arg1:GetNumber(10) == 0 then
            f42_arg2:ClearSubGoal()
            f42_arg2:AddSubGoal(GOAL_COMMON_SidewayMove, 1, TARGET_ENE_0, 1, f42_arg1:GetRandam_Int(30, 45), true, true, -1)
            return true
        elseif f42_arg1:GetNumber(10) == 1 then
            f42_arg2:ClearSubGoal()
            f42_arg2:AddSubGoal(GOAL_COMMON_SidewayMove, 1, TARGET_ENE_0, 0, f42_arg1:GetRandam_Int(30, 45), true, true, -1)
            return true
        end
    end
    return false
    
end

Goal.Parry = function (f43_arg0, f43_arg1, f43_arg2, f43_arg3)
    local f43_local0 = f43_arg0:GetDist(TARGET_ENE_0)
    local f43_local1 = GetDist_Parry(f43_arg0)
    local f43_local2 = f43_arg0:GetRandam_Int(1, 100)
    local f43_local3 = f43_arg0:GetRandam_Int(1, 100)
    local f43_local4 = f43_arg0:GetRandam_Int(1, 100)
    local f43_local5 = f43_arg0:GetRandam_Int(1, 100)
    local f43_local6 = f43_arg0:HasSpecialEffectId(TARGET_ENE_0, 109970)
    local f43_local7 = f43_arg0:HasSpecialEffectId(TARGET_ENE_0, COMMON_SP_EFFECT_PC_ATTACK_RUSH)
    local f43_local8 = -1
    if f43_arg0:HasSpecialEffectId(TARGET_SELF, 221000) then
        f43_local8 = 0
    elseif f43_arg0:HasSpecialEffectId(TARGET_SELF, 221001) then
        f43_local8 = 1
    elseif f43_arg0:HasSpecialEffectId(TARGET_SELF, 221002) then
        f43_local8 = 2
    end
    if f43_arg0:IsFinishTimer(AI_TIMER_PARRY_INTERVAL) == false then
        return false
    end
    if f43_local8 == -1 then
        return false
    end
    if f43_arg0:HasSpecialEffectId(TARGET_SELF, 220062) then
        return false
    end
    if f43_arg0:HasSpecialEffectId(TARGET_ENE_0, 110450) or f43_arg0:HasSpecialEffectId(TARGET_ENE_0, 110501) or f43_arg0:HasSpecialEffectId(TARGET_ENE_0, 110500) then
        return false
    end
    f43_arg0:SetTimer(AI_TIMER_PARRY_INTERVAL, 0.1)
    if f43_local7 and f43_arg0:HasSpecialEffectId(TARGET_SELF, 200229) and f43_local5 <= 50 then
        f43_arg1:ClearSubGoal()
        f43_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 1, 3088, TARGET_ENE_0, 9999, 0, 0)
        return true
    end
    if f43_arg0:IsInsideTarget(TARGET_ENE_0, AI_DIR_TYPE_F, 90) and f43_arg0:IsInsideTargetEx(TARGET_ENE_0, TARGET_SELF, AI_DIR_TYPE_F, 90, f43_local1) then
        if f43_local7 then
            f43_arg1:ClearSubGoal()
            f43_arg1:AddSubGoal(GOAL_COMMON_EndureAttack, 0.3, 3102, TARGET_ENE_0, 9999, 0)
            return true
        elseif f43_local6 then
            if f43_arg0:IsTargetGuard(TARGET_SELF) and ReturnKengekiSpecialEffect(f43_arg0) == false then
                return false
            elseif f43_local8 == 2 then
                return false
            elseif f43_local8 == 1 then
                if f43_local2 <= 50 then
                    f43_arg1:ClearSubGoal()
                    f43_arg1:AddSubGoal(GOAL_COMMON_EndureAttack, 0.3, 3101, TARGET_ENE_0, 9999, 0)
                    return true
                end
            elseif f43_local8 == 0 and f43_local2 <= 100 then
                f43_arg1:ClearSubGoal()
                f43_arg1:AddSubGoal(GOAL_COMMON_EndureAttack, 0.3, 3101, TARGET_ENE_0, 9999, 0)
                return true
            end
        elseif f43_arg0:HasSpecialEffectId(TARGET_ENE_0, 109980) then
            f43_arg1:ClearSubGoal()
            f43_arg1:AddSubGoal(GOAL_COMMON_SpinStep, 1, 5211, TARGET_ENE_0, 0, AI_DIR_TYPE_B, 0)
            return true
        elseif f43_local3 <= Get_ConsecutiveGuardCount(f43_arg0) * f43_arg2 then
            f43_arg1:ClearSubGoal()
            f43_arg1:AddSubGoal(GOAL_COMMON_EndureAttack, 0.3, 3101, TARGET_ENE_0, 9999, 0)
            return true
        else
            f43_arg1:ClearSubGoal()
            f43_arg1:AddSubGoal(GOAL_COMMON_EndureAttack, 0.3, 3100, TARGET_ENE_0, 9999, 0)
            return true
        end
    elseif f43_local1 <= 4 and f43_arg0:IsInsideTargetEx(TARGET_ENE_0, TARGET_SELF, AI_DIR_TYPE_F, 90, 5) then
        if f43_local4 <= 67 and f43_arg0:GetNinsatsuNum() <= 1 then
            f43_arg1:ClearSubGoal()
            f43_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 1, 3007, TARGET_ENE_0, 9999, 0, 0, 0, 0)
            return true
        else
            return false
        end
    end
    return false
    
end

Goal.ShootReaction = function (f44_arg0, f44_arg1)
    f44_arg1:ClearSubGoal()
    f44_arg1:AddSubGoal(GOAL_COMMON_EndureAttack, 0.3, 3102, TARGET_ENE_0, 9999, 0)
    return true
    
end

Goal.InObserveArea_Action = function (f45_arg0, f45_arg1)
    local f45_local0 = 3008
    local f45_local1 = 3009
    local f45_local2 = 3067
    local f45_local3 = 3.8 - f45_arg0:GetMapHitRadius(TARGET_SELF)
    local f45_local4 = 0.5
    local f45_local5 = 90
    local f45_local6 = f45_arg0:GetRandam_Int(1, 100)
    if f45_arg0:IsInsideObserve(0) then
        f45_arg1:ClearSubGoal()
        f45_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 1, 3015, TARGET_ENE_0, 9999, 0, 0)
        f45_arg0:DeleteObserve(0)
        return true
    elseif f45_arg0:IsInsideObserve(1) then
        if f45_arg0:HasSpecialEffectId(TARGET_ENE_0, 110015) == false and f45_arg0:IsStartAttack() == false then
            f45_arg0:Replanning()
            f45_arg0:DeleteObserve(1)
            return true
        end
    elseif f45_arg0:IsInsideObserve(3) then
        f45_arg1:ClearSubGoal()
        f45_arg1:AddSubGoal(GOAL_COMMON_SidewayMove, 1, TARGET_ENE_0, f45_arg0:GetRandam_Int(0, 1), f45_arg0:GetRandam_Int(30, 45), true, true, -1)
        f45_arg0:DeleteObserve(3)
        return true
    end
    return false
    
end

Goal.ActAfter_AdjustSpace = function (f46_arg0, f46_arg1, f46_arg2)
    
end

Goal.Update = function (f47_arg0, f47_arg1, f47_arg2)
    return Update_Default_NoSubGoal(f47_arg0, f47_arg1, f47_arg2)
    
end

Goal.Terminate = function (f48_arg0, f48_arg1, f48_arg2)
    
end


