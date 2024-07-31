import { StyleConstants } from '@ohos/common'

@Preview
@Component
export struct NewPlanetComponent {
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
          Image($r('app.media.default_img')) // 显示图片
            .width($r('app.float.new_planet_image_size')) // 设置宽度
            .height($r('app.float.new_planet_image_size')) // 设置高度

          Text($r('app.string.new_planet_query')) // 显示文本
            .fontColor($r('app.color.new_planet_query_font_color')) // 设置字体颜色
            .fontSize($r('app.float.new_planet_font_size')) // 设置字体大小
            .fontWeight(FontWeight.Bold) // 设置字体粗细

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
  }
}
