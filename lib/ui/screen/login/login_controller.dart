import 'package:dtnd/=models=/request/request_model.dart';
import 'package:dtnd/data/i_network_service.dart';
import 'package:dtnd/data/implementations/network_service.dart';
import 'package:get/get.dart';

class LoginController {
  LoginController._internal();
  static final LoginController _instance = LoginController._internal();
  factory LoginController() => _instance;
  final INetworkService networkService = NetworkService();

  final Rx<bool> invalidUsername = Rx(false);
  final Rx<bool> invalidPassword = Rx(false);

  Future<void> login(String username, String password) async {
    final requestDataModel = RequestDataModel(
        type: RequestType.string,
        cmd: "Web.sCheckLogin",
        p1: username,
        p2: password,
        p3: "M",
        p4: "");
    final requestModel = RequestModel(
      group: "L",
      user: username,
      data: requestDataModel,
    );
    await networkService.checkLogin(requestModel);
  }
}
