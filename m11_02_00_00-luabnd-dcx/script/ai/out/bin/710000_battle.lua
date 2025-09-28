-- ================================================
-- 710000_battle.lua - 劲敌BOSS战斗AI (Rival Boss Battle AI)
-- 角色：剑圣/忍者大师级BOSS (Character: Kensei/Master Ninja Boss)
-- 特点：超高复杂度AI，23个自定义ACT，113次共享函数调用
-- Features: Ultra-complex AI with 23 custom ACTs and 113 shared function calls
-- ================================================

RegisterTableGoal(GOAL_Rival_710000_Battle, "GOAL_Rival_710000_Battle")  -- 注册劲敌710000战斗目标 (Register Rival 710000 battle goal)
REGISTER_GOAL_NO_UPDATE(GOAL_Rival_710000_Battle, true)                    -- 禁用Update函数以提升性能 (Disable update function for performance)

-- 初始化函数 - 目标创建时调用 (Initialize function - called when goal is created)
Goal.Initialize = function (f1_arg0, f1_arg1, f1_arg2, f1_arg3)
    -- 劲敌BOSS无需特殊初始化 (Rival Boss requires no special initialization)
end

-- 激活函数 - 劲敌BOSS的核心战斗逻辑调度器 (Activate function - Core battle logic dispatcher for Rival Boss)
Goal.Activate = function (f2_arg0, f2_arg1, f2_arg2)
    Init_Pseudo_Global(f2_arg1, f2_arg2)                              -- 初始化伪全局变量 (Initialize pseudo-global variables)
    local f2_local0 = {}                                              -- 行为权重数组 (Behavior weight array)
    local f2_local1 = {}                                              -- 行为函数数组 (Behavior function array)
    local f2_local2 = {}                                              -- 子目标数组 (Sub-goal array)
    Common_Clear_Param(f2_local0, f2_local1, f2_local2)              -- 清理参数数组，初始化50个行为槽位 (Clear parameter arrays, initialize 50 behavior slots)
    -- 获取战斗状态信息 (Get battle status information)
    local f2_local3 = f2_arg1:GetDist(TARGET_ENE_0)                   -- 与玩家的距离 (Distance to player)
    local f2_local4 = f2_arg1:GetExcelParam(AI_EXCEL_THINK_PARAM_TYPE__thinkAttr_doAdmirer)  -- 崇拜者思考属性 (Admirer think attribute)
    local f2_local5 = f2_arg1:GetHpRate(TARGET_SELF)                  -- 自身血量百分比 (Self HP percentage)
    local f2_local6 = f2_arg1:GetSp(TARGET_SELF)                      -- 自身SP值（体力/架势） (Self SP value - stamina/posture)
    local f2_local7 = f2_arg1:GetNinsatsuNum()                        -- 忍杀数量 (Ninsatsu count)
    -- 观察特殊效果 - 监控关键状态变化 (Observe special effects - Monitor key status changes)
    f2_arg1:AddObserveSpecialEffectAttribute(TARGET_SELF, 5025)        -- 观察自身特效5025 (Observe self effect 5025)
    f2_arg1:AddObserveSpecialEffectAttribute(TARGET_SELF, 5026)        -- 观察自身特效5026 (Observe self effect 5026)
    f2_arg1:AddObserveSpecialEffectAttribute(TARGET_SELF, 5029)        -- 观察自身特效5029 (Observe self effect 5029)
    f2_arg1:AddObserveSpecialEffectAttribute(TARGET_SELF, 5030)        -- 观察自身特效5030 (Observe self effect 5030)
    f2_arg1:AddObserveSpecialEffectAttribute(TARGET_SELF, 5031)        -- 观察自身特效5031 (Observe self effect 5031)
    f2_arg1:AddObserveSpecialEffectAttribute(TARGET_SELF, 3710010)     -- 观察BOSS专属特效3710010 (Observe boss-specific effect 3710010)
    f2_arg1:AddObserveSpecialEffectAttribute(TARGET_SELF, 3710020)     -- 观察BOSS专属特效3710020 (Observe boss-specific effect 3710020)
    f2_arg1:AddObserveSpecialEffectAttribute(TARGET_SELF, 3710030)     -- 观察BOSS专属特效3710030 (Observe boss-specific effect 3710030)
    f2_arg1:AddObserveSpecialEffectAttribute(TARGET_SELF, 3710031)     -- 观察BOSS专属特效3710031 (Observe boss-specific effect 3710031)
    f2_arg1:AddObserveSpecialEffectAttribute(TARGET_ENE_0, 110010)     -- 观察玩家潜行状态 (Observe player stealth state)
    f2_arg1:AddObserveSpecialEffectAttribute(TARGET_ENE_0, 3710050)    -- 观察玩家特定效果 (Observe player specific effect)
    f2_arg1:AddObserveSpecialEffectAttribute(TARGET_ENE_0, 110620)     -- 观察玩家特效110620 (Observe player effect 110620)
    Set_ConsecutiveGuardCount_Interrupt(f2_arg1)                       -- 设置连续防守计数中断 (Set consecutive guard count interrupt)
    f2_arg1:DeleteObserve(0)                                           -- 删除观察槽0 (Delete observe slot 0)
    -- 剑击特殊激活检查 - 优先处理剑击技能 (Sword strike special activation check - Priority handle sword strikes)
    if f2_arg0.Kengeki_Activate(f2_arg0, f2_arg1, f2_arg2) then
        return  -- 如果剑击激活成功则直接返回 (Return directly if sword strike activation succeeds)
    end
    -- ========== 主要战斗逻辑决策树 (Main Battle Logic Decision Tree) ==========
    -- 情况1：玩家处于潜行或特殊状态 (Case 1: Player in stealth or special state)
    if f2_arg1:HasSpecialEffectId(TARGET_ENE_0, 110060) or f2_arg1:HasSpecialEffectId(TARGET_ENE_0, 110010) then
        if f2_arg1:IsInsideTarget(TARGET_ENE_0, AI_DIR_TYPE_F, 90) then
            f2_local0[21] = 1    -- 低权重Act21（主动攻击） (Low weight Act21 - Active attack)
            f2_local0[28] = 100  -- 高权重Act28（特殊反击） (High weight Act28 - Special counter)
        else
            f2_local0[21] = 100  -- 高权重Act21（追击潜行者） (High weight Act21 - Chase stealth target)
        end
    -- 情况2：检查通用特殊行为激活 (Case 2: Check common special action activation)
    elseif Common_ActivateAct(f2_arg1, f2_arg2, 0, 1) then
        -- 通用行为已激活，无需设置权重 (Common action activated, no weight setting needed)
    -- 情况3：初次进入战斗且具有特殊状态 (Case 3: First battle entry with special state)
    elseif f2_arg1:GetNumber(7) == 0 and f2_arg1:HasSpecialEffectId(TARGET_SELF, 200050) then
        f2_local0[15] = 600  -- 非常高权重Act15（初始化攻击） (Very high weight Act15 - Initialization attack)
    -- 情况4：玩家处于特殊状态110030 (Case 4: Player in special state 110030)
    elseif f2_arg1:HasSpecialEffectId(TARGET_ENE_0, 110030) then
        f2_local0[28] = 100  -- 高权重Act28（针对性反击） (High weight Act28 - Targeted counter)
    -- 情况5：玩家在背后 (Case 5: Player is behind)
    elseif f2_arg1:IsInsideTarget(TARGET_ENE_0, AI_DIR_TYPE_B, 180) then
        f2_local0[21] = 100  -- 高权重Act21（转身政击） (High weight Act21 - Turn and attack)
        f2_local0[22] = 1    -- 低权重Act22（辅助动作） (Low weight Act22 - Support action)
    -- 情况6：玩家再次进入潜行或特殊状态 (Case 6: Player re-enters stealth or special state)
    elseif f2_arg1:HasSpecialEffectId(TARGET_ENE_0, 110060) or f2_arg1:HasSpecialEffectId(TARGET_ENE_0, 110010) then
        f2_local0[27] = 100  -- 高权重Act27（反潜行策略） (High weight Act27 - Anti-stealth strategy)
    -- ========== 距离分层战斗策略 (Distance-Based Combat Strategy) ==========
    -- 远距离战斗 (≥7米) - Long Range Combat (≥7m)
    elseif f2_local3 >= 7 then
        f2_local0[10] = 300  -- 高权重Act10（远程冲刺） (High weight Act10 - Long-range charge)
        f2_local0[15] = 600  -- 非常高权重Act15（远程特殊攻击） (Very high weight Act15 - Long-range special attack)
    -- 中远距离战斗 (5-7米) - Medium-Long Range Combat (5-7m)
    elseif f2_local3 >= 5 then
        f2_local0[10] = 300  -- 高权重Act10（中远程冲刺） (High weight Act10 - Medium-range charge)
        f2_local0[34] = 100  -- 中等权重Act34（特殊技能） (Medium weight Act34 - Special skill)
        f2_local0[23] = 100  -- 中等权重Act23（侧移攻击） (Medium weight Act23 - Side movement attack)
        if f2_local6 <= 360 then                                      -- SP值较低时使用能量技能 (Use energy skill when SP is low)
            f2_local0[9] = 300  -- 高权重Act09（能量回复/爆发攻击） (High weight Act09 - Energy recovery/burst attack)
        end
    -- 中距离战斗 (3-5米) - Medium Range Combat (3-5m)
    elseif f2_local3 > 3 then
        f2_local0[1] = 5     -- 低权重Act01（基础连击） (Low weight Act01 - Basic combo)
        f2_local0[2] = 10    -- 低权重Act02（单次攻击） (Low weight Act02 - Single attack)
        f2_local0[6] = 30    -- 中等权重Act06（中距离特攻） (Medium weight Act06 - Medium range special)
        f2_local0[11] = 15   -- 低权重Act11（连击终结） (Low weight Act11 - Combo finisher)
        f2_local0[23] = 15   -- 低权重Act23（侧移攻击） (Low weight Act23 - Side movement attack)
        if f2_local6 <= 360 then                                      -- SP低时加强攻击性 (Increase aggression when SP is low)
            f2_local0[9] = 300  -- 高权重Act09（爆发攻击） (High weight Act09 - Burst attack)
        end
    -- 近距离战斗 (≤3米) - Close Range Combat (≤3m)
    else
        f2_local0[3] = 15    -- 低权重Act03（近距离快攻） (Low weight Act03 - Close range quick attack)
        f2_local0[11] = 15   -- 低权重Act11（连击终结） (Low weight Act11 - Combo finisher)
        f2_local0[23] = 10   -- 低权重Act23（侧移攻击） (Low weight Act23 - Side movement attack)
        f2_local0[31] = 30   -- 中等权重Act31（近距离特殊技） (Medium weight Act31 - Close range special)
        if f2_arg1:IsFinishTimer(7) == true then                       -- 计时7结束后可使用后撤攻击 (After timer 7 ends, retreat attack available)
            f2_local0[24] = 30  -- 中等权重Act24（后撤攻击） (Medium weight Act24 - Retreat attack)
        end
    end
    -- ========== 特殊条件判断 (Special Condition Checks) ==========
    -- 玩家具有特定状态且距离较近时的反制策略 (Counter strategy when player has specific state and is close)
    if (f2_arg1:HasSpecialEffectId(TARGET_ENE_0, 109031) or f2_arg1:HasSpecialEffectId(TARGET_ENE_0, 110125)) and f2_local3 <= 5 then
        f2_local0[16] = 100  -- 高权重Act16（反制技能） (High weight Act16 - Counter skill)
    end
    -- 玩家处于特殊无敌状态109900时的策略调整 (Strategy adjustment when player is in special invincible state 109900)
    if f2_arg1:HasSpecialEffectId(TARGET_ENE_0, 109900) then
        f2_local0[1] = 5     -- 降低Act01权重（基础连击） (Lower Act01 weight - Basic combo)
        f2_local0[2] = 5     -- 降低Act02权重（单次攻击） (Lower Act02 weight - Single attack)
        f2_local0[3] = 5     -- 降低Act03权重（快攻） (Lower Act03 weight - Quick attack)
        f2_local0[9] = 0     -- 禁用Act09（爆发攻击） (Disable Act09 - Burst attack)
        f2_local0[11] = 5    -- 降低Act11权重（连击终结） (Lower Act11 weight - Combo finisher)
        f2_local0[10] = 30   -- 提高Act10权重（保守性攻击） (Increase Act10 weight - Defensive attack)
        f2_local0[15] = 0    -- 禁用Act15（特殊攻击） (Disable Act15 - Special attack)
        f2_local0[31] = 0    -- 禁用Act31（近距离特殊技） (Disable Act31 - Close range special)
        f2_local0[48] = 30   -- 提高Act48权重（特殊对策） (Increase Act48 weight - Special countermeasure)
    end
    -- 特殊触发条件：数字2为1时的爆发模式 (Special trigger condition: Burst mode when number 2 is 1)
    if f2_arg1:GetNumber(2) == 1 then
        f2_local0[23] = 6000  -- 极高权重Act23（爆发侧移攻击） (Extremely high weight Act23 - Burst side attack)
        f2_arg1:SetNumber(2, 0)  -- 重置数字2以避免永久爆发 (Reset number 2 to avoid permanent burst)
    end
    -- ========== 计时器控制的冷却系统 (Timer-Controlled Cooldown System) ==========
    -- 计时器0控制的技能冷却 (Timer 0 controlled skill cooldown)
    if f2_arg1:IsFinishTimer(0) == false then
        f2_local0[3] = 0     -- 禁用Act03（快攻冷却中） (Disable Act03 - Quick attack on cooldown)
        f2_local0[6] = 1     -- 低权重Act06（替代选择） (Low weight Act06 - Alternative choice)
    end
    -- 计时器1控制的技能冷却 (Timer 1 controlled skill cooldown)
    if f2_arg1:IsFinishTimer(1) == false then
        f2_local0[2] = 0     -- 禁用Act02（单次攻击冷却中） (Disable Act02 - Single attack on cooldown)
    end
    -- 计时器3控制的后撤技能冷却 (Timer 3 controlled retreat skill cooldown)
    if f2_arg1:IsFinishTimer(3) == false then
        f2_local0[24] = 0    -- 禁用Act24（后撤攻击冷却中） (Disable Act24 - Retreat attack on cooldown)
    end
    -- 计时器6控制的爆发技能冷却 (Timer 6 controlled burst skill cooldown)
    if f2_arg1:IsFinishTimer(6) == false then
        f2_local0[9] = 0     -- 禁用Act09（爆发攻击冷却中） (Disable Act09 - Burst attack on cooldown)
    end
    -- BOSS特殊状态200051时的能力限制 (Ability restrictions when BOSS has special state 200051)
    if f2_arg1:HasSpecialEffectId(TARGET_SELF, 200051) then
        f2_local0[15] = 0    -- 禁用Act15（特殊攻击限制） (Disable Act15 - Special attack restricted)
        f2_local0[18] = 0    -- 禁用Act18（能量攻击限制） (Disable Act18 - Energy attack restricted)
        f2_local0[19] = 0    -- 禁用Act19（连续技限制） (Disable Act19 - Continuous skill restricted)
        f2_local0[34] = 0    -- 禁用Act34（特殊技能限制） (Disable Act34 - Special skill restricted)
        f2_local0[48] = 0    -- 禁用Act48（对策技能限制） (Disable Act48 - Counter skill restricted)
    end
    -- ========== 空间检查系统 (Space Check System) ==========
    -- 检查左右斜后方空间（±45°，2米）(Check diagonal rear space (±45°, 2m))
    if SpaceCheck(f2_arg1, f2_arg2, 45, 2) == false and SpaceCheck(f2_arg1, f2_arg2, -45, 2) == false then
        f2_local0[22] = 0    -- 禁用Act22（斜后移动攻击） (Disable Act22 - Diagonal rear movement attack)
    end
    -- 检查左右侧方空间（±90°，1米）(Check left/right side space (±90°, 1m))
    if SpaceCheck(f2_arg1, f2_arg2, 90, 1) == false and SpaceCheck(f2_arg1, f2_arg2, -90, 1) == false then
        f2_local0[23] = 0    -- 禁用Act23（侧移攻击） (Disable Act23 - Side movement attack)
    end
    -- 检查后方空间（180°，2米）(Check rear space (180°, 2m))
    if SpaceCheck(f2_arg1, f2_arg2, 180, 2) == false then
        f2_local0[24] = 0    -- 禁用Act24（后撤攻击） (Disable Act24 - Retreat attack)
    end
    -- 检查后方近距空间（180°，1米）(Check rear close space (180°, 1m))
    if SpaceCheck(f2_arg1, f2_arg2, 180, 1) == false then
        f2_local0[25] = 0    -- 禁用Act25（后撤短攻击） (Disable Act25 - Retreat short attack)
    end
    -- 玩家具有特殊效果110621时的策略调整 (Strategy adjustment when player has special effect 110621)
    if f2_arg1:HasSpecialEffectId(TARGET_ENE_0, 110621) then
        f2_local0[23] = 0    -- 禁用Act23（侧移攻击） (Disable Act23 - Side movement attack)
        f2_local0[24] = 0    -- 禁用Act24（后撤攻击） (Disable Act24 - Retreat attack)
        f2_local0[31] = 10   -- 低权重Act31（替代攻击） (Low weight Act31 - Alternative attack)
    end
    -- ========== 行为冷却时间管理系统 (Behavior Cooldown Management System) ==========
    -- 为每个攻击行为设置冷却时间，防止连续重复使用 (Set cooldown for each attack behavior to prevent continuous repetition)
    f2_local0[1] = SetCoolTime(f2_arg1, f2_arg2, 3000, 15, f2_local0[1], 1)   -- Act01: 基础连击冷却5秒 (Basic combo 15s cooldown)
    f2_local0[2] = SetCoolTime(f2_arg1, f2_arg2, 3004, 15, f2_local0[2], 1)   -- Act02: 单次攻击冷却15秒 (Single attack 15s cooldown)
    f2_local0[3] = SetCoolTime(f2_arg1, f2_arg2, 3005, 15, f2_local0[3], 1)   -- Act03: 快速攻击冷却15秒 (Quick attack 15s cooldown)
    f2_local0[4] = SetCoolTime(f2_arg1, f2_arg2, 3006, 15, f2_local0[4], 1)   -- Act04: 特殊攻击冷却15秒 (Special attack 15s cooldown)
    f2_local0[5] = SetCoolTime(f2_arg1, f2_arg2, 3007, 15, f2_local0[5], 1)   -- Act05: 远程攻击冷却15秒 (Long-range attack 15s cooldown)
    f2_local0[6] = SetCoolTime(f2_arg1, f2_arg2, 3016, 15, f2_local0[6], 1)   -- Act06: 中距攻击冷却15秒 (Medium-range attack 15s cooldown)
    f2_local0[7] = SetCoolTime(f2_arg1, f2_arg2, 3020, 15, f2_local0[7], 1)   -- Act07: 终结技冷却15秒 (Finisher skill 15s cooldown)
    f2_local0[8] = SetCoolTime(f2_arg1, f2_arg2, 3021, 15, f2_local0[8], 1)   -- Act08: 连续技冷却15秒 (Continuous skill 15s cooldown)
    f2_local0[9] = SetCoolTime(f2_arg1, f2_arg2, 3092, 15, f2_local0[9], 1)   -- Act09: 爆发技能冷却15秒 (Burst skill 15s cooldown)
    f2_local0[10] = SetCoolTime(f2_arg1, f2_arg2, 3006, 15, f2_local0[10], 1) -- Act10: 冲刺攻击冷却15秒 (Charge attack 15s cooldown)
    f2_local0[11] = SetCoolTime(f2_arg1, f2_arg2, 3037, 15, f2_local0[11], 1) -- Act11: 连击终结冷却15秒 (Combo finisher 15s cooldown)
    f2_local0[13] = SetCoolTime(f2_arg1, f2_arg2, 3011, 15, f2_local0[13], 1) -- Act13: 特殊技能冷却15秒 (Special skill 15s cooldown)
    f2_local0[14] = SetCoolTime(f2_arg1, f2_arg2, 3014, 15, f2_local0[14], 1) -- Act14: 高级攻击冷却15秒 (Advanced attack 15s cooldown)
    f2_local0[15] = SetCoolTime(f2_arg1, f2_arg2, 3014, 15, f2_local0[15], 1) -- Act15: 初始攻击冷却15秒 (Initial attack 15s cooldown)
    f2_local0[18] = SetCoolTime(f2_arg1, f2_arg2, 3040, 15, f2_local0[18], 1) -- Act18: 能量攻击冷却15秒 (Energy attack 15s cooldown)
    f2_local0[30] = SetCoolTime(f2_arg1, f2_arg2, 3006, 15, f2_local0[30], 1) -- Act30: 特殊攻击冷却15秒 (Special attack 15s cooldown)
    f2_local0[31] = SetCoolTime(f2_arg1, f2_arg2, 3045, 15, f2_local0[31], 1) -- Act31: 近距特殊冷却15秒 (Close-range special 15s cooldown)
    f2_local0[32] = SetCoolTime(f2_arg1, f2_arg2, 3006, 15, f2_local0[32], 1) -- Act32: 特殊攻击冷却15秒 (Special attack 15s cooldown)
    f2_local0[34] = SetCoolTime(f2_arg1, f2_arg2, 3007, 15, f2_local0[34], 1) -- Act34: 特殊技能冷却15秒 (Special skill 15s cooldown)
    f2_local0[38] = SetCoolTime(f2_arg1, f2_arg2, 3006, 15, f2_local0[38], 1) -- Act38: 特殊攻击冷却15秒 (Special attack 15s cooldown)
    f2_local0[48] = SetCoolTime(f2_arg1, f2_arg2, 3013, 5, f2_local0[48], 1)  -- Act48: 对策技能冷却5秒 (Counter skill 5s cooldown)
    -- ========== 行为函数注册系统 (Behavior Function Registration System) ==========
    -- 将所有行为函数注册到数组中，供权重系统调用 (Register all behavior functions to array for weight system to call)
    f2_local1[1] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act01)   -- 注册基础连击 (Register basic combo)
    f2_local1[2] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act02)   -- 注册单次攻击 (Register single attack)
    f2_local1[3] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act03)   -- 注册快速攻击 (Register quick attack)
    f2_local1[5] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act05)   -- 注册远程攻击 (Register long-range attack)
    f2_local1[6] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act06)   -- 注册中距攻击 (Register medium-range attack)
    f2_local1[7] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act07)   -- 注册终结技能 (Register finisher skill)
    f2_local1[8] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act08)   -- 注册连续技能 (Register continuous skill)
    f2_local1[9] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act09)   -- 注册爆发技能 (Register burst skill)
    f2_local1[10] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act10)  -- 注册冲刺攻击 (Register charge attack)
    f2_local1[11] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act11)  -- 注册连击终结 (Register combo finisher)
    f2_local1[15] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act15)  -- 注册初始攻击 (Register initial attack)
    f2_local1[16] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act16)  -- 注册反制技能 (Register counter skill)
    f2_local1[18] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act18)  -- 注册能量攻击 (Register energy attack)
    f2_local1[19] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act19)  -- 注册连续技能 (Register continuous skill)
    f2_local1[20] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act20)  -- 注册高级技能 (Register advanced skill)
    f2_local1[21] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act21)  -- 注册主动攻击 (Register active attack)
    f2_local1[22] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act22)  -- 注册斜后攻击 (Register diagonal attack)
    f2_local1[23] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act23)  -- 注册侧移攻击 (Register side attack)
    f2_local1[24] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act24)  -- 注册后撤攻击 (Register retreat attack)
    f2_local1[25] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act25)  -- 注册后撤短攻 (Register retreat short attack)
    f2_local1[26] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act26)  -- 注册特殊攻击 (Register special attack)
    f2_local1[27] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act27)  -- 注册反潜行攻击 (Register anti-stealth attack)
    f2_local1[28] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act28)  -- 注册特殊反击 (Register special counter)
    f2_local1[30] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act30)  -- 注册特殊攻击 (Register special attack)
    f2_local1[31] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act31)  -- 注册近距特殊 (Register close-range special)
    f2_local1[34] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act34)  -- 注册特殊技能 (Register special skill)
    f2_local1[40] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act40)  -- 注册高级攻击 (Register advanced attack)
    f2_local1[41] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act41)  -- 注册高级技能 (Register advanced skill)
    f2_local1[42] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act42)  -- 注册高级攻击 (Register advanced attack)
    f2_local1[45] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act45)  -- 注册特殊技能 (Register special skill)
    f2_local1[46] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act46)  -- 注册特殊攻击 (Register special attack)
    f2_local1[47] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act47)  -- 注册特殊技能 (Register special skill)
    f2_local1[48] = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.Act48)  -- 注册对策技能 (Register counter skill)
    -- 注册攻击后空间调整函数 (Register post-attack space adjustment function)
    local f2_local8 = REGIST_FUNC(f2_arg1, f2_arg2, f2_arg0.ActAfter_AdjustSpace)

    -- ========== 最终调度系统 (Final Dispatch System) ==========
    -- 调用通用战斗激活器，根据权重选择并执行对应的行为函数 (Call common battle activator to select and execute corresponding behavior function based on weights)
    Common_Battle_Activate(f2_arg1, f2_arg2, f2_local0, f2_local1, f2_local8, f2_local2)

