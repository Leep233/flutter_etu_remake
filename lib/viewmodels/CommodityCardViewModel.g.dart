// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'CommodityCardViewModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CommodityCardViewModel _$CommodityCardViewModelFromJson(
    Map<String, dynamic> json) {
  return CommodityCardViewModel()
    ..commodityId = json['commodityId'] as String
    ..storeId = json['storeId'] as String
    ..commodityName = json['commodityName'] as String
    ..storeName = json['storeName'] as String
    ..advantage = json['advantage'] as String
    ..suggested = json['suggested'] as String
    ..price = (json['price'] as num)?.toDouble()
    ..originalPrice = (json['originalPrice'] as num)?.toDouble()
    ..salesVolume = json['salesVolume'] as int
    ..tips = (json['tips'] as List)?.map((e) => e as String)?.toList()
    ..image = json['image'] as String;
}

Map<String, dynamic> _$CommodityCardViewModelToJson(
        CommodityCardViewModel instance) =>
    <String, dynamic>{
      'commodityId': instance.commodityId,
      'storeId': instance.storeId,
      'commodityName': instance.commodityName,
      'storeName': instance.storeName,
      'advantage': instance.advantage,
      'suggested': instance.suggested,
      'price': instance.price,
      'originalPrice': instance.originalPrice,
      'salesVolume': instance.salesVolume,
      'tips': instance.tips,
      'image': instance.image,
    };
