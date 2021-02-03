// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Category.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Category _$CategoryFromJson(Map<String, dynamic> json) {
  return Category()
    ..id = json['id'] as int
    ..categoryName = json['categoryName'] as String
    ..categories = (json['categories'] as List)
        ?.map((e) =>
            e == null ? null : Category.fromJson(e as Map<String, dynamic>))
        ?.toList()
    ..productInfos = (json['productInfos'] as List)
        ?.map((e) =>
            e == null ? null : Commodity.fromJson(e as Map<String, dynamic>))
        ?.toList();
}

Map<String, dynamic> _$CategoryToJson(Category instance) => <String, dynamic>{
      'id': instance.id,
      'categoryName': instance.categoryName,
      'categories': instance.categories,
      'productInfos': instance.productInfos,
    };
