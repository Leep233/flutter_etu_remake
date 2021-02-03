import 'package:flutter/material.dart';
import 'package:flutter_etu_remake/AppDefaultStyle.dart';
import 'package:flutter_etu_remake/Debug.dart';
import 'package:flutter_etu_remake/WidgetComponents.dart';
import 'package:flutter_etu_remake/l10n/localization_intl.dart';
import 'package:flutter_etu_remake/views/components/RegisterInputContentCard.dart';

// ignore: must_be_immutable
class RegisterPage extends StatelessWidget {
  final GlobalKey<FormFieldState> phoneFormFieldKey =
      GlobalKey<FormFieldState>();

  final GlobalKey<FormFieldState> pwdFormFieldKey = GlobalKey<FormFieldState>();

  final GlobalKey<FormFieldState> verifyCodeFormFieldKey =
      GlobalKey<FormFieldState>();

  final GlobalKey<FormFieldState> inviteCodeFormFieldKey =
      GlobalKey<FormFieldState>();

  @protected
  BuildContext context;

  @override
  Widget build(BuildContext context) {
    this.context = context;
    // TODO: implement build
    return Scaffold(
      resizeToAvoidBottomInset: false,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        toolbarHeight: AppDefaultStyle.appBarHeight,
        centerTitle: true,
        title: Text(AppLocalizations.of(context).register,style: TextStyle(fontSize:AppDefaultStyle.AppTitleFontSize),),
        leading: IconButton(
          icon: Icon(Icons.chevron_left_rounded),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
      ),
      body: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  alignment: Alignment.topCenter,
                  fit: BoxFit.fitWidth,
                  image: AssetImage('assets/images/login_bg.png'))),
          child: _$BuildContent(context)),
    );
  }

  // ignore: missing_return
  Widget _$BuildContent(BuildContext context) {
    return Container(
        margin: const EdgeInsets.fromLTRB(10, 70, 10, 20),
        child: Column(children: [
          Container(
            child: RegisterInputContextCard(
              accuntFormFieldKey: phoneFormFieldKey,
              pwdFormFieldKey: pwdFormFieldKey,
              verifyCodeFormFieldKey: verifyCodeFormFieldKey,
              inviteCodeFormFieldKey: inviteCodeFormFieldKey,
              onPressedGetCode: _onClickGetCode,
            ),
            // height: 180,
          ),
          Container(
              margin: EdgeInsets.all(10),
              child:
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Text(AppLocalizations.of(context).clickSomethingIsAgreed(
                    AppLocalizations.of(context).register)),
                GestureDetector(
                  child: Text(
                    AppLocalizations.of(context).userRegisterAgreement,
                    style: TextStyle(color: Colors.red),
                  ),
                  onTap: _onClickRegisterAgreementBtn,
                )
              ])),
          WidgetComponents.CommonButton(
            AppLocalizations.of(context).register,
            style: TextStyle(color: Colors.white),
            onPressed: _onClickRegisterBtn,
            margin: EdgeInsets.fromLTRB(5, 10, 5, 10),
          ),
          GestureDetector(
            child: Text(
              AppLocalizations.of(context).register,
            ),
            onTap: () {
              Navigator.pop(context);
            },
          )
        ]));
  }

  void _onClickGetCode(String phoneNumber) {
    if (phoneNumber.isNotEmpty) {
      Debug.log('获取验证码 ($phoneNumber)');
    }
  }

  void _onClickRegisterBtn() {
    Navigator.pop(context, phoneFormFieldKey.currentState.value);

    if (phoneFormFieldKey.currentState.validate() &&
        pwdFormFieldKey.currentState.validate() &&
        verifyCodeFormFieldKey.currentState.validate()) {
      String phoneNumber = phoneFormFieldKey.currentState.value;
      String pwdCode = pwdFormFieldKey.currentState.value;
      String verifyCode = verifyCodeFormFieldKey.currentState.value;
      String inviteCode = inviteCodeFormFieldKey.currentState.value;

      Debug.log(
          '立即注册=> 电话: $phoneNumber 密码: $pwdCode 验证码: $verifyCode 邀请码: $inviteCode');
    }
  }

  void _onClickRegisterAgreementBtn() {
    Debug.log("《注册协议》");
  }
}
