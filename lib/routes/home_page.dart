import 'package:flukit/flukit.dart';
import 'package:github_client_app/index.dart';

class HomeRoute extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomeRouteState();
  }
}

class _HomeRouteState extends State<HomeRoute> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(GmLocalizations.of(context).home),
      ),
    );
  }

  Widget _buildBody() {
    UserModel userModel = Provider.of<UserModel>(context);
    if (!userModel.isLogin) {
      // 用户未登录，显示登录按钮
      return Center(
        child: RaisedButton(
          child: Text(GmLocalizations.of(context).login),
          onPressed: () => Navigator.pushNamed(context, "login"),
        ),
      );
    } else {
      // 已登录，展示项目列表
      return InfiniteListView(
        onRetrieveData: (int page, List<Repo> items, bool refresh) async {
          List<Repo> data = await Git(context).getRepos(
            refresh: refresh,
            queryParameters: {
              "page": page,
              "page_size": 20,
            },
          );
          items.addAll(data);
          // 返回值类型为bool，为true时表示还有数据，为false时则表示后续没有数据了。
          return data.length == 20;
        },
        itemBuilder: (List<Repo> list, int index, BuildContext context) {
          // 项目信息的列表项
          return null;
        },
      );
    }
  }
}
