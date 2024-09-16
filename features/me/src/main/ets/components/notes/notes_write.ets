import { router } from '@kit.ArkUI';

@Entry({ routeName: 'notes_write' })
@Component
export struct Notes_write {
  @State showTip: boolean = true;
  @State textInput: string = '';
  bottomRectHeight: string = AppStorage.get<number>('bottomRectHeight') + 'px';
  statusBarHeight: string = AppStorage.get<number>('statusBarHeight') + 'px';


  aboutToAppear(): void {
    this.dynamicLoading();
  }

  dynamicLoading(): void {
    try {
      import('../notes/notes_write');
    } catch (err) {

    }
  }

  getCurrentDate(): string {
    const date = new Date();
    const month = (date.getMonth() + 1).toString().padStart(2, '0');
    const day = date.getDate().toString().padStart(2, '0');
    return `${month}/${day}`;
  }

  build() {
    Row() {
      Column() {
        Row() {
          Column() {
            Button() {
              Image($r('app.media.close'))
                .width(20)
                .height(20)
            }
            .backgroundColor(Color.Transparent)
            .onClick(() => {
              router.replaceNamedRoute({
                name: 'notes'
              })
            })
          }
        }
        .width('90%')
        .height('5%')

        Column() {
          if (this.showTip) {
            Row() {
              Text('笔记会展示到动态和足迹内，关注你的用户可查看，')
                .fontSize(10)
                .textAlign(TextAlign.Start)

              Button() {
                Image($r('app.media.close'))
                  .width(20)
                  .height(20)
              }
              .backgroundColor(Color.Transparent)
              .onClick(() => {
                this.showTip = false;
              })
            }
            .height('5%')
            .width('90%')
            .justifyContent(FlexAlign.SpaceBetween)
            .backgroundColor(Color.White)
            .borderRadius(5)
            .padding({ left: 10, right: 10 })
          }

          Blank()
            .height(10)

          Column() {

            Blank()
              .height(10)

            Row() {
              Image($r('app.media.Left_double_quotation_marks'))
                .width(30)
                .height(30)

              Text(this.getCurrentDate())
                .fontSize(20)
            }
            .width('90%')
            .justifyContent(FlexAlign.SpaceBetween)

            Blank()
              .height(5)

            TextArea({ placeholder: '写下你此刻的想法...' })
              .placeholderFont({ size: 14 })
              .width('99%')
              .height('100%')
              .maxLines(10)
              .fontSize(14)
              .caretColor(0x25b196)
              .backgroundColor(Color.Transparent)
              .showCounter(true, { thresholdPercentage: 1, highlightBorder: false })
              .onChange((value: string) => {
                this.textInput = value;
              });

          }
          .width('90%')
          .height(this.showTip ? '82%' : '87%') // 动态设置高度
          .borderRadius(5)
          .backgroundColor(Color.White)
        }

        Row(){
          Row(){
            Button(){
              Image($r('app.media.photo'))
                .width(20)
                .height(20)
            }
            .backgroundColor(Color.Transparent)

            Blank()
              .width(10)

            Button(){
              Image($r('app.media.emoji'))
                .width(20)
                .height(20)
            }
            .backgroundColor(Color.Transparent)
          }

          Row(){
            Button('发布')
              .fontSize(13)
              .enabled(this.textInput.length > 0)
              .backgroundColor(0x18b998)

          }
          .height(25)
        }
        .width('90%')
        .height('6%')
        .justifyContent(FlexAlign.SpaceBetween)

      }
      .height('100%')
      .width('100%')
    }
    .alignItems(VerticalAlign.Top)
    .backgroundColor(0xf5f6f8)
    .height('100%')
    .padding({
      top: this.statusBarHeight
    })
  }
}