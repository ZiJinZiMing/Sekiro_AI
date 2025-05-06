RegisterTableGoal(GOAL_Rappa_136000_Battle, "GOAL_Rappa_136000_Battle")
REGISTER_GOAL_NO_UPDATE(GOAL_Rappa_136000_Battle, true)

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
    local f2_local5 = Check_ReachAttack(f2_arg1, 0)
    local f2_local6 = f2_arg1:GetSp(TARGET_SELF)
    f2_arg1:DeleteObserve(0)
    f2_arg1:DeleteObserve(1)
    f2_arg1:DeleteObserve(2)
    f2_arg1:DeleteObserve(3)
    f2_arg1:DeleteObserve(4)
    f2_arg1:AddObserveSpecialEffectAttribute(TARGET_SELF, 3136000)
    f2_arg1:AddObserveSpecialEffectAttribute(TARGET_ENE_0, 3136001)
    Set_ConsecutiveGuardCount_Interrupt(f2_arg1)
    if f2_arg0.Kengeki_Activate(f2_arg0, f2_arg1, f2_arg2) then
        return
    end
    if Common_ActivateAct(f2_arg1, f2_arg2, 1) then
    elseif f2_local5 ~= POSSIBLE_ATTACK then
        if f2_local4 == 1 and f2_arg1:GetTeamOrder(ORDER_TYPE_Role) == ROLE_TYPE_Kankyaku then
            f2_local0[27] = 100
        elseif f2_local4 == 1 and f2_arg1:GetTeamOrder(ORDER_TYPE_Role) == ROLE_TYPE_Torimaki then
            f2_local0[27] = 100
        elseif f2_local5 == UNREACH_ATTACK then
            f2_local0[27] = 50
            f2_local0[7] = 100
        elseif f2_local5 == REACH_ATTACK_TARGET_HIGH_POSITION then
            f2_local0[3] = 100
            f2_local0[7] = 100
            f2_local0[27] = 100
        elseif f2_local5 == REACH_ATTACK_TARGET_LOW_POSITION then
            f2_local0[3] = 100
            f2_local0[7] = 100
            f2_local0[27] = 100
        else
            f2_local0[27] = 100
        end
    elseif f2_arg1:CheckDoesExistPath(TARGET_ENE_0, AI_DIR_TYPE_F, 0, 0) == false then
        f2_local0[27] = 1
        f2_local0[7] = 100
        f2_local0[23] = 10
    elseif f2_local4 == 1 and f2_arg1:GetTeamOrder(ORDER_TYPE_Role) == ROLE_TYPE_Kankyaku then
        KankyakuAct(f2_arg1, f2_arg2)
    elseif f2_local4 == 1 and f2_arg1:GetTeamOrder(ORDER_TYPE_Role) == ROLE_TYPE_Torimaki then
        if TorimakiAct(f2_arg1, f2_arg2) then
            f2_local0[1] = 100
            f2_local0[2] = 100
        end
    elseif f2_arg1:IsInsideTarget(TARGET_ENE_0, AI_DIR_TYPE_B, 180) then
        f2_local0[21] = 100
        f2_local0[25] = 1
    elseif f2_arg1:IsInsideTargetEx(TARGET_ENE_0, TARGET_SELF, AI_DIR_TYPE_F, 180, 9999) then
        if f2_arg1:HasSpecialEffectId(TARGET_SELF, 3136030) then
            if f2_local3 > 6 then
                f2_local0[1] = 100
                f2_local0[2] = 150
                f2_local0[7] = 200
                f2_local0[10] = 200
                f2_local0[14] = 150
            elseif f2_local3 >= 2 then
                f2_local0[1] = 100
                f2_local0[2] = 100
                f2_local0[4] = 200
                f2_local0[9] = 150
                f2_local0[11] = 100
                f2_local0[14] = 150
                f2_local0[23] = 100
            else
                f2_local0[1] = 100
                f2_local0[2] = 100
                f2_local0[4] = 50
                f2_local0[9] = 70
                f2_local0[11] = 100
                f2_local0[14] = 80
                f2_local0[23] = 1
                f2_local0[25] = 50
            end
        elseif f2_arg1:HasSpecialEffectId(TARGET_SELF, 3136900) then
            if f2_arg1:HasSpecialEffectId(TARGET_SELF, 3136901) then
                if f2_arg1:IsInsideTargetRegion(TARGET_ENE_0, 2002249) and f2_arg1:IsInsideTargetRegion(TARGET_SELF, 2002249) then
                    f2_local0[32] = 100
                elseif f2_arg1:IsInsideTargetRegion(TARGET_ENE_0, 2002250) and f2_arg1:IsInsideTargetRegion(TARGET_SELF, 2002250) then
                    f2_local0[34] = 100
                else
                    f2_local0[27] = 1
                    if f2_arg1:IsVisibleTarget(TARGET_ENE_0) then
                        f2_local0[13] = 0
                        f2_local0[18] = 1
                        f2_local0[33] = 150
                    end
                end
            elseif f2_local3 >= 5 then
                f2_local0[13] = 1
                f2_local0[18] = 100
                f2_local0[33] = 150
            else
                f2_local0[13] = 100
                f2_local0[18] = 100
                f2_local0[22] = 1
            end
        elseif f2_arg1:HasSpecialEffectId(TARGET_SELF, 3136910) then
            f2_local0[3] = 100
            f2_local0[12] = 100
            f2_local0[18] = 50
        elseif f2_arg1:IsLockOnTarget(TARGET_ENE_0, TARGET_SELF) or f2_arg1:IsFinishTimer(4) == false then
            if f2_local3 >= 8 then
                if f2_arg1:IsFinishTimer(4) == false then
                    f2_local0[7] = 100
                elseif f2_arg1:IsFinishTimer(3) == true then
                    f2_local0[4] = 1
                    f2_local0[7] = 10
                    f2_local0[19] = 100
                    f2_local0[22] = 10
                    f2_local0[27] = 10
                else
                    f2_local0[4] = 1
                    f2_local0[23] = 100
                    f2_local0[27] = 1
                end
            elseif f2_local3 >= 4 then
                if f2_arg1:IsFinishTimer(3) == true then
                    f2_local0[3] = 300
                    f2_local0[4] = 350
                    f2_local0[7] = 1
                    f2_local0[10] = 300
                    f2_local0[22] = 100
                else
                    f2_local0[3] = 100
                    f2_local0[4] = 100
                    f2_local0[7] = 1
                    f2_local0[23] = 50
                    f2_local0[27] = 1
                end
            elseif f2_local3 >= 2 then
                if f2_arg1:IsFinishTimer(3) == true then
                    f2_local0[1] = 300
                    f2_local0[2] = 300
                    f2_local0[3] = 150
                    f2_local0[4] = 350
                    f2_local0[9] = 300
                    f2_local0[11] = 150
                    f2_local0[14] = 300
                    f2_local0[22] = 100
                    if f2_local6 <= 35 then
                        f2_local0[5] = 100
                        f2_local0[13] = 100
                        f2_local0[18] = 100
                    end
                else
                    f2_local0[23] = 100
                    f2_local0[27] = 1
                end
            else
                f2_local0[1] = 300
                f2_local0[2] = 300
                f2_local0[4] = 350
                f2_local0[9] = 100
                f2_local0[11] = 100
                f2_local0[12] = 100
                f2_local0[14] = 200
                if f2_local6 <= 35 then
                    f2_local0[5] = 100
                    f2_local0[13] = 100
                    f2_local0[18] = 100
                end
            end
        elseif f2_arg1:IsFinishTimer(0) == false then
            if f2_local3 >= 5 then
                f2_local0[3] = 1
                f2_local0[19] = 100
            else
                f2_local0[3] = 1
                f2_local0[22] = 100
            end
        elseif f2_local3 >= 5 then
            f2_local0[19] = 500
            f2_local0[10] = 100
            f2_local0[1] = 1
            f2_local0[2] = 1
        elseif f2_local3 >= 3 then
            f2_local0[11] = 1
            f2_local0[12] = 1
            f2_local0[22] = 200
            f2_local0[4] = 100
            f2_local0[10] = 100
        else
            f2_local0[3] = 100
            f2_local0[11] = 1
            f2_local0[12] = 1
            f2_local0[18] = 1
            f2_local0[22] = 200
        end
    elseif f2_arg1:HasSpecialEffectId(TARGET_SELF, 3136900) then
        if f2_arg1:HasSpecialEffectId(TARGET_SELF, 3136901) then
            if f2_arg1:IsInsideTargetRegion(TARGET_ENE_0, 2002249) and f2_arg1:IsInsideTargetRegion(TARGET_SELF, 2002249) then
                f2_local0[32] = 100
            elseif f2_arg1:IsInsideTargetRegion(TARGET_ENE_0, 2002250) and f2_arg1:IsInsideTargetRegion(TARGET_SELF, 2002250) then
                f2_local0[34] = 100
            else
                f2_local0[27] = 1
                if f2_arg1:IsVisibleTarget(TARGET_ENE_0) then
                    f2_local0[13] = 0
                    f2_local0[18] = 1
                    f2_local0[33] = 150
                end
            end
        elseif f2_local3 >= 5 then
            f2_local0[13] = 1
            f2_local0[18] = 100
            f2_local0[33] = 150
        else
            f2_local0[13] = 100
            f2_local0[18] = 100
            f2_local0[22] = 1
        end
    elseif f2_arg1:IsFinishTimer(1) == false and f2_arg1:IsFinishTimer(3) == false then
        f2_local0[1] = 300
        f2_local0[2] = 300
        f2_local0[3] = 200
        f2_local0[5] = 300
        f2_local0[9] = 100
        f2_local0[23] = 50
        f2_local0[27] = 1
    elseif f2_arg1:IsFinishTimer(1) == false then
        if f2_local3 >= 5 then
            f2_local0[11] = 1
            f2_local0[12] = 1
            f2_local0[23] = 1000
            f2_local0[27] = 1
        else
            f2_local0[11] = 1
            f2_local0[12] = 1
            f2_local0[18] = 10000
            f2_local0[27] = 1
        end
    else
        f2_local0[20] = 100
    end
    if f2_arg1:HasSpecialEffectId(TARGET_SELF, 3136900) or f2_arg1:HasSpecialEffectId(TARGET_SELF, 3136901) then
        f2_local0[20] = 0
    end
    if SpaceCheck(f2_arg1, f2_arg2, 45, 3) == false and SpaceCheck(f2_arg1, f2_arg2, -45, 3) == false then
        f2_local0[10] = 0
        f2_local0[19] = 0
        f2_local0[22] = 0
    end
    if SpaceCheck(f2_arg1, f2_arg2, 90, 1) == false and SpaceCheck(f2_arg1, f2_arg2, -90, 1) == false then
        f2_local0[23] = 1
    end
    if SpaceCheck(f2_arg1, f2_arg2, 180, 3) == false then
        f2_local0[5] = 0
        f2_local0[13] = 0
        f2_local0[18] = 1
    end
    if SpaceCheck(f2_arg1, f2_arg2, 180, 1) == false then
        f2_local0[25] = 1
    end
    if f2_arg1:IsFinishTimer(2) == false then
        f2_local0[8] = 0
    end
    if 2.8 - f2_arg1:GetMapHitRadius(TARGET_SELF) <= f2_local3 then
        f2_local0[11] = 0
    end
    if f2_arg1:HasSpecialEffectId(TARGET_ENE_0, 109012) then
        f2_local0[6] = 0
        f2_local0[12] = 0
    end
    f2_local0[1] = SetCoolTime(f2_arg1, f2_arg2, 3000, 5, f2_local0[1], 1)
    f2_local0[2] = SetCoolTime(f2_arg1, f2_arg2, 3001, 5, f2_local0[2], 1)
    f2_local0[3] = SetCoolTime(f2_arg1, f2_arg2, 3002, 5, f2_local0[3], 1)
    f2_local0[4] = SetCoolTime(f2_arg1, f2_arg2, 3004, 8, f2_local0[4], 1)
    f2_local0[5] = SetCoolTime(f2_arg1, f2_arg2, 3005, 5, f2_local0[5], 1)
    f2_local0[6] = SetCoolTime(f2_arg1, f2_arg2, 3008, 5, f2_local0[6], 1)
    f2_local0[7] = SetCoolTime(f2_arg1, f2_arg2, 3010, 5, f2_local0[7], 1)
    f2_local0[7] = SetCoolTime(f2_arg1, f2_arg2, 3011, 5, f2_local0[7], 1)
    f2_local0[9] = SetCoolTime(f2_arg1, f2_arg2, 3003, 5, f2_local0[9], 1)
    f2_local0[10] = SetCoolTime(f2_arg1, f2_arg2, 3010, 5, f2_local0[10], 1)
    f2_local0[10] = SetCoolTime(f2_arg1, f2_arg2, 3011, 5, f2_local0[10], 1)
    f2_local0[10] = SetCoolTime(f2_arg1, f2_arg2, 5202, 5, f2_local0[10], 1)
    f2_local0[10] = SetCoolTime(f2_arg1, f2_arg2, 5203, 5, f2_local0[10], 1)
    f2_local0[11] = SetCoolTime(f2_arg1, f2_arg2, 3014, 5, f2_local0[11], 1)
    f2_local0[12] = SetCoolTime(f2_arg1, f2_arg2, 3017, 5, f2_local0[12], 1)
    f2_local0[13] = SetCoolTime(f2_arg1, f2_arg2, 3021, 5, f2_local0[13], 1)
    f2_local0[14] = SetCoolTime(f2_arg1, f2_arg2, 3019, 5, f2_local0[14], 1)
    f2_local0[18] = SetCoolTime(f2_arg1, f2_arg2, 3021, 5, f2_local0[18], 1)
    f2_local0[22] = SetCoolTime(f2_arg1, f2_arg2, 5202, 3, f2_local0[22], 1)
    f2_local0[22] = SetCoolTime(f2_arg1, f2_arg2, 5203, 3, f2_local0[22], 1)
    f2_local0[33] = SetCoolTime(f2_arg1, f2_arg2, 3010, 3, f2_local0[33], 1)
    f2_local0[33] = SetCoolTime(f2_arg1, f2_arg2, 3011, 3, f2_local0[33], 1)
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
    f2_local1[14] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act14)
    f2_local1[17] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act17)
    f2_local1[18] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act18)
    f2_local1[19] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act19)
    f2_local1[20] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act20)
    f2_local1[21] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act21)
    f2_local1[22] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act22)
    f2_local1[23] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act23)
    f2_local1[24] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act24)
    f2_local1[25] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act25)
    f2_local1[26] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act26)
    f2_local1[27] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act27)
    f2_local1[28] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act28)
    f2_local1[30] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act30)
    f2_local1[31] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act31)
    f2_local1[32] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act32)
    f2_local1[33] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act33)
    f2_local1[34] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act34)
    f2_local1[40] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act40)
    local f2_local7 = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.ActAfter_AdjustSpace)
    Common_Battle_Activate(f2_arg1, f2_arg2, f2_local0, f2_local1, f2_local7, f2_local2)
    
