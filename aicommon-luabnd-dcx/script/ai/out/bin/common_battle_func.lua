--[[============================================================================
    common_battle_func.lua - Sekiro AI战斗函数库 (Sekiro AI Battle Function Library)

    版本信息 (Version Info): v3.0 - Comprehensive documentation upgrade
    作者 (Author): FromSoftware AI Team / Enhanced by Claude Code
    最后修改 (Last Modified): 2025-09-28
    编码格式 (Encoding): Shift-JIS (required for Sekiro compatibility)

    ============================================================================
    模块概述 (Module Overview):
    ============================================================================
    这是Sekiro AI系统的核心战斗函数库，提供了基于权重的动态行为选择系统。
    该模块实现了AI战斗行为的统一管理和调度，支持50个可配置的行为槽位，
    每个槽位都可以独立配置权重、函数和参数，实现复杂的AI战斗逻辑。

    核心功能模块 (Core Function Modules):
    ┌─ 战斗行为管理 (Battle Behavior Management)
    │  ├─ Common_Clear_Param() - 清理和初始化行为参数
    │  ├─ Common_Battle_Activate() - 标准战斗行为激活器
    │  └─ Common_Kengeki_Activate() - 见切专用行为激活器
    │
    ├─ 默认行为函数 (Default Behavior Functions)
    │  ├─ defAct01-50() - 50个可配置的默认行为函数
    │  ├─ 每个函数对应一种基础的AI战斗模式
    │  └─ 支持参数覆盖和自定义配置
    │
    ├─ 人类通用行为 (Human Common Behaviors)
    │  ├─ HumanCommon_KeepDist_and_ThrowSomething() - 保持距离并投掷
    │  ├─ HumanCommon_ActAfter_AdjustSpace() - 攻击后调整空间
    │  ├─ HumanCommon_Approach_and_ComboAtk() - 接近并连击
    │  └─ HumanCommon_Shooting_Act() - 射击行为
    │
    └─ 工具函数 (Utility Functions)
       ├─ GET_PARAM_IF_NIL_DEF() - 参数默认值处理
       └─ REGIST_FUNC() - 函数注册器

    ============================================================================
    权重系统说明 (Weight System Explanation):
    ============================================================================
    行为选择算法采用基于权重的随机选择机制：

    1. 权重计算 (Weight Calculation):
       - 每个行为槽位都有独立的权重值
       - 权重为0的行为不会被选择
       - 权重越高，被选择的概率越大

    2. 选择算法 (Selection Algorithm):
       - 计算所有权重的总和
       - 生成0到总权重之间的随机数
       - 根据累积权重确定最终选择的行为

    3. 调试支持 (Debug Support):
       - 支持强制指定行为索引进行调试
       - 记录最后执行的行为索引
       - 提供详细的选择过程日志

    ============================================================================
    默认行为模式 (Default Behavior Patterns):
    ============================================================================
    defAct01-50: 基础攻击行为 (Basic Attack Behaviors)
    - 大部分使用Approach_and_Attack_Act模式
    - 默认攻击ID: 3000 (基础攻击)
    - 默认距离类型: DIST_Middle (中等距离)
    - 支持参数自定义覆盖

    特殊行为 (Special Behaviors):
    - defAct02, defAct09: 连击攻击 (Combo Attacks)
    - defAct04: 破防攻击 (Guard Break Attacks)
    - defAct05: 保持距离投掷 (Keep Distance & Throw)
    - defAct06: 远程攻击 (Ranged Attack)
    - defAct08: 观察招架时机 (Watch Parry Chance)
    - defAct10, defAct11: 射击行为 (Shooting Behaviors)

    ============================================================================
    性能优化考虑 (Performance Optimization Considerations):
    ============================================================================
    1. 函数表预生成：所有50个行为函数在激活时一次性生成，避免重复创建
    2. 权重快速计算：使用累积加法进行权重分布计算，时间复杂度O(n)
    3. 参数缓存：默认参数在函数内部缓存，减少重复的参数解析
    4. 调试模式优化：调试强制索引跳过权重计算，提高调试效率

    注意事项 (Important Notes):
    - 所有行为函数返回概率值(0-100)，用于后续行为触发判断
    - 参数数组支持nil值，系统会自动使用默认配置
    - 见切激活器与标准激活器使用相同的函数库但独立的调试索引
    ============================================================================
]]--

-- ===== 系统配置常量 (System Configuration Constants) =====
-- 最大支持的AI行为数量 (Maximum number of AI behaviors supported)
-- 这个值决定了整个系统可以管理的行为槽位数量，影响内存分配和循环次数
local f0_local0 = 50

--[[
函数名：Common_Clear_Param (通用参数清理函数)
功能描述：初始化和清理AI行为系统的参数数组，为新的行为周期准备数据结构
Function: Initialize and clear AI behavior system parameter arrays for new behavior cycle

参数说明：
  - f1_arg0: 行为权重数组 (behavior weight array) - 长度50，存储每个行为槽位的选择权重
  - f1_arg1: 行为函数数组 (behavior function array) - 长度50，存储每个行为的对应函数指针
  - f1_arg2: 行为参数配置数组 (behavior parameter config array) - 长度50，存储每个行为的参数表

返回值：无 (void)

功能说明：
  本函数遍历所有50个行为槽位，将它们重置为初始状态。这通常在AI开始新的决策周期时调用，
  确保之前的行为配置不会影响当前的决策过程。每个槽位被设置为：
  - 权重值为0（不会被选择）
  - 函数指针为nil（移除关联函数）
  - 参数表为空表（清空所有参数）

使用场景：
  - 在切换AI行为模式时调用
  - 在每个新的AI决策循环开始前调用
  - 在清除特定敌人的旧行为配置时调用

示例：
  local weightsTbl = {}
  local funcTbl = {}
  local paramsTbl = {}
  Common_Clear_Param(weightsTbl, funcTbl, paramsTbl)  -- 清理所有参数
]]--
function Common_Clear_Param(f1_arg0, f1_arg1, f1_arg2)
    local f1_local0 = 1
    -- 初始化所有50个行为槽位 (Initialize all 50 behavior slots)
    for f1_local1 = 1, f0_local0, 1 do
        f1_arg0[f1_local1] = 0        -- 权重设为0 (set weight to 0)
        f1_arg1[f1_local1] = nil      -- 函数指针清空 (clear function pointer)
        f1_arg2[f1_local1] = {}       -- 子目标配置清空 (clear sub-goal config)
    end


end

