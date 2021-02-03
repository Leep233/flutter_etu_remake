// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'MyOrders.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MyOrders _$MyOrdersFromJson(Map<String, dynamic> json) {
  return MyOrders()
    ..total = json['total'] as int
    ..result = (json['result'] as List)
        ?.map((e) =>
            e == null ? null : OrderDetail.fromJson(e as Map<String, dynamic>))
        ?.toList();
}

Map<String, dynamic> _$MyOrdersToJson(MyOrders instance) => <String, dynamic>{
      'total': instance.total,
      'result': instance.result,
    };
