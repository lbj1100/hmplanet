import { router } from '@kit.ArkUI'

@Entry({ routeName: 'AboutMe' })
@Component
struct AboutMe {
  bottomRectHeight: string = AppStorage.get<number>('bottomRectHeight') + 'px';
  statusBarHeight: string = AppStorage.get<number>('statusBarHeight') + 'px';
  @State message: string = '私信';
  private arr: number[] = []

  build() {
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
            router.back()
          })
          .backgroundColor(Color.Transparent)
          .width('5%')
          .height('50%')
          .margin({ left: 10 })
          .alignRules({
            left: { anchor: "__container__", align: HorizontalAlign.Start },
            center: { anchor: "__container__", align: VerticalAlign.Center },
          })

          Text("与我相关")
            .fontSize(15)
            // .fontWeight(FontWeight.Bold)
            .alignRules({
              middle: { anchor: '__container__', align: HorizontalAlign.Center },
              center: { anchor: "__container__", align: VerticalAlign.Center }
            })


        }
        .height('7%')
        .width('100%')
      }


      Row() {
        Column() {
          Column() {
            Row() {
              Button() {
                Column({ space: 5 }) {
                  Image($r('app.media.like_red'))
                    .width(23)
                    .height(25)
                    .align(Alignment.Start)
                    .zIndex(1)
                  Text("收到的赞")
                    .fontSize(10)
                    .alignRules({
                      middle: { anchor: '__container__', align: HorizontalAlign.Center },
                      center: { anchor: "__container__", align: VerticalAlign.Center }
                    })
                }
              }
              .backgroundColor(Color.Transparent)
              .stateEffect(false)

              Button() {
                Column({ space: 5 }) {
                  Image($r('app.media.request_green'))
                    .width(23)
                    .height(25)
                    .align(Alignment.Start)
                    .zIndex(1)
                  Text("审批请求")
                    .fontSize(10)
                    .alignRules({
                      middle: { anchor: '__container__', align: HorizontalAlign.Center },
                      center: { anchor: "__container__", align: VerticalAlign.Center }
                    })
                }
              }
              .backgroundColor(Color.Transparent)
              .stateEffect(false)

              Button() {
                Column({ space: 5 }) {
                  Image($r('app.media.notes_green'))
                    .width(23)
                    .height(25)
                    .align(Alignment.Start)
                    .zIndex(1)
                  Text("系统消息")
                    .fontSize(10)
                    .alignRules({
                      middle: { anchor: '__container__', align: HorizontalAlign.Center },
                      center: { anchor: "__container__", align: VerticalAlign.Center }
                    })
                }
              }
              .backgroundColor(Color.Transparent)
              .stateEffect(false)
              .onClick(()=>{
                router.pushUrl({
                  url:'pages/Sys_Message'
                })
              })
            }
            .width('80%')
            .height('100%')
            .justifyContent(FlexAlign.SpaceBetween)
          }
          .height('12%')
          .width('100%')

          Blank()
            .height(1)
            .width('100%')
            .color(0xf5f6f8)

          Blank()
            .height('10%')

          Row() {
            //如果没有私信，就显示没有私信，有私信就显示私信
            if (this.arr.length == 0) {
              Column() {
                Image($r('app.media.no_notes'))
                  .width(110)
                  .height(90)

                Blank()
                  .height(20)

                Text("这里空空如也")
                  .fontSize(15)// .fontWeight(FontWeight.Bold)
                  .fontColor(Color.Gray)
              }
              .width('100%')
              .height('40%')

            } else {
              Text(this.message)
                .fontSize(15)
                .fontWeight(FontWeight.Bold)
                .alignRules({
                  middle: { anchor: '__container__', align: HorizontalAlign.Center },
                  center: { anchor: "__container__", align: VerticalAlign.Center }
                })
            }
          }
        }
        .width('100%')
        .height('100%')
      }
    }
    .padding({
      top: this.statusBarHeight,
      bottom: this.bottomRectHeight
    }) // 此处margin具体数值在实际中应与导航条区域高度保持一致
  }
}