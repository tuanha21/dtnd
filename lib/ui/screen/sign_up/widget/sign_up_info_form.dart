import 'dart:async';
import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:dtnd/data/i_user_service.dart';
import 'package:dtnd/data/implementations/user_service.dart';
import 'package:dtnd/l10n/generated/l10n.dart';
import 'package:dtnd/ui/screen/sign_up/business/signup_info.dart';
import 'package:dtnd/ui/theme/app_color.dart';
import 'package:dtnd/ui/theme/app_image.dart';
import 'package:dtnd/ui/theme/app_textstyle.dart';
import 'package:dtnd/ui/widget/app_snack_bar.dart';
import 'package:dtnd/ui/widget/button/async_button.dart';
import 'package:dtnd/ui/widget/expanded_widget.dart';
import 'package:dtnd/ui/widget/icon/check_box.dart';
import 'package:dtnd/ui/widget/input/app_text_form_field.dart';
import 'package:dtnd/utilities/validator.dart';
import 'package:flutter/material.dart';

class SignUpInfoForm extends StatefulWidget {
  const SignUpInfoForm(
      {super.key, required this.onSuccess, required this.verifyRegisterInfo});
  final Function onSuccess;
  final Future<bool> Function(String, String) verifyRegisterInfo;
  @override
  State<SignUpInfoForm> createState() => _SignUpInfoFormState();
}

class _SignUpInfoFormState extends State<SignUpInfoForm> with AppValidator {
  final IUserService userService = UserService();
  // final logic = Get.put(SignUpLogic());
  // final state = Get.find<SignUpLogic>().state;
  final GlobalKey<FormState> signUpFormKey = GlobalKey<FormState>();

  final GlobalKey<FormFieldState<String?>> passwordFormKey =
      GlobalKey<FormFieldState<String?>>();

  final fullName = TextEditingController();
  final phoneNumber = TextEditingController();
  final email = TextEditingController();
  final idPresenter = TextEditingController();
  final _passwordController = TextEditingController();
  final _rePasswordController = TextEditingController();
  bool isValid = true;
  bool condition1 = false; //condtion length password
  bool condition2 = false; // condition 1 letter uppercase
  bool condition3 = false; // condition 1 number
  bool condition4 = false; // condition special character
  bool _passwordVisible = false;
  bool _rePasswordVisible = false;

  Timer? _timer;

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

