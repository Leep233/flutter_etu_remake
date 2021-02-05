import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_etu_remake/Debug.dart';
import 'package:flutter_etu_remake/Global.dart';
import 'package:flutter_etu_remake/core/MessageManager.dart';
import 'package:flutter_etu_remake/models/Category.dart';
import 'package:flutter_etu_remake/models/Comment.dart';
import 'package:flutter_etu_remake/models/Commodity.dart';
import 'package:flutter_etu_remake/models/CommodityDetail.dart';
import 'package:flutter_etu_remake/models/CommoditySpecificationPrice.dart';
import 'package:flutter_etu_remake/models/Deliveryaddress.dart';
import 'package:flutter_etu_remake/models/MyOrders.dart';
import 'package:flutter_etu_remake/models/OrderDetail.dart';
import 'package:flutter_etu_remake/models/PaymentDetail.dart';
import 'package:flutter_etu_remake/models/ShoppingCartDetail.dart';
import 'package:flutter_etu_remake/models/ShoppingOrder.dart';
import 'package:flutter_etu_remake/models/StoreDetial.dart';
import 'package:flutter_etu_remake/models/User.dart';
import 'package:flutter_etu_remake/models/UserBalance.dart';
import 'package:flutter_etu_remake/models/WechatPayment.dart';

class HttpUtil {
  static String getParams(Map<String, dynamic> params) {
    String paramsStr = "";

    if (params == null || params.length <= 0) return paramsStr;

    params.forEach((key, value) {
      if (value != null) {
        paramsStr += "&${key}=${value}";
      }
    });

    return paramsStr.substring(1, paramsStr.length);
  }
}

class NetworkManager {
  NetworkManager._();

  static NetworkManager _instance;
  static NetworkManager get instance => _getInstance();

  static NetworkManager _getInstance() {
    if (_instance == null) _instance = NetworkManager._();

    return _instance;
  }

  String get server =>
      "https://pxxt.shopismini.com:8090"; //"http://192.168.1.10:8086";

  Map<String, String> get headers => {
        "content-type": "application/x-www-form-urlencoded;charset=utf-8",
        "Accept": "application/json",
        "App-Token": Global.appToken ?? ""
      };

  ///登录
  Future<String> login(
      String account, String password, String verifyCode) async {
    String url = "$server/market/app/login";

    String msg = "";

    Map<String, dynamic> loginBody = {
      "account": "$account",
      "password": "$password",
      "verifyCode": "$verifyCode"
    };

    try {
      var dio = Dio();

      dio.options.headers = headers;

      var response = await dio.post(url, data: FormData.fromMap(loginBody));

      if (response.statusCode == 200) {
        Map jsonMap;

        if (response.data is String)
          jsonMap = jsonDecode(response.data);
        else
          jsonMap = response.data;

         Debug.log(jsonMap);

        if (jsonMap["code"] != 200)
          msg = jsonMap["message"];
        else {
          Global.appToken = jsonMap["data"];
          MessageManager.instance.login(account);
        }
      } else {
        msg = "网络异常:${response.statusCode}";
      }
    } catch (e) {
      msg = e;
    }

    if(msg.isNotEmpty) Debug.error(msg);

    return msg;
  }

  Future<User> user() async {
    String url = "$server/market/app/personal/mineInfo";

    String msg = "";

    User result;

    try {
      var dio = Dio();

      dio.options.headers = headers;

      var response = await dio.get(url);

      if (response.statusCode == 200) {
        Map<String, dynamic> jsonMap = response.data as Map;

         Debug.log(jsonMap);

        if (jsonMap["code"] == 200) result = User.fromJson(jsonMap["data"]);
      } else {
        msg = "网络异常:${response.statusCode}";
      }
    } catch (e) {
      msg = e;
    }
    if(msg.isNotEmpty) Debug.error(msg);
    return result;
  }