end

Goal.Act01 = function (f3_arg0, f3_arg1, f3_arg2)
    local f3_local0 = 3.5 - f3_arg0:GetMapHitRadius(TARGET_SELF)
    local f3_local1 = 0
    local f3_local2 = 3.5 - f3_arg0:GetMapHitRadius(TARGET_SELF) + 2
    local f3_local3 = 100
    local f3_local4 = 0
    local f3_local5 = 1.5
    local f3_local6 = 3
    Approach_Act_Flex(f3_arg0, f3_arg1, f3_local0, f3_local1, f3_local2, f3_local3, f3_local4, f3_local5, f3_local6)
    local f3_local7 = 0
    local f3_local8 = 0
    local f3_local9 = f3_arg0:GetRandam_Int(0, 100)
    if not f3_arg0:HasSpecialEffectId(TARGET_SELF, 3136030) then
        f3_arg1:AddSubGoal(GOAL_COMMON_ComboAttackTunableSpin, 10, 3035, TARGET_ENE_0, 9999, f3_local7, f3_local8, 0, 0)
    end
    f3_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3000, TARGET_ENE_0, 9999, 0, 0)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act02 = function (f4_arg0, f4_arg1, f4_arg2)
    local f4_local0 = 3.5 - f4_arg0:GetMapHitRadius(TARGET_SELF)
    local f4_local1 = 0
    local f4_local2 = 3.5 - f4_arg0:GetMapHitRadius(TARGET_SELF) + 2
    local f4_local3 = 100
    local f4_local4 = 0
    local f4_local5 = 1.5
    local f4_local6 = 3
    Approach_Act_Flex(f4_arg0, f4_arg1, f4_local0, f4_local1, f4_local2, f4_local3, f4_local4, f4_local5, f4_local6)
    local f4_local7 = 0
    local f4_local8 = 0
    local f4_local9 = f4_arg0:GetRandam_Int(0, 100)
    if not f4_arg0:HasSpecialEffectId(TARGET_SELF, 3136030) then
        f4_arg1:AddSubGoal(GOAL_COMMON_ComboAttackTunableSpin, 10, 3036, TARGET_ENE_0, 9999, f4_local7, f4_local8, 0, 0)
    end
    f4_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3001, TARGET_ENE_0, 9999, 0, 0)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act03 = function (f5_arg0, f5_arg1, f5_arg2)
    local f5_local0 = 5.2 - f5_arg0:GetMapHitRadius(TARGET_SELF)
    local f5_local1 = 0
    local f5_local2 = 5.2 - f5_arg0:GetMapHitRadius(TARGET_SELF) + 2
    local f5_local3 = 100
    local f5_local4 = 0
    local f5_local5 = 1.5
    local f5_local6 = 3
    Approach_Act_Flex(f5_arg0, f5_arg1, f5_local0, f5_local1, f5_local2, f5_local3, f5_local4, f5_local5, f5_local6)
    local f5_local7 = 2.2 - f5_arg0:GetMapHitRadius(TARGET_SELF)
    local f5_local8 = 0
    local f5_local9 = 0
    f5_arg1:AddSubGoal(GOAL_COMMON_ComboAttackTunableSpin, 10, 3038, TARGET_ENE_0, 9999, f5_local8, f5_local9, 0, 0)
    f5_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3002, TARGET_ENE_0, 9999, 0, 0)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act04 = function (f6_arg0, f6_arg1, f6_arg2)
    local f6_local0 = 0
    local f6_local1 = 0
    f6_arg0:AddObserveArea(1, TARGET_SELF, TARGET_ENE_0, AI_DIR_TYPE_F, 180, 4)
    f6_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 10, 3004, TARGET_ENE_0, 9999, f6_local0, f6_local1, 0, 0):TimingSetTimer(5, 7, AI_TIMING_SET__UPDATE_SUCCESS)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act05 = function (f7_arg0, f7_arg1, f7_arg2)
    local f7_local0 = 2.5 - f7_arg0:GetMapHitRadius(TARGET_SELF)
    local f7_local1 = 0
    local f7_local2 = 2.5 - f7_arg0:GetMapHitRadius(TARGET_SELF) + 2
    local f7_local3 = 100
    local f7_local4 = 0
    local f7_local5 = 1.5
    local f7_local6 = 3
    Approach_Act_Flex(f7_arg0, f7_arg1, f7_local0, f7_local1, f7_local2, f7_local3, f7_local4, f7_local5, f7_local6)
    local f7_local7 = 0
    local f7_local8 = 0
    f7_arg1:AddSubGoal(GOAL_COMMON_ComboAttackTunableSpin, 10, 3037, TARGET_ENE_0, 9999, f7_local7, f7_local8, 0, 0)
    f7_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3005, TARGET_ENE_0, 9999, 0, 0)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act06 = function (f8_arg0, f8_arg1, f8_arg2)
    local f8_local0 = 3.2 - f8_arg0:GetMapHitRadius(TARGET_SELF)
    local f8_local1 = 0
    local f8_local2 = 3.2 - f8_arg0:GetMapHitRadius(TARGET_SELF) + 2
    local f8_local3 = 100
    local f8_local4 = 0
    local f8_local5 = 1.5
    local f8_local6 = 3
    Approach_Act_Flex(f8_arg0, f8_arg1, f8_local0, f8_local1, f8_local2, f8_local3, f8_local4, f8_local5, f8_local6)
    local f8_local7 = 3 - f8_arg0:GetMapHitRadius(TARGET_SELF)
    local f8_local8 = 0
    local f8_local9 = 0
    f8_arg1:AddSubGoal(GOAL_COMMON_ComboAttackTunableSpin, 10, 3008, TARGET_ENE_0, f8_local7, f8_local8, f8_local9, 0, 0)
    f8_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3009, TARGET_ENE_0, 9999, 0, 0)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act07 = function (f9_arg0, f9_arg1, f9_arg2)
    local f9_local0 = 0
    local f9_local1 = 0
    local f9_local2 = f9_arg0:GetRandam_Int(0, 1)
    local f9_local3 = f9_arg0:GetRandam_Int(1, 100)
    local f9_local4 = 3011
    local f9_local5 = 3010
    if f9_local2 == 1 then
        local f9_local6 = 3010
        local f9_local7 = 3011
    else
        local f9_local6 = 3011
        local f9_local7 = 3010
    end
    f9_arg1:AddSubGoal(GOAL_COMMON_ComboAttackTunableSpin, 10, f9_local4, TARGET_ENE_0, 9999, f9_local0, f9_local1, 0, 0)
    if f9_local3 >= 70 then
        f9_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, f9_local5, TARGET_ENE_0, 9999, 0, 0)
    end
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act08 = function (f10_arg0, f10_arg1, f10_arg2)
    local f10_local0 = 0
    local f10_local1 = 0
    f10_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 10, 3015, TARGET_ENE_0, 9999, f10_local0, f10_local1, 0, 0):TimingSetTimer(2, 7, AI_TIMING_SET__UPDATE_SUCCESS)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act09 = function (f11_arg0, f11_arg1, f11_arg2)
    local f11_local0 = 2.2 - f11_arg0:GetMapHitRadius(TARGET_SELF)
    local f11_local1 = 0
    local f11_local2 = 2.2 - f11_arg0:GetMapHitRadius(TARGET_SELF) + 2
    local f11_local3 = 100
    local f11_local4 = 0
    local f11_local5 = 1.5
    local f11_local6 = 3
    Approach_Act_Flex(f11_arg0, f11_arg1, f11_local0, f11_local1, f11_local2, f11_local3, f11_local4, f11_local5, f11_local6)
    local f11_local7 = 0
    local f11_local8 = 0
    if not f11_arg0:HasSpecialEffectId(TARGET_SELF, 3136030) then
        f11_arg1:AddSubGoal(GOAL_COMMON_ComboAttackTunableSpin, 10, 3035, TARGET_ENE_0, 9999, f11_local7, f11_local8, 0, 0)
    end
    f11_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3003, TARGET_ENE_0, 9999, 0, 0)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act10 = function (f12_arg0, f12_arg1, f12_arg2)
    local f12_local0 = f12_arg0:GetRandam_Int(0, 1)
    if SpaceCheck(f12_arg0, f12_arg1, -45, 3) == true then
        if SpaceCheck(f12_arg0, f12_arg1, 45, 3) == true then
            if f12_arg0:IsInsideTargetEx(TARGET_ENE_0, TARGET_SELF, AI_DIR_TYPE_R, 180, 999) then
                f12_local0 = 1
            else
                f12_local0 = 0
            end
        else
            f12_local0 = 0
        end
    elseif SpaceCheck(f12_arg0, f12_arg1, 45, 3) == true then
        f12_local0 = 1
    else
    end
    local f12_local1 = 5202
    local f12_local2 = 3011
    local f12_local3 = 3010
    if f12_local0 == 0 then
        f12_local1 = 5203
        f12_local2 = 3010
        f12_local3 = 3011
    else
        f12_local1 = 5202
        f12_local2 = 3011
        f12_local3 = 3010
    end
    local f12_local4 = 1
    local f12_local5 = f12_arg0:GetRandam_Int(30, 45)
    local f12_local6 = 0
    local f12_local7 = 0
    local f12_local8 = f12_arg0:GetRandam_Int(1, 100)
    f12_arg0:SetNumber(10, f12_local0)
    f12_arg1:AddSubGoal(GOAL_COMMON_SpinStep, f12_local4, f12_local1, TARGET_ENE_0, f12_local6, AI_DIR_TYPE_L, 0)
    f12_arg1:AddSubGoal(GOAL_COMMON_ComboAttackTunableSpin, 10, f12_local2, TARGET_ENE_0, 9999, f12_local6, f12_local7, 0, 0)
    if f12_local8 >= 65 then
        f12_arg1:AddSubGoal(GOAL_COMMON_ComboRepeat, 10, f12_local3, TARGET_ENE_0, 9999, 0)
    elseif f12_local8 >= 35 then
        f12_arg1:AddSubGoal(GOAL_COMMON_SpinStep, f12_local4, f12_local1, TARGET_ENE_0, f12_local6, AI_DIR_TYPE_L, 0)
        f12_arg1:AddSubGoal(GOAL_COMMON_ComboAttackTunableSpin, 10, f12_local2, TARGET_ENE_0, 9999, f12_local6, f12_local7, 0, 0)
    end
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act11 = function (f13_arg0, f13_arg1, f13_arg2)
    local f13_local0 = 2.8 - f13_arg0:GetMapHitRadius(TARGET_SELF)
    local f13_local1 = 0
    local f13_local2 = 2.8 - f13_arg0:GetMapHitRadius(TARGET_SELF) + 2
    local f13_local3 = 100
    local f13_local4 = 0
    local f13_local5 = 1.5
    local f13_local6 = 3
    local f13_local7 = 0
    local f13_local8 = 0
    if not f13_arg0:HasSpecialEffectId(TARGET_SELF, 3136030) then
        f13_arg1:AddSubGoal(GOAL_COMMON_ComboAttackTunableSpin, 10, 3036, TARGET_ENE_0, 9999, f13_local7, f13_local8, 0, 0)
    end
    f13_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3014, TARGET_ENE_0, 9999, 0, 0)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act12 = function (f14_arg0, f14_arg1, f14_arg2)
    local f14_local0 = 1.5 - f14_arg0:GetMapHitRadius(TARGET_SELF)
    local f14_local1 = 0
    local f14_local2 = 1.5 - f14_arg0:GetMapHitRadius(TARGET_SELF) + 2
    local f14_local3 = 100
    local f14_local4 = 0
    local f14_local5 = 1.5
    local f14_local6 = 3
    local f14_local7 = f14_arg0:GetSp(TARGET_SELF)
    Approach_Act_Flex(f14_arg0, f14_arg1, f14_local0, f14_local1, f14_local2, f14_local3, f14_local4, f14_local5, f14_local6)
    local f14_local8 = 0
    local f14_local9 = 0
    f14_arg1:AddSubGoal(GOAL_COMMON_ComboAttackTunableSpin, 10, 3036, TARGET_ENE_0, 9999, f14_local8, f14_local9, 0, 0)
    if f14_local7 <= 35 then
        f14_arg1:AddSubGoal(GOAL_COMMON_ComboRepeat, 10, 3018, TARGET_ENE_0, 9999, 0)
    end
    f14_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3017, TARGET_ENE_0, 9999, 0, 0)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act13 = function (f15_arg0, f15_arg1, f15_arg2)
    local f15_local0 = f15_arg0:GetDist(TARGET_ENE_0)
    local f15_local1 = 0
    local f15_local2 = 0
    local f15_local3 = f15_arg0:GetRandam_Int(0, 1)
    local f15_local4 = f15_arg0:GetRandam_Int(1, 100)
    local f15_local5 = 3010
    local f15_local6 = 3011
    if f15_local3 == 0 then
        local f15_local7 = 3010
        local f15_local8 = 3011
    else
        local f15_local7 = 3011
        local f15_local8 = 3010
    end
    f15_arg1:AddSubGoal(GOAL_COMMON_ComboAttackTunableSpin, 10, 3021, TARGET_ENE_0, 9999, f15_local1, f15_local2, 0, 0)
    if f15_local0 <= 2 then
        f15_arg1:AddSubGoal(GOAL_COMMON_ComboRepeat, 10, 3021, TARGET_ENE_0, 9999, 0)
    end
    f15_arg1:AddSubGoal(GOAL_COMMON_ComboRepeat, 10, f15_local5, TARGET_ENE_0, 9999, 0):TimingSetTimer(3, 3, AI_TIMING_SET__ACTIVATE)
    if f15_local4 >= 70 then
        f15_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, f15_local6, TARGET_ENE_0, 9999, 0, 0)
    end
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act14 = function (f16_arg0, f16_arg1, f16_arg2)
    local f16_local0 = 3 - f16_arg0:GetMapHitRadius(TARGET_SELF)
    local f16_local1 = 0
    local f16_local2 = 3 - f16_arg0:GetMapHitRadius(TARGET_SELF) + 2
    local f16_local3 = 100
    local f16_local4 = 0
    local f16_local5 = 1.5
    local f16_local6 = 3
    Approach_Act_Flex(f16_arg0, f16_arg1, f16_local0, f16_local1, f16_local2, f16_local3, f16_local4, f16_local5, f16_local6)
    local f16_local7 = 0
    local f16_local8 = 0
    if not f16_arg0:HasSpecialEffectId(TARGET_SELF, 3136030) then
        f16_arg1:AddSubGoal(GOAL_COMMON_ComboAttackTunableSpin, 10, 3036, TARGET_ENE_0, 9999, f16_local7, f16_local8, 0, 0)
    end
    f16_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3019, TARGET_ENE_0, 9999, 0, 0)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act17 = function (f17_arg0, f17_arg1, f17_arg2)
    local f17_local0 = 0
    local f17_local1 = 0
    f17_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 10, 3020, TARGET_ENE_0, 9999, f17_local0, f17_local1, 0, 0)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act18 = function (f18_arg0, f18_arg1, f18_arg2)
    local f18_local0 = 0
    local f18_local1 = 0
    f18_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 10, 3021, TARGET_ENE_0, 9999, f18_local0, f18_local1, 0, 0):TimingSetTimer(3, 3, AI_TIMING_SET__ACTIVATE)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act19 = function (f19_arg0, f19_arg1, f19_arg2)
    local f19_local0 = 0
    local f19_local1 = 0
    local f19_local2 = 3022
    if f19_arg0:IsFinishTimer(0) == true then
        f19_arg0:SetTimer(0, 1.5)
        if SpaceCheck(f19_arg0, f19_arg1, -45, 3) == true then
            if SpaceCheck(f19_arg0, f19_arg1, 45, 3) == true then
                if f19_arg0:IsInsideTarget(TARGET_ENE_0, AI_DIR_TYPE_R, 180) then
                    f19_local2 = 3022
                    f19_arg0:SetNumber(0, 0)
                else
                    f19_local2 = 3025
                    f19_arg0:SetNumber(0, 1)
                end
            else
                f19_local2 = 3022
                f19_arg0:SetNumber(0, 0)
            end
        elseif SpaceCheck(f19_arg0, f19_arg1, 45, 6) == true then
            f19_local2 = 3025
            f19_arg0:SetNumber(0, 1)
            if false then
            end
        end
    else
        f19_arg0:SetTimer(4, 2)
        if f19_arg0:GetNumber(0) == 1 then
            f19_local2 = 3025
        else
            f19_local2 = 3022
        end
    end
    if not (f19_arg0:HasSpecialEffectId(TARGET_SELF, 3136900) and f19_arg0:HasSpecialEffectId(TARGET_SELF, 3136901)) then
        f19_arg0:AddObserveArea(0, TARGET_ENE_0, TARGET_SELF, AI_DIR_TYPE_B, 60, 8)
    end
    f19_arg1:AddSubGoal(GOAL_COMMON_ComboAttackTunableSpin, 10, f19_local2, TARGET_ENE_0, 9999, f19_local0, f19_local1, 0, 0)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act20 = function (f20_arg0, f20_arg1, f20_arg2)
    local f20_local0 = 4.5 - f20_arg0:GetMapHitRadius(TARGET_SELF)
    local f20_local1 = 0
    local f20_local2 = 4.5 - f20_arg0:GetMapHitRadius(TARGET_SELF) + 2
    local f20_local3 = 100
    local f20_local4 = 0
    local f20_local5 = 1.5
    local f20_local6 = 1.5
    Approach_Act_Flex(f20_arg0, f20_arg1, f20_local0, f20_local1, f20_local2, f20_local3, f20_local4, f20_local5, f20_local6)
    local f20_local7 = 0
    local f20_local8 = 0
    f20_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 10, 3016, TARGET_ENE_0, 9999, f20_local7, f20_local8, 0, 0):TimingSetTimer(1, 9, AI_TIMING_SET__ACTIVATE)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act21 = function (f21_arg0, f21_arg1, f21_arg2)
    local f21_local0 = 0.5
    local f21_local1 = 45
    f21_arg1:AddSubGoal(GOAL_COMMON_Turn, f21_local0, TARGET_ENE_0, f21_local1, -1, GOAL_RESULT_Success, true)
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
    
