import { StyleConstants } from '@ohos/common/Index'
import { PlanetConstants } from '../constants/PlanetConstants'
import { router } from '@kit.ArkUI'
import { Planet } from '../viewmodel/PlanetModel'
import { cardData } from '../viewmodel/CardData'


@Entry({ routeName: 'SearchPage' })
@Component
export struct SearchPage {
  @State rankings: Planet[] = []

  aboutToAppear(): void {
    this.rankings = cardData
  }

  @Builder
  RankingItem(value: Planet, index: number) {
    Row() {
      if (index < 3) {
        if (index === 0) {
          Image($r('app.media.ic_ranking_first'))
            .width(PlanetConstants.RANKINGS_INDEX_IMG_SIZE)
            .height(PlanetConstants.RANKINGS_INDEX_IMG_SIZE)
        } else if (index === 1) {
          Image($r('app.media.ic_ranking_second'))
            .width(PlanetConstants.RANKINGS_INDEX_IMG_SIZE)
            .height(PlanetConstants.RANKINGS_INDEX_IMG_SIZE)
        } else {
          Image($r('app.media.ic_ranking_third'))
            .width(PlanetConstants.RANKINGS_INDEX_IMG_SIZE)
            .height(PlanetConstants.RANKINGS_INDEX_IMG_SIZE)
        }
        // Image($r('app.media.default_img'))
        //   .width(PlanetConstants.RANKINGS_INDEX_IMG_SIZE)
        //   .height(PlanetConstants.RANKINGS_INDEX_IMG_SIZE)
      } else {
        Text((index + 1).toString())
          .fontSize(16)
          .width(PlanetConstants.RANKINGS_INDEX_IMG_SIZE)
          .height(PlanetConstants.RANKINGS_INDEX_IMG_SIZE)
          .textAlign(TextAlign.Center)
      }
      Image(value.authorImg)
        .width(PlanetConstants.RANKINGS_IMG_SIZE)
        .height(PlanetConstants.RANKINGS_IMG_SIZE)
        .margin({
          left: $r('app.float.vp_six'),
          right: $r('app.float.vp_six')
        })
      Text(value.title)
        .fontSize(18)
        .textAlign(TextAlign.Center)
    }
    .width(StyleConstants.FULL_WIDTH)
    .height(PlanetConstants.RANKINGS_ITEM_HEIGHT)
    .alignItems(VerticalAlign.Center)
    .justifyContent(FlexAlign.Start)
  }

  /**
   * 构建搜索组件
   */
  build() {
    Column() {
      Row() {
        Search()
          .width('70%')
          .borderRadius(8)
        // 取消
        Text($r('app.string.search_cancel'))
          .fontSize(14)
          .fontColor($r('app.color.search_cancel_font_color'))
          .onClick(() => {
            // 点击事件
            router.back()
          })
      }
      .width(StyleConstants.FULL_WIDTH)
      .justifyContent(FlexAlign.Center)

      // TODO 搜索历史保存在preferences中
      if (true) {
        // 最近搜索
        Column() {
          Row() {
            Text('最近搜索')
              .fontSize(14)
              .fontWeight(FontWeight.Bold)
            // 清空
            Image($r('app.media.ic_clear'))
              .width(14)
              .height(14)
              .onClick(() => {
                // 点击事件
                console.info('click clear')
              })
          }
          .width(StyleConstants.FULL_WIDTH)
          .alignItems(VerticalAlign.Center)
          .justifyContent(FlexAlign.SpaceBetween)
          .margin({
            top: $r('app.float.vp_twelve'),
            bottom: $r('app.float.vp_twelve')
          })
          Blank()
            .height(6)
            .backgroundColor($r('app.color.divider_color'))
        }
      }

      // 排行榜
      Text('xx排行榜')
        .width(StyleConstants.FULL_WIDTH)
        .textAlign(TextAlign.Start)
        .fontSize(14)
        .fontWeight(FontWeight.Bold)
        .margin({
          top: $r('app.float.vp_twelve'),
          bottom: $r('app.float.vp_twelve')
        })
      List() {
        ForEach(this.rankings, (item: Planet, index: number) => {
          ListItem() {
            this.RankingItem(item, index)
          }
        })
      }
      .width(StyleConstants.FULL_WIDTH)
      .height(PlanetConstants.RANKINGS_ITEM_HEIGHT * this.rankings.length)
      .alignListItem(ListItemAlign.Center)
    }
    .margin({
      top: $r('app.float.vp_eight'),
      left: $r('app.float.vp_eight'),
      right: $r('app.float.vp_eight')
    })
  }
}
