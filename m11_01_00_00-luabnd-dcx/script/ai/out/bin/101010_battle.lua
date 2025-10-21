-- ====================================================================================================
-- 101010_battle.lua - 落武者八双 (双剑武士) 战斗AI
-- ====================================================================================================
-- 敌人类型: 落武者八双 (Ochimusha Hassou)
-- 地图区域: m11_01_00_00 (苇名城)
-- 战斗风格: 高速双剑连击，具备快速移动和强大压制力
-- 主要特点:
--   - 7种攻击模式: 快速连击、横扫、跳跃等
--   - 移动灵活: 侧步、后退规避
--   - 8种特殊招式: 根据距离和敌人防御选择
--   - 距离战术: 根据距离动态调整(7米/5米/3米/1米以下)
--   - 特效触发: 对特定特效(5020/5021)有加速响应
--   - 冷却管理: 防止同一招式频繁使用
-- ====================================================================================================

RegisterTableGoal(GOAL_Ochimusha_hassou_101010_Battle, "GOAL_Ochimusha_hassou_101010_Battle")
REGISTER_GOAL_NO_UPDATE(GOAL_Ochimusha_hassou_101010_Battle, true)

-- 初始化函数（当前为空实现）
Goal.Initialize = function (f1_arg0, f1_arg1, f1_arg2, f1_arg3)

end

