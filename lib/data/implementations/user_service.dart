import 'package:dtnd/=models=/request/request_model.dart';
import 'package:dtnd/=models=/response/account/asset_chart_element.dart';
import 'package:dtnd/=models=/response/account/base_margin_account_model.dart';
import 'package:dtnd/=models=/response/account/i_account.dart';
import 'package:dtnd/=models=/response/account/portfolio_status_model.dart';
import 'package:dtnd/=models=/response/account/unexecuted_right_model.dart';
import 'package:dtnd/=models=/response/account_info_model.dart';
import 'package:dtnd/=models=/response/order_model/base_order_model.dart';
import 'package:dtnd/=models=/response/total_asset_model.dart';
import 'package:dtnd/=models=/response/user_token.dart';
import 'package:dtnd/=models=/side.dart';
import 'package:dtnd/data/i_local_storage_service.dart';
import 'package:dtnd/data/i_network_service.dart';
import 'package:dtnd/data/i_user_service.dart';
import 'package:dtnd/data/implementations/local_storage_service.dart';
import 'package:dtnd/data/implementations/network_service.dart';
import 'package:dtnd/utilities/logger.dart';
import 'package:dtnd/utilities/time_utils.dart';
import 'package:get/get.dart';

class UserService implements IUserService {
  final ILocalStorageService localStorageService = LocalStorageService();
  final INetworkService networkService = NetworkService();
  UserService._internal();

  static final UserService _instance = UserService._internal();

  factory UserService() => _instance;

  @override
  final Rx<UserToken?> token = Rxn();

  final Rx<String?> _currentPassword = Rxn();
  @override
  final Rx<UserInfo?> userInfo = Rxn();

  @override
  final Rx<TotalAsset?> totalAsset = Rxn();

  @override
  Rx<List<IAccountModel>?> listAccountModel = Rxn();

  @override
  List<String> searchHistory = [];

  @override
  bool regSmartOTP = false;

  @override
  bool regVA = false;

  @override
  void changeRegSmartOTP(bool value) {
    regSmartOTP = value;
  }

  @override
  void changeRegVA(bool value) {
    regVA = value;
  }

  @override
  Future<void> init() {
    throw UnimplementedError();
  }

  @override
  Future<void> deleteToken() async {
    token.value = null;
    userInfo.value = null;
    totalAsset.value = null;
    searchHistory = [];
    return;
  }

