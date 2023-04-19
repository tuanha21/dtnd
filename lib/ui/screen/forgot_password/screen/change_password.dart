import 'dart:async';
import 'package:dtnd/=models=/check_account_success_data_model.dart';
import 'package:dtnd/data/i_user_service.dart';
import 'package:dtnd/data/implementations/user_service.dart';
import 'package:dtnd/ui/theme/app_color.dart';
import 'package:dtnd/ui/theme/app_image.dart';
import 'package:dtnd/ui/theme/app_textstyle.dart';
import 'package:flutter/material.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({super.key, required this.accountInfo});
  final CheckAccountSuccessDataModel accountInfo;

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  final _formKey = GlobalKey<FormState>();
  final _passwordController = TextEditingController();
  final _rePasswordController = TextEditingController();
  bool isValid = true;
  bool condition1 = false;
  bool condition2 = false;
  bool condition3 = false;
  bool condition4 = false;
  bool _passwordVisible = false;
  bool _rePasswordVisible = false;

  Timer? _timer;

  void updateIsValid() {
    setState(() {
      isValid = condition1 && condition2 && condition3 && condition4;
    });
  }

  void _onPasswordTyping() {
    if (_timer != null) {
      _timer!.cancel();
    }
    _timer = Timer(const Duration(milliseconds: 50), () {
      setState(() {
        isValid = condition1 && condition2 && condition3 && condition4;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    _passwordController.addListener(_onPasswordTyping);
  }

  @override
  void dispose() {
    _passwordController.removeListener(_onPasswordTyping);
    super.dispose();
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
              "Đặt lại mật khẩu",
              style: AppTextStyle.headlineSmall_24
                  .copyWith(fontWeight: FontWeight.w700),
            ),
            const SizedBox(
              height: 16,
            ),
            Text(
              // S.of(context).title_change_password,
              'Để chúng tôi bảo vệ tài khoản và các thông tin quan trọng của bạn',
              style: AppTextStyle.titleSmall_14
                  .copyWith(color: AppColors.neutral_02),
            ),
            const SizedBox(height: 36),
            Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  TextFormField(
                    obscureText: _passwordVisible,
                    decoration: InputDecoration(
                      errorStyle: const TextStyle(height: 0),
                      labelText: 'Mật khẩu mới',
                      hintText: 'Mật khẩu mới',
                      suffixIcon: IconButton(
                        icon: Icon(
                          !_passwordVisible
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: AppColors.text_black_1,
                        ),
                        onPressed: () {
                          setState(() {
                            _passwordVisible = !_passwordVisible;
                          });
                        },
                      ),
                    ),
                    controller: _passwordController,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    onChanged: (value) => {},
                    validator: validatePassword,
                    onSaved: (value) {
                      // _name = value;
                    },
                  ),
                  !(isValid) ? _showCodition(context) : Container(),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    obscureText: _rePasswordVisible,
                    controller: _rePasswordController,
                    decoration: InputDecoration(
                      suffixIcon: IconButton(
                        icon: Icon(
                          !_rePasswordVisible
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: AppColors.text_black_1,
                        ),
                        onPressed: () {
                          setState(() {
                            _rePasswordVisible = !_rePasswordVisible;
                          });
                        },
                      ),
                      hintText: 'Nhập lại mật khẩu mới',
                      labelText: 'Nhập lại mật khẩu mới',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Vui lòng nhập lại mật khẩu mới';
                      } else if (value != _passwordController.text) {
                        return 'Mật khẩu nhập lại không trùng khớp';
                      }
                      return null;
                    },
                    onSaved: (value) {},
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  SizedBox(
                    height: 50,
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          _formKey.currentState!.save();
                          print('Change Successs!!');
                        }
                      },
                      child: const Text('Lưu mật khẩu'),
                    ),
                  ),
                ],
              ),
            )
          ]),
        ));
  }

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return '';
    }
    if (value.length < 8 || value.length > 16) {
      condition1 = false;
      return '';
    }
    condition1 = true;
    if (!value.contains(RegExp(r'[A-Z]'))) {
      condition2 = false;
      return '';
    }
    condition2 = true;
    if (!value.contains(RegExp(r'[0-9]'))) {
      condition3 = false;
      return '';
    }
    condition3 = true;
    if (!value.contains(RegExp(r'[!@#\$&*~]'))) {
      condition4 = false;
      return '';
    }
    condition4 = true;
    isValid = true;
    return null;
  }

  Widget getIcon(bool condition) {
    Widget child;
    if (condition) {
      child = Image.asset(
        AppImages.validate_check,
        height: 20,
        width: 20,
      );
    } else {
      child = Image.asset(
        AppImages.validate_fail,
        height: 20,
        width: 20,
      );
    }
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 10),
      child: child,
    );
  }

  Widget _showCodition(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 10),
        Row(
          children: [
            getIcon(condition1),
            Text(
              '8 -16 ký tự',
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium
                  ?.copyWith(color: AppColors.neutral_03),
            ),
          ],
        ),
        const SizedBox(height: 5),
        Row(
          children: [
            getIcon(condition2),
            Text(
              '1 chữ cái viết hoa',
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium
                  ?.copyWith(color: AppColors.neutral_03),
            ),
          ],
        ),
        const SizedBox(height: 5),
        Row(
          children: [
            getIcon(condition3),
            Text(
              '1 chữ số',
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium
                  ?.copyWith(color: AppColors.neutral_03),
            ),
          ],
        ),
        const SizedBox(height: 5),
        Row(
          children: [
            getIcon(condition4),
            Text('1 ký tự đặc biệt',
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium
                    ?.copyWith(color: AppColors.neutral_03)),
          ],
        ),
      ],
    );
  }
}
