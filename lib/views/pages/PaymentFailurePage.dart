import 'package:flutter/material.dart';
import 'package:flutter_etu_remake/WidgetComponents.dart';

class PaymentFailurePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            icon: Icon(
              Icons.chevron_left,
              color: Colors.black,
            ),
            onPressed: () => Navigator.pop(context)),
        shadowColor: Colors.transparent,
        backgroundColor: Colors.transparent,
      ),
      body: Container(
          width: double.infinity,
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
            Container(
              margin: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                  shape: BoxShape.circle, color: Colors.grey[400]),
              width: 50,
              height: 50,
              child: Icon(
                Icons.close_rounded,
                size: 40,
                color: Colors.white,
              ),
            ),
            Container(child: Text("支付失败",style: TextStyle(fontSize:18,fontWeight: FontWeight.bold),),),

            Container(margin: const EdgeInsets.fromLTRB(15, 30, 15, 0),child:WidgetComponents.CommonButton("再试一次", onPressed: () => Navigator.pop(context),height: 40,style: TextStyle(color:Colors.white)) )

          ])),
    );
  }
}
