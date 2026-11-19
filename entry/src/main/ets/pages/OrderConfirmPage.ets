import { CartLine } from '../model/CartItem';
import { CartService } from '../service/CartService';
import { OrderService } from '../service/OrderService';
import { AppTheme } from '../common/theme/AppTheme';
import { RouteConstants } from '../common/constants/RouteConstants';
import { RouterUtil } from '../common/utils/RouterUtil';
import { ToastUtil } from '../common/utils/ToastUtil';
import { PageHeader } from '../components/PageHeader';
import { EmptyView } from '../components/EmptyView';

@Entry
@Component
struct OrderConfirmPage {
  @State lines: CartLine[] = [];
  @StorageLink('address') address: string = '';
  @StorageLink('token') token: string = '';

  aboutToAppear(): void {
    this.lines = CartService.getSelectedLines();
  }

  private total(): number {
    let total: number = 0;
    for (let i = 0; i < this.lines.length; i++) {
      total += this.lines[i].product.price * this.lines[i].quantity;
    }
    return total;
  }

  private submit(): void {
    if (this.token.length === 0) {
      ToastUtil.show('请先登录');
      RouterUtil.push(RouteConstants.LOGIN);
      return;
    }
    if (this.lines.length === 0) {
      ToastUtil.show('没有待结算的商品');
      return;
    }
    OrderService.create(this.lines, this.address);
    CartService.removeSelected();
    ToastUtil.show('下单成功');
    RouterUtil.replace(RouteConstants.ORDER_LIST);
  }

  @Builder
  AddressCard() {
    Row() {
      Text('📍')
        .fontSize(20)
        .margin({ right: 10 })
      Column() {
        Text('收货地址')
          .fontSize(11)
          .fontColor(AppTheme.TEXT_TERTIARY)
        Text(this.address.length > 0 ? this.address : '请添加收货地址')
          .fontSize(13)
          .fontColor(AppTheme.TEXT_PRIMARY)
          .margin({ top: 4 })
          .maxLines(2)
      }
      .layoutWeight(1)
      .alignItems(HorizontalAlign.Start)
      Text('›')
        .fontSize(20)
        .fontColor(AppTheme.TEXT_TERTIARY)
    }
    .width('100%')
    .padding(14)
    .backgroundColor(Color.White)
    .borderRadius(AppTheme.RADIUS_CARD)
    .onClick(() => {
      RouterUtil.push(RouteConstants.ADDRESS);
    })
  }

  @Builder
  ItemRow(line: CartLine) {
    Row() {
      Image(line.product.image)
        .width(56)
        .height(56)
        .borderRadius(8)
        .objectFit(ImageFit.Cover)
        .backgroundColor(AppTheme.BG_PLACEHOLDER)

      Column() {
        Text(line.product.name)
          .fontSize(13)
          .fontColor(AppTheme.TEXT_PRIMARY)
          .maxLines(1)
          .textOverflow({ overflow: TextOverflow.Ellipsis })
        Text(`¥${line.product.price.toFixed(2)} × ${line.quantity}`)
          .fontSize(11)
          .fontColor(AppTheme.TEXT_SECONDARY)
          .margin({ top: 6 })
      }
      .layoutWeight(1)
      .alignItems(HorizontalAlign.Start)
      .margin({ left: 10 })

      Text(`¥${(line.product.price * line.quantity).toFixed(2)}`)
        .fontSize(13)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppTheme.TEXT_PRIMARY)
    }
    .width('100%')
    .padding({ top: 10, bottom: 10 })
  }

  @Builder
  SubmitBar() {
    Row() {
      Column() {
        Text('应付金额')
          .fontSize(10)
          .fontColor(AppTheme.TEXT_TERTIARY)
        Row() {
          Text('¥')
            .fontSize(11)
            .fontColor(AppTheme.DANGER)
          Text(this.total().toFixed(2))
            .fontSize(20)
            .fontWeight(FontWeight.Bold)
            .fontColor(AppTheme.DANGER)
        }
      }
      .alignItems(HorizontalAlign.Start)
      .layoutWeight(1)

      Button('提交订单')
        .height(42)
        .fontSize(14)
        .fontColor(Color.White)
        .backgroundColor(AppTheme.PRIMARY)
        .borderRadius(AppTheme.RADIUS_PILL)
        .padding({ left: 26, right: 26 })
        .onClick(() => {
          this.submit();
        })
    }
    .width('100%')
    .height(64)
    .padding({ left: 16, right: 16 })
    .backgroundColor(Color.White)
  }

  build() {
    Column() {
      PageHeader({ title: '确认订单' })

      if (this.lines.length === 0) {
        EmptyView({
          icon: '📦',
          title: '没有待结算的商品',
          subtitle: '先去购物车勾选心仪好物',
          actionText: '返回上一页',
          onAction: () => {
            RouterUtil.back();
          }
        })
      } else {
        Scroll() {
          Column() {
            this.AddressCard()

            Column() {
              Text('商品清单')
                .fontSize(14)
                .fontWeight(FontWeight.Bold)
                .fontColor(AppTheme.TEXT_PRIMARY)
                .width('100%')

              ForEach(this.lines, (line: CartLine) => {
                this.ItemRow(line)
              }, (line: CartLine) => line.product.id.toString())

              Divider()
                .strokeWidth(0.5)
                .color(AppTheme.BORDER)
                .margin({ top: 6, bottom: 6 })

              Row() {
                Text('商品金额')
                  .fontSize(12)
                  .fontColor(AppTheme.TEXT_SECONDARY)
                Blank()
                Text(`¥${this.total().toFixed(2)}`)
                  .fontSize(12)
                  .fontColor(AppTheme.TEXT_PRIMARY)
              }
              .width('100%')
              .margin({ top: 4 })

              Row() {
                Text('运费')
                  .fontSize(12)
                  .fontColor(AppTheme.TEXT_SECONDARY)
                Blank()
                Text('免运费')
                  .fontSize(12)
                  .fontColor(AppTheme.SUCCESS)
              }
              .width('100%')
              .margin({ top: 8 })
            }
            .width('100%')
            .padding(14)
            .backgroundColor(Color.White)
            .borderRadius(AppTheme.RADIUS_CARD)
            .margin({ top: 12 })
            .alignItems(HorizontalAlign.Start)
          }
          .width('100%')
          .padding({ left: 16, right: 16, bottom: 16 })
        }
        .width('100%')
        .layoutWeight(1)
        .scrollBar(BarState.Off)

        this.SubmitBar()
      }
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTheme.BG_PAGE)
  }
}
