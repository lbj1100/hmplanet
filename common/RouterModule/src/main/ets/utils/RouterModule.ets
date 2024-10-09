import { RouterModel } from '../model/RouterModel';
import Logger from './Logger';

export class RouterModule {
  // 构建器Map
  static builderMap: Map<string, WrappedBuilder<[object]>> = new Map<string, WrappedBuilder<[object]>>();
  // 路由Map
  static routerMap: Map<string, NavPathStack> = new Map<string, NavPathStack>();

  // Registering a builder by name.
  //
  public static registerBuilder(builderName: string, builder: WrappedBuilder<[object]>): void {
    RouterModule.builderMap.set(builderName, builder);
  }

  // Get builder by name.
  public static getBuilder(builderName: string): WrappedBuilder<[object]> {
    const builder = RouterModule.builderMap.get(builderName);
    if (!builder) {
      Logger.info('not found builder ' + builderName);
    }
    return builder as WrappedBuilder<[object]>;
  }

  // Registering a router by name.
  public static createRouter(routerName: string, router: NavPathStack): void {
    RouterModule.routerMap.set(routerName, router);
  }

  // Get router by name.
  public static getRouter(routerName: string): NavPathStack {
    return RouterModule.routerMap.get(routerName) as NavPathStack;
  }

  // Test import
  public static importTest(routerName: string): void {
    import(routerName).then((ns: ESObject): void => {
      console.log('lbj!!! ns:', ns)
    })
      .catch((error: Error) => {
        console.error('lbj!!! error:', error)
      });
  }

  public static async setInterception(router: RouterModel): Promise<void> {
    RouterModule.getRouter(router.routerName).setInterception({})
  }


  // Jumping to a Specified Page by Obtaining the Page Stack.
  public static async push(router: RouterModel): Promise<void> {
    /**
     * TO NOTE: 路由栈判断
     * 这里判断是否存在路由栈，如果存在则不再push，而是直接跳转到路由栈顶
     *
     * 然而不只这一种方法
     * 1. 可以直接push，这样就会有多个相同的路由
     * 2. 可以popToName，这样就会只有一个相同的路由，但会把name之后的路由（即栈中在 name 之上的路由）都pop掉
     * 3. 可以拦截和栈顶相同的路由，这样就不会有连续的相同路由，但可以有多个不连续的相同路由
     */
    // 路由判断是否存在路由栈
    let routerModule = RouterModule.getRouter(router.routerName)
    let indexArr = routerModule.getIndexByName(router.builderName)
    if (indexArr.length > 0) {
      /* 更多方法
      // 只拦截存在的路由栈顶相同的路由
      console.log('lbj!!! indexArr:', indexArr.toString())
      if (indexArr[indexArr.length - 1] === (routerModule.size() - 1))
        return Promise.reject();
      // 跳转路由栈中存在的路由
      routerModule.popToIndex(indexArr[indexArr.length - 1])
      return Promise.reject();
      */
      // 移动到路由栈顶
      routerModule.moveToTop(router.builderName)
      return Promise.reject();
    }
    // 根据builderName获取模块名
    const harName = router.builderName.split('_')[0];
    // Dynamically import the page to be redirected to.
    // 动态导入要跳转的页面
    await import(harName).then((ns: ESObject): Promise<void> => {
      // 从har模块中获取builder对象
      ns.harInit(router.builderName)
      console.log('lbj!!! harInit:', router.builderName)
      return Promise.resolve();
    })
      .catch((error: Error) => {
        console.error('lbj!!! error:', error)
        return Promise.reject();
      });
    RouterModule.getRouter(router.routerName).pushPath({ name: router.builderName, param: router.param });
  }

  // Obtain the page stack and pop it.
  public static pop(routerName: string): void {
    // Find the corresponding route stack for pop.
    RouterModule.getRouter(routerName).pop();
  }

  // Get the page stack and clear it.
  public static clear(routerName: string): void {
    // Find the corresponding route stack for pop.
    RouterModule.getRouter(routerName).clear();
  }

  // Directly jump to the specified route.
  public static popToName(routerName: string, builderName: string): void {
    RouterModule.getRouter(routerName).popToName(builderName);
  }
}
