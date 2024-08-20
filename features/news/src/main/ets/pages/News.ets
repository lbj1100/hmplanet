import { router } from '@kit.ArkUI'

@Entry
@Component
struct News {
  private arr: number[] = [0, 1, 2, 3, 4, 5];
  @State expandedItems: Set<number> = new Set();
  @State showMore: boolean = false
  @State showButton: boolean = false
  @State text: string = ' NEXT Beta 版本鸿蒙应用开发视频教程来了，由于平台暂时无法提交视频，需要达到一定人数，所以目前提供哗哩哔哩视频链接供大家学习，后期会在星球持续更新，学习内容包含 环境搭建、ArkTS语法、ArkUI组件、Ability开发、服务卡片、数据管理、文件管理、网络请求、分布式特性、项目等知识点，祝大家学习愉快!!!'
  @State likedItems: Set<number> = new Set();
  @State likeCounts: Map<number, number> = new Map();
  @State text1: string = '鸿蒙学习社区（HarmonyOS NEXT）'

  dialogController: CustomDialogController | null = new CustomDialogController({
    builder: CustomDialogExample({
      text1: this.text1,
      cancel: ()=> { this.onCancel() },
      confirm: ()=> { this.onAccept() }
    }),
    autoCancel: true,
    alignment: DialogAlignment.Bottom,
    customStyle: false,
    cornerRadius: { topLeft: '15vp', topRight: '15vp' , bottomLeft: '0vp', bottomRight: '0vp'},
    width: '107%',
    height: 260,
    backgroundColor: 0xf5f6f8,
    maskColor: 0x99000000,
  })
  // 在自定义组件即将析构销毁时将dialogController置空
  aboutToDisappear() {
    this.dialogController = null // 将dialogController置空
  }

  onCancel() {
    console.info('Callback when the first button is clicked')
  }

  onAccept() {
    console.info('Callback when the second button is clicked')
  }

