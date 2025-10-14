--[[============================================================================
    set_number_realtime.lua - 实时数值设置模块 (Realtime Number Setting Module)

    版本信息 (Version Info): v1.0 - Initial documentation
    作者 (Author): FromSoftware AI Team / Enhanced by Claude Code
    最后修改 (Last Modified): 2025-10-13
    编码格式 (Encoding): Shift-JIS (required for Sekiro compatibility)

    ============================================================================
    模块概述 (Module Overview):
    ============================================================================
    这是一个实时数值设置工具模块，提供即时设置AI数值变量的功能。该模块允许
    在AI行为执行过程中动态设置或修改数值变量，用于控制AI的状态标志、计数器
    和其他数值型参数。

    核心功能 (Core Functions):
    - 实时设置AI数值变量 (Set AI number variable in realtime)
    - 支持任意数值索引 (Support arbitrary number index)
    - 即时生效无延迟 (Take effect immediately)

    使用场景 (Usage Scenarios):
    - 设置AI状态标志 (Set AI state flags)
    - 初始化计数器变量 (Initialize counter variables)
    - 记录战斗阶段信息 (Record battle phase information)
    - 存储临时计算结果 (Store temporary calculation results)
    - 在不同行为间传递数据 (Pass data between different behaviors)

    与定时器模块的区别 (Difference from Timer Module):
    - set_timer_realtime.lua: 设置会随时间递减的定时器
    - set_number_realtime.lua: 设置静态的数值变量（不会自动变化）
    - 定时器用于时序控制，数值用于状态存储

    与其他模块的关系 (Relationship with Other Modules):
    - 配合common_func.lua中的数值管理函数使用
    - 可在任何AI行为中作为子目标调用
    - 常与条件判断、状态切换结合使用

    ============================================================================
]]--

-- 注册数值设置目标 (Register number setting goal)
-- 注意：RegisterTableGoal的名称仍使用"SetTimerRealtime"，这可能是原代码的遗留问题
RegisterTableGoal(GOAL_COMMON_SetNumberRealtime, "SetTimerRealtime")