  ///查询产品对应规格的价格
  Future<CommoditySpecificationPrice> commoditySpecificationPrice(
      String productNo, String specificationJson) async {
    CommoditySpecificationPrice result;

    String param = HttpUtil.getParams({
      "productNo": productNo,
      "specification": specificationJson,
    });

    String url = "$server/market/app/goods/queryPrice?$param";

     Debug.log(url);

    String msg = "";

    try {
      var dio = Dio();
      dio.options.headers = headers;

      var response = await dio.get(url);

      if (response.statusCode == 200) {
        Map jsonMap = response.data as Map;

         Debug.log(jsonMap);

        msg = jsonMap["message"];

        if (jsonMap["code"] == 200)
          result = CommoditySpecificationPrice.fromJson(jsonMap["data"]??"");
      } else {
        msg = "网络异常:${response.statusCode}";
      }
    } catch (e) {
      msg = e;
    }

    if(msg.isNotEmpty) Debug.error(msg);

    return result;
  }

 //用户钱包
  Future<UserBalance> userBalance() async {
    UserBalance result = null;

    String url = "$server/market/app/wallet/balance";

    print(url);

    String msg = "";

    try {
      var dio = Dio();
      dio.options.headers = headers;

      var response = await dio.get(url);

      if (response.statusCode == 200) {
        Map jsonMap = response.data as Map;

         Debug.log(jsonMap);

        msg = jsonMap["message"];

        if (jsonMap["code"] == 200)
          result = UserBalance.fromJson(jsonMap["data"]);
      } else {
        msg = "网络异常:${response.statusCode}";
      }
    } catch (e) {
      msg = e;
    }

    Debug.log(msg);
    return result;
  }

  ///加入购物车
  Future<String> addToCart(String commodityNo, int quantity) async {
    String url = "$server/market/app/goods/addToPurchase";

    String msg = "";

    Map<String, String> body = {
      "commodityNo": "$commodityNo",
      "quantity": "$quantity",
    };

    try {
      var dio = Dio();
      dio.options.headers = headers;

      var response = await dio.post(
        url,
        data: FormData.fromMap(body),
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> jsonMap = response.data as Map;

         Debug.log(jsonMap);

        if (jsonMap["code"] != 200)
          msg = jsonMap["message"];
        else
          msg = jsonMap["data"];
      } else {
        msg = "网络异常:${response.statusCode}";
      }
    } catch (e) {
      msg = e;
    }

    if(msg.isNotEmpty) Debug.log(msg);

    return msg;
  }

  ///购物车
  Future<ShoppingCartDetail> shoppingCartDetail() async {
    String url = "$server/market/app/purchase/info";

     Debug.log(url);

    ShoppingCartDetail result;

    String msg = "";
// headers: headers
    try {
      var dio = Dio();
      dio.options.headers = headers;

      var response = await dio.get(url);

      if (response.statusCode == 200) {
        Map jsonMap = response.data as Map;

         Debug.log(jsonMap);

        msg = jsonMap["message"];

        if (jsonMap["code"] == 200)
          result = ShoppingCartDetail.fromJson(jsonMap["data"]);
      } else {
        msg = "网络异常:${response.statusCode}";
      }
    } catch (e) {
      msg = e;
    }

    if(msg.isNotEmpty) Debug.error(msg);

    return result;
  }

