


import 'package:flutter_etu_remake/models/Commodity.dart';

class CollectionCommodityCardViewModel{

  String productNo;
  String title;
  String subtitle;
  double price;
   ///销量
  int collectNum;
  String storeName;
  String image;

  CollectionCommodityCardViewModel();


  factory CollectionCommodityCardViewModel.transform(Commodity commodity)
   {
      return CollectionCommodityCardViewModel()..title = commodity.title
      ..collectNum = commodity.collectNum
      ..storeName = commodity.merchantName
      ..productNo = commodity.productNo
      ..price = commodity.price
      ..subtitle = commodity.subtitle    
      ..image = commodity.mainPicture;
   } 

}