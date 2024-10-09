import { Planet } from '@ohos/common'
import { CardList } from '../components/CardList'
import { cardData } from '../model/CardData'
import { BreakpointConstants, StyleConstants } from '@ohos/common'
import { NewPlanetComponent } from '../components/NewPlanetComponent'
import { RankingComponent } from '../components/RankingComponent'
import { Recommended } from '../components/Recommended'
import { RefreshModel, PageState, CommonConstant } from '@ohos/common'
import { listTouchEvent } from '@ohos/common'
import { RouterModule, buildRouterModel, RouterNameConstants, BuilderNameConstants } from '@ohos/routermodule'

// import { ResponseResult, httpRequestGet, Api, CommonConstant as Const } from '@ohos/network'

let touch = 0;

@Component
export struct PlanetPage {
  @StorageProp('currentBreakpoint') currentBreakpoint: string = 'sm';

  @Consume planetPathStack: NavPathStack;
  @Consume appPathStack: NavPathStack;
  private onClickItem = (Card: Planet) => {
    // 在另一栏窗口打开
    buildRouterModel(RouterNameConstants.PHONE_HAP, BuilderNameConstants.HARPLANET_DETAILS, new Object({
      id: Card.id,
      planet: Card
    }));
  };
  @State cardList: Planet[] = [];
  @State refresher: RefreshModel = new RefreshModel();
  @State imageOffsetY: number = 0;
  @State isRefreshing: boolean = false;
  @State myScale: number = 1;
  // 列表是否滑动到边缘
  private isScrollEdge: boolean = true;
  // 是否正在下拉
  @State isPulling: boolean = false;

  changeCategory() {
    this.refresher.currentPage = 1;
    this.refresher.pageState = PageState.Success;
  }

  dynamicLoading(): void {
    try {
      import('../pages/SearchPage');
      import('../pages/MorePage');
      import('../pages/PlanetDetailsPage');
    } catch (err) {

    }
  }

  // 下拉刷新改变状态
  handleTouch(event: TouchEvent | undefined): void {
    if (event) {
      // 记录按下时的Y坐标
      switch (event.type) {
        case TouchType.Down:
          //
          touch = event.touches[0].y;
          console.log('touch' + touch);
          break;
        case TouchType.Move:
        // 只有下拉才会触发
          if (event.touches[0].y - touch > 0) {
            this.isPulling = true;
            const distance = event.touches[0].y - touch;
            this.imageOffsetY = distance / 2; // 越拉越慢
            if (this.imageOffsetY >= CommonConstant.CUSTOM_LAYOUT_HEIGHT) {
              this.isRefreshing = true;
            } else {
              this.isRefreshing = false;
            }
          }
          break;
        case TouchType.Up:
          touch = 0;
          if (this.isRefreshing) {
            this.imageOffsetY = CommonConstant.CUSTOM_LAYOUT_HEIGHT;
          } else {
            this.imageOffsetY = 0;
          }
          this.isPulling = false;
        case TouchType.Cancel:
        // this.imageOffsetY = 0;
          if (this.isRefreshing) {
            console.log('refreshing');
            this.imageOffsetY = CommonConstant.CUSTOM_LAYOUT_HEIGHT;
          } else {
            this.imageOffsetY = 0;
          }
          this.isPulling = false;
          break;
        default:
          break;
      }
      if (this.refresher.pageState === PageState.Success) {
        listTouchEvent(this.refresher, event, () => {
          console.log('refresh111');
          return new Promise((resolve, reject) => {
            setTimeout(() => {
              console.log('refresh');
              this.isRefreshing = false;
              this.imageOffsetY = 0;
              resolve();
            }, 1000);
          });
        });
      }
    }
  }

  /*networkRequest(): void {
    console.log('networkRequest');
    httpRequestGet(Api.SERVER + Api.GET_NEWS_TYPE).then((response: ResponseResult) => {
      console.log('lbj response code:', response.code);
      console.log('lbj response msg:', response.msg);
      console.log('lbj response data:', response.data);
      if (response.code === Const.SERVER_CODE_SUCCESS) {
        console.log('lbj response data:', response.data);
      } else {
        // reject(Const.TabBars_DEFAULT_NEWS_TYPES);
        console.log('lbj err response code:', response.code);
      }

    }).catch((error: ResponseResult) => {
      console.log('lbj error:', error);
    });
  }*/

