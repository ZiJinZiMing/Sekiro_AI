--[[============================================================================
模块名称: common_func_FDP.lua
模块版本: 1.0.0
作者: From Software
最后修改: 2025-10-14
编码格式: Shift-JIS

模块概述:
    FDP（Flexible Distance & Positioning）灵活距离与定位AI通用函数库
    提供敌人AI中常用的距离判定、空间检测、反应行为等核心功能。

功能描述:
    - 灵活接近行为（根据距离和空间自动选择行走/奔跑）
    - 空间安全检测（前方是否有障碍、悬崖等）
    - 范围和方向判定（角度、距离组合判定）
    - 攻击冷却时间管理
    - 反击和背刺应对系统
    - 伪全局变量初始化
    - 防御Goal子函数集

技术细节:
    - 支持特定区域强制行走模式（M11地图的行走限制区域）
    - 使用字符串索引变量存储AI状态参数
    - 实现了完整的背刺反应决策树
    - 包含防御成功/失败的判定逻辑

主要函数:
    1. Approach_Act_Flex - 灵活接近目标
    2. SpaceCheck - 空间安全检测
    3. InsideRange/InsideDir - 范围和方向判定
    4. SetCoolTime - 攻击冷却管理
    5. Counter_Act - 反击行为
    6. ReactBackstab_Act - 背刺反应
    7. Init_Pseudo_Global - 初始化伪全局变量
    8. GuardGoalSubFunc_* - 防御Goal子函数集

使用示例:
    -- 灵活接近敌人，自动选择行走/奔跑
    Approach_Act_Flex(ai, goal, 3, 2, 5, 50, 30, 3, 8, 0)

    -- 检查前方3米是否安全
    if SpaceCheck(ai, goal, 0, 3) then
        -- 执行攻击
    end

版本历史:
    v1.0.0 - 初始版本

依赖模块:
    - ai_define.lua (AI常量定义)

特殊说明:
    - 文件编码必须为Shift-JIS
    - 许多参数使用字符串索引号存储，便于脚本间共享状态
    - 防御Goal函数使用Number(0)和Number(1)作为状态标志
============================================================================]]--

