﻿function COMMON_HiPrioritySetup(f1_arg0, f1_arg1)
    f1_arg0:AddObserveSpecialEffectAttribute(TARGET_ENE_0, COMMON_SP_EFFECT_PC_DEAD)
    f1_arg0:AddObserveSpecialEffectAttribute(TARGET_ENE_0, COMMON_SP_EFFECT_PC_RETURN)
    f1_arg0:AddObserveSpecialEffectAttribute(TARGET_ENE_0, COMMON_SP_EFFECT_PC_NINSATSU)
    f1_arg0:AddObserveSpecialEffectAttribute(TARGET_ENE_0, COMMON_SP_EFFECT_PC_REVIVAL_AFTER_2)
    f1_arg0:AddObserveSpecialEffectAttribute(TARGET_ENE_0, COMMON_SP_EFFECT_PC_REVIVAL_AFTER_3)
    f1_arg0:AddObserveSpecialEffectAttribute(TARGET_ENE_0, COMMON_SP_EFFECT_HIDE_IN_BLOOD)
    f1_arg0:AddObserveSpecialEffectAttribute(TARGET_ENE_0, COMMON_SP_EFFECT_PC_BREAK)
    f1_arg0:AddObserveSpecialEffectAttribute(TARGET_SELF, COMMON_SP_EFFECT_ENEMY_TURN)
    f1_arg0:AddObserveSpecialEffectAttribute(TARGET_SELF, COMMON_SP_EFFECT_QUICK_TURN_TO_PC)
    f1_arg0:AddObserveSpecialEffectAttribute(TARGET_SELF, COMMON_SP_EFFECT_BLOOD_SMOKE)
    f1_arg0:AddObserveSpecialEffectAttribute(TARGET_SELF, COMMON_SP_EFFECT_CONFUSE)
    f1_arg0:AddObserveSpecialEffectAttribute(TARGET_SELF, COMMON_SP_EFFECT_CONFUSE_GHOST)
    f1_arg0:DeleteObserve(COMMON_OBSERVE_SLOT_BATTLE_STEALTH)
    local f1_local0 = f1_arg0:GetEventRequest(2)
    if not f1_arg0:HasSpecialEffectId(TARGET_ENE_0, 110010) or f1_arg0:HasSpecialEffectId(TARGET_SELF, 205090) or f1_arg0:HasSpecialEffectId(TARGET_SELF, 205091) then
    else
        f1_arg0:ClearEnemyTarget()
        f1_arg0:ClearSoundTarget()
        f1_arg0:ClearIndicationPosTarget()
        f1_arg0:ClearLastMemoryTargetPos()
        f1_arg0:AddTopGoal(GOAL_COMMON_Wait, 0.1, TARGET_SELF, 0, 0, 0)
        return true
    end
    if f1_arg0:HasSpecialEffectId(TARGET_SELF, COMMON_SP_EFFECT_SMOKE_SCREEN) and f1_arg0:HasSpecialEffectId(TARGET_ENE_0, COMMON_SP_EFFECT_HIDE_IN_BUSH) and f1_arg0:IsVisibleCurrTarget() == false then
        if f1_arg0:HasSpecialEffectId(TARGET_SELF, COMMON_SP_EFFECT_ZAKO_REACTION) or f1_arg0:HasSpecialEffectId(TARGET_SELF, COMMON_SP_EFFECT_ZAKO_NOREACTION) then
            f1_arg0:ClearEnemyTarget()
            f1_arg0:ClearSoundTarget()
            f1_arg0:ClearIndicationPosTarget()
            f1_arg0:AddTopGoal(GOAL_COMMON_Wait, 0.1, TARGET_SELF, 0, 0, 0)
            return true
        elseif f1_arg0:HasSpecialEffectId(TARGET_SELF, COMMON_SP_EFFECT_CHUBOSS_REACTION) or f1_arg0:HasSpecialEffectId(TARGET_SELF, COMMON_SP_EFFECT_CHUBOSS_NOREACTION) then
            if f1_arg0:GetRandam_Int(1, 100) <= 50 then
                pcSearchAnim = 400600
            else
                pcSearchAnim = 400610
            end
            f1_arg0:AddTopGoal(GOAL_COMMON_WaitWithAnime, 30, pcSearchAnim, TARGET_SELF)
            f1_arg0:AddTopGoal(GOAL_COMMON_AttackTunableSpin, 10, 401040, TARGET_ENE_0, 9999, 0, 0, 0, 0)
            f1_arg0:AddObserveChrDmyArea(COMMON_OBSERVE_SLOT_BATTLE_STEALTH, TARGET_ENE_0, 7, 90, 120, 30, 4)
            return true
        end
    end
    if f1_local0 + 10 <= f1_arg0:GetDist(TARGET_ENE_0) and f1_local0 >= 0 and f1_arg0:GetCurrTargetType() ~= AI_TARGET_TYPE__NONE and f1_arg0:GetTopNormalEnemyForgettingTime() >= 5 then
        f1_arg0:ClearEnemyTarget()
        f1_arg0:ClearSoundTarget()
        f1_arg0:ClearIndicationPosTarget()
        f1_arg0:ClearLastMemoryTargetPos()
        f1_arg0:AddTopGoal(GOAL_COMMON_Wait, 0.1, TARGET_SELF, 0, 0, 0)
        return true
    end
    if not f1_arg0:IsCautionState() then
        f1_arg0:SetNumber(AI_NUMBER_LATEST_SOUND_ID, 0)
    end
    return false
    
