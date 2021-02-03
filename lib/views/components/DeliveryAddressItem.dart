import 'package:flutter/material.dart';
import 'package:flutter_etu_remake/WidgetComponents.dart';
import 'package:flutter_etu_remake/l10n/localization_intl.dart';
import 'package:flutter_etu_remake/viewmodels/DeliveryAddressItemViewModel.dart';

class DeliveryAddressItem extends StatefulWidget {
  final DeliveryAddressItemViewModel data;
  final bool showLeading;
  final void Function() onEidt;
  final void Function() onPressed;
  final double leadingSize;
  final EdgeInsetsGeometry padding;
  final BorderRadius borderRadius;

  DeliveryAddressItem({Key key,@required this.data,this.showLeading = false ,this.borderRadius ,this.leadingSize=24,this.padding =const EdgeInsets.all(0), this.onEidt, this.onPressed})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => DeliveryAddressItemState();
}

class DeliveryAddressItemState extends State<DeliveryAddressItem> {
  TextStyle get style01 => TextStyle(fontSize: 16, color: Colors.black);
  TextStyle get style02 => TextStyle(fontSize: 13, color: Colors.grey);
  TextStyle get style03 => TextStyle(fontSize: 14, color: Colors.grey);

  String get kSPACE => "        ";

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
    return Card(
      shape:widget.borderRadius!=null? RoundedRectangleBorder(borderRadius:widget.borderRadius):RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      child: _$CardContent());
  }

  Widget _$CardContent() {
    Widget icon = widget.showLeading == true
        ? Container(
            margin: const EdgeInsets.all(5),
            child: Icon(
              Icons.location_on_sharp,
              color: Colors.deepOrange,
              size:widget.leadingSize,
            ))
        : SizedBox();

    Widget title = RichText(
        text: TextSpan(
            text: widget.data?.name ?? "",
            style: style01,
            children: [
          TextSpan(text: ' ${widget.data?.phone ?? ""}', style: style02)
        ]));

    Widget address = Stack(
      children: [
        Text(
          "${widget.data?.isDefault == true ? kSPACE : ""}${widget.data?.address ?? ""}",
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: style03,
        ),
        if (widget.data?.isDefault==true)
          Positioned(
              left: 0,
              top: 2,
              child: WidgetComponents.Tips(
                  AppLocalizations.of(context).defaultText,
                  style: TextStyle(fontSize: 9, color: Colors.redAccent),
                  borderColor: Colors.red)),
      ],
    );

    return FlatButton(
        onPressed: widget.onPressed,
        padding: widget.padding,
        child: Container(
            margin: const EdgeInsets.all(5),
            child: Row(children: [
              icon,
              Expanded(
                  child: Container(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      title,
                      Container(
                          margin: const EdgeInsets.symmetric(vertical: 5),
                          child: address)
                    ]),
              )),
              if (widget.onEidt != null)
                TextButton(
                    onPressed: widget.onEidt,
                    child: Text(AppLocalizations.of(context).edit))
            ])));
  }
}