  //商铺信息
  Future<StoreDetial> storeDetial(
      {int pageNum = 1,
      int pageSize = 10,
      String startDate,
      String endDate,
      int sort = 1,
      int tag = 1,
      String content,
      String filterContent,
      String region,
      int isHot,
      int isRecommend,
      @required int merchantId,
      int categoryId}) async {
    StoreDetial result;

    String param = HttpUtil.getParams({
      "pageNum": pageNum,
      "pageSize": pageSize,
      "startDate": startDate,
      "content": content,
      "sort": sort,
      "tag": tag,
      "isHot": isHot,
      "isRecommend": isRecommend,
      "merchantId": merchantId,
      "categoryId": categoryId,
      "filterContent": filterContent,
      "region": region,
    });

    String url = "$server/market/app/shop/list?$param";

     Debug.log(url);

    String msg = "";

    try {
      var dio = Dio();
      dio.options.headers = headers;

      var response = await dio.get(url);

      if (response.statusCode == 200) {
        Map jsonMap = response.data as Map;

         Debug.log(jsonMap);

        msg = jsonMap["message"];

        if (jsonMap["code"] == 200)
          result = StoreDetial.fromJson(jsonMap["data"]);
      } else {
        msg = "网络异常:${response.statusCode}";
      }
    } catch (e) {
      msg = e;
    }

    if(msg.isNotEmpty) Debug.error(msg);

    return result;
  }

//商品分类
  Future<List<Category>> commodityCategoryList(
      {String region, int categoryId}) async {
    String url = ""; //"${webServer}/market/app/classify/list?region=$region";

    if ((region == null || region.isEmpty) && categoryId != null)
      url = "$server/market/app/classify/children?categoryId=$categoryId";
    else
      url = "$server/market/app/classify/list?region=$region";

     Debug.log(url);

    String msg = "";

    List<Category> dataList = null;

    try {
      var dio = Dio();

      dio.options.headers = headers;

      var response = await dio.get(
        url,
      );

      if (response.statusCode == 200) {
        Map jsonMap = response.data as Map;

         Debug.log(jsonMap);

        msg = jsonMap["message"];

        if (jsonMap["code"] == 200)
          dataList = Category.fromJsonList(jsonMap["data"]);
        else
          msg = "网络异常:${response.statusCode}";
      }
    } catch (e) {
      msg = e;
    }

     Debug.log(msg);

    return dataList;
  }

  ///商品分类查询
  Future<List<Commodity>> queryCategoryCommodity(
      {int pageNum = 1,
      int pageSize = 10,
      String startDate,
      String endDate,
      int sort = 1,
      int tag = 1,
      String content,
      int isHot,
      int isRecommend,
      int merchantId,
     @required int categoryId}) async {
    String param = HttpUtil.getParams({
      "pageNum": pageNum,
      "pageSize": pageSize,
      "startDate": startDate,
      "sort": sort,
      "tag": tag,
      "isHot": isHot,
      "isRecommend": isRecommend,
      "merchantId": merchantId,
      "categoryId": categoryId,
    });

    String url = "$server/market/app/classify/categoryList?$param";

    List<Commodity> result = [];

     Debug.log(url);

    String msg = "";

    try {
      var dio = Dio();
      dio.options.headers = headers;

      var response = await dio.get(url);

      if (response.statusCode == 200) {
        Map jsonMap = response.data as Map;

         Debug.log(jsonMap);

        msg = jsonMap["message"];

        if (jsonMap["code"] == 200) result =Commodity.fromJsonList(jsonMap["data"]) ;
      } else {
        msg = "网络异常:${response.statusCode}";
      }
    } catch (e) {
      msg = e;
    }

    if(msg.isNotEmpty) Debug.error(msg);

    return result;
  }

 ///商品评论查询
  Future<List<Comment>> comments({
    int pageNum = 1,
    int pageSize = 10,
    String startDate,
    String endDate,
    int type = 1,
    String productNo,
  }) async {
    List<Comment> comments = [];

    String param = HttpUtil.getParams({
      "pageNum": pageNum,
      "pageSize": pageSize,
      "startDate": startDate,
      "type": type,
      "productNo": productNo,
    });

    String url = "$server/market/app/goods/comments?$param";

    Debug.log(url);

    String msg = "";
    // headers: headers
    try {
      var dio = Dio();
      dio.options.headers = headers;

      var response = await dio.get(url);

      if (response.statusCode == 200) {
        Map jsonMap = response.data as Map;

        Debug.log(jsonMap);

        msg = jsonMap["message"];

        if (jsonMap["code"] == 200)
          comments = (jsonMap["data"] as List)?.map((e) => Comment.fromJson(e))?.toList();// Comment.fromJsonList();
      } else {
        msg = "网络异常:${response.statusCode}";
      }
    } catch (e) {
      msg = e;
    }

    Debug.log(msg);

    return comments;
  }

