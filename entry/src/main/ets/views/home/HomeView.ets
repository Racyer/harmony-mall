import { BANNERS } from '../../data/MockData';
import { AppTheme } from '../../common/theme/AppTheme';
import { RouteConstants } from '../../common/constants/RouteConstants';
import { RouterUtil } from '../../common/utils/RouterUtil';
import { SearchParams } from '../../model/Product';
import { ProductFeed } from '../../components/ProductFeed';
import { ToastUtil } from '../../common/utils/ToastUtil';

class QuickEntry {
  icon: string = '';
  title: string = '';
  keyword: string = '';

  constructor(icon: string, title: string, keyword: string) {
    this.icon = icon;
    this.title = title;
    this.keyword = keyword;
  }
}

@Component
export struct HomeView {
  onOpenCart: () => void = () => {
  };
  @StorageLink('cartCount') cartCount: number = 0;

  private quickEntries: QuickEntry[] = [
    new QuickEntry('⚡', '每日上新', ''),
    new QuickEntry('📱', '手机专区', '手机'),
    new QuickEntry('⌚', '智能穿戴', '手表'),
    new QuickEntry('🎟️', '领券中心', '')
  ];

  private openSearch(keyword: string): void {
    RouterUtil.push(RouteConstants.SEARCH, new SearchParams(keyword));
  }

  @Builder
  Header() {
    Column() {
      Row() {
        Column() {
          Text('鸿蒙优选')
            .fontSize(23)
            .fontWeight(FontWeight.Bold)
            .fontColor(AppTheme.TEXT_PRIMARY)
          Text('HarmonyOS 生态好物')
            .fontSize(11)
            .fontColor(AppTheme.TEXT_SECONDARY)
            .margin({ top: 2 })
        }
        .alignItems(HorizontalAlign.Start)

        Blank()

        Stack({ alignContent: Alignment.TopEnd }) {
          Image($r('app.media.ic_cart'))
            .width(24)
            .height(24)
            .fillColor(AppTheme.TEXT_PRIMARY)

          if (this.cartCount > 0) {
            Text(this.cartCount > 99 ? '99+' : this.cartCount.toString())
              .fontSize(8)
              .fontColor(Color.White)
              .height(15)
              .constraintSize({ minWidth: 15 })
              .borderRadius(8)
              .backgroundColor(AppTheme.DANGER)
              .textAlign(TextAlign.Center)
              .lineHeight(15)
              .padding({ left: 3, right: 3 })
              .offset({ x: 7, y: -5 })
          }
        }
        .width(32)
        .height(32)
        .onClick(() => {
          this.onOpenCart();
        })
      }
      .width('100%')

      Row() {
        Text('🔍')
          .fontSize(14)
          .margin({ right: 6 })
        Text('搜索 手机 / 耳机 / 手表')
          .fontSize(13)
          .fontColor(AppTheme.TEXT_TERTIARY)
        Blank()
        Text('搜索')
          .fontSize(12)
          .fontColor(AppTheme.PRIMARY)
      }
      .width('100%')
      .height(38)
      .padding({ left: 12, right: 12 })
      .backgroundColor(AppTheme.BG_PLACEHOLDER)
      .borderRadius(AppTheme.RADIUS_PILL)
      .margin({ top: 10 })
      .onClick(() => {
        this.openSearch('');
      })
    }
    .width('100%')
    .padding({ left: 16, right: 16, top: 12, bottom: 8 })
  }

  @Builder
  BannerView() {
    Swiper() {
      ForEach(BANNERS, (banner: ResourceStr) => {
        Image(banner)
          .width('100%')
          .height(126)
          .borderRadius(14)
          .objectFit(ImageFit.Cover)
      }, (banner: ResourceStr, index: number) => index.toString())
    }
    .width('100%')
    .height(126)
    .autoPlay(true)
    .interval(3500)
    .loop(true)
    .indicator(true)
    .padding({ left: 16, right: 16 })
  }

  @Builder
  QuickEntries() {
    Row() {
      ForEach(this.quickEntries, (entry: QuickEntry) => {
        Column() {
          Text(entry.icon)
            .fontSize(22)
          Text(entry.title)
            .fontSize(11)
            .fontColor(AppTheme.TEXT_PRIMARY)
            .margin({ top: 4 })
        }
        .layoutWeight(1)
        .onClick(() => {
          if (entry.keyword.length > 0) {
            this.openSearch(entry.keyword);
          } else if (entry.title === '领券中心') {
            ToastUtil.show('优惠券模块由成员D负责，敬请期待');
          } else {
            this.openSearch('');
          }
        })
      }, (entry: QuickEntry) => entry.title)
    }
    .width('100%')
    .padding({ top: 10, bottom: 2 })
  }

  @Builder
  ProductTabs() {
    Tabs({ barPosition: BarPosition.Start }) {
      TabContent() {
        ProductFeed({ categoryId: 0 })
      }
      .tabBar('精选')

      TabContent() {
        ProductFeed({ categoryId: 1 })
      }
      .tabBar('手机')

      TabContent() {
        ProductFeed({ categoryId: 2 })
      }
      .tabBar('电脑')

      TabContent() {
        ProductFeed({ categoryId: 3 })
      }
      .tabBar('穿戴')

      TabContent() {
        ProductFeed({ categoryId: 4 })
      }
      .tabBar('家居')

      TabContent() {
        ProductFeed({ categoryId: 5 })
      }
      .tabBar('配件')
    }
    .width('100%')
    .layoutWeight(1)
    .barMode(BarMode.Scrollable)
    .barHeight(44)
    .scrollable(false)
    .animationDuration(200)
  }

  build() {
    Column() {
      this.Header()
      this.BannerView()
      this.QuickEntries()
      this.ProductTabs()
    }
    .width('100%')
    .height('100%')
    .backgroundColor(Color.White)
  }
}
