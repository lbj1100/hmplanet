import {
  StyleConstants,
  BreakpointConstants,
  BreakpointSystem
} from '@ohos/common';
import { PageConstants } from '../constants/PageConstants';
import { TabButtonInfoModel, tabButtonInfo } from '../viewmodel/MainPageData';
import { PlanetPage } from  '@ohos/planet';
import '@ohos/planet';
import { Dynamic } from '@ohos/dynamic';
import { MePage } from '@ohos/me';
import { RouterModule, RouterModel, BuilderNameConstants, RouterNameConstants } from '@ohos/routermodule';

@Entry({ routeName: 'MainPage' })
@Component
struct MainPage {
  // @State msg:string = "home"
  @StorageProp('currentBreakpoint') currentBreakpoint: string = 'sm';
  @StorageLink('Index  Page') currentPageIndex: number = 0;
  @Provide appPathStack: NavPathStack = new NavPathStack();
  @Provide planetPathStack: NavPathStack = new NavPathStack();
  @Provide dynamicPathStack: NavPathStack = new NavPathStack();
  bottomRectHeight: string = AppStorage.get<number>('bottomRectHeight') + 'px';
  statusBarHeight: string = AppStorage.get<number>('statusBarHeight') + 'px';


  private breakpointSystem = new BreakpointSystem();
  aboutToAppear(): void {
    this.breakpointSystem.register();
    if (!this.appPathStack) {
      this.appPathStack = new NavPathStack();
    }
    RouterModule.createRouter(RouterNameConstants.PHONE_HAP, this.appPathStack);
  }

  aboutToDisappear(): void {
    this.breakpointSystem.unregister();
  }

  @Builder
  routerMap(builderName: string, param: object) {
    // Obtain the WrappedBuilder object based on the module name, create a page through the builder interface, and import the param parameter.
    RouterModule.getBuilder(builderName).builder(param);
  };


  build() {
    Navigation(this.appPathStack) {
      Column() {
        Tabs({
          barPosition: this.currentBreakpoint === BreakpointConstants.BREAKPOINT_LG ? BarPosition.Start :
          BarPosition.End,
          index: this.currentPageIndex
        }) {
          TabContent() {
            PlanetPage()
          }
          .tabBar(this.BottomNavigation(tabButtonInfo[PageConstants.HOME_INDEX]))

          TabContent() {
            // Text("NewProduct")
            Dynamic()
          }
          .tabBar(this.BottomNavigation(tabButtonInfo[PageConstants.NEW_PRODUCT_INDEX]))

          TabContent() {
            // Text("ShopCart")
            MePage()
            // Text(this.currentBreakpoint)
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
    }
    .backgroundColor($r('app.color.page_background'))
    .height('100%')
    .ignoreLayoutSafeArea([LayoutSafeAreaType.SYSTEM], [LayoutSafeAreaEdge.TOP, LayoutSafeAreaEdge.BOTTOM])
    .padding({
      top: this.statusBarHeight,
      // bottom: this.bottomRectHeight
    }) // 此处margin具体数值在实际中应与导航条区域高度保持一致
    .hideTitleBar(true)
    .navDestination(this.routerMap)
  }
  @Builder TitleNavigation() {
    Row() {
      Text('知识星球')
        .fontSize(20)
        .fontWeight(StyleConstants.FONT_WEIGHT_FIVE)
        .textAlign(TextAlign.Center)
        .fontColor(Color.Black)
    }
    .height(50)
    .width(StyleConstants.FULL_WIDTH)
    .justifyContent(FlexAlign.Center)
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