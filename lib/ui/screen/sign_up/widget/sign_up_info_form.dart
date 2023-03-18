import 'package:dtnd/data/i_user_service.dart';
import 'package:dtnd/data/implementations/user_service.dart';
import 'package:dtnd/generated/l10n.dart';
import 'package:dtnd/ui/screen/sign_up/business/signup_info.dart';
import 'package:dtnd/ui/screen/sign_up/sign_up_logic.dart';
import 'package:dtnd/ui/theme/app_color.dart';
import 'package:dtnd/ui/widget/app_snack_bar.dart';
import 'package:dtnd/ui/widget/icon/check_box.dart';
import 'package:dtnd/ui/widget/input/app_text_field.dart';
import 'package:dtnd/utilities/validator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignUpInfoForm extends StatefulWidget {
  const SignUpInfoForm({super.key, required this.onSuccess});
  final Function onSuccess;
  @override
  State<SignUpInfoForm> createState() => _SignUpInfoFormState();
}

class _SignUpInfoFormState extends State<SignUpInfoForm> with AppValidator {
  final IUserService userService = UserService();
  final logic = Get.put(SignUpLogic());
  final state = Get.find<SignUpLogic>().state;
  final GlobalKey<FormState> signUpFormKey = GlobalKey<FormState>();

  final GlobalKey<FormFieldState<String?>> passwordFormKey =
      GlobalKey<FormFieldState<String?>>();

  bool isAgree = false;

  bool showPass = false;

  bool showRepass = false;

