import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';

import '../../../generated/l10n.dart';
import '../../../utilities/responsive.dart';
import '../../theme/app_color.dart';
import 'otp_logic.dart';

class OtpPage extends StatefulWidget {
  final String phone;

  const OtpPage({super.key, required this.phone});

  @override
  State<OtpPage> createState() => _OtpPageState();
}

class _OtpPageState extends State<OtpPage> {
  final logic = Get.put(OtpLogic());
  final state = Get.find<OtpLogic>().state;

  @override
  Widget build(BuildContext context) {
    var headlineSmall = Theme.of(context).textTheme.headlineSmall;
    var titleSmall = Theme.of(context).textTheme.titleSmall;
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            Text(
              "Nhập mã OTP",
              style: headlineSmall?.copyWith(fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 16),
            RichText(
              text: TextSpan(children: [
                TextSpan(
                    text: 'Mã OTP đã được gửi về số điện thoại đuôi ',
                    style: titleSmall?.copyWith(
                        fontWeight: FontWeight.w500,
                        color: AppColors.neutral_04)),
                TextSpan(
                    text: widget.phone.replaceRange(0, 6, "*"),
                    style: titleSmall?.copyWith(
                        fontWeight: FontWeight.w700,
                        color: AppColors.primary_01)),
                TextSpan(
                    text: ' của bạn. Nhập mã 6 số để tiếp tục.',
                    style: titleSmall?.copyWith(
                        fontWeight: FontWeight.w500,
                        color: AppColors.neutral_04)),
              ]),
            ),
            const SizedBox(height: 32),
            Pinput(
              length: 6,
              defaultPinTheme: defaultPinTheme,
              focusedPinTheme: defaultPinTheme,
              cursor: cursor,
              preFilledWidget: preFilledWidget,
              pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,

              onCompleted: (pin) => setState(() {}),
            ),
            const SizedBox(height: 16),
            RichText(
              text: TextSpan(children: [
                TextSpan(
                    text: 'Gửi lại mã? ',
                    style: titleSmall?.copyWith(
                        fontWeight: FontWeight.w700,
                        color: AppColors.primary_01)),
                TextSpan(
                    text: '00:30',
                    style: titleSmall?.copyWith(
                        fontWeight: FontWeight.w500,
                        color: AppColors.neutral_04)),

              ]),
            ),
            const Spacer(),
            SizedBox(
              width: Responsive.getMaxWidth(context) - 32,
              child: TextButton(
                onPressed: null,
                style: const ButtonStyle(
                    padding: MaterialStatePropertyAll(EdgeInsets.all(14))),
                child: Text(S.of(context).confirm),
              ),
            ),
            const SizedBox(height: 50)
          ],
        ),
      ),
    );
  }

  final defaultPinTheme = PinTheme(
    width: 49,
    height: 49,
    textStyle: const TextStyle(
        fontSize: 18,
        color: AppColors.light_bg,
        fontWeight: FontWeight.w600),
    decoration: BoxDecoration(
      border: Border.all(color: AppColors.neutral_04),
      borderRadius: BorderRadius.circular(12),
      color: AppColors.neutral_01,
    ),
  );


  final preFilledWidget = Column(
    mainAxisAlignment: MainAxisAlignment.end,
    children: [
      Container(
        width: 24,
        height: 2,
        margin: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          color: AppColors.neutral_01,
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

  @override
  void dispose() {
    Get.delete<OtpLogic>();
    super.dispose();
  }
}
