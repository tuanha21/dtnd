import 'package:dtnd/=models=/response/user_token.dart';
import 'package:dtnd/=models=/request/request_model.dart';
import 'package:dtnd/data/i_network_service.dart';
import 'package:dtnd/data/i_user_service.dart';
import 'package:dtnd/data/implementations/network_service.dart';

class UserService implements IUserService {
  final INetworkService networkService = NetworkService();

  UserService._internal();

  static final UserService _instance = UserService._internal();

  @override
  UserToken? userToken;

  factory UserService() => _instance;

  @override
  Future<void> init() {
    throw UnimplementedError();
  }

  @override
  Future<UserToken?> login(RequestModel model) async {
    return null;
  }

  @override
  Future<void> logout() {
    throw UnimplementedError();
  }
}
