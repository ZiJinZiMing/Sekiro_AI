--[[
团队召集AI脚本 - 激活函数
用于AI角色向团队成员发出召集信号，请求支援的功能模块

功能描述：
- 初始化团队召集流程
- 设置召集动作参数
- 向目标转身并执行召集动作
- 与其他团队成员建立协作关系

使用场景：
- 敌人发现玩家时请求队友支援
- 战斗中呼叫增援
- 警戒状态下的团队协调

参数说明：
@param f1_arg0 AI实体对象，包含AI状态和行为控制接口
@param f1_arg1 目标参数对象，包含召集目标的相关信息

返回值：无

技术实现：
- 使用Excel参数系统获取召集动作ID
- 通过TeamHelp系统管理团队协作
- 集成转向和攻击请求系统
--]]
function CallTeam_Activate(f1_arg0, f1_arg1)
    -- 获取Excel配置中的召集帮助动作ID，用于确定具体的召集动画和行为
    local f1_local0 = f1_arg0:GetExcelParam(AI_EXCEL_THINK_PARAM_TYPE__callHelp_CallActionId)
    -- 获取目标参数，通常是召集的目标位置或对象
    local f1_local1 = f1_arg1:GetParam(1)

    -- 设置状态标记为1，表示开始召集流程
    f1_arg0:SetNumber(2, 1)
    -- 预约团队召集，在团队帮助系统中注册召集请求
    f1_arg0:TeamHelp_ReserveCall()
    -- 验证召集有效性，检查是否满足召集条件
    f1_arg0:TeamHelp_ValidateCall()
    -- 向目标方向转身，确保召集动作面向正确方向
    f1_arg0:TurnTo(f1_local1)

    -- 如果已经面向目标，立即开始执行召集动作
    if f1_arg0:IsLookToTarget() == true then
        f1_arg0:SetAttackRequest(f1_local0)
    end

end

--[[
团队召集AI脚本 - 更新函数
持续监控和维护团队召集过程，确保召集动作正确执行

功能描述：
- 监控目标生命状态和召集动作进度
- 维持面向目标的转向行为
- 控制召集动作的执行时机
- 处理召集过程中的状态变化

执行逻辑：
1. 检查目标生命状态，死亡时终止召集
2. 检查攻击动作完成状态
3. 维持面向目标并执行召集动作
4. 返回继续执行状态

参数说明：
@param f2_arg0 AI实体对象，控制召集行为的执行
@param f2_arg1 目标参数对象，包含召集目标信息

返回值：
@return GOAL_RESULT_Success 召集完成或目标死亡
@return GOAL_RESULT_Continue 继续执行召集过程

性能考虑：
- 每帧都会调用，需要高效的状态检查
- 避免重复的转向和攻击请求
--]]
function CallTeam_Update(f2_arg0, f2_arg1)
    -- 获取召集动作ID，用于持续的动作控制
    local f2_local0 = f2_arg0:GetExcelParam(AI_EXCEL_THINK_PARAM_TYPE__callHelp_CallActionId)
    -- 获取目标参数，维持对目标的引用
    local f2_local1 = f2_arg1:GetParam(1)

    -- 检查目标生命值，如果目标已死亡则召集成功结束
    if f2_arg1:GetLife() <= 0 then
        return GOAL_RESULT_Success
    end

    -- 检查攻击动作是否完成，召集动作执行完毕则返回成功
    if f2_arg0:IsFinishAttack() then
        return GOAL_RESULT_Success
    end

    -- 检查是否面向目标
    if f2_arg0:IsLookToTarget() == true then
        -- 如果面向目标但还没开始攻击动作，则发起召集攻击请求
        if f2_arg0:IsStartAttack() == false then
            f2_arg0:SetAttackRequest(f2_local0)
        end
    else
        -- 如果没有面向目标，继续转向目标
        f2_arg0:TurnTo(f2_local1)
    end

    -- 返回继续状态，保持召集过程运行
    return GOAL_RESULT_Continue

end

--[[
团队召集AI脚本 - 终止函数
处理团队召集过程的结束逻辑，确保正确的状态转换和团队通知

功能描述：
- 根据召集状态决定后续行为
- 执行实际的团队召集通知
- 重置或更新召集状态标记
- 完成团队协作流程

状态管理：
- 状态1：正常召集完成，发送团队召集信号
- 其他状态：异常终止，重置为初始状态

参数说明：
@param f3_arg0 AI实体对象，管理召集状态和团队通信
@param f3_arg1 目标参数对象（此函数中未直接使用）

返回值：无

团队协作机制：
- 通过TeamHelp_Call()向团队成员发送召集信号
- 状态码9表示召集已发送，避免重复调用
- 状态码1表示就绪状态，可以重新开始召集
--]]
function CallTeam_Terminate(f3_arg0, f3_arg1)
    -- 获取当前召集状态标记
    local f3_local0 = f3_arg0:GetNumber(2)

    -- 检查是否为正常召集状态(1)
    if f3_local0 == 1 then
        -- 设置状态为已召集(9)，标记召集已完成
        f3_arg0:SetNumber(2, 9)
        -- 向团队发送召集信号，通知队友提供支援
        f3_arg0:TeamHelp_Call()
    else
        -- 非正常状态，重置为就绪状态(1)
        f3_arg0:SetNumber(2, 1)
    end

end

--[[
团队召集AI脚本 - 中断处理函数
处理召集过程中的意外中断情况，特别是受到伤害时的应急响应

功能描述：
- 监控召集过程中的中断事件
- 处理受伤中断，调整AI行为状态
- 确保中断后的状态一致性
- 支持紧急情况下的快速响应

中断类型：
- INTERUPT_Damaged：受到伤害中断，最常见的中断类型
- 其他中断类型可在此基础上扩展

参数说明：
@param f4_arg0 AI实体对象，检测中断事件并更新状态
@param f4_arg1 目标参数对象，获取目标生命值等信息

返回值：
@return true 发生中断，需要中断当前召集行为
@return false 无中断，可以继续执行召集

状态码说明：
- 状态4：表示因受伤而中断召集，后续可能触发报复或防御行为

应用场景：
- 召集过程中被玩家攻击
- 受到环境伤害打断
- 其他意外伤害事件
--]]
function CallTeam_Interupt(f4_arg0, f4_arg1)
    -- 获取目标生命值，用于上下文判断（虽然此函数中未直接使用）
    local f4_local0 = f4_arg1:GetLife()

    -- 检查是否受到伤害中断
    if f4_arg0:IsInterupt(INTERUPT_Damaged) then
        -- 设置状态为受伤中断(4)，标记召集被打断
        f4_arg0:SetNumber(2, 4)
        -- 返回true表示发生中断，需要终止当前召集行为
        return true
    end

    -- 没有中断事件，返回false继续执行召集
    return false

end


