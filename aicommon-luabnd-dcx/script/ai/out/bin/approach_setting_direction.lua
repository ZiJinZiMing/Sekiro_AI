REGISTER_DBG_GOAL_PARAM(GOAL_COMMON_ApproachSettingDirection, 0, "移動対象", 0)
REGISTER_DBG_GOAL_PARAM(GOAL_COMMON_ApproachSettingDirection, 1, "到達判定距離", 0)
REGISTER_DBG_GOAL_PARAM(GOAL_COMMON_ApproachSettingDirection, 2, "旋回対象", 0)
REGISTER_DBG_GOAL_PARAM(GOAL_COMMON_ApproachSettingDirection, 3, "歩く?", 0)
REGISTER_DBG_GOAL_PARAM(GOAL_COMMON_ApproachSettingDirection, 4, "ガードEzState番号", 0)
REGISTER_DBG_GOAL_PARAM(GOAL_COMMON_ApproachSettingDirection, 5, "移動方向", 0)
REGISTER_DBG_GOAL_PARAM(GOAL_COMMON_ApproachSettingDirection, 6, "指定方向への距離", 0)
REGISTER_DBG_GOAL_PARAM(GOAL_COMMON_ApproachSettingDirection, 7, "寿命終了時、成功扱いにするか", 0)
REGISTER_GOAL_NO_INTERUPT(GOAL_COMMON_ApproachSettingDirection, true)
REGISTER_GOAL_NO_SUB_GOAL(GOAL_COMMON_ApproachSettingDirection, true)

function ApproachSettingDirection_Activate(f1_arg0, f1_arg1)
    local f1_local0 = f1_arg1:GetLife()
    local f1_local1 = f1_arg1:GetParam(0)--移目
    local f1_local2 = f1_arg1:GetParam(1)--到判断距
    local f1_local3 = f1_arg1:GetParam(2)--旋目
    local f1_local4 = f1_arg1:GetParam(3)--是否行
    local f1_local5 = f1_arg1:GetParam(4)--防御EzState号
    local f1_local6 = f1_arg1:GetParam(5)--移方向
    local f1_local7 = f1_arg1:GetParam(6)--指定方向的距
                                        --7，寿命束，是否成功
    f1_arg1:AddSubGoal(GOAL_COMMON_MoveToSomewhere, -1, f1_local1, f1_local6, f1_local2, f1_local3, f1_local4, f1_local7, 0, false, f1_local5, GOAL_RESULT_Continue, false)

end

function ApproachSettingDirection_Update(f2_arg0, f2_arg1, f2_arg2)
    local f2_local0 = f2_arg1:GetParam(7)
    if f2_arg1:GetSubGoalNum() <= 0 then
        return GOAL_RESULT_Success
    end
    if f2_arg1:GetLife() <= 0 then
        if f2_local0 == nil then
            return GOAL_RESULT_Failed
        else
            return GOAL_RESULT_Success
        end
    end
    return GOAL_RESULT_Continue
    
end

function ApproachSettingDirection_Terminate(f3_arg0, f3_arg1)
    
end

function ApproachSettingDirection_Interupt(f4_arg0, f4_arg1)
    return false
    
end


