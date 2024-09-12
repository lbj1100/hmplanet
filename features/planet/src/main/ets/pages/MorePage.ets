import { router } from '@kit.ArkUI'
import { CommonDataSource, StyleConstants, TabsComponent } from '@ohos/common';
import { Planet } from '@ohos/common';
import { cardData } from '../model/CardData';
import { MorePlanetItem } from '../components/MorePlanetItem';
import { PlanetConstants } from '../constants/PlanetConstants';

@Entry({ routeName: 'MorePage' })
@Component
export struct MorePage {

  bottomRectHeight: string = AppStorage.get<number>('bottomRectHeight') + 'px';
  statusBarHeight: string = AppStorage.get<number>('statusBarHeight') + 'px';
  @State title: string = 'More Page';
  // 分类列表
  @State typeList: string[] = [];
  // 星球列表
  @State planetList: Planet[] = [];

  aboutToAppear(): void {
    this.title = router.getParams() ? (router.getParams() as Record<string, string>)['title'] : 'More Page';
    // console.log('lbj!!!' + (router.getParams() as Map<string, string>).get('params'))
    this.typeList = ['全部', '个人成长', '3', '4', '5', '6', '7', '8', '9', '10'];
    this.planetList = cardData;
    // TODO 网络请求
  }


  build() {
    Flex({ direction: FlexDirection.Column }) {
      RelativeContainer() {
        Button()
          .width('16vp')
          .height('16vp')
          .zIndex(1)
          .type(ButtonType.Normal)
          .backgroundColor(Color.Transparent)
          .onClick(() => {
            router.back();
          })
          .backgroundImage($r('app.media.ic_left_arrow'))
          .backgroundImageSize(ImageSize.Contain)
          .borderRadius(0)
        Text(this.title)
          .fontSize(18)
          .fontWeight(FontWeight.Normal)
          .alignRules({
            // left: { anchor: '__container__', align: HorizontalAlign.Center },
            // right: { anchor: '__container__', align: HorizontalAlign.Center }
            middle: { anchor: '__container__', align: HorizontalAlign.Center }
          })
          .id('title')

      }
      .width(StyleConstants.FULL_WIDTH)
      .height(50)
      // .alignItems(VerticalAlign.Center)
      .padding({
        top: $r('app.float.vp_twelve'),
        bottom: $r('app.float.vp_twelve'),
        left: $r('app.float.vp_eight'),
        right: $r('app.float.vp_eight')
      })

      TabsComponent({
        tabsList: this.typeList,
        itemClick: (index: number) => {
          // TODO 网络请求
          console.log('index: ' + index)
        }
      })
        .margin({
          bottom: $r('app.float.vp_twelve')
        })

      /*Row() {
        List() {
          ForEach(this.typeList, (item: string, index: number) => {
            ListItem() {
              Text(item)
                .fontColor(this.typeIndex === index ? $r('app.color.more_page_item_focus_font') :
                $r('app.color.more_page_item_font'))
                .fontSize(16)
                .fontWeight(FontWeight.Normal)
                .padding({
                  top: $r('app.float.vp_six'),
                  bottom: $r('app.float.vp_six'),
                  left: $r('app.float.vp_eight'),
                  right: $r('app.float.vp_eight')
                })
                .margin({
                  left: (index === 0) ? 0 : $r('app.float.vp_six'),
                  right: (index === this.typeList.length - 1) ? 0 : $r('app.float.vp_six')
                })// 背景颜色选中时改变
                .backgroundColor(index === this.typeIndex ? $r('app.color.more_page_item_focus_bg') :
                $r('app.color.more_page_item_bg'))// .backgroundColor($r('app.color.more_page_item_bg'))
                .borderRadius($r('app.float.vp_eight'))
                .onClick(() => {
                  this.typeIndex = index;
                  // 网络请求
                })
            }
          })
        }
        .width(StyleConstants.FULL_WIDTH)
        .height($r('app.float.vp_thirtysix'))
        .scrollBar(BarState.Off)
        .listDirection(Axis.Horizontal)
      }
      .height($r('app.float.vp_thirtysix'))
      .margin({
        top: $r('app.float.vp_twenty'),
        bottom: $r('app.float.vp_twelve')
      })
      .width(StyleConstants.FULL_WIDTH)*/


      // .alignRules({
      //   top: { anchor: 'title', align: VerticalAlign.Bottom }
      // })
      // .id('type')

      Row() {
        List() {
          LazyForEach(new CommonDataSource<Planet>(this.planetList), (item: Planet) => {
            ListItem() {
              // this.RecommendedItem(item)
              MorePlanetItem({ item: item })
            }
          })
        }
        .width(StyleConstants.FULL_WIDTH)
        .height(StyleConstants.FULL_HEIGHT)
        .cachedCount(6)
        .alignListItem(ListItemAlign.Center)
        .scrollBar(BarState.Off)
      }

      // .alignRules({
      //   top: { anchor: 'type', align: VerticalAlign.Bottom }
      // })
    }
    .height(StyleConstants.FULL_HEIGHT)
    .backgroundColor($r('app.color.more_page_bg'))
    .padding({
      top: this.statusBarHeight,
      bottom: this.bottomRectHeight,
      left: $r('app.float.vp_eight'),
      right: $r('app.float.vp_eight')
    }) // 此处margin具体数值在实际中应与导航条区域高度保持一致
  }
}
