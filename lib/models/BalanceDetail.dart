import 'package:json_annotation/json_annotation.dart';

//flutter packages pub run build_runner build

part 'BalanceDetail.g.dart';

@JsonSerializable()
class BalanceDetail{
int id;
  ///
  String useDescription;
  ///
  double expenseRecord;
  ///
  String recordTime;

  BalanceDetail();
  factory BalanceDetail.fromJson(Map<String, dynamic> json) => _$BalanceDetailFromJson(json);
  Map<String, dynamic> toJson() => _$BalanceDetailToJson(this);

}