end

-- ========== ACT01: 基础连击攻击 (ACT01: Basic Combo Attack) ==========
-- 功能：执行基础的连击攻击，包含多种连击路线 (Function: Execute basic combo attack with multiple combo routes)
-- 特点：适用于3-5米距离，随机选择不同连击路线 (Features: Suitable for 3-5m distance, randomly choose different combo routes)
Goal.Act01 = function (f3_arg0, f3_arg1, f3_arg2)
    -- 计算接近距离参数（考虑角色体型）(Calculate approach distance parameters considering character size)
    local f3_local0 = 3.6 - f3_arg0:GetMapHitRadius(TARGET_SELF)        -- 最佳攻击距离 (Optimal attack distance)
    local f3_local1 = 3.6 - f3_arg0:GetMapHitRadius(TARGET_SELF) + 2    -- 中等距离范围 (Medium distance range)
    local f3_local2 = 3.6 - f3_arg0:GetMapHitRadius(TARGET_SELF) + 3    -- 最大距离范围 (Maximum distance range)
    local f3_local3 = 100                                               -- 接近权重 (Approach weight)
    local f3_local4 = 0                                                 -- 方向偏移 (Direction offset)
    local f3_local5 = 2.5                                               -- 移动速度倍率 (Movement speed multiplier)
    local f3_local6 = 3                                                 -- 转身速度 (Turn speed)

    local f3_local7 = f3_arg0:GetRandam_Int(1, 100)                     -- 随机数，决定连击路线 (Random number determining combo route)

    -- 执行灵活接近，移动到适合攻击的距离 (Execute flexible approach, move to suitable attack distance)
    Approach_Act_Flex(f3_arg0, f3_arg1, f3_local0, f3_local1, f3_local2, f3_local3, f3_local4, f3_local5, f3_local6)

    -- 计算连击成功距离（每次攻击的有效范围）(Calculate combo success distances - effective range for each attack)
    local f3_local8 = 3.5 - f3_arg0:GetMapHitRadius(TARGET_SELF)        -- 第一击成功距离 (First hit success distance)
    local f3_local9 = 3.4 - f3_arg0:GetMapHitRadius(TARGET_SELF)        -- 第二击成功距离 (Second hit success distance)
    local f3_local10 = 3.4 - f3_arg0:GetMapHitRadius(TARGET_SELF)       -- 第三击成功距离 (Third hit success distance)
    local f3_local11 = 0                                                -- 上攻击角度 (Upper attack angle)
    local f3_local12 = 0                                                -- 下攻击角度 (Lower attack angle)

    -- 根据随机数选择连击路线 (Choose combo route based on random number)
    if f3_local7 <= 30 then  -- 30%概率选择路线1 (30% chance for route 1)
        -- 连击路线1：3000→3001→3002→3003 (Combo route 1: 3000→3001→3002→3003)
        f3_arg1:AddSubGoal(GOAL_COMMON_ComboAttackTunableSpin, 10, 3000, TARGET_ENE_0, f3_local8, f3_local11, f3_local12, 0, 0)  -- 连击起手 (Combo starter)
        f3_arg1:AddSubGoal(GOAL_COMMON_ComboRepeat, 10, 3001, TARGET_ENE_0, f3_local9, 0)   -- 连击中段 (Combo middle)
        f3_arg1:AddSubGoal(GOAL_COMMON_ComboRepeat, 10, 3002, TARGET_ENE_0, f3_local10, 0)  -- 连击中段 (Combo middle)
        f3_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3003, TARGET_ENE_0, 9999, 0, 0)      -- 连击终结 (Combo finisher)
    else  -- 70%概率选择路线2 (70% chance for route 2)
        -- 连击路线2：3000→3001→3010→3025 (Combo route 2: 3000→3001→3010→3025)
        f3_arg1:AddSubGoal(GOAL_COMMON_ComboAttackTunableSpin, 10, 3000, TARGET_ENE_0, f3_local8, f3_local11, f3_local12, 0, 0)  -- 连击起手 (Combo starter)
        f3_arg1:AddSubGoal(GOAL_COMMON_ComboRepeat, 10, 3001, TARGET_ENE_0, 3.5, 0)         -- 连击中段 (Combo middle)
        f3_arg1:AddSubGoal(GOAL_COMMON_ComboRepeat, 10, 3010, TARGET_ENE_0, 5, 0)           -- 连击中段（更长距离）(Combo middle - longer range)
        f3_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3025, TARGET_ENE_0, 9999, 0, 0)      -- 连击终结 (Combo finisher)
    end

    GetWellSpace_Odds = 100  -- 设置空间优化概率 (Set space optimization probability)
    return GetWellSpace_Odds

end

-- ========== ACT02: 单次强力攻击 (ACT02: Single Power Attack) ==========
-- 功能：执行单次的强力攻击，适合快速击中敌人 (Function: Execute single power attack, suitable for quick enemy hits)
-- 特点：较短攻击距离，但伤害集中 (Features: Shorter attack distance but concentrated damage)
Goal.Act02 = function (f4_arg0, f4_arg1, f4_arg2)
    -- 计算接近距离参数 (Calculate approach distance parameters)
    local f4_local0 = 3.2 - f4_arg0:GetMapHitRadius(TARGET_SELF)        -- 最佳攻击距离 (Optimal attack distance)
    local f4_local1 = 3.2 - f4_arg0:GetMapHitRadius(TARGET_SELF) + 2    -- 中等距离范围 (Medium distance range)
    local f4_local2 = 3.2 - f4_arg0:GetMapHitRadius(TARGET_SELF) + 3    -- 最大距离范围 (Maximum distance range)
    local f4_local3 = 100                                               -- 接近权重 (Approach weight)
    local f4_local4 = 0                                                 -- 方向偏移 (Direction offset)
    local f4_local5 = 2.5                                               -- 移动速度倍率 (Movement speed multiplier)
    local f4_local6 = 3                                                 -- 转身速度 (Turn speed)

    -- 执行灵活接近 (Execute flexible approach)
    Approach_Act_Flex(f4_arg0, f4_arg1, f4_local0, f4_local1, f4_local2, f4_local3, f4_local4, f4_local5, f4_local6)

    local f4_local7 = 0                                                 -- 上攻击角度 (Upper attack angle)
    local f4_local8 = 0                                                 -- 下攻击角度 (Lower attack angle)

    -- 执行单次强力攻击（动画3004）(Execute single power attack - animation 3004)
    f4_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 10, 3004, TARGET_ENE_0, 9999, f4_local7, f4_local8, 0, 0)

    GetWellSpace_Odds = 100  -- 设置空间优化概率 (Set space optimization probability)
    return GetWellSpace_Odds

end

-- ========== ACT03: 近距离快速攻击 (ACT03: Close-Range Quick Attack) ==========
-- 功能：执行近距离的快速攻击，带有后方观察区域 (Function: Execute close-range quick attack with rear observation area)
-- 特点：最短攻击距离，攻击后设置后方监控区域 (Features: Shortest attack distance, sets rear monitoring area after attack)
Goal.Act03 = function (f5_arg0, f5_arg1, f5_arg2)
    -- 计算接近距离参数（非常近的距离）(Calculate approach distance parameters - very close distance)
    local f5_local0 = 2.2 - f5_arg0:GetMapHitRadius(TARGET_SELF)        -- 最佳攻击距离 (Optimal attack distance)
    local f5_local1 = 2.2 - f5_arg0:GetMapHitRadius(TARGET_SELF) + 0.3  -- 微调距离范围 (Fine-tuned distance range)
    local f5_local2 = 2.2 - f5_arg0:GetMapHitRadius(TARGET_SELF) + 2    -- 最大距离范围 (Maximum distance range)
    local f5_local3 = 0                                                 -- 接近权重（不强制接近）(Approach weight - no forced approach)
    local f5_local4 = 0                                                 -- 方向偏移 (Direction offset)
    local f5_local5 = 1.5                                               -- 较低的移动速度 (Lower movement speed)
    local f5_local6 = 3                                                 -- 转身速度 (Turn speed)

    -- 执行灵活接近 (Execute flexible approach)
    Approach_Act_Flex(f5_arg0, f5_arg1, f5_local0, f5_local1, f5_local2, f5_local3, f5_local4, f5_local5, f5_local6)

    local f5_local7 = 0                                                 -- 上攻击角度 (Upper attack angle)
    local f5_local8 = 0                                                 -- 下攻击角度 (Lower attack angle)
    local f5_local9 = 180                                               -- 观察角度（后方180°）(Observation angle - rear 180°)
    local f5_local10 = 3                                                -- 观察距离 (Observation distance)

    -- 在攻击前设置后方观察区域，监控玩家是否绕到背后 (Set rear observation area before attack to monitor if player circles behind)
    f5_arg0:AddObserveArea(0, TARGET_SELF, TARGET_ENE_0, AI_DIR_TYPE_B, f5_local9, f5_local10)

    -- 执行快速攻击（动画3005）(Execute quick attack - animation 3005)
    f5_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 10, 3005, TARGET_ENE_0, 9999, f5_local7, f5_local8, 0, 0)

    -- 设置计时器0为7秒，防止过频使用此攻击 (Set timer 0 to 7 seconds to prevent overuse of this attack)
    f5_arg0:SetTimer(0, 7)

    GetWellSpace_Odds = 100  -- 设置空间优化概率 (Set space optimization probability)
    return GetWellSpace_Odds

end

