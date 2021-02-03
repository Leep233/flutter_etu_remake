// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a zh_Hans_CN locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'zh_Hans_CN';

  static m0(number) => "${Intl.plural(number, zero: '全部评论', other: '全部评论(${number})')}";

  static m1(something) => "点击${something}即代表同意 ";

  static m2(number) => "${Intl.plural(number, zero: '商品评论', other: '商品评论(${number})')}";

  static m3(seconds) => "${Intl.plural(seconds, zero: '获取验证码', other: '重新获取(${seconds})')}";

  static m4(salesVolume) => "${Intl.plural(salesVolume, zero: '', other: '${salesVolume} 人购买')}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static _notInlinedMessages(_) => <String, Function> {
    "addToCart" : MessageLookupByLibrary.simpleMessage("加入购物车"),
    "advantage" : MessageLookupByLibrary.simpleMessage("产品优势"),
    "allComments" : m0,
    "ascendSort" : MessageLookupByLibrary.simpleMessage("升序"),
    "buyNow" : MessageLookupByLibrary.simpleMessage("立即购买"),
    "cancel" : MessageLookupByLibrary.simpleMessage("取消"),
    "chinaMobileCertificationServiceTerms" : MessageLookupByLibrary.simpleMessage("《中国移动认证服务条款》"),
    "clickSomethingIsAgreed" : m1,
    "commodity" : MessageLookupByLibrary.simpleMessage("商品"),
    "commodityComments" : m2,
    "commodityDetail" : MessageLookupByLibrary.simpleMessage("商品详情"),
    "comprehensiveSort" : MessageLookupByLibrary.simpleMessage("综合排序"),
    "confirm" : MessageLookupByLibrary.simpleMessage("确认"),
    "creditSort" : MessageLookupByLibrary.simpleMessage("信用排序"),
    "delete" : MessageLookupByLibrary.simpleMessage("删除"),
    "descendSort" : MessageLookupByLibrary.simpleMessage("降序"),
    "edit" : MessageLookupByLibrary.simpleMessage("编辑"),
    "express" : MessageLookupByLibrary.simpleMessage("快      递"),
    "features" : MessageLookupByLibrary.simpleMessage("产品特色"),
    "forgotPassword" : MessageLookupByLibrary.simpleMessage("忘记密码"),
    "home" : MessageLookupByLibrary.simpleMessage("首页"),
    "hotSale" : MessageLookupByLibrary.simpleMessage("热卖推荐"),
    "inputInviteCodeTip" : MessageLookupByLibrary.simpleMessage("请输入邀请码"),
    "inputPasswordTip" : MessageLookupByLibrary.simpleMessage("请输入密码"),
    "inputPhoneTip" : MessageLookupByLibrary.simpleMessage("请输入手机号码"),
    "inputVerificationCodeTip" : MessageLookupByLibrary.simpleMessage("请输入验证码"),
    "login" : MessageLookupByLibrary.simpleMessage("登录"),
    "mine" : MessageLookupByLibrary.simpleMessage("我的"),
    "originPlace" : MessageLookupByLibrary.simpleMessage("产      地"),
    "otherLoginMode" : MessageLookupByLibrary.simpleMessage("其他登录方式"),
    "passwordLogin" : MessageLookupByLibrary.simpleMessage("密码登录"),
    "phoneNumberWrongTip" : MessageLookupByLibrary.simpleMessage("请输入手机号码 !"),
    "price" : MessageLookupByLibrary.simpleMessage("价格"),
    "quickLoginByPhoneNumber" : MessageLookupByLibrary.simpleMessage("手机一键登录"),
    "quickLoginByWeChat" : MessageLookupByLibrary.simpleMessage("微信登录"),
    "register" : MessageLookupByLibrary.simpleMessage("立即注册"),
    "registeredToLogin" : MessageLookupByLibrary.simpleMessage("已注册，返回登录"),
    "salesVolume" : MessageLookupByLibrary.simpleMessage("销量"),
    "searchContent" : MessageLookupByLibrary.simpleMessage("输入搜索内容"),
    "selectedSpecification" : MessageLookupByLibrary.simpleMessage("已      选"),
    "sendVerificationCode" : m3,
    "shoppingCart" : MessageLookupByLibrary.simpleMessage("购物车"),
    "soldNumber" : m4,
    "submit" : MessageLookupByLibrary.simpleMessage("提交"),
    "suggested" : MessageLookupByLibrary.simpleMessage("推荐搭配"),
    "title" : MessageLookupByLibrary.simpleMessage("Flutter APP"),
    "userRegisterAgreement" : MessageLookupByLibrary.simpleMessage("《用户注册协议》"),
    "userServiceAgreement" : MessageLookupByLibrary.simpleMessage("《用户服务协议》"),
    "verificationLogin" : MessageLookupByLibrary.simpleMessage("验证码登录"),
    "viewMore" : MessageLookupByLibrary.simpleMessage("查看更多")
  };
}
