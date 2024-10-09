// import { router } from '@kit.ArkUI';
import {
  BuilderNameConstants,
  buildRouterModel, RouterModel, RouterModule, RouterNameConstants } from '@ohos/routermodule';

// @Entry({ routeName: 'MePage' })
@Component
// 我的页面
export struct MePage {
  @State showSelectedArea: boolean = true;
  @Consume('mePathStack') mePathStack: NavPathStack;
  bottomRectHeight: string = AppStorage.get<number>('bottomRectHeight') + 'px';
  statusBarHeight: string = AppStorage.get<number>('statusBarHeight') + 'px';

  @Builder
  routerMap(builderName: string, param: object) {
    // Obtain the WrappedBuilder object based on the module name, create a page through the builder interface, and import the param parameter.
    RouterModule.getBuilder(builderName).builder(param);
  };

  aboutToAppear(): void {
    if (!this.mePathStack) {
      this.mePathStack = new NavPathStack();
    }
    RouterModule.createRouter(RouterNameConstants.ME_HAR, this.mePathStack);
  }

  dynamicLoading(): void {
    try {
      import('./drafts');
      import('./footprint');
      import('../notes/notes');
    } catch (err) {

    }
  }

  build() {
    Navigation(this.mePathStack) {
      Column() {
        Column() {
          Column() {
            Row() {
              Button() {
                Image($r('app.media.read'))
                  .width(15)
                  .height(15)
              }
              .backgroundColor(Color.Transparent)

              Blank()
                .width(15)

              Button() {
                Image($r('app.media.notes'))
                  .width(15)
                  .height(15)
              }
              .backgroundColor(Color.Transparent)
            }
            .alignItems(VerticalAlign.Bottom)
            .width('20%')
            .height(30)
          }
          .alignItems(HorizontalAlign.End)
          .width('100%')

          Row() {
            Row() {
              Image($r('app.media.startIcon'))
                .width(40)
                .height(40)
                .borderRadius(25)
              Blank()
                .width(10)
              // TODO 用户名
              Text('用户名')
                .fontSize(15)
            }

            Row() {
              Image($r('app.media.back'))
                .width(10)
                .height(10)
            }
          }
          .justifyContent(FlexAlign.SpaceBetween)
          .width('85%')
          .height(93)


          Column() {
            Row() {
              Button() {
                Column() {
                  // TODO 我的足迹
                  Text('1')
                    .textAlign(TextAlign.Start)
                    .fontSize(18)
                    .width('100%')

                  Blank()
                    .height(7)

                  Text('我的足迹')
                    .fontColor(Color.Gray)
                    .fontSize(10)
                    .textAlign(TextAlign.Start)
                    .width('100%')

                }
              }
              .width('21%')
              .backgroundColor(Color.Transparent)
              .stateEffect(false)
              .onClick(() => {
                buildRouterModel(RouterNameConstants.ME_HAR, BuilderNameConstants.HARME_FOOTPRINT);
                // router.replaceNamedRoute({
                //   name: 'footprint'
                // })
              })

              Button() {
                Column() {
                  // TODO 我的问答
                  Text('0')
                    .textAlign(TextAlign.Start)
                    .fontSize(18)
                    .width('100%')

                  Blank()
                    .height(7)

                  Text('我的问答')
                    .fontColor(Color.Gray)
                    .fontSize(10)
                    .textAlign(TextAlign.Start)
                    .width('100%')

                }
              }
              .width('21%')
              .backgroundColor(Color.Transparent)
              .stateEffect(false)

              Button() {
                Column() {
                  // TODO 我的收藏
                  Text('0')
                    .textAlign(TextAlign.Start)
                    .fontSize(18)
                    .width('100%')

                  Blank()
                    .height(7)

                  Text('我的收藏')
                    .fontColor(Color.Gray)
                    .fontSize(10)
                    .textAlign(TextAlign.Start)
                    .width('100%')

                }
              }
              .width('21%')
              .backgroundColor(Color.Transparent)
              .stateEffect(false)

              Button() {
                Column() {
                  // TODO 我的笔记
                  Text('0')
                    .textAlign(TextAlign.Start)
                    .fontSize(18)
                    .width('100%')

                  Blank()
                    .height(7)

                  Text('我的笔记')
                    .fontColor(Color.Gray)
                    .fontSize(10)
                    .textAlign(TextAlign.Start)
                    .width('100%')

                }
              }
              .width('21%')
              .backgroundColor(Color.Transparent)
              .stateEffect(false)
              .onClick(() => {
                buildRouterModel(RouterNameConstants.ME_HAR, BuilderNameConstants.HARME_NOTES);
                // router.replaceNamedRoute({
                //   name: 'notes'
                // })
              })

            }
            .justifyContent(FlexAlign.SpaceBetween)
            .width('85%')
          }
          .height(40)

          Blank()
            .height(10)
        }
        .width('100%')
        .height(190)
        .linearGradient({
          angle: 0,
          colors: [[0xffffff, 0.0], [0xf5fefd, 1.0]]
        })

        Blank()
          .height(5)
          .color(0xfbfbfb)

        Column() {
          Column() {
            Blank()
              .height(10)

            Button() {
              Row() {
                Row() {
                  Image($r('app.media.wallet'))
                    .width(18)
                    .height(18)
                    .margin({ bottom: 3 })

                  Blank()
                    .width(10)

                  Text('我的钱包')
                    .fontSize(13)
                }

                Row() {
                  Image($r('app.media.back'))
                    .width(10)
                    .height(10)
                }
              }
              .width('100%')
              .justifyContent(FlexAlign.SpaceBetween)
              .height(44)
            }
            .stateEffect(false)
            .backgroundColor(Color.Transparent)

            Button() {
              Row() {
                Row() {
                  Image($r('app.media.gift_card'))
                    .width(18)
                    .height(18)

                  Blank()
                    .width(10)

                  Text('礼品卡')
                    .fontSize(13)
                }

                Row() {
                  Image($r('app.media.back'))
                    .width(10)
                    .height(10)
                }
              }
              .width('100%')
              .justifyContent(FlexAlign.SpaceBetween)
              .height(44)
            }
            .stateEffect(false)
            .backgroundColor(Color.Transparent)

            Button() {
              Row() {
                Row() {
                  Image($r('app.media.drafts'))
                    .width(18)
                    .height(15)

                  Blank()
                    .width(10)

                  Text('草稿箱')
                    .fontSize(13)
                }

                Row() {
                  // TODO 草稿箱数量
                  Text('0')
                    .fontSize(13)
                    .fontColor(0Xcbcbcb)

                  Blank()
                    .width(10)

                  Image($r('app.media.back'))
                    .width(10)
                    .height(10)
                }
              }
              .width('100%')
              .justifyContent(FlexAlign.SpaceBetween)
              .height(44)
            }
            .onClick(() => {
              buildRouterModel(RouterNameConstants.ME_HAR, BuilderNameConstants.HARME_DRAFTS);
              // router.replaceNamedRoute({
              //   name: 'drafts'
              // })
            })
            .stateEffect(false)
            .backgroundColor(Color.Transparent)

            Button() {
              Row() {
                Row() {
                  Image($r('app.media.recycle'))
                    .width(18)
                    .height(15)

                  Blank()
                    .width(10)

                  Text('回收站')
                    .fontSize(13)
                }

                Row() {
                  Image($r('app.media.back'))
                    .width(10)
                    .height(10)
                }
              }
              .width('100%')
              .justifyContent(FlexAlign.SpaceBetween)
              .height(44)
            }
            .stateEffect(false)
            .backgroundColor(Color.Transparent)

            Button() {
              Row() {
                Row() {
                  Image($r('app.media.set'))
                    .width(19)
                    .height(19)

                  Blank()
                    .width(10)

                  Text('设置')
                    .fontSize(13)
                }

                Row() {
                  Image($r('app.media.back'))
                    .width(10)
                    .height(10)
                }
              }
              .width('100%')
              .justifyContent(FlexAlign.SpaceBetween)
              .height(44)
            }
            .stateEffect(false)
            .backgroundColor(Color.Transparent)

            Button() {
              Row() {
                Row() {
                  Image($r('app.media.support'))
                    .width(20)
                    .height(20)

                  Blank()
                    .width(10)

                  Text('联系客服')
                    .fontSize(13)
                }

                Row() {
                  Image($r('app.media.back'))
                    .width(10)
                    .height(10)
                }
              }
              .width('100%')
              .justifyContent(FlexAlign.SpaceBetween)
              .height(44)
            }
            .stateEffect(false)
            .backgroundColor(Color.Transparent)

          }
          .width('100%')

        }
        .width('85%')

        if (this.showSelectedArea) {
          Blank()
            .height(10)

          Column({ space: 8 }) {
            Row() {
              Row() {
                Text('你会愿意向朋友推荐知识星球吗?')
                  .fontSize(13)
                  .textAlign(TextAlign.Start)
              }

              Row() {
                Button() {
                  Image($r('app.media.close'))
                    .width(12)
                    .height(12)
                }
                .backgroundColor(Color.Transparent)
                .onClick(() => {
                  this.showSelectedArea = false;
                })
              }
            }
            .width('95%')
            .justifyContent(FlexAlign.SpaceBetween)
            .margin({ top: 8 })

            Row() {
              Row() {
                Text('不推荐')
                  .fontSize(10)
                  .fontColor(Color.Gray)
              }

              Row() {
                Text('十分推荐')
                  .fontSize(10)
                  .fontColor(Color.Gray)
              }
            }
            .width('95%')
            .justifyContent(FlexAlign.SpaceBetween)

            Row() {
              Button({ type: ButtonType.Normal }) {
                Text('1')
                  .fontSize(13)
              }
              .backgroundColor(0xf3f7f8)
              .borderRadius(25)
              .width(25)
              .height(25)

              Button({ type: ButtonType.Normal }) {
                Text('2')
                  .fontSize(13)
              }
              .backgroundColor(0xf3f7f8)
              .borderRadius(25)
              .width(25)
              .height(25)

              Button({ type: ButtonType.Normal }) {
                Text('3')
                  .fontSize(13)
              }
              .backgroundColor(0xf3f7f8)
              .borderRadius(25)
              .width(25)
              .height(25)

              Button({ type: ButtonType.Normal }) {
                Text('4')
                  .fontSize(13)
              }
              .backgroundColor(0xf3f7f8)
              .borderRadius(25)
              .width(25)
              .height(25)

              Button({ type: ButtonType.Normal }) {
                Text('5')
                  .fontSize(13)
              }
              .backgroundColor(0xf3f7f8)
              .borderRadius(25)
              .width(25)
              .height(25)

              Button({ type: ButtonType.Normal }) {
                Text('6')
                  .fontSize(13)
              }
              .backgroundColor(0xf3f7f8)
              .borderRadius(25)
              .width(25)
              .height(25)

              Button({ type: ButtonType.Normal }) {
                Text('7')
                  .fontSize(13)
              }
              .backgroundColor(0xf3f7f8)
              .borderRadius(25)
              .width(25)
              .height(25)

              Button({ type: ButtonType.Normal }) {
                Text('8')
                  .fontSize(13)
              }
              .backgroundColor(0xf3f7f8)
              .borderRadius(25)
              .width(25)
              .height(25)

              Button({ type: ButtonType.Normal }) {
                Text('9')
                  .fontSize(13)
              }
              .backgroundColor(0xf3f7f8)
              .borderRadius(25)
              .width(25)
              .height(25)

              Button({ type: ButtonType.Normal }) {
                Text('10')
                  .fontSize(13)
              }
              .backgroundColor(0xf3f7f8)
              .borderRadius(25)
              .width(25)
              .height(25)

            }
            .width('95%')
            .justifyContent(FlexAlign.SpaceBetween)
          }
          .width('90%')
          .border({
            width: 0.7,
            color: 0xe6e6e6,
            radius: 5,
          })
          .height(86)
          .linearGradient({
            angle: 0,
            colors: [[0xffffff, 0.0], [0xf5fefd, 1.0]]
          })
        } else {
          Button() {
            Row() {
              Row() {
                Image($r('app.media.questionnaire'))
                  .width(20)
                  .height(20)

                Blank()
                  .width(10)

                Text('知识星球推荐调研')
                  .fontSize(13)
              }

              Row() {
                Image($r('app.media.back'))
                  .width(10)
                  .height(10)
              }
            }
            .width('100%')
            .justifyContent(FlexAlign.SpaceBetween)
            .height(44)
          }
          .onClick(() => {
            this.showSelectedArea = true;
          })
          .stateEffect(false)
          .width('85%')
          .backgroundColor(Color.Transparent)
        }


      }
      .width('100%')
      .height('100%')
    }
    .hideTitleBar(true)
    .navDestination(this.routerMap)
  }
}