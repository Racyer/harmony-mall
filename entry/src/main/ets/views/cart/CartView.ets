import { CartLine } from '../../model/CartItem';
import { CartService } from '../../service/CartService';
import { AppTheme } from '../../common/theme/AppTheme';
import { RouteConstants } from '../../common/constants/RouteConstants';
import { RouterUtil } from '../../common/utils/RouterUtil';
import { EmptyView } from '../../components/EmptyView';
import { ToastUtil } from '../../common/utils/ToastUtil';

@Component
export struct CartView {
  @StorageLink('cartItems') cartItemsJson: string = '[]';
  @StorageLink('token') token: string = '';
  onGoShopping: () => void = () => {
  };

  private isAllSelected(): boolean {
    const lines: CartLine[] = CartService.getLines();
    if (lines.length === 0) {
      return false;
    }
    for (let i = 0; i < lines.length; i++) {
      if (!lines[i].selected) {
        return false;
      }
    }
    return true;
  }

  @Builder
  Header() {
    Row() {
      Column() {
        Text('购物车')
          .fontSize(23)
          .fontWeight(FontWeight.Bold)
          .fontColor(AppTheme.TEXT_PRIMARY)
        Text(`共 ${CartService.count()} 件商品`)
          .fontSize(11)
          .fontColor(AppTheme.TEXT_SECONDARY)
          .margin({ top: 2 })
      }
      .alignItems(HorizontalAlign.Start)

      Blank()

      Text('管理')
        .fontSize(13)
        .fontColor(AppTheme.TEXT_SECONDARY)
        .onClick(() => {
          ToastUtil.show('批量管理由成员C继续完善');
        })
    }
    .width('100%')
    .padding({ left: 16, right: 16, top: 12, bottom: 10 })
  }

  @Builder
  CartLineItem(line: CartLine) {
    Row() {
      Checkbox({ name: `cart_${line.product.id}`, group: 'cartGroup' })
        .select(line.selected)
        .selectedColor(AppTheme.PRIMARY)
        .width(22)
        .height(22)
        .margin({ right: 8 })
        .onChange((value: boolean) => {
          CartService.toggleSelected(line.product.id);
        })

      Image(line.product.image)
        .width(82)
        .height(82)
        .borderRadius(10)
        .objectFit(ImageFit.Cover)
        .backgroundColor(AppTheme.BG_PLACEHOLDER)

      Column() {
        Row() {
          Text(line.product.name)
            .fontSize(14)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppTheme.TEXT_PRIMARY)
            .maxLines(1)
            .textOverflow({ overflow: TextOverflow.Ellipsis })
            .layoutWeight(1)

          Text('删除')
            .fontSize(10)
            .fontColor(AppTheme.TEXT_TERTIARY)
            .padding({ left: 8 })
            .onClick(() => {
              CartService.remove(line.product.id);
              ToastUtil.show('已移出购物车');
            })
        }
        .width('100%')

        Text(line.product.subtitle)
          .fontSize(10)
          .fontColor(AppTheme.TEXT_SECONDARY)
          .maxLines(1)
          .textOverflow({ overflow: TextOverflow.Ellipsis })
          .margin({ top: 4 })

        Blank()

        Row() {
          Text('¥')
            .fontSize(10)
            .fontColor(AppTheme.DANGER)
          Text(line.product.price.toFixed(2))
            .fontSize(16)
            .fontWeight(FontWeight.Bold)
            .fontColor(AppTheme.DANGER)

          Blank()

          Row() {
            Text('−')
              .fontSize(16)
              .width(24)
              .height(24)
              .textAlign(TextAlign.Center)
              .lineHeight(24)
              .backgroundColor(AppTheme.BG_PAGE)
              .borderRadius(4)
              .onClick(() => {
                CartService.updateQuantity(line.product.id, -1);
              })

            Text(line.quantity.toString())
              .fontSize(13)
              .width(32)
              .textAlign(TextAlign.Center)

            Text('+')
              .fontSize(16)
              .width(24)
              .height(24)
              .textAlign(TextAlign.Center)
              .lineHeight(24)
              .backgroundColor(AppTheme.BG_PAGE)
              .borderRadius(4)
              .onClick(() => {
                CartService.updateQuantity(line.product.id, 1);
              })
          }
        }
        .width('100%')
      }
      .layoutWeight(1)
      .height(82)
      .alignItems(HorizontalAlign.Start)
      .padding({ left: 10 })
    }
    .width('100%')
    .padding(12)
    .backgroundColor(Color.White)
    .borderRadius(AppTheme.RADIUS_CARD)
  }

  @Builder
  BottomBar() {
    Row() {
      Checkbox({ name: 'cart_all', group: 'cartGroup' })
        .select(this.isAllSelected())
        .selectedColor(AppTheme.PRIMARY)
        .width(22)
        .height(22)
        .onChange((value: boolean) => {
          CartService.toggleAll(value);
        })
      Text('全选')
        .fontSize(13)
        .fontColor(AppTheme.TEXT_SECONDARY)
        .margin({ left: 6 })

      Blank()

      Column() {
        Text('合计')
          .fontSize(10)
          .fontColor(AppTheme.TEXT_TERTIARY)
        Row() {
          Text('¥')
            .fontSize(11)
            .fontColor(AppTheme.DANGER)
          Text(CartService.getSelectedTotal().toFixed(2))
            .fontSize(19)
            .fontWeight(FontWeight.Bold)
            .fontColor(AppTheme.DANGER)
        }
      }
      .alignItems(HorizontalAlign.End)
      .margin({ right: 12 })

      Button(`去结算(${CartService.getSelectedCount()})`)
        .height(40)
        .fontSize(14)
        .fontColor(Color.White)
        .backgroundColor(CartService.getSelectedCount() > 0 ? AppTheme.PRIMARY : '#C7D2E5')
        .borderRadius(AppTheme.RADIUS_PILL)
        .padding({ left: 18, right: 18 })
        .onClick(() => {
          if (CartService.getSelectedCount() === 0) {
            ToastUtil.show('请先选择要结算的商品');
            return;
          }
          if (this.token.length === 0) {
            ToastUtil.show('请先登录');
            RouterUtil.push(RouteConstants.LOGIN);
            return;
          }
          RouterUtil.push(RouteConstants.ORDER_CONFIRM);
        })
    }
    .width('100%')
    .height(64)
    .padding({ left: 16, right: 16 })
    .backgroundColor(Color.White)
  }

  build() {
    Column() {
      this.Header()

      if (CartService.getLines().length === 0) {
        EmptyView({
          icon: '🛒',
          title: '购物车还是空的',
          subtitle: '去首页挑选几件鸿蒙生态好物吧',
          actionText: '去逛逛',
          onAction: () => {
            this.onGoShopping();
          }
        })
      } else {
        List({ space: 10 }) {
          ForEach(CartService.getLines(), (line: CartLine) => {
            ListItem() {
              this.CartLineItem(line)
            }
          }, (line: CartLine) => line.product.id.toString())
        }
        .width('100%')
        .layoutWeight(1)
        .padding({ left: 16, right: 16, bottom: 10 })

        this.BottomBar()
      }
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTheme.BG_PAGE)
  }
}
