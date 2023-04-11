import 'dart:convert';

import 'package:dtnd/generated/l10n.dart';
import 'package:dtnd/ui/theme/app_image.dart';
import 'package:dtnd/ui/widget/my_appbar.dart';
import 'package:dtnd/utilities/responsive.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

import '../../../../../data/i_network_service.dart';
import '../../../../../data/i_user_service.dart';
import '../../../../../data/implementations/network_service.dart';
import '../../../../../data/implementations/user_service.dart';
import '../../../../widget/overlay/custom_dialog.dart';
import '../register_fill_otp/button.dart';
import '../register_fill_otp/register_fill_otp_screen.dart';

class RegisterIntro extends StatefulWidget {
  RegisterIntro({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _RegisterIntro();
}

class _RegisterIntro extends State<RegisterIntro> {
  final IUserService userService = UserService();
  final INetworkService networkService = NetworkService();
  RxBool canNext = true.obs;

  Future<void> onClickRegisterFillOTP(BuildContext context) async {
    canNext.value = false;
    EasyLoading.show();
    final Map<String, String> body = {
      "account": userService.token.value?.user ?? '',
      "sid": userService.token.value?.sid ?? '',
    };

    final response =
        await networkService.registerVirtualBroker(jsonEncode(body));

    if (response) {
      canNext.value = true;
      EasyLoading.dismiss();
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => RegisterFillOTP(),
        ),
      );
    } else {
      CustomDialog(
        title: 'Đã có lỗi xảy ra',
        content: 'hãy kiểm tra lại đường truyền tín hiệu',
        action: () => Navigator.of(context).pop(),
        textButtonExit: 'Thoát',
        textButtonAction: 'OK',
        type: TypeAlert.notification,
      );
      EasyLoading.dismiss();
    }
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: const MyAppBar(
        title: 'Trợ lý ảo',
      ),
      body: Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: Responsive.getMaxWidth(context) / 2 - 20,
                child: Image.asset(
                  AppImages.virtual_assistant_register,
                  fit: BoxFit.fitWidth,
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
                child: Text(
                  S.of(context).virtual_assistant_available,
                  textAlign: TextAlign.center,
                  style: textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.w700, fontSize: 16, height: 1.4),
                ),
              ),
              SizedBox(
                width: Responsive.getMaxWidth(context) - 32,
                child: MyButton(
                  title: S.of(context).create_account,
                  cantTap: canNext,
                  onTap: () {
                    onClickRegisterFillOTP(context);
                  },
                ),
              ),
            ]),
      ),
    );
  }
}
