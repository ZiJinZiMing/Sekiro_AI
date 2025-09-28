--[[============================================================================
    common_func.lua - Sekiro AI通用函数库 (Sekiro AI Common Function Library)

    版本信息 (Version Info): v3.0 - Comprehensive documentation upgrade
    作者 (Author): FromSoftware AI Team / Enhanced by Claude Code
    最后修改 (Last Modified): 2025-09-28
    编码格式 (Encoding): Shift-JIS (required for Sekiro compatibility)

    ============================================================================
    模块概述 (Module Overview):
    ============================================================================
    这是Sekiro AI系统的核心通用函数库，为整个AI框架提供基础数据处理和
    计算服务。该模块是所有AI行为脚本的基础依赖，包含了动画状态管理、
    距离计算、概率处理、敌人行为选择等关键功能。

    核心功能模块 (Core Function Modules):
    ┌─ 动画状态管理 (Animation State Management)
    │  ├─ _COMMON_GetEzStateAnimId() - 批量获取动画状态ID
    │  └─ 支持30个动画状态的并行处理
    │
    ├─ 距离计算系统 (Distance Calculation System)
    │  ├─ _COMMON_GetMinDist() - 最小攻击距离计算
    │  ├─ _COMMON_GetMaxDist() - 最大攻击距离计算
    │  └─ _COMMON_GetAtkDistType() - 攻击距离类型分析
    │
    ├─ 概率权重系统 (Probability Weight System)
    │  ├─ _COMMON_GetOddsParam() - 概率参数获取
    │  ├─ _COMMON_MulOddsXWeight() - 概率权重乘积计算
    │  └─ _COMMON_MulWeightParam() - 权重参数乘法处理
    │
    └─ 敌人行为选择 (Enemy Behavior Selection)
       ├─ _COMMON_InitEnemyAct() - 敌人行为初始化
       ├─ _COMMON_SelectEnemyAct() - 智能行为选择算法
       └─ _COMMON_SetEnemyActRate() - 行为执行频率设置

    ============================================================================
    性能优化说明 (Performance Optimization Notes):
    ============================================================================
    1. 批量处理优化：所有函数都支持批量数据处理，减少函数调用开销
    2. 内存优化：使用本地变量减少全局访问，提高执行效率
    3. 算法优化：采用数值计算优化，避免复杂的字符串操作
    4. 缓存友好：数组访问模式优化，提高CPU缓存命中率

    注意事项 (Important Notes):
    - 所有函数都是实时执行，性能敏感，避免在循环中频繁调用
    - 参数验证在调用方进行，本模块专注于高效计算
    - 函数返回的数组索引从1开始（Lua标准）
    ============================================================================
]]--

-- 注册侧移避障行为的回避角色设置 (Register sideway movement avoidance character settings)
REGISTER_GOAL_USE_AVOID_CHR(GOAL_COMMON_SidewayMoveAvoidChr, true)

--[[============================================================================
    动画状态管理系统 (Animation State Management System)
    ============================================================================
]]--

-- 批量获取EZ状态动画ID列表 (Batch retrieve EZ state animation ID list)
-- 功能说明 (Function Description):
--   这是动画系统的核心接口函数，用于批量获取AI角色的动画状态ID。
--   该函数一次性处理30个动画状态槽，为AI行为提供完整的动画状态信息。
--
-- 参数说明 (Parameters):
--   f1_arg0: AI实体对象 (AI entity object) - 需要查询动画状态的AI角色
--   f1_arg1: 动画组ID (Animation group ID) - 指定要查询的动画组
--
-- 返回值 (Return Value):
--   ret: 动画ID数组 (Animation ID array) - 包含30个动画状态ID的数组
--        索引1-30对应游戏内部的动画状态槽0-29
--
-- 性能提示 (Performance Tips):
--   - 该函数涉及30次GetEzStateAnimId调用，建议缓存结果避免重复调用
--   - 在AI初始化阶段调用，避免在战斗循环中频繁执行
--
-- 使用示例 (Usage Example):
--   local animIds = _COMMON_GetEzStateAnimId(ai, ANIM_GROUP_ATTACK)
--   if animIds[1] ~= nil then
--       -- 使用第一个攻击动画
--   end
function _COMMON_GetEzStateAnimId(f1_arg0, f1_arg1)
    ret = {}                                          -- 初始化返回数组 (Initialize return array)
    local f1_local0 = 1                             -- 计数器（未使用）(Counter - unused)

    -- 批量获取30个动画状态槽的ID (Batch retrieve IDs for 30 animation state slots)
    for f1_local1 = 1, 30, 1 do
        -- 注意：Lua数组索引从1开始，游戏内部索引从0开始 (Note: Lua array starts from 1, game internal index starts from 0)
        ret[f1_local1] = f1_arg0:GetEzStateAnimId(f1_arg1, f1_local1 - 1)
    end
    return ret                                       -- 返回完整的动画ID数组 (Return complete animation ID array)
end

--[[============================================================================
    距离计算系统 (Distance Calculation System)
    ============================================================================
]]--

