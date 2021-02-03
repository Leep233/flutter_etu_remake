// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'OrderDetail.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderDetail _$OrderDetailFromJson(Map<String, dynamic> json) {
  return OrderDetail()
    ..orderNo = json['orderNo'] as String
    ..subOrderNo = json['subOrderNo'] as String
    ..belongMerchant = json['belongMerchant'] as int
    ..shopName = json['shopName'] as String
    ..commodityNum = json['commodityNum'] as int
    ..orderAmount = (json['orderAmount'] as num)?.toDouble()
    ..totalAmount = (json['totalAmount'] as num)?.toDouble()
    ..orderStatus = json['orderStatus'] as int
    ..orderTime = json['orderTime'] as String
    ..commodities = (json['commodities'] as List)
        ?.map((e) =>
            e == null ? null : Commodity.fromJson(e as Map<String, dynamic>))
        ?.toList()
    ..orderStatusDepict = json['orderStatusDepict'] as String
    ..consignee = json['consignee'] as String
    ..consigneePhone = json['consigneePhone'] as String
    ..consigneeAddress = json['consigneeAddress'] as String
    ..subOrderWeight = (json['subOrderWeight'] as num)?.toDouble()
    ..subOrderFare = (json['subOrderFare'] as num)?.toDouble()
    ..subOrderAmount = (json['subOrderAmount'] as num)?.toDouble()
    ..remarks = json['remarks'] as String
    ..paymentChannel = json['paymentChannel'] as String
    ..outTradeNo = json['outTradeNo'] as String
    ..paymentTime = json['paymentTime'] as String
    ..shippingTime = json['shippingTime'] as String
    ..receivingTime = json['receivingTime'] as String
    ..finishTime = json['finishTime'] as String
    ..trailInfo = json['trailInfo'] as Map<String, dynamic>;
}

Map<String, dynamic> _$OrderDetailToJson(OrderDetail instance) =>
    <String, dynamic>{
      'orderNo': instance.orderNo,
      'subOrderNo': instance.subOrderNo,
      'belongMerchant': instance.belongMerchant,
      'shopName': instance.shopName,
      'commodityNum': instance.commodityNum,
      'orderAmount': instance.orderAmount,
      'totalAmount': instance.totalAmount,
      'orderStatus': instance.orderStatus,
      'orderTime': instance.orderTime,
      'commodities': instance.commodities,
      'orderStatusDepict': instance.orderStatusDepict,
      'consignee': instance.consignee,
      'consigneePhone': instance.consigneePhone,
      'consigneeAddress': instance.consigneeAddress,
      'subOrderWeight': instance.subOrderWeight,
      'subOrderFare': instance.subOrderFare,
      'subOrderAmount': instance.subOrderAmount,
      'remarks': instance.remarks,
      'paymentChannel': instance.paymentChannel,
      'outTradeNo': instance.outTradeNo,
      'paymentTime': instance.paymentTime,
      'shippingTime': instance.shippingTime,
      'receivingTime': instance.receivingTime,
      'finishTime': instance.finishTime,
      'trailInfo': instance.trailInfo,
    };