end

Goal.Act22 = function (f22_arg0, f22_arg1, f22_arg2)
    local f22_local0 = 3
    local f22_local1 = 0
    local f22_local2 = 5202
    local f22_local3 = 0
    if f22_arg0:IsFinishTimer(0) == true then
        f22_arg0:SetTimer(0, 1.5)
        if SpaceCheck(f22_arg0, f22_arg1, -45, 3) == true then
            if SpaceCheck(f22_arg0, f22_arg1, 45, 3) == true then
                if f22_arg0:IsInsideTarget(TARGET_ENE_0, AI_DIR_TYPE_R, 180) then
                    f22_local2 = 5202
                    f22_arg0:SetNumber(0, 0)
                else
                    f22_local2 = 5203
                    f22_arg0:SetNumber(0, 1)
                end
            else
                f22_local2 = 5202
                f22_arg0:SetNumber(0, 0)
            end
        elseif SpaceCheck(f22_arg0, f22_arg1, 45, 3) == true then
            f22_local2 = 5203
            f22_arg0:SetNumber(0, 1)
            if false then
            end
        end
    else
        f22_arg0:SetTimer(4, 2)
        if f22_arg0:GetNumber(0) == 1 then
            f22_local2 = 5203
        else
            f22_local2 = 5202
        end
    end
    if not (f22_arg0:HasSpecialEffectId(TARGET_SELF, 3136900) and f22_arg0:HasSpecialEffectId(TARGET_SELF, 3136901)) then
        f22_arg0:AddObserveArea(0, TARGET_ENE_0, TARGET_SELF, AI_DIR_TYPE_B, 60, 8)
    end
    f22_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 10, f22_local2, TARGET_ENE_0, 9999, f22_local1, f22_local3, 0, 0)
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
    