--[[
函数名：Common_Battle_Activate (标准战斗行为激活器)
功能描述：AI战斗系统的核心调度函数，根据权重分布进行加权随机选择并执行战斗行为
Function: Core AI combat behavior scheduler that performs weighted random selection and executes combat actions

参数说明：
  - f2_arg0: AI实体对象 (AI entity object) - 执行行为的AI角色，提供随机数生成和调试接口
  - f2_arg1: 目标对象 (Target object) - 行为的作用目标，通常是玩家或其他敌方角色
  - f2_arg2: 行为权重数组 (Behavior weight array) - 50个权重值，权重越高被选择概率越大
  - f2_arg3: 行为函数数组 (Behavior function array) - 50个自定义函数，为nil时使用对应的默认函数
  - f2_arg4: 后续行为函数 (Follow-up behavior function) - 攻击后执行的后续处理函数，nil时使用默认调整距离
  - f2_arg5: 行为参数配置数组 (Behavior parameter config array) - 每个行为的参数表，传递给行为函数

返回值：无 (void)

算法流程 (Algorithm Flow):
  1. 数据准备 (Data Preparation)
     - 构建50个行为函数的默认映射表
     - 合并自定义函数和默认函数
     - 计算所有权重的总和

  2. 行为选择 (Behavior Selection)
     - 检查调试强制索引（DbgGetForceActIdx）
     - 如果调试索引有效，直接选择指定行为
     - 否则生成0到总权重的随机数，按累积权重查找行为

  3. 行为执行 (Behavior Execution)
     - 调用选中的行为函数并获取返回概率值
     - 记录执行的行为索引到调试系统

  4. 后续处理 (Follow-up Processing)
     - 根据返回概率值决定是否触发后续行为
     - 使用HumanCommon_ActAfter_AdjustSpace调整位置和距离

性能特性 (Performance Characteristics):
  - 时间复杂度：O(n) 其中n=50
  - 空间复杂度：O(n) 用于临时函数表和权重表
  - 支持权重预计算以减少运行时开销

调试支持 (Debug Support):
  - DbgGetForceActIdx(): 获取强制指定的行为索引（调试用）
  - DbgSetLastActIdx(): 记录最后执行的行为索引用于回放和分析
  - 调试模式下可以强制执行特定行为进行测试

示例用法：
  local weights = {10, 20, 15, 0, 0, ...}  -- 50个权重值
  local functions = {nil, nil, ...}         -- 50个函数指针
  local params = {{}, {}, ...}              -- 50个参数表
  Common_Battle_Activate(aiObj, targetObj, weights, functions, nil, params)
]]--
function Common_Battle_Activate(f2_arg0, f2_arg1, f2_arg2, f2_arg3, f2_arg4, f2_arg5)
    local f2_local0 = {}  -- 临时权重表 (temporary weight table)
    local f2_local1 = {}  -- 临时函数表 (temporary function table)
    local f2_local2 = 0   -- 计数器，用于计算总权重 (counter for total weight calculation)

    -- 定义默认行为函数映射表 (Define default behavior function mapping table)
    -- 每个函数对应一个具体的AI行为实现 (Each function corresponds to a specific AI behavior implementation)
    local f2_local3 = {function ()
        return defAct01(f2_arg0, f2_arg1, f2_arg5[1])  -- 默认行为01 (Default behavior 01)

    end, function ()
        return defAct02(f2_arg0, f2_arg1, f2_arg5[2])  -- 默认行为02 (Default behavior 02)

    end, function ()
        return defAct03(f2_arg0, f2_arg1, f2_arg5[3])  -- 默认行为03 (Default behavior 03)

    end, function ()
        return defAct04(f2_arg0, f2_arg1, f2_arg5[4])  -- 默认行为04 (Default behavior 04)

    end, function ()
        return defAct05(f2_arg0, f2_arg1, f2_arg5[5])
        
    end, function ()
        return defAct06(f2_arg0, f2_arg1, f2_arg5[6])
        
    end, function ()
        return defAct07(f2_arg0, f2_arg1, f2_arg5[7])
        
    end, function ()
        return defAct08(f2_arg0, f2_arg1, f2_arg5[8])
        
    end, function ()
        return defAct09(f2_arg0, f2_arg1, f2_arg5[9])
        
    end, function ()
        return defAct10(f2_arg0, f2_arg1, f2_arg5[10])
        
    end, function ()
        return defAct11(f2_arg0, f2_arg1, f2_arg5[11])
        
    end, function ()
        return defAct12(f2_arg0, f2_arg1, f2_arg5[12])
        
    end, function ()
        return defAct13(f2_arg0, f2_arg1, f2_arg5[13])
        
    end, function ()
        return defAct14(f2_arg0, f2_arg1, f2_arg5[14])
        
    end, function ()
        return defAct15(f2_arg0, f2_arg1, f2_arg5[15])
        
    end, function ()
        return defAct16(f2_arg0, f2_arg1, f2_arg5[16])
        
    end, function ()
        return defAct17(f2_arg0, f2_arg1, f2_arg5[17])
        
    end, function ()
        return defAct18(f2_arg0, f2_arg1, f2_arg5[18])
        
    end, function ()
        return defAct19(f2_arg0, f2_arg1, f2_arg5[19])
        
    end, function ()
        return defAct20(f2_arg0, f2_arg1, f2_arg5[20])
        
    end, function ()
        return defAct21(f2_arg0, f2_arg1, f2_arg5[21])
        
    end, function ()
        return defAct22(f2_arg0, f2_arg1, f2_arg5[22])
        
    end, function ()
        return defAct23(f2_arg0, f2_arg1, f2_arg5[23])
        
    end, function ()
        return defAct24(f2_arg0, f2_arg1, f2_arg5[24])
        
    end, function ()
        return defAct25(f2_arg0, f2_arg1, f2_arg5[25])
        
    end, function ()
        return defAct26(f2_arg0, f2_arg1, f2_arg5[26])
        
    end, function ()
        return defAct27(f2_arg0, f2_arg1, f2_arg5[27])
        
    end, function ()
        return defAct28(f2_arg0, f2_arg1, f2_arg5[28])
        
    end, function ()
        return defAct29(f2_arg0, f2_arg1, f2_arg5[29])
        
    end, function ()
        return defAct30(f2_arg0, f2_arg1, f2_arg5[30])
        
    end, function ()
        return defAct31(f2_arg0, f2_arg1, f2_arg5[31])
        
    end, function ()
        return defAct32(f2_arg0, f2_arg1, f2_arg5[32])
        
    end, function ()
        return defAct33(f2_arg0, f2_arg1, f2_arg5[33])
        
    end, function ()
        return defAct34(f2_arg0, f2_arg1, f2_arg5[34])
        
    end, function ()
        return defAct35(f2_arg0, f2_arg1, f2_arg5[35])
        
    end, function ()
        return defAct36(f2_arg0, f2_arg1, f2_arg5[36])
        
    end, function ()
        return defAct37(f2_arg0, f2_arg1, f2_arg5[37])
        
    end, function ()
        return defAct38(f2_arg0, f2_arg1, f2_arg5[38])
        
    end, function ()
        return defAct39(f2_arg0, f2_arg1, f2_arg5[39])
        
    end, function ()
        return defAct40(f2_arg0, f2_arg1, f2_arg5[40])
        
    end, function ()
        return defAct41(f2_arg0, f2_arg1, f2_arg5[41])
        
    end, function ()
        return defAct42(f2_arg0, f2_arg1, f2_arg5[42])
        
    end, function ()
        return defAct43(f2_arg0, f2_arg1, f2_arg5[43])
        
    end, function ()
        return defAct44(f2_arg0, f2_arg1, f2_arg5[44])
        
    end, function ()
        return defAct45(f2_arg0, f2_arg1, f2_arg5[45])
        
    end, function ()
        return defAct46(f2_arg0, f2_arg1, f2_arg5[46])
        
    end, function ()
        return defAct47(f2_arg0, f2_arg1, f2_arg5[47])
        
    end, function ()
        return defAct48(f2_arg0, f2_arg1, f2_arg5[48])
        
    end, function ()
        return defAct49(f2_arg0, f2_arg1, f2_arg5[49])
        
    end, function ()
        return defAct50(f2_arg0, f2_arg1, f2_arg5[50])
        
    end}

    -- 第一阶段：合并自定义和默认函数，计算总权重
    -- Phase 1: Merge custom and default functions, calculate total weight
    local f2_local4 = 1
    for f2_local5 = 1, f0_local0, 1 do
        -- 如果提供了自定义函数则使用自定义函数，否则使用默认函数
        -- Use custom function if provided, otherwise use default function
        if f2_arg3[f2_local5] ~= nil then
            f2_local0[f2_local5] = f2_arg3[f2_local5]
        else
            f2_local0[f2_local5] = f2_local3[f2_local5]
        end
        -- 复制权重值到临时表
        -- Copy weight values to temporary table
        f2_local1[f2_local5] = f2_arg2[f2_local5]
        -- 累加总权重（用于后续的加权随机选择）
        -- Accumulate total weight (for subsequent weighted random selection)
        f2_local2 = f2_local2 + f2_local1[f2_local5]
    end

    -- 第二阶段：设置后续行为处理函数
    -- Phase 2: Set follow-up behavior handler
    local f2_local5 = nil
    if f2_arg4 ~= nil then
        -- 使用传入的自定义后续行为处理函数
        -- Use custom follow-up behavior handler
        f2_local5 = f2_arg4
    else
        -- 使用默认后续行为处理函数：调整攻击后的位置和距离
        -- Use default follow-up behavior handler: adjust position and distance after attack
        f2_local5 = function ()
            HumanCommon_ActAfter_AdjustSpace(f2_arg0, f2_arg1, atkAfterOddsTbl)

        end
    end

    -- 第三阶段：行为选择（支持调试强制索引）
    -- Phase 3: Behavior selection (supports debug force index)
    local f2_local6 = 0  -- 行为函数的返回概率值 (return probability value from behavior function)
    if kengekiId == nil then
        kengekiId = 0
    end
    local f2_local7 = 0  -- 调试强制索引 (debug force index)
    f2_local7 = f2_arg0:DbgGetForceActIdx()

    -- 如果调试强制索引有效，直接执行指定行为
    -- If debug force index is valid, directly execute specified behavior
    if 0 < f2_local7 and f2_local7 <= f0_local0 then
        f2_local6 = f2_local0[f2_local7]()
        f2_arg0:DbgSetLastActIdx(f2_local7)
    else
        -- 执行加权随机选择算法
        -- Execute weighted random selection algorithm
        local f2_local8 = f2_arg0:GetRandam_Int(1, f2_local2)  -- 生成1到总权重之间的随机数
        local f2_local9 = 0   -- 累积权重计数器 (cumulative weight counter)
        local f2_local10 = 1  -- 遍历计数器 (iteration counter)
        for f2_local11 = 1, f0_local0, 1 do
            -- 累加当前权重
            -- Accumulate current weight
            f2_local9 = f2_local9 + f2_local1[f2_local11]
            -- 如果随机数落在当前区间内，选择此行为
            -- If random number falls within current range, select this behavior
            if f2_local8 <= f2_local9 then
                f2_local6 = f2_local0[f2_local11]()
                f2_arg0:DbgSetLastActIdx(f2_local11)
                f2_local11 = f0_local0  -- 提前跳出循环 (early exit loop)
            end
        end
    end

    -- 第四阶段：根据返回概率决定是否触发后续行为
    -- Phase 4: Determine whether to trigger follow-up behavior based on return probability
    local f2_local8 = f2_arg0:GetRandam_Int(1, 100)  -- 生成0-100的随机数 (generate 0-100 random number)
    if f2_local6 == nil then
        f2_local6 = 0  -- 如果返回值为nil，设为0（不触发后续行为）
    end
    -- 如果随机数小于等于返回概率，触发后续行为处理
    -- If random number is less than or equal to return probability, trigger follow-up behavior
    if f2_local8 <= f2_local6 then
        f2_local5()
    end


end

