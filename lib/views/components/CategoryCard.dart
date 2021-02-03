import 'package:flutter/material.dart';
import 'package:flutter_etu_remake/AppDefaultStyle.dart';
import 'package:flutter_etu_remake/WidgetComponents.dart';
import 'package:flutter_etu_remake/viewmodels/CategoryCardViewModel.dart';

//商品分类卡
class CategoryCard extends StatefulWidget {
  //类别

  final CategoryCardViewModel data;

  final CategoryCardDelegate listener;

  CategoryCard({Key key, this.data, this.listener}) : super(key: key);

  @override
  State<StatefulWidget> createState() => CategoryCardState();
}

class CategoryCardState extends State<CategoryCard> {
  List<CategoryCommodity> categoryCommodities;

  @override
  void initState() {
    super.initState();
  }

  @override
  void deactivate() {
    super.deactivate();
  }

  // ignore: unused_element
  List<Widget> _items() {
    List<Widget> list = [];

    categoryCommodities = widget.data?.commodities;

    if (categoryCommodities == null || categoryCommodities.length <= 0)
      return list;

    for (var i = 0; i < categoryCommodities.length; i++) {
      CategoryCommodity commodity = categoryCommodities[i];
      list.add(InkWell(
        child: _$CommodityGrid(commodity.title, imgUrl: commodity.image),
        onTap: () {
          int id = int.parse(commodity?.id);
          _onClickCommodity(id);
        },
      ));
    }
    return list;
  }

  Widget _$CategoryTitle() {
    return Container(
        margin:const EdgeInsets.symmetric(vertical: 5),   
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Container(
              child: Text(
            widget.data?.name ?? "",
            textAlign: TextAlign.left,
            style: TextStyle(fontSize: AppDefaultStyle.TitleFontSize, fontWeight: FontWeight.w600),
          )),
          Container(
              child: InkWell(
            child: Icon(Icons.more_vert, size:  AppDefaultStyle.TitleFontSize,color: Colors.grey,),
            onTap: () {
              int id = int.parse(widget.data?.id);
              String name =  widget.data?.name ?? "";
              _onClickCategoryMore(id,name);
            },
          )),
        ]));
  }

  Widget _$BuildContent() {
    return Container(padding:  const EdgeInsets.symmetric(horizontal:10),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(5),
          border: Border.all(color: Colors.black12)),
      child: Column(
        children: [
          _$CategoryTitle(),
          Container(
            width: double.infinity,
            margin: EdgeInsets.only(bottom: 5),
            child: Wrap(
              alignment: WrapAlignment.start,
             // runAlignment: WrapAlignment.start,
              spacing: 5,
              runSpacing: 5,
              //crossAxisAlignment: WrapCrossAlignment.,
              children: _items(),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return  _$BuildContent();
  }

  Widget _$CommodityGrid(String label,
      {String imgUrl = "",double imageSize = 60}) {
    Widget img = Container(
      child: ClipRRect(
          borderRadius: BorderRadius.circular(5),
          child: FadeInImage.assetNetwork(
              width: imageSize,
              height: imageSize,
              fit: BoxFit.fill,
              placeholder: 'assets/images/loading.gif',
              image: imgUrl)),
    );
    Widget title = Container(
        margin: EdgeInsets.all(3),
        child: Text(
          label,
          overflow: TextOverflow.ellipsis,
          maxLines: 2,
          style: TextStyle(fontSize: 10),
        ));
    return Container(
        width: imageSize,
        child: Column(children: [
          Container(child: img),
          Container(child: title),
        ]));
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _onClickCommodity(int id) {
    if (widget.listener == null) return WidgetComponents.DefaultToast("模块开发中");

    widget.listener.onPressedCommodity(id);
  }

  void _onClickCategoryMore(int id,String name) {
    if (widget.listener == null) return WidgetComponents.DefaultToast("模块开发中");
    widget.listener.onPressedMore(id,name);
  }
}

abstract class CategoryCardDelegate {
  void onPressedCommodity(int commodityId);

  void onPressedMore(int gategoryId,String gategoryName);
}
