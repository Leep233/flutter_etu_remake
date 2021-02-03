import 'package:flutter/material.dart';
import 'package:flutter_etu_remake/AppDefaultStyle.dart';
import 'package:flutter_etu_remake/Debug.dart';
import 'package:flutter_etu_remake/WidgetComponents.dart';
import 'package:flutter_etu_remake/core/NetworkManager.dart';
import 'package:flutter_etu_remake/core/UIManager.dart';
import 'package:flutter_etu_remake/l10n/localization_intl.dart';
import 'package:flutter_etu_remake/viewmodels/CommodityDetailPageViewModel.dart';
import 'package:flutter_etu_remake/viewmodels/CommoditySpecificationsViewModel.dart';
import 'package:flutter_etu_remake/viewmodels/DeliveryAddressItemViewModel.dart';
import 'package:flutter_etu_remake/views/components/CommentCard.dart';
import 'package:flutter_etu_remake/views/components/CommoditySpecificationsView.dart';
import 'package:flutter_etu_remake/views/components/CommoditySwiper.dart';
import 'package:flutter_etu_remake/views/components/ShareCard.dart';
import 'package:flutter_etu_remake/views/pages/DeliveryAddressListPage.dart';
import 'package:flutter_html/flutter_html.dart';

enum CommodityOperation { none, buy, addCart, selectSpecification }

///商品详情页面
class CommodityDetailPage extends StatefulWidget {
  CommodityDetailPage({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => CommodityDetailPageState();
}

class CommodityDetailPageState extends State<CommodityDetailPage>
    implements
        CommoditySpecificationsViewDelegate,
        DeliveryAddressListPageDelegate,
        ShareCardDelegate {
  final TextStyle titleStyle = TextStyle(color: Colors.grey, fontSize: 14);
  final TextStyle lableStyle = TextStyle(color: Colors.black, fontSize: 14);

  final double titleWidth = 70;

  CommodityDetailPageViewModel _viewModel;

  CommodityOperation _operation;

  ///当前商品编号
  String _comodityNo;

  @override
  void initState() {
    super.initState();

    _operation = CommodityOperation.none;

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _comodityNo = ModalRoute.of(context).settings.arguments?.toString();

      NetworkManager.instance
          .commodityDetail(productNo: int.parse(_comodityNo))
          .then((value) {
        if (value == null) return;

        _viewModel = CommodityDetailPageViewModel.transfrom(value);

        _$RefreshUI();
      });
    });
  }

