import 'package:flutter/material.dart';
import 'package:flutter_etu_remake/WidgetComponents.dart';
import 'package:flutter_etu_remake/l10n/localization_intl.dart';

class OtherLoginOperationWidget extends StatelessWidget{

final OtherLoginOperationWidgetDelegate operationListener;

OtherLoginOperationWidget({this.operationListener});

 @override
Widget build(BuildContext context) {
      var style = TextStyle(color: Colors.grey, fontSize: 12);

    return Column(children: [
      Container(margin: EdgeInsets.all(20), child: Text('--- ${AppLocalizations.of(context).otherLoginMode} ---')),

      Container(child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          FlatButton(highlightColor:Colors.transparent,
            child: WidgetComponents.ImageLabel(
                Image.asset('assets/images/icon_phone.png'), AppLocalizations.of(context).quickLoginByPhoneNumber,
                style: style),
            onPressed: operationListener?.onLoginByPhoneNumber,
          ),
          FlatButton(
            child: WidgetComponents.ImageLabel(
                Image.asset('assets/images/icon_wx_nor.png'), AppLocalizations.of(context).quickLoginByWeChat,
                style: style),
            onPressed:  operationListener?.onLoginByWechat,
          )
        ],
      ) ,)

     
    ]);
}

}
 abstract class  OtherLoginOperationWidgetDelegate{

   void onLoginByPhoneNumber();
   void onLoginByWechat();

}