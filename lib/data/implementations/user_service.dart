import 'package:dtnd/=models=/request/request_model.dart';
import 'package:dtnd/=models=/response/account_info_model.dart';
import 'package:dtnd/=models=/response/total_asset_model.dart';
import 'package:dtnd/=models=/response/user_token.dart';
import 'package:dtnd/data/i_local_storage_service.dart';
import 'package:dtnd/data/i_network_service.dart';
import 'package:dtnd/data/i_user_service.dart';
import 'package:dtnd/data/implementations/local_storage_service.dart';
import 'package:dtnd/data/implementations/network_service.dart';
import 'package:dtnd/utilities/logger.dart';

class UserService implements IUserService {
  final ILocalStorageService localStorageService = LocalStorageService();
  final INetworkService networkService = NetworkService();
  UserService._internal();

  static final UserService _instance = UserService._internal();

  factory UserService() => _instance;

  UserToken? userToken;
  @override
  UserInfo? userInfo;

  @override
  TotalAsset? totalAsset;

  @override
  List<String> searchHistory = [];

  @override
  bool regSmartOTP = false;

  @override
  void changeRegSmartOTP(bool value) {
    regSmartOTP = value;
  }

  @override
  Future<void> init() {
    throw UnimplementedError();
  }

  @override
  Future<void> deleteToken() async {
    userToken = null;
    userInfo = null;
    totalAsset = null;
    searchHistory = [];
    return;
  }

  @override
  Future<bool> saveToken(UserToken token) async {
    try {
      userToken = token;
      await localStorageService.saveUserToken(token);
      getUserInfo();
      getTotalAsset();
      getSearchHistory();
      return true;
    } catch (e) {
      return false;
    }
  }

  @override
  bool get isLogin => userToken != null;

  @override
  UserToken? get token => userToken;

  Future<UserInfo?> getUserInfo() async {
    if (!isLogin) {
      return null;
    }

    final RequestModel requestModel = RequestModel(this,
        group: "B",
        data: RequestDataModel.cursorType(
          cmd: "GetAccountInfo",
          p1: userToken!.user,
        ));
    userInfo = await networkService.getUserInfo(requestModel);
    return userInfo;
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
    totalAsset = await networkService.getTotalAsset(requestModel);
    logger.v(totalAsset!.toJson());
    return totalAsset;
  }

  @override
  Future<List<String>> getSearchHistory() async {
    if (!isLogin) {
      return [];
    }
    final body = '{"account":"${userToken!.user}"}';

    searchHistory = await networkService.getSearchHistory(body);
    logger.v(searchHistory);
    return searchHistory;
  }

  @override
  void putSearchHistory(String searchString) {
    final Map<String, dynamic> body = {
      "account": userToken!.user,
      "textSearch": searchString,
    };
    networkService.putSearchHistory(body.toString());
    return;
  }
}
