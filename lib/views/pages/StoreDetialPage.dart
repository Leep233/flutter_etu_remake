import 'package:flutter/material.dart';
import 'package:flutter_etu_remake/AppDefaultStyle.dart';
import 'package:flutter_etu_remake/WidgetComponents.dart';
import 'package:flutter_etu_remake/core/NetworkManager.dart';
import 'package:flutter_etu_remake/core/UIManager.dart';
import 'package:flutter_etu_remake/l10n/localization_intl.dart';
import 'package:flutter_etu_remake/viewmodels/StoreDetialPageViewModel.dart';
import 'package:flutter_etu_remake/views/components/CommodityCard.dart';
import 'package:flutter_etu_remake/views/components/RefreshListView.dart';
import 'package:flutter_etu_remake/views/components/ShareCard.dart';

///店铺详情页
class StoreDetialPage extends StatefulWidget {
  StoreDetialPage({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => StoreDetialPageState();
}

class StoreDetialPageState extends State<StoreDetialPage>
    implements CommodityCardDelegate, RefreshListViewDeleagate ,ShareCardDelegate{
  StoreDetialPageViewModel _viewModel;

  String _storeId;

  final TextEditingController searchController = TextEditingController();

  String _searchContent;

  int _currentPageNumber;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _storeId = ModalRoute.of(context).settings.arguments?.toString();

      print("商铺ID：$_storeId");

      onRefreshPull();
    });
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
    Size screen = MediaQuery.of(context).size;

    return Scaffold(
      extendBodyBehindAppBar: true,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        leadingWidth: 25,
        leading: IconButton(
            icon: Icon(Icons.chevron_left, color: Colors.white70),
            onPressed: () {
              Navigator.pop(context);
            }),
        title: Text(_viewModel?.title ?? ""),
        actions: [
          IconButton(
              icon: Icon(Icons.headset_mic),
              onPressed: _onClickCustomerService),
          IconButton(
              icon: Icon(
                Icons.favorite,
                color:
                    _viewModel?.isMark == true ? Colors.orange : Colors.white,
              ),
              onPressed: _onClickFavorite),
          IconButton(icon: Icon(Icons.share), onPressed: _onClickShare),
        ],
      ),
      body: Container(
          width: screen.width,
          height: screen.height,
          decoration: AppDefaultStyle.BGConstraint(),
          child: _$BuildContent(context)),
    );
  }

  TextStyle get style01 => TextStyle(fontSize: 15, color: Colors.white);

  _$BuildContent(BuildContext context) {
    int starNumber = _viewModel?.starlevel?.toInt() ?? 0;

    List<Widget> stars = [];

    for (var i = 0; i < starNumber; i++) {
      stars.add(Container(
          margin: const EdgeInsets.only(right: 3),
          child: Icon(Icons.star_border_sharp, color: Colors.white)));
    }

    Widget starBarLabel =
        Row(crossAxisAlignment: CrossAxisAlignment.end, children: [
      Row(children: stars),
      Text(AppLocalizations.of(context).funs(_viewModel?.funsNumber ?? 0),
          style: style01)
    ]);

    Widget searchLabel = Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
            child: WidgetComponents.SearchFeild(
                hintText: AppLocalizations.of(context).searchContent,
                controller: searchController,
                onPressedSearch: _onClickSearch)),
        IconButton(
            icon: Icon(
              Icons.reorder,
              size: 28,
              color: Colors.white,
            ),
            onPressed: _onClickSearch)
      ],
    );

    return Container(
        margin: const EdgeInsets.fromLTRB(10, 70, 10, 0),
        child: Column(children: [
          Container(
            child: starBarLabel,
            margin: const EdgeInsets.symmetric(horizontal: 30),
          ),
          Container(
            margin: const EdgeInsets.fromLTRB(10, 10, 0, 10),
            child: searchLabel,
          ),
          Expanded(
              child: MediaQuery.removePadding(
                  removeTop: true,
                  context: context,
                  child: Container(
                      child: RefreshListView(
                    listener: this,
                    itemBuilder: (content, index) => CommodityCard(
                      sourceData: _viewModel?.commodities[index],
                    ),
                    itemCount: _viewModel?.commodities?.length ?? 0,
                  ))))
        ]));
  }

  void _onClickCustomerService() {}

  void _onClickFavorite() {
    NetworkManager.instance
        .collection(type: 1, merchantId: _viewModel.storeId)
        .then((value) {
      _viewModel.isMark = value == 1;
        _$RefreshUI();
    });
  }

  void _onClickShare()async {

      await showModalBottomSheet(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadiusDirectional.circular(3)), //加圆角
        context: context,
        builder: (_) => Container(
            height: MediaQuery.of(context).size.height * 0.35,
            child: ShareCard(
              listener: this,
            )));

  }

  void _onClickSearch() {
    _searchContent = searchController.text;
    onRefreshPull();
  }

  @override
  void onPressedCommodity(String commodityId) {
    UIManager.instance
        .toPage(context, UIDef.commodityDetail, arguments: commodityId);
  }

  @override
  void onPressedStore(String storeId) {
    // UIManager.instance.toPage(context, UIDef.storeDetial, arguments: storeId);
  }

  @override
  Future onRefreshDropdown() {
    return NetworkManager.instance
        .storeDetial(
            pageNum: ++_currentPageNumber,
            content: _searchContent?.isNotEmpty ?? _searchContent,
            merchantId: _storeId == null ? null : int.parse(_storeId))
        .then((value) {
      _viewModel?.commodities
          ?.addAll(StoreDetialPageViewModel.transform(value).commodities);
      _$RefreshUI();
    });
  }

  @override
  Future onRefreshPull() {
    _currentPageNumber = 1;

    return NetworkManager.instance
        .storeDetial(
            pageNum: _currentPageNumber,
            content: _searchContent?.isNotEmpty ?? _searchContent,
            merchantId: _storeId == null ? null : int.parse(_storeId))
        .then((value) {
      _viewModel = StoreDetialPageViewModel.transform(value);
      _$RefreshUI();
    });
  }

  @override
  onShareCopyLink() {
    // TODO: implement onShareCopyLink
    throw UnimplementedError();
  }

  @override
  onShareFriends() {
    // TODO: implement onShareFriends
    throw UnimplementedError();
  }

  @override
  onShareGenerateImage() {
    // TODO: implement onShareGenerateImage
    throw UnimplementedError();
  }

  @override
  onShareQQ() {
    // TODO: implement onShareQQ
    throw UnimplementedError();
  }

  @override
  onShareWechat() {
    // TODO: implement onShareWechat
    throw UnimplementedError();
  }
}
