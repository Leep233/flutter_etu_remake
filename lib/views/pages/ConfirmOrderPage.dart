import 'package:flutter/material.dart';
import 'package:flutter_etu_remake/AppDefaultStyle.dart';
import 'package:flutter_etu_remake/Debug.dart';
import 'package:flutter_etu_remake/WidgetComponents.dart';
import 'package:flutter_etu_remake/core/NetworkManager.dart';
import 'package:flutter_etu_remake/core/UIManager.dart';
import 'package:flutter_etu_remake/l10n/localization_intl.dart';
import 'package:flutter_etu_remake/models/ShoppingOrder.dart';
import 'package:flutter_etu_remake/viewmodels/ComfirmOrderPageViewModel.dart';
import 'package:flutter_etu_remake/viewmodels/DeliveryAddressItemViewModel.dart';
import 'package:flutter_etu_remake/viewmodels/PaymentPageViewModel.dart';
import 'package:flutter_etu_remake/viewmodels/PurchaseCommodityItemViewModel.dart';
import 'package:flutter_etu_remake/views/components/DeliveryAddressItem.dart';
import 'package:flutter_etu_remake/views/components/PurchaseCommodityItem.dart';
import 'package:flutter_etu_remake/views/pages/DeliveryAddressListPage.dart';

class ComfirmOrderPage extends StatefulWidget {
  ComfirmOrderPage({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => ComfirmOrderPageState();
}

class ComfirmOrderPageState extends State<ComfirmOrderPage> implements DeliveryAddressListPageDelegate {
  ComfirmOrderPageViewModel _viewModel;

  final TextEditingController remarksComtroller = TextEditingController();

  void _$RefreshUI() {
    if (mounted) setState(() {});
  }

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      ShoppingOrder order =
          ModalRoute.of(context).settings.arguments as ShoppingOrder;

      _viewModel = ComfirmOrderPageViewModel.transform(order);

      _$RefreshUI();
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
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          elevation: 0.1,
          centerTitle: true,
          backgroundColor: Colors.white,
          title: Text(
            AppLocalizations.of(context).confirmOrder,
            style: TextStyle(color: Colors.black),
          ),
          leading: IconButton(
            icon: Icon(Icons.chevron_left, color: Colors.black),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: $BodyContentBuidler(context));
  }

  Widget $BodyContentBuidler(BuildContext context) {
    Widget addressLabel = _viewModel?.deliveryAddress == null
        ? Container(
            height: 70,
            child: Card(
              child: FlatButton(
                onPressed: _onClickChangedDeliveryAddress,
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.add_box,
                        color: Colors.deepOrangeAccent,
                        size: 30,
                      ),
                      Text(
                        AppLocalizations.of(context).addAddress,
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 16),
                      )
                    ]),
              ),
            ))
        : DeliveryAddressItem(showLeading: true,            
            data: _viewModel?.deliveryAddress,
            onPressed: _onClickChangedDeliveryAddress,
          );

    List<Widget> commodityItems = [];

    _viewModel?.commoditiesMap?.forEach((key, value) {
      commodityItems.add(
        Container(
            child: ConfirmOrderCommodityItem(remarksComtroller: remarksComtroller,
          storeName: key,
          commodities: value,
        )),
      );
    });

  double number = double.tryParse(_viewModel?.fareAmount??"0") ;

  String fareAmount = (number==null|| number<0)?"免运费":number.toStringAsFixed(2);

    Widget orderInfo = Column(children: [
      Container(
          margin: const EdgeInsets.all(5),
          width: double.infinity,
          child: $TitleLabel(AppLocalizations.of(context).commodityTotalAmount, "￥${_viewModel?.orderAmount??"0"}")),
      Container(
          margin: const EdgeInsets.all(5),
          width: double.infinity,
          child: $TitleLabel(AppLocalizations.of(context).weight, '${_viewModel?.weight??"0"}kg')),
      Container(
          margin: const EdgeInsets.all(5),
          width: double.infinity,
          child: $TitleLabel(AppLocalizations.of(context).freight,"￥$fareAmount")),
           Container(
          margin: const EdgeInsets.all(5),
          width: double.infinity,
          child: $TitleLabel(AppLocalizations.of(context).totalAomunt,"￥${_viewModel?.totalAmount??"0"}")),
    ]);

    return Stack(children: [
      Container(
        margin: const EdgeInsets.symmetric(horizontal: 10),
        child: ListView(children: [
          Container(alignment: Alignment.center, child: addressLabel),
          Card(
            child: Column(
              children: [
                Container(
                    margin: const EdgeInsets.all(10),
                    child: Column(
                      children: commodityItems,
                    )),
                WidgetComponents.Line(),
                Container(
                  margin:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  child: orderInfo,
                ),
              ],
            ),
          ),
          SizedBox(
            height: 60,
          )
        ]),
      ),
      Positioned(bottom: 0, left: 0, right: 0, child: Container(child: _$PaymentLabel(),height: 50,) )
    ]);
  }

  Widget _$PaymentLabel() {
    return Container(
        padding: const EdgeInsets.only(left: 50, right: 10),
        color: Colors.white,
        height: 35,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
           Container(
                  child: Text(
                    AppLocalizations.of(context)
                        .quantity(_viewModel?.commodityAmount??0),
                    style: TextStyle(color: Colors.grey, fontSize: 14),
                  ),
                ),
            Container(
                child: Row(
              children: [
                Container(
                  child: Text(
                    AppLocalizations.of(context).total,
                    style: TextStyle(fontSize: 14),
                  ),
                ),
                Container(
                    margin: EdgeInsets.all(3),
                    child: WidgetComponents.MeonyLabel(
                        double.parse(_viewModel?.totalAmount ?? '0'))),
                Container(
                    margin: EdgeInsets.all(3),
                    child: FlatButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30)),
                        color: Colors.red,
                        onPressed: _onClickPaymentBtn,
                        child: Text(
                          AppLocalizations.of(context).payment,
                          style: TextStyle(color: Colors.white),
                        ))),
              ],
            )),
          ],
        ));
  }

  Widget $TitleLabel(String title, String label) {
    return Row(children: [
      Expanded(
          flex: 1,
          child: Text(
            title,
            textAlign: TextAlign.end,
            style: TextStyle(color: Colors.black, fontSize: 16),
          )),
      Expanded(
          flex: 2,
          child: Text(
            label,
            textAlign: TextAlign.end,
            style: TextStyle(color: Colors.grey, fontSize: 16),
          )),
    ]);
  }

  void _onClickChangedDeliveryAddress() {
    Navigator.push<DeliveryAddressItemViewModel>(context,
        new MaterialPageRoute(builder: (BuildContext context) {
      return DeliveryAddressListPage(listener: this,);
    })).then((data) {     
        _viewModel?.deliveryAddress = data;  
        _$RefreshUI();    
    });
  }

  void _onClickPaymentBtn() {
      Debug.log("立即支付 订单号:${_viewModel.orderNo}");
    
  String remarks = remarksComtroller?.value?.text;

      NetworkManager.instance.paymentDetail(_viewModel.orderNo, remarks:remarks).then((value)
       {
         if(value == null)return;

         UIManager.instance.toPage(context, UIDef.payment,arguments: PaymentPageViewModel.transform(value));
      });
  }

  @override
  onClickDeliveryAddressItem(DeliveryAddressItemViewModel data) {
    Navigator.pop(context,data);
  }
}

class ConfirmOrderCommodityItem extends StatelessWidget {
  final String storeName;

  final List<PurchaseCommodityItemViewModel> commodities;

  final TextEditingController remarksComtroller;

  ConfirmOrderCommodityItem({this.storeName, this.commodities,this.remarksComtroller});

  @override
  Widget build(BuildContext context) {
    List<Widget> commodityItems = [];

    commodities?.forEach((element) {
      commodityItems.add(Container(
          margin: const EdgeInsets.all(5),
          child: PurchaseCommodityItem(
            viewModel: element,
          )));
    });

    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Container(
          margin: const EdgeInsets.fromLTRB(0, 10, 0, 5),
          child: Text(
            storeName ?? "",
            style: AppDefaultStyle.titleStyle01,
          )),
      Container(
        child: Column(children: commodityItems),
      ),
      Container(
        margin: const EdgeInsets.all(10),
        child: Row(children: [
          Text("订单备注:", style: TextStyle(fontSize: 16)),
          Expanded(
              child: TextField(controller: remarksComtroller,
            decoration: InputDecoration.collapsed(
                hintText: "选填", hintStyle: TextStyle(fontSize: 16)),
          ))
        ]),
      )
    ]);
  }
}
