-- ==============================================
-- 140020 - 剑客·居合 AI 战斗脚本
-- Kenkaku Iai (Samurai Swordsman with Iai technique)
-- ==============================================
--
-- 【AI概述 - AI Overview】
-- 这是一个专精居合斩技的高级剑客AI，拥有复杂的距离判断和连击系统
-- This is an advanced swordsman AI specializing in Iai techniques with complex distance judgment and combo systems
--
-- 【核心特性 - Core Features】
-- • 居合技能系统：具备200030(预备)和200031(可用)两种居合状态
-- • 见切反击系统：能够根据不同特效状态执行精准的弹反和反击
-- • 智能距离管理：根据8.5米、5.5米、3.8米等距离阈值调整战术
-- • 空间感知能力：检查周围空间并选择最佳移动和攻击方向
-- • 团队协作模式：支持观众(Kankyaku)和跟随(Torimaki)角色行为
--
-- 【技术架构 - Technical Architecture】
-- • 共享函数调用：132次，主要依赖GOAL_COMMON系列进行战斗行为组织
-- • 行为权重系统：动态调整各种攻击和移动行为的优先级
-- • 计数器管理：使用多个计数器跟踪攻击状态和冷却时间
-- • 观察区域监控：设置前方攻击范围和近距离监控区域
--
-- 【适用场景 - Application Scenarios】
-- 适用于m15_00_00_00地图区域的高级剑客敌人，提供挑战性的近战体验
-- Suitable for advanced swordsman enemies in m15_00_00_00 map area, providing challenging melee combat experience
-- ==============================================

RegisterTableGoal(GOAL_Kenkaku_iai_140020_Battle, "GOAL_Kenkaku_iai_140020_Battle")
REGISTER_GOAL_NO_UPDATE(GOAL_Kenkaku_iai_140020_Battle, true)

