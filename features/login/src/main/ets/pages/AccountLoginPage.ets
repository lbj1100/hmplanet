@Entry({ routeName: 'AccountLoginPage' })
@Component
export struct AccountLoginPage {
  @State message: string = '知识星球';

  build() {
    Column(){
      Row(){
        Image($r('app.media.no'))
          .width(25)
          .height(25)
          .margin({top:50,right:15})
        // .onClick({})
      }
      .width("100%")
      .justifyContent(FlexAlign.End)

      Row(){
        Image($r('app.media.world'))
          .width(35)
          .height(35)
          .margin({right:15})
        Text(this.message)
          .id('HelloWorld')
          .fontColor('white')
          .fontSize(30)
      }
      .margin({top:50})

      TextInput({placeholder: '邮箱地址'})
        .placeholderColor(Color.White)
        .placeholderFont({ size: 14, weight: 400 })
        .caretColor(Color.Blue)
        .width('80%')
        .height(50)
        .margin({ top:50 })
        .fontSize(14)
        .border({
          width: 1,
          color:'white',
          radius: { topLeft: 5, topRight: 5, bottomLeft: 0, bottomRight: 0 },
        })
        .fontColor(Color.Black)

      TextInput({ placeholder: '密码' })
        .placeholderColor(Color.White)
        .width('80%')
        .height(50)
        .type(InputType.Password)
        .showPasswordIcon(false)
        .fontSize(14)
        .fontColor(Color.Black)
        .border({
          width: { left: 1, right: 1, top: 0, bottom: 1 },
          color:'white',
          radius: { topLeft: 0, topRight: 0, bottomLeft: 5, bottomRight: 5 },
        })

      Button('登录',{type: ButtonType.Normal})
        .width('80%')
        .height(40)
        .margin(15)
        .backgroundColor('white')
        .fontColor('#5db3a6')
        .borderRadius(5)
        .shadow({
          radius:3,
          offsetY:1
        })
      // .onClick({})
    }
    .backgroundImage($r("app.media.backgroundImg"))
    .backgroundImageSize(ImageSize.Cover)
    .height('100%')
    .width('100%')
  }
}
