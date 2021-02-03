import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_etu_remake/AppDefaultStyle.dart';
import 'package:flutter_etu_remake/WidgetComponents.dart';
import 'package:flutter_etu_remake/l10n/localization_intl.dart';

///手机一键登录
class QuickLoginByPhoneNumberPage extends StatelessWidget {

  
  String _phoneNumber;

  @override
  Widget build(BuildContext context) {
    _phoneNumber = ModalRoute.of(context).settings.arguments.toString();

    String number = _phoneNumber.replaceRange(3, 7, "****");

    String login = AppLocalizations.of(context).login;

    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
            icon: Icon(Icons.chevron_left, color: Colors.grey[600]),
            onPressed: () {
              Navigator.pop(context);
            }),
        centerTitle: true,
        toolbarHeight: AppDefaultStyle.appBarHeight,
        backgroundColor: Colors.white,
        title: Text(login, style: AppDefaultStyle.appTitleStyle),
      ),
      body: Container(
          margin: EdgeInsets.fromLTRB(0, 50, 0, 0),
          child: Column(
            children: [
              Container(
                  child: Text(number,
                      style: TextStyle(color: Colors.black87, fontSize: 16))),
              WidgetComponents.CommonButton(
                login,
                margin: EdgeInsets.fromLTRB(10, 20, 10, 10),
                style: TextStyle(color: Colors.white),
                onPressed: _onClickLoginBtn,
              ),
              Expanded(child: SizedBox()),
              Container(
                  margin: EdgeInsets.fromLTRB(30, 0, 30, 10),
                  child: RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                          text: AppLocalizations.of(context)
                              .clickSomethingIsAgreed(login),
                          style: TextStyle(color: Colors.black87, fontSize: 12),
                          children: [
                            TextSpan(
                                text: AppLocalizations.of(context)
                                    .chinaMobileCertificationServiceTerms,
                                style:
                                    TextStyle(color: Colors.red, fontSize: 12),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = _onClickProtocolBtn,
                                children: [
                                  TextSpan(
                                    text: "",
                                    style: TextStyle(
                                        color: Colors.black87, fontSize: 12),
                                  )
                                ])
                          ]))),
            ],
          )),
    );
  }

  void _onClickProtocolBtn() {
    print("吧啦啦啦啦协议");
  }

  void _onClickLoginBtn() {
    print("登录");
  }
}
