import 'package:flutter/cupertino.dart';
import 'package:flutter_etu_remake/models/Commodity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'CommodityCardViewModel.g.dart';

@JsonSerializable()
class CommodityCardViewModel {
  //商品id
  String commodityId;

  ///商铺id
  String storeId;

  ///商品名称
  String commodityName;

  ///商铺名称
  String storeName;

  ///商品优势
  String advantage;

  ///推荐搭配
  String suggested;

  ///售价
  double price;

  ///原价
  double originalPrice;

  ///销量
  int salesVolume;

  ///词条
  List<String> tips;

  ///商品图片
  String image;

  CommodityCardViewModel();
  factory CommodityCardViewModel.fromJson(Map<String, dynamic> json) =>
      _$CommodityCardViewModelFromJson(json);
  Map<String, dynamic> toJson() => _$CommodityCardViewModelToJson(this);

  factory CommodityCardViewModel.transform(Commodity commodity) {
   return  CommodityCardViewModel()..advantage = commodity.advantage
..commodityId = commodity.productNo
..commodityName = commodity.title
..image = commodity.mainPicture
..originalPrice = double.parse(commodity.originalPrice??'0')
..price = double.parse(commodity.sellingPrice??'0')
..salesVolume = commodity.salesVolume
..suggested = commodity.recommendMatch
..tips = [commodity.feature]
..storeName = commodity.shopName
..storeId = commodity.merchantId; 

  }
}