end

Goal.Act23 = function (f23_arg0, f23_arg1, f23_arg2)
    local f23_local0 = f23_arg0:GetRandam_Int(1, 100)
    local f23_local1 = -1
    local f23_local2 = f23_arg0:GetRandam_Int(0, 1)
    if SpaceCheck(f23_arg0, f23_arg1, -90, 0.5) == true then
        if SpaceCheck(f23_arg0, f23_arg1, 90, 0.5) == true then
            if f23_arg0:IsInsideTargetEx(TARGET_ENE_0, TARGET_SELF, AI_DIR_TYPE_R, 180, 999) then
                f23_local2 = 1
            else
                f23_local2 = 0
            end
        else
            f23_local2 = 0
        end
    elseif SpaceCheck(f23_arg0, f23_arg1, 90, 0.5) == true then
        f23_local2 = 1
    else
    end
    local f23_local3 = 2
    local f23_local4 = f23_arg0:GetRandam_Int(15, 45)
    f23_arg0:SetNumber(10, f23_local2)
    f23_arg0:AddObserveArea(2, TARGET_SELF, TARGET_ENE_0, AI_DIR_TYPE_F, 180, 4)
    f23_arg0:AddObserveArea(3, TARGET_SELF, TARGET_ENE_0, AI_DIR_TYPE_F, 180, 10)
    f23_arg1:AddSubGoal(GOAL_COMMON_SidewayMove, f23_local3, TARGET_ENE_0, f23_local2, f23_local4, true, true, f23_local1)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act24 = function (f24_arg0, f24_arg1, f24_arg2)
    local f24_local0 = f24_arg0:GetDist(TARGET_ENE_0)
    local f24_local1 = 3
    local f24_local2 = 0
    local f24_local3 = 5201
    if SpaceCheck(f24_arg0, f24_arg1, 180, 3) ~= true or SpaceCheck(f24_arg0, f24_arg1, 180, 3) ~= true or f24_local0 > 4 then
    else
        f24_local3 = 5211
        if false then
        else
        end
    end
    f24_arg1:AddSubGoal(GOAL_COMMON_SpinStep, f24_local1, f24_local3, TARGET_ENE_0, f24_local2, AI_DIR_TYPE_B, 0)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act25 = function (f25_arg0, f25_arg1, f25_arg2)
    local f25_local0 = f25_arg0:GetRandam_Float(2, 4)
    local f25_local1 = f25_arg0:GetRandam_Float(3, 7)
    local f25_local2 = f25_arg0:GetDist(TARGET_ENE_0)
    local f25_local3 = -1
    f25_arg1:AddSubGoal(GOAL_COMMON_LeaveTarget, f25_local0, TARGET_ENE_0, f25_local1, TARGET_ENE_0, true, f25_local3)
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
    