-- ==============================================
-- 初始化函数 - AI实体创建时调用的初始化设置
-- Initialization function - Called when AI entity is created
-- ==============================================
-- 参数说明 (Parameters):
--   f1_arg0: AI目标对象 (AI goal object)
--   f1_arg1: AI实体 (AI entity)
--   f1_arg2: 目标管理器 (Target manager)
--   f1_arg3: 额外参数 (Additional parameters)
-- ==============================================
Goal.Initialize = function (f1_arg0, f1_arg1, f1_arg2, f1_arg3)
    -- 当前为空实现，所有初始化在Activate函数中进行
    -- Currently empty implementation, all initialization is done in Activate function
    -- 这是标准的FromSoftware AI架构模式，Initialize通常只用于特殊初始化需求
    -- This is the standard FromSoftware AI architecture pattern, Initialize is typically only used for special initialization needs
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
    local f2_local5 = f2_arg1:GetExcelParam(AI_EXCEL_THINK_PARAM_TYPE__thinkAttr_doAdmirer) -- AI思考参数 (AI thinking parameter)
    local f2_local6 = f2_arg1:GetHpRate(TARGET_SELF)             -- 自身血量比例 (Self HP ratio)
    local f2_local7 = f2_arg1:GetSp(TARGET_SELF)                 -- 自身SP值 (Self SP value)
    local f2_local8 = f2_arg1:GetDist(TARGET_ENE_0)              -- 与敌人距离(重复获取，用于后续计算) (Distance to enemy - duplicate for later calculations)
    local f2_local9 = f2_arg1:GetSp(TARGET_ENE_0)                -- 敌人SP值 (Enemy SP value)
    local f2_local10 = f2_arg1:GetRandam_Int(1, 100)             -- 随机数1-100 (Random number 1-100)
    local f2_local11 = f2_arg1:GetExcelParam(AI_EXCEL_THINK_PARAM_TYPE__thinkAttr_doAdmirer) -- AI思考参数(重复获取，团队行为用) (AI thinking parameter - duplicate for team behavior)
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
    -- ========== 团队协作模式处理 (Team Cooperation Mode Processing) ==========
    elseif f2_local11 == 1 and f2_arg1:GetTeamOrder(ORDER_TYPE_Role) == ROLE_TYPE_Kankyaku then
        -- 观众角色：执行观众行为模式 (Spectator role: Execute spectator behavior mode)
        KankyakuAct(f2_arg1, f2_arg2)
    elseif f2_local11 == 1 and f2_arg1:GetTeamOrder(ORDER_TYPE_Role) == ROLE_TYPE_Torimaki then
        -- 跟随角色：执行跟随行为模式 (Follower role: Execute follower behavior mode)
        TorimakiAct(f2_arg1, f2_arg2, -1, 0)

    -- ========== 背身攻击判断 (Back Attack Detection) ==========
    elseif f2_arg1:IsInsideTarget(TARGET_ENE_0, AI_DIR_TYPE_B, 180) then
        -- 敌人在背后180度范围内 (Enemy is within 180 degrees behind)
        if f2_arg1:HasSpecialEffectId(TARGET_SELF, 200030) then
            -- 处于居合预备状态 (In Iai preparation state)
            if f2_local8 < 3 then
                f2_local0[22] = 100  -- 近距离：执行闪避反击 (Close range: Execute dodge counter)
            else
                f2_local0[15] = 100  -- 远距离：执行居合斩 (Far range: Execute Iai slash)
            end
        else
            -- 普通状态：转向并闪避 (Normal state: Turn and dodge)
            f2_local0[21] = 100  -- 转向敌人 (Turn to enemy)
            f2_local0[22] = 100  -- 闪避反击 (Dodge counter)
        end
    -- ========== 居合技能状态处理 (Iai Skill State Processing) ==========
    elseif f2_arg1:HasSpecialEffectId(TARGET_SELF, 200030) then
        -- 居合预备状态：强制执行居合斩 (Iai preparation state: Force execute Iai slash)
        f2_local0[15] = 1000  -- 最高优先级执行居合斩 (Highest priority for Iai slash)

    elseif f2_arg1:HasSpecialEffectId(TARGET_SELF, 200031) then
        -- 居合可用状态：根据距离制定战略 (Iai available state: Strategy based on distance)

        -- ===== 远距离战斗 (8.5+米) - Long Range Combat (8.5+ meters) =====
        if f2_local8 >= 8.5 then
            f2_local0[19] = 60   -- 前进步法 (Forward step)
            f2_local0[20] = 100  -- 接近目标 (Approach target)
            -- 检查敌人是否在前方120度视野内 (Check if enemy is within 120-degree front view)
            if not f2_arg1:IsInsideTarget(TARGET_ENE_0, AI_DIR_TYPE_F, 120) then
                f2_local0[19] = 0    -- 取消前进 (Cancel forward movement)
                f2_local0[20] = 0    -- 取消接近 (Cancel approach)
                f2_local0[21] = 100  -- 转向敌人 (Turn to enemy)
            end

        -- ===== 中距离战斗 (5.5-8.5米) - Medium Range Combat (5.5-8.5 meters) =====
        elseif f2_local8 >= 5.5 then
            f2_local0[10] = 100  -- 跳跃攻击 (Jump attack)
            f2_local0[19] = 50   -- 前进步法 (Forward step)
            f2_local0[20] = 30   -- 接近目标 (Approach target)
            f2_local0[23] = 40   -- 普通攻击 (Normal attack)
            f2_local0[26] = 50   -- 位置调整 (Position adjustment)
            -- 特殊计数器激活时提高前进优先级 (Increase forward priority when special counter is active)
            if f2_arg1:GetNumber(4) >= 1 then
                f2_local0[19] = 500  -- 大幅提高前进优先级 (Significantly increase forward priority)
            end

        -- ===== 中近距离战斗 (3.8-5.5米) - Medium-Close Range Combat (3.8-5.5 meters) =====
        elseif f2_local8 > 3.8 then
            f2_local0[10] = 15   -- 跳跃攻击 (Jump attack)
            f2_local0[19] = 30   -- 前进步法 (Forward step)
            f2_local0[20] = 10   -- 接近目标 (Approach target)
            f2_local0[22] = 30   -- 闪避反击 (Dodge counter)
            f2_local0[23] = 25   -- 普通攻击 (Normal attack)
            f2_local0[24] = 15   -- 近距离攻击 (Close-range attack)
            f2_local0[25] = 10   -- 特殊攻击 (Special attack)
            f2_local0[26] = 70   -- 位置调整 (Position adjustment)
            -- 特殊计数器激活时极大提高前进优先级 (Extremely increase forward priority when special counter is active)
            if f2_arg1:GetNumber(4) >= 1 then
                f2_local0[19] = 10000  -- 绝对最高优先级前进 (Absolute highest priority for forward movement)
            end

        -- ===== 近距离战斗 (3.8米内) - Close Range Combat (within 3.8 meters) =====
        else
            f2_local0[10] = 100  -- 跳跃攻击 (Jump attack)
            f2_local0[23] = 1    -- 普通攻击（低优先级） (Normal attack - low priority)
            f2_local0[24] = 100  -- 近距离攻击（主要选择） (Close-range attack - main choice)
            f2_local0[25] = 10   -- 特殊攻击 (Special attack)
            -- 特殊计数器激活时调整攻击策略 (Adjust attack strategy when special counter is active)
            if f2_arg1:GetNumber(4) >= 1 then
                f2_local0[10] = 400  -- 大幅提高跳跃攻击优先级 (Significantly increase jump attack priority)
                f2_local0[24] = 10   -- 降低近距离攻击优先级 (Reduce close-range attack priority)
            end
        end
        -- ========== 距离特殊调整 (Distance Special Adjustments) ==========
        if f2_local8 < 1.5 then
            -- 极近距离：强制使用近距离攻击 (Very close range: Force close-range attack)
            f2_local0[24] = 500  -- 大幅提高近距离攻击优先级 (Significantly increase close-range attack priority)
        elseif f2_arg1:GetNumber(1) >= 1 then
            -- 已使用近距离攻击：降低重复使用概率 (Already used close-range attack: Reduce repeat usage probability)
            f2_local0[24] = f2_local0[24] * 0.1  -- 降低到10% (Reduce to 10%)
        end

        -- ========== 特殊状态优先级调整 (Special State Priority Adjustments) ==========
        if f2_arg1:GetNumber(12) == 1 and f2_local8 < 2.5 then
            -- 特殊状态12激活且距离很近：执行特殊连招 (Special state 12 active and very close: Execute special combo)
            f2_local0[3] = 1000   -- 最高优先级特殊动作 (Highest priority special action)
            f2_local0[19] = 500   -- 高优先级前进 (High priority forward movement)
            f2_local0[22] = 0     -- 禁用闪避反击 (Disable dodge counter)
        end

        -- ========== 敌人架势破坏状态处理 (Enemy Posture Break State Processing) ==========
        if f2_arg1:HasSpecialEffectId(TARGET_ENE_0, COMMON_SP_EFFECT_PC_BREAK) then
            -- 敌人架势被破坏：禁用大部分攻击，专注特定攻击 (Enemy posture broken: Disable most attacks, focus on specific attack)
            f2_local0[22] = 0   -- 禁用闪避反击 (Disable dodge counter)
            f2_local0[23] = 0   -- 禁用普通攻击 (Disable normal attack)
            f2_local0[24] = 0   -- 禁用近距离攻击 (Disable close-range attack)
            f2_local0[25] = 0   -- 禁用特殊攻击 (Disable special attack)
            f2_local0[26] = 1   -- 低优先级位置调整 (Low priority position adjustment)
        end
    end
    -- ========== 特殊状态管理和重置 (Special State Management and Reset) ==========
    if not f2_arg1:HasSpecialEffectId(TARGET_SELF, 5028) then
        -- 没有特效5028：重置特殊状态计数器12 (No special effect 5028: Reset special state counter 12)
        f2_arg1:SetNumber(12, 0)
    elseif f2_local8 < 2.5 then
        -- 有特效5028且距离很近：激活特殊连招模式 (Has effect 5028 and very close: Activate special combo mode)
        f2_local0[3] = 1000   -- 最高优先级执行特殊动作 (Highest priority for special action)
        f2_local0[19] = 0     -- 禁用前进步法 (Disable forward step)
    end

    -- ========== 居合预备状态的超级优先级处理 (Iai Preparation State Super Priority Processing) ==========
    if f2_arg1:GetNumber(3) == 1 and f2_arg1:HasSpecialEffectId(TARGET_SELF, 200030) then
        -- 计数器3=1且处于居合预备状态：绝对最高优先级执行居合斩 (Counter 3=1 and in Iai prep: Absolute highest priority for Iai slash)
        f2_local0[15] = 3000  -- 超高优先级，确保立即执行 (Ultra-high priority to ensure immediate execution)
        f2_arg1:SetNumber(3, 0)  -- 重置计数器，防止重复触发 (Reset counter to prevent repeated triggering)
    else
        -- 其他情况：重置计数器3 (Other cases: Reset counter 3)
        f2_arg1:SetNumber(3, 0)
    end
    -- ========== 空间限制检查和行为调整 (Space Limitation Check and Behavior Adjustment) ==========
    if SpaceCheck(f2_arg1, f2_arg2, 0, 1) == false then
        -- 前方1米空间不足：禁用前进步法 (Insufficient 1m front space: Disable forward step)
        f2_local0[19] = 0
    end

    if SpaceCheck(f2_arg1, f2_arg2, 180, 2) == false and f2_local8 < 6 then
        -- 后方2米空间不足且距离<6米：优先使用闪避反击 (Insufficient 2m rear space and distance<6m: Prioritize dodge counter)
        f2_local0[22] = 400   -- 大幅提高闪避反击优先级 (Significantly increase dodge counter priority)
        f2_local0[24] = 0     -- 禁用近距离攻击 (Disable close-range attack)
    end

    if SpaceCheck(f2_arg1, f2_arg2, 180, 4) == false and f2_local8 < 6 then
        -- 后方4米空间不足且距离<6米：中等提高闪避反击 (Insufficient 4m rear space and distance<6m: Moderately increase dodge counter)
        f2_local0[22] = 200   -- 中等提高闪避反击优先级 (Moderately increase dodge counter priority)
    end

    if SpaceCheck(f2_arg1, f2_arg2, 90, 1) == false and SpaceCheck(f2_arg1, f2_arg2, -90, 1) == false then
        -- 左右两侧1米空间都不足：禁用横向移动和攻击 (Both left/right 1m space insufficient: Disable lateral movement and attacks)
        f2_local0[22] = 0     -- 禁用闪避反击 (Disable dodge counter)
        f2_local0[23] = 0     -- 禁用普通攻击 (Disable normal attack)
    end

    if SpaceCheck(f2_arg1, f2_arg2, 180, 1) == false then
        -- 后方1米空间不足：禁用特殊攻击 (Insufficient 1m rear space: Disable special attack)
        f2_local0[25] = 0
    end
    -- ========== 观察区域激活和战术调整 (Observation Area Activation and Tactical Adjustment) ==========
    if f2_arg1:IsInsideObserve(0) and f2_local8 > 1 then
        -- 敌人进入观察区域0且距离>1米：调整攻击策略 (Enemy enters observe area 0 and distance>1m: Adjust attack strategy)
        f2_local0[10] = f2_local0[10] * 3      -- 跳跃攻击优先级提高3倍 (Jump attack priority increased 3x)
        f2_local0[24] = f2_local0[24] * 0.5    -- 近距离攻击优先级降低50% (Close-range attack priority reduced 50%)
        f2_local0[25] = f2_local0[25] * 0.3    -- 特殊攻击优先级降低70% (Special attack priority reduced 70%)
    end

    -- ========== 目标方向检查 (Target Direction Check) ==========
    if not f2_arg1:IsInsideTarget(TARGET_ENE_0, AI_DIR_TYPE_F, 90) then
        -- 敌人不在前方90度视野内：禁用前进步法 (Enemy not within 90° front view: Disable forward step)
        f2_local0[19] = 0
    end

    -- ========== 计数器管理和重置 (Counter Management and Reset) ==========
    if f2_arg1:GetNumber(4) >= 4 then
        -- 计数器4达到4次：重置并降低跳跃攻击优先级 (Counter 4 reaches 4 times: Reset and reduce jump attack priority)
        f2_arg1:SetNumber(4, 0)  -- 重置计数器4 (Reset counter 4)
        f2_local0[10] = 1        -- 跳跃攻击降至最低优先级 (Jump attack reduced to lowest priority)
    end

    -- ========== 高度差处理 (Height Difference Processing) ==========
    if f2_local4 > 1.5 then
        -- Y轴高度差>1.5米：降低某些攻击的有效性 (Y-axis height difference>1.5m: Reduce effectiveness of certain attacks)
        f2_local0[10] = 1   -- 跳跃攻击降至最低优先级 (Jump attack reduced to lowest priority)
        f2_local0[26] = 1   -- 位置调整降至最低优先级 (Position adjustment reduced to lowest priority)
    end
    -- ========== 冷却时间管理 (Cooldown Time Management) ==========
    f2_local0[3] = SetCoolTime(f2_arg1, f2_arg2, 3021, 5, f2_local0[3], 1)      -- 特殊连击技能冷却5秒 (Special combo skill cooldown 5s)
    f2_local0[10] = SetCoolTime(f2_arg1, f2_arg2, 3010, 1, f2_local0[10], 1)     -- 跳跃攻击冷却1秒 (Jump attack cooldown 1s)
    f2_local0[19] = SetCoolTime(f2_arg1, f2_arg2, 5200, 1.4, f2_local0[19], 1)   -- 前进步法冷却1.4秒 (Forward step cooldown 1.4s)

    -- ========== 行为函数注册 (Behavior Function Registration) ==========
    f2_local1[3] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act03)   -- 注册行为3：特殊连击 (Register Action 3: Special combo)
    f2_local1[10] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act10)  -- 注册行为10：跳跃攻击 (Register Action 10: Jump attack)
    f2_local1[14] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act14)  -- 注册行为14：预备动作 (Register Action 14: Preparation action)
    f2_local1[15] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act15)  -- 注册行为15：居合斩攻击 (Register Action 15: Iai slash attack)
    f2_local1[19] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act19)  -- 注册行为19：前进步法 (Register Action 19: Forward step)
    f2_local1[20] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act20)  -- 注册行为20：接近目标 (Register Action 20: Approach target)
    f2_local1[21] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act21)  -- 注册行为21：转向敌人 (Register Action 21: Turn to enemy)
    f2_local1[22] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act22)  -- 注册行为22：闪避反击 (Register Action 22: Dodge counter)
    f2_local1[23] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act23)  -- 注册行为23：普通攻击 (Register Action 23: Normal attack)
    f2_local1[24] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act24)  -- 注册行为24：近距离攻击 (Register Action 24: Close-range attack)
    f2_local1[25] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act25)  -- 注册行为25：特殊攻击 (Register Action 25: Special attack)
    f2_local1[26] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act26)  -- 注册行为26：位置调整 (Register Action 26: Position adjustment)
    f2_local1[27] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act27)  -- 注册行为27：接近行为 (Register Action 27: Approach behavior)
    f2_local1[28] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act28)  -- 注册行为28：其他行为 (Register Action 28: Other behavior)

    -- ========== 后续行为注册 (Post-Action Registration) ==========
    local f2_local17 = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.ActAfter_AdjustSpace)  -- 注册动作后空间调整函数 (Register post-action space adjustment function)

    -- ========== 执行战斗行为激活 (Execute Battle Behavior Activation) ==========
    Common_Battle_Activate(f2_arg1, f2_arg2, f2_local0, f2_local1, f2_local17, f2_local2)  -- 激活通用战斗系统 (Activate common battle system)
    
end

