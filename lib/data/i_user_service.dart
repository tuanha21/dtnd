import 'package:dtnd/=models=/response/account_info_model.dart';
import 'package:dtnd/=models=/response/user_token.dart';

abstract class IUserService {
  bool get isLogin;

  UserToken? get token;

  UserInfo? get userInfo;

  Future<void> init();

  Future<void> deleteToken();

  Future<bool> saveToken(UserToken token);

  Future<UserInfo?> getUserInfo();
}
