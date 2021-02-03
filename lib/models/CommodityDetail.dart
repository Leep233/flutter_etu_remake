import 'package:flutter_etu_remake/models/Comment.dart';
import 'package:json_annotation/json_annotation.dart';

//flutter packages pub run build_runner build

part 'CommodityDetail.g.dart';

/*

0:"id" -> 3
1:"belongMerchant" -> 1
2:"isCollect" -> 0
3:"productNo" -> "10000052"
4:"title" -> "鸭鸭羽绒服男2020年新款连帽防风保暖潮流帅气短款冬季男士外套潮"
5:"subtitle" -> "羽绒行家|鸭鸭专注羽绒48年！"
6:"placeOfProduct" -> "深圳"
7:"feature" -> "商场同款"
8:"advantage" -> "聚酯纤维100%"
9:"recommendMatch" -> "百搭"
10:"mainPicture" -> "https://e-buy.oss-cn-shenzhen.aliyuncs.com/productProfile/1610084502687.jpeg"
11:"video" -> "https://e-buy.oss-cn-shenzhen.aliyuncs.com/productProfile/1610084508420.mp4"
12:"slideShow" -> "https://e-buy.oss-cn-shenzhen.aliyuncs.com/productProfile/1610084537482.jpeg,https://e-buy.oss-cn-shenzhen.aliyuncs.com/productP…"
13:"specificationJson" -> "{"颜色":["雾霾蓝","黑色"],"尺码":["M","L","XL"]}"
14:"details" -> "<p><br><img src="https://e-buy.oss-cn-shenzhen.aliyuncs.com/productProfile/rich/1610084753725.jpeg" style="max-width:100%;"><img…"
15:"hotSellRecommend" -> 1
16:"categoryRecommend" -> 0
17:"pageView" -> 0
18:"inventory" -> 4724
19:"price" -> "0.01"
20:"minPrice" -> "0.01"
21:"maxPrice" -> "0.01"
22:"originPrice" -> "698.00"
23:"salesVolume" -> 96
24:"consigneeAddress" -> "广东省深圳市"
25:"fareAmount" -> "免运费"
26:"allComment" -> 4
27:"merchantName" -> "云娜时装城"
28:"merchantPhone" -> "18819015201"
29:"evaluationInfos" -> List (1 item)

 */




@JsonSerializable()
class CommodityDetail{

  int id;
  int belongMerchant;
  int isCollect;
  String productNo;
  String title;
  String subtitle;
  String placeOfProduct;
  String feature;
  String advantage;
  String recommendMatch;
  String mainPicture;
  String video;
  String slideShow;
  String specificationJson;
  String details;
  int hotSellRecommend;
  int categoryRecommend;
  int inventory;
  String price;
  String minPrice;
  String maxPrice;
  String originPrice;
  int salesVolume;
  String consigneeAddress;
  String fareAmount;
  int allComment;
  String merchantName;
  String merchantPhone;


  List<Comment> evaluationInfos;

  CommodityDetail();
  factory CommodityDetail.fromJson(Map<String, dynamic> json) => _$CommodityDetailFromJson(json);
  Map<String, dynamic> toJson() => _$CommodityDetailToJson(this);

}