-- ========== ACT05: 中远程强力攻击 (ACT05: Medium-Long Range Power Attack) ==========
-- 功能：执行中远程的强力单次攻击，适用于5.9米距离 (Function: Execute medium-long range power single attack, suitable for 5.9m distance)
-- 特点：统一攻击距离，标准移动速度，攻击动画3007 (Features: Unified attack distance, standard movement speed, attack animation 3007)
Goal.Act05 = function (f6_arg0, f6_arg1, f6_arg2)
    -- 计算中远程攻击距离参数 (Calculate medium-long range attack distance parameters)
    local f6_local0 = 5.9 - f6_arg0:GetMapHitRadius(TARGET_SELF)        -- 最佳攻击距离 (Optimal attack distance)
    local f6_local1 = 5.9 - f6_arg0:GetMapHitRadius(TARGET_SELF)        -- 中等距离范围 (Medium distance range)
    local f6_local2 = 5.9 - f6_arg0:GetMapHitRadius(TARGET_SELF)        -- 最大距离范围 (Maximum distance range)
    local f6_local3 = 100                                               -- 接近权重 (Approach weight)
    local f6_local4 = 0                                                 -- 方向偏移 (Direction offset)
    local f6_local5 = 2.5                                               -- 标准移动速度倍率 (Standard movement speed multiplier)
    local f6_local6 = 3                                                 -- 转身速度 (Turn speed)

    -- 执行灵活接近 (Execute flexible approach)
    Approach_Act_Flex(f6_arg0, f6_arg1, f6_local0, f6_local1, f6_local2, f6_local3, f6_local4, f6_local5, f6_local6)

    local f6_local7 = 0                                                 -- 上攻击角度 (Upper attack angle)
    local f6_local8 = 0                                                 -- 下攻击角度 (Lower attack angle)

    -- 执行中远程强力攻击（动画3007）(Execute medium-long range power attack - animation 3007)
    f6_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 10, 3007, TARGET_ENE_0, 9999, f6_local7, f6_local8, 0, 0)

    GetWellSpace_Odds = 100  -- 设置空间优化概率 (Set space optimization probability)
    return GetWellSpace_Odds

end

-- ========== ACT06: 中距离特殊攻击 (ACT06: Medium Range Special Attack) ==========
-- 功能：执行中距离的特殊攻击，带有5秒冷却时间 (Function: Execute medium range special attack with 5-second cooldown)
-- 特点：较慢接近速度，设置计时器0防止频繁使用 (Features: Slower approach speed, sets timer 0 to prevent frequent use)
Goal.Act06 = function (f7_arg0, f7_arg1, f7_arg2)
    -- 计算中距离攻击距离参数 (Calculate medium range attack distance parameters)
    local f7_local0 = 5.2 - f7_arg0:GetMapHitRadius(TARGET_SELF)        -- 最佳攻击距离 (Optimal attack distance)
    local f7_local1 = 5.2 - f7_arg0:GetMapHitRadius(TARGET_SELF) + 2    -- 中等距离范围 (Medium distance range)
    local f7_local2 = 5.2 - f7_arg0:GetMapHitRadius(TARGET_SELF) + 3    -- 最大距离范围 (Maximum distance range)
    local f7_local3 = 100                                               -- 接近权重 (Approach weight)
    local f7_local4 = 0                                                 -- 方向偏移 (Direction offset)
    local f7_local5 = 1.5                                               -- 较慢的移动速度 (Slower movement speed)
    local f7_local6 = 3                                                 -- 转身速度 (Turn speed)

    -- 执行灵活接近 (Execute flexible approach)
    Approach_Act_Flex(f7_arg0, f7_arg1, f7_local0, f7_local1, f7_local2, f7_local3, f7_local4, f7_local5, f7_local6)

    local f7_local7 = 0                                                 -- 上攻击角度 (Upper attack angle)
    local f7_local8 = 0                                                 -- 下攻击角度 (Lower attack angle)

    -- 执行中距离特殊攻击（动画3016）(Execute medium range special attack - animation 3016)
    f7_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 10, 3016, TARGET_ENE_0, 9999, f7_local7, f7_local8, 0, 0)

    -- 设置计时器0为5秒，防止过频使用此攻击 (Set timer 0 to 5 seconds to prevent overuse of this attack)
    f7_arg0:SetTimer(0, 5)

    GetWellSpace_Odds = 100  -- 设置空间优化概率 (Set space optimization probability)
    return GetWellSpace_Odds

end

-- ========== ACT09: 能量爆发连击 (ACT09: Energy Burst Combo) ==========
-- 功能：执行能量爆发双段连击，消耗大量SP时的高威力技能 (Function: Execute energy burst two-stage combo, high power skill when consuming large SP)
-- 特点：30秒长冷却，3040→3041连击序列，SP≤360时高权重 (Features: 30-second long cooldown, 3040→3041 combo sequence, high weight when SP≤360)
Goal.Act09 = function (f8_arg0, f8_arg1, f8_arg2)
    -- 计算中距离攻击距离参数 (Calculate medium range attack distance parameters)
    local f8_local0 = 4.5 - f8_arg0:GetMapHitRadius(TARGET_SELF)        -- 最佳攻击距离 (Optimal attack distance)
    local f8_local1 = 4.5 - f8_arg0:GetMapHitRadius(TARGET_SELF)        -- 中等距离范围 (Medium distance range)
    local f8_local2 = 4.5 - f8_arg0:GetMapHitRadius(TARGET_SELF)        -- 最大距离范围 (Maximum distance range)
    local f8_local3 = 100                                               -- 接近权重 (Approach weight)
    local f8_local4 = 0                                                 -- 方向偏移 (Direction offset)
    local f8_local5 = 1.5                                               -- 较慢的移动速度 (Slower movement speed)
    local f8_local6 = 3                                                 -- 转身速度 (Turn speed)

    -- 执行灵活接近 (Execute flexible approach)
    Approach_Act_Flex(f8_arg0, f8_arg1, f8_local0, f8_local1, f8_local2, f8_local3, f8_local4, f8_local5, f8_local6)

    local f8_local7 = 0                                                 -- 上攻击角度 (Upper attack angle)
    local f8_local8 = 0                                                 -- 下攻击角度 (Lower attack angle)

    -- 执行能量爆发连击序列 (Execute energy burst combo sequence)
    f8_arg1:AddSubGoal(GOAL_COMMON_ComboAttackTunableSpin, 10, 3040, TARGET_ENE_0, 4, f8_local7, f8_local8, 0, 0)  -- 爆发攻击起手（动画3040）(Burst attack starter - animation 3040)
    f8_arg1:AddSubGoal(GOAL_COMMON_ComboRepeat, 10, 3041, TARGET_ENE_0, 3.5, 0)                                    -- 爆发攻击后续（动画3041）(Burst attack follow-up - animation 3041)

    -- 设置计时器6为30秒，防止能量爆发技能被滥用 (Set timer 6 to 30 seconds to prevent energy burst skill abuse)
    f8_arg0:SetTimer(6, 30)

    GetWellSpace_Odds = 100  -- 设置空间优化概率 (Set space optimization probability)
    return GetWellSpace_Odds

end

-- ========== ACT10: 中距离冲刺攻击 (ACT10: Medium Range Charge Attack) ==========
-- 功能：执行中距离的冲刺攻击，适用于远距离和中远距离的接近战术 (Function: Execute medium range charge attack, suitable for long and medium-long distance approach tactics)
-- 特点：高速移动和转身(10/10)，10秒冷却，多用于远程冲刺 (Features: High-speed movement and turn (10/10), 10-second cooldown, often used for long-range charge)
Goal.Act10 = function (f9_arg0, f9_arg1, f9_arg2)
    -- 计算冲刺攻击距离参数 (Calculate charge attack distance parameters)
    local f9_local0 = 4.8 - f9_arg0:GetMapHitRadius(TARGET_SELF)        -- 最佳攻击距离 (Optimal attack distance)
    local f9_local1 = 4.8 - f9_arg0:GetMapHitRadius(TARGET_SELF)        -- 中等距离范围 (Medium distance range)
    local f9_local2 = 4.8 - f9_arg0:GetMapHitRadius(TARGET_SELF)        -- 最大距离范围 (Maximum distance range)
    local f9_local3 = 100                                               -- 接近权重 (Approach weight)
    local f9_local4 = 0                                                 -- 方向偏移 (Direction offset)
    local f9_local5 = 10                                                -- 非常高的移动速度倍率 (Very high movement speed multiplier)
    local f9_local6 = 10                                                -- 非常高的转身速度 (Very high turn speed)

    -- 执行高速冲刺接近 (Execute high-speed charge approach)
    Approach_Act_Flex(f9_arg0, f9_arg1, f9_local0, f9_local1, f9_local2, f9_local3, f9_local4, f9_local5, f9_local6)

    local f9_local7 = 0                                                 -- 上攻击角度 (Upper attack angle)
    local f9_local8 = 0                                                 -- 下攻击角度 (Lower attack angle)

    -- 执行冲刺攻击（动画3006）(Execute charge attack - animation 3006)
    f9_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 10, 3006, TARGET_ENE_0, 9999, f9_local7, f9_local8, 0, 0)

    -- 设置计时器3为10秒，防止过频使用冲刺攻击 (Set timer 3 to 10 seconds to prevent overuse of charge attack)
    f9_arg0:SetTimer(3, 10)

    GetWellSpace_Odds = 100  -- 设置空间优化概率 (Set space optimization probability)
    return GetWellSpace_Odds

end

-- ========== ACT11: 连击终结技 (ACT11: Combo Finisher) ==========
-- 功能：执行双段强力连击，用于结束连击序列 (Function: Execute two-stage power combo for finishing combo sequences)
-- 特点：3037起手 + 3020终结，高伤害收尾 (Features: 3037 starter + 3020 finisher, high damage conclusion)
Goal.Act11 = function (f10_arg0, f10_arg1, f10_arg2)
    -- 计算接近距离参数 (Calculate approach distance parameters)
    local f10_local0 = 3.2 - f10_arg0:GetMapHitRadius(TARGET_SELF)        -- 最佳攻击距离 (Optimal attack distance)
    local f10_local1 = 3.2 - f10_arg0:GetMapHitRadius(TARGET_SELF) + 2    -- 中等距离范围 (Medium distance range)
    local f10_local2 = 3.2 - f10_arg0:GetMapHitRadius(TARGET_SELF) + 3    -- 最大距离范围 (Maximum distance range)
    local f10_local3 = 100                                               -- 接近权重 (Approach weight)
    local f10_local4 = 0                                                 -- 方向偏移 (Direction offset)
    local f10_local5 = 3                                                 -- 移动速度倍率 (Movement speed multiplier)
    local f10_local6 = 3                                                 -- 转身速度 (Turn speed)

    -- 执行灵活接近 (Execute flexible approach)
    Approach_Act_Flex(f10_arg0, f10_arg1, f10_local0, f10_local1, f10_local2, f10_local3, f10_local4, f10_local5, f10_local6)

    -- 执行连击终结序列 (Execute combo finisher sequence)
    f10_arg1:AddSubGoal(GOAL_COMMON_ComboAttackTunableSpin, 10, 3037, TARGET_ENE_0, 6, 0)    -- 连击起手（动画3037）(Combo starter - animation 3037)
    f10_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3020, TARGET_ENE_0, 9999, 0, 0)         -- 终结攻击（动画3020）(Finisher attack - animation 3020)

end

-- ========== ACT15: 远程初始化攻击 (ACT15: Long-Range Initialization Attack) ==========
-- 功能：执行超远距离的初始攻击，通常用于战斗开始 (Function: Execute ultra-long range initial attack, usually used at battle start)
-- 特点：最长攻击距离(8.9m)，设置数字7标记首次使用 (Features: Longest attack range (8.9m), sets number 7 flag for first use)
Goal.Act15 = function (f11_arg0, f11_arg1, f11_arg2)
    -- 计算超远距离接近参数 (Calculate ultra-long distance approach parameters)
    local f11_local0 = 8.9 - f11_arg0:GetMapHitRadius(TARGET_SELF)        -- 最优攻击距离 (Optimal attack distance)
    local f11_local1 = 8.9 - f11_arg0:GetMapHitRadius(TARGET_SELF) - 2    -- 最小距离范围 (Minimum distance range)
    local f11_local2 = 8.9 - f11_arg0:GetMapHitRadius(TARGET_SELF)        -- 最大距离范围 (Maximum distance range)
    local f11_local3 = 100                                               -- 接近权重 (Approach weight)
    local f11_local4 = 0                                                 -- 方向偏移 (Direction offset)
    local f11_local5 = 1.5                                               -- 较低的移动速度 (Lower movement speed)
    local f11_local6 = 3                                                 -- 转身速度 (Turn speed)

    -- 执行灵活接近 (Execute flexible approach)
    Approach_Act_Flex(f11_arg0, f11_arg1, f11_local0, f11_local1, f11_local2, f11_local3, f11_local4, f11_local5, f11_local6)

    local f11_local7 = 0                                                 -- 上攻击角度 (Upper attack angle)
    local f11_local8 = 0                                                 -- 下攻击角度 (Lower attack angle)
    local f11_local9 = 7 - f11_arg0:GetMapHitRadius(TARGET_SELF)         -- 连击成功距离 (Combo success distance)

    -- 执行远程初始连击 (Execute long-range initial combo)
    f11_arg1:AddSubGoal(GOAL_COMMON_ComboAttackTunableSpin, 10, 3014, TARGET_ENE_0, f11_local9, f11_local7, f11_local8, 0, 0)  -- 初始攻击（动画3014）(Initial attack - animation 3014)
    f11_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3015, TARGET_ENE_0, 9999, 0, 0)                                           -- 终结攻击（动画3015）(Final attack - animation 3015)

    -- 设置数字7为1，标记已执行过初始攻击 (Set number 7 to 1, marking initial attack has been executed)
    f11_arg0:SetNumber(7, 1)

    GetWellSpace_Odds = 100  -- 设置空间优化概率 (Set space optimization probability)
    return GetWellSpace_Odds

end

-- ========== ACT16: 反制技能 (ACT16: Counter Skill) ==========
-- 功能：执行反制技能，针对玩家特定状态的对策 (Function: Execute counter skill, countermeasure against player specific states)
-- 特点：近距离快速反击，高权重触发条件 (Features: Close-range quick counter, high-weight trigger conditions)
Goal.Act16 = function (f12_arg0, f12_arg1, f12_arg2)
    -- 计算近距离接近参数 (Calculate close-range approach parameters)
    local f12_local0 = 2.5 - f12_arg0:GetMapHitRadius(TARGET_SELF)        -- 最佳攻击距离 (Optimal attack distance)
    local f12_local1 = 2.5 - f12_arg0:GetMapHitRadius(TARGET_SELF)        -- 中等距离范围 (Medium distance range)
    local f12_local2 = 2.5 - f12_arg0:GetMapHitRadius(TARGET_SELF)        -- 最大距离范围 (Maximum distance range)
    local f12_local3 = 100                                               -- 接近权重 (Approach weight)
    local f12_local4 = 0                                                 -- 方向偏移 (Direction offset)
    local f12_local5 = 1.5                                               -- 较低的移动速度 (Lower movement speed)
    local f12_local6 = 3                                                 -- 转身速度 (Turn speed)

    local f12_local7 = f12_arg0:GetRandam_Int(1, 100)                     -- 随机数（未使用）(Random number - unused)

    -- 执行灵活接近 (Execute flexible approach)
    Approach_Act_Flex(f12_arg0, f12_arg1, f12_local0, f12_local1, f12_local2, f12_local3, f12_local4, f12_local5, f12_local6)

    local f12_local8 = 0                                                 -- 上攻击角度 (Upper attack angle)
    local f12_local9 = 0                                                 -- 下攻击角度 (Lower attack angle)
    local f12_local10 = 7 - f12_arg0:GetMapHitRadius(TARGET_SELF)        -- 攻击有效距离 (Attack effective distance)

    -- 执行反制攻击（动画3022）(Execute counter attack - animation 3022)
    f12_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 10, 3022, TARGET_ENE_0, 9999, f12_local8, f12_local9, 0, 0)

    GetWellSpace_Odds = 100  -- 设置空间优化概率 (Set space optimization probability)
    return GetWellSpace_Odds

end

-- ========== ACT20: 中距离特殊攻击 (ACT20: Medium Range Special Attack) ==========
-- 功能：执行中距离的特殊攻击，使用动画3062 (Function: Execute medium range special attack using animation 3062)
-- 特点：渐进距离范围(3.2+1+2)，标准接近参数 (Features: Progressive distance range (3.2+1+2), standard approach parameters)
Goal.Act20 = function (f13_arg0, f13_arg1, f13_arg2)
    -- 计算中距离攻击距离参数 (Calculate medium range attack distance parameters)
    local f13_local0 = 3.2 - f13_arg0:GetMapHitRadius(TARGET_SELF)        -- 最佳攻击距离 (Optimal attack distance)
    local f13_local1 = 3.2 - f13_arg0:GetMapHitRadius(TARGET_SELF) + 1    -- 中等距离范围 (Medium distance range)
    local f13_local2 = 3.2 - f13_arg0:GetMapHitRadius(TARGET_SELF) + 2    -- 最大距离范围 (Maximum distance range)
    local f13_local3 = 100                                               -- 接近权重 (Approach weight)
    local f13_local4 = 0                                                 -- 方向偏移 (Direction offset)
    local f13_local5 = 2.5                                               -- 标准移动速度倍率 (Standard movement speed multiplier)
    local f13_local6 = 3                                                 -- 转身速度 (Turn speed)

    -- 执行灵活接近 (Execute flexible approach)
    Approach_Act_Flex(f13_arg0, f13_arg1, f13_local0, f13_local1, f13_local2, f13_local3, f13_local4, f13_local5, f13_local6)

    local f13_local7 = 0                                                 -- 上攻击角度 (Upper attack angle)
    local f13_local8 = 0                                                 -- 下攻击角度 (Lower attack angle)

    -- 执行中距离特殊攻击（动画3062）(Execute medium range special attack - animation 3062)
    f13_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 10, 3062, TARGET_ENE_0, 9999, f13_local7, f13_local8, 0, 0)

    GetWellSpace_Odds = 100  -- 设置空间优化概率 (Set space optimization probability)
    return GetWellSpace_Odds

