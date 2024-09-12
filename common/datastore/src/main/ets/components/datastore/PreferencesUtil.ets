

import { preferences } from '@kit.ArkData';
import { common } from '@kit.AbilityKit';

let PREFERENCES_NAME: string = 'default';
/**
 * 用于使用 Arkts 框架管理应用程序偏好设置的实用工具类。
 */

export class PreferencesUtil {
  private preferences?: preferences.Preferences; // 应用程序偏好设置的引用。
  private context = getContext(this) as common.UIAbilityContext; // UI 能力的上下文。
  private static instance: PreferencesUtil; // PreferencesUtil 的单例实例。

  constructor() {
    this.initPreference(PREFERENCES_NAME); // 使用指定的存储名称初始化偏好设置。
  }

  /**
   * 获取 PreferencesUtil 的单例实例。
   * @returns PreferencesUtil 的单例实例。
   */
  public static getInstance(): PreferencesUtil {
    if (!PreferencesUtil.instance) {
      PreferencesUtil.instance = new PreferencesUtil();
    }
    return PreferencesUtil.instance;
  }

  /**
   * 异步初始化应用程序偏好设置。
   * @param storeName 偏好设置存储的名称。
   */
  async initPreference(storeName: string): Promise<void> {
    return preferences.getPreferences(this.context, storeName)
      .then((preferences: preferences.Preferences) => {
        this.preferences = preferences;
      });
  }

  /**
   * 异步设置偏好设置的值。
   * @param key 偏好设置的键。
   * @param value 要设置的值。
   */
  async setValue<T>(key: string, value: T): Promise<void> {
    if (this.preferences) {
      this.preferences.put(key, JSON.stringify(value)).then(() => {
        this.saveUserData();
      })
    } else {
      this.initPreference(PREFERENCES_NAME).then(() => {
        this.setValue<T>(key, value);
      });
    }
  }

  /**
   * 同步设置偏好设置的值。
   * @param key 偏好设置的键。
   * @param value 要设置的值。
   */
  setValueSync<T>(key: string, value: T): void {
    if (this.preferences) {
      this.preferences.put(key, JSON.stringify(value));
      this.saveUserData();
    } else {
      this.initPreference(PREFERENCES_NAME).then(() => {
        this.setValue<T>(key, value);
      });
    }
  }

  /**
   * 获取偏好设置的值。
   * @param key 偏好设置的键。
   * @returns 与键对应的值，如果不存在则返回 null。
   */
  async getValue<T>(key: string): Promise<T | null> {
    if (this.preferences) {
      return this.preferences.get(key, '').then((res: preferences.ValueType) => {
        let value: T | null = null;
        if (res) {
          value = JSON.parse(res as string) as T;
        }
        return value;
      });
    } else {
      return this.initPreference(PREFERENCES_NAME).then(() => {
        return this.getValue<T>(key);
      });
    }
  }

  /**
   * 同步获取偏好设置的值。
   * @param key 偏好设置的键。
   * @returns 与键对应的值，如果不存在则返回 null。
   */
  getValueSync<T>(key: string): T | null {
    if (!this.preferences) {
      return null;
    }
    let res = this.preferences.getSync(key, '');
    if (!res) {
      return null;
    }
    return JSON.parse(res as string) as T;
  }

  /**
   * 检查是否存在指定键的偏好设置。
   * @param key 偏好设置的键。
   * @returns 如果偏好设置存在，则返回 true，否则返回 false。
   */
  async hasValue(key: string): Promise<boolean> {
    if (this.preferences) {
      return this.preferences.has(key);
    } else {
      return this.initPreference(PREFERENCES_NAME).then(() => {
        return this.hasValue(key);
      });
    }
  }

  /**
   * 同步检查是否存在指定键的偏好设置。
   * @param key 偏好设置的键。
   * @returns 如果偏好设置存在，则返回 true，否则返回 false。
   */

  hasValueSync(key: string): boolean {
    if (!this.preferences) {
      return false;
    }
    return this.preferences.hasSync(key);
  }

  /**
   * 删除偏好设置的值。
   * @param key 要删除的偏好设置的键。
   */
  async deleteValue(key: string): Promise<void> {
    if (this.preferences) {
      this.preferences.delete(key).then(() => {
        this.saveUserData();
      });
    } else {
      this.initPreference(PREFERENCES_NAME).then(() => {
        this.deleteValue(key);
      });
    }
  }

  /**
   * 同步删除偏好设置的值。
   * @param key 要删除的偏好设置的键。
   */
  deleteValueSync(key: string): void {
    if (this.preferences) {
      this.preferences.deleteSync(key);
      this.saveUserData();
    } else {
      this.initPreference(PREFERENCES_NAME).then(() => {
        this.deleteValue(key);
      });
    }
  }

  /**
   * 将用户数据保存到偏好设置中。
   */
  saveUserData() {
    this.preferences?.flush();
  }
}
