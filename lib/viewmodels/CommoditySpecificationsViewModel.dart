import 'package:flutter/cupertino.dart';
import 'package:flutter_etu_remake/models/CommoditySpecificationPrice.dart';
import 'package:json_annotation/json_annotation.dart';

//flutter packages pub run build_runner build

part 'CommoditySpecificationsViewModel.g.dart';

@JsonSerializable()
class CommoditySpecificationsViewModel{

  String productNo;
  String commodityNo;
  int inventory;
  double originalPrice;
  double sellingPrice;
  double weight;
  String picture;
  String describe;
  int quantity;

  Map<String, List<String>> specifications;

  CommoditySpecificationsViewModel({@required this.productNo,this.quantity = 1,this.specifications,this.describe,this.picture});

  factory CommoditySpecificationsViewModel.fromJson(Map<String, dynamic> json) => _$CommoditySpecificationsViewModelFromJson(json);
  Map<String, dynamic> toJson() => _$CommoditySpecificationsViewModelToJson(this);

  

}