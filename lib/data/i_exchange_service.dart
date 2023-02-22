import 'package:dtnd/=models=/response/account/i_account.dart';
import 'package:dtnd/=models=/response/account/unexecuted_right_model.dart';
import 'package:dtnd/=models=/response/order_model/base_order_model.dart';
import 'package:dtnd/=models=/response/stock_cash_balance_model.dart';
import 'package:dtnd/=models=/side.dart';
import 'package:dtnd/ui/screen/exchange_stock/stock_order/data/order_data.dart';

import 'i_user_service.dart';

abstract class IExchangeService {
  Future<BaseOrderModel?> createNewOrder(
      IUserService userService, OrderData orderData);

  Future<StockCashBalanceModel> getSCashBalance(
      {required String stockCode, required String price, required Side side});

  Future<void> registerRight(
      {required IAccountModel accountModel,
      required UnexecutedRightModel right,
      required String volumn,
      required String pin});
}
