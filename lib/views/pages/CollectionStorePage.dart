import 'package:flutter/material.dart';
import 'package:flutter_etu_remake/Debug.dart';
import 'package:flutter_etu_remake/core/NetworkManager.dart';
import 'package:flutter_etu_remake/core/UIManager.dart';
import 'package:flutter_etu_remake/viewmodels/CollectionStoreCardViewModel.dart';
import 'package:flutter_etu_remake/views/components/RefreshListView.dart';

class CollectionStorePage extends StatefulWidget {
  CollectionStorePage({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => CollectionStorePageState();
}

class CollectionStorePageState extends State<CollectionStorePage>
    implements RefreshListViewDeleagate, CollectionStoreCardDelegate {
  List<CollectionStoreCardViewModel> stores;

  int _currentPageNum = 0;

  @override
  void initState() {
    super.initState();
    onRefreshPull();
  }

  _$RefreshUI() {
    if (mounted) setState(() {});
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
              onPressed: () => Navigator.pop(context)),
        ),
        body: _$BodyContentBuilder(context));
  }

  Widget _$BodyContentBuilder(BuildContext context) {
    return Container(
      child: MediaQuery.removePadding(
        removeTop: true,
        context: context,
        child: RefreshListView(
          itemBuilder: (context, index) => CollectionStoreCard(
            data: stores[index],
            listener: this,
          ),
          itemCount: stores?.length ?? 0,
          listener: this,
        ),
      ),
    );
  }

  @override
  Future onRefreshDropdown() {
    return NetworkManager.instance
        .collectStores(pageNum: ++_currentPageNum)
        .then((value) {
      if (value == null) return;
      stores = value
          ?.map((e) => CollectionStoreCardViewModel.transform(e))
          ?.toList();

      _$RefreshUI();
    });
  }

  @override
  Future onRefreshPull() {
    _currentPageNum = 1;
    return NetworkManager.instance
        .collectStores(pageNum: _currentPageNum)
        .then((value) {
      if (value == null) return;
      stores = value
          ?.map((e) => CollectionStoreCardViewModel.transform(e))
          ?.toList();

      _$RefreshUI();
    });
  }

  @override
  void onCancel(String storeid) {
    Debug.log(storeid);
    NetworkManager.instance
        .collection(type: 1, merchantId: storeid)
        .then((value) => onRefreshPull());
  }

  @override
  void onClickCommodity(String commodityId) {
    Debug.log(commodityId);
    UIManager.instance
        .toPage(context, UIDef.commodityDetail, arguments: commodityId);
  }
}

// ignore: unused_element
class CollectionStoreCard extends StatelessWidget {
  final double imageSize;

  final CollectionStoreCardViewModel data;

  final CollectionStoreCardDelegate listener;

  CollectionStoreCard(
      {@required this.data, this.listener, this.imageSize = 60});

  @override
  Widget build(BuildContext context) {
    List<Widget> imgs = [];

    for (var i = 0; i < data?.images?.length; i++) {
      imgs.add(Container(
        margin: EdgeInsets.all(8),
        width: imageSize,
        height: imageSize,
        child: FlatButton(
          padding: const EdgeInsets.all(0),
          child: ClipRRect(
              borderRadius: BorderRadius.circular(5),
              child: FadeInImage.assetNetwork(
                  fit: BoxFit.fill,
                  placeholder: "assets/images/loading.gif",
                  image: data?.images[i] ?? "")),
          onPressed: () {
            listener?.onClickCommodity(data.commodityIds[i]);
          },
        ),
      ));
    }

    return Card(
      child: Container(
          margin: EdgeInsets.fromLTRB(5, 0, 5, 10),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                    child: ListTile(
                  trailing: TextButton(
                    child: Text("取消关注"),
                    onPressed: () {
                      listener?.onCancel(data.storeId);
                    },
                  ),
                  leading: ClipOval(
                      child: FadeInImage.assetNetwork(
                          fit: BoxFit.fill,
                          width: 55,
                          height: 55,
                          placeholder: "assets/images/loading.gif",
                          image: data?.profile ?? "")),
                  title: Container(
                    child: Text(data?.title ?? ""),
                  ),
                  subtitle: Container(
                    child: Text("${data?.subtitle}天前关注"),
                  ),
                )),
                Container(
                    child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: imgs,
                ))
              ])),
    );
  }
}

abstract class CollectionStoreCardDelegate {
  void onCancel(String storeid);
  void onClickCommodity(String commodityId);
}
