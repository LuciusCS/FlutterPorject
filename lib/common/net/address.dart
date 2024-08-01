///用于表示网络请求地址
class Address {
  ///用于表示ip地址
  // static String host = "http://47.105.218.221";
  static String host = "http://192.168.19.123:8002";

  // static String host = "http://192.168.67.252:8011";
  static String prefix = "/";

  ///用于获取版本信息
  static getVersionInfo() {
    return "http://218.58.62.115:11188/ble_photovoltaic/ble_version_android.json";
  }

  static getVersionIOSInfo() {
    return "http://218.58.62.115:11188/ble_photovoltaic/ble_version_ios.json";
  }


  ///用于表示数据上传接口
  static uploadShowDB() {
    return "${host}${prefix}maintenance/bleShowMB/save";
    // return "http://192.168.19.23:8066/maintenance/bleShowMB/save";
  }

  ///用谷图片上传接口
  static uploadImages() {
    return "http://218.58.62.115:11188/images/uploadReturnString";
    // return "${host}${prefix}maintenance/image/uploadReturnString";
  }

  ///用于表示用户登录验证
  static login(String name, String password, String eigenvalue) {
    return "${host}${prefix}maintenance/bleUser/login?name=${name}&password=${password}&eigenvalue=${eigenvalue}";
  }

  ///用于分块上传数据
  static uploadFileByChunk(){
    return "${host}${prefix}/upload/chunk";
  }

}
