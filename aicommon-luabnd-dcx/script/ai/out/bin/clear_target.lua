﻿REGISTER_DBG_GOAL_PARAM(GOAL_COMMON_ClearTarget, 0, "クリア対象ターゲット", 0)
REGISTER_GOAL_UPDATE_TIME(GOAL_COMMON_ClearTarget, 0, 0)
REGISTER_GOAL_NO_INTERUPT(GOAL_COMMON_ClearTarget, true)

function ClearTarget_Activate(f1_arg0, f1_arg1)
    local f1_local0 = f1_arg1:GetParam(0)
    if f1_local0 == AI_TARGET_TYPE__NORMAL_ENEMY then
        f1_arg0:ClearEnemyTarget()
    elseif f1_local0 == AI_TARGET_TYPE__SOUND then
        f1_arg0:ClearSoundTarget()
    elseif f1_local0 == AI_TARGET_TYPE__MEMORY_ENEMY then
        f1_arg0:ClearLastMemoryTargetPos()
    elseif f1_local0 == AI_TARGET_TYPE__INDICATION_POS then
        f1_arg0:ClearIndicationPosTarget()
    elseif f1_local0 == AI_TARGET_TYPE__CORPSE_POS then
        f1_arg0:ClearCorpsePosTarget()
    end
    f1_arg1:AddSubGoal(GOAL_COMMON_Wait, 0.1, TARGET_SELF, 0, 0, 0)
    
end

function ClearTarget_Update(f2_arg0, f2_arg1, f2_arg2)
    return GOAL_RESULT_Success
    
end

function ClearTarget_Terminate(f3_arg0, f3_arg1)
    
end

function ClearTarget_Interupt(f4_arg0, f4_arg1)
    return false
    
end


