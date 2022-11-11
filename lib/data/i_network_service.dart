import 'package:dtnd/config/service/environment.dart';

import '../=models=/request/request_model.dart';
import '../=models=/response/user_token.dart';

abstract class INetworkService {
  //init service
  Future<void> init(Environment environment);

  //core api
  Future<UserEntity?> checkLogin(RequestModel requestModel);
}
