import 'package:flutter/material.dart';
import 'package:flutter_etu_remake/core/NetworkManager.dart';
import 'package:flutter_etu_remake/core/UIManager.dart';
import 'package:flutter_etu_remake/viewmodels/CollectionCommodityCardViewModel.dart';
import 'package:flutter_etu_remake/views/components/CollectionCommodityCard.dart';
import 'package:flutter_etu_remake/views/components/RefreshListView.dart';

class CollectionCommodityPage extends StatefulWidget {

  CollectionCommodityPage({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => CollectionCommodityPageState();
}

class CollectionCommodityPageState extends State<CollectionCommodityPage> implements RefreshListViewDeleagate ,CollectionCommodityCardDelegate{

  List<CollectionCommodityCardViewModel> _commodites;

  int _currentPageNum = 0;

  final int kPageSize = 20;

  @override
  void initState() {
    super.initState();
    onRefreshPull();
  }

  void _$RefreshUI(){
    if(mounted)setState(() {
      
    });
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
    return Scaffold(
        appBar: AppBar(
          elevation: 0.1,
          backgroundColor: Colors.white,
          centerTitle: true,
          title: Text(
            '我的收藏',
            style: TextStyle(color: Colors.black),
          ),
          leading: IconButton(
            icon: Icon(Icons.chevron_left, color: Colors.black),
            onPressed: () => Navigator.pop(context)
          ),
        ),
        body: _$BodyContentBuilder(context));
  }

 Widget _$BodyContentBuilder(BuildContext context) {
   return Container(child: MediaQuery.removePadding(
          removeTop: true,
          context: context,
          child: RefreshListView(
            itemBuilder: (context, index) => CollectionCommodityCard(
              sourceData: _commodites[index],
              listener: this,
            ),
            itemCount: _commodites?.length??0,
            listener: this,
          ),
        ),);
 }

  @override
  Future onRefreshDropdown() {

     return  NetworkManager.instance.collectionCommodities(pageNum: ++_currentPageNum,pageSize:kPageSize ).then((value){
        if(value == null) return;

          value.forEach((element) {
            _commodites?.add( CollectionCommodityCardViewModel.transform(element));
          });

        _$RefreshUI();
    });

   
  }

  @override
  Future onRefreshPull() {

    _currentPageNum = 1;

     return  NetworkManager.instance.collectionCommodities(pageNum: _currentPageNum,pageSize:kPageSize ).then((value){
        if(value == null) return;

        _commodites = value.map((e) => CollectionCommodityCardViewModel.transform(e))?.toList();

        _$RefreshUI();
    });
  }

  @override
  void onPressedCommodity(String id) {
     UIManager.instance
        .toPage(context, UIDef.commodityDetail, arguments: id);
    } 
  

  @override
  void onPressedCancel(String id) {
    NetworkManager.instance.collection(type: 0,productNo:id).then((value){
        onRefreshPull();
    });
  }
}
