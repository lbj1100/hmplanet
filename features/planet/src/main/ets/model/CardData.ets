import { Planet } from '@ohos/common'

// const cardData: Planet[] = [
//   {
//     category_id: "1",
//     id: "1",
//     title: "XXXX40 Pro",
//     author: "华为",
//     authorImg: $r('app.media.default_author_img'),
//     images: $r('app.media.default_img'),
//     description: "XXXX Pro 5G手机",
//     price: 6399,
//     promotion: ["新品"]
//   },
//   {
//     category_id: "1",
//     id: "2",
//     title: "XXXX40 Pro",
//     author: "华为",
//     authorImg: $r('app.media.default_author_img'),
//     images: $r('app.media.default_img'),
//     description: "XXXX Pro 5G手机",
//     price: 6399,
//     promotion: ["新品"]
//   },
//   {
//     category_id: "1",
//     id: "3",
//     title: "XXXX40 Pro",
//     author: "华为",
//     authorImg: $r('app.media.default_author_img'),
//     images: $r('app.media.default_img'),
//     description: "XXXX Pro 5G手机",
//     price: 6399,
//     promotion: ["新品"]
//   },
//   {
//     category_id: "1",
//     id: "4",
//     title: "XXXX40 Pro",
//     author: "华为",
//     authorImg: $r('app.media.default_author_img'),
//     images: $r('app.media.default_img'),
//     description: "XXXX Pro 5G手机",
//     price: 6399,
//     promotion: ["新品"]
//   },
//   {
//     category_id: "1",
//     id: "5",
//     title: "XXXX40 Pro",
//     author: "华为",
//     authorImg: $r('app.media.default_author_img'),
//     images: $r('app.media.default_img'),
//     description: "XXXX Pro 5G手机",
//     price: 6399,
//     promotion: ["新品"]
//   },
//   {
//     category_id: "1",
//     id: "6",
//     title: "XXXX40 Pro",
//     author: "华为",
//     authorImg: $r('app.media.default_author_img'),
//     images: $r('app.media.default_img'),
//     description: "XXXX Pro 5G手机",
//     price: 6399,
//     promotion: ["新品"]
//   },
//   {
//     category_id: "1",
//     id: "7",
//     title: "XXXX40 Pro",
//     author: "华为",
//     authorImg: $r('app.media.default_author_img'),
//     images: $r('app.media.default_img'),
//     description: "XXXX Pro 5G手机",
//     price: 6399,
//     promotion: ["新品"]
//   },
//   {
//     category_id: "1",
//     id: "8",
//     title: "XXXX40 Pro",
//     author: "华为",
//     authorImg: $r('app.media.default_author_img'),
//     images: $r('app.media.default_img'),
//     description: "XXXX Pro 5G手机",
//     price: 6399,
//     promotion: ["新品"]
//   }
// ]
const cardData: Planet[] = [
  new Planet(
    "1",
    "1",
    "如何压榨员工的剩余价值",
    "经理",
    $rawfile('avatar/manger_avatar.png'),
    $r('app.media.default_img'),
    "探讨如何提升企业效率，发掘员工的最大潜力。",
    6399,
    ["新品"],
    "鸿蒙专栏"
  ),
  new Planet(
    "1",
    "2",
    "异国生存之道",
    "外国人",
    $rawfile('avatar/foreigner_avatar.png'),
    $r('app.media.default_img'),
    "分享在异国他乡生活工作时应对挑战的经验。",
    6399,
    ["新品"]
  ),
  new Planet(
    "1",
    "3",
    "如何成为一个邪恶魔术师",
    "魔术师",
    $rawfile('avatar/magician_avatar.png'),
    $r('app.media.default_img'),
    "揭示成为一名魔术师背后的秘密和神秘技巧。",
    6399,
    ["新品"]
  ),
  new Planet(
    "1",
    "4",
    "颗粒度和抓手的重要性",
    "工程师",
    $rawfile('avatar/engineer_avatar.png'),
    $r('app.media.default_img'),
    "讨论项目管理中颗粒度和抓手对于工程师的意义。",
    6399,
    ["新品"]
  ),
  new Planet(
    "1",
    "5",
    "母猪的产后护理",
    "医生",
    $rawfile('avatar/doctor_avatar.png'),
    $r('app.media.default_img'),
    "关于母猪产后护理的科学方法和实用技巧。",
    6399,
    ["新品"]
  ),
]

export { cardData }