@Entry
@Component
struct Test1 {
  @State myheight: number = 100;

  aboutToAppear(): void {
    setTimeout(() => {
      this.myheight = 50;
    }, 3000);
  }

  build() {
    Row() {
      Column().width("100%").height(this.myheight+"%").backgroundColor("#FF3333")
      RelativeContainer() {
        Row().width(100).height(100)
          .backgroundColor("#FF3333")
          .alignRules({
            top: {anchor: "__container__", align: VerticalAlign.Top},
            left: {anchor: "__container__", align: HorizontalAlign.Start}
          })
          .id("row1")
          .margin(10)

        Row().width(100).height(100)
          .backgroundColor("#FFCC00")
          .alignRules({
            left: {anchor: "row1", align: HorizontalAlign.End},
            top: {anchor: "row1", align: VerticalAlign.Top}
          })
          .id("row2")

        Row().width(100).height(100)
          .backgroundColor("#FF6633")
          .alignRules({
            left: {anchor: "row1", align: HorizontalAlign.Start},
            top: {anchor: "row1", align: VerticalAlign.Bottom}
          })
          .id("row3")

        Row().width(100).height(100)
          .backgroundColor("#FF9966")
          .alignRules({
            left: {anchor: "row3", align: HorizontalAlign.End},
            top: {anchor: "row2", align: VerticalAlign.Bottom}
          })
          .id("row4")
          .margin(10)
      }
      .width(300).height(300)
      .margin({left: 50})
      .border({width:2, color: "#6699FF"})
    }
    .height('100%')
  }
}