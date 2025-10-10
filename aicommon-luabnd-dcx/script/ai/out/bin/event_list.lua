--[[
AI事件列表定义文件
用途：定义游戏中各种AI事件的标识符和编号
说明：这些事件用于触发特定的AI行为、动画和状态变化
范围：涵盖敌人行为、区域触发、排兵布阵、特殊攻击等各类事件

使用方式：
- 在AI脚本中引用这些常量来触发相应事件
- 事件编号用于区分不同类型的行为和反应
- 编号设计考虑了扩展性和分类管理
--]]

-- 基础事件
AI_EVENT_None = -1                    -- 无事件状态

-- 方阵/排兵布阵相关事件 (Phalanx系列)
AI_EVENT_Phalanx_Gattai = 10         -- 方阵合体/集结事件
AI_EVENT_Phalanx_Bousui = 20         -- 方阵防守事件
AI_EVENT_Phalanx_Bousui_Attack = 21  -- 方阵防守攻击事件
AI_EVENT_Phalanx_Bousui_WallAttack = 22  -- 方阵墙体攻击事件
AI_EVENT_Phalanx_Bunsan = 30         -- 方阵分散事件

-- 火焰人相关事件 (FlameMan系列)
AI_EVENT_FlameMan_Angry = 10         -- 火焰人愤怒状态事件
AI_EVENT_FlameMan_Weaker = 20        -- 火焰人虚弱状态事件
AI_EVENT_FlameMan_Roar = 1           -- 火焰人咆哮事件

-- 奴隶威吓事件
AI_EVENT_DOREI_IKAKU = 10            -- 奴隶威吓行为事件

-- 区域触发事件 (AREA系列)
AI_EVENT_AREA01 = 10                 -- 区域1触发事件
AI_EVENT_AREA02 = 20                 -- 区域2触发事件
AI_EVENT_AREA03 = 30                 -- 区域3触发事件
AI_EVENT_AREA04 = 40                 -- 区域4触发事件
AI_EVENT_AREA05 = 50                 -- 区域5触发事件
AI_EVENT_AREA06 = 60                 -- 区域6触发事件

-- 位置状态事件 (隧道和房间)
AI_EVENT_STAY_TUNNEL = 10            -- 停留在隧道状态
AI_EVENT_STAY_ROOM = 20              -- 停留在房间状态

-- 隧道位置事件
AI_EVENT_TUNNEL_RIGHT = 10           -- 隧道右侧位置事件
AI_EVENT_TUNNEL_CENTER = 20          -- 隧道中央位置事件
AI_EVENT_TUNNEL_LEFT = 30            -- 隧道左侧位置事件

-- 房间位置事件
AI_EVENT_ROOM_RIGHT = 40             -- 房间右侧位置事件
AI_EVENT_ROOM_CENTER = 50            -- 房间中央位置事件
AI_EVENT_ROOM_LEFT = 60              -- 房间左侧位置事件

-- 特殊状态事件
AI_EVENT_GRACE = 10                  -- 优雅状态事件

-- 方向性事件
AI_EVENT_FOR_RIGHT = 10              -- 面向右侧事件
AI_EVENT_FOR_CENTER = 20             -- 面向中央事件
AI_EVENT_FOR_LEFT = 30               -- 面向左侧事件
AI_EVENT_NEAR = 40                   -- 接近事件

-- 攻击动作事件 (拳击系列)
AI_EVENT_PUNCH1 = 10                 -- 拳击攻击1
AI_EVENT_PUNCH2 = 20                 -- 拳击攻击2
AI_EVENT_PUNCH3 = 30                 -- 拳击攻击3
AI_EVENT_PUNCH4 = 40                 -- 拳击攻击4

-- 呼吸/喷射攻击事件
AI_EVENT_BREATH1 = 50                -- 呼吸攻击1
AI_EVENT_BREATH2 = 60                -- 呼吸攻击2
AI_EVENT_BREATH3 = 70                -- 呼吸攻击3
AI_EVENT_BREATH4 = 80                -- 呼吸攻击4

-- 撕咬攻击事件
AI_EVENT_BITEATTACK = 90             -- 撕咬攻击事件

-- 反应事件
AI_EVENT_REACTION = 10               -- 通用反应事件

-- 特殊敌人事件
AI_EVENT_KIMERA_TALE_CUT = 10        -- 奇美拉尾巴切断事件
AI_EVENT_LEECH_REGENERATE = 10       -- 水蛭再生事件
AI_EVENT_HIRYU_GATE = 10             -- 飞龙门事件
AI_EVENT_MUKADE_TALE_CUT = 1         -- 蜈蚣尾巴切断事件

-- 部位破坏事件
AI_EVENT_PARTS_BREAK = 10            -- 可再生部位破坏事件
AI_EVENT_PARTS_NON_REGENERATABLE_BREAK = 20  -- 不可再生部位破坏事件

