--[[
团队求助召集行为激活函数
功能：当AI需要召集队友帮助时执行的初始化行为
使用场景：敌人发现玩家或受到攻击时，向附近的队友发出求助信号
战术意图：通过团队协作增强战斗压力，形成围攻态势
--]]
function TeamCallHelp_Activate(f1_arg0, f1_arg1)
    -- 获取召集帮助时使用的动作ID（从AI参数表中读取）
    -- 这个动作通常是喊叫、吹哨或其他召集动作
    local f1_local0 = f1_arg0:GetExcelParam(AI_EXCEL_THINK_PARAM_TYPE__callHelp_CallActionId)

    -- 获取目标参数（通常是玩家或威胁目标）
    local f1_local1 = f1_arg1:GetParam(0)

    -- 预约团队帮助调用，标记即将发出求助信号
    -- 这会在AI系统中注册一个待发送的求助请求
    f1_arg0:TeamHelp_ReserveCall()

    -- 转向目标，确保能够看到威胁来源
    -- 这有助于提高召集动作的准确性和真实感
    f1_arg0:TurnTo(f1_local1)

    -- 如果已经朝向目标，立即执行召集动作
    -- 避免在转身过程中执行动作导致的不自然表现
    if f1_arg0:IsLookToTarget() == true then
        f1_arg0:SetAttackRequest(f1_local0)  -- 执行召集动作（实际是特殊攻击动作）
    end

end

--[[
团队求助召集行为更新函数
功能：持续监控求助召集过程，确保动作完成
逻辑流程：检查生命状态 -> 检查动作完成 -> 维持朝向目标 -> 执行召集动作
返回值：Success表示召集完成，Continue表示继续执行
--]]
function TeamCallHelp_Update(f2_arg0, f2_arg1)
    -- 获取召集帮助动作ID
    local f2_local0 = f2_arg0:GetExcelParam(AI_EXCEL_THINK_PARAM_TYPE__callHelp_CallActionId)

    -- 获取目标参数
    local f2_local1 = f2_arg1:GetParam(0)

    -- 检查目标是否死亡，如果目标已死则无需继续召集
    -- 这是一个安全检查，避免对死亡目标无意义的求助
    if f2_arg1:GetLife() <= 0 then
        return GOAL_RESULT_Success  -- 任务完成，目标已不存在
    end

    -- 检查召集动作是否已完成
    -- 一旦召集动作结束，目标就达成了
    if f2_arg0:IsFinishAttack() then
        return GOAL_RESULT_Success  -- 召集动作完成，成功结束
    end

    -- 检查是否正确朝向目标
    if f2_arg0:IsLookToTarget() == true then
        -- 如果朝向正确但动作未开始，则开始执行召集动作
        if f2_arg0:IsStartAttack() == false then
            f2_arg0:SetAttackRequest(f2_local0)  -- 设置召集动作请求
        end
    else
        -- 如果未正确朝向目标，继续调整朝向
        -- 确保召集动作朝向威胁来源，增强真实感
        f2_arg0:TurnTo(f2_local1)
    end

    return GOAL_RESULT_Continue  -- 继续执行召集过程

end

--[[
团队求助召集行为终止函数
功能：完成实际的团队求助调用，发送求助信号给队友
执行时机：当召集动作完成或被中断时调用
系统集成：通过TeamHelp_Call()触发整个团队AI的响应机制
--]]
function TeamCallHelp_Terminate(f3_arg0, f3_arg1)
    -- 执行实际的团队求助调用
    -- 这会向AI系统广播求助信号，通知附近的队友前来支援
    -- 与call_team.lua配合工作，形成完整的团队协作机制
    f3_arg0:TeamHelp_Call()

end

-- 注册目标类型，指定此目标不可被中断
-- 确保求助召集过程的完整性，避免被其他行为打断
REGISTER_GOAL_NO_INTERUPT(GOAL_COMMON_TeamCallHelp, true)

--[[
团队求助召集行为中断检查函数
功能：检查是否允许中断当前的求助召集行为
返回值：false表示不允许中断，确保求助流程的完整性
设计理念：求助召集是关键的团队协作行为，不应被轻易中断
--]]
function TeamCallHelp_Interupt(f4_arg0, f4_arg1)
    -- 始终返回false，不允许中断求助召集过程
    -- 这确保了团队协作机制的可靠性和一致性
    return false

end


