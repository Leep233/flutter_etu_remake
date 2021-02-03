import 'package:flutter/material.dart';
import 'package:flutter_etu_remake/WidgetComponents.dart';
import 'package:flutter_etu_remake/core/NetworkManager.dart';
import 'package:flutter_etu_remake/l10n/localization_intl.dart';
import 'package:flutter_etu_remake/viewmodels/CommentCardViewModel.dart';
import 'package:flutter_etu_remake/views/components/CommentCard.dart';
import 'package:flutter_etu_remake/views/components/RefreshListView.dart';
import 'package:flutter_etu_remake/views/components/SelectorWidget.dart';

//评论列表
class CommentListPage extends StatefulWidget {
  final String title;

  CommentListPage({Key key, this.title = '全部评论'}) : super(key: key);

  @override
  State<StatefulWidget> createState() => CommentListPageState();
}

class CommentListPageState extends State<CommentListPage>
    implements RefreshListViewDeleagate {
  List<CommentCardViewModel> _comment = [];

  // 1:全部 2：有图 3：其他
  int selectedType;

  int _pageNum = 0;

  String _commodityId;

  @override
  void initState() {
    super.initState();

    selectedType = 1;

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _commodityId = ModalRoute.of(context).settings.arguments?.toString();

      onRefreshPull();
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
    AppLocalizations local = AppLocalizations.of(context);
    return Scaffold(
        appBar: AppBar(
          elevation: 0.1,
          backgroundColor: Colors.white,
          title: Text(
            local.allComments(_comment?.length ?? 0),
            style: TextStyle(color: Colors.black),
          ),
          leading: IconButton(
            icon: Icon(Icons.chevron_left, color: Colors.black),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: _bodyBuilder(context));
  }

  Widget _bodyBuilder(BuildContext context) {
    RefreshListView refreshListView = RefreshListView(
      itemBuilder: _commentListViewBuidler,
      itemCount: _comment.length,
      listener: this,
    );

    return Container(
      color: Colors.white,
      child: Column(children: [
        _commentsTypeWidget(),
        Expanded(child: Container(child: refreshListView))
      ]),
    );
  }

  Widget _commentsTypeWidget() {
    return Container(
      margin: EdgeInsets.all(10),
      child: Row(children: [
        SelectorWidget<int>(
          groupValue: selectedType,
          value: 1,
          onChanged: onSelectedChanged,
          selected: _selectedWidget("全部"),
          unselected: _unselectedWidget("全部"),
        ),
        SelectorWidget<int>(
          groupValue: selectedType,
          value: 2,
          onChanged: onSelectedChanged,
          selected: _selectedWidget("有图"),
          unselected: _unselectedWidget("有图"),
        ),
        SelectorWidget<int>(
          groupValue: selectedType,
          value: 3,
          onChanged: onSelectedChanged,
          selected: _selectedWidget("其他"),
          unselected: _unselectedWidget("其他"),
        )
      ]),
    );
  }

  Widget _unselectedWidget(String s) {
    return WidgetComponents.Tips(s,
        style: TextStyle(color: Colors.black87, fontSize: 12),
        borderColor: Colors.transparent,padding: EdgeInsets.fromLTRB(3,2,3,2),
        bgColor: Colors.black12);
  }

  Widget _selectedWidget(String s) {
    return WidgetComponents.Tips(s,
        style: TextStyle(color: Colors.red, fontSize: 13),
        padding: EdgeInsets.fromLTRB(3,2,3,2),
        borderColor: Colors.red,
        bgColor: Colors.white12);
  }

  Widget _commentListViewBuidler(BuildContext context, int index) {
    return Container(
      child: CommentCard(content: _comment[index]),
    );
  }

  @override
  Future onRefreshDropdown() {
    return NetworkManager.instance
        .comments(
            pageNum: ++_pageNum, productNo: _commodityId, type: selectedType)
        .then((value) {
      _comment .addAll(value.map((e) => CommentCardViewModel.transfrom(e))?.toList()) ;
      _$RefreshUI();
    });
  }

  @override
  Future onRefreshPull() {
    if (_pageNum == 1) return null;
    _pageNum = 1;

    return NetworkManager.instance
        .comments(
            pageNum: _pageNum, productNo: _commodityId, type: selectedType)
        .then((value) {
      _comment = value.map((e) => CommentCardViewModel.transfrom(e))?.toList();
      _$RefreshUI();
    });
  }

  void onSelectedChanged(dynamic value) {
    _pageNum = 0;
    selectedType = value;
    onRefreshPull();
  }
}
