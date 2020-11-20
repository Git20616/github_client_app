import '../index.dart';

/// 用于Profile状态共享的基类
class ProfileChangeNotifier extends ChangeNotifier {
  Profile get _profile => Global.profile;

  @override
  void notifyListeners() {
    Global.saveProfile(); //保存Profile变更
    super.notifyListeners(); //通知Widget更新
  }
}

/// 用户状态在登录状态发生变化时更新、通知其依赖项
class UserModel extends ProfileChangeNotifier {
  User get user => _profile.user;

  // APP是否登录(如果有用户信息，则证明登录过)
  bool get isLogin => user != null;

  //用户信息发生变化，更新用户信息并通知依赖它的子孙Widgets更新
  set user(User user) {
    if (user.login != _profile.user?.login) {
      _profile.lastLogin = _profile.user?.login;
      _profile.user = user;
      notifyListeners();
    }
  }
}

/// 主题状态在用户更换APP主题时更新、通知其依赖项
class ThemeModel extends ProfileChangeNotifier {
  // 获取当前主题，如果没设置主题，则默认使用蓝色主题
  // firstWhere 返回符合条件的第一个元素
  ColorSwatch get theme => Global.themes.firstWhere((e) {
        return e.value == _profile?.theme;
      }, orElse: () => Colors.blue);

  // 更改主题并通知更新
  set theme(ColorSwatch colorSwatch) {
    if (colorSwatch.value != _profile?.theme) {
      _profile.theme = colorSwatch[500].value;
      notifyListeners();
    }
  }
}

/// App语言状态
class LocaleModel extends ProfileChangeNotifier {
  // 获取当前用户的APP语言配置Locale类，如果为null，则语言跟随系统语言
  Locale getLocale() {
    if(_profile.locale == null) return null;
    List<String> t = _profile.locale.split("_");
    return Locale(t[0], t[1]);
  }

  String get locale => _profile.locale;

  set locale(String locale) {
    if (locale != _profile?.locale) {
      _profile.locale = locale;
      notifyListeners();
    }
  }
}
