// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'City.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

City _$CityFromJson(Map<String, dynamic> json) {
  return City(
    name: json['name'] as String,
    tagIndex: json['tagIndex'] as String,
  )
    ..shrink = json['shrink'] as String
    ..namePinyin = json['namePinyin'] as String
    ..isShowSuspension = json['isShowSuspension'] as bool;
}

Map<String, dynamic> _$CityToJson(City instance) => <String, dynamic>{
      'name': instance.name,
      'tagIndex': instance.tagIndex,
      'shrink': instance.shrink,
      'namePinyin': instance.namePinyin,
      'isShowSuspension': instance.isShowSuspension,
    };
