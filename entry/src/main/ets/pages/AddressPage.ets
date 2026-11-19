import { AppTheme } from '../common/theme/AppTheme';
import { PageHeader } from '../components/PageHeader';
import { ToastUtil } from '../common/utils/ToastUtil';
import { RouterUtil } from '../common/utils/RouterUtil';

@Entry
@Component
struct AddressPage {
  @StorageLink('address') address: string = '';
  @State receiver: string = '';
  @State phone: string = '';
  @State detail: string = '';

  private save(): void {
    if (this.receiver.trim().length === 0) {
      ToastUtil.show('请填写收货人');
      return;
    }
    if (this.phone.trim().length < 6) {
      ToastUtil.show('请填写正确的联系电话');
      return;
    }
    if (this.detail.trim().length === 0) {
      ToastUtil.show('请填写详细地址');
      return;
    }
    const fullAddress: string = `${this.receiver.trim()} ${this.phone.trim()} ${this.detail.trim()}`;
    AppStorage.setOrCreate<string>('address', fullAddress);
    ToastUtil.show('地址已保存');
    RouterUtil.back();
  }

  @Builder
  LabeledInput(label: string, placeholder: string, value: string, field: string) {
    Column() {
      Text(label)
        .fontSize(12)
        .fontColor(AppTheme.TEXT_SECONDARY)
        .width('100%')
        .margin({ bottom: 6 })
      TextInput({ text: value, placeholder: placeholder })
        .width('100%')
        .height(46)
        .backgroundColor(AppTheme.BG_PAGE)
        .borderRadius(10)
        .padding({ left: 12, right: 12 })
        .onChange((input: string) => {
          if (field === 'receiver') {
            this.receiver = input;
          } else if (field === 'phone') {
            this.phone = input;
          }
        })
    }
    .width('100%')
    .margin({ bottom: 14 })
    .alignItems(HorizontalAlign.Start)
  }

  build() {
    Column() {
      PageHeader({ title: '收货地址' })

      Scroll() {
        Column() {
          if (this.address.length > 0) {
            Column() {
              Text('当前默认地址')
                .fontSize(11)
                .fontColor(AppTheme.TEXT_TERTIARY)
                .width('100%')
              Text(this.address)
                .fontSize(13)
                .fontColor(AppTheme.TEXT_PRIMARY)
                .lineHeight(20)
                .width('100%')
                .margin({ top: 6 })
            }
            .width('100%')
            .padding(14)
            .backgroundColor(Color.White)
            .borderRadius(AppTheme.RADIUS_CARD)
            .alignItems(HorizontalAlign.Start)
            .margin({ bottom: 12 })
          }

          Column() {
            Text('新增 / 修改地址')
              .fontSize(15)
              .fontWeight(FontWeight.Bold)
              .fontColor(AppTheme.TEXT_PRIMARY)
              .width('100%')
              .margin({ bottom: 16 })

            this.LabeledInput('收货人', '请输入姓名', this.receiver, 'receiver')

            this.LabeledInput('联系电话', '请输入手机号', this.phone, 'phone')

            Text('详细地址')
              .fontSize(12)
              .fontColor(AppTheme.TEXT_SECONDARY)
              .width('100%')
              .margin({ bottom: 6 })
            TextArea({ text: this.detail, placeholder: '省 / 市 / 区 / 街道 / 门牌号' })
              .width('100%')
              .height(88)
              .backgroundColor(AppTheme.BG_PAGE)
              .borderRadius(10)
              .padding(12)
              .onChange((value: string) => {
                this.detail = value;
              })
          }
          .width('100%')
          .padding(14)
          .backgroundColor(Color.White)
          .borderRadius(AppTheme.RADIUS_CARD)
          .alignItems(HorizontalAlign.Start)

          Button('保存地址')
            .width('100%')
            .height(46)
            .fontSize(15)
            .fontColor(Color.White)
            .backgroundColor(AppTheme.PRIMARY)
            .borderRadius(AppTheme.RADIUS_PILL)
            .margin({ top: 20 })
            .onClick(() => {
              this.save();
            })
        }
        .width('100%')
        .padding({ left: 16, right: 16, top: 12, bottom: 24 })
      }
      .width('100%')
      .layoutWeight(1)
      .scrollBar(BarState.Off)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTheme.BG_PAGE)
  }
}
