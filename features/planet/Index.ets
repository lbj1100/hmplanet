import { BuilderNameConstants } from '@ohos/routermodule';

export { PlanetPage } from './src/main/ets/pages/PlanetPage'



/**
 * TO NOTE: 动态引入页面
 *
 * @param builderName 页面名
 *
 * 1. 获取页面名
 * 2. 动态引入页面
 */
export function harInit(builderName: string): void {
  // 动态引入要跳转的页面
  switch (builderName) {
    case BuilderNameConstants.HARPLANET_DETAILS:
      console.log("lbj!!" + BuilderNameConstants.HARPLANET_DETAILS);
      import("./src/main/ets/pages/PlanetDetailsPage");
      break;
    case BuilderNameConstants.HARPLANET_MORE:
      console.log("lbj!!" + BuilderNameConstants.HARPLANET_MORE);
      import("./src/main/ets/pages/MorePage");
      break;
    case BuilderNameConstants.HARPLANET_SEARCH:
      console.log("lbj!!" + BuilderNameConstants.HARPLANET_SEARCH);
      import("./src/main/ets/pages/SearchPage");
      break;
    default:
      break;
  }
}