import 'dart:convert';
import 'package:azlistview/azlistview.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_etu_remake/Debug.dart';
import 'package:flutter_etu_remake/core/MessageManager.dart';
import 'package:flutter_etu_remake/models/City.dart';
import 'package:flutter_etu_remake/models/Profile.dart';
import 'package:fluwx/fluwx.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lpinyin/lpinyin.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bmfbase/BaiduMap/bmfmap_base.dart'
    show BMFCoordinate, BMFEdgeInsets, BMFMapSDK, BMFPoint, BMF_COORD_TYPE;
import 'dart:io' show File, Platform;

///全局类
class Global {

   static final picker = ImagePicker();
  ///轻量级的存储类来保存键值对信息
  static SharedPreferences _prefs;

  static Profile profile = Profile();

  static String appToken;

  //坐标位置
  static String location ="深圳市";// "广州市"; //

  static String wx_appid = "wxd930ea5d5a258f4f";
  static String wx_universalLink="https://your.univerallink.com/link/";

  // 可选的主题列表
  static List<MaterialColor> get themes => [
        Colors.blue,
        Colors.cyan,
        Colors.teal,
        Colors.green,
        Colors.red,
        Colors.orange,
        Colors.deepOrange
      ];

  ///中国所有城市
  static List<City> chinaCities;

  ///历史搜索城市
  static List<City> historyCities;

  ///热门搜索城市
  static List<City> hotCityies;

  // 是否为release版
  static bool get isRelease => bool.fromEnvironment("dart.vm.product");

  //初始化全局信息，会在APP启动时执行
  static Future init() async {
    await _initProfile();

   await  _initServices();

    await loadCity();

    await _initFluwx(wx_appid,wx_universalLink);

    _initBMFSdk();
  }

  static Future _initServices()async{
    await MessageManager.instance.init(im_key:profile.eim_appid);
  }

   ///微信登录/支付/分享 初始化
  static Future _initFluwx(String appid,String universalLink) async {
    await registerWxApi(
        appId: appid,
        doOnAndroid: true,
        doOnIOS: true,
        universalLink: universalLink);
    bool isInstall = await isWeChatInstalled;

    Debug.log("WeChat is Installed ? [$isInstall]");

    weChatResponseEventHandler.listen((event) {
      Debug.log(event);
    });
  }

  static Future loadCity() {
    historyCities = [];
    hotCityies = [
      City(name: '北京市', tagIndex: '★'),
      City(name: '成都市', tagIndex: '★'),
      City(name: '深圳市', tagIndex: '★'),
      City(name: '杭州市', tagIndex: '★'),
      City(name: '上海市', tagIndex: '★'),
      City(name: '广州市', tagIndex: '★'),
      City(name: '武汉市', tagIndex: '★'),
    ];

    chinaCities = [];

    chinaCities.addAll(hotCityies);

//加载城市列表
    return rootBundle.loadString('assets/data/china.json').then((value) {
      Map countyMap = json.decode(value);
      List list = countyMap['china'];
      list.forEach((v) {
        chinaCities.add(City.fromJson(v));
      });

     
       _handleList(chinaCities);
      // show sus tag.
      SuspensionUtil.setShowSuspensionStatus(chinaCities);
    });
  }

  static void _handleList(List<City> list) {
    if (list == null || list.isEmpty) return;

    String shrink = "";

    for (int i = 0, length = list.length; i < length; i++) {
      String pinyin = PinyinHelper.getPinyinE(list[i].name);
      String tag = pinyin.substring(0, 1).toUpperCase();
      list[i].namePinyin = pinyin;
      list[i].shrink = shrink;
      if (RegExp('[A-Z]').hasMatch(tag)) {
        list[i].tagIndex = tag;
      } else {
        list[i].tagIndex = '#';
      }
    }
    SuspensionUtil.sortListBySuspensionTag(list);
  }

  ///百度地图SDK初始化
  static void _initBMFSdk() {
    //
    if (Platform.isIOS) {
      BMFMapSDK.setApiKeyAndCoordType(
          '${profile.bmf_isokey}', BMF_COORD_TYPE.BD09LL);
    } else if (Platform.isAndroid) {
      // Android 目前不支持接口设置Apikey,
      // 请在主工程的Manifest文件里设置，详细配置方法请参考官网(https://lbsyun.baidu.com/)demo
      BMFMapSDK.setCoordType(BMF_COORD_TYPE.BD09LL);
    }
  }

  static Future _initProfile() async {
    _prefs = await SharedPreferences.getInstance();
    var _profile = _prefs.getString("profile");
    if (_profile == null || _profile.isEmpty) {
      _profile = await rootBundle.loadString("assets/data/profile.json");
    }
    try {
      profile = Profile.fromJson(jsonDecode(_profile));
    } catch (e) {
      print(e);
    }
  }

  static saveProfile() {
    String jsonStr = jsonEncode(profile.toJson());

    Debug.log(jsonStr);

    //_prefs.setString("profile", jsonEncode(profile.toJson()));
  }

  static void release() {
    MessageManager.instance.release();
  }
}

class ProfileChangeNotifier extends ChangeNotifier {
  // ignore: unused_element
  Profile get _profile => Global.profile;

  @override
  void notifyListeners() {
    Global.saveProfile(); //保存Profile变更
    super.notifyListeners(); //通知依赖的Widget更新
  }
}

///APP语言状态
class LocaleModel extends ProfileChangeNotifier {
  // 获取当前用户的APP语言配置Locale类，如果为null，则语言跟随系统语言
  Locale getLocale() {
    if (_profile.locale == null) return null;
    List t = _profile.locale.split("_");
    //注：为何_countryCode 要t.length-1 比如中文简体 字符串将会是 zh_Hans_CN
    return Locale(t[0], t[t.length - 1]);
  }

  // 获取当前Locale的字符串表示
  String get locale => _profile.locale;

  // 用户改变APP语言后，通知依赖项更新，新语言会立即生效
  set locale(String locale) {
    if (locale != _profile.locale) {
      _profile.locale = locale;
      notifyListeners();
    }
  }
}

class ThemeModel extends ProfileChangeNotifier {
  // 获取当前主题，如果为设置主题，则默认使用蓝色主题
  ColorSwatch get theme =>
      Global.themes.firstWhere((e) => e.value == _profile.theme,
          orElse: () => Colors.deepOrange);

  // 主题改变后，通知其依赖项，新主题会立即生效
  set theme(ColorSwatch color) {
    if (color != theme) {
      _profile.theme = color[500].value;
      notifyListeners();
    }
  }
}

class LocationModel extends ProfileChangeNotifier {
  String get location => Global.location;

  ///中国所有城市
  List<City> get chinaCities => Global.chinaCities;

  ///历史搜索城市
  List<City> get historyCities => Global.historyCities;

  ///热门搜索城市
  List<City> get hotCityies => Global.hotCityies;

  set chinaCities(List<City> cities) {
    if (chinaCities != cities) {
      Global.chinaCities = cities;
      notifyListeners();
    }
  }

  set historyCities(List<City> cities) {
    if (historyCities != cities) {
      Global.chinaCities = cities;
      notifyListeners();
    }
  }

  set hotCityies(List<City> cities) {
    if (hotCityies != cities) {
      Global.hotCityies = cities;
      notifyListeners();
    }
  }

  set location(String address) {
    if (location != address) {
      Global.location = address;
      notifyListeners();
    }
  }
}
