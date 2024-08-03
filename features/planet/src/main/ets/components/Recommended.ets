import { StyleConstants } from '@ohos/common'
import { PlanetConstants } from '../constants/PlanetConstants'
import { Planet } from '../viewmodel/PlanetModel'

@Preview
@Component
export struct Recommended {
  @State isLoading: boolean = false
  @Prop recommendedList: Planet[] = []
  @State recommended3Item: Planet[] = []

  aboutToAppear(): void {
    // recommendedList只取前三个
    this.recommended3Item = this.recommendedList.slice(0, 3)
  }

  @Builder
  RecommendedItem(item: Planet) {
    Column() {
      Row() {
        Image(item.images)
          .width('75vp')
          .height('75vp')
          .margin({
            right: $r('app.float.vp_twelve')
          })
          .borderRadius($r('app.float.vp_eight'))
        Column() {
          Text(item.title)
            .fontSize(20)
            .fontColor('#000000')
          Text(item.author)
            .fontSize(16)
            .fontColor($r('app.color.author_color'))
          Text(item.description)
            .fontSize(16)
            .fontColor($r('app.color.description_color'))
        }
        .height('75vp')
        .alignItems(HorizontalAlign.Start)
        .justifyContent(FlexAlign.SpaceBetween)
      }
      List() {
        ForEach(item.promotion, (tag: string) => {
          ListItem() {
            Text(tag)
              .fontSize(12)
              .fontColor($r('app.color.tag_font_color'))
              .backgroundColor($r('app.color.tag_bg_color'))
              .padding({
                left: $r('app.float.vp_eight'),
                right: $r('app.float.vp_eight')
              })
              .borderRadius($r('app.float.vp_one'))
              // .opacity(0.3)
          }
        })
      }
      .margin({
        top: $r('app.float.vp_twelve')
      })
      .listDirection(Axis.Vertical)
    }
    .height(PlanetConstants.RECOMMENDED_ITEM_HEIGHT)
    .width(StyleConstants.FULL_WIDTH)
    .alignItems(HorizontalAlign.Start)
    .justifyContent(FlexAlign.Center)
    .padding({
      left: $r('app.float.vp_twelve'),
      right: $r('app.float.vp_twelve')
    })
    .borderRadius($r('app.float.vp_eight'))
  }

  build() {
    Column() {
      Row() {
        Text($r('app.string.recommended_title'))
          .fontSize(16)
          .fontWeight(FontWeight.Bold)
        Row() {
          LoadingProgress()
            .enableLoading(this.isLoading)
            .color('#15b997')
            .size({
              width: $r('app.float.vp_twenty'),
              height: $r('app.float.vp_twenty')
            })
            .margin({
              right: $r('app.float.vp_four')
            })
          Text('换一换')
            .fontColor(Color.Gray)
            .fontSize(14)
            .onClick(() => {
              this.isLoading = true
              setTimeout(() => {
                this.isLoading = false
              }, 2000)
            })
        }
      }
      .width(StyleConstants.FULL_WIDTH)
      .justifyContent(FlexAlign.SpaceBetween) // 设置两端对齐

      // 推荐列表
      Row() {
        List() {
          ForEach(this.recommended3Item, (item: Planet) => {
            ListItem() {
              this.RecommendedItem(item)
            }
          })
        }
        .width(StyleConstants.FULL_WIDTH)
        .height(PlanetConstants.RECOMMENDED_ITEM_HEIGHT * 3)
        .alignListItem(ListItemAlign.Center)
      }
      .margin({
        top: $r('app.float.vp_eight')
      })


      Row() {
        Text($r('app.string.recommended_more'))
          .fontColor(Color.Gray)
          .fontSize(12)
      }
      .width(StyleConstants.FULL_WIDTH)
      .height(32)
      // .alignItems(VerticalAlign.Center)
      .justifyContent(FlexAlign.Center)
      .borderRadius($r('app.float.vp_eight'))
      .backgroundColor($r('app.color.recommended_bg'))
    }
    .margin({
      top: $r('app.float.vp_thirty'),
      left: $r('app.float.vp_eight'),
      right: $r('app.float.vp_eight')
    })
  }
}
