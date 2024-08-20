import {
  StyleConstants,
  BreakpointConstants,
  BreakpointSystem
} from '@ohos/common';
import { PageConstants } from '../constants/PageConstants';
import { TabButtonInfoModel, tabButtonInfo } from '../viewmodel/MainPageData';
import { PlanetPage } from  '@ohos/planet'
import { Planet } from '@ohos/common';
import { News } from '@ohos/dynamic';

@Entry({ routeName: 'MainPage' })
@Component
struct MainPage {
  // @State msg:string = "home"
  @StorageProp('currentBreakpoint') currentBreakpoint: string = 'sm';
  @StorageLink('IndexPage') currentPageIndex: number = 0;
  bottomRectHeight: string = AppStorage.get<number>('bottomRectHeight') + 'px';
  statusBarHeight: string = AppStorage.get<number>('statusBarHeight') + 'px';


  private breakpointSystem = new BreakpointSystem();
  aboutToAppear(): void {
    this.breakpointSystem.register();
  }

  aboutToDisappear(): void {
    this.breakpointSystem.unregister();
  }


  build() {
    Column() {
      // TODO Tabs考虑换成Navigation
      Tabs({
        barPosition: this.currentBreakpoint === BreakpointConstants.BREAKPOINT_LG ? BarPosition.Start : BarPosition.End,
        index: this.currentPageIndex
      }) {
        TabContent() {
          PlanetPage()
        }
        .tabBar(this.BottomNavigation(tabButtonInfo[PageConstants.HOME_INDEX]))

        TabContent() {
          // Text("NewProduct")
          News()
        }
        .tabBar(this.BottomNavigation(tabButtonInfo[PageConstants.NEW_PRODUCT_INDEX]))

        TabContent() {
          // Text("ShopCart")

          Text(this.currentBreakpoint)
        }
        .tabBar(this.BottomNavigation(tabButtonInfo[PageConstants.SHOP_CART_INDEX]))

      }
      .barWidth(this.currentBreakpoint === BreakpointConstants.BREAKPOINT_LG ?
      $r('app.float.bar_width') : StyleConstants.FULL_WIDTH)
      .barHeight(this.currentBreakpoint === BreakpointConstants.BREAKPOINT_LG ?
      StyleConstants.SIXTY_HEIGHT : $r('app.float.vp_fifty_six'))
      .divider({
        strokeWidth: $r('app.float.divider_width'),
        color: $r('app.color.divider_color')
      })
      .vertical(this.currentBreakpoint === BreakpointConstants.BREAKPOINT_LG)
      .scrollable(false)
      .onChange((index: number) => {
        this.currentPageIndex = index;
        // if (index === PageConstants.PERSONAL_INDEX) {
        //   this.queryShopCart();
        // } else if (index === PageConstants.PERSONAL_INDEX) {
        //   this.queryOrderList();
        // }
      })
    }
    .backgroundColor($r('app.color.page_background'))
    // .height('100%')
    .padding({
      top: this.statusBarHeight,
      bottom: this.bottomRectHeight
    }) // 此处margin具体数值在实际中应与导航条区域高度保持一致
  }


  @Builder BottomNavigation(button: TabButtonInfoModel) {
    Column({ space: PageConstants.BUTTON_SPACE }) {
      Image(this.currentPageIndex === button.index ? button.selectImg : button.img)
        .objectFit(ImageFit.Contain)
        .width($r('app.float.main_image_size'))
        .height($r('app.float.main_image_size'))
      Text(button.title)
        .fontColor(this.currentPageIndex === button.index ? $r('app.color.focus_color') : Color.Black)
        .opacity(this.currentPageIndex === button.index ? StyleConstants.FULL_OPACITY : StyleConstants.SIXTY_OPACITY)
        .fontWeight(StyleConstants.FONT_WEIGHT_FIVE)
        .textAlign(TextAlign.Center)
        .fontSize($r('app.float.micro_font_size'))
    }
    .width(StyleConstants.FULL_WIDTH)
    .height(StyleConstants.FULL_HEIGHT)
    .alignItems(HorizontalAlign.Center)
    .justifyContent(FlexAlign.Center)
  }
}