import 'dart:async';
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
  TextEditingController otpController = TextEditingController();
  RxString otp = ''.obs;
  RxBool canNext = false.obs;
  RxInt timeExpire = 60.obs;
  Timer? otpExpire;

  Future<void> verifyRegisterOtp(BuildContext context) async {
    EasyLoading.show();
    final Map<String, String> body = {
      "account": userService.token.value?.user ?? '',
      "sid": userService.token.value?.sid ?? '',
      "otp": otp.value
    };

    final response = await networkService.checkRegisterOtp(jsonEncode(body));
    if (response) {
      EasyLoading.dismiss();
      userService.saveValueRegisterVa();
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => const RegisterRegistered(),
        ),
      );
    } else {
      EasyLoading.dismiss();
    }
  }

  @override
  void onReady() {
    super.onReady();
    otpController.addListener(
      () {
        if (otpController.text.length == 6) {
          canNext.value = true;
        } else {
          canNext.value = false;
        }
      },
    );
    _playTime();
  }

  _playTime() {
    timeExpire.value = 60;
    if (otpExpire == null || !otpExpire!.isActive) {
      otpExpire = Timer.periodic(
        const Duration(seconds: 1),
        (timer) {
          if (timeExpire.value == 0) {
            otpExpire!.cancel();
          } else {
            timeExpire.value--;
          }
        },
      );
    }
  }

  onClickResendOTP() async {
    EasyLoading.show();
    final Map<String, String> body = {
      "account": userService.token.value?.user ?? '',
      "sid": userService.token.value?.sid ?? '',
    };
    final response =
        await networkService.registerVirtualBroker(jsonEncode(body));
    if (response) {
      EasyLoading.dismiss();
    } else {
      EasyLoading.dismiss();
    }
  }
}
