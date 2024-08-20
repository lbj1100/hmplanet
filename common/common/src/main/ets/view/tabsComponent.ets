import { StyleConstants } from '../constants/StyleConstants';

@Preview
@Component
export struct TabsComponent {
  @Link tabsList: string[];
  @State tabsIndex: number = 0;
  // item点击事件
  private itemClick: (index: number) => void = (index: number) => {};

  build() {
    Flex({ direction: FlexDirection.Row }) {
      List() {
        ForEach(this.tabsList, (item: string, index: number) => {
          ListItem() {
            Text(item)
              .fontColor(this.tabsIndex === index ? $r('app.color.tab_page_item_focus_font') :
              $r('app.color.tab_page_item_font'))
              .fontSize(16)
              .fontWeight(FontWeight.Normal)
              .padding({
                top: $r('app.float.vp_six'),
                bottom: $r('app.float.vp_six'),
                left: $r('app.float.vp_eight'),
                right: $r('app.float.vp_eight')
              })
              .margin({
                left: (index === 0) ? 0 : $r('app.float.vp_six'),
                right: (index === this.tabsList.length - 1) ? 0 : $r('app.float.vp_six')
              })// 背景颜色选中时改变
              .backgroundColor(index === this.tabsIndex ? $r('app.color.tab_page_item_focus_bg') :
              $r('app.color.tab_page_item_bg'))// .backgroundColor($r('app.color.more_page_item_bg'))
              .borderRadius($r('app.float.vp_eight'))
              .onClick(() => {
                this.tabsIndex = index;
                // 网络请求
                this.itemClick(index);
              })
          }
        })
      }
      .listDirection(Axis.Horizontal)
      .width(StyleConstants.FULL_WIDTH)
      .height($r('app.float.vp_thirtysix'))
      .alignListItem(ListItemAlign.Center)
      .align(Alignment.Center)
      .scrollBar(BarState.Off)

      Image($r('app.media.ic_right_arrow'))
        .width(20)
        .height(20)
        .backgroundColor('#ffffff')
        .alignSelf(ItemAlign.Center)
      // .alignRules({
      //   right: { anchor: '__container__', align: HorizontalAlign.End },
      //   center: { anchor: '__container__', align: VerticalAlign.Center }
      // })
    }
    .align(Alignment.Center)
    .height($r('app.float.vp_thirtysix'))
  }
}
