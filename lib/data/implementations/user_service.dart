import 'dart:convert';

import 'package:dtnd/=models=/check_account_success_data_model.dart';
import 'package:dtnd/=models=/local/va_portfolio_model.dart';
import 'package:dtnd/=models=/request/request_model.dart';
import 'package:dtnd/=models=/response/account/base_margin_plus_account_model.dart';
import 'package:dtnd/=models=/response/account/i_account.dart';
import 'package:dtnd/=models=/response/account_info_model.dart';
import 'package:dtnd/=models=/response/accumulation/contract_model.dart';
import 'package:dtnd/=models=/response/accumulation/fee_rate_model.dart';
import 'package:dtnd/=models=/response/order_model/base_order_model.dart';
import 'package:dtnd/=models=/response/total_asset_model.dart';
import 'package:dtnd/=models=/response/user_token.dart';
import 'package:dtnd/=models=/side.dart';
import 'package:dtnd/=models=/sign_up_success_data_model.dart';
import 'package:dtnd/=models=/ui_model/exception.dart';
import 'package:dtnd/data/i_local_storage_service.dart';
import 'package:dtnd/data/i_network_service.dart';
import 'package:dtnd/data/i_user_service.dart';
import 'package:dtnd/data/implementations/local_storage_service.dart';
import 'package:dtnd/data/implementations/network_service.dart';
import 'package:dtnd/utilities/logger.dart';
import 'package:get/get.dart';

class UserService implements IUserService {
  final ILocalStorageService localStorageService = LocalStorageService();
  final INetworkService networkService = NetworkService();

  UserService._internal();

  static final UserService _instance = UserService._internal();

  factory UserService() => _instance;

  @override
  final Rx<UserToken?> token = Rxn();

  @override
  final Rx<bool> isRegisterVa = Rx<bool>(false);

  final Rx<String?> _currentPassword = Rxn();
  @override
  final Rx<UserInfo?> userInfo = Rxn();

  @override
  final Rx<TotalAsset?> totalAsset = Rxn();
  @override
  Rx<IAccountModel?> defaultAccount = Rxn();

  @override
  Rx<List<IAccountModel>?> listAccountModel = Rxn();

  final Rx<VAPortfolio?> _vaPortfolio = Rxn();

  @override
  List<String> searchHistory = [];

  @override
  VAPortfolio? get vaPortfolio => _vaPortfolio.value;

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
    isRegisterVa.value = false;
    _vaPortfolio.value = null;
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
      localStorageService.sharedPreferences.remove('pinCode');
      // getSearchHistory();
      return true;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<void> refreshAssets() {
    getTotalAsset();
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
    final listAccount =
        await networkService.requestTraditionalApiResList<IAccountModel>(
      requestModel,
      hasError: (p0) {
        logger.v(p0);
        return false;
      },
    );
    logger.v(listAccount.toString());

    if (listAccount?.isEmpty ?? true) {
      return [];
    } else {
      listAccountModel.value = listAccount;
      logger.v(listAccount);
      for (var i = 0; i < listAccount!.length; i++) {
        await listAccount.elementAt(i).refreshAsset(this, networkService);
        await listAccount.elementAt(i).getListAssetChart(this, networkService);
        await listAccount
            .elementAt(i)
            .getListUnexecutedRight(this, networkService);
        await listAccount.elementAt(i).getListRightBuy(this, networkService);
        await listAccount.elementAt(i).getListHistoryBuy(this, networkService);
        if (listAccount.elementAt(i) is BaseMarginPlusAccountModel) {
          defaultAccount.value = listAccount.elementAt(i);
        }
      }
    }
    listAccountModel.refresh();
    return listAccountModel.value;
  }

  Future<UserInfo?> getUserInfo() async {
    if (!isLogin) {
      return null;
    }

    try {
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
    } catch (e) {
      logger.e(e.toString());
      return null;
    }
  }