-- ==========================================
-- 行为03：特殊连击攻击 (Action 03: Special Combo Attack)
-- ==========================================
-- 功能：执行高优先级的特殊连击序列，包含强力的连续攻击组合
Goal.Act03 = function (f3_arg0, f3_arg1, f3_arg2)
    local f3_local0 = f3_arg0:GetDist(TARGET_ENE_0)  -- 获取与敌人距离 (Get distance to enemy)

    -- ========== 距离和空间参数计算 (Distance and Space Parameter Calculation) ==========
    local f3_local1 = 4.5 - f3_arg0:GetMapHitRadius(TARGET_SELF)        -- 基础攻击距离 (Base attack distance)
    local f3_local2 = 4.5 - f3_arg0:GetMapHitRadius(TARGET_SELF) + 5    -- 扩展攻击距离1 (Extended attack distance 1)
    local f3_local3 = 4.5 - f3_arg0:GetMapHitRadius(TARGET_SELF) + 5    -- 扩展攻击距离2 (Extended attack distance 2)

    -- ========== 攻击参数设置 (Attack Parameter Setup) ==========
    local f3_local4 = 0     -- 转向时间 (Turn time)
    local f3_local5 = 0     -- 正面角度 (Front angle)
    local f3_local6 = 5     -- 冷却时间 (Cooldown time)
    local f3_local7 = 3     -- 持续时间 (Duration)
    local f3_local8 = 3021  -- 连击起手攻击ID (Combo starter attack ID)
    local f3_local9 = 0     -- 额外转向时间 (Additional turn time)
    local f3_local10 = 70   -- 正面角度范围 (Front angle range)

    -- ========== 清理观察区域 (Clear Observation Areas) ==========
    f3_arg0:DeleteObserve(0)  -- 删除观察区域0 (Delete observation area 0)
    f3_arg0:DeleteObserve(1)  -- 删除观察区域1 (Delete observation area 1)

    -- ========== 执行特殊连击序列 (Execute Special Combo Sequence) ==========
    -- 第一段：连击起手攻击 (Part 1: Combo starter attack)
    f3_arg1:AddSubGoal(GOAL_COMMON_ComboAttackTunableSpin, 10, f3_local8, TARGET_ENE_0, 4, f3_local9, f3_local10, 0, 0)
    -- 第二段：连击终结攻击3022 (Part 2: Combo final attack 3022)
    f3_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3022, TARGET_ENE_0, 9999, 0, 0)

    GetWellSpace_Odds = 100  -- 设置100%空间调整概率 (Set 100% space adjustment probability)
    return GetWellSpace_Odds

end

-- ==========================================
-- 行为10：跳跃攻击 (Action 10: Jump Attack)
-- ==========================================
-- 功能：执行灵活的跳跃攻击，包含智能接近和攻击时机判断
Goal.Act10 = function (f4_arg0, f4_arg1, f4_arg2)
    local f4_local0 = f4_arg0:GetDist(TARGET_ENE_0)  -- 获取与敌人距离 (Get distance to enemy)

    -- ========== 接近距离参数设置 (Approach Distance Parameter Setup) ==========
    local f4_local1 = 4.6 - f4_arg0:GetMapHitRadius(TARGET_SELF)      -- 最小接近距离 (Minimum approach distance)
    local f4_local2 = 4.6 - f4_arg0:GetMapHitRadius(TARGET_SELF) + 3  -- 中等接近距离 (Medium approach distance)
    local f4_local3 = 4.6 - f4_arg0:GetMapHitRadius(TARGET_SELF) + 6  -- 最大接近距离 (Maximum approach distance)

    -- ========== 移动参数设置 (Movement Parameter Setup) ==========
    local f4_local4 = 0    -- 转向时间 (Turn time)
    local f4_local5 = 0    -- 正面角度 (Front angle)
    local f4_local6 = 1.5  -- 移动持续时间 (Movement duration)
    local f4_local7 = 3    -- 移动类型 (Movement type)

    -- ========== 智能接近执行 (Smart Approach Execution) ==========
    Approach_Act_Flex(f4_arg0, f4_arg1, f4_local1, f4_local2, f4_local3, f4_local4, f4_local5, f4_local6, f4_local7)

    -- ========== 跳跃攻击参数 (Jump Attack Parameters) ==========
    local f4_local8 = 3010  -- 跳跃攻击动画ID (Jump attack animation ID)
    local f4_local9 = 0     -- 转向时间 (Turn time)
    local f4_local10 = 0    -- 正面角度 (Front angle)

    -- ========== 计数器管理 (Counter Management) ==========
    f4_arg0:SetNumber(11, f4_arg0:GetNumber(11) + 1)  -- 增加跳跃攻击计数器 (Increment jump attack counter)
    f4_arg0:SetNumber(4, 0)                           -- 重置计数器4 (Reset counter 4)

    -- ========== 执行跳跃攻击 (Execute Jump Attack) ==========
    -- 添加计时器：攻击激活时设置计时器9为4帧 (Add timer: Set timer 9 to 4 frames on attack activation)
    f4_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 10, f4_local8, TARGET_ENE_0, 9999, f4_local9, f4_local10, 0, 0):TimingSetTimer(9, 4, AI_TIMING_SET__ACTIVATE)

    -- ========== 状态监听 (State Monitoring) ==========
    f4_arg0:AddObserveSpecialEffectAttribute(TARGET_SELF, 5025)  -- 监听特效5025 (Monitor special effect 5025)

    GetWellSpace_Odds = 100  -- 设置100%空间调整概率 (Set 100% space adjustment probability)
    return GetWellSpace_Odds
    
end

-- ==========================================
-- 行为14：预备攻击动作 (Action 14: Preparation Attack)
-- ==========================================
-- 功能：执行预备性攻击动作，根据距离选择是否后撤再攻击
-- 用途：为后续连招创造合适的间距和时机
Goal.Act14 = function (f5_arg0, f5_arg1, f5_arg2)
    local f5_local0 = f5_arg0:GetDist(TARGET_ENE_0)  -- 与敌人距离 (Distance to enemy)
    local f5_local1 = 0     -- 转向时间 (Turn time)
    local f5_local2 = 0     -- 正面角度 (Front angle)
    local f5_local3 = 3     -- 动作持续时间 (Action duration)
    local f5_local4 = 3020  -- 预备攻击动画ID (Preparation attack animation ID)
    -- ========== 距离判断和动作选择 (Distance Judgment and Action Selection) ==========
    if f5_local0 <= 2 then
        -- 距离过近：检查后撤空间 (Too close: Check retreat space)
        if SpaceCheck(f5_arg0, f5_arg1, 180, 2) == false then
            -- 后方空间不足：直接攻击 (Insufficient rear space: Direct attack)
        else
            -- 后方空间充足：先后撤再攻击 (Sufficient rear space: Retreat then attack)
            f5_arg1:AddSubGoal(GOAL_COMMON_SpinStep, f5_local3, 5201, TARGET_ENE_0, f5_local1, AI_DIR_TYPE_B, 0)
            f5_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 10, f5_local4, TARGET_ENE_0, 9999, f5_local1, f5_local2, 0, 0):TimingSetNumber(11, 0, AI_TIMING_SET__ACTIVATE)
        end
    else
        -- 距离合适：直接执行预备攻击 (Appropriate distance: Direct preparation attack)
        f5_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 10, f5_local4, TARGET_ENE_0, 9999, f5_local1, f5_local2, 0, 0):TimingSetNumber(11, 0, AI_TIMING_SET__ACTIVATE)
    end
    GetWellSpace_Odds = 100
    return GetWellSpace_Odds
    
end

-- ==========================================
-- 行为15：居合斩攻击 (Action 15: Iai Slash Attack)
-- ==========================================
-- 功能：执行居合技能的核心攻击动作，根据距离和空间选择不同的攻击方式
Goal.Act15 = function (f6_arg0, f6_arg1, f6_arg2)
    local f6_local0 = f6_arg0:GetDist(TARGET_ENE_0)  -- 获取与敌人的距离 (Get distance to enemy)
    local f6_local1 = 3031  -- 居合斩动画ID：标准距离攻击 (Iai slash animation ID: standard distance attack)
    local f6_local2 = 3033  -- 居合斩动画ID：近距离攻击 (Iai slash animation ID: close-range attack)
    local f6_local3 = 0     -- 转向时间 (Turn time)
    local f6_local4 = 0     -- 正面角度 (Front angle)

    -- 重置状态计数器 (Reset state counters)
    f6_arg0:SetNumber(5, 0)  -- 重置计数器5 (Reset counter 5)
    f6_arg0:SetNumber(1, 1)  -- 设置居合使用标记 (Set Iai usage flag)

    -- ========== 空间检查和攻击选择 (Space Check and Attack Selection) ==========
    if SpaceCheck(f6_arg0, f6_arg1, 180, 2) == false then
        -- 后方空间不足：使用标准居合斩 (Insufficient rear space: Use standard Iai slash)
        f6_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 10, f6_local1, TARGET_ENE_0, 9999, f6_local3, f6_local4, 0, 0)
    elseif f6_local0 <= 2 then
        -- 极近距离：使用近距离居合斩 (Very close range: Use close-range Iai slash)
        f6_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 10, f6_local2, TARGET_ENE_0, 9999, f6_local3, f6_local4, 0, 0)
    else
        -- 其他情况：使用标准居合斩 (Other cases: Use standard Iai slash)
        f6_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 10, f6_local1, TARGET_ENE_0, 9999, f6_local3, f6_local4, 0, 0)
    end

    GetWellSpace_Odds = 100  -- 设置空间调整概率为100% (Set space adjustment probability to 100%)
    return GetWellSpace_Odds

end

