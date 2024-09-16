import { router } from '@kit.ArkUI'
import { pasteboard } from '@kit.BasicServicesKit';

@Entry({ routeName: 'notes' })
@Component
struct notes {
  @State message: string = '笔记';
  @State arr: number[] = [1,2];
  private count: number = 0;
  // private text: string = '123';
  bottomRectHeight: string = AppStorage.get<number>('bottomRectHeight') + 'px';
  statusBarHeight: string = AppStorage.get<number>('statusBarHeight') + 'px';


  aboutToAppear(): void {
    this.dynamicLoading();
  }

  dynamicLoading(): void {
    try {
      import('../mainpage/MePage');
      import('../notes/notes_write');
    } catch (err) {

    }
  }

  dialogController: CustomDialogController | null = new CustomDialogController({
    builder: TextCustomDialog({
      cancel: () => {
        this.onCancel()
      },
      confirm: () => {
        this.onAccept()
      }
    }),
    autoCancel: true,
    alignment: DialogAlignment.Bottom,
    customStyle: false,
    cornerRadius: 0,
    width: '107%',
    height: 290,
    maskColor: 0x99000000,
    backgroundColor: 0xf5f6f8,
  })

  // 在自定义组件即将析构销毁时将dialogController置空
  aboutToDisappear() {
    this.dialogController = null // 将dialogController置空
  }

  onCancel() {
    console.info('点击取消按钮的回调');
  }

  onAccept() {

  }

  getCurrentDate(): string {
    const date = new Date();
    const month = (date.getMonth() + 1).toString().padStart(2, '0');
    const day = date.getDate().toString().padStart(2, '0');
    return `${month}/${day}`;
  }

  build() {
    Flex({ direction: FlexDirection.Column }) {
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
              router.replaceNamedRoute({
                name: 'MePage'
              })
            })
            .backgroundColor(Color.Transparent)
            .width('5%')
            .height('50%')
            .margin({ left: 10 })
            .alignRules({
              left: { anchor: "__container__", align: HorizontalAlign.Start },
              center: { anchor: "__container__", align: VerticalAlign.Center },
            });

            if(this.arr.length == 0){
            Text(this.message)
              .fontSize(15)
              .alignRules({
                middle: { anchor: '__container__', align: HorizontalAlign.Center },
                center: { anchor: "__container__", align: VerticalAlign.Center }
              });
            }else {
              Text(this.message + ` (${this.arr.length})`)
                .fontSize(15)
                .alignRules({
                  middle: { anchor: '__container__', align: HorizontalAlign.Center },
                  center: { anchor: "__container__", align: VerticalAlign.Center }
                });
            }

            if(this.arr.length != 0) {
              Button() {
                Image($r('app.media.share'))
                  .width(17)
                  .height(17)
              }
              .margin({ right: 10 })
              .backgroundColor(Color.Transparent)
              .alignRules({
                right: { anchor: "__container__", align: HorizontalAlign.End },
                center: { anchor: "__container__", align: VerticalAlign.Center },
              })
            }
          }
          .width('100%');
        }
      }
      .height('7%')

      Row() {
        if (this.arr.length == 0) {
          Column() {
            Image($r('app.media.no_notes'))
              .width(120)
              .height(100);

            Blank()
              .height(10);

            Text("还没有发布笔记")
              .fontSize(13)
              .fontColor(Color.Gray);

            Blank()
              .height(15);

            Button('发一篇')
              .fontSize(13)
              .backgroundColor(0x18b998)
              .width(130)
              .onClick(() => {
                router.pushNamedRoute({
                  name: 'notes_write'
                })
              });

            Blank()
              .height(30)

            Blank()
              .height(5)
              .width('100%')
              .color(0xf5f5f5)

            Blank()
              .height(30)

            Text('看到好内容有感而发，发在星球又觉得有压力? 可以试试「笔记」功能~')
              .fontSize(13)
              .width('70%')
              .textAlign(TextAlign.Center)
          }

          .width('100%')
          .height('90%')
          .alignItems(HorizontalAlign.Center)
        } else {
          Row() {
            Column() {
              List({ space: 10 }) {
                ForEach(this.arr, (arr: number, index) => {
                  ListItem() {
                    Row() {
                      Column() {
                        Row() {

                          Text(this.getCurrentDate())
                            .fontSize(13)
                            .lineHeight(20)
                            .fontColor(Color.White)
                            .textAlign(TextAlign.Center)
                            .width(50)
                            .height(22)
                            .borderRadius(5)
                            .backgroundColor(0x4c4e4d)

                        }
                        .width('95%')
                        .justifyContent(FlexAlign.SpaceBetween);

                        Blank()
                          .height(10);

                        Row() {
                          Text('123')
                            .fontSize(13)
                            .width('95%')
                            .maxLines(5)
                            .textOverflow({ overflow: TextOverflow.Ellipsis })
                        }
                        .height('auto')
                        .alignItems(VerticalAlign.Top);

                        Blank()
                          .height(30);

                        Row() {
                          Row() {
                            Text('赞 ' + this.count + '，')
                              .fontColor(Color.Gray)
                              .fontSize(13)
                              .height(15)
                              .width('auto')

                            Text('评论 ' + this.count)
                              .fontColor(Color.Gray)
                              .fontSize(13)
                              .height(15)
                              .width('auto')
                          }
                          .alignItems(VerticalAlign.Center)
                          .width('95%')
                          .alignItems(VerticalAlign.Bottom);

                          Button() {
                            Image($r("app.media.more_column"))
                              .width(15)
                              .height(15)
                              .align(Alignment.End)
                          }
                          .backgroundColor(Color.Transparent)
                          .onClick(() => {
                            if (this.dialogController != null) {
                              this.dialogController.open()
                            }
                          })
                        }
                        .width('95%')
                        .justifyContent(FlexAlign.SpaceBetween);

                        Blank()
                          .height(30);

                        Blank()
                          .height(1)
                          .width('95%')
                          .color(0xf6f6f6)

                        Blank()
                          .height(10);
                      }
                      .height('80%');
                    }
                  }
                  .width('95%')
                  .height(140)
                  .backgroundColor(Color.Transparent)
                  .borderRadius(5);
                });
              }
              .alignListItem(ListItemAlign.Center)
              .width('100%')
              .height('auto')
              .listDirection(Axis.Vertical)
              .scrollBar(BarState.Off);

              Blank()
                .height(40);

              Text('没有更多内容')
                .fontSize(12)
                .width('100%')
                .fontColor(Color.Gray)
                .textAlign(TextAlign.Center);

              Button() {
                Row() {
                  Image($r('app.media.editor'))
                    .width(13)
                    .height(13)
                    .align(Alignment.Center)

                  Blank()
                    .width(5)

                  Text('发布笔记')
                    .fontSize(13)
                    .fontColor(Color.White)
                    .align(Alignment.Center)

                }
              }
              .width('34%')
              .height(40)
              .position({ x: '33%', y: "90%" })
              .backgroundColor(0x18b998)
              .onClick(() => {
                router.pushNamedRoute({
                  name: 'notes_write'
                })
              });

            }
            .width('100%')
            // .alignItems(HorizontalAlign.Start)
            .height('100%');
          }
          .height('100%')
        }
      }
      .width('100%')
      .height('100%');
    }
    .linearGradient({
      angle: 0,
      colors: [[0xffffff, 0.7], [0xe3fef5, 1.0]]
    })
    .padding({
      top: this.statusBarHeight
    })
  }
}