--[[
函数名：Common_Kengeki_Activate (见切专用行为激活器)
功能描述：只狼"见切"机制的专用行为激活器，支持弹刀反击行为的独立调度和管理
Function: Dedicated behavior activator for Sekiro's "Kengeki" (parry counter) mechanism with independent scheduling

参数说明：
  - f54_arg0: AI实体对象 (AI entity object) - 执行见切行为的AI角色
  - f54_arg1: 目标对象 (Target object) - 见切行为的作用目标
  - f54_arg2: 行为权重数组 (Behavior weight array) - 50个权重值，控制见切行为选择
  - f54_arg3: 行为函数数组 (Behavior function array) - 50个自定义见切函数
  - f54_arg4: 后续行为函数 (Follow-up behavior function) - 见切后的后续处理
  - f54_arg5: 行为参数配置数组 (Behavior parameter config array) - 见切函数的参数表

返回值：布尔值 (boolean)
  - true: 见切行为成功执行或触发后续行为
  - false: 权重总和为0或返回概率为-1且未强制指定行为

功能说明：
  本函数用于处理只狼游戏中见切（弹刀）机制。见切是BOSS在弹开玩家攻击时进行的反击行为。
  该函数与Common_Battle_Activate的逻辑相同，但使用独立的调试索引（DbgGetForceKengekiActIdx）
  和返回值机制，允许对见切行为进行独立的权重配置和调试。

性能特性 (Performance Characteristics):
  - 时间复杂度：O(n) 其中n=50
  - 与标准激活器使用相同的算法，区别仅在调试索引命名
  - 返回值可用于判断行为是否真正执行

调试支持 (Debug Support):
  - DbgGetForceKengekiActIdx(): 获取强制指定的见切行为索引
  - DbgSetLastKengekiActIdx(): 记录最后执行的见切行为索引

示例用法：
  local kengekiWeights = {0, 10, 20, 0, ...}  -- 见切行为权重
  local kengekiFuncs = {nil, nil, ...}        -- 见切函数
  local result = Common_Kengeki_Activate(aiObj, targetObj, kengekiWeights, kengekiFuncs, nil, params)
  if result then
    -- 见切行为成功执行
  end
]]--
function Common_Kengeki_Activate(f54_arg0, f54_arg1, f54_arg2, f54_arg3, f54_arg4, f54_arg5)
    local f54_local0 = {}  -- 见切函数表 (kengeki function table)
    local f54_local1 = {}  -- 见切权重表 (kengeki weight table)
    local f54_local2 = 0   -- 总权重计数器 (total weight counter)

    local f54_local3 = {function ()
        return defAct01(f54_arg0, f54_arg1, f54_arg5[1])
        
    end, function ()
        return defAct02(f54_arg0, f54_arg1, f54_arg5[2])
        
    end, function ()
        return defAct03(f54_arg0, f54_arg1, f54_arg5[3])
        
    end, function ()
        return defAct04(f54_arg0, f54_arg1, f54_arg5[4])
        
    end, function ()
        return defAct05(f54_arg0, f54_arg1, f54_arg5[5])
        
    end, function ()
        return defAct06(f54_arg0, f54_arg1, f54_arg5[6])
        
    end, function ()
        return defAct07(f54_arg0, f54_arg1, f54_arg5[7])
        
    end, function ()
        return defAct08(f54_arg0, f54_arg1, f54_arg5[8])
        
    end, function ()
        return defAct09(f54_arg0, f54_arg1, f54_arg5[9])
        
    end, function ()
        return defAct10(f54_arg0, f54_arg1, f54_arg5[10])
        
    end, function ()
        return defAct11(f54_arg0, f54_arg1, f54_arg5[11])
        
    end, function ()
        return defAct12(f54_arg0, f54_arg1, f54_arg5[12])
        
    end, function ()
        return defAct13(f54_arg0, f54_arg1, f54_arg5[13])
        
    end, function ()
        return defAct14(f54_arg0, f54_arg1, f54_arg5[14])
        
    end, function ()
        return defAct15(f54_arg0, f54_arg1, f54_arg5[15])
        
    end, function ()
        return defAct16(f54_arg0, f54_arg1, f54_arg5[16])
        
    end, function ()
        return defAct17(f54_arg0, f54_arg1, f54_arg5[17])
        
    end, function ()
        return defAct18(f54_arg0, f54_arg1, f54_arg5[18])
        
    end, function ()
        return defAct19(f54_arg0, f54_arg1, f54_arg5[19])
        
    end, function ()
        return defAct20(f54_arg0, f54_arg1, f54_arg5[20])
        
    end, function ()
        return defAct21(f54_arg0, f54_arg1, f54_arg5[21])
        
    end, function ()
        return defAct22(f54_arg0, f54_arg1, f54_arg5[22])
        
    end, function ()
        return defAct23(f54_arg0, f54_arg1, f54_arg5[23])
        
    end, function ()
        return defAct24(f54_arg0, f54_arg1, f54_arg5[24])
        
    end, function ()
        return defAct25(f54_arg0, f54_arg1, f54_arg5[25])
        
    end, function ()
        return defAct26(f54_arg0, f54_arg1, f54_arg5[26])
        
    end, function ()
        return defAct27(f54_arg0, f54_arg1, f54_arg5[27])
        
    end, function ()
        return defAct28(f54_arg0, f54_arg1, f54_arg5[28])
        
    end, function ()
        return defAct29(f54_arg0, f54_arg1, f54_arg5[29])
        
    end, function ()
        return defAct30(f54_arg0, f54_arg1, f54_arg5[30])
        
    end, function ()
        return defAct31(f54_arg0, f54_arg1, f54_arg5[31])
        
    end, function ()
        return defAct32(f54_arg0, f54_arg1, f54_arg5[32])
        
    end, function ()
        return defAct33(f54_arg0, f54_arg1, f54_arg5[33])
        
    end, function ()
        return defAct34(f54_arg0, f54_arg1, f54_arg5[34])
        
    end, function ()
        return defAct35(f54_arg0, f54_arg1, f54_arg5[35])
        
    end, function ()
        return defAct36(f54_arg0, f54_arg1, f54_arg5[36])
        
    end, function ()
        return defAct37(f54_arg0, f54_arg1, f54_arg5[37])
        
    end, function ()
        return defAct38(f54_arg0, f54_arg1, f54_arg5[38])
        
    end, function ()
        return defAct39(f54_arg0, f54_arg1, f54_arg5[39])
        
    end, function ()
        return defAct40(f54_arg0, f54_arg1, f54_arg5[40])
        
    end, function ()
        return defAct41(f54_arg0, f54_arg1, f54_arg5[41])
        
    end, function ()
        return defAct42(f54_arg0, f54_arg1, f54_arg5[42])
        
    end, function ()
        return defAct43(f54_arg0, f54_arg1, f54_arg5[43])
        
    end, function ()
        return defAct44(f54_arg0, f54_arg1, f54_arg5[44])
        
    end, function ()
        return defAct45(f54_arg0, f54_arg1, f54_arg5[45])
        
    end, function ()
        return defAct46(f54_arg0, f54_arg1, f54_arg5[46])
        
    end, function ()
        return defAct47(f54_arg0, f54_arg1, f54_arg5[47])
        
    end, function ()
        return defAct48(f54_arg0, f54_arg1, f54_arg5[48])
        
    end, function ()
        return defAct49(f54_arg0, f54_arg1, f54_arg5[49])
        
    end, function ()
        return defAct50(f54_arg0, f54_arg1, f54_arg5[50])
        
    end}

    -- 第一阶段：合并自定义和默认函数，计算总权重
    -- Phase 1: Merge custom and default functions, calculate total weight
    local f54_local4 = 1
    for f54_local5 = 1, f0_local0, 1 do
        -- 选择自定义见切函数或默认函数
        -- Select custom kengeki function or default function
        if f54_arg3[f54_local5] ~= nil then
            f54_local0[f54_local5] = f54_arg3[f54_local5]
        else
            f54_local0[f54_local5] = f54_local3[f54_local5]
        end
        -- 复制权重值
        -- Copy weight values
        f54_local1[f54_local5] = f54_arg2[f54_local5]
        -- 累加总权重
        -- Accumulate total weight
        f54_local2 = f54_local2 + f54_local1[f54_local5]
    end

    -- 第二阶段：设置见切后的后续处理函数
    -- Phase 2: Set post-kengeki follow-up handler
    local f54_local5 = nil
    if f54_arg4 ~= nil then
        -- 使用自定义后续处理
        -- Use custom follow-up handler
        f54_local5 = f54_arg4
    else
        -- 使用默认后续处理：调整距离
        -- Use default follow-up handler: adjust distance
        f54_local5 = function ()
            HumanCommon_ActAfter_AdjustSpace(f54_arg0, f54_arg1, atkAfterOddsTbl)

        end
    end

    -- 第三阶段：见切行为选择（支持调试强制索引）
    -- Phase 3: Kengeki behavior selection (supports debug force index)
    local f54_local6 = 0  -- 见切行为返回概率 (kengeki behavior return probability)
    local f54_local7 = f54_arg0:DbgGetForceKengekiActIdx()  -- 获取调试强制见切索引

    -- 如果调试强制索引有效
    -- If debug force index is valid
    if 0 < f54_local7 and f54_local7 <= f0_local0 then
        f54_local6 = f54_local0[f54_local7]()
        f54_arg0:DbgSetLastKengekiActIdx(f54_local7)
    else
        -- 执行见切行为的加权随机选择
        -- Execute weighted random selection for kengeki behavior
        local f54_local8 = f54_arg0:GetRandam_Int(1, f54_local2)  -- 随机数（1到总权重）
        local f54_local9 = 0   -- 累积权重 (cumulative weight)
        local f54_local10 = 1  -- 遍历计数器 (iteration counter)
        for f54_local11 = 1, f0_local0, 1 do
            -- 累加权重
            -- Accumulate weight
            f54_local9 = f54_local9 + f54_local1[f54_local11]
            -- 检查随机数是否落在此区间
            -- Check if random number falls within this range
            if f54_local8 <= f54_local9 then
                f54_local6 = f54_local0[f54_local11]()
                f54_arg0:DbgSetLastKengekiActIdx(f54_local11)
                f54_local11 = f0_local0  -- 跳出循环 (break loop)
            end
        end
    end

    -- 第四阶段：根据返回概率触发后续处理
    -- Phase 4: Trigger follow-up handler based on return probability
    local f54_local8 = f54_arg0:GetRandam_Int(1, 100)  -- 后续行为触发概率 (follow-up trigger probability)
    if f54_local6 == nil then
        f54_local6 = 0
    end
    -- 根据概率触发后续行为
    -- Trigger follow-up behavior based on probability
    if f54_local8 <= f54_local6 then
        f54_local5()
    end

    -- 返回值判断
    -- Return value decision:
    -- 如果总权重为0且没有强制索引，说明没有可用的见切行为
    -- If total weight is 0 and no force index, no available kengeki behavior
    -- 如果返回概率为-1，也表示行为不可执行
    -- If return probability is -1, also indicates action is not executable
    if (f54_local2 == 0 or f54_local6 == -1) and f54_local7 == 0 then
        return false
    else
        return true
    end


end

--[[
函数名：defAct01 (默认行为01 - 基础接近并攻击)
功能描述：标准的接近敌人并进行攻击的行为，使用中等距离
Function: Standard approach and attack behavior using medium distance range

参数说明：
  - f106_arg0: AI实体对象 (AI entity object) - 执行攻击的AI角色
  - f106_arg1: 目标对象 (Target object) - 被攻击的目标
  - f106_arg2: 行为参数表 (Behavior parameter table) - 包含以下信息：
    [1]: 接近距离阈值 (approach threshold) - 默认1.5米
    [2]: 接近延迟 (approach delay) - 默认0
    [3]: 攻击ID (attack ID) - 默认3000（基础攻击）
    [4]: 距离类型 (distance type) - 默认DIST_Middle（中等距离）
    [5]: 触发概率 (trigger probability) - 默认100

返回值：数值 - 触发后续行为的概率百分比（0-100）

默认参数：
  - 接近距离: 1.5米
  - 攻击延迟: 0秒
  - 攻击ID: 3000
  - 距离类型: DIST_Middle
  - 概率: 100%

使用场景：
  - 敌人与玩家距离较近时（3-5米）
  - 作为通用的基础攻击行为
  - 大多数普通敌人的默认攻击模式

示例配置：
  defAct01参数 = {1.5, 0, 3000, DIST_Middle, 100}  -- 标准配置
]]--
function defAct01(f106_arg0, f106_arg1, f106_arg2)
    -- 默认参数表 (default parameter table)
    local f106_local0 = {1.5, 0, 3000, DIST_Middle, nil}
    -- 如果传入了自定义参数，使用自定义参数覆盖默认值
    -- If custom parameters provided, override defaults
    if f106_arg2[1] ~= nil then
        f106_local0 = f106_arg2
    end
    -- 解析参数 (parse parameters)
    local f106_local1 = f106_local0[1]           -- 接近距离阈值 (approach threshold)
    local f106_local2 = f106_local0[1] + 2       -- 接近最大距离 (max approach distance)
    local f106_local3 = f106_local0[2]           -- 接近延迟 (approach delay)
    local f106_local4 = f106_local0[3]           -- 攻击ID (attack ID)
    local f106_local5 = f106_local0[4]           -- 距离类型 (distance type)
    local f106_local6 = GET_PARAM_IF_NIL_DEF(f106_local0[5], 100)  -- 后续行为触发概率 (follow-up trigger probability)
    -- 执行接近并攻击行为 (execute approach and attack)
    Approach_and_Attack_Act(f106_arg0, f106_arg1, f106_local1, f106_local2, f106_local3, f106_local4, f106_local5)
    return f106_local6


end

