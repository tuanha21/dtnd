import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

import '../../../../../data/i_network_service.dart';
import '../../../../../data/i_user_service.dart';
import '../../../../../data/implementations/network_service.dart';
import '../../../../../data/implementations/user_service.dart';
import '../register_registered/register_registered_screen.dart';

class RegisterFillOtpController extends GetxController {
  final IUserService userService = UserService();
  final INetworkService networkService = NetworkService();
  RxString otp = ''.obs;
  RxBool canNext = false.obs;

  Future<void> verifyRegisterOtp(BuildContext context) async {
    print("adu");
    EasyLoading.show();
    final Map<String, String> body = {
      "account": userService.token.value?.user ?? '',
      "sid": userService.token.value?.sid ?? '',
      "otp": otp.value
    };

    final response = await networkService.checkRegisterOtp(jsonEncode(body));
    if (response) {
      EasyLoading.dismiss();
      Navigator.of(context).push<void>(
        MaterialPageRoute(
          builder: (context) => const RegisterRegistered(),
        ),
      );
    }else{
      EasyLoading.dismiss();
    }
  }

  @override
  void dispose() {
    canNext.value = false;
    super.dispose();
  }
}
