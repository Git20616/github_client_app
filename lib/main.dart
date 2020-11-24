import 'package:github_client_app/states/profile_change_notifier.dart';

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
          );
        },
      ),
    );
  }
}
