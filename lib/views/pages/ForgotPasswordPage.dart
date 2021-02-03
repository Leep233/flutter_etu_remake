import 'package:flutter/material.dart';
import 'package:flutter_etu_remake/AppDefaultStyle.dart';
import 'package:flutter_etu_remake/Debug.dart';
import 'package:flutter_etu_remake/WidgetComponents.dart';
import 'package:flutter_etu_remake/core/UIManager.dart';
import 'package:flutter_etu_remake/l10n/localization_intl.dart';
import 'package:flutter_etu_remake/views/components/ForgotPasswordInputContentCard.dart';

// ignore: must_be_immutable
class ForgotPasswordPage extends StatelessWidget {
  final GlobalKey<FormFieldState> accuntFormFieldKey =
      GlobalKey<FormFieldState>();
  final GlobalKey<FormFieldState> passwordFormFieldKey =
      GlobalKey<FormFieldState>();
  final GlobalKey<FormFieldState> codeFormFieldKey =
      GlobalKey<FormFieldState>();
  @protected
  BuildContext context;
  @override
  Widget build(BuildContext context) {
    this.context = context;
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(
          toolbarHeight: AppDefaultStyle.appBarHeight,
          centerTitle: true,
          title: Text(AppLocalizations.of(context).forgotPassword,
              style: AppDefaultStyle.appTitleStyle),
          leading: IconButton(
              icon: Icon(Icons.chevron_left, color: Colors.grey[600]),
              onPressed: () {
                Navigator.pop(context);
              }),
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
        ),
        body: _$BuildBodyContent(context));
  }

  Widget _$BuildBodyContent(BuildContext context) {
    return Container(
        margin: EdgeInsets.all(10),
        child: Column(children: [
          ForgotPasswordInputContentCard(
              onPressedGetCode: _onPressGetCode,
              accuntFormFieldKey: accuntFormFieldKey,
              passwordFormFieldKey: passwordFormFieldKey,
              codeFormFieldKey: codeFormFieldKey),
          Container(
              margin: const EdgeInsets.only(top: 20),
              child: WidgetComponents.CommonButton(
                  AppLocalizations.of(context).confirm,
                  style: TextStyle(color: Colors.white),
                  onPressed: _onClickConfirmBtn))
        ]));
  }

  void _onClickConfirmBtn() {
    if (accuntFormFieldKey.currentState.validate() &&
        passwordFormFieldKey.currentState.validate() &&
        codeFormFieldKey.currentState.validate()) {
      UIManager.instance
          .toBack(context, arg: accuntFormFieldKey.currentState.value);
    }
  }

  void _onPressGetCode(String phoneNumber) {
    if (phoneNumber.isNotEmpty) {
      Debug.log('获取验证码 ($phoneNumber)');
    }
  }
}
