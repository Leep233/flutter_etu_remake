// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Commodity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Commodity _$CommodityFromJson(Map<String, dynamic> json) {
  return Commodity()
    ..productNo = json['productNo']?.toString()
    ..merchantId = json['merchantId'] as String
    ..shopName = json['shopName'] as String
    ..isHot = json['isHot'] as int
    ..isRecommend = json['isRecommend'] as int
    ..title = json['title'] as String
    ..subtitle = json['subtitle'] as String
    ..placeOfProduct = json['placeOfProduct'] as String
    ..feature = json['feature'] as String
    ..advantage = json['advantage'] as String
    ..recommendMatch = json['recommendMatch'] as String
    ..mainPicture = json['mainPicture'] as String
    ..originalPrice = json['originalPrice'] as String
    ..sellingPrice = json['sellingPrice'] as String
    ..salesVolume = json['salesVolume'] as int
    ..merchantName = json['merchantName'] as String
    ..collectNum = json['collectNum'] as int
    ..id = json['id'] as int
    ..commodityNo = json['commodityNo'] as String
    ..specification = json['specification'] as String
    ..price = (json['price'] as num)?.toDouble()
    ..quantity = json['quantity'] as int
    ..inventory = json['inventory'] as int
    ..weight = (json['weight'] as num)?.toDouble()
    ..selected = json['selected'] as int
    ..isLock = json['isLock'] as int
    ..formatSpec = json['formatSpec'] as String
    ..afterSaleStatus = json['afterSaleStatus'] as int;
}

Map<String, dynamic> _$CommodityToJson(Commodity instance) => <String, dynamic>{
      'productNo': instance.productNo,
      'merchantId': instance.merchantId,
      'shopName': instance.shopName,
      'isHot': instance.isHot,
      'isRecommend': instance.isRecommend,
      'title': instance.title,
      'subtitle': instance.subtitle,
      'placeOfProduct': instance.placeOfProduct,
      'feature': instance.feature,
      'advantage': instance.advantage,
      'recommendMatch': instance.recommendMatch,
      'mainPicture': instance.mainPicture,
      'originalPrice': instance.originalPrice,
      'sellingPrice': instance.sellingPrice,
      'salesVolume': instance.salesVolume,
      'merchantName': instance.merchantName,
      'collectNum': instance.collectNum,
      'id': instance.id,
      'commodityNo': instance.commodityNo,
      'specification': instance.specification,
      'price': instance.price,
      'quantity': instance.quantity,
      'inventory': instance.inventory,
      'weight': instance.weight,
      'selected': instance.selected,
      'isLock': instance.isLock,
      'formatSpec': instance.formatSpec,
      'afterSaleStatus': instance.afterSaleStatus,
    };
