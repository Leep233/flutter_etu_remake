import 'package:flutter_etu_remake/models/Commodity.dart';

class StoreOrderCommodityItemViewModel{
  String image;
  String title;
  String subtitle;
  double price;
  double originalPrice;
  int quantity;
  StoreOrderCommodityItemViewModel();
 factory StoreOrderCommodityItemViewModel.transform(Commodity e) {
   return StoreOrderCommodityItemViewModel()..image = e.mainPicture
   ..title = e.title
   ..subtitle = e.specification
   ..price = e.price
   ..quantity = e.quantity;
  }
}