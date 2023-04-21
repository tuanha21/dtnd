import 'package:dtnd/ui/theme/app_color.dart';
import 'package:dtnd/ui/widget/input/rounded_pinput.dart';
import 'package:flutter/material.dart';

import '../../../../../../generated/l10n.dart';

class CreateSmartOtpPinPage extends StatefulWidget {
  const CreateSmartOtpPinPage({
    super.key,
    required this.nextPage,
  });

  final VoidCallback nextPage;

  @override
  State<CreateSmartOtpPinPage> createState() => _CreateSmartOtpPinPageState();
}

class _CreateSmartOtpPinPageState extends State<CreateSmartOtpPinPage> {
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
            S.of(context).Setting_up_Smart_OTP_password,
            style: textTheme.headlineSmall,
          ),
          const SizedBox(height: 16),
          Text(
            S.of(context).Please_remember_your_SmartOTP_password,
            style: textTheme.bodyMedium!.copyWith(color: AppColors.neutral_03),
          ),
          const SizedBox(height: 36),
          Text(
            S.of(context).Set_a_password_consisting_of_6_digits,
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
                  child: Text(S.of(context).confirm),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
