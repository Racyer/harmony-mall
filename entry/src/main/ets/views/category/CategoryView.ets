import { CATEGORIES } from '../../data/MockData';
import { Category, Product, ProductParams } from '../../model/Product';
import { ProductService } from '../../service/ProductService';
import { AppTheme } from '../../common/theme/AppTheme';
import { RouteConstants } from '../../common/constants/RouteConstants';
import { RouterUtil } from '../../common/utils/RouterUtil';
import { ProductCard } from '../../components/ProductCard';
import { SearchParams } from '../../model/Product';

@Component
export struct CategoryView {
  @State selectedId: number = 1;

  private sideCategories: Category[] = CATEGORIES.filter((item: Category) => item.id !== 0);

  private currentCategory(): Category {
    const found: Category | undefined = CATEGORIES.find((item: Category) => item.id === this.selectedId);
    return found === undefined ? CATEGORIES[1] : found;
  }

  @Builder
  Header() {
    Row() {
      Column() {
        Text('分类')
          .fontSize(23)
          .fontWeight(FontWeight.Bold)
          .fontColor(AppTheme.TEXT_PRIMARY)
        Text('按品类发现好物')
          .fontSize(11)
          .fontColor(AppTheme.TEXT_SECONDARY)
          .margin({ top: 2 })
      }
      .alignItems(HorizontalAlign.Start)

      Blank()

      Text('🔍')
        .fontSize(18)
        .width(36)
        .height(36)
        .textAlign(TextAlign.Center)
        .backgroundColor(AppTheme.BG_PLACEHOLDER)
        .borderRadius(18)
        .onClick(() => {
          RouterUtil.push(RouteConstants.SEARCH, new SearchParams(''));
        })
    }
    .width('100%')
    .padding({ left: 16, right: 16, top: 12, bottom: 10 })
  }

  build() {
    Column() {
      this.Header()

      Row() {
        Scroll() {
          Column() {
            ForEach(this.sideCategories, (category: Category) => {
              Column() {
                Text(category.icon)
                  .fontSize(20)
                Text(category.name)
                  .fontSize(12)
                  .fontColor(this.selectedId === category.id ? AppTheme.PRIMARY : AppTheme.TEXT_SECONDARY)
                  .fontWeight(this.selectedId === category.id ? FontWeight.Medium : FontWeight.Normal)
                  .margin({ top: 4 })
              }
              .width('100%')
              .height(64)
              .justifyContent(FlexAlign.Center)
              .backgroundColor(this.selectedId === category.id ? Color.White : Color.Transparent)
              .onClick(() => {
                this.selectedId = category.id;
              })
            }, (category: Category) => category.id.toString())
          }
          .width('100%')
        }
        .width(92)
        .height('100%')
        .backgroundColor('#F0F2F7')

        Column() {
          Row() {
            Text(this.currentCategory().name)
              .fontSize(16)
              .fontWeight(FontWeight.Bold)
              .fontColor(AppTheme.TEXT_PRIMARY)
            Text(this.currentCategory().desc)
              .fontSize(11)
              .fontColor(AppTheme.TEXT_TERTIARY)
              .margin({ left: 8 })
            Blank()
            Text(`${ProductService.getTotalCount(this.selectedId)} 件`)
              .fontSize(11)
              .fontColor(AppTheme.TEXT_TERTIARY)
          }
          .width('100%')
          .padding({ left: 12, right: 12, top: 12, bottom: 8 })

          List({ space: 10 }) {
            ForEach(ProductService.getByCategory(this.selectedId, 0, 50), (product: Product) => {
              ListItem() {
                ProductCard({
                  product: product,
                  onTap: () => {
                    RouterUtil.push(RouteConstants.PRODUCT_DETAIL, new ProductParams(product.id));
                  }
                })
              }
            }, (product: Product) => product.id.toString())
          }
          .width('100%')
          .layoutWeight(1)
          .padding({ left: 10, right: 12, bottom: 12 })
        }
        .layoutWeight(1)
        .height('100%')
        .backgroundColor(AppTheme.BG_PAGE)
      }
      .width('100%')
      .layoutWeight(1)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(Color.White)
  }
}
