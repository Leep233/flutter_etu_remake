import 'package:flutter/material.dart';
import 'package:flutter_etu_remake/Global.dart';
import 'package:flutter_etu_remake/core/NetworkManager.dart';
import 'package:flutter_etu_remake/core/UIManager.dart';
import 'package:flutter_etu_remake/viewmodels/CommodityCardViewModel.dart';
import 'package:flutter_etu_remake/views/components/MapView.dart';
import 'package:flutter_etu_remake/views/components/HomeHotSaleView.dart';
import 'package:flutter_etu_remake/views/pages/CitySearchListView.dart';
import 'package:provider/provider.dart';

class HomeView extends StatefulWidget {
  final String title;

  HomeView({Key key, this.title = ''}) : super(key: key);

  @override
  State<StatefulWidget> createState() => HomeViewState();
}

class HomeViewState extends State<HomeView>
    with TickerProviderStateMixin
    implements
        DragDropDelegate,
        HomeHotSaleViewDelegate,
        CitySearchListViewDelegate {
  //最大偏移率
  final double kMaxOffsetRate = 0.5;
  final double kMixOfsetRate = 0.035;
  double offsetRate;

  Size screenSize;

  Animation<double> tween;
  AnimationController controller;

  List<CommodityCardViewModel> _commodites = [];

  bool _extend;

  @override
  void initState() {
    super.initState();

    offsetRate = kMaxOffsetRate;

    initAnimation();

    _loadData(Global.location);
  }

  void _loadData(String location) {
    NetworkManager.instance
        .hotSellCommodities(region:location )
        .then((value) {
      if (value == null) return;

      _commodites.clear();

      value?.forEach((element) {
        _commodites.add(CommodityCardViewModel.transform(element));
      });

      _$RefreshUI();
    });
  }

  void _$RefreshUI() {
    if (mounted) setState(() {});
  }

  void initAnimation() {
    /*创建动画控制类对象*/
    controller = AnimationController(
        duration: const Duration(milliseconds: 300), vsync: this);

    _extend = false;

    /*创建补间对象*/
    tween = Tween(begin: kMixOfsetRate, end: kMaxOffsetRate)
        .animate(controller) //返回Animation对象
          ..addListener(() {
            //添加监听
            setState(() {
              offsetRate = tween.value;
              _extend = !(offsetRate >= kMaxOffsetRate);

              print("$offsetRate || "); //打印补间插值
            });
          });
    //
    // controller.forward(from: kMaxOffsetRate);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void deactivate() {
    super.deactivate();
    controller?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    screenSize = MediaQuery.of(context).size;

    return _$BuildContent(context);
  }

  Widget _$BuildContent(BuildContext context) {
    return Stack(children: [
      Container(
          padding: EdgeInsets.only(bottom: screenSize.height * 0.41),
          child: MapView()),
      Container(
          padding: EdgeInsets.only(top: screenSize.height * (offsetRate)),
          child: HomeHotSaleView(
            location: Provider.of<LocationModel>(context).location,
            listener: this,
            commodities: _commodites,
            dragDropListener: this,
            extend: _extend,
          )),
    ]);
  }

  @override
  void onDropLeft() {
    // TODO: implement onDropLeft
  }

  @override
  void onDropRight() {
    // TODO: implement onDropRight
  }

  @override
  void onDropUp() {
    print('上拉');
    controller.reverse(from: kMaxOffsetRate);
    // TODO: implement onDropUp
  }

  @override
  void onDropdown() {
    // TODO: implement onDropdown
    print('下拉');
    controller.forward(from: kMaxOffsetRate);
  }

  @override
  void onClickLocation(String location) {
    Navigator.push<String>(context,
        new MaterialPageRoute(builder: (BuildContext context) {
      return CitySearchListView(listener: this);
    })).then((address) {
      if (address == null || address.isEmpty) return;

      Provider.of<LocationModel>(context, listen: false).location = address;

       _loadData(address);
    });
  }

  @override
  void onClickMessage() {
    // TODO: implement onClickMessage
  }

  @override
  void onClickSearch(String search) {
    // TODO: implement onClickSearch
  }

  @override
  void onClickMore() {
    UIManager.instance.toPage(context, UIDef.hotSale);
  }

  @override
  void onLocation() {
    // TODO: implement onLocation
  }

  @override
  void onSelectedCity(String city) {
    Navigator.pop<String>(context, city);
  }
}
