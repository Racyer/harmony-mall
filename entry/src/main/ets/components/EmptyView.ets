import { AppTheme } from '../common/theme/AppTheme';

@Component
export struct EmptyView {
  icon: string = '🛒';
  title: string = '这里还是空的';
  subtitle: string = '';
  actionText: string = '';
  onAction: () => void = () => {
  };

  build() {
    Column() {
      Text(this.icon)
        .fontSize(56)
        .margin({ bottom: 12 })

      Text(this.title)
        .fontSize(16)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppTheme.TEXT_PRIMARY)

      if (this.subtitle.length > 0) {
        Text(this.subtitle)
          .fontSize(12)
          .fontColor(AppTheme.TEXT_SECONDARY)
          .margin({ top: 6 })
      }

      if (this.actionText.length > 0) {
        Button(this.actionText)
          .height(38)
          .fontSize(14)
          .fontColor(Color.White)
          .backgroundColor(AppTheme.PRIMARY)
          .borderRadius(AppTheme.RADIUS_PILL)
          .padding({ left: 28, right: 28 })
          .margin({ top: 20 })
          .onClick(() => {
            this.onAction();
          })
      }
    }
    .width('100%')
    .layoutWeight(1)
    .justifyContent(FlexAlign.Center)
    .padding({ bottom: 60 })
  }
}
