RegisterTableGoal(GOAL_Busshi_Oni_702000_Battle, "GOAL_Busshi_Oni_702000_Battle")
REGISTER_GOAL_NO_UPDATE(GOAL_Busshi_Oni_702000_Battle, true)

Goal.Initialize = function (f1_arg0, f1_arg1, f1_arg2, f1_arg3)
    
end

Goal.Activate = function (f2_arg0, f2_arg1, f2_arg2)
    Init_Pseudo_Global(f2_arg1, f2_arg2)
    local f2_local0 = {}
    local f2_local1 = {}
    local f2_local2 = {}
    Common_Clear_Param(f2_local0, f2_local1, f2_local2)
    local f2_local3 = f2_arg1:GetHpRate(TARGET_SELF)
    local f2_local4 = f2_arg1:GetSp(TARGET_SELF)
    local f2_local5 = f2_arg1:GetDist(TARGET_ENE_0)
    local f2_local6 = f2_arg1:GetExcelParam(AI_EXCEL_THINK_PARAM_TYPE__thinkAttr_doAdmirer)
    local f2_local7 = f2_arg1:GetEventRequest()
    f2_arg1:AddObserveSpecialEffectAttribute(TARGET_SELF, 3702001)
    f2_arg1:AddObserveSpecialEffectAttribute(TARGET_SELF, 3702002)
    f2_arg1:AddObserveSpecialEffectAttribute(TARGET_SELF, 3702040)
    f2_arg1:AddObserveSpecialEffectAttribute(TARGET_SELF, 107900)
    f2_arg1:AddObserveSpecialEffectAttribute(TARGET_SELF, 5025)
    f2_arg1:AddObserveSpecialEffectAttribute(TARGET_SELF, 5026)
    f2_arg1:AddObserveSpecialEffectAttribute(TARGET_SELF, 5028)
    f2_arg1:AddObserveSpecialEffectAttribute(TARGET_SELF, 5029)
    f2_arg1:AddObserveSpecialEffectAttribute(TARGET_SELF, 5032)
    f2_arg1:AddObserveSpecialEffectAttribute(TARGET_SELF, 5033)
    f2_arg1:AddObserveSpecialEffectAttribute(TARGET_SELF, 5034)
    f2_arg1:AddObserveSpecialEffectAttribute(TARGET_SELF, 5035)
    f2_arg1:AddObserveSpecialEffectAttribute(TARGET_SELF, 5036)
    if f2_arg0.Kengeki_Activate(f2_arg0, f2_arg1, f2_arg2) then
        return
    end
    if f2_arg1:HasSpecialEffectId(TARGET_ENE_0, 109250) then
        f2_local0[23] = 50
        f2_local0[26] = 100
    elseif f2_local7 == 10 then
        if f2_local5 >= 9 then
            f2_local0[41] = 100
            f2_local0[43] = 100
        else
            f2_local0[40] = 100
            f2_local0[44] = 100
        end
    elseif f2_local7 == 20 then
        f2_local0[32] = 100
    elseif f2_arg1:HasSpecialEffectId(TARGET_ENE_0, 110060) or f2_arg1:HasSpecialEffectId(TARGET_ENE_0, 110010) then
        if f2_arg1:IsInsideTarget(TARGET_ENE_0, AI_DIR_TYPE_F, 90) then
            f2_local0[21] = 1
            f2_local0[28] = 100
        else
            f2_local0[21] = 100
        end
    elseif Common_ActivateAct(f2_arg1, f2_arg2, 0, 1) then
    elseif not f2_arg1:HasSpecialEffectId(TARGET_SELF, 5022) then
        f2_local0[45] = 100
    elseif f2_arg1:HasSpecialEffectId(TARGET_SELF, 3702001) and f2_arg1:GetNinsatsuNum() == 2 then
        f2_local0[31] = 100
    elseif f2_arg1:IsInsideTarget(TARGET_ENE_0, AI_DIR_TYPE_B, 180) then
        f2_local0[21] = 1
        f2_local0[22] = 500
        f2_local0[24] = 1
    elseif not f2_arg1:HasSpecialEffectId(TARGET_SELF, 5022) then
        f2_local0[45] = 100
    elseif f2_arg1:HasSpecialEffectId(TARGET_SELF, 3702001) then
        if f2_local5 >= 30 then
            if f2_arg1:IsFinishTimer(3) == true then
                f2_local0[3] = 300
            end
            f2_local0[11] = 10
            f2_local0[13] = 10
            f2_local0[35] = 680
        elseif f2_local5 >= 25 then
            if f2_arg1:IsFinishTimer(3) == true then
                f2_local0[3] = 300
            end
            f2_local0[11] = 100
            f2_local0[13] = 50
            f2_local0[35] = 550
        elseif f2_local5 >= 20 then
            if f2_arg1:IsFinishTimer(3) == true then
                f2_local0[1] = 30
                f2_local0[3] = 300
                f2_local0[5] = 20
                f2_local0[6] = 150
            end
            f2_local0[11] = 300
            f2_local0[13] = 200
        elseif f2_local5 >= 15 then
            if f2_arg1:IsFinishTimer(3) == true then
                f2_local0[1] = 20
                f2_local0[3] = 210
                f2_local0[5] = 20
                f2_local0[6] = 150
            end
            f2_local0[11] = 300
            f2_local0[13] = 200
        elseif f2_local5 >= 10 then
            if f2_arg1:IsFinishTimer(3) == true then
                f2_local0[1] = 20
                f2_local0[3] = 260
                f2_local0[5] = 20
                f2_local0[6] = 120
                f2_local0[8] = 130
            end
            f2_local0[11] = 300
            f2_local0[13] = 150
        elseif f2_local5 >= 5 then
            f2_local0[1] = 150
            f2_local0[5] = 450
            f2_local0[6] = 50
            f2_local0[8] = 350
            f2_local0[24] = 150
        elseif f2_local5 >= 3 then
            if f2_arg1:HasSpecialEffectId(TARGET_ENE_0, 3702085) then
                f2_local0[19] = 200
            end
            f2_local0[1] = 30
            f2_local0[2] = 310
            f2_local0[5] = 30
            f2_local0[8] = 30
            f2_local0[10] = 200 * f2_arg1:GetNumber(4)
            f2_local0[22] = 50
            f2_local0[24] = 150
            f2_local0[29] = 150 * f2_arg1:GetNumber(4)
        elseif f2_local5 >= 2 then
            if f2_arg1:HasSpecialEffectId(TARGET_ENE_0, 3702085) then
                f2_local0[19] = 200
            end
            f2_local0[2] = 70
            f2_local0[8] = 130
            f2_local0[10] = 200 * f2_arg1:GetNumber(4)
            f2_local0[17] = 200
            f2_local0[22] = 100
            f2_local0[24] = 200
            f2_local0[29] = 150 * f2_arg1:GetNumber(4)
        else
            if f2_arg1:HasSpecialEffectId(TARGET_ENE_0, 3702085) then
                f2_local0[19] = 300
            end
            f2_local0[8] = 150
            f2_local0[10] = 250 * f2_arg1:GetNumber(4)
            f2_local0[17] = 150
            f2_local0[22] = 150
            f2_local0[24] = 150
            f2_local0[29] = 150 * f2_arg1:GetNumber(4)
        end
    elseif not f2_arg1:HasSpecialEffectId(TARGET_SELF, 3702005) then
        if not f2_arg1:HasSpecialEffectId(TARGET_SELF, 5020) then
            if f2_local5 >= 30 then
                f2_local0[34] = 100
            elseif f2_local5 >= 15 then
                f2_local0[24] = 999
                f2_local0[34] = 1
            elseif f2_local5 >= 5 then
                f2_local0[10] = 499
                f2_local0[22] = 400
                f2_local0[24] = 100
                f2_local0[29] = 500
                f2_local0[34] = 1
            else
                f2_local0[10] = 499
                f2_local0[22] = 400
                f2_local0[24] = 100
                f2_local0[29] = 500
                f2_local0[34] = 1
            end
        elseif f2_local5 >= 35 then
            f2_local0[11] = 5
            f2_local0[13] = 5
            f2_local0[34] = 490
            f2_local0[35] = 100
            f2_local0[37] = 400
        elseif f2_local5 >= 30 then
            f2_local0[11] = 5
            f2_local0[13] = 5
            f2_local0[34] = 240
            f2_local0[35] = 100
            f2_local0[37] = 650
        elseif f2_local5 >= 25 then
            f2_local0[11] = 10
            f2_local0[13] = 10
            f2_local0[34] = 200
            f2_local0[35] = 450
            f2_local0[37] = 80
        elseif f2_local5 >= 20 then
            if f2_arg1:IsFinishTimer(3) == true then
                f2_local0[1] = 20
                f2_local0[5] = 20
                f2_local0[6] = 180
                f2_local0[9] = 350
            end
            f2_local0[11] = 200
            f2_local0[13] = 100
        elseif f2_local5 >= 15 then
            if f2_arg1:IsFinishTimer(3) == true then
                f2_local0[1] = 20
                f2_local0[5] = 20
                f2_local0[6] = 180
                f2_local0[9] = 230
            end
            f2_local0[11] = 150
            f2_local0[13] = 90
        elseif f2_local5 >= 10 then
            if f2_arg1:IsFinishTimer(3) == true then
                f2_local0[1] = 20
                f2_local0[5] = 20
                f2_local0[6] = 120
                f2_local0[8] = 130
                f2_local0[9] = 260
            end
            f2_local0[11] = 300
            f2_local0[13] = 150
        elseif f2_local5 >= 5 then
            f2_local0[1] = 50
            f2_local0[5] = 500
            f2_local0[6] = 50
            f2_local0[8] = 400
            f2_local0[24] = 100
        elseif f2_local5 >= 3 then
            if f2_arg1:HasSpecialEffectId(TARGET_ENE_0, 3702085) then
                f2_local0[19] = 200
            end
            f2_local0[1] = 30
            f2_local0[2] = 330
            f2_local0[5] = 30
            f2_local0[8] = 30
            f2_local0[10] = 200 * f2_arg1:GetNumber(4)
            f2_local0[22] = 30 * f2_arg1:GetNumber(4)
            f2_local0[24] = 150
            f2_local0[29] = 150 * f2_arg1:GetNumber(4)
        elseif f2_local5 >= 2 then
            if f2_arg1:HasSpecialEffectId(TARGET_ENE_0, 3702085) then
                f2_local0[19] = 200
            end
            f2_local0[2] = 70
            f2_local0[8] = 130
            f2_local0[10] = 150 * f2_arg1:GetNumber(4)
            f2_local0[17] = 150
            f2_local0[22] = 50
            f2_local0[24] = 100
            f2_local0[29] = 150 * f2_arg1:GetNumber(4)
        else
            if f2_arg1:HasSpecialEffectId(TARGET_ENE_0, 3702085) then
                f2_local0[19] = 200
            end
            f2_local0[8] = 200
            f2_local0[10] = 200 * f2_arg1:GetNumber(4)
            f2_local0[17] = 150
            f2_local0[22] = 100
            f2_local0[24] = 100
            f2_local0[29] = 150 * f2_arg1:GetNumber(4)
        end
    elseif not f2_arg1:HasSpecialEffectId(TARGET_SELF, 5021) then
        if f2_local5 >= 3 then
            f2_local0[12] = 100
        else
            f2_local0[12] = 50
            f2_local0[22] = 1
            f2_local0[24] = 150
        end
    elseif f2_local5 >= 35 then
        if f2_arg1:IsFinishTimer(5) == false then
            f2_local0[9] = 300
            f2_local0[3] = 500
        end
        f2_local0[11] = 5
        f2_local0[13] = 5
        f2_local0[34] = 240
        f2_local0[35] = 250
        f2_local0[37] = 500
    elseif f2_local5 >= 30 then
        if f2_arg1:IsFinishTimer(5) == false then
            f2_local0[9] = 500
            f2_local0[3] = 500
        end
        f2_local0[11] = 5
        f2_local0[13] = 5
        f2_local0[34] = 240
        f2_local0[35] = 350
        f2_local0[37] = 400
    elseif f2_local5 >= 25 then
        if f2_arg1:IsFinishTimer(5) == false then
            f2_local0[9] = 500
            f2_local0[3] = 500
        end
        f2_local0[11] = 60
        f2_local0[13] = 60
        f2_local0[34] = 250
        f2_local0[35] = 430
        f2_local0[37] = 200
    elseif f2_local5 >= 20 then
        if f2_arg1:IsFinishTimer(3) == true then
            f2_local0[9] = 250
        elseif f2_arg1:IsFinishTimer(5) == false then
            f2_local0[9] = 500
            f2_local0[3] = 500
        end
        f2_local0[11] = 180
        f2_local0[13] = 20
        f2_local0[35] = 150
    elseif f2_local5 >= 15 then
        if f2_arg1:IsFinishTimer(3) == true then
            f2_local0[1] = 10
            f2_local0[5] = 10
            f2_local0[6] = 100
            f2_local0[9] = 180
        end
        f2_local0[11] = 150
        f2_local0[12] = 150
        f2_local0[13] = 100
    elseif f2_local5 >= 10 then
        if f2_arg1:IsFinishTimer(3) == true then
            f2_local0[1] = 20
            f2_local0[5] = 20
            f2_local0[6] = 100
            f2_local0[8] = 100
            f2_local0[9] = 210
        end
        f2_local0[11] = 100
        f2_local0[12] = 180
        f2_local0[13] = 20
    elseif f2_local5 >= 5 then
        f2_local0[1] = 160
        f2_local0[5] = 190
        f2_local0[6] = 10
        f2_local0[8] = 140
        f2_local0[12] = 200
        f2_local0[36] = 200
        f2_local0[24] = 100
    elseif f2_local5 >= 3 then
        if f2_arg1:HasSpecialEffectId(TARGET_ENE_0, 3702085) then
            f2_local0[19] = 100
        end
        f2_local0[1] = 30
        f2_local0[2] = 180
        f2_local0[5] = 30
        f2_local0[8] = 30
        f2_local0[10] = 250 * f2_arg1:GetNumber(4)
        f2_local0[22] = 30
        f2_local0[36] = 150 * f2_arg1:GetNumber(4)
        f2_local0[24] = 50
        f2_local0[29] = 150 * f2_arg1:GetNumber(4)
    elseif f2_local5 >= 2 then
        if f2_arg1:HasSpecialEffectId(TARGET_ENE_0, 3702085) then
            f2_local0[19] = 100
        end
        f2_local0[2] = 50
        f2_local0[8] = 100
        f2_local0[10] = 250 * f2_arg1:GetNumber(4)
        f2_local0[22] = 50
        f2_local0[36] = 150 * f2_arg1:GetNumber(4)
        f2_local0[24] = 50
        f2_local0[29] = 150 * f2_arg1:GetNumber(4)
    else
        if f2_arg1:HasSpecialEffectId(TARGET_ENE_0, 3702085) then
            f2_local0[19] = 100
        end
        f2_local0[8] = 100
        f2_local0[10] = 250 * f2_arg1:GetNumber(4)
        f2_local0[22] = 50
        f2_local0[36] = 300 * f2_arg1:GetNumber(4)
        f2_local0[24] = 100
        f2_local0[29] = 150 * f2_arg1:GetNumber(4)
    end
    if SpaceCheck(f2_arg1, f2_arg2, 0, 15) == false then
        f2_local0[10] = 0
    end
    if SpaceCheck(f2_arg1, f2_arg2, 45, 15) == false and SpaceCheck(f2_arg1, f2_arg2, -45, 15) == false then
        f2_local0[22] = 0
    end
    if SpaceCheck(f2_arg1, f2_arg2, 90, 1) == false and SpaceCheck(f2_arg1, f2_arg2, -90, 1) == false then
        f2_local0[23] = 0
    end
    if SpaceCheck(f2_arg1, f2_arg2, 180, 15) == false then
        f2_local0[29] = 0
    end
    if SpaceCheck(f2_arg1, f2_arg2, 180, 1) == false then
        f2_local0[25] = 0
    end
    if f2_arg1:IsFinishTimer(5) == false then
        f2_local0[14] = 0
        f2_local0[29] = 0
        f2_local0[34] = 0
        f2_local0[35] = 0
        f2_local0[36] = 0
        f2_local0[37] = 0
    end
    f2_local0[1] = SetCoolTime(f2_arg1, f2_arg2, 3000, 20, f2_local0[1], 1)
    f2_local0[2] = SetCoolTime(f2_arg1, f2_arg2, 3005, 15, f2_local0[2], 1)
    f2_local0[3] = SetCoolTime(f2_arg1, f2_arg2, 3007, 20, f2_local0[3], 1)
    f2_local0[4] = SetCoolTime(f2_arg1, f2_arg2, 3008, 15, f2_local0[4], 1)
    f2_local0[5] = SetCoolTime(f2_arg1, f2_arg2, 3010, 20, f2_local0[5], 1)
    f2_local0[6] = SetCoolTime(f2_arg1, f2_arg2, 3015, 20, f2_local0[6], 1)
    f2_local0[7] = SetCoolTime(f2_arg1, f2_arg2, 3018, 10, f2_local0[7], 1)
    f2_local0[8] = SetCoolTime(f2_arg1, f2_arg2, 3019, 25, f2_local0[8], 1)
    f2_local0[9] = SetCoolTime(f2_arg1, f2_arg2, 3023, 20, f2_local0[9], 1)
    f2_local0[10] = SetCoolTime(f2_arg1, f2_arg2, 3025, 20, f2_local0[10], 1)
    f2_local0[10] = SetCoolTime(f2_arg1, f2_arg2, 3026, 10, f2_local0[10], 1)
    f2_local0[11] = SetCoolTime(f2_arg1, f2_arg2, 3032, 20, f2_local0[11], 1)
    f2_local0[12] = SetCoolTime(f2_arg1, f2_arg2, 3036, 40, f2_local0[12], 1)
    f2_local0[13] = SetCoolTime(f2_arg1, f2_arg2, 3037, 15, f2_local0[13], 1)
    f2_local0[14] = SetCoolTime(f2_arg1, f2_arg2, 3038, 50, f2_local0[14], 1)
    f2_local0[14] = SetCoolTime(f2_arg1, f2_arg2, 3042, 50, f2_local0[14], 1)
    f2_local0[15] = SetCoolTime(f2_arg1, f2_arg2, 3040, 10, f2_local0[15], 1)
    f2_local0[16] = SetCoolTime(f2_arg1, f2_arg2, 3041, 10, f2_local0[16], 1)
    f2_local0[17] = SetCoolTime(f2_arg1, f2_arg2, 3047, 15, f2_local0[17], 1)
    f2_local0[18] = SetCoolTime(f2_arg1, f2_arg2, 3045, 10, f2_local0[18], 1)
    f2_local0[19] = SetCoolTime(f2_arg1, f2_arg2, 3046, 30, f2_local0[19], 1)
    f2_local0[22] = SetCoolTime(f2_arg1, f2_arg2, 5202, 10, f2_local0[22], 1)
    f2_local0[22] = SetCoolTime(f2_arg1, f2_arg2, 5203, 10, f2_local0[22], 1)
    f2_local0[24] = SetCoolTime(f2_arg1, f2_arg2, 5201, 20, f2_local0[24], 1)
    f2_local0[24] = SetCoolTime(f2_arg1, f2_arg2, 5211, 10, f2_local0[24], 1)
    f2_local0[24] = SetCoolTime(f2_arg1, f2_arg2, 5202, 5, f2_local0[24], 1)
    f2_local0[24] = SetCoolTime(f2_arg1, f2_arg2, 5203, 5, f2_local0[24], 1)
    f2_local0[29] = SetCoolTime(f2_arg1, f2_arg2, 5201, 10, f2_local0[29], 1)
    f2_local0[29] = SetCoolTime(f2_arg1, f2_arg2, 5211, 20, f2_local0[29], 1)
    f2_local0[29] = SetCoolTime(f2_arg1, f2_arg2, 5202, 5, f2_local0[29], 1)
    f2_local0[29] = SetCoolTime(f2_arg1, f2_arg2, 5203, 5, f2_local0[29], 1)
    f2_local0[33] = SetCoolTime(f2_arg1, f2_arg2, 3036, 25, f2_local0[33], 1)
    f2_local0[34] = SetCoolTime(f2_arg1, f2_arg2, 3048, 20, f2_local0[34], 1)
    f2_local0[35] = SetCoolTime(f2_arg1, f2_arg2, 3049, 15, f2_local0[35], 1)
    f2_local0[36] = SetCoolTime(f2_arg1, f2_arg2, 3044, 30, f2_local0[36], 1)
    f2_local0[36] = SetCoolTime(f2_arg1, f2_arg2, 3036, 30, f2_local0[36], 1)
    f2_local0[37] = SetCoolTime(f2_arg1, f2_arg2, 3038, 30, f2_local0[37], 1)
    f2_local0[37] = SetCoolTime(f2_arg1, f2_arg2, 3042, 30, f2_local0[37], 1)
    f2_local0[40] = SetCoolTime(f2_arg1, f2_arg2, 3019, 5, f2_local0[40], 1)
    f2_local0[41] = SetCoolTime(f2_arg1, f2_arg2, 3032, 5, f2_local0[41], 1)
    f2_local0[42] = SetCoolTime(f2_arg1, f2_arg2, 3037, 5, f2_local0[42], 1)
    f2_local0[43] = SetCoolTime(f2_arg1, f2_arg2, 3010, 5, f2_local0[43], 1)
    f2_local0[44] = SetCoolTime(f2_arg1, f2_arg2, 3046, 5, f2_local0[44], 1)
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
    f2_local1[15] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act15)
    f2_local1[16] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act16)
    f2_local1[17] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act17)
    f2_local1[18] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act18)
    f2_local1[19] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act19)
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
    f2_local1[31] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act31)
    f2_local1[32] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act32)
    f2_local1[33] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act33)
    f2_local1[34] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act34)
    f2_local1[35] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act35)
    f2_local1[36] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act36)
    f2_local1[37] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act37)
    f2_local1[38] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act38)
    f2_local1[39] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act39)
    f2_local1[40] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act40)
    f2_local1[41] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act41)
    f2_local1[42] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act42)
    f2_local1[43] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act43)
    f2_local1[44] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act44)
    f2_local1[45] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act45)
    local f2_local8 = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.ActAfter_AdjustSpace)
    Common_Battle_Activate(f2_arg1, f2_arg2, f2_local0, f2_local1, f2_local8, f2_local2)
    
