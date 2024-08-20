import { RefreshState, CommonConstant as Const, PageState } from './CommonConstant';

export function listTouchEvent(model: RefreshModel, event: TouchEvent, onRefresh: () => Promise<void>) {
  switch (event.type) {
    case TouchType.Down:
      // console.log('down');
      model.downY = event.touches[0].y;
      model.lastMoveY = event.touches[0].y;
      break;
    case TouchType.Move:
      // console.log('move');
      if ((model.isRefreshing === true) || (model.isLoading === true)) {
        return;
      }
      let isDownPull = event.touches[0].y - model.lastMoveY > 0;
      if (((isDownPull === true) || (model.isPullRefreshOperation === true)) && (model.isCanLoadMore === false)) {
        // console.log('move pull refresh');
        touchMovePullRefresh(model, event);
      } else {
        // touchMoveLoadMore(model, event);
        // console.log('move load more');
      }
      model.lastMoveY = event.touches[0].y;
      break;
    case TouchType.Cancel:
      // console.log('cancel');
      break;
    case TouchType.Up:
      // console.log('up');
      if ((model.isRefreshing === true) || (model.isLoading === true)) {
        return;
      }
      if ((model.isPullRefreshOperation === true)) {
        touchUpPullRefresh(model, onRefresh);
      } else {
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
    let height = vp2px(model.pullDownRefreshHeight);
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
  if (model.isCanRefresh === true) {
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
  currentPage: number = 1;
  pageSize: number = Const.PAGE_SIZE;
  pullDownRefreshText: Resource = $r('app.string.pull_down_refresh_text');
  pullDownRefreshImage: Resource = $r('app.media.ic_pull_down_refresh');
  pullDownRefreshHeight: number = Const.CUSTOM_LAYOUT_HEIGHT;
  isVisiblePullDown: boolean = false;
  pullUpLoadText: Resource = $r('app.string.pull_up_load_text');
  pullUpLoadImage: Resource = $r('app.media.ic_pull_up_load');
  pullUpLoadHeight: number = Const.CUSTOM_LAYOUT_HEIGHT;
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