@CustomDialog
struct TextCustomDialog {
  controller?: CustomDialogController
  cancel: () => void = () => {
  }
  confirm: () => void = () => {
  }

  build() {

    Column() {
      Row() {
        Row() {
          Text('分享至')
            .fontSize(13)
            .fontColor(Color.Gray)
            .margin(10);
        }
      }
      .height(50)

      Row() {
        Column() {
          Row({ space: 10 }) {
            Column() {
              Button({ type: ButtonType.Normal }) {
                Image($r('app.media.startIcon'))
                  .width(25)
                  .height(25)
                  .onClick(() => {
                    this.confirm()
                  });
              }
              .width(50)
              .height(50)
              .backgroundColor(Color.White)
              .borderRadius(5)

              Text('微信好友')
                .fontSize(12)
                .margin({ top: 10, bottom: 10 })
            }

            Column() {
              Button({ type: ButtonType.Normal }) {
                Image($r('app.media.startIcon'))
                  .width(25)
                  .height(25)
                  .onClick(() => {
                    this.confirm()
                  });
              }
              .width(50)
              .height(50)
              .backgroundColor(Color.White)
              .borderRadius(5)

              Text('朋友圈')
                .fontSize(12)
                .margin({ top: 10, bottom: 10 })
            }

            Column() {
              Button({ type: ButtonType.Normal }) {
                Image($r('app.media.startIcon'))
                  .width(25)
                  .height(25)
                  .onClick(() => {
                    this.confirm()
                  });
              }
              .width(50)
              .height(50)
              .backgroundColor(Color.White)
              .borderRadius(5)

              Text('生产长图')
                .fontSize(12)
                .margin({ top: 10, bottom: 10 })
            }

            Column() {
              Button({ type: ButtonType.Normal }) {
                Image($r('app.media.startIcon'))
                  .width(25)
                  .height(25)
                  .onClick(() => {
                    this.confirm()
                  });
              }
              .width(50)
              .height(50)
              .backgroundColor(Color.White)
              .borderRadius(5)

              Text('复制链接')
                .fontSize(12)
                .margin({ top: 10, bottom: 10 })
            }
          }

          Blank()
            .height(20)

          Row({ space: 10 }) {
            Column() {
              Button({ type: ButtonType.Normal }) {
                Image($r('app.media.startIcon'))
                  .width(25)
                  .height(25)
                  .onClick(() => {
                    this.confirm()
                  });
              }
              .width(50)
              .height(50)
              .backgroundColor(Color.White)
              .borderRadius(5)

              Text('编辑')
                .fontSize(12)
                .margin({ top: 10, bottom: 10 })
            }

            Column() {
              Button({ type: ButtonType.Normal }) {
                Image($r('app.media.startIcon'))
                  .width(25)
                  .height(25)
                  .onClick(() => {
                    this.confirm()
                  });
              }
              .width(50)
              .height(50)
              .backgroundColor(Color.White)
              .borderRadius(5)

              Text('转发')
                .fontSize(12)
                .margin({ top: 10, bottom: 10 })
            }

            Column() {
              Button({ type: ButtonType.Normal }) {
                Image($r('app.media.startIcon'))
                  .width(25)
                  .height(25)
                  .onClick(() => {
                    this.confirm()
                  });
              }
              .width(50)
              .height(50)
              .backgroundColor(Color.White)
              .borderRadius(5)

              Text('删除')
                .fontSize(12)
                .margin({ top: 10, bottom: 10 })
            }
          }

          Blank()
            .height(10)

        }
        .alignItems(HorizontalAlign.Start)
        .width('90%')
      }

      Row() {
        Button({ type: ButtonType.Normal }) {
          Text('取消')
            .fontSize(13)
            .fontColor(Color.Gray)

        }
        .backgroundColor(Color.White)
        .width('107%')
        .height(40)
        //关闭弹窗
        .onClick(() => {
          this.controller?.close()
        })
      }

    }
  }
}

