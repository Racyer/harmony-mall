import { AppTheme } from '../../common/theme/AppTheme';
import { RouteConstants } from '../../common/constants/RouteConstants';
import { RouterUtil } from '../../common/utils/RouterUtil';
import { ToastUtil } from '../../common/utils/ToastUtil';
import { AuthService } from '../../service/AuthService';
import { FavoriteService } from '../../service/FavoriteService';
import { OrderService } from '../../service/OrderService';

class ProfileMenu {
  icon: string = '';
  title: string = '';
  route: string = '';

  constructor(icon: string, title: string, route: string) {
    this.icon = icon;
    this.title = title;
    this.route = route;
  }
}

@Component
export struct ProfileView {
  @StorageLink('token') token: string = '';
  @StorageLink('userName') userName: string = '';
  @StorageLink('favoriteIds') favoriteIdsJson: string = '[]';
  @StorageLink('orders') ordersJson: string = '[]';
  @StorageLink('cartCount') cartCount: number = 0;

  private menus: ProfileMenu[] = [
    new ProfileMenu('❤️', '我的收藏', RouteConstants.FAVORITES),
    new ProfileMenu('📍', '收货地址', RouteConstants.ADDRESS),
    new ProfileMenu('🎟️', '优惠券', ''),
    new ProfileMenu('💬', '帮助与客服', ''),
    new ProfileMenu('ℹ️', '关于鸿蒙优选', '')
  ];

  private avatarText(): string {
    if (this.token.length === 0) {
      return 'H';
    }
    return this.userName.length > 0 ? this.userName.substring(0, 1) : 'H';
  }

  private openMenu(menu: ProfileMenu): void {
    if (menu.route.length > 0) {
      RouterUtil.push(menu.route);
      return;
    }
    if (menu.title === '关于鸿蒙优选') {
      AlertDialog.show({
        title: '关于鸿蒙优选',
        message: 'HarmonyOS 电子商城课程大作业\n版本 1.0.0\n技术栈：ArkTS + ArkUI + Stage 模型',
        confirm: {
          value: '知道了',
          action: () => {
          }
        }
      });
      return;
    }
    ToastUtil.show(`${menu.title}模块正在建设中`);
  }

  @Builder
  StatItem(label: string, value: number, onTap: () => void) {
    Column() {
      Text(value.toString())
        .fontSize(18)
        .fontWeight(FontWeight.Bold)
        .fontColor(Color.White)
      Text(label)
        .fontSize(11)
        .fontColor('#DCE6FF')
        .margin({ top: 2 })
    }
    .layoutWeight(1)
    .onClick(() => {
      onTap();
    })
  }

  @Builder
  TopArea() {
    Column() {
      Row() {
        Text(this.avatarText())
          .fontSize(24)
          .fontWeight(FontWeight.Bold)
          .fontColor(AppTheme.PRIMARY)
          .width(60)
          .height(60)
          .textAlign(TextAlign.Center)
          .lineHeight(60)
          .backgroundColor(Color.White)
          .borderRadius(30)

        Column() {
          if (this.token.length === 0) {
            Text('点击登录')
              .fontSize(19)
              .fontWeight(FontWeight.Bold)
              .fontColor(Color.White)
              .onClick(() => {
                RouterUtil.push(RouteConstants.LOGIN);
              })
            Text('登录后同步订单、收藏与优惠券')
              .fontSize(11)
              .fontColor('#DCE6FF')
              .margin({ top: 4 })
          } else {
            Text(this.userName)
              .fontSize(19)
              .fontWeight(FontWeight.Bold)
              .fontColor(Color.White)
            Text('鸿蒙优选会员 · 尊享生态权益')
              .fontSize(11)
              .fontColor('#DCE6FF')
              .margin({ top: 4 })
          }
        }
        .alignItems(HorizontalAlign.Start)
        .margin({ left: 12 })

        Blank()

        Text('设置')
          .fontSize(12)
          .fontColor('#DCE6FF')
          .onClick(() => {
            ToastUtil.show('设置页面由成员D继续完善');
          })
      }
      .width('100%')

      Row() {
        this.StatItem('收藏', FavoriteService.count(), () => {
          RouterUtil.push(RouteConstants.FAVORITES);
        })
        this.StatItem('订单', OrderService.getOrders().length, () => {
          RouterUtil.push(RouteConstants.ORDER_LIST);
        })
        this.StatItem('购物车', this.cartCount, () => {
          ToastUtil.show('请通过底部导航进入购物车');
        })
      }
      .width('100%')
      .margin({ top: 18 })
    }
    .width('100%')
    .height(178)
    .padding({ left: 20, right: 20, top: 18 })
    .linearGradient({
      angle: 135,
      colors: [['#2F6BFF', 0.0], ['#5B8DFF', 1.0]]
    })
  }