--[[----------------------------------------------------------------------------
函数名: Approach_Act_Flex
功能: 灵活接近目标，根据距离和概率自动选择步行或奔跑模式

参数说明:
    f1_arg0 - AI实例对象
    f1_arg1 - Goal管理器
    f1_arg2 - 目标接近距离（米）
    f1_arg3 - 步行判定最小距离（米）
    f1_arg4 - 步行判定最大距离（米）
    f1_arg5 - 在步行判定范围内选择奔跑的概率（1-100）
    f1_arg6 - 招架执行概率（1-100），0表示不招架
    f1_arg7 - 步行模式的Goal生命周期（秒），默认3秒
    f1_arg8 - 奔跑模式的Goal生命周期（秒），默认8秒
    f1_arg9 - 是否强制接近（>0时即使在目标距离内也会移动）

处理逻辑:
    1. 判定当前距离是否应该使用行走模式
    2. 特殊区域（M11地图）强制使用行走
    3. 根据概率决定是否执行等待动画
    4. 添加接近目标的SubGoal

技术细节:
    - M11地图的COMMON_REGION_FORCE_WALK区域会强制行走
    - 行走模式会添加AddDistWalk偏移量
    - 奔跑模式会添加AddDistRun偏移量
----------------------------------------------------------------------------]]--
function Approach_Act_Flex(f1_arg0, f1_arg1, f1_arg2, f1_arg3, f1_arg4, f1_arg5, f1_arg6, f1_arg7, f1_arg8, f1_arg9)
    -- 设置默认生命周期参数
    if f1_arg7 == nil then
        f1_arg7 = 3  -- 行走模式默认3秒
    end
    if f1_arg8 == nil then
        f1_arg8 = 8  -- 奔跑模式默认8秒
    end
    if f1_arg9 == nil then
        f1_arg9 = 0  -- 默认不强制接近
    end

    -- 获取当前距离和随机数
    local f1_local0 = f1_arg0:GetDist(TARGET_ENE_0)  -- 当前距离
    local f1_local1 = f1_arg0:GetRandam_Int(1, 100)  -- 行走判定用随机数
    local f1_local2 = true  -- 是否使用行走模式

    -- 判定是否应该行走
    if f1_arg4 <= f1_local0 then
        -- 距离超过最大行走距离，使用奔跑
        f1_local2 = false
    elseif f1_arg3 <= f1_local0 and f1_local1 <= f1_arg5 then
        -- 在行走判定范围内，根据概率决定
        f1_local2 = false
    end

    -- 特定区域强制行走（M11地图的行走限制区域）
    if f1_arg0:IsInsideTargetRegion(TARGET_SELF, COMMON_REGION_FORCE_WALK_M11_0) or f1_arg0:IsInsideTargetRegion(TARGET_SELF, COMMON_REGION_FORCE_WALK_M11_1) then
        f1_local2 = true
    end

    -- 决定等待动画EzStateID
    local f1_local3 = -1  -- -1表示不使用等待动画
    local f1_local4 = f1_arg0:GetRandam_Int(1, 100)
    if f1_local4 <= f1_arg6 then
        f1_local3 = 9910  -- 招架动画ID
    end

    -- 根据移动模式选择Goal生命周期
    if f1_local2 == true then
        life = f1_arg7  -- 行走生命周期
    else
        life = f1_arg8  -- 奔跑生命周期
    end

    -- 判断是否需要添加接近Goal
    if f1_arg2 <= f1_local0 or f1_arg9 > 0 then
        -- 根据移动模式调整目标距离
        if f1_local2 == true then
            -- 行走模式：添加行走距离偏移
            f1_arg2 = f1_arg2 + f1_arg0:GetStringIndexedNumber("AddDistWalk")
        else
            -- 奔跑模式：添加奔跑距离偏移
            f1_arg2 = f1_arg2 + f1_arg0:GetStringIndexedNumber("AddDistRun")
        end
        -- 添加接近目标Goal
        f1_arg1:AddSubGoal(GOAL_COMMON_ApproachTarget, life, TARGET_ENE_0, f1_arg2, TARGET_SELF, f1_local2, f1_local3)
    end

end

--[[----------------------------------------------------------------------------
函数名: SpaceCheck
功能: 检查指定方向和距离是否有足够的安全空间（无障碍物、悬崖等）

参数说明:
    f2_arg0 - AI实例对象
    f2_arg1 - Goal管理器（未使用）
    f2_arg2 - 检测角度（相对于自身朝向，度）
    f2_arg3 - 检测距离（米）

返回值:
    true - 空间安全，可以移动
    false - 空间不安全（有障碍或悬崖）

处理逻辑:
    1. 获取自身碰撞半径
    2. 在指定角度和距离检测网格碰撞
    3. 如果实际可移动距离 >= 目标距离的95%，则认为安全

技术细节:
    - 使用GetExistMeshOnLineDistSpecifyAngleEx进行射线检测
    - 考虑自身碰撞半径，避免卡墙
    - 95%的容差允许轻微的地形起伏
----------------------------------------------------------------------------]]--
function SpaceCheck(f2_arg0, f2_arg1, f2_arg2, f2_arg3)
    -- 获取自身碰撞半径
    local f2_local0 = f2_arg0:GetMapHitRadius(TARGET_SELF)

    -- 在指定角度检测网格距离
    local f2_local1 = f2_arg0:GetExistMeshOnLineDistSpecifyAngleEx(TARGET_SELF, f2_arg2, f2_arg3 + f2_local0, AI_SPA_DIR_TYPE_TargetF, f2_local0, 0)

    -- 判断是否有足够空间（95%容差）
    if f2_arg3 * 0.95 <= f2_local1 then
        return true  -- 空间安全
    else
        return false  -- 空间不足
    end