end

function COMMON_EasySetup3(f2_arg0)
    local f2_local0 = 0
    COMMON_EzSetup(f2_arg0, f2_local0)
    
end

function COMMON_EzSetup(f3_arg0, f3_arg1)
    if not f3_arg0:HasSpecialEffectId(TARGET_SELF, 205050) and not f3_arg0:HasSpecialEffectId(TARGET_SELF, 205051) and _COMMON_AddStateTransitionGoal(f3_arg0, f3_arg1) then
        return true
    end
    _COMMON_SetBattleActLogic(f3_arg0, f3_arg1)
    if f3_arg0:IsLadderAct(TARGET_SELF) and not f3_arg0:HasGoal(GOAL_COMMON_LadderAct) then
        local f3_local0 = f3_arg0:GetTopGoal()
        if f3_local0 ~= nil then
            f3_local0:AddSubGoal_Front(GOAL_COMMON_LadderAct, -1, 3000, TARGET_SELF, f3_arg0:GetLadderDirMove(TARGET_SELF))
        else
            f3_arg0:AddTopGoal(GOAL_COMMON_LadderAct, -1, 3000, TARGET_SELF, f3_arg0:GetLadderDirMove(TARGET_SELF))
        end
    end
    
end

function _COMMON_SetBattleActLogic(f4_arg0, f4_arg1)
    local f4_local0 = f4_arg0:GetExcelParam(AI_EXCEL_THINK_PARAM_TYPE__maxBackhomeDist)
    local f4_local1 = f4_arg0:GetExcelParam(AI_EXCEL_THINK_PARAM_TYPE__backhomeDist)
    local f4_local2 = f4_arg0:GetExcelParam(AI_EXCEL_THINK_PARAM_TYPE__backhomeBattleDist)
    local f4_local3 = f4_arg0:GetExcelParam(AI_EXCEL_THINK_PARAM_TYPE__nonBattleActLife)
    local f4_local4 = f4_arg0:GetExcelParam(AI_EXCEL_THINK_PARAM_TYPE__callHelp_ForgetTimeByArrival)
    local f4_local5 = f4_arg0:IsSearchTarget(TARGET_ENE_0)
    local f4_local6 = f4_arg0:GetMovePointEffectRange()
    local f4_local7 = f4_arg0:GetDist(TARGET_ENE_0)
    if f4_arg0:TeamHelp_IsValidReply() then
        f4_arg0:AddTopGoal(GOAL_COMMON_TeamReplyHelp, f4_local4)
        return true
    elseif f4_arg0:IsForceBattleGoal() then
        f4_arg0:ClearForceBattleGoal()
        f4_arg0:ReqPlatoonState(PLATOON_STATE_Battle)
        _COMMON_AddBattleGoal(f4_arg0, f4_arg1)
    elseif f4_local5 == true then
        if f4_local0 < f4_local6 then
            _COMMON_AddNonBattleGoal(f4_arg0, f4_local3, -1, false)
            return true
        elseif f4_local1 < f4_local6 then
            if f4_local7 < f4_local2 then
                f4_arg0:ReqPlatoonState(PLATOON_STATE_Battle)
                _COMMON_AddBattleGoal(f4_arg0, f4_arg1)
                return true
            else
                _COMMON_AddNonBattleGoal(f4_arg0, f4_local3, f4_local2, false)
                return true
            end
        else
            _COMMON_AddBattleGoal(f4_arg0, f4_arg1)
            return true
        end
    else
        _COMMON_AddNonBattleGoal(f4_arg0, -1, -1, true)
        return true
    end
    return false
    
end

