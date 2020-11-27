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
  String get title => Intl.message("Flutter App",
      name: "title", desc: "Title for the Demo application");
  //未读邮件数量
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
  //主页名称
  String get home => Intl.message("Github Client", name: "home");
  //登录
  String get login => Intl.message("Login", name: "login");
  //暂无描述
  String get noDescription => Intl.message("No description!", name: "noDescription");
}

// Delegate类的职责是在Locale改变时加载新的Locale资源
class GmLocalizationsDelegate extends LocalizationsDelegate<GmLocalizations> {
  @override
  bool isSupported(Locale locale) {
    // 是否支持某个Local
    return ["en", "zn"].contains(locale.languageCode);
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
