


import 'package:flutter/material.dart';
import 'package:flutter_etu_remake/l10n/localization_intl.dart';
import 'package:fluttertoast/fluttertoast.dart';

class WidgetComponents
{

        // ignore: non_constant_identifier_names
        static   Widget TitleTextField(String title, String hintText,
                {Key key,void Function(String) onChanged,int maxLines = 1,double height =40,CrossAxisAlignment crossAxisAlignment=CrossAxisAlignment.center,
                TextEditingController controller,
                String Function(String) validator}) {
              return Container(
                margin: EdgeInsets.only(bottom: 2),
                padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                height: height,
                color: Colors.white,          
                child: Row(crossAxisAlignment: crossAxisAlignment,children: [
                  Container(width: 70, child: Text("$title")),
                  Expanded(
                      child: Container(
                    alignment: Alignment.centerLeft,    

                    child: TextFormField(
                      
                      key: key,
                      controller: controller,
                      onChanged:onChanged,
                      validator: validator,
                      maxLines: maxLines,
                      style: TextStyle(fontSize: 14),
                      decoration: InputDecoration.collapsed(
                          hintText: hintText, hintStyle: TextStyle(fontSize: 14)),
                    ),
                  )) //
                ]),
              );
            }

// ignore: non_constant_identifier_names
static void ModuleDeveloping(){
  DefaultToast("模块开发中");
}
// ignore: non_constant_identifier_names
static Future<T> DefaultDailog<T>(BuildContext context,{String title,String content,TextStyle contentStyle}){
 return  showDialog(context: context,child:SimpleDialog(title: Text(title,textAlign: TextAlign.center,),titlePadding:const EdgeInsets.fromLTRB(10, 10, 10, 0),contentPadding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
  children: [
    Container(margin: const EdgeInsets.symmetric(vertical:10),alignment: Alignment.center,child: Text(content,style: contentStyle,),),
    Container(child:Row(mainAxisAlignment: MainAxisAlignment.center,children:[
       FlatButton(color: Theme.of(context).primaryColor,onPressed: (){
      Navigator.pop(context);
    }, child: Text( AppLocalizations.of(context).confirm,style: TextStyle(color:Colors.white,fontWeight: FontWeight.bold),))
    ]),)
  ],
));
}

 // ignore: non_constant_identifier_names
static  Widget ImageButton(String image, String title,
      {double iconSize = 25,
      void Function() onPressed,
      TextStyle style = const TextStyle(fontSize: 14, color: Colors.grey)}) {
    return InkWell(
      child: Column(children: [
        Container(child:  Image.asset(
          image,
          fit: BoxFit.fill,
          width: iconSize,
          height: iconSize,
        ),) ,
      
        Container(margin: const EdgeInsets.only(top: 5),child: Text(title,style: style,))
      ]),
      onTap: onPressed,
    );
  }

// ignore: non_constant_identifier_names
  static Widget TitleLabel(String title,String label,{TextStyle titleStyle,TextStyle labelStyle}) {
    return RichText(
        text: TextSpan(
            text: title,
            style:titleStyle,
            children: [TextSpan(text: label, style: labelStyle)]));
  }

// ignore: non_constant_identifier_names
 static  Widget SearchFeild({String hintText,TextEditingController controller,void Function(String) onChanged,void Function() onPressedSearch,double height = 30}) {
    return Container(decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.circular(20)),
      height: height,
      child: Row(
        children: [
        Container(child:IconButton(icon: Image.asset('assets/images/icon_ss_nor_nor_nav.png') ,onPressed: onPressedSearch,),),
         Expanded(child: TextField(style: TextStyle(fontSize:14),onChanged:onChanged ,controller:  controller,decoration: InputDecoration.collapsed(hintText: hintText,hintStyle: TextStyle(color:Colors.grey)),)) 
                  ],
                ),
              );
            }

   // ignore: non_constant_identifier_names
   static void DefaultToast(String msg) async {

     Fluttertoast.cancel().then((value){
       print(value);
     Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.black54,
        textColor: Colors.white,
        fontSize: 12.0);
     });


  }

// ignore: non_constant_identifier_names
  static Widget Tips(String content,
      {double width,double height,double minWidth=0.0,double minHeight=0.0,TextStyle style,
      double borderRadius = 2,
      Color borderColor = Colors.orangeAccent,Color bgColor,padding =const EdgeInsets.fromLTRB(1, 0, 1, 0)}) {
    if (style == null) {
      style = TextStyle(
        color: borderColor,
        fontSize: 8,
      );
    }
    return Container(
        padding: padding,
        alignment: Alignment.center,
        margin:const EdgeInsets.symmetric(vertical:1,horizontal:3),
        height:height ,
        width:width,
        constraints: BoxConstraints(minWidth:minWidth,minHeight: minHeight),
        decoration: BoxDecoration(
            color: bgColor,
            borderRadius: BorderRadius.circular(borderRadius),
            border: Border.all(color: borderColor)),
        child: Text(content,textAlign: TextAlign.center, style: style));
  }


   // ignore: non_constant_identifier_names
   static Widget MeonyLabel(double number,{double originalPrice,String prefix = '￥',double scale = 1,Color color =  Colors.red,FontWeight fontWeight = FontWeight.normal}) {
    String num1 = number.toStringAsFixed(2);
    List<String> numArray = num1.split(".");

    return Container(
      child: RichText(
          text: TextSpan(
              text: prefix,
              style: TextStyle(color:color, fontSize: 10*scale,fontWeight: fontWeight),
              children: [
            TextSpan(
                text: "${numArray[0]}",
                style: TextStyle(
                  color: color,
                  fontSize: 16*scale,
                  fontWeight: fontWeight
                ),
                children: [
                  TextSpan(
                    text: ".${numArray[1]} ",
                    style: TextStyle(
                      color: color,
                      fontSize: 10*scale,
                      fontWeight: fontWeight
                    ),
                  ),
                  if(originalPrice!=null) TextSpan(
                    text: "$prefix${originalPrice.toStringAsFixed(2)}",
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 10*scale*0.9,
                      fontWeight: fontWeight,
                       decoration: TextDecoration.lineThrough
                    ),
                  )
                ])
          ])),
    );
  }

  ///图片标签 上面图片  下面描述
  // ignore: non_constant_identifier_names
  static Widget ImageLabel(Widget icon, String title, {double iconSize = 35,TextStyle style}) {
    return Container(
        child: Column(children: [
      Container(
        child: icon,
        width: iconSize,
        height: iconSize,
      ),
      Container(
          child: Text(
        title,
        style: style,
      ))
    ]));
  }

  // ignore: non_constant_identifier_names
  static Widget CommonButton(String text,
      {EdgeInsetsGeometry margin,
      void Function() onPressed,
      TextStyle style,
      double height = 35,
      double width = double.infinity}) {
    return Container(
        margin: margin,
        height: height,
        width: width,
        decoration: BoxDecoration(
            image: DecorationImage(
                fit: BoxFit.fill, image: AssetImage('assets/images/btn.png'))),
        child:
         FlatButton(
          shape:RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)) ,
          color: Colors.transparent,
          child: Text(
            text,
            style: style,
          ),
          onPressed: onPressed,
        ));
  }

// ignore: non_constant_identifier_names
static Widget Line({Color color = Colors.black12, double size = 1}) {
    return Container(
      child: SizedBox(
        width: double.infinity,
      ),
      height: size,
      color: color,
    );
  }
 
}