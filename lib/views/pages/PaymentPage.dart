import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_etu_remake/AppDefaultStyle.dart';
import 'package:flutter_etu_remake/WidgetComponents.dart';
import 'package:flutter_etu_remake/core/NetworkManager.dart';
import 'package:flutter_etu_remake/core/UIManager.dart';
import 'package:flutter_etu_remake/viewmodels/PaymentPageViewModel.dart';
import 'package:flutter_etu_remake/Debug.dart';

//支付页面
class PaymentPage extends StatefulWidget {
  PaymentPage({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => PaymentPageState();
}

class PaymentPageState extends State<PaymentPage> {
  PaymentPageViewModel viewModel;

  Timer _timer;

  @override
  void initState() {
    super.initState();

    viewModel = new PaymentPageViewModel(seconds: 10);

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      viewModel = ModalRoute.of(context).settings.arguments;
      _$RefreshUI();
      _timer = Timer.periodic(Duration(seconds: 1), onTimerCallback);
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void deactivate() {
    super.deactivate();
    _timer?.cancel();
  }

  _$RefreshUI() {
    if (mounted) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    Size screen = MediaQuery.of(context).size;
    return Scaffold(
      extendBodyBehindAppBar: true,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        centerTitle: true,
        toolbarHeight: AppDefaultStyle.appBarHeight,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        title: Text("支付页面"),
        leading: IconButton(
            icon: Icon(Icons.chevron_left),
            onPressed: () => Navigator.pop(context)),
      ),
      body: Container(
          width: screen.width,
          height: screen.height,
          decoration: BoxDecoration(
              image: DecorationImage(
                  alignment: Alignment.topCenter,
                  fit: BoxFit.fitWidth,
                  image: AssetImage('assets/images/pay_bg.png'))),
          child: _$BuildContent(context)),
    );
  }

  Widget _$BuildContent(BuildContext context) {
    return Container(
        child: Column(children: [
      Expanded(
          flex: 2,
          child: Container(
              margin: const EdgeInsets.only(top: 40),
              width: double.infinity,
              child: _$PayTime())),
      Expanded(
          flex: 4,
          child: Container(
              margin: const EdgeInsets.fromLTRB(15, 30, 15, 0),
              width: double.infinity,
              child: _$PayMode())),
    ]));
  }

  Widget _$PayTime() {
    String timeText = "";

    if (viewModel.seconds <= 0) {
      timeText = "支付超时，请重新提交订单";
    } else {
      int minutes = viewModel.seconds ~/ 60;
      int seconds = viewModel.seconds % 60;

      String minutesStr = minutes <= 0 ? "" : "$minutes分";
      String secondsStr = seconds <= 0 ? "" : "$seconds秒";

      timeText = "剩余支付时间：$minutesStr$secondsStr";
    }

    return Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      WidgetComponents.MeonyLabel(viewModel?.price ?? 0,
          color: Colors.white, scale: 2),
      Text(
        timeText,
        style: TextStyle(color: Colors.white),
      )
    ]);
  }

  ///支付方式
  Widget _$PayMode() {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(
        "选择支付方式",
        style: TextStyle(
            color: Colors.black, fontSize: 17, fontWeight: FontWeight.w500),
      ),
      RadioListTile(
          secondary: Image.asset(
            'assets/images/icon_wx_nor.png',
            width: 45,
            height: 45,
          ),
          title: Text(
            "微信",
            style: TextStyle(fontSize: 14),
          ),
          controlAffinity: ListTileControlAffinity.trailing,
          value: 2,
          groupValue: viewModel.payMode,
          onChanged: (mode) {
            viewModel.payMode = mode;
            _$RefreshUI();
          }),
      RadioListTile(
          secondary: Image.asset(
            'assets/images/icon_zfb_nor.png',
            width: 45,
            height: 45,
          ),
          title: Text("支付宝", style: TextStyle(fontSize: 14)),
          controlAffinity: ListTileControlAffinity.trailing,
          value: 1,
          groupValue: viewModel.payMode,
          onChanged: (mode) {
            viewModel.payMode = mode;
            _$RefreshUI();
          }),
      Container(
          margin: const EdgeInsets.symmetric(vertical: 20),
          child: WidgetComponents.CommonButton("确认支付",
              onPressed: onConfirmPayment,
              style: TextStyle(color: Colors.white)))
    ]);
  }

  void onConfirmPayment() {
    Debug.log("支付方式:${viewModel.payMode == 1 ? '支付宝' : '微信'}");
    NetworkManager.instance
        .payment(
            viewModel.payMode, viewModel.price?.toString(), viewModel.orderNo)
        .then((value) {
      Debug.log("支付结果:$value");

      bool isSuccess = true;

      if (isSuccess) {
        UIManager.instance
            .toPage(context, UIDef.paymentSuccess)
            .then((value) {});
      } else {
        UIManager.instance
            .toPage(context, UIDef.paymentFailure)
            .then((value) {});
      }
    });
  }

  void onTimerCallback(Timer timer) {
    // print("${viewModel.seconds}");
    if (viewModel.seconds-- <= 0)
      timer.cancel();
    else
      _$RefreshUI();
  }
}