  build() {
    Column() {
      Row() {
        RelativeContainer() {
          Text("动态")
            .fontSize(15)
            .alignRules({
              middle: { anchor: '__container__', align: HorizontalAlign.Center },
              center: { anchor: "__container__", align: VerticalAlign.Center }
            })

          Button() {
            Row() {
              Image($r('app.media.message'))
                .width(17)
                .height(15)
                .align(Alignment.Start)
                .padding({ right: 2 })
              Text('与我相关')
                .fontColor(Color.Gray)
                .fontSize(12)
            }
          }
          .onClick(()=>{
            router.pushUrl({
              url:'pages/AboutMe'
            })
          })
          .backgroundColor(0xf6f6f6)
          .width('23%')
          .height('50%')
          .margin({ right: 10 })
          .alignRules({
            right: { anchor: "__container__", align: HorizontalAlign.End },
            center: { anchor: "__container__", align: VerticalAlign.Center },
          })
        }
        .height('7%')
        .width('100%')
      }

      Column() {
        Row() {
          Button() {
            Row() {
              Column() {
                Image($r('app.media.notes_blue'))
                  .width(17)
                  .height(15)
                  .align(Alignment.Start)
                  .zIndex(1)
                  .margin({ top: 8 })
              }
              .width(30)
              .height(30)
              .borderRadius(25)
              .backgroundColor(0xeef6f9)

              .alignSelf(ItemAlign.Center)
              Blank()
                .width(10)
              Text('私信')
                .fontSize(13)
            }
          }
          .stateEffect(false)
          .backgroundColor(Color.Transparent)
          .height("7%")

          Button() {
            Image($r('app.media.back'))
              .width(10)
              .height(10)
              .align(Alignment.End)
          }
          .stateEffect(false)
          .backgroundColor(Color.Transparent)
        }
        .onClick(()=>{
          router.pushUrl({
            url:'pages/Notes'
          })
        })
        .justifyContent(FlexAlign.SpaceBetween)
        .width('93%')

        Blank()
          .height(1)
          .width('95%')
          .color(0xf5f6f8)

        Row() {
          Button() {
            Row() {
              Column() {
                Image($r('app.media.notes_green'))
                  .width(20)
                  .height(20)
                  .zIndex(1)
                  .margin({top: 5})
              }
              .width(30)
              .height(30)
              .borderRadius(25)
              .backgroundColor(0xedf8f4)
              .alignSelf(ItemAlign.Center)

              Blank()
                .width(10)
              Column() {
                Text('系统消息')
                  .fontSize(13)
                Blank()
                  .height(5)
                Text('「鸿蒙学习社区(HarmonyOS Next)」的高质量主题已...')
                  .fontSize(12)
                  .maxLines(1)
                  .fontColor(Color.Gray)
                  .textOverflow({ overflow: TextOverflow.Ellipsis })

              }
              .alignItems(HorizontalAlign.Start)
            }
          }
          .backgroundColor(Color.Transparent)
          .stateEffect(false)
          .width("85%")
          .height("9%")
          .borderRadius(20)

          Button() {
            Image($r('app.media.back'))
              .width(10)
              .height(10)
              .align(Alignment.End)
          }
          .backgroundColor(Color.Transparent)
        }
        .onClick(()=>{
          router.pushUrl({
            url:'pages/Sys_Message'
          })
        })
        .justifyContent(FlexAlign.SpaceBetween)
        .width('93%')
      }

      Blank()
        .height(7)
        .color(0xf5f6f8)

      Column() {
        List({ space: 5, initialIndex: 0 }) {
          ForEach(this.arr, (item: number) => {
            ListItem() {
              Column() {
                Row() {
                  Image($r('app.media.app_icon'))
                    .width(30)
                    .height(30)
                    .borderRadius(25)
                    .alignSelf(ItemAlign.Start)
                    .margin({ left: 5 })

                  Column() {
                    Row() {
                      Column() {
                        Text('用户名')
                          .fontSize(12)
                          .fontColor(0x65768c)
                        Text('2021-08-01')
                          .fontColor(Color.Gray)
                          .fontSize(10)
                      }
                      .alignItems(HorizontalAlign.Start)

                      Row() {
                        Button() {
                          Image($r('app.media.more'))
                            .width(10)
                            .height(10)
                        }
                        .onClick(() => {
                          if (this.dialogController != null) {
                            this.dialogController.open()
                          }
                        })
                        .backgroundColor(Color.Transparent)
                        .margin({ right: 15 })

                        Blank()
                          .width(10)
                      }
                    }
                    .width('90%')
                    .height('auto')
                    .justifyContent(FlexAlign.SpaceBetween)

                    Row() {
                      Column() {
                        Column() {
                          Row() {
                            Text(this.text)
                              .lineHeight(20)
                              .width('85%')
                              .fontSize(14)
                              .maxLines(this.expandedItems.has(item) ? undefined : 5)
                              .textOverflow({ overflow: TextOverflow.Ellipsis })
                              .fontWeight(FontWeight.Normal)
                              .textAlign(TextAlign.Start)
                              .fontColor(Color.Black)
                              .backgroundColor(Color.Transparent)
                              .padding({ top: 5 , bottom: 10 })
                          }
                          .width('95%')

                          if (this.text.split(/[\s\S]{1,27}/).length > 5) {
                            Row() {
                              Button() {
                                  Text(this.expandedItems.has(item) ? '收起' : '展开更多')
                                    .fontSize(14)
                                    .fontWeight(FontWeight.Normal)
                                    .textAlign(TextAlign.Start)
                                    .fontColor(0x65768c)
                                    .backgroundColor(Color.White)
                                    .padding({ bottom: 10 })
                                }
                                .onClick(() => {
                                  if (this.expandedItems.has(item)) {
                                    this.expandedItems.delete(item);
                                  } else {
                                    this.expandedItems.add(item);
                                  }
                                })
                            }
                            .width('95%')
                          }
                        }
                        .height('auto')

                        Image($r('app.media.app_icon'))
                          .width(60)
                          .height(60)
                          .alignSelf(ItemAlign.Start)

                      }
                      .margin({ left: 10, bottom: 10 })
                    }

                    Row() {
                      Button() {
                        Row() {
                          Image($r('app.media.app_icon'))
                            .width(15)
                            .height(15)
                            .margin({ right: 5 })
                          Text(this.text1)
                            .fontSize(10)
                            .fontWeight(FontWeight.Normal)
                            .maxLines(1)
                            .textOverflow({ overflow: TextOverflow.Ellipsis })
                            .fontColor(0x65768c)
                            .width('60%')
                        }
                        .padding({ left: 10, right: 10 })
                      }
                      .height(25)
                      .backgroundColor(0xf4f4f6)
                      .alignSelf(ItemAlign.Start)
                      .type(ButtonType.Normal)
                      .borderRadius(3)

                      Row() {
                        Row() {
                          Button() {
                            Row() {
                              Button() {
                                Image($r(this.likedItems.has(item) ? 'app.media.like_true' : 'app.media.like_false'))
                                  .width(15)
                                  .height(15)
                                  .backgroundColor(Color.White)
                              }
                              .onClick(() => {
                                if (this.likedItems.has(item)) {
                                  this.likedItems.delete(item);
                                  this.likeCounts.set(item, (this.likeCounts.get(item) || 1) - 1);
                                } else {
                                  this.likedItems.add(item);
                                  this.likeCounts.set(item, (this.likeCounts.get(item) || 0) + 1);
                                }
                              })
                              Blank()
                                .width(5)
                              Text(`${this.likeCounts.get(item) || 0}`)
                                .fontSize(10)
                                .fontWeight(FontWeight.Normal)
                                .fontColor(this.likedItems.has(item) ? 0x18b998 : 0x65768c)
                            }
                          }
                          .stateEffect(false)
                          .backgroundColor(Color.Transparent)

                          Blank()
                            .width(20)

                          Button() {
                            Row() {
                              Image($r('app.media.comment'))
                                .width(15)
                                .height(15)
                            }
                          }
                          .backgroundColor(Color.Transparent)
                        }

                        Blank()
                          .width(20)
                      }
                    }
                    .justifyContent(FlexAlign.SpaceBetween)
                    .width('90%')
                    .padding({ right: 10 })
                    .margin({ bottom: 10 })
                  }
                }
                .margin({ top: 10, left: 10 })
              }
              .backgroundColor(Color.White)
              .width('100%')
              .height('auto')
              .borderRadius(10)
            }
          }, (item: string) => item)
        }
        .padding({ top: 5, bottom: 200 })
        .listDirection(Axis.Vertical) // 排列方向
        .scrollBar(BarState.Off)
        .friction(0.6)
        .cachedCount(3)
        .divider({
          strokeWidth: 2,
          color: 0xf5f6f8,
          startMargin: 10,
          endMargin: 10
        }) // 每行之间的分界线
        .edgeEffect(EdgeEffect.Spring) // 边缘效果设置为Spring
        .backgroundColor(Color.White)
        .width('100%')
        .height('auto')
      }
    }
  }
}


