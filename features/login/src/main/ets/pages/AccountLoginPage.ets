@Entry({ routeName: 'AccountLoginPage' })
@Component
export struct AccountLoginPage {
  @State message: string = 'Hello World';

  build() {
      Column() {
        Stack() {
          Row() {
            Image($r('app.media.ic_planet_normal'))
              .width($r('app.float.image_planet_small_width'))
              .height($r('app.float.image_planet_small_height'))
            Text($r('app.string.hm_planet_title'))
              .fontSize(20)
              .fontStyle(FontStyle.Normal)
              .fontFamily('')
              .fontWeight(FontWeight.Normal)
              .padding({
                left: "6vp"
              })
          }

        }
        TextInput({
          placeholder: "邮箱"
        })
          .type(InputType.Email)
          .backgroundColor(Color.Transparent)
          .fontColor(Color.Black)
          .backgroundBlurStyle(BlurStyle.NONE)
        TextInput({
          placeholder: "密码"
        })
          .type(InputType.Password)
          .backgroundColor(Color.Transparent)
          .fontColor(Color.Black)
          .backgroundBlurStyle(BlurStyle.NONE)
      }
      .backgroundColor(Color.Pink)
      .width('100%')
    }
}
