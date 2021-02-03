import 'package:flutter/material.dart';
import 'package:flutter_etu_remake/l10n/localization_intl.dart';
class TestPage extends StatefulWidget{

    final String title;

    TestPage({Key key,this.title=''}):super(key:key);

    @override
    State<StatefulWidget> createState()=>TestPageState(); 
}
 
class TestPageState extends State<TestPage>{

    @override
    void initState() {
       super.initState();
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

     String str = MaterialLocalizations.of(context).backButtonTooltip;

     // Locale locale = Localizations.localeOf(context);

      print(str);

      return Scaffold(
             appBar:AppBar(title:Text(AppLocalizations.of(context).addAddress ),),
             body:Container(child:Text(str))
             );
    }

}