import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

///通过intl_translation工具从arb文件生成的代码，
///所以在第一次运行生成命令之前，此文件不存在。
///注释2处的initializeMessages()方法和"messages_all.dart"文件一样，是同时生成的
import 'messages_all.dart'; //

///1.现在我们可以通intl_translation包的工具来提取代码中的字符串到一个arb文件:
/// flutter pub pub run intl_translation:extract_to_arb --output-dir=l10n-arb  lib/l10n/localization_intl.dart
/// 2.arb生成dart文件
/// flutter pub pub run intl_translation:generate_from_arb --output-dir=lib/l10n --no-use-deferred-loading lib/l10n/localization_intl.dart l10n-arb/intl_*.arb

///当前App的本地化字段类
class AppLocalizations {
  AppLocalizations();

  static Future<AppLocalizations> load(Locale locale) {
    final String name =
        locale.countryCode.isEmpty ? locale.languageCode : locale.toString();
    final String localeName = Intl.canonicalizedLocale(name);
    //2
    return initializeMessages(localeName).then((b) {
      Intl.defaultLocale = localeName;
      return new AppLocalizations();
    });
  }

  //标准写法 为了方便获取字段
  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }
  ///新增收货地址
  String get addAddress {
    return Intl.message(
      '新增收货地址',
      name: 'addAddress',
      desc: '新增收货地址',
    );
  }

   String get filtrate {
    return Intl.message(
      '筛选',
      name: 'filtrate',
      desc: '筛选',
    );
  }


  ///立即支付
  String get payment {
    return Intl.message(
      '立即支付',
      name: 'payment',
      desc: '立即支付',
    );
  }
///编辑收货地址
String get editDeliveryAddress  {
    return Intl.message(
      '编辑收货地址',
      name: 'editDeliveryAddress',
      desc: '编辑收货地址',
    );
  }

 String get commodityTotalAmount {
    return Intl.message(
      '商品总额：',
      name: 'commodityTotalAmount',
      desc: '商品总额',
    );
  }

  String get weight {
    return Intl.message(
      '重        量：',
      name: 'weight',
      desc: '重量',
    );
  }

    String get remakes{
    return Intl.message(
      '备        注：',
      name: 'remakes',
      desc: '备注',
    );
  }
  String get freight  {
    return Intl.message(
      '运        费：',
      name: 'freight',
      desc: '运费',
    );
  }

  String get totalAomunt {
    return Intl.message(
      '合        计：',
      name: 'totalAomunt',
      desc: '合计',
    );
  }

  String  get orderTime  {
    return Intl.message(
      '下单时间：',
      name: 'orderTime',
      desc: '下单时间',
    );
  }

 ///确认订单
  String get confirmOrder {
    return Intl.message(
      '确认订单',
      name: 'confirmOrder',
      desc: '确认订单',
    );
  }
  
String get allSelect{
    return Intl.message(
      '全选',
      name: 'allSelect',
      desc: '全选',
    );
  }

///查看全部订单
 String get viewAllOrder {
    return Intl.message(
      '查看全部订单',
      name: 'viewAllOrder',
      desc: '查看全部订单',
    );
  }
///
 String get title {
    return Intl.message(
      '云禾一方',
      name: 'title',
      desc: '云禾一方',
    );
  }

  ///足迹
  String get footprint {
    return Intl.message(
      '足迹',
      name: 'footprint',
      desc: '足迹',
    );
  }
 String get defaultText {
    return Intl.message(
      '默认',
      name: 'defaultText',
      desc: '默认',
    );
  }
