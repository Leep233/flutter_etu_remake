import 'package:flutter_etu_remake/models/OrderDetail.dart';
import 'package:flutter_etu_remake/viewmodels/StoreOrderCommodityItemViewModel.dart';

class OrderDetialCommodityCardViewModel {
  String storeName;
  String orderNo;

  ///订单状态 1待付款 2待发货 3待收货 4 待评价 5交易成功 6交易关闭
  int orderStatus;
  int commodityCount;
  double totalAomunt;
  String remarks;
  List<StoreOrderCommodityItemViewModel> items;
  OrderDetialCommodityCardViewModel();
  factory OrderDetialCommodityCardViewModel.transform(OrderDetail e) {
    return OrderDetialCommodityCardViewModel()
      ..storeName = e.shopName
      ..orderNo = e.orderNo
      ..orderStatus = e.orderStatus
      ..commodityCount = e.commodityNum
      ..totalAomunt = e.totalAmount
      ..remarks = e.remarks
      ..items = e.commodities
          ?.map((e) => StoreOrderCommodityItemViewModel.transform(e))
          ?.toList();
  }
}
