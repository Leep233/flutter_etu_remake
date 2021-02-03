import 'package:flutter/material.dart';

class TabBarExtend<T> extends StatefulWidget {

  final List<Widget> tabs;
   final List<Widget> selectedTabs;
  final List<T> values;
  final void Function(int, T) onTab;

  int initIndex;

  List<bool> selectedStatus;

  TabBarExtend(
      {Key key,
      @required this.tabs,
      this.selectedTabs,
      this.values,
      this.onTab,
      this.initIndex = 0})
      : super(key: key) {

print(initIndex);
 
  selectedStatus = [];
    for (var i = 0; i < tabs?.length; i++) {
      selectedStatus.add(initIndex==i);
    }


  }

  @override
  State<StatefulWidget> createState() => TabBarExtendState<T>();
}

class TabBarExtendState<T> extends State<TabBarExtend<T>> {

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

       // _lastIndex = widget.initIndex;

    Widget content = Container(
      child: ListView.builder(
          itemBuilder: tabBarBuidler, itemCount: widget.tabs.length),
    );
    return content;
  }

  Widget tabBarBuidler(BuildContext context, int index) {

    //print(index);

    Widget text = widget.tabs[index];
    Widget text2 = widget.selectedTabs[index];
    T target = null;

    try {
      target = widget?.values[index];
    } catch (e) {
      print(e);
    }

     // print(widget.selectedStatus);

    return Container(
        height: 35,
        child: TabExtend(
          title: text,
          selectedTitle:text2 ,
          isSelected: widget.selectedStatus[index],
          value: 2,
          onPressed: (selected, e) {
            setState(() {
              if (widget.initIndex >= 0) 
              widget.selectedStatus[widget.initIndex] = false;
               widget.selectedStatus[index] = selected;
              widget?.onTab?.call(index, target);
            });
          },
        ));
  }

  @override
  void dispose() {
    super.dispose();
  }
}



// ignore: must_be_immutable
class TabExtend<T> extends StatefulWidget {
  final Color lineColor;

  final Color unselectedLineColor;

  final double lineSize;

  final Widget title;

  final Widget selectedTitle;

  final void Function(bool, T) onPressed;

  final T value;

  bool isSelected;

  TabExtend(
      {Key key,
      @required this.title,
      this.selectedTitle,
      this.value,
      this.onPressed,
      this.isSelected = false,
      this.lineColor = Colors.red,
      this.lineSize = 1.0,
      this.unselectedLineColor = Colors.transparent})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => TabExtendState<T>();
}

class TabExtendState<T> extends State<TabExtend<T>> {
  Color _unselected = Colors.transparent;
  Color _selected = Colors.white;

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
    Color color;
    Color bgColor;
    Widget child;
    if (widget.isSelected) {
      color = widget.lineColor;
      bgColor = _selected;
      child = widget.selectedTitle;
    } else {
      color = widget.unselectedLineColor;
      bgColor = _unselected;
      child = widget.title;
    }

    Widget content = Container(      
      margin: EdgeInsets.all(3),
      padding: EdgeInsets.all(3),
      child: GestureDetector(
        child:Container(child:child,margin: EdgeInsets.only(left:5),) ,
        onTap: () {
          setState(() {
            widget.isSelected = !widget.isSelected;
            widget?.onPressed?.call(widget.isSelected, widget.value);
          });
        },
      ),
     
      decoration: BoxDecoration(
          color: bgColor,
          border:
              Border(left: BorderSide(color: color, width: widget.lineSize))),
    );

    return content;
  }

  @override
  void dispose() {
    super.dispose();
  }
}
