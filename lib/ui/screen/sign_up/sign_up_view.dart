import 'package:dtnd/ui/theme/app_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

import '../../../generated/l10n.dart';
import '../../../utilities/validator.dart';
import '../../theme/app_color.dart';
import '../../widget/app_snack_bar.dart';
import '../../widget/icon/check_box.dart';
import '../../widget/input/app_text_field.dart';
import 'sign_up_logic.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

enum ValidatorState { none, success, failed }

class _SignUpPageState extends State<SignUpPage> with AppValidator {
  final logic = Get.put(SignUpLogic());
  final state = Get.find<SignUpLogic>().state;

  ValueNotifier<ValidatorState> isLess6Length =
      ValueNotifier<ValidatorState>(ValidatorState.none);

  ValueNotifier<ValidatorState> isSpecialCharacter =
      ValueNotifier<ValidatorState>(ValidatorState.none);

  ValueNotifier<bool> validateAccount = ValueNotifier<bool>(false);

  bool isAgree = false;

  @override
  Widget build(BuildContext context) {
    var headlineSmall = Theme.of(context).textTheme.headlineSmall;
    var titleSmall = Theme.of(context).textTheme.titleSmall;
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              S.of(context).hi_you,
              style: headlineSmall?.copyWith(fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 16),
            RichText(
              text: TextSpan(children: [
                TextSpan(
                    text:
                        'Cùng tham gia thị trường đầu tư đầy sôi động với ứng dụng',
                    style: titleSmall?.copyWith(
                        fontWeight: FontWeight.w500,
                        color: AppColors.neutral_04)),
                TextSpan(
                    text: ' DTND ',
                    style: titleSmall?.copyWith(
                        fontWeight: FontWeight.w700,
                        color: AppColors.primary_01)),
                TextSpan(
                    text: 'bạn nhé',
                    style: titleSmall?.copyWith(
                        fontWeight: FontWeight.w500,
                        color: AppColors.neutral_04))
              ]),
            ),
            const SizedBox(height: 36),
            Form(
              key: state.keyName,
              child: AppTextField(
                labelText: S.of(context).full_name,
                controller: state.fullName,
                validator: (name) {
                  return checkFullName(name);
                },
                onChanged: (name) {
                  state.keyName.currentState?.validate();
                },
              ),
            ),
            const SizedBox(height: 16),
            AppTextField(
              labelText: S.of(context).account,
              controller: state.account,
              onChanged: (account) {
                if (checkAccountShort(account) == null) {
                  isLess6Length.value = ValidatorState.success;
                } else {
                  isLess6Length.value = ValidatorState.failed;
                }
                if (checkAccountNotMatchSpecial(account) == null) {
                  isSpecialCharacter.value = ValidatorState.success;
                } else {
                  isSpecialCharacter.value = ValidatorState.failed;
                }
                validateAccount.value =
                    isSpecialCharacter.value == ValidatorState.success &&
                        isLess6Length.value == ValidatorState.success;
              },
            ),
            ValueListenableBuilder(
              valueListenable: validateAccount,
              builder: (BuildContext context, bool state, Widget? child) {
                return Visibility(
                    visible: !state,
                    child: Column(
                      children: [
                        const SizedBox(height: 16),
                        StateValidator(
                            state: isLess6Length, title: 'Ít nhất 6 ký tự'),
                        const SizedBox(height: 16),
                        StateValidator(
                            state: isSpecialCharacter,
                            title: 'Không bao gồm các ký tự đặc biệt'),
                      ],
                    ));
              },
            ),
            const SizedBox(height: 16),
            InternationalPhoneNumberInput(
              onInputChanged: (PhoneNumber number) {
                if (kDebugMode) {
                  print(number.phoneNumber);
                }
              },
              onInputValidated: (bool value) {
                if (kDebugMode) {
                  print(value);
                }
              },
              errorMessage: 'Số điện thoại chưa đúng',
              selectorConfig: const SelectorConfig(
                  selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
                  setSelectorButtonAsPrefixIcon: true,
                  leadingPadding: 20,
                  trailingSpace: false),
              inputDecoration:
                  InputDecoration(labelText: S.of(context).phone_number),
              ignoreBlank: true,
              textStyle: titleSmall,
              autoValidateMode: AutovalidateMode.onUserInteraction,
              selectorTextStyle: titleSmall,
              initialValue: PhoneNumber(dialCode: "+84", isoCode: "VN"),
              textFieldController: state.phoneNumber,
              formatInput: true,
              keyboardType: const TextInputType.numberWithOptions(
                  signed: true, decimal: true),
              inputBorder: const OutlineInputBorder(),
            ),
            const SizedBox(height: 16),
            Form(
              key: state.keyEmail,
              child: AppTextField(
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
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                AppCheckBox(
                  onChanged: (value) {
                    isAgree = value;
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
            const SizedBox(height: 36),
            SizedBox(
                width: MediaQuery.of(context).size.width,
                child: ElevatedButton(
                    onPressed: () {
                      if (state.keyName.currentState?.validate() == false) {
                        return;
                      }
                      if (state.keyEmail.currentState?.validate() == false) {
                        return;
                      }

                      if (!validateAccount.value) {
                        return;
                      }

                      if (!validateAccount.value) {
                        return;
                      }
                      if (!isAgree) {
                        AppSnackBar.showInfo(context,
                            message: "Bạn chưa đồng ý điều khoản");
                        return;
                      }
                    },
                    child: Text(S.of(context).sign_up))),
            const SizedBox(height: 50),
            Center(
              child: RichText(
                  text: TextSpan(children: [
                TextSpan(
                    text: 'Bạn đã có tài khoản? ',
                    style: titleSmall?.copyWith(
                        fontWeight: FontWeight.w500,
                        color: AppColors.neutral_04)),
                TextSpan(
                    text: S.of(context).login,
                    style: titleSmall?.copyWith(
                        fontWeight: FontWeight.w500,
                        color: AppColors.primary_01),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        GoRouter.of(context).pop();
                      })
              ])),
            )
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    Get.delete<SignUpLogic>();
    super.dispose();
  }
}

class StateValidator extends StatelessWidget {
  final ValueNotifier<ValidatorState> state;
  final String title;

  const StateValidator({Key? key, required this.state, required this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var bodySmall = Theme.of(context).textTheme.bodySmall;

    return ValueListenableBuilder<ValidatorState>(
        valueListenable: state,
        builder: (context, state, child) {
          return Row(
            children: [
              state.icon,
              const SizedBox(width: 10),
              Text(
                title,
                style: bodySmall?.copyWith(fontWeight: FontWeight.w500),
              )
            ],
          );
        });
  }
}

extension ValidatorStateExt on ValidatorState {
  Widget get icon {
    switch (this) {
      case ValidatorState.none:
        return SvgPicture.asset(AppImages.icon_error);
      case ValidatorState.success:
        return SvgPicture.asset(AppImages.icon_success);
      case ValidatorState.failed:
        return SvgPicture.asset(AppImages.icon_error);
    }
  }
}
