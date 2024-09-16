// Key of the builderMap of the routing table in the RouterModule. The format is as follows:{bundleName}_${pageName}.
export class BuilderNameConstants {
  static readonly HARPLANET_DETAILS: string = '@ohos/planet_details';
  static readonly HARPLANET_MORE: string = '@ohos/planet_more';
  static readonly HARPLANET_SEARCH: string = '@ohos/planet_search';
  static readonly HARDYNAMIC_ABOUT: string = '@ohos/dynamic_about';
  static readonly HARDYNAMIC_NOTES: string = '@ohos/dynamic_notes';
  static readonly HARDYNAMIC_SYSMAG: string = '@ohos/dynamic_sysmag';

}

// Indicates the key of the routerMap table in the RouterModule.
export class RouterNameConstants {
  static readonly PHONE_HAP: string = 'PhoneHap_Router';
  static readonly PLANET_HAR: string = 'PlantHar_Router';
}