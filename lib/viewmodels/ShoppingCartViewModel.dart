import 'package:flutter_etu_remake/models/ShoppingCartDetail.dart';
import 'package:flutter_etu_remake/viewmodels/ShoppingCartCardViewModel.dart';

class ShoppingCartViewModel {
  bool isEdit;
  bool _selected;
  double _amount;
  List<ShoppingCartCardViewModel> commodities;

  ShoppingCartViewModel({this.isEdit = false}) {
    _selected = false;
    _amount = 0;
    update();
  }

  get amount =>_amount;   

  // ignore: unnecessary_getters_setters
  set selected(bool isSelected) {
    _selected = isSelected;

    _amount = 0;
    if (commodities == null || commodities.length <= 0) return;

    commodities?.forEach((element) {
      element.allSelected = _selected;
      element.items?.forEach((element) {
        element.selected = _selected;
        if (isSelected) _amount += (element.price * element.quantity);
      });
    });
  }

  // ignore: unnecessary_getters_setters
  get selected => _selected;


  factory ShoppingCartViewModel.transform(ShoppingCartDetail data){

      return ShoppingCartViewModel().._amount = data.totalAmount
      ..commodities = data.parts?.map((e) => ShoppingCartCardViewModel.transform(e))?.toList();
  }

  ///更新一下数据
  void update() {
    _amount = 0;
     commodities?.forEach((element) {
      element.items?.forEach((element) {
        if (element?.selected??false) _amount += (element.price * element.quantity);
      });
    });}
}
