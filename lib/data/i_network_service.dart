import '../=models=/request/request_model.dart';
import '../=models=/response/user_token.dart';

abstract class INetworkService {
  //init service
  Future<void> init(String config);

  //core api
  Future<UserToken?> checkLogin(RequestModel requestModel);
}
