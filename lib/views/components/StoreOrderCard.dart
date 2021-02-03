import 'package:flutter/material.dart';
import 'package:flutter_etu_remake/WidgetComponents.dart';
import 'package:flutter_etu_remake/common/StringUtil.dart';
import 'package:flutter_etu_remake/viewmodels/StoreOrderCardViewModel.dart';
import 'package:flutter_etu_remake/views/components/StoreOrderCommodityItem.dart';

class StoreOrderCard extends StatelessWidget {

  final StoreOrderCardViewModel viewModel;

  final Widget tailing;

  StoreOrderCard({this.viewModel,this.tailing});

  @override
  Widget build(BuildContext context) {
    Widget title = Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        FlatButton(
            padding: EdgeInsets.all(0),
            onPressed: null,
            child: Row(
              children: [
                Text(
                  viewModel?.storeName,
                  style: TextStyle(fontSize: 15, color: Colors.black),
                ),
                Icon(
                  Icons.chevron_right,
                  color: Colors.grey,
                )
              ],
            )),
        Text(
         StringUtil.OrderStateToString(viewModel.orderStatus) ,
          style: TextStyle(fontSize: 14, color: Theme.of(context).accentColor),
        )
      ],
    );

    List<Widget> commodities = [];

    viewModel.items?.forEach((element) {
      commodities.add(Container(
          margin: const EdgeInsets.symmetric(vertical: 5),
          child: StoreOrderCommodityItem(
            viewModel: element,
          )));
    });

    Widget orderAmount =
        Row(mainAxisAlignment: MainAxisAlignment.end, children: [
      Text("共${viewModel?.commodityCount ?? '0'}件商品，合计：",
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey,
          )),
      WidgetComponents.MeonyLabel(viewModel?.totalAomunt ?? 0, scale: 1.2)
    ]);

    return Card(
        child: Container(
      margin: const EdgeInsets.fromLTRB(10, 0, 10, 10),
      child: Column(children: [
        Container(
          child: title,
        ),
        if (commodities.length > 0)
          Container(child: Column(children: commodities)),
        Container(
            alignment: Alignment.centerRight,
            child: orderAmount),
            Container(child: tailing,)
      ]),
    ));
  }
}
