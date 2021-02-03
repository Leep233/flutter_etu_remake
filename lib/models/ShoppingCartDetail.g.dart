// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ShoppingCartDetail.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ShoppingCartDetail _$ShoppingCartDetailFromJson(Map<String, dynamic> json) {
  return ShoppingCartDetail()
    ..totalAmount = (json['totalAmount'] as num)?.toDouble()
    ..parts = (json['parts'] as List)
        ?.map((e) => e == null
            ? null
            : ShoppingOrderDetailPart.fromJson(e as Map<String, dynamic>))
        ?.toList();
}

Map<String, dynamic> _$ShoppingCartDetailToJson(ShoppingCartDetail instance) =>
    <String, dynamic>{
      'totalAmount': instance.totalAmount,
      'parts': instance.parts,
    };
