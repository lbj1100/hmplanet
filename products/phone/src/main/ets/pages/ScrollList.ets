@Entry
@Component
struct ScrollList {
  @State message: string = 'Hello World';
  @State isEnd: boolean = false;
  @State listMge: string = 'listMge';

  build() {
    Column() {
      Text(this.message)
        .fontSize(20)
      Scroll() {
        Column() {
          Text("我是Scroll头部")
            .fontSize(50)
            .fontColor('#000000')
            .fontWeight(FontWeight.Bold)
            .height(100)
          List() {
            ForEach([1, 2, 3, 4, 5, 6, 7, 8, 9, 10], (item: number) => {
              ListItem() {
                Text(`Item ${item}  ` + this.listMge)
                  .fontSize(20)
                  .fontColor('#000000')
                  .height(100)
              }
            }, (item: number) => item.toString())
          }
          .height(800)
          .nestedScroll({
            scrollForward: NestedScrollMode.PARENT_FIRST,
            scrollBackward: NestedScrollMode.SELF_FIRST
          })
          .onScrollStart(() => {
            this.listMge = '子list开始滚动'
          })
          .onReachStart(() => {
            this.listMge = '子list到顶了'
            this.isEnd = false
          })
          .onReachEnd(() => {
            this.listMge = '子list到底了'
          })

        }
      }
      // .scrollable(!this.isEnd ? ScrollDirection.Vertical : ScrollDirection.None)
      .onReachEnd(() => {
        this.message = '父到底了'
        this.isEnd = true
      })
      .onScrollStart(() => {
        this.message = '父开始滚动'
      })
    }

  }
}