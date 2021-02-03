import 'package:address_picker/address_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_etu_remake/WidgetComponents.dart';
import 'package:flutter_etu_remake/core/NetworkManager.dart';
import 'package:flutter_etu_remake/l10n/localization_intl.dart';
import 'package:flutter_etu_remake/models/Deliveryaddress.dart';
import 'package:flutter_etu_remake/viewmodels/DeliveryAddressItemViewModel.dart';
import 'package:flutter_etu_remake/views/components/DeliveryAddressItem.dart';

class DeliveryAddressListPage extends StatefulWidget {

    final DeliveryAddressListPageDelegate listener;

  DeliveryAddressListPage({Key key,this.listener}) : super(key: key);

  @override
  State<StatefulWidget> createState() => DeliveryAddressListPageState();
}

class DeliveryAddressListPageState extends State<DeliveryAddressListPage>
    implements EditDeliveryAddressPageDelegate {

  List<DeliveryAddressItemViewModel> items;

  @override
  void initState() {
    super.initState();

    NetworkManager.instance.deliveryAddreses().then((value) {
      items = value
          ?.map((e) => DeliveryAddressItemViewModel.transform(e))
          ?.toList();
      _$RefreshUI();
    });
  }

  void _$RefreshUI() {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0.1,
          backgroundColor: Colors.white,
          title: Text(
            AppLocalizations.of(context).deliveryAddress,
            style: TextStyle(color: Colors.black),
          ),
          leading: IconButton(
            icon: Icon(Icons.chevron_left, color: Colors.black),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          actions: [
            TextButton(
                onPressed: toEditPage,
                child: Text(AppLocalizations.of(context).addAddress))
          ],
        ),
        body: _$BodyContentBuilder(context));
  }

  Widget _$BodyContentBuilder(BuildContext context) {
    return ListView.builder(
      itemBuilder: _$AddressBuilder,
      itemCount: items?.length ?? 0,
    );
  }

  Widget _$AddressBuilder(BuildContext context, int index) {
    DeliveryAddressItemViewModel data = items[index];

    return DeliveryAddressItem(
      data: data,
      onEidt: () {
        print(data.name);
        toEditPage(data: data);
      },
      onPressed: () {
        widget.listener?.onClickDeliveryAddressItem(data);
      },
    );
  }

  void toEditPage({DeliveryAddressItemViewModel data}) {
    Navigator.push<bool>(context,
        new MaterialPageRoute(builder: (BuildContext context) {
      return EditDeliveryAddressPage(
        data: data,
        listener: this,
      );
    })).then((bool _isRefresh) {
      if (!_isRefresh) return;

      NetworkManager.instance.deliveryAddreses().then((value) {
        items = value
            ?.map((e) => DeliveryAddressItemViewModel.transform(e))
            ?.toList();
        _$RefreshUI();
      });
    });
  }

  @override
  onDeleted(String id) {
    if (id != null && id.isNotEmpty) {
      NetworkManager.instance
          .deleteDeliveryAddress(int.parse(id))
          .then((value) {
        Navigator.pop<bool>(context, true);
      });
    }
  }

  @override
  onSave(DeliveryAddressItemViewModel data) {
    Deliveryaddress address = Deliveryaddress();
    address.consignee = data.name;
    address.id = data.id;
    address.consigneeAddress = data.address;
    address.consigneePhone = data.phone;
    address.county = data.county;
    address.detailAddress = data.detailAddress;
    address.prefecture = data.prefecture;
    address.province = data.province;
    address.isDefault = data.isDefault?1:0;
    if (address.id != null)
      NetworkManager.instance.editDeliveryAddress(address).then((value) {
        Navigator.pop<bool>(context, true);
      });
    else
      NetworkManager.instance.addDeliveryAddress(address).then((value) {
        Navigator.pop<bool>(context, true);
      });
  }
}

class EditDeliveryAddressPage extends StatefulWidget {
  final DeliveryAddressItemViewModel data;
  final EditDeliveryAddressPageDelegate listener;
  EditDeliveryAddressPage({Key key, @required this.data, this.listener})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => EditDeliveryAddressPageState();
}