--[[
函数名：defAct02 (默认行为02 - 连击攻击)
功能描述：接近敌人后进行多段连击的行为，包含不同的连击模式
Function: Approach and perform combo attack behavior with multiple combo patterns

参数说明：
  - f107_arg0: AI实体对象 (AI entity object)
  - f107_arg1: 目标对象 (Target object)
  - f107_arg2: 行为参数表 (Behavior parameter table) - 包含以下信息：
    [1]: 接近距离阈值 (approach threshold) - 默认1.5米
    [2]: 接近延迟 (approach delay) - 默认0
    [3]: 单段攻击概率 (single attack probability) - 默认10%
    [4]: 两段连击概率 (combo probability) - 默认40%
    [5]: 首段攻击ID (first attack ID) - 默认3000
    [6]: 第二段攻击ID (second attack ID) - 默认3001
    [7]: 第三段攻击ID (third attack ID) - 默认3002
    [8]: 后续行为触发概率 (follow-up trigger probability) - 默认100

返回值：数值 - 触发后续行为的概率百分比（0-100）

默认参数：
  - 接近距离: 1.5米
  - 单段攻击: 10%
  - 两段连击: 40%
  - 三段连击: 50%（剩余百分比）

连击模式说明：
  模式1（10% 概率）: 单段攻击 (3000)
  模式2（40% 概率）: 两段连击 (3000 -> 3001)
  模式3（50% 概率）: 三段连击 (3000 -> 3001 -> 3002)

使用场景：
  - 敌人想要造成更多伤害的连击策略
  - 大型敌人或BOSS的攻击模式
  - 需要保持玩家压力的高难度战斗

示例配置：
  defAct02参数 = {1.5, 0, 10, 40, 3000, 3001, 3002, 100}  -- 标准连击配置
]]--
function defAct02(f107_arg0, f107_arg1, f107_arg2)
    -- 默认参数表 (default parameter table)
    local f107_local0 = {1.5, 0, 10, 40, nil, nil, nil, nil}
    -- 使用自定义参数或默认参数 (use custom or default parameters)
    if f107_arg2[1] ~= nil then
        f107_local0 = f107_arg2
    end
    -- 调用人类通用的接近并连击函数 (call human common approach and combo function)
    return HumanCommon_Approach_and_ComboAtk(f107_arg0, f107_arg1, f107_local0)


end

--[[
函数名：defAct03 (默认行为03 - 第二种基础攻击)
功能描述：使用不同攻击ID的标准接近并攻击行为
Function: Standard approach and attack with alternative attack ID (3005)
]]--
function defAct03(f108_arg0, f108_arg1, f108_arg2)
    local f108_local0 = {1.5, 0, 3005, DIST_Middle, nil}
    if f108_arg2[1] ~= nil then
        f108_local0 = f108_arg2
    end
    local f108_local1 = f108_local0[1]
    local f108_local2 = f108_local0[1] + 2
    local f108_local3 = f108_local0[2]
    local f108_local4 = f108_local0[3]
    local f108_local5 = f108_local0[4]
    local f108_local6 = GET_PARAM_IF_NIL_DEF(f108_local0[5], 100)
    Approach_and_Attack_Act(f108_arg0, f108_arg1, f108_local1, f108_local2, f108_local3, f108_local4, f108_local5)
    return f108_local6


end

--[[
函数名：defAct04 (默认行为04 - 破防攻击)
功能描述：执行破防（guard break）攻击序列，用于击破玩家的防御
Function: Guard break attack sequence for breaking player's guard

参数说明：
  - f109_arg2: 行为参数表
    [1]: 接近距离阈值 - 默认5米
    [3]: 破防主攻击ID - 默认3007
    [4]: 距离类型 - 默认DIST_Middle
    [5]: 后续普通攻击ID - 默认3005
    [6]: 距离类型 - 默认DIST_Middle
    [7]: 触发概率 - 默认100
]]--
function defAct04(f109_arg0, f109_arg1, f109_arg2)
    local f109_local0 = {5, 0, 3007, DIST_Middle, 3005, DIST_Middle, nil}
    if f109_arg2[1] ~= nil then
        f109_local0 = f109_arg2
    end
    local f109_local1 = f109_local0[1]
    local f109_local2 = f109_local0[1] + 2
    local f109_local3 = f109_local0[2]
    local f109_local4 = f109_local0[3]
    local f109_local5 = f109_local0[4]
    local f109_local6 = f109_local0[5]
    local f109_local7 = f109_local0[6]
    local f109_local8 = GET_PARAM_IF_NIL_DEF(f109_local0[7], 100)
    Approach_and_GuardBreak_Act(f109_arg0, f109_arg1, f109_local1, f109_local2, f109_local3, f109_local4, f109_local5, f109_local6, f109_local7)
    return f109_local8
    
end

--[[
函数名：defAct05 (默认行为05 - 保持距离并投掷)
功能描述：与敌人保持一定距离，同时进行投掷物品或远程攻击
Function: Keep distance while throwing projectiles or using ranged attack

参数说明：
  - f110_arg2: 行为参数表
    [1]: 最小距离 - 默认4米
    [2]: 最大距离 - 默认6米
    [3]: 投掷延迟 - 默认0
    [4]: 投掷物品ID - 默认3008
    [5]: 距离类型 - 默认DIST_None
    [6]: 触发概率 - 默认0

使用场景：
  - 敌人拥有投掷物品能力时
  - 大型敌人或BOSS的远程攻击策略
  - 需要保持距离的战斗场景
]]--
function defAct05(f110_arg0, f110_arg1, f110_arg2)
    local f110_local0 = {4, 6, 0, 3008, DIST_None, nil}
    if f110_arg2[1] ~= nil then
        f110_local0 = f110_arg2
    end
    return HumanCommon_KeepDist_and_ThrowSomething(f110_arg0, f110_arg1, f110_local0)


end

--[[
函数名：defAct06 (默认行为06 - 远距离攻击)
功能描述：在远距离对敌人进行攻击，通常用于弓箭或法术等远程武器
Function: Long-range attack behavior for bows, magic, or other ranged weapons

参数说明：
  - f111_arg2: 行为参数表
    [1]: 攻击ID - 默认3000
    [2]: 距离类型 - 默认DIST_Far（远距离）
    [3]: 触发概率 - 默认0

使用场景：
  - 敌人拥有弓箭或远程魔法
  - 需要远距离骚扰玩家的策略
]]--
function defAct06(f111_arg0, f111_arg1, f111_arg2)
    local f111_local0 = {3000, DIST_Far, nil}
    if f111_arg2[1] ~= nil then
        f111_local0 = f111_arg2
    end
    local f111_local1 = GET_PARAM_IF_NIL_DEF(f111_local0[3], 0)
    f111_arg1:AddSubGoal(GOAL_COMMON_Attack, 10, f111_local0[1], TARGET_ENE_0, f111_local0[2], 0)
    return f111_local1


end

--[[
函数名：defAct07 (默认行为07 - 第三种基础攻击)
功能描述：使用3001攻击ID的标准接近并攻击行为，返回概率100%
Function: Standard approach and attack with attack ID 3001, always triggers follow-up
]]--
function defAct07(f112_arg0, f112_arg1, f112_arg2)
    local f112_local0 = {1.5, 0, 3001, DIST_Middle}
    if f112_arg2[1] ~= nil then
        f112_local0 = f112_arg2
    end
    local f112_local1 = f112_local0[1]
    local f112_local2 = f112_local0[1] + 2
    local f112_local3 = f112_local0[2]
    local f112_local4 = f112_local0[3]
    local f112_local5 = f112_local0[4]
    Approach_and_Attack_Act(f112_arg0, f112_arg1, f112_local1, f112_local2, f112_local3, f112_local4, f112_local5)
    return 100


end

--[[
函数名：defAct08 (默认行为08 - 观察招架时机)
功能描述：敌人观察玩家的招架（parry）时机，等待合适的反击机会
Function: Watch for player's parry chances and wait for counter-attack opportunity

参数说明：
  - f113_arg2: 行为参数表
    [1]: 触发概率 - 默认0

使用场景：
  - BOSS和高难敌人的防守策略
  - 观察玩家防守后寻求反击机会
  - 只狼游戏中的见切（招架）对抗机制
]]--
function defAct08(f113_arg0, f113_arg1, f113_arg2)
    local f113_local0 = {nil}
    if f113_arg2[1] ~= nil then
        f113_local0 = f113_arg2
    end
    local f113_local1 = GET_PARAM_IF_NIL_DEF(f113_local0[1], 0)
    Watching_Parry_Chance_Act(f113_arg0, f113_arg1)
    return f113_local1


end

--[[
函数名：defAct09 (默认行为09 - 第二种连击攻击)
功能描述：另一种连击行为配置，可能有不同的参数组合
Function: Alternative combo attack configuration with potentially different combo patterns
]]--
function defAct09(f114_arg0, f114_arg1, f114_arg2)
    local f114_local0 = {1.5, 0, 10, 40, nil, nil, nil, nil}
    if f114_arg2[1] ~= nil then
        f114_local0 = f114_arg2
    end
    return HumanCommon_Approach_and_ComboAtk(f114_arg0, f114_arg1, f114_local0)


end

--[[
函数名：defAct10 (默认行为10 - 第一种射击行为)
功能描述：执行射击动作（弓箭、法术等），包含2-4秒的随机射击间隔
Function: First shooting behavior with 2-4 second random interval between shots
]]--
function defAct10(f115_arg0, f115_arg1, f115_arg2)
    local f115_local0 = {3000, 3001, 2, 4, 0}
    if f115_arg2[1] ~= nil then
        f115_local0 = f115_arg2
    end
    return HumanCommon_Shooting_Act(f115_arg0, f115_arg1, Tbl)


end

--[[
函数名：defAct11 (默认行为11 - 第二种射击行为)
功能描述：使用不同攻击ID（3002、3003）的射击行为
Function: Alternative shooting behavior with different attack IDs (3002, 3003)
]]--
function defAct11(f116_arg0, f116_arg1, f116_arg2)
    local f116_local0 = {3002, 3003, 2, 4, 0}
    if f116_arg2[1] ~= nil then
        f116_local0 = f116_arg2
    end
    return HumanCommon_Shooting_Act(f116_arg0, f116_arg1, Tbl)


end

--[[
函数名：defAct12 (默认行为12 - 第四种基础攻击)
功能描述：使用3001攻击ID的标准接近并攻击行为
Function: Standard approach and attack with attack ID 3001
]]--
function defAct12(f117_arg0, f117_arg1, f117_arg2)
    local f117_local0 = {1.5, 0, 3001, DIST_Middle}
    if f117_arg2[1] ~= nil then
        f117_local0 = f117_arg2
    end
    local f117_local1 = f117_local0[1]
    local f117_local2 = f117_local0[1] + 2
    local f117_local3 = f117_local0[2]
    local f117_local4 = f117_local0[3]
    local f117_local5 = f117_local0[4]
    Approach_and_Attack_Act(f117_arg0, f117_arg1, f117_local1, f117_local2, f117_local3, f117_local4, f117_local5)
    return 100
    
end

-- defAct13 - 默认行为13：基础接近攻击（攻击ID: 3000）
function defAct13(f118_arg0, f118_arg1, f118_arg2)
    local f118_local0 = {1.5, 0, 3000, DIST_Middle, nil}
    if f118_arg2[1] ~= nil then
        f118_local0 = f118_arg2
    end
    local f118_local1 = f118_local0[1]
    local f118_local2 = f118_local0[1] + 2
    local f118_local3 = f118_local0[2]
    local f118_local4 = f118_local0[3]
    local f118_local5 = f118_local0[4]
    local f118_local6 = GET_PARAM_IF_NIL_DEF(f118_local0[5], 100)
    Approach_and_Attack_Act(f118_arg0, f118_arg1, f118_local1, f118_local2, f118_local3, f118_local4, f118_local5)
    return f118_local6


end