  Future<TotalAsset?> getTotalAsset() async {
    if (!isLogin) {
      return null;
    }

    final RequestModel requestModel = RequestModel(this,
        group: "SU",
        data: RequestDataModel(
          type: null,
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
    return searchHistory;
  }

  @override
  Future<List<String>> getTopSearch() async {
    if (!isLogin) {
      return [];
    }
    final Map<String, String> body = {
      "account": token.value!.user,
      "sid": token.value!.sid
    };
    logger.v(jsonEncode(body));
    final listStrings = await networkService.getTopSearch(jsonEncode(body));

    return listStrings;
  }

  @override
  void putSearchHistory(String searchString) {
    if (!isLogin) {
      return;
    }
    final Map<String, String> body = {
      "account": token.value!.user,
      "textSearch": searchString,
    };
    networkService.putSearchHistory(jsonEncode(body));
    return;
  }

  // Register session

  @override
  Future<bool> verifyRegisterInfo(String mobile, String mail) async {
    final Map<String, dynamic> body = {
      "user": "back",
      "cmd": "CHECK_OPENACC",
      "param": {"C_MOBILE": mobile, "C_EMAIL": mail}
    };
    try {
      final result = await networkService.verifySignupInfo(jsonEncode(body));
      return result;
    } on Map<String, dynamic> catch (res) {
      throw res['sRs'];
    } catch (e) {
      logger.e(e);
      throw e.runtimeType.toString();
    }
  }

  @override
  Future<bool> verifyRegisterOTP(String mobile, String mail, String otp) {
    Map<String, String> body = {"email": mail, "phone": mobile, "otp": otp};
    return networkService.verifySignupOTP(jsonEncode(body));
  }

  @override
  Future<SignUpSuccessDataModel?> createAccount(
      String name, String mobile, String mail, String pass) {
    Map<String, dynamic> body = {
      "user": "back",
      "cmd": "OPEN_VIRTUAL_ACCOUNT",
      "sid": "",
      "param": {
        "CUSTOMER_NAME": name,
        "CUSTOMER_MOBILE": mobile,
        "CUSTOMER_EMAIL": mail,
        "CUSTOMER_PASS": pass,
      }
    };
    return networkService.createAccount(jsonEncode(body));
  }

  //check account info
  @override
  Future<CheckAccountSuccessDataModel?> checkAccountInfo(String mail) {
    Map<String, dynamic> body = {
      "user": "back",
      "cmd": "CHECK_ACCOUNT_INFO",
      "sid": "",
      "param": {
        "CUST_EMAIL": mail,
      }
    };

    return networkService.checkAccountInfo(jsonEncode(body));
  }

  @override
  Future<bool> resetPassword(
      String id, String phone, String mail, String password) {
    Map<String, dynamic> body = {
      "user": "back",
      "cmd": "RESET_ACCOUNT_PASS",
      "sid": "",
      "param": {
        "USER_ID": id,
        "CUST_MOBILE": phone,
        "CUST_EMAIL": mail,
        "CUST_PASSWORD": password
      }
    };
    return networkService.resetPassword(jsonEncode(body));
  }

  // VA
  @override
  Future<VAPortfolio> getVAPortfolio() async {
    if (!isLogin) {
      throw const BotNotExistedException();
    }
    final Map<String, String> body = {
      "account": token.value!.user,
      "session": token.value!.sid,
    };
    try {
      _vaPortfolio.value =
          await networkService.getVAPortfolio(jsonEncode(body));
    } catch (e) {
      _vaPortfolio.value = await getLocalVAPortfolio();
    }
    logger.v(vaPortfolio.toString());
    return vaPortfolio!;
  }

  Future<VAPortfolio> getLocalVAPortfolio() async {
    final VAPortfolio portfolio;
    try {
      portfolio = localStorageService.getSavedVAPortfolio(token.value!.user);
    } on BoxNotOpenedException catch (_) {
      await localStorageService.openSavedVAPortfolioBox();
      return getLocalVAPortfolio();
    } on BotNotExistedException catch (_) {
      final VAPortfolio newPortfolio =
          VAPortfolio(VAPortfolioSetting.defaultSetting());
      await localStorageService.putVAPortfolio(token.value!.user, newPortfolio);
      return getLocalVAPortfolio();
    }
    return portfolio;
  }

  @override
  Future<void> createBot() async {
    if (!isLogin) {
      return;
    }
    final Map<String, dynamic> body = {
      "account": token.value!.user,
      "session": token.value!.sid,
      "stocks": [
        for (VAPortfolioItem item in vaPortfolio!.listStocks) item.toJson()
      ]
    };
    return networkService.createBot(jsonEncode(body));
  }

  @override
  Future<void> destroyBot() async {
    if (!isLogin) {
      return;
    }
    final Map<String, dynamic> body = {
      "account": token.value!.user,
      "session": token.value!.sid,
    };

    return networkService.deleteBot(jsonEncode(body));
  }

  @override
  Future<void> saveValueRegisterVa() async {
    final Map<String, String> body = {
      "account": token.value?.user ?? '',
      "sid": token.value?.sid ?? '',
    };
    isRegisterVa.value = await networkService.checkInfoVa(jsonEncode(body));
    return;
  }

  @override
  Future<void> deleteAccount() async {
    final Map<String, dynamic> body = {
      "user": token.value?.user ?? '',
      "session": token.value?.sid ?? '',
      "group": "B",
      "data": {
        "type": "object",
        "cmd": "ClosedAccount",
        "p1": {
          "ACCOUNT_CODE": token.value?.defaultAcc ?? "",
        },
      },
    };
    try {
      await networkService.deleteAccount(jsonEncode(body));
      deleteToken();
      return;
    } on Map<String, dynamic> catch (res) {
      throw res['sRs'];
    } catch (e) {
      logger.e(e);
      throw e.runtimeType.toString();
    }
  }

  @override
  Future<List<FeeRateModel>?> getAllFreeRate() {
    Map<String, dynamic> body = {
      "group": "B",
      "user": token.value?.user ?? '',
      "session": token.value?.sid ?? '',
      "data": {"cmd": "MM_GetAllFeeRate", "type": "object", "p1": {}}
    };
    return networkService.getAllFreeRate(jsonEncode(body));
  }

  @override
  Future<bool> updateContract(String termCode, num capital, String extentType) {
    Map<String, dynamic> body = {
      "group": "B",
      "user": token.value?.user ?? '',
      "session": token.value?.sid ?? '',
      "data": {
        "cmd": "MM_UpdateContract",
        "type": "object",
        "p1": {
          "ACCOUNT_CODE": '${token.value?.user}9',
          "TERM": termCode,
          "CAPITAL": capital,
          "EXTENT_TYPE": extentType,
          "CHANNEL": "M",
          "CONTENT": ""
        }
      }
    };
    return networkService.updateContract(jsonEncode(body));
  }

  @override
  Future<List<ContractModel>?> getAllContract() {
    Map<String, dynamic> body = {
      "group": "B",
      "user": token.value?.user ?? '',
      "session": token.value?.sid ?? '',
      "data": {
        "cmd": "MM_GetAllContract",
        "type": "object",
        "p1": {
          "ACCOUNT_CODE": '${token.value?.user}9',
        }
      }
    };
    return networkService.getAllContract(jsonEncode(body));
  }
}
