import 'package:dtnd/=models=/request/request_model.dart';
import 'package:dtnd/=models=/response/account_info_model.dart';
import 'package:dtnd/=models=/response/user_token.dart';
import 'package:dtnd/data/i_local_storage_service.dart';
import 'package:dtnd/data/i_network_service.dart';
import 'package:dtnd/data/i_user_service.dart';
import 'package:dtnd/data/implementations/local_storage_service.dart';
import 'package:dtnd/data/implementations/network_service.dart';

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
    return;
  }

  @override
  Future<bool> saveToken(UserToken token) async {
    try {
      userToken = token;
      await localStorageService.saveUserToken(token);
      await getUserInfo();
      return true;
    } catch (e) {
      return false;
    }
  }

  @override
  bool get isLogin => userToken != null;

  @override
  UserToken? get token => userToken;

  @override
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
}
