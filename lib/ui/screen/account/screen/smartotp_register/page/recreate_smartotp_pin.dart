import 'package:dtnd/l10n/generated/l10n.dart';
import 'package:dtnd/ui/theme/app_color.dart';
import 'package:dtnd/ui/widget/input/rounded_pinput.dart';
import 'package:flutter/material.dart';

class RecreateSmartOtpPinPage extends StatefulWidget {
  const RecreateSmartOtpPinPage({
    super.key,
    required this.nextPage,
  });

  final VoidCallback nextPage;

  @override
  State<RecreateSmartOtpPinPage> createState() =>
      _RecreateSmartOtpPinPageState();
}

class _RecreateSmartOtpPinPageState extends State<RecreateSmartOtpPinPage> {
  final TextEditingController controller = TextEditingController();

  bool complete = false;

  void onChanged(String pin) {
    if (!complete) {
      if (pin.length == 6) {
        setState(() {
          complete = true;
        });
      }
    } else {
      setState(() {
        complete = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    VoidCallback? onPressed;
    if (complete) {
      onPressed = widget.nextPage;
    }
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            S.of(context).re_enter_smartOTP_password,
            style: textTheme.headlineSmall,
          ),
          const SizedBox(height: 16),
          Text(
            S.of(context).please_remember_your_smartOTP_password,
            style: textTheme.bodyMedium!.copyWith(color: AppColors.neutral_03),
          ),
          const SizedBox(height: 36),
          Text(
            S.of(context).re_enter_6_digit_password,
            style: textTheme.bodyLarge,
          ),
          const SizedBox(height: 16),
          RoundedPinput(
            onChanged: onChanged,
          ),
          const SizedBox(height: 36),
          Row(
            children: [
              Expanded(
                  child: TextButton(
                      onPressed: onPressed,
                      child: Text(S.of(context).confirm))),
            ],
          )
        ],
      ),
    );
  }
}
