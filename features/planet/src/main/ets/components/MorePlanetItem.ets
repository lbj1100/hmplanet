import { StyleConstants } from '@ohos/common/Index';
import { PlanetConstants } from '../constants/PlanetConstants';
import { Planet } from '@ohos/common';

@Component
export struct MorePlanetItem {
  // @State message: string = 'Hello World';
  @Prop item: Planet;
  @State cw: number = 0;
  @State ch: number = 0;

  build() {
    Column() {
      Flex({ direction: FlexDirection.Row, alignItems: ItemAlign.Auto, justifyContent: FlexAlign.SpaceBetween }) {
      // Row() {
        Image(this.item.images)
          .width('75vp')
          .height('75vp')
          // .flexBasis('100vp')
          .margin({
            right: $r('app.float.vp_eight')
          })
          .objectFit(ImageFit.Cover)

          .borderRadius($r('app.float.vp_eight'))
        Column() {
          Text(this.item.title)
            .fontSize(18)
            .fontColor('#000000')
            .maxLines(1)
            .textOverflow({
              overflow: TextOverflow.Ellipsis
            })
          Text(this.item.author)
            .fontSize(16)
            .fontColor($r('app.color.author_color'))
            .maxLines(1)
            .textOverflow({
              overflow: TextOverflow.Ellipsis
            })
          Text(this.item.description)
            .fontSize(16)
            .fontColor($r('app.color.description_color'))
            .maxLines(1)
            .textOverflow({
              overflow: TextOverflow.Ellipsis
            })
        }
        // TODO: 75vp - 8vp 优化??
        .width(this.cw - 75 - 8)
        .height('75vp')
        .flexShrink(3)
        .alignItems(HorizontalAlign.Start)
        .justifyContent(FlexAlign.SpaceBetween)
      }

      List() {
        ForEach(this.item.promotion, (tag: string) => {
          ListItem() {
            Text(tag)
              .fontSize(12)
              .fontColor($r('app.color.tag_font_color'))
              .backgroundColor($r('app.color.tag_bg_color'))
              .padding({
                left: $r('app.float.vp_eight'),
                right: $r('app.float.vp_eight'),
                top: $r('app.float.vp_four'),
                bottom: $r('app.float.vp_four')
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
    .backgroundColor($r('app.color.more_page_item_bg'))
    .alignItems(HorizontalAlign.Start)
    .justifyContent(FlexAlign.Center)
    .padding({
      // left: $r('app.float.vp_twelve'),
      // right: $r('app.float.vp_twelve')
    })
    .margin({
      top: $r('app.float.vp_six'),
      bottom: $r('app.float.vp_six')
    })
    .borderRadius($r('app.float.vp_eight'))
    .onAreaChange((oldValue: Area, newValue: Area) => {
      this.cw = new Number(newValue.width).valueOf()
      console.log('newValue:', newValue.width);
      this.ch = new Number(newValue.height).valueOf()
    })
  }
}