function _COMMON_AddBattleGoal(f5_arg0, f5_arg1)
    local f5_local0 = f5_arg0:GetPrevTargetState()
    local f5_local1 = f5_arg0:GetCurrTargetType()
    local f5_local2 = 0
    if f5_arg0:IsFindState() or f5_arg0:IsBattleState() then
        if f5_arg0:GetNumber(AI_NUMBER_BLOOD_SMOKE_BLINDNESS) == 1 and f5_arg0:HasSpecialEffectId(TARGET_SELF, COMMON_SP_EFFECT_CHUBOSS_REACTION) then
            local f5_local3 = f5_arg0:GetRandam_Int(1, 100)
            if f5_local3 <= 50 then
                pcSearchAnim = 400600
            else
                pcSearchAnim = 400610
            end
            f5_arg0:AddTopGoal(GOAL_COMMON_WaitWithAnime, 30, pcSearchAnim, TARGET_SELF):TimingSetNumber(AI_NUMBER_BLOOD_SMOKE_BLINDNESS, 0, AI_TIMING_SET__ACTIVATE)
            f5_arg0:AddTopGoal(GOAL_COMMON_AttackTunableSpin, 10, 401040, TARGET_ENE_0, 9999, 0, 0, 0, 0)
            f5_arg0:AddObserveChrDmyArea(COMMON_OBSERVE_SLOT_BATTLE_STEALTH, TARGET_ENE_0, 7, 90, 120, 30, 4)
        elseif f5_arg0:IsBattleState() or f5_arg0:HasSpecialEffectId(TARGET_SELF, 220020) then
            f5_arg0:ReqPlatoonState(PLATOON_STATE_Battle)
            _COMMON_SetBattleGoal(f5_arg0)
        elseif f5_arg0:IsFindState() then
            f5_arg0:ReqPlatoonState(PLATOON_STATE_Find)
            f5_local2 = 2
            _COMMON_AddCautionAndFindGoal(f5_arg0, f5_local2, f5_arg1)
        end
    elseif f5_arg0:IsCautionState() then
        if f5_local1 == AI_TARGET_TYPE__MEMORY_ENEMY then
            f5_local2 = 0
            _COMMON_AddCautionAndFindGoal(f5_arg0, f5_local2, f5_arg1)
        elseif f5_local1 == AI_TARGET_TYPE__SOUND then
            f5_arg0:ReqPlatoonState(PLATOON_STATE_Caution)
            f5_local2 = 1
            _COMMON_AddCautionAndFindGoal(f5_arg0, f5_local2, f5_arg1)
        elseif f5_local1 == AI_TARGET_TYPE__CORPSE_POS then
            f5_arg0:ReqPlatoonState(PLATOON_STATE_Caution)
            f5_local2 = 4
            _COMMON_AddCautionAndFindGoal(f5_arg0, f5_local2, f5_arg1)
        else
            f5_arg0:ReqPlatoonState(PLATOON_STATE_Caution)
            f5_local2 = 3
            _COMMON_AddCautionAndFindGoal(f5_arg0, f5_local2, f5_arg1)
        end
    else
        _COMMON_AddNonBattleGoal(f5_arg0, 10, -1, true)
    end
    f5_arg0:SetNumber(AI_NUMBER_LATEST_ACTION, COMMON_LATEST_ACTION_BATTLEGOAL)
    
end

function _COMMON_AddChangeStateActionGoal(f6_arg0, f6_arg1)
    
end

