import { AppTheme } from '../common/theme/AppTheme';
import { AuthService } from '../service/AuthService';
import { AppConstants } from '../common/constants/AppConstants';
import { RouterUtil } from '../common/utils/RouterUtil';
import { ToastUtil } from '../common/utils/ToastUtil';
import { PageHeader } from '../components/PageHeader';

@Entry
@Component
struct LoginPage {
  @State account: string = AppConstants.DEMO_ACCOUNT;
  @State password: string = AppConstants.DEMO_PASSWORD;
  @State errorMessage: string = '';

  private doLogin(): void {
    if (AuthService.login(this.account, this.password)) {
      this.errorMessage = '';
      ToastUtil.show('登录成功');
      RouterUtil.back();
    } else {
      this.errorMessage = '账号或密码不正确（密码至少 6 位）';
    }
  }

  build() {
    Column() {
      PageHeader({ title: '登录' })

      Column() {
        Text('欢迎回来')
          .fontSize(28)
          .fontWeight(FontWeight.Bold)
          .fontColor(AppTheme.TEXT_PRIMARY)
          .width('100%')

        Text('登录后即可同步购物车、订单与收藏')
          .fontSize(12)
          .fontColor(AppTheme.TEXT_SECONDARY)
          .width('100%')
          .margin({ top: 6, bottom: 28 })

        Text('账号')
          .fontSize(12)
          .fontColor(AppTheme.TEXT_SECONDARY)
          .width('100%')
          .margin({ bottom: 6 })

        TextInput({ text: this.account, placeholder: '手机号 / 用户名' })
          .width('100%')
          .height(48)
          .backgroundColor(AppTheme.BG_PAGE)
          .borderRadius(12)
          .padding({ left: 14, right: 14 })
          .onChange((value: string) => {
            this.account = value;
          })

        Text('密码')
          .fontSize(12)
          .fontColor(AppTheme.TEXT_SECONDARY)
          .width('100%')
          .margin({ top: 16, bottom: 6 })

        TextInput({ text: this.password, placeholder: '请输入密码' })
          .type(InputType.Password)
          .width('100%')
          .height(48)
          .backgroundColor(AppTheme.BG_PAGE)
          .borderRadius(12)
          .padding({ left: 14, right: 14 })
          .onChange((value: string) => {
            this.password = value;
          })

        if (this.errorMessage.length > 0) {
          Text(this.errorMessage)
            .fontSize(11)
            .fontColor(AppTheme.DANGER)
            .width('100%')
            .margin({ top: 8 })
        }

        Button('登录')
          .width('100%')
          .height(46)
          .fontSize(15)
          .fontColor(Color.White)
          .backgroundColor(AppTheme.PRIMARY)
          .borderRadius(AppTheme.RADIUS_PILL)
          .margin({ top: 24 })
          .onClick(() => {
            this.doLogin();
          })

        Row() {
          Text('演示账号：demo / 123456')
            .fontSize(11)
            .fontColor(AppTheme.TEXT_TERTIARY)
          Blank()
          Text('注册账号')
            .fontSize(11)
            .fontColor(AppTheme.PRIMARY)
            .onClick(() => {
              ToastUtil.show('注册模块由成员D继续完善');
            })
        }
        .width('100%')
        .margin({ top: 14 })

        Blank()

        Text('登录即代表同意《用户协议》与《隐私政策》')
          .fontSize(10)
          .fontColor(AppTheme.TEXT_TERTIARY)
          .margin({ bottom: 16 })
      }
      .width('100%')
      .layoutWeight(1)
      .padding({ left: 24, right: 24, top: 20 })
      .alignItems(HorizontalAlign.Start)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(Color.White)
  }
}
