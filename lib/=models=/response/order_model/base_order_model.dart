import 'package:dtnd/=models=/core_response_model.dart';
import 'package:dtnd/=models=/response/order_model/i_order_model.dart';
import 'package:dtnd/utilities/logger.dart';
import 'package:intl/intl.dart';

class BaseOrderModel extends CoreResponseModel implements IOrderModel {
  @override
  late final String id;

  @override
  late final String orderAccount;

  @override
  late final OrderStatus orderStatus;

  @override
  late final DateTime orderTime;

  @override
  late final String symbol;

  num? orderNo;
  String? side;
  String? volume;
  String? showPrice;
  String? orderPrice;
  num? matchVolume;
  String? status;
  String? channel;
  String? group;
  String? cancelTime;
  String? info;
  String? maxPrice;
  String? matchValue;
  String? quote;
  String? autoType;
  String? product;
  String? condition;
  String? result;
  String? activeTime;
  String? sendTime;

  BaseOrderModel.fromJson(Map<String, dynamic> json) {
    logger.v(json);
    try {
      orderNo = json['orderNo'];
      id = json['pk_orderNo'];
      orderTime = DateFormat("HH:mm:ss").parseStrict(json['orderTime']);
      orderAccount = json['accountCode'];
      side = json['side'];
      symbol = json['symbol'];
      volume = json['volume'];
      showPrice = json['showPrice'];
      orderPrice = json['orderPrice'];
      matchVolume = json['matchVolume'];
      status = json['status'];
      channel = json['channel'];
      group = json['group'];
      cancelTime = json['cancelTime'];
      info = json['info'];
      maxPrice = json['maxPrice'];
      matchValue = json['matchValue'];
      quote = json['quote'];
      autoType = json['autoType'];
      product = json['product'];
      condition = json['condition'];
      result = json['result'];
      activeTime = json['active_time'];
      sendTime = json['send_time'];
    } catch (e) {
      logger.e(e);
    }
  }
}
