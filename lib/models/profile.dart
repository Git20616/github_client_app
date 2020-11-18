import 'package:json_annotation/json_annotation.dart';
import "user.dart";
import "cache_config.dart";
part 'profile.g.dart';

/// 用户信息
@JsonSerializable()
class Profile {
    Profile();

    User user;
    String token;
    num theme;
    CacheConfig cache;
    String lastLogin;
    String locale;
    
    factory Profile.fromJson(Map<String,dynamic> json) => _$ProfileFromJson(json);
    Map<String, dynamic> toJson() => _$ProfileToJson(this);
}
