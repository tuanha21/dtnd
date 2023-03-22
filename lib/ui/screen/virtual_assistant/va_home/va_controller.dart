import 'dart:convert';

import 'package:dtnd/=models=/response/va_portfolio_model.dart';
import 'package:dtnd/data/i_network_service.dart';
import 'package:dtnd/data/implementations/network_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

import '../../../../=models=/response/trash_model.dart';
import '../../../../data/i_user_service.dart';
import '../../../../data/implementations/user_service.dart';
import '../../home/home_controller.dart';

class VAController {
  final IUserService userService = UserService();
  final HomeController homeController = HomeController();
  final INetworkService networkService = NetworkService();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController volumeController = TextEditingController();

  final Rx<VAPortfolio?> vaPortfolio = Rxn();

  void initController() {}

  Future<void> createBot() async {
    EasyLoading.show();
    final Map<String, String> body = {
      "account": userService.token.value?.user ?? '',
      "session": userService.token.value?.sid ?? '',
      "stocks": ""
    };
    final response = await networkService.createBot(jsonEncode(body));
  }

  Future<void> deleteBot() async {
    EasyLoading.show();
    final Map<String, String> body = {
      "account": userService.token.value?.user ?? '',
      "session": userService.token.value?.sid ?? '',
    };
    final response = await networkService.deleteBot(jsonEncode(body));
  }
}
