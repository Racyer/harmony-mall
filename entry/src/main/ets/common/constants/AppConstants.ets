/**
 * 全局常量。页面、服务、组件统一从这里取值，避免魔法字符串。
 */
export class AppConstants {
  static readonly APP_NAME: string = '鸿蒙优选';
  static readonly APP_SLOGAN: string = 'HarmonyOS 生态好物商城';
  static readonly PAGE_SIZE: number = 6;

  static readonly CART_KEY: string = 'cartItems';
  static readonly CART_COUNT_KEY: string = 'cartCount';
  static readonly TOKEN_KEY: string = 'token';
  static readonly USER_NAME_KEY: string = 'userName';
  static readonly FAVORITES_KEY: string = 'favoriteIds';
  static readonly ORDERS_KEY: string = 'orders';
  static readonly ADDRESS_KEY: string = 'address';

  static readonly DEMO_ACCOUNT: string = 'demo';
  static readonly DEMO_PASSWORD: string = '123456';
  static readonly DEFAULT_ADDRESS: string = '上海市浦东新区世纪大道 100 号 鸿蒙大厦 12F';
}
