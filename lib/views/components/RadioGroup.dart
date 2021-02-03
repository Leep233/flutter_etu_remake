// ignore: must_be_immutable
import 'package:flutter/material.dart';
import 'package:flutter_etu_remake/WidgetComponents.dart';
import 'package:flutter_etu_remake/views/components/SelectorWidget.dart';


// ignore: must_be_immutable
class RadioGroup extends StatefulWidget {

  final List<dynamic> selection;

  final int value;

  final double fontSize;

  final void Function(int) onChanged;

  RadioGroup({
    Key key,   
    this.fontSize=14,
    this.selection,
     this.value = 0,
    this.onChanged,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => RadioGroupState();
}

class RadioGroupState extends State<RadioGroup> {

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

  Widget _selectedWidget(String title) {
    return WidgetComponents.Tips(title,padding: const EdgeInsets.symmetric(vertical: 0.5,horizontal: 3),minWidth: 50,borderRadius: 5,
        borderColor: Colors.deepOrangeAccent,bgColor: Colors.grey[100],
        style: TextStyle(fontSize: widget?.fontSize, color: Colors.deepOrangeAccent));
  }

  Widget _unselectedWidget(String title) {
    return WidgetComponents.Tips(title,padding: const EdgeInsets.symmetric(vertical: 0.5,horizontal: 3),minWidth: 50,borderRadius: 5,
        borderColor: Colors.grey,bgColor: Colors.grey[100],
        style: TextStyle(fontSize: widget?.fontSize, color: Colors.grey));
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> list = [];

    for (var i = 0; i < widget.selection?.length; i++) {
      String element = widget.selection[i];

      Widget child = Container(
        child: SelectorWidget(
          groupValue: element,
          value:widget.selection[widget.value] ,
          onChanged: (value) {    
            widget.onChanged?.call(i); 
          },
          selected: _selectedWidget(element),
          unselected: _unselectedWidget(element),
        ),
        margin: EdgeInsets.fromLTRB(0, 0, 5, 0),
      );

      list.add(child);
    }
    return Container(
      child:Row(children: list,),
    );
  }
}
