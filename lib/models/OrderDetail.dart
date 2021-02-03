
import 'package:flutter_etu_remake/models/Commodity.dart';
import 'package:json_annotation/json_annotation.dart';

//flutter packages pub run build_runner build

part 'OrderDetail.g.dart';

@JsonSerializable()
class OrderDetail{
  ///订单编号
  String orderNo;
  ///订单编号
  String subOrderNo;
  ///店铺ID
  int belongMerchant;
  ///店铺名称
  String shopName;
  ///商品数量
  int commodityNum;
  ///订单商品总额
  double orderAmount;
  ///合计金额
  double totalAmount;
  ///订单状态 1待付款 2待发货 3待收货 4 待评价 5交易成功 6交易关闭
  int orderStatus;
  ///下单时间
  String orderTime;
  ///订单内商品列表
  List<Commodity> commodities;
///订单状态描述
  String orderStatusDepict;
///收货人姓名
  String consignee;
  ///收货人手机号码
  String consigneePhone;
  ///收获地址
  String consigneeAddress;
///订单总重
  double subOrderWeight;
  ///订单运费
  double subOrderFare;
  ///订单商品总额
  double subOrderAmount;
  ///备注
   String remarks;
   ///支付方式
    String paymentChannel;
    ///支付流水号
     String outTradeNo;
     ///支付时间
     String paymentTime;
     ///发货时间
     String shippingTime;
     ///收货时间
     String receivingTime;
     ///结束时间
     String finishTime;
     ///物流最新信息
     Map trailInfo;
  //double totalAmount;

  OrderDetail();
  factory OrderDetail.fromJson(Map<String, dynamic> json) => _$OrderDetailFromJson(json);
  Map<String, dynamic> toJson() => _$OrderDetailToJson(this);

}