-- defAct14 - 默认行为14：基础接近攻击（攻击ID: 3000）
function defAct14(f119_arg0, f119_arg1, f119_arg2)
    local f119_local0 = {1.5, 0, 3000, DIST_Middle, nil}
    if f119_arg2[1] ~= nil then
        f119_local0 = f119_arg2
    end
    local f119_local1 = f119_local0[1]
    local f119_local2 = f119_local0[1] + 2
    local f119_local3 = f119_local0[2]
    local f119_local4 = f119_local0[3]
    local f119_local5 = f119_local0[4]
    local f119_local6 = GET_PARAM_IF_NIL_DEF(f119_local0[5], 100)
    Approach_and_Attack_Act(f119_arg0, f119_arg1, f119_local1, f119_local2, f119_local3, f119_local4, f119_local5)
    return f119_local6


end

-- defAct15 - 默认行为15：基础接近攻击（攻击ID: 3000）
function defAct15(f120_arg0, f120_arg1, f120_arg2)
    local f120_local0 = {1.5, 0, 3000, DIST_Middle, nil}
    if f120_arg2[1] ~= nil then
        f120_local0 = f120_arg2
    end
    local f120_local1 = f120_local0[1]
    local f120_local2 = f120_local0[1] + 2
    local f120_local3 = f120_local0[2]
    local f120_local4 = f120_local0[3]
    local f120_local5 = f120_local0[4]
    local f120_local6 = GET_PARAM_IF_NIL_DEF(f120_local0[5], 100)
    Approach_and_Attack_Act(f120_arg0, f120_arg1, f120_local1, f120_local2, f120_local3, f120_local4, f120_local5)
    return f120_local6


end

-- defAct16 - 默认行为16：基础接近攻击（攻击ID: 3000）
function defAct16(f121_arg0, f121_arg1, f121_arg2)
    local f121_local0 = {1.5, 0, 3000, DIST_Middle, nil}
    if f121_arg2[1] ~= nil then
        f121_local0 = f121_arg2
    end
    local f121_local1 = f121_local0[1]
    local f121_local2 = f121_local0[1] + 2
    local f121_local3 = f121_local0[2]
    local f121_local4 = f121_local0[3]
    local f121_local5 = f121_local0[4]
    local f121_local6 = GET_PARAM_IF_NIL_DEF(f121_local0[5], 100)
    Approach_and_Attack_Act(f121_arg0, f121_arg1, f121_local1, f121_local2, f121_local3, f121_local4, f121_local5)
    return f121_local6


end

-- defAct17 - 默认行为17：基础接近攻击（攻击ID: 3000）
function defAct17(f122_arg0, f122_arg1, f122_arg2)
    local f122_local0 = {1.5, 0, 3000, DIST_Middle, nil}
    if f122_arg2[1] ~= nil then
        f122_local0 = f122_arg2
    end
    local f122_local1 = f122_local0[1]
    local f122_local2 = f122_local0[1] + 2
    local f122_local3 = f122_local0[2]
    local f122_local4 = f122_local0[3]
    local f122_local5 = f122_local0[4]
    local f122_local6 = GET_PARAM_IF_NIL_DEF(f122_local0[5], 100)
    Approach_and_Attack_Act(f122_arg0, f122_arg1, f122_local1, f122_local2, f122_local3, f122_local4, f122_local5)
    return f122_local6


end

-- defAct18 - 默认行为18：基础接近攻击（攻击ID: 3000）
function defAct18(f123_arg0, f123_arg1, f123_arg2)
    local f123_local0 = {1.5, 0, 3000, DIST_Middle, nil}
    if f123_arg2[1] ~= nil then
        f123_local0 = f123_arg2
    end
    local f123_local1 = f123_local0[1]
    local f123_local2 = f123_local0[1] + 2
    local f123_local3 = f123_local0[2]
    local f123_local4 = f123_local0[3]
    local f123_local5 = f123_local0[4]
    local f123_local6 = GET_PARAM_IF_NIL_DEF(f123_local0[5], 100)
    Approach_and_Attack_Act(f123_arg0, f123_arg1, f123_local1, f123_local2, f123_local3, f123_local4, f123_local5)
    return f123_local6


end

-- defAct19 - 默认行为19：基础接近攻击（攻击ID: 3000）
function defAct19(f124_arg0, f124_arg1, f124_arg2)
    local f124_local0 = {1.5, 0, 3000, DIST_Middle, nil}
    if f124_arg2[1] ~= nil then
        f124_local0 = f124_arg2
    end
    local f124_local1 = f124_local0[1]
    local f124_local2 = f124_local0[1] + 2
    local f124_local3 = f124_local0[2]
    local f124_local4 = f124_local0[3]
    local f124_local5 = f124_local0[4]
    local f124_local6 = GET_PARAM_IF_NIL_DEF(f124_local0[5], 100)
    Approach_and_Attack_Act(f124_arg0, f124_arg1, f124_local1, f124_local2, f124_local3, f124_local4, f124_local5)
    return f124_local6


end

-- defAct20 - 默认行为20：基础接近攻击（攻击ID: 3000）
function defAct20(f125_arg0, f125_arg1, f125_arg2)
    local f125_local0 = {1.5, 0, 3000, DIST_Middle, nil}
    if f125_arg2[1] ~= nil then
        f125_local0 = f125_arg2
    end
    local f125_local1 = f125_local0[1]
    local f125_local2 = f125_local0[1] + 2
    local f125_local3 = f125_local0[2]
    local f125_local4 = f125_local0[3]
    local f125_local5 = f125_local0[4]
    local f125_local6 = GET_PARAM_IF_NIL_DEF(f125_local0[5], 100)
    Approach_and_Attack_Act(f125_arg0, f125_arg1, f125_local1, f125_local2, f125_local3, f125_local4, f125_local5)
    return f125_local6
    
end

-- defAct21 - 默认行为21：基础接近攻击（攻击ID: 3000）
function defAct21(f126_arg0, f126_arg1, f126_arg2)
    local f126_local0 = {1.5, 0, 3000, DIST_Middle, nil}
    if f126_arg2[1] ~= nil then
        f126_local0 = f126_arg2
    end
    local f126_local1 = f126_local0[1]
    local f126_local2 = f126_local0[1] + 2
    local f126_local3 = f126_local0[2]
    local f126_local4 = f126_local0[3]
    local f126_local5 = f126_local0[4]
    local f126_local6 = GET_PARAM_IF_NIL_DEF(f126_local0[5], 100)
    Approach_and_Attack_Act(f126_arg0, f126_arg1, f126_local1, f126_local2, f126_local3, f126_local4, f126_local5)
    return f126_local6
    
end

-- defAct22 - 默认行为22：基础接近攻击（攻击ID: 3000）
function defAct22(f127_arg0, f127_arg1, f127_arg2)
    local f127_local0 = {1.5, 0, 3000, DIST_Middle, nil}
    if f127_arg2[1] ~= nil then
        f127_local0 = f127_arg2
    end
    local f127_local1 = f127_local0[1]
    local f127_local2 = f127_local0[1] + 2
    local f127_local3 = f127_local0[2]
    local f127_local4 = f127_local0[3]
    local f127_local5 = f127_local0[4]
    local f127_local6 = GET_PARAM_IF_NIL_DEF(f127_local0[5], 100)
    Approach_and_Attack_Act(f127_arg0, f127_arg1, f127_local1, f127_local2, f127_local3, f127_local4, f127_local5)
    return f127_local6


end

-- defAct23 - 默认行为23：基础接近攻击（攻击ID: 3000）
function defAct23(f128_arg0, f128_arg1, f128_arg2)
    local f128_local0 = {1.5, 0, 3000, DIST_Middle, nil}
    if f128_arg2[1] ~= nil then
        f128_local0 = f128_arg2
    end
    local f128_local1 = f128_local0[1]
    local f128_local2 = f128_local0[1] + 2
    local f128_local3 = f128_local0[2]
    local f128_local4 = f128_local0[3]
    local f128_local5 = f128_local0[4]
    local f128_local6 = GET_PARAM_IF_NIL_DEF(f128_local0[5], 100)
    Approach_and_Attack_Act(f128_arg0, f128_arg1, f128_local1, f128_local2, f128_local3, f128_local4, f128_local5)
    return f128_local6


end

-- defAct24 - 默认行为24：基础接近攻击（攻击ID: 3000）
function defAct24(f129_arg0, f129_arg1, f129_arg2)
    local f129_local0 = {1.5, 0, 3000, DIST_Middle, nil}
    if f129_arg2[1] ~= nil then
        f129_local0 = f129_arg2
    end
    local f129_local1 = f129_local0[1]
    local f129_local2 = f129_local0[1] + 2
    local f129_local3 = f129_local0[2]
    local f129_local4 = f129_local0[3]
    local f129_local5 = f129_local0[4]
    local f129_local6 = GET_PARAM_IF_NIL_DEF(f129_local0[5], 100)
    Approach_and_Attack_Act(f129_arg0, f129_arg1, f129_local1, f129_local2, f129_local3, f129_local4, f129_local5)
    return f129_local6


end

-- defAct25 - 默认行为25：基础接近攻击（攻击ID: 3000）
function defAct25(f130_arg0, f130_arg1, f130_arg2)
    local f130_local0 = {1.5, 0, 3000, DIST_Middle, nil}
    if f130_arg2[1] ~= nil then
        f130_local0 = f130_arg2
    end
    local f130_local1 = f130_local0[1]
    local f130_local2 = f130_local0[1] + 2
    local f130_local3 = f130_local0[2]
    local f130_local4 = f130_local0[3]
    local f130_local5 = f130_local0[4]
    local f130_local6 = GET_PARAM_IF_NIL_DEF(f130_local0[5], 100)
    Approach_and_Attack_Act(f130_arg0, f130_arg1, f130_local1, f130_local2, f130_local3, f130_local4, f130_local5)
    return f130_local6
    
end

-- defAct26 - 默认行为26：基础接近攻击（攻击ID: 3000）
function defAct26(f131_arg0, f131_arg1, f131_arg2)
    local f131_local0 = {1.5, 0, 3000, DIST_Middle, nil}
    if f131_arg2[1] ~= nil then
        f131_local0 = f131_arg2
    end
    local f131_local1 = f131_local0[1]
    local f131_local2 = f131_local0[1] + 2
    local f131_local3 = f131_local0[2]
    local f131_local4 = f131_local0[3]
    local f131_local5 = f131_local0[4]
    local f131_local6 = GET_PARAM_IF_NIL_DEF(f131_local0[5], 100)
    Approach_and_Attack_Act(f131_arg0, f131_arg1, f131_local1, f131_local2, f131_local3, f131_local4, f131_local5)
    return f131_local6
    
end

-- defAct27 - 默认行为27：基础接近攻击（攻击ID: 3000）
function defAct27(f132_arg0, f132_arg1, f132_arg2)
    local f132_local0 = {1.5, 0, 3000, DIST_Middle, nil}
    if f132_arg2[1] ~= nil then
        f132_local0 = f132_arg2
    end
    local f132_local1 = f132_local0[1]
    local f132_local2 = f132_local0[1] + 2
    local f132_local3 = f132_local0[2]
    local f132_local4 = f132_local0[3]
    local f132_local5 = f132_local0[4]
    local f132_local6 = GET_PARAM_IF_NIL_DEF(f132_local0[5], 100)
    Approach_and_Attack_Act(f132_arg0, f132_arg1, f132_local1, f132_local2, f132_local3, f132_local4, f132_local5)
    return f132_local6