function _COMMON_AddCautionAndFindGoal(f7_arg0, f7_arg1, f7_arg2)
    local f7_local0 = f7_arg0:GetExcelParam(AI_EXCEL_THINK_PARAM_TYPE__goalAction_ToCaution)
    local f7_local1 = f7_arg0:GetExcelParam(AI_EXCEL_THINK_PARAM_TYPE__goalAction_ToCautionImportant)
    local f7_local2 = f7_arg0:GetExcelParam(AI_EXCEL_THINK_PARAM_TYPE__goalAction_ToCautionCorpseTarget)
    local f7_local3 = f7_arg0:GetExcelParam(AI_EXCEL_THINK_PARAM_TYPE__goalAction_ToFind)
    local f7_local4 = f7_arg0:GetExcelParam(AI_EXCEL_THINK_PARAM_TYPE__goalAction_ToDisappear)
    local f7_local5 = f7_arg0:GetExcelParam(AI_EXCEL_THINK_PARAM_TYPE__goalAction_ToCautionIndicationTarget)
    local f7_local6 = f7_arg0:GetExcelParam(AI_EXCEL_THINK_PARAM_TYPE__maxBackhomeDist)
    local f7_local7 = f7_arg0:GetMovePointEffectRange()
    local f7_local8 = 0
    local f7_local9 = 1
    local f7_local10 = 2
    local f7_local11 = 3
    local f7_local12 = 4
    local f7_local13 = 5
    local f7_local14 = 0
    local f7_local15 = -1
    local f7_local16 = f7_arg0:GetDist(TARGET_ENE_0)
    local f7_local17 = 2.5
    local f7_local18 = f7_arg0:GetLatestSoundTargetRank()
    local f7_local19 = f7_arg0:GetRandam_Int(1, 100)
    if f7_arg1 == 0 then
        f7_local14 = f7_local4
    elseif f7_arg1 == 1 and f7_local18 == AI_SOUND_RANK__IMPORTANT then
        f7_local14 = f7_local1
    elseif f7_arg1 == 1 then
        f7_local14 = f7_local0
    elseif f7_arg1 == 2 then
        f7_local14 = f7_local3
    elseif f7_arg1 == 3 then
        f7_local14 = f7_local5
    elseif f7_arg1 == 4 then
        f7_local14 = f7_local2
    end
    if f7_arg0:HasSpecialEffectId(TARGET_SELF, 205050) or f7_arg0:HasSpecialEffectId(TARGET_SELF, 205051) then
        if f7_arg0:IsFindState() then
            _COMMON_SetBattleGoal(f7_arg0)
        else
            _COMMON_AddNonBattleGoal(f7_arg0, 3, -1, false)
        end
    end
    if f7_arg0:IsFindState() then
        if f7_local14 == f7_local9 then
            f7_arg0:AddTopGoal(GOAL_COMMON_Turn, 3, TARGET_ENE_0, 40, -1, GOAL_RESULT_Success, true)
            f7_arg0:AddTopGoal(GOAL_COMMON_Stay, 1, 0, TARGET_ENE_0)
        elseif f7_local14 == f7_local10 then
            if f7_arg0:CheckDoesExistPathWithSetPoint(TARGET_ENE_0, AI_DIR_TYPE_F, 0, 0) == false then
                if SpaceCheck(f7_arg0, goal, 0, 3) == true then
                    f7_arg0:AddTopGoal(GOAL_COMMON_ApproachTarget, 5, POINT_UnreachTerminate, f7_local17, TARGET_SELF, true, -1)
                elseif f7_arg0:IsInsideTarget(TARGET_ENE_0, AI_DIR_TYPE_F, 90) then
                    f7_arg0:AddTopGoal(GOAL_COMMON_Stay, 1, 0, TARGET_ENE_0)
                else
                    f7_arg0:AddTopGoal(GOAL_COMMON_Turn, 3, TARGET_ENE_0, 40, -1, GOAL_RESULT_Success, true)
                end
            elseif f7_local17 + 0.5 < f7_local16 then
                f7_arg0:AddTopGoal(GOAL_COMMON_Turn, 3, TARGET_ENE_0, 40, -1, GOAL_RESULT_Success, true)
                if not f7_arg0:HasSpecialEffectId(TARGET_SELF, 220010) and not f7_arg0:HasSpecialEffectId(TARGET_SELF, 220011) then
                    f7_arg0:AddTopGoal(GOAL_COMMON_MoveToSomewhere, f7_local15, TARGET_ENE_0, AI_DIR_TYPE_CENTER, f7_local17, TARGET_SELF, true)
                    if false then
                    end
                end
            end
        elseif f7_local14 == f7_local11 then
            if f7_arg0:CheckDoesExistPathWithSetPoint(TARGET_ENE_0, AI_DIR_TYPE_F, 0, 0) == false then
                if SpaceCheck(f7_arg0, goal, 0, 4) == true then
                    local f7_local20 = false
                    if f7_arg0:IsInsideTargetRegion(TARGET_SELF, COMMON_REGION_FORCE_WALK_M11_0) then
                        f7_local20 = true
                    end
                    f7_arg0:AddTopGoal(GOAL_COMMON_ApproachTarget, 5, POINT_UnreachTerminate, f7_local17, TARGET_SELF, f7_local20, -1)
                elseif SpaceCheck(f7_arg0, goal, 0, 3) == true then
                    f7_arg0:AddTopGoal(GOAL_COMMON_ApproachTarget, 5, POINT_UnreachTerminate, f7_local17, TARGET_SELF, true, -1)
                elseif f7_arg0:IsInsideTarget(TARGET_ENE_0, AI_DIR_TYPE_F, 90) then
                    f7_arg0:AddTopGoal(GOAL_COMMON_Stay, 1, 0, TARGET_ENE_0)
                else
                    f7_arg0:AddTopGoal(GOAL_COMMON_Turn, 3, TARGET_ENE_0, 40, -1, GOAL_RESULT_Success, true)
                end
            elseif f7_local17 + 0.5 < f7_local16 and not f7_arg0:HasSpecialEffectId(TARGET_SELF, 220010) and not f7_arg0:HasSpecialEffectId(TARGET_SELF, 220011) then
                local f7_local20 = false
                if f7_arg0:IsInsideTargetRegion(TARGET_SELF, COMMON_REGION_FORCE_WALK_M11_0) then
                    f7_local20 = true
                end
                f7_arg0:AddTopGoal(GOAL_COMMON_MoveToSomewhere, f7_local15, TARGET_ENE_0, AI_DIR_TYPE_CENTER, f7_local17, TARGET_SELF, f7_local20)
                if false then
                end
            end
        elseif f7_local14 == f7_local12 then
            f7_arg0:AddTopGoal(GOAL_COMMON_Stay, 1, 0, TARGET_ENE_0)
        elseif f7_local14 == f7_local13 then
            if f7_local17 <= f7_local16 then
                f7_arg0:AddTopGoal(GOAL_COMMON_Stay, 1, 0, TARGET_ENE_0)
            elseif f7_local17 / 2 <= f7_local16 then
                f7_arg0:AddTopGoal(GOAL_COMMON_LeaveTarget, f7_local15, TARGET_ENE_0, f7_local17, TARGET_ENE_0, true, -1)
            else
                f7_arg0:AddTopGoal(GOAL_COMMON_LeaveTarget, f7_local15, TARGET_ENE_0, f7_local17, TARGET_SELF, false, -1)
            end
        else
            _COMMON_AddNonBattleGoal(f7_arg0, 1, -1, false)
        end
    else
        if f7_arg1 == 1 then
            if f7_arg0:GetLatestSoundTargetID() == 7900 or f7_arg0:GetLatestSoundTargetID() == 7910 then
                f7_local17 = 0.4
            elseif f7_arg0:GetLatestSoundTargetID() == 3501 then
                f7_local17 = 0.2
            end
        end
        local f7_local20 = 600
        if f7_arg0:HasSpecialEffectId(TARGET_SELF, 200004) or f7_arg0:HasSpecialEffectId(TARGET_SELF, 200002) then
            if f7_local19 <= 50 then
                f7_local20 = 400600
            else
                f7_local20 = 400610
            end
        elseif f7_local19 <= 50 then
            f7_local20 = 610
        end
        f7_arg0:RegisterTriggerRegionObserver(1000)
        if f7_arg0:GetNumber(AI_NUMBER_LATEST_ACTION) == COMMON_LATEST_ACTION_NONBATTLEGOAL_BATTLE then
            f7_arg0:AddTopGoal(GOAL_COMMON_ConfirmCautionTarget, 30, f7_local20, TARGET_SELF, f7_arg0:GetRandam_Float(4, 6), TARGET_SELF)
        elseif f7_arg0:GetCurrTargetType() == AI_TARGET_TYPE__SOUND and f7_arg0:GetLatestSoundTargetID() == 7700 then
            f7_arg0:AddTopGoal(GOAL_COMMON_ConfirmCautionTarget, 30, f7_local20, TARGET_SELF, f7_arg0:GetRandam_Float(4, 6), TARGET_SELF)
        elseif f7_local14 == f7_local9 then
            f7_arg0:AddTopGoal(GOAL_COMMON_Turn, 3, TARGET_ENE_0, 40, -1, GOAL_RESULT_Success, true)
            f7_arg0:AddTopGoal(GOAL_COMMON_ConfirmCautionTarget, 30, f7_local20, TARGET_SELF, f7_arg0:GetRandam_Float(6, 7), TARGET_SELF)
        elseif f7_local14 == f7_local10 then
            if f7_arg0:CheckDoesExistPathWithSetPoint(TARGET_ENE_0, AI_DIR_TYPE_F, 0, 0) == false then
                if f7_arg1 == 0 then
                    local f7_local21 = f7_arg0:GetDist_Point(POINT_INITIAL)
                    if f7_local17 + 0.5 < f7_local21 then
                        f7_arg0:AddTopGoal(GOAL_COMMON_MoveToSomewhere, -1, POINT_INITIAL, AI_DIR_TYPE_CENTER, f7_local17, TARGET_ENE_0, false)
                    else
                        f7_arg0:AddTopGoal(GOAL_COMMON_ConfirmCautionTarget, 30, f7_local20, TARGET_SELF, f7_arg0:GetRandam_Float(3, 4), TARGET_SELF)
                    end
                else
                    f7_arg0:AddTopGoal(GOAL_COMMON_YousumiAct, 10, false, 60, 30, -1)
                    f7_arg0:AddTopGoal(GOAL_COMMON_Turn, 3, TARGET_ENE_0, 40, -1, GOAL_RESULT_Success, true)
                    f7_arg0:AddTopGoal(GOAL_COMMON_ConfirmCautionTarget, 30, f7_local20, TARGET_SELF, f7_arg0:GetRandam_Float(3, 4), TARGET_SELF)
                end
            elseif f7_local17 + 0.5 < f7_local16 then
                if not f7_arg0:HasSpecialEffectId(TARGET_SELF, 220010) and not f7_arg0:HasSpecialEffectId(TARGET_SELF, 220011) then
                    f7_arg0:AddTopGoal(GOAL_COMMON_MoveToSomewhere, f7_local15, TARGET_ENE_0, AI_DIR_TYPE_CENTER, f7_local17, TARGET_SELF, true)
                else
                    f7_arg0:AddTopGoal(GOAL_COMMON_ConfirmCautionTarget, 30, f7_local20, TARGET_SELF, f7_arg0:GetRandam_Float(7, 8), TARGET_SELF)
                end
            else
                f7_arg0:RegisterTriggerRegion(1000, f7_arg0:GetLatestSoundTargetInstanceID(), 5, 5, TARGET_SELF, AI_DIR_TYPE_F, 0)
                f7_arg0:AddTopGoal(GOAL_COMMON_Turn, 3, TARGET_ENE_0, 40, -1, GOAL_RESULT_Success, true)
                f7_arg0:AddTopGoal(GOAL_COMMON_ConfirmCautionTarget, 30, f7_local20, TARGET_SELF, f7_arg0:GetRandam_Float(3, 4), TARGET_SELF)
            end
        elseif f7_local14 == f7_local11 then
            if f7_arg0:CheckDoesExistPathWithSetPoint(TARGET_ENE_0, AI_DIR_TYPE_F, 0, 0) == false then
                if f7_arg1 == 0 then
                    local f7_local21 = f7_arg0:GetDist_Point(POINT_INITIAL)
                    if f7_local17 + 0.5 < f7_local21 then
                        f7_arg0:AddTopGoal(GOAL_COMMON_MoveToSomewhere, -1, POINT_INITIAL, AI_DIR_TYPE_CENTER, f7_local17, TARGET_ENE_0, false)
                    else
                        f7_arg0:AddTopGoal(GOAL_COMMON_ConfirmCautionTarget, 30, f7_local20, TARGET_SELF, f7_arg0:GetRandam_Float(3, 4), TARGET_SELF)
                    end
                else
                    f7_arg0:AddTopGoal(GOAL_COMMON_YousumiAct, 10, false, 60, 30, -1)
                    f7_arg0:AddTopGoal(GOAL_COMMON_Turn, 3, TARGET_ENE_0, 40, -1, GOAL_RESULT_Success, true)
                    f7_arg0:AddTopGoal(GOAL_COMMON_ConfirmCautionTarget, 30, f7_local20, TARGET_SELF, f7_arg0:GetRandam_Float(3, 4), TARGET_SELF)
                end
            elseif f7_local17 + 0.5 < f7_local16 then
                if not f7_arg0:HasSpecialEffectId(TARGET_SELF, 220010) and not f7_arg0:HasSpecialEffectId(TARGET_SELF, 220011) then
                    local f7_local21 = false
                    if f7_arg0:IsInsideTargetRegion(TARGET_SELF, COMMON_REGION_FORCE_WALK_M11_0) then
                        f7_local21 = true
                    end
                    f7_arg0:AddTopGoal(GOAL_COMMON_MoveToSomewhere, f7_local15, TARGET_ENE_0, AI_DIR_TYPE_CENTER, f7_local17, TARGET_SELF, f7_local21)
                else
                    f7_arg0:AddTopGoal(GOAL_COMMON_ConfirmCautionTarget, 30, f7_local20, TARGET_SELF, f7_arg0:GetRandam_Float(3, 4), TARGET_SELF)
                end
            else
                f7_arg0:RegisterTriggerRegion(1000, f7_arg0:GetLatestSoundTargetInstanceID(), 5, 5, TARGET_SELF, AI_DIR_TYPE_F, 0)
                f7_arg0:AddTopGoal(GOAL_COMMON_Turn, 3, TARGET_ENE_0, 40, -1, GOAL_RESULT_Success, true)
                f7_arg0:AddTopGoal(GOAL_COMMON_ConfirmCautionTarget, 30, f7_local20, TARGET_SELF, f7_arg0:GetRandam_Float(3, 4), TARGET_SELF)
            end
        elseif f7_local14 == f7_local12 then
            f7_arg0:AddTopGoal(GOAL_COMMON_Turn, 3, TARGET_ENE_0, 40, -1, GOAL_RESULT_Success, true)
            f7_arg0:AddTopGoal(GOAL_COMMON_ConfirmCautionTarget, 30, f7_local20, TARGET_SELF, f7_arg0:GetRandam_Float(6, 7), TARGET_SELF)
        elseif f7_local14 == f7_local13 then
            if f7_local17 <= f7_local16 then
                f7_arg0:AddTopGoal(GOAL_COMMON_ConfirmCautionTarget, 30, f7_local20, TARGET_SELF, f7_arg0:GetRandam_Float(3, 4), TARGET_SELF)
            elseif f7_local17 / 2 <= f7_local16 then
                f7_arg0:AddTopGoal(GOAL_COMMON_LeaveTarget, f7_local15, TARGET_ENE_0, f7_local17, TARGET_ENE_0, true, -1)
            else
                f7_arg0:AddTopGoal(GOAL_COMMON_LeaveTarget, f7_local15, TARGET_ENE_0, f7_local17, TARGET_SELF, false, -1)
            end
        else
            f7_arg0:AddTopGoal(GOAL_COMMON_Turn, 3, TARGET_ENE_0, 40, -1, GOAL_RESULT_Success, true)
            f7_arg0:AddTopGoal(GOAL_COMMON_ConfirmCautionTarget, 30, f7_local20, TARGET_SELF, f7_arg0:GetRandam_Float(6, 7), TARGET_SELF)
        end
    end
    