end

Goal.Act01 = function (f3_arg0, f3_arg1, f3_arg2)
    local f3_local0 = 10 - f3_arg0:GetMapHitRadius(TARGET_SELF)
    local f3_local1 = 10 - f3_arg0:GetMapHitRadius(TARGET_SELF) + 5
    local f3_local2 = 10 - f3_arg0:GetMapHitRadius(TARGET_SELF) + 10
    local f3_local3 = 100
    local f3_local4 = 0
    local f3_local5 = 1.5
    local f3_local6 = 3
    Approach_Act_Flex(f3_arg0, f3_arg1, f3_local0, f3_local1, f3_local2, f3_local3, f3_local4, f3_local5, f3_local6)
    local f3_local7 = 18 - f3_arg0:GetMapHitRadius(TARGET_SELF) + 10
    local f3_local8 = 11 - f3_arg0:GetMapHitRadius(TARGET_SELF) + 10
    local f3_local9 = 0
    local f3_local10 = 0
    f3_arg1:AddSubGoal(GOAL_COMMON_ComboAttackTunableSpin, 10, 3000, TARGET_ENE_0, 999, f3_local9, f3_local10, 0, 0):TimingSetNumber(4, f3_arg0:GetNumber(4) + 1, AI_TIMING_SET__ACTIVATE)
    f3_arg1:AddSubGoal(GOAL_COMMON_ComboRepeat, 10, 3001, TARGET_ENE_0, 999, 0)
    f3_arg1:AddSubGoal(GOAL_COMMON_ComboRepeat, 10, 3002, TARGET_ENE_0, 999, 0)
    if not f3_arg0:HasSpecialEffectId(TARGET_SELF, 3702001) then
        f3_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3092, TARGET_ENE_0, 9999, 0, 0)
    end
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act02 = function (f4_arg0, f4_arg1, f4_arg2)
    local f4_local0 = 7 - f4_arg0:GetMapHitRadius(TARGET_SELF)
    local f4_local1 = 7 - f4_arg0:GetMapHitRadius(TARGET_SELF) + 2
    local f4_local2 = 7 - f4_arg0:GetMapHitRadius(TARGET_SELF) + 2
    local f4_local3 = 100
    local f4_local4 = 0
    local f4_local5 = 1.5
    local f4_local6 = 3
    Approach_Act_Flex(f4_arg0, f4_arg1, f4_local0, f4_local1, f4_local2, f4_local3, f4_local4, f4_local5, f4_local6)
    local f4_local7 = 8 - f4_arg0:GetMapHitRadius(TARGET_SELF)
    local f4_local8 = 0
    local f4_local9 = 0
    f4_arg1:AddSubGoal(GOAL_COMMON_ComboAttackTunableSpin, 10, 3005, TARGET_ENE_0, f4_local7, f4_local8, f4_local9, 0, 0):TimingSetNumber(4, f4_arg0:GetNumber(4) + 1, AI_TIMING_SET__ACTIVATE)
    f4_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3006, TARGET_ENE_0, 9999, 0, 0)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act03 = function (f5_arg0, f5_arg1, f5_arg2)
    local f5_local0 = 30 - f5_arg0:GetMapHitRadius(TARGET_SELF)
    local f5_local1 = 30 - f5_arg0:GetMapHitRadius(TARGET_SELF) + 5
    local f5_local2 = 30 - f5_arg0:GetMapHitRadius(TARGET_SELF) + 10
    local f5_local3 = 100
    local f5_local4 = 0
    local f5_local5 = 1.5
    local f5_local6 = 3
    Approach_Act_Flex(f5_arg0, f5_arg1, f5_local0, f5_local1, f5_local2, f5_local3, f5_local4, f5_local5, f5_local6)
    local f5_local7 = 0
    local f5_local8 = 0
    f5_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 10, 3007, TARGET_ENE_0, 9999, f5_local7, f5_local8, 0, 0)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act04 = function (f6_arg0, f6_arg1, f6_arg2)
    local f6_local0 = 30 - f6_arg0:GetMapHitRadius(TARGET_SELF)
    local f6_local1 = 30 - f6_arg0:GetMapHitRadius(TARGET_SELF) + 5
    local f6_local2 = 30 - f6_arg0:GetMapHitRadius(TARGET_SELF) + 10
    local f6_local3 = 100
    local f6_local4 = 0
    local f6_local5 = 1.5
    local f6_local6 = 3
    local f6_local7 = f6_arg0:GetDist(TARGET_ENE_0)
    local f6_local8 = 0
    local f6_local9 = 0
    if f6_local7 <= 25 then
        f6_arg1:AddSubGoal(GOAL_COMMON_LeaveTarget, 1, TARGET_ENE_0, 25, TARGET_ENE_0, true, -1)
    end
    f6_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 10, 3008, TARGET_ENE_0, 9999, f6_local8, f6_local9, 0, 0)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act05 = function (f7_arg0, f7_arg1, f7_arg2)
    local f7_local0 = 10 - f7_arg0:GetMapHitRadius(TARGET_SELF)
    local f7_local1 = 10 - f7_arg0:GetMapHitRadius(TARGET_SELF) + 5
    local f7_local2 = 10 - f7_arg0:GetMapHitRadius(TARGET_SELF) + 10
    local f7_local3 = 100
    local f7_local4 = 0
    local f7_local5 = 1.5
    local f7_local6 = 3
    Approach_Act_Flex(f7_arg0, f7_arg1, f7_local0, f7_local1, f7_local2, f7_local3, f7_local4, f7_local5, f7_local6)
    local f7_local7 = 11 - f7_arg0:GetMapHitRadius(TARGET_SELF)
    local f7_local8 = 11 - f7_arg0:GetMapHitRadius(TARGET_SELF)
    local f7_local9 = 0
    local f7_local10 = 0
    f7_arg1:AddSubGoal(GOAL_COMMON_ComboAttackTunableSpin, 10, 3010, TARGET_ENE_0, f7_local7, f7_local9, f7_local10, 0, 0)
    f7_arg1:AddSubGoal(GOAL_COMMON_ComboRepeat, 10, 3011, TARGET_ENE_0, f7_local8, 0)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act06 = function (f8_arg0, f8_arg1, f8_arg2)
    local f8_local0 = 10 - f8_arg0:GetMapHitRadius(TARGET_SELF)
    local f8_local1 = 10 - f8_arg0:GetMapHitRadius(TARGET_SELF) + 5
    local f8_local2 = 10 - f8_arg0:GetMapHitRadius(TARGET_SELF) + 10
    local f8_local3 = 100
    local f8_local4 = 0
    local f8_local5 = 1.5
    local f8_local6 = 3
    Approach_Act_Flex(f8_arg0, f8_arg1, f8_local0, f8_local1, f8_local2, f8_local3, f8_local4, f8_local5, f8_local6)
    local f8_local7 = 10.1 - f8_arg0:GetMapHitRadius(TARGET_SELF)
    local f8_local8 = 8 - f8_arg0:GetMapHitRadius(TARGET_SELF)
    local f8_local9 = 0
    local f8_local10 = 0
    f8_arg1:AddSubGoal(GOAL_COMMON_ComboAttackTunableSpin, 10, 3015, TARGET_ENE_0, f8_local7, f8_local9, f8_local10, 0, 0)
    f8_arg1:AddSubGoal(GOAL_COMMON_ComboRepeat, 10, 3016, TARGET_ENE_0, 9999, 0)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act07 = function (f9_arg0, f9_arg1, f9_arg2)
    local f9_local0 = 10 - f9_arg0:GetMapHitRadius(TARGET_SELF)
    local f9_local1 = 10 - f9_arg0:GetMapHitRadius(TARGET_SELF) + 5
    local f9_local2 = 10 - f9_arg0:GetMapHitRadius(TARGET_SELF) + 10
    local f9_local3 = 100
    local f9_local4 = 0
    local f9_local5 = 1.5
    local f9_local6 = 3
    Approach_Act_Flex(f9_arg0, f9_arg1, f9_local0, f9_local1, f9_local2, f9_local3, f9_local4, f9_local5, f9_local6)
    local f9_local7 = 0
    local f9_local8 = 0
    f9_arg0:SetTimer(3, 15)
    f9_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 10, 3018, TARGET_ENE_0, 9999, f9_local7, f9_local8, 0, 0)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act08 = function (f10_arg0, f10_arg1, f10_arg2)
    local f10_local0 = 10 - f10_arg0:GetMapHitRadius(TARGET_SELF)
    local f10_local1 = 10 - f10_arg0:GetMapHitRadius(TARGET_SELF) + 5
    local f10_local2 = 10 - f10_arg0:GetMapHitRadius(TARGET_SELF) + 10
    local f10_local3 = 100
    local f10_local4 = 0
    local f10_local5 = 1.5
    local f10_local6 = 3
    Approach_Act_Flex(f10_arg0, f10_arg1, f10_local0, f10_local1, f10_local2, f10_local3, f10_local4, f10_local5, f10_local6)
    local f10_local7 = 0
    local f10_local8 = 0
    f10_arg1:AddSubGoal(GOAL_COMMON_ComboAttackTunableSpin, 10, 3019, TARGET_ENE_0, 8, f10_local7, f10_local8, 0, 0):TimingSetNumber(4, f10_arg0:GetNumber(4) + 1, AI_TIMING_SET__ACTIVATE):TimingSetTimer(6, 20, AI_TIMING_SET__ACTIVATE)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act09 = function (f11_arg0, f11_arg1, f11_arg2)
    local f11_local0 = 19 - f11_arg0:GetMapHitRadius(TARGET_SELF)
    local f11_local1 = 19 - f11_arg0:GetMapHitRadius(TARGET_SELF) + 5
    local f11_local2 = 19 - f11_arg0:GetMapHitRadius(TARGET_SELF) + 10
    local f11_local3 = 100
    local f11_local4 = 0
    local f11_local5 = 1.5
    local f11_local6 = 3
    Approach_Act_Flex(f11_arg0, f11_arg1, f11_local0, f11_local1, f11_local2, f11_local3, f11_local4, f11_local5, f11_local6)
    local f11_local7 = 0
    local f11_local8 = 0
    f11_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 10, 3023, TARGET_ENE_0, 9999, f11_local7, f11_local8, 0, 0)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act10 = function (f12_arg0, f12_arg1, f12_arg2)
    f12_arg1:AddSubGoal(GOAL_COMMON_ComboAttackTunableSpin, 10, 3025, TARGET_ENE_0, 9999, 0, 0, 0, 0)
    f12_arg0:SetNumber(4, 1)
    f12_arg0:SetTimer(3, 15)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act11 = function (f13_arg0, f13_arg1, f13_arg2)
    local f13_local0 = 20.5 - f13_arg0:GetMapHitRadius(TARGET_SELF)
    local f13_local1 = 20.5 - f13_arg0:GetMapHitRadius(TARGET_SELF) + 5
    local f13_local2 = 20.5 - f13_arg0:GetMapHitRadius(TARGET_SELF) + 10
    local f13_local3 = 100
    local f13_local4 = 0
    local f13_local5 = 1.5
    local f13_local6 = 3
    Approach_Act_Flex(f13_arg0, f13_arg1, f13_local0, f13_local1, f13_local2, f13_local3, f13_local4, f13_local5, f13_local6)
    local f13_local7 = 0
    local f13_local8 = 0
    f13_arg1:AddSubGoal(GOAL_COMMON_ComboAttackTunableSpin, 10, 3032, TARGET_ENE_0, 9999, 0, 0, 0, 0)
    f13_arg1:AddSubGoal(GOAL_COMMON_ComboRepeat, 10, 3033, TARGET_ENE_0, 9999, 0)
    f13_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3034, TARGET_ENE_0, 9999, 0, 0)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act12 = function (f14_arg0, f14_arg1, f14_arg2)
    local f14_local0 = 22 - f14_arg0:GetMapHitRadius(TARGET_SELF)
    local f14_local1 = 22 - f14_arg0:GetMapHitRadius(TARGET_SELF) + 5
    local f14_local2 = 22 - f14_arg0:GetMapHitRadius(TARGET_SELF) + 10
    local f14_local3 = 100
    local f14_local4 = 0
    local f14_local5 = 1.5
    local f14_local6 = 3
    local f14_local7 = f14_arg0:GetDist(TARGET_ENE_0)
    local f14_local8 = 1
    local f14_local9 = 0
    local f14_local10 = 5201
    if f14_local7 <= 3 and SpaceCheck(f14_arg0, f14_arg1, 180, 8) == true then
        f14_arg1:AddSubGoal(GOAL_COMMON_SpinStep, f14_local8, f14_local10, TARGET_ENE_0, f14_local9, AI_DIR_TYPE_B, 0)
    else
        Approach_Act_Flex(f14_arg0, f14_arg1, f14_local0, f14_local1, f14_local2, f14_local3, f14_local4, f14_local5, f14_local6)
    end
    local f14_local11 = 0
    local f14_local12 = 0
    f14_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 10, 3036, TARGET_ENE_0, 9999, f14_local11, f14_local12, 0, 0):TimingSetTimer(5, 20, AI_TIMING_SET__UPDATE_SUCCESS)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act13 = function (f15_arg0, f15_arg1, f15_arg2)
    local f15_local0 = 24 - f15_arg0:GetMapHitRadius(TARGET_SELF)
    local f15_local1 = 24 - f15_arg0:GetMapHitRadius(TARGET_SELF) + 5
    local f15_local2 = 24 - f15_arg0:GetMapHitRadius(TARGET_SELF) + 10
    local f15_local3 = 100
    local f15_local4 = 0
    local f15_local5 = 1.5
    local f15_local6 = 3
    Approach_Act_Flex(f15_arg0, f15_arg1, f15_local0, f15_local1, f15_local2, f15_local3, f15_local4, f15_local5, f15_local6)
    local f15_local7 = 0
    local f15_local8 = 0
    f15_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 10, 3037, TARGET_ENE_0, 9999, f15_local7, f15_local8, 0, 0)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act14 = function (f16_arg0, f16_arg1, f16_arg2)
    local f16_local0 = 30 - f16_arg0:GetMapHitRadius(TARGET_SELF)
    local f16_local1 = 30 - f16_arg0:GetMapHitRadius(TARGET_SELF) + 5
    local f16_local2 = 30 - f16_arg0:GetMapHitRadius(TARGET_SELF) + 10
    local f16_local3 = 100
    local f16_local4 = 0
    local f16_local5 = 1.5
    local f16_local6 = 3
    local f16_local7 = 0
    local f16_local8 = 0
    f16_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 10, 3038, TARGET_ENE_0, 9999, f16_local7, f16_local8, 0, 0):TimingSetTimer(4, 50, AI_TIMING_SET__UPDATE_ACTIVATE)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act15 = function (f17_arg0, f17_arg1, f17_arg2)
    f17_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 10, 3040, TARGET_ENE_0, 9999, 0, 0, 0, 0):TimingSetNumber(1, 1, AI_TIMING_SET__ACTIVATE)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act16 = function (f18_arg0, f18_arg1, f18_arg2)
    f18_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 10, 3041, TARGET_ENE_0, 9999, 0, 0, 0, 0):TimingSetNumber(1, 0, AI_TIMING_SET__ACTIVATE)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act17 = function (f19_arg0, f19_arg1, f19_arg2)
    f19_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 10, 3047, TARGET_ENE_0, 9999, 0, 0, 0, 0)
    f19_arg0:SetTimer(3, 15)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act18 = function (f20_arg0, f20_arg1, f20_arg2)
    f20_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 10, 3045, TARGET_ENE_0, 9999, 0, 0, 0, 0)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act19 = function (f21_arg0, f21_arg1, f21_arg2)
    f21_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 10, 3046, TARGET_ENE_0, 9999, 0, 0, 0, 0):TimingSetNumber(4, f21_arg0:GetNumber(4) + 2, AI_TIMING_SET__ACTIVATE)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act21 = function (f22_arg0, f22_arg1, f22_arg2)
    local f22_local0 = 3
    local f22_local1 = 45
    f22_arg1:AddSubGoal(GOAL_COMMON_Turn, f22_local0, TARGET_ENE_0, f22_local1, -1, GOAL_RESULT_Success, true)
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
    
