import { HomeView } from '../views/home/HomeView';
import { CategoryView } from '../views/category/CategoryView';
import { CartView } from '../views/cart/CartView';
import { ProfileView } from '../views/profile/ProfileView';
import { AppTheme } from '../common/theme/AppTheme';

@Entry
@Component
struct Index {
  @State currentIndex: number = 0;
  @StorageLink('cartCount') cartCount: number = 0;
  private controller: TabsController = new TabsController();

  private switchTab(index: number): void {
    this.currentIndex = index;
    this.controller.changeIndex(index);
  }

  @Builder
  TabItem(icon: Resource, title: string, index: number, showBadge: boolean) {
    Column() {
      Stack({ alignContent: Alignment.TopEnd }) {
        Image(icon)
          .width(23)
          .height(23)
          .fillColor(this.currentIndex === index ? AppTheme.PRIMARY : '#8A8F99')

        if (showBadge && this.cartCount > 0) {
          Text(this.cartCount > 99 ? '99+' : this.cartCount.toString())
            .fontSize(8)
            .fontColor(Color.White)
            .height(14)
            .constraintSize({ minWidth: 14 })
            .borderRadius(7)
            .backgroundColor(AppTheme.DANGER)
            .textAlign(TextAlign.Center)
            .lineHeight(14)
            .padding({ left: 2, right: 2 })
            .offset({ x: 7, y: -4 })
        }
      }
      .width(26)
      .height(26)

      Text(title)
        .fontSize(10)
        .fontColor(this.currentIndex === index ? AppTheme.PRIMARY : '#8A8F99')
        .fontWeight(this.currentIndex === index ? FontWeight.Medium : FontWeight.Normal)
        .margin({ top: 2 })
    }
    .width('100%')
    .height(58)
    .justifyContent(FlexAlign.Center)
  }

  build() {
    Tabs({ barPosition: BarPosition.End, index: this.currentIndex, controller: this.controller }) {
      TabContent() {
        HomeView({
          onOpenCart: () => {
            this.switchTab(2);
          }
        })
      }
      .tabBar(this.TabItem($r('app.media.ic_home'), '首页', 0, false))

      TabContent() {
        CategoryView()
      }
      .tabBar(this.TabItem($r('app.media.ic_category'), '分类', 1, false))

      TabContent() {
        CartView({
          onGoShopping: () => {
            this.switchTab(0);
          }
        })
      }
      .tabBar(this.TabItem($r('app.media.ic_cart'), '购物车', 2, true))

      TabContent() {
        ProfileView()
      }
      .tabBar(this.TabItem($r('app.media.ic_user'), '我的', 3, false))
    }
    .width('100%')
    .height('100%')
    .barHeight(58)
    .barBackgroundColor(Color.White)
    .scrollable(false)
    .animationDuration(200)
    .onChange((index: number) => {
      this.currentIndex = index;
    })
  }
}
