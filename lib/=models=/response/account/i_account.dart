import 'package:dtnd/=models=/core_response_model.dart';
import 'package:dtnd/=models=/response/account/base_margin_account_model.dart';
import 'package:dtnd/=models=/response/account/base_normal_account_model.dart';

import 'portfolio_status_model.dart';

abstract class IAccountModel implements CoreResponseModel {
  late final String accCode;
  PortfolioStatus? portfolioStatus;
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

abstract class IAccountResponse implements CoreResponseModel {
  late final Map<String, dynamic> json;

  factory IAccountResponse.fromJson(Map<String, dynamic> json) {
    final lastChar = json["group"];
    switch (lastChar) {
      case "MARGIN":
        return BaseMarginAccountResponse.fromJson(json);
      default:
        return BaseNormalAccountResponse.fromJson(json);
    }
  }
}
