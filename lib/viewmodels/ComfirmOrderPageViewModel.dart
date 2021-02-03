import 'package:flutter_etu_remake/models/ShoppingOrder.dart';
import 'package:flutter_etu_remake/viewmodels/DeliveryAddressItemViewModel.dart';
import 'package:flutter_etu_remake/viewmodels/PurchaseCommodityItemViewModel.dart';

class ComfirmOrderPageViewModel {
  DeliveryAddressItemViewModel deliveryAddress;
  Map<String, List<PurchaseCommodityItemViewModel>> commoditiesMap;
  String weight;
  String orderAmount;
  String fareAmount;
  String totalAmount;
  int commodityAmount;
  String orderNo;

  ComfirmOrderPageViewModel();

  factory ComfirmOrderPageViewModel.transform(ShoppingOrder order) {
    Map<String, List<PurchaseCommodityItemViewModel>> commoditiesMap = {};

    order.parts?.forEach((element) {
      commoditiesMap.putIfAbsent(element.shopName, () => element.commodities?.map((e) {
        return PurchaseCommodityItemViewModel()
          ..image = e.mainPicture
          ..title = e.title
          ..subtitle = e.specification
          ..price = e.price
          ..originalPrice = e.originalPrice == null ? null: double.parse(e.originalPrice)
          ..quantity = e.quantity;
      })?.toList());
     
    });

    return ComfirmOrderPageViewModel()
      ..deliveryAddress =DeliveryAddressItemViewModel.transform(order.addressDisplay)
      ..commoditiesMap = commoditiesMap
      ..weight = order.weight
      ..orderAmount = order.orderAmount
      ..fareAmount = order.fareAmount
      ..totalAmount = order.totalAmount
      ..commodityAmount = order.commodityAmount
      ..orderNo = order.orderNo;
  }
}
