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
  Future onRequest(RequestOptions options) async {
    if(!Global.profile.cache.enable) {
      return options;
    }
    // 下拉刷新标记
    bool refresh = options.extra["refresh"] == true;
    // 下拉刷新删除相关缓存
    if(refresh) {
      if(options.extra["list"] == true) {
        //若是列表，则只要url中包含当前path的缓存全部删除（简单实现，并不精准）
        cache.removeWhere((key, value) => key.contains(options.path));
      }else {
        cache.remove(options.uri.toString());
      }
      return options;
    }

    if(options.extra["noCache"] != true && options.method.toLowerCase() == "get") {
      String key = options.extra["cacheKey"] ?? options.uri.toString();
      CacheObject cacheObject = cache[key];
      if(cacheObject != null) {
        // 缓存是否过期
        if(DateTime.now().millisecondsSinceEpoch - cacheObject.timestamp < Global.profile.cache.maxAge) {
          return cache[key].response;//返回缓存内容
        } else {
          //若已过期则删除缓存，继续向服务器请求
          cache.remove(key);
        }
      }
    }
    // return options;
  }

  @override
  Future onError(DioError err) async {
    // 错误状态不缓存
  }

  @override
  Future onResponse(Response response) async {
    // 如果启用缓存，则将结果保存到缓存
    if(Global.profile.cache.enable) {
      _saveCache(response);
    }
  }

  void _saveCache(Response response) {
    RequestOptions options = response.request;
    if(options.extra["noCache"] != true && options.method.toLowerCase() == "get") {
      // 如果缓存的数量超过限制，移除最早的记录
      if(cache.length > Global.profile.cache.maxCount) {
        cache.remove(cache.keys.first);
      }
      String key = options.extra["cacheKey"] ?? options.uri.toString();
      cache[key] = CacheObject(response);
    }
  }
}
