import 'package:flutter/foundation.dart';
import 'package:flutter_etu_remake/Debug.dart';
import 'package:flutter_etu_remake/WidgetComponents.dart';
import 'package:im_flutter_sdk/im_flutter_sdk.dart';

//收发消息控制
class MessageManager implements EMConnectionListener, EMChatManagerListener {
  MessageManager._();

  static MessageManager _instance;
  static MessageManager get instance => _getInstance();

  static MessageManager _getInstance() {
    if (_instance == null) _instance = MessageManager._();
    return _instance;
  }

  // ignore: non_constant_identifier_names
  Future<void> init({String im_key}) async {
    print("${this.runtimeType} init !");

    await initEaseMobSDK(im_key);
  }

  bool isLogin;

// ignore: non_constant_identifier_names
  Future<void> initEaseMobSDK(String im_key) async {
    EMOptions options = EMOptions(appKey: im_key);
    EMPushConfig config = EMPushConfig();
    // 配置推送信息
    config
      ..enableAPNs("chatdemoui_dev")
      ..enableHWPush()
      ..enableFCM('')
      ..enableMeiZuPush('', '')
      ..enableMiPush('', '');
    options.pushConfig = config;
    await EMClient.getInstance.init(options);

    //EMClient.getInstance.addConnectionListener(this);

   // EMClient.getInstance.chatManager.addListener(this);

//    EMClient.getInstance.callManager.registerCallSharedManager();
//    EMClient.getInstance.conferenceManager.registerConferenceSharedManager();

    isLogin = EMClient.getInstance.isLoginBefore;
  }

  login(String phone) async {
    String userName = 'app$phone';
    String password = 'im$phone';

    print("登录 账号:$userName | 密码:$password ");

    try {
      await EMClient.getInstance.login(userName, password);
    } on EMError catch (e) {
      print('操作失败，原因是: $e');
      switch (e.code) {
        case 2:
          {
            WidgetComponents.DefaultToast('网络未连接!');
          }
          break;
        case 202:
          {
            WidgetComponents.DefaultToast('密码错误!');
          }
          break;
        case 204:
          {
            WidgetComponents.DefaultToast('用户ID不存在!');
          }
          break;
        case 300:
          {
            WidgetComponents.DefaultToast('无法连接服务器!');
          }
          break;
        default:
          {
            WidgetComponents.DefaultToast(e.description);
          }
          break;
      }
    }
  }

  logout() {
    EMClient.getInstance?.logout();
  }

  @override
  void onConnected() {
    // TODO: implement onConnected
  }

  @override
  void onDisconnected(int errorCode) {
    // TODO: implement onDisconnected
  }

  release() {
    EMClient.getInstance?.removeConnectionListener(this);

    EMClient.getInstance?.chatManager?.removeListener(this);

    logout();
  }

  @override
  onCmdMessagesReceived(List<EMMessage> messages) {
    Debug.log("onCmdMessagesReceived");
  }

  @override
  onConversationsUpdate() {
   Debug.log("onConversationsUpdate");
  }

  @override
  onMessagesDelivered(List<EMMessage> messages) {
     Debug.log("onMessagesDelivered");
  }

  @override
  onMessagesRead(List<EMMessage> messages) {
   Debug.log("onMessagesRead");
  }

  @override
  onMessagesRecalled(List<EMMessage> messages) {
   Debug.log("onMessagesRecalled");
  }

  @override
  onMessagesReceived(List<EMMessage> messages) {
 Debug.log("onMessagesReceived");
  }

  ///加载会话列表
  // ignore: missing_return
  Future<List<EMConversation>> loadConversationList() {

   bool isLogin =  EMClient.getInstance.isLoginBefore;

    try {
      return EMClient.getInstance.chatManager.loadAllConversations();
    } on EMError catch (e) {
      print('操作失败，原因是: $e');
    }
  }

  ///发送消息
  Future sendMessage(EMMessage message) {
    try {
      return EMClient.getInstance.chatManager.sendMessage(message);
    } on EMError catch (e) {
      print('操作失败，原因是: $e');
    }
  }
}
