import { DynamicModel } from '../model/DynamicModel';

@Preview
@Component
export struct DynamicListItem {
  @Prop item: DynamicModel = new DynamicModel('00');
  @State expandedItems: Set<DynamicModel> = new Set();
  @State likedItems: Set<string> = new Set();
  @State likeCounts: Map<string, number> = new Map();
  private openDialog = () =>{};


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
                /*if (this.dialogController != null) {
                  this.dialogController.open()
                }*/
                this.openDialog();
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
      .margin({ top: 10, left: 10 })
    }
    .backgroundColor(Color.White)
    .width('100%')
    .height('auto')
    .borderRadius(10)
  }
}