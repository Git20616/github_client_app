import 'package:github_client_app/index.dart';

class ThemeChangeRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(GmLocalizations.of(context).theme),),
      body: ListView(
        children: Global.themes.map<Widget>((e) {
          return GestureDetector(
            onTap: () {
              // 更新主题后， MaterialApp会重新build
              Provider.of<ThemeModel>(context).theme = e;
            },
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 16.0),
              child: Container(
                height: 40.0,
                color: e,
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}

