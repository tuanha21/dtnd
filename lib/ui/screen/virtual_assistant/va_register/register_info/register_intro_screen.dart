import 'package:dtnd/generated/l10n.dart';
import 'package:dtnd/ui/screen/virtual_assistant/va_register/register_info/Register_info_controller.dart';
import 'package:dtnd/ui/theme/app_color.dart';
import 'package:dtnd/ui/theme/app_image.dart';
import 'package:dtnd/ui/widget/my_appbar.dart';
import 'package:dtnd/utilities/responsive.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegisterIntro extends GetView<RegisterInfoController> {
  @override
  final RegisterInfoController controller = Get.put(RegisterInfoController());

  RegisterIntro({Key? key}) : super(key: key);

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
              padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
              child: Text(
                S.of(context).virtual_assistant_available,
                textAlign: TextAlign.center,
                style: textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.w700, fontSize: 16, height: 1.4),
              ),
            ),
            SizedBox(
              width: Responsive.getMaxWidth(context) - 32,
              child: TextButton(
                onPressed: () {
                  controller.onClickRegisterFillOTP(context);
                },
                style: const ButtonStyle(
                    padding: MaterialStatePropertyAll(EdgeInsets.all(14))),
                child: Text(
                  S.of(context).create_account,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: AppColors.neutral_07),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
