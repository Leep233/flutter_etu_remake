import 'package:flutter/material.dart';
import 'package:flutter_etu_remake/AppDefaultStyle.dart';
import 'package:flutter_etu_remake/common/TimeUtil.dart';
import 'package:flutter_etu_remake/core/MessageManager.dart';
import 'package:flutter_etu_remake/views/pages/ChatPage.dart';
import 'package:im_flutter_sdk/im_flutter_sdk.dart';

class MessageCenterPage extends StatefulWidget {
  MessageCenterPage({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => MessageCenterPageState();
}

class MessageCenterPageState extends State<MessageCenterPage> {
  List<EMConversation> converstaions;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  void _loadData() {
    MessageManager.instance.loadConversationList().then((value) {
      converstaions = value;
      _$RefreshUI();
    });
  }

  _$RefreshUI() {
    if (mounted) setState(() {});
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
    Size screen = MediaQuery.of(context).size;
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          centerTitle: true,
          toolbarHeight: AppDefaultStyle.appBarHeight,
          automaticallyImplyLeading: false,
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          leading: IconButton(
            icon: Icon(
              Icons.chevron_left,
              color: Colors.black,
            ),
            onPressed: () => Navigator.pop(context),
          ),
          title: Text(
            "消息中心",
            style: TextStyle(
                fontSize: AppDefaultStyle.AppTitleFontSize,
                color: Colors.black),
          ),
        ),
        body: Container(
          // margin: const EdgeInsets.all(15),
          width: screen.width,
          height: screen.height,
          child: _$BuildBody(context),
        ));
  }

  Widget _$BuildBody(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, index) => MessageCenterItem(
          conversation: converstaions[index],
          onPressed: (con) {
            Navigator.push<bool>(context,
                new MaterialPageRoute(builder: (BuildContext context) {
              return ChatPage(conversation: con);
            })).then((bool _isRefresh) {
              _loadData();
            });
          }),
      itemCount: converstaions?.length ?? 0,
    );
  }
}

class MessageCenterItem extends StatelessWidget {
  final double imageSize = 50;

  final EMConversation conversation;

  final void Function(EMConversation) onPressed;

  MessageCenterItem({this.conversation, this.onPressed});
  @override
  Widget build(BuildContext context) {
    Widget icon = ClipOval(
        child: FadeInImage.assetNetwork(
      placeholder: "assets/images/loading.gif",
      image: "",
      fit: BoxFit.fill,
      width: imageSize,
      height: imageSize,
    ));

    Widget title = Text(conversation?.id ?? "");

    String lastMessageStr = "";

    EMMessage lastMsg = conversation.latestMessage;

    switch (lastMsg.body.type) {
      case EMMessageBodyType.TXT:
        var body = lastMsg.body as EMTextMessageBody;
        lastMessageStr = body.content;
        break;
      case EMMessageBodyType.IMAGE:
        lastMessageStr = '[图片]';
        break;
      case EMMessageBodyType.VIDEO:
        lastMessageStr = '[视频]';
        break;
      case EMMessageBodyType.LOCATION:
        lastMessageStr = '[定位]';
        break;
      case EMMessageBodyType.VOICE:
        lastMessageStr = '[语言]';
        break;
      case EMMessageBodyType.FILE:
        lastMessageStr = '[文件]';
        break;
      default:
    }

    Widget subtitle = Text(
      lastMessageStr,
      overflow: TextOverflow.ellipsis,
    );

    String unreadCount;

    if (conversation.unreadCount >= 99)
      unreadCount = "99+";
    else if (conversation.unreadCount > 0)
      unreadCount = conversation.unreadCount.toString();

    return Container(
        decoration: BoxDecoration(
            border: Border(
                top: BorderSide(color: Colors.grey, width: 0.1),
                bottom: BorderSide(color: Colors.grey, width: 0.1))),
        child: ListTile(
          onTap: () {
            onPressed?.call(conversation);
          },
          leading: icon,
          title: title,
          subtitle: subtitle,
          trailing: Container(
            margin: const EdgeInsets.symmetric(vertical: 5),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    TimeUtil.convertTime(lastMsg.serverTime),
                    style: TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                  if (unreadCount != null)
                    Container(
                        // alignment: Alignment.center,
                        padding: const EdgeInsets.symmetric(
                            vertical: 1, horizontal: 3),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: Colors.red),
                        child: Text(unreadCount,
                            style:
                                TextStyle(fontSize: 12, color: Colors.white)))
                ]),
          ),
        ));
  }
}