  void _$RefreshUI() {
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
          local.commodityDetail,
          style: TextStyle(color: Colors.black,fontSize: AppDefaultStyle.AppTitleFontSize),
        ),
        leading: IconButton(
          icon: Icon(Icons.chevron_left, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(
              icon: Icon(Icons.favorite,
                  color: _viewModel?.isFavorite == true
                      ? Colors.deepOrange
                      : Colors.grey[600]),
              onPressed: _onClickMarkFavorite),
          IconButton(
              icon: Icon(Icons.share, color: Colors.grey[600]),
              onPressed: _onClickShare),
        ],
      ),
      body: Stack(children: [
        _$BuildBodyContent(),
        Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              height: 45,
              color: Colors.white,
              width: double.infinity,
              child: _$FooterBar(),
            )),
      ]),
    );
  }

  Widget _$BuildBodyContent() {
    return Container(
        child: ListView(
      children: [
        Container(
          color: Colors.amberAccent,
          height: 300,
          child: CommoditySwiper(
            images: _viewModel?.images,
          ),
        ),
        Container(
            margin: EdgeInsets.all(10),
            width: double.infinity,
            child: _$CommodityPriceCard()),
        Container(
            margin: EdgeInsets.all(10),
            width: double.infinity,
            child: _$PurchaseCommodityCard()),
        Container(
            margin: EdgeInsets.all(10),
            width: double.infinity,
            child: _$CommodityCommentCard()),
        //商品详情
        Container(
            margin: const EdgeInsets.fromLTRB(8, 0, 8, 0),
            child: _$DetailsContent(_viewModel?.details)),

        Container(
            alignment: Alignment.center,
            margin: EdgeInsets.fromLTRB(0, 0, 0, 45),
            child: Text(
              "----底部----",
              style: TextStyle(color: Colors.grey, fontSize: 14),
            )),
      ],
    ));
  }

  ///商品价格描述卡
  Widget _$CommodityPriceCard() {
    return Card(
      child: Container(
        margin: const EdgeInsets.all(10),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Container(
            child: WidgetComponents.MeonyLabel(_viewModel?.price ?? 0,
                originalPrice: _viewModel?.originalPrice ?? 0, scale: 2),
          ),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 5),
            child: Text(
              _viewModel?.title ?? "",
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontSize: AppDefaultStyle.TitleFontSize, fontWeight: FontWeight.bold),
            ),
          ),
          Container(
            child: Text(
              _viewModel?.subTitle ?? "",
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontSize: AppDefaultStyle.SubtitleFontSize, color: Colors.grey),
            ),
          )
        ]),
      ),
    );
  }

  ///购买商品信息描述卡
  Widget _$PurchaseCommodityCard() {
    //规格选择
    Widget specification = Row(
      children: [
        Container(margin: EdgeInsets.only(right: 5),
          child: Text(AppLocalizations.of(context).selectedSpecification,style: titleStyle,),
          width: titleWidth,
        ),
        Expanded(
            child: FlatButton(
                padding: EdgeInsets.all(0),
                onPressed: _onClickSpecificationSelection,
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                          child: Text(
                        _viewModel?.selectedSpecification?.toString() ?? "",
                        style: lableStyle,
                      )),
                      Icon(Icons.chevron_right, color: Colors.grey)
                    ])))
      ],
    );
    //快递
    Widget express = Row(
      children: [
        Container(
          margin: EdgeInsets.only(right: 5),
          child: Text(
            AppLocalizations.of(context).express,
            style: titleStyle,
          ),
          width: titleWidth,
        ),
        Expanded(
            child: FlatButton(
                padding: EdgeInsets.all(0),
                onPressed: _onClickAddressSelection,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                              child: Text(
                            _viewModel?.postage ?? "",
                            style: lableStyle,
                          )),
                          Icon(Icons.chevron_right, color: Colors.grey)
                        ]),
                    Text(
                      "配送至:${_viewModel?.address ?? ""}",
                      style: const TextStyle(color: Colors.grey, fontSize: 14),
                    )],
                )))
      ],
    );

    Widget originPlace = Row(
      children: [
        Container(
          child: Text(
            AppLocalizations.of(context).originPlace,
            style: titleStyle,
          ),
          width: titleWidth,
        ),
        Expanded(
            child: Text(
          _viewModel?.placeOfProduct ?? "",
          style: lableStyle,
        ))
      ],
    );

    Widget features = Row(
      children: [
        Container(
          child: Text(
            AppLocalizations.of(context).features,
            style: titleStyle,
          ),
          width: titleWidth,
        ),
        Expanded(
            child: Text(
          _viewModel?.feature ?? "",
          style: lableStyle,
        ))
      ],
    );

    Widget advantage = Row(
      children: [
        Container(
          child: Text(
            AppLocalizations.of(context).advantage,
            style: titleStyle,
          ),
          width: titleWidth,
        ),
        Expanded(
            child: Text(
          _viewModel?.advantage ?? "",
          style: lableStyle,
        ))
      ],
    );

    Widget match = Row(
      children: [
        Container(
          child: Text(
            AppLocalizations.of(context).suggested,
            style: titleStyle,
          ),
          width: titleWidth,
        ),
        Expanded(
            child: Text(
          _viewModel?.suggested ?? "",
          style: lableStyle,
        ))
      ],
    );

    return Card(
      child: Container(
        margin: const EdgeInsets.fromLTRB(15, 10, 10, 15),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                child: specification,
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 8),
                child: express,
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 8),
                child: originPlace,
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 8),
                child: features,
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 8),
                child: advantage,
              ),
              Container(
                child: match,
              ),
            ]),
      ),
    );
  }

  ///商品评论
  Widget _$CommodityCommentCard() {
    Widget commentTitle =
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      Text(
        AppLocalizations.of(context)
            .commodityComments(_viewModel?.comments?.length ?? 0),
        style: TextStyle(
            fontSize: AppDefaultStyle.TitleFontSize, color: Colors.black, fontWeight: FontWeight.w600),
      ),
      TextButton(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              AppLocalizations.of(context).viewMore,
              style: titleStyle,
            ),
            Icon(
              Icons.chevron_right,
              size: 16,
              color: Colors.grey,
            )
          ],
        ),
        onPressed: _onClickMoreComment,
      )
    ]);

    return Card(
      child: Container(
          margin: const EdgeInsets.all(10),
          child: Column(children: [
            Container(child: commentTitle),
            if (_viewModel?.comments != null &&
                _viewModel?.comments?.length > 0)
              Container(
                child: CommentCard(
                  content: _viewModel?.comments?.first,
                  elevation: 0,
                ),
              ),
          ])),
    );
  }

  Widget _$DetailsContent(String detailsHtml) {
    Widget html = Html(
      data: detailsHtml,
      onImageError: (a1, a2) {},
      //Optional parameters:
      onLinkTap: (url) {
        // open url in a webview
      },
      onImageTap: (src) {
        // Display the image in large form.
      },
    );
    return html;
  }

  ///购买
  Widget _$FooterBar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Container(
            child: InkWell(
          child: Icon(Icons.store),
          onTap: _onClickStoreBtn,
        )),
        Container(
            child: InkWell(
          child: Icon(Icons.headset_mic),
          onTap: _onClickServicesCustomBtn,
        )),
        Row(
          children: [
            Container(
              child: FlatButton(
                color: Colors.deepOrangeAccent,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        bottomLeft: Radius.circular(20))),
                child: Container(
                  width: 80,
                  child: Text(
                    AppLocalizations.of(context).addToCart,
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                onPressed: _onClickJoininShoppingCartBtn,
              ),
            ),
            Container(
              child: FlatButton(
                color: Colors.red,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(20),
                        bottomRight: Radius.circular(20))),
                child: Container(
                  width: 80,
                  child: Text(
                    AppLocalizations.of(context).buyNow,
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                onPressed: _onClickBuyBtn,
              ),
            ),
          ],
        )
      ],
    );
  }

  void $ShowCommoditySpecificationsBottomSheet() async {
    CommoditySpecificationsViewModel viewModel =
        CommoditySpecificationsViewModel(
            describe: _viewModel?.title,
            productNo: _viewModel.productNo,
            specifications: _viewModel?.specifications,
            picture: _viewModel?.mianPicture);

    await showModalBottomSheet(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadiusDirectional.circular(3)), //加圆角
        context: context,
        builder: (_) => Container(
            child:
                CommoditySpecificationsView(data: viewModel, listener: this)));
  }

  void _onClickMarkFavorite() {
    NetworkManager.instance
        .collection(type: 0, productNo: _viewModel.productNo)
        .then((value) {
      _viewModel?.isFavorite = value == 1;

      _$RefreshUI();
    });
  }

  void _onClickSpecificationSelection() {
    _operation = CommodityOperation.selectSpecification;
    $ShowCommoditySpecificationsBottomSheet();
  }

  void _onClickAddressSelection() {
    Navigator.push<DeliveryAddressItemViewModel>(context,
        new MaterialPageRoute(builder: (BuildContext context) {
      return DeliveryAddressListPage(
        listener: this,
      );
    })).then((data) {
      _viewModel?.address = data.address;
      _viewModel?.addressId = data.id == null ? null : int.parse(data.id);
      _$RefreshUI();
    });
  }

  void _onClickMoreComment() {
    UIManager.instance.toPage(context, UIDef.commentList,arguments: _viewModel?.productNo);
  }

  void _onClickStoreBtn() {
    UIManager.instance
        .toPage(context, UIDef.storeDetial, arguments: _viewModel.storeId);
  }

  void _onClickBuyBtn() async {
    _operation = CommodityOperation.buy;
    $ShowCommoditySpecificationsBottomSheet();
  }

  void _onClickJoininShoppingCartBtn() async {
    _operation = CommodityOperation.addCart;
    $ShowCommoditySpecificationsBottomSheet();
  }

  void _onClickServicesCustomBtn() {}

  @override
  void onPressedConfirm(Object arg) {
    // TODO: implement onPressedConfirm

    CommoditySpecificationsViewModel data =
        arg as CommoditySpecificationsViewModel;

    switch (_operation) {
      case CommodityOperation.buy:
        Debug.log("购买商品 id:[${data.commodityNo} x ${data.quantity} ]");

        NetworkManager.instance
            .submitOrder(data.commodityNo, data.quantity,
                addressId: _viewModel.addressId)
            .then((value) {
          if (value != null)
            UIManager.instance
                .toPage(context, UIDef.comfirmOrder, arguments: value);
        });

        break;
      case CommodityOperation.addCart:
        Debug.log("加入购物车 ${data.commodityNo} ${data.quantity}");

        NetworkManager.instance
            .addToCart(data.commodityNo, data.quantity)
            .then((value) => WidgetComponents.DefaultToast(value));
        _$RefreshUI();
        break;
      case CommodityOperation.selectSpecification:
        _$RefreshUI();
        break;
      default:
    }
  }

  @override
  void onSpecificationChanged(Map<String, String> specification) {
    _viewModel?.selectedSpecification = specification;
  }

  @override
  onClickDeliveryAddressItem(DeliveryAddressItemViewModel data) {
    Navigator.pop(context, data);
  }

  void _onClickShare() async {
    await showModalBottomSheet(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadiusDirectional.circular(3)), //加圆角
        context: context,
        builder: (_) => Container(
            height: MediaQuery.of(context).size.height * 0.35,
            child: ShareCard(
              listener: this,
            )));
  }

  @override
  onShareCopyLink() {
    // TODO: implement onShareCopyLink
    throw UnimplementedError();
  }

  @override
  onShareFriends() {
    // TODO: implement onShareFriends
    throw UnimplementedError();
  }

  @override
  onShareGenerateImage() {
    // TODO: implement onShareGenerateImage
    throw UnimplementedError();
  }

  @override
  onShareQQ() {
    // TODO: implement onShareQQ
    throw UnimplementedError();
  }

  @override
  onShareWechat() {
    // TODO: implement onShareWechat
    throw UnimplementedError();
  }
}
