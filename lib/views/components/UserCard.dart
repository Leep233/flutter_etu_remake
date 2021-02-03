import 'package:flutter/material.dart';
import 'package:flutter_etu_remake/l10n/localization_intl.dart';
import 'package:flutter_etu_remake/viewmodels/UserCardViewModel.dart';

// ignore: must_be_immutable
class UserCard extends StatelessWidget {

  final TextStyle style01 = TextStyle(color: Colors.grey, fontSize: 12);
  final TextStyle style02 = TextStyle(color: Colors.black, fontSize: 14);

  final double kImageSize = 50;

  BuildContext context; 

  UserCardDelegate listener;

  UserCardViewModel data;

  UserCard({this.data,this.listener});

  @override
  Widget build(BuildContext context) {
    context = context;

    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      elevation: 1,
      shadowColor: Colors.white,
      color: Color(0xD0FFFFFF),
      child: _$CardContent(context),
    );
  }

  Widget _$CardContent(BuildContext context) { 

    return Container(
      margin: EdgeInsets.only(top: 10, bottom: 10),
      child:
          Column(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Container(
            child: ListTile(
          leading: Container(
            child: ClipOval(
              child: FadeInImage.assetNetwork(
                  placeholder: "assets/images/loading.gif",fit: BoxFit.fill, image: data?.image??"",width: kImageSize,height: kImageSize,),
            ),
          ),
          title: Container(
              child: Row(
            children: [
              Container(child: Text(data?.title??"")),
              Container(child:Image.asset(data?.gender==2?"assets/images/woman.png":"assets/images/man.png",width: 14,height: 14,))
            ],
          )),
          subtitle: Container(
              child: Text(
            data?.subtitle??"这个人很懒，什么也没留下",
            style: TextStyle(fontSize: 14),
          )),
          trailing: IconButton(
            icon: Icon(
              Icons.chevron_right,
              color: Colors.grey,
            ),
            onPressed: () {
             listener?.onClickUser();
            },
          ),
        )),
        Container(
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
              TextButton(
                  onPressed: _onClickFootprint,
                child:Column(children: [
                    Container(child: Text("${data?.footprint??"0"}",style: style02,)),
                    Container(child: Text(AppLocalizations.of(context).footprint,style:style01,))
                    ])),
              TextButton(
                onPressed: _onClickFavorites,
                child: Column(children: [
                    Container(child: Text("${data?.favorites??"0"}",style: style02)) ,
                     Container(child: Text(AppLocalizations.of(context).favorites,style:style01))
                     ]),),
              TextButton(
                  onPressed: _onClickAttentionStore,
                  child:Column(children: [
                      Container( child: Text("${data?.attention??"0"}",style: style02)),
                       Container(child: Text(AppLocalizations.of(context).attention,style:style01))
                       ])),
              TextButton(
                  onPressed: _onClickBalance,
                  child: Column(children: [
                       Container(child: Text("${data?.balance?.toStringAsFixed(2)??"0.00"}",style: style02)),
                       Container(child: Text(AppLocalizations.of(context).balance,style:style01))
                       ]))
            ])),
      ]),
    );
  }

  void _onClickAttentionStore() {
    print("关注店铺");
  listener?.onClickAttentionStore();
  }

  void _onClickBalance() {
    print("我的余额");
 listener?.onClickBalance();
  }

  void _onClickFavorites() {
    print("收藏夹");
listener?.onClickFavorites();
  }

  void _onClickFootprint() {
    print("足迹");
    listener?.onClickFootprint();
  }
}

abstract class UserCardDelegate{
  onClickAttentionStore();
  onClickBalance();
  onClickFavorites();
  onClickFootprint();
  onClickUser();
}