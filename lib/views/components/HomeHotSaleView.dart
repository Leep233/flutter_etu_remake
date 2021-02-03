//首页热卖推荐视图
import 'package:flutter/material.dart';
import 'package:flutter_etu_remake/AppDefaultStyle.dart';
import 'package:flutter_etu_remake/WidgetComponents.dart';
import 'package:flutter_etu_remake/core/UIManager.dart';
import 'package:flutter_etu_remake/l10n/localization_intl.dart';
import 'package:flutter_etu_remake/viewmodels/CommodityCardViewModel.dart';
import 'package:flutter_etu_remake/views/components/CommodityCard.dart';
import 'package:flutter_etu_remake/views/components/RefreshListView.dart';

class HomeHotSaleView extends StatefulWidget {
  final bool extend;

  final String location;

  final List<CommodityCardViewModel> commodities;

  final HomeHotSaleViewDelegate listener;

  final DragDropDelegate dragDropListener;

  HomeHotSaleView(
      {Key key,
      this.listener,
      this.commodities,
      this.location = '深圳市',
      this.dragDropListener,
      this.extend = false})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => HomeHotSaleViewState();
}

class HomeHotSaleViewState extends State<HomeHotSaleView> implements CommodityCardDelegate {
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
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
    return Container(           
        decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.vertical(top:Radius.circular(13)),
                  image: DecorationImage(
                      alignment: Alignment.topCenter,
                      fit: BoxFit.fitWidth,
                      image: AssetImage('assets/images/bg.png'))),
        child: Column(children: [
          _$DragDropBar(),
          Container(
            child: _$SearchBar(),
          ),
          Container(child: _$TitleBar()),
          Expanded(
              child: MediaQuery.removePadding(
            removeTop: true,
            context: context,
            child: RefreshListView(
              itemBuilder: (context,index)=> CommodityCard(sourceData:  widget.commodities[index],listener: this,),
              itemCount:  widget.commodities.length,
            ),
          ))
        ]));
  }

  ///标题栏
  Widget _$TitleBar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        TextButton(
            onPressed: null,
            child: Text(
              AppLocalizations.of(context).hotSale,
              style: TextStyle(color: Colors.white, fontSize: AppDefaultStyle.TitleFontSize),
            )),
        TextButton(
            onPressed: _onClickMore,
            child: Row(children: [
              Text(
                AppLocalizations.of(context).viewMore,
                style: TextStyle(color: Colors.white, fontSize: 12),
              ),
              Icon(Icons.chevron_right, color: Colors.white)
            ])),
      ],
    );
  }

  ///搜索栏
  Widget _$SearchBar() {
    return Row(
      children: [
        FlatButton(
            padding: EdgeInsets.all(0),
            onPressed: _onClickLocationBtn,
            child: Row(children: [
              Text(widget.location,
                  style: TextStyle(
                    color: Colors.white,
                  )),
              Icon(
                Icons.arrow_drop_down,
                color: Colors.white,
              ),
            ])),
        Expanded(
            child: WidgetComponents.SearchFeild(onPressedSearch: _onClickSearch,
                hintText: AppLocalizations.of(context).searchContent)),
        FlatButton(
            minWidth: 50,
            child: Image.asset('assets/images/icon_ss_nor_nav.png'),
            onPressed: _onClickMessage)
      ],
    );
  }

  ///拖拽栏
  Widget _$DragDropBar() {
    return GestureDetector(
        onVerticalDragEnd: (details) {
          if (widget.dragDropListener == null) return;

          double y = details.velocity.pixelsPerSecond.dy;

          if (y > 100) {
            widget.dragDropListener.onDropdown();
          } else if (y < -100) {
            widget.dragDropListener.onDropUp();
          }
        },
        child: Container(
          width: double.infinity,
          child: Icon(
              widget.extend ? Icons.keyboard_arrow_down : Icons.horizontal_rule,color: Colors.white,),
        ));
  }

  
  

  void _onClickLocationBtn() {
    print("${widget.location}");

    if (widget.listener == null) return WidgetComponents.DefaultToast('功能未实现');

    widget.listener?.onClickLocation(widget.location);
  }

  void _onClickMessage() {
    if (widget.listener == null) return WidgetComponents.DefaultToast('功能未实现');

    widget.listener?.onClickMessage();
  }

  void _onClickSearch() {
    if (widget.listener == null) return WidgetComponents.DefaultToast('功能未实现');

    widget.listener?.onClickSearch(_searchController?.text);
  }

  void _onClickMore() {
    if (widget.listener == null) return WidgetComponents.DefaultToast('功能未实现');

    widget.listener?.onClickMore();
  }

  @override
  void onPressedCommodity(String commodityId) {
        UIManager.instance.toPage(context, UIDef.commodityDetail,arguments:commodityId);
    }
  
    @override
    void onPressedStore(String storeId) {
     UIManager.instance.toPage(context, UIDef.storeDetial,arguments:storeId);
  }
}

abstract class HomeHotSaleViewDelegate {
  void onClickSearch(String search);
  void onClickMessage();
  void onClickMore();
  void onClickLocation(String location);
}

abstract class DragDropDelegate {
  void onDropdown();
  void onDropUp();
  void onDropLeft();
  void onDropRight();
}