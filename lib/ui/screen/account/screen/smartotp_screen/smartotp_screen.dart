import 'package:dtnd/data/i_user_service.dart';
import 'package:dtnd/data/implementations/user_service.dart';
import 'package:dtnd/generated/l10n.dart';
import 'package:dtnd/ui/screen/account/screen/smartotp_register/smartotp_register.dart';
import 'package:dtnd/ui/widget/appbar/simple_appbar.dart';
import 'package:flutter/material.dart';

class SmartotpScreen extends StatefulWidget {
  const SmartotpScreen({super.key});

  @override
  State<SmartotpScreen> createState() => _SmartotpScreenState();
}

class _SmartotpScreenState extends State<SmartotpScreen> {
  final IUserService userService = UserService();
  bool reg = false;
  void onChanged(bool value) async {
    setState(() {
      reg = value;
    });
    if (value) {
      await Future.delayed(const Duration(milliseconds: 500));
      setState(() {
        reg = false;
      });
      await Future.delayed(const Duration(milliseconds: 100));
      if (mounted) {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => SmartOTPRegister(
            rebuild: rebuild,
          ),
        ));
      }
    }
  }

  void rebuild() {
    setState(() {
      reg = userService.regSmartOTP;
    });
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: SimpleAppbar(title: S.of(context).setting_up_smartOTP),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  S.of(context).registering_for_smartOTP,
                  style: textTheme.titleSmall,
                ),
                Switch.adaptive(value: reg, onChanged: onChanged)
              ],
            )
          ],
        ),
      ),
    );
  }
}