end

--[[----------------------------------------------------------------------------
函数名: InsideRange
功能: 判断目标是否在指定的角度和距离范围内

参数说明:
    f3_arg0 - AI实例对象
    f3_arg1 - Goal管理器（未使用）
    f3_arg2 - 中心角度（相对于自身朝向，度）
    f3_arg3 - 角度范围宽度（度）
    f3_arg4 - 最小距离（米）
    f3_arg5 - 最大距离（米）

返回值:
    true - 目标在范围内
    false - 目标不在范围内

说明:
    这是YSD_InsideRangeEx的包装函数，简化调用接口
----------------------------------------------------------------------------]]--
function InsideRange(f3_arg0, f3_arg1, f3_arg2, f3_arg3, f3_arg4, f3_arg5)
    return YSD_InsideRangeEx(f3_arg0, f3_arg1, f3_arg2, f3_arg3, f3_arg4, f3_arg5)

end

--[[----------------------------------------------------------------------------
函数名: InsideDir
功能: 判断目标是否在指定的角度范围内（忽略距离限制）

参数说明:
    f4_arg0 - AI实例对象
    f4_arg1 - Goal管理器（未使用）
    f4_arg2 - 中心角度（相对于自身朝向，度）
    f4_arg3 - 角度范围宽度（度）

返回值:
    true - 目标在角度范围内
    false - 目标不在角度范围内

说明:
    使用-999到999的距离范围，相当于忽略距离判定
----------------------------------------------------------------------------]]--
function InsideDir(f4_arg0, f4_arg1, f4_arg2, f4_arg3)
    return YSD_InsideRangeEx(f4_arg0, f4_arg1, f4_arg2, f4_arg3, -999, 999)

end

--[[----------------------------------------------------------------------------
函数名: YSD_InsideRangeEx
功能: 综合判定目标是否在指定的角度和距离范围内（核心实现）

参数说明:
    f5_arg0 - AI实例对象
    f5_arg1 - Goal管理器（未使用）
    f5_arg2 - 中心角度（相对于自身朝向，度）
    f5_arg3 - 角度范围宽度（度）
    f5_arg4 - 最小距离（米）
    f5_arg5 - 最大距离（米）

返回值:
    true - 目标同时满足距离和角度条件
    false - 目标不满足条件

处理逻辑:
    1. 先判定距离是否在范围内
    2. 再判定角度是否在范围内
    3. 处理角度跨越360度边界的特殊情况

技术细节:
    - 角度范围以中心角度为基准，向两侧扩展f5_arg3/2度
    - 支持负角度和角度环绕（通过360度修正）
    - 距离和角度必须同时满足才返回true
----------------------------------------------------------------------------]]--
function YSD_InsideRangeEx(f5_arg0, f5_arg1, f5_arg2, f5_arg3, f5_arg4, f5_arg5)
    -- 获取当前距离
    local f5_local0 = f5_arg0:GetDist(TARGET_ENE_0)

    -- 首先判定距离
    if f5_arg4 <= f5_local0 and f5_local0 <= f5_arg5 then
        -- 距离满足，继续判定角度
        local f5_local1 = f5_arg0:GetToTargetAngle(TARGET_ENE_0)  -- 获取到目标的角度

        -- 判断角度方向（用于处理角度环绕）
        local f5_local2 = 0
        if f5_arg2 < 0 then
            f5_local2 = -1  -- 负角度
        else
            f5_local2 = 1   -- 正角度
        end

        -- 判定角度是否在范围内（考虑360度环绕）
        -- 范围计算：[中心角度 - 宽度/2, 中心角度 + 宽度/2]
        if f5_arg2 + f5_arg3 / -2 <= f5_local1 and f5_local1 <= f5_arg2 + f5_arg3 / 2 or
           f5_arg2 + f5_arg3 / -2 <= f5_local1 + 360 * f5_local2 and f5_local1 + 360 * f5_local2 <= f5_arg2 + f5_arg3 / 2 then
            return true  -- 角度和距离都满足
        else
            return false  -- 角度不满足
        end
    else
        return false  -- 距离不满足
    end

