// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'UserBalance.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserBalance _$UserBalanceFromJson(Map<String, dynamic> json) {
  return UserBalance()
    ..balance = json['balance'] as String
    ..balanceDetailList = (json['balanceDetailList'] as List)?.map((e) => BalanceDetail.fromJson(e))?.toList();
}

Map<String, dynamic> _$UserBalanceToJson(UserBalance instance) =>
    <String, dynamic>{
      'balance': instance.balance,
      'balanceDetailList': instance.balanceDetailList,
    };
