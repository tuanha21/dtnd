import 'package:dtnd/ui/theme/app_color.dart';
import 'package:dtnd/ui/widget/input/rounded_pinput.dart';
import 'package:flutter/material.dart';

class CreateSmartotpPinPage extends StatefulWidget {
  const CreateSmartotpPinPage({
    super.key,
    required this.nextPage,
  });
  final VoidCallback nextPage;

  @override
  State<CreateSmartotpPinPage> createState() => _CreateSmartotpPinPageState();
}

class _CreateSmartotpPinPageState extends State<CreateSmartotpPinPage> {
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
            "Cài đặt mật khẩu Smart OTP",
            style: textTheme.headlineSmall,
          ),
          const SizedBox(height: 16),
          Text(
            "Quý khách vui lòng ghi nhớ mật khẩu SmartOTP",
            style: textTheme.bodyMedium!.copyWith(color: AppColors.neutral_03),
          ),
          const SizedBox(height: 36),
          Text(
            "Đặt mật khẩu gồm 6 chữ số",
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
                      onPressed: onPressed, child: const Text("Xác nhận"))),
            ],
          )
        ],
      ),
    );
  }
}
