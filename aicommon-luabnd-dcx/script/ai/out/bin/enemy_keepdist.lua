--[[============================================================================
    enemy_keepdist.lua - 敌人保持距离系统 (Enemy Keep Distance System)

    版本信息 (Version Info): v1.0
    作者 (Author): FromSoftware AI Team / Enhanced by Claude Code
    最后修改 (Last Modified): 2025-10-21
    编码格式 (Encoding): Shift-JIS (required for Sekiro compatibility)

    ============================================================================
    模块概述 (Module Overview):
    ============================================================================
    这是Sekiro AI系统中的距离保持系统模块。该模块负责管理敌人与目标之间的
    距离控制，使敌人能够维持在特定的距离范围内进行战斗。它集成了多种运动
    行为包括：接近/远离目标、侧向移动、防御姿态、快速步移和紧急回避等。

    该模块是敌人战术系统的核心组件，负责在不同的战斗距离和压力下选择合适的
    移动策略。它既能维持战术距离，也能根据实时战斗情况进行灵活的位置调整。

    核心功能 (Core Functions):
    ├─ 距离管理：维持敌人与目标的最优战斗距离
    ├─ 灵活移动：根据距离差异选择接近、远离或侧向移动
    ├─ 防御策略：在接近范围内启用防御姿态以降低伤害
    ├─ 步移规避：通过随机步移躲避敌人的攻击
    ├─ 紧急回避：在目标接近时执行快速侧向或后退动作
    └─ 侧向保持：在目标周围进行环绕移动以保持战术优势

    与其他系统的关系 (Relationship with Other Systems):
    ├─ enemy_handy_attack.lua - 便捷攻击系统（攻击行为）
    ├─ enemy_multi_attack.lua - 多段攻击系统（连击序列）
    ├─ enemy_flexible_approach.lua - 灵活接近系统（路径移动）
    ├─ GOAL_COMMON_FlexibleSideWayMove - 通用侧向移动（横向闪避）
    └─ GOAL_EnemyStepBLR - 基础步移系统（多向步移）

    ============================================================================
    参数系统详解 (Parameter System Details):
    ============================================================================

    参数0 (Param0): 対象 (攻击目标)
    ────────────────────────────────────────────────────────────────────
    功能：指定保持距离的目标对象
    数据类型：目标枚举 (Target Enum)
    常用值：TARGET_ENE_0（主要敌人/玩家）
    使用说明：
      - 距离保持系统围绕此目标进行所有移动
      - 距离值基于该目标的位置计算
      - 通常固定为玩家（TARGET_ENE_0）

    参数1 (Param1): 旋回対象 (转向目标)
    ────────────────────────────────────────────────────────────────────
    功能：指定侧向移动时的参考目标
    数据类型：目标枚举 (Target Enum)
    常用值：TARGET_ENE_0 或 1（默认值表示主要敌人）
    使用说明：
      - 在侧向移动中充当参考中心点
      - 影响横向闪避的方向选择
      - 通常与参数0相同

    参数2 (Param2): 強制歩行距離 (强制行走距离)
    ────────────────────────────────────────────────────────────────────
    功能：在灵活接近中触发行走动作的距离阈值
    数据类型：浮点数 (Float)
    单位：游戏内部距离单位
    取值范围：0.5 ~ 15.0（推荐）
    使用说明：
      - 当敌人与目标距离超过此值时，使用行走速度接近
      - 值较大：优先使用行走，接近速度较慢
      - 值较小：更快切换到跑动，接近速度较快
    典型配置：
      - 谨慎型：5.0 ~ 8.0（保持安全距离）
      - 平衡型：3.0 ~ 5.0（标准接近）
      - 激进型：1.0 ~ 3.0（快速接近）

    参数3 (Param3): 強制走行距離 (强制跑行距离)
    ────────────────────────────────────────────────────────────────────
    功能：在灵活接近中触发跑步动作的距离阈值
    数据类型：浮点数 (Float)
    单位：游戏内部距离单位
    取值范围：0.5 ~ 15.0（推荐）
    使用说明：
      - 当敌人与目标距离超过此值时，使用跑步速度接近
      - 应设置为 >= 参数2，确保距离太远时全力冲刺
      - 决定了接近的最大速度
    推荐配置：
      - 参数3应大于参数2，形成两层接近速度

    参数4 (Param4): 走行率 (跑步率/移动速率)
    ────────────────────────────────────────────────────────────────────
    功能：控制敌人在侧向移动时的跑步比率
    数据类型：浮点数 (Float)
    单位：百分比 (0.0 ~ 100.0)
    取值范围：0 ~ 100
    使用说明：
      - 控制侧向移动中使用跑步而非行走的倾向
      - 值较高：更多使用跑步，移动速度快但更易疲劳
      - 值较低：更多使用行走，移动速度慢但更持久
    典型配置：
      - 敏捷敌人：70-90%（快速移动）
      - 标准敌人：40-60%（平衡移动）
      - 笨重敌人：10-30%（缓慢移动）

    参数5 (Param5): 防御率 (防御概率)
    ────────────────────────────────────────────────────────────────────
    功能：控制敌人在靠近目标时采取防御姿态的概率
    数据类型：浮点数 (Float)
    单位：百分比 (0.0 ~ 100.0)
    取值范围：0 ~ 100
    使用说明：
      - 决定敌人是否进入防御状态以抵挡伤害
      - 值较高：更容易防御，抗伤害能力强
      - 值较低：很少防御，更容易受伤
    战术配置：
      - 防守型敌人：60-80%（主动防守）
      - 平衡型敌人：30-50%（有时防守）
      - 进攻型敌人：0-20%（罕见防守）

    参数6 (Param6): 後方ステップ確率 (后方步移概率)
    ────────────────────────────────────────────────────────────────────
    功能：控制敌人执行后退步移的概率
    数据类型：浮点数 (Float)
    单位：百分比 (0.0 ~ 100.0)
    取值范围：0 ~ 100
    使用说明：
      - 当距离过近时触发后退步移规避
      - 高概率时：敌人频繁后退，战术保守
      - 低概率时：敌人很少后退，战术激进
    推荐配置：
      - 谨慎型：40-60%
      - 平衡型：20-40%
      - 激进型：0-20%

    参数7 (Param7): 前方ステップ確率 (前方步移概率)
    ────────────────────────────────────────────────────────────────────
    功能：控制敌人执行前方步移的概率
    数据类型：浮点数 (Float)
    单位：百分比 (0.0 ~ 100.0)
    取值范围：0 ~ 100
    使用说明：
      - 在侧向移动时执行前方步移，加速接近
      - 高概率时：敌人频繁上前，更具威胁
      - 低概率时：敌人缓慢接近，给玩家反击时间
    推荐配置：
      - 谨慎型：0-20%
      - 平衡型：20-40%
      - 激进型：40-60%

    参数8 (Param8): ステップ実行確認間隔 (步移执行确认间隔)
    ────────────────────────────────────────────────────────────────────
    功能：控制检查是否执行步移规避的时间间隔
    数据类型：浮点数 (Float)
    单位：秒 (Seconds)
    取值范围：0.5 ~ 5.0（推荐）
    使用说明：
      - 定义Update函数中检查步移条件的频率
      - 值较小：频繁检查，反应迅速但计算开销大
      - 值较大：偶尔检查，反应较慢但性能优化
    典型配置：
      - 快速反应：0.5 ~ 1.0秒
      - 标准反应：1.0 ~ 2.0秒
      - 缓慢反应：2.0 ~ 3.0秒

    参数9 (Param9): 緊急回避距離 (紧急回避距离)
    ────────────────────────────────────────────────────────────────────
    功能：触发紧急回避行为的距离阈值
    数据类型：浮点数 (Float)
    单位：游戏内部距离单位
    取值范围：0.5 ~ 5.0（推荐）
    使用说明：
      - 当目标进入此距离内时，触发快速侧向步移或后退
      - 值较小：紧急回避的触发距离近，风险更大
      - 值较大：紧急回避的触发距离远，反应更提前
    战术配置：
      - 谨慎型：3.0 ~ 5.0（距离远时就开始回避）
      - 平衡型：1.5 ~ 3.0（适中的回避距离）
      - 激进型：0.5 ~ 1.5（危险时才回避）

    参数10 (Param10): 緊急回避確率 (紧急回避概率)
    ────────────────────────────────────────────────────────────────────
    功能：控制触发紧急回避的概率
    数据类型：浮点数 (Float)
    单位：百分比 (0.0 ~ 100.0)
    取值范围：0 ~ 100
    使用说明：
      - 即使距离条件满足，也不必然触发紧急回避
      - 值较高：距离近时几乎一定会回避
      - 值较低：距离近时有可能继续进攻而不回避
    推荐配置：
      - 保守型：60-80%（容易回避）
      - 标准型：40-60%（有时回避）
      - 激进型：20-40%（很少回避）

    参数11 (Param11): 緊急回避確認間隔 (紧急回避确认间隔)
    ────────────────────────────────────────────────────────────────────
    功能：控制检查是否执行紧急回避的时间间隔
    数据类型：浮点数 (Float)
    单位：秒 (Seconds)
    取值范围：0.5 ~ 5.0（推荐）
    使用说明：
      - 定义检查紧急回避条件的频率
      - 值较小：频繁检查，反应迅速
      - 值较大：偶尔检查，反应较慢
    注意：参数8和11的含义相同，都是确认间隔

    ============================================================================
]]--

