import 'package:flutter/material.dart';
import 'package:flutter_etu_remake/Debug.dart';
import 'package:flutter_etu_remake/WidgetComponents.dart';
import 'package:flutter_etu_remake/core/NetworkManager.dart';
import 'package:flutter_etu_remake/core/UIManager.dart';
import 'package:flutter_etu_remake/l10n/localization_intl.dart';
import 'package:flutter_etu_remake/views/components/LoginInputContentCard.dart';
import 'package:flutter_etu_remake/views/components/OtherLoginOperationWidget.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage>
    implements OtherLoginOperationWidgetDelegate {
  ///连续点击两次退出间隔
  final int exitPressedIntarval = 1;

  DateTime _lastPressedAt; //上次点击时间

  TextEditingController phoneTextEditingController = TextEditingController();

  final GlobalKey<FormFieldState> phoneFormFieldKey =
      GlobalKey<FormFieldState>();

  final GlobalKey<FormFieldState> pwdFormFieldKey = GlobalKey<FormFieldState>();

  final GlobalKey<FormFieldState> codeFormFieldKey =
      GlobalKey<FormFieldState>();

  ///登录形式
  int _loginType = 0;

  @override
  void initState() {
    super.initState();
    _loginType = 0;
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void deactivate() {
    super.deactivate();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return WillPopScope(
        onWillPop: () async {
          if (_lastPressedAt == null ||
              DateTime.now().difference(_lastPressedAt) >
                  Duration(seconds: exitPressedIntarval)) {
            //两次点击间隔超过1秒则重新计时
            _lastPressedAt = DateTime.now();
            return false;
          }
          return true;
        },
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          extendBodyBehindAppBar: true,     
          body: Container(
              decoration: BoxDecoration(
                  image: DecorationImage(
                      alignment: Alignment.topCenter,
                      fit: BoxFit.fitWidth,
                      image: AssetImage('assets/images/login_bg.png'))),
              child: Container(child: _$BuildContent(context),padding:const EdgeInsets.only(top:40),)),
        ));
  }

  Widget _$BuildContent(BuildContext context) {
    return Container(
       margin: const EdgeInsets.fromLTRB(10, 20, 10, 20),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  LoginInputContentCard(
                    phoneTextEditingController: phoneTextEditingController,
                    accuntFormFieldKey: phoneFormFieldKey,
                    passwordFormFieldKey: pwdFormFieldKey,
                    codeFormFieldKey: codeFormFieldKey,
                    onTabChanged: _onLoginTabChangedCallback,
                    onPressedGetCode: _onClickGetCodeCallback,
                  ),
                  Container(
                      margin: EdgeInsets.all(10),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(AppLocalizations.of(context)
                                .clickSomethingIsAgreed(
                                    AppLocalizations.of(context).login)),
                            GestureDetector(
                              child: Text(
                                AppLocalizations.of(context)
                                    .userServiceAgreement,
                                style: TextStyle(color: Colors.red),
                              ),
                              onTap: _onClickUserAgreementBtn,
                            )
                          ])),
                  WidgetComponents.CommonButton(
                    AppLocalizations.of(context).login,
                    style: TextStyle(color: Colors.white),
                    onPressed: _onClickLoginBtn,
                    margin: EdgeInsets.fromLTRB(5, 10, 5, 10),
                  ),
                  Container(
                      margin: EdgeInsets.all(10),
                      child: _$OtherOperationItem(context)),
                ],
              ),
              Container(
                child: OtherLoginOperationWidget(
                  operationListener: this,
                ),
              )
            ]));
  }

  Widget _$OtherOperationItem(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
          child: Text(
            AppLocalizations.of(context).forgotPassword,
            style: TextStyle(color: Colors.blue),
          ),
          onTap: _onClickForgotPasswordBtn,
        ),
        Expanded(child: SizedBox()),
        GestureDetector(
          child: Text(AppLocalizations.of(context).register,
              style: TextStyle(color: Colors.blue)),
          onTap: _onClickRegisterBtn,
        ),
      ],
    );
  }

  void _$RefreshUI() {
    if (mounted) {
      setState(() {});
    }
  }

  ///登录方式改变
  void _onLoginTabChangedCallback(int type) {
    _loginType = type;
    Debug.log('$_loginType');
  }

  ///点击获取验证码
  void _onClickGetCodeCallback(String phoneNumber) {
    if (phoneNumber.isNotEmpty) {
      Debug.log('获取验证码 ($phoneNumber)');
    }
  }

  ///点击登录
  void _onClickLoginBtn() {
  
    String phoneNumber ,password,code;
 
    switch (_loginType) {
      case 0:
        if (phoneFormFieldKey.currentState.validate() &&
            pwdFormFieldKey.currentState.validate()) {
          phoneNumber = phoneFormFieldKey.currentState.value;
          password = pwdFormFieldKey.currentState.value;

          Debug.log("登录>>密码登录 | 账号: $phoneNumber   密码: $password");
        }
        break;
      case 1:
        if (phoneFormFieldKey.currentState.validate() &&
            codeFormFieldKey.currentState.validate()) {
          phoneNumber = phoneFormFieldKey.currentState.value;
          code = codeFormFieldKey.currentState.value;
          Debug.log("登录>>验证码登录 | 账号: $phoneNumber   验证码: $code");
        }
        break;
    }

    NetworkManager.instance.login(phoneNumber, password, code).then((value)
     { 
       if(value.isNotEmpty)return WidgetComponents.DefaultToast(value);
       
       UIManager.instance.toPage(context, UIDef.home); 
     }
    );
  }

  void defaultInputPhoneNumber(dynamic value) {
    String phoneNumber = value;

    Debug.log(phoneNumber);

    if (phoneNumber != null) {
      phoneTextEditingController = TextEditingController(text: phoneNumber);

      _$RefreshUI();
    }
  }

  ///点击忘记密码
  void _onClickForgotPasswordBtn() {
    Debug.log("忘记密码");
    UIManager.instance
        .toPage(context, UIDef.forgotPassword)
        .then(defaultInputPhoneNumber);
  }

  ///点击注册
  void _onClickRegisterBtn() {
    Debug.log("注册");
    UIManager.instance
        .toPage(context, UIDef.register)
        .then(defaultInputPhoneNumber);
  }

  void _onClickUserAgreementBtn() {
    Debug.log("用户服务协议");
  }

  @override
  void onLoginByPhoneNumber() {
    Debug.log("手机一键登录");

    String phoneNumber = '19979824448';

    UIManager.instance
        .toPage(context, UIDef.quickLoginByPhoneNumber, arguments: phoneNumber);
  }

  @override
  void onLoginByWechat() {
    Debug.log("微信登录");
  }
}
