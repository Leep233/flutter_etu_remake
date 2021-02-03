import 'package:flutter/material.dart';
import 'package:flutter_etu_remake/Debug.dart';
import 'package:flutter_etu_remake/core/NetworkManager.dart';
import 'package:flutter_etu_remake/core/UIManager.dart';
import 'package:flutter_etu_remake/l10n/localization_intl.dart';
import 'package:flutter_etu_remake/viewmodels/PaymentPageViewModel.dart';
import 'package:flutter_etu_remake/viewmodels/PrepaymentOrderDetailPageViewModel.dart';
import 'package:flutter_etu_remake/viewmodels/StoreOrderCardViewModel.dart';
import 'package:flutter_etu_remake/views/components/RefreshListView.dart';
import 'package:flutter_etu_remake/views/components/StoreOrderCard.dart';

///我的订单
class MyOrdersPage extends StatefulWidget {
  MyOrdersPage({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => MyOrdersPageState();
}

class MyOrdersPageState extends State<MyOrdersPage>
    implements RefreshListViewDeleagate {
  final String emptyOrderImage = 'assets/images/pic_qsy_nor.png';

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  List<StoreOrderCardViewModel> orders;

  int _orderType;

  int _pageNum;

  bool noOrder = true;

  @override
  void initState() {
    super.initState();
    _orderType = 0;
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _orderType = ModalRoute.of(context).settings.arguments ?? 0;

      DefaultTabController.of(_scaffoldKey.currentContext).index = _orderType;

      onRefreshPull();
    });
  }

  _$RefreshUI() {
    if (mounted) setState(() {});
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void deactivate() {
    super.deactivate();
  }

  Size _screen;

  @override
  Widget build(BuildContext context) {
    _screen = MediaQuery.of(context).size;

    return DefaultTabController(
      initialIndex: _orderType,
      length: 6,
      child: Scaffold(
          key: _scaffoldKey,
          appBar: AppBar(
              elevation: 0.1,
              backgroundColor: Colors.white,
              centerTitle: true,
              toolbarHeight: 70,
              title: Text(
                '我的订单',
                style: TextStyle(color: Colors.black),
              ),
              leading: IconButton(
                  icon: Icon(Icons.chevron_left, color: Colors.black),
                  onPressed: () => Navigator.pop(context)),
              bottom: TabBar(
                onTap: _onTabChanged,
                isScrollable: true,
                indicatorSize: TabBarIndicatorSize.label,
                labelColor: Colors.grey,
                labelStyle: TextStyle(fontSize: 14),
                tabs: <Widget>[
                  Text(AppLocalizations.of(context).all),
                  Text(AppLocalizations.of(context).prepayment),
                  Text(AppLocalizations.of(context).predelivery),
                  Text(AppLocalizations.of(context).prereceiving),
                  Text(AppLocalizations.of(context).preevaluation),
                  Text(AppLocalizations.of(context).aftersales),
                ],
              )),
          body: _$BodyContentBuilder(context)),
    );
  }

  Widget _$BodyContentBuilder(BuildContext context) {
    return (orders == null || orders.length <= 0)
        ? _$EmptyOrders()
        : _orderType != 5
            ? RefreshListView(
                itemBuilder: _$StoreOrderItemBuilder,
                itemCount: orders.length,
                listener: this,
              )
            : Container(child: Text("退货/售后"));
  }

  Widget _$StoreOrderItemBuilder(BuildContext context, int index) {
    StoreOrderCardViewModel viewModel = orders[index];

    Widget item;

    switch (viewModel.orderStatus) {
      case 1:
        item = _$PrepaymentItem(viewModel);
        break;
      case 2:
        item = _$PredeliveryItem(viewModel);
        break;
      case 3:
        item = _$PrereceiveItem(viewModel);
        break;
      case 4:
        item = _$PrecommentItem(viewModel);
        break;
      case 5:
        item = _$TradingDoneItem(viewModel);
        break;
      case 6:
        item = _$TradingClosed(viewModel);
        break;
      default:
    }

    return Container(
        margin: const EdgeInsets.fromLTRB(5, 0, 5, 5), child: item);
  }

  Widget _$EmptyOrders() {
    return Container(
      margin: EdgeInsets.only(top: (_screen.height * 0.1)),
      width: double.infinity,
      child: Column(children: [Image.asset(emptyOrderImage), Text("无订单信息")]),
    );
  }

  void _onTabChanged(int value) {
    _orderType = value;
    _pageNum = 0;
    onRefreshPull();
    Debug.log(value);
  }

  ///待付款
  Widget _$PrepaymentItem(StoreOrderCardViewModel viewModel) {
    return StoreOrderCard(
        viewModel: viewModel,
        tailing: Container(
            margin: const EdgeInsets.fromLTRB(5, 5, 5, 0),
            alignment: Alignment.centerRight,
            child: FlatButton(
                textColor: Theme.of(context).accentColor,
                height: 30,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                    side: BorderSide(color: Theme.of(context).accentColor)),
                padding: const EdgeInsets.all(0),
                highlightColor: Colors.transparent,
                onPressed: () => _onClickPayment(viewModel.orderNo),
                child: Text("立即支付"))));
  }