-- ====================================================================================================
-- 激活函数 - 战斗AI的核心决策逻辑
-- ====================================================================================================
-- 功能: 根据当前战斗状态（HP、SP、距离、特效等）选择最优行动
-- 处理流程: 初始化参数 -> 检查剑戟 -> 获取状态 -> 决策行为 -> 空间检查 -> 设置冷却 -> 激活行为
-- ====================================================================================================
Goal.Activate = function (f2_arg0, f2_arg1, f2_arg2)
    Init_Pseudo_Global(f2_arg1, f2_arg2)
    -- 初始化行动权重表
    local f2_local0 = {}
    -- 注册行动函数表
    local f2_local1 = {}
    -- 参数表（当前未使用）
    local f2_local2 = {}
    Common_Clear_Param(f2_local0, f2_local1, f2_local2)
    -- 获取与目标敌人的距离
    local f2_local3 = f2_arg1:GetDist(TARGET_ENE_0)
    -- 获取AI参数：是否为学徒状态(0=正常, 1=学徒模式)
    local f2_local4 = f2_arg1:GetExcelParam(AI_EXCEL_THINK_PARAM_TYPE__thinkAttr_doAdmirer)
    -- 监听特效：109031=姿态被破坏
    f2_arg1:AddObserveSpecialEffectAttribute(TARGET_ENE_0, 109031)
    -- 监听特效：107900=见切时机
    f2_arg1:AddObserveSpecialEffectAttribute(TARGET_SELF, 107900)
    Set_ConsecutiveGuardCount_Interrupt(f2_arg1)
    -- 检查是否能激活剑戟反击，若能则直接返回
    if f2_arg0.Kengeki_Activate(f2_arg0, f2_arg1, f2_arg2) then
        return
    end
    -- ====== 状态检查及行动决策 ======
    -- 特殊状态1: 敌人处于处决状态 (3170200)
    if f2_arg1:HasSpecialEffectId(TARGET_ENE_0, 3170200) then
        -- 处决状态下：逃离(权重1000)和基础攻击(权重1)
        f2_local0[25] = 1000
        f2_local0[1] = 1
    -- 特殊状态2: 敌人被推倒 (3101540)
    elseif f2_arg1:HasSpecialEffectId(TARGET_ENE_0, 3101540) then
        -- 推倒状态下：环绕移动(权重100)
        f2_local0[27] = 100
    -- 特殊事件触发
    elseif Common_ActivateAct(f2_arg1, f2_arg2) then
    -- 特殊模式检查: 双剑特殊攻击(5020/5021)
    elseif f2_arg1:HasSpecialEffectId(TARGET_SELF, 5020) or f2_arg1:HasSpecialEffectId(TARGET_SELF, 5021) then
        -- 双剑模式下：侧向移动权重提高(600)
        f2_local0[23] = 600
    -- 路径检查: 无法到达敌人或敌人失衡状态(109220/109221)
    elseif f2_arg1:CheckDoesExistPath(TARGET_ENE_0, AI_DIR_TYPE_F, 0, 0) == false or f2_arg1:HasSpecialEffectId(TARGET_ENE_0, 109220) or f2_arg1:HasSpecialEffectId(TARGET_ENE_0, 109221) then
        -- 无路径或失衡：远距离攻击(3010,权重100)和环绕移动
        f2_local0[10] = 100
        f2_local0[27] = 100
    -- 团队AI: 观客角色处理
    elseif f2_local4 == 1 and f2_arg1:GetTeamOrder(ORDER_TYPE_Role) == ROLE_TYPE_Kankyaku then
        KankyakuAct(f2_arg1, f2_arg2)
    -- 团队AI: 包围角色处理
    elseif f2_local4 == 1 and f2_arg1:GetTeamOrder(ORDER_TYPE_Role) == ROLE_TYPE_Torimaki then
        if TorimakiAct(f2_arg1, f2_arg2) == true then
            -- 包围模式：基础攻击和跳跃斩击
            f2_local0[1] = 10
            f2_local0[4] = 10
            -- 检查特殊效果：3101500
            if f2_arg1:HasSpecialEffectId(TARGET_SELF, 3101500) then
                f2_local0[10] = 500
            end
        end
    -- 定时器检查：等待第一击完成
    elseif f2_arg1:IsFinishTimer(0) == false then
        f2_local0[1] = 1
        f2_local0[23] = 1000
    -- ====== 距离分层战术 ======
    -- 距离 >= 7米: 远距离阶段 - 使用远程攻击接近敌人
    elseif f2_local3 >= 7 then
        f2_local0[1] = 1
        f2_local0[2] = 200      -- 冲刺斩击
        f2_local0[4] = 0        -- 禁用
        f2_local0[5] = 100      -- 跳跃攻击
        f2_local0[6] = 0        -- 禁用
        f2_local0[23] = 600     -- 侧向移动
    -- 距离 >= 5米: 中距离阶段 - 多重攻击与移动
    elseif f2_local3 >= 5 then
        f2_local0[1] = 100      -- 基础连击
        f2_local0[2] = 200      -- 冲刺斩击
        f2_local0[4] = 0        -- 禁用
        f2_local0[5] = 100      -- 跳跃攻击
        f2_local0[6] = 0        -- 禁用
        f2_local0[23] = 1200    -- 侧向移动
    -- 距离 >= 3米: 中近距离阶段 - 增加连击与破防频率
    elseif f2_local3 >= 3 then
        f2_local0[1] = 100      -- 基础连击
        f2_local0[2] = 200      -- 冲刺斩击
        f2_local0[4] = 0        -- 禁用
        f2_local0[5] = 100      -- 跳跃攻击
        f2_local0[6] = 300      -- 特殊连击
        f2_local0[23] = 1200    -- 侧向移动
    -- 距离 >= 1米: 近距离阶段 - 近战连续压制
    elseif f2_local3 >= 1 then
        f2_local0[1] = 200      -- 基础连击(高权重)
        f2_local0[2] = 100      -- 冲刺斩击
        f2_local0[4] = 100      -- 跳跃斩击
        f2_local0[5] = 0        -- 禁用
        f2_local0[6] = 200      -- 特殊连击
        f2_local0[23] = 0       -- 侧向移动禁用
        f2_local1[24] = 0       -- 后退禁用
    -- 距离 < 1米: 贴身距离 - 极限压制
    else
        f2_local0[1] = 100      -- 基础连击
        f2_local0[2] = 100      -- 冲刺斩击
        f2_local0[3] = 0        -- 禁用
        f2_local0[4] = 200      -- 跳跃斩击(高权重)
        f2_local0[5] = 0        -- 禁用
        f2_local0[6] = 400      -- 特殊连击(超高权重)
        f2_local0[23] = 0       -- 侧向移动禁用
    end
    if SpaceCheck(f2_arg1, f2_arg2, 45, 2) == false and SpaceCheck(f2_arg1, f2_arg2, -45, 2) == false then
        f2_local0[22] = 0
    end
    if SpaceCheck(f2_arg1, f2_arg2, 90, 1) == false and SpaceCheck(f2_arg1, f2_arg2, -90, 1) == false then
        f2_local0[23] = 0
    end
    if SpaceCheck(f2_arg1, f2_arg2, 180, 2) == false then
        f2_local0[24] = 0
    end
    if SpaceCheck(f2_arg1, f2_arg2, 180, 1) == false then
        f2_local0[25] = 0
    end
    f2_local0[1] = SetCoolTime(f2_arg1, f2_arg2, 3000, 5, f2_local0[1], 1)
    f2_local0[2] = SetCoolTime(f2_arg1, f2_arg2, 3002, 10, f2_local0[2], 1)
    f2_local0[3] = SetCoolTime(f2_arg1, f2_arg2, 3003, 5, f2_local0[3], 1)
    f2_local0[4] = SetCoolTime(f2_arg1, f2_arg2, 3004, 5, f2_local0[4], 1)
    f2_local0[5] = SetCoolTime(f2_arg1, f2_arg2, 3006, 10, f2_local0[5], 1)
    f2_local0[6] = SetCoolTime(f2_arg1, f2_arg2, 3007, 5, f2_local0[6], 1)
    f2_local0[10] = SetCoolTime(f2_arg1, f2_arg2, 3009, 5, f2_local0[10], 1)
    f2_local1[1] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act01)
    f2_local1[2] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act02)
    f2_local1[3] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act03)
    f2_local1[4] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act04)
    f2_local1[5] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act05)
    f2_local1[6] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act06)
    f2_local1[7] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act07)
    f2_local1[10] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act10)
    f2_local1[21] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act21)
    f2_local1[22] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act22)
    f2_local1[23] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act23)
    f2_local1[24] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act24)
    f2_local1[25] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act25)
    f2_local1[26] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act26)
    f2_local1[27] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act27)
    f2_local1[28] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act28)
    f2_local1[41] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act41)
    local f2_local5 = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.ActAfter_AdjustSpace)
    Common_Battle_Activate(f2_arg1, f2_arg2, f2_local0, f2_local1, f2_local5, f2_local2)
    