  Future<CommodityDetail> commodityDetail({
    @required int productNo,
    int commodityNo,
    String specification,
  }) async {
    CommodityDetail result;

    String param = HttpUtil.getParams({
      "productNo": productNo,
      "commodityNo": commodityNo,
      "specification": specification,
    });

    String url = "$server/market/app/goods/info?$param";

     Debug.log(url);

    String msg = "";

    try {
      var dio = Dio();
      dio.options.headers = headers;

      var response = await dio.get(
        url,
      );

      if (response.statusCode == 200) {
        Map jsonMap = response.data as Map;

         Debug.log(jsonMap);

        msg = jsonMap["message"];

        if (jsonMap["code"] == 200)
          result = CommodityDetail.fromJson(jsonMap["data"]);
      } else {
        msg = "网络异常:${response.statusCode}";
      }
    } catch (e) {
      msg = e;
    }

    if(msg.isNotEmpty) Debug.error(msg);

    return result;
  }

  ///热卖推荐
  Future<List<Commodity>> hotSellCommodities(
      {int pageNum = 1,
      int pageSize = 10,
      String startDate,
      String endDate,
      int sort = 1,
      int tag = 0,
      String content,
      int isHot=1,
      int isRecommend,
      int merchantId,
      String region,
      int categoryId}) async {
    String param = HttpUtil.getParams({
      "pageNum": pageNum,
      "pageSize": pageSize,
      "startDate": startDate,
      "endDate": endDate,
      "sort": sort,
      "content": content,
      "isHot": isHot,
      "isRecommend": isRecommend,
      "merchantId": merchantId,
      "categoryId": categoryId,
      "tag": tag,
      "region": region
    });

    String url = "$server/market/app/home/hotSell?$param";

     Debug.log(url);

    List<Commodity> result = [];

    String msg = "";

    try {
      var dio = Dio();

      dio.options.headers = headers;

      var response = await dio.get(url);

      if (response.statusCode == 200) {
        Map<String, dynamic> jsonMap = response.data as Map;

         Debug.log(jsonMap);

        msg = jsonMap["message"];

        if (jsonMap["code"] == 200)
          result = Commodity.fromJsonList(jsonMap["data"]);
      } else {
        msg = "网络异常:${response.statusCode}";
      }
    } catch (e) {
      msg = e;
    }

    if(msg.isNotEmpty) Debug.error(msg);

    return result;
  }

  ///更新购物车商品数量  返回当前总价
  Future<String> updateShoppingCartCommodityQuantity(
      int id, int quantity) async {
    String url = "$server/market/app/purchase/alterQuantity";

    String msg = "";

    Map<String, dynamic> body = {"id": id, "quantity": quantity};

    try {
      var dio = Dio();
      dio.options.headers = headers;

      var response = await dio.put(url, data: FormData.fromMap(body));

      if (response.statusCode == 200) {
        Map jsonMap = response.data as Map;

         Debug.log(jsonMap);

        if (jsonMap["code"] != 200) msg = jsonMap["message"];
      } else {
        msg = "网络异常:${response.statusCode}";
      }
    } catch (e) {
      msg = e;
    }

     if(msg.isNotEmpty) Debug.error(msg);

    return msg;
  }

 ///提交商品订单
  Future<ShoppingOrder> submitOrder(String commodityNo, int quantity,
      {int addressId}) async {
    String url = "$server/market/app/order/toBuy";

    String msg = "";

    ShoppingOrder result = null;

    Map<String, dynamic> body = {
      "commodityNo": commodityNo,
      "quantity": quantity,
      "addressId": addressId
    };

    try {
      var dio = Dio();

      dio.options.headers = headers;

      var response = await dio.post(url, data: FormData.fromMap(body));

      if (response.statusCode == 200) {
        Map<String, dynamic> jsonMap = response.data as Map;

         Debug.error(jsonMap);

        if (jsonMap["code"] != 200)
          msg = jsonMap["message"];
        else
          result = ShoppingOrder.fromJson(jsonMap["data"]);
      } else {
        msg = "网络异常:${response.statusCode}";
      }
    } catch (e) {
      msg = e;
    }

  if(msg.isNotEmpty) Debug.error(msg);

    return result;
  }

