import { promptAction, router } from '@kit.ArkUI'
import { common } from '@kit.AbilityKit'

@Entry({ routeName: 'AccountLoginPage' })
@Component
struct AccountLoginPage {
  @State email: string = ''
  @State password: string = ''
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
        placeholder: "邮箱",
        text: $$this.email
      })
        .type(InputType.Email)
        .backgroundColor(Color.Transparent)
        .fontColor(Color.Black)
        .backgroundBlurStyle(BlurStyle.NONE)
      TextInput({
        placeholder: "密码",
        text: $$this.password
      })
        .type(InputType.Password)
        .backgroundColor(Color.Transparent)
        .fontColor(Color.Black)
        .backgroundBlurStyle(BlurStyle.NONE)
      Button("登录")
        .backgroundColor(Color.Brown)
        .margin({
          top: '4vp'
        })
        .onClick(() => {
          // promptAction.showToast({
          //   message: '登录中...'
          // })
          if (this.email === '' || this.password === '') {
            promptAction.showToast({
              message: '用户名或密码不能为空'
            })
            return
          }
          // TODO 登录逻辑
          if (this.email != 'admin' || this.password != 'admin') {
            promptAction.showToast({
              message: '用户名或密码错误'
            })
            return
          }
          promptAction.showToast({
            message: '登录成功'
          })
          const bundleName = (getContext(this) as common.UIAbilityContext).applicationInfo.name;
          const url = `@bundle:${bundleName}/phone/ets/pages/MainPage`;
          router.pushUrl({
            url: url
          });
        })

    }
    .backgroundColor(Color.Pink)
    .width('100%')
    .height('100%')
  }
}
