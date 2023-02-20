import 'package:dtnd/=models=/response/account/asset_chart_element.dart';
import 'package:dtnd/=models=/response/account/i_account.dart';
import 'package:dtnd/=models=/response/account/list_account_model.dart';

import 'response/account/portfolio_status_model.dart';
import 'response/account/unexecuted_right_model.dart';
import 'response/order_model/base_order_model.dart';
import 'response/stock_info_core.dart';

abstract class CoreResponseModel {
  static T fromJson<T extends CoreResponseModel>(Map<String, dynamic> json) {
    switch (T) {
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
      default:
        throw UnimplementedError();
    }
  }
}
