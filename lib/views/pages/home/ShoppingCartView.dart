import 'package:flutter/material.dart';
import 'package:flutter_etu_remake/AppDefaultStyle.dart';
import 'package:flutter_etu_remake/Debug.dart';
import 'package:flutter_etu_remake/WidgetComponents.dart';
import 'package:flutter_etu_remake/core/NetworkManager.dart';
import 'package:flutter_etu_remake/core/UIManager.dart';
import 'package:flutter_etu_remake/l10n/localization_intl.dart';
import 'package:flutter_etu_remake/viewmodels/ShoppingCartCardViewModel.dart';
import 'package:flutter_etu_remake/viewmodels/ShoppingCartViewModel.dart';
import 'package:flutter_etu_remake/views/components/ShoppingCartCard.dart';

// ignore: must_be_immutable
class ShoppingCartView extends StatefulWidget {
  ShoppingCartView({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => ShoppingCartViewState();
}

class ShoppingCartViewState extends State<ShoppingCartView>
    implements ShoppingCartCardDelegate {
  ShoppingCartViewModel _viewModel;

  ///已选择的商品id
  String get selectedIds {
    String ids = '';

    _viewModel?.commodities?.forEach((element) {
      element.items?.forEach((e) {
        if (_viewModel.isEdit) {
          if (e.selected) ids += "${e.id},";
        } else {
          if (e.selected && e.understock) ids += "${e.id},";
        }
      });
    });

    ids = ids.length > 1 ? ids.substring(0, ids.length - 1) : "";

    return ids;
  }

  @override
  void initState() {
    super.initState();

    _updateData();
  }

  void _updateData() {
    NetworkManager.instance.shoppingCartDetail().then((value) {
      _viewModel = ShoppingCartViewModel.transform(value);
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
    AppLocalizations appLocal = AppLocalizations.of(context);
    return Scaffold(
        appBar: AppBar(
          toolbarHeight: AppDefaultStyle.appBarHeight,
          automaticallyImplyLeading: false,
          centerTitle: true,
          backgroundColor: Colors.white,
          elevation: 0.1,
          title: Text(
            AppLocalizations.of(context).shoppingCart,
            style: TextStyle(color: Colors.black87, fontSize: AppDefaultStyle.AppTitleFontSize),
          ),
          actions: [
            TextButton(
                onPressed: () {
                  _viewModel.isEdit = !_viewModel.isEdit;
                  _$RefreshUI();
                },
                child: Text(_viewModel?.isEdit == true
                    ? appLocal.finshed
                    : appLocal.edit))
          ],
        ),
        body: Column(
          children: [
            Expanded(
                child: Container(
              child: ListView.builder(
                itemBuilder: (context, index) => ShoppingCartCard(
                    isEidt: _viewModel?.isEdit == true,
                    data: _viewModel?.commodities[index],
                    listener: this),
                itemCount: _viewModel?.commodities?.length ?? 0,
              ),
            )),
            if ((_viewModel?.commodities?.length ?? 0) > 0)
              Container(
                child: _viewModel?.isEdit == true
                    ? _$EditLabel()
                    : _$SettlementLabel(),
              )
          ],
        ));
  }

  ///编辑label
  Widget _$EditLabel() {
    return Container(
        padding: const EdgeInsets.only(left: 10, right: 10),
        color: Colors.white,
        height: 35,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
                child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                    width: 20,
                    height: 20,
                    child: Checkbox(
                      value: _viewModel?.selected,
                      onChanged: _clickAllSelectedCallback,
                    )),
                Container(
                  child: Text(
                    AppLocalizations.of(context).allSelect,
                    style: TextStyle(color: Colors.grey, fontSize: 12),
                  ),
                ),
              ],
            )),
            Container(
                child: Row(
              children: [
                Container(
                    margin: EdgeInsets.all(3),
                    child: FlatButton(
                        shape: RoundedRectangleBorder(
                            side: BorderSide(color: Colors.red),
                            borderRadius: BorderRadius.circular(30)),
                        color: Colors.white,
                        onPressed: _onClickDeleteBtn,
                        child: Text(
                          AppLocalizations.of(context).delete,
                          style: TextStyle(color: Colors.red),
                        ))),
              ],
            )),
          ],
        ));
  }

  //提交购物车订单Label
  Widget _$SettlementLabel() {
    return Container(
        padding: const EdgeInsets.only(left: 10, right: 10),
        color: Colors.white,
        height: 35,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
                child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                    width: 20,
                    height: 20,
                    child: Checkbox(
                      value: _viewModel.selected,
                      onChanged: _clickAllSelectedCallback,
                    )),
                Container(
                  child: Text(
                    "全选",
                    style: TextStyle(color: Colors.grey, fontSize: 12),
                  ),
                ),
              ],
            )),
            Container(
                child: Row(
              children: [
                Container(
                  child: Text(
                    "合计：",
                    style: TextStyle(fontSize: 12),
                  ),
                ),
                Container(
                    margin: EdgeInsets.all(3),
                    child: WidgetComponents.MeonyLabel(_viewModel.amount ?? 0)),
                Container(
                    margin: EdgeInsets.all(3),
                    child: FlatButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30)),
                        color: Colors.red,
                        onPressed: _onClickSettlementBtn,
                        child: Text(
                          "结算",
                          style: TextStyle(color: Colors.white),
                        ))),
              ],
            )),
          ],
        ));
  }

  void _$RefreshUI() {
    if (mounted) setState(() {});
  }

  void _clickAllSelectedCallback(bool value) {
    _viewModel?.selected = value;

    _$RefreshUI();
  }

  void _onClickSettlementBtn() {
    print("提交 $selectedIds");
    NetworkManager.instance.submitShoppingCartOrder(selectedIds).then((value) {
      if (value != null)
        UIManager.instance
            .toPage(context, UIDef.comfirmOrder, arguments: value);
    });
  }

  void _onClickDeleteBtn() {
    print("删除 $selectedIds");

    NetworkManager.instance
        .deleteShoppintCartCommodities(selectedIds)
        .then((msg) {
      if (msg != null && msg.isNotEmpty)
        return WidgetComponents.DefaultToast(msg);

      _updateData();
    });
  }

  @override
  void onChangedSelected(bool selected, ShoppingCartCardViewModel data) {
    _viewModel?.update();
    _$RefreshUI();
  }

  @override
  void onCountChanged(int number, String id) {
    _viewModel?.update();
    _$RefreshUI();
  }

  @override
  void onChangedSingleSelected(bool selected, String commodityId) {
    // TODO: implement onChangedSingleSelected

    Debug.log("SingleSelected ! $selected  $commodityId ");

    _viewModel?.update();
    _$RefreshUI();
  }
}