end

function _COMMON_AddNonBattleGoal(f8_arg0, f8_arg1, f8_arg2, f8_arg3)
    f8_arg0:TeamHelp_ValidateCall()
    f8_arg0:TeamHelp_ValidateReply()
    local f8_local0 = -1
    if f8_arg0:HasSpecialEffectId(TARGET_SELF, 205100) or f8_arg0:HasSpecialEffectId(TARGET_SELF, 205101) then
        f8_local0 = 9920
    end
    f8_arg0:AddTopGoal(GOAL_COMMON_NonBattleAct, f8_arg1, f8_arg2, f8_arg3, false, POINT_INIT_POSE, 0, 0, f8_local0)
    if f8_arg0:IsBattleState() or f8_arg0:IsFindState() or f8_arg0:IsCautionState() then
        f8_arg0:SetNumber(AI_NUMBER_LATEST_ACTION, COMMON_LATEST_ACTION_NONBATTLEGOAL_BATTLE)
    else
        f8_arg0:SetNumber(AI_NUMBER_LATEST_ACTION, COMMON_LATEST_ACTION_NONBATTLEGOAL_NON)
    end
    
end

function _COMMON_AddStateTransitionGoal(f9_arg0, f9_arg1)
    if f9_arg0:HasSpecialEffectId(TARGET_SELF, 205080) and f9_arg0:HasSpecialEffectId(TARGET_SELF, 205081) then
        return false
    end
    local f9_local0 = f9_arg0:IsSearchTarget(TARGET_ENE_0)
    local f9_local1 = f9_arg0:GetPrevTargetState()
    local f9_local2 = f9_arg0:GetCurrTargetType()
    if f9_arg1 == COMMON_FLAG_BOSS then
    elseif f9_arg0:IsFindState() or f9_arg0:IsBattleState() then
        f9_arg0:ClearSoundTarget()
        f9_arg0:ClearIndicationPosTarget()
        if f9_arg0:HasSpecialEffectId(TARGET_SELF, 200004) then
            if f9_arg0:IsChangeState() and f9_arg0:GetPrevTargetState() ~= AI_TARGET_STATE__FIND then
                f9_arg0:AddTopGoal(GOAL_COMMON_AttackTunableSpin, 10, 401040, TARGET_ENE_0, 9999, 0, 0, 0, 0)
                return true
            end
        elseif f9_arg0:HasSpecialEffectId(TARGET_SELF, 200002) then
            if f9_arg0:HasSpecialEffectId(TARGET_SELF, 220070) and f9_arg0:IsVisibleCurrTarget() == false then
                if not f9_arg0:IsInsideTarget(TARGET_ENE_0, AI_DIR_TYPE_F, 90) then
                    f9_arg0:AddTopGoal(GOAL_COMMON_Turn, 3, TARGET_ENE_0, 40, -1, GOAL_RESULT_Success, true)
                else
                    f9_arg0:AddTopGoal(GOAL_COMMON_ClearTarget, 3, AI_TARGET_TYPE__NORMAL_ENEMY)
                end
            else
                f9_arg0:AddTopGoal(GOAL_COMMON_AttackTunableSpin, 10, 201040, TARGET_ENE_0, 9999, 0, 0, 0, 0)
            end
            return true
        elseif f9_arg0:HasSpecialEffectId(TARGET_SELF, 200001) then
            if f9_arg0:HasSpecialEffectId(TARGET_SELF, 220070) and f9_arg0:IsVisibleCurrTarget() == false then
                if not f9_arg0:IsInsideTarget(TARGET_ENE_0, AI_DIR_TYPE_F, 90) then
                    f9_arg0:AddTopGoal(GOAL_COMMON_Turn, 3, TARGET_ENE_0, 40, -1, GOAL_RESULT_Success, true)
                else
                    f9_arg0:AddTopGoal(GOAL_COMMON_EndureAttack, 10, 101040, TARGET_ENE_0, 9999, 0, 0, 0, 0)
                    f9_arg0:AddTopGoal(GOAL_COMMON_ClearTarget, 3, AI_TARGET_TYPE__NORMAL_ENEMY)
                end
            else
                f9_arg0:AddTopGoal(GOAL_COMMON_EndureAttack, 10, 101040, TARGET_ENE_0, 9999, 0, 0, 0, 0)
            end
            return true
        else
            f9_arg0:AddTopGoal(GOAL_COMMON_EndureAttack, 10, 1040, TARGET_ENE_0, 9999, 0, 0, 0, 0)
            return true
        end
    elseif f9_arg0:IsCautionState() then
        if f9_local2 == AI_TARGET_TYPE__MEMORY_ENEMY then
            if f9_arg0:HasSpecialEffectId(TARGET_SELF, 200004) then
                f9_arg0:AddTopGoal(GOAL_COMMON_AttackTunableSpin, 10, 401020, TARGET_ENE_0, 9999, 0, 0, 0, 0)
                return true
            elseif f9_arg0:HasSpecialEffectId(TARGET_SELF, 200002) or f9_arg0:HasSpecialEffectId(TARGET_SELF, 200001) then
            else
                f9_arg0:AddTopGoal(GOAL_COMMON_EndureAttack, 10, 1010, TARGET_ENE_0, 9999, 0, 0, 0, 0)
                return true
            end
        elseif f9_local2 == AI_TARGET_TYPE__SOUND then
            if f9_arg0:HasSpecialEffectId(TARGET_SELF, 200004) then
                f9_arg0:AddTopGoal(GOAL_COMMON_AttackTunableSpin, 10, 401020, TARGET_ENE_0, 9999, 0, 0, 0, 0)
                return true
            elseif f9_arg0:HasSpecialEffectId(TARGET_SELF, 200002) or f9_arg0:HasSpecialEffectId(TARGET_SELF, 200001) then
            else
                f9_arg0:AddTopGoal(GOAL_COMMON_EndureAttack, 10, 1010, TARGET_ENE_0, 9999, 0, 0, 0, 0)
                return true
            end
        elseif f9_local2 == AI_TARGET_TYPE__INDICATION_POS then
            if f9_arg0:HasSpecialEffectId(TARGET_SELF, 200004) then
                f9_arg0:AddTopGoal(GOAL_COMMON_AttackTunableSpin, 10, 401020, TARGET_ENE_0, 9999, 0, 0, 0, 0)
                return true
            elseif f9_arg0:HasSpecialEffectId(TARGET_SELF, 200002) or f9_arg0:HasSpecialEffectId(TARGET_SELF, 200001) then
            else
                if f9_arg0:IsChangeState() then
                    f9_arg0:AddTopGoal(GOAL_COMMON_Wait, f9_arg0:GetRandam_Float(0, 0.3), TARGET_SELF, 0, 0, 0)
                    f9_arg0:AddTopGoal(GOAL_COMMON_EndureAttack, 10, 700, TARGET_ENE_0, 9999, 0)
                    return true
                end
                f9_arg0:AddTopGoal(GOAL_COMMON_EndureAttack, 10, 1010, TARGET_ENE_0, 9999, 0, 0, 0, 0)
                return true
            end
        elseif f9_local2 == AI_TARGET_TYPE__CORPSE_POS then
            if f9_arg0:HasSpecialEffectId(TARGET_SELF, 200004) then
                f9_arg0:AddTopGoal(GOAL_COMMON_AttackTunableSpin, 10, 401020, TARGET_ENE_0, 9999, 0, 0, 0, 0)
                return true
            elseif f9_arg0:HasSpecialEffectId(TARGET_SELF, 200002) or f9_arg0:HasSpecialEffectId(TARGET_SELF, 200001) then
            else
                if f9_arg0:IsChangeState() then
                    f9_arg0:AddTopGoal(GOAL_COMMON_Wait, f9_arg0:GetRandam_Float(0, 0.3), TARGET_SELF, 0, 0, 0)
                    f9_arg0:AddTopGoal(GOAL_COMMON_EndureAttack, 10, 710, TARGET_ENE_0, 9999, 0)
                    return true
                end
                f9_arg0:AddTopGoal(GOAL_COMMON_EndureAttack, 10, 1010, TARGET_ENE_0, 9999, 0, 0, 0, 0)
                return true
            end
        end
    elseif f9_arg0:HasSpecialEffectId(TARGET_SELF, 200004) then
        f9_arg0:AddTopGoal(GOAL_COMMON_AttackTunableSpin, 10, 401000, TARGET_ENE_0, 9999, 0, 0, 0, 0)
        return true
    elseif f9_arg0:HasSpecialEffectId(TARGET_SELF, 200002) then
        f9_arg0:AddTopGoal(GOAL_COMMON_AttackTunableSpin, 10, 201000, TARGET_ENE_0, 9999, 0, 0, 0, 0)
        return true
    elseif f9_arg0:HasSpecialEffectId(TARGET_SELF, 200001) then
        f9_arg0:AddTopGoal(GOAL_COMMON_AttackTunableSpin, 10, 101000, TARGET_SELF, 9999, 0, 0, 0, 0)
        return true
    else
    end
    return false
    
