import 'package:dtnd/ui/theme/app_color.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';

class RoundedPinput extends StatefulWidget {
  const RoundedPinput({
    Key? key,
    this.onCompleted,
    this.onChanged,
  }) : super(key: key);
  final ValueChanged<String>? onCompleted;
  final ValueChanged<String>? onChanged;

  @override
  State<RoundedPinput> createState() => _RoundedPinputState();
}

class _RoundedPinputState extends State<RoundedPinput> {
  final pinController = TextEditingController();
  final focusNode = FocusNode();
  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    pinController.dispose();
    focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const focusedBorderColor = AppColors.neutral_04;
    const fillColor = AppColors.neutral_06;
    const borderColor = AppColors.neutral_05;

    final defaultPinTheme = PinTheme(
      width: 50,
      height: 50,
      // textStyle: GoogleFonts.poppins(
      //   fontSize: 22,
      //   color: const Color.fromRGBO(30, 60, 87, 1),
      // ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: borderColor),
      ),
    );

    return Pinput(
      length: 6,
      controller: pinController,
      focusNode: focusNode,
      androidSmsAutofillMethod: AndroidSmsAutofillMethod.smsUserConsentApi,
      listenForMultipleSmsOnAndroid: true,
      defaultPinTheme: defaultPinTheme,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      // validator: (value) {
      //   return value == '123456' ? null : 'Pin is incorrect';
      // },
      hapticFeedbackType: HapticFeedbackType.lightImpact,
      onCompleted: widget.onCompleted,
      onChanged: widget.onChanged,
      cursor: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            margin: const EdgeInsets.only(bottom: 9),
            width: 22,
            height: 1,
            color: focusedBorderColor,
          ),
        ],
      ),
      focusedPinTheme: defaultPinTheme.copyWith(
        decoration: defaultPinTheme.decoration!.copyWith(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: focusedBorderColor),
        ),
      ),
      submittedPinTheme: defaultPinTheme.copyWith(
        decoration: defaultPinTheme.decoration!.copyWith(
          color: fillColor,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: focusedBorderColor),
        ),
      ),
      errorPinTheme: defaultPinTheme.copyBorderWith(
        border: Border.all(color: AppColors.semantic_03),
      ),
    );
  }
}
