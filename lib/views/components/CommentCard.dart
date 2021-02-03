
import 'package:flutter/material.dart';
import 'package:flutter_etu_remake/viewmodels/CommentCardViewModel.dart';

class CommentCard extends StatefulWidget {

  final CommentCardViewModel content;

  final double elevation;

  CommentCard({Key key, this.content, this.elevation}) : super(key: key);

  @override
  State<StatefulWidget> createState() => CommentCardState();
}

class CommentCardState extends State<CommentCard> {
  

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
    return Card(
        elevation: widget.elevation,
        child: Container(margin: EdgeInsets.all(10), child: userLabel()));
  }

  Widget userLabel() {
    List<Widget> stars = [];

    int starCount = (widget?.content?.starNum ?? 0).toInt();

    for (var i = 0; i < starCount; i++) {
      stars.add(Container(
          child: Icon(
        Icons.star_rounded,
        color: Colors.deepOrangeAccent,
        size: 16,
      )));
    }

    List<Widget> imgs = [];
    if ( widget.content?.images != null &&  widget.content?.images.length > 0) {
      for (var i = 0; i <  widget.content?.images.length; i++) {

        print( widget.content?.images[i]);

        if( widget.content?.images[i].isEmpty)continue;

        imgs.add(Container(
          width: 80,
          height: 80,
          child: ClipRRect(
              borderRadius: BorderRadius.circular(5),
              child: FadeInImage.assetNetwork(
                placeholder: 'assets/images/loading.gif',
                image:  widget.content?.images[i],
                fit: BoxFit.fill,
              )),
        ));
      }
    }

    String subTitl =
        "${widget?.content?.commentTime ?? ""} | ${widget?.content?.specification ?? ""}";

    Container starBar = Container(child: Row(children: stars));

    Container icon = Container(
      width: 40,
      height: 40,
      child: CircleAvatar(
        backgroundImage: NetworkImage(widget?.content?.userProfile ?? ""),
      ),
    );

    Container user = Container(
      width: double.infinity,
      child: Text(
        widget?.content?.username ?? "未知用户",
        style: TextStyle(color: Colors.black, fontSize: 14),
      ),
    );

    Container orderLabel = Container(
      width: double.infinity,
      child: Text(
        subTitl,
        style: TextStyle(color: Colors.grey, fontSize: 12),
      ),
    );

    Container content = Container(
      margin: EdgeInsets.only(top: 5, bottom: 10),
      child: Text(
        widget?.content?.evaluation ?? "",
        maxLines: 2,
        style: TextStyle(color: Colors.black, fontSize: 13),
      ),
    );

    // Container imags = Container(margin: EdgeInsets.only(bottom:5),child:Row(mainAxisAlignment: MainAxisAlignment.spaceAround,children: imgs,));

    Container imags = Container(
        margin: EdgeInsets.only(bottom: 5),
        child: Wrap(
          children: imgs,
        ));

    Container userTitle = Container(
        margin: EdgeInsets.only(bottom: 5),
        child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
          icon,
          Expanded(
              child: Container(
            margin: EdgeInsets.fromLTRB(5, 0, 5, 0),
            child:
                Column(mainAxisAlignment: MainAxisAlignment.start, children: [
              user,
              orderLabel,
            ]),
          )),
          starBar
        ]));

    Container mark = Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "浏览${widget?.content?.viewNum ?? 0} 次",
            style: TextStyle(color: Colors.grey, fontSize: 12),
          ),
          Container(
              child: GestureDetector(
            onTap: () {
              setState(() {
                widget?.content?.isLike= widget?.content?.isLike==1?0:1;    
              });
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  Icons.thumb_up,
                  size: 14,
                  color:  widget?.content?.isLike==1
                      ? Colors.deepOrange
                      : Colors.grey,
                ),
                Text(
                  "${widget?.content?.likeNum}",
                  style: TextStyle(color: Colors.grey, fontSize: 12),
                )
              ],
            ),
          ))
        ],
      ),
    );

    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [userTitle, content, imags, mark]);
  }
}
