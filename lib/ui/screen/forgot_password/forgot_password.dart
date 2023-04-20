import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:dtnd/=models=/check_account_success_data_model.dart';
import 'package:dtnd/data/i_user_service.dart';
import 'package:dtnd/data/implementations/user_service.dart';
import 'package:dtnd/generated/l10n.dart';
import 'package:dtnd/ui/screen/forgot_password/screen/otp_forgot_password.dart';
import 'package:dtnd/ui/theme/app_color.dart';
import 'package:dtnd/ui/theme/app_textstyle.dart';
import 'package:dtnd/ui/widget/button/async_button.dart';
import 'package:flutter/material.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final emailFormKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final IUserService userService = UserService();

  late CheckAccountSuccessDataModel? accountInfo;

  String? _errorMessage;

  bool isValidEmail(String? email) {
    if (email == null) {
      return false;
    } else {
      return RegExp(
              r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
          .hasMatch(email);
    }
  }

  void refreshError() {
    setState(() {
      _errorMessage = null;
    });
  }

  Future<bool> checkEmailExist(String email) async {
    try {
      accountInfo = await userService.checkAccountInfo(email);
      return true;
    } catch (e) {
      setState(() {
        _errorMessage = e.toString();
      });
    }
    return false;
  }

  Future<void> _handleAsyncButtonPress() async {
    if (emailFormKey.currentState!.validate()) {
      emailFormKey.currentState!.save();
      final email = _emailController.text;
      final emailExist = await checkEmailExist(email);
      if (!mounted) return;
      if (emailExist) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => OtpForgotPassword(
              email: email,
              accountInfo: accountInfo!,
            ),
          ),
        );
      }
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: Padding(
          padding: const EdgeInsets.only(top: 45, left: 16, right: 16),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(
              "Quên mật khẩu?",
              style: AppTextStyle.headlineSmall_24
                  .copyWith(fontWeight: FontWeight.w700),
            ),
            const SizedBox(
              height: 16,
            ),
            Text(
              "Đừng lo lắng, sử dụng email bạn đã đăng ký để bắt đầu cài đặt mật khẩu mới cho tài khoản nhé.",
              style: AppTextStyle.titleSmall_14
                  .copyWith(color: AppColors.neutral_02),
            ),
            const SizedBox(
              height: 36,
            ),
            Form(
              key: emailFormKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  TextFormField(
                    controller: _emailController,
                    decoration: const InputDecoration(
                      hintText: 'Email',
                      labelText: 'Email',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        refreshError();
                        return 'Vui lòng nhập email';
                      } else if (!isValidEmail(value)) {
                        refreshError();
                        return 'Email không đúng định dạng';
                      }
                      return null;
                    },
                    onSaved: (value) {},
                  ),
                  if (_errorMessage != null)
                    Padding(
                      padding: const EdgeInsets.only(top: 8, left: 16),
                      child: Text(
                        _errorMessage!,
                        style: AppTextStyle.bodySmall_12
                            .copyWith(color: AppColors.error_text),
                      ),
                    ),
                  const SizedBox(
                    height: 16,
                  ),
                  SizedBox(
                    height: 50,
                    width: double.infinity,
                    child: AsyncButton(
                      onPressed: _handleAsyncButtonPress,
                      child: Text(
                        'Tiếp tục',
                        style: AppTextStyle.bodyMedium_14.copyWith(
                            fontWeight: FontWeight.w700,
                            color: AppColors.neutral_07),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ]),
        ));
  }
}
