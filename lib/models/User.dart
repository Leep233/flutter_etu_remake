import 'package:json_annotation/json_annotation.dart';

//flutter packages pub run build_runner build

part 'User.g.dart';

/* 

0:"id" -> 1
1:"phone" -> "19979824441"
2:"actualName" -> null
3:"nickName" -> "手机用户_4441"
4:"birthday" -> null
5:"gender" -> null
6:"signature" -> "个性签名"
7:"referrer" -> null
8:"profile" -> "https://e-buy.oss-cn-shenzhen.aliyuncs.com/user/default_user.png"
9:"status" -> 1
10:"balance" -> "1000.00"
11:"footer" -> 13
12:"collect" -> 0
13:"follow" -> 1
14:"receiveNotify" -> 1
15:"inviteCode" -> "C7GIN4"
16:"sign" -> null
17:"orderNum" -> Map (7 items)
18:"servicePhone" -> "13670482078"
19:"haveUnRead" -> true


*/

@JsonSerializable()
class User{

  int id;
  String phone;
  String actualName;
  String nickName;
  String birthday;
  String gender;
  String signature;
  String referrer;
  String profile;
  int status;
  String balance;
  int footer;
  int collect;
  int follow;
  int receiveNotify;
  String inviteCode;
  String sign;
  String servicePhone;

  User();
  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
  
  Map<String,dynamic> toJson() => _$UserToJson(this);

  



}