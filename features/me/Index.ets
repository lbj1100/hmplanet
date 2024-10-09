import { BuilderNameConstants } from '@ohos/routermodule';

export { MePage } from './src/main/ets/components/pages/MePage'


export function harInit(builderName: string): void {
  // 动态引入要跳转的页面
  switch (builderName) {
    case BuilderNameConstants.HARME_DRAFTS:
      import("./src/main/ets/components/pages/drafts");
      break;
    case BuilderNameConstants.HARME_FOOTPRINT:
      import("./src/main/ets/components/pages/footprint");
      break;
    case BuilderNameConstants.HARME_NOTES:
      import("./src/main/ets/components/notes/notes");
      break;
    case BuilderNameConstants.HARME_NOTES_WRITE:
      import("./src/main/ets/components/notes/notes_write");
      break;
    default:
      break;
  }
}