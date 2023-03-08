import 'package:dtnd/generated/l10n.dart';
import 'package:dtnd/ui/theme/app_color.dart';
import 'package:dtnd/utilities/responsive.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';

class RegisterFillOTP extends StatefulWidget {
  const RegisterFillOTP({
    super.key,
    required this.nextPage,
  });
  final VoidCallback nextPage;
  @override
  State<RegisterFillOTP> createState() => _RegisterFillOTPState();
}

class _RegisterFillOTPState extends State<RegisterFillOTP> {
  bool canNext = false;
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
                  child:
                      Text(S.of(context).otp_code_sent_to_phone_number("*sdk")))
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
          const SizedBox(height: 16),
          Row(
            children: [Expanded(child: Text('Gửi lại mã?'))],
          ),
          const SizedBox(height: 36),
          Builder(builder: (context) {
            late final VoidCallback? next;
            if (canNext) {
              next = () => widget.nextPage.call();
            } else {
              next = null;
            }

            return SizedBox(
              width: Responsive.getMaxWidth(context) - 32,
              child: TextButton(
                onPressed: next,
                style: const ButtonStyle(
                    padding: MaterialStatePropertyAll(EdgeInsets.all(14))),
                child: Text(
                  S.of(context).confirm,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: AppColors.neutral_07),
                ),
              ),
            );
          }),
        ],
      ),
    );
  }
}
