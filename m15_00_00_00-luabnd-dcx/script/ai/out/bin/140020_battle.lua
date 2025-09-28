-- ==============================================
-- 140020 - 剑客·居合 AI 战斗脚本
-- Kenkaku Iai (Samurai Swordsman with Iai technique)
-- ==============================================
-- 特点：专精居合斩技的高级剑客AI，拥有复杂的距离判断和连击系统
-- 共享函数调用：132次，主要依赖GOAL_COMMON系列进行战斗行为组织
-- ==============================================

RegisterTableGoal(GOAL_Kenkaku_iai_140020_Battle, "GOAL_Kenkaku_iai_140020_Battle")
REGISTER_GOAL_NO_UPDATE(GOAL_Kenkaku_iai_140020_Battle, true)

-- 初始化函数 (Initialization function)
Goal.Initialize = function (f1_arg0, f1_arg1, f1_arg2, f1_arg3)

end

-- 主要激活函数 - AI行为的核心逻辑入口
-- Main activation function - Core logic entry point for AI behavior
Goal.Activate = function (f2_arg0, f2_arg1, f2_arg2)
    Init_Pseudo_Global(f2_arg1, f2_arg2)  -- 初始化伪全局变量 (Initialize pseudo-global variables)
    local f2_local0 = {}  -- 行为权重数组 (Behavior weight array)
    local f2_local1 = {}  -- 行为函数数组 (Behavior function array)
    local f2_local2 = {}  -- 子目标配置数组 (Sub-goal configuration array)
    Common_Clear_Param(f2_local0, f2_local1, f2_local2)  -- 清理通用参数 (Clear common parameters)
    -- 获取战斗状态参数 (Get combat state parameters)
    local f2_local3 = f2_arg1:GetDist(TARGET_ENE_0)              -- 与敌人的距离 (Distance to enemy)
    local f2_local4 = f2_arg1:GetDistYSigned(TARGET_ENE_0)       -- Y轴高度差 (Y-axis height difference)
    local f2_local5 = f2_arg1:GetExcelParam(AI_EXCEL_THINK_PARAM_TYPE__thinkAttr_doAdmirer) -- AI思考参数
    local f2_local6 = f2_arg1:GetHpRate(TARGET_SELF)             -- 自身血量比例 (Self HP ratio)
    local f2_local7 = f2_arg1:GetSp(TARGET_SELF)                 -- 自身SP值 (Self SP value)
    local f2_local8 = f2_arg1:GetDist(TARGET_ENE_0)              -- 与敌人距离(重复获取) (Distance to enemy - duplicate)
    local f2_local9 = f2_arg1:GetSp(TARGET_ENE_0)                -- 敌人SP值 (Enemy SP value)
    local f2_local10 = f2_arg1:GetRandam_Int(1, 100)             -- 随机数1-100 (Random number 1-100)
    local f2_local11 = f2_arg1:GetExcelParam(AI_EXCEL_THINK_PARAM_TYPE__thinkAttr_doAdmirer) -- AI思考参数(重复)
    local f2_local12 = Check_ReachAttack(f2_arg1, 0)             -- 检查攻击可达性 (Check attack reachability)
    local f2_local13 = f2_arg1:GetRandam_Int(3, 5)               -- 随机数3-5 (Random number 3-5)
    -- 设置战斗系统参数 (Set combat system parameters)
    Set_ConsecutiveGuardCount_Interrupt(f2_arg1)  -- 设置连续防御计数中断 (Set consecutive guard count interrupt)
    f2_arg1:SetNumber(5, 0)   -- 重置计数器5 (Reset counter 5)
    f2_arg1:SetNumber(11, 0)  -- 重置计数器11 (Reset counter 11)

    -- 添加特殊效果观察 (Add special effect observations)
    f2_arg1:AddObserveSpecialEffectAttribute(TARGET_SELF, 5026)   -- 观察自身状态：攻击后 (Observe self state: after attack)
    f2_arg1:AddObserveSpecialEffectAttribute(TARGET_SELF, 5027)   -- 观察自身状态：被攻击后 (Observe self state: after being attacked)
    f2_arg1:AddObserveSpecialEffectAttribute(TARGET_SELF, 5029)   -- 观察自身状态：特殊动作 (Observe self state: special action)
    f2_arg1:AddObserveSpecialEffectAttribute(TARGET_SELF, 200030) -- 观察自身状态：居合预备 (Observe self state: Iai preparation)
    f2_arg1:AddObserveSpecialEffectAttribute(TARGET_SELF, 200031) -- 观察自身状态：居合可用 (Observe self state: Iai available)
    -- 设置观察区域参数 (Set observation area parameters)
    local f2_local14 = 60     -- 观察角度：60度 (Observation angle: 60 degrees)
    local f2_local15 = 4.6 - f2_arg1:GetMapHitRadius(TARGET_SELF) + 1  -- 居合攻击距离 (Iai attack distance)
    local f2_local16 = 2.5    -- 近距离观察范围 (Close-range observation range)

    -- 初始化观察区域（仅执行一次）(Initialize observation areas - execute only once)
    if f2_arg1:GetNumber(3) == 0 then
        f2_arg1:SetNumber(3, 1)  -- 标记已初始化 (Mark as initialized)
        -- 添加前方攻击范围观察 (Add forward attack range observation)
        f2_arg1:AddObserveArea(0, TARGET_SELF, TARGET_ENE_0, AI_DIR_TYPE_F, f2_local14, f2_local15)
        -- 添加前方近距离观察 (Add forward close-range observation)
        f2_arg1:AddObserveArea(1, TARGET_SELF, TARGET_ENE_0, AI_DIR_TYPE_F, 200, f2_local16)
    end
    -- 检查是否激活见切系统 (Check if Kengeki system should be activated)
    if f2_arg0.Kengeki_Activate(f2_arg0, f2_arg1, f2_arg2) then
        return  -- 见切激活时直接返回，优先处理见切行为 (Return directly when Kengeki is active)
    end
    -- ========== 核心行为决策逻辑 (Core Behavior Decision Logic) ==========
    -- 居合预备状态 - 最高优先级 (Iai preparation state - highest priority)
    if f2_arg1:HasSpecialEffectId(TARGET_SELF, 200030) then
        f2_local0[15] = 100  -- 执行居合斩 (Execute Iai slash)
        if f2_arg1:HasSpecialEffectId(TARGET_SELF, 5027) then
            f2_local0[22] = 100  -- 同时可以执行闪避反击 (Can also execute dodge counter)
        end
    -- 通用行为激活检查 (Common behavior activation check)
    elseif Common_ActivateAct(f2_arg1, f2_arg2) then
        -- 使用共享的通用激活逻辑 (Use shared common activation logic)
    -- 攻击不可达状态处理 (Handle unreachable attack states)
    elseif f2_local12 ~= POSSIBLE_ATTACK then
        -- 团队角色：观众模式 (Team role: Spectator mode)
        if f2_local11 == 1 and f2_arg1:GetTeamOrder(ORDER_TYPE_Role) == ROLE_TYPE_Kankyaku then
            f2_local0[27] = 100  -- 执行接近行为 (Execute approach behavior)
        -- 团队角色：跟随模式 (Team role: Follow mode)
        elseif f2_local11 == 1 and f2_arg1:GetTeamOrder(ORDER_TYPE_Role) == ROLE_TYPE_Torimaki then
            f2_local0[27] = 100  -- 执行接近行为 (Execute approach behavior)
        -- 攻击完全无法到达 (Attack completely unreachable)
        elseif f2_local12 == UNREACH_ATTACK then
            f2_local0[27] = 100  -- 接近目标 (Approach target)
        -- 目标位置过高 (Target position too high)
        elseif f2_local12 == REACH_ATTACK_TARGET_HIGH_POSITION then
            f2_local0[10] = 50   -- 尝试跳跃攻击 (Try jump attack)
            f2_local0[27] = 100  -- 同时准备接近 (Also prepare to approach)
        -- 目标位置过低 (Target position too low)
        elseif f2_local12 == REACH_ATTACK_TARGET_LOW_POSITION then
            f2_local0[10] = 50   -- 尝试下劈攻击 (Try downward attack)
            f2_local0[27] = 100  -- 同时准备接近 (Also prepare to approach)
        else
            f2_local0[27] = 100  -- 默认接近行为 (Default approach behavior)
        end
    elseif f2_local11 == 1 and f2_arg1:GetTeamOrder(ORDER_TYPE_Role) == ROLE_TYPE_Kankyaku then
        KankyakuAct(f2_arg1, f2_arg2)
    elseif f2_local11 == 1 and f2_arg1:GetTeamOrder(ORDER_TYPE_Role) == ROLE_TYPE_Torimaki then
        TorimakiAct(f2_arg1, f2_arg2, -1, 0)
    elseif f2_arg1:IsInsideTarget(TARGET_ENE_0, AI_DIR_TYPE_B, 180) then
        if f2_arg1:HasSpecialEffectId(TARGET_SELF, 200030) then
            if f2_local8 < 3 then
                f2_local0[22] = 100
            else
                f2_local0[15] = 100
            end
        else
            f2_local0[21] = 100
            f2_local0[22] = 100
        end
    elseif f2_arg1:HasSpecialEffectId(TARGET_SELF, 200030) then
        f2_local0[15] = 1000
    elseif f2_arg1:HasSpecialEffectId(TARGET_SELF, 200031) then
        if f2_local8 >= 8.5 then
            f2_local0[19] = 60
            f2_local0[20] = 100
            if not f2_arg1:IsInsideTarget(TARGET_ENE_0, AI_DIR_TYPE_F, 120) then
                f2_local0[19] = 0
                f2_local0[20] = 0
                f2_local0[21] = 100
            end
        elseif f2_local8 >= 5.5 then
            f2_local0[10] = 100
            f2_local0[19] = 50
            f2_local0[20] = 30
            f2_local0[23] = 40
            f2_local0[26] = 50
            if f2_arg1:GetNumber(4) >= 1 then
                f2_local0[19] = 500
            end
        elseif f2_local8 > 3.8 then
            f2_local0[10] = 15
            f2_local0[19] = 30
            f2_local0[20] = 10
            f2_local0[22] = 30
            f2_local0[23] = 25
            f2_local0[24] = 15
            f2_local0[25] = 10
            f2_local0[26] = 70
            if f2_arg1:GetNumber(4) >= 1 then
                f2_local0[19] = 10000
            end
        else
            f2_local0[10] = 100
            f2_local0[23] = 1
            f2_local0[24] = 100
            f2_local0[25] = 10
            if f2_arg1:GetNumber(4) >= 1 then
                f2_local0[10] = 400
                f2_local0[24] = 10
            end
        end
        if f2_local8 < 1.5 then
            f2_local0[24] = 500
        elseif f2_arg1:GetNumber(1) >= 1 then
            f2_local0[24] = f2_local0[24] * 0.1
        end
        if f2_arg1:GetNumber(12) == 1 and f2_local8 < 2.5 then
            f2_local0[3] = 1000
            f2_local0[19] = 500
            f2_local0[22] = 0
        end
        if f2_arg1:HasSpecialEffectId(TARGET_ENE_0, COMMON_SP_EFFECT_PC_BREAK) then
            f2_local0[22] = 0
            f2_local0[23] = 0
            f2_local0[24] = 0
            f2_local0[25] = 0
            f2_local0[26] = 1
        end
    end
    if not f2_arg1:HasSpecialEffectId(TARGET_SELF, 5028) then
        f2_arg1:SetNumber(12, 0)
    elseif f2_local8 < 2.5 then
        f2_local0[3] = 1000
        f2_local0[19] = 0
    end
    if f2_arg1:GetNumber(3) == 1 and f2_arg1:HasSpecialEffectId(TARGET_SELF, 200030) then
        f2_local0[15] = 3000
        f2_arg1:SetNumber(3, 0)
    else
        f2_arg1:SetNumber(3, 0)
    end
    if SpaceCheck(f2_arg1, f2_arg2, 0, 1) == false then
        f2_local0[19] = 0
    end
    if SpaceCheck(f2_arg1, f2_arg2, 180, 2) == false and f2_local8 < 6 then
        f2_local0[22] = 400
        f2_local0[24] = 0
    end
    if SpaceCheck(f2_arg1, f2_arg2, 180, 4) == false and f2_local8 < 6 then
        f2_local0[22] = 200
    end
    if SpaceCheck(f2_arg1, f2_arg2, 90, 1) == false and SpaceCheck(f2_arg1, f2_arg2, -90, 1) == false then
        f2_local0[22] = 0
        f2_local0[23] = 0
    end
    if SpaceCheck(f2_arg1, f2_arg2, 180, 1) == false then
        f2_local0[25] = 0
    end
    if f2_arg1:IsInsideObserve(0) and f2_local8 > 1 then
        f2_local0[10] = f2_local0[10] * 3
        f2_local0[24] = f2_local0[24] * 0.5
        f2_local0[25] = f2_local0[25] * 0.3
    end
    if not f2_arg1:IsInsideTarget(TARGET_ENE_0, AI_DIR_TYPE_F, 90) then
        f2_local0[19] = 0
    end
    if f2_arg1:GetNumber(4) >= 4 then
        f2_arg1:SetNumber(4, 0)
        f2_local0[10] = 1
    end
    if f2_local4 > 1.5 then
        f2_local0[10] = 1
        f2_local0[26] = 1
    end
    f2_local0[3] = SetCoolTime(f2_arg1, f2_arg2, 3021, 5, f2_local0[3], 1)
    f2_local0[10] = SetCoolTime(f2_arg1, f2_arg2, 3010, 1, f2_local0[10], 1)
    f2_local0[19] = SetCoolTime(f2_arg1, f2_arg2, 5200, 1.4, f2_local0[19], 1)
    f2_local1[3] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act03)
    f2_local1[10] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act10)
    f2_local1[14] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act14)
    f2_local1[15] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act15)
    f2_local1[19] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act19)
    f2_local1[20] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act20)
    f2_local1[21] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act21)
    f2_local1[22] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act22)
    f2_local1[23] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act23)
    f2_local1[24] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act24)
    f2_local1[25] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act25)
    f2_local1[26] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act26)
    f2_local1[27] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act27)
    f2_local1[28] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act28)
    local f2_local17 = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.ActAfter_AdjustSpace)
    Common_Battle_Activate(f2_arg1, f2_arg2, f2_local0, f2_local1, f2_local17, f2_local2)
    
