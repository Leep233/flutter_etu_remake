import 'package:json_annotation/json_annotation.dart';

//flutter packages pub run build_runner build

part 'PaymentDetail.g.dart';

@JsonSerializable()
class PaymentDetail{

  String orderNo;
  double payAmount;
  String date;

  PaymentDetail();
  factory PaymentDetail.fromJson(Map<String, dynamic> json) => _$PaymentDetailFromJson(json);
  Map<String, dynamic> toJson() => _$PaymentDetailToJson(this);

}