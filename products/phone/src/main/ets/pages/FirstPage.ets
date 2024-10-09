import { router } from '@kit.ArkUI';

@Entry
@Component
struct FirstPage {
  @State message: string = 'Hello World';
  isFirst:boolean = true

  dynamicLoading(): void {
    try {
      import('@ohos/login/src/main/ets/pages/WXLoginPage');
      import('../pages/MainPage');
    } catch (err) {
    }
  }

  aboutToAppear(): void {
    this.dynamicLoading();
    // TODO 资源加载
    setTimeout(()=>{
      if (this.isFirst) {
        this.isFirst = false
        router.replaceNamedRoute({
          name: 'WXLoginPage'
        })
      } else {
        router.replaceNamedRoute({
          name: 'MainPage'
        })
      }
    }, 1000)

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