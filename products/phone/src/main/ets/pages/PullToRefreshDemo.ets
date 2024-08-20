// xxx.ets

import { PullToRefresh, PullToRefreshConfigurator } from '@ohos/pulltorefresh';
@Entry
@Component
struct PullToRefreshDemo {
  private scroller: Scroller = new Scroller();
  @State data: number[] = [1,2,3,4,5];

  @Builder
  private getListView() {
    Row() {
      List({scroller: this.scroller}) {
        ForEach(this.data, (item: number, index: number) => {
          ListItem() {
            Text('item ' + item)
          }
        })
      }
    }
  }

  build() {
    Column() {
      PullToRefresh({
        data: $data,
        scroller: this.scroller,
        customList: () => {
          this.getListView();
        },
        onRefresh: () => {
          return new Promise((resolve, reject) => {
            setTimeout(() => {
              this.data = [1,2,3,4,5,6,7,8,9,10];
              resolve('refresh success');
            }, 1000);
          });
        },
        refreshConfigurator: new PullToRefreshConfigurator().setMaxTranslate(50),
        customLoad: null,
        customRefresh: null,
      })
    }
  }
}