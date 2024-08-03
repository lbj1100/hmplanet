import { StyleConstants } from '@ohos/common/Index'

@Preview
@Component
export struct SearchComponent {

  /**
   * 构建搜索组件
   */
  build() {
    Row() {
        Text($r('app.string.search_placeholder'))
          .fontSize(16)
          .fontColor('#aaaaaa')
          .padding({
            top: $r('app.float.vp_twelve'),
            bottom: $r('app.float.vp_twelve')
          })
    }
    .width(StyleConstants.FULL_WIDTH)
    .backgroundColor('#f6f6f6')
    .borderRadius($r('app.float.vp_eight'))
    .margin({
      top: $r('app.float.vp_twelve'),
      bottom: $r('app.float.vp_twelve'),
      left: $r('app.float.vp_eight'),
      right: $r('app.float.vp_eight')
    })
  }
}
