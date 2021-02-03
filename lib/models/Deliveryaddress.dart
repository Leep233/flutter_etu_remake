import 'package:json_annotation/json_annotation.dart';

//flutter packages pub run build_runner build

part 'Deliveryaddress.g.dart';

@JsonSerializable()
class Deliveryaddress{

/*
0:"id" -> "1"
1:"consignee" -> "lll"
2:"consigneePhone" -> "19979824441"
3:"province" -> "广东省"
4:"prefecture" -> "深圳市"
5:"county" -> "宝安区"
6:"detailAddress" -> "hggggdg"
7:"consigneeAddress" -> "广东省深圳市宝安区hggggdg"


0:"id" -> 1
1:"consignee" -> "lll"
2:"consigneePhone" -> "19979824441"
3:"province" -> "广东省"
4:"provinceCode" -> null
5:"prefecture" -> "深圳市"
6:"prefectureCode" -> null
7:"county" -> "宝安区"
8:"countyCode" -> null
9:"detailAddress" -> "hggggdg"
10:"isDefault" -> 1

 */


String id;
String consignee;
String consigneePhone;
String province;
String provinceCode;
String prefecture;
String prefectureCode;
String county;
String countyCode;
String detailAddress;
String consigneeAddress;
int isDefault;

  Deliveryaddress();
  factory Deliveryaddress.fromJson(Map<String, dynamic> json) => _$DeliveryaddressFromJson(json);
  Map<String, dynamic> toJson() => _$DeliveryaddressToJson(this);

}