import { BuilderNameConstants, RouterModule, RouterNameConstants } from '@ohos/routermodule';

@Component
struct Sys_message {
  bottomRectHeight: string = AppStorage.get<number>('bottomRectHeight') + 'px';
  statusBarHeight: string = AppStorage.get<number>('statusBarHeight') + 'px';
  @State message: string = '系统消息';
  private arr: number[] = [1]

  build() {
    NavDestination() {
      Column() {
        Row() {
          RelativeContainer() {

            Button() {
              Image($r('app.media.left_back'))
                .width(17)
                .height(15)
                .align(Alignment.Start)
            }
            .onClick(() => {
              RouterModule.pop(RouterNameConstants.PHONE_HAP)
            })
            .backgroundColor(Color.Transparent)
            .width('5%')
            .height('50%')
            .margin({ left: 10 })
            .alignRules({
              left: { anchor: "__container__", align: HorizontalAlign.Start },
              center: { anchor: "__container__", align: VerticalAlign.Center },
            })

            Text("系统消息")
              .fontSize(15)// .fontWeight(FontWeight.Bold)
              .alignRules({
                middle: { anchor: '__container__', align: HorizontalAlign.Center },
                center: { anchor: "__container__", align: VerticalAlign.Center }
              })
          }
          .height('7%')
          .width('100%')
        }

        Row() {
          //如果没有私信，就显示没有私信，有私信就显示私信
          if (this.arr.length == 0) {
            Column() {
              Image($r('app.media.no_notes'))
                .width(120)
                .height(100)

              Blank()
                .height(10)

              Text("这里空空如也")
                .fontSize(15)// .fontWeight(FontWeight.Bold)
                  // .textAlign(TextAlign.Center)
                .fontColor(Color.Gray)
            }
            .width('100%')
            .height('40%')

          } else {
            Column() {
              List() {
                ForEach(this.arr, () => {
                  ListItem() {
                    Row() {
                      Column() {
                        Image($r('app.media.world_green'))
                          .width(20)
                          .height(20)
                          .borderRadius(25)
                          .align(Alignment.TopStart)
                          .zIndex(1)
                          .border({
                            width: 0.5,
                            color: 0xe6e6e6
                          })
                      }
                      .height('6%')

                      Blank()
                        .width(10)

                      Column() {
                        Row() {
                          Text('「鸿蒙学习社区(HarmonyOS Next)」的高质量主题已为你整理好，点击立刻查看~')
                            .fontSize(14)
                            .lineHeight(20)
                        }
                        .width('80%')

                        Blank()
                          .height(5)

                        Column() {
                          Row() {
                            Row() {
                              Text('2021-08-01')
                                .fontColor(Color.Gray)
                                .fontSize(10)
                            }

                            Row() {
                              Text('系统消息')
                                .fontColor(Color.Gray)
                                .fontSize(10)
                            }
                          }
                          .width('80%')
                          .justifyContent(FlexAlign.SpaceBetween)
                        }

                        .justifyContent(FlexAlign.SpaceBetween)
                      }

                    }

                  }
                  .align(Alignment.Center)
                  .width('100%')
                })
              }
              .width('100%')
              .height('100%')
              .listDirection(Axis.Vertical) // 排列方向
              .scrollBar(BarState.Off)
              .divider({
                strokeWidth: 2,
                color: 0xf5f6f8,
                startMargin: 15,
                endMargin: 15
              }) // 每行之间的分界线
            }
          }
        }
        .width('100%')
        .height('100%')
      }
      .padding({
        // top: this.statusBarHeight,
        // bottom: this.bottomRectHeight
      }) // 此处margin具体数值在实际中应与导航条区域高度保持一致}
    }
    .hideTitleBar(true)
  }
}


@Builder
function harBuilder(value: object) {
  Sys_message()
}

const builderName = BuilderNameConstants.HARDYNAMIC_SYSMAG;
if (!RouterModule.getBuilder(builderName)) {
  let builder: WrappedBuilder<[object]> = wrapBuilder(harBuilder);
  RouterModule.registerBuilder(builderName, builder);
}

