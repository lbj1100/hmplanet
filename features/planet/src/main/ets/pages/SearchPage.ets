import { StyleConstants } from '@ohos/common/Index'
import { PlanetConstants } from '../constants/PlanetConstants'
import { router } from '@kit.ArkUI'

import { Planet } from '@ohos/common'
import { cardData } from '../model/CardData'
import { PreferencesUtil } from '@ohos/datastore'
import { BusinessError } from '@kit.BasicServicesKit'


@Entry({ routeName: 'SearchPage' })
@Component
export struct SearchPage {

  bottomRectHeight: string = AppStorage.get<number>('bottomRectHeight') + 'px';
  statusBarHeight: string = AppStorage.get<number>('statusBarHeight') + 'px';
  @State rankings: Planet[] = []
  @State searchHistory: string[] = []
  @State cw: number = 0
  @State ch: number = 0
  private preferencesUtil: PreferencesUtil = PreferencesUtil.getInstance()
  private hasHistory: boolean = false

  aboutToAppear(): void {
    this.rankings = cardData
    this.hasHistory = this.preferencesUtil.hasValueSync('searchHistory');
    // 判断是否有搜索历史
    if (this.hasHistory) {
      this.searchHistory = this.preferencesUtil.getValueSync('searchHistory') as string[];
    }
  }

  @Builder
  RankingItem(value: Planet, index: number) {
    Row() {
      if (index < 3) {
        if (index === 0) {
          // 第一名
          Image($r('app.media.ic_ranking_first'))
            .width(PlanetConstants.RANKINGS_INDEX_IMG_SIZE)
            .height(PlanetConstants.RANKINGS_INDEX_IMG_SIZE)
        } else if (index === 1) {
          // 第二名
          Image($r('app.media.ic_ranking_second'))
            .width(PlanetConstants.RANKINGS_INDEX_IMG_SIZE)
            .height(PlanetConstants.RANKINGS_INDEX_IMG_SIZE)
        } else {
          // 第三名
          Image($r('app.media.ic_ranking_third'))
            .width(PlanetConstants.RANKINGS_INDEX_IMG_SIZE)
            .height(PlanetConstants.RANKINGS_INDEX_IMG_SIZE)
        }
      } else {
        // 第三后的排名
        Text((index + 1).toString())
          .fontSize(16)
          .width(PlanetConstants.RANKINGS_INDEX_IMG_SIZE)
          .height(PlanetConstants.RANKINGS_INDEX_IMG_SIZE)
          .textAlign(TextAlign.Center)
      }
      Image(value.images)
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
          .width(this.cw - 28)
          .borderRadius(8)
          .onSubmit((value: string) => {
            // 提交事件
            console.info('submit', value)
            // 保存搜索历史
            if (this.searchHistory.includes(value)) {
              this.searchHistory.splice(this.searchHistory.indexOf(value), 1)
            }
            // 从头插入
            this.searchHistory.unshift(value)
            // this.searchHistory.push(value)
            if (this.searchHistory.length > 5) {
              this.searchHistory.pop()
            }
            this.preferencesUtil.setValue('searchHistory', this.searchHistory).then(() => {
              console.info('save search history success')
            }).catch((err: BusinessError) => {
              console.error('save search history failed', err)
            })
          })
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
      .onAreaChange((oldValue: Area, newValue: Area) => {
        this.cw = new Number(newValue.width).valueOf()
        console.log('newValue:', newValue.height);
        this.ch = new Number(newValue.height).valueOf()
      })

      // 搜索历史保存在preferences中
      if (this.searchHistory.length > 0) {
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
                // 清空搜索历史
                this.searchHistory = []
                this.preferencesUtil.deleteValue('searchHistory').then(() => {
                  console.info('clear search history success')
                }).catch((err: BusinessError) => {
                  console.error('clear search history failed', err)
                })
              })
          }
          .width(StyleConstants.FULL_WIDTH)
          .alignItems(VerticalAlign.Center)
          .justifyContent(FlexAlign.SpaceBetween)
          .margin({
            top: $r('app.float.vp_twelve'),
            bottom: $r('app.float.vp_twelve')
          })
          // 展示搜索历史
          ForEach(this.searchHistory, (item: string, index: number) => {
            Row() {
              Text(item)
                .fontSize(14)
                // .fontColor($r('app.color.search_history_font_color'))
                .onClick(() => {
                  // 点击事件
                  console.info('click search history', item)
                })
              // 删除
              Image($r('app.media.ic_clear'))
                .width(14)
                .height(14)
                .onClick(() => {
                  // 点击事件
                  console.info('click clear search history', item)
                  // 删除搜索历史
                  this.searchHistory.splice(index, 1)
                  this.preferencesUtil.setValue('searchHistory', this.searchHistory).then(() => {
                    console.info('delete search history success')
                  }).catch((err: BusinessError) => {
                    console.error('delete search history failed', err)
                  })
                })
            }
            .width(StyleConstants.FULL_WIDTH)
            .alignItems(VerticalAlign.Center)
            .justifyContent(FlexAlign.SpaceBetween)
            .margin({
              bottom: $r('app.float.vp_twelve')
            })
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
    .padding({
      top: this.statusBarHeight,
      bottom: this.bottomRectHeight,
      left: $r('app.float.vp_eight'),
      right: $r('app.float.vp_eight')
    }) // 此处margin具体数值在实际中应与导航条区域高度保持一致
  }
}