end

Goal.Act26 = function (f26_arg0, f26_arg1, f26_arg2)
    if f26_arg0:HasSpecialEffectId(TARGET_SELF, 200051) then
        f26_arg0:AddObserveArea(4, TARGET_SELF, TARGET_ENE_0, AI_DIR_TYPE_F, 180, 6)
    end
    f26_arg1:AddSubGoal(GOAL_COMMON_Wait, 0.5, TARGET_SELF, 0, 0, 0)
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
    
end

Goal.Act27 = function (f27_arg0, f27_arg1, f27_arg2)
    local f27_local0 = f27_arg0:GetRandam_Int(1, 100)
    if YousumiAct_SubGoal(f27_arg0, f27_arg1, true, 60, 30) == false then
        GetWellSpace_Odds = 0
        return GetWellSpace_Odds
    end
    local f27_local1 = 0
    local f27_local2 = SpaceCheck_SidewayMove(f27_arg0, f27_arg1, 1)
    if f27_local2 == 0 then
        f27_local1 = 0
    elseif f27_local2 == 1 then
        f27_local1 = 1
    elseif f27_local2 == 2 then
        if f27_local0 <= 50 then
            f27_local1 = 0
        else
            f27_local1 = 1
        end
    else
        f27_arg1:AddSubGoal(GOAL_COMMON_Wait, 1, TARGET_SELF, 0, 0, 0)
        GetWellSpace_Odds = 0
        return GetWellSpace_Odds
    end
    f27_arg0:SetNumber(10, f27_local1)
    f27_arg1:AddSubGoal(GOAL_COMMON_SidewayMove, 3, TARGET_ENE_0, f27_local1, f27_arg0:GetRandam_Int(30, 45), true, true, -1)
    return GET_WELL_SPACE_ODDS
    
end

Goal.Act28 = function (f28_arg0, f28_arg1, f28_arg2)
    local f28_local0 = f28_arg0:GetDist(TARGET_ENE_0)
    local f28_local1 = 1.5
    local f28_local2 = 1.5
    local f28_local3 = f28_arg0:GetRandam_Int(30, 45)
    local f28_local4 = -1
    local f28_local5 = f28_arg0:GetRandam_Int(0, 1)
    if f28_local0 <= 3 then
        f28_arg1:AddSubGoal(GOAL_COMMON_SidewayMove, f28_local1, TARGET_ENE_0, f28_local5, f28_local3, true, true, f28_local4)
    elseif f28_local0 <= 8 then
        f28_arg1:AddSubGoal(GOAL_COMMON_ApproachTarget, f28_local2, TARGET_ENE_0, 3, TARGET_SELF, true, -1)
    else
        f28_arg1:AddSubGoal(GOAL_COMMON_ApproachTarget, f28_local2, TARGET_ENE_0, 8, TARGET_SELF, false, -1)
    end
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
    
end

Goal.Act30 = function (f29_arg0, f29_arg1, f29_arg2)
    local f29_local0 = 0
    local f29_local1 = 0
    f29_arg1:AddSubGoal(GOAL_COMMON_ComboAttackTunableSpin, 10, 3000, TARGET_ENE_0, 9999, f29_local0, f29_local1, 0, 0)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act31 = function (f30_arg0, f30_arg1, f30_arg2)
    local f30_local0 = 10
    local f30_local1 = 0
    local f30_local2 = 10
    local f30_local3 = 100
    local f30_local4 = 0
    local f30_local5 = 1.5
    local f30_local6 = 3
    Approach_Act_Flex(f30_arg0, f30_arg1, f30_local0, f30_local1, f30_local2, f30_local3, f30_local4, f30_local5, f30_local6)
    local f30_local7 = 0
    local f30_local8 = 0
    f30_arg1:AddSubGoal(GOAL_COMMON_ComboAttackTunableSpin, 10, 3001, TARGET_ENE_0, 9999, f30_local7, f30_local8, 0, 0)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act32 = function (f31_arg0, f31_arg1, f31_arg2)
    local f31_local0 = 0
    local f31_local1 = 180
    local f31_local2 = f31_arg0:GetRandam_Int(1, 100)
    local f31_local3 = 2002246
    f31_local3 = 2002246
    f31_arg0:SetEventMoveTarget(f31_local3)
    local f31_local4 = f31_arg0:GetDist(POINT_EVENT)
    f31_arg1:AddSubGoal(GOAL_COMMON_ApproachTarget, 3, POINT_EVENT, 0.2, TARGET_SELF, false, -1)
    if f31_arg0:IsInsideTarget(TARGET_ENE_0, AI_DIR_TYPE_F, 360) then
        f31_arg1:AddSubGoal(GOAL_COMMON_Wait, 0.3, TARGET_ENE_0, 0, 0, 0)
    else
        f31_arg1:AddSubGoal(GOAL_COMMON_Turn, 0.3, TARGET_ENE_0, 0, 0, 0)
    end
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
    
