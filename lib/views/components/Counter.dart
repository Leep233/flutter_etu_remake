import 'package:flutter/material.dart';

// ignore: must_be_immutable
class Counter extends StatefulWidget {
  static const int kMaxValue = 999;

  static const int kMinValue = 0;

  final int number;

  final void Function(int) onChanged;

  Counter({Key key, this.number = 0, this.onChanged}) : super(key: key);

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
        Container(margin: EdgeInsets.all(1),decoration:_boxDecoration,width: 20,height: 20,child: subButton()),
        Container(width: 20,margin: EdgeInsets.all(1),child: Text("${widget.number}",textAlign: TextAlign.center,)),
        Container(margin: EdgeInsets.all(1),decoration:_boxDecoration,width: 20,height: 20,child: addButton()),
      ],
    );
  }

  BoxDecoration get _boxDecoration=> BoxDecoration(border:Border.all(color:Colors.grey),borderRadius: BorderRadius.circular(3));

  Widget addButton() {

    return IconButton(iconSize: 10,padding: const EdgeInsets.all(3),
      icon: Icon(Icons.add,size: 12,),
      onPressed:(){ if (widget.number < Counter.kMaxValue) widget.onChanged?.call(widget.number+1);}    
    );
  
  }

  Widget subButton() {
    return IconButton(iconSize: 10,padding: const EdgeInsets.all(3),
      icon: Icon(Icons.remove,size: 12,),
      onPressed:(){ if(widget.number > Counter.kMinValue) widget.onChanged?.call( widget.number-1); }
    );
  } 

  @override
  void dispose() {
    super.dispose();
  }
}
