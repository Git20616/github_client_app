import 'package:github_client_app/index.dart';
import 'package:intl/intl.dart';
import 'messages_all.dart'; //intl_translation工具从arb文件生成的代码

class GmLocalizations {
  static Future<GmLocalizations> load(Locale locale) {
    final String name =
        locale.countryCode.isEmpty ? locale.languageCode : locale.toString();
    final String localeName = Intl.canonicalizedLocale(name); //name为null时返回系统设置

    //messages_all.dart
    return initializeMessages(localeName).then((b) {
      Intl.defaultLocale = localeName;
      return new GmLocalizations();
    });
  }

  //Localizations组件用于加载和查找应用当前语言下的本地化值或资源。应用程序通过Localizations.of(context,type)来引用这些对象。
  //如果设备的Locale区域设置发生更改，则Localizations 组件会自动加载新区域的Locale值，然后重新build使用（依赖）了它们的组件
  static GmLocalizations of(BuildContext context) {
    return Localizations.of(context, GmLocalizations);
  }

  // TODO 多语言资源
  ///取消
  String get cancel => Intl.message("cancel", name: "cancel");
  ///邮箱或手机号码
  String get emailOrPhone => Intl.message("Email or cell phone number", name: "emailOrPhone");
  ///主页名称
  String get home => Intl.message("Github Client", name: "home");
  ///输入密码
  String get inputPassword => Intl.message("Input password", name: "inputPassword");
  ///语言
  String get language => Intl.message("Language", name: "language");
  ///登录
  String get login => Intl.message("Login", name: "login");
  ///登出
  String get logout => Intl.message("Logout", name: "logout");
  ///登出提示
  String get logoutTip => Intl.message("Are you sure you want to quit your current account?", name: "logoutTip");
  ///暂无描述
  String get noDescription => Intl.message("No description!", name: "noDescription");
  ///密码
  String get password => Intl.message("Password", name: "password");
  ///密码不能为空
  String get passwordRequired => Intl.message("Password cannot be empty!", name: "passwordRequired");
  ///未读邮件数量
  String remainingEmailsMessage(int howMany) {
    return Intl.plural(
      howMany,
      zero: "There are no emails left",
      one: "There is $howMany email left",
      other: "There are $howMany emails left",
      name: "remainingEmailsMessage",
      args: [howMany],
      desc: "How many emails remain after archiving.",
      examples: const {'howMany': 42, 'userName': 'Fred'},
    );
  }
  ///主题
  String get theme => Intl.message("Theme", name: "theme");
  ///标题
  String get title => Intl.message("Flutter App",
      name: "title", desc: "Title for the Demo application");
  ///用户名
  String get userName => Intl.message("User Name", name: "userName");
  ///用户名或密码不正确
  String get userNameOrPasswordWrong => Intl.message("User name or password is not correct!", name: "userNameOrPasswordWrong");
  ///用户名不能为空
  String get userNameRequired => Intl.message("User name cannot be empty!", name: "userNameRequired");
  ///确认
  String get yes => Intl.message("yes", name: "yes");

}

// Delegate类的职责是在Locale改变时加载新的Locale资源
class GmLocalizationsDelegate extends LocalizationsDelegate<GmLocalizations> {
  const GmLocalizationsDelegate();

  // TODO Reflect
  // Warning: This application's locale, zh_CN, is not supported by all of its localization delegates.
  // A GmLocalizations delegate that supports the zh_CN locale was not found.

  @override
  bool isSupported(Locale locale) {
    // TODO 这里一定要添加supportedLocales中所有的languageCode，否则会报错
    // 是否支持某个Local
    return ["en", "zh"].contains(locale.languageCode);
  }

  @override
  Future<GmLocalizations> load(Locale locale) {
    // Flutter会调用此类加载相应的Locale资源类
    return GmLocalizations.load(locale);
  }

  @override
  bool shouldReload(LocalizationsDelegate<GmLocalizations> old) {
    // 当Localizations Widget重新build时，是否调用load重新加载Locale资源
    return false;
  }
}