  @override
  Widget build(BuildContext context) {
    var titleSmall = Theme.of(context).textTheme.titleSmall;
    return Form(
      key: signUpFormKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppTextField(
            labelText: S.of(context).full_name,
            controller: state.fullName,
            hintText: "Họ và tên",
            validator: (name) {
              return checkFullName(name);
            },
            onChanged: (name) {
              state.keyName.currentState?.validate();
            },
          ),
          const SizedBox(height: 16),
          // AppTextField(
          //   labelText: S.of(context).account,
          //   controller: state.account,
          //   onChanged: (account) {
          //     isLess6Length.value = checkAccountShort(account) == null;
          //     isSpecialCharacter.value =
          //         checkAccountNotMatchSpecial(account) == null;
          //     validateAccount.value =
          //         isLess6Length.value && isSpecialCharacter.value;
          //   },
          // ),
          // ValueListenableBuilder(
          //   valueListenable: validateAccount,
          //   builder: (BuildContext context, bool state, Widget? child) {
          //     return Visibility(
          //         visible: !state,
          //         child: Column(
          //           children: [
          //             const SizedBox(height: 16),
          //             StateValidator(
          //                 state: isLess6Length, title: 'Ít nhất 6 ký tự'),
          //             const SizedBox(height: 16),
          //             StateValidator(
          //                 state: isSpecialCharacter,
          //                 title: 'Không bao gồm các ký tự đặc biệt'),
          //           ],
          //         ));
          //   },
          // ),
          // const SizedBox(height: 16),
          AppTextField(
            labelText: S.of(context).phone_number,
            controller: state.phoneNumber,
            hintText: "Số điện thoại",
            validator: (name) {
              return checkFullName(name);
            },
            onChanged: (name) {
              state.keyName.currentState?.validate();
            },
          ),
          const SizedBox(height: 16),
          // InternationalPhoneNumberInput(
          //   onInputChanged: (PhoneNumber number) {
          //     if (kDebugMode) {
          //       print(number.phoneNumber);
          //     }
          //   },
          //   onInputValidated: (bool value) {
          //     if (kDebugMode) {
          //       print(value);
          //     }
          //   },
          //   errorMessage: 'Số điện thoại chưa đúng',
          //   selectorConfig: const SelectorConfig(
          //       selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
          //       setSelectorButtonAsPrefixIcon: true,
          //       leadingPadding: 20,
          //       trailingSpace: false),
          //   inputDecoration:
          //       InputDecoration(labelText: S.of(context).phone_number),
          //   ignoreBlank: true,
          //   textStyle: titleSmall,
          //   autoValidateMode: AutovalidateMode.onUserInteraction,
          //   selectorTextStyle: titleSmall,
          //   initialValue: PhoneNumber(dialCode: "+84", isoCode: "VN"),
          //   textFieldController: state.phoneNumber,
          //   formatInput: true,
          //   keyboardType: const TextInputType.numberWithOptions(
          //       signed: true, decimal: true),
          //   inputBorder: const OutlineInputBorder(),
          // ),
          // const SizedBox(height: 16),
          AppTextField(
            labelText: S.of(context).email,
            controller: state.email,
            hintText: "example@gmail.com",
            validator: (email) {
              return checkEmail(email);
            },
            onChanged: (email) {
              state.keyEmail.currentState?.validate();
            },
          ),
          const SizedBox(height: 16),
          FormField<String?>(
            key: passwordFormKey,
            validator: passwordValidator,
            builder: (passwordState) => TextField(
              obscureText: !showPass,
              autocorrect: false,
              // focusNode: passwordFocusNode,
              // controller: _passController,
              onChanged: (value) {
                passwordState.didChange(value);
                // _onPasswordChangeHandler(passwordState, value);
              },
              decoration: InputDecoration(
                labelText: S.of(context).password,
                hintText: S.of(context).password,
                errorText:
                    passwordState.hasError ? passwordState.errorText : null,
                suffixIcon: GestureDetector(
                  onTap: () {
                    setState(() {
                      showPass = !showPass;
                    });
                  },
                  child: Icon(showPass
                      ? Icons.visibility_outlined
                      : Icons.visibility_off_outlined),
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),
          FormField<String?>(
            // key: passwordFormKey,
            validator: (repass) =>
                checkConfirmPass(repass, passwordFormKey.currentState?.value),
            builder: (repasswordState) => TextField(
              obscureText: !showRepass,
              autocorrect: false,
              // focusNode: passwordFocusNode,
              // controller: _passController,
              onChanged: (value) {
                repasswordState.didChange(value);
                // _onPasswordChangeHandler(passwordState, value);
              },
              decoration: InputDecoration(
                labelText: "Nhập lại mật khẩu",
                hintText: "Nhập lại mật khẩu",
                errorText:
                    repasswordState.hasError ? repasswordState.errorText : null,
                suffixIcon: GestureDetector(
                  onTap: () {
                    setState(() {
                      showPass = !showPass;
                    });
                  },
                  child: Icon(showPass
                      ? Icons.visibility_outlined
                      : Icons.visibility_off_outlined),
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),
          FormField<bool?>(
              initialValue: false,
              validator: (value) {
                if (!(value ?? false)) {
                  AppSnackBar.showInfo(context,
                      message: "Bạn chưa đồng ý điều khoản");
                  return "Bạn chưa đồng ý điều khoản";
                }
                return null;
              },
              builder: (licensceState) {
                return Row(
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
                );
              }),
          const SizedBox(height: 36),
          SizedBox(
              width: MediaQuery.of(context).size.width,
              child: ElevatedButton(
                  onPressed: () async {
                    FocusManager.instance.primaryFocus?.unfocus();

                    if (signUpFormKey.currentState?.validate() ?? false) {
                      try {
                        await userService.verifyRegisterInfo(
                            state.phoneNumber.text, state.email.text);
                      } catch (e) {
                        return AppSnackBar.showInfo(context,
                            message: e.toString());
                      }
                      return widget.onSuccess.call(
                          info: SignUpInfo(state.fullName.text,
                              state.phoneNumber.text, state.email.text, ""));
                    }
                    return;
                  },
                  child: Text(S.of(context).sign_up))),
        ],
      ),
    );
  }

  @override
  void dispose() {
    Get.delete<SignUpLogic>();
    super.dispose();
  }
}