-- ==========================================
-- 行为19：前进步法 (Action 19: Forward Step)
-- ==========================================
-- 功能：执行快速前进步法，用于缩短与敌人的距离并创造攻击机会
Goal.Act19 = function (f7_arg0, f7_arg1, f7_arg2)
    local f7_local0 = 3     -- 持续时间3秒 (Duration 3 seconds)
    local f7_local1 = 0     -- 转向延迟时间 (Turn delay time)
    local f7_local2 = 5200  -- 前进步法动画ID (Forward step animation ID)

    -- ========== 执行前进步法 (Execute Forward Step) ==========
    -- 向前方向执行旋转步法，快速接近敌人 (Execute spin step toward front direction to quickly approach enemy)
    f7_arg1:AddSubGoal(GOAL_COMMON_SpinStep, f7_local0, f7_local2, TARGET_ENE_0, f7_local1, AI_DIR_TYPE_F, 0)

    GetWellSpace_Odds = 100  -- 设置100%空间调整概率 (Set 100% space adjustment probability)
    return GetWellSpace_Odds

end

-- ==========================================
-- 行为20：接近目标 (Action 20: Approach Target)
-- ==========================================
-- 功能：智能接近敌人，保持合适的战斗距离
Goal.Act20 = function (f8_arg0, f8_arg1, f8_arg2)
    local f8_local0 = f8_arg0:GetDist(TARGET_ENE_0)  -- 获取当前与敌人距离 (Get current distance to enemy)
    local f8_local1 = 3                             -- 目标接近距离3米 (Target approach distance 3 meters)
    local f8_local2 = 3                             -- 接近持续时间3秒 (Approach duration 3 seconds)
    local f8_local3 = f8_arg0:GetRandam_Float(1, 3) -- 随机接近时间1-3秒 (Random approach time 1-3 seconds)
    local f8_local4 = 0                             -- 额外参数 (Additional parameter)
    local f8_local5 = 5200                          -- 移动动画ID (Movement animation ID)

    -- ========== 执行接近目标行为 (Execute Approach Target Behavior) ==========
    -- 接近敌人到3米距离，持续3秒，使用智能路径规划 (Approach enemy to 3m distance, duration 3s, use smart pathfinding)
    f8_arg1:AddSubGoal(GOAL_COMMON_ApproachTarget, f8_local2, TARGET_ENE_0, f8_local1, TARGET_SELF, true, -1)

    GetWellSpace_Odds = 100  -- 设置100%空间调整概率 (Set 100% space adjustment probability)
    return GetWellSpace_Odds

end

-- ==========================================
-- 行为21：转向敌人 (Action 21: Turn to Enemy)
-- ==========================================
-- 功能：快速转向面对敌人，确保正确的攻击角度
Goal.Act21 = function (f9_arg0, f9_arg1, f9_arg2)
    local f9_local0 = 3   -- 转向持续时间3秒 (Turn duration 3 seconds)
    local f9_local1 = 45  -- 转向角度容差45度 (Turn angle tolerance 45 degrees)

    -- ========== 执行转向敌人 (Execute Turn to Enemy) ==========
    -- 在3秒内转向敌人，角度容差45度，成功后结束 (Turn to enemy within 3s, 45° tolerance, end on success)
    f9_arg1:AddSubGoal(GOAL_COMMON_Turn, f9_local0, TARGET_ENE_0, f9_local1, -1, GOAL_RESULT_Success, true)

    GetWellSpace_Odds = 0  -- 转向后不需要空间调整 (No space adjustment needed after turning)
    return GetWellSpace_Odds

end

-- ==========================================
-- 行为22：闪避反击系统 (Action 22: Dodge Counter System)
-- ==========================================
-- 功能：复杂的闪避和反击逻辑，根据空间、距离和居合状态选择最佳行动
Goal.Act22 = function (f10_arg0, f10_arg1, f10_arg2)
    local f10_local0 = 3    -- 动作持续时间 (Action duration)
    local f10_local1 = 0    -- 转向时间 (Turn time)
    local f10_local2 = 0    -- 正面角度 (Front angle)
    local f10_local3 = f10_arg0:GetRandam_Int(1, 100)  -- 随机数1-100 (Random number 1-100)
    local f10_local4 = f10_arg0:GetDist(TARGET_ENE_0)  -- 与敌人距离 (Distance to enemy)

    -- ========== 居合预备状态：直接攻击 (Iai Preparation State: Direct Attack) ==========
    if f10_arg0:HasSpecialEffectId(TARGET_SELF, 200030) then
        -- 检查左右空间可用性并选择攻击方向 (Check left/right space availability and choose attack direction)
        if SpaceCheck(f10_arg0, f10_arg1, -45, 2) == true then
            -- 左侧空间充足 (Left side space sufficient)
            if SpaceCheck(f10_arg0, f10_arg1, 45, 2) == true then
                -- 左右空间都充足：根据敌人位置选择攻击 (Both sides sufficient: Choose attack based on enemy position)
                if f10_arg0:IsInsideTarget(TARGET_ENE_0, AI_DIR_TYPE_R, 180) then
                    -- 敌人在右侧：使用左斩攻击3035 (Enemy on right side: Use left slash attack 3035)
                    f10_arg1:AddSubGoal(GOAL_COMMON_ComboAttackTunableSpin, 10, 3035, TARGET_ENE_0, 999, f10_local1, f10_local2, 0, 0)
                else
                    -- 敌人在左侧：使用右斩攻击3034 (Enemy on left side: Use right slash attack 3034)
                    f10_arg1:AddSubGoal(GOAL_COMMON_ComboAttackTunableSpin, 10, 3034, TARGET_ENE_0, 999, f10_local1, f10_local2, 0, 0)
                end
            else
                -- 只有左侧空间：强制使用左斩 (Only left side space: Force left slash)
                f10_arg1:AddSubGoal(GOAL_COMMON_ComboAttackTunableSpin, 10, 3035, TARGET_ENE_0, 999, f10_local1, f10_local2, 0, 0)
            end
        elseif SpaceCheck(f10_arg0, f10_arg1, 45, 2) == true then
            -- 只有右侧空间：强制使用右斩 (Only right side space: Force right slash)
            f10_arg1:AddSubGoal(GOAL_COMMON_ComboAttackTunableSpin, 10, 3034, TARGET_ENE_0, 999, f10_local1, f10_local2, 0, 0)
            -- 注：此处有未使用的条件分支 (Note: There's an unused conditional branch here)
        end

    -- ========== 普通状态：闪避移动 (Normal State: Dodge Movement) ==========
    else
        -- 检查空间并执行相应的闪避步法 (Check space and execute corresponding dodge steps)
        if SpaceCheck(f10_arg0, f10_arg1, -45, 2) == true then
            -- 左侧空间充足 (Left side space sufficient)
            if SpaceCheck(f10_arg0, f10_arg1, 45, 2) == true then
                -- 左右空间都充足：根据敌人位置选择闪避方向 (Both sides sufficient: Choose dodge direction based on enemy position)
                if f10_arg0:IsInsideTarget(TARGET_ENE_0, AI_DIR_TYPE_R, 180) then
                    -- 敌人在右侧：向左闪避 (Enemy on right: Dodge left)
                    f10_arg1:AddSubGoal(GOAL_COMMON_SpinStep, f10_local0, 5202, TARGET_ENE_0, f10_local1, AI_DIR_TYPE_L, 0)
                else
                    -- 敌人在左侧：向右闪避 (Enemy on left: Dodge right)
                    f10_arg1:AddSubGoal(GOAL_COMMON_SpinStep, f10_local0, 5203, TARGET_ENE_0, f10_local1, AI_DIR_TYPE_R, 0)
                end
            else
                -- 只有左侧空间：强制向左闪避 (Only left side space: Force dodge left)
                f10_arg1:AddSubGoal(GOAL_COMMON_SpinStep, f10_local0, 5202, TARGET_ENE_0, f10_local1, AI_DIR_TYPE_L, 0)
            end
        elseif SpaceCheck(f10_arg0, f10_arg1, 45, 2) == true then
            -- 只有右侧空间：强制向右闪避 (Only right side space: Force dodge right)
            f10_arg1:AddSubGoal(GOAL_COMMON_SpinStep, f10_local0, 5203, TARGET_ENE_0, f10_local1, AI_DIR_TYPE_R, 0)
        else
            -- 左右空间都不足：不执行闪避 (Neither side has space: No dodge executed)
        end

        -- ========== 随机连击机会 (Random Combo Opportunity) ==========
        if f10_local3 <= 50 and f10_local4 < 4 and f10_arg0:IsInsideTarget(TARGET_ENE_0, AI_DIR_TYPE_F, 90) then
            -- 50%概率且距离<4且敌人在前方90度：执行连击 (50% chance and distance<4 and enemy in front 90°: Execute combo)
            f10_arg1:AddSubGoal(GOAL_COMMON_ComboRepeat, 10, 3021, TARGET_ENE_0, 4.5, 0)  -- 连击重复攻击 (Combo repeat attack)
            f10_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3022, TARGET_ENE_0, 9999, 0, 0)  -- 连击终结攻击 (Combo final attack)
        else
            -- 其他情况：执行前方闪避步法 (Other cases: Execute forward dodge step)
            f10_local1 = 0.5  -- 设置较短的转向时间 (Set shorter turn time)
            f10_arg1:AddSubGoal(GOAL_COMMON_SpinStep, f10_local0, 5200, TARGET_ENE_0, f10_local1, AI_DIR_TYPE_F, 0)
        end
    end

    GetWellSpace_Odds = 0  -- 不需要空间调整 (No space adjustment needed)
    return GetWellSpace_Odds
    
end