end

--[[----------------------------------------------------------------------------
函数名: SetCoolTime
功能: 根据攻击间隔时间设置攻击冷却，防止连续使用同一攻击

参数说明:
    f6_arg0 - AI实例对象
    f6_arg1 - Goal管理器（未使用）
    f6_arg2 - 攻击ID
    f6_arg3 - 最小攻击间隔时间（秒）
    f6_arg4 - 原始攻击权重值
    f6_arg5 - 冷却期间的权重值（通常为0）

返回值:
    权重值 - 如果在冷却期间返回f6_arg5，否则返回f6_arg4

处理逻辑:
    1. 如果原始权重为0，直接返回0（不可用）
    2. 如果距离上次使用该攻击的时间小于最小间隔，返回冷却权重
    3. 否则返回原始权重

使用示例:
    -- 设置3000攻击最少3秒间隔，冷却期间权重为0
    weight = SetCoolTime(ai, goal, 3000, 3, 50, 0)
----------------------------------------------------------------------------]]--
function SetCoolTime(f6_arg0, f6_arg1, f6_arg2, f6_arg3, f6_arg4, f6_arg5)
    -- 如果攻击本身不可用，直接返回0
    if f6_arg4 <= 0 then
        return 0
    -- 检查是否在冷却期间
    elseif f6_arg0:GetAttackPassedTime(f6_arg2) <= f6_arg3 then
        return f6_arg5  -- 返回冷却权重
    end
    -- 冷却结束，返回原始权重
    return f6_arg4

end

--[[----------------------------------------------------------------------------
函数名: SpaceCheckBeforeAct
功能: 行动前检查空间是否安全，不安全则返回0权重

参数说明:
    f7_arg0 - AI实例对象
    f7_arg1 - Goal管理器
    f7_arg2 - 检测角度（度）
    f7_arg3 - 检测距离（米）
    f7_arg4 - 原始权重值

返回值:
    权重值 - 空间安全返回原始权重，不安全返回0

说明:
    常用于攻击或移动前的安全检查，避免AI执行危险动作
    如果原始权重已经为0，直接返回0不进行检测
----------------------------------------------------------------------------]]--
function SpaceCheckBeforeAct(f7_arg0, f7_arg1, f7_arg2, f7_arg3, f7_arg4)
    -- 如果行动本身不可用，直接返回0
    if f7_arg4 <= 0 then
        return 0
    -- 检查空间是否安全
    elseif SpaceCheck(f7_arg0, f7_arg1, f7_arg2, f7_arg3) then
        return f7_arg4  -- 空间安全，返回原始权重
    else
        return 0  -- 空间不安全，禁用该行动
    end

end

