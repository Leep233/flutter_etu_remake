import 'package:flutter_etu_remake/models/OrderDetail.dart';
import 'package:json_annotation/json_annotation.dart';

//flutter packages pub run build_runner build

part 'MyOrders.g.dart';

@JsonSerializable()
class MyOrders{

  int total;
  List<OrderDetail> result;

  MyOrders();
  factory MyOrders.fromJson(Map<String, dynamic> json) => _$MyOrdersFromJson(json);
  Map<String, dynamic> toJson() => _$MyOrdersToJson(this);

}