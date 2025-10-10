--[[============================================================================
    common_func2.lua - Sekiro AI通用行为函数库扩展 (Sekiro AI Common Behavior Function Library Extension)

    版本信息 (Version Info): v3.0 - Comprehensive documentation upgrade
    作者 (Author): FromSoftware AI Team / Enhanced by Claude Code
    最后修改 (Last Modified): 2025-09-28
    编码格式 (Encoding): Shift-JIS (required for Sekiro compatibility)

    ============================================================================
    模块概述 (Module Overview):
    ============================================================================
    这是Sekiro AI系统的扩展通用行为函数库，专注于具体的战斗行为实现。
    该模块提供了武器切换、移动控制、反应行为、状态处理等高级AI功能。

    核心功能模块 (Core Function Modules):
    ┌─ 武器管理系统 (Weapon Management System)
    │  ├─ CommonNPC_ChangeWepL1/L2() - 左手武器切换
    │  ├─ CommonNPC_ChangeWepR1/R2() - 右手武器切换
    │  └─ 双手/单手模式切换控制
    │
    ├─ 反应行为系统 (Reactive Behavior System)
    │  ├─ FindAttack_*() - 发现攻击时的反应
    │  ├─ Damaged_*() - 受伤时的反应
    │  ├─ GuardBreak_*() - 架势破坏时的反应
    │  └─ Parry_*() - 弹反相关行为
    │
    ├─ 移动控制系统 (Movement Control System)
    │  ├─ Approach_*() - 接近目标行为
    │  ├─ GetWellSpace_*() - 空间调整行为
    │  └─ Torimaki/Kankyaku_Act() - 团队协作移动
    │
    └─ 选择算法系统 (Selection Algorithm System)
       ├─ SelectFunc() - 基于权重的选择算法
       └─ CallAttackAndAfterFunc() - 攻击执行和后续处理

    ============================================================================
    使用注意事项 (Important Usage Notes):
    ============================================================================
    - 所有函数都是实时执行，避免在主循环中频繁调用复杂函数
    - 中断处理函数需要快速执行，避免阻塞AI主逻辑
    - 随机数生成使用AI内置函数，确保可重现性
    - 距离和角度计算基于游戏内部坐标系统
    ============================================================================
]]--

--[[============================================================================
    武器管理系统 (Weapon Management System)
    ============================================================================
]]--