end

-- ========== ACT21: 快速转向行为 (ACT21: Quick Turn Behavior) ==========
-- 功能：快速转向玩家的位置，用于追击或调整朝向 (Function: Quickly turn towards player position, used for pursuit or orientation adjustment)
-- 特点：纯转向动作，不设置空间优化，多用于潜行者追击 (Features: Pure turning action, no space optimization, often used for stealth target pursuit)
Goal.Act21 = function (f14_arg0, f14_arg1, f14_arg2)
    local f14_local0 = 3                                                 -- 转向时间 (Turn time)
    local f14_local1 = 45                                                -- 转向角度阈值 (Turn angle threshold)

    -- 执行快速转向玩家方向 (Execute quick turn towards player direction)
    f14_arg1:AddSubGoal(GOAL_COMMON_Turn, f14_local0, TARGET_ENE_0, f14_local1, -1, GOAL_RESULT_Success, true)

    GetWellSpace_Odds = 0  -- 不设置空间优化，保持原位 (No space optimization, stay in place)
    return GetWellSpace_Odds

end

-- ========== ACT22: 斜向闪避步 (ACT22: Diagonal Dodge Step) ==========
-- 功能：根据空间情况执行斜向闪避步法，避开玩家攻击 (Function: Execute diagonal dodge steps based on space situation to avoid player attacks)
-- 特点：智能空间检测，优先选择最佳闪避方向，使用动画5202/5203 (Features: Intelligent space detection, prioritize optimal dodge direction, using animations 5202/5203)
Goal.Act22 = function (f15_arg0, f15_arg1, f15_arg2)
    local f15_local0 = 3                                                 -- 闪避步执行时间 (Dodge step execution time)
    local f15_local1 = 0                                                 -- 闪避参数 (Dodge parameter)

    -- 空间检测与闪避方向决策 (Space detection and dodge direction decision)
    if SpaceCheck(f15_arg0, f15_arg1, -45, 2) == true then              -- 检查左后方45°空间 (Check left rear 45° space)
        if SpaceCheck(f15_arg0, f15_arg1, 45, 2) == true then           -- 检查右后方45°空间 (Check right rear 45° space)
            -- 双侧都有空间，根据玩家位置选择闪避方向 (Both sides have space, choose dodge direction based on player position)
            if f15_arg0:IsInsideTarget(TARGET_ENE_0, AI_DIR_TYPE_R, 180) then
                f15_arg1:AddSubGoal(GOAL_COMMON_SpinStep, f15_local0, 5202, TARGET_ENE_0, f15_local1, AI_DIR_TYPE_L, 0)  -- 向左闪避 (Dodge left)
            else
                f15_arg1:AddSubGoal(GOAL_COMMON_SpinStep, f15_local0, 5203, TARGET_ENE_0, f15_local1, AI_DIR_TYPE_R, 0)  -- 向右闪避 (Dodge right)
            end
        else
            -- 只有左侧有空间 (Only left side has space)
            f15_arg1:AddSubGoal(GOAL_COMMON_SpinStep, f15_local0, 5202, TARGET_ENE_0, f15_local1, AI_DIR_TYPE_L, 0)      -- 向左闪避 (Dodge left)
        end
    elseif SpaceCheck(f15_arg0, f15_arg1, 45, 2) == true then           -- 只有右侧有空间 (Only right side has space)
        f15_arg1:AddSubGoal(GOAL_COMMON_SpinStep, f15_local0, 5203, TARGET_ENE_0, f15_local1, AI_DIR_TYPE_R, 0)          -- 向右闪避 (Dodge right)
    else
        -- 两侧都没有空间，不执行闪避 (No space on either side, don't execute dodge)
    end

    GetWellSpace_Odds = 0  -- 不设置空间优化，由闪避动作本身处理位置 (No space optimization, position handled by dodge action itself)
    return GetWellSpace_Odds

end

-- ========== ACT23: 智能侧向规避 (ACT23: Intelligent Lateral Evasion) ==========
-- 功能：执行基于空间检测的侧向移动规避 (Function: Execute space-detection based lateral movement evasion)
-- 特点：根据左右空间状态智能选择移动方向 (Features: Intelligently choose movement direction based on left/right space status)
-- 应用场景：面对敌人攻击时的主动规避策略 (Application: Active evasion strategy when facing enemy attacks)
Goal.Act23 = function (f16_arg0, f16_arg1, f16_arg2)
    local f16_local0 = f16_arg0:GetDist(TARGET_ENE_0)              -- 获取与敌人的距离 (Get distance to enemy)
    local f16_local1 = f16_arg0:GetSp(TARGET_SELF)                -- 获取当前SP值 (Get current SP value)
    local f16_local2 = 20                                          -- 随机角度基数 (Random angle base)
    local f16_local3 = f16_arg0:GetRandam_Int(1, 100)             -- 随机数1-100 (Random number 1-100)
    local f16_local4 = -1                                          -- 动画状态标记 (Animation state flag)
    local f16_local5 = 0                                           -- 移动方向：0=左，1=右 (Movement direction: 0=left, 1=right)
    -- 空间检测与方向选择逻辑 (Space detection and direction selection logic)
    if SpaceCheck(f16_arg0, f16_arg1, -90, 1) == true then         -- 检测左侧空间 (Check left side space)
        if SpaceCheck(f16_arg0, f16_arg1, 90, 1) == true then       -- 检测右侧空间 (Check right side space)
            -- 左右两侧都有空间，根据敌人位置选择 (Both sides have space, choose based on enemy position)
            if f16_arg0:IsInsideTargetEx(TARGET_ENE_0, TARGET_SELF, AI_DIR_TYPE_R, 180, 5) then
                f16_local5 = 1                                      -- 敌人在右侧，向右移动 (Enemy on right, move right)
            else
                f16_local5 = 0                                      -- 敌人在左侧，向左移动 (Enemy on left, move left)
            end
        else
            f16_local5 = 0                                          -- 只有左侧有空间 (Only left side has space)
        end
    elseif SpaceCheck(f16_arg0, f16_arg1, 90, 1) == true then       -- 只有右侧有空间 (Only right side has space)
        f16_local5 = 1
    else
        -- 两侧都没有空间时的默认处理 (Default handling when no space on either side)
    end
    local f16_local6 = f16_arg0:GetRandam_Int(1.5, 3)             -- 随机移动持续时间1.5-3秒 (Random movement duration 1.5-3 seconds)
    local f16_local7 = f16_arg0:GetRandam_Int(30, 45)             -- 随机移动角度30-45度 (Random movement angle 30-45 degrees)
    f16_arg0:SetNumber(10, f16_local5)                             -- 记录移动方向到AI变量10 (Record movement direction to AI variable 10)
    -- 执行侧向移动 (Execute lateral movement)
    f16_arg1:AddSubGoal(GOAL_COMMON_SidewayMove, f16_local6, TARGET_ENE_0, f16_local5, f16_local7, true, true, f16_local4)
    GetWellSpace_Odds = 100  -- 设置高空间优化权重 (Set high space optimization weight)
    return GetWellSpace_Odds
    
end

-- ========== ACT24: 后退旋转攻击 (ACT24: Backward Spinning Attack) ==========
-- 功能：执行后退旋转攻击，包含SP消耗和特殊效果检查 (Function: Execute backward spinning attack with SP consumption and special effect check)
-- 特点：根据空间和距离条件选择不同攻击动作 (Features: Choose different attack actions based on space and distance conditions)
-- 应用场景：中近距离战斗中的反击策略 (Application: Counter-attack strategy in medium-close combat)
Goal.Act24 = function (f17_arg0, f17_arg1, f17_arg2)
    local f17_local0 = f17_arg0:GetDist(TARGET_ENE_0)              -- 获取与敌人距离 (Get distance to enemy)
    local f17_local1 = 3                                           -- 旋转攻击持续时间3秒 (Spinning attack duration 3 seconds)
    local f17_local2 = 0                                           -- 转向时间参数 (Turn time parameter)
    local f17_local3 = 5201                                        -- 后退旋转攻击动作ID (Backward spinning attack animation ID)
    local f17_local4 = f17_arg0:GetSpRate(TARGET_SELF)            -- 获取SP百分比 (Get SP percentage)
    -- 空间和距离条件检查 (Space and distance condition check)
    if SpaceCheck(f17_arg0, f17_arg1, 180, 2) ~= true or SpaceCheck(f17_arg0, f17_arg1, 180, 4) ~= true or f17_local0 > 4 then
        -- 后方空间不足或距离过远，使用默认攻击 (Insufficient rear space or distance too far, use default attack)
    else
        f17_local3 = 5201                                          -- 空间充足时使用后退旋转攻击 (Use backward spinning attack when space is sufficient)
        if false then
            -- 预留条件分支 (Reserved condition branch)
        else
            -- 默认分支 (Default branch)
        end
    end
    f17_arg0:SetNumber(2, 1)                                       -- 设置AI变量2为1，标记政击状态 (Set AI variable 2 to 1, mark attack state)
    -- 执行旋转步伐攻击，30秒冷却时间 (Execute spinning step attack with 30-second cooldown)
    f17_arg1:AddSubGoal(GOAL_COMMON_SpinStep, f17_local1, f17_local3, TARGET_ENE_0, f17_local2, AI_DIR_TYPE_B, 0):TimingSetTimer(3, 30, AI_TIMING_SET__UPDATE_SUCCESS)
    -- SP低于70%且有特殊效果200050时执行追击 (Execute follow-up attack when SP < 70% and has special effect 200050)
    if f17_local4 <= 0.7 and f17_arg0:HasSpecialEffectId(TARGET_SELF, 200050) then
        f17_arg1:AddSubGoal(GOAL_COMMON_ComboRepeat, 10, 3044, TARGET_ENE_0, DistToAtt1, f17_local2, FrontAngle, 0, 0)
    end
    GetWellSpace_Odds = 100  -- 设置高空间优化权重 (Set high space optimization weight)
    return GetWellSpace_Odds
    
end

-- ========== ACT25: 后撤脱离 (ACT25: Backward Disengagement) ==========
-- 功能：执行后撤脱离动作，拉开与敌人的距离 (Function: Execute backward disengagement action, increase distance from enemy)
-- 特点：基于后方空间检查，安全撤退到更远位置 (Features: Based on rear space check, safely retreat to farther position)
-- 应用场景：战斗压力过大时的战术撤退 (Application: Tactical retreat when combat pressure is too high)
Goal.Act25 = function (f18_arg0, f18_arg1, f18_arg2)
    local f18_local0 = f18_arg0:GetRandam_Float(2, 4)             -- 随机撤退持续时间2-4秒 (Random retreat duration 2-4 seconds)
    local f18_local1 = f18_arg0:GetRandam_Float(1, 3)             -- 随机目标撤退距离1-3米 (Random target retreat distance 1-3 meters)
    local f18_local2 = f18_arg0:GetDist(TARGET_ENE_0)              -- 获取当前与敌人距离 (Get current distance to enemy)
    local f18_local3 = -1                                          -- 动画状态标记 (Animation state flag)
    -- 后方空间检查与撤退执行 (Rear space check and retreat execution)
    if SpaceCheck(f18_arg0, f18_arg1, 180, 1) == true then         -- 检查后方是否有空间 (Check if there's space behind)
        -- 后方有空间，执行撤退 (Space behind available, execute retreat)
        f18_arg1:AddSubGoal(GOAL_COMMON_LeaveTarget, f18_local0, TARGET_ENE_0, f18_local1, TARGET_ENE_0, true, f18_local3)
    else
        -- 后方无空间，不执行撤退 (No space behind, don't execute retreat)
    end
    GetWellSpace_Odds = 0    -- 不设置空间优化，由撤退动作自己处理 (No space optimization, handled by retreat action itself)
    return GetWellSpace_Odds
    
end

-- ========== ACT26: 短暂等待 (ACT26: Brief Wait) ==========
-- 功能：执行0.5秒短暂等待动作 (Function: Execute 0.5-second brief wait action)
-- 特点：用于时机调整和节奏控制 (Features: Used for timing adjustment and rhythm control)
-- 应用场景：战斗间隙中的观察等待 (Application: Observation waiting during combat intervals)
Goal.Act26 = function (f19_arg0, f19_arg1, f19_arg2)
    -- 执行0.5秒等待 (Execute 0.5-second wait)
    f19_arg1:AddSubGoal(GOAL_COMMON_Wait, 0.5, TARGET_SELF, 0, 0, 0)
    GetWellSpace_Odds = 0    -- 不需要空间优化 (No space optimization needed)
    return GetWellSpace_Odds
    
end

-- ========== ACT27: 自适应距离调整 (ACT27: Adaptive Distance Adjustment) ==========
-- 功能：根据当前距离自动调整位置，维持最优作战距离 (Function: Automatically adjust position based on current distance, maintain optimal combat distance)
-- 特点：远距离时接近，近距离时拉开，中距离时侧移 (Features: Approach when far, retreat when close, sidestep at medium distance)
-- 应用场景：动态距离管理和位置优化 (Application: Dynamic distance management and position optimization)
Goal.Act27 = function (f20_arg0, f20_arg1, f20_arg2)
    local f20_local0 = f20_arg0:GetDist(TARGET_ENE_0)              -- 获取当前与敌人距离 (Get current distance to enemy)
    local f20_local1 = f20_arg0:GetRandam_Int(1, 100)             -- 随机数字用于决策 (Random number for decision making)
    local f20_local2 = 8                                           -- 接近目标距离8米 (Target approach distance 8 meters)
    local f20_local3 = 5                                           -- 拉开目标距离5米 (Target retreat distance 5 meters)
    local f20_local4 = f20_arg0:GetRandam_Float(2, 4)             -- 移动持续时间2-4秒 (Movement duration 2-4 seconds)
    local f20_local5 = f20_arg0:GetRandam_Int(30, 45)             -- 侧移角度30-45度 (Sidestep angle 30-45 degrees)
    -- 根据距离执行不同的移动策略 (Execute different movement strategies based on distance)
    if f20_local0 >= 8 then                                       -- 距离≥ 8米：太远，需要接近 (Distance >= 8m: too far, need to approach)
        f20_arg1:AddSubGoal(GOAL_COMMON_ApproachTarget, f20_local4, TARGET_ENE_0, f20_local2, TARGET_ENE_0, true, -1)
    elseif f20_local0 <= 5 then                                   -- 距离≤ 5米：太近，需要拉开 (Distance <= 5m: too close, need to retreat)
        f20_arg1:AddSubGoal(GOAL_COMMON_LeaveTarget, f20_local4, TARGET_ENE_0, f20_local3, TARGET_ENE_0, true, -1)
    end
    -- 无论距离如何，都执行侧向移动以保持机动性 (Regardless of distance, execute lateral movement to maintain mobility)
    f20_arg1:AddSubGoal(GOAL_COMMON_SidewayMove, f20_local4, TARGET_ENE_0, f20_arg0:GetRandam_Int(0, 1), f20_local5, true, true, -1)
    GetWellSpace_Odds = 0    -- 不设置空间优化，由移动动作自己处理 (No space optimization, handled by movement actions)
    return GetWellSpace_Odds
    
end

-- ========== ACT28: 精确距离调整 (ACT28: Precise Distance Adjustment) ==========
-- 功能：执行更精确的距离调整，针对不同距离层采用不同策略 (Function: Execute more precise distance adjustment, using different strategies for different distance layers)
-- 特点：3米内侧移，3-8米间接近，超过8米快速接近 (Features: Sidestep within 3m, approach between 3-8m, rapid approach beyond 8m)
-- 应用场景：需要精确控制作战距离的战术调整 (Application: Tactical adjustment requiring precise combat distance control)
Goal.Act28 = function (f21_arg0, f21_arg1, f21_arg2)
    local f21_local0 = f21_arg0:GetDist(TARGET_ENE_0)              -- 获取当前与敌人距离 (Get current distance to enemy)
    local f21_local1 = 1.5                                         -- 侧移持续时间1.5秒 (Sidestep duration 1.5 seconds)
    local f21_local2 = 1.5                                         -- 接近持续时间1.5秒 (Approach duration 1.5 seconds)
    local f21_local3 = f21_arg0:GetRandam_Int(30, 45)             -- 侧移角度30-45度 (Sidestep angle 30-45 degrees)
    local f21_local4 = -1                                          -- 动画状态标记 (Animation state flag)
    local f21_local5 = f21_arg0:GetRandam_Int(0, 1)               -- 侧移方向：0=左，1=右 (Sidestep direction: 0=left, 1=right)
    -- 精确的距离分层管理策略 (Precise distance layer management strategy)
    if f21_local0 <= 3 then                                       -- 距离≤ 3米：近距离，执行侧向移动 (Distance <= 3m: close range, execute lateral movement)
        f21_arg1:AddSubGoal(GOAL_COMMON_SidewayMove, f21_local1, TARGET_ENE_0, f21_local5, f21_local3, true, true, f21_local4)
    elseif f21_local0 <= 8 then                                   -- 3米 < 距离≤ 8米：中距离，接近到3米 (3m < distance <= 8m: medium range, approach to 3m)
        f21_arg1:AddSubGoal(GOAL_COMMON_ApproachTarget, f21_local2, TARGET_ENE_0, 3, TARGET_SELF, true, -1)
    else                                                           -- 距离 > 8米：远距离，快速接近到8米 (Distance > 8m: long range, rapidly approach to 8m)
        f21_arg1:AddSubGoal(GOAL_COMMON_ApproachTarget, f21_local2, TARGET_ENE_0, 8, TARGET_SELF, false, -1)
    end
    GetWellSpace_Odds = 0    -- 不设置空间优化 (No space optimization)
    return GetWellSpace_Odds
    
end

-- ========== ACT30: 旋转连击组合 (ACT30: Spinning Combo Combination) ==========
-- 功能：执行旋转攻击+追击连击的组合攻击 (Function: Execute spinning attack + follow-up combo combination attack)
-- 特点：先执行3009旋转攻击，再跟进3044追击 (Features: First execute 3009 spinning attack, then follow up with 3044 pursuit)
-- 应用场景：中距离压制性连击攻击 (Application: Medium-range suppressive combo attack)
Goal.Act30 = function (f22_arg0, f22_arg1, f22_arg2)
    -- 执行旋转攻击起始段 (Execute spinning attack initial segment)
    f22_arg1:AddSubGoal(GOAL_COMMON_ComboAttackTunableSpin, 10, 3009, TARGET_ENE_0, 9999, TurnTime, FrontAngle, 0, 0)
    -- 紧接着执行追击连击段 (Follow up with pursuit combo segment)
    f22_arg1:AddSubGoal(GOAL_COMMON_ComboRepeat, 10, 3044, TARGET_ENE_0, DistToAtt1, TurnTime, FrontAngle, 0, 0)
    GetWellSpace_Odds = 100  -- 设置高空间优化权重 (Set high space optimization weight)
    return GetWellSpace_Odds
    
end

-- ========== ACT31: Approach_Act_Flex灵活接近 (ACT31: Approach_Act_Flex Flexible Approach) ==========
-- 功能：使用Approach_Act_Flex系统灵活接近敌人 (Function: Use Approach_Act_Flex system to flexibly approach enemy)
-- 特点：根据地图半径计算精确距离，智能化接近 (Features: Calculate precise distances based on map radius, intelligent approach)
-- 应用场景：需要智能化接近策略的复杂场景 (Application: Complex scenarios requiring intelligent approach strategies)
Goal.Act31 = function (f23_arg0, f23_arg1, f23_arg2)
    local f23_local0 = 3.6 - f23_arg0:GetMapHitRadius(TARGET_SELF)
    local f23_local1 = 3.6 - f23_arg0:GetMapHitRadius(TARGET_SELF) + 2
    local f23_local2 = 3.6 - f23_arg0:GetMapHitRadius(TARGET_SELF) + 2
    local f23_local3 = 100
    local f23_local4 = 0
    local f23_local5 = 1.5
    local f23_local6 = 3
    -- 调用Approach_Act_Flex系统进行智能化接近 (Call Approach_Act_Flex system for intelligent approach)
    Approach_Act_Flex(f23_arg0, f23_arg1, f23_local0, f23_local1, f23_local2, f23_local3, f23_local4, f23_local5, f23_local6)
    local f23_local7 = 0                                               -- 转向时间 (Turn time)
    local f23_local8 = 0                                               -- 攻击角度 (Attack angle)
    local f23_local9 = 999 - f23_arg0:GetMapHitRadius(TARGET_SELF)    -- 超远距离攻击范围 (Ultra long range attack range)
    -- 执行旋转连击攻击起始段 (Execute spinning combo attack initial segment)
    f23_arg1:AddSubGoal(GOAL_COMMON_ComboAttackTunableSpin, 10, 3003, TARGET_ENE_0, f23_local9, f23_local7, f23_local8, 0, 0)
    -- 执行连击终结段 (Execute combo finisher segment)
    f23_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3045, TARGET_ENE_0, 9999, 0, 0)
    GetWellSpace_Odds = 100  -- 设置高空间优化权重 (Set high space optimization weight)
    return GetWellSpace_Odds
    
end

-- ========== ACT34: 中距离灵活连击 (ACT34: Medium-Range Flexible Combo) ==========
-- 功能：以5.9米为基准距离的灵活接近+连击攻击 (Function: Flexible approach + combo attack based on 5.9m distance)
-- 特点：先灵活接近，然后执行3007+3011连击组合 (Features: First flexible approach, then execute 3007+3011 combo combination)
-- 应用场景：中距离战斗中的主要攻击手段 (Application: Primary attack method in medium-range combat)
Goal.Act34 = function (f24_arg0, f24_arg1, f24_arg2)
    local f24_local0 = 5.9 - f24_arg0:GetMapHitRadius(TARGET_SELF)   -- 最小接近距离 (5.9米 - 自身半径) (Minimum approach distance: 5.9m - self radius)
    local f24_local1 = 5.9 - f24_arg0:GetMapHitRadius(TARGET_SELF) + 2 -- 中等接近距离 (+2米缓冲) (Medium approach distance: +2m buffer)
    local f24_local2 = 5.9 - f24_arg0:GetMapHitRadius(TARGET_SELF) + 2 -- 最大接近距离 (+2米缓冲) (Maximum approach distance: +2m buffer)
    local f24_local3 = 100                                             -- 行为权重100 (Behavior weight 100)
    local f24_local4 = 0                                               -- 特殊参数 (Special parameter)
    local f24_local5 = 1.5                                             -- 最小选择时间 (Minimum selection time)
    local f24_local6 = 3                                               -- 最大选择时间 (Maximum selection time)
    -- 调用Approach_Act_Flex系统进行智能化接近 (Call Approach_Act_Flex system for intelligent approach)
    Approach_Act_Flex(f24_arg0, f24_arg1, f24_local0, f24_local1, f24_local2, f24_local3, f24_local4, f24_local5, f24_local6)
    local f24_local7 = 0                                               -- 转向时间 (Turn time)
    local f24_local8 = 0                                               -- 攻击角度 (Attack angle)
    local f24_local9 = 999 - f24_arg0:GetMapHitRadius(TARGET_SELF)    -- 超远距离攻击范围 (Ultra long range attack range)
    -- 执行旋转连击攻击3007起始段 (Execute spinning combo attack 3007 initial segment)
    f24_arg1:AddSubGoal(GOAL_COMMON_ComboAttackTunableSpin, 10, 3007, TARGET_ENE_0, f24_local9, f24_local7, f24_local8, 0, 0)
    -- 执行连击终结段3011 (Execute combo finisher segment 3011)
    f24_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3011, TARGET_ENE_0, 9999, 0, 0)
    GetWellSpace_Odds = 100  -- 设置高空间优化权重 (Set high space optimization weight)
    return GetWellSpace_Odds
    
end

-- ========== ACT48: 超长距离初始攻击 (ACT48: Ultra Long-Range Initial Attack) ==========
-- 功能：以8.9米为基准的超长距离战斗初始化攻击 (Function: Ultra long-range combat initialization attack based on 8.9m)
-- 特点：先灵活接近，然后执行3013+3015连击，设置AI变量7 (Features: First flexible approach, then execute 3013+3015 combo, set AI variable 7)
-- 应用场景：战斗开始时的超远程攻击策略 (Application: Ultra long-range attack strategy at combat start)
Goal.Act48 = function (f25_arg0, f25_arg1, f25_arg2)
    local f25_local0 = 8.9 - f25_arg0:GetMapHitRadius(TARGET_SELF)   -- 最小接近距离 (8.9米 - 自身半径) (Minimum approach distance: 8.9m - self radius)
    local f25_local1 = 8.9 - f25_arg0:GetMapHitRadius(TARGET_SELF) - 2 -- 中等接近距离 (-2米保守缓冲) (Medium approach distance: -2m conservative buffer)
    local f25_local2 = 8.9 - f25_arg0:GetMapHitRadius(TARGET_SELF)     -- 最大接近距离 (就是基本8.9米) (Maximum approach distance: base 8.9m)
    local f25_local3 = 100                                             -- 行为权重100 (Behavior weight 100)
    local f25_local4 = 0                                               -- 特殊参数 (Special parameter)
    local f25_local5 = 1.5                                             -- 最小选择时间 (Minimum selection time)
    local f25_local6 = 3                                               -- 最大选择时间 (Maximum selection time)
    -- 调用Approach_Act_Flex系统进行超远距离智能化接近 (Call Approach_Act_Flex system for ultra long-range intelligent approach)
    Approach_Act_Flex(f25_arg0, f25_arg1, f25_local0, f25_local1, f25_local2, f25_local3, f25_local4, f25_local5, f25_local6)
    local f25_local7 = 0                                               -- 转向时间 (Turn time)
    local f25_local8 = 0                                               -- 攻击角度 (Attack angle)
    local f25_local9 = 7 - f25_arg0:GetMapHitRadius(TARGET_SELF)      -- 7米攻击范围 (7-meter attack range)
    -- 执行旋转连击攻击3013起始段 (Execute spinning combo attack 3013 initial segment)
    f25_arg1:AddSubGoal(GOAL_COMMON_ComboAttackTunableSpin, 10, 3013, TARGET_ENE_0, f25_local9, f25_local7, f25_local8, 0, 0)
    -- 执行连击终结段3015 (Execute combo finisher segment 3015)
    f25_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3015, TARGET_ENE_0, 9999, 0, 0)
    f25_arg0:SetNumber(7, 1)                                           -- 设置AI变量7为1，标记超远攻击已执行 (Set AI variable 7 to 1, mark ultra long-range attack executed)
    GetWellSpace_Odds = 100  -- 设置高空间优化权重 (Set high space optimization weight)
    return GetWellSpace_Odds
    
