import { router } from '@kit.ArkUI';

@Entry
@Component
struct FirstPage {
  @State message: string = 'Hello World';
  @State isFirst:boolean = true

  dynamicLoading(): void {
    try {
      import('@ohos/login/src/main/ets/pages/WXLoginPage');
      import('../pages/MainPage');
    } catch (err) {
    }
  }

  aboutToAppear(): void {
    this.dynamicLoading();
    setTimeout(()=>{}, 1000)
    if (this.isFirst) {
      this.isFirst = false
      router.replaceNamedRoute({
        name: 'WXLoginPage'
      })
    }
  }
  build() {
    RelativeContainer() {
      Text(this.message + this.isFirst)
        .id('FirstPageHelloWorld')
        .fontSize(50)
        .fontWeight(FontWeight.Bold)
        .alignRules({
          center: { anchor: '__container__', align: VerticalAlign.Center },
          middle: { anchor: '__container__', align: HorizontalAlign.Center }
        })
    }
    .height('100%')
    .width('100%')
  }
}