-- 注册保持距离行为的调试参数 (Register debug parameters for keep distance behavior)
RegisterTableGoal(GOAL_EnemyKeepDist, "GOAL_EnemyKeepDist")
-- 标记此目标无子目标要求 (Mark this goal as having no sub-goal requirement)
REGISTER_GOAL_NO_SUB_GOAL(GOAL_EnemyKeepDist, true)
-- 注册攻击目标调试参数 (Register attack target debug parameter)
REGISTER_DBG_GOAL_PARAM(GOAL_EnemyKeepDist, 0, "対象", 0)
-- 注册旋回/转向目标调试参数 (Register turning target debug parameter)
REGISTER_DBG_GOAL_PARAM(GOAL_EnemyKeepDist, 1, "旋回対象", 1)
-- 注册强制行走距离调试参数 (Register forced walking distance debug parameter)
REGISTER_DBG_GOAL_PARAM(GOAL_EnemyKeepDist, 2, "強制歩行距離", 2)
-- 注册强制跑步距离调试参数 (Register forced running distance debug parameter)
REGISTER_DBG_GOAL_PARAM(GOAL_EnemyKeepDist, 3, "強制走行距離", 3)
-- 注册跑步率调试参数 (Register running rate debug parameter)
REGISTER_DBG_GOAL_PARAM(GOAL_EnemyKeepDist, 4, "走行率", 4)
-- 注册防御率调试参数 (Register guard rate debug parameter)
REGISTER_DBG_GOAL_PARAM(GOAL_EnemyKeepDist, 5, "防御率", 5)
-- 注册后方步移概率调试参数 (Register back step probability debug parameter)
REGISTER_DBG_GOAL_PARAM(GOAL_EnemyKeepDist, 6, "後方ステップ確率", 6)
-- 注册前方步移概率调试参数 (Register front step probability debug parameter)
REGISTER_DBG_GOAL_PARAM(GOAL_EnemyKeepDist, 7, "前方ステップ確率", 7)
-- 注册步移执行确认间隔调试参数 (Register step execution confirmation interval debug parameter)
REGISTER_DBG_GOAL_PARAM(GOAL_EnemyKeepDist, 8, "ステップ実行確認間隔", 8)
-- 注册紧急回避距离调试参数 (Register emergency evasion distance debug parameter)
REGISTER_DBG_GOAL_PARAM(GOAL_EnemyKeepDist, 9, "緊急回避距離", 8)
-- 注册紧急回避概率调试参数 (Register emergency evasion probability debug parameter)
REGISTER_DBG_GOAL_PARAM(GOAL_EnemyKeepDist, 10, "緊急回避確率", 8)
-- 注册紧急回避确认间隔调试参数 (Register emergency evasion confirmation interval debug parameter)
REGISTER_DBG_GOAL_PARAM(GOAL_EnemyKeepDist, 11, "緊急回避確認間隔", 8)

