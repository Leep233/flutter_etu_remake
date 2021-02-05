import 'package:flutter_etu_remake/models/BalanceDetail.dart';

class TransactionDetailItemViewModel{
  String id;
  String title;
  String date;
  double number;

  TransactionDetailItemViewModel({this.title,this.date,this.number});

factory TransactionDetailItemViewModel.transform(BalanceDetail detail){
  return TransactionDetailItemViewModel()..id = detail.id?.toString()
       ..title = detail.useDescription
       ..date = detail.recordTime
       ..number = detail.expenseRecord;
}

}