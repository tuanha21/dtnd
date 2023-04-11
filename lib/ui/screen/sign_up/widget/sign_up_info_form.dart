import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:dtnd/data/i_user_service.dart';
import 'package:dtnd/data/implementations/user_service.dart';
import 'package:dtnd/generated/l10n.dart';
import 'package:dtnd/ui/screen/sign_up/business/signup_info.dart';
import 'package:dtnd/ui/theme/app_color.dart';
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

  bool isAgree = false;

  bool showPass = false;

  bool showRepass = false;

  bool registering = false;

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
          SizedBox(
            height: 75,
            child: AppTextFormField(
              formKey: passwordFormKey,
              obscureText: true,
              labelText: S.of(context).password,
              hintText: S.of(context).password,
              validator: passwordValidator,
            ),
          ),
          const SizedBox(height: 5),
          SizedBox(
            height: 75,
            child: AppTextFormField(
              obscureText: true,
              labelText: "Nhập lại mật khẩu",
              hintText: "Nhập lại mật khẩu",
              validator: (repass) =>
                  checkConfirmRePass(repass, passwordFormKey.currentState?.value),
            ),
          ),
          const SizedBox(height: 5),
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
                  final List<int> bytes =
                      utf8.encode(passwordFormKey.currentState?.value ?? "");

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

  // @override
  // void dispose() {
  //   // Get.delete<SignUpLogic>();
  //   super.dispose();
  // }
}