end

-- Act01 - 基础双剑连击 (3000->3001, 3.5米, 冷却5秒)
-- 功能: 快速双剑连击，是最常用的基础攻击
-- 特点:
--   - 距离要求: 3.5米
--   - 攻击ID: 3000(主攻击) -> 3001(最终击)
--   - 旋转限制: 0.5秒, 最大旋转角度90度
--   - 权重: 中等，在各距离段均有使用
Goal.Act01 = function (f3_arg0, f3_arg1, f3_arg2)
    local f3_local0 = 3.5 - f3_arg0:GetMapHitRadius(TARGET_SELF)
    local f3_local1 = 3.5 - f3_arg0:GetMapHitRadius(TARGET_SELF) + 2
    local f3_local2 = 3.5 - f3_arg0:GetMapHitRadius(TARGET_SELF) + 2
    local f3_local3 = 100
    local f3_local4 = 0
    local f3_local5 = 1.5
    local f3_local6 = 3
    Approach_Act_Flex(f3_arg0, f3_arg1, f3_local0, f3_local1, f3_local2, f3_local3, f3_local4, f3_local5, f3_local6)
    local f3_local7 = 3 - f3_arg0:GetMapHitRadius(TARGET_SELF)
    local f3_local8 = 5.8 - f3_arg0:GetMapHitRadius(TARGET_SELF)
    local f3_local9 = 0.5
    local f3_local10 = 90
    f3_arg1:AddSubGoal(GOAL_COMMON_ComboAttackTunableSpin, 10, 3000, TARGET_ENE_0, f3_local7, f3_local9, f3_local10, 0, 0)
    f3_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3001, TARGET_ENE_0, 9999, 0, 0)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds

end

Goal.Act02 = function (f4_arg0, f4_arg1, f4_arg2)
    local f4_local0 = 5.8 - f4_arg0:GetMapHitRadius(TARGET_SELF)
    local f4_local1 = 5.8 - f4_arg0:GetMapHitRadius(TARGET_SELF) + 2
    local f4_local2 = 5.8 - f4_arg0:GetMapHitRadius(TARGET_SELF) + 2
    local f4_local3 = 100
    local f4_local4 = 0
    local f4_local5 = 1.5
    local f4_local6 = 3
    Approach_Act_Flex(f4_arg0, f4_arg1, f4_local0, f4_local1, f4_local2, f4_local3, f4_local4, f4_local5, f4_local6)
    local f4_local7 = 0.5
    local f4_local8 = 90
    f4_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 10, 3002, TARGET_ENE_0, 9999, f4_local7, f4_local8, 0, 0)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act03 = function (f5_arg0, f5_arg1, f5_arg2)
    local f5_local0 = 5.4 - f5_arg0:GetMapHitRadius(TARGET_SELF)
    local f5_local1 = 5.4 - f5_arg0:GetMapHitRadius(TARGET_SELF) + 2
    local f5_local2 = 5.4 - f5_arg0:GetMapHitRadius(TARGET_SELF) + 2
    local f5_local3 = 100
    local f5_local4 = 0
    local f5_local5 = 1.5
    local f5_local6 = 3
    Approach_Act_Flex(f5_arg0, f5_arg1, f5_local0, f5_local1, f5_local2, f5_local3, f5_local4, f5_local5, f5_local6)
    local f5_local7 = 0.5
    local f5_local8 = 90
    f5_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 10, 3003, TARGET_ENE_0, 9999, f5_local7, f5_local8, 0, 0)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act04 = function (f6_arg0, f6_arg1, f6_arg2)
    local f6_local0 = 3.3 - f6_arg0:GetMapHitRadius(TARGET_SELF)
    local f6_local1 = 3.3 - f6_arg0:GetMapHitRadius(TARGET_SELF) + 2
    local f6_local2 = 3.3 - f6_arg0:GetMapHitRadius(TARGET_SELF) + 2
    local f6_local3 = 100
    local f6_local4 = 0
    local f6_local5 = 1.5
    local f6_local6 = 3
    Approach_Act_Flex(f6_arg0, f6_arg1, f6_local0, f6_local1, f6_local2, f6_local3, f6_local4, f6_local5, f6_local6)
    local f6_local7 = 3.8 - f6_arg0:GetMapHitRadius(TARGET_SELF)
    local f6_local8 = 0.5
    local f6_local9 = 90
    f6_arg1:AddSubGoal(GOAL_COMMON_ComboAttackTunableSpin, 10, 3004, TARGET_ENE_0, f6_local7, f6_local8, f6_local9, 0, 0)
    f6_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3005, TARGET_ENE_0, 9999, 0, 0)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act05 = function (f7_arg0, f7_arg1, f7_arg2)
    local f7_local0 = f7_arg0:GetDist(TARGET_ENE_0)
    local f7_local1 = 3.3 - f7_arg0:GetMapHitRadius(TARGET_SELF)
    local f7_local2 = 3.3 - f7_arg0:GetMapHitRadius(TARGET_SELF) + 2
    local f7_local3 = 3.3 - f7_arg0:GetMapHitRadius(TARGET_SELF) + 2
    local f7_local4 = 100
    local f7_local5 = 0
    local f7_local6 = 1.5
    local f7_local7 = 3
    local f7_local8 = 0.5
    local f7_local9 = 90
    Approach_Act_Flex(f7_arg0, f7_arg1, f7_local1, f7_local2, f7_local3, f7_local4, f7_local5, f7_local6, f7_local7)
    f7_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 10, 3006, TARGET_ENE_0, 9999, f7_local8, f7_local9, 0, 0)
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
    
