import 'package:flutter/material.dart';
import 'package:flutter_etu_remake/common/MediaUtil.dart';

// ignore: must_be_immutable
class BottomInputBar extends StatefulWidget {
  BottomInputBarDelegate delegate;

  BottomInputBar(BottomInputBarDelegate delegate) {
    this.delegate = delegate;
  }

  @override
  _BottomInputBarState createState() => _BottomInputBarState(this.delegate);
}

class _BottomInputBarState extends State<BottomInputBar> {
  BottomInputBarDelegate delegate;
  TextField textField;
  FocusNode focusNode = FocusNode();
  InputBarStatus inputBarStatus;

  String message;
  bool isChanged = false;
  bool isShowVoiceAction = false;

  final controller = new TextEditingController();

  _BottomInputBarState(BottomInputBarDelegate delegate) {
    this.delegate = delegate;
    this.inputBarStatus = InputBarStatus.Normal;
  }

  @override
  void initState() {
    super.initState();
    focusNode.addListener(() {
      if (focusNode.hasFocus) {
        _notifyInputStatusChanged(InputBarStatus.Normal);
      }
    });
  }

  void _submittedMessage(String messageStr) {
    if (messageStr == null || messageStr.length <= 0) {
      print('不能为空');
      return;
    }
    if (this.delegate != null) {
      this.delegate.sendText(messageStr);
    } else {
      print("没有实现 BottomInputBarDelegate");
    }
    this.textField.controller.text = '';
    this.message = '';
  }

  switchExt() {
    print("switchExtention");
    if (focusNode.hasFocus) {
      focusNode.unfocus();
    }
    InputBarStatus status = InputBarStatus.Normal;
    if (this.inputBarStatus != InputBarStatus.Ext) {
      status = InputBarStatus.Ext;
    }
    if (this.delegate != null) {
      this.delegate.onTapExtButton();
    } else {
      print("没有实现 BottomInputBarDelegate");
    }
    _notifyInputStatusChanged(status);
  }

  sendMessages() {
    if (message.isEmpty || message.length <= 0) {
      print('不能为空');
      return;
    }
    if (this.delegate != null && isChanged) {
      print(message + '...');
      this.delegate.sendText(message);
    } else {
      print("没有实现 BottomInputBarDelegate");
    }
    this.textField.controller.text = '';
    this.message = '';
  }

  _onTapVoiceLongPress() {
    print("_onTapVoiceLongPress");
  }

  _onTapVoiceLongPressEnd() {
    print("_onTapVoiceLongPressEnd");
  }

  void _notifyInputStatusChanged(InputBarStatus status) {
    this.inputBarStatus = status;
    if (this.delegate != null) {
      this.delegate.inputStatusChanged(status);
    } else {
      print("没有实现 BottomInputBarDelegate");
    }
  }

  ///点击相册 选择图片
  void _selectPicture() async {
    String imgPath = await MediaUtil.instance.pickImage();
    if (imgPath == null) {
      return;
    }
    this.delegate.onTapItemPicture(imgPath);
  }

  ///点击相机拍照
  void _takePicture() async {
    String imgPath = await MediaUtil.instance.takePhoto();
    if (imgPath == null) {
      return;
    }
    this.delegate.onTapItemCamera(imgPath);
  }

  ///点击表情item
  void _selectEmojicon() async {
    print("_selectEmojicon_");
    this.delegate.onTapItemEmojicon();
  }

  ///点击音频item
  void _makeVoiceCall() async {
    this.delegate.onTapItemPhone();
  }

  ///点击文件item
  void _makeFileCall() async {
    print("_makeFileCall_");
    this.delegate.onTapItemFile();
  }

  ///点击语音消息item
  void _sendVoiceMessage() async {
    print("_sendVoiceMessage_");
    this.delegate.sendVoice('', 0);
  }

  @override
  Widget build(BuildContext context) {
    this.textField = TextField(
      onSubmitted: _submittedMessage,
      controller: controller,
      style: TextStyle(fontSize: 16),
      maxLines: 1,
      decoration: InputDecoration(
          focusColor: Colors.black87,
          hoverColor: Colors.black87,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 12, vertical: 10)),
      focusNode: focusNode,
      onChanged: (text) {
        //内容改变的回调
        message = text;
        isChanged = true;
      },
    );

    return Container(
      decoration: BoxDecoration(
          color: Colors.grey[50],
          border: Border(
              top: BorderSide(
                width: 0.1,
              ),
              bottom: BorderSide(
                width: 0.1,
              ))),
      padding: const EdgeInsets.all(10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Container(
            child: _$InputFieldWidget(),
          ),
          Container(
            child: _$ActionsWidget(),
          ),

          //            Visibility(
          //
          //            )
        ],
      ),
    );
  }

  Widget _$InputFieldWidget() {
    return Row(
      children: <Widget>[
        Expanded(
            child:
                Container(alignment: Alignment.center, child: this.textField)),
        Container(
          margin: const EdgeInsets.only(left: 8),
          width: 60,
          height: 40,
          alignment: Alignment.center,
          child: FlatButton(
            padding: const EdgeInsets.all(0),
            color: Theme.of(context).buttonColor,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            child: Icon(Icons.send),
            onPressed: () {
              sendMessages();
            },
          ),
        ),
      ],
    );
  }

  Widget _$ActionsWidget() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        InkWell(
          child: Icon(
            Icons.mic,
            color: Colors.grey,
          ),
          onTap: () {
            isShowVoiceAction = true;
            _sendVoiceMessage();
          },
        ),
        InkWell(
          child: Icon(
            Icons.call,
            color: Colors.grey,
          ),
          onTap: () {
            _makeVoiceCall();
          },
        ),
        InkWell(
          child: Icon(
            Icons.file_upload,
            color: Colors.grey,
          ),
          onTap: () {
            _makeFileCall();
          },
        ),
        InkWell(
          child: Icon(
            Icons.camera_enhance,
            color: Colors.grey,
          ),
          onTap: () {
            _takePicture();
          },
        ),
        InkWell(
          child: Icon(
            Icons.image,
            color: Colors.grey,
          ),
          onTap: () {
            _selectPicture();
          },
        ),
        InkWell(
          child: Icon(
            Icons.face,
            color: Colors.grey,
          ),
          onTap: () {
            _selectEmojicon();
          },
        ),
        /*
                          Expanded(
                            child: FlatButton(
                              child: Text("7"),
                               minWidth: 40,
                              onPressed: (){
                                switchExt();
                              },
                            ),
                          ),*/
      ],
    );
  }
}

enum InputBarStatus {
  Normal, //正常
  Voice, //语音输入
  Ext, //扩展栏
}

abstract class BottomInputBarDelegate {
  ///输入工具栏状态发生变更
  void inputStatusChanged(InputBarStatus status);

  ///发送消息
  void sendText(String text);

  ///发送语音
  void sendVoice(String path, int duration);

  ///开始录音
  void startRecordVoice();

  ///停止录音
  void stopRecordVoice();

  ///点击了加号按钮
  void onTapExtButton();

  ///点击了相机
  void onTapItemCamera(String imgPath);

  ///点击了相册
  void onTapItemPicture(String imgPath);

  ///点击了表情
  void onTapItemEmojicon();

  ///点击音频
  void onTapItemPhone();

  ///点击文件
  void onTapItemFile();
}