@CustomDialog
struct CustomDialogExample {
  private text1 : string = '';

  controller?: CustomDialogController
  cancel: () => void = () => {
  }
  confirm: () => void = () => {
  }
  build() {
    Column() {

      Button()
        .width(60)
        .height(4)
        .backgroundColor(0xdbdcde)
        .onClick(() => {
          if (this.controller != undefined) {
            this.controller.close()
          }
        })
        .margin(15)

      Button(){
        Row() {
          Image($r('app.media.CD_like'))
            .width(15)
            .height(15)
            .align(Alignment.End)
            .margin({ left:15 })
            .onClick(() => {
              if (this.controller != undefined) {
                this.controller.close()
              }
            })

          Text('加入收藏')
            .fontSize(12)
            .align(Alignment.Start)
            .margin(10)
            .onClick(() => {
              this.confirm()
            })
        }
        .width('100%')
      }
      .type(ButtonType.Normal)
      .backgroundColor(Color.White)
      .borderRadius(5)
      .width('90%')
      .height(45)

      Button(){
        Row() {
          Image($r('app.media.CD_share'))
            .width(15)
            .height(15)
            .align(Alignment.End)
            .margin({ left:15 })
            .onClick(() => {
              if (this.controller != undefined) {
                this.controller.close()
              }
            })

          Text('分享')
            .fontSize(12)
            .align(Alignment.Start)
            .margin(10)
            .onClick(() => {
              this.confirm()
            })
        }
        .width('100%')
      }
      .type(ButtonType.Normal)
      .backgroundColor(Color.White)
      .borderRadius(5)
      .width('90%')
      .height(45)
      .margin({ top: 10 })

      Button(){
        Row() {
          Image($r('app.media.CD_unlike'))
            .width(15)
            .height(15)
            .align(Alignment.End)
            .margin({ left:15 })
            .onClick(() => {
              if (this.controller != undefined) {
                this.controller.close()
              }
            })

          Text('不看该星球：' + this.text1)
            .fontSize(12)
            .align(Alignment.Start)
            .margin(10)
            .textOverflow({ overflow: TextOverflow.Ellipsis })
            .onClick(() => {
              this.confirm()
            })
        }
        .width('100%')
      }
      .type(ButtonType.Normal)
      .backgroundColor(Color.White)
      .borderRadius(5)
      .width('90%')
      .height(45)
      .margin({ top: 10 })

      Button(){
        Row() {
          Image($r('app.media.CD_report'))
            .width(17)
            .height(17)
            .align(Alignment.End)
            .margin({ left:15 })
            .onClick(() => {
              if (this.controller != undefined) {
                this.controller.close()
              }
            })

          Text('投诉')
            .fontSize(12)
            .align(Alignment.Start)
            .margin(10)
            .onClick(() => {
              this.confirm()
            })
        }
        .width('100%')
      }
      .type(ButtonType.Normal)
      .backgroundColor(Color.White)
      .borderRadius(5)
      .width('90%')
      .height(45)
      .margin({ top: 10 })
    }
  }
}
