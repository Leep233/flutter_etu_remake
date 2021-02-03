import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_etu_remake/AppDefaultStyle.dart';
import 'package:flutter_etu_remake/Debug.dart';
import 'package:flutter_etu_remake/WidgetComponents.dart';
import 'package:flutter_etu_remake/views/components/SelectorWidget.dart';

///提现
class WithdrawalPage extends StatefulWidget {
  final String title;

  WithdrawalPage({Key key, this.title = ''}) : super(key: key);

  @override
  State<StatefulWidget> createState() => WithdrawalPageState();
}

class WithdrawalPageState extends State<WithdrawalPage> {
  double get iconSize => 24;

  final BoxDecoration selectedDecoration = BoxDecoration(
      image: DecorationImage(
          fit: BoxFit.fill, image: AssetImage("assets/images/k_hover.png")));

  final BoxDecoration unselectedDecoration = BoxDecoration(
      borderRadius: BorderRadius.circular(3),
      border: Border.all(color: Colors.grey[100]));

  TextEditingController _controller = TextEditingController();

  final TapGestureRecognizer pressGestureRecognizer = TapGestureRecognizer();

  ///提现方式 1 支付宝 ； 2：微信
  int withdrawlMode = 2;

  String amount;

  double totalAmount = 99999;

  @override
  void initState() {
    super.initState();
    amount = "0.00";
    pressGestureRecognizer.onTap = _onPressedAllWithdrawl;
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void deactivate() {
    pressGestureRecognizer?.dispose();
    super.deactivate();
  }

  @override
  Widget build(BuildContext context) {
    Size screen = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: AppDefaultStyle.bgColor,
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          centerTitle: true,
          toolbarHeight: AppDefaultStyle.appBarHeight,
          automaticallyImplyLeading: false,
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          leading: IconButton(
            icon: Icon(
              Icons.chevron_left,
              color: Colors.black,
            ),
            onPressed: () => Navigator.pop(context),
          ),
          title: Text(
            "提现",
            style: AppDefaultStyle.appTitleStyle,
          ),
        ),
        body: Container(
          width: screen.width,
          height: screen.height,
          child: _$BuildBody(context),
        ));
  }

  Widget _$BuildBody(BuildContext context) {
    return Container(
      child: Column(children: [
        _$WithdrawlModeSeletor(),
        _$WithdrawlAmountItem(),
        Container(
            margin: const EdgeInsets.all(15),
            child: WidgetComponents.CommonButton('提现',
                style: TextStyle(color: Colors.white),
                onPressed: _onClickWithdrawl))
      ]),
    );
  }

  Widget _$WithdrawlModeSeletor() {
    return Container(
        padding: const EdgeInsets.all(15),
        margin: const EdgeInsets.fromLTRB(15, 0, 15, 15),
        decoration: BoxDecoration(
            border: Border.all(color: Colors.grey[200]),
            color: Colors.white,
            borderRadius: BorderRadius.circular(10)),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text("提现方式"),
          Container(
              child: Row(children: [
            Expanded(
                child: Container(
              margin: const EdgeInsets.fromLTRB(0, 10, 10, 0),
              child: _$WeChatSelector(),
            )),
            Expanded(
                child: Container(
              margin: const EdgeInsets.fromLTRB(10, 10, 0, 0),
              child: _$AliSelector(),
            )),
          ]))
        ]));
  }

  Widget _$WithdrawlAmountItem() {
    _controller = TextEditingController(text: amount ?? "");

    return Container(
        width: double.infinity,
        padding: const EdgeInsets.all(15),
        margin: const EdgeInsets.fromLTRB(15, 0, 15, 15),
        decoration: BoxDecoration(
            border: Border.all(color: Colors.grey[200]),
            color: Colors.white,
            borderRadius: BorderRadius.circular(10)),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text("提现金额"),
          TextFormField(
            onChanged: (value) => amount = value,
            keyboardType: TextInputType.number,
            controller: _controller,
            style: TextStyle(fontSize: 24),
            decoration: InputDecoration(
                prefix: Text(
              '￥',
              style: TextStyle(
                  fontSize: 24,
                  color: Colors.black,
                  fontWeight: FontWeight.bold),
            )),
          ),
          Container(
              margin: const EdgeInsets.only(top: 8),
              child: RichText(
                  text: TextSpan(
                      text: "可提现金额 ${totalAmount.toStringAsFixed(2)}元   ",
                      style: TextStyle(fontSize: 13, color: Colors.grey),
                      children: [
                    TextSpan(
                        text: "全部提现",
                        style: TextStyle(fontSize: 13, color: Colors.red),
                        recognizer: pressGestureRecognizer)
                  ]))),
        ]));
  }

  Widget _$WeChatSelector() {
    return SelectorWidget<int>(
        value: 2,
        groupValue: withdrawlMode,
        selected: Container(
          width: 150,
          height: 45,
          decoration: selectedDecoration,
          child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            Image.asset(
              'assets/images/icon_wx_nor.png',
              height: iconSize,
              width: iconSize,
            ),
            Text("微信")
          ]),
        ),
        unselected: Container(
          width: 150,
          height: 45,
          decoration: unselectedDecoration,
          child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            Image.asset('assets/images/icon_wx_nor.png',
                height: iconSize, width: iconSize),
            Text("微信")
          ]),
        ),
        onChanged: _selectedChanged);
  }

  Widget _$AliSelector() {
    return SelectorWidget<int>(
      value: 1,
      groupValue: withdrawlMode,
      selected: Container(
          width: 150,
          height: 45,
          decoration: selectedDecoration,
          child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            Image.asset('assets/images/icon_zfb_nor.png',
                height: iconSize, width: iconSize),
            Text("支付宝")
          ])),
      unselected: Container(
        width: 150,
        height: 45,
        decoration: unselectedDecoration,
        child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          Image.asset('assets/images/icon_zfb_nor.png',
              height: iconSize, width: iconSize),
          Text("支付宝")
        ]),
      ),
      onChanged: _selectedChanged,
    );
  }

  void _selectedChanged(dynamic value) {
    if (mounted)
      setState(() {
        withdrawlMode = value;
      });
  }

  void _onPressedAllWithdrawl() {
    if (mounted)
      setState(() {
        amount = totalAmount.toString();
      });
  }

  void _onClickWithdrawl() {
    Debug.log("[${withdrawlMode==1?"支付宝":"微信"}] 提现:$amount");
  }
}
