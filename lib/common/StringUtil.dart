class StringUtil{
      ///订单状态 1 待付款 2 待发货 3 待收货 4 待评价 5 交易成功 6 交易关闭
  // ignore: non_constant_identifier_names
  static String OrderStateToString(int state){

    String stateStr = "未知状态";

    switch (state) {
      case 1:
        stateStr = '待付款';
        break;
         case 2:
        stateStr = '待发货';
        break;
         case 3:
        stateStr = '待收货';
        break;
         case 4:
        stateStr = '待评价';
        break;
         case 5:
        stateStr = '交易成功';
         break;
           case 6:
        stateStr = '交易关闭';
        break;
      default:
    }

    return stateStr;
  }

}