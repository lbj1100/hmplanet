import CardInfoModel from '../viewmodel/PlanetPageData'
import { Card } from '../viewmodel/CardModel'
import { CardList } from '../components/CardList'
import { cardData } from '../viewmodel/CardData'
import { BreakpointConstants, StyleConstants } from '@ohos/common'
import { NewPlanetComponent } from '../components/NewPlanetComponent'
import { RankingComponent } from '../components/RankingComponent'
import { resourceManager } from '@kit.LocalizationKit'
import { Recommended } from '../components/Recommended'

@Entry({ routeName: 'PlanetPage' })
@Component
export struct PlanetPage {
  @StorageProp('currentBreakpoint') currentBreakpoint: string = 'sm';
  private onClickItem = (Card: Card) => {};
  @State cardList: Card[] = [];

  aboutToAppear(): void {
    console.log('aboutToAppear')
    this.cardList = cardData
  }

  @Builder
  CardItem(card: CardInfoModel) {
    Column() {
      Image(card.img)
        .width('100vp')
        .height('100vp')
      Text(card.title)
        .fontSize(20)
        .fontColor('#000000')
      Text(card.author)
        .fontSize(16)
        .fontColor('#000000')
    }
    .backgroundColor('#ffffff')
    // 圆角
    .borderRadius(6)
  }

  build() {
      Flex({ direction: FlexDirection.Column }) {
        Row() {
          Text($r('app.string.planet_title'))
            .fontSize(20)
            .fontColor('#000000')
            .fontWeight(FontWeight.Bold)
            .padding({
              top: $r('app.float.vp_twelve'),
              bottom: $r('app.float.vp_twelve')
            })
        }
        .width(StyleConstants.FULL_WIDTH)
        .justifyContent(FlexAlign.Center)

        Scroll() {
          Column() {
            Search()
            CardList({
              cardList: $cardList,
              column: this.currentBreakpoint === BreakpointConstants.BREAKPOINT_LG ? StyleConstants.DISPLAY_FOUR :
                (this.currentBreakpoint === BreakpointConstants.BREAKPOINT_MD ?
                StyleConstants.DISPLAY_THREE : StyleConstants.DISPLAY_TWO),
              onClickItem: (data: Card): void => this.onClickItem(data)
            })
            NewPlanetComponent()
            RankingComponent()
            Recommended({
              recommendedList: cardData
            })
          }
          .margin({
            left: $r('app.float.vp_eight'),
            right: $r('app.float.vp_eight')
          })
        }
        .scrollBar(BarState.Off)
        .scrollable(ScrollDirection.Vertical)
        .padding({
          bottom: $r('app.float.vp_twelve')
        })
      }
      .backgroundColor('#ffffff')
      .width('100%')
      .height('100%')
    }
}
