import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_etu_remake/AppDefaultStyle.dart';
import 'package:flutter_etu_remake/WidgetComponents.dart';
import 'package:flutter_etu_remake/core/NetworkManager.dart';
import 'package:flutter_etu_remake/views/components/BottomInputBar.dart';
import 'package:flutter_etu_remake/views/components/ChatItem.dart';
import 'package:im_flutter_sdk/im_flutter_sdk.dart';

class ChatPage extends StatefulWidget {
  ChatPage({Key key, @required this.conversation, this.merchantId})
      : super(key: key);

  final EMConversation conversation;

  final String merchantId;

  @override
  State<StatefulWidget> createState() =>
      _ChatPageState(conversation: conversation);
}

class _ChatPageState extends State<ChatPage>
    implements EMChatManagerListener, BottomInputBarDelegate, ChatItemDelegate {
  _ChatPageState({@required this.conversation});

  EMConversation conversation;

  bool _singleChat;

  String _msgStartId = '';

  String _afterLoadMessageId = '';

  List<EMMessage> messageTotalList = []; //消息数组

  //List<EMMessage> messageList = new List(); //消息数组

  List<EMMessage> msgListFromDB = new List();

  List<Widget> extWidgetList = new List(); //加号扩展栏的 widget 列表

  bool showExtWidget = false; //是否显示加号扩展栏内容

  ChatStatus currentStatus; //当前输入工具栏的状态

  ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();


    EMClient.getInstance.chatManager.addListener(this);

    currentStatus = ChatStatus.Normal;

    messageTotalList?.clear();

    //增加加号扩展栏的 widget
    _initExtWidgets();

    if (conversation == null) {
      return;
    }
    _singleChat = conversation.type == EMConversationType.Chat;

    _scrollController.addListener(() {
      //此处要用 == 而不是 >= 否则会触发多次
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        _loadMessages();       
      }
    });

    // 设置全部已读
    _markMessagesAsRead();

    // load消息
    _loadMessages(onEnd: () {
      _listViewToEnd();
    });
  }

  @override
  Widget build(BuildContext context) {
    /*
      if (messageList.length > 0) {
      if (!_isLoad) {
        messageTotalList.clear();
        messageTotalList.addAll(messageList); 
      } else {
     
      }
    }  
     */
     if (messageTotalList.length > 0)
   _scrollController?.animateTo(_scrollController?.position?.maxScrollExtent,duration: new Duration(seconds: 2), curve: Curves.ease);
    return Scaffold(
        appBar: AppBar(
          elevation: 1,
          title: Text(
            conversation.id,
            style: TextStyle(
                color: Colors.black,
                fontSize: AppDefaultStyle.AppTitleFontSize),
          ),
          centerTitle: true,
          backgroundColor: Colors.white,
          leading: IconButton(
              icon: Icon(Icons.chevron_left, color: Colors.black),
              onPressed: () => Navigator.pop(context, true)),
          actions: <Widget>[
            // 隐藏的菜单
            PopupMenuButton<String>(
              icon: new Icon(Icons.more_vert, color: Colors.black),
              itemBuilder: _singleChat == true
                  ? (BuildContext context) => <PopupMenuItem<String>>[
                        this.SelectView(Icons.delete, '删除记录', 'A')
                      ]
                  : (BuildContext context) => <PopupMenuItem<String>>[
                        this.SelectView(Icons.delete, '删除记录', 'A'),
                        this.SelectView(Icons.people, '查看详情', 'B'),
                      ],
              onSelected: (String action) {
                // 点击选项的时候
                switch (action) {
                  case 'A':
                    _cleanAllMessage();
                    break;
                  case 'B':
                    _viewDetails();
                    break;
                }
              },
            ),
          ],
        ),
        body: Container(
          color: Colors.grey,
          child: Stack(
            children: [
              SafeArea(
                child: Column(
                  children: <Widget>[
                    Expanded(
                        child: Container(
                      color: Colors.grey[100],
                      child: $ChatListView()
                         // Column(children: [Flexible(child: $ChatListView())]),
                    )),
                    Container(
                      height: 100,
                      child: BottomInputBar(this),
                    ),
                    _getExtWidgets(),
                  ],
                ),
              ),
//              _buildActionWidget(),
            ],
          ),
        ));
  }

  Widget $ChatListView() {
    return ListView.builder(
        controller: _scrollController,
        itemCount: messageTotalList.length,
        itemBuilder: (context,index){
           EMMessage message = messageTotalList[index];
           print("${message.body}");
          return ChatItem(this,message, _isShowTime(index));
        });
  }

  // ignore: non_constant_identifier_names
  SelectView(IconData icon, String text, String id) {
    return PopupMenuItem<String>(
        value: id,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Icon(icon, color: Colors.blue),
            Text(text),
          ],
        ));
  }

  void _loadMessages({onEnd()}) async {
    conversation.loadMessagesWithStartId(_afterLoadMessageId).then((value) {
      List<EMMessage> loadList = value;
      _afterLoadMessageId = loadList.first.msgId;
    //  loadList.sort((a, b) => b.serverTime.compareTo(a.serverTime));

      messageTotalList.addAll(loadList);

      messageTotalList.sort((a,b)=>a.serverTime.compareTo(b.serverTime));

      onEnd?.call();

      _$RefreshUI();
    });
  }

  void _markMessagesAsRead({String messageId = ''}) async {
    try {
      if (messageId.length == 0) {
        await conversation.markAllMessagesAsRead();
      } else {
        await conversation.markMessageAsRead(messageId);
      }
    } on EMError catch (e) {}
  }

  void _listViewToEnd() {
    _scrollController.animateTo(_scrollController.offset,
        duration: new Duration(seconds: 1), curve: Curves.ease);
  }

  ///清除记录
  _cleanAllMessage() async {
    try {
      conversation.deleteAllMessages();

      messageTotalList.clear();

      _$RefreshUI();
    } catch (e) {}
  }

  ///查看详情
  _viewDetails() async {
    if (conversation.type == EMConversationType.GroupChat) {
      /*
      Navigator.push<bool>(context, MaterialPageRoute(builder: (BuildContext context) {
            return MessageGroupDetailsPage(conversation.id);
          })).then((bool _isRefresh){
            if(_isRefresh){
              Navigator.pop(context, true);
            }
      });*/
    }
    // TODO: 查看聊天室详情
  }

  /// 禁止随意调用 setState 接口刷新 UI，必须调用该接口刷新 UI
  void _$RefreshUI() {
    if (mounted) setState(() {});
  }

  Widget _getExtWidgets() {
    if (showExtWidget) {
      return Container(
          height: 110,
          color: Colors.grey,
          child: GridView.count(
            physics: new NeverScrollableScrollPhysics(),
            crossAxisCount: 4,
            padding: EdgeInsets.all(10),
            children: extWidgetList,
          ));
    } else {
      return SizedBox();
    }
  }

  void _showExtraCenterWidget(ChatStatus status) {
    this.currentStatus = status;
    _$RefreshUI();
  }

  void checkOutRoom() async {
    try {
      await EMClient.getInstance.chatRoomManager.leaveChatRoom(conversation.id);
    } catch (e) {}
  }

  void toStringInfo() async {}

  void _initExtWidgets() {
    Widget videoWidget = IconButton(
        icon: Icon(Icons.videocam),
        onPressed: () async {
          try {
            EMClient.getInstance.callManager
                .makeCall(EMCallType.Video, conversation.id);
          } on EMError catch (error) {}
        });

    Widget locationWidget = IconButton(
        icon: Icon(Icons.location_on),
        onPressed: () async {
          WidgetComponents.DefaultToast('发送位置消息待实现!');
        });

    extWidgetList.add(videoWidget);
    extWidgetList.add(locationWidget);
  }

  @override
  void onCmdMessagesReceived(List<EMMessage> messages) {
    // TODO: implement onCmdMessageReceived
  }

  @override
  void onMessagesDelivered(List<EMMessage> messages) {
    // TODO: implement onMessageDelivered
  }

  @override
  void onMessagesRead(List<EMMessage> messages) {
    // TODO: implement onMessageRead
  }

  @override
  void onMessagesRecalled(List<EMMessage> messages) {
    // TODO: implement onMessageRecalled
  }

  @override
  void onMessagesReceived(List<EMMessage> messages) {
    messageTotalList.insertAll(messageTotalList.length, messages);

    _$RefreshUI();

      
  }

  @override
  void dispose() {
    _scrollController.dispose();
    messageTotalList.clear();
    super.dispose();
    EMClient.getInstance.chatManager.removeListener(this);
    if (conversation.type == EMConversationType.ChatRoom) {
      checkOutRoom();
    }
  }

  /// 判断时间间隔在60秒内不需要显示时间
  bool _isShowTime(int index) {
    if (index == 0) {
      return true;
    }
    String lastTime = messageTotalList[index - 1].serverTime?.toString() ?? '0';

    String afterTime = messageTotalList[index].serverTime?.toString() ?? '0';

    return isCloseEnough(lastTime, afterTime);
  }

  ///判断消息时间间隔
  static bool isCloseEnough(String time1, String time2) {
    int lastTime = int.parse(time1);
    int afterTime = int.parse(time2);
    int delta = lastTime - afterTime;
    if (delta < 0) {
      delta = -delta;
    }
    return delta > 60000;
  }

  @override
  void onLongPressMessageItem(EMMessage message, Offset tapPos) {
    // TODO: implement didLongPressMessageItem
    print("长按了Item ");
  }

  @override
  void onTapMessageItem(EMMessage message) {
    // TODO: 消息点击
    if (message.direction == EMMessageDirection.RECEIVE) {
      if (message.attributes != null) {
        String conferenceId;
        String password;
        if (message.attributes['conferenceId'] != null &&
            message.attributes['conferenceId'].length > 0) {
          conferenceId = message.attributes['conferenceId'];
        } else if (message.attributes['em_conference_id'] != null) {
          conferenceId = message.attributes['em_conference_id'];
        }

        if (conferenceId != null) {
          if (message.attributes['password'] != null) {
            password = message.attributes['password'];
          } else if (message.attributes['em_conference_password'] != null) {
            password = message.attributes['em_conference_password'];
          }
        }
      }
    }
  }

  @override
  void onTapUserPortrait(String userId) {
    print("点击了用户头像 " + userId);
  }

  @override
  void onTapExtButton() {
    // TODO: implement didTapExtentionButton  点击了加号按钮
  }

  @override
  void inputStatusChanged(InputBarStatus status) {
    // TODO: implement inputStatusDidChange  输入工具栏状态发生变更
    if (status == InputBarStatus.Ext) {
      showExtWidget = true;
    } else {
      showExtWidget = false;
    }
    _$RefreshUI();
  }

  @override
  void onTapItemPicture(String imgPath) async {
    debugPrint('onTapItemPicture' + imgPath);
    EMMessage imageMessage = EMMessage.createImageSendMessage(
        username: conversation.id, filePath: imgPath, sendOriginalImage: true);
    sendMessage(imageMessage);
  }

  @override
  void onTapItemCamera(String imgPath) {
    debugPrint('onTapItemCamera' + imgPath);
    EMMessage imageMessage = EMMessage.createImageSendMessage(
        username: conversation.id, filePath: imgPath, sendOriginalImage: true);
    sendMessage(imageMessage);
  }

  @override
  void onTapItemEmojicon() {
    // TODO: implement onTapItemEmojicon
    WidgetComponents.DefaultToast('发送表情待实现!');
  }

  @override
  void onTapItemPhone() async {
    try {
      await EMClient.getInstance.callManager
          .makeCall(EMCallType.Video, conversation.id);
      try {} catch (e) {}
    } on EMError catch (error) {
      print('拨打通话失败 --- ' + error.description);
    }
  }

  @override
  void onTapItemFile() {
    WidgetComponents.DefaultToast('选择文件待实现!');
  }

  @override
  void sendText(String text) {
    EMMessage message = EMMessage.createTxtSendMessage(
        username: conversation.id, content: text);
    sendMessage(message);
  }

  void sendMessage(EMMessage message) async {
    messageTotalList.insert(messageTotalList.length, message);

    _$RefreshUI();

    try {
      await EMClient.getInstance.chatManager.sendMessage(message);

      if (widget?.merchantId?.isNotEmpty == true) {
        NetworkManager.instance
            .sendIMMessage(widget.merchantId, json.encode(message.toJson()));
      } else {
        print("商家店铺为空");
      }
    } on EMError catch (e) {}
  }

  @override
  void sendVoice(String path, int duration) {
    WidgetComponents.DefaultToast('语音消息待实现!');
  }

  @override
  void startRecordVoice() {
    _showExtraCenterWidget(ChatStatus.VoiceRecorder);
  }

  @override
  void stopRecordVoice() {
    _showExtraCenterWidget(ChatStatus.Normal);
  }

  @override
  onConversationsUpdate() {
    // TODO: implement onConversationsUpdate
    throw UnimplementedError();
  }
}

enum ChatStatus {
  Normal, //正常
  VoiceRecorder, //语音输入，页面中间回弹出录音的 gif
}
