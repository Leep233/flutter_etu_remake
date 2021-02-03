import 'package:json_annotation/json_annotation.dart';

//flutter packages pub run build_runner build

part 'Commodity.g.dart';

/*
0:"productNo" -> "10000088"
1:"title" -> "半身裙秋冬2020新款黑色开叉针织裙子女中长款高腰a字显瘦包臀裙"
2:"subtitle" -> "开叉针织裙子女中长款"
3:"placeOfProduct" -> "深圳"
4:"feature" -> "廓形: H型"
5:"advantage" -> "通勤: 韩版"
6:"recommendMatch" -> "百搭"
7:"mainPicture" -> "https://e-buy.oss-cn-shenzhen.aliyuncs.com/productProfile/1610678787547.jpeg"
8:"originalPrice" -> "459.00"
9:"sellingPrice" -> "359.00"
10:"salesVolume" -> 5
11:"merchantId" -> "1"
12:"shopName" -> "云娜时装城"
13:"isHot" -> 1
14:"isRecommend" -> 0
15:"userNum" -> 0
 */

/*
0:"productNo" -> "10000083"
1:"title" -> "执政官夏季战术速干T恤男军迷短袖户外运动圆领短袖特种兵速干衣"
2:"subtitle" -> "全场正品 达人推荐 无忧退换"
3:"placeOfProduct" -> "深圳"
4:"feature" -> "全场正品"
5:"advantage" -> "无忧退换"
6:"recommendMatch" -> "百搭"
7:"mainPicture" -> "https://e-buy.oss-cn-shenzhen.aliyuncs.com/productProfile/1610673961591.jpeg"
8:"originalPrice" -> "369.00"
9:"sellingPrice" -> "45.00"
10:"salesVolume" -> 2
11:"merchantId" -> "1"
12:"shopName" -> "云娜时装城"
13:"isHot" -> 1
14:"isRecommend" -> 0
15:"userNum" -> 0

 */



@JsonSerializable()
class Commodity {
  

  String productNo;

  String merchantId;

  String shopName;

  int isHot;

  int isRecommend;

  String title;

  String subtitle;

  String placeOfProduct;

  String feature;

  String advantage;

  String recommendMatch;

  String mainPicture;

  String originalPrice;

  String sellingPrice;

  int salesVolume;

  String merchantName;

  int collectNum;

  /*
  :"id" -> 117
1:"productNo" -> "10000052"
2:"commodityNo" -> "10000052001"
3:"title" -> "鸭鸭羽绒服男2020年新款连帽防风保暖潮流帅气短款冬季男士外套潮"
4:"subTitle" -> "羽绒行家|鸭鸭专注羽绒48年！"
5:"specification" -> "{"颜色":"雾霾蓝","尺码":"M"}"
6:"mainPicture" -> "https://e-buy.oss-cn-shenzhen.aliyuncs.com/productProfile/1610084502687.jpeg"
7:"price" -> 0.01
8:"quantity" -> 2
9:"inventory" -> 754
10:"weight" -> 1.0
11:"selected" -> 0
12:"isLock" -> null
   */

  int id;
  String commodityNo;
  String specification;
  double price;
  int quantity;
  int inventory;
  double weight;
  int  selected;
  int isLock;
  String formatSpec;
  int afterSaleStatus;

  Commodity();
  factory Commodity.fromJson(Map<String, dynamic> json) =>
      _$CommodityFromJson(json);
  Map<String, dynamic> toJson() => _$CommodityToJson(this);

  static List<Commodity> fromJsonList(List<dynamic> jsonList) {
    List<Commodity> list = [];
    jsonList.forEach((element) {
      list.add(Commodity.fromJson(element));
    });

    return list;
  }
}
