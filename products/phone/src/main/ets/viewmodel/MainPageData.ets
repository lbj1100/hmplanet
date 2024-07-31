export class TabButtonInfoModel {
  index: number = 0;
  img: Resource = $r('app.media.ic_planet_normal');
  selectImg: Resource = $r('app.media.ic_planet_focus');
  title: Resource = $r('app.string.planet');
}

const tabButtonInfo: TabButtonInfoModel[] = [
  {
    index: 0,
    img: $r('app.media.ic_planet_normal'),
    selectImg: $r('app.media.ic_planet_focus'),
    title: $r('app.string.planet')
  },
  {
    index: 1,
    img: $r('app.media.ic_dynamic_normal'),
    selectImg: $r('app.media.ic_dynamic_focus'),
    title: $r('app.string.dynamic')
  },
  {
    index: 2,
    img: $r('app.media.ic_mine_normal'),
    selectImg: $r('app.media.ic_mine_focus'),
    title: $r('app.string.me')
  }
]

export { tabButtonInfo }