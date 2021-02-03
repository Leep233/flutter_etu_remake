import 'package:flutter/material.dart';
import 'package:flutter_etu_remake/AppDefaultStyle.dart';
import 'package:flutter_etu_remake/WidgetComponents.dart';
import 'package:flutter_etu_remake/viewmodels/StoreOrderCommodityItemViewModel.dart';
class StoreOrderCommodityItem extends StatelessWidget{

final double imageSize;

final StoreOrderCommodityItemViewModel viewModel;

StoreOrderCommodityItem({@required this.viewModel,this.imageSize=70});

  @override
    Widget build(BuildContext context) {

       ///商品图片
    Widget commodityImage = ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: FadeInImage.assetNetwork(
        placeholder: AppDefaultStyle.Loading,
        image: viewModel?.image ?? "",
        width: imageSize,
        height: imageSize,
      ),
    );

    ///商品标题
    Widget title = Text(
      viewModel?.title ?? "",
      style: TextStyle(fontSize: 14),
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
    );

    ///商品规格
    Widget specification = Text(
     viewModel?.subtitle ?? "",
      style: TextStyle(color: Colors.grey, fontSize: 12),
    );

    ///购买商品数量
    Widget buyNumberCounter = Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        WidgetComponents.MeonyLabel(viewModel?.price),
       Text("x ${viewModel?.quantity??'0'}")
      ],
    );

      return   Row(children: [
         Container(
          margin: const EdgeInsets.only(left: 5, right: 10),
          child: commodityImage),
      Expanded(
          child: Container(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                child: title,
              ),
              Container(
                child: specification,
              ),
              Container(
                child: buyNumberCounter,
              ),
            ]),
      ))
      ],)  ;
    }
}