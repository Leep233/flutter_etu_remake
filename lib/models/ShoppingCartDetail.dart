import 'package:flutter_etu_remake/models/ShoppingOrderDetailPart.dart';
import 'package:json_annotation/json_annotation.dart';

//flutter packages pub run build_runner build

part 'ShoppingCartDetail.g.dart';

/*

  0:"totalAmount" -> 0
1:"parts" -> List (1 item)
 */

@JsonSerializable()
class ShoppingCartDetail{

  double totalAmount;
  List<ShoppingOrderDetailPart> parts;

  ShoppingCartDetail();
  factory ShoppingCartDetail.fromJson(Map<String, dynamic> json) => _$ShoppingCartDetailFromJson(json);
  Map<String, dynamic> toJson() => _$ShoppingCartDetailToJson(this);

}