end

Goal.Act33 = function (f32_arg0, f32_arg1, f32_arg2)
    local f32_local0 = 0
    local f32_local1 = 0
    f32_arg1:AddSubGoal(GOAL_COMMON_ComboAttackTunableSpin, 10, 3010, TARGET_ENE_0, 9999, f32_local0, f32_local1, 0, 0)
    f32_arg1:AddSubGoal(GOAL_COMMON_ComboRepeat, 10, 3011, TARGET_ENE_0, 9999, 0)
    f32_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3010, TARGET_ENE_0, 9999, 0, 0)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act34 = function (f33_arg0, f33_arg1, f33_arg2)
    local f33_local0 = 0
    local f33_local1 = 180
    local f33_local2 = f33_arg0:GetRandam_Int(1, 100)
    local f33_local3 = 2002247
    f33_local3 = 2002247
    f33_arg0:SetEventMoveTarget(f33_local3)
    local f33_local4 = f33_arg0:GetDist(POINT_EVENT)
    f33_arg1:AddSubGoal(GOAL_COMMON_ApproachTarget, 3, POINT_EVENT, 0.2, TARGET_SELF, false, -1)
    if f33_arg0:IsInsideTarget(TARGET_ENE_0, AI_DIR_TYPE_F, 360) then
        f33_arg1:AddSubGoal(GOAL_COMMON_Wait, 0.3, TARGET_ENE_0, 0, 0, 0)
    else
        f33_arg1:AddSubGoal(GOAL_COMMON_Turn, 0.3, TARGET_ENE_0, 0, 0, 0)
    end
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
    
end

Goal.Act40 = function (f34_arg0, f34_arg1, f34_arg2)
    local f34_local0 = 3.5
    local f34_local1 = f34_arg0:GetRandam_Int(30, 45)
    local f34_local2 = 0
    if SpaceCheck(f34_arg0, f34_arg1, -90, 1) == true then
        if SpaceCheck(f34_arg0, f34_arg1, 90, 1) == true then
            if f34_arg0:IsInsideTarget(TARGET_ENE_0, AI_DIR_TYPE_R, 180) then
                f34_local2 = 0
            else
                f34_local2 = 1
            end
        else
            f34_local2 = 0
        end
    elseif SpaceCheck(f34_arg0, f34_arg1, 90, 1) == true then
        f34_local2 = 1
    else
    end
    f34_arg1:AddSubGoal(GOAL_COMMON_SidewayMove, f34_local0, TARGET_ENE_0, f34_local2, f34_local1, true, true, -1)
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
    
end

Goal.Interrupt = function (f35_arg0, f35_arg1, f35_arg2)
    local f35_local0 = f35_arg1:GetHpRate(TARGET_SELF)
    local f35_local1 = f35_arg1:GetSpecialEffectActivateInterruptType(0)
    local f35_local2 = f35_arg1:GetDist(TARGET_ENE_0)
    local f35_local3 = f35_arg1:GetSp(TARGET_SELF)
    local f35_local4 = f35_arg1:GetRandam_Int(1, 100)
    if f35_arg1:IsLadderAct(TARGET_SELF) then
        return false
    end
    if not f35_arg1:HasSpecialEffectId(TARGET_SELF, 200004) then
        return false
    end
    if f35_arg1:IsInterupt(INTERUPT_ParryTiming) then
        return f35_arg0.Parry(f35_arg1, f35_arg2, 50, 0, -1)
    end
    if f35_arg1:IsInterupt(INTERUPT_ShootImpact) then
        return f35_arg0.ShootReaction(f35_arg1, f35_arg2)
    end
    if f35_arg1:IsInterupt(INTERUPT_Damaged) then
        return f35_arg0.Damaged(f35_arg1, f35_arg2)
    end
    if f35_arg1:IsInterupt(INTERUPT_Inside_ObserveArea) then
        if f35_arg1:IsInsideObserve(0) then
            f35_arg1:DeleteObserve(0)
            f35_arg2:ClearSubGoal()
            f35_arg2:AddSubGoal(GOAL_COMMON_EndureAttack, 0.8, 3016, TARGET_ENE_0, 9999, 0)
            return true
        end
        if f35_arg1:IsInsideObserve(2) then
            f35_arg1:DeleteObserve(2)
            f35_arg2:ClearSubGoal()
            f35_arg1:SetTimer(3, 0)
            f35_arg1:SetTimer(5, 0)
            f35_arg1:Replanning()
            return true
        end
        if f35_arg1:IsInsideObserve(4) then
            f35_arg1:DeleteObserve(4)
            f35_arg2:ClearSubGoal()
            f35_arg1:Replanning()
            return true
        end
    end
    if f35_arg1:IsInterupt(INTERUPT_Outside_ObserveArea) and f35_arg1:GetAreaObserveSlot(AI_AREAOBSERVE_INTERRUPT__OUTSIDE, 3) then
        f35_arg1:DeleteObserve(3)
        f35_arg2:ClearSubGoal()
        f35_arg1:SetTimer(3, 0)
        f35_arg1:SetTimer(5, 0)
        f35_arg1:Replanning()
        return true
    end
    if f35_arg1:IsInterupt(INTERUPT_ActivateSpecialEffect) and f35_local1 == 3136001 and f35_arg1:HasSpecialEffectId(TARGET_SELF, 3136000) then
        f35_arg2:ClearSubGoal()
        f35_arg2:AddSubGoal(GOAL_COMMON_ComboRepeat, 1, 3007, TARGET_ENE_0, 9999, 0):TimingSetTimer(3, 3, AI_TIMING_SET__ACTIVATE)
        if f35_arg1:IsFinishTimer(2) == true and f35_local3 <= 20 then
            f35_arg2:AddSubGoal(GOAL_COMMON_ComboFinal, 1, 3015, TARGET_ENE_0, 9999, TurnTime, FrontAngle, 0, 0):TimingSetTimer(2, 7, AI_TIMING_SET__UPDATE_SUCCESS):TimingSetTimer(3, 0, AI_TIMING_SET__UPDATE_SUCCESS)
        end
    end
    return false
    
end

Goal.Damaged = function (f36_arg0, f36_arg1, f36_arg2)
    local f36_local0 = 3
    return false
    
end