 ///提交购物车订单
  Future<ShoppingOrder> submitShoppingCartOrder(String ids) async {
    String url = "$server/market/app/purchase/check?purchaseIds=$ids";

    String msg = "";

    ShoppingOrder result = null;

    try {
      var dio = Dio();
      dio.options.headers = headers;

      var response = await dio.get(url);

      if (response.statusCode == 200) {
        Map<String, dynamic> jsonMap = response.data as Map;

         Debug.log(jsonMap);

        if (jsonMap["code"] != 200)
          msg = jsonMap["message"];
        else
          result = ShoppingOrder.fromJson(jsonMap["data"]);
      } else {
        msg = "网络异常:${response.statusCode}";
      }
    } catch (e) {
      msg = e;
    }

     if(msg.isNotEmpty) Debug.error(msg);

    return result;
  }


  ///删除购物车商品 如 ids = "1,2,3,4"
  Future<String> deleteShoppintCartCommodities(String ids) async {
    String url = "$server/market/app/purchase/delete?ids=$ids";

    String msg = "";

    try {
         var dio = Dio()..options..options.headers =headers;

      var response = await dio.delete(
        url,
      );

      if (response.statusCode == 200) {
        Map jsonMap = response.data as Map;

         Debug.log(jsonMap);

        msg = (jsonMap["code"] != 200) ? jsonMap["message"] : jsonMap["data"];
      } else {
        msg = "网络异常:${response.statusCode}";
      }
    } catch (e) {
      msg = e;
    }

     if(msg?.isNotEmpty == true) Debug.error(msg);

    return msg;
  }

 ///收货地址列表查询
  Future<List<Deliveryaddress>> deliveryAddreses() async {
    List<Deliveryaddress> list = [];

    String url = "$server/market/app/address/list";

     Debug.log(url);

    String msg = "";

    try {
      var dio = Dio();
      dio.options.headers = headers;

      var response = await dio.get(
        url,
      );

      if (response.statusCode == 200) {
        Map jsonMap = response.data as Map;

         Debug.log(jsonMap);

        msg = jsonMap["message"];

        if (jsonMap["code"] == 200)
          list =(jsonMap["data"] as List)?.map((e) => Deliveryaddress.fromJson(e))?.toList();
      } else {
        msg = "网络异常:${response.statusCode}";
      }
    } catch (e) {
      msg = e;
    }

     if(msg.isNotEmpty) Debug.error(msg);

    return list;
  }

///收藏店铺
  Future<List<StoreDetial>> collectStores({
    int pageNum = 1,
    int pageSize = 10,
    String startDate,
    String endDate,
  }) async {
    List<StoreDetial> result = [];

    String param = HttpUtil.getParams({
      "pageNum": pageNum,
      "pageSize": pageSize,
      "startDate": startDate,
      "endDate": endDate,
    });

    String url = "$server/market/app/personal/mineFollow?$param";

    Debug.log(url);

    String msg = "";

    try {
      var dio = Dio();

      dio.options.headers = headers;

      var response = await dio.get(url);

      if (response.statusCode == 200) {
        Map<String, dynamic> jsonMap = response.data as Map;

        Debug.log(jsonMap);

        msg = jsonMap["message"];

        if (jsonMap["code"] == 200)
          result = StoreDetial.fromJsonList(jsonMap["data"]) ;
      } else {
        msg = "网络异常:${response.statusCode}";
      }
    } catch (e) {
      msg = e;
    }

    if(msg.isNotEmpty) Debug.error(msg);

    return result;
  }

 ///我的订单 [type]:查询类型 0全部 1待付款 2待发货 3待收货 4待评价
  Future<MyOrders> myOrders(
      {int pageNum = 1,
      int pageSize = 10,
      String startDate,
      String endDate,
      int type = 0}) async {
 

    String param = HttpUtil.getParams({
      "pageNum": pageNum,
      "pageSize": pageSize,
      "startDate": startDate,
      "endDate": endDate,
      "type": type,
    });

   MyOrders result;

    String url = "$server/market/app/order/orderList?$param";

    Debug.log(url);

    String msg = "";

    try {
        var dio = Dio()..options..options.headers =headers;

      var response = await dio.get(url);

      if (response.statusCode == 200) {
        Map<String, dynamic> jsonMap = response.data as Map;

        Debug.log(jsonMap);

        msg = jsonMap["message"];

        if (jsonMap["code"] == 200) result = MyOrders.fromJson(jsonMap["data"]);
      } else {
        msg = "网络异常:${response.statusCode}";
      }
    } catch (e) {
      msg = e;
    }

    if(msg.isNotEmpty) Debug.error(msg);

    return result;
  }

