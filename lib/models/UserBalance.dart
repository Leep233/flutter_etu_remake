import 'package:flutter_etu_remake/models/BalanceDetail.dart';
import 'package:json_annotation/json_annotation.dart';

//flutter packages pub run build_runner build

part 'UserBalance.g.dart';

@JsonSerializable()
class UserBalance{

  String balance;

  List<BalanceDetail> balanceDetailList;

  UserBalance();
  factory UserBalance.fromJson(Map<String, dynamic> json) => _$UserBalanceFromJson(json);
  Map<String, dynamic> toJson() => _$UserBalanceToJson(this);

}