end

Goal.Act22 = function (f23_arg0, f23_arg1, f23_arg2)
    local f23_local0 = 3
    local f23_local1 = 0
    local f23_local2 = 5202
    if SpaceCheck(f23_arg0, f23_arg1, -45, 15) == true then
        if SpaceCheck(f23_arg0, f23_arg1, 45, 15) == true then
            if f23_arg0:IsInsideTarget(TARGET_ENE_0, AI_DIR_TYPE_R, 180) then
                f23_local2 = 5202
            else
                f23_local2 = 5203
            end
        else
            f23_local2 = 5202
        end
    elseif SpaceCheck(f23_arg0, f23_arg1, 45, 15) == true then
        f23_local2 = 5203
    else
    end
    f23_arg1:AddSubGoal(GOAL_COMMON_SpinStep, f23_local0, f23_local2, TARGET_ENE_0, f23_local1, AI_DIR_TYPE_R, 0)
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
    
end

Goal.Act23 = function (f24_arg0, f24_arg1, f24_arg2)
    local f24_local0 = f24_arg0:GetDist(TARGET_ENE_0)
    local f24_local1 = f24_arg0:GetSp(TARGET_SELF)
    local f24_local2 = 20
    local f24_local3 = f24_arg0:GetRandam_Int(1, 100)
    local f24_local4 = -1
    local f24_local5 = 0
    if SpaceCheck(f24_arg0, f24_arg1, -90, 1) == true then
        if SpaceCheck(f24_arg0, f24_arg1, 90, 1) == true then
            if f24_arg0:IsInsideTargetEx(TARGET_ENE_0, TARGET_SELF, AI_DIR_TYPE_R, 180, 999) then
                f24_local5 = 1
            else
                f24_local5 = 0
            end
        else
            f24_local5 = 0
        end
    elseif SpaceCheck(f24_arg0, f24_arg1, 90, 1) == true then
        f24_local5 = 1
    else
    end
    local f24_local6 = 1
    local f24_local7 = f24_arg0:GetRandam_Int(30, 45)
    f24_arg0:SetNumber(10, f24_local5)
    f24_arg1:AddSubGoal(GOAL_COMMON_SidewayMove, f24_local6, TARGET_ENE_0, f24_local5, f24_local7, true, true, f24_local4)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act24 = function (f25_arg0, f25_arg1, f25_arg2)
    local f25_local0 = f25_arg0:GetDist(TARGET_ENE_0)
    local f25_local1 = 1
    local f25_local2 = 0
    local f25_local3 = 5201
    f25_arg1:AddSubGoal(GOAL_COMMON_SpinStep, f25_local1, f25_local3, TARGET_ENE_0, f25_local2, AI_DIR_TYPE_B, 0)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act25 = function (f26_arg0, f26_arg1, f26_arg2)
    local f26_local0 = f26_arg0:GetRandam_Float(2, 4)
    local f26_local1 = f26_arg0:GetRandam_Float(5, 7)
    local f26_local2 = f26_arg0:GetDist(TARGET_ENE_0)
    local f26_local3 = -1
    f26_arg1:AddSubGoal(GOAL_COMMON_LeaveTarget, f26_local0, TARGET_ENE_0, f26_local1, TARGET_ENE_0, true, f26_local3)
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
    
