import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

import '../index.dart';

// 主题颜色
const _themes = <MaterialColor>[
  Colors.blue,
  Colors.cyan,
  Colors.teal,
  Colors.green,
  Colors.red
];

class Global {
  static SharedPreferences _prefs;
  static Profile profile = Profile();
  // 网络缓存对象
  static NetCache netCache = NetCache();

  // 可选主题列表
  static List<MaterialColor> get themes => _themes;
  // dart.vm.product 环境标识位
  static bool get isRelease => bool.fromEnvironment("dart.vm.product");

  // 初始化全局信息，会在App启动时执行
  static Future init() async {
    _prefs = await SharedPreferences.getInstance();
    String _profile = _prefs.getString("profile");
    if (_profile != null) {
      try {
        profile = Profile.fromJson(jsonDecode(_profile));
      } catch (e) {
        print(e);
      }
    }
    profile.cache = profile.cache ?? CacheConfig()
      ..enable = true
      ..maxAge = 3000
      ..maxCount = 100;

    // TODO 网络初始化
  }

  // 持久化Profile
  static saveProfile() {
    _prefs.setString("profile", jsonEncode(profile.toJson()));
  }
}