end

Goal.Act03 = function (f3_arg0, f3_arg1, f3_arg2)
    local f3_local0 = f3_arg0:GetDist(TARGET_ENE_0)
    local f3_local1 = 4.5 - f3_arg0:GetMapHitRadius(TARGET_SELF)
    local f3_local2 = 4.5 - f3_arg0:GetMapHitRadius(TARGET_SELF) + 5
    local f3_local3 = 4.5 - f3_arg0:GetMapHitRadius(TARGET_SELF) + 5
    local f3_local4 = 0
    local f3_local5 = 0
    local f3_local6 = 5
    local f3_local7 = 3
    local f3_local8 = 3021
    local f3_local9 = 0
    local f3_local10 = 70
    f3_arg0:DeleteObserve(0)
    f3_arg0:DeleteObserve(1)
    f3_arg1:AddSubGoal(GOAL_COMMON_ComboAttackTunableSpin, 10, f3_local8, TARGET_ENE_0, 4, f3_local9, f3_local10, 0, 0)
    f3_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3022, TARGET_ENE_0, 9999, 0, 0)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act10 = function (f4_arg0, f4_arg1, f4_arg2)
    local f4_local0 = f4_arg0:GetDist(TARGET_ENE_0)
    local f4_local1 = 4.6 - f4_arg0:GetMapHitRadius(TARGET_SELF)
    local f4_local2 = 4.6 - f4_arg0:GetMapHitRadius(TARGET_SELF) + 3
    local f4_local3 = 4.6 - f4_arg0:GetMapHitRadius(TARGET_SELF) + 6
    local f4_local4 = 0
    local f4_local5 = 0
    local f4_local6 = 1.5
    local f4_local7 = 3
    Approach_Act_Flex(f4_arg0, f4_arg1, f4_local1, f4_local2, f4_local3, f4_local4, f4_local5, f4_local6, f4_local7)
    local f4_local8 = 3010
    local f4_local9 = 0
    local f4_local10 = 0
    f4_arg0:SetNumber(11, f4_arg0:GetNumber(11) + 1)
    f4_arg0:SetNumber(4, 0)
    f4_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 10, f4_local8, TARGET_ENE_0, 9999, f4_local9, f4_local10, 0, 0):TimingSetTimer(9, 4, AI_TIMING_SET__ACTIVATE)
    f4_arg0:AddObserveSpecialEffectAttribute(TARGET_SELF, 5025)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act14 = function (f5_arg0, f5_arg1, f5_arg2)
    local f5_local0 = f5_arg0:GetDist(TARGET_ENE_0)
    local f5_local1 = 0
    local f5_local2 = 0
    local f5_local3 = 3
    local f5_local4 = 3020
    if f5_local0 <= 2 then
        if SpaceCheck(f5_arg0, f5_arg1, 180, 2) == false then
        else
            f5_arg1:AddSubGoal(GOAL_COMMON_SpinStep, f5_local3, 5201, TARGET_ENE_0, f5_local1, AI_DIR_TYPE_B, 0)
            f5_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 10, f5_local4, TARGET_ENE_0, 9999, f5_local1, f5_local2, 0, 0):TimingSetNumber(11, 0, AI_TIMING_SET__ACTIVATE)
        end
    else
        f5_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 10, f5_local4, TARGET_ENE_0, 9999, f5_local1, f5_local2, 0, 0):TimingSetNumber(11, 0, AI_TIMING_SET__ACTIVATE)
    end
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act15 = function (f6_arg0, f6_arg1, f6_arg2)
    local f6_local0 = f6_arg0:GetDist(TARGET_ENE_0)
    local f6_local1 = 3031
    local f6_local2 = 3033
    local f6_local3 = 0
    local f6_local4 = 0
    f6_arg0:SetNumber(5, 0)
    f6_arg0:SetNumber(1, 1)
    if SpaceCheck(f6_arg0, f6_arg1, 180, 2) == false then
        f6_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 10, f6_local1, TARGET_ENE_0, 9999, f6_local3, f6_local4, 0, 0)
    elseif f6_local0 <= 2 then
        f6_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 10, f6_local2, TARGET_ENE_0, 9999, f6_local3, f6_local4, 0, 0)
    else
        f6_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 10, f6_local1, TARGET_ENE_0, 9999, f6_local3, f6_local4, 0, 0)
    end
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act19 = function (f7_arg0, f7_arg1, f7_arg2)
    local f7_local0 = 3
    local f7_local1 = 0
    local f7_local2 = 5200
    f7_arg1:AddSubGoal(GOAL_COMMON_SpinStep, f7_local0, f7_local2, TARGET_ENE_0, f7_local1, AI_DIR_TYPE_F, 0)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act20 = function (f8_arg0, f8_arg1, f8_arg2)
    local f8_local0 = f8_arg0:GetDist(TARGET_ENE_0)
    local f8_local1 = 3
    local f8_local2 = 3
    local f8_local3 = f8_arg0:GetRandam_Float(1, 3)
    local f8_local4 = 0
    local f8_local5 = 5200
    f8_arg1:AddSubGoal(GOAL_COMMON_ApproachTarget, f8_local2, TARGET_ENE_0, f8_local1, TARGET_SELF, true, -1)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act21 = function (f9_arg0, f9_arg1, f9_arg2)
    local f9_local0 = 3
    local f9_local1 = 45
    f9_arg1:AddSubGoal(GOAL_COMMON_Turn, f9_local0, TARGET_ENE_0, f9_local1, -1, GOAL_RESULT_Success, true)
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
    
