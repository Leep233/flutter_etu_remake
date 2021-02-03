import 'package:flutter/material.dart';
import 'package:flutter_etu_remake/WidgetComponents.dart';
import 'package:flutter_etu_remake/l10n/localization_intl.dart';
import 'package:flutter_etu_remake/viewmodels/CommodityCardViewModel.dart';

// ignore: must_be_immutable
class CommodityCard extends StatelessWidget {

  final double imageSize;

  final CommodityCardViewModel sourceData;

  final TextStyle titleStyle =
      TextStyle(color: Colors.black, fontWeight: FontWeight.w500, fontSize: 14);

  final TextStyle subtitleStyle01 =
      TextStyle(color: Colors.grey, fontWeight: FontWeight.w400, fontSize: 12);

  final TextStyle subtitleStyle02 =
      TextStyle(color: Colors.black, fontWeight: FontWeight.w400, fontSize: 12);

  final CommodityCardDelegate listener;

    final ShapeBorder shape;

  CommodityCard({this.sourceData, this.listener,this.shape,this.imageSize = 130});

  BuildContext context;

  @override
  Widget build(BuildContext context) {
    this.context = context;
    // TODO: implement build
    return Card(
      shape: shape,
      child: _$CardContent(context),
    );
  }

  Widget _$CardContent(BuildContext context) {
    return FlatButton(
        padding: EdgeInsets.all(0),
        highlightColor: Colors.transparent,
        splashColor: Colors.grey[10],
        onPressed: _onClickCommodity,
        child: Container(
            margin: EdgeInsets.all(5),
            child: Row(
              children: [
                Container(
                  margin: EdgeInsets.only(right: 10),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: FadeInImage.assetNetwork(
                        height: imageSize,
                        width: imageSize,
                        fit: BoxFit.fill,
                        placeholder: 'assets/images/loading.gif',
                        image: sourceData.image),
                  ),
                ),
                Expanded(child: Container(child: _$CommodityLables(context)))
              ],
            )));
  }

  Widget _$CommodityLables(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FlatButton(
            height: 20,
            padding: const EdgeInsets.all(0),
            highlightColor: Colors.transparent,
            onPressed: _onClickCommodity,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                    child: Text(
                  sourceData.commodityName,
                  style: titleStyle,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                )),
                Container(
                    width: 20,
                    child: Icon(
                      Icons.more_vert,
                      size: 20,
                      color: Colors.grey,
                    ))
              ],
            )),
        Container(
            margin: EdgeInsets.symmetric(vertical: 1, horizontal: 0),
            child: WidgetComponents.TitleLabel(
                AppLocalizations.of(context).advantage,
                ' ${sourceData.advantage}',
                titleStyle: subtitleStyle01,
                labelStyle: subtitleStyle02)),
        Container(
            margin: EdgeInsets.symmetric(vertical: 1, horizontal: 0),
            child: WidgetComponents.TitleLabel(
                AppLocalizations.of(context).suggested,
                ' ${sourceData.suggested}',
                titleStyle: subtitleStyle01,
                labelStyle: subtitleStyle02)),
        Container(
            child: WidgetComponents.MeonyLabel(sourceData.price,
                originalPrice: sourceData.originalPrice, scale: 1.3)),
        Container(
          child: _$TipsLable(sourceData.tips, sourceData.salesVolume),
        ),
        FlatButton(
            height: 12,
            padding: const EdgeInsets.all(0),
            highlightColor: Colors.transparent,
            onPressed: _onClickStoreName,
            child: Row(
              children: [
                Text(
                  sourceData.storeName,
                  style: subtitleStyle01,
                ),
                Icon(
                  Icons.chevron_right,
                  size: 16,
                  color: Colors.grey,
                )
              ],
            )),
      ],
    );
  }

  Widget _$TipsLable(List<String> tips, int salesVolume) {
    List<Widget> childs = [];

    for (var i = 0; i < tips?.length; i++) {
      childs.add(WidgetComponents.Tips(tips[i],
          style: TextStyle(fontSize: 12, color: Theme.of(context).accentColor),
          borderColor: Theme.of(context).accentColor));
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        childs.length > 0 ? Row(children: childs) : SizedBox(),
        Text(
          AppLocalizations.of(context).soldNumber(salesVolume),
          style: subtitleStyle01,
        )
      ],
    );
  }

  void _onClickCommodity() {

    listener?.onPressedCommodity(sourceData.commodityId);
  }

  void _onClickStoreName() {

     listener?.onPressedStore(sourceData.storeId);
  }
}

abstract class CommodityCardDelegate {
  void onPressedCommodity(String commodityId);
  void onPressedStore(String storeId);
}
