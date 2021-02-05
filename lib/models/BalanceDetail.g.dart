// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'BalanceDetail.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BalanceDetail _$BalanceDetailFromJson(Map<String, dynamic> json) {
  return BalanceDetail()
    ..id = json['id'] as int
    ..useDescription = json['useDescription'] as String
    ..expenseRecord = (json['expenseRecord'] as num)?.toDouble()
    ..recordTime = json['recordTime'] as String;
}

Map<String, dynamic> _$BalanceDetailToJson(BalanceDetail instance) =>
    <String, dynamic>{
      'id': instance.id,
      'useDescription': instance.useDescription,
      'expenseRecord': instance.expenseRecord,
      'recordTime': instance.recordTime,
    };
