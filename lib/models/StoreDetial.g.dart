// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'StoreDetial.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StoreDetial _$StoreDetialFromJson(Map<String, dynamic> json) {
  return StoreDetial()
    ..id = json['id'] as int
    ..shopName = json['shopName'] as String
    ..shopAddress = json['shopAddress'] as String
    ..merchantPhone = json['merchantPhone'] as String
    ..businessCategory = json['businessCategory'] as String
    ..currentStar = (json['currentStar'] as num)?.toDouble()
    ..shopDepict = json['shopDepict'] as String
    ..followNumber = json['followNumber'] as int
    ..isFollow = json['isFollow'] as int
    ..merchantPicture = json['merchantPicture'] as String
    ..productList = (json['productList'] as List)
        ?.map((e) =>
            e == null ? null : Commodity.fromJson(e as Map<String, dynamic>))
        ?.toList()
    ..commodityList = (json['commodityList'] as List)
        ?.map((e) =>
            e == null ? null : Commodity.fromJson(e as Map<String, dynamic>))
        ?.toList()
    ..followTime = json['followTime'] as String;
}

Map<String, dynamic> _$StoreDetialToJson(StoreDetial instance) =>
    <String, dynamic>{
      'id': instance.id,
      'shopName': instance.shopName,
      'shopAddress': instance.shopAddress,
      'merchantPhone': instance.merchantPhone,
      'businessCategory': instance.businessCategory,
      'currentStar': instance.currentStar,
      'shopDepict': instance.shopDepict,
      'followNumber': instance.followNumber,
      'isFollow': instance.isFollow,
      'merchantPicture': instance.merchantPicture,
      'productList': instance.productList,
      'commodityList': instance.commodityList,
      'followTime': instance.followTime,
    };
