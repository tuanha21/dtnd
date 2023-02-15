import 'package:dtnd/=models=/response/account/asset_chart_element.dart';
import 'package:dtnd/=models=/response/account/i_account.dart';
import 'package:dtnd/=models=/response/account/list_account_model.dart';

import 'response/account/portfolio_status_model.dart';

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
      default:
        throw UnimplementedError();
    }
  }
}