///全部
  String get all {
    return Intl.message(
      '全部',
      name: 'all',
      desc: '全部',
    );
  }


  ///待付款
  String get prepayment {
    return Intl.message(
      '待付款',
      name: 'prepayment',
      desc: '待付款',
    );
  }

  ///待发货
  String get predelivery {
    return Intl.message(
      '待发货',
      name: 'predelivery',
      desc: '待发货',
    );
  }

  ///待收货
  String get prereceiving {
    return Intl.message(
      '待收货',
      name: 'prereceiving',
      desc: '待收货',
    );
  }

  ///待评价
  String get preevaluation {
    return Intl.message(
      '待评价',
      name: 'preevaluation',
      desc: '待评价',
    );
  }

  ///退货/售后
  String get aftersales {
    return Intl.message(
      '退货/售后',
      name: 'aftersales',
      desc: '退货/售后',
    );
  }

  ///收货地址
  String get deliveryAddress {
    return Intl.message(
      '收货地址',
      name: 'deliveryAddress',
      desc: '收货地址',
    );
  }

  ///常用工具
  String get commonTools {
    return Intl.message(
      '常用工具',
      name: 'commonTools',
      desc: '常用工具',
    );
  }

  ///客服电话
  String get serivcesTel {
    return Intl.message(
      '客服电话',
      name: 'serivcesTel',
      desc: '客服电话',
    );
  }

  ///邀请好友
  String get inviteFriends {
    return Intl.message(
      '邀请好友',
      name: 'inviteFriends',
      desc: '邀请好友',
    );
  }

  ///意见反馈
  String get feedback {
    return Intl.message(
      '意见反馈',
      name: 'feedback',
      desc: '意见反馈',
    );
  }

  ///收藏夹
  String get favorites {
    return Intl.message(
      '收藏夹',
      name: 'favorites',
      desc: '收藏夹',
    );
  }

  ///关注店铺
  String get attention {
    return Intl.message(
      '关注店铺',
      name: 'attention',
      desc: '关注店铺',
    );
  }

  ///余额
  String get balance {
    return Intl.message(
      '余额',
      name: 'balance',
      desc: '余额',
    );
  }

  ///余额
  String get myOrder {
    return Intl.message(
      '我的订单',
      name: 'myOrder',
      desc: '我的订单',
    );
  }

  ///商品详情
  String get commodityDetail {
    return Intl.message(
      '商品详情',
      name: 'commodityDetail',
      desc: '商品详情',
    );
  }

  ///产品特色
  String get features {
    return Intl.message(
      '产品特色',
      name: 'features',
      desc: '产品特色',
    );
  }

  ///数量
  String get number {
    return Intl.message(
      '数量',
      name: 'number',
      desc: '数量',
    );
  }

  ///加入购物车
  String get addToCart {
    return Intl.message(
      '加入购物车',
      name: 'addToCart',
      desc: '加入购物车',
    );
  }

  ///立即购买
  String get buyNow {
    return Intl.message(
      '立即购买',
      name: 'buyNow',
      desc: '立即购买',
    );
  }

  ///产品优势
  String get advantage {
    return Intl.message(
      '产品优势',
      name: 'advantage',
      desc: '产品优势',
    );
  }

  //已选规格
  String get selectedSpecification {
    return Intl.message(
      '已        选',
      name: 'selectedSpecification',
      desc: '已选规格',
    );
  }

  ///快递
  String get express {
    return Intl.message(
      '快        递',
      name: 'express',
      desc: '快递',
    );
  }

  ///产地
  String get originPlace {
    return Intl.message(
      '产        地',
      name: 'originPlace',
      desc: '产地',
    );
  }

  ///推荐搭配
  String get suggested {
    return Intl.message(
      '推荐搭配',
      name: 'suggested',
      desc: '推荐搭配',
    );
  }

  ///
  String get searchContent {
    return Intl.message(
      '输入搜索内容',
      name: 'searchContent',
      desc: '输入搜索内容',
    );
  }

  ///密码登录
  String get passwordLogin {
    return Intl.message(
      '密码登录',
      name: 'passwordLogin',
      desc: '密码登录',
    );
  }

  ///验证码登录
  String get verificationLogin {
    return Intl.message(
      '验证码登录',
      name: 'verificationLogin',
      desc: '验证码登录',
    );
  }

  ///请输入手机号码提示
  String get inputPhoneTip {
    return Intl.message(
      '请输入手机号码',
      name: 'inputPhoneTip',
      desc: '请输入手机号码提示',
    );
  }

  ///n人购买
  String soldNumber(int howmany) {
    return Intl.plural(
      howmany,
      name: 'soldNumber',
      zero: "",
      other: '$howmany 人购买',
      args: [howmany],
      desc: 'n人购买',
    );
  }

