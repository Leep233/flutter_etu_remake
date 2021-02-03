import 'package:flutter/material.dart';
import 'package:flutter_etu_remake/AppDefaultStyle.dart';
import 'package:flutter_etu_remake/core/NetworkManager.dart';
import 'package:flutter_etu_remake/Debug.dart';
import 'package:flutter_etu_remake/viewmodels/CommodityCardViewModel.dart';
import 'package:flutter_etu_remake/views/components/CommodityCard.dart';
import 'package:flutter_etu_remake/views/components/RefreshListView.dart';
import 'package:flutter_etu_remake/core/UIManager.dart';
import 'package:flutter_etu_remake/l10n/localization_intl.dart';
import 'package:flutter_etu_remake/WidgetComponents.dart';

///分类商品列表页面
class CategoryCommodityPage extends StatefulWidget {
  CategoryCommodityPage({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => CategoryCommodityPageState();
}

class CategoryCommodityPageState extends State<CategoryCommodityPage>
    implements RefreshListViewDeleagate, CommodityCardDelegate {
  TextStyle selectedStyle =
      TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.w500);

  TextStyle unselectedStyle = TextStyle(color: Colors.black);

  TextEditingController _controller = TextEditingController();

  List<CommodityCardViewModel> _commodites = [];

  int queryConditionIndex = 0;

  final int kPageSize = 10;

  bool _updating;

  ///
  int _currentPageNumber = 0;

  String gategoryName;

  int gategoryId;

  @override
  void initState() {
    super.initState();
    _updating = false;
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Map map = ModalRoute.of(context).settings.arguments as Map;

      Debug.log("CategoryCommodityPage $map");

      if (map == null) return;
      gategoryName = map['name'];
      gategoryId = map['id'];

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
        centerTitle: true,
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        title: Text(gategoryName ?? ""),
      ),
      body: Container(
          width: screen.width,
          height: screen.height,
          decoration: AppDefaultStyle.BGConstraint(),
          child: _$BuildContent(context)),
    );
    ;
  }

  ///查询条件
  Widget _$QueryConditionsBar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        DropdownButton(
            underline: SizedBox(),
            elevation: 0,
            iconEnabledColor: Colors.white,
            value: queryConditionIndex,
            items: [
              DropdownMenuItem(
                child: Text(
                  AppLocalizations.of(context).comprehensiveSort,
                  style: unselectedStyle,
                ),
                value: 0,
              ),
              DropdownMenuItem(
                  child: Text(
                    AppLocalizations.of(context).creditSort,
                    style: unselectedStyle,
                  ),
                  value: 1),
              DropdownMenuItem(
                  child: Text(
                    AppLocalizations.of(context).descendSort,
                    style: unselectedStyle,
                  ),
                  value: 2),
              DropdownMenuItem(
                  child: Text(
                    AppLocalizations.of(context).ascendSort,
                    style: unselectedStyle,
                  ),
                  value: 3),
            ],
            selectedItemBuilder: (context) => [
                  DropdownMenuItem(
                    child: Text(
                      AppLocalizations.of(context).comprehensiveSort,
                      style: selectedStyle,
                    ),
                    value: 0,
                  ),
                  DropdownMenuItem(
                      child: Text(AppLocalizations.of(context).creditSort,
                          style: selectedStyle),
                      value: 1),
                  DropdownMenuItem(
                      child: Text(AppLocalizations.of(context).descendSort,
                          style: selectedStyle),
                      value: 2),
                  DropdownMenuItem(
                      child: Text(AppLocalizations.of(context).ascendSort,
                          style: selectedStyle),
                      value: 3),
                ],
            onChanged: (index) {
              setState(() {
                queryConditionIndex = index;
              });
            }),
        TextButton(
            onPressed: _onClickSaleSort,
            child: Text(
              AppLocalizations.of(context).salesVolume,
              style: TextStyle(color: Colors.white),
            )),
        TextButton(
            onPressed: _onClickSaleSort,
            child: Text(
              AppLocalizations.of(context).price,
              style: TextStyle(color: Colors.white),
            )),
        TextButton(
            onPressed: _onClickFiltrate,
            child: Text(
              AppLocalizations.of(context).filtrate,
              style: TextStyle(color: Colors.white),
            ))
      ],
    );
  }

  Widget _$BuildContent(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border(top: BorderSide(color: Colors.white, width: 0.2))),
      margin: EdgeInsets.only(top: 80),
      child: Column(children: [
        Container(
          margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          child: WidgetComponents.SearchFeild(
              controller: _controller,
              hintText: AppLocalizations.of(context).searchContent,
              onPressedSearch: _onClickSearch),
        ),
        Container(child: _$QueryConditionsBar()),
        Expanded(
            child: MediaQuery.removePadding(
          removeTop: true,
          context: context,
          child: RefreshListView(
            itemBuilder: (context, index) => CommodityCard(
              sourceData: _commodites[index],
              listener: this,
            ),
            itemCount: _commodites.length,
            listener: this,
          ),
        ))
      ]),
    );
  }

  void _onClickSaleSort() {}

  void _onClickSearch() {}

  @override
  Future onRefreshDropdown() {
    if (_updating) return null;

    _updating = true;

    return NetworkManager.instance
        .queryCategoryCommodity(
      categoryId: gategoryId,
      pageNum: ++_currentPageNumber,
    )
        .then((value) {
      if (value != null) {
        value?.forEach((element) {
          _commodites.add(CommodityCardViewModel.transform(element));
        });

        _$RefreshUI();
      }

      _updating = false;
    });
  }

  @override
  Future onRefreshPull() {
    if (_updating || _currentPageNumber == 1) return null;

    _updating = true;

    _currentPageNumber = 1;

    return NetworkManager.instance
        .queryCategoryCommodity(
      categoryId: gategoryId,
      pageNum: _currentPageNumber,
    )
        .then((value) {
      if (value != null) {
        _commodites.clear();

        value?.forEach((element) {
          _commodites.add(CommodityCardViewModel.transform(element));
        });

        _$RefreshUI();
        _updating = false;
      }
    });
  }

  @override
  void onPressedCommodity(String commodityId) {
    UIManager.instance
        .toPage(context, UIDef.commodityDetail, arguments: commodityId);
  }

  @override
  void onPressedStore(String storeId) {
    UIManager.instance.toPage(context, UIDef.storeDetial, arguments: storeId);
  }

  void _onClickFiltrate() {
    Debug.log("筛选");
  }
}
