import 'package:flutter/material.dart';
import 'package:flutter_etu_remake/common/TimeUtil.dart';
import 'package:flutter_etu_remake/views/components/MessageItemFactory.dart';
import 'package:im_flutter_sdk/im_flutter_sdk.dart';

// ignore: must_be_immutable
class ChatItem extends StatefulWidget {
  EMMessage message;
  ChatItemDelegate delegate;
  bool showTime;

  ChatItem(ChatItemDelegate delegate, EMMessage msg, bool showTime) {
    this.message = msg;
    this.delegate = delegate;
    this.showTime = showTime;
  }

  @override
  State<StatefulWidget> createState() {
    return new _ChatItemState(this.delegate, this.message, this.showTime);
  }
}

class _ChatItemState extends State<ChatItem> {
  EMMessage message;
  ChatItemDelegate delegate;
  bool showTime;
  // User user;
  Offset tapPos;

  _ChatItemState(ChatItemDelegate delegate, EMMessage msg, bool showTime) {
    this.message = msg;
    this.delegate = delegate;
    this.showTime = showTime;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
      child: Column(
        children: <Widget>[
          this.showTime
              ? Text(TimeUtil.convertTime(message.serverTime))
              : SizedBox(),
          Row(
            children: <Widget>[subContent()],
          )
        ],
      ),
    );
  }

  String get userid => message?.from ?? "";

  Widget subContent() {
    Widget content;
    String profile = ""; //"this.user?.profile"

    switch (message.direction) {
      case EMMessageDirection.SEND:
        content = Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(
                child: Column(
                  children: <Widget>[
                    Container(
                      alignment: Alignment.centerRight,
                      padding: EdgeInsets.fromLTRB(0, 0, 15, 0),
                      child: Text(userid,
                          style: TextStyle(fontSize: 13, color: Colors.black)),
                    ),
                    buildMessageWidget(),
                  ],
                ),
              ),
              Container(child: userPortrait(profile)),
            ],
          ),
        );
        break;
      case EMMessageDirection.RECEIVE:
        content = Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(child: userPortrait(profile)),
              Expanded(
                child: Column(
                  children: <Widget>[
                    Container(
                      alignment: Alignment.centerLeft,
                      padding: EdgeInsets.fromLTRB(15, 0, 0, 0),
                      child: Text(
                        userid,
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                    buildMessageWidget(),
                  ],
                ),
              ),
            ],
          ),
        );
        break;
      default:
        content = SizedBox();
    }

    return content;
  }

  Widget userPortrait(String iconUrl) {
    return GestureDetector(
        onTap: __onTapedUserPortrait,
        child: ClipOval(
          child: FadeInImage.assetNetwork(
            placeholder: "assets/images/loading.gif",
            image: iconUrl ?? "",
            width: 50,
            height: 50,
          ),
        ));
  }

  Widget buildMessageWidget() {
    return Row(
      children: <Widget>[
        Expanded(
          child: Container(
              padding: EdgeInsets.fromLTRB(15, 6, 15, 10),
              alignment: message.direction == EMMessageDirection.SEND
                  ? Alignment.centerRight
                  : Alignment.centerLeft,
              child: GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTapDown: (TapDownDetails details) {
                  this.tapPos = details.globalPosition;
                },
                onTap: () {
                  __onTapedMessage();
                },
                onLongPress: () {
                  __onLongPressMessage(this.tapPos);
                },
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: MessageItemFactory(message: message),
                ),
              )),
        )
      ],
    );
  }

  void __onTapedMessage() {
    if (delegate != null) {
      delegate.onTapMessageItem(message);
    } else {
      print("没有实现 ConversationItemDelegate");
    }
  }

  void __onLongPressMessage(Offset tapPos) {
    if (delegate != null) {
      delegate.onLongPressMessageItem(message, tapPos);
    } else {
      print("没有实现 ConversationItemDelegate");
    }
  }

  void __onTapedUserPortrait() {
    if (delegate != null) {
      delegate.onTapUserPortrait(message.from);
    } else {
      print("没有实现 ConversationItemDelegate");
    }
  }
}

abstract class ChatItemDelegate {
  //点击消息
  void onTapMessageItem(EMMessage message);
  //长按消息
  void onLongPressMessageItem(EMMessage message, Offset tapPos);
  //点击用户头像
  void onTapUserPortrait(String userId);
}
