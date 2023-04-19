import 'package:dtnd/generated/l10n.dart';
import 'package:dtnd/ui/screen/forgot_password/screen/otp_forgot_password.dart';
import 'package:dtnd/ui/theme/app_color.dart';
import 'package:dtnd/ui/theme/app_textstyle.dart';
import 'package:flutter/material.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final emailFormKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();

  bool isValidEmail(String? email) {
    if (email == null) {
      return false;
    } else {
      return RegExp(
              r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
          .hasMatch(email);
    }
  }

  bool typingEmail = false;

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
                        return 'Vui lòng nhập email';
                      } else if (!isValidEmail(value)) {
                        return 'Email không đúng định dạng';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      // _name = value;
                    },
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  SizedBox(
                    height: 50,
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        if (emailFormKey.currentState!.validate()) {
                          emailFormKey.currentState!.save();
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => OtpForgotPassword(
                                email: _emailController.text,
                              ),
                            ),
                          );
                        }
                      },
                      child: const Text('Tiếp tục'),
                    ),
                  ),
                ],
              ),
            )
          ]),
        ));
  }
}
