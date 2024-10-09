import { Constants }  from '../constants/LoginConstants';
import { router } from '@kit.ArkUI';
import { common } from '@kit.AbilityKit';

@Entry({ routeName: 'WXLoginPage' })
@Component
struct WXLoginPage {

  dynamicLoading(): void {
    try {
      import('../pages/AccountLoginPage');
    } catch (err) {

    }
  }

  aboutToAppear(): void {
    this.dynamicLoading();
  }

  @State radioPopup:boolean = false;
  build() {
    RelativeContainer() {
      Column(){
        Image($r('app.media.ic_planet_normal'))
          .width($r('app.float.image_planet_width'))
          .height($r('app.float.image_planet_height'))
        Text($r('app.string.hm_planet_title'))
          .fontSize(30)
          .fontStyle(FontStyle.Normal)
          .fontFamily('')
          .fontWeight(FontWeight.Bold)
          .padding({
            top: '5vp'
          })
        Text($r('app.string.hm_planet_intro'))
          .letterSpacing('16vp')
          .width('130vp')
          .align(Alignment.Center)
          .padding({
            top: '5vp'
          })
          .fontColor($r('app.color.font_color_grey'))
      }
        .id('title')
        .width(Constants.FULL_SCREEN)
        .margin({
          top: $r('app.float.title_margin_top')
        })
        .alignItems(HorizontalAlign.Center)

      Button($r('app.string.wx_login'))
        .width($r('app.float.button_width'))
        .height($r('app.float.button_height'))
        .backgroundColor($r('app.color.login_button_color'))
        .id('wx_login')
        .alignRules({
          center: { anchor: 'title', align: VerticalAlign.Bottom },
          middle: { anchor: 'title', align: HorizontalAlign.Center }
        })
        .margin({
          top: $r('app.float.wx_login_margin_top')
        })
        .shadow(ShadowStyle.OUTER_DEFAULT_SM)
        .onClick(()=>{
          // TODO 微信登录逻辑
          const bundleName = (getContext(this) as common.UIAbilityContext).applicationInfo.name;
          const url = `@bundle:${bundleName}/phone/ets/pages/MainPage`;
          router.pushUrl({
            url: url
          });
        })

      Row(){
        Toggle({ type: ToggleType.Checkbox, isOn: false })
          .size({ width: 20, height: 20 })
          .selectedColor($r('app.color.login_button_color'))
          .onChange((isOn: boolean) => {
            console.info('Component status:' + isOn)
            this.radioPopup = !isOn
          })

        Text($r('app.string.agree'))
          .width($r('app.float.statement_width'))
          .fontSize('12vp')
          .fontColor($r('app.color.font_color_grey'))
          .lineHeight(18)
      }
      .bindPopup(this.radioPopup, {
        builder: this.popupBuilder(),
        offset: {
          x: '-70vp'
        },
        enableArrow: true,
        arrowPointPosition: ArrowPointPosition.START,
        arrowHeight: 5, // 设置气泡箭头高度
        arrowWidth: 10, // 设置气泡箭头宽度
        radius: 5, // 设置气泡的圆角
        backgroundBlurStyle: BlurStyle.NONE, // 关闭气泡的模糊背景
        popupColor: $r('app.color.popup_color'),
        mask: false,
        shadow: ShadowStyle.OUTER_DEFAULT_XS, // 设置气泡的阴影
        onWillDismiss: false
      })

      .alignRules({
        middle: {anchor: "wx_login", align: HorizontalAlign.Center},
        top: {anchor: "wx_login", align: VerticalAlign.Bottom}
      })
      .margin({
        top: $r('app.float.statement_margin_top')
      })
      Text($r('app.string.account_login'))
        .alignRules({
          center: {anchor: "__container__", align: VerticalAlign.Bottom},
          middle: {anchor: "__container__", align: HorizontalAlign.Center}
        })
        .margin({
          bottom: "100vp"
        })
        .fontSize('14vp')
        .fontColor($r('app.color.font_color_grey'))
        .onClick(()=>{
          router.pushNamedRoute({
            name: 'AccountLoginPage'
          })
        })
    }
    .backgroundColor($r('app.color.wx_login_bgcolor'))
    .height('100%')
    .width('100%')
  }
  @Builder popupBuilder() {
    Text('请先阅读并同意协议')
      .fontSize('14vp')
      .fontColor(Color.White)
      .height('25vp')
      .padding({
        right: '10vp',
        left: '10vp'
      })
  }
}