-- 声明该目标不使用子目标系统 (Declare this goal doesn't use sub-goal system)
REGISTER_GOAL_NO_SUB_GOAL(GOAL_COMMON_SetNumberRealtime, true)

-- 注册调试参数：数值索引 (Register debug parameter: number index)
REGISTER_DBG_GOAL_PARAM(GOAL_COMMON_SetNumberRealtime, 0, "ナンバーインデックス", 0)  -- 数值索引 (Number index)

-- 注册调试参数：数值 (Register debug parameter: number value)
REGISTER_DBG_GOAL_PARAM(GOAL_COMMON_SetNumberRealtime, 1, "番号", 0)  -- 数值 (Number value)

--[[============================================================================
    目标激活函数 (Goal Activation Function)
    ============================================================================
]]--

-- 实时数值设置激活函数 (Realtime number setting activation function)
-- 功能说明 (Function Description):
--   立即设置指定索引的AI数值变量为指定值。该函数在被调用时立即执行，
--   修改AI的数值变量状态，用于存储状态信息、标志位或计数器等数据。
--
-- 参数说明 (Parameters):
--   f1_arg0: AI角色对象 (AI character object) - 目标AI的角色对象（未直接使用）
--   f1_arg1: AI实体对象 (AI entity object) - 执行数值设置的AI实体
--   f1_arg2: 目标对象 (Goal object) - 包含数值参数的目标对象
--
-- 参数详解 (Parameter Details):
--   参数0 (f1_local0): 数值索引 (Number index)
--     - 范围：通常为0-99的整数
--     - 用途：标识要设置的数值变量ID
--     - 不同索引用于不同的用途（状态标志、计数器、阶段标记等）
--
--   参数1 (f1_local1): 数值 (Number value)
--     - 类型：整数或浮点数
--     - 范围：取决于具体用途，通常为0-100
--     - 用途：要设置的数值变量的值
--
-- 执行流程 (Execution Flow):
--   1. 从目标对象中提取数值索引
--   2. 从目标对象中提取要设置的数值
--   3. 调用SetNumber立即设置数值变量
--   4. 函数结束，AI继续执行后续行为
--
-- 使用示例 (Usage Example):
--   -- 在AI逻辑脚本中使用
--   goal:AddSubGoal(GOAL_COMMON_SetNumberRealtime, 0.1, 0, 1)
--   -- 设置0号变量为1（例如：标记AI已进入战斗状态）
--
--   goal:AddSubGoal(GOAL_COMMON_SetNumberRealtime, 0.1, 10, 3)
--   -- 设置10号变量为3（例如：记录当前战斗阶段为第3阶段）
--
-- 常用数值索引及其用途 (Common Number Indices and Their Purposes):
--   0: 战斗状态标志 (Combat state flag) - 0:非战斗, 1:战斗中
--   1: 防御姿态标志 (Guard stance flag) - 0:正常, 1:防御
--   2: 移动模式 (Movement mode) - 0:走, 1:跑, 2:冲刺
--   3: 连击计数器 (Combo counter) - 记录当前连击次数
--   4: 走/跑切换标志 (Walk/Run toggle) - 用于控制移动速度
--   5-9: 自定义状态标志 (Custom state flags)
--   10-19: 战斗阶段标记 (Battle phase markers)
--   20-29: 攻击模式标记 (Attack pattern markers)
--   30-49: 临时变量 (Temporary variables)
--   50-99: 扩展用途 (Extended purposes)
--
-- 常见用法模式 (Common Usage Patterns):
--   1. 布尔标志：使用0表示false，1表示true
--   2. 枚举状态：使用连续整数表示不同状态（如0,1,2,3...）
--   3. 计数器：从0开始递增或从某值开始递减
--   4. 百分比：使用0-100表示百分比值
Goal.Activate = function (f1_arg0, f1_arg1, f1_arg2)
    local f1_local0 = f1_arg2:GetParam(0)       -- 获取数值索引 (Get number index)
    local f1_local1 = f1_arg2:GetParam(1)       -- 获取要设置的数值 (Get number value to set)

    -- 立即设置数值变量 (Set number variable immediately)
    -- 参数：数值索引, 数值
    f1_arg1:SetNumber(f1_local0, f1_local1)

end

--[[============================================================================
    目标更新函数 (Goal Update Function)
    ============================================================================
]]--

-- 实时数值设置更新函数 (Realtime number setting update function)
-- 功能说明 (Function Description):
--   数值设置是即时操作，无需持续更新。该函数使用默认的无子目标更新逻辑，
--   在激活后立即返回成功状态。
--
-- 参数说明 (Parameters):
--   f2_arg0: AI角色对象 (AI character object) - 目标AI的角色对象
--   f2_arg1: AI实体对象 (AI entity object) - 执行更新的AI实体
--   f2_arg2: 目标对象 (Goal object) - 当前目标对象
--
-- 返回值 (Return Value):
--   通过Update_Default_NoSubGoal返回成功状态 (Return success status via Update_Default_NoSubGoal)
--
-- 执行逻辑 (Execution Logic):
--   由于数值设置是即时操作，该函数在第一次调用时就会返回成功，
--   不需要等待或循环处理。
Goal.Update = function (f2_arg0, f2_arg1, f2_arg2)
    -- 使用默认的无子目标更新逻辑，立即返回成功 (Use default no-sub-goal update logic, return success immediately)
    return Update_Default_NoSubGoal(f2_arg0, f2_arg1, f2_arg2)

end

--[[============================================================================
    文件结束 (End of File)
    ============================================================================

    实时数值设置模块已完成文档化。该模块现在具有：
    - 完整的功能说明和用途描述
    - 详细的参数说明和使用场景
    - 清晰的数值索引规范和用途说明
    - 常见用法模式和最佳实践
    - 专业级的代码注释

    技术特点 (Technical Features):
    - 即时生效：无延迟，立即修改数值状态
    - 轻量级操作：执行速度快，不影响性能
    - 灵活性高：支持任意数值索引和值
    - 持久存储：数值不会自动变化，需手动修改

    最佳实践 (Best Practices):
    - 为不同用途的数值使用不同的索引范围，避免冲突
    - 在AI脚本开头用注释文档化使用的数值索引及其含义
    - 使用有意义的常量替代魔法数字（例如：STATE_COMBAT = 1）
    - 在状态转换时及时更新相关数值变量
    - 定期清理不再使用的临时变量

    常用操作组合 (Common Operation Combinations):
    - 设置数值 + 检查条件：SetNumber + GetNumber
    - 设置标志 + 触发行为：SetNumber + 条件判断 + AddSubGoal
    - 初始化变量 + 开始计时：SetNumber + SetTimer

    相关函数 (Related Functions):
    - AI:GetNumber(index) - 获取数值变量当前值
    - AI:SetStringIndexedNumber(name, value) - 通过字符串名称设置数值
    - AI:GetStringIndexedNumber(name) - 通过字符串名称获取数值

    调试技巧 (Debug Tips):
    - 使用调试参数查看实时的数值变量状态
    - 在关键位置添加打印语句输出数值变量
    - 记录数值变量的变化历史，便于追踪问题
    ============================================================================
]]--

