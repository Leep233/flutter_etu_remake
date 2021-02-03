// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'CommodityDetail.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CommodityDetail _$CommodityDetailFromJson(Map<String, dynamic> json) {
  return CommodityDetail()
    ..id = json['id'] as int
    ..belongMerchant = json['belongMerchant'] as int
    ..isCollect = json['isCollect'] as int
    ..productNo = json['productNo'] as String
    ..title = json['title'] as String
    ..subtitle = json['subtitle'] as String
    ..placeOfProduct = json['placeOfProduct'] as String
    ..feature = json['feature'] as String
    ..advantage = json['advantage'] as String
    ..recommendMatch = json['recommendMatch'] as String
    ..mainPicture = json['mainPicture'] as String
    ..video = json['video'] as String
    ..slideShow = json['slideShow'] as String
    ..specificationJson = json['specificationJson'] as String
    ..details = json['details'] as String
    ..hotSellRecommend = json['hotSellRecommend'] as int
    ..categoryRecommend = json['categoryRecommend'] as int
    ..inventory = json['inventory'] as int
    ..price = json['price'] as String
    ..minPrice = json['minPrice'] as String
    ..maxPrice = json['maxPrice'] as String
    ..originPrice = json['originPrice'] as String
    ..salesVolume = json['salesVolume'] as int
    ..consigneeAddress = json['consigneeAddress'] as String
    ..fareAmount = json['fareAmount'] as String
    ..allComment = json['allComment'] as int
    ..merchantName = json['merchantName'] as String
    ..merchantPhone = json['merchantPhone'] as String
    ..evaluationInfos = (json['evaluationInfos'] as List)
        ?.map((e) =>
            e == null ? null : Comment.fromJson(e as Map<String, dynamic>))
        ?.toList();
}

Map<String, dynamic> _$CommodityDetailToJson(CommodityDetail instance) =>
    <String, dynamic>{
      'id': instance.id,
      'belongMerchant': instance.belongMerchant,
      'isCollect': instance.isCollect,
      'productNo': instance.productNo,
      'title': instance.title,
      'subtitle': instance.subtitle,
      'placeOfProduct': instance.placeOfProduct,
      'feature': instance.feature,
      'advantage': instance.advantage,
      'recommendMatch': instance.recommendMatch,
      'mainPicture': instance.mainPicture,
      'video': instance.video,
      'slideShow': instance.slideShow,
      'specificationJson': instance.specificationJson,
      'details': instance.details,
      'hotSellRecommend': instance.hotSellRecommend,
      'categoryRecommend': instance.categoryRecommend,
      'inventory': instance.inventory,
      'price': instance.price,
      'minPrice': instance.minPrice,
      'maxPrice': instance.maxPrice,
      'originPrice': instance.originPrice,
      'salesVolume': instance.salesVolume,
      'consigneeAddress': instance.consigneeAddress,
      'fareAmount': instance.fareAmount,
      'allComment': instance.allComment,
      'merchantName': instance.merchantName,
      'merchantPhone': instance.merchantPhone,
      'evaluationInfos': instance.evaluationInfos,
    };