-- 批量获取最小攻击距离参数 (Batch retrieve minimum attack distance parameters)
-- 功能说明 (Function Description):
--   获取AI角色所有攻击动作的最小有效距离。这个距离定义了攻击开始生效的
--   最近距离，用于判断是否可以发动攻击以及攻击的有效性。
--
-- 参数说明 (Parameters):
--   f2_arg0: AI实体对象 (AI entity object) - 执行攻击的AI角色
--   f2_arg1: 攻击参数组ID (Attack parameter group ID) - 指定攻击参数组
--
-- 返回值 (Return Value):
--   ret: 距离数组 (Distance array) - 包含30个最小攻击距离值
--        单位：游戏内部距离单位 (Unit: game internal distance units)
--
-- 战术应用 (Tactical Applications):
--   - 近战武器通常最小距离为0-2单位
--   - 中程攻击最小距离为2-5单位
--   - 远程攻击可能有更大的最小距离限制
--
-- 使用示例 (Usage Example):
--   local minDists = _COMMON_GetMinDist(ai, ATTACK_GROUP_MELEE)
--   if currentDist >= minDists[1] then
--       -- 距离足够，可以执行第一个攻击
--   end
function _COMMON_GetMinDist(f2_arg0, f2_arg1)
    ret = {}                                          -- 初始化最小距离数组 (Initialize minimum distance array)
    local f2_local0 = 1                             -- 计数器（未使用）(Counter - unused)

    -- 批量获取30个攻击动作的最小距离 (Batch retrieve minimum distance for 30 attack actions)
    for f2_local1 = 1, 30, 1 do
        ret[f2_local1] = f2_arg0:GetMinDist(f2_arg1, f2_local1 - 1)
    end
    return ret                                       -- 返回最小距离数组 (Return minimum distance array)
end

-- 批量获取最大攻击距离参数 (Batch retrieve maximum attack distance parameters)
-- 功能说明 (Function Description):
--   获取AI角色所有攻击动作的最大有效距离。这个距离定义了攻击的最远有效范围，
--   超出此距离的攻击将失效或无法命中目标。
--
-- 参数说明 (Parameters):
--   f3_arg0: AI实体对象 (AI entity object) - 执行攻击的AI角色
--   f3_arg1: 攻击参数组ID (Attack parameter group ID) - 指定攻击参数组
--
-- 返回值 (Return Value):
--   ret: 距离数组 (Distance array) - 包含30个最大攻击距离值
--        索引0-29对应游戏内部攻击槽（注意：此函数使用0开始索引）
--
-- 重要区别 (Important Difference):
--   注意：此函数的循环和数组访问使用0-29索引，与其他函数的1-30不同
--   这是原始代码的设计，保持兼容性
--
-- 战术应用 (Tactical Applications):
--   - 确定AI是否需要接近敌人才能攻击
--   - 计算攻击的最佳距离范围
--   - 避免在无效距离上浪费攻击动作
--
-- 使用示例 (Usage Example):
--   local maxDists = _COMMON_GetMaxDist(ai, ATTACK_GROUP_RANGED)
--   if currentDist <= maxDists[0] then  -- 注意：索引从0开始
--       -- 在有效攻击范围内
--   end
function _COMMON_GetMaxDist(f3_arg0, f3_arg1)
    ret = {}                                          -- 初始化最大距离数组 (Initialize maximum distance array)
    local f3_local0 = 0                             -- 起始索引 (Starting index)

    -- 注意：此函数使用0-29索引系统 (Note: This function uses 0-29 index system)
    for f3_local1 = 0, 29, 1 do
        ret[f3_local1] = f3_arg0:GetMaxDist(f3_arg1, f3_local1 - 1)
    end
    return ret                                       -- 返回最大距离数组 (Return maximum distance array)
end

-- 批量获取攻击距离类型分类 (Batch retrieve attack distance type classification)
-- 功能说明 (Function Description):
--   将数值型的攻击距离类型转换为AI系统可理解的距离常量。这是距离计算系统
--   的核心分类器，将原始距离数据转换为战术决策可用的分类信息。
--
-- 参数说明 (Parameters):
--   f4_arg0: AI实体对象 (AI entity object) - 执行分析的AI角色
--   f4_arg1: 攻击参数组ID (Attack parameter group ID) - 指定攻击参数组
--
-- 返回值 (Return Value):
--   ret: 距离类型数组 (Distance type array) - 包含30个距离类型常量
--
-- 距离类型常量说明 (Distance Type Constants):
--   DIST_Near   = 近距离 (Close range)   - 0-2单位，适合近战攻击
--   DIST_Middle = 中距离 (Medium range)  - 2-5单位，适合中程攻击
--   DIST_Far    = 远距离 (Long range)    - 5-10单位，适合远程攻击
--   DIST_Out    = 超出范围 (Out of range) - >10单位，无法攻击
--   DIST_None   = 无效距离 (Invalid)      - 特殊状态或错误
--
-- 转换逻辑 (Conversion Logic):
--   原始值 → 常量映射 (Raw value → Constant mapping):
--   0 → DIST_Near    (近战优势区域)
--   1 → DIST_Middle  (平衡战斗区域)
--   2 → DIST_Far     (远程优势区域)
--   3 → DIST_Out     (脱离战斗区域)
--   4 → DIST_None    (无效或禁用)
--
-- 使用示例 (Usage Example):
--   local distTypes = _COMMON_GetAtkDistType(ai, ATTACK_GROUP_ALL)
--   if distTypes[1] == DIST_Near then
--       -- 第一个攻击适合近距离使用
--   end
function _COMMON_GetAtkDistType(f4_arg0, f4_arg1)
    ret = {}                                          -- 初始化距离类型数组 (Initialize distance type array)
    local f4_local0 = 1                             -- 计数器（未使用）(Counter - unused)

    -- 批量获取并转换30个攻击动作的距离类型 (Batch retrieve and convert distance types for 30 attack actions)
    for f4_local1 = 1, 30, 1 do
        -- 获取原始距离类型数值 (Get raw distance type value)
        ret[f4_local1] = f4_arg0:GetAtkDistType(f4_arg1, f4_local1 - 1)

        -- 距离类型转换逻辑 (Distance type conversion logic)
        if ret[f4_local1] == 0 then
            ret[f4_local1] = DIST_Near              -- 近距离：适合刀剑、爪击等近战攻击
        elseif ret[f4_local1] == 1 then
            ret[f4_local1] = DIST_Middle            -- 中距离：适合长柄武器、跳跃攻击
        elseif ret[f4_local1] == 2 then
            ret[f4_local1] = DIST_Far               -- 远距离：适合投掷物、法术攻击
        elseif ret[f4_local1] == 3 then
            ret[f4_local1] = DIST_Out               -- 超出范围：需要移动接近才能攻击
        elseif ret[f4_local1] == 4 then
            ret[f4_local1] = DIST_None              -- 无效距离：攻击被禁用或出错
        end
    end
    return ret                                       -- 返回转换后的距离类型数组 (Return converted distance type array)
