import 'package:flutter/material.dart';
import 'package:flutter_etu_remake/AppDefaultStyle.dart';
import 'package:flutter_etu_remake/WidgetComponents.dart';
import 'package:flutter_etu_remake/core/NetworkManager.dart';
import 'package:flutter_etu_remake/l10n/localization_intl.dart';
import 'package:flutter_etu_remake/viewmodels/PurchaseCommodityItemViewModel.dart';
import 'package:flutter_etu_remake/viewmodels/ShoppingCartCardViewModel.dart';
import 'package:flutter_etu_remake/views/components/PurchaseCommodityItem.dart';

class ShoppingCartCard extends StatefulWidget {
  final ShoppingCartCardViewModel data;

  final ShoppingCartCardDelegate listener;

  final bool isEidt;

  ShoppingCartCard({Key key, this.data,this.isEidt=false, this.listener}) : super(key: key);

  @override
  State<StatefulWidget> createState() => ShoppingCartCardState();
}

class ShoppingCartCardState extends State<ShoppingCartCard>
    implements ShoppingCartCardItemDelegate {
  final double kCheckboxSize = 30;

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
    List<Widget> childs = [];

    if (widget.data == null) return SizedBox();

    widget.data?.items?.forEach((element) {
      childs.add(Container(
        child: ShoppingCartCommodityItem(isEdit: widget.isEidt,
          data: element,
          listener: this,
        ),
        margin: const EdgeInsets.all(3),
      ));
    });

    return Card(
      child: Container(
          margin: const EdgeInsets.all(10),
          child: Column(children: [
            Container(
              child: _$TitleWidget(),
            ),
            Column(children: childs)
          ])),
    );
  }

  Widget _$TitleWidget() {
    return Row(
      children: [
        Container(
          width: kCheckboxSize,
          height: kCheckboxSize,
          child: Checkbox(
              value: widget?.data?.allSelected ?? false,
              onChanged: (value) {
                widget?.data?.allSelected = value;
                _$RefreshUI();
                _onClickAllSelected(widget?.data?.allSelected);
              }),
        ),
        FlatButton(
            padding: const EdgeInsets.all(0),
            onPressed: _onClickStoreTitle,
            child: Row(
              children: [
                Text(
                  widget?.data?.title ?? "",
                  style:AppDefaultStyle.titleStyle01,
                ),
                Icon(
                  Icons.chevron_right,
                  color: Colors.grey,
                )
              ],
            ))
      ],
    );
  }

  void _$RefreshUI() {
    if (mounted) setState(() {});
  }

  void _onClickStoreTitle() {}

  @override
  void onChangedSelected(bool selected, String id) {
    widget.listener?.onChangedSingleSelected(selected, id);
  }

  @override
  void onCountChanged(int number, String id) {
    widget.listener?.onCountChanged(number, id);
  }

  void _onClickAllSelected(bool allSelected) {
    widget.data?.items?.forEach((element) {
      if (element.understock) element.selected = allSelected;
    });

    _$RefreshUI();

    //全选
    widget.listener?.onChangedSelected(allSelected, widget.data);
  }
}

class ShoppingCartCommodityItem extends StatefulWidget {
  final ShoppingCartCardItemViewModel data;
  final double checkBoxSize;
  final double imageSize;
  final ShoppingCartCardItemDelegate listener;
  final bool isEdit;
  ShoppingCartCommodityItem(
      {Key key,
      this.listener,
      this.isEdit = false,
      this.data,
      this.checkBoxSize = 30,
      this.imageSize = 80})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => ShoppingCartCommodityItemState();
}

class ShoppingCartCommodityItemState extends State<ShoppingCartCommodityItem> {
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

    PurchaseCommodityItemViewModel commodityItem = PurchaseCommodityItemViewModel();
    commodityItem.image = widget?.data?.image ?? "";
    commodityItem.title =  widget.data?.title ?? "";
    commodityItem.subtitle =  widget.data?.specification ?? "";
    commodityItem.quantity = widget.data?.quantity ?? 0;
    commodityItem.price = widget.data?.price;

    return Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
      Container(
        width: widget.checkBoxSize,
        height: widget.checkBoxSize,
        child: Checkbox(
            value: widget?.data?.selected ?? false,
            onChanged:widget.isEdit?_onClickChecked:
            widget?.data?.understock == true ? _onClickChecked : null),
      ),
      Expanded(child: Container(child:PurchaseCommodityItem(viewModel: commodityItem,onCountChanged:_onBuyNumberChanged,),)) 
    ]);
  }

  //检查库存够不够
  bool checkInventory(int number) {
    bool has = true;
    int inventory = widget.data?.inventory ?? 0;

    if (inventory < number) {
      WidgetComponents.DefaultToast(
          AppLocalizations.of(context).understock(inventory));
      has = false;
    }
    return has;
  }

  void _$RefreshUI() {
    if (mounted) setState(() {});
  }

  void _onClickChecked(bool value) {
    //库存充足才可以勾选
    if (widget?.data?.understock == true) {
      widget?.data?.selected = value;
      _$RefreshUI();
      widget.listener
          ?.onChangedSelected(widget?.data?.selected, widget?.data?.id);
    }
  }

  void _onBuyNumberChanged(int value) {
  //  if (checkInventory(value)) {
      NetworkManager.instance
          .updateShoppingCartCommodityQuantity(
              int.parse(widget?.data?.id ?? '0'), value)
          .then((error) {
        if (error.isNotEmpty) {
          WidgetComponents.DefaultToast(error);
        } else {
          widget.data?.quantity = value;
          widget.listener?.onCountChanged(value, widget.data?.id);
          _$RefreshUI();
        }
      });
   // }
  }
}

abstract class ShoppingCartCardItemDelegate {
  // void onPressedStoreTitle(int storeId);
  void onChangedSelected(bool selected, String id);
  void onCountChanged(int number, String id);
}

abstract class ShoppingCartCardDelegate {
  // void onPressedStoreTitle(int storeId);
  void onChangedSingleSelected(bool selected, String commodityId);
  void onChangedSelected(bool selected, ShoppingCartCardViewModel data);
  void onCountChanged(int number, String id);
}
