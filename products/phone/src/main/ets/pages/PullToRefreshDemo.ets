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
            Text('item ' + item).height(300)
          }
        })
      }
    }
  }

  build() {
    Column() {
      PullToRefresh({
        data: this.data,
        scroller: this.scroller,
        customList: () => {
          this.getListView();
        },
        onRefresh: () => {
          return new Promise((resolve, reject) => {
            setTimeout(() => {
              this.data = [1,2,3,4,5];
              resolve('refresh success');
            }, 1000);
          });
        },
        onLoadMore: () => {
          return new Promise((resolve, reject) => {
            setTimeout(() => {
              this.data.push(10)
              resolve('load more success');
            }, 1000);
          });
        },
        refreshConfigurator: new PullToRefreshConfigurator().setHasLoadMore(true),
        customLoad: null,
        customRefresh: null,
      })
    }
  }
}