import 'package:flutter/material.dart';
import 'package:flutter_etu_remake/WidgetComponents.dart';
import 'package:flutter_etu_remake/viewmodels/OrderDetailCommodityCardViewModel.dart';
import 'package:flutter_etu_remake/views/components/StoreOrderCommodityItem.dart';

// ignore: must_be_immutable
class OrderDetailCommodityCard extends StatelessWidget{

final OrderDetialCommodityCardViewModel data;
 
OrderDetailCommodityCard({this.data});

 @override
Widget build(BuildContext context) {
      Widget title = FlatButton(
            padding: EdgeInsets.all(0),
            onPressed: null,
            child: Row(
              children: [
                Text(
                  data?.storeName,
                  style: TextStyle(fontSize: 15, color: Colors.black),
                ),
                Icon(
                  Icons.chevron_right,
                  color: Colors.grey,
                )
              ],
            ));
    

    List<Widget> commodities = [];

    data.items?.forEach((element) {
      commodities.add(Container(
          margin: const EdgeInsets.symmetric(vertical: 5),
          child: StoreOrderCommodityItem(
            viewModel: element,
          )));
    });

/*
    Widget orderAmount =
        Row(mainAxisAlignment: MainAxisAlignment.end, children: [
      Text("共${viewModel?.commodityCount ?? '0'}件商品，合计：",
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey,
          )),
      WidgetComponents.MeonyLabel(viewModel?.totalAomunt ?? 0, scale: 1.2)
    ]);
*/
    return 
        Container(
      margin: const EdgeInsets.fromLTRB(10, 0, 10, 10),
      child: Column(children: [
        Container(
          child: title,
        ),
        if (commodities.length > 0)
          Container(child: Column(children: commodities)),
          /*
        Container(
            alignment: Alignment.centerRight,
            child: orderAmount),
            Container(child: tailing,)*/
      ]),
    );
  }
}