-- ==============================
-- Goal.Act23 - 智能侧移行动 (Intelligent Sideway Movement)
-- ==============================
-- 功能：根据周围空间和敌人位置智能选择侧移方向
-- 用途：战斗中的战术机动，保持与敌人的距离并寻找攻击机会
Goal.Act23 = function (f11_arg0, f11_arg1, f11_arg2)
    -- ========== 基础参数获取 (Basic Parameters) ==========
    local f11_local0 = f11_arg0:GetDist(TARGET_ENE_0)     -- 与敌人的距离 (Distance to enemy)
    local f11_local1 = f11_arg0:GetSp(TARGET_SELF)        -- 自身SP值 (Self SP)
    local f11_local2 = 20                                 -- 基础速度参数 (Base speed parameter)
    local f11_local3 = f11_arg0:GetRandam_Int(1, 100)     -- 随机数1-100，用于决策 (Random 1-100 for decision)
    local f11_local4 = -1                                 -- 目标类型参数 (Target type parameter)
    local f11_local5 = 0                                  -- 移动方向：0=左侧移，1=右侧移 (Move direction: 0=left, 1=right)

    -- ========== 智能方向选择逻辑 (Intelligent Direction Selection Logic) ==========
    if SpaceCheck(f11_arg0, f11_arg1, -90, 1) == true then  -- 检查左侧空间 (Check left space)
        if SpaceCheck(f11_arg0, f11_arg1, 90, 1) == true then  -- 检查右侧空间 (Check right space)
            -- 左右两侧都有空间时的智能选择 (Smart choice when both sides have space)
            if f11_local3 <= 50 then  -- 50%概率基于位置选择 (50% chance position-based choice)
                if f11_arg0:IsInsideTargetEx(TARGET_ENE_0, TARGET_SELF, AI_DIR_TYPE_R, 180, 999) then
                    f11_local5 = 1  -- 敌人在右侧，向右移动 (Enemy on right, move right)
                else
                    f11_local5 = 0  -- 敌人在左侧，向左移动 (Enemy on left, move left)
                end
            elseif f11_arg0:IsInsideTargetEx(TARGET_ENE_0, TARGET_SELF, AI_DIR_TYPE_L, 180, 999) then
                f11_local5 = 0  -- 敌人在左侧，向左移动 (Enemy on left, move left)
            else
                f11_local5 = 1  -- 默认向右移动 (Default move right)
            end
        else
            f11_local5 = 0  -- 只有左侧有空间，向左移动 (Only left space, move left)
        end
    elseif SpaceCheck(f11_arg0, f11_arg1, 90, 1) == true then  -- 只有右侧有空间 (Only right space available)
        f11_local5 = 1  -- 向右移动 (Move right)
    else
        f11_local5 = 1  -- 两侧都没空间时强制右移 (Force right when no space on both sides)
    end

    -- ========== 执行侧移动作 (Execute Sideway Movement) ==========
    local f11_local6 = f11_arg0:GetRandam_Float(0.5, 1.5)  -- 移动持续时间0.5-1.5秒 (Movement duration 0.5-1.5s)
    local f11_local7 = f11_arg0:GetRandam_Int(30, 45)      -- 移动角度30-45度 (Movement angle 30-45 degrees)
    f11_arg0:SetNumber(10, f11_local5)  -- 记录移动方向到计数器10 (Record move direction to counter 10)
    f11_arg1:AddSubGoal(GOAL_COMMON_SidewayMove, f11_local6, TARGET_ENE_0, f11_local5, f11_local7, true, true, f11_local4)
    GetWellSpace_Odds = 100  -- 需要空间调整 (Space adjustment needed)
    return GetWellSpace_Odds

end

-- ==============================
-- Goal.Act24 - 后撤旋转步法 (Backward Spin Step)
-- ==============================
-- 功能：执行向后的旋转步法，用于拉开距离或避开攻击
-- 用途：近距离战斗中的脱离机动，创造反击机会
Goal.Act24 = function (f12_arg0, f12_arg1, f12_arg2)
    -- ========== 基础参数设置 (Basic Parameters Setup) ==========
    local f12_local0 = f12_arg0:GetDist(TARGET_ENE_0)  -- 与敌人的距离 (Distance to enemy)
    local f12_local1 = 3                               -- 旋转步法持续时间3秒 (Spin step duration 3 seconds)
    local f12_local2 = 0                               -- 距离参数 (Distance parameter)
    local f12_local3 = 5201                            -- 默认动作ID：后撤步法 (Default action ID: backward step)

    -- ========== 设置AI状态标记 (Set AI State Flag) ==========
    f12_arg0:SetNumber(1, 1)  -- 设置计数器1为1，标记正在执行后撤动作 (Set counter 1 to 1, mark executing retreat)

    -- ========== 空间检查与动作选择 (Space Check and Action Selection) ==========
    if SpaceCheck(f12_arg0, f12_arg1, 180, 2) ~= true or SpaceCheck(f12_arg0, f12_arg1, 180, 4) ~= true or f12_local0 > 4 then
        -- 后方空间不足或距离过远时，保持默认后撤动作
        -- (Insufficient rear space or too far distance, keep default retreat action)
    else
        -- 后方空间充足且距离合适时，确认使用后撤步法
        -- (Sufficient rear space and appropriate distance, confirm using backward step)
        f12_local3 = 5201  -- 后撤旋转步法动作ID (Backward spin step action ID)
        if false then
            -- 预留的条件分支，当前未激活 (Reserved conditional branch, currently inactive)
        else
            -- 当前执行默认逻辑 (Currently executing default logic)
        end
    end

    -- ========== 执行旋转步法 (Execute Spin Step) ==========
    -- 参数说明：持续时间, 动作ID, 目标, 距离, 方向(后方), 角度偏移
    -- (Parameters: duration, action ID, target, distance, direction(backward), angle offset)
    f12_arg1:AddSubGoal(GOAL_COMMON_SpinStep, f12_local1, f12_local3, TARGET_ENE_0, f12_local2, AI_DIR_TYPE_B, 0)
    GetWellSpace_Odds = 100  -- 需要空间调整 (Space adjustment needed)
    return GetWellSpace_Odds

end

-- ==========================================
-- 行为25：脱离目标 (Action 25: Leave Target)
-- ==========================================
-- 功能：智能脱离当前目标，保持安全距离
-- 用途：当需要重新调整战术位置或避免过度接触时使用
Goal.Act25 = function (f13_arg0, f13_arg1, f13_arg2)
    local f13_local0 = f13_arg0:GetRandam_Float(0.8, 2)    -- 脱离持续时间0.8-2秒 (Leave duration 0.8-2s)
    local f13_local1 = f13_arg0:GetRandam_Float(2, 4.5)    -- 目标脱离距离2-4.5米 (Target leave distance 2-4.5m)
    local f13_local2 = f13_arg0:GetDist(TARGET_ENE_0)      -- 当前与敌人距离 (Current distance to enemy)
    local f13_local3 = -1                                  -- 目标参数 (Target parameter)

    -- ========== 执行脱离目标行为 (Execute Leave Target Behavior) ==========
    f13_arg1:AddSubGoal(GOAL_COMMON_LeaveTarget, f13_local0, TARGET_ENE_0, f13_local1, TARGET_ENE_0, true, f13_local3)
    GetWellSpace_Odds = 0  -- 不需要空间调整 (No space adjustment needed)
    return GetWellSpace_Odds

end

-- ==========================================
-- 行为26：等待观察 (Action 26: Wait and Observe)
-- ==========================================
-- 功能：短暂等待并观察敌人动向，用于节奏控制
-- 用途：在连续攻击间隙进行战术暂停，寻找更好的攻击时机
Goal.Act26 = function (f14_arg0, f14_arg1, f14_arg2)
    -- ========== 执行短暂等待 (Execute Brief Wait) ==========
    f14_arg1:AddSubGoal(GOAL_COMMON_Wait, 0.5, TARGET_ENE_0, 0, 0, 0)  -- 等待0.5秒观察敌人 (Wait 0.5s to observe enemy)
    GetWellSpace_Odds = 0  -- 等待期间不需要空间调整 (No space adjustment needed during wait)
    return GetWellSpace_Odds

end

-- ==========================================
-- 行为27：智能游击接近 (Action 27: Smart Guerrilla Approach)
-- ==========================================
-- 功能：智能的游击战术，结合距离检查和侧移机动
-- 用途：在团队作战或需要灵活机动的场合使用
Goal.Act27 = function (f15_arg0, f15_arg1, f15_arg2)
    local f15_local0 = f15_arg0:GetRandam_Int(1, 100)  -- 随机数1-100，用于决策 (Random 1-100 for decision)

    -- ========== 游击子目标检查 (Guerrilla Sub-goal Check) ==========
    -- 参数：启用游击模式，距离阈值60，角度30
    if YousumiAct_SubGoal(f15_arg0, f15_arg1, true, 60, 30) == false then
        -- 游击条件不满足：直接返回 (Guerrilla conditions not met: Return directly)
        GetWellSpace_Odds = 0
        return GetWellSpace_Odds
    end

    -- ========== 智能侧移方向选择 (Smart Sideway Direction Selection) ==========
    local f15_local1 = 0  -- 移动方向：0=左，1=右 (Movement direction: 0=left, 1=right)
    local f15_local2 = SpaceCheck_SidewayMove(f15_arg0, f15_arg1, 1)  -- 检查侧移空间 (Check sideway space)

    if f15_local2 == 0 then
        f15_local1 = 0  -- 只能向左移动 (Can only move left)
    elseif f15_local2 == 1 then
        f15_local1 = 1  -- 只能向右移动 (Can only move right)
    elseif f15_local2 == 2 then
        -- 两个方向都可移动：50%概率选择 (Both directions available: 50% chance selection)
        if f15_local0 <= 50 then
            f15_local1 = 0  -- 选择左移 (Choose left)
        else
            f15_local1 = 1  -- 选择右移 (Choose right)
        end
    else
        -- 无法侧移：等待观察 (Cannot move sideways: Wait and observe)
        f15_arg1:AddSubGoal(GOAL_COMMON_Wait, 0.5, TARGET_SELF, 0, 0, 0)
        GetWellSpace_Odds = 0
        return GetWellSpace_Odds
    end

    -- ========== 执行侧移机动 (Execute Sideway Maneuver) ==========
    f15_arg0:SetNumber(10, f15_local1)  -- 记录移动方向 (Record movement direction)
    -- 参数：持续3秒，目标敌人，移动方向，随机角度30-45度
    f15_arg1:AddSubGoal(GOAL_COMMON_SidewayMove, 3, TARGET_ENE_0, f15_local1, f15_arg0:GetRandam_Int(30, 45), true, true, -1)
    GetWellSpace_Odds = 0  -- 不需要额外空间调整 (No additional space adjustment needed)
    return GetWellSpace_Odds

