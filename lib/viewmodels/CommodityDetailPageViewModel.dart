import 'dart:convert';
import 'package:flutter_etu_remake/models/CommodityDetail.dart';
import 'package:flutter_etu_remake/viewmodels/CommentCardViewModel.dart';
import 'package:json_annotation/json_annotation.dart';

//flutter packages pub run build_runner build

part 'CommodityDetailPageViewModel.g.dart';

@JsonSerializable()
class CommodityDetailPageViewModel {

  String id;

  String storeId;

  String productNo;

  String mianPicture;

  double price;

  double originalPrice;

  String title;

  String subTitle;

  String details;

  String placeOfProduct;

  String feature;

  String advantage;

  String suggested;

  String postage;

  String address;

  int addressId;

  

  List<String> images;

  bool isFavorite;

  List<CommentCardViewModel> comments;

  Map<String, List<String>> specifications;

  //选择的规格
  Map<String, String> selectedSpecification;

  CommodityDetailPageViewModel();
  factory CommodityDetailPageViewModel.fromJson(Map<String, dynamic> json) =>
      _$CommodityDetailPageViewModelFromJson(json);
  Map<String, dynamic> toJson() => _$CommodityDetailPageViewModelToJson(this);

  static CommodityDetailPageViewModel transfrom(CommodityDetail value) {
/*
 (json['specifications'] as Map<String, dynamic>)?.map(
      (k, e) => MapEntry(k, (e as List)?.map((e) => e as String)?.toList()),
    )
 */
    Map<String, List<String>> spec = {};

    Map<String, dynamic> map = jsonDecode(value.specificationJson);

    map?.forEach((key, value) {
      spec.putIfAbsent(key, () => []);
      (value as List).forEach((element) {
        spec[key].add(element.toString());
      });
    });
 
    return CommodityDetailPageViewModel()
    ..storeId = value.belongMerchant?.toString()
      ..id = value.id?.toString()    
      ..productNo = value.productNo
      ..mianPicture = value.mainPicture
      ..price = double.parse(value?.price?.toString() ?? '0')
      ..originalPrice = double.parse(value?.originPrice?.toString() ?? '0')
      ..title = value.title
      ..subTitle = value.subtitle
      ..details = value.details
      ..images = value.slideShow.split(',')
      ..isFavorite = value.isCollect == 1
      ..placeOfProduct = value.placeOfProduct
      ..feature = value.feature
      ..advantage = value.advantage
      ..suggested = value.recommendMatch
      ..postage = value.fareAmount
      ..address = value.consigneeAddress
     // ..addressId = value.
      ..comments = value.evaluationInfos
          ?.map((e) => e == null ? null : CommentCardViewModel.transfrom(e))
          ?.toList()
      ..specifications = spec;
  }
}