end

Goal.Act06 = function (f8_arg0, f8_arg1, f8_arg2)
    local f8_local0 = f8_arg0:GetDist(TARGET_ENE_0)
    local f8_local1 = 2.8 - f8_arg0:GetMapHitRadius(TARGET_SELF)
    local f8_local2 = 2.8 - f8_arg0:GetMapHitRadius(TARGET_SELF) + 2
    local f8_local3 = 2.8 - f8_arg0:GetMapHitRadius(TARGET_SELF) + 2
    local f8_local4 = 100
    local f8_local5 = 0
    local f8_local6 = 1.5
    local f8_local7 = 3
    local f8_local8 = 0.5
    local f8_local9 = 90
    Approach_Act_Flex(f8_arg0, f8_arg1, f8_local1, f8_local2, f8_local3, f8_local4, f8_local5, f8_local6, f8_local7)
    f8_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 10, 3007, TARGET_ENE_0, 9999, f8_local8, f8_local9, 0, 0)
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
    
end

Goal.Act07 = function (f9_arg0, f9_arg1, f9_arg2)
    local f9_local0 = f9_arg0:GetDist(TARGET_ENE_0)
    local f9_local1 = 3 - f9_arg0:GetMapHitRadius(TARGET_SELF)
    local f9_local2 = 3 - f9_arg0:GetMapHitRadius(TARGET_SELF) + 2
    local f9_local3 = 3 - f9_arg0:GetMapHitRadius(TARGET_SELF) + 2
    local f9_local4 = 100
    local f9_local5 = 0
    local f9_local6 = 1.5
    local f9_local7 = 3
    local f9_local8 = 0.5
    local f9_local9 = 90
    Approach_Act_Flex(f9_arg0, f9_arg1, f9_local1, f9_local2, f9_local3, f9_local4, f9_local5, f9_local6, f9_local7)
    f9_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 10, 3010, TARGET_ENE_0, 9999, f9_local8, f9_local9, 0, 0)
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
    
end

Goal.Act10 = function (f10_arg0, f10_arg1, f10_arg2)
    local f10_local0 = 10 - f10_arg0:GetMapHitRadius(TARGET_SELF)
    local f10_local1 = 10 - f10_arg0:GetMapHitRadius(TARGET_SELF) + 2
    local f10_local2 = 10 - f10_arg0:GetMapHitRadius(TARGET_SELF) + 2
    local f10_local3 = 100
    local f10_local4 = 0
    local f10_local5 = 1.5
    local f10_local6 = 3
    local f10_local7 = 0.5
    local f10_local8 = 90
    f10_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 10, 3009, TARGET_ENE_0, 9999, f10_local7, f10_local8, 0, 0)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act21 = function (f11_arg0, f11_arg1, f11_arg2)
    local f11_local0 = 3
    local f11_local1 = 45
    f11_arg1:AddSubGoal(GOAL_COMMON_Turn, f11_local0, TARGET_ENE_0, f11_local1, -1, GOAL_RESULT_Success, true)
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
    
end

Goal.Act22 = function (f12_arg0, f12_arg1, f12_arg2)
    local f12_local0 = 3
    local f12_local1 = 0
    local f12_local2 = 5202
    if SpaceCheck(f12_arg0, f12_arg1, -45, 2) == true then
        if SpaceCheck(f12_arg0, f12_arg1, 45, 2) == true then
            if f12_arg0:IsInsideTarget(TARGET_ENE_0, AI_DIR_TYPE_R, 180) then
                f12_local2 = 5202
            else
                f12_local2 = 5203
            end
        else
            f12_local2 = 5202
        end
    elseif SpaceCheck(f12_arg0, f12_arg1, 45, 2) == true then
        f12_local2 = 5203
    else
    end
    f12_arg1:AddSubGoal(GOAL_COMMON_SpinStep, f12_local0, f12_local2, TARGET_ENE_0, f12_local1, AI_DIR_TYPE_R, 0)
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
    
