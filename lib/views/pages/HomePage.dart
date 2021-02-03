import 'package:flutter/material.dart';
import 'package:flutter_etu_remake/viewmodels/CommodityCardViewModel.dart';
import 'package:flutter_etu_remake/views/components/CommodityCard.dart';
import 'package:flutter_etu_remake/views/pages/home/CategoryView.dart';
import 'package:flutter_etu_remake/views/pages/home/HomeView.dart';
import 'package:flutter_etu_remake/views/pages/home/MineView.dart';
import 'package:flutter_etu_remake/views/pages/home/ShoppingCartView.dart';

//主页
class HomePage extends StatefulWidget {
  final String title;

  HomePage({Key key, this.title = ''}) : super(key: key);

  @override
  State<StatefulWidget> createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  int _currentBottomBarIndex = 0;

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

  @override
  Widget build(BuildContext context) {  

    return Scaffold(
        resizeToAvoidBottomInset: false,  
        body: Center(
          child: _$SwitchPageContent(_currentBottomBarIndex),
        ),
        bottomNavigationBar: BottomNavigationBar(
          selectedFontSize: 10,
          unselectedFontSize: 10,
          type: BottomNavigationBarType.fixed,
          showUnselectedLabels: true,
          selectedLabelStyle: TextStyle(color: Colors.orangeAccent),
          items: _$BottomNavigationBarItems(),
          currentIndex: _currentBottomBarIndex,
          onTap: (value) {
            setState(() {
              _currentBottomBarIndex = value;
            });
          },
        ));
  }

  Widget _$SwitchPageContent(int index) {

    Widget content;

    switch (index) {
      case 1:
       content = CategoryView();
        break;
      case 2:
       content = ShoppingCartView();
        break;
      case 3:
       content = MineView();
        break;
      case 0:
      default:
      content = HomeView();//RecommendedListView();//
        break;
    }

    return content;
  }

  List<BottomNavigationBarItem> _$BottomNavigationBarItems() {
    return [
      BottomNavigationBarItem(
          label: "首页",
          icon: Image.asset(
            'assets/images/icon_home_nor.png',
            width: 20,
            height: 20,
          ),
          activeIcon: Image.asset(
            'assets/images/icon_home_hover.png',
            width: 20,
            height: 20,
          )),
      BottomNavigationBarItem(
          label: "商品",
          icon: Image.asset(
            'assets/images/icon_sp_nor.png',
            width: 20,
            height: 20,
          ),
          activeIcon: Image.asset(
            'assets/images/icon_sp_nor_hover.png',
            width: 20,
            height: 20,
          )),
      BottomNavigationBarItem(
          label: "购物车",
          icon: Image.asset(
            'assets/images/icon_gwc_nor.png',
            width: 20,
            height: 20,
          ),
          activeIcon: Image.asset(
            'assets/images/icon_gwc_hover.png',
            width: 20,
            height: 20,
          )),
      BottomNavigationBarItem(
          label: "我的",
          icon: Image.asset(
            'assets/images/icon_my_nor.png',
            width: 20,
            height: 20,
          ),
          activeIcon: Image.asset(
            'assets/images/icon_my_hover.png',
            width: 20,
            height: 20,
          )),
    ];
  }


}
