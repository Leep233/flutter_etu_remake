import 'package:flutter/material.dart';
import 'package:flutter_etu_remake/AppDefaultStyle.dart';
import 'package:flutter_etu_remake/Global.dart';
import 'package:flutter_etu_remake/core/NetworkManager.dart';
import 'package:flutter_etu_remake/core/UIManager.dart';
import 'package:flutter_etu_remake/l10n/localization_intl.dart';
import 'package:flutter_etu_remake/views/pages/CitySearchListView.dart';
import 'package:flutter_etu_remake/viewmodels/CategoryCardViewModel.dart';
import 'package:flutter_etu_remake/views/components/CategoryCard.dart';
import 'package:flutter_etu_remake/views/components/TabBarExtend.dart';
import 'package:provider/provider.dart';

///商品分类页面
class CategoryView extends StatefulWidget {
  final String title;

  CategoryView({Key key, this.title = ''}) : super(key: key);

  @override
  State<StatefulWidget> createState() => CategoryViewState();
}

class CategoryViewState extends State<CategoryView>
    implements CategoryCardDelegate, CitySearchListViewDelegate {
  int _initIndex = 0;

  List<CategoryCardViewModel> categories;

  CategoryCardViewModel _currentCategory;

  String region = "";

  List<String> _tabs;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  void _loadData() {
    NetworkManager.instance
        .commodityCategoryList(region: Global.location)
        .then((value) {
      if (value == null) return;
      categories = [];
      _tabs = [];

      value?.forEach((element) {
        categories.add(CategoryCardViewModel.tranform(element));
        _tabs.add(element.categoryName);
      });

      _currentCategory = categories[_initIndex];

      _$RefreshUI();
    });
  }

  void _$RefreshUI() {
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

  Widget get tabsWidget => _tabs == null
      ? SizedBox()
      : CategoryTabBar(
          initIndex: _initIndex,
          categoryTabs: _tabs,
          onTabChanged: _onTabChangedCallback,
        );

  Widget get tabsView => categories == null
      ? SizedBox()
      : CategoryTabBarView(
          cardListener: this, categories: _currentCategory.categories);

  @override
  Widget build(BuildContext context) {
    region = Provider.of<LocationModel>(context).location;

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: AppDefaultStyle.appBarHeight,
        automaticallyImplyLeading: false,
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          AppLocalizations.of(context).commodity,
          style: TextStyle(color: Colors.black87, fontSize: AppDefaultStyle.AppTitleFontSize),
        ),
        actions: [
          FlatButton(
              color: Colors.transparent,
              onPressed: _onclickPositionBtn,
              child: Row(children: [
                Text(
                  region,
                  style:
                      TextStyle(fontSize: 12, color: Colors.deepOrangeAccent),
                ),
                Icon(Icons.location_on_outlined,
                    size: 14, color: Colors.deepOrangeAccent)
              ]))
        ],
      ),
      body: Container(
        child: Row(
          children: [
            Expanded(flex: 3, child: Container(child: tabsWidget)),
            Expanded(
                flex: 11,
                child: Container(
                  child: tabsView,
                )),
          ],
        ),
      ),
    );
  }

  void _onTabChangedCallback(int index, String p2) {
    _initIndex = index;

    NetworkManager.instance
        .commodityCategoryList(categoryId: int.parse(categories[_initIndex].id))
        .then((value) {
      if (value == null) return;

      _currentCategory.categories = [];

      value.forEach((element) {
        _currentCategory.categories
            .add(CategoryCardViewModel.tranform(element));
      });

      _$RefreshUI();
    });
  }

  void _onclickPositionBtn() {
    Navigator.push<String>(context,
        new MaterialPageRoute(builder: (BuildContext context) {
      return CitySearchListView(listener: this);
    })).then((address) {
      if (address == null || address.isEmpty) return;

      Provider.of<LocationModel>(context, listen: false).location = address;

      _loadData();
    });
  }

  @override
  void onPressedCommodity(int commodityId) {
    UIManager.instance
        .toPage(context, UIDef.commodityDetail, arguments: commodityId);
  }

  @override
  void onPressedMore(int gategoryId,String gategoryName) {
    print("分类商品 $gategoryId");

    Map map = {"id":gategoryId,'name':gategoryName};

    UIManager.instance.toPage(context, UIDef.categoryCommodity,arguments: map);
  }

  @override
  void onLocation() {
    // TODO: implement onLocation
  }

  @override
  void onSelectedCity(String city) {
    Navigator.pop<String>(context, city);
  }
}

//分类TabBar
class CategoryTabBar extends StatelessWidget {
  final List<String> categoryTabs;

  final void Function(int, String) onTabChanged;

  final int initIndex;

  CategoryTabBar(
      {@required this.categoryTabs, this.onTabChanged, this.initIndex});

  @override
  Widget build(BuildContext context) {
    List<Text> tabs = [];
    List<Text> selectedTabs = [];

    for (var i = 0; i < categoryTabs?.length; i++) {
      tabs.add(Text(
        categoryTabs[i],
        style: TextStyle(color: Colors.grey),
      ));
      selectedTabs.add(Text(categoryTabs[i],
          style: TextStyle(color: Colors.red, fontWeight: FontWeight.w600)));
    }

    return Container(
        padding: const EdgeInsets.only(left: 5),
        child: TabBarExtend(
          tabs: tabs,
          initIndex: initIndex,
          values: categoryTabs,
          selectedTabs: selectedTabs,
          onTab: onTabChanged,
        ));
  }
}

// ignore: must_be_immutable
class CategoryTabBarView extends StatelessWidget {
  
  final List<CategoryCardViewModel> categories;

  final ScrollController controller;

  final CategoryCardDelegate cardListener;

  CategoryTabBarView({
    this.categories,
    this.controller,
    this.cardListener,
  });

  @override
  Widget build(BuildContext context) {
  
    Container container = Container(
        child: ListView.builder(
      controller: controller,
      itemBuilder: _itemBuilder,
      itemCount: categories?.length ?? 0,
    ));

    return container;
  }

  Widget _itemBuilder(BuildContext context, int index) {
    CategoryCardViewModel data = categories[index];

    return Container(
        padding: EdgeInsets.all(2),
        child: CategoryCard(
          data: data,
          listener: cardListener,
        ));
  }
}
