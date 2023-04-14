import 'package:dtnd/=models=/side.dart';

import '../../../../=models=/response/order_model/i_order_model.dart';

class OrderHistory {
  final String stockCode;
  final Side side;
  final OrderStatus orderStatus;
  final num price;
  final String margin = "100%";
  final String orderPrice = "MP";
  final String matchedPrice = "17.85";
  final String matchedVol = "100/100";

  OrderHistory({
    required this.stockCode,
    required this.side,
    required this.orderStatus,
    required this.price,
  });
}
