import 'package:dtnd/=models=/response/account/i_account.dart';
import 'package:dtnd/=models=/response/account_info_model.dart';
import 'package:dtnd/=models=/response/total_asset_model.dart';
import 'package:dtnd/=models=/response/user_token.dart';
import 'package:get/get.dart';

abstract class IUserService {
  bool get isLogin;

  Rx<UserToken?> get token;

  Rx<UserInfo?> get userInfo;

  Rx<TotalAsset?> get totalAsset;

  Rx<List<IAccountModel>?> get listAccountModel;

  List<String> get searchHistory;

  bool get regSmartOTP;

  void changeRegSmartOTP(bool value);

  bool get regVA;

  void changeRegVA(bool value);

  Future<void> init();

  Future<void> deleteToken();

  Future<bool> saveToken(UserToken token);

  Future<List<String>> getSearchHistory();

  Future<void> refreshAssets();

  void putSearchHistory(String searchString);
}
