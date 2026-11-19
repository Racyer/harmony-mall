import { Product, ProductParams } from '../model/Product';
import { ProductDataSource } from '../viewmodel/ProductDataSource';
import { ProductService } from '../service/ProductService';
import { AppConstants } from '../common/constants/AppConstants';
import { RouteConstants } from '../common/constants/RouteConstants';
import { RouterUtil } from '../common/utils/RouterUtil';
import { AppTheme } from '../common/theme/AppTheme';
import { ProductCard } from './ProductCard';

/**
 * 可复用的商品流：List + LazyForEach + 下拉刷新 + 上拉加载 + 到底提示。
 * 课程评分点全部集中在这里，修改时请同步测试三种状态。
 */
@Component
export struct ProductFeed {
  categoryId: number = 0;
  private dataSource: ProductDataSource = new ProductDataSource();
  @State isRefreshing: boolean = false;
  @State isLoading: boolean = false;
  @State hasMore: boolean = true;
  private pageIndex: number = 0;

  aboutToAppear(): void {
    this.reload();
  }

  private reload(): void {
    this.pageIndex = 0;
    const list: Product[] = ProductService.getByCategory(this.categoryId, 0, AppConstants.PAGE_SIZE);
    this.dataSource.reset(list);
    this.hasMore = list.length === AppConstants.PAGE_SIZE;
  }

  private loadMore(): void {
    if (this.isLoading || !this.hasMore) {
      return;
    }
    this.isLoading = true;
    setTimeout(() => {
      this.pageIndex++;
      const list: Product[] = ProductService.getByCategory(
        this.categoryId,
        this.pageIndex * AppConstants.PAGE_SIZE,
        AppConstants.PAGE_SIZE
      );
      this.dataSource.pushData(list);
      this.hasMore = list.length === AppConstants.PAGE_SIZE;
      this.isLoading = false;
    }, 350);
  }

  @Builder
  Footer() {
    Row() {
      if (this.isLoading) {
        LoadingProgress()
          .width(16)
          .height(16)
          .color(AppTheme.PRIMARY)
        Text('加载中...')
          .fontSize(11)
          .fontColor(AppTheme.TEXT_TERTIARY)
          .margin({ left: 6 })
      } else if (this.hasMore) {
        Text('上拉加载更多')
          .fontSize(11)
          .fontColor(AppTheme.TEXT_TERTIARY)
      } else {
        Text('— 已经到底了 —')
          .fontSize(11)
          .fontColor(AppTheme.TEXT_TERTIARY)
      }
    }
    .width('100%')
    .height(44)
    .justifyContent(FlexAlign.Center)
  }

  build() {
    Column() {
      Refresh({ refreshing: $$this.isRefreshing }) {
        List({ space: 10 }) {
          LazyForEach(this.dataSource, (item: Product) => {
            ListItem() {
              ProductCard({
                product: item,
                onTap: () => {
                  RouterUtil.push(RouteConstants.PRODUCT_DETAIL, new ProductParams(item.id));
                }
              })
            }
          }, (item: Product) => item.id.toString())

          ListItem() {
            this.Footer()
          }
        }
        .width('100%')
        .height('100%')
        .padding({ left: 16, right: 16, bottom: 12 })
        .edgeEffect(EdgeEffect.Spring)
        .onReachEnd(() => {
          this.loadMore();
        })
      }
      .onRefreshing(() => {
        setTimeout(() => {
          this.reload();
          this.isRefreshing = false;
        }, 600);
      })
      .layoutWeight(1)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTheme.BG_PAGE)
  }
}
