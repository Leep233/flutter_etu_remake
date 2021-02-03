import 'package:flutter/material.dart';
import 'package:flutter_etu_remake/AppDefaultStyle.dart';
import 'package:flutter_etu_remake/WidgetComponents.dart';
import 'package:flutter_etu_remake/l10n/localization_intl.dart';

// ignore: must_be_immutable
class MineOrderCard extends StatelessWidget {
  final double kIconSize = 24;
  final TextStyle style01 = TextStyle(fontSize: 12, color: Colors.grey);

  final MineOrderCardDelegate listener;

  MineOrderCard({this.listener});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
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
            children: [
              Container(child: _$TitleLabel(context)),
              Container(margin:const EdgeInsets.symmetric(vertical: 10, horizontal: 0),child: WidgetComponents.Line()),
              Container( child: _$ButtonLable(context)),
            ]));
  }

  Widget _$TitleLabel(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment:CrossAxisAlignment.baseline ,
      children: [
        Text(
          AppLocalizations.of(context).myOrder,
          style: TextStyle(fontSize: AppDefaultStyle.TitleFontSize, fontWeight: FontWeight.w600),
        ),
        InkWell(
          child: Row(children: [
            Text(
              AppLocalizations.of(context).viewAllOrder,
              style: TextStyle(fontSize: 12, color: Colors.grey),
            ),
            Icon(Icons.chevron_right, size: 12, color: Colors.grey)
          ]),
          onTap: _onClickAllOrderBtn,
        )
      ],
    );
  }

  Widget _$ButtonLable(BuildContext context) {
    return Row(    
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Container(
            child: WidgetComponents.ImageButton(
              'assets/images/icon_dfk_nor.png',
                AppLocalizations.of(context).prepayment,style: style01,iconSize: kIconSize,
                onPressed: _onClickPrepaymentBtn)),
        Container(
            child: WidgetComponents.ImageButton(
                'assets/images/icon_dfh_nor.png',
                AppLocalizations.of(context).predelivery,style: style01,iconSize: kIconSize,
                onPressed: _onClickPredeliveryBtn)),
        Container(
            child: WidgetComponents.ImageButton(
                'assets/images/icon_dsh_nor.png',
                AppLocalizations.of(context).prereceiving,style: style01,iconSize: kIconSize,
                onPressed: _onClickPreReceivingBtn)),
        Container(
            child: WidgetComponents.ImageButton(
                'assets/images/icon_dpj_nor.png',
                AppLocalizations.of(context).preevaluation,style: style01,iconSize: kIconSize,
                onPressed: _onClickPreevaluationBtn)),

                   Container(
            child: WidgetComponents.ImageButton('assets/images/icon_sh_nor.png',
                AppLocalizations.of(context).aftersales,style: style01,iconSize: kIconSize,
                onPressed: _onClickAftersalesBtn)),
     
      ],
    );
  }

  void _onClickPrepaymentBtn() {
    listener?.onPrepayment();
  }

  void _onClickPredeliveryBtn() {
    listener?.onPredelivery();
  }

  void _onClickPreReceivingBtn() {
    listener?.onPrereceive();
  }

  void _onClickPreevaluationBtn() {
    listener?.onPreevaluation();
  }

  void _onClickAftersalesBtn() {
    listener?.onAftersales();
  }

  void _onClickAllOrderBtn() {
    listener?.onViewAllOrders();
  }
}

abstract class MineOrderCardDelegate {
  onViewAllOrders();
  onAftersales();
  onPreevaluation();
  onPrereceive();
  onPredelivery();
  onPrepayment();
}
