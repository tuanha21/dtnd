import 'package:dtnd/=models=/sign_up_success_data_model.dart';
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

  Future<SignUpSuccessDataModel?> createAccount() {
    return userService.createAccount(
        info!.name, info!.phone, info!.email, info!.password);
  }

  Future<bool> verifyOTP(SignUpInfo info) {
    return userService.verifyRegisterInfo(info.name, info.email);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
          onPressed: () {
            if (controller.page == 0.0 || controller.page == 2.0) {
              return Navigator.of(context).pop();
            } else {
              controller.previousPage(
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.easeInCubic);
            }
            return;
          },
        ),
      ),
      body: PageView(
        controller: controller,
        physics: const NeverScrollableScrollPhysics(),
        children: <Widget>[
          SignUpInfoPage(
            onSuccess: onSuccess,
          ),
          FillOTPPage(
            onSuccess: onSuccess,
            verifyOTP: (otp) =>
                userService.verifyRegisterOTP(info!.phone, info!.email, otp),
            createAccount: createAccount,
          ),
          const SuccessSignUpPage(),
        ],
      ),
    );
  }
}