--[[----------------------------------------------------------------------------
函数名: Counter_Act
功能: 受到攻击时的反击行为系统，根据累计伤害触发忍耐反击

参数说明:
    f8_arg0 - AI实例对象
    f8_arg1 - Goal管理器
    f8_arg2 - 单次受击增加的反击值，默认4
    f8_arg3 - 反击使用的攻击ID

返回值:
    true - 触发了反击行为
    false - 未触发反击

处理逻辑:
    1. 检测是否受到伤害中断
    2. 累积反击值（存储在Number(15)中）
    3. 反击值每次受击翻倍，最大100
    4. 根据概率触发忍耐反击
    5. 反击后重置计数器

技术细节:
    - 使用Timer(15)记录累积时间（5秒）
    - 使用Number(15)存储反击累积值
    - 使用Timer(14)设置反击冷却（3秒）
    - 反击值上限为100
----------------------------------------------------------------------------]]--
function Counter_Act(f8_arg0, f8_arg1, f8_arg2, f8_arg3)
    local f8_local0 = 0.5  -- 忍耐持续时间

    -- 设置默认反击值增量
    if f8_arg2 == nil then
        f8_arg2 = 4
    end

    local f8_local1 = f8_arg0:GetRandam_Int(1, 100)  -- 触发判定随机数
    local f8_local2 = f8_arg0:GetNumber(15)  -- 当前反击累积值

    -- 检测受击中断
    if f8_arg0:IsInterupt(INTERUPT_Damaged) then
        -- 重置累积计时器
        f8_arg0:SetTimer(15, 5)

        -- 初次受击，设置基础反击值
        if f8_local2 == 0 then
            f8_local2 = f8_arg2
        end

        -- 累积反击值翻倍
        f8_arg0:SetNumber(15, f8_local2 * 2)
    end

    -- 反击值上限为100
    if f8_local2 >= 100 then
        f8_arg0:SetNumber(15, 100)
    end

    -- 判定是否触发反击
    if f8_arg0:IsInterupt(INTERUPT_Damaged) and f8_local1 <= f8_arg0:GetNumber(15) and f8_arg0:GetTimer(14) <= 0 then
        -- 设置反击冷却时间
        f8_arg0:SetTimer(14, 3)
        -- 重置反击累积值
        f8_arg0:SetNumber(15, 0)
        -- 清除当前所有SubGoal
        f8_arg1:ClearSubGoal()
        -- 执行忍耐反击
        f8_arg1:AddSubGoal(GOAL_COMMON_EndureAttack, f8_local0, f8_arg3, TARGET_ENE_0, DIST_None, 0, 180, 0, 0)
        return true
    end

    return false

end

--[[----------------------------------------------------------------------------
函数名: ReactBackstab_Act
功能: 背刺风险应对系统，根据配置选择不同的应对方式

参数说明:
    f9_arg0 - AI实例对象
    f9_arg1 - Goal管理器
    f9_arg2 - 应对模式：1=前滚翻, 2=左右滚翻, 3=三向滚翻
    f9_arg3 - 背刺反击攻击ID（用于高级AI）
    f9_arg4 - 触发背刺反击的概率（1-100），默认0

返回值:
    false - 执行了应对动作

处理逻辑:
    1. 检测背刺风险中断
    2. 根据概率决定是否执行背刺反击
    3. 否则根据模式执行滚翻规避

技术细节:
    - 6000: 前滚翻动画ID
    - 6002: 左滚翻动画ID
    - 6003: 右滚翻动画ID
    - 持续时间固定为3秒
----------------------------------------------------------------------------]]--
function ReactBackstab_Act(f9_arg0, f9_arg1, f9_arg2, f9_arg3, f9_arg4)
    local f9_local0 = f9_arg0:GetRandam_Int(1, 100)  -- 反击判定
    local f9_local1 = f9_arg0:GetRandam_Int(1, 100)  -- 方向选择
    local f9_local2 = 3  -- 应对动作持续时间

    -- 滚翻动画ID
    local f9_local3 = 6000  -- 前滚翻
    local f9_local4 = 6002  -- 左滚翻
    local f9_local5 = 6003  -- 右滚翻

    -- 默认不使用背刺反击
    if f9_arg3 == nil then
        f9_arg4 = 0
    end

    -- 检测背刺风险
    if f9_arg0:IsInterupt(INTERUPT_BackstabRisk) then
        -- 判定是否执行背刺反击
        if f9_local0 <= f9_arg4 then
            f9_arg1:ClearSubGoal()
            f9_arg1:AddSubGoal(GOAL_COMMON_StabCounterAttack, f9_local2, f9_arg3, TARGET_ENE_0, DIST_None, 0, 180, 0, 0)
        -- 模式1: 前滚翻
        elseif f9_arg2 == 1 then
            f9_arg1:ClearSubGoal()
            f9_arg1:AddSubGoal(GOAL_COMMON_SpinStep, f9_local2, f9_local3, TARGET_SELF, 0, AI_DIR_TYPE_F, 0)
        -- 模式2: 左右滚翻（随机）
        elseif f9_arg2 == 2 then
            f9_arg1:ClearSubGoal()
            if f9_local1 <= 50 then
                f9_arg1:AddSubGoal(GOAL_COMMON_SpinStep, f9_local2, f9_local4, TARGET_SELF, 0, AI_DIR_TYPE_L, 0)
            else
                f9_arg1:AddSubGoal(GOAL_COMMON_SpinStep, f9_local2, f9_local5, TARGET_SELF, 0, AI_DIR_TYPE_R, 0)
            end
        -- 模式3: 前/左/右三向滚翻（随机）
        elseif f9_arg2 == 3 then
            f9_arg1:ClearSubGoal()
            if f9_local1 <= 33 then
                f9_arg1:AddSubGoal(GOAL_COMMON_SpinStep, f9_local2, f9_local3, TARGET_SELF, 0, AI_DIR_TYPE_F, 0)
            elseif f9_local1 <= 66 then
                f9_arg1:AddSubGoal(GOAL_COMMON_SpinStep, f9_local2, f9_local4, TARGET_SELF, 0, AI_DIR_TYPE_L, 0)
            else
                f9_arg1:AddSubGoal(GOAL_COMMON_SpinStep, f9_local2, f9_local5, TARGET_SELF, 0, AI_DIR_TYPE_R, 0)
            end
        end
        return false
    end

