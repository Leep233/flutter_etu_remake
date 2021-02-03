import 'package:flutter_etu_remake/models/Deliveryaddress.dart';
import 'package:flutter_etu_remake/models/ShoppingOrderDetailPart.dart';
import 'package:json_annotation/json_annotation.dart';

//flutter packages pub run build_runner build

part 'ShoppingOrder.g.dart';

@JsonSerializable()
class ShoppingOrder{

/*
0:"addressDisplay" -> Map (8 items)
1:"parts" -> List (1 item)
2:"weight" -> "4.00"
3:"orderAmount" -> "136.02"
4:"fareAmount" -> "0"
5:"totalAmount" -> "136.02"
6:"commodityAmount" -> 4
7:"orderNo" -> "11611285660141"
*/
Deliveryaddress addressDisplay;
List<ShoppingOrderDetailPart> parts;
String weight;
String orderAmount;
String fareAmount;
String totalAmount;
int commodityAmount;
String orderNo;


  ShoppingOrder();
  factory ShoppingOrder.fromJson(Map<String, dynamic> json) => _$ShoppingOrderFromJson(json);
  Map<String, dynamic> toJson() => _$ShoppingOrderToJson(this);

}