end

-- ========== 中断处理系统 (Interrupt Handling System) ==========
-- 功能：处理战斗中的各种中断事件，包括招架、射击冲击、特殊效果激活等 (Function: Handle various interrupt events in combat, including parries, shoot impacts, special effect activations, etc.)
-- 特点：高优先级反应系统，立即响应玩家行为和特殊状态变化 (Features: High-priority reaction system that immediately responds to player actions and special state changes)
Goal.Interrupt = function (f26_arg0, f26_arg1, f26_arg2)
    -- 获取中断相关信息 (Get interrupt-related information)
    local f26_local0 = f26_arg1:GetSpecialEffectActivateInterruptType(0)   -- 特殊效果激活中断类型 (Special effect activate interrupt type)
    local f26_local1 = f26_arg1:GetSpecialEffectInactivateInterruptType(0) -- 特殊效果失效中断类型 (Special effect inactivate interrupt type)
    local f26_local2 = f26_arg1:GetDist(TARGET_ENE_0)                      -- 与玩家的距离 (Distance to player)
    local f26_local3 = f26_arg1:GetRandam_Int(1, 100)                      -- 随机数1-100 (Random number 1-100)
    local f26_local4 = f26_arg1:GetNinsatsuNum()                          -- 玩家忍杀数量 (Player ninsatsu count)

    -- 基础状态检查 (Basic state checks)
    if f26_arg1:IsLadderAct(TARGET_SELF) then
        return false  -- 正在爬梯时不处理中断 (Don't handle interrupts while climbing ladder)
    end
    if not f26_arg1:HasSpecialEffectId(TARGET_SELF, 200004) then
        return false  -- 没有基础战斗状态时不处理中断 (Don't handle interrupts without basic combat state)
    end

    -- 招架时机中断处理 (Parry timing interrupt handling)
    if f26_arg1:IsInterupt(INTERUPT_ParryTiming) then
        return f26_arg0.Parry(f26_arg1, f26_arg2, 100, 0)  -- 执行招架反应 (Execute parry reaction)
    end

    -- 射击冲击中断处理 (Shoot impact interrupt handling)
    if f26_arg1:IsInterupt(INTERUPT_ShootImpact) and f26_arg0.ShootReaction(f26_arg1, f26_arg2) then
        return true  -- 执行射击反应 (Execute shoot reaction)
    end

    -- 特殊效果激活中断处理 (Special effect activation interrupt handling)
    if f26_arg1:IsInterupt(INTERUPT_ActivateSpecialEffect) then
        if f26_local0 == 3710020 then
            -- 特殊效果3710020：重置计数器 (Special effect 3710020: Reset counter)
            f26_arg1:SetNumber(0, 0)
            return true
        elseif f26_local0 == 3710030 and f26_arg1:HasSpecialEffectId(TARGET_SELF, 3710032) then
            -- 特殊效果3710030+3710032：执行霸体攻击3092 (Special effect 3710030+3710032: Execute endure attack 3092)
            f26_arg2:ClearSubGoal()
            f26_arg2:AddSubGoal(GOAL_COMMON_EndureAttack, 5, 3092, TARGET_ENE_0, 9999, 0)
            f26_arg1:SetTimer(6, 50)  -- 设置50秒计时器 (Set 50-second timer)
            return true
        elseif f26_local0 == 5029 then
            -- 特殊效果5029：受伤反应 (Special effect 5029: Damage reaction)
            return f26_arg0.Damaged(f26_arg1, f26_arg2)
        elseif f26_local0 == 5031 then
            -- 特殊效果5031：忍杀数量检查，距离>=4.1时执行连击 (Special effect 5031: Ninsatsu count check, execute combo when distance >= 4.1)
            if f26_local4 <= 1 and f26_local2 >= 4.1 then
                f26_arg2:ClearSubGoal()
                f26_arg2:AddSubGoal(GOAL_COMMON_ComboRepeat, 5, 3017, TARGET_ENE_0, 9999, 0)
            end
        elseif f26_local0 == 3710050 then
            -- 特殊效果3710050：根据随机数和特殊状态选择行动 (Special effect 3710050: Choose action based on random number and special state)
            if f26_local3 <= 50 and f26_arg1:HasSpecialEffectId(TARGET_SELF, 200050) then
                -- 50%概率且有200050效果：执行连击攻击3023 (50% chance with effect 200050: Execute combo attack 3023)
                f26_arg2:ClearSubGoal()
                f26_arg2:AddSubGoal(GOAL_COMMON_ComboRepeat, 5, 3023, TARGET_ENE_0, 9999, 0)
            else
                -- 其他情况：执行侧向移动 (Other cases: Execute sideways movement)
                f26_arg2:ClearSubGoal()
                f26_arg2:AddSubGoal(GOAL_COMMON_SidewayMove, 4, TARGET_ENE_0, f26_arg1:GetRandam_Int(0, 1), f26_arg1:GetRandam_Int(30, 45), true, true, -1)
            end
        elseif f26_local0 == 110620 then
            -- 特殊效果110620：重新规划行为 (Special effect 110620: Replanning behavior)
            f26_arg1:Replanning()
            return true
        end
    end

    -- 道具使用检查和反击 (Item use check and counter-attack)
    if not Interupt_Use_Item(f26_arg1, 8, 5) or f26_arg1:HasSpecialEffectId(TARGET_SELF, 200051) and f26_local4 >= 2 then
        -- 条件不满足时不执行反击 (Don't execute counter-attack when conditions not met)
    else
        -- 执行快速反击攻击3023 (Execute quick counter-attack 3023)
        f26_arg2:ClearSubGoal()
        f26_arg2:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 1, 3023, TARGET_ENE_0, 9999, 0, 0, 0, 0)
        return true
    end
    return false  -- 没有中断处理时返回false (Return false when no interrupt handling)

end

-- ========== 招架反应系统 (Parry Reaction System) ==========
-- 功能：处理玩家攻击时的招架反应，根据不同条件选择反击方式 (Function: Handle parry reactions to player attacks, choose counter-attack methods based on different conditions)
-- 特点：复杂的条件判断，包括距离、特殊效果、连续防御次数等因素 (Features: Complex condition checks including distance, special effects, consecutive guard count, etc.)
Goal.Parry = function (f27_arg0, f27_arg1, f27_arg2, f27_arg3)
    local f27_local0 = f27_arg0:GetDist(TARGET_ENE_0)
    local f27_local1 = GetDist_Parry(f27_arg0)
    local f27_local2 = f27_arg0:GetRandam_Int(1, 100)
    local f27_local3 = f27_arg0:GetRandam_Int(1, 100)
    local f27_local4 = f27_arg0:GetRandam_Int(1, 100)
    local f27_local5 = f27_arg0:HasSpecialEffectId(TARGET_ENE_0, 109970)
    local f27_local6 = f27_arg0:HasSpecialEffectId(TARGET_ENE_0, COMMON_SP_EFFECT_PC_ATTACK_RUSH)
    local f27_local7 = 2
    if f27_arg0:HasSpecialEffectId(TARGET_SELF, 221000) then
        f27_local7 = 0
    elseif f27_arg0:HasSpecialEffectId(TARGET_SELF, 221001) then
        f27_local7 = 1
    end
    if f27_arg0:IsFinishTimer(AI_TIMER_PARRY_INTERVAL) == false then
        return false
    end
    if f27_arg0:HasSpecialEffectId(TARGET_ENE_0, 110450) or f27_arg0:HasSpecialEffectId(TARGET_ENE_0, 110501) or f27_arg0:HasSpecialEffectId(TARGET_ENE_0, 110500) then
        return false
    end
    f27_arg0:SetTimer(AI_TIMER_PARRY_INTERVAL, 0.1)
    if f27_arg2 == nil then
        f27_arg2 = 50
    end
    if f27_arg3 == nil then
        f27_arg3 = 0
    end
    if f27_arg0:IsInsideTarget(TARGET_ENE_0, AI_DIR_TYPE_F, 90) and f27_arg0:IsInsideTargetEx(TARGET_ENE_0, TARGET_SELF, AI_DIR_TYPE_F, 180, f27_local1) then
        if f27_arg0:HasSpecialEffectId(TARGET_SELF, 3710040) then
            f27_arg1:ClearSubGoal()
            f27_arg1:AddSubGoal(GOAL_COMMON_EndureAttack, 0.3, 3102, TARGET_ENE_0, 9999, 0)
            f27_arg0:SetTimer(5, 60)
            return true
        elseif f27_local6 then
            f27_arg1:ClearSubGoal()
            f27_arg1:AddSubGoal(GOAL_COMMON_EndureAttack, 0.3, 3103, TARGET_ENE_0, 9999, 0)
            return true
        elseif f27_local5 then
            if f27_arg0:IsTargetGuard(TARGET_SELF) and ReturnKengekiSpecialEffect(f27_arg0) == false then
                return false
            elseif f27_local7 == 2 then
                return false
            elseif f27_local7 == 1 then
                if f27_local2 <= 50 then
                    f27_arg1:ClearSubGoal()
                    f27_arg1:AddSubGoal(GOAL_COMMON_SpinStep, 1, 5211, TARGET_ENE_0, 0, AI_DIR_TYPE_B, 0)
                    return true
                end
            elseif f27_local7 == 0 and f27_local2 <= 100 then
                f27_arg1:ClearSubGoal()
                f27_arg1:AddSubGoal(GOAL_COMMON_EndureAttack, 0.3, 3101, TARGET_ENE_0, 9999, 0)
                return true
            end
        elseif f27_arg0:HasSpecialEffectId(TARGET_ENE_0, 109980) then
            f27_arg1:ClearSubGoal()
            f27_arg1:AddSubGoal(GOAL_COMMON_SpinStep, 1, 5201, TARGET_ENE_0, 0, AI_DIR_TYPE_B, 0)
            return true
        elseif f27_local3 <= Get_ConsecutiveGuardCount(f27_arg0) * f27_arg2 then
            f27_arg1:ClearSubGoal()
            f27_arg1:AddSubGoal(GOAL_COMMON_EndureAttack, 0.3, 3101, TARGET_ENE_0, 9999, 0)
            return true
        else
            f27_arg1:ClearSubGoal()
            f27_arg1:AddSubGoal(GOAL_COMMON_EndureAttack, 0.3, 3100, TARGET_ENE_0, 9999, 0)
            return true
        end
    elseif f27_arg0:IsInsideTargetEx(TARGET_ENE_0, TARGET_SELF, AI_DIR_TYPE_F, 90, f27_local1 + 1) then
        if f27_local4 <= f27_arg3 then
            f27_arg1:ClearSubGoal()
            f27_arg1:AddSubGoal(GOAL_COMMON_SpinStep, 1, 5211, TARGET_ENE_0, 0, AI_DIR_TYPE_B, 0)
            return true
        else
            return false
        end
    else
        return false
    end
    
end

-- ========== 受伤反应系统 (Damage Reaction System) ==========
-- 功能：处理受到伤害时的反应，包括后退和反击 (Function: Handle reactions when taking damage, including retreat and counter-attacks)
-- 特点：基于随机概率和特殊状态选择不同的应对策略 (Features: Choose different response strategies based on random probability and special states)
Goal.Damaged = function (f28_arg0, f28_arg1, f28_arg2)
    local f28_local0 = f28_arg0:GetHpRate(TARGET_SELF)
    local f28_local1 = f28_arg0:GetDist(TARGET_ENE_0)
    local f28_local2 = f28_arg0:GetSp(TARGET_SELF)
    local f28_local3 = f28_arg0:GetRandam_Int(1, 100)
    local f28_local4 = 0
    local f28_local5 = 3
    if f28_local3 <= 15 then
        f28_arg1:ClearSubGoal()
        f28_arg1:AddSubGoal(GOAL_COMMON_SpinStep, f28_local5, 5201, TARGET_ENE_0, TurnTime, AI_DIR_TYPE_B, 0):TimingSetTimer(3, 6, UPDATE_SUCCESS)
        f28_arg0:SetNumber(2, 1)
        if f28_arg0:GetNumber(0) <= 3 then
            f28_arg0:SetNumber(0, 0)
        else
            f28_arg0:SetNumber(0, f28_arg0:GetNumber(0) - 3)
        end
        return true
    elseif f28_local3 <= 30 and f28_arg0:HasSpecialEffectId(TARGET_SELF, 200050) then
        f28_arg1:ClearSubGoal()
        f28_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3009, TARGET_ENE_0, 9999, 0)
        f28_arg0:SetNumber(2, 1)
        if f28_arg0:GetNumber(0) <= 3 then
            f28_arg0:SetNumber(0, 0)
        else
            f28_arg0:SetNumber(0, f28_arg0:GetNumber(0) - 3)
        end
        return true
    else
    end
    return false
    
end

Goal.ShootReaction = function (f29_arg0, f29_arg1)
    f29_arg1:ClearSubGoal()
    f29_arg1:AddSubGoal(GOAL_COMMON_EndureAttack, 0.1, 3100, TARGET_ENE_0, 9999, 0)
    return true
    
end

-- ========== 特殊剑击系统 (Special Sword Strike System) ==========
-- 功能：检查并激活特殊剑击技能，优先于普通战斗行为 (Function: Check and activate special sword strike skills, priority over normal combat behaviors)
-- 特点：多种剑击模式，根据特殊效果状态触发 (Features: Multiple sword strike modes triggered by special effect states)
Goal.Kengeki_Activate = function (f30_arg0, f30_arg1, f30_arg2, f30_arg3)
    -- 检查当前剑击特殊效果状态 (Check current sword strike special effect state)
    local f30_local0 = ReturnKengekiSpecialEffect(f30_arg1)
    if f30_local0 == 0 then
        return false  -- 无剑击特殊效果，返回false (No sword strike special effect, return false)
    end
    -- 初始化剑击系统参数 (Initialize sword strike system parameters)
    local f30_local1 = {}                                                 -- 剑击权重数组 (Sword strike weight array)
    local f30_local2 = {}                                                 -- 剑击函数数组 (Sword strike function array)
    local f30_local3 = {}                                                 -- 剑击子目标数组 (Sword strike sub-goal array)
    Common_Clear_Param(f30_local1, f30_local2, f30_local3)               -- 清理参数数组 (Clear parameter arrays)

    -- 获取战斗状态信息 (Get battle status information)
    local f30_local4 = f30_arg1:GetDist(TARGET_ENE_0)                     -- 与玩家距离 (Distance to player)
    local f30_local5 = f30_arg1:GetHpRate(TARGET_SELF)                    -- 自身血量率 (Self HP rate)
    local f30_local6 = f30_arg1:GetSpRate(TARGET_SELF)                    -- 自身SP率 (Self SP rate)
    -- 剑击模式1：特殊效果200200 (Sword Strike Mode 1: Special Effect 200200)
    if f30_local0 == 200200 then
        f30_arg1:SetNumber(0, f30_arg1:GetNumber(0) + 1)                  -- 增加剑击计数器 (Increment sword strike counter)

        if f30_local4 >= 2.5 then                                        -- 远距离剑击 (Long-range sword strike)
            f30_local1[50] = 100  -- 高权重远程剑击 (High weight long-range sword strike)

        elseif f30_arg1:GetNumber(0) >= 2 then                           -- 多次剑击后的组合攻击 (Combo attack after multiple sword strikes)
            f30_local1[3] = 60    -- 中等权重快攻 (Medium weight quick attack)
            f30_local1[20] = 60   -- 中等权重特殊攻击 (Medium weight special attack)
            f30_local1[30] = 5    -- 低权重辅助攻击 (Low weight auxiliary attack)
            f30_local1[38] = 50   -- 中等权重高级攻击 (Medium weight advanced attack)
            f30_local1[15] = 30   -- 低中权重初始攻击 (Low-medium weight initial attack)
            f30_local1[43] = 50   -- 中等权重特殊技能 (Medium weight special skill)
            f30_local1[39] = 30   -- 低中权重高级技能 (Low-medium weight advanced skill)

            -- 根据数字6状态选择不同的特殊攻击 (Choose different special attacks based on number 6 state)
            if f30_arg1:GetNumber(6) == 0 then
                f30_local1[32] = 20  -- 低权重特殊攻击32 (Low weight special attack 32)
            else
                f30_local1[33] = 20  -- 低权重特殊攻击33 (Low weight special attack 33)
            end

        elseif f30_arg1:GetNumber(3) == 0 then                           -- 首次特殊状态 (First special state)
            f30_local1[1] = 50    -- 中等权重基础攻击 (Medium weight basic attack)
        else                                                              -- 其他情况 (Other cases)
            f30_local1[4] = 100   -- 高权重特殊攻击 (High weight special attack)
        end
    elseif f30_local0 == 200201 then
        if f30_local4 >= 2.5 then
            f30_local1[50] = 100
        elseif f30_arg1:GetNumber(0) >= 2 then
            f30_local1[3] = 60
            f30_local1[20] = 60
            f30_local1[38] = 50
            f30_local1[15] = 30
            f30_local1[43] = 50
            f30_local1[39] = 30
            if f30_arg1:GetNumber(6) == 0 then
                f30_local1[32] = 50
            else
                f30_local1[33] = 50
            end
        elseif f30_arg1:GetNumber(3) == 0 then
            f30_local1[1] = 50
        else
            f30_local1[4] = 100
        end
    elseif f30_local0 == 200210 then
        f30_local1[2] = 100
        f30_local1[17] = 100
        f30_local1[38] = 50
        f30_local1[31] = 50
    elseif f30_local0 == 200211 then
        f30_local1[2] = 100
        f30_local1[10] = 50
        f30_local1[31] = 50
        f30_local1[38] = 50
    elseif f30_local0 == 200216 then
        if f30_local4 >= 2 then
            f30_local1[50] = 10
        else
            f30_arg1:SetNumber(0, f30_arg1:GetNumber(0) + 1)
            if f30_arg1:GetNumber(0) >= 3 then
                f30_local1[3] = 60
                f30_local1[20] = 20
                f30_local1[38] = 100
                f30_local1[43] = 50
                if f30_arg1:GetNumber(6) == 0 then
                    f30_local1[32] = 50
                else
                    f30_local1[33] = 50
                end
            else
                f30_local1[20] = 50
                if f30_arg1:GetNumber(3) == 0 then
                    f30_local1[1] = 50
                else
                    f30_local1[14] = 50
                end
            end
        end
    elseif f30_local0 == 200215 then
        if f30_local4 >= 2 then
            f30_local1[50] = 10
        else
            f30_arg1:SetNumber(0, f30_arg1:GetNumber(0) + 1)
            if f30_arg1:GetNumber(0) >= 3 then
                f30_local1[20] = 20
                f30_local1[38] = 30
                f30_local1[31] = 15
                f30_local1[43] = 10
                f30_local1[39] = 10
                if f30_arg1:GetNumber(6) == 0 then
                    f30_local1[32] = 50
                else
                    f30_local1[33] = 50
                end
            else
                f30_local1[20] = 50
                if f30_arg1:GetNumber(3) == 0 then
                    f30_local1[1] = 50
                else
                    f30_local1[14] = 50
                end
            end
        end
    end
    if f30_arg1:HasSpecialEffectId(TARGET_SELF, 200051) then
        f30_local1[3] = 0
        f30_local1[9] = 0
        f30_local1[15] = 0
        f30_local1[32] = 0
        f30_local1[33] = 0
        f30_local1[39] = 0
        f30_local1[46] = 0
    elseif f30_arg1:HasSpecialEffectId(TARGET_SELF, 200050) then
        f30_local1[20] = 0
    end
    if SpaceCheck(f30_arg1, f30_arg2, 45, 2) == false and SpaceCheck(f30_arg1, f30_arg2, -45, 2) == false then
        f30_local1[20] = 0
    end
    if f30_arg1:IsFinishTimer(6) == false then
        f30_local1[40] = 0
    elseif f30_arg1:IsFinishTimer(6) == true and f30_local5 <= 0.75 then
        f30_local1[40] = 50
    end
    f30_local1[1] = SetCoolTime(f30_arg1, f30_arg2, 3050, 8, f30_local1[1], 1)
    f30_local1[2] = SetCoolTime(f30_arg1, f30_arg2, 5201, 10, f30_local1[2], 1)
    f30_local1[3] = SetCoolTime(f30_arg1, f30_arg2, 3009, 10, f30_local1[3], 1)
    f30_local1[4] = SetCoolTime(f30_arg1, f30_arg2, 3055, 8, f30_local1[4], 1)
    f30_local1[7] = SetCoolTime(f30_arg1, f30_arg2, 3060, 8, f30_local1[7], 1)
    f30_local1[9] = SetCoolTime(f30_arg1, f30_arg2, 3018, 8, f30_local1[9], 1)
    f30_local1[10] = SetCoolTime(f30_arg1, f30_arg2, 3065, 8, f30_local1[10], 1)
    f30_local1[13] = SetCoolTime(f30_arg1, f30_arg2, 3075, 8, f30_local1[13], 1)
    f30_local1[14] = SetCoolTime(f30_arg1, f30_arg2, 3076, 8, f30_local1[14], 1)
    f30_local1[15] = SetCoolTime(f30_arg1, f30_arg2, 3031, 15, f30_local1[15], 1)
    f30_local1[17] = SetCoolTime(f30_arg1, f30_arg2, 3071, 8, f30_local1[17], 1)
    f30_local1[18] = SetCoolTime(f30_arg1, f30_arg2, 3004, 8, f30_local1[18], 1)
    f30_local1[20] = SetCoolTime(f30_arg1, f30_arg2, 5202, 15, f30_local1[20], 1)
    f30_local1[30] = SetCoolTime(f30_arg1, f30_arg2, 3063, 15, f30_local1[30], 1)
    f30_local1[31] = SetCoolTime(f30_arg1, f30_arg2, 3068, 15, f30_local1[31], 1)
    f30_local1[32] = SetCoolTime(f30_arg1, f30_arg2, 3018, 15, f30_local1[32], 1)
    f30_local1[33] = SetCoolTime(f30_arg1, f30_arg2, 3007, 15, f30_local1[33], 1)
    f30_local1[34] = SetCoolTime(f30_arg1, f30_arg2, 3037, 15, f30_local1[34], 1)
    f30_local1[35] = SetCoolTime(f30_arg1, f30_arg2, 3016, 8, f30_local1[35], 1)
    f30_local1[38] = SetCoolTime(f30_arg1, f30_arg2, 3030, 8, f30_local1[38], 1)
    f30_local1[39] = SetCoolTime(f30_arg1, f30_arg2, 3034, 15, f30_local1[39], 1)
    f30_local1[40] = SetCoolTime(f30_arg1, f30_arg2, 3028, 15, f30_local1[40], 1)
    f30_local1[41] = SetCoolTime(f30_arg1, f30_arg2, 3020, 15, f30_local1[41], 1)
    f30_local1[43] = SetCoolTime(f30_arg1, f30_arg2, 3062, 15, f30_local1[43], 1)
    f30_local1[44] = SetCoolTime(f30_arg1, f30_arg2, 3067, 15, f30_local1[44], 1)
    f30_local1[45] = SetCoolTime(f30_arg1, f30_arg2, 3032, 15, f30_local1[45], 1)
    f30_local2[1] = REGIST_FUNC(f30_arg1, f30_arg2, f30_arg0.Kengeki01)
    f30_local2[2] = REGIST_FUNC(f30_arg1, f30_arg2, f30_arg0.Kengeki02)
    f30_local2[3] = REGIST_FUNC(f30_arg1, f30_arg2, f30_arg0.Kengeki03)
    f30_local2[4] = REGIST_FUNC(f30_arg1, f30_arg2, f30_arg0.Kengeki04)
    f30_local2[5] = REGIST_FUNC(f30_arg1, f30_arg2, f30_arg0.Kengeki05)
    f30_local2[6] = REGIST_FUNC(f30_arg1, f30_arg2, f30_arg0.Kengeki06)
    f30_local2[7] = REGIST_FUNC(f30_arg1, f30_arg2, f30_arg0.Kengeki07)
    f30_local2[9] = REGIST_FUNC(f30_arg1, f30_arg2, f30_arg0.Kengeki09)
    f30_local2[10] = REGIST_FUNC(f30_arg1, f30_arg2, f30_arg0.Kengeki10)
    f30_local2[13] = REGIST_FUNC(f30_arg1, f30_arg2, f30_arg0.Kengeki13)
    f30_local2[14] = REGIST_FUNC(f30_arg1, f30_arg2, f30_arg0.Kengeki14)
    f30_local2[15] = REGIST_FUNC(f30_arg1, f30_arg2, f30_arg0.Kengeki15)
    f30_local2[17] = REGIST_FUNC(f30_arg1, f30_arg2, f30_arg0.Kengeki17)
    f30_local2[18] = REGIST_FUNC(f30_arg1, f30_arg2, f30_arg0.Kengeki18)
    f30_local2[19] = REGIST_FUNC(f30_arg1, f30_arg2, f30_arg0.Kengeki19)
    f30_local2[20] = REGIST_FUNC(f30_arg1, f30_arg2, f30_arg0.Kengeki20)
    f30_local2[21] = REGIST_FUNC(f30_arg1, f30_arg2, f30_arg0.Kengeki21)
    f30_local2[30] = REGIST_FUNC(f30_arg1, f30_arg2, f30_arg0.Kengeki30)
    f30_local2[31] = REGIST_FUNC(f30_arg1, f30_arg2, f30_arg0.Kengeki31)
    f30_local2[32] = REGIST_FUNC(f30_arg1, f30_arg2, f30_arg0.Kengeki32)
    f30_local2[33] = REGIST_FUNC(f30_arg1, f30_arg2, f30_arg0.Kengeki33)
    f30_local2[34] = REGIST_FUNC(f30_arg1, f30_arg2, f30_arg0.Kengeki34)
    f30_local2[35] = REGIST_FUNC(f30_arg1, f30_arg2, f30_arg0.Kengeki35)
    f30_local2[36] = REGIST_FUNC(f30_arg1, f30_arg2, f30_arg0.Kengeki36)
    f30_local2[37] = REGIST_FUNC(f30_arg1, f30_arg2, f30_arg0.Kengeki37)
    f30_local2[38] = REGIST_FUNC(f30_arg1, f30_arg2, f30_arg0.Kengeki38)
    f30_local2[39] = REGIST_FUNC(f30_arg1, f30_arg2, f30_arg0.Kengeki39)
    f30_local2[40] = REGIST_FUNC(f30_arg1, f30_arg2, f30_arg0.Kengeki40)
    f30_local2[41] = REGIST_FUNC(f30_arg1, f30_arg2, f30_arg0.Kengeki41)
    f30_local2[43] = REGIST_FUNC(f30_arg1, f30_arg2, f30_arg0.Kengeki43)
    f30_local2[44] = REGIST_FUNC(f30_arg1, f30_arg2, f30_arg0.Kengeki44)
    f30_local2[45] = REGIST_FUNC(f30_arg1, f30_arg2, f30_arg0.Kengeki45)
    f30_local2[46] = REGIST_FUNC(f30_arg1, f30_arg2, f30_arg0.Kengeki46)
    f30_local2[50] = REGIST_FUNC(f30_arg1, f30_arg2, f30_arg0.NoAction)
    local f30_local7 = REGIST_FUNC(f30_arg1, f30_arg2, f30_arg0.ActAfter_AdjustSpace)
    return Common_Kengeki_Activate(f30_arg1, f30_arg2, f30_local1, f30_local2, f30_local7, f30_local3)
    
end

-- ========== 剑击01：终结剑击 (Kengeki01: Finisher Sword Strike) ==========
-- 功能：执行终结性剑击攻击，清空所有子目标 (Function: Execute finisher sword strike attack, clear all sub-goals)
-- 特点：高优先级，会中断其他所有行为 (Features: High priority, interrupts all other behaviors)
Goal.Kengeki01 = function (f31_arg0, f31_arg1, f31_arg2)
    f31_arg0:SetNumber(3, 1)                                              -- 设置数字3为1，标记剑击执行 (Set number 3 to 1, mark sword strike execution)
    f31_arg1:ClearSubGoal()                                               -- 清空所有子目标 (Clear all sub-goals)
    -- 执行终结剑击（动画3050）(Execute finisher sword strike - animation 3050)
    f31_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3050, TARGET_ENE_0, 9999, 0, 0)
