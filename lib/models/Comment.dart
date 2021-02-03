import 'package:json_annotation/json_annotation.dart';

//flutter packages pub run build_runner build

part 'Comment.g.dart';

/*
0:"id" -> 14
1:"userProfile" -> "https://e-buy.oss-cn-shenzhen.aliyuncs.com/user/default_user.png"
2:"username" -> "手机用户_0207"
3:"specification" -> null
4:"commodityJson" -> "{"shopName":"云娜时装城","productNo":"10000052","commodityNo":"10000052001","title":"鸭鸭羽绒服男2020年新款连帽防风保暖潮流帅气短款冬季男士外套潮","subTitle":"羽绒…"
5:"evaluation" -> "好评"
6:"images" -> "https://e-buy.oss-cn-shenzhen.aliyuncs.com/evaluation/161069878094150484.png"
7:"commentTime" -> "3天前"
8:"reply" -> null
9:"isLike" -> 0
10:"likeNum" -> 0
11:"viewNum" -> 0
12:"starNum" -> 5.0
 */

@JsonSerializable()
class Comment{

  int id;
  String userProfile;
  String username;
  String specification;
  String commodityJson;
  String evaluation;
  String images;
  String commentTime;
  String reply;
  int isLike;
  int likeNum;
  int viewNum;
  double starNum;


  Comment();
  factory
  
   Comment.fromJson(Map<String, dynamic> json) => _$CommentFromJson(json);
  Map<String, dynamic> toJson() => _$CommentToJson(this);





}