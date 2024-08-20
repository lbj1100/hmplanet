import { router } from '@kit.ArkUI'

@Entry
@Component
struct Notes {
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

          Text("私信")
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
        //如果没有私信，就显示没有私信，有私信就显示私信
        if (this.arr.length == 0) {
          Column(){
          Image($r('app.media.no_notes'))
            .width(120)
            .height(100)

          Blank()
            .height(10)

          Text("这里空空如也")
            .fontSize(15)
            // .fontWeight(FontWeight.Bold)
            // .textAlign(TextAlign.Center)
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
      .width('100%')
      .height('100%')
    }
  }
}