end

function _COMMON_SetBattleGoal(f10_arg0)
    local f10_local0 = f10_arg0:GetExcelParam(AI_EXCEL_THINK_PARAM_TYPE__battleGoalID)
    local f10_local1 = f10_arg0:AddTopGoal(f10_local0, -1)
    if f10_local1 then
        f10_local1:SetManagementGoal()
    end
    return true
    
end

function COMMON_Interrupt(f11_arg0, f11_arg1)
    local f11_local0 = false
    if f11_arg0:IsInterupt(INTERUPT_MovedEnd_OnFailedPath) then
        f11_arg0:DecideWalkAroundPos()
        local f11_local1 = f11_arg0:GetActTypeOnFailedPathEnd()
        if 0 == f11_local1 then
            f11_local0 = true
        elseif 1 == f11_local1 then
            f11_arg1:ClearSubGoal()
            f11_arg1:AddSubGoal(GOAL_COMMON_Wait_On_FailedPath, -1, 1)
            f11_local0 = true
        elseif 2 == f11_local1 then
            f11_arg1:ClearSubGoal()
            f11_arg1:AddSubGoal(GOAL_COMMON_Wait_On_FailedPath, 2, 1)
            f11_local0 = true
        elseif 3 == f11_local1 then
            f11_arg1:ClearSubGoal()
            f11_arg1:AddSubGoal(GOAL_COMMON_WalkAround_On_FailedPath, -1, 1)
            f11_local0 = true
        elseif 4 == f11_local1 then
            f11_arg1:ClearSubGoal()
            f11_arg1:AddSubGoal(GOAL_COMMON_BackToHome_On_FailedPath, 100, 1, 2)
            f11_local0 = true
        end
    end
    return f11_local0
    
end