class EditDeliveryAddressPageState extends State<EditDeliveryAddressPage> {
  TextEditingController nameController;
  TextEditingController phoneController;
  TextEditingController detailAddressController;

  final GlobalKey<FormFieldState> userKey = GlobalKey<FormFieldState>();
  final GlobalKey<FormFieldState> phoneKey = GlobalKey<FormFieldState>();
  final GlobalKey<FormFieldState> detailKey = GlobalKey<FormFieldState>();

  DeliveryAddressItemViewModel _viewModel;

  bool _isEdit;
  String _province;
  String _city;
  String _area;

  @override
  void initState() {
    super.initState();
    _isEdit = false;

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      
      _viewModel = widget.data;

      _isEdit = !(_viewModel == null);

      if (!_isEdit) _viewModel = DeliveryAddressItemViewModel(isDefault: false);

      if(mounted)setState(() {
        
      });

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
          centerTitle: true,
          elevation: 0.1,
          backgroundColor: Colors.white,
          title: Text(
            _isEdit
                ? AppLocalizations.of(context).editDeliveryAddress 
                : AppLocalizations.of(context).addAddress,
            style: TextStyle(color: Colors.black),
          ),
          leading: IconButton(
            icon: Icon(Icons.chevron_left, color: Colors.black),
            onPressed: () {
              Navigator.pop<bool>(context, false);
            },
          ),
        ),
        body: _$BodyContentBuilder(context));
  }

  Widget _$AddressLabel() {
    List<Widget> items = [];

    if (_viewModel?.province != null && _viewModel.province.isNotEmpty)
      items.add(Text(_viewModel.province));

    if (_viewModel?.prefecture != null && _viewModel.prefecture.isNotEmpty)
      items.add(Text(_viewModel.prefecture));

    if (_viewModel?.county != null && _viewModel.county.isNotEmpty)
      items.add(Text(_viewModel.county));

    return Container(
      margin: EdgeInsets.only(bottom: 2),
      color: Colors.white,
      padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
      child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
                margin: const EdgeInsets.only(top: 5),
                width: 70,
                child: Text("所在地区")),
            Expanded(
                child: Container(
                    margin: const EdgeInsets.only(top: 5),
                    width: double.infinity,
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: items))),
            FlatButton(
                padding: EdgeInsets.all(0),
                onPressed: showAddressSelector,
                child: Row(
                  children: [
                    if (items.length <= 0) Text("请选择"),
                    Icon(
                      Icons.chevron_right,
                      color: Colors.grey,
                    )
                  ],
                ))
          ]),
    );
  }

  _$DetailAddressTextFeild() {
    return Container(
      color: Colors.white,
      margin: EdgeInsets.only(bottom: 2),
      padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
      child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Container(
            margin: const EdgeInsets.only(top: 10),
            width: 70,
            child: Text("详细地址")),
        Expanded(
            child: Container(
          color: Colors.white,
          margin: EdgeInsets.only(bottom: 2),
          padding: EdgeInsets.all(10),
          child: TextFormField(
            key: detailKey,
            onChanged: (value) {
              _viewModel.detailAddress = value;
            },
            validator: (value) => (value.isNotEmpty) ? null : "请填写详细地址",
            controller: detailAddressController,
            maxLines: 3,
            style: TextStyle(fontSize: 14),
            decoration: InputDecoration.collapsed(
                hintText: "请填写详细地址", hintStyle: TextStyle(fontSize: 14)),
          ),
        )),
      ]),
    );
  }

  Widget _$DefaultStateLable() {
    return Container(
      color: Colors.white,
      margin: EdgeInsets.only(bottom: 2),
      padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
      child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(width: 70, child: Text("设为默认")),
            Container(
              child: Switch(
                value: _viewModel?.isDefault ?? false,
                onChanged: (value) {
                  if (mounted)
                    setState(() {
                      _viewModel.isDefault = value;
                    });
                },
              ),
            )
          ]),
    );
  }

  _$BodyContentBuilder(BuildContext context) {
    nameController = TextEditingController(text: _viewModel?.name ?? "");
    phoneController = TextEditingController(text: _viewModel?.phone ?? "");

    detailAddressController =
        TextEditingController(text: _viewModel?.detailAddress ?? "");

    return Container(
      child: Column(children: [
        Container(
            child: WidgetComponents.TitleTextField("收件人", "请输入收件人",
                onChanged: (value) {
                  _viewModel.name = value;
                },
                key: userKey,
                validator: (value) => (value.isNotEmpty) ? null : "请输入收件人",
                controller: nameController)),
        Container(
            child: WidgetComponents.TitleTextField("联系电话", "请输入联系电话",
                onChanged: (value) {
          _viewModel.phone = value;
        },
                key: phoneKey,
                validator: phoneNumberVerification,
                controller: phoneController)),
        Container(
          child: _$AddressLabel(),
        ),
        Container(
          child: _$DetailAddressTextFeild(),
        ),
        Container(child: _$DefaultStateLable()),
        Container(
            margin: const EdgeInsets.all(10),
            child: WidgetComponents.CommonButton("保存",
                style: TextStyle(color: Colors.white),
                onPressed: _onClickSaveAddress)),
        if (_isEdit)
          Container(
              margin: const EdgeInsets.all(10),
              child: WidgetComponents.CommonButton("删除",
                  style: TextStyle(color: Colors.white),
                  onPressed: _onClickDeletedAddress)),
      ]),
    );
  }

  String phoneNumberVerification(String value) {
    if (value.isEmpty) return AppLocalizations.of(context).inputPhoneTip;

    RegExp reg = new RegExp(r'^\d{11}$');
    if (!reg.hasMatch(value)) {
      return AppLocalizations.of(context).phoneNumberWrongTip;
    }
    return null;
  }

  void _onClickSaveAddress() {
    if (userKey.currentState.validate() &&
        phoneKey.currentState.validate() &&
        detailKey.currentState.validate()) {
      if (_viewModel.prefecture == null ||
          _viewModel.prefecture.isEmpty ||
          _viewModel.province == null ||
          _viewModel.province.isEmpty ||
          _viewModel.county == null ||
          _viewModel.county.isEmpty) {
        return WidgetComponents.DefaultToast("请选择所在地");
      }

      widget.listener?.onSave(_viewModel);
    }
  }

  void _onClickDeletedAddress() {
    widget.listener?.onDeleted(_viewModel.id);
  }

  void showAddressSelector() {
    showModalBottomSheet(
        context: context,
        builder: (context) => BottomSheet(
              onClosing: () {},
              builder: (context) => Container(
                  height: 300.0,
                  child: Column(children: [
                    Container(
                        alignment: Alignment.centerRight,
                        width: double.infinity,
                        margin: EdgeInsets.all(3),
                        child: FlatButton(
                            color: Colors.red,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                                side: BorderSide(color: Colors.grey)),
                            onPressed: () {
                              print("确定");

                              setState(() {
                                print('${_province}');
                                print('${_city}');
                                print('${_area}');
                                _viewModel.province = _province;
                                _viewModel.prefecture = _city;
                                _viewModel.county = _area;
                              });
                              Navigator.pop(context);
                            },
                            child: Text("确定",
                                style: TextStyle(color: Colors.white)))),
                    Container(
                        height: 250.0,
                        child: AddressPicker(
                          style: TextStyle(color: Colors.black, fontSize: 17),
                          mode: AddressPickerMode.provinceCityAndDistrict,
                          onSelectedAddressChanged: (address) {
                            _province = address.currentProvince.province;
                            _city = address.currentCity.city;
                            _area = address.currentDistrict.area;
                          },
                        )),
                  ])),
            ));
  }
}

abstract class EditDeliveryAddressPageDelegate {
  onSave(DeliveryAddressItemViewModel data);
  onDeleted(String id);
}

abstract class DeliveryAddressListPageDelegate{
  onClickDeliveryAddressItem(DeliveryAddressItemViewModel data);
}