end

-- ========== 剑击02：后退旋转剑击 (Kengeki02: Backward Spinning Sword Strike) ==========
-- 功能：执行后退旋转攻击，带有SP条件检查和追击 (Function: Execute backward spinning attack with SP condition check and follow-up)
-- 特点：先执行5201后退攻击，SP≤70%时追加3044攻击 (Features: First execute 5201 backward attack, add 3044 attack when SP ≤ 70%)
-- 应用场景：防守反击中的特殊剑击技能 (Application: Special sword strike skill in defensive counter-attacks)
Goal.Kengeki02 = function (f32_arg0, f32_arg1, f32_arg2)
    local f32_local0 = f32_arg0:GetSpRate(TARGET_SELF)                -- 获取SP百分比 (Get SP percentage)
    f32_arg1:ClearSubGoal()                                            -- 清空所有子目标 (Clear all sub-goals)
    -- 执行后退旋转攻击5201，30秒冷却 (Execute backward spinning attack 5201, 30-second cooldown)
    f32_arg1:AddSubGoal(GOAL_COMMON_ComboRepeat, 10, 5201, TARGET_ENE_0, 9999, 0, 0):TimingSetTimer(3, 30, AI_TIMING_SET__UPDATE_SUCCESS)
    f32_arg0:SetNumber(2, 1)                                           -- 设置AI变量2为1，标记攻击状态 (Set AI variable 2 to 1, mark attack state)
    -- SP低于70%且有特殊效果200050时执行追击 (Execute follow-up attack when SP < 70% and has special effect 200050)
    if f32_local0 <= 0.7 and f32_arg0:HasSpecialEffectId(TARGET_SELF, 200050) then
        f32_arg1:AddSubGoal(GOAL_COMMON_ComboRepeat, 10, 3044, TARGET_ENE_0, DistToAtt1, TurnTime, FrontAngle, 0, 0)
    end
    
