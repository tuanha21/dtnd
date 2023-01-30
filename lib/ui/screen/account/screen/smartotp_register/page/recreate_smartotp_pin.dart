import 'package:dtnd/ui/theme/app_color.dart';
import 'package:dtnd/ui/widget/input/rounded_pinput.dart';
import 'package:flutter/material.dart';

class RecreateSmartotpPinPage extends StatefulWidget {
  const RecreateSmartotpPinPage({
    super.key,
    required this.nextPage,
  });
  final VoidCallback nextPage;

  @override
  State<RecreateSmartotpPinPage> createState() =>
      _RecreateSmartotpPinPageState();
}

class _RecreateSmartotpPinPageState extends State<RecreateSmartotpPinPage> {
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
            "Nhập lại mật khẩu SmartOTP",
            style: textTheme.headlineSmall,
          ),
          const SizedBox(height: 16),
          Text(
            "Quý khách vui lòng ghi nhớ mật khẩu SmartOTP",
            style: textTheme.bodyMedium!.copyWith(color: AppColors.neutral_03),
          ),
          const SizedBox(height: 36),
          Text(
            "Nhập lại mật khẩu 6 chữ số",
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
