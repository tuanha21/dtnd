import 'package:dtnd/=models=/response/user_token.dart';

abstract class IUserService {
  bool get isLogin;

  Future<void> init();

  Future<void> deleteToken();

  Future<bool> saveToken(UserToken token);
}
