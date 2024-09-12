import { listTouchEvent, RefreshModel } from '../common/PullDownRefresh'
import { CommonConstant, PageState } from '../common/CommonConstant'
import { PullToRefresh } from '@ohos/pulltorefresh';
import { httpRequestGet, Api, ResponseResult, CommonConstant as Const } from '@ohos/network';

let touch = 0;

@Entry
@Component
struct Test {
  @State refresher: RefreshModel = new RefreshModel();
  @State imageOffsetY: number = 0;
  @State isRefreshing: boolean = false;
  @State myScale: number = 1;

  changeCategory() {
    this.refresher.currentPage = 1;
    this.refresher.pageState = PageState.Success;
    // NewsViewModel.getNewsList(this.newsModel.currentPage, this.newsModel.pageSize, Const.GET_NEWS_LIST)
    //   .then((data: NewsData[]) => {
    //     this.newsModel.pageState = PageState.Success;
    //     if (data.length === this.newsModel.pageSize) {
    //       this.newsModel.currentPage++;
    //       this.newsModel.hasMore = true;
    //     } else {
    //       this.newsModel.hasMore = false;
    //     }
    //     this.newsModel.newsData = data;
    //   })
    //   .catch((err: string | Resource) => {
    //     promptAction.showToast({
    //       message: err,
    //       duration: Const.ANIMATION_DURATION
    //     });
    //     this.newsModel.pageState = PageState.Fail;
    //   });
  }

  handleTouch(event: TouchEvent | undefined): void {
    if (event) {
      // 记录按下时的Y坐标
      switch (event.type) {
        case TouchType.Down:
          touch = event.touches[0].y;
          console.log('down' + touch);
          break;
        case TouchType.Move:
          const distance = event.touches[0].y - touch;
          this.imageOffsetY = distance / 2; // 越拉越慢
          console.log('move' + touch);
          if (this.imageOffsetY >= CommonConstant.CUSTOM_LAYOUT_HEIGHT) {
            this.isRefreshing = true;
          } else {
            this.isRefreshing = false;
          }
          break;
        case TouchType.Up:
          touch = 0;
          if (this.isRefreshing) {
            this.imageOffsetY = CommonConstant.CUSTOM_LAYOUT_HEIGHT;
          }else {
            this.imageOffsetY = 0;
          }
          break;
        case TouchType.Cancel:
        // this.imageOffsetY = 0;
          if (this.isRefreshing) {
            this.imageOffsetY = CommonConstant.CUSTOM_LAYOUT_HEIGHT;
          } else {
            this.imageOffsetY = 0;
          }
          break;
        default:
          break;
      }
    }
  }

  networkRequest(): void {
    console.log('networkRequest');
    httpRequestGet(`${Api.SERVER}/${Api.GET_NEWS_TYPE}`).then((response: ResponseResult) => {
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
  }

  aboutToAppear(): void {
    // Request news data.
    this.networkRequest();
    this.changeCategory();
  }

  build() {
    Stack() {
      Row()
        .backgroundColor("#FFCC00")
        .width('100%')
        .height(50)
        .alignRules({
          top: { anchor: "__container__", align: VerticalAlign.Top },
          left: { anchor: "__container__", align: HorizontalAlign.Start }
        })
        .zIndex(2)
      Image($r('app.media.ic_pull_down_refresh'))
        .width(30)
        .height(30)
        .scale({ x: this.myScale, y: this.myScale })
        .offset({ y: this.imageOffsetY })
        .alignRules({
          top: { anchor: "__container__", align: VerticalAlign.Top },
          left: { anchor: "__container__", align: HorizontalAlign.Start }
        })
        .zIndex(1)

      Row() {
        RelativeContainer() {
          Row()
            .width(100)
            .height(100)
            .backgroundColor("#FF3333")
            .alignRules({
              top: { anchor: "__container__", align: VerticalAlign.Top },
              left: { anchor: "__container__", align: HorizontalAlign.Start }
            })
            .id("row1")

          Row()
            .width(100)
            .height(100)
            .backgroundColor("#FFCC00")
            .alignRules({
              top: { anchor: "__container__", align: VerticalAlign.Top },
              right: { anchor: "__container__", align: HorizontalAlign.End }
            })
            .id("row2")

          Row().height(100)
            .backgroundColor("#FF6633")
            .alignRules({
              top: { anchor: "row1", align: VerticalAlign.Bottom },
              left: { anchor: "row1", align: HorizontalAlign.End },
              right: { anchor: "row2", align: HorizontalAlign.Start }
            })
            .id("row3")

          Row()
            .backgroundColor("#FF9966")
            .alignRules({
              top: { anchor: "row3", align: VerticalAlign.Bottom },
              bottom: { anchor: "__container__", align: VerticalAlign.Bottom },
              left: { anchor: "__container__", align: HorizontalAlign.Start },
              right: { anchor: "row1", align: HorizontalAlign.End }
            })
            .id("row4")

          Row()
            .backgroundColor("#FF66FF")
            .alignRules({
              top: { anchor: "row3", align: VerticalAlign.Bottom },
              bottom: { anchor: "__container__", align: VerticalAlign.Bottom },
              left: { anchor: "row2", align: HorizontalAlign.Start },
              right: { anchor: "__container__", align: HorizontalAlign.End }
            })
            .id("row5")
        }
        .width(300).height(300)
        .margin({ left: 50 })
        .border({ width: 2, color: "#6699FF" })
      }
      .height('100%')
      .onTouch((event: TouchEvent | undefined) => {
        // console.log('touch');
        this.handleTouch(event);
        if (event) {
          // console.log('event' + event.type);
          if (this.refresher.pageState === PageState.Success) {
            // console.log('success');
            listTouchEvent(this.refresher, event, () => {
              return new Promise((resolve, reject) => {
                setTimeout(() => {
                  console.log('refresh');
                  this.isRefreshing = false;
                  this.imageOffsetY = 0;
                  resolve();
                }, 2000);
              });
            });
          }
        }
      })
    }
    .alignContent(Alignment.Top)
  }
}