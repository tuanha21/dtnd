import 'package:dtnd/data/i_user_service.dart';
import 'package:dtnd/data/implementations/user_service.dart';
import 'package:dtnd/ui/screen/sign_up/business/signup_info.dart';
import 'package:dtnd/ui/screen/sign_up/page/fill_otp_page.dart';
import 'package:dtnd/ui/screen/sign_up/page/sign_up_info_page.dart';
import 'package:dtnd/ui/screen/sign_up/page/success_sign_up_page.dart';
import 'package:flutter/material.dart';

import '../../../utilities/validator.dart';

class SignUpView extends StatefulWidget {
  const SignUpView({super.key});

  @override
  State<SignUpView> createState() => _SignUpViewState();
}

// enum ValidatorState { none, success, failed }

class _SignUpViewState extends State<SignUpView> with AppValidator {
  final IUserService userService = UserService();
  final PageController controller = PageController(initialPage: 0);

  SignUpInfo? info;

  void onSuccess({SignUpInfo? info}) {
    if (info != null) {
      setState(() {
        this.info = info;
      });
    }
    controller.nextPage(
        duration: const Duration(milliseconds: 500), curve: Curves.easeInCubic);
  }

  // Future<bool> verifyOTP() async {
  //   return
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new_rounded),
          onPressed: () {
            controller.previousPage(
                duration: const Duration(milliseconds: 500),
                curve: Curves.easeInCubic);
          },
        ),
      ),
      body: PageView(
        controller: controller,
        children: <Widget>[
          SignUpInfoPage(
            onSuccess: onSuccess,
          ),
          FillOTPPage(
            onSuccess: onSuccess,
            verifyOTP: (otp) =>
                userService.verifyRegisterOTP(info!.phone!, info!.email!, otp),
          ),
          const SuccessSignUpPage(),
        ],
      ),
    );
  }

  // final logic = Get.put(SignUpLogic());
  // final state = Get.find<SignUpLogic>().state;

  // ValueNotifier<bool> isLess6Length = ValueNotifier<bool>(false);

  // ValueNotifier<bool> isSpecialCharacter = ValueNotifier<bool>(false);

  // ValueNotifier<bool> validateAccount = ValueNotifier<bool>(false);

  // bool isAgree = false;

  // @override
  // Widget build(BuildContext context) {
  //   var headlineSmall = Theme.of(context).textTheme.headlineSmall;
  //   var titleSmall = Theme.of(context).textTheme.titleSmall;
  //   return Scaffold(
  //     appBar: AppBar(),
  //     body: SingleChildScrollView(
  //       padding: const EdgeInsets.symmetric(horizontal: 16),
  //       child: Column(
  //         crossAxisAlignment: CrossAxisAlignment.start,
  //         children: [
  //           Text(
  //             S.of(context).hi_you,
  //             style: headlineSmall?.copyWith(fontWeight: FontWeight.w700),
  //           ),
  //           const SizedBox(height: 16),
  //           RichText(
  //             text: TextSpan(children: [
  //               TextSpan(
  //                   text:
  //                       'Cùng tham gia thị trường đầu tư đầy sôi động với ứng dụng',
  //                   style: titleSmall?.copyWith(
  //                       fontWeight: FontWeight.w500,
  //                       color: AppColors.neutral_04)),
  //               TextSpan(
  //                   text: ' DTND ',
  //                   style: titleSmall?.copyWith(
  //                       fontWeight: FontWeight.w700,
  //                       color: AppColors.primary_01)),
  //               TextSpan(
  //                   text: 'bạn nhé',
  //                   style: titleSmall?.copyWith(
  //                       fontWeight: FontWeight.w500,
  //                       color: AppColors.neutral_04))
  //             ]),
  //           ),
  //           const SizedBox(height: 36),
  //           Form(
  //             key: state.keyName,
  //             child: AppTextField(
  //               labelText: S.of(context).full_name,
  //               controller: state.fullName,
  //               validator: (name) {
  //                 return checkFullName(name);
  //               },
  //               onChanged: (name) {
  //                 state.keyName.currentState?.validate();
  //               },
  //             ),
  //           ),
  //           const SizedBox(height: 16),
  //           AppTextField(
  //             labelText: S.of(context).account,
  //             controller: state.account,
  //             onChanged: (account) {
  //               isLess6Length.value = checkAccountShort(account) == null;
  //               isSpecialCharacter.value =
  //                   checkAccountNotMatchSpecial(account) == null;
  //               validateAccount.value =
  //                   isLess6Length.value && isSpecialCharacter.value;
  //             },
  //           ),
  //           ValueListenableBuilder(
  //             valueListenable: validateAccount,
  //             builder: (BuildContext context, bool state, Widget? child) {
  //               return Visibility(
  //                   visible: !state,
  //                   child: Column(
  //                     children: [
  //                       const SizedBox(height: 16),
  //                       StateValidator(
  //                           state: isLess6Length, title: 'Ít nhất 6 ký tự'),
  //                       const SizedBox(height: 16),
  //                       StateValidator(
  //                           state: isSpecialCharacter,
  //                           title: 'Không bao gồm các ký tự đặc biệt'),
  //                     ],
  //                   ));
  //             },
  //           ),
  //           const SizedBox(height: 16),
  //           InternationalPhoneNumberInput(
  //             onInputChanged: (PhoneNumber number) {
  //               if (kDebugMode) {
  //                 print(number.phoneNumber);
  //               }
  //             },
  //             onInputValidated: (bool value) {
  //               if (kDebugMode) {
  //                 print(value);
  //               }
  //             },
  //             errorMessage: 'Số điện thoại chưa đúng',
  //             selectorConfig: const SelectorConfig(
  //                 selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
  //                 setSelectorButtonAsPrefixIcon: true,
  //                 leadingPadding: 20,
  //                 trailingSpace: false),
  //             inputDecoration:
  //                 InputDecoration(labelText: S.of(context).phone_number),
  //             ignoreBlank: true,
  //             textStyle: titleSmall,
  //             autoValidateMode: AutovalidateMode.onUserInteraction,
  //             selectorTextStyle: titleSmall,
  //             initialValue: PhoneNumber(dialCode: "+84", isoCode: "VN"),
  //             textFieldController: state.phoneNumber,
  //             formatInput: true,
  //             keyboardType: const TextInputType.numberWithOptions(
  //                 signed: true, decimal: true),
  //             inputBorder: const OutlineInputBorder(),
  //           ),
  //           const SizedBox(height: 16),
  //           Form(
  //             key: state.keyEmail,
  //             child: AppTextField(
  //               labelText: S.of(context).email,
  //               controller: state.email,
  //               hintText: "example@gmail.com",
  //               validator: (email) {
  //                 return checkEmail(email);
  //               },
  //               onChanged: (email) {
  //                 state.keyEmail.currentState?.validate();
  //               },
  //             ),
  //           ),
  //           const SizedBox(height: 16),
  //           Row(
  //             children: [
  //               AppCheckBox(
  //                 onChanged: (value) {
  //                   isAgree = value;
  //                 },
  //               ),
  //               const SizedBox(width: 10),
  //               Flexible(
  //                 child: RichText(
  //                   text: TextSpan(children: [
  //                     TextSpan(
  //                         text: 'Tôi đồng ý và chấp nhận toàn bộ',
  //                         style: titleSmall?.copyWith(
  //                             fontWeight: FontWeight.w500,
  //                             color: AppColors.neutral_04)),
  //                     TextSpan(
  //                         text:
  //                             ' Các điều khoản và Điều kiện giao dịch chứng khoán',
  //                         style: titleSmall?.copyWith(
  //                             fontWeight: FontWeight.w500,
  //                             color: AppColors.primary_01)),
  //                   ]),
  //                 ),
  //               ),
  //             ],
  //           ),
  //           const SizedBox(height: 36),
  //           SizedBox(
  //               width: MediaQuery.of(context).size.width,
  //               child: ElevatedButton(
  //                   onPressed: () {
  //                     if (state.keyName.currentState?.validate() == false) {
  //                       return;
  //                     }
  //                     if (state.keyEmail.currentState?.validate() == false) {
  //                       return;
  //                     }

  //                     if (!validateAccount.value) {
  //                       return;
  //                     }

  //                     if (!validateAccount.value) {
  //                       return;
  //                     }
  //                     if (!isAgree) {
  //                       AppSnackBar.showInfo(context,
  //                           message: "Bạn chưa đồng ý điều khoản");
  //                       return;
  //                     }
  //                     context.pushNamed('otp',
  //                         params: {"phone": state.phoneNumber.text});
  //                   },
  //                   child: Text(S.of(context).sign_up))),
  //           const SizedBox(height: 50),
  //           Center(
  //             child: RichText(
  //                 text: TextSpan(children: [
  //               TextSpan(
  //                   text: 'Bạn đã có tài khoản? ',
  //                   style: titleSmall?.copyWith(
  //                       fontWeight: FontWeight.w500,
  //                       color: AppColors.neutral_04)),
  //               TextSpan(
  //                   text: S.of(context).login,
  //                   style: titleSmall?.copyWith(
  //                       fontWeight: FontWeight.w500,
  //                       color: AppColors.primary_01),
  //                   recognizer: TapGestureRecognizer()
  //                     ..onTap = () {
  //                       GoRouter.of(context).pop();
  //                     })
  //             ])),
  //           )
  //         ],
  //       ),
  //     ),
  //   );
  // }

  // @override
  // void dispose() {
  //   Get.delete<SignUpLogic>();
  //   super.dispose();
  // }
}
