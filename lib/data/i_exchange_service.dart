import 'package:dtnd/=models=/response/account/i_account.dart';
import 'package:dtnd/=models=/response/account/unexecuted_right_model.dart';
import 'package:dtnd/=models=/response/order_history_model.dart';
import 'package:dtnd/=models=/response/order_model/base_order_model.dart';
import 'package:dtnd/=models=/response/order_model/change_order_model.dart';
import 'package:dtnd/=models=/response/stock_cash_balance_model.dart';
import 'package:dtnd/=models=/side.dart';
import 'package:dtnd/ui/screen/exchange_stock/stock_order/data/order_data.dart';

import 'i_user_service.dart';

abstract class IExchangeService {
  Future<BaseOrderModel?> createNewOrder(
      IUserService userService, OrderData orderData);
  Future<ChangeOrderModel?> changeOrder(IUserService userService,
      BaseOrderModel baseOrderModel, num vol, String price, String pin);
  Future<ChangeOrderModel?> cancelOrder(
      IUserService userService, BaseOrderModel baseOrderModel, String pin);

  Future<List<OrderHistoryModel>> getOrdersHistory(IUserService userService,
      {String stockCode,
      DateTime? fromDay,
      DateTime? toDay,
      String? status,
      int? page,
      int? recordPerPage});

  Future<StockCashBalanceModel> getSCashBalance(
      {required String stockCode, required String price, required Side side});

  Future<void> registerRight(
      {required IAccountModel accountModel,
      required UnexecutedRightModel right,
      required String volumn,
      required String pin});
}