 ///支付详情
  Future<PaymentDetail> paymentDetail(
      String orderNo,{int flag = 1 , String remarks=""}) async {
    String url = "$server/market/app/order/toPay";

    String msg = "";

    PaymentDetail result = null;

    Map<String, dynamic> body = {
      "orderNo": orderNo,
      "flag": flag,
      "remarks": remarks
    };

    try {
        var dio = Dio()..options..options.headers =headers;

      var response = await dio.post(url, data: FormData.fromMap(body));

      if (response.statusCode == 200) {
        Map<String, dynamic> jsonMap = response.data as Map;

        Debug.log(jsonMap);

        if (jsonMap["code"] != 200)
          msg = jsonMap["message"];
        else
          result =PaymentDetail.fromJson(jsonMap["data"]);
      } else {
        msg = "网络异常:${response.statusCode}";
      }
    } catch (e) {
      msg = e;
    }

   if(msg.isNotEmpty) Debug.error(msg);

    return result;
  }

  ///支付
  ///[channel] 支付渠道 1支付宝 2微信
  ///[paymentAmount] 支付金额
  ///[orderNo] 订单编号
  Future<dynamic> payment(
      int channel, String paymentAmount, String orderNo) async {
    String url = "$server/market/app/pay/pay";

    String msg = "";

    dynamic result;
    Map<String, dynamic> body = {
      "orderNo": orderNo,
      "channel": channel,
      "paymentAmount": paymentAmount
    };

    try {
      var dio = Dio()..options..options.headers =headers;
    

      var response = await dio.post(url, data: FormData.fromMap(body));

      if (response.statusCode == 200) {
        Map<String, dynamic> jsonMap =response.data as Map;

        Debug.log(jsonMap);

        if (jsonMap["code"] != 200)
          msg = jsonMap["message"];
        else{        
           result = channel==1? jsonMap["data"]:WechatPayment.fromJson(jsonDecode(jsonMap["data"]));  
        }

      } else {
        msg = "网络异常:${response.statusCode}";
      }
    } catch (e) {
      msg = e;
    }

 if(msg.isNotEmpty) Debug.error(msg);

    return result;
  }


///收藏商品
 Future<List<Commodity>> collectionCommodities({
    int pageNum = 1,
    int pageSize = 10,
    String startDate,
    String endDate,
  }) async {
    List<Commodity> result = [];

    String param = HttpUtil.getParams({
      "pageNum": pageNum,
      "pageSize": pageSize,
      "startDate": startDate,
      "endDate": endDate,
    });

    String url = "$server/market/app/personal/mineCollect?$param";

    Debug.log(url);

    String msg = "";

    try {
      var dio = Dio();

      dio.options.headers = headers;

      var response = await dio.get(url);

      if (response.statusCode == 200) {
        Map<String, dynamic> jsonMap = response.data as Map;

         Debug.log(jsonMap);

        msg = jsonMap["message"];

        if (jsonMap["code"] == 200) result = Commodity.fromJsonList(jsonMap["data"]);
      } else {
        msg = "网络异常:${response.statusCode}";
      }
    } catch (e) {
      msg = e;
    }

 if(msg.isNotEmpty) Debug.error(msg);

    return result;
  }

///订单详情 
 Future<OrderDetail> orderDetail(String orderNo) async {
   
    OrderDetail result;

    String param = HttpUtil.getParams({"orderNo": orderNo,});

    String url = "$server/market/app/order/orderDetails?$param";

    Debug.log(url);

    String msg = "";

    try {
      var dio = Dio();

      dio.options.headers = headers;

      var response = await dio.get(url);

      if (response.statusCode == 200) {
        Map<String, dynamic> jsonMap = response.data as Map;

        Debug.log(jsonMap);

        msg = jsonMap["message"];

        if (jsonMap["code"] == 200)
          result = OrderDetail.fromJson(jsonMap["data"]);
      } else {
        msg = "网络异常:${response.statusCode}";
      }
    } catch (e) {
      msg = e;
    }

    Debug.log(msg);

    return result;
  }

///加入收藏 type:0 收藏商品 type:1 收藏店铺
///收藏商品 productNo 必须赋值
///收藏店铺 merchantId 必须赋值
 Future<int> collection({@required int type,String merchantId,String productNo})async{
 
  String url,msg;
 
  FormData formData;
 
  int result;

  switch (type) {
    case 0:
      url = "$server/market/app/goods/collect";
      formData = FormData.fromMap({"productNo": productNo});
      break;
    case 1:
       url = "$server/market/app/shop/collect";
      formData = FormData.fromMap({"merchantId": merchantId});
      break;
    default:
  }

   Debug.log(url);

 try {

      var dio = Dio();

      dio.options.headers = headers;

      var response = await dio.post(url,data:formData);

      if (response.statusCode == 200) {
        Map<String, dynamic> jsonMap = response.data as Map;    

        Debug.log(jsonMap);

        msg = jsonMap["message"];

        if (jsonMap["code"] == 200) result = jsonMap["data"];

      } else {
        msg = "网络异常:${response.statusCode}";
      }
    } catch (e) {
      msg = e;
    }

  if(msg.isNotEmpty) Debug.error(msg);

    return result;

 }