  @Builder
  OrderCard() {
    Column() {
      Row() {
        Text('我的订单')
          .fontSize(15)
          .fontWeight(FontWeight.Bold)
          .fontColor(AppTheme.TEXT_PRIMARY)
        Blank()
        Text('全部订单 ›')
          .fontSize(11)
          .fontColor(AppTheme.TEXT_TERTIARY)
          .onClick(() => {
            RouterUtil.push(RouteConstants.ORDER_LIST);
          })
      }
      .width('100%')

      Row() {
        this.OrderStatus('💰', '待付款')
        this.OrderStatus('📦', '待发货')
        this.OrderStatus('🚚', '待收货')
        this.OrderStatus('✍️', '待评价')
      }
      .width('100%')
      .margin({ top: 16 })
    }
    .width('100%')
    .padding(14)
    .backgroundColor(Color.White)
    .borderRadius(AppTheme.RADIUS_CARD)
  }

  @Builder
  OrderStatus(icon: string, title: string) {
    Column() {
      Text(icon)
        .fontSize(20)
      Text(title)
        .fontSize(11)
        .fontColor(AppTheme.TEXT_SECONDARY)
        .margin({ top: 4 })
    }
    .layoutWeight(1)
    .onClick(() => {
      RouterUtil.push(RouteConstants.ORDER_LIST);
    })
  }

  @Builder
  MenuCard() {
    Column() {
      ForEach(this.menus, (menu: ProfileMenu, index: number) => {
        Row() {
          Text(menu.icon)
            .fontSize(17)
            .width(28)
          Text(menu.title)
            .fontSize(14)
            .fontColor(AppTheme.TEXT_PRIMARY)
            .layoutWeight(1)
          Text('›')
            .fontSize(20)
            .fontColor(AppTheme.TEXT_TERTIARY)
        }
        .width('100%')
        .height(50)
        .padding({ left: 14, right: 14 })
        .onClick(() => {
          this.openMenu(menu);
        })

        if (index < this.menus.length - 1) {
          Divider()
            .strokeWidth(0.5)
            .color(AppTheme.BORDER)
            .margin({ left: 42, right: 14 })
        }
      }, (menu: ProfileMenu) => menu.title)
    }
    .width('100%')
    .backgroundColor(Color.White)
    .borderRadius(AppTheme.RADIUS_CARD)
  }

  build() {
    Column() {
      this.TopArea()

      Column() {
        this.OrderCard()

        Column() {
          this.MenuCard()
        }
        .margin({ top: 12 })

        if (this.token.length > 0) {
          Button('退出登录')
            .width('100%')
            .height(44)
            .fontSize(14)
            .fontColor(AppTheme.DANGER)
            .backgroundColor(Color.White)
            .borderRadius(AppTheme.RADIUS_CARD)
            .margin({ top: 12 })
            .onClick(() => {
              AuthService.logout();
              ToastUtil.show('已退出登录');
            })
        }
      }
      .width('100%')
      .layoutWeight(1)
      .padding({ left: 16, right: 16, top: 12 })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTheme.BG_PAGE)
  }
}
