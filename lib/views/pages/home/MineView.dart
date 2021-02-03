import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_etu_remake/AppDefaultStyle.dart';
import 'package:flutter_etu_remake/WidgetComponents.dart';
import 'package:flutter_etu_remake/common/Constant.dart';
import 'package:flutter_etu_remake/core/NetworkManager.dart';
import 'package:flutter_etu_remake/core/UIManager.dart';
import 'package:flutter_etu_remake/l10n/localization_intl.dart';
import 'package:flutter_etu_remake/viewmodels/UserCardViewModel.dart';
import 'package:flutter_etu_remake/views/components/MineOrderCard.dart';
import 'package:flutter_etu_remake/views/components/MineToolsCard.dart';
import 'package:flutter_etu_remake/views/components/UserCard.dart';

class MineView extends StatefulWidget {
  MineView({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => MineViewState();
}

class MineViewState extends State<MineView>
    implements MineToolsCardDelegate, MineOrderCardDelegate, UserCardDelegate {
  UserCardViewModel _userCardViewModel;

  @override
  void initState() {
    super.initState();
    _updateData();
  }

  void _updateData() {
    NetworkManager.instance.user().then((value) {
      if (mounted)
        setState(() {
          _userCardViewModel = UserCardViewModel.transform(value);
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
    Size screen = MediaQuery.of(context).size;
    return Scaffold(
      extendBodyBehindAppBar: true,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        toolbarHeight: AppDefaultStyle.appBarHeight,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        title: Text(AppLocalizations.of(context).mine,style:TextStyle(fontSize: AppDefaultStyle.AppTitleFontSize) ),
        actions: [
          IconButton(
            icon: Icon(Icons.message),
            onPressed: _onClickMessageBtn,
          ),
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: _onClickSettingBtn,
          )
        ],
      ),
      body: Container(
          width: screen.width,
          height: screen.height,
          decoration: BoxDecoration(
              image: DecorationImage(
                  alignment: Alignment.topCenter,
                  fit: BoxFit.fitWidth,
                  image: AssetImage('assets/images/mine_bg.png'))),
          child: _$BuildContent(context)),
    );
  }

  Widget _$BuildContent(BuildContext context) {
    return Container(
        margin: EdgeInsets.fromLTRB(10, 70, 10, 0),
        child: Column(children: [
          UserCard(
            data: _userCardViewModel,
            listener: this,
          ),
          Container(
              margin: const EdgeInsets.symmetric(vertical: 10),
              child: MineOrderCard(
                listener: this,
              )),
          Container(
            child: MineToolsCard(
              listener: this,
            ),
          )
        ]));
  }

  @override
  onDeliveryAddress() {
    UIManager.instance.toPage(context, UIDef.deliveryAddress);
  }

  @override
  onFeedback() {
    UIManager.instance.toPage(context, UIDef.suggestionFeedback);
  }

  @override
  onInviteFriends() {
    WidgetComponents.ModuleDeveloping();
  }

  @override
  onServiersTel() {
    //WidgetComponents.ModuleDeveloping();
    WidgetComponents.DefaultDailog(context,
        title: AppLocalizations.of(context).serivcesTel,
        content: _userCardViewModel.servicePhone);
  }

  @override
  onAftersales() {
    UIManager.instance.toPage(context, UIDef.myOrders, arguments: OrderConstants.AFTERSALES_ORDERS);
  }

  @override
  onPredelivery() {
    UIManager.instance.toPage(context, UIDef.myOrders, arguments: OrderConstants.PREDELIVERY_ORDERS);
  }

  @override
  onPreevaluation() {
    UIManager.instance.toPage(context, UIDef.myOrders, arguments: OrderConstants.PREEVALUATION_ORDERS);
  }

  @override
  onPrepayment() {
    UIManager.instance.toPage(context, UIDef.myOrders, arguments:OrderConstants.PREPAYMENT_ORDERS);
  }

  @override
  onPrereceive() {
    UIManager.instance.toPage(context, UIDef.myOrders, arguments: OrderConstants.PRERECEIVE_ORDERS);
  }

  @override
  onViewAllOrders() {
    UIManager.instance.toPage(context, UIDef.myOrders, arguments: OrderConstants.ALL_ORDERS);
  }

  @override
  onClickAttentionStore() {
    UIManager.instance.toPage(context, UIDef.collectionStore).then((value) {
      _updateData();
    });
  }

  @override
  onClickBalance() {
    UIManager.instance.toPage(context, UIDef.userBalance).then((value) {
      _updateData();
    });
  }

  @override
  onClickFavorites() {
    UIManager.instance.toPage(context, UIDef.collectionCommodity).then((value) {
      _updateData();
    });
  }

  @override
  onClickFootprint() {
    UIManager.instance.toPage(context, UIDef.footprint).then((value) {
      _updateData();
    });
  }

  @override
  onClickUser() {
    // TODO: implement onClickUser
    throw UnimplementedError();
  }

  void _onClickMessageBtn() {
    UIManager.instance.toPage(context, UIDef.messageCenter);
  }

  void _onClickSettingBtn() {}
}
