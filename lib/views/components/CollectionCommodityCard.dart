import 'package:flutter/material.dart';
import 'package:flutter_etu_remake/WidgetComponents.dart';
import 'package:flutter_etu_remake/l10n/localization_intl.dart';
import 'package:flutter_etu_remake/viewmodels/CollectionCommodityCardViewModel.dart';

// ignore: must_be_immutable
class CollectionCommodityCard extends StatelessWidget {

  final double imageSize = 80;

  final CollectionCommodityCardViewModel sourceData;

  final TextStyle titleStyle =
      TextStyle(color: Colors.black, fontWeight: FontWeight.w500, fontSize: 16);

  final TextStyle subtitleStyle01 =
      TextStyle(color: Colors.grey, fontWeight: FontWeight.w400, fontSize: 14);

  final TextStyle subtitleStyle02 =
      TextStyle(color: Colors.black, fontWeight: FontWeight.w400, fontSize: 14);

  final CollectionCommodityCardDelegate listener;

  CollectionCommodityCard({this.sourceData, this.listener});

  BuildContext context;

  @override
  Widget build(BuildContext context) {
    this.context = context;
    // TODO: implement build
    return Card(
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
                Expanded(child: Container(child: _$CommodityLables(context))),         
              ],
            )));
  }

  Widget _$CommodityLables(BuildContext context) {   

    return  
      Column(
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
                  sourceData?.title??"",
                  style: titleStyle,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                )),               
              ],
            )),
        Container(
            margin: EdgeInsets.symmetric(vertical: 1, horizontal: 0),
            child: Text(sourceData.subtitle,style: subtitleStyle01,)),
        Container(
            margin: EdgeInsets.symmetric(vertical: 1, horizontal: 0),
            child: Text(AppLocalizations.of(context).collectionNumber(sourceData?.collectNum??0),style: subtitleStyle01,)),
        Container(
            child:Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,children: [
              WidgetComponents.MeonyLabel(sourceData.price,scale: 1.5),
              FlatButton(textColor: Theme.of(context).accentColor,height: 30,
            shape:RoundedRectangleBorder(borderRadius: BorderRadius.circular(20),side: BorderSide(color: Theme.of(context).accentColor )),
            padding: const EdgeInsets.all(0),
            highlightColor: Colors.transparent,
            onPressed: _onClickCancelName,
            child: Text("取消收藏")),
            ],) ),
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

    listener?.onPressedCommodity(sourceData.productNo);
  }

  void _onClickCancelName() {
     listener?.onPressedCancel(sourceData.productNo);
  }
}

abstract class CollectionCommodityCardDelegate {
  void onPressedCommodity(String id);
  void onPressedCancel(String id);
}
