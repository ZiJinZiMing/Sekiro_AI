RegisterTableLogic(113000)

Logic.Main = function (f1_arg0, f1_arg1)
    if COMMON_HiPrioritySetup(f1_arg1) then
        return true
    end
    if f1_arg1:IsFinishTimer(AI_TIMER_TEKIMAWASHI_REACTION) == false then
        JuzuReaction(f1_arg1, goal, 1, 20105)
        return true
    end
    COMMON_EzSetup(f1_arg1)
    
end

Logic.Interrupt = function (f2_arg0, f2_arg1, f2_arg2)
    if f2_arg1:IsInterupt(INTERUPT_EventRequest) then
        local f2_local0 = f2_arg1:GetEventRequest()
        if f2_local0 == 12 then
            f2_arg1:Replanning()
        end
    end
    return false
    
end