end

Goal.Act26 = function (f27_arg0, f27_arg1, f27_arg2)
    f27_arg1:AddSubGoal(GOAL_COMMON_Wait, 0.5, TARGET_SELF, 0, 0, 0)
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
    
end

Goal.Act27 = function (f28_arg0, f28_arg1, f28_arg2)
    local f28_local0 = f28_arg0:GetDist(TARGET_ENE_0)
    local f28_local1 = f28_arg0:GetDistYSigned(TARGET_ENE_0)
    local f28_local2 = f28_local1 / math.tan(math.deg(30))
    local f28_local3 = f28_arg0:GetRandam_Int(0, 1)
    if f28_local1 >= 5 then
        if f28_local2 + 1 <= f28_local0 then
            if SpaceCheck(f28_arg0, f28_arg1, 0, 4) == true then
                f28_arg1:AddSubGoal(GOAL_COMMON_ApproachTarget, 0.1, TARGET_ENE_0, f28_local2, TARGET_SELF, false, -1)
            elseif SpaceCheck(f28_arg0, f28_arg1, 0, 3) == true then
                f28_arg1:AddSubGoal(GOAL_COMMON_ApproachTarget, 0.5, TARGET_ENE_0, f28_local2, TARGET_SELF, true, -1)
            end
        elseif f28_local0 <= f28_local2 - 1 then
            f28_arg1:AddSubGoal(GOAL_COMMON_LeaveTarget, 10, TARGET_ENE_0, f28_local2, TARGET_ENE_0, true, -1)
        else
            f28_arg1:AddSubGoal(GOAL_COMMON_SidewayMove, 3, TARGET_ENE_0, f28_local3, f28_arg0:GetRandam_Int(30, 45), true, true, -1)
            f28_arg0:SetNumber(10, f28_local3)
        end
    elseif SpaceCheck(f28_arg0, f28_arg1, 0, 4) == true then
        f28_arg1:AddSubGoal(GOAL_COMMON_ApproachTarget, 0.1, TARGET_ENE_0, 10, TARGET_SELF, false, -1)
    elseif SpaceCheck(f28_arg0, f28_arg1, 0, 3) == true then
        f28_arg1:AddSubGoal(GOAL_COMMON_ApproachTarget, 0.5, TARGET_ENE_0, 10, TARGET_SELF, true, -1)
    elseif SpaceCheck(f28_arg0, f28_arg1, 0, 1) == false then
        f28_arg1:AddSubGoal(GOAL_COMMON_LeaveTarget, 0.5, TARGET_ENE_0, 999, TARGET_ENE_0, true, -1)
    else
        f28_arg1:AddSubGoal(GOAL_COMMON_SidewayMove, 3, TARGET_ENE_0, f28_local3, f28_arg0:GetRandam_Int(30, 45), true, true, -1)
        f28_arg0:SetNumber(10, f28_local3)
    end
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
    
