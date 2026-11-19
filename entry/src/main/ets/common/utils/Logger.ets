import { hilog } from '@kit.PerformanceAnalysisKit';

const DOMAIN: number = 0x0001;
const TAG: string = 'HarmonyMall';

/**
 * 统一日志出口，方便过滤与关闭。
 */
export class Logger {
  static info(scope: string, message: string): void {
    hilog.info(DOMAIN, TAG, '%{public}s', `[${scope}] ${message}`);
  }

  static warn(scope: string, message: string): void {
    hilog.warn(DOMAIN, TAG, '%{public}s', `[${scope}] ${message}`);
  }

  static error(scope: string, message: string): void {
    hilog.error(DOMAIN, TAG, '%{public}s', `[${scope}] ${message}`);
  }
}
