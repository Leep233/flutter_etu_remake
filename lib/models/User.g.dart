// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'User.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) {
  return User()
    ..id = json['id'] as int
    ..phone = json['phone'] as String
    ..actualName = json['actualName'] as String
    ..nickName = json['nickName'] as String
    ..birthday = json['birthday'] as String
    ..gender = json['gender'] as String
    ..signature = json['signature'] as String
    ..referrer = json['referrer'] as String
    ..profile = json['profile'] as String
    ..status = json['status'] as int
    ..balance = json['balance'] as String
    ..footer = json['footer'] as int
    ..collect = json['collect'] as int
    ..follow = json['follow'] as int
    ..receiveNotify = json['receiveNotify'] as int
    ..inviteCode = json['inviteCode'] as String
    ..sign = json['sign'] as String
    ..servicePhone = json['servicePhone'] as String;
}

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'id': instance.id,
      'phone': instance.phone,
      'actualName': instance.actualName,
      'nickName': instance.nickName,
      'birthday': instance.birthday,
      'gender': instance.gender,
      'signature': instance.signature,
      'referrer': instance.referrer,
      'profile': instance.profile,
      'status': instance.status,
      'balance': instance.balance,
      'footer': instance.footer,
      'collect': instance.collect,
      'follow': instance.follow,
      'receiveNotify': instance.receiveNotify,
      'inviteCode': instance.inviteCode,
      'sign': instance.sign,
      'servicePhone': instance.servicePhone,
    };
