import 'package:flutter/material.dart';
import 'package:flutter_etu_remake/AppDefaultStyle.dart';
import 'package:flutter_etu_remake/core/NetworkManager.dart';
import 'package:flutter_etu_remake/core/UIManager.dart';
import 'package:flutter_etu_remake/viewmodels/TransactionDetailItemViewModel.dart';
import 'package:flutter_etu_remake/viewmodels/UserBalancePageViewModel.dart';

import 'package:flutter/material.dart';

class UserBalancePage extends StatefulWidget {
  UserBalancePage({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => UserBalancePageState();
}

class UserBalancePageState extends State<UserBalancePage> {
  UserBalancePageViewModel _viewModel;

  @override
  void initState() {
    super.initState();
    NetworkManager.instance.userBalance().then((value) {
      _viewModel = UserBalancePageViewModel.transform(value);
      if (mounted) setState(() {});
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void deactivate() {
    super.deactivate();
  }

  Decoration get buttonDecoration {
    return BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        gradient: LinearGradient(
          begin: Alignment(0.0, -1.0),
          end: Alignment(0.0, 1.0),
          colors: <Color>[
            Colors.white,
            Color(0xFFFFC996),
          ],
        ));
  }

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
          "我的余额",
          style: AppDefaultStyle.appTitleStyle,
        ),
      ),
      body: Container(
          padding: const EdgeInsets.only(top: 20),
          width: screen.width,
          height: screen.height,
          decoration: BoxDecoration(
              image: DecorationImage(
                  alignment: Alignment.topCenter,
                  fit: BoxFit.fitWidth,
                  image: AssetImage('assets/images/balance_bg.png'))),
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 10),
            child: _$BuildBody(context),
          )),
    );
  }

  Widget _$BuildBody(BuildContext context) {
    return Column(children: [
      Text(_viewModel?.balance ?? "0.00",
          style: TextStyle(
              color: Colors.white, fontSize: 32, fontWeight: FontWeight.bold)),
      Text('账户余额', style: TextStyle(color: Colors.white)),
      Container(
          margin: const EdgeInsets.only(top: 20),
          decoration: buttonDecoration,
          child: FlatButton(
              height: 30,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30)),
              textColor: Colors.orange[800],
              onPressed: () =>
                  UIManager.instance.toPage(context, UIDef.withdrawal),
              child: Text(
                "提现",
                style: TextStyle(fontSize: 16),
              ))),
      Expanded(
        child: Container(
            margin: const EdgeInsets.only(top: 25),
            width: double.infinity,
            child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                child: Container(
                    child: Column(children: [
                  Container(
                    margin: const EdgeInsets.all(15),
                    alignment: Alignment.centerLeft,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "来源明细",
                          style: AppDefaultStyle.titleStyle01,
                        ),
                        TextButton(
                            onPressed: () => UIManager.instance
                                .toPage(context, UIDef.changeDetail),
                            child: Row(children: [
                              Text(
                                "查看全部",
                                style:
                                    TextStyle(color: Colors.grey, fontSize: 12),
                              ),
                              Icon(
                                Icons.chevron_right,
                                color: Colors.grey,
                              )
                            ]))
                      ],
                    ),
                  ),
                  Expanded(
                      child: ListView.builder(
                          itemBuilder: (context, index) =>
                              TransactionDetailItem(
                                data: _viewModel?.details[index],
                              ),
                          itemCount: _viewModel?.details?.length ?? 0))
                ])))),
      )
    ]);
  }
}

// ignore: must_be_immutable

class TransactionDetailItem extends StatelessWidget {
  final TransactionDetailItemViewModel data;

  TransactionDetailItem({this.data});

  @override
  Widget build(BuildContext context) {
    double number = data?.number ?? 0;

    return ListTile(
      trailing: Text(
        number?.toStringAsFixed(2),
        style: TextStyle(
            fontSize: 20,
            color: number < 0 ? Colors.black : Colors.red,
            fontWeight: FontWeight.bold),
      ),
      onTap: null,
      title: Text(data?.title ?? "",
          style: const TextStyle(color: Colors.black, fontSize: 16)),
      subtitle: Text(data?.date ?? "",
          style: const TextStyle(
            color: Colors.grey,
            fontSize: 14,
          )),
    );
  }
}
