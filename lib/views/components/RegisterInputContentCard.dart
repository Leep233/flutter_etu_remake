import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_etu_remake/AppDefaultStyle.dart';
import 'package:flutter_etu_remake/WidgetComponents.dart';
import 'package:flutter_etu_remake/l10n/localization_intl.dart';

class RegisterInputContextCard extends StatefulWidget {
  
  final TextEditingController phoneTextEditingController;
  final TextEditingController passwordTextEditingController;
  final TextEditingController verificationCodeTextEditingController;
  final TextEditingController inviteCodeTextEditingController;
  final GlobalKey<FormFieldState> accuntFormFieldKey;

 final GlobalKey<FormFieldState> pwdFormFieldKey;

 final GlobalKey<FormFieldState> verifyCodeFormFieldKey;

 final GlobalKey<FormFieldState> inviteCodeFormFieldKey;

final void Function(String) onPressedGetCode;


  RegisterInputContextCard(
      {Key key,
      this.accuntFormFieldKey,
      this.pwdFormFieldKey,
      this.verifyCodeFormFieldKey,
      this.inviteCodeFormFieldKey,
      this.onPressedGetCode,
      this.phoneTextEditingController,
      this.inviteCodeTextEditingController,
      this.passwordTextEditingController,
      this.verificationCodeTextEditingController})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => RegisterInputContextCardState();
}

class RegisterInputContextCardState extends State<RegisterInputContextCard> {

 

  final double kIconSize = 24;
final int kResendSeconds = 60;

Timer _getCodeTimer;
bool _isSend = false;

  ///密码是否可见
  bool _passwordVisible = false;

int _resendTimeCount;

  @override
  void initState() {
    super.initState();
        _isSend = false;
  }

  @override
  void deactivate() {
    super.deactivate();
      _getCodeTimer?.cancel();
  }

  @override
  void dispose() {
    super.dispose();
  
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: _$CardContent(),
    );
  }

  Widget _$CardContent() {
    return Column(children: [
     _$PhoneTextFormField() ,
      WidgetComponents.Line(),
    _$PasswordTextFormField(),
      WidgetComponents.Line(),
      _$VerificationCodeTextFormField(),
      WidgetComponents.Line(),
     _$InviteCodeTextFormField(),
    ]);
  }

Widget _$PhoneTextFormField() {
    return Container(
        margin: EdgeInsets.all(5),
        child: TextFormField(
            keyboardType: TextInputType.number,
            key: widget.accuntFormFieldKey,
            controller: widget.phoneTextEditingController,
            decoration: InputDecoration(
                border: InputBorder.none,
                prefixIcon: Container(
                    margin: EdgeInsets.all(5),
                    child: Image.asset(
                      'assets/images/icon_sjh_nor.png',
                      fit: BoxFit.fitHeight,
                      width: kIconSize,
                      height: kIconSize,
                    )),
                hintText: AppLocalizations.of(context).inputPhoneTip,
                hintStyle: AppDefaultStyle.hintText),
            validator: phoneNumberVerification));
  }

   Widget _$PasswordTextFormField(){
   return   Container(
          margin: EdgeInsets.all(5),
          child: TextFormField(
            key: widget?.pwdFormFieldKey,keyboardType: TextInputType.visiblePassword,obscureText: _passwordVisible,
            controller: widget.passwordTextEditingController,
            decoration: InputDecoration(
                border: InputBorder.none,
                prefixIcon: Icon(
                  Icons.lock_open_outlined,
                  color: Colors.deepOrange,
                ),
                hintText:  AppLocalizations.of(context).inputPasswordTip,
                hintStyle: AppDefaultStyle.hintText),
            validator: (value) => (value.isEmpty) ? AppLocalizations.of(context).inputPasswordTip : null,
          ));
 }

 Widget _$InviteCodeTextFormField(){
   return Container(
          margin: EdgeInsets.all(5),
          child: TextFormField(
            key: widget?.inviteCodeFormFieldKey,
            controller: widget?.inviteCodeTextEditingController,
            decoration: InputDecoration(
                border: InputBorder.none,
                hintText: AppLocalizations.of(context).inputInviteCodeTip,
                hintStyle: AppDefaultStyle.hintText),
            validator: (value) => (value.isEmpty) ?AppLocalizations.of(context).inputInviteCodeTip : null,
          ));
 }

   Widget _$VerificationCodeTextFormField() {
    return Row(
      children: [
        Expanded(
            child: TextFormField(
          key: widget.verifyCodeFormFieldKey,
          controller: widget.verificationCodeTextEditingController,
          decoration: InputDecoration(
              border: InputBorder.none,
              prefixIcon: Container(
                  margin: EdgeInsets.all(5),
                  child: Image.asset('assets/images/icon_yzm_nor.png',
                      fit: BoxFit.fitHeight,
                      width: kIconSize,
                      height: kIconSize)),
              hintText: AppLocalizations.of(context).inputVerificationCodeTip,
              hintStyle: AppDefaultStyle.hintText),
          validator: (value) => (value.isEmpty)
              ? AppLocalizations.of(context).inputVerificationCodeTip
              : null,
        )),
        FlatButton(
            onPressed: _isSend ? null : _onClickGetverifyCode,
            color: Colors.transparent,
            child: Text(
                AppLocalizations.of(context)
                    .sendVerificationCode(_resendTimeCount ?? 0),
                style: TextStyle(color: _isSend ? Colors.grey : Colors.red)))
      ],
    );
  }

  String phoneNumberVerification(String value) {
    if (value.isEmpty) return AppLocalizations.of(context).inputPhoneTip;

    RegExp reg = new RegExp(r'^\d{11}$');
    if (!reg.hasMatch(value)) {
      return AppLocalizations.of(context).phoneNumberWrongTip;
    }
    return null;
  }

  void _onClickGetverifyCode() {
    if (widget.accuntFormFieldKey == null ||
        !widget.accuntFormFieldKey.currentState.validate()) return;

    if (!_isSend) {

      _isSend = true;

      _resendTimeCount = kResendSeconds;

      _getCodeTimer = Timer.periodic(Duration(seconds: 1), (sender) {
        if (--_resendTimeCount <= 0) {
          _isSend = false;
          sender?.cancel();
          _resendTimeCount = 0;
        }
        _$RefreshUI();
      });

      widget?.onPressedGetCode?.call(widget.accuntFormFieldKey.currentState.value);
    }
  }

  void _$RefreshUI() {
    if (mounted) {
      setState(() {});
    }
  }



}
