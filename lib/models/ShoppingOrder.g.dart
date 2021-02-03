// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ShoppingOrder.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ShoppingOrder _$ShoppingOrderFromJson(Map<String, dynamic> json) {
  return ShoppingOrder()
    ..addressDisplay = json['addressDisplay'] == null
        ? null
        : Deliveryaddress.fromJson(
            json['addressDisplay'] as Map<String, dynamic>)
    ..parts = (json['parts'] as List)
        ?.map((e) => e == null
            ? null
            : ShoppingOrderDetailPart.fromJson(e as Map<String, dynamic>))
        ?.toList()
    ..weight = json['weight'] as String
    ..orderAmount = json['orderAmount'] as String
    ..fareAmount = json['fareAmount'] as String
    ..totalAmount = json['totalAmount'] as String
    ..commodityAmount = json['commodityAmount'] as int
    ..orderNo = json['orderNo'] as String;
}

Map<String, dynamic> _$ShoppingOrderToJson(ShoppingOrder instance) =>
    <String, dynamic>{
      'addressDisplay': instance.addressDisplay,
      'parts': instance.parts,
      'weight': instance.weight,
      'orderAmount': instance.orderAmount,
      'fareAmount': instance.fareAmount,
      'totalAmount': instance.totalAmount,
      'commodityAmount': instance.commodityAmount,
      'orderNo': instance.orderNo,
    };
