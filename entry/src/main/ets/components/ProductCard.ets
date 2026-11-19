import { Product } from '../model/Product';
import { AppTheme } from '../common/theme/AppTheme';
import { PRODUCTS } from '../data/MockData';

/**
 * 通用商品卡片。首页、分类、搜索、收藏共用，保证视觉一致。
 */
@Component
export struct ProductCard {
  product: Product = PRODUCTS[0];
  onTap: () => void = () => {
  };

  build() {
    Row() {
      Image(this.product.image)
        .width(104)
        .height(104)
        .borderRadius(12)
        .objectFit(ImageFit.Cover)
        .backgroundColor(AppTheme.BG_PLACEHOLDER)

      Column() {
        Text(this.product.name)
          .fontSize(15)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppTheme.TEXT_PRIMARY)
          .maxLines(1)
          .textOverflow({ overflow: TextOverflow.Ellipsis })

        Text(this.product.subtitle)
          .fontSize(11)
          .fontColor(AppTheme.TEXT_SECONDARY)
          .maxLines(1)
          .textOverflow({ overflow: TextOverflow.Ellipsis })
          .margin({ top: 4 })

        Row() {
          ForEach(this.product.tags.slice(0, 2), (tag: string) => {
            Text(tag)
              .fontSize(9)
              .fontColor(AppTheme.PRIMARY)
              .backgroundColor(AppTheme.PRIMARY_LIGHT)
              .borderRadius(4)
              .padding({ left: 6, right: 6, top: 2, bottom: 2 })
              .margin({ right: 6 })
          }, (tag: string) => tag)
        }
        .margin({ top: 6 })

        Blank()

        Row() {
          Text('¥')
            .fontSize(11)
            .fontColor(AppTheme.DANGER)
          Text(this.product.price.toFixed(2))
            .fontSize(18)
            .fontWeight(FontWeight.Bold)
            .fontColor(AppTheme.DANGER)
          Text(`¥${this.product.originalPrice.toFixed(2)}`)
            .fontSize(10)
            .fontColor(AppTheme.TEXT_TERTIARY)
            .decoration({ type: TextDecorationType.LineThrough, color: AppTheme.TEXT_TERTIARY })
            .margin({ left: 6 })
          Blank()
          Text(`已售 ${this.product.sales}`)
            .fontSize(10)
            .fontColor(AppTheme.TEXT_TERTIARY)
        }
        .width('100%')
      }
      .layoutWeight(1)
      .height(104)
      .alignItems(HorizontalAlign.Start)
      .padding({ left: 12 })
    }
    .width('100%')
    .padding(12)
    .backgroundColor(Color.White)
    .borderRadius(AppTheme.RADIUS_CARD)
    .onClick(() => {
      this.onTap();
    })
  }
}
