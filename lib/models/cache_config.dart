import 'package:json_annotation/json_annotation.dart';

part 'cache_config.g.dart';

@JsonSerializable()
class CacheConfig {
    CacheConfig();

    bool enable;//是否开启缓存
    num maxAge;//最大缓存时间
    num maxCount;//最大缓存数
    
    factory CacheConfig.fromJson(Map<String,dynamic> json) => _$CacheConfigFromJson(json);
    Map<String, dynamic> toJson() => _$CacheConfigToJson(this);
}
