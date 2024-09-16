// export { MainPage } from './src/main/ets/components/DynamicListItem'
import { BuilderNameConstants } from '@ohos/routermodule';

export { Dynamic } from './src/main/ets/pages/Dynamic'

export function harInit(builderName: string): void {
  // 动态引入要跳转的页面
  switch (builderName) {
    case BuilderNameConstants.HARDYNAMIC_ABOUT:
      import("./src/main/ets/pages/AboutMe");
      break;
    case BuilderNameConstants.HARDYNAMIC_NOTES:
      import("./src/main/ets/pages/Notes");
      break;
    case BuilderNameConstants.HARDYNAMIC_SYSMAG:
      import("./src/main/ets/pages/Sys_Message");
      break;
    default:
      break;
  }
}
