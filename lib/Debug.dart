
import 'package:intl/intl.dart';
class Debug{

  static String prefix = " --> ";

  static void log(dynamic message,{bool isShowtime = true}){

    String time;

    if(isShowtime)
        time =' ${DateFormat("yyyy-MM-dd HH:mm:ss").format(DateTime.now())} ' ;// 

    print("$prefix[DEBUG$time]: ${message?.toString()}");
  }

  static void warn(dynamic message,{bool isShowtime = true}){

    String time;

    if(isShowtime)
        time =' ${DateFormat("yyyy-MM-dd HH:mm:ss").format(DateTime.now())} ' ;// 

    print("$prefix[WARN$time]: ${message?.toString()}");
  }

   static void error(dynamic message,{bool isShowtime = true}){

    String time;

    if(isShowtime)
        time =' ${DateFormat("yyyy-MM-dd HH:mm:ss").format(DateTime.now())} ' ;// 

    print("$prefix[ERROR$time]: ${message?.toString()}");
  }

}