import 'package:azlistview/azlistview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_etu_remake/Global.dart';
import 'package:flutter_etu_remake/WidgetComponents.dart';
import 'package:flutter_etu_remake/models/City.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class CitySearchListView extends StatefulWidget {
  
  CitySearchListViewDelegate listener;

  CitySearchListView({Key key, this.listener}) : super(key: key);

  @override
  State<StatefulWidget> createState() => CitySearchListViewState();
}

class CitySearchListViewState extends State<CitySearchListView> {
  final TextEditingController cityController = new TextEditingController();

  List<City> _searchCities = [];

  bool _isSearching = false;

  LocationModel _locationModel;

  @override
  void initState() => super.initState();

  @override
  void deactivate() => super.deactivate();

  @override
  void dispose() => super.dispose();

  Widget _$SearchListCity() {
    return ListView.separated(
      itemCount: _searchCities?.length == 0 ? 1 : _searchCities?.length,
      itemBuilder: (context, index) {
        if ((_searchCities?.length ?? 0) > 0) {
          return TextButton(
            child: Container(
              width: double.infinity,
              child: Text(
                _searchCities[index].name,
                style: TextStyle(color: Colors.black, fontSize: 14),
              ),
            ),
            onPressed: () =>
                widget?.listener?.onSelectedCity(_searchCities[index]?.name),
          );
        } else {
          return Container(
            margin: EdgeInsets.only(top: 30.0),
            child: Text(
              "无法查询到城市",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16.0, color: Colors.grey),
            ),
          );
        }
      },
      separatorBuilder: (context, index) =>
          Divider(height: 0.0, thickness: 0.0, indent: 0),
    );
  }

  ///当前城市
  Widget _$CurrentCityItem() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
            padding: const EdgeInsets.only(left: 10.0),
            child: Icon(
              Icons.location_on,
              color: Colors.orangeAccent,
              size: 20,
            )),
        Expanded(
            child: Container(
          alignment: Alignment.centerLeft,
          child: Text("当前城市: ${_locationModel?.location ?? '深圳市'}"),
        )),
        Container(
            child: IconButton(
          icon: Icon(
            Icons.rotate_right_outlined,
            color: Colors.orangeAccent,
          ),
          onPressed: widget?.listener?.onLocation,
        ))
      ],
    );
  }

  List<Widget> _$HistoryCityTips() {
    List<Widget> historyCityTips = [];

    for (var i = 0; i < _locationModel?.historyCities?.length; i++) {
      historyCityTips.add(Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(2),
              border: Border.all(color: Colors.black87)),
          height: 20,
          child: FlatButton(
              padding: const EdgeInsets.all(0),
              child: Text(_locationModel.historyCities[i]?.name,
                  style: TextStyle(fontSize: 12)),
              onPressed: () {
                widget?.listener
                    ?.onSelectedCity(_locationModel.historyCities[i]?.name);
              })));
    }
    return historyCityTips;
  }

  ///最近访问
  Widget _$RecentVistItem() {
    List<Widget> historyCityTips = _$HistoryCityTips();
    return Container(
        margin: EdgeInsets.fromLTRB(15, 5, 5, 5),
        child: Column(children: [
          Container(
              margin: EdgeInsets.only(bottom: 5),
              width: double.infinity,
              child: Text(
                "定位/最近访问",
                style: TextStyle(fontSize: 14, color: Colors.grey),
              )),
          if (historyCityTips != null || historyCityTips.length > 0)
            Container(child: Wrap(children: historyCityTips))
        ]));
  }

//A-Z城市列表
  Widget _$CityAzListView() {
    return AzListView(
      data: _locationModel?.chinaCities,
      itemCount: _locationModel?.chinaCities?.length ?? 0,
      itemBuilder: (BuildContext context, int index) {
        City model = _locationModel?.chinaCities[index];
        return _$GetListItem(context, model);
      },
      padding: EdgeInsets.zero,
      susItemBuilder: (BuildContext context, int index) {
        City model = _locationModel?.chinaCities[index];
        String tag = model.getSuspensionTag();
        return _$GetSusItem(context, tag);
      },
      indexBarItemHeight: 16,
      indexBarAlignment: Alignment.centerRight,
      indexBarData: ['★', ...kIndexBarData],
    );
  }

  @override
  Widget build(BuildContext context) {
    _locationModel = Provider.of<LocationModel>(context);

    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          elevation: 0.1,
          shadowColor: Colors.transparent,
          backgroundColor: Colors.grey[100],
          centerTitle: false,
          leadingWidth: 25,
          title: Container(
              margin: EdgeInsets.symmetric(vertical: 0, horizontal: 5),
              child: WidgetComponents.SearchFeild(
                hintText: "城市中文名或拼音",
                onChanged: (value) {
                  _isSearching = false;
                  if (value != null && value.length > 0) {
                    _searchCities?.clear();

                    _locationModel?.chinaCities?.forEach((element) {
                      if (element.namePinyin.contains(value) ||
                          element.shrink.contains(value) ||
                          element.name.contains(value))
                        _searchCities.add(element);
                    });
                    _isSearching = true;
                  }
                  if (mounted) setState(() {});
                },
              )),
          leading: IconButton(
            icon: Icon(Icons.chevron_left, color: Colors.black),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        body: _$BodyContentBuilder(context));
  }

  Widget _$GetSusItem(BuildContext context, String tag,
      {double susHeight = 25}) {
    if (tag == '★') {
      tag = '★ 热门城市';
    }
    return Container(
      height: susHeight,
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.only(left: 16.0),
      color: Color(0xFFF3F4F5),
      alignment: Alignment.centerLeft,
      child: Text(
        '$tag',
        softWrap: false,
        style: TextStyle(
          fontSize: 14.0,
          color: Color(0xFF666666),
        ),
      ),
    );
  }

  Widget _$GetListItem(BuildContext context, City model,
      {double susHeight = 25}) {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: FlatButton(
        child: Container(
          width: MediaQuery.of(context).size.width,
          child: Text(
            model.name,
            textAlign: TextAlign.left,
            style: TextStyle(fontSize: 12),
          ),
        ),
        onPressed: () {
          widget.listener?.onSelectedCity(model.name);
        },
      ),
    );
  }

  _$BodyContentBuilder(BuildContext context) {
    return Stack(
      children: [
        Offstage(offstage: !_isSearching, child: _$SearchListCity()),
        Offstage(
            offstage: _isSearching,
            child: Container(
                child: Card(
              clipBehavior: Clip.hardEdge,
              shape: const RoundedRectangleBorder(
                borderRadius: const BorderRadius.all(Radius.zero),
              ),
              child: Column(
                children: [
                  _$CurrentCityItem(),
                  _$RecentVistItem(),
                  Expanded(
                    child: _$CityAzListView(),
                  )
                ],
              ),
            )))
      ],
    );
  }
}

abstract class CitySearchListViewDelegate {
  void onSelectedCity(String city);
  void onLocation();
}