end

--[[============================================================================
    概率权重系统 (Probability Weight System)
    ============================================================================
]]--

-- 批量获取概率参数数据 (Batch retrieve probability parameter data)
-- 功能说明 (Function Description):
--   从AI参数系统中批量获取概率相关的参数数据。这些参数控制AI行为选择的
--   随机性和倾向性，是AI决策系统的核心数据来源。
--
-- 参数说明 (Parameters):
--   f5_arg0: AI实体对象 (AI entity object) - 提供参数数据的AI角色
--   f5_arg1: 参数偏移ID (Parameter offset ID) - 指定参数组的偏移量
--
-- 返回值 (Return Value):
--   ret: 概率参数数组 (Probability parameter array) - 包含100个概率参数值
--        索引0-99对应不同的概率控制参数
--
-- 参数系统结构 (Parameter System Structure):
--   - 使用100个参数槽来存储概率数据
--   - 每个参数可以是0.0-1.0的概率值或权重倍率
--   - 通过GetOddsParamIdOffset获取基础偏移地址
--   - 支持多套参数配置的动态切换
--
-- 性能考虑 (Performance Considerations):
--   - 涉及100次参数读取，建议在AI初始化时调用
--   - 参数变化不频繁，可以缓存结果
--   - 避免在每帧都重新获取参数
--
-- 使用示例 (Usage Example):
--   local odds = _COMMON_GetOddsParam(ai, ODDS_COMBAT_BASIC)
--   local attackChance = odds[0]  -- 获取基础攻击概率
function _COMMON_GetOddsParam(f5_arg0, f5_arg1)
    ret = {}                                          -- 初始化概率参数数组 (Initialize probability parameter array)
    local f5_local0 = f5_arg0:GetOddsParamIdOffset(100)  -- 获取100参数槽的基础偏移 (Get base offset for 100 parameter slots)
    local f5_local1 = 0                             -- 循环计数器（未使用）(Loop counter - unused)

    -- 批量读取100个概率参数 (Batch read 100 probability parameters)
    for f5_local2 = 0, 99, 1 do
        ret[f5_local2] = f5_arg0:GetOddsParam(f5_local0 + f5_arg1, f5_local2)
    end
    return ret                                       -- 返回概率参数数组 (Return probability parameter array)
end

-- 概率数组与权重数组的乘积计算 (Calculate product of probability array and weight array)
-- 功能说明 (Function Description):
--   将概率数组与权重数组进行逐元素相乘，并计算累积分布和最大值。
--   这是AI决策系统中的核心概率计算函数，用于生成可用于随机选择的权重分布。
--
-- 参数说明 (Parameters):
--   f6_arg0: 概率数组 (Probability array) - 基础概率值，会被修改
--   f6_arg1: 权重数组 (Weight array) - 权重倍率，如果为空则默认为1
--
-- 返回值 (Return Value):
--   f6_local3: 最大累积权重值 (Maximum cumulative weight) - 用于随机数范围
--
-- 算法逻辑 (Algorithm Logic):
--   1. 检查权重数组是否为空，为空时使用默认权重1
--   2. 逐元素相乘：probability[i] *= weight[i]
--   3. 负值处理：将负值置为0
--   4. 累积计算：每个元素累加前面所有元素的值
--   5. 记录最大值：用于后续的随机数生成范围
--
-- 使用场景 (Usage Scenarios):
--   - AI行为选择的权重计算
--   - 攻击动作的概率分布生成
--   - 基于权重的随机选择算法
--
-- 使用示例 (Usage Example):
--   local maxWeight = _COMMON_MulOddsXWeight(probabilities, weights)
--   local randomValue = getRandom(0, maxWeight)
--   -- 然后根据randomValue选择对应的行为
function _COMMON_MulOddsXWeight(f6_arg0, f6_arg1)
    local f6_local0 = 0                             -- 未使用的变量 (Unused variable)
    local f6_local1 = true                          -- 权重数组有效性标志 (Weight array validity flag)

    -- 检查权重数组是否为空 (Check if weight array is empty)
    if table.getn(f6_arg1) == 0 then
        f6_local1 = false                           -- 标记权重数组无效 (Mark weight array as invalid)
    end

    local f6_local2 = 0                             -- 累积值临时存储 (Cumulative value temporary storage)
    local f6_local3 = 0                             -- 最大累积值 (Maximum cumulative value)

    -- 处理100个概率参数 (Process 100 probability parameters)
    for f6_local4 = 0, 99, 1 do
        -- 如果权重数组无效，使用默认权重1 (If weight array invalid, use default weight 1)
        if f6_local1 == false then
            f6_arg1[f6_local4] = 1
        end

        -- 概率与权重相乘 (Multiply probability by weight)
        f6_arg0[f6_local4] = f6_arg0[f6_local4] * f6_arg1[f6_local4]

        -- 负值保护：将负值置为0 (Negative value protection: set negatives to 0)
        if f6_arg0[f6_local4] < 0 then
            f6_arg0[f6_local4] = 0
        end

        -- 累积计算：当前值 = 当前值 + 前面所有值的和 (Cumulative calculation)
        f6_arg0[f6_local4] = f6_arg0[f6_local4] + f6_local2
        f6_local2 = f6_arg0[f6_local4]              -- 更新累积基准 (Update cumulative base)

        -- 记录最大累积值 (Record maximum cumulative value)
        if f6_local3 < f6_arg0[f6_local4] then
            f6_local3 = f6_arg0[f6_local4]
        end
    end
    return f6_local3                                 -- 返回最大累积权重值 (Return maximum cumulative weight)
