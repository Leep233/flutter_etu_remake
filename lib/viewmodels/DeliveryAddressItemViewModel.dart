import 'package:flutter_etu_remake/models/Deliveryaddress.dart';

class DeliveryAddressItemViewModel{

  String id;
  String name;
  String phone;
  String address;
  bool isDefault;

String province;
String provinceCode;
String prefecture;
String prefectureCode;
String county;
String countyCode;
String detailAddress;




  DeliveryAddressItemViewModel({this.isDefault = true});

  factory DeliveryAddressItemViewModel.transform(Deliveryaddress addressDisplay) 
  {

    String address =  addressDisplay.consigneeAddress;
   address = (address == null || address.isEmpty)?"${addressDisplay.province??""}${addressDisplay.prefecture??""}${addressDisplay.county??""}${addressDisplay.detailAddress??""}":address;

    return DeliveryAddressItemViewModel()..address = address
    ..id = addressDisplay.id
    ..name = addressDisplay.consignee
    ..phone = addressDisplay.consigneePhone
    ..isDefault = addressDisplay.isDefault==1
    ..province = addressDisplay.province
    ..provinceCode= addressDisplay.provinceCode
    ..prefecture = addressDisplay. prefecture
    ..prefectureCode= addressDisplay.prefectureCode
    ..county= addressDisplay.county
    ..countyCode= addressDisplay.countyCode
    ..detailAddress= addressDisplay.detailAddress ;

   
  }
}