-- NPC左手主武器切换函数 (NPC left hand primary weapon switch function)
-- 功能说明 (Function Description):
--   检查NPC当前左手装备的武器，如果不是主武器则执行切换动作。
--   这是AI武器管理的基础函数，确保NPC在需要时装备正确的武器。
--
-- 参数说明 (Parameters):
--   f1_arg0: AI实体对象 (AI entity object) - 需要切换武器的AI角色
--   f1_arg1: 目标管理器 (Goal manager) - AI行为目标管理器
--
-- 武器切换逻辑 (Weapon Switch Logic):
--   1. 获取当前左手装备的武器索引
--   2. 与主武器索引(WEP_Primary)进行比较
--   3. 如果不匹配，则添加武器切换子目标
--
-- 使用场景 (Usage Scenarios):
--   - 战斗开始前的武器准备
--   - 特定攻击需要指定武器时
--   - 武器损坏或失效后的应急切换
--
-- 注意事项 (Notes):
--   - 切换动作有一定的执行时间，期间AI无法执行其他动作
--   - 切换失败不会产生错误，但可能影响后续攻击效果
function CommonNPC_ChangeWepL1(f1_arg0, f1_arg1)
    local f1_local0 = f1_arg0:GetEquipWeaponIndex(ARM_L)  -- 获取左手当前装备武器索引 (Get current left hand weapon index)
    if WEP_Primary ~= f1_local0 then                      -- 检查是否为主武器 (Check if it's primary weapon)
        -- 添加左手主武器切换目标 (Add left hand primary weapon switch goal)
        f1_arg1:AddSubGoal(GOAL_COMMON_Attack, 10, NPC_ATK_ChangeWep_L1, TARGET_NONE, DIST_None)
    end
end

-- NPC右手主武器切换函数 (NPC right hand primary weapon switch function)
-- 功能说明 (Function Description):
--   检查并切换NPC右手武器到主武器。右手通常是主要攻击武器，
--   此函数确保AI在关键时刻装备最有效的武器。
--
-- 参数说明 (Parameters):
--   f2_arg0: AI实体对象 (AI entity object) - 执行武器切换的AI角色
--   f2_arg1: 目标管理器 (Goal manager) - 管理AI行为目标的对象
--
-- 右手武器特点 (Right Hand Weapon Characteristics):
--   - 通常为主要伤害输出武器
--   - 攻击力和攻击速度通常优于左手武器
--   - 大多数连击和特殊攻击依赖右手武器
function CommonNPC_ChangeWepR1(f2_arg0, f2_arg1)
    local f2_local0 = f2_arg0:GetEquipWeaponIndex(ARM_R)  -- 获取右手当前装备武器索引 (Get current right hand weapon index)
    if WEP_Primary ~= f2_local0 then                      -- 检查是否为主武器 (Check if it's primary weapon)
        -- 添加右手主武器切换目标 (Add right hand primary weapon switch goal)
        f2_arg1:AddSubGoal(GOAL_COMMON_Attack, 10, NPC_ATK_ChangeWep_R1, TARGET_NONE, DIST_None)
    end
end

-- NPC左手副武器切换函数 (NPC left hand secondary weapon switch function)
-- 功能说明 (Function Description):
--   将NPC左手武器切换为副武器。副武器通常具有特殊功能，
--   如防护、特殊攻击或支援能力。
--
-- 参数说明 (Parameters):
--   f3_arg0: AI实体对象 (AI entity object) - 需要切换武器的AI角色
--   f3_arg1: 目标管理器 (Goal manager) - AI行为目标管理器
--
-- 副武器应用场景 (Secondary Weapon Usage Scenarios):
--   - 防御型武器：盾牌、护手等
--   - 特殊攻击武器：投掷物、法术道具等
--   - 辅助工具：钩锁、特殊机关等
--
-- 战术考虑 (Tactical Considerations):
--   - 副武器切换通常在特定战斗阶段进行
--   - 某些副武器可能有使用次数限制
--   - 切换时机需要考虑当前战斗节奏
function CommonNPC_ChangeWepL2(f3_arg0, f3_arg1)
    local f3_local0 = f3_arg0:GetEquipWeaponIndex(ARM_L)  -- 获取左手当前装备武器索引 (Get current left hand weapon index)
    if WEP_Secondary ~= f3_local0 then                    -- 检查是否为副武器 (Check if it's secondary weapon)
        -- 添加左手副武器切换目标 (Add left hand secondary weapon switch goal)
        f3_arg1:AddSubGoal(GOAL_COMMON_Attack, 10, NPC_ATK_ChangeWep_L2, TARGET_NONE, DIST_None)
    end
end

-- NPC右手副武器切换函数 (NPC right hand secondary weapon switch function)
-- 功能说明 (Function Description):
--   将NPC右手武器切换为副武器。右手副武器通常是备用攻击武器
--   或具有特殊战术功能的装备。
--
-- 参数说明 (Parameters):
--   f4_arg0: AI实体对象 (AI entity object) - 执行武器切换的AI角色
--   f4_arg1: 目标管理器 (Goal manager) - 管理AI行为目标的对象
--
-- 右手副武器特性 (Right Hand Secondary Weapon Characteristics):
--   - 可能是远程武器（弓箭、投掷武器）
--   - 特殊攻击武器（毒刃、火焰武器）
--   - 备用近战武器（不同攻击模式）
--   - 防御反击武器（带反击能力的武器）
function CommonNPC_ChangeWepR2(f4_arg0, f4_arg1)
    local f4_local0 = f4_arg0:GetEquipWeaponIndex(ARM_R)  -- 获取右手当前装备武器索引 (Get current right hand weapon index)
    if WEP_Secondary ~= f4_local0 then                    -- 检查是否为副武器 (Check if it's secondary weapon)
        -- 添加右手副武器切换目标 (Add right hand secondary weapon switch goal)
        f4_arg1:AddSubGoal(GOAL_COMMON_Attack, 10, NPC_ATK_ChangeWep_R2, TARGET_NONE, DIST_None)
    end
end

-- NPC双手持握模式切换函数 (NPC both hands grip mode switch function)
-- 功能说明 (Function Description):
--   将NPC切换到双手持握模式。双手模式通常提供更高的攻击力和
--   更强的攻击稳定性，但可能牺牲防御能力。
--
-- 参数说明 (Parameters):
--   f5_arg0: AI实体对象 (AI entity object) - 需要切换握持模式的AI角色
--   f5_arg1: 目标管理器 (Goal manager) - AI行为目标管理器
--
-- 双手模式优势 (Both Hands Mode Advantages):
--   - 攻击力提升：通常比单手模式伤害更高
--   - 击破能力：更容易破坏敌人防御
--   - 攻击范围：某些武器双手模式有更大攻击范围
--   - 特殊攻击：解锁双手专用攻击动作
--
-- 双手模式劣势 (Both Hands Mode Disadvantages):
--   - 防御减弱：无法使用左手盾牌等防御装备
--   - 灵活性降低：攻击速度可能变慢
--   - 消耗增加：体力消耗通常更大
--
-- 切换时机 (Switch Timing):
--   - 敌人防御较强时
--   - 需要最大伤害输出时
--   - 执行特殊攻击组合时
function CommonNPC_SwitchBothHandMode(f5_arg0, f5_arg1)
    if not f5_arg0:IsBothHandMode(TARGET_SELF) then       -- 检查当前是否为双手模式 (Check if currently in both hands mode)
        -- 添加武器握持模式切换目标 (Add weapon grip mode switch goal)
        f5_arg1:AddSubGoal(GOAL_COMMON_Attack, 10, NPC_ATK_SwitchWep, TARGET_NONE, DIST_None)
    end
end

-- NPC单手持握模式切换函数 (NPC one hand grip mode switch function)
-- 功能说明 (Function Description):
--   将NPC从双手模式切换回单手模式。单手模式提供更好的防御能力
--   和更高的攻击频率，适合灵活战斗。
--
-- 参数说明 (Parameters):
--   f6_arg0: AI实体对象 (AI entity object) - 需要切换握持模式的AI角色
--   f6_arg1: 目标管理器 (Goal manager) - AI行为目标管理器
--
-- 单手模式优势 (One Hand Mode Advantages):
--   - 防御灵活：可使用左手盾牌或副武器防御
--   - 攻击速度：通常比双手模式攻击更快
--   - 移动灵活：更好的移动和闪避能力
--   - 组合攻击：左右手武器可进行组合攻击
--
-- 单手模式应用 (One Hand Mode Applications):
--   - 面对快速敌人时
--   - 需要频繁防御时
--   - 多敌人战斗时
--   - 需要保持机动性时
--
-- 切换条件判断 (Switch Condition Check):
--   - 仅在当前为双手模式时执行切换
--   - 避免重复切换动作
function CommonNPC_SwitchOneHandMode(f6_arg0, f6_arg1)
    if f6_arg0:IsBothHandMode(TARGET_SELF) then           -- 检查当前是否为双手模式 (Check if currently in both hands mode)
        -- 添加武器握持模式切换目标 (Add weapon grip mode switch goal)
        f6_arg1:AddSubGoal(GOAL_COMMON_Attack, 10, NPC_ATK_SwitchWep, TARGET_NONE, DIST_None)
    end
end

--[[============================================================================
    移动和接近行为系统 (Movement and Approach Behavior System)
    ============================================================================
]]--

-- NPC智能接近行为函数 (NPC intelligent approach behavior function)
-- 功能说明 (Function Description):
--   控制NPC以最优方式接近目标。该函数会根据当前距离自动选择冲刺或普通移动，
--   并可以配置使用特殊移动动作来提高接近效率和战术多样性。
--
-- 参数说明 (Parameters):
--   f7_arg0: AI实体对象 (AI entity object) - 执行接近行为的AI角色
--   f7_arg1: 目标管理器 (Goal manager) - AI行为目标管理器
--   f7_arg2: 目标距离 (Target distance) - 接近的目标距离（游戏单位）
--   f7_arg3: 冲刺阈值距离 (Dash threshold distance) - 超过此距离启用冲刺
--   f7_arg4: 特殊动作概率 (Special action probability) - 使用特殊移动动作的概率（0-100）
--
-- 算法逻辑 (Algorithm Logic):
--   1. 重置冲刺状态，确保干净的移动状态
--   2. 根据概率决定是否使用特殊移动动作（如翻滚、跳跃等）
--   3. 测量与目标的当前距离
--   4. 距离判断：超过阈值使用冲刺+长时间接近，否则使用普通短时间接近
--
-- 移动策略 (Movement Strategy):
--   远距离（>阈值）: 启用冲刺 + 10秒持续接近 + 可能的特殊动作
--   近距离（≤阈值）: 普通移动 + 5秒快速接近 + 可能的特殊动作
--
-- 特殊动作说明 (Special Action Description):
--   当f7_local0 = 4时，AI会在接近过程中随机执行特殊移动动作，
--   如翻滚、侧步、跳跃等，增加接近过程的不可预测性。
--
-- 使用场景 (Usage Scenarios):
--   - 战斗开始时的初始接近
--   - 敌人逃跑后的重新接近
--   - 需要快速缩短距离的战术移动
--   - 与远程攻击结合的距离控制
function NPC_Approach_Act(f7_arg0, f7_arg1, f7_arg2, f7_arg3, f7_arg4)
    f7_arg0:EndDash()                                     -- 结束当前冲刺状态，重置移动模式 (End current dash state, reset movement mode)
    local f7_local0 = -1                                 -- 特殊动作标识符初始化 (Special action identifier initialization)
    local f7_local1 = f7_arg0:GetRandam_Int(1, 100)     -- 生成随机数用于特殊动作判定 (Generate random number for special action check)

    -- 特殊动作概率判定 (Special action probability check)
    if f7_local1 <= f7_arg4 then
        f7_local0 = 4                                     -- 启用特殊移动动作 (Enable special movement actions)
    end

    local f7_local2 = f7_arg0:GetDist(TARGET_ENE_0)      -- 获取与主要敌人的当前距离 (Get current distance to primary enemy)

    -- 距离判断和移动策略选择 (Distance judgment and movement strategy selection)
    if f7_arg3 <= f7_local2 then
        -- 远距离策略：启用冲刺快速接近 (Long distance strategy: enable dash for rapid approach)
        f7_arg0:StartDash()                               -- 开始冲刺移动 (Start dash movement)
        f7_arg1:AddSubGoal(GOAL_COMMON_ApproachTarget, 10, TARGET_ENE_0, f7_arg2, TARGET_SELF, false, f7_local0)
    else
        -- 近距离策略：普通速度精准接近 (Short distance strategy: normal speed precise approach)
        f7_arg1:AddSubGoal(GOAL_COMMON_ApproachTarget, 5, TARGET_ENE_0, f7_arg2, TARGET_SELF, false, f7_local0)
    end
end

--[[============================================================================
    战斗模式切换系统 (Combat Mode Switch System)
    ============================================================================
]]--

-- NPC单手（片手）模式切换函数 (NPC one-hand (katate) mode switch function)
-- 功能说明 (Function Description):
--   检查并将NPC从双手持握模式切换到单手持握模式。单手模式在日语中称为"片手"（katate），
--   提供更好的灵活性和防御能力，适合需要频繁格挡和反击的战斗情况。
--
-- 参数说明 (Parameters):
--   f8_arg0: AI实体对象 (AI entity object) - 需要切换持握模式的AI角色
--   f8_arg1: 目标管理器 (Goal manager) - AI行为目标管理器
--
-- 单手模式特点 (One-Hand Mode Characteristics):
--   - 攻击速度：通常比双手模式更快
--   - 防御能力：可以使用盾牌或副武器进行防御
--   - 灵活性：更好的移动和闪避能力
--   - 组合攻击：可以进行左右手武器的组合攻击
--   - 消耗：体力消耗通常较低
--
-- 与双手模式对比 (Comparison with Two-Hand Mode):
--   单手模式 vs 双手模式：
--   - 攻击力：较低 vs 较高
--   - 攻击速度：较快 vs 较慢
--   - 防御：较强 vs 较弱
--   - 灵活性：较高 vs 较低
--   - 破防能力：较弱 vs 较强
--
-- 切换时机选择 (Switch Timing Selection):
--   - 面对快速攻击的敌人时
--   - 需要频繁格挡和反击时
--   - 多敌人战斗需要机动性时
--   - 体力不足需要降低消耗时
--
-- 技术实现细节 (Technical Implementation Details):
--   使用NonspinningComboAttack确保切换动作不会被意外的旋转攻击打断，
--   保证切换过程的稳定性和可靠性。
function NPC_KATATE_Switch(f8_arg0, f8_arg1)
    if f8_arg0:IsBothHandMode(TARGET_SELF) then           -- 检查当前是否为双手模式 (Check if currently in both hands mode)
        -- 添加单手模式切换目标，使用非旋转连击攻击确保稳定性 (Add one-hand mode switch goal with non-spinning combo attack for stability)
        f8_arg1:AddSubGoal(GOAL_COMMON_NonspinningComboAttack, 10, NPC_ATK_SwitchWep, TARGET_ENE_0, DIST_None, 0)
    end
end

-- NPC双手（两手）模式切换函数 (NPC both-hands (ryoute) mode switch function)
-- 功能说明 (Function Description):
--   检查并将NPC从单手持握模式切换到双手持握模式。双手模式在日语中称为"両手"（ryoute），
--   提供更高的攻击力和破防能力，适合需要强力攻击突破敌人防御的战斗情况。
--
-- 参数说明 (Parameters):
--   f9_arg0: AI实体对象 (AI entity object) - 需要切换持握模式的AI角色
--   f9_arg1: 目标管理器 (Goal manager) - AI行为目标管理器
--
-- 双手模式优势 (Both-Hands Mode Advantages):
--   - 攻击力：显著提升，通常有1.5倍伤害加成
--   - 破防能力：更容易破坏敌人的防御姿态
--   - 攻击范围：某些武器双手模式有更大攻击范围
--   - 特殊攻击：解锁双手专用的强力攻击动作
--   - 击退效果：更强的击退和硬直效果
--
-- 双手模式劣势 (Both-Hands Mode Disadvantages):
--   - 攻击速度：通常比单手模式慢
--   - 防御能力：无法使用盾牌，防御选择有限
--   - 灵活性：移动和闪避能力下降
--   - 体力消耗：攻击消耗更多体力
--   - 恢复时间：攻击后的恢复时间更长
--
-- 最佳使用场景 (Optimal Usage Scenarios):
--   - 敌人防御力很强需要破防时
--   - 对付重甲敌人时
--   - 需要最大伤害输出时
--   - 执行终结攻击时
--   - 对付大型BOSS时
--
-- 风险评估 (Risk Assessment):
--   切换到双手模式会暂时降低防御能力，因此需要在安全的时机进行切换，
--   或者确保有足够的攻击机会来弥补防御上的损失。
function NPC_RYOUTE_Switch(f9_arg0, f9_arg1)
    if not f9_arg0:IsBothHandMode(TARGET_SELF) then       -- 检查当前是否为单手模式 (Check if currently in one hand mode)
        -- 添加双手模式切换目标，使用非旋转连击攻击确保稳定性 (Add both-hands mode switch goal with non-spinning combo attack for stability)
        f9_arg1:AddSubGoal(GOAL_COMMON_NonspinningComboAttack, 10, NPC_ATK_SwitchWep, TARGET_ENE_0, DIST_None, 0)
    end
end

--[[============================================================================
    受伤反应系统 (Damage Response System)
    ============================================================================
]]--

-- NPC对玩家受伤时的步伐反击函数 (NPC step counter-attack function when damaged by player)
-- 功能说明 (Function Description):
--   当NPC受到伤害时，根据距离和概率判断执行闪避步伐并进行反击。
--   这是一个高级的反应系统，能够让AI在受到攻击后做出灵活的战术反应。
--
-- 参数说明 (Parameters):
--   f10_arg0: AI实体对象 (AI entity object) - 受伤的AI角色
--   f10_arg1: 目标管理器 (Goal manager) - AI行为目标管理器
--   f10_arg2: 触发距离 (Trigger distance) - 可以执行反应的最大距离
--   f10_arg3: 反应概率 (Response probability) - 执行反应的概率（0-100）
--   f10_arg4: 反击概率 (Counter-attack probability) - 步伐后进行反击的概率
--   f10_arg5: 反击攻击 ID (Counter-attack ID) - 反击使用的攻击动作 ID
--   f10_arg6: 后蹲步伐概率 (Back step probability) - 向后闪避的概率
--   f10_arg7: 左步伐概率 (Left step probability) - 向左闪避的概率
--   f10_arg8: 右步伐概率 (Right step probability) - 向右闪避的概率（自动计算）
--
-- 返回值 (Return Value):
--   true:  成功执行了受伤反应，调用方应停止当前行为
--   false: 未满足执行条件，继续当前行为（隐式返回）
--
-- 反应算法流程 (Response Algorithm Flow):
--   1. 检查受伤中断标志：确认正在受到伤害
--   2. 距离验证：确保与敌人距离在可反应范围内
--   3. 概率判定：根据反应概率决定是否执行
--   4. 清空当前目标：停止正在进行的行为
--   5. 步伐方向选择：根据概率分配选择后、左、右步伐
--   6. 反击决定：根据反击概率决定是否执行追击
--
-- 步伐方向算法 (Step Direction Algorithm):
--   后步伐: 0 ~ f10_arg6
--   左步伐: f10_arg6 ~ (f10_arg6 + f10_arg7)
--   右步伐: (f10_arg6 + f10_arg7) ~ 100
--
-- 战术考虑 (Tactical Considerations):
--   - 后步伐：安全但可能失去反击机会
--   - 侧步伐：保持攻击距离，更容易进行反击
--   - 反击选择：中距离攻击适合大多数情况
--
-- 使用场景 (Usage Scenarios):
--   - 面对攻击性强的玩家时
--   - 需要在受伤后立即反击的AI
--   - 实现高难度的战斗AI行为
function Damaged_StepCount_NPCPlayer(f10_arg0, f10_arg1, f10_arg2, f10_arg3, f10_arg4, f10_arg5, f10_arg6, f10_arg7, f10_arg8)
    local f10_local0 = f10_arg0:GetDist(TARGET_ENE_0)     -- 获取与主要敌人的距离 (Get distance to primary enemy)
    local f10_local1 = f10_arg0:GetRandam_Int(1, 100)    -- 反应执行概率判定 (Response execution probability check)
    local f10_local2 = f10_arg0:GetRandam_Int(1, 100)    -- 步伐方向选择随机数 (Step direction selection random number)
    local f10_local3 = f10_arg0:GetRandam_Int(1, 100)    -- 反击执行概率判定 (Counter-attack execution probability check)

    -- 受伤反应条件检查 (Damage response condition check)
    if f10_arg0:IsInterupt(INTERUPT_Damaged) and f10_local0 < f10_arg2 and f10_local1 <= f10_arg3 then
        f10_arg1:ClearSubGoal()                           -- 清空当前所有子目标 (Clear all current sub-goals)

        -- 步伐方向选择逻辑 (Step direction selection logic)
        if f10_local2 <= f10_arg6 then
            -- 执行后步伐：向后闪避，安全但可能失去攻击机会 (Execute back step: retreat safely but may lose attack opportunity)
            f10_arg1:AddSubGoal(GOAL_COMMON_Attack, 10, NPC_ATK_StepB, TARGET_ENE_0, DIST_None, 0)
        elseif f10_local2 <= f10_arg6 + f10_arg7 then
            -- 执行左步伐：向左闪避，保持侧面优势 (Execute left step: evade left, maintain side advantage)
            f10_arg1:AddSubGoal(GOAL_COMMON_Attack, 10, NPC_ATK_StepL, TARGET_ENE_0, DIST_None, 0)
        else
            -- 执行右步伐：向右闪避，保持侧面优势 (Execute right step: evade right, maintain side advantage)
            f10_arg1:AddSubGoal(GOAL_COMMON_Attack, 10, NPC_ATK_StepR, TARGET_ENE_0, DIST_None, 0)
        end

        -- 反击执行决定 (Counter-attack execution decision)
        if f10_local3 <= f10_arg4 then
            -- 添加反击连击攻击，使用中距离攻击模式 (Add counter-attack combo, using medium distance attack mode)
            f10_arg1:AddSubGoal(GOAL_COMMON_ComboAttack, 10, f10_arg5, TARGET_ENE_0, DIST_Middle, 0)
        end
        return true                                       -- 返回true表示成功处理了受伤事件 (Return true indicating successful damage event handling)
    end
    -- 未满足反应条件，隐式返回false（无return语句）(Conditions not met, implicitly return false)
end

--[[============================================================================
    攻击发现反应系统 (Attack Detection Response System)
    ============================================================================
]]--

-- NPC对玩家发现攻击时的步伐反应函数 (NPC step response function when detecting player attack)
-- 功能说明 (Function Description):
--   当NPC检测到玩家即将或正在发动攻击时，根据距离和概率判断执行预判性的闪避步伐。
--   这是一个预防性的反应系统，能够让AI在敌人攻击之前就做出闪避反应。
--
-- 参数说明 (Parameters):
--   f11_arg0: AI实体对象 (AI entity object) - 执行反应的AI角色
--   f11_arg1: 目标管理器 (Goal manager) - AI行为目标管理器
--   f11_arg2: 触发距离 (Trigger distance) - 可以执行反应的最大距离
--   f11_arg3: 反应概率 (Response probability) - 执行反应的概率（0-100）
--   f11_arg4: 后蹲步伐概率 (Back step probability) - 向后闪避的概率
--   f11_arg5: 左步伐概率 (Left step probability) - 向左闪避的概率
--   f11_arg6: 右步伐概率 (Right step probability) - 向右闪避的概率（自动计算）
--
-- 返回值 (Return Value):
--   true:  成功执行了预判闪避，调用方应停止当前行为
--   false: 未满足执行条件，继续当前行为（隐式返回）
--
-- 与 Damaged_StepCount_NPCPlayer 的区别 (Difference from Damaged_StepCount_NPCPlayer):
--   - 发现攻击 vs 受到伤害：主动预防 vs 被动反应
--   - 不包含反击逻辑：仅专注于闪避
--   - 更早的触发时机：在攻击命中之前就能反应
--   - 更高的防御性：降低受到伤害的概率
--
-- 算法流程 (Algorithm Flow):
--   1. 检查攻击发现中断：确认检测到敌人的攻击意图
--   2. 距离验证：确保在可反应范围内
--   3. 概率判定：根据反应概率决定是否执行
--   4. 清空当前目标：中断当前行为
--   5. 步伐方向选择：选择最优的闪避方向
--
-- 步伐策略分析 (Step Strategy Analysis):
--   - 后步伐：最安全，但可能失去攻击机会
--   - 左/右步伐：保持攻击距离，可以快速反击
--   - 方向随机性：避免被玩家预测和针对
--
-- 适用场景 (Applicable Scenarios):
--   - 面对攻击速度快的敌人
--   - 需要高度反应性的高难度AI
--   - 实现有挑战性的战斗体验
--   - 防御反击型的敌人角色
function FindAttack_Step_NPCPlayer(f11_arg0, f11_arg1, f11_arg2, f11_arg3, f11_arg4, f11_arg5, f11_arg6)
    local f11_local0 = f11_arg0:GetDist(TARGET_ENE_0)     -- 获取与主要敌人的距离 (Get distance to primary enemy)
    local f11_local1 = f11_arg0:GetRandam_Int(1, 100)    -- 反应执行概率判定 (Response execution probability check)
    local f11_local2 = f11_arg0:GetRandam_Int(1, 100)    -- 步伐方向选择随机数 (Step direction selection random number)

    -- 攻击发现反应条件检查 (Attack detection response condition check)
    if f11_arg0:IsInterupt(INTERUPT_FindAttack) and f11_local0 <= f11_arg2 and f11_local1 <= f11_arg3 then
        f11_arg1:ClearSubGoal()                           -- 清空当前所有子目标 (Clear all current sub-goals)

        -- 预判性步伐方向选择 (Predictive step direction selection)
        if f11_local2 <= f11_arg4 then
            -- 执行后步伐：安全距离闪避 (Execute back step: safe distance evasion)
            f11_arg1:AddSubGoal(GOAL_COMMON_Attack, 10, NPC_ATK_StepB, TARGET_ENE_0, DIST_None, 0)
        elseif f11_local2 <= f11_arg4 + f11_arg5 then
            -- 执行左步伐：侧向闪避保持攻击机会 (Execute left step: lateral evasion maintaining attack opportunity)
            f11_arg1:AddSubGoal(GOAL_COMMON_Attack, 10, NPC_ATK_StepL, TARGET_ENE_0, DIST_None, 0)
        else
            -- 执行右步伐：侧向闪避保持攻击机会 (Execute right step: lateral evasion maintaining attack opportunity)
            f11_arg1:AddSubGoal(GOAL_COMMON_Attack, 10, NPC_ATK_StepR, TARGET_ENE_0, DIST_None, 0)
        end
        return true                                       -- 返回true表示成功处理了攻击发现事件 (Return true indicating successful attack detection event handling)
    end
    -- 未满足反应条件，隐式返回false (Conditions not met, implicitly return false)
end

function FindAttack_Act(f12_arg0, f12_arg1, f12_arg2, f12_arg3)
    local f12_local0 = f12_arg0:GetDist(TARGET_ENE_0)
    local f12_local1 = f12_arg0:GetRandam_Int(1, 100)
    if f12_arg0:IsInterupt(INTERUPT_FindAttack) and f12_local0 <= f12_arg2 and f12_local1 <= f12_arg3 then
        f12_arg1:ClearSubGoal()
        return true
    end
    return false
    
end

function FindAttack_Step(f13_arg0, f13_arg1, f13_arg2, f13_arg3, f13_arg4, f13_arg5, f13_arg6, f13_arg7)
    local f13_local0 = f13_arg0:GetDist(TARGET_ENE_0)
    local f13_local1 = f13_arg0:GetRandam_Int(1, 100)
    local f13_local2 = f13_arg0:GetRandam_Int(1, 100)
    local f13_local3 = GET_PARAM_IF_NIL_DEF(f13_arg4, 50)
    local f13_local4 = GET_PARAM_IF_NIL_DEF(f13_arg5, 25)
    local f13_local5 = GET_PARAM_IF_NIL_DEF(f13_arg6, 25)
    local f13_local6 = GET_PARAM_IF_NIL_DEF(f13_arg7, 3)
    if f13_arg0:IsInterupt(INTERUPT_FindAttack) and f13_local0 <= f13_arg2 and f13_local1 <= f13_arg3 then
        f13_arg1:ClearSubGoal()
        if f13_local2 <= f13_local3 then
            f13_arg1:AddSubGoal(GOAL_COMMON_SpinStep, 5, 701, TARGET_ENE_0, 0, AI_DIR_TYPE_B, f13_local6)
        elseif f13_local2 <= f13_local3 + f13_local4 then
            f13_arg1:AddSubGoal(GOAL_COMMON_SpinStep, 5, 702, TARGET_ENE_0, 0, AI_DIR_TYPE_L, f13_local6)
        else
            f13_arg1:AddSubGoal(GOAL_COMMON_SpinStep, 5, 703, TARGET_ENE_0, 0, AI_DIR_TYPE_R, f13_local6)
        end
        return true
    end
    
end

function FindAttack_Guard(f14_arg0, f14_arg1, f14_arg2, f14_arg3, f14_arg4, f14_arg5, f14_arg6)
    local f14_local0 = f14_arg0:GetDist(TARGET_ENE_0)
    local f14_local1 = f14_arg0:GetRandam_Int(1, 100)
    local f14_local2 = f14_arg0:GetRandam_Int(1, 100)
    local f14_local3 = GET_PARAM_IF_NIL_DEF(f14_arg4, 40)
    local f14_local4 = GET_PARAM_IF_NIL_DEF(f14_arg5, 4)
    local f14_local5 = GET_PARAM_IF_NIL_DEF(f14_arg6, 3)
    if f14_arg0:IsInterupt(INTERUPT_FindAttack) and f14_local0 <= f14_arg2 and f14_local1 <= f14_arg3 then
        f14_arg1:ClearSubGoal()
        if f14_local2 <= f14_local3 then
            f14_arg1:AddSubGoal(GOAL_COMMON_LeaveTarget, 4, TARGET_ENE_0, f14_local5, TARGET_ENE_0, true, 9910)
        else
            f14_arg1:AddSubGoal(GOAL_COMMON_LeaveTarget, 4, TARGET_ENE_0, f14_local5, TARGET_ENE_0, true, 9910)
            f14_arg1:AddSubGoal(GOAL_COMMON_SidewayMove, f14_local4, TARGET_ENE_0, f14_arg0:GetRandam_Int(0, 1), f14_arg0:GetRandam_Int(30, 45), true, true, 9910)
        end
        return true
    end
    
end

function FindAttack_Step_or_Guard(f15_arg0, f15_arg1, f15_arg2, f15_arg3, f15_arg4, f15_arg5, f15_arg6, f15_arg7, f15_arg8, f15_arg9, f15_arg10, f15_arg11)
    local f15_local0 = f15_arg0:GetDist(TARGET_ENE_0)
    local f15_local1 = f15_arg0:GetRandam_Int(1, 100)
    local f15_local2 = f15_arg0:GetRandam_Int(1, 100)
    local f15_local3 = f15_arg0:GetRandam_Int(1, 100)
    local f15_local4 = GET_PARAM_IF_NIL_DEF(f15_arg5, 50)
    local f15_local5 = GET_PARAM_IF_NIL_DEF(f15_arg6, 25)
    local f15_local6 = GET_PARAM_IF_NIL_DEF(f15_arg7, 25)
    local f15_local7 = GET_PARAM_IF_NIL_DEF(f15_arg8, 3)
    local f15_local8 = GET_PARAM_IF_NIL_DEF(f15_arg9, 40)
    local f15_local9 = GET_PARAM_IF_NIL_DEF(f15_arg10, 4)
    local f15_local10 = GET_PARAM_IF_NIL_DEF(f15_arg11, 3)
    if f15_arg0:IsInterupt(INTERUPT_FindAttack) and f15_local0 <= f15_arg2 and f15_local1 <= f15_arg3 then
        if f15_local2 <= f15_arg4 then
            f15_arg1:ClearSubGoal()
            if f15_local3 <= f15_local4 then
                f15_arg1:AddSubGoal(GOAL_COMMON_SpinStep, 5, 701, TARGET_ENE_0, 0, AI_DIR_TYPE_B, f15_local7)
            elseif f15_local3 <= f15_local4 + f15_local5 then
                f15_arg1:AddSubGoal(GOAL_COMMON_SpinStep, 5, 702, TARGET_ENE_0, 0, AI_DIR_TYPE_L, f15_local7)
            else
                f15_arg1:AddSubGoal(GOAL_COMMON_SpinStep, 5, 703, TARGET_ENE_0, 0, AI_DIR_TYPE_R, f15_local7)
            end
            return true
        else
            f15_arg1:ClearSubGoal()
            if f15_local3 <= f15_local8 then
                f15_arg1:AddSubGoal(GOAL_COMMON_LeaveTarget, 4, TARGET_ENE_0, f15_local10, TARGET_ENE_0, true, 9910)
            else
                f15_arg1:AddSubGoal(GOAL_COMMON_LeaveTarget, 4, TARGET_ENE_0, f15_local10, TARGET_ENE_0, true, 9910)
                f15_arg1:AddSubGoal(GOAL_COMMON_SidewayMove, f15_local9, TARGET_ENE_0, f15_arg0:GetRandam_Int(0, 1), f15_arg0:GetRandam_Int(30, 45), true, true, 9910)
            end
            return true
        end
    end
    
end

function Damaged_Act(f16_arg0, f16_arg1, f16_arg2, f16_arg3)
    local f16_local0 = f16_arg0:GetDist(TARGET_ENE_0)
    local f16_local1 = f16_arg0:GetRandam_Int(1, 100)
    if f16_arg0:IsInterupt(INTERUPT_Damaged) and f16_local0 < f16_arg2 and f16_local1 <= f16_arg3 then
        f16_arg1:ClearSubGoal()
        return true
    end
    return false
    
end

function Damaged_Guard(f17_arg0, f17_arg1, f17_arg2, f17_arg3, f17_arg4, f17_arg5, f17_arg6)
    local f17_local0 = f17_arg0:GetDist(TARGET_ENE_0)
    local f17_local1 = f17_arg0:GetRandam_Int(1, 100)
    local f17_local2 = f17_arg0:GetRandam_Int(1, 100)
    local f17_local3 = GET_PARAM_IF_NIL_DEF(f17_arg4, 40)
    local f17_local4 = GET_PARAM_IF_NIL_DEF(f17_arg5, 4)
    local f17_local5 = GET_PARAM_IF_NIL_DEF(f17_arg6, 3)
    if f17_arg0:IsInterupt(INTERUPT_Damaged) and f17_local0 <= f17_arg2 and f17_local1 <= f17_arg3 then
        f17_arg1:ClearSubGoal()
        if f17_local2 <= f17_local3 then
            f17_arg1:AddSubGoal(GOAL_COMMON_LeaveTarget, 4, TARGET_ENE_0, f17_local5, TARGET_ENE_0, true, 9910)
        else
            f17_arg1:AddSubGoal(GOAL_COMMON_LeaveTarget, 4, TARGET_ENE_0, f17_local5, TARGET_ENE_0, true, 9910)
            f17_arg1:AddSubGoal(GOAL_COMMON_SidewayMove, f17_local4, TARGET_ENE_0, f17_arg0:GetRandam_Int(0, 1), f17_arg0:GetRandam_Int(30, 45), true, true, 9910)
        end
        return true
    end
    
end

function Damaged_Step(f18_arg0, f18_arg1, f18_arg2, f18_arg3, f18_arg4, f18_arg5, f18_arg6, f18_arg7)
    local f18_local0 = f18_arg0:GetDist(TARGET_ENE_0)
    local f18_local1 = f18_arg0:GetRandam_Int(1, 100)
    local f18_local2 = f18_arg0:GetRandam_Int(1, 100)
    local f18_local3 = GET_PARAM_IF_NIL_DEF(f18_arg4, 50)
    local f18_local4 = GET_PARAM_IF_NIL_DEF(f18_arg5, 25)
    local f18_local5 = GET_PARAM_IF_NIL_DEF(f18_arg6, 25)
    local f18_local6 = GET_PARAM_IF_NIL_DEF(f18_arg7, 3)
    if f18_arg0:IsInterupt(INTERUPT_Damaged) and f18_local0 <= f18_arg2 and f18_local1 <= f18_arg3 then
        f18_arg1:ClearSubGoal()
        if f18_local2 <= f18_local3 then
            f18_arg1:AddSubGoal(GOAL_COMMON_SpinStep, 5, 701, TARGET_ENE_0, 0, AI_DIR_TYPE_B, f18_local6)
        elseif f18_local2 <= f18_local3 + f18_local4 then
            f18_arg1:AddSubGoal(GOAL_COMMON_SpinStep, 5, 702, TARGET_ENE_0, 0, AI_DIR_TYPE_L, f18_local6)
        else
            f18_arg1:AddSubGoal(GOAL_COMMON_SpinStep, 5, 703, TARGET_ENE_0, 0, AI_DIR_TYPE_R, f18_local6)
        end
        return true
    end
    
end

function Damaged_Step_or_Guard(f19_arg0, f19_arg1, f19_arg2, f19_arg3, f19_arg4, f19_arg5, f19_arg6, f19_arg7, f19_arg8, f19_arg9, f19_arg10, f19_arg11)
    local f19_local0 = f19_arg0:GetDist(TARGET_ENE_0)
    local f19_local1 = f19_arg0:GetRandam_Int(1, 100)
    local f19_local2 = f19_arg0:GetRandam_Int(1, 100)
    local f19_local3 = f19_arg0:GetRandam_Int(1, 100)
    local f19_local4 = GET_PARAM_IF_NIL_DEF(f19_arg5, 50)
    local f19_local5 = GET_PARAM_IF_NIL_DEF(f19_arg6, 25)
    local f19_local6 = GET_PARAM_IF_NIL_DEF(f19_arg7, 25)
    local f19_local7 = GET_PARAM_IF_NIL_DEF(f19_arg8, 3)
    local f19_local8 = GET_PARAM_IF_NIL_DEF(f19_arg9, 40)
    local f19_local9 = GET_PARAM_IF_NIL_DEF(f19_arg10, 4)
    local f19_local10 = GET_PARAM_IF_NIL_DEF(f19_arg11, 3)
    if f19_arg0:IsInterupt(INTERUPT_Damaged) and f19_local0 <= f19_arg2 and f19_local1 <= f19_arg3 then
        if f19_local2 <= f19_arg4 then
            f19_arg1:ClearSubGoal()
            if f19_local3 <= f19_local4 then
                f19_arg1:AddSubGoal(GOAL_COMMON_SpinStep, 5, 701, TARGET_ENE_0, 0, AI_DIR_TYPE_B, f19_local7)
            elseif f19_local3 <= f19_local4 + f19_local5 then
                f19_arg1:AddSubGoal(GOAL_COMMON_SpinStep, 5, 702, TARGET_ENE_0, 0, AI_DIR_TYPE_L, f19_local7)
            else
                f19_arg1:AddSubGoal(GOAL_COMMON_SpinStep, 5, 703, TARGET_ENE_0, 0, AI_DIR_TYPE_R, f19_local7)
            end
            return true
        else
            f19_arg1:ClearSubGoal()
            if f19_local3 <= f19_local8 then
                f19_arg1:AddSubGoal(GOAL_COMMON_LeaveTarget, 4, TARGET_ENE_0, f19_local10, TARGET_ENE_0, true, 9910)
            else
                f19_arg1:AddSubGoal(GOAL_COMMON_LeaveTarget, 4, TARGET_ENE_0, f19_local10, TARGET_ENE_0, true, 9910)
                f19_arg1:AddSubGoal(GOAL_COMMON_SidewayMove, f19_local9, TARGET_ENE_0, f19_arg0:GetRandam_Int(0, 1), f19_arg0:GetRandam_Int(30, 45), true, true, 9910)
            end
            return true
        end
    end
    
end

function GuardBreak_Act(f20_arg0, f20_arg1, f20_arg2, f20_arg3)
    local f20_local0 = f20_arg0:GetDist(TARGET_ENE_0)
    local f20_local1 = f20_arg0:GetRandam_Int(1, 100)
    if f20_arg0:IsInterupt(INTERUPT_GuardBreak) and f20_local0 <= f20_arg2 and f20_local1 <= f20_arg3 then
        f20_arg1:ClearSubGoal()
        return true
    end
    return false
    
end

function GuardBreak_Attack(f21_arg0, f21_arg1, f21_arg2, f21_arg3, f21_arg4)
    local f21_local0 = f21_arg0:GetDist(TARGET_ENE_0)
    local f21_local1 = f21_arg0:GetRandam_Int(1, 100)
    if f21_arg0:IsInterupt(INTERUPT_GuardBreak) and f21_local0 <= f21_arg2 and f21_local1 <= f21_arg3 then
        f21_arg1:ClearSubGoal()
        f21_arg1:AddSubGoal(GOAL_COMMON_Attack, 10, f21_arg4, TARGET_ENE_0, DIST_Middle, 0)
        return true
    end
    return false
    
end

function MissSwing_Int(f22_arg0, f22_arg1, f22_arg2, f22_arg3)
    local f22_local0 = f22_arg0:GetDist(TARGET_ENE_0)
    local f22_local1 = f22_arg0:GetRandam_Int(1, 100)
    if f22_arg0:IsInterupt(INTERUPT_MissSwing) and f22_local0 <= f22_arg2 and f22_local1 <= f22_arg3 then
        f22_arg1:ClearSubGoal()
        return true
    end
    return false
    
end

function MissSwing_Attack(f23_arg0, f23_arg1, f23_arg2, f23_arg3, f23_arg4)
    local f23_local0 = f23_arg0:GetDist(TARGET_ENE_0)
    local f23_local1 = f23_arg0:GetRandam_Int(1, 100)
    if f23_arg0:IsInterupt(INTERUPT_MissSwing) and f23_local0 <= f23_arg2 and f23_local1 <= f23_arg3 then
        f23_arg1:ClearSubGoal()
        f23_arg1:AddSubGoal(GOAL_COMMON_Attack, 10, f23_arg4, TARGET_ENE_0, DIST_Middle, 0)
        return true
    end
    return false
    
end

function UseItem_Act(f24_arg0, f24_arg1, f24_arg2, f24_arg3)
    local f24_local0 = f24_arg0:GetDist(TARGET_ENE_0)
    local f24_local1 = f24_arg0:GetRandam_Int(1, 100)
    if f24_arg0:IsInterupt(INTERUPT_UseItem) and f24_local0 <= f24_arg2 and f24_local1 <= f24_arg3 then
        f24_arg1:ClearSubGoal()
        return true
    end
    return false
    
end

function Shoot_1kind(f25_arg0, f25_arg1, f25_arg2, f25_arg3)
    local f25_local0 = f25_arg0:GetDist(TARGET_ENE_0)
    local f25_local1 = f25_arg0:GetRandam_Int(1, 100)
    local f25_local2 = GET_PARAM_IF_NIL_DEF(bkStepPer, 50)
    local f25_local3 = GET_PARAM_IF_NIL_DEF(leftStepPer, 25)
    local f25_local4 = GET_PARAM_IF_NIL_DEF(rightStepPer, 25)
    local f25_local5 = GET_PARAM_IF_NIL_DEF(safetyDist, 3)
    if f25_arg0:IsInterupt(INTERUPT_Shoot) and f25_local0 <= f25_arg2 and f25_local1 <= f25_arg3 then
        f25_arg1:ClearSubGoal()
        return true
    end
    return false
    
end

function Shoot_2dist(f26_arg0, f26_arg1, f26_arg2, f26_arg3, f26_arg4, f26_arg5)
    local f26_local0 = f26_arg0:GetDist(TARGET_ENE_0)
    local f26_local1 = f26_arg0:GetRandam_Int(1, 100)
    local f26_local2 = f26_arg0:GetRandam_Int(1, 100)
    if f26_arg0:IsInterupt(INTERUPT_Shoot) then
        if f26_local0 <= f26_arg2 then
            if f26_local1 <= f26_arg4 then
                f26_arg1:ClearSubGoal()
                return 1
            end
        elseif f26_local0 <= f26_arg3 then
            if f26_local1 <= f26_arg5 then
                f26_arg1:ClearSubGoal()
                return 2
            end
        else
            return 0
        end
    end
    return 0
    
end

function MissSwingSelf_Step(f27_arg0, f27_arg1, f27_arg2, f27_arg3, f27_arg4, f27_arg5, f27_arg6)
    local f27_local0 = f27_arg0:GetDist(TARGET_ENE_0)
    local f27_local1 = f27_arg0:GetRandam_Int(1, 100)
    local f27_local2 = f27_arg0:GetRandam_Int(1, 100)
    local f27_local3 = GET_PARAM_IF_NIL_DEF(f27_arg3, 50)
    local f27_local4 = GET_PARAM_IF_NIL_DEF(f27_arg4, 25)
    local f27_local5 = GET_PARAM_IF_NIL_DEF(f27_arg5, 25)
    local f27_local6 = GET_PARAM_IF_NIL_DEF(f27_arg6, 3)
    if f27_arg0:IsInterupt(INTERUPT_MissSwingSelf) and f27_local1 <= f27_arg2 then
        f27_arg1:ClearSubGoal()
        if f27_local2 <= f27_local3 then
            f27_arg1:AddSubGoal(GOAL_COMMON_SpinStep, 5, 701, TARGET_ENE_0, 0, AI_DIR_TYPE_B, f27_local6)
        elseif f27_local2 <= f27_local3 + f27_local4 then
            f27_arg1:AddSubGoal(GOAL_COMMON_SpinStep, 5, 702, TARGET_ENE_0, 0, AI_DIR_TYPE_L, f27_local6)
        else
            f27_arg1:AddSubGoal(GOAL_COMMON_SpinStep, 5, 703, TARGET_ENE_0, 0, AI_DIR_TYPE_R, f27_local6)
        end
        return true
    end
    
end

function RebByOpGuard_Step(f28_arg0, f28_arg1, f28_arg2, f28_arg3, f28_arg4, f28_arg5, f28_arg6)
    local f28_local0 = f28_arg0:GetDist(TARGET_ENE_0)
    local f28_local1 = f28_arg0:GetRandam_Int(1, 100)
    local f28_local2 = f28_arg0:GetRandam_Int(1, 100)
    local f28_local3 = GET_PARAM_IF_NIL_DEF(f28_arg3, 50)
    local f28_local4 = GET_PARAM_IF_NIL_DEF(f28_arg4, 25)
    local f28_local5 = GET_PARAM_IF_NIL_DEF(f28_arg5, 25)
    local f28_local6 = GET_PARAM_IF_NIL_DEF(f28_arg6, 3)
    if f28_arg0:IsInterupt(INTERUPT_ReboundByOpponentGuard) and f28_local1 <= f28_arg2 then
        f28_arg1:ClearSubGoal()
        if f28_local2 <= f28_local3 then
            f28_arg1:AddSubGoal(GOAL_COMMON_SpinStep, 5, 701, TARGET_ENE_0, 0, AI_DIR_TYPE_B, f28_local6)
        elseif f28_local2 <= f28_local3 + f28_local4 then
            f28_arg1:AddSubGoal(GOAL_COMMON_SpinStep, 5, 702, TARGET_ENE_0, 0, AI_DIR_TYPE_L, f28_local6)
        else
            f28_arg1:AddSubGoal(GOAL_COMMON_SpinStep, 5, 703, TARGET_ENE_0, 0, AI_DIR_TYPE_R, f28_local6)
        end
        return true
    end
    
end

function SuccessGuard_Act(f29_arg0, f29_arg1, f29_arg2, f29_arg3)
    local f29_local0 = f29_arg0:GetDist(TARGET_ENE_0)
    local f29_local1 = f29_arg0:GetRandam_Int(1, 100)
    local f29_local2 = f29_arg0:GetRandam_Int(1, 100)
    if f29_arg0:IsInterupt(INTERUPT_SuccessGuard) and f29_local0 <= f29_arg2 and f29_local1 <= f29_arg3 then
        f29_arg1:ClearSubGoal()
        return true
    end
    return false
    
end

function SuccessGuard_Attack(f30_arg0, f30_arg1, f30_arg2, f30_arg3, f30_arg4)
    local f30_local0 = f30_arg0:GetDist(TARGET_ENE_0)
    local f30_local1 = f30_arg0:GetRandam_Int(1, 100)
    if f30_arg0:IsInterupt(INTERUPT_SuccessGuard) and f30_local0 <= f30_arg2 and f30_local1 <= f30_arg3 then
        f30_arg1:ClearSubGoal()
        f30_arg1:AddSubGoal(GOAL_COMMON_Attack, 10, f30_arg4, TARGET_ENE_0, DIST_Middle, 0)
        return true
    end
    return false
    
end

function FarDamaged_Act(f31_arg0, f31_arg1, f31_arg2, f31_arg3)
    local f31_local0 = f31_arg0:GetDist(TARGET_ENE_0)
    local f31_local1 = f31_arg0:GetRandam_Int(1, 100)
    if f31_arg0:IsInterupt(INTERUPT_Damaged) and f31_arg2 <= f31_local0 and f31_local1 <= f31_arg3 then
        f31_arg1:ClearSubGoal()
        return true
    end
    return false
    
end

function MissSwing_Act(f32_arg0, f32_arg1, f32_arg2, f32_arg3)
    local f32_local0 = f32_arg0:GetDist(TARGET_ENE_0)
    local f32_local1 = f32_arg0:GetRandam_Int(1, 100)
    if f32_arg0:IsInterupt(INTERUPT_MissSwing) and f32_local0 <= f32_arg2 and f32_local1 <= f32_arg3 then
        f32_arg1:ClearSubGoal()
        return true
    end
    return false
    
end

function FindGuardBreak_Act(f33_arg0, f33_arg1, f33_arg2, f33_arg3)
    local f33_local0 = f33_arg0:GetDist(TARGET_ENE_0)
    local f33_local1 = f33_arg0:GetRandam_Int(1, 100)
    if f33_arg0:IsInterupt(INTERUPT_GuardBreak) and f33_local0 <= f33_arg2 and f33_local1 <= f33_arg3 then
        f33_arg1:ClearSubGoal()
        return true
    end
    return false
    
end

function FindGuardFinish_Act(f34_arg0, f34_arg1, f34_arg2, f34_arg3)
    local f34_local0 = f34_arg0:GetDist(TARGET_ENE_0)
    local f34_local1 = f34_arg0:GetRandam_Int(1, 100)
    if f34_arg0:IsInterupt(INTERUPT_GuardFinish) and f34_local0 <= f34_arg2 and f34_local1 <= f34_arg3 then
        f34_arg1:ClearSubGoal()
        return true
    end
    return false
    
end

function FindShoot_Act(f35_arg0, f35_arg1, f35_arg2, f35_arg3, f35_arg4, f35_arg5, f35_arg6, f35_arg7)
    local f35_local0 = f35_arg0:GetDist(TARGET_ENE_0)
    local f35_local1 = f35_arg0:GetRandam_Int(1, 100)
    if f35_arg0:IsInterupt(INTERUPT_Shoot) then
        if f35_local0 <= f35_arg5 and f35_local1 <= f35_arg2 then
            f35_arg1:ClearSubGoal()
            return 1
        elseif f35_local0 <= f35_arg6 and f35_local1 <= f35_arg3 then
            f35_arg1:ClearSubGoal()
            return 2
        elseif f35_local0 <= f35_arg7 and f35_local1 <= f35_arg4 then
            f35_arg1:ClearSubGoal()
            return 3
        else
            f35_arg1:ClearSubGoal()
            return 0
        end
    end
    return 0
    
end

function BusyApproach_Act(f36_arg0, f36_arg1, f36_arg2, f36_arg3, f36_arg4)
    local f36_local0 = -1
    local f36_local1 = f36_arg0:GetRandam_Int(1, 100)
    if f36_local1 <= f36_arg4 then
        f36_local0 = 9910
    end
    local f36_local2 = f36_arg0:GetDist(TARGET_ENE_0)
    if f36_arg3 <= f36_local2 then
        f36_arg1:AddSubGoal(GOAL_COMMON_ApproachTarget, 10, TARGET_ENE_0, f36_arg2, TARGET_SELF, false, f36_local0)
    else
        f36_arg1:AddSubGoal(GOAL_COMMON_ApproachTarget, 2, TARGET_ENE_0, f36_arg2, TARGET_SELF, true, f36_local0)
    end
    
end

function Approach_and_Attack_Act(f37_arg0, f37_arg1, f37_arg2, f37_arg3, f37_arg4, f37_arg5, f37_arg6, f37_arg7, f37_arg8)
    local f37_local0 = f37_arg0:GetDist(TARGET_ENE_0)
    local f37_local1 = true
    if f37_arg3 <= f37_local0 then
        f37_local1 = false
    end
    local f37_local2 = -1
    local f37_local3 = f37_arg0:GetRandam_Int(1, 100)
    if f37_local3 <= f37_arg4 then
        f37_local2 = 9910
    end
    local f37_local4 = GET_PARAM_IF_NIL_DEF(f37_arg7, 1.5)
    local f37_local5 = GET_PARAM_IF_NIL_DEF(f37_arg8, 20)
    f37_arg1:AddSubGoal(GOAL_COMMON_ApproachTarget, 10, TARGET_ENE_0, f37_arg2, TARGET_SELF, f37_local1, f37_local2)
    f37_arg1:AddSubGoal(GOAL_COMMON_AttackTunableSpin, 10, f37_arg5, TARGET_ENE_0, f37_arg6, f37_local4, f37_local5)
    
end

function KeepDist_and_Attack_Act(f38_arg0, f38_arg1, f38_arg2, f38_arg3, f38_arg4, f38_arg5, f38_arg6, f38_arg7)
    local f38_local0 = f38_arg0:GetDist(TARGET_ENE_0)
    local f38_local1 = true
    if f38_arg4 <= f38_local0 then
        f38_local1 = false
    end
    local f38_local2 = -1
    local f38_local3 = f38_arg0:GetRandam_Int(1, 100)
    if f38_local3 <= f38_arg5 then
        f38_local2 = 9910
    end
    f38_arg1:AddSubGoal(GOAL_COMMON_KeepDist, 10, TARGET_ENE_0, f38_arg2, f38_arg3, TARGET_ENE_0, f38_local1, f38_local2)
    f38_arg1:AddSubGoal(GOAL_COMMON_Attack, 10, f38_arg6, TARGET_ENE_0, f38_arg7, 0)
    
end

function Approach_and_GuardBreak_Act(f39_arg0, f39_arg1, f39_arg2, f39_arg3, f39_arg4, f39_arg5, f39_arg6, f39_arg7, f39_arg8)
    local f39_local0 = f39_arg0:GetDist(TARGET_ENE_0)
    local f39_local1 = true
    if f39_arg3 <= f39_local0 then
        f39_local1 = false
    end
    local f39_local2 = -1
    local f39_local3 = f39_arg0:GetRandam_Int(1, 100)
    if f39_local3 <= f39_arg4 then
        f39_local2 = 9910
    end
    f39_arg1:AddSubGoal(GOAL_COMMON_ApproachTarget, 10, TARGET_ENE_0, f39_arg2, TARGET_SELF, f39_local1, f39_local2)
    f39_arg1:AddSubGoal(GOAL_COMMON_GuardBreakAttack, 10, f39_arg5, TARGET_ENE_0, f39_arg6, 0)
    f39_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, f39_arg7, TARGET_ENE_0, f39_arg8, 0)
    
end

function GetWellSpace_Act(f40_arg0, f40_arg1, f40_arg2, f40_arg3, f40_arg4, f40_arg5, f40_arg6, f40_arg7)
    local f40_local0 = -1
    local f40_local1 = f40_arg0:GetRandam_Int(1, 100)
    if f40_local1 <= f40_arg2 then
        f40_local0 = 9910
    end
    local f40_local2 = f40_arg0:GetRandam_Int(1, 100)
    local f40_local3 = f40_arg0:GetRandam_Int(0, 1)
    local f40_local4 = f40_arg0:GetTeamRecordCount(COORDINATE_TYPE_SideWalk_L + f40_local3, TARGET_ENE_0, 2)
    if f40_local2 <= f40_arg3 then
    elseif f40_local2 <= f40_arg3 + f40_arg4 and f40_local4 < 2 then
        f40_arg1:AddSubGoal(GOAL_COMMON_LeaveTarget, 2.5, TARGET_ENE_0, 2, TARGET_ENE_0, true, f40_local0)
        f40_arg1:AddSubGoal(GOAL_COMMON_SidewayMove, 3, TARGET_ENE_0, f40_local3, f40_arg0:GetRandam_Int(30, 45), true, true, f40_local0)
    elseif f40_local2 <= f40_arg3 + f40_arg4 + f40_arg5 then
        f40_arg1:AddSubGoal(GOAL_COMMON_LeaveTarget, 2.5, TARGET_ENE_0, 3, TARGET_ENE_0, true, f40_local0)
    elseif f40_local2 <= f40_arg3 + f40_arg4 + f40_arg5 + f40_arg6 then
        f40_arg1:AddSubGoal(GOAL_COMMON_Wait, f40_arg0:GetRandam_Float(0.5, 1), 0, 0, 0, 0)
    else
        f40_arg1:AddSubGoal(GOAL_COMMON_SpinStep, 5, 701, TARGET_ENE_0, 0, AI_DIR_TYPE_B, 4)
    end
    
end

function GetWellSpace_Act_IncludeSidestep(f41_arg0, f41_arg1, f41_arg2, f41_arg3, f41_arg4, f41_arg5, f41_arg6, f41_arg7, f41_arg8)
    local f41_local0 = -1
    local f41_local1 = f41_arg0:GetRandam_Int(1, 100)
    if f41_local1 <= f41_arg2 then
        f41_local0 = 9910
    end
    local f41_local2 = f41_arg0:GetRandam_Int(1, 100)
    local f41_local3 = f41_arg0:GetRandam_Int(0, 1)
    local f41_local4 = f41_arg0:GetTeamRecordCount(COORDINATE_TYPE_SideWalk_L + f41_local3, TARGET_ENE_0, 2)
    if f41_local2 <= f41_arg3 then
    elseif f41_local2 <= f41_arg3 + f41_arg4 and f41_local4 < 2 then
        f41_arg1:AddSubGoal(GOAL_COMMON_LeaveTarget, 2.5, TARGET_ENE_0, 2, TARGET_ENE_0, true, f41_local0)
        f41_arg1:AddSubGoal(GOAL_COMMON_SidewayMove, 3, TARGET_ENE_0, f41_local3, f41_arg0:GetRandam_Int(30, 45), true, true, f41_local0)
    elseif f41_local2 <= f41_arg3 + f41_arg4 + f41_arg5 then
        f41_arg1:AddSubGoal(GOAL_COMMON_LeaveTarget, 2.5, TARGET_ENE_0, 3, TARGET_ENE_0, true, f41_local0)
    elseif f41_local2 <= f41_arg3 + f41_arg4 + f41_arg5 + f41_arg6 then
        f41_arg1:AddSubGoal(GOAL_COMMON_Wait, f41_arg0:GetRandam_Float(0.5, 1), 0, 0, 0, 0)
    elseif f41_local2 <= f41_arg3 + f41_arg4 + f41_arg5 + f41_arg6 + f41_arg7 then
        f41_arg1:AddSubGoal(GOAL_COMMON_SpinStep, 5, 6001, TARGET_ENE_0, 0, AI_DIR_TYPE_B, 4)
    else
        local f41_local5 = f41_arg0:GetRandam_Int(1, 100)
        if f41_local5 <= 50 then
            f41_arg1:AddSubGoal(GOAL_COMMON_SpinStep, 5, 6002, TARGET_ENE_0, 0, AI_DIR_TYPE_L, 4)
        else
            f41_arg1:AddSubGoal(GOAL_COMMON_SpinStep, 5, 6003, TARGET_ENE_0, 0, AI_DIR_TYPE_R, 4)
        end
    end
    
end

function Shoot_Act(f42_arg0, f42_arg1, f42_arg2, f42_arg3, f42_arg4)
    if f42_arg4 == 1 then
        f42_arg1:AddSubGoal(GOAL_COMMON_Attack, 10, f42_arg2, TARGET_ENE_0, DIST_None, 0)
    elseif f42_arg4 >= 2 then
        f42_arg1:AddSubGoal(GOAL_COMMON_ComboAttack, 10, f42_arg2, TARGET_ENE_0, DIST_None, 0)
        if f42_arg4 >= 3 then
            f42_arg1:AddSubGoal(GOAL_COMMON_ComboRepeat, 10, f42_arg3, TARGET_ENE_0, DIST_None, 0)
            if f42_arg4 >= 4 then
                f42_arg1:AddSubGoal(GOAL_COMMON_ComboRepeat, 10, f42_arg3, TARGET_ENE_0, DIST_None, 0)
                if f42_arg4 >= 5 then
                    f42_arg1:AddSubGoal(GOAL_COMMON_ComboRepeat, 10, f42_arg3, TARGET_ENE_0, DIST_None, 0)
                end
            end
        end
        f42_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, f42_arg3, TARGET_ENE_0, DIST_None, 0)
    end
    
end

function Approach_Act(f43_arg0, f43_arg1, f43_arg2, f43_arg3, f43_arg4, f43_arg5)
    if f43_arg5 == nil then
        f43_arg5 = 10
    end
    local f43_local0 = f43_arg0:GetDist(TARGET_ENE_0)
    local f43_local1 = true
    if f43_arg3 <= f43_local0 then
        f43_local1 = false
    end
    local f43_local2 = -1
    local f43_local3 = f43_arg0:GetRandam_Int(1, 100)
    if f43_local3 <= f43_arg4 then
        f43_local2 = 9910
    end
    f43_arg1:AddSubGoal(GOAL_COMMON_ApproachTarget, f43_arg5, TARGET_ENE_0, f43_arg2, TARGET_SELF, f43_local1, f43_local2)
    
end

function Approach_or_Leave_Act(f44_arg0, f44_arg1, f44_arg2, f44_arg3, f44_arg4, f44_arg5)
    local f44_local0 = f44_arg0:GetDist(TARGET_ENE_0)
    local f44_local1 = true
    if f44_arg4 ~= -1 and f44_arg4 <= f44_local0 then
        f44_local1 = false
    end
    local f44_local2 = -1
    local f44_local3 = f44_arg0:GetRandam_Int(1, 100)
    if f44_local3 <= f44_arg5 then
        f44_local2 = 9910
    end
    if f44_arg2 <= f44_local0 then
        f44_arg1:AddSubGoal(GOAL_COMMON_ApproachTarget, 5, TARGET_ENE_0, f44_arg3, TARGET_SELF, f44_local1, f44_local2)
    else
        f44_arg1:AddSubGoal(GOAL_COMMON_LeaveTarget, 5, TARGET_ENE_0, f44_arg2, TARGET_ENE_0, true, f44_local2)
    end
    
end

function Watching_Parry_Chance_Act(f45_arg0, f45_arg1)
    FirstDist = f45_arg0:GetRandam_Float(2, 4)
    SecondDist = f45_arg0:GetRandam_Float(2, 4)
    f45_arg1:AddSubGoal(GOAL_COMMON_KeepDist, 5, TARGET_ENE_0, FirstDist, FirstDist + 0.5, TARGET_ENE_0, true, 9920)
    f45_arg1:AddSubGoal(GOAL_COMMON_SidewayMove, f45_arg0:GetRandam_Float(3, 5), TARGET_ENE_0, f45_arg0:GetRandam_Int(0, 1), 180, true, true, 9920)
    f45_arg1:AddSubGoal(GOAL_COMMON_KeepDist, 5, TARGET_ENE_0, SecondDist, SecondDist + 0.5, TARGET_ENE_0, true, 9920)
    f45_arg1:AddSubGoal(GOAL_COMMON_SidewayMove, f45_arg0:GetRandam_Float(3, 5), TARGET_ENE_0, f45_arg0:GetRandam_Int(0, 1), 180, true, true, 9920)
    
end

function Parry_Act(f46_arg0, f46_arg1, f46_arg2, f46_arg3, f46_arg4, f46_arg5)
    local f46_local0 = f46_arg0:GetDist(TARGET_ENE_0)
    if f46_arg0:IsInterupt(INTERUPT_ParryTiming) then
        if f46_local0 <= f46_arg2 and f46_arg0:IsInsideTarget(TARGET_ENE_0, AI_DIR_TYPE_F, f46_arg3) then
            f46_arg1:ClearSubGoal()
            f46_arg1:AddSubGoal(GOAL_COMMON_Parry, 1.25, 4000, TARGET_SELF, 0)
            return true
        end
    elseif f46_arg0:IsInterupt(INTERUPT_SuccessParry) and f46_local0 <= f46_arg4 and f46_arg0:IsInsideTarget(TARGET_ENE_0, AI_DIR_TYPE_F, f46_arg5) then
        f46_arg1:ClearSubGoal()
        f46_arg1:AddSubGoal(GOAL_COMMON_ApproachTarget, 3, TARGET_ENE_0, 1, TARGET_SELF, false, -1)
        local f46_local1 = f46_arg0:GetRandam_Float(0.3, 0.6)
        f46_arg1:AddSubGoal(GOAL_COMMON_Wait, f46_local1, TARGET_ENE_0)
        f46_arg1:AddSubGoal(GOAL_COMMON_Attack, 10, 3110, TARGET_ENE_0, 3, 0)
        return true
    end
    
end

function ObserveAreaForBackstab(f47_arg0, f47_arg1, f47_arg2, f47_arg3, f47_arg4)
    f47_arg0:AddObserveArea(f47_arg2, TARGET_ENE_0, TARGET_SELF, AI_DIR_TYPE_B, f47_arg4, f47_arg3)
    
end

function Backstab_Act(f48_arg0, f48_arg1, f48_arg2, f48_arg3, f48_arg4, f48_arg5)
    if f48_arg0:IsInterupt(INTERUPT_Inside_ObserveArea) and f48_arg0:IsThrowing() == false and f48_arg0:IsFinishTimer(f48_arg4) == true and f48_arg0:IsInsideObserve(f48_arg2) then
        f48_arg0:SetTimer(f48_arg4, f48_arg5)
        f48_arg1:ClearSubGoal()
        f48_arg1:AddSubGoal(GOAL_COMMON_ApproachTarget, 5, TARGET_ENE_0, f48_arg3, TARGET_SELF, false, -1)
        f48_arg1:AddSubGoal(GOAL_COMMON_Attack, 10, 3110, TARGET_ENE_0, 3, 0)
        return true
    end
    
end

function Torimaki_Act(f49_arg0, f49_arg1, f49_arg2)
    local f49_local0 = -1
    local f49_local1 = f49_arg0:GetRandam_Int(1, 100)
    if f49_local1 <= f49_arg2 then
        f49_local0 = 9910
    end
    local f49_local2 = f49_arg0:GetDist(TARGET_ENE_0)
    if f49_local2 >= 15 then
        f49_arg1:AddSubGoal(GOAL_COMMON_ApproachTarget, 5, TARGET_ENE_0, 4.5, TARGET_SELF, true, -1)
    elseif f49_local2 >= 6 then
        f49_arg1:AddSubGoal(GOAL_COMMON_ApproachTarget, 5, TARGET_ENE_0, 4.5, TARGET_SELF, true, -1)
    elseif f49_local2 >= 3 then
        f49_arg1:AddSubGoal(GOAL_COMMON_SidewayMove, 3, TARGET_ENE_0, f49_arg0:GetRandam_Int(0, 1), f49_arg0:GetRandam_Int(30, 45), true, true, f49_local0)
    else
        f49_arg1:AddSubGoal(GOAL_COMMON_LeaveTarget, 5, TARGET_ENE_0, 4, TARGET_ENE_0, true, f49_local0)
    end
    f49_arg1:AddSubGoal(GOAL_COMMON_SidewayMove, 3, TARGET_ENE_0, f49_arg0:GetRandam_Int(0, 1), f49_arg0:GetRandam_Int(30, 45), true, true, f49_local0)
    
end

function Kankyaku_Act(f50_arg0, f50_arg1, f50_arg2)
    local f50_local0 = -1
    local f50_local1 = f50_arg0:GetRandam_Int(1, 100)
    if f50_local1 <= f50_arg2 then
        f50_local0 = 9910
    end
    local f50_local2 = f50_arg0:GetDist(TARGET_ENE_0)
    if f50_local2 >= 15 then
        f50_arg1:AddSubGoal(GOAL_COMMON_ApproachTarget, 5, TARGET_ENE_0, 6.5, TARGET_SELF, true, -1)
    elseif f50_local2 >= 8 then
        f50_arg1:AddSubGoal(GOAL_COMMON_ApproachTarget, 5, TARGET_ENE_0, 6.5, TARGET_SELF, true, -1)
    elseif f50_local2 >= 4 then
        f50_arg1:AddSubGoal(GOAL_COMMON_SidewayMove, 3, TARGET_ENE_0, f50_arg0:GetRandam_Int(0, 1), f50_arg0:GetRandam_Int(30, 45), true, true, f50_local0)
    else
        f50_arg1:AddSubGoal(GOAL_COMMON_LeaveTarget, 5, TARGET_ENE_0, 6, TARGET_ENE_0, true, f50_local0)
    end
    f50_arg1:AddSubGoal(GOAL_COMMON_SidewayMove, 3, TARGET_ENE_0, f50_arg0:GetRandam_Int(0, 1), f50_arg0:GetRandam_Int(30, 45), true, true, f50_local0)
    
end

function ClearTableParam(f51_arg0, f51_arg1)
    local f51_local0 = 50
    local f51_local1 = 1
    for f51_local2 = 1, f51_local0, 1 do
        f51_arg0[f51_local2] = 0
        f51_arg1[f51_local2] = {}
    end
    

end

--[[============================================================================
    概率选择算法系统 (Probability Selection Algorithm System)
    ============================================================================
]]--

-- 基于权重的概率选择函数 (Weight-based probability selection function)
-- 功能说明 (Function Description):
--   这是核心的概率选择算法，根据给定的权重数组进行加权随机选择。
--   该算法广泛用于AI行为选择、攻击模式选择、战术决策等各种情况。
--
-- 参数说明 (Parameters):
--   f52_arg0: AI实体对象 (AI entity object) - 提供随机数生成服务的AI对象
--   f52_arg1: 权重数组 (Weight array) - 包含各选项权重值的数组
--
-- 返回值 (Return Value):
--   正整数: 选中的选项索引（从1开始）
--   -1:      异常情况（所有权重为0或数组为空）
--
-- 算法实现原理 (Algorithm Implementation Principle):
--   1. 计算权重总和 (Calculate total weight sum)
--   2. 生成[0, 总和-1]范围内的随机数 (Generate random number in [0, total-1] range)
--   3. 从前向后遍历，用随机数逐次减去每个权重 (Iterate forward, subtracting each weight from random number)
--   4. 当随机数小于当前权重时，返回当前索引 (Return current index when random number is less than current weight)
--
-- 概率计算公式 (Probability Calculation Formula):
--   选项i的选中概率 = weight[i] / ∑(weight[j]) × 100%
--   例如：权重[10, 20, 30]，选中概率分别为[16.7%, 33.3%, 50%]
--
-- 性能特性 (Performance Characteristics):
--   - 时间复杂度：O(n)，n为选项数量
--   - 空间复杂度：O(1)，仅使用少量局部变量
--   - 随机数生成：使用游戏内置随机数发生器，确保可重现性
--
-- 边界情况处理 (Edge Case Handling):
--   - 空数组：返回-1
--   - 所有权重为0：返回-1
--   - 负权重：可能导致错误结果，调用方应避免
--
-- 使用示例 (Usage Examples):
--   local weights = {10, 20, 30}  -- 攻击模式权重
--   local selected = SelectOddsIndex(ai, weights)
--   if selected == 1 then
--       -- 执行第一种攻击模式（16.7%概率）
--   elseif selected == 2 then
--       -- 执行第二种攻击模式（33.3%概率）
--   elseif selected == 3 then
--       -- 执行第三种攻击模式（50%概率）
--   end
--
-- 应用场景 (Application Scenarios):
--   - AI行为选择：攻击/防御/移动等行为的权重选择
--   - 攻击模式选择：不同攻击动作的概率分配
--   - 战术策略选择：根据当前情况调整策略权重
--   - 随机事件触发：根据概率触发特殊事件
function SelectOddsIndex(f52_arg0, f52_arg1)
    local f52_local0 = table.getn(f52_arg1)               -- 获取数组长度 (Get array length)
    local f52_local1 = 0                                 -- 权重总和初始化 (Initialize weight total sum)

    -- 第一遍遍历：计算所有权重的总和 (First pass: calculate sum of all weights)
    for f52_local2 = 1, f52_local0, 1 do
        f52_local1 = f52_local1 + f52_arg1[f52_local2]
    end

    -- 边界情况检查：总权重为0时返回错误 (Edge case check: return error when total weight is 0)
    if f52_local1 <= 0 then
        return -1
    end

    -- 生成[0, 总权重-1]范围内的随机数 (Generate random number in [0, total_weight-1] range)
    local f52_local2 = f52_arg0:GetRandam_Int(0, f52_local1 - 1)

    -- 第二遍遍历：根据随机数确定选中的索引 (Second pass: determine selected index based on random number)
    for f52_local3 = 1, f52_local0, 1 do
        local f52_local6 = f52_arg1[f52_local3]           -- 当前选项的权重 (Current option's weight)
        if f52_local2 < f52_local6 then                   -- 随机数落在当前权重范围内 (Random number falls within current weight range)
            return f52_local3                             -- 返回当前索引 (Return current index)
        end
        f52_local2 = f52_local2 - f52_local6             -- 从随机数中减去当前权重 (Subtract current weight from random number)
    end

    -- 错误情况：正常情况下不应该执行到这里 (Error case: should not reach here under normal circumstances)
    return -1
end

-- 基于概率的函数选择器 (Probability-based function selector)
-- 功能说明 (Function Description):
--   结合概率选择算法和函数数组，实现基于权重的函数选择。
--   这是AI行为系统的高层封装，将概率计算和函数执行结合在一起。
--
-- 参数说明 (Parameters):
--   f53_arg0: AI实体对象 (AI entity object) - 提供随机数生成服务
--   f53_arg1: 权重数组 (Weight array) - 与函数数组对应的权重值
--   f53_arg2: 函数数组 (Function array) - 可执行的函数列表
--
-- 返回值 (Return Value):
--   函数引用: 根据概率选中的函数
--   nil:       选择失败或未找到合适的函数
--
-- 使用流程 (Usage Flow):
--   1. 调用SelectOddsIndex进行概率选择
--   2. 根据选中的索引从函数数组中获取对应函数
--   3. 返回选中的函数供调用方执行
--
-- 数据结构要求 (Data Structure Requirements):
--   - 权重数组和函数数组必须长度相同
--   - 数组索引一一对应：weight[i] <-> function[i]
--   - 函数数组中的元素必须是可调用的函数引用
--
-- 优势特点 (Advantages):
--   - 高层封装：隐藏了概率计算的复杂性
--   - 类型安全：返回的是函数引用而非索引
--   - 错误处理：异常情况下返回nil而非崩溃
--   - 灵活性：支持任意数量的函数选项
--
-- 应用示例 (Application Example):
--   local weights = {30, 50, 20}  -- 行为权重
--   local functions = {AttackFunc, DefendFunc, MoveFunc}  -- 行为函数
--   local selectedFunc = SelectFunc(ai, weights, functions)
--   if selectedFunc then
--       selectedFunc(ai, goal, ...)
--   end
--
-- 错误防护 (Error Protection):
--   - 验证数组长度一致性（调用方责任）
--   - 检查函数索引有效性
--   - 处理选择失败情况
function SelectFunc(f53_arg0, f53_arg1, f53_arg2)
    local f53_local0 = SelectOddsIndex(f53_arg0, f53_arg1) -- 执行概率选择算法 (Execute probability selection algorithm)
    if f53_local0 < 1 then                               -- 检查选择结果有效性 (Check selection result validity)
        return nil                                        -- 选择失败，返回nil (Selection failed, return nil)
    end
    return f53_arg2[f53_local0]                           -- 返回选中的函数引用 (Return selected function reference)
end

-- AI目标行为函数选择器 (AI goal action function selector)
-- 功能说明 (Function Description):
--   专门用于AI目标行为选择的高级封装函数。该函数自动获取AI对象的
--   行为函数表，并根据指定的权重进行选择。
--
-- 参数说明 (Parameters):
--   f54_arg0: AI配置对象 (AI configuration object) - 包含行为函数定义的AI配置
--   f54_arg1: AI实体对象 (AI entity object) - 执行行为的AI实体
--   f54_arg2: 权重数组 (Weight array) - 各行为的权重值
--
-- 返回值 (Return Value):
--   函数引用: 根据概率选中的AI行为函数
--   nil:       选择失败或没有可用的行为函数
--
-- 行为函数表结构 (Action Function Table Structure):
--   AI配置对象包含以下行为函数：
--   - Act01, Act02, ..., Act20: 基础行为函数（1-20号行为槽）
--   - 每个函数对应不同的战术行为（攻击、防御、移动等）
--
-- 调用流程 (Call Flow):
--   1. 调用_GetGoalActFuncTable获取行为函数表
--   2. 使用SelectFunc进行概率选择
--   3. 返回选中的行为函数
--
-- 与直接调用SelectFunc的区别 (Difference from Direct SelectFunc Call):
--   - 自动处理行为函数表获取
--   - 专门针对AI行为选择场景优化
--   - 简化了上层调用代码
--   - 提供了更好的封装和可读性
--
-- 使用场景 (Usage Scenarios):
--   - AI主行为循环中的行为选择
--   - 根据当前状态调整行为权重
--   - 实现动态的AI行为模式
--   - 战斗中的实时行为决策
--
-- 性能考虑 (Performance Considerations):
--   - 函数表获取是轻量级操作
--   - 概率计算复杂度为O(n)
--   - 适合在实时战斗中频繁调用
function SelectGoalFunc(f54_arg0, f54_arg1, f54_arg2)
    local f54_local0 = _GetGoalActFuncTable(f54_arg0)     -- 获取AI行为函数表 (Get AI action function table)
    return SelectFunc(f54_arg1, f54_arg2, f54_local0)     -- 执行概率选择并返回结果 (Execute probability selection and return result)
end

function CallAttackAndAfterFunc(f55_arg0, f55_arg1, f55_arg2, f55_arg3, f55_arg4, f55_arg5)
    local f55_local0 = SelectOddsIndex(f55_arg1, f55_arg3)
    local f55_local1 = 0
    if f55_local0 >= 1 then
        local f55_local2 = _GetGoalActFuncTable(f55_arg0)
        local f55_local3 = nil
        if f55_arg4 ~= nil then
            f55_local3 = f55_arg4[f55_local0]
        end
        f55_local1 = f55_local2[f55_local0](f55_arg0, f55_arg1, f55_arg2, f55_local3)
    end
    local f55_local2 = f55_arg1:GetRandam_Int(1, 100)
    if f55_local2 <= f55_local1 then
        if f55_arg0.ActAfter ~= nil then
            f55_arg0.ActAfter(f55_arg0, f55_arg1, f55_arg2, f55_arg5)
        else
            HumanCommon_ActAfter_AdjustSpace(f55_arg1, f55_arg2, f55_arg5)
        end
    end
    
end

function _GetGoalActFuncTable(f56_arg0)
    return {f56_arg0.Act01, f56_arg0.Act02, f56_arg0.Act03, f56_arg0.Act04, f56_arg0.Act05, f56_arg0.Act06, f56_arg0.Act07, f56_arg0.Act08, f56_arg0.Act09, f56_arg0.Act10, f56_arg0.Act11, f56_arg0.Act12, f56_arg0.Act13, f56_arg0.Act14, f56_arg0.Act15, f56_arg0.Act16, f56_arg0.Act17, f56_arg0.Act18, f56_arg0.Act19, f56_arg0.Act20}
    
end

function GetTargetAngle(f57_arg0, f57_arg1)
    if f57_arg0:IsInsideTarget(f57_arg1, AI_DIR_TYPE_F, 90) then
        if f57_arg0:IsInsideTarget(f57_arg1, AI_DIR_TYPE_F, 90) then
            return TARGET_ANGLE_FRONT
        elseif f57_arg0:IsInsideTarget(f57_arg1, AI_DIR_TYPE_L, 180) then
            return TARGET_ANGLE_LEFT
        else
            return TARGET_ANGLE_RIGHT
        end
    end
    if f57_arg0:IsInsideTarget(f57_arg1, AI_DIR_TYPE_L, 90) then
        return TARGET_ANGLE_LEFT
    elseif f57_arg0:IsInsideTarget(f57_arg1, AI_DIR_TYPE_R, 90) then
        return TARGET_ANGLE_RIGHT
    else
        return TARGET_ANGLE_BACK
    end
    
end