end

Goal.Act28 = function (f29_arg0, f29_arg1, f29_arg2)
    local f29_local0 = f29_arg0:GetDist(TARGET_ENE_0)
    local f29_local1 = f29_arg0:GetRandam_Float(4.5, 5.5)
    local f29_local2 = 1.5
    local f29_local3 = f29_arg0:GetRandam_Int(30, 45)
    local f29_local4 = -1
    local f29_local5 = 0
    if f29_local0 <= 5 then
        f29_arg1:AddSubGoal(GOAL_COMMON_LeaveTarget, 4, TARGET_ENE_0, 10, TARGET_ENE_0, true, -1)
    elseif f29_local0 <= 15 then
        if SpaceCheck(f29_arg0, f29_arg1, -90, 1) == true then
            if SpaceCheck(f29_arg0, f29_arg1, 90, 1) == true then
                if f29_arg0:IsInsideTargetEx(TARGET_ENE_0, TARGET_SELF, AI_DIR_TYPE_R, 180, 999) then
                    f29_local5 = 1
                else
                    f29_local5 = 0
                end
            else
                f29_local5 = 0
            end
        elseif SpaceCheck(f29_arg0, f29_arg1, 90, 1) == true then
            f29_local5 = 1
        end
        f29_arg1:AddSubGoal(GOAL_COMMON_SidewayMove, f29_local1, TARGET_ENE_0, f29_local5, f29_local3, true, true, f29_local4)
    else
        f29_arg1:AddSubGoal(GOAL_COMMON_ApproachTarget, f29_local2, TARGET_ENE_0, 10, TARGET_SELF, true, -1)
    end
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
    