  ///待发货
  Widget _$PredeliveryItem(StoreOrderCardViewModel viewModel) {
    return StoreOrderCard(
        viewModel: viewModel,
        tailing: Container(
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
                      onPressed: () {},
                      child: Text("申请售后"))),
              FlatButton(
                  textColor: Theme.of(context).accentColor,
                  height: 30,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                      side: BorderSide(color: Theme.of(context).accentColor)),
                  padding: const EdgeInsets.all(0),
                  highlightColor: Colors.transparent,
                  onPressed: () {},
                  child: Text("提醒发货")),
            ])));
  }

  ///待收货
  Widget _$PrereceiveItem(StoreOrderCardViewModel viewModel) {
    return StoreOrderCard(
        viewModel: viewModel,
        tailing: Container(
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
                      onPressed: () {},
                      child: Text("查看物流"))),
              FlatButton(
                  textColor: Theme.of(context).accentColor,
                  height: 30,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                      side: BorderSide(color: Theme.of(context).accentColor)),
                  padding: const EdgeInsets.all(0),
                  highlightColor: Colors.transparent,
                  onPressed: () {},
                  child: Text("确认收货")),
            ])));
  }

  ///待评论
  Widget _$PrecommentItem(StoreOrderCardViewModel viewModel) {
    return StoreOrderCard(
        viewModel: viewModel,
        tailing: Container(
            margin: const EdgeInsets.fromLTRB(5, 5, 5, 0),
            alignment: Alignment.centerRight,
            child: FlatButton(
                textColor: Theme.of(context).accentColor,
                height: 30,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                    side: BorderSide(color: Theme.of(context).accentColor)),
                padding: const EdgeInsets.all(0),
                highlightColor: Colors.transparent,
                onPressed: () {},
                child: Text("马上评论"))));
  }

  ///交易完成
  Widget _$TradingDoneItem(StoreOrderCardViewModel viewModel) {
    return StoreOrderCard(viewModel: viewModel);
  }

  ///交易关闭
  Widget _$TradingClosed(StoreOrderCardViewModel viewModel) {
    return StoreOrderCard(viewModel: viewModel);
  }

  @override
  Future onRefreshDropdown() {
    return NetworkManager.instance
        .myOrders(pageNum: ++_pageNum, type: _orderType)
        .then((value) {
      if (value == null || value.total <= 0) return;

      orders.addAll(value.result
          ?.map((e) => StoreOrderCardViewModel.transform(e))
          ?.toList());

      _$RefreshUI();
    });
  }

  @override
  Future onRefreshPull() {
    if (_pageNum == 1) return null;

    _pageNum = 1;

    return NetworkManager.instance
        .myOrders(pageNum: _pageNum, type: _orderType)
        .then((value) {
      orders = value.result
          ?.map((e) => StoreOrderCardViewModel.transform(e))
          ?.toList();

      _$RefreshUI();
    });
  }

  void _onClickPayment(String orderNo) {
    Debug.log("立即支付 订单号:${orderNo}");  

    NetworkManager.instance.orderDetail(orderNo).then((value){
      if(value!=null)UIManager.instance.toPage(context, UIDef.prepaymentOrderDetail,arguments:PrepaymentOrderDetailPageViewModel.transform(value));
    });

   
  }
}