end

-- defAct28 - 默认行为28：基础接近攻击（攻击ID: 3000）
function defAct28(f133_arg0, f133_arg1, f133_arg2)
    local f133_local0 = {1.5, 0, 3000, DIST_Middle, nil}
    if f133_arg2[1] ~= nil then
        f133_local0 = f133_arg2
    end
    local f133_local1 = f133_local0[1]
    local f133_local2 = f133_local0[1] + 2
    local f133_local3 = f133_local0[2]
    local f133_local4 = f133_local0[3]
    local f133_local5 = f133_local0[4]
    local f133_local6 = GET_PARAM_IF_NIL_DEF(f133_local0[5], 100)
    Approach_and_Attack_Act(f133_arg0, f133_arg1, f133_local1, f133_local2, f133_local3, f133_local4, f133_local5)
    return f133_local6


end

-- defAct29 - 默认行为29：基础接近攻击（攻击ID: 3000）
function defAct29(f134_arg0, f134_arg1, f134_arg2)
    local f134_local0 = {1.5, 0, 3000, DIST_Middle, nil}
    if f134_arg2[1] ~= nil then
        f134_local0 = f134_arg2
    end
    local f134_local1 = f134_local0[1]
    local f134_local2 = f134_local0[1] + 2
    local f134_local3 = f134_local0[2]
    local f134_local4 = f134_local0[3]
    local f134_local5 = f134_local0[4]
    local f134_local6 = GET_PARAM_IF_NIL_DEF(f134_local0[5], 100)
    Approach_and_Attack_Act(f134_arg0, f134_arg1, f134_local1, f134_local2, f134_local3, f134_local4, f134_local5)
    return f134_local6


end

-- defAct30 - 默认行为30：基础接近攻击（攻击ID: 3000）
function defAct30(f135_arg0, f135_arg1, f135_arg2)
    local f135_local0 = {1.5, 0, 3000, DIST_Middle, nil}
    if f135_arg2[1] ~= nil then
        f135_local0 = f135_arg2
    end
    local f135_local1 = f135_local0[1]
    local f135_local2 = f135_local0[1] + 2
    local f135_local3 = f135_local0[2]
    local f135_local4 = f135_local0[3]
    local f135_local5 = f135_local0[4]
    local f135_local6 = GET_PARAM_IF_NIL_DEF(f135_local0[5], 100)
    Approach_and_Attack_Act(f135_arg0, f135_arg1, f135_local1, f135_local2, f135_local3, f135_local4, f135_local5)
    return f135_local6


end

-- defAct31 - 默认行为31：基础接近攻击（攻击ID: 3000）
function defAct31(f136_arg0, f136_arg1, f136_arg2)
    local f136_local0 = {1.5, 0, 3000, DIST_Middle, nil}
    if f136_arg2[1] ~= nil then
        f136_local0 = f136_arg2
    end
    local f136_local1 = f136_local0[1]
    local f136_local2 = f136_local0[1] + 2
    local f136_local3 = f136_local0[2]
    local f136_local4 = f136_local0[3]
    local f136_local5 = f136_local0[4]
    local f136_local6 = GET_PARAM_IF_NIL_DEF(f136_local0[5], 100)
    Approach_and_Attack_Act(f136_arg0, f136_arg1, f136_local1, f136_local2, f136_local3, f136_local4, f136_local5)
    return f136_local6


end

-- defAct32 - 默认行为32：基础接近攻击（攻击ID: 3000）
function defAct32(f137_arg0, f137_arg1, f137_arg2)
    local f137_local0 = {1.5, 0, 3000, DIST_Middle, nil}
    if f137_arg2[1] ~= nil then
        f137_local0 = f137_arg2
    end
    local f137_local1 = f137_local0[1]
    local f137_local2 = f137_local0[1] + 2
    local f137_local3 = f137_local0[2]
    local f137_local4 = f137_local0[3]
    local f137_local5 = f137_local0[4]
    local f137_local6 = GET_PARAM_IF_NIL_DEF(f137_local0[5], 100)
    Approach_and_Attack_Act(f137_arg0, f137_arg1, f137_local1, f137_local2, f137_local3, f137_local4, f137_local5)
    return f137_local6


end

-- defAct33 - 默认行为33：基础接近攻击（攻击ID: 3000）
function defAct33(f138_arg0, f138_arg1, f138_arg2)
    local f138_local0 = {1.5, 0, 3000, DIST_Middle, nil}
    if f138_arg2[1] ~= nil then
        f138_local0 = f138_arg2
    end
    local f138_local1 = f138_local0[1]
    local f138_local2 = f138_local0[1] + 2
    local f138_local3 = f138_local0[2]
    local f138_local4 = f138_local0[3]
    local f138_local5 = f138_local0[4]
    local f138_local6 = GET_PARAM_IF_NIL_DEF(f138_local0[5], 100)
    Approach_and_Attack_Act(f138_arg0, f138_arg1, f138_local1, f138_local2, f138_local3, f138_local4, f138_local5)
    return f138_local6


end

-- defAct34 - 默认行为34：基础接近攻击（攻击ID: 3000）
function defAct34(f139_arg0, f139_arg1, f139_arg2)
    local f139_local0 = {1.5, 0, 3000, DIST_Middle, nil}
    if f139_arg2[1] ~= nil then
        f139_local0 = f139_arg2
    end
    local f139_local1 = f139_local0[1]
    local f139_local2 = f139_local0[1] + 2
    local f139_local3 = f139_local0[2]
    local f139_local4 = f139_local0[3]
    local f139_local5 = f139_local0[4]
    local f139_local6 = GET_PARAM_IF_NIL_DEF(f139_local0[5], 100)
    Approach_and_Attack_Act(f139_arg0, f139_arg1, f139_local1, f139_local2, f139_local3, f139_local4, f139_local5)
    return f139_local6
    
end

-- defAct35 - 默认行为35：基础接近攻击（攻击ID: 3000）
function defAct35(f140_arg0, f140_arg1, f140_arg2)
    local f140_local0 = {1.5, 0, 3000, DIST_Middle, nil}
    if f140_arg2[1] ~= nil then
        f140_local0 = f140_arg2
    end
    local f140_local1 = f140_local0[1]
    local f140_local2 = f140_local0[1] + 2
    local f140_local3 = f140_local0[2]
    local f140_local4 = f140_local0[3]
    local f140_local5 = f140_local0[4]
    local f140_local6 = GET_PARAM_IF_NIL_DEF(f140_local0[5], 100)
    Approach_and_Attack_Act(f140_arg0, f140_arg1, f140_local1, f140_local2, f140_local3, f140_local4, f140_local5)
    return f140_local6


end

-- defAct36 - 默认行为36：基础接近攻击（攻击ID: 3000）
function defAct36(f141_arg0, f141_arg1, f141_arg2)
    local f141_local0 = {1.5, 0, 3000, DIST_Middle, nil}
    if f141_arg2[1] ~= nil then
        f141_local0 = f141_arg2
    end
    local f141_local1 = f141_local0[1]
    local f141_local2 = f141_local0[1] + 2
    local f141_local3 = f141_local0[2]
    local f141_local4 = f141_local0[3]
    local f141_local5 = f141_local0[4]
    local f141_local6 = GET_PARAM_IF_NIL_DEF(f141_local0[5], 100)
    Approach_and_Attack_Act(f141_arg0, f141_arg1, f141_local1, f141_local2, f141_local3, f141_local4, f141_local5)
    return f141_local6


end

-- defAct37 - 默认行为37：基础接近攻击（攻击ID: 3000）
function defAct37(f142_arg0, f142_arg1, f142_arg2)
    local f142_local0 = {1.5, 0, 3000, DIST_Middle, nil}
    if f142_arg2[1] ~= nil then
        f142_local0 = f142_arg2
    end
    local f142_local1 = f142_local0[1]
    local f142_local2 = f142_local0[1] + 2
    local f142_local3 = f142_local0[2]
    local f142_local4 = f142_local0[3]
    local f142_local5 = f142_local0[4]
    local f142_local6 = GET_PARAM_IF_NIL_DEF(f142_local0[5], 100)
    Approach_and_Attack_Act(f142_arg0, f142_arg1, f142_local1, f142_local2, f142_local3, f142_local4, f142_local5)
    return f142_local6


end

-- defAct38 - 默认行为38：基础接近攻击（攻击ID: 3000）
function defAct38(f143_arg0, f143_arg1, f143_arg2)
    local f143_local0 = {1.5, 0, 3000, DIST_Middle, nil}
    if f143_arg2[1] ~= nil then
        f143_local0 = f143_arg2
    end
    local f143_local1 = f143_local0[1]
    local f143_local2 = f143_local0[1] + 2
    local f143_local3 = f143_local0[2]
    local f143_local4 = f143_local0[3]
    local f143_local5 = f143_local0[4]
    local f143_local6 = GET_PARAM_IF_NIL_DEF(f143_local0[5], 100)
    Approach_and_Attack_Act(f143_arg0, f143_arg1, f143_local1, f143_local2, f143_local3, f143_local4, f143_local5)
    return f143_local6


end

-- defAct39 - 默认行为39：基础接近攻击（攻击ID: 3000）
function defAct39(f144_arg0, f144_arg1, f144_arg2)
    local f144_local0 = {1.5, 0, 3000, DIST_Middle, nil}
    if f144_arg2[1] ~= nil then
        f144_local0 = f144_arg2
    end
    local f144_local1 = f144_local0[1]
    local f144_local2 = f144_local0[1] + 2
    local f144_local3 = f144_local0[2]
    local f144_local4 = f144_local0[3]
    local f144_local5 = f144_local0[4]
    local f144_local6 = GET_PARAM_IF_NIL_DEF(f144_local0[5], 100)
    Approach_and_Attack_Act(f144_arg0, f144_arg1, f144_local1, f144_local2, f144_local3, f144_local4, f144_local5)
    return f144_local6


end

-- defAct40 - 默认行为40：基础接近攻击（攻击ID: 3000）
function defAct40(f145_arg0, f145_arg1, f145_arg2)
    local f145_local0 = {1.5, 0, 3000, DIST_Middle, nil}
    if f145_arg2[1] ~= nil then
        f145_local0 = f145_arg2
    end
    local f145_local1 = f145_local0[1]
    local f145_local2 = f145_local0[1] + 2
    local f145_local3 = f145_local0[2]
    local f145_local4 = f145_local0[3]
    local f145_local5 = f145_local0[4]
    local f145_local6 = GET_PARAM_IF_NIL_DEF(f145_local0[5], 100)
    Approach_and_Attack_Act(f145_arg0, f145_arg1, f145_local1, f145_local2, f145_local3, f145_local4, f145_local5)
    return f145_local6


end

