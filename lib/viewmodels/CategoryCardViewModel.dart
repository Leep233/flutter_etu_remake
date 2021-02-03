import 'package:flutter_etu_remake/models/Category.dart';
import 'package:flutter_etu_remake/models/Commodity.dart';

class CategoryCardViewModel {
  String id;
  String name;
  List<CategoryCardViewModel> categories;
  List<CategoryCommodity> commodities;

  CategoryCardViewModel();

   factory CategoryCardViewModel.tranform(Category gategory) {
      return CategoryCardViewModel()..id = gategory?.id?.toString()??"0"
      ..name = gategory.categoryName
      ..categories = gategory.categories?.map((e) => CategoryCardViewModel.tranform(e))?.toList()
      ..commodities = gategory.productInfos?.map((e) => CategoryCommodity.tranform(e))?.toList();
   }
}

class CategoryCommodity {
  String id;
  String image;
  String title;
  CategoryCommodity();

  factory CategoryCommodity.tranform(Commodity commodity) {
    return CategoryCommodity()
      ..id = commodity.productNo
      ..image = commodity.mainPicture
      ..title = commodity.title;
  }
}
