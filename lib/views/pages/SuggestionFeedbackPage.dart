import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_etu_remake/AppDefaultStyle.dart';
import 'package:flutter_etu_remake/Global.dart';
import 'package:flutter_etu_remake/WidgetComponents.dart';
import 'package:flutter_etu_remake/views/components/SelectorWidget.dart';
import 'package:image_picker/image_picker.dart';

class SuggestionFeedbackPage extends StatefulWidget {
  SuggestionFeedbackPage({Key key}) : super(key: key);
  @override
  State<StatefulWidget> createState() => SuggestionFeedbackPageState();
}

class SuggestionFeedbackPageState extends State<SuggestionFeedbackPage> {
  int selectedType = 0;

  final int kImageCount = 6;

  List<String> images;

  @override
  void initState() {
    super.initState();
    images = [];
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void deactivate() {
    super.deactivate();
  }

  _$RefreshUI() {
    if (mounted) setState(() {});
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
            "意见反馈",
            style: AppDefaultStyle.appTitleStyle,
          ),
        ),
        body: Container(
          margin: const EdgeInsets.all(15),
          width: screen.width,
          height: screen.height,
          child: _$BuildBody(context),
        ));
  }

  Widget _$BuildBody(BuildContext context) {
    return Container(
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Container(
            child: Text(
          "请选择问题类型",
          style: TextStyle(fontWeight: FontWeight.bold),
        )),
        _$SuggestionSelector(),
        Container(
          child: WidgetComponents.Line(),
          margin: const EdgeInsets.symmetric(vertical: 5),
        ),
        Container(
          child: TextField(
            style: TextStyle(fontSize:15),
            maxLength: 200,
            maxLines: 6,
            decoration: InputDecoration.collapsed(hintText: "请描述您遇到的问题，不少于10字"),
          ),
        ),
        Container(
          child: WidgetComponents.Line(),
          margin: const EdgeInsets.symmetric(vertical: 5),
        ),
        Container(child: _$ImagesLabel())
      ]),
    );
  }

  Widget _$SuggestionSelector() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
        SelectorWidget<int>(
          groupValue: selectedType,
          value: 0,
          onChanged: onSelectedChanged,
          selected: _$SelectedItem("问题BUG"),
          unselected: _$UnselectedItem("问题BUG"),
        ),
        SelectorWidget<int>(
          groupValue: selectedType,
          value: 1,
          onChanged: onSelectedChanged,
          selected: _$SelectedItem("需求建议"),
          unselected: _$UnselectedItem("需求建议"),
        ),
        SelectorWidget<int>(
          groupValue: selectedType,
          value: 2,
          onChanged: onSelectedChanged,
          selected: _$SelectedItem("使用体验"),
          unselected: _$UnselectedItem("使用体验"),
        ),
        SelectorWidget<int>(
          groupValue: selectedType,
          value: 3,
          onChanged: onSelectedChanged,
          selected: _$SelectedItem("其他"),
          unselected: _$UnselectedItem("其他"),
        )
      ]),
    );
  }

  Widget _$UnselectedItem(String s) {
    return WidgetComponents.Tips(s,
        style: TextStyle(color: Colors.black87, fontSize: 12),
        borderColor: Colors.transparent,
        padding: EdgeInsets.fromLTRB(3, 2, 3, 2),
        bgColor: Colors.black12);
  }

  Widget _$SelectedItem(String s) {
    return WidgetComponents.Tips(s,
        style: TextStyle(color: Colors.red, fontSize: 13),
        padding: EdgeInsets.fromLTRB(3, 2, 3, 2),
        borderColor: Colors.red,
        bgColor: Colors.white12);
  }

  Widget _$Image(String imagePath, void Function() onDeleted,
      {double size = 80}) {
    return Container(
        width: size,
        height: size,
        child: Stack(
          children: [
            Container(
                padding: EdgeInsets.all(5),
                width: double.infinity,
                height: double.infinity,
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(5),
                    child: Image.file(
                      File(imagePath),
                      fit: BoxFit.fill,
                    ))),
            Positioned(
                top: 0,
                right: 0,
                child: GestureDetector(
                    onTap: onDeleted,
                    child: Container(
                        decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(10)),
                        child: Icon(
                          Icons.close,
                          color: Colors.white,
                          size: 20,
                        ))))
          ],
        ));
  }

  Widget _$ImagesLabel() {
    List<Widget> imgWidget = [];

    for (var i = 0; i < images.length; i++) {
      imgWidget.add(_$Image(images[i], () {
        setState(() {
          images.removeAt(i);
        });
      }, size: 100));
    }

    if (imgWidget.length < kImageCount) {
      imgWidget.add(Container(
        width: 100,
        height: 100,
        padding: const EdgeInsets.all(5),
        child: Container(
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),border: Border.all(color: Colors.grey)),
            child: FlatButton(onPressed: _onClickAddImageBtn, child: Icon(Icons.add))),
      ));
    }

    return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ignore: unnecessary_brace_in_string_interps
          Container(
            width: double.infinity,
            margin: const EdgeInsets.fromLTRB(5, 10, 5, 10),
            child: Text(
              "上传图片（最多${kImageCount}张）",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Container(
              margin: const EdgeInsets.fromLTRB(20, 10, 20, 5),
              child: Wrap(
                // alignment: WrapAlignment.spaceAround,
                children: imgWidget,
              ))
        ]);
  }

  void onSelectedChanged(dynamic value) {
    selectedType = value;
    _$RefreshUI();
  }

  Future _onClickAddImageBtn() {
    print("添加图片");

    return Global.picker.getImage(source: ImageSource.gallery).then((value) {
      if (value != null) {
        images.add(value.path);
        _$RefreshUI();
      } else {
        print('No image selected.');
      }
    });
  }
}
