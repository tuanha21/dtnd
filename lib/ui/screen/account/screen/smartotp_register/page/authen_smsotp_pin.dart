import 'package:dtnd/ui/screen/account/screen/smartotp_register/catalog/catalog_index.dart';
import 'package:dtnd/ui/screen/account/screen/smartotp_register/catalog/registed_smartotp_catalog.dart';
import 'package:dtnd/ui/theme/app_color.dart';
import 'package:dtnd/ui/widget/input/rounded_pinput.dart';
import 'package:flutter/material.dart';

class AuthenSmsotpPinPage extends StatefulWidget {
  const AuthenSmsotpPinPage({
    super.key,
    required this.nextPage,
  });
  final VoidCallback nextPage;

  @override
  State<AuthenSmsotpPinPage> createState() => _AuthenSmsotpPinPageState();
}

class _AuthenSmsotpPinPageState extends State<AuthenSmsotpPinPage> {
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
      onPressed = () {
        const SmartotpRegistedIDialog().show(
            context,
            SmartotpRegistedCatalog(
              onClose: widget.nextPage,
            ));
      };
    }
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Xác thực cài đặt",
            style: textTheme.headlineSmall,
          ),
          const SizedBox(height: 16),
          Text(
            "Mã OTP đã được gửi về số điện thoại đuôi *6789 của bạn. Nhập mã 6 số để tiếp tục.",
            style: textTheme.bodyMedium!.copyWith(color: AppColors.neutral_03),
          ),
          const SizedBox(height: 16),
          RoundedPinput(
            onChanged: onChanged,
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(
                child: Text(
                  "Gửi lại mã?",
                  style: textTheme.bodySmall!
                      .copyWith(color: AppColors.primary_01),
                ),
              ),
            ],
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
