
//默认样式
import 'package:flutter/material.dart';

class AppDefaultStyle{

  // ignore: non_constant_identifier_names
  static String Loading =  "assets/images/loading.gif";

  static Color bgColor = Color.lerp(Colors.white, Colors.deepOrange, 0.02);

  // ignore: non_constant_identifier_names
  static double get AppTitleFontSize => 18;
// ignore: non_constant_identifier_names
   static double get TitleFontSize => 16;
// ignore: non_constant_identifier_names
   static double get SubtitleFontSize => 14;

   // ignore: non_constant_identifier_names
   static BoxDecoration  BGConstraint({BorderRadius borderRadius}) => BoxDecoration(
            borderRadius: borderRadius,
            gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color.fromARGB(255, 239, 70, 74),
              Color.fromARGB(255, 239, 80, 70),
              Color.fromARGB(255, 250, 160, 70),
              Color.fromARGB(255, 250, 225, 200),
              Colors.white,
              Colors.white,
              Colors.white,
            ],
          ),
        );

static TextStyle hintText = TextStyle(fontSize: 15, color: Colors.grey);

static TextStyle appTitleStyle = TextStyle(fontSize: 16,color: Colors.grey[900],fontWeight: FontWeight.w600);

static double appBarHeight = 40;

static TextStyle titleStyle01 = TextStyle(fontSize:14,color:Colors.black,fontWeight: FontWeight.w500);

}