end

--[[----------------------------------------------------------------------------
函数名: Init_Pseudo_Global
功能: 初始化AI的伪全局变量（使用字符串索引号存储的共享参数）

参数说明:
    f10_arg0 - AI实例对象
    f10_arg1 - Goal管理器

说明:
    设置AI的默认步伐距离和接近距离修正值
    这些值会影响后续的移动和攻击行为

初始化的变量:
    - Dist_SideStep: 横向闪避距离（默认5米）
    - Dist_BackStep: 后退闪避距离（默认5米）
    - AddDistWalk: 行走接近距离修正（默认0）
    - AddDistRun: 奔跑接近距离修正（默认0）
----------------------------------------------------------------------------]]--
function Init_Pseudo_Global(f10_arg0, f10_arg1)
    f10_arg0:SetStringIndexedNumber("Dist_SideStep", 5)  -- 横向闪避距离
    f10_arg0:SetStringIndexedNumber("Dist_BackStep", 5)  -- 后退闪避距离
    f10_arg0:SetStringIndexedNumber("AddDistWalk", 0)    -- 行走距离修正
    f10_arg0:SetStringIndexedNumber("AddDistRun", 0)     -- 奔跑距离修正

    -- 初始化攻击后行动参数
    Init_AfterAttackAct(f10_arg0, f10_arg1)

end

