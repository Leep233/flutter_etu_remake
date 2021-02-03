import 'package:flutter/material.dart';
import 'package:flutter_etu_remake/AppDefaultStyle.dart';
import 'package:flutter_etu_remake/viewmodels/TransactionDetailItemViewModel.dart';
import 'package:flutter_etu_remake/views/components/RefreshListView.dart';
import 'package:flutter_etu_remake/views/pages/UserBalancePage.dart';
class ChangeDetailPage extends StatelessWidget{

 @override
Widget build(BuildContext context) {
     Size screen = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        centerTitle: true,
        toolbarHeight: AppDefaultStyle.appBarHeight,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        leading: IconButton(
          icon: Icon(
            Icons.chevron_left,
            color: Colors.black,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          "零钱明细",
          style: AppDefaultStyle.appTitleStyle,
        ),
      ),
      body: Container(
          padding: const EdgeInsets.only(top: 20),
          width: screen.width,
          height: screen.height,       
          child: Container(child: _$BuildBody(context))),);
}
            
           Widget   _$BuildBody(BuildContext context) {
             return RefreshListView(itemBuilder: (context, index){
                return TransactionDetailItem(data:TransactionDetailItemViewModel(number:99,title: "好友下单",date: '2020-20-20 20:20:20') ,);
             },itemCount: 10,);
           }
}