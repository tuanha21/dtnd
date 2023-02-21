import 'package:dtnd/=models=/request/request_model.dart';
import 'package:dtnd/=models=/response/user_token.dart';
import 'package:dtnd/data/i_network_service.dart';
import 'package:dtnd/data/i_user_service.dart';
import 'package:dtnd/data/implementations/network_service.dart';
import 'package:dtnd/data/implementations/user_service.dart';
import 'package:dtnd/utilities/logger.dart';
import 'package:flutter/material.dart';
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

extension LoginStatusX on LoginStatus {
  bool get isSuccess => this == LoginStatus.success;
}

class LoginController {
  LoginController._internal() {
    loginFormKey = GlobalKey<FormState>();
  }
  static final LoginController _instance = LoginController._internal();
  factory LoginController() => _instance;
  final INetworkService networkService = NetworkService();
  final IUserService userService = UserService();
  late final GlobalKey<FormState> loginFormKey;

  final Rx<bool> loading = Rx<bool>(false);
  final Rx<bool> otpRequired = Rx<bool>(false);

  final invalidAccount = false.obs;
  final invalidPassword = false.obs;

  Future<void> login(String username, String password) async {
    loading.value = true;
    final requestDataModel = RequestDataModel(
        type: RequestType.string,
        cmd: "Web.sCheckLogin",
        p1: username,
        p2: password,
        p3: "M",
        p4: "");
    final requestModel = RequestModel.login(
      group: "L",
      user: username,
      data: requestDataModel,
    );
    UserToken? userToken;
    try {
      userToken = await networkService.requestTraditionalApi<UserToken>(
        requestModel,
        hasError: hasError,
        onError: onError,
      );
    } catch (e) {
      loginFormKey.currentState?.validate();
      rethrow;
    }
    logger.v(userToken?.toJson());
    await userService.saveToken(userToken!);
    loading.value = false;
    return;
  }

  bool hasError(Map<String, dynamic>? entity) {
    if (entity == null) return true;
    final int rc = entity["rc"];
    if (rc == 1) return false;
    return true;
  }

  UserToken? onError(Map<String, dynamic>? entity) {
    if (entity == null) throw LoginStatus.somethingWhenWrong;

    throw entity["rs"];

    // final loginStatus = verifyEntity(entity);
    // switch (loginStatus) {
    //   case LoginStatus.wrongAccount:
    //     invalidAccount.value = true;
    //     break;
    //   case LoginStatus.wrongPassword:
    //     invalidPassword.value = true;
    //     break;
    //   default:
    //     break;
    // }
    // throw loginStatus;
  }

  LoginStatus verifyEntity(Map<String, dynamic>? entity) {
    logger.v(entity);
    if (entity == null) return LoginStatus.somethingWhenWrong;
    final int rc = entity["rc"];
    if (rc == 2) {
      otpRequired.value = true;
      return LoginStatus.requiredOTP;
    }
    if (rc == 0) {
      final String? rs = entity["rs"];
      if (rs?.isEmpty ?? true) return LoginStatus.somethingWhenWrong;
      if (rs!.contains("Tai khoan")) {
        return LoginStatus.wrongAccount;
      }
      if (rs.contains("Mat khau")) {
        return LoginStatus.wrongPassword;
      }
      return LoginStatus.somethingWhenWrong;
    }

    if ((entity["iFlag"] ?? 0) == 1) {
      return LoginStatus.changePassRequired;
    }
    return LoginStatus.failure;
  }
}
