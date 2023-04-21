import 'package:dtnd/=models=/core_response_model.dart';
import 'package:dtnd/=models=/request/request_model.dart';
import 'package:dtnd/=models=/response/account/unexecuted_right_model.dart';
import 'package:dtnd/data/i_network_service.dart';
import 'package:dtnd/data/i_user_service.dart';
import 'package:dtnd/utilities/logger.dart';
import 'package:dtnd/utilities/time_utils.dart';
import 'package:get/get.dart';

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

  IAccountModel({required this.accCode});

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

  void updateDataFromJson(IAccountResponse? jsonData);

  Future<void> getAccountStatus(
      IUserService userService, INetworkService networkService) async {
    final RequestModel requestModel = RequestModel(userService,
        group: "Q",
        data: RequestDataModel.stringType(
          cmd: "Web.Portfolio.AccountStatus",
          p1: accCode,
        ));

    final jsonData =
        await networkService.requestTraditionalApi<IAccountResponse>(
      requestModel,
      modifyResponse: (res) {
        return res;
      },
    );
    return updateDataFromJson(jsonData);
  }

  Future<void> getPortfolioStatus(
      IUserService userService, INetworkService networkService) async {
    final RequestModel requestModel = RequestModel(userService,
        group: "Q",
        data: RequestDataModel.stringType(
          cmd: "Web.Portfolio.PortfolioStatus",
          p1: accCode,
        ));
    final response = await networkService
        .requestTraditionalApiResList<PorfolioStock>(requestModel);
    if (response != null) {
      portfolioStatus = PortfolioStatus.fromPorfolioStock(response);
    }
    return;
  }

  Future<List<AssetChartElementModel>?> getListAssetChart(
    IUserService userService,
    INetworkService networkService, {
    DateTime? fromTime,
    DateTime? toTime,
  }) async {
    final requestModel = RequestModel(
      userService,
      group: "B",
      data: RequestDataModel.cursorType(
          cmd: "ListAssetChart",
          p1: accCode,
          p2: TimeUtilities.commonTimeFormat.format(fromTime ??
              TimeUtilities.getPreviousDateTime(TimeUtilities.month(3))),
          p3: TimeUtilities.commonTimeFormat.format(toTime ?? DateTime.now())),
    );
    listAssetChart = await networkService
        .requestTraditionalApiResList<AssetChartElementModel>(requestModel);
    return listAssetChart;
  }

  Future<List<UnexecutedRightModel>> getListUnexecutedRight(
      IUserService userService, INetworkService networkService) async {
    final requestModel = RequestModel(
      userService,
      group: "B",
      data: RequestDataModel.cursorType(
        cmd: "ListRightUnExec",
        p1: accCode,
      ),
    );
    final res =
        await networkService.requestTraditionalApiResList<UnexecutedRightModel>(
      requestModel,
      hasError: (p0) {
        if (p0["data"].runtimeType is List && p0["data"].isNotEmpty) {
          return p0["data"].first["DUMMY"] != null;
        }
        return false;
      },
    );
    listUnexecutedRight = res ?? [];
    return res ?? [];
  }

  Future<void> refreshAsset(
      IUserService userService, INetworkService networkService) async {
    await getAccountStatus(userService, networkService);
    await getPortfolioStatus(userService, networkService);
    return;
  }
}

class IAccountResponse implements CoreResponseModel {
  late final Map<String, dynamic> json;

  IAccountResponse.fromJson(this.json);
}