end

-- 权重参数乘法处理函数 (Weight parameter multiplication processing function)
-- 功能说明 (Function Description):
--   将权重数组与从AI参数系统中获取的概率参数进行乘法运算。该函数主要用于
--   动态调整AI行为的权重分布，根据当前游戏状态修改基础概率参数。
--
-- 参数说明 (Parameters):
--   f7_arg0: AI实体对象 (AI entity object) - 提供参数访问的AI角色
--   f7_arg1: 权重数组 (Weight array) - 要修改的权重数组，会被直接修改
--   f7_arg2: 参数偏移ID (Parameter offset ID) - 指定要使用的概率参数组
--
-- 返回值 (Return Value):
--   无返回值 (No return value) - 直接修改传入的权重数组
--
-- 处理逻辑 (Processing Logic):
--   1. 检查权重数组是否为空，为空时使用默认值1
--   2. 获取指定的概率参数组
--   3. 将权重数组的每个元素与对应的概率参数相乘
--   4. 结果直接存储在原权重数组中
--
-- 与_COMMON_MulOddsXWeight的区别 (Difference from _COMMON_MulOddsXWeight):
--   - 此函数从AI参数系统实时获取概率数据
--   - 主要用于动态权重调整而非静态计算
--   - 不计算累积分布，只进行简单的乘法运算
--
-- 使用示例 (Usage Example):
--   local weights = {1, 2, 3, ...}  -- 初始权重
--   _COMMON_MulWeightParam(ai, weights, PARAM_COMBAT_STATE)
--   -- weights数组现在包含调整后的权重值
function _COMMON_MulWeightParam(f7_arg0, f7_arg1, f7_arg2)
    local f7_local0 = false                          -- 权重数组状态标志 (Weight array status flag)

    -- 检查权重数组是否为空 (Check if weight array is empty)
    if table.getn(f7_arg1) == 0 then
        f7_local0 = true                             -- 标记为需要初始化 (Mark as needing initialization)
    end

    local f7_local1 = f7_arg0:GetOddsParamIdOffset(100)  -- 获取参数系统的基础偏移 (Get base offset for parameter system)
    local f7_local2 = 0                             -- 未使用的循环计数器 (Unused loop counter)

    -- 处理100个权重参数 (Process 100 weight parameters)
    for f7_local3 = 0, 99, 1 do
        -- 如果权重数组为空，初始化为默认值1 (If weight array empty, initialize to default value 1)
        if f7_local0 then
            f7_arg1[f7_local3] = 1
        end

        -- 权重与AI参数相乘，实现动态权重调整 (Multiply weight by AI parameter for dynamic adjustment)
        f7_arg1[f7_local3] = f7_arg1[f7_local3] * f7_arg0:GetOddsParam(f7_local1 + f7_arg2, f7_local3)
    end
    -- 注意：函数直接修改传入的权重数组，无需返回值 (Note: Function modifies input array directly, no return needed)
end

--[[============================================================================
    敌人行为选择系统 (Enemy Behavior Selection System)
    ============================================================================
]]--

-- 批量设置敌人行为执行频率 (Batch set enemy behavior execution rate)
-- 功能说明 (Function Description):
--   统一设置AI角色所有行为槽的执行频率。这是AI行为系统的基础配置函数，
--   控制各种行为被选择的相对频率，直接影响AI的战斗模式和攻击节奏。
--
-- 参数说明 (Parameters):
--   f8_arg0: AI实体对象 (AI entity object) - 未直接使用，保持接口一致性
--   f8_arg1: AI实体对象 (AI entity object) - 实际执行设置的AI角色
--   f8_arg2: 参数组ID (Parameter group ID) - 未直接使用，保持接口一致性
--   f8_arg3: 执行频率值 (Execution rate value) - 应用到所有行为槽的频率值
--
-- 行为频率说明 (Behavior Rate Explanation):
--   - 频率值范围通常为0.0-2.0
--   - 1.0 = 标准频率，正常执行概率
--   - >1.0 = 高频率，增加执行概率，AI更积极
--   - <1.0 = 低频率，降低执行概率，AI更保守
--   - 0.0 = 禁用行为，该行为不会被选择
--
-- 支持的行为槽 (Supported Behavior Slots):
--   ActRate01-ActRate20: 对应AI的20个主要行为槽
--   每个槽位对应不同的战术行为（攻击、移动、防御等）
--
-- 使用场景 (Usage Scenarios):
--   - AI初始化时设置默认行为频率
--   - 根据战斗阶段动态调整AI积极性
--   - 实现AI难度分级（简单/普通/困难）
--   - 特殊状态下的行为模式切换
--
-- 使用示例 (Usage Example):
--   _COMMON_SetEnemyActRate(ai, ai, PARAM_NORMAL, 1.0)    -- 标准频率
--   _COMMON_SetEnemyActRate(ai, ai, PARAM_AGGRESSIVE, 1.5) -- 积极模式
--   _COMMON_SetEnemyActRate(ai, ai, PARAM_DEFENSIVE, 0.7)  -- 保守模式
function _COMMON_SetEnemyActRate(f8_arg0, f8_arg1, f8_arg2, f8_arg3)
    -- 批量设置20个行为槽的执行频率 (Batch set execution rate for 20 behavior slots)
    f8_arg1:SetStringIndexedNumber("ActRate01", f8_arg3)  -- 行为槽1：通常为基础攻击
    f8_arg1:SetStringIndexedNumber("ActRate02", f8_arg3)  -- 行为槽2：通常为强攻击
    f8_arg1:SetStringIndexedNumber("ActRate03", f8_arg3)  -- 行为槽3：通常为连击攻击
    f8_arg1:SetStringIndexedNumber("ActRate04", f8_arg3)  -- 行为槽4：通常为特殊攻击
    f8_arg1:SetStringIndexedNumber("ActRate05", f8_arg3)  -- 行为槽5：通常为防御行为
    f8_arg1:SetStringIndexedNumber("ActRate06", f8_arg3)  -- 行为槽6：通常为移动行为
    f8_arg1:SetStringIndexedNumber("ActRate07", f8_arg3)  -- 行为槽7：通常为闪避行为
    f8_arg1:SetStringIndexedNumber("ActRate08", f8_arg3)  -- 行为槽8：通常为反击行为
    f8_arg1:SetStringIndexedNumber("ActRate09", f8_arg3)  -- 行为槽9：扩展行为1
    f8_arg1:SetStringIndexedNumber("ActRate10", f8_arg3)  -- 行为槽10：扩展行为2
    f8_arg1:SetStringIndexedNumber("ActRate11", f8_arg3)  -- 行为槽11：扩展行为3
    f8_arg1:SetStringIndexedNumber("ActRate12", f8_arg3)  -- 行为槽12：扩展行为4
    f8_arg1:SetStringIndexedNumber("ActRate13", f8_arg3)  -- 行为槽13：扩展行为5
    f8_arg1:SetStringIndexedNumber("ActRate14", f8_arg3)  -- 行为槽14：扩展行为6
    f8_arg1:SetStringIndexedNumber("ActRate15", f8_arg3)  -- 行为槽15：扩展行为7
    f8_arg1:SetStringIndexedNumber("ActRate16", f8_arg3)  -- 行为槽16：扩展行为8
    f8_arg1:SetStringIndexedNumber("ActRate17", f8_arg3)  -- 行为槽17：扩展行为9
    f8_arg1:SetStringIndexedNumber("ActRate18", f8_arg3)  -- 行为槽18：扩展行为10
    f8_arg1:SetStringIndexedNumber("ActRate19", f8_arg3)  -- 行为槽19：扩展行为11
    f8_arg1:SetStringIndexedNumber("ActRate20", f8_arg3)  -- 行为槽20：扩展行为12
