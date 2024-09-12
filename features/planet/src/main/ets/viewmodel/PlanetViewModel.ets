import { httpRequestGet, ResponseResult, CommonConstant as Const } from '@ohos/network';

export class PlanetViewModel {
  private fetchData<T>(url: string, defaultData?: T): Promise<T> {
    return new Promise((resolve: (value: T) => void, reject: (reason: T) => void) => {
      httpRequestGet(url)
        .then((data: ResponseResult) => {
          if (data.code === Const.SERVER_CODE_SUCCESS) {
            resolve(data.data as T);
          } else {
            console.error('fetchData failed', JSON.stringify(data));
            reject(defaultData ? defaultData : data.data as T);
          }
        })
        .catch((err: Error) => {
          console.error('fetchData failed', JSON.stringify(err));
          reject(defaultData ? defaultData : err as T);
        });
    });
  }
}