
import 'package:json_annotation/json_annotation.dart';
//flutter packages pub run build_runner build

part 'Profile.g.dart';

@JsonSerializable()
class Profile{

  ///后台服务器地址
  String server;

  // ignore: non_constant_identifier_names
  String heistory_user;
  ///微信开放平台 appkey;
  // ignore: non_constant_identifier_names
  String wx_appkey;

  ///微信开放平台universalLink 仅iso
  // ignore: non_constant_identifier_names
  String wx_universalLink;

  ///环信im appid
  // ignore: non_constant_identifier_names
  String eim_appid;

  ///百度地图sdk isokey
  // ignore: non_constant_identifier_names
  String bmf_isokey;

  ///百度地图sdk androidkey （Android 目前不支持接口设置Apikey,
  /// 请在主工程的Manifest文件里设置，详细配置方法请参考官网(https://lbsyun.baidu.com/)demo）
  // ignore: non_constant_identifier_names
  String bmf_androidkey;

  ///主题
  int  theme;
  
  //本地语言
  String locale;

  Profile();
  factory Profile.fromJson(Map<String, dynamic> json) => _$ProfileFromJson(json);
  Map<String, dynamic> toJson() => _$ProfileToJson(this);

}