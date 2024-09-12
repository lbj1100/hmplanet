export class DynamicModel {
  id: string = '0';
  author: string = '';
  authorAvatar: string | Resource = '';
  time: string = '';
  content: string = '';
  // 星球名称
  planetName: string = '';
  images: Array<string | Resource> = [$r('app.media.app_icon')];
  likeCount: number = 0;
  commentCount: number = 0;

  // 全参构造函数，初始化数据
  constructor(
    id: string,
    author: string = '用户名',
    authorAvatar: string | Resource = $r('app.media.app_icon'),
    time: string = '2021-01-01',
    content: string = ' NEXT Beta 版本鸿蒙应用开发视频教程来了，由于平台暂时无法提交视频，需要达到一定人数，所以目前提供哗哩哔哩视频链接供大家学习，后期会在星球持续更新，学习内容包含 环境搭建、ArkTS语法、ArkUI组件、Ability开发、服务卡片、数据管理、文件管理、网络请求、分布式特性、项目等知识点，祝大家学习愉快!!!',
    planetName: string = '鸿蒙学习社区（HarmonyOS NEXT）',
    images: Array<string | Resource> = [$r('app.media.app_icon')],
    likeCount: number = 0,
    commentCount: number = 0
  ) {
    this.id = id;
    this.author = author;
    this.authorAvatar = authorAvatar;
    this.time = time;
    this.content = content;
    this.planetName = planetName;
    this.images = images;
    this.likeCount = likeCount;
    this.commentCount = commentCount;
  }
}
const dynamicData: DynamicModel[] = [
  new DynamicModel('0'),
  new DynamicModel('1'),
  new DynamicModel('2'),
  // new DynamicModel('3'),
  // new DynamicModel('4'),
  // new DynamicModel('5'),
  // new DynamicModel('6'),
  // new DynamicModel('7'),
]

export { dynamicData };