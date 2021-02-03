import 'package:flutter_etu_remake/models/StoreDetial.dart';

class CollectionStoreCardViewModel{
  String storeId;
  String profile;
  String title;
  String subtitle;
  List<String> commodityIds;
  List<String> images;
CollectionStoreCardViewModel();
  factory CollectionStoreCardViewModel.transform(StoreDetial e) 
  {
List<String>ids = [];
List<String> imgs = [];

e.commodityList?.forEach((element) {
  ids.add(element?.productNo?.toString()??"");
  imgs.add(element?.mainPicture??"");
});

     return CollectionStoreCardViewModel()
     ..storeId = e.id.toString()??""
     ..profile  = e.merchantPicture
     ..title = e.shopName
     ..subtitle = e.followTime
     ..commodityIds = ids
     ..images = imgs;

  }
}