  aboutToAppear(): void {
    // this.networkRequest();
    this.changeCategory();
    console.log('aboutToAppear')
    // TODO 动态获取数据（用户）
    this.cardList = cardData
    if (!this.planetPathStack) {
      this.planetPathStack = new NavPathStack();
    }
    RouterModule.createRouter(RouterNameConstants.PLANET_HAR, this.planetPathStack);
  }


  @Builder
  routerMap(builderName: string, param: object) {
    // Obtain the WrappedBuilder object based on the module name, create a page through the builder interface, and import the param parameter.
    RouterModule.getBuilder(builderName).builder(param);
  };

  build() {
    /**
     * TO NOTE: 页面导航
     * 为什么是planetPathStack
     * 在这里使用planetPathStack push 页面是在tabs里面跳转的，就是说tabs下导航栏还在
     *
     *
     * 在双栏模式中
     * 如果使用appPathStack push 页面，会在另一栏窗口打开，这样就不是在tabs里面跳转了
     * 如果使用planetPathStack push 页面，会在同一栏窗口打开，这样就只在tabs里面跳转了
     *
     * 所以这里使用appPS push 详情页，使用planetPS push 搜索页
     * 详情页在另一栏窗口打开，即右侧窗口
     * 搜索页在同一栏窗口打开（覆盖PlanetPage），即左侧窗口
     */
    Navigation(this.planetPathStack) {
      Flex({ direction: FlexDirection.Column }) {
        Stack() {
          Image($r('app.media.ic_pull_down_refresh'))
            .width(30)
            .height(30)
            .scale({ x: this.myScale, y: this.myScale })
            .offset({ y: this.imageOffsetY })
            .alignRules({
              top: { anchor: "__container__", align: VerticalAlign.Top },
              left: { anchor: "__container__", align: HorizontalAlign.Start }
            })
            .zIndex(0)
          Row() {
            Text($r('app.string.planet_title'))
              .fontSize(20)
              .fontColor('#000000')
              .fontWeight(FontWeight.Bold)
          }
          .backgroundColor('#ffffff')
          .height(50)
          .width(StyleConstants.FULL_WIDTH)
          .justifyContent(FlexAlign.Center)
          .zIndex(2)
        }

        Scroll() {
          Column() {
            Search()
              .borderRadius($r('app.float.vp_eight'))
              .margin({
                left: $r('app.float.vp_eight'),
                right: $r('app.float.vp_eight'),
                top: $r('app.float.vp_eight'),
                bottom: $r('app.float.vp_eight')
              })
              .onClick(() => {
                // 在同一栏窗口打开
                buildRouterModel(RouterNameConstants.PLANET_HAR, BuilderNameConstants.HARPLANET_SEARCH);
              })
            CardList({
              cardList: $cardList,
              // 判断当前屏幕尺寸，设置每行显示的个数
              column: this.currentBreakpoint === BreakpointConstants.BREAKPOINT_LG ? StyleConstants.DISPLAY_FOUR :
                (this.currentBreakpoint === BreakpointConstants.BREAKPOINT_MD ?
                StyleConstants.DISPLAY_THREE : StyleConstants.DISPLAY_TWO),
              // column: StyleConstants.DISPLAY_TWO,
              onClickItem: (data: Planet): void => this.onClickItem(data)
            })
              .zIndex(-1)
            NewPlanetComponent()
            RankingComponent()
            Recommended({
              recommendedList: cardData
            })
          }
          .margin({
            left: $r('app.float.vp_eight'),
            right: $r('app.float.vp_eight')
          })
        }
        .scrollBar(BarState.Off)
        .scrollable(this.isPulling ? ScrollDirection.None : ScrollDirection.Vertical)
        .padding({
          bottom: $r('app.float.vp_twelve')
        })
        .onWillScroll(() => {
          this.isScrollEdge = false;
        })
        .onReachStart(() => {
          this.isScrollEdge = true;
        })
      }
      .backgroundColor('#ffffff')
      .width('100%')
      .height('100%')
      .onTouch((event: TouchEvent | undefined) => {
        if (!this.isScrollEdge) {
          return;
        }
        // 这个方法会在下拉刷新时触发
        this.handleTouch(event);
        if (event) {
          // console.log('event' + event.type);
        }
      })
      .onAreaChange((oldValue: Area, newValue: Area) => {
        // this.cw = new Number(newValue.width).valueOf()
        console.log('PP newValue:', newValue.width);
        // this.ch = new Number(newValue.height).valueOf()
      })
    }
    .hideTitleBar(true)
    .navDestination(this.routerMap)
  }
}


