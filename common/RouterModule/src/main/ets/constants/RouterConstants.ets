// Key of the builderMap of the routing table in the RouterModule. The format is as follows:{bundleName}_${pageName}.
export class BuilderNameConstants {
  // 星球详情页面
  static readonly HARPLANET_DETAILS: string = '@ohos/planet_details';
  // 星球更多页面
  static readonly HARPLANET_MORE: string = '@ohos/planet_more';
  // 星球搜索页面
  static readonly HARPLANET_SEARCH: string = '@ohos/planet_search';
  // 动态关于页面
  static readonly HARDYNAMIC_ABOUT: string = '@ohos/dynamic_about';
  // 动态笔记页面
  static readonly HARDYNAMIC_NOTES: string = '@ohos/dynamic_notes';
  // 动态系统管理页面
  static readonly HARDYNAMIC_SYSMAG: string = '@ohos/dynamic_sysmag';
  // 我的草稿页面
  static readonly HARME_DRAFTS: string = '@ohos/me_drafts';
  // 我的足迹页面
  static readonly HARME_FOOTPRINT: string = '@ohos/me_footprint';
  // 我的笔记页面
  static readonly HARME_NOTES: string = '@ohos/me_notes';
  // 我的笔记写页面
  static readonly HARME_NOTES_WRITE: string = '@ohos/me_notes_write';
}

// Indicates the key of the routerMap table in the RouterModule.
export class RouterNameConstants {
  // MainPage页面的路由
  static readonly PHONE_HAP: string = 'PhoneHap_Router';
  // 星球页面的路由
  static readonly PLANET_HAR: string = 'PlantHar_Router';
  // 动态页面的路由
  static readonly DYNAMIC_HAR: string = 'DynamicHar_Router';
  // 我的页面的路由
  static readonly ME_HAR: string = 'MeHar_Router';
}