import 'package:flutter/material.dart';

//可刷新的ListView
// ignore: must_be_immutable
class RefreshListView extends StatefulWidget {

  final IndexedWidgetBuilder itemBuilder;

  final int itemCount;

  RefreshListViewDeleagate listener;

  RefreshListView(
      {Key key,
      @required this.itemBuilder,
      this.itemCount = 0,
      this.listener,})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => RefreshListViewState();
}

class RefreshListViewState extends State<RefreshListView> {


  final ScrollController _scrollController =
      new ScrollController(); // 初始化滚动监听器，加载更多使用

  @override
  void initState() {
    super.initState();
 
    _scrollController.addListener(_onRefreshDropdown);
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
    return RefreshIndicator(
        onRefresh: _onRefreshPull,
        child: Container(
            child:             
            ListView.builder(addRepaintBoundaries: false,addAutomaticKeepAlives: false,
          controller: _scrollController,
          itemBuilder: widget.itemBuilder,
          physics: AlwaysScrollableScrollPhysics(),
          itemCount: widget.itemCount??0,
        )));
  }

  Future<void> _onRefreshPull() async {
  
    try {
      await widget.listener?.onRefreshPull();
    } catch (e) {}

   
  }

  Future<void> _onRefreshDropdown() async { 

    if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
      try {
        await widget.listener?.onRefreshDropdown();
      } catch (e) {}
     
    }
  }
}


abstract class RefreshListViewDeleagate
{
 Future onRefreshPull();
 Future onRefreshDropdown();
}
