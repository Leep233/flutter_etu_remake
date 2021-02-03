import 'package:flutter/material.dart';
import 'package:flutter_etu_remake/AppDefaultStyle.dart';
import 'package:flutter_etu_remake/WidgetComponents.dart';
import 'package:flutter_etu_remake/core/NetworkManager.dart';
import 'package:flutter_etu_remake/core/UIManager.dart';
import 'package:flutter_etu_remake/l10n/localization_intl.dart';
import 'package:flutter_etu_remake/viewmodels/PaymentPageViewModel.dart';
import 'package:flutter_etu_remake/viewmodels/PrepaymentOrderDetailPageViewModel.dart';
import 'package:flutter_etu_remake/views/components/DeliveryAddressItem.dart';
import 'package:flutter_etu_remake/views/components/OrderDetailCommodityCard.dart';

abstract class OrderDetailPage extends StatelessWidget {
  final String image;

  OrderDetailPage({this.image});

  Widget buildBody(BuildContext context);

  @override
  Widget build(BuildContext context) {
    Size screen = MediaQuery.of(context).size;
    return Scaffold(
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
          "订单详情",
          style: AppDefaultStyle.appTitleStyle,
        ),
      ),
      body: Container(
          width: screen.width,
          height: screen.height,
          decoration: BoxDecoration(
              image: DecorationImage(
                  alignment: Alignment.topCenter,
                  fit: BoxFit.fitWidth,
                  image: AssetImage(image))),
          child: buildBody(context)),
    );
  }
}

// ignore: must_be_immutable
class PrepaymentOrderDetailPage extends OrderDetailPage {
  PrepaymentOrderDetailPageViewModel _viewModel;

  PrepaymentOrderDetailPage(): super(image: 'assets/images/bg_01.png');

  @override
  Widget buildBody(BuildContext context) {
    _viewModel = ModalRoute.of(context).settings.arguments;

    return Container(
      margin: const EdgeInsets.fromLTRB(15, 13, 15, 0),
      child: ListView(children: [
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 10),
          child: _$StatusItem(),
        ),
        Container(
          margin: const EdgeInsets.symmetric(vertical: 10),
          child: DeliveryAddressItem(
            data: _viewModel?.address,
            showLeading: true,
            leadingSize: 32,
            borderRadius: BorderRadius.circular(10),
            padding: EdgeInsets.symmetric(vertical: 5),
          ),
        ),
        Container(
          child: _$OrderContent(context),
        )
      ]),
    );
  }

  Widget _$OrderContent(BuildContext context) {
    List<Widget> orderCards = _viewModel?.commodities
        ?.map((e) => OrderDetailCommodityCard(data: e))
        ?.toList();

    Widget orderInfo = Column(children: [
      Container(
          margin: const EdgeInsets.all(5),
          width: double.infinity,
          child: $TitleLabel(AppLocalizations.of(context).commodityTotalAmount,
              "￥${_viewModel?.orderAmount ?? "0"}")),
      Container(
          margin: const EdgeInsets.all(5),
          width: double.infinity,
          child: $TitleLabel(AppLocalizations.of(context).weight,
              '${_viewModel?.orderWeight ?? "0"}kg')),
      Container(
          margin: const EdgeInsets.all(5),
          width: double.infinity,
          child: $TitleLabel(AppLocalizations.of(context).freight,
              "${_viewModel?.orderFare}")),
      Container(
          margin: const EdgeInsets.all(5),
          width: double.infinity,
          child: $TitleLabel(AppLocalizations.of(context).totalAomunt,
              "￥${_viewModel?.totalAmount ?? "0"}")),
      Container(
        child: WidgetComponents.Line(),
        margin: const EdgeInsets.symmetric(vertical: 10),
      ),
      Container(
          margin: const EdgeInsets.all(5),
          width: double.infinity,
          child: $TitleLabel(AppLocalizations.of(context).remakes,
              "${_viewModel?.remarks ?? ""}")),
      Container(
          margin: const EdgeInsets.all(5),
          width: double.infinity,
          child: $TitleLabel(AppLocalizations.of(context).orderTime,
              "${_viewModel?.orderTime ?? ""}")),
      Container(
          margin: const EdgeInsets.fromLTRB(5, 5, 5, 0),
          alignment: Alignment.centerRight,
          child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
            Container(
                margin: const EdgeInsets.only(right: 10),
                child: FlatButton(
                    textColor: Colors.grey,
                    height: 30,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                        side: BorderSide(color: Colors.grey)),
                    padding: const EdgeInsets.all(0),
                    highlightColor: Colors.transparent,
                    onPressed: _onCancelOrder,
                    child: Text("取消订单"))),
            FlatButton(
                textColor: Theme.of(context).accentColor,
                height: 30,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                    side: BorderSide(color: Theme.of(context).accentColor)),
                padding: const EdgeInsets.all(0),
                highlightColor: Colors.transparent,
                onPressed: ()=>_onPayment( context),
                child: Text("马上支付")),
          ]))
    ]);

    return Card(
        child: Container(
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      child: Column(children: [
        Column(children: orderCards),
        Container(
          child: WidgetComponents.Line(),
          margin: const EdgeInsets.symmetric(vertical: 10),
        ),
        Container(child: orderInfo)
      ]),
    ));
  }

  Widget _$StatusItem() {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(
        "待付款",
        style: TextStyle(color: Colors.white, fontSize: 16),
      ),
      Text("30分12秒后订单自动关闭", style: TextStyle(color: Colors.white, fontSize: 14))
    ]);
  }

  Widget $TitleLabel(String title, String label) {
    return Row(children: [
      Expanded(
          flex: 1,
          child: Text(
            title,
            textAlign: TextAlign.end,
            style: TextStyle(color: Colors.black, fontSize: 14),
          )),
      Expanded(
          flex: 2,
          child: Text(
            label,
            textAlign: TextAlign.start,
            style: TextStyle(color: Colors.grey, fontSize: 14),
          )),
    ]);
  }

  void _onCancelOrder() {
  
  }

  void _onPayment(BuildContext context) {

    

       NetworkManager.instance.paymentDetail(_viewModel.orderNo, remarks:_viewModel.remarks).then((value)
       {
         if(value == null)return;

         UIManager.instance.toPage(context, UIDef.payment,arguments: PaymentPageViewModel.transform(value));
      });
  }
}


