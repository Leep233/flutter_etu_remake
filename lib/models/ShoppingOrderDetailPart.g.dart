// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ShoppingOrderDetailPart.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ShoppingOrderDetailPart _$ShoppingOrderDetailPartFromJson(
    Map<String, dynamic> json) {
  return ShoppingOrderDetailPart()
    ..id = json['id'] as int
    ..shopName = json['shopName'] as String
    ..commodities = (json['commodities'] as List)
        ?.map((e) =>
            e == null ? null : Commodity.fromJson(e as Map<String, dynamic>))
        ?.toList()
    ..fareAmount = (json['fareAmount'] as num)?.toDouble()
    ..commodityWeight = (json['commodityWeight'] as num)?.toDouble()
    ..commodityPrice = (json['commodityPrice'] as num)?.toDouble();
}

Map<String, dynamic> _$ShoppingOrderDetailPartToJson(
        ShoppingOrderDetailPart instance) =>
    <String, dynamic>{
      'id': instance.id,
      'shopName': instance.shopName,
      'commodities': instance.commodities,
      'fareAmount': instance.fareAmount,
      'commodityWeight': instance.commodityWeight,
      'commodityPrice': instance.commodityPrice,
    };