--[[----------------------------------------------------------------------------
函数名: Init_AfterAttackAct
功能: 初始化攻击后行动（After Attack Act）的所有参数

参数说明:
    f11_arg0 - AI实例对象
    f11_arg1 - Goal管理器

说明:
    设置攻击后AI可以执行的各种行动的默认参数和概率
    这些参数控制AI在完成一次攻击后的行为选择

初始化的参数分类:
    1. 距离和角度条件
    2. 各种行动的触发概率（防御、待机、后退、侧移等）
    3. 行动的持续时间和移动距离

AAA后缀表示After Attack Act
----------------------------------------------------------------------------]]--
function Init_AfterAttackAct(f11_arg0, f11_arg1)
    -- 基础条件参数
    f11_arg0:SetStringIndexedNumber("DistMin_AAA", -999)  -- 最小距离限制（无限制）
    f11_arg0:SetStringIndexedNumber("DistMax_AAA", 999)   -- 最大距离限制（无限制）
    f11_arg0:SetStringIndexedNumber("BaseDir_AAA", AI_DIR_TYPE_F)  -- 基准方向（前方）
    f11_arg0:SetStringIndexedNumber("Angle_AAA", 360)     -- 角度范围（360度）

    -- 各种行动的触发概率（默认全部为0，表示不使用）
    f11_arg0:SetStringIndexedNumber("Odds_Guard_AAA", 0)     -- 防御概率
    f11_arg0:SetStringIndexedNumber("Odds_NoAct_AAA", 0)     -- 无动作概率
    f11_arg0:SetStringIndexedNumber("Odds_BackAndSide_AAA", 0)  -- 后退+侧移概率
    f11_arg0:SetStringIndexedNumber("Odds_Back_AAA", 0)      -- 后退概率
    f11_arg0:SetStringIndexedNumber("Odds_Backstep_AAA", 0)  -- 后跳概率
    f11_arg0:SetStringIndexedNumber("Odds_Sidestep_AAA", 0)  -- 侧跳概率
    f11_arg0:SetStringIndexedNumber("Odds_BitWait_AAA", 0)   -- 短暂等待概率
    f11_arg0:SetStringIndexedNumber("Odds_BsAndSide_AAA", 0) -- 后跳+侧移概率
    f11_arg0:SetStringIndexedNumber("Odds_BsAndSs_AAA", 0)   -- 后跳+侧跳概率

    -- 中断条件（在这些条件下触发攻击后行动）
    f11_arg0:SetStringIndexedNumber("DistMin_Inter_AAA", -999)  -- 中断最小距离
    f11_arg0:SetStringIndexedNumber("DistMax_Inter_AAA", 999)   -- 中断最大距离
    f11_arg0:SetStringIndexedNumber("BaseAng_Inter_AAA", 0)     -- 中断基准角度
    f11_arg0:SetStringIndexedNumber("Ang_Inter_AAA", 360)       -- 中断角度范围

    -- 各种行动的具体参数
    f11_arg0:SetStringIndexedNumber("BackAndSide_BackLife_AAA", 2)  -- 后退生命周期（2秒）
    f11_arg0:SetStringIndexedNumber("BackAndSide_SideLife_AAA", f11_arg0:GetRandam_Float(2.5, 3.5))  -- 侧移生命周期（随机2.5-3.5秒）
    f11_arg0:SetStringIndexedNumber("BackLife_AAA", f11_arg0:GetRandam_Float(2, 3))  -- 单纯后退生命周期（随机2-3秒）
    f11_arg0:SetStringIndexedNumber("BsAndSide_SideLife_AAA", f11_arg0:GetRandam_Float(2.5, 3.5))  -- 后跳+侧移的侧移时间
    f11_arg0:SetStringIndexedNumber("BackAndSide_BackDist_AAA", 1.5)  -- 后退距离（1.5米）
    f11_arg0:SetStringIndexedNumber("BackDist_AAA", f11_arg0:GetRandam_Float(2.5, 3.5))  -- 单纯后退距离（随机2.5-3.5米）
    f11_arg0:SetStringIndexedNumber("BackAndSide_SideDir_AAA", f11_arg0:GetRandam_Int(45, 60))  -- 侧移角度（随机45-60度）
    f11_arg0:SetStringIndexedNumber("BsAndSide_SideDir_AAA", f11_arg0:GetRandam_Int(45, 60))  -- 后跳+侧移的侧移角度

end

--[[----------------------------------------------------------------------------
函数名: Update_Default_NoSubGoal
功能: 默认的Update函数实现，当没有SubGoal时结束

参数说明:
    f12_arg0 - AI实例对象
    f12_arg1 - Goal管理器
    f12_arg2 - Goal实例

返回值:
    GOAL_RESULT_Success - 没有SubGoal时返回成功
    GOAL_RESULT_Continue - 有SubGoal时继续执行

说明:
    这是一个通用的Update函数模板
    适用于只需等待SubGoal完成的Goal
----------------------------------------------------------------------------]]--
function Update_Default_NoSubGoal(f12_arg0, f12_arg1, f12_arg2)
    -- 检查是否还有SubGoal在执行
    if f12_arg2:GetSubGoalNum() <= 0 then
        return GOAL_RESULT_Success  -- 没有SubGoal，Goal完成
    end
    return GOAL_RESULT_Continue  -- 继续执行SubGoal

