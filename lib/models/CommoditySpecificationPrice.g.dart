// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'CommoditySpecificationPrice.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CommoditySpecificationPrice _$CommoditySpecificationPriceFromJson(
    Map<String, dynamic> json) {
  return CommoditySpecificationPrice()
    ..commodityNo = json['commodityNo'] as String
    ..inventory = json['inventory'] as int
    ..originalPrice = (json['originalPrice'] as num)?.toDouble()
    ..sellingPrice = (json['sellingPrice'] as num)?.toDouble()
    ..weight = (json['weight'] as num)?.toDouble()
    ..picture = json['picture'] as String;
}

Map<String, dynamic> _$CommoditySpecificationPriceToJson(
        CommoditySpecificationPrice instance) =>
    <String, dynamic>{
      'commodityNo': instance.commodityNo,
      'inventory': instance.inventory,
      'originalPrice': instance.originalPrice,
      'sellingPrice': instance.sellingPrice,
      'weight': instance.weight,
      'picture': instance.picture,
    };
