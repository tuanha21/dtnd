import 'package:dtnd/=models=/request/request_model.dart';
import 'package:dtnd/=models=/response/user_token.dart';

abstract class IUserService {
  Future<UserToken?> login(RequestModel model);

  Future<void> logout();
}
