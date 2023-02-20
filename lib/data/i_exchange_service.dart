import 'package:dtnd/=models=/response/order_model/base_order_model.dart';
import 'package:dtnd/=models=/response/s_cash_balance.dart';
import 'package:dtnd/=models=/side.dart';
import 'package:dtnd/ui/screen/exchange_stock/stock_order/data/order_data.dart';

import 'i_user_service.dart';

abstract class IExchangeService {
  Future<BaseOrderModel?> createNewOrder(
      IUserService userService, OrderData orderData);
  Future<SCashBalance> getSCashBalance(IUserService userService,
      {required String stockCode, required String price, required Side side});
}
