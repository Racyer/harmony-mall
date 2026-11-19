import { Product, ProductParams } from '../model/Product';
import { FavoriteService } from '../service/FavoriteService';
import { AppTheme } from '../common/theme/AppTheme';
import { RouteConstants } from '../common/constants/RouteConstants';
import { RouterUtil } from '../common/utils/RouterUtil';
import { PageHeader } from '../components/PageHeader';
import { EmptyView } from '../components/EmptyView';
import { ProductCard } from '../components/ProductCard';

@Entry
@Component
struct FavoritesPage {
  @StorageLink('favoriteIds') favoriteIdsJson: string = '[]';

  private getProducts(): Product[] {
    return FavoriteService.getProducts();
  }

  build() {
    Column() {
      PageHeader({ title: '我的收藏' })

      if (this.getProducts().length === 0) {
        EmptyView({
          icon: '🤍',
          title: '还没有收藏商品',
          subtitle: '在商品详情页点击收藏，方便下次找到',
          actionText: '返回上一页',
          onAction: () => {
            RouterUtil.back();
          }
        })
      } else {
        List({ space: 10 }) {
          ForEach(this.getProducts(), (product: Product) => {
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
        .padding({ left: 16, right: 16, top: 12, bottom: 12 })
      }
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTheme.BG_PAGE)
  }
}