  bool registering = false;

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
    var titleSmall = Theme.of(context).textTheme.titleSmall;
    return Form(
      key: signUpFormKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 75,
            child: AppTextFormField(
              labelText: S.of(context).full_name,
              controller: fullName,
              hintText: "Họ và tên",
              validator: checkFullName,
            ),
          ),
          const SizedBox(height: 5),
          SizedBox(
            height: 75,
            child: AppTextFormField(
              labelText: S.of(context).phone_number,
              controller: phoneNumber,
              hintText: "Số điện thoại",
              validator: phoneNumberValidator,
            ),
          ),
          const SizedBox(height: 5),
          SizedBox(
            height: 75,
            child: AppTextFormField(
              labelText: S.of(context).email,
              controller: email,
              hintText: "example@gmail.com",
              validator: checkEmail,
            ),
          ),
          const SizedBox(height: 5),
          TextFormField(
            obscureText: _passwordVisible,
            decoration: InputDecoration(
              errorStyle: const TextStyle(height: 0),
              labelText: S.of(context).hint_password,
              hintText: S.of(context).hint_password,
              suffixIcon: IconButton(
                icon: Icon(
                  !_passwordVisible ? Icons.visibility : Icons.visibility_off,
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
            validator: validatePassword,
            onSaved: (value) {
              // _name = value;
            },
          ),
          !(isValid) ? _showCodition(context) : Container(),
          const SizedBox(
            height: 25,
          ),
          TextFormField(
            obscureText: _rePasswordVisible,
            controller: _rePasswordController,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            decoration: InputDecoration(
              suffixIcon: IconButton(
                icon: Icon(
                  !_rePasswordVisible ? Icons.visibility : Icons.visibility_off,
                  color: AppColors.text_black_1,
                ),
                onPressed: () {
                  setState(() {
                    _rePasswordVisible = !_rePasswordVisible;
                  });
                },
              ),
              hintText: S.of(context).hint_re_password,
              labelText: S.of(context).hint_re_password,
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return S.of(context).validate_null_repassword;
              } else if (value != _passwordController.text) {
                return S.of(context).validate_same_repassword;
              }
              return null;
            },
            onSaved: (value) {},
          ),
          // SizedBox(
          //   height: 75,
          //   child: AppTextFormField(
          //     formKey: passwordFormKey,
          //     obscureText: true,
          //     labelText: S.of(context).password,
          //     hintText: S.of(context).password,
          //     validator: passwordValidator,
          //   ),
          // ),
          // const SizedBox(height: 5),
          // SizedBox(
          //   height: 75,
          //   child: AppTextFormField(
          //     obscureText: true,
          //     labelText: "Nhập lại mật khẩu",
          //     hintText: "Nhập lại mật khẩu",
          //     validator: (repass) =>
          //         checkConfirmRePass(repass, passwordFormKey.currentState?.value),
          //   ),
          // ),
          const SizedBox(height: 25),
          SizedBox(
            height: 75,
            child: AppTextFormField(
              labelText: 'ID người giới thiệu',
              controller: idPresenter,
              hintText: "Nhập ID người giới thiệu",
            ),
          ),
          const SizedBox(height: 5),
          FormField<bool?>(
              initialValue: false,
              validator: (value) {
                if (!(value ?? false)) {
                  // AppSnackBar.showInfo(context,
                  //     message: "Bạn chưa đồng ý điều khoản");
                  return "Bạn chưa đồng ý điều khoản";
                }
                return null;
              },
              builder: (licensceState) {
                return Column(
                  children: [
                    Row(
                      children: [
                        AppCheckBox(
                          onChanged: (value) {
                            licensceState.didChange(value);
                          },
                        ),
                        const SizedBox(width: 10),
                        Flexible(
                          child: RichText(
                            text: TextSpan(children: [
                              TextSpan(
                                  text: 'Tôi đồng ý và chấp nhận toàn bộ',
                                  style: titleSmall?.copyWith(
                                      fontWeight: FontWeight.w500,
                                      color: AppColors.neutral_04)),
                              TextSpan(
                                  text:
                                      ' Các điều khoản và Điều kiện giao dịch chứng khoán',
                                  style: titleSmall?.copyWith(
                                      fontWeight: FontWeight.w500,
                                      color: AppColors.primary_01)),
                            ]),
                          ),
                        ),
                      ],
                    ),
                    ExpandedSection(
                        expand: licensceState.errorText != null,
                        child: Row(
                          children: [
                            Text(
                              licensceState.errorText ?? "",
                              style: AppTextStyle.bodyMedium_14
                                  .copyWith(color: Colors.red),
                            )
                          ],
                        ))
                  ],
                );
              }),
          const SizedBox(height: 36),
          SizedBox(
            width: MediaQuery.of(context).size.width,
            child: AsyncButton(
              onPressed: () async {
                FocusManager.instance.primaryFocus?.unfocus();
                if (registering) {
                  return;
                }
                registering = true;
                if (signUpFormKey.currentState?.validate() ?? false) {
                  try {
                    await widget.verifyRegisterInfo
                        .call(phoneNumber.text, email.text);
                  } catch (e) {
                    registering = false;
                    return AppSnackBar.showInfo(context, message: e.toString());
                  }

                  registering = false;
                  final List<int> bytes = utf8.encode(_passwordController.text);

                  // Generate the MD5 hash
                  final Digest digest = md5.convert(bytes);

                  // Convert the hash to a hex string
                  final encodedPass = digest.toString().toUpperCase();

                  return widget.onSuccess.call(
                    info: SignUpInfo(fullName.text, phoneNumber.text,
                        email.text, encodedPass),
                  );
                } else {
                  registering = false;
                }
                return;
              },
              child: Text(S.of(context).sign_up),
            ),
          ),
        ],
      ),
    );
  }

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      condition1 = false;
      condition2 = false;
      condition3 = false;
      condition4 = false;
      return '';
    }
    (value.length < 8 || value.length > 16)
        ? condition1 = false
        : condition1 = true;

    (!value.contains(RegExp(r'[A-Z]')))
        ? condition2 = false
        : condition2 = true;

    (!value.contains(RegExp(r'[0-9]')))
        ? condition3 = false
        : condition3 = true;

    (!value.contains(RegExp(r'[!@#\$&*~]')))
        ? condition4 = false
        : condition4 = true;

    if (condition1 && condition2 && condition3 && condition4) {
      return null;
    }
    return '';
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
              S.of(context).condition_password1,
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
              S.of(context).condition_password2,
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
              S.of(context).condition_password3,
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
            Text(S.of(context).condition_password4,
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium
                    ?.copyWith(color: AppColors.neutral_03)),
          ],
        ),
      ],
    );
  }

  // @override
  // void dispose() {
  //   // Get.delete<SignUpLogic>();
  //   super.dispose();
  // }
}
