import 'package:dtnd/ui/theme/app_textstyle.dart';
import 'package:flutter/material.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  late final TextEditingController _emailController;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: Column(children: [
          Text(
            "Quên mật khẩu",
            style: AppTextStyle.headlineSmall_24
                .copyWith(fontWeight: FontWeight.w700),
          )
        ]));
  }
}
