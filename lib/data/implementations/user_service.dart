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
  Future<void> init() {
    throw UnimplementedError();
  }

  @override
  Future<void> deleteToken() async {
    userToken = null;
    return;
  }

  @override
  Future<bool> saveToken(UserToken token) async {
    try {
      userToken = token;
      await localStorageService.saveUserToken(token);
      return true;
    } catch (e) {
      return false;
    }
  }

  @override
  bool get isLogin => userToken != null;

  @override
  UserToken? get token => userToken;
}
