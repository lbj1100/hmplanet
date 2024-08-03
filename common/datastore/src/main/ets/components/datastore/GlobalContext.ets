

export class GlobalContext {
  private static instance: GlobalContext;
  private _objects: Map<string, Object>;

  private constructor() {
    this._objects = new Map<string, Object>();
  }

  public static getContext(): GlobalContext {
    if (!GlobalContext.instance) {
      GlobalContext.instance = new GlobalContext();
    }
    return GlobalContext.instance;
  }

  getObject(key: string): Object | undefined {
    return this._objects.get(key);
  }

  setObject(key: string, objectClass: Object): void {
    this._objects.set(key, objectClass);
  }

  deleteObject(key: string): void {
    this._objects.delete(key);
  }
}