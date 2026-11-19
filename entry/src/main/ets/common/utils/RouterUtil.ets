import { router } from '@kit.ArkUI';
import { BusinessError } from '@kit.BasicServicesKit';
import { Logger } from './Logger';

/**
 * 路由统一封装。参数使用显式 class，避免 ArkTS 对象字面量类型不明确的问题。
 */
export class RouterUtil {
  static push(url: string, params?: Object): void {
    router.pushUrl({
      url: url,
      params: params
    }).catch((err: BusinessError) => {
      Logger.error('Router', `push ${url} failed: ${JSON.stringify(err)}`);
    });
  }

  static replace(url: string, params?: Object): void {
    router.replaceUrl({
      url: url,
      params: params
    }).catch((err: BusinessError) => {
      Logger.error('Router', `replace ${url} failed: ${JSON.stringify(err)}`);
    });
  }

  static back(): void {
    router.back();
  }
}
