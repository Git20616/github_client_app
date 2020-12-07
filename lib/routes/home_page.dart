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
      drawer: MyDrawer(),
      body: _buildBody(),
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
          try {
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
          }catch (e) {
            // DioError
            print("DioError: ${e.toString()}");
            return false;
          }
        },
        itemBuilder: (List<Repo> list, int index, BuildContext context) {
          // 项目信息的列表项
          return RepoItem(repo: list[index]);
        },
      );
    }
  }
}

class MyDrawer extends StatelessWidget {
  const MyDrawer({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: MediaQuery.removePadding(
        context: context,
        // DrawerHeader consumes top MediaQuery padding.
        removeTop: true,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _buildHeader(),//构建抽屉菜单头部
            Expanded(child: _buildMenus(),),//构建功能菜单
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Consumer<UserModel>(
        builder: (BuildContext context, UserModel userModel, Widget child) {
      return GestureDetector(
        onTap: () {
          if (!userModel.isLogin) Navigator.of(context).pushNamed("login");
        },
        child: Container(
          color: Theme.of(context).primaryColor,
          padding: const EdgeInsets.only(
            top: 40,
            bottom: 20,
          ),
          child: Row(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: ClipOval(
                  // 如果已登录，则显示用户头像；若未登录，则显示默认头像
                  child: userModel.isLogin
                      ? gmAvatar(userModel.user.avatar_url, width: 80)
                      : Image.asset(
                          "imgs/avatar-default.png",
                          width: 80,
                        ),
                ),
              ),
              Text(
                userModel.isLogin
                    ? userModel.user.login
                    : GmLocalizations.of(context).login,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      );
    });
  }

  // 构建菜单项
  Widget _buildMenus() {
    return Consumer<UserModel>(
      builder: (BuildContext context, UserModel userModel, Widget child) {
        GmLocalizations gm = GmLocalizations.of(context);
        return ListView(
          children: <Widget>[
            ListTile(
              leading: Icon(Icons.color_lens),
              title: Text(gm.theme),
              onTap: () => Navigator.pushNamed(context, "themes"),
            ),
            ListTile(
              leading: Icon(Icons.language),
              title: Text(gm.language),
              onTap: () => Navigator.pushNamed(context, "language"),
            ),
            userModel.isLogin
                ? ListTile(
                    leading: Icon(Icons.power_settings_new),
                    title: Text(gm.logout),
                    onTap: () {
                      showDialog(
                          context: context,
                          builder: (context) {
                            //退出账号前先弹二次确认窗
                            return AlertDialog(
                              content: Text(gm.logoutTip),
                              actions: <Widget>[
                                FlatButton(
                                  child: Text(gm.cancel),
                                  onPressed: () =>
                                      Navigator.pop(context), //关闭弹窗
                                ),
                                FlatButton(
                                  child: Text(gm.yes),
                                  onPressed: () {
                                    //该赋值语句会触发MaterialApp rebuild
                                    userModel.user = null;
                                    Navigator.pop(context);
                                  },
                                ),
                              ],
                            );
                          });
                    },
                  )
                : Container(),
          ],
        );
      },
    );
  }
}
