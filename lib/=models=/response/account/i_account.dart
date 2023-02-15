import 'package:dtnd/=models=/core_response_model.dart';

import 'asset_chart_element.dart';
import 'base_margin_account_model.dart';
import 'base_normal_account_model.dart';
import 'portfolio_status_model.dart';

abstract class IAccountModel implements CoreResponseModel {
  late final String accCode;
  PortfolioStatus? portfolioStatus;
  List<AssetChartElementModel>? listAssetChart;
  factory IAccountModel.fromJson(Map<String, dynamic> json) {
    final lastChar = (json["accCode"] as String)[json["accCode"].length - 1];
    switch (lastChar) {
      case "6":
        return BaseMarginAccountModel.fromJson(json);
      default:
        return BaseNormalAccountModel.fromJson(json);
    }
  }

  void updateData(IAccountResponse data);
}

class IAccountResponse implements CoreResponseModel {
  late final Map<String, dynamic> json;

  IAccountResponse.fromJson(this.json);
}
