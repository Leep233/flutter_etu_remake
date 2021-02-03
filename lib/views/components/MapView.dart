
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bmflocation/flutter_baidu_location.dart';
import 'package:flutter_bmfmap/BaiduMap/map/bmf_map_controller.dart';
import 'package:flutter_bmfmap/BaiduMap/map/bmf_map_view.dart';
import 'package:flutter_bmfmap/BaiduMap/models/bmf_map_options.dart';
import 'package:flutter_bmfbase/BaiduMap/bmfmap_base.dart'
    show BMFCoordinate, BMFEdgeInsets, BMFMapSDK, BMFPoint, BMF_COORD_TYPE;

import 'package:flutter_bmfbase/BaiduMap/bmfmap_base.dart';
import 'package:flutter_bmfmap/BaiduMap/models/bmf_mappoi.dart';

//百度地图
class MapView extends StatefulWidget {

  MapView({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => MapViewState();
}

class MapViewState extends State<MapView> {

  Size screenSize;

  BMFMapController _mapController;

  BMFCoordinate _coordinate;

  BMFMapPoi _mapPoi;

  String _touchPointStr = '触摸点';

  BMFCoordinate center = BMFCoordinate(39.965, 116.404);

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

  void onBMFMapCreated(BMFMapController controller) {

    _mapController = controller;

    _mapController?.showUserLocation(true);

    /// 点中底图标注后会回调此接口
    _mapController?.setMapOnClickedMapPoiCallback(callback: (BMFMapPoi mapPoi) {
      print('点中底图标注后会回调此接口poi=${mapPoi?.toMap()}');
      setState(() {
        _mapPoi = mapPoi;
        _touchPointStr = '标注触摸点';
      });
    });

    /// 点中底图空白处会回调此接口
    _mapController?.setMapOnClickedMapBlankCallback(
        callback: (BMFCoordinate coordinate) {
      print('点中底图空白处会回调此接口coord=${coordinate?.toMap()}');
      setState(() {
        _coordinate = coordinate;
        _mapPoi = null;
        _touchPointStr = '空白触摸点';
      });
    });

    /// 双击地图时会回调此接口
    _mapController?.setMapOnDoubleClickCallback(
        callback: (BMFCoordinate coordinate) {
      print('双击地图时会回调此接口coord=${coordinate?.toMap()}');
      setState(() {
        _coordinate = coordinate;
        _mapPoi = null;
        _touchPointStr = '双击触摸点';
      });
    });

    /// 长按地图时会回调此接口
    _mapController?.setMapOnLongClickCallback(
        callback: (BMFCoordinate coordinate) {
      setState(() {
        _coordinate = coordinate;
        _mapPoi = null;
        _touchPointStr = '长按触摸点';
      });
      print('长按地图时会回调此接口coord=${coordinate?.toMap()}');
    });

    /// 3DTouch 按地图时会回调此接口
    ///（仅在支持3D Touch，且fouchTouchEnabled属性为true时，会回调此接口）
    /// coordinate 触摸点的经纬度
    /// force 触摸该点的力度(参考UITouch的force属性)
    /// maximumPossibleForce 当前输入机制下的最大可能力度(参考UITouch的maximumPossibleForce属性)
    _mapController?.setMapOnForceTouchCallback(callback:
        (BMFCoordinate coordinate, double force, double maximumPossibleForce) {
      setState(() {
        _coordinate = coordinate;
        _mapPoi = null;
        _touchPointStr = '3D触摸点';
      });
      print(
          '3DTouch 按地图时会回调此接口\ncoord=${coordinate?.toMap()}\nforce=$force\nmaximumPossibleForce=$maximumPossibleForce');
    });
  }

  /// 创建地图
  Container generateMap() {
    return Container(
      child: BMFMapWidget(
        onBMFMapCreated: onBMFMapCreated,
        mapOptions: initMapOptions(),
      ),
    );
  }

  BMFMapOptions initMapOptions() {
    BMFMapOptions mapOptions = BMFMapOptions(
        mapType: BMFMapType.Standard,
        zoomLevel: 12,
        maxZoomLevel: 21,
        minZoomLevel: 4,
        compassPosition: BMFPoint(0, 0),
        mapPadding: BMFEdgeInsets(top: 0, left: 50, right: 50, bottom: 0),
        logoPosition: BMFLogoPosition.LeftTop,
        rotateEnabled: true,
        gesturesEnabled: true,
        center: center);
    return mapOptions;
  }

  @override
  Widget build(BuildContext context) {
    screenSize = MediaQuery.of(context).size;

    return generateMap();
  }
}