end

Goal.Act22 = function (f10_arg0, f10_arg1, f10_arg2)
    local f10_local0 = 3
    local f10_local1 = 0
    local f10_local2 = 0
    local f10_local3 = f10_arg0:GetRandam_Int(1, 100)
    local f10_local4 = f10_arg0:GetDist(TARGET_ENE_0)
    if f10_arg0:HasSpecialEffectId(TARGET_SELF, 200030) then
        if SpaceCheck(f10_arg0, f10_arg1, -45, 2) == true then
            if SpaceCheck(f10_arg0, f10_arg1, 45, 2) == true then
                if f10_arg0:IsInsideTarget(TARGET_ENE_0, AI_DIR_TYPE_R, 180) then
                    f10_arg1:AddSubGoal(GOAL_COMMON_ComboAttackTunableSpin, 10, 3035, TARGET_ENE_0, 999, f10_local1, f10_local2, 0, 0)
                else
                    f10_arg1:AddSubGoal(GOAL_COMMON_ComboAttackTunableSpin, 10, 3034, TARGET_ENE_0, 999, f10_local1, f10_local2, 0, 0)
                end
            else
                f10_arg1:AddSubGoal(GOAL_COMMON_ComboAttackTunableSpin, 10, 3035, TARGET_ENE_0, 999, f10_local1, f10_local2, 0, 0)
            end
        elseif SpaceCheck(f10_arg0, f10_arg1, 45, 2) == true then
            f10_arg1:AddSubGoal(GOAL_COMMON_ComboAttackTunableSpin, 10, 3034, TARGET_ENE_0, 999, f10_local1, f10_local2, 0, 0)
            if false then
            end
        end
    else
        if SpaceCheck(f10_arg0, f10_arg1, -45, 2) == true then
            if SpaceCheck(f10_arg0, f10_arg1, 45, 2) == true then
                if f10_arg0:IsInsideTarget(TARGET_ENE_0, AI_DIR_TYPE_R, 180) then
                    f10_arg1:AddSubGoal(GOAL_COMMON_SpinStep, f10_local0, 5202, TARGET_ENE_0, f10_local1, AI_DIR_TYPE_L, 0)
                else
                    f10_arg1:AddSubGoal(GOAL_COMMON_SpinStep, f10_local0, 5203, TARGET_ENE_0, f10_local1, AI_DIR_TYPE_R, 0)
                end
            else
                f10_arg1:AddSubGoal(GOAL_COMMON_SpinStep, f10_local0, 5202, TARGET_ENE_0, f10_local1, AI_DIR_TYPE_L, 0)
            end
        elseif SpaceCheck(f10_arg0, f10_arg1, 45, 2) == true then
            f10_arg1:AddSubGoal(GOAL_COMMON_SpinStep, f10_local0, 5203, TARGET_ENE_0, f10_local1, AI_DIR_TYPE_R, 0)
        else
        end
        if f10_local3 <= 50 and f10_local4 < 4 and f10_arg0:IsInsideTarget(TARGET_ENE_0, AI_DIR_TYPE_F, 90) then
            f10_arg1:AddSubGoal(GOAL_COMMON_ComboRepeat, 10, 3021, TARGET_ENE_0, 4.5, 0)
            f10_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3022, TARGET_ENE_0, 9999, 0, 0)
        else
            f10_local1 = 0.5
            f10_arg1:AddSubGoal(GOAL_COMMON_SpinStep, f10_local0, 5200, TARGET_ENE_0, f10_local1, AI_DIR_TYPE_F, 0)
        end
    end
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
    
end

Goal.Act23 = function (f11_arg0, f11_arg1, f11_arg2)
    local f11_local0 = f11_arg0:GetDist(TARGET_ENE_0)
    local f11_local1 = f11_arg0:GetSp(TARGET_SELF)
    local f11_local2 = 20
    local f11_local3 = f11_arg0:GetRandam_Int(1, 100)
    local f11_local4 = -1
    local f11_local5 = 0
    if SpaceCheck(f11_arg0, f11_arg1, -90, 1) == true then
        if SpaceCheck(f11_arg0, f11_arg1, 90, 1) == true then
            if f11_local3 <= 50 then
                if f11_arg0:IsInsideTargetEx(TARGET_ENE_0, TARGET_SELF, AI_DIR_TYPE_R, 180, 999) then
                    f11_local5 = 1
                else
                    f11_local5 = 0
                end
            elseif f11_arg0:IsInsideTargetEx(TARGET_ENE_0, TARGET_SELF, AI_DIR_TYPE_L, 180, 999) then
                f11_local5 = 0
            else
                f11_local5 = 1
            end
        else
            f11_local5 = 0
        end
    elseif SpaceCheck(f11_arg0, f11_arg1, 90, 1) == true then
        f11_local5 = 1
    else
        f11_local5 = 1
    end
    local f11_local6 = f11_arg0:GetRandam_Float(0.5, 1.5)
    local f11_local7 = f11_arg0:GetRandam_Int(30, 45)
    f11_arg0:SetNumber(10, f11_local5)
    f11_arg1:AddSubGoal(GOAL_COMMON_SidewayMove, f11_local6, TARGET_ENE_0, f11_local5, f11_local7, true, true, f11_local4)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act24 = function (f12_arg0, f12_arg1, f12_arg2)
    local f12_local0 = f12_arg0:GetDist(TARGET_ENE_0)
    local f12_local1 = 3
    local f12_local2 = 0
    local f12_local3 = 5201
    f12_arg0:SetNumber(1, 1)
    if SpaceCheck(f12_arg0, f12_arg1, 180, 2) ~= true or SpaceCheck(f12_arg0, f12_arg1, 180, 4) ~= true or f12_local0 > 4 then
    else
        f12_local3 = 5201
        if false then
        else
        end
    end
    f12_arg1:AddSubGoal(GOAL_COMMON_SpinStep, f12_local1, f12_local3, TARGET_ENE_0, f12_local2, AI_DIR_TYPE_B, 0)
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Act25 = function (f13_arg0, f13_arg1, f13_arg2)
    local f13_local0 = f13_arg0:GetRandam_Float(0.8, 2)
    local f13_local1 = f13_arg0:GetRandam_Float(2, 4.5)
    local f13_local2 = f13_arg0:GetDist(TARGET_ENE_0)
    local f13_local3 = -1
    f13_arg1:AddSubGoal(GOAL_COMMON_LeaveTarget, f13_local0, TARGET_ENE_0, f13_local1, TARGET_ENE_0, true, f13_local3)
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
    
end

Goal.Act26 = function (f14_arg0, f14_arg1, f14_arg2)
    f14_arg1:AddSubGoal(GOAL_COMMON_Wait, 0.5, TARGET_ENE_0, 0, 0, 0)
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
    
end

Goal.Act27 = function (f15_arg0, f15_arg1, f15_arg2)
    local f15_local0 = f15_arg0:GetRandam_Int(1, 100)
    if YousumiAct_SubGoal(f15_arg0, f15_arg1, true, 60, 30) == false then
        GetWellSpace_Odds = 0
        return GetWellSpace_Odds
    end
    local f15_local1 = 0
    local f15_local2 = SpaceCheck_SidewayMove(f15_arg0, f15_arg1, 1)
    if f15_local2 == 0 then
        f15_local1 = 0
    elseif f15_local2 == 1 then
        f15_local1 = 1
    elseif f15_local2 == 2 then
        if f15_local0 <= 50 then
            f15_local1 = 0
        else
            f15_local1 = 1
        end
    else
        f15_arg1:AddSubGoal(GOAL_COMMON_Wait, 0.5, TARGET_SELF, 0, 0, 0)
        GetWellSpace_Odds = 0
        return GetWellSpace_Odds
    end
    f15_arg0:SetNumber(10, f15_local1)
    f15_arg1:AddSubGoal(GOAL_COMMON_SidewayMove, 3, TARGET_ENE_0, f15_local1, f15_arg0:GetRandam_Int(30, 45), true, true, -1)
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
    
end

Goal.Act28 = function (f16_arg0, f16_arg1, f16_arg2)
    local f16_local0 = f16_arg0:GetDist(TARGET_ENE_0)
    local f16_local1 = 1.5
    local f16_local2 = 1.5
    local f16_local3 = f16_arg0:GetRandam_Int(30, 45)
    local f16_local4 = -1
    local f16_local5 = f16_arg0:GetRandam_Int(0, 1)
    if f16_local0 <= 3 then
        f16_arg1:AddSubGoal(GOAL_COMMON_SidewayMove, f16_local1, TARGET_ENE_0, f16_local5, f16_local3, true, true, f16_local4)
    elseif f16_local0 <= 8 then
        f16_arg1:AddSubGoal(GOAL_COMMON_ApproachTarget, f16_local2, TARGET_ENE_0, 3, TARGET_SELF, true, -1)
    else
        f16_arg1:AddSubGoal(GOAL_COMMON_ApproachTarget, f16_local2, TARGET_ENE_0, 5, TARGET_SELF, false, -1)
    end
    GetWellSpace_Odds = 0
    return GetWellSpace_Odds
    
end

