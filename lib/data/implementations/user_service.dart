import 'package:dtnd/=models=/response/user_token.dart';
import 'package:dtnd/=models=/request/request_model.dart';
import 'package:dtnd/data/i_user_service.dart';
import 'package:dtnd/data/implementations/network_service.dart';

class UserService implements IUserService {
  late final NetworkService _networkService;

  UserService({required NetworkService networkService})
      : _networkService = networkService;

  @override
  Future<UserToken?> login(RequestModel model) async {
    return null;
  }

  @override
  Future<void> logout() {
    // TODO: implement logout
    throw UnimplementedError();
  }
}
