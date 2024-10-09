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
            TabsItem({ item: item, index: index, currentIndex: this.tabsIndex, itemClick: this.itemClick })
            /*Text(item)
              .fontColor(this.tabsIndex === index ? $r('app.color.tab_page_item_focus_font') : $r('app.color.tab_page_item_font'))
              .fontSize(this.getFontSize())
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
              })*/
          }
          .margin({
            left: (index === 0) ? 0 : $r('app.float.vp_six'),
            right: (index === this.tabsList.length - 1) ? 0 : $r('app.float.vp_six')
          })
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

@Component
struct TabsItem {
  @Prop item: string;
  @Prop index: number; // 列表项的下标
  @Link @Watch('onCurrentIndexUpdate') currentIndex: number;
  @State fontColor: ResourceColor = this.currentIndex === this.index ? Color.White : Color.Black;// ? $r('app.color.tab_page_item_focus_font') : $r('app.color.tab_page_item_font');
  @State bgColor: ResourceColor = this.currentIndex === this.index ? "#18b797" : "#dddddd";// ? "#18b797" : "#dddddd";// ? $r('app.color.tab_page_item_focus_bg') :$r('app.color.tab_page_item_bg');
  private itemClick: (index: number) => void = (index: number) => {};

  /**
   * TO NOTE: 状态变化监听优化
   * 该方法会在currentIndex变化时被调用
   * 用于更新当前列表项的样式
   *
   * 如果直接在build方法中使用currentIndex，会导致currentIndex变化时，所有列表项的样式都会被重新构建
   * 为了避免这种情况，可以通过监听currentIndex的变化，来动态修改当前列表项的样式
   */
  onCurrentIndexUpdate() {
    // 根据当前列表项下标index与currentIndex的差值来动态修改color的值
    this.fontColor = this.currentIndex === this.index ? Color.White : Color.Black;// ? $r('app.color.tab_page_item_focus_font') : $r('app.color.tab_page_item_font');
    this.bgColor = this.currentIndex === this.index? "#18b797" : "#dddddd";// ? $r('app.color.tab_page_item_focus_bg') :$r('app.color.tab_page_item_bg');
  }

  getFontSize(): number {
    console.log(`index = ${this.index}文字大小重新构建`)
    return 16;
  }

  build() {
    Text(this.item)
      .fontColor(this.fontColor) // this.tabsIndex === index ? $r('app.color.tab_page_item_focus_font') : $r('app.color.tab_page_item_font')
      .fontSize(this.getFontSize())
      .fontWeight(FontWeight.Normal)
      .padding({
        top: $r('app.float.vp_six'),
        bottom: $r('app.float.vp_six'),
        left: $r('app.float.vp_eight'),
        right: $r('app.float.vp_eight')
      })
      .backgroundColor(this.bgColor)// index === this.tabsIndex ? $r('app.color.tab_page_item_focus_bg') :$r('app.color.tab_page_item_bg')
      .borderRadius($r('app.float.vp_eight'))
      .onClick(() => {
        this.currentIndex = this.index;
        // 网络请求
        this.itemClick(this.index);
      })
  }
}