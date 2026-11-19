import { promptAction } from '@kit.ArkUI';

/**
 * 轻提示封装，避免每个页面重复写 promptAction。
 */
export class ToastUtil {
  static show(message: string): void {
    promptAction.showToast({
      message: message,
      duration: 2000
    });
  }
}
