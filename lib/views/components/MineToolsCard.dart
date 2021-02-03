import 'package:flutter/material.dart';
import 'package:flutter_etu_remake/AppDefaultStyle.dart';
import 'package:flutter_etu_remake/WidgetComponents.dart';
import 'package:flutter_etu_remake/l10n/localization_intl.dart';

class MineToolsCard extends StatelessWidget {
  final double kIconSize = 24;
  final TextStyle style01 = TextStyle(fontSize: 12, color: Colors.grey);

  final MineToolsCardDelegate listener;

  MineToolsCard({this.listener});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0.5,
      child: _$CardContent(context),
    );
  }

  Widget _$CardContent(BuildContext context) {
    return Container(
        margin: EdgeInsets.all(10),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                  child: Text(
                AppLocalizations.of(context).commonTools,
                style: TextStyle(fontSize: AppDefaultStyle.TitleFontSize, fontWeight: FontWeight.w600),
              )),
              Container(
                margin: const EdgeInsets.only(top: 10),
                width: double.infinity,
                child: _$ToolButtons(context),
              ),
            ]));
  }

// //""
  Widget _$ToolButtons(BuildContext context) {
    return Wrap(
      alignment: WrapAlignment.spaceAround,
      children: [
        Container(
            child: WidgetComponents.ImageButton(
                'assets/images/icon_shdz_nor.png',
                AppLocalizations.of(context).deliveryAddress,
                style: style01,
                iconSize: kIconSize,
                onPressed: _onClickDeliveryAddressBtn)),
        Container(
            child: WidgetComponents.ImageButton('assets/images/icon_kf_nor.png',
                AppLocalizations.of(context).serivcesTel,
                style: style01,
                iconSize: kIconSize,
                onPressed: _onClickSerivcesTelBtn)),
        Container(
            child: WidgetComponents.ImageButton(
                'assets/images/icon_yqhy_nor.png',
                AppLocalizations.of(context).inviteFriends,
                style: style01,
                iconSize: kIconSize,
                onPressed: _onClickInviteFriendsBtn)),
        Container(
            child: WidgetComponents.ImageButton(
                'assets/images/icon_yjfk_nor.png',
                AppLocalizations.of(context).feedback,
                style: style01,
                iconSize: kIconSize,
                onPressed: _onClickFeedbackBtn)),
      ],
    );
  }

  void _onClickFeedbackBtn() {
    print("意见反馈");
    listener?.onFeedback();
  }

  void _onClickSerivcesTelBtn() {
    print("客服电话");
    listener?.onServiersTel();
  }

  void _onClickInviteFriendsBtn() {
    print("邀请好友");
    listener?.onInviteFriends();
  }

  void _onClickDeliveryAddressBtn() {
    print("收货地址");
    listener?.onDeliveryAddress();
  }
}

abstract class MineToolsCardDelegate {
  onFeedback();
  onServiersTel();
  onInviteFriends();
  onDeliveryAddress();
}