///库存不足
 String  understock(int howmany) {

    return Intl.plural(
      howmany,
      name: 'understock',
      zero: "库存不足(库存:$howmany)",
      other:"库存不足(库存:$howmany)",
      args: [howmany],
      desc: '库存不足(库存:2)',
    );  
  }
  ///商品评论（N）
  String commodityComments(int howmany) {
    return Intl.plural(
      howmany,
      name: 'commodityComments',
      zero: "商品评论",
      other: '商品评论($howmany)',
      args: [howmany],
      desc: '商品评论（N）',
    );
  }

  ///全部评论（N）
  String allComments(int howmany) {
    return Intl.plural(
      howmany,
      name: 'allComments',
      zero: "全部评论",
      other: '全部评论($howmany)',
      args: [howmany],
      desc: '全部评论（N）',
    );
  }
///共n件
   String quantity(int howmany) {
    return Intl.plural(
      howmany,
      name: 'quantity',
      zero: "共 $howmany 件",
      other: '共 $howmany 件',
      args: [howmany],
      desc: '共1 件',
    );
  }
  /// n 收藏
   String collectionNumber(int howmany) {
   return Intl.message(
      '$howmany 收藏',
      name: 'collectionNumber',
      args:[howmany] ,
      desc: '99 收藏',
    );
  }

///合计
 String get total {
    return Intl.message(
      '合计',
      name: 'total',
      desc: '合计',
    );
  }

  ///请输入手机号码提示
  String get phoneNumberWrongTip {
    return Intl.message(
      '请输入手机号码 !',
      name: 'phoneNumberWrongTip',
      desc: '请输入手机号码 !',
    );
  }

  ///请输入密码提示
  String get inputPasswordTip {
    return Intl.message(
      '请输入密码',
      name: 'inputPasswordTip',
      desc: '请输入密码',
    );
  }

  ///请输入验证码提示
  String get inputVerificationCodeTip {
    return Intl.message(
      '请输入验证码',
      name: 'inputVerificationCodeTip',
      desc: '请输入验证码',
    );
  }

  ///获取验证码/重新获取($seconds)
  String sendVerificationCode(int seconds) {
    return Intl.plural(
      seconds,
      name: 'sendVerificationCode',
      zero: "获取验证码",
      other: '重新获取($seconds)',
      args: [seconds],
      desc: "获取验证码/重新获取(23)",
    );
  }