end

Goal.Act23 = function (f13_arg0, f13_arg1, f13_arg2)
    local f13_local0 = f13_arg0:GetDist(TARGET_ENE_0)
    local f13_local1 = f13_arg0:GetSp(TARGET_SELF)
    local f13_local2 = 20
    local f13_local3 = f13_arg0:GetRandam_Int(1, 100)
    local f13_local4 = -1
    if f13_arg0:IsFinishTimer(0) == false then
        f13_local4 = 9910
    end
    local f13_local5 = 0
    if SpaceCheck(f13_arg0, f13_arg1, -90, 1) == true then
        if SpaceCheck(f13_arg0, f13_arg1, 90, 1) == true then
            if f13_arg0:IsInsideTargetEx(TARGET_ENE_0, TARGET_SELF, AI_DIR_TYPE_R, 180, 999) then
                f13_local5 = 1
            else
                f13_local5 = 0
            end
        else
            f13_local5 = 0
        end
    elseif SpaceCheck(f13_arg0, f13_arg1, 90, 1) == true then
        f13_local5 = 1
    else
    end
    local f13_local6 = 3
    local f13_local7 = f13_arg0:GetRandam_Int(30, 45)
    f13_arg0:SetNumber(10, f13_local5)
    f13_arg0:SetTimer(2, f13_local6)
    f13_arg1:AddSubGoal(GOAL_COMMON_SidewayMove, f13_local6, TARGET_ENE_0, f13_local5, f13_local7, true, true, f13_local4)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act24 = function (f14_arg0, f14_arg1, f14_arg2)
    local f14_local0 = f14_arg0:GetDist(TARGET_ENE_0)
    local f14_local1 = 3
    local f14_local2 = 0
    local f14_local3 = 5201
    if SpaceCheck(f14_arg0, f14_arg1, 180, 2) ~= true or SpaceCheck(f14_arg0, f14_arg1, 180, 4) ~= true or f14_local0 > 4 then
    else
        f14_local3 = 5211
        if false then
        else
        end
    end
    f14_arg1:AddSubGoal(GOAL_COMMON_SpinStep, f14_local1, f14_local3, TARGET_ENE_0, f14_local2, AI_DIR_TYPE_B, 0)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act25 = function (f15_arg0, f15_arg1, f15_arg2)
    local f15_local0 = f15_arg0:GetSp(TARGET_SELF)
    local f15_local1 = 0
    local f15_local2 = f15_arg0:GetRandam_Int(1, 100)
    local f15_local3 = -1
    if f15_local1 <= f15_local0 and f15_local2 <= 100 or f15_arg0:HasSpecialEffectId(TARGET_ENE_0, 3170200) then
        f15_local3 = 9910
    end
    local f15_local4 = f15_arg0:GetRandam_Float(3, 5)
    local f15_local5 = 5
    if f15_arg0:HasSpecialEffectId(TARGET_ENE_0, 3170200) then
        f15_local5 = 999
    end
    if SpaceCheck(f15_arg0, f15_arg1, 180, 1) == true then
        f15_arg1:AddSubGoal(GOAL_COMMON_LeaveTarget, f15_local4, TARGET_ENE_0, f15_local5, TARGET_ENE_0, true, f15_local3)
    else
    end
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
    
end

Goal.Act26 = function (f16_arg0, f16_arg1, f16_arg2)
    f16_arg1:AddSubGoal(GOAL_COMMON_Wait, 0.5, TARGET_SELF, 0, 0, 0)
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
    
end

Goal.Act27 = function (f17_arg0, f17_arg1, f17_arg2)
    local f17_local0 = f17_arg0:GetRandam_Int(1, 100)
    if YousumiAct_SubGoal(f17_arg0, f17_arg1, true, 60, 30) == false then
        GetWellSpace_Odds = 0
        return GetWellSpace_Odds
    end
    local f17_local1 = 0
    local f17_local2 = SpaceCheck_SidewayMove(f17_arg0, f17_arg1, 1)
    if f17_local2 == 0 then
        f17_local1 = 0
    elseif f17_local2 == 1 then
        f17_local1 = 1
    elseif f17_local2 == 2 then
        if f17_local0 <= 50 then
            f17_local1 = 0
        else
            f17_local1 = 1
        end
    else
        f17_arg1:AddSubGoal(GOAL_COMMON_Wait, 1, TARGET_SELF, 0, 0, 0)
        GetWellSpace_Odds = 0
        return GetWellSpace_Odds
    end
    f17_arg0:SetNumber(10, f17_local1)
    f17_arg1:AddSubGoal(GOAL_COMMON_SidewayMove, 3, TARGET_ENE_0, f17_local1, f17_arg0:GetRandam_Int(30, 45), true, true, -1)
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
    
