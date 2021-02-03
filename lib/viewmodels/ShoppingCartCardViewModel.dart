import 'package:flutter_etu_remake/models/Commodity.dart';
import 'package:flutter_etu_remake/models/ShoppingOrderDetailPart.dart';

class ShoppingCartCardViewModel{
  String id;
  bool allSelected;
  String title;
  List<ShoppingCartCardItemViewModel> items;
  ShoppingCartCardViewModel({this.allSelected = false});
   factory ShoppingCartCardViewModel.transform(ShoppingOrderDetailPart commodity){
      return ShoppingCartCardViewModel()..title = commodity.shopName
      ..items = commodity.commodities?.map((e) => ShoppingCartCardItemViewModel.transform(e))?.toList();

   }
}

class ShoppingCartCardItemViewModel{
  String id;
  bool selected;
  String title;
  String subtitle;
  String image;
  double price;
  int quantity;  
  String productNo;
  String commodityNo;
  String specification;
  int inventory;

  bool get understock =>((this.inventory??0)>=(this.quantity??0));  

  ShoppingCartCardItemViewModel({this.selected = false});


  factory ShoppingCartCardItemViewModel.transform(Commodity commodity)
  {
/*
"id" -> 117
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

  return  ShoppingCartCardItemViewModel()..selected =commodity.selected==1
  ..id = commodity.id?.toString()
  ..productNo =commodity.productNo
  ..title = commodity.title
  ..subtitle = commodity.subtitle
  ..specification = commodity.specification
  ..image = commodity.mainPicture
  ..price = commodity.price
  ..quantity = commodity.quantity
  ..commodityNo = commodity.commodityNo
  ..inventory = commodity.inventory;
  }
}