end

-- ========== 剑击03：空间感知旋转剑击 (Kengeki03: Space-Aware Spinning Sword Strike) ==========
-- 功能：基于空间检测的旋转攻击+侧向移动组合 (Function: Space detection-based spinning attack + lateral movement combination)
-- 特点：先执行3009旋转攻击，然后根据空间状况进行侧向移动 (Features: First execute 3009 spinning attack, then lateral movement based on space conditions)
-- 应用场景：需要空间感知的高级剑击技能 (Application: Advanced sword strike skill requiring space awareness)
Goal.Kengeki03 = function (f33_arg0, f33_arg1, f33_arg2)
    f33_arg1:ClearSubGoal()                                            -- 清空所有子目标 (Clear all sub-goals)
    -- 执行旋转攻击3009 (Execute spinning attack 3009)
    f33_arg1:AddSubGoal(GOAL_COMMON_ComboAttackTunableSpin, 10, 3009, TARGET_ENE_0, 999, 0, 0, 0, 0)
    local f33_local0 = 0                                               -- 侧向移动方向变量 (Lateral movement direction variable)
    if SpaceCheck(f33_arg0, f33_arg1, -90, 1) == true then
        if SpaceCheck(f33_arg0, f33_arg1, 90, 1) == true then
            if f33_arg0:IsInsideTargetEx(TARGET_ENE_0, TARGET_SELF, AI_DIR_TYPE_R, 180, 5) then
                f33_local0 = 1
            else
                f33_local0 = 0
            end
        else
            f33_local0 = 0
        end
    elseif SpaceCheck(f33_arg0, f33_arg1, 90, 1) == true then
        f33_local0 = 1
    else
        f33_local0 = 1
    end
    local f33_local1 = 4
    local f33_local2 = f33_arg0:GetRandam_Int(30, 45)
    f33_arg1:AddSubGoal(GOAL_COMMON_SidewayMove, f33_local1, TARGET_ENE_0, f33_local0, f33_local2, true, true, -1)
    
end

-- 剑击04：终结剑击3055 (Kengeki04: Finisher sword strike 3055)
Goal.Kengeki04 = function (f34_arg0, f34_arg1, f34_arg2)
    f34_arg0:SetNumber(3, 0)
    f34_arg1:ClearSubGoal()
    f34_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3055, TARGET_ENE_0, 9999, 0, 0)
    
end

-- 剑击07：终结剑击3060 (Kengeki07: Finisher sword strike 3060)
Goal.Kengeki07 = function (f35_arg0, f35_arg1, f35_arg2)
    f35_arg1:ClearSubGoal()
    f35_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3060, TARGET_ENE_0, 9999, 0, 0)
    
end

-- 剑击09：旋转连击3018+3015组合 (Kengeki09: Spinning combo 3018+3015 combination)
Goal.Kengeki09 = function (f36_arg0, f36_arg1, f36_arg2)
    f36_arg1:ClearSubGoal()
    f36_arg1:AddSubGoal(GOAL_COMMON_ComboAttackTunableSpin, 10, 3018, TARGET_ENE_0, 999, 0, 0, 0, 0)
    f36_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3015, TARGET_ENE_0, 9999, 0, 0)
    
end

-- 剑击10：终结剑击3065 (Kengeki10: Finisher sword strike 3065)
Goal.Kengeki10 = function (f37_arg0, f37_arg1, f37_arg2)
    f37_arg1:ClearSubGoal()
    f37_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3065, TARGET_ENE_0, 9999, 0, 0)
    
end

-- ========== 剑戟反应13：雷电攻击 (Kengeki Reaction 13: Lightning Attack) ==========
Goal.Kengeki13 = function (f38_arg0, f38_arg1, f38_arg2)
    f38_arg1:ClearSubGoal()  -- 清除当前子目标 (Clear current sub-goals)
    -- 执行雷电终结攻击3075 (Execute lightning final attack 3075)
    f38_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3075, TARGET_ENE_0, 9999, 0, 0)

end

-- ========== 剑戟反应14：风之攻击 (Kengeki Reaction 14: Wind Attack) ==========
Goal.Kengeki14 = function (f39_arg0, f39_arg1, f39_arg2)
    f39_arg1:ClearSubGoal()  -- 清除当前子目标 (Clear current sub-goals)
    -- 执行风之终结攻击3076 (Execute wind final attack 3076)
    f39_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3076, TARGET_ENE_0, 9999, 0, 0)

end

-- ========== 剑戟反应15：复杂连击序列 (Kengeki Reaction 15: Complex Combo Sequence) ==========
Goal.Kengeki15 = function (f40_arg0, f40_arg1, f40_arg2)
    local f40_local0 = 0
    local f40_local1 = 0
    local f40_local2 = 7.8 - f40_arg0:GetMapHitRadius(TARGET_SELF) + 2
    local f40_local3 = 0
    local f40_local4 = f40_arg0
    f40_local3 = f40_arg0.GetMapHitRadius
    f40_local3 = f40_local3(f40_local4, TARGET_SELF)
    f40_local3 = 2.5 - f40_local3
    f40_local4 = f40_arg0:GetRandam_Int(1, 100)
    local f40_local5 = f40_arg0:GetRandam_Int(1, 100)
    local f40_local6 = f40_arg0:GetSp(TARGET_SELF)
    local f40_local7 = f40_arg0:GetRandam_Int(30, 45)
    f40_arg1:ClearSubGoal()
    f40_arg1:AddSubGoal(GOAL_COMMON_ComboAttackTunableSpin, 10, 3031, TARGET_ENE_0, f40_local2, f40_local0, f40_local1, 0, 0)
    if f40_local4 <= 50 then
        f40_arg1:AddSubGoal(GOAL_COMMON_ComboRepeat, 10, 3019, TARGET_ENE_0, f40_local3, 0)
        f40_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3029, TARGET_ENE_0, 9999, 0, 0)
    else
        f40_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3036, TARGET_ENE_0, 9999, 0, 0)
    end
    if f40_local5 <= 50 then
        f40_arg0:SetNumber(2, 1)
    end
    
end

-- ========== 剑戟反应17：精准斩击 (Kengeki Reaction 17: Precise Strike) ==========
Goal.Kengeki17 = function (f41_arg0, f41_arg1, f41_arg2)
    f41_arg1:ClearSubGoal()  -- 清除当前子目标 (Clear current sub-goals)
    -- 执行精准终结攻击3071 (Execute precise final attack 3071)
    f41_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3071, TARGET_ENE_0, 9999, 0, 0)

end

-- ========== 剑戟反应18：基础反击 (Kengeki Reaction 18: Basic Counter) ==========
Goal.Kengeki18 = function (f42_arg0, f42_arg1, f42_arg2)
    f42_arg1:ClearSubGoal()  -- 清除当前子目标 (Clear current sub-goals)
    -- 执行基础反击攻击3004 (Execute basic counter attack 3004)
    f42_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3004, TARGET_ENE_0, 9999, 0, 0)

end

-- ========== 剑戟反应19：快速反击 (Kengeki Reaction 19: Quick Counter) ==========
Goal.Kengeki19 = function (f43_arg0, f43_arg1, f43_arg2)
    f43_arg1:ClearSubGoal()  -- 清除当前子目标 (Clear current sub-goals)
    -- 执行快速反击攻击3044 (Execute quick counter attack 3044)
    f43_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3044, TARGET_ENE_0, 9999, 0, 0)

end

-- ========== 剑戟反应20：空间感知后退反击 (Kengeki Reaction 20: Spatial Awareness Retreat Counter) ==========
Goal.Kengeki20 = function (f44_arg0, f44_arg1, f44_arg2)
    local f44_local0 = f44_arg0:GetDist(TARGET_ENE_0)  -- 与玩家距离 (Distance to player)
    local f44_local1 = 3      -- 后退步法持续时间 (Retreat step duration)
    local f44_local2 = 0      -- 移动方向标志 (Movement direction flag)

    -- 复杂的空间检查逻辑 (Complex spatial check logic)
    if SpaceCheck(f44_arg0, f44_arg1, -135, 1) == true then
        -- 检查-135度方向空间 (Check -135 degree direction space)
        if SpaceCheck(f44_arg0, f44_arg1, 135, 1) == true then
            -- 检查135度方向空间 (Check 135 degree direction space)
            if f44_arg0:IsInsideTarget(TARGET_ENE_0, AI_DIR_TYPE_R, 180) then
                f44_local2 = 1  -- 玩家在右侧，向右移动 (Player on right, move right)
            else
                f44_local2 = 0  -- 玩家在左侧，向左移动 (Player on left, move left)
            end
        else
            f44_local2 = 0      -- 135度方向受阻，向左移动 (135 degree blocked, move left)
        end
    elseif SpaceCheck(f44_arg0, f44_arg1, 90, 1) == true then
        -- 90度方向有空间，向右移动 (90 degree space available, move right)
        f44_local2 = 1
    else
        -- 无可用空间时的默认处理 (Default handling when no space available)
    end

    f44_arg1:ClearSubGoal()  -- 清除当前子目标 (Clear current sub-goals)
    -- 执行后退旋转步法5202 (Execute retreat spin step 5202)
    f44_arg1:AddSubGoal(GOAL_COMMON_SpinStep, f44_local1, 5202, TARGET_ENE_0, 0, AI_DIR_TYPE_B, 0)
    -- 执行终结攻击3007 (Execute final attack 3007)
    f44_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3007, TARGET_ENE_0, 9999, 0, 0)
    return GETWELLSPACE_ODDS  -- 返回空间检查权重 (Return space check weight)

end

-- ========== 剑戟反应21：标准反击 (Kengeki Reaction 21: Standard Counter) ==========
Goal.Kengeki21 = function (f45_arg0, f45_arg1, f45_arg2)
    f45_arg1:ClearSubGoal()  -- 清除当前子目标 (Clear current sub-goals)
    -- 执行标准反击攻击3010 (Execute standard counter attack 3010)
    f45_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3010, TARGET_ENE_0, 9999, 0, 0)

end

-- ========== 剑戟反应30：定时反击A (Kengeki Reaction 30: Timed Counter A) ==========
Goal.Kengeki30 = function (f46_arg0, f46_arg1, f46_arg2)
    f46_arg1:ClearSubGoal()  -- 清除当前子目标 (Clear current sub-goals)
    -- 执行定时终结攻击3063，设置10秒计时器 (Execute timed final attack 3063 with 10-second timer)
    f46_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3063, TARGET_ENE_0, 9999, 0, 0):TimingSetTimer(1, 10, AI_TIMING_SET__UPDATE_SUCCESS)
    f46_arg0:SetNumber(5, 0)  -- 重置计数器5 (Reset counter 5)

end

-- ========== 剑戟反应31：定时反击B (Kengeki Reaction 31: Timed Counter B) ==========
Goal.Kengeki31 = function (f47_arg0, f47_arg1, f47_arg2)
    f47_arg1:ClearSubGoal()  -- 清除当前子目标 (Clear current sub-goals)
    -- 执行定时终结攻击3068，设置10秒计时器 (Execute timed final attack 3068 with 10-second timer)
    f47_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3068, TARGET_ENE_0, 9999, 0, 0):TimingSetTimer(1, 10, AI_TIMING_SET__UPDATE_SUCCESS)
    f47_arg0:SetNumber(5, 0)  -- 重置计数器5 (Reset counter 5)

end

-- ========== 剑戟反应32：远距离连击 (Kengeki Reaction 32: Long Range Combo) ==========
Goal.Kengeki32 = function (f48_arg0, f48_arg1, f48_arg2)
    local f48_local0 = 0  -- 转向时间 (Turn time)
    local f48_local1 = 0  -- 正面角度 (Front angle)
    -- 计算最大攻击距离：999减去自身碰撞半径 (Calculate max attack distance: 999 minus self hit radius)
    local f48_local2 = 999 - f48_arg0:GetMapHitRadius(TARGET_SELF)
    local f48_local3 = 7 - f48_arg0:GetMapHitRadius(TARGET_SELF)  -- 终结攻击距离 (Final attack distance)
    f48_arg1:ClearSubGoal()  -- 清除当前子目标 (Clear current sub-goals)
    -- 执行连击起手攻击3018 (Execute combo starter attack 3018)
    f48_arg1:AddSubGoal(GOAL_COMMON_ComboAttackTunableSpin, 10, 3018, TARGET_ENE_0, f48_local2, f48_local0, f48_local1, 0, 0)
    -- 执行终结攻击3015 (Execute final attack 3015)
    f48_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3015, TARGET_ENE_0, 9999, 0, 0)
    f48_arg0:SetNumber(6, 1)  -- 设置状态计数器6 (Set state counter 6)

