import 'dart:convert';

import 'package:azlistview/azlistview.dart';
import 'package:json_annotation/json_annotation.dart';

//flutter packages pub run build_runner build

part 'City.g.dart';

@JsonSerializable()
class City implements ISuspensionBean{

  String name;
  
  String tagIndex;

  String shrink;

  String namePinyin;

  City({this.name,this.tagIndex});

  factory City.fromJson(Map<String, dynamic> json) => _$CityFromJson(json);
  Map<String, dynamic> toJson() => _$CityToJson(this);

   @override
  String getSuspensionTag() => tagIndex;

  @override
  String toString() => json.encode(this);

  @override
  bool isShowSuspension;

}