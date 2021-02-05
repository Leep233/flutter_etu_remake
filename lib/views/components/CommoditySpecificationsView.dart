import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_etu_remake/AppDefaultStyle.dart';
import 'package:flutter_etu_remake/WidgetComponents.dart';
import 'package:flutter_etu_remake/core/NetworkManager.dart';
import 'package:flutter_etu_remake/l10n/localization_intl.dart';
import 'package:flutter_etu_remake/viewmodels/CommoditySpecificationsViewModel.dart';
import 'package:flutter_etu_remake/views/components/CommoditySpecificationsChoice.dart';
import 'package:flutter_etu_remake/views/components/Counter.dart';

class CommoditySpecificationsView extends StatefulWidget {
  final CommoditySpecificationsViewModel data;

  final CommoditySpecificationsViewDelegate listener;

  CommoditySpecificationsView({Key key, this.data, this.listener})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => CommoditySpecificationsViewState();
}

class CommoditySpecificationsViewState
    extends State<CommoditySpecificationsView> {
  final double imageSize = 80;

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
    return Container(
      child: Column(children: [
        Container(
          margin: const EdgeInsets.symmetric(vertical:10,horizontal:10),
          child: commodityListTitle(),
        ),
      WidgetComponents.Line(),
         Container(
          margin: const EdgeInsets.symmetric(vertical:5,horizontal:10),
          child:CommoditySpecificationsChoice(
          specifications: widget.data.specifications,
          onChanged: _onSpecificationChanged,
        )),

        Container(
          margin: const EdgeInsets.symmetric(vertical:5,horizontal:10),
          child: counter(),
        ),
        Expanded(child: SizedBox()),
        Container(
          margin: const EdgeInsets.symmetric(vertical:5,horizontal:10),
          child: WidgetComponents.CommonButton(
              AppLocalizations.of(context).confirm,
              style: TextStyle(color: Colors.white),
              onPressed: _onClickSubmitBtn),
        )
      ]),
    );
  }

  Widget counter() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          child: Text(
            AppLocalizations.of(context).number,
            style: TextStyle(fontSize: AppDefaultStyle.SubtitleFontSize, fontWeight: FontWeight.w500),
          ),
        ),
        Counter(
          number: widget.data.quantity,
          onChanged: (value) {
            if (mounted) {
              setState(() {
                if(value<1) value = 1;
               
                widget.data.quantity = value;
              });
            }
          },
        )
      ],
    );
  }

  Widget commodityListTitle() {
    return Container(
      child: Row(children: [
        Container(
          margin: const EdgeInsets.only(right: 10),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: FadeInImage.assetNetwork(
              fit: BoxFit.fill,
              placeholder: "assets/images/loading.gif",
              image: widget.data.picture,
              width: imageSize,
              height: imageSize,
            ),
          ),
        ),
        Expanded(
            child: Container(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
              WidgetComponents.MeonyLabel(widget.data?.sellingPrice ?? 0,
                  originalPrice: widget.data?.originalPrice ?? 0, scale: 1.5),
              Container(
                  child: Text(
                widget.data.describe,
                maxLines: 2,
                style: TextStyle(fontSize: AppDefaultStyle.SubtitleFontSize, fontWeight: FontWeight.bold),
                overflow: TextOverflow.ellipsis,
              ))
              //  Expanded(child: Text(widget.data.describe,maxLines: 2,overflow: TextOverflow.ellipsis,))
            ])))
      ]),
    );
  }

  void _onClickSubmitBtn() {
    

    if (widget.listener == null) return;

    if((widget.data?.inventory??0) >= widget.data?.quantity){
      Navigator.pop(context);
      widget.listener.onPressedConfirm?.call(widget.data);
    }
    else{
        WidgetComponents.DefaultToast(AppLocalizations.of(context).understock(widget.data?.inventory??0));
    }  
  }

  void _onSpecificationChanged(Map<String, int> selectedSprecifications) {
    if (widget.listener == null) return;

    Map<String, String> map = {};  

    selectedSprecifications.forEach((key, value) {
      if(value>=0)
      map.putIfAbsent(key, () => widget.data.specifications[key][value]);
    });

    if(map.length < widget.data.specifications.length) return;

    widget.listener.onSpecificationChanged(map);

    NetworkManager.instance
        .commoditySpecificationPrice(widget.data.productNo, jsonEncode(map))
        .then((value) {
      if (mounted)
        setState(() {
          widget.data.commodityNo = value.commodityNo;
          widget.data.inventory = value.inventory ?? 0;
          widget.data.originalPrice = value.originalPrice;
          widget.data.sellingPrice = value.sellingPrice;
          widget.data.picture = value.picture;
          widget.data.weight = value.weight;
        });
    });
  }
}

abstract class CommoditySpecificationsViewDelegate {
  void onPressedConfirm(Object arg);
  void onSpecificationChanged(Map<String, String> specification);
}
