import 'dart:io';

import 'package:dio/dio.dart';
import 'package:github_client_app/index.dart';

class Git {
  BuildContext context;
  Options _options;

  Git([this.context]) {
    _options = Options(extra: {"context": context});
  }

  static Dio dio = new Dio(BaseOptions(
    baseUrl: "",
    headers: {
      HttpHeaders.acceptHeader: "",
    }
  ));

  static void init() {
    // 添加缓存插件
    dio.interceptors.add(Global.netCache);
    // 设置用户token（可能为null，代表未登录）
    dio.options.headers[HttpHeaders.authorizationHeader] = Global.profile.token;
  }
}