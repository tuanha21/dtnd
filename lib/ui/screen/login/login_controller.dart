import 'package:dtnd/=models=/request/request_model.dart';
import 'package:dtnd/=models=/response/user_token.dart';
import 'package:dtnd/data/i_network_service.dart';
import 'package:dtnd/data/i_user_service.dart';
import 'package:dtnd/data/implementations/network_service.dart';
import 'package:dtnd/data/implementations/user_service.dart';
import 'package:get/get.dart';

enum LoginStatus {
  wrongAccount,
  wrongPassword,
  requiredOTP,
  success,
  failure,
  serverDown,
  changePassRequired,
  somethingWhenWrong,
}

class LoginController {
  LoginController._internal();
  static final LoginController _instance = LoginController._internal();
  factory LoginController() => _instance;
  final INetworkService networkService = NetworkService();
  final IUserService userService = UserService();

  final Rx<bool> loading = Rx<bool>(false);
  final Rx<bool> otpRequired = Rx<bool>(false);

  Future<void> login(String username, String password) async {
    loading.value = true;
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
    final userEntity = await networkService.checkLogin(requestModel);
    final loginStatus = await verifyEntity(userEntity);
    loading.value = false;
  }

  Future<LoginStatus> verifyEntity(UserEntity? entity) async {
    if (entity == null) return LoginStatus.somethingWhenWrong;
    final int rc = entity.rc;
    if (rc == 1) return LoginStatus.success;

    if (rc == 2) {
      otpRequired.value = true;
      return LoginStatus.requiredOTP;
    }
    if (rc == 0) {
      final String? rs = entity.rs;
      if (rs?.isEmpty ?? true) return LoginStatus.somethingWhenWrong;
      if (rs!.contains("Tai khoan")) {
        return LoginStatus.wrongAccount;
      }
      if (rs.contains("Mat khau")) {
        return LoginStatus.wrongPassword;
      }
      return LoginStatus.somethingWhenWrong;
    }

    if ((entity.loginData?.iFlag ?? 0) == 1) {
      return LoginStatus.changePassRequired;
    }
    return LoginStatus.failure;
  }
}
