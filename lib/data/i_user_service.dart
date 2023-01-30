import 'package:dtnd/=models=/response/account_info_model.dart';
import 'package:dtnd/=models=/response/total_asset_model.dart';
import 'package:dtnd/=models=/response/user_token.dart';

abstract class IUserService {
  bool get isLogin;

  UserToken? get token;

  UserInfo? get userInfo;

  TotalAsset? get totalAsset;

  bool get regSmartOTP;

  void changeRegSmartOTP(bool value);

  Future<void> init();

  Future<void> deleteToken();

  Future<bool> saveToken(UserToken token);
}
