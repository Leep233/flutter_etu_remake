import 'package:flutter/material.dart';



//一个选择变动的widget
// ignore: must_be_immutable
class SelectorWidget<T> extends StatefulWidget{

    final Widget selected;

    final Widget unselected;

    final void Function(T) onChanged;

   final T groupValue;

   final T value;

    SelectorWidget({Key key,this.selected,@required this.value,this.unselected,@required this.groupValue,this.onChanged}):super(key:key);

    @override
    State<StatefulWidget> createState()=>SelectorWidgetState(); 
}
 
class SelectorWidgetState<T> extends State<SelectorWidget<T>>{

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

      Widget  target = widget.groupValue==widget.value?widget.selected:widget.unselected;

      return  GestureDetector(child:Container(child: target),onTap: (){
        widget.onChanged?.call(widget.value);
      },) ;
    }

    @override
    void dispose() {
          super.dispose();
    }
}