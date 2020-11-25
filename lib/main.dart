import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:github_client_app/l10n/localization_intl.dart';

import 'index.dart';

// 全局变量初始化需要在App启动时执行
void main() => Global.init().then((e) => runApp(MyApp()));

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: <SingleChildCloneableWidget>[
        ChangeNotifierProvider.value(value: ThemeModel()),
        ChangeNotifierProvider.value(value: UserModel()),
        ChangeNotifierProvider.value(value: LocaleModel()),
      ],
      child: Consumer2<ThemeModel, LocaleModel>(
        builder: (BuildContext context, ThemeModel themeModel, LocaleModel localeModel, Widget child){
          return MaterialApp(
            theme: ThemeData(
              primarySwatch: themeModel.theme,
            ),
            //title: GmLocalizations.of(context).title,//这里会返回null
            onGenerateTitle: (context) => GmLocalizations.of(context).title,
            home: HomeRoute(),
            locale: LocaleModel().getLocale(),
            //语言支持
            supportedLocales: [
              const Locale("en", "US"),//美式英语
              const Locale("zh", "CN"),//中文简体
              const Locale("zh", "TW"),//中文繁体
              //其它Locales
            ],
            localizationsDelegates: [
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GmLocalizationsDelegate(),
            ],
            localeResolutionCallback: (Locale _locale, Iterable<Locale> supportedLocales) {
              if(LocaleModel().getLocale() != null) {
                //如果已选定语言，则不跟随系统
                return LocaleModel().getLocale();
              } else {
                Locale locale;
                //APP语言跟随系统语言，如果系统语言不在语言支持列表里，
                //则默认使用美国英语
                if(supportedLocales.contains(_locale)) {
                  locale = _locale;
                } else {
                  locale = Locale("en", "US");
                }
                return locale;
              }
            },
            // 注册命名路由表
            routes: <String, WidgetBuilder>{
              "language": (context) => LanguageRoute(),
              "login": (context) => LoginRoute(),
              "themes": (context) => ThemeChangeRoute(),
            },
          );
        },
      ),
    );
  }
}

//在上面的代码中：
//
// 我们的根widget是MultiProvider，它将主题、用户、语言三种状态绑定到了应用的根上，如此一来，任何路由中都可以通过Provider.of()来获取这些状态，
// 也就是说这三种状态是全局共享的！
// 在构建MaterialApp时，我们配置了APP支持的语言列表，以及监听了系统语言改变事件；
// 另外MaterialApp消费（依赖）了ThemeModel和LocaleModel，所以当APP主题或语言改变时MaterialApp会重新构建
// 我们注册了命名路由表，以便在APP中可以直接通过路由名跳转。
// 为了支持多语言（本APP中我们支持美国英语和中文简体两种语言）我们实现了一个GmLocalizationsDelegate，
// 子Widget中都可以通过GmLocalizations来动态获取APP当前语言对应的文案。