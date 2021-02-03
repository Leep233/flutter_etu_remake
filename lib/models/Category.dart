import 'package:flutter_etu_remake/models/Commodity.dart';
import 'package:json_annotation/json_annotation.dart';

//flutter packages pub run build_runner build

part 'Category.g.dart';

@JsonSerializable()
class Category{

  int id;
  String categoryName;
  List<Category> categories;
  List<Commodity> productInfos;


  Category();
  factory Category.fromJson(Map<String, dynamic> json) => _$CategoryFromJson(json);
  Map<String, dynamic> toJson() => _$CategoryToJson(this);

  static List<Category> fromJsonList(List<dynamic> jsonMap) {
     List<Category> list = [];
     jsonMap?.forEach((element) {
       list.add(Category.fromJson(element));
     });
     return list;
  }

}