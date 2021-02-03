// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Deliveryaddress.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Deliveryaddress _$DeliveryaddressFromJson(Map<String, dynamic> json) {
  return Deliveryaddress()
    ..id = json['id']?.toString()
    ..consignee = json['consignee'] as String
    ..consigneePhone = json['consigneePhone'] as String
    ..province = json['province'] as String
    ..provinceCode = json['provinceCode'] as String
    ..prefecture = json['prefecture'] as String
    ..prefectureCode = json['prefectureCode'] as String
    ..county = json['county'] as String
    ..countyCode = json['countyCode'] as String
    ..detailAddress = json['detailAddress'] as String
    ..consigneeAddress = json['consigneeAddress'] as String
    ..isDefault = json['isDefault'] as int;
}

Map<String, dynamic> _$DeliveryaddressToJson(Deliveryaddress instance) =>
    <String, dynamic>{
      'id': instance.id,
      'consignee': instance.consignee,
      'consigneePhone': instance.consigneePhone,
      'province': instance.province,
      'provinceCode': instance.provinceCode,
      'prefecture': instance.prefecture,
      'prefectureCode': instance.prefectureCode,
      'county': instance.county,
      'countyCode': instance.countyCode,
      'detailAddress': instance.detailAddress,
      'consigneeAddress': instance.consigneeAddress,
      'isDefault': instance.isDefault,
    };
