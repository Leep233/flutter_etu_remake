import 'package:flutter/material.dart';
import 'package:flutter_etu_remake/core/UIManager.dart';
import 'package:flutter_etu_remake/l10n/localization_intl.dart';
import 'package:flutter_etu_remake/Global.dart';
import 'package:flutter_etu_remake/views/pages/ChangeDetailPage.dart';
import 'package:flutter_etu_remake/views/pages/CollectionCommodityPage.dart';
import 'package:flutter_etu_remake/views/pages/CategoryCommodityPage.dart';
import 'package:flutter_etu_remake/views/pages/CollectionStorePage.dart';
import 'package:flutter_etu_remake/views/pages/CommentListPage.dart';
import 'package:flutter_etu_remake/views/pages/CommodityDetailPage.dart';
import 'package:flutter_etu_remake/views/pages/ConfirmOrderPage.dart';
import 'package:flutter_etu_remake/views/pages/DeliveryAddressListPage.dart';
import 'package:flutter_etu_remake/views/pages/FootprintPage.dart';
import 'package:flutter_etu_remake/views/pages/ForgotPasswordPage.dart';
import 'package:flutter_etu_remake/views/pages/HomePage.dart';
import 'package:flutter_etu_remake/views/pages/HotSalePage.dart';
import 'package:flutter_etu_remake/views/pages/LoginPage.dart';
import 'package:flutter_etu_remake/views/pages/MessageCenterPage.dart';
import 'package:flutter_etu_remake/views/pages/MyOrdersPage.dart';
import 'package:flutter_etu_remake/views/pages/OrderDetialPage.dart';
import 'package:flutter_etu_remake/views/pages/PaymentFailurePage.dart';
import 'package:flutter_etu_remake/views/pages/PaymentPage.dart';
import 'package:flutter_etu_remake/views/pages/PaymentSuccessPage.dart';
import 'package:flutter_etu_remake/views/pages/QuickLoginByPhoneNumberPage.dart';
import 'package:flutter_etu_remake/views/pages/RegisterPage.dart';
import 'package:flutter_etu_remake/views/pages/StoreDetialPage.dart';
import 'package:flutter_etu_remake/views/pages/SuggestionFeedbackPage.dart';
import 'package:flutter_etu_remake/views/pages/UserBalancePage.dart';
import 'package:flutter_etu_remake/views/pages/WithdrawalPage.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';

/*
  ==============[编码规范]=================
  1.除自定义Widget类以外 自定义Widget类 内部UIWidget 组件均命名方式为 _$函数名() 如 _$Line() 函数名首字母大写 如果全局公共UI 首字母大写 如 Widget Line();
  2.与UI无关函数 均为拖分命名法
  3.私有函数,字段,类 前面均加 '_'
*/

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  Global.init().then((value) => runApp(App()));
}

class App extends StatefulWidget {
  final String title;

  App({Key key, this.title = ''}) : super(key: key);

  @override
  State<StatefulWidget> createState() => AppState();
}

class AppState extends State<App> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    Global.release();
    super.dispose();
  }

  @override
  void deactivate() {
    super.deactivate();
  }

  Map<String, WidgetBuilder> get routes => <String, WidgetBuilder>{
        // "login": (context) => LoginRoute(),
        UIDef.login: (context) => LoginPage(),
        UIDef.register: (context) => RegisterPage(),
        UIDef.forgotPassword: (context) => ForgotPasswordPage(),
        UIDef.quickLoginByPhoneNumber: (context) =>
            QuickLoginByPhoneNumberPage(),
        UIDef.home: (context) => HomePage(),
        UIDef.hotSale: (context) => HotSalePage(),
        UIDef.commodityDetail: (context) => CommodityDetailPage(),
        UIDef.commentList: (context) => CommentListPage(),
        UIDef.deliveryAddress: (context) => DeliveryAddressListPage(),
        UIDef.storeDetial: (context) => StoreDetialPage(),
        UIDef.comfirmOrder: (context) => ComfirmOrderPage(),
        UIDef.collectionCommodity: (context) => CollectionCommodityPage(),
        UIDef.categoryCommodity: (context) => CategoryCommodityPage(),
        UIDef.collectionStore: (context) => CollectionStorePage(),
        UIDef.myOrders: (context) => MyOrdersPage(),
        UIDef.payment: (context) => PaymentPage(),
        UIDef.prepaymentOrderDetail: (context) => PrepaymentOrderDetailPage(),
        UIDef.paymentFailure: (context) => PaymentFailurePage(),
        UIDef.paymentSuccess: (context) => PaymentSuccessPage(),
        UIDef.footprint: (context) => FootprintPage(),
        UIDef.userBalance: (context) => UserBalancePage(),
        UIDef.suggestionFeedback: (context) => SuggestionFeedbackPage(),
        UIDef.changeDetail: (context) => ChangeDetailPage(),
        UIDef.withdrawal: (context) => WithdrawalPage(),
UIDef.messageCenter: (context) => MessageCenterPage(),
        
      };

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider.value(value: ThemeModel()),
          ChangeNotifierProvider.value(value: LocaleModel()),
          ChangeNotifierProvider.value(value: LocationModel()),
        ],
        child: Consumer3<ThemeModel, LocaleModel, LocationModel>(builder:
            (BuildContext context, themeModel, localeModel, locationModel,
                Widget child) {
          return MaterialApp(
              routes: routes,
              theme: ThemeData(
                primarySwatch: themeModel.theme,
              ),
              onGenerateTitle: (context) {
                return AppLocalizations.of(context).title;
              },
              home:LoginPage(), //PrepaymentOrderDetailPage(),//PrepaymentOrderDetailPage(),
              //LoginPage(), // CitySearchListView(), //LoginPage(), // DeliveryAddressListPage(),//  ThemeChangeRoute(),//LoginPage(), //应用主页
              locale: localeModel.getLocale(),
              //我们只支持美国英语和中文简体
              supportedLocales: [
                const Locale.fromSubtags(
                    languageCode: 'zh',
                    scriptCode: 'Hans',
                    countryCode: 'CN'), // 中文简体
                const Locale('en', 'US'), // 美国英语
                //其它Locales
              ],
              localizationsDelegates: [
                // 本地化的代理类
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                AppLocalizationsDelegate()
              ],
              localeResolutionCallback:
                  (Locale _locale, Iterable<Locale> supportedLocales) {
                //如果已经选定语言，则不跟随系统

                //APP语言跟随系统语言，如果系统语言不是中文简体或美国英语，
                //则默认使用美国英语

                return (localeModel.getLocale() != null)
                    ? localeModel.getLocale()
                    : supportedLocales.contains(_locale)
                        ? _locale
                        : Locale('en', 'US');
              });
        }));
  }
}
