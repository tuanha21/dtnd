import 'package:dtnd/ui/screen/ekyc/ekyc_logic.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

import '../../../theme/app_color.dart';
import '../../../theme/app_image.dart';
import '../ekyc_state.dart';

class EkycIntroducePage extends StatelessWidget {
  const EkycIntroducePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final headlineSmall = Theme.of(context).textTheme.headlineSmall;
    var titleSmall = Theme.of(context).textTheme.titleSmall;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 90),
              Center(
                child: Image.asset(
                  AppImages.illust05,
                  height: 200,
                ),
              ),
              const SizedBox(height: 20),
              Text(
                'Bạn cần xác minh eKYC để tiếp tục  đặt lệnh',
                style: headlineSmall?.copyWith(fontWeight: FontWeight.w700),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(children: [
                  TextSpan(
                      text: 'Quy trình xác minh ',
                      style: titleSmall?.copyWith(
                          fontWeight: FontWeight.w500,
                          color: AppColors.neutral_04)),
                  TextSpan(
                      text: "eKYC",
                      style: titleSmall?.copyWith(
                          fontWeight: FontWeight.w700,
                          color: AppColors.light_bg)),
                  TextSpan(
                      text:
                          ' là điều kiện bắt buộc khi giao dịch các sản phẩm đầu tư',
                      style: titleSmall?.copyWith(
                          fontWeight: FontWeight.w500,
                          color: AppColors.neutral_04)),
                ]),
              ),
              const Spacer(),
              SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: ElevatedButton(
                      onPressed: () {
                        Get.find<EkycLogic>().nextStep();
                      },
                      child: const Text("Xác minh ngay"))),
              const SizedBox(height: 16),
              GestureDetector(
                onTap: () {
                  context.goNamed('home');
                },
                child: Center(
                    child: Text(
                  'Để sau',
                  style: titleSmall,
                )),
              ),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}