-- defAct41 - 默认行为41：基础接近攻击（攻击ID: 3000）
function defAct41(f146_arg0, f146_arg1, f146_arg2)
    local f146_local0 = {1.5, 0, 3000, DIST_Middle, nil}
    if f146_arg2[1] ~= nil then
        f146_local0 = f146_arg2
    end
    local f146_local1 = f146_local0[1]
    local f146_local2 = f146_local0[1] + 2
    local f146_local3 = f146_local0[2]
    local f146_local4 = f146_local0[3]
    local f146_local5 = f146_local0[4]
    local f146_local6 = GET_PARAM_IF_NIL_DEF(f146_local0[5], 100)
    Approach_and_Attack_Act(f146_arg0, f146_arg1, f146_local1, f146_local2, f146_local3, f146_local4, f146_local5)
    return f146_local6
    
end

-- defAct42 - 默认行为42：基础接近攻击（攻击ID: 3000）
function defAct42(f147_arg0, f147_arg1, f147_arg2)
    local f147_local0 = {1.5, 0, 3000, DIST_Middle, nil}
    if f147_arg2[1] ~= nil then
        f147_local0 = f147_arg2
    end
    local f147_local1 = f147_local0[1]
    local f147_local2 = f147_local0[1] + 2
    local f147_local3 = f147_local0[2]
    local f147_local4 = f147_local0[3]
    local f147_local5 = f147_local0[4]
    local f147_local6 = GET_PARAM_IF_NIL_DEF(f147_local0[5], 100)
    Approach_and_Attack_Act(f147_arg0, f147_arg1, f147_local1, f147_local2, f147_local3, f147_local4, f147_local5)
    return f147_local6


end

-- defAct43 - 默认行为43：基础接近攻击（攻击ID: 3000）
function defAct43(f148_arg0, f148_arg1, f148_arg2)
    local f148_local0 = {1.5, 0, 3000, DIST_Middle, nil}
    if f148_arg2[1] ~= nil then
        f148_local0 = f148_arg2
    end
    local f148_local1 = f148_local0[1]
    local f148_local2 = f148_local0[1] + 2
    local f148_local3 = f148_local0[2]
    local f148_local4 = f148_local0[3]
    local f148_local5 = f148_local0[4]
    local f148_local6 = GET_PARAM_IF_NIL_DEF(f148_local0[5], 100)
    Approach_and_Attack_Act(f148_arg0, f148_arg1, f148_local1, f148_local2, f148_local3, f148_local4, f148_local5)
    return f148_local6


end

-- defAct44 - 默认行为44：基础接近攻击（攻击ID: 3000）
function defAct44(f149_arg0, f149_arg1, f149_arg2)
    local f149_local0 = {1.5, 0, 3000, DIST_Middle, nil}
    if f149_arg2[1] ~= nil then
        f149_local0 = f149_arg2
    end
    local f149_local1 = f149_local0[1]
    local f149_local2 = f149_local0[1] + 2
    local f149_local3 = f149_local0[2]
    local f149_local4 = f149_local0[3]
    local f149_local5 = f149_local0[4]
    local f149_local6 = GET_PARAM_IF_NIL_DEF(f149_local0[5], 100)
    Approach_and_Attack_Act(f149_arg0, f149_arg1, f149_local1, f149_local2, f149_local3, f149_local4, f149_local5)
    return f149_local6


end

-- defAct45 - 默认行为45：基础接近攻击（攻击ID: 3000）
function defAct45(f150_arg0, f150_arg1, f150_arg2)
    local f150_local0 = {1.5, 0, 3000, DIST_Middle, nil}
    if f150_arg2[1] ~= nil then
        f150_local0 = f150_arg2
    end
    local f150_local1 = f150_local0[1]
    local f150_local2 = f150_local0[1] + 2
    local f150_local3 = f150_local0[2]
    local f150_local4 = f150_local0[3]
    local f150_local5 = f150_local0[4]
    local f150_local6 = GET_PARAM_IF_NIL_DEF(f150_local0[5], 100)
    Approach_and_Attack_Act(f150_arg0, f150_arg1, f150_local1, f150_local2, f150_local3, f150_local4, f150_local5)
    return f150_local6


end

-- defAct46 - 默认行为46：基础接近攻击（攻击ID: 3000）
function defAct46(f151_arg0, f151_arg1, f151_arg2)
    local f151_local0 = {1.5, 0, 3000, DIST_Middle, nil}
    if f151_arg2[1] ~= nil then
        f151_local0 = f151_arg2
    end
    local f151_local1 = f151_local0[1]
    local f151_local2 = f151_local0[1] + 2
    local f151_local3 = f151_local0[2]
    local f151_local4 = f151_local0[3]
    local f151_local5 = f151_local0[4]
    local f151_local6 = GET_PARAM_IF_NIL_DEF(f151_local0[5], 100)
    Approach_and_Attack_Act(f151_arg0, f151_arg1, f151_local1, f151_local2, f151_local3, f151_local4, f151_local5)
    return f151_local6


end

-- defAct47 - 默认行为47：基础接近攻击（攻击ID: 3000）
function defAct47(f152_arg0, f152_arg1, f152_arg2)
    local f152_local0 = {1.5, 0, 3000, DIST_Middle, nil}
    if f152_arg2[1] ~= nil then
        f152_local0 = f152_arg2
    end
    local f152_local1 = f152_local0[1]
    local f152_local2 = f152_local0[1] + 2
    local f152_local3 = f152_local0[2]
    local f152_local4 = f152_local0[3]
    local f152_local5 = f152_local0[4]
    local f152_local6 = GET_PARAM_IF_NIL_DEF(f152_local0[5], 100)
    Approach_and_Attack_Act(f152_arg0, f152_arg1, f152_local1, f152_local2, f152_local3, f152_local4, f152_local5)
    return f152_local6


end

-- defAct48 - 默认行为48：基础接近攻击（攻击ID: 3000）
function defAct48(f153_arg0, f153_arg1, f153_arg2)
    local f153_local0 = {1.5, 0, 3000, DIST_Middle, nil}
    if f153_arg2[1] ~= nil then
        f153_local0 = f153_arg2
    end
    local f153_local1 = f153_local0[1]
    local f153_local2 = f153_local0[1] + 2
    local f153_local3 = f153_local0[2]
    local f153_local4 = f153_local0[3]
    local f153_local5 = f153_local0[4]
    local f153_local6 = GET_PARAM_IF_NIL_DEF(f153_local0[5], 100)
    Approach_and_Attack_Act(f153_arg0, f153_arg1, f153_local1, f153_local2, f153_local3, f153_local4, f153_local5)
    return f153_local6


end

-- defAct49 - 默认行为49：基础接近攻击（攻击ID: 3000）
function defAct49(f154_arg0, f154_arg1, f154_arg2)
    local f154_local0 = {1.5, 0, 3000, DIST_Middle, nil}
    if f154_arg2[1] ~= nil then
        f154_local0 = f154_arg2
    end
    local f154_local1 = f154_local0[1]
    local f154_local2 = f154_local0[1] + 2
    local f154_local3 = f154_local0[2]
    local f154_local4 = f154_local0[3]
    local f154_local5 = f154_local0[4]
    local f154_local6 = GET_PARAM_IF_NIL_DEF(f154_local0[5], 100)
    Approach_and_Attack_Act(f154_arg0, f154_arg1, f154_local1, f154_local2, f154_local3, f154_local4, f154_local5)
    return f154_local6


end

-- defAct50 - 默认行为50：基础接近攻击（攻击ID: 3000）
function defAct50(f155_arg0, f155_arg1, f155_arg2)
    local f155_local0 = {1.5, 0, 3000, DIST_Middle, nil}
    if f155_arg2[1] ~= nil then
        f155_local0 = f155_arg2
    end
    local f155_local1 = f155_local0[1]
    local f155_local2 = f155_local0[1] + 2
    local f155_local3 = f155_local0[2]
    local f155_local4 = f155_local0[3]
    local f155_local5 = f155_local0[4]
    local f155_local6 = GET_PARAM_IF_NIL_DEF(f155_local0[5], 100)
    Approach_and_Attack_Act(f155_arg0, f155_arg1, f155_local1, f155_local2, f155_local3, f155_local4, f155_local5)
    return f155_local6
    
end

--[[
函数名：HumanCommon_KeepDist_and_ThrowSomething (保持距离并投掷)
功能描述：人类敌人保持与玩家的距离同时投掷物品的行为
Function: Human enemy keep distance while throwing projectiles behavior

参数说明：
  - f156_arg0: AI实体对象 (AI entity)
  - f156_arg1: 目标对象 (Target object)
  - f156_arg2: 参数表 (Parameter table)
    [1]: 最小距离 - 保持距离的最小值
    [2]: 最大距离 - 保持距离的最大值
    [3]: 投掷延迟 - 投掷前的等待时间
    [4]: 投掷物品ID - 投掷的物品或攻击ID
    [5]: 距离类型 - 用于保持距离的距离类型
    [6]: 后续触发概率 - 默认0（不触发后续行为）

返回值：数值 - 后续行为触发概率（0-100）
]]--
function HumanCommon_KeepDist_and_ThrowSomething(f156_arg0, f156_arg1, f156_arg2)
    -- 提取参数 (Extract parameters)
    local f156_local0 = f156_arg2[1]  -- 最小距离 (min distance)
    local f156_local1 = f156_arg2[2]  -- 最大距离 (max distance)
    local f156_local2 = f156_arg2[2] + 2  -- 防线距离 (defensive distance)
    local f156_local3 = f156_arg2[3]  -- 投掷延迟 (throw delay)
    local f156_local4 = f156_arg2[4]  -- 投掷物品ID (throw item ID)
    local f156_local5 = f156_arg2[5]  -- 距离类型 (distance type)
    -- 执行保持距离并投掷行为 (Execute keep distance and throw)
    KeepDist_and_Attack_Act(f156_arg0, f156_arg1, f156_local0, f156_local1, f156_local2, f156_local3, f156_local4, f156_local5)
    -- 获取后续触发概率 (Get follow-up trigger probability)
    local f156_local6 = GET_PARAM_IF_NIL_DEF(f156_arg2[6], 0)
    return f156_local6


end

--[[
函数名：HumanCommon_ActAfter_AdjustSpace (攻击后调整距离)
功能描述：在攻击后调整与目标的位置和距离，包含移动和转身
Function: Adjust position and distance after attack, including movement and turning

参数说明：
  - f157_arg0: AI实体对象 (AI entity)
  - f157_arg1: 目标对象 (Target object)
  - f157_arg2: 调整参数表 (Adjustment parameter table)
    [1-6]: 各类距离调整参数 (distance adjustment parameters)

使用场景：
  - 在攻击序列之后调整位置
  - 为下一次攻击做准备
  - 与敌人保持有效的战斗距离
]]--
function HumanCommon_ActAfter_AdjustSpace(f157_arg0, f157_arg1, f157_arg2)
    -- 提取调整参数 (Extract adjustment parameters)
    local f157_local0 = f157_arg2[1]
    local f157_local1 = f157_arg2[2]
    local f157_local2 = f157_arg2[3]
    local f157_local3 = f157_arg2[4]
    local f157_local4 = f157_arg2[5]
    local f157_local5 = f157_arg2[6]
    -- 执行距离调整 (Execute distance adjustment)
    GetWellSpace_Act(f157_arg0, f157_arg1, f157_local0, f157_local1, f157_local2, f157_local3, f157_local4, f157_local5)


