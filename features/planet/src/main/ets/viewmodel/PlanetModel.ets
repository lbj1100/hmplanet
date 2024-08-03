export class KV {
  key: string = '';
  value: string = '';
  image?: string = ''
}

export class Specification {
  id: string = '';
  title: string = '';
  data: KV[] = [];
}

// export class Card1 {
//   category_id?: string = '';
//   id: string = '';
//   title: string = '';
//   promotion?: string = '';
//   description: string = '';
//   images: string[] | Resource = [];
//   detail?: string[] | Resource = [];
//   price: number = 0;
//   specifications?: Specification[] = [];
// }

export class Planet {
  // 分类ID
  category_id?: string = '0';
  // 星球ID
  id: string = '0';
  // 星球名称
  title: string = '知识星球';
  // 星球描述
  description: string = '这是一个知识星球';
  // 星球作者
  author: string = '作者';
  // 星球作者头像
  authorImg: Resource = $r('app.media.default_author_img');
  // 星球促销信息
  promotion?: string[] = ['新星'];
  // 星球图片
  images: Resource = $r('app.media.default_img');
  // 星球价格
  price: number = 0;
}

/*export class Opt {
  yy: string = '';
  mm: string = '';
  dd: string = '';
  HH: string = '';
  MM: string = '';
  SS: string = '';
}

export class InsertOrderParams {
  orderId: string = '';
  uid: string = '';
  status: number = 0;
  createTime: string = '';
}*/