end

Goal.Act28 = function (f18_arg0, f18_arg1, f18_arg2)
    local f18_local0 = f18_arg0:GetDist(TARGET_ENE_0)
    local f18_local1 = 1.5
    local f18_local2 = 1.5
    local f18_local3 = f18_arg0:GetRandam_Int(30, 45)
    local f18_local4 = -1
    local f18_local5 = f18_arg0:GetRandam_Int(0, 1)
    if f18_local0 <= 3 then
        f18_arg1:AddSubGoal(GOAL_COMMON_SidewayMove, f18_local1, TARGET_ENE_0, f18_local5, f18_local3, true, true, f18_local4)
    elseif f18_local0 <= 8 then
        Approach_Act_Flex(f18_arg0, f18_arg1, 3, 3, 3, 100, 0, 1.5, 3)
    else
        Approach_Act_Flex(f18_arg0, f18_arg1, 8, 999, 999, 0, 0, 1.5, 3)
    end
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
    
end

Goal.Act41 = function (f19_arg0, f19_arg1, f19_arg2)
    local f19_local0 = 3.5
    local f19_local1 = f19_arg0:GetRandam_Int(30, 45)
    local f19_local2 = 0
    if SpaceCheck(f19_arg0, f19_arg1, -90, 1) == true then
        if SpaceCheck(f19_arg0, f19_arg1, 90, 1) == true then
            if f19_arg0:IsInsideTarget(TARGET_ENE_0, AI_DIR_TYPE_R, 180) then
                f19_local2 = 0
            else
                f19_local2 = 1
            end
        else
            f19_local2 = 0
        end
    elseif SpaceCheck(f19_arg0, f19_arg1, 90, 1) == true then
        f19_local2 = 1
    else
    end
    f19_arg1:AddSubGoal(GOAL_COMMON_SidewayMove, f19_local0, TARGET_ENE_0, f19_local2, f19_local1, true, true, -1)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

-- ====================================================================================================
-- 中断处理函数
-- ====================================================================================================
-- 功能: 处理战斗中的各种中断事件
-- 中断类型: 梯子动作/特效触发/弹反时机/伤害反应/射击冲击等
-- ====================================================================================================
Goal.Interrupt = function (f20_arg0, f20_arg1, f20_arg2)
    local f20_local0 = f20_arg1:GetSpecialEffectActivateInterruptType(0)
    -- 检查是否在梯子上，若是则无法中断
    if f20_arg1:IsLadderAct(TARGET_SELF) then
        return false
    end
    -- 检查是否具备战斗能力特效(200004)
    if not f20_arg1:HasSpecialEffectId(TARGET_SELF, 200004) then
        return false
    end
    -- 检查弹反时机，若无特效3502520则执行弹反(权重100)
    if f20_arg1:IsInterupt(INTERUPT_ParryTiming) and not f20_arg1:HasSpecialEffectId(TARGET_ENE_0, 3502520) then
        return Common_Parry(f20_arg1, f20_arg2, 100, 0, 0, 3102)
    end
    -- 检查伤害中断
    if f20_arg1:IsInterupt(INTERUPT_Damaged) then
        return f20_arg0.Damaged(f20_arg1, f20_arg2)
    end
    -- 检查射击冲击中断
    if f20_arg1:IsInterupt(INTERUPT_ShootImpact) and f20_arg0.ShootReaction(f20_arg1, f20_arg2) then
        return true
    end
    return false

end

Goal.ShootReaction = function (f21_arg0, f21_arg1)
    f21_arg1:ClearSubGoal()
    f21_arg1:AddSubGoal(GOAL_COMMON_EndureAttack, 0.3, 3100, TARGET_ENE_0, 9999, 0)
    return true
    
end

