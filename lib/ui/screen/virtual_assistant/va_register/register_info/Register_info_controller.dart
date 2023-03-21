import 'dart:convert';

import 'package:dtnd/data/implementations/user_service.dart';
import 'package:dtnd/ui/screen/virtual_assistant/va_register/register_fill_otp/register_fill_otp_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

import '../../../../../data/i_network_service.dart';
import '../../../../../data/i_user_service.dart';
import '../../../../../data/implementations/network_service.dart';

class RegisterInfoController extends GetxController {
  final IUserService userService = UserService();
  final INetworkService networkService = NetworkService();

  Future<void> onClickRegisterFillOTP(BuildContext context) async {
    EasyLoading.show();
    final Map<String, String> body = {
      "account": userService.token.value?.user ?? '',
      "sid": userService.token.value?.sid ?? '',
    };

    final response =
        await networkService.registerVirtualBroker(jsonEncode(body));
    if (response) {
      EasyLoading.dismiss();
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => RegisterFillOTP(),
        ),
      );
    }else{
      EasyLoading.dismiss();
    }
  }
}
