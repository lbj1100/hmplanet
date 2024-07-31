export default class CardInfoModel {
  index: number = 0;
  // 星球名称
  title: Resource = $r('app.string.default_title');
  // 星球图片
  img: Resource = $r('app.media.default_img');
  // 星球作者
  author: Resource = $r('app.string.default_author');
  // 星球作者头像
  authorImg: Resource = $r('app.media.default_author_img');

  constructor(index: number, title: Resource, img: Resource, author: Resource, authorImg: Resource) {
    this.index = index;
    this.title = title;
    this.img = img;
    this.author = author;
    this.authorImg = authorImg;
  }

  toString(): string {
    return `CardInfoModel{index=${this.index}, title=${this.title}, img=${this.img}, author=${this.author}, authorImg=${this.authorImg}}`
  }
}

const cardInfo: CardInfoModel[] = [
  // {
  //   index: 0,
  //   img: $r('app.media.default_img'),
  //   title: $r('app.string.default_title')
  // },
  // {
  //   index: 1,
  //   img: $r('app.media.default_img'),
  //   title: $r('app.string.default_title')
  // },
  // {
  //   index: 2,
  //   img: $r('app.media.default_img'),
  //   title: $r('app.string.default_title')
  // }

  new CardInfoModel(0, $r('app.string.default_title'), $r('app.media.default_img'), $r('app.string.default_author'), $r('app.media.default_author_img')),
  new CardInfoModel(1, $r('app.string.default_title'), $r('app.media.default_img'), $r('app.string.default_author'), $r('app.media.default_author_img')),
  // new CardInfoModel(2, $r('app.string.default_title'), $r('app.media.default_img'), $r('app.string.default_author'), $r('app.media.default_author_img'))
]

export { cardInfo }