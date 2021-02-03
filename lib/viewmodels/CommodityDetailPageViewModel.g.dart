// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'CommodityDetailPageViewModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CommodityDetailPageViewModel _$CommodityDetailPageViewModelFromJson(
    Map<String, dynamic> json) {
  return CommodityDetailPageViewModel()
    ..id = json['id'] as String
    ..storeId = json['storeId'] as String
    ..productNo = json['productNo'] as String
    ..mianPicture = json['mianPicture'] as String
    ..price = (json['price'] as num)?.toDouble()
    ..originalPrice = (json['originalPrice'] as num)?.toDouble()
    ..title = json['title'] as String
    ..subTitle = json['subTitle'] as String
    ..details = json['details'] as String
    ..placeOfProduct = json['placeOfProduct'] as String
    ..feature = json['feature'] as String
    ..advantage = json['advantage'] as String
    ..suggested = json['suggested'] as String
    ..postage = json['postage'] as String
    ..address = json['address'] as String
    ..addressId = json['addressId'] as int
    ..images = (json['images'] as List)?.map((e) => e as String)?.toList()
    ..isFavorite = json['isFavorite'] as bool
    ..comments = (json['comments'] as List)
        ?.map((e) => e == null
            ? null
            : CommentCardViewModel.fromJson(e as Map<String, dynamic>))
        ?.toList()
    ..specifications = (json['specifications'] as Map<String, dynamic>)?.map(
      (k, e) => MapEntry(k, (e as List)?.map((e) => e as String)?.toList()),
    )
    ..selectedSpecification =
        (json['selectedSpecification'] as Map<String, dynamic>)?.map(
      (k, e) => MapEntry(k, e as String),
    );
}

Map<String, dynamic> _$CommodityDetailPageViewModelToJson(
        CommodityDetailPageViewModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'storeId': instance.storeId,
      'productNo': instance.productNo,
      'mianPicture': instance.mianPicture,
      'price': instance.price,
      'originalPrice': instance.originalPrice,
      'title': instance.title,
      'subTitle': instance.subTitle,
      'details': instance.details,
      'placeOfProduct': instance.placeOfProduct,
      'feature': instance.feature,
      'advantage': instance.advantage,
      'suggested': instance.suggested,
      'postage': instance.postage,
      'address': instance.address,
      'addressId': instance.addressId,
      'images': instance.images,
      'isFavorite': instance.isFavorite,
      'comments': instance.comments,
      'specifications': instance.specifications,
      'selectedSpecification': instance.selectedSpecification,
    };
