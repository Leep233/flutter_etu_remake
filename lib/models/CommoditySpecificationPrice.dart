import 'package:json_annotation/json_annotation.dart';

//flutter packages pub run build_runner build

/*
"commodityNo" -> "10000052001"
1:"inventory" -> 755
2:"originalPrice" -> 698.0
3:"sellingPrice" -> 0.01
4:"weight" -> 1.0
5:"picture" -> "https://e-buy.oss-cn-shenzhen.aliyuncs.com/productProfile/1610084674360.jpeg"

*/

part 'CommoditySpecificationPrice.g.dart';

@JsonSerializable()


class CommoditySpecificationPrice{

  String commodityNo;
  int inventory;
  double originalPrice;
  double sellingPrice;
  double weight;
  String picture;


  CommoditySpecificationPrice();

  
  factory CommoditySpecificationPrice.fromJson(Map<String, dynamic> json) => _$CommoditySpecificationPriceFromJson(json);

  Map<String, dynamic> toJson() => _$CommoditySpecificationPriceToJson(this);

}