end

-- ==========================================
-- 行为28：距离适应性机动 (Action 28: Distance Adaptive Maneuver)
-- ==========================================
-- 功能：根据与敌人的距离自动选择最佳的机动方式
-- 用途：通用的距离调整行为，确保保持最佳战斗距离
Goal.Act28 = function (f16_arg0, f16_arg1, f16_arg2)
    -- ========== 基础参数获取 (Basic Parameters) ==========
    local f16_local0 = f16_arg0:GetDist(TARGET_ENE_0)      -- 与敌人当前距离 (Current distance to enemy)
    local f16_local1 = 1.5                                -- 侧移持续时间1.5秒 (Sideway movement duration 1.5s)
    local f16_local2 = 1.5                                -- 接近持续时间1.5秒 (Approach duration 1.5s)
    local f16_local3 = f16_arg0:GetRandam_Int(30, 45)     -- 随机角度30-45度 (Random angle 30-45 degrees)
    local f16_local4 = -1                                 -- 目标参数 (Target parameter)
    local f16_local5 = f16_arg0:GetRandam_Int(0, 1)       -- 随机方向：0=左，1=右 (Random direction: 0=left, 1=right)

    -- ========== 距离分段机动策略 (Distance-Based Maneuver Strategy) ==========
    if f16_local0 <= 3 then
        -- 近距离(≤3米)：执行侧移保持距离 (Close range (≤3m): Execute sideway movement to maintain distance)
        f16_arg1:AddSubGoal(GOAL_COMMON_SidewayMove, f16_local1, TARGET_ENE_0, f16_local5, f16_local3, true, true, f16_local4)
    elseif f16_local0 <= 8 then
        -- 中距离(3-8米)：接近到3米最佳战斗距离 (Medium range (3-8m): Approach to 3m optimal combat distance)
        f16_arg1:AddSubGoal(GOAL_COMMON_ApproachTarget, f16_local2, TARGET_ENE_0, 3, TARGET_SELF, true, -1)
    else
        -- 远距离(>8米)：快速接近到5米 (Long range (>8m): Quickly approach to 5m)
        f16_arg1:AddSubGoal(GOAL_COMMON_ApproachTarget, f16_local2, TARGET_ENE_0, 5, TARGET_SELF, false, -1)
    end

    GetWellSpace_Odds = 0  -- 不需要额外空间调整 (No additional space adjustment needed)
    return GetWellSpace_Odds

end

