import 'dart:convert';

import 'package:dtnd/=models=/response/stock_va.dart';
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
  final NetworkService networkService = NetworkService();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController volumeController = TextEditingController();
  StockVa? data;

  Future<void> checkListInfoBot() async {
    EasyLoading.show();
    final Map<String, String> body = {
      "account": userService.token.value?.user ?? '',
      "session": userService.token.value?.sid ?? '',
    };
    data = await networkService.checkListInfoBot(jsonEncode(body));

  }

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
