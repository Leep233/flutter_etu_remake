// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'PaymentDetail.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PaymentDetail _$PaymentDetailFromJson(Map<String, dynamic> json) {
  return PaymentDetail()
    ..orderNo = json['orderNo'] as String
    ..payAmount = (json['payAmount'] as num)?.toDouble()
    ..date = json['date'] as String;
}

Map<String, dynamic> _$PaymentDetailToJson(PaymentDetail instance) =>
    <String, dynamic>{
      'orderNo': instance.orderNo,
      'payAmount': instance.payAmount,
      'date': instance.date,
    };
