import { AppTheme } from '../common/theme/AppTheme';

@Component
export struct SectionHeader {
  title: string = '';
  action: string = '';
  onAction: () => void = () => {
  };

  build() {
    Row() {
      Text(this.title)
        .fontSize(17)
        .fontWeight(FontWeight.Bold)
        .fontColor(AppTheme.TEXT_PRIMARY)

      Blank()

      if (this.action.length > 0) {
        Text(this.action)
          .fontSize(12)
          .fontColor(AppTheme.TEXT_SECONDARY)
          .onClick(() => {
            this.onAction();
          })
      }
    }
    .width('100%')
    .padding({ left: 16, right: 16, top: 16, bottom: 8 })
  }
}