  Future<String> addDeliveryAddress(Deliveryaddress address) async {
    String url = "$server/market/app/address/addAddress";

    String msg = "";

    FormData formData = new FormData.fromMap(address.toJson());

    try {
      var dio = Dio();

      dio.options.headers = headers;

      var response = await dio.post(
        url,
        data: formData,
      );

      if (response.statusCode == 200) {
        Map utf8Content = response.data as Map;

         Debug.log(utf8Content);

        if (utf8Content["code"] != 200) msg = utf8Content["message"];
      } else {
        msg = "网络异常:${response.statusCode}";
      }
    } catch (e) {
      msg = e;
    }

  if(msg.isNotEmpty) Debug.error(msg);

    return msg;
  }

  ///设为默认地址
  Future<String> setDefaultDeliveryAddress(int id) async {
    String url = "$server/market/app/address/toDefault";

    String msg = "";

    try {
      var dio = Dio();
      dio.options.headers = headers;

      var response =
          await dio.put(url, data: FormData.fromMap({"id": id.toString()}));

      if (response.statusCode == 200) {
        Map<String, dynamic> jsonMap = response.data
            as Map; //json.decode(utf8Content); String utf8Content = utf8.decode(response.bodyBytes);

         Debug.log(jsonMap);

        if (jsonMap["code"] != 200) msg = jsonMap["message"];
      } else {
        msg = "网络异常:${response.statusCode}";
      }
    } catch (e) {
      msg = e;
    }

   if(msg.isNotEmpty) Debug.error(msg);

    return msg;
  }

  Future<String> editDeliveryAddress(Deliveryaddress address) async {

    String url = "${server}/market/app/address/editAddress";

    String msg = "";

    try {
      var dio = Dio();
      dio.options.headers = headers;
      var response =
          await dio.put(url, data: FormData.fromMap(address.toJson()));

      if (response.statusCode == 200) {
        Map<String, dynamic> jsonMap = response.data as Map;

         Debug.log(jsonMap);

        if (jsonMap["code"] != 200) msg = jsonMap["message"];
      } else {
        msg = "网络异常:${response.statusCode}";
      }
    } catch (e) {
      msg = e;
    }

     if(msg.isNotEmpty) Debug.error(msg);

    return msg;
  }

  Future<String> deleteDeliveryAddress(int id) async {
    String url = "$server/market/app/address/removeAddress?id=$id";

    String msg = "";

    try {
      var dio = Dio();
      dio.options.headers = headers;

      var response = await dio.delete(
        url,
      );

      if (response.statusCode == 200) {
        Map jsonMap = response.data as Map;

         Debug.log(jsonMap);

        if (jsonMap["code"] != 200) msg = jsonMap["message"];
      } else {
        msg = "网络异常:${response.statusCode}";
      }
    } catch (e) {
      msg = e;
    }

    if(msg.isNotEmpty) Debug.error(msg);

    return msg;
  }

  void sendIMMessage(String merchantId, String encode) {}

}
