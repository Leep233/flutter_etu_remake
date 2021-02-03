import 'package:flutter_etu_remake/models/Comment.dart';
import 'package:json_annotation/json_annotation.dart';

//flutter packages pub run build_runner build

part 'CommentCardViewModel.g.dart';

@JsonSerializable()
class CommentCardViewModel{

  int id;
  ///用户头像
  String userProfile;
  ///用户昵称
  String username;
  ///规格
  String specification;
  ///商品信息Json(商品编号、规格信息、价格、主图)
  String commodityJson;
  ///评价内容
  String evaluation;
  ///评价图片
  List<String> images;
  ///评价时间
  String commentTime;
  ///回复内容
  String reply;
  ///点赞状态 0未点赞 1已点赞
  int isLike;
  ///点赞数量
  int likeNum;
  ///浏览数量
  int viewNum;
  ///星级
  double starNum;

  CommentCardViewModel();
  factory CommentCardViewModel.fromJson(Map<String, dynamic> json) => _$CommentCardViewModelFromJson(json);
  Map<String, dynamic> toJson() => _$CommentCardViewModelToJson(this);

  factory CommentCardViewModel.transfrom(Comment e) {
    return CommentCardViewModel()..userProfile = e.userProfile
    ..username = e.username
    ..specification = e.specification
    ..commodityJson = e.commodityJson
    ..evaluation = e.evaluation
    ..images = e.images?.split(',')??null
    ..commentTime = e.commentTime
    ..reply = e.reply
    ..isLike = e.isLike 
    ..likeNum = e.likeNum
    ..viewNum = e.viewNum
    ..starNum = e.starNum;

  }

}