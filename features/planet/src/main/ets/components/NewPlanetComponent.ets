import { StyleConstants } from '@ohos/common'

@Preview
@Component
export struct NewPlanetComponent {
  @State ch: number = 0;
  @State cw: number = 0;
  /**
   * 构建新建星球组件
   */
  build() {
    Column() {
      Column(){
        Text($r('app.string.new_planet_title'))// 显示新建星球标题
          .fontSize(12)// 设置字体大小
          .fontColor($r('app.color.new_planet_font_color'))// 设置字体颜色
          .padding({
            bottom: $r('app.float.vp_twelve')
          })

        Button("+ 创建星球")
          .fontSize(14)// 设置字体大小
          .backgroundColor('#15b997')
          .height(34)
          .width(110)
      }
      .width(StyleConstants.FULL_WIDTH) // 宽度占满父容器
      .height($r('app.float.new_planet_height')) // 高度
      .alignItems(HorizontalAlign.Center) // 设置水平居中
      .justifyContent(FlexAlign.Center) // 设置两端对齐
      .backgroundColor($r('app.color.new_planet_bg_color')) // 设置背景颜色
      .borderRadius($r('app.float.vp_eight')) // 设置圆角

      Button() {
        Row() {
          Image($r('app.media.issue')) // 显示图片
            .width($r('app.float.new_planet_image_size')) // 设置宽度
            .height($r('app.float.new_planet_image_size')) // 设置高度
            .margin({
              right: $r('app.float.vp_six')
            })

          Text($r('app.string.new_planet_query')) // 显示文本
            .width(this.cw < 250 ? this.cw - 15 - 20 - 8 * 2 : 'auto') // 设置宽度
            .fontColor($r('app.color.new_planet_query_font_color')) // 设置字体颜色
            .fontSize($r('app.float.new_planet_font_size')) // 设置字体大小
            .fontWeight(FontWeight.Bold) // 设置字体粗细
            .maxLines(1) // 设置最大行数
            .textOverflow({
              overflow: TextOverflow.Ellipsis
            }) // 设置文本溢出样式

          Image($r('app.media.ic_arrow_right')) // 显示图片
            .width($r('app.float.right_arrow_image_size')) // 设置宽度
            .height($r('app.float.right_arrow_image_size')) // 设置高度

        }
        .alignItems(VerticalAlign.Center) // 设置垂直居中
        .justifyContent(FlexAlign.Center) // 设置两端对齐
      }
      .type(ButtonType.Normal)
      .width(StyleConstants.FULL_WIDTH) // 宽度占满父容器
      .height($r('app.float.new_planet_query_height')) // 高度
      .backgroundColor($r('app.color.new_planet_query_bg_color')) // 设置背景颜色
      .borderRadius($r('app.float.vp_eight')) // 设置圆角
      .margin({
        top: $r('app.float.vp_fourteen')
      })
      .onClick(() => {
        // 点击事件
        console.info('click new planet query')
      })
    }
    .margin({
      top: $r('app.float.vp_twelve'),
      left: $r('app.float.vp_eight'),
      right: $r('app.float.vp_eight')
    }) // 设置外边距
    .onAreaChange((oldValue: Area, newValue: Area) => {
      this.cw = new Number(newValue.width).valueOf()
      console.log('newValue:', newValue.height);
      this.ch = new Number(newValue.height).valueOf()
    })
  }
}
