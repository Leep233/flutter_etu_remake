import 'package:flutter_etu_remake/models/Commodity.dart';
import 'package:json_annotation/json_annotation.dart';

//flutter packages pub run build_runner build

part 'ShoppingOrderDetailPart.g.dart';

/*
0:"id" -> 1
1:"shopName" -> "云娜时装城"
2:"commodities" -> List (3 items)
3:"commodityPrice" -> null
4:"commodityWeight" -> null
5:"fareAmount" -> null
 */

@JsonSerializable()
class ShoppingOrderDetailPart{

  int id;
  String shopName;
  List<Commodity> commodities;
  double fareAmount;
  double commodityWeight;
  double commodityPrice;



  ShoppingOrderDetailPart();
  factory ShoppingOrderDetailPart.fromJson(Map<String, dynamic> json) => _$ShoppingOrderDetailPartFromJson(json);
  Map<String, dynamic> toJson() => _$ShoppingOrderDetailPartToJson(this);

}