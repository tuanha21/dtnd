import 'package:dtnd/=models=/response/new_order.dart';
import 'package:dtnd/=models=/response/s_cash_balance.dart';
import 'package:dtnd/=models=/side.dart';
import 'package:dtnd/ui/screen/exchange_stock/stock_order/data/order_data.dart';

abstract class IExchangeService {
  Future<NewOrderResponse?> createNewOrder(OrderData orderData);
  Future<SCashBalance> getSCashBalance(
      {required String stockCode, required String price, required Side side});
}
