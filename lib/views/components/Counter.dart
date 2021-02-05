import 'package:flutter/material.dart';

// ignore: must_be_immutable
class Counter extends StatefulWidget {
  static const int kMaxValue = 999;

  static const int kMinValue = 0;

  final double buttonSize;

  final int number;

  final void Function(int) onChanged;

  Counter({Key key, this.number = 0, this.onChanged, this.buttonSize = 16})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => CounterState();
}

class CounterState extends State<Counter> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void deactivate() {
    super.deactivate();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
            margin: EdgeInsets.all(1),
            decoration: _boxDecoration,
            width: widget.buttonSize,
            height: widget.buttonSize,
            child: _$CountButton(1)),
        Container(
            width: 20,
            margin: EdgeInsets.all(1),
            child: Text(
              "${widget.number}",
              style: TextStyle(fontSize: 14, color: Colors.grey),
              textAlign: TextAlign.center,
            )),
        Container(
            margin: EdgeInsets.all(1),
            decoration: _boxDecoration,
            width: widget.buttonSize,
            height: widget.buttonSize,
            child: _$CountButton(0)),
      ],
    );
  }

  BoxDecoration get _boxDecoration => BoxDecoration(
      border: Border.all(color: Colors.grey),
      borderRadius: BorderRadius.circular(3));

  ///计数按钮 0:加 1：减
  Widget _$CountButton(int type, {double iconSize = 12}) {
    bool isAdd = type == 0;

    return InkWell(
        child: isAdd
            ? Icon(Icons.add, size: iconSize)
            : Icon(Icons.remove, size: iconSize),
        onTap: isAdd
            ? () {
                if (widget.number < Counter.kMaxValue)
                  widget.onChanged?.call(widget.number + 1);
              }
            : () {
                if (widget.number > Counter.kMinValue)
                  widget.onChanged?.call(widget.number - 1);
              });
  }

  @override
  void dispose() {
    super.dispose();
  }
}