end

Goal.Act29 = function (f30_arg0, f30_arg1, f30_arg2)
    local f30_local0 = f30_arg0:GetDist(TARGET_ENE_0)
    local f30_local1 = 1
    local f30_local2 = 0
    local f30_local3 = 5211
    f30_arg1:AddSubGoal(GOAL_COMMON_SpinStep, f30_local1, f30_local3, TARGET_ENE_0, f30_local2, AI_DIR_TYPE_B, 0)
    f30_arg0:SetNumber(4, 1)
    f30_arg0:SetTimer(3, 15)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act30 = function (f31_arg0, f31_arg1, f31_arg2)
    local f31_local0 = 3
    local f31_local1 = 0
    local f31_local2 = 4.5
    local f31_local3 = f31_arg0:GetRandam_Int(30, 45)
    if SpaceCheck(f31_arg0, f31_arg1, 180, 5) then
        f31_arg1:AddSubGoal(GOAL_COMMON_SpinStep, f31_local0, 5201, TARGET_ENE_0, f31_local1, AI_DIR_TYPE_B, 0)
        f31_local2 = 3.5
    end
    local f31_local4 = 0
    if SpaceCheck(f31_arg0, f31_arg1, -90, 1) == true then
        if SpaceCheck(f31_arg0, f31_arg1, 90, 1) == true then
            if f31_arg0:IsInsideTarget(TARGET_ENE_0, AI_DIR_TYPE_R, 180) then
                f31_local4 = 0
            else
                f31_local4 = 1
            end
        else
            f31_local4 = 0
        end
    elseif SpaceCheck(f31_arg0, f31_arg1, 90, 1) == true then
        f31_local4 = 1
    else
    end
    f31_arg1:AddSubGoal(GOAL_COMMON_SidewayMove, f31_local2, TARGET_ENE_0, f31_local4, f31_local3, true, true, -1)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act31 = function (f32_arg0, f32_arg1, f32_arg2)
    f32_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 5, 20001, TARGET_ENE_0, 9999, 0, 0, 0, 0)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act32 = function (f33_arg0, f33_arg1, f33_arg2)
    local f33_local0 = f33_arg0:GetDist(TARGET_ENE_0)
    local f33_local1 = 3
    local f33_local2 = 3
    local f33_local3 = 3 + 2
    local f33_local4 = 100
    local f33_local5 = 0
    local f33_local6 = 1.5
    local f33_local7 = 3
    local f33_local8 = f33_arg0:GetRandam_Int(1, 100)
    if f33_arg0:GetNumber(10) == 0 then
        if not f33_arg0:HasSpecialEffectId(TARGET_SELF, 5025) then
            f33_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 2, 20010, POINT_EVENT, 0, 0, -1)
        else
            f33_arg1:AddSubGoal(GOAL_COMMON_Wait, 0.5, TARGET_SELF, 0, 0, 0)
        end
    elseif f33_arg0:GetNumber(10) == 2 then
        f33_arg1:AddSubGoal(GOAL_COMMON_ApproachSettingDirection, 3, TARGET_ENE_0, 2, TARGET_ENE_0, false, -1, AI_DIR_TYPE_ToL, 10)
    end
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act33 = function (f34_arg0, f34_arg1, f34_arg2)
    local f34_local0 = 0
    local f34_local1 = 0
    f34_arg1:AddSubGoal(GOAL_COMMON_ComboAttack_SuccessAngle180, 10, 3036, TARGET_ENE_0, 9999, 0)
    f34_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3037, TARGET_ENE_0, 9999, 0, 0)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act34 = function (f35_arg0, f35_arg1, f35_arg2)
    local f35_local0 = 1.5
    local f35_local1 = 3
    local f35_local2 = f35_arg0:GetDist(TARGET_ENE_0)
    f35_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 3, 3048, TARGET_ENE_0, 9999, 0, 0, 0, 0)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act35 = function (f36_arg0, f36_arg1, f36_arg2)
    local f36_local0 = 23 - f36_arg0:GetMapHitRadius(TARGET_SELF)
    local f36_local1 = 23 - f36_arg0:GetMapHitRadius(TARGET_SELF) + 5
    local f36_local2 = 23 - f36_arg0:GetMapHitRadius(TARGET_SELF) + 10
    local f36_local3 = 100
    local f36_local4 = 0
    local f36_local5 = 1.5
    local f36_local6 = 3
    local f36_local7 = f36_arg0:GetDist(TARGET_ENE_0)
    if f36_local7 >= 21 then
        Approach_Act_Flex(f36_arg0, f36_arg1, f36_local0 + 3, f36_local1, f36_local2, f36_local3, f36_local4, f36_local5, f36_local6)
    else
        f36_arg1:AddSubGoal(GOAL_COMMON_LeaveTarget, 1, TARGET_ENE_0, f36_local0, TARGET_ENE_0, true, -1)
    end
    f36_arg1:AddSubGoal(GOAL_COMMON_ComboAttack_SuccessAngle180, 2, 3049, TARGET_ENE_0, 9999, 0)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act36 = function (f37_arg0, f37_arg1, f37_arg2)
    local f37_local0 = f37_arg0:GetDist(TARGET_ENE_0)
    local f37_local1 = 5
    local f37_local2 = 10
    local f37_local3 = 20
    local f37_local4 = 100
    local f37_local5 = 0
    local f37_local6 = 1.5
    local f37_local7 = 3
    Approach_Act_Flex(f37_arg0, f37_arg1, f37_local1, f37_local2, f37_local3, f37_local4, f37_local5, f37_local6, f37_local7)
    f37_arg1:AddSubGoal(GOAL_COMMON_ComboAttackTunableSpin, 10, 3044, TARGET_ENE_0, 8, TurnTime, FrontAngle, 0, 0)
    f37_arg0:SetNumber(4, 1)
    f37_arg0:SetTimer(3, 15)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act37 = function (f38_arg0, f38_arg1, f38_arg2)
    local f38_local0 = f38_arg0:GetDist(TARGET_ENE_0)
    local f38_local1 = 1
    local f38_local2 = 0
    local f38_local3 = 5201
    local f38_local4 = f38_arg0:GetDist(TARGET_ENE_0)
    if f38_local4 >= 40 then
        Approach_Act_Flex(f38_arg0, f38_arg1, 35, 35, 35, 0, 0, 5, 5)
    elseif f38_local4 <= 15 then
        f38_arg1:AddSubGoal(GOAL_COMMON_SpinStep, f38_local1, 5201, TARGET_ENE_0, f38_local2, AI_DIR_TYPE_B, 0)
    end
    f38_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 3, 3042, TARGET_ENE_0, 9999, 0, 0, 0, 0):TimingSetTimer(4, 50, AI_TIMING_SET__UPDATE_ACTIVATE)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act38 = function (f39_arg0, f39_arg1, f39_arg2)
    local f39_local0 = 10 - f39_arg0:GetMapHitRadius(TARGET_SELF)
    local f39_local1 = 10 - f39_arg0:GetMapHitRadius(TARGET_SELF) + 5
    local f39_local2 = 10 - f39_arg0:GetMapHitRadius(TARGET_SELF) + 10
    local f39_local3 = 100
    local f39_local4 = 0
    local f39_local5 = 1.5
    local f39_local6 = 3
    local f39_local7 = 18 - f39_arg0:GetMapHitRadius(TARGET_SELF) + 10
    local f39_local8 = 11 - f39_arg0:GetMapHitRadius(TARGET_SELF) + 10
    local f39_local9 = 0
    local f39_local10 = 0
    f39_arg1:AddSubGoal(GOAL_COMMON_ComboAttackTunableSpin, 10, 3044, TARGET_ENE_0, 5, f39_local9, f39_local10, 0, 0)
    f39_arg1:AddSubGoal(GOAL_COMMON_ComboRepeat, 10, 3005, TARGET_ENE_0, 8, 0)
    f39_arg1:AddSubGoal(GOAL_COMMON_ComboRepeat, 10, 3006, TARGET_ENE_0, 999, 0)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act39 = function (f40_arg0, f40_arg1, f40_arg2)
    local f40_local0 = 10 - f40_arg0:GetMapHitRadius(TARGET_SELF)
    local f40_local1 = 10 - f40_arg0:GetMapHitRadius(TARGET_SELF) + 5
    local f40_local2 = 10 - f40_arg0:GetMapHitRadius(TARGET_SELF) + 10
    local f40_local3 = 100
    local f40_local4 = 0
    local f40_local5 = 1.5
    local f40_local6 = 3
    local f40_local7 = 18 - f40_arg0:GetMapHitRadius(TARGET_SELF) + 10
    local f40_local8 = 11 - f40_arg0:GetMapHitRadius(TARGET_SELF) + 10
    local f40_local9 = 0
    local f40_local10 = 0
    f40_arg1:AddSubGoal(GOAL_COMMON_ComboAttackTunableSpin, 10, 3044, TARGET_ENE_0, 5, f40_local9, f40_local10, 0, 0)
    f40_arg1:AddSubGoal(GOAL_COMMON_ComboRepeat, 10, 3046, TARGET_ENE_0, 8, 0)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act40 = function (f41_arg0, f41_arg1, f41_arg2)
    local f41_local0 = 10 - f41_arg0:GetMapHitRadius(TARGET_SELF)
    local f41_local1 = 10 - f41_arg0:GetMapHitRadius(TARGET_SELF) + 5
    local f41_local2 = 10 - f41_arg0:GetMapHitRadius(TARGET_SELF) + 10
    local f41_local3 = 100
    local f41_local4 = 0
    local f41_local5 = 1.5
    local f41_local6 = 3
    Approach_Act_Flex(f41_arg0, f41_arg1, f41_local0, f41_local1, f41_local2, f41_local3, f41_local4, f41_local5, f41_local6)
    local f41_local7 = 0
    local f41_local8 = 0
    f41_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 10, 3019, TARGET_ENE_0, 9999, f41_local7, f41_local8, 0, 0)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act41 = function (f42_arg0, f42_arg1, f42_arg2)
    local f42_local0 = 20.5 - f42_arg0:GetMapHitRadius(TARGET_SELF)
    local f42_local1 = 20.5 - f42_arg0:GetMapHitRadius(TARGET_SELF) + 5
    local f42_local2 = 20.5 - f42_arg0:GetMapHitRadius(TARGET_SELF) + 10
    local f42_local3 = 100
    local f42_local4 = 0
    local f42_local5 = 1.5
    local f42_local6 = 3
    Approach_Act_Flex(f42_arg0, f42_arg1, f42_local0, f42_local1, f42_local2, f42_local3, f42_local4, f42_local5, f42_local6)
    f42_arg1:AddSubGoal(GOAL_COMMON_ComboAttackTunableSpin, 10, 3032, TARGET_ENE_0, 9999, 0, 0, 0, 0)
    if f42_arg0:IsFinishTimer(6) == true then
        f42_arg1:AddSubGoal(GOAL_COMMON_ComboRepeat, 10, 3033, TARGET_ENE_0, 9999, 0):TimingSetTimer(6, 20, AI_TIMING_SET__ACTIVATE)
        f42_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3034, TARGET_ENE_0, 9999, 0, 0)
    end
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act42 = function (f43_arg0, f43_arg1, f43_arg2)
    local f43_local0 = 24 - f43_arg0:GetMapHitRadius(TARGET_SELF)
    local f43_local1 = 24 - f43_arg0:GetMapHitRadius(TARGET_SELF) + 5
    local f43_local2 = 24 - f43_arg0:GetMapHitRadius(TARGET_SELF) + 10
    local f43_local3 = 100
    local f43_local4 = 0
    local f43_local5 = 1.5
    local f43_local6 = 3
    Approach_Act_Flex(f43_arg0, f43_arg1, f43_local0, f43_local1, f43_local2, f43_local3, f43_local4, f43_local5, f43_local6)
    f43_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 10, 3037, TARGET_ENE_0, 9999, 0, 0, 0, 0)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act43 = function (f44_arg0, f44_arg1, f44_arg2)
    local f44_local0 = 10 - f44_arg0:GetMapHitRadius(TARGET_SELF)
    local f44_local1 = 10 - f44_arg0:GetMapHitRadius(TARGET_SELF) + 5
    local f44_local2 = 10 - f44_arg0:GetMapHitRadius(TARGET_SELF) + 10
    local f44_local3 = 100
    local f44_local4 = 0
    local f44_local5 = 1.5
    local f44_local6 = 3
    Approach_Act_Flex(f44_arg0, f44_arg1, f44_local0, f44_local1, f44_local2, f44_local3, f44_local4, f44_local5, f44_local6)
    local f44_local7 = 11 - f44_arg0:GetMapHitRadius(TARGET_SELF)
    local f44_local8 = 11 - f44_arg0:GetMapHitRadius(TARGET_SELF)
    local f44_local9 = 0
    local f44_local10 = 0
    f44_arg1:AddSubGoal(GOAL_COMMON_ComboAttackTunableSpin, 10, 3010, TARGET_ENE_0, f44_local7, f44_local9, f44_local10, 0, 0)
    f44_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3011, TARGET_ENE_0, 9999, 0, 0)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act44 = function (f45_arg0, f45_arg1, f45_arg2)
    local f45_local0 = 0
    local f45_local1 = 0
    f45_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 10, 3046, TARGET_ENE_0, 9999, f45_local0, f45_local1, 0, 0)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act45 = function (f46_arg0, f46_arg1, f46_arg2)
    local f46_local0 = f46_arg0:GetDist(TARGET_ENE_0)
    local f46_local1 = 1
    local f46_local2 = 0
    local f46_local3 = 5201
    if f46_local0 <= 5 and SpaceCheck(f46_arg0, f46_arg1, 180, 15) == true then
        f46_arg1:AddSubGoal(GOAL_COMMON_SpinStep, f46_local1, f46_local3, TARGET_ENE_0, f46_local2, AI_DIR_TYPE_B, 0)
    end
    local f46_local4 = 0
    local f46_local5 = 0
    f46_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 10, 3056, TARGET_ENE_0, 9999, f46_local4, f46_local5, 0, 0)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Interrupt = function (f47_arg0, f47_arg1, f47_arg2)
    local f47_local0 = f47_arg1:GetSpecialEffectActivateInterruptType(0)
    local f47_local1 = f47_arg1:GetDist(TARGET_ENE_0)
    local f47_local2 = f47_arg1:GetRandam_Int(1, 100)
    if f47_arg1:IsLadderAct(TARGET_SELF) then
        return false
    end
    if not f47_arg1:HasSpecialEffectId(TARGET_SELF, 200004) then
        return false
    end
    if f47_arg1:IsInterupt(INTERUPT_ActivateSpecialEffect) then
        if f47_arg1:GetSpecialEffectActivateInterruptType(0) == 5025 and f47_local1 <= 2 then
            if f47_local1 >= 0 and f47_local2 >= 21 then
                f47_arg2:ClearSubGoal()
                f47_arg2:AddSubGoal(GOAL_COMMON_ComboRepeat, 10, 3011, TARGET_ENE_0, 9999, 0)
            else
                f47_arg1:Replanning()
            end
        elseif f47_arg1:GetSpecialEffectActivateInterruptType(0) == 5026 and f47_local1 <= 2.5 then
            if f47_local1 >= 0 and f47_arg1:IsFinishTimer(6) == true then
                f47_arg2:ClearSubGoal()
                f47_arg2:AddSubGoal(GOAL_COMMON_ComboRepeat, 8, 3019, TARGET_ENE_0, 9999, 0):TimingSetTimer(6, 20, AI_TIMING_SET__ACTIVATE)
            else
                f47_arg1:Replanning()
            end
        elseif f47_arg1:GetSpecialEffectActivateInterruptType(0) == 5027 and f47_local1 <= 3 then
            f47_arg1:Replanning()
        elseif f47_arg1:GetSpecialEffectActivateInterruptType(0) == 5036 and f47_local1 <= 6 then
            if f47_arg1:HasSpecialEffectId(TARGET_SELF, 3702001) or f47_arg1:IsFinishTimer(3) == false then
                f47_arg1:Replanning()
            else
                f47_arg2:ClearSubGoal()
                f47_arg2:AddSubGoal(GOAL_COMMON_ComboRepeat, 10, 3025, TARGET_ENE_0, 9999, 0):TimingSetTimer(3, 15, AI_TIMING_SET__UPDATE_SUCCESS)
            end
        elseif f47_arg1:GetSpecialEffectActivateInterruptType(0) == 5028 and f47_local1 <= 6 then
            if f47_arg1:HasSpecialEffectId(TARGET_SELF, 3702005) and f47_arg1:IsFinishTimer(3) == true then
                f47_arg2:ClearSubGoal()
                f47_arg2:AddSubGoal(GOAL_COMMON_ComboRepeat, 10, 3025, TARGET_ENE_0, 9999, 0):TimingSetTimer(3, 15, AI_TIMING_SET__UPDATE_SUCCESS)
            else
                f47_arg1:Replanning()
            end
        elseif f47_arg1:GetSpecialEffectActivateInterruptType(0) == 5029 and f47_local1 <= 10 then
            if f47_arg1:HasSpecialEffectId(TARGET_SELF, 3702005) and f47_arg1:IsFinishTimer(3) == true then
                f47_arg2:ClearSubGoal()
                f47_arg2:AddSubGoal(GOAL_COMMON_ComboRepeat, 10, 3025, TARGET_ENE_0, 9999, 0):TimingSetTimer(3, 15, AI_TIMING_SET__UPDATE_SUCCESS)
            else
                f47_arg1:Replanning()
            end
        elseif f47_arg1:GetSpecialEffectActivateInterruptType(0) == 5032 and f47_local1 <= 0.5 then
            f47_arg1:Replanning()
        elseif f47_arg1:GetSpecialEffectActivateInterruptType(0) == 5034 then
            if f47_local1 >= 18 then
                f47_arg1:Replanning()
            elseif f47_local1 >= 10 then
                f47_arg2:ClearSubGoal()
                f47_arg2:AddSubGoal(GOAL_COMMON_ComboRepeat, 10, 3039, TARGET_ENE_0, 18, 0)
            else
                f47_arg1:Replanning()
            end
        elseif f47_arg1:GetSpecialEffectActivateInterruptType(0) == 5035 and f47_arg1:HasSpecialEffectId(TARGET_SELF, 3702005) then
            if f47_local1 >= 14 then
                f47_arg1:Replanning()
            elseif f47_local1 >= 5 then
                f47_arg2:ClearSubGoal()
                f47_arg2:AddSubGoal(GOAL_COMMON_ComboRepeat, 10, 3052, TARGET_ENE_0, 18, 0)
            else
                f47_arg1:Replanning()
            end
        elseif f47_arg1:GetSpecialEffectActivateInterruptType(0) == 5033 then
            if f47_arg1:IsFinishTimer(5) == false then
                if f47_local1 <= 45 then
                    f47_arg2:ClearSubGoal()
                    f47_arg2:AddSubGoal(GOAL_COMMON_ComboRepeat, 10, 3026, TARGET_ENE_0, 9999, 0)
                else
                    f47_arg1:Replanning()
                end
            elseif f47_arg1:HasSpecialEffectId(TARGET_SELF, 3702001) then
                if f47_local1 <= 19 then
                    f47_arg1:Replanning()
                elseif f47_local1 <= 23 then
                    f47_arg2:ClearSubGoal()
                    f47_arg2:AddSubGoal(GOAL_COMMON_ComboRepeat, 10, 3049, TARGET_ENE_0, 9999, 0)
                else
                    f47_arg1:Replanning()
                end
            elseif not f47_arg1:HasSpecialEffectId(TARGET_SELF, 5020) then
                f47_arg2:ClearSubGoal()
                f47_arg2:AddSubGoal(GOAL_COMMON_ComboRepeat, 10, 3048, TARGET_ENE_0, 9999, 0)
            elseif f47_local1 <= 20 then
                if f47_arg1:HasSpecialEffectId(TARGET_SELF, 3702005) then
                    f47_arg2:ClearSubGoal()
                    f47_arg2:AddSubGoal(GOAL_COMMON_ComboRepeat, 10, 3026, TARGET_ENE_0, 9999, 0)
                else
                    f47_arg1:Replanning()
                end
            elseif f47_local1 <= 23 then
                f47_arg2:ClearSubGoal()
                f47_arg2:AddSubGoal(GOAL_COMMON_ComboRepeat, 10, 3049, TARGET_ENE_0, 9999, 0)
            elseif f47_local2 >= 40 then
                f47_arg2:ClearSubGoal()
                f47_arg2:AddSubGoal(GOAL_COMMON_ComboRepeat, 10, 3048, TARGET_ENE_0, 9999, 0)
            else
                f47_arg1:Replanning()
            end
        end
    end
    return false
    
