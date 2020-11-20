import 'dart:collection';

import 'package:dio/dio.dart';

import '../index.dart';

class CacheObject {
  int timestamp;
  Response response;

  CacheObject(this.response)
      : timestamp = DateTime.now().millisecondsSinceEpoch;

  @override
  bool operator ==(other) {
    return hashCode == other.hashCode;
  }

  // 将请求uri作为缓存的key
  @override
  int get hashCode => response.realUri.hashCode;

  // 操作符重载
  bool operator <(CacheObject other) {
    return timestamp < other.timestamp;
  }
}

class NetCache extends Interceptor {
  // 为确保迭代器顺序和对象插入时间一致顺序一致，我们使用LinkedHashMap
  var cache = LinkedHashMap<String, CacheObject>();

  @override
  Future onResponse(Response response) {
    // TODO: implement onResponse
    return super.onResponse(response);
  }
}
