@Entry
@Component
struct SizeExample {
  @State flag: boolean = true;

  build() {
    Row() {
      Text(this.flag ? '已关注' : '没有关注')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
        .backgroundColor(0xFFFAF0)
        .textAlign(TextAlign.Center)
        .margin( 10)
        .size({ width: this.flag ? 60 : 80 })
        .onClick(()=>{
          this.flag = !this.flag
        })
      Text('calc(100% - 60vp)')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
        .backgroundColor(0xFFFAF0)
        .size({width: this.flag ? 'calc(100% - 60vp)' : 'calc(100% - 80vp)'})
    }.width(500).margin({ top: 5 })
  }
}