end

Goal.Parry = function (f48_arg0, f48_arg1, f48_arg2)
    local f48_local0 = f48_arg0:GetHpRate(TARGET_SELF)
    local f48_local1 = f48_arg0:GetDist(TARGET_ENE_0)
    local f48_local2 = f48_arg0:GetSp(TARGET_SELF)
    local f48_local3 = f48_arg0:GetRandam_Int(1, 100)
    local f48_local4 = 0
    if not f48_arg0:IsInsideTarget(TARGET_ENE_0, AI_DIR_TYPE_F, 90) or not f48_arg0:IsInsideTargetEx(TARGET_ENE_0, TARGET_SELF, AI_DIR_TYPE_F, 90, 3) or f48_arg0:HasSpecialEffectId(TARGET_ENE_0, 109012) then
    elseif f48_arg0:IsTargetGuard(TARGET_SELF) then
        if f48_arg0:HasSpecialEffectId(TARGET_ENE_0, 109970) then
        else
            f48_arg1:ClearSubGoal()
            f48_arg1:AddSubGoal(GOAL_COMMON_EndureAttack, 0.1, 3100, TARGET_ENE_0, 9999, 0)
            return true
        end
    elseif f48_arg0:HasSpecialEffectId(TARGET_ENE_0, 109970) then
        f48_arg1:ClearSubGoal()
        f48_arg1:AddSubGoal(GOAL_COMMON_EndureAttack, 0.1, 3101, TARGET_ENE_0, 9999, 0)
        return true
    else
        f48_arg1:ClearSubGoal()
        f48_arg1:AddSubGoal(GOAL_COMMON_EndureAttack, 0.1, 3100, TARGET_ENE_0, 9999, 0)
        return true
    end
    return false
    