Goal.Kengeki_Activate = function (f22_arg0, f22_arg1, f22_arg2, f22_arg3)
    local f22_local0 = ReturnKengekiSpecialEffect(f22_arg1)
    if f22_local0 == 0 then
        return false
    end
    local f22_local1 = {}
    local f22_local2 = {}
    local f22_local3 = {}
    Common_Clear_Param(f22_local1, f22_local2, f22_local3)
    local f22_local4 = f22_arg1:GetDist(TARGET_ENE_0)
    local f22_local5 = f22_arg1:GetSp(TARGET_SELF)
    if f22_local5 <= 0 then
        f22_local1[50] = 100
    elseif f22_arg1:HasSpecialEffectId(TARGET_SELF, 5020) or f22_arg1:HasSpecialEffectId(TARGET_SELF, 5021) then
        f22_local1[50] = 50
    elseif f22_local0 == 200200 or f22_local0 == 200205 then
        if f22_local4 >= 2 then
            f22_local1[50] = 100
        else
            f22_local1[1] = 100
            f22_local1[2] = 100
            f22_local1[3] = 100
            f22_local1[50] = 50
        end
    elseif f22_local0 == 200201 or f22_local0 == 200206 then
        if f22_local4 >= 2 then
            f22_local1[50] = 100
        else
            f22_local1[5] = 100
            f22_local1[6] = 100
            f22_local1[50] = 50
        end
    elseif f22_local0 == 200210 or f22_local0 == 200215 then
        if f22_local0 == 200210 and f22_arg1:HasSpecialEffectId(TARGET_SELF, 3101030) then
            f22_local1[11] = 200
            f22_local1[12] = 1
        elseif f22_local4 >= 2 then
            f22_local1[50] = 100
        else
            f22_local1[10] = 20
            f22_local1[24] = 0
            f22_local1[50] = 0
        end
    elseif f22_local0 == 200211 or f22_local0 == 200216 then
        if f22_local0 == 200211 and f22_arg1:HasSpecialEffectId(TARGET_SELF, 3101030) then
            f22_local1[11] = 200
            f22_local1[12] = 1
        elseif f22_local4 >= 2 then
            f22_local1[50] = 100
        else
            f22_local1[10] = 20
            f22_local1[24] = 0
            f22_local1[50] = 0
            if f22_arg1:HasSpecialEffectId(TARGET_SELF, 3101030) then
                f22_local1[11] = 20
                f22_local1[50] = 30
            end
        end
    else
        f22_local1[50] = 100
    end
    if SpaceCheck(f22_arg1, f22_arg2, 180, 2) == false then
        f22_local1[11] = 0
    end
    f22_local2[1] = REGIST_FUNC(f22_arg1, f22_arg2, f22_arg0.Kengeki01)
    f22_local2[2] = REGIST_FUNC(f22_arg1, f22_arg2, f22_arg0.Kengeki02)
    f22_local2[3] = REGIST_FUNC(f22_arg1, f22_arg2, f22_arg0.Kengeki03)
    f22_local2[4] = REGIST_FUNC(f22_arg1, f22_arg2, f22_arg0.Kengeki04)
    f22_local2[5] = REGIST_FUNC(f22_arg1, f22_arg2, f22_arg0.Kengeki05)
    f22_local2[6] = REGIST_FUNC(f22_arg1, f22_arg2, f22_arg0.Kengeki06)
    f22_local2[7] = REGIST_FUNC(f22_arg1, f22_arg2, f22_arg0.Kengeki07)
    f22_local2[8] = REGIST_FUNC(f22_arg1, f22_arg2, f22_arg0.Kengeki08)
    f22_local2[9] = REGIST_FUNC(f22_arg1, f22_arg2, f22_arg0.Kengeki09)
    f22_local2[10] = REGIST_FUNC(f22_arg1, f22_arg2, f22_arg0.Kengeki10)
    f22_local2[11] = REGIST_FUNC(f22_arg1, f22_arg2, f22_arg0.Kengeki11)
    f22_local2[12] = REGIST_FUNC(f22_arg1, f22_arg2, f22_arg0.Kengeki12)
    f22_local2[13] = REGIST_FUNC(f22_arg1, f22_arg2, f22_arg0.Kengeki13)
    f22_local2[21] = REGIST_FUNC(f22_arg1, f22_arg2, f22_arg0.Act21)
    f22_local2[22] = REGIST_FUNC(f22_arg1, f22_arg2, f22_arg0.Act22)
    f22_local2[23] = REGIST_FUNC(f22_arg1, f22_arg2, f22_arg0.Act23)
    f22_local2[24] = REGIST_FUNC(f22_arg1, f22_arg2, f22_arg0.Act24)
    f22_local2[25] = REGIST_FUNC(f22_arg1, f22_arg2, f22_arg0.Act25)
    f22_local2[50] = REGIST_FUNC(f22_arg1, f22_arg2, f22_arg0.NoAction)
    local f22_local6 = REGIST_FUNC(f22_arg1, f22_arg2, f22_arg0.ActAfter_AdjustSpace)
    return Common_Kengeki_Activate(f22_arg1, f22_arg2, f22_local1, f22_local2, f22_local6, f22_local3)
    
end

Goal.Kengeki01 = function (f23_arg0, f23_arg1, f23_arg2)
    f23_arg1:ClearSubGoal()
    f23_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 1, 3050, TARGET_ENE_0, 9999, 0, 0)
    
end

Goal.Kengeki02 = function (f24_arg0, f24_arg1, f24_arg2)
    f24_arg1:ClearSubGoal()
    f24_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 1, 3051, TARGET_ENE_0, 9999, 0, 0)
    
end

Goal.Kengeki03 = function (f25_arg0, f25_arg1, f25_arg2)
    f25_arg1:ClearSubGoal()
    f25_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 1, 3052, TARGET_ENE_0, 9999, 0, 0)
    
end

Goal.Kengeki04 = function (f26_arg0, f26_arg1, f26_arg2)
    f26_arg1:ClearSubGoal()
    f26_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 1, 3055, TARGET_ENE_0, 9999, 0, 0)
    
end

