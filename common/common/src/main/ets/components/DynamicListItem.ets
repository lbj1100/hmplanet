import { DynamicModel } from '../model/DynamicModel';

@Preview
@Component
export struct DynamicListItem {
  @Prop item: DynamicModel = new DynamicModel('00');
  @State expandedItems: Set<DynamicModel> = new Set();
  @State likedItems: Set<string> = new Set();
  @State likeCounts: Map<string, number> = new Map();

  aboutToDisappear() {
    this.dialogController = null // 将dialogController置空
  }

  dialogController: CustomDialogController | null = new CustomDialogController({
    builder: CustomDialogExample({
      text1: this.item.planetName,
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
  onCancel() {
    console.info('Callback when the first button is clicked')
  }

  onAccept() {
    console.info('Callback when the second button is clicked')
  }

  build() {
    Column() {
      Row() {
        Image(this.item.authorAvatar)
          .width(30)
          .height(30)
          .borderRadius(25)
          .alignSelf(ItemAlign.Start)
          .margin({ left: 5 })

        Column() {
          Row() {
            Column() {
              Text(this.item.author)
                .fontSize(12)
                .fontColor(0x65768c)
              Text(this.item.time)
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
                  Text(this.item.content)
                    .lineHeight(20)
                    .width('85%')
                    .fontSize(14)
                    .maxLines(this.expandedItems.has(this.item) ? undefined : 5)
                    .textOverflow({ overflow: TextOverflow.Ellipsis })
                    .fontWeight(FontWeight.Normal)
                    .textAlign(TextAlign.Start)
                    .fontColor(Color.Black)
                    .backgroundColor(Color.Transparent)
                    .padding({ top: 5 , bottom: 10 })
                }
                .width('95%')

                if (this.item.content.split(/[\s\S]{1,27}/).length > 5) {
                  Row() {
                    Button() {
                      Text(this.expandedItems.has(this.item) ? '收起' : '展开更多')
                        .fontSize(14)
                        .fontWeight(FontWeight.Normal)
                        .textAlign(TextAlign.Start)
                        .fontColor(0x65768c)
                        .backgroundColor(Color.White)
                        .padding({ bottom: 10 })
                    }
                    .onClick(() => {
                      if (this.expandedItems.has(this.item)) {
                        this.expandedItems.delete(this.item);
                      } else {
                        this.expandedItems.add(this.item);
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
                Text(this.item.planetName)
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
                      Image($r(this.likedItems.has(this.item.id) ? 'app.media.like_true' : 'app.media.like_false'))
                        .width(15)
                        .height(15)
                        .backgroundColor(Color.White)
                    }
                    .onClick(() => {
                      if (this.likedItems.has(this.item.id)) {
                        this.likedItems.delete(this.item.id);
                        this.likeCounts.set(this.item.id, (this.likeCounts.get(this.item.id) || 1) - 1);
                      } else {
                        this.likedItems.add(this.item.id);
                        this.likeCounts.set(this.item.id, (this.likeCounts.get(this.item.id) || 0) + 1);
                      }
                    })
                    Blank()
                      .width(5)
                    Text(`${this.likeCounts.get(this.item.id) || 0}`)
                      .fontSize(10)
                      .fontWeight(FontWeight.Normal)
                      .fontColor(this.likedItems.has(this.item.id) ? 0x18b998 : 0x65768c)
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
      .margin({ top: 10 })
    }
    .backgroundColor(Color.White)
    .width('100%')
    .height('auto')
    .borderRadius(10)
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