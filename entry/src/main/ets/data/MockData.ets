import { Category, Product } from '../model/Product';

/**
 * 本地 Mock 数据。后续接入真实后端时，仅替换 ProductService 的实现，页面无需改动。
 */
export const CATEGORIES: Category[] = [
  { id: 0, name: '精选', icon: '✨', desc: '编辑推荐' },
  { id: 1, name: '手机', icon: '📱', desc: '旗舰与影像' },
  { id: 2, name: '电脑', icon: '💻', desc: '办公与创作' },
  { id: 3, name: '穿戴', icon: '⌚', desc: '健康与运动' },
  { id: 4, name: '智能家居', icon: '🏠', desc: '全屋互联' },
  { id: 5, name: '配件', icon: '🎧', desc: '充电与外设' }
];

export const BANNERS: ResourceStr[] = [
  $r('app.media.banner_1'),
  $r('app.media.banner_2'),
  $r('app.media.banner_3')
];

export const HOT_KEYWORDS: string[] = ['旗舰手机', '降噪耳机', '智能手表', '轻薄本', '快充'];

export const PRODUCTS: Product[] = [
  {
    id: 1,
    name: '鸿蒙旗舰 Phone X1',
    subtitle: '6.7 英寸 OLED · 超光变影像 · 卫星通信',
    price: 4999,
    originalPrice: 5499,
    image: $r('app.media.product_phone'),
    categoryId: 1,
    tags: ['新品', '旗舰'],
    sales: 1286,
    rating: 4.9,
    description: '搭载新一代鸿蒙影像引擎，支持全焦段超清拍摄与双向卫星消息。玄武钢化玻璃与 IP68 防护，日常使用更安心。'
  },
  {
    id: 2,
    name: '折叠屏 Fold S',
    subtitle: '7.9 英寸内屏 · 超轻铰链 · 多任务分屏',
    price: 8999,
    originalPrice: 9999,
    image: $r('app.media.product_fold'),
    categoryId: 1,
    tags: ['折叠旗舰', '轻薄'],
    sales: 356,
    rating: 4.8,
    description: '展开即是平板，合上轻巧便携。鸿蒙多窗口让会议、笔记与购物同屏并行，商务出行一台搞定。'
  },
  {
    id: 3,
    name: '轻薄影像手机 Air 12',
    subtitle: '5000 万像素主摄 · 66W 快充 · 7.2mm 机身',
    price: 3299,
    originalPrice: 3599,
    image: $r('app.media.product_phone'),
    categoryId: 1,
    tags: ['影像', '轻薄'],
    sales: 2043,
    rating: 4.7,
    description: '轻至 168g 的直屏旗舰，人像肤色自然、夜景纯净。支持鸿蒙超级终端，与平板、耳机无缝协同。'
  },
  {
    id: 4,
    name: 'MateBook Air 14',
    subtitle: '2.8K 高刷屏 · 1.29kg · 70Wh 大电池',
    price: 5499,
    originalPrice: 5999,
    image: $r('app.media.product_laptop'),
    categoryId: 2,
    tags: ['轻薄本', '长续航'],
    sales: 768,
    rating: 4.8,
    description: '专为移动办公打造的 14 英寸轻薄本，支持鸿蒙多设备协同与超级中转站，文档、图片一拖即传。'
  },
  {
    id: 5,
    name: '创作本 Pro 16',
    subtitle: '16 英寸 3.2K · 独立显卡 · 双风扇散热',
    price: 8999,
    originalPrice: 9499,
    image: $r('app.media.product_laptop'),
    categoryId: 2,
    tags: ['高性能', '创作'],
    sales: 245,
    rating: 4.9,
    description: '面向设计与视频创作者的移动工作站，广色域屏幕出厂逐台校色，渲染导出更快更稳。'
  },
  {
    id: 6,
    name: '二合一平板 Book E',
    subtitle: '12.6 英寸 · 键盘手写笔 · 鸿蒙互联',
    price: 3999,
    originalPrice: 4299,
    image: $r('app.media.product_tablet'),
    categoryId: 2,
    tags: ['平板', '键盘'],
    sales: 512,
    rating: 4.6,
    description: '平板与笔记本形态自由切换，磁吸键盘即插即用。支持全局批注与手写转文本，课堂笔记更高效。'
  },
  {
    id: 7,
    name: '智能手表 Watch GT 5',
    subtitle: '14 天续航 · 血氧心率 · 100+ 运动模式',
    price: 1488,
    originalPrice: 1688,
    image: $r('app.media.product_watch'),
    categoryId: 3,
    tags: ['健康监测', '长续航'],
    sales: 1890,
    rating: 4.8,
    description: '全天候健康守护，支持血氧、心率与睡眠监测。双频 GPS 精准记录户外轨迹，续航最长 14 天。'
  },
  {
    id: 8,
    name: '无线耳机 FreeBuds Pro',
    subtitle: '智慧动态降噪 · 星闪连接 · 空间音频',
    price: 899,
    originalPrice: 1099,
    image: $r('app.media.product_buds'),
    categoryId: 3,
    tags: ['降噪', '星闪'],
    sales: 4321,
    rating: 4.7,
    description: '根据环境自动调节降噪深度，地铁、咖啡馆都能安静听歌。支持双设备连接与离线查找。'
  },
  {
    id: 9,
    name: '智能手环 Band 9',
    subtitle: '1.62 英寸 AMOLED · 睡眠监测 · 5ATM 防水',
    price: 269,
    originalPrice: 299,
    image: $r('app.media.product_band'),
    categoryId: 3,
    tags: ['运动', '轻巧'],
    sales: 6720,
    rating: 4.6,
    description: '轻至 14g 的日常健康手环，支持 96 种运动模式与全天心率监测，游泳也可佩戴。'
  },
  {
    id: 10,
    name: '运动手表 Watch Fit',
    subtitle: '方形大屏 · 跑力指数 · 10 天续航',
    price: 699,
    originalPrice: 799,
    image: $r('app.media.product_watch'),
    categoryId: 3,
    tags: ['运动', '轻薄'],
    sales: 980,
    rating: 4.5,
    description: '为跑步与健身爱好者设计，提供专业跑力分析与恢复建议，轻巧表体长时间佩戴无负担。'
  },
  {
    id: 11,
    name: '智能音箱 Sound X',
    subtitle: '帝瓦雷联合调音 · 鸿蒙一碰传 · 智能家居中枢',
    price: 799,
    originalPrice: 899,
    image: $r('app.media.product_speaker'),
    categoryId: 4,
    tags: ['音质', '智能家居'],
    sales: 654,
    rating: 4.7,
    description: '三分频声学结构带来饱满低频，一句话控制全屋鸿蒙设备，也可作为家庭影音副音箱。'
  },
  {
    id: 12,
    name: '扫地机器人 CleanBot',
    subtitle: '激光导航 · 自动集尘 · 拖扫一体',
    price: 2299,
    originalPrice: 2599,
    image: $r('app.media.product_robot'),
    categoryId: 4,
    tags: ['激光导航', '自动集尘'],
    sales: 321,
    rating: 4.8,
    description: '毫米级激光建图，智能规划清扫路径。自动集尘基站可存储 60 天尘袋，解放双手。'
  },
  {
    id: 13,
    name: '智慧屏 Vision 55',
    subtitle: '4K 120Hz · 鸿蒙超级投屏 · 远场语音',
    price: 3299,
    originalPrice: 3699,
    image: $r('app.media.product_tablet'),
    categoryId: 4,
    tags: ['4K', '鸿蒙互联'],
    sales: 187,
    rating: 4.6,
    description: '客厅的智慧中心，手机轻碰即可投屏。支持远场语音与儿童模式，全家人都好用。'
  },
  {
    id: 14,
    name: '66W 超级快充套装',
    subtitle: '原装充电器 · 智能温控 · 兼容多协议',
    price: 169,
    originalPrice: 199,
    image: $r('app.media.product_charger'),
    categoryId: 5,
    tags: ['快充', '原装'],
    sales: 8231,
    rating: 4.8,
    description: '66W 大功率输出，30 分钟充至 80%。内置智能温控芯片，边充边玩也安心。'
  },
  {
    id: 15,
    name: '磁吸充电宝 10000mAh',
    subtitle: '磁吸无线充 · 双向快充 · 可上飞机',
    price: 249,
    originalPrice: 299,
    image: $r('app.media.product_charger'),
    categoryId: 5,
    tags: ['磁吸', '轻薄'],
    sales: 3120,
    rating: 4.7,
    description: '吸附即充，无需线缆。10000mAh 容量满足一天外出，支持有线无线同时输出。'
  },
  {
    id: 16,
    name: '星闪无线键盘',
    subtitle: '星闪低时延 · 三设备切换 · 长续航',
    price: 399,
    originalPrice: 499,
    image: $r('app.media.product_laptop'),
    categoryId: 5,
    tags: ['星闪', '办公'],
    sales: 456,
    rating: 4.6,
    description: '星闪连接更低时延，打字跟手。可在手机、平板、电脑之间一键切换，桌面更简洁。'
  }
];