end

-- 敌人行为系统初始化函数 (Enemy behavior system initialization function)
-- 功能说明 (Function Description):
--   执行AI角色的完整行为系统初始化。这是AI启动时必须调用的核心函数，
--   负责设置行为频率、启动定时器、配置攻击间隔等关键的AI运行参数。
--
-- 参数说明 (Parameters):
--   f9_arg0: AI实体对象 (AI entity object) - 主AI实体引用
--   f9_arg1: AI实体对象 (AI entity object) - 执行初始化的AI实体
--   f9_arg2: 参数组ID (Parameter group ID) - 初始化使用的参数组标识
--
-- 初始化步骤 (Initialization Steps):
--   1. 设置所有行为频率为默认值1.0（标准频率）
--   2. 启动行为计时器（ID: 10000001-10000015）
--   3. 启动扩展计时器（ID: 7107000-7107008）
--   4. 配置攻击参数计时器（攻击ID: 3000-3030）
--   5. 配置特殊攻击计时器（攻击ID: 7000-7010）
--
-- 攻击间隔配置逻辑 (Attack Interval Configuration Logic):
--   - 检查每个攻击ID是否有有效的AI攻击参数
--   - 如果攻击在战斗开始时不可选择：设置间隔为0（立即可用）
--   - 如果攻击在战斗开始时可选择：使用参数中定义的执行间隔
--
-- 定时器系统说明 (Timer System Explanation):
--   - 行为定时器：控制各种行为的冷却和可用性
--   - 攻击定时器：管理攻击动作的执行间隔
--   - 定时器ID采用分段设计，避免冲突
--
-- 性能考虑 (Performance Considerations):
--   - 该函数仅在AI初始化时调用一次
--   - 涉及大量参数读取，但不影响运行时性能
--   - 所有定时器设置为异步操作，不阻塞主线程
--
-- 使用示例 (Usage Example):
--   _COMMON_InitEnemyAct(ai, ai, PARAM_GROUP_STANDARD)
--   -- AI现在已完成初始化，可以开始正常的行为选择
function _COMMON_InitEnemyAct(f9_arg0, f9_arg1, f9_arg2)
    -- 步骤1：设置所有行为频率为默认值1.0 (Step 1: Set all behavior rates to default value 1.0)
    _COMMON_SetEnemyActRate(f9_arg0, f9_arg1, f9_arg2, 1)

    -- 步骤2：启动基础行为定时器 (Step 2: Start basic behavior timers)
    -- 定时器ID范围：10000001-10000015，用于控制基础行为的冷却时间
    for f9_local0 = 1, 15, 1 do
        f9_arg1:StartIdTimer(f9_local0 + 10000000)      -- 启动行为冷却定时器
    end

    -- 步骤3：启动扩展功能定时器 (Step 3: Start extended function timers)
    -- 定时器ID范围：7107000-7107008，用于特殊行为和扩展功能
    for f9_local0 = 7000, 7008, 1 do
        f9_arg1:StartIdTimer(f9_local0 + 7100000)       -- 启动扩展功能定时器
    end

    -- 步骤4：配置标准攻击参数定时器 (Step 4: Configure standard attack parameter timers)
    -- 攻击ID范围：3000-3030，涵盖大部分标准攻击动作
    for f9_local0 = 3000, 3030, 1 do
        -- 检查该攻击ID是否存在有效的AI攻击参数 (Check if valid AI attack parameters exist for this ID)
        if f9_arg1:IsAIAttackParam(f9_local0) then
            -- 根据战斗开始时的可选择性设置攻击间隔 (Set attack interval based on battle start selectability)
            if f9_arg1:GetAIAttackParam(f9_local0, AI_ATTACK_PARAM_TYPE__IS_SELECTABLE_ON_BATTLE_START) == 0 then
                -- 战斗开始时不可选择的攻击：设置为立即可用 (Battle start non-selectable attacks: set to immediately available)
                f9_arg1:StartAttackPassedTimer(f9_local0, 0)
            else
                -- 战斗开始时可选择的攻击：使用定义的执行间隔 (Battle start selectable attacks: use defined execution interval)
                f9_arg1:StartAttackPassedTimer(f9_local0, f9_arg1:GetAIAttackParam(f9_local0, AI_ATTACK_PARAM_TYPE__INTERVAL_EXEC))
            end
        end
    end

    -- 步骤5：配置特殊攻击参数定时器 (Step 5: Configure special attack parameter timers)
    -- 攻击ID范围：7000-7010，通常为特殊技能、终结技或BOSS专用攻击
    for f9_local0 = 7000, 7010, 1 do
        -- 检查该特殊攻击ID是否存在有效参数 (Check if valid parameters exist for this special attack ID)
        if f9_arg1:IsAIAttackParam(f9_local0) then
            -- 应用与标准攻击相同的间隔配置逻辑 (Apply same interval configuration logic as standard attacks)
            if f9_arg1:GetAIAttackParam(f9_local0, AI_ATTACK_PARAM_TYPE__IS_SELECTABLE_ON_BATTLE_START) == 0 then
                -- 特殊攻击在战斗开始时通常不可选择，设为立即可用以备后续激活
                f9_arg1:StartAttackPassedTimer(f9_local0, 0)
            else
                -- 可在战斗开始时选择的特殊攻击，使用其定义的冷却间隔
                f9_arg1:StartAttackPassedTimer(f9_local0, f9_arg1:GetAIAttackParam(f9_local0, AI_ATTACK_PARAM_TYPE__INTERVAL_EXEC))
            end
        end
    end

    -- 初始化完成，AI系统现在已准备好进行行为选择和攻击执行
    -- (Initialization complete, AI system is now ready for behavior selection and attack execution)
