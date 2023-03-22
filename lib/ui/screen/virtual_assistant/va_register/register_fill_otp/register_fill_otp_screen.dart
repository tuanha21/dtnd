import 'package:dtnd/generated/l10n.dart';
import 'package:dtnd/ui/screen/virtual_assistant/va_register/register_fill_otp/register_fill_otp_controller.dart';
import 'package:dtnd/ui/theme/app_color.dart';
import 'package:dtnd/ui/widget/my_appbar.dart';
import 'package:dtnd/utilities/responsive.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';

import '../../../../theme/app_textstyle.dart';
import 'button.dart';

class RegisterFillOTP extends GetView<RegisterFillOtpController> {
  final RegisterFillOtpController controller =
      Get.put(RegisterFillOtpController());

  RegisterFillOTP({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: const MyAppBar(
        title: 'Trợ lý ảo',
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                S.of(context).fill_OTP,
                style:
                    theme.headlineSmall!.copyWith(fontWeight: FontWeight.w700),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      S.of(context).otp_code_sent_to_phone_number("*sdk"),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 36),
              Builder(
                builder: (context) {
                  final defaultPinTheme = PinTheme(
                    width: 49,
                    height: 49,
                    textStyle: const TextStyle(
                        fontSize: 20,
                        color: Color.fromRGBO(30, 60, 87, 1),
                        fontWeight: FontWeight.w600),
                    decoration: BoxDecoration(
                      border: Border.all(color: AppColors.neutral_04),
                      borderRadius: BorderRadius.circular(12),
                      color: AppColors.neutral_06,
                    ),
                  );

                  final focusedPinTheme = defaultPinTheme.copyDecorationWith(
                    border: Border.all(
                      color: AppColors.primary_01,
                    ),
                    borderRadius: BorderRadius.circular(12),
                  );

                  final preFilledWidget = Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        width: 24,
                        height: 2,
                        margin: const EdgeInsets.symmetric(vertical: 10),
                        decoration: BoxDecoration(
                          color: AppColors.neutral_04,
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ],
                  );
                  final cursor = Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        width: 24,
                        height: 2,
                        margin: const EdgeInsets.symmetric(vertical: 10),
                        decoration: BoxDecoration(
                          color: AppColors.primary_01,
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ],
                  );
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Pinput(
                        controller: controller.otpController,
                        length: 6,
                        defaultPinTheme: defaultPinTheme,
                        focusedPinTheme: focusedPinTheme,
                        cursor: cursor,
                        preFilledWidget: preFilledWidget,
                        pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
                        onCompleted: (pin) {
                          controller.otp.value = pin;
                        },
                      ),
                    ],
                  );
                },
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  const Text('OTP hết hạn sau : '),
                  const SizedBox(width: 6),
                  Expanded(
                    child: Obx(
                      () => Text(
                        '${controller.timeExpire.value}s',
                        style: AppTextStyle.bodyMedium_14
                            .copyWith(color: AppColors.semantic_03),
                      ),
                    ),
                  ),
                  Obx(
                    () => controller.timeExpire.value == 0
                        ? InkWell(
                            child: Text(
                              'Gửi lại mã?',
                              style: AppTextStyle.bodyMedium_14,
                            ),
                            onTap: () => controller.onClickResendOTP(),
                          )
                        : const SizedBox(),
                  )
                ],
              ),
              const SizedBox(height: 36),
              SizedBox(
                width: Responsive.getMaxWidth(context) - 32,
                child: MyButton(
                  title: S.of(context).confirm,
                  cantTap: controller.canNext,
                  onTap: () => controller.verifyRegisterOtp(context),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