Goal.Interrupt = function (f17_arg0, f17_arg1, f17_arg2)
    local f17_local0 = f17_arg1:GetSpecialEffectActivateInterruptType(0)
    local f17_local1 = f17_arg1:GetRandam_Int(1, 100)
    local f17_local2 = f17_arg1:GetDist(TARGET_ENE_0)
    local f17_local3 = f17_arg1:GetSpRate(TARGET_SELF)
    local f17_local4 = f17_arg1:GetNumber(11)
    if f17_arg1:IsLadderAct(TARGET_SELF) then
        return false
    end
    if not f17_arg1:HasSpecialEffectId(TARGET_SELF, 200004) then
        return false
    end
    if f17_arg1:IsInterupt(INTERUPT_Shoot) then
        return f17_arg0.ShootReaction(f17_arg1, f17_arg2)
    end
    if f17_arg1:IsInterupt(INTERUPT_ParryTiming) then
        if f17_arg1:HasSpecialEffectId(TARGET_SELF, 200030) then
            return Common_Parry(f17_arg1, f17_arg2, 100, 0, 0, 3103)
        else
            return Common_Parry(f17_arg1, f17_arg2, 100, 0)
        end
    end
    if f17_arg1:IsInterupt(INTERUPT_Damaged) then
        return f17_arg0.Damaged(f17_arg1, f17_arg2)
    end
    if Interupt_PC_Break(f17_arg1) then
        f17_arg1:Replanning()
        return true
    end
    if Interupt_Use_Item(f17_arg1, 4, 10) then
        if f17_arg1:HasSpecialEffectId(TARGET_SELF, 200030) then
            f17_arg1:Replanning()
            return true
        elseif f17_local2 <= 5 then
            f17_arg2:ClearSubGoal()
            f17_arg2:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 1, 3010, TARGET_ENE_0, 9999, 0, 0, 0, 0)
            return true
        elseif f17_local2 <= 10 then
            f17_arg2:ClearSubGoal()
            f17_arg2:AddSubGoal(GOAL_COMMON_SpinStep, 1, 5200, TARGET_ENE_0, 0, AI_DIR_TYPE_F, 0)
            return true
        else
            f17_arg1:Replanning()
            return true
        end
    end
    local f17_local5 = 60
    local f17_local6 = 4.6 - f17_arg1:GetMapHitRadius(TARGET_SELF) + 1
    local f17_local7 = 2.5
    if f17_arg1:IsInterupt(INTERUPT_ActivateSpecialEffect) then
        if f17_arg1:GetSpecialEffectActivateInterruptType(0) == 5027 and f17_arg1:HasSpecialEffectId(TARGET_SELF, 200030) then
            f17_arg2:ClearSubGoal()
            f17_arg2:AddSubGoal(GOAL_COMMON_EndureAttack, 0.1, 3031, TARGET_ENE_0, 9999, 0)
            return true
        end
        if f17_arg1:GetSpecialEffectActivateInterruptType(0) == 5025 then
            if f17_arg1:HasSpecialEffectId(TARGET_SELF, 200030) and f17_arg1:GetHpRate(TARGET_ENE_0) == 0 then
                f17_arg2:ClearSubGoal()
                f17_arg2:AddSubGoal(GOAL_COMMON_EndureAttack, 5, 3032, TARGET_ENE_0, 9999, 0, 0, 0, 0)
                return true
            elseif f17_arg1:HasSpecialEffectId(TARGET_SELF, 200031) and f17_arg1:HasSpecialEffectId(TARGET_ENE_0, 110125) then
                f17_arg1:Replanning()
                return true
            end
        end
        if f17_arg1:GetSpecialEffectActivateInterruptType(0) == 200031 then
            f17_arg1:AddObserveArea(0, TARGET_SELF, TARGET_ENE_0, AI_DIR_TYPE_F, f17_local5, f17_local6)
            f17_arg1:AddObserveArea(1, TARGET_SELF, TARGET_ENE_0, AI_DIR_TYPE_F, 200, f17_local7)
            return true
        elseif f17_arg1:GetSpecialEffectActivateInterruptType(0) == 200030 then
            f17_arg1:DeleteObserve(0)
            f17_arg1:DeleteObserve(1)
            return true
        end
        if f17_arg1:GetSpecialEffectActivateInterruptType(0) == 5029 and f17_arg1:GetNumber(5) == 0 then
            if f17_arg1:IsInsideTarget(TARGET_ENE_0, AI_DIR_TYPE_F, 90) and f17_local2 <= 2 and not f17_arg1:HasSpecialEffectId(TARGET_ENE_0, 110125) then
                f17_arg2:ClearSubGoal()
                if f17_local1 <= 70 then
                    f17_arg2:AddSubGoal(GOAL_COMMON_EndureAttack, 0.1, 3033, TARGET_ENE_0, 9999, 0):TimingSetTimer(9, 0.1, AI_TIMING_SET__ACTIVATE)
                elseif f17_local1 <= 85 then
                    f17_arg2:AddSubGoal(GOAL_COMMON_EndureAttack, 0.1, 3035, TARGET_ENE_0, 9999, 0):TimingSetTimer(9, 0.1, AI_TIMING_SET__ACTIVATE)
                else
                    f17_arg2:AddSubGoal(GOAL_COMMON_EndureAttack, 0.1, 3034, TARGET_ENE_0, 9999, 0):TimingSetTimer(9, 0.1, AI_TIMING_SET__ACTIVATE)
                end
                f17_arg1:AddObserveArea(1, TARGET_SELF, TARGET_ENE_0, AI_DIR_TYPE_F, f17_local5, f17_local6)
                return true
            elseif SpaceCheck(f17_arg1, f17_arg2, -90, 1) and f17_arg1:IsInsideTarget(TARGET_ENE_0, AI_DIR_TYPE_R, 90) and f17_local2 <= 4 then
                f17_arg1:SetNumber(12, 1)
                f17_arg2:ClearSubGoal()
                f17_arg2:AddSubGoal(GOAL_COMMON_EndureAttack, 0.1, 3035, TARGET_ENE_0, 9999, 0):TimingSetTimer(9, 0.1, AI_TIMING_SET__ACTIVATE)
                f17_arg1:AddObserveArea(1, TARGET_SELF, TARGET_ENE_0, AI_DIR_TYPE_F, f17_local5, f17_local6)
                return true
            elseif SpaceCheck(f17_arg1, f17_arg2, 90, 1) and f17_arg1:IsInsideTarget(TARGET_ENE_0, AI_DIR_TYPE_L, 90) and f17_local2 <= 4 then
                f17_arg1:SetNumber(12, 1)
                f17_arg2:ClearSubGoal()
                f17_arg2:AddSubGoal(GOAL_COMMON_EndureAttack, 0.1, 3034, TARGET_ENE_0, 9999, 0):TimingSetTimer(9, 0.1, AI_TIMING_SET__ACTIVATE)
                f17_arg1:AddObserveArea(1, TARGET_SELF, TARGET_ENE_0, AI_DIR_TYPE_F, f17_local5, f17_local6)
                return true
            elseif f17_arg1:IsInsideTarget(TARGET_ENE_0, AI_DIR_TYPE_F, 90) and f17_local2 <= 2 and not f17_arg1:HasSpecialEffectId(TARGET_ENE_0, 110125) then
                if f17_local4 >= 2 or f17_local3 < 0.6 then
                    f17_arg2:ClearSubGoal()
                    f17_arg2:AddSubGoal(GOAL_COMMON_EndureAttack, 1, 3033, TARGET_ENE_0, 9999, 0)
                    return true
                elseif f17_arg1:HasSpecialEffectId(TARGET_SELF, 200031) and f17_local4 == 0 then
                    f17_arg2:ClearSubGoal()
                    f17_arg1:SetNumber(11, f17_arg1:GetNumber(11) + 1)
                    f17_arg2:AddSubGoal(GOAL_COMMON_EndureAttack, 1, 3010, TARGET_ENE_0, 9999, 0)
                    return true
                end
            end
        end
    end
    if f17_arg1:IsInterupt(INTERUPT_InactivateSpecialEffect) and f17_arg1:GetSpecialEffectInactivateInterruptType(0) == 5026 then
        if f17_local2 < 2 and f17_arg1:GetNumber(1) == 0 then
            f17_arg2:ClearSubGoal()
            f17_arg2:AddSubGoal(GOAL_COMMON_EndureAttack, 1, 3033, TARGET_ENE_0, 9999, 0)
            return true
        else
            f17_arg2:ClearSubGoal()
            f17_arg2:AddSubGoal(GOAL_COMMON_EndureAttack, 0.1, 3012, TARGET_ENE_0, 9999, 0)
            return true
        end
    end
    if f17_arg1:GetNumber(5) == 1 then
        return false
    end
    if f17_arg1:IsInterupt(INTERUPT_Inside_ObserveArea) then
        if f17_arg1:IsInsideObserve(1) and f17_arg1:HasSpecialEffectId(TARGET_SELF, 200031) and f17_local4 == 0 then
            if f17_arg1:HasSpecialEffectId(TARGET_SELF, 200031) and (f17_arg1:IsInsideTarget(TARGET_ENE_0, AI_DIR_TYPE_R, 90) or f17_arg1:IsInsideTarget(TARGET_ENE_0, AI_DIR_TYPE_L, 90)) then
                f17_arg2:ClearSubGoal()
                f17_arg2:AddSubGoal(GOAL_COMMON_EndureAttack, 0.1, 5201, TARGET_ENE_0, 9999, 0, 0, 0, 0)
                return true
            elseif f17_arg1:HasSpecialEffectId(TARGET_SELF, 5028) then
                f17_arg1:SetNumber(12, 1)
                f17_arg1:Replanning()
                return true
            else
                f17_arg1:SetNumber(11, f17_arg1:GetNumber(11) + 1)
                f17_arg2:ClearSubGoal()
                f17_arg2:AddSubGoal(GOAL_COMMON_EndureAttack, 0.1, 3010, TARGET_ENE_0, 9999, 0, 0, 0, 0):TimingSetTimer(9, 4, AI_TIMING_SET__ACTIVATE)
                return true
            end
        elseif not f17_arg1:IsInsideObserve(0) or f17_local4 ~= 0 or not f17_arg1:HasSpecialEffectId(TARGET_SELF, 200031) or not (f17_arg1:GetHpRate(TARGET_ENE_0) > 0) or f17_local4 ~= 0 or f17_arg1:GetNumber(12) == 1 then
        elseif f17_local4 == 0 and f17_arg1:IsFinishTimer(9) == true and f17_local1 <= 80 and not f17_arg1:HasSpecialEffectId(TARGET_ENE_0, 110125) then
            f17_arg2:ClearSubGoal()
            f17_arg1:SetNumber(11, f17_arg1:GetNumber(11) + 1)
            f17_arg2:AddSubGoal(GOAL_COMMON_EndureAttack, 1.5, 3010, TARGET_ENE_0, 9999, 0, 0, 0, 0):TimingSetTimer(9, 4, AI_TIMING_SET__ACTIVATE)
            return true
        elseif f17_arg1:IsFinishTimer(9) == true and f17_local1 > 80 then
            f17_arg2:ClearSubGoal()
            f17_arg2:AddSubGoal(GOAL_COMMON_EndureAttack, 0.3, 5201, TARGET_ENE_0, 9999, 0, 0, 0, 0)
            return true
        end
    end
    return false
    