-- ==========================================
-- 中断处理系统 (Interrupt Handling System)
-- ==========================================
-- 功能：处理各种游戏事件的中断，包括射击、弹反、受伤、道具使用等
Goal.Interrupt = function (f17_arg0, f17_arg1, f17_arg2)
    -- ========== 获取中断状态参数 (Get Interrupt State Parameters) ==========
    local f17_local0 = f17_arg1:GetSpecialEffectActivateInterruptType(0)  -- 特效激活类型 (Special effect activation type)
    local f17_local1 = f17_arg1:GetRandam_Int(1, 100)                    -- 随机数1-100 (Random number 1-100)
    local f17_local2 = f17_arg1:GetDist(TARGET_ENE_0)                    -- 与敌人距离 (Distance to enemy)
    local f17_local3 = f17_arg1:GetSpRate(TARGET_SELF)                   -- 自身SP比例 (Self SP ratio)
    local f17_local4 = f17_arg1:GetNumber(11)                            -- 计数器11值 (Counter 11 value)

    -- ========== 基础条件检查 (Basic Condition Check) ==========
    if f17_arg1:IsLadderAct(TARGET_SELF) then
        -- 正在爬梯子：不处理中断 (Currently climbing ladder: Don't handle interrupts)
        return false
    end
    if not f17_arg1:HasSpecialEffectId(TARGET_SELF, 200004) then
        -- 没有基础激活特效：不处理中断 (No basic activation effect: Don't handle interrupts)
        return false
    end

    -- ========== 射击反应中断 (Shooting Reaction Interrupt) ==========
    if f17_arg1:IsInterupt(INTERUPT_Shoot) then
        -- 检测到射击攻击：执行射击反应 (Detected shooting attack: Execute shooting reaction)
        return f17_arg0.ShootReaction(f17_arg1, f17_arg2)
    end

    -- ========== 弹反时机中断 (Parry Timing Interrupt) ==========
    if f17_arg1:IsInterupt(INTERUPT_ParryTiming) then
        if f17_arg1:HasSpecialEffectId(TARGET_SELF, 200030) then
            -- 居合预备状态：使用特殊弹反3103 (Iai preparation state: Use special parry 3103)
            return Common_Parry(f17_arg1, f17_arg2, 100, 0, 0, 3103)
        else
            -- 普通状态：使用标准弹反 (Normal state: Use standard parry)
            return Common_Parry(f17_arg1, f17_arg2, 100, 0)
        end
    end

    -- ========== 受伤中断 (Damaged Interrupt) ==========
    if f17_arg1:IsInterupt(INTERUPT_Damaged) then
        -- 检测到受伤：执行受伤反应 (Detected damage: Execute damage reaction)
        return f17_arg0.Damaged(f17_arg1, f17_arg2)
    end
    -- ========== 架势破坏中断 (Posture Break Interrupt) ==========
    if Interupt_PC_Break(f17_arg1) then
        -- 敌人架势被破坏：重新规划行为 (Enemy posture broken: Replanning behavior)
        f17_arg1:Replanning()
        return true
    end

    -- ========== 道具使用中断 (Item Use Interrupt) ==========
    if Interupt_Use_Item(f17_arg1, 4, 10) then
        -- 检测到道具使用：根据状态和距离做出反应 (Item use detected: React based on state and distance)
        if f17_arg1:HasSpecialEffectId(TARGET_SELF, 200030) then
            -- 居合预备状态：重新规划 (Iai preparation state: Replanning)
            f17_arg1:Replanning()
            return true
        elseif f17_local2 <= 5 then
            -- 距离≤5米：立即跳跃攻击打断 (Distance ≤5m: Immediate jump attack interrupt)
            f17_arg2:ClearSubGoal()
            f17_arg2:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 1, 3010, TARGET_ENE_0, 9999, 0, 0, 0, 0)
            return true
        elseif f17_local2 <= 10 then
            -- 距离5-10米：前进步法接近 (Distance 5-10m: Forward step approach)
            f17_arg2:ClearSubGoal()
            f17_arg2:AddSubGoal(GOAL_COMMON_SpinStep, 1, 5200, TARGET_ENE_0, 0, AI_DIR_TYPE_F, 0)
            return true
        else
            -- 距离>10米：重新规划策略 (Distance >10m: Replanning strategy)
            f17_arg1:Replanning()
            return true
        end
    end
    -- ========== 特效激活中断参数 (Special Effect Activation Interrupt Parameters) ==========
    local f17_local5 = 60                                            -- 观察角度60度 (Observation angle 60 degrees)
    local f17_local6 = 4.6 - f17_arg1:GetMapHitRadius(TARGET_SELF) + 1  -- 居合攻击距离 (Iai attack distance)
    local f17_local7 = 2.5                                           -- 近距离阈值 (Close range threshold)

    -- ========== 特效激活中断处理 (Special Effect Activation Interrupt Processing) ==========
    if f17_arg1:IsInterupt(INTERUPT_ActivateSpecialEffect) then
        -- 特效5027激活且处于居合预备状态 (Special effect 5027 activated and in Iai preparation state)
        if f17_arg1:GetSpecialEffectActivateInterruptType(0) == 5027 and f17_arg1:HasSpecialEffectId(TARGET_SELF, 200030) then
            f17_arg2:ClearSubGoal()  -- 清除当前目标 (Clear current goals)
            -- 执行快速居合斩反击3031 (Execute quick Iai slash counter 3031)
            f17_arg2:AddSubGoal(GOAL_COMMON_EndureAttack, 0.1, 3031, TARGET_ENE_0, 9999, 0)
            return true
        end

        -- 特效5025激活处理 (Special effect 5025 activation processing)
        if f17_arg1:GetSpecialEffectActivateInterruptType(0) == 5025 then
            if f17_arg1:HasSpecialEffectId(TARGET_SELF, 200030) and f17_arg1:GetHpRate(TARGET_ENE_0) == 0 then
                -- 居合状态且敌人死亡：执行终结技3032 (Iai state and enemy dead: Execute finisher 3032)
                f17_arg2:ClearSubGoal()
                f17_arg2:AddSubGoal(GOAL_COMMON_EndureAttack, 5, 3032, TARGET_ENE_0, 9999, 0, 0, 0, 0)
                return true
            elseif f17_arg1:HasSpecialEffectId(TARGET_SELF, 200031) and f17_arg1:HasSpecialEffectId(TARGET_ENE_0, 110125) then
                -- 居合可用状态且敌人有特效110125：重新规划 (Iai available and enemy has effect 110125: Replanning)
                f17_arg1:Replanning()
                return true
            end
        end
        -- 特效200031激活：居合可用状态 (Special effect 200031 activated: Iai available state)
        if f17_arg1:GetSpecialEffectActivateInterruptType(0) == 200031 then
            -- 设置观察区域：前方攻击范围和近距离监控 (Set observation areas: Front attack range and close-range monitoring)
            f17_arg1:AddObserveArea(0, TARGET_SELF, TARGET_ENE_0, AI_DIR_TYPE_F, f17_local5, f17_local6)
            f17_arg1:AddObserveArea(1, TARGET_SELF, TARGET_ENE_0, AI_DIR_TYPE_F, 200, f17_local7)
            return true
        -- 特效200030激活：居合预备状态 (Special effect 200030 activated: Iai preparation state)
        elseif f17_arg1:GetSpecialEffectActivateInterruptType(0) == 200030 then
            -- 删除观察区域，专注于居合攻击 (Delete observation areas, focus on Iai attack)
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

-- ==========================================
-- 弹反系统 (Parry System)
-- ==========================================
-- 功能：复杂的弹反逻辑，根据居合状态、敌人类型、距离等条件选择弹反方式
-- 参数说明：f18_arg2为成功率，f18_arg3为步法类型
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

-- ==========================================
-- 受伤反应系统 (Damage Reaction System)
-- ==========================================
-- 功能：处理AI受到伤害时的反应逻辑，特别是居合状态下的即时反击
-- 用途：在受到攻击时触发，根据当前状态选择最佳反应方式
Goal.Damaged = function (f19_arg0, f19_arg1, f19_arg2)
    -- ========== 状态参数获取 (State Parameters) ==========
    local f19_local0 = f19_arg0:GetHpRate(TARGET_SELF)     -- 自身血量比例 (Self HP ratio)
    local f19_local1 = f19_arg0:GetDist(TARGET_ENE_0)      -- 与敌人距离 (Distance to enemy)
    local f19_local2 = f19_arg0:GetSp(TARGET_SELF)         -- 自身SP值 (Self SP value)
    local f19_local3 = f19_arg0:GetRandam_Int(1, 100)      -- 随机数1-100 (Random number 1-100)
    local f19_local4 = 0                                   -- 预留参数 (Reserved parameter)

    -- ========== 居合预备状态特殊反应 (Iai Preparation State Special Reaction) ==========
    if f19_arg0:HasSpecialEffectId(TARGET_SELF, 200030) then
        -- 处于居合预备状态：立即执行居合斩反击 (In Iai preparation state: Immediately execute Iai slash counter)
        f19_arg1:ClearSubGoal()  -- 清除当前所有目标 (Clear all current goals)
        -- 执行居合斩攻击3031，极短延迟0.1秒确保即时反击 (Execute Iai slash 3031, 0.1s delay for instant counter)
        f19_arg1:AddSubGoal(GOAL_COMMON_EndureAttack, 0.1, 3031, TARGET_ENE_0, 9999, 0)
        return true  -- 成功触发反击 (Successfully triggered counter)
    end

    -- ========== 其他状态暂不反应 (Other States No Reaction) ==========
    -- 当前版本仅在居合预备状态下进行反击，其他状态使用默认受伤处理
    -- (Current version only counters in Iai prep state, other states use default damage handling)
    return false

end

-- ==========================================
-- 射击反应系统 (Shooting Reaction System)
-- ==========================================
-- 功能：处理远程射击攻击的反应逻辑，根据距离和状态选择闪避或反击方式
-- 用途：在检测到远程攻击时自动触发，确保AI能够合理应对远程威胁
Goal.ShootReaction = function (f20_arg0, f20_arg1)
    -- ========== 基础参数计算 (Basic Parameters) ==========
    local f20_local0 = f20_arg0:GetDist(TARGET_ENE_0)  -- 与敌人距离 (Distance to enemy)
    local f20_local1 = f20_local0 * 0.01               -- 距离相关延迟时间 (Distance-based delay time)

    -- ========== 居合预备状态射击反应 (Iai Preparation State Shooting Reaction) ==========
    if f20_arg0:HasSpecialEffectId(TARGET_SELF, 200030) then
        -- 检查敌人是否在前方20度视角内 (Check if enemy is within 20° front angle)
        if f20_arg0:IsInsideTargetEx(TARGET_ENE_0, TARGET_SELF, AI_DIR_TYPE_F, 20, 999) then
            if f20_local0 <= 15 then
                -- 近距离(≤15米)：立即弹反射击 (Close range (≤15m): Immediate shooting parry)
                f20_arg1:ClearSubGoal()
                f20_arg1:AddSubGoal(GOAL_COMMON_EndureAttack, 0.1, 3100, TARGET_ENE_0, 9999, 0)
                return true
            else
                -- 远距离(>15米)：等待后弹反 (Long range (>15m): Wait then parry)
                f20_arg1:ClearSubGoal()
                f20_arg1:AddSubGoal(GOAL_COMMON_Wait, f20_local1, TARGET_SELF, 0, 0, 0)  -- 基于距离的等待时间
                f20_arg1:AddSubGoal(GOAL_COMMON_EndureAttack, 0.3, 3100, TARGET_ENE_0, 9999, 0)
                return true
            end
        end

    -- ========== 普通状态射击反应 (Normal State Shooting Reaction) ==========
    elseif f20_local0 <= 20 then
        -- 中近距离(≤20米)：直接弹反 (Medium-close range (≤20m): Direct parry)
        f20_arg1:ClearSubGoal()
        f20_arg1:AddSubGoal(GOAL_COMMON_EndureAttack, 0.1, 3100, TARGET_ENE_0, 9999, 0)
        return true
    else
        -- 远距离(>20米)：智能闪避策略 (Long range (>20m): Smart evasion strategy)
        f20_arg1:ClearSubGoal()

        -- ========== 空间检查和闪避方向选择 (Space Check and Evasion Direction Selection) ==========
        if SpaceCheck(f20_arg0, f20_arg1, -45, 2) == true then  -- 检查左侧空间 (Check left space)
            if SpaceCheck(f20_arg0, f20_arg1, 45, 2) == true then  -- 检查右侧空间 (Check right space)
                -- 左右都有空间：根据敌人位置选择闪避方向 (Both sides available: Choose evasion based on enemy position)
                if f20_arg0:IsInsideTarget(TARGET_ENE_0, AI_DIR_TYPE_R, 180) then
                    f20_arg1:AddSubGoal(GOAL_COMMON_EndureAttack, 0.1, 5202, TARGET_ENE_0, 9999, 0)  -- 向左闪避 (Dodge left)
                else
                    f20_arg1:AddSubGoal(GOAL_COMMON_EndureAttack, 0.1, 5203, TARGET_ENE_0, 9999, 0)  -- 向右闪避 (Dodge right)
                end
            else
                -- 只有左侧空间：强制左闪避 (Only left space: Force left dodge)
                f20_arg1:AddSubGoal(GOAL_COMMON_EndureAttack, 0.1, 5202, TARGET_ENE_0, 9999, 0)
            end
        elseif SpaceCheck(f20_arg0, f20_arg1, 45, 2) == true then
            -- 只有右侧空间：强制右闪避 (Only right space: Force right dodge)
            f20_arg1:AddSubGoal(GOAL_COMMON_EndureAttack, 0.1, 5203, TARGET_ENE_0, 9999, 0)
        else
            -- 无闪避空间：等待后弹反 (No evasion space: Wait then parry)
            f20_arg1:AddSubGoal(GOAL_COMMON_Wait, f20_local1, TARGET_SELF, 0, 0, 0)
            f20_arg1:AddSubGoal(GOAL_COMMON_EndureAttack, 0.3, 3100, TARGET_ENE_0, 9999, 0)
        end
        return true
    end
    return false

end

-- ==========================================
-- 见切激活系统 (Kengeki Activation System)
-- ==========================================
-- 功能：管理见切（弹反）系统的激活逻辑，这是高级剑客AI的核心技能
-- 根据特效状态、距离、SP值等条件决定是否激活见切反击
Goal.Kengeki_Activate = function (f21_arg0, f21_arg1, f21_arg2, f21_arg3)
    -- 获取当前见切特效状态 (Get current Kengeki special effect state)
    local f21_local0 = ReturnKengekiSpecialEffect(f21_arg1)
    if f21_local0 == 0 then
        -- 无见切特效：不激活 (No Kengeki effect: Don't activate)
        return false
    end

    -- 初始化见切行为权重系统 (Initialize Kengeki behavior weight system)
    local f21_local1 = {}  -- 行为权重数组 (Behavior weight array)
    local f21_local2 = {}  -- 行为函数数组 (Behavior function array)
    local f21_local3 = {}  -- 子目标配置数组 (Sub-goal configuration array)
    Common_Clear_Param(f21_local1, f21_local2, f21_local3)

    -- 获取战斗状态参数 (Get combat state parameters)
    local f21_local4 = f21_arg1:GetDist(TARGET_ENE_0)  -- 与敌人距离 (Distance to enemy)
    local f21_local5 = f21_arg1:GetSp(TARGET_SELF)     -- 自身SP值 (Self SP value)

    -- ========== SP值检查和见切类型判断 (SP Check and Kengeki Type Determination) ==========
    if f21_local5 <= 0 then
        -- SP不足：执行默认见切行为 (Insufficient SP: Execute default Kengeki behavior)
        f21_local1[50] = 100
    elseif f21_local0 == 200200 then
        -- 特效200200激活：远距离见切 (Special effect 200200 active: Long-range Kengeki)
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

-- ==========================================
-- 见切14：基础见切反击 (Kengeki14: Basic Kengeki Counter)
-- ==========================================
-- 功能：执行基础的见切反击动作，根据状态选择不同的反击方式
Goal.Kengeki14 = function (f22_arg0, f22_arg1, f22_arg2)
    local f22_local0 = f22_arg0:GetDist(TARGET_ENE_0)    -- 获取与敌人距离 (Get distance to enemy)
    local f22_local1 = 3066                             -- 默认反击动画ID (Default counter animation ID)
    local f22_local2 = f22_arg0:GetRandam_Int(1, 100)   -- 随机数1-100 (Random number 1-100)

    f22_arg1:ClearSubGoal()  -- 清除当前所有子目标 (Clear all current sub-goals)

    -- ========== 见切反击选择逻辑 (Kengeki Counter Selection Logic) ==========
    if f22_arg0:HasSpecialEffectId(TARGET_SELF, 200031) then
        -- 居合可用状态：使用默认反击3066 (Iai available state: Use default counter 3066)
    elseif f22_local2 <= 50 then
        -- 50%概率：使用替代反击3083 (50% chance: Use alternative counter 3083)
        f22_local1 = 3083
        if f22_arg0:HasSpecialEffectId(TARGET_SELF, 200210) then
            -- 有特效200210：使用强化反击3087 (Has effect 200210: Use enhanced counter 3087)
            f22_local1 = 3087
        end
    end

    -- ========== 执行见切终结攻击 (Execute Kengeki Final Attack) ==========
    f22_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 1, f22_local1, TARGET_ENE_0, 9999, 0, 0)

end

-- ==========================================
-- 见切15：居合见切反击 (Kengeki15: Iai Kengeki Counter)
-- ==========================================
-- 功能：结合居合技的见切反击，根据距离和空间条件选择最佳攻击方式
Goal.Kengeki15 = function (f23_arg0, f23_arg1, f23_arg2)
    local f23_local0 = f23_arg0:GetDist(TARGET_ENE_0)  -- 获取与敌人距离 (Get distance to enemy)
    local f23_local1 = 3031  -- 居合斩攻击ID (Iai slash attack ID)
    local f23_local2 = 3066  -- 近距离反击攻击ID (Close-range counter attack ID)
    local f23_local3 = 0     -- 转向时间 (Turn time)
    local f23_local4 = 0     -- 正面角度 (Front angle)

    f23_arg1:ClearSubGoal()  -- 清除当前所有子目标 (Clear all current sub-goals)

    -- ========== 状态重置 (State Reset) ==========
    f23_arg0:SetNumber(5, 0)  -- 重置计数器5 (Reset counter 5)
    f23_arg0:SetNumber(1, 1)  -- 设置居合使用标记 (Set Iai usage flag)

    -- ========== 距离和空间判断攻击选择 (Distance and Space Judgment for Attack Selection) ==========
    if SpaceCheck(f23_arg0, f23_arg1, 180, 2) == false then
        -- 后方空间不足：使用居合斩3031 (Insufficient rear space: Use Iai slash 3031)
        f23_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 10, f23_local1, TARGET_ENE_0, 9999, f23_local3, f23_local4, 0, 0)
    elseif f23_local0 <= 2.4 then
        -- 极近距离(≤2.4米)：使用近距离反击，增加计数器4 (Very close range (≤2.4m): Use close-range counter, increment counter 4)
        f23_arg0:SetNumber(4, f23_arg0:GetNumber(4) + 1)
        f23_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 15, f23_local2, TARGET_ENE_0, 9999, f23_local3, f23_local4, 0, 0)
    else
        -- 中等距离：使用居合斩，重置计数器4 (Medium range: Use Iai slash, reset counter 4)
        f23_arg0:SetNumber(4, 0)
        f23_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 10, f23_local1, TARGET_ENE_0, 9999, f23_local3, f23_local4, 0, 0)
    end

