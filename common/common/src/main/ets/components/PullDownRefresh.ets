import { RefreshState, CommonConstant as Const, PageState } from './CommonConstant';

export function listTouchEvent(model: RefreshModel, event: TouchEvent, onRefresh: () => Promise<void>) {
  switch (event.type) {
    case TouchType.Down:
      model.downY = event.touches[0].y;
      model.lastMoveY = event.touches[0].y;
      break;
    case TouchType.Move:
      if ((model.isRefreshing === true) || (model.isLoading === true)) {
        return;
      }
      let isDownPull = event.touches[0].y - model.lastMoveY > 0;
      if (((isDownPull === true) || (model.isPullRefreshOperation === true)) && (model.isCanLoadMore === false)) {
        touchMovePullRefresh(model, event);
      } else {
        // touchMoveLoadMore(model, event);
      }
      model.lastMoveY = event.touches[0].y;
      break;
    case TouchType.Cancel:
      break;
    case TouchType.Up:
      if ((model.isRefreshing === true) || (model.isLoading === true)) {
        return;
      }
      if ((model.isPullRefreshOperation === true)) {
        touchUpPullRefresh(model, onRefresh);
      } else {
        console.log('up load more');
        // touchUpLoadMore(model);
      }
      break;
    default:
      // console.log('default');
      break;
  }
}


export function touchMovePullRefresh(model: RefreshModel, event: TouchEvent) {
  if (model.startIndex === 0) {
    model.isPullRefreshOperation = true;
    let height = model.pullDownRefreshHeight;
    model.offsetY = event.touches[0].y - model.downY;
    if (model.offsetY >= height) {
      pullRefreshState(model, RefreshState.Release);
      model.offsetY = height + model.offsetY * Const.Y_OFF_SET_COEFFICIENT;
    } else {
      pullRefreshState(model, RefreshState.DropDown);
    }
    if (model.offsetY < 0) {
      model.offsetY = 0;
      model.isPullRefreshOperation = false;
    }
  }
}



export function touchUpPullRefresh(model: RefreshModel, onRefresh: () => Promise<void>) {
  console.log('touchUpPullRefresh');
  if (model.isCanRefresh === true) {
    console.log('isCanRefresh');
    model.offsetY = vp2px(model.pullDownRefreshHeight);
    pullRefreshState(model, RefreshState.Refreshing);
    setTimeout(async () => {
      try {
        await onRefresh();
        pullRefreshState(model, RefreshState.Success);
      } catch (error) {
        pullRefreshState(model, RefreshState.Fail);
      }
      closeRefresh(model);
    }, Const.DELAY_TIME);
  } else {
    closeRefresh(model);
  }
}

export function pullRefreshState(model: RefreshModel, state: number) {
  switch (state) {
    case RefreshState.DropDown:
      model.pullDownRefreshText = $r('app.string.pull_down_refresh_text');
      model.pullDownRefreshImage = $r('app.media.ic_pull_down_refresh');
      model.isCanRefresh = false;
      model.isRefreshing = false;
      model.isVisiblePullDown = true;
      break;
    case RefreshState.Release:
      model.pullDownRefreshText = $r('app.string.release_refresh_text');
      model.pullDownRefreshImage = $r('app.media.ic_pull_up_refresh');
      model.isCanRefresh = true;
      model.isRefreshing = false;
      break;
    case RefreshState.Refreshing:
      model.offsetY = vp2px(model.pullDownRefreshHeight);
      model.pullDownRefreshText = $r('app.string.refreshing_text');
      model.pullDownRefreshImage = $r('app.media.ic_pull_up_load');
      model.isCanRefresh = true;
      model.isRefreshing = true;
      break;
    case RefreshState.Success:
      model.pullDownRefreshText = $r('app.string.refresh_success_text');
      model.pullDownRefreshImage = $r('app.media.ic_succeed_refresh');
      model.isCanRefresh = true;
      model.isRefreshing = false;
      break;
    case RefreshState.Fail:
      model.pullDownRefreshText = $r('app.string.refresh_fail_text');
      model.pullDownRefreshImage = $r('app.media.ic_fail_refresh');
      model.isCanRefresh = true;
      model.isRefreshing = false;
      break;
    default:
      break;
  }
}

export function closeRefresh(model: RefreshModel) {
  setTimeout(() => {
    let delay = Const.RefreshConstant_DELAY_PULL_DOWN_REFRESH;
    if (model.isCanRefresh === true) {
      pullRefreshState(model, RefreshState.Success);
      delay = Const.RefreshConstant_DELAY_SHRINK_ANIMATION_TIME;
    }
    animateTo({
      duration: Const.RefreshConstant_CLOSE_PULL_DOWN_REFRESH_TIME,
      delay: delay,
      onFinish: () => {
        pullRefreshState(model, RefreshState.DropDown);
        model.isVisiblePullDown = false;
        model.isPullRefreshOperation = false;
      }
    }, () => {
      model.offsetY = 0;
    })
  }, model.isCanRefresh ? Const.DELAY_ANIMATION_DURATION : 0);
}

export class RefreshModel {
  // newsData: Array<NewsData> = [];
  // 当前页数
  currentPage: number = 1;
  // 每页数量
  pageSize: number = Const.PAGE_SIZE;
  // 下拉刷新文本
  pullDownRefreshText: Resource = $r('app.string.pull_down_refresh_text');
  // 下拉刷新图片
  pullDownRefreshImage: Resource = $r('app.media.ic_pull_down_refresh');
  // 下拉刷新高度
  pullDownRefreshHeight: number = Const.CUSTOM_LAYOUT_HEIGHT;
  // 是否显示下拉刷新
  isVisiblePullDown: boolean = false;
  // 上拉加载文本
  pullUpLoadText: Resource = $r('app.string.pull_up_load_text');
  // 上拉加载图片
  pullUpLoadImage: Resource = $r('app.media.ic_pull_up_load');
  // 上拉加载高度
  pullUpLoadHeight: number = Const.CUSTOM_LAYOUT_HEIGHT;
  // 是否显示上拉加载
  isVisiblePullUpLoad: boolean = false;
  offsetY: number = 0;
  pageState: number = PageState.Loading;
  hasMore: boolean = true;
  startIndex = 0;
  endIndex = 0;
  downY = 0;
  lastMoveY = 0;
  isRefreshing: boolean = false;
  isCanRefresh = false;
  isPullRefreshOperation = false;
  isLoading: boolean = false;
  isCanLoadMore: boolean = false;
}