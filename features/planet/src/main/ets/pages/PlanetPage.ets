import { Planet } from '@ohos/common'
import { CardList } from '../components/CardList'
import { cardData } from '../model/CardData'
import { BreakpointConstants, StyleConstants } from '@ohos/common'
import { NewPlanetComponent } from '../components/NewPlanetComponent'
import { RankingComponent } from '../components/RankingComponent'
import { resourceManager } from '@kit.LocalizationKit'
import { Recommended } from '../components/Recommended'
import { router } from '@kit.ArkUI'
import { RefreshModel, PageState, CommonConstant } from '@ohos/common'
import { listTouchEvent } from '@ohos/common'

let touch = 0;

@Entry({ routeName: 'PlanetPage' })
@Component
export struct PlanetPage {
  @StorageProp('currentBreakpoint') currentBreakpoint: string = 'sm';
  private onClickItem = (Card: Planet) => {
    router.pushNamedRoute({
      name: 'PlanetDetailsPage',
      params: {
        id: Card.id,
        planet: Card
      }
    });
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

  aboutToAppear(): void {
    this.changeCategory();
    this.dynamicLoading();
    console.log('aboutToAppear')
    this.cardList = cardData
  }

  // @Builder
  // CardItem(card: CardInfoModel) {
  //   Column() {
  //     Image(card.img)
  //       .width('100vp')
  //       .height('100vp')
  //     Text(card.title)
  //       .fontSize(20)
  //       .fontColor('#000000')
  //     Text(card.author)
  //       .fontSize(16)
  //       .fontColor('#000000')
  //   }
  //   .backgroundColor('#ffffff')
  //   // 圆角
  //   .borderRadius(6)
  // }

  build() {
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
            .padding({
              top: $r('app.float.vp_twelve'),
              bottom: $r('app.float.vp_twelve')
            })
        }
        .backgroundColor('#ffffff')
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
              router.pushNamedRoute({
                name: 'SearchPage'
              })
            })
          CardList({
            cardList: $cardList,
            column: this.currentBreakpoint === BreakpointConstants.BREAKPOINT_LG ? StyleConstants.DISPLAY_FOUR :
              (this.currentBreakpoint === BreakpointConstants.BREAKPOINT_MD ?
              StyleConstants.DISPLAY_THREE : StyleConstants.DISPLAY_TWO),
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
      .onWillScroll(()=>{
        // console.log('willScroll');
        this.isScrollEdge = false;
      })
      .onReachStart(()=>{
        // console.log('reachStart');
        this.isScrollEdge = true;
      })
    }
    .backgroundColor('#ffffff')
    .width('100%')
    .height('100%')
    .onTouch((event: TouchEvent | undefined) => {
      // console.log('touch');
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
}
