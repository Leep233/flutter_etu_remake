import 'package:flutter/material.dart';
import 'package:flutter_etu_remake/AppDefaultStyle.dart';
import 'package:flutter_etu_remake/WidgetComponents.dart';
import 'package:flutter_etu_remake/views/components/Calendar.dart';
class FootprintPage extends StatefulWidget{  
    FootprintPage({Key key}):super(key:key);
    @override
    State<StatefulWidget> createState()=>FootprintPageState(); 
}
 
class FootprintPageState extends State<FootprintPage>{

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

    double height =  MediaQuery.of(context).size.height;

      return Scaffold(
      appBar: AppBar(
        toolbarHeight:45,
        centerTitle: true,
        title: Text('我的足迹',style: AppDefaultStyle.appTitleStyle,),
        leading: IconButton(
            icon: Icon(
              Icons.chevron_left,
              color: Colors.black,
            ),
            onPressed: () => Navigator.pop(context)),
        shadowColor: Colors.transparent,
        backgroundColor: Colors.transparent,
      ),
      body: Container(width: double.infinity,child: Column(children:[

       Container(margin: const EdgeInsets.fromLTRB(10, 0, 10, 10),child: Card(child: Container(margin: EdgeInsets.all(3),child:Calendar()),)),
       //
      Expanded(child:  Container(margin: const EdgeInsets.symmetric(horizontal:10),constraints: BoxConstraints(maxHeight: height*0.5),alignment: Alignment.center,child: ListView(children: [
          FootprintCommodityItem(),
          FootprintCommodityItem(),
          FootprintCommodityItem(),
          FootprintCommodityItem(),
          FootprintCommodityItem(),
          FootprintCommodityItem(),
        ],),)) ,
      ]),),
    );
    }
}


class FootprintCommodityItem extends StatelessWidget{

final double imageSize;

final double price;

final bool isEdit;

final bool isSelected;

final void Function(bool) onChecked;

FootprintCommodityItem({this.imageSize = 85,this.isSelected = false,this.price = 99,this.isEdit = true,this.onChecked});

 @override
Widget build(BuildContext context) {
     // TODO: implement build
      return Container(child:Column(children:[
        Container(width: double.infinity,child:
          Row(children: [
           if(isEdit) Container(child: Checkbox(value: isSelected, onChanged: onChecked) ,height: 30,width: 30,),
            Text("10月20日")
          ],)
        ),
        Container(width: double.infinity,child:Wrap(
          spacing:10,
          runSpacing: 5,
          alignment: WrapAlignment.start, 
          runAlignment: WrapAlignment.start,    
          children:[
          _$CommodityItem(),
          _$CommodityItem(),
          _$CommodityItem(),
          _$CommodityItem(),
          _$CommodityItem(),
          _$CommodityItem(),
          _$CommodityItem(),
          _$CommodityItem(),
        ]))
       
      ]));
     }

Widget _$CommodityItem(){
  return Column(children: [
     Container(child:ClipRRect(borderRadius: BorderRadius.circular(10),child: FadeInImage.assetNetwork(placeholder: "assets/images/loading.gif", image: "",width:imageSize ,height: imageSize,),)),
         Container(child:WidgetComponents.MeonyLabel(price)),
  ],);
}
}