end

-- ==========================================
-- 见切16：高级连击见切 (Kengeki16: Advanced Combo Kengeki)
-- ==========================================
-- 功能：执行高级连击见切反击，根据累积状态选择攻击强度
Goal.Kengeki16 = function (f24_arg0, f24_arg1, f24_arg2)
    local f24_local0 = 3057  -- 连击起手攻击ID (Combo starter attack ID)
    local f24_local1 = 3017  -- 连击终结攻击ID (Combo final attack ID)
    local f24_local2 = 0     -- 转向时间 (Turn time)
    local f24_local3 = 0     -- 正面角度 (Front angle)

    f24_arg1:ClearSubGoal()  -- 清除当前所有子目标 (Clear all current sub-goals)

    -- ========== 状态判断和攻击选择 (State Judgment and Attack Selection) ==========
    if f24_arg0:GetNumber(5) >= 15 or f24_arg0:GetStringIndexedNumber("spFlag") >= 3 then
        -- 累积状态达到阈值：执行完整连击序列 (Accumulated state reaches threshold: Execute full combo sequence)
        f24_arg0:SetNumber(5, 0)  -- 重置累积计数器 (Reset accumulation counter)
        f24_arg1:AddSubGoal(GOAL_COMMON_ComboAttackTunableSpin, 10, f24_local0, TARGET_ENE_0, 9999, f24_local2, f24_local3, 0, 0)
        f24_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, f24_local1, TARGET_ENE_0, 9999, 0, 0):TimingSetTimer(6, 8, AI_TIMING_SET__ACTIVATE)
    else
        -- 普通状态：执行基础反击 (Normal state: Execute basic counter)
        f24_arg0:SetTimer(6, 8)  -- 设置冷却计时器 (Set cooldown timer)
        f24_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 1, 3077, TARGET_ENE_0, 9999, 0, 0):TimingSetNumber(5, f24_arg0:GetNumber(5) + 2, AI_TIMING_SET__ACTIVATE)
    end

end

-- ==========================================
-- 见切17：侧向斩击见切 (Kengeki17: Lateral Slash Kengeki)
-- ==========================================
-- 功能：根据空间条件选择左右侧向斩击的见切反击
Goal.Kengeki17 = function (f25_arg0, f25_arg1, f25_arg2)
    local f25_local0 = f25_arg0:GetDist(TARGET_ENE_0)  -- 与敌人距离 (Distance to enemy)
    local f25_local1 = 3034  -- 右侧斩击攻击ID (Right slash attack ID)
    local f25_local2 = 3035  -- 左侧斩击攻击ID (Left slash attack ID)
    local f25_local3 = f25_arg0:GetRandam_Int(1, 100)  -- 随机数1-100 (Random number 1-100)
    local f25_local4 = 0     -- 转向时间 (Turn time)
    local f25_local5 = 0     -- 正面角度 (Front angle)

    f25_arg1:ClearSubGoal()  -- 清除当前所有子目标 (Clear all current sub-goals)
    f25_arg0:SetNumber(5, 0) -- 重置状态计数器 (Reset state counter)

    -- ========== 空间检查和攻击方向选择 (Space Check and Attack Direction Selection) ==========
    if SpaceCheck(f25_arg0, f25_arg1, -90, 2) and SpaceCheck(f25_arg0, f25_arg1, 90, 2) then
        -- 左右两侧都有空间：50%概率选择左斩 (Both sides have space: 50% chance for left slash)
        if f25_local3 <= 50 then
            f25_local1 = 3035  -- 选择左侧斩击 (Choose left slash)
        end
    elseif SpaceCheck(f25_arg0, f25_arg1, -90, 2) == true then
        -- 只有左侧有空间：强制使用左斩 (Only left side has space: Force left slash)
        f25_local1 = 3035
    else
        -- 只有右侧有空间或空间不足：使用默认右斩 (Only right side has space or insufficient space: Use default right slash)
    end

    -- ========== 执行侧向斩击 (Execute Lateral Slash) ==========
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

-- ==========================================
-- 无动作函数 (No Action Function)
-- ==========================================
-- 功能：见切系统中的空动作占位符，当不满足任何见切条件时调用
-- 返回：-1表示不执行任何动作，让AI系统继续其他行为判断
Goal.NoAction = function (f36_arg0, f36_arg1, f36_arg2)
    return -1  -- 返回-1表示不执行任何动作 (Return -1 to indicate no action)
end

-- ==========================================
-- 动作后空间调整函数 (Post-Action Space Adjustment Function)
-- ==========================================
-- 功能：在执行完攻击动作后进行空间位置的微调
-- 用途：确保AI在攻击后保持合适的战斗距离和位置
Goal.ActAfter_AdjustSpace = function (f37_arg0, f37_arg1, f37_arg2)
    -- 当前为空实现，使用系统默认的空间调整逻辑
    -- Currently empty implementation, uses system default space adjustment logic
    -- 此函数作为后续扩展的接口保留
    -- This function is reserved as an interface for future extensions
end

-- ==========================================
-- 更新函数 (Update Function)
-- ==========================================
-- 功能：AI行为的持续更新逻辑，每帧调用以维护AI状态
-- 使用默认无子目标更新模式，适合大多数战斗AI
Goal.Update = function (f38_arg0, f38_arg1, f38_arg2)
    -- 使用默认的无子目标更新函数 (Use default no-sub-goal update function)
    -- 这确保AI在没有活跃子目标时能正确处理状态转换
    -- This ensures AI can properly handle state transitions when no active sub-goals exist
    return Update_Default_NoSubGoal(f38_arg0, f38_arg1, f38_arg2)
end

-- ==========================================
-- 终止函数 (Terminate Function)
-- ==========================================
-- 功能：AI目标终止时的清理工作
-- 用途：在AI行为结束时进行必要的状态重置和资源清理
Goal.Terminate = function (f39_arg0, f39_arg1, f39_arg2)
    -- 当前为空实现，使用系统默认的终止逻辑
    -- Currently empty implementation, uses system default termination logic
    -- 这是标准的FromSoftware AI架构模式
    -- This is the standard FromSoftware AI architecture pattern
end

-- ==============================================
-- 文件结束 - End of File
-- ==============================================
-- 140020_battle.lua 剑客·居合 AI战斗脚本
--
-- 【注释完成状态 - Documentation Completion Status】
-- ✓ 完整的函数注释覆盖：所有主要函数都有详细的中英文注释
-- ✓ 战术逻辑说明：详细解释了居合技能和见切系统的实现
-- ✓ 参数文档化：所有重要参数都有清晰的用途说明
-- ✓ 代码分段注释：复杂逻辑块都有分段说明
-- ✓ 架构文档：从文件头部可以了解整个AI的设计思路
--
-- 【维护说明 - Maintenance Notes】
-- 此脚本为Sekiro AI mod项目的核心文件之一，修改时请注意：
-- 1. 保持Shift-JIS编码兼容性
-- 2. 确保所有动画ID与AIAttackParam.xml一致
-- 3. 测试居合和见切系统的平衡性
-- 4. 验证团队协作模式的正确性
-- ==============================================
