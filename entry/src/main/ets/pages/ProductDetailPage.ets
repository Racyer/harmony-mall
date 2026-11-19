import { router } from '@kit.ArkUI';
import { Product, ProductParams } from '../model/Product';
import { PRODUCTS } from '../data/MockData';
import { ProductService } from '../service/ProductService';
import { CartService } from '../service/CartService';
import { FavoriteService } from '../service/FavoriteService';
import { AppTheme } from '../common/theme/AppTheme';
import { RouteConstants } from '../common/constants/RouteConstants';
import { RouterUtil } from '../common/utils/RouterUtil';
import { ToastUtil } from '../common/utils/ToastUtil';
import { PageHeader } from '../components/PageHeader';
import { EmptyView } from '../components/EmptyView';

@Entry
@Component
struct ProductDetailPage {
  @State product: Product = PRODUCTS[0];
  @State found: boolean = false;
  @State isFavorite: boolean = false;

  aboutToAppear(): void {
    const params: ProductParams = router.getParams() as ProductParams;
    if (params !== undefined && params !== null) {
      const target: Product | undefined = ProductService.getById(params.id);
      if (target !== undefined) {
        this.product = target;
        this.found = true;
        this.isFavorite = FavoriteService.isFavorite(target.id);
      }
    }
  }

  private addToCart(): void {
    CartService.add(this.product.id, 1);
    ToastUtil.show('已加入购物车');
  }

  @Builder
  TagChip(tag: string) {
    Text(tag)
      .fontSize(10)
      .fontColor(AppTheme.PRIMARY)
      .backgroundColor(AppTheme.PRIMARY_LIGHT)
      .borderRadius(4)
      .padding({ left: 7, right: 7, top: 3, bottom: 3 })
      .margin({ right: 6 })
  }

  @Builder
  ServiceItem(icon: string, title: string, subtitle: string) {
    Column() {
      Text(icon)
        .fontSize(17)
      Text(title)
        .fontSize(11)
        .fontColor(AppTheme.TEXT_PRIMARY)
        .margin({ top: 4 })
      Text(subtitle)
        .fontSize(9)
        .fontColor(AppTheme.TEXT_TERTIARY)
        .margin({ top: 2 })
    }
    .layoutWeight(1)
  }

  @Builder
  BottomBar() {
    Row({ space: 10 }) {
      Column() {
        Text(this.isFavorite ? '♥' : '♡')
          .fontSize(22)
          .fontColor(this.isFavorite ? AppTheme.DANGER : AppTheme.TEXT_SECONDARY)
        Text(this.isFavorite ? '已收藏' : '收藏')
          .fontSize(9)
          .fontColor(AppTheme.TEXT_TERTIARY)
          .margin({ top: 1 })
      }
      .width(48)
      .onClick(() => {
        this.isFavorite = FavoriteService.toggle(this.product.id);
        ToastUtil.show(this.isFavorite ? '已收藏' : '已取消收藏');
      })

      Button('加入购物车')
        .layoutWeight(1)
        .height(42)
        .fontSize(14)
        .fontColor(AppTheme.PRIMARY)
        .backgroundColor(AppTheme.PRIMARY_LIGHT)
        .borderRadius(AppTheme.RADIUS_PILL)
        .onClick(() => {
          this.addToCart();
        })

      Button('立即购买')
        .layoutWeight(1)
        .height(42)
        .fontSize(14)
        .fontColor(Color.White)
        .backgroundColor(AppTheme.PRIMARY)
        .borderRadius(AppTheme.RADIUS_PILL)
        .onClick(() => {
          CartService.toggleAll(false);
          this.addToCart();
          RouterUtil.push(RouteConstants.ORDER_CONFIRM);
        })
    }
    .width('100%')
    .height(64)
    .padding({ left: 12, right: 12 })
    .backgroundColor(Color.White)
  }

  build() {
    Column() {
      PageHeader({ title: '商品详情' })

      if (this.found) {
        Scroll() {
          Column() {
            Image(this.product.image)
              .width('100%')
              .height(330)
              .objectFit(ImageFit.Contain)
              .backgroundColor(Color.White)

            Column() {
              Row() {
                ForEach(this.product.tags, (tag: string) => {
                  this.TagChip(tag)
                }, (tag: string) => tag)
              }
              .width('100%')

              Text(this.product.name)
                .fontSize(21)
                .fontWeight(FontWeight.Bold)
                .fontColor(AppTheme.TEXT_PRIMARY)
                .margin({ top: 8 })

              Text(this.product.subtitle)
                .fontSize(12)
                .fontColor(AppTheme.TEXT_SECONDARY)
                .margin({ top: 6 })

              Row() {
                Text('¥')
                  .fontSize(14)
                  .fontColor(AppTheme.DANGER)
                Text(this.product.price.toFixed(2))
                  .fontSize(30)
                  .fontWeight(FontWeight.Bold)
                  .fontColor(AppTheme.DANGER)
                Text(`¥${this.product.originalPrice.toFixed(2)}`)
                  .fontSize(11)
                  .fontColor(AppTheme.TEXT_TERTIARY)
                  .decoration({ type: TextDecorationType.LineThrough, color: AppTheme.TEXT_TERTIARY })
                  .margin({ left: 8 })
                Blank()
                Text(`已售 ${this.product.sales}`)
                  .fontSize(11)
                  .fontColor(AppTheme.TEXT_TERTIARY)
              }
              .width('100%')
              .margin({ top: 12 })

              Row() {
                Text(`评分 ${this.product.rating.toFixed(1)}`)
                  .fontSize(11)
                  .fontColor(AppTheme.WARNING)
                Text('· 鸿蒙优选自营')
                  .fontSize(11)
                  .fontColor(AppTheme.TEXT_SECONDARY)
                  .margin({ left: 8 })
              }
              .width('100%')
              .margin({ top: 6 })
            }
            .width('100%')
            .padding(16)
            .backgroundColor(Color.White)
            .margin({ top: 10 })

            Row() {
              this.ServiceItem('✅', '正品保障', '官方授权')
              this.ServiceItem('🚚', '极速发货', '48 小时内')
              this.ServiceItem('🛡️', '无忧售后', '7 天无理由')
            }
            .width('100%')
            .padding({ top: 14, bottom: 14 })
            .backgroundColor(Color.White)
            .margin({ top: 10 })

            Column() {
              Text('商品介绍')
                .fontSize(15)
                .fontWeight(FontWeight.Bold)
                .fontColor(AppTheme.TEXT_PRIMARY)
              Text(this.product.description)
                .fontSize(13)
                .fontColor(AppTheme.TEXT_SECONDARY)
                .lineHeight(22)
                .margin({ top: 8 })
            }
            .width('100%')
            .alignItems(HorizontalAlign.Start)
            .padding(16)
            .backgroundColor(Color.White)
            .margin({ top: 10, bottom: 12 })
          }
          .width('100%')
        }
        .width('100%')
        .layoutWeight(1)
        .scrollBar(BarState.Off)
        .backgroundColor(AppTheme.BG_PAGE)

        this.BottomBar()
      } else {
        EmptyView({
          icon: '🔍',
          title: '商品不存在',
          subtitle: '它可能已经下架了',
          actionText: '返回上一页',
          onAction: () => {
            RouterUtil.back();
          }
        })
      }
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTheme.BG_PAGE)
  }
}
