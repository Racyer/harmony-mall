import { AbilityConstant, ConfigurationConstant, UIAbility, Want } from '@kit.AbilityKit';
import { hilog } from '@kit.PerformanceAnalysisKit';
import { window } from '@kit.ArkUI';
import { AppConstants } from '../common/constants/AppConstants';
import { CartService } from '../service/CartService';

const DOMAIN: number = 0x0001;
const TAG: string = 'HarmonyMall';

export default class EntryAbility extends UIAbility {
  onCreate(want: Want, launchParam: AbilityConstant.LaunchParam): void {
    try {
      this.context.getApplicationContext().setColorMode(ConfigurationConstant.ColorMode.COLOR_MODE_LIGHT);
    } catch (error) {
      hilog.error(DOMAIN, TAG, 'Failed to set color mode. Cause: %{public}s', JSON.stringify(error));
    }

    // 先初始化持久化键，页面中的 @StorageLink 才能拿到默认值。
    PersistentStorage.persistProp(AppConstants.TOKEN_KEY, '');
    PersistentStorage.persistProp(AppConstants.USER_NAME_KEY, '');
    PersistentStorage.persistProp(AppConstants.CART_KEY, '[]');
    PersistentStorage.persistProp(AppConstants.CART_COUNT_KEY, 0);
    PersistentStorage.persistProp(AppConstants.FAVORITES_KEY, '[]');
    PersistentStorage.persistProp(AppConstants.ORDERS_KEY, '[]');
    PersistentStorage.persistProp(AppConstants.ADDRESS_KEY, AppConstants.DEFAULT_ADDRESS);

    AppStorage.setOrCreate(AppConstants.CART_COUNT_KEY, CartService.count());
    hilog.info(DOMAIN, TAG, '%{public}s', 'Ability onCreate');
  }

  onDestroy(): void {
    hilog.info(DOMAIN, TAG, '%{public}s', 'Ability onDestroy');
  }

  onWindowStageCreate(windowStage: window.WindowStage): void {
    windowStage.loadContent('pages/Index', (err) => {
      if (err.code) {
        hilog.error(DOMAIN, TAG, 'Failed to load the content. Cause: %{public}s', JSON.stringify(err));
        return;
      }
      hilog.info(DOMAIN, TAG, '%{public}s', 'Succeeded in loading the content.');
    });
  }

  onWindowStageDestroy(): void {
    hilog.info(DOMAIN, TAG, '%{public}s', 'Ability onWindowStageDestroy');
  }

  onForeground(): void {
    hilog.info(DOMAIN, TAG, '%{public}s', 'Ability onForeground');
  }

  onBackground(): void {
    hilog.info(DOMAIN, TAG, '%{public}s', 'Ability onBackground');
  }
}
