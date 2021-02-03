import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_etu_remake/AppDefaultStyle.dart';
import 'package:flutter_etu_remake/core/NetworkManager.dart';
import 'package:flutter_etu_remake/core/UIManager.dart';
import 'package:flutter_etu_remake/viewmodels/CommodityCardViewModel.dart';
import 'package:flutter_etu_remake/views/components/CommodityCard.dart';
import 'package:flutter_etu_remake/views/components/RefreshListView.dart';

class PaymentSuccessPage extends StatefulWidget {
  PaymentSuccessPage({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => PaymentSuccessPageState();
}

class PaymentSuccessPageState extends State<PaymentSuccessPage>
    implements CommodityCardDelegate {
  List<CommodityCardViewModel> _commodites = [];

  void _$RefreshUI() {
    if (mounted) setState(() {});
  }

  @override
  void initState() {
    super.initState();
    NetworkManager.instance
        .hotSellCommodities(
      pageNum: 1,
    )
        .then((value) {
      if (value != null) {
        _commodites.clear();

        value?.forEach((element) {
          _commodites.add(CommodityCardViewModel.transform(element));
        });
        _$RefreshUI();
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void deactivate() {
    super.deactivate();
  }

  @override
  Widget build(BuildContext context) {
    Size screen = MediaQuery.of(context).size;

    return Scaffold(
      extendBodyBehindAppBar: true,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          leading: IconButton(
              icon: Icon(
                Icons.chevron_left,
                size: 32,
              ),
              onPressed: () => Navigator.pop(context))),
      body: Container(
          padding: const EdgeInsets.only(top: 70),
          width: screen.width,
          height: screen.height,
          decoration: AppDefaultStyle.BGConstraint(),
          child: _$BuildContent(context)),
    );
  }

  Widget _$BuildContent(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
        Container(
          margin: const EdgeInsets.all(10),
          decoration:
              BoxDecoration(shape: BoxShape.circle, color: Colors.white),
          width: 45,
          height: 45,
          child: Icon(
            Icons.check,
            size: 40,
            color: Colors.deepOrange,
          ),
        ),
        Container(
          child: Text(
            "支付成功！感谢您的购买！",
            style: TextStyle(
                color: Colors.white, fontSize: 18, fontWeight: FontWeight.w500),
          ),
        ),
        Container(
            margin: const EdgeInsets.all(10),
            child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Container(
                  margin: const EdgeInsets.all(10),
                  child: FlatButton(
                      textColor: Colors.white,
                      height: 30,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                          side: BorderSide(color: Colors.white)),
                      padding: const EdgeInsets.all(0),
                      highlightColor: Colors.transparent,
                      onPressed: () =>
                          UIManager.instance.toPage(context, UIDef.home),
                      child: Text("返回首页"))),
              Container(
                margin: const EdgeInsets.all(10),
                child: FlatButton(
                    textColor: Colors.white,
                    height: 30,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                        side: BorderSide(color: Colors.white)),
                    padding: const EdgeInsets.all(0),
                    highlightColor: Colors.transparent,
                    onPressed: _onClickViewOrder,
                    child: Text("查看订单")),
              )
            ])),
        Expanded(
            child: Container(margin:const EdgeInsets.symmetric(horizontal:10),
                child: MediaQuery.removePadding(
                  removeTop: true,
                  context: context,
                  child: RefreshListView(
                    itemBuilder: (context, index) => CommodityCard(shape:RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      sourceData: _commodites[index],
                      listener: this,
                    ),
                    itemCount: _commodites.length,
                  ),
                )))
      ]),
    );
  }

  void _onClickViewOrder() {}

  @override
  void onPressedCommodity(String commodityId) {
    UIManager.instance
        .toPage(context, UIDef.commodityDetail, arguments: commodityId);
  }

  @override
  void onPressedStore(String storeId) {
    UIManager.instance.toPage(context, UIDef.storeDetial, arguments: storeId);
  }
}
