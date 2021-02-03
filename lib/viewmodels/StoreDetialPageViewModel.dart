


import 'package:flutter_etu_remake/models/StoreDetial.dart';
import 'package:flutter_etu_remake/viewmodels/CommodityCardViewModel.dart';

class StoreDetialPageViewModel{
  String storeId;
  String title;
  double starlevel;
  bool isMark;
  String phone;
  int funsNumber;

  List<CommodityCardViewModel> commodities;
  
  StoreDetialPageViewModel({this.isMark = false});
  

  factory StoreDetialPageViewModel.transform(StoreDetial detial){
    
    return StoreDetialPageViewModel()..isMark = detial.isFollow==1
    ..storeId = detial.id?.toString()
    ..title =detial.shopName
    ..starlevel = detial.currentStar
    ..phone = detial.merchantPhone
    ..commodities = detial.productList?.map((e) => CommodityCardViewModel.transform(e))?.toList()
    ..funsNumber = detial.followNumber;
  }
} 