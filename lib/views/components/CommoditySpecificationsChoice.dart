import 'package:flutter/material.dart';
import 'package:flutter_etu_remake/AppDefaultStyle.dart';
import 'package:flutter_etu_remake/views/components/RadioGroup.dart';

///商品规格选择
class CommoditySpecificationsChoice extends StatefulWidget {
  ///规格 如 {"尺码":['s','m','l'],"颜色":['红','白','黑']}
  final Map<String, List<String>> specifications;

  final void Function(Map<String, int>) onChanged;

  CommoditySpecificationsChoice(
      {Key key, @required this.specifications, this.onChanged})
      : super(key: key) {}

  @override
  State<StatefulWidget> createState() => CommoditySpecificationsChoiceState();
}

class CommoditySpecificationsChoiceState
    extends State<CommoditySpecificationsChoice> {
  Map<String, int> selected = {};
  @override
  void initState() {
    super.initState();
    selected.clear();


    widget.specifications.forEach((key, value) {
      selected.putIfAbsent(key, () => -1);
    });

    widget?.onChanged?.call(selected);
  
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
    return Container(child: _$ItemBuilder());
  }

  Widget _$ItemBuilder() {
    List<Widget> childs = [];

    widget.specifications.forEach((key, value) {
      childs.add(_$SpecificationItem(value,
          title: Container(
              margin: const EdgeInsets.symmetric(vertical: 5),
              child: Text(
                key,
                style: TextStyle(
                    fontSize: AppDefaultStyle.SubtitleFontSize,
                    fontWeight: FontWeight.w500),
              )),
          value: selected[key], onChanged: (index) {
        if (mounted) {
          setState(() {
            selected[key] = index;
            widget?.onChanged?.call(selected);
          });
        }
      }));
    });
    return Column(children: childs);
  }

  Widget _$SpecificationItem(List<String> specifications,
      {Widget title, int value, void Function(int) onChanged}) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      title,
      RadioGroup(
          value: value,
          fontSize: 12,
          selection: specifications,
          onChanged: onChanged)
    ]);
  }
}
