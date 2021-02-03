import 'package:flutter_etu_remake/models/OrderDetail.dart';
import 'package:flutter_etu_remake/viewmodels/DeliveryAddressItemViewModel.dart';
import 'package:flutter_etu_remake/viewmodels/OrderDetailCommodityCardViewModel.dart';


class PrepaymentOrderDetailPageViewModel{
  
  String orderNo;
  int storeId;
  String storeName;
  int orderStatus;
  String orderStatusDepict;
  String orderTime; 

  List<OrderDetialCommodityCardViewModel> commodities;
  DeliveryAddressItemViewModel address;
  double orderWeight;
  double orderFare;
  double orderAmount;
  double totalAmount;
  String remarks;
  int paymentChannel;
  String outTradeNo;
  String paymentTime;
  String shippingTime;
  String receivingTime;
  String finishTime;
  dynamic trailInfo;


  PrepaymentOrderDetailPageViewModel();

  factory PrepaymentOrderDetailPageViewModel.transform(OrderDetail value) {

    DeliveryAddressItemViewModel addressItemViewModel = DeliveryAddressItemViewModel();
    addressItemViewModel.address = value.consigneeAddress;
    addressItemViewModel.phone = value.consigneePhone;
    addressItemViewModel.name = value.consignee;
  

    return PrepaymentOrderDetailPageViewModel()..address = addressItemViewModel
    ..orderWeight = value.subOrderWeight
    ..orderFare = value.subOrderFare
    ..orderAmount = value.subOrderAmount
    ..totalAmount = value.totalAmount
    ..remarks = value.remarks
    ..paymentChannel = int.parse( value?.paymentChannel?.toString()??"-1")
    ..outTradeNo = value.outTradeNo
    ..paymentTime = value.paymentTime
    ..shippingTime = value.shippingTime
    ..receivingTime = value.receivingTime
    ..finishTime = value.finishTime
    ..trailInfo = value.trailInfo
    ..orderStatusDepict = value.orderStatusDepict
    ..orderTime = value.orderTime
    ..orderStatus = value.orderStatus
    ..orderNo = value.orderNo
    ..storeId = value.belongMerchant
    ..commodities = [OrderDetialCommodityCardViewModel.transform(value)] 
    ..storeName = value.shopName;
  }

}