///粉丝数：0
 String funs(int howMany) {
    return Intl.plural(
      howMany,
      name: 'funs',
      zero: "粉丝数：0",
      other: '粉丝数：$howMany',
      args: [howMany],
      desc: "粉丝数：23",
    );
  }


  ///请输入邀请码提示
  String get inputInviteCodeTip {
    return Intl.message(
      '请输入邀请码',
      name: 'inputInviteCodeTip',
      desc: '请输入邀请码',
    );
  }

  ///点击$something 即代表同意
  String clickSomethingIsAgreed(String something) {
    return Intl.message(
      '点击$something即代表同意 ',
      name: 'clickSomethingIsAgreed',
      args: [something],
      desc: '点击登录 即代表同意',
    );
  }

  ///登录
  String get login {
    return Intl.message(
      '登录',
      name: 'login',
      desc: '登录',
    );
  }

  ///忘记密码
  String get forgotPassword {
    return Intl.message(
      '忘记密码',
      name: 'forgotPassword',
      desc: '忘记密码',
    );
  }

  ///确认
  String get confirm {
    return Intl.message(
      '确认',
      name: 'confirm',
      desc: '确认',
    );
  }

  ///提交
  String get submit {
    return Intl.message(
      '提交',
      name: 'submit',
      desc: '提交',
    );
  }

  ///我的
  String get mine {
    return Intl.message(
      '我的',
      name: 'mine',
      desc: '我的',
    );
  }

  ///首页
  String get home {
    return Intl.message(
      '首页',
      name: 'home',
      desc: '首页',
    );
  }

  ///购物车
  String get shoppingCart {
    return Intl.message(
      '购物车',
      name: 'shoppingCart',
      desc: '购物车',
    );
  }

  ///商品分类
  String get commodityCategory {
    return Intl.message(
      '商品分类',
      name: 'commodityCategory',
      desc: '商品分类',
    );
  }

  ///商品
  String get commodity {
    return Intl.message(
      '商品',
      name: 'commodity',
      desc: '商品',
    );
  }

  ///查看更多
  String get viewMore {
    return Intl.message(
      '查看更多',
      name: 'viewMore',
      desc: '查看更多',
    );
  }

  ///热卖推荐
  String get hotSale {
    return Intl.message(
      '热卖推荐',
      name: 'hotSale',
      desc: '热卖推荐',
    );
  }

  ///综合排序
  String get comprehensiveSort {
    return Intl.message(
      '综合排序',
      name: 'comprehensiveSort',
      desc: '综合排序',
    );
  }

  ///升序
  String get ascendSort {
    return Intl.message(
      '升序',
      name: 'ascendSort',
      desc: '升序',
    );
  }

  ///降序
  String get descendSort {
    return Intl.message(
      '降序',
      name: 'descendSort',
      desc: '降序',
    );
  }

  ///销量
  String get salesVolume {
    return Intl.message(
      '销量',
      name: 'salesVolume',
      desc: '销量',
    );
  }

  ///价格
  String get price {
    return Intl.message(
      '价格',
      name: 'price',
      desc: '价格',
    );
  }

  ///信用排序
  String get creditSort {
    return Intl.message(
      '信用排序',
      name: 'creditSort',
      desc: '信用排序',
    );
  }

  ///取消
  String get cancel {
    return Intl.message(
      '取消',
      name: 'cancel',
      desc: '取消',
    );
  }

  ///编辑
  String get edit {
    return Intl.message(
      '编辑',
      name: 'edit',
      desc: '编辑',
    );
  }

  ///完成
  String get finshed {
    return Intl.message(
      '完成',
      name: 'finshed',
      desc: '完成',
    );
  }

  ///删除
  String get delete {
    return Intl.message(
      '删除',
      name: 'delete',
      desc: '删除',
    );
  }

  ///立即注册
  String get register {
    return Intl.message(
      '立即注册',
      name: 'register',
      desc: '立即注册',
    );
  }

  ///已注册，返回登录
  String get registeredToLogin {
    return Intl.message(
      '已注册，返回登录',
      name: 'registeredToLogin',
      desc: '已注册，返回登录',
    );
  }

  ///其他登录方式
  String get otherLoginMode {
    return Intl.message(
      '其他登录方式',
      name: 'otherLoginMode',
      desc: '其他登录方式',
    );
  }

  ///手机一键登录
  String get quickLoginByPhoneNumber {
    return Intl.message(
      '手机一键登录',
      name: 'quickLoginByPhoneNumber',
      desc: '手机一键登录',
    );
  }

  ///微信登录
  String get quickLoginByWeChat {
    return Intl.message(
      '微信登录',
      name: 'quickLoginByWeChat',
      desc: '微信登录',
    );
  }

  ///用户注册协议
  String get userRegisterAgreement {
    return Intl.message(
      '《用户注册协议》',
      name: 'userRegisterAgreement',
      desc: '用户注册协议',
    );
  }

  String get chinaMobileCertificationServiceTerms {
    return Intl.message(
      '《中国移动认证服务条款》',
      name: 'chinaMobileCertificationServiceTerms',
      desc: '中国移动认证服务条款',
    );
  }

  ///用户服务协议
  String get userServiceAgreement {
    return Intl.message(
      '《用户服务协议》',
      name: 'userServiceAgreement',
      desc: '用户服务协议',
    );
  }
}

//Locale代理类
class AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const AppLocalizationsDelegate();

//是否支持某个Local
  @override
  bool isSupported(Locale locale) {
    // TODO: implement isSupported
    return ['en', 'zh'].contains(locale.languageCode);
  }

  /// Flutter会调用此类加载相应的Locale资源类
  @override
  Future<AppLocalizations> load(Locale locale) {
    // TODO: implement load
    print("AppLocalizationsDelegate.Load $locale");
    return AppLocalizations.load(locale);
  }

  // 当Localizations Widget重新build时，是否调用load重新加载Locale资源.
  @override
  bool shouldReload(covariant LocalizationsDelegate<AppLocalizations> old) {
    return false;
  }
}
