import 'package:github_client_app/index.dart';

class LoginRoute extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _LoginRouteState();
  }
}

class _LoginRouteState extends State<LoginRoute> {
  TextEditingController _unameController = new TextEditingController();
  TextEditingController _pwdController = new TextEditingController();
  bool pwdShow = false;
  bool _nameAutoFocus = true;
  GlobalKey _formKey = new GlobalKey<FormState>();//用于获取FormState

  @override
  void initState() {
    // 自动填充上次登录的用户名，填充后焦点定位到密码输入框
    _unameController.text = Global.profile.lastLogin;
    if(_unameController.text != null) {
      _nameAutoFocus = false;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    GmLocalizations gm = GmLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(title: Text(gm.login),),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          autovalidate: true,
          child: Column(
            children: <Widget>[
            ],
          ),
        ),
      ),
    );
  }
}