end

-- ========== 剑戟反应33：适应性连击 (Kengeki Reaction 33: Adaptive Combo) ==========
Goal.Kengeki33 = function (f49_arg0, f49_arg1, f49_arg2)
    local f49_local0 = 0  -- 转向时间 (Turn time)
    local f49_local1 = 0  -- 正面角度 (Front angle)
    local f49_local2 = 999 - f49_arg0:GetMapHitRadius(TARGET_SELF)   -- 起手攻击距离 (Starter attack distance)
    local f49_local3 = 7.8 - f49_arg0:GetMapHitRadius(TARGET_SELF)  -- 连击重复距离 (Combo repeat distance)
    local f49_local4 = 2.5 - f49_arg0:GetMapHitRadius(TARGET_SELF)  -- 备用距离 (Backup distance)
    local f49_local5 = f49_arg0:GetRandam_Int(1, 100)  -- 随机数决定连击分支 (Random number for combo branch)
    f49_arg1:ClearSubGoal()  -- 清除当前子目标 (Clear current sub-goals)
    -- 执行连击起手攻击3018 (Execute combo starter attack 3018)
    f49_arg1:AddSubGoal(GOAL_COMMON_ComboAttackTunableSpin, 10, 3018, TARGET_ENE_0, f49_local2, f49_local0, f49_local1, 0, 0)
    if f49_local5 <= 50 then
        -- 50%概率：执行完整连击序列 (50% chance: Execute full combo sequence)
        f49_arg1:AddSubGoal(GOAL_COMMON_ComboRepeat, 10, 3019, TARGET_ENE_0, f49_local3, 0)     -- 连击重处3019
        f49_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3029, TARGET_ENE_0, 9999, 0, 0)         -- 终结攻击3029
    else
        -- 50%概率：执行单一终结攻击 (50% chance: Execute single final attack)
        f49_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3019, TARGET_ENE_0, 9999, 0, 0)         -- 终结攻击3019
    end
    f49_arg0:SetNumber(6, 0)  -- 重置状态计数器6 (Reset state counter 6)

end

-- ========== 剑戟反应34：连击特化攻击 (Kengeki Reaction 34: Specialized Combo Attack) ==========
Goal.Kengeki34 = function (f50_arg0, f50_arg1, f50_arg2)
    f50_arg1:ClearSubGoal()  -- 清除当前子目标 (Clear current sub-goals)
    -- 执行连击重复攻击3037，6米范围 (Execute combo repeat attack 3037, 6-meter range)
    f50_arg1:AddSubGoal(GOAL_COMMON_ComboRepeat, 10, 3037, TARGET_ENE_0, 6, 0)
    -- 执行终结攻击3020 (Execute final attack 3020)
    f50_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3020, TARGET_ENE_0, 9999, 0, 0)

end

-- ========== 剑戟反应35：简单终结反击 (Kengeki Reaction 35: Simple Final Counter) ==========
Goal.Kengeki35 = function (f51_arg0, f51_arg1, f51_arg2)
    f51_arg1:ClearSubGoal()  -- 清除当前子目标 (Clear current sub-goals)
    -- 执行终结攻击3016 (Execute final attack 3016)
    f51_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3016, TARGET_ENE_0, 9999, 0, 0)
    f51_arg0:SetNumber(5, 0)  -- 重置计数器5 (Reset counter 5)

end

-- ========== 剑戟反应38：忍杀数量适应连击 (Kengeki Reaction 38: Ninsatsu Count Adaptive Combo) ==========
Goal.Kengeki38 = function (f52_arg0, f52_arg1, f52_arg2)
    local f52_local0 = 0  -- 转向时间 (Turn time)
    local f52_local1 = 0  -- 正面角度 (Front angle)
    local f52_local2 = f52_arg0:GetNinsatsuNum()  -- 获取当前忍杀数量 (Get current ninsatsu count)
    local f52_local3 = f52_arg0:GetRandam_Int(1, 100)  -- 随机数决定攻击类型 (Random number for attack type)
    f52_arg1:ClearSubGoal()  -- 清除当前子目标 (Clear current sub-goals)
    -- 执行连击起手攻击3030 (Execute combo starter attack 3030)
    f52_arg1:AddSubGoal(GOAL_COMMON_ComboAttackTunableSpin, 10, 3030, TARGET_ENE_0, 999, f52_local0, f52_local1, 0, 0)
    if f52_local2 <= 1 then
        -- 忍杀数量低时（1及以下）的攻击选择 (Attack selection when ninsatsu count is low (1 or below))
        if f52_local3 <= 75 then
            -- 75%概率执行攻击3067 (75% chance to execute attack 3067)
            f52_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3067, TARGET_ENE_0, 9999, 0, 0)
        else
            -- 25%概率执行攻击3025 (25% chance to execute attack 3025)
            f52_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3025, TARGET_ENE_0, 9999, 0, 0)
        end
    else
        -- 忍杀数量高时（2及以上）统一执行攻击3025 (When ninsatsu count is high (2 or above), always execute attack 3025)
        f52_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3025, TARGET_ENE_0, 9999, 0, 0)
    end

end

-- ========== 剑戟反应39：距离感知连续攻击 (Kengeki Reaction 39: Distance-Aware Continuous Attack) ==========
Goal.Kengeki39 = function (f53_arg0, f53_arg1, f53_arg2)
    local f53_local0 = 0  -- 转向时间 (Turn time)
    local f53_local1 = 0  -- 正面角度 (Front angle)
    local f53_local2 = 999 - f53_arg0:GetMapHitRadius(TARGET_SELF)  -- 最大攻击距离 (Maximum attack distance)
    local f53_local3 = f53_arg0:GetDist(TARGET_ENE_0)  -- 当前与目标距离 (Current distance to target)
    f53_arg1:ClearSubGoal()  -- 清除当前子目标 (Clear current sub-goals)
    -- 执行连击起手攻击3034 (Execute combo starter attack 3034)
    f53_arg1:AddSubGoal(GOAL_COMMON_ComboAttackTunableSpin, 10, 3034, TARGET_ENE_0, f53_local2, f53_local0, f53_local1, 0, 0)
    -- 执行连击重复攻击3036 (Execute combo repeat attack 3036)
    f53_arg1:AddSubGoal(GOAL_COMMON_ComboRepeat, 10, 3036, TARGET_ENE_0, 999, 0)
    -- 执行终结攻击3015 (Execute final attack 3015)
    f53_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3015, TARGET_ENE_0, 9999, 0, 0)

end

-- 剑击40 - 终结攻击技能 (Sword Strike 40 - Finishing Attack Skill)
-- 参数: f54_arg0=AI实体, f54_arg1=目标管理器, f54_arg2=状态参数
-- 功能: 执行攻击动作3028的终结攻击，设置50帧冷却时间
Goal.Kengeki40 = function (f54_arg0, f54_arg1, f54_arg2)
    f54_arg1:ClearSubGoal()  -- 清除当前所有子目标 (Clear all current sub-goals)
    -- 执行终结攻击3028，最大距离9999 (Execute final attack 3028 with max distance 9999)
    f54_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3028, TARGET_ENE_0, 9999, 0, 0)
    f54_arg0:SetTimer(6, 50)  -- 设置计时器6为50帧冷却 (Set timer 6 for 50 frames cooldown)

end

-- 剑击43 - 强力终结攻击 (Sword Strike 43 - Powerful Finishing Attack)
-- 参数: f55_arg0=AI实体, f55_arg1=目标管理器, f55_arg2=状态参数
-- 功能: 执行攻击动作3062的终结攻击，设置状态标记为激活状态
Goal.Kengeki43 = function (f55_arg0, f55_arg1, f55_arg2)
    f55_arg1:ClearSubGoal()  -- 清除当前所有子目标 (Clear all current sub-goals)
    -- 执行终结攻击3062，最大距离9999 (Execute final attack 3062 with max distance 9999)
    f55_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3062, TARGET_ENE_0, 9999, 0, 0)
    f55_arg0:SetNumber(2, 1)  -- 设置数值变量2为1，标记状态激活 (Set number variable 2 to 1, mark state as active)

end

-- 剑击44 - 高级终结攻击 (Sword Strike 44 - Advanced Finishing Attack)
-- 参数: f56_arg0=AI实体, f56_arg1=目标管理器, f56_arg2=状态参数
-- 功能: 执行攻击动作3067的终结攻击，设置状态标记为激活状态
Goal.Kengeki44 = function (f56_arg0, f56_arg1, f56_arg2)
    f56_arg1:ClearSubGoal()  -- 清除当前所有子目标 (Clear all current sub-goals)
    -- 执行终结攻击3067，最大距离9999 (Execute final attack 3067 with max distance 9999)
    f56_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3067, TARGET_ENE_0, 9999, 0, 0)
    f56_arg0:SetNumber(2, 1)  -- 设置数值变量2为1，标记状态激活 (Set number variable 2 to 1, mark state as active)

end

-- 剑击45 - 重置型终结攻击 (Sword Strike 45 - Reset Type Finishing Attack)
-- 参数: f57_arg0=AI实体, f57_arg1=目标管理器, f57_arg2=状态参数
-- 功能: 执行攻击动作3045的终结攻击，重置状态计数器为0
Goal.Kengeki45 = function (f57_arg0, f57_arg1, f57_arg2)
    f57_arg1:ClearSubGoal()  -- 清除当前所有子目标 (Clear all current sub-goals)
    -- 执行终结攻击3045，最大距离9999 (Execute final attack 3045 with max distance 9999)
    f57_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3045, TARGET_ENE_0, 9999, 0, 0)
    f57_arg0:SetNumber(0, 0)  -- 重置数值变量0为0，清零状态计数器 (Reset number variable 0 to 0, clear state counter)

end

-- 剑击46 - 组合攻击加侧移 (Sword Strike 46 - Combo Attack with Sidestep)
-- 参数: f58_arg0=AI实体, f58_arg1=目标管理器, f58_arg2=状态参数
-- 功能: 执行终结攻击后立即进行侧移，适用于攻击后的位置调整
Goal.Kengeki46 = function (f58_arg0, f58_arg1, f58_arg2)
    local f58_local0 = 0  -- 转向时间 (Turn time)
    local f58_local1 = 0  -- 正面角度 (Front angle)
    -- 计算有效攻击距离：基础距离7.8减去自身碰撞半径再加2 (Calculate effective attack distance)
    local f58_local2 = 7.8 - f58_arg0:GetMapHitRadius(TARGET_SELF) + 2
    local f58_local3 = 0  -- 随机数存储变量 (Random number storage variable)
    local f58_local4 = f58_arg0  -- AI实体引用 (AI entity reference)
    -- 获取1-100的随机数 (Get random number between 1-100)
    f58_local3 = f58_arg0.GetRandam_Int
    f58_local3 = f58_local3(f58_local4, 1, 100)
    f58_local4 = f58_arg0:GetSp(TARGET_SELF)  -- 获取自身SP值 (Get self SP value)
    -- 随机侧移角度30-45度 (Random sidestep angle 30-45 degrees)
    local f58_local5 = f58_arg0:GetRandam_Int(30, 45)
    f58_arg1:ClearSubGoal()  -- 清除当前所有子目标 (Clear all current sub-goals)
    -- 执行终结攻击3039，成功时设置计时器4为10帧 (Execute final attack 3039, set timer 4 to 10 frames on success)
    f58_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3039, TARGET_ENE_0, 9999, 0, 0):TimingSetTimer(4, 10, AI_TIMING_SET__UPDATE_SUCCESS)
    -- 攻击后执行2.5秒侧移，角度为随机值 (Execute 2.5s sidestep after attack with random angle)
    f58_arg1:AddSubGoal(GOAL_COMMON_SidewayMove, 2.5, TARGET_ENE_0, 0, f58_local5, true, true, -1)

end

-- 剑击47 - 快速终结攻击 (Sword Strike 47 - Quick Finishing Attack)
-- 参数: f59_arg0=AI实体, f59_arg1=目标管理器, f59_arg2=状态参数
-- 功能: 执行快速终结攻击3038，成功时设置短暂计时器，适用于快速连击场景
Goal.Kengeki47 = function (f59_arg0, f59_arg1, f59_arg2)
    f59_arg1:ClearSubGoal()  -- 清除当前所有子目标 (Clear all current sub-goals)
    -- 执行快速终结攻击3038，成功时设置计时器4为10帧 (Execute quick final attack 3038, set timer 4 to 10 frames on success)
    f59_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, 3038, TARGET_ENE_0, 9999, 0, 0):TimingSetTimer(4, 10, AI_TIMING_SET__UPDATE_SUCCESS)

end

-- ========== 辅助函数 (Auxiliary Functions) ==========

-- 无动作函数 - 返回-1表示不执行任何动作 (No action function - return -1 means no action)
Goal.NoAction = function (f60_arg0, f60_arg1, f60_arg2)
    return -1
end

-- 攻击后空间调整函数 - 用于攻击后的位置优化 (Post-attack space adjustment function - for position optimization after attacks)
Goal.ActAfter_AdjustSpace = function (f61_arg0, f61_arg1, f61_arg2)
    -- 暂无特定的空间调整逻辑 (No specific space adjustment logic currently)
end

-- 更新函数 - 使用默认更新逻辑 (Update function - uses default update logic)
Goal.Update = function (f62_arg0, f62_arg1, f62_arg2)
    return Update_Default_NoSubGoal(f62_arg0, f62_arg1, f62_arg2)
end

-- 终止函数 - 目标终止时的清理工作 (Terminate function - cleanup when goal terminates)
Goal.Terminate = function (f63_arg0, f63_arg1, f63_arg2)
    -- 暂无特定的清理逻辑 (No specific cleanup logic currently)
end

-- ================================================
-- 710000 劲敌 BOSS AI 分析总结 (710000 Rival BOSS AI Analysis Summary)
-- ================================================
--
-- 角色身份：剑圣级劲敌BOSS (Character Identity: Kensei-level Rival BOSS)
-- 复杂度：23个自定义ACT + 113次共享函数调用 (Complexity: 23 custom ACTs + 113 shared function calls)
--
-- 核心特点 (Core Features):
-- 1. 超高复杂度AI系统 (Ultra-high complexity AI system)
--    - 30+个专用行为函数，覆盖所有战斗场景 (30+ dedicated behavior functions covering all combat scenarios)
--    - 多层次决策树：特殊状态检查 → 距离分层 → 空间检查 → 冷却管理 (Multi-layered decision tree)
--
-- 2. 动态距离管理策略 (Dynamic Distance Management Strategy)
--    - 远距离(≥7m): 冲刺攻击 + 特殊技能 (Long-range: Charge attacks + Special skills)
--    - 中远距离(5-7m): 平衡攻击 + 能量技能 (Mid-long: Balanced attacks + Energy skills)
--    - 中距离(3-5m): 连击组合 + 灵活移动 (Medium: Combo sequences + Flexible movement)
--    - 近距离(≤3m): 快攻 + 后撤技巧 (Close: Quick attacks + Retreat techniques)
--
-- 3. 智能反制系统 (Intelligent Counter System)
--    - 反潜行：检测110010/110060效果，执行追击策略 (Anti-stealth: Detect stealth effects, execute pursuit)
--    - 反无敌：玩家无敌时切换为保守战术 (Anti-invincible: Switch to conservative tactics when player is invincible)
--    - 空间感知：实时监控四周空间，禁用不适合的攻击 (Spatial awareness: Real-time space monitoring)
--    - 观察区域：攻击后设置后方监控区域防止绕后 (Observation areas: Set rear monitoring to prevent flanking)
--
-- 4. 精密冷却管理 (Precise Cooldown Management)
--    - 每个攻击都有独立的15秒冷却时间 (Each attack has independent 15-second cooldown)
--    - Act48特殊对策技能仅5秒冷却，快速响应 (Act48 counter skill only 5-second cooldown for quick response)
--    - 多个计时器(0,1,3,6,7)同时运行防止重复 (Multiple timers running simultaneously to prevent repetition)
--
-- 5. 状态响应机制 (Status Response Mechanism)
--    - 爆发模式：数字2触发时，Act23权重飙升至6000 (Burst mode: When number 2 triggers, Act23 weight spikes to 6000)
--    - SP管理：低于360时激活高消耗技能 (SP management: Activate high-consumption skills when below 360)
--    - 特殊效果观察：监控10+种特殊效果状态 (Special effect observation: Monitor 10+ special effect states)
--
-- 6. 连击系统设计 (Combo System Design)
--    - Act01：双路径连击(30%概率3000→3001→3002→3003，70%概率3000→3001→3010→3025)
--    - Act09：能量连击(3040→3041)，设置30秒计时器防止滥用
--    - Act11：终结连击(3037→3020)，高伤害收尾技能
--
-- 7. 移动与定位策略 (Movement and Positioning Strategy)
--    - Act23/24：侧移和后撤攻击，需要空间检查支持
--    - Act27/28：特殊反制移动，针对潜行和特定状态
--    - Approach_Act_Flex：智能接近系统，根据距离动态调整移动参数
--
-- 战斗风格总结 (Combat Style Summary):
-- 这是一个极其智能和适应性强的BOSS AI，能够：
-- - 根据玩家行为实时调整策略
-- - 使用复杂的连击序列和空间控制
-- - 通过冷却管理保持攻击的多样性
-- - 利用观察系统预判玩家行动
--
-- 此AI代表了Sekiro中最高水平的战斗人工智能设计。
-- This AI represents the highest level of combat artificial intelligence design in Sekiro.
-- ================================================