--[[============================================================================
    保持距离激活函数 (Keep Distance Activation Function)
    ============================================================================

    功能说明 (Function Description):
    ────────────────────────────────────────────────────────────────────
    这是保持距离系统的核心入口函数，负责初始化距离保持行为并启动各类
    移动子目标。该函数首先检查敌人是否具有特定的AI参数(7006)支持，
    然后根据当前距离条件选择激活"灵活接近"或直接使用"侧向移动"等
    子目标。在整个保持距离过程中协调多个运动行为的协同工作。

    参数说明 (Parameters):
    ────────────────────────────────────────────────────────────────────
    f1_arg0: AI角色对象 (AI character object)
             - 执行保持距离的AI实体

    f1_arg1: 目标对象/行为对象 (Goal object)
             - 当前GOAL_EnemyKeepDist行为的实例

    f1_arg2: 额外参数 (Extra parameter)
             - 当前未使用 (Currently unused)

    返回值 (Return Value):
    ────────────────────────────────────────────────────────────────────
    无返回值 (No return value)
]]--
Goal.Activate = function (f1_arg0, f1_arg1, f1_arg2)
    -- === 第一步：AI参数支持检查 (AI Parameter Support Check) ===
    -- 验证敌人是否具有攻击参数7006（距离保持相关参数）
    -- 如果不支持，则退出函数，不激活保持距离行为
    if not f1_arg1:IsAIAttackParam(7006) then
        -- 敌人不支持距离保持参数，直接返回
        -- (Enemy doesn't support keep distance parameters, return directly)
        return
    end

    -- === 第二步：参数提取阶段 (Parameter Extraction Phase) ===
    -- 从行为参数中提取所有配置参数

    -- 提取攻击目标 (Extract attack target)
    -- 距离保持系统围绕此目标进行所有距离计算和移动
    local f1_local0 = f1_arg2:GetParam(0)

    -- 提取转向目标 (Extract turning target)
    -- 用于侧向移动的参考目标
    local f1_local1 = f1_arg2:GetParam(1)

    -- 提取强制行走距离 (Extract forced walking distance)
    -- 当距离超过此值时，使用行走速度接近
    local f1_local2 = f1_arg2:GetParam(2)

    -- 提取强制跑步距离 (Extract forced running distance)
    -- 当距离超过此值时，使用跑步速度接近
    local f1_local3 = f1_arg2:GetParam(3)

    -- 提取跑步率 (Extract running rate)
    -- 控制侧向移动中的跑步倾向
    local f1_local4 = f1_arg2:GetParam(4)

    -- 提取防御率 (Extract guard rate)
    -- 控制进入防御状态的概率
    local f1_local5 = f1_arg2:GetParam(5)

    -- 提取后方步移概率 (Extract back step probability)
    local f1_local6 = f1_arg2:GetParam(6)

    -- 提取前方步移概率 (Extract front step probability)
    local f1_local7 = f1_arg2:GetParam(7)

    -- 提取步移执行确认间隔 (Extract step execution confirmation interval)
    local f1_local8 = f1_arg2:GetParam(8)

    -- === 第三步：AI攻击参数获取 (AI Attack Parameters Extraction) ===
    -- 获取攻击参数7006中关于距离的特定信息

    -- 获取最小到达距离 (Get minimum arrive distance)
    -- 这是敌人与目标之间的最小推荐距离
    local f1_local9 = f1_arg1:GetAIAttackParam(7006, AI_ATTACK_PARAM_TYPE__MIN_ARRIVE_DISTANCE)

    -- 获取最大到达距离 (Get maximum arrive distance)
    -- 这是敌人与目标之间的最大推荐距离
    local f1_local10 = f1_arg1:GetAIAttackParam(7006, AI_ATTACK_PARAM_TYPE__MAX_ARRIVE_DISTANCE)

    -- === 第四步：距离参数有效性检查 (Distance Parameter Validity Check) ===
    -- 确保最小距离为非负值
    if f1_local9 < 0 then
        f1_local9 = 0
        -- 最小距离不能为负，设置为0
        -- (Minimum distance cannot be negative, set to 0)
    end

    -- === 第五步：当前距离计算 (Current Distance Calculation) ===
    -- 获取敌人与目标的当前距离
    local f1_local11 = f1_arg1:GetDist(f1_local0)

    -- === 第六步：防御状态初始化 (Guard State Initialization) ===
    -- 根据防御率概率决定是否进入防御状态

    -- 生成随机数0-100，与防御率比较
    -- (Generate random number 0-100 and compare with guard rate)
    if f1_arg1:GetRandam_Float(0, 100) < f1_local5 then
        -- 概率成功，设置防御状态为9910（进入防御）
        -- (Probability success, set guard state to 9910 - enter guard)
        f1_arg2:SetNumber(1, 9910)
    else
        -- 概率失败，设置防御状态为-1（不防御）
        -- (Probability failure, set guard state to -1 - no guard)
        f1_arg2:SetNumber(1, -1)
    end

    -- === 第七步：定时器初始化 (Timer Initialization) ===
    -- 启动内部计时器以控制步移检查频率
    -- 设定的时间范围：0 ~ 2.5秒（5/2）
    f1_arg1:StartIdTimerSpecifyTime(GOAL_EnemyKeepDist, f1_arg1:GetRandam_Float(0, 5 / 2))

    -- === 第八步：距离判定和灵活接近激活 (Distance Judgment and Flexible Approach Activation) ===
    -- 检查当前距离是否超出理想范围
    -- 条件1：f1_local11 < f1_local9 - 距离太近
    -- 条件2：f1_local10 < f1_local11 - 距离太远
    -- 如果任意一个条件成立，需要执行灵活接近以调整距离
    if f1_local11 < f1_local9 or f1_local10 < f1_local11 then
        -- 距离不在理想范围内，添加灵活接近子目标
        -- (Distance is not in the ideal range, add flexible approach sub-goal)
        --
        -- 参数说明 (Parameter Explanation):
        -- GOAL_EnemyFlexibleApproach - 灵活接近目标
        -- f1_arg2:GetLife() - 行为生命周期
        -- f1_local0 - 接近目标 (Approach target)
        -- f1_local1 - 旋转目标 (Rotation target)
        -- (f1_local9 + f1_local10) / 2 - 目标距离（最小和最大距离的平均值）
        -- (f1_local9 + f1_local10) / 2 - 停止距离（同目标距离）
        -- f1_local2 - 强制行走距离 (Forced walking distance)
        -- f1_local3 - 强制跑步距离 (Forced running distance)
        -- f1_local4 - 跑步率 (Running rate)
        -- GuradRate - 防御率（从全局参数或状态获取）
        -- f1_local6 - 后方步移概率 (Back step probability)
        -- f1_local7 - 前方步移概率 (Front step probability)
        -- f1_local8 - 步移执行确认间隔 (Step execution confirmation interval)
        -- 1 - 特殊标志或优先级
        f1_arg2:AddSubGoal(GOAL_EnemyFlexibleApproach, f1_arg2:GetLife(), f1_local0, f1_local1,
                          (f1_local9 + f1_local10) / 2, (f1_local9 + f1_local10) / 2,
                          f1_local2, f1_local3, f1_local4, GuradRate,
                          f1_local6, f1_local7, f1_local8, 1)
    end

    -- === 第九步：侧向移动激活 (Flexible Sideway Move Activation) ===
    -- 添加侧向移动子目标，使敌人能够在保持距离的同时进行横向闪避
    -- 这是保持距离行为的主要运动方式
    --
    -- 参数说明 (Parameter Explanation):
    -- GOAL_COMMON_FlexibleSideWayMove - 通用侧向移动目标
    -- f1_arg2:GetLife() - 行为生命周期
    -- f1_arg1:GetRandam_Float(1, 100) - 随机时间1：侧向移动持续时间1
    -- f1_arg1:GetRandam_Float(1, 100) - 随机时间2：侧向移动持续时间2
    -- f1_local1 - 转向目标 (Turning target)
    -- 3 - 移动类型或速度等级
    -- 90 - 侧向角度（相对于目标的角度）
    -- f1_local5 - 防御率 (Guard rate)
    -- f1_local9 - 最小到达距离 (Minimum arrive distance)
    -- f1_local10 - 最大到达距离 (Maximum arrive distance)
    --
    -- SetFailedEndOption - 设置失败结束选项
    -- AI_GOAL_FAILED_END_OPT__PARENT_NEXT_SUB_GOAL - 失败时执行父目标的下一个子目标
    f1_arg2:AddSubGoal(GOAL_COMMON_FlexibleSideWayMove, f1_arg2:GetLife(),
                      f1_arg1:GetRandam_Float(1, 100), f1_arg1:GetRandam_Float(1, 100),
                      f1_local1, 3, 90, f1_local5, f1_local9, f1_local10):SetFailedEndOption(AI_GOAL_FAILED_END_OPT__PARENT_NEXT_SUB_GOAL)

end

--[[============================================================================
    保持距离状态更新函数 (Keep Distance State Update Function)
    ============================================================================

    功能说明 (Function Description):
    ────────────────────────────────────────────────────────────────────
    这是保持距离系统的执行监控和动态调整函数，每帧被调用以管理距离保持行为
    的实时执行。该函数负责：
    1. 检查子目标执行状态
    2. 监测当前距离与理想范围的关系
    3. 在必要时触发紧急回避行为
    4. 根据距离变化动态调整移动策略

    核心职责：
    - 紧急回避检测：如果目标进入紧急距离范围，执行快速回避
    - 距离调整：如果距离超出理想范围，重新激活灵活接近
    - 连续监控：维持保持距离状态，防止频繁行为切换

    参数说明 (Parameters):
    ────────────────────────────────────────────────────────────────────
    f2_arg0: AI角色对象 (AI character object)
             - 执行保持距离的AI实体

    f2_arg1: 行为对象 (Goal object)
             - 当前GOAL_EnemyKeepDist行为的实例
             - 用于获取AI参数和距离信息

    f2_arg2: 额外参数 (Extra parameter)
             - 当前未使用 (Currently unused)

    返回值 (Return Value):
    ────────────────────────────────────────────────────────────────────
    GOAL_RESULT_Success: 保持距离行为完成
    GOAL_RESULT_Continue: 保持距离行为继续执行
]]--
Goal.Update = function (f2_arg0, f2_arg1, f2_arg2)
    -- === 第一步：子目标完成检查 (Sub-Goal Completion Check) ===
    -- 检查所有子目标是否已完成
    if f2_arg2:GetSubGoalNum() <= 0 then
        -- 所有子目标已完成，保持距离行为成功结束
        -- (All sub-goals completed, keep distance behavior ends successfully)
        return GOAL_RESULT_Success
    end

    -- === 第二步：参数重新提取阶段 (Parameter Re-Extraction Phase) ===
    -- 在每帧Update中重新获取参数，确保使用最新配置
    -- 这允许参数在运行时被动态修改

    -- 提取攻击目标 (Extract attack target)
    local f2_local0 = f2_arg2:GetParam(0)

    -- 提取转向目标 (Extract turning target)
    local f2_local1 = f2_arg2:GetParam(1)

    -- 提取强制行走距离 (Extract forced walking distance)
    local f2_local2 = f2_arg2:GetParam(2)

    -- 提取强制跑步距离 (Extract forced running distance)
    local f2_local3 = f2_arg2:GetParam(3)

    -- 提取跑步率 (Extract running rate)
    local f2_local4 = f2_arg2:GetParam(4)

    -- 提取防御率 (Extract guard rate)
    local f2_local5 = f2_arg2:GetParam(5)

    -- 提取后方步移概率 (Extract back step probability)
    local f2_local6 = f2_arg2:GetParam(6)

    -- 提取前方步移概率 (Extract front step probability)
    local f2_local7 = f2_arg2:GetParam(7)

    -- 提取步移执行确认间隔 (Extract step execution confirmation interval)
    local f2_local8 = f2_arg2:GetParam(8)

    -- === 第三步：AI攻击参数重新获取 (Re-acquire AI Attack Parameters) ===
    -- 获取攻击参数7006中的距离信息

    -- 获取最小到达距离 (Get minimum arrive distance)
    local f2_local9 = f2_arg1:GetAIAttackParam(7006, AI_ATTACK_PARAM_TYPE__MIN_ARRIVE_DISTANCE)

    -- 获取最大到达距离 (Get maximum arrive distance)
    local f2_local10 = f2_arg1:GetAIAttackParam(7006, AI_ATTACK_PARAM_TYPE__MAX_ARRIVE_DISTANCE)

    -- === 第四步：距离参数有效性检查 (Distance Parameter Validity Check) ===
    if f2_local9 < 0 then
        f2_local9 = 0
    end

    -- === 第五步：紧急回避参数提取 (Emergency Evasion Parameters Extraction) ===
    -- 获取紧急回避相关的参数

    -- 提取紧急回避距离 (Extract emergency evasion distance)
    -- 当目标进入此距离内时，触发紧急回避
    local f2_local11 = f2_arg2:GetParam(9)

    -- 提取紧急回避概率 (Extract emergency evasion probability)
    -- 控制紧急回避的触发概率
    local f2_local12 = f2_arg2:GetParam(10)

    -- 提取紧急回避确认间隔 (Extract emergency evasion confirmation interval)
    -- 检查紧急回避条件的时间间隔
    local f2_local13 = f2_arg2:GetParam(11)

    -- === 第六步：当前距离计算 (Current Distance Calculation) ===
    -- 获取敌人与目标的实时距离
    local f2_local14 = f2_arg1:GetDist(f2_local0)

    -- === 第七步：紧急回避检测 (Emergency Evasion Detection) ===
    -- 检查是否需要触发紧急回避行为
    -- 条件：目标进入了紧急回避距离范围

    if f2_local11 ~= nil and f2_local14 <= f2_local11 then
        -- 目标在紧急距离内，检查是否需要执行紧急回避

        -- 获取内部计时器的当前时间（计时器索引为1+1=2）
        -- (Get the current time of the internal timer at index 1+1=2)
        PassTime = f2_arg1:GetIdTimer(1 + 1)

        -- === 间隔检查逻辑 (Interval Check Logic) ===
        -- 确保紧急回避检查不会过于频繁执行
        if 0 >= PassTime then
            -- 计时器未初始化或已过期，设置为紧急回避间隔时间
            -- (Timer not initialized or expired, set to emergency evasion interval)
            PassTime = f2_local13
        end

        -- 检查是否达到了间隔检查时间
        if f2_local13 ~= nil and f2_local13 <= PassTime then
            -- 间隔时间已到，重新启动计时器
            -- (Interval time reached, restart timer)
            f2_arg1:StartIdTimer(1 + 1)

            -- === 紧急回避触发检查 (Emergency Evasion Trigger Check) ===
            -- 根据概率决定是否执行紧急回避
            if f2_local12 ~= nil and f2_arg1:GetRandam_Float(0, 100) < f2_local12 then
                -- 概率成功，执行紧急回避

                -- 清除所有现有子目标
                -- (Clear all existing sub-goals)
                f2_arg2:ClearSubGoal()

                -- 转向自身，为步移做准备
                -- (Turn to self, prepare for stepping)
                f2_arg1:TurnTo(TRAGET_SELF)

                -- 添加基础步移子目标（多向步移，范围5）
                -- (Add basic step sub-goal - multi-directional step with range 5)
                f2_arg2:AddSubGoal(GOAL_EnemyStepBLR, f2_arg2:GetLife(), f2_local0, 5)

                -- 重新添加灵活接近子目标以恢复最优距离
                -- (Re-add flexible approach sub-goal to restore optimal distance)
                f2_arg2:AddSubGoal(GOAL_EnemyFlexibleApproach, f2_arg2:GetLife(), f2_local0, f2_local1,
                                  (f2_local9 + f2_local10) / 2, (f2_local9 + f2_local10) / 2,
                                  f2_local2, f2_local3, f2_local4, GuradRate,
                                  f2_local6, f2_local7, f2_local8, 1)

                -- 重新添加侧向移动以继续保持距离
                -- (Re-add sideway movement to continue maintaining distance)
                f2_arg2:AddSubGoal(GOAL_COMMON_FlexibleSideWayMove, f2_arg2:GetLife(),
                                  f2_arg1:GetRandam_Float(1, 100), f2_arg1:GetRandam_Float(1, 100),
                                  TARGET_ENE_0, 3, f2_arg1:GetRandam_Float(30, 70),
                                  f2_arg2:GetParam(5), f2_local9, f2_local10):SetFailedEndOption(AI_GOAL_FAILED_END_OPT__PARENT_NEXT_SUB_GOAL)

                -- 返回Continue维持紧急回避后的行为继续
                -- (Return Continue to maintain behavior continuation after emergency evasion)
                return GOAL_RESULT_Continue
            end
        end
    end

    -- === 第八步：距离范围检查 (Distance Range Check) ===
    -- 监测敌人是否在理想距离范围内
    -- 如果超出范围，需要重新调整

    -- 复杂的距离判定逻辑，分解如下：
    -- 条件1：NOT (距离 < 最小值 OR 正在远离目标)
    --       即：距离 >= 最小值 AND 不是远离
    -- 条件2：(距离 > 最大值) AND 不是接近
    -- 如果条件1成立 OR 条件2成立，需要重新调整距离

    if not (not (f2_local14 < f2_local9) or f2_arg1:HasGoal(GOAL_COMMON_LeaveTarget)) or
       f2_local10 < f2_local14 and not f2_arg1:HasGoal(GOAL_COMMON_ApproachTarget) then

        -- 距离超出理想范围，需要重新调整

        -- 清除当前所有子目标
        -- (Clear all current sub-goals)
        f2_arg2:ClearSubGoal()

        -- 转向自身，为调整做准备
        -- (Turn to self, prepare for adjustment)
        f2_arg1:TurnTo(TRAGET_SELF)

        -- 重新添加灵活接近子目标以调整到最优距离
        -- (Re-add flexible approach sub-goal to adjust to optimal distance)
        f2_arg2:AddSubGoal(GOAL_EnemyFlexibleApproach, f2_arg2:GetLife(), f2_local0, f2_local1,
                          (f2_local9 + f2_local10) / 2, (f2_local9 + f2_local10) / 2,
                          f2_local2, f2_local3, f2_local4, GuradRate,
                          f2_local6, f2_local7, f2_local8, 1)

        -- 重新添加侧向移动子目标
        -- (Re-add sideway movement sub-goal)
        f2_arg2:AddSubGoal(GOAL_COMMON_FlexibleSideWayMove, f2_arg2:GetLife(),
                          f2_arg1:GetRandam_Float(1, 100), f2_arg1:GetRandam_Float(1, 100),
                          TARGET_ENE_0, 3, f2_arg1:GetRandam_Float(30, 70),
                          f2_arg2:GetParam(5), f2_local9, f2_local10):SetFailedEndOption(AI_GOAL_FAILED_END_OPT__PARENT_NEXT_SUB_GOAL)
    end

    -- === 第九步：行为继续返回 (Behavior Continuation Return) ===
    -- 返回Continue以维持保持距离行为的继续执行
    -- (Return Continue to maintain keep distance behavior continuation)
    return GOAL_RESULT_Continue

end


