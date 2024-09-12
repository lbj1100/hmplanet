import { router } from '@kit.ArkUI'
import { pasteboard } from '@kit.BasicServicesKit';

@Entry({ routeName: 'drafts' })
@Component
struct drafts {
  @State message: string = '草稿箱';
  @State arr: number[] = [1, 2, 3, 4,5,6,7,8];
  private text: string = '123';
  @State customPopup: boolean = false;
  @State popupMessage: string = '';
  dialogController: CustomDialogController | null = null;
  selectedItemIndex: number = -1;

  aboutToDisappear() {
    this.dialogController = null;
  }

  aboutToAppear(): void {
    this.dynamicLoading();
  }

  dynamicLoading(): void {
    try {
      import('../mainpage/MePage');
    } catch (err) {

    }
  }

  onCancel() {
    console.info('点击取消按钮的回调');
  }

  onAccept() {
    if (this.selectedItemIndex >= 0 && this.selectedItemIndex < this.arr.length) {
      this.arr.splice(this.selectedItemIndex, 1);
      // promptAction.showToast({ message: '已删除', bottom: 50 });
      this.popupMessage = '已删除';
      this.customPopup = true;
      this.autoClosePopup(); // 调用自动关闭方法
    }
    if (this.dialogController != null) {
      this.dialogController.close(); // 删除成功后关闭弹窗
    }
    console.info('删除索引为', this.selectedItemIndex, '的项目');
  }

  @Builder
  popupBuilder() {
    Column() {
      Row() {
        Image($r('app.media.world_green'))
          .width(17)
          .height(17)

        Blank()
          .width(10)

        Text(this.popupMessage).fontSize(12)
      }
      .alignItems(VerticalAlign.Center)
      .height('100%')
    }
    .height(45)
    .width(100)
    .padding(5)
  }

  autoClosePopup() {
    setTimeout(() => {
      this.customPopup = false;
    }, 3000);
  }

  build() {
    Flex({ direction: FlexDirection.Column }) {
      Row() {
        RelativeContainer() {
          Button() {
            Image($r('app.media.left_back'))
              .width(17)
              .height(15)
              .align(Alignment.Start)
          }
          .backgroundColor(Color.Transparent)
          .margin({ left: 10 })
          .alignRules({
            left: { anchor: "__container__", align: HorizontalAlign.Start },
            center: { anchor: "__container__", align: VerticalAlign.Center },
          })
          .onClick(() => {
            router.replaceNamedRoute({
              name: 'MainPage'
            })
          })

          Text(this.message)
            .fontSize(15)
            .alignRules({
              middle: { anchor: '__container__', align: HorizontalAlign.Center },
              center: { anchor: "__container__", align: VerticalAlign.Center }
            });
        }
        .width('100%');
      }
      .height('7%')
      .backgroundColor(0xf5f6f8)



      Row() {
        if (this.arr.length == 0) {
          Column() {
            Image($r('app.media.no_notes'))
              .width(120)
              .height(100);

            Blank()
              .height(10);

            Text("取消发布内容可以被存为草稿")
              .fontSize(15)
              .fontColor(Color.Gray);
          }
          .width('100%')
          .height('40%');
        } else {
          Row() {
            Column() {
              List({ space: 10 }) {
                ForEach(this.arr, (arr: number, index) => {
                  ListItem() {
                    Row() {
                      Column() {
                        Row() {
                          Text('鸿蒙学习社区(HarmonyOS Next)')
                            .fontSize(13)
                            .lineHeight(20);

                          Button() {
                            Image($r("app.media.more_row"))
                              .height(18)
                              .width(18);
                          }
                          .onClick(() => {
                            this.selectedItemIndex = index;
                            this.dialogController = new CustomDialogController({
                              builder: CustomDialogExample({
                                cancel: () => {
                                  this.onCancel()
                                },
                                confirm: () => {
                                  this.onAccept()
                                },
                                itemIndex: this.selectedItemIndex,
                                text: this.text,
                                showPopup: (message: string) => {
                                  this.popupMessage = message;
                                  this.customPopup = true;
                                  this.autoClosePopup(); // 调用自动关闭方法
                                },
                              }),
                              autoCancel: true,
                              alignment: DialogAlignment.Bottom,
                              customStyle: false,
                              cornerRadius: {
                                topLeft: '0vp',
                                topRight: '0vp',
                                bottomLeft: '0vp',
                                bottomRight: '0vp'
                              },
                              width: '107%',
                              height: 135,
                              backgroundColor: 0xf5f6f8,
                              maskColor: 0x66000000,
                            });
                            this.dialogController.open();
                          })
                          .backgroundColor(Color.Transparent);
                        }
                        .width('95%')
                        .justifyContent(FlexAlign.SpaceBetween);

                        Blank()
                          .height(7);

                        Row() {
                          Text('123')
                            .fontSize(12)
                            .width('95%')
                            .maxLines(2)
                            .textOverflow({ overflow: TextOverflow.Ellipsis })
                            .fontColor(Color.Gray);
                        }
                        .height('50%')
                        .alignItems(VerticalAlign.Top);

                        Row() {
                          Text('主题')
                            .fontColor(Color.Gray)
                            .fontSize(8)
                            .height(15)
                            .width(30)
                            .backgroundColor(0xf6f6f6)
                            .textAlign(TextAlign.Center)
                            .borderRadius(5);

                          Blank()
                            .width(10);

                          Text('2024/8/17 21:23')
                            .fontColor(Color.Gray)
                            .fontSize(11);
                        }
                        .alignItems(VerticalAlign.Center)
                        .width('95%')
                        .alignItems(VerticalAlign.Bottom);
                      }
                      .height('80%');
                    }
                  }
                  .width('95%')
                  .height(110)
                  .backgroundColor(Color.White)
                  .borderRadius(5);
                });
              }
              .alignListItem(ListItemAlign.Center)
              .width('100%')
              .height('auto')
              .listDirection(Axis.Vertical)
              .scrollBar(BarState.Off);

              Blank()
                .height(20);

              Text('没有更多内容')
                .fontSize(12)
                .width('100%')
                .fontColor(Color.Gray)
                .textAlign(TextAlign.Center);
            }
            .alignItems(HorizontalAlign.Start)
            .height('100%');
          }
        }
      }
      .width('100%')
      .height('100%')
      .backgroundColor(0xf5f6f8)
      .bindPopup(this.customPopup, {
        builder: this.popupBuilder,
        autoCancel: true,
        placement: Placement.Bottom,
        radius: 10,
        offset: { x: 0, y: 300 },
        enableArrow: false,
        onStateChange: (e) => {
          if (!e.isVisible) {
            this.customPopup = false;
          }
        }
      });
    }
  }
}