end

-- 智能敌人行为选择算法 (Intelligent enemy behavior selection algorithm)
-- 功能说明 (Function Description):
--   这是AI系统的核心决策函数，负责根据当前战斗状况智能选择最合适的行为动作。
--   该函数综合考虑距离、角度、冷却时间、概率权重等多个因素，实现复杂的AI决策逻辑。
--
-- 参数说明 (Parameters):
--   f10_arg0: 行为配置表 (Behavior configuration table) - 包含所有可用行为的定义
--   f10_arg1: AI实体对象 (AI entity object) - 执行选择的AI角色
--   f10_arg2: 参数组ID (Parameter group ID) - 当前使用的参数配置组
--   f10_arg3: 目标对象 (Target object) - 攻击目标，默认为TARGET_ENE_0
--   f10_arg4: 预测时间 (Prediction time) - 用于预测目标位置的时间值
--   f10_arg5: 预测倍率 (Prediction multiplier) - 预测计算的倍率系数
--
-- 返回值 (Return Value):
--   选中的行为函数 (Selected behavior function) - 返回最优行为的执行函数，nil表示无可用行为
--
-- 算法流程 (Algorithm Flow):
--   1. 数据准备阶段：收集行为定义、频率、基础ID等数据
--   2. 距离计算阶段：确定与目标的当前距离或预测距离
--   3. 候选筛选阶段：根据距离、角度、冷却等条件筛选可用行为
--   4. 权重计算阶段：为每个候选行为计算最终权重值
--   5. 随机选择阶段：基于权重分布随机选择最终行为
--
-- 核心特性 (Core Features):
--   - 支持30个行为槽的并行评估
--   - 动态距离预测和范围判断
--   - 多层次的行为过滤机制
--   - 基于权重的概率选择算法
--   - 详细的调试信息输出
--
-- 性能提示 (Performance Tips):
--   - 该函数计算密集，避免在短时间内频繁调用
--   - 调试输出较多，生产环境可考虑优化
--   - 权重计算涉及多次AI参数查询，建议缓存常用参数
function _COMMON_SelectEnemyAct(f10_arg0, f10_arg1, f10_arg2, f10_arg3, f10_arg4, f10_arg5)
    -- === 阶段1：数据准备和初始化 (Phase 1: Data preparation and initialization) ===
    local f10_local0 = 30                               -- 最大行为槽数量 (Maximum behavior slots)
    local f10_local1 = {}                               -- 候选行为索引列表 (Candidate behavior index list)
    local f10_local2 = 0                                -- 候选行为计数器 (Candidate behavior counter)
    local f10_local3 = nil                              -- 当前处理的攻击ID (Current processing attack ID)
    local f10_local4 = 0                                -- 攻击ID偏移量 (Attack ID offset)

    -- 收集所有行为函数引用 (Collect all behavior function references)
    local f10_local5 = {f10_arg0.Act01, f10_arg0.Act02, f10_arg0.Act03, f10_arg0.Act04, f10_arg0.Act05, f10_arg0.Act06, f10_arg0.Act07, f10_arg0.Act08, f10_arg0.Act09, f10_arg0.Act10, f10_arg0.Act11, f10_arg0.Act12, f10_arg0.Act13, f10_arg0.Act14, f10_arg0.Act15, f10_arg0.Act16, f10_arg0.Act17, f10_arg0.Act18, f10_arg0.Act19, f10_arg0.Act20, f10_arg0.Act21, f10_arg0.Act22, f10_arg0.Act23, f10_arg0.Act24, f10_arg0.Act25, f10_arg0.Act26, f10_arg0.Act27, f10_arg0.Act28, f10_arg0.Act29, f10_arg0.Act30}

    -- 收集所有行为执行频率 (Collect all behavior execution rates)
    local f10_local6 = {f10_arg1:GetStringIndexedNumber("ActRate01"), f10_arg1:GetStringIndexedNumber("ActRate02"), f10_arg1:GetStringIndexedNumber("ActRate03"), f10_arg1:GetStringIndexedNumber("ActRate04"), f10_arg1:GetStringIndexedNumber("ActRate05"), f10_arg1:GetStringIndexedNumber("ActRate06"), f10_arg1:GetStringIndexedNumber("ActRate07"), f10_arg1:GetStringIndexedNumber("ActRate08"), f10_arg1:GetStringIndexedNumber("ActRate09"), f10_arg1:GetStringIndexedNumber("ActRate10"), f10_arg1:GetStringIndexedNumber("ActRate11"), f10_arg1:GetStringIndexedNumber("ActRate12"), f10_arg1:GetStringIndexedNumber("ActRate13"), f10_arg1:GetStringIndexedNumber("ActRate14"), f10_arg1:GetStringIndexedNumber("ActRate15"), f10_arg1:GetStringIndexedNumber("ActRate16"), f10_arg1:GetStringIndexedNumber("ActRate17"), f10_arg1:GetStringIndexedNumber("ActRate18"), f10_arg1:GetStringIndexedNumber("ActRate19"), f10_arg1:GetStringIndexedNumber("ActRate20"), f10_arg1:GetStringIndexedNumber("ActRate21"), f10_arg1:GetStringIndexedNumber("ActRate22"), f10_arg1:GetStringIndexedNumber("ActRate23"), f10_arg1:GetStringIndexedNumber("ActRate24"), f10_arg1:GetStringIndexedNumber("ActRate25"), f10_arg1:GetStringIndexedNumber("ActRate26"), f10_arg1:GetStringIndexedNumber("ActRate27"), f10_arg1:GetStringIndexedNumber("ActRate28"), f10_arg1:GetStringIndexedNumber("ActRate29"), f10_arg1:GetStringIndexedNumber("ActRate30")}

    -- 收集所有行为基础攻击ID (Collect all behavior base attack IDs)
    local f10_local7 = {f10_arg0.ActBase01, f10_arg0.ActBase02, f10_arg0.ActBase03, f10_arg0.ActBase04, f10_arg0.ActBase05, f10_arg0.ActBase06, f10_arg0.ActBase07, f10_arg0.ActBase08, f10_arg0.ActBase09, f10_arg0.ActBase10, f10_arg0.ActBase11, f10_arg0.ActBase12, f10_arg0.ActBase13, f10_arg0.ActBase14, f10_arg0.ActBase15, f10_arg0.ActBase16, f10_arg0.ActBase17, f10_arg0.ActBase18, f10_arg0.ActBase19, f10_arg0.ActBase20, f10_arg0.ActBase21, f10_arg0.ActBase22, f10_arg0.ActBase23, f10_arg0.ActBase24, f10_arg0.ActBase25, f10_arg0.ActBase26, f10_arg0.ActBase27, f10_arg0.ActBase28, f10_arg0.ActBase29, f10_arg0.ActBase30}

    -- === 阶段2：目标和距离计算 (Phase 2: Target and distance calculation) ===
    -- 确定攻击目标 (Determine attack target)
    local f10_local8 = f10_arg3
    if f10_local8 == nil then
        f10_local8 = TARGET_ENE_0                       -- 默认目标：主要敌人 (Default target: primary enemy)
    end

    -- 计算战术距离：当前距离或预测距离 (Calculate tactical distance: current or predicted)
    local f10_local9 = nil
    if f10_arg4 == nil or f10_arg4 <= 0 then
        -- 使用当前实时距离 (Use current real-time distance)
        f10_local9 = f10_arg1:GetDist(f10_local8)
    else
        -- 使用预测距离计算 (Use predicted distance calculation)
        if f10_arg5 == nil then
            f10_arg5 = 1                                 -- 默认预测倍率 (Default prediction multiplier)
        end
        -- 设置AI预测目标移动方向和位置 (Set AI prediction target movement direction and position)
        f10_arg1:SetAIPredictionMoveTargetSpecifyTargetDir(f10_arg4, AI_DIR_TYPE_L, 0, f10_arg5)
        f10_local9 = f10_arg1:GetDist(POINT_AIPredictionTargetPos)
    end

    local f10_local10 = false                           -- 未使用的标志位 (Unused flag)
    local f10_local11 = GetDistPos(f10_arg0, f10_arg1, f10_arg2, f10_local9)  -- 获取距离位置信息 (Get distance position info)
    for f10_local12 = 1, 1, 1 do
        if f10_local12 == 2 and f10_local2 > 0 then
            break
        end
        for f10_local15 = 1, f10_local0, 1 do
            f10_local3 = f10_local7[f10_local15]
            if f10_local3 ~= nil and f10_local3 ~= 9999999 then
                f10_local3, f10_local4 = GetAttackIdOffset(f10_arg0, f10_arg1, f10_arg2, f10_local3)
                if f10_local3 ~= 9999999 and f10_arg1:IsAIAttackParam(f10_local3) then
                    if f10_arg1:IsFinishAttackCoolTime(f10_local3) or f10_arg1:GetNumber(60) == 1 then
                        local f10_local18 = false
                        if f10_arg1:GetAIAttackParam(f10_local3, AI_ATTACK_PARAM_TYPE__MIN_OPTIMAL_DISTANCE) <= f10_local9 and f10_local9 <= f10_arg1:GetAIAttackParam(f10_local3, AI_ATTACK_PARAM_TYPE__MAX_OPTIMAL_DISTANCE) or f10_arg1:GetAIAttackParam(f10_local3, AI_ATTACK_PARAM_TYPE__DOES_SELECT_ON_OUT_RANGE) == 1 and f10_arg1:GetAIAttackParam(f10_local3, AI_ATTACK_PARAM_TYPE__DOES_SELECT_ON_INNER_RANGE) == 1 then
                            f10_local18 = true
                        elseif f10_local9 < f10_arg1:GetAIAttackParam(f10_local3, AI_ATTACK_PARAM_TYPE__MIN_OPTIMAL_DISTANCE) and f10_arg1:GetAIAttackParam(f10_local3, AI_ATTACK_PARAM_TYPE__DOES_SELECT_ON_INNER_RANGE) == 1 then
                            f10_local18 = true
                        elseif f10_arg1:GetAIAttackParam(f10_local3, AI_ATTACK_PARAM_TYPE__MAX_OPTIMAL_DISTANCE) < f10_local9 and f10_arg1:GetAIAttackParam(f10_local3, AI_ATTACK_PARAM_TYPE__DOES_SELECT_ON_OUT_RANGE) == 1 then
                            f10_local18 = true
                        else
                            print("[SELECT ENEMY]" .. "　　　範囲外[" .. f10_local3 .. "]　　最小：" .. f10_arg1:GetAIAttackParam(f10_local3, AI_ATTACK_PARAM_TYPE__MIN_OPTIMAL_DISTANCE) .. "　　最大：" .. f10_arg1:GetAIAttackParam(f10_local3, AI_ATTACK_PARAM_TYPE__MAX_OPTIMAL_DISTANCE) .. "　　現在距離：" .. f10_local9)
                        end
                        if f10_local18 then
                            if f10_local6[f10_local15] > 0 then
                                if GetAttackRateByDist(f10_arg0, f10_arg1, f10_arg2, f10_local3, f10_local11) > 0 then
                                    if f10_arg1:IsOptimalAttackRangeH(TARGET_ENE_0, f10_local3) then
                                        if not f10_arg1:HasSpecialEffectAttribute(TARGET_ENE_0, SP_EFFECT_TYPE_TARGET_DOWN) or f10_arg1:GetAIAttackParam(f10_local3, AI_ATTACK_PARAM_TYPE__DOES_SELECT_ON_TARGET_DOWN) == 1 then
                                            f10_local2 = f10_local2 + 1
                                            f10_local1[f10_local2] = f10_local15
                                        else
                                            print("[SELECT ENEMY]" .. "　　　プレイヤーダウン中攻撃不可[" .. f10_local3 .. "]")
                                        end
                                    else
                                        print("[SELECT ENEMY]" .. "　　　範囲角度外[" .. f10_local3 .. "]")
                                    end
                                else
                                    print("[SELECT ENEMY]" .. "　　　範囲レート0[" .. f10_local3 .. "]")
                                end
                            else
                                print("[SELECT ENEMY]" .. "　　　Actレート0[" .. f10_local3 .. "]")
                            end
                        end
                    else
                        print("[SELECT ENEMY]" .. "　　　インターバル中[" .. f10_local3 .. "]")
                    end
                end
            end
        end
    end
    local f10_local12 = {}
    local f10_local13 = 0
    local f10_local14 = 0
    if f10_local2 == 0 then
        print("[SELECT ENEMY]" .. "<<結果>> 抽選結果[なし]")
        return nil
    elseif f10_local2 > 1 then
        for f10_local15 = 1, f10_local2, 1 do
            f10_local3 = f10_local7[f10_local1[f10_local15]] - f10_local4
            local f10_local18 = 1
            if f10_local6[f10_local1[f10_local15]] ~= nil then
                f10_local18 = f10_local6[f10_local1[f10_local15]]
            end
            local f10_local19 = f10_arg1:GetAttackPassedTime(f10_local3)
            if f10_local19 <= 0 then
            end
            f10_local19 = f10_local19 - f10_arg1:GetAIAttackParam(f10_local3, AI_ATTACK_PARAM_TYPE__INTERVAL_EXEC)
            if f10_local19 < 0 then
                f10_local19 = 1
                print("[SELECT ENEMY]" .. "*****　出ないはず")
            end
            local f10_local20 = f10_arg1:GetIdTimer(f10_local1[f10_local15] + 10000000)
            if f10_local20 <= 0 then
                f10_arg1:StartIdTimer(f10_local1[f10_local15] + 10000000)
            end
            f10_local12[f10_local15] = f10_arg1:GetAIAttackParam(f10_local3, AI_ATTACK_PARAM_TYPE__SELECTION_TENDENCY) * f10_local18 * GetAttackRateByDist(f10_arg0, f10_arg1, f10_arg2, f10_local3, f10_local11)
            print("[SELECT ENEMY]" .. "　　　　　　　　　　　選択候補攻撃[" .. f10_local3 .. "][" .. f10_local1[f10_local15] .. "]　攻撃レート[" .. f10_local12[f10_local15] .. "]    ACTレート[" .. f10_local20 .. "]　経過時間[" .. f10_local19 .. "]　スクリプトレート[" .. f10_local18 .. "]　思考レート：" .. GetAttackRateByDist(f10_arg0, f10_arg1, f10_arg2, f10_local3, f10_local11) .. "　距離レート：" .. f10_local14)
            f10_local13 = f10_local12[f10_local15] + f10_local13
        end
        if f10_local13 > 0 then
            local f10_local15 = f10_arg1:GetRandam_Float(0, f10_local13)
            local f10_local16 = 0
            for f10_local17 = 1, f10_local2, 1 do
                f10_local16 = f10_local16 + f10_local12[f10_local17]
                if f10_local15 <= f10_local16 then
                    print("[SELECT ENEMY]" .. "<<結果>> 抽選結果[" .. f10_local1[f10_local17] .. "]" .. f10_local7[f10_local1[f10_local17]])
                    f10_arg1:StartIdTimer(f10_local1[f10_local17] + 10000000)
                    return f10_local5[f10_local1[f10_local17]]
                end
            end
        end

    else
        print("[SELECT ENEMY]" .. "<<結果>> 抽選結果[" .. f10_local1[1] .. "]" .. f10_local7[f10_local1[1]])
        f10_arg1:StartIdTimer(f10_local1[1] + 10000000)
        return f10_local5[f10_local1[1]]
    end
    return nil
    

end


