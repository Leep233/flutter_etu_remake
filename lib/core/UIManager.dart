import 'package:flutter/material.dart';

class UIDef {
  static String login = "pages/LoginPage.dart";
  static String register = "pages/RegisterPage.dart";
  static String forgotPassword = "pages/ForgotPasswordPage.dart";
  static String quickLoginByPhoneNumber =
      "pages/QuickLoginByPhoneNumberPage.dart";
  static String home = "pages/HomePage.dart";
  static String hotSale = "pages/HotSalePage.dart";
  static String commodityDetail = "pages/CommodityDetailPage.dart";
  static String commentList = "pages/CommentListPage.dart";
  static String deliveryAddress = "pages/DeliveryAddressListPage.dart";
  static String storeDetial = "pages/StoreDetialPage.dart";
  static String comfirmOrder = "pages/ComfirmOrderPage.dart";
  static String collectionCommodity = "pages/CollectionCommodityPage.dart";
  static String categoryCommodity = "pages/CategoryCommodityPage.dart";
  static String collectionStore = "pages/CollectionStorePage.dart";
  static String myOrders = "pages/MyOrdersPage.dart";
  static String payment = "pages/PaymentPage.dart";
  static String prepaymentOrderDetail = "pages/PrepaymentOrderDetailPage.dart";
  static String paymentFailure = "pages/PaymentFailurePage.dart";
  static String paymentSuccess = "pages/PaymentSuccessPage.dart";
  static String footprint = "pages/FootprintPage.dart";
  static String userBalance = "pages/UserBalancePage.dart";
  static String suggestionFeedback = "pages/SuggestionFeedbackPage.dart";
  static String changeDetail = "pages/ChangeDetailPage.dart";
  static String withdrawal = "pages/WithdrawalPage.dart";
  static String messageCenter = "pages/MessageCenterPage.dart";
}

class UIManager {
  UIManager._();

  static UIManager _instance;
  static UIManager get instance => _getInstance();

  static UIManager _getInstance() {
    if (_instance == null) _instance = UIManager._();

    return _instance;
  }

//返回上一页
  toBack<T extends Object>(BuildContext context, {T arg}) {
    if (Navigator.canPop(context)) Navigator.pop<T>(context, arg);
  }

//页面跳转 异步
  Future<T> toPage<T>(
    BuildContext context,
    String routeName, {
    Object arguments,
  }) {
    return Navigator.pushNamed<T>(context, routeName, arguments: arguments);
  }

  Future<void> init() async {
    print("${this.runtimeType} init !");
  }

  void release() {}
}
