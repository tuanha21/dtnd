import 'package:dtnd/=models=/response/account/asset_chart_element.dart';
import 'package:dtnd/=models=/response/account/i_account.dart';
import 'package:dtnd/=models=/response/account/list_account_model.dart';

import 'response/account/portfolio_status_model.dart';
import 'response/account/unexecuted_right_model.dart';
import 'response/account_info_model.dart';
import 'response/cash_transaction_model.dart';
import 'response/order_history_model.dart';
import 'response/order_model/base_order_model.dart';
import 'response/order_model/change_order_model.dart';
import 'response/share_earned_model.dart';
import 'response/share_transaction_model.dart';
import 'response/stock_cash_balance_model.dart';
import 'response/stock_info_core.dart';
import 'response/user_token.dart';

abstract class CoreResponseModel {
  static T? fromJson<T extends CoreResponseModel>(Map<String, dynamic> json) {
    switch (T) {
      case UserToken:
        return UserToken.fromJson(json) as T;
      case IAccountModel:
        return IAccountModel.fromJson(json) as T;
      case ListAccountModel:
        return ListAccountModel.fromJson(json) as T;
      case IAccountResponse:
        return IAccountResponse.fromJson(json) as T;
      case PorfolioStock:
        return PorfolioStock.fromJson(json) as T;
      case AssetChartElementModel:
        return AssetChartElementModel.fromJson(json) as T;
      case UnexecutedRightModel:
        return UnexecutedRightModel.fromJson(json) as T;
      case BaseOrderModel:
        return BaseOrderModel.fromJson(json) as T;
      case StockInfoCore:
        return StockInfoCore.fromJson(json) as T;
      case UserInfo:
        return UserInfo.fromJson(json) as T;
      case ShareEarnedDetailModel:
        return ShareEarnedDetailModel.fromJson(json) as T;
      case StockCashBalanceModel:
        return StockCashBalanceModel.fromJson(json) as T;
      case OrderHistoryModel:
        return OrderHistoryModel.fromJson(json) as T;
      case ChangeOrderModel:
        return ChangeOrderModel.fromJson(json) as T;
      case CashTransactionHistoryModel:
        return CashTransactionHistoryModel.fromJson(json) as T;
      case ShareTransactionModel:
        return ShareTransactionModel.fromJson(json) as T;
      default:
        return null;
    }
  }
}
