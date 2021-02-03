import 'package:flutter_etu_remake/models/PaymentDetail.dart';

class PaymentPageViewModel{
  double price;
  int seconds;
  /// 支付渠道 1支付宝 2微信
  int payMode;
  String orderNo;

  PaymentPageViewModel({this.seconds =900,this.payMode = 2});

  factory PaymentPageViewModel.transform(PaymentDetail value) {
  
    DateTime time = DateTime.parse(value.date);

    DateTime now = DateTime.now();

    Duration duration = now.difference(time);

    int seconds = 900 - (duration.inMinutes*60 + duration.inSeconds);

    return PaymentPageViewModel()..price = value.payAmount
    ..orderNo = value.orderNo
    ..seconds = seconds;

  }
}