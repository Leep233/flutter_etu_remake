import 'package:flutter_etu_remake/models/Commodity.dart';
import 'package:json_annotation/json_annotation.dart';

//flutter packages pub run build_runner build

part 'StoreDetial.g.dart';


/*

0:"id" -> 1
1:"shopName" -> "云娜时装城"
2:"shopAddress" -> "广东省深圳市深圳市南山区常兴路86号"
3:"merchantPhone" -> "18819015201"
4:"businessCategory" -> "服装批发，专注女性"
5:"currentStar" -> 4.3
6:"shopDepict" -> "专注于时尚女装的面料、款式、工艺的研发以及成品服装的自产自销。"
7:"followNumber" -> 8
8:"isFollow" -> 1
9:"merchantPicture" -> "https://e-buy.oss-cn-shenzhen.aliyuncs.com/productProfile/1610078341195.jpeg"
10:"productList" -> List (10 items)


 */

@JsonSerializable()
class StoreDetial{

  int id;
  ///店铺名称
  String shopName;
  ///店平铺地址
  String shopAddress;
  ///店铺电话
  String merchantPhone;
  ///
  String businessCategory;
  ///店铺评分
  double currentStar;
  ///店铺描述
  String shopDepict;
  ///关注数量
  int followNumber;
  ///是否关注 0：否 1：是
  int isFollow;
  ///店铺图片
  String merchantPicture;
  ///商品列表
  List<Commodity> productList;
  ///关注店铺
  List<Commodity> commodityList;
  ///关注时间
  String followTime;


  StoreDetial();
  factory StoreDetial.fromJson(Map<String, dynamic> json) => _$StoreDetialFromJson(json);
  Map<String, dynamic> toJson() => _$StoreDetialToJson(this);

  static List<StoreDetial> fromJsonList(List<dynamic> jsonMap) {
    List<StoreDetial> result = [];

  jsonMap?.forEach((element) {
    result.add(StoreDetial.fromJson(element));
  });

    return result;
  }

}