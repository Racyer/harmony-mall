import { Order, OrderItem } from '../model/Order';
import { OrderService } from '../service/OrderService';
import { AppTheme } from '../common/theme/AppTheme';
import { PageHeader } from '../components/PageHeader';
import { EmptyView } from '../components/EmptyView';
import { RouterUtil } from '../common/utils/RouterUtil';

@Entry
@Component
struct OrderListPage {
  @StorageLink('orders') ordersJson: string = '[]';

  private getOrders(): Order[] {
    return OrderService.getOrders();
  }

  @Builder
  OrderCard(order: Order) {
    Column() {
      Row() {
        Text(`订单号 ${order.id}`)
          .fontSize(11)
          .fontColor(AppTheme.TEXT_TERTIARY)
        Blank()
        Text(order.status)
          .fontSize(10)
          .fontColor(AppTheme.PRIMARY)
          .backgroundColor(AppTheme.PRIMARY_LIGHT)
          .borderRadius(4)
          .padding({ left: 6, right: 6, top: 2, bottom: 2 })
      }
      .width('100%')

      ForEach(order.items, (item: OrderItem) => {
        Row() {
          Text(item.name)
            .fontSize(13)
            .fontColor(AppTheme.TEXT_PRIMARY)
            .maxLines(1)
            .textOverflow({ overflow: TextOverflow.Ellipsis })
            .layoutWeight(1)
          Text(`×${item.quantity}`)
            .fontSize(11)
            .fontColor(AppTheme.TEXT_SECONDARY)
          Text(`¥${item.price.toFixed(2)}`)
            .fontSize(12)
            .fontColor(AppTheme.TEXT_PRIMARY)
            .margin({ left: 10 })
        }
        .width('100%')
        .margin({ top: 10 })
      }, (item: OrderItem) => item.productId.toString())

      Divider()
        .strokeWidth(0.5)
        .color(AppTheme.BORDER)
        .margin({ top: 10, bottom: 8 })

      Row() {
        Text(order.createdAt)
          .fontSize(10)
          .fontColor(AppTheme.TEXT_TERTIARY)
        Blank()
        Text('合计 ')
          .fontSize(11)
          .fontColor(AppTheme.TEXT_SECONDARY)
        Text(`¥${order.total.toFixed(2)}`)
          .fontSize(15)
          .fontWeight(FontWeight.Bold)
          .fontColor(AppTheme.DANGER)
      }
      .width('100%')

      Text(order.address)
        .fontSize(10)
        .fontColor(AppTheme.TEXT_TERTIARY)
        .maxLines(1)
        .textOverflow({ overflow: TextOverflow.Ellipsis })
        .width('100%')
        .margin({ top: 6 })
    }
    .width('100%')
    .padding(14)
    .backgroundColor(Color.White)
    .borderRadius(AppTheme.RADIUS_CARD)
  }

  build() {
    Column() {
      PageHeader({ title: '我的订单' })

      if (this.getOrders().length === 0) {
        EmptyView({
          icon: '📄',
          title: '还没有订单',
          subtitle: '去首页挑选商品，下单后可在这里查看',
          actionText: '返回首页',
          onAction: () => {
            RouterUtil.back();
          }
        })
      } else {
        List({ space: 10 }) {
          ForEach(this.getOrders(), (order: Order) => {
            ListItem() {
              this.OrderCard(order)
            }
          }, (order: Order) => order.id)
        }
        .width('100%')
        .layoutWeight(1)
        .padding({ left: 16, right: 16, top: 12, bottom: 12 })
      }
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTheme.BG_PAGE)
  }
}