  @override
  Future<bool> saveToken(UserToken userToken, String password) async {
    try {
      token.value = userToken;
      _currentPassword.value = password;
      await localStorageService.saveUserToken(userToken, password);
      getUserInfo();
      getListAccount();
      getTotalAsset();
      getSearchHistory();
      return true;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<void> refreshAssets() {
    return getListAccount();
  }

  @override
  bool get isLogin => token.value != null;

  @override
  Future<List<BaseOrderModel>?> getIndayOrder(
      {int? page,
      int? recordPerPage,
      String? accountCode,
      String? symbol,
      int? status,
      Side? side}) {
    final RequestModel requestModel = RequestModel(
      this,
      group: "Q",
      data: RequestDataModel.stringType(
        cmd: "Web.Order.IndayOrder2",
        p1: "${page ?? 1}",
        p2: "${recordPerPage ?? 10}",
        p3: accountCode ?? "ALL",
        p4: [
          symbol ?? "ALL",
          status?.toString() ?? "ALL",
          side?.code ?? "ALL",
        ].join(","),
      ),
    );
    return networkService
        .requestTraditionalApiResList<BaseOrderModel>(requestModel);
  }

  Future<List<IAccountModel>?> getListAccount() async {
    RequestModel requestModel = RequestModel(this,
        group: "B",
        data: RequestDataModel.cursorType(
          cmd: "ListAccount",
        ));
    final listAccount = await networkService
        .requestTraditionalApiResList<IAccountModel>(requestModel);
    if (listAccount?.isEmpty ?? true) {
      return [];
    } else {
      listAccountModel.value = listAccount;
      for (var i = 0; i < listAccount!.length; i++) {
        requestModel = RequestModel(this,
            group: "Q",
            data: RequestDataModel.stringType(
              cmd: "Web.Portfolio.AccountStatus",
              p1: listAccount.elementAt(i).accCode,
            ));
        dynamic response = await networkService
            .requestTraditionalApi<IAccountResponse>(requestModel);

        listAccount.elementAt(i).updateDataFromJson(response!);
        requestModel = RequestModel(this,
            group: "Q",
            data: RequestDataModel.stringType(
              cmd: "Web.Portfolio.PortfolioStatus",
              p1: listAccount.elementAt(i).accCode,
            ));
        response = await networkService
            .requestTraditionalApiResList<PorfolioStock>(requestModel);
        if (response != null) {
          listAccount.elementAt(i).portfolioStatus =
              PortfolioStatus.fromPorfolioStock(response!);
        }
        response = await getListAssetChart(listAccount.elementAt(i).accCode);
        if (response != null) {
          listAccount.elementAt(i).listAssetChart = response;
        }

        response =
            await getListUnexecutedRight(listAccount.elementAt(i).accCode);
        if (listAccount.elementAt(i) is BaseMarginAccountModel &&
            response != null) {
          (listAccount.elementAt(i) as BaseMarginAccountModel)
              .listUnexecutedRight = response;
        }
      }
    }
    listAccountModel.refresh();
    return listAccountModel.value;
  }

  Future<List<AssetChartElementModel>?> getListAssetChart(String account,
      {DateTime? fromTime, DateTime? toTime}) {
    final requestModel = RequestModel(
      this,
      group: "B",
      data: RequestDataModel.cursorType(
          cmd: "ListAssetChart",
          p1: account,
          p2: TimeUtilities.commonTimeFormat.format(fromTime ??
              TimeUtilities.getPreviousDateTime(TimeUtilities.month(3))),
          p3: TimeUtilities.commonTimeFormat.format(toTime ?? DateTime.now())),
    );
    return networkService
        .requestTraditionalApiResList<AssetChartElementModel>(requestModel);
  }

  Future<List<UnexecutedRightModel>?> getListUnexecutedRight(String account) {
    final requestModel = RequestModel(
      this,
      group: "B",
      data: RequestDataModel.cursorType(
        cmd: "ListRightUnExec",
        p1: account,
      ),
    );
    return networkService
        .requestTraditionalApiResList<UnexecutedRightModel>(requestModel);
  }

  Future<UserInfo?> getUserInfo() async {
    if (!isLogin) {
      return null;
    }

    final RequestModel requestModel = RequestModel(this,
        group: "B",
        data: RequestDataModel.cursorType(
          cmd: "GetAccountInfo",
          p1: token.value!.user,
        ));
    final listResponse = await networkService
        .requestTraditionalApiResList<UserInfo>(requestModel);
    userInfo.value = listResponse?.first;
    return userInfo.value;
  }

  Future<TotalAsset?> getTotalAsset() async {
    if (!isLogin) {
      return null;
    }

    final RequestModel requestModel = RequestModel(this,
        group: "SU",
        data: RequestDataModel(
          cmd: "TotalAsset",
        ));
    totalAsset.value = await networkService.getTotalAsset(requestModel);
    logger.v(totalAsset.value!.toJson());
    return totalAsset.value;
  }

  @override
  Future<List<String>> getSearchHistory() async {
    if (!isLogin) {
      return [];
    }
    final body = '{"account":"${token.value!.user}"}';

    searchHistory = await networkService.getSearchHistory(body);
    logger.v(searchHistory);
    return searchHistory;
  }

  @override
  void putSearchHistory(String searchString) {
    final Map<String, dynamic> body = {
      "account": token.value!.user,
      "textSearch": searchString,
    };
    networkService.putSearchHistory(body.toString());
    return;
  }
}
