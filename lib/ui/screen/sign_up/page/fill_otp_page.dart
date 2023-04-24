import 'dart:async';

import 'package:dtnd/=models=/sign_up_success_data_model.dart';
import 'package:dtnd/generated/l10n.dart';
import 'package:dtnd/ui/theme/app_color.dart';
import 'package:dtnd/ui/theme/app_textstyle.dart';
import 'package:dtnd/ui/widget/app_snack_bar.dart';
import 'package:dtnd/ui/widget/button/async_button.dart';
import 'package:dtnd/ui/widget/expanded_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';

class FillOTPPage extends StatefulWidget {
  const FillOTPPage(
      {super.key,
      required this.onSuccess,
      required this.verifyOTP,
      required this.createAccount,
      required this.resendOTP,
      required this.email});
  final VoidCallback onSuccess;
  final VoidCallback resendOTP;
  final Future<bool> Function(String) verifyOTP;
  final Future<SignUpSuccessDataModel?> Function() createAccount;
  final String? email;
  @override
  State<FillOTPPage> createState() => _FillOTPPageState();
}

class _FillOTPPageState extends State<FillOTPPage> {
  final TextEditingController controller = TextEditingController();
  Timer? timer;
  String? errorTxt;
  bool canNext = false;
  bool canResend = false;
  VoidCallback? resendOTP;
  final Rx<int> timeLeft = 30.obs;
  @override
  void initState() {
    super.initState();
    setTimer();
  }

  void setTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (tm) {
      if (timeLeft.value == 1) {
        timer?.cancel();
        setState(() {
          resendOTP = () {
            setState(() {
              resendOTP = null;
            });
            timeLeft.value = 30;
            widget.resendOTP.call();
            return setTimer();
          };
        });
      }
      timeLeft.value--;
    });
  }

  String get _timeLeft => timeLeft.value > 9
      ? "00:${timeLeft.value.toString()}"
      : timeLeft.value == 0
          ? ""
          : "00:0${timeLeft.value}";

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            S.of(context).fill_OTP,
            style: theme.headlineSmall!.copyWith(fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                  child: Text(S
                      .of(context)
                      .otp_code_sent_to_phone_number(widget.email.toString())))
            ],
          ),
          const SizedBox(height: 36),
          Builder(builder: (context) {
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
                  controller: controller,
                  length: 6,
                  defaultPinTheme: defaultPinTheme,
                  focusedPinTheme: focusedPinTheme,
                  cursor: cursor,
                  preFilledWidget: preFilledWidget,
                  pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
                  onCompleted: (pin) => setState(() {
                    canNext = true;
                  }),
                ),
              ],
            );
          }),
          const SizedBox(height: 8),
          ExpandedSection(
              expand: errorTxt != null,
              child: Row(
                children: [
                  Text(
                    errorTxt ?? "",
                    style: AppTextStyle.bodySmall_12
                        .copyWith(color: AppColors.semantic_03),
                  )
                ],
              )),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(
                onTap: resendOTP,
                child: Text(
                  S.of(context).Send_the_code_again,
                  style: AppTextStyle.bodySmall_12.copyWith(
                    color: resendOTP != null
                        ? AppColors.primary_01
                        : AppColors.neutral_03,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Obx(() => Text(
                    _timeLeft,
                    style: AppTextStyle.bodyMedium_14.copyWith(
                      color: AppColors.neutral_03,
                      fontWeight: FontWeight.w700,
                    ),
                  )),
            ],
          ),
          const SizedBox(height: 36),
          AsyncButton(
            onPressed: onVerify,
            child: Text(
              S.of(context).confirm,
              style: AppTextStyle.bodyMedium_14.copyWith(
                  fontWeight: FontWeight.w700, color: AppColors.neutral_07),
            ),
          ),
          // Builder(builder: (context) {
          //   late final VoidCallback? next;
          //   if (canNext) {
          //     next = onVerify;
          //   } else {
          //     next = null;
          //   }

          //   return SizedBox(
          //     width: Responsive.getMaxWidth(context) - 32,
          //     child: TextButton(
          //       onPressed: next,
          //       style: const ButtonStyle(
          //           padding: MaterialStatePropertyAll(EdgeInsets.all(14))),
          //       child: Text(
          //         S.of(context).confirm,
          //         style: AppTextStyle.bodyMedium_14.copyWith(
          //             fontWeight: FontWeight.w700, color: AppColors.neutral_07),
          //       ),
          //     ),
          //   );
          // }),
        ],
      ),
    );
  }

  Future<void> onVerify() async {
    setState(() {
      errorTxt = null;
    });
    final verified = await widget.verifyOTP.call(controller.text);
    if (verified) {
      try {
        await widget.createAccount.call();
      } catch (e) {
        if (mounted) {
          return AppSnackBar.showInfo(context, message: e.toString());
        } else {
          return;
        }
      }
      widget.onSuccess.call();
    } else {
      setState(() {
        errorTxt = "Sai mã OTP";
      });
      return;
    }
  }
}
