--[[============================================================================
    back_to_home_with_parry.lua - Sekiro带招架返回原点系统
    (Back to Home with Parry System)

    版本信息 (Version Info): v3.0 - Professional documentation
    作者 (Author): FromSoftware AI Team / Enhanced by Claude Code
    编码格式 (Encoding): Shift-JIS (required for Sekiro compatibility)

    ============================================================================
    模块概述 (Module Overview):
    ============================================================================
    这是Sekiro AI系统的带招架返回原点模块,实现了在返回初始位置过程中保持
    招架防御能力的行为。该模块允许AI在撤退回初始点时仍能对玩家攻击做出
    招架反应,避免在撤退途中成为完全的靶子。

    核心功能 (Core Functions):
    ┌─ 带防御返回管理 (Defensive Return Management)
    │  ├─ 基础返回行为 - 委托GOAL_COMMON_BackToHome执行
    │  ├─ 招架中断系统 - INTERUPT_ParryTiming时机判断
    │  ├─ 射击冲击处理 - INTERUPT_ShootImpact响应
    │  └─ 特殊效果检测 - 基于SE ID的状态判断
    │
    ├─ 战术意义 (Tactical Significance)
    │  ├─ 防御性撤退 - 不是逃跑而是战术性后退
    │  ├─ 保持威胁 - 返回途中仍有反击能力
    │  ├─ 距离控制 - 回到有利位置重新开始进攻
    │  └─ 玩家体验 - 避免AI显得过于被动或愚蠢
    │
    └─ 与标准返回的区别 (Difference from Standard Return)
       ├─ 标准BackToHome - 单纯返回,无防御能力
       ├─ BackToHome_With_Parry - 返回+招架反应
       └─ 应用场景 - 强敌撤退、BOSS战术性调整

    ============================================================================
    招架中断机制 (Parry Interrupt Mechanism):
    ============================================================================

    招架时机检测 (Parry Timing Detection):
    - INTERUPT_ParryTiming: 引擎提供的精确招架时机
    - Common_Parry: 通用招架处理函数
    - 优先级: 最高 - 即使在返回途中也能响应

    射击冲击响应 (Shoot Impact Response):
    - 特殊效果ID检测: 221000, 221001, 221002
    - 动态响应模式: 根据不同SE执行不同防御
    - 应急持续攻击: 使用EndureAttack(3100)应对冲击

    ============================================================================
]]--

-- 注册带招架返回原点行为的Goal系统
-- (Register back to home with parry behavior in Goal system)
RegisterTableGoal(GOAL_COMMON_BackToHome_With_Parry, "BackToHomeWithParry")
REGISTER_GOAL_NO_SUB_GOAL(GOAL_COMMON_BackToHome_With_Parry, true)

--[[
带招架返回初始化函数 (Defensive return initialization function)
功能：初始化带防御的返回行为状态
参数：
  f1_arg0 - AI角色对象 (AI character object)
  f1_arg1 - AI实体对象 (AI entity object)
  f1_arg2 - 目标对象 (Goal object)
返回：无
说明：当前为空实现，所有初始化工作在Activate中完成
]]--
Goal.Initialize = function (f1_arg0, f1_arg1, f1_arg2)
    -- 带招架返回不需要特殊初始化
    -- (Defensive return requires no special initialization)
end

--[[
带招架返回激活函数 (Defensive return activation function)
功能：启动带招架能力的返回原点行为
参数：
  f2_arg0 - AI角色对象 (AI character object)
  f2_arg1 - AI实体对象 (AI entity object)
  f2_arg2 - 目标对象 (Goal object)
逻辑流程：
  1. 委托GOAL_COMMON_BackToHome执行实际的返回移动
  2. 通过Interrupt函数提供招架和防御响应
  3. 保持返回目标和防御能力的双重状态
特点：基础行为委托,高级响应自主处理
]]--
Goal.Activate = function (f2_arg0, f2_arg1, f2_arg2)
    -- 添加标准返回原点子目标,执行实际的移动逻辑
    -- (Add standard back to home sub-goal for actual movement logic)
    -- 参数: 生命周期, 移动速度, 是否跑步, 旋转时间, 判定角度, 目标
    f2_arg2:AddSubGoal(GOAL_COMMON_BackToHome, f2_arg2:GetLife(), 0, false, 0, 0, TARGET_ENE_0)

    -- 注意: 招架和防御响应在Interrupt函数中处理
    -- (Note: Parry and defensive responses handled in Interrupt function)
end