Goal.Kengeki05 = function (f27_arg0, f27_arg1, f27_arg2)
    f27_arg1:ClearSubGoal()
    f27_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 1, 3056, TARGET_ENE_0, 9999, 0, 0)
    
end

Goal.Kengeki06 = function (f28_arg0, f28_arg1, f28_arg2)
    f28_arg1:ClearSubGoal()
    f28_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 1, 3057, TARGET_ENE_0, 9999, 0, 0)
    
end

Goal.Kengeki07 = function (f29_arg0, f29_arg1, f29_arg2)
    f29_arg1:ClearSubGoal()
    f29_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 1, 3070, TARGET_ENE_0, 9999, 0, 0)
    
end

Goal.Kengeki08 = function (f30_arg0, f30_arg1, f30_arg2)
    f30_arg1:ClearSubGoal()
    f30_arg1:AddSubGoal(GOAL_COMMON_EndureAttack, 1, 3071, TARGET_ENE_0, 9999, 0, 0)
    
end

Goal.Kengeki09 = function (f31_arg0, f31_arg1, f31_arg2)
    f31_arg1:ClearSubGoal()
    f31_arg1:AddSubGoal(GOAL_COMMON_EndureAttack, 1, 3075, TARGET_ENE_0, 9999, 0)
    
end

Goal.Kengeki10 = function (f32_arg0, f32_arg1, f32_arg2)
    f32_arg1:ClearSubGoal()
    f32_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 1, 3076, TARGET_ENE_0, 9999, 0, 0)
    
end

Goal.Kengeki11 = function (f33_arg0, f33_arg1, f33_arg2)
    f33_arg1:ClearSubGoal()
    f33_arg1:AddSubGoal(GOAL_COMMON_ComboRepeat, 3, 5211, TARGET_ENE_0, 9999, 0):TimingSetTimer(0, 7, AI_TIMING_SET__UPDATE_SUCCESS)
    
end

Goal.Kengeki12 = function (f34_arg0, f34_arg1, f34_arg2)
    local f34_local0 = f34_arg0:GetSp(TARGET_SELF)
    local f34_local1 = 0
    local f34_local2 = f34_arg0:GetRandam_Int(1, 100)
    local f34_local3 = 9910
    local f34_local4 = 0
    if SpaceCheck(f34_arg0, f34_arg1, -90, 1) == true then
        if SpaceCheck(f34_arg0, f34_arg1, 90, 1) == true then
            if f34_arg0:IsInsideTarget(TARGET_ENE_0, AI_DIR_TYPE_R, 180) then
                f34_local4 = 1
            else
                f34_local4 = 0
            end
        else
            f34_local4 = 0
        end
    elseif SpaceCheck(f34_arg0, f34_arg1, 90, 1) == true then
        f34_local4 = 1
    else
        GetWellSpace_Odds = 100
        return GetWellSpace_Odds
    end
    local f34_local5 = f34_arg0:GetRandam_Int(30, 45)
    f34_arg1:ClearSubGoal()
    f34_arg1:AddSubGoal(GOAL_COMMON_SidewayMove, f34_arg0:GetTimer(2), TARGET_ENE_0, f34_local4, f34_local5, true, true, f34_local3)
    
end

Goal.Kengeki13 = function (f35_arg0, f35_arg1, f35_arg2)
    local f35_local0 = f35_arg0:GetSp(TARGET_SELF)
    local f35_local1 = 0
    local f35_local2 = f35_arg0:GetRandam_Int(1, 100)
    local f35_local3 = 9910
    local f35_local4 = 0
    if SpaceCheck(f35_arg0, f35_arg1, -90, 1) == true then
        if SpaceCheck(f35_arg0, f35_arg1, 90, 1) == true then
            if f35_arg0:IsInsideTarget(TARGET_ENE_0, AI_DIR_TYPE_R, 180) then
                f35_local4 = 1
            else
                f35_local4 = 0
            end
        else
            f35_local4 = 0
        end
    elseif SpaceCheck(f35_arg0, f35_arg1, 90, 1) == true then
        f35_local4 = 1
    else
        GetWellSpace_Odds = 100
        return GetWellSpace_Odds
    end
    local f35_local5 = f35_arg0:GetRandam_Int(60, 90)
    f35_arg1:ClearSubGoal()
    f35_arg1:AddSubGoal(GOAL_COMMON_SidewayMove, 5, TARGET_ENE_0, f35_local4, f35_local5, true, true, 9910)
    
end

Goal.NoAction = function (f36_arg0, f36_arg1, f36_arg2)
    return -1
    
end

Goal.ActAfter_AdjustSpace = function (f37_arg0, f37_arg1, f37_arg2)
    
end

Goal.Update = function (f38_arg0, f38_arg1, f38_arg2)
    return Update_Default_NoSubGoal(f38_arg0, f38_arg1, f38_arg2)
    
end

Goal.Terminate = function (f39_arg0, f39_arg1, f39_arg2)
    
end


