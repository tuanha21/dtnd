import 'dart:async';
import 'dart:convert';

import 'package:dtnd/l10n/generated/l10n.dart';
import 'package:dtnd/ui/theme/app_color.dart';
import 'package:dtnd/ui/widget/my_appbar.dart';
import 'package:dtnd/ui/widget/overlay/custom_dialog.dart';
import 'package:dtnd/utilities/responsive.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';

import '../../../../../data/i_network_service.dart';
import '../../../../../data/i_user_service.dart';
import '../../../../../data/implementations/network_service.dart';
import '../../../../../data/implementations/user_service.dart';
import '../../../../theme/app_textstyle.dart';
import '../register_registered/register_registered_screen.dart';
import 'button.dart';

class RegisterFillOTP extends StatefulWidget {
  const RegisterFillOTP({
    super.key,
  });

  @override
  State<StatefulWidget> createState() => _RegisterFillOTP();
}

class _RegisterFillOTP extends State<RegisterFillOTP> {
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
      CustomDialog(
        title: S.of(context).something_went_wrong,
        content: 'hãy kiểm tra lại OTP và đường truyền tín hiệu',
        action: () => Navigator.of(context).pop(),
        textButtonExit: 'Thoát',
        textButtonAction: 'OK',
        type: TypeAlert.notification,
      );
      EasyLoading.dismiss();
    }
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
    _playTime();
  }

  @override
  void initState() {
    super.initState();
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
                        controller: otpController,
                        length: 6,
                        defaultPinTheme: defaultPinTheme,
                        focusedPinTheme: focusedPinTheme,
                        cursor: cursor,
                        preFilledWidget: preFilledWidget,
                        pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
                        onCompleted: (pin) {
                          otp.value = pin;
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
                        '${timeExpire.value}s',
                        style: AppTextStyle.bodyMedium_14
                            .copyWith(color: AppColors.semantic_03),
                      ),
                    ),
                  ),
                  Obx(
                    () => timeExpire.value == 0
                        ? InkWell(
                            child: Text(
                              S.of(context).Send_the_code_again,
                              style: AppTextStyle.bodyMedium_14,
                            ),
                            onTap: () => onClickResendOTP(),
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
                  cantTap: canNext,
                  onTap: () => verifyRegisterOtp(context),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