end

Goal.Parry = function (f18_arg0, f18_arg1, f18_arg2, f18_arg3)
    local f18_local0 = f18_arg0:GetDist(TARGET_ENE_0)
    local f18_local1 = GetDist_Parry(f18_arg0)
    local f18_local2 = f18_arg0:GetRandam_Int(1, 100)
    local f18_local3 = f18_arg0:GetRandam_Int(1, 100)
    local f18_local4 = f18_arg0:GetRandam_Int(1, 100)
    local f18_local5 = f18_arg0:HasSpecialEffectId(TARGET_ENE_0, 109970)
    local f18_local6 = f18_arg0:HasSpecialEffectId(TARGET_ENE_0, COMMON_SP_EFFECT_PC_ATTACK_RUSH)
    local f18_local7 = -1
    local f18_local8 = 3.7
    if f18_arg0:HasSpecialEffectId(TARGET_SELF, 221000) then
        f18_local7 = 0
    elseif f18_arg0:HasSpecialEffectId(TARGET_SELF, 221001) then
        f18_local7 = 1
    elseif f18_arg0:HasSpecialEffectId(TARGET_SELF, 221002) then
        f18_local7 = 2
    end
    if f18_arg0:IsFinishTimer(AI_TIMER_PARRY_INTERVAL) == false then
        return false
    end
    if f18_local7 == -1 then
        return false
    end
    if f18_arg0:HasSpecialEffectId(TARGET_SELF, 220062) then
        return false
    end
    if f18_arg0:HasSpecialEffectId(TARGET_ENE_0, 110450) or f18_arg0:HasSpecialEffectId(TARGET_ENE_0, 110501) or f18_arg0:HasSpecialEffectId(TARGET_ENE_0, 110500) then
        return false
    end
    f18_arg0:SetTimer(AI_TIMER_PARRY_INTERVAL, 0.1)
    if f18_arg2 == nil then
        f18_arg2 = 50
    end
    if f18_arg3 == nil then
        f18_arg3 = 0
    end
    if stepType == nil then
        stepType = 0
    end
    if f18_arg0:HasSpecialEffectId(TARGET_SELF, 200030) then
        if f18_arg0:IsInsideTarget(TARGET_ENE_0, AI_DIR_TYPE_F, 90) and f18_arg0:IsInsideTargetEx(TARGET_ENE_0, TARGET_SELF, AI_DIR_TYPE_F, 90, f18_local1) then
            if f18_local6 then
                f18_arg1:ClearSubGoal()
                f18_arg1:AddSubGoal(GOAL_COMMON_EndureAttack, 0.3, 3033, TARGET_ENE_0, 9999, 0)
                return true
            elseif f18_local5 then
                if f18_arg0:IsTargetGuard(TARGET_SELF) and ReturnKengekiSpecialEffect(f18_arg0) == false then
                    f18_arg1:ClearSubGoal()
                    f18_arg1:AddSubGoal(GOAL_COMMON_EndureAttack, 0.3, 3101, TARGET_ENE_0, 9999, 0)
                    return true
                else
                    if f18_local7 == 2 then
                        return false
                    elseif f18_local7 == 1 then
                        if f18_local2 <= 50 then
                            f18_arg1:ClearSubGoal()
                            f18_arg1:AddSubGoal(GOAL_COMMON_EndureAttack, 0.3, 3101, TARGET_ENE_0, 9999, 0)
                            return true
                        end
                    elseif f18_local7 == 0 and f18_local2 <= 100 then
                        if f18_local0 >= 3 then
                            f18_arg1:ClearSubGoal()
                            f18_arg1:AddSubGoal(GOAL_COMMON_EndureAttack, 0.3, 3033, TARGET_ENE_0, 9999, 0)
                            return true
                        else
                            f18_arg1:ClearSubGoal()
                            f18_arg1:AddSubGoal(GOAL_COMMON_EndureAttack, 0.3, 3101, TARGET_ENE_0, 9999, 0)
                            return true
                        end
                    end
                    return false
                end
            else
                f18_arg1:ClearSubGoal()
                f18_arg1:AddSubGoal(GOAL_COMMON_EndureAttack, 0.3, 3033, TARGET_ENE_0, 9999, 0)
                return true
            end
        elseif f18_arg0:IsInsideTargetEx(TARGET_ENE_0, TARGET_SELF, AI_DIR_TYPE_F, 90, f18_local1 + 1) then
            if stepType ~= -1 and f18_local4 <= f18_arg3 then
                f18_arg1:ClearSubGoal()
                f18_arg1:AddSubGoal(GOAL_COMMON_EndureAttack, 0.3, 3033, TARGET_ENE_0, 9999, 0)
                return true
            else
                return false
            end
        elseif f18_arg0:HasSpecialEffectId(TARGET_SELF, 200031) then
            if f18_arg0:IsInsideTarget(TARGET_ENE_0, AI_DIR_TYPE_F, 90) and f18_arg0:IsInsideTargetEx(TARGET_ENE_0, TARGET_SELF, AI_DIR_TYPE_F, 90, f18_local1) then
                if f18_local6 then
                    f18_arg1:ClearSubGoal()
                    f18_arg1:AddSubGoal(GOAL_COMMON_EndureAttack, 0.3, 3100, TARGET_ENE_0, 9999, 0)
                    return true
                elseif f18_local5 then
                    if f18_arg0:IsTargetGuard(TARGET_SELF) and ReturnKengekiSpecialEffect(f18_arg0) == false then
                        f18_arg1:ClearSubGoal()
                        f18_arg1:AddSubGoal(GOAL_COMMON_EndureAttack, 0.3, 5201, TARGET_ENE_0, 9999, 0)
                        f18_arg0:SetNumber(4, 1)
                        return true
                    else
                        if f18_local7 == 2 then
                            return false
                        elseif f18_local7 == 1 then
                            if f18_local2 <= 50 then
                                f18_arg1:ClearSubGoal()
                                f18_arg1:AddSubGoal(GOAL_COMMON_EndureAttack, 0.3, 3101, TARGET_ENE_0, 9999, 0)
                                return true
                            end
                        elseif f18_local7 == 0 and f18_local2 <= 100 then
                            f18_arg0:DeleteObserve(0)
                            f18_arg0:DeleteObserve(1)
                            f18_arg1:ClearSubGoal()
                            f18_arg1:AddSubGoal(GOAL_COMMON_EndureAttack, 0.4, 5201, TARGET_ENE_0, 9999, 0)
                            return true
                        end
                        return false
                    end
                elseif f18_arg0:HasSpecialEffectId(TARGET_ENE_0, 109980) and stepType ~= -1 and f18_local7 == 0 then
                    f18_arg1:ClearSubGoal()
                    f18_arg1:AddSubGoal(GOAL_COMMON_SpinStep, 1, 5201, TARGET_ENE_0, 0, AI_DIR_TYPE_B, 0)
                    return true
                elseif f18_local3 <= Get_ConsecutiveGuardCount(f18_arg0) * f18_arg2 then
                    f18_arg0:DeleteObserve(0)
                    f18_arg0:DeleteObserve(1)
                    f18_arg1:ClearSubGoal()
                    f18_arg1:AddSubGoal(GOAL_COMMON_EndureAttack, 0.3, 3101, TARGET_ENE_0, 9999, 0)
                    return true
                else
                    f18_arg0:DeleteObserve(0)
                    f18_arg0:DeleteObserve(1)
                    f18_arg1:ClearSubGoal()
                    f18_arg1:AddSubGoal(GOAL_COMMON_EndureAttack, 0.3, 3100, TARGET_ENE_0, 9999, 0)
                    return true
                end
            elseif f18_arg0:IsInsideTargetEx(TARGET_ENE_0, TARGET_SELF, AI_DIR_TYPE_F, 90, f18_local1 + 1) then
                if stepType ~= -1 and f18_local4 <= f18_arg3 then
                    f18_arg1:ClearSubGoal()
                    f18_arg1:AddSubGoal(GOAL_COMMON_SpinStep, 1, 5201, TARGET_ENE_0, 0, AI_DIR_TYPE_B, 0)
                    return true
                else
                    return false
                end
            else
                return false
            end
        end
    end
    return false
    
end

Goal.Damaged = function (f19_arg0, f19_arg1, f19_arg2)
    local f19_local0 = f19_arg0:GetHpRate(TARGET_SELF)
    local f19_local1 = f19_arg0:GetDist(TARGET_ENE_0)
    local f19_local2 = f19_arg0:GetSp(TARGET_SELF)
    local f19_local3 = f19_arg0:GetRandam_Int(1, 100)
    local f19_local4 = 0
    if f19_arg0:HasSpecialEffectId(TARGET_SELF, 200030) then
        f19_arg1:ClearSubGoal()
        f19_arg1:AddSubGoal(GOAL_COMMON_EndureAttack, 0.1, 3031, TARGET_ENE_0, 9999, 0)
        return true
    end
    return false
    
