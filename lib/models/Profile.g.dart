// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Profile.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Profile _$ProfileFromJson(Map<String, dynamic> json) {
  return Profile()
    ..server = json['server'] as String
    ..heistory_user = json['heistory_user'] as String
    ..wx_appkey = json['wx_appkey'] as String
    ..wx_universalLink = json['wx_universalLink'] as String
    ..eim_appid = json['eim_appid'] as String
    ..bmf_isokey = json['bmf_isokey'] as String
    ..bmf_androidkey = json['bmf_androidkey'] as String
    ..theme = json['theme'] as int
    ..locale = json['locale'] as String;
}

Map<String, dynamic> _$ProfileToJson(Profile instance) => <String, dynamic>{
      'server': instance.server,
      'heistory_user': instance.heistory_user,
      'wx_appkey': instance.wx_appkey,
      'wx_universalLink': instance.wx_universalLink,
      'eim_appid': instance.eim_appid,
      'bmf_isokey': instance.bmf_isokey,
      'bmf_androidkey': instance.bmf_androidkey,
      'theme': instance.theme,
      'locale': instance.locale,
    };
