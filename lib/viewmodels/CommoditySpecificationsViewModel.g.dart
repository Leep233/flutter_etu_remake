// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'CommoditySpecificationsViewModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CommoditySpecificationsViewModel _$CommoditySpecificationsViewModelFromJson(
    Map<String, dynamic> json) {
  return CommoditySpecificationsViewModel(
    productNo: json['productNo'] as String,
    quantity: json['quantity'] as int,
    specifications: (json['specifications'] as Map<String, dynamic>)?.map(
      (k, e) => MapEntry(k, (e as List)?.map((e) => e as String)?.toList()),
    ),
    describe: json['describe'] as String,
    picture: json['picture'] as String,
  )
    ..commodityNo = json['commodityNo'] as String
    ..inventory = json['inventory'] as int
    ..originalPrice = (json['originalPrice'] as num)?.toDouble()
    ..sellingPrice = (json['sellingPrice'] as num)?.toDouble()
    ..weight = (json['weight'] as num)?.toDouble();
}

Map<String, dynamic> _$CommoditySpecificationsViewModelToJson(
        CommoditySpecificationsViewModel instance) =>
    <String, dynamic>{
      'productNo': instance.productNo,
      'commodityNo': instance.commodityNo,
      'inventory': instance.inventory,
      'originalPrice': instance.originalPrice,
      'sellingPrice': instance.sellingPrice,
      'weight': instance.weight,
      'picture': instance.picture,
      'describe': instance.describe,
      'quantity': instance.quantity,
      'specifications': instance.specifications,
    };
