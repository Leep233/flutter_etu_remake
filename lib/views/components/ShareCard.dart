import 'package:flutter/material.dart';
import 'package:flutter_etu_remake/AppDefaultStyle.dart';
import 'package:flutter_etu_remake/WidgetComponents.dart';

class ShareCard extends StatelessWidget {
/*

    - assets/images/icon_fzlj_nor.png
    - assets/images/icon_qqhy_nor.png
    - assets/images/icon_pyq_nor.png
    - assets/images/icon_sctp_nor.png
    - assets/images/icon_wxhy_nor.png
    
 */

  final ShareCardDelegate listener;

  ShareCard({this.listener});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      child: Column(children: [
        Expanded(
            child: Container(
                alignment: Alignment.center,
                child: Text(
                  "分享至",
                  style: AppDefaultStyle.appTitleStyle,
                ))),
        Expanded(
            flex: 5,
            child: Container(
              child: Wrap(spacing: 30, children: [
                WidgetComponents.ImageButton(
                    "assets/images/icon_wxhy_nor.png", "微信好友",
                    iconSize: 50, onPressed: listener?.onShareWechat),
                WidgetComponents.ImageButton(
                    "assets/images/icon_pyq_nor.png", "朋友圈",
                    iconSize: 50, onPressed: listener?.onShareFriends),
                WidgetComponents.ImageButton(
                    "assets/images/icon_qqhy_nor.png", "QQ好友",
                    iconSize: 50, onPressed: listener?.onShareQQ),
                WidgetComponents.ImageButton(
                    "assets/images/icon_fzlj_nor.png", "复制链接",
                    iconSize: 50, onPressed: listener?.onShareCopyLink),
                WidgetComponents.ImageButton(
                    "assets/images/icon_sctp_nor.png", "生成图片",
                    iconSize: 50, onPressed: listener?.onShareGenerateImage),
              ]),
            ))
      ]),
    );
  }
}

abstract class ShareCardDelegate {
  onShareWechat();
  onShareFriends();
  onShareQQ();
  onShareCopyLink();
  onShareGenerateImage();
}