end

Goal.ShootReaction = function (f20_arg0, f20_arg1)
    local f20_local0 = f20_arg0:GetDist(TARGET_ENE_0)
    local f20_local1 = f20_local0 * 0.01
    if f20_arg0:HasSpecialEffectId(TARGET_SELF, 200030) then
        if f20_arg0:IsInsideTargetEx(TARGET_ENE_0, TARGET_SELF, AI_DIR_TYPE_F, 20, 999) then
            if f20_local0 <= 15 then
                f20_arg1:ClearSubGoal()
                f20_arg1:AddSubGoal(GOAL_COMMON_EndureAttack, 0.1, 3100, TARGET_ENE_0, 9999, 0)
                return true
            else
                f20_arg1:ClearSubGoal()
                f20_arg1:AddSubGoal(GOAL_COMMON_Wait, f20_local1, TARGET_SELF, 0, 0, 0)
                f20_arg1:AddSubGoal(GOAL_COMMON_EndureAttack, 0.3, 3100, TARGET_ENE_0, 9999, 0)
                return true
            end
        end
    elseif f20_local0 <= 20 then
        f20_arg1:ClearSubGoal()
        f20_arg1:AddSubGoal(GOAL_COMMON_EndureAttack, 0.1, 3100, TARGET_ENE_0, 9999, 0)
        return true
    else
        f20_arg1:ClearSubGoal()
        if SpaceCheck(f20_arg0, f20_arg1, -45, 2) == true then
            if SpaceCheck(f20_arg0, f20_arg1, 45, 2) == true then
                if f20_arg0:IsInsideTarget(TARGET_ENE_0, AI_DIR_TYPE_R, 180) then
                    f20_arg1:AddSubGoal(GOAL_COMMON_EndureAttack, 0.1, 5202, TARGET_ENE_0, 9999, 0)
                else
                    f20_arg1:AddSubGoal(GOAL_COMMON_EndureAttack, 0.1, 5203, TARGET_ENE_0, 9999, 0)
                end
            else
                f20_arg1:AddSubGoal(GOAL_COMMON_EndureAttack, 0.1, 5202, TARGET_ENE_0, 9999, 0)
            end
        elseif SpaceCheck(f20_arg0, f20_arg1, 45, 2) == true then
            f20_arg1:AddSubGoal(GOAL_COMMON_EndureAttack, 0.1, 5203, TARGET_ENE_0, 9999, 0)
        else
            f20_arg1:AddSubGoal(GOAL_COMMON_Wait, f20_local1, TARGET_SELF, 0, 0, 0)
            f20_arg1:AddSubGoal(GOAL_COMMON_EndureAttack, 0.3, 3100, TARGET_ENE_0, 9999, 0)
        end
        return true
    end
    return false
    
end

Goal.Kengeki_Activate = function (f21_arg0, f21_arg1, f21_arg2, f21_arg3)
    local f21_local0 = ReturnKengekiSpecialEffect(f21_arg1)
    if f21_local0 == 0 then
        return false
    end
    local f21_local1 = {}
    local f21_local2 = {}
    local f21_local3 = {}
    Common_Clear_Param(f21_local1, f21_local2, f21_local3)
    local f21_local4 = f21_arg1:GetDist(TARGET_ENE_0)
    local f21_local5 = f21_arg1:GetSp(TARGET_SELF)
    if f21_local5 <= 0 then
        f21_local1[50] = 100
    elseif f21_local0 == 200200 then
        if f21_local4 >= 2.8 then
            f21_local1[8] = 100
            f21_local1[50] = 100
        elseif f21_local4 <= 0.2 then
            f21_local1[50] = 100
        else
            f21_local1[8] = 100
            f21_local1[50] = 100
        end
    elseif f21_local0 == 200201 then
        if f21_local4 >= 2.8 then
            f21_local1[9] = 100
            f21_local1[50] = 1
        else
            f21_local1[9] = 100
            f21_local1[50] = 1
        end
    elseif f21_local0 == 200205 then
        if f21_local4 >= 2.8 then
            f21_local1[1] = 100
            f21_local1[50] = 1
        elseif f21_local4 <= 0.2 then
            f21_local1[2] = 20
            f21_local1[50] = 80
        else
            f21_local1[1] = 100
            f21_local1[2] = 100
            f21_local1[50] = 1
        end
    elseif f21_local0 == 200206 then
        if f21_local4 >= 2.8 then
            f21_local1[5] = 100
            f21_local1[50] = 1
        elseif f21_local4 <= 0.2 then
            f21_local1[6] = 50
            f21_local1[24] = 20
            f21_local1[50] = 30
        else
            f21_local1[5] = 100
            f21_local1[6] = 50
            f21_local1[50] = 1
        end
    elseif f21_local0 == 200215 then
        if f21_local4 >= 2.8 then
            f21_local1[10] = 40
            f21_local1[11] = 20
            f21_local1[50] = 40
        elseif f21_local4 <= 0.2 then
            f21_local1[10] = 100
            f21_local1[50] = 1
        else
            f21_local1[10] = 100
            f21_local1[50] = 1
        end
    elseif f21_local0 == 200216 then
        if f21_local4 >= 2.8 then
            f21_local1[50] = 100
        elseif f21_local4 <= 0.2 then
            f21_local1[13] = 100
            f21_local1[50] = 1
        else
            f21_local1[5] = 100
            f21_local1[12] = 100
            f21_local1[50] = 1
        end
    end
    if f21_arg1:IsFinishTimer(6) == false or f21_arg1:GetNumber(5) <= 6 then
        f21_local1[6] = 0
        f21_local1[13] = 0
    end
    if f21_arg1:IsFinishTimer(7) == false then
        f21_local1[12] = 0
    end
    f21_local1[1] = 0
    f21_local1[2] = 0
    f21_local1[3] = 0
    f21_local1[4] = 0
    f21_local1[5] = 0
    f21_local1[6] = 0
    f21_local1[8] = 0
    f21_local1[9] = 0
    f21_local1[10] = 0
    f21_local1[11] = 0
    f21_local1[12] = 0
    f21_local1[13] = 0
    f21_local1[14] = 0
    f21_local1[15] = 0
    if f21_local0 == 200228 then
        if f21_local4 <= 2.8 then
            f21_local1[14] = 100
            f21_local1[15] = 0
        end
    elseif f21_local0 == 200210 or f21_local0 == 200211 then
        if f21_local4 <= 2.8 then
            f21_local1[14] = 100
            f21_local1[15] = 100
            f21_local1[17] = 20
        end
    elseif f21_local0 == 200215 or f21_local0 == 200216 then
        if f21_local4 <= 2.8 then
            f21_local1[14] = 100
            f21_local1[15] = 0
        end
    elseif (f21_local0 == 200200 or f21_local0 == 200201) and f21_local4 <= 2.8 then
        f21_local1[14] = 0
        f21_local1[15] = 50
        f21_local1[50] = 50
        f21_local1[12] = 100
        f21_local1[14] = 100
        f21_local1[17] = 100
    end
    if SpaceCheck(f21_arg1, f21_arg2, 90, 2) == false and SpaceCheck(f21_arg1, f21_arg2, -90, 2) == false then
        f21_local1[17] = 0
    end
    if SpaceCheck(f21_arg1, f21_arg2, 180, 2) == false then
        f21_local1[12] = 0
        f21_local1[14] = f21_local1[14] * 5
    end
    f21_local2[1] = REGIST_FUNC(f21_arg1, f21_arg2, f21_arg0.Kengeki01)
    f21_local2[2] = REGIST_FUNC(f21_arg1, f21_arg2, f21_arg0.Kengeki02)
    f21_local2[5] = REGIST_FUNC(f21_arg1, f21_arg2, f21_arg0.Kengeki05)
    f21_local2[6] = REGIST_FUNC(f21_arg1, f21_arg2, f21_arg0.Kengeki06)
    f21_local2[8] = REGIST_FUNC(f21_arg1, f21_arg2, f21_arg0.Kengeki08)
    f21_local2[9] = REGIST_FUNC(f21_arg1, f21_arg2, f21_arg0.Kengeki09)
    f21_local2[10] = REGIST_FUNC(f21_arg1, f21_arg2, f21_arg0.Kengeki10)
    f21_local2[11] = REGIST_FUNC(f21_arg1, f21_arg2, f21_arg0.Kengeki11)
    f21_local2[12] = REGIST_FUNC(f21_arg1, f21_arg2, f21_arg0.Kengeki12)
    f21_local2[13] = REGIST_FUNC(f21_arg1, f21_arg2, f21_arg0.Kengeki13)
    f21_local2[14] = REGIST_FUNC(f21_arg1, f21_arg2, f21_arg0.Kengeki14)
    f21_local2[15] = REGIST_FUNC(f21_arg1, f21_arg2, f21_arg0.Kengeki15)
    f21_local2[16] = REGIST_FUNC(f21_arg1, f21_arg2, f21_arg0.Kengeki16)
    f21_local2[17] = REGIST_FUNC(f21_arg1, f21_arg2, f21_arg0.Kengeki17)
    f21_local2[24] = REGIST_FUNC(f21_arg1, f21_arg2, f21_arg0.Act24)
    f21_local2[50] = REGIST_FUNC(f21_arg1, f21_arg2, f21_arg0.NoAction)
    local f21_local6 = REGIST_FUNC(f21_arg1, f21_arg2, f21_arg0.ActAfter_AdjustSpace)
    return Common_Kengeki_Activate(f21_arg1, f21_arg2, f21_local1, f21_local2, f21_local6, f21_local3)
    
