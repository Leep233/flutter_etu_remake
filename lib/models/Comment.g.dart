// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Comment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Comment _$CommentFromJson(Map<String, dynamic> json) {
  return Comment()
    ..id = json['id'] as int
    ..userProfile = json['userProfile'] as String
    ..username = json['username'] as String
    ..specification = json['specification'] as String
    ..commodityJson = json['commodityJson'] as String
    ..evaluation = json['evaluation'] as String
    ..images = json['images'] as String
    ..commentTime = json['commentTime'] as String
    ..reply = json['reply'] as String
    ..isLike = json['isLike'] as int
    ..likeNum = json['likeNum'] as int
    ..viewNum = json['viewNum'] as int
    ..starNum = (json['starNum'] as num)?.toDouble();
}

Map<String, dynamic> _$CommentToJson(Comment instance) => <String, dynamic>{
      'id': instance.id,
      'userProfile': instance.userProfile,
      'username': instance.username,
      'specification': instance.specification,
      'commodityJson': instance.commodityJson,
      'evaluation': instance.evaluation,
      'images': instance.images,
      'commentTime': instance.commentTime,
      'reply': instance.reply,
      'isLike': instance.isLike,
      'likeNum': instance.likeNum,
      'viewNum': instance.viewNum,
      'starNum': instance.starNum,
    };
