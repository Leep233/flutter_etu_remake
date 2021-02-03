import 'package:flutter/material.dart';
import 'package:flutter_etu_remake/WidgetComponents.dart';
import 'package:flutter_etu_remake/viewmodels/PurchaseCommodityItemViewModel.dart';
import 'package:flutter_etu_remake/views/components/Counter.dart';


class PurchaseCommodityItem extends StatelessWidget{

  final double  imageSize;

    final PurchaseCommodityItemViewModel viewModel;

    final void Function(int) onCountChanged;

    PurchaseCommodityItem({Key key,@required this.viewModel,this.onCountChanged, this.imageSize=80}):super(key:key);

  @override
    Widget build(BuildContext context) {

       ///商品图片
    Widget commodityImage = ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: FadeInImage.assetNetwork(
        placeholder: "assets/images/loading.gif",
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
        Counter(
          number: viewModel?.quantity ?? 0,
          onChanged: onCountChanged,)
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

/*
class PurchaseCommodityItem extends StatefulWidget{

    final double  imageSize;

    final PurchaseCommodityItemViewModel viewModel;

    final void Function(int) onCountChanged;

    PurchaseCommodityItem({Key key,@required this.viewModel,this.onCountChanged, this.imageSize=80}):super(key:key);

    @override
    State<StatefulWidget> createState()=>PurchaseCommodityItemState(); 
}
 
class PurchaseCommodityItemState extends State<PurchaseCommodityItem>{

    @override
    void initState() {
       super.initState();
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

       ///商品图片
    Widget commodityImage = ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: FadeInImage.assetNetwork(
        placeholder: "assets/images/loading.gif",
        image: widget?.viewModel?.image ?? "",
        width: widget?.imageSize,
        height: widget?.imageSize,
      ),
    );

    ///商品标题
    Widget title = Text(
      widget.viewModel?.title ?? "",
      style: TextStyle(fontSize: 14),
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
    );

    ///商品规格
    Widget specification = Text(
      widget.viewModel?.subtitle ?? "",
      style: TextStyle(color: Colors.grey, fontSize: 12),
    );

    ///购买商品数量
    Widget buyNumberCounter = Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        WidgetComponents.MeonyLabel(widget.viewModel?.price),
        Counter(
          number: widget.viewModel?.quantity ?? 0,
          onChanged: widget.onCountChanged,)
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
*/