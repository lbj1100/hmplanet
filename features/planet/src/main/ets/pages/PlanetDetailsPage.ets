import { CommonDataSource, dynamicData,
  DynamicListItem,
  DynamicModel, StyleConstants, TabsComponent } from '@ohos/common';
import { display, router } from '@kit.ArkUI';
import { Planet } from '@ohos/common';
import { PullToRefresh, PullToRefreshConfigurator } from '@ohos/pulltorefresh';


@Entry({ routeName: 'PlanetDetailsPage' })
@Component
export struct PlanetDetailsPage {

  bottomRectHeight: string = AppStorage.get<number>('bottomRectHeight') + 'px';
  statusBarHeight: string = AppStorage.get<number>('statusBarHeight') + 'px';
  // 星球ID
  @State planetId: string = '';
  // 星球信息
  @State planetInfo?: Planet = new Planet('0', '0', '知识星球', '作者', $r('app.media.default_author_img'), $r('app.media.default_img'), '这是一个知识星球', 0, ['新星']);
  // 分类列表
  @State TypeList: string[] = [];
  // 被选中的
  @State TypeIndex: number = 0;
  // Scroll是否到底
  @State isScrollEnd: boolean = false;
  // 本地数据管理
  // private localDataManager: LocalDataManager = LocalDataManager.instance();
  @State isRefresh: boolean = true;
  // 是否加载完成
  @State isLoad: boolean = false;
  // 屏幕高度
  @State ch: number = 0;
  @State cw: number = 0;
  @State DynamicList: DynamicModel[] = [];

  private scroller: Scroller = new Scroller();



  aboutToAppear() {
    // TODO 网络请求
    this.TypeList = ['全部', '个人成长', '3', '4', '5', '6', '7', '8', '9', '10'];
    new Promise<string> ((resolve, reject) => {
      setTimeout(() => {
        this.DynamicList = dynamicData;
        resolve('加载成功');
      }, 2000);
    }).then((value) => {
      console.log('value:', value);
      this.isLoad = true;
    });

    // TODO 性能？
    let params = router.getParams() as Record<string, object>;
    this.planetInfo = params != null ? params.planet as Planet : this.planetInfo;
    // this.planetId = params.id as string;
    console.log('planetInfo:', this.planetInfo);
    // this.info = this.localDataManager.queryCommodityListById(this.commodityId);
  }

  @Builder
  PullToRefreshList() {
    List({ scroller: this.isRefresh ? this.scroller : null }) {
      LazyForEach(new CommonDataSource<DynamicModel>(this.DynamicList), (item: DynamicModel) => {
        ListItem() {
          /*Text(tag)
            .height(140)
            .fontSize(12)
            .fontColor($r('app.color.tag_font_color'))
            .backgroundColor($r('app.color.tag_bg_color'))
            .padding({
              left: $r('app.float.vp_eight'),
              right: $r('app.float.vp_eight'),
              top: $r('app.float.vp_four'),
              bottom: $r('app.float.vp_four')
            })
            .borderRadius($r('app.float.vp_one'))*/
          DynamicListItem({
            item: item
          })
        }
      })
    }
    .width(StyleConstants.FULL_WIDTH)
    .height(this.ch - 36 - 38)
    .cachedCount(3)
    .edgeEffect(EdgeEffect.None)
    .nestedScroll({
      scrollForward: NestedScrollMode.PARENT_FIRST,
      scrollBackward: NestedScrollMode.SELF_FIRST
    })
    .scrollBar(BarState.Off)
  }