end

--[[
函数名：HumanCommon_ActAfter_AdjustSpace_IncludeSidestep (攻击后调整距离含横向移动)
功能描述：在攻击后调整距离，同时支持横向闪避移动
Function: Adjust distance after attack with support for sidestep evasion

参数说明：
  - f158_arg0: AI实体对象 (AI entity)
  - f158_arg1: 目标对象 (Target object)
  - f158_arg2: 参数表 (Parameter table)
    [1-7]: 包括横向移动参数的调整配置

功能差异：
  - 相比普通版本，本函数支持横向闪避
  - 用于高难度BOSS的躲避战术
]]--
function HumanCommon_ActAfter_AdjustSpace_IncludeSidestep(f158_arg0, f158_arg1, f158_arg2)
    -- 提取参数，包括横向移动参数 (Extract parameters including sidestep)
    local f158_local0 = f158_arg2[1]
    local f158_local1 = f158_arg2[2]
    local f158_local2 = f158_arg2[3]
    local f158_local3 = f158_arg2[4]
    local f158_local4 = f158_arg2[5]
    local f158_local5 = f158_arg2[6]
    local f158_local6 = f158_arg2[7]  -- 横向移动参数 (sidestep parameter)
    -- 执行包含横向移动的距离调整 (Execute distance adjustment with sidestep)
    GetWellSpace_Act_IncludeSidestep(f158_arg0, f158_arg1, f158_local0, f158_local1, f158_local2, f158_local3, f158_local4, f158_local5, f158_local6)


end

--[[
函数名：HumanCommon_Approach_and_ComboAtk (接近并连击)
功能描述：敌人接近玩家并执行多种连击模式的行为
Function: Enemy approach and perform various combo attack patterns

参数说明：
  - f159_arg0: AI实体对象 (AI entity)
  - f159_arg1: 目标对象 (Target object)
  - f159_arg2: 参数表 (Parameter table)
    [1]: 接近距离 - 需要接近到的距离
    [2]: 接近延迟 - 接近前的等待时间
    [3]: 单段攻击概率 - 执行单段攻击的百分比
    [4]: 两段连击概率 - 执行两段连击的额外百分比
    [5]: 第一段攻击ID - 默认3000
    [6]: 第二段攻击ID - 默认3001
    [7]: 第三段攻击ID - 默认3002
    [8]: 后续触发概率 - 默认100

连击模式（基于百分比）：
  - [0, p3]：单段攻击 (single attack)
  - [p3, p3+p4]：两段连击 (2-hit combo)
  - [p3+p4, 100]：三段连击 (3-hit combo)
]]--
function HumanCommon_Approach_and_ComboAtk(f159_arg0, f159_arg1, f159_arg2)
    -- 提取接近参数 (Extract approach parameters)
    local f159_local0 = f159_arg2[1]  -- 接近距离 (approach distance)
    local f159_local1 = f159_arg2[1] + 2  -- 防线距离 (defensive distance)
    local f159_local2 = f159_arg2[2]  -- 接近延迟 (approach delay)
    -- 执行接近行为 (Execute approach)
    Approach_Act(f159_arg0, f159_arg1, f159_local0, f159_local1, f159_local2)

    -- 获取攻击ID（使用默认值） (Get attack IDs with defaults)
    local f159_local3 = GET_PARAM_IF_NIL_DEF(f159_arg2[5], 3000)  -- 第一段攻击
    local f159_local4 = GET_PARAM_IF_NIL_DEF(f159_arg2[6], 3001)  -- 第二段攻击
    local f159_local5 = GET_PARAM_IF_NIL_DEF(f159_arg2[7], 3002)  -- 第三段攻击

    -- 根据概率选择连击模式 (Select combo pattern based on probability)
    local f159_local6 = f159_arg0:GetRandam_Int(1, 100)
    if f159_local6 <= f159_arg2[3] then
        -- 单段攻击 (Single attack)
        f159_arg1:AddSubGoal(GOAL_COMMON_Attack, 10, f159_local3, TARGET_ENE_0, DIST_Middle, 0)
    elseif f159_local6 <= f159_arg2[3] + f159_arg2[4] then
        -- 两段连击 (Two-hit combo)
        f159_arg1:AddSubGoal(GOAL_COMMON_ComboAttack, 10, f159_local3, TARGET_ENE_0, DIST_Middle, 0)
        f159_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, f159_local4, TARGET_ENE_0, DIST_Middle, 0)
    else
        -- 三段连击 (Three-hit combo)
        f159_arg1:AddSubGoal(GOAL_COMMON_ComboAttack, 10, f159_local3, TARGET_ENE_0, DIST_Middle, 0)
        f159_arg1:AddSubGoal(GOAL_COMMON_ComboRepeat, 10, f159_local4, TARGET_ENE_0, DIST_Middle, 0)
        f159_arg1:AddSubGoal(GOAL_COMMON_ComboFinal, 10, f159_local5, TARGET_ENE_0, DIST_Middle, 0)
    end

    -- 获取后续触发概率 (Get follow-up trigger probability)
    local f159_local7 = GET_PARAM_IF_NIL_DEF(f159_arg2[8], 100)
    return f159_local7


end

--[[
函数名：HumanCommon_Watching_Parry_Chance_Act (观察招架机会)
功能描述：敌人观察玩家的招架（parry）时机，等待反击机会
Function: Enemy watches for parry opportunity and waits for counter-attack chance

参数说明：
  - f160_arg0: AI实体对象 (AI entity)
  - f160_arg1: 目标对象 (Target object)
  - f160_arg2: 参数表 (Parameter table)
    [1]: 触发概率 - 默认100

使用场景：
  - BOSS防守时的反击策略
  - 只狼游戏中见切（招架）的对抗机制
  - 高难度敌人的防守模式
]]--
function HumanCommon_Watching_Parry_Chance_Act(f160_arg0, f160_arg1, f160_arg2)
    -- 执行观察招架机会 (Execute watch for parry)
    Watching_Parry_Chance_Act(f160_arg0, f160_arg1)
    -- 获取触发概率 (Get trigger probability)
    local f160_local0 = GET_PARAM_IF_NIL_DEF(f160_arg2[1], 100)
    return f160_local0


end

--[[
函数名：HumanCommon_Shooting_Act (射击行为)
功能描述：执行射击或法术攻击，支持多种射击后处理策略
Function: Execute shooting or spell attack with multiple post-shoot handling strategies

参数说明：
  - f161_arg0: AI实体对象 (AI entity)
  - f161_arg1: 目标对象 (Target object)
  - f161_arg2: 参数表 (Parameter table)
    [1]: 第一个攻击ID - 射击的主攻击ID
    [2]: 第二个攻击ID - 可选的后续攻击ID
    [3]: 最小射击间隔 - 射击前等待的最小秒数
    [4]: 最大射击间隔 - 射击前等待的最大秒数
    [5]: 射击后动作 - 0:无动作 1:追击 2:撤退

射击后处理策略：
  0: 保持站立，继续观察
  1: 主动追击敌人
  2: 撤退到安全位置
]]--
function HumanCommon_Shooting_Act(f161_arg0, f161_arg1, f161_arg2)
    -- 提取射击参数 (Extract shooting parameters)
    local f161_local0 = f161_arg2[1]  -- 第一个攻击ID (first attack ID)
    local f161_local1 = f161_arg2[2]  -- 第二个攻击ID (second attack ID)
    -- 获取随机射击间隔 (Get random shooting interval)
    local f161_local2 = f161_arg0:GetRandam_Int(f161_arg2[3], f161_arg2[4])
    local f161_local3 = f161_arg2[5]  -- 射击后动作 (post-shooting action)

    -- 执行射击 (Execute shooting)
    Shoot_Act(f161_arg0, f161_arg1, f161_local0, f161_local1, f161_local2)

    -- 根据射击后动作类型执行不同处理 (Execute different handling based on action type)
    if f161_local3 == 0 then
        -- 无动作 (no action - just wait)
    elseif f161_local3 == 1 then
        -- 主动追击敌人 (actively chase enemy)
        f161_arg1:AddSubGoal(GOAL_COMMON_LeaveTarget, 2, TARGET_ENE_0, 20, TARGET_ENE_0, true, -1)
    elseif f161_local3 == 2 then
        -- 撤退到安全位置 (retreat to safe position)
        f161_arg1:AddSubGoal(GOAL_COMMON_LeaveTarget, 5, TARGET_ENE_0, 20, TARGET_SELF, false, -1)
    else
        -- 未知的动作类型 (unknown action type)
        f161_arg0:PrintText("★logical error, get the manager!★ ")
    end

    return 0


end

--[[
函数名：GET_PARAM_IF_NIL_DEF (参数默认值处理器)
功能描述：如果参数为nil，则返回默认值，否则返回参数值
Function: If parameter is nil, return default value; otherwise return parameter value

参数说明：
  - f162_arg0: 待检查的参数 (parameter to check)
  - f162_arg1: 默认值 (default value)

返回值：参数值或默认值

使用场景：
  - 在函数中处理可选参数
  - 为nil参数提供合理的默认值
  - 简化参数验证逻辑

示例：
  local value = GET_PARAM_IF_NIL_DEF(param, 100)  -- 如果param为nil，使用100
]]--
function GET_PARAM_IF_NIL_DEF(f162_arg0, f162_arg1)
    -- 检查参数是否为nil (Check if parameter is nil)
    if f162_arg0 ~= nil then
        -- 如果不为nil，返回参数值 (Return parameter if not nil)
        return f162_arg0
    end
    -- 否则返回默认值 (Return default value if nil)
    return f162_arg1


end

--[[
函数名：REGIST_FUNC (函数注册器)
功能描述：创建一个闭包函数，将AI、目标、参数绑定到行为函数
Function: Create a closure function that binds AI, target, and parameters to behavior function

参数说明：
  - f163_arg0: AI实体对象 (AI entity)
  - f163_arg1: 目标对象 (Target object)
  - f163_arg2: 行为函数 (Behavior function)
  - f163_arg3: 行为参数 (Behavior parameters)

返回值：包装后的函数 (Wrapped function)

功能说明：
  本函数用于创建高阶函数，将特定的AI和参数绑定到行为函数中。
  返回的函数可以在后续直接调用而无需传递这些参数。

使用场景：
  - 在行为表中注册函数
  - 创建函数回调
  - 函数式编程中的偏函数应用

示例：
  local boundFunc = REGIST_FUNC(aiObj, targetObj, myBehavior, params)
  boundFunc()  -- 调用已绑定的函数
]]--
function REGIST_FUNC(f163_arg0, f163_arg1, f163_arg2, f163_arg3)
    -- 返回闭包函数 (Return closure function)
    return function ()
        -- 调用行为函数，传递绑定的参数 (Call behavior function with bound parameters)
        return f163_arg2(f163_arg0, f163_arg1, f163_arg3)


    end


end


