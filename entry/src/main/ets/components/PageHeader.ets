import { AppTheme } from '../common/theme/AppTheme';
import { RouterUtil } from '../common/utils/RouterUtil';

/**
 * 二级页面统一导航栏：返回 + 标题 + 可选右侧操作。
 */
@Component
export struct PageHeader {
  title: string = '';
  rightText: string = '';
  onRight: () => void = () => {
  };

  build() {
    Stack({ alignContent: Alignment.Center }) {
      Text(this.title)
        .fontSize(17)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppTheme.TEXT_PRIMARY)

      Row() {
        Text('‹')
          .fontSize(34)
          .fontColor(AppTheme.TEXT_PRIMARY)
          .width(44)
          .height(44)
          .textAlign(TextAlign.Center)
          .onClick(() => {
            RouterUtil.back();
          })

        Blank()

        if (this.rightText.length > 0) {
          Text(this.rightText)
            .fontSize(14)
            .fontColor(AppTheme.PRIMARY)
            .padding({ left: 12, right: 12 })
            .onClick(() => {
              this.onRight();
            })
        }
      }
      .width('100%')
      .height('100%')
    }
    .width('100%')
    .height(52)
    .backgroundColor(Color.White)
  }
}
