--[[============================================================================
    011001_logic.lua - Sekiro AI什么都不做11001响应式逻辑控制器 (Sekiro AI Nothing-Do 11001 Responsive Logic Controller)

    版本信息 (Version Info): v3.0 - Comprehensive professional documentation
    作者 (Author): FromSoftware AI Team / Enhanced by Claude Code
    最后修改 (Last Modified): 2025-10-10
    编码格式 (Encoding): Shift-JIS (required for Sekiro compatibility)

    ============================================================================
    模块概述 (Module Overview):
    ============================================================================
    这是Sekiro AI系统的"什么都不做"11001响应式逻辑控制器，在基础等待功能的基础上
    增加了对特殊效果的响应能力。与011000_logic.lua不同，本模块能够响应快速转向
    玩家的特殊效果，实现更灵活的AI控制。

    核心功能 (Core Functions):
    ┌─ 响应式等待系统 (Responsive Wait System)
    │  ├─ 基础10秒等待状态
    │  └─ 监控快速转向玩家特殊效果
    │
    ├─ 特殊效果监控 (Special Effect Monitoring)
    │  ├─ COMMON_SP_EFFECT_QUICK_TURN_TO_PC效果监控
    │  └─ 实时特殊效果中断处理
    │
    └─ 智能转向响应 (Intelligent Turn Response)
       ├─ 自动清除当前目标
       ├─ 快速转向玩家位置
       └─ 短暂等待以稳定状态

    设计特点 (Design Features):
    - 响应性：能够对特定特殊效果做出快速反应
    - 稳定性：保持基础的等待状态直到被特殊效果触发
    - 智能性：自动处理转向和后续稳定化

    适用场景 (Application Scenarios):
    - 需要AI能够快速响应玩家位置的场景
    - 剧情演出中的定向反应
    - 测试环境中的可控AI行为

    ============================================================================
]]--

-- ■ 注册11001什么都不做响应式逻辑 (Register 11001 Nothing-Do Responsive Logic)
RegisterTableLogic(LOGIC_ID_Nanimosinai11001)

-- ■ 主逻辑函数 (Main Logic Function)
-- ■ 功能说明：设置AI的基础等待状态并监控特殊效果
-- ■ 与011000的区别：增加了特殊效果监控和更长的等待时间
-- ■ 参数说明 (Parameters):
-- ■   f1_arg0: AI参数对象 (AI parameter object)
-- ■   f1_arg1: AI实体对象 (AI entity object)
Logic.Main = function (f1_arg0, f1_arg1)
    -- ■ 添加特殊效果监控 (Add special effect monitoring)
    -- ■ 监控目标：TARGET_SELF - AI自身
    -- ■ 监控效果：COMMON_SP_EFFECT_QUICK_TURN_TO_PC - 快速转向玩家特殊效果
    -- ■ 当此效果激活时，AI将触发转向玩家的行为
    f1_arg1:AddObserveSpecialEffectAttribute(TARGET_SELF, COMMON_SP_EFFECT_QUICK_TURN_TO_PC)

    -- ■ 添加顶级等待目标 (Add top-level wait goal)
    -- ■ 参数详解：
    -- ■   GOAL_COMMON_Wait: 通用等待目标类型
    -- ■   10: 等待持续时间（秒）- 比011000的5秒更长
    -- ■   TARGET_NONE: 不指向任何目标，保持当前状态
    -- ■   0, 0, 0: 未使用的扩展参数
    f1_arg1:AddTopGoal(GOAL_COMMON_Wait, 10, TARGET_NONE, 0, 0, 0)
end

-- ■ 中断处理函数 (Interrupt Handler Function)
-- ■ 功能说明：处理特殊效果激活中断，实现快速转向玩家的响应
-- ■ 参数说明 (Parameters):
-- ■   f2_arg0: AI参数对象 (AI parameter object)
-- ■   f2_arg1: AI实体对象 (AI entity object)
-- ■   f2_arg2: 子目标管理器 (Sub-goal manager)
-- ■ 返回值 (Return Value):
-- ■   true: 处理了中断事件
-- ■   false: 未处理中断事件
Logic.Interrupt = function (f2_arg0, f2_arg1, f2_arg2)
    -- ■ 检查是否为特殊效果激活中断 (Check if it's a special effect activation interrupt)
    if f2_arg1:IsInterupt(INTERUPT_ActivateSpecialEffect) then
        -- ■ 获取激活的特殊效果类型 (Get the activated special effect type)
        local activatedEffect = f2_arg1:GetSpecialEffectActivateInterruptType(0)

        -- ■ 检查是否为快速转向玩家效果 (Check if it's the quick turn to PC effect)
        if activatedEffect == COMMON_SP_EFFECT_QUICK_TURN_TO_PC then
            -- ■ 清除所有当前子目标 (Clear all current sub-goals)
            f2_arg2:ClearSubGoal()

            -- ■ 添加转向玩家目标 (Add turn to player goal)
            -- ■ 参数详解：
            -- ■   GOAL_COMMON_Turn: 通用转向目标
            -- ■   3: 转向持续时间（秒）
            -- ■   TARGET_LOCALPLAYER: 转向本地玩家
            -- ■   20: 转向速度参数
            -- ■   -1: 角度限制（-1表示无限制）
            -- ■   GOAL_RESULT_Success: 预期结果类型
            -- ■   true: 启用平滑转向
            f2_arg1:AddTopGoal(GOAL_COMMON_Turn, 3, TARGET_LOCALPLAYER, 20, -1, GOAL_RESULT_Success, true)

            -- ■ 添加短暂等待以稳定状态 (Add brief wait to stabilize state)
            -- ■ 0.5秒的短暂等待确保转向完成后AI状态稳定
            f2_arg1:AddTopGoal(GOAL_COMMON_Wait, 0.5, TARGET_LOCALPLAYER, 0, 0, 0)

            -- ■ 返回true表示成功处理了中断 (Return true indicating successful interrupt handling)
            return true
        end
    end

    -- ■ 未处理任何中断，返回false (No interrupt handled, return false)
    return false
end


