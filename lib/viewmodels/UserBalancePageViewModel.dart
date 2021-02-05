import 'package:flutter_etu_remake/models/UserBalance.dart';
import 'package:flutter_etu_remake/viewmodels/TransactionDetailItemViewModel.dart';

class UserBalancePageViewModel{
  String balance;
  List<TransactionDetailItemViewModel> details;
UserBalancePageViewModel();

factory UserBalancePageViewModel.transform(UserBalance balance){
  return UserBalancePageViewModel()..balance = balance.balance
  ..details = balance.balanceDetailList?.map((e) => TransactionDetailItemViewModel.transform(e))?.toList();
}

}