end

Goal.Damaged = function (f49_arg0, f49_arg1, f49_arg2)
    local f49_local0 = 3
    if SpaceCheck(f49_arg0, f49_arg1, 180, 15) then
        f49_arg1:ClearSubGoal()
        f49_arg1:AddSubGoal(GOAL_COMMON_SpinStep, f49_local0, 5201, TARGET_ENE_0, 0, AI_DIR_TYPE_B, 0)
        return true
    end
    return false
    
end

Goal.Kengeki_Activate = function (f50_arg0, f50_arg1, f50_arg2, f50_arg3)
    local f50_local0 = ReturnKengekiSpecialEffect(f50_arg1)
    if f50_local0 == 0 then
        return false
    end
    local f50_local1 = {}
    local f50_local2 = {}
    local f50_local3 = {}
    Common_Clear_Param(f50_local1, f50_local2, f50_local3)
    local f50_local4 = f50_arg1:GetDist(TARGET_ENE_0)
    local f50_local5 = f50_arg1:GetSp(TARGET_SELF)
    if f50_local0 == 200300 then
        if f50_local4 >= 20 then
            f50_local1[50] = 100
        else
            f50_local1[50] = 100
        end
    elseif f50_local0 == 200301 then
        if f50_local4 >= 20 then
            f50_local1[50] = 100
        else
            f50_local1[50] = 100
        end
    elseif f50_local0 == 200205 then
        if f50_local4 >= 20 then
            f50_local1[50] = 100
        else
            f50_local1[50] = 100
        end
    elseif f50_local0 == 200206 then
        if f50_local4 >= 20 then
            f50_local1[50] = 100
        else
            f50_local1[50] = 100
        end
    else
        f50_local1[50] = 100
    end
    f50_local2[1] = REGIST_FUNC(f50_arg1, f50_arg2, f50_arg0.Kengeki01)
    f50_local2[2] = REGIST_FUNC(f50_arg1, f50_arg2, f50_arg0.Kengeki02)
    f50_local2[10] = REGIST_FUNC(f50_arg1, f50_arg2, f50_arg0.Kengeki10)
    f50_local2[11] = REGIST_FUNC(f50_arg1, f50_arg2, f50_arg0.Kengeki11)
    f50_local2[50] = REGIST_FUNC(f50_arg1, f50_arg2, f50_arg0.NoAction)
    local f50_local6 = REGIST_FUNC(f50_arg1, f50_arg2, f50_arg0.ActAfter_AdjustSpace)
    Common_Kengeki_Activate(f50_arg1, f50_arg2, f50_local1, f50_local2, f50_local6, f50_local3)
    
end

Goal.Kengeki01 = function (f51_arg0, f51_arg1, f51_arg2)
    f51_arg1:ClearSubGoal()
    f51_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 5, 3052, TARGET_ENE_0, 9999, 0, 0)
    f51_arg0:SetNumber(2, f51_arg0:GetNumber(2) + 1)
    
end

Goal.Kengeki02 = function (f52_arg0, f52_arg1, f52_arg2)
    f52_arg1:ClearSubGoal()
    f52_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 5, 3092, TARGET_ENE_0, 9999, 0, 0)
    f52_arg0:SetNumber(2, f52_arg0:GetNumber(2) + 1)
    
end

Goal.Kengeki10 = function (f53_arg0, f53_arg1, f53_arg2)
    f53_arg1:ClearSubGoal()
    f53_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 6, 3056, TARGET_ENE_0, 9999, 0, 0)
    
end

Goal.Kengeki11 = function (f54_arg0, f54_arg1, f54_arg2)
    f54_arg1:ClearSubGoal()
    f54_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 1, 3093, TARGET_ENE_0, 9999, 0, 0)
    
end

Goal.NoAction = function (f55_arg0, f55_arg1, f55_arg2)
    return -1
    
end

Goal.ActAfter_AdjustSpace = function (f56_arg0, f56_arg1, f56_arg2)
    
end

Goal.Update = function (f57_arg0, f57_arg1, f57_arg2)
    return Update_Default_NoSubGoal(f57_arg0, f57_arg1, f57_arg2)
    
end

Goal.Terminate = function (f58_arg0, f58_arg1, f58_arg2)
    
end


