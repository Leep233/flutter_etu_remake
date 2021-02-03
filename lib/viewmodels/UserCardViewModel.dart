import 'package:flutter_etu_remake/models/User.dart';

class UserCardViewModel{
  String image;
  String title;
  String subtitle;

  ///1 = 男 ； 2 = 女；
  int gender;

  int footprint;
  int favorites;
  double balance;
  int attention;
  String servicePhone;

UserCardViewModel();

factory UserCardViewModel.transform(User user){
  return UserCardViewModel()..image = user.profile
  ..title = user.nickName
  ..subtitle = user.signature
  ..gender = int.parse(user.gender??'1')
  ..footprint = user.footer
  ..favorites = user.collect
  ..balance =double.parse(user.balance??'0')
  ..attention = user.follow
  ..servicePhone = user.servicePhone; 
}


}