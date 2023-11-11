import 'package:dtnd/=models=/exchange.dart';
import 'package:dtnd/=models=/response/market/stock_model.dart';
import 'package:dtnd/=models=/side.dart';
import 'package:dtnd/utilities/string_util.dart';

class OrderData {
  OrderData({
    required this.stockModel,
    required this.orderType,
    required this.volumn,
    required this.price,
    required this.side,
    this.pin,
  });
  final StockModel stockModel;
  final String price;
  final num volumn;
  final OrderType orderType;
  final Side side;
  final String? pin;

  OrderData copyWithPin(String pin) {
    return OrderData(
      stockModel: stockModel,
      orderType: orderType,
      volumn: volumn,
      price: price,
      side: side,
      pin: pin,
    );
  }

  num? get exchangeTotal {
    if (price.isNum) {
      return num.parse(price) * volumn * 1000;
    }
    return null;
  }
}
