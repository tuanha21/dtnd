import 'package:dtnd/=models=/core_response_model.dart';
import 'package:dtnd/=models=/response/account/unexecuted_right_model.dart';
import 'package:dtnd/utilities/logger.dart';

import 'asset_chart_element.dart';
import 'base_margin_account_model.dart';
import 'base_margin_plus_account_model.dart';
import 'base_normal_account_model.dart';
import 'portfolio_status_model.dart';

abstract class IAccountModel implements CoreResponseModel {
  late final String accCode;
  PortfolioStatus? portfolioStatus;
  List<AssetChartElementModel>? listAssetChart;
  List<UnexecutedRightModel>? listUnexecutedRight;
  factory IAccountModel.fromJson(Map<String, dynamic> json) {
    logger.v(json);
    final lastChar = (json["accCode"] as String)[json["accCode"].length - 1];
    switch (lastChar) {
      case "6":
        return BaseMarginAccountModel.fromJson(json);
      case "9":
        return BaseMarginPlusAccountModel.fromJson(json);
      default:
        return BaseNormalAccountModel.fromJson(json);
    }
  }

  void updateDataFromJson(IAccountResponse jsonData);

  // void reloadPortfolio();
}

class IAccountResponse implements CoreResponseModel {
  late final Map<String, dynamic> json;

  IAccountResponse.fromJson(this.json);
}
