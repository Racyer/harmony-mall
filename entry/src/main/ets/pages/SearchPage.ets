import { router } from '@kit.ArkUI';
import { Product, ProductParams, SearchParams } from '../model/Product';
import { HOT_KEYWORDS, PRODUCTS } from '../data/MockData';
import { ProductService } from '../service/ProductService';
import { AppTheme } from '../common/theme/AppTheme';
import { RouteConstants } from '../common/constants/RouteConstants';
import { RouterUtil } from '../common/utils/RouterUtil';
import { ProductCard } from '../components/ProductCard';
import { EmptyView } from '../components/EmptyView';

@Entry
@Component
struct SearchPage {
  @State keyword: string = '';
  @State results: Product[] = PRODUCTS;

  aboutToAppear(): void {
    const params: SearchParams = router.getParams() as SearchParams;
    if (params !== undefined && params !== null) {
      this.keyword = params.keyword;
    }
    this.doSearch();
  }

  private doSearch(): void {
    this.results = ProductService.search(this.keyword);
  }

  @Builder
  HotKeywords() {
    Column() {
      Text('热门搜索')
        .fontSize(13)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppTheme.TEXT_PRIMARY)
        .width('100%')
        .margin({ bottom: 10 })

      Flex({ wrap: FlexWrap.Wrap }) {
        ForEach(HOT_KEYWORDS, (keyword: string) => {
          Text(keyword)
            .fontSize(12)
            .fontColor(AppTheme.TEXT_SECONDARY)
            .backgroundColor(AppTheme.BG_PAGE)
            .borderRadius(AppTheme.RADIUS_PILL)
            .padding({ left: 12, right: 12, top: 6, bottom: 6 })
            .margin({ right: 8, bottom: 8 })
            .onClick(() => {
              this.keyword = keyword;
              this.doSearch();
            })
        }, (keyword: string) => keyword)
      }
      .width('100%')
    }
    .width('100%')
    .padding(16)
    .alignItems(HorizontalAlign.Start)
  }

  build() {
    Column() {
      Row() {
        Text('‹')
          .fontSize(32)
          .fontColor(AppTheme.TEXT_PRIMARY)
          .width(40)
          .height(44)
          .textAlign(TextAlign.Center)
          .onClick(() => {
            RouterUtil.back();
          })

        Search({ value: $$this.keyword, placeholder: '搜索商品名称 / 品类' })
          .width('100%')
          .height(38)
          .layoutWeight(1)
          .backgroundColor(AppTheme.BG_PLACEHOLDER)
          .placeholderColor(AppTheme.TEXT_TERTIARY)
          .onChange((value: string) => {
            this.keyword = value;
            this.doSearch();
          })
          .onSubmit((value: string) => {
            this.keyword = value;
            this.doSearch();
          })

        Text('搜索')
          .fontSize(13)
          .fontColor(AppTheme.PRIMARY)
          .padding({ left: 10 })
          .onClick(() => {
            this.doSearch();
          })
      }
      .width('100%')
      .padding({ left: 8, right: 12, top: 4, bottom: 4 })
      .backgroundColor(Color.White)

      if (this.keyword.length === 0) {
        this.HotKeywords()
      }

      if (this.results.length === 0) {
        EmptyView({
          icon: '🔍',
          title: '没有找到相关商品',
          subtitle: '换个关键词试试，例如“耳机”“手表”',
          actionText: '清空搜索',
          onAction: () => {
            this.keyword = '';
            this.doSearch();
          }
        })
      } else {
        List({ space: 10 }) {
          ListItem() {
            Text(`找到 ${this.results.length} 件商品`)
              .fontSize(11)
              .fontColor(AppTheme.TEXT_TERTIARY)
              .width('100%')
              .padding({ top: 4, bottom: 2 })
          }

          ForEach(this.results, (product: Product) => {
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
        .padding({ left: 16, right: 16, bottom: 12 })
      }
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTheme.BG_PAGE)
  }
}