end

Goal.Kengeki14 = function (f22_arg0, f22_arg1, f22_arg2)
    local f22_local0 = f22_arg0:GetDist(TARGET_ENE_0)
    local f22_local1 = 3066
    local f22_local2 = f22_arg0:GetRandam_Int(1, 100)
    f22_arg1:ClearSubGoal()
    if f22_arg0:HasSpecialEffectId(TARGET_SELF, 200031) then
    elseif f22_local2 <= 50 then
        f22_local1 = 3083
        if f22_arg0:HasSpecialEffectId(TARGET_SELF, 200210) then
            f22_local1 = 3087
        end
    end
    f22_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 1, f22_local1, TARGET_ENE_0, 9999, 0, 0)
    
end

Goal.Kengeki15 = function (f23_arg0, f23_arg1, f23_arg2)
    local f23_local0 = f23_arg0:GetDist(TARGET_ENE_0)
    local f23_local1 = 3031
    local f23_local2 = 3066
    local f23_local3 = 0
    local f23_local4 = 0
    f23_arg1:ClearSubGoal()
    f23_arg0:SetNumber(5, 0)
    f23_arg0:SetNumber(1, 1)
    if SpaceCheck(f23_arg0, f23_arg1, 180, 2) == false then
        f23_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 10, f23_local1, TARGET_ENE_0, 9999, f23_local3, f23_local4, 0, 0)
    elseif f23_local0 <= 2.4 then
        f23_arg0:SetNumber(4, f23_arg0:GetNumber(4) + 1)
        f23_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 15, f23_local2, TARGET_ENE_0, 9999, f23_local3, f23_local4, 0, 0)
    else
        f23_arg0:SetNumber(4, 0)
        f23_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 10, f23_local1, TARGET_ENE_0, 9999, f23_local3, f23_local4, 0, 0)
    end
    
end

Goal.Kengeki16 = function (f24_arg0, f24_arg1, f24_arg2)
    local f24_local0 = 3057
    local f24_local1 = 3017
    local f24_local2 = 0
    local f24_local3 = 0
    f24_arg1:ClearSubGoal()
    if f24_arg0:GetNumber(5) >= 15 or f24_arg0:GetStringIndexedNumber("spFlag") >= 3 then
        f24_arg0:SetNumber(5, 0)
        f24_arg1:AddSubGoal(GOAL_COMMON_ComboAttackTunableSpin, 10, f24_local0, TARGET_ENE_0, 9999, f24_local2, f24_local3, 0, 0)
        f24_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, f24_local1, TARGET_ENE_0, 9999, 0, 0):TimingSetTimer(6, 8, AI_TIMING_SET__ACTIVATE)
    else
        f24_arg0:SetTimer(6, 8)
        f24_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 1, 3077, TARGET_ENE_0, 9999, 0, 0):TimingSetNumber(5, f24_arg0:GetNumber(5) + 2, AI_TIMING_SET__ACTIVATE)
    end
    
end

Goal.Kengeki17 = function (f25_arg0, f25_arg1, f25_arg2)
    local f25_local0 = f25_arg0:GetDist(TARGET_ENE_0)
    local f25_local1 = 3034
    local f25_local2 = 3035
    local f25_local3 = f25_arg0:GetRandam_Int(1, 100)
    local f25_local4 = 0
    local f25_local5 = 0
    f25_arg1:ClearSubGoal()
    f25_arg0:SetNumber(5, 0)
    if SpaceCheck(f25_arg0, f25_arg1, -90, 2) and SpaceCheck(f25_arg0, f25_arg1, 90, 2) then
        if f25_local3 <= 50 then
            f25_local1 = 3035
        end
    elseif SpaceCheck(f25_arg0, f25_arg1, -90, 2) == true then
        f25_local1 = 3035
    else
    end
    f25_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 10, f25_local1, TARGET_ENE_0, 9999, f25_local4, f25_local5, 0, 0)
    
end

Goal.Kengeki01 = function (f26_arg0, f26_arg1, f26_arg2)
    local f26_local0 = 3050
    local f26_local1 = 3013
    local f26_local2 = 3014
    local f26_local3 = 2.5 - f26_arg0:GetMapHitRadius(TARGET_SELF)
    local f26_local4 = 5 - f26_arg0:GetMapHitRadius(TARGET_SELF)
    local f26_local5 = 0
    local f26_local6 = 0
    local f26_local7 = f26_arg0:GetRandam_Int(1, 100)
    f26_arg1:ClearSubGoal()
    if f26_local7 <= 30 then
        f26_arg1:AddSubGoal(GOAL_COMMON_ComboAttackTunableSpin, 10, f26_local0, TARGET_ENE_0, f26_local3, f26_local5, f26_local6, 0, 0):TimingSetNumber(5, f26_arg0:GetNumber(5) + 1, AI_TIMING_SET__ACTIVATE)
        f26_arg1:AddSubGoal(GOAL_COMMON_ComboRepeat, 10, f26_local1, TARGET_ENE_0, f26_local4, 0):TimingSetNumber(5, f26_arg0:GetNumber(5) + 2, AI_TIMING_SET__ACTIVATE)
        f26_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, f26_local2, TARGET_ENE_0, 9999, 0, 0):TimingSetNumber(5, f26_arg0:GetNumber(5) + 3, AI_TIMING_SET__ACTIVATE)
    elseif f26_local7 <= 70 then
        f26_arg1:AddSubGoal(GOAL_COMMON_ComboAttackTunableSpin, 10, f26_local0, TARGET_ENE_0, 9999, f26_local5, f26_local6, 0, 0):TimingSetNumber(5, f26_arg0:GetNumber(5) + 1, AI_TIMING_SET__ACTIVATE)
        f26_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, f26_local1, TARGET_ENE_0, 9999, 0, 0):TimingSetNumber(5, f26_arg0:GetNumber(5) + 2, AI_TIMING_SET__ACTIVATE)
    else
        f26_arg1:AddSubGoal(GOAL_COMMON_ComboAttackTunableSpin, 10, f26_local0, TARGET_ENE_0, 9999, f26_local5, f26_local6, 0, 0):TimingSetNumber(5, f26_arg0:GetNumber(5) + 1, AI_TIMING_SET__ACTIVATE)
    end
    
end

Goal.Kengeki02 = function (f27_arg0, f27_arg1, f27_arg2)
    local f27_local0 = 3051
    local f27_local1 = 3016
    local f27_local2 = 3017
    local f27_local3 = 2.5 - f27_arg0:GetMapHitRadius(TARGET_SELF)
    local f27_local4 = 2.5 - f27_arg0:GetMapHitRadius(TARGET_SELF)
    local f27_local5 = 0
    local f27_local6 = 0
    local f27_local7 = f27_arg0:GetRandam_Int(1, 100)
    f27_arg1:ClearSubGoal()
    if f27_arg0:GetNumber(5) >= 15 or f27_arg0:GetStringIndexedNumber("spFlag") >= 3 then
        f27_arg0:SetNumber(5, 0)
        f27_arg1:AddSubGoal(GOAL_COMMON_ComboAttackTunableSpin, 10, f27_local0, TARGET_ENE_0, f27_local3, f27_local5, f27_local6, 0, 0)
        f27_arg1:AddSubGoal(GOAL_COMMON_ComboRepeat, 10, f27_local1, TARGET_ENE_0, f27_local4, 0)
        f27_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, f27_local2, TARGET_ENE_0, 9999, 0, 0)
    elseif f27_arg0:IsFinishTimer(6) == true then
        f27_arg1:AddSubGoal(GOAL_COMMON_ComboAttackTunableSpin, 10, f27_local0, TARGET_ENE_0, f27_local3, f27_local5, f27_local6, 0, 0):TimingSetNumber(5, f27_arg0:GetNumber(5) + 1, AI_TIMING_SET__ACTIVATE)
    else
        f27_arg1:AddSubGoal(GOAL_COMMON_ComboAttackTunableSpin, 10, f27_local0, TARGET_ENE_0, f27_local3, f27_local5, f27_local6, 0, 0):TimingSetNumber(5, f27_arg0:GetNumber(5) + 1, AI_TIMING_SET__ACTIVATE)
        f27_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, f27_local1, TARGET_ENE_0, 9999, 0, 0):TimingSetNumber(5, f27_arg0:GetNumber(5) + 2, AI_TIMING_SET__ACTIVATE):TimingSetTimer(6, 8, AI_TIMING_SET__ACTIVATE)
    end
    
end