Goal.Parry = function (f37_arg0, f37_arg1, f37_arg2, f37_arg3, f37_arg4)
    local f37_local0 = f37_arg0:GetDist(TARGET_ENE_0)
    local f37_local1 = GetDist_Parry(f37_arg0)
    local f37_local2 = f37_arg0:GetRandam_Int(1, 100)
    local f37_local3 = f37_arg0:GetRandam_Int(1, 100)
    local f37_local4 = f37_arg0:GetRandam_Int(1, 100)
    local f37_local5 = f37_arg0:HasSpecialEffectId(TARGET_ENE_0, 109970)
    local f37_local6 = f37_arg0:HasSpecialEffectId(TARGET_ENE_0, COMMON_SP_EFFECT_PC_ATTACK_RUSH)
    local f37_local7 = -1
    if f37_arg0:HasSpecialEffectId(TARGET_SELF, 221000) then
        f37_local7 = 0
    elseif f37_arg0:HasSpecialEffectId(TARGET_SELF, 221001) then
        f37_local7 = 1
    elseif f37_arg0:HasSpecialEffectId(TARGET_SELF, 221002) then
        f37_local7 = 2
    end
    if f37_arg0:IsFinishTimer(AI_TIMER_PARRY_INTERVAL) == false then
        return false
    end
    if f37_local7 == -1 then
        return false
    end
    if f37_arg0:HasSpecialEffectId(TARGET_SELF, 220062) then
        return false
    end
    if f37_arg0:HasSpecialEffectId(TARGET_ENE_0, 110450) or f37_arg0:HasSpecialEffectId(TARGET_ENE_0, 110501) or f37_arg0:HasSpecialEffectId(TARGET_ENE_0, 110500) then
        return false
    end
    f37_arg0:SetTimer(AI_TIMER_PARRY_INTERVAL, 0.1)
    if f37_arg2 == nil then
        f37_arg2 = 50
    end
    if f37_arg3 == nil then
        f37_arg3 = 0
    end
    if f37_arg4 == nil then
        f37_arg4 = 0
    end
    if f37_arg0:IsInsideTarget(TARGET_ENE_0, AI_DIR_TYPE_F, 90) and f37_arg0:IsInsideTargetEx(TARGET_ENE_0, TARGET_SELF, AI_DIR_TYPE_F, 90, f37_local1) then
        if f37_arg0:HasSpecialEffectId(TARGET_SELF, 220063) and f37_local0 <= 4 then
            f37_arg1:ClearSubGoal()
            f37_arg1:AddSubGoal(GOAL_COMMON_EndureAttack, 0.1, 3102, TARGET_ENE_0, 9999, 0)
            return true
        elseif f37_local6 then
            f37_arg1:ClearSubGoal()
            f37_arg1:AddSubGoal(GOAL_COMMON_EndureAttack, 0.3, 3100, TARGET_ENE_0, 9999, 0)
            return true
        elseif f37_local5 then
            if f37_arg0:IsTargetGuard(TARGET_SELF) and ReturnKengekiSpecialEffect(f37_arg0) == false then
                return false
            else
                if f37_local7 == 2 then
                    return false
                elseif f37_local7 == 1 then
                    if f37_local2 <= 50 then
                        f37_arg1:ClearSubGoal()
                        f37_arg1:AddSubGoal(GOAL_COMMON_EndureAttack, 0.3, 3101, TARGET_ENE_0, 9999, 0)
                        return true
                    end
                elseif f37_local7 == 0 and f37_local2 <= 100 then
                    f37_arg1:ClearSubGoal()
                    f37_arg1:AddSubGoal(GOAL_COMMON_EndureAttack, 0.3, 3101, TARGET_ENE_0, 9999, 0)
                    return true
                end
                return false
            end
        elseif f37_arg0:HasSpecialEffectId(TARGET_ENE_0, 109980) and f37_arg4 ~= -1 and f37_local7 == 0 then
            if f37_arg4 == 1 then
                f37_arg1:ClearSubGoal()
                f37_arg1:AddSubGoal(GOAL_COMMON_SpinStep, 1, 5201, TARGET_ENE_0, 0, AI_DIR_TYPE_B, 0)
                return true
            else
                f37_arg1:ClearSubGoal()
                f37_arg1:AddSubGoal(GOAL_COMMON_SpinStep, 1, 5211, TARGET_ENE_0, 0, AI_DIR_TYPE_B, 0)
                return true
            end
        elseif f37_local3 <= Get_ConsecutiveGuardCount(f37_arg0) * f37_arg2 then
            f37_arg1:ClearSubGoal()
            f37_arg1:AddSubGoal(GOAL_COMMON_EndureAttack, 0.3, 3101, TARGET_ENE_0, 9999, 0)
            return true
        else
            f37_arg1:ClearSubGoal()
            f37_arg1:AddSubGoal(GOAL_COMMON_EndureAttack, 0.3, 3100, TARGET_ENE_0, 9999, 0)
            return true
        end
    elseif f37_arg0:IsInsideTargetEx(TARGET_ENE_0, TARGET_SELF, AI_DIR_TYPE_F, 90, f37_local1 + 1) then
        if f37_arg4 ~= -1 and f37_local4 <= f37_arg3 then
            if f37_arg4 == 1 then
                f37_arg1:ClearSubGoal()
                f37_arg1:AddSubGoal(GOAL_COMMON_SpinStep, 1, 5201, TARGET_ENE_0, 0, AI_DIR_TYPE_B, 0)
                return true
            else
                f37_arg1:ClearSubGoal()
                f37_arg1:AddSubGoal(GOAL_COMMON_SpinStep, 1, 5211, TARGET_ENE_0, 0, AI_DIR_TYPE_B, 0)
                return true
            end
        else
            return false
        end
    else
        return false
    end
    
end

Goal.ShootReaction = function (f38_arg0, f38_arg1)
    local f38_local0 = f38_arg0:GetDist(TARGET_ENE_0)
    if f38_arg0:IsInsideTargetEx(TARGET_ENE_0, TARGET_SELF, AI_DIR_TYPE_F, 20, 999) then
        if f38_local0 <= 30 then
            if f38_arg0:HasSpecialEffectId(TARGET_SELF, 3136030) then
                f38_arg1:ClearSubGoal()
                f38_arg1:AddSubGoal(GOAL_COMMON_EndureAttack, 0.1, 3102, TARGET_ENE_0, 9999, 0)
                return true
            else
                f38_arg1:ClearSubGoal()
                f38_arg1:AddSubGoal(GOAL_COMMON_EndureAttack, 0.1, 3100, TARGET_ENE_0, 9999, 0)
                return true
            end
        elseif f38_arg0:HasSpecialEffectId(TARGET_SELF, 3136030) then
            f38_arg1:ClearSubGoal()
            f38_arg1:AddSubGoal(GOAL_COMMON_EndureAttack, 0.1, 3102, TARGET_ENE_0, 9999, 0)
            return true
        else
            f38_arg1:ClearSubGoal()
            f38_arg1:AddSubGoal(GOAL_COMMON_Wait, 0.3, TARGET_SELF, 0, 0, 0)
            f38_arg1:AddSubGoal(GOAL_COMMON_EndureAttack, 0.1, 3100, TARGET_ENE_0, 9999, 0)
            return true
        end
    end
    return false
    
end

Goal.Kengeki_Activate = function (f39_arg0, f39_arg1, f39_arg2, f39_arg3)
    local f39_local0 = ReturnKengekiSpecialEffect(f39_arg1)
    if f39_local0 == 0 then
        return false
    end
    local f39_local1 = {}
    local f39_local2 = {}
    local f39_local3 = {}
    Common_Clear_Param(f39_local1, f39_local2, f39_local3)
    local f39_local4 = f39_arg1:GetDist(TARGET_ENE_0)
    local f39_local5 = f39_arg1:GetSp(TARGET_SELF)
    if f39_local0 == 200200 then
        if f39_local4 >= 1.5 then
            f39_local1[9] = 100
        elseif f39_local4 <= 0.2 then
            f39_local1[50] = 100
            if f39_local5 <= 35 then
                f39_local1[9] = 100
            end
        else
            f39_local1[1] = 100
            if f39_local5 <= 35 then
                f39_local1[9] = 100
            end
        end
    elseif f39_local0 == 200201 then
        if f39_local4 >= 1.5 then
            f39_local1[50] = 100
        elseif f39_local4 <= 0.2 then
            f39_local1[50] = 100
            if f39_local5 <= 35 then
                f39_local1[10] = 100
            end
        else
            f39_local1[2] = 100
            if f39_local5 <= 35 then
                f39_local1[10] = 100
            end
        end
    elseif f39_local0 == 200205 then
        if f39_local4 >= 1.5 then
            f39_local1[50] = 100
        elseif f39_local4 <= 0.2 then
            f39_local1[50] = 100
            if f39_local5 <= 35 then
                f39_local1[11] = 100
            end
        else
            f39_local1[3] = 100
            f39_local1[5] = 100
            f39_local1[7] = 200
            f39_local1[50] = 300
            if f39_local5 <= 35 then
                f39_local1[11] = 100
            end
        end
    elseif f39_local0 == 200206 then
        if f39_local4 >= 1.5 then
            f39_local1[50] = 100
        elseif f39_local4 <= 0.2 then
            f39_local1[50] = 100
            if f39_local5 <= 35 then
                f39_local1[10] = 100
            end
        else
            f39_local1[4] = 100
            f39_local1[6] = 100
            f39_local1[50] = 300
            if f39_local5 <= 35 then
                f39_local1[12] = 100
            end
        end
    elseif f39_local0 == 200210 then
        if f39_local4 >= 1.5 then
            f39_local1[50] = 100
        else
            f39_local1[11] = 50
            f39_local1[2] = 200
            f39_local1[8] = 200
        end
    elseif f39_local0 == 200211 then
        if f39_local4 >= 1.5 then
            f39_local1[50] = 100
        else
            f39_local1[12] = 50
            f39_local1[2] = 200
            f39_local1[8] = 200
        end
    elseif f39_local0 == 200215 then
        if f39_local4 >= 1.5 then
            f39_local1[50] = 100
        elseif f39_local4 <= 0.2 then
            f39_local1[50] = 100
            if f39_local5 <= 35 then
                f39_local1[11] = 10000
            end
        else
            f39_local1[3] = 100
            f39_local1[5] = 100
            f39_local1[7] = 200
            f39_local1[50] = 100
            if f39_local5 <= 35 then
                f39_local1[11] = 10000
            end
        end
    elseif f39_local0 == 200216 then
        if f39_local4 >= 1.5 then
            f39_local1[50] = 100
        elseif f39_local4 <= 0.2 then
            f39_local1[50] = 100
            if f39_local5 <= 35 then
                f39_local1[12] = 10000
            end
        else
            f39_local1[4] = 100
            f39_local1[6] = 100
            f39_local1[50] = 100
            if f39_local5 <= 35 then
                f39_local1[12] = 10000
            end
        end
    else
        f39_local1[50] = 100
    end
    if SpaceCheck(f39_arg1, f39_arg2, 180, 3) == false then
        f39_local1[8] = 0
        f39_local1[9] = 0
        f39_local1[10] = 0
        f39_local1[11] = 0
        f39_local1[12] = 0
    end
    f39_local2[1] = REGIST_FUNC(f39_arg1, f39_arg2, f39_arg0.Kengeki01)
    f39_local2[2] = REGIST_FUNC(f39_arg1, f39_arg2, f39_arg0.Kengeki02)
    f39_local2[3] = REGIST_FUNC(f39_arg1, f39_arg2, f39_arg0.Kengeki03)
    f39_local2[4] = REGIST_FUNC(f39_arg1, f39_arg2, f39_arg0.Kengeki04)
    f39_local2[5] = REGIST_FUNC(f39_arg1, f39_arg2, f39_arg0.Kengeki05)
    f39_local2[6] = REGIST_FUNC(f39_arg1, f39_arg2, f39_arg0.Kengeki06)
    f39_local2[7] = REGIST_FUNC(f39_arg1, f39_arg2, f39_arg0.Kengeki07)
    f39_local2[8] = REGIST_FUNC(f39_arg1, f39_arg2, f39_arg0.Kengeki08)
    f39_local2[9] = REGIST_FUNC(f39_arg1, f39_arg2, f39_arg0.Kengeki09)
    f39_local2[10] = REGIST_FUNC(f39_arg1, f39_arg2, f39_arg0.Kengeki10)
    f39_local2[11] = REGIST_FUNC(f39_arg1, f39_arg2, f39_arg0.Kengeki11)
    f39_local2[12] = REGIST_FUNC(f39_arg1, f39_arg2, f39_arg0.Kengeki12)
    f39_local2[50] = REGIST_FUNC(f39_arg1, f39_arg2, f39_arg0.NoAction)
    local f39_local6 = REGIST_FUNC(f39_arg1, f39_arg2, f39_arg0.ActAfter_AdjustSpace)
    return Common_Kengeki_Activate(f39_arg1, f39_arg2, f39_local1, f39_local2, f39_local6, f39_local3)
    