  build() {
    Flex({ direction: FlexDirection.Column }) {
      // Stack() {
      //   Image(this.planetInfo?.images)
      //
      // }
      Row() {
        Row() {
          Image($r('app.media.ic_left_arrow'))
            .width(20)
            .height(20)
            .onClick(() => {
              router.back();
            })
          if (this.isScrollEnd) {
            Text(this.planetInfo?.title)
              .fontSize(20)
              .fontColor('#000000')
          }
        }

        Row() {
          Row() {
            Image($r('app.media.default_author_img'))
              .width(20)
              .height(20)
              .borderRadius(10)
              .margin({
                right: 5
              })
            Text(/*this.isRefresh +*/ '积分榜')
              .fontSize(10)
              .fontColor('#ffffff')
          }
          .height(24)
          .width(70)
          .borderRadius(12)
          .backgroundColor('#77333333')
          .justifyContent(FlexAlign.Center)
          Image($r('app.media.ic_search'))
            .width(20)
            .height(20)
            .margin({
              left: 12,
              right: 12
            })
          Image($r('app.media.ic_more'))
            .width(20)
            .height(20)
        }
      }
      .width('100%')
      .height(38)
      .justifyContent(FlexAlign.SpaceBetween)
      .padding({
        right: 8,
        left: 8
      })
      Scroll() {
        Column() {
          Row() {
            Image(this.planetInfo?.images)
              .width(70)
              .height(70)
              .borderRadius(8)
            Column() {
              Flex({ direction: FlexDirection.Row, alignItems: ItemAlign.Center, justifyContent: FlexAlign.SpaceBetween }) {
                Text(this.planetInfo?.title)
                  .fontSize(20)
                  .fontColor('#ffffff')
                  // 宽度
                  // .width(this.cw - 200)
                  .maxLines(1)
                  .textOverflow({
                    overflow: TextOverflow.Ellipsis
                  })
                Button('分享')
                  .width(70)
                  .height(30)
                  .fontColor('#ffffff')
                  .fontSize(14)
                  .backgroundColor('#aabfbfbf')
                  .borderColor('#ffffff')
                  .borderWidth(1)
                  .borderRadius(4)
              }
              .width(this.cw - 100)


              Row() {
                Stack() {
                  Image(this.planetInfo?.authorImg)
                    .width(20)
                    .height(20)
                    .borderRadius(10)
                    .backgroundColor('#ffffff')
                    .borderWidth(1)
                    .borderColor('#ffffff')
                  Image(this.planetInfo?.authorImg)
                    .width(20)
                    .height(20)
                    .borderRadius(10)
                    .backgroundColor('#ffffff')
                    .borderWidth(1)
                    .borderColor('#ffffff')
                    // .margin({
                    //   left: -3
                    // })
                    .position({
                      x: 13
                    })
                  Image(this.planetInfo?.authorImg)
                    .width(20)
                    .height(20)
                    .borderRadius(10)
                    .backgroundColor('#ffffff')
                    .borderWidth(1)
                    .borderColor('#ffffff')
                    // .margin({
                    //   left: -3
                    // })
                    .position({
                      x: 26
                    })
                }
                .width(40)
                .alignContent(Alignment.Start)

                Button() {
                  Row() {
                    Text('去提问')
                      .fontSize(12)
                      .fontColor('#ffffff')
                    Image($r('app.media.ic_right_arrow'))
                      .width(20)
                      .height(20)
                  }
                  .alignItems(VerticalAlign.Center)
                }
                .width(70)
                .height(20)
                .backgroundColor('#77333333')
                .borderColor('#000000')
                .margin({
                  left: 15
                })

              }
              .margin({
                top: 10
              })
            }
            .alignItems(HorizontalAlign.Start)
            // .height(StyleConstants.FULL_HEIGHT)

          }
          .width('100%')
          .justifyContent(FlexAlign.SpaceBetween)
          .margin({
            top: 15,
            bottom: 15
          })
          .padding({
            right: 8,
            left: 8
          })

          Column() {
            if (this.planetInfo?.columnTitle) {
              Button() {
                Row() {
                  Row() {
                    Image($r('app.media.ic_stack'))
                      .width(20)
                      .height(20)
                      .margin({
                        right: 10
                      })
                    Text(this.planetInfo?.columnTitle)
                      .fontSize(16)
                  }

                  Image($r('app.media.ic_right_triangle'))
                    .width(10)
                    .height(10)
                }
                .width('100%')
                .justifyContent(FlexAlign.SpaceBetween)
                .padding({
                  left: 10,
                  right: 10
                })
              }
              .width(StyleConstants.FULL_WIDTH)
              .height(60)
              .backgroundColor('#dddddd')
              .type(ButtonType.Normal)
              .margin({
                top: 10
              })
              .borderRadius(8)
            }

            TabsComponent({
              tabsList: this.TypeList,
              itemClick: (index: number) => {
                // this.TypeIndex = index;
                // TODO 网络请求
                this.isLoad = false;
                new Promise<string> ((resolve, reject) => {
                  setTimeout(() => {
                    this.DynamicList = dynamicData;
                    resolve('加载成功');
                  }, 2000);
                }).then((value) => {
                  console.log('value:', value);
                  this.isLoad = true;
                });
                console.log('index: ' + index)
              }
            })
              .margin({
                top: 10,
                bottom: 5
              })

            /*Flex({ direction: FlexDirection.Row }) {
              List() {
                ForEach(this.TypeList, (item: string, index: number) => {
                  ListItem() {
                    Text(item)
                      .fontColor(this.TypeIndex === index ? $r('app.color.more_page_item_focus_font') :
                      $r('app.color.more_page_item_font'))
                      .fontSize(16)
                      .fontWeight(FontWeight.Normal)
                      .padding({
                        top: $r('app.float.vp_six'),
                        bottom: $r('app.float.vp_six'),
                        left: $r('app.float.vp_eight'),
                        right: $r('app.float.vp_eight')
                      })
                      .margin({
                        left: (index === 0) ? 0 : $r('app.float.vp_six'),
                        right: (index === this.TypeList.length - 1) ? 0 : $r('app.float.vp_six')
                      })// 背景颜色选中时改变
                      .backgroundColor(index === this.TypeIndex ? $r('app.color.more_page_item_focus_bg') :
                      $r('app.color.more_page_item_bg'))// .backgroundColor($r('app.color.more_page_item_bg'))
                      .borderRadius($r('app.float.vp_eight'))
                      .onClick(() => {
                        this.TypeIndex = index;
                        // 网络请求
                      })
                  }
                })
              }
              .listDirection(Axis.Horizontal)
              .width(StyleConstants.FULL_WIDTH)
              .height($r('app.float.vp_thirtysix'))
              .alignListItem(ListItemAlign.Center)
              .align(Alignment.Center)
              .scrollBar(BarState.Off)

              Image($r('app.media.ic_right_arrow'))
                .width(20)
                .height(20)
                .backgroundColor('#ffffff')
                .alignSelf(ItemAlign.Center)
                // .alignRules({
                //   right: { anchor: '__container__', align: HorizontalAlign.End },
                //   center: { anchor: '__container__', align: VerticalAlign.Center }
                // })
            }
            .align(Alignment.Center)
            .height($r('app.float.vp_thirtysix'))*/

            if (this.isLoad) {
              PullToRefresh({
                data: this.TypeList,
                customList: () =>{ this.PullToRefreshList() },
                scroller: this.scroller,
                refreshConfigurator: new PullToRefreshConfigurator().setHasRefresh(true).setMaxTranslate(60),
                onRefresh: () => {
                  return new Promise((resolve, reject) => {
                    setTimeout(() => {
                      resolve('刷新成功');
                    }, 2000);
                  });
                },
                onLoadMore: () => {
                  return new Promise((resolve, reject) => {
                    setTimeout(() => {
                      resolve('加载成功');
                    }, 2000);
                  });
                }
              })
                .height(this.ch - 36 - 38 - 5)
            } else {
              Flex({ direction: FlexDirection.Column, alignItems: ItemAlign.Center, justifyContent: FlexAlign.Center }) {
                LoadingProgress()
                  .width(50)
                  .height(50)
                Text('加载中...')
                  .fontSize(16)
                  .fontColor('#000000')
                  .alignSelf(ItemAlign.Center)
              }
              // 100%高度减去标题栏高度，减去tab高度，减去底部高度
              .height(this.planetInfo?.columnTitle ? this.ch - 46 - 70 - 100 - 38 : this.ch - 46 - 100 - 38)

              // .alignItems(HorizontalAlign.Center)
              // .justifyContent(FlexAlign.Center)
            }
            /*List() {
              LazyForEach(new CommonDataSource<string>(this.TypeList), (tag: string) => {
                ListItem() {
                  Text(tag)
                    .height(140)
                    .fontSize(12)
                    .fontColor($r('app.color.tag_font_color'))
                    .backgroundColor($r('app.color.tag_bg_color'))
                    .padding({
                      left: $r('app.float.vp_eight'),
                      right: $r('app.float.vp_eight'),
                      top: $r('app.float.vp_four'),
                      bottom: $r('app.float.vp_four')
                    })
                    .borderRadius($r('app.float.vp_one'))
                }
              })
            }
            .width(StyleConstants.FULL_WIDTH)
            .height(this.ch - 36 - 38)
            .cachedCount(3)
            .edgeEffect(EdgeEffect.None)
            .nestedScroll({
              scrollForward: NestedScrollMode.PARENT_FIRST,
              scrollBackward: NestedScrollMode.SELF_FIRST
            })*/
          }
          .width('100%')
          .borderRadius(8)
          .backgroundColor('#ffffff')
          .padding({
            right: 8,
            left: 8
          })
        }
      }
      .scrollBar(BarState.Off)
      .scrollable(this.isLoad ? ScrollDirection.Vertical :ScrollDirection.None)
      .onReachEnd(()=>{
        this.isScrollEnd = true;
        this.isRefresh = false;
        console.log('reachEnd' + this.isRefresh);
      })
      .onReachStart(()=>{
        this.isRefresh = true;
        console.log('reachStart' + this.isRefresh);
      })
      // TODO 浪费性能吗 ？？？
      .onWillScroll((xOffset: number, yOffset: number, scrollState: ScrollState)=>{
        // console.log('scroll start');
        // console.log('xOffset:', xOffset, 'yOffset:', yOffset, 'scrollState:', scrollState);
        if (yOffset != 0 ) {
          if (this.isScrollEnd) {
            this.isScrollEnd = false;
          }
          this.isRefresh = false;
          console.log('父scroll onWillScroll');
        }
      })
    }
    .onAreaChange((oldValue: Area, newValue: Area) => {
      this.cw = new Number(newValue.width).valueOf()
      console.log('newValue:', newValue.height);
      this.ch = new Number(newValue.height).valueOf()
    })
    .padding({
      top: this.statusBarHeight,
      bottom: this.bottomRectHeight
    }) // 此处margin具体数值在实际中应与导航条区域高度保持一致
    .backgroundImage(this.planetInfo?.images)
    .backgroundImageSize(ImageSize.Cover)
    .backgroundBlurStyle(BlurStyle.Thin)
  }
}