Goal.Kengeki05 = function (f28_arg0, f28_arg1, f28_arg2)
    local f28_local0 = 3056
    local f28_local1 = 3012
    local f28_local2 = 3013
    local f28_local3 = 3014
    local f28_local4 = 2.5 - f28_arg0:GetMapHitRadius(TARGET_SELF)
    local f28_local5 = 2.5 - f28_arg0:GetMapHitRadius(TARGET_SELF)
    local f28_local6 = 5 - f28_arg0:GetMapHitRadius(TARGET_SELF)
    local f28_local7 = 0
    local f28_local8 = 0
    local f28_local9 = f28_arg0:GetRandam_Int(1, 100)
    f28_arg1:ClearSubGoal()
    if f28_local9 <= 30 or f28_arg0:GetNumber(7) >= 3 then
        f28_arg0:SetNumber(7, 0)
        f28_arg1:AddSubGoal(GOAL_COMMON_ComboAttackTunableSpin, 10, f28_local0, TARGET_ENE_0, f28_local4, f28_local7, f28_local8, 0, 0):TimingSetNumber(5, f28_arg0:GetNumber(5) + 1, AI_TIMING_SET__ACTIVATE)
        f28_arg1:AddSubGoal(GOAL_COMMON_ComboRepeat, 10, f28_local1, TARGET_ENE_0, f28_local5, 0):TimingSetNumber(5, f28_arg0:GetNumber(5) + 2, AI_TIMING_SET__ACTIVATE)
        f28_arg1:AddSubGoal(GOAL_COMMON_ComboRepeat, 10, f28_local2, TARGET_ENE_0, 9999, 0):TimingSetNumber(5, f28_arg0:GetNumber(5) + 3, AI_TIMING_SET__ACTIVATE)
        f28_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, f28_local3, TARGET_ENE_0, 9999, 0, 0):TimingSetNumber(5, f28_arg0:GetNumber(5) + 4, AI_TIMING_SET__ACTIVATE)
    elseif f28_local9 <= 60 then
        f28_arg0:SetNumber(7, f28_arg0:GetNumber(7) + 1)
        f28_arg1:AddSubGoal(GOAL_COMMON_ComboAttackTunableSpin, 10, f28_local0, TARGET_ENE_0, f28_local4, f28_local7, f28_local8, 0, 0):TimingSetNumber(5, f28_arg0:GetNumber(5) + 1, AI_TIMING_SET__ACTIVATE)
        f28_arg1:AddSubGoal(GOAL_COMMON_ComboRepeat, 10, f28_local1, TARGET_ENE_0, f28_local5, 0):TimingSetNumber(5, f28_arg0:GetNumber(5) + 2, AI_TIMING_SET__ACTIVATE)
        f28_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, f28_local2, TARGET_ENE_0, 9999, 0, 0):TimingSetNumber(5, f28_arg0:GetNumber(5) + 3, AI_TIMING_SET__ACTIVATE)
    elseif f28_local9 <= 90 then
        f28_arg0:SetNumber(7, f28_arg0:GetNumber(7) + 1)
        f28_arg1:AddSubGoal(GOAL_COMMON_ComboAttackTunableSpin, 10, f28_local0, TARGET_ENE_0, f28_local4, f28_local7, f28_local8, 0, 0):TimingSetNumber(5, f28_arg0:GetNumber(5) + 1, AI_TIMING_SET__ACTIVATE)
        f28_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, f28_local1, TARGET_ENE_0, 9999, 0, 0):TimingSetNumber(5, f28_arg0:GetNumber(5) + 2, AI_TIMING_SET__ACTIVATE)
    elseif f28_local9 <= 100 then
        f28_arg0:SetNumber(7, f28_arg0:GetNumber(7) + 1)
        f28_arg1:AddSubGoal(GOAL_COMMON_ComboAttackTunableSpin, 10, f28_local0, TARGET_ENE_0, f28_local4, f28_local7, f28_local8, 0, 0):TimingSetNumber(5, f28_arg0:GetNumber(5) + 1, AI_TIMING_SET__ACTIVATE)
    end
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

Goal.Kengeki06 = function (f29_arg0, f29_arg1, f29_arg2)
    f29_arg1:ClearSubGoal()
    local f29_local0 = 3057
    local f29_local1 = 3017
    local f29_local2 = 0
    local f29_local3 = 0
    if f29_arg0:GetNumber(5) >= 15 or f29_arg0:GetStringIndexedNumber("spFlag") >= 3 then
        f29_arg0:SetNumber(5, 0)
        f29_arg1:AddSubGoal(GOAL_COMMON_ComboAttackTunableSpin, 10, f29_local0, TARGET_ENE_0, 9999, f29_local2, f29_local3, 0, 0)
        f29_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, f29_local1, TARGET_ENE_0, 9999, 0, 0):TimingSetTimer(6, 8, AI_TIMING_SET__ACTIVATE)
    else
        f29_arg0:SetTimer(6, 8)
        f29_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 1, 3077, TARGET_ENE_0, 9999, 0, 0):TimingSetNumber(5, f29_arg0:GetNumber(5) + 2, AI_TIMING_SET__ACTIVATE)
    end
    
end

Goal.Kengeki08 = function (f30_arg0, f30_arg1, f30_arg2)
    f30_arg1:ClearSubGoal()
    f30_arg0:SetNumber(MENFLAG, 0)
    f30_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 1, 3060, TARGET_ENE_0, 9999, 0, 0)
    
end

Goal.Kengeki09 = function (f31_arg0, f31_arg1, f31_arg2)
    local f31_local0 = 3065
    local f31_local1 = 3012
    local f31_local2 = 3013
    local f31_local3 = 3014
    local f31_local4 = 2.5 - f31_arg0:GetMapHitRadius(TARGET_SELF)
    local f31_local5 = 2.5 - f31_arg0:GetMapHitRadius(TARGET_SELF)
    local f31_local6 = 5 - f31_arg0:GetMapHitRadius(TARGET_SELF)
    local f31_local7 = 0
    local f31_local8 = 0
    local f31_local9 = f31_arg0:GetRandam_Int(1, 100)
    f31_arg1:ClearSubGoal()
    if f31_local9 <= 10 then
        f31_arg1:AddSubGoal(GOAL_COMMON_ComboAttackTunableSpin, 10, f31_local0, TARGET_ENE_0, f31_local4, f31_local7, f31_local8, 0, 0):TimingSetNumber(5, f31_arg0:GetNumber(5) + 1, AI_TIMING_SET__ACTIVATE)
        f31_arg1:AddSubGoal(GOAL_COMMON_ComboRepeat, 10, f31_local1, TARGET_ENE_0, f31_local5, 0):TimingSetNumber(5, f31_arg0:GetNumber(5) + 2, AI_TIMING_SET__ACTIVATE)
        f31_arg1:AddSubGoal(GOAL_COMMON_ComboRepeat, 10, f31_local2, TARGET_ENE_0, 9999, 0):TimingSetNumber(5, f31_arg0:GetNumber(5) + 3, AI_TIMING_SET__ACTIVATE)
        f31_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, f31_local3, TARGET_ENE_0, 9999, 0, 0):TimingSetNumber(5, f31_arg0:GetNumber(5) + 4, AI_TIMING_SET__ACTIVATE)
    elseif f31_local9 <= 30 then
        f31_arg1:AddSubGoal(GOAL_COMMON_ComboAttackTunableSpin, 10, f31_local0, TARGET_ENE_0, f31_local4, f31_local7, f31_local8, 0, 0):TimingSetNumber(5, f31_arg0:GetNumber(5) + 1, AI_TIMING_SET__ACTIVATE)
        f31_arg1:AddSubGoal(GOAL_COMMON_ComboRepeat, 10, f31_local1, TARGET_ENE_0, f31_local5, 0):TimingSetNumber(5, f31_arg0:GetNumber(5) + 2, AI_TIMING_SET__ACTIVATE)
        f31_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, f31_local2, TARGET_ENE_0, 9999, 0, 0):TimingSetNumber(5, f31_arg0:GetNumber(5) + 3, AI_TIMING_SET__ACTIVATE)
    elseif f31_local9 <= 65 then
        f31_arg1:AddSubGoal(GOAL_COMMON_ComboAttackTunableSpin, 10, f31_local0, TARGET_ENE_0, f31_local4, f31_local7, f31_local8, 0, 0):TimingSetNumber(5, f31_arg0:GetNumber(5) + 1, AI_TIMING_SET__ACTIVATE)
        f31_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, f31_local1, TARGET_ENE_0, 9999, 0, 0):TimingSetNumber(5, f31_arg0:GetNumber(5) + 2, AI_TIMING_SET__ACTIVATE)
    else
        f31_arg1:AddSubGoal(GOAL_COMMON_ComboAttackTunableSpin, 10, f31_local0, TARGET_ENE_0, f31_local4, f31_local7, f31_local8, 0, 0):TimingSetNumber(5, f31_arg0:GetNumber(5) + 1, AI_TIMING_SET__ACTIVATE)
    end
    
end

Goal.Kengeki13 = function (f32_arg0, f32_arg1, f32_arg2)
    f32_arg1:ClearSubGoal()
    local f32_local0 = 3077
    local f32_local1 = 3017
    local f32_local2 = 0
    local f32_local3 = 0
    if f32_arg0:GetNumber(5) >= 15 or f32_arg0:GetStringIndexedNumber("spFlag") >= 3 then
        f32_arg0:SetNumber(5, 0)
        f32_arg1:AddSubGoal(GOAL_COMMON_ComboAttackTunableSpin, 10, f32_local0, TARGET_ENE_0, 9999, f32_local2, f32_local3, 0, 0)
        f32_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, f32_local1, TARGET_ENE_0, 9999, 0, 0)
    else
        f32_arg0:SetTimer(6, 8)
        f32_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 1, 3077, TARGET_ENE_0, 9999, 0, 0):TimingSetNumber(5, f32_arg0:GetNumber(5) + 2, AI_TIMING_SET__ACTIVATE)
    end
    
end

Goal.Kengeki10 = function (f33_arg0, f33_arg1, f33_arg2)
    f33_arg1:ClearSubGoal()
    f33_arg0:SetNumber(5, f33_arg0:GetNumber(5) + 1)
    f33_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 1, 3071, TARGET_ENE_0, 9999, 0, 0)
    
end

Goal.Kengeki11 = function (f34_arg0, f34_arg1, f34_arg2)
    f34_arg1:ClearSubGoal()
    f34_arg0:SetNumber(5, f34_arg0:GetNumber(5) + 3)
    f34_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 1, 3073, TARGET_ENE_0, 9999, 0, 0)
    
end

Goal.Kengeki12 = function (f35_arg0, f35_arg1, f35_arg2)
    f35_arg1:ClearSubGoal()
    f35_arg0:SetNumber(5, f35_arg0:GetNumber(5) + 1)
    f35_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 1, 3076, TARGET_ENE_0, 9999, 0, 0):TimingSetTimer(7, 20, AI_TIMING_SET__ACTIVATE)
    
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


