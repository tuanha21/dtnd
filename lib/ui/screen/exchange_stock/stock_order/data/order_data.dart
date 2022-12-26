import 'package:dtnd/=models=/exchange.dart';
import 'package:dtnd/=models=/side.dart';
import 'package:dtnd/utilities/string_util.dart';

class OrderData {
  OrderData({
    required this.orderType,
    required this.volumn,
    required this.price,
    required this.side,
  });
  final String price;
  final num volumn;
  final OrderType orderType;
  final Side side;

  num? get exchangeTotal {
    if (price.isNum) {
      return num.parse(price) * volumn * 1000;
    }
    return null;
  }
}
