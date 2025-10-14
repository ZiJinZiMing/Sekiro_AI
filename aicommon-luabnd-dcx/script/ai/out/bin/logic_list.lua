--[[============================================================================
模块名称: logic_list.lua
模块版本: 1.0.0
作者: From Software
最后修改: 2025-10-14
编码格式: Shift-JIS

模块概述:
    只狼AI逻辑ID定义表
    包含游戏中所有敌人类型和NPC的逻辑标识符常量定义。

功能描述:
    - 定义所有AI逻辑类型的全局常量ID
    - 用于在脚本中引用特定的敌人AI行为逻辑
    - 按敌人类型和功能分组组织

技术细节:
    - 使用LOGIC_ID_前缀的命名约定
    - ID值范围从0到980000+
    - 包括普通敌人、Boss、NPC和测试用AI

ID分类说明:
    - 0-99999: 系统默认和通用逻辑
    - 100000-199999: 普通敌人（雑兵、小型敌人）
    - 500000-599999: 大型敌人和中型Boss
    - 700000-799999: NPC和特殊角色
    - 900000-999999: 测试和调试用AI

使用示例:
    if ai:GetLogicId() == LOGIC_ID_Rival_710000 then
        -- 执行苇名一心的专属逻辑
    end

版本历史:
    v1.0.0 - 完整的敌人类型定义

依赖模块:
    无（纯常量定义文件）

特殊说明:
    - 此文件为只读常量定义，不应在运行时修改
    - 文件编码必须为Shift-JIS
    - 逻辑ID与AIAttackParam.xml中的定义相对应
============================================================================]]--

-- ============================================================================
-- 系统默认和通用逻辑 (0-99999)
-- ============================================================================

-- 默认逻辑ID
LOGIC_ID_Default = 0

-- 渡场专用逻辑（测试用）
LOGIC_ID_Wataa1540 = 1540

-- 通用AI逻辑
LOGIC_ID_Common10000 = 10000

-- 无行为AI（什么都不做）
LOGIC_ID_Nanimosinai11000 = 11000
LOGIC_ID_Nanimosinai11001 = 11001

-- 巡逻队长AI
LOGIC_ID_PatrolLeader20000 = 20000

-- ============================================================================
-- 普通敌人类型 (100000-199999)
-- ============================================================================

-- 落武者（基础敌人）
LOGIC_ID_Ochimusha_101000 = 101000
LOGIC_ID_Tutorial_Ochimusha_101200 = 101200  -- 教程用落武者

-- 侍大将（中型敌人）
LOGIC_ID_SamuraiTaisho_102000 = 102000

-- 蜈蚣（小型）
LOGIC_ID_Mukade_103000 = 103000
-- 蜈蚣（大型）
LOGIC_ID_Mukade_Large_104000 = 104000

-- 枪足轻（枪兵）
LOGIC_ID_Yarisouhei_105000 = 105000

-- 回转枪术使
LOGIC_ID_KaitenSoujutusi_106000 = 106000

-- 修罗武士
LOGIC_ID_SyuraSamurai_107000 = 107000

-- 七面武者
LOGIC_ID_7menmusya_108000 = 108000

-- 犬（敌对动物）
LOGIC_ID_Inu_109000 = 109000

-- 山守（守墓人）
LOGIC_ID_Yamori_111000 = 110000

-- 慈照姥姥（NPC型敌人）
LOGIC_ID_JijoOba_111000 = 111000

-- 见张番
LOGIC_ID_Mihariban_112000 = 112000

-- 南蛮铠甲
LOGIC_ID_NanbanArmor_113000 = 113000

-- 土墙兵
LOGIC_ID_Dobeihei_114000 = 114000

-- 乌鸦（飞行敌人）
LOGIC_ID_Crow_117000 = 117000

-- 源难（剑士型）
LOGIC_ID_Genan_118000 = 118000

-- 谷贼（山贼）
LOGIC_ID_Taniteki_119000 = 119000

-- 即身佛（带蜈蚣）
LOGIC_ID_Sokushinbutsu_120000 = 120000
-- 即身佛（无蜈蚣）
LOGIC_ID_Sokushinbutsu_mukadenashi_121000 = 121000

-- 蟋蟀（虫类小型敌人）
LOGIC_ID_Korogi_121100 = 121100
-- 蟋蟀（幻觉版）
LOGIC_ID_Korogi_genkaku_121180 = 121180

-- 即身佛（假人/Dummy）
LOGIC_ID_Sokushinbutsu_dummy_121200 = 121200

-- 寺木杂兵
LOGIC_ID_Terakisozako_122000 = 122000

-- 鲨鱼（水中敌人）
LOGIC_ID_Syamo_124000 = 124000

-- 夜叉猿眷属
LOGIC_ID_YashazaruKenzoku_125000 = 125000

-- 稚儿猿
LOGIC_ID_Chigosaru_126000 = 126000

-- 水生村村民（克苏鲁风格）
LOGIC_ID_Innsmouth_130000 = 130000

-- 源平武者（古代武士）
LOGIC_ID_Genpeimusya_131000 = 131000

-- 宝鲤（特殊敌人）
LOGIC_ID_Takaragoi_132000 = 132000

-- 水中无首（水下）
LOGIC_ID_SuichuKubinashi_134000 = 134000

-- 无首（陆地）
LOGIC_ID_Kubinashi_135000 = 135000

-- 乱波（忍者型）
LOGIC_ID_Rappa_136000 = 136000

-- 剑客（高级剑士）
LOGIC_ID_Kenkaku_140000 = 140000
LOGIC_ID_Kenkaku_140010 = 140010  -- 剑客变种