end

--[[----------------------------------------------------------------------------
函数名: GuardGoalSubFunc_Activate
功能: 防御Goal的激活辅助函数

参数说明:
    f13_arg0 - AI实例对象
    f13_arg1 - Goal管理器
    f13_arg2 - EzAction ID（防御动作ID）

说明:
    如果指定了有效的EzAction ID（>0），则执行该防御动作
----------------------------------------------------------------------------]]--
function GuardGoalSubFunc_Activate(f13_arg0, f13_arg1, f13_arg2)
    if 0 < f13_arg2 then
        f13_arg0:DoEzAction(f13_arg1, f13_arg2)
    end

end

--[[----------------------------------------------------------------------------
函数名: GuardGoalSubFunc_Update
功能: 防御Goal的更新辅助函数

参数说明:
    f14_arg0 - AI实例对象
    f14_arg1 - Goal实例
    f14_arg2 - EzAction ID
    f14_arg3 - 防御成功时的返回值
    f14_arg4 - 是否在生命周期结束时返回Success

返回值:
    GOAL_RESULT_Failed - 受到伤害时失败
    f14_arg3 - 防御成功时返回指定值
    GOAL_RESULT_Success/Failed - 生命周期结束时根据参数返回
    GOAL_RESULT_Continue - 继续防御

处理逻辑:
    使用Number(0)作为伤害标志
    使用Number(1)作为防御成功标志
----------------------------------------------------------------------------]]--
function GuardGoalSubFunc_Update(f14_arg0, f14_arg1, f14_arg2, f14_arg3, f14_arg4)
    -- 如果使用了防御动作
    if 0 < f14_arg2 then
        -- 检查是否受到伤害（Number(0) != 0表示受伤）
        if f14_arg1:GetNumber(0) ~= 0 then
            return GOAL_RESULT_Failed  -- 防御失败
        -- 检查是否防御成功（Number(1) != 0表示成功格挡）
        elseif f14_arg1:GetNumber(1) ~= 0 then
            return f14_arg3  -- 返回指定的成功结果
        end
    end

    -- 检查Goal生命周期是否结束
    if f14_arg1:GetLife() <= 0 then
        if f14_arg4 then
            return GOAL_RESULT_Success  -- 生命周期结束，返回成功
        else
            return GOAL_RESULT_Failed   -- 生命周期结束，返回失败
        end
    end

    return GOAL_RESULT_Continue  -- 继续防御

end

--[[----------------------------------------------------------------------------
函数名: GuardGoalSubFunc_Interrupt
功能: 防御Goal的中断处理辅助函数

参数说明:
    f15_arg0 - AI实例对象
    f15_arg1 - Goal实例
    f15_arg2 - EzAction ID
    f15_arg3 - 防御成功时的期望结果类型

返回值:
    false - 始终返回false（中断在Update中处理）

处理逻辑:
    监听受伤和防御成功事件，设置相应的Number标志
    Update函数会读取这些标志并返回相应结果
----------------------------------------------------------------------------]]--
function GuardGoalSubFunc_Interrupt(f15_arg0, f15_arg1, f15_arg2, f15_arg3)
    -- 如果使用了防御动作
    if 0 < f15_arg2 then
        -- 检测受伤中断
        if f15_arg0:IsInterupt(INTERUPT_Damaged) then
            f15_arg1:SetNumber(0, 1)  -- 设置受伤标志
        -- 检测防御成功中断
        elseif f15_arg0:IsInterupt(INTERUPT_SuccessGuard) and f15_arg3 ~= GOAL_RESULT_Continue then
            f15_arg1:SetNumber(1, 1)  -- 设置防御成功标志
        end
    end

    return false  -- 中断由Update处理

end


