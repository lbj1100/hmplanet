import { StyleConstants } from '@ohos/common'
import { PlanetConstants } from '../constants/PlanetConstants'
import { router } from '@kit.ArkUI'


@Entry
@Component
export struct RankingComponent {
  @Builder
  RankingItem(value: string) {
    Column() {
      Row() {
        Text(value)
          .fontSize(14)
          .fontWeight(FontWeight.Bold)
        Image($r('app.media.ic_right_triangle'))
          .width($r('app.float.vp_ten'))
          .height($r('app.float.vp_ten'))
      }
      .width(StyleConstants.FULL_WIDTH)
      .justifyContent(FlexAlign.SpaceBetween)
      .margin({
        bottom: $r('app.float.vp_eight')
      })
      // 三张重叠的图片
      Row() {
        Image($r('app.media.default_author_img'))
          .imgStyle()
          .position({
            left: PlanetConstants.RANKINGS_IMG_SIZE
          })
        Image($r('app.media.default_author_img'))
          .imgStyle()
          .position({
          left: PlanetConstants.RANKINGS_IMG_SIZE / 2
        })

        Image($r('app.media.default_img'))
          .imgStyle()
      }

    }
    .width($r('app.float.rankings_item_width'))
    .height($r('app.float.rankings_item_height'))
    .alignItems(HorizontalAlign.Start)
    .justifyContent(FlexAlign.Center)
    .backgroundColor($r('app.color.rankings_bg'))
    .padding({
      left: $r('app.float.vp_eight'),
      right: $r('app.float.vp_eight')
    })
    .borderRadius($r('app.float.vp_eight'))
  }
  build() {
    Column() {
      Row() {
        Row() {
          Text($r('app.string.rankings_title'))
            .fontSize(16)
            .fontWeight(FontWeight.Bold)
          Text($r('app.string.rankings_subtitle'))
            .fontColor(Color.Gray)
            .fontSize(14)
        }

        Row() {
          // Text($r('app.string.rankings_more'))
          //   .fontColor(Color.Gray)
          //   .fontSize(14)
          // Image()
          Button() {
            Text($r('app.string.rankings_more'))
              .fontColor(Color.Gray)
              .fontSize(14)
          }
          .backgroundColor(Color.Transparent)
          .onClick(() => {
            router.pushNamedRoute({
              name: 'MorePage',
              params: {
                title: $r('app.string.rankings_more')
              }
            })
          })
        }
      }
      .width(StyleConstants.FULL_WIDTH)
      .justifyContent(FlexAlign.SpaceBetween) // 设置两端对齐
      .alignItems(VerticalAlign.Center)

      // 榜单列表
      Row() {
        this.RankingItem('财富榜')
        this.RankingItem('人气榜')
        this.RankingItem('新作榜')
      }
      .justifyContent(FlexAlign.SpaceBetween) // 设置两端对齐
      .width(StyleConstants.FULL_WIDTH)
      .margin({
        top: $r('app.float.vp_sixteen')
      })
    }
    // .width(StyleConstants.FULL_WIDTH)
    // .height($r('app.float.rankings_height'))
    .margin({
      top: $r('app.float.vp_thirty'),
      left: $r('app.float.vp_eight'),
      right: $r('app.float.vp_eight')
    })
  }
}

@Styles function imgStyle()  {
  .width(PlanetConstants.RANKINGS_IMG_SIZE)
  .height(PlanetConstants.RANKINGS_IMG_SIZE)
  .borderRadius($r('app.float.vp_eight'))
  .borderColor($r('app.color.rankings_border'))
  .borderWidth($r('app.float.vp_one'))
}