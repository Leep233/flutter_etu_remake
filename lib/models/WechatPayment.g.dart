// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'WechatPayment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WechatPayment _$WechatPaymentFromJson(Map<String, dynamic> json) {
  return WechatPayment()
    ..prepay_id = json['prepay_id'] as String
    ..appid = json['appid'] as String
    ..timestamp = json['timestamp'] as String
    ..noncestr = json['noncestr'] as String
    ..paySign = json['paySign'] as String
    ..partnerid = json['partnerid'] as String
    ..package = json['package'] as String;
}

Map<String, dynamic> _$WechatPaymentToJson(WechatPayment instance) =>
    <String, dynamic>{
      'prepay_id': instance.prepay_id,
      'appid': instance.appid,
      'timestamp': instance.timestamp,
      'noncestr': instance.noncestr,
      'paySign': instance.paySign,
      'partnerid': instance.partnerid,
      'package': instance.package,
    };
