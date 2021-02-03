import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_etu_remake/AppDefaultStyle.dart';
import 'package:flutter_etu_remake/WidgetComponents.dart';
import 'package:flutter_etu_remake/l10n/localization_intl.dart';

//登录输入卡片
class LoginInputContentCard extends StatefulWidget {
  final TextEditingController phoneTextEditingController;

  final TextEditingController passwordTextEditingController;

  final TextEditingController verificationCodeTextEditingController;

  final GlobalKey<FormFieldState> accuntFormFieldKey;

  final GlobalKey<FormFieldState> passwordFormFieldKey;

  final GlobalKey<FormFieldState> codeFormFieldKey;

  final void Function(String) onPressedGetCode;

  final void Function(int) onTabChanged;

  LoginInputContentCard(
      {Key key,
      this.accuntFormFieldKey,
      this.passwordFormFieldKey,
      this.codeFormFieldKey,
      this.onPressedGetCode,
      this.phoneTextEditingController,
      this.passwordTextEditingController,
      this.verificationCodeTextEditingController,
      this.onTabChanged})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => LoginInputContentCardState();
}

class LoginInputContentCardState extends State<LoginInputContentCard> {
  final int kResendSeconds = 60;

  final double kIconSize = 24;

  ///密码是否可见
  bool _passwordVisible = false;

  int _tabIndex = 0;

  bool _isSend = false;

  Timer _getCodeTimer;

  int _resendTimeCount;

  @override
  void initState() {
    super.initState();
    _resendTimeCount = 0;
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
    return _$BuildContent();
  }

  Widget _$BuildContent() {   

   Widget inputWidget = Column(mainAxisAlignment: MainAxisAlignment.end, children: [
      _$PhoneTextFormField(),
      WidgetComponents.Line(),
      _tabIndex==0? _$PasswordTextFormField():_$VerificationCodeTextFormField(),
    ]);

    return Card(
      child: Container(
        margin: EdgeInsets.all(5),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              DefaultTabController(
                  initialIndex: 0,
                  length: 2,
                  child: TabBar(
                      unselectedLabelStyle: TextStyle(
                        fontSize: 15,
                        color: Colors.grey,
                      ),
                      unselectedLabelColor: Colors.grey,
                      labelColor: Colors.black,
                      labelStyle: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                      indicatorColor:Theme.of(context).primaryColor,
                      indicatorSize: TabBarIndicatorSize.label,
                      onTap: _onTabChanged,
                      tabs: [
                        Tab(
                            child: Text(
                                AppLocalizations.of(context).passwordLogin)),
                        Tab(
                            child: Text(AppLocalizations.of(context)
                                .verificationLogin)),
                      ])),
              //Expanded(child: SizedBox()),
              Container(
                  margin: EdgeInsets.fromLTRB(0, 10, 0, 0), child: inputWidget),
            ]),
      ),
    );
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
    return Container(
          margin:EdgeInsets.all(5),
          child: TextFormField(
            obscureText: !_passwordVisible,
            keyboardType: TextInputType.visiblePassword,
            key: widget.passwordFormFieldKey,
            controller: widget.passwordTextEditingController,
            decoration: InputDecoration(
                border: InputBorder.none,
                prefixIcon: Container(
                    margin: EdgeInsets.all(5),
                    child: Image.asset('assets/images/icon_dlmm_nor.png',
                        fit: BoxFit.fitHeight,
                        width: kIconSize,
                        height: kIconSize)),
                hintText: AppLocalizations.of(context).inputPasswordTip,
                hintStyle: AppDefaultStyle.hintText),
            validator: (value) => (value.isEmpty)
                ? AppLocalizations.of(context).inputPasswordTip
                : null,
          ));
  }



  Widget _$VerificationCodeTextFormField() {
    return  Container(
          margin:EdgeInsets.all(5),
          child: Row(
      children: [
        Expanded(
            child: TextFormField(
          key: widget.codeFormFieldKey,
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
    ));
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

  void _onTabChanged(int value) {
     _tabIndex = value;
      _$RefreshUI();
        widget.onTabChanged?.call(_tabIndex);
    
  }
}