end

Goal.Kengeki01 = function (f40_arg0, f40_arg1, f40_arg2)
    f40_arg1:ClearSubGoal()
    f40_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 1, 3052, TARGET_ENE_0, 9999, 0, 0)
    
end

Goal.Kengeki02 = function (f41_arg0, f41_arg1, f41_arg2)
    local f41_local0 = f41_arg0:GetRandam_Int(1, 100)
    f41_arg1:ClearSubGoal()
    f41_arg1:AddSubGoal(GOAL_COMMON_ComboRepeat, 10, 3057, TARGET_ENE_0, 9999, 0)
    if f41_local0 <= 50 then
        f41_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3001, TARGET_ENE_0, 9999, 0, 0)
    else
        f41_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3017, TARGET_ENE_0, 9999, 0, 0)
    end
    
end

Goal.Kengeki03 = function (f42_arg0, f42_arg1, f42_arg2)
    f42_arg1:ClearSubGoal()
    f42_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 1, 3071, TARGET_ENE_0, 9999, 0, 0)
    
end

Goal.Kengeki04 = function (f43_arg0, f43_arg1, f43_arg2)
    f43_arg1:ClearSubGoal()
    f43_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 1, 3076, TARGET_ENE_0, 9999, 0, 0)
    
end

Goal.Kengeki05 = function (f44_arg0, f44_arg1, f44_arg2)
    f44_arg1:ClearSubGoal()
    f44_arg1:AddSubGoal(GOAL_COMMON_ComboRepeat, 1, 3072, TARGET_ENE_0, 9999, 0)
    if sp <= 35 then
        f44_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 1, 3018, TARGET_ENE_0, 9999, 0, 0)
    end
    
end

Goal.Kengeki06 = function (f45_arg0, f45_arg1, f45_arg2)
    f45_arg1:ClearSubGoal()
    f45_arg1:AddSubGoal(GOAL_COMMON_ComboRepeat, 1, 3077, TARGET_ENE_0, 9999, 0)
    f45_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 1, 3018, TARGET_ENE_0, 9999, 0, 0)
    
end

Goal.Kengeki07 = function (f46_arg0, f46_arg1, f46_arg2)
    f46_arg1:ClearSubGoal()
    f46_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 1, 3073, TARGET_ENE_0, 9999, 0, 0)
    
end

Goal.Kengeki08 = function (f47_arg0, f47_arg1, f47_arg2)
    f47_arg1:ClearSubGoal()
    f47_arg1:AddSubGoal(GOAL_COMMON_ComboRepeat, 10, 3056, TARGET_ENE_0, 9999, 0)
    f47_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3002, TARGET_ENE_0, 9999, 0, 0)
    
end

Goal.Kengeki09 = function (f48_arg0, f48_arg1, f48_arg2)
    local f48_local0 = f48_arg0:GetSp(TARGET_SELF)
    f48_arg1:ClearSubGoal()
    f48_arg1:AddSubGoal(GOAL_COMMON_ComboRepeat, 10, 3051, TARGET_ENE_0, 9999, 0):TimingSetTimer(3, 3, AI_TIMING_SET__ACTIVATE)
    if f48_arg0:IsFinishTimer(2) == true and f48_local0 <= 15 then
        f48_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3015, TARGET_ENE_0, 9999, TurnTime, FrontAngle, 0, 0):TimingSetTimer(2, 7, AI_TIMING_SET__UPDATE_SUCCESS)
    end
    
end

Goal.Kengeki10 = function (f49_arg0, f49_arg1, f49_arg2)
    local f49_local0 = f49_arg0:GetSp(TARGET_SELF)
    f49_arg1:ClearSubGoal()
    f49_arg1:AddSubGoal(GOAL_COMMON_ComboRepeat, 10, 3056, TARGET_ENE_0, 9999, 0):TimingSetTimer(3, 3, AI_TIMING_SET__ACTIVATE)
    if f49_arg0:IsFinishTimer(2) == true and f49_local0 <= 15 then
        f49_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3015, TARGET_ENE_0, 9999, TurnTime, FrontAngle, 0, 0):TimingSetTimer(2, 7, AI_TIMING_SET__UPDATE_SUCCESS)
    end
    
end

Goal.Kengeki11 = function (f50_arg0, f50_arg1, f50_arg2)
    local f50_local0 = f50_arg0:GetSp(TARGET_SELF)
    f50_arg1:ClearSubGoal()
    f50_arg1:AddSubGoal(GOAL_COMMON_ComboRepeat, 10, 3070, TARGET_ENE_0, 9999, 0):TimingSetTimer(3, 3, AI_TIMING_SET__ACTIVATE)
    if f50_arg0:IsFinishTimer(2) == true and f50_local0 <= 15 then
        f50_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3015, TARGET_ENE_0, 9999, TurnTime, FrontAngle, 0, 0):TimingSetTimer(2, 7, AI_TIMING_SET__UPDATE_SUCCESS)
    end
    
end

Goal.Kengeki12 = function (f51_arg0, f51_arg1, f51_arg2)
    local f51_local0 = f51_arg0:GetSp(TARGET_SELF)
    f51_arg1:ClearSubGoal()
    f51_arg1:AddSubGoal(GOAL_COMMON_ComboRepeat, 10, 3075, TARGET_ENE_0, 9999, 0):TimingSetTimer(3, 3, AI_TIMING_SET__ACTIVATE)
    if f51_arg0:IsFinishTimer(2) == true and f51_local0 <= 15 then
        f51_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3015, TARGET_ENE_0, 9999, TurnTime, FrontAngle, 0, 0):TimingSetTimer(2, 7, AI_TIMING_SET__UPDATE_SUCCESS)
    end
    
end

Goal.NoAction = function (f52_arg0, f52_arg1, f52_arg2)
    return -1
    
end

Goal.ActAfter_AdjustSpace = function (f53_arg0, f53_arg1, f53_arg2)
    
end

Goal.Update = function (f54_arg0, f54_arg1, f54_arg2)
    return Update_Default_NoSubGoal(f54_arg0, f54_arg1, f54_arg2)
    
end

Goal.Terminate = function (f55_arg0, f55_arg1, f55_arg2)
    
end