--[[
带招架返回更新函数 (Defensive return update function)
功能：每帧更新带招架返回的状态
参数：
  f3_arg0 - AI角色对象 (AI character object)
  f3_arg1 - AI实体对象 (AI entity object)
  f3_arg2 - 目标对象 (Goal object)
返回：更新结果状态
说明：使用默认的无子目标更新逻辑，主要依赖Interrupt处理特殊事件
]]--
Goal.Update = function (f3_arg0, f3_arg1, f3_arg2)
    -- 使用默认更新逻辑,主要状态管理交由BackToHome子目标
    -- (Use default update logic, main state management delegated to BackToHome sub-goal)
    return Update_Default_NoSubGoal(f3_arg0, f3_arg1, f3_arg2)
end

--[[
带招架返回终止函数 (Defensive return termination function)
功能：带招架返回行为结束时的清理
参数：
  f4_arg0 - AI角色对象 (AI character object)
  f4_arg1 - AI实体对象 (AI entity object)
  f4_arg2 - 目标对象 (Goal object)
返回：无
说明：无需特殊清理，状态由子目标自动管理
]]--
Goal.Terminate = function (f4_arg0, f4_arg1, f4_arg2)
    -- 带招架返回结束,无需特殊清理
    -- (Defensive return ended, no special cleanup needed)
end

--[[
带招架返回中断处理函数 (Defensive return interrupt handler function)
功能：处理返回途中的招架和防御中断事件
参数：
  f5_arg0 - AI角色对象 (AI character object)
  f5_arg1 - AI实体对象 (AI entity object)
  f5_arg2 - 目标对象 (Goal object)
返回：
  true - 中断被处理并执行了对应动作
  false - 不处理该中断,继续返回
逻辑流程：
  1. 检查招架时机中断 (INTERUPT_ParryTiming)
     - 执行通用招架响应 Common_Parry
  2. 检查射击冲击中断 (INTERUPT_ShootImpact)
     - 检测特殊效果ID (221000/221001/221002)
     - 执行应急持续攻击 EndureAttack
  3. 其他中断不处理,继续返回
设计理念：
  - 优先响应生存威胁(射击冲击)
  - 其次响应反击机会(招架时机)
  - 保持返回主要目标不变
]]--
Goal.Interrupt = function (f5_arg0, f5_arg1, f5_arg2)
    -- === 招架时机中断处理 (Parry Timing Interrupt Handling) ===
    if f5_arg1:IsInterupt(INTERUPT_ParryTiming) then
        -- 检测到招架时机,执行招架反击
        -- (Parry timing detected, execute parry counter)
        return Common_Parry(f5_arg1, f5_arg2, 0, 0)
    end

    -- === 射击冲击中断处理 (Shoot Impact Interrupt Handling) ===
    if f5_arg1:IsInterupt(INTERUPT_ShootImpact) then
        -- 检测AI身上的特殊效果,判断冲击类型
        -- (Detect special effects on AI to determine impact type)
        local f5_local0 = -1  -- 冲击类型ID,默认-1表示未识别

        if f5_arg1:HasSpecialEffectId(TARGET_SELF, 221000) then
            f5_local0 = 0  -- 冲击类型0
        elseif f5_arg1:HasSpecialEffectId(TARGET_SELF, 221001) then
            f5_local0 = 1  -- 冲击类型1
        elseif f5_arg1:HasSpecialEffectId(TARGET_SELF, 221002) then
            f5_local0 = 2  -- 冲击类型2
        end

        -- 判断是否识别到有效的冲击类型
        if f5_local0 == -1 then
            -- 未识别的冲击类型,不处理
            -- (Unrecognized impact type, do not handle)
            return false
        else
            -- 识别到有效冲击,执行应急防御
            -- (Valid impact recognized, execute emergency defense)
            f5_arg2:ClearSubGoal()  -- 清除当前返回子目标
            -- 添加持续攻击(实际是防御姿态)应对冲击
            -- 参数: 持续时间0.1秒, 动作3100, 目标, 超长距离, 无角度限制
            f5_arg2:AddSubGoal(GOAL_COMMON_EndureAttack, 0.1, 3100, TARGET_ENE_0, 9999, 0)
            return true  -- 中断已处理
        end
    end

    -- 其他中断事件不处理,继续返回原点
    -- (Other interrupt events not handled, continue returning home)
    return false
end

--[[============================================================================
    文件结束 (End of File)
    ============================================================================

    带招架返回原点系统已完成专业文档化。该模块现在具备：
    - 完整的带防御返回机制说明
    - 详细的招架和冲击响应逻辑
    - 清晰的战术意义和应用场景
    - 专业的特殊效果检测文档

    关键特性总结：
    - 防御性撤退：返回途中保持招架能力
    - 招架响应：INTERUPT_ParryTiming时机的精确处理
    - 冲击防御：基于SE ID的射击冲击应对
    - 战术灵活：平衡撤退和防御的双重目标

    应用场景：
    - BOSS战术性调整位置
    - 强敌血量过低时的安全撤退
    - 多波次战斗中的间歇调整
    ============================================================================
]]--