@CustomDialog
struct CustomDialogExample {
  @State text: string = '';
  controller?: CustomDialogController;
  itemIndex: number = -1;
  cancel: () => void = () => {
  };
  confirm: () => void = () => {
  };
  showPopup: (message: string) => void = () => {
  }; // 用于显示气泡弹窗的回调函数

  build() {
    Column() {
      Button() {
        Row() {
          Text('复制文本')
            .fontSize(12)
            .textAlign(TextAlign.Center)
            .width('100%')
            .onClick(() => {
              const textToCopy = this.text;

              const pasteboardData = pasteboard.createData(pasteboard.MIMETYPE_TEXT_PLAIN, textToCopy);
              const systemPasteboard = pasteboard.getSystemPasteboard();

              systemPasteboard.setData(pasteboardData).then(() => {


                console.info("文本已复制到剪贴板: " + textToCopy);
                this.showPopup('已复制'); // 显示气泡弹窗
              });

              if (this.controller != undefined) {
                this.controller.close();
              }
            });
        }
        .width('100%');
      }
      .type(ButtonType.Normal)
      .backgroundColor(Color.White)
      .width('100%')
      .height(45);

      Button() {
        Row() {
          Text('删除')
            .fontSize(12)
            .textAlign(TextAlign.Center)
            .fontColor(Color.Red)
            .width('100%')
            .onClick(() => {
              this.confirm(); // 调用删除方法
              if (this.controller != undefined) {
                this.controller.close();
              }
            });
        }
        .width('100%');
      }
      .type(ButtonType.Normal)
      .backgroundColor(Color.White)
      .width('100%')
      .height(45);

      Button() {
        Row() {
          Text('取消')
            .fontSize(12)
            .width('100%')
            .fontColor(Color.Gray)
            .textAlign(TextAlign.Center)
            .onClick(() => {
              if (this.controller != undefined) {
                this.controller.close();
              }
            });
        }
        .width('100%');
      }
      .type(ButtonType.Normal)
      .backgroundColor(0xf5f6f8)
      .width('100%')
      .height(45);
    }
  }
}
