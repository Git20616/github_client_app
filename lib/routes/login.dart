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
              TextFormField(
                autofocus: _nameAutoFocus,
                controller: _unameController,
                decoration: InputDecoration(
                  labelText: gm.userName,
                  hintText: gm.emailOrPhone,
                  prefixIcon: Icon(Icons.person),
                ),
                validator: (v) => v.trim().isNotEmpty ? null : gm.passwordRequired,
              ),
              TextFormField(
                autofocus: !_nameAutoFocus,
                controller: _pwdController,
                obscureText: !pwdShow,
                decoration: InputDecoration(
                  labelText: gm.password,
                  hintText: gm.inputPassword,
                  prefixIcon: Icon(Icons.lock),
                  suffixIcon: IconButton(
                    icon: Icon(pwdShow ? Icons.visibility_off : Icons.visibility),
                    onPressed: () {
                      setState(() {
                        pwdShow = !pwdShow;
                      });
                    },
                  ),
                ),
                validator: (v) => v.trim().isNotEmpty ? null : gm.passwordRequired,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 25),
                child: ConstrainedBox(
                  constraints: BoxConstraints.expand(height: 55.0),
                  child: RaisedButton(
                    color: Theme.of(context).primaryColor,
                    textColor: Colors.white,
                    child: Text(gm.login),
                    onPressed: _onLogin,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _onLogin() async {
    if((_formKey.currentState as FormState).validate()) {
      showLoading(context);
      User user;
      try {
        user = await Git(context).login(_unameController.text, _pwdController.text);
        // 因为登录页返回后，首页会build，所以我们传false，更新user后不触发更新
        Provider.of<UserModel>(context, listen: false).user = user;
      } catch (e) {
        // 登录失败提示 DioError
      } finally {
      }
    }
  }
}
