import 'package:json_annotation/json_annotation.dart';

//flutter packages pub run build_runner build

part 'WechatPayment.g.dart';

@JsonSerializable()
class WechatPayment{

/*
{"prepay_id":"wx281758329785030b852c8c484601af0000",
"appid":"wx0e11318ad04738ab",
"timestamp":"1611827912",
"noncestr":"QQGY818RASW0WKD39FIUJ891T6IT76RQ",
"paySign":"kq/WNtb8S+eo7c3664MvKrvqIrdN2zQHXkP7x3on7ria38ZIRIFxjQ8fA8YcAtAcNuoLjKZsjnTD+WwqfIbM2vy+AuNOhOy/tkSoSELIEu1As18C35/nRc96x9xBT83FnTFR3TFF0wBE1lGVoXpFGz7/1j7z/ZgZt9aHH8x/3UlAvXwkXQ2AZnOzLCbZ6DpVM7UojdlnXmrWcUWgO1SeUdeGTHbF0mKAKdvQbU9f6SyuSIROuN6Y93Vm54E0oK9vhLCoivkr3gFkjgqAdJgM1gsLsT98XTxEvooigUMx+sL4t3c+lfVPvlLg8+55K3m4JFUjT/1rS0suoaLUYDZBrw==",
"partnerid":"1604980422","package":"Sign=WXPay"}
 */

// ignore: non_constant_identifier_names
String prepay_id;
String appid;
String timestamp;
String noncestr;
String paySign;
String partnerid;
String package;

  WechatPayment();
  factory WechatPayment.fromJson(Map<String, dynamic> json) => _$WechatPaymentFromJson(json);
  Map<String, dynamic> toJson() => _$WechatPaymentToJson(this);

}