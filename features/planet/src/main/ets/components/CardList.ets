import { StyleConstants, CommonDataSource, BreakpointConstants } from '@ohos/common';
import { Planet } from '@ohos/common';
import { EmptyComponent } from './EmptyComponent';
import { resourceManager } from '@kit.LocalizationKit';

/**
 * Card list component.
 */

@Component
export struct CardList {
  @StorageProp('currentBreakpoint') currentBreakpoint: string = 'sm';
  @Link cardList: Planet[];
  @Prop column: number = 0;
  private onClickItem? = (card: Planet) => {
  };
  @State listLength: number = 0;

  aboutToAppear(): void {
    // TODO 尝试使用resourceManager获取资源失败，暂时使用固定值
    // resourceManager.getSystemResourceManager().getStringValue($r('app.float.card_item_height')).then((value) => {
    //   console.info('card_item_height:' + value)
    //   this.listLength = this.cardList.length * Number(value)
    // })

    this.listLength = Math.ceil(this.cardList.length / 2) * (210 + 10);
  }

  @Builder
  CardItem(info: Planet) {
    Column() {
      Image($r('app.media.default_img'))
        .width('100%')
        .height($r('app.float.img_height'))
        .borderRadius({
          topLeft: $r('app.float.vp_eight'),
          topRight: $r('app.float.vp_eight')
        })
      Column() {
        Text($r('app.string.card_piece_description', info.title))
          .fontColor($r('app.color.card_title_color'))
          .maxLines(StyleConstants.TWO_TEXT_LINE)
          .textOverflow({ overflow: TextOverflow.Ellipsis })
          .fontSize($r('app.float.middle_font_size'))
          .fontWeight(StyleConstants.FONT_WEIGHT_FOUR)
          .lineHeight($r('app.float.card_desc_height'))
          .maxLines(1)
          .textOverflow({
            overflow: TextOverflow.Ellipsis
          })
        Row() {
          Text(info.author)
            .textAlign(TextAlign.Center)
            .fontColor($r('app.color.author_color'))
            .fontSize($r('app.float.small_font_size'))
          Image(info.authorImg)
            .width($r('app.float.vp_twenty'))
            .height($r('app.float.vp_twenty'))
            .borderRadius($r('app.float.vp_ten'))
            .backgroundColor($r('app.color.author_bg_color'))
        }
        .width(StyleConstants.FULL_WIDTH)
        .padding({
          top: $r('app.float.vp_four'),
          bottom: $r('app.float.vp_eight')
        })
        .alignItems(VerticalAlign.Center)
        .justifyContent(FlexAlign.SpaceBetween)

        /*Text(`${info.promotion}`)
          .fontSize($r('app.float.micro_font_size'))
          .fontColor(Color.White)
          .backgroundColor($r('app.color.focus_color'))
          .borderRadius($r('app.float.vp_four'))
          .height($r('app.float.vp_sixteen'))
          .padding({
            right: $r('app.float.vp_eight'),
            left: $r('app.float.vp_eight')
          })*/
      }
      .width(StyleConstants.FULL_WIDTH)
      .alignItems(HorizontalAlign.Start)
      .padding({
        top: $r('app.float.vp_six'),
        left: $r('app.float.vp_six'),
        right: $r('app.float.vp_six')
      })
    }
    .height($r('app.float.card_item_height'))
    .width(StyleConstants.FULL_WIDTH)
    .zIndex(-1)
    .backgroundColor($r('app.color.card_bg_color'))
    .borderRadius($r('app.float.vp_eight'))
    .backgroundImagePosition(Alignment.Top)
  }

  build() {
    if (this.cardList.length > 0) {
      List({ space: StyleConstants.TWELVE_SPACE }) {
        LazyForEach(new CommonDataSource<Planet>(this.cardList), (item: Planet) => {
          ListItem() {
            this.CardItem(item)
          }
          .margin({ left: $r('app.float.vp_eight'), right: $r('app.float.vp_eight') })
          .onClick(() => {
            if (this.onClickItem !== undefined) {
              this.onClickItem(item);
            }
          })
        }, (item: Planet) => JSON.stringify(item))
      }
      .enableScrollInteraction(false)
      .cachedCount(6)
      .height(Math.ceil(this.cardList.length / (this.currentBreakpoint === BreakpointConstants.BREAKPOINT_LG ? 2 : 3)) * (210 + 10))
      .width(StyleConstants.FULL_WIDTH)
      .margin({
        left: $r('app.float.card_list_margin'),
        right: $r('app.float.card_list_margin')
      })
      .padding({
        bottom: $r('app.float.card_list_bottom')
      })
      .listDirection(Axis.Vertical)
      .direction(Direction.Auto)
      .lanes(this.column)
    } else {
      EmptyComponent({ outerHeight: StyleConstants.FIFTY_HEIGHT })
    }
  }
}