-- 夜鹰众（忍者）
LOGIC_ID_Yotakashu_145000 = 145000

-- 护卫众
LOGIC_ID_Koeishu_147000 = 147000

-- 村人僵尸
LOGIC_ID_Murabitozonbi_150000 = 150000
-- 村人僵尸（幻觉版）
LOGIC_ID_Murabitozonbi_genkaku_151000 = 151000

-- 弥刀（特殊剑士）
LOGIC_ID_Yatou_155000 = 155000

-- 德川武士（后期敌人）
LOGIC_ID_Tokugawazamurai_170000 = 170000

-- ============================================================================
-- 大型敌人和Boss (500000-599999)
-- ============================================================================

-- 破戒僧（Boss）
LOGIC_ID_Hakaisou500000 = 500000

-- 大蛇（巨型Boss）
LOGIC_ID_Orochi501000 = 501000
-- 大蛇（假人用）
LOGIC_ID_Orochi_Dummy_501001 = 501001

-- 赤鬼（Mini Boss）
LOGIC_ID_RedOgre_502000 = 502000

-- 稻草人（活动傀儡）
LOGIC_ID_Waraningyou_503000 = 503000
-- 稻草人（蠕动型）
LOGIC_ID_Waraningyou_nyoronyoro_503100 = 503100
-- 稻草人（变种）
LOGIC_ID_Waraningyou_504000 = 504000

-- 锦鲤（Boss级别）
LOGIC_ID_Nishikigoi_505000 = 505000

-- 忍军首领（Boss）
LOGIC_ID_NingunOsa_506000 = 506000
LOGIC_ID_NingunOsa_506300 = 506300  -- 变种

-- 枭（Boss）
LOGIC_ID_Fukuro_506000 = 506000
LOGIC_ID_Fukuro_506300 = 506300  -- 变种

-- 骑马武者（Boss）
LOGIC_ID_Kibamusya508000 = 508000

-- 蝴蝶夫人（Boss）
LOGIC_ID_Otyou_509000 = 509000

-- 狮子猿（Boss）
LOGIC_ID_Yasyazaru510000 = 510000

-- 人偶龙（特殊Boss）
LOGIC_ID_NingyoRyu_520000 = 520000

-- 樱龙（Boss）
LOGIC_ID_Okinaryuu_530000 = 530000
-- 樱龙（假人）
LOGIC_ID_Okinaryuu_Dummy_530010 = 530010

-- 触手（樱龙附属）
LOGIC_ID_Syokusyu_531000 = 531000
LOGIC_ID_Syokusyu_531001 = 531001  -- 变种

-- 樱龙（大型形态）
LOGIC_ID_Okinaryuu_big_532000 = 532000

-- 剑圣（Boss）
LOGIC_ID_Kensei_540000 = 540000
LOGIC_ID_Kensei_540300 = 540300  -- 变种

-- ============================================================================
-- NPC和特殊角色 (700000-799999)
-- ============================================================================

-- 女剑士（蝴蝶夫人NPC形态）
LOGIC_ID_OnnaSousha_700000 = 700000

-- NPC佛师
LOGIC_ID_NPCBusshi_701000 = 701000

-- 佛师·鬼（敌对形态）
LOGIC_ID_Busshi_Oni_702000 = 702000

-- 鬼佛（互动物体）
LOGIC_ID_Kibutu_702100 = 702100

-- 苇名一心（宿敌/Boss）
LOGIC_ID_Rival_710000 = 710000
LOGIC_ID_Rival_710300 = 710300  -- 变种
-- 苇名一心（裸身形态）
LOGIC_ID_Rival_hadaka_711000 = 711000
LOGIC_ID_Rival_hadaka_711300 = 711300  -- 变种

-- 御子（重要NPC）
LOGIC_ID_Ouji_720000 = 720000

-- 异乡之女（NPC）
LOGIC_ID_Iseinomusume_740000 = 740000

-- ============================================================================
-- 测试和调试用AI (900000-999999)
-- ============================================================================

-- NPC测试用
LOGIC_ID_NPCTest_900000 = 900000

-- 犬（测试用）
LOGIC_ID_Inu_910000 = 910000

-- 落武者（测试用）
LOGIC_ID_Ochimusha_950000 = 950000

-- 侍大将（测试用）
LOGIC_ID_SamuraiTaisho_952000 = 952000

-- 剑修武士（测试用）
LOGIC_ID_Kenshusamurai_952300 = 952300

-- 蜈蚣（测试用）
LOGIC_ID_Mukade_953000 = 953000

-- 大型蜈蚣（测试用）
LOGIC_ID_Mukade_Large_956000 = 956000

-- 破戒僧（测试用）
LOGIC_ID_Hakaisou960000 = 960000

-- 大蛇（测试用）
LOGIC_ID_Orochi961000 = 961000

-- 慈照姥姥（测试用）
LOGIC_ID_JijoOba_965000 = 965000

-- 见张番（测试用）
LOGIC_ID_Mihariban_966000 = 966000

-- ============================================================================
-- 忍杀确认系统（特殊系统AI）
-- ============================================================================

-- 忍杀确认·汎用（通用型）
LOGIC_ID_Ninsatsukakunin_hanyo_980000 = 980000

-- 忍杀确认·无警戒（偷袭专用）
LOGIC_ID_Ninsatsukakunin_NoCaution_981000 = 981000

-- 忍杀确认·大型敌人
LOGIC_ID_Ninsatsukakunin_Ogata_982000 = 982000

-- 忍杀确认·四足型
LOGIC_ID_Ninsatsukakunin_Yonsoku_983000 = 983000

-- 测试用座头市（盲剑士）
LOGIC_ID_TestZatoichi_985000 = 985000

