import 'package:dtnd/=models=/response/account/asset_chart_element.dart';
import 'package:dtnd/=models=/response/account/i_account.dart';
import 'package:dtnd/=models=/response/account/portfolio_status_model.dart';

class UnknownAccountModel implements IAccountModel {
  @override
  String accCode = "";

  @override
  PortfolioStatus? portfolioStatus;

  @override
  List<AssetChartElementModel>? listAssetChart;

  UnknownAccountModel.fromJson(Map<String, dynamic> json) {
    throw UnimplementedError();
  }

  @override
